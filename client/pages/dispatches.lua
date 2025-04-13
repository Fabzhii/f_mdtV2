
locales = Config.Locales[Config.Language]
local oldMarker = {}
local markerCounter = 4

RegisterNUICallback('load_dispatches', function(data, cb)

    local selfData = getSelfData()
    local dispatchesData = getDispatches()
    local copsData = getCopsData()
    
    local control_center = ""
    local dispatches = ""
    local officer = ""
    local code_list = ""

    oldMarker = {}

    if GlobalState.dispatcher == nil then 
        control_center = ([[
                <div class="call_body w-full flex flex-col gap-2">
                    <h3 class="text-neutral-500">%s</h3>
                    <sl-button 
                        variant="primary" 
                        class="w-full" 
                        hx-post="/set_dispatcher" 
                        hx-target="closest .call_body"
                        hx-swap="outerHTML"
                        hx-swap="none">%s
                    </sl-button>
                </div>
        ]]):format(
            locales['pages']['dispatches']['unoccupied'],
            locales['pages']['dispatches']['occupie']
        )
    else
        if GlobalState.dispatcher == GetPlayerServerId(PlayerId()) then 
            control_center = [[
                <div 
                    id="current_calls"
                    hx-get="/get_current_calls"
                    hx-trigger="every 1s"
                    hx-swap="innerHTML">
                </div>  
            ]]
        else 
            control_center = ([[
                <div class="w-full flex flex-col gap-2">
                    <h3 class="text-neutral-500">%s</h3>
                </div>
            ]]):format(
                (locales['pages']['dispatches']['occupied_from']):format(getCopData(GlobalState.dispatcher).name)
            )
        end 
    end 


    for k,v in pairs(dispatchesData) do 
        local position = json.decode(v.position)
        dispatches = dispatches .. dispatches_dispatches(
            v.identifier,
            locales['code'][v.code], v.code,
            v.reason,
            v.position,
            locales['pages']['dispatches']['dispatch_time'], v.time,
            locales['pages']['dispatches']['dispatch_position'], 
            GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, 70.0, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())),
            locales['pages']['dispatches']['dispatch_infos'], v.infos,
            v.officer,
            getCopsData(),
            locales['pages']['dispatches']['dispatch_add_officer'],
            locales['pages']['dispatches']['dispatch_edit_infos_header'],
            locales['pages']['dispatches']['dispatch_edit_infos_description'],
            locales['pages']['dispatches']['dispatch_edit_infos_button'],

            locales['pages']['dispatches']['dispatch_edit_code_header'],
            locales['pages']['dispatches']['dispatch_edit_code_description'],
            locales['pages']['dispatches']['dispatch_edit_code_button'],
            locales['pages']['dispatches']['dispatch_edit_dispatch_delete'],
            locales['code']
        )
    end 

    for k,v in pairs(copsData) do 
        officer = officer .. dispatches_officer(
            v.name, 
            locales['status'][v.status], v.status,
            locales['callname'][v.callname], locales['pages']['dashboard']['div_1_callname'], (v.callname .. ' - ' .. v.callnumber),
            locales['vehicle'][v.vehicle], locales['pages']['dashboard']['div_1_vehicle'], v.vehicle,
            locales['position'][v.position], locales['pages']['dashboard']['div_1_position'], v.position
        )
    end 

    for k,v in pairs(locales['code']) do 
        if k ~= "n/A" then 
            code_list = code_list .. ([[<sl-option value="%s">%s</sl-option>]]):format(k, k)
        end 
    end 

    cb(([=[
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
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_dispatches" panel="dispatches" active>%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_lists" panel="lists">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_documents" panel="documents">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_calculator" panel="calculator">%s</sl-tab>
            </sl-tab-group>
            
            <div class="m-4 flex flex-row gap-4">
                <div class="flex flex-col w-full max-h-[70vh] overflow-y-hidden">

                    <sl-card class="card-basic flex-none">
                        <sl-details summary="%s" class="custom-icons w-full text-gray-100">
                            <sl-icon name="plus-square" slot="expand-icon"></sl-icon>
                            <sl-icon name="dash-square" slot="collapse-icon"></sl-icon>
                            %s
                        </sl-details>

                        <sl-details summary="%s" class="custom-icons w-full text-gray-100 pt-4">
                            <sl-icon name="plus-square" slot="expand-icon"></sl-icon>
                            <sl-icon name="dash-square" slot="collapse-icon"></sl-icon>
                            
                            <sl-card class="w-full create_dispatch">
                                <form hx-post="/dispatch_create_dispatch" 
                                    hx-trigger="submit" 
                                    hx-swap="outerHTML"
                                    hx-target="closest .create_dispatch"
                                    hx-vals='js:{reason: document.querySelector("#reason").value, code: document.querySelector("#code").value, info: document.querySelector("#info").value}'>

                                    <sl-input id="reason" class="text-neutral-500" label="%s"></sl-input>

                                    <sl-select id="code" label="%s" class="text-neutral-500 mt-4">
                                        %s
                                    </sl-select>
                                    
                                    <sl-textarea id="info" class="text-neutral-500 mt-4" label="%s" rows="2"></sl-textarea>

                                    <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
                                </form>

                            </sl-card>

                        </sl-details>
                    </sl-card>

                    <div class="flex flex-row gap-2 w-full pt-4 flex-1">
                        <div id="dispatches_list" class="flex flex-col w-full max-h-[52vh] overflow-y-auto">
                            %s
                        </div>
                        <div id="officer_list" class="flex flex-col w-full max-h-[52vh] overflow-y-auto">
                            %s
                        </div>
                    </div>
                </div>

                <div class="w-full">
                    <sl-card class="card-basic w-full">
                        <div id="map" class="w-full h-[67vh] rounded-xl shadow-lg overflow-hidden relative scroll-smooth"></div>
                    </sl-card>

                    <script>
                        
                        var imageWidth = 1000;
                        var imageHeight = 1000;
                        var bounds = [[0, 0], [imageHeight, imageWidth]];

                        var map = L.map('map', {
                            crs: L.CRS.Simple,
                            minZoom: -0.3,
                            maxZoom: 4,
                            zoomSnap: 0.1,
                            zoomDelta: 0.1,
                            maxBounds: bounds,
                            maxBoundsViscosity: 1.0,
                            zoomControl: false
                        });

                        var image = L.imageOverlay('./img/map.png', bounds).addTo(map);
                        map.fitBounds(bounds);
                        map.attributionControl.remove();

                        var leafletMarkers = [];

                        function updateMarkers(data) {
                            
                            if (!data) return;

                            leafletMarkers.forEach(marker => map.removeLayer(marker));
                            leafletMarkers = [];

                            data.forEach((m, i) => {
                                var customIcon = L.divIcon({
                                    className: '',
                                    html: m.iconHtml,
                                    iconSize: [24, 24],
                                    iconAnchor: [12, 24],
                                });

                                const markerOptions = {
                                    icon: customIcon,
                                    draggable: m.draggable === true // Nur draggable, wenn explizit true
                                };

                                var marker = L.marker([m.y, m.x], markerOptions).addTo(map);

                                marker.bindPopup(`<div id="marker-${i}" class="sl-theme-dark">${m.popupContent}</div>`);
                                leafletMarkers.push(marker);

                                // Wenn Marker draggable ist, auf dragend reagieren
                                if (m.draggable === true) {
                                    marker.on('dragend', function (e) {
                                        const newPos = e.target.getLatLng();
                                        console.log(`Marker ${m.id || i} bewegt nach:`, newPos.lat, newPos.lng);

                                        fetch(`https://${GetParentResourceName()}/marker_moved`, {
                                            method: 'POST',
                                            headers: {
                                                'Content-Type': 'application/json; charset=UTF-8'
                                            },
                                            body: JSON.stringify({
                                                id: m.id, 
                                                x: newPos.lng,
                                                y: newPos.lat
                                            })
                                        });
                                    });
                                }
                            });

                        }

                        function fetchMarkers() {
                            fetch(`https://${GetParentResourceName()}/dispatch_markers`, {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json; charset=UTF-8'
                                },
                                body: JSON.stringify({})
                            })
                            .then(res => res.json())
                            .then(data => updateMarkers(data))
                            .catch(err => console.error('Error:', err));
                        }

                        fetchMarkers();
                        if (window.mapPollingInterval) clearInterval(window.mapPollingInterval);
                        if (document.getElementById('map')) {
                            window.mapPollingInterval = setInterval(() => {
                                if (document.getElementById('map')) {
                                    fetchMarkers();
                                } else {
                                    clearInterval(window.mapPollingInterval);
                                    window.mapPollingInterval = null;
                                }
                            }, 2000);
                        }


                    </script>

                </div>
            </div>

        </div>
    ]=]):format(

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

        locales['pages']['dispatches']['control_center'],
        control_center,

        locales['pages']['dispatches']['dispatch_create_dispatch_header'],
        locales['pages']['dispatches']['dispatch_create_dispatch_reason'],
        locales['pages']['dispatches']['dispatch_create_dispatch_code'],
        code_list,
        locales['pages']['dispatches']['dispatch_create_dispatch_infos'],
        locales['pages']['dispatches']['dispatch_create_dispatch_button'],

        dispatches,
        officer
    ))
