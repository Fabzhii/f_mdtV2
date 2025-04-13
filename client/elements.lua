
function dashboard_div_2_element(name, tel_locales, tel, status_color, status_locales, status, callname_color, callname_locales, callname, vehicle_color, vehicle_locales, vehicle, position_color, position_locales, position)
    return ([[
        <sl-card class="card-header w-full pt-4">
            <div slot="header" class="flex flex-row">
                <img src="./img/user.png" alt="user" class="w-12">
                <div class="pl-4 flex flex-col">
                    <h3 class="text-gray-100 font-bold">%s</h3>  
                    <h2 class="text-neutral-500">%s %s</h2>
                </div>
            </div>

            <sl-badge variant="%s">
                <sl-icon name="sliders" style="margin-right: 4px;"></sl-icon>
                %s %s
            </sl-badge>

            <sl-badge variant="%s">
                <sl-icon name="person" style="margin-right: 4px;"></sl-icon>
                %s %s
            </sl-badge>

            <sl-badge variant="%s">
                <sl-icon name="truck" style="margin-right: 4px;"></sl-icon>
                %s %s
            </sl-badge>

            <sl-badge variant="%s">
                <sl-icon name="signpost-split" style="margin-right: 4px;"></sl-icon>
                %s %s
            </sl-badge> 
        </sl-card>
    ]]):format(
        name, 
        tel_locales, 
        tel,

        status_color,
        status_locales,
        status,

        callname_color,
        callname_locales,
        callname,

        vehicle_color,
        vehicle_locales,
        vehicle,

        position_color,
        position_locales,
        position
    )
end 

function dashboard_div_3_element(name, reason, infos)
    return ([[
        <sl-card class="card-header w-full pt-4">
            <div slot="header">
                <h3 class="text-gray-100 font-bold">%s</h3>  
            </div>
            <h2 class="text-neutral-500">%s</h2> 
            <sl-details summary="Weiterlesen" class="pt-4 text-neutral-500">
                <h3 class="text-gray-100">%s</h3>  
            </sl-details>

        </sl-card>
    ]]):format(
        name,
        reason,
        infos
    )
end 

function dashboard_div_4_element(code_color, code, reason, position_vector, time_locales, time, position_locales, position, infos_locales, infos)
    return ([[
        <sl-card class="card-header w-full pt-4">
            <div slot="header" class="flex flex-row justify-between">
                <div class="flex flex-row items-center">
                    <sl-badge variant="%s">%s</sl-badge>
                    <h3 class="pl-2 text-gray-100 font-bold">%s</h3>  
                </div>
                <sl-icon-button
                    name="geo-alt"
                    label="Favorit"
                    hx-post="/create_marker"
                    hx-vals='{"position": %s}'
                    hx-trigger="click"
                </sl-icon-button>
            </div>
            <sl-badge variant="success">
                <sl-icon name="clock" style="margin-right: 4px;"></sl-icon>
                %s %s
            </sl-badge>
            <sl-badge variant="danger">
                <sl-icon name="signpost-split" style="margin-right: 4px;"></sl-icon>
                %s %s
            </sl-badge>
            <sl-badge variant="primary">
                <sl-icon name="exclamation-octagon" style="margin-right: 4px;"></sl-icon>
                %s %s
            </sl-badge>
        </sl-card>
    ]]):format(
        code_color,
        code,
        reason,
        position_vector,

        time_locales,
        time,

        position_locales,
        position,

        infos_locales,
        infos
    )
end 

function dashboard_div_5_element(title, information, identifier, delete_btn)
    return ([[
        <sl-details summary="%s" class="custom-icons text-neutral-500 pt-4">
            <sl-icon name="plus-square" slot="expand-icon"></sl-icon>
            <sl-icon name="dash-square" slot="collapse-icon"></sl-icon>
            <div class="flex flex-col gap-2">
                <h3 class="pl-2 text-gray-100">%s</h3> 
                <sl-button variant="danger" hx-post="/delete_information" hx-swap="innerHTML" hx-target="#information" hx-vals='{"identifier": %s}'>%s</sl-button>
            </div>
        </sl-details>
    ]]):format(
        title,
        information,
        identifier,
        delete_btn
    )
