
locales = Config.Locales[Config.Language]
local currentNumber = nil 
local accepted = false 
local activeCall = 0 

-- tracking

exports('canBeTracked', function()
    if exports.ox_inventory:GetItemCount(Config.Tracking['settings'].phoneItem) == 1 or Config.Tracking['settings'].requirePhone == false then 
        return true 
    end 

    if Config.Dispatches.type == "roadphone" and GetResourceState("roadphone") == "started" then 
        if exports['roadphone']:isFlightmode() == false then 
            return true 
        end 
    end 

    if Config.Dispatches.type == "lbphone" and GetResourceState("lb-phone") == "started" then 
        if exports["lb-phone"]:GetAirplaneMode() == false then 
            return true 
        end 
    end 

    return false
end)

RegisterNetEvent('fmdt:get:canBeTracked')
AddEventHandler('fmdt:get:canBeTracked', function(id)
    TriggerServerEvent('fmdt:send:canBeTracked', id, exports[GetCurrentResourceName()]:canBeTracked())
end)

-- call notify

function dispatcherGetCall(number)
    lib.notify({
        id = 'fmdt:getCall',
        title = locales['dispatch']['call_header'],
        description = locales['dispatch']['call_text'],
        showDuration = false,
        duration = 6500,
        position = 'top-right',
        icon = 'headset',
    })
end 

-- exports

exports('call', function(number)
    print('call:', number)
end)

RegisterNetEvent('fmdt:roadphone:dispatcher:callEnded')
AddEventHandler('fmdt:roadphone:dispatcher:callEnded', function()
    activeCall = 0
end)

exports('isCallActive', function()
    return activeCall
end)

-- calling logic

Citizen.CreateThread(function()
    if Config.Dispatches.type == "roadphone" and GetResourceState("roadphone") == "started" then 
        setupRoadphone()
    end 

    if Config.Dispatches.type == "lbphone" and GetResourceState("lb-phone") == "started" then 
        setupLbphone()
    end 
end)

function setupRoadphone()

    exports('dispatcherEndCall', function()
        if GlobalState.dispatcher == GetPlayerServerId(PlayerId()) then 
            activeCall = 0
            TriggerServerEvent('roadphone:server:endCall', (currentNumber..""), nil)
        end 
    end)

    exports('dispatcherAcceptCall', function()
        if GlobalState.dispatcher == GetPlayerServerId(PlayerId()) then 
            accepted = true
            Citizen.Wait(2500)
            accepted = false
        end 
    end)
    
    exports('registerDispatcher', function(start)
        if GlobalState.dispatcher == nil then 
            TriggerServerEvent('fmdt:registerDispatcher', start)
            return true
        else 
            return false
        end 
    end)
    
    AddEventHandler("roadphone:client:call:eventnumber", function(number)
        if tostring(number) == tostring(Config.Dispatches.number) then 
            local phone_number = exports['roadphone']:getPhoneNumber()
            TriggerServerEvent('fmdt:roadphone:caller:startCall', phone_number)
        end
    end)

    RegisterNetEvent('fmdt:roadphone:dispatcher:getCall')
    AddEventHandler('fmdt:roadphone:dispatcher:getCall', function(number)
        currentNumber = number
        dispatcherGetCall(number)
        local timer = Config.Dispatches.maxTimeToAnswer
        activeCall = 1

        while timer > 0 do 
            timer = timer - 1
            Citizen.Wait(1000)

            if accepted then 
                accepted = false
                timer = -1
                activeCall = 2

                TriggerServerEvent("roadphone:server:acceptIncomingCall", number, 911)
                Citizen.Wait(10)
                stopAnim()

            end 
        end 

        if timer ~= -1 then 
            activeCall = 0
        end 

    end)

    function stopAnim()
        ClearPedTasks(PlayerPedId())
        for k,v in pairs(ESX.Game.GetObjects()) do
            if DoesEntityExist(v) and IsEntityAttachedToEntity(v, PlayerPedId()) then
                DeleteObject(v)
            end 
        end 
    end

end 


function setupLbphone()

end
