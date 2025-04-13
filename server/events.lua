
Citizen.CreateThread(function()
    GlobalState.timer = {
        ['vehicle'] = 0,
        ['citizen'] = 0,
    }

    while true do 
        Citizen.Wait(5000)

        local timer = GlobalState.timer
        if timer['vehicle'] > 0 then 
            timer['vehicle'] = timer['vehicle'] - 5
        end 
        if timer['citizen'] > 0 then 
            timer['citizen'] = timer['citizen'] - 5
        end 

        GlobalState.timer = timer
    end 

end)

function sanitizeInput(input)
    input = input:gsub("<.->", "")
    input = input:gsub('["\']?%s*[%w-]*%s*=%s*["\']?[^"\'>]+["\']?', "")
    input = input:gsub("%s+", " ")

    return input
end

function generateIdentifer(length)
    local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local result = {}

    for i = 1, length do
        local rand = math.random(1, #charset)
        result[i] = charset:sub(rand, rand)
    end

    return table.concat(result)
end

exports.ox_inventory:registerHook("createItem", function(payload)
    local metadata = payload.metadata
    if payload.item.weapon and metadata.registered then
        local xPlayer = ESX.GetPlayerFromId(payload.inventoryId)
        for k,v in pairs(exports.ox_inventory:Items()) do 
            if v.name == payload.item.name then 
                MySQL.insert("INSERT INTO `f_mdt_weapons` (`owner`, `type`, `serial`, `wanted`) VALUES (?, ?, ?, ?)", {xPlayer.identifier, v.label, metadata.serial, 0})
            end 
        end 
    end
    return metadata
end)

-- information

ESX.RegisterServerCallback('fmdt:addInformation', function(source, cb, title, information)
    MySQL.insert('INSERT INTO f_mdt_infos (header, text) VALUES (?, ?)', {sanitizeInput(title), sanitizeInput(information)}, function()end)
    Citizen.Wait(50)
    cb(getInformation())
end)

ESX.RegisterServerCallback('fmdt:deleteInformation', function(source, cb, identifier)
    MySQL.Async. execute('DELETE FROM f_mdt_infos WHERE identifier = @identifier',{['@identifier'] = identifier},function()end)
    Citizen.Wait(50)
    cb(getInformation())
end)

-- self data

ESX.RegisterServerCallback('fmdt:changeSelfData', function(source, cb, key, value)

    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT state FROM users WHERE identifier = @identifier', {
        ['@identifier']  = xPlayer.identifier,
    }, function(data)

        local state = json.decode(data[1].state)
        state[key] = value

        MySQL.Async.execute('UPDATE users SET state = @state WHERE identifier = @identifier', {
            ['@state']  = json.encode(state),
            ['@identifier'] = xPlayer.identifier,
        })

    end)
    Citizen.Wait(50)
    cb(getCopData(xPlayer.source))
end)

-- buttons

ESX.RegisterServerCallback('fmdt:addButton', function(source, cb, text)
    MySQL.insert('INSERT INTO f_mdt_buttons (text) VALUES (?)', {sanitizeInput(text)}, function()end)
    Citizen.Wait(50)
    cb(getButtons())
end)

ESX.RegisterServerCallback('fmdt:deleteButton', function(source, cb, identifier)
    MySQL.Async. execute('DELETE FROM f_mdt_buttons WHERE identifier = @identifier',{['@identifier'] = identifier},function()end)
    Citizen.Wait(50)
    cb(getButtons())
end)

-- chat

ESX.RegisterServerCallback('fmdt:postMessage', function(source, cb, text)
    MySQL.insert('INSERT INTO f_mdt_chat (text, sender, name) VALUES (?, ?, ?)', 
    {
        sanitizeInput(text), 
        ESX.GetPlayerFromId(source).identifier,
        ESX.GetPlayerFromId(source).getName(),
    }, function()end)
    Citizen.Wait(50)
    cb(getChat(source))
end)

-- img

