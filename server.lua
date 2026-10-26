local ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('ngd-tobaccobuyer:sell', function(item, amount)
    local src = source
    amount = math.floor(tonumber(amount) or 0)

    local price = Config.Items[item]
    if not price or amount <= 0 then return end

    -- kontrola vzdialenosti od NPC
    local b = Config.Buyer.coords
    local pCoords = GetEntityCoords(GetPlayerPed(src))
    if #(pCoords - vec3(b.x, b.y, b.z)) > 5.0 then return end

    local have = exports.ox_inventory:GetItemCount(src, item)
    if have < amount then
        return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'Nemáš dosť itemov.' })
    end

    if not exports.ox_inventory:RemoveItem(src, item, amount) then return end

    local total = price * amount
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.addMoney(total) -- QBCore: Player.Functions.AddMoney('cash', total)

    TriggerClientEvent('ox_lib:notify', src, {
        type = 'success',
        description = ('Predal si %dx za $%d.'):format(amount, total),
    })
end)