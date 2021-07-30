
-- ░░███╗░░███╗░░██╗███████╗██╗███╗░░██╗░░███╗░░███████╗██╗░░░██╗░░░██╗░██╗░███████╗░█████╗░░░██╗██╗░█████╗░
-- ░████║░░████╗░██║██╔════╝██║████╗░██║░████║░░╚════██║╚██╗░██╔╝██████████╗██╔════╝██╔═══╝░░██╔╝██║██╔═══╝░
-- ██╔██║░░██╔██╗██║█████╗░░██║██╔██╗██║██╔██║░░░░░░██╔╝░╚████╔╝░╚═██╔═██╔═╝██████╗░██████╗░██╔╝░██║██████╗░
-- ╚═╝██║░░██║╚████║██╔══╝░░██║██║╚████║╚═╝██║░░░░░██╔╝░░░╚██╔╝░░██████████╗╚════██╗██╔══██╗███████║██╔══██╗
-- ███████╗██║░╚███║██║░░░░░██║██║░╚███║███████╗░░██╔╝░░░░░██║░░░╚██╔═██╔══╝██████╔╝╚█████╔╝╚════██║╚█████╔╝
-- ╚══════╝╚═╝░░╚══╝╚═╝░░░░░╚═╝╚═╝░░╚══╝╚══════╝░░╚═╝░░░░░░╚═╝░░░░╚═╝░╚═╝░░░╚═════╝░░╚════╝░░░░░░╚═╝░╚════╝░


-- █▄▄ █▀█ █▀▄ █▄█ █▀▀ █░█ ▄▀█ █▀█ █▀▄   █▀▄▀█ █▀▀ █▄░█ █░█
-- █▄█ █▄█ █▄▀ ░█░ █▄█ █▄█ █▀█ █▀▄ █▄▀   █░▀░█ ██▄ █░▀█ █▄█

-- Need assistance? Need a script made? Join here. https://discord.gg/wMD6Ed2szp
-- I AM ALSO LOOKING FOR TEAM MEMBERS AND TESTERS IF YOU ARE INTERESTED JOIN THE DISCORD!!

-- Resource Metadata
fx_version "cerulean"
games {"gta5"}

author '1NF1N17Y#5646'
description '1NF1N17Y Development | Bodyguard Menu'
repository 'https://github.com/ethanol20'
version '2.0.0'

client_scripts { 
	"@NativeUI/NativeUI.lua",
	"client/main.lua",
	"client/global.lua",
	"config/config.lua"
}
server_scripts {
	"server/main.lua",
	"config/config.lua"
}	
