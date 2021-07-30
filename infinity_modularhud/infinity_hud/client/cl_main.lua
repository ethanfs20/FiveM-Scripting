-- ░█████╗░██╗░░░░░██╗███████╗███╗░░██╗████████╗
-- ██╔══██╗██║░░░░░██║██╔════╝████╗░██║╚══██╔══╝
-- ██║░░╚═╝██║░░░░░██║█████╗░░██╔██╗██║░░░██║░░░
-- ██║░░██╗██║░░░░░██║██╔══╝░░██║╚████║░░░██║░░░
-- ╚█████╔╝███████╗██║███████╗██║░╚███║░░░██║░░░
-- ░╚════╝░╚══════╝╚═╝╚══════╝╚═╝░░╚══╝░░░╚═╝░░░

RegisterNetEvent('hud:sethud')

local positions = {
    healthleft = 5.5,
    healthbottom = 29,
    armorleft = 3,
    armorbottom = 25,
    fuelleft = 2,
    fuelbottom = 20,
    seatbeltleft = 2,
    seatbeltbottom = 16
}

local fueledit = false
local armoredit = false
local seatbeltedit = false
local healthedit = false

local seatbelt = false
local healthstate = true
local armorstate = true

if not Config.DisableToggle then
    RegisterCommand(
        'healthtoggle',
        function()
            ToggleDisp('health')
        end
    )

    RegisterCommand(
        'armortoggle',
        function()
            ToggleDisp('armor')
        end
    )

    RegisterCommand(
        'reset',
        function()
            ToggleDisp('reset')
        end
    )

    RegisterCommand(
        'uiall',
        function()
            ToggleDisp('all')
        end
    )

    function ToggleDisp(case)
        if case == 'health' then
            SendNUIMessage(
                {
                    action = 'healthui'
                }
            )
        elseif case == 'armor' then
            SendNUIMessage(
                {
                    action = 'armorui'
                }
            )
        elseif case == 'reset' then
            SendNUIMessage(
                {
                    action = 'reset'
                }
            )
        elseif case == 'all' then
            SendNUIMessage(
                {
                    action = 'all'
                }
            )
        end
    end
end