RegisterServerEvent('fmdt:saveImage')
AddEventHandler('fmdt:saveImage', function(url, type, id)
    
    if type == "user" then 
        MySQL.Async.fetchAll('SELECT images FROM users WHERE identifier = @identifier', {
            ['@identifier']  = id,
        }, function(data)
    
            local images = json.decode(data[1].images)
            local time = os.date("%Y-%m-%d %H:%M:%S")

            table.insert(images, {
                url = url,
                name = time,
            })
            
            MySQL.Async.execute('UPDATE users SET images = @images WHERE identifier = @identifier', {
                ['@images']  = json.encode(images),
                ['@identifier'] = id,
            })
    
        end)
    end 
end)

-- personal information

ESX.RegisterServerCallback('fmdt:changePersonalInformation', function(source, cb, identifier, telefon, email, job)
    MySQL.Async.execute('UPDATE users SET editinfo = @editinfo WHERE identifier = @identifier', {
        ['@editinfo']  = json.encode({
            telefon = sanitizeInput(telefon),
            email = sanitizeInput(email),
            job = sanitizeInput(job),
        }),
        ['@identifier'] = identifier,
    })
    Citizen.Wait(50)
    cb(getUser(identifier))
end)

-- warrant information

ESX.RegisterServerCallback('fmdt:changeWarrantInformation', function(source, cb, identifier, state, reason, infos)
    MySQL.Async.execute('UPDATE users SET warrant = @warrant WHERE identifier = @identifier', {
        ['@warrant']  = json.encode({
            state = state, 
            reason = sanitizeInput(reason), 
            infos = sanitizeInput(infos)
        }),
        ['@identifier'] = identifier,
    })
    Citizen.Wait(50)
    cb(getUser(identifier))
end)

-- notes

ESX.RegisterServerCallback('fmdt:addNote', function(source, cb, identifier, text)
    MySQL.Async.fetchAll('SELECT notes FROM users WHERE identifier = @identifier', {
        ['@identifier']  = identifier,
    }, function(data)
        local notes = json.decode(data[1].notes)

        table.insert(notes, {
            identifier = generateIdentifer(15),
            text = sanitizeInput(text),
            time = os.date("%Y-%m-%d %H:%M:%S"),
            officer = ESX.GetPlayerFromId(source).getName(),
        })
        
        MySQL.Async.execute('UPDATE users SET notes = @notes WHERE identifier = @identifier', {
            ['@notes']  = json.encode(notes),
            ['@identifier'] = identifier,
        })

    end)
    Citizen.Wait(50)
    cb(getNotes(identifier))
end)

ESX.RegisterServerCallback('fmdt:deleteNote', function(source, cb, identifier, note_id)
    MySQL.Async.fetchAll('SELECT notes FROM users WHERE identifier = @identifier', {
        ['@identifier']  = identifier,
    }, function(data)
        local notes = json.decode(data[1].notes)

        for k,v in pairs(notes) do 
            if v.identifier == note_id then
                table.remove(notes, k)
                break
            end 
        end
        
        MySQL.Async.execute('UPDATE users SET notes = @notes WHERE identifier = @identifier', {
            ['@notes']  = json.encode(notes),
            ['@identifier'] = identifier,
        })

    end)
    Citizen.Wait(50)
    cb(getNotes(identifier))
end)

-- files

ESX.RegisterServerCallback('fmdt:addCrime', function(source, cb, identifier, crime_type, description)
    MySQL.Async.fetchAll('SELECT files FROM users WHERE identifier = @identifier', {
        ['@identifier']  = identifier,
    }, function(data)
        local files = json.decode(data[1].files)

        table.insert(files, {
            identifier = generateIdentifer(15),
            crime = sanitizeInput(crime_type),
            description = sanitizeInput(description),
            time = os.date("%Y-%m-%d %H:%M:%S"),
            status = true,
            officer = ESX.GetPlayerFromId(source).getName(),
        })
        
        MySQL.Async.execute('UPDATE users SET files = @files WHERE identifier = @identifier', {
            ['@files']  = json.encode(files),
            ['@identifier'] = identifier,
        })

    end)
    Citizen.Wait(50)
    cb(getCrimes(identifier))
end)

