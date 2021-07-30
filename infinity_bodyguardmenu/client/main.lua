_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Body Guard", "~b~Protect Yo Self", 1320, 0) -- for right align
-- mainMenu = NativeUI.CreateMenu("Body Guard", "~b~Protect Yo Self") -- for left align
_menuPool:Add(mainMenu)

models = { "a_f_m_beach_01", "a_f_m_bodybuild_01", "csb_mweather", "csb_ramp_marine", "s_m_m_movalien_01", "s_m_y_blackops_03", "s_m_y_prismuscl_01", "s_m_y_swat_01", "ig_ballasog", "g_m_y_lost_01", "g_m_y_salvagoon_01", "g_m_y_famca_01" }
item1 = NativeUI.CreateListItem("Spawn Ped", models, 1, "Ped Models.")
    item1.OnListSelected = function(ParentMenu, SelectedItem, Index)
    model = SelectedItem:IndexToItem(Index)
    if TriggerServerEvent("core_bodyperms", source) then
		createbody(model)
	end
end
mainMenu:AddItem(item1)

wepmodels = { "WEAPON_COMBATMG", "weapon_knife", "weapon_appistol", "weapon_pistol", "weapon_smg", "weapon_pumpshotgun", "weapon_assaultshotgun", "weapon_carbinerifle_mk2", "weapon_compactrifle", "weapon_assaultrifle", "weapon_mg", "weapon_heavysniper_mk2", "weapon_minigun", "weapon_rpg" }
item2 = NativeUI.CreateListItem("Give Weapons", wepmodels, 1, "Give weapons to the body guards.")
    item2.OnListSelected = function(ParentMenu, SelectedItem, Index)
    model = SelectedItem:IndexToItem(Index)
    giveweap(model)
end
mainMenu:AddItem(item2)

item3 = NativeUI.CreateItem("Clone yourself", "Clone your ped to make a bodyguard.")
    item3.Activated = function(ParentMenu, SelectedItem)
		clonebody()
	end
mainMenu:AddItem(item3)

item5 = NativeUI.CreateItem("Remove Weapons", "Remove the weapons from the body guards.")
    item5.Activated = function(ParentMenu, SelectedItem)
		removeweap()
	end
mainMenu:AddItem(item5)

item6 = NativeUI.CreateItem("Remove Body Guards", "GuudBaye!")
    item6.Activated = function(ParentMenu, SelectedItem)
		delguards()
	end
mainMenu:AddItem(item6)

_menuPool:RefreshIndex()
_menuPool:MouseControlsEnabled(false)
_menuPool:ControlDisablingEnabled(false)
