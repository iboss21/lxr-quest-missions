--[[
    🐺 Land of Wolves - Bounty Quests System
    English Language File
    © 2026 iBoss21 / The Lux Empire | wolves.land
]]

Locales = Locales or {}

Locales['English'] = {
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- GENERAL
    -- ═══════════════════════════════════════════════════════════════════════════════
    ['press_to_interact'] = 'Press ~COLOR_GOLD~[SPACE]~s~ to talk to ~COLOR_GOLD~%s~s~',
    ['press_to_identify'] = 'Press ~COLOR_GOLD~[E]~s~ to identify target',
    ['too_far_away'] = 'You are too far from the NPC',
    ['not_available'] = 'This is not available right now',
    ['something_went_wrong'] = 'Something went wrong, please try again',
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- QUEST SYSTEM
    -- ═══════════════════════════════════════════════════════════════════════════════
    ['quest_menu_title'] = '🐺 Bounty Quests',
    ['quest_available'] = 'Available Quests',
    ['quest_active'] = 'Active Quest',
    ['quest_rewards'] = 'Collect Rewards',
    ['quest_shop'] = 'Bounty Hunter Shop',
    ['quest_stats'] = 'Your Statistics',
    ['quest_close_menu'] = 'Close Menu',
    
    -- Quest Actions
    ['accept_quest'] = 'Accept Quest',
    ['cancel_quest'] = 'Cancel Quest',
    ['track_quest'] = 'Track Quest',
    ['collect_rewards'] = 'Collect Rewards',
    
    -- Quest Status
    ['quest_started'] = 'Quest Started: ~COLOR_GOLD~%s~s~',
    ['quest_completed'] = 'Quest Completed! Rewards available.',
    ['quest_failed'] = 'Quest Failed: %s',
    ['quest_cancelled'] = 'Quest cancelled',
    ['quest_expired'] = 'Quest expired - time limit reached',
    
    -- Quest Progress
    ['objective_complete'] = 'Objective Complete',
    ['go_to_location'] = 'Go to the marked location',
    ['eliminate_target'] = 'Eliminate the target: %s',
    ['eliminate_guards'] = 'Eliminate the guards: %s/%s',
    ['identify_target'] = 'Identify the target to complete the quest',
    ['return_to_npc'] = 'Return to %s to collect your rewards',
    
    -- Quest Requirements
    ['level_required'] = 'Level %s required',
    ['quest_required'] = 'Complete "%s" first',
    ['job_required'] = 'Job required: %s',
    ['requirements_not_met'] = 'You do not meet the requirements for this quest',
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- COOLDOWNS
    -- ═══════════════════════════════════════════════════════════════════════════════
    ['cooldown_active'] = 'You must wait ~COLOR_GOLD~%s~s~ before accepting another quest',
    ['cooldown_minutes'] = '%s minutes',
    ['cooldown_hours'] = '%s hours',
    ['cooldown_seconds'] = '%s seconds',
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- REWARDS
    -- ═══════════════════════════════════════════════════════════════════════════════
    ['reward_money'] = 'Money: $%s',
    ['reward_gold'] = 'Gold: %s',
    ['reward_xp'] = 'XP: %s',
    ['reward_items'] = 'Items: %s',
    ['reward_level_up'] = '🎉 Level Up! You are now level %s',
    
    -- Bonuses
    ['bonus_headshot'] = '🎯 Headshot Bonus: +%s%%',
    ['bonus_melee'] = '🗡️ Melee Bonus: +%s%%',
    ['bonus_stealth'] = '🤫 Stealth Bonus: +%s%%',
    ['bonus_time'] = '⏱️ Speed Bonus: +%s%%',
    ['bonus_weapon'] = '🔫 %s Bonus: $%s',
    ['bonus_perfect'] = '⭐ Perfect Completion: +%s%%',
    
    ['rewards_collected'] = 'Rewards collected: $%s, %s XP',
    ['rewards_expired'] = 'Your rewards have expired',
    ['must_collect_rewards'] = 'You must collect your rewards before starting a new quest',
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- COMBAT & TARGET
    -- ═══════════════════════════════════════════════════════════════════════════════
    ['target_spawned'] = 'Target location marked on your map',
    ['target_nearby'] = 'The target is nearby - be careful!',
    ['target_eliminated'] = 'Target eliminated',
    ['target_identified'] = 'Target identified: %s',
    ['target_escaped'] = 'The target has escaped - quest failed',
    ['guards_alerted'] = 'Guards have been alerted!',
    ['animal_guards_nearby'] = 'Dangerous animals detected nearby!',
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- SHOP
    -- ═══════════════════════════════════════════════════════════════════════════════
    ['shop_title'] = '🛒 %s',
    ['shop_buy'] = 'Buy',
    ['shop_close'] = 'Close',
    ['shop_item_price'] = 'Price: $%s',
    ['shop_item_level'] = 'Required Level: %s',
    ['shop_purchased'] = 'Purchased: %s',
    ['shop_not_enough_money'] = 'You do not have enough money',
    ['shop_not_enough_gold'] = 'You do not have enough gold',
    ['shop_level_required'] = 'Level %s required to access this shop',
    ['shop_locked'] = 'This shop is locked. Complete more quests to unlock it.',
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- STATISTICS
    -- ═══════════════════════════════════════════════════════════════════════════════
    ['stats_title'] = '📊 Bounty Hunter Statistics',
    ['stats_level'] = 'Level: %s',
    ['stats_xp'] = 'XP: %s',
    ['stats_total_quests'] = 'Total Quests: %s',
    ['stats_easy_quests'] = 'Easy: %s',
    ['stats_medium_quests'] = 'Medium: %s',
    ['stats_hard_quests'] = 'Hard: %s',
    ['stats_legendary_quests'] = 'Legendary: %s',
    ['stats_money_earned'] = 'Money Earned: $%s',
    ['stats_gold_earned'] = 'Gold Earned: %s',
    ['stats_reputation'] = 'Reputation: %s',
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- DIFFICULTY LEVELS
    -- ═══════════════════════════════════════════════════════════════════════════════
    ['difficulty_easy'] = '⚪ Easy',
    ['difficulty_medium'] = '🟡 Medium',
    ['difficulty_hard'] = '🔴 Hard',
    ['difficulty_legendary'] = '🟣 Legendary',
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- NOTIFICATIONS
    -- ═══════════════════════════════════════════════════════════════════════════════
    ['notify_quest_started'] = 'Quest started',
    ['notify_quest_complete'] = 'Quest completed',
    ['notify_quest_failed'] = 'Quest failed',
    ['notify_level_up'] = 'Level up!',
    ['notify_reward_collected'] = 'Rewards collected',
    ['notify_shop_purchase'] = 'Item purchased',
    ['notify_cooldown'] = 'Cooldown active',
    ['notify_requirements'] = 'Requirements not met',
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- ERRORS
    -- ═══════════════════════════════════════════════════════════════════════════════
    ['error_already_active'] = 'You already have an active quest',
    ['error_no_active_quest'] = 'You do not have an active quest',
    ['error_quest_not_found'] = 'Quest not found',
    ['error_npc_not_found'] = 'NPC not found',
    ['error_target_not_spawned'] = 'Target not spawned',
    ['error_too_far'] = 'You are too far from the quest area',
    ['error_invalid_target'] = 'Invalid target',
    ['error_database'] = 'Database error - contact an administrator',
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- DEBUG (only shown when Config.Debug.Enabled = true)
    -- ═══════════════════════════════════════════════════════════════════════════════
    ['debug_quest_id'] = '[DEBUG] Quest ID: %s',
    ['debug_target_health'] = '[DEBUG] Target Health: %s/%s',
    ['debug_guards_count'] = '[DEBUG] Guards: %s',
    ['debug_distance'] = '[DEBUG] Distance: %s meters',
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- QUEST DIALOG (NPC conversations)
    -- ═══════════════════════════════════════════════════════════════════════════════
    ['npc_greeting'] = 'Hello there, bounty hunter. Looking for work?',
    ['npc_quest_available'] = 'I have some dangerous work if you\'re interested.',
    ['npc_quest_active'] = 'You still have work to do. Come back when it\'s done.',
    ['npc_quest_complete'] = 'Well done! Here\'s your payment.',
    ['npc_no_quests'] = 'I don\'t have any work for you right now. Check back later.',
    ['npc_cooldown'] = 'You need to rest up before taking another job.',
    ['npc_locked'] = 'You need to prove yourself first before I can trust you with this work.',
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- HELP TEXT
    -- ═══════════════════════════════════════════════════════════════════════════════
    ['help_title'] = '🐺 Bounty Quest Help',
    ['help_text'] = [[
        Welcome to the Bounty Hunter system!
        
        📋 How to Start:
        1. Visit a quest NPC (marked on your map)
        2. Accept an available quest
        3. Travel to the target location
        4. Eliminate the target and guards
        5. Identify the target's body
        6. Return to collect your rewards
        
        💰 Earn More:
        - Use special weapons for bonus rewards
        - Complete quests quickly for time bonuses
        - Get headshots for accuracy bonuses
        - Capture targets alive for maximum rewards
        
        ⬆️ Level Up:
        - Complete quests to earn XP
        - Level up to unlock harder quests
        - Access better shops and equipment
        
        🐺 Good hunting!
    ]],
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- COMMANDS
    -- ═══════════════════════════════════════════════════════════════════════════════
    ['command_help'] = 'Show bounty quest help',
    ['command_stats'] = 'Show your bounty hunter statistics',
    ['command_quests'] = 'Show available quests',
    ['command_cancel'] = 'Cancel your current quest',
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- 🐺 End of English Locales - wolves.land
    -- ═══════════════════════════════════════════════════════════════════════════════
}
