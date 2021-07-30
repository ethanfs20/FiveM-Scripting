RegisterCommand(
	"eforceduty",
	function(source, args, rawCommand)
		if #args == 1 then
			if tonumber(args[1]) then
				local target = tonumber(args[1])
				local pname = GetPlayerName(target)
				if pname then
					TriggerClientEvent("fireems:forceduty", target)
				else
					TriggerClientEvent("pNotify:SendNotification", -1, {{text = "This server ID is invalid!", type = "error", timeout = 1000}})
				end
			else
				TriggerClientEvent("pNotify:SendNotification", -1, {{text = "You must input a players server ID.", type = "error", timeout = 1000}})
			end
		end
	end,
	true
)