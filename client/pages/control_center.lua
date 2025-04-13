
locales = Config.Locales[Config.Language]

RegisterNUICallback('load_control_center', function(data, cb)

    local selfData      = getSelfData()
    local copsData      = getCopsData()
    local buttonData    = getButtons()

    local div_1_elements = ""
    local div_2_elements = ""
    local div_3_elements = ""

    local officer_list = ""
    local buttons = ""

    for k,v in pairs(locales['pages']['control_center']['div_1_data']) do 
        div_1_elements = div_1_elements .. control_center_div_1_element(
            k,
            getDataCount(copsData, 'vehicle', v)
        )
    end 

    for k,v in pairs(locales['pages']['control_center']['div_2_data']) do 
        div_2_elements = div_2_elements .. control_center_div_1_element(
            k,
            getDataCount(copsData, 'position', v)
        )
    end 

    for k,v in pairs(locales['pages']['control_center']['div_3_data']) do 
        div_3_elements = div_3_elements .. control_center_div_1_element(
            k,
            getDataCount(copsData, 'callname', v)
        )
    end 

    for k,v in pairs(locales['callname']) do 
        if k ~= 'n/A' then 
            officer_list = officer_list .. control_center_div_2_element(
                k,
                copsData
            )
        end 
    end 

    for k,v in pairs(buttonData) do 
        buttons = buttons .. control_center_buttons(
            v.text,
            v.identifier
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

                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_dashboard" panel="dashboard">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_control_center" panel="control_center" active>%s</sl-tab>
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
                <div class="basis-3/4">
                    <div class="flex flex-col">
                        <div class="flex flex-row gap-4">
                            <div class="w-full">
                                <h2 class="text-gray-100">%s</h2>
                                <h3 class="text-neutral-500">%s</h3>
                                <sl-divider class="w-full h-[1px] bg-neutral-500 mb-8"></sl-divider>
                                %s
                            </div>
                            <div class="w-full">
                                <h2 class="text-gray-100">%s</h2>
                                <h3 class="text-neutral-500">%s</h3>
                                <sl-divider class="w-full h-[1px] bg-neutral-500 mb-8"></sl-divider>
                                %s
                            </div>
                            <div class="w-full">
                                <h2 class="text-gray-100">%s</h2>
                                <h3 class="text-neutral-500">%s</h3>
                                <sl-divider class="w-full h-[1px] bg-neutral-500 mb-8"></sl-divider>
                                %s
                            </div>
                        </div>
                        <div class="flex flex-col">
                            <div class="w-full mt-12">
                                <h2 class="text-gray-100">%s</h2>
                                <sl-divider class="w-full h-[1px] bg-neutral-500 mb-8" style="height: 2px;"></sl-divider>
                                
                                <div class="max-h-[40vh] min-h-[40vh] overflow-y-auto">

                                    <div>
                                        <h2 class="text-gray-100">%s</h2>
                                        <sl-divider class="w-full h-[1px] bg-neutral-500 mb-8"></sl-divider>
                                        <sl-card class="card-basic w-full">
                                            <div class="flex flex-row gap-2">
                                                <sl-badge style="height: 25px;" variant="success">%s</sl-badge>
                                                <sl-badge style="height: 25px;" variant="success">%s</sl-badge>

                                                <sl-dropdown hoist placement="bottom-start" class="info_btn">
                                                    <sl-badge 
                                                        slot="trigger"
                                                        variant="%s"
                                                        style="cursor: pointer; height: 25px; display: inline-flex; align-items: center;">%s
                                                    </sl-badge>
                                                    <sl-menu>
                                                        <div class="flex flex-col p-2 gap-2">
                                                            %s
                                                        </div>
                                                    </sl-menu>
                                                </sl-dropdown>

                                                <sl-dropdown hoist placement="bottom-start" class="info_btn">
                                                    <sl-badge 
                                                        slot="trigger"
                                                        variant="%s"
                                                        style="cursor: pointer; height: 25px; display: inline-flex; align-items: center;">%s
                                                    </sl-badge>
                                                    <sl-menu>
                                                        <div class="flex flex-col p-2 gap-2">
                                                            %s
                                                        </div>
                                                    </sl-menu>
                                                </sl-dropdown>

                                                <sl-dropdown hoist placement="bottom-start" class="info_btn">
                                                    <sl-badge 
                                                        slot="trigger"
                                                        variant="%s"
                                                        style="cursor: pointer; height: 25px; display: inline-flex; align-items: center;">%s
                                                    </sl-badge>
                                                    <sl-menu>
                                                        <div class="flex flex-col p-2 gap-2">
                                                            %s
                                                        </div>
                                                    </sl-menu>
                                                </sl-dropdown>

                                                <sl-dropdown hoist placement="bottom-start" class="info_btn">
                                                    <sl-badge 
                                                        slot="trigger"
                                                        variant="%s"
                                                        style="cursor: pointer; height: 25px; display: inline-flex; align-items: center;">%s
                                                    </sl-badge>
                                                    <sl-menu>
                                                        <div class="flex flex-col p-2 gap-2">
                                                            %s
                                                        </div>
                                                    </sl-menu>
                                                </sl-dropdown>

                                                <sl-dropdown hoist placement="bottom-start" class="info_btn">
                                                    <sl-badge 
                                                        slot="trigger"
                                                        variant="%s"
                                                        style="cursor: pointer; height: 25px; display: inline-flex; align-items: center;">%s
                                                    </sl-badge>
                                                    <sl-menu>
                                                        <div class="flex flex-col p-2 gap-2">
                                                            %s
                                                        </div>
                                                    </sl-menu>
                                                </sl-dropdown>

                                                <sl-dropdown hoist placement="bottom-start" class="info_btn">
                                                    <sl-badge 
                                                        slot="trigger"
                                                        variant="%s"
                                                        style="cursor: pointer; height: 25px; display: inline-flex; align-items: center;">%s
                                                    </sl-badge>
                                                    <sl-menu>
                                                        <div class="flex flex-col p-2 gap-2">
                                                            %s
                                                        </div>
                                                    </sl-menu>
                                                </sl-dropdown>

                                                <sl-dropdown hoist placement="bottom-start" class="info_btn">
                                                    <sl-badge 
                                                        slot="trigger"
                                                        variant="%s"
                                                        style="cursor: pointer; height: 25px; display: inline-flex; align-items: center;">%s
                                                    </sl-badge>
                                                    <sl-menu>
                                                        <div class="flex flex-col p-2 gap-2">
                                                            %s
                                                        </div>
                                                    </sl-menu>
                                                </sl-dropdown>

                                                <sl-dropdown hoist placement="bottom-start" class="info_btn">
                                                    <sl-badge 
                                                        slot="trigger"
                                                        variant="%s"
                                                        style="cursor: pointer; height: 25px; display: inline-flex; align-items: center;">%s
                                                    </sl-badge>
                                                    <sl-menu>
                                                        <div class="flex flex-col p-2 gap-2">
                                                            %s
                                                        </div>
                                                    </sl-menu>
                                                </sl-dropdown>

                                                <sl-badge style="height: 25px;" class="cursor-pointer" hx-trigger="click" hx-swap="outerHTML" hx-post="/change_self_info_logout" variant="danger">%s</sl-badge>

                                            </div>
                                        </sl-card>
                                    </div>

                                    <div 
                                        id="officer_list"
                                        hx-get="/get_officer_list"
                                        hx-trigger="officer_list"
                                        hx-swap="innerHTML">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="basis-1/4">
                    <div id="button_and_btn" class="flex flex-col gap-2 max-h-[20vh] min-h-[20vh] overflow-y-auto">
                        %s
                        <sl-card class="card-basic w-full text-gray-100 text-center" style="cursor: pointer; --padding: 0.4rem; height: auto;" hx-trigger="click" hx-swap="outerHTML" hx-post="/create_button">
                            %s
                        </sl-card>  
                    </div>

                    <style>
                        sl-button::part(base) {
                            white-space: normal;
                            text-align: center;
                            cursor: default !important;
                        }
                    </style>

                    <sl-card class="card-basic w-[20vw] pb-4">
                        
                        <div class="h-[42vh] flex flex-col-reverse gap-2 overflow-y-auto p-4" id="chat-box" hx-get="/load_chat" hx-trigger="every 1s" hx-swap="innerHTML"></div>

                        <form onsubmit="htmx.ajax('POST', '/send_message', { target: this, swap: 'beforebegin', values: { message: this.querySelector('sl-input').value } }); this.reset(); return false;" class="px-4 pt-2">
                            <sl-input name="message" placeholder="%s" clearable class="w-full">
                                <sl-icon-button slot="suffix" name="send" label="Senden" type="submit"></sl-icon-button>
                            </sl-input>
                        </form>

                    </sl-card>
                </div>
            </div>

            <script>
                htmx.trigger(document.getElementById("officer_list"), "officer_list");
            </script>
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
        locales['pages']['control_center']['div_1_header'],
        locales['pages']['control_center']['div_1_subheader'],
        div_1_elements,

        --div_2
        locales['pages']['control_center']['div_2_header'],
        locales['pages']['control_center']['div_2_subheader'],
        div_2_elements,

        --div_3
        locales['pages']['control_center']['div_3_header'],
        locales['pages']['control_center']['div_3_subheader'],
        div_3_elements,

        locales['pages']['control_center']['control_center_header'],
        locales['pages']['control_center']['your_status_header'],

        selfData.job_grade_label,
        selfData.name,
        locales['callname'][selfData.callname], selfData.callname, editInfoBtn('callname'),
        locales['status'][selfData.status], selfData.status, editInfoBtn('status'),
        locales['position'][selfData.position], selfData.position, editInfoBtn('position'),
        locales['vehicle'][selfData.vehicle], selfData.vehicle, editInfoBtn('vehicle'),
        locales['frequency'][(selfData.frequency.."")], selfData.frequency, editInfoBtn('frequency'),
        (selfData.o1 == "n/A" and "warning" or "success"), selfData.o1, editInfoBtn('o1'),
        (selfData.o2 == "n/A" and "warning" or "success"), selfData.o2, editInfoBtn('o2'),
        (selfData.o3 == "n/A" and "warning" or "success"), selfData.o3, editInfoBtn('o3'),
        locales['pages']['control_center']['logout'],
        buttons,
        locales['pages']['control_center']['create_button'],
        locales['pages']['control_center']['enter_message']
    ))
