--[[
    🐺 Land of Wolves - Bounty Quests System
    Client-Side Main Script
    © 2026 iBoss21 / The Lux Empire | wolves.land
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- VARIABLES & INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════

local PlayerData = {}
local PlayerLoaded = false
local CurrentQuest = nil
local QuestTarget = nil
local QuestGuards = {}
local AnimalGuards = {}
local QuestBlip = nil
local TargetBlip = nil
local NPCPrompts = {}
local NPCEntities = {} -- Store spawned NPC entities
local NPCBlips = {} -- Store NPC blips
local NPCCurrentLocations = {} -- Synced from server

-- ═══════════════════════════════════════════════════════════════════════════════
-- FRAMEWORK DETECTION & INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════
-- Note: Framework is initialized globally in shared/framework.lua
-- We just keep FrameworkType for backward compatibility with player loaded events

local FrameworkType = Config.Framework

function InitializeFramework()
    -- Framework is already initialized in shared/framework.lua
    -- Just sync the FrameworkType for compatibility
    if Framework and Framework.Type then
        FrameworkType = Framework.Type
    else
        -- Fallback to config setting if Framework not ready yet
        FrameworkType = Config.Framework or 'standalone'
    end
    
    if Config.EnableDebug then
        print(('[🐺 Bounty Quests] Using Framework: %s'):format(FrameworkType))
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════

function GetLocale(key, ...)
    local locale = Locales[Config.Lang] or Locales['English']
    local text = locale[key] or key
    if ... then
        return string.format(text, ...)
    end
    return text
end

function ShowNotification(message, type)
    if not Config.Notifications.Enabled then return end
    
    local notifType = Config.Notifications.Types[type] or Config.Notifications.Types.info
    
    -- Use the Framework.Notify method from shared/framework.lua
    if Framework and Framework.Notify then
        Framework.Notify(message, type, Config.Notifications.Duration)
    else
        -- Fallback to native notification if framework not ready
        local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", message, Citizen.ResultAsLong())
        Citizen.InvokeNative(0xE9990552DEC71600)
    end
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px, py, pz) - vector3(x, y, z))
    
    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov
    
    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function GetDistance(coords1, coords2)
    return #(vector3(coords1.x, coords1.y, coords1.z) - vector3(coords2.x, coords2.y, coords2.z))
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- BLIP MANAGEMENT
-- ═══════════════════════════════════════════════════════════════════════════════

function CreateQuestNPCBlips()
    if not Config.EnableBlips then return end
    
    for _, npc in ipairs(Config.QuestNPCs) do
        UpdateNPCBlip(npc)
    end
end

function UpdateNPCBlip(npc)
    if not Config.EnableBlips then return end
    
    -- Remove existing blip if any
    if NPCBlips[npc.id] then
        RemoveBlip(NPCBlips[npc.id])
        NPCBlips[npc.id] = nil
    end
    
    -- Get current location from synced data or fallback to config
    local coords = npc.coords
    if NPCCurrentLocations[npc.id] and NPCCurrentLocations[npc.id].isAvailable then
        coords = NPCCurrentLocations[npc.id].coords
    elseif NPCCurrentLocations[npc.id] and not NPCCurrentLocations[npc.id].isAvailable then
        -- NPC is not available, don't create blip
        return
    end
    
    local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, coords.x, coords.y, coords.z)
    SetBlipSprite(blip, GetHashKey(npc.blipSprite or 'blip_bounty_poster_4'), 1)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, npc.blipName or 'Bounty Quest')
    NPCBlips[npc.id] = blip
end

function CreateQuestBlip(coords, name)
    RemoveQuestBlip()
    
    QuestBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, coords.x, coords.y, coords.z)
    SetBlipSprite(QuestBlip, GetHashKey('blip_ambient_companion'), 1)
    Citizen.InvokeNative(0x9CB1A1623062F402, QuestBlip, name or 'Quest Location')
    return QuestBlip
end

function RemoveQuestBlip()
    if QuestBlip then
        RemoveBlip(QuestBlip)
        QuestBlip = nil
    end
