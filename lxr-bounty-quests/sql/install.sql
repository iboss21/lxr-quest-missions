-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 Land of Wolves - Bounty Quests System Database Schema
-- © 2026 iBoss21 / The Lux Empire | wolves.land
-- ═══════════════════════════════════════════════════════════════════════════════

-- Player Quest Data Table
-- Stores overall player quest statistics and progression
CREATE TABLE IF NOT EXISTS `lxr_bounty_player_quests` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(50) NOT NULL COMMENT 'Player identifier (steam, license, etc.)',
    `charid` INT(11) DEFAULT NULL COMMENT 'Character ID (if using multi-character)',
    
    -- Stats
    `total_quests_completed` INT(11) DEFAULT 0,
    `easy_quests_completed` INT(11) DEFAULT 0,
    `medium_quests_completed` INT(11) DEFAULT 0,
    `hard_quests_completed` INT(11) DEFAULT 0,
    `legendary_quests_completed` INT(11) DEFAULT 0,
    
    -- XP & Level
    `total_xp` INT(11) DEFAULT 0,
    `current_level` INT(11) DEFAULT 0,
    
    -- Economy
    `total_money_earned` DECIMAL(10,2) DEFAULT 0.00,
    `total_gold_earned` DECIMAL(10,2) DEFAULT 0.00,
    
    -- Reputation
    `reputation` INT(11) DEFAULT 0 COMMENT 'Bounty hunter reputation score',
    
    -- Unlocks
    `unlocked_npcs` TEXT DEFAULT NULL COMMENT 'JSON array of unlocked NPC IDs',
    `unlocked_shops` TEXT DEFAULT NULL COMMENT 'JSON array of unlocked shop IDs',
    
    -- Timestamps
    `last_quest_time` TIMESTAMP NULL DEFAULT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_player` (`identifier`, `charid`),
    KEY `idx_identifier` (`identifier`),
    KEY `idx_level` (`current_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Quest Progress Table
