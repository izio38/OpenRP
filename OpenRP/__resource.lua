resource_type 'gametype' { name = 'default fivem server' }

server_scripts {
	"server/main.lua",
	"@mysql-async/lib/MySQL.lua",
	"config.lua"
}

client_scripts {
	"client/main.lua",
	"config.lua"
}

files {
	--'meta/mapzoomdata.meta'
}