fx_version 'cerulean'
game 'gta5'
author '_elvano'
lua54 'yes'

shared_scripts {
    "config.lua",
    "@ox_lib/init.lua",
}

client_scripts {
    "client.lua"
}

server_scripts {
    "server.lua",
}

escrow_ignore {
    'config.lua',
}

dependencies {
    "illenium-appearance",
}