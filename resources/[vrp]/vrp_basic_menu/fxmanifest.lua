fx_version 'adamant'
game 'gta5'
client_scripts {
  "client/Tunnel.lua",
  "client/Proxy.lua",
  "client.lua",
  "playerblips/client.lua",
  "customscripts/client.lua",
  "cfg/commands.lua",
  "jobs/client/*.lua",
  "tptowaypoint/client.lua",
  "taxi/cl_taxi.lua",
  "biz/client.lua",
  "drag/client.lua"
}
server_scripts {
  "@vrp/lib/utils.lua",
  "customscripts/server.lua",
  "taxi/sv_taxi.lua",
  "jobs/server/*.lua",
  "server.lua"
}