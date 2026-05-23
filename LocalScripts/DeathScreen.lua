--[[
	╔════════════════════════════════════════════════════════════════════════════════════════════════════════╗
	║                      ASHEN RECKONING - DEATH SCREEN                                                    ║
	║                  Cinematic "YOU DIED" screen with fade and respawn                                   ║
	╚════════════════════════════════════════════════════════════════════════════════════════════════════════╝
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local function showDeathScreen()
	-- Create death screen GUI
	local deathGui = Instance.new("ScreenGui")
	deathGui.Name = "DeathScreen"
	deathGui.ResetOnSpawn = false
	deathGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	deathGui.Parent = playerGui
	
	-- Black fade background
	local blackOverlay = Instance.new("Frame")
	blackOverlay.Name = "BlackOverlay"
	blackOverlay.Size = UDim2.new(1, 0, 1, 0)
	blackOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	blackOverlay.BackgroundTransparency = 0
	blackOverlay.BorderSizePixel = 0
	blackOverlay.Parent = deathGui
	
	-- YOU DIED text (large, center)
	local deathText = Instance.new("TextLabel")
	deathText.Name = "DeathText"
	deathText.Size = UDim2.new(1, 0, 0.4, 0)
	deathText.Position = UDim2.new(0, 0, 0.35, 0)
	deathText.BackgroundTransparency = 1
	deathText.Text = "Y O U   D I E D"
	deathText.TextColor3 = Color3.fromRGB(200, 0, 0)
	deathText.TextSize = 120
	deathText.Font = Enum.Font.GothamBold
	deathText.TextStrokeTransparency = 0.4
	deathText.TextStrokeColor3 = Color3.fromRGB(100, 0, 0)
	deathText.Parent = deathGui
	
	-- Respawn info text
	local respawnText = Instance.new("TextLabel")
	respawnText.Name = "RespawnText"
	respawnText.Size = UDim2.new(1, 0, 0.15, 0)
	respawnText.Position = UDim2.new(0, 0, 0.65, 0)
	respawnText.BackgroundTransparency = 1
	respawnText.Text = "Respawning in 5 seconds..."
	respawnText.TextColor3 = Color3.fromRGB(150, 150, 150)
	respawnText.TextSize = 32
	respawnText.TextStrokeTransparency = 0.7
	respawnText.Parent = deathGui
	
	-- Countdown
	for i = 5, 1, -1 do
		wait(1)
		respawnText.Text = "Respawning in " .. i - 1 .. " seconds..."
	end
	
	-- Request respawn from server
	Remotes:WaitForChild("PlayerRespawn"):FireServer()
	
	-- Fade out
	local animation = game:GetService("TweenService")
	local fadeTween = animation:Create(
		blackOverlay,
		TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{ BackgroundTransparency = 1 }
	)
	fadeTween:Play()
	
	wait(2)
	deathGui:Destroy()
end

-- Listen for death from server
Remotes:WaitForChild("TriggerDeathScreen"):OnClientEvent:Connect(function()
	print("[DEATH] Showing death screen")
	showDeathScreen()
end)

print("[ASHEN RECKONING] Death screen module loaded")