end 

function control_center_div_1_element(title, count)
    return ([[
        <div class="flex flex-row gap-2">
            <h2 class="text-neutral-500">%s</h2>
            <h3 class="text-gray-100 font-bold">%s</h3>
        </div>
    ]]):format(
        title,
        count
    )
end 

function editInfoBtn(info)
    local callname_btn = ""

    if info == "o1" or info == "o2" or info == "o3" then 
        for k,v in pairs(getCopsData()) do 
            callname_btn = callname_btn .. ([[
                <sl-badge 
                    variant="%s"
                    style="cursor: pointer;"
                    hx-post="/set_personal_information" 
                    hx-swap="outerHTML" 
                    hx-target="closest .info_btn" 
                    hx-vals='js:{ key: "%s", value: "%s"}'
                
                >%s</sl-badge>
            ]]):format(
                'success', 
                info,
                v.name,
                v.name
            )
        end 
        callname_btn = callname_btn .. ([[
            <sl-badge 
                variant="warning"
                style="cursor: pointer;"
                hx-post="/set_personal_information" 
                hx-swap="outerHTML" 
                hx-target="closest .info_btn" 
                hx-vals='js:{ key: "%s", value: "n/A"}'
            
            >n/A</sl-badge>
        ]]):format(
            info
        )
    else 
        for k,v in pairs(locales[info]) do 
            callname_btn = callname_btn .. ([[
                <sl-badge 
                    variant="%s"
                    style="cursor: pointer;"
                    hx-post="/set_personal_information" 
                    hx-swap="outerHTML" 
                    hx-target="closest .info_btn" 
                    hx-vals='js:{ key: "%s", value: "%s"}'
                
                >%s</sl-badge>
            ]]):format(
                v, 
                info,
                k,
                k
            )
        end 
    end 

    return callname_btn
end


function control_center_div_2_element(title, copsData)
    local officer = ""

    for k,v in pairs(copsData) do 
        if v.callname == title then 
            officer = officer .. ([[
                <sl-card class="card-basic w-full pb-4">
                    <div class="flex flex-row gap-2">
                        <sl-badge style="height: 25px;" variant="success">%s</sl-badge>
                        <sl-badge style="height: 25px;" variant="success">%s</sl-badge>
                        <sl-badge style="height: 25px;" variant="%s">%s</sl-badge>
                        <sl-badge style="height: 25px;" variant="%s">%s</sl-badge>
                        <sl-badge style="height: 25px;" variant="%s">%s</sl-badge>
                        <sl-badge style="height: 25px;" variant="%s">%s</sl-badge>
                        <sl-badge style="height: 25px;" variant="%s">%s</sl-badge>
                        <sl-badge style="height: 25px;" variant="%s">%s</sl-badge>
                        <sl-badge style="height: 25px;" variant="%s">%s</sl-badge>
                        <sl-badge style="height: 25px;" variant="%s">%s</sl-badge>

                        <sl-icon-button
                            name="telephone"
                            hx-post="/create_call"
                            hx-vals='{"number": %s}'
                            hx-trigger="click"
                        </sl-icon-button>

                    </div>
                </sl-card>
            ]]):format(
                v.job_grade_label,
                v.name,
                locales['callname'][v.callname], v.callname, 
                locales['status'][v.status], v.status, 
                locales['position'][v.position], v.position, 
                locales['vehicle'][v.vehicle], v.vehicle, 
                locales['frequency'][(v.frequency.."")], v.frequency,
                (v.o1 == "n/A" and "warning" or "success"), v.o1, 
                (v.o2 == "n/A" and "warning" or "success"), v.o2, 
                (v.o3 == "n/A" and "warning" or "success"), v.o3,
                v.phone_number
            )
        end 
    end 


    return ([[
        <div class="pt-4">
            <h2 class="text-gray-100">%s</h2>
            <sl-divider class="w-full h-[1px] bg-neutral-500 mb-8"></sl-divider>
            %s
        </div>
    ]]):format(
        title,
        officer
    )
