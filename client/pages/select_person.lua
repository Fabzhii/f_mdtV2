
locales = Config.Locales[Config.Language]

RegisterNUICallback('select_person', function(data, cb)

    local identifier = data.identifier
    local userData = getUser(identifier)
    local notesData = getNotes(identifier)
    local crimeData = getCrimes(identifier)

    local notes = ""
    local crimes = ""

    for k,v in pairs(notesData) do 
        notes = notes .. select_person_note(
            v.officer,
            v.time,
            identifier,
            v.identifier,
            v.text
        )
    end 

    for k,v in pairs(crimeData) do 
        crimes = crimes .. select_person_crime(
            v.crime, 
            v.description, 
            v.time, 
            locales['pages']['citizen']['div_6_crime_options'][v.status],
            v.officer,
            identifier,
            v.identifier,
            v.status
        )
    end 

    cb(([[
        <div class="mt-4 px-4 max-h-[72vh] overflow-y-auto">
            <div class="w-full">
                <h2 class="text-gray-100 font-bold">%s</h2>
                <sl-divider class="w-full h-[1px] bg-neutral-500" style="height: 2px;"></sl-divider>
            </div>

            <div class="flex flex-row w-full pt-4 justify-between gap-4">

                <div class="w-1/2 flex flex-col items-center">
                    <img src="./img/user.png" alt="user" class="h-32 w-32">

                    <sl-dropdown hoist placement="bottom-start" class="self-center pt-4">
                        <sl-button slot="trigger" caret>%s</sl-button>

                        <sl-menu>
                            %s
                            <sl-divider class="h-[1px] bg-neutral-500"></sl-divider>

                            <sl-menu-item onclick="htmx.ajax('POST', '/camera_clicked', { values: { type: 'user', id: '%s' }, swap: 'none' })">
                                %s
                                <sl-icon slot="prefix" name="camera"></sl-icon>
                            </sl-menu-item>

                        </sl-menu>
                    </sl-dropdown>
                </div>
                
                <div class="w-full">
                    <h2 class="text-gray-100">%s</h2>
                    <div class="flex flex-row gap-2 items-center">
                        <h3 class="text-neutral-500">%s</h3>
                        <sl-icon-button name="ban" class="opacity-0 pointer-events-none select-none"></sl-icon-button>
                    </div>
                    <sl-divider class="w-full h-[1px] bg-neutral-500 mb-8"></sl-divider>
                    <div class="flex flex-row gap-2">
                        <h2 class="text-neutral-500">%s</h2>
                        <h3 class="text-gray-100 font-bold">%s</h3>
                    </div>
                    <div class="flex flex-row gap-2">
                        <h2 class="text-neutral-500">%s</h2>
                        <h3 class="text-gray-100 font-bold">%s</h3>
                    </div>
                    <div class="flex flex-row gap-2">
                        <h2 class="text-neutral-500">%s</h2>
                        <h3 class="text-gray-100 font-bold">%s</h3>
                    </div>
                    <div class="flex flex-row gap-2">
                        <h2 class="text-neutral-500">%s</h2>
                        <h3 class="text-gray-100 font-bold">%s</h3>
                    </div>
                </div>

                <div class="w-full">
                    <h2 class="text-gray-100">%s</h2>
                    <div class="flex flex-row gap-2 items-center">
                        <h3 class="text-neutral-500">%s</h3>
                        <sl-icon-button
                            name="pencil-square"
                            hx-post="/edit_personal_information"
                            hx-target="#personal_information"
                            hx-swap="innerHTML"
                            hx-vals='{"identifier": "%s"}'
                        />
                    </div>
                    <sl-divider class="w-full h-[1px] bg-neutral-500 mb-8"></sl-divider>
                    <div id="personal_information">
                        <div class="flex flex-row gap-2">
                            <h2 class="text-neutral-500">%s</h2>
                            <h3 class="text-gray-100 font-bold">%s</h3>
                        </div>
                        <div class="flex flex-row gap-2">
                            <h2 class="text-neutral-500">%s</h2>
                            <h3 class="text-gray-100 font-bold">%s</h3>
                        </div>
                        <div class="flex flex-row gap-2">
                            <h2 class="text-neutral-500">%s</h2>
                            <h3 class="text-gray-100 font-bold">%s</h3>
                        </div>
                    </div>
                </div>

                <div class="w-full">
                    <h2 class="text-gray-100">%s</h2>
                    <div class="flex flex-row gap-2 items-center">
                        <h3 class="text-neutral-500">%s</h3>
                        <sl-icon-button
                            name="pencil-square"
                            hx-post="/edit_warrant_information"
                            hx-target="#warrant_information"
                            hx-swap="innerHTML"
                            hx-vals='{"identifier": "%s"}'
                        />
                    </div>
                    <sl-divider class="w-full h-[1px] bg-neutral-500 mb-8"></sl-divider>
                    <div id="warrant_information">
                        <div class="flex flex-row gap-2">
                            <h2 class="text-neutral-500">%s</h2>
                            <h3 class="text-gray-100 font-bold">%s</h3>
                        </div>
                        <div class="flex flex-row gap-2">
                            <h2 class="text-neutral-500">%s</h2>
                            <h3 class="text-gray-100 font-bold">%s</h3>
                        </div>
                        <div class="flex flex-row gap-2">
                            <h2 class="text-neutral-500">%s</h2>
                            <h3 class="text-gray-100 font-bold">%s</h3>
                        </div>
                    </div>
                </div>

                <div class="w-full">
                    <h2 class="text-gray-100">%s</h2>
                    <div class="flex flex-row gap-2 items-center">
                        <h3 class="text-neutral-500">%s</h3>
                        <sl-icon-button name="ban" class="opacity-0 pointer-events-none select-none"></sl-icon-button>
                    </div>
                    <sl-divider class="w-full h-[1px] bg-neutral-500 mb-8"></sl-divider>
                    <div class="flex flex-col gap-2">
                        %s
                    </div>
                </div>
            </div>

            <div class="w-full pt-4">
                <h2 class="text-gray-100">%s</h2>
                <sl-divider class="w-full h-[1px] bg-neutral-500" style="height: 2px;"></sl-divider>
                <div id="notes_box" class="grid grid-cols-3 items-start gap-4">
                    %s
                    <sl-card class="card-basic text-neutral-500  pt-4 pr-4">
                        <div 
                            class="w-[22vw] max-w-[22vw] text-center" 
                            style="cursor: pointer;"
                            hx-post="/add_note"
                            hx-vals='{"identifier": "%s"}'
                            hx-trigger="click"
                            hx-target="closest .card-basic"
                            hx-swap="outerHTML">%s   
                        </div>
                    </sl-card>

                </div>  
            </div>

            <div class="w-full pt-8">
                <h2 class="text-gray-100">%s</h2>
                <sl-divider class="w-full h-[1px] bg-neutral-500" style="height: 2px;"></sl-divider>

                <div class="grid grid-cols-6 gap-4 text-sm text-gray-100 pt-4 w-full">

                    <div class="font-bold col-span-1">%s</div>
                    <div class="font-bold col-span-1">%s</div>
                    <div class="font-bold col-span-1">%s</div>
                    <div class="font-bold col-span-1">%s</div>
                    <div class="font-bold col-span-1">%s</div>
                    <div class="font-bold col-span-1">%s</div>

                    <div class="col-span-6">
                        <sl-divider class="-mt-4 bg-neutral-600 h-[1px] w-full"></sl-divider>
                    </div>

                    <div class="col-span-6" id="crimes">
                        %s

                        <div class="col-span-6">
                            <sl-card class="card-basic text-neutral-500 w-full">
                                <div 
                                    class="text-center" 
                                    style="cursor: pointer;"
                                    hx-post="/add_crime"
                                    hx-vals='{"identifier": "%s"}'
                                    hx-trigger="click"
                                    hx-target="closest .card-basic"
                                    hx-swap="outerHTML">%s
                                </div>
                            </sl-card>
                        </div>

                    </div>
                 
                </div>
            </div>


        </div>

    ]]):format(
        (userData.firstname .. ' ' .. userData.lastname),

            
        locales['pages']['citizen']['pictures'],
        citizen_div_4_images(json.decode(userData.images)),
        userData.identifier,
        locales['pages']['citizen']['take_pictures'],

        --div_1
        locales['pages']['citizen']['div_1_header'],
        locales['pages']['citizen']['div_1_subheader'],
        locales['pages']['citizen']['div_1_firstname'], userData.firstname,
        locales['pages']['citizen']['div_1_lastname'], userData.lastname,
        locales['pages']['citizen']['div_1_dateofbirth'], userData.dateofbirth,
        locales['pages']['citizen']['div_1_sex'], locales['pages']['citizen']['div_1_sex_options'][userData.sex],

        --div_2
        locales['pages']['citizen']['div_2_header'],
        locales['pages']['citizen']['div_2_subheader'],
        userData.identifier,
        locales['pages']['citizen']['div_2_tel'], json.decode(userData.editinfo).telefon,
        locales['pages']['citizen']['div_2_email'], json.decode(userData.editinfo).email,
        locales['pages']['citizen']['div_2_job'], json.decode(userData.editinfo).job,

        --div_3
        locales['pages']['citizen']['div_3_header'],
        locales['pages']['citizen']['div_3_subheader'],
        userData.identifier,
        locales['pages']['citizen']['div_3_status'], locales['pages']['citizen']['div_3_status_options'][json.decode(userData.warrant).state],
        locales['pages']['citizen']['div_3_reason'], json.decode(userData.warrant).reason,
        locales['pages']['citizen']['div_3_infos'], json.decode(userData.warrant).infos,

        --div_3
        locales['pages']['citizen']['div_4_header'],
        locales['pages']['citizen']['div_4_subheader'],
        citizen_div_4_licenses(getLicenses(identifier)),

        locales['pages']['citizen']['div_5_header'],
        notes,
        identifier,
        locales['pages']['citizen']['div_5_add_note'],

        locales['pages']['citizen']['div_6_header'],
        locales['pages']['citizen']['div_6_crime'],
        locales['pages']['citizen']['div_6_description'],
        locales['pages']['citizen']['div_6_time'],
        locales['pages']['citizen']['div_6_status'],
        locales['pages']['citizen']['div_6_officer'],
        locales['pages']['citizen']['div_6_actions'],
        crimes,
        identifier,
        locales['pages']['citizen']['div_6_add_crime']
    ))
end)


