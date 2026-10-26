local ped

local function openMenu()
    local options = {}

    for name, price in pairs(Config.Items) do
        local count = exports.ox_inventory:Search('count', name)
        if count and count > 0 then
            local data = exports.ox_inventory:Items(name)
            options[#options + 1] = {
                title = ('%s (x%d)'):format(data and data.label or name, count),
                description = ('Cena: $%d / ks'):format(price),
                icon = 'fa-solid fa-box',
                onSelect = function()
                    local input = lib.inputDialog('Predaj', {
                        { type = 'number', label = 'Počet', default = count, min = 1, max = count, required = true },
                    })
                    if not input then return end
                    TriggerServerEvent('ngd-tobaccobuyer:sell', name, math.floor(input[1]))
                end,
            }
        end
    end

    if #options == 0 then
        return lib.notify({ type = 'error', description = 'Nemáš nič na predaj.' })
    end

    lib.registerContext({ id = 'tobacco_buyer', title = Config.Buyer.label, options = options })
    lib.showContext('tobacco_buyer')
end

CreateThread(function()
    local b = Config.Buyer
    lib.requestModel(b.model)

    ped = CreatePed(4, b.model, b.coords.x, b.coords.y, b.coords.z, b.coords.w, false, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)

    exports.ox_target:addLocalEntity(ped, {
        { label = b.label, icon = b.icon, distance = 2.5, onSelect = openMenu },
    })
end)

AddEventHandler('onResourceStop', function(res)
    if res == GetCurrentResourceName() and ped then DeleteEntity(ped) end
end)