fx_version 'adamant'
games { 'gta5' }

description "hud faderp v1 - discord.gg/faderp"
author '@scamcheck'

ui_page "web/index.html"

files {
	'web/index.html',
	'web/style.css',
  'web/logo.png',
  'web/scripts.js',
}

client_scripts{"chud.lua"}
