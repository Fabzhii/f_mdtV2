


function getSelfData()
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getSelfData', function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end

function getCopData(id)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getCopData', function(data)
        p:resolve(data)
    end, id)
    return Citizen.Await(p)
end

function getCopsData()
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getCopsData', function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end

function getWanteds()
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getWanteds', function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end

function getDispatches()
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getDispatches', function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end

function getInformation()
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getInformation', function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end

function getButtons()
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getButtons', function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end

function getChat()
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getChat', function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end

function getUser(identifier)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getUser', function(data)
        p:resolve(data)
    end, identifier)
    return Citizen.Await(p)
end

function searchPerson(input)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:searchPerson', function(data)
        p:resolve(data)
    end, input)
    return Citizen.Await(p)
end

function searchVehicle(input)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:searchVehicle', function(data)
        p:resolve(data)
    end, input)
    return Citizen.Await(p)
end

function searchWeapon(input)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:searchWeapon', function(data)
        p:resolve(data)
    end, input)
    return Citizen.Await(p)
end

function getLicenses(identifier)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getLicenses', function(data)
        p:resolve(data)
    end, identifier)
    return Citizen.Await(p)
end 

function getNotes(identifier)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getNotes', function(data)
        p:resolve(data)
    end, identifier)
    return Citizen.Await(p)
end 

function getLaw()
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getLaw', function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end 

function getCrimes(identifier)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getCrimes', function(data)
        p:resolve(data)
    end, identifier)
    return Citizen.Await(p)
end 

function track(input)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:track', function(data)
        p:resolve(data)
    end, input)
    return Citizen.Await(p)
end

function getTracker()
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getTracker', function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end 

function getListEmployeeData()
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getListEmployeeData', function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end 

function getGrades()
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getGrades', function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end 

function getListVehicleData()
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getListVehicleData', function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end

function getListOutfitData()
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getListOutfitData', function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end

function getListTrainingData()
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getListTrainingData', function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end

function getDocuments()
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getDocuments', function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end

function searchDocument(input)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:searchDocument', function(data)
        p:resolve(data)
    end, input)
    return Citizen.Await(p)
end

function getDocumentOptions()
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:getDocumentOptions', function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end


-- events

function addInformation(title, information)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:addInformation', function(data)
        p:resolve(data)
    end, title, information)
    return Citizen.Await(p)
end

function deleteInformation(identifier)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:deleteInformation', function(data)
        p:resolve(data)
    end, identifier)
    return Citizen.Await(p)
end

function changeSelfData(key, value)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:changeSelfData', function(data)
        p:resolve(data)
    end, key, value)
    return Citizen.Await(p)
end

function addButton(text)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:addButton', function(data)
        p:resolve(data)
    end, text)
    return Citizen.Await(p)
end

function deleteButton(identifier)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:deleteButton', function(data)
        p:resolve(data)
    end, identifier)
    return Citizen.Await(p)
end

function postMessage(message)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:postMessage', function(data)
        p:resolve(data)
    end, message)
    return Citizen.Await(p)
end

function changePersonalInformation(identifier, telefon, email, job)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:changePersonalInformation', function(data)
        p:resolve(data)
    end, identifier, telefon, email, job)
    return Citizen.Await(p)
end

function changeWarrantInformation(identifier, state, reason, infos)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:changeWarrantInformation', function(data)
        p:resolve(data)
    end, identifier, state, reason, infos)
    return Citizen.Await(p)
end

function addNote(identifier, text)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:addNote', function(data)
        p:resolve(data)
    end, identifier, text)
    return Citizen.Await(p)
end

function deleteNote(identifier, note_id)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:deleteNote', function(data)
        p:resolve(data)
    end, identifier, note_id)
    return Citizen.Await(p)
end

function addCrime(identifier, crime_type, description)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:addCrime', function(data)
        p:resolve(data)
    end, identifier, crime_type, description)
    return Citizen.Await(p)
end

function deleteCrime(identifier, crime_id)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:deleteCrime', function(data)
        p:resolve(data)
    end, identifier, crime_id)
    return Citizen.Await(p)
end

function changeCrimeStatus(identifier, crime_id, status)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:changeCrimeStatus', function(data)
        p:resolve(data)
    end, identifier, crime_id, status)
    return Citizen.Await(p)
end

function changeVehicleWanted(plate, wanted)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:changeVehicleWanted', function(data)
        p:resolve(data)
    end, plate, wanted)
    return Citizen.Await(p)
end

function changeWeaponWanted(serial, wanted)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:changeWeaponWanted', function(data)
        p:resolve(data)
    end, serial, wanted)
    return Citizen.Await(p)
end

