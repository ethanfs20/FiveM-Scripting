-- ░░░░░░░░░░░░░░  ░░░░░██╗░█████╗░██████╗░  ██████╗░░█████╗░██╗░░░░░██╗░█████╗░███████╗  ░░░░░░░ ░░░░░░░
-- ██████╗██████╗  ░░░░░██║██╔══██╗██╔══██╗  ██╔══██╗██╔══██╗██║░░░░░██║██╔══██╗██╔════╝  ██████╗██████╗
-- ╚═════╝╚═════╝  ░░░░░██║██║░░██║██████╦╝  ██████╔╝██║░░██║██║░░░░░██║██║░░╚═╝█████╗░░  ╚═════╝╚═════╝
-- ██████╗██████╗  ██╗░░██║██║░░██║██╔══██╗  ██╔═══╝░██║░░██║██║░░░░░██║██║░░██╗██╔══╝░░  ██████╗██████╗
-- ╚═════╝╚═════╝  ╚█████╔╝╚█████╔╝██████╦╝  ██║░░░░░╚█████╔╝███████╗██║╚█████╔╝███████╗  ╚═════╝╚═════╝
-- ░░░░░░░░░░░░░░  ░╚════╝░░╚════╝░╚═════╝░  ╚═╝░░░░░░╚════╝░╚══════╝╚═╝░╚════╝░╚══════╝  ░░░░░░░░░░░░░░

fx_version 'bodacious'
games {'gta5'}

author '1NFIN17Y#5646'
description 'Project X | Job Police.'
version '1.0.0'

uniformFile = 'outfits.json'
file(uniformFile)
uniform_file(uniformFile)

dependencies {
    'NativeUI',
    'core_framework',
    'pNotify'
}

client_scripts {
    '@NativeUI/NativeUI.lua',
    'client/variables.lua',
    'client/threads.lua',
    'client/menu.lua',
    'client/functions.lua',
    'client/events.lua',
    'config/config.lua'
}

server_scripts {
    'config/config.lua',
    'server/variables.lua',
    'server/functions.lua',
    'server/events.lua',
    'server/commands.lua'
}

exports {
    'ServiceOn',
    'ServiceOff',
    'ToggleCuff',
    'RemoveWeapons',
    'PutInVehicle',
    'UnseatVehicle',
    'DragPlayer',
    'unlockcar',
    'RemoveSpikes',
    'SetPerms',
    'GetActive',
    'CreateSpikes'
}
