-- ░░░░░░░░░░░░░░  ░░░░░██╗░█████╗░██████╗░  ██████╗░░█████╗░██╗░░░░░██╗░█████╗░███████╗  ░░░░░░░ ░░░░░░░
-- ██████╗██████╗  ░░░░░██║██╔══██╗██╔══██╗  ██╔══██╗██╔══██╗██║░░░░░██║██╔══██╗██╔════╝  ██████╗██████╗
-- ╚═════╝╚═════╝  ░░░░░██║██║░░██║██████╦╝  ██████╔╝██║░░██║██║░░░░░██║██║░░╚═╝█████╗░░  ╚═════╝╚═════╝
-- ██████╗██████╗  ██╗░░██║██║░░██║██╔══██╗  ██╔═══╝░██║░░██║██║░░░░░██║██║░░██╗██╔══╝░░  ██████╗██████╗
-- ╚═════╝╚═════╝  ╚█████╔╝╚█████╔╝██████╦╝  ██║░░░░░╚█████╔╝███████╗██║╚█████╔╝███████╗  ╚═════╝╚═════╝
-- ░░░░░░░░░░░░░░  ░╚════╝░░╚════╝░╚═════╝░  ╚═╝░░░░░░╚════╝░╚══════╝╚═╝░╚════╝░╚══════╝  ░░░░░░░░░░░░░░

fx_version "bodacious"
games {"gta5"}

author "1NFIN17Y#5646"
description "Project X | Job Fire/EMS."
version "1.0.0"

uniformFile = "outfits.json"
file(uniformFile)
uniform_file(uniformFile)

dependencies {
	"NativeUI",
	"core_framework",
	"pNotify"
}

client_scripts {
	"@NativeUI/NativeUI.lua",
	"client/variables.lua",
	"client/threads.lua",
	"client/menu.lua",
	"client/functions.lua",
	"client/events.lua",
	"config/config.lua"
}

exports {
	"CPR",
	"healplayer"
}
