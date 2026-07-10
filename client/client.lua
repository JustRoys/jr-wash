local Core = exports.vorp_core:GetCore()

local buttons_prompt = GetRandomIntInRange(0, 0xffffff)
local Wash

local T = Translation.Langs[Config.Language]

-- Prompt setup
function WashPrompt()
    Wash = Citizen.InvokeNative(0x04F97DE45A519419)
    PromptSetControlAction(Wash, Config.Keys.WashKey)
    PromptSetText(Wash, CreateVarString(10, 'LITERAL_STRING', T.Wash))
    PromptSetEnabled(Wash, true)
    PromptSetVisible(Wash, true)
    PromptSetHoldMode(Wash, true)
    PromptSetGroup(Wash, buttons_prompt)
    PromptRegisterEnd(Wash)
end

-- Animations
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

RegisterNetEvent("jr-wash:client:wash", function()
    local Player = PlayerPedId()

    if IsPedMale(Player) then
        PlayAnimation(Player, "mp_amb_player@prop_player_wash_face_barrel@sober@male_a@base", "base")
    else
        PlayAnimation(Player, "amb_misc@world_human_wash_face_bucket@table@female_a@idle_d", "idle_j")
    end

    Wait(12000)
    ClearPedEnvDirt(Player)
    ClearPedBloodDamage(Player)
    ClearPedDamageDecalByZone(Player, 10, "ALL")

    if Config.OutsiderNeeds then
        TriggerEvent("Outsider_needs:Client:ClearDirt")
    end

    ClearPedTasks(Player)
end)

if Config.UseProps then
    Citizen.CreateThread(function()
        WashPrompt()
        while true do
            local Player = PlayerPedId()
            local Coords = GetEntityCoords(Player)
            local playerHorse = IsPedOnMount(Player)
            local playerWagon = IsPedInAnyVehicle(Player, true)
            local Sleep = 1000

            for _, PropName in ipairs(Config.Props) do
                local PropHash = GetHashKey(PropName.name)
                local Props = GetClosestObjectOfType(Coords.x, Coords.y, Coords.z, 1.0, PropHash, false, false, false)

                if DoesEntityExist(Props) then
                    local PropCoords = GetEntityCoords(Props)
                    local Distance = #(Coords - PropCoords)

                    if Distance <= Config.Distance then
                        Sleep = 0

                        PromptSetActiveGroupThisFrame(buttons_prompt, T.Wash)
                        if PromptHasHoldModeCompleted(Wash) then
                            if playerHorse or playerWagon then
                                Wait(100)
                                TriggerEvent("vorp:TipRight", T.OnHorseOrWagon, Config.TextTime)
                            else
                                TaskTurnPedToFaceEntity(Player, Props, 1000)
                                Wait(1100)
                                if PropName.type == "barrel" then
                                    if IsPedMale(PlayerPedId()) then
                                        PlayAnimation(PlayerPedId(), "mp_amb_player@prop_player_wash_face_barrel@sober@male_a@base", "base", 0)
                                    else
                                        PlayAnimation(PlayerPedId(), "amb_misc@world_human_wash_face_bucket@table@female_a@idle_d", "idle_j", 0)
                                    end
                                elseif PropName.type == "bucket" then
                                    if IsPedMale(PlayerPedId()) then
                                        TaskStartScenarioInPlace(Player, "WORLD_HUMAN_WASH_FACE_BUCKET_GROUND", 0, true)
                                    else
                                        TaskStartScenarioInPlace(Player, "WORLD_HUMAN_WASH_FACE_BUCKET_GROUND", 0, true)
                                    end
                                end

                                Wait(Config.AnimationLenght)
                                ClearPedEnvDirt(Player)
                                ClearPedBloodDamage(Player)
                                ClearPedDamageDecalByZone(Player, 10, "ALL")

                                if Config.OutsiderNeeds then
                                    TriggerEvent("Outsider_needs:Client:ClearDirt")
                                end

                                ClearPedTasks(Player)
                            end
                        end
                    end
                end
            end
            Wait(Sleep)
        end
    end)
end