end

function CreateTargetBlip(entity)
    RemoveTargetBlip()
    
    TargetBlip = Citizen.InvokeNative(0x23F74C2FDA6E7C61, -1282792512, entity)
    SetBlipSprite(TargetBlip, GetHashKey('blip_bounty_poster_4'), 1)
    return TargetBlip
end

function RemoveTargetBlip()
    if TargetBlip then
        RemoveBlip(TargetBlip)
        TargetBlip = nil
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- NPC SPAWN & MANAGEMENT
-- ═══════════════════════════════════════════════════════════════════════════════

function SpawnQuestNPCs()
    for _, npc in ipairs(Config.QuestNPCs) do
        SpawnQuestNPC(npc)
    end
end

function SpawnQuestNPC(npc)
    -- Remove existing NPC if any
    if NPCEntities[npc.id] and DoesEntityExist(NPCEntities[npc.id]) then
        DeleteEntity(NPCEntities[npc.id])
        NPCEntities[npc.id] = nil
    end
    
    -- Get current location from synced data or fallback to config
    local coords = npc.coords
    if NPCCurrentLocations[npc.id] and NPCCurrentLocations[npc.id].isAvailable then
        coords = NPCCurrentLocations[npc.id].coords
    elseif NPCCurrentLocations[npc.id] and not NPCCurrentLocations[npc.id].isAvailable then
        -- NPC is not available at this time, don't spawn
        return
    end
    
    local hash = GetHashKey(npc.model)
    
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Wait(100)
        end
    end
    
    local ped = CreatePed(hash, coords.x, coords.y, coords.z, coords.w, false, false, false, false)
    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
    SetEntityCanBeDamaged(ped, false)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    
    -- Store NPC reference
    NPCEntities[npc.id] = ped
    
    if Config.EnableDebug then
        print(('[🐺 Bounty Quests] Spawned NPC: %s at %s'):format(npc.name, coords))
    end
end

function RemoveQuestNPC(npcId)
    -- Remove NPC entity
    if NPCEntities[npcId] and DoesEntityExist(NPCEntities[npcId]) then
        DeleteEntity(NPCEntities[npcId])
        NPCEntities[npcId] = nil
    end
    
    -- Remove blip
    if NPCBlips[npcId] then
        RemoveBlip(NPCBlips[npcId])
        NPCBlips[npcId] = nil
    end
    
    if Config.EnableDebug then
        print(('[🐺 Bounty Quests] Removed NPC: %s'):format(npcId))
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- QUEST FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════

function OpenQuestMenu(npcId)
    -- Send request to server for quest menu data
    TriggerServerEvent('lxr-bounty:server:openQuestMenu', npcId)
end

function AcceptQuest(questId, npcId)
    TriggerServerEvent('lxr-bounty:server:acceptQuest', questId, npcId)
end

function CompleteQuestObjective(objectiveType, data)
    TriggerServerEvent('lxr-bounty:server:completeObjective', objectiveType, data)
end

function IdentifyTarget()
    if not QuestTarget or not DoesEntityExist(QuestTarget) then
        ShowNotification(GetLocale('error_target_not_spawned'), 'error')
        return
    end
    
    if not IsEntityDead(QuestTarget) then
        ShowNotification(GetLocale('error_invalid_target'), 'error')
        return
    end
    
    local playerCoords = GetEntityCoords(PlayerPedId())
    local targetCoords = GetEntityCoords(QuestTarget)
    
    if GetDistance(playerCoords, targetCoords) > 3.0 then
        ShowNotification(GetLocale('too_far_away'), 'error')
        return
    end
    
    -- Send to server to complete quest
    TriggerServerEvent('lxr-bounty:server:identifyTarget')
    ShowNotification(GetLocale('target_identified', CurrentQuest.targetName), 'success')
end

function CollectRewards()
    TriggerServerEvent('lxr-bounty:server:collectRewards')
end

function CancelQuest()
    TriggerServerEvent('lxr-bounty:server:cancelQuest')
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- CLIENT EVENTS
-- ═══════════════════════════════════════════════════════════════════════════════

