
locales = Config.Locales[Config.Language]

RegisterNUICallback('load_lists', function(data, cb)

    local selfData      = getSelfData()

    cb(([[
        <div>
            <sl-tab-group>
                <sl-tab slot="nav" panel="name" disabled>%s</sl-tab>
                <sl-tab slot="nav" panel="space1" disabled>|</sl-tab>
                <sl-tab slot="nav" panel="grade" disabled>%s</sl-tab>
                <sl-tab slot="nav" panel="space2" disabled> </sl-tab>
                <sl-tab slot="nav" panel="space3" disabled> </sl-tab>

                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_dashboard" panel="dashboard">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_control_center" panel="control_center">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_citizen_search" panel="citizen_search">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_vehicle_search" panel="vehicle_search">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_weapon_search" panel="weapon_search">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_tracking" panel="tracking">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_dispatches" panel="dispatches">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_lists" panel="lists" active>%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_documents" panel="documents">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_calculator" panel="calculator">%s</sl-tab>
            </sl-tab-group>
            
            <sl-tab-group class="w-full">
                <sl-tab slot="nav" panel="space" disabled></sl-tab>
                <sl-tab slot="nav" panel="space" disabled></sl-tab>
                <sl-tab slot="nav" panel="space" disabled></sl-tab>

                <sl-tab slot="nav" panel="employee" active>%s</sl-tab>

                <sl-tab slot="nav" panel="space" disabled></sl-tab>
                <sl-tab slot="nav" panel="space" disabled></sl-tab>
                <sl-tab slot="nav" panel="space" disabled></sl-tab>

                <sl-tab slot="nav" panel="vehicles">%s</sl-tab>

                <sl-tab slot="nav" panel="space" disabled></sl-tab>
                <sl-tab slot="nav" panel="space" disabled></sl-tab>
                <sl-tab slot="nav" panel="space" disabled></sl-tab>

                <sl-tab slot="nav" panel="outfits">%s</sl-tab>

                <sl-tab slot="nav" panel="space" disabled></sl-tab>
                <sl-tab slot="nav" panel="space" disabled></sl-tab>
                <sl-tab slot="nav" panel="space" disabled></sl-tab>

                <sl-tab slot="nav" panel="codes">%s</sl-tab>

                <sl-tab slot="nav" panel="space" disabled></sl-tab>
                <sl-tab slot="nav" panel="space" disabled></sl-tab>
                <sl-tab slot="nav" panel="space" disabled></sl-tab>

                <sl-tab slot="nav" panel="training">%s</sl-tab>

                <sl-tab slot="nav" panel="space" disabled></sl-tab>
                <sl-tab slot="nav" panel="space" disabled></sl-tab>
                <sl-tab slot="nav" panel="space" disabled></sl-tab>

                <sl-tab slot="nav" panel="law">%s</sl-tab>

                <sl-tab slot="nav" panel="space" disabled></sl-tab>
                <sl-tab slot="nav" panel="space" disabled></sl-tab>
                <sl-tab slot="nav" panel="space" disabled></sl-tab>

                <sl-tab-panel name="employee">
                    <div id="list_employee" class="p-4 w-full"></div>
                    <div
                        hx-get="/list_load_employee"
                        hx-trigger="load"
                        hx-target="#list_employee"
                        hx-swap="innerHTML">
                    </div>
                </sl-tab-panel>

                <sl-tab-panel name="vehicles">
                    <div id="list_vehicles" class="p-4 w-full"></div>
                    <div
                        hx-get="/list_load_vehicles"
                        hx-trigger="load"
                        hx-target="#list_vehicles"
                        hx-swap="innerHTML">
                    </div>
                </sl-tab-panel>

                <sl-tab-panel name="outfits">
                    <div id="list_outfits" class="p-4 w-full"></div>
                    <div
                        hx-get="/list_load_outfits"
                        hx-trigger="load"
                        hx-target="#list_outfits"
                        hx-swap="innerHTML">
                    </div>
                </sl-tab-panel>

                <sl-tab-panel name="codes">
                    <div id="list_codes" class="p-4 w-full"></div>
                    <div
                        hx-get="/list_load_codes"
                        hx-trigger="load"
                        hx-target="#list_codes"
                        hx-swap="innerHTML">
                    </div>
                </sl-tab-panel>

                
                <sl-tab-panel name="training">
                    <div id="list_training" class="p-4 w-full"></div>
                    <div
                        hx-get="/list_load_training"
                        hx-trigger="load"
                        hx-target="#list_training"
                        hx-swap="innerHTML">
                    </div>
                </sl-tab-panel>

                <sl-tab-panel name="law">
                    <div id="list_law" class="p-4 w-full"></div>
                    <div
                        hx-get="/list_load_law"
                        hx-trigger="load"
                        hx-target="#list_law"
                        hx-swap="innerHTML">
                    </div>
                </sl-tab-panel>
            </sl-tab-group>


        
        </div>
    ]]):format(

        -- header
        selfData.name,
        (selfData.job_label .. ' ' .. selfData.job_grade_label),

        -- buttons
        locales['sidebar']['dashboard'],
        locales['sidebar']['control_center'],
        locales['sidebar']['citizen_search'],
        locales['sidebar']['vehicle_search'],
        locales['sidebar']['weapon_search'],
        locales['sidebar']['tracking'],
        locales['sidebar']['dispatches'],
        locales['sidebar']['lists'],
        locales['sidebar']['documents'],
        locales['sidebar']['calculator'],

        locales['pages']['lists']['header']['employee'],
        locales['pages']['lists']['header']['vehicles'],
        locales['pages']['lists']['header']['outfits'],
        locales['pages']['lists']['header']['codes'],
        locales['pages']['lists']['header']['training'],
        locales['pages']['lists']['header']['law']

    ))
end)



