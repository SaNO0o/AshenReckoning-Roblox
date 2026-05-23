--[[
	╔═══════════════════════════════════════════════════════════════════════════════════════════════╗
	║                      ASHEN RECKONING - NPC MODULE                                            ║
	║                All enemy types, AI behaviors, and spawning                                   ║
	╚═══════════════════════════════════════════════════════════════════════════════════════════════╝
]]

local NPCModule = {}

-- ====================
-- NORMAL ENEMIES
-- ====================

NPCModule.normalEnemies = {
	-- Enemy Type 1: Hollow Wretch (Weak, common)
	HollowWretch = {
		displayName = "Hollow Wretch",
		description = "A shambling corpse, once human. Weak and predictable.",
		baseHealth = 25,
		baseDamage = 3,
		level = 1,
		experience = 50,
		aggro\_range = 15,
		moveSpeed = 12,
		attackCooldown = 1.5,
		weapon = "Fists",
		behavior = "Wander + Aggro",
	},
	
	-- Enemy Type 2: Blood Knight (Medium, armored)
	BloodKnight = {
		displayName = "Blood Knight",
		description = "A corrupted warrior in tattered plate armor.",
		baseHealth = 45,
		baseDamage = 6,
		level = 2,
		experience = 100,
		aggro\_range = 20,
		moveSpeed = 14,
		attackCooldown = 1.2,
		weapon = "Katana",
		behavior = "Patrol + Aggro",
		armor = 0.85, -- Takes 15% less damage
	},
	
	-- Enemy Type 3: Cursed Priest (Magic user, ranged)
	CursedPriest = {
		displayName = "Cursed Priest",
		description = "A clergy member twisted by dark magic.",
		baseHealth = 35,
		baseDamage = 7,
		level = 2,
		experience = 120,
		aggro\_range = 25,
		moveSpeed = 13,
		attackCooldown = 1.8,
		weapon = "Revolver",
		behavior = "Ranged + Kite",
		magicResistance = 0.7,
	},
}

-- ====================
-- MINI-BOSSES
-- ====================

NPCModule.miniBosses = {
	-- Mini-Boss 1: Graveyard Guardian
	GraveyardGuardian = {
		displayName = "Graveyard Guardian",
		description = "An ancient sentinel guarding the graves. Slow but powerful.",
		baseHealth = 80,
		baseDamage = 10,
		level = 3,
		experience = 300,
		aggro\_range = 30,
		moveSpeed = 10,
		attackCooldown = 2.0,
		weapon = "Scythe",
		behavior = "Stationary Guardian",
		armor = 0.75,
		textureColor = "Grey",
	},
	
	-- Mini-Boss 2: Ruined King
	RuinedKing = {
		displayName = "Ruined King",
		description = "A once-mighty sovereign, now corrupted and broken.",
		baseHealth = 120,
		baseDamage = 12,
		level = 4,
		experience = 400,
		aggro\_range = 35,
		moveSpeed = 12,
		attackCooldown = 1.5,
		weapon = "Mortal Blade",
		behavior = "Mobile Boss",
		armor = 0.8,
		textureColor = "DarkPurple",
		phases = 2, -- Changes attack pattern at 50% health
	},
}

-- ====================
-- AI BEHAVIORS
-- ====================

NPCModule.aiStates = {
	Idle = "Standing still, waiting",
	Wandering = "Moving randomly in patrol area",
	Aggro = "Chasing player",
	Attacking = "Engaged in combat",
	Casting = "Using special attack",
	Dying = "Death animation playing",
}

-- ====================
-- ENEMY LOOT TABLES
-- ====================

NPCModule.lootTables = {
	HollowWretch = {
		{ item = "SoulsSmall", amount = 20, chance = 1.0 },
		{ item = "Herb", amount = 1, chance = 0.3 },
	},
	BloodKnight = {
		{ item = "SoulsMedium", amount = 50, chance = 1.0 },
		{ item = "KatanaBlade", amount = 1, chance = 0.2 },
	},
	CursedPriest = {
		{ item = "SoulsMedium", amount = 60, chance = 1.0 },
		{ item = "RuneStone", amount = 1, chance = 0.25 },
	},
	GraveyardGuardian = {
		{ item = "SoulsLarge", amount = 150, chance = 1.0 },
		{ item = "ScytheHandle", amount = 1, chance = 0.4 },
	},
	RuinedKing = {
		{ item = "SoulsLarge", amount = 300, chance = 1.0 },
		{ item = "MortalBlade", amount = 1, chance = 0.5 },
	},
}

-- ====================
-- HELPER FUNCTIONS
-- ====================

function NPCModule:getEnemyType(enemyName)
	return self.normalEnemies[enemyName] or self.miniBosses[enemyName]
end

function NPCModule:getLoot(enemyName)
	return self.lootTables[enemyName] or {}
end

function NPCModule:calculateEnemyHealth(enemyName, biomeLevel)
	local enemy = self:getEnemyType(enemyName)
	if not enemy then return 25 end
	
	local health = enemy.baseHealth
	health = health + (biomeLevel * 15) -- Scale with biome
	
	return math.round(health)
end

return NPCModule
