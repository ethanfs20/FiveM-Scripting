-- ███████╗██╗░░░██╗███████╗███╗░░██╗████████╗░██████╗
-- ██╔════╝██║░░░██║██╔════╝████╗░██║╚══██╔══╝██╔════╝
-- █████╗░░╚██╗░██╔╝█████╗░░██╔██╗██║░░░██║░░░╚█████╗░
-- ██╔══╝░░░╚████╔╝░██╔══╝░░██║╚████║░░░██║░░░░╚═══██╗
-- ███████╗░░╚██╔╝░░███████╗██║░╚███║░░░██║░░░██████╔╝
-- ╚══════╝░░░╚═╝░░░╚══════╝╚═╝░░╚══╝░░░╚═╝░░░╚═════╝░

RegisterServerEvent('framework:SinitPlayer')
RegisterServerEvent('framework:dvserver')
RegisterServerEvent('framework:DisconnectPlayer')
RegisterServerEvent('framework:checkVehicle')
RegisterServerEvent('framework:setxploop')

local PermTracker = {}

AddEventHandler(
	'framework:DisconnectPlayer',
	function()
		local src = source
		DropPlayer(src, 'You have disconnected from the server.')
	end
)

AddEventHandler(
	'framework:dvserver',
	function(id)
		local id = NetworkGetEntityFromNetworkId(id)
		DeleteEntity(id)
	end
)

AddEventHandler(
	'framework:checkVehicle',
	function(data)
		local src = source
		local id = NetworkGetEntityFromNetworkId(data.id)
		local data = {hash = data.hash, id = id, callback = CheckVehWhitelist, source = src}
		GetUserRank(data)
	end
)

AddEventHandler(
	'framework:setxploop',
	function()
		local src = source
		AddXP(src, Config['XPSYSTEM'].xploop)
	end
)

AddEventHandler(
	'framework:SinitPlayer',
	function()
		local src = source
		setActive({source = src, charid = charid})
        GetCharacterInfo(source, charid)
		GetUserXP({source = src, xp = 0, callback = initXP})
		return
	end
)

AddEventHandler(
	'playerDropped',
	function(reason)
		local src = source
		local license = GetPlayerIdentifierFromType('license', src)
		setUnActive(license)
	end
)

AddEventHandler(
	"framework:SinitPlayer",
	function()
		local src = source
		local RoleList = Config.RoleList
		local discordid = GetPlayerIdentifierFromType("discord", src)
		local command = "add_principal identifier." .. discordid .. " "
		if discordid ~= nil then
			local roleIDs = GetDiscordRoles(string.gsub(discordId, 'discord:', ''))
			if roleIDs then
				for i = 1, #RoleList do
					for j = 1, #roleIDs do
						if CheckEqual(RoleList[i][1], roleIDs[j]) then
							print(Config["server"].serverprefix .. GetPlayerName(src) .. " has been added to group " .. RoleList[i][2])
							ExecuteCommand(command .. RoleList[i][2])
							if PermTracker[discordid] ~= nil then
								local list = PermTracker[discordid]
								table.insert(list, RoleList[i][2])
								PermTracker[discordid] = list
							else
								local list = {}
								table.insert(list, RoleList[i][2])
								PermTracker[discordid] = list
							end
						end
					end
				end
				print(Config["server"].serverprefix .. GetPlayerName(src) .. " has been granted their permissions...")
			else
				print(
					Config["server"].serverprefix ..
						GetPlayerName(src) .. " has not gotten permissions because we could not find their roles..."
				)
			end
		else
			print(Config["server"].serverprefix .. GetPlayerName(src) .. " is not in our Discord! BEG HIM TO JOIN!")
		end
		GetUserXP({source = src, xp = 0, callback = initXP})
		return
	end
)

AddEventHandler(
	"playerDropped",
	function(reason)
		local src = source
		local pname = GetPlayerName(src)
		local discord = GetPlayerIdentifierFromType("discord", source)
		if PermTracker[discord] ~= nil then
			local list = PermTracker[discord]
			for i = 1, #list do
				local permGroup = list[i]
				ExecuteCommand("remove_principal identifier.discord:" .. discord .. " " .. permGroup)
				print(Config["server"].serverprefix .. pname .. " from role group " .. permGroup)
			end
			PermTracker[discord] = nil
		end
		setUnActive(license)
	end
)