RegisterNUICallback('camera_clicked', function(data, cb)

    local type = data.type
    local id = data.id

    SetNuiFocus(false, false)
    DisplayRadar(false)
    SendNUIMessage({
        type = 'hide',
    })

    startPlayerCamera()

    if lib.progressCircle({
        position = 'bottom',
        duration = 5000,
        label = locales['pages']['citizen']['taking_picture'],
        useWhileDead = false,
        canCancel = true,
        disable = {
        },
        anim = {
            dict = 'amb@world_human_paparazzi@male@base',
            clip = 'base'
        },
        prop = {
            model = `prop_pap_camera_01`,
            bone = 28422,
            pos = vec3(0.0, 0.0, 0.0),
            rot = vec3(0.0, 0.0, 0.0)
        },
    }) then 
        screenshot(type, id)  
    end

    stopPlayerCamera()

    cb([[]])
end)

RegisterNUICallback('edit_personal_information', function(data, cb)

    local identifier = data.identifier
    local userData = getUser(identifier)

    cb(([[
        <sl-card class="w-full">
            <div slot="header">
                <h2 class="text-gray-100 font-bold">%s</h2>
            </div>

            <form hx-post="/submit_personal_information" 
                hx-trigger="submit" 
                hx-swap="innerHTML"
                hx-target="#personal_information"
                hx-vals='js:{ identifier: "%s", phone_number: document.querySelector("#phone_number").value, email: document.querySelector("#email").value, job: document.querySelector("#job").value}'>
                
                <sl-input id="phone_number" class="text-neutral-500" label="%s" value="%s"></sl-input>
                <sl-input id="email" class="text-neutral-500" label="%s" value="%s"></sl-input>
                <sl-input id="job" class="text-neutral-500" label="%s" value="%s"></sl-input>
                
                <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
            </form>

        </sl-card>
    ]]):format(
        locales['pages']['citizen']['edit_personal_information_header'],
        identifier,
        locales['pages']['citizen']['edit_personal_information_tel'], json.decode(userData.editinfo).telefon,
        locales['pages']['citizen']['edit_personal_information_email'], json.decode(userData.editinfo).email,
        locales['pages']['citizen']['edit_personal_information_job'], json.decode(userData.editinfo).job,
        locales['pages']['citizen']['edit_personal_information_submit']
    ))
end)

