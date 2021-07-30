local mainTool = NativeUI.CreateMenu("ToolBox", "~p~Project X", 1320, 0)
menuTool = NativeUI.CreatePool()
menuTool:Add(mainTool)

function AddMenuGPSMenu(menu)
	local gps = {
		"Sandy Shores PD",
		"Sandy Shores Airfield",
		"Fire Station",
		"Sandy Shores Ammunation",
		"Yellow Jack Inn",
		"Liquor Ace",
		"Sandy Shores 24/7",
		"Paleto Bay Savings Bank",
		"Paleto Bay PD",
		"Recommended Los Santos PD"
	}
	local newitem = NativeUI.CreateListItem("GPS-EZ", gps, 1, "Select a location to set a waypoint to!")
	newitem.OnListSelected = function(ParentMenu, SelectedItem, Index)
		local Item = SelectedItem:IndexToItem(Index)
		if Item == "Sandy Shores PD" then
			SetNewWaypoint(1853.8, 3687.17)
		elseif Item == "Sandy Shores Airfield" then
			SetNewWaypoint(1781.94, 3283.23)
		elseif Item == "Fire Station" then
			SetNewWaypoint(1698, 3583)
		elseif Item == "Sandy Shores Ammunation" then
			SetNewWaypoint(1701, 3750)
		elseif Item == "Yellow Jack Inn" then
			SetNewWaypoint(1993, 3058)
		elseif Item == "Liquor Ace" then
			SetNewWaypoint(1395, 3595)
		elseif Item == "Sandy Shores 24/7" then
			SetNewWaypoint(1966, 3737)
		elseif Item == "Paleto Bay PD" then
			SetNewWaypoint(-441, 6018)
		elseif Item == "Recommended Los Santos PD" then
			SetNewWaypoint(432, -981)
		end
	end
	menu:AddItem(newitem)
end

