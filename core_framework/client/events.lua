-- ███████╗██╗░░░██╗███████╗███╗░░██╗████████╗░██████╗
-- ██╔════╝██║░░░██║██╔════╝████╗░██║╚══██╔══╝██╔════╝
-- █████╗░░╚██╗░██╔╝█████╗░░██╔██╗██║░░░██║░░░╚█████╗░
-- ██╔══╝░░░╚████╔╝░██╔══╝░░██║╚████║░░░██║░░░░╚═══██╗
-- ███████╗░░╚██╔╝░░███████╗██║░╚███║░░░██║░░░██████╔╝
-- ╚══════╝░░░╚═╝░░░╚══════╝╚═╝░░╚══╝░░░╚═╝░░░╚═════╝░

RegisterNetEvent('framework:getdelveh')
RegisterNetEvent('framework:recieveRequest')
RegisterNetEvent('framework:setCoords')

local fadeTime = 1000
local muted = false

AddEventHandler(
	'framework:getdelveh',
	function()
		local player = PlayerPedId()
		local veh = nil
		if IsPedInAnyVehicle(player, false) then
			veh = GetVehiclePedIsIn(player, false)
			if (GetPedInVehicleSeat(veh, -1) == player) then
				local id = NetworkGetNetworkIdFromEntity(veh)
				TriggerServerEvent('framework:dvserver', id)
			else
				CustomMessage('Get in driver seat')
			end
		else
			veh = GetVehicleAheadOfPlayer(player)
			if veh ~= 0 then
				local id = NetworkGetNetworkIdFromEntity(veh)
				TriggerServerEvent('framework:dvserver', id)
			else
				CustomMessage(Config['CommonStrings'].novehnear)
			end
		end
	end
)

AddEventHandler(
	'framework:recieveRequest',
	function(requestData)
		CustomMessage(
			'Teleport request from ' ..
				requestData.name ..
					' [' .. requestData.id .. '] (/tpaccept ' .. requestData.id .. ') (' .. requestData.requestTimeout .. ' seconds)'
		)
	end
)

AddEventHandler(
	'framework:setCoords',
	function(coords)
		Citizen.CreateThread(
			function()
				local playerPed = PlayerPedId()
				DoScreenFadeOut(fadeTime)
				Citizen.Wait(fadeTime)
				SetEntityCoords(playerPed, coords.x, coords.y, coords.z, false, false, false, false)
				CustomMessage('You were teleported.')
				DoScreenFadeIn(fadeTime)
			end
		)
	end
)