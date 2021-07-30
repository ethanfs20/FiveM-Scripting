-- ███╗░░░███╗███████╗███╗░░██╗██╗░░░██╗  ░█████╗░░█████╗░██████╗░███████╗
-- ████╗░████║██╔════╝████╗░██║██║░░░██║  ██╔══██╗██╔══██╗██╔══██╗██╔════╝
-- ██╔████╔██║█████╗░░██╔██╗██║██║░░░██║  ██║░░╚═╝██║░░██║██║░░██║█████╗░░
-- ██║╚██╔╝██║██╔══╝░░██║╚████║██║░░░██║  ██║░░██╗██║░░██║██║░░██║██╔══╝░░
-- ██║░╚═╝░██║███████╗██║░╚███║╚██████╔╝  ╚█████╔╝╚█████╔╝██████╔╝███████╗
-- ╚═╝░░░░░╚═╝╚══════╝╚═╝░░╚══╝░╚═════╝░  ░╚════╝░░╚════╝░╚═════╝░╚══════╝

outfits =
	json.decode(LoadResourceFile(GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), "uniform_file")))

local function convertInput(input)
	local t1 = tonumber(string.split(input, ":")[1]) - 1
	local t2 = tonumber(string.split(input, ":")[2]) - 1
	return ({t1, t2})
end

local function setOutfit(outfit)
	local ped = PlayerPedId()

	if
		(outfit.Gender == "Male" and GetEntityModel(ped) == GetHashKey("mp_m_freemode_01")) or
			(outfit.Gender == "Female" and GetEntityModel(ped) == GetHashKey("mp_f_freemode_01"))
	 then
		componentMap = {
			{outfit.Mask, 1},
			{outfit.UpperSkin, 3},
			{outfit.Pants, 4},
			{outfit.Parachute, 5},
			{outfit.Shoes, 6},
			{outfit.Accessories, 7},
			{outfit.UnderCoat, 8},
			{outfit.Armor, 9},
			{outfit.Decal, 10},
			{outfit.Top, 11}
		}
		propMap = {{outfit.Hat, 0}, {outfit.Glasses, 1}, {outfit.Watch, 6}}

		for i in ipairs(componentMap) do
			if componentMap[i][1] then
				SetPedComponentVariation(
					ped,
					componentMap[i][2],
					convertInput(componentMap[i][1])[1],
					convertInput(componentMap[i][1])[2],
					0
				)
			end
		end

		for i in ipairs(propMap) do
			if propMap[i][1] then
				if convertInput(propMap[i][1])[1] == -1 then
					ClearPedProp(ped, propMap[i][2])
				else
					SetPedPropIndex(ped, propMap[i][2], convertInput(propMap[i][1])[1], convertInput(propMap[i][1])[2], true)
				end
			end
		end
	end
end

local categoryOutfitsM = {}
local categoryOutfitsF = {}

for x, outfit in ipairs(outfits) do
	found = false
	if outfit.Gender == "Male" then
		for i, j in ipairs(categoryOutfitsM) do
			if categoryOutfitsM[i][1] == outfit.Category2 then
				table.insert(categoryOutfitsM[i], outfit)
				found = true
			end
		end
		if found == false then
			table.insert(categoryOutfitsM, {outfit.Category2, outfit})
		end
	else
		for i, j in ipairs(categoryOutfitsF) do
			if categoryOutfitsF[i][1] == outfit.Category2 then
				table.insert(categoryOutfitsF[i], outfit)
				found = true
			end
		end
		if found == false then
			table.insert(categoryOutfitsF, {outfit.Category2, outfit})
		end
	end
end

