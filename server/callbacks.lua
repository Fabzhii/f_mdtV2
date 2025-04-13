
local trackable = {}

-- cop and self data

ESX.RegisterServerCallback('fmdt:getSelfData', function(source, cb)
    cb(getCopData(source))
end)

ESX.RegisterServerCallback('fmdt:getCopData', function(source, cb, id)
    cb(getCopData(id))
end)

ESX.RegisterServerCallback('fmdt:getCopsData', function(source, cb)
    local data = {}

    for k,v in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(v)
        if xPlayer then 
            for o,i in pairs(Config.Commands.jobs) do 
                if i == xPlayer.getJob().name then 
                    table.insert(data, getCopData(v))
                end 
            end 
        end 
    end
    
    cb(data)
end)

function getCopData(id)
    local p = promise.new()
    local xPlayer = ESX.GetPlayerFromId(id)
    if xPlayer then 
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
            ['@identifier']  = xPlayer.identifier,
        }, function(data)
            local sqlData = data[1]
            local data = {
                name = xPlayer.getName(),
                coords = xPlayer.getCoords(true),
                canBeTracked = canBeTracked(id),
                job_name = xPlayer.getJob().name,
                job_label = xPlayer.getJob().label,
                job_grade_name = xPlayer.getJob().grade_name,
                job_grade_label = xPlayer.getJob().grade_label,
                phone_number = sqlData[Config.PhoneNumberColomn],
                status = (json.decode(sqlData.state)).status or "n/A",
                callname = (json.decode(sqlData.state)).callname or "n/A",
                callnumber = sqlData.callNumber,
                badgenumber = sqlData.badgeNumber,
                unit = sqlData.unit,
                position = (json.decode(sqlData.state)).position or "n/A",
                vehicle = (json.decode(sqlData.state)).vehicle or "n/A",
                frequency = (json.decode(sqlData.state)).frequency or "n/A",
                o1 = (json.decode(sqlData.state)).o1 or "n/A",
                o2 = (json.decode(sqlData.state)).o2 or "n/A",
                o3 = (json.decode(sqlData.state)).o3 or "n/A",
            }
            p:resolve(data)
        end)
    end 
    return Citizen.Await(p)
end

-- wanted data

ESX.RegisterServerCallback('fmdt:getWanteds', function(source, cb)
    cb(getWanteds())
end)

function getWanteds()
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT firstname, lastname, warrant FROM users', {
    }, function(data)
        local result = {}
        for k,v in pairs(data) do 
            local wantedData = json.decode(v.warrant)

            if wantedData.state == true then 
                table.insert(result, {
                    name = (v.firstname .. ' ' .. v.lastname),
                    reason = wantedData.reason,
                    infos = wantedData.infos,
                })
            end 
        end 
        p:resolve(result)
    end)
    return Citizen.Await(p)
end

-- dispatches data

ESX.RegisterServerCallback('fmdt:getDispatches', function(source, cb)
    cb(getDispatches())
end)

function getDispatches()
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_calls', {}, 
    function(data)
        local result = {}
        for k,v in pairs(data) do 
            local unix_time = (v.time) / 1000 
            local formatted_time = os.date("%H:%M:%S", unix_time)
            table.insert(result, {
                reason = v.reason,
                time = formatted_time,
                position = v.position,
                code = v.code,
                infos = v.infos,
                officer = json.decode(v.officer),
                identifier = v.identifier,
            }) 
        end 
        p:resolve(result)
    end)
    return Citizen.Await(p)
end

-- infos data

ESX.RegisterServerCallback('fmdt:getInformation', function(source, cb)
    cb(getInformation())
end)

function getInformation()
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_infos', {}, 
    function(data)
        local result = {}
        for k,v in pairs(data) do 
            table.insert(result, {
                title = v.header,
                information = v.text,
                identifier = v.identifier,
            }) 
        end 
        p:resolve(result)
    end)
    return Citizen.Await(p)
end

-- buttons

ESX.RegisterServerCallback('fmdt:getButtons', function(source, cb)
    cb(getButtons())
end)

