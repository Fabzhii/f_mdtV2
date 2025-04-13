
Citizen.CreateThread(function()
    GlobalState.dispatcher = nil
end)

RegisterServerEvent('fmdt:registerDispatcher')
AddEventHandler('fmdt:registerDispatcher', function(start)
    if GlobalState.dispatcher == nil then 
        if start then 
            GlobalState.dispatcher = source
        else 
            GlobalState.dispatcher = nil
        end 
    end 
end)

AddEventHandler("playerDropped", function(reason)
    if GlobalState.dispatcher == source then 
        GlobalState.dispatcher = nil
    end 
end)

RegisterServerEvent('fmdt:roadphone:caller:startCall')
AddEventHandler('fmdt:roadphone:caller:startCall', function(number)
    if GlobalState.dispatcher ~= nil then 
        TriggerClientEvent('fmdt:roadphone:dispatcher:getCall', GlobalState.dispatcher, number)
    end 
end)

RegisterNetEvent('roadphone:server:endCall')
AddEventHandler('roadphone:server:endCall', function(num1, num2)
    if num1.."" == (Config.Dispatches.number).."" then 
        if GlobalState.dispatcher ~= nil then 
            TriggerClientEvent('fmdt:roadphone:dispatcher:callEnded', GlobalState.dispatcher)
        end
    end 
end)

RegisterNetEvent('roadphone:service:sendMessage')
AddEventHandler('roadphone:service:sendMessage', function(job, text)
    for k,v in pairs(Config.Commands.jobs) do
        if v == job then 
            createDispatch(source, text)
        end 
    end 
end)

function createDispatch(id, header)
    MySQL.insert('INSERT INTO f_mdt_calls (reason, position, code, infos, officer) VALUES (?, ?, ?, ?, ?)', 
    {
        sanitizeInput(header), 
        json.encode(ESX.GetPlayerFromId(source).getCoords(true)),
        "Code-3",
        "n/A",
        json.encode({}),
    }, function()end)
end 
