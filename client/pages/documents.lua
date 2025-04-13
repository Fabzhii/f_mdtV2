
locales = Config.Locales[Config.Language]

RegisterNUICallback('load_documents', function(data, cb)

    local selfData = getSelfData()


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
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_documents" panel="documents" active>%s</sl-tab>
                <sl-tab slot="nav" hx-swap="innerHTML" hx-target="#content" hx-post="/load_calculator" panel="calculator">%s</sl-tab>
            </sl-tab-group>
            
            <div class="h-full flex flex-row p-4 gap-4">
                <div class="h-full basis-1/5 flex-none">
                    
                    <sl-card class="card-basic w-full">
                        <sl-input
                            name="query"
                            label="%s"
                            help-text="%s"
                            class="text-gray-100 w-full"
                            hx-post="/search_documents"
                            hx-trigger="input changed delay:200ms"
                            hx-target="#search_documents"
                            hx-swap="innerHTML"
                            oninput="this.setAttribute('hx-vals', JSON.stringify({ query: this.value }))"
                        ></sl-input>

                        <sl-button 
                            hx-post="/add_document"
                            hx-trigger="click"
                            hx-swap="innerHTML"
                            hx-target="#search_documents"
                            class="w-full pt-4"
                            variant="primary">%s
                        </sl-button>
                    </sl-card>

                    <div id="search_documents" class="flex flex-col max-h-[53vh] overflow-y-auto mt-4"></div>

                    <script>
                        htmx.ajax('POST', '/search_documents', {
                            target: '#search_documents',
                            swap: 'innerHTML',
                            values: { query: '' }
                        });
                    </script>

                </div>

                <div class="h-full flex-grow">
                    <sl-card class="card-basic w-full">
                        <div id="document_body" class="min-h-[68vh] max-h-[68vh] overflow-y-auto">

                        </div>
                    </sl-card>
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

        locales['pages']['documents']['search_header'],
        locales['pages']['documents']['search_description'],
        locales['pages']['documents']['create_document']
    ))

end)

RegisterNUICallback('add_document', function(data, cb)
    local documents = ""

    local document_types = ""

    for k,v in pairs(Config.Documents) do 
        document_types = document_types .. ([[<sl-option value="%s">%s</sl-option>]]):format(v.id, v.label[Config.Language])
    end 

    local documentsData = getDocuments()
    for k,v in pairs(documentsData) do 
        documents = documents .. documents_document(v.id, v.time, v.officer, v.identifier, v.data, locales['document_tags'])
    end 

    documents = documents .. ([[
        <sl-card class="w-full">
            <div slot="header">
                <h2 class="text-gray-100 font-bold">%s</h2>
            </div>

            <form hx-post="/submit_document" 
                hx-trigger="submit" 
                hx-swap="innerHTML"
                hx-target="#search_documents"
                hx-vals='js:{ type: document.querySelector("#type").value }'>
                
                <sl-select id="type" label="%s" class="text-neutral-500 mt-4">
                    %s
                </sl-select>

                <sl-button type="submit" class="mt-6 w-full" variant="primary">%s</sl-button>
            </form>

        </sl-card>
    ]]):format(
        locales['pages']['documents']['create_document'],
        locales['pages']['documents']['create_document_type'],
        document_types,
        locales['pages']['documents']['create_document_submit']
    )

    
    cb(documents)
end)

RegisterNUICallback('search_documents', function(data, cb)
    local documents = ""
    local documentsData = searchDocument(data.query)

    for k,v in pairs(documentsData) do 
        documents = documents .. documents_document(v.id, v.time, v.officer, v.identifier, v.data, locales['document_tags'])
    end 
    
    cb(documents)
end)

RegisterNUICallback('submit_document', function(data, cb)
    local type = data.type 
    local documentsData = addDocument(type)
    local documents = ""

    for k,v in pairs(documentsData) do 
        documents = documents .. documents_document(v.id, v.time, v.officer, v.identifier, v.data, locales['document_tags'])
    end 
    
    cb(documents)
end)

RegisterNUICallback('show_document', function(data, cb)
    local document = data.document
    local documentsData = getDocuments()

    for o,i in pairs(documentsData) do 
        if document == i.identifier then 
            local id = i.id
            local data = json.decode(i.data)
            local documentType = {}
    
            local header = ""
            local vals = ""
            local options = ""

            for k,v in pairs(Config.Documents) do 
                if v.id == id then 
                    documentType = v
                end 
            end 

            local header = documentType.label[Config.Language]

            for k,v in pairs(documentType.elements) do 
                if v.enabled == true then 
                    
                    if v.type == "header" then 
                        vals = vals .. [[label: document.querySelector("#label").value, ]]

                        options = options .. ([[
                            <sl-input id="label" label="%s" class="text-neutral-500 pt-8 w-72" value="%s"></sl-input>
                        ]]):format(
                            v.locales[Config.Language],
                            (data["label"] or "")
                        )
                    end 

                    if v.type == "tags" then 
                        vals = vals .. [[tags: document.querySelector("#tags").value, ]]

                        local beforeValues = ""
                        local values = ""

                        for k,v in pairs((data[v.type] or {})) do 
                            beforeValues = beforeValues .. ' ' .. v 
                        end 

                        for m,n in pairs(locales.document_tags) do 
                            values = values .. ([[<sl-option value="%s">%s</sl-option>]]):format(m, n)
                        end 

                        options = options .. ([[
                            <sl-select id="tags" label="%s" multiple clearable class="text-neutral-500 pt-8 w-[33vw]" value="%s">
                                %s
                            </sl-select>
                        ]]):format(
                            v.locales[Config.Language],
                            beforeValues,
                            values
                        )
                    end 

                    if v.type == "description" then 
                        vals = vals .. [[description: document.querySelector("#description").value, ]]

                        options = options .. ([[
                            <sl-textarea id="description" label="%s" rows="9" class="text-neutral-500 pt-8 w-full" value="%s"></sl-textarea>
                        ]]):format(
                            v.locales[Config.Language],
                            (data[v.type] or "")
                        )
                    end 

                    if v.type == "citizen" then 
                        vals = vals .. [[citizen: document.querySelector("#citizen").value, ]]

                        local documentOptionsData = getDocumentOptions()

                        local beforeValues = ""
                        local values = ""

                        for k,v in pairs((data[v.type] or {})) do 
                            beforeValues = beforeValues .. ' ' .. labelToValue(v) 
                        end 

                        for m,n in pairs(documentOptionsData.citizen) do 
                            values = values .. ([[<sl-option value="%s">%s</sl-option>]]):format(labelToValue(n), n)
                        end 

                        options = options .. ([[
                            <sl-select id="citizen" label="%s" multiple clearable class="text-neutral-500 pt-8 w-[33vw]" value="%s">
                                %s
                            </sl-select>
                        ]]):format(
                            v.locales[Config.Language],
                            beforeValues,
                            values
                        )
                    end 

                    if v.type == "officer" then 
                        vals = vals .. [[officer: document.querySelector("#officer").value, ]]

                        local documentOptionsData = getDocumentOptions()

                        local beforeValues = ""
                        local values = ""

                        for k,v in pairs((data[v.type] or {})) do 
                            beforeValues = beforeValues .. ' ' .. labelToValue(v) 
                        end 

                        for m,n in pairs(documentOptionsData.officer) do 
                            values = values .. ([[<sl-option value="%s">%s</sl-option>]]):format(labelToValue(n), n)
                        end 

                        options = options .. ([[
                            <sl-select id="officer" label="%s" multiple clearable class="text-neutral-500 pt-8 w-[33vw]" value="%s">
                                %s
                            </sl-select>
                        ]]):format(
                            v.locales[Config.Language],
                            beforeValues,
                            values
                        )
                    end 

                    if v.type == "weapons" then 
                        vals = vals .. [[weapons: document.querySelector("#weapons").value, ]]

                        local documentOptionsData = getDocumentOptions()

                        local beforeValues = ""
                        local values = ""

                        for k,v in pairs((data[v.type] or {})) do 
                            beforeValues = beforeValues .. ' ' .. v
                        end 

                        for m,n in pairs(documentOptionsData.weapons) do 
                            values = values .. ([[<sl-option value="%s">%s</sl-option>]]):format(n.serial, (n.serial .. ' - ' .. n.type))
                        end 

                        options = options .. ([[
                            <sl-select id="weapons" label="%s" multiple clearable class="text-neutral-500 pt-8 w-[33vw]" value="%s">
                                %s
                            </sl-select>
                        ]]):format(
                            v.locales[Config.Language],
                            beforeValues,
                            values
                        )
                    end 



                end 
            end 
            
            cb(([[
                <form 
                    id="save_document"
                    hx-post="/save_document" 
                    hx-trigger="every 1s" 
                    hx-swap="none"
                    hx-vals='js:{%s document: %s }'
                    <h2 class="font-bold text-gray-100">%s</h2>
                    %s
                </form>
            ]]):format(
                vals,
                document,
                header,
                options

            ))
        end 
    end
end)


local oldDocument = {}
local currentDocument = {}
RegisterNUICallback('save_document', function(data, cb)

    local documentData = {
        label = (data.label or ""),
        description = (data.description or ""),
        weapons = (data.weapons or {}),
        tags = (data.tags or {}),
        officer = {},
        citizen = {},
    }

    for k,v in pairs((data.officer or {})) do 
        table.insert((documentData.officer), valueToLabel(v))
    end 

    for k,v in pairs((data.citizen or {})) do 
        table.insert((documentData.citizen), valueToLabel(v))
    end 

    currentDocument = {
        identifier = data.document,
        data = documentData,
    }

    cb([[]])
end)

Citizen.CreateThread(function()
    while true do 

        if not tablesEqual(currentDocument, oldDocument) then 
            oldDocument = currentDocument
            saveDocument(currentDocument.identifier, currentDocument.data)
        end 

        Citizen.Wait(5000)
    end 
end)