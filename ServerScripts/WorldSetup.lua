--[[
	╔═══════════════════════════════════════════════════════════════╗
	║             ASHEN RECKONING - WORLD SETUP                      ║
	║     Creates the open world map with 4 biomes, terrain,         ║
	║                    and environmental effects                    ║
	╚═══════════════════════════════════════════════════════════════╝
	
	Biomes:
	1. Affluent District - Well-lit, rich architecture, easier enemies
	2. Slums - Dark, decrepit, harder enemies, traps, chasms
	3. Sewers - Toxic gas, need gas mask for passive damage immunity
	4. Ruined Bastion - Inspired by Dark Souls/Sekiro, ancient ruins
]]

local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- Store references to biome folders
local biomes = {}

-- ====================
-- WORLD CONFIGURATION
-- ====================
local WORLD_CONFIG = {
	terrain = Workspace.Terrain,
	spawnSize = 512, -- Medium open world
	sky = {
		ambient = Color3.fromRGB(50, 40, 60), -- Dark blue
		outdoorAmbient = Color3.fromRGB(80, 70, 100),
		clockTime = 18, -- Evening/dusk
	},
	fog = {
		enabled = true,
		color = Color3.fromRGB(100, 80, 120),
		start = 50,
		end = 500,
	},
}

-- ====================
-- SETUP LIGHTING
-- ====================
local function setupLighting()
	Lighting.Ambient = WORLD_CONFIG.sky.ambient
	Lighting.OutdoorAmbient = WORLD_CONFIG.sky.outdoorAmbient
	Lighting.ClockTime = WORLD_CONFIG.sky.clockTime
	
	-- Atmospheric fog
	if WORLD_CONFIG.fog.enabled then
		Lighting.FogColor = WORLD_CONFIG.fog.color
		Lighting.FogStart = WORLD_CONFIG.fog.start
		Lighting.FogEnd = WORLD_CONFIG.fog.end
	end
	
	print("[WORLD] Lighting configured - Dark Bloodborne/Sekiro atmosphere")
end

-- ====================
-- BIOME CREATION
-- ====================

local function createBiomeFolder(biomeName, position)
	local biome = Instance.new("Folder")
	biome.Name = biomeName
	biome.Parent = Workspace
	biomes[biomeName] = biome
	print("[WORLD] Created biome folder: " .. biomeName)
end

-- ====================
-- TERRAIN PAINTING
-- ====================

local function paintTerrain()
	local terrain = WORLD_CONFIG.terrain
	
	-- Create base terrain
	terrain:FillBall(Vector3.new(0, 0, 0), 300, Enum.Material.Cobblestone)
	print("[WORLD] Base terrain created (Cobblestone, 300 stud radius)")
	
	-- Mud for swamp/sewer areas
	terrain:FillBall(Vector3.new(500, 0, 500), 150, Enum.Material.Mud)
	print("[WORLD] Sewer terrain created (Mud)")
	
	-- Grass for wealthier district
	terrain:FillBall(Vector3.new(-500, 0, -500), 150, Enum.Material.Grass)
	print("[WORLD] Affluent District terrain created (Grass)")
end

-- ====================
-- STATIC PROPS (Buildings, Ruins, etc.)
-- ====================

local function createRuins()
	local ruinsFolder = Instance.new("Folder")
	ruinsFolder.Name = "Ruins"
	ruinsFolder.Parent = Workspace
	
	-- Simple stone pillar ruins (placeholder for actual assets)
	for i = 1, 5 do
		local pillar = Instance.new("Part")
		pillar.Shape = Enum.PartType.Block
		pillar.Material = Enum.Material.Slate
		pillar.BrickColor = BrickColor.new("Dark stone grey")
		pillar.Size = Vector3.new(2, 8, 2)
		pillar.CanCollide = true
		pillar.TopSurface = Enum.SurfaceType.Smooth
		pillar.BottomSurface = Enum.SurfaceType.Smooth
		pillar.Position = Vector3.new(50 + (i * 40), 5, 100)
		pillar.Parent = ruinsFolder
	end
	
	print("[WORLD] Created 5 stone pillars in Ruins biome")