if not Config.DisableSaving then
    RegisterCommand(
        'healthedit',
        function()
            HealthEdit()
        end
    )

    RegisterCommand(
        'armoredit',
        function()
            ArmorEdit()
        end
    )

    RegisterCommand(
        'fueledit',
        function()
            FuelEdit()
        end
    )

    RegisterCommand(
        'sbedit',
        function()
            SeatBeltEdit()
        end
    )

    RegisterCommand(
        'resetui',
        function()
            TriggerServerEvent('hud:save', true)
        end
    )

    AddEventHandler(
        'hud:sethud',
        function(data)
            positions = data
            SendNUIMessage(
                {
                    action = 'intialization',
                    healthleft = positions.healthleft,
                    healthbottom = positions.healthbottom,
                    armorleft = positions.armorleft,
                    armorbottom = positions.armorbottom,
                    fuelleft = positions.fuelleft,
                    fuelbottom = positions.fuelbottom,
                    seatbeltleft = positions.seatbeltleft,
                    seatbeltbottom = positions.seatbeltbottom
                }
            )
        end
    )
    function FuelEdit()
        if armoredit or healthedit == false then
            if fueledit then
                fueledit = false
                TriggerServerEvent('hud:save', false, positions)
            else
                fueledit = true
                fuelloop()
            end
        else
            TriggerEvent('framework:tnotify:alert', 'error', 'Finish editing the current element!')
        end
    end

    function ArmorEdit()
        if healthedit or fueledit == false then
            if armoredit then
                armoredit = false
                TriggerServerEvent('hud:save', false, positions)
            else
                armoredit = true
                armorloop()
            end
        else
            TriggerEvent('framework:tnotify:alert', 'error', 'Finish editing the current element!')
        end
    end

    function HealthEdit()
        if armoredit or fueledit == false then
            if healthedit then
                healthedit = false
                TriggerServerEvent('hud:save', false, positions)
            else
                healthedit = true
                healthloop()
            end
        else
            TriggerEvent('framework:tnotify:alert', 'error', 'Finish editing the current element!')
        end
    end

    function SeatBeltEdit()
        if armoredit or fueledit == false then
            if seatbeltedit then
                seatbeltedit = false
                TriggerServerEvent('hud:save', false, positions)
            else
                seatbeltedit = true
                seatbeltloop()
            end
        else
            TriggerEvent('framework:tnotify:alert', 'error', 'Finish editing the current element!')
        end
    end

    function armorloop()
        Citizen.CreateThread(
            function()
                while armoredit do
                    Citizen.Wait(0)
                    if IsControlPressed(0, 175) then
                        armorleft = positions.armorleft + 0.5
                        SendNUIMessage(
                            {
                                action = 'editarmor',
                                left = armorleft
                            }
                        )
                        positions.armorleft = armorleft
                    end
                    if IsControlPressed(0, 174) then
                        armorleft = positions.armorleft - 0.5
                        SendNUIMessage(
                            {
                                action = 'editarmor',
                                left = positions.armorleft
                            }
                        )
                        positions.armorleft = armorleft
                    end
                    if IsControlPressed(0, 172) then
                        armorbottom = positions.armorbottom + 0.5
                        SendNUIMessage(
                            {
                                action = 'editarmor',
                                bottom = armorbottom
                            }
                        )
                        positions.armorbottom = armorbottom
                    end
                    if IsControlPressed(0, 173) then
                        armorbottom = positions.armorbottom - 0.5
                        SendNUIMessage(
                            {
                                action = 'editarmor',
                                bottom = armorbottom
                            }
                        )
                        positions.armorbottom = armorbottom
                    end
                    if not armoredit then
                        break
                    end
                end
            end
        )
    end
    function healthloop()
        Citizen.CreateThread(
            function()
                while healthedit do
                    Citizen.Wait(0)
                    if IsControlPressed(0, 175) then
                        healthleft = positions.healthleft + 0.5
                        SendNUIMessage(
                            {
                                action = 'edithealth',
                                left = healthleft
                            }
                        )
                        positions.healthleft = healthleft
                    end
                    if IsControlPressed(0, 174) then
                        healthleft = positions.healthleft - 0.5
                        SendNUIMessage(
                            {
                                action = 'edithealth',
                                left = healthleft
                            }
                        )
                        positions.healthleft = healthleft
                    end
                    if IsControlPressed(0, 172) then
                        healthbottom = positions.healthbottom + 0.5
                        SendNUIMessage(
                            {
                                action = 'edithealth',
                                bottom = healthbottom
                            }
                        )
                        positions.healthbottom = healthbottom
                    end
                    if IsControlPressed(0, 173) then
                        healthbottom = positions.healthbottom - 0.5
                        SendNUIMessage(
                            {
                                action = 'edithealth',
                                bottom = healthbottom
                            }
                        )
                        positions.healthbottom = healthbottom
                    end
                    if not healthedit then
                        break
                    end
                end
            end
        )
    end

    function fuelloop()
        Citizen.CreateThread(
            function()
                while fueledit do
                    Citizen.Wait(0)
                    if IsControlPressed(0, 175) then
                        fuelleft = positions.fuelleft + 0.5
                        SendNUIMessage(
                            {
                                action = 'editfuel',
                                left = fuelleft
                            }
                        )
                        positions.fuelleft = fuelleft
                    end
                    if IsControlPressed(0, 174) then
                        fuelleft = positions.fuelleft - 0.5
                        SendNUIMessage(
                            {
                                action = 'editfuel',
                                left = fuelleft
                            }
                        )
                        positions.fuelleft = fuelleft
                    end
                    if IsControlPressed(0, 172) then
                        fuelbottom = positions.fuelbottom + 0.5
                        SendNUIMessage(
                            {
                                action = 'editfuel',
                                bottom = fuelbottom
                            }
                        )
                        positions.fuelbottom = fuelbottom
                    end
                    if IsControlPressed(0, 173) then
                        fuelbottom = positions.fuelbottom - 0.5
                        SendNUIMessage(
                            {
                                action = 'editfuel',
                                bottom = fuelbottom
                            }
                        )
                        positions.fuelbottom = fuelbottom
                    end
                    if not fueledit then
                        break
                    end
                end
            end
        )
    end

    function seatbeltloop()
        Citizen.CreateThread(
            function()
                while seatbeltedit do
                    Citizen.Wait(0)
                    if IsControlPressed(0, 175) then
                        seatbeltleft = positions.seatbeltleft + 0.5
                        SendNUIMessage(
                            {
                                action = 'editseatbelt',
                                left = seatbeltleft
                            }
                        )
                        positions.seatbeltleft = seatbeltleft
                    end
                    if IsControlPressed(0, 174) then
                        seatbeltleft = positions.seatbeltleft - 0.5
                        SendNUIMessage(
                            {
                                action = 'editseatbelt',
                                left = seatbeltleft
                            }
                        )
                        positions.seatbeltleft = seatbeltleft
                    end
                    if IsControlPressed(0, 172) then
                        seatbeltbottom = positions.seatbeltbottom + 0.5
                        SendNUIMessage(
                            {
                                action = 'editseatbelt',
                                bottom = seatbeltbottom
                            }
                        )
                        positions.seatbeltbottom = seatbeltbottom
                    end
                    if IsControlPressed(0, 173) then
                        seatbeltbottom = positions.seatbeltbottom - 0.5
                        SendNUIMessage(
                            {
                                action = 'editseatbelt',
                                bottom = seatbeltbottom
                            }
                        )
                        positions.seatbeltbottom = seatbeltbottom
                    end
                    if not seatbeltedit then
                        break
                    end
                end
            end
        )
    end
