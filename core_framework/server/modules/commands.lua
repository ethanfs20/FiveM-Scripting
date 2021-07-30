-- ░█████╗░░█████╗░███╗░░░███╗███╗░░░███╗░█████╗░███╗░░██╗██████╗░░██████╗
-- ██╔══██╗██╔══██╗████╗░████║████╗░████║██╔══██╗████╗░██║██╔══██╗██╔════╝
-- ██║░░╚═╝██║░░██║██╔████╔██║██╔████╔██║███████║██╔██╗██║██║░░██║╚█████╗░
-- ██║░░██╗██║░░██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚████║██║░░██║░╚═══██╗
-- ╚█████╔╝╚█████╔╝██║░╚═╝░██║██║░╚═╝░██║██║░░██║██║░╚███║██████╔╝██████╔╝
-- ░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░╚═════╝░

local requests = {}
local timeout = 10 -- seconds

RegisterCommand(
	'addxp',
	function(source, args, rawCommand)
		local target = args[1]
		local value = tonumber(args[2])
		local targetname = GetPlayerName(target)
		local src = source
		if target then
			if targetname then
				if value then
					if source >= 0 then
						TriggerClientEvent(
							'framework:notif:CustomMessage',
							source,
							Config['server'].serverprefix .. targetname .. ' was given ' .. value .. ' XP.'
						)
					else
						print(Config['server'].serverprefix .. targetname .. ' was given ' .. value .. ' XP.')
					end
					sendToDiscord(Config['discord'].xpwebhook, Config['discord'].SystemAvatar, 'Command: addxp\n**Target:** ', targetname .. '\n\n**Amount:**\n' .. value, 16711680, source)
					AddXP(target, value)
				else
					TriggerClientEvent(
						'framework:notif:CustomMessage',
						src,
						Config['server'].serverprefix .. Config['CommandUsage'].addxp
					)
				end
			else
				TriggerClientEvent(
					'framework:notif:CustomMessage',
					src,
					Config['server'].serverprefix .. Config['CommandUsage'].addxp
				)
				TriggerClientEvent(
					'framework:notif:CustomMessage',
					src,
					Config['server'].serverprefix .. Config['CommonStrings'].noplayerspec
				)
			end
		else
			TriggerClientEvent(
				'framework:notif:CustomMessage',
				src,
				Config['server'].serverprefix .. Config['CommandUsage'].addxp
			)
			TriggerClientEvent(
				'framework:notif:CustomMessage',
				src,
				Config['server'].serverprefix .. Config['CommonStrings'].noplayerspec
			)
		end
	end,
	true
	
)

RegisterCommand(
	'removexp',
	function(source, args, rawCommand)
		local target = args[1]
		local value = tonumber(args[2])
		local targetname = GetPlayerName(target)
		if target then
			if targetname then
				if value then
					if source >= 0 then
						TriggerClientEvent(
							'framework:notif:CustomMessage',
							source,
							Config['server'].serverprefix .. value .. ' XP was taken from ' .. targetname
						)
					else
						print(Config['server'].serverprefix .. value .. ' XP was taken from ' .. targetname)
					end
					sendToDiscord(Config['discord'].xpwebhook, Config['discord'].SystemAvatar, 'Command: removexp\n**Target:** ', targetname .. '\n\n**Amount:**\n' .. value, 16711680, source)
				RemoveXP(target, value)
				else
					TriggerClientEvent(
						'framework:notif:CustomMessage',
						source,
						Config['server'].serverprefix .. Config['CommandUsage'].removexp
					)
				end
			else
				TriggerClientEvent(
					'framework:notif:CustomMessage',
					source,
					Config['server'].serverprefix .. Config['CommandUsage'].removexp
				)
				TriggerClientEvent(
					'framework:notif:CustomMessage',
					source,
					Config['server'].serverprefix .. Config['CommonStrings'].invalidplayer
				)
			end
		else
			TriggerClientEvent(
				'framework:notif:CustomMessage',
				source,
				Config['server'].serverprefix .. Config['CommandUsage'].removexp
			)
			TriggerClientEvent(
				'framework:notif:CustomMessage',
				source,
				Config['server'].serverprefix .. Config['CommonStrings'].noplayerspec
			)
		end
	end,
	true
)

