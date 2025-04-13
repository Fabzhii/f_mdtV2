
Config = {}

Config.ImgWebhook = "" -- discord Webhook

Config.ShowVehicleRegististration = true

Config.Dispatches = {
    type = "roadphone", -- roadphone / lbphone (lbphone support will come soon)
    number = 911, -- disable this number as a job number // if you use roadphone enable the number as an eventnumber
    maxTimeToAnswer = 20, -- how long the dispatcher has time to answer the call
}

Config.Tracking = {
    ['vehicle'] = {
        ['delay'] = 15,
        ['enabled'] = true,
    },
    ['citizen'] = {
        ['delay'] = 15,
        ['enabled'] = true,
    },
    ['settings'] = { -- same settings apply for officers in order to get displayed on the dispatches page 
        requirePhone = true, -- if player needs to have a phone in the inv in order to be trackable // flightmode is checked too
        phoneItem = "phone",
    },
}

Config.MapAlignment = {
    defaultX = 458,
    defaultY = 344,
    xMultiply = 0.099,
    yMultiply = 0.0838,
}

Config.Commands = {
    jobs = {'police', 'sheriff'},
    open = {
        command = {
            ['DE'] = 'mdt',
            ['EN'] = 'mdt',
        },
        description = {
            ['DE'] = 'Öffne das MDT',
            ['EN'] = 'Open the MDT',
        },
    },
}

Config.Documents = {
    {
        id = "deployment",
        label = {
            ['DE'] = 'Einsatz Bericht',
            ['EN'] = 'Deployment Report',
        },
        elements = {
            {
                type = "header",
                enabled = true,
                locales = {
                    ['DE'] = 'Titel',
                    ['EN'] = 'Title',
                },
            },
            {
                type = "tags",
                enabled = true,
                locales = {
                    ['DE'] = 'Tags Hinzufügen',
                    ['EN'] = 'Add Tags',
                },
            },
            {
                type = "description",
                enabled = true,
                locales = {
                    ['DE'] = 'Einsatzbeschreibung',
                    ['EN'] = 'Mission Description',
                },
            },
            {
                type = "citizen",
                enabled = true,
                locales = {
                    ['DE'] = 'Personen Hinzufügen',
                    ['EN'] = 'Add Citizen',
                },
            },
            {
                type = "officer",
                enabled = true,
                locales = {
                    ['DE'] = 'Beamte Hinzufügen',
                    ['EN'] = 'Add Officer',
                },
            },
            {
                type = "weapons",
                enabled = true,
                locales = {
                    ['DE'] = 'Waffen Hinzufügen',
                    ['EN'] = 'Add Weapons',
                },
            },
        }
    },
    {
        id = "shots",
        label = {
            ['DE'] = 'Schuss Bericht',
            ['EN'] = 'Shot Report',
        },
        elements = {
            {
                type = "header",
                enabled = true,
                locales = {
                    ['DE'] = 'Titel',
                    ['EN'] = 'Title',
                },
            },
            {
                type = "tags",
                enabled = true,
                locales = {
                    ['DE'] = 'Tags Hinzufügen',
                    ['EN'] = 'Add Tags',
                },
            },
            {
                type = "description",
                enabled = true,
                locales = {
                    ['DE'] = 'Einsatzbeschreibung',
                    ['EN'] = 'Mission Description',
                },
            },
            {
                type = "citizen",
                enabled = true,
                locales = {
                    ['DE'] = 'Personen Hinzufügen',
                    ['EN'] = 'Add Citizen',
                },
            },
            {
                type = "officer",
                enabled = true,
                locales = {
                    ['DE'] = 'Beamte Hinzufügen',
                    ['EN'] = 'Add Officer',
                },
            },
            {
                type = "weapons",
                enabled = true,
                locales = {
                    ['DE'] = 'Waffen Hinzufügen',
                    ['EN'] = 'Add Weapons',
                },
            },
        }
    },
}

