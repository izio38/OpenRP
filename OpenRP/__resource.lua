resource_type 'gametype' { name = 'default fivem server' }

server_scripts {
	"server/main.lua",
	"config/main.lua",

	-- LIBRARIES
	"@mysql-async/lib/MySQL.lua",
	"lib/i18n.lua",

	-- LOCALES
	'config/locales/en-GB.lua',
	'config/locales/fr-FR.lua',
}

client_scripts {
	"client/main.lua",
	"config/main.lua",

	-- LIBRARIES
	"lib/i18n.lua",

	-- LOCALES
	'config/locales/en-GB.lua',
	'config/locales/fr-FR.lua',
}

files {
	--'meta/mapzoomdata.meta'
}