RegisterNetEvent('lxr-bounty:client:questStarted')
AddEventHandler('lxr-bounty:client:questStarted', function(questData)
    CurrentQuest = questData
    ShowNotification(GetLocale('quest_started', questData.title), 'success')
    
    -- Create quest location blip
    CreateQuestBlip(questData.location, questData.title)
    
    if Config.EnableDebug then
        print(('[🐺 Bounty Quests] Quest started: %s'):format(questData.id))
    end
end)

RegisterNetEvent('lxr-bounty:client:questCompleted')
AddEventHandler('lxr-bounty:client:questCompleted', function()
    ShowNotification(GetLocale('quest_completed'), 'success')
    RemoveQuestBlip()
    RemoveTargetBlip()
    CurrentQuest = nil
end)

RegisterNetEvent('lxr-bounty:client:questFailed')
AddEventHandler('lxr-bounty:client:questFailed', function(reason)
    ShowNotification(GetLocale('quest_failed', reason), 'error')
    RemoveQuestBlip()
    RemoveTargetBlip()
    CurrentQuest = nil
end)

RegisterNetEvent('lxr-bounty:client:spawnTarget')
AddEventHandler('lxr-bounty:client:spawnTarget', function(targetData)
    -- Target spawning is handled server-side for security
    -- Client receives notification only
    ShowNotification(GetLocale('target_spawned'), 'info')
end)

RegisterNetEvent('lxr-bounty:client:showNotification')
AddEventHandler('lxr-bounty:client:showNotification', function(message, type)
    ShowNotification(message, type or 'info')
end)

RegisterNetEvent('lxr-bounty:client:syncNPCLocations')
AddEventHandler('lxr-bounty:client:syncNPCLocations', function(locations)
    NPCCurrentLocations = locations
    
    -- Update all NPCs with new locations
    for _, npc in ipairs(Config.QuestNPCs) do
        if locations[npc.id] then
            SpawnQuestNPC(npc)
            UpdateNPCBlip(npc)
        end
    end
    
    if Config.EnableDebug then
        print('[🐺 Bounty Quests] Synced NPC locations from server')
    end
end)

RegisterNetEvent('lxr-bounty:client:updateNPCLocation')
AddEventHandler('lxr-bounty:client:updateNPCLocation', function(npcId, locationData)
    NPCCurrentLocations[npcId] = locationData
    
    -- Find the NPC config
    for _, npc in ipairs(Config.QuestNPCs) do
        if npc.id == npcId then
            -- Respawn NPC at new location
            SpawnQuestNPC(npc)
            UpdateNPCBlip(npc)
            
            if Config.EnableDebug then
                print(('[🐺 Bounty Quests] Updated NPC location: %s at %s - %s'):format(npc.name, locationData.city, locationData.location))
            end
            
            -- Notify player if they're near the old location
            ShowNotification(string.format('%s has moved to %s - %s', npc.name, locationData.city, locationData.location), 'info')
            break
        end
    end
end)

