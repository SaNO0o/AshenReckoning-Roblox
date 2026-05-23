--[[
	╔═══════════════════════════════════════════════════════════════════════════════════════════════╗
	║                    ASHEN RECKONING - COMBAT MODULE                                           ║
	║          All weapon stats, movesets, and combat mechanics defined here                       ║
	╚═══════════════════════════════════════════════════════════════════════════════════════════════╝
]]

local CombatModule = {}

-- ====================
-- WEAPON DEFINITIONS
-- ====================

CombatModule.weapons = {
	-- FISTS: Balanced, fast, low stamina cost
	Fists = {
		displayName = "Fists",
		description = "The primordial weapon. Fast combos, low damage, minimal stamina cost.",
		dmgMultiplier = 1.0,
		staminaCostLight = 10,
		staminaCostHeavy = 20,
		staminaCostCombo = 15,
		comboSpeed = 0.6, -- Fast
		range = 3, -- Short range
		weightClass = "Light",
		movesets = {
			Light = {
				name = "Jab",
				damage = 8,
				animLength = 0.4,
			},
			Heavy = {
				name = "Uppercut",
				damage = 15,
				animLength = 0.8,
			},
			Combo = {
				name = "Combo Rush",
				damage = 12,
				hits = 4,
				animLength = 2.0,
			},
		},
	},
	
	-- KATANA: Balanced, elegant, medium damage
	Katana = {
		displayName = "Katana",
		description = "The way of the warrior. Balanced damage and speed.",
		dmgMultiplier = 1.3,
		staminaCostLight = 12,
		staminaCostHeavy = 25,
		staminaCostCombo = 20,
		comboSpeed = 0.7,
		range = 5,
		weightClass = "Medium",
		movesets = {
			Light = {
				name = "Slash",
				damage = 12,
				animLength = 0.5,
			},
			Heavy = {
				name = "Overhead Strike",
				damage = 22,
				animLength = 1.0,
			},
			Combo = {
				name = "Iaijutsu",
				damage = 18,
				hits = 3,
				animLength = 1.8,
			},
		},
	},
	
	-- DAGGER: Fast, low damage, high mobility
	Dagger = {
		displayName = "Dagger",
		description = "Swift and cunning. Quick strikes, low stamina drain.",
		dmgMultiplier = 0.9,
		staminaCostLight = 8,
		staminaCostHeavy = 18,
		staminaCostCombo = 14,
		comboSpeed = 0.5, -- Very fast
		range = 2.5,
		weightClass = "Light",
		movesets = {
			Light = {
				name = "Quick Stab",
				damage = 7,
				animLength = 0.3,
			},
			Heavy = {
				name = "Backstab",
				damage = 18,
				animLength = 0.9,
			},
			Combo = {
				name = "Flurry",
				damage = 10,
				hits = 5,
				animLength = 1.5,
			},
		},
	},
	
	-- SCYTHE: Slow, high damage, large range
	Scythe = {
		displayName = "Scythe",
		description = "The reaper's tool. Slow but devastating sweeps.",
		dmgMultiplier = 1.5,
		staminaCostLight = 15,
		staminaCostHeavy = 30,
		staminaCostCombo = 25,
		comboSpeed = 0.9, -- Slow
		range = 7, -- Very long range
		weightClass = "Heavy",
		movesets = {
			Light = {
				name = "Horizontal Slash",
				damage = 16,
				animLength = 0.7,
			},
			Heavy = {
				name = "Death Reap",
				damage = 28,
				animLength = 1.3,
			},
			Combo = {
				name = "Spinning Sweep",
				damage = 20,
				hits = 2,
				animLength = 2.5,
			},
		},
	},
	
	-- REVOLVER: Ranged, cooldown-based, precision
	Revolver = {
		displayName = "Revolver",
		description = "Precision firearm. Limited ammo, high damage, ranged attack.",
		dmgMultiplier = 1.2,
		staminaCostLight = 0, -- Guns don't use stamina, they use ammo
		staminaCostHeavy = 0,
		staminaCostCombo = 0,
		comboSpeed = 1.2,
		range = 100, -- Very long range
		weightClass = "Medium",
		ammo = 6,
		reloadTime = 2.0,
		shotCooldown = 0.5, -- 0.5s between shots to prevent spam
		movesets = {
			Light = {
				name = "Quick Shot",
				damage = 15,
				animLength = 0.4,
			},
			Heavy = {
				name = "Aimed Shot",
				damage = 25,
				animLength = 0.8,
			},
			Combo = {
				name = "Fan the Hammer",
				damage = 12,
				hits = 3,
				animLength = 1.2,
			},
		},
	},
}