Config.Trainings = {
    {
        id = 'ga1',
        locales = {
            ['DE'] = {
                label = "Grundausbildung 1",
                description = "Theoretischer Teil der Grundausbildung.",
            },
            ['EN'] = {
                label = "Grundausbildung 1",
                description = "Theoretischer Teil der Grundausbildung.",
            },
        },
        mingrade = 0,
    },
    {
        id = 'ga2',
        locales = {
            ['DE'] = {
                label = "Grundausbildung 2",
                description = "Praktischer Teil der Grundausbildung.",
            },
            ['EN'] = {
                label = "Grundausbildung 2",
                description = "Praktischer Teil der Grundausbildung.",
            },
        },
        mingrade = 0,
    },
    {
        id = 'ewf',
        locales = {
            ['DE'] = {
                label = "Erweiterte Funk Ausbildung",
                description = "Zum erlangen von erweiterten Kenntnisse des Funkens. Notwendig für weitere Devisions.",
            },
            ['EN'] = {
                label = "Erweiterte Funk Ausbildung",
                description = "Zum erlangen von erweiterten Kenntnisse des Funkens. Notwendig für weitere Devisions.",
            },
        },
        mingrade = 0,
    },
    {
        id = 'ewa',
        locales = {
            ['DE'] = {
                label = "Erweiterte Waffenausbildung",
                description = "Ermöglicht die Verwenung einer Langwaffe bei Freigabe eines Supervisors.",
            },
            ['EN'] = {
                label = "Erweiterte Waffenausbildung",
                description = "Ermöglicht die Verwenung einer Langwaffe bei Freigabe eines Supervisors.",
            },
        },
        mingrade = 2,
    },
    {
        id = 'efa',
        locales = {
            ['DE'] = {
                label = "Erweiterte Fahrausbildung",
                description = "Erweiterte Taktiken im Zusammenhang mit Fahrzeugen.",
            },
            ['EN'] = {
                label = "Erweiterte Fahrausbildung",
                description = "Erweiterte Taktiken im Zusammenhang mit Fahrzeugen.",
            },
        },
        mingrade = 1,
    },
    {
        id = 'mta',
        locales = {
            ['DE'] = {
                label = "Motorrad Ausbildung",
                description = "Ermöglicht das Fahren eines Polizei Motorrads in der Traffic Unit.",
            },
            ['EN'] = {
                label = "Motorrad Ausbildung",
                description = "Ermöglicht das Fahren eines Polizei Motorrads in der Traffic Unit.",
            },
        },
        mingrade = 2,
    },
    {
        id = 'boot',
        locales = {
            ['DE'] = {
                label = "Boot Ausbildung",
                description = "Ermöglicht das Bedienen eines Polizei Bootes.",
            },
            ['EN'] = {
                label = "Boot Ausbildung",
                description = "Ermöglicht das Bedienen eines Polizei Bootes.",
            },
        },
        mingrade = 2,
    },
    {
        id = 'la',
        locales = {
            ['DE'] = {
                label = "Luftausbildung",
                description = "Ermöglicht die Verwendung eines Helicopters als Copiloten. Erlernt wird die Wartung eines Helikopters, die Verwendung von Kamerasystemen und das Funken in der Luft.",
            },
            ['EN'] = {
                label = "Luftausbildung",
                description = "Ermöglicht die Verwendung eines Helicopters als Copiloten. Erlernt wird die Wartung eines Helikopters, die Verwendung von Kamerasystemen und das Funken in der Luft.",
            },
        },
        mingrade = 3,
    },
    {
        id = 'ela',
        locales = {
            ['DE'] = {
                label = "Erweiterte Luftausbildung",
                description = "Ermöglicht die Verwendung eines Helicopters als Piloten.",
            },
            ['EN'] = {
                label = "Erweiterte Luftausbildung",
                description = "Ermöglicht die Verwendung eines Helicopters als Piloten.",
            },
        },
        mingrade = 4,
    },
}

Config.PhoneNumberColomn = 'phone_number'