RegisterNUICallback('submit_personal_information', function(data, cb)
    local email = data.email
    local telefon = data.phone_number
    local job = data.job
    local identifier = data.identifier

    local userData = changePersonalInformation(identifier, telefon, email, job)

    cb(([[
        <div class="flex flex-row gap-2">
            <h2 class="text-neutral-500">%s</h2>
            <h3 class="text-gray-100 font-bold">%s</h3>
        </div>
        <div class="flex flex-row gap-2">
            <h2 class="text-neutral-500">%s</h2>
            <h3 class="text-gray-100 font-bold">%s</h3>
        </div>
        <div class="flex flex-row gap-2">
            <h2 class="text-neutral-500">%s</h2>
            <h3 class="text-gray-100 font-bold">%s</h3>
        </div>
    ]]):format(
        locales['pages']['citizen']['div_2_tel'], telefon,
        locales['pages']['citizen']['div_2_email'], email,
        locales['pages']['citizen']['div_2_job'], job
    ))
end)

RegisterNUICallback('edit_warrant_information', function(data, cb)

    local identifier = data.identifier
    local userData = getUser(identifier)

    cb(([[
        <sl-card class="w-full">
            <div slot="header">
                <h2 class="text-gray-100 font-bold">%s</h2>
            </div>

            <form hx-post="/submit_warrant_information" 
                hx-trigger="submit" 
                hx-swap="innerHTML"
                hx-target="#warrant_information"
                hx-vals='js:{ identifier: "%s", state: document.querySelector("#state").checked, reason: document.querySelector("#reason").value, infos: document.querySelector("#infos").value}'>
                
                <sl-checkbox id="state" class="text-neutral-500 pb-4" %s>%s</sl-checkbox>
                <sl-input id="reason" class="text-neutral-500" label="%s" value="%s"></sl-input>
                <sl-textarea id="infos" class="text-neutral-500 mt-4" label="%s" value="%s"></sl-textarea>
                
                <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
            </form>

        </sl-card>
    ]]):format(
        locales['pages']['citizen']['edit_warrant_information_header'],
        identifier,
        (json.decode(userData.warrant).state and "checked" or ""), locales['pages']['citizen']['edit_warrant_information_status'],
        locales['pages']['citizen']['edit_warrant_information_reason'], json.decode(userData.warrant).reason,
        locales['pages']['citizen']['edit_warrant_information_infos'], json.decode(userData.warrant).infos,
        locales['pages']['citizen']['edit_warrant_information_submit']
    ))
end)

