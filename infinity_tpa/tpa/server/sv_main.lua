-- Stores the current request data for every user.
-- Stores by requester ID.
local requests = {}
local timeout = 10 -- seconds

RegisterCommand(
	"tpa",
	function(source, args, rawCommand)
		if (source < 1) then
			return
		end
		local targetId = args[1]
		if not targetId then
			TriggerClientEvent("_tpa:showMessage", source, "You need to specify a target's server ID.")
			return
		end
		if GetPlayerPing(targetId) == 0 then
			TriggerClientEvent("_tpa:showMessage", source, "This player does not exist.")
			return
		end
		if targetId == tostring(source) then
			TriggerClientEvent("_tpa:showMessage", source, "You cannot teleport to yourself.")
			return
		end
		local requestData = {
			name = GetPlayerName(source),
			id = source,
			target = targetId,
			timestamp = os.time(),
			requestTimeout = timeout
		}
		requests[tostring(source)] = requestData
		TriggerClientEvent("_tpa:showMessage", source, "You sent a teleport request to [" .. targetId .. "].")
		TriggerClientEvent("tpa:recieveRequest", targetId, requestData)
	end,
	false
)

RegisterCommand(
	"tpaccept",
	function(source, args, rawCommand)
		if (source < 1) then
			return
		end
		local targetId = args[1]
		if not targetId then
			TriggerClientEvent(
				"_tpa:showMessage",
				source,
				"You need to specify the server ID of the player who's request you are accepting."
			)
			return
		end
		local request = requests[targetId]
		if not request then
			TriggerClientEvent("_tpa:showMessage", source, "You do not have a request from that player.")
			return
		end
		if request.target ~= tostring(source) then
			TriggerClientEvent("_tpa:showMessage", source, "You do not have a request from that player.")
			return
		end
		if os.time() - request.timestamp > timeout then
			TriggerClientEvent("_tpa:showMessage", source, "This request timed out.")
			requests[targetId] = nil
			return
		end
		local targetPed = GetPlayerPed(source)
		local targetCoords = GetEntityCoords(targetPed)
		TriggerClientEvent("_tpa:setCoords", request.id, targetCoords)
		TriggerClientEvent(
			"_tpa:showMessage",
			source,
			"You accepted a teleport request from " .. request.name .. " [" .. request.id .. "]"
		)
		requests[targetId] = nil
	end,
	false
)
