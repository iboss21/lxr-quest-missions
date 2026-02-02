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

-- ═══════════════════════════════════════════════════════════════════════════════
-- FRAMEWORK DETECTION & INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════

local Framework = nil
local FrameworkType = Config.Framework

function InitializeFramework()
    if FrameworkType == 'auto' then
        -- Auto-detect framework
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
    
    if Config.EnableDebug then
        print(('[🐺 Bounty Quests] Framework detected: %s'):format(FrameworkType))
    end
    
    -- Initialize framework-specific functions
    if FrameworkType == 'lxrcore' or FrameworkType == 'rsg-core' or FrameworkType == 'qbr-core' or FrameworkType == 'qr-core' then
        Framework = exports[Config.FrameworkSettings[FrameworkType].resource]:GetCoreObject()
    elseif FrameworkType == 'vorp' then
        Framework = exports.vorp_core:GetCore()
    elseif FrameworkType == 'redemrp' then
        TriggerEvent('redem:getSharedObject', function(obj) Framework = obj end)
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
    
    if FrameworkType == 'vorp' then
        Framework.NotifyLeft('Bounty Quests', message, 'generic_textures', 'tick', Config.Notifications.Duration)
    elseif FrameworkType == 'lxrcore' or FrameworkType == 'rsg-core' or FrameworkType == 'qbr-core' then
        Framework.Functions.Notify(message, type, Config.Notifications.Duration)
    else
        -- Native notification
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
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, npc.coords.x, npc.coords.y, npc.coords.z)
        SetBlipSprite(blip, GetHashKey(npc.blipSprite or 'blip_bounty_poster_4'), 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, npc.blipName or 'Bounty Quest')
    end
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
        local hash = GetHashKey(npc.model)
        
        if not HasModelLoaded(hash) then
            RequestModel(hash)
            while not HasModelLoaded(hash) do
                Wait(100)
            end
        end
        
        local ped = CreatePed(hash, npc.coords.x, npc.coords.y, npc.coords.z, npc.coords.w, false, false, false, false)
        Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
        SetEntityCanBeDamaged(ped, false)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)
        
        -- Store NPC reference
        npc.entity = ped
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

-- ═══════════════════════════════════════════════════════════════════════════════
-- MAIN THREAD - NPC INTERACTION
-- ═══════════════════════════════════════════════════════════════════════════════

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        if PlayerLoaded then
            for _, npc in ipairs(Config.QuestNPCs) do
                local distance = GetDistance(playerCoords, npc.coords)
                
                if distance < 50.0 then
                    sleep = 0
                    
                    if distance < 3.0 then
                        -- Draw text prompt
                        DrawText3D(npc.coords.x, npc.coords.y, npc.coords.z + 1.0, GetLocale('press_to_interact', npc.name))
                        
                        -- Check for key press
                        if IsControlJustReleased(0, Config.Keys.OpenQuestMenu) then
                            OpenQuestMenu(npc.id)
                        end
                    end
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