function AddMenuVehicle(menu)
	local submenu = menuTool:AddSubMenu(menu, "Emergency Services", "", true, 0)
	local submenu3 = menuTool:AddSubMenu(submenu, "Player Controls", "", true, 0)
	local submenu2 = menuTool:AddSubMenu(submenu, "Vehicle Options", "", true, 0)
	local dogs = {
		"Golden Retreiver",
		"German Shephard",
		"Husky",
		"Rottweiler",
		"Horse"
	}
	local newitem = NativeUI.CreateListItem("K9 Toggle", dogs, 1, "Spawn your companion.")
	newitem.OnListSelected = function(ParentMenu, SelectedItem, Index)
		-- if emergencyperms then
		-- 	if onduty then
		local Item = SelectedItem:IndexToItem(Index)
		if Item == "Golden Retreiver" then
			TriggerEvent("K9:ToggleK9", "a_c_retriever")
		elseif Item == "German Shephard" then
			TriggerEvent("K9:ToggleK9", "a_c_shepherd")
		elseif Item == "Husky" then
			TriggerEvent("K9:ToggleK9", "a_c_husky")
		elseif Item == "Rottweiler" then
			TriggerEvent("K9:ToggleK9", "a_c_rottweiler")
		elseif Item == "Horse" then
			TriggerEvent("K9:ToggleK9", "a_c_deer")
		end
		-- 	else
		-- 		TriggerEvent("core:tnotify:alert", "error", "You need to be clocked in!")
		-- 	end
		-- else
		-- 	TriggerEvent(
		-- 		"core:tnotify:iinfo",
		-- 		"Emergency Services",
		-- 		"You are not authorized to perform this action, please apply at: " .. discord
		-- 	)
		-- end
	end
	submenu:AddItem(newitem)

	local Item = NativeUI.CreateItem("Search Vehicle", "Search suspects vehicle.")
	Item.Activated = function(ParentMenu, SelectedItem)
		-- if emergencyperms then
		-- 	if onduty then
		ExecuteCommand("search")
		-- 	else
		-- 		TriggerEvent("core:tnotify:alert", "error", "You need to be clocked in!")
		-- 	end
		-- else
		-- 	TriggerEvent(
		-- 		"core:tnotify:iinfo",
		-- 		"Emergency Services",
		-- 		"You are not authorized to perform this action, please apply at: " .. discord
		-- 	)
		-- end
	end
	submenu2:AddItem(Item)

	local Item = NativeUI.CreateItem("Toggle Dashcam", "Turn on Your Dashcam.")
	Item.Activated = function(ParentMenu, SelectedItem)
		-- if emergencyperms then
		-- 	if onduty then
		TriggerEvent("dash")
		-- 	else
		-- 		TriggerEvent("core:tnotify:alert", "error", "You need to be clocked in!")
		-- 	end
		-- else
		-- 	TriggerEvent(
		-- 		"core:tnotify:iinfo",
		-- 		"Emergency Services",
		-- 		"You are not authorized to perform this action, please apply at: " .. discord
		-- 	)
		-- end
	end
	submenu2:AddItem(Item)

	local Item = NativeUI.CreateItem("Unlock Vehicle", "Unlock the vehicle infront of you.")
	Item.Activated = function(ParentMenu, SelectedItem)
		-- if emergencyperms then
		-- 	if onduty then
		exports.job_police:unlockcar()
		-- 	else
		-- 		TriggerEvent("core:tnotify:alert", "error", "You need to be clocked in!")
		-- 	end
		-- else
		-- 	TriggerEvent(
		-- 		"core:tnotify:iinfo",
		-- 		"Emergency Services",
		-- 		"You are not authorized to perform this action, please apply at: " .. discord
		-- 	)
		-- end
	end
	submenu2:AddItem(Item)

	local Item = NativeUI.CreateItem("Cuff Suspect", "Cuff the player infront of you.")
	Item.Activated = function(ParentMenu, SelectedItem)
		-- if emergencyperms then
		-- 	if onduty then
		exports.job_police:ToggleCuff()
		-- 	else
		-- 		TriggerEvent("core:tnotify:alert", "error", "You need to be clocked in!")
		-- 	end
		-- else
		-- 	TriggerEvent(
		-- 		"core:tnotify:iinfo",
		-- 		"Emergency Services",
		-- 		"You are not authorized to perform this action, please apply at: " .. discord
		-- 	)
		-- end
	end
	submenu3:AddItem(Item)

	local Item = NativeUI.CreateItem("Heal player", "Heal the player infront of you.")
	Item.Activated = function(ParentMenu, SelectedItem)
		-- if emergencyperms then
		-- 	if onduty then
		exports.job_police:healplayer()
		-- 	else
		-- 		TriggerEvent("core:tnotify:alert", "error", "You need to be clocked in!")
		-- 	end
		-- else
		-- 	TriggerEvent(
		-- 		"core:tnotify:iinfo",
		-- 		"Emergency Services",
		-- 		"You are not authorized to perform this action, please apply at: " .. discord
		-- 	)
		-- end
	end
	submenu3:AddItem(Item)

	local Item = NativeUI.CreateItem("Perform CPR", "Perform CPR on the player closest to you.")
	Item.Activated = function(ParentMenu, SelectedItem)
		-- if emergencyperms then
		-- 	if onduty then
		exports.job_fireems:CPR()
		-- 	else
		-- 		TriggerEvent("core:tnotify:alert", "error", "You need to be clocked in!")
		-- 	end
		-- else
		-- 	TriggerEvent(
		-- 		"core:tnotify:iinfo",
		-- 		"Emergency Services",
		-- 		"You are not authorized to perform this action, please apply at: " .. discord
		-- 	)
		-- end
	end
	submenu3:AddItem(Item)

	local Item = NativeUI.CreateItem("Search and remove weapons", "Search the players person..")
	Item.Activated = function(ParentMenu, SelectedItem)
		-- if emergencyperms then
		-- 	if onduty then
		exports.job_police:RemoveWeapons()
		-- 	else
		-- 		TriggerEvent("core:tnotify:alert", "error", "You need to be clocked in!")
		-- 	end
		-- else
		-- 	TriggerEvent(
		-- 		"core:tnotify:iinfo",
		-- 		"Emergency Services",
		-- 		"You are not authorized to perform this action, please apply at: " .. discord
		-- 	)
		-- end
	end
	submenu3:AddItem(Item)

	local Item = NativeUI.CreateItem("Transport Suspect", "Drag the player with you.")
	Item.Activated = function(ParentMenu, SelectedItem)
		-- if emergencyperms then
		-- 	if onduty then
		exports.job_police:DragPlayer()
		-- 	else
		-- 		TriggerEvent("core:tnotify:alert", "error", "You need to be clocked in!")
		-- 	end
		-- else
		-- 	TriggerEvent(
		-- 		"core:tnotify:iinfo",
		-- 		"Emergency Services",
		-- 		"You are not authorized to perform this action, please apply at: " .. discord
		-- 	)
		-- end
	end
	submenu3:AddItem(Item)

	local Item = NativeUI.CreateItem("Put Suspect in Vehicle", "Put the plater in the car.")
	Item.Activated = function(ParentMenu, SelectedItem)
		-- if emergencyperms then
		-- 	if onduty then
		exports.job_police:PutInVehicle()
		-- 	else
		-- 		TriggerEvent("core:tnotify:alert", "error", "You need to be clocked in!")
		-- 	end
		-- else
		-- 	TriggerEvent(
		-- 		"core:tnotify:iinfo",
		-- 		"Emergency Services",
		-- 		"You are not authorized to perform this action, please apply at: " .. discord
		-- 	)
		-- end
	end
	submenu3:AddItem(Item)

	local Item = NativeUI.CreateItem("Take Suspect out of Vehicle", "Taket the player out of the car.")
	Item.Activated = function(ParentMenu, SelectedItem)
		-- if emergencyperms then
		-- 	if onduty then
		exports.job_police:UnseatVehicle()
		-- 	else
		-- 		TriggerEvent("core:tnotify:alert", "error", "You need to be clocked in!")
		-- 	end
		-- else
		-- 	TriggerEvent(
		-- 		"core:tnotify:iinfo",
		-- 		"Emergency Services",
		-- 		"You are not authorized to perform this action, please apply at: " .. discord
		-- 	)
		-- end
	end
	submenu3:AddItem(Item)

	local Item = NativeUI.CreateItem("Deploy Stinger Strip", "Put down spike strips. POP POP!")
	Item.Activated = function(ParentMenu, SelectedItem)
		-- if emergencyperms then
		-- 	if onduty then
		ExecuteCommand("setspikes")
		-- 	else
		-- 		TriggerEvent("core:tnotify:alert", "error", "You need to be clocked in!")
		-- 	end
		-- else
		-- 	TriggerEvent(
		-- 		"core:tnotify:iinfo",
		-- 		"Emergency Services",
		-- 		"You are not authorized to perform this action, please apply at: " .. discord
		-- 	)
		-- end
	end
	submenu:AddItem(Item)

	local Item = NativeUI.CreateItem("Pick up Stingers", "Pick up the spike strips.")
	Item.Activated = function(ParentMenu, SelectedItem)
		-- if emergencyperms then
		-- 	if onduty then
		exports.job_police:RemoveSpikes()
		-- 	else
		-- 		TriggerEvent("core:tnotify:alert", "error", "You need to be clocked in!")
		-- 	end
		-- else
		-- 	TriggerEvent(
		-- 		"core:tnotify:iinfo",
		-- 		"Emergency Services",
		-- 		"You are not authorized to perform this action, please apply at: " .. discord
		-- 	)
		-- end
	end
	submenu:AddItem(Item)
