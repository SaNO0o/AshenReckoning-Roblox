--[[
	╔════════════════════════════════════════════════════════════════════════════════════════════════════════╗
	║                       ASHEN RECKONING - MAIN MENU (Type//Soul Style)                                  ║
	║              Gothic, elegant menu with animated title and smooth transitions                         ║
	╚════════════════════════════════════════════════════════════════════════════════════════════════════════╝
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ====================
-- CREATE MENU GUI
-- ====================

local menuGui = Instance.new("ScreenGui")
menuGui.Name = "MainMenu"
menuGui.ResetOnSpawn = false
menuGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
menuGui.Parent = playerGui

-- ====================
-- BACKGROUND
-- ====================

local background = Instance.new("Frame")
background.Name = "Background"
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
background.BorderSizePixel = 0
background.Parent = menuGui

-- Gradient effect (dark to slightly lighter)
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 5, 15)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 15, 30)),
})
gradient.Rotation = 45
gradient.Parent = background

-- ====================
-- TITLE (Type//Soul Style)
-- ====================

local titleFrame = Instance.new("Frame")
titleFrame.Name = "TitleFrame"
titleFrame.Size = UDim2.new(0, 400, 0, 150)
titleFrame.Position = UDim2.new(0.5, -200, 0.25, -75)
titleFrame.BackgroundTransparency = 1
titleFrame.Parent = menuGui

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "ASHEN RECKONING"
title.TextColor3 = Color3.fromRGB(220, 200, 180) -- Gold/cream
title.TextSize = 80
title.Font = Enum.Font.GothamBold
title.TextStrokeTransparency = 0.3
title.TextStrokeColor3 = Color3.fromRGB(100, 80, 60)
title.Parent = titleFrame

-- Add decorative line below title
local decorLine = Instance.new("Frame")
decoLine.Name = "DecoLine"
decoLine.Size = UDim2.new(0, 350, 0, 2)
decoLine.Position = UDim2.new(0.5, -175, 1, 10)
decoLine.BackgroundColor3 = Color3.fromRGB(200, 150, 80)
decoLine.BorderSizePixel = 0
decoLine.Parent = titleFrame

-- ====================
-- MENU BUTTONS
-- ====================

local function createMenuButton(text, position, callback)
	local button = Instance.new("TextButton")
	button.Name = text .. "Button"
	button.Size = UDim2.new(0, 250, 0, 50)
	button.Position = position
	button.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
	button.BackgroundTransparency = 0.3
	button.BorderColor3 = Color3.fromRGB(150, 120, 80)
	button.BorderSizePixel = 2
	button.Text = text
	button.TextColor3 = Color3.fromRGB(200, 180, 150)
	button.TextSize = 24
	button.Font = Enum.Font.GothamMedium
	button.TextStrokeTransparency = 0.5
	button.Parent = menuGui
	
	-- Corner radius
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = button
	
	-- Hover effect
	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(60, 40, 80)
		button.BorderColor3 = Color3.fromRGB(255, 200, 100)
		button.TextColor3 = Color3.fromRGB(255, 255, 200)
	end)
	
	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
		button.BorderColor3 = Color3.fromRGB(150, 120, 80)
		button.TextColor3 = Color3.fromRGB(200, 180, 150)
	end)
	
	button.MouseButton1Click:Connect(callback)
	
	return button
end

-- Create buttons
local playButton = createMenuButton("PLAY", UDim2.new(0.5, -125, 0.5, -100), function()
	print("[MENU] Play clicked")
	menuGui:Destroy() -- Close menu
end)

local characterButton = createMenuButton("CHARACTER", UDim2.new(0.5, -125, 0.5, -30), function()
	print("[MENU] Character customization opened")
	-- TODO: Open character customization panel
end)

local combatButton = createMenuButton("COMBAT STYLES", UDim2.new(0.5, -125, 0.5, 40), function()
	print("[MENU] Combat styles opened")
	-- TODO: Open combat styles guide
end)

local controlsButton = createMenuButton("CONTROLS", UDim2.new(0.5, -125, 0.5, 110), function()
	print("[MENU] Controls info opened")
	-- TODO: Show controls reference
end)

local quitButton = createMenuButton("QUIT", UDim2.new(0.5, -125, 0.5, 180), function()
	print("[MENU] Quit game")
	players:LeaveGame()
end)

-- ====================
-- CONTROLS LEGEND (Bottom)
-- ====================

local controlsLegend = Instance.new("TextLabel")
controlsLegend.Name = "ControlsLegend"
controlsLegend.Size = UDim2.new(0, 500, 0, 120)
controlsLegend.Position = UDim2.new(0.5, -250, 1, -140)
controlsLegend.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
controlsLegend.BorderColor3 = Color3.fromRGB(100, 80, 120)
controlsLegend.BorderSizePixel = 1
controlsLegend.TextColor3 = Color3.fromRGB(150, 150, 150)
controlsLegend.TextSize = 16
controlsLegend.Text = "LMB: Light Attack | RMB: Heavy Attack | E: Parry | SHIFT: Sprint\nSPACE: Vault | 1-5: Switch Weapons | Esc: Menu"
controlsLegend.TextWrapped = true
controlsLegend.TextStrokeTransparency = 0.7
controlsLegend.Parent = menuGui

-- ====================
-- ANIMATION
-- ====================

-- Fade in title
local animation = game:GetService("TweenService")
local titleTween = animation:Create(
	title,
	TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	{ TextTransparency = 0 }
)
title.TextTransparency = 1
titleTween:Play()

print("[ASHEN RECKONING] Main Menu loaded - Type//Soul style")
print("[MENU] Awaiting player input...")
