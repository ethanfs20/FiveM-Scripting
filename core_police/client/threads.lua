Citizen.CreateThread(
	function()
		local playerped = PlayerPedId()
		while true do
			Citizen.Wait(0)
			if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@mugging3", "handsup_standing_base", 3) then
				DisableControlAction(1, 140, true)
				DisableControlAction(1, 141, true)
				DisableControlAction(1, 142, true)
				if IsPedInAnyVehicle(GetPlayerPed(PlayerId()), false) then
					DisableControlAction(0, 59, true)
				end
			end
			if drag then
				local ped = GetPlayerPed(GetPlayerFromServerId(officerDrag))
				local myped = PlayerPedId()
				AttachEntityToEntity(myped, ped, 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				playerStillDragged = true
			else
				if (playerStillDragged) then
					DetachEntity(PlayerPedId(), true, false)
					playerStillDragged = false
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			if drag then
				local ped = GetPlayerPed(GetPlayerFromServerId(playerPedDragged))
				plyPos = GetEntityCoords(ped, true)
				SetEntityCoords(ped, plyPos.x, plyPos.y, plyPos.z)
			end
			Citizen.Wait(1000)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if handCuffed and not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "idle", 3) then
				TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
				DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
				DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
				DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
				DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
				DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
				DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
				DisableControlAction(0, 257, true) -- INPUT_ATTACK2
				DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
				DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
				DisableControlAction(0, 24, true) -- INPUT_ATTACK
				DisableControlAction(0, 25, true) -- INPUT_AIM
			end
		end
	end
)
