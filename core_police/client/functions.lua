function blipenable()
	for _, info in pairs(coords) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, 60)
		SetBlipAsShortRange(info.blip, true)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 1.0)
		SetBlipColour(info.blip, 3)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Police Department")
		EndTextCommandSetBlipName(info.blip)
	end
	return
end

function ServiceOn()
	if terminated then
		exports.core_framework:TerminatedMessage()
	else
		ExecuteCommand("e notepad")
		TriggerServerEvent("police:takeService")
		TriggerEvent("jnj:setduty", true)
		TriggerEvent("toolbox:setduty", true)
		onduty = true
	end
	return
end

function GetActive()
	return allServiceCops
end

function ServiceOff()
	if onduty then
		if terminated then
			exports.core_framework:TerminatedMessage()
		else
			TriggerServerEvent("police:breakService")
			TriggerEvent("toolbox:setduty", false)
			TriggerEvent("jnj:setduty", false)
			allServiceCops = {}
			onduty = false
			for k, existingBlip in pairs(blipsCops) do
				RemoveBlip(existingBlip)
			end
			blipsCops = {}
			DoScreenFadeOut(500)
			Citizen.Wait(750)
			TriggerServerEvent("framework:getSkin")
			Citizen.Wait(750)
			DoScreenFadeIn(1000)
		end
	else
		exports.core_framework:NotInService()
	end
	return
end

function ToggleCuff()
	if onduty then
		if terminated then
			exports.core_framework:TerminatedMessage()
		else
			local player = PlayerPedId()
			local data = exports.core_framework:GetClosestPlayer()
			if (data.distance ~= -1 and data.distance < 3) then
				TriggerServerEvent("police:cuffGranted", GetPlayerServerId(data.t))
				arrest()
			else
				exports.core_framework:NoPlayerNear()
			end
		end
	else
		exports.core_framework:NotInService()
	end
	return
end

function arrest()
	if onduty then
		if terminated then
			exports.core_framework:TerminatedMessage()
		else
			local player = PlayerPedId()
			if not suspectCuffed then
				-- local adict = "mp_arrest_paired"
				-- local anim = "cop_p2_back_left"
				-- RequestAnimDict(adict)
				-- while not HasAnimDictLoaded(adict) do
				-- 	Citizen.Wait(0)
				-- end
				-- TaskPlayAnim(player, adict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
				suspectCuffed = true
			else
				local adict = "mp_arresting"
				local anim = "a_uncuff"
				RequestAnimDict(adict)
				while not HasAnimDictLoaded(adict) do
					Citizen.Wait(0)
				end
				TaskPlayAnim(player, adict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
				suspectCuffed = false
			end
		end
	else
		exports.core_framework:NotInService()
	end
	return
end

function PutInVehicle()
	if onduty then
		if terminated then
			exports.core_framework:TerminatedMessage()
		else
			local data = exports.core_framework:GetClosestPlayer()
			if (data.distance ~= -1 and data.distance < 3) then
				local v = GetVehiclePedIsIn(PlayerPedId(), true)
				TriggerServerEvent("police:forceEnterAsk", GetPlayerServerId(data.t), v)
			else
				exports.core_framework:NoPlayerNear()
			end
		end
	else
		exports.core_framework:NotInService()
	end
	return
end

RegisterNetEvent("police:UnseatVehicle")
AddEventHandler(
	"police:UnseatVehicle",
	function()
		UnseatVehicle()
	end
)

function UnseatVehicle()
	if onduty then
		if terminated then
			exports.core_framework:TerminatedMessage()
		else
			local data = exports.core_framework:GetClosestPlayer()
			if (data.distance ~= -1 and data.distance < 3) then
				TriggerServerEvent("police:confirmUnseat", GetPlayerServerId(data.t))
			else
				exports.core_framework:NoPlayerNear()
			end
		end
	else
		exports.core_framework:NotInService()
	end
	return
end

function DragPlayer()
	if onduty then
		if terminated then
			exports.core_framework:TerminatedMessage()
		else
			local data = exports.core_framework:GetClosestPlayer()
			if (data.distance ~= -1 and data.distance < 3) then
				TriggerServerEvent("police:dragRequest", GetPlayerServerId(data.t))
			else
				exports.core_framework:NoPlayerNear()
			end
		end
	else
		exports.core_framework:NotInService()
	end
	return
end

function unlockcar()
	if onduty then
		if terminated then
			exports.core_framework:TerminatedMessage()
		else
			local playerped = PlayerPedId()
			local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(playerped, 0.0, distanceToCheck, 0.0)
			local pos = GetEntityCoords(playerped)
			local vehicle = exports.core_framework:GetVehicleAheadOfPlayer(playerped)
			if (DoesEntityExist(vehicle)) then
				SetVehicleDoorOpen(vehicle, vals)
				TriggerEvent("framework:tnotify:alert", "success", "The door is unlocked.")
			else
				TriggerEvent("framework:tnotify:alert", "error", "You need to be near a vehicle!")
			end
		end
	else
		exports.core_framework:NotInService()
	end
	return
end

function enableCopBlips()
	if onduty then
		if terminated then
			exports.core_framework:TerminatedMessage()
		else
			for k, existingBlip in pairs(blipsCops) do
				RemoveBlip(existingBlip)
			end
			blipsCops = {}
			local localIdCops = {}
			for _, player in ipairs(GetActivePlayers()) do
				if (GetPlayerPed(player) ~= PlayerPedId()) then
					for i, c in pairs(allServiceCops) do
						if (i == GetPlayerServerId(player)) then
							localIdCops[player] = c
							break
						end
					end
				end
			end
			for id, c in pairs(localIdCops) do
				local ped = GetPlayerPed(id)
				local blip = GetBlipFromEntity(ped)
				if not DoesBlipExist(blip) then
					blip = AddBlipForEntity(ped)
					SetBlipSprite(blip, 1)
					Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true)
					HideNumberOnBlip(blip)
					SetBlipNameToPlayerName(blip, id)
					SetBlipScale(blip, 0.85)
					SetBlipAlpha(blip, 255)
					table.insert(blipsCops, blip)
				else
					blipSprite = GetBlipSprite(blip)
					HideNumberOnBlip(blip)
					if blipSprite ~= 1 then
						SetBlipSprite(blip, 1)
						Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true)
					end
					SetBlipNameToPlayerName(blip, id)
					SetBlipScale(blip, 0.85)
					SetBlipAlpha(blip, 255)
					table.insert(blipsCops, blip)
				end
			end
		end
	else
		exports.core_framework:NotInService()
	end
	return
end