end

function AddMenuCiv(menu)
	local submenu = menuTool:AddSubMenu(menu, "Civilians", "", true, 0)
	local submenu2 = menuTool:AddSubMenu(submenu, "Props", "", true, 0)
	local props = {"Cardboard Box", "Pizza Box", "Wooden Crate", "Drug Package"}
	local newitem = NativeUI.CreateListItem("Carry Props", props, 1, "Carry props from the list.")
	newitem.OnListSelected = function(ParentMenu, SelectedItem, Index)
		local Item = SelectedItem:IndexToItem(Index)
		if Item == "Cardboard Box" then
			DoAction("box_carry")
		elseif Item == "Pizza Box" then
			DoAction("pizza_delivery")
		elseif Item == "Wooden Crate" then
			DoAction("crate_delivery")
		elseif Item == "Drug Package" then
			DoAction("test_action")
		end
	end
	submenu2:AddItem(newitem)
	local Item = NativeUI.CreateItem("Drop Item", "Drop the item on the floor.")
	Item.Activated = function(ParentMenu, SelectedItem)
		DoAction("none")
	end
	submenu2:AddItem(Item)
	local Item = NativeUI.CreateItem("Give Item", "Give the item to another player.")
	Item.Activated = function(ParentMenu, SelectedItem)
		DoAction("give_item")
	end
	submenu2:AddItem(Item)
	local Item = NativeUI.CreateItem("Hands Up On Knees", "Put your hands up on knees.")
	Item.Activated = function(ParentMenu, SelectedItem)
		TriggerEvent("HandsupKnees")
	end
	submenu:AddItem(Item)