end)

RegisterNUICallback('get_officer_list', function(data, cb)

    local officer_list = ""
    local copsData = getCopsData()

    for k,v in pairs(locales['callname']) do 
        if k ~= 'n/A' then 
            officer_list = officer_list .. control_center_div_2_element(
                k,
                copsData
            )
        end 
    end 

    cb(officer_list)
end)


RegisterNUICallback('set_personal_information', function(data, cb)
    
    local key = data.key
    local value = data.value

    changeSelfData(key, value)

    local color = ""

    if key == "o1" or key == "o2" or key == "o3" then 
        if value =='n/A' then 
            color = 'warning'
        else 
            color = 'success'
        end 
    else 
        color = locales[key][value]
    end 
    
    cb(([[
        <sl-dropdown hoist placement="bottom-start" class="info_btn">
            <sl-badge 
                slot="trigger"
                variant="%s"
                style="cursor: pointer; height: 25px; display: inline-flex; align-items: center;">%s
            </sl-badge>
            <sl-menu>
                <div class="flex flex-col p-2 gap-2">
                    %s
                </div>
            </sl-menu>
        </sl-dropdown>

        <script>
            htmx.trigger(document.getElementById("officer_list"), "officer_list");
        </script>
    ]]):format(
        color, 
        value, 
        editInfoBtn(key)
    ))
end)

