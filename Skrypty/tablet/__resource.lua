resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

ui_page 'ui/index.html'
files {
  'ui/index.html',
  'ui/style.css',
  'ui/img/logo.png',
  'ui/img/tablet.png',
  'ui/script.js',
  'ui/vcr.ttf'
}

client_script "client.lua"
server_scripts {

  '@mysql-async/lib/MySQL.lua',
  'server.lua'
}