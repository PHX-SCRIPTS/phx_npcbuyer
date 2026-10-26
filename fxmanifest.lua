fx_version 'cerulean'
game 'gta5'
lua54 'yes'

dependencies { 'ox_lib', 'ox_inventory', 'ox_target' }

shared_scripts { '@ox_lib/init.lua', 'config.lua' }
client_script 'client.lua'
server_script 'server.lua'