RegisterNUICallback('submit_warrant_information', function(data, cb)
    local state = data.state
    local reason = data.reason
    local infos = data.infos
    local identifier = data.identifier

    if state == false then 
        reason = 'n/A'
        infos = 'n/A'
    end 

    local userData = changeWarrantInformation(identifier, state, reason, infos)

    cb(([[
        <div class="flex flex-row gap-2">
            <h2 class="text-neutral-500">%s</h2>
            <h3 class="text-gray-100 font-bold">%s</h3>
        </div>
        <div class="flex flex-row gap-2">
            <h2 class="text-neutral-500">%s</h2>
            <h3 class="text-gray-100 font-bold">%s</h3>
        </div>
        <div class="flex flex-row gap-2">
            <h2 class="text-neutral-500">%s</h2>
            <h3 class="text-gray-100 font-bold">%s</h3>
        </div>
    ]]):format(
        locales['pages']['citizen']['div_3_status'], locales['pages']['citizen']['div_3_status_options'][state],
        locales['pages']['citizen']['div_3_reason'], reason,
        locales['pages']['citizen']['div_3_infos'], infos
    ))
end)

RegisterNUICallback('add_note', function(data, cb)

    local identifier = data.identifier

    cb(([[
        <sl-card class="card-header text-neutral-500 pt-4 pr-4">
            <div slot="header" class="text-gray-100 font-bold flex flex-row justify-between">
                %s
            </div>
            <div class="w-[22vw] max-w-[22vw]">
                <form hx-post="/submit_note" 
                    hx-trigger="submit" 
                    hx-swap="innerHTML"
                    hx-target="#notes_box"
                    hx-vals='js:{ identifier: "%s", text: document.querySelector("#text").value}'>
                    
                    <sl-textarea id="text" class="text-neutral-500" label="%s"></sl-textarea>
                    
                    <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
                </form>  
            </div>
        </sl-card>
    ]]):format(
        locales['pages']['citizen']['div_5_add_note'],
        identifier,
        locales['pages']['citizen']['div_5_note_text'],
        locales['pages']['citizen']['div_5_note_submit']
    ))
end)

