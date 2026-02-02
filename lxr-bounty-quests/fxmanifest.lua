--[[
    🐺 Land of Wolves - Bounty Quests System
    © 2026 iBoss21 / The Lux Empire | wolves.land
]]

fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'iBoss21 / The Lux Empire'
description '🐺 Land of Wolves - Bounty Quests System 2.0 - Hunt down dangerous targets, complete quests, and earn legendary rewards'
version '2.0.0'

lua54 'yes'

shared_scripts {
    'config.lua',
    'locales/*.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua', -- If using oxmysql
    'server/*.lua',
}

dependencies {
    -- Framework dependencies (at least one required)
    -- 'lxr-core', -- Primary
    -- 'rsg-core', -- Primary
    -- 'qbr-core', -- QB-Core for RedM
    -- 'qr-core', -- QR Core
    -- 'vorp_core', -- VORP
    -- 'redem_roleplay', -- RedEM:RP
    
    -- Optional but recommended
    -- 'oxmysql', -- or 'ghmattimysql' or 'mysql-async'
}

files {}

-- Resource Information
metadata {
    ['server'] = 'The Land of Wolves 🐺',
    ['tagline'] = 'Georgian RP 🇬🇪 | მგლების მიწა',
    ['website'] = 'https://www.wolves.land',
    ['discord'] = 'https://discord.gg/CrKcWdfd3A',
    ['github'] = 'https://github.com/iBoss21',
    ['store'] = 'https://theluxempire.tebex.io',
}

-- Escrow protection (if you plan to sell)
-- escrow_ignore {
--     'config.lua',
--     'locales/*.lua',
--     'README.md',
-- }
