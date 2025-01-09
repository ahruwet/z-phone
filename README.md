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

<h1 align="center">Z-PHONE</h1>
<h2 align="center">Modify Add Share location in chat and add location for App service</h2>

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

<div align="center">

| ![Image 1](https://i.imgur.com/eYiHbSS.png) | ![Image 2](https://i.imgur.com/bKkunQY.png) | ![Image 3](https://i.imgur.com/EbK3Vsf.png) |
|-------------------------------------------|-------------------------------------------|-------------------------------------------|

</div>


## To USE

**State for dead and revive**
```lua
-- OTHERS CODE
function OnPlayerDeath()
    isDead = true
    ESX.UI.Menu.CloseAll()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local formattedCoords = {
        x = ESX.Math.Round(coords.x, 1),
        y = ESX.Math.Round(coords.y, 1),
        z = ESX.Math.Round(coords.z, 1)
    }
    ESX.SetPlayerData('lastPosition', formattedCoords)
    ClearTimecycleModifier()
    SetTimecycleModifier("REDMIST_blend")
    SetTimecycleModifierStrength(0.7)
    SetExtraTimecycleModifier("fp_vig_red")
    SetExtraTimecycleModifierStrength(1.0)
    SetPedMotionBlur(PlayerPedId(), true)
    TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)
    StartDeathTimer()
    StartDeathCam()
    StartDistressSignal()
    ClearPedTasksImmediately(PlayerPedId())
    exports['pma-voice']:removePlayerFromRadio()
    exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
    exports["z-phone"]:setStatedead(true)
end
-- OTHERS CODE
RegisterNetEvent('esx_ambulancejob:revive', function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

    DoScreenFadeOut(800)

    while not IsScreenFadedOut() do
        Wait(50)
    end

    local formattedCoords = {x = ESX.Math.Round(coords.x, 1), y = ESX.Math.Round(coords.y, 1), z = ESX.Math.Round(coords.z, 1)}

    RespawnPed(playerPed, formattedCoords, 0.0)
    isDead = false
    ClearTimecycleModifier()
    SetPedMotionBlur(playerPed, false)
    ClearExtraTimecycleModifier()
    EndDeathCam()
    DoScreenFadeIn(800)
    TriggerEvent('esx_basicneeds:resetStatus')
    Wait(2000)
    loadAnimDict("random@crash_rescue@help_victim_up") 
    TaskPlayAnim( PlayerPedId(), "random@crash_rescue@help_victim_up", "helping_victim_to_feet_victim", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait(3000)
    ClearPedSecondaryTask(PlayerPedId())
    ClearPedTasksImmediately(PlayerPedId())
    exports["z-phone"]:setStatedead(false)
end)
-- OTHERS CODE
```

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
