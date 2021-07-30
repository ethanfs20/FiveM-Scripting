-- ████████╗██╗░░██╗██████╗░███████╗░█████╗░██████╗░░██████╗
-- ╚══██╔══╝██║░░██║██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝
-- ░░░██║░░░███████║██████╔╝█████╗░░███████║██║░░██║╚█████╗░
-- ░░░██║░░░██╔══██║██╔══██╗██╔══╝░░██╔══██║██║░░██║░╚═══██╗
-- ░░░██║░░░██║░░██║██║░░██║███████╗██║░░██║██████╔╝██████╔╝
-- ░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═════╝░╚═════╝░

local checked = false
local last = nil

-- This is a thread that give users xp
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(tonumber(Config['XPSYSTEM'].xplooptime))
			TriggerServerEvent('framework:setxploop')
		end
	end
)

-- Vehicle generators remover
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			RemoveVehiclesFromGeneratorsInArea(19901.55 - 50, 3770.48 - 50, 32.18 - 50, 1991.55 + 50, 3770.48 + 50, 32.18 + 50)
			local playerLoc = GetEntityCoords(PlayerPedId())
			ClearAreaOfCops(playerLoc.x, playerLoc.y, playerLoc.z, 400.0)
			FreezeEntityPosition(PlayerPedId(), false)
		end
	end
)

Citizen.CreateThread(
	function()
		local sleepThread = 0
		while true do
			Citizen.Wait(sleepThread)
			local player = PlayerPedId()
			local veh = GetVehiclePedIsIn(player, false)
			if IsPedInAnyVehicle(player, true) then
				if last ~= veh then
					sleepThread = 1000
					local hash = GetEntityModel(veh)
					local id = NetworkGetNetworkIdFromEntity(veh)
					if DoesEntityExist(veh) and IsEntityAVehicle(veh) and not IsEntityDead(veh) then
						TriggerServerEvent('framework:checkVehicle', {hash = hash, id = id})
						checked = true
						last = veh
					end
				else
					sleepThread = 10000
				end
			end
		end
	end
)

-- This was used to add vehicles by mass spawning them. Def a resource hog.
-- Citizen.CreateThread(
-- 	function()
-- 		while true do
-- 			Citizen.Wait(0)
-- 			local player = PlayerPedId()
-- 			local veh = GetVehiclePedIsIn(player, false)
-- 			local hash = GetHashKey(veh)
-- 			local class = GetVehicleClass(veh)
-- 			local name = GetDisplayNameFromVehicleModel(veh)
-- 			if IsPedInAnyVehicle(player, true) then
-- 				local hash = GetEntityModel(veh)
-- 				if DoesEntityExist(veh) and IsEntityAVehicle(veh) and not IsEntityDead(veh) then
-- 					TriggerServerEvent('framework:addvehicle', name, hash, class, 0)
-- 				end
-- 			end
-- 		end
-- 	end
-- )

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(Config['discord'].wait)
			SetDiscordAppId(Config['discord'].appid)
			SetDiscordRichPresenceAsset(Config['discord'].assetbig)
			SetDiscordRichPresenceAssetText(Config['discord'].bigtext)
			for _, v in pairs(Config.Buttons) do
				SetDiscordRichPresenceAction(v.index, v.name, v.url)
			end
			if StreetHash ~= nil then
				StreetName = GetStreetNameFromHashKey(StreetHash)
				if IsPedOnFoot(player) and not IsEntityInWater(player) then
					if IsPedSprinting(player) then
						SetRichPresence('Sprinting down ' .. StreetName)
					elseif IsPedRunning(player) then
						SetRichPresence('Running down ' .. StreetName)
					elseif IsPedWalking(player) then
						SetRichPresence('Walking down ' .. StreetName)
					elseif IsPedStill(player) then
						SetRichPresence('Standing on ' .. StreetName)
					end
				elseif
					GetVehiclePedIsUsing(player) ~= nil and not IsPedInAnyHeli(player) and not IsPedInAnyPlane(player) and
						not IsPedOnFoot(player) and
						not IsPedInAnySub(player) and
						not IsPedInAnyBoat(player)
				 then
					local VehSpeed = GetEntitySpeed(GetVehiclePedIsUsing(player))
					local CurSpeed = Config.UseKMH and math.ceil(VehSpeed * 3.6) or math.ceil(VehSpeed * 2.236936)
					local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(player))))
					if CurSpeed > 50 then
						SetRichPresence('Speeding down ' .. StreetName .. ' In a ' .. VehName)
					elseif CurSpeed <= 50 and CurSpeed > 0 then
						SetRichPresence('Cruising down ' .. StreetName .. ' In a ' .. VehName)
					elseif CurSpeed == 0 then
						SetRichPresence('Parked on ' .. StreetName .. ' In a ' .. VehName)
					end
				elseif IsPedInAnyHeli(player) or IsPedInAnyPlane(player) then
					local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(player))))
					if IsEntityInAir(GetVehiclePedIsUsing(player)) or GetEntityHeightAboveGround(GetVehiclePedIsUsing(player)) > 5.0 then
						SetRichPresence('Flying over ' .. StreetName .. ' in a ' .. VehName)
					else
						SetRichPresence('Landed at ' .. StreetName .. ' in a ' .. VehName)
					end
				elseif IsEntityInWater(player) then
					SetRichPresence('Swimming around')
				elseif IsPedInAnyBoat(player) and IsEntityInWater(GetVehiclePedIsUsing(player)) then
					local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(player))))
					SetRichPresence('Sailing around in a ' .. VehName)
				elseif IsPedInAnySub(player) and IsEntityInWater(GetVehiclePedIsUsing(player)) then
					SetRichPresence('In a yellow submarine')
				end
			end
		end
	end
)
