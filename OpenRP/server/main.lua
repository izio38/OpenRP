i18n.setLang(OpenRp.Config["Lang"])
ConnectedUsers = {}

AddEventHandler('playerConnecting', function(playerName, setKickReason)
    local source = source

    --Si Steam est obligatoire:
    if OpenRp.Config["Steam"] == 1 then
    	local isUsingSteam = IsUserUsingSteam(GetPlayerIdentifiers(source)[1])

    	if not(isUsingSteam) then
    		setKickReason(i18n.translate("SteamMustBeLaunched"))
        	CancelEvent()
    	end
    end

    --Si la whiteliste est activée:
    if OpenRp.Config["WhiteListe"] == 1 then
    	local isWhiteListed = IsUserWhiteListed(GetPlayerIdentifiers(source)[1])

    	if not(isWhiteListed) then
    		setKickReason(i18n.translate("NeedToBeWhiteLited"))
        	CancelEvent()
    	end
    end

    LoadUser(source)
    -- On load l'utilisateur ici, on a passé les deux vérifs (si elles sont parametrées.)
end)

AddEventHandler('playerDropped', function()
    local source = source
    if ConnectedUsers[source] then
    	ConnectedUsers[source].setSessionVar('userInTransition', true)
    	TriggerEvent("ORP:playerDisconnected", ConnectedUsers[source])
    	SetTimeout(10000, function() -- on laisse 10 secondes pour laisser les resources traiter des donnèes.
    		DebugMessage("L'utilisateur: " .. ConnectedUsers[source].get('name') .. " identifié par: " .. ConnectedUsers[source].get('identifier') .. " vient de se déconnecter.")
    		ConnectedUsers[source] = nil
    	end)
    end
end)

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

-- Sauvegarde:
Citizen.CreateThread(function()
	while true do
		Wait(OpenRp.Config["SavingTime"])

		TriggerEvent("ORP:getPlayers", function(Users)

			for k, v in pairs(Users) do

				if v.get('haveChanged') == 1 then
					MySQL.Async.execute("UPDATE user_data SET user_money = @money, user_bank_money = @bank, user_work = @job WHERE user_id = @id",
					{
						["@money"] = v.get('money'),
						["@bank"] = v.get('bankMoney'),
						["@job"] = v.get('job'),
						["@id"] = v.get('id')
					})
					DebugMessage("Un utilisateur sauvegardé!")
				end
			end
		end)
	end
end)

-- Fonctions utilitaires:
function DebugMessage(message)
	if OpenRp.Config["DebugMsg"] == 1 then
		print(message)
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