end

function AddMenuUtil(menu)
	local submenu = menuTool:AddSubMenu(menu, "Utilities", "", true, 0)
	local Item = NativeUI.CreateItem("Toggle Delete Gun", "Enable Delete Gun.")
	Item.Activated = function(ParentMenu, SelectedItem)
		TriggerEvent("ObjectDeleteGunOn2")
	end
	submenu:AddItem(Item)
	local Item = NativeUI.CreateItem("Manual Vehicle Delete", "Delete vehicles manually upon clicking this.")
	Item.Activated = function(ParentMenu, SelectedItem)
		TriggerEvent("framework:getdelveh")
	end
	submenu:AddItem(Item)
	local Item = NativeUI.CreateItem("Drop/Pickup Weapon", "Drop/Pickup the weapon on the ground.")
	Item.Activated = function(ParentMenu, SelectedItem)
		dropgun(source)
	end
	submenu:AddItem(Item)
	local Item = NativeUI.CreateItem("Test Function", "For me to test shit out.")
	Item.Activated = function(ParentMenu, SelectedItem)
		TriggerServerEvent("hud:setplayer")
	end
	submenu:AddItem(Item)
end

function AddMenuSettings(menu)
	local submenu = menuTool:AddSubMenu(menu, "Settings", "", true, 0)
	local submenu2 = menuTool:AddSubMenu(submenu, "UI Locations", "", true, 0)
	local newitem = NativeUI.CreateItem("Photo Mode", "Minimize all GUI elements.")
	submenu:AddItem(newitem)
	newitem.Activated = function(ParentMenu, SelectedItem)
		exports.ui_speedo:ToggleDisplay()
		exports.ui_framework:minimaptoggle()
			exports.hud:UIDisplay("healthvis")
		exports.hud:UIDisplay("armorvis")
	end
	local newitem = NativeUI.CreateItem("Toggle Speedo", "Turn the speedo off completely.")
	submenu:AddItem(newitem)
	newitem.Activated = function(ParentMenu, SelectedItem)
		exports.ui_speedo:ToggleDisplay()
	end
	local newitem = NativeUI.CreateItem("Toggle Minimap", "Turn the minimap off completely.")
	submenu:AddItem(newitem)
	newitem.Activated = function(ParentMenu, SelectedItem)
		exports.ui_framework:minimaptoggle()
	end

	local newitem = NativeUI.CreateItem("Toggle Health Visibility", "Turn the minimap off completely.")
	submenu:AddItem(newitem)
	newitem.Activated = function(ParentMenu, SelectedItem)
		exports.hud:UIDisplay("healthvis")
	end

	local newitem = NativeUI.CreateItem("Toggle Armor Visibility", "Turn the minimap off completely.")
	submenu:AddItem(newitem)
	newitem.Activated = function(ParentMenu, SelectedItem)
		exports.hud:UIDisplay("armorvis")
	end

	local newitem = NativeUI.CreateItem("Edit Armor", "Move the armor status around.")
	submenu2:AddItem(newitem)
	newitem.Activated = function(ParentMenu, SelectedItem)
		exports.hud:ArmorEdit()
	end

	local newitem = NativeUI.CreateItem("Edit Health", "Move the health status around.")
	submenu2:AddItem(newitem)
	newitem.Activated = function(ParentMenu, SelectedItem)
		exports.hud:HealthEdit()
	end
	
		
	local newitem = NativeUI.CreateItem("Edit Fuel", "Move the fuel status around.")
	submenu2:AddItem(newitem)
	newitem.Activated = function(ParentMenu, SelectedItem)
		exports.hud:FuelEdit()
	end
end

AddMenuGPSMenu(mainTool)
AddMenuVehicle(mainTool)
AddMenuCiv(mainTool)
AddMenuUtil(mainTool)
AddMenuSettings(mainTool)
menuTool:RefreshIndex()
menuTool:MouseControlsEnabled(false)
menuTool:ControlDisablingEnabled(false)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			menuTool:ProcessMenus()
			if IsControlJustPressed(1, 166) then
				mainTool:Visible(not mainTool:Visible())
			end
		end
	end
)
