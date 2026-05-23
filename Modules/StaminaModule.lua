--[[
	╔═══════════════════════════════════════════════════════════════════════════════════════════════╗
	║                    ASHEN RECKONING - STAMINA MODULE                                          ║
	║            Handles stamina drain, regeneration, and movement costs                          ║
	╚═══════════════════════════════════════════════════════════════════════════════════════════════╝
]]

local StaminaModule = {}

-- ====================
-- STAMINA CONFIG
-- ====================

StaminaModule.maxStamina = 100
StaminaModule.currentStamina = 100

-- Regeneration rates (per second)
StaminaModule.regenRates = {
	Idle = 20,           -- Standing still
	Walking = 15,        -- Normal movement
	Sprinting = -25,     -- Draining while sprinting (negative = loss)
	InCombat = 5,        -- Reduced regen during combat
}

-- Action costs
StaminaModule.costs = {
	AttackLight = 10,
	AttackHeavy = 25,
	AttackCombo = 20,
	Parry = 20,
	Roll = 25,
	Vault = 25,
	SprintPerSecond = 25, -- Per second of sprinting
}

-- ====================
-- STAMINA FUNCTIONS
-- ====================

function StaminaModule:drainStamina(amount)
	self.currentStamina = math.max(0, self.currentStamina - amount)
	return self.currentStamina
end

function StaminaModule:regenerateStamina(amount)
	self.currentStamina = math.min(self.maxStamina, self.currentStamina + amount)
	return self.currentStamina
end

function StaminaModule:hasEnoughStamina(cost)
	return self.currentStamina >= cost
end

function StaminaModule:getStaminaPercentage()
	return (self.currentStamina / self.maxStamina) * 100
end

function StaminaModule:canSprint()
	return self.currentStamina > 0
end

function StaminaModule:canAttack(attackType)
	local cost = self.costs[attackType] or 10
	return self.currentStamina >= cost
end

function StaminaModule:canParry()
	return self.currentStamina >= self.costs.Parry
end

function StaminaModule:canVault()
	return self.currentStamina >= self.costs.Vault
end

function StaminaModule:reset()
	self.currentStamina = self.maxStamina
end

return StaminaModule