end 

function control_center_buttons(text, identifier)
    return ([[
        <sl-card class="card-basic w-full text-gray-100 text-center" style="cursor: pointer; --padding: 0.4rem; height: auto;">
            <div class="flex flex-row items-center justify-between w-full">
                <div class="w-full text-center pointer-events-none">
                    %s
                </div>
                
                <sl-icon-button
                    name="trash"
                    hx-post="/delete_button"
                    hx-vals='{"identifier": %s}'
                    hx-trigger="click"
                    hx-target="closest .card-basic"
                    hx-swap="outerHTML" 
                </sl-icon-button>


            </div>
        </sl-card>  
    ]]):format(
        text,
        identifier
    )
end

function control_center_own_chat(name, text)
    return ([[
            <div class="flex flex-row-reverse items-start">
            <sl-tooltip content="%s" hoist>
                <sl-avatar image="https://api.dicebear.com/7.x/initials/svg?seed=D+U" class="ml-2" style="--size: 32px;"></sl-avatar>
            </sl-tooltip>
            <sl-button disabled class="w-72 text-left">
                %s
            </sl-button>
            </div>
    ]]):format(
        name,
        text
    )
end

function control_center_other_chat(name, icon, text)
    return ([[
        <div class="flex items-start">
        <sl-tooltip content="%s" hoist>
            <sl-avatar image="https://api.dicebear.com/7.x/initials/svg?seed=%s" class="mr-2" style="--size: 32px;"></sl-avatar>
        </sl-tooltip>
        <sl-button disabled class="w-72">
            %s
        </sl-button>
        </div>
    ]]):format(
        name,
        icon,
        text
    )
end

function citizen_search_person(identifier, firstname, lastname, wanted, wanted_label, dateofbirth_label, dateofbirth, sex_label, sex)
    return ([[
        <sl-card 
            class="card-header w-full pt-4 text-neutral-500 hover:cursor-pointer"
            onclick="htmx.ajax('POST', '/select_person', { target: '#selected_user', swap: 'outerHTML', values: { identifier: '%s' } })"
        >
            <div slot="header" class="text-gray-100">
                %s %s
                %s
            </div>

            <div class="flex flex-row items-center gap-72">
                <img src="./img/user.png" alt="user" class="h-8">

                <div class="flex flex-col">
                    <h2 class="text-neutral-500 text-sm">%s</h2>
                    <h3 class="text-gray-100 font-bold text-base">%s</h3>
                </div>

                <div class="flex flex-col">
                    <h2 class="text-neutral-500 text-sm">%s</h2>
                    <h3 class="text-gray-100 font-bold text-base">%s</h3>
                </div>
            </div>
            
        </sl-card>
    ]]):format(
        identifier,
        firstname,
        lastname,
        (wanted and ([[<sl-badge variant="danger">%s</sl-badge>]]):format(wanted_label) or ""),
        dateofbirth_label,
        dateofbirth,
        sex_label,
        sex
    )
end

function citizen_div_4_licenses(licenses)
    local user_licenses = ""

    for k,v in pairs(licenses) do 
        user_licenses = user_licenses .. ([[<h2 class="text-gray-100 font-bold">%s</h2>]]):format(v)
    end 

    return user_licenses
end

function citizen_div_4_images(images)
    local user_images = ""

    for k,v in pairs(images) do 
        user_images = user_images .. ([[
            <sl-menu-item
                hx-post="/show_image"
                hx-target="#img_box"
                hx-swap="innerHTML"
                hx-vals='{"url": "%s"}'
                >
                %s
            </sl-menu-item>
        ]]):format(
            v.url,
            v.name
        )
    end 

    return user_images
end

function select_person_note(officer, time, identifier, note_id, text)
    return ([[
        <sl-card class="card-header text-neutral-500 pt-4 pr-4">
            <div slot="header" class="text-gray-100 font-bold flex flex-row justify-between">
                %s - %s
                <sl-icon-button
                    name="trash"
                    hx-post="/delete_note"
                    hx-vals='{"identifier": "%s", "note_id": "%s"}'
                    hx-trigger="click"
                    hx-swap="outerHTML"
                    hx-target="closest .card-header"
                </sl-icon-button>
                
            </div>
            <div class="w-[22vw] max-w-[22vw]">
                %s
            </div>
        </sl-card>
    ]]):format(
        officer,
        time,
        identifier,
        note_id,
        text
    )
