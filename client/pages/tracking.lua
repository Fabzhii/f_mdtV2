
locales = Config.Locales[Config.Language]
local oldMarker = {}

RegisterNUICallback('load_tracking', function(data, cb)

    local selfData      = getSelfData()
    oldMarker = {}

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
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_tracking" panel="tracking" active>%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_dispatches" panel="dispatches">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_lists" panel="lists">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_documents" panel="documents">%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_calculator" panel="calculator">%s</sl-tab>
            </sl-tab-group>
            
            <div class="m-4 flex flex-row gap-4">
                <div class="flex flex-col w-full">
                    <sl-card class="card-basic w-full">
                        <sl-input
                            name="query"
                            label="%s"
                            help-text="%s"
                            class="text-gray-100 w-full"
                            hx-post="/track"
                            hx-trigger="input changed delay:200ms"
                            hx-target="#search_results"
                            hx-swap="innerHTML"
                            oninput="this.setAttribute('hx-vals', JSON.stringify({ query: this.value }))"
                        ></sl-input>
                    </sl-card>

                    <div id="search_results" class="flex flex-col max-h-[57vh] overflow-y-auto mt-4 gap-2">

                    </div>

                    <script>
                        htmx.ajax('POST', '/track', {
                            target: '#search_results',
                            swap: 'innerHTML',
                            values: { query: '' }
                        });
                    </script>

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

                            var marker = L.marker([m.y, m.x], {
                                icon: customIcon,
                                draggable: false
                            }).addTo(map);

                            marker.bindPopup(`<div id="marker-${i}" class="sl-theme-dark">${m.popupContent}</div>`);
                            leafletMarkers.push(marker);
                            });
                        }

                        function fetchMarkers() {
                            fetch(`https://${GetParentResourceName()}/track_markers`, {
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

        locales['pages']['tracking']['search_header'],
        locales['pages']['tracking']['search_description']

    ))
end)

RegisterNUICallback('track_markers', function(data, cb)
    local trackingData = getTracker()

    if not tablesEqual(trackingData, oldMarker) then 
        local marker = {}

        for k,v in pairs(trackingData) do 
            table.insert(marker, {
                x = toMapCoords(v.coords).x,
                y = toMapCoords(v.coords).y,
                iconHtml = '<sl-icon name="broadcast-pin" class="text-neutral-500" style="font-size: 1.5rem;"></sl-icon>',
                popupContent = ([[
                    <sl-menu style="max-width: 200px;">
                        <sl-menu-item value="undo">%s</sl-menu-item>
                        <sl-menu-item value="redo">%s</sl-menu-item>
                        <sl-divider class="h-[1px] bg-neutral-500"></sl-divider>
                        
                        <sl-menu-item onclick="htmx.ajax('POST', '/create_marker', { values: { x: %s, y: %s }, swap: 'none' })">
                            <sl-icon slot="prefix" name="signpost-split"></sl-icon>
                            %s
                        </sl-menu-item>

                        <sl-menu-item onclick="htmx.ajax('POST', '/delete_tracking', { values: { identifier: %s }, swap: 'none' })">
                            <sl-icon slot="prefix" name="trash"></sl-icon>
                            %s
                        </sl-menu-item>

                    </sl-menu>

                ]]):format(
                    v.label,
                    v.time,
                    v.coords.x,
                    v.coords.y,
                    locales['pages']['tracking']['create_marker'],
                    v.identifier,
                    locales['pages']['tracking']['delete_tracker']
                ),
            })
        end 

        cb(marker)
    else 
        cb(nil)
    end 

    oldMarker = trackingData
end)

RegisterNUICallback('delete_tracking', function(data, cb)
    local identifier = data.identifier
    local trackingData = deleteTracker(identifier)
    cb([[]])
end)

RegisterNUICallback('track', function(data, cb)
    local results = track(data.query)
    local search = ""
    
    for k,v in pairs(results) do 
        if v.type == "person" then 
            search = search .. track_person(
                v.phone_number,
                v.identifier,
                locales['pages']['tracking']['name'],
                v.name,
                string.gsub((v.identifier), ":", "")
            ) 
        end 

        if v.type == "vehicle" then 
            search = search .. track_vehicle(
                v.plate,
                locales['pages']['tracking']['model'], (GetDisplayNameFromVehicleModel(v.type) == "CARNOTFOUND" and "n/A" or GetDisplayNameFromVehicleModel(v.type)),
                locales['pages']['tracking']['color'], (Config.VehicleColors[v.color] or 'n/A'),
                string.gsub((v.plate), "%s+", "")
            ) 
        end 
    end 
    
    cb(search)
end)

RegisterNUICallback('track_vehicle', function(data, cb)
    local plate = data.plate

    if Config.Tracking['vehicle']['enabled'] == false then
        cb(locales['pages']['tracking']['not_enabled'])
        return
    end 

    local success = trackVehicle(plate)
    if success == true then 
        cb(locales['pages']['tracking']['vehicle_tracking_success'])
    else 
        cb(locales['pages']['tracking']['vehicle_tracking_error'])
    end 
end)

RegisterNUICallback('track_person', function(data, cb)
    local identifier = data.identifier

    if Config.Tracking['citizen']['enabled'] == false then
        cb(locales['pages']['tracking']['not_enabled'])
        return
    end 

    if (GlobalState.timer)['citizen'] > 0 then 
        cb(locales['pages']['tracking']['citizen_tracking_error'])
        return
    end 

    local success = trackPlayer(identifier)
    if success == true then 
        cb(locales['pages']['tracking']['citizen_tracking_success'])
    else 
        cb(locales['pages']['tracking']['citizen_tracking_error'])
    end 
end)