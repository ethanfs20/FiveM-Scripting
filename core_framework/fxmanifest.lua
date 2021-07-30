-- ░░███╗░░███╗░░██╗███████╗░░███╗░░███╗░░██╗░░███╗░░███████╗██╗░░░██╗░░░██╗░██╗░███████╗░█████╗░░░██╗██╗░█████╗░
-- ░████║░░████╗░██║██╔════╝░████║░░████╗░██║░████║░░╚════██║╚██╗░██╔╝██████████╗██╔════╝██╔═══╝░░██╔╝██║██╔═══╝░
-- ██╔██║░░██╔██╗██║█████╗░░██╔██║░░██╔██╗██║██╔██║░░░░░░██╔╝░╚████╔╝░╚═██╔═██╔═╝██████╗░██████╗░██╔╝░██║██████╗░
-- ╚═╝██║░░██║╚████║██╔══╝░░╚═╝██║░░██║╚████║╚═╝██║░░░░░██╔╝░░░╚██╔╝░░██████████╗╚════██╗██╔══██╗███████║██╔══██╗
-- ███████╗██║░╚███║██║░░░░░███████╗██║░╚███║███████╗░░██╔╝░░░░░██║░░░╚██╔═██╔══╝██████╔╝╚█████╔╝╚════██║╚█████╔╝
-- ╚══════╝╚═╝░░╚══╝╚═╝░░░░░╚══════╝╚═╝░░╚══╝╚══════╝░░╚═╝░░░░░░╚═╝░░░░╚═╝░╚═╝░░░╚═════╝░░╚════╝░░░░░░╚═╝░╚════╝░

-- █▀▀ █▀█ █▀█ █▄█ █▀█ █ █▀▀ █░█ ▀█▀     ▄█ █▄░█ █▀▀ ▄█ █▄░█ ▄█ ▀▀█ █▄█
-- █▄▄ █▄█ █▀▀ ░█░ █▀▄ █ █▄█ █▀█ ░█░     ░█ █░▀█ █▀░ ░█ █░▀█ ░█ ░░█ ░█░

-- https://discord.gg/CPxWHD8WM6 | Project X Discord
-- https://discord.gg/wMD6Ed2szp | 1NF1N17Y Development

-- Resource Metadata
fx_version 'bodacious'
games {'gta5'}

author '1NFIN17Y#5646'
description 'Project X | Core Framework.'
version '2.0.0'

dependencies {}

client_scripts {
	'config/config.lua',
	'client/modules/spawnmanager.lua',
	'client/modules/notifications.lua',
	'client/threads.lua',
	'client/functions.lua',
	'client/events.lua'
}

server_scripts {
	'config/config.lua',
	'server/modules/commands.lua',
	'server/modules/database.lua',
	'server/events.lua',
	'server/functions.lua'
}

exports {
	'GetPlayers',
	'GetClosestPlayer',
	'GetVehicleAheadOfPlayer',
	'GetClosestVehicleDoor',
	'RequestNetworkControl',
	'GiveLoadout',
	'NoPlayerNear',
	'NoPerms',
	'TerminatedMessage',
	'GetPedInFront',
	'PlayAnimation',
	'NoPlayerNear',
	'NoPerms',
	'TerminatedMessage',
	'NotInService',
	'VehicleWhitelist',
	'CustomMessage',
	'NotInService'
}

server_exports {
	'GetPlayerIdentifierFromType',
	'NoPerms'
}
