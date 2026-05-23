# 🎮 ASHEN RECKONING - SETUP GUIDE 2026
## Ultra-Detailed Step-by-Step Installation for Roblox Studio

**Language**: English  
**Game Version**: Ashen Reckoning v1.0  
**Studio Version**: Roblox Studio 2026  
**Last Updated**: May 2026

---

## 📋 TABLE OF CONTENTS
1. [Prerequisites](#prerequisites)
2. [Part 1: Create New Place](#part-1-create-new-place)
3. [Part 2: Folder Structure](#part-2-folder-structure)
4. [Part 3: Copy Scripts](#part-3-copy-scripts)
5. [Part 4: Configure Remotes](#part-4-configure-remotes)
6. [Part 5: Asset Marketplace Setup](#part-5-asset-marketplace-setup)
7. [Part 6: Test & Publish](#part-6-test--publish)
8. [Troubleshooting](#troubleshooting)

---

## PREREQUISITES

### What You Need
✅ Roblox Studio installed (free from roblox.com/create)  
✅ A Roblox account with game creation access  
✅ GitHub repo cloned or files downloaded  
✅16+ GB RAM recommended (for Mesh Streaming)  
✅ GPU with 2GB+ VRAM  

### Recommended Plugins (Free)
- **Moon Animator 2** (for custom animations)
- **Mesh Importer** (for 3D models from Blender)
- **F3X Build Tools** (for terrain editing)

---

## PART 1: CREATE NEW PLACE

### Step 1.1: Open Roblox Studio
1. Launch **Roblox Studio**
2. You see the Start Screen with templates
3. Click **"Create New"** (top-left)
4. Select **"Blank Baseplate"** template
5. Wait 10-15 seconds for the place to load

### Step 1.2: Save Your Place
1. Go to **File** (top menu)
2. Click **"Save As"**
3. Name it: **"AshenReckoning"**
4. Click **Save**
5. You'll see the place name at the top of Studio window

---

## PART 2: FOLDER STRUCTURE

### Step 2.1: Create Folder Hierarchy
In the **Explorer** panel (left side), you need to create this structure:

```
Workspace (already exists)
  └─ (your terrain and props go here)

ReplicatedStorage (already exists)
  ├─ Remotes (NEW - create this)
  ├─ Modules (NEW - create this)
  └─ Assets (NEW - create this, for downloaded models)

ServerScriptService (already exists)
  ├─ RemotesSetup (script)
  ├─ GameServer (script)
  └─ WorldSetup (script)

PlayerGui / StarterPlayer / StarterCharacterScripts (for local scripts)
  ├─ CombatClient (LocalScript)
  ├─ HUD (LocalScript)
  ├─ MainMenu (LocalScript)
  ├─ DeathScreen (LocalScript)
  └─ CustomShiftlock (LocalScript)
```

### Step 2.2: Create "Remotes" Folder
1. Right-click **ReplicatedStorage** in Explorer
2. Click **"Insert Object"**
3. Select **"Folder"**
4. Name it: **"Remotes"**
5. Hit Enter

### Step 2.3: Create "Modules" Folder
1. Right-click **ReplicatedStorage**
2. Click **"Insert Object"** → **"Folder"**
3. Name it: **"Modules"**

### Step 2.4: Create "Assets" Folder
1. Right-click **ReplicatedStorage**
2. Click **"Insert Object"** → **"Folder"**
3. Name it: **"Assets"** (for downloaded marketplace models)

---

## PART 3: COPY SCRIPTS

### Step 3.1: Copy Server Scripts (Priority Order)

**CRITICAL**: These must be loaded in this exact order!

#### 3.1.1: Add RemotesSetup.lua
1. Right-click **ServerScriptService** → **"Insert Object"** → **"Script"**
2. Name it: **"RemotesSetup"**
3. Open the script (double-click it)
4. **DELETE** the default `print("Hello world")` line
5. Copy the entire content of `RemotesSetup.lua` from GitHub
6. Paste it into Studio
7. Press **Ctrl+S** to save

#### 3.1.2: Add GameServer.lua
1. Right-click **ServerScriptService** → **"Insert Object"** → **"Script"**
2. Name it: **"GameServer"**
3. Double-click to open
4. Delete default content
5. Copy & paste `GameServer.lua` content
6. Save with **Ctrl+S**

#### 3.1.3: Add WorldSetup.lua
1. Right-click **ServerScriptService** → **"Insert Object"** → **"Script"**
2. Name it: **"WorldSetup"**
3. Copy & paste `WorldSetup.lua` content
4. Save

**✅ CHECKPOINT**: In Output panel, you should see green messages:
```
[ASHEN RECKONING] Remotes setup complete!
[ASHEN RECKONING] GameServer initialized!
[ASHEN RECKONING] World setup complete!
```

### Step 3.2: Add Module Scripts

These go in **ReplicatedStorage > Modules**

#### 3.2.1: CombatModule.lua
1. Right-click **Modules** folder → **"Insert Object"** → **"ModuleScript"**
2. Name it: **"CombatModule"**
3. Copy & paste content from GitHub
4. Save

#### 3.2.2: WeaponBalancing.lua
1. Right-click **Modules** → **"Insert Object"** → **"ModuleScript"**
2. Name it: **"WeaponBalancing"**
3. Paste content
4. Save

#### 3.2.3: StaminaModule.lua
1. Right-click **Modules** → **"Insert Object"** → **"ModuleScript"**
2. Name it: **"StaminaModule"**
3. Paste content
4. Save

#### 3.2.4: NPCModule.lua
1. Right-click **Modules** → **"Insert Object"** → **"ModuleScript"**
2. Name it: **"NPCModule"**
3. Paste content
4. Save

### Step 3.3: Add Local Scripts

These go in **StarterPlayer > StarterCharacterScripts** OR **StarterPlayer > StarterPlayerScripts**

**Navigation**: Click **StarterPlayer** in Explorer → see **StarterCharacterScripts** folder

#### 3.3.1: CombatClient.lua
1. Right-click **StarterCharacterScripts** → **"Insert Object"** → **"LocalScript"**
2. Name it: **"CombatClient"**
3. Paste content
4. Save

#### 3.3.2: HUD.lua
1. Right-click **StarterCharacterScripts** → **"Insert Object"** → **"LocalScript"**
2. Name it: **"HUD"**
3. Paste content
4. Save

#### 3.3.3: MainMenu.lua
1. Right-click **StarterCharacterScripts** → **"Insert Object"** → **"LocalScript"**
2. Name it: **"MainMenu"**
3. Paste content
4. Save

#### 3.3.4: DeathScreen.lua
1. Right-click **StarterCharacterScripts** → **"Insert Object"** → **"LocalScript"**
2. Name it: **"DeathScreen"**
3. Paste content
4. Save

#### 3.3.5: CustomShiftlock.lua
1. Right-click **StarterCharacterScripts** → **"Insert Object"** → **"LocalScript"**
2. Name it: **"CustomShiftlock"**
3. Paste content
4. Save

---

## PART 4: CONFIGURE REMOTES

RemoteEvents should be **auto-created** by RemotesSetup.lua on first run.

To verify:
1. Press **Play** (top button)
2. Check **Output** panel
3. Look for: `[REMOTES] Created RemoteEvent: PlayerAttack`
4. If you see 20+ remote creation messages, **you're good!**
5. Stop the game (**Stop** button)

If RemoteEvents don't exist:
1. Check **ReplicatedStorage > Remotes** folder
2. If empty, check Output for error messages
3. Verify RemotesSetup.lua is correct

---

## PART 5: ASSET MARKETPLACE SETUP

### What Assets You Need

**Weapons Models** (Download from Creator Marketplace):
- Katana mesh
- Scythe mesh
- Dagger mesh
- Revolver mesh

**Animations** (Download or create):
- Attack animations (light, heavy, combo)
- Parry animations
- Sprint animation
- Death animation

**Environment Props**:
- Ruins/pillars
- Gravestones
- Lanterns
- Dark trees

### Step 5.1: Search Creator Marketplace
1. In Studio, go to **Toolbox** (right panel)
2. Search for **"Katana"** or **"Sword Mesh"**
3. Click an asset you like
4. Click **Insert into Game**
5. It appears in Workspace
6. Right-click → **Group into Folder** → name it **"Weapons"**

### Step 5.2: Import Custom Models (Optional)
If you want to use Blender models:
1. Export model as `.obj` file
2. In Studio: **Toolbox** → **Models** → **Import Model**
3. Select `.obj` file
4. Click **Open**
5. Position in Workspace

### Step 5.3: Add Animations
1. Download animation from marketplace or create with Moon Animator 2
2. Get the **Animation ID** (long number)
3. In your attack scripts, reference: `game:GetService("RunService"):LoadAnimation("rbxassetid://XXXXXXXXX")`

---

## PART 6: TEST & PUBLISH

### Step 6.1: Test in Studio
1. Click **Play** button (top)
2. Wait for game to load (10-15 seconds)
3. Check Output for errors
4. Try controls:
   - **M1** = Light attack
   - **M2** = Heavy attack
   - **R** = Critical
   - **E** = Parry
   - **SHIFT** = Sprint
   - **SPACE** = Vault
   - **1-5** = Weapon switch
5. Click **Stop** to exit

### Step 6.2: Fix Common Errors

| Error | Fix |
|-------|-----|
| "ReplicatedStorage.Remotes is nil" | Check RemotesSetup.lua ran first (see Output) |
| "Module not found" | Verify all 4 modules are in ReplicatedStorage > Modules |
| Controls don't work | Check CombatClient.lua is in StarterCharacterScripts |
| Game crashes on spawn | Check WorldSetup.lua has no syntax errors |

### Step 6.3: Publish to Roblox
1. Go to **File** → **Publish to Roblox**
2. Login if needed
3. Fill in:
   - **Title**: "Ashen Reckoning" 
   - **Description**: Your game description
   - **Creator Icon**: (optional)
4. Click **Create**
5. Wait 1-2 minutes
6. Your game is now live!

### Step 6.4: Share Your Game
1. Copy the game URL from Studio
2. Share on Discord/social media
3. Players can join with the link

---

## TROUBLESHOOTING

### Issue: "Script Error: attempt to index nil with 'WaitForChild'"
**Cause**: A script ran before its dependencies loaded  
**Fix**: 
1. Check script load order
2. Ensure RemotesSetup runs first
3. Add `wait(1)` at top of script

### Issue: Controls Don't Respond
**Cause**: LocalScript not in correct location  
**Fix**:
1. Move scripts to **StarterCharacterScripts**
2. Not StartPlayer directly
3. Verify script names match exactly

### Issue: "ReplicatedStorage.Modules.CombatModule is not a valid Module"
**Cause**: Module script has syntax error  
**Fix**:
1. Open the module
2. Check for typos or missing `return` statement
3. Look in Output for exact line number

### Issue: HUD Not Showing
**Cause**: ScreenGui not created or hidden  
**Fix**:
1. In HUD.lua, check `playerGui:WaitForChild("PlayerGui")`
2. Verify no GUI is disabled
3. Check Output for errors

### Issue: Can't Damage Enemies
**Cause**: Hitbox/damage detection not implemented  
**Fix** (for now):
1. This is placeholder code
2. You need to add raycasting for hit detection
3. Recommend using Region3 or Raycasting

---

## ✅ SUCCESS CHECKLIST

Before publishing, verify:
- [ ] All 3 server scripts in ServerScriptService
- [ ] All 4 modules in ReplicatedStorage/Modules
- [ ] All 5 local scripts in StarterCharacterScripts
- [ ] Remotes folder exists in ReplicatedStorage
- [ ] Game runs without errors in Output
- [ ] Controls respond (M1/M2/R/E/X/C/V)
- [ ] HUD displays (health orbs + stamina bar)
- [ ] Menu shows on spawn
- [ ] Weapon switching works (1-5 keys)
- [ ] Custom shiftlock cursor visible

---

## 🎯 NEXT STEPS

1. **Add Real Assets**: Download weapons/props from Creator Marketplace
2. **Create Animations**: Use Moon Animator 2 for combat animations
3. **Implement Hit Detection**: Add raycasting for damage
4. **Add Enemies**: Spawn NPCs with AI pathfinding
5. **Balance Gameplay**: Tweak WeaponBalancing.lua numbers
6. **Add Sound**: Background music + attack SFX
7. **Polish UI**: Improve menu visuals with images/logos
8. **Test Multiplayer**: Have friends join and test combat

---

## 📞 SUPPORT

If you encounter issues:
1. Check Output panel for error messages
2. Post error in Roblox Developer Forum
3. Verify all script names match exactly
4. Try deleting and re-adding the problematic script

---

**You've got this! 🎮✨**