RegisterNUICallback('submit_note', function(data, cb)

    local identifier = data.identifier
    local text = data.text

    local notesData = addNote(identifier, text)
    local notes = ""

    for k,v in pairs(notesData) do 
        notes = notes .. select_person_note(
            v.officer,
            v.time,
            identifier,
            v.identifier,
            v.text
        )
    end 

    cb(([[
        %s
        <sl-card class="card-basic text-neutral-500  pt-4 pr-4">
            <div 
                class="w-[22vw] max-w-[22vw] text-center" 
                style="cursor: pointer;"
                hx-post="/add_note"
                hx-vals='{"identifier": "%s"}'
                hx-trigger="click"
                hx-target="closest .card-basic"
                hx-swap="outerHTML">%s   
            </div>
        </sl-card>
    ]]):format(
        notes,
        identifier,
        locales['pages']['citizen']['div_5_add_note']
    ))
end)

RegisterNUICallback('delete_note', function(data, cb)
    local identifier = data.identifier
    local note_id = data.note_id
    local notesData = deleteNote(identifier, note_id)
    cb([[]])
end)

RegisterNUICallback('add_crime', function(data, cb)
    local identifier = data.identifier
    
    cb(([[
        <sl-card class="card-header text-neutral-500 w-full">
            <div slot="header" class="text-gray-100 font-bold flex flex-row justify-between">
                %s
            </div>
            <div class="w-full">
                <form 
                    hx-post="/submit_crime"
                    hx-trigger="submit"
                    hx-swap="innerHTML"
                    hx-target="#crimes"
                    hx-vals='js:{ identifier: "%s", text: document.querySelector("#text").value, crime_type: document.querySelector("#crime_type").value }'
                    class="flex flex-row gap-4 justify-between w-full"
                    >
                    <sl-select id="crime_type" label="%s" class="w-full">
                        %s
                    </sl-select>

                    <sl-textarea id="text" class="text-neutral-500 w-full"" label="%s"></sl-textarea>

                    <sl-button type="submit" variant="primary" class="mt-6 w-full">
                        %s
                    </sl-button>
                </form>

            </div>
        </sl-card>
    ]]):format(
        locales['pages']['citizen']['div_6_add_crime'],
        identifier,
        locales['pages']['citizen']['div_6_crime_crime'],
        select_person_crimes(getLaw()),
        locales['pages']['citizen']['div_6_crime_description'],
        locales['pages']['citizen']['div_6_crime_submit']
    ))
end)

RegisterNUICallback('submit_crime', function(data, cb)
    local identifier = data.identifier
    local description = data.text
    local crime_type = string.gsub((data.crime_type), "_", " ")

    local crimeData = addCrime(identifier, crime_type, description)
    local crimes = ""

    for k,v in pairs(crimeData) do 
        crimes = crimes .. select_person_crime(
            v.crime, 
            v.description, 
            v.time, 
            locales['pages']['citizen']['div_6_crime_options'][v.status],
            v.officer,
            identifier,
            v.identifier,
            v.status
        )
    end 

    cb(([[
        %s
        <div class="col-span-6">
            <sl-card class="card-basic text-neutral-500 w-full">
                <div 
                    class="text-center" 
                    style="cursor: pointer;"
                    hx-post="/add_crime"
                    hx-vals='{"identifier": "%s"}'
                    hx-trigger="click"
                    hx-target="closest .card-basic"
                    hx-swap="outerHTML">%s
                </div>
            </sl-card>
        </div>
    ]]):format(
        crimes,
        identifier,
        locales['pages']['citizen']['div_6_add_crime']
    ))
end)


RegisterNUICallback('delete_crime', function(data, cb)
    local identifier = data.identifier
    local crime_id = data.crime_id
    local crimeData = deleteCrime(identifier, crime_id)
    cb([[]])
end)

RegisterNUICallback('change_crime_status', function(data, cb)
    local identifier = data.identifier
    local crime_id = data.crime_id
    local status = not data.status

    local crimeData = changeCrimeStatus(identifier, crime_id, status)
    
    cb(([[
        <sl-badge
            variant="%s"
            class="cursor-pointer"
            hx-post="/change_crime_status"
            hx-vals='{"identifier": "%s", "crime_id": "%s", "status": %s}'
            hx-trigger="click"
            hx-swap="outerHTML">%s
        </sl-badge>
    ]]):format(
        locales['pages']['citizen']['div_6_crime_options'][status][1],
        identifier,
        crime_id,
        status,
        locales['pages']['citizen']['div_6_crime_options'][status][2]
    ))
end)