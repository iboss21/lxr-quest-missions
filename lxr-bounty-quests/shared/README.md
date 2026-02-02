# 🐺 Shared Scripts - LXR Bounty Quests System

```
██╗      █████╗ ███╗   ██╗██████╗      ██████╗ ███████╗    ██╗    ██╗ ██████╗ ██╗    ██╗   ██╗███████╗███████╗
██║     ██╔══██╗████╗  ██║██╔══██╗    ██╔═══██╗██╔════╝    ██║    ██║██╔═══██╗██║    ██║   ██║██╔════╝██╔════╝
██║     ███████║██╔██╗ ██║██║  ██║    ██║   ██║█████╗      ██║ █╗ ██║██║   ██║██║    ██║   ██║█████╗  ███████╗
██║     ██╔══██║██║╚██╗██║██║  ██║    ██║   ██║██╔══╝      ██║███╗██║██║   ██║██║    ╚██╗ ██╔╝██╔══╝  ╚════██║
███████╗██║  ██║██║ ╚████║██████╔╝    ╚██████╔╝██║         ╚███╔███╔╝╚██████╔╝███████╗╚████╔╝ ███████╗███████║
╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═╝          ╚══╝╚══╝  ╚═════╝ ╚══════╝ ╚═══╝  ╚══════╝╚══════╝
```

**Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!**  
*ისტორია ცოცხლდება აქ! (History Lives Here!)*

---

## 📁 Overview

This folder contains **shared scripts** that run on both client and server. The primary purpose is to provide a **unified framework adapter layer** that bridges all supported frameworks, ensuring seamless cross-compatibility.

---

## 🎯 Purpose

### **Framework Bridge/Adapter Layer**
The core purpose of the shared folder is to provide **framework abstraction** - a single, unified interface that works across all supported frameworks without code duplication.

### **Why Framework Abstraction?**
- ✅ **Write Once, Run Everywhere** - Same code works across all frameworks
- ✅ **No Framework Lock-In** - Switch frameworks without rewriting logic
- ✅ **Simplified Development** - Developers use one consistent API
- ✅ **Future-Proof** - Easy to add new framework support
- ✅ **Reduced Bugs** - Less conditional logic means fewer edge cases

---

## 🔧 Framework Support

The shared framework adapter supports **7 frameworks**:

1. **LXR-Core** (Primary) - The Land of Wolves custom framework
2. **RSG-Core** (Primary) - Popular RedM framework
3. **VORP Core** - Widely-used RedM framework
4. **RedEM:RP** - Classic RedM roleplay framework
5. **QBR Core** - RedM port of QBCore
6. **QR Core** - Alternative RedM framework
7. **Standalone** - No framework dependency

---

## 📂 Files

```
shared/
├── README.md           # This file - Overview of shared scripts
└── framework.lua       # Framework bridge/adapter layer
```

---

## 🛠️ Framework Bridge Features

### **Auto-Detection**
Automatically detects which framework is running and adapts accordingly:
```lua
Framework.Initialize() -- Detects and configures framework
Framework.Type         -- Returns: 'lxrcore', 'rsg-core', 'vorp', etc.
Framework.Ready        -- Boolean indicating if framework is ready
```

### **Unified Client Functions**
Client-side functions that work across all frameworks:
```lua
Framework.GetPlayerData()           -- Get current player data
Framework.Notify(msg, type, duration) -- Send notification to player
Framework.GetJob()                  -- Get player's current job
Framework.HasItem(item, amount)     -- Check if player has item
```

### **Unified Server Functions**
Server-side functions that work across all frameworks:
```lua
Framework.GetPlayer(source)              -- Get player object by server ID
Framework.GetIdentifier(source)          -- Get unique player identifier
Framework.AddMoney(source, type, amount) -- Add money (cash/gold)
Framework.RemoveMoney(source, type, amount) -- Remove money
Framework.AddItem(source, item, amount)  -- Give item to player
Framework.RemoveItem(source, item, amount) -- Take item from player
Framework.GetPlayerJob(source)           -- Get player's job
Framework.HasItem(source, item, amount)  -- Check player inventory
```

---

## 💡 Usage Example

### **Instead of writing this (framework-specific):**
```lua
-- Different code for each framework
if Framework == 'rsg-core' then
    RSGCore.Functions.Notify(msg, type, duration)
elseif Framework == 'vorp' then
    TriggerEvent('vorp:TipBottom', msg, duration)
elseif Framework == 'redemrp' then
    TriggerEvent('redemrp_notification:start', msg, duration)
-- ... and so on for 7 frameworks
end
```

### **You write this (framework-agnostic):**
```lua
-- Works on all frameworks automatically
Framework.Notify(msg, type, duration)
```

---

## 🔄 How It Works

1. **Auto-Detection** - Script checks which framework resource is running
2. **Core Initialization** - Gets the framework's core object using the correct method
3. **Function Mapping** - Maps unified functions to framework-specific implementations
4. **Transparent Usage** - Developer uses `Framework.X()` without knowing which framework is active

---

## 🚀 Benefits

- **Single Codebase** - One script works everywhere
- **Easy Maintenance** - Update once, works for all frameworks
- **Better Performance** - No runtime checks needed in main logic
- **Clean Code** - No messy if/else framework checks throughout codebase
- **Modular Design** - Framework logic separated from business logic

---

## 🔗 Integration

All other scripts (client + server) import the framework bridge:
```lua
-- In other scripts
Framework = exports['lxr-bounty-quests']:GetFramework()
-- OR if loaded as shared file
-- Framework is already available globally
```

---

## 👨‍💻 Developer Info

**Created by:** iBoss21 / The Lux Empire  
**Website:** [wolves.land](https://www.wolves.land)  
**Discord:** [Join Community](https://discord.gg/CrKcWdfd3A)  
**GitHub:** [@iBoss21](https://github.com/iBoss21)  
**Store:** [The Lux Empire Tebex](https://theluxempire.tebex.io)

---

## 📜 License

© 2026 iBoss21 / The Lux Empire. All rights reserved.  
For licensing inquiries, visit our store or contact via Discord.

---

*🐺 The Land of Wolves - Where Legends Are Born*
