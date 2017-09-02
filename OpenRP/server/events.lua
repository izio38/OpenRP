AddEventHandler("ORP:getPlayer", function(playerServerId, callback)
	if ConnectedUsers[playerServerId] then
		if not(ConnectedUsers[playerServerId].getSessionVar("userInTransition")) then
			callback(ConnectedUsers[playerServerId])
		else
			callback(nil)
		end
	else
		callback(nil)
	end
end)

AddEventHandler("ORP:getPlayers", function(playerServerId, callback)
	local returnedUsers = {}
	for k, v in pairs(ConnectedUsers) do
		if v ~= nil and not(v.getSessionVar("userInTransition")) then
			table.insert(returnedUsers, v)
		end
	end

	if #returnedUsers ~= 0 then
		callback(returnedUsers)
	else
		callback(nil)
	end
end)