RegisterNUICallback('change_self_info_logout', function(data, cb)
    
    changeSelfData('callname', 'n/A')
    changeSelfData('status', 'n/A')
    changeSelfData('position', 'n/A')
    changeSelfData('vehicle', 'n/A')
    changeSelfData('frequency', 'n/A')
    changeSelfData('o1', 'n/A')
    changeSelfData('o2', 'n/A')
    changeSelfData('o3', 'n/A')

    cb([[

        <div 
            id="logout"
            hx-get="/load_control_center"
            hx-trigger="logout"
            hx-swap="innerHTML"
            hx-target="#content">
        </div>
        
        <script>
            htmx.trigger(document.getElementById("logout"), "logout");  
        </script>

    ]])

end)

RegisterNUICallback('create_button', function(data, cb)
    cb(([[
        <sl-card class="w-full">
            <div slot="header">
                <h2 class="text-gray-100 font-bold">%s</h2>
            </div>

            <form hx-post="/submit_button" 
                hx-trigger="submit" 
                hx-swap="innerHTML"
                hx-target="#button_and_btn"
                hx-vals='js:{ text: document.querySelector("#title").value}'>
                
                <sl-input id="title" class="text-neutral-500" label="%s"></sl-input>
                <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
            </form>

        </sl-card>
    ]]):format(
        locales['pages']['control_center']['create_button_header'],
        locales['pages']['control_center']['create_button_text'],
        locales['pages']['control_center']['create_button_submit']
    ))
end)

RegisterNUICallback('submit_button', function(data, cb)
    local text = data.text

    local buttonData = addButton(text)
    local buttons = ""

    for k,v in pairs(buttonData) do 
        buttons = buttons .. control_center_buttons(
            v.text,
            v.identifier
        )
    end 

    cb(([[
        %s
        <sl-card class="card-basic w-full text-gray-100 text-center" style="cursor: pointer; --padding: 0.4rem; height: auto;" hx-trigger="click" hx-swap="outerHTML" hx-post="/create_button">
            %s
        </sl-card>  
    ]]):format(
        buttons,
        locales['pages']['control_center']['create_button']
    ))
end)

RegisterNUICallback('delete_button', function(data, cb)
    local identifier = data.identifier
    local buttonData = deleteButton(identifier)
    cb([[]])
end)

RegisterNUICallback('send_message', function(data, cb)
    local message = data.message
    local chatData = postMessage(message)
    cb([[]])
end)

RegisterNUICallback('load_chat', function(data, cb)
    local chatData = getChat().chat
    local playerIdentifier = getChat().identifier
    local chatHistory = ""

    table.sort(chatData, function(a, b)
        return a.identifier > b.identifier
    end)

    for k,v in pairs(chatData) do 
        if v.sender == playerIdentifier then 
            chatHistory = chatHistory .. control_center_own_chat(
                v.name,
                v.text
            )
        else 
            chatHistory = chatHistory .. control_center_other_chat(
                v.name,
                nameToIcon(v.name),
                v.text
            )
        end 
    end 


    cb(chatHistory)
end)