local chPosOff, chAngOff = Vector(0, 0, 0), Angle(0, -90, 90)

local function postDrawTranslucentRenderables()

	local ply = LocalPlayer()

    if ply:GetViewEntity() ~= ply then return end

	local override = hook.Run('octolib.delay.chShouldDraw', ply)
	if not override then return end

	local veh = ply:GetVehicle()
	local eyeAng = IsValid(veh) and veh:LocalToWorldAngles(ply:EyeAngles()) or ply:EyeAngles()

	local aim = eyeAng:Forward()
	local tr = hook.Run('octolib.delay.chTraceOverride')
	if not tr then
		local pos = ply:GetShootPos()
		local endpos = pos + aim * 2000
		tr = util.TraceLine({
			start = pos,
			endpos = endpos,
			filter = function(ent)
				return ent ~= ply and ent:GetRenderMode() ~= RENDERMODE_TRANSALPHA
			end
		})
	end

	local _icon, _alpha, _scale = hook.Run('octolib.delay.chOverride', tr)
	-- local n = tr.Hit and tr.HitNormal or -aim
	-- if math.abs(n.z) > 0.98 then
	-- 	n:Add(-aim * 0.01)
	-- end
	local chPos, chAng = LocalToWorld(chPosOff, chAngOff, tr.HitPos or endpos, eyeAng)
	cam.Start3D2D(chPos, chAng, math.pow(tr.Fraction, 0.5) * (_scale or 0.23))
	cam.IgnoreZ(true)
	if not hook.Run('octolib.delay.chPaint', tr, _icon) then return end
	cam.IgnoreZ(false)
	cam.End3D2D()

end

hook.Add('PostDrawTranslucentRenderables', 'octolib.delay', postDrawTranslucentRenderables)

local delays = {}

surface.CreateFont('octolib.use', {
	font = 'Calibri',
	extended = true,
	size = 82,
	weight = 350,
})

netstream.Hook('octolib.delay', function(id, active, text, time)

	local id = id
	local active = active

	if active then
		delays[id] = {
			text = text,
			start = CurTime(),
			time = time - CurTime(),
		}
	else
		delays[id] = nil
	end

end)

local cx, cy = 0, 0
local size = 40
local p1, p2 = {}, {}
for i = 1, 36 do
	local a1 = math.rad((i-1) * -10 + 180)
	local a2 = math.rad(i * -10 + 180)
	p1[i] = { x = cx + math.sin(a1) * (size + 5), y = cy + math.cos(a1) * (size + 5) }
	p2[i] = {
		{ x = cx, y = cy },
		{ x = cx + math.sin(a1) * size, y = cy + math.cos(a1) * size },
		{ x = cx + math.sin(a2) * size, y = cy + math.cos(a2) * size },
	}
end

local override
hook.Add('octolib.delay.chShouldDraw', 'octolib.delay', function()

	override = table.Count(delays) > 0
	if override then return true end

end)

hook.Add('octolib.delay.chPaint', 'octolib.delay', function(tr, icon)

	for id, data in pairs(delays) do
		local segs = math.min(math.ceil((CurTime() - data.start) / data.time * 36), 36)
		local text = data.text .. ('.'):rep(math.floor(CurTime() * 2 % 4))
		draw.SimpleTextOutlined(text, 'octolib.use', 0 + 60, 0, Color(255, 255, 255, 150), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 230))

		draw.NoTexture()
		surface.SetDrawColor(0, 0, 0, 230)
		surface.DrawPoly(p1)

		surface.SetDrawColor(255,255,255, 150)
		for i = 1, segs do
			surface.DrawPoly(p2[i])
		end

		return true
	end

end)

hook.Add('octolib.delay.chOverride', 'octolib.delay', function(tr, icon)

	local ply = LocalPlayer()
	local veh = ply:GetVehicle()

	if override and (not tr.Hit or tr.Fraction > 0.03) then
		local aim = ( IsValid(veh) and veh:LocalToWorldAngles(ply:EyeAngles()) or ply:EyeAngles() ):Forward()
		
		tr.HitPos = ply:GetShootPos() + aim * 60
		tr.HitNormal = -aim
		tr.Fraction = 0.03
	end

end)

hook.Add('StartCommand', 'octolib.delay.blockKey', function(ply, cmd)

	local wep = ply:GetActiveWeapon()
	if not IsValid(wep) or not wep.AimPos then return end

    if table.Count(delays) > 0 then
        cmd:RemoveKey(IN_ATTACK2)
    end

end)