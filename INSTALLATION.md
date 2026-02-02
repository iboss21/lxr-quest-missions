# 🐺 Quick Installation Guide - Land of Wolves Bounty Quests

## Prerequisites
- RedM Server (latest version)
- MySQL/MariaDB database
- One of the supported frameworks (LXRCore, RSG, VORP, RedEM:RP, QBR, QR) or Standalone
- oxmysql or equivalent database resource

## Installation Steps

### 1. Download and Extract
```bash
# Place the lxr-bounty-quests folder in your resources directory
server-data/resources/[land-of-wolves]/lxr-bounty-quests/
```

### 2. Database Setup
```sql
-- Execute the SQL file in your database
-- File: lxr-bounty-quests/sql/install.sql
-- This creates 4 tables:
-- - lxr_bounty_player_quests
-- - lxr_bounty_quest_progress
-- - lxr_bounty_shop_purchases
-- - lxr_bounty_cooldowns
```

**Using HeidiSQL:**
1. Open HeidiSQL
2. Connect to your database
3. Go to Tools > Load SQL file
4. Select `install.sql`
5. Click Execute

**Using phpMyAdmin:**
1. Open phpMyAdmin
2. Select your database
3. Click Import tab
4. Choose file: `install.sql`
5. Click Go

**Using Command Line:**
```bash
mysql -u username -p database_name < lxr-bounty-quests/sql/install.sql
```

### 3. Configure the Script

Edit `lxr-bounty-quests/config.lua`:

```lua
-- Framework (usually auto-detects)
Config.Framework = 'auto' -- or 'lxrcore', 'rsg-core', 'vorp', etc.

-- Language
Config.Lang = 'English' -- or 'Georgian'

-- Enable/Disable Features
Config.EnableQuests = true
Config.EnableDebug = false -- Set to true for testing
Config.EnableBlips = true

-- Adjust cooldowns (in minutes)
Config.Cooldowns = {
    GlobalCooldown = 15,
    EasyQuestCooldown = 10,
    MediumQuestCooldown = 20,
    HardQuestCooldown = 30,
    LegendaryQuestCooldown = 60,
}

-- Adjust rewards
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

### 4. Add to server.cfg

```cfg
# Ensure your framework first
ensure lxr-core  # or rsg-core, vorp_core, redem_roleplay, qbr-core, qr-core

# Ensure database resource
ensure oxmysql

# Ensure the bounty quests script
ensure lxr-bounty-quests
```

### 5. Add Items to Inventory (Framework-Dependent)

#### For VORP:
```sql
-- Items are in the SQL file comments
-- Add them to your vorp_inventory items table
```

#### For RSG/QBR:
```lua
-- Add to shared/items.lua or your items configuration
['bounty_poster'] = {
    ['name'] = 'bounty_poster',
    ['label'] = 'Bounty Poster',
    ['weight'] = 50,
    ['type'] = 'item',
    ['image'] = 'bounty_poster.png',
    ['unique'] = false,
    ['useable'] = true,
    ['shouldClose'] = true,
    ['description'] = 'A wanted poster for a dangerous criminal'
},
```

### 6. Restart Server

```bash
# In server console
refresh
restart lxr-bounty-quests

# Or restart entire server
```

### 7. Test the Script

1. Join your server
2. Look for bounty quest blips on the map
3. Go to Valentine Sheriff's Office (-275.71, 805.01, 118.39)
4. Press SPACE near the sheriff to open quest menu
5. Accept an easy quest to test functionality

## Verification Checklist

- [ ] Database tables created successfully
- [ ] Script loads without errors (check F8 console)
- [ ] Framework detected correctly (check server console)
- [ ] Blips appear on map
- [ ] Can interact with quest NPCs
- [ ] Can accept quests
- [ ] Quest objectives appear
- [ ] Rewards are given correctly
- [ ] Statistics are tracked in database

## Troubleshooting

### Script Not Loading
```bash
# Check server console for errors
# Enable debug mode in config.lua
Config.EnableDebug = true
```

### Database Errors
```bash
# Verify oxmysql is running
ensure oxmysql

# Check database connection in server.cfg
set mysql_connection_string "mysql://user:password@localhost/database"
```

### Framework Not Detected
```lua
-- In config.lua, manually set framework
Config.Framework = 'vorp' -- or your framework
```

### NPCs Not Spawning
```lua
-- Check NPC coordinates in config.lua
-- Verify you're in the correct location
-- Check if model hashes are valid for RedM
```

### Rewards Not Working
```bash
# Check framework integration
# Verify AddMoney and AddItem functions
# Check inventory system compatibility
```

## Support

- **Discord**: https://discord.gg/CrKcWdfd3A
- **GitHub**: https://github.com/iBoss21
- **Website**: https://www.wolves.land

## Common Customizations

### Change NPC Locations
Edit `Config.QuestNPCs` in config.lua:
```lua
{
    id = 'my_custom_npc',
    name = 'My Sheriff',
    coords = vector4(x, y, z, heading),
    -- ... other settings
}
```

### Add More Quests
Edit `Config.Quests` in config.lua:
```lua
{
    id = 'my_custom_quest',
    difficulty = 'medium',
    title = 'My Custom Quest',
    description = 'Description here',
    targetModel = 'G_M_M_UniCriminals_01',
    targetName = 'Bad Guy',
    location = vector3(x, y, z),
    rewardMultiplier = 1.0,
}
```

### Adjust Difficulty
```lua
-- In config.lua
Config.TargetNPCs = {
    HealthMultipliers = {
        Easy = 1.0,    -- Make harder: 1.5
        Medium = 1.5,  -- Make harder: 2.0
        Hard = 2.0,    -- Make harder: 3.0
        Legendary = 3.0, -- Make harder: 5.0
    }
}
```

---

## 🐺 The Land of Wolves

**Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!**

*ისტორია ცოცხლდება აქ! (History Lives Here!)*

© 2026 iBoss21 / The Lux Empire | All Rights Reserved