end)

RegisterNUICallback('dispatch_create_dispatch', function(data, cb)
    local reason = data.reason
    local code = data.code
    local infos = data.info
    local code_list = ""

    local dispatchesData = createDispatch(reason, code, infos)

    for k,v in pairs(locales['code']) do 
        if k ~= "n/A" then 
            code_list = code_list .. ([[<sl-option value="%s">%s</sl-option>]]):format(k, k)
        end 
    end 

    cb(([[
        <sl-card class="w-full create_dispatch">
            <form hx-post="/dispatch_create_dispatch" 
                hx-trigger="submit" 
                hx-swap="outerHTML"
                hx-target="closest .create_dispatch"
                hx-vals='js:{reason: document.querySelector("#reason").value, code: document.querySelector("#code").value, info: document.querySelector("#info").value}'>

                <sl-input id="reason" class="text-neutral-500" label="%s"></sl-input>

                <sl-select id="code" label="%s" class="text-neutral-500 mt-4">
                    %s
                </sl-select>
                
                <sl-textarea id="info" class="text-neutral-500 mt-4" label="%s" rows="2"></sl-textarea>

                <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
            </form>

        </sl-card>

        <div
            hx-get="/refresh_dispatches"  
            hx-trigger="load"
            hx-target="#dispatches_list"
            hx-swap="innerHTML">
        </div>


    ]]):format(
        locales['pages']['dispatches']['dispatch_create_dispatch_reason'],
        locales['pages']['dispatches']['dispatch_create_dispatch_code'],
        code_list,
        locales['pages']['dispatches']['dispatch_create_dispatch_infos'],
        locales['pages']['dispatches']['dispatch_create_dispatch_button']
    ))
end)


