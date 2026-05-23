--[[
	╔═══════════════════════════════════════════════════════════════════════════════════════════════╗
	║                   ASHEN RECKONING - WEAPON BALANCING                                         ║
	║              Cooldowns, balance tweaks, and economy settings                                 ║
	╚═══════════════════════════════════════════════════════════════════════════════════════════════╝
]]

local WeaponBalancing = {}

-- ====================
-- GLOBAL COOLDOWNS
-- ====================

WeaponBalancing.globalAttackCooldown = 0.5 -- Min time between attacks
WeaponBalancing.parrywindow = 0.3 -- 300ms to react
WeaponBalancing.rollInvincibilityFrames = 0.6 -- i-frames when rolling

-- ====================
-- STAMINA REGENERATION
-- ====================

WeaponBalancing.staminaRegenRate = 15 -- Per second when not moving
WeaponBalancing.staminaRegenWhileMoving = 8 -- Per second while sprinting
WeaponBalancing.staminaRegenWhileInCombat = 5 -- Per second during combat
WeaponBalancing.maxStaminaPerPlayer = 100

-- ====================
-- SPRINTING/PARKOUR
-- ====================

WeaponBalancing.sprintStaminaCost = 1 -- Per frame (60fps = 60 stamina/sec)
WeaponBalancing.sprintSpeedMultiplier = 1.5 -- 1.5x normal speed
WeaponBalancing.vaultStaminaCost = 25 -- One-time cost to vault over obstacle
WeaponBalancing.vaultHeight = 5 -- Studs to jump
WeaponBalancing.maxSprintDuration = 10 -- Seconds before stamina depletes

-- ====================
-- REVOLVER MECHANICS
-- ====================

WeaponBalancing.revolverShotCooldown = 0.5 -- 500ms between shots (prevents spam)
WeaponBalancing.revolverReloadTime = 2.0 -- Seconds to reload
WeaponBalancing.revolverMaxAmmo = 6
WeaponBalancing.revolverDamagePerShot = 15
WeaponBalancing.revolverAimedShotDamage = 25
WeaponBalancing.revolverRangeDistance = 100 -- Studs

-- ====================
-- MYTHIC WEAPON BALANCE
-- ====================

-- River of Blood (Bleed weapon)
WeaponBalancing.riverOfBloodBleedBuildupLight = 25
WeaponBalancing.riverOfBloodBleedBuildupHeavy = 40
WeaponBalancing.riverOfBloodBleedThreshold = 100 -- Buildup needed to proc bleed
WeaponBalancing.riverOfBloodBleedDamage = 40 -- Damage when bleed procs
WeaponBalancing.riverOfBloodBleedDuration = 10 -- Seconds
WeaponBalancing.riverOfBloodBleedTickRate = 1 -- Damage per second

-- Mortal Blade (Dark Taint weapon)
WeaponBalancing.mortalBladeDarkTaintLight = 20
WeaponBalancing.mortalBladeDarkTaintHeavy = 35
WeaponBalancing.mortalBladeDarkTaintThreshold = 80 -- Buildup needed
WeaponBalancing.mortalBladeDarkTaintDuration = 8 -- Seconds
WeaponBalancing.mortalBladeDarkTaintDamageReduction = 0.8 -- Enemy takes 80% damage while affected

-- ====================
-- ENEMY SCALING
-- ====================

WeaponBalancing.enemyDamageMultiplier = 1.0 -- Base damage enemies do
WeaponBalancing.enemyHealthPerLevel = 20 -- +20 HP per level
WeaponBalancing.miniBossDamageMultiplier = 1.3 -- Mini-bosses do 30% more damage
WeaponBalancing.miniBossHealthMultiplier = 2.0 -- Mini-bosses have 2x health
WeaponBalancing.bossHealthMultiplier = 3.5 -- Bosses have 3.5x health
WeaponBalancing.bossDamageMultiplier = 1.5 -- Bosses do 50% more damage

-- ====================
-- DIFFICULTY ZONES
-- ====================

WeaponBalancing.biomeEnemyLevels = {
	["Affluent District"] = 1,  -- Easiest
	["Slums"] = 3,              -- Medium
	["Sewers"] = 4,             -- Hard (with gas mask requirement)
	["Ruined Bastion"] = 5,     -- Hardest
}

WeaponBalancing.biomeEnemyDamageMultipliers = {
	["Affluent District"] = 0.8,
	["Slums"] = 1.0,
	["Sewers"] = 1.2,
	["Ruined Bastion"] = 1.5,
}

-- ====================
-- GAS MASK MECHANICS
-- ====================

WeaponBalancing.gasMaskDuration = 300 -- 5 minutes
WeaponBalancing.sewerPassiveDamage = 3 -- Per second without gas mask
WeaponBalancing.sewerPassiveDamageWithMask = 0 -- No damage with mask
WeaponBalancing.sewerFogVisibility = 20 -- Reduced vision in sewers

-- ====================
-- HELPER FUNCTIONS
-- ====================

function WeaponBalancing:getEnemyStats(biome, enemyType, level)
	local baseHealth = 30
	local baseDamage = 5
	
	if enemyType == "MiniBoss" then
		baseHealth = baseHealth * self.miniBossHealthMultiplier
		baseDamage = baseDamage * self.miniBossDamageMultiplier
	elseif enemyType == "Boss" then
		baseHealth = baseHealth * self.bossHealthMultiplier
		baseDamage = baseDamage * self.bossDamageMultiplier
	end
	
	-- Scale by biome difficulty
	local biomeMultiplier = self.biomeEnemyDamageMultipliers[biome] or 1.0
	
	-- Scale by level
	baseHealth = baseHealth + (level * self.enemyHealthPerLevel)
	baseDamage = baseDamage * biomeMultiplier
	
	return {
		health = math.round(baseHealth),
		damage = math.round(baseDamage),
		level = level,
	}
end

return WeaponBalancing
