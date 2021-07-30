RegisterNetEvent('identity:start')
RegisterNetEvent('identity:init')

local display = false
local wait = false
local charinfo = {}

--very important cb
RegisterNUICallback(
    'exit',
    function(data)
        print('test')
        SetDisplay(false)
    end
)

AddEventHandler(
    'identity:start',
    function(ppdata)
        print('Starting Identity Menu')
        SetDisplay(not display)
    end
)

AddEventHandler(
    'identity:init',
    function(data)
        charinfo = data
        SendNUIMessage(
            {
                type = 'update',
                firstname = charinfo[1].firstname,
                lastname = charinfo[1].lastname,
                sex = charinfo[1].sex,
                dateofbirth = charinfo[1].dateofbirth,
                height = charinfo[1].height,
                weight = charinfo[1].weight
            }
        )
    end
)

RegisterNUICallback(
    'main',
    function(data)
        SetDisplay(false)
        TriggerServerEvent('framework:saveIdentity', data)
        print('Finished Identity Menu')
    end
)

RegisterNUICallback(
    'error',
    function(data)
        exports.core_framework:CustomMessage(data.error)
        Citizen.Wait(500)
        SetDisplay(true)
    end
)

RegisterNUICallback(
    'vehreg',
    function(data)
        if not wait then
            local player = PlayerPedId()
            if GetVehiclePedIsIn(player, false) then
                local veh = GetVehiclePedIsIn(player, false)
                local hash = GetHashKey(veh)
                local class = GetVehicleClass(veh)
                local name =
                    GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))))
                local data = {hash = hash, class = class, name = name}
                TriggerServerEvent('framework:registerveh', data)
                wait = true
                Citizen.Wait(5000)
                wait = false
            end
        end
    end
)

RegisterNUICallback(
    'vehdel',
    function(data)
    end
)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage(
        {
            type = 'ui',
            status = bool
        }
    )
end

Citizen.CreateThread(
    function()
        while display do
            Citizen.Wait(0)
            DisableControlAction(0, 1, display) -- LookLeftRight
            DisableControlAction(0, 2, display) -- LookUpDown
            DisableControlAction(0, 142, display) -- MeleeAttackAlternate
            DisableControlAction(0, 18, display) -- Enter
            DisableControlAction(0, 322, display) -- ESC
            DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
        end
        while true do
            Citizen.Wait(0)
            if IsControlPressed(0, 167) then
                SetDisplay(true)
            end
        end
    end
)