RegisterNUICallback('refresh_dispatches', function(data, cb)
    
    local dispatches = ""
    local dispatchesData = getDispatches()

    for k,v in pairs(dispatchesData) do 
        local position = json.decode(v.position)
        dispatches = dispatches .. dispatches_dispatches(
            v.identifier,
            locales['code'][v.code], v.code,
            v.reason,
            v.position,
            locales['pages']['dispatches']['dispatch_time'], v.time,
            locales['pages']['dispatches']['dispatch_position'], 
            GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, 70.0, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())),
            locales['pages']['dispatches']['dispatch_infos'], v.infos,
            v.officer,
            getCopsData(),
            locales['pages']['dispatches']['dispatch_add_officer'],
            locales['pages']['dispatches']['dispatch_edit_infos_header'],
            locales['pages']['dispatches']['dispatch_edit_infos_description'],
            locales['pages']['dispatches']['dispatch_edit_infos_button'],

            locales['pages']['dispatches']['dispatch_edit_code_header'],
            locales['pages']['dispatches']['dispatch_edit_code_description'],
            locales['pages']['dispatches']['dispatch_edit_code_button'],
            locales['pages']['dispatches']['dispatch_edit_dispatch_delete'],
            locales['code']
        )
    end 

    cb(dispatches)

end)

RegisterNUICallback('set_dispatcher', function(data, cb)
    exports[GetCurrentResourceName()]:registerDispatcher(true)
    cb([[
        <div 
            id="current_calls"
            hx-get="/get_current_calls"
            hx-trigger="every 1s"
            hx-swap="innerHTML">
        </div>  
    ]])
end)

