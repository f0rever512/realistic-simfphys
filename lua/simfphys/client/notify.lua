net.Receive('lrp.cars-notify', function(len, ply)
    local int = net.ReadInt(4)

    if int == 1 then
        notification.AddLegacy('Нужно отстегнуть ремень', NOTIFY_ERROR, 2)
    elseif int == 2 then
        notification.AddLegacy('Нужно подождать, пока ремень отстегивается', NOTIFY_GENERIC, 3)
    elseif int == 3 then
        notification.AddLegacy('Что-то мешает выйти из автомобиля', NOTIFY_ERROR, 3)
    else
        notification.AddLegacy('Нельзя пересаживаться на ходу', NOTIFY_ERROR, 3)
    end
    surface.PlaySound('buttons/lightswitch2.wav')
end)