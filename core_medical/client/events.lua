RegisterNetEvent("fireems:forceduty")
RegisterNetEvent("fireems:setperms")

AddEventHandler(
	"onClientMapStart",
	function()
		blipenable()
		return
	end
)

AddEventHandler(
	"fireems:forceduty",
	function()
		if terminated then
			terminated = false
		else
			ServiceOff()
			terminated = true
			duty = false
			exports.pNotify:SendNotification({text = "You have been terminated from service. Report back to the office. ", type = "info", timeout = 1000})
		end
		return
	end
)

AddEventHandler(
	"fireems:setperms",
	function()
		permissions = true
	end
)