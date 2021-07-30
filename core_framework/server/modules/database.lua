RegisterServerEvent('framework:CharacterChosen')
RegisterServerEvent('framework:DeleteCharacter')
RegisterServerEvent('framework:saveNewIdentity')
RegisterServerEvent('framework:saveIdentity')
RegisterServerEvent('framework:getchars')
RegisterServerEvent('framework:registerveh')

activeChars = {}

AddEventHandler(
    'framework:saveIdentity',
    function(data)
        updateIdentityToDatabase(data, source)
    end
)

AddEventHandler(
    'framework:getchars',
    function()
        local source = source
        if source > 0 then
            GetPlayerCharacters(source)
        else
            print(Config['server'].serverprefix .. 'Error with event getchars.')
        end
    end
)

AddEventHandler(
    'framework:registerveh',
    function(data)
        print('test')
        if source > 0 and data then
            RegisterVeh(source, data)
        else
            print(Config['server'].serverprefix .. 'Error with event registerveh.')
        end
    end
)

AddEventHandler(
    'framework:DeleteCharacter',
    function(charid)
        if charid then
            local source = source
            DeleteCharacter({source = source, charid = charid})
            Citizen.Wait(1000)
            local Characters = GetPlayerCharacters(source)
            TriggerClientEvent('mainmenu:openUI', source, Characters)
        else
            print(Config['server'].serverprefix .. 'Error with event DeleteCharacter.')
        end
    end
)

AddEventHandler(
    'framework:saveNewIdentity',
    function(data)
        if data then
            insertNewIdentityToDatabase(data, source)
            RequestCharacter(data.charid, source)
        else
            print(Config['server'].serverprefix .. 'Error with event saveNewIdentity.')
        end
    end
)

function GetActiveChar(source)
    if source then
        local src = source
        local license = GetPlayerIdentifierFromType('license', src)
        local charid = activeChars[license].charid
        print('Active Char ' .. charid)
        return charid
    else
        print(Config['server'].serverprefix .. 'Error with setActive.')
    end
end

function setActive(data)
    if data then
        local license = GetPlayerIdentifierFromType('license', data.source)
        activeChars[license] = {charid = data.charid}
    else
        print(Config['server'].serverprefix .. 'Error with setActive.')
    end
end

function setUnActive(source)
    if source then
        local src = source
        local license = GetPlayerIdentifierFromType('license', src)
        if activeChars[license] then
            activeChars[license] = nil
        else
            return
        end
    else
        print(Config['server'].serverprefix .. 'Error with setUnActive.')
    end
end

function CheckVehWhitelist(data)
    if data then
        exports.ghmattimysql:execute(
            'SELECT `rank` FROM `vehicles` WHERE model = @model',
            {
                ['@model'] = data.hash
            },
            function(result)
                if data.rank < result[1].rank then
                    DeleteEntity(data.id)
                    TriggerClientEvent(
                        'framework:notif:CustomMessage',
                        data.source,
                        Config['CommonStrings'].nopermsvehs
                    )
                    return
                else
                    return
                end
            end
        )
    else
        print(Config['server'].serverprefix .. 'Error with CheckVehWhitelist.')
    end
end

function GetUserRank(data)
    if data then
        local license = GetPlayerIdentifierFromType('license', data.source)
        exports.ghmattimysql:execute(
            'SELECT `rank` FROM `xpsystem` WHERE license = @license',
            {['@license'] = license},
            function(result)
                local rank = result[1].rank
                data['rank'] = rank
                data.callback(data)
            end
        )
    else
        print(Config['server'].serverprefix .. 'Error with GetUserRank.')
    end
end

function GetUserXP(data)
    if data then
        local license = GetPlayerIdentifierFromType('license', data.source)
        exports.ghmattimysql:execute(
            'SELECT `xp` FROM `xpsystem` WHERE license = @license',
            {['@license'] = license},
            function(result)
                if result[1] == nil then
                    exports.ghmattimysql:execute(
                        'INSERT INTO xpsystem (`license`, `rank`, `xp`) VALUES (@license, @rank, @xp);',
                        {
                            ['@license'] = license,
                            ['@rank'] = 0,
                            ['@xp'] = 0
                        },
                        function(result)
                            data['xp'] = 0
                            data.callback(data)
                        end
                    )
                else
                    local xp = result[1].xp
                    data['xp'] = xp
                    data.callback(data)
                end
            end
        )
    else
        print(Config['server'].serverprefix .. 'Error with GetUserXP.')
    end
end

function initXP(data)
    if data then
        TriggerClientEvent('XNL_NET:XNL_SetInitialXPLevels', data.source, data.xp, true, false)
    else
        print(Config['server'].serverprefix .. 'Error with initXP.')
    end
end

