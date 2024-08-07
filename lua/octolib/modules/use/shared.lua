if CFG.disabledModules.use then return end

local Player = FindMetaTable('Player')

function Player:GetEyeTraceLimited(length)
	local aim = self:EyeAngles():Forward()
	local t = {}

	t.start = self:GetShootPos()
	t.endpos = t.start + aim * length
	t.filter = { self }

	hook.Run('octolib.eyeTraceFilter', self, t.filter)

	return util.TraceLine(t)
end

octolib.use = octolib.use or {}

function octolib.use.getTrace(ply)
	return ply:GetEyeTraceLimited(CFG.useDist)
end

-- function octolib.use.check(ply, ent)
-- 	if not IsValid(ply) or not IsValid(ent) then return false end

-- 	local tr = octolib.use.getTrace(ply)

-- 	return tr.Entity == ent
-- end
