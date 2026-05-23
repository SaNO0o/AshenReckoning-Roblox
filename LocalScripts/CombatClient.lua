--[[
	╔════════════════════════════════════════════════════════════════════════════════════════════════════════╗
	║                      ASHEN RECKONING - COMBAT CLIENT                                                    ║
	║            Handles player input, attacks, parry, movement, weapon switching, stamina                    ║
	╚════════════════════════════════════════════════════════════════════════════════════════════════════════╝
]]

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local CombatModule = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("CombatModule"))
local StaminaModule = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("StaminaModule"))

-- Player combat state
local combatState = {
	currentWeapon = "Fists",
	currentHealth = 100,
	maxHealth = 100,
	currentStamina = 100,
	maxStamina = 100,
	isSprinting = false,
	isAttacking = false,
	hasGasMask = false,
}

-- ====================
-- COMBAT INPUTS
-- ====================

-- Left Mouse Button = Light Attack
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		-- Light attack
		if combatState.currentStamina >= 10 then
			Remotes:WaitForChild("PlayerAttack"):FireServer(combatState.currentWeapon, "Light")
			combatState.isAttacking = true
			combatState.currentStamina = combatState.currentStamina - 10
			print("[COMBAT] Light Attack with " .. combatState.currentWeapon)
		end
	end
end)

-- Right Mouse Button = Heavy Attack
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		-- Heavy attack
		if combatState.currentStamina >= 25 then
			Remotes:WaitForChild("PlayerAttack"):FireServer(combatState.currentWeapon, "Heavy")
			combatState.isAttacking = true
			combatState.currentStamina = combatState.currentStamina - 25
			print("[COMBAT] Heavy Attack with " .. combatState.currentWeapon)
		end
	end
end)

-- E = Parry
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if input.KeyCode == Enum.KeyCode.E then
		if combatState.currentStamina >= 20 then
			Remotes:WaitForChild("PlayerParry"):FireServer()
			combatState.currentStamina = combatState.currentStamina - 20
			print("[PARRY] Attempted parry!")
		end
	end
end)

-- SHIFT = Sprint
local isSprintKeyDown = false
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if input.KeyCode == Enum.KeyCode.LeftShift then
		isSprintKeyDown = true
		combatState.isSprinting = true
		Remotes:WaitForChild("PlayerSprint"):FireServer(true)
		print("[MOVEMENT] Sprint started")
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		isSprintKeyDown = false
		combatState.isSprinting = false
		Remotes:WaitForChild("PlayerSprint"):FireServer(false)
		print("[MOVEMENT] Sprint ended")
	end
end)

-- SPACE = Vault/Roll
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if input.KeyCode == Enum.KeyCode.Space then
		if combatState.currentStamina >= 25 then
			Remotes:WaitForChild("PlayerVault"):FireServer()
			combatState.currentStamina = combatState.currentStamina - 25
			print("[MOVEMENT] Vault executed")
		end
	end
end)

-- ====================
-- WEAPON SWITCHING
-- ====================

-- Number keys 1-5 for weapon switching
local weaponKeys = {
	[Enum.KeyCode.One] = "Fists",
	[Enum.KeyCode.Two] = "Katana",
	[Enum.KeyCode.Three] = "Dagger",
	[Enum.KeyCode.Four] = "Scythe",
	[Enum.KeyCode.Five] = "Revolver",
}

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if weaponKeys[input.KeyCode] then
		local newWeapon = weaponKeys[input.KeyCode]
		Remotes:WaitForChild("PlayerWeaponSwitch"):FireServer(newWeapon)
		combatState.currentWeapon = newWeapon
		print("[WEAPON] Switched to " .. newWeapon)
	end
end)

-- ====================
-- STAMINA REGENERATION (CLIENT-SIDE PREDICTION)
-- ====================

RunService.Heartbeat:Connect(function()
	-- Regenerate stamina based on state
	if combatState.isSprinting then
		combatState.currentStamina = math.max(0, combatState.currentStamina - 0.4) -- 25 per sec
	elseif not combatState.isAttacking then
		combatState.currentStamina = math.min(100, combatState.currentStamina + 0.25) -- 15 per sec
	end
	
	-- Reset attack flag after short duration
	if combatState.isAttacking then
		wait(0.5)
		combatState.isAttacking = false
	end
end)

-- ====================
-- SERVER EVENT LISTENERS
-- ====================

-- Listen for health updates from server
Remotes:WaitForChild("UpdateHealthBar"):OnClientEvent:Connect(function(newHealth, maxHealth)
	combatState.currentHealth = newHealth
	combatState.maxHealth = maxHealth
	print("[HUD] Health updated: " .. newHealth .. "/" .. maxHealth)
end)

-- Listen for stamina updates from server
Remotes:WaitForChild("UpdateStaminaBar"):OnClientEvent:Connect(function(playerUserId, stamina, maxStamina)
	if playerUserId == player.UserId then
		combatState.currentStamina = stamina
		combatState.maxStamina = maxStamina
		print("[HUD] Stamina: " .. stamina .. "/" .. maxStamina)
	end
end)

-- Listen for weapon updates
Remotes:WaitForChild("UpdateQuickSlots"):OnClientEvent:Connect(function(weapon)
	combatState.currentWeapon = weapon
	print("[UI] Quick slots updated: " .. weapon)
end)

-- Listen for damage screen flash
Remotes:WaitForChild("TriggerScreenFlash"):OnClientEvent:Connect(function()
	print("[VFX] Screen flash triggered (take damage)")
	-- TODO: Add red screen flash effect
end)

-- Listen for death
Remotes:WaitForChild("PlayerDeath"):OnClientEvent:Connect(function()
	print("[GAMEPLAY] Player died - triggering death screen")
	Remotes:WaitForChild("TriggerDeathScreen"):FireServer()
end)

-- Listen for bleed effect
Remotes:WaitForChild("BleedEffect"):OnClientEvent:Connect(function(enemyName)
	print("[VFX] Bleed effect on " .. enemyName)
	-- TODO: Add red particle effect
end)

-- Listen for dark slash effect
Remotes:WaitForChild("DarkSlashEffect"):OnClientEvent:Connect(function(enemyName)
	print("[VFX] Dark slash on " .. enemyName)
	-- TODO: Add dark purple particle effect
end)

print("\n[ASHEN RECKONING] CombatClient loaded!")
print("[ASHEN RECKONING] Controls:")
print("  LMB = Light Attack")
print("  RMB = Heavy Attack")
print("  E = Parry")
print("  SHIFT = Sprint")
print("  SPACE = Vault/Roll")
print("  1-5 = Switch Weapons\n")
