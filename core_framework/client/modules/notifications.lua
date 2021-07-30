RegisterNetEvent('framework:notif:NoPlayerNear')
RegisterNetEvent('framework:notif:NoPerms')
RegisterNetEvent('framework:notif:TerminatedMessage')
RegisterNetEvent('framework:notif:NotInService')
RegisterNetEvent('framework:notif:VehicleWhitelist')
RegisterNetEvent('framework:notif:CustomMessage')

AddEventHandler(
	'framework:notif:NoPlayerNear',
	function()
		NoPlayerNear()
	end
)

function NoPlayerNear()
	exports.pNotify:SendNotification(
		{
			text = Config['CommonStrings'].nonearplayer,
			layout = 'topRight',
			type = 'error',
			timeout = 3500
		}
	)
end

AddEventHandler(
	'framework:notif:NoPerms',
	function()
		NoPerms()
	end
)

function NoPerms()
	exports.pNotify:SendNotification(
		{
			text = Config['CommonStrings'].noperms,
			layout = 'topRight',
			type = 'error',
			timeout = 3500
		}
	)
end

AddEventHandler(
	'framework:notif:TerminatedMessage',
	function()
		TerminatedMessage()
	end
)

function TerminatedMessage()
	exports.pNotify:SendNotification(
		{
			text = Config['CommonStrings'].terminated,
			layout = 'topRight',
			type = 'error',
			timeout = 3500
		}
	)
end

AddEventHandler(
	'framework:notif:NotInService',
	function()
		NotInService()
	end
)

function NotInService()
	exports.pNotify:SendNotification(
		{
			text = Config['CommonStrings'].notonduty,
			layout = 'topRight',
			type = 'error',
			timeout = 3500
		}
	)
end

AddEventHandler(
	'framework:notif:VehicleWhitelist',
	function()
		VehicleWhitelist()
	end
)

function VehicleWhitelist()
	exports.pNotify:SendNotification(
		{
			text = Config['CommonStrings'].nopermsvehs,
			layout = 'topRight',
			type = 'error',
			timeout = 3500
		}
	)
end

AddEventHandler(
	'framework:notif:CustomMessage',
	function(message)
		CustomMessage(message)
	end
)

function CustomMessage(message)
	exports.pNotify:SendNotification(
		{
			text = message,
			layout = 'topRight',
			type = 'error',
			timeout = 3500
		}
	)
end
