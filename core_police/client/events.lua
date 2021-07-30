RegisterNetEvent("police:resultAllCopsInService")
RegisterNetEvent("police:forcedEnteringVeh")
RegisterNetEvent("police:setperms")
RegisterNetEvent("police:forceduty")
RegisterNetEvent("police:getArrested")
RegisterNetEvent("police:CheckWeapons")
RegisterNetEvent("police:unseatme")
RegisterNetEvent("police:toggleDrag")
RegisterNetEvent("police:unlockcar")
RegisterNetEvent("police:DragPlayer")
RegisterNetEvent("police:PutInVehicle")
RegisterNetEvent("police:ToggleCuff")
RegisterNetEvent("police:ServiceOff")
RegisterNetEvent("police:ServiceOn")

AddEventHandler(
	"onClientMapStart",
	function()
		blipenable()
	end
)

AddEventHandler(
	"police:forceduty",
	function()
		if terminated then
			terminated = false
			return
		else
			ServiceOff()
			terminated = true
			duty = false
			exports.core_framework:TerminatedMessage()
		end
		return
	end
)

AddEventHandler(
	"police:resultAllCopsInService",
	function(array)
		allServiceCops = array
		enableCopBlips()
		duty = true
		return
	end
)

AddEventHandler(
	"police:ServiceOn",
	function()
		ServiceOn()
	end
)

AddEventHandler(
	"police:ServiceOff",
	function()
		ServiceOff()
	end
)

AddEventHandler(
	"police:ToggleCuff",
	function()
		ToggleCuff()
	end
)

AddEventHandler(
	"police:PutInVehicle",
	function()
		PutInVehicle()
	end
)

AddEventHandler(
	"police:DragPlayer",
	function()
		DragPlayer()
	end
)

AddEventHandler(
	"police:unlockcar",
	function()
		unlockcar()
	end
)

local prevMaleVariation = 0
local prevFemaleVariation = 0

AddEventHandler(
	"police:getArrested",
	function()
		local playerped = PlayerPedId()
		if (handCuffed) then
			if GetEntityModel(playerped) == femaleHash then -- mp female
				SetPedComponentVariation(playerped, 7, prevFemaleVariation, 0, 0)
			elseif GetEntityModel(playerped) == maleHash then -- mp male
				SetPedComponentVariation(playerped, 7, prevMaleVariation, 0, 0)
			end
			local adict = "mp_arresting"
			local anim = "b_uncuff"
			RequestAnimDict(adict)
			while not HasAnimDictLoaded(adict) do
				Citizen.Wait(0)
			end
			TaskPlayAnim(playerped, adict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
			handCuffed = not handCuffed
			ClearPedTasks(playerped)
		else
			if GetEntityModel(playerped) == femaleHash then -- mp female
				prevFemaleVariation = GetPedDrawableVariation(playerped, 7)
				SetPedComponentVariation(playerped, 7, 25, 0, 0)
			elseif GetEntityModel(playerped) == maleHash then -- mp male
				prevMaleVariation = GetPedDrawableVariation(playerped, 7)
				SetPedComponentVariation(playerped, 7, 41, 0, 0)
			end
			-- local adict = "mp_arrest_paired"
			-- local anim = "crook_p2_back_left"
			-- RequestAnimDict(adict)k
			-- while not HasAnimDictLoaded(adict) do
				-- Citizen.Wait(0)
			-- end
			-- TaskPlayAnim(playerped, adict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
			drag = false
			handCuffed = not handCuffed
		end
	end
)

AddEventHandler(
	"police:CheckWeapons",
	function(t)
		local player = GetPlayerFromServerId(t)
		local playerped = GetPlayerPed(player)
		local weapons = config.weapons
		for k, v in pairs(weapons) do
			if HasPedGotWeapon(playerped, k) then
				TriggerServerEvent("police:wepnotes", v)
			end
		end
		RemoveAllPedWeapons(playerped)
		return
	end
)

AddEventHandler(
	"police:unseatme",
	function(t)
		local playerped = PlayerPedId()
		ClearPedTasksImmediately(ped)
		plyPos = GetEntityCoords(playerped, true)
		local xnew = plyPos.x + 2
		local ynew = plyPos.y + 2

		SetEntityCoords(playerped, xnew, ynew, plyPos.z)
		Citizen.Wait(500)
		return
	end
)

AddEventHandler(
	"police:toggleDrag",
	function(t)
		if (handCuffed) then
			drag = not drag
			officerDrag = t
		end
		return
	end
)

AddEventHandler(
	"police:forcedEnteringVeh",
	function(veh)
		local playerped = PlayerPedId()
		if (handCuffed) then
			Citizen.Wait(500)
			local pos = GetEntityCoords(playerped)
			local entityWorld = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 20.0, 0.0)
			local rayHandle =
				CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, playerped, 0)
			local _,
				_,
				_,
				_,
				vehicleHandle = GetRaycastResult(rayHandle)
			if vehicleHandle ~= nil then
				if (IsVehicleSeatFree(vehicleHandle, 1)) then
					SetPedIntoVehicle(playerped, vehicleHandle, 1)
					return
				else
					if (IsVehicleSeatFree(vehicleHandle, 2)) then
						SetPedIntoVehicle(playerped, vehicleHandle, 2)
					end
					return
				end
			end
		end
		return
	end
)

AddEventHandler(
	"police:setperms",
	function()
		print("test")
		permissions = true
	end
)
