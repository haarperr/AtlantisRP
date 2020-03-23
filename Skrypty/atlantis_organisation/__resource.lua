resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Atlantis skrypt na mafie 2HeadPepegaLUL'

version '5.2.3'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

client_scripts {
	'client.lua'
}

dependencies {
	'es_extended',
	'esx_addonaccount',
	'esx_addoninventory',
	'esx_datastore'
}