end

function select_person_crimes(law)
    local law_options = ""

    for k,v in pairs(law) do 
        for o,i in pairs(v.text) do 
            law_options = law_options .. ([[<sl-option value="§%s.%s %s">§%s.%s %s</sl-option>]]):format(k, o, i.label, k, o, i.label)
        end 
    end 

    return law_options
end 

function select_person_crime(crime, description, time, status, officer, identifier, crime_id, status_bool)
    return ([[
        <div class="crime col-span-6 grid grid-cols-6 gap-4 pb-4">
            <div class="col-span-1">%s</div>
            <div class="col-span-1">%s</div>
            <div class="col-span-1">%s</div>
            <sl-badge
                variant="%s"
                class="cursor-pointer"
                hx-post="/change_crime_status"
                hx-vals='{"identifier": "%s", "crime_id": "%s", "status": %s}'
                hx-trigger="click"
                hx-swap="outerHTML">%s
            </sl-badge>
            <div class="col-span-1">%s</div>
            <div class="col-span-1">
                <sl-icon-button
                    name="trash"
                    hx-post="/delete_crime"
                    hx-vals='{"identifier": "%s", "crime_id": "%s"}'
                    hx-trigger="click"
                    hx-swap="outerHTML"
                    hx-target="closest .crime"
                </sl-icon-button>
            </div>
        </div>
    ]]):format(
        crime, 
        description, 
        time, 
        status[1], 
        identifier, 
        crime_id,
        status_bool,
        status[2], 
        officer,
        identifier, 
        crime_id
    )
end

function vehicle_search_vehicle(plate, wanted, wanted_label, owner_label, owner, type_label, type, color_label, color, registered_label, registered, show_registration)
    
    local registration = ""
    if show_registration then 
        registration = ([[
        <div class="flex flex-col w-full">
            <h2 class="text-neutral-500 text-sm">%s</h2>
            <h3 class="text-gray-100 font-bold text-base">%s</h3>
        </div>
        ]]):format(
            registered_label, 
            registered
        )
    end 
    
    return ([[
        <sl-card class="card-header w-full pt-4 text-neutral-500">
            <div slot="header" class="text-gray-100">
                %s
                <sl-badge
                    variant="%s"
                    class="cursor-pointer"
                    hx-post="/change_vehicle_wanted"
                    hx-vals='{"plate": "%s", "wanted": %s}'
                    hx-trigger="click"
                    hx-swap="outerHTML">%s
                </sl-badge>

            </div>

            <div class="flex flex-row items-center gap-40">
                <img src="./img/car.png" alt="user" class="h-8">

                <div class="flex flex-col w-full">
                    <h2 class="text-neutral-500 text-sm">%s</h2>
                    <h3 class="text-gray-100 font-bold text-base">%s</h3>
                </div>

                <div class="flex flex-col w-full">
                    <h2 class="text-neutral-500 text-sm">%s</h2>
                    <h3 class="text-gray-100 font-bold text-base">%s</h3>
                </div>

                <div class="flex flex-col w-full">
                    <h2 class="text-neutral-500 text-sm">%s</h2>
                    <h3 class="text-gray-100 font-bold text-base">%s</h3>
                </div>
                %s
            </div>
            
        </sl-card>
    ]]):format(
        plate,
        wanted_label[1],
        plate, 
        wanted,
        wanted_label[2],
        owner_label,
        owner,
        type_label,
        type,
        color_label, 
        color, 
        registration
    )
end

