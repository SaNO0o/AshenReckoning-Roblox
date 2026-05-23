--[[
	╔═══════════════════════════════════════════════════════════════╗
	║          ASHEN RECKONING - REMOTES SETUP (PRIORITY 1)         ║
	║     This script MUST load first before any other scripts!      ║
	╚═══════════════════════════════════════════════════════════════╝
	
	This creates all RemoteEvents and RemoteFunctions used for
	server-to-client communication. Load this FIRST in ServerScriptService.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local serverScripts = ReplicatedStorage:FindFirstChild("ServerScripts")
local remotes = ReplicatedStorage:FindFirstChild("Remotes")

-- Create Remotes folder if it doesn't exist
if not remotes then
	remotes = Instance.new("Folder")
	remotes.Name = "Remotes"
	remotes.Parent = ReplicatedStorage
end

-- Function to create a RemoteEvent
local function createRemoteEvent(name)
	if not remotes:FindFirstChild(name) then
		local remote = Instance.new("RemoteEvent")
		remote.Name = name
		remote.Parent = remotes
		print("[REMOTES] Created RemoteEvent: " .. name)
	end
end

-- Function to create a RemoteFunction
local function createRemoteFunction(name)
	if not remotes:FindFirstChild(name) then
		local remote = Instance.new("RemoteFunction")
		remote.Name = name
		remote.Parent = remotes
		print("[REMOTES] Created RemoteFunction: " .. name)
	end
end

-- ====================
-- COMBAT REMOTES
-- ====================
creatRemoteEvent("PlayerAttack")         -- Client sends attack input
creatRemoteEvent("PlayerParry")          -- Client sends parry input
creatRemoteEvent("PlayerWeaponSwitch")   -- Client switches weapon
creatRemoteEvent("UpdateHealthBar")      -- Server updates client HUD
creatRemoteEvent("PlayAttackAnimation")  -- Server tells client to play animation
creatRemoteEvent("EnemyTakeDamage")      -- Client-to-server: enemy hit
creatRemoteEvent("BleedEffect")          -- Server triggers bleed visual
creatRemoteEvent("DarkSlashEffect")      -- Server triggers dark slash visual

-- ====================
-- MOVEMENT REMOTES
-- ====================
creatRemoteEvent("PlayerSprint")         -- Client sends sprint input
creatRemoteEvent("PlayerVault")          -- Client sends vault input
creatRemoteEvent("UpdateStaminaBar")     -- Server updates stamina HUD
creatRemoteEvent("DrainStamina")         -- Server drains stamina on client

-- ====================
-- GAMEPLAY REMOTES
-- ====================
creatRemoteEvent("PlayerDeath")          -- Server notifies client of death
creatRemoteEvent("PlayerRespawn")        -- Server triggers respawn
creatRemoteEvent("UpdateMenuUI")         -- Server updates menu state
creatRemoteEvent("TriggerDeathScreen")   -- Server triggers death screen
creatRemoteEvent("AcquireWeapon")        -- Server tells client they got a weapon
creatRemoteEvent("AcquireItem")          -- Server tells client they got an item
creatRemoteEvent("GaseMaskPickup")       -- Server tells client about gas mask

-- ====================
-- NPC/ENEMY REMOTES
-- ====================
creatRemoteEvent("EnemySpawned")         -- Server notifies spawning
creatRemoteEvent("EnemyDied")            -- Server notifies enemy death
creatRemoteEvent("BossHealthUpdate")     -- Server updates boss health for all players
creatRemoteEvent("BossPhaseChange")      -- Server triggers boss phase change

-- ====================
-- HUD/UI REMOTES
-- ====================
creatRemoteEvent("ShowNotification")     -- Server sends popup message
creatRemoteEvent("UpdateQuickSlots")     -- Server updates equipped weapons
creatRemoteEvent("ToggleUIVisibility")   -- Server controls UI visibility

-- ====================
-- COSMETIC REMOTES
-- ====================
creatRemoteEvent("UpdateShiftlockCursor") -- Server updates custom cursor position
creatRemoteEvent("TriggerScreenFlash")   -- Server triggers screen damage flash
creatRemoteEvent("PlaySFX")               -- Server plays sound effect

-- ====================
-- INITIALIZATION COMPLETE
-- ====================
print("\n[ASHEN RECKONING] Remotes setup complete!")
print("[ASHEN RECKONING] All RemoteEvents created in ReplicatedStorage.Remotes")
print("[ASHEN RECKONING] Ready for GameServer and WorldSetup to load.\n")