function getButtons()
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_buttons', {}, 
    function(data)
        local result = {}
        for k,v in pairs(data) do 
            table.insert(result, {
                text = v.text,
                identifier = v.identifier,
            }) 
        end 
        p:resolve(result)
    end)
    return Citizen.Await(p)
end

-- chat

ESX.RegisterServerCallback('fmdt:getChat', function(source, cb)
    cb(getChat(source))
end)

function getChat(source)
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_chat', {}, 
    function(data)
        local result = {}
        for k,v in pairs(data) do 
            table.insert(result, {
                text = v.text,
                sender = v.sender,
                name = v.name,
                identifier = v.identifier,
            }) 
        end 
        p:resolve({chat = result, identifier = ESX.GetPlayerFromId(source).identifier})
    end)
    return Citizen.Await(p)
end

-- search people

ESX.RegisterServerCallback('fmdt:searchPerson', function(source, cb, input)
    cb(searchPerson(input))
end)

function searchPerson(input)
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT identifier, firstname, lastname, dateofbirth, sex, warrant FROM users WHERE firstname LIKE @name OR lastname LIKE @name OR CONCAT(firstname, " ", lastname) LIKE @name', {
        ['@name'] = '%' .. input .. '%',
    }, function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end

-- search vehicle

ESX.RegisterServerCallback('fmdt:searchVehicle', function(source, cb, input)
    cb(searchVehicle(input))
end)

function searchVehicle(input)
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT identifier, firstname, lastname FROM users', {
    }, function(users)
        MySQL.Async.fetchAll('SELECT owner, plate, vehicle, registered, wanted FROM owned_vehicles WHERE plate LIKE @plate', {
            ['@plate'] = '%' .. input .. '%',
        }, function(vehicle)
            local data = {}

            for k,v in pairs(vehicle) do 
                for o,i in pairs(users) do 
                    if i.identifier == v.owner then

                        table.insert(data, {
                            owner = (i.firstname .. ' ' .. i.lastname),
                            identifier = i.identifier,
                            plate = v.plate, 
                            type = json.decode(v.vehicle).model,
                            color = json.decode(v.vehicle).color1, 
                            registered = v.registered,
                            wanted = v.wanted,
                        })

                        break
                    end 
                end 
            end 

            p:resolve(data)
        end)
    end)
    return Citizen.Await(p)
end

-- search weapon

ESX.RegisterServerCallback('fmdt:searchWeapon', function(source, cb, input)
    cb(searchWeapon(input))
end)

function searchWeapon(input)
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT identifier, firstname, lastname FROM users', {
    }, function(users)
        MySQL.Async.fetchAll('SELECT * FROM f_mdt_weapons WHERE serial LIKE @serial', {
            ['@serial'] = '%' .. input .. '%',
        }, function(weapons)
            local data = {}

            for k,v in pairs(weapons) do 
                for o,i in pairs(users) do 
                    if i.identifier == v.owner then

                        table.insert(data, {
                            owner = (i.firstname .. ' ' .. i.lastname),
                            identifier = i.identifier,
                            serial = v.serial, 
                            type = v.type, 
                            wanted = v.wanted,
                        })

                        break
                    end 
                end 
            end 

            p:resolve(data)
        end)
    end)
    return Citizen.Await(p)
end

-- get user

ESX.RegisterServerCallback('fmdt:getUser', function(source, cb, identifier)
    cb(getUser(identifier))
end)

function getUser(identifier)
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier,
    }, function(data)
        p:resolve(data[1])
    end)
    return Citizen.Await(p)
end

-- get licenses

ESX.RegisterServerCallback('fmdt:getLicenses', function(source, cb, identifier)
    cb(getLicenses(identifier))
end)

function getLicenses(identifier)
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT * FROM licenses', {
    }, function(licenses)
        MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE owner = @owner', {
            ['@owner'] = identifier,
        }, function(data)
            local user_licenses = {}

            for k,v in pairs(data) do 
                for o,i in pairs(licenses) do 
                    if v.type == i.type then 
                        table.insert(user_licenses, i.label)
                    end 
                end 
            end 

            p:resolve(user_licenses)
        end)
    end)
    return Citizen.Await(p)
end

-- get notes

ESX.RegisterServerCallback('fmdt:getNotes', function(source, cb, identifier)
    cb(getNotes(identifier))
end)