function weapon_search_weapon(serial, wanted, wanted_label, owner_label, owner, type_label, type)
    return ([[
        <sl-card class="card-header w-full pt-4 text-neutral-500">
            <div slot="header" class="text-gray-100">
                %s
                <sl-badge
                    variant="%s"
                    class="cursor-pointer"
                    hx-post="/change_weapon_wanted"
                    hx-vals='{"serial": "%s", "wanted": %s}'
                    hx-trigger="click"
                    hx-swap="outerHTML">%s
                </sl-badge>

            </div>

            <div class="flex flex-row items-center gap-[20vw]">
                <img src="./img/gun.png" alt="user" class="h-8">

                <div class="flex flex-col">
                    <h2 class="text-neutral-500 text-sm">%s</h2>
                    <h3 class="text-gray-100 font-bold text-base">%s</h3>
                </div>

                <div class="flex flex-col">
                    <h2 class="text-neutral-500 text-sm">%s</h2>
                    <h3 class="text-gray-100 font-bold text-base">%s</h3>
                </div>
            </div>
            
        </sl-card>
    ]]):format(
        serial,
        wanted_label[1],
        serial, 
        wanted,
        wanted_label[2],
        owner_label,
        owner,
        type_label,
        type
    )
end

function track_person(phone_number, identifier, name_label, name, id)
    return(([[
        <sl-card class="card-header text-neutral-500">
        <div slot="header" class="text-gray-100">
            %s
            <sl-icon-button
                name="crosshair"
                hx-post="/track_person"
                hx-vals='{"identifier": "%s"}'
                hx-trigger="click"
                hx-swap="innerHTML"
                hx-target="#info_%s"
            </sl-icon-button>
        </div>
            <div id="info_%s" class=" flex flex-row w-full gap-2 items-center">
                <h2 class="text-neutral-500 text-sm">%s</h2>
                <h3 class="text-gray-100 font-bold text-base">%s</h3>
            </div>
        </sl-card>
    ]]):format(
        phone_number,
        identifier,
        id,
        id,
        name_label,
        name
    ))
end

function track_vehicle(plate, model_label, model, color_label, color, id)
    return(([[
        <sl-card class="card-header text-neutral-500">
        <div slot="header" class="text-gray-100">
            %s
            <sl-icon-button
                name="crosshair"
                hx-post="/track_vehicle"
                hx-vals='{"plate": "%s"}'
                hx-trigger="click"
                hx-swap="innerHTML"
                hx-target="#info_%s"
            </sl-icon-button>
        </div>
            <div id="info_%s" class="flex flex-row w-full gap-2 items-center">
                <div class=" flex flex-row w-full gap-2 items-center">
                    <h2 class="text-neutral-500 text-sm">%s</h2>
                    <h3 class="text-gray-100 font-bold text-base">%s</h3>
                </div>
                <div class=" flex flex-row w-full gap-2 items-center">
                    <h2 class="text-neutral-500 text-sm">%s</h2>
                    <h3 class="text-gray-100 font-bold text-base">%s</h3>
                </div>
            </div>
        </sl-card>
    ]]):format(
        plate,
        plate,
        id,
        id,
        model_label,
        model, 
        color_label, 
        color
    ))
end 

