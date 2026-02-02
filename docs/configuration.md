# 🐺 LXR Quest Missions - Configuration Guide

```
 ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ ██╗   ██╗██████╗  █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ ██║   ██║██╔══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗██║   ██║██████╔╝███████║   ██║   ██║██║   ██║██╔██╗ ██║
██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║██║   ██║██╔══██╗██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝╚██████╔╝██║  ██║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
 ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
```

**🐺 The Land of Wolves - Complete Configuration Reference**

**Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!**

---

## 📖 Table of Contents

1. [Overview](#overview)
2. [Server Information](#server-information)
3. [Framework Settings](#framework-settings)
4. [General Settings](#general-settings)
5. [Quest NPCs](#quest-npcs)
6. [Rewards & Economy](#rewards--economy)
7. [Cooldowns & Timing](#cooldowns--timing)
8. [XP & Progression](#xp--progression)
9. [Security Settings](#security-settings)
10. [Performance Settings](#performance-settings)
11. [Debug Options](#debug-options)

---

## 🌟 Overview

The `config.lua` file is the central configuration hub for LXR Bounty Quests. This comprehensive guide explains every configuration option available, allowing you to customize the system to match your server's needs perfectly.

**Configuration File Location:**
```
lxr-bounty-quests/config.lua
```

---

## 🏢 Server Information

### Config.ServerInfo

This section contains your server's branding and contact information. These values are displayed in various places throughout the script including startup messages and UI elements.

```lua
Config.ServerInfo = {
    name = 'The Land of Wolves 🐺',
    tagline = 'Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!',
    description = 'ისტორია ცოცხლდება აქ!', -- History Lives Here!
    type = 'Serious Hardcore Roleplay',
    access = 'Discord & Whitelisted',
    
    -- Contact & Links
    website = 'https://www.wolves.land',
    discord = 'https://discord.gg/CrKcWdfd3A',
    github = 'https://github.com/iBoss21',
    store = 'https://theluxempire.tebex.io',
    serverListing = 'https://servers.redm.net/servers/detail/8gj7eb',
    
    -- Developer Info
    developer = 'iBoss21 / The Lux Empire',
    
    -- Tags
    tags = {'RedM', 'Georgian', 'SeriousRP', 'Whitelist', 'Bounty', 'Quests', 'Economy', 'RPG'}
}
```

#### Configuration Options:

| Option | Type | Description |
|--------|------|-------------|
| `name` | String | Your server's display name |
| `tagline` | String | Server tagline or slogan |
| `description` | String | Short server description |
| `type` | String | Server type (RP style) |
| `access` | String | Access method (whitelist, public, etc.) |
| `website` | String | Server website URL |
| `discord` | String | Discord invite link |
| `github` | String | GitHub profile or repository |
| `store` | String | Tebex or donation store link |
| `serverListing` | String | Server listing URL (CFX, RedM.net, etc.) |
| `developer` | String | Script developer name |
| `tags` | Table | Array of descriptive tags |

---

## ⚙️ Framework Settings

### Config.Framework

Controls which framework the script uses. The system includes intelligent auto-detection but can be manually overridden.

```lua
Config.Framework = 'auto' -- Options: 'auto', 'lxrcore', 'rsg-core', 'qbr-core', 'qr-core', 'vorp', 'redemrp', 'standalone'
```

#### Supported Frameworks (Priority Order):

1. **LXRCore** - Primary (The Land of Wolves custom framework)
2. **RSG-Core** - Primary (Rexshack RedM framework)
3. **QBR Core** - QB-Core for RedM
4. **QR Core** - QR Core Framework
5. **VORP Core** - Legacy Support
6. **RedEM:RP** - Legacy Support
7. **Standalone** - No framework required

### Config.FrameworkSettings

Detailed framework-specific configuration for each supported framework:

```lua
Config.FrameworkSettings = {
    lxrcore = {
        enabled = true,
        resource = 'lxr-core',
        exportName = 'lxr-core',
        getSharedObject = 'lxr-core:getSharedObject',
        playerLoaded = 'LXR:Client:OnPlayerLoaded',
        playerUnloaded = 'LXR:Client:OnPlayerUnload',
        jobUpdate = 'LXR:Client:OnJobUpdate',
        notification = 'lxr', -- 'lxr', 'vorp', 'native'
    },
    -- Additional frameworks configured similarly...
}
```

#### Framework Settings Options:

| Option | Type | Description |
|--------|------|-------------|
| `enabled` | Boolean | Enable/disable this framework |
| `resource` | String | Framework resource name |
| `exportName` | String | Export name for framework object |
| `getSharedObject` | String | Event name to get shared object |
| `playerLoaded` | String | Event triggered when player loads |
| `playerUnloaded` | String | Event triggered when player disconnects |
| `jobUpdate` | String | Event triggered on job change |
| `notification` | String | Notification system to use |

---

## 🎮 General Settings

### Core System Controls

```lua
Config.EnableQuests = true -- Enable/disable the entire quest system
Config.EnableDebug = false -- Enable debug messages in console/chat
Config.EnableBlips = true -- Show quest NPCs on the map
Config.EnablePrompts = true -- Show prompts when near quest NPCs
```

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `EnableQuests` | Boolean | `true` | Master switch for quest system |
| `EnableDebug` | Boolean | `false` | Show debug output in console |
| `EnableBlips` | Boolean | `true` | Display quest NPC map blips |
| `EnablePrompts` | Boolean | `true` | Show interaction prompts |

### Language Configuration

```lua
Config.Lang = 'English' -- Options: 'English', 'French', 'German', 'Spanish', 'Italian', 'Georgian'
```

Supported languages:
- English
- French
- German
- Spanish
- Italian
- Georgian (🇬🇪)

### Keybinds

```lua
Config.Keys = {
    OpenQuestMenu = 0xD9D0E1C0, -- [SPACE] - Interact with quest NPC
    IdentifyTarget = 0xC7B5340A, -- [E] - Identify bounty target
}
```

**Key Reference:**
- `OpenQuestMenu` - Interact with quest giver NPCs
- `IdentifyTarget` - Identify bounty targets in the world

*Note: Key codes are RedM/FiveM hash values. See [FiveM Docs](https://docs.fivem.net/docs/game-references/controls/) for reference.*

---

## 🎯 Quest NPCs

### NPC Configuration Structure

Quest NPCs are configured in `Config.QuestNPCs`. Each NPC represents a quest giver with their own location, quests, and requirements.

```lua
Config.QuestNPCs = {
    {
        id = 'valentine_sheriff',
        name = 'Sheriff Curtis Malloy',
        model = 'u_m_m_valdeputy_01',
        coords = vector3(-275.81, 805.48, 118.40),
        heading = 95.0,
        
        -- Blip Configuration
        blip = {
            enabled = true,
            sprite = 'blip_ambient_bounty_poster',
            scale = 0.2,
            color = 'BLIP_MODIFIER_MP_COLOR_8'
        },
        
        -- Unlock Requirements
        unlockRequirements = {
            level = 0,
            previousNPC = nil
        },
        
        -- Available quests for this NPC
        quests = {
            -- Quest definitions here
        }
    }
}
```

#### NPC Configuration Options:

| Option | Type | Description |
|--------|------|-------------|
| `id` | String | Unique identifier for this NPC |
| `name` | String | Display name of the quest giver |
| `model` | String | Ped model hash for the NPC |
| `coords` | Vector3 | XYZ coordinates for NPC location |
| `heading` | Float | Direction NPC faces (0-360) |
| `blip.enabled` | Boolean | Show this NPC on map |
| `blip.sprite` | String | Blip icon to use |
| `blip.scale` | Float | Size of blip on map |
| `blip.color` | String | Blip color modifier |
| `unlockRequirements.level` | Integer | Player level required to unlock |
| `unlockRequirements.previousNPC` | String | ID of NPC that must be unlocked first |
| `quests` | Table | Array of quest definitions |

### Quest Structure

Each quest within an NPC configuration:

```lua
{
    id = 'easy_bounty_1',
    name = 'Wanted: Petty Thief',
    description = 'Track down a petty criminal causing trouble.',
    difficulty = 'easy', -- 'easy', 'medium', 'hard', 'legendary'
    
    targetLocation = vector3(100.0, 200.0, 50.0),
    searchRadius = 100.0,
    
    targetPed = {
        model = 's_m_m_unidustadores_01',
        weapon = 'WEAPON_PISTOL_VOLCANIC',
        accuracy = 10,
        health = 100
    },
    
    guards = {
        enabled = true,
        count = 2,
        models = {'A_C_DogBluetickCoonhound_01'},
        spawnRadius = 20.0
    },
    
    rewards = {
        xp = 50,
        cash = 25.0,
        items = {}
    }
}
```

---

## 💰 Rewards & Economy

### XP System

```lua
Config.XPSystem = {
    enabled = true,
    startingLevel = 0,
    maxLevel = 50,
    
    xpPerLevel = 100, -- Base XP required per level
    xpScaling = 1.15, -- Multiplier per level (exponential growth)
    
    -- XP Rewards by Difficulty
    xpRewards = {
        easy = 50,
        medium = 125,
        hard = 250,
        legendary = 500
    }
}
```

#### XP System Options:

| Setting | Type | Description |
|---------|------|-------------|
| `enabled` | Boolean | Enable XP and leveling system |
| `startingLevel` | Integer | Level new players start at |
| `maxLevel` | Integer | Maximum achievable level |
| `xpPerLevel` | Integer | Base XP needed for level 1→2 |
| `xpScaling` | Float | XP multiplier per level (e.g., 1.15 = +15% per level) |
| `xpRewards` | Table | XP earned per difficulty tier |

### Cash Rewards

```lua
Config.Rewards = {
    cashMultiplier = 1.0, -- Global cash reward multiplier
    
    baseCash = {
        easy = 25.0,
        medium = 75.0,
        hard = 150.0,
        legendary = 300.0
    },
    
    bonusRewards = {
        quickCompletion = 0.25, -- +25% for completing under 50% time limit
        noDeaths = 0.15, -- +15% for not dying
        headshot = 0.20 -- +20% for headshot kill
    }
}
```

### Item Rewards

Items are granted based on quest completion and can include weapons, consumables, or custom items.

```lua
itemRewards = {
    {item = 'weapon_lasso', label = 'Reinforced Lasso', chance = 100},
    {item = 'consumable_medicine', label = 'Medicine', amount = 3, chance = 75},
    {item = 'ammo_revolver', label = 'Revolver Ammo', amount = 20, chance = 50}
}
```

---

## ⏱️ Cooldowns & Timing

### Config.Cooldowns

Controls quest pacing and prevents spam.

```lua
Config.Cooldowns = {
    -- Global cooldown between quests (in minutes)
    GlobalCooldown = 15,
    
    -- Cooldown per quest difficulty (in minutes)
    EasyQuestCooldown = 10,
    MediumQuestCooldown = 20,
    HardQuestCooldown = 30,
    LegendaryQuestCooldown = 60,
    
    -- Time limit to complete a quest (in minutes)
    QuestTimeLimit = 45,
    
    -- Reward collection timeout (in minutes)
    RewardCollectionTimeout = 120
}
```

#### Cooldown Configuration:

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `GlobalCooldown` | Integer | 15 | Minutes between any quests |
| `EasyQuestCooldown` | Integer | 10 | Additional cooldown for easy quests |
| `MediumQuestCooldown` | Integer | 20 | Additional cooldown for medium quests |
| `HardQuestCooldown` | Integer | 30 | Additional cooldown for hard quests |
| `LegendaryQuestCooldown` | Integer | 60 | Additional cooldown for legendary quests |
| `QuestTimeLimit` | Integer | 45 | Minutes to complete before quest fails |
| `RewardCollectionTimeout` | Integer | 120 | Minutes to collect rewards before expiration |

**Cooldown Logic:**
- Global cooldown applies to ALL quests
- Difficulty-specific cooldowns stack on top of global cooldown
- Example: Easy quest = 10 + 15 = 25 minutes total cooldown

---

## 🔒 Security Settings

### Resource Name Protection

The script includes built-in protection to prevent unauthorized redistribution.

```lua
local REQUIRED_RESOURCE_NAME = "lxr-bounty-quests"
local currentResourceName = GetCurrentResourceName()

if currentResourceName ~= REQUIRED_RESOURCE_NAME then
    error("Resource name mismatch - must be named 'lxr-bounty-quests'")
end
```

**Security Features:**
- ✅ Resource name validation
- ✅ Server-side validation for all rewards
- ✅ Anti-cheat for quest completion
- ✅ Cooldown enforcement server-side
- ✅ Data integrity checks

### Server-Side Validation

All critical operations are validated server-side:
- Quest start requests
- Quest completion verification
- Reward distribution
- XP and level updates
- Cooldown enforcement

**Best Practices:**
1. Never modify server-side validation code
2. Keep debug mode OFF in production
3. Regularly audit server logs
4. Monitor for suspicious quest completions
5. Use framework permissions where applicable

---

## ⚡ Performance Settings

### Optimization Configuration

```lua
Config.Performance = {
    -- NPC Update Frequency
    npcUpdateRate = 1000, -- milliseconds (1 second)
    
    -- Distance Checks
    interactionDistance = 3.0, -- Distance to show prompts
    npcRenderDistance = 150.0, -- Distance to render NPCs
    
    -- Thread Management
    enableThreadOptimization = true,
    reducedTickRate = 500, -- ms for non-critical threads
    
    -- Memory Management
    cleanupInterval = 300000, -- 5 minutes
    maxCachedQuests = 10
}
```

#### Performance Options:

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `npcUpdateRate` | Integer | 1000 | Milliseconds between NPC updates |
| `interactionDistance` | Float | 3.0 | Distance to show interaction prompts |
| `npcRenderDistance` | Float | 150.0 | Distance to render quest NPCs |
| `enableThreadOptimization` | Boolean | true | Use optimized thread management |
| `reducedTickRate` | Integer | 500 | Tick rate for background threads |
| `cleanupInterval` | Integer | 300000 | Memory cleanup interval (ms) |
| `maxCachedQuests` | Integer | 10 | Maximum quests cached in memory |

**Performance Tips:**
- 🚀 Increase tick rates if server is under-performing
- 🎯 Reduce render distances on high-population servers
- 💾 Lower max cached quests to reduce memory usage
- ⚡ Enable thread optimization for better FPS

---

## 🐛 Debug Options

### Config.EnableDebug

Enable comprehensive debug logging for troubleshooting.

```lua
Config.EnableDebug = false -- Set to true for debug mode
```

When enabled, debug mode provides:
- 📊 Console logging for all major events
- 🔍 Quest state tracking
- 📡 Framework detection details
- ⚠️ Error stack traces
- 🎯 NPC spawn confirmations
- 💰 Reward calculation breakdowns

**Debug Console Output Examples:**
```
[LXR-Quests] Framework detected: lxrcore
[LXR-Quests] Player accepted quest: easy_bounty_1
[LXR-Quests] Target spawned at: 100.0, 200.0, 50.0
[LXR-Quests] Quest completed - Rewards: $25.00, 50 XP
```

**Warning:** Debug mode can spam console logs. Only enable when troubleshooting issues.

---

## 📝 Configuration Best Practices

### Recommended Settings

**For Small Servers (< 32 players):**
```lua
Config.Cooldowns.GlobalCooldown = 10
Config.Performance.npcUpdateRate = 500
Config.Performance.npcRenderDistance = 200.0
```

**For Large Servers (> 32 players):**
```lua
Config.Cooldowns.GlobalCooldown = 20
Config.Performance.npcUpdateRate = 1000
Config.Performance.npcRenderDistance = 100.0
Config.Performance.maxCachedQuests = 5
```

**For Economy-Focused Servers:**
```lua
Config.Rewards.cashMultiplier = 0.75
Config.XPSystem.xpScaling = 1.25
Config.Cooldowns.GlobalCooldown = 30
```

**For Casual/Fast-Paced Servers:**
```lua
Config.Rewards.cashMultiplier = 1.5
Config.XPSystem.xpScaling = 1.1
Config.Cooldowns.GlobalCooldown = 5
```

### Configuration Validation

After modifying config.lua:

1. ✅ Restart the resource: `/restart lxr-bounty-quests`
2. ✅ Check console for errors
3. ✅ Test quest acceptance and completion
4. ✅ Verify rewards are distributed correctly
5. ✅ Confirm cooldowns are working

---

## 🆘 Troubleshooting Configuration Issues

### Common Issues

**Issue:** Resource won't start - "Resource name mismatch"
- **Solution:** Ensure folder is named exactly `lxr-bounty-quests`

**Issue:** Framework not detected
- **Solution:** Check `Config.Framework` is set to correct value or 'auto'

**Issue:** NPCs not spawning
- **Solution:** Verify NPC coordinates and model hashes are correct

**Issue:** Rewards not given
- **Solution:** Enable debug mode and check console for reward calculation

**Issue:** High server CPU usage
- **Solution:** Increase tick rates and reduce render distances

---

## 📚 Additional Resources

- 📖 [Installation Guide](./installation.md)
- 🔧 [Framework Integration](./frameworks.md)
- 🎯 [Events & API Reference](./events.md)
- 🔒 [Security Guide](./security.md)
- ⚡ [Performance Optimization](./performance.md)

---

## 🐺 Server Information

**The Land of Wolves - Georgian RP Server**

🇬🇪 **მგლების მიწა - რჩეულთა ადგილი!**
*ისტორია ცოცხლდება აქ! (History Lives Here!)*

- 🌐 **Website:** [wolves.land](https://www.wolves.land)
- 💬 **Discord:** [Join our community](https://discord.gg/CrKcWdfd3A)
- 🛒 **Store:** [theluxempire.tebex.io](https://theluxempire.tebex.io)
- 📡 **Server Listing:** [RedM Server](https://servers.redm.net/servers/detail/8gj7eb)
- 💻 **Developer:** iBoss21 / The Lux Empire

---

*© 2025 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved*