end

if Config.Seatbelt then
    Citizen.CreateThread(
        function()
            while true do
                local class = GetVehicleClass(GetVehiclePedIsIn(PlayerPedId()))
                Citizen.Wait(0)
                if IsPedInAnyVehicle(PlayerPedId(), false) then -- Checks to see if the players ped is in a vehicle. Changes the display state.
                    if IsControlJustReleased(0, Config.SeatbeltKey) and class ~= 8 then
                        seatbelt = not seatbelt
                    end
                end
            end
        end
    )
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            local player = PlayerPedId() -- The players model ID
            local vehicle = GetVehiclePedIsIn(player) -- This grabs the players vehicle using the PED ID.
            local class = GetVehicleClass(vehicle)
            if Config.LegacyFuel then
                fuel = exports.LegacyFuel:GetFuel(vehicle) -- Calls an exported function to get the fuel precentage.
            else
                fuel = exports.frfuelplus:getCurrentFuelLevel()
            end
            if IsEntityDead(GetPlayerPed(-1)) then
                health = 0
            else
                health = (GetEntityHealth(GetPlayerPed(-1)) - 100)
            end
            local armor = GetPedArmour(GetPlayerPed(-1))
            if not IsPedInAnyVehicle(player, false) then -- Checks to see if the players ped is in a vehicle. Changes the display state.
                SendNUIMessage(
                    {
                        action = 'fuelui',
                        showfuel = false
                    }
                )
                SendNUIMessage(
                    {
                        action = 'seatbeltui',
                        showseatbelt = false
                    }
                )
                seatbelt = false
            else
                SendNUIMessage(
                    {
                        action = 'fuelui',
                        showfuel = true
                    }
                )
                if seatbelt and class ~= 8 then
                    SendNUIMessage(
                        {
                            action = 'seatbeltui',
                            showseatbelt = false
                        }
                    )
                elseif class ~= 8 then
                    SendNUIMessage(
                        {
                            action = 'seatbeltui',
                            showseatbelt = true
                        }
                    )
                end
            end
            SendNUIMessage(
                {
                    action = 'update',
                    health = health,
                    armor = armor,
                    fuel = fuel
                }
            )
        end
    end
)
