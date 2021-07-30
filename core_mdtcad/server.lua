RegisterNetEvent("mdt:searchname")
RegisterNetEvent("mdt:searchcar")

AddEventHandler(
	"mdt:searchname",
	function(data)
		local source = source
		if source then
			exports.ghmattimysql:execute(
				"SELECT * FROM `users` WHERE firstname LIKE '%' @firstname '%' AND lastname LIKE '%' @lastname '%'",
				{
					["@firstname"] = data.firstname,
					["@lastname"] = data.lastname
				},
				function(result)
					if result[1] ~= nil then
						TriggerClientEvent("mdt:nameResult", source, result)
					else
						TriggerClientEvent("mdt:nameResult", source, false)
					end
				end
			)
		else
			print(Config["server"].serverprefix .. "Error with event mdt:searchname.")
		end
	end
)

AddEventHandler(
	"mdt:searchcar",
	function(data)
		local source = source
		if source then
			exports.ghmattimysql:execute(
				"SELECT * FROM `registeredvehs` WHERE licenseplate = @licenseplate",
				{
					["@licenseplate"] = data.licenseplate
				},
				function(result)
					if result[1] ~= nil then
						TriggerClientEvent("mdt:nameResult", source, result)
					else
						TriggerClientEvent("mdt:nameResult", source, false)
					end
				end
			)
		else
			print(Config["server"].serverprefix .. "Error with event mdt:searchcar.")
		end
	end
)
