
locales = Config.Locales[Config.Language]

ESX.RegisterCommand({Config.Commands.open.command[Config.Language]}, 'user', function(xPlayer, args, showError)

    local hasJob = false
    local currentJob = xPlayer.getJob().name

    for k,v in pairs(Config.Commands.jobs) do
        if v == currentJob then 
            hasJob = true 
        end 
    end 

    TriggerClientEvent('fmdt:openMDT', xPlayer.source, hasJob)

end, false, {help = Config.Commands.open.description[Config.Language]})
