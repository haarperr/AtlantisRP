resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'AtlantisRP UtilsPack'

version '35.0'

client_scripts {
	'config.lua',
	'client.lua',
	'jobs/dpd/client.lua',
	'jobs/barman/client.lua',
	'jobs/storekeeper/client.lua',
	'hospitalbed/bed_c.lua',
	'hospitalbed/resthouse.lua',
	'jobs/moneywash/client.lua'
}

server_scripts {
	'server.lua',
	'jobs/dpd/server.lua',
	'jobs/barman/server.lua',
	'jobs/storekeeper/server.lua',
	'@mysql-async/lib/MySQL.lua',
	'hospitalbed/bed_s.lua',
	'jobs/moneywash/server.lua'
}