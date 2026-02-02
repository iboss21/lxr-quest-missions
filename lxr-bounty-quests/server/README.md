# 🐺 Server Scripts - LXR Bounty Quests System

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

This folder contains all **server-side scripts** for the LXR Bounty Quests system. These scripts run on the server and handle all authoritative game logic, database operations, reward distribution, and anti-cheat validation.

---

## 🎯 Responsibilities

### **Server-Side Operations**
- 🔐 **Quest Validation** - Verifying quest requests, completions, and player eligibility
- 💰 **Reward Distribution** - Handling money, items, and experience rewards securely
- ⏱️ **Cooldown Management** - Tracking and enforcing quest cooldowns per player
- 🗄️ **Database Operations** - Saving, loading, and updating player quest data
- 🎲 **Quest Generation** - Randomly selecting and creating quest instances
- 📊 **Statistics Tracking** - Recording player quest completions, earnings, and progress
- 🛡️ **Anti-Cheat** - Validating all player actions to prevent exploitation
- 🌐 **Multi-Player Sync** - Managing quest states across all connected players
- 🔄 **NPC Location Updates** - Dynamically updating NPC spawn locations

### **Communication with Clients**
- ✉️ Client Events - Receiving quest requests, completion attempts, and player actions
- 📨 Broadcasting Updates - Sending quest updates, NPC positions, and notifications
- 🔒 Secure Processing - Validating all client requests server-side for security

---

## 📂 File Structure

```
server/
├── README.md           # This file - Overview of server scripts
├── main.lua            # Main server initialization and event handlers
├── quest.lua           # Quest creation, validation, and completion logic
├── database.lua        # Database integration for player quest data
├── rewards.lua         # Reward calculation and distribution
├── cooldowns.lua       # Cooldown tracking and enforcement
└── utils.lua           # Server-side utility functions
```

---

## 🛠️ Key Features

- **Framework Agnostic** - Works with LXR-Core, RSG-Core, VORP, RedEM:RP, QBR, QR, and Standalone
- **Anti-Exploit Protection** - All quest logic validated server-side with security checks
- **Database Integration** - Persistent player data across sessions
- **Performance Optimized** - Efficient quest management with minimal server overhead
- **Scalable Architecture** - Handles multiple concurrent quests across many players
- **Flexible Rewards** - Supports cash, gold, items, and experience rewards

---

## 🔒 Security Features

- ✅ **Server-Side Validation** - All quest completions verified server-side
- ✅ **Cooldown Enforcement** - Prevents quest spamming and exploitation
- ✅ **Distance Checks** - Validates player proximity to NPCs and targets
- ✅ **Reward Limits** - Ensures rewards are within configured bounds
- ✅ **State Management** - Prevents duplicate quest claims and exploits

---

## 🔗 Integration

All server scripts integrate with:
- `shared/framework.lua` - Framework bridge layer for cross-compatibility
- `config.lua` - Central configuration for all server settings
- `sql/` - Database schema for player quest data storage

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
