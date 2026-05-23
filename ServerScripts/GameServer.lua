--[[
	╔═══════════════════════════════════════════════════════════════╗
	║               ASHEN RECKONING - GAME SERVER CORE               ║
	║         Handles all server-side combat, damage, and player      ║
	║                         management                              ║
	╚═══════════════════════════════════════════════════════════════╝
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Debris = game:GetService("Debris")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local CombatModule = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("CombatModule"))
local StaminaModule = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("StaminaModule"))
local WeaponBalancing = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("WeaponBalancing"))

-- Player data storage
local playerData = {}

-- ====================
-- PLAYER INITIALIZATION
-- ====================
local function initializePlayer(player)
	print("[SERVER] Initializing player: " .. player.Name)
	
	local humanoidRootPart
	local humanoid
	
	-- Wait for character to load
	local character = player.Character or player.CharacterAdded:Wait()
	humanoidRootPart = character:WaitForChild("HumanoidRootPart")
	humanoid = character:WaitForChild("Humanoid")
	
	-- Initialize player data
	playerData[player.UserId] = {
		player = player,
		character = character,
		humanoid = humanoid,
		humanoidRootPart = humanoidRootPart,
		currentWeapon = "Fists",
		currentHealth = 100,
		maxHealth = 100,
		currentStamina = 100,
		maxStamina = 100,
		isAlive = true,
		isAttacking = false,
		lastAttackTime = 0,
		hasGasMask = false,
		bleedStacks = 0,
		darkTaint = 0,
	}
	
	-- Set humanoid health to match our system
	humanoid.MaxHealth = 100
	humanoid.Health = 100
	
	-- Update client HUD on spawn
	Remotes:WaitForChild("UpdateHealthBar"):FireClient(player, 100, 100)
	Remotes:WaitForChild("UpdateStaminaBar"):FireClient(player, 100, 100)
	
	-- Monitor humanoid health (server authority)
	humanoid.Died:Connect(function()
		if playerData[player.UserId] then
			playerData[player.UserId].isAlive = false
			Remotes:WaitForChild("PlayerDeath"):FireClient(player)
			print("[SERVER] Player " .. player.Name .. " died")
		end
	end)
	
	print("[SERVER] " .. player.Name .. " initialized with 100 HP")
end

-- ====================
-- PLAYER JOIN/LEAVE
-- ====================
Players.PlayerAdded:Connect(function(player)
	initializePlayer(player)
end)

Players.PlayerRemoving:Connect(function(player)
	if playerData[player.UserId] then
		playerData[player.UserId] = nil
		print("[SERVER] Cleaned up data for " .. player.Name)
	end
end)

-- ====================
-- COMBAT SYSTEM
-- ====================

-- Listen for player attacks
Remotes:WaitForChild("PlayerAttack"):OnServerEvent:Connect(function(player, weapon, attackType)
	local data = playerData[player.UserId]
	if not data or not data.isAlive then return end
	
	local weaponStats = CombatModule.weapons[weapon]
	if not weaponStats then return end
	
	-- Check cooldown (prevent spam)
	local currentTime = tick()
	if currentTime - data.lastAttackTime < 0.5 then
		return -- Cooldown active
	end
	
	data.lastAttackTime = currentTime
	data.isAttacking = true
	
	-- Drain stamina based on weapon
	local staminaCost = weaponStats[attackType] and weaponStats[attackType].staminaCost or 15
	data.currentStamina = math.max(0, data.currentStamina - staminaCost)
	
	-- Update all clients
	Remotes:WaitForChild("UpdateStaminaBar"):FireAllClients(player.UserId, data.currentStamina, data.maxStamina)
	
	-- Tell all clients to play animation
	Remotes:WaitForChild("PlayAttackAnimation"):FireAllClients(player, weapon, attackType)
	
	-- Stamina regeneration (slow)
	game:GetService("RunService").Heartbeat:Connect(function()
		if data.isAlive and not data.isAttacking then
			data.currentStamina = math.min(data.maxStamina, data.currentStamina + 0.5)
		end
	end)
	
	print("[COMBAT] " .. player.Name .. " used " .. weapon .. " - " .. attackType .. " (Stamina: " .. data.currentStamina .. ")")
end)

-- Listen for parry attempts
Remotes:WaitForChild("PlayerParry"):OnServerEvent:Connect(function(player)
	local data = playerData[player.UserId]
	if not data or not data.isAlive then return end
	
	-- Parry uses 20 stamina
	if data.currentStamina < 20 then
		return -- Not enough stamina
	end
	
	data.currentStamina = data.currentStamina - 20
	Remotes:WaitForChild("UpdateStaminaBar"):FireAllClients(player.UserId, data.currentStamina, data.maxStamina)
	
	print("[PARRY] " .. player.Name .. " parried!")
end)

-- Listen for weapon switches
Remotes:WaitForChild("PlayerWeaponSwitch"):OnServerEvent:Connect(function(player, newWeapon)
	local data = playerData[player.UserId]
	if not data then return end
	
	if CombatModule.weapons[newWeapon] then
		data.currentWeapon = newWeapon
		Remotes:WaitForChild("UpdateQuickSlots"):FireClient(player, newWeapon)
		print("[WEAPON] " .. player.Name .. " switched to " .. newWeapon)
	end
end)

-- ====================
-- DAMAGE HANDLING
-- ====================

-- Listen for enemy hit reports from client
Remotes:WaitForChild("EnemyTakeDamage"):OnServerEvent:Connect(function(player, enemyName, damageAmount, weapon)
	local data = playerData[player.UserId]
	if not data then return end
	
	print("[DAMAGE] " .. player.Name .. " dealt " .. damageAmount .. " damage to " .. enemyName .. " with " .. weapon)
	
	-- Trigger visual effects on all clients
	if weapon == "River of Blood" then
		Remotes:WaitForChild("BleedEffect"):FireAllClients(enemyName)
		data.bleedStacks = (data.bleedStacks or 0) + 1
	elseif weapon == "Mortal Blade" then
		Remotes:WaitForChild("DarkSlashEffect"):FireAllClients(enemyName)
		data.darkTaint = (data.darkTaint or 0) + 1
	end
end)

-- ====================
-- PLAYER RESPAWN
-- ====================

local function respawnPlayer(player)
	local data = playerData[player.UserId]
	if not data then return end
	
	-- Reset health and stamina
	data.currentHealth = 100
	data.currentStamina = 100
	data.isAlive = true
	data.bleedStacks = 0
	data.darkTaint = 0
	
	-- Tell client to respawn
	Remotes:WaitForChild("PlayerRespawn"):FireClient(player)
	
	-- Update HUD
	Remotes:WaitForChild("UpdateHealthBar"):FireClient(player, 100, 100)
	Remotes:WaitForChild("UpdateStaminaBar"):FireClient(player, 100, 100)
	
	print("[SERVER] " .. player.Name .. " respawned")
end

-- Create a way for clients to request respawn (via death screen)
Remotes:WaitForChild("PlayerRespawn"):OnServerEvent:Connect(function(player)
	respawnPlayer(player)
end)

print("\n[ASHEN RECKONING] GameServer initialized!")
print("[ASHEN RECKONING] Listening for player events...\n")
