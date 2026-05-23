# 🏗️ ASHEN RECKONING - ARCHITECTURE GUIDE
## How All the Systems Work Together

**Last Updated**: May 2026  
**Audience**: Developers wanting to understand the codebase

---

## 📊 SYSTEM OVERVIEW

```
┌─────────────────────────────────────────────────────┐
│                   SERVER (Master)                    │
│  • RemotesSetup: Creates all network channels       │
│  • GameServer: Player state + combat authority      │
│  • WorldSetup: Map generation + terrain             │
│  • Modules: Balance data + NPC data                 │
└─────────────────────────────────────────────────────┘
         ↓↑ (RemoteEvents / RemoteFunctions)
┌─────────────────────────────────────────────────────┐
│              LOCAL CLIENT (Per Player)              │
│  • CombatClient: Input handling (M1/M2/R/etc)     │
│  • HUD: Display health + stamina + weapons          │
│  • MainMenu: UI for play/settings                   │
│  • CustomShiftlock: Mouse camera control            │
│  • DeathScreen: Death cinematic                     │
└─────────────────────────────────────────────────────┘
```

---

## 🔄 DATA FLOW (How Commands Work)

### Example: Player Attacks Enemy

```
1. CLIENT INPUT
   └─ Player presses M1 (Mouse Button 1)
   └─ CombatClient.lua fires: PlayerAttack:FireServer()
   └─ Sends: (weaponName, attackType) to server

2. SERVER PROCESSING
   └─ GameServer.lua receives PlayerAttack event
   └─ Validates: Stamina check, attack cooldown, distance
   └─ Calls: CombatModule:calculateDamage()
   └─ Result: 15 damage to enemy

3. SERVER BROADCASTS
   └─ PlayAttackAnimation:FireAllClients(player, weapon, type)
   └─ All players see the animation
   └─ UpdateStaminaBar:FireAllClients(playerID, stamina)
   └─ All clients update their HUD

4. CLIENT UPDATES
   └─ Each client receives updates
   └─ HUD.lua updates stamina bar
   └─ CombatClient.lua updates combatState
   └─ Screen shows visual feedback
```

---

## 📁 FILE RESPONSIBILITIES

### SERVER SCRIPTS (Always Running)

#### RemotesSetup.lua
**Purpose**: Create communication channels  
**Runs**: Once at startup  
**Creates**: 25+ RemoteEvents in ReplicatedStorage.Remotes  
**Key Remotes**:
- PlayerAttack
- PlayerParry
- UpdateHealthBar
- TriggerDeathScreen

#### GameServer.lua
**Purpose**: Combat + player state authority  
**Runs**: Constantly while server is running  
**Handles**:
- Player joins → initialize health/stamina
- Player leaves → cleanup data
- Damage calculations
- Status effects (bleed, poison)
- Respawn logic

**Key Functions**:
```lua
initializePlayer(player) -- Set up HP/stamina
Remotes:PlayerAttack:OnServerEvent -- Receive attack
Remotes:PlayerParry:OnServerEvent -- Receive parry
respawnPlayer(player) -- Reset on death
```

#### WorldSetup.lua
**Purpose**: Generate map + terrain  
**Runs**: Once at startup  
**Creates**:
- Spawn platform
- Terrain (cobblestone, mud, grass)
- Ruins/pillars
- Graveyard
- Water areas
- Danger zones

**Key Terrain Materials**:
- Cobblestone = main walkable area
- Mud = sewers (toxic)
- Grass = affluent district
- Slate = buildings/ruins

---

### MODULES (Reusable Logic)

#### CombatModule.lua
**Purpose**: Define all weapon stats  
**Contains**:
- Fists, Katana, Dagger, Scythe, Revolver stats
- River of Blood (mythic) stats
- Mortal Blade (mythic) stats
- Parry mechanics
- Status effects

**Key Data**:
```lua
weapons.Katana = {
  dmgMultiplier = 1.3,
  staminaCostLight = 12,
  range = 5,
  movesets = {
    Light = {damage = 12, animLength = 0.5},
    Heavy = {damage = 22, animLength = 1.0},
    Combo = {damage = 18, hits = 3, animLength = 1.8}
  }
}
```

#### WeaponBalancing.lua
**Purpose**: Game balance + difficulty  
**Contains**:
- Attack cooldowns
- Stamina regen rates
- Enemy scaling per biome
- Revolver ammo/cooldown
- Gas mask mechanics

**Key Balance Values**:
```lua
staminaRegenRate = 15 -- Per second
sprintStaminaCost = 1 -- Per frame (60fps = 60/sec)
revolverShotCooldown = 0.5 -- Between shots
sewerPassiveDamage = 3 -- Per second in sewers
```

#### StaminaModule.lua
**Purpose**: Stamina logic  
**Contains**:
- Drain/regenerate functions
- Can-do checks (canAttack, canParry, canSprint)
- Stamina state management

**Key Methods**:
```lua
StaminaModule:drainStamina(amount)
StaminaModule:regenerateStamina(amount)
StaminaModule:hasEnoughStamina(cost)
StaminaModule:canSprint()
```

#### NPCModule.lua
**Purpose**: Enemy definitions  
**Contains**:
- Normal enemies: Hollow Wretch, Blood Knight, Cursed Priest
- Mini-bosses: Graveyard Guardian, Ruined King
- AI behaviors
- Loot tables
- Health/damage scaling