RegisterCommand(
	'revall',
	function()
		TriggerClientEvent('framework:revall', -1)
	end,
	true
)

RegisterCommand(
	'rev',
	function(source, args, rawCommand)
		if args[1] then
			local target = args[1]
			if GetPlayerName(target) then
				TriggerClientEvent('framework:rev', target)
			else
				TriggerClientEvent('framework:notif:CustomMessage', source, Config['CommonStrings'].invalidplayer)
			end
		else
			TriggerClientEvent('framework:rev', source)
		end
	end,
	false
)

RegisterCommand(
	'dv',
	function(source)
		if source == 0 then
			print(Config['server'].serverprefix .. Config['CommonStrings'].source0)
		else
			TriggerClientEvent('framework:getdelveh', source)
		end
	end,
	false
)

RegisterCommand(
	'tpa',
	function(source, args, rawCommand)
		if (source < 1) then
			return
		end
		local targetId = args[1]
		if not targetId then
			TriggerClientEvent('framework:notif:CustomMessage', source, 'You need to specify a targets server ID.')
			return
		end
		if GetPlayerPing(targetId) == 0 then
			TriggerClientEvent('framework:notif:CustomMessage', source, 'This player does not exist.')
			return
		end
		if targetId == tostring(source) then
			TriggerClientEvent('framework:notif:CustomMessage', source, 'You cannot teleport to yourself.')
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
		TriggerClientEvent('framework:notif:CustomMessage', source, 'You sent a teleport request to [' .. targetId .. '].')
		TriggerClientEvent('framework:recieveRequest', targetId, requestData)
	end,
	false
)

RegisterCommand(
	'tpaccept',
	function(source, args, rawCommand)
		if (source < 1) then
			return
		end
		local targetId = args[1]
		if not targetId then
			TriggerClientEvent(
				'framework:notif:CustomMessage',
				source,
				'You need to specify the server ID of the player whos request you are accepting.'
			)
			return
		end
		local request = requests[targetId]
		if not request then
			TriggerClientEvent('framework:notif:CustomMessage', source, 'You do not have a request from that player.')
			return
		end
		if request.target ~= tostring(source) then
			TriggerClientEvent('framework:notif:CustomMessage', source, 'You do not have a request from that player.')
			return
		end
		if os.time() - request.timestamp > timeout then
			TriggerClientEvent('framework:notif:CustomMessage', source, 'This request timed out.')
			requests[targetId] = nil
			return
		end
		local targetPed = GetPlayerPed(source)
		local targetCoords = GetEntityCoords(targetPed)
		TriggerClientEvent('framework:setCoords', request.id, targetCoords)
		TriggerClientEvent(
			'framework:notif:CustomMessage',
			source,
			'You accepted a teleport request from ' .. request.name .. ' [' .. request.id .. ']'
		)
		requests[targetId] = nil
	end,
	false
)

RegisterCommand(
	'bringall',
	function(source)
		local coords = GetEntityCoords(GetPlayerPed(source))
		TriggerClientEvent('framework:setCoords', -1, coords)
	end,
	true
)

RegisterCommand('911', function(source, args, raw)
    local message = table.concat(args, ' ')
    TriggerClientEvent('chatMessage', -1, '^5911: ^0(^1' .. GetPlayerName(source) ..' ^0| ^1' ..source..'^0)', { 30, 144, 255 }, message)
end)

RegisterCommand('twot', function(source, args, raw)
    local message = table.concat(args, ' ')
    TriggerClientEvent('chatMessage', -1, '^5911: ^0(^1' .. GetPlayerName(source) ..' ^0| ^1' ..source..'^0)', { 30, 144, 255 }, message)
	sendToDiscord(Config['discord'].tweetwebhook, Config['discord'].SystemAvatar, 'Twotter\n:e_mail:', message, 16711680, source)
end)