local callTime = 0
RegisterNUICallback('get_current_calls', function(data, cb)
    
    local activeCall = exports[GetCurrentResourceName()]:isCallActive()

    if activeCall == 0 then 
        callTime = 0
        cb(([[
            <div>
                <h3 class="text-neutral-500">%s</h3>
            </div>  
        ]]):format(
            locales['pages']['dispatches']['no_call']
        ))
    elseif activeCall == 1 then
        callTime = 0
        cb(([[
            <div class="flex flex-col gap-2">
                <h3 class="text-neutral-500">%s</h3>
                <sl-button 
                    variant="primary" 
                    class="w-full" 
                    hx-post="/accept_call">%s
                </sl-button>
            </div>  
        ]]):format(
            locales['pages']['dispatches']['receive_call'],
            locales['pages']['dispatches']['accept_call']
        ))
    elseif activeCall == 2 then 
        callTime = callTime + 1

        cb(([[
            <div class="flex flex-col gap-1">
                <svg viewBox="0 0 160 60" height="60" xmlns="http://www.w3.org/2000/svg" fill="#00ff88" class="w-full">
                    <script>
                        var svgNS = "http://www.w3.org/2000/svg";
                        var svg = document.querySelector("svg");

                        for (let i = 0; i < 32; i++) {
                        var rect = document.createElementNS(svgNS, "rect");
                        rect.setAttribute("x", i * 5);
                        rect.setAttribute("y", "20"); 
                        rect.setAttribute("width", "2");
                        rect.setAttribute("height", "20");
                        rect.setAttribute("rx", "1");
                        rect.setAttribute("class", "bar");
                        rect.style.animationDelay = `${(Math.random() * 0.8).toFixed(2)}s`;
                        rect.style.animationDuration = `${(0.5 + Math.random() * 0.6).toFixed(2)}s`;
                        svg.appendChild(rect);
                        }
                    </script>
                </svg>
                <h3 class="text-neutral-500">%s %s</h3>

                <sl-button 
                    variant="danger" 
                    class="w-full pt-4" 
                    hx-post="/end_call">%s
                </sl-button>


            </div>  
        ]]):format(
            locales['pages']['dispatches']['call_time'],
            secondsToTime(callTime),
            locales['pages']['dispatches']['end_call']
        ))
    end 
end)

RegisterNUICallback('accept_call', function(data, cb)
    exports[GetCurrentResourceName()]:dispatcherAcceptCall()
    cb([[]])
end)

RegisterNUICallback('end_call', function(data, cb)
    exports[GetCurrentResourceName()]:dispatcherEndCall()
    cb([[]])
end)

RegisterNUICallback('dispatch_markers', function(data, cb)

    local dispatchesData = getDispatches()
    local officerData = getCopsData()

    markerCounter = markerCounter + 1

    if (not tablesEqual(trackingData, oldMarker)) or markerCounter == 5 then 
        markerCounter = 0
        local marker = {}

        for k,v in pairs(officerData) do 
            if v.canBeTracked == true then 
                table.insert(marker, {
                    draggable = false,
                    x = toMapCoords(v.coords).x,
                    y = toMapCoords(v.coords).y,
                    iconHtml = '<sl-icon name="car-front" class="text-blue-500" style="font-size: 1.5rem;"></sl-icon>',
                    popupContent = ([[
                        <sl-menu style="max-width: 200px;">
                            <sl-menu-item value="undo">%s</sl-menu-item>
                            <sl-menu-item value="redo">%s</sl-menu-item>
                            <sl-divider class="h-[1px] bg-neutral-500"></sl-divider>
                            
                            <sl-menu-item onclick="htmx.ajax('POST', '/create_marker', { values: { x: %s, y: %s }, swap: 'none' })">
                                <sl-icon slot="prefix" name="signpost-split"></sl-icon>
                                %s
                            </sl-menu-item>
                        </sl-menu>

                    ]]):format(
                        v.name,
                        v.status,
                        v.coords.x,
                        v.coords.y,
                        locales['pages']['tracking']['create_marker']
                    ),
                }) 
            end 
        end 

        for k,v in pairs(dispatchesData) do 
            local position = json.decode(v.position)
            local officer_list = ""

            for k,v in pairs(v.officer) do 
                officer_list = officer_list .. ([[<sl-badge variant="primary">%s</sl-badge>]]):format(v)
            end 

            table.insert(marker, {
                draggable = true,
                id = v.identifier,
                x = toMapCoords(position).x,
                y = toMapCoords(position).y,
                iconHtml = '<sl-icon name="broadcast-pin" class="text-neutral-500" style="font-size: 1.5rem;"></sl-icon>',
                popupContent = ([[
                    <sl-menu style="max-width: 200px;">
                        <sl-menu-item value="undo">%s</sl-menu-item>
                        <sl-menu-item value="redo">%s</sl-menu-item>
                        <sl-divider class="h-[1px] bg-neutral-500"></sl-divider>

                        <sl-menu-item value="undo">%s %s</sl-menu-item>
                        <sl-menu-item value="redo">
                            <div class="flex flex-col gap-2">
                                %s
                            </div>
                        </sl-menu-item>
                        <sl-divider class="h-[1px] bg-neutral-500"></sl-divider>
                        
                        <sl-menu-item onclick="htmx.ajax('POST', '/create_marker', { values: { x: %s, y: %s }, swap: 'none' })">
                            <sl-icon slot="prefix" name="signpost-split"></sl-icon>
                            %s
                        </sl-menu-item>

                    </sl-menu>

                ]]):format(
                    v.reason,
                    v.time,
                    locales['pages']['dashboard']['div_4_infos'], v.infos,
                    officer_list,
                    position.x,
                    position.y,
                    locales['pages']['tracking']['create_marker']
                ),
            })
        end 

        cb(marker)
    else 
        cb(nil)
    end 

    oldMarker = trackingData
end)

