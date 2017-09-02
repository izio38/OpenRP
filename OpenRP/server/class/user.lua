function FetchUserObject(source, identifier)
	MySQL.Async.fetchAll("SELECT * FROM user_data WHERE user_identifier = @identifier", 
	{
		["@identifier"] = identifier
	}, function(user)
		local source = source
		CreateUserObject(source, user[1])
	end)
end

local function CreateUserObject(source, user)
	local self = {
		id = user.user_id,
		identifier = user.user_identifier
		name = user.user_name
		firstConnectionAt = user.user_created_at,
		lastConnectionAt = user.user_updated_at,
		money = user.user_money
		bankMoney = user.user_bank_money,
		job = user.user_work
		haveChanged = false
	}

	local Methods = {
	-- Getter et Setter méthode
		get = function(key)
			if self[key] then
				return self[key]
			else
				print("Pas de clef ayant pour index : " .. tostring(key))
				return nil
			end
		end,

		set = function(key, value)
			if self[key] then
				self[key] = value
				self.haveChanged = true
			else
				print("Pas de clef ayant pour index : " .. tostring(key))
				return nil
			end
		end,

	-- Money setter:
		addMoney = function(key, value)
			if value ~= nil and ( type(value) == "number" or type(value) == "string" ) then
				value = math.abs(tonumber(value))
			else
				print("Erreur addMoney methode: un nombre ou un string est attendu.")
				return false
			end

			self.money = self.money + value
			self.haveChanged = true

			-- TriggerClientEvent("OP:addMoney", self.source, self.money) TODO
			
			return true
			
		end,

		removeMoney = function(key, value)
			if value ~= nil and ( type(value) == "number" or type(value) == "string" ) then
				value = math.abs(tonumber(value))
			else
				print("Erreur removeMoney methode: un nombre ou un string est attendu.")
				return false
			end

			self.money = self.money - value
			self.haveChanged = true
			-- TriggerClientEvent("OP:removeMoney", self.source, self.money) TODO
			return true
		end

		setMoney = function(key, value)
			if value ~= nil and ( type(value) == "number" or type(value) == "string" ) then
				value = math.abs(tonumber(value))
			else
				print("Erreur setMoney methode: un nombre ou un string est attendu.")
				return false
			end

			if self.money > value then
				-- TriggerClientEvent("OP:removeMoney", self.source, self.money) TODO
			else
				-- TriggerClientEvent("OP:addMoney", self.source, self.money) TODO
			end

			self.money = value
			self.haveChanged = true
			return true
		end
	}

	return Methods
end