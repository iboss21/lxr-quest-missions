# 🐺 LXR Quest Missions - Framework Integration Guide

```
███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗███████╗
██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██╔════╝
█████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ███████╗
██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ╚════██║
██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗███████║
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
```

**🐺 The Land of Wolves - Multi-Framework Integration**

**Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!**

---

## 📖 Table of Contents

1. [Overview](#overview)
2. [Auto-Detection System](#auto-detection-system)
3. [LXR-Core Setup](#lxr-core-setup)
4. [RSG-Core Setup](#rsg-core-setup)
5. [VORP Setup](#vorp-setup)
6. [RedEM:RP Setup](#redemrp-setup)
7. [QBR/QR Core Setup](#qbrqr-core-setup)
8. [Standalone Mode](#standalone-mode)
9. [Framework Adapter Layer](#framework-adapter-layer)
10. [Custom Framework Integration](#custom-framework-integration)

---

## 🌟 Overview

LXR Quest Missions features a **universal framework adapter system** that allows seamless integration with multiple RedM frameworks. The system automatically detects your framework and configures itself accordingly, requiring minimal setup.

### Supported Frameworks

| Framework | Status | Priority | Auto-Detect |
|-----------|--------|----------|-------------|
| **LXR-Core** | ✅ Primary | 1 | Yes |
| **RSG-Core** | ✅ Primary | 2 | Yes |
| **QBR Core** | ✅ Supported | 3 | Yes |
| **QR Core** | ✅ Supported | 4 | Yes |
| **VORP Core** | ✅ Legacy | 5 | Yes |
| **RedEM:RP** | ✅ Legacy | 6 | Yes |
| **Standalone** | ✅ Fallback | 7 | Yes |

### Key Features

- 🔄 **Automatic Framework Detection** - No manual configuration needed
- 🎯 **Priority-Based Loading** - Detects multiple frameworks and uses the highest priority
- 🛡️ **Fallback System** - Works in standalone mode if no framework is detected
- ⚡ **Zero Performance Impact** - Framework adapter adds negligible overhead
- 🔧 **Easy Configuration** - Override auto-detection with simple config option

---

## 🔍 Auto-Detection System

### How It Works

The framework adapter checks for each supported framework in priority order:

```lua
1. Check for LXR-Core
2. Check for RSG-Core
3. Check for QBR Core
4. Check for QR Core
5. Check for VORP Core
6. Check for RedEM:RP
7. Fall back to Standalone mode
```

### Configuration

```lua
-- In config.lua
Config.Framework = 'auto' -- Let the system auto-detect
```

**Available Options:**
- `'auto'` - Automatic detection (recommended)
- `'lxrcore'` - Force LXR-Core
- `'rsg-core'` - Force RSG-Core
- `'qbr-core'` - Force QBR Core
- `'qr-core'` - Force QR Core
- `'vorp'` - Force VORP
- `'redemrp'` - Force RedEM:RP
- `'standalone'` - Force standalone mode

### Detection Process

On resource start, the adapter:

1. ✅ Checks if framework resource is started
2. ✅ Validates framework exports are available
3. ✅ Verifies required events exist
4. ✅ Loads framework-specific configuration
5. ✅ Initializes adapter functions

**Console Output:**
```
[LXR-Quests] Framework Detection: Checking for frameworks...
[LXR-Quests] Framework Detection: LXR-Core detected and loaded
[LXR-Quests] Using notification system: lxr
[LXR-Quests] Framework adapter initialized successfully
```

---

## 🏆 LXR-Core Setup

### About LXR-Core

**LXR-Core** is the custom framework developed for The Land of Wolves server. It's optimized for Georgian RP and serious roleplay environments.

- 🔗 **GitHub:** [github.com/lxrcore](https://github.com/lxrcore)
- 🐺 **Server:** The Land of Wolves
- 🎯 **Focus:** Hardcore RP, Georgian culture

### Prerequisites

1. Install LXR-Core framework
2. Ensure LXR-Core is started before this resource
3. Configure database connection in LXR-Core

### Configuration

```lua
Config.FrameworkSettings.lxrcore = {
    enabled = true,
    resource = 'lxr-core',
    exportName = 'lxr-core',
    getSharedObject = 'lxr-core:getSharedObject',
    playerLoaded = 'LXR:Client:OnPlayerLoaded',
    playerUnloaded = 'LXR:Client:OnPlayerUnload',
    jobUpdate = 'LXR:Client:OnJobUpdate',
    notification = 'lxr'
}
```

### Integration Features

**What Works Automatically:**
- ✅ Player data retrieval
- ✅ Money management (cash/bank)
- ✅ Item giving/removing
- ✅ Job/gang checks
- ✅ Notification system
- ✅ Player status (hunger, thirst, stress)

### Example Usage

```lua
-- Server-side
local Player = FrameworkAdapter.GetPlayer(source)
if Player then
    FrameworkAdapter.AddMoney(source, 'cash', 100)
    FrameworkAdapter.AddItem(source, 'weapon_lasso', 1)
end

-- Client-side
RegisterNetEvent('LXR:Client:OnPlayerLoaded', function()
    -- Initialize quest system when player loads
    InitializeQuestSystem()
end)
```

### Server.cfg

```cfg
ensure lxr-core
ensure lxr-bounty-quests
```

---

## 🎮 RSG-Core Setup

### About RSG-Core

**RSG-Core** is a popular open-source RedM framework developed by Rexshack Gaming.

- 🔗 **GitHub:** [github.com/Rexshack-RedM](https://github.com/Rexshack-RedM)
- 📚 **Documentation:** Available in their repository
- 🎯 **Focus:** General-purpose RedM framework

### Prerequisites

1. Install RSG-Core framework
2. Run database migrations
3. Configure framework settings

### Configuration

```lua
Config.FrameworkSettings['rsg-core'] = {
    enabled = true,
    resource = 'rsg-core',
    exportName = 'rsg-core',
    getSharedObject = 'rsg-core:getSharedObject',
    playerLoaded = 'RSGCore:Client:OnPlayerLoaded',
    playerUnloaded = 'RSGCore:Client:OnPlayerUnload',
    jobUpdate = 'RSGCore:Client:OnJobUpdate',
    notification = 'rsg'
}
```

### Integration Features

**Supported Functions:**
- ✅ RSGCore.Functions.GetPlayerData()
- ✅ RSGCore.Functions.Notify()
- ✅ Player.PlayerData.money
- ✅ Player.PlayerData.job
- ✅ Server-side player management

### Example Usage

```lua
-- Get player data
local Player = RSGCore.Functions.GetPlayer(source)
local money = Player.PlayerData.money.cash

-- Add money
Player.Functions.AddMoney('cash', 100, 'bounty-reward')

-- Send notification
TriggerClientEvent('RSGCore:Notify', source, 'Quest completed!', 'success')
```

### Server.cfg

```cfg
ensure rsg-core
ensure lxr-bounty-quests
```

---

## 🐴 VORP Setup

### About VORP

**VORP** is one of the oldest and most established RedM frameworks.

- 🔗 **GitHub:** [github.com/VORPCORE](https://github.com/VORPCORE)
- 📚 **Documentation:** [VORP Docs](https://docs.vorp.gg/)
- 🎯 **Focus:** Legacy support, established servers

### Prerequisites

1. Install VORP Core
2. Install vorp_inventory
3. Configure database

### Configuration

```lua
Config.FrameworkSettings.vorp = {
    enabled = true,
    resource = 'vorp_core',
    exportName = 'vorp_core',
    getSharedObject = 'vorp:getSharedObject',
    playerLoaded = 'vorp:SelectedCharacter',
    playerUnloaded = 'vorp:PlayerLogout',
    jobUpdate = 'vorp:updateJob',
    notification = 'vorp'
}
```

### Integration Features

**Supported Functions:**
- ✅ VORP.getUser(source)
- ✅ User.getCharacter()
- ✅ Character.addCurrency()
- ✅ Character.removeCurrency()
- ✅ VORP notification system

### Example Usage

```lua
-- Server-side
local User = VORP.getUser(source)
local Character = User.getCharacter()

-- Add money
Character.addCurrency(0, 100) -- 0 = cash, 1 = gold

-- Send notification
TriggerClientEvent('vorp:TipRight', source, 'Quest completed!', 3000)
```

### Server.cfg

```cfg
ensure vorp_core
ensure vorp_inventory
ensure lxr-bounty-quests
```

---

## 🎯 RedEM:RP Setup

### About RedEM:RP

**RedEM:RP** is a roleplay-focused framework for RedM.

- 🔗 **GitHub:** [github.com/RedEM-RP](https://github.com/RedEM-RP)
- 🎯 **Focus:** Roleplay servers

### Prerequisites

1. Install RedEM:RP framework
2. Configure database connection
3. Set up inventory system

### Configuration

```lua
Config.FrameworkSettings.redemrp = {
    enabled = true,
    resource = 'redem_roleplay',
    exportName = 'redem_roleplay',
    getSharedObject = 'redem:getSharedObject',
    playerLoaded = 'RedEM:PlayerLoaded',
    playerUnloaded = 'RedEM:PlayerUnload',
    jobUpdate = 'RedEM:JobUpdate',
    notification = 'redemrp'
}
```

### Integration Features

**Supported Functions:**
- ✅ Player data retrieval
- ✅ Money management
- ✅ Job system integration
- ✅ Notification system

### Example Usage

```lua
-- Server-side
TriggerEvent('redemrp:getPlayerFromId', source, function(user)
    if user then
        user.addMoney(100)
        TriggerClientEvent('redemrp:notification', source, 'Quest reward received!')
    end
end)
```

### Server.cfg

```cfg
ensure redem_roleplay
ensure lxr-bounty-quests
```

---

## 🔷 QBR/QR Core Setup

### About QBR & QR Core

**QBR Core** and **QR Core** are RedM adaptations of the popular QB-Core framework from FiveM.

### Prerequisites

1. Install QB/QR Core for RedM
2. Configure framework settings
3. Set up database

### Configuration

```lua
-- QBR Core
Config.FrameworkSettings['qbr-core'] = {
    enabled = true,
    resource = 'qbr-core',
    exportName = 'qbr-core',
    getSharedObject = 'qbr-core:getSharedObject',
    playerLoaded = 'QBCore:Client:OnPlayerLoaded',
    playerUnloaded = 'QBCore:Client:OnPlayerUnload',
    jobUpdate = 'QBCore:Client:OnJobUpdate',
    notification = 'qb'
}

-- QR Core
Config.FrameworkSettings['qr-core'] = {
    enabled = true,
    resource = 'qr-core',
    exportName = 'qr-core',
    getSharedObject = 'qr-core:getSharedObject',
    playerLoaded = 'QR:Client:OnPlayerLoaded',
    playerUnloaded = 'QR:Client:OnPlayerUnload',
    jobUpdate = 'QR:Client:OnJobUpdate',
    notification = 'qr'
}
```

### Integration Features

**Supported Functions:**
- ✅ QB/QR.Functions.GetPlayer()
- ✅ Player.Functions.AddMoney()
- ✅ Player.Functions.AddItem()
- ✅ Notification system

### Example Usage

```lua
-- QBR Core
local Player = QBCore.Functions.GetPlayer(source)
Player.Functions.AddMoney('cash', 100, 'bounty-reward')

-- QR Core
local Player = QRCore.Functions.GetPlayer(source)
Player.Functions.AddMoney('cash', 100, 'bounty-reward')
```

### Server.cfg

```cfg
# For QBR
ensure qbr-core
ensure lxr-bounty-quests

# For QR
ensure qr-core
ensure lxr-bounty-quests
```

---

## 🚀 Standalone Mode

### About Standalone Mode

Standalone mode allows the script to function **without any framework**. This is perfect for:
- Testing environments
- Custom framework servers
- Minimal dependency setups

### How It Works

When no framework is detected, the script:
- ✅ Uses native game functions
- ✅ Stores data in local tables (server memory)
- ✅ Uses native notifications
- ✅ Manages its own player session data

### Configuration

```lua
Config.Framework = 'standalone' -- Force standalone mode

Config.FrameworkSettings.standalone = {
    enabled = true,
    resource = nil,
    exportName = nil,
    notification = 'native'
}
```

### Limitations

⚠️ **Standalone Mode Limitations:**
- No persistent player data between restarts
- No framework inventory integration
- Limited money management
- No job/gang system integration
- Basic notification system only

### Example Usage

```lua
-- Server-side standalone
RegisterNetEvent('lxr-quests:giveReward', function(amount)
    local source = source
    
    -- Standalone reward system (custom implementation)
    TriggerClientEvent('lxr-quests:notify', source, 'You earned $'..amount)
end)
```

### Server.cfg

```cfg
ensure lxr-bounty-quests
```

---

## 🔧 Framework Adapter Layer

### Architecture

The framework adapter provides a **unified API** regardless of which framework is being used.

```
┌─────────────────────┐
│  LXR Quest System   │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│  Framework Adapter  │ ◄── Unified API
└──────────┬──────────┘
           │
    ┌──────┴──────┐
    ▼             ▼
┌────────┐    ┌────────┐
│ LXRCore│    │RSG-Core│  etc...
└────────┘    └────────┘
```

### Core Functions

The adapter provides these universal functions:

```lua
-- Player Management
FrameworkAdapter.GetPlayer(source)
FrameworkAdapter.GetPlayerIdentifier(source)

-- Money Management
FrameworkAdapter.AddMoney(source, type, amount)
FrameworkAdapter.RemoveMoney(source, type, amount)
FrameworkAdapter.GetMoney(source, type)

-- Item Management
FrameworkAdapter.AddItem(source, item, amount)
FrameworkAdapter.RemoveItem(source, item, amount)
FrameworkAdapter.GetItemCount(source, item)

-- Notifications
FrameworkAdapter.Notify(source, message, type, duration)

-- Job/Gang System
FrameworkAdapter.GetJob(source)
FrameworkAdapter.GetGang(source)
```

### Implementation Example

```lua
-- file: framework/adapter.lua
FrameworkAdapter = {}

function FrameworkAdapter.AddMoney(source, moneyType, amount)
    if Config.Framework == 'lxrcore' then
        local Player = LXRCore.Functions.GetPlayer(source)
        Player.Functions.AddMoney(moneyType, amount)
        
    elseif Config.Framework == 'rsg-core' then
        local Player = RSGCore.Functions.GetPlayer(source)
        Player.Functions.AddMoney(moneyType, amount)
        
    elseif Config.Framework == 'vorp' then
        local User = VORP.getUser(source)
        local Character = User.getCharacter()
        local currencyType = (moneyType == 'cash') and 0 or 1
        Character.addCurrency(currencyType, amount)
        
    -- Additional framework implementations...
    end
end
```

### Benefits

✅ **For Developers:**
- Single codebase for all frameworks
- Easy to add new framework support
- Consistent behavior across frameworks

✅ **For Server Owners:**
- Switch frameworks without changing scripts
- Run multiple frameworks simultaneously
- Easy migration between frameworks

---

## 🛠️ Custom Framework Integration

### Adding a New Framework

To integrate a custom framework:

#### Step 1: Add Framework Configuration

```lua
-- In config.lua
Config.FrameworkSettings['my-framework'] = {
    enabled = true,
    resource = 'my-framework-resource',
    exportName = 'my-framework',
    getSharedObject = 'myframework:getObject',
    playerLoaded = 'MyFramework:PlayerLoaded',
    playerUnloaded = 'MyFramework:PlayerUnload',
    jobUpdate = 'MyFramework:JobUpdate',
    notification = 'custom'
}
```

#### Step 2: Implement Adapter Functions

```lua
-- In framework/adapter.lua
elseif Config.Framework == 'my-framework' then
    -- Implement required functions
    FrameworkAdapter.GetPlayer = function(source)
        return exports['my-framework']:GetPlayer(source)
    end
    
    FrameworkAdapter.AddMoney = function(source, type, amount)
        local Player = exports['my-framework']:GetPlayer(source)
        Player.AddMoney(type, amount)
    end
    
    -- Implement other required functions...
end
```

#### Step 3: Add Detection Logic

```lua
-- In framework/detection.lua
function DetectFramework()
    -- Check for your framework
    if GetResourceState('my-framework-resource') == 'started' then
        return 'my-framework'
    end
    
    -- Continue with other checks...
end
```

#### Step 4: Test Integration

1. Start your framework
2. Start lxr-bounty-quests
3. Check console for detection confirmation
4. Test quest acceptance and rewards
5. Verify notifications work correctly

### Required Functions

Your framework must support these functions:

```lua
-- Minimum Required
✅ Get player object
✅ Add/remove money
✅ Send notifications

-- Recommended
🔹 Add/remove items
🔹 Get player job
🔹 Player loaded/unloaded events

-- Optional
⭐ Gang system
⭐ Player status (hunger, thirst)
⭐ Inventory management
```

---

## 🔍 Troubleshooting

### Framework Not Detected

**Issue:** Console shows "No framework detected, using standalone mode"

**Solutions:**
1. Ensure framework resource is started **before** lxr-bounty-quests
2. Check framework resource name matches config
3. Verify framework is running: `/status` in server console
4. Try manual override: `Config.Framework = 'lxrcore'`

### Player Data Not Loading

**Issue:** Player data returns nil

**Solutions:**
1. Check player is fully loaded before quest interaction
2. Verify framework player loading event is correct
3. Enable debug mode to see player load events
4. Check database connection

### Notifications Not Working

**Issue:** No notifications appear

**Solutions:**
1. Verify notification system setting in config
2. Check framework notification exports
3. Test with different notification type
4. Check client console for errors

### Money Not Being Given

**Issue:** Rewards don't appear in player balance

**Solutions:**
1. Check server console for errors
2. Verify money type ('cash' vs 'bank')
3. Test AddMoney function directly
4. Check framework account system

---

## 📚 Additional Resources

- 📖 [Configuration Guide](./configuration.md)
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
