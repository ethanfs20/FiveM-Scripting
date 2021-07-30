RegisterServerEvent('infinity_bodyguard:RequestPerms')
AddEventHandler('infinity_bodyguard:RequestPerms', function()
	if IsPlayerAceAllowed(source, 'bodyguard.menu') then
		TriggerClientEvent('infinity_bodyguard:ReceivePerms', source, true)
	else
		TriggerClientEvent('infinity_bodyguard:ReceivePerms', source, false)
	end
end)