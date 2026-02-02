# 🐺 LXR Quest Missions - Security Guide

```
███████╗███████╗ ██████╗██╗   ██╗██████╗ ██╗████████╗██╗   ██╗
██╔════╝██╔════╝██╔════╝██║   ██║██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝
███████╗█████╗  ██║     ██║   ██║██████╔╝██║   ██║    ╚████╔╝ 
╚════██║██╔══╝  ██║     ██║   ██║██╔══██╗██║   ██║     ╚██╔╝  
███████║███████╗╚██████╗╚██████╔╝██║  ██║██║   ██║      ██║   
╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝   
```

**🐺 The Land of Wolves - Security & Anti-Cheat Documentation**

**Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!**

---

## 📖 Table of Contents

1. [Overview](#overview)
2. [Resource Name Protection](#resource-name-protection)
3. [Server-Side Validation](#server-side-validation)
4. [Anti-Cheat Measures](#anti-cheat-measures)
5. [Cooldown Systems](#cooldown-systems)
6. [Rate Limiting](#rate-limiting)
7. [Audit Logging](#audit-logging)
8. [Best Practices](#best-practices)
9. [Threat Detection](#threat-detection)
10. [Security Configuration](#security-configuration)

---

## 🌟 Overview

LXR Quest Missions includes multiple layers of security protection designed to prevent cheating, exploitation, and unauthorized modifications. This guide explains each security feature and how to configure them for your server.

### Security Philosophy

🛡️ **Multi-Layer Defense:**
- Prevention (stop attacks before they happen)
- Detection (identify suspicious activity)
- Response (automatic countermeasures)
- Logging (track and audit all actions)

### Threat Model

**Protected Against:**
- ✅ Client-side manipulation
- ✅ Reward injection/duplication
- ✅ Quest cooldown bypass
- ✅ Unauthorized quest completion
- ✅ Resource name changes (redistribution)
- ✅ Event spamming
- ✅ Database injection
- ✅ XP/level manipulation

---

## 🔒 Resource Name Protection

### Purpose

Prevents unauthorized redistribution by enforcing the original resource name.

### How It Works

The script validates its folder name on startup and during configuration load:

```lua
local REQUIRED_RESOURCE_NAME = "lxr-bounty-quests"
local currentResourceName = GetCurrentResourceName()

if currentResourceName ~= REQUIRED_RESOURCE_NAME then
    error([[
        ═══════════════════════════════════════════════════════════════════════════════
        ❌ CRITICAL ERROR: RESOURCE NAME MISMATCH ❌
        ═══════════════════════════════════════════════════════════════════════════════
        
        Expected: lxr-bounty-quests
        Got: ]] .. currentResourceName .. [[
        
        This resource is branded and must maintain the correct name.
        Rename the folder to "lxr-bounty-quests" to continue.
        
        🐺 wolves.land - The Land of Wolves
        
        ═══════════════════════════════════════════════════════════════════════════════
    ]])
end
```

### Protection Level

🔴 **CRITICAL** - Script will not start if name is incorrect

### Configuration

**Location:** `config.lua` (lines 64-85)

**Bypass:** Not recommended - violates licensing terms

---

## ✅ Server-Side Validation

### Quest Acceptance Validation

All quest acceptances are validated server-side:

```lua
RegisterNetEvent('lxr-quests:server:acceptQuest', function(questId, npcId)
    local source = source
    
    -- Validation checks
    if not IsPlayerValid(source) then return end
    if not DoesQuestExist(questId) then return end
    if not CanPlayerAccessNPC(source, npcId) then return end
    if IsPlayerOnCooldown(source, questId) then return end
    if HasActiveQuest(source) then return end
    if not MeetsLevelRequirement(source, questId) then return end
    
    -- All checks passed - start quest
    StartQuest(source, questId, npcId)
end)
```

#### Validation Checks:

| Check | Purpose | Action on Fail |
|-------|---------|---------------|
| **Player Validity** | Ensure player exists | Reject silently |
| **Quest Existence** | Verify quest ID is valid | Reject + log |
| **NPC Access** | Check if NPC is unlocked | Notify player |
| **Cooldown Check** | Enforce cooldown periods | Notify player |
| **Active Quest** | Prevent multiple quests | Notify player |
| **Level Requirement** | Verify player level | Notify player |

### Quest Completion Validation

Quest completions are validated to prevent false positives:

```lua
RegisterNetEvent('lxr-quests:server:completeQuest', function(questId, completionData)
    local source = source
    
    -- Validation
    if not HasActiveQuest(source, questId) then return end
    if not IsTargetEliminated(source, questId) then return end
    if not IsWithinTimeLimit(source, questId) then return end
    
    -- Verify completion data integrity
    if not ValidateCompletionData(completionData) then
        LogSuspiciousActivity(source, 'Invalid completion data', questId)
        return
    end
    
    -- Award rewards
    GiveQuestRewards(source, questId, completionData)
end)
```

#### Completion Checks:

✅ Player has the quest active
✅ Target NPC was actually killed
✅ Quest not expired (time limit)
✅ Completion data is valid
✅ Player is in correct location
✅ No suspicious activity detected

### Reward Distribution Validation

All rewards are validated before distribution:

```lua
function GiveQuestRewards(source, questId, completionData)
    -- Get base rewards
    local questData = GetQuestById(questId)
    local rewards = CalculateRewards(questData, completionData)
    
    -- Validate reward amounts
    if rewards.cash > Config.MaxRewardCash then
        LogSuspiciousActivity(source, 'Reward amount exceeds maximum', questId)
        rewards.cash = Config.MaxRewardCash
    end
    
    if rewards.xp > Config.MaxRewardXP then
        LogSuspiciousActivity(source, 'XP amount exceeds maximum', questId)
        rewards.xp = Config.MaxRewardXP
    end
    
    -- Distribute rewards safely
    FrameworkAdapter.AddMoney(source, 'cash', rewards.cash)
    GivePlayerXP(source, rewards.xp)
    
    -- Log transaction
    LogRewardTransaction(source, questId, rewards)
end
```

---

## 🛡️ Anti-Cheat Measures

### Event Flood Protection

Prevents event spamming attacks:

```lua
local eventLimiter = {}

function IsEventFlood(source, eventName)
    local identifier = GetPlayerIdentifier(source)
    local currentTime = os.time()
    
    if not eventLimiter[identifier] then
        eventLimiter[identifier] = {}
    end
    
    if not eventLimiter[identifier][eventName] then
        eventLimiter[identifier][eventName] = {
            count = 0,
            lastReset = currentTime
        }
    end
    
    local limiter = eventLimiter[identifier][eventName]
    
    -- Reset counter every 5 seconds
    if currentTime - limiter.lastReset >= 5 then
        limiter.count = 0
        limiter.lastReset = currentTime
    end
    
    limiter.count = limiter.count + 1
    
    -- Max 10 events per 5 seconds
    if limiter.count > 10 then
        LogSuspiciousActivity(source, 'Event flooding detected: ' .. eventName)
        return true
    end
    
    return false
end

-- Usage in event handlers
RegisterNetEvent('lxr-quests:server:acceptQuest', function(questId, npcId)
    local source = source
    
    if IsEventFlood(source, 'acceptQuest') then
        return -- Reject silently
    end
    
    -- Process normally...
end)
```

### Distance Validation

Validates player is within acceptable distance for interactions:

```lua
function ValidatePlayerDistance(source, targetCoords, maxDistance)
    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)
    local distance = #(playerCoords - targetCoords)
    
    if distance > maxDistance then
        LogSuspiciousActivity(source, 'Distance validation failed', {
            distance = distance,
            maxDistance = maxDistance,
            target = targetCoords
        })
        return false
    end
    
    return true
end

-- Usage
RegisterNetEvent('lxr-quests:server:requestQuestMenu', function(npcId)
    local source = source
    local npcData = GetNPCById(npcId)
    
    -- Validate distance (15 units)
    if not ValidatePlayerDistance(source, npcData.coords, 15.0) then
        return
    end
    
    -- Process normally...
end)
```

### Quest State Validation

Prevents state manipulation:

```lua
local activeQuests = {}

function ValidateQuestState(source, questId, expectedState)
    local identifier = GetPlayerIdentifier(source)
    
    if not activeQuests[identifier] then
        return false
    end
    
    local quest = activeQuests[identifier][questId]
    
    if not quest then
        return false
    end
    
    if quest.state ~= expectedState then
        LogSuspiciousActivity(source, 'Quest state mismatch', {
            questId = questId,
            expected = expectedState,
            actual = quest.state
        })
        return false
    end
    
    return true
end
```

### Time Validation

Detects impossibly fast quest completions:

```lua
function ValidateQuestTime(source, questId, completionTime)
    local questData = GetQuestById(questId)
    local minimumTime = questData.minimumCompletionTime or 60 -- 1 minute minimum
    
    if completionTime < minimumTime then
        LogSuspiciousActivity(source, 'Suspiciously fast completion', {
            questId = questId,
            completionTime = completionTime,
            minimumTime = minimumTime
        })
        
        -- Ban or kick based on severity
        if completionTime < minimumTime * 0.5 then
            BanPlayer(source, 'Quest time manipulation detected')
            return false
        end
    end
    
    return true
end
```

---

## ⏱️ Cooldown Systems

### Global Cooldown

Prevents quest spam:

```lua
Config.Cooldowns = {
    GlobalCooldown = 15, -- Minutes between any quests
}

local playerCooldowns = {}

function IsPlayerOnCooldown(source)
    local identifier = GetPlayerIdentifier(source)
    
    if not playerCooldowns[identifier] then
        return false
    end
    
    local lastQuestTime = playerCooldowns[identifier].lastQuest
    local currentTime = os.time()
    local cooldownSeconds = Config.Cooldowns.GlobalCooldown * 60
    
    if (currentTime - lastQuestTime) < cooldownSeconds then
        local remaining = cooldownSeconds - (currentTime - lastQuestTime)
        return true, remaining
    end
    
    return false
end

function SetPlayerCooldown(source)
    local identifier = GetPlayerIdentifier(source)
    
    if not playerCooldowns[identifier] then
        playerCooldowns[identifier] = {}
    end
    
    playerCooldowns[identifier].lastQuest = os.time()
end
```

### Difficulty-Based Cooldowns

Higher difficulty = longer cooldown:

```lua
Config.Cooldowns = {
    EasyQuestCooldown = 10,
    MediumQuestCooldown = 20,
    HardQuestCooldown = 30,
    LegendaryQuestCooldown = 60
}

function GetQuestCooldown(questId)
    local questData = GetQuestById(questId)
    local baseCooldown = Config.Cooldowns.GlobalCooldown
    
    local difficultyCooldown = 0
    if questData.difficulty == 'easy' then
        difficultyCooldown = Config.Cooldowns.EasyQuestCooldown
    elseif questData.difficulty == 'medium' then
        difficultyCooldown = Config.Cooldowns.MediumQuestCooldown
    elseif questData.difficulty == 'hard' then
        difficultyCooldown = Config.Cooldowns.HardQuestCooldown
    elseif questData.difficulty == 'legendary' then
        difficultyCooldown = Config.Cooldowns.LegendaryQuestCooldown
    end
    
    return (baseCooldown + difficultyCooldown) * 60 -- Convert to seconds
end
```

### Cooldown Bypass Detection

Detects attempts to bypass cooldowns:

```lua
function DetectCooldownBypass(source, questId)
    local identifier = GetPlayerIdentifier(source)
    local questData = GetQuestById(questId)
    
    -- Check if player recently completed same quest type
    if playerCooldowns[identifier] then
        local lastQuest = playerCooldowns[identifier].lastQuestData
        
        if lastQuest and lastQuest.difficulty == questData.difficulty then
            local timeSince = os.time() - playerCooldowns[identifier].lastQuest
            local requiredCooldown = GetQuestCooldown(questId)
            
            if timeSince < requiredCooldown then
                LogSuspiciousActivity(source, 'Cooldown bypass attempt', {
                    questId = questId,
                    timeSince = timeSince,
                    requiredCooldown = requiredCooldown
                })
                return true
            end
        end
    end
    
    return false
end
```

---

## 🚦 Rate Limiting

### Per-Player Rate Limits

```lua
local rateLimits = {
    acceptQuest = {limit = 5, window = 60}, -- 5 per minute
    completeQuest = {limit = 3, window = 60}, -- 3 per minute
    claimReward = {limit = 10, window = 60}, -- 10 per minute
}

local playerRateLimits = {}

function CheckRateLimit(source, action)
    local identifier = GetPlayerIdentifier(source)
    local currentTime = os.time()
    
    if not playerRateLimits[identifier] then
        playerRateLimits[identifier] = {}
    end
    
    if not playerRateLimits[identifier][action] then
        playerRateLimits[identifier][action] = {
            count = 0,
            windowStart = currentTime
        }
    end
    
    local rateLimit = playerRateLimits[identifier][action]
    local config = rateLimits[action]
    
    -- Reset window if expired
    if (currentTime - rateLimit.windowStart) >= config.window then
        rateLimit.count = 0
        rateLimit.windowStart = currentTime
    end
    
    rateLimit.count = rateLimit.count + 1
    
    -- Check if limit exceeded
    if rateLimit.count > config.limit then
        LogSuspiciousActivity(source, 'Rate limit exceeded: ' .. action, {
            count = rateLimit.count,
            limit = config.limit
        })
        return false
    end
    
    return true
end
```

---

## 📊 Audit Logging

### Transaction Logging

All rewards and transactions are logged:

```lua
function LogRewardTransaction(source, questId, rewards)
    local identifier = GetPlayerIdentifier(source)
    local playerName = GetPlayerName(source)
    
    local logEntry = {
        timestamp = os.date('%Y-%m-%d %H:%M:%S'),
        identifier = identifier,
        playerName = playerName,
        questId = questId,
        rewards = rewards,
        action = 'quest_reward'
    }
    
    -- Log to database
    MySQL.insert('INSERT INTO lxr_quest_logs (identifier, action, data, timestamp) VALUES (?, ?, ?, ?)', {
        identifier,
        'quest_reward',
        json.encode(logEntry),
        os.time()
    })
    
    -- Log to console (if debug enabled)
    if Config.EnableDebug then
        print(string.format('[LXR-Quests] Reward: %s completed %s - $%.2f, %d XP', 
            playerName, questId, rewards.cash, rewards.xp))
    end
end
```

### Suspicious Activity Logging

```lua
function LogSuspiciousActivity(source, reason, data)
    local identifier = GetPlayerIdentifier(source)
    local playerName = GetPlayerName(source)
    
    local logEntry = {
        timestamp = os.date('%Y-%m-%d %H:%M:%S'),
        identifier = identifier,
        playerName = playerName,
        reason = reason,
        data = data,
        severity = 'warning'
    }
    
    -- Log to database
    MySQL.insert('INSERT INTO lxr_quest_security_logs (identifier, reason, data, timestamp) VALUES (?, ?, ?, ?)', {
        identifier,
        reason,
        json.encode(logEntry),
        os.time()
    })
    
    -- Alert admins if serious
    if IsSeriousViolation(reason) then
        AlertAdmins(playerName .. ' - Suspicious activity: ' .. reason)
    end
    
    -- Console log
    print(string.format('^3[LXR-Quests SECURITY] %s - %s - %s^7', 
        playerName, reason, json.encode(data)))
end
```

### Admin Alert System

```lua
function AlertAdmins(message)
    for _, playerId in ipairs(GetPlayers()) do
        if IsPlayerAdmin(playerId) then
            TriggerClientEvent('lxr-quests:client:notify', playerId, 
                '🛡️ Security Alert: ' .. message, 'warning', 10000)
        end
    end
end
```

---

## 🎯 Best Practices

### Server Configuration

1. **Always use server-side validation**
   - Never trust client data
   - Validate all inputs
   - Check permissions before actions

2. **Enable logging in production**
   ```lua
   Config.EnableAuditLog = true
   Config.LogSuspiciousActivity = true
   ```

3. **Configure appropriate cooldowns**
   - Balance gameplay vs exploitation
   - Adjust based on server economy
   - Monitor completion rates

4. **Regular security audits**
   - Review security logs weekly
   - Check for patterns of abuse
   - Update blacklists as needed

### Database Security

1. **Use parameterized queries**
   ```lua
   -- ✅ GOOD
   MySQL.query('SELECT * FROM users WHERE identifier = ?', {identifier})
   
   -- ❌ BAD
   MySQL.query('SELECT * FROM users WHERE identifier = ' .. identifier)
   ```

2. **Sanitize all inputs**
   ```lua
   function SanitizeInput(input)
       return input:gsub('[^%w%s-_]', '')
   end
   ```

3. **Use proper database permissions**
   - Quest script user should only need SELECT, INSERT, UPDATE
   - Never grant DROP or ALTER permissions

### Event Security

1. **Rate limit all events**
2. **Validate event sources**
3. **Never expose sensitive data to client**
4. **Use server callbacks for data requests**

### Client-Side Security

While server-side is primary, client-side can add friction:

```lua
-- Detect debugging/injection attempts
CreateThread(function()
    while true do
        Wait(30000) -- Every 30 seconds
        
        -- Check for common cheating tools
        if IsDebuggerPresent() then
            TriggerServerEvent('lxr-quests:server:reportCheat', 'debugger_detected')
        end
    end
end)
```

---

## 🔍 Threat Detection

### Automated Threat Detection

```lua
-- Threat scoring system
local threatScores = {}

function IncrementThreatScore(source, reason, points)
    local identifier = GetPlayerIdentifier(source)
    
    if not threatScores[identifier] then
        threatScores[identifier] = {
            score = 0,
            violations = {}
        }
    end
    
    threatScores[identifier].score = threatScores[identifier].score + points
    table.insert(threatScores[identifier].violations, {
        reason = reason,
        timestamp = os.time(),
        points = points
    })
    
    -- Take action based on score
    if threatScores[identifier].score >= 100 then
        BanPlayer(source, 'Multiple security violations')
    elseif threatScores[identifier].score >= 50 then
        KickPlayer(source, 'Suspicious activity detected')
    elseif threatScores[identifier].score >= 25 then
        AlertAdmins(GetPlayerName(source) .. ' has elevated threat score: ' .. threatScores[identifier].score)
    end
    
    LogSuspiciousActivity(source, reason, {
        points = points,
        totalScore = threatScores[identifier].score
    })
end

-- Threat levels
local ThreatLevels = {
    MINOR = 5,      -- Suspicious but could be innocent
    MODERATE = 15,  -- Likely cheating attempt
    SERIOUS = 30,   -- Definite cheating
    CRITICAL = 50   -- Ban immediately
}
```

---

## ⚙️ Security Configuration

### Recommended Production Settings

```lua
-- config.lua
Config.Security = {
    -- Logging
    enableAuditLog = true,
    enableSecurityLog = true,
    logRetentionDays = 30,
    
    -- Rate Limiting
    enableRateLimiting = true,
    maxRequestsPerMinute = 10,
    
    -- Validation
    validateDistance = true,
    maxInteractionDistance = 15.0,
    validateQuestTime = true,
    minimumQuestTime = 60, -- seconds
    
    -- Anti-Cheat
    enableEventFloodProtection = true,
    enableThreatScoring = true,
    autoKickThreshold = 50,
    autoBanThreshold = 100,
    
    -- Cooldowns
    enforceGlobalCooldown = true,
    enforceDifficultyCooldowns = true,
    
    -- Rewards
    maxRewardCash = 1000.0,
    maxRewardXP = 1000,
    validateRewardAmounts = true
}
```

### Test Environment Settings

```lua
-- For testing only - NEVER use in production
Config.Security = {
    enableAuditLog = false,
    enableRateLimiting = false,
    validateDistance = false,
    enforceGlobalCooldown = false,
    autoKickThreshold = 999999,
    autoBanThreshold = 999999
}
```

---

## 🆘 Security Incident Response

### If You Detect Cheating:

1. **Document everything**
   - Check security logs
   - Record player identifiers
   - Save timestamps

2. **Review logs**
   ```sql
   SELECT * FROM lxr_quest_security_logs 
   WHERE identifier = 'steam:xxxxx' 
   ORDER BY timestamp DESC;
   ```

3. **Take appropriate action**
   - Warn player
   - Temporary ban
   - Permanent ban

4. **Update security**
   - Add new detection rules
   - Adjust threat scores
   - Update documentation

---

## 📚 Additional Resources

- 📖 [Configuration Guide](./configuration.md)
- 🔧 [Framework Integration](./frameworks.md)
- 🎯 [Events & API Reference](./events.md)
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
