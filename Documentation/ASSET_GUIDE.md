# 🎨 ASHEN RECKONING - ASSET GUIDE 2026
## Where to Download Free Models, Weapons, and Props

**Last Updated**: May 2026

---

## 📦 WHERE TO FIND ASSETS

### Official Sources
1. **Roblox Creator Marketplace** (Free models)
   - Go to Studio → Toolbox (right panel)
   - Search keywords
   - Free = "Free to use with credit"

2. **Sketchfab** (Free 3D models)
   - https://sketchfab.com
   - Search + download as `.obj`
   - Import into Studio

3. **Blender** (Free modeling tool)
   - Download at blender.org
   - Model custom weapons
   - Export as `.fbx` or `.obj`

4. **Assetly** (Paid Roblox assets)
   - Premium props for games
   - Professional quality

---

## 🗡️ WEAPON MODELS

### Katana
**Search Terms**: "Katana", "Japanese Sword", "Samurai Blade"  
**Creator Marketplace**: Free katana models exist (search "Katana mesh")  
**Quality**: 500-5000 polygons recommended  
**How to use**:
1. Search in Toolbox
2. Insert into game
3. Move to ReplicatedStorage > Assets > Weapons
4. Scale to fit player hand (use Move tool)

### Scythe
**Search**: "Scythe", "Grim Reaper", "Death Weapon"  
**Recommended**: Model one in Blender (complex shape)  
**Scale**: 2-3x normal size  

### Dagger
**Search**: "Dagger", "Short Blade", "Knife"  
**Marketplace**: Many free options  
**Tips**: Keep model light (200-800 polygons)

### Revolver
**Search**: "Revolver", "Handgun", "Firearm"  
**Note**: Roblox has content rules - check firearm models are approved  
**Alternative**: Use SteamPunk revolver for fantasy feel

---

## 🏛️ ENVIRONMENT PROPS

### Ruins / Architecture
**Search**: "Ruins", "Dark ruins", "Gothic architecture"  
**Recommended Props**:
- Stone pillars (Slate material)
- Broken arches
- Ancient columns
- Cracked stone walls

**Creator Examples**:
- "Dark Ruins Pack" (Marketplace)
- "Gothic Building Set"
- "Bloodborne-Inspired Pack"

### Graveyard Elements
**Search**: "Gravestone", "Graveyard", "Cemetery"  
**Download**:
- Gravestones (simple squares work)
- Crosses
- Tombstones
- Iron fences

**DIY Option**: Create in Studio:
1. Insert → Part → Block
2. Shape = 1x3x0.1 (gravestone size)
3. Material = Slate
4. Color = Dark stone grey

### Lanterns / Lighting Props
**Search**: "Lantern", "Torch", "Dark lantern"  
**Purpose**: Add to dark areas for atmosphere  
**Recommended**: Medieval/gothic lanterns

### Dark Trees
**Search**: "Dead tree", "Twisted tree", "Dark forest tree"  
**Tip**: Scale large (15-20 studs tall)  
**Placement**: Around map edges

### Water/Poison Effects
**Search**: "Water texture", "Toxic pool", "Dark water"  
**DIY**: Use Workspace.Terrain:
```lua
Workspace.Terrain:FillBall(Vector3.new(x, y, z), radius, Enum.Material.Water)
```

---

## 🎬 ANIMATIONS

### Where to Get Animations

1. **Moon Animator 2** (Free plugin, create custom)
   - Download plugin in Studio
   - Create animations frame-by-frame
   - Export animation IDs

2. **Marketplace Animation Packs**
   - Search: "Combat Animations", "Sword Animations"
   - Copy animation ID
   - Use in code: `game:GetService("RunService"):LoadAnimation(id)`

3. **Free Animation Sites**
   - Roblox Animations Marketplace
   - Some DevEx creators share free IDs

### Animation IDs to Copy
```
Light Attack (sword): rbxassetid://9862131
Heavy Attack: rbxassetid://9862145
Parry: rbxassetid://9862157
Death: rbxassetid://12345678
Run: rbxassetid://12345679
```
(Replace with real IDs from Marketplace)

---

## 📊 RECOMMENDED SETUP

### Minimum to Start
- 1 Katana model
- 1 Dagger model
- 10-20 environment props
- 5-10 basic animations

### Recommended Full Setup
- All 5 weapon models
- Mythic weapon visuals (River of Blood, Mortal Blade)
- 50+ environment props
- 30+ combat animations
- 4 biome-specific assets

### Pro Setup (if you want AAA quality)
- Custom-modeled weapons (Blender)
- Professional 3D asset packs
- Motion-capture animations
- Particle effects (custom)
- Terrain with hand-painted textures

---

## 🔧 HOW TO IMPORT INTO STUDIO

### Method 1: Marketplace Insert (Easiest)
```
1. Open Studio
2. Right-click Toolbox → Search asset name
3. Click on asset
4. Click "Insert into Game"
5. Asset appears in Workspace
6. Move to ReplicatedStorage > Assets
```

### Method 2: Import .OBJ Files
```
1. Export model as .obj from Blender
2. In Studio: Toolbox → Models → Import Model
3. Select .obj file
4. Click Open
5. Place in workspace
```

### Method 3: Use Model Folders
```
1. Search in Marketplace
2. Insert entire "pack" (contains multiple models)
3. Extract individual models
4. Store in ReplicatedStorage > Assets > [Category]
```

---

## ⚠️ IMPORTANT NOTES

✅ **Free Assets** must have proper attribution in game credits  
✅ **Performance**: Keep total polygon count under 100k for 16GB RAM  
✅ **Texture Size**: Use 512x512 or 1024x1024 max (larger = lag)  
✅ **Mesh Streaming**: Enabled by default (May 2026 update)  

❌ **Don't**: Copy assets from other games without permission  
❌ **Don't**: Use assets marked "Paid only" for free  
❌ **Don't**: Upload same model 100x (clogs storage)  

---

## 🎯 QUICK START SHOPPING LIST

### Day 1: Get These First
- [ ] Any Katana mesh (Marketplace)
- [ ] Any Scythe mesh
- [ ] 5 Stone pillar models
- [ ] 5 Gravestone models
- [ ] 1 basic animation pack

### Day 2: Expand
- [ ] Dagger + Revolver models
- [ ] Fists = Roblox default hands (no model needed)
- [ ] 20+ architecture props
- [ ] Dark atmosphere lighting

### Week 1: Polish
- [ ] Weapon particle effects
- [ ] Custom animations
- [ ] Biome-specific props
- [ ] NPCs/enemies

---

**Happy asset hunting! 🎨**