**Enemy Example**:
```lua
BloodKnight = {
  baseHealth = 45,
  baseDamage = 6,
  weapon = "Katana",
  armor = 0.85, -- Takes 15% less damage
  behavior = "Patrol + Aggro"
}
```

---

### LOCAL SCRIPTS (Per Player)

#### CombatClient.lua
**Purpose**: Process player input  
**Runs**: On each player's client  
**Handles**:
- M1 = Light attack
- M2 = Heavy attack
- R = Critical attack
- E = Parry
- X/C/V = Weapon abilities
- 1-5 = Weapon switch
- SHIFT = Sprint
- SPACE = Vault

**Key Events**:
```lua
UserInputService.InputBegan -- Key pressed
Remotes.PlayerAttack:FireServer() -- Send to server
Remotes.UpdateHealthBar:OnClientEvent -- Receive updates
```

#### HUD.lua
**Purpose**: Display player information  
**Creates**:
- Kingdom Hearts health orbs (5 segments)
- Cyan stamina bar
- Weapon display (top-right)
- Real HP bar removed

**Health System**:
- 5 orbs × 20 HP each = 100 total
- Red orbs = full health
- Gray orbs = damaged
- Updates every server health change

#### MainMenu.lua
**Purpose**: Start menu UI  
**Shows**:
- "ASHEN RECKONING" title (Type//Soul style)
- PLAY button
- CHARACTER button
- COMBAT STYLES button
- CONTROLS button
- QUIT button
- Controls legend at bottom

**Menu Close**: Clicking PLAY destroys menu GUI

#### DeathScreen.lua
**Purpose**: Death cinematic  
**Shows**:
- Black fade effect
- "YOU DIED" text
- Countdown timer
- Auto-respawn after 5 seconds

**Flow**:
```
1. Server notifies: PlayerDeath event
2. Client shows black overlay
3. Display "YOU DIED"
4. Countdown 5→4→3→2→1
5. Fire respawn request to server
6. Fade out
```

#### CustomShiftlock.lua
**Purpose**: Mouse-look camera control  
**Features**:
- Middle Mouse (MMB) toggle on/off
- Y2K star cursor at center
- Smooth camera following mouse
- Prevents over-rotation

**Camera Control**:
```lua
camera.CFrame = humanoidRootPart.CFrame * 
  CFrame.Angles(rotationX, rotationY, 0) * 
  CFrame.new(0, 2, 0)
```

---

## 🌊 COMMUNICATION FLOW

### Attack Flow (Detailed)
```
CLIENT                          SERVER
  │                              │
  ├─ M1 pressed ──────────────┬→ PlayerAttack event
  │  FireServer(              │  │
  │  "Katana",              │  ├→ Validate attack
  │  "Light"                 │  │  ├─ Check stamina
  │  )                        │  │  ├─ Check cooldown
  │                          │  │  └─ Check distance
  │                          │  │
  │                          │  └→ Calculate damage
  │                          │     ├─ Base: 12
  │                          │     ├─ Multiplier: 1.3
  │                          │     └─ Result: ~15.6
  │                          │
  │ PlayAttackAnimation ←─────┤  Broadcast animation
  │ ┌─ Fire event           │
  │ └─ All clients show anim│
  │                          │
  │ UpdateStaminaBar ←────────┤ Broadcast stamina
  │ ┌─ Cyan bar updates     │
  │ └─ HUD shows new value  │
  │                          │
```

---

## 🎮 GAME STATES

### Player State Machine
```
┌──────────┐
│  SPAWNED │ ← Player joins game
└─────┬────┘
      │
      ▼
 ┌─────────┐
 │ IN_GAME │ ← Can move, attack, parry
 │ (Alive) │
 └────┬────┘
      │ (Takes damage)
      ▼
 ┌─────────┐
 │ DYING   │ ← HP reaches 0
 └────┬────┘
      │ (Wait 5 sec)
      ▼
 ┌──────────┐
 │ RESPAWN  │ ← Reset to spawn point
 └─────┬────┘
       │
       └────→ IN_GAME (loop)
```

---

## ⚡ OPTIMIZATION TIPS

### Performance Checklist
- [ ] Use LOD (Level of Detail) for distant props
- [ ] Limit NPC count (50 max for 25 players)
- [ ] Use Mesh Streaming (enabled by default)
- [ ] Batch terrain operations (avoid FillBall in loops)
- [ ] Reduce particle count on weapons
- [ ] Use texture atlasing for props

### Profiling
1. In Studio: View → Output
2. Look for frame time warnings
3. If > 16ms per frame = lag
4. Profile → Microprofiler to find bottleneck

---

## 🐛 DEBUGGING

### Print Statements Strategy
```lua
-- Server-side
print("[SERVER] Player joined: " .. player.Name)
print("[COMBAT] Attack calculated: " .. damage .. " damage")
print("[ERROR] Health below 0: " .. humanoid.Health)

-- Client-side
print("[CLIENT] Input received: M1")
print("[HUD] Health updated: " .. newHealth)
print("[MENU] Player clicked PLAY")
```

### Check Output Panel
1. Play game
2. Perform action
3. Look for `[TAG]` messages in Output
4. Verify expected flow

---

**Now you understand the whole system! 🎮**
