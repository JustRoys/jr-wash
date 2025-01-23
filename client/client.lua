local Core = exports.vorp_core:GetCore()

local buttons_prompt = GetRandomIntInRange(0, 0xffffff)
local Wash

local peds = {}
local blips = {}

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

--[[ function StartOpenMenuPrompt()
    -- Button Menu
    OpenMenu = Citizen.InvokeNative(0x04F97DE45A519419)
    PromptSetControlAction(OpenMenu, Config.Keys.OpenMenuKey)
    PromptSetText(OpenMenu, CreateVarString(10, 'LITERAL_STRING', T.OpenMenu))
    PromptSetEnabled(OpenMenu, true)
    PromptSetVisible(OpenMenu, true)
    PromptSetHoldMode(OpenMenu, true)
    PromptSetGroup(OpenMenu, buttons_prompt)
    PromptRegisterEnd(OpenMenu)
end ]]

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

    Wait(3000)
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
            Wait(Sleep)
        end
    end)
end

-- Blips & NPC
--[[ Citizen.CreateThread(function()
    Citizen.Wait(1000)
	for k, v in pairs(Config.BathLocations) do
        -- Blip
        if v.Blip.ShowBlip then
		    local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.Blip.Position.x, v.Blip.Position.y, v.Blip.Position.z)
    	    SetBlipSprite(blip, v.Blip.BlipSprite)
    	    SetBlipScale(blip, v.Blip.BlipScale)
    	    Citizen.InvokeNative(0x9CB1A1623062F402, blip, v.Blip.BlipName)
            table.insert(blips, blip)
        end

        -- NPC
        local hashModel = GetHashKey(v.Npc.Model)
        local npc = CreatePed(hashModel, v.Npc.Position.x, v.Npc.Position.y, v.Npc.Position.z - 1.0, v.Npc.Position.w, false, true, true, true)

        if IsModelValid(hashModel) then
            RequestModel(hashModel)
            while not HasModelLoaded(hashModel) do
                Wait(100)
            end
        end

        if not v.Npc.Animation and v.Npc.Animation then
            RequestAnimDict(v.Npc.Animation.AnimDict)
            while not HasAnimDictLoaded(v.Npc.Animation.AnimDict) do
                Citizen.Wait(100)
            end
            TaskPlayAnim(npc, v.Npc.Animation.AnimDict, v.Npc.Animation.AnimName, 1.0, -1.0, -1, 1, 0, true, 0, false, 0, false)
        end

        if v.Npc.Scale then
            SetPedScale(npc, v.Npc.Scale)
        end

        SetEntityNoCollisionEntity(PlayerPedId(), npc, false)
        SetEntityCanBeDamaged(npc, false)
        SetEntityInvincible(npc, true)
        FreezeEntityPosition(npc, true) -- NPC can't escape
        SetBlockingOfNonTemporaryEvents(npc, true) -- NPC can't be scared
        table.insert(peds, npc)
	end
end) ]]

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for k, v in pairs(blips) do
            RemoveBlip(v)
        end
    end
end)