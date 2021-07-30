-- ███████╗██╗░░░██╗███╗░░██╗░█████╗░████████╗██╗░█████╗░███╗░░██╗░██████╗
-- ██╔════╝██║░░░██║████╗░██║██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝
-- █████╗░░██║░░░██║██╔██╗██║██║░░╚═╝░░░██║░░░██║██║░░██║██╔██╗██║╚█████╗░
-- ██╔══╝░░██║░░░██║██║╚████║██║░░██╗░░░██║░░░██║██║░░██║██║╚████║░╚═══██╗
-- ██║░░░░░╚██████╔╝██║░╚███║╚█████╔╝░░░██║░░░██║╚█████╔╝██║░╚███║██████╔╝
-- ╚═╝░░░░░░╚═════╝░╚═╝░░╚══╝░╚════╝░░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)

    for index, value in ipairs(players) do
        local target = GetPlayerPed(value)
        if (target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance =
                Vdist(
                targetCoords['x'],
                targetCoords['y'],
                targetCoords['z'],
                plyCoords['x'],
                plyCoords['y'],
                plyCoords['z']
            )
            if (closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    return {t = closestPlayer, distance = closestDistance}
end

function GetPedInFront(ped)
    local plyPos = GetEntityCoords(ped, false)
    local plyOffset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.3, 0.0)
    local rayHandle =
        StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, ped, 7)
    local _, _, _, _, ped = GetShapeTestResult(rayHandle)
    return {ped = ped}
end

function GetVehicleAheadOfPlayer(ped)
    local pedcoords = GetEntityCoords(ped, false)
    local pedoffset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 3.0, 0.0)
    local rayHandle =
        StartShapeTestCapsule(
        pedcoords.x,
        pedcoords.y,
        pedcoords.z,
        pedoffset.x,
        pedoffset.y,
        pedoffset.z,
        1.2,
        10,
        ped,
        7
    )
    local returnValue, hit, endcoords, surface, vehicle = GetShapeTestResult(rayHandle)
    if hit then
        return vehicle
    else
        return false
    end
end

function PlayAnimation(ped, dict, anim, length, flag)
    if flag == nil then
        flag = 16
    end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(ped, dict, anim, 8.0, -8.0, length, 120, 0, false, false, false)
end

function GiveLoadout(spawnLoadoutList, ped, spawnLoadoutExtrasList)
    for k, w in pairs(spawnLoadoutList) do
        GiveWeaponToPed(ped, w[1], w[2], false, false)
        SetEntityHealth(ped, 200)
        ClearPedBloodDamage(ped)
        ClearPedWetness(ped)
        SetPedArmour(ped, 100)
    end
    for k, c in pairs(spawnLoadoutExtrasList) do
        GiveWeaponComponentToPed(ped, c[1], c[2])
    end
end