RegisterNUICallback('list_load_employee', function(data, cb)

    local employee = ""
    local units = ""
    local listEmployeeData = getListEmployeeData()

    for k,v in pairs(locales['units']) do 
        units = units .. ([[<sl-option value="%s">%s</sl-option>]]):format(k, v)
    end 

    for k,v in pairs(listEmployeeData) do 
        local officer = ""

        for o,i in pairs(v.officer) do 

            local trainings = ""
            for m,n in pairs(i.trainings) do 
                for z,u in pairs(Config.Trainings) do 
                    if u.id == n then 
                        trainings = trainings .. ([[
                            <sl-menu-item 
                                value="%s"
                                hx-post="/remove_training"
                                hx-vals='{"training": "%s", "identifier": "%s"}'
                                hx-swap="outerHTML"
                                hx-target="closest .player_trainings"
                                hx-trigger="click">%s
                            </sl-menu-item>
                        ]]):format(z, u.id, i.identifier, u.locales[Config.Language].label)
                    end 
                end 
            end 

            officer = officer .. ([[
            <div class="crime col-span-8 grid grid-cols-8 gap-4 pb-2">
                <div class="col-span-1">%s</div>
                <div class="col-span-1">%s</div>
                <div class="col-span-1">%s</div>

                <div class="callnumber relative inline-block">
                    <sl-dropdown>
                        <sl-badge
                            slot="trigger"
                            variant="success"
                            style="cursor: pointer;">%s
                        </sl-badge>

                        <sl-card class="w-[13vw]">
                            <div slot="header">
                                <h2 class="text-gray-100 font-bold">%s</h2>
                            </div>
                            <form hx-post="/employee_edit_callnumber" 
                                hx-trigger="submit" 
                                hx-swap="outerHTML"
                                hx-target="closest .callnumber"
                                hx-vals='js:{ id: "%s", identifier: "%s", callnumber: document.querySelector("#callnumber-%s").value}'>
                                <sl-input id="callnumber-%s" label="%s" class="text-neutral-500 mt-4" value="%s" type="number" min="1" max="999" step="1"></sl-input>
                                <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
                            </form>
                        </sl-card>
                    </sl-dropdown>
                </div>

                <div class="badgenumber relative inline-block">
                    <sl-dropdown>
                        <sl-badge
                            slot="trigger"
                            variant="primary"
                            style="cursor: pointer;">%s
                        </sl-badge>

                        <sl-card class="w-[13vw]">
                            <div slot="header">
                                <h2 class="text-gray-100 font-bold">%s</h2>
                            </div>
                            <form hx-post="/employee_edit_badgenumber" 
                                hx-trigger="submit" 
                                hx-swap="outerHTML"
                                hx-target="closest .badgenumber"
                                hx-vals='js:{ id: "%s", identifier: "%s", badgenumber: document.querySelector("#badgenumber-%s").value}'>
                                <sl-input id="badgenumber-%s" label="%s" class="text-neutral-500 mt-4" value="%s" type="number" min="10000" max="99999" step="1"></sl-input>
                                <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
                            </form>
                        </sl-card>
                    </sl-dropdown>
                </div>

                <div class="unit relative inline-block">
                    <sl-dropdown>
                        <div class="col-span-1" slot="trigger" style="cursor: pointer;">%s</div>

                        <sl-card class="w-[13vw]">
                            <div slot="header">
                                <h2 class="text-gray-100 font-bold">%s</h2>
                            </div>
                            <form hx-post="/employee_edit_unit" 
                                hx-trigger="submit" 
                                hx-swap="outerHTML"
                                hx-target="closest .unit"
                                hx-vals='js:{ id: "%s", identifier: "%s", unit: document.querySelector("#unit-%s").value}'>

                                <sl-select id="unit-%s" label="%s" class="text-neutral-500 mt-4" value="%s">
                                    %s
                                </sl-select>

                                <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
                            </form>
                        </sl-card>
                    </sl-dropdown>
                </div>

                <div class="infos relative inline-block">
                    <sl-dropdown>
                        <div class="col-span-1" slot="trigger" style="cursor: pointer;">%s</div>

                        <sl-card class="w-[13vw]">
                            <div slot="header">
                                <h2 class="text-gray-100 font-bold">%s</h2>
                            </div>
                            <form hx-post="/employee_edit_infos" 
                                hx-trigger="submit" 
                                hx-swap="outerHTML"
                                hx-target="closest .infos"
                                hx-vals='js:{ id: "%s", identifier: "%s", infos: document.querySelector("#infos-%s").value}'>
                                <sl-textarea id="infos-%s" label="%s" class="text-neutral-500 mt-4" value="%s"></sl-textarea>
                                <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
                            </form>
                        </sl-card>
                    </sl-dropdown>
                </div>

                <div class="player_trainings relative inline-block">
                    <sl-dropdown placement="top-start">
                        <div class="col-span-1" slot="trigger" style="cursor: pointer;">%s</div>

                        <sl-menu>
                            %s
                        </sl-menu>
                    </sl-dropdown>
                </div>

            </div>
            ]]):format(
                i.name,
                i.dob,
                i.phone_number,

                i.callNumber,
                locales['pages']['lists']['employee']['callnumber_header'],
                (k..o),
                i.identifier,
                (k..o),
                (k..o),
                locales['pages']['lists']['employee']['callnumber_description'],
                i.callNumber,
                locales['pages']['lists']['employee']['callnumber_button'],

                formatBadgeNumber(i.badgeNumber),
                locales['pages']['lists']['employee']['badgenumber_header'],
                (k..o),
                i.identifier,
                (k..o),
                (k..o),
                locales['pages']['lists']['employee']['badgenumber_description'],
                i.badgeNumber,
                locales['pages']['lists']['employee']['badgenumber_button'],


                locales['units'][i.unit],
                locales['pages']['lists']['employee']['unit_header'],
                (k..o),
                i.identifier,
                (k..o),
                (k..o),
                locales['pages']['lists']['employee']['unit_description'],
                i.unit,
                units,
                locales['pages']['lists']['employee']['unit_button'],


                (i.info or "n/A"),
                locales['pages']['lists']['employee']['notes_header'],
                (k..o),
                i.identifier,
                (k..o),
                (k..o),
                locales['pages']['lists']['employee']['notes_description'],
                (i.info or "n/A"),
                locales['pages']['lists']['employee']['notes_button'],



                (#(i.trainings) .. "/" .. #(Config.Trainings)),
                trainings
            )
        end 

        employee = employee .. ([[
            <div class="col-span-8 flex flex-col">
                <div class="font-bold col-span-1">%s - %s</div>
                <sl-divider class="-mt-[2px] bg-neutral-600 h-[1px] w-full"></sl-divider>
                %s
            </div>

        ]]):format(
            v.job_label,
            v.grade_label,
            officer
        )
    end 

    cb(([[
        <div>
            <div class="grid grid-cols-8 gap-4 text-sm text-gray-100 pt-4 w-full max-h-[64vh] overflow-y-auto">

                <div class="font-bold col-span-1">%s</div>
                <div class="font-bold col-span-1">%s</div>
                <div class="font-bold col-span-1">%s</div>
                <div class="font-bold col-span-1">%s</div>
                <div class="font-bold col-span-1">%s</div>
                <div class="font-bold col-span-1">%s</div>
                <div class="font-bold col-span-1">%s</div>
                <div class="font-bold col-span-1">%s</div>

                <div class="col-span-8">
                    <sl-divider class="-mt-4 bg-neutral-600 h-[2px] w-full"></sl-divider>
                </div>
                %s
            </div>
        </div>
    ]]):format(
        locales['pages']['lists']['employee']['header_name'],
        locales['pages']['lists']['employee']['header_dob'],
        locales['pages']['lists']['employee']['header_tel'],
        locales['pages']['lists']['employee']['header_callnumber'],
        locales['pages']['lists']['employee']['header_badgenummer'],
        locales['pages']['lists']['employee']['header_unit'],
        locales['pages']['lists']['employee']['header_notes'],
        locales['pages']['lists']['employee']['header_trainings'],
        employee
    ))
end)

RegisterNUICallback('remove_training', function(data, cb)
    local identifier = data.identifier
    local training = data.training

    local listEmployeeData = removeTraining(identifier, training)

    for k,v in pairs(listEmployeeData) do 
        for o,i in pairs(v.officer) do 
            if i.identifier == identifier then 

                local trainings = ""
                for m,n in pairs(i.trainings) do 
                    for z,u in pairs(Config.Trainings) do 
                        if u.id == n then 
                            trainings = trainings .. ([[
                                <sl-menu-item 
                                    value="%s"
                                    hx-post="/remove_training"
                                    hx-vals='{"training": "%s", "identifier": "%s"}'
                                    hx-swap="outerHTML"
                                    hx-target="closest .player_trainings"
                                    hx-trigger="click">%s
                                </sl-menu-item>
                            ]]):format(z, u.id, i.identifier, u.locales[Config.Language].label)
                        end 
                    end 
                end 
               
                cb(([[
                    <div class="player_trainings relative inline-block">
                        <sl-dropdown>
                            <div class="col-span-1" slot="trigger" style="cursor: pointer;">%s</div>
            
                            <sl-menu>
                                %s
                            </sl-menu>
                        </sl-dropdown>
                    </div>
                ]]):format(
                    (#(i.trainings) .. "/" .. #(Config.Trainings)),
                    trainings
                ))

            end 
        end 
    end 
end)


RegisterNUICallback('employee_edit_callnumber', function(data, cb)
    local identifier = data.identifier
    local id = data.id
    local callNumber = data.callnumber

    local selfData = editPlayerCallnumber(identifier, callNumber)

    cb(([[
        <div class="callnumber relative inline-block">
            <sl-dropdown>
                <sl-badge
                    slot="trigger"
                    variant="success"
                    style="cursor: pointer;">%s
                </sl-badge>

                <sl-card class="w-[13vw]">
                    <div slot="header">
                        <h2 class="text-gray-100 font-bold">%s</h2>
                    </div>
                    <form hx-post="/employee_edit_callnumber" 
                        hx-trigger="submit" 
                        hx-swap="outerHTML"
                        hx-target="closest .callnumber"
                        hx-vals='js:{ id: "%s", identifier: "%s", callnumber: document.querySelector("#callnumber-%s").value}'>
                        <sl-input id="callnumber-%s" label="%s" class="text-neutral-500 mt-4" value="%s" type="number" min="1" max="999" step="1"></sl-input>
                        <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
                    </form>
                </sl-card>
            </sl-dropdown>
        </div>
    ]]):format(
        callNumber,
        locales['pages']['lists']['employee']['callnumber_header'],
        id,
        identifier,
        id,
        id,
        locales['pages']['lists']['employee']['callnumber_description'],
        callNumber,
        locales['pages']['lists']['employee']['callnumber_button']
    ))
end)

RegisterNUICallback('employee_edit_badgenumber', function(data, cb)
    local identifier = data.identifier
    local id = data.id
    local badgeNumber = data.badgenumber

    local selfData = editPlayerBadgenumber(identifier, badgeNumber)

    cb(([[
        <div class="badgenumber relative inline-block">
            <sl-dropdown>
                <sl-badge
                    slot="trigger"
                    variant="primary"
                    style="cursor: pointer;">%s
                </sl-badge>

                <sl-card class="w-[13vw]">
                    <div slot="header">
                        <h2 class="text-gray-100 font-bold">%s</h2>
                    </div>
                    <form hx-post="/employee_edit_badgenumber" 
                        hx-trigger="submit" 
                        hx-swap="outerHTML"
                        hx-target="closest .badgenumber"
                        hx-vals='js:{ id: "%s", identifier: "%s", badgenumber: document.querySelector("#badgenumber-%s").value}'>
                        <sl-input id="badgenumber-%s" label="%s" class="text-neutral-500 mt-4" value="%s" type="number" min="10000" max="99999" step="1"></sl-input>
                        <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
                    </form>
                </sl-card>
            </sl-dropdown>
        </div>
    ]]):format(
        formatBadgeNumber(badgeNumber),
        locales['pages']['lists']['employee']['badgenumber_header'],
        id,
        identifier,
        id,
        id,
        locales['pages']['lists']['employee']['badgenumber_description'],
        badgeNumber,
        locales['pages']['lists']['employee']['badgenumber_button']
    ))
end)

RegisterNUICallback('employee_edit_unit', function(data, cb)
    local identifier = data.identifier
    local id = data.id
    local unit = data.unit

    local units = ""
    for k,v in pairs(locales['units']) do 
        units = units .. ([[<sl-option value="%s">%s</sl-option>]]):format(k, v)
    end 

    local selfData = editPlayerUnit(identifier, unit)

    cb(([[
        <div class="unit relative inline-block">
            <sl-dropdown>
                <div class="col-span-1" slot="trigger" style="cursor: pointer;">%s</div>

                <sl-card class="w-[13vw]">
                    <div slot="header">
                        <h2 class="text-gray-100 font-bold">%s</h2>
                    </div>
                    <form hx-post="/employee_edit_unit" 
                        hx-trigger="submit" 
                        hx-swap="outerHTML"
                        hx-target="closest .unit"
                        hx-vals='js:{ id: "%s", identifier: "%s", unit: document.querySelector("#unit-%s").value}'>

                        <sl-select id="unit-%s" label="%s" class="text-neutral-500 mt-4" value="%s">
                            %s
                        </sl-select>

                        <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
                    </form>
                </sl-card>
            </sl-dropdown>
        </div>
    ]]):format(
        locales['units'][unit],
        locales['pages']['lists']['employee']['unit_header'],
        id,
        identifier,
        id,
        id,
        locales['pages']['lists']['employee']['unit_description'],
        unit,
        units,
        locales['pages']['lists']['employee']['unit_button']
    ))
end)

RegisterNUICallback('employee_edit_infos', function(data, cb)
    local identifier = data.identifier
    local id = data.id
    local infos = data.infos

    local selfData = editPlayerInfos(identifier, infos)

    cb(([[
        <div class="infos relative inline-block">
            <sl-dropdown>
                <div class="col-span-1" slot="trigger" style="cursor: pointer;">%s</div>

                <sl-card class="w-[13vw]">
                    <div slot="header">
                        <h2 class="text-gray-100 font-bold">%s</h2>
                    </div>
                    <form hx-post="/employee_edit_infos" 
                        hx-trigger="submit" 
                        hx-swap="outerHTML"
                        hx-target="closest .infos"
                        hx-vals='js:{ id: "%s", identifier: "%s", infos: document.querySelector("#infos-%s").value}'>
                        <sl-textarea id="infos-%s" label="%s" class="text-neutral-500 mt-4" value="%s"></sl-textarea>
                        <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
                    </form>
                </sl-card>
            </sl-dropdown>
        </div>
    ]]):format(
        infos,
        locales['pages']['lists']['employee']['notes_header'],
        id,
        identifier,
        id,
        id,
        locales['pages']['lists']['employee']['notes_description'],
        infos,
        locales['pages']['lists']['employee']['notes_button']
    ))
end)

RegisterNUICallback('list_load_vehicles', function(data, cb)

    local vehicles = ""
    local vehiclesData = getListVehicleData()

    for k,v in pairs(vehiclesData) do 
        vehicles = vehicles .. list_vehicle(v.category, v.label, v.mingrade, formatPrice(v.price), v.identifier)
    end 

    vehicles = vehicles .. ([[
        <div class="col-span-6">
            <sl-card class="card-basic text-neutral-500 w-full">
                <div 
                    class="text-center" 
                    style="cursor: pointer;"
                    hx-post="/list_add_vehicle"
                    hx-trigger="click"
                    hx-target="closest .card-basic"
                    hx-swap="outerHTML">%s
                </div>
            </sl-card>
        </div>
    ]]):format(locales['pages']['lists']['vehicles']['vehice_add_button'])



    cb(([[
        <div>
            <div class="grid grid-cols-5 gap-4 text-sm text-gray-100 pt-4 w-full max-h-[64vh] overflow-y-auto">

                <div class="font-bold col-span-1">%s</div>
                <div class="font-bold col-span-1">%s</div>
                <div class="font-bold col-span-1">%s</div>
                <div class="font-bold col-span-1">%s</div>
                <div class="font-bold col-span-1">%s</div>

                <div class="col-span-5">
                    <sl-divider class="-mt-4 bg-neutral-600 h-[2px] w-full"></sl-divider>
                </div>

                <div class="col-span-5" id="vehicles_list">
                    %s
                </div>

            </div>
        </div>
    ]]):format(
        locales['pages']['lists']['vehicles']['header_category'],
        locales['pages']['lists']['vehicles']['header_name'],
        locales['pages']['lists']['vehicles']['header_mingrade'],
        locales['pages']['lists']['vehicles']['header_price'],
        locales['pages']['lists']['vehicles']['header_actions'],
        vehicles
    ))
end)

RegisterNUICallback('list_add_vehicle', function(data, cb)
    local identifier = data.identifier

    local categories = ""

    for k,v in pairs(locales['vehicle']) do 
        if k ~= "n/A" then 
            categories = categories .. ([[<sl-option value="%s">%s</sl-option>]]):format(k, k)
        end 
    end 

    local grades = ""
    local gradesData = getGrades()

    for k,v in pairs(gradesData) do 
        grades = grades .. ([[<sl-option value="%s - %s">%s - %s</sl-option>]]):format(v.job_label, v.grade_label, v.job_label, v.grade_label)
    end 

    cb(([[
        <sl-card class="card-header text-neutral-500 w-full">
            <div slot="header" class="text-gray-100 font-bold flex flex-row justify-between">
                %s
            </div>
            <div class="w-full">
                <form 
                    hx-post="/list_submit_vehicle"
                    hx-trigger="submit"
                    hx-swap="innerHTML"
                    hx-target="#vehicles_list"
                    hx-vals='js:{ name: document.querySelector("#name").value, category: document.querySelector("#category").value, grade: document.querySelector("#grade").value, price: document.querySelector("#price").value}'
                    class="flex flex-row gap-4 justify-between w-full"
                    >
                    <sl-select id="category" label="%s" class="w-full text-neutral-500">
                        %s
                    </sl-select>

                    <sl-input  id="name" class="text-neutral-500 w-full" label="%s"></sl-input>

                    <sl-select id="grade" label="%s" class="w-full text-neutral-500">
                        %s
                    </sl-select>

                    <sl-input  id="price" class="text-neutral-500 w-full"" type="number" label="%s"></sl-input>

                    <sl-button type="submit" variant="primary" class="mt-6 w-full">
                        %s
                    </sl-button>
                </form>

            </div>
        </sl-card>
    ]]):format(
        locales['pages']['lists']['vehicles']['vehice_add_button'],
        locales['pages']['lists']['vehicles']['vehicle_select_category'],
        categories,
        locales['pages']['lists']['vehicles']['vehicle_select_name'],
        locales['pages']['lists']['vehicles']['vehicle_select_grade'],
        grades,
        locales['pages']['lists']['vehicles']['vehicle_select_price'],
        locales['pages']['lists']['vehicles']['vehicle_add_submit']
    ))
end)

RegisterNUICallback('list_submit_vehicle', function(data, cb)
    local name = data.name
    local price = data.price
    local grade = valueToLabel(data.grade)
    local category = valueToLabel(data.category)

    local vehicles = ""
    local vehiclesData = addVehicle(category, name, grade, price)

    for k,v in pairs(vehiclesData) do 
        vehicles = vehicles .. list_vehicle(v.category, v.label, v.mingrade, formatPrice(v.price), v.identifier)
    end 

    vehicles = vehicles .. ([[
        <div class="col-span-6">
            <sl-card class="card-basic text-neutral-500 w-full">
                <div 
                    class="text-center" 
                    style="cursor: pointer;"
                    hx-post="/list_add_vehicle"
                    hx-trigger="click"
                    hx-target="closest .card-basic"
                    hx-swap="outerHTML">%s
                </div>
            </sl-card>
        </div>
    ]]):format(locales['pages']['lists']['vehicles']['vehice_add_button'])

    cb(vehicles)
end)

RegisterNUICallback('delete_vehicle', function(data, cb)
    local identifier = data.vehicle

    local vehicles = ""
    local vehiclesData = removeVehicle(identifier)

    for k,v in pairs(vehiclesData) do 
        vehicles = vehicles .. list_vehicle(v.category, v.label, v.mingrade, formatPrice(v.price), v.identifier)
    end 

    vehicles = vehicles .. ([[
        <div class="col-span-6">
            <sl-card class="card-basic text-neutral-500 w-full">
                <div 
                    class="text-center" 
                    style="cursor: pointer;"
                    hx-post="/list_add_vehicle"
                    hx-trigger="click"
                    hx-target="closest .card-basic"
                    hx-swap="outerHTML">%s
                </div>
            </sl-card>
        </div>
    ]]):format(locales['pages']['lists']['vehicles']['vehice_add_button'])

    cb(vehicles)
end)

RegisterNUICallback('list_load_outfits', function(data, cb)

    local outfitsData = getListOutfitData()
    local outfits = ""

    for k,v in pairs(outfitsData) do
        outfits = outfits .. list_outfit(v.label, v.url, v.mingrade, v.unit, locales['pages']['lists']['outfits']['outfit_numbers'], v.identifier, json.decode(v.outfit))
    end

    outfits = outfits .. ([[
        <sl-card class="card-basic">
            <div 
                class="text-neutral-500 flex items-center justify-center text-center" 
                style="cursor: pointer;"
                hx-post="/list_add_outfit"
                hx-trigger="click"
                hx-target="closest .card-basic"
                hx-swap="outerHTML"
            >
                %s
            </div>
        </sl-card>
    ]]):format(locales['pages']['lists']['outfits']['add_outfit'])

    cb(([[
        <div id="outfit_list" class="p-4 grid grid-cols-6 gap-4 overflow-y-auto max-h-[64vh]">
            %s
        </div>
    ]]):format(
        outfits   
    ))
end)

RegisterNUICallback('list_add_outfit', function(data, cb)

    local grades = ""
    local gradesData = getGrades()

    for k,v in pairs(gradesData) do 
        grades = grades .. ([[<sl-option value="%s - %s">%s - %s</sl-option>]]):format(v.job_label, v.grade_label, v.job_label, v.grade_label)
    end 

    local units = ""
    for k,v in pairs(locales['units']) do 
        units = units .. ([[<sl-option value="%s">%s</sl-option>]]):format(v, v)
    end 

    local outfit_parts = ""
    for k,v in pairs(locales['pages']['lists']['outfits']['parts']) do 
        outfit_parts = outfit_parts .. ([[
            <div class="flex flex-row gap-2 justify-between w-full pt-4">
                <sl-input id="%s1" class="text-neutral-500 pb-4 w-[4.5vw]" label="%s 1"></sl-input>
                <sl-input id="%s2" class="text-neutral-500 pb-4 w-[4.5vw]" label="%s 2"></sl-input>
            </div>
        ]]):format(k,v, k, v)
    end 


    local vals = ""
    for k,v in pairs(locales['pages']['lists']['outfits']['parts']) do 
        vals = vals .. ([[
            %s1: document.querySelector("#%s1").value, 
            %s2: document.querySelector("#%s2").value, 
        ]]):format(k,k, k, k)
    end 




    cb(([[
        <sl-card class="w-full">
            <div slot="header">
                <h2 class="text-gray-100 font-bold">%s</h2>
            </div>

            <form hx-post="/list_submit_outfit" 
                hx-trigger="submit" 
                hx-swap="innerHTML"
                hx-target="#outfit_list"
                hx-vals='js:{ 
                    %s
                    name: document.querySelector("#name").value, 
                    url: document.querySelector("#url").value, 
                    grade: document.querySelector("#grade").value, 
                    unit: document.querySelector("#unit").value
                }'>
                
                <sl-input id="name" class="text-neutral-500 pb-4" label="%s"></sl-input>

                <sl-input id="url" class="text-neutral-500 pb-4" label="%s"></sl-input>
                
                <sl-select id="grade" label="%s" class="w-full text-neutral-500 pb-4">
                    %s
                </sl-select>

                <sl-select id="unit" label="%s" class="w-full text-neutral-500 pb-4>
                    %s
                </sl-select>

                
                %s

                <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
            </form>

        </sl-card>
    ]]):format(
        locales['pages']['lists']['outfits']['add_outfit'],
        vals,
        locales['pages']['lists']['outfits']['create_name'],
        locales['pages']['lists']['outfits']['create_url'],
        locales['pages']['lists']['outfits']['create_grade'],
        grades,
        locales['pages']['lists']['outfits']['create_unit'],
        units,
        outfit_parts,
        locales['pages']['lists']['outfits']['create_button']
    ))
end)

RegisterNUICallback('list_submit_outfit', function(data, cb)

    local name = data.name
    local url = data.url
    local grade = valueToLabel(data.grade)
    local unit = valueToLabel(data.unit)
    local outfit = {}

    if grade == "" or grade == nil then 
        local gradesData = getGrades()
        grade = (gradesData[1].job_label .. ' - ' .. gradesData[1].grade_label)
    end 

    if unit == "" or unit == nil then 
        unit = locales['units']['patrol']
    end 

    for k,v in pairs(locales['pages']['lists']['outfits']['parts']) do 
        table.insert(outfit, {
            part_name = v,
            part_1 = (data[k.."1"] == "" and "n/A") or data[k.."1"],
            part_2 = (data[k.."2"] == "" and "n/A") or data[k.."2"],
        })
    end 

    local outfitsData = addOutfit(name, grade, unit, url, outfit)
    local outfits = ""

    for k,v in pairs(outfitsData) do
        outfits = outfits .. list_outfit(v.label, v.url, v.mingrade, v.unit, locales['pages']['lists']['outfits']['outfit_numbers'], v.identifier, json.decode(v.outfit))
    end

    outfits = outfits .. ([[
        <sl-card class="card-basic">
            <div 
                class="text-neutral-500 flex items-center justify-center text-center" 
                style="cursor: pointer;"
                hx-post="/list_add_outfit"
                hx-trigger="click"
                hx-target="closest .card-basic"
                hx-swap="outerHTML"
            >
                %s
            </div>
        </sl-card>
    ]]):format(locales['pages']['lists']['outfits']['add_outfit'])

    cb(outfits)
end)

RegisterNUICallback('delete_outfit', function(data, cb)
    local identifier = data.identifier
    local outfitsData = deleteOutfit(identifier)
    cb([[]])
end)

RegisterNUICallback('list_load_codes', function(data, cb)

    local status = ""
    local code = ""
    local frequency = ""

    for k,v in pairs(Config.Lists.status) do 
        status = status .. ([[
            <div class="crime col-span-2 grid grid-cols-2 gap-4 pb-4">
                <div class="col-span-1">%s</div>
                <div class="col-span-1">%s</div>
            </div>
        ]]):format(v.status, v.description)
    end 

    for k,v in pairs(Config.Lists.code) do 
        code = code .. ([[
            <div class="crime col-span-2 grid grid-cols-2 gap-4 pb-4">
                <div class="col-span-1">%s</div>
                <div class="col-span-1">%s</div>
            </div>
        ]]):format(v.status, v.description)
    end 

    for k,v in pairs(Config.Lists.frequency) do 
        frequency = frequency .. ([[
            <div class="crime col-span-2 grid grid-cols-2 gap-4 pb-4">
                <div class="col-span-1">%s</div>
                <div class="col-span-1">%s</div>
            </div>
        ]]):format(v.status, v.description)
    end 

    cb(([[
        <div class="p-4 w-full flex flex-row gap-4 overflow-y-auto max-h-[64vh]">


            <div class="grid grid-cols-2 gap-4 text-sm text-gray-100 w-full">

                <div class="font-bold col-span-1">%s</div>
                <div class="font-bold col-span-1">%s</div>

                <div class="col-span-2">
                    <sl-divider class="-mt-4 bg-neutral-600 h-[2px] w-full"></sl-divider>
                </div>
                %s
            </div>


            <div class="flex flex-col w-full gap-4">
                <div class="grid grid-cols-2 gap-4 text-sm text-gray-100 w-full">

                    <div class="font-bold col-span-1">%s</div>
                    <div class="font-bold col-span-1">%s</div>

                    <div class="col-span-2">
                        <sl-divider class="-mt-4 bg-neutral-600 h-[2px] w-full"></sl-divider>
                    </div>
                    %s
                </div>

                <div class="grid grid-cols-2 gap-4 text-sm text-gray-100 w-full">

                    <div class="font-bold col-span-1">%s</div>
                    <div class="font-bold col-span-1">%s</div>

                    <div class="col-span-2">
                        <sl-divider class="-mt-4 bg-neutral-600 h-[2px] w-full"></sl-divider>
                    </div>
                    %s
                </div>
            </div>
        </div>
    ]]):format(
        locales['pages']['lists']['codes']['status'],
        locales['pages']['lists']['codes']['description'],
        status,

        locales['pages']['lists']['codes']['code'],
        locales['pages']['lists']['codes']['description'],
        code,

        locales['pages']['lists']['codes']['frequency'],
        locales['pages']['lists']['codes']['description'],
        frequency
    ))
end)

RegisterNUICallback('list_load_training', function(data, cb)

    local trainings = ""
    local trainingData = getListTrainingData()

    for k,v in pairs(trainingData) do 
        trainings = trainings .. list_training(
            v.label,
            v.description,
            v.supervisor,
            formatDate(v.time),
            v.location,
            v.playerlimit,
            json.decode(v.list),
            getSelfData().name,
            locales['pages']['lists']['training']['login_status'],
            v.identifier
        )
    end 


    trainings = trainings .. ([[
        <div class="col-span-8 w-full">
            <sl-card class="card-basic w-full">
                <div 
                    class="text-neutral-500 flex items-center justify-center text-center" 
                    style="cursor: pointer;"
                    hx-post="/list_add_training"
                    hx-trigger="click"
                    hx-target="closest .card-basic"
                    hx-swap="outerHTML"
                >
                    %s
                </div>
            </sl-card>
        </div>
    ]]):format(locales['pages']['lists']['training']['add_training'])

    cb(([[
        <div class="grid grid-cols-8 gap-4 text-sm text-gray-100 pt-4 w-full overflow-y-auto max-h-[64vh]">

            <div class="font-bold col-span-1">%s</div>
            <div class="font-bold col-span-1">%s</div>
            <div class="font-bold col-span-1">%s</div>
            <div class="font-bold col-span-1">%s</div>
            <div class="font-bold col-span-1">%s</div>
            <div class="font-bold col-span-1">%s</div>
            <div class="font-bold col-span-1">%s</div>
            <div class="font-bold col-span-1">%s</div>

            <div class="col-span-8">
                <sl-divider class="-mt-4 bg-neutral-600 h-[2px] w-full"></sl-divider>
            </div>
            <div id="training_list" class="col-span-8">
                %s
            </div>
        </div>
    ]]):format(
        locales['pages']['lists']['training']['training'],
        locales['pages']['lists']['training']['description'],
        locales['pages']['lists']['training']['supervisor'],
        locales['pages']['lists']['training']['time'],
        locales['pages']['lists']['training']['location'],
        locales['pages']['lists']['training']['self_status'],
        locales['pages']['lists']['training']['participants'],
        locales['pages']['lists']['training']['actions'],
        trainings
    ))
end)

RegisterNUICallback('list_add_training', function(data, cb)

    local trainings = ""
    for k,v in pairs(Config.Trainings) do 
        trainings = trainings .. ([[<sl-option value="%s">%s</sl-option>]]):format(v.id, v.locales[Config.Language].label)
    end 

    cb(([[
        <sl-card class="w-full">
            <div slot="header">
                <h2 class="text-gray-100 font-bold">%s</h2>
            </div>

            <form hx-post="/list_submit_training" 
                hx-trigger="submit" 
                hx-swap="innerHTML"
                hx-target="#training_list"
                hx-vals='js:{ 
                    training: document.querySelector("#training").value, 
                    time: document.querySelector("#time").value, 
                    location: document.querySelector("#location").value, 
                    limit: document.querySelector("#limit").value
                }'>

                <sl-select id="training" label="%s" class="w-full text-neutral-500 pb-4">
                    %s
                </sl-select>

                <sl-input id="time" type="date" class="text-neutral-500 pb-4" label="%s"></sl-input>

                <sl-input id="location" class="text-neutral-500 pb-4" label="%s"></sl-input>

                <sl-input id="limit" type="number" min="1" max="25" class="text-neutral-500 pb-4" label="%s"></sl-input>


                <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
            </form>

        </sl-card>
    ]]):format(
        locales['pages']['lists']['training']['add_training'],
        locales['pages']['lists']['training']['select_training'],
        trainings,
        locales['pages']['lists']['training']['select_time'],
        locales['pages']['lists']['training']['select_location'],
        locales['pages']['lists']['training']['select_limit'],
        locales['pages']['lists']['training']['training_submit']
    ))
end)

