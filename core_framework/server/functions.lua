-- ███████╗██╗░░░██╗███╗░░██╗░█████╗░████████╗██╗░█████╗░███╗░░██╗░██████╗
-- ██╔════╝██║░░░██║████╗░██║██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝
-- █████╗░░██║░░░██║██╔██╗██║██║░░╚═╝░░░██║░░░██║██║░░██║██╔██╗██║╚█████╗░
-- ██╔══╝░░██║░░░██║██║╚████║██║░░██╗░░░██║░░░██║██║░░██║██║╚████║░╚═══██╗
-- ██║░░░░░╚██████╔╝██║░╚███║╚█████╔╝░░░██║░░░██║╚█████╔╝██║░╚███║██████╔╝
-- ╚═╝░░░░░░╚═════╝░╚═╝░░╚══╝░╚════╝░░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░

function GetPlayerIdentifierFromType(type, source)
	local identifiers = {}
	local identifierCount = GetNumPlayerIdentifiers(source)
	for a = 0, identifierCount do
		table.insert(identifiers, GetPlayerIdentifier(source, a))
	end
	for b = 1, #identifiers do
		if string.find(identifiers[b], type, 1) then
			return identifiers[b]
		end
	end
	return nil
end

function sendToDiscord(webhookUrl, avatar, title, message, color, source)
	local connect = {
		{
		  	['color'] = color,
		  	['title'] = '**'.. title ..'**\n',
			['description'] = message,
			['footer'] = {
				['text'] = 'FROM: ' .. GetPlayerName(source) .. ' | sID: ' .. source,
			},
		  }
	  }
	PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode({username = Config['discord'].WebhookName, embeds = connect, avatar_url = Config['discord'].WebhookAvatar}), { ['Content-Type'] = 'application/json' })
end

function DiscordGET(method, endpoint, jsondata)
	local data = nil
	PerformHttpRequest(
		'https://discordapp.com/api/' .. endpoint,
		function(errorCode, resultData, resulwebhookapitHeaders)
			data = {data = resultData, code = errorCode, headers = resultHeaders}
		end,
		method,
		#jsondata > 0 and json.encode(jsondata) or '',
		{['Content-Type'] = 'application/json', ['Authorization'] = 'Bot ' .. Config['discord'].bottoken}
	)
	while data == nil do
		Citizen.Wait(0)
	end
	return data
end

function GetDiscordRoles(discordId)
	if discordId then
		local endpoint = ('guilds/%s/members/%s'):format(Config['discord'].guildid, discordId)
		local member = DiscordGET('GET', endpoint, {})
		if member.code == 200 then
			local data = json.decode(member.data)
			local roles = data.roles
			return roles
		else
			print(Config['server'].serverprefix .. ' User is not apart of the Discord server!')
			return false
		end
	else
		print(Config['server'].serverprefix .. ' Discord was not connected to users FiveM account.')
		return false
	end
	return false
end