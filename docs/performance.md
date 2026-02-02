# 🐺 LXR Quest Missions - Performance Optimization Guide

```
██████╗ ███████╗██████╗ ███████╗ ██████╗ ██████╗ ███╗   ███╗ █████╗ ███╗   ██╗ ██████╗███████╗
██╔══██╗██╔════╝██╔══██╗██╔════╝██╔═══██╗██╔══██╗████╗ ████║██╔══██╗████╗  ██║██╔════╝██╔════╝
██████╔╝█████╗  ██████╔╝█████╗  ██║   ██║██████╔╝██╔████╔██║███████║██╔██╗ ██║██║     █████╗  
██╔═══╝ ██╔══╝  ██╔══██╗██╔══╝  ██║   ██║██╔══██╗██║╚██╔╝██║██╔══██║██║╚██╗██║██║     ██╔══╝  
██║     ███████╗██║  ██║██║     ╚██████╔╝██║  ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║╚██████╗███████╗
╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝
```

**🐺 The Land of Wolves - Performance Optimization Guide**

**Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!**

---

## 📖 Table of Contents

1. [Overview](#overview)
2. [Performance Targets](#performance-targets)
3. [Optimization Techniques](#optimization-techniques)
4. [Configuration for Performance](#configuration-for-performance)
5. [Tick Management](#tick-management)
6. [Memory Usage](#memory-usage)
7. [Database Optimization](#database-optimization)
8. [Client FPS Considerations](#client-fps-considerations)
9. [Server Load Management](#server-load-management)
10. [Profiling & Monitoring](#profiling--monitoring)

---

## 🌟 Overview

LXR Quest Missions is designed from the ground up with performance in mind. This guide explains the optimization techniques used and how to configure the system for optimal performance on your server.

### Performance Philosophy

🎯 **Core Principles:**
- Minimize unnecessary computations
- Reduce network traffic
- Optimize database queries
- Efficient memory management
- Client FPS preservation

### Resource Impact

**Typical Resource Usage:**
- **Server CPU:** < 0.02ms per tick (idle)
- **Server Memory:** ~5-10MB
- **Client FPS Impact:** < 1 FPS when idle, 2-3 FPS during active quest
- **Network Traffic:** ~1-2 KB/s per player with active quest
- **Database Queries:** 2-4 queries per quest cycle

---

## 🎯 Performance Targets

### Target Metrics

| Metric | Target | Excellent | Acceptable | Poor |
|--------|--------|-----------|------------|------|
| **Server Tick Time** | < 0.02ms | < 0.05ms | < 0.10ms | > 0.10ms |
| **Client FPS Impact** | < 1 FPS | < 3 FPS | < 5 FPS | > 5 FPS |
| **Memory Usage** | < 10MB | < 20MB | < 50MB | > 50MB |
| **Database Query Time** | < 5ms | < 10ms | < 25ms | > 25ms |
| **Network Latency** | < 10ms | < 25ms | < 50ms | > 50ms |

### Server Size Considerations

**Small Servers (< 32 players):**
- Can use more frequent updates
- Higher render distances acceptable
- Less aggressive caching needed

**Medium Servers (32-64 players):**
- Balanced settings recommended
- Moderate render distances
- Standard caching

**Large Servers (> 64 players):**
- Aggressive optimization required
- Reduced render distances
- Extensive caching recommended

---

## ⚡ Optimization Techniques

### 1. Distance-Based Rendering

NPCs and quest elements only render when players are nearby:

```lua
-- Efficient distance checking
local RENDER_DISTANCE = 150.0
local CHECK_INTERVAL = 1000 -- Check every 1 second

CreateThread(function()
    while true do
        Wait(CHECK_INTERVAL)
        
        local playerCoords = GetEntityCoords(PlayerPedId())
        
        for npcId, npcData in pairs(QuestNPCs) do
            local distance = #(playerCoords - npcData.coords)
            
            if distance <= RENDER_DISTANCE then
                if not npcData.spawned then
                    SpawnQuestNPC(npcId)
                end
            else
                if npcData.spawned then
                    DespawnQuestNPC(npcId)
                end
            end
        end
    end
end)
```

**Benefits:**
- ✅ Reduces entity count
- ✅ Lower memory usage
- ✅ Better client FPS
- ✅ Scales with server size

### 2. Event Throttling

Limit event frequency to prevent spam:

```lua
-- Throttle NUI updates
local lastNuiUpdate = 0
local NUI_UPDATE_INTERVAL = 100 -- 100ms minimum between updates

function UpdateQuestUI(data)
    local currentTime = GetGameTimer()
    
    if (currentTime - lastNuiUpdate) < NUI_UPDATE_INTERVAL then
        return -- Skip update if too soon
    end
    
    lastNuiUpdate = currentTime
    SendNUIMessage({
        action = 'updateQuest',
        data = data
    })
end
```

### 3. Lazy Loading

Load data only when needed:

```lua
-- Don't load all quests at startup
local questCache = {}

function GetQuestData(questId)
    -- Check cache first
    if questCache[questId] then
        return questCache[questId]
    end
    
    -- Load from database only if not cached
    local questData = MySQL.query.await('SELECT * FROM quests WHERE id = ?', {questId})
    
    -- Cache for future use
    questCache[questId] = questData
    
    return questData
end
```

### 4. Batch Operations

Process multiple operations together:

```lua
-- Bad: Multiple individual queries
for _, reward in ipairs(rewards) do
    MySQL.insert('INSERT INTO player_rewards VALUES (?, ?)', {playerId, reward})
end

-- Good: Single batch query
MySQL.insert('INSERT INTO player_rewards VALUES ?', {rewardBatch})
```

### 5. Smart Thread Management

Use dynamic tick rates based on activity:

```lua
local activeTickRate = 0 -- Process every frame when active
local idleTickRate = 1000 -- Process every 1s when idle

CreateThread(function()
    while true do
        local tickRate = HasActiveQuest() and activeTickRate or idleTickRate
        Wait(tickRate)
        
        -- Process quest logic
        ProcessQuestLogic()
    end
end)
```

---

## ⚙️ Configuration for Performance

### Recommended Settings by Server Size

#### Small Servers (< 32 players)

```lua
Config.Performance = {
    npcUpdateRate = 500,           -- 500ms (faster)
    interactionDistance = 3.0,
    npcRenderDistance = 200.0,     -- Larger render distance
    enableThreadOptimization = true,
    reducedTickRate = 500,
    cleanupInterval = 600000,      -- 10 minutes
    maxCachedQuests = 20           -- More caching
}
```

#### Medium Servers (32-64 players)

```lua
Config.Performance = {
    npcUpdateRate = 1000,          -- 1 second (balanced)
    interactionDistance = 3.0,
    npcRenderDistance = 150.0,     -- Standard render distance
    enableThreadOptimization = true,
    reducedTickRate = 500,
    cleanupInterval = 300000,      -- 5 minutes
    maxCachedQuests = 10           -- Standard caching
}
```

#### Large Servers (> 64 players)

```lua
Config.Performance = {
    npcUpdateRate = 1500,          -- 1.5 seconds (slower)
    interactionDistance = 2.5,     -- Smaller interaction range
    npcRenderDistance = 100.0,     -- Reduced render distance
    enableThreadOptimization = true,
    reducedTickRate = 1000,        -- Slower background threads
    cleanupInterval = 180000,      -- 3 minutes
    maxCachedQuests = 5            -- Minimal caching
}
```

### Performance Options Explained

| Option | Description | Performance Impact |
|--------|-------------|-------------------|
| `npcUpdateRate` | How often NPCs are updated (ms) | Higher = better performance |
| `interactionDistance` | Distance to show prompts | Lower = better performance |
| `npcRenderDistance` | Distance to render NPCs | Lower = better performance |
| `enableThreadOptimization` | Use smart tick management | Enable for better performance |
| `reducedTickRate` | Tick rate for idle threads | Higher = better performance |
| `cleanupInterval` | Memory cleanup frequency | Balance needed |
| `maxCachedQuests` | Number of quests to cache | Higher = faster, more memory |

---

## 🔄 Tick Management

### Understanding Ticks

In FiveM/RedM, a "tick" is a single frame execution. Each script runs code every tick (or every N ticks if using Wait()).

**The Problem:**
```lua
-- BAD: Runs every frame (~60 times per second)
CreateThread(function()
    while true do
        Wait(0) -- Process EVERY frame
        DoExpensiveOperation()
    end
end)
```

**The Solution:**
```lua
-- GOOD: Runs once per second
CreateThread(function()
    while true do
        Wait(1000) -- Wait 1 second
        DoExpensiveOperation()
    end
end)
```

### Dynamic Tick Rates

Adjust tick rate based on what the player is doing:

```lua
local TickRates = {
    INACTIVE = 5000,      -- 5 seconds when player is far away
    IDLE = 1000,          -- 1 second when player is nearby but not interacting
    ACTIVE = 100,         -- 0.1 seconds during active interaction
    COMBAT = 0            -- Every frame during combat/quest
}

CreateThread(function()
    while true do
        local playerState = GetPlayerState()
        local tickRate = TickRates[playerState]
        Wait(tickRate)
        
        ProcessQuestSystem()
    end
end)

function GetPlayerState()
    if HasActiveQuest() and InCombat() then
        return 'COMBAT'
    elseif IsNearQuestNPC() then
        if IsInteractingWithNPC() then
            return 'ACTIVE'
        else
            return 'IDLE'
        end
    else
        return 'INACTIVE'
    end
end
```

### Tick Budget Management

Track how much time your script uses:

```lua
local function ProfiledTick()
    local startTime = GetGameTimer()
    
    -- Your tick code here
    ProcessQuestLogic()
    
    local endTime = GetGameTimer()
    local tickTime = endTime - startTime
    
    if tickTime > 5 then -- Log if tick takes > 5ms
        print('^3[Performance Warning] Tick took ' .. tickTime .. 'ms^7')
    end
end
```

---

## 💾 Memory Usage

### Memory Optimization Strategies

#### 1. Proper Table Cleanup

```lua
-- Bad: Creates memory leak
local questData = {}
function AddQuestData(data)
    table.insert(questData, data) -- Never cleaned up
end

-- Good: Cleanup old data
local questData = {}
local MAX_QUEST_HISTORY = 50

function AddQuestData(data)
    table.insert(questData, data)
    
    -- Remove old entries
    if #questData > MAX_QUEST_HISTORY then
        table.remove(questData, 1)
    end
end
```

#### 2. Garbage Collection

```lua
-- Force garbage collection periodically
CreateThread(function()
    while true do
        Wait(300000) -- Every 5 minutes
        
        collectgarbage("collect")
        
        if Config.EnableDebug then
            print('[LXR-Quests] Memory after GC: ' .. collectgarbage("count") .. ' KB')
        end
    end
end)
```

#### 3. Efficient Data Structures

```lua
-- Bad: Store full quest data in active quests
activeQuests[playerId] = {
    fullQuestData = GetCompleteQuestData(questId), -- 10KB+ of data
    startTime = os.time()
}

-- Good: Store only what's needed
activeQuests[playerId] = {
    questId = questId,  -- Just the ID (few bytes)
    startTime = os.time()
}
-- Fetch full data only when needed
```

### Memory Monitoring

```lua
-- Monitor memory usage
CreateThread(function()
    if not Config.EnableDebug then return end
    
    while true do
        Wait(60000) -- Every minute
        
        local memoryUsage = collectgarbage("count")
        print(string.format('[LXR-Quests] Memory: %.2f MB', memoryUsage / 1024))
        
        if memoryUsage > 51200 then -- 50MB
            print('^3[Warning] High memory usage detected!^7')
        end
    end
end)
```

---

## 🗄️ Database Optimization

### Query Optimization

#### 1. Use Indexes

```sql
-- Create indexes for frequently queried columns
CREATE INDEX idx_player_quests_identifier ON player_quests(identifier);
CREATE INDEX idx_player_quests_status ON player_quests(status);
CREATE INDEX idx_quest_logs_timestamp ON quest_logs(timestamp);
```

#### 2. Prepared Statements

```lua
-- Use parameterized queries (prevents SQL injection AND improves performance)
MySQL.prepare('SELECT * FROM player_quests WHERE identifier = ?', {identifier})
```

#### 3. Batch Queries

```lua
-- Bad: Multiple queries in sequence
for i = 1, 10 do
    MySQL.query('SELECT * FROM quests WHERE id = ?', {questIds[i]})
end

-- Good: Single query with IN clause
local ids = table.concat(questIds, ',')
MySQL.query('SELECT * FROM quests WHERE id IN (?)', {ids})
```

#### 4. Async Queries

```lua
-- Non-blocking database access
MySQL.query('SELECT * FROM player_quests WHERE identifier = ?', {identifier}, function(result)
    -- Process result without blocking server thread
    ProcessQuestData(result)
end)
```

### Connection Pooling

Ensure your database resource uses connection pooling:

```lua
-- oxmysql configuration (server.cfg)
set mysql_connection_string "mysql://user:pass@localhost/database?charset=utf8mb4"
set mysql_slow_query_warning 100
set mysql_debug false
set mysql_pool_size 5 -- Number of connections to keep open
```

### Database Caching

```lua
-- Cache database results
local dbCache = {}
local CACHE_DURATION = 300 -- 5 minutes

function GetPlayerQuestData(identifier)
    -- Check cache first
    if dbCache[identifier] and (os.time() - dbCache[identifier].timestamp) < CACHE_DURATION then
        return dbCache[identifier].data
    end
    
    -- Query database
    local data = MySQL.query.await('SELECT * FROM player_quests WHERE identifier = ?', {identifier})
    
    -- Update cache
    dbCache[identifier] = {
        data = data,
        timestamp = os.time()
    }
    
    return data
end
```

---

## 🎮 Client FPS Considerations

### FPS Impact Analysis

**Operations and Their Impact:**

| Operation | FPS Impact | Frequency | Optimization |
|-----------|-----------|-----------|--------------|
| Distance checks | Low (~0.1) | Every 1s | Acceptable |
| NPC spawning | Medium (~2) | Occasional | Use LOD |
| UI updates | Low (~0.5) | As needed | Throttle |
| Blip updates | Low (~0.3) | Occasional | Batch |
| Combat AI | High (~3-5) | Active quests | Optimize paths |

### FPS Optimization Techniques

#### 1. Level of Detail (LOD)

```lua
-- Reduce detail for distant objects
function SpawnQuestNPC(npcId, distance)
    local npcData = Config.QuestNPCs[npcId]
    
    -- Use lower LOD for distant NPCs
    if distance > 100.0 then
        npcData.frozen = true -- Don't process AI
        npcData.invisible = false
    else
        npcData.frozen = false -- Full AI processing
        npcData.invisible = false
    end
    
    local ped = CreatePed(npcData.model, npcData.coords, npcData.heading, false, false)
    SetEntityAsMissionEntity(ped, true, true)
    SetBlockingOfNonTemporaryEvents(ped, npcData.frozen)
    
    return ped
end
```

#### 2. Conditional Rendering

```lua
-- Only show prompts when looking at NPC
function ShouldShowPrompt(npcCoords)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local distance = #(playerCoords - npcCoords)
    
    if distance > 3.0 then
        return false
    end
    
    -- Check if player is facing the NPC
    local heading = GetEntityHeading(playerPed)
    local angle = GetAngleBetweenCoords(playerCoords, npcCoords)
    local angleDiff = math.abs(heading - angle)
    
    return angleDiff < 45 -- Only show if within 45 degree cone
end
```

#### 3. Efficient Particle Effects

```lua
-- Limit particle effects based on FPS
function SpawnQuestEffect(coords)
    local fps = GetFrameTime() * 1000
    
    if fps < 30 then
        return -- Skip effects on low FPS
    end
    
    -- Spawn particle effect
    UseParticleFxAsset("core")
    StartParticleFxNonLoopedAtCoord("ent_anim_torch", coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 1.0, false, false, false)
end
```

---

## 🖥️ Server Load Management

### Load Balancing

Distribute operations across ticks:

```lua
-- Process players in batches instead of all at once
local playerProcessIndex = 1

CreateThread(function()
    while true do
        Wait(100) -- Process batch every 100ms
        
        local players = GetPlayers()
        local batchSize = 5 -- Process 5 players per tick
        
        for i = playerProcessIndex, math.min(playerProcessIndex + batchSize - 1, #players) do
            ProcessPlayerQuests(players[i])
        end
        
        playerProcessIndex = playerProcessIndex + batchSize
        if playerProcessIndex > #players then
            playerProcessIndex = 1
        end
    end
end)
```

### Server Metrics

Monitor server performance:

```lua
CreateThread(function()
    if not Config.EnableDebug then return end
    
    while true do
        Wait(30000) -- Every 30 seconds
        
        local playerCount = #GetPlayers()
        local activeQuests = GetActiveQuestCount()
        local memory = collectgarbage("count") / 1024
        
        print(string.format('[LXR-Quests] Players: %d | Active Quests: %d | Memory: %.2f MB', 
            playerCount, activeQuests, memory))
    end
end)
```

---

## 📊 Profiling & Monitoring

### Built-in Profiler

```lua
-- Simple profiler
local Profiler = {}

function Profiler.Start(name)
    if not Profiler[name] then
        Profiler[name] = {calls = 0, totalTime = 0}
    end
    Profiler[name].startTime = GetGameTimer()
end

function Profiler.Stop(name)
    local endTime = GetGameTimer()
    local duration = endTime - Profiler[name].startTime
    
    Profiler[name].calls = Profiler[name].calls + 1
    Profiler[name].totalTime = Profiler[name].totalTime + duration
    Profiler[name].avgTime = Profiler[name].totalTime / Profiler[name].calls
end

function Profiler.Report()
    print('^2========== LXR Quests Profiler Report ==========^7')
    for name, data in pairs(Profiler) do
        if type(data) == 'table' then
            print(string.format('%s: %d calls, %.2fms avg, %.2fms total', 
                name, data.calls, data.avgTime, data.totalTime))
        end
    end
    print('^2================================================^7')
end

-- Usage
Profiler.Start('AcceptQuest')
AcceptQuest(source, questId)
Profiler.Stop('AcceptQuest')

-- Print report every 5 minutes
CreateThread(function()
    while true do
        Wait(300000)
        Profiler.Report()
    end
end)
```

### External Monitoring

Use FiveM's built-in profiler:

```bash
# In server console
profiler start
# ... let it run for a while ...
profiler save
# Check server/profiles/ folder
```

### Performance Commands

```lua
-- Admin command to check performance
RegisterCommand('questperf', function(source, args)
    if not IsPlayerAdmin(source) then return end
    
    local stats = {
        memory = collectgarbage("count") / 1024,
        activeQuests = GetActiveQuestCount(),
        cachedQuests = GetCachedQuestCount(),
        players = #GetPlayers()
    }
    
    TriggerClientEvent('chat:addMessage', source, {
        args = {'[LXR-Quests]', string.format('Memory: %.2fMB | Active: %d | Cached: %d | Players: %d',
            stats.memory, stats.activeQuests, stats.cachedQuests, stats.players)}
    })
end, false)
```

---

## 🎯 Performance Checklist

### Initial Setup
- [ ] Configure settings for your server size
- [ ] Enable thread optimization
- [ ] Set appropriate render distances
- [ ] Configure database connection pooling
- [ ] Create database indexes

### Regular Maintenance
- [ ] Monitor memory usage weekly
- [ ] Review server logs for performance warnings
- [ ] Check average tick times
- [ ] Profile script performance monthly
- [ ] Update optimization settings as needed

### Troubleshooting High Usage
1. Enable debug mode temporarily
2. Run profiler to identify bottlenecks
3. Check for memory leaks
4. Review recent config changes
5. Monitor database query times

---

## 📚 Additional Resources

- 📖 [Configuration Guide](./configuration.md)
- 🔧 [Framework Integration](./frameworks.md)
- 🎯 [Events & API Reference](./events.md)
- 🔒 [Security Guide](./security.md)

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