ESX.RegisterServerCallback('fmdt:deleteCrime', function(source, cb, identifier, crime_id)
    MySQL.Async.fetchAll('SELECT files FROM users WHERE identifier = @identifier', {
        ['@identifier']  = identifier,
    }, function(data)
        local files = json.decode(data[1].files)

        for k,v in pairs(files) do 
            if v.identifier == crime_id then
                table.remove(files, k)
                break
            end 
        end
        
        MySQL.Async.execute('UPDATE users SET files = @files WHERE identifier = @identifier', {
            ['@files']  = json.encode(files),
            ['@identifier'] = identifier,
        })

    end)
    Citizen.Wait(50)
    cb(getNotes(identifier))
end)

ESX.RegisterServerCallback('fmdt:changeCrimeStatus', function(source, cb, identifier, crime_id, status)
    MySQL.Async.fetchAll('SELECT files FROM users WHERE identifier = @identifier', {
        ['@identifier']  = identifier,
    }, function(data)
        local files = json.decode(data[1].files)

        for k,v in pairs(files) do 
            if v.identifier == crime_id then
                files[k].status = status
                break
            end 
        end
        
        MySQL.Async.execute('UPDATE users SET files = @files WHERE identifier = @identifier', {
            ['@files']  = json.encode(files),
            ['@identifier'] = identifier,
        })

    end)
    Citizen.Wait(50)
    cb(getNotes(identifier))
end)

-- vehicle and weapons

ESX.RegisterServerCallback('fmdt:changeVehicleWanted', function(source, cb, plate, wanted)  
    MySQL.Async.execute('UPDATE owned_vehicles SET wanted = @wanted WHERE plate = @plate', {
        ['@wanted']  = wanted,
        ['@plate'] = plate,
    })
    Citizen.Wait(50)
    cb({})
end)

ESX.RegisterServerCallback('fmdt:changeWeaponWanted', function(source, cb, serial, wanted)  
    MySQL.Async.execute('UPDATE f_mdt_weapons SET wanted = @wanted WHERE serial = @serial', {
        ['@wanted']  = wanted,
        ['@serial'] = serial,
    })
    Citizen.Wait(50)
    cb({})
end)

-- tracking

RegisterServerEvent('fmdt:addTracker')
AddEventHandler('fmdt:addTracker', function(type, coords, label)
    addTracker(type, coords, label, source)
end)

function addTracker(type, coords, label, id)
    local timer = GlobalState.timer
    timer[type] = ((Config.Tracking)[type]['delay']) * 60
    GlobalState.timer = timer

    local officer = ESX.GetPlayerFromId(id).getName()
    MySQL.insert("INSERT INTO `f_mdt_tracker` (`label`, `officer`, `type`, `coords`) VALUES (?, ?, ?, ?)", {sanitizeInput(label), officer, type, json.encode(coords)})
end 

ESX.RegisterServerCallback('fmdt:trackPlayer', function(source, cb, identifier)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if xPlayer and canBeTracked(xPlayer.source) then
        addTracker("citizen", xPlayer.getCoords(true), xPlayer.getName(), source)
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('fmdt:deleteTracker', function(source, cb, identifier)
    MySQL.Async. execute('DELETE FROM f_mdt_tracker WHERE identifier = @identifier',{['@identifier'] = identifier},function()end)
    Citizen.Wait(50)
    cb(getTracker())
end)

-- dispatches

ESX.RegisterServerCallback('fmdt:dispatchAddOfficer', function(source, cb, identifier, officerName)
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_calls WHERE identifier = @identifier', {
        ['@identifier']  = identifier,
    }, function(data)
        local officer = json.decode(data[1].officer)

        local found = false

        for k,v in pairs(ESX.GetPlayers()) do 
            local xPlayer = ESX.GetPlayerFromId(v)
            if xPlayer then 
                if xPlayer.getName() == officerName then 
                    TriggerClientEvent('fmdt:notifyDispatch', xPlayer.source, identifier)
                end 
            end 
        end 

        for k,v in pairs(officer) do 
            if v == officerName then 
                found = true
            end 
        end     

        if not found then 
            table.insert(officer, officerName)
        end 

        MySQL.Async.execute('UPDATE f_mdt_calls SET officer = @officer WHERE identifier = @identifier', {
            ['@officer']  = json.encode(officer),
            ['@identifier'] = identifier,
        })

    end)
    Citizen.Wait(50)
    cb(getDispatches())