local menuPool = NativeUI.CreatePool()
local mainMenuM = NativeUI.CreateMenu("EUP Outfits", "Pick your outfit!", 1320, 0)
-- local Item = NativeUI.CreateItem("Clock out of service", "Clock out of service.")
-- Item.Activated = function(ParentMenu, SelectedItem)
-- 	ServiceOff()
-- end
-- mainMenuM:AddItem(Item)
for i, list in pairs(categoryOutfitsM) do
	local subMenu = menuPool:AddSubMenu(mainMenuM, list[1], 1320, 0)
	for id, outfit in ipairs(list) do
		if id ~= 1 then
			categoryOutfitsM[i][id].item = NativeUI.CreateItem(categoryOutfitsM[i][id].Name, "Select this outfit.")
			subMenu:AddItem(categoryOutfitsM[i][id].item)
		end
	end
	subMenu.OnItemSelect = function(sender, item, index)
		for id, outfit in pairs(list) do
			if categoryOutfitsM[i][id].item == item then
				local ped = PlayerPedId()
				if terminated then
					exports.core_framework:TerminatedMessage()
				else
					if onduty then
						setOutfit(outfit)
					else
						exports.core_framework:GiveLoadout(spawnLoadoutList, ped, spawnLoadoutExtrasList)
						ServiceOn()
						setOutfit(outfit)
					end
				end
			end
		end
	end
end

local mainMenuF = NativeUI.CreateMenu("EUP Outfits", "Pick your outfit!", 1320, 0)
for i, list in pairs(categoryOutfitsF) do
	local subMenu = menuPool:AddSubMenu(mainMenuF, list[1], 1320, 0)
	for id, outfit in ipairs(list) do
		if id ~= 1 then
			categoryOutfitsF[i][id].item = NativeUI.CreateItem(categoryOutfitsF[i][id].Name, "Select this outfit.")
			subMenu:AddItem(categoryOutfitsF[i][id].item)
		end
	end
	subMenu.OnItemSelect = function(sender, item, index)
		for id, outfit in pairs(list) do
			if categoryOutfitsF[i][id].item == item then
				local ped = PlayerPedId()
				if terminated then
					exports.core_framework:TerminatedMessage()
				else
					if onduty then
						setOutfit(outfit)
					else
						exports.core_framework:GiveLoadout(spawnLoadoutList, ped, spawnLoadoutExtrasList)
						ServiceOn()
						setOutfit(outfit)
					end
				end
			end
		end
	end
end

menuPool:Add(mainMenuM)
menuPool:Add(mainMenuF)
menuPool:RefreshIndex()
menuPool:MouseControlsEnabled(false)
menuPool:ControlDisablingEnabled(false)

-- ████████╗██╗░░██╗██████╗░███████╗░█████╗░██████╗░░██████╗
-- ╚══██╔══╝██║░░██║██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝
-- ░░░██║░░░███████║██████╔╝█████╗░░███████║██║░░██║╚█████╗░
-- ░░░██║░░░██╔══██║██╔══██╗██╔══╝░░██╔══██║██║░░██║░╚═══██╗
-- ░░░██║░░░██║░░██║██║░░██║███████╗██║░░██║██████╔╝██████╔╝
-- ░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═════╝░╚═════╝░

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
			local ped = PlayerPedId()
			if permissions and not WaitTime then
				for k in pairs(coords) do
					local plyCoords = GetEntityCoords(ped, false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, coords[k].x, coords[k].y, coords[k].z)
					if dist < 2.0 then
						DrawMarker(
							2,
							coords[k].x,
							coords[k].y,
							coords[k].z,
							0,
							0,
							0,
							0,
							0,
							0,
							0.501,
							1.0001,
							0.5001,
							255,
							255,
							255,
							200,
							1,
							0,
							0,
							1
						)
						exports.ui_framework:DrawText3D(coords[k].x, coords[k].y, coords[k].z + 0.6, "Press ~p~E ~w~to open menu.")
						if IsControlJustPressed(1, 51) then -- "E"
							if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
								mainMenuM:Visible(not mainMenuM:Visible())
							elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
								mainMenuF:Visible(not mainMenuF:Visible())
							end
						end
					end
				end
				menuPool:ProcessMenus()
			else
				for k in pairs(coords) do
					local plyCoords = GetEntityCoords(ped, false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, coords[k].x, coords[k].y, coords[k].z)
					if dist < 2.0 then
						DrawMarker(
							2,
							coords[k].x,
							coords[k].y,
							coords[k].z,
							0,
							0,
							0,
							0,
							0,
							0,
							0.501,
							1.0001,
							0.5001,
							255,
							255,
							255,
							200,
							1,
							0,
							0,
							1
						)
						exports.ui_framework:DrawText3D(
							coords[k].x,
							coords[k].y,
							coords[k].z + 0.6,
							"Apply through https://discord.gg/~p~CPxWHD8WM6"
						)
					end
				end
			end
		end
	end
)

