
locales = Config.Locales[Config.Language]
local oldMarker = {}
local markerCounter = 4

RegisterNetEvent('fmdt:openMDT')
AddEventHandler('fmdt:openMDT', function(canOpen)
    if not canOpen then 
        return Config.Notifcation(locales['cant_open_mdt'])
    end

    SetNuiFocus(true, true)
    DisplayRadar(false)
    SendNUIMessage({
        type = 'show',
    })
end)

RegisterNUICallback('exit', function(data, cb)
    cb([[
        <div></div>
    ]])
    SetNuiFocus(false, false)
    DisplayRadar(true)
    SendNUIMessage({
        type = 'hide',
    })
end)

RegisterNetEvent('fmdt:notifyDispatch')
AddEventHandler('fmdt:notifyDispatch', function(identifier)
    Config.Notifcation(locales['new_dispatch'])
end)

RegisterNUICallback('show_image', function(data, cb)
    local url = data.url

    cb(([[
        <div class="fixed top-[9vh] left-[10vw] w-[80vw] h-[80vh] object-cover z-[9999]">
            <sl-button
                variant="danger"
                size="small"
                class="absolute top-2 left-2"
                hx-post="/close_image"
                hx-target="#img_box"
                hx-swap="innerHTML">%s
            </sl-button>

            <img src="%s" alt="img" class="w-full h-full object-cover rounded" />
        </div>
    ]]):format(
        locales['pages']['citizen']['close_picture'],
        url
    ))
end)

RegisterNUICallback('close_image', function(data, cb)
    cb([[]])
end)


