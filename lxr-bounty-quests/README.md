# 🐺 Land of Wolves - Bounty Quests System 2.0

<div align="center">

![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)
![RedM](https://img.shields.io/badge/RedM-Compatible-red.svg)
![License](https://img.shields.io/badge/license-Custom-orange.svg)

**Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!**

*ისტორია ცოცხლდება აქ! (History Lives Here!)*

[Website](https://www.wolves.land) • [Discord](https://discord.gg/CrKcWdfd3A) • [Store](https://theluxempire.tebex.io) • [Server](https://servers.redm.net/servers/detail/8gj7eb)

</div>

---

## 📖 Description

**Land of Wolves Bounty Quests 2.0** is a comprehensive RedM script that allows players to become bounty hunters, tracking down dangerous criminals, completing quests, earning rewards, and unlocking new content. Built specifically for The Land of Wolves server with extensive RPG mechanics and progression systems.

### 🌟 Key Features

- **🎯 Multiple Quest NPCs** - 6 unique quest givers across the map with individual requirements
- **📊 RPG Progression System** - Level up, earn XP, and unlock harder quests and better rewards
- **🐺 Animal Guards** - Face dangerous wolves, bears, panthers, and more protecting targets
- **💰 Dynamic Economy** - Earn money, gold, and items based on performance
- **🎁 Weapon Bonuses** - Extra rewards for using specific weapons (pistols, rifles, melee, lasso)
- **🛒 NPC Shops** - Unlock exclusive shops with powerful equipment
- **⏱️ Cooldown System** - Balanced gameplay with configurable cooldowns
- **🎲 4 Difficulty Levels** - Easy, Medium, Hard, and Legendary quests
- **🏆 Bonus Rewards** - Headshots, stealth, speed, and melee kill bonuses
- **📈 Statistics Tracking** - Comprehensive player statistics and leaderboards
- **🔧 Highly Configurable** - Over 500 configuration options for complete customization
- **🌐 Multi-Framework** - Supports LXRCore, RSG, VORP, RedEM:RP, QBR, QR, and Standalone

---

## 📋 Table of Contents

- [Features](#-features)
- [Dependencies](#-dependencies)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [Framework Support](#-framework-support)
- [Quest System](#-quest-system)
- [Economy & Rewards](#-economy--rewards)
- [NPC Shops](#-npc-shops)
- [Commands](#-commands)
- [Database Structure](#-database-structure)
- [Performance](#-performance)
- [Support](#-support)
- [Credits](#-credits)
- [License](#-license)

---

## ✨ Features

### Core Features

#### 🎯 Quest System
- **Multiple Quest NPCs**: 6 different quest givers across the map (Valentine, Strawberry, Rhodes, Saint Denis, Blackwater, Tumbleweed)
- **Progressive Unlocking**: Complete quests to unlock new NPCs and harder challenges
- **Quest Requirements**: Level, previous quest completion, and job requirements
- **Quest Tracking**: Real-time objective tracking and distance display
- **Time Limits**: Complete quests within time limits or they expire
- **Quest Cooldowns**: Global and difficulty-specific cooldowns prevent quest spam

#### 💪 Combat System
- **Dynamic Target NPCs**: Targets with scaled health, accuracy, and combat behavior
- **Human Guards**: 1-8 guards depending on difficulty with intelligent AI
- **Animal Guards**: Wolves, bears, panthers, cougars, alligators protecting targets
- **Combat Behaviors**: NPCs use cover, call for help, and flee when injured
- **Weapon Loadouts**: Different weapon sets for each difficulty level

#### 📊 Progression System
- **XP & Leveling**: Earn XP from completing quests to level up
- **Level Requirements**: Higher level unlocks harder quests and better shops
- **Reputation System**: Build reputation as a bounty hunter
- **Statistics Tracking**: Track all your accomplishments and progress

#### 💰 Economy & Rewards
- **Base Rewards**: Scaled by quest difficulty
- **Weapon Bonuses**: Extra money for using specific weapons
- **Combat Bonuses**: Headshot, melee, stealth, and speed bonuses
- **Item Rewards**: Chance to receive additional items (consumables, ammo, valuables)
- **Perfect Completion**: 2x rewards for perfect execution

#### 🛒 Shop System
- **6 Unique Shops**: Each NPC has their own shop with different items
- **Progressive Items**: Better items unlock at higher levels
- **Weapons & Ammo**: Purchase bounty hunting equipment
- **Consumables**: Medicines and supplies
- **Exclusive Items**: Legendary shops with rare items

#### 🐺 Animal Guards System
- **7 Animal Types**: Wolves, timber wolves, black bears, grizzly bears, panthers, cougars, alligators
- **Scaled Difficulty**: More animals and tougher variants at higher difficulties
- **Unique Behaviors**: Each animal type has different health, damage, and speed
- **Dynamic Spawning**: 10-75% chance based on quest difficulty

---

## 🔧 Dependencies

### Required
- **RedM Server** (Latest version recommended)
- **One of the following frameworks:**
  - LXRCore (Primary - The Land of Wolves)
  - RSG Core
  - VORP Core
  - RedEM:RP
  - QBR Core (QB-Core for RedM)
  - QR Core
  - Standalone mode (no framework)

### Recommended
- **Database Resource** (one of):
  - oxmysql (recommended)
  - ghmattimysql
  - mysql-async

### Optional
- **Inventory System** (framework-dependent)
- **Phone/Notification System** (framework-dependent)

---

## 📥 Installation

### 1. Download & Extract
```bash
# Download the resource
# Extract to your server resources folder
server-data/resources/[land-of-wolves]/lxr-bounty-quests
```

### 2. Database Setup
```bash
# Import the SQL file to your database
# File location: sql/install.sql
```

Execute the SQL file in your database:
- **HeidiSQL**: Tools > Load SQL file
- **phpMyAdmin**: Import > Choose file
- **Command Line**: `mysql -u username -p database_name < install.sql`

### 3. Framework Configuration

#### For LXRCore / RSG Core:
```lua
-- No additional configuration needed
-- The script will auto-detect your framework
```

#### For VORP:
```lua
-- Add items to your VORP inventory
-- Items are included in the SQL file comments
```

#### For RedEM:RP:
```lua
-- Configure in your RedEM:RP config
-- Items should be added to your items database
```

#### For Standalone:
```lua
-- The script will work without a framework
-- You may need to configure economy functions
```

### 4. Server Configuration
Add to your `server.cfg`:
```cfg
# Ensure your framework first
ensure lxr-core  # or rsg-core, vorp_core, redem_roleplay, etc.

# Ensure the database resource
ensure oxmysql

# Ensure the bounty quests script
ensure lxr-bounty-quests
```

### 5. Configure the Script
Edit `config.lua` to customize:
- Framework settings
- Quest locations and rewards
- NPC positions
- Shop items and prices
- Cooldown timers
- XP and level requirements
- Combat settings

### 6. Restart Server
```bash
# Restart your server or refresh the resource
refresh
restart lxr-bounty-quests
```

---

## ⚙️ Configuration

The script is **highly configurable** with over 500 options. Key configuration sections:

### Server Branding
```lua
Config.ServerInfo = {
    name = 'The Land of Wolves 🐺',
    website = 'https://www.wolves.land',
    discord = 'https://discord.gg/CrKcWdfd3A',
    -- ... more settings
}
```

### Framework
```lua
Config.Framework = 'auto' -- Auto-detect or specify: 'lxrcore', 'rsg-core', 'vorp', etc.
```

### Cooldowns
```lua
Config.Cooldowns = {
    GlobalCooldown = 15, -- 15 minutes between quests
    EasyQuestCooldown = 10,
    MediumQuestCooldown = 20,
    HardQuestCooldown = 30,
    LegendaryQuestCooldown = 60,
    QuestTimeLimit = 45, -- 45 minutes to complete
}
```

### XP System
```lua
Config.XPSystem = {
    Enabled = true,
    EasyQuestXP = 50,
    MediumQuestXP = 100,
    HardQuestXP = 200,
    LegendaryQuestXP = 500,
    Bonuses = {
        HeadshotBonus = 1.25,  -- 25% bonus
        MeleeBonus = 1.5,      -- 50% bonus
        NoAlertBonus = 1.3,    -- 30% bonus
        TimeBonus = 1.2,       -- 20% bonus
        PerfectBonus = 2.0,    -- 100% bonus (doubles rewards)
    }
}
```

### Economy
```lua
Config.Economy = {
    Currency = 'money',
    BaseRewards = {
        Easy = {min = 25, max = 50},
        Medium = {min = 75, max = 150},
        Hard = {min = 200, max = 350},
        Legendary = {min = 500, max = 1000},
    }
}
```

### NPC Health & Combat
```lua
Config.TargetNPCs = {
    HealthMultipliers = {
        Easy = 1.0,
        Medium = 1.5,
        Hard = 2.0,
        Legendary = 3.0,
    },
    Accuracy = {
        Easy = 0.3,
        Medium = 0.5,
        Hard = 0.7,
        Legendary = 0.9,
    }
}
```

### Animal Guards
```lua
Config.AnimalGuards = {
    Enabled = true,
    SpawnChance = {
        Easy = 0.1,      -- 10%
        Medium = 0.25,   -- 25%
        Hard = 0.5,      -- 50%
        Legendary = 0.75 -- 75%
    }
}
```

---

## 🎮 Quest System

### Quest Flow
1. **Visit Quest NPC** - Find a quest giver on the map (marked with blip)
2. **Check Requirements** - Ensure you meet level and prerequisite requirements
3. **Accept Quest** - Choose from available difficulty levels
4. **Travel to Location** - Quest location is marked on your map
5. **Eliminate Target** - Fight through guards and kill the target
6. **Identify Target** - Confirm the target to complete the objective
7. **Return to NPC** - Collect your rewards from the quest giver

### Quest Difficulties

| Difficulty | Level Req | Guards | Animal Guards | Base Reward | Cooldown |
|-----------|-----------|---------|---------------|-------------|----------|
| ⚪ Easy | 0 | 1-2 | 10% chance | $25-50 | 10 min |
| 🟡 Medium | 5 | 2-4 | 25% chance | $75-150 | 20 min |
| 🔴 Hard | 10 | 4-6 | 50% chance | $200-350 | 30 min |
| 🟣 Legendary | 20 | 6-8 | 75% chance | $500-1000 | 60 min |

### Quest NPCs

1. **Valentine - Sheriff Curtis Malloy**
   - Level Required: 0
   - Quests: Easy, Medium
   - Location: Sheriff's Office

2. **Strawberry - Marshal Thomas Huxley**
   - Level Required: 5
   - Quests: Easy, Medium, Hard
   - Location: Town Marshal Office

3. **Rhodes - Sheriff Gray**
   - Level Required: 10
   - Quests: Medium, Hard
   - Location: Sheriff's Office

4. **Saint Denis - Chief Inspector Archibald**
   - Level Required: 15
   - Quests: Hard, Legendary
   - Location: Police Department

5. **Blackwater - Marshal Davis**
   - Level Required: 20
   - Quests: Legendary
   - Location: Law Office

6. **Tumbleweed - Bounty Hunter Morgan**
   - Level Required: 25
   - Quests: Legendary
   - Location: Desert Outpost

---

## 💰 Economy & Rewards

### Base Rewards
Rewards are scaled based on quest difficulty and include:
- **Money** - Main currency reward
- **Gold** - Bonus currency (framework-dependent)
- **XP** - Experience points for leveling
- **Items** - Random chance for additional items

### Weapon Bonuses
Earn extra money for using specific weapons:

| Weapon Type | Bonus |
|------------|-------|
| Lasso (Capture Alive) | $100 |
| Tomahawk | $75 |
| Throwing Knives | $60 |
| Sniper Rifles | $50 |
| Knife/Machete | $50 |
| Bow (Improved) | $50 |
| Shotguns | $20-30 |
| Rifles | $15-30 |
| Pistols/Revolvers | $10-25 |

### Performance Bonuses

| Bonus Type | Multiplier | Description |
|-----------|-----------|-------------|
| Headshot | +25% | Kill target with headshot |
| Melee | +50% | Kill target with melee weapon |
| Stealth | +30% | Complete without alerting guards |
| Speed | +20% | Complete in under 50% time limit |
| Perfect | +100% | Achieve all bonuses above |

### Item Rewards
30% chance to receive additional items:
- **Common**: Meat, coffee, basic ammo
- **Uncommon**: Medicine, shotgun ammo, pocket watches
- **Rare**: Gold bars, jewelry, special ammo

---

## 🛒 NPC Shops

Each quest NPC has their own shop with unique items:

### Valentine Bounty Shop (Level 0)
- Cattleman Revolver
- Basic ammo
- Medicine
- Reinforced Lasso

### Strawberry Bounty Supplies (Level 5)
- Schofield Revolver
- Bolt Action Rifle
- Potent Medicine

### Rhodes Bounty Equipment (Level 10)
- Pump Shotgun
- Springfield Rifle
- Hunting Knife
- Elephant Rifle Ammo

### Saint Denis Police Armory (Level 15)
- Mauser Pistol
- Rolling Block Rifle
- Repeating Shotgun
- Special Medicine

### Blackwater Elite Equipment (Level 20)
- Semi-Auto Pistol
- Carcano Rifle
- Improved Bow
- Tomahawk

### Tumbleweed Legendary Supplies (Level 25)
- Legendary weapons
- Gold bars
- Special sniper ammo
- Bulk medicine

---

## 📝 Commands

### Player Commands
```
/bountyhelp - Show help information
/bountystats - View your statistics
/bountyquests - Show available quests
/bountycancel - Cancel current quest
```

### Admin Commands (if implemented)
```
/bountyadmin - Admin menu
/bountyreset [id] - Reset player progress
/bountysetlevel [id] [level] - Set player level
```

---

## 🗄️ Database Structure

### Tables

#### `lxr_bounty_player_quests`
Stores player progression and statistics:
- Total quests completed by difficulty
- Current level and XP
- Money and gold earned
- Reputation
- Unlocked NPCs and shops

#### `lxr_bounty_quest_progress`
Tracks active and historical quests:
- Quest status (active, completed, failed)
- Combat statistics
- Rewards earned
- Completion time

#### `lxr_bounty_shop_purchases`
Records shop transactions:
- Items purchased
- Prices paid
- Purchase timestamps

#### `lxr_bounty_cooldowns`
Manages cooldown timers:
- Global and difficulty-specific cooldowns
- Expiration timestamps

### Views

#### `lxr_bounty_leaderboard`
Pre-built leaderboard view showing:
- Top 100 players by XP
- Quest completion stats
- Total earnings

---

## ⚡ Performance

### Optimization Features
- **Efficient database queries** - Indexed tables and optimized queries
- **Lazy loading** - Only loads data when needed
- **Client-side caching** - Reduces server calls
- **Configurable update intervals** - Balance between accuracy and performance
- **Cleanup routines** - Automatic cleanup of old data

### Resource Usage
- **Idle**: 0.00-0.01 ms
- **Active Quest**: 0.02-0.05 ms
- **Combat**: 0.05-0.10 ms

### Best Practices
1. Adjust `Config.AdvancedFeatures.QuestTracking.UpdateInterval` for your server population
2. Use database cleanup routines regularly
3. Monitor animal guard spawn rates on high-population servers
4. Configure cooldowns to balance gameplay and server load

---

## 🐛 Troubleshooting

### Common Issues

**Quest NPCs not showing on map:**
- Check `Config.EnableBlips = true`
- Verify NPC coordinates in config
- Ensure framework is properly detected

**Database errors:**
- Verify SQL file was imported correctly
- Check database credentials
- Ensure oxmysql or equivalent is running

**Rewards not working:**
- Check framework inventory integration
- Verify item names match your inventory system
- Review console for errors

**Combat not working:**
- Check NPC weapon hashes are valid
- Verify framework combat systems are active
- Review Config.TargetNPCs settings

---

## 💬 Support

### Getting Help

1. **Discord**: Join our [Discord server](https://discord.gg/CrKcWdfd3A)
2. **GitHub**: Open an issue on [GitHub](https://github.com/iBoss21)
3. **Documentation**: Check this README thoroughly
4. **Website**: Visit [wolves.land](https://www.wolves.land)

### Before Asking for Help
- Read this entire README
- Check console for errors (F8)
- Verify all dependencies are installed
- Ensure configuration is correct
- Try with debug mode enabled: `Config.EnableDebug = true`

---

## 🏆 Credits

### Development
- **iBoss21** - Script development, Land of Wolves branding
- **The Lux Empire** - Development team

### Inspiration
- **RicX Bounty Quests** - Original concept inspiration
- **The Land of Wolves Community** - Testing and feedback

### Special Thanks
- RedM community for resources and support
- Framework developers (LXRCore, RSG, VORP, RedEM:RP)
- The Land of Wolves players for continuous feedback

---

## 📜 License

© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved

This script is branded for **The Land of Wolves** server and is protected by custom licensing:

### ✅ Allowed
- Use on The Land of Wolves server
- Personal modifications for your server
- Configuration changes

### ❌ Not Allowed
- Redistribution or resale
- Rebranding or removing credits
- Public sharing of code
- Commercial use without permission

### Resource Name Protection
This resource **must** be named `lxr-bounty-quests` - it will not function if renamed. This is intentional to protect the branding and intellectual property.

For licensing inquiries, contact: [Discord](https://discord.gg/CrKcWdfd3A) | [Store](https://theluxempire.tebex.io)

---

<div align="center">

### 🐺 The Land of Wolves

**Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!**

*ისტორია ცოცხლდება აქ! (History Lives Here!)*

[Join Our Server](https://servers.redm.net/servers/detail/8gj7eb) • [Discord Community](https://discord.gg/CrKcWdfd3A) • [Visit wolves.land](https://www.wolves.land)

**Server Type**: Serious Hardcore Roleplay • Whitelisted • Discord Required

---

Made with ❤️ by **iBoss21 / The Lux Empire**

© 2026 All Rights Reserved

</div>
