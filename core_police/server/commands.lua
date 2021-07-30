RegisterCommand(
	"forceduty",
	function(source, args, rawCommand)
		if #args == 1 then
			if tonumber(args[1]) then
				local target = tonumber(args[1])
				local pname = GetPlayerName(target)
				if pname then
					TriggerClientEvent("police:forceduty", target)
				else
					TriggerClientEvent("framework:tnotify:alert", source, "error", "This server ID is invalid.")
				end
			else
				TriggerClientEvent("framework:tnotify:alert", source, "error", "You must input a players server ID.")
			end
		end
		return
	end,
	true
)