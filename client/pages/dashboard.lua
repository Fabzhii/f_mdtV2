
locales = Config.Locales[Config.Language]

RegisterNUICallback('load_dashboard', function(data, cb)

    local selfData      = getSelfData()
    local copsData      = getCopsData()
    local wantedsData   = getWanteds()
    local dispatchesData= getDispatches()
    local infoData      = getInformation()

    local div_2_elements = ""
    local div_3_elements = ""
    local div_4_elements = ""
    local div_5_elements = ""

    for k,v in pairs(copsData) do 
        div_2_elements = div_2_elements .. dashboard_div_2_element(
            v.name, 
            locales['pages']['dashboard']['div_1_tel'], v.phone_number,
            locales['status'][v.status], locales['pages']['dashboard']['div_1_status'], v.status,
            locales['callname'][v.callname], locales['pages']['dashboard']['div_1_callname'], (v.callname .. ' - ' .. v.callnumber),
            locales['vehicle'][v.vehicle], locales['pages']['dashboard']['div_1_vehicle'], v.vehicle,
            locales['position'][v.position], locales['pages']['dashboard']['div_1_position'], v.position
        )
    end 

    for k,v in pairs(wantedsData) do 
        div_3_elements = div_3_elements .. dashboard_div_3_element(
            v.name,
            v.reason,
            v.infos
        )
    end 

    for k,v in pairs(dispatchesData) do 
        local position = json.decode(v.position)
        div_4_elements = div_4_elements .. dashboard_div_4_element(
            locales['code'][v.code], v.code,
            v.reason,
            v.position,
            locales['pages']['dashboard']['div_4_time'], v.time,
            locales['pages']['dashboard']['div_4_position'], 
            GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, 70.0, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())),
            locales['pages']['dashboard']['div_4_infos'], v.infos
        )
    end 

    for k,v in pairs(infoData) do 
        div_5_elements = div_5_elements .. dashboard_div_5_element(
            v.title,
            v.information,
            v.identifier,
            locales['pages']['dashboard']['div_5_delete_button']
        )
    end 

    cb(([[
        <div>
            <sl-tab-group>
                <sl-tab slot="nav" panel="name" disabled>%s</sl-tab>
                <sl-tab slot="nav" panel="space1" disabled>|</sl-tab>
                <sl-tab slot="nav" panel="grade" disabled>%s</sl-tab>
                <sl-tab slot="nav" panel="space2" disabled> </sl-tab>
                <sl-tab slot="nav" panel="space3" disabled> </sl-tab>

                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_dashboard" panel="dashboard" active>%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_control_center" panel="control_center">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_citizen_search" panel="citizen_search">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_vehicle_search" panel="vehicle_search">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_weapon_search" panel="weapon_search">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_tracking" panel="tracking">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_dispatches" panel="dispatches">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_lists" panel="lists">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_documents" panel="documents">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_calculator" panel="calculator">%s</sl-tab>
            </sl-tab-group>
            

            <div class="flex flex-row justify-between pl-4 pt-8 gap-4 pr-4">
                <div class="w-full">
                    <div>
                        <h2 class="text-gray-100">%s</h2>
                        <h3 class="text-neutral-500">%s</h3>
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
                        <div class="flex flex-row gap-2">
                            <h2 class="text-neutral-500">%s</h2>
                            <h3 class="text-gray-100 font-bold">%s</h3>
                        </div>
                    </div>
                    <div class="mt-12">
                        <h2 class="text-gray-100">%s</h2>
                        <h3 class="text-neutral-500">%s</h3>
                        <sl-divider class="w-full h-[1px] bg-neutral-500 mb-8"></sl-divider>
                        <div class="max-h-96 overflow-y-auto">
                            %s
                        </div>
                    </div>
                </div>
                <div class="w-full">
                    <div>
                        <h2 class="text-gray-100">%s</h2>
                        <h3 class="text-neutral-500">%s</h3>
                        <sl-divider class="w-full h-[1px] bg-neutral-500"></sl-divider>
                        <div class="max-h-80 overflow-y-auto">
                            %s
                        </div>
                    </div>
                    <div class="mt-12">
                        <h2 class="text-gray-100">%s</h2>
                        <h3 class="text-neutral-500">%s</h3>
                        <sl-divider class="w-full h-[1px] bg-neutral-500"></sl-divider>
                        <div class="max-h-[31vh] overflow-y-auto">
                            %s
                        </div>
                    </div>
                </div>
                <div class="w-full">
                    <div>
                        <h2 class="text-gray-100">%s</h2>
                        <h3 class="text-neutral-500">%s</h3>
                        <sl-divider class="w-full h-[1px] bg-neutral-500"></sl-divider>
                        <div id="information_and_btn">
                            <sl-button variant="primary" class="w-full" hx-post="/create_information" hx-swap="outerHTML">%s</sl-button>
                            <div id="information" class="max-h-[58vh] overflow-y-auto pt-4">
                                %s
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            

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

        --div_1
        locales['pages']['dashboard']['div_1_header'],
        locales['pages']['dashboard']['div_1_subheader'],
        locales['pages']['dashboard']['div_1_name'], selfData.name,
        locales['pages']['dashboard']['div_1_callname'], selfData.callname,
        locales['pages']['dashboard']['div_1_status'], selfData.status,
        locales['pages']['dashboard']['div_1_position'], selfData.position,
        locales['pages']['dashboard']['div_1_tel'], selfData.phone_number,

        --div_2
        locales['pages']['dashboard']['div_2_header'],
        locales['pages']['dashboard']['div_2_subheader'],
        div_2_elements,

        --div_3
        locales['pages']['dashboard']['div_3_header'],
        locales['pages']['dashboard']['div_3_subheader'],
        div_3_elements,

        --div_4
        locales['pages']['dashboard']['div_4_header'],
        locales['pages']['dashboard']['div_4_subheader'],
        div_4_elements,

        --div_5
        locales['pages']['dashboard']['div_5_header'],
        locales['pages']['dashboard']['div_5_subheader'],
        locales['pages']['dashboard']['div_5_create_button'],
        div_5_elements
    ))
end)

RegisterNUICallback('create_marker', function(data, cb)
    local position = data.position
    if not position then position = {x = data.x, y = data.y} end 

    SetNewWaypoint(position.x, position.y)
    cb([[]])
end)

RegisterNUICallback('create_call', function(data, cb)
    local number = data.number
    exports[GetCurrentResourceName()]:call(number)
end)

RegisterNUICallback('create_information', function(data, cb)
    cb(([[
        <sl-card class="w-full p-4">
            <div slot="header">
                <h2 class="text-gray-100 font-bold">%s</h2>
            </div>

            <form hx-post="/submit_information" 
                hx-trigger="submit" 
                hx-swap="innerHTML"
                hx-target="#information_and_btn"
                hx-vals='js:{ title: document.querySelector("#title").value, info: document.querySelector("#info").value}'>
                
                <sl-input id="title" class="text-neutral-500" label="%s"></sl-input>
                
                <sl-textarea id="info" class="text-neutral-500 mt-4" label="%s"></sl-textarea>

                <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
            </form>

        </sl-card>
    ]]):format(
        locales['pages']['dashboard']['div_5_create_button'],
        locales['pages']['dashboard']['div_5_title'],
        locales['pages']['dashboard']['div_5_infos'],
        locales['pages']['dashboard']['div_5_submit']
    ))
end)

RegisterNUICallback('submit_information', function(data, cb)
    local title = data.title
    local information = data.info

    local infoData = addInformation(title, information)
    local div_5_elements = ""

    for k,v in pairs(infoData) do 
        div_5_elements = div_5_elements .. dashboard_div_5_element(
            v.title,
            v.information,
            v.identifier,
            locales['pages']['dashboard']['div_5_delete_button']
        )
    end 

    cb(([[
        <sl-button variant="primary" class="w-full" hx-post="/create_information" hx-swap="outerHTML">%s</sl-button>
        <div id="information" class="max-h-[58vh] overflow-y-auto pt-4">
            %s
        </div>
    ]]):format(
        locales['pages']['dashboard']['div_5_create_button'],
        div_5_elements
    ))
end)

RegisterNUICallback('delete_information', function(data, cb)
    local identifier = data.identifier
    
    local infoData = deleteInformation(identifier)
    local div_5_elements = ""

    for k,v in pairs(infoData) do 
        div_5_elements = div_5_elements .. dashboard_div_5_element(
            v.title,
            v.information,
            v.identifier,
            locales['pages']['dashboard']['div_5_delete_button']
        )
    end 

    cb(div_5_elements)
end)