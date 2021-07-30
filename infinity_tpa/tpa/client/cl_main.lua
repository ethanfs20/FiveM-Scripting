local fadeTime = 1000

RegisterNetEvent("tpa:recieveRequest")
AddEventHandler(
	"tpa:recieveRequest",
	function(requestData)
		TriggerEvent(
			"_tpa:showMessage",
			"Teleport request from " ..
				requestData.name ..
					" [" .. requestData.id .. "] (/tpaccept " .. requestData.id .. ") (" .. requestData.requestTimeout .. " seconds)"
		)
	end
)

RegisterNetEvent("_tpa:setCoords")
AddEventHandler(
	"_tpa:setCoords",
	function(coords)
		Citizen.CreateThread(
			function()
				local playerPed = PlayerPedId()
				DoScreenFadeOut(fadeTime)
				Citizen.Wait(fadeTime)
				SetEntityCoords(playerPed, coords.x, coords.y, coords.z, false, false, false, false)
				TriggerEvent("_tpa:showMessage", "You were teleported.")
				DoScreenFadeIn(fadeTime)
			end
		)
	end
)

RegisterNetEvent("_tpa:showMessage")
AddEventHandler(
	"_tpa:showMessage",
	function(message)
		TriggerEvent(
			"chat:addMessage",
			{
				args = {
					"[TPA]",
					message
				},
				color = {255, 100, 100}
			}
		)
	end
)