RegisterNetEvent('lxr-bounty:client:removeNPC')
AddEventHandler('lxr-bounty:client:removeNPC', function(npcId)
    RemoveQuestNPC(npcId)
    
    -- Find NPC name
    for _, npc in ipairs(Config.QuestNPCs) do
        if npc.id == npcId then
            ShowNotification(string.format('%s is not available at this time', npc.name), 'info')
            break
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- MAIN THREAD - NPC INTERACTION
-- ═══════════════════════════════════════════════════════════════════════════════

function CheckNPCInteraction(playerPed, playerCoords, npc)
    -- Get current NPC location
    local npcCoords = npc.coords
    if NPCCurrentLocations[npc.id] and NPCCurrentLocations[npc.id].isAvailable then
        npcCoords = NPCCurrentLocations[npc.id].coords
    elseif NPCCurrentLocations[npc.id] and not NPCCurrentLocations[npc.id].isAvailable then
        -- Skip this NPC as it's not available
        return false
    end
    
    local distance = GetDistance(playerCoords, npcCoords)
    
    if distance < 50.0 then
        if distance < 3.0 then
            -- Build location info text
            local locationText = ''
            if NPCCurrentLocations[npc.id] then
                locationText = string.format('\n~o~%s - %s~w~', NPCCurrentLocations[npc.id].city, NPCCurrentLocations[npc.id].location)
            end
            
            -- Draw text prompt
            DrawText3D(npcCoords.x, npcCoords.y, npcCoords.z + 1.0, GetLocale('press_to_interact', npc.name) .. locationText)
            
            -- Check for key press
            if IsControlJustReleased(0, Config.Keys.OpenQuestMenu) then
                OpenQuestMenu(npc.id)
            end
        end
        return true
    end
    
    return false
end

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        if PlayerLoaded then
            for _, npc in ipairs(Config.QuestNPCs) do
                if CheckNPCInteraction(playerPed, playerCoords, npc) then
                    sleep = 0
                end
            end
        end
        
        Wait(sleep)
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- MAIN THREAD - TARGET IDENTIFICATION
-- ═══════════════════════════════════════════════════════════════════════════════

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        
        if CurrentQuest and QuestTarget and DoesEntityExist(QuestTarget) and IsEntityDead(QuestTarget) then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local targetCoords = GetEntityCoords(QuestTarget)
            local distance = GetDistance(playerCoords, targetCoords)
            
            if distance < 10.0 then
                sleep = 0
                
                if distance < 3.0 then
                    DrawText3D(targetCoords.x, targetCoords.y, targetCoords.z + 0.5, GetLocale('press_to_identify'))
                    
                    if IsControlJustReleased(0, Config.Keys.IdentifyTarget) then
                        IdentifyTarget()
                    end
                end
            end
        end
        
        Wait(sleep)
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════

Citizen.CreateThread(function()
    InitializeFramework()
    
    -- Wait for player to load
    while not PlayerLoaded do
        Wait(1000)
    end
    
    -- Request NPC locations from server
    TriggerServerEvent('lxr-bounty:server:requestNPCLocations')
    
    -- Wait a bit for server response
    Wait(1000)
    
    -- Create NPC blips
    CreateQuestNPCBlips()
    
    -- Spawn quest NPCs
    SpawnQuestNPCs()
    
    if Config.EnableDebug then
        print('[🐺 Bounty Quests] Client initialized successfully')
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- PLAYER LOADED EVENT
-- ═══════════════════════════════════════════════════════════════════════════════

if FrameworkType == 'lxrcore' or FrameworkType == 'rsg-core' or FrameworkType == 'qbr-core' or FrameworkType == 'qr-core' then
    RegisterNetEvent(Config.FrameworkSettings[FrameworkType].playerLoaded)
    AddEventHandler(Config.FrameworkSettings[FrameworkType].playerLoaded, function(playerData)
        PlayerData = playerData
        PlayerLoaded = true
    end)
elseif FrameworkType == 'vorp' then
    RegisterNetEvent('vorp:SelectedCharacter')
    AddEventHandler('vorp:SelectedCharacter', function(charid)
        PlayerLoaded = true
    end)
elseif FrameworkType == 'redemrp' then
    RegisterNetEvent('RedEM:PlayerLoaded')
    AddEventHandler('RedEM:PlayerLoaded', function()
        PlayerLoaded = true
    end)
else
    -- Standalone - assume player is always loaded
    PlayerLoaded = true
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- COMMANDS
-- ═══════════════════════════════════════════════════════════════════════════════

RegisterCommand('bountyhelp', function()
    ShowNotification(GetLocale('help_text'), 'info')
end, false)

RegisterCommand('bountystats', function()
    TriggerServerEvent('lxr-bounty:server:getStats')
end, false)

RegisterCommand('bountycancel', function()
    if CurrentQuest then
        CancelQuest()
    else
        ShowNotification(GetLocale('error_no_active_quest'), 'error')
    end
end, false)

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 End of Client Script - wolves.land
-- ═══════════════════════════════════════════════════════════════════════════════