function getNotes(identifier)
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT notes FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier,
    }, function(data)
        p:resolve(json.decode(data[1].notes))
    end)
    return Citizen.Await(p)
end

-- get law

ESX.RegisterServerCallback('fmdt:getLaw', function(source, cb)
    cb(getLaw())
end)

function getLaw()
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_law', {}, 
    function(data)
        local result = {}
        for k,v in pairs(data) do 
            table.insert(result, {
                paragraph = v.paragraph,
                text = json.decode(v.text),
            }) 
        end 
        p:resolve(result)
    end)
    return Citizen.Await(p)
end

-- get crimes

ESX.RegisterServerCallback('fmdt:getCrimes', function(source, cb, identifier)
    cb(getCrimes(identifier))
end)

function getCrimes(identifier)
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT files FROM users WHERE identifier = @identifier', {
        ['@identifier']  = identifier,
    }, function(data)
        p:resolve(json.decode(data[1].files))
    end)
    return Citizen.Await(p)
end

-- tracking

ESX.RegisterServerCallback('fmdt:track', function(source, cb, input)
    cb(track(input))
end)

function track(input)
    local p = promise.new()

    MySQL.Async.fetchAll('SELECT identifier, firstname, lastname, ' .. Config.PhoneNumberColomn .. ' FROM users WHERE ' .. Config.PhoneNumberColomn .. ' LIKE @phone_number', {
        ['@phone_number'] = '%' .. input .. '%',
    }, function(users)
        MySQL.Async.fetchAll('SELECT plate, vehicle FROM owned_vehicles WHERE plate LIKE @plate', {
            ['@plate'] = '%' .. input .. '%',
        }, function(vehicle)
            local data = {}

            for k,v in pairs(vehicle) do 
                table.insert(data, {
                    type = "vehicle",
                    plate = v.plate, 
                    model = json.decode(v.vehicle).model,
                    color = json.decode(v.vehicle).color1
                })
            end 

            for k,v in pairs(users) do 
                table.insert(data, {
                    type = "person",
                    phone_number = v[Config.PhoneNumberColomn],
                    identifier = v.identifier, 
                    name = (v.firstname .. ' ' .. v.lastname),
                })
            end 

            p:resolve(data)
        end)
    end)

    return Citizen.Await(p)
end

ESX.RegisterServerCallback('fmdt:getTracker', function(source, cb)
    cb(getTracker())
end)

function getTracker()
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_tracker', {}, 
    function(data)
        local result = {}

        for k,v in pairs(data) do 
            local unix_time = (v.time) / 1000 
            local formatted_time = os.date("%H:%M:%S", unix_time)
            table.insert(result, {
                type = v.type,
                identifier = v.identifier,
                label = v.label,
                time = formatted_time,
                officer = v.officer,
                coords = json.decode(v.coords),
            })
        end 

        p:resolve(result)
    end)
    return Citizen.Await(p)
end

-- flightmode

RegisterServerEvent('fmdt:send:canBeTracked')
AddEventHandler('fmdt:send:canBeTracked', function(id, result)
    trackable[id] = result
end)

function canBeTracked(id)
    trackable[id] = nil

    TriggerClientEvent('fmdt:get:canBeTracked', id, id)
    while trackable[id] == nil do 
        Citizen.Wait(3)
    end 

    return trackable[id]
end 


-- lists

ESX.RegisterServerCallback('fmdt:getListEmployeeData', function(source, cb)
    cb(getListEmployeeData())
end)

