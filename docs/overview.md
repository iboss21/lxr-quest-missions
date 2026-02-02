# 🐺 LXR Quest Missions - System Overview

```
██╗      █████╗ ███╗   ██╗██████╗      ██████╗ ███████╗    ██╗    ██╗ ██████╗ ██╗    ██╗   ██╗███████╗███████╗
██║     ██╔══██╗████╗  ██║██╔══██╗    ██╔═══██╗██╔════╝    ██║    ██║██╔═══██╗██║    ██║   ██║██╔════╝██╔════╝
██║     ███████║██╔██╗ ██║██║  ██║    ██║   ██║█████╗      ██║ █╗ ██║██║   ██║██║    ██║   ██║█████╗  ███████╗
██║     ██╔══██║██║╚██╗██║██║  ██║    ██║   ██║██╔══╝      ██║███╗██║██║   ██║██║    ╚██╗ ██╔╝██╔══╝  ╚════██║
███████╗██║  ██║██║ ╚████║██████╔╝    ╚██████╔╝██║         ╚███╔███╔╝╚██████╔╝███████╗╚████╔╝ ███████╗███████║
╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═╝          ╚══╝╚══╝  ╚═════╝ ╚══════╝ ╚═══╝  ╚══════╝╚══════╝
```

**🐺 The Land of Wolves - Quest & Missions System Documentation**

*Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!*

*ისტორია ცოცხლდება აქ! (History Lives Here!)*

---

## 📖 What is LXR Quest Missions?

LXR Quest Missions is a comprehensive quest and mission framework for RedM, specifically designed and branded for **The Land of Wolves** server. This repository contains multiple quest systems that can work standalone or together.

### 🎯 Primary Systems

#### 1. **LXR Bounty Quests 2.0**
A complete bounty hunting system with:
- 6 Quest NPCs with progressive unlocking
- XP & Leveling system (1-100)
- Dynamic animal guards (wolves, bears, panthers, cougars, alligators)
- Multi-framework support (LXR-Core, RSG-Core, VORP)
- 4 Difficulty levels (Easy, Medium, Hard, Legendary)
- Performance-based bonus rewards
- 6 Unique NPC shops with specialized items
- Server-side security and validation
- Anti-cheat protection
- Cooldown systems

---

## 🏗️ Architecture

### System Design Philosophy

1. **Multi-Framework Compatibility**: All systems support multiple frameworks with automatic detection
2. **Server Authority**: All economy, rewards, and validation happen server-side
3. **Performance First**: Optimized for minimal FPS impact and server overhead
4. **Security Focused**: Anti-cheat, rate limiting, and server-side validation
5. **Highly Configurable**: Hundreds of configuration options without code changes
6. **Branded Identity**: Every file maintains Land of Wolves branding

### Component Structure

```
lxr-quest-missions/
├── docs/                          # Documentation (you are here)
│   ├── overview.md               # System overview
│   ├── installation.md           # Installation guide
│   ├── configuration.md          # Configuration guide
│   ├── frameworks.md             # Framework integration
│   ├── events.md                 # Event & API reference
│   ├── security.md               # Security features
│   ├── performance.md            # Performance optimization
│   ├── screenshots.md            # Screenshot requirements
│   └── assets/screenshots/       # Screenshot storage
│
└── lxr-bounty-quests/            # Bounty quest system
    ├── client/                   # Client-side scripts
    ├── server/                   # Server-side scripts
    ├── shared/                   # Shared framework adapter
    ├── locales/                  # Language files
    ├── sql/                      # Database schemas
    ├── config.lua                # Configuration
    ├── fxmanifest.lua           # Resource manifest
    └── README.md                # System-specific docs
```

---

## 🌟 Key Features

### Multi-Framework Support
- **LXR-Core** (Primary) - The Land of Wolves framework
- **RSG-Core** (Primary) - Rexshack Gaming Core
- **VORP Core** (Supported) - Legacy framework
- **RedEM:RP** (Optional) - RedEM Roleplay
- **QBR Core** (Optional) - QB-Core for RedM
- **QR Core** (Optional) - QR Core Framework
- **Standalone** (Optional) - No framework required

### Framework Adapter Layer
All systems include a unified framework adapter (`shared/framework.lua`) that provides:
- Unified function calls (Notify, GetPlayerJob, AddMoney, etc.)
- Automatic framework detection
- Clean code separation
- Easy maintenance

### Security Features
- Resource name protection (runtime verification)
- Server-side validation for all actions
- Cooldown systems (per-player tracking)
- Rate limiting for repeatable actions
- Distance validation
- State verification
- Audit logging
- Anti-exploit protections

### Performance Optimization
- Minimal tick usage
- Efficient distance calculations
- Smart NPC spawning/despawning
- Optimized database queries
- Client-side caching
- Configurable update intervals

---

## 🎮 Gameplay Systems

### Quest System
- Multiple quest NPCs with different specializations
- Progressive difficulty unlocking based on player level
- Dynamic quest targets with random locations
- Animal guard spawning for added challenge
- Performance-based rewards
- Quest history tracking

### Progression System
- XP-based leveling (1-100)
- Quest completion tracking
- Statistics recording
- Leaderboard integration
- Achievement unlocking

### Economy Integration
- Dynamic reward calculations
- Weapon-based bonuses
- Distance multipliers
- Difficulty scaling
- Framework-specific currency handling

---

## 📊 Database Integration

All quest systems include:
- Persistent player data storage
- Statistics tracking
- Quest history
- Leaderboard data
- Configuration backup
- Automatic table creation

See [installation.md](./installation.md) for SQL schema details.

---

## 🔗 Related Documentation

- **[Installation Guide](./installation.md)** - Step-by-step setup instructions
- **[Configuration Guide](./configuration.md)** - Detailed config options
- **[Framework Integration](./frameworks.md)** - Framework-specific setup
- **[Events & API](./events.md)** - Event reference and custom integrations
- **[Security Features](./security.md)** - Security implementation details
- **[Performance Guide](./performance.md)** - Optimization tips
- **[Screenshots](./screenshots.md)** - Visual documentation requirements

---

## 🐺 The Land of Wolves

**Server Information**
- **Name**: The Land of Wolves 🐺
- **Tagline**: Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!
- **Description**: ისტორია ცოცხლდება აქ! (History Lives Here!)
- **Type**: Serious Hardcore Roleplay
- **Access**: Discord & Whitelisted

**Links**
- Website: https://www.wolves.land
- Discord: https://discord.gg/CrKcWdfd3A
- GitHub: https://github.com/iBoss21
- Store: https://theluxempire.tebex.io
- Server Listing: https://servers.redm.net/servers/detail/8gj7eb

**Developer**: iBoss21 / The Lux Empire

---

© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
