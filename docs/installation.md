# 🐺 LXR Quest Missions - Installation Guide

```
██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗      █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║
██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
```

**🐺 The Land of Wolves - Quest & Missions Installation Guide**

---

## 📋 Prerequisites

Before installing LXR Quest Missions, ensure you have:

### Required
- ✅ RedM Server (latest prerelease build)
- ✅ At least one supported framework installed:
  - **LXR-Core** (recommended)
  - **RSG-Core** (recommended)
  - **VORP Core**
  - RedEM:RP, QBR-Core, QR-Core (optional)
  - Or run standalone (no framework)
- ✅ Database system (MySQL/MariaDB)
- ✅ Database resource (oxmysql, ghmattimysql, or mysql-async)

### Recommended
- 📝 Text editor with Lua syntax highlighting
- 🗂️ FTP/SFTP client or direct server access
- 🔑 Database administration tool (phpMyAdmin, HeidiSQL, etc.)
- 📊 TxAdmin or similar server management tool

---

## 📥 Installation Steps

### Step 1: Download the Resource

1. **Clone or Download** the repository:
   ```bash
   cd resources
   git clone https://github.com/iboss21/lxr-quest-missions.git
   ```

2. **Or download** the ZIP file and extract to your `resources` folder

### Step 2: Resource Placement

1. Place the resource in your server's `resources` folder:
   ```
   server/
   └── resources/
       └── lxr-quest-missions/
           └── lxr-bounty-quests/
   ```

2. **IMPORTANT**: The resource folder name **MUST** be exactly `lxr-bounty-quests`
   - The script includes resource name protection
   - Renaming will cause the script to fail with an error

### Step 3: Database Setup

#### For LXR Bounty Quests System

1. **Locate the SQL file**:
   ```
   lxr-bounty-quests/sql/bounty_quests.sql
   ```

2. **Import the SQL file** into your database:
   - Using phpMyAdmin: Import tab → Choose file → Execute
   - Using HeidiSQL: File → Run SQL file
   - Using command line:
     ```bash
     mysql -u username -p database_name < bounty_quests.sql
     ```

3. **Verify tables were created**:
   - `lxr_bounty_players` - Player data and progression
   - `lxr_bounty_quests` - Active quest tracking
   - `lxr_bounty_history` - Quest completion history

#### SQL Schema Overview

```sql
-- Player Data Table
CREATE TABLE IF NOT EXISTS `lxr_bounty_players` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `identifier` VARCHAR(50) UNIQUE,
    `level` INT DEFAULT 1,
    `xp` INT DEFAULT 0,
    `total_quests` INT DEFAULT 0,
    `successful_quests` INT DEFAULT 0,
    `failed_quests` INT DEFAULT 0,
    `total_kills` INT DEFAULT 0,
    `total_earnings` DECIMAL(10,2) DEFAULT 0.00,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `last_active` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Active Quests Table
CREATE TABLE IF NOT EXISTS `lxr_bounty_quests` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `identifier` VARCHAR(50),
    `npc_id` VARCHAR(50),
    `quest_id` INT,
    `difficulty` VARCHAR(20),
    `status` VARCHAR(20) DEFAULT 'active',
    `started_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Quest History Table