RegisterNUICallback('list_submit_training', function(data, cb)
    local training = ""
    local description = ""
    local time = data.time
    local location = data.location
    local limit = tonumber(data.limit)

    for k,v in pairs(Config.Trainings) do 
        if v.id == data.training then 
            training = v.locales[Config.Language].label
            description = v.locales[Config.Language].description
        end     
    end
    
    local trainings = ""
    local trainingData = addTraining(training, description, time, location, limit)

    for k,v in pairs(trainingData) do 
        trainings = trainings .. list_training(
            v.label,
            v.description,
            v.supervisor,
            formatDate(v.time),
            v.location,
            v.playerlimit,
            json.decode(v.list),
            getSelfData().name,
            locales['pages']['lists']['training']['login_status'],
            v.identifier
        )
    end 

    trainings = trainings .. ([[
        <div class="col-span-8 w-full">
            <sl-card class="card-basic w-full">
                <div 
                    class="text-neutral-500 flex items-center justify-center text-center" 
                    style="cursor: pointer;"
                    hx-post="/list_add_training"
                    hx-trigger="click"
                    hx-target="closest .card-basic"
                    hx-swap="outerHTML"
                >
                    %s
                </div>
            </sl-card>
        </div>
    ]]):format(locales['pages']['lists']['training']['add_training'])

    cb(trainings)
end)

