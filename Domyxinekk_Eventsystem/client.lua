local ESX = exports['es_extended']:getSharedObject()

local locations = {}
for name, coords in pairs(Config.EventLocations) do
    table.insert(locations, { label = name, coords = coords })
end

RegisterNetEvent("event_system:openAdminMenu", function()
    lib.registerContext({
        id = 'event_admin_menu',
        title = 'Event Admin Menu',
        options = {
            {
                title = 'Zahájit Event',
                description = 'Vyber lokaci pro event',
                icon = 'fa-solid fa-user-shield',
                onSelect = function()
                    TriggerEvent("event_system:selectLocationMenu")
                end
            },
            {
                title = 'Ukončit Event',
                description = 'Ukončí aktuální event',
                icon = 'fa-solid fa-calendar',
                onSelect = function()
                    TriggerServerEvent("event_system:deactivateEvent")
                end
            }
        }
    })
    lib.showContext('event_admin_menu')
end)

RegisterNetEvent("event_system:selectLocationMenu", function()
    local opts = {}

    for _, loc in pairs(locations) do
        table.insert(opts, {
            title = loc.label,
            image = loc.image or nil,
            description = 'Klikni pro Zahajení Eventu pro hráče!',
            icon = 'fa-solid fa-location-dot',
            onSelect = function()
                TriggerServerEvent("event_system:setActiveEvent", loc)
            end
        })
    end

    lib.registerContext({
        id = 'event_location_menu',
        title = 'Výběr Lokace',
        options = opts
    })
    lib.showContext('event_location_menu')
end)

RegisterNetEvent("event_system:openJoinMenu", function(eventIsActive)
    if not eventIsActive then
        lib.notify({ description = "Žádný event není aktivní.", type = "error" })
        return
    end

    lib.registerContext({
        id = 'event_join_menu',
        title = 'Teleportovat se na Event',
        options = {
            {
                title = 'Teleportovat se',
                description = 'Připojit se na aktivní event',
                onSelect = function()
                    TriggerEvent("event_system:joinEvent")
                end
            }
        }
    })
    lib.showContext('event_join_menu')
end)

RegisterNetEvent("event_system:joinEvent", function()
    ESX.TriggerServerCallback("event_system:getActiveEvent", function(eventData)
        if eventData and eventData.coords then
            SetEntityCoords(PlayerPedId(), eventData.coords.x, eventData.coords.y, eventData.coords.z, false, false,
                false, true)
        else
            lib.notify({ description = "Event není dostupný.", type = "error" })
        end
    end)
end)
