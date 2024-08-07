octolib = octolib or {}

-- backwards compatibility
function octolib.server(path)
	path = path .. '.lua'
	if SERVER then include(path) end
end

function octolib.client(path)
	path = path .. '.lua'
	if SERVER then AddCSLuaFile(path) end
	if CLIENT then include(path) end
end

function octolib.shared(path)
	path = path .. '.lua'
	if SERVER then AddCSLuaFile(path) end
	include(path)
end

function octolib.module(path)
	if file.Exists(path .. '/shared.lua', 'LUA') then octolib.shared(path .. '/shared') end
	if file.Exists(path .. '/server.lua', 'LUA') then octolib.server(path .. '/server') end
	if file.Exists(path .. '/client.lua', 'LUA') then octolib.client(path .. '/client') end
end

octolib.shared('octolib/modules/path')
octolib.shared('octolib/modules/include')

octolib.include.files('/octolib/libraries')
octolib.include.modules('/octolib/modules', {
	'!path',
	'!include',
	'netstream',
	'cfg',
	'lang',
	'table',
	'array',
	'string',
	'func',
	'meta',
	'pon',
	'queue',
	'config',
	'api',
	'vars',
	'icons',
	'data-editor',
	'bind',
	'*',
})

-- octolib.msg('Init OK')

hook.Run('octolib.loaded')