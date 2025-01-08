shared_script '@flv-register/ai_module_fg-obfuscated.js'
shared_script '@flv-register/ai_module_fg-obfuscated.lua'
shared_script '@flv-register/shared_fg-obfuscated.lua'
-- This resource is part of the default Cfx.re asset pack (cfx-server-data)
-- Altering or recreating for local use only is strongly discouraged.

version '1.0.0'
author 'Cfx.re <root@cfx.re>'
description 'Builds resources with yarn. To learn more: https://classic.yarnpkg.com'
repository 'https://github.com/citizenfx/cfx-server-data'

fx_version 'adamant'
game 'common'

server_script 'yarn_builder.js'

client_scripts{
    "txtui/textui.lua",
  }
  

ui_page "html/index.html"

files {
	'html/index.html',
	'html/css/*.css',
	'html/fonts/*.TTF',
	'html/fonts/*.*',
	'html/sound/*.*',
	'html/images/**/*.png',
	'html/images/**/**/*.png',
	'html/js/*.js',
	'html/js/**/*.js',
	'html/images/**/*.png',
	'html/pages/**/*.js',
	'html/pages/**/*.html',
}


export 'OpenTextUI'
export 'CloseTextUI'