function AddXP(source, value)
    if source and value then
        local src = source
        local value = value
        Citizen.Wait(5000)
        local license = GetPlayerIdentifierFromType('license', source)
        exports.ghmattimysql:execute(
            'SELECT `xp` FROM `xpsystem` WHERE license = @license',
            {['@license'] = license},
            function(result)
                local xpcur = result[1].xp
                local xpafter = xpcur + value
                local rank = XNL_GetLevelFromXP(xpafter)
                TriggerClientEvent('XNL_NET:AddPlayerXP', source, value)
                exports.ghmattimysql:execute(
                    'UPDATE `xpsystem` SET xp = @xp, rank = @rank WHERE license = @license',
                    {
                        ['@license'] = license,
                        ['@xp'] = xpafter,
                        ['@rank'] = rank
                    }
                )
            end
        )
    else
        print(Config['server'].serverprefix .. 'Error with AddXP.')
    end
end

function RemoveXP(target, value)
    if target and value then
        local license = GetPlayerIdentifierFromType('license', target)
        exports.ghmattimysql:execute(
            'SELECT `xp` FROM `xpsystem` WHERE license = @license',
            {['@license'] = license},
            function(result)
                local xpcur = result[1].xp
                local xpafter = xpcur - value
                local rank = XNL_GetLevelFromXP(xpafter)
                TriggerClientEvent('XNL_NET:RemovePlayerXP', target, value)
                exports.ghmattimysql:execute(
                    'UPDATE `xpsystem` SET xp = @xp, rank = @rank WHERE license = @license',
                    {
                        ['@license'] = license,
                        ['@xp'] = xpafter,
                        ['@rank'] = rank
                    }
                )
            end
        )
    else
        print(Config['server'].serverprefix .. 'Error with RemoveXP.')
    end
end

function insertNewIdentityToDatabase(data, source)
    if data and source then
        local src = source
        local license = GetPlayerIdentifierFromType('license', src)
        exports.ghmattimysql:execute(
            'INSERT INTO users (`license`, `charid`, `firstname`, `lastname`, `dateofbirth`, `weight`, `height`, `sex`, `desc`, `attr`, `salicense`, `endorsements`) VALUES (@license, @charid, @firstname, @lastname, @dateofbirth, @weight, @height, @sex, @desc, @attr, @salicense, @endorsements);',
            {
                ['@license'] = license,
                ['@charid'] = data.charid,
                ['@firstname'] = data.firstname,
                ['@lastname'] = data.lastname,
                ['@dateofbirth'] = data.dob,
                ['@weight'] = data.weight,
                ['@height'] = data.height,
                ['@sex'] = data.sex,
                ['@desc'] = data.desc,
                ['@attr'] = data.attr,
                ['@salicense'] = data.license,
                ['@endorsements'] = data.m .. ' ' .. data.cdl
            }
        )
    else
        print(Config['server'].serverprefix .. 'Error with insertNewIdentityToDatabase.')
    end
end

function updateIdentityToDatabase(data, source)
    if data and source then
        local src = source
        local license = GetPlayerIdentifierFromType('license', src)
        local charid = activeChars[license].charid

        exports.ghmattimysql:execute(
            'UPDATE `users` SET firstname = @firstname, lastname = @lastname, dateofbirth = @dateofbirth, weight = @weight, sex = @sex, height = @height, salicense = @salicense, endorsements = @endorsements WHERE license = @license AND charid = @charid',
            {
                ['@license'] = license,
                ['@charid'] = charid,
                ['@firstname'] = data.firstname,
                ['@lastname'] = data.lastname,
                ['@dateofbirth'] = data.dob,
                ['@sex'] = data.sex,
                ['@height'] = data.height,
                ['@weight'] = data.weight,
                ['@salicense'] = data.salicense,
                ['@endorsements'] = data.m .. ' ' .. data.cdl
            }
        )
    else
        print(Config['server'].serverprefix .. 'Error with updateIdentityToDatabase.')
    end
end

function GetPlayerCharacters(source)
    if source then
        local src = source
        local license = GetPlayerIdentifierFromType('license', src)
        exports.ghmattimysql:execute(
            'SELECT * FROM `users` WHERE license = @license',
            {['license'] = license},
            function(Characters)
                TriggerClientEvent('mainmenu:openUI', src, Characters)
            end
        )
    else
        print(Config['server'].serverprefix .. 'Error with GetPlayerCharacters.')
    end
end

function DeleteCharacter(data)
    if data then
        local license = GetPlayerIdentifierFromType('license', data.source)
        exports.ghmattimysql:execute(
            'DELETE FROM users WHERE license = @license AND charid = @charid',
            {['@license'] = license, ['charid'] = data.charid}
        )
    else
        print(Config['server'].serverprefix .. 'Error with DeleteCharacter.')
    end
end