end)

ESX.RegisterServerCallback('fmdt:dispatchRemoveOfficer', function(source, cb, identifier, officerName)
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_calls WHERE identifier = @identifier', {
        ['@identifier']  = identifier,
    }, function(data)
        local officer = json.decode(data[1].officer)

        for k,v in pairs(officer) do 
            if v == officerName then 
                table.remove(officer, k)
                break
            end 
        end

        MySQL.Async.execute('UPDATE f_mdt_calls SET officer = @officer WHERE identifier = @identifier', {
            ['@officer']  = json.encode(officer),
            ['@identifier'] = identifier,
        })

    end)
    Citizen.Wait(50)
    cb(getDispatches())
end)


ESX.RegisterServerCallback('fmdt:dispatchEditInfo', function(source, cb, identifier, info)
    MySQL.Async.execute('UPDATE f_mdt_calls SET infos = @infos WHERE identifier = @identifier', {
        ['@infos']  = sanitizeInput(info),
        ['@identifier'] = identifier,
    })
    Citizen.Wait(50)
    cb(getDispatches())
end)

ESX.RegisterServerCallback('fmdt:deleteDispatch', function(source, cb, identifier)
    MySQL.Async. execute('DELETE FROM f_mdt_calls WHERE identifier = @identifier',{['@identifier'] = identifier},function()end)
    Citizen.Wait(50)
    cb(getDispatches())
end)

ESX.RegisterServerCallback('fmdt:dispatchEditCode', function(source, cb, identifier, code)
    MySQL.Async.execute('UPDATE f_mdt_calls SET code = @code WHERE identifier = @identifier', {
        ['@code']  = sanitizeInput(code),
        ['@identifier'] = identifier,
    })
    Citizen.Wait(50)
    cb(getDispatches())
end)

ESX.RegisterServerCallback('fmdt:DispatchEditPos', function(source, cb, identifier, position)
    MySQL.Async.execute('UPDATE f_mdt_calls SET position = @position WHERE identifier = @identifier', {
        ['@position']  = json.encode(position),
        ['@identifier'] = identifier,
    })
    Citizen.Wait(50)
    cb(getDispatches())
end)

ESX.RegisterServerCallback('fmdt:createDispatch', function(source, cb, reason, code, infos)
    MySQL.insert('INSERT INTO f_mdt_calls (reason, position, code, infos, officer) VALUES (?, ?, ?, ?, ?)', {
        sanitizeInput(reason), 
        json.encode(vector3(0, 0, 0)),
        sanitizeInput(code),
        sanitizeInput(infos),
        json.encode({}),
    }, function()end)

    Citizen.Wait(50)
    cb(getDispatches())
end)

-- lists

ESX.RegisterServerCallback('fmdt:editPlayerCallnumber', function(source, cb, identifier, number)
    MySQL.Async.execute('UPDATE users SET callNumber = @callNumber WHERE identifier = @identifier', {
        ['@callNumber']  = sanitizeInput(number),
        ['@identifier'] = identifier,
    })
    Citizen.Wait(50)
    cb(getListEmployeeData())
end)

ESX.RegisterServerCallback('fmdt:editPlayerBadgenumber', function(source, cb, identifier, number)
    MySQL.Async.execute('UPDATE users SET badgeNumber = @badgeNumber WHERE identifier = @identifier', {
        ['@badgeNumber']  = sanitizeInput(number),
        ['@identifier'] = identifier,
    })
    Citizen.Wait(50)
    cb(getListEmployeeData())
end)

ESX.RegisterServerCallback('fmdt:editPlayerUnit', function(source, cb, identifier, unit)
    MySQL.Async.execute('UPDATE users SET unit = @unit WHERE identifier = @identifier', {
        ['@unit']  = sanitizeInput(unit),
        ['@identifier'] = identifier,
    })
    Citizen.Wait(50)
    cb(getListEmployeeData())
end)

ESX.RegisterServerCallback('fmdt:editPlayerInfos', function(source, cb, identifier, info)
    MySQL.Async.execute('UPDATE users SET info = @info WHERE identifier = @identifier', {
        ['@info']  = sanitizeInput(info),
        ['@identifier'] = identifier,
    })
    Citizen.Wait(50)
    cb(getListEmployeeData())
end)

ESX.RegisterServerCallback('fmdt:removeTraining', function(source, cb, identifier, training)
    MySQL.Async.fetchAll('SELECT trainings FROM users WHERE identifier = @identifier', {
        ['@identifier']  = identifier,
    }, function(data)
        local trainings = json.decode(data[1].trainings)
        
        for k,v in pairs(trainings) do 
            if v == training then 
                table.remove(trainings, k)
            end 
        end 

        MySQL.Async.execute('UPDATE users SET trainings = @trainings WHERE identifier = @identifier', {
            ['@trainings']  = json.encode(trainings),
            ['@identifier'] = identifier,
        })
    end)
    Citizen.Wait(50)
    cb(getListEmployeeData())
end)

ESX.RegisterServerCallback('fmdt:addVehicle', function(source, cb, category, label, mingrade, price)
    MySQL.insert('INSERT INTO f_mdt_vehicles (category, label, mingrade, price) VALUES (?, ?, ?, ?)', {
        sanitizeInput(category), 
        sanitizeInput(label), 
        sanitizeInput(mingrade), 
        sanitizeInput(price), 
    }, function()end)

    Citizen.Wait(50)
    cb(getListVehicleData())
end)

ESX.RegisterServerCallback('fmdt:removeVehicle', function(source, cb, identifier)
    MySQL.Async. execute('DELETE FROM f_mdt_vehicles WHERE identifier = @identifier',{['@identifier'] = identifier},function()end)
    Citizen.Wait(50)
    cb(getListVehicleData())
end)

ESX.RegisterServerCallback('fmdt:addOutfit', function(source, cb, label, mingrade, unit, url, outfit)
    MySQL.insert('INSERT INTO f_mdt_outfits (label, mingrade, unit, url, outfit) VALUES (?, ?, ?, ?, ?)', {
        sanitizeInput(label), 
        sanitizeInput(mingrade), 
        sanitizeInput(unit), 
        sanitizeInput(url), 
        json.encode(outfit)
    }, function()end)

    Citizen.Wait(50)
    cb(getListOutfitData())
end)

ESX.RegisterServerCallback('fmdt:deleteOutfit', function(source, cb, identifier)
    MySQL.Async. execute('DELETE FROM f_mdt_outfits WHERE identifier = @identifier',{['@identifier'] = identifier},function()end)
    Citizen.Wait(50)
    cb(getListOutfitData())
end)

ESX.RegisterServerCallback('fmdt:addTraining', function(source, cb, training, description, time, location, limit)
    MySQL.insert('INSERT INTO f_mdt_trainings (label, description, supervisor, time, location, list, playerlimit) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        sanitizeInput(training), 
        sanitizeInput(description), 
        ESX.GetPlayerFromId(source).getName(), 
        sanitizeInput(time), 
        sanitizeInput(location),
        json.encode({}),
        sanitizeInput(limit.."")
    }, function()end)

    Citizen.Wait(50)
    cb(getListTrainingData())
end)

ESX.RegisterServerCallback('fmdt:editTrainingLogin', function(source, cb, identifier)
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_trainings WHERE identifier = @identifier', {
        ['@identifier']  = identifier,
    }, function(data)
        local list = json.decode(data[1].list)

        local found = false 
        local name = ESX.GetPlayerFromId(source).getName()
        
        for k,v in pairs(list) do 
            if v == name then 
                found = true 
                table.remove(list, k)
            end 
        end 

        if not found then table.insert(list, name) end 

        MySQL.Async.execute('UPDATE f_mdt_trainings SET list = @list WHERE identifier = @identifier', {
            ['@list']  = json.encode(list),
            ['@identifier'] = identifier,
        })
    end)

    Citizen.Wait(50)
    cb(getListTrainingData())
end)

ESX.RegisterServerCallback('fmdt:deleteTraining', function(source, cb, identifier)
    MySQL.Async. execute('DELETE FROM f_mdt_trainings WHERE identifier = @identifier',{['@identifier'] = identifier},function()end)
    Citizen.Wait(50)
    cb(getListTrainingData())
end)


