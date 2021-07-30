-- ███████╗██╗░░░██╗███████╗███╗░░██╗████████╗░██████╗
-- ██╔════╝██║░░░██║██╔════╝████╗░██║╚══██╔══╝██╔════╝
-- █████╗░░╚██╗░██╔╝█████╗░░██╔██╗██║░░░██║░░░╚█████╗░
-- ██╔══╝░░░╚████╔╝░██╔══╝░░██║╚████║░░░██║░░░░╚═══██╗
-- ███████╗░░╚██╔╝░░███████╗██║░╚███║░░░██║░░░██████╔╝
-- ╚══════╝░░░╚═╝░░░╚══════╝╚═╝░░╚══╝░░░╚═╝░░░╚═════╝░

RegisterNetEvent("arm:RecieveItem")
AddEventHandler(
	"arm:RecieveItem",
	function(index)
		DoAction(index)
	end
)

-- ███████╗██╗░░░██╗███╗░░██╗░█████╗░████████╗██╗░█████╗░███╗░░██╗░██████╗
-- ██╔════╝██║░░░██║████╗░██║██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝
-- █████╗░░██║░░░██║██╔██╗██║██║░░╚═╝░░░██║░░░██║██║░░██║██╔██╗██║╚█████╗░
-- ██╔══╝░░██║░░░██║██║╚████║██║░░██╗░░░██║░░░██║██║░░██║██║╚████║░╚═══██╗
-- ██║░░░░░╚██████╔╝██║░╚███║╚█████╔╝░░░██║░░░██║╚█████╔╝██║░╚███║██████╔╝
-- ╚═╝░░░░░░╚═════╝░╚═╝░░╚══╝░╚════╝░░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░

function DoAction(index)
	local playerped = PlayerPedId()
	Citizen.CreateThread(
		function()
			if index == "give_item" then
				local distance = GetClosestPlayer()
				if (distance ~= -1 and distance < 3) then
					local one = GetPlayerServerId(GetClosestPlayer())
					TriggerServerEvent("arm:GiveItem", one, currentAction)
					ClearPedSecondaryTask(playerped)
					DetachEntity(NetToObj(obj_net), 1, 1)
					DeleteEntity(NetToObj(obj_net))
					obj_net = nil
					currentAction = "none"
					return
				else
					TriggerEvent("core:tnotify:alert", "error", "There is no player near you!")
					return
				end
			end
			if currentAction ~= "none" then
				ClearPedSecondaryTask(playerped)
				DetachEntity(NetToObj(obj_net), 1, 1)
				DeleteEntity(NetToObj(obj_net))
				obj_net = nil
				currentAction = "none"
			end
			RequestModel(GetHashKey(config.actions[index].animObjects.name))
			while not HasModelLoaded(GetHashKey(config.actions[index].animObjects.name)) do
				Citizen.Wait(100)
			end
			RequestAnimDict(config.actions[index].animDictionary)
			while not HasAnimDictLoaded(config.actions[index].animDictionary) do
				Citizen.Wait(100)
			end
			local plyCoords = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 0.0, -5.0)
			local objSpawned =
				CreateObject(GetHashKey(config.actions[index].animObjects.name), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
			Citizen.Wait(1000)
			local netid = ObjToNet(objSpawned)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			AttachEntityToEntity(
				objSpawned,
				playerped,
				GetPedBoneIndex(playerped, 28422),
				config.actions[index].animObjects.xoff,
				config.actions[index].animObjects.yoff,
				config.actions[index].animObjects.zoff,
				config.actions[index].animObjects.xrot,
				config.actions[index].animObjects.yrot,
				config.actions[index].animObjects.zrot,
				1,
				1,
				0,
				1,
				0,
				1
			)
			TaskPlayAnim(playerped, 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
			TaskPlayAnim(
				playerped,
				config.actions[index].animDictionary,
				config.actions[index].animationName,
				1.0,
				-1,
				-1,
				50,
				0,
				0,
				0,
				0
			)
			obj_net = netid
			currentAction = index
		end
	)
end

function ToggleHUK(toggle)
	local playerped = PlayerPedId()
	if (toggle) then
		RequestAnimDict("random")
		RequestAnimDict("random@getawaydriver")
		while not HasAnimDictLoaded("random@getawaydriver") do
			Citizen.Wait(100)
		end
		TaskPlayAnim(playerped, "random@getawaydriver", "idle_2_hands_up", 1.0, -1, -1, 0, 0, 0, 0, 0)
		Citizen.Wait(3500)
		TaskPlayAnim(playerped, "random@getawaydriver", "idle_a", 1.0, -1, -1, 1, 0, 0, 0, 0)
		SetEnableHandcuffs(playerped, true)
	else
		if
			IsEntityPlayingAnim(playerped, "random@getawaydriver", "idle_a", 3) and
				IsEntityPlayingAnim(playerped, "mp_arresting", "idle", 3)
		 then
			StopAnimTask(playerped, "random@getawaydriver", "idle_a", 3)
			StopAnimTask(playerped, "random@getawaydriver", "idle_2_hands_up", 3)
			TaskPlayAnim(playerped, "random@getawaydriver", "hands_up_2_idle", 1.0, -1, -1, 0, 0, 0, 0, 0)
			ClearPedSecondaryTask(playerped)
			TaskPlayAnim(playerped, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
			SetEnableHandcuffs(playerped, true)
		elseif IsEntityPlayingAnim(playerped, "random@getawaydriver", "idle_a", 3) then
			StopAnimTask(playerped, "random@getawaydriver", "idle_a", 3)
			StopAnimTask(playerped, "random@getawaydriver", "idle_2_hands_up", 3)
			TaskPlayAnim(playerped, "random@getawaydriver", "hands_up_2_idle", 1.0, -1, -1, 0, 0, 0, 0, 0)
			ClearPedSecondaryTask(playerped)
			SetEnableHandcuffs(playerped, false)
		end
	end
end

function dropgun()
	local player = PlayerPedId()
	if (IsPedArmed(player, 7)) then
		-- TriggerEvent('framework:tnotify:alert', 'success', 'You have dropped your weapon!')
		ClearPedTasks(player)
		exports.core_framework:PlayAnimation(player, "weapons@first_person@aim_rng@generic@projectile@sticky_bomb@", "plant_floor")
		Citizen.Wait(1000)
		SetPedDropsInventoryWeapon(player, GetSelectedPedWeapon(player), 0.0, 0.6, -0.9, 30)
		ClearPedTasks(player)
	else
		TriggerEvent("framework:tnotify:alert", "error", "You are not holding a weapon.")
	end
end

function healplayer()
	local t, distance = GetClosestPlayer()
	local ped = GetPlayerPed(t)
	local tname = GetPlayerName(t)
	if (distance ~= -1 and distance < 3) then
		TriggerEvent("core:tnotify:alert", "success", "You successfully healed: " .. tname)
		SetEntityHealth(ped, 200)
	else
		TriggerEvent("core:tnotify:alert", "error", "No player found/Get closer.")
	end
end
