RegisterNUICallback('new-or-continue-chat', function(body, cb)
    lib.callback('z-phone:server:StartOrContinueChatting', false, function(chatting)
        cb(chatting)
    end, body)
end)

RegisterNUICallback('get-chats', function(_, cb)
    lib.callback('z-phone:server:GetChats', false, function(chats)
        cb(chats)
    end)
end)

RegisterNUICallback('get-chatting', function(body, cb)
    lib.callback('z-phone:server:GetChatting', false, function(chatting)
        cb(chatting)
    end, body)
end)

RegisterNUICallback('sendLocation', function(_, cb)
    local myPos = GetEntityCoords(PlayerPedId())
    local message = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
    cb(message)
end)

RegisterNUICallback('getLocation', function(data, cb)
    local x, y = data.message:match("GPS: ([%-%d%.]+), ([%-%d%.]+)")

    if x and y then
        x = tonumber(x)
        y = tonumber(y)

        SetNewWaypoint(x, y)
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = "Message",
            message = "Waypoint Sudah Di Set Di GPS"
        })
    else
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = "Message",
            message = "Koordinat tidak valid"
        })
    end
    
    cb("ok")
end)

RegisterNUICallback('send-chatting', function(body, cb)
    if not IsAllowToSendOrCall() then
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = Config.App.InetMax.Name,
            message = Config.MsgSignalZone
        })
        cb(false)
        return
    end
    
    if Profile.inetmax_balance < Config.App.InetMax.InetMaxUsage.MessageSend then
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = Config.App.InetMax.Name,
            message = Config.MsgNotEnoughInternetData
        })
        cb(false)
        return
    end

    lib.callback('z-phone:server:SendChatting', false, function(isOk)
        TriggerServerEvent("z-phone:server:usage-internet-data", Config.App.Message.Name, Config.App.InetMax.InetMaxUsage.MessageSend)
        cb(isOk)
    end, body)
end)

RegisterNUICallback('delete-message', function(body, cb)
    lib.callback('z-phone:server:DeleteMessage', false, function(isOk)
        cb(isOk)
    end, body)
end)

RegisterNUICallback('create-group', function(body, cb)
    lib.callback('z-phone:server:CreateGroup', false, function(isOk)
        if (isOk) then
            TriggerEvent("z-phone:client:sendNotifInternal", {
                type = "Notification",
                from = "Message",
                message = "Group chat created!"
            })
        end
        cb(isOk)
    end, body)
end)