-- Stores active and historical quest data
CREATE TABLE IF NOT EXISTS `lxr_bounty_quest_progress` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(50) NOT NULL,
    `charid` INT(11) DEFAULT NULL,
    
    -- Quest Info
    `quest_id` VARCHAR(100) NOT NULL,
    `quest_difficulty` ENUM('easy', 'medium', 'hard', 'legendary') NOT NULL,
    `npc_id` VARCHAR(100) NOT NULL COMMENT 'Quest giver NPC ID',
    
    -- Status
    `status` ENUM('active', 'completed', 'failed', 'abandoned') NOT NULL DEFAULT 'active',
    
    -- Progress Data
    `target_killed` TINYINT(1) DEFAULT 0,
    `guards_killed` INT(11) DEFAULT 0,
    `animals_killed` INT(11) DEFAULT 0,
    `target_identified` TINYINT(1) DEFAULT 0,
    `rewards_collected` TINYINT(1) DEFAULT 0,
    
    -- Combat Stats
    `kill_weapon` VARCHAR(100) DEFAULT NULL COMMENT 'Weapon used for final kill',
    `headshot_kill` TINYINT(1) DEFAULT 0,
    `melee_kill` TINYINT(1) DEFAULT 0,
    `stealth_kill` TINYINT(1) DEFAULT 0,
    `time_to_complete` INT(11) DEFAULT NULL COMMENT 'Time taken in seconds',
    
    -- Rewards
    `money_reward` DECIMAL(10,2) DEFAULT 0.00,
    `gold_reward` DECIMAL(10,2) DEFAULT 0.00,
    `xp_reward` INT(11) DEFAULT 0,
    `bonus_multiplier` DECIMAL(4,2) DEFAULT 1.00,
    `item_rewards` TEXT DEFAULT NULL COMMENT 'JSON array of item rewards',
    
    -- Timestamps
    `started_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `completed_at` TIMESTAMP NULL DEFAULT NULL,
    `expires_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Quest expiration time',
    
    PRIMARY KEY (`id`),
    KEY `idx_identifier` (`identifier`),
    KEY `idx_quest` (`quest_id`),
    KEY `idx_status` (`status`),
    KEY `idx_difficulty` (`quest_difficulty`),
    KEY `idx_completed` (`completed_at`),
    FOREIGN KEY (`identifier`, `charid`) REFERENCES `lxr_bounty_player_quests`(`identifier`, `charid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Shop Purchases Table
-- Tracks player purchases from bounty shops
CREATE TABLE IF NOT EXISTS `lxr_bounty_shop_purchases` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(50) NOT NULL,
    `charid` INT(11) DEFAULT NULL,
    
    -- Shop Info
    `shop_id` VARCHAR(100) NOT NULL,
    `item_name` VARCHAR(100) NOT NULL,
    `item_label` VARCHAR(255) DEFAULT NULL,
    
    -- Purchase Details
    `quantity` INT(11) DEFAULT 1,
    `unit_price` DECIMAL(10,2) NOT NULL,
    `total_price` DECIMAL(10,2) NOT NULL,
    `currency` VARCHAR(20) DEFAULT 'money',
    
    -- Timestamps
    `purchased_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (`id`),
    KEY `idx_identifier` (`identifier`),
    KEY `idx_shop` (`shop_id`),
    KEY `idx_item` (`item_name`),
    KEY `idx_purchased` (`purchased_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Quest Cooldowns Table (optional, can use in-memory cache instead)
CREATE TABLE IF NOT EXISTS `lxr_bounty_cooldowns` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(50) NOT NULL,
    `charid` INT(11) DEFAULT NULL,
    
    -- Cooldown Info
    `cooldown_type` VARCHAR(50) NOT NULL COMMENT 'global, easy, medium, hard, legendary',
    `expires_at` TIMESTAMP NOT NULL,
    
    -- Timestamps
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_cooldown` (`identifier`, `charid`, `cooldown_type`),
    KEY `idx_expires` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Leaderboards View (optional)
CREATE OR REPLACE VIEW `lxr_bounty_leaderboard` AS
SELECT 
    bpq.identifier,
    bpq.charid,
    bpq.total_quests_completed,
    bpq.legendary_quests_completed,
    bpq.current_level,
    bpq.total_xp,
    bpq.total_money_earned,
    bpq.reputation,
    bpq.updated_at
FROM `lxr_bounty_player_quests` bpq
ORDER BY bpq.total_xp DESC, bpq.legendary_quests_completed DESC, bpq.total_quests_completed DESC
LIMIT 100;

-- ═══════════════════════════════════════════════════════════════════════════════
-- Sample Items (add these to your inventory system)
-- ═══════════════════════════════════════════════════════════════════════════════

-- Example for VORP inventory (vorp_inventory items table)
/*
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES
    ('bounty_poster', 'Bounty Poster', 10, 1, 'item_standard', 1),
    ('bounty_token', 'Bounty Hunter Token', 100, 1, 'item_standard', 0),
    ('legendary_bounty_token', 'Legendary Bounty Token', 10, 1, 'item_standard', 0);
*/

-- Example for RSG/QBR Core (items in shared/items.lua or database)
/*
['bounty_poster'] = {
    ['name'] = 'bounty_poster',
    ['label'] = 'Bounty Poster',
    ['weight'] = 50,
    ['type'] = 'item',
    ['image'] = 'bounty_poster.png',
    ['unique'] = false,
    ['useable'] = true,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'A wanted poster for a dangerous criminal'
},
*/

-- ═══════════════════════════════════════════════════════════════════════════════
-- Initial Data & Permissions
-- ═══════════════════════════════════════════════════════════════════════════════

-- Add any initial configuration or admin permissions here
-- For example, admin commands to reset player data, view stats, etc.

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 End of Database Schema - wolves.land
-- ═══════════════════════════════════════════════════════════════════════════════
