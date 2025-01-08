shared_script '@flv-register/ai_module_fg-obfuscated.lua'
shared_script '@flv-register/shared_fg-obfuscated.lua'




fx_version 'adamant'
game 'gta5'

------
-- InteractSound by Scott
-- Verstion: v0.0.1
------

-- Manifest Version

-- Client Scripts
client_script 'client/main.lua'

-- Server Scripts
server_script 'server/main.lua'

-- NUI Default Page
ui_page 'client/html/index.html'

-- Files needed for NUI
-- DON'T FORGET TO ADD THE SOUND FILES TO THIS!
files {
    'client/html/index.html',
    -- Begin Sound Files Here...
    'client/html/sounds/*.ogg'
}




-- client_script '@vrp/client/allResources.lua'