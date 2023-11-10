TriggerEvent("getCore",function(core)
    VorpCore = core
end)

local VORPInv = exports.vorp_inventory:vorp_inventoryApi()

VORPInv.RegisterUsableItem("washcloth", function(data)
    local source = data.source
    TriggerClientEvent("wash", source)
    VORPInv.subItem(source, 'washcloth', 1)
end)

VORPInv.RegisterUsableItem("soap", function(data)
    local source = data.source
    TriggerClientEvent("wash", source)
    VORPInv.subItem(source, 'washcloth', 1)
end)