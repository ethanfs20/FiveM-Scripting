RegisterNetEvent("mdt:nameResult")

local display = false

RegisterCommand(
	"cmd",
	function(source, args)
		SetDisplay(not display)
	end
)

RegisterNUICallback(
	"closesystem",
	function(data)
		SetDisplay(false)
	end
)

RegisterNUICallback(
	"setstatus",
	function(data)
		TriggerServerEvent("police:sendStatus", data.status)
		SetDisplay(false)
	end
)

RegisterNUICallback(
	"search",
	function(data)
		TriggerServerEvent("mdt:searchname", data)
		SetDisplay(not display)
	end
)

AddEventHandler(
	"mdt:nameResult",
	function(result)
		print(result)
		if result ~= false then
			SetDisplay(not display)
			SendNUIMessage(
				{
					type = "nameResult",
					name = "LEGAL NAME: " .. result[1].firstname .. " " .. result[1].lastname,
					sex = "SEX: " .. result[1].sex,
					height = "HEIGHT: " .. result[1].height,
					weight = "WEIGHT: " .. result[1].weight,
					license = "LICENSE: " .. result[1].salicense,
					endorsements = "ENDORSEMENTS: " .. result[1].endorsements
				}
			)
		else
			SetDisplay(not display)
			SendNUIMessage(
				{
					type = "nameResult",
					name = "ERROR: COULD NOT FIND PERSON IN DATABASE."
				}
			)
		end
	end
)

function SetDisplay(bool)
	display = bool
	SetNuiFocus(bool, bool)
	DisableControls()
	SendNUIMessage(
		{
			type = "ui",
			status = bool,
			name = GetPlayerName(PlayerId())
		}
	)
end

function DisableControls()
	Citizen.CreateThread(
		function()
			while display do
				Citizen.Wait(500)
				DisableControlAction(0, 1, display) -- LookLeftRight
				DisableControlAction(0, 2, display) -- LookUpDown
				DisableControlAction(0, 142, display) -- MeleeAttackAlternate
				DisableControlAction(0, 18, display) -- Enter
				DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
				if not display then
					break
				end
			end
		end
	)
end
