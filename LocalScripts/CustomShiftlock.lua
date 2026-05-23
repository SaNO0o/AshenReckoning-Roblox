--[[
	╔════════════════════════════════════════════════════════════════════════════════════════════════════════╗
	║                    ASHEN RECKONING - CUSTOM SHIFTLOCK (Y2K Star)                                      ║
	║                     Custom mouse cursor in Y2K star shape / aesthetic                                ║
	╚════════════════════════════════════════════════════════════════════════════════════════════════════════╝
]]

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- ====================
-- CUSTOM SHIFTLOCK STATE
-- ====================

local shiftlockEnabled = false
local mouseSensitivity = 0.005 -- Adjust for desired sensitivity
local rotationX = 0
local rotationY = 0

-- ====================
-- TOGGLE SHIFTLOCK (Middle Mouse Button)
-- ====================

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if input.UserInputType == Enum.UserInputType.MouseButton3 then -- Middle mouse
		shiftlockEnabled = not shiftlockEnabled
		if shiftlockEnabled then
			print("[SHIFTLOCK] Enabled")
			mouse.Icon = "rbxasset://textures/Cursors/MouseLockedCursor.png"
		else
			print("[SHIFTLOCK] Disabled")
			mouse.Icon = ""
		end
	end
end)

-- ====================
-- CUSTOM CAMERA CONTROL (When Shiftlock enabled)
-- ====================

RunService.RenderStepped:Connect(function()
	if shiftlockEnabled and character and humanoidRootPart then
		-- Get mouse position
		local mouseX = mouse.X
		local mouseY = mouse.Y
		
		-- Calculate rotation based on mouse movement
		rotationY = rotationY + (mouseX - mouse.X) * mouseSensitivity
		rotationX = rotationX + (mouseY - mouse.Y) * mouseSensitivity
		
		-- Clamp vertical rotation (prevent over-rotation)
		rotationX = math.clamp(rotationX, -math.rad(90), math.rad(90))
		
		-- Apply rotation to camera
		camera.CFrame = humanoidRootPart.CFrame * 
			CFrame.Angles(rotationX, rotationY, 0) * 
			CFrame.new(0, 2, 0) -- Offset camera from head
		
		-- Center mouse on screen (Y2K aesthetic)
		-- Draw virtual star cursor at center
	end
end)

-- ====================
-- Y2K STAR CURSOR VISUAL (Optional overlay)
-- ====================

local function createStarCursor()
	local playerGui = player:WaitForChild("PlayerGui")
	
	local cursorGui = Instance.new("ScreenGui")
	cursorGui.Name = "Y2KStarCursor"
	cursorGui.ResetOnSpawn = false
	cursorGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	cursorGui.Parent = playerGui
	
	-- Center crosshair / star
	local star = Instance.new("Frame")
	star.Name = "StarCursor"
	star.Size = UDim2.new(0, 40, 0, 40)
	star.Position = UDim2.new(0.5, -20, 0.5, -20)
	star.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
	star.BackgroundTransparency = 0.5
	star.BorderSizePixel = 0
	star.Parent = cursorGui
	
	-- Make it a circle (rounded corners)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0.5, 0)
	corner.Parent = star
	
	-- Only show when shiftlock is active
	RunService.RenderStepped:Connect(function()
		star.Visible = shiftlockEnabled
	end)
	
	print("[SHIFTLOCK] Y2K star cursor created")
	return cursorGui
end

local starCursor = createStarCursor()

-- ====================
-- DISABLE ROBLOX DEFAULT SHIFTLOCK
-- ====================

player.DevEnableMouseLock = true -- Allow custom shiftlock

print("\n[ASHEN RECKONING] Custom Shiftlock initialized")
print("[SHIFTLOCK] Controls:")
print("  Middle Mouse (MMB) = Toggle Shiftlock")
print("  Mouse Movement = Look around (when enabled)")
print("  Y2K star cursor at screen center\n")
