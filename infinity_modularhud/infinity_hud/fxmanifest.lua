-- ░░███╗░░███╗░░██╗███████╗░░███╗░░███╗░░██╗░░███╗░░███████╗██╗░░░██╗░░░██╗░██╗░███████╗░█████╗░░░██╗██╗░█████╗░
-- ░████║░░████╗░██║██╔════╝░████║░░████╗░██║░████║░░╚════██║╚██╗░██╔╝██████████╗██╔════╝██╔═══╝░░██╔╝██║██╔═══╝░
-- ██╔██║░░██╔██╗██║█████╗░░██╔██║░░██╔██╗██║██╔██║░░░░░░██╔╝░╚████╔╝░╚═██╔═██╔═╝██████╗░██████╗░██╔╝░██║██████╗░
-- ╚═╝██║░░██║╚████║██╔══╝░░╚═╝██║░░██║╚████║╚═╝██║░░░░░██╔╝░░░╚██╔╝░░██████████╗╚════██╗██╔══██╗███████║██╔══██╗
-- ███████╗██║░╚███║██║░░░░░███████╗██║░╚███║███████╗░░██╔╝░░░░░██║░░░╚██╔═██╔══╝██████╔╝╚█████╔╝╚════██║╚█████╔╝
-- ╚══════╝╚═╝░░╚══╝╚═╝░░░░░╚══════╝╚═╝░░╚══╝╚══════╝░░╚═╝░░░░░░╚═╝░░░░╚═╝░╚═╝░░░╚═════╝░░╚════╝░░░░░░╚═╝░╚════╝░

-- █▀▄▀█ █▀█ █▀▄ █░█ █░░ ▄▀█ █▀█   █░█ █░█ █▀▄
-- █░▀░█ █▄█ █▄▀ █▄█ █▄▄ █▀█ █▀▄   █▀█ █▄█ █▄▀

-- Need assistance? Need a script made? Join here. https://discord.gg/wMD6Ed2szp

fx_version 'cerulean'
game 'gta5'
version '1.5.0'
author '1NF1N17Y#5646'
description '1NF1N17Y Development | Modular Hud'

ui_page 'html/ui.html'

client_scripts {
    'shared/config.lua',
    'client/cl_main.lua'
}

server_scripts {
    'shared/config.lua',
    'server/sv_main.lua'
}

files {
    'html/ui.html',
    'html/style.css',
    'html/main.js',
    'html/img/*.png'
}

exports {
    'ToggleDisp',
    'HealthEdit',
    'ArmorEdit',
    'FuelEdit',
    'SeatBeltEdit'
}
