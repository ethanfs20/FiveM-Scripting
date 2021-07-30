local tries = 0
function CPR()
	if onduty then
		if terminated then
			exports.core_framework:TerminatedMessage()
		else
			local player = PlayerPedId()
			local data = exports.core_framework:GetClosestPlayer()
			local distance = data.distance
			local closest = data.t
			if (distance ~= -1 and distance < 3) then
				if IsPedDeadOrDying(GetPlayerPed(closest)) then
					if tries < 10 then
						local closestID = GetPlayerServerId(closest)
						local chance = math.random(0, 100)
						loadAnimDict("mini@cpr@char_a@cpr_str")
						loadAnimDict("mini@cpr@char_a@cpr_def")
						TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_def", "cpr_intro", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
						Citizen.Wait(2000)
						TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_str", "cpr_pumpchest", 8.0, 1.0, -1, 9, 0, 0, 0, 0)
						Citizen.Wait(7000)
						TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_def", "cpr_success", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
						tries = tries + 1
						if chance <= 25 then
							TriggerServerEvent("reviveServer", closestID)
							exports.pNotify:SendNotification(
								{text = "You successfully revived " .. GetPlayerName(closest), type = "success", timeout = 1000}
							)
						else
							exports.pNotify:SendNotification(
								{text = "You failed to revived " .. GetPlayerName(closest) .. " try again!", type = "error", timeout = 1000}
							)
						end
					else
						exports.pNotify:SendNotification(
							{text = "You are too weak to do anymore CPR, REST!", type = "error", timeout = 1000}
						)
						Citizen.Wait(2 * 60000)
						tries = 0
						exports.pNotify:SendNotification(
							{text = "Your energy has reset. You are now able to do CPR again!", type = "info", timeout = 1000}
						)
					end
				else
					exports.pNotify:SendNotification(
						{text = GetPlayerName(closest) .. " doesn't need CPR!", type = "error", timeout = 1000}
					)
				end
			else
				exports.core_framework:NoPlayerNear()
			end
		end
	else
		exports.core_framework:NotInService()
	end
end

function healplayer()
	if onduty then
		if terminated then
			exports.core_framework:TerminatedMessage()
		else
			local data = exports.core_framework:GetClosestPlayer()
			local distance = data.distance
			local closest = data.t
			if (distance ~= -1 and distance < 3) then
				exports.pNotify:SendNotification({text = "You successfully healed: " .. tname, type = "success", timeout = 1000})
				SetEntityHealth(ped, 200)
			else
				exports.core_framework:NoPlayerNear()
			end
		end
	else
		exports.core_framework:NotInService()
	end
	return
end

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