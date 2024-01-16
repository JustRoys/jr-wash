fx_version "adamant"
game "rdr3"
lua54 "yes"

author 'JustRoy'
description 'This script is made by JustRoy and tested in Nieuw-Nederland RP'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_scripts {
    'config.lua',
}

client_scripts {
	'client/client.lua',
}

server_scripts {
	'server/server.lua',
}

dependency {
	"vorp_core",
	"vorp_inventory",
}
