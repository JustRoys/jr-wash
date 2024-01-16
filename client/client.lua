TriggerEvent("getCore",function(core)
    VorpCore = core
end)

function PlayAnimation(ped, dict, name)
    if not DoesAnimDictExist(dict) then
        return
    end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
    Citizen.Wait(0)
    end
    TaskPlayAnim(ped, dict, name, -1.0, -0.5, -1, 1, 0, true, 0, false, 0, false)
    RemoveAnimDict(dict)
end

RegisterNetEvent("wash", function()
    local ped = PlayerPedId()
    if IsPedMale(PlayerPedId()) then 
        PlayAnimation(ped, "mp_amb_player@prop_player_wash_face_barrel@sober@male_a@base", "base")
    else
        PlayAnimation(ped, "amb_misc@world_human_wash_face_bucket@table@female_a@idle_d", "idle_j")
    end
    Wait(2000)
    ClearPedEnvDirt(PlayerPedId())
    ClearPedBloodDamage(PlayerPedId())
    ClearPedDamageDecalByZone(PlayerPedId(), 10, "ALL")
    if Config.Outsiderneeds then
        TriggerEvent("Outsider_needs:Client:ClearDirt")
    end
    ClearPedTasks(ped)
end)
