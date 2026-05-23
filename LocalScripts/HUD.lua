--[[
	╔════════════════════════════════════════════════════════════════════════════════════════════════════════╗
	║                        ASHEN RECKONING - HUD (Kingdom Hearts Style)                                    ║
	║                    Health orbs, stamina bar, and player status display                                ║
	╚════════════════════════════════════════════════════════════════════════════════════════════════════════╝
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

-- ====================
-- CREATE MAIN SCREEN GUI
-- ====================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AshenReckoningHUD"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- ====================
-- HIDE DEFAULT ROBLOX HEALTH BAR
-- ====================

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Roblox default health GUI is in PlayerGui
local healthGui = playerGui:FindFirstChild("HealthGui")
if healthGui then
	healthGui:Destroy()
end

-- ====================
-- KINGDOM HEARTS HEALTH ORBS
-- ====================

local function createHealthOrbs(maxHealth)
	local orbsContainer = Instance.new("Frame")
	orbsContainer.Name = "HealthOrbs"
	orbsContainer.Size = UDim2.new(0, 300, 0, 50)
	orbsContainer.Position = UDim2.new(0, 20, 0, 20)
	orbsContainer.BackgroundTransparency = 1
	orbsContainer.Parent = screenGui
	
	-- Create 5 health orbs (each represents 20 HP in a 100 HP system)
	local orbCount = math.ceil(maxHealth / 20)
	local orbSize = 40
	local spacing = 10
	
	for i = 1, orbCount do
		local orb = Instance.new("Frame")
		orb.Name = "HealthOrb_" .. i
		orb.Size = UDim2.new(0, orbSize, 0, orbSize)
		orb.Position = UDim2.new(0, (i - 1) * (orbSize + spacing), 0, 0)
		orb.BackgroundColor3 = Color3.fromRGB(220, 50, 50) -- Red
		orb.BackgroundTransparency = 0.2
		orb.BorderColor3 = Color3.fromRGB(180, 0, 0)
		orb.BorderSizePixel = 2
		orb.Parent = orbsContainer
		
		-- Make it circular with corner radius
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 20)
		corner.Parent = orb
		
		-- Add inner glow effect
		local innerGlow = Instance.new("Frame")
		innerGlow.Name = "InnerGlow"
		innerGlow.Size = UDim2.new(1, -4, 1, -4)
		innerGlow.Position = UDim2.new(0, 2, 0, 2)
		innerGlow.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
		innerGlow.BackgroundTransparency = 0.3
		innerGlow.BorderSizePixel = 0
		innerGlow.Parent = orb
		
		local innerCorner = Instance.new("UICorner")
		innerCorner.CornerRadius = UDim.new(0, 15)
		innerCorner.Parent = innerGlow
	end
	
	return orbsContainer
end

-- ====================
-- STAMINA BAR (Cyan)
-- ====================

local function createStaminaBar(maxStamina)
	local staminaContainer = Instance.new("Frame")
	staminaContainer.Name = "StaminaBar"
	staminaContainer.Size = UDim2.new(0, 200, 0, 20)
	staminaContainer.Position = UDim2.new(0, 20, 0, 85) -- Below health orbs
	staminaContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
	staminaContainer.BorderColor3 = Color3.fromRGB(0, 200, 255)
	staminaContainer.BorderSizePixel = 2
	staminaContainer.Parent = screenGui
	
	-- Stamina fill bar
	local staminaFill = Instance.new("Frame")
	staminaFill.Name = "StaminaFill"
	staminaFill.Size = UDim2.new(1, 0, 1, 0)
	staminaFill.Position = UDim2.new(0, 0, 0, 0)
	staminaFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255) -- Cyan
	staminaFill.BorderSizePixel = 0
	staminaFill.Parent = staminaContainer
	
	-- Stamina text label
	local staminaLabel = Instance.new("TextLabel")
	staminaLabel.Name = "StaminaLabel"
	staminaLabel.Size = UDim2.new(1, 0, 1, 0)
	staminaLabel.BackgroundTransparency = 1
	staminaLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	staminaLabel.TextSize = 14
	staminaLabel.Text = "STAMINA"
	staminaLabel.TextStrokeTransparency = 0.5
	staminaLabel.Parent = staminaContainer
	
	return staminaContainer, staminaFill, staminaLabel
