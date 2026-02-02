# 🐺 Client Scripts - LXR Bounty Quests System

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

This folder contains all **client-side scripts** for the LXR Bounty Quests system. These scripts run on the player's client and handle all local game interactions, UI rendering, NPC interactions, and player-side quest logic.

---

## 🎯 Responsibilities

### **Client-Side Operations**
- 🗺️ **NPC Management** - Spawning, displaying, and managing quest-giving NPCs in the world
- 🎨 **UI Rendering** - Drawing prompts, menus, markers, and notifications for players
- 🎮 **Player Interactions** - Handling keybinds, proximity checks, and target identification
- 📍 **Blip Management** - Creating and updating map blips for quest locations
- 🎭 **Visual Effects** - Managing visual indicators, highlights, and world interactions
- 🔊 **Audio/Feedback** - Playing sounds and providing haptic feedback during quests
- 🌍 **World State** - Tracking local quest states and player progress client-side
- 🚨 **Target Tracking** - Identifying and tracking bounty targets in the world

### **Communication with Server**
- ✉️ Server Events - Sending quest requests, completion notifications, and player actions
- 📨 Receiving Updates - Getting quest updates, reward confirmations, and state changes
- 🔄 Data Sync - Syncing NPC locations, active quests, and target positions

---

## 📂 File Structure

```
client/
├── README.md           # This file - Overview of client scripts
├── main.lua            # Main client initialization and core logic
├── npc.lua             # NPC spawning, management, and interactions
├── quest.lua           # Quest UI, menus, and player quest tracking
├── target.lua          # Bounty target identification and tracking
└── utils.lua           # Client-side utility functions
```

---

## 🛠️ Key Features

- **Framework Agnostic** - Works with LXR-Core, RSG-Core, VORP, RedEM:RP, QBR, QR, and Standalone
- **Performance Optimized** - Efficient thread management and distance checks
- **Multi-Language Support** - Full localization support for all UI elements
- **Customizable UI** - Flexible prompt and notification system
- **Dynamic NPCs** - NPCs that move and change locations based on configuration

---

## 🔗 Integration

All client scripts integrate with:
- `shared/framework.lua` - Framework bridge layer for cross-compatibility
- `config.lua` - Central configuration for all client settings
- `locales/` - Language files for translated UI text

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
