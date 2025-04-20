local T = Translation.Langs[Config.Language]

for index, value in ipairs(Config.WashItems) do
    exports.vorp_inventory:registerUsableItem(value, function(data)
        local _source = data.source
        local currentMeta = data.item.metadata
        local washItem

        if Config.Debug then
            print("Used washing item: "..value)
        end

        exports.vorp_inventory:closeInventory(_source)

        if Config.Durability.Enable then
            local durability
            local description

            washItem = exports.vorp_inventory:getItemContainingMetadata(_source, value, currentMeta, nil)

            if currentMeta.durability == nil then
                durability = Config.Durability.MaxDurability - Config.Durability.RemoveDurability
                description = ""..T.Description.. " "..tostring(durability).. "%"

                if Config.Debug then
                    print("Old Durability: 100")
                end
            else
                if Config.Debug then
                    print(washItem.id)
                end
                durability = currentMeta.durability - Config.Durability.RemoveDurability
                description = ""..T.Description.. " "..tostring(durability).. "%"

                if Config.Debug then
                    print("Old Durability: "..currentMeta.durability)
                end
            end

            if durability <= 0 then
                exports.vorp_inventory:subItemID(_source, washItem.id)

                if Config.Durability.NotifyBroken then
                    TriggerClientEvent("vorp:TipRight", _source, T.Broke, 6000)
                end
            else
                local newMeta = {durability = durability, description = description}
                exports.vorp_inventory:subItemID(_source, washItem.id)
                exports.vorp_inventory:addItem(_source, value, 1, newMeta)
            end

            if Config.Debug then
                print("New Durability: "..durability)
            end

            TriggerClientEvent("jr-wash:client:wash", _source)
        else
            if Config.RemoveItem then
                exports.vorp_inventory:subItem(_source, value, 1)
            end

            TriggerClientEvent("jr-wash:client:wash", _source)

            if Config.Durability.Enable and Config.Durability.NotifyBroken then
                TriggerClientEvent("vorp:TipRight", _source, T.Broke, 6000)
            end
        end
    end)
end

