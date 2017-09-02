i18n.setLang(OpenRp.Config["Lang"])
local connectedUsers = {}

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

    -- On load l'utilisateur ici, on a passé les deux vérifs (si elles sont parametrées.)
end)

function IsUserUsingSteam(identifier)
	local resultSplited = StringSplit(identifier)

	if resultSplited == "steam" then
		return true
	else
		return false
	end
end

function IsUserWhiteListed(identifier)
	local result = MySQL.Sync.fetchAll("SELECT * FROM user_data WHERE user_id = @identifier", -- On attend la PR de Brouznouf pour faire des Cb en Async auprès d'une fonction.
		{
			["@identifier"] = identifier
		})
	if result[1].user_id and result[1].user_whitelisted then
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