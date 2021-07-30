local extract = {} -- This table contains the data from users.json when extracted. / Also gets updated whenever a new player joing / players values get updated.
local loadFile = LoadResourceFile(GetCurrentResourceName(), 'users.json')

AddEventHandler( -- When the resource starts for the player, extract the data from the json file and insert into the table extract.
    'onResourceStart',
    function(hud)
        extract = json.decode(loadFile) or {}
    end
)

RegisterCommand(
    'tt',
    function(source)
        TriggerEvent('hud:setplayer', source)
    end
)

-- this is called when the player spawns into the map.
RegisterNetEvent('hud:setplayer')
AddEventHandler(
    'hud:setplayer',
    function(src)
        local license = exports.core_framework:GetPlayerIdentifierFromType('license', src)
        if extract[license] then
            local data = extract[license]
            print('here')
            TriggerClientEvent('hud:sethud', src, data)
        else
            CreateEntry(license, Config.defaults)
        end
    end
)
-- This is called from the client side whenever a client finished editing an element.
RegisterNetEvent('hud:save')
AddEventHandler(
    'hud:save',
    function(default, positions)
        local source = source
        local license = exports.core_framework:GetPlayerIdentifierFromType('license', source)
        if default then
            CreateEntry(license, Config.defaults)
        else
            CreateEntry(license, positions)
        end
        TriggerEvent('hud:setplayer', source)
    end
)

-- Used to create a new entry for the user.
function CreateEntry(license, positions)
    extract[license] = positions
    SaveResourceFile(GetCurrentResourceName(), 'users.json', json.encode(extract), -1)
end