RegisterNUICallback('edit_training_login', function(data, cb)
    local identifier = data.identifier
    local trainingData = editTrainingLogin(identifier)
    local selfData = getSelfData()

    local asigned = false
    local limit = 25
    local list = {}

    for k,v in pairs(trainingData) do 
        if tonumber(v.identifier) == tonumber(identifier) then 
            list = json.decode(v.list)
            limit = v.playerlimit
        end
    end 

    for k,v in pairs(list) do 
        if v == selfData.name then 
            asigned = true
        end 
    end 

    cb(([[
        <div class="training_stats col-span-2 flex flex-row">
            <sl-badge
                variant="%s"
                class="cursor-pointer h-8 w-full"
                hx-post="/edit_training_login"
                hx-vals='{"identifier": "%s"}'
                hx-trigger="click"
                hx-target="closest .training_stats"
                hx-swap="outerHTML">%s
            </sl-badge>
            <div class="pl-4 w-full">%s</div>
        </div>
    ]]):format(
        locales['pages']['lists']['training']['login_status'][asigned][2], 
        identifier,
        locales['pages']['lists']['training']['login_status'][asigned][1],
        ((#list) .. '/' .. limit)
    ))
end)

RegisterNUICallback('delete_training', function(data, cb)
    local identifier = data.identifier
    local trainingData = deleteTraining(identifier)
    cb([[]])
end)

RegisterNUICallback('submit_training', function(data, cb)
    local identifier = data.identifier
    local trainingData = getListTrainingData()

    local vals = ""
    local checkboxes = ""

    for k,v in pairs(trainingData) do 
        if tonumber(v.identifier) == tonumber(identifier) then 
            for o,i in pairs(json.decode(v.list)) do 
                vals = vals .. ([["%s": document.querySelector("#%s").checked, ]]):format(labelToValue(i), labelToValue(i))
                checkboxes = checkboxes .. ([[<sl-checkbox id="%s">%s</sl-checkbox>]]):format(labelToValue(i), i)
            end 
        end 
    end 

    cb(([[
        <sl-card class="end_training w-full pb-4">
            <div slot="header">
                <h2 class="text-gray-100 font-bold">%s</h2>
            </div>

            <form hx-post="/list_end_training" 
                hx-trigger="submit" 
                hx-swap="outerHTML"
                hx-target="closest .end_training"
                hx-vals='js:{%s identifier: "%s"}'

                <h3 class="text-neutral-500"">%s</h3>

                <div class="grid grid-cols-3 gap-4 pt-4">
                    %s
                </div>

                <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
            </form>

        </sl-card>
    ]]):format(
        locales['pages']['lists']['training']['submit_training_header'],
        vals,
        identifier,
        locales['pages']['lists']['training']['submit_training_description'],
        checkboxes,
        locales['pages']['lists']['training']['submit_training_button']
    ))
end)

RegisterNUICallback('list_end_training', function(data, cb)
    local identifier = data.identifier
    local officer = {}

    for k,v in pairs(data) do 
        if k ~= "" and k ~= "identifier" then 
            if v == true then 
                table.insert(officer, valueToLabel(k))
            end 
        end 
    end

    local trainingData = endTraining(identifier, officer)

    cb([[]])
end)

RegisterNUICallback('list_load_law', function(data, cb)

    local law = ""
    local lawData = getLaw()

    for k,v in pairs(lawData) do
        
        local crimes = ""
        
        for o,i in pairs(v.text) do 
            crimes = crimes .. list_law(
                i.label, 
                i.description, 
                i.jail, 
                i.fine, 
                i.society,
                v.paragraph
            )
        end 

        law = law .. ([[
            <div class="paragraph col-span-6 flex flex-col">
                <div class="flex flex-row justify-between">
                    <div class="font-bold col-span-1">§%s - %s</div>

                    <div class="col-span-1 flex gap-2">
                        <sl-icon-button
                            name="plus"
                            hx-post="/list_add_crime"
                            hx-vals='{"paragraph": "%s"}'
                            hx-trigger="click"
                            hx-swap="innerHTML"
                            hx-target="#crimes_%s"
                        ></sl-icon-button>

                        <sl-icon-button
                            name="trash"
                            hx-post="/delete_law"
                            hx-vals='{"paragraph": "%s"}'
                            hx-trigger="click"
                            hx-swap="outerHTML"
                            hx-target="closest .paragraph"
                        ></sl-icon-button>
                    </div>

                </div>
                <sl-divider class="-mt-[2px] bg-neutral-600 h-[1px] w-full"></sl-divider>
                <div id="crimes_%s" class="flex flex-col max-h-[64vh] overflow-y-auto">
                    %s
                </div>
            </div>
        ]]):format(
            k, v.paragraph, v.paragraph, v.paragraph, v.paragraph, v.paragraph, crimes)
    end 

    law = law .. ([[
        <div class="col-span-6 w-full">
            <sl-card class="card-basic w-full">
                <div 
                    class="text-neutral-500 flex items-center justify-center text-center" 
                    style="cursor: pointer;"
                    hx-post="/list_add_law"
                    hx-trigger="click"
                    hx-target="closest .card-basic"
                    hx-swap="outerHTML"
                >
                    %s
                </div>
            </sl-card>
        </div>
    ]]):format(locales['pages']['lists']['law']['add_paragraph'])

    cb(([[
        <div class="grid grid-cols-6 gap-4 text-sm text-gray-100 pt-4 w-full overflow-y-auto max-h-[64vh]">

            <div class="font-bold col-span-1">%s</div>
            <div class="font-bold col-span-1">%s</div>
            <div class="font-bold col-span-1">%s</div>
            <div class="font-bold col-span-1">%s</div>
            <div class="font-bold col-span-1">%s</div>
            <div class="font-bold col-span-1">%s</div>

            <div class="col-span-6">
                <sl-divider class="-mt-4 bg-neutral-600 h-[2px] w-full"></sl-divider>
            </div>
            <div id="law_list" class="col-span-6">
                %s
            </div>

        </div>
    ]]):format(
        locales['pages']['lists']['law']['label'],
        locales['pages']['lists']['law']['description'],
        locales['pages']['lists']['law']['jail'],
        locales['pages']['lists']['law']['fine'],
        locales['pages']['lists']['law']['society'],
        locales['pages']['lists']['law']['actions'],
        law
    ))
end)

RegisterNUICallback('delete_law', function(data, cb)
    local paragraph = data.paragraph
    local lawData = deleteLaw(paragraph)
    cb([[]])
end)

RegisterNUICallback('list_add_law', function(data, cb)
    local trainings = ""
    for k,v in pairs(Config.Trainings) do 
        trainings = trainings .. ([[<sl-option value="%s">%s</sl-option>]]):format(v.id, v.locales[Config.Language].label)
    end 

    cb(([[
        <sl-card class="w-full">
            <div slot="header">
                <h2 class="text-gray-100 font-bold">%s</h2>
            </div>

            <form hx-post="/list_submit_law" 
                hx-trigger="submit" 
                hx-swap="innerHTML"
                hx-target="#law_list"
                hx-vals='js:{ paragraph: document.querySelector("#paragraph").value }'>
                <sl-input id="paragraph" class="text-neutral-500 pb-4" label="%s"></sl-input>
                <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
            </form>

        </sl-card>
    ]]):format(
        locales['pages']['lists']['law']['add_paragraph'],
        locales['pages']['lists']['law']['submit_paragraph'],
        locales['pages']['lists']['law']['paragraph_submit_button']
    ))
end)

RegisterNUICallback('list_submit_law', function(data, cb)
    local paragraph = data.paragraph
    local lawData = addLaw(paragraph)
    local law = ""

    for k,v in pairs(lawData) do
        
        local crimes = ""
        
        for o,i in pairs(v.text) do 
            crimes = crimes .. list_law(
                i.label, 
                i.description, 
                i.jail, 
                i.fine, 
                i.society,
                v.paragraph
            )
        end 

        law = law .. ([[
            <div class="paragraph col-span-6 flex flex-col">
                <div class="flex flex-row justify-between">
                    <div class="font-bold col-span-1">§%s - %s</div>

                    <div class="col-span-1 flex gap-2">
                        <sl-icon-button
                            name="plus"
                            hx-post="/list_add_crime"
                            hx-vals='{"paragraph": "%s"}'
                            hx-trigger="click"
                            hx-swap="innerHTML"
                            hx-target="#crimes_%s"
                        ></sl-icon-button>

                        <sl-icon-button
                            name="trash"
                            hx-post="/delete_law"
                            hx-vals='{"paragraph": "%s"}'
                            hx-trigger="click"
                            hx-swap="outerHTML"
                            hx-target="closest .paragraph"
                        ></sl-icon-button>
                    </div>

                </div>
                <sl-divider class="-mt-[2px] bg-neutral-600 h-[1px] w-full"></sl-divider>
                <div id="crimes_%s" class="flex flex-col">
                    %s
                </div>
            </div>
        ]]):format(
            k, v.paragraph, v.paragraph, v.paragraph, v.paragraph, v.paragraph, crimes)
    end 

    law = law .. ([[
        <div class="col-span-6 w-full">
            <sl-card class="card-basic w-full">
                <div 
                    class="text-neutral-500 flex items-center justify-center text-center" 
                    style="cursor: pointer;"
                    hx-post="/list_add_law"
                    hx-trigger="click"
                    hx-target="closest .card-basic"
                    hx-swap="outerHTML"
                >
                    %s
                </div>
            </sl-card>
        </div>
    ]]):format(locales['pages']['lists']['law']['add_paragraph'])

    cb(law)
end)

RegisterNUICallback('list_add_crime', function(data, cb)
    local paragraph = data.paragraph

    local lawData = getLaw()

    for k,v in pairs(lawData) do
        if v.paragraph == paragraph then 
        
            local crimes = ""
            
            for o,i in pairs(v.text) do 
                crimes = crimes .. list_law(
                    i.label, 
                    i.description, 
                    i.jail, 
                    i.fine, 
                    i.society,
                    v.paragraph
                )
            end 

            cb(([[
                %s

                <sl-card class="w-full pb-4">
                    <div slot="header">
                        <h2 class="text-gray-100 font-bold">%s</h2>
                    </div>

                    <form hx-post="/list_submit_crime" 
                        hx-trigger="submit" 
                        hx-swap="innerHTML"
                        hx-target="#crimes_%s"
                        hx-vals='js:{ 
                            paragraph: "%s",
                            crime: document.querySelector("#crime").value,
                            description: document.querySelector("#description").value,
                            jail: document.querySelector("#jail").value,
                            fine: document.querySelector("#fine").value,
                            society: document.querySelector("#society").value
                        }'>

                        <sl-input id="crime" class="text-neutral-500 pb-4" label="%s"></sl-input>
                        <sl-textarea id="description" class="text-neutral-500 mt-4" label="%s"></sl-textarea>
                        <sl-input id="jail" class="text-neutral-500 pb-4" label="%s" value="0"></sl-input>
                        <sl-input id="fine" class="text-neutral-500 pb-4" label="%s" value="0"></sl-input>
                        <sl-input id="society" class="text-neutral-500 pb-4" label="%s" value="0"></sl-input>


                        <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
                    </form>

                </sl-card>
            ]]):format(
                crimes,
                locales['pages']['lists']['law']['add_crime'],
                paragraph,
                paragraph,
                locales['pages']['lists']['law']['submit_crime'],
                locales['pages']['lists']['law']['submit_description'],
                locales['pages']['lists']['law']['submit_jail'],
                locales['pages']['lists']['law']['submit_fine'],
                locales['pages']['lists']['law']['submit_society'],
                locales['pages']['lists']['law']['crime_submit_button']
            ))

        end 
    end 
end)


RegisterNUICallback('list_submit_crime', function(data, cb)
    local paragraph = data.paragraph
    local crime = data.crime
    local description = data.description 
    local jail = data.jail
    local fine = data.fine
    local society = data.society

    local lawData = addCrimeToParagraph(paragraph, crime, description, jail, fine, society)

    for k,v in pairs(lawData) do
        if v.paragraph == paragraph then 
        
            local crimes = ""
            
            for o,i in pairs(v.text) do 
                crimes = crimes .. list_law(
                    i.label, 
                    i.description, 
                    i.jail, 
                    i.fine, 
                    i.society,
                    v.paragraph
                )
            end 

            cb(crimes)
        end
    end 
end)

RegisterNUICallback('delete_paragraph_crime', function(data, cb)
    local paragraph = data.paragraph
    local crime = data.crime

    local lawData = deleteCrimeFromParagraph(paragraph, crime)


    cb([[]])
end)
