for index, value in ipairs(Config.WashItems) do
    exports.vorp_inventory:registerUsableItem(value, function(data)
        local _source = data.source
        local currentMeta = data.item.metadata
        local washItem

        print(currentMeta.durability)

        exports.vorp_inventory:closeInventory(_source)

        if Config.UseDurability then
            local durability
            local description

            washItem = exports.vorp_inventory:getItemContainingMetadata(_source, value, currentMeta, nil)

            if currentMeta.durability == nil then
                durability = Config.MaxDurability - Config.DamagePerUse
                description = "Durability: "..tostring(durability)
            else
                print(washItem.id)
                durability = currentMeta.durability - Config.DamagePerUse
                description = "Durability: "..tostring(durability)
            end

            if durability <= 0 then
                exports.vorp_inventory:subItemID(_source, washItem.id)
            else
                local newMeta = {durability = durability, description = description}
                -- exports.vorp_inventory:subItem(_source, value, 1, {})
                exports.vorp_inventory:subItemID(_source, washItem.id)
                exports.vorp_inventory:addItem(_source, value, 1, newMeta)
            end

            TriggerClientEvent("jr-wash:client:wash", _source)
        else
            exports.vorp_inventory:subItem(_source, value, 1)
            TriggerClientEvent("jr-wash:client:wash", _source)
        end
    end)
end