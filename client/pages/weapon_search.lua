
locales = Config.Locales[Config.Language]

RegisterNUICallback('load_weapon_search', function(data, cb)

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
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_weapon_search" panel="weapon_search" active>%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_tracking" panel="tracking">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_dispatches" panel="dispatches">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_lists" panel="lists">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_documents" panel="documents">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_calculator" panel="calculator">%s</sl-tab>
            </sl-tab-group>
            
            <div class="m-4" id="selected_user">
                <sl-card class="card-basic w-full">
                    <sl-input
                        name="query"
                        label="%s"
                        help-text="%s"
                        class="text-gray-100 w-full"
                        hx-post="/search_weapon"
                        hx-trigger="input changed delay:200ms"
                        hx-target="#search_results"
                        hx-swap="innerHTML"
                        oninput="this.setAttribute('hx-vals', JSON.stringify({ query: this.value }))"
                    ></sl-input>
                </sl-card>

                <div id="search_results" class="flex flex-col max-h-[58vh] overflow-y-auto mt-4"></div>

                <script>
                    htmx.ajax('POST', '/search_weapon', {
                        target: '#search_results',
                        swap: 'innerHTML',
                        values: { query: '' }
                    });
                </script>

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

        locales['pages']['weapon_search']['search_header'],
        locales['pages']['weapon_search']['search_description']
    ))
end)

RegisterNUICallback('search_weapon', function(data, cb)
    local results = searchWeapon(data.query)
    local search_result = ""

    for k,v in pairs(results) do 
        search_result = search_result .. weapon_search_weapon(
            v.serial,
            (v.wanted == 1 and true or false),
            locales['pages']['weapon_search']['wanted_options'][v.wanted == 1 and true or false],
            locales['pages']['weapon_search']['owner'], v.owner,
            locales['pages']['weapon_search']['type'], v.type
        )
    end 
    
    cb(search_result)
end)

RegisterNUICallback('change_weapon_wanted', function(data, cb)
    local serial = data.serial
    local wanted = not data.wanted

    local results = changeWeaponWanted(serial, wanted)
    
    cb(([[
        <sl-badge
            variant="%s"
            class="cursor-pointer"
            hx-post="/change_vehicle_wanted"
            hx-vals='{"plate": "%s", "wanted": %s}'
            hx-trigger="click"
            hx-swap="outerHTML">%s
        </sl-badge>
    ]]):format(
        locales['pages']['vehicle_search']['wanted_options'][wanted][1],
        serial,
        wanted,
        locales['pages']['vehicle_search']['wanted_options'][wanted][2]
    ))
end)