function dispatches_dispatches(identifier, code_color, code, reason, position_vector, time_locales, time, position_locales, position, infos_locales, infos, officer, copsData, add_officer_locales, info_header, info_description, info_button, code_header, code_description, code_button, dispatch_delete, codes)
    local officer_list = ""
    local officer_add = ""
    local code_list = ""

    for k,v in pairs(codes) do 
        if k ~= "n/A" then 
            code_list = code_list .. ([[<sl-option value="%s">%s</sl-option>]]):format(k, k)
        end 
    end 

    for k,v in pairs(officer) do 
        officer_list = officer_list .. ([[
            <sl-badge 
                class="pr-2" 
                variant="primary" 
                style="cursor: pointer;"
                hx-post="/dispatch_remove_officer"
                hx-vals='{"identifier": "%s", "officer": "%s"}'
                hx-swap="outerHTML"
                hx-trigger="click">%s
            </sl-badge>
        ]]):format(
            identifier,
            v,
            v
        )  
    end 

    for k,v in pairs(copsData) do 
        officer_add = officer_add .. ([[
            <sl-menu-item 
                value="%s"
                hx-post="/dispatch_add_officer"
                hx-vals='{"identifier": "%s", "officer": "%s"}'
                hx-target="closest .officerlist" 
                hx-swap="outerHTML"
                hx-trigger="click">%s
            </sl-menu-item>
        ]]):format(k+1, identifier, v.name, v.name)
    end 

    officer_list = officer_list .. ([[
        <div class="relative inline-block">
            <sl-dropdown>
                <sl-icon-button
                    slot="trigger"
                    name="plus"
                    label="plus">
                </sl-icon-button>

                <sl-menu>
                    <sl-menu-item value="1">%s</sl-menu-item>
                    <sl-divider class="h-[1px] bg-neutral-500"></sl-divider>
                    %s
                </sl-menu>
            </sl-dropdown>
        </div>
    ]]):format(
        add_officer_locales,
        officer_add
    )

    return ([[
        <sl-card class="dispatch card-header w-full pt-4">
            <div slot="header" class="flex flex-row justify-between">
                <div class="flex flex-row items-center">
                    
                    <div class="code_select relative inline-block">
                        <sl-dropdown>
                            <sl-badge
                                slot="trigger"
                                variant="%s"
                                style="cursor: pointer;">%s
                            </sl-badge>

                            <sl-card class="w-[15vw]">
                                <div slot="header">
                                    <h2 class="text-gray-100 font-bold">%s</h2>
                                </div>

                                <form hx-post="/dispatch_edit_code" 
                                    hx-trigger="submit" 
                                    hx-swap="outerHTML"
                                    hx-target="closest .code_select"
                                    hx-vals='js:{ identifier: %s, code: document.querySelector("#code_select-%s").value}'>

                                    <sl-select id="code_select-%s" label="%s" class="text-neutral-500 mt-4" value="%s">
                                        %s
                                        <sl-option value="delete">%s</sl-option>
                                    </sl-select>
                                    
                                    <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
                                </form>

                            </sl-card>


                        </sl-dropdown>
                    </div>

                    <h3 class="pl-2 text-gray-100 font-bold">%s</h3>  
                </div>

                <sl-icon-button
                    name="geo-alt"
                    label="Favorit"
                    hx-post="/create_marker"
                    hx-vals='{"position": %s}'
                    hx-trigger="click"
                </sl-icon-button>

                <sl-icon-button
                    name="trash"
                    label="Trash"
                    hx-post="/create_marker"
                    hx-vals='{"position": "hallo"}'
                    hx-trigger="click"
                </sl-icon-button>

            </div>
            <sl-badge variant="success">
                <sl-icon name="clock" style="margin-right: 4px;"></sl-icon>
                %s %s
            </sl-badge>
            <sl-badge variant="danger">
                <sl-icon name="signpost-split" style="margin-right: 4px;"></sl-icon>
                %s %s
            </sl-badge>


            <div class="dispatch_info relative inline-block">
                <sl-dropdown>
                    <sl-badge
                    slot="trigger"
                    variant="primary"
                    style="cursor: pointer;"
                >
                    <sl-icon name="exclamation-octagon" style="margin-right: 4px;"></sl-icon>
                        %s %s
                    </sl-badge>

                    <sl-card class="w-[15vw]">
                        <div slot="header">
                            <h2 class="text-gray-100 font-bold">%s</h2>
                        </div>

                        <form hx-post="/dispatch_edit_info" 
                            hx-trigger="submit" 
                            hx-swap="outerHTML"
                            hx-target="closest .dispatch_info"
                            hx-vals='js:{ identifier: %s, info: document.querySelector("#info").value}'>
                            
                            <sl-textarea id="info" class="text-neutral-500 mt-4" label="%s" value="%s"></sl-textarea>

                            <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
                        </form>

                    </sl-card>


                </sl-dropdown>
            </div>

            <div slot="footer">
                <div class="officerlist flex flex-row items-center">
                    %s
                </div> 
            </div>
        </sl-card>
    ]]):format(
        code_color,
        code,
        code_header,
        identifier,
        identifier,
        identifier,
        code_description,
        code,
        code_list,
        dispatch_delete,
        code_button,

        reason,
        position_vector,

        time_locales,
        time,

        position_locales,
        position,

        infos_locales,
        infos,

        info_header,
        identifier,
        info_description,
        infos,
        info_button,

        officer_list
    )