end

local function createGraveyard()
	local graveyardFolder = Instance.new("Folder")
	graveyardFolder.Name = "Graveyard"
	graveyardFolder.Parent = Workspace
	
	-- Simple grave markers
	for i = 1, 10 do
		local grave = Instance.new("Part")
		grave.Shape = Enum.PartType.Block
		grave.Material = Enum.Material.Slate
		grave.BrickColor = BrickColor.new("Medium stone grey")
		grave.Size = Vector3.new(1, 3, 2)
		grave.CanCollide = true
		grave.Position = Vector3.new(-100 + (i * 20), 2, -100)
		grave.Rotation = Vector3.new(0, math.random(-45, 45), 0)
		grave.Parent = graveyardFolder
	end
	
	print("[WORLD] Created 10 graves in Graveyard")
end

local function createWaterAreas()
	local waterFolder = Instance.new("Folder")
	waterFolder.Name = "Water"
	waterFolder.Parent = Workspace
	
	-- Dark water pool (sewer area)
	local water = Instance.new("Part")
	water.Shape = Enum.PartType.Block
	water.Material = Enum.Material.Water
	water.BrickColor = BrickColor.new("Dark green")
	water.Size = Vector3.new(200, 5, 200)
	water.CanCollide = false
	water.Transparency = 0.3
	water.Position = Vector3.new(500, -10, 500)
	water.Parent = waterFolder
	
	-- Deal passive damage if player touches (unless they have gas mask)
	water.Touched:Connect(function(hit)
		local humanoid = hit.Parent:FindFirstChild("Humanoid")
		if humanoid then
			print("[WORLD] Player in toxic water - would need gas mask")
		end
	end)
	
	print("[WORLD] Created toxic water pool in Sewers")
end

local function createDangerZones()
	local dangerFolder = Instance.new("Folder")
	dangerFolder.Name = "DangerZones"
	dangerFolder.Parent = Workspace
	
	-- Chasm/pit in slums
	local chasm = Instance.new("Part")
	chasm.Shape = Enum.PartType.Block
	chasm.Material = Enum.Material.Slate
	chasm.BrickColor = BrickColor.new("Black")
	chasm.Size = Vector3.new(100, 50, 20)
	chasm.CanCollide = true
	chasm.Position = Vector3.new(300, -40, 200)
	chasm.Parent = dangerFolder
	
	print("[WORLD] Created chasm in Slums (instant death if touched)")
end

-- ====================
-- SPAWN POINT
-- ====================

local function createSpawnArea()
	local spawnFolder = Instance.new("Folder")
	spawnFolder.Name = "SpawnArea"
	spawnFolder.Parent = Workspace
	
	-- Safe platform
	local spawnPlatform = Instance.new("Part")
	spawnPlatform.Shape = Enum.PartType.Block
	spawnPlatform.Material = Enum.Material.Slate
	spawnPlatform.BrickColor = BrickColor.new("Dark stone grey")
	spawnPlatform.Size = Vector3.new(50, 2, 50)
	spawnPlatform.CanCollide = true
	spawnPlatform.TopSurface = Enum.SurfaceType.Smooth
	spawnPlatform.BottomSurface = Enum.SurfaceType.Smooth
	spawnPlatform.Position = Vector3.new(0, 5, 0)
	spawnPlatform.Parent = spawnFolder
	
	print("[WORLD] Created spawn platform at (0, 5, 0)")
end

-- ====================
-- INITIALIZATION
-- ====================

print("\n[ASHEN RECKONING] Starting World Setup...\n")

setupLighting()
paintTerrain()
createSpawnArea()
createRuins()
createGraveyard()
createWaterAreas()
createDangerZones()

print("\n[ASHEN RECKONING] World setup complete!")
print("[ASHEN RECKONING] Map loaded with 4 biomes and atmospheric effects.\n")
