function getPlayerID(source)
	local identifiers = GetPlayerIdentifiers(source)
	local player = getIdentifiant(identifiers)
	return player
end

function getIdentifiant(id)
	for _, v in ipairs(id) do
		return v
	end
end

function setDuty(data)
	local identifier = exports.core_framework:GetPlayerIdentifierFromType("license", data.source)
	MySQL.Async.execute(
		"UPDATE users SET onduty = " .. data.status .. " WHERE identifier LIKE '%" .. identifier .. "%'",
		{}
	)
end
