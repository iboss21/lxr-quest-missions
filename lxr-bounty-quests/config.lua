--[[
    ██╗      █████╗ ███╗   ██╗██████╗      ██████╗ ███████╗    ██╗    ██╗ ██████╗ ██╗    ██╗   ██╗███████╗███████╗
    ██║     ██╔══██╗████╗  ██║██╔══██╗    ██╔═══██╗██╔════╝    ██║    ██║██╔═══██╗██║    ██║   ██║██╔════╝██╔════╝
    ██║     ███████║██╔██╗ ██║██║  ██║    ██║   ██║█████╗      ██║ █╗ ██║██║   ██║██║    ██║   ██║█████╗  ███████╗
    ██║     ██╔══██║██║╚██╗██║██║  ██║    ██║   ██║██╔══╝      ██║███╗██║██║   ██║██║    ╚██╗ ██╔╝██╔══╝  ╚════██║
    ███████╗██║  ██║██║ ╚████║██████╔╝    ╚██████╔╝██║         ╚███╔███╔╝╚██████╔╝███████╗╚████╔╝ ███████╗███████║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═╝          ╚══╝╚══╝  ╚═════╝ ╚══════╝ ╚═══╝  ╚══════╝╚══════╝
                                                                                                                    
    🐺 LXR Bounty Quests System - Configuration
    
    This configuration file controls all aspects of the bounty quest system.
    Players can hunt down dangerous targets, complete quests, earn rewards, and unlock new content.
    
    ═══════════════════════════════════════════════════════════════════════════════
    SERVER INFORMATION
    ═══════════════════════════════════════════════════════════════════════════════
    
    Server:      The Land of Wolves 🐺
    Tagline:     Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!
    Description: ისტორია ცოცხლდება აქ! (History Lives Here!)
    Type:        Serious Hardcore Roleplay
    Access:      Discord & Whitelisted
    
    Developer:   iBoss21 / The Lux Empire
    Website:     https://www.wolves.land
    Discord:     https://discord.gg/CrKcWdfd3A
    GitHub:      https://github.com/iBoss21
    Store:       https://theluxempire.tebex.io
    Server:      https://servers.redm.net/servers/detail/8gj7eb
    
    ═══════════════════════════════════════════════════════════════════════════════
    
    Version: 2.0.0
    Performance Target: Optimized for minimal server overhead and client FPS impact
    
    Tags: RedM, Georgian, SeriousRP, Whitelist, Bounty, Quests, Economy, RPG
    
    Framework Support:
    - LXRCore (Primary)
    - RSG Core (Primary)
    - VORP Core
    - RedEM:RP
    - QBR Core
    - QR Core
    - Standalone
    
    ═══════════════════════════════════════════════════════════════════════════════
    CREDITS
    ═══════════════════════════════════════════════════════════════════════════════
    
    Script Author: iBoss21 / The Lux Empire for The Land of Wolves
    Inspired by: RicX Bounty Quests & Various RPG Quest Systems
    
    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 RESOURCE NAME PROTECTION - RUNTIME CHECK
-- ═══════════════════════════════════════════════════════════════════════════════
-- Additional safeguard: Verify resource name at config load time
-- This prevents the script from functioning if renamed
-- ═══════════════════════════════════════════════════════════════════════════════

local REQUIRED_RESOURCE_NAME = "lxr-bounty-quests"
local currentResourceName = GetCurrentResourceName()

if currentResourceName ~= REQUIRED_RESOURCE_NAME then
    error(string.format([[
        
        ═══════════════════════════════════════════════════════════════════════════════
        ❌ CRITICAL ERROR: RESOURCE NAME MISMATCH ❌
        ═══════════════════════════════════════════════════════════════════════════════
        
        Expected: %s
        Got: %s
        
        This resource is branded and must maintain the correct name.
        Rename the folder to "%s" to continue.
        
        🐺 wolves.land - The Land of Wolves
        
        ═══════════════════════════════════════════════════════════════════════════════
        
    ]], REQUIRED_RESOURCE_NAME, currentResourceName, REQUIRED_RESOURCE_NAME))
end

Config = {}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ SERVER BRANDING & INFO ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

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

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ FRAMEWORK CONFIGURATION ███████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

--[[
    Framework Priority (in order):
    1. LXRCore (Primary) - https://github.com/lxrcore - The Land of Wolves
    2. RSG-Core (Primary) - https://github.com/Rexshack-RedM
    3. QBR Core - QB-Core for RedM
    4. QR Core - QR Core Framework
    5. VORP Core (Legacy Support)
    6. RedEM:RP (Legacy Support)
    7. Standalone (No Framework)
    
    The script will auto-detect which framework is running.
    Set Config.Framework to override auto-detection.
]]

Config.Framework = 'auto' -- Options: 'auto', 'lxrcore', 'rsg-core', 'qbr-core', 'qr-core', 'vorp', 'redemrp', 'standalone'

-- Framework-specific resource names and triggers
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
    ['rsg-core'] = {
        enabled = true,
        resource = 'rsg-core',
        exportName = 'rsg-core',
        getSharedObject = 'rsg-core:getSharedObject',
        playerLoaded = 'RSGCore:Client:OnPlayerLoaded',
        playerUnloaded = 'RSGCore:Client:OnPlayerUnload',
        jobUpdate = 'RSGCore:Client:OnJobUpdate',
        notification = 'rsg',
    },
    ['qbr-core'] = {
        enabled = true,
        resource = 'qbr-core',
        exportName = 'qbr-core',
        getSharedObject = 'qbr-core:getSharedObject',
        playerLoaded = 'QBCore:Client:OnPlayerLoaded',
        playerUnloaded = 'QBCore:Client:OnPlayerUnload',
        jobUpdate = 'QBCore:Client:OnJobUpdate',
        notification = 'qb',
    },
    ['qr-core'] = {
        enabled = true,
        resource = 'qr-core',
        exportName = 'qr-core',
        getSharedObject = 'qr-core:getSharedObject',
        playerLoaded = 'QR:Client:OnPlayerLoaded',
        playerUnloaded = 'QR:Client:OnPlayerUnload',
        jobUpdate = 'QR:Client:OnJobUpdate',
        notification = 'qr',
    },
    vorp = {
        enabled = true,
        resource = 'vorp_core',
        exportName = 'vorp_core',
        getSharedObject = 'vorp:getSharedObject',
        playerLoaded = 'vorp:SelectedCharacter',
        playerUnloaded = 'vorp:PlayerLogout',
        jobUpdate = 'vorp:updateJob',
        notification = 'vorp',
    },
    redemrp = {
        enabled = true,
        resource = 'redem_roleplay',
        exportName = 'redem_roleplay',
        getSharedObject = 'redem:getSharedObject',
        playerLoaded = 'RedEM:PlayerLoaded',
        playerUnloaded = 'RedEM:PlayerUnload',
        jobUpdate = 'RedEM:JobUpdate',
        notification = 'redemrp',
    },
    standalone = {
        enabled = true,
        resource = nil,
        exportName = nil,
        notification = 'native',
    }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ LANGUAGE CONFIGURATION ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Lang = 'English' -- Options: 'English', 'French', 'German', 'Spanish', 'Italian', 'Georgian'

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ GENERAL QUEST SETTINGS ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.EnableQuests = true -- Enable/disable the entire quest system
Config.EnableDebug = false -- Enable debug messages in console/chat
Config.EnableBlips = true -- Show quest NPCs on the map
Config.EnablePrompts = true -- Show prompts when near quest NPCs

-- Keybinds
Config.Keys = {
    OpenQuestMenu = 0xD9D0E1C0, -- [SPACE] - Interact with quest NPC
    IdentifyTarget = 0xC7B5340A, -- [E] - Identify bounty target
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████ QUEST COOLDOWN & TIMING SETTINGS ██████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Cooldowns = {
    -- Global cooldown between quests (in minutes)
    GlobalCooldown = 15, -- Player must wait 15 minutes before accepting another quest
    
    -- Cooldown per quest type (in minutes)
    EasyQuestCooldown = 10, -- Easy difficulty quests
    MediumQuestCooldown = 20, -- Medium difficulty quests
    HardQuestCooldown = 30, -- Hard difficulty quests
    LegendaryQuestCooldown = 60, -- Legendary difficulty quests
    
    -- Time limit to complete a quest (in minutes)
    QuestTimeLimit = 45, -- Player has 45 minutes to complete quest or it fails
    
    -- Reward collection timeout (in minutes)
    RewardCollectionTimeout = 120, -- Player has 2 hours to collect rewards before they expire
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ XP & PROGRESSION SETTINGS █████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.XPSystem = {
    Enabled = true, -- Enable XP rewards for completing quests
    
    -- XP rewards by quest difficulty
    EasyQuestXP = 50,
    MediumQuestXP = 100,
    HardQuestXP = 200,
    LegendaryQuestXP = 500,
    
    -- Bonus XP multipliers
    Bonuses = {
        HeadshotBonus = 1.25, -- 25% bonus XP for headshot kills
        MeleeBonus = 1.5, -- 50% bonus XP for melee kills
        NoAlertBonus = 1.3, -- 30% bonus XP for stealth (no alert)
        TimeBonus = 1.2, -- 20% bonus XP for completing quickly (under 50% time)
        PerfectBonus = 2.0, -- 100% bonus XP for perfect completion (all bonuses)
    },
    
    -- Level thresholds for unlocking content
    LevelRequired = {
        EasyQuests = 0, -- No level requirement
        MediumQuests = 5, -- Requires level 5
        HardQuests = 10, -- Requires level 10
        LegendaryQuests = 20, -- Requires level 20
        SpecialShop = 15, -- Requires level 15 to access special shop
    }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ ECONOMY & REWARD SETTINGS █████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Economy = {
    Currency = 'money', -- Options: 'money', 'gold', 'cash', depends on framework
    
    -- Base reward amounts by difficulty
    BaseRewards = {
        Easy = {min = 25, max = 50},
        Medium = {min = 75, max = 150},
        Hard = {min = 200, max = 350},
        Legendary = {min = 500, max = 1000},
    },
    
    -- Weapon-specific bonus rewards (encourage weapon variety)
    WeaponBonuses = {
        -- Pistols & Revolvers
        ['WEAPON_REVOLVER_CATTLEMAN'] = 10,
        ['WEAPON_REVOLVER_SCHOFIELD'] = 15,
        ['WEAPON_REVOLVER_NAVY'] = 20,
        ['WEAPON_PISTOL_MAUSER'] = 25,
        ['WEAPON_PISTOL_SEMIAUTO'] = 25,
        
        -- Rifles
        ['WEAPON_RIFLE_SPRINGFIELD'] = 30,
        ['WEAPON_RIFLE_BOLTACTION'] = 30,
        ['WEAPON_RIFLE_VARMINT'] = 15,
        ['WEAPON_SNIPERRIFLE_CARCANO'] = 50,
        ['WEAPON_SNIPERRIFLE_ROLLINGBLOCK'] = 50,
        
        -- Shotguns
        ['WEAPON_SHOTGUN_DOUBLEBARREL'] = 20,
        ['WEAPON_SHOTGUN_PUMP'] = 25,
        ['WEAPON_SHOTGUN_REPEATING'] = 30,
        
        -- Melee & Throwables
        ['WEAPON_MELEE_KNIFE'] = 50,
        ['WEAPON_MELEE_MACHETE'] = 50,
        ['WEAPON_THROWN_TOMAHAWK'] = 75,
        ['WEAPON_THROWN_THROWING_KNIVES'] = 60,
        ['WEAPON_BOW'] = 40,
        ['WEAPON_BOW_IMPROVED'] = 50,
        
        -- Lasso (capture alive bonus)
        ['WEAPON_LASSO'] = 100, -- Highest bonus for capturing alive
    },
    
    -- Additional item rewards (random chance)
    ItemRewards = {
        Enabled = true,
        ChancePercent = 30, -- 30% chance to get additional item
        
        PossibleItems = {
            -- Consumables
            {item = 'consumable_meat_gristly_mutton', amount = {min = 1, max = 3}, rarity = 'common'},
            {item = 'consumable_coffee', amount = {min = 1, max = 2}, rarity = 'common'},
            {item = 'consumable_medicine', amount = {min = 1, max = 1}, rarity = 'uncommon'},
            
            -- Ammunition
            {item = 'ammorifle', amount = {min = 10, max = 30}, rarity = 'common'},
            {item = 'ammopistol', amount = {min = 10, max = 30}, rarity = 'common'},
            {item = 'ammoshotgun', amount = {min = 5, max = 15}, rarity = 'uncommon'},
            
            -- Valuables
            {item = 'goldbar', amount = {min = 1, max = 1}, rarity = 'rare'},
            {item = 'pocket_watch', amount = {min = 1, max = 1}, rarity = 'uncommon'},
            {item = 'silver_chain_bracelet', amount = {min = 1, max = 2}, rarity = 'rare'},
        }
    }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ██████████████████████ BOUNTY TARGET NPC SETTINGS ██████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.TargetNPCs = {
    -- NPC Health scaling by difficulty
    HealthMultipliers = {
        Easy = 1.0, -- Normal health (100-150 HP)
        Medium = 1.5, -- 50% more health
        Hard = 2.0, -- Double health
        Legendary = 3.0, -- Triple health
    },
    
    -- Base health ranges
    BaseHealth = {min = 100, max = 150},
    
    -- NPC accuracy and combat settings
    Accuracy = {
        Easy = 0.3, -- 30% accuracy
        Medium = 0.5, -- 50% accuracy
        Hard = 0.7, -- 70% accuracy
        Legendary = 0.9, -- 90% accuracy
    },
    
    -- Combat behavior
    Combat = {
        FleeHealthPercent = 20, -- NPC tries to flee when below 20% health
        UsesCover = true, -- NPCs use cover during combat
        CallsForHelp = true, -- NPCs can call for backup
        
        -- Aggression levels (affects combat style)
        Aggression = {
            Easy = 0.3,
            Medium = 0.6,
            Hard = 0.8,
            Legendary = 1.0,
        }
    },
    
    -- NPC Weapon loadouts by difficulty
    WeaponLoadouts = {
        Easy = {
            'WEAPON_REVOLVER_CATTLEMAN',
            'WEAPON_RIFLE_VARMINT',
            'WEAPON_MELEE_KNIFE',
        },
        Medium = {
            'WEAPON_REVOLVER_SCHOFIELD',
            'WEAPON_RIFLE_BOLTACTION',
            'WEAPON_SHOTGUN_DOUBLEBARREL',
            'WEAPON_MELEE_KNIFE',
        },
        Hard = {
            'WEAPON_REVOLVER_NAVY',
            'WEAPON_RIFLE_SPRINGFIELD',
            'WEAPON_SHOTGUN_PUMP',
            'WEAPON_SNIPERRIFLE_ROLLINGBLOCK',
            'WEAPON_MELEE_MACHETE',
        },
        Legendary = {
            'WEAPON_PISTOL_MAUSER',
            'WEAPON_PISTOL_SEMIAUTO',
            'WEAPON_RIFLE_BOLTACTION',
            'WEAPON_SHOTGUN_REPEATING',
            'WEAPON_SNIPERRIFLE_CARCANO',
            'WEAPON_MELEE_MACHETE',
        }
    }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ GUARD NPC SETTINGS ████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Guards = {
    Enabled = true, -- Enable guards protecting targets
    
    -- Number of guards by difficulty
    GuardCount = {
        Easy = {min = 1, max = 2},
        Medium = {min = 2, max = 4},
        Hard = {min = 4, max = 6},
        Legendary = {min = 6, max = 8},
    },
    
    -- Guard spawn radius around target
    SpawnRadius = {min = 5.0, max = 15.0},
    
    -- Guard health (slightly less than targets)
    HealthMultiplier = 0.8, -- 80% of target health
    
    -- Guard models (human NPCs)
    HumanGuardModels = {
        'A_M_O_SDCowpoke_01',
        'A_M_M_RanchersGangSec_01',
        'A_M_M_UniBoatCrew_01',
        'A_M_M_ValPosse_01',
        'G_M_M_UniBanditos_01',
        'G_M_M_UniCriminals_01',
        'G_M_M_UniFedRuffians_01',
    },
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ ANIMAL GUARD SETTINGS █████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.AnimalGuards = {
    Enabled = true, -- Enable animal guards (wolves, bears, etc.)
    
    -- Chance for animal guards to spawn (by difficulty)
    SpawnChance = {
        Easy = 0.1, -- 10% chance
        Medium = 0.25, -- 25% chance
        Hard = 0.5, -- 50% chance
        Legendary = 0.75, -- 75% chance
    },
    
    -- Number of animal guards
    Count = {
        Easy = {min = 1, max = 2},
        Medium = {min = 2, max = 3},
        Hard = {min = 3, max = 4},
        Legendary = {min = 4, max = 6},
    },
    
    -- Animal types and their configurations
    AnimalTypes = {
        {
            model = 'A_C_Wolf',
            name = 'Wolf',
            health = {min = 80, max = 120},
            damage = {min = 15, max = 25},
            speed = 1.2, -- Movement speed multiplier
            aggression = 0.9,
        },
        {
            model = 'A_C_Wolf_Medium',
            name = 'Timber Wolf',
            health = {min = 100, max = 140},
            damage = {min = 20, max = 30},
            speed = 1.3,
            aggression = 1.0,
        },
        {
            model = 'A_C_Bear_01',
            name = 'Black Bear',
            health = {min = 200, max = 300},
            damage = {min = 30, max = 50},
            speed = 0.9,
            aggression = 0.8,
        },
        {
            model = 'A_C_BearGrizzly_01',
            name = 'Grizzly Bear',
            health = {min = 300, max = 450},
            damage = {min = 40, max = 70},
            speed = 0.85,
            aggression = 1.0,
        },
        {
            model = 'A_C_Panther_01',
            name = 'Panther',
            health = {min = 120, max = 180},
            damage = {min = 25, max = 40},
            speed = 1.5,
            aggression = 1.0,
        },
        {
            model = 'A_C_Cougar_01',
            name = 'Cougar',
            health = {min = 110, max = 160},
            damage = {min = 22, max = 38},
            speed = 1.4,
            aggression = 0.95,
        },
        {
            model = 'A_C_Alligator_01',
            name = 'Alligator',
            health = {min = 150, max = 250},
            damage = {min = 35, max = 60},
            speed = 0.7,
            aggression = 0.9,
        }
    },
    
    -- Animal spawn behavior
    SpawnBehavior = {
        SpawnRadius = {min = 10.0, max = 25.0}, -- Distance from target
        PatrolRadius = 15.0, -- How far animals roam
        AlertRadius = 30.0, -- Distance at which they detect player
    }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ QUEST NPC CONFIGURATION ███████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.QuestNPCs = {
    -- Valentine - Sheriff Office
    {
        id = 'valentine_sheriff',
        name = 'Sheriff Curtis Malloy',
        blipName = 'Bounty Quest - Sheriff',
        model = 'S_M_M_ValSheriff_01',
        coords = vector4(-275.71, 805.01, 118.39, 270.0),
        blipSprite = 'blip_bounty_poster_4',
        
        -- Requirements to unlock this NPC
        requirements = {
            level = 0, -- No level requirement (starter NPC)
            completedQuests = {}, -- No prerequisites
            job = nil, -- No job requirement
        },
        
        -- Available quest difficulties from this NPC
        availableQuests = {'easy', 'medium'},
        
        -- Shop access
        hasShop = true,
        shopId = 'valentine_bounty_shop',
    },
    
    -- Strawberry - Town Marshal
    {
        id = 'strawberry_marshal',
        name = 'Marshal Thomas Huxley',
        blipName = 'Bounty Quest - Marshal',
        model = 'U_M_M_ValLawman_01',
        coords = vector4(-1809.19, -354.20, 164.66, 90.0),
        blipSprite = 'blip_bounty_poster_4',
        
        requirements = {
            level = 5,
            completedQuests = {'valentine_sheriff'}, -- Must complete at least 1 quest from Valentine
            job = nil,
        },
        
        availableQuests = {'easy', 'medium', 'hard'},
        hasShop = true,
        shopId = 'strawberry_bounty_shop',
    },
    
    -- Rhodes - Sheriff Office
    {
        id = 'rhodes_sheriff',
        name = 'Sheriff Gray',
        blipName = 'Bounty Quest - Sheriff',
        model = 'S_M_M_RhdSheriff_01',
        coords = vector4(1361.22, -1303.01, 77.77, 180.0),
        blipSprite = 'blip_bounty_poster_4',
        
        requirements = {
            level = 10,
            completedQuests = {'valentine_sheriff', 'strawberry_marshal'},
            job = nil,
        },
        
        availableQuests = {'medium', 'hard'},
        hasShop = true,
        shopId = 'rhodes_bounty_shop',
    },
    
    -- Saint Denis - Police Department
    {
        id = 'saintdenis_police',
        name = 'Chief Inspector Archibald',
        blipName = 'Bounty Quest - Police',
        model = 'S_M_M_SDPolice_01',
        coords = vector4(2513.14, -1309.84, 48.96, 0.0),
        blipSprite = 'blip_bounty_poster_4',
        
        requirements = {
            level = 15,
            completedQuests = {'valentine_sheriff', 'strawberry_marshal', 'rhodes_sheriff'},
            job = nil,
        },
        
        availableQuests = {'hard', 'legendary'},
        hasShop = true,
        shopId = 'saintdenis_bounty_shop',
    },
    
    -- Blackwater - Law Office
    {
        id = 'blackwater_law',
        name = 'Marshal Davis',
        blipName = 'Bounty Quest - Marshal',
        model = 'S_M_M_BwmMarshall_01',
        coords = vector4(-762.61, -1269.22, 43.63, 270.0),
        blipSprite = 'blip_bounty_poster_4',
        
        requirements = {
            level = 20,
            completedQuests = {'saintdenis_police'},
            job = nil,
        },
        
        availableQuests = {'legendary'},
        hasShop = true,
        shopId = 'blackwater_legendary_shop',
    },
    
    -- Tumbleweed - Desert Bounty Hunter
    {
        id = 'tumbleweed_hunter',
        name = 'Bounty Hunter Morgan',
        blipName = 'Bounty Quest - Hunter',
        model = 'A_M_M_RanchersGangSec_01',
        coords = vector4(-5519.55, -2906.48, -2.18, 180.0),
        blipSprite = 'blip_bounty_poster_4',
        
        requirements = {
            level = 25,
            completedQuests = {'blackwater_law'},
            job = nil,
        },
        
        availableQuests = {'legendary'},
        hasShop = true,
        shopId = 'tumbleweed_elite_shop',
    },
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ QUEST DEFINITIONS █████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Quests = {
    -- ========== EASY QUESTS ==========
    {
        id = 'easy_outlaw_hideout',
        difficulty = 'easy',
        title = 'Petty Thief - John Marrow',
        description = 'A petty thief has been stealing from local shops. Track him down at his hideout.',
        targetModel = 'G_M_M_UniCriminals_01',
        targetName = 'John Marrow',
        location = vector3(-1489.85, -2195.46, 43.80), -- West Elizabeth
        rewardMultiplier = 1.0,
    },
    {
        id = 'easy_horse_rustler',
        difficulty = 'easy',
        title = 'Horse Rustler - Billy Thompson',
        description = 'A horse rustler has been stealing horses from ranches near Valentine.',
        targetModel = 'A_M_O_SDCowpoke_01',
        targetName = 'Billy Thompson',
        location = vector3(-453.62, 395.73, 105.01), -- Near Valentine
        rewardMultiplier = 1.0,
    },
    
    -- ========== MEDIUM QUESTS ==========
    {
        id = 'medium_gang_member',
        difficulty = 'medium',
        title = 'Gang Member - "Scarface" Pete',
        description = 'A dangerous gang member wanted for multiple robberies. Last seen near Strawberry.',
        targetModel = 'G_M_M_UniBanditos_01',
        targetName = 'Scarface Pete',
        location = vector3(-1678.32, -525.09, 141.64), -- Strawberry area
        rewardMultiplier = 1.2,
    },
    {
        id = 'medium_murderer',
        difficulty = 'medium',
        title = 'Wanted Murderer - Jack "The Knife" Sullivan',
        description = 'A cold-blooded killer. Approach with extreme caution.',
        targetModel = 'G_M_M_UniFedRuffians_01',
        targetName = 'Jack Sullivan',
        location = vector3(1437.55, -1376.90, 78.48), -- Near Rhodes
        rewardMultiplier = 1.3,
    },
    
    -- ========== HARD QUESTS ==========
    {
        id = 'hard_gang_leader',
        difficulty = 'hard',
        title = 'Gang Leader - "Black" Jack Morrison',
        description = 'Leader of a notorious gang. Heavily guarded and extremely dangerous.',
        targetModel = 'G_M_M_UniBanditos_01',
        targetName = 'Black Jack Morrison',
        location = vector3(2640.94, -1127.32, 53.33), -- Near Saint Denis
        rewardMultiplier = 1.5,
    },
    {
        id = 'hard_serial_killer',
        difficulty = 'hard',
        title = 'Serial Killer - "The Butcher"',
        description = 'A deranged serial killer. Known to be accompanied by wolves. Extreme danger.',
        targetModel = 'A_M_M_RanchersGangSec_01',
        targetName = 'The Butcher',
        location = vector3(-910.68, 1780.63, 234.77), -- Remote area
        rewardMultiplier = 1.8,
    },
    
    -- ========== LEGENDARY QUESTS ==========
    {
        id = 'legendary_crime_boss',
        difficulty = 'legendary',
        title = 'Crime Boss - Vincenzo "The Wolf" Romano',
        description = 'The most wanted man in the territory. Leader of the Romano crime family. Extremely well protected.',
        targetModel = 'A_M_M_RanchersGangSec_01',
        targetName = 'Vincenzo Romano',
        location = vector3(-783.99, -1310.44, 43.88), -- Blackwater area
        rewardMultiplier = 2.5,
    },
    {
        id = 'legendary_outlaw_king',
        difficulty = 'legendary',
        title = 'The Outlaw King - "Red Death" Morgan',
        description = 'A legendary outlaw who commands an army. The ultimate bounty.',
        targetModel = 'G_M_M_UniBanditos_01',
        targetName = 'Red Death Morgan',
        location = vector3(-5627.38, -3392.74, -21.40), -- Remote West
        rewardMultiplier = 3.0,
    },
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ SHOP CONFIGURATIONS ███████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Shops = {
    -- Valentine Bounty Shop
    valentine_bounty_shop = {
        name = 'Valentine Bounty Hunter Supplies',
        items = {
            {item = 'weapon_revolver_cattleman', label = 'Cattleman Revolver', price = 50, currency = 'money'},
            {item = 'ammorifle', label = 'Rifle Ammo (x50)', price = 10, currency = 'money', amount = 50},
            {item = 'ammopistol', label = 'Pistol Ammo (x50)', price = 8, currency = 'money', amount = 50},
            {item = 'consumable_medicine', label = 'Medicine', price = 15, currency = 'money'},
            {item = 'weapon_lasso', label = 'Reinforced Lasso', price = 25, currency = 'money'},
        }
    },
    
    -- Strawberry Bounty Shop
    strawberry_bounty_shop = {
        name = 'Strawberry Bounty Supplies',
        items = {
            {item = 'weapon_revolver_schofield', label = 'Schofield Revolver', price = 150, currency = 'money'},
            {item = 'weapon_rifle_boltaction', label = 'Bolt Action Rifle', price = 200, currency = 'money'},
            {item = 'ammoshotgun', label = 'Shotgun Ammo (x30)', price = 15, currency = 'money', amount = 30},
            {item = 'consumable_medicine', label = 'Medicine', price = 15, currency = 'money'},
            {item = 'consumable_potent_medicine', label = 'Potent Medicine', price = 30, currency = 'money'},
        }
    },
    
    -- Rhodes Bounty Shop
    rhodes_bounty_shop = {
        name = 'Rhodes Bounty Equipment',
        items = {
            {item = 'weapon_shotgun_pump', label = 'Pump Shotgun', price = 250, currency = 'money'},
            {item = 'weapon_rifle_springfield', label = 'Springfield Rifle', price = 300, currency = 'money'},
            {item = 'ammo_rifle_elephant', label = 'Elephant Rifle Ammo', price = 25, currency = 'money', amount = 10},
            {item = 'consumable_potent_medicine', label = 'Potent Medicine', price = 30, currency = 'money'},
            {item = 'weapon_melee_knife_hunting', label = 'Hunting Knife', price = 50, currency = 'money'},
        }
    },
    
    -- Saint Denis Police Shop
    saintdenis_bounty_shop = {
        name = 'Saint Denis Police Armory',
        items = {
            {item = 'weapon_pistol_mauser', label = 'Mauser Pistol', price = 400, currency = 'money'},
            {item = 'weapon_sniperrifle_rollingblock', label = 'Rolling Block Rifle', price = 500, currency = 'money'},
            {item = 'weapon_shotgun_repeating', label = 'Repeating Shotgun', price = 350, currency = 'money'},
            {item = 'consumable_potent_medicine', label = 'Potent Medicine', price = 30, currency = 'money'},
            {item = 'consumable_special_medicine', label = 'Special Medicine', price = 50, currency = 'money'},
        }
    },
    
    -- Blackwater Legendary Shop
    blackwater_legendary_shop = {
        name = 'Blackwater Elite Bounty Equipment',
        levelRequired = 20,
        items = {
            {item = 'weapon_pistol_semiauto', label = 'Semi-Auto Pistol', price = 600, currency = 'money'},
            {item = 'weapon_sniperrifle_carcano', label = 'Carcano Rifle', price = 800, currency = 'money'},
            {item = 'weapon_bow_improved', label = 'Improved Bow', price = 400, currency = 'money'},
            {item = 'consumable_special_medicine', label = 'Special Medicine', price = 50, currency = 'money'},
            {item = 'weapon_thrown_tomahawk', label = 'Tomahawk', price = 100, currency = 'money'},
        }
    },
    
    -- Tumbleweed Elite Shop
    tumbleweed_elite_shop = {
        name = 'Tumbleweed Legendary Hunter Supplies',
        levelRequired = 25,
        items = {
            {item = 'weapon_rifle_springfield', label = 'Springfield Rifle (Legendary)', price = 1000, currency = 'money'},
            {item = 'weapon_sniperrifle_carcano', label = 'Carcano Rifle (Legendary)', price = 1200, currency = 'money'},
            {item = 'goldbar', label = 'Gold Bar', price = 500, currency = 'money'},
            {item = 'consumable_special_medicine', label = 'Special Medicine (x5)', price = 200, currency = 'money', amount = 5},
            {item = 'ammo_special_sniper', label = 'Special Sniper Ammo', price = 50, currency = 'money', amount = 20},
        }
    },
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████ NOTIFICATION & UI SETTINGS ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Notifications = {
    -- Show notifications on screen
    Enabled = true,
    
    -- Notification duration (in milliseconds)
    Duration = 5000,
    
    -- Notification types with colors
    Types = {
        success = {r = 34, g = 139, b = 34}, -- Green
        error = {r = 220, g = 20, b = 60}, -- Red
        warning = {r = 255, g = 165, b = 0}, -- Orange
        info = {r = 30, g = 144, b = 255}, -- Blue
    }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████ ADVANCED FEATURES & SETTINGS ██████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.AdvancedFeatures = {
    -- Dynamic weather for quests
    DynamicWeather = {
        Enabled = false, -- Change weather during legendary quests
        LegendaryQuestWeather = 'THUNDER', -- Weather type for legendary quests
    },
    
    -- Reputation system
    Reputation = {
        Enabled = true,
        AffectsLawmen = true, -- Good reputation with law
        AffectsOutlaws = false, -- Bad reputation with outlaws
    },
    
    -- Quest tracking
    QuestTracking = {
        ShowQuestMarkers = true, -- Show markers for active quest objectives
        ShowDistanceToTarget = true, -- Show distance in meters
        UpdateInterval = 1000, -- Update every 1 second (in ms)
    },
    
    -- Death penalties
    DeathPenalty = {
        Enabled = true,
        LoseQuestOnDeath = true, -- Player loses active quest if they die
        KeepRewardsOnFailure = false, -- Player loses collected rewards
    },
    
    -- Anti-cheat
    AntiCheat = {
        Enabled = true,
        MaxDistanceFromTarget = 500.0, -- Max distance before quest auto-fails
        RequireTargetIdentification = true, -- Must identify target to complete
        PreventFriendlyFire = true, -- Prevent killing quest NPCs early
    }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ DATABASE TABLE NAMES ██████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.DatabaseTables = {
    PlayerQuests = 'lxr_bounty_player_quests',
    QuestProgress = 'lxr_bounty_quest_progress',
    ShopPurchases = 'lxr_bounty_shop_purchases',
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ██████████████████████████ DEBUG & TESTING █████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Debug = {
    Enabled = Config.EnableDebug,
    ShowTargetInfo = false, -- Show target health/info
    ShowGuardInfo = false, -- Show guard spawn info
    ShowQuestStates = false, -- Print quest state changes
    AllowQuestSkip = false, -- Allow skipping quests (ONLY FOR TESTING)
    UnlockAllQuests = false, -- Unlock all quests regardless of requirements (TESTING ONLY)
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ██████████████████████████████ END OF CONFIG ███████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

print([[
    ^3═══════════════════════════════════════════════════════════════════════════════^0
    ^2🐺 Land of Wolves - Bounty Quests System Loaded^0
    ^3═══════════════════════════════════════════════════════════════════════════════^0
    ^5Version:^0 2.0.0
    ^5Framework:^0 ]] .. Config.Framework .. [[
    ^5Language:^0 ]] .. Config.Lang .. [[
    ^5Quest NPCs:^0 ]] .. #Config.QuestNPCs .. [[
    ^5Total Quests:^0 ]] .. #Config.Quests .. [[
    ^3═══════════════════════════════════════════════════════════════════════════════^0
    ^6🐺 wolves.land - The Land of Wolves^0
    ^3═══════════════════════════════════════════════════════════════════════════════^0
]])