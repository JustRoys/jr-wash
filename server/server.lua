TriggerEvent("getCore",function(core)
    VorpCore = core
end)

local VorpInv = exports.vorp_inventory:vorp_inventoryApi()

for k,v in pairs(Config.WashItems) do
    VorpInv.RegisterUsableItem(Config.WashItems[k], function(data)
        VorpInv.CloseInv(data.source)
        VorpInv.subItem(data.source, Config.WashItems[k], 1)
        TriggerClientEvent("wash", data.source)
    end)
end