end 

function dispatches_officer(name, status_color, status, callname_color, callname_locales, callname, vehicle_color, vehicle_locales, vehicle, position_color, position_locales, position)
    return ([[
        <sl-card class="card-header w-full pt-4">
            <div slot="header" class="flex flex-row">

                <div class="flex flex-row gap-2">
                    <sl-badge variant="%s">
                        %s
                    </sl-badge>
                    <h3 class="text-gray-100 font-bold">%s</h3>  
                </div>
            </div>


            <sl-badge variant="%s">
                <sl-icon name="person" style="margin-right: 4px;"></sl-icon>
                %s %s
            </sl-badge>

            <sl-badge variant="%s">
                <sl-icon name="truck" style="margin-right: 4px;"></sl-icon>
                %s %s
            </sl-badge>

            <sl-badge variant="%s">
                <sl-icon name="signpost-split" style="margin-right: 4px;"></sl-icon>
                %s %s
            </sl-badge> 
        </sl-card>
    ]]):format(
        status_color,
        status,
        name, 

        callname_color,
        callname_locales,
        callname,

        vehicle_color,
        vehicle_locales,
        vehicle,

        position_color,
        position_locales,
        position
    )
end 

function dashboard_div_3_element(name, reason, infos)
    return ([[
        <sl-card class="card-header w-full pt-4">
            <div slot="header">
                <h3 class="text-gray-100 font-bold">%s</h3>  
            </div>
            <h2 class="text-neutral-500">%s</h2> 
            <sl-details summary="Weiterlesen" class="pt-4 text-neutral-500">
                <h3 class="text-gray-100">%s</h3>  
            </sl-details>

        </sl-card>
    ]]):format(
        name,
        reason,
        infos
    )
end 

function list_vehicle(category, label, grade, price, identifier)
    return ([[
        <div class="crime col-span-5 grid grid-cols-5 gap-4 pb-4">
            <div class="col-span-1">%s</div>
            <div class="col-span-1">%s</div>
            <sl-badge
                variant="warning">%s
            </sl-badge>
            <div class="col-span-1">%s</div>
            <div class="col-span-1">
                <sl-icon-button
                    name="trash"
                    hx-post="/delete_vehicle"
                    hx-vals='{"vehicle": %s}'
                    hx-trigger="click"
                    hx-swap="innerHTML"
                    hx-target="#vehicles_list"
                </sl-icon-button>
            </div>
        </div>
    ]]):format(
        category, 
        label, 
        grade, 
        price,
        identifier
    )
end

function list_outfit(name, url, grade, unit, outfit_numbers_locales, identifier, outfit)

    if url == "" or url == nil then 
        url = "./img/no_outfit.png"
    end 

    local outfit_data = ""
    for k,v in pairs(outfit) do 
        if v.part_1 ~= "n/A" or v.part_2 ~= "n/A" then 
            outfit_data = outfit_data .. ([[<sl-menu-item>%s: %s %s</sl-menu-item>]]):format(v.part_name, v.part_1, v.part_2)
        end 
    end 

    return ([[
        <sl-card class="card-overview h-[37vh]">
    
            <div class="outfit_body">
                <img
                    slot="image"
                    src="%s"
                    alt="Outfit"
                    style="width: 150px;"
                    class="mx-auto"
                />
    
                <div class="text-gray-100 w-full">%s</div>
                <sl-badge
                    variant="warning">%s
                </sl-badge>
                <div class="text-neutral-500 w-full">%s</div>
            </div>
    
            <div slot="footer">
                <div class="w-full flex flex-row items-center justify-between">

                    <div class="relative inline-block">
                        <sl-dropdown>
                            <sl-button variant="success" slot="trigger" >%s</sl-button>

                            <sl-menu>
                                %s
                            </sl-menu>
                        </sl-dropdown>
                    </div>

                    <sl-icon-button
                        name="trash"
                        hx-post="/delete_outfit"
                        hx-vals='{"identifier": %s}'
                        hx-trigger="click"
                        hx-target="closest .card-overview"
                        hx-swap="outerHTML"
                    </sl-icon-button>
                </div>
            </div>
        </sl-card>  
    ]]):format(
        url,
        name,
        grade, 
        unit,
        outfit_numbers_locales,
        outfit_data,
        identifier
    )