RegisterNUICallback('marker_moved', function(data, cb)
    local identifier = data.id
    local mapCoords = {x = data.x, y = data.y}
    local realCoords = {x = toRealCoords(mapCoords).x, y = toRealCoords(mapCoords).y}

    local dispatchesData = DispatchEditPos(identifier, realCoords)
    
    cb([[]])
end)


RegisterNUICallback('dispatch_remove_officer', function(data, cb)
    local officer = data.officer
    local identifier = data.identifier

    local dispatchesData = dispatchRemoveOfficer(identifier, officer)
    
    cb([[]])
end)

RegisterNUICallback('dispatch_add_officer', function(data, cb)
    local officer = data.officer
    local identifier = data.identifier

    local copsData = getCopsData()
    local dispatchesData = dispatchAddOfficer(identifier, officer)
    local dispatch = {}

    for k,v in pairs(dispatchesData) do 
        if tonumber(v.identifier) == tonumber(identifier) then 
            dispatch = v
        end 
    end 

    local officer_list = ""
    local officer_add = ""

    for k,v in pairs(dispatch.officer) do 
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
                hx-swap="innerHTML"
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
        locales['pages']['dispatches']['dispatch_add_officer'],
        officer_add
    )

    cb(([[
        <div class="officerlist flex flex-row items-center">
            %s
        </div> 
    ]]):format(officer_list))
end)



RegisterNUICallback('dispatch_edit_info', function(data, cb)
    
    local identifier = data.identifier
    local info = data.info

    local dispatchesData = dispatchEditInfo(identifier, info)
    
    cb(([[
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
    ]]):format(
        locales['pages']['dispatches']['dispatch_infos'], info,
        locales['pages']['dispatches']['dispatch_edit_infos_header'],
        identifier,
        locales['pages']['dispatches']['dispatch_edit_infos_description'],
        info,
        locales['pages']['dispatches']['dispatch_edit_infos_button']
    ))
end)

RegisterNUICallback('dispatch_edit_code', function(data, cb)

    local identifier = data.identifier
    local code = data.code

    if code == "delete" then 
        local dispatchesData = deleteDispatch(identifier)
        cb([[
            <div 
                hx-get="/delete_dispatch" 
                hx-trigger="load" 
                hx-swap="outerHTML"
                hx-target="closest .dispatch">
            </div>
        ]])
    else 
        local dispatchesData = dispatchEditCode(identifier, code)
        local code_list = ""

        for k,v in pairs(locales['code']) do 
            if k ~= "n/A" then 
                code_list = code_list .. ([[<sl-option value="%s">%s</sl-option>]]):format(k, k)
            end 
        end 

        cb(([[
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
        ]]):format(
            locales['code'][code], code,
            locales['pages']['dispatches']['dispatch_edit_code_header'],
            identifier,
            identifier,
            identifier,
            locales['pages']['dispatches']['dispatch_edit_code_description'],
            code,
            code_list,
            locales['pages']['dispatches']['dispatch_edit_dispatch_delete'],
            locales['pages']['dispatches']['dispatch_edit_code_button']
        ))
    end 
end)

RegisterNUICallback('delete_dispatch', function(data, cb)
    cb([[]])
end)