function getListEmployeeData()
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT identifier, firstname, lastname, dateofbirth, job, job_grade, '.. Config.PhoneNumberColomn .. ', callNumber, badgeNumber, unit, info, trainings FROM users', {}, 
    function(data)
        local result = {}
        local jobs = {}

        for k,v in pairs(ESX.GetJobs()) do 
            for o,i in pairs(Config.Commands.jobs) do 
                if k == i then 
                    table.insert(jobs, v)
                end 
            end 
        end 

        for k,v in pairs(jobs) do 
            for i = 0, 25 do 
                if v.grades[i..""] then 
                    table.insert(result, {
                        job_name = v.name,
                        job_label = v.label,
                        grade = v.grades[i..""].grade,
                        grade_name = v.grades[i..""].name,
                        grade_label = v.grades[i..""].label, 
                        officer = {},
                    })
                end 
            end 
        end 

        for k,v in pairs(data) do 
            for o,i in pairs(result) do 
                if v.job == i.job_name and v.job_grade == i.grade then 
                    table.insert((result[o].officer), {
                        identifier = v.identifier,
                        name = (v.firstname .. ' ' .. v.lastname),
                        dob = v.dateofbirth,
                        phone_number = v[Config.PhoneNumberColomn],
                        callNumber = v.callNumber,
                        badgeNumber = v.badgeNumber,
                        unit = v.unit,
                        info = v.info,
                        trainings = json.decode(v.trainings)
                    })
                end 
            end 
        end 

        p:resolve(result)
    end)
    return Citizen.Await(p)
end

ESX.RegisterServerCallback('fmdt:getGrades', function(source, cb)
    cb(getGrades())
end)

function getGrades()
    local result = {}
    local jobs = {}

    for k,v in pairs(ESX.GetJobs()) do 
        for o,i in pairs(Config.Commands.jobs) do 
            if k == i then 
                table.insert(jobs, v)
            end 
        end 
    end 

    for k,v in pairs(jobs) do 
        for i = 0, 25 do 
            if v.grades[i..""] then 
                table.insert(result, {
                    job_name = v.name,
                    job_label = v.label,
                    grade = v.grades[i..""].grade,
                    grade_name = v.grades[i..""].name,
                    grade_label = v.grades[i..""].label, 
                })
            end 
        end 
    end 

    return result
end

ESX.RegisterServerCallback('fmdt:getListVehicleData', function(source, cb)
    cb(getListVehicleData())
end)

function getListVehicleData()
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_vehicles', {}, function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end

ESX.RegisterServerCallback('fmdt:getListOutfitData', function(source, cb)
    cb(getListOutfitData())
end)

function getListOutfitData()
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_outfits', {}, function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end

ESX.RegisterServerCallback('fmdt:getListTrainingData', function(source, cb)
    cb(getListTrainingData())
end)

function getListTrainingData()
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_trainings', {}, function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end

-- documents

ESX.RegisterServerCallback('fmdt:getDocuments', function(source, cb)
    cb(getDocuments())
end)

function getDocuments()
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_documents', {}, function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end

ESX.RegisterServerCallback('fmdt:searchDocument', function(source, cb, input)
    cb(searchDocument(input))
end)

function searchDocument(input)
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_documents WHERE officer LIKE @input OR identifier LIKE @input OR time LIKE @input', {
        ['@input'] = '%' .. input .. '%',
    }, function(data)
        local result = {}

        for k,v in pairs(data) do 
            table.insert(result, {
                id = v.id,
                time = os.date("%d.%m.%Y %H:%M:%S", math.floor(v.time / 1000)),
                officer = v.officer,
                identifier = v.identifier,
                data = json.decode(v.data),
            })
        end 

        p:resolve(result)
    end)
    return Citizen.Await(p)
end

ESX.RegisterServerCallback('fmdt:getDocumentOptions', function(source, cb)
    cb(getDocumentOptions())
end)

function getDocumentOptions()
    local p = promise.new()
    MySQL.Async.fetchAll('SELECT firstname, lastname, job FROM users', {
    }, function(users)
        MySQL.Async.fetchAll('SELECT * FROM f_mdt_weapons', {
        }, function(weapons)
            local result = {
                officer = {},
                citizen = {},
                weapons = {},
            }

            for k,v in pairs(users) do
                local isCop = false
                for o,i in pairs(Config.Commands.jobs) do if i == v.job then isCop = true end end

                if isCop then 
                    table.insert((result.officer), (v.firstname .. ' ' .. v.lastname))
                else 
                    table.insert((result.citizen), (v.firstname .. ' ' .. v.lastname))
                end 
            end 

            for k,v in pairs(weapons) do 
                table.insert((result.weapons), {type = v.type, serial = v.serial})
            end 

            p:resolve(result)
        end)
    end)
    return Citizen.Await(p)
end