Config.Lists = {
    status = {
        {status = '10-02', description = 'Funkspruch empfangen'},
        {status = '10-03', description = 'Bestätige'},
        {status = '10-04', description = 'Verstanden'},
        {status = '10-06', description = 'Beschäftigt'},
        {status = '10-09', description = 'Wiederholen'},
        {status = '10-97', description = 'Nicht Einsatzbereit'},
        {status = '10-08', description = 'Einsatzbereit'},
        {status = '10-10', description = 'Benötige Verstärkung'},
        {status = '10-20', description = 'Aktueller Standort'},
        {status = '10-21', description = 'Personenkontrolle'},
        {status = '10-22', description = 'Fahrzeugkontrolle'},
        {status = '10-23', description = 'Einsatzort angekommen'},
        {status = '10-25', description = 'Raub / Diebstahl'},
        {status = '10-30', description = 'Täterbeschreibung'},
        {status = '10-32', description = 'Täter bewaffnet'},
        {status = '10-35', description = 'Personenabfrage'},
        {status = '10-36', description = 'Halterabfrage'},
        {status = '10-40', description = 'Anfahrt zur Verstärkung'},
        {status = '10-50', description = 'Verunfallt'},
        {status = '10-60', description = 'Verfolgungsjagd'},
        {status = '10-65', description = 'Personenverfolgung'},
        {status = '10-90', description = 'Officer in Gefahr'},
        {status = '10-99', description = 'Schusswechsel'},
    },
    code = {
        {status = 'Code-1', description = 'Dienstbereit / Kein Einsatz'},
        {status = 'Code-1-H', description = 'Dienstbereit / Straßenregeln befreit'},
        {status = 'Code-2', description = 'Routine Einsatz'},
        {status = 'Code-3', description = 'Notfall / Blaulicht & Sirene'},
        {status = 'Code-4', description = 'Einsatz unter Kontrolle'},
        {status = 'Code-4-ADAM', description = 'Einsatz unter Kontrolle / Keine weiteren Einsatzmittel benötigt'},
        {status = 'Code-5', description = 'Risiko Stopp (10-22)'},
        {status = 'Code-6', description = 'Fahrzeug verlassen'},
    },
    frequency = {
        {status = '1.0', description = 'Dienstfunk'},
        {status = '1.1', description = 'Private Gespräche (1)'},
        {status = '1.2', description = 'Private Gespräche (2)'},
        {status = '1.3', description = 'Private Gespräche (3)'},
        {status = '1.6', description = 'Ausbildungsfunk (1)'},
        {status = '1.7', description = 'Ausbildungsfunk (2)'},
        {status = '1.8', description = 'Ausbildungsfunk (3)'},
        {status = '3.0', description = 'Geteilter Funk (AMR)'},
        {status = '4.0', description = 'Geteilter Funk (LAFD)'},
    },}

