CFG = CFG or {}

CFG.disabledModules = {
	-- moduleName = true,
}
CFG.useDist = 84
CFG.useDistSqr = CFG.useDist * CFG.useDist

if SERVER then
    CFG.use = CFG.use or {}
    hook.Add('octolib.use-loadConfig', 'octolib', function()
        local fs, _ = file.Find('config/octolib-use/*.lua', 'LUA')
        for _, f in pairs(fs) do
            fname = 'config/octolib-use/' .. string.StripExtension(f)
            octolib.server(fname)
        end
    end)
end