-- ░█████╗░██╗░░░░░██╗███████╗███╗░░██╗████████╗
-- ██╔══██╗██║░░░░░██║██╔════╝████╗░██║╚══██╔══╝
-- ██║░░╚═╝██║░░░░░██║█████╗░░██╔██╗██║░░░██║░░░
-- ██║░░██╗██║░░░░░██║██╔══╝░░██║╚████║░░░██║░░░
-- ╚█████╔╝███████╗██║███████╗██║░╚███║░░░██║░░░
-- ░╚════╝░╚══════╝╚═╝╚══════╝╚═╝░░╚══╝░░░╚═╝░░░

RegisterNetEvent('mainmenu:openUI')
RegisterNetEvent('mainmenu:spawnPlayer')
RegisterNetEvent('mainmenu:getChar')

AddEventHandler(
    'mainmenu:openUI',
    function(Characters)
        ShutdownLoadingScreen()
        ShutdownLoadingScreenNui()
        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                action = 'senddata',
                characters = Characters,
                pinfo = '[' .. GetPlayerName(PlayerId()) .. '@PJX ~] ServerID [' .. GetPlayerServerId(PlayerId()) .. ']'
            }
        )
    end
)

RegisterNUICallback(
    'CharacterChosen',
    function(data)
        SetNuiFocus(false, false)
        TriggerServerEvent('framework:CharacterChosen', data.charid)
        TriggerServerEvent('framework:SinitPlayer')
    end
)

RegisterNUICallback(
    'DeleteCharacter',
    function(data)
        TriggerServerEvent('framework:DeleteCharacter', data.charid)
    end
)

RegisterNUICallback(
    'Disconnect',
    function()
        TriggerServerEvent('framework:DisconnectPlayer')
    end
)

RegisterNUICallback(
    'newidentity',
    function(data)
        SetNuiFocus(false, false)
        TriggerServerEvent('framework:saveNewIdentity', data)
    end
)

Citizen.CreateThread(
    function()
        TriggerServerEvent('framework:getchars')
        SendNUIMessage(
            {
                action = 'pinfo',
                pname = '[' .. GetPlayerName(PlayerId()) .. '@PJX ~]',
                sid = 'ServerID [' .. GetPlayerServerId(PlayerId()) .. ']'
            }
        )
    end
)
