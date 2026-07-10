Config = {}

Config.Debug = false                         -- Set true to enable debug mode

Config.Language = "English"                 -- English, Dutch

Config.OutsiderNeeds = true                 -- Set false if you don't use outsider_needs

Config.AnimationLenght = 10000              -- Time in ms to play the animation

-- Durability
Config.RemoveItem = false                   -- Set false if you don't want to remove the item after use or set false if you use Config.Durability
Config.Durability = {
    Enable = true,                          -- Set false if you don't want to use durability
    MaxDurability = 100,                    -- Maximum durability
    RemoveDurability = 20,                  -- Durability to remove per use
    NotifyBroken = true                     -- Notify player when item is broken
}

-- Items
Config.WashItems = {
    "washcloth",
    "soap"
}

-- Keys
Config.Keys = {
    WashKey = 0x41AC83D1,                   -- E
}

-- Interaction Props
Config.UseProps = true
Config.Distance = 2.0
Config.Props = {                            -- Choose barrel or bucket animation
    --{ name = "p_wellpumpnbx01x", type = "barrel" }, -- Make sure this is not in another script enabled
    { name = "p_barrel_wash01x", type = "bucket" },
    { name = "p_washbasin01x", type = "bucket" },
    { name = "p_washtub01x", type = "bucket" },
    { name = "p_washtub02x", type = "bucket" },
    { name = "p_washtub03x", type = "bucket" },
    { name = "p_waterbucket01x", type = "bucket" },
    { name = "p_watertrough01x", type = "bucket" },
    { name = "p_watertrough01x_new", type = "bucket" },
    { name = "p_watertrough02x", type = "bucket" },
    { name = "p_watertrough03x", type = "bucket" },
    { name = "p_watertroughsml01x", type = "bucket" },
    { name = "p_barrelhalf02x", type = "bucket" },
}
