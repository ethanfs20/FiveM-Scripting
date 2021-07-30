RegisterServerEvent("police:getAllCopsInService")
RegisterServerEvent("police:takeService")
RegisterServerEvent("police:breakService")
RegisterServerEvent("police:cuffGranted")
RegisterServerEvent("police:confirmUnseat")
RegisterServerEvent("police:dragRequest")
RegisterServerEvent("police:finesGranted")
RegisterServerEvent("police:forceEnterAsk")
RegisterServerEvent("police:sendStatus")
RegisterServerEvent("police:getActive")

local inServiceCops = {}

AddEventHandler(
	"police:takeService",
	function()
		if IsPlayerAceAllowed(source, "emergency.services") then
			local pname = GetPlayerName(source)
			if (not inServiceCops[source]) then
				inServiceCops[source] = getPlayerID(source)
				for i, c in pairs(inServiceCops) do
					TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
					TriggerClientEvent("framework:notif:CustomMessage", i, pname .. " has entered service.")
				end
			end
			TriggerClientEvent("framework:notif:CustomMessage", source, "You have entered service!")
			setDuty({source = source, status = 1})
			return (true)
		else
			TriggerClientEvent("framework:notif:NoPerms", source)
		end
	end
)

AddEventHandler(
	"police:breakService",
	function()
		if IsPlayerAceAllowed(source, "emergency.services") then
			local pname = GetPlayerName(source)
			if (inServiceCops[source]) then
				inServiceCops[source] = nil
				for i, c in pairs(inServiceCops) do
					TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
					TriggerClientEvent("framework:notif:CustomMessage", i, pname .. " has entered service.")
				end
			end
			TriggerClientEvent("framework:notif:CustomMessage", source, "You have exited service!")
			setDuty({source = source, status = 0})
			return (false)
		else
			TriggerClientEvent("framework:notif:NoPerms", source)
		end
	end
)

AddEventHandler(
	"police:sendStatus",
	function(status)
		if IsPlayerAceAllowed(source, "emergency.services") then
			print("test")
			local pname = GetPlayerName(source)
			for i, c in pairs(inServiceCops) do
				TriggerClientEvent("framework:notif:CustomMessage", i, pname .. " " .. status)
			end
			return (true)
		else
			TriggerClientEvent("framework:notif:NoPerms", source)
		end
	end
)

AddEventHandler(
	"police:getActive",
	function()
		if IsPlayerAceAllowed(source, "emergency.services") then
			print(inServiceCops)
			return {officers = inServiceCops}
		else
			TriggerClientEvent("framework:notif:NoPerms", source)
		end
	end
)

AddEventHandler(
	"playerDropped",
	function()
		if IsPlayerAceAllowed(source, "emergency.services") and source ~= nil then
			if (inServiceCops[source]) then
				inServiceCops[source] = nil
				for i, c in pairs(inServiceCops) do
					TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
				end
			end
		end
	end
)

AddEventHandler(
	"police:cuffGranted",
	function(t)
		local eventname = "police:cuffGranted"
		local source = source
		if t == -1 or t == "-1" then
			if source == "" then
				print(
					GetPlayerName(source) .. " " .. eventname .. " | This event was triggered illegally. Please investigate the user.	"
				)
				DropPlayer(source, "Attempted to trigger an event illegally.")
			else
				print(
					"Someone is attempting to trigger events illegally, please investigate now. It is possible someone might have a client side trainer."
				)
			end
		end
		if IsPlayerAceAllowed(source, "emergency.services") then
			TriggerClientEvent("police:getArrested", t)
			TriggerClientEvent(
				"framework:tnotify:alert",
				source,
				"success",
				"You just placed " .. GetPlayerName(t) .. " under arrest."
			)
		else
			TriggerClientEvent("framework:notif:NoPerms", source)
		end
	end
)

AddEventHandler(
	"police:confirmUnseat",
	function(t)
		local eventname = "police:confirmUnseat"
		local source = source
		if t == -1 or t == "-1" then
			if source == "" then
				print(
					GetPlayerName(source) .. " " .. eventname .. " | This event was triggered illegally. Please investigate the user.	"
				)
				DropPlayer(source, "Attempted to trigger an event illegally.")
			else
				print(
					"Someone is attempting to trigger events illegally, please investigate now. It is possible someone might have a client side trainer."
				)
			end
		end
		if IsPlayerAceAllowed(source, "emergency.services") then
			TriggerClientEvent(
				"framework:tnotify:alert",
				source,
				"success",
				"You got " .. GetPlayerName(t) .. " out of the vehicle."
			)
			TriggerClientEvent("police:unseatme", t)
		else
			TriggerClientEvent("framework:notif:NoPerms", source)
		end
	end
)

AddEventHandler(
	"police:dragRequest",
	function(t)
		local eventname = "police:dragRequest"
		local source = source
		if t == -1 or t == "-1" then
			if source == "" then
				print(
					GetPlayerName(source) .. " " .. eventname .. " | This event was triggered illegally. Please investigate the user.	"
				)
				DropPlayer(source, "Attempted to trigger an event illegally.")
			else
				print(
					"Someone is attempting to trigger events illegally, please investigate now. It is possible someone might have a client side trainer."
				)
			end
		end
		if IsPlayerAceAllowed(source, "emergency.services") then
			TriggerClientEvent("framework:tnotify:alert", source, "success", "You are now dragging " .. GetPlayerName(t) .. ".")
			TriggerClientEvent("police:toggleDrag", t, source)
		else
			TriggerClientEvent("framework:notif:NoPerms", source)
		end
	end
)

AddEventHandler(
	"police:finesGranted",
	function(t, amount)
		local eventname = "police:finesGranted"
		local source = source
		if t == -1 or t == "-1" then
			if source == "" then
				print(
					GetPlayerName(source) .. " " .. eventname .. " | This event was triggered illegally. Please investigate the user.	"
				)
				DropPlayer(source, "Attempted to trigger an event illegally.")
			else
				print(
					"Someone is attempting to trigger events illegally, please investigate now. It is possible someone might have a client side trainer."
				)
			end
		end
		if IsPlayerAceAllowed(source, "emergency.services") then
			TriggerClientEvent("police:payFines", target, amount, source)
		else
			TriggerClientEvent("framework:notif:NoPerms", source)
		end
	end
)

AddEventHandler(
	"police:forceEnterAsk",
	function(t, v)
		local eventname = "police:forceEnterAsk"
		local source = source
		if t == -1 or t == "-1" then
			if source == "" then
				print(
					GetPlayerName(source) .. " " .. eventname .. " | This event was triggered illegally. Please investigate the user.	"
				)
				DropPlayer(source, "Attempted to trigger an event illegally.")
			else
				print(
					"Someone is attempting to trigger events illegally, please investigate now. It is possible someone might have a client side trainer."
				)
			end
		end
		if IsPlayerAceAllowed(source, "emergency.services") then
			TriggerClientEvent("police:forcedEnteringVeh", t, v)
		else
			TriggerClientEvent("framework:notif:NoPerms", source)
		end
	end
)

AddEventHandler(
	"K9:RequestVehicleToggle",
	function()
		local src = source
		TriggerClientEvent("K9:ToggleVehicle", src, K9ConfigVehicleRestriction, K9ConfigVehiclesList)
	end
)

AddEventHandler(
	"K9:RequestItems",
	function()
		local src = source
		TriggerClientEvent("K9:SearchVehicle", src, K9ConfigItems, K9ConfigOpenDoorsOnSearch)
	end
)