CREATE TABLE IF NOT EXISTS `lxr_bounty_history` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `identifier` VARCHAR(50),
    `npc_id` VARCHAR(50),
    `difficulty` VARCHAR(20),
    `reward` DECIMAL(10,2),
    `xp_earned` INT,
    `completion_time` INT,
    `completed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Step 4: Configuration

1. **Open config.lua** in a text editor:
   ```
   lxr-bounty-quests/config.lua
   ```

2. **Configure framework settings** (if not using auto-detect):
   ```lua
   Config.Framework = 'auto' -- or specify: 'lxrcore', 'rsg-core', 'vorp', etc.
   ```

3. **Adjust quest settings** as desired:
   - NPC locations
   - Reward amounts
   - XP multipliers
   - Cooldown timers
   - Difficulty scaling

4. **Configure database** (if not using default):
   ```lua
   Config.DatabaseTables = {
       players = 'lxr_bounty_players',
       quests = 'lxr_bounty_quests',
       history = 'lxr_bounty_history'
   }
   ```

5. **Set language**:
   ```lua
   Config.Lang = 'English' -- or 'Georgian'
   ```

See [configuration.md](./configuration.md) for detailed configuration options.

### Step 5: Server Configuration

1. **Add to server.cfg**:
   ```cfg
   # LXR Quest Missions
   ensure lxr-bounty-quests
   ```

2. **Verify dependencies** are loaded first:
   ```cfg
   # Framework (choose one or more)
   ensure lxr-core      # LXR-Core
   # ensure rsg-core    # RSG-Core
   # ensure vorp_core   # VORP

   # Database
   ensure oxmysql       # or ghmattimysql or mysql-async

   # LXR Quest Missions
   ensure lxr-bounty-quests
   ```

3. **Restart your server** or start the resource:
   ```
   refresh
   start lxr-bounty-quests
   ```

### Step 6: Verification

1. **Check console** for startup messages:
   ```
   ═══════════════════════════════════════════════════════════════════════════════
   🐺 LXR Bounty Quests System v2.0.0
   ═══════════════════════════════════════════════════════════════════════════════
   ✓ Framework: lxrcore
   ✓ Database: Connected
   ✓ NPCs: 6 loaded
   ✓ Shops: 6 loaded
   ═══════════════════════════════════════════════════════════════════════════════
   ```

2. **Join your server** and verify:
   - NPCs appear at configured locations
   - Interaction prompts work
   - Quest menu opens
   - Database tracking works (check F8 console if debug enabled)

3. **Test functionality**:
   - Accept a quest
   - Complete a quest
   - Check XP/level progression
   - Visit an NPC shop
   - Verify rewards are given

---

## 🔧 Framework-Specific Setup

### LXR-Core Setup

1. **Ensure LXR-Core is installed** and working
2. **No additional configuration needed** - auto-detection works
3. **Optional**: Add custom items to lxr-core/shared/items.lua if needed

### RSG-Core Setup

1. **Ensure RSG-Core is installed** and working
2. **No additional configuration needed** - auto-detection works
3. **Optional**: Add custom items to rsg-core/shared/items.lua if needed

### VORP Setup

1. **Ensure VORP Core is installed** and working
2. **Database**: VORP uses different identifier system
   ```lua
   Config.FrameworkSettings.vorp.identifierColumn = 'identifier'
   ```
3. **Items**: Add any custom items to vorp_inventory if needed

### Standalone Setup

1. **Set framework to standalone**:
   ```lua
   Config.Framework = 'standalone'
   ```
2. **Configure notification system**:
   ```lua
   Config.Notifications.Type = 'native'
   ```
3. **Note**: Some features may be limited without framework integration

See [frameworks.md](./frameworks.md) for detailed framework integration.

---

## 🛠️ Troubleshooting

### Resource Not Starting

**Problem**: Resource fails to start or shows errors

**Solutions**:
1. ✓ Check resource name is exactly `lxr-bounty-quests`
2. ✓ Verify fxmanifest.lua exists and is valid
3. ✓ Check F8 console for specific error messages
4. ✓ Ensure all dependencies are started before this resource

### Database Errors

**Problem**: Database connection errors or table not found

**Solutions**:
1. ✓ Verify database resource (oxmysql) is running
2. ✓ Check database credentials in your database resource config
3. ✓ Confirm SQL tables were created successfully
4. ✓ Verify table names in config match database

### Framework Not Detected

**Problem**: "Framework not detected" or standalone mode when framework is installed

**Solutions**:
1. ✓ Ensure framework resource is started before lxr-bounty-quests
2. ✓ Check framework resource name matches Config.FrameworkSettings
3. ✓ Manually set Config.Framework if auto-detect fails
4. ✓ Verify framework exports are working

### NPCs Not Spawning

**Problem**: Quest NPCs don't appear

**Solutions**:
1. ✓ Check NPC coordinates in config.lua
2. ✓ Verify you're in the correct location
3. ✓ Enable debug mode to see spawn messages
4. ✓ Check if NPC has time restrictions preventing spawn

### Quests Not Working

**Problem**: Can't accept or complete quests

**Solutions**:
1. ✓ Check player level requirements
2. ✓ Verify cooldowns haven't blocked the quest
3. ✓ Enable debug mode for detailed information
4. ✓ Check server console for validation errors
5. ✓ Ensure quest target spawned correctly

---

## 🔍 Debug Mode

Enable debug mode for troubleshooting:

```lua
Config.EnableDebug = true
```

This will:
- Print detailed information to F8 console
- Show framework detection details
- Display spawn/despawn events
- Log quest state changes
- Show validation results

**Remember to disable** debug mode in production for performance.

---

## 📦 Updating

### Update Process

1. **Backup your files**:
   - config.lua (your custom settings)
   - Any modified locales
   - Database (if significant)

2. **Download new version**:
   ```bash
   cd lxr-quest-missions
   git pull origin main
   ```

3. **Compare configs**:
   - Check for new configuration options
   - Merge your customizations

4. **Check SQL updates**:
   - Review sql/ folder for migration scripts
   - Apply any database changes

5. **Restart resource**:
   ```
   restart lxr-bounty-quests
   ```

### Version Compatibility

- **Major version changes** (e.g., 2.0 → 3.0): May require database migration
- **Minor version changes** (e.g., 2.0 → 2.1): Usually config-only changes
- **Patch changes** (e.g., 2.0.0 → 2.0.1): Hot-swappable, no config changes

Always read CHANGELOG.md before updating.

---

## 🆘 Getting Help

### Before Asking for Support

1. ✅ Read this installation guide completely
2. ✅ Check [configuration.md](./configuration.md) for settings help
3. ✅ Review F8 console for error messages
4. ✅ Enable debug mode to see detailed information
5. ✅ Check that all dependencies are installed
6. ✅ Verify framework is properly configured

### Support Channels

1. **Discord**: Join our [Discord server](https://discord.gg/CrKcWdfd3A) for live support
2. **GitHub Issues**: Report bugs or request features on GitHub
3. **Documentation**: Check other docs in this folder
4. **Website**: Visit [wolves.land](https://www.wolves.land) for more info

### Information to Provide

When asking for help, include:
- RedM server version
- Framework name and version
- Database resource being used
- Error messages (full text from F8 console)
- Relevant config.lua sections
- Steps to reproduce the issue

---

## 🐺 The Land of Wolves

*Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!*

**Server**: https://servers.redm.net/servers/detail/8gj7eb  
**Discord**: https://discord.gg/CrKcWdfd3A  
**Website**: https://www.wolves.land

---

© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
