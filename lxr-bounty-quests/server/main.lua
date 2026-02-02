--[[
    🐺 Land of Wolves - Bounty Quests System
    Server-Side Main Script
    © 2026 iBoss21 / The Lux Empire | wolves.land
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- VARIABLES & INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════

local ActiveQuests = {} -- [source] = questData
local PlayerCooldowns = {} -- [identifier] = {global = timestamp, easy = timestamp, etc}
local NPCCurrentLocations = {} -- [npcId] = {coords, city, location, lastChange}
local Framework = nil
local FrameworkType = Config.Framework

-- ═══════════════════════════════════════════════════════════════════════════════
-- FRAMEWORK DETECTION & INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════

function InitializeFramework()
    if FrameworkType == 'auto' then
        if GetResourceState('lxr-core') == 'started' then
            FrameworkType = 'lxrcore'
        elseif GetResourceState('rsg-core') == 'started' then
            FrameworkType = 'rsg-core'
        elseif GetResourceState('qbr-core') == 'started' then
            FrameworkType = 'qbr-core'
        elseif GetResourceState('qr-core') == 'started' then
            FrameworkType = 'qr-core'
        elseif GetResourceState('vorp_core') == 'started' then
            FrameworkType = 'vorp'
        elseif GetResourceState('redem_roleplay') == 'started' then
            FrameworkType = 'redemrp'
        else
            FrameworkType = 'standalone'
        end
    end
    
    print(('[🐺 Bounty Quests] Framework detected: %s'):format(FrameworkType))
    
    if FrameworkType == 'lxrcore' or FrameworkType == 'rsg-core' or FrameworkType == 'qbr-core' or FrameworkType == 'qr-core' then
        Framework = exports[Config.FrameworkSettings[FrameworkType].resource]:GetCoreObject()
    elseif FrameworkType == 'vorp' then
        Framework = exports.vorp_core:GetCore()
    elseif FrameworkType == 'redemrp' then
        TriggerEvent('redem:getSharedObject', function(obj) Framework = obj end)
    end
end

InitializeFramework()

-- ═══════════════════════════════════════════════════════════════════════════════
-- NPC DYNAMIC LOCATION SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

function GetCurrentGameTime()
    -- Get real-world time (hours and minutes) for server-side operations
    -- Note: Server cannot use GetClockHours/GetClockMinutes (client-only natives)
    local currentTime = os.date("*t")
    
    return {
        hours = currentTime.hour,
        minutes = currentTime.min,
        dayOfWeek = currentTime.wday - 1 -- Convert to 0-6 where 0=Sunday (matching GetClockDayOfWeek native)
    }
end

function IsNPCAvailableAtTime(npc)
    if not npc.timeRestrictions then
        return true
    end
    
    local currentTime = GetCurrentGameTime()
    local restrictions = npc.timeRestrictions
    
    -- Check hour restrictions
    if restrictions.startHour and restrictions.endHour then
        local currentHour = currentTime.hours
        
        -- Handle cases where end time is past midnight
        if restrictions.endHour < restrictions.startHour then
            -- e.g., 22:00 to 6:00 (overnight)
            if not (currentHour >= restrictions.startHour or currentHour < restrictions.endHour) then
                return false
            end
        else
            -- Normal case e.g., 6:00 to 22:00
            if currentHour < restrictions.startHour or currentHour >= restrictions.endHour then
                return false
            end
        end
    end
    
    -- Check day of week restrictions
    if restrictions.daysOfWeek and type(restrictions.daysOfWeek) == 'table' then
        local dayFound = false
        for _, day in ipairs(restrictions.daysOfWeek) do
            if day == currentTime.dayOfWeek then
                dayFound = true
                break
            end
        end
        if not dayFound then
            return false
        end
    end
    
    return true
end

function SelectRandomNPCLocation(npc)
    if not Config.NPCDynamicSpawn.Enabled then
        return npc.coords
    end
    
    -- Check if NPC is available at current time
    if not IsNPCAvailableAtTime(npc) then
        return nil -- NPC is not available at this time
    end
    
    -- If NPC has spawn locations, pick a random one
    if npc.spawnLocations and #npc.spawnLocations > 0 then
        local randomIndex = math.random(1, #npc.spawnLocations)
        local selectedLocation = npc.spawnLocations[randomIndex]
        
        if Config.EnableDebug then
            print(('[🐺 Bounty Quests] %s now at %s - %s'):format(npc.name, selectedLocation.city, selectedLocation.location))
        end
        
        return selectedLocation
    end
    
    -- Fallback to default coords
    return {
        coords = npc.coords,
        city = 'Unknown',
        location = 'Default Location'
    }
end

function InitializeNPCLocations()
    for _, npc in ipairs(Config.QuestNPCs) do
        local location = SelectRandomNPCLocation(npc)
        
        -- Calculate next change time
        local changeInterval = Config.NPCDynamicSpawn.ChangeInterval * 60
        if Config.NPCDynamicSpawn.RandomTime then
            local minTime = Config.NPCDynamicSpawn.TimeRange.min * 60
            local maxTime = Config.NPCDynamicSpawn.TimeRange.max * 60
            changeInterval = math.random(minTime, maxTime)
        end
        
        NPCCurrentLocations[npc.id] = {
            coords = location and location.coords or npc.coords,
            city = location and location.city or 'Unknown',
            location = location and location.location or 'Default',
            lastChange = os.time(),
            nextChange = os.time() + changeInterval,
            isAvailable = location ~= nil
        }
    end
    
    if Config.EnableDebug then
        print('[🐺 Bounty Quests] NPC locations initialized')
    end
end

function UpdateNPCLocations()
    for _, npc in ipairs(Config.QuestNPCs) do
        if NPCCurrentLocations[npc.id] then
            local currentTime = os.time()
            
            -- Check if it's time to change location
            if currentTime >= NPCCurrentLocations[npc.id].nextChange then
                local newLocation = SelectRandomNPCLocation(npc)
                
                -- Calculate next change time
                local changeInterval = Config.NPCDynamicSpawn.ChangeInterval * 60
                if Config.NPCDynamicSpawn.RandomTime then
                    local minTime = Config.NPCDynamicSpawn.TimeRange.min * 60
                    local maxTime = Config.NPCDynamicSpawn.TimeRange.max * 60
                    changeInterval = math.random(minTime, maxTime)
                end
                
                if newLocation then
                    NPCCurrentLocations[npc.id] = {
                        coords = newLocation.coords,
                        city = newLocation.city,
                        location = newLocation.location,
                        lastChange = currentTime,
                        nextChange = currentTime + changeInterval,
                        isAvailable = true
                    }
                    
                    -- Notify all clients about the location change
                    TriggerClientEvent('lxr-bounty:client:updateNPCLocation', -1, npc.id, NPCCurrentLocations[npc.id])
                    
                    if Config.EnableDebug then
                        print(('[🐺 Bounty Quests] %s moved to %s - %s'):format(npc.name, newLocation.city, newLocation.location))
                    end
                else
                    -- NPC is not available at this time
                    NPCCurrentLocations[npc.id].isAvailable = false
                    NPCCurrentLocations[npc.id].nextChange = currentTime + changeInterval
                    TriggerClientEvent('lxr-bounty:client:removeNPC', -1, npc.id)
                    
                    if Config.EnableDebug then
                        print(('[🐺 Bounty Quests] %s is not available at this time'):format(npc.name))
                    end
                end
            end
        end
    end
end

function GetNPCCurrentLocation(npcId)
    return NPCCurrentLocations[npcId]
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- DATABASE FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════

function GetPlayerData(identifier)
    local result = MySQL.Sync.fetchAll('SELECT * FROM ' .. Config.DatabaseTables.PlayerQuests .. ' WHERE identifier = @identifier LIMIT 1', {
        ['@identifier'] = identifier
    })
    
    if result[1] then
        return result[1]
    else
        -- Create new player entry
        MySQL.Async.execute('INSERT INTO ' .. Config.DatabaseTables.PlayerQuests .. ' (identifier) VALUES (@identifier)', {
            ['@identifier'] = identifier
        })
        return {
            identifier = identifier,
            total_quests_completed = 0,
            easy_quests_completed = 0,
            medium_quests_completed = 0,
            hard_quests_completed = 0,
            legendary_quests_completed = 0,
            total_xp = 0,
            current_level = 0,
            total_money_earned = 0.0,
            total_gold_earned = 0.0,
            reputation = 0,
            unlocked_npcs = '[]',
            unlocked_shops = '[]',
        }
    end
end

function UpdatePlayerData(identifier, data)
    local query = 'UPDATE ' .. Config.DatabaseTables.PlayerQuests .. ' SET '
    local params = {['@identifier'] = identifier}
    
    for key, value in pairs(data) do
        query = query .. key .. ' = @' .. key .. ', '
        params['@' .. key] = value
    end
    
    query = query:sub(1, -3) .. ' WHERE identifier = @identifier'
    
    MySQL.Async.execute(query, params)
end

function SaveQuestProgress(source, questData)
    local identifier = GetPlayerIdentifier(source)
    
    MySQL.Async.execute('INSERT INTO ' .. Config.DatabaseTables.QuestProgress .. ' (identifier, quest_id, quest_difficulty, npc_id, status, started_at) VALUES (@identifier, @quest_id, @difficulty, @npc_id, @status, NOW())', {
        ['@identifier'] = identifier,
        ['@quest_id'] = questData.id,
        ['@difficulty'] = questData.difficulty,
        ['@npc_id'] = questData.npcId,
        ['@status'] = 'active'
    })
end

function UpdateQuestCompletion(identifier, questData, rewards)
    MySQL.Async.execute('UPDATE ' .. Config.DatabaseTables.QuestProgress .. ' SET status = @status, completed_at = NOW(), target_killed = 1, target_identified = 1, rewards_collected = 1, money_reward = @money, xp_reward = @xp WHERE identifier = @identifier AND quest_id = @quest_id AND status = "active"', {
        ['@identifier'] = identifier,
        ['@quest_id'] = questData.id,
        ['@status'] = 'completed',
        ['@money'] = rewards.money,
        ['@xp'] = rewards.xp
    })
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════

function GetPlayerIdentifier(source)
    if FrameworkType == 'lxrcore' or FrameworkType == 'rsg-core' or FrameworkType == 'qbr-core' or FrameworkType == 'qr-core' then
        local player = Framework.Functions.GetPlayer(source)
        return player and player.PlayerData.citizenid or nil
    elseif FrameworkType == 'vorp' then
        local user = Framework.getUser(source)
        return user and user.getIdentifier() or nil
    elseif FrameworkType == 'redemrp' then
        local user = Framework.GetPlayer(source)
        return user and user.getIdentifier() or nil
    else
        -- Standalone - use license
        for _, id in ipairs(GetPlayerIdentifiers(source)) do
            if string.match(id, 'license:') then
                return id
            end
        end
    end
    return nil
end

function AddMoney(source, amount)
    if FrameworkType == 'lxrcore' or FrameworkType == 'rsg-core' or FrameworkType == 'qbr-core' or FrameworkType == 'qr-core' then
        local player = Framework.Functions.GetPlayer(source)
        if player then
            player.Functions.AddMoney('cash', amount)
        end
    elseif FrameworkType == 'vorp' then
        local user = Framework.getUser(source)
        if user then
            user.addCurrency(0, amount) -- 0 = money
        end
    elseif FrameworkType == 'redemrp' then
        local user = Framework.GetPlayer(source)
        if user then
            user.addMoney(amount)
        end
    end
end

function AddItem(source, item, amount)
    if FrameworkType == 'lxrcore' or FrameworkType == 'rsg-core' or FrameworkType == 'qbr-core' or FrameworkType == 'qr-core' then
        local player = Framework.Functions.GetPlayer(source)
        if player then
            player.Functions.AddItem(item, amount or 1)
        end
    elseif FrameworkType == 'vorp' then
        exports.vorp_inventory:addItem(source, item, amount or 1)
    elseif FrameworkType == 'redemrp' then
        local user = Framework.GetPlayer(source)
        if user then
            user.addItem(item, amount or 1)
        end
    end
end

function CheckCooldown(identifier, cooldownType)
    if not PlayerCooldowns[identifier] then
        return false
    end
    
    local cooldown = PlayerCooldowns[identifier][cooldownType]
    if cooldown and os.time() < cooldown then
        return true, cooldown - os.time()
    end
    
    return false
end

function SetCooldown(identifier, cooldownType, duration)
    if not PlayerCooldowns[identifier] then
        PlayerCooldowns[identifier] = {}
    end
    
    PlayerCooldowns[identifier][cooldownType] = os.time() + (duration * 60) -- Convert minutes to seconds
end

function CalculateRewards(questData, playerData)
    local difficulty = questData.difficulty
    local baseReward = Config.Economy.BaseRewards[difficulty:gsub("^%l", string.upper)]
    
    local money = math.random(baseReward.min, baseReward.max)
    local xp = Config.XPSystem[difficulty:gsub("^%l", string.upper) .. 'QuestXP']
    
    -- Apply multipliers
    if questData.rewardMultiplier then
        money = money * questData.rewardMultiplier
        xp = xp * questData.rewardMultiplier
    end
    
    -- TODO: Add bonus calculations based on performance
    
    return {
        money = math.floor(money),
        xp = math.floor(xp),
        items = {}
    }
end

function GiveRewards(source, rewards)
    local identifier = GetPlayerIdentifier(source)
    
    -- Give money
    if rewards.money > 0 then
        AddMoney(source, rewards.money)
    end
    
    -- Give XP and update level
    if Config.XPSystem.Enabled and rewards.xp > 0 then
        local playerData = GetPlayerData(identifier)
        local newXP = playerData.total_xp + rewards.xp
        local newLevel = CalculateLevel(newXP)
        
        UpdatePlayerData(identifier, {
            total_xp = newXP,
            current_level = newLevel,
            total_money_earned = playerData.total_money_earned + rewards.money
        })
        
        if newLevel > playerData.current_level then
            TriggerClientEvent('lxr-bounty:client:showNotification', source, ('Level Up! You are now level %s'):format(newLevel), 'success')
        end
    end
    
    -- Give items
    if rewards.items and #rewards.items > 0 then
        for _, item in ipairs(rewards.items) do
            AddItem(source, item.item, item.amount)
        end
    end
    
    return true
end

function CalculateLevel(xp)
    -- Simple level calculation: 100 XP per level
    return math.floor(xp / 100)
end

function CheckQuestRequirements(source, npc)
    local identifier = GetPlayerIdentifier(source)
    local playerData = GetPlayerData(identifier)
    
    -- Check level requirement
    if playerData.current_level < npc.requirements.level then
        return false, 'level_required'
    end
    
    -- Check completed quests requirement
    if npc.requirements.completedQuests and #npc.requirements.completedQuests > 0 then
        -- TODO: Implement quest completion check
    end
    
    -- Check job requirement
    if npc.requirements.job then
        -- TODO: Implement job check based on framework
    end
    
    return true
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- SERVER EVENTS
-- ═══════════════════════════════════════════════════════════════════════════════

RegisterNetEvent('lxr-bounty:server:openQuestMenu')
AddEventHandler('lxr-bounty:server:openQuestMenu', function(npcId)
    local source = source
    local identifier = GetPlayerIdentifier(source)
    
    if not identifier then return end
    
    -- Find NPC
    local npc = nil
    for _, n in ipairs(Config.QuestNPCs) do
        if n.id == npcId then
            npc = n
            break
        end
    end
    
    if not npc then return end
    
    -- Check requirements
    local canAccess, reason = CheckQuestRequirements(source, npc)
    
    if not canAccess then
        TriggerClientEvent('lxr-bounty:client:showNotification', source, 'You do not meet the requirements', 'error')
        return
    end
    
    -- Get player data
    local playerData = GetPlayerData(identifier)
    
    -- Get available quests
    local availableQuests = {}
    for _, quest in ipairs(Config.Quests) do
        for _, difficulty in ipairs(npc.availableQuests) do
            if quest.difficulty == difficulty then
                table.insert(availableQuests, quest)
            end
        end
    end
    
    -- Send to client (you would implement a menu system here)
    -- For now, auto-accept first available quest for testing
    if #availableQuests > 0 and not ActiveQuests[source] then
        local quest = availableQuests[1]
        TriggerEvent('lxr-bounty:server:acceptQuest', source, quest.id, npcId)
    end
end)

RegisterNetEvent('lxr-bounty:server:acceptQuest')
AddEventHandler('lxr-bounty:server:acceptQuest', function(questId, npcId)
    local source = type(questId) == 'number' and questId or source
    local actualQuestId = type(questId) == 'number' and npcId or questId
    local actualNpcId = type(questId) == 'number' and source or npcId
    
    local identifier = GetPlayerIdentifier(source)
    
    if not identifier then return end
    
    -- Check if player already has active quest
    if ActiveQuests[source] then
        TriggerClientEvent('lxr-bounty:client:showNotification', source, 'You already have an active quest', 'error')
        return
    end
    
    -- Check cooldowns
    local onCooldown, remainingTime = CheckCooldown(identifier, 'global')
    if onCooldown then
        TriggerClientEvent('lxr-bounty:client:showNotification', source, ('You must wait %s minutes'):format(math.ceil(remainingTime / 60)), 'error')
        return
    end
    
    -- Find quest
    local quest = nil
    for _, q in ipairs(Config.Quests) do
        if q.id == actualQuestId then
            quest = q
            break
        end
    end
    
    if not quest then return end
    
    -- Create quest data
    local questData = {
        id = quest.id,
        title = quest.title,
        description = quest.description,
        difficulty = quest.difficulty,
        location = quest.location,
        targetModel = quest.targetModel,
        targetName = quest.targetName,
        npcId = actualNpcId,
        startTime = os.time(),
        rewardMultiplier = quest.rewardMultiplier or 1.0
    }
    
    -- Save quest
    ActiveQuests[source] = questData
    SaveQuestProgress(source, questData)
    
    -- Set cooldowns
    SetCooldown(identifier, 'global', Config.Cooldowns.GlobalCooldown)
    SetCooldown(identifier, quest.difficulty, Config.Cooldowns[quest.difficulty:gsub("^%l", string.upper) .. 'QuestCooldown'])
    
    -- Notify client
    TriggerClientEvent('lxr-bounty:client:questStarted', source, questData)
    
    if Config.EnableDebug then
        print(('[🐺 Bounty Quests] Player %s started quest: %s'):format(source, quest.id))
    end
end)

RegisterNetEvent('lxr-bounty:server:identifyTarget')
AddEventHandler('lxr-bounty:server:identifyTarget', function()
    local source = source
    local identifier = GetPlayerIdentifier(source)
    
    if not identifier or not ActiveQuests[source] then return end
    
    local questData = ActiveQuests[source]
    local rewards = CalculateRewards(questData, GetPlayerData(identifier))
    
    -- Give rewards
    GiveRewards(source, rewards)
    
    -- Update database
    UpdateQuestCompletion(identifier, questData, rewards)
    
    -- Update player stats
    local playerData = GetPlayerData(identifier)
    local updateData = {
        total_quests_completed = playerData.total_quests_completed + 1
    }
    
    local difficultyKey = questData.difficulty .. '_quests_completed'
    updateData[difficultyKey] = (playerData[difficultyKey] or 0) + 1
    
    UpdatePlayerData(identifier, updateData)
    
    -- Clear active quest
    ActiveQuests[source] = nil
    
    -- Notify client
    TriggerClientEvent('lxr-bounty:client:questCompleted', source)
    TriggerClientEvent('lxr-bounty:client:showNotification', source, ('Rewards collected: $%s, %s XP'):format(rewards.money, rewards.xp), 'success')
    
    if Config.EnableDebug then
        print(('[🐺 Bounty Quests] Player %s completed quest: %s'):format(source, questData.id))
    end
end)

RegisterNetEvent('lxr-bounty:server:cancelQuest')
AddEventHandler('lxr-bounty:server:cancelQuest', function()
    local source = source
    local identifier = GetPlayerIdentifier(source)
    
    if not identifier or not ActiveQuests[source] then return end
    
    -- Update database
    MySQL.Async.execute('UPDATE ' .. Config.DatabaseTables.QuestProgress .. ' SET status = "abandoned" WHERE identifier = @identifier AND quest_id = @quest_id AND status = "active"', {
        ['@identifier'] = identifier,
        ['@quest_id'] = ActiveQuests[source].id
    })
    
    -- Clear active quest
    ActiveQuests[source] = nil
    
    -- Notify client
    TriggerClientEvent('lxr-bounty:client:showNotification', source, 'Quest cancelled', 'info')
end)

RegisterNetEvent('lxr-bounty:server:getStats')
AddEventHandler('lxr-bounty:server:getStats', function()
    local source = source
    local identifier = GetPlayerIdentifier(source)
    
    if not identifier then return end
    
    local playerData = GetPlayerData(identifier)
    
    -- Format stats message
    local stats = string.format([[
        📊 Bounty Hunter Statistics
        
        Level: %s
        XP: %s
        Total Quests: %s
        Easy: %s | Medium: %s | Hard: %s | Legendary: %s
        Money Earned: $%s
        Reputation: %s
    ]], 
        playerData.current_level,
        playerData.total_xp,
        playerData.total_quests_completed,
        playerData.easy_quests_completed,
        playerData.medium_quests_completed,
        playerData.hard_quests_completed,
        playerData.legendary_quests_completed,
        playerData.total_money_earned,
        playerData.reputation
    )
    
    TriggerClientEvent('lxr-bounty:client:showNotification', source, stats, 'info')
end)

RegisterNetEvent('lxr-bounty:server:requestNPCLocations')
AddEventHandler('lxr-bounty:server:requestNPCLocations', function()
    local source = source
    
    -- Send all current NPC locations to the requesting client
    TriggerClientEvent('lxr-bounty:client:syncNPCLocations', source, NPCCurrentLocations)
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- PLAYER DISCONNECT - CLEANUP
-- ═══════════════════════════════════════════════════════════════════════════════

AddEventHandler('playerDropped', function()
    local source = source
    
    if ActiveQuests[source] then
        local identifier = GetPlayerIdentifier(source)
        if identifier then
            -- Save quest as abandoned
            MySQL.Async.execute('UPDATE ' .. Config.DatabaseTables.QuestProgress .. ' SET status = "abandoned" WHERE identifier = @identifier AND quest_id = @quest_id AND status = "active"', {
                ['@identifier'] = identifier,
                ['@quest_id'] = ActiveQuests[source].id
            })
        end
        
        ActiveQuests[source] = nil
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- SERVER STARTUP
-- ═══════════════════════════════════════════════════════════════════════════════

Citizen.CreateThread(function()
    print([[
        ^3═══════════════════════════════════════════════════════════════════════════════^0
        ^2🐺 Land of Wolves - Bounty Quests System Server Started^0
        ^3═══════════════════════════════════════════════════════════════════════════════^0
        ^5Version:^0 2.0.0
        ^5Framework:^0 ]] .. FrameworkType .. [[
        ^5Quest NPCs:^0 ]] .. #Config.QuestNPCs .. [[
        ^5Total Quests:^0 ]] .. #Config.Quests .. [[
        ^5Dynamic NPCs:^0 ]] .. (Config.NPCDynamicSpawn.Enabled and 'Enabled' or 'Disabled') .. [[
        ^3═══════════════════════════════════════════════════════════════════════════════^0
        ^6🐺 wolves.land - The Land of Wolves^0
        ^3═══════════════════════════════════════════════════════════════════════════════^0
    ]])
    
    -- Initialize NPC locations
    InitializeNPCLocations()
    
    -- Start periodic location update if dynamic spawning is enabled
    if Config.NPCDynamicSpawn.Enabled then
        Citizen.CreateThread(function()
            while true do
                -- Check and update NPC locations every minute
                Wait(60000)
                UpdateNPCLocations()
            end
        end)
        
        if Config.EnableDebug then
            print('[🐺 Bounty Quests] Dynamic NPC location system started')
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 End of Server Script - wolves.land
-- ═══════════════════════════════════════════════════════════════════════════════