end

-- ====================
-- WEAPON DISPLAY
-- ====================

local function createWeaponDisplay()
	local weaponFrame = Instance.new("TextLabel")
	weaponFrame.Name = "WeaponDisplay"
	weaponFrame.Size = UDim2.new(0, 150, 0, 30)
	weaponFrame.Position = UDim2.new(1, -170, 0, 20) -- Top right
	weaponFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
	weaponFrame.BorderColor3 = Color3.fromRGB(200, 150, 0) -- Gold border
	weaponFrame.BorderSizePixel = 2
	weaponFrame.TextColor3 = Color3.fromRGB(255, 255, 200)
	weaponFrame.TextSize = 18
	weaponFrame.Text = "Weapon: Fists"
	weaponFrame.TextStrokeTransparency = 0.5
	weaponFrame.Parent = screenGui
	
	return weaponFrame
end

-- ====================
-- INITIALIZE HUD
-- ====================

local healthOrbs = createHealthOrbs(100)
local staminaContainer, staminaFill, staminaLabel = createStaminaBar(100)
local weaponDisplay = createWeaponDisplay()

print("[HUD] Kingdom Hearts-style HUD created")

-- ====================
-- UPDATE FUNCTIONS
-- ====================

local function updateHealthOrbs(currentHealth, maxHealth)
	local healthPerOrb = maxHealth / 5
	local fullOrbs = math.floor(currentHealth / healthPerOrb)
	
	for i, orb in ipairs(healthOrbs:GetChildren()) do
		if i <= fullOrbs then
			orb.BackgroundColor3 = Color3.fromRGB(220, 50, 50) -- Red (full)
			orb.BackgroundTransparency = 0.2
		else
			orb.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Gray (empty)
			orb.BackgroundTransparency = 0.5
		end
	end
end

local function updateStaminaBar(currentStamina, maxStamina)
	local percentage = currentStamina / maxStamina
	staminaFill.Size = UDim2.new(percentage, 0, 1, 0)
	
	-- Change color based on stamina level
	if percentage > 0.5 then
		staminaFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255) -- Cyan (plenty)
	elseif percentage > 0.25 then
		staminaFill.BackgroundColor3 = Color3.fromRGB(255, 200, 0) -- Yellow (low)
	else
		staminaFill.BackgroundColor3 = Color3.fromRGB(255, 50, 50) -- Red (critical)
	end
end

local function updateWeaponDisplay(weaponName)
	weaponDisplay.Text = "Weapon: " .. weaponName
end

-- ====================
-- SERVER COMMUNICATION
-- ====================

-- Listen for health updates
Remotes:WaitForChild("UpdateHealthBar"):OnClientEvent:Connect(function(newHealth, maxHealth)
	updateHealthOrbs(newHealth, maxHealth)
	print("[HUD] Health: " .. newHealth .. "/" .. maxHealth)
end)

-- Listen for stamina updates
Remotes:WaitForChild("UpdateStaminaBar"):OnClientEvent:Connect(function(playerUserId, stamina, maxStamina)
	if playerUserId == player.UserId then
		updateStaminaBar(stamina, maxStamina)
	end
end)

-- Listen for weapon updates
Remotes:WaitForChild("UpdateQuickSlots"):OnClientEvent:Connect(function(weapon)
	updateWeaponDisplay(weapon)
end)

-- Initial update
updateHealthOrbs(100, 100)
updateStaminaBar(100, 100)

print("[ASHEN RECKONING] HUD initialized - Kingdom Hearts style health orbs active")
