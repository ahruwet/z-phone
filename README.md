## Author

<table>
   <tbody>
      <tr>
         <td align="center" valign="top">
            <a href="https://github.com/alfaben12"
                style="text-decoration: none;"
               ><img
               src="https://avatars.githubusercontent.com/u/20008086?v=4"
               width="50px"
               alt="Thariq Alfa"
               /><br /><sub><b>alfaben12</b></sub></a>
         </td>
      </tr>
   </tbody>
</table>

<div align="center">
**Z-Phone**, Modify Add Share location in chat and add location for App service
</div>
<table align="center">
   <tbody>
      <tr>
         <td align="center" valign="top">
            <a href="https://github.com/ahruwet" style="text-decoration: none;">
               <img
                  src="https://avatars.githubusercontent.com/u/85060725?v=4"
                  width="100px"
                  style="border-radius: 50%; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);"
                  alt="Aurindra Maulidzar"
               />
               <br />
               <sub>
                  <b style="font-size: 14px; color: #333;">Aurindra Maulidzar</b>
               </sub>
            </a>
         </td>
      </tr>
   </tbody>
</table>


<h1 align="center">Z-PHONE</h1>
<div align="center">

| ![Image 1](https://i.imgur.com/eYiHbSS.png) | ![Image 2](https://i.imgur.com/bKkunQY.png) | ![Image 3](https://i.imgur.com/EbK3Vsf.png) |
|-------------------------------------------|-------------------------------------------|-------------------------------------------|

</div>


## To USE

**Connect with ambulance job WITH NO USE INET**

```lua
-- OTHERS CODE
function SendDistressSignal()
	local playerPed = PlayerPedId()
    local myPos = GetEntityCoords(playerPed)
    local loc = 'GPS: ' .. myPos.x .. ', ' .. myPos.y

    local body = {
        message = 'ACCIDENT!!!',
        job     = 'ambulance',
        lokasi  = loc
    }

    lib.callback('z-phone:server:SendMessageService', false, function() end, body)
end
-- OTHERS CODE
```

**Connect with ambulance job USE INET**

```lua
-- OTHERS CODE
Profile = {}
RegisterNetEvent('esx:playerLoaded', function()
    ESX.PlayerLoaded = true
    lib.callback('z-phone:server:GetProfile', false, function(profile)
        Profile = profile
    end)
end)
-- OTHERS CODE

-- OTHERS CODE
function SendDistressSignal()
	local playerPed = PlayerPedId()
    local myPos = GetEntityCoords(playerPed)
    local loc = 'GPS: ' .. myPos.x .. ', ' .. myPos.y

    local body = {
        message = 'ACCIDENT!!!',
        job     = 'ambulance',
        lokasi  = loc
    }

    lib.callback('z-phone:server:SendMessageService', false, function(isOk)
        TriggerServerEvent("z-phone:server:usage-internet-data", "Services", math.random(5000, 10000))
        cb(isOk)
    end, body)
end
-- OTHERS CODE
```
