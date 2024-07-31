for index, value in ipairs(Config.WashItems) do
    exports.vorp_inventory:registerUsableItem(value, function(data)
        local _source = data.source
        local currentMeta = data.item.metadata
        local washItem

        if Config.Debug then
            print("Used washing item: "..value)
        end

        exports.vorp_inventory:closeInventory(_source)

        if Config.UseDurability then
            local durability
            local description

            washItem = exports.vorp_inventory:getItemContainingMetadata(_source, value, currentMeta, nil)

            if currentMeta.durability == nil then
                durability = Config.MaxDurability - Config.RemoveDurability
                description = ""..Config.Language.Description.. " "..tostring(durability).. "%"

                if Config.Debug then
                    print("Old Durability: 100")
                end
            else
                if Config.Debug then
                    print(washItem.id)
                end
                durability = currentMeta.durability - Config.RemoveDurability
                description = ""..Config.Language.Description.. " "..tostring(durability).. "%"

                if Config.Debug then
                    print("Old Durability: "..currentMeta.durability)
                end
            end

            if durability <= 0 then
                exports.vorp_inventory:subItemID(_source, washItem.id)

                if Config.NotifyBroken then
                    TriggerClientEvent("vorp:TipRight", _source, Config.Language.Broke, 6000)
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
            exports.vorp_inventory:subItem(_source, value, 1)
            TriggerClientEvent("jr-wash:client:wash", _source)

            if Config.NotifyBroken then
                TriggerClientEvent("vorp:TipRight", _source, Config.Language.Broke, 6000)
            end
        end
    end)
end