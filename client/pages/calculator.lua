
locales = Config.Locales[Config.Language]

RegisterNUICallback('load_calculator', function(data, cb)

    local selfData      = getSelfData()
    local lawData       = getLaw()

    local vals = ""
    local options = ""

    for k,v in pairs(lawData) do 
        local crimes = ""
        vals = vals .. ([[%s: document.querySelector("#%s").value,]]):format(v.paragraph, v.paragraph)

        for o,i in pairs(v.text) do
            crimes = crimes .. ([[<sl-option value="%s:%s:%s">%s</sl-option>]]):format(i.jail, i.fine, i.society, i.label)
        end     

        options = options .. ([[
            <sl-select id="%s" label="%s" multiple clearable class="text-neutral-500 w-full pb-4">
                %s
            </sl-select>
        ]]):format(v.paragraph, v.paragraph, crimes)
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
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_control_center" panel="control_center">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_citizen_search" panel="citizen_search">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_vehicle_search" panel="vehicle_search">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_weapon_search" panel="weapon_search">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_tracking" panel="tracking">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_dispatches" panel="dispatches">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_lists" panel="lists">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_documents" panel="documents">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_calculator" panel="calculator" active>%s</sl-tab>
            </sl-tab-group>
            
            <div class="w-[60vw] mx-auto mt-8 flex flex-col max-h-[64vh] overflow-y-auto">
                <div>
                    <h2 class="text-gray-100">%s</h2>
                    <h3 class="text-neutral-500">%s</h3>
                    <sl-divider class="w-full h-[2px] bg-neutral-500 mb-8"></sl-divider>
                </div>

                <form 
                    class="w-full"
                    hx-post="/calc_law" 
                    hx-trigger="every 0.5s" 
                    hx-swap="innerHTML"
                    hx-target="#calc_output"
                    hx-vals='js:{%s}'>
                    %s
                </form>

                <div id="calc_output"></div>
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

        locales['pages']['calculator']['header'],
        locales['pages']['calculator']['description'],
        vals,
        options
    ))
end)

RegisterNUICallback('calc_law', function(data, cb)

    local fine = 0
    local jail = 0
    local society = 0

    for k,v in pairs(data) do 
        for o,i in pairs(v) do 
            local jailAdd, fineAdd, societyAdd = i:match("^(%d+):(%d+):(%d+)$")
            fine = fine + tonumber(fineAdd)
            jail = jail + tonumber(jailAdd)
            society = society + tonumber(societyAdd)
        end 
    end 


    cb(([[
        <div class="w-full flex flex-col">
            <sl-divider class="w-full h-[1px] bg-neutral-500 mb-2"></sl-divider>
            
            <div class="w-full flex flex-row gap-2">
                <h2 class="text-neutral-500">%s</h2>
                <h3 class="text-gray-100 font-bold">%s</h3>
            </div>

            <div class="w-full flex flex-row gap-2">
                <h2 class="text-neutral-500">%s</h2>
                <h3 class="text-gray-100 font-bold">%s</h3>
            </div>

            <div class="w-full flex flex-row gap-2">
                <h2 class="text-neutral-500">%s</h2>
                <h3 class="text-gray-100 font-bold">%s</h3>
            </div>
        </div>
    ]]):format(
        locales['pages']['calculator']['jail'],
        jail,
        locales['pages']['calculator']['fine'],
        fine,
        locales['pages']['calculator']['society'],
        society
    ))
end)