end

function list_training(label, description, supervisor, time, location, limit, list, name, login_locales, identifier)
    
    local asigned = false

    for k,v in pairs(list) do 
        if v == name then 
            asigned = true 
            break
        end
    end 

    
    return ([[
        <div class="training col-span-8 grid grid-cols-8 gap-4 pb-4">
            <div class="col-span-1">%s</div>
            <div class="col-span-1">%s</div>
            <sl-badge
                class="h-8" variant="warning">%s
            </sl-badge>
            <div class="col-span-1">%s</div>
            <div class="col-span-1">%s</div>

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
            
            <div class="col-span-1 flex gap-2">

                <sl-icon-button
                    name="trash"
                    hx-post="/delete_training"
                    hx-vals='{"identifier": %s}'
                    hx-trigger="click"
                    hx-swap="outerHTML"
                    hx-target="closest .training"
                ></sl-icon-button>

                <sl-icon-button
                    name="check2-circle"
                    hx-post="/submit_training"
                    hx-vals='{"identifier": %s}'
                    hx-trigger="click"
                    hx-swap="outerHTML"
                    hx-target="closest .training"
                ></sl-icon-button>

            </div>

            
        </div>
    ]]):format(
        label, 
        description, 
        supervisor, 
        time, 
        location,
        login_locales[asigned][2], 
        identifier,
        login_locales[asigned][1],
        ((#list) .. '/' .. limit),
        identifier,
        identifier
    )
end

function list_law(label, description, jail, fine, society, paragraph)
    return ([[
        <div class="crime col-span-6 grid grid-cols-6 gap-4 pb-4">
            <div class="col-span-1">%s</div>
            <div class="col-span-1">%s</div>
            <sl-badge
                class="h-8" variant="danger">%s
            </sl-badge>
            <sl-badge
                class="h-8" variant="success">%s
            </sl-badge>
            <sl-badge
                class="h-8" variant="primary">%s
            </sl-badge>
            <div class="col-span-1 w-full flex flex-row justify-end">
                <sl-icon-button
                    name="trash"
                    hx-post="/delete_paragraph_crime"
                    hx-vals='{"paragraph": "%s", "crime": "%s"}'
                    hx-trigger="click"
                    hx-swap="innerHTML"
                    hx-target="closest .crime"
                </sl-icon-button>
            </div>
        </div>
    ]]):format(
        label, 
        description, 
        jail, 
        fine, 
        society, 
        paragraph,
        label
    )
end

function documents_document(id, time, officer, identifier, data, tag_data)

    local label = ""
    for k,v in pairs(Config.Documents) do 
        if v.id == id then 
            label = v.label[Config.Language]
        end 
    end 

    local tags = ""

    for k,v in pairs((data.tags or {})) do 
        for o,i in pairs(tag_data) do 
            if o == v then 
                tags = tags .. ([[<sl-badge variant="primary">%s</sl-badge>]]):format(i)
            end 
        end 
    end 


    return ([[
        <sl-card 
            class="card-header pb-2" 
            style="cursor: pointer;"
            hx-post="/show_document"
            hx-trigger="click"
            hx-swap="innerHTML"
            hx-vals='{"document": %s}'
            hx-target="#document_body"
        >
            <div slot="header" class="text-gray-100">
                %s - %s
            </div>

            <div class="w-full text-gray-100">
                Tags: %s
            </div>

            <div slot="footer" class="text-neutral-500">
                <sl-badge
                    class="h-8" variant="warning">%s
                </sl-badge>
                %s
            </div>
        </sl-card>
    ]]):format(
        identifier,
        label, 
        identifier,
        tags,
        officer, time
    )
end