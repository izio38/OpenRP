ConnectedUsers = {}

AddEventHandler('playerConnecting', function(playerName, setKickReason)
    local source = source

    --Si Steam est obligatoire:
    if OpenRp.Config["Steam"] == 1 then
    	local isUsingSteam = IsUserUsingSteam(GetPlayerIdentifiers(source)[1])

    	if not(isUsingSteam) then
    		setKickReason(OpenRp.Message["SteamMustBeLaunchedMessage"])
        	CancelEvent()
    	end
    end

    --Si la whiteliste est activée:
    if OpenRp.Config["WhiteListe"] == 1 then
    	local isWhiteListed = IsUserWhiteListed(GetPlayerIdentifiers(source)[1])

    	if not(isWhiteListed) then
    		setKickReason(OpenRp.Message["NeedToBeWhiteLitedMessage"])
        	CancelEvent()
    	end
    end

    LoadUser(source)
    -- On load l'utilisateur ici, on a passé les deux vérifs (si elles sont parametrées.)
end)

-- AddEventHandler('') OnPlayerDrop TODO

function LoadUser(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchAll("SELECT * FROM user_data WHERE user_identifier = @identifier",
	{
		["@identifier"] = identifier
	}, function(user)
		local source = source
		local identifier = identifier
		if user then
			ConnectedUsers[source] = CreateUserObject(source, identifier)
		else
			RegisterNewUser(source, identifier)
		end
	end)
end

function RegisterNewUser(source, identifier)
	MySQL.Async.execute("INSERT INTO user_data (user_identifier, user_name, user_money, user_bank_money, user_work) VALUES (@identifier, @playerName, @money, @bankMoney, @job)",
	{
		["@identifier"] = identifier,
		["@playerName"] = GetPlayerName(source),
		["@money"] = OpenRp.firstUserDatas.money,
		["@bankMoney"] = OpenRp.firstUserDatas.bankMoney,
		["@job"] = OpenRp.firstUserDatas.job
	}, function()
		local source = source
		local identifier = identifier

		FetchUserObject(source, identifier)
	end)
end

function IsUserUsingSteam(identifier)
	local resultSplited = StringSplit(identifier)

	if resultSplited == "steam" then
		return true
	else
		return false
	end
end

function IsUserWhiteListed(identifier)
	local result = MySQL.Sync.fetchAll("SELECT * FROM user_whitelist WHERE user_identifier = @identifier", -- On attend la PR de Brouznouf pour faire des Cb en Async auprès d'une fonction.
		{
			["@identifier"] = identifier
		})
	if result[1].user_identifier and result[1].user_whitelisted then
		return true
	else
		return false
	end
end

function StringSplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end

    local t={} ; i=1

    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end

    return t
end