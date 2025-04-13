
function getDataCount(copsData, key, search)
    local count = 0

    for k,v in pairs(copsData) do
        for o,i in pairs(search) do 
            if v[key] == i then 
                count = count + 1
            end 
        end 
    end 

    return count
end

function nameToIcon(name)
    return name:gsub(" ", "+")
end

local cam = nil
local camThread = nil

function startPlayerCamera()
    local playerPed = PlayerPedId()

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 0, true, true)

    SetPlayerControl(PlayerId(), true, 0)

    camThread = CreateThread(function()
        while cam do
            local coords = GetEntityCoords(playerPed)
            local forward = GetEntityForwardVector(playerPed)
            local camCoords = coords + forward * 2.0 + vector3(0.0, 0.0, 0.7)
            SetCamCoord(cam, camCoords.x, camCoords.y, camCoords.z)

            local playerHeading = GetEntityHeading(playerPed)

            local camRot = GetGameplayCamRot(2)
            local pitch = camRot.x
            local yaw = camRot.z

            local deltaYaw = yaw - playerHeading

            if deltaYaw > 180.0 then deltaYaw = deltaYaw - 360.0 end
            if deltaYaw < -180.0 then deltaYaw = deltaYaw + 360.0 end

            if deltaYaw > 60.0 then
                yaw = playerHeading + 60.0
            elseif deltaYaw < -60.0 then
                yaw = playerHeading - 60.0
            end

            SetCamRot(cam, pitch, 0.0, yaw, 2)

            Wait(0)
        end
    end)
end

function stopPlayerCamera()
    if cam then
        RenderScriptCams(false, false, 0, true, true)
        DestroyCam(cam, false)
        cam = nil
    end
end


function screenshot(type, id)
    local url = ""
    exports['screenshot-basic']:requestScreenshotUpload(Config.ImgWebhook, 'files[]', function(data)
        local result = json.decode(data)
        url = (result.attachments)[1].url
        TriggerServerEvent('fmdt:saveImage', url, type, id)
    end)
    return url
end

function trackVehicle(plate)
    local success = false
    local timer = GlobalState.timer

    if (GlobalState.timer)['vehicle'] > 0 then 
        return false
    end 

    for k,v in pairs(ESX.Game.GetVehicles()) do 
        if string.gsub(string.lower(GetVehicleNumberPlateText(v)), " ", "") == string.gsub(string.lower(plate), " ", "") then 
            success = true
            local coords = {x = GetEntityCoords(v).x, y = GetEntityCoords(v).y}
            TriggerServerEvent('fmdt:addTracker', "vehicle", coords, plate)
        end 
    end 

    return success
end 

function tablesEqual(t1, t2)
    if t1 == t2 then return true end
    if type(t1) ~= "table" or type(t2) ~= "table" then return false end

    for k, v in pairs(t1) do
        if type(v) == "table" and type(t2[k]) == "table" then
            if not tablesEqual(v, t2[k]) then return false end
        elseif t2[k] ~= v then
            return false
        end
    end

    for k in pairs(t2) do
        if t1[k] == nil then return false end
    end

    return true
end

function toMapCoords(coords)
    local x = Config.MapAlignment.defaultX + (coords.x * Config.MapAlignment.xMultiply)
    local y = Config.MapAlignment.defaultY + (coords.y * Config.MapAlignment.yMultiply)
    return {x = x, y = y}
end 

function toRealCoords(coords)
    local x = (coords.x - Config.MapAlignment.defaultX) / Config.MapAlignment.xMultiply
    local y = (coords.y - Config.MapAlignment.defaultY) / Config.MapAlignment.yMultiply
    return {x = x, y = y}
end


function secondsToTime(sec)
    local mins = math.floor(sec / 60)
    local restSecs = sec % 60
    return string.format("%02d:%02d", mins, restSecs)
end

function formatBadgeNumber(badgeNumber)
    local badgeNumberString = tostring(badgeNumber)
    return string.sub(badgeNumberString, 1, 2) .. "-" .. string.sub(badgeNumberString, 3)
end

function formatPrice(price)
    local formatted = tostring(price):reverse():gsub("(%d%d%d)", "%1."):reverse()
    if formatted:sub(1, 1) == "." then
        formatted = formatted:sub(2)
    end
    return "$" .. formatted
end

function formatDate(dateString)
    local year, month, day = dateString:match("(%d+)%-(%d+)%-(%d+)")
    return string.format("%s.%s.%s", day, month, year)
end

function valueToLabel(value)
    local result = string.gsub(value, "_", " ")
    return result
end

function labelToValue(value)
    local result = string.gsub(value, " ", "_")
    return result
end