function trackPlayer(identifier)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:trackPlayer', function(data)
        p:resolve(data)
    end, identifier)
    return Citizen.Await(p)
end 

function deleteTracker(identifier)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:deleteTracker', function(data)
        p:resolve(data)
    end, identifier)
    return Citizen.Await(p)
end 

function dispatchAddOfficer(identifier, officer)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:dispatchAddOfficer', function(data)
        p:resolve(data)
    end, identifier, officer)
    return Citizen.Await(p)
end

function dispatchRemoveOfficer(identifier, officer)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:dispatchRemoveOfficer', function(data)
        p:resolve(data)
    end, identifier, officer)
    return Citizen.Await(p)
end

function dispatchEditInfo(identifier, info)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:dispatchEditInfo', function(data)
        p:resolve(data)
    end, identifier, info)
    return Citizen.Await(p)
end

function deleteDispatch(identifier)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:deleteDispatch', function(data)
        p:resolve(data)
    end, identifier)
    return Citizen.Await(p)
end


function dispatchEditCode(identifier, code)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:dispatchEditCode', function(data)
        p:resolve(data)
    end, identifier, code)
    return Citizen.Await(p)
end

function DispatchEditPos(identifier, position)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:DispatchEditPos', function(data)
        p:resolve(data)
    end, identifier, position)
    return Citizen.Await(p)
end

function createDispatch(reason, code, infos)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:createDispatch', function(data)
        p:resolve(data)
    end, reason, code, infos)
    return Citizen.Await(p)
end

function editPlayerCallnumber(identifier, number)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:editPlayerCallnumber', function(data)
        p:resolve(data)
    end, identifier, number)
    return Citizen.Await(p)
end

function editPlayerBadgenumber(identifier, number)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:editPlayerBadgenumber', function(data)
        p:resolve(data)
    end, identifier, number)
    return Citizen.Await(p)
end

function editPlayerUnit(identifier, unit)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:editPlayerUnit', function(data)
        p:resolve(data)
    end, identifier, unit)
    return Citizen.Await(p)
end

function editPlayerInfos(identifier, infos)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:editPlayerInfos', function(data)
        p:resolve(data)
    end, identifier, infos)
    return Citizen.Await(p)
end

function removeTraining(identifier, training)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:removeTraining', function(data)
        p:resolve(data)
    end, identifier, training)
    return Citizen.Await(p)
end

function addVehicle(category, label, mingrade, price)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:addVehicle', function(data)
        p:resolve(data)
    end, category, label, mingrade, price)
    return Citizen.Await(p)
end

function removeVehicle(identifier)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:removeVehicle', function(data)
        p:resolve(data)
    end, identifier)
    return Citizen.Await(p)
end

function addOutfit(label, mingrade, unit, url, outfit)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:addOutfit', function(data)
        p:resolve(data)
    end, label, mingrade, unit, url, outfit)
    return Citizen.Await(p)
end

function deleteOutfit(identifier)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:deleteOutfit', function(data)
        p:resolve(data)
    end, identifier)
    return Citizen.Await(p)
end

function addTraining(training, description, time, location, limit)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:addTraining', function(data)
        p:resolve(data)
    end, training, description, time, location, limit)
    return Citizen.Await(p)
end

function editTrainingLogin(identifier)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:editTrainingLogin', function(data)
        p:resolve(data)
    end, identifier)
    return Citizen.Await(p)
end

function deleteTraining(identifier)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:deleteTraining', function(data)
        p:resolve(data)
    end, identifier)
    return Citizen.Await(p)
end

function endTraining(identifier, list)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:endTraining', function(data)
        p:resolve(data)
    end, identifier, list)
    return Citizen.Await(p)
end

function deleteLaw(paragraph)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:deleteLaw', function(data)
        p:resolve(data)
    end, paragraph)
    return Citizen.Await(p)
end

function addLaw(paragraph)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:addLaw', function(data)
        p:resolve(data)
    end, paragraph)
    return Citizen.Await(p)
end

function addCrimeToParagraph(paragraph, crime, description, jail, fine, society)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:addCrimeToParagraph', function(data)
        p:resolve(data)
    end, paragraph, crime, description, jail, fine, society)
    return Citizen.Await(p)
end

function deleteCrimeFromParagraph(paragraph, crime)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:deleteCrimeFromParagraph', function(data)
        p:resolve(data)
    end, paragraph, crime)
    return Citizen.Await(p)
end

function addDocument(type)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:addDocument', function(data)
        p:resolve(data)
    end, type)
    return Citizen.Await(p)
end

function saveDocument(identifier, data)
    local p = promise.new()
    ESX.TriggerServerCallback('fmdt:saveDocument', function(data)
        p:resolve(data)
    end, identifier, data)
    return Citizen.Await(p)
end