Config.Language = 'DE'
Config.Locales = {
    ['DE'] = {
        ['cant_open_mdt'] = {'Du darfst das MDT nicht öffnen!', 'error'},
        ['new_dispatch'] = {'Dir wurde ein neuer Dispatch zugeteilt!', 'info'},
        ['sidebar'] = {
            ['dashboard'] = 'Dashboard',
            ['control_center'] = 'Leitstelle',
            ['citizen_search'] = 'Einwohnersuche',
            ['vehicle_search'] = 'Fahrzeugsuche',
            ['weapon_search'] = 'Waffensuche',
            ['tracking'] = 'Tracking',
            ['dispatches'] = 'Dispatches',
            ['lists'] = 'Listen',
            ['documents'] = 'Berichte',
            ['calculator'] = 'Rechner',
        },
        ['document_tags'] = {
            ['important'] = "Wichtig",
            ['in_progress'] = "In Bearbeitung",
            ['forever'] = "Fristlos",
        },
        ['units'] = {
            ['patrol'] = "Patrol Unit",
            ['traffic'] = "Traffic Unit",
            ['air'] = "Air Support Unit",
            ['detective'] = "Detective Unit",
            ['swat'] = "S.W.A.T.",
        },
        ['status'] = {
            ['n/A'] = "neutral",
            ['10-06'] = "warning",
            ['10-08'] = "success",
        },
        ['callname'] = {
            ['n/A'] = "neutral",
            ['Lincoln'] = "warning",
            ['Adam'] = "warning",
        },
        ['vehicle'] = {
            ['n/A'] = "neutral",
            ['Straßenwagen [M]'] = "success",
            ['Offraod [M]'] = "success",
        },
        ['position'] = {
            ['n/A'] = "neutral",
            ['Police Department'] = "warning",
            ['Sheriff Department'] = "warning",
        },
        ['code'] = {
            ['n/A'] = "neutral",
            ['Code-3'] = "success",
            ['Code-4'] = "warning",
        },
        ['frequency'] = {
            ['n/A'] = "neutral",
            ['1.1'] = "success",
            ['1.2'] = "warning",
        },
        ['dispatch'] = {
            ['dispatch'] = "Dispatch Absetzen",
            ['call_header'] = "Notruf",
            ['call_text'] = "Die Leitstelle hat einen Notruf erhalten. Öffne das MDT um ihn anzunehmen.",
        },
        ['pages'] = {
            ['dashboard'] = {
                ['div_1_header'] = "Persönliche Informationen",
                ['div_1_subheader'] = "Hier siehst du deinen aktuellen Status",
                ['div_1_name'] = "Name:",
                ['div_1_callname'] = "Callname:",
                ['div_1_status'] = "Status:",
                ['div_1_position'] = "Position:",
                ['div_1_tel'] = "Nummer:",
                ['div_1_vehicle'] = "Fahrzeug:",

                ['div_2_header'] = "Aktive Beamte",
                ['div_2_subheader'] = "Hier siehtst du Beamte im Dienst",

                ['div_3_header'] = "Fahndungen",
                ['div_3_subheader'] = "Hier siehtst du gesuchte Personen",

                ['div_4_header'] = "Dispatches",
                ['div_4_subheader'] = "Hier siehtst du aktive Dispatches",
                ['div_4_time'] = "Uhrzeit:",
                ['div_4_position'] = "Position:",
                ['div_4_infos'] = "Infos:",

                ['div_5_header'] = "Informationen",
                ['div_5_subheader'] = "Hier siehtst Infos von anderen Beamten",
                ['div_5_create_button'] = "Informationen Hinzufügen",
                ['div_5_title'] = "Titel",
                ['div_5_infos'] = "Informationen",
                ['div_5_submit'] = "Hinzufügen",
                ['div_5_delete_button'] = "Löschen",
            },
            ['control_center'] = {
                ['div_1_header'] = "Fahrzeug-Verteilung",
                ['div_1_subheader'] = "Hier siehst du wie die aktuelle Fahrzeug-Verteilung",
                ['div_1_data'] = {
                    ['Straßenwagen'] = {'Straßenwagen [M]', 'Straßenwagen [UM]'},
                    ['Offroad'] = {'Offroad [M]', 'Offroad [UM]'},
                    ['Highspeed'] = {'Highspeed [M]', 'Highspeed [UM]'},
                    ['Air'] = {'Helikopter', 'Flugzeug'},
                },

                ['div_2_header'] = "Positions-Verteilung",
                ['div_2_subheader'] = "Hier siehst du wie die aktuelle Positions-Verteilung",
                ['div_2_data'] = {
                    ['Departments'] = {'Police Department', 'Sherif Department'},
                    ['Los Angeles'] = {},
                    ['Highway'] = {},
                    ['Frei'] = {},
                },

                ['div_3_header'] = "Unit-Verteilung",
                ['div_3_subheader'] = "Hier siehst du wie die aktuelle Unit-Verteilung",
                ['div_3_data'] = {
                    ['Patrol Unit'] = {'Lincoln', 'Adam'},
                    ['King Unit'] = {},
                    ['SWAT Unit'] = {},
                    ['Gemeinsam'] = {'Lincoln', 'Adam'},
                },

                ['control_center_header'] = "Aktive Beamte im Dienst",
                ['your_status_header'] = "Dein Status",
                ['logout'] = "Aus MDT Austragen",

                ['create_button'] = "+",
                ['create_button_header'] = "Info Erstellen",
                ['create_button_text'] = "Text",
                ['create_button_submit'] = "Erstellen",

                ['enter_message'] = "Nachricht eingeben...",
            },
            ['citizen_search'] = {
                ['search_header'] = "Einwohnersuche",
                ['search_description'] = "Suche nach einem Bürger des Staates",

                ['wanted'] = "Gesucht",
                ['dateofbirth'] = "Geburtsdatum: ",
                ['sex'] = "Geschlecht: ",
                ['sex_options'] = {
                    ['m'] = 'Männlich',
                    ['f'] = 'Weiblich',
                },
            },
            ['citizen'] = {
                ['div_1_header'] = "Informationen",
                ['div_1_subheader'] = "Informationen der geöffneten Person",

                ['div_1_firstname'] = "Vorname: ",
                ['div_1_lastname'] = "Nachname: ",
                ['div_1_dateofbirth'] = "Geburtsdatum: ",
                ['div_1_sex'] = "Geschlecht: ",
                ['div_1_sex_options'] = {
                    ['m'] = 'Männlich',
                    ['f'] = 'Weiblich',
                },

                ['div_2_header'] = "Personaldaten",
                ['div_2_subheader'] = "Personaldaten der geöffneten Person",
                ['div_2_tel'] = "Telefonnummer: ",
                ['div_2_email'] = "E-Mail: ",
                ['div_2_job'] = "Job: ",

                ['div_3_header'] = "Fahndung",
                ['div_3_subheader'] = "Fandung der geöffneten Person",
                ['div_3_status'] = "Status: ",
                ['div_3_status_options'] = {
                    [true] = [[<sl-badge variant="danger">Ja</sl-badge>]],
                    [false] = [[<sl-badge variant="success">Nein</sl-badge>]],
                },
                ['div_3_reason'] = "Grund: ",
                ['div_3_infos'] = "Infos: ",

                ['div_4_header'] = "Lizenzen",
                ['div_4_subheader'] = "Lizenzen der geöffneten Person",

                ['pictures'] = "Bilder",
                ['take_pictures'] = "Neues Bild aufnehmen",
                ['taking_picture'] = 'Bild wird aufgenommen...',
                ['close_picture'] = "Schließen",

                ['edit_personal_information_header'] = 'Persönliche Informationen Bearbeiten',
                ['edit_personal_information_tel'] = 'Telefonnummer',
                ['edit_personal_information_email'] = 'E-Mail',
                ['edit_personal_information_job'] = 'Job',
                ['edit_personal_information_submit'] = 'Speichern',

                ['edit_warrant_information_header'] = 'Fahndung Bearbeiten',
                ['edit_warrant_information_status'] = 'Status',
                ['edit_warrant_information_reason'] = 'Grund',
                ['edit_warrant_information_infos'] = 'Infos',
                ['edit_warrant_information_submit'] = 'Speichern',

                ['div_5_header'] = "Notizen",
                ['div_5_add_note'] = "Notiz Erstellen",
                ['div_5_note_text'] = 'Notiz-Text',
                ['div_5_note_submit'] = 'Erstellen',

                ['div_6_header'] = "Akten",
                ['div_6_crime'] = "Vergehen",
                ['div_6_description'] = "Beschreibung",
                ['div_6_time'] = "Zeitpunkt",
                ['div_6_status'] = "Status",
                ['div_6_officer'] = "Beamter",
                ['div_6_actions'] = "Aktionen",
                ['div_6_add_crime'] = 'Akte Hinzufügen',
                ['div_6_crime_crime'] = 'Vergehen',
                ['div_6_crime_description'] = 'Beschreibung',
                ['div_6_crime_submit'] = 'Hinzufügen',
                ['div_6_crime_options'] = {
                    [true] = {"danger", "Aktiv"},
                    [false] = {"success", "Geschlossen"},
                },
            },
            ['vehicle_search'] = {
                ['search_header'] = "Fahrzeugsuche",
                ['search_description'] = "Suche nach einem Kraftfahrzeug",

                ['wanted_options'] = {
                    [false] = {"success", "Unauffällig"},
                    [true] = {"danger", "Gesucht"},
                },
                ['owner'] = "Besitzer: ",
                ['type'] = "Fahrzeugtyp: ",
                ['color'] = "Primärfarbe: ",
                ['registered'] = "Registrierung: ",
                ['registered_options'] = {
                    [0] = [[<sl-badge variant="danger">Abgemeldet</sl-badge>]],
                    [1] = [[<sl-badge variant="success">Registriert</sl-badge>]],
                },
            },

            ['weapon_search'] = {
                ['search_header'] = "Waffensuche",
                ['search_description'] = "Suche nach einer registrierten Waffe",

                ['wanted_options'] = {
                    [false] = {"success", "Unauffällig"},
                    [true] = {"danger", "Gesucht"},
                },
                ['owner'] = "Besitzer: ",
                ['type'] = "Waffentyp: ",
            },

            ['tracking'] = {
                ['search_header'] = "Tracking-Suche",
                ['search_description'] = "Suche nach einem Kennzeichen oder einer Telefonnummer",

                ['name'] = "Name: ",
                ['model'] = "Fahrzeugtyp: ",
                ['color'] = "Primärfarbe: ",

                ['not_enabled'] = [[<sl-badge variant="danger">Die Tracking Funktion wurde dafür nicht aktiviert!</sl-badge>]],

                ['vehicle_tracking_success'] = [[<sl-badge variant="success">Das Fahrzeug wurde erfolgreich getrackt!</sl-badge>]],
                ['vehicle_tracking_error'] = [[<sl-badge variant="danger">Das Fahrzeug konnte nicht getrackt werden!</sl-badge>]],
                ['citizen_tracking_success'] = [[<sl-badge variant="success">Der Bürger wurde erfolgreich getrackt!</sl-badge>]],
                ['citizen_tracking_error'] = [[<sl-badge variant="danger">Der Bürger konnte nicht getrackt werden!</sl-badge>]],

                ['create_marker'] = "Markieren",
                ['delete_tracker'] = "Löschen"
            },

            ['dispatches'] = {
                ['control_center'] = "Leitstelle",
                
                ['unoccupied'] = "Die Leitstelle wird aktuell von keinen Beamten besetzt!",
                ['occupie'] = "Leitstelle Besetzen",

                ['occupied_from'] = "Aktuell wird die Leitstelle von %s besetzt!",
                ['no_call'] = "Aktuell befindet sich kein Anrufer in der Leitung!",
                ['receive_call'] = "Die Leitstelle wird aktuell alarmiert!",
                ['accept_call'] = "Anruf Annehmen",

                ['call_time'] = "Aktueller Notruf: ",
                ['end_call'] = "Telefonat Beenden",

                ['dispatch_time'] = "Uhrzeit:",
                ['dispatch_position'] = "Position:",
                ['dispatch_infos'] = "Infos:",
                ['dispatch_add_officer'] = "Beamte Hinzufügen",
                ['dispatch_edit_infos_header'] = "Infos Bearbeiten",
                ['dispatch_edit_infos_description'] = "Neue Infos",
                ['dispatch_edit_infos_button'] = "Ändern",

                ['dispatch_edit_code_header'] = "Code Ändern",
                ['dispatch_edit_code_description'] = "Neuer Status-Code",
                ['dispatch_edit_code_button'] = "Ändern",
                ['dispatch_edit_dispatch_delete'] = "Dispatch Löschen",

                ['dispatch_create_dispatch_header'] = "Dispatch Erstellen",
                ['dispatch_create_dispatch_reason'] = "Dispatch Titel",
                ['dispatch_create_dispatch_code'] = "Dispatch Status-Code",
                ['dispatch_create_dispatch_infos'] = "Dispatch Infos",
                ['dispatch_create_dispatch_button'] = "Erstellen",
            },
            ['lists'] = {
                ['header'] = {
                    ['employee'] = "Mitarbeiter",
                    ['vehicles'] = "Fahrzeuge",
                    ['outfits'] = "Kleidung",
                    ['codes'] = "Codes / Funks",
                    ['training'] = "Ausbildungen",
                    ['law'] = "Gesetze",
                },
                ['employee'] = {
                    ['header_name'] = "Name",
                    ['header_dob'] = "Geburtsdatum",
                    ['header_tel'] = "Telefonnummer",
                    ['header_callnumber'] = "Rufnummer",
                    ['header_badgenummer'] = "Badgenummer",
                    ['header_unit'] = "Einheit",
                    ['header_notes'] = "Notizen",
                    ['header_trainings'] = "Ausbildungen",

                    ['callnumber_header'] = "Rufnummer Bearbeiten",
                    ['callnumber_description'] = "Neue Rufnummer",
                    ['callnumber_button'] = "Ändern",

                    ['badgenumber_header'] = "Badgenummer Bearbeiten",
                    ['badgenumber_description'] = "Neue Badgenummer",
                    ['badgenumber_button'] = "Ändern",

                    ['unit_header'] = "Einheit Bearbeiten",
                    ['unit_description'] = "Neue Einheit",
                    ['unit_button'] = "Ändern",

                    ['notes_header'] = "Notizen Bearbeiten",
                    ['notes_description'] = "Neue Notiz",
                    ['notes_button'] = "Ändern",
                },
                ['vehicles'] = {
                    ['header_category'] = "Kategorie",
                    ['header_name'] = "Fahrzeugname",
                    ['header_mingrade'] = "Rang",
                    ['header_price'] = "Preis",
                    ['header_actions'] = "Aktionen",

                    ['vehice_add_button'] = "Fahrzeug Hinzufügen",
                    ['vehicle_select_category'] = "Kategorie Wählen",
                    ['vehicle_select_name'] = "Fahrzeugname Wählen",
                    ['vehicle_select_grade'] = "Rang Wählen",
                    ['vehicle_select_price'] = "Preis Wählen",
                    ['vehicle_add_submit'] = "Hinzufügen",
                },
                ['outfits'] = {
                    ['add_outfit'] = "Outfit Hinzufügen",
                    ['create_name'] = "Outfit Name",
                    ['create_url'] = "Bild-URL",
                    ['create_grade'] = "Rang",
                    ['create_unit'] = "Unit",
                    ['create_button'] = "Hinzufügen",

                    ['outfit_numbers'] = "Kleiderschrank",

                    ['parts'] = { 
                        ['tshirt'] = 'T-Shirt',
                        ['torso'] = 'Torso',
                        ['decals'] = 'Decals',
                        ['arms'] = 'Arme',
                        ['pants'] = 'Hose',
                        ['shoes'] = 'Schuhe',
                        ['mask'] = 'Maske',
                        ['bproof'] = 'Weste',
                        ['chain'] = 'Kette',
                        ['helmet'] = 'Helm',
                        ['glasses'] = 'Brille',
                        ['watches'] = 'Uhr',
                        ['bags'] = 'Rucksack',
                        ['ears'] = 'Ohren', 
                    },
                },
                ['codes'] = {
                    ['description'] = "Beschreibung",
                    ['status'] = "Status",
                    ['code'] = "Codes",
                    ['frequency'] = "Frequenzen",
                },
                ['training'] = {
                    ['training'] = "Ausbildung",
                    ['description'] = "Beschreibung",
                    ['supervisor'] = "Ausbilder",
                    ['time'] = "Zeitpunkt",
                    ['location'] = "Treffpunkt",
                    ['self_status'] = "Anmeldestatus",
                    ['participants'] = "Teilnehmer",
                    ['actions'] = "Aktionen",

                    ['login_status'] = {
                        [true] = {"Angemeldet", "success"},
                        [false] = {"Nicht Angemeldet", "danger"},
                    },

                    ['add_training'] = "Ausbildung Hinzufügen",
                    ['select_training'] = "Ausbildung Wählen",
                    ['select_time'] = "Zeitpunkt Wählen",
                    ['select_location'] = "Treffpunkt Wählen",
                    ['select_limit'] = "Limit Wählen",
                    ['training_submit'] = "Erstellen",

                    ['submit_training_header'] = "Ausbildung Beenden",
                    ['submit_training_description'] = "Hake all jene Personen an, welche die Ausbildung bestanden haben.",
                    ['submit_training_button'] = "Beenden",
                },
                ['law'] = {
                    ['label'] = "Verhehen",
                    ['description'] = "Beschreibung",
                    ['jail'] = "Gefängniszeit",
                    ['fine'] = "Geldstrafe",
                    ['society'] = "Sozialarbeit",
                    ['actions'] = "Aktionen",

                    ['add_paragraph'] = "Paragraph Hinzufügen",
                    ['submit_paragraph'] = "Neuer Paragraph",
                    ['paragraph_submit_button'] = "Hinzufügen",

                    ['add_crime'] = "Vergehen Hinzufügen",
                    ['submit_crime'] = "Neues Vergehen",
                    ['submit_description'] = "Beschreibung",
                    ['submit_jail'] = "Gefängniszeit",
                    ['submit_fine'] = "Geldstrafe",
                    ['submit_society'] = "Sozialarbeit",
                    ['crime_submit_button'] = "Hinzufügen",
                },

            },
            ['documents'] = {
                ['search_header'] = "Dokumentensuche",
                ['search_description'] = "Suche nach einem erstelltem Bericht",
                
                ['create_document'] = "Neuen Bericht Erstellen",
                ['create_document_type'] = "Bericht Typ",
                ['create_document_submit'] = "Erstellen",
            },
            ['calculator'] = {
                ['header'] = "Strafrechner",
                ['description'] = "Rechne Geldstrafen, Haftstrafen und Sozialstunden von mehreren Vergehen zusammen",
                
                ['jail'] = "Gefängniszeit: ",
                ['fine'] = "Geldstrafe: ",
                ['society'] = "Sozialarbeit: ",
            },
        },
    },
    ['EN'] = {

    },
}

