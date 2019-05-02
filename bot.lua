local discordia = require('discordia')
local client = discordia.Client()
local config = require('config')
local TOKEN = config.token
local coro_wrap = coroutine.wrap
local fs = require('coro-fs')
local scandir = fs.scandir
local commands = require('./utils/commands.lua')

coro_wrap(function()
   for f in scandir('commands') do
      print('Loading ' .. f.name)
      commands:add(f.name)
   end
end)()

client:on('ready', function()
   print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
   commands:run(message)
end)

client:run(TOKEN)
