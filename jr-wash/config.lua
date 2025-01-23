Config = {}

Config.Debug = true                         -- Set true to enable debug mode

Config.Language = "English"                 -- English, Dutch

Config.OutsiderNeeds = true                 -- Set false if you don't use outsider_needs

Config.AnimationLenght = 10000                -- Time in ms to play the animation

-- Durability
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
    --OpenMenuKey = 0x41AC83D1                -- E
}

-- Interaction Props
Config.UseProps = true
Config.Distance = 2.0
Config.Props = {                            -- Choose barrel or bucket animation
    --{ name = "p_wellpumpnbx01x", type = "barrel" }, -- Make sure this is not in another script enabled
    --{ name = "p_wellpumpnbx01x", type = "barrel" },
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

-- Coming Soon...
--[[ Config.BathLocations = {
    ["Valentine"] = {
        Price = {
            Normal = 1.00,
            Deluxe = 5.00
        },
        Location = {
            Enter = vector3(-320.56, 762.41, 117.44),
            Exit = vector3(-320.56, 762.41, 117.44),
            Bath = vector4(-317.37, 761.8, 116.44, 10.365),
            doorhash = 1523300673,
        },
        Blip = {
            ShowBlip = true,
            BlipSprite = -304640465,
            BlipScale = 0.8,
            BlipName = "Bathhouse"
        },
        NPC = {
            Model = "a_m_m_rancher_01",
            Position = vector3(-308.0, 769.0, 118.0),
            Scale = 1.0
        },
        Animation = {
            AnimDict = "amb_misc@world_human_wash_face_bucket@table@female_a@idle_d",
            AnimName = "idle_j"
        },
    }
}]]