Config.VehicleColors = {
    [0] = "Metallic Black",
    [1] = "Metallic Graphite Black",
    [2] = "Metallic Black Steal",
    [3] = "Metallic Dark Silver",
    [4] = "Metallic Silver",
    [5] = "Metallic Blue Silver",
    [6] = "Metallic Steel Gray",
    [7] = "Metallic Shadow Silver",
    [8] = "Metallic Stone Silver",
    [9] = "Metallic Midnight Silver",
    [10] = "Metallic Gun Metal",
    [11] = "Metallic Anthracite Grey",
    [12] = "Matte Black",
    [13] = "Matte Gray",
    [14] = "Matte Light Grey",
    [15] = "Util Black",
    [16] = "Util Black Poly",
    [17] = "Util Dark silver",
    [18] = "Util Silver",
    [19] = "Util Gun Metal",
    [20] = "Util Shadow Silver",
    [21] = "Worn Black",
    [22] = "Worn Graphite",
    [23] = "Worn Silver Grey",
    [24] = "Worn Silver",
    [25] = "Worn Blue Silver",
    [26] = "Worn Shadow Silver",
    [27] = "Metallic Red",
    [28] = "Metallic Torino Red",
    [29] = "Metallic Formula Red",
    [30] = "Metallic Blaze Red",
    [31] = "Metallic Graceful Red",
    [32] = "Metallic Garnet Red",
    [33] = "Metallic Desert Red",
    [34] = "Metallic Cabernet Red",
    [35] = "Metallic Candy Red",
    [36] = "Metallic Sunrise Orange",
    [37] = "Metallic Classic Gold",
    [38] = "Metallic Orange",
    [39] = "Matte Red",
    [40] = "Matte Dark Red",
    [41] = "Matte Orange",
    [42] = "Matte Yellow",
    [43] = "Util Red",
    [44] = "Util Bright Red",
    [45] = "Util Garnet Red",
    [46] = "Worn Red",
    [47] = "Worn Golden Red",
    [48] = "Worn Dark Red",
    [49] = "Metallic Dark Green",
    [50] = "Metallic Racing Green",
    [51] = "Metallic Sea Green",
    [52] = "Metallic Olive Green",
    [53] = "Metallic Green",
    [54] = "Metallic Gasoline Blue Green",
    [55] = "Matte Lime Green",
    [56] = "Util Dark Green",
    [57] = "Util Green",
    [58] = "Worn Dark Green",
    [59] = "Worn Green",
    [60] = "Worn Sea Wash",
    [61] = "Metallic Midnight Blue",
    [62] = "Metallic Dark Blue",
    [63] = "Metallic Saxony Blue",
    [64] = "Metallic Blue",
    [65] = "Metallic Mariner Blue",
    [66] = "Metallic Harbor Blue",
    [67] = "Metallic Diamond Blue",
    [68] = "Metallic Surf Blue",
    [69] = "Metallic Nautical Blue",
    [70] = "Metallic Bright Blue",
    [71] = "Metallic Purple Blue",
    [72] = "Metallic Spinnaker Blue",
    [73] = "Metallic Ultra Blue",
    [74] = "Metallic Bright Blue",
    [75] = "Util Dark Blue",
    [76] = "Util Midnight Blue",
    [77] = "Util Blue",
    [78] = "Util Sea Foam Blue",
    [79] = "Uil Lightning blue",
    [80] = "Util Maui Blue Poly",
    [81] = "Util Bright Blue",
    [82] = "Matte Dark Blue",
    [83] = "Matte Blue",
    [84] = "Matte Midnight Blue",
    [85] = "Worn Dark blue",
    [86] = "Worn Blue",
    [87] = "Worn Light blue",
    [88] = "Metallic Taxi Yellow",
    [89] = "Metallic Race Yellow",
    [90] = "Metallic Bronze",
    [91] = "Metallic Yellow Bird",
    [92] = "Metallic Lime",
    [93] = "Metallic Champagne",
    [94] = "Metallic Pueblo Beige",
    [95] = "Metallic Dark Ivory",
    [96] = "Metallic Choco Brown",
    [97] = "Metallic Golden Brown",
    [98] = "Metallic Light Brown",
    [99] = "Metallic Straw Beige",
    [100] = "Metallic Moss Brown",
    [101] = "Metallic Biston Brown",
    [102] = "Metallic Beechwood",
    [103] = "Metallic Dark Beechwood",
    [104] = "Metallic Choco Orange",
    [105] = "Metallic Beach Sand",
    [106] = "Metallic Sun Bleeched Sand",
    [107] = "Metallic Cream",
    [108] = "Util Brown",
    [109] = "Util Medium Brown",
    [110] = "Util Light Brown",
    [111] = "Metallic White",
    [112] = "Metallic Frost White",
    [113] = "Worn Honey Beige",
    [114] = "Worn Brown",
    [115] = "Worn Dark Brown",
    [116] = "Worn straw beige",
    [117] = "Brushed Steel",
    [118] = "Brushed Black steel",
    [119] = "Brushed Aluminium",
    [120] = "Chrome",
    [121] = "Worn Off White",
    [122] = "Util Off White",
    [123] = "Worn Orange",
    [124] = "Worn Light Orange",
    [125] = "Metallic Securicor Green",
    [126] = "Worn Taxi Yellow",
    [127] = "police car blue",
    [128] = "Matte Green",
    [129] = "Matte Brown",
    [130] = "Worn Orange",
    [131] = "Matte White",
    [132] = "Worn White",
    [133] = "Worn Olive Army Green",
    [134] = "Pure White",
    [135] = "Hot Pink",
    [136] = "Salmon pink",
    [137] = "Metallic Vermillion Pink",
    [138] = "Orange",
    [139] = "Green",
    [140] = "Blue",
    [141] = "Mettalic Black Blue",
    [142] = "Metallic Black Purple",
    [143] = "Metallic Black Red",
    [144] = "hunter green",
    [145] = "Metallic Purple",
    [146] = "Metaillic V Dark Blue",
    [147] = "MODSHOP BLACK1",
    [148] = "Matte Purple",
    [149] = "Matte Dark Purple",
    [150] = "Metallic Lava Red",
    [151] = "Matte Forest Green",
    [152] = "Matte Olive Drab",
    [153] = "Matte Desert Brown",
    [154] = "Matte Desert Tan",
    [155] = "Matte Foilage Green",
    [156] = "DEFAULT ALLOY COLOR",
    [157] = "Epsilon Blue",
}


Config.Notifcation = function(notify)
    local message = notify[1]
    local notify_type = notify[2]
    lib.notify({
        position = 'top-right',
        description = message,
        type = notify_type,
    })
end 

Config.InfoBar = function(info, toggle)
    local message = info[1]
    local notify_type = info[2]
    if toggle then 
        lib.showTextUI(message, {position = 'bottom-center'})
    else 
        lib.hideTextUI()
    end
end 
