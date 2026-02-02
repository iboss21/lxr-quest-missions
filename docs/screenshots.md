# 🐺 LXR Quest Missions - Screenshots Documentation

```
███████╗ ██████╗██████╗ ███████╗███████╗███╗   ██╗███████╗██╗  ██╗ ██████╗ ████████╗███████╗
██╔════╝██╔════╝██╔══██╗██╔════╝██╔════╝████╗  ██║██╔════╝██║  ██║██╔═══██╗╚══██╔══╝██╔════╝
███████╗██║     ██████╔╝█████╗  █████╗  ██╔██╗ ██║███████╗███████║██║   ██║   ██║   ███████╗
╚════██║██║     ██╔══██╗██╔══╝  ██╔══╝  ██║╚██╗██║╚════██║██╔══██║██║   ██║   ██║   ╚════██║
███████║╚██████╗██║  ██║███████╗███████╗██║ ╚████║███████║██║  ██║╚██████╔╝   ██║   ███████║
╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚══════╝
```

**🐺 The Land of Wolves - Screenshot Requirements & Guidelines**

**Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!**

---

## 📖 Table of Contents

1. [Overview](#overview)
2. [Storage Location](#storage-location)
3. [Naming Convention](#naming-convention)
4. [Required Screenshots](#required-screenshots)
5. [Technical Requirements](#technical-requirements)
6. [Screenshot Guidelines](#screenshot-guidelines)
7. [How to Capture](#how-to-capture)

---

## 🌟 Overview

This document defines the required screenshots for LXR Quest Missions documentation. These screenshots provide visual references for users, developers, and server administrators.

**Purpose:**
- 📸 Visual documentation of features
- 🎯 User interface reference
- 🛠️ Troubleshooting guide
- 📚 Marketing and promotional materials

---

## 📂 Storage Location

All screenshots must be stored in the following directory:

```
/home/runner/work/lxr-quest-missions/lxr-quest-missions/docs/assets/screenshots/
```

### Directory Structure

```
docs/
└── assets/
    └── screenshots/
        ├── 01_startup_console.png
        ├── 02_config_sections.png
        ├── 03_ui_interaction.png
        ├── 04_framework_detection.png
        ├── 05_npc_locations.png
        ├── 06_quest_menu.png
        ├── 07_active_quest.png
        └── 08_completion_rewards.png
```

---

## 📝 Naming Convention

### Format

```
[NUMBER]_[DESCRIPTIVE_NAME].png
```

### Rules

- ✅ Use lowercase letters
- ✅ Replace spaces with underscores (_)
- ✅ Use descriptive names
- ✅ Start with two-digit number (01, 02, etc.)
- ✅ Use PNG format for best quality
- ❌ Avoid special characters
- ❌ Keep names concise but clear

### Examples

```
✅ GOOD:
01_startup_console.png
02_config_sections.png
03_ui_interaction.png

❌ BAD:
startup.png
Screenshot_2025-01-01.png
IMG_001.jpeg
```

---

## 📸 Required Screenshots

### 1. Startup Console (01_startup_console.png)

**Description:** Server console output when lxr-bounty-quests starts successfully.

**What to Capture:**
- ASCII art branding banner
- Resource name confirmation
- Framework detection message
- Version information
- "Resource started successfully" message
- Georgian tagline display

**Example Console Output:**
```
[LXR-Bounty-Quests] ╔════════════════════════════════════════╗
[LXR-Bounty-Quests] ║   LAND OF WOLVES - BOUNTY QUESTS      ║
[LXR-Bounty-Quests] ║   მგლების მიწა - რჩეულთა ადგილი      ║
[LXR-Bounty-Quests] ╚════════════════════════════════════════╝
[LXR-Bounty-Quests] Framework detected: LXR-Core
[LXR-Bounty-Quests] Version: 2.0.0
[LXR-Bounty-Quests] Resource started successfully
```

**Console Settings:**
- Background: Dark theme
- Font: Monospace
- Size: Readable (minimum 12pt)

---

### 2. Config Sections (02_config_sections.png)

**Description:** Code editor view showing major config.lua sections.

**What to Capture:**
- File opened in code editor (VS Code, Notepad++, etc.)
- Visible sections:
  - Server Information
  - Framework Settings
  - General Settings
  - Quest NPCs
  - Cooldowns
- Syntax highlighting enabled
- Line numbers visible

**Editor Settings:**
- Theme: Dark (recommended) or Light
- Syntax: Lua highlighting
- Zoom: Readable code size
- Show: Line numbers, brackets

---

### 3. UI Interaction (03_ui_interaction.png)

**Description:** In-game screenshot of player interacting with quest NPC.

**What to Capture:**
- Quest NPC visible
- Interaction prompt displayed
- Player character in frame
- NPC name tag (if applicable)
- Blip on minimap
- Clear, well-lit scene

**In-Game Settings:**
- Time of day: Noon or afternoon (good lighting)
- Weather: Clear
- Graphics: High settings preferred
- HUD: Visible

**Location Suggestions:**
- Valentine Sheriff's Office
- Rhodes Marshal's Office
- Strawberry Sheriff's Office

---

### 4. Framework Detection (04_framework_detection.png)

**Description:** Console or log showing framework auto-detection process.

**What to Capture:**
- Framework detection sequence
- Checking for each framework
- Successful detection message
- Notification system selection
- Framework adapter initialization

**Example Output:**
```
[LXR-Quests] Framework Detection: Starting...
[LXR-Quests] Checking for LXR-Core... ✓ Found
[LXR-Quests] Framework: lxrcore loaded successfully
[LXR-Quests] Notification system: lxr
[LXR-Quests] Framework adapter initialized
```

---

### 5. NPC Locations (05_npc_locations.png)

**Description:** In-game map view showing quest NPC blip locations.

**What to Capture:**
- Full map view (zoomed out enough to see multiple locations)
- Quest NPC blips clearly visible
- Blip labels (if visible)
- Map legend (if applicable)
- Multiple NPC locations

**Map Settings:**
- Zoom level: Show 3-5 NPC locations
- Style: Normal map view
- Markers: All quest blips enabled

**Locations to Show:**
- Valentine Sheriff
- Rhodes Marshal
- Strawberry Sheriff
- Saint Denis Police
- Blackwater Sheriff

---

### 6. Quest Menu (06_quest_menu.png)

**Description:** Quest selection menu interface.

**What to Capture:**
- Quest giver NPC name and title
- Available quests list
- Quest details (name, difficulty, rewards)
- Player level and XP
- Accept/Cancel buttons
- UI elements clearly visible

**UI Elements:**
- Quest name
- Difficulty indicator (Easy/Medium/Hard/Legendary)
- Reward information (cash, XP, items)
- Quest description
- Requirements (if any)

**Example Quest Display:**
```
┌─────────────────────────────────────┐
│  Sheriff Curtis Malloy              │
│  Valentine Sheriff's Office         │
├─────────────────────────────────────┤
│  Available Quests:                  │
│                                     │
│  [EASY] Wanted: Petty Thief        │
│  Reward: $25 • 50 XP               │
│                                     │
│  [MEDIUM] Dangerous Outlaw         │
│  Reward: $75 • 125 XP              │
│  Requires: Level 5                 │
│                                     │
│  [HARD] Gang Leader                │
│  Reward: $150 • 250 XP             │
│  Requires: Level 10                │
└─────────────────────────────────────┘
```

---

### 7. Active Quest (07_active_quest.png)

**Description:** In-game screenshot during an active quest.

**What to Capture:**
- Active quest objective on screen
- Quest waypoint/marker visible
- HUD showing quest information
- Player in action (traveling to target, in combat, etc.)
- Time remaining (if applicable)
- Quest progress indicator

**HUD Elements:**
- Quest name
- Objective text
- Distance to target
- Waypoint marker
- Minimap with objective

**Scenarios:**
- Tracking a target
- At target location
- Identifying bounty
- Combat with target

---

### 8. Completion Rewards (08_completion_rewards.png)

**Description:** Quest completion screen showing rewards received.

**What to Capture:**
- "Quest Complete" message
- Rewards breakdown:
  - Cash earned
  - XP gained
  - Items received (if any)
  - Bonus rewards (if applicable)
- Level up notification (if applicable)
- Success notification/UI
- Player stats update

**Reward Display Example:**
```
╔═══════════════════════════════════╗
║       QUEST COMPLETED!            ║
╠═══════════════════════════════════╣
║  Wanted: Petty Thief              ║
║                                   ║
║  Rewards Earned:                  ║
║  💰 Cash: $31.25                  ║
║     (Base: $25 + 25% bonus)      ║
║  ⭐ XP: 62                        ║
║     (Base: 50 + 24% bonus)       ║
║  🎁 Items: Reinforced Lasso      ║
║                                   ║
║  Bonuses:                         ║
║  ✓ Quick Completion (+25%)       ║
║  ✓ No Deaths (+15%)              ║
╚═══════════════════════════════════╝
```

---

## ⚙️ Technical Requirements

### Image Specifications

| Property | Requirement | Recommended |
|----------|-------------|-------------|
| **Format** | PNG (required) | PNG-24 |
| **Resolution** | Minimum 1280x720 | 1920x1080 |
| **Aspect Ratio** | 16:9 preferred | 16:9 |
| **Color Depth** | 24-bit minimum | 32-bit |
| **File Size** | Maximum 5MB | 1-3MB |
| **Compression** | PNG optimization | Medium compression |

### Quality Standards

- ✅ Sharp, clear images
- ✅ No motion blur
- ✅ Proper lighting
- ✅ Readable text
- ✅ No excessive artifacts
- ❌ No watermarks (except Land of Wolves branding if applicable)
- ❌ No overlays that obscure content
- ❌ No low-quality upscaling

---

## 📷 Screenshot Guidelines

### In-Game Screenshots (03, 05, 07, 08)

**Graphics Settings:**
```
Resolution: 1920x1080 or higher
Texture Quality: High
Shadow Quality: Medium or High
Reflection Quality: Medium
Water Quality: High
MSAA: 2x or 4x
```

**Camera/View:**
- Use third-person view for character interactions
- First-person for UI close-ups
- Free camera for overview shots (if available)

**Environment:**
- Time: 10:00 AM - 3:00 PM in-game (good lighting)
- Weather: Clear or Sunny
- Location: Well-known, recognizable areas

**HUD:**
- Keep HUD enabled for UI screenshots
- Disable unnecessary elements for environmental shots
- Ensure readability of all text

### Console/Code Screenshots (01, 02, 04)

**Console Settings:**
- Dark theme preferred
- Monospace font
- Font size: 12-14pt minimum
- Background: Dark (#1E1E1E or similar)
- Text: Light (#FFFFFF or #CCCCCC)

**Code Editor Settings:**
- Syntax highlighting: Enabled
- Theme: Dark (VS Code Dark+, Monokai, etc.)
- Line numbers: Visible
- Zoom: 100-125%
- Font: Fira Code, Cascadia Code, or Consolas

### UI Screenshots (06)

**Capture Method:**
- Use in-game screenshot or external tool
- Ensure crisp UI rendering
- No screen tearing
- Full frame capture (not partial)

**UI Elements:**
- All text readable
- Icons clearly visible
- Buttons and interactive elements obvious
- Color contrast sufficient

---

## 🎯 How to Capture

### In-Game Screenshots (RedM)

**Method 1: Native Screenshot**
1. Press `F12` (if using Steam)
2. Or press `F10` (RedM default)
3. Find in: `RedM/screenshots/` folder

**Method 2: Windows Snipping Tool**
1. Open RedM in windowed or borderless mode
2. Press `Win + Shift + S`
3. Select area to capture
4. Save from clipboard

**Method 3: ShareX/Lightshot**
1. Configure capture hotkey
2. Take screenshot
3. Auto-save to designated folder

### Console Screenshots

**Method 1: Server Console**
1. Start server with resource loaded
2. Wait for complete startup
3. Capture console window

**Method 2: Log File**
1. Open server log file
2. Display in text editor
3. Capture relevant section

### Code Editor Screenshots

**Method 1: VS Code**
1. Open `config.lua`
2. Scroll to desired section
3. Capture window (Ctrl + Shift + P → "Screenshot")

**Method 2: Direct Capture**
1. Open file in preferred editor
2. Use screenshot tool
3. Crop to relevant area

---

## ✅ Checklist

Before submitting screenshots, verify:

- [ ] All 8 required screenshots captured
- [ ] Files named according to convention
- [ ] Stored in correct directory (`docs/assets/screenshots/`)
- [ ] PNG format used
- [ ] Resolution meets minimum requirements (1280x720+)
- [ ] Images are clear and readable
- [ ] No sensitive information visible (player names, IPs, etc.)
- [ ] File sizes under 5MB each
- [ ] Consistent quality across all screenshots
- [ ] All text is readable without zooming

---

## 🎨 Optional Screenshots

Additional screenshots that enhance documentation (not required):

- **Setup Process** - Installation steps
- **Database Tables** - Schema visualization
- **Error Messages** - Common error examples
- **Admin Commands** - Admin tools in action
- **Multiple NPCs** - All quest givers in one image
- **Difficulty Comparison** - Side-by-side quest difficulties
- **XP Progress** - Leveling system visualization
- **Cooldown Timer** - Cooldown notification example

Store optional screenshots in:
```
docs/assets/screenshots/optional/
```

---

## 📝 Notes for Contributors

When adding new features, update this document with:
1. New screenshot requirements
2. Updated numbering if needed
3. Technical specifications for new UI elements
4. Guidelines for capturing new features

**Version Control:**
- Commit screenshots with descriptive messages
- Include screenshot file changes in pull requests
- Update this document if requirements change

---

## 🔗 Related Documentation

- 📖 [Installation Guide](../installation.md)
- 🎯 [Configuration Guide](./configuration.md)
- 🔧 [Framework Integration](./frameworks.md)
- 🎮 [Events & API Reference](./events.md)

---

## 📚 Resources

### Screenshot Tools

- **ShareX** - https://getsharex.com/ (Windows, Free)
- **Lightshot** - https://app.prntscr.com/ (Cross-platform, Free)
- **Greenshot** - https://getgreenshot.org/ (Windows, Free)
- **Flameshot** - https://flameshot.org/ (Linux, Free)
- **Snagit** - https://www.techsmith.com/screen-capture.html (Premium)

### Image Optimization

- **TinyPNG** - https://tinypng.com/ (PNG compression)
- **ImageOptim** - https://imageoptim.com/ (Mac, Free)
- **RIOT** - https://riot-optimizer.com/ (Windows, Free)

### Code Editor Themes

- **VS Code Dark+** - Built-in VS Code theme
- **Monokai Pro** - https://monokai.pro/
- **One Dark Pro** - VS Code marketplace

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
