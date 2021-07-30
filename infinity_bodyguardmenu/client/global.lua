-- ░█████╗░██╗░░░░░██╗███████╗███╗░░██╗████████╗
-- ██╔══██╗██║░░░░░██║██╔════╝████╗░██║╚══██╔══╝
-- ██║░░╚═╝██║░░░░░██║█████╗░░██╔██╗██║░░░██║░░░
-- ██║░░██╗██║░░░░░██║██╔══╝░░██║╚████║░░░██║░░░
-- ╚█████╔╝███████╗██║███████╗██║░╚███║░░░██║░░░
-- ░╚════╝░╚══════╝╚═╝╚══════╝╚═╝░░╚══╝░░░╚═╝░░░

local permissions = nil
local bodyguards = {} -- Table of the bodyguard
local size = 0

RegisterNetEvent("infinity_bodyguard:ReceivePerms")
AddEventHandler(
	"infinity_bodyguard:ReceivePerms",
	function(bool)
		permissions = bool
		print(bool)
	end
)

RegisterCommand(
	"body",
	function()
		if permissions == true and Config.command then
			mainMenu:Visible(not mainMenu:Visible())
		end
	end
)

-- Functions

function createbody(model) -- Function to create the ped
	if permissions and size < 7 then
		initPed(model)
		ShowNotification("Bodyguard spawned.")
	else
		ShowNotification("You have reached the max amount of bodyguards.")
	end
end

function clonebody() -- Function to create the ped
	if permissions and size < 7 then
		local pped = PlayerPedId()
		local model = GetEntityModel(pped)
		initPed(model)
		ShowNotification("Bodyguard spawned.")
	else
		ShowNotification("You have reached the max amount of bodyguards.")
	end
end

function initPed(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(1)
	end
	local pped = PlayerPedId()
	local ploc = GetOffsetFromEntityInWorldCoords(pped, 0.0, 5.0, 0.0)
	local pgroup = GetPedGroupIndex(PlayerPedId())
	local ped = CreatePed(3, model, ploc.x + 2, ploc.y + 2, ploc.z, GetEntityHeading(pped), true, true)

	SetPedAsGroupMember(ped, pgroup)

	SetEntityInvincible(ped, Config.godmode)
	SetPedCanBeTargetted(ped, false)
	TaskCombatHatedTargetsAroundPed(ped, 20, 0)
	SetPedDropsWeaponsWhenDead(ped, false)
	SetPedSuffersCriticalHits(ped, Config.headshot)
	SetPedCanRagdoll(ped, Config.ragdoll)
	SetModelAsNoLongerNeeded(model)

	local bodybip = AddBlipForEntity(ped)
	SetBlipSprite(bodybip, Config.blip)
	SetBlipColour(bodybip, Config.color)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Body Guard")
	EndTextCommandSetBlipName(bodybip)

	table.insert(bodyguards, ped)
end

function delguards() -- Function to remove the bodyguards
	for k, v in pairs(bodyguards) do
		if DoesEntityExist(v) then
			DeleteEntity(v)
			RemoveGroup(pgroup)
			bodyguards[k] = nil
			size = 0
			ShowNotification("All Bodyguards have been removed.")
		end
	end
end

function giveweap(model) -- Function to give weapons to the body guards
	for k, v in pairs(bodyguards) do
		if DoesEntityExist(v) then
			GiveWeaponToPed(v, model, 9000, true, true)
			ShowNotification("Weapon added.")
		end
	end
end

function removeweap() -- Function to remove weapons from the bodyguards
	for k, v in pairs(bodyguards) do
		if DoesEntityExist(v) then
			RemoveAllPedWeapons(v)
			ShowNotification("Weapon/s removed.")
		end
	end
end

function ShowNotification(text) -- Function to send notifications
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

Citizen.CreateThread(
	function()
		TriggerServerEvent('infinity_bodyguard:RequestPerms')
		while permissions == nil do
			Citizen.Wait(0)
		end
		if permissions then
			while true do
				Citizen.Wait(0)
				local playerped = PlayerPedId()
				local ploc = GetEntityCoords(playerped)
				for k, v in pairs(bodyguards) do
					if DoesEntityExist(v) then
						local bodyloc = GetEntityCoords(v, true)
						if (Vdist(ploc.x, ploc.y, ploc.z, bodyloc.x, bodyloc.y, bodyloc.z) >= 50) then
							SetEntityCoords(v, ploc.x + 2, ploc.y + 2, ploc.z, false, false, false, true)
							SetEntityVisible(v, true, 0)
						end
						if IsEntityDead(v) then
							DeleteEntity(v)
							bodyguards[k] = nil
						end
						if IsPedInParachuteFreeFall(playerped) then
							GiveWeaponToPed(v, "GADGET_PARACHUTE")
							ForcePedToOpenParachute(v)
							TaskParachuteToTarget(v, ploc)
						end
						size = k
					end
				end
				_menuPool:ProcessMenus()
				if IsControlJustPressed(1, Config.key) and Config.keypress then
					mainMenu:Visible(not mainMenu:Visible())
				end
			end
		end
	end
)
