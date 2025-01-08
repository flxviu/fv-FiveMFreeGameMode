



fx_version "bodacious"
games { 'gta5' }

author 'justgabri'

ui_page 'html/ui.html'

client_scripts {
  'lib/Tunnel.lua',
  'lib/Proxy.lua',
  'config.lua',
  'client/main.lua',
  'client/chest.lua',
  'client/shop.lua',
  'client/player.lua',
  'client/weapon.lua',
  'client/drops.lua',
  'client/backpack.lua'
}

server_scripts {
  '@vrp/lib/utils.lua',
  'config.lua',	
  'server/main.lua',
  'server/chest.lua',
  'server/shop.lua',
  'server/player.lua',
  'server/drops.lua',
  'server/backpack.lua',
  'server/weapon.lua'
}

files {
  'html/ui.html',
  'html/css/ui.css',
  'html/css/jquery-ui.css',
  'html/js/inventory.js',
  'html/cloth/*.svg',
  'html/js/config.js',
  'html/img/*.png'
}
server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }