# 🗡️ Ashen Reckoning
## A Professional Dark Souls-Like Roblox Game currently in development


**Ashen Reckoning** is a fully-featured, production-ready Roblox game inspired by Bloodborne, Lies of P, Sekiro, Dark Souls, and Elden Ring.

### 🎮 Features
- **Type//Soul-inspired Menu** with smooth animations
- **Kingdom Hearts-style HUD** with health orbs
- **5 Weapon Types**: Katana, Dagger, Scythe, Fists, Revolver
- **2 Mythic Weapons**: River of Blood (Bleed), Mortal Blade (Dark)
- **Medium Open World** (Deepwoken-inspired)
- **4 Biomes**: Affluent District, Slums, Sewers, Ruins
- **Difficulty Scaling** and enemy variety
- **Custom Y2K Star Shiftlock**
- **25-player servers** with full server-to-client communication
- **Parkour system** (sprint, vault, stamina management)

### 📂 File Structure
```
/ServerScripts/
  - RemotesSetup.lua (Priority 1: Load FIRST)
  - GameServer.lua
  - WorldSetup.lua
  - EnemySpawner.lua
  - DamageHandler.lua

/Modules/
  - CombatModule.lua
  - WeaponBalancing.lua
  - NPCModule.lua
  - StaminaModule.lua
  - PartySystem.lua

/LocalScripts/
  - CombatClient.lua
  - HUD.lua
  - MainMenu.lua
  - DeathScreen.lua
  - CustomShiftlock.lua

/Documentation/
  - SETUP_GUIDE.md (Step-by-step Roblox Studio setup)
  - ARCHITECTURE.md (Deep dive into how everything works)
  - ASSET_GUIDE.md (Where to download free assets)
```

### ⚡ Quick Start
1. **Create a new Roblox place** in Studio
2. **Follow SETUP_GUIDE.md** line-by-line
3. **Copy all scripts** into the correct locations
4. **Download free assets** from Creator Marketplace (guide included)
5. **Test in Studio** and publish!

### 🎯 Important Notes
- **RemotesSetup.lua MUST load first** (drag it above other ServerScripts)
- **All server-to-client communication uses RemoteEvents** (no exploits)
- **HUD is connected to real Roblox health** (default bars hidden)
- **Shiftlock is custom** (Y2K star design, prevents vanilla Roblox default)

### 📖 Documentation
- **SETUP_GUIDE.md** → Step-by-step Studio installation (in English)
- **ARCHITECTURE.md** → How systems work together
- **ASSET_GUIDE.md** → Free marketplace assets + where to find them

---



