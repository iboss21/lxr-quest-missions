# 🐺 LXR Quest Missions - Events & API Reference

```
███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗     █████╗ ██████╗ ██╗
██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝    ██╔══██╗██╔══██╗██║
█████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗    ███████║██████╔╝██║
██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║    ██╔══██║██╔═══╝ ██║
███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║    ██║  ██║██║     ██║
╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝    ╚═╝  ╚═╝╚═╝     ╚═╝
```

**🐺 The Land of Wolves - Complete Events & API Documentation**

**Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!**

---

## 📖 Table of Contents

1. [Overview](#overview)
2. [Client-Side Events](#client-side-events)
3. [Server-Side Events](#server-side-events)
4. [Framework Adapter Functions](#framework-adapter-functions)
5. [Custom Event Integration](#custom-event-integration)
6. [Callback System](#callback-system)
7. [Event Usage Examples](#event-usage-examples)

---

## 🌟 Overview

This document provides a complete reference for all events, exports, and API functions available in LXR Quest Missions. Use these to integrate the quest system with your other resources or create custom functionality.

### Event Categories

- 🎮 **Client Events** - Triggered on player clients
- 🖥️ **Server Events** - Triggered on the server
- 🔄 **Framework Events** - Framework-specific integrations
- 📡 **Custom Events** - Your own integrations

---

## 🎮 Client-Side Events

### Quest System Events

#### `lxr-quests:client:openQuestMenu`
Opens the quest menu for a specific NPC.

**Parameters:**
- `npcId` (string) - The ID of the quest giver NPC

**Example:**
```lua
TriggerEvent('lxr-quests:client:openQuestMenu', 'valentine_sheriff')
```

---

#### `lxr-quests:client:closeQuestMenu`
Closes the currently open quest menu.

**Example:**
```lua
TriggerEvent('lxr-quests:client:closeQuestMenu')
```

---

#### `lxr-quests:client:questAccepted`
Triggered when a player accepts a quest.

**Parameters:**
- `questData` (table) - Complete quest information

**Quest Data Structure:**
```lua
{
    id = 'easy_bounty_1',
    name = 'Wanted: Petty Thief',
    difficulty = 'easy',
    npcId = 'valentine_sheriff',
    targetLocation = vector3(x, y, z),
    rewards = {
        xp = 50,
        cash = 25.0,
        items = {}
    }
}
```

**Example:**
```lua
RegisterNetEvent('lxr-quests:client:questAccepted', function(questData)
    print('Accepted quest: ' .. questData.name)
    print('Difficulty: ' .. questData.difficulty)
end)
```

---

#### `lxr-quests:client:questCompleted`
Triggered when a player successfully completes a quest.

**Parameters:**
- `questId` (string) - ID of the completed quest
- `rewards` (table) - Rewards earned

**Example:**
```lua
RegisterNetEvent('lxr-quests:client:questCompleted', function(questId, rewards)
    print('Quest completed: ' .. questId)
    print('XP earned: ' .. rewards.xp)
    print('Cash earned: $' .. rewards.cash)
end)
```

---

#### `lxr-quests:client:questFailed`
Triggered when a quest fails (timeout, death, etc.).

**Parameters:**
- `questId` (string) - ID of the failed quest
- `reason` (string) - Reason for failure

**Failure Reasons:**
- `'timeout'` - Quest time limit exceeded
- `'death'` - Player died during quest
- `'abandoned'` - Player abandoned quest
- `'disconnect'` - Player disconnected

**Example:**
```lua
RegisterNetEvent('lxr-quests:client:questFailed', function(questId, reason)
    if reason == 'timeout' then
        print('Quest timed out!')
    elseif reason == 'death' then
        print('You died during the quest!')
    end
end)
```

---

#### `lxr-quests:client:questAbandoned`
Triggered when a player manually abandons a quest.

**Parameters:**
- `questId` (string) - ID of abandoned quest

**Example:**
```lua
RegisterNetEvent('lxr-quests:client:questAbandoned', function(questId)
    print('Quest abandoned: ' .. questId)
end)
```

---

#### `lxr-quests:client:updateQuestProgress`
Updates quest progress display.

**Parameters:**
- `progress` (table) - Progress information

**Example:**
```lua
RegisterNetEvent('lxr-quests:client:updateQuestProgress', function(progress)
    print('Quest progress: ' .. progress.current .. '/' .. progress.total)
end)
```

---

### Target & Combat Events

#### `lxr-quests:client:targetSpawned`
Triggered when a bounty target is spawned.

**Parameters:**
- `targetData` (table) - Target information

**Example:**
```lua
RegisterNetEvent('lxr-quests:client:targetSpawned', function(targetData)
    print('Target spawned at: ' .. tostring(targetData.coords))
    SetNewWaypoint(targetData.coords.x, targetData.coords.y)
end)
```

---

#### `lxr-quests:client:targetIdentified`
Triggered when player successfully identifies a target.

**Parameters:**
- `targetId` (number) - Network ID of target entity

**Example:**
```lua
RegisterNetEvent('lxr-quests:client:targetIdentified', function(targetId)
    print('Target identified: ' .. targetId)
end)
```

---

#### `lxr-quests:client:targetEliminated`
Triggered when a bounty target is killed.

**Parameters:**
- `questId` (string) - Associated quest ID
- `targetId` (number) - Network ID of target
- `killerWeapon` (hash) - Weapon used for kill

**Example:**
```lua
RegisterNetEvent('lxr-quests:client:targetEliminated', function(questId, targetId, killerWeapon)
    print('Target eliminated with weapon: ' .. killerWeapon)
end)
```

---

### Notification Events

#### `lxr-quests:client:notify`
Display a notification to the player.

**Parameters:**
- `message` (string) - Notification message
- `type` (string) - Notification type: `'success'`, `'error'`, `'warning'`, `'info'`
- `duration` (number) - Display duration in milliseconds (optional)

**Example:**
```lua
TriggerEvent('lxr-quests:client:notify', 'Quest accepted!', 'success', 5000)
```

---

### UI Events

#### `lxr-quests:client:showPrompt`
Display an interaction prompt.

**Parameters:**
- `promptText` (string) - Text to display
- `key` (string) - Key to press

**Example:**
```lua
TriggerEvent('lxr-quests:client:showPrompt', 'Talk to Sheriff', 'SPACE')
```

---

#### `lxr-quests:client:hidePrompt`
Hide the interaction prompt.

**Example:**
```lua
TriggerEvent('lxr-quests:client:hidePrompt')
```

---

#### `lxr-quests:client:updateBlips`
Update quest-related blips on the map.

**Parameters:**
- `blipData` (table) - Blip information

**Example:**
```lua
TriggerEvent('lxr-quests:client:updateBlips', {
    {
        coords = vector3(x, y, z),
        sprite = 'blip_ambient_bounty_poster',
        label = 'Quest Giver'
    }
})
```

---

## 🖥️ Server-Side Events

### Quest Management Events

#### `lxr-quests:server:requestQuestMenu`
Request to open quest menu (server-side validation).

**Parameters:**
- `npcId` (string) - ID of quest NPC

**Example:**
```lua
-- Client triggers this
TriggerServerEvent('lxr-quests:server:requestQuestMenu', 'valentine_sheriff')
```

---

#### `lxr-quests:server:acceptQuest`
Player attempts to accept a quest.

**Parameters:**
- `questId` (string) - ID of quest to accept
- `npcId` (string) - ID of quest giver

**Example:**
```lua
-- Client triggers
TriggerServerEvent('lxr-quests:server:acceptQuest', 'easy_bounty_1', 'valentine_sheriff')

-- Server-side handler
RegisterNetEvent('lxr-quests:server:acceptQuest', function(questId, npcId)
    local source = source
    
    -- Validate quest acceptance
    if CanPlayerAcceptQuest(source, questId) then
        -- Start quest
        StartQuest(source, questId, npcId)
    else
        TriggerClientEvent('lxr-quests:client:notify', source, 'Cannot accept quest', 'error')
    end
end)
```

---

#### `lxr-quests:server:completeQuest`
Report quest completion to server.

**Parameters:**
- `questId` (string) - ID of completed quest
- `completionData` (table) - Data about how quest was completed

**Completion Data:**
```lua
{
    timeTaken = 1234, -- Seconds
    deaths = 0,
    headshotKill = true,
    weaponUsed = 'WEAPON_REVOLVER_CATTLEMAN'
}
```

**Example:**
```lua
TriggerServerEvent('lxr-quests:server:completeQuest', 'easy_bounty_1', {
    timeTaken = 300,
    deaths = 0,
    headshotKill = true,
    weaponUsed = 'WEAPON_REVOLVER_CATTLEMAN'
})
```

---

#### `lxr-quests:server:abandonQuest`
Player abandons their active quest.

**Parameters:**
- `questId` (string) - ID of quest to abandon

**Example:**
```lua
TriggerServerEvent('lxr-quests:server:abandonQuest', 'easy_bounty_1')
```

---

### Reward Events

#### `lxr-quests:server:giveRewards`
Distribute quest rewards to player.

**Parameters:**
- `playerId` (number) - Player server ID
- `rewards` (table) - Reward data

**Example:**
```lua
-- Server-side
TriggerEvent('lxr-quests:server:giveRewards', source, {
    xp = 50,
    cash = 25.0,
    items = {
        {item = 'weapon_lasso', amount = 1}
    }
})
```

---

#### `lxr-quests:server:claimReward`
Player claims a pending reward.

**Parameters:**
- `rewardId` (string) - ID of reward to claim

**Example:**
```lua
TriggerServerEvent('lxr-quests:server:claimReward', 'reward_123456')
```

---

### Player Data Events

#### `lxr-quests:server:getPlayerQuestData`
Request player's quest data.

**Returns:** (via callback)
```lua
{
    level = 5,
    xp = 250,
    totalQuests = 15,
    activeQuest = 'easy_bounty_1',
    unlockedNPCs = {'valentine_sheriff', 'rhodes_marshal'}
}
```

**Example:**
```lua
-- Client requests
TriggerServerCallback('lxr-quests:server:getPlayerQuestData', function(data)
    print('Player level: ' .. data.level)
    print('Player XP: ' .. data.xp)
end)
```

---

#### `lxr-quests:server:updatePlayerXP`
Update player's XP (admin/external use).

**Parameters:**
- `playerId` (number) - Player server ID
- `xpAmount` (number) - XP to add (can be negative)

**Example:**
```lua
-- Give 100 XP
TriggerEvent('lxr-quests:server:updatePlayerXP', source, 100)

-- Remove 50 XP
TriggerEvent('lxr-quests:server:updatePlayerXP', source, -50)
```

---

### Admin Events

#### `lxr-quests:server:resetPlayerQuests`
Reset all quest data for a player (admin only).

**Parameters:**
- `playerId` (number) - Player server ID

**Example:**
```lua
TriggerServerEvent('lxr-quests:server:resetPlayerQuests', targetPlayerId)
```

---

#### `lxr-quests:server:forceCompleteQuest`
Force complete a quest for a player (admin only).

**Parameters:**
- `playerId` (number) - Player server ID
- `questId` (string) - Quest ID to complete

**Example:**
```lua
TriggerServerEvent('lxr-quests:server:forceCompleteQuest', targetPlayerId, 'easy_bounty_1')
```

---

## 🔄 Framework Adapter Functions

### Server-Side Adapter API

#### `FrameworkAdapter.GetPlayer(source)`
Get player object from framework.

**Parameters:**
- `source` (number) - Player server ID

**Returns:** Framework player object or nil

**Example:**
```lua
local Player = FrameworkAdapter.GetPlayer(source)
if Player then
    print('Player found')
end
```

---

#### `FrameworkAdapter.GetPlayerIdentifier(source)`
Get player's unique identifier.

**Parameters:**
- `source` (number) - Player server ID

**Returns:** Identifier string

**Example:**
```lua
local identifier = FrameworkAdapter.GetPlayerIdentifier(source)
print('Player identifier: ' .. identifier)
```

---

#### `FrameworkAdapter.AddMoney(source, moneyType, amount)`
Add money to player account.

**Parameters:**
- `source` (number) - Player server ID
- `moneyType` (string) - Money type: `'cash'` or `'bank'`
- `amount` (number) - Amount to add

**Example:**
```lua
FrameworkAdapter.AddMoney(source, 'cash', 100.0)
```

---

#### `FrameworkAdapter.RemoveMoney(source, moneyType, amount)`
Remove money from player account.

**Parameters:**
- `source` (number) - Player server ID
- `moneyType` (string) - Money type
- `amount` (number) - Amount to remove

**Returns:** Boolean (success/failure)

**Example:**
```lua
local success = FrameworkAdapter.RemoveMoney(source, 'cash', 50.0)
if success then
    print('Money removed')
end
```

---

#### `FrameworkAdapter.GetMoney(source, moneyType)`
Get player's money balance.

**Parameters:**
- `source` (number) - Player server ID
- `moneyType` (string) - Money type

**Returns:** Number (balance)

**Example:**
```lua
local balance = FrameworkAdapter.GetMoney(source, 'cash')
print('Player has: $' .. balance)
```

---

#### `FrameworkAdapter.AddItem(source, item, amount, metadata)`
Add item to player inventory.

**Parameters:**
- `source` (number) - Player server ID
- `item` (string) - Item name
- `amount` (number) - Quantity
- `metadata` (table) - Optional item metadata

**Example:**
```lua
FrameworkAdapter.AddItem(source, 'weapon_lasso', 1)
FrameworkAdapter.AddItem(source, 'consumable_medicine', 5)
```

---

#### `FrameworkAdapter.RemoveItem(source, item, amount)`
Remove item from player inventory.

**Parameters:**
- `source` (number) - Player server ID
- `item` (string) - Item name
- `amount` (number) - Quantity

**Returns:** Boolean (success/failure)

**Example:**
```lua
local success = FrameworkAdapter.RemoveItem(source, 'weapon_lasso', 1)
```

---

#### `FrameworkAdapter.GetItemCount(source, item)`
Get quantity of item in player inventory.

**Parameters:**
- `source` (number) - Player server ID
- `item` (string) - Item name

**Returns:** Number (quantity)

**Example:**
```lua
local count = FrameworkAdapter.GetItemCount(source, 'consumable_medicine')
print('Player has ' .. count .. ' medicine')
```

---

#### `FrameworkAdapter.Notify(source, message, type, duration)`
Send notification to player.

**Parameters:**
- `source` (number) - Player server ID
- `message` (string) - Notification message
- `type` (string) - Notification type
- `duration` (number) - Duration in ms (optional)

**Example:**
```lua
FrameworkAdapter.Notify(source, 'Quest accepted!', 'success', 5000)
```

---

#### `FrameworkAdapter.GetJob(source)`
Get player's job information.

**Parameters:**
- `source` (number) - Player server ID

**Returns:** Table with job data
```lua
{
    name = 'sheriff',
    label = 'Sheriff',
    grade = 2,
    grade_label = 'Deputy'
}
```

**Example:**
```lua
local job = FrameworkAdapter.GetJob(source)
if job.name == 'sheriff' then
    print('Player is a lawman')
end
```

---

## 🔌 Custom Event Integration

### Creating Custom Quest Events

You can create custom events that integrate with the quest system:

#### Example: Custom Reward Event

```lua
-- Server-side custom event
RegisterNetEvent('myserver:giveCustomReward', function(questId)
    local source = source
    
    -- Get quest data
    local questData = GetQuestById(questId)
    
    -- Give custom rewards
    if questData.difficulty == 'legendary' then
        FrameworkAdapter.AddItem(source, 'rare_treasure', 1)
        FrameworkAdapter.Notify(source, 'You found a rare treasure!', 'success')
    end
    
    -- Trigger quest completion
    TriggerEvent('lxr-quests:server:completeQuest', source, questId)
end)
```

---

#### Example: Custom Quest Condition

```lua
-- Check custom condition before quest acceptance
AddEventHandler('lxr-quests:server:acceptQuest', function(questId, npcId)
    local source = source
    
    -- Custom condition: Player must have a specific item
    if questId == 'special_quest' then
        local hasItem = FrameworkAdapter.GetItemCount(source, 'bounty_license') > 0
        
        if not hasItem then
            TriggerClientEvent('lxr-quests:client:notify', source, 
                'You need a Bounty License to accept this quest!', 'error')
            CancelEvent() -- Prevent quest acceptance
            return
        end
    end
end)
```

---

### Integration with Other Resources

#### Example: Discord Logging

```lua
-- Log quest completions to Discord
AddEventHandler('lxr-quests:server:questCompleted', function(playerId, questId, rewards)
    local playerName = GetPlayerName(playerId)
    
    -- Send to Discord webhook
    local embed = {
        {
            ["title"] = "Quest Completed",
            ["description"] = playerName .. " completed quest: " .. questId,
            ["color"] = 65280, -- Green
            ["fields"] = {
                {["name"] = "Rewards", ["value"] = "$" .. rewards.cash .. " | " .. rewards.xp .. " XP"}
            }
        }
    }
    
    PerformHttpRequest('YOUR_WEBHOOK_URL', function() end, 'POST', 
        json.encode({embeds = embed}), {['Content-Type'] = 'application/json'})
end)
```

---

#### Example: Leaderboard Integration

```lua
-- Track top quest completers
local questLeaderboard = {}

AddEventHandler('lxr-quests:server:questCompleted', function(playerId, questId)
    local identifier = FrameworkAdapter.GetPlayerIdentifier(playerId)
    
    if not questLeaderboard[identifier] then
        questLeaderboard[identifier] = 0
    end
    
    questLeaderboard[identifier] = questLeaderboard[identifier] + 1
    
    -- Update global leaderboard
    TriggerEvent('myserver:updateLeaderboard', 'quests', identifier, questLeaderboard[identifier])
end)
```

---

## 📞 Callback System

### Server Callbacks

#### `TriggerServerCallback(eventName, callback, ...)`

Request data from server with callback.

**Example:**
```lua
-- Client-side
TriggerServerCallback('lxr-quests:getPlayerData', function(data)
    print('Player Level: ' .. data.level)
    print('Player XP: ' .. data.xp)
end)

-- Server-side handler
RegisterServerCallback('lxr-quests:getPlayerData', function(source, cb)
    local playerData = GetPlayerQuestData(source)
    cb(playerData)
end)
```

---

### Client Callbacks

#### `RegisterClientCallback(eventName, callback)`

Register a callback that server can trigger.

**Example:**
```lua
-- Client-side
RegisterClientCallback('lxr-quests:confirmQuestAbandon', function(questId, cb)
    -- Show confirmation UI
    ShowConfirmDialog('Abandon quest?', function(confirmed)
        cb(confirmed)
    end)
end)

-- Server-side trigger
TriggerClientCallback(source, 'lxr-quests:confirmQuestAbandon', function(confirmed)
    if confirmed then
        AbandonQuest(source, questId)
    end
end, questId)
```

---

## 💡 Event Usage Examples

### Complete Quest Flow Example

```lua
-- Client: Player approaches NPC and opens quest menu
CreateThread(function()
    while true do
        Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        
        for _, npc in pairs(Config.QuestNPCs) do
            local distance = #(playerCoords - npc.coords)
            
            if distance < 3.0 then
                -- Show prompt
                TriggerEvent('lxr-quests:client:showPrompt', 'Talk to ' .. npc.name, 'SPACE')
                
                if IsControlJustPressed(0, Config.Keys.OpenQuestMenu) then
                    -- Request quest menu
                    TriggerServerEvent('lxr-quests:server:requestQuestMenu', npc.id)
                end
            end
        end
    end
end)

-- Server: Validate and send quest menu
RegisterNetEvent('lxr-quests:server:requestQuestMenu', function(npcId)
    local source = source
    
    -- Check if player meets requirements
    local playerLevel = GetPlayerLevel(source)
    local npcData = GetNPCById(npcId)
    
    if playerLevel >= npcData.unlockRequirements.level then
        -- Send available quests
        TriggerClientEvent('lxr-quests:client:openQuestMenu', source, npcData)
    else
        FrameworkAdapter.Notify(source, 'You need level ' .. npcData.unlockRequirements.level, 'error')
    end
end)

-- Client: Accept quest
RegisterNetEvent('lxr-quests:client:acceptQuest', function(questId, npcId)
    TriggerServerEvent('lxr-quests:server:acceptQuest', questId, npcId)
end)

-- Server: Start quest
RegisterNetEvent('lxr-quests:server:acceptQuest', function(questId, npcId)
    local source = source
    
    -- Validate cooldowns
    if IsPlayerOnCooldown(source) then
        FrameworkAdapter.Notify(source, 'You are on cooldown', 'error')
        return
    end
    
    -- Start quest
    StartPlayerQuest(source, questId, npcId)
    
    -- Notify client
    TriggerClientEvent('lxr-quests:client:questAccepted', source, GetQuestData(questId))
end)

-- Client: Complete quest
RegisterNetEvent('lxr-quests:client:targetEliminated', function(questId)
    -- Report to server
    TriggerServerEvent('lxr-quests:server:completeQuest', questId, {
        timeTaken = GetQuestElapsedTime(),
        deaths = GetQuestDeaths(),
        headshotKill = true
    })
end)

-- Server: Give rewards
RegisterNetEvent('lxr-quests:server:completeQuest', function(questId, completionData)
    local source = source
    
    -- Calculate rewards
    local rewards = CalculateRewards(questId, completionData)
    
    -- Give rewards
    FrameworkAdapter.AddMoney(source, 'cash', rewards.cash)
    GivePlayerXP(source, rewards.xp)
    
    -- Notify
    TriggerClientEvent('lxr-quests:client:questCompleted', source, questId, rewards)
end)
```

---

## 📚 Additional Resources

- 📖 [Configuration Guide](./configuration.md)
- 🔧 [Framework Integration](./frameworks.md)
- 🔒 [Security Guide](./security.md)
- ⚡ [Performance Optimization](./performance.md)

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
