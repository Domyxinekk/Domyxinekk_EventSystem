fx_version 'cerulean'
game 'gta5'

author 'Domyxinekk'
description 'eventsystem by Domyxinekk'

lua54 'yes'

client_scripts {
    '@ox_lib/init.lua',
    'client.lua',
}

server_scripts {
    'server.lua',
}

dependencies {
    'ox_lib',
}

shared_script 'config.lua'


