--[[
    ██╗      █████╗ ███╗   ██╗██████╗      ██████╗ ███████╗    ██╗    ██╗ ██████╗ ██╗    ██╗   ██╗███████╗███████╗
    ██║     ██╔══██╗████╗  ██║██╔══██╗    ██╔═══██╗██╔════╝    ██║    ██║██╔═══██╗██║    ██║   ██║██╔════╝██╔════╝
    ██║     ███████║██╔██╗ ██║██║  ██║    ██║   ██║█████╗      ██║ █╗ ██║██║   ██║██║    ██║   ██║█████╗  ███████╗
    ██║     ██╔══██║██║╚██╗██║██║  ██║    ██║   ██║██╔══╝      ██║███╗██║██║   ██║██║    ╚██╗ ██╔╝██╔══╝  ╚════██║
    ███████╗██║  ██║██║ ╚████║██████╔╝    ╚██████╔╝██║         ╚███╔███╔╝╚██████╔╝███████╗╚████╔╝ ███████╗███████║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═╝          ╚══╝╚══╝  ╚═════╝ ╚══════╝ ╚═══╝  ╚══════╝╚══════╝
                                                                                                                     
    🐺 LXR Bounty Quests System - Framework Bridge/Adapter Layer
    
    This file provides a unified interface for all supported frameworks.
    Automatically detects and adapts to the current framework in use.
    
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
    Framework Support:
    - LXRCore (Primary)
    - RSG Core (Primary)
    - VORP Core
    - RedEM:RP
    - QBR Core
    - QR Core
    - Standalone
    
    ═══════════════════════════════════════════════════════════════════════════════
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- FRAMEWORK BRIDGE INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════

Framework = {}
Framework.Type = nil
Framework.Core = nil
Framework.Ready = false

-- ═══════════════════════════════════════════════════════════════════════════════
-- AUTO-DETECTION & INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════

function Framework.Initialize()
    local frameworkType = Config.Framework or 'auto'
    
    if frameworkType == 'auto' then
        if GetResourceState('lxr-core') == 'started' then
            frameworkType = 'lxrcore'
        elseif GetResourceState('rsg-core') == 'started' then
            frameworkType = 'rsg-core'
        elseif GetResourceState('qbr-core') == 'started' then
            frameworkType = 'qbr-core'
        elseif GetResourceState('qr-core') == 'started' then
            frameworkType = 'qr-core'
        elseif GetResourceState('vorp_core') == 'started' then
            frameworkType = 'vorp'
        elseif GetResourceState('redem_roleplay') == 'started' then
            frameworkType = 'redemrp'
        else
            frameworkType = 'standalone'
        end
    end
    
    Framework.Type = frameworkType
    
    if Config.EnableDebug then
        print(('[🐺 Bounty Quests] Framework detected: %s'):format(frameworkType))
    end
    
    -- Initialize core object based on framework
    if frameworkType == 'lxrcore' or frameworkType == 'rsg-core' or frameworkType == 'qbr-core' or frameworkType == 'qr-core' then
        Framework.Core = exports[Config.FrameworkSettings[frameworkType].resource]:GetCoreObject()
    elseif frameworkType == 'vorp' then
        Framework.Core = exports.vorp_core:GetCore()
    elseif frameworkType == 'redemrp' then
        if IsDuplicityVersion() then
            TriggerEvent('redem:getSharedObject', function(obj) 
                Framework.Core = obj 
                Framework.Ready = true
            end)
        else
            TriggerEvent('redem:getSharedObject', function(obj) 
                Framework.Core = obj 
                Framework.Ready = true
            end)
        end
    elseif frameworkType == 'standalone' then
        Framework.Core = nil
    end
    
    if frameworkType ~= 'redemrp' then
        Framework.Ready = true
    end
    
    return Framework
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- CLIENT-SIDE FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════

if not IsDuplicityVersion() then
    
    -- Get Player Data
    function Framework.GetPlayerData()
        if not Framework.Ready then return nil end
        
        if Framework.Type == 'lxrcore' or Framework.Type == 'rsg-core' or Framework.Type == 'qbr-core' or Framework.Type == 'qr-core' then
            return Framework.Core.Functions.GetPlayerData()
        elseif Framework.Type == 'vorp' then
            local playerData = {}
            TriggerEvent('vorp:getCharacter', function(user)
                if user then
                    playerData.firstname = user.firstname
                    playerData.lastname = user.lastname
                    playerData.job = user.job
                    playerData.money = user.money
                    playerData.gold = user.gold
                end
            end)
            return playerData
        elseif Framework.Type == 'redemrp' then
            return Framework.Core.GetPlayer()
        elseif Framework.Type == 'standalone' then
            return {
                identifier = GetPlayerServerId(PlayerId()),
                name = GetPlayerName(PlayerId())
            }
        end
        
        return nil
    end
    
    -- Send Notification to Player
    function Framework.Notify(message, type, duration)
        type = type or 'primary'
        duration = duration or 5000
        
        if Framework.Type == 'lxrcore' then
            Framework.Core.Functions.Notify(message, type, duration)
        elseif Framework.Type == 'rsg-core' then
            Framework.Core.Functions.Notify(message, type, duration)
        elseif Framework.Type == 'qbr-core' or Framework.Type == 'qr-core' then
            Framework.Core.Functions.Notify(message, type, duration)
        elseif Framework.Type == 'vorp' then
            TriggerEvent('vorp:TipBottom', message, duration)
        elseif Framework.Type == 'redemrp' then
            TriggerEvent('redemrp_notification:start', message, duration / 1000, type)
        elseif Framework.Type == 'standalone' then
            -- Native RedM notification
            local str = CreateVarString(10, "LITERAL_STRING", message)
            local notifType = 'PLAYER_MENU'
            local duration_ms = duration
            TriggerEvent('chat:addMessage', {
                args = { message }
            })
        end
    end
    
    -- Get Player Job
    function Framework.GetJob()
        if not Framework.Ready then return nil end
        
        local playerData = Framework.GetPlayerData()
        if not playerData then return nil end
        
        if Framework.Type == 'lxrcore' or Framework.Type == 'rsg-core' or Framework.Type == 'qbr-core' or Framework.Type == 'qr-core' then
            return playerData.job
        elseif Framework.Type == 'vorp' then
            return playerData.job or 'unemployed'
        elseif Framework.Type == 'redemrp' then
            return playerData.getJob() or 'unemployed'
        elseif Framework.Type == 'standalone' then
            return 'unemployed'
        end
        
        return nil
    end
    
    -- Check if Player Has Item
    function Framework.HasItem(item, amount)
        amount = amount or 1
        
        if Framework.Type == 'lxrcore' or Framework.Type == 'rsg-core' or Framework.Type == 'qbr-core' or Framework.Type == 'qr-core' then
            local hasItem = Framework.Core.Functions.HasItem(item, amount)
            return hasItem ~= nil and hasItem
        elseif Framework.Type == 'vorp' then
            local result = false
            TriggerServerEvent('lxr-bounty-quests:server:checkItem', item, amount)
            return result
        elseif Framework.Type == 'redemrp' then
            return Framework.Core.Inventory.getItemCount(item) >= amount
        elseif Framework.Type == 'standalone' then
            -- For standalone, always return true or implement custom inventory check
            return true
        end
        
        return false
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- SERVER-SIDE FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════

if IsDuplicityVersion() then
    
    -- Get Player Object by Source
    function Framework.GetPlayer(source)
        if not Framework.Ready then return nil end
        
        if Framework.Type == 'lxrcore' or Framework.Type == 'rsg-core' or Framework.Type == 'qbr-core' or Framework.Type == 'qr-core' then
            return Framework.Core.Functions.GetPlayer(source)
        elseif Framework.Type == 'vorp' then
            return Framework.Core.getUser(source)
        elseif Framework.Type == 'redemrp' then
            return Framework.Core.GetPlayer(source)
        elseif Framework.Type == 'standalone' then
            return {
                source = source,
                identifier = GetPlayerIdentifier(source, 0),
                name = GetPlayerName(source)
            }
        end
        
        return nil
    end
    
    -- Get Player Identifier
    function Framework.GetIdentifier(source)
        if Framework.Type == 'lxrcore' or Framework.Type == 'rsg-core' or Framework.Type == 'qbr-core' or Framework.Type == 'qr-core' then
            local Player = Framework.GetPlayer(source)
            return Player and Player.PlayerData.citizenid or nil
        elseif Framework.Type == 'vorp' then
            local Player = Framework.GetPlayer(source)
            return Player and Player.getIdentifier() or nil
        elseif Framework.Type == 'redemrp' then
            local Player = Framework.GetPlayer(source)
            return Player and Player.getIdentifier() or nil
        elseif Framework.Type == 'standalone' then
            return GetPlayerIdentifier(source, 0)
        end
        
        return nil
    end
    
    -- Add Money to Player
    function Framework.AddMoney(source, moneyType, amount)
        if not Framework.Ready then return false end
        
        local Player = Framework.GetPlayer(source)
        if not Player then return false end
        
        if Framework.Type == 'lxrcore' or Framework.Type == 'rsg-core' or Framework.Type == 'qbr-core' or Framework.Type == 'qr-core' then
            return Player.Functions.AddMoney(moneyType, amount)
        elseif Framework.Type == 'vorp' then
            if moneyType == 'cash' then
                Player.addCurrency(0, amount)
                return true
            elseif moneyType == 'gold' then
                Player.addCurrency(1, amount)
                return true
            end
        elseif Framework.Type == 'redemrp' then
            if moneyType == 'cash' then
                Player.addMoney(amount)
                return true
            elseif moneyType == 'gold' then
                Player.addGold(amount)
                return true
            end
        elseif Framework.Type == 'standalone' then
            -- Standalone: Could integrate with custom banking or just log
            print(('[🐺 Bounty Quests] Added $%d %s to player %s'):format(amount, moneyType, source))
            return true
        end
        
        return false
    end
    
    -- Remove Money from Player
    function Framework.RemoveMoney(source, moneyType, amount)
        if not Framework.Ready then return false end
        
        local Player = Framework.GetPlayer(source)
        if not Player then return false end
        
        if Framework.Type == 'lxrcore' or Framework.Type == 'rsg-core' or Framework.Type == 'qbr-core' or Framework.Type == 'qr-core' then
            return Player.Functions.RemoveMoney(moneyType, amount)
        elseif Framework.Type == 'vorp' then
            if moneyType == 'cash' then
                Player.removeCurrency(0, amount)
                return true
            elseif moneyType == 'gold' then
                Player.removeCurrency(1, amount)
                return true
            end
        elseif Framework.Type == 'redemrp' then
            if moneyType == 'cash' then
                Player.removeMoney(amount)
                return true
            elseif moneyType == 'gold' then
                Player.removeGold(amount)
                return true
            end
        elseif Framework.Type == 'standalone' then
            print(('[🐺 Bounty Quests] Removed $%d %s from player %s'):format(amount, moneyType, source))
            return true
        end
        
        return false
    end
    
    -- Add Item to Player
    function Framework.AddItem(source, item, amount, metadata)
        if not Framework.Ready then return false end
        
        amount = amount or 1
        metadata = metadata or {}
        
        local Player = Framework.GetPlayer(source)
        if not Player then return false end
        
        if Framework.Type == 'lxrcore' or Framework.Type == 'rsg-core' or Framework.Type == 'qbr-core' or Framework.Type == 'qr-core' then
            return Player.Functions.AddItem(item, amount, false, metadata)
        elseif Framework.Type == 'vorp' then
            Player.addInventoryItem(item, amount, metadata)
            return true
        elseif Framework.Type == 'redemrp' then
            Player.addItem(item, amount)
            return true
        elseif Framework.Type == 'standalone' then
            print(('[🐺 Bounty Quests] Added %dx %s to player %s'):format(amount, item, source))
            return true
        end
        
        return false
    end
    
    -- Remove Item from Player
    function Framework.RemoveItem(source, item, amount)
        if not Framework.Ready then return false end
        
        amount = amount or 1
        
        local Player = Framework.GetPlayer(source)
        if not Player then return false end
        
        if Framework.Type == 'lxrcore' or Framework.Type == 'rsg-core' or Framework.Type == 'qbr-core' or Framework.Type == 'qr-core' then
            return Player.Functions.RemoveItem(item, amount)
        elseif Framework.Type == 'vorp' then
            Player.removeInventoryItem(item, amount)
            return true
        elseif Framework.Type == 'redemrp' then
            Player.removeItem(item, amount)
            return true
        elseif Framework.Type == 'standalone' then
            print(('[🐺 Bounty Quests] Removed %dx %s from player %s'):format(amount, item, source))
            return true
        end
        
        return false
    end
    
    -- Get Player Job
    function Framework.GetPlayerJob(source)
        if not Framework.Ready then return nil end
        
        local Player = Framework.GetPlayer(source)
        if not Player then return nil end
        
        if Framework.Type == 'lxrcore' or Framework.Type == 'rsg-core' or Framework.Type == 'qbr-core' or Framework.Type == 'qr-core' then
            return Player.PlayerData.job
        elseif Framework.Type == 'vorp' then
            local Character = Player.getUsedCharacter
            return Character and Character.job or 'unemployed'
        elseif Framework.Type == 'redemrp' then
            return Player.getJob() or 'unemployed'
        elseif Framework.Type == 'standalone' then
            return 'unemployed'
        end
        
        return nil
    end
    
    -- Check if Player Has Item
    function Framework.HasItem(source, item, amount)
        if not Framework.Ready then return false end
        
        amount = amount or 1
        
        local Player = Framework.GetPlayer(source)
        if not Player then return false end
        
        if Framework.Type == 'lxrcore' or Framework.Type == 'rsg-core' or Framework.Type == 'qbr-core' or Framework.Type == 'qr-core' then
            local itemData = Player.Functions.GetItemByName(item)
            return itemData and itemData.amount >= amount
        elseif Framework.Type == 'vorp' then
            local itemCount = Player.getInventoryItem(item)
            return itemCount and itemCount >= amount
        elseif Framework.Type == 'redemrp' then
            return Player.getItemCount(item) >= amount
        elseif Framework.Type == 'standalone' then
            return true
        end
        
        return false
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- AUTO-INITIALIZE ON LOAD
-- ═══════════════════════════════════════════════════════════════════════════════

CreateThread(function()
    Wait(500) -- Small delay to ensure config is loaded
    Framework.Initialize()
    
    if Config.EnableDebug then
        print('[🐺 Bounty Quests] Framework bridge initialized successfully')
    end
end)

return Framework