-- ====================
-- MYTHIC WEAPONS
-- ====================

CombatModule.mythicWeapons = {
	-- RIVER OF BLOOD: Elden Ring-inspired, applies Bleed buildup
	RiverOfBlood = {
		displayName = "River of Blood",
		description = "Cursed katana that bleeds the very essence. Red slash effects, applies Bleed status.",
		dmgMultiplier = 1.4,
		staminaCostLight = 14,
		staminaCostHeavy = 28,
		staminaCostCombo = 22,
		comboSpeed = 0.7,
		range = 5,
		weightClass = "Medium",
		specialEffect = "Bleed",
		bleedBuildupPerHit = 25,
		bleedThresholdToProc = 100,
		bleedDamageOnProc = 40,
		movesets = {
			Light = {
				name = "Crimson Slash",
				damage = 13,
				bleedBuildup = 25,
				animLength = 0.5,
			},
			Heavy = {
				name = "Bloodhound's Fang",
				damage = 24,
				bleedBuildup = 40,
				animLength = 1.0,
			},
			Combo = {
				name = "Bloodboon Ritual",
				damage = 20,
				hits = 3,
				bleedBuildup = 35,
				animLength = 2.2,
			},
		},
	},
	
	-- MORTAL BLADE: Sekiro-inspired, applies Dark Taint debuff
	MortalBlade = {
		displayName = "Mortal Blade",
		description = "Infused with pure darkness. Black/purple slash effects, applies Dark Taint debuff.",
		dmgMultiplier = 1.5,
		staminaCostLight = 16,
		staminaCostHeavy = 30,
		staminaCostCombo = 25,
		comboSpeed = 0.75,
		range = 5,
		weightClass = "Medium",
		specialEffect = "DarkTaint",
		darkTaintPerHit = 20,
		darkTaintThreshold = 80,
		darkTaintDebuffDuration = 8,
		darkTaintDamageReduction = 0.8, -- Enemy takes 80% damage while tainted
		movesets = {
			Light = {
				name = "Void Strike",
				damage = 15,
				darkTaint = 20,
				animLength = 0.5,
			},
			Heavy = {
				name = "Mortal Draw",
				damage = 28,
				darkTaint = 35,
				animLength = 1.1,
			},
			Combo = {
				name = "Darkness Ascendant",
				damage = 24,
				hits = 2,
				darkTaint = 30,
				animLength = 2.0,
			},
		},
	},
}

-- ====================
-- PARRY MECHANICS
-- ====================

CombatModule.parryWindow = 0.3 -- 300ms window to parry
CombatModule.parryStaminaCost = 20
CombatModule.parryDamageReduction = 0.5 -- 50% damage reduction on successful parry
CombatModule.parryCounterMultiplier = 1.5 -- Next attack after parry does 150% damage

-- ====================
-- STATUS EFFECTS
-- ====================

CombatModule.statusEffects = {
	Bleed = {
		name = "Bleed",
		duration = 10,
		damagePerSecond = 5,
		visualColor = Color3.fromRGB(200, 0, 0), -- Red
	},
	DarkTaint = {
		name = "Dark Taint",
		duration = 8,
		damageMultiplier = 0.8, -- Takes 80% damage (weakened)
		visualColor = Color3.fromRGB(80, 0, 80), -- Purple
	},
	Poison = {
		name = "Poison",
		duration = 12,
		damagePerSecond = 3,
		visualColor = Color3.fromRGB(0, 150, 0), -- Green
	},
}

-- ====================
-- COMBAT CALCULATIONS
-- ====================

function CombatModule:calculateDamage(baseWeapon, attackType, targetLevel, isCritical)
	local weaponData = self.weapons[baseWeapon] or self.mythicWeapons[baseWeapon]
	if not weaponData then return 0 end
	
	local baseDamage = weaponData.movesets[attackType].damage
	local finalDamage = baseDamage * weaponData.dmgMultiplier
	
	-- Critical hits do 1.5x damage
	if isCritical then
		finalDamage = finalDamage * 1.5
	end
	
	-- Scale with target level (harder enemies take less damage)
	finalDamage = finalDamage * (1 + (targetLevel * 0.05))
	
	return math.round(finalDamage)
end

function CombatModule:getWeaponStats(weaponName)
	return self.weapons[weaponName] or self.mythicWeapons[weaponName]
end

return CombatModule