ESX.RegisterServerCallback('fmdt:endTraining', function(source, cb, identifier, list)

    local trainingData = getListTrainingData()
    local label = ""
    local id id = ""

    for k,v in pairs(trainingData) do 
        if tonumber(v.identifier) == tonumber(identifier) then 
            label = v.label
            break
        end
    end 

    for k,v in pairs(Config.Trainings) do 
        if label == v.locales[Config.Language].label then 
            id = v.id
            break
        end
    end 

    MySQL.Async.fetchAll('SELECT identifier, firstname, lastname, trainings FROM users', {
    }, function(data)
        for k,v in pairs(data) do 
            for o,i in pairs(list) do 
                print((v.firstname .. ' ' .. v.lastname), i)
                if (v.firstname .. ' ' .. v.lastname) == i then 
                    local plyIdentifier = v.identifier
                    local trainings = json.decode(v.trainings)
                    table.insert(trainings, id)
                    MySQL.Async.execute('UPDATE users SET trainings = @trainings WHERE identifier = @identifier', {
                        ['@trainings']  = json.encode(trainings),
                        ['@identifier'] = plyIdentifier,
                    })
                end 
            end 
        end 
    end)

    MySQL.Async. execute('DELETE FROM f_mdt_trainings WHERE identifier = @identifier',{['@identifier'] = identifier},function()end)
    Citizen.Wait(50)
    cb(getListTrainingData())
end)

ESX.RegisterServerCallback('fmdt:deleteLaw', function(source, cb, paragraph)
    MySQL.Async. execute('DELETE FROM f_mdt_law WHERE paragraph = @paragraph',{['@paragraph'] = paragraph},function()end)
    Citizen.Wait(50)
    cb(getLaw())
end)

ESX.RegisterServerCallback('fmdt:addLaw', function(source, cb, paragraph)
    MySQL.insert('INSERT INTO f_mdt_law (text, paragraph) VALUES (?, ?)', {json.encode({}), sanitizeInput(paragraph)}, function()end)
    Citizen.Wait(50)
    cb(getLaw())
end)

ESX.RegisterServerCallback('fmdt:addCrimeToParagraph', function(source, cb, paragraph, crime, description, jail, fine, society)
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_law WHERE paragraph = @paragraph', {
        ['@paragraph']  = paragraph,
    }, function(data)
        local text = json.decode(data[1].text)

        table.insert(text, {
            label = crime, 
            description = description, 
            jail = jail, 
            fine = fine, 
            society = society,
        })

        MySQL.Async.execute('UPDATE f_mdt_law SET text = @text WHERE paragraph = @paragraph', {
            ['@text']  = json.encode(text),
            ['@paragraph'] = paragraph,
        })
    end)

    Citizen.Wait(50)
    cb(getLaw())
end)

ESX.RegisterServerCallback('fmdt:deleteCrimeFromParagraph', function(source, cb, paragraph, crime)
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_law WHERE paragraph = @paragraph', {
        ['@paragraph']  = paragraph,
    }, function(data)
        local text = json.decode(data[1].text)

        for k,v in pairs(text) do 
            if v.label == crime then 
                table.remove(text, k)
                break
            end 
        end 

        MySQL.Async.execute('UPDATE f_mdt_law SET text = @text WHERE paragraph = @paragraph', {
            ['@text']  = json.encode(text),
            ['@paragraph'] = paragraph,
        })
    end)

    Citizen.Wait(50)
    cb(getLaw())
end)

ESX.RegisterServerCallback('fmdt:addDocument', function(source, cb, type)
    MySQL.insert('INSERT INTO f_mdt_documents (id, officer, data) VALUES (?, ?, ?)', {type, ESX.GetPlayerFromId(source).getName(), json.encode({})}, function()end)
    Citizen.Wait(50)
    cb(getDocuments())
end)

ESX.RegisterServerCallback('fmdt:saveDocument', function(source, cb, identifier, data)
    MySQL.Async.execute('UPDATE f_mdt_documents SET data = @data WHERE identifier = @identifier', {
        ['@data']  = json.encode(data),
        ['@identifier'] = identifier,
    })
    Citizen.Wait(50)
    cb(getDocuments())
end)

