RegisterNetEvent('framework:spawnPlayer')
RegisterNetEvent('framework:revall')
RegisterNetEvent('framework:rev')

local spawnPoints = {
    [1] = {x = 1152.35, y = -1528.03, z = 34.84, h = 328.56},
    [2] = {x = -496.74, y = -336.28, z = 34.5, h = 260.64},
    [3] = {x = -247.55, y = 6330.56, z = 32.43, h = 254.02},
    [4] = {x = 346.24, y = -1391.54, z = 32.5, h = 74.35}
}

AddEventHandler(
    'framework:spawnPlayer',
    function()
        local pos = spawnPoints[math.random(#spawnPoints)]
        local player = PlayerId()
        local playerped = PlayerPedId()
        local text =
            GetPlayerName(player) ..
            ' [~p~' .. GetPlayerServerId(player) .. '~w~] ' .. 'Discord ~w~- ' .. Config['discord'].serverlink
        AddTextEntry('FE_THDR_GTAO', '~p~' .. Config['server'].servername .. ' ~w~| ' .. text)
        SetEntityCoords(playerped, pos.x, pos.y, pos.z)
        SetEntityHeading(playerped, pos.h)
        ShutdownLoadingScreen()
        ShutdownLoadingScreenNui()
        NetworkSetFriendlyFireOption(true)
        SetCanAttackFriendly(player, true, true)
        SetPoliceIgnorePlayer(player, true)
        SetDispatchCopsForPlayer(player, false)
        SetMaxWantedLevel(0)
        NetworkSetTalkerProximity(8.0)
        exports.spawnmanager:setAutoSpawn(false)
    end
)

AddEventHandler(
    'framework:revall',
    function()
        local player = PlayerPedId()
        if IsEntityDead(player) then
            revivePed(player)
        else
            return
        end
    end
)

AddEventHandler(
    'framework:rev',
    function(target)
        local player = PlayerPedId()
        if IsEntityDead(player) then
            revivePed(player)
        else
            return
        end
    end
)

function revivePed(player)
    NetworkResurrectLocalPlayer(GetEntityCoords(player), true, true, false)
    SetPlayerInvincible(player, false)
    ClearPedBloodDamage(player)
end

function respawnPed(player)
    NetworkResurrectLocalPlayer(math.random(#spawnPoints), true, true, false)
    SetPlayerInvincible(player, false)
    ClearPedBloodDamage(player)
end
