Config = {}

Config.Debug = true                        -- Set true to enable debug mode

Config.OutsiderNeeds = true                 -- Set false if you don't use outsider_needs

Config.UseDurability = true                 -- Set false if you don't want to use durability
Config.MaxDurability = 100                  -- Maximum durability
Config.RemoveDurability = 20                -- Durability to remove per use
Config.NotifyBroken = true                  -- Notify player when item is broken

Config.WashItems = {
    "washcloth",
    "soap"
}

Config.Language = {
    Description = "Durability",
    Broke = "Your washing item broke",
}
