
ESX = exports['es_extended']:getSharedObject()

local activeEvent = nil


local function isAdmin(group)
    for _, allowed in pairs(Config.AdminGroups or {}) do
        if group == allowed then return true end
    end
    return false
end

RegisterCommand("eventadmin", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and isAdmin(xPlayer.getGroup()) then
        TriggerClientEvent("event_system:openAdminMenu", source)
    else
        TriggerClientEvent("ox_lib:notify", source, { description = "Nemáš oprávnění používat /eventadmin.", type = "error" })
    end
end, false)

RegisterCommand("event", function(source)
    TriggerClientEvent("event_system:openJoinMenu", source, activeEvent ~= nil)
end, false)

ESX.RegisterServerCallback("event_system:getActiveEvent", function(_, cb)
    cb(activeEvent)
end)

RegisterNetEvent("event_system:setActiveEvent", function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer and isAdmin(xPlayer.getGroup()) then
        activeEvent = data
        TriggerClientEvent("ox_lib:notify", src, { description = "Event spuštěn!", type = "success" })
    end
end)

RegisterNetEvent("event_system:deactivateEvent", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer and isAdmin(xPlayer.getGroup()) then
        activeEvent = nil
        TriggerClientEvent("ox_lib:notify", src, { description = "Event byl ukončen.", type = "error" })
    end
end)
