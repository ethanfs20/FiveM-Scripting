RegisterNetEvent("arm:GiveItem")
AddEventHandler(
	"arm:GiveItem",
	function(target, currentAction)
		local index = currentAction
		local source = target
		TriggerClientEvent("arm:RecieveItem", source, index)
	end
)
RegisterNetEvent("tests33")
AddEventHandler(
	"tests33",
	function()
		sendToDiscord("test", "<@204255221017214977> test")
	end
)

link = "https://discord.com/api/webhooks/801678398648090645/5QHr14Albp52gCECijaPfKK6U4S4xunyYibgnhzVU9cZUhGvA9HdRZE7dUm8eRNAhMrj"

function sendToDiscord(name, message)
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
  end