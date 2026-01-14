require "prefabutil"

-- SAPLING --

local date_sapling_assets = {Asset("ANIM", "anim/date_fruit.zip"), Asset("ANIM", "anim/planted_hills.zip")}

local date_sapling_prefabs = {"date_tree_short"}

local function growtree(inst)
    local tree = SpawnPrefab(inst.growprefab)
    if tree then
        tree.Transform:SetPosition(inst.Transform:GetWorldPosition())
        tree:growfromseed()
        inst:Remove()
    end
end

local function stopgrowing(inst)
    inst.components.timer:StopTimer("grow")
end

startgrowing = function(inst)
    if not inst.components.timer:TimerExists("grow") then
        local growtime = GetRandomWithVariance(TUNING.PINECONE_GROWTIME.base, TUNING.PINECONE_GROWTIME.random)
        inst.components.timer:StartTimer("grow", growtime)
    end
end

local function ontimerdone(inst, data)
    if data.name == "grow" then
        growtree(inst)
    end
end

local function digup(inst, digger)
    inst.components.lootdropper:DropLoot()
    inst:Remove()
end

local function onSaplingload(inst)
    local ground_tile = TheWorld.Map:GetTileAtPoint(inst.Transform:GetWorldPosition())
    local pt = inst:GetPosition()
    local ents = #TheSim:FindEntities(pt.x, pt.y, pt.z, 30, {"oasislake"})
    if (ground_tile ~= GROUND.DESERT_DIRT) and (ground_tile ~= GROUND.DIRT) and ents < 1 then
        inst.AnimState:PlayAnimation("dirt")
        inst.AnimState:OverrideSymbol("swap_sapling", "date_fruit", "swap_sapling")
        if (ground_tile == GROUND.PEBBLEBEACH) or (ground_tile == GROUND.BEACH) then
            inst.AnimState:OverrideSymbol("dirt", "planted_hills", "tropical")
        end
    end
end

local function sapling_fn()
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        inst.AnimState:SetBank("sapling")
        inst.AnimState:SetBuild("planted_hills")
        inst.AnimState:PlayAnimation("sand")
        inst.AnimState:OverrideSymbol("swap_sapling", "date_fruit", "swap_sapling")

        inst:AddTag("plant")
        inst:AddTag("date_tree")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst.growprefab = "date_tree_short"
        inst.StartGrowing = startgrowing

        inst:AddComponent("timer")
        inst:ListenForEvent("timerdone", ontimerdone)
        startgrowing(inst)

        inst:AddComponent("inspectable")

        inst:AddComponent("lootdropper")
        inst.components.lootdropper:SetLoot({"twigs"})

        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.DIG)
        inst.components.workable:SetOnFinishCallback(digup)
        inst.components.workable:SetWorkLeft(1)

        MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
        inst:ListenForEvent("onignite", stopgrowing)
        inst:ListenForEvent("onextinguish", startgrowing)
        MakeSmallPropagator(inst)

        MakeHauntableIgnite(inst)

        inst.OnLoad = onSaplingload

        return inst
    end
    return fn
end

-- DATES --

local date_assets = {Asset("ANIM", "anim/date_fruit.zip")}

local date_prefabs = {"date_cooked", "date_pit", "spoiled_food"}

local cooked_date_prefabs = {"spoiled_food"}

local pitted_date_prefabs = {"date_sapling"}

local function pitchance(inst, eater, pos)
    if math.random() <= 0.20 then
        if eater.components.inventory ~= nil then
            eater.components.inventory:GiveItem(SpawnPrefab("date_pit"))
        else
            SpawnPrefab("date_pit").Transform:SetPosition(pos:Get())
        end
    end
end

local function plant(inst, growtime)
    local sapling = SpawnPrefab("date_sapling")
    sapling:StartGrowing()
    sapling.Transform:SetPosition(inst.Transform:GetWorldPosition())
    sapling.SoundEmitter:PlaySound("dontstarve/wilson/plant_tree")

    local ground_tile = TheWorld.Map:GetTileAtPoint(inst.Transform:GetWorldPosition())
    local pt = inst:GetPosition()
    local ents = #TheSim:FindEntities(pt.x, pt.y, pt.z, 30, {"oasislake"})
    if (ground_tile ~= GROUND.DESERT_DIRT) and (ground_tile ~= GROUND.DIRT) and ents < 1 then
        sapling.AnimState:PlayAnimation("dirt")
        sapling.AnimState:OverrideSymbol("swap_sapling", "date_fruit", "swap_sapling")
        if (ground_tile == GROUND.PEBBLEBEACH) or (ground_tile == GROUND.BEACH) then
            sapling.AnimState:OverrideSymbol("dirt", "planted_hills", "tropical")
        end
    end

    inst:Remove()
end

local function ondeploy(inst, pt)
    inst = inst.components.stackable:Get()
    inst.Transform:SetPosition(pt:Get())
    local timeToGrow = GetRandomWithVariance(TUNING.ACORN_GROWTIME.base, TUNING.ACORN_GROWTIME.random)
    plant(inst, timeToGrow)
end

local function OnLoad(inst, data)
    if data and data.growtime then
        plant(inst, data.growtime)
    end
end

local function commondatefn(anim, cookable, pit)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("date_fruit")
    inst.AnimState:SetBuild("date_fruit")
    inst.AnimState:PlayAnimation(anim)
    inst.Transform:SetScale(.7, .7, .7)

    if cookable then
        -- cookable (from cookable component) added to pristine state for optimization
        inst:AddTag("cookable")
    end

    inst:AddTag("honeyed")

    MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    if pit == nil then
        inst:AddComponent("edible")
        inst.components.edible.foodtype = FOODTYPE.VEGGIE

        if cookable then
            inst:AddComponent("cookable")
            inst.components.cookable.product = "date_cooked"
        end

        inst:AddComponent("perishable")
        inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
        inst.components.perishable:StartPerishing()
        inst.components.perishable.onperishreplacement = "spoiled_food"

        MakeHauntableLaunchAndPerish(inst)
    else

    end

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("bait")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

    inst:AddComponent("tradable")

    return inst
end

local function defaultdatefn()
    local inst = commondatefn("idle", true)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.inventoryitem.imagename = "dates"

    inst.components.edible:SetOnEatenFn(pitchance)

    inst.components.edible.healthvalue = -TUNING.HEALING_SMALL
    inst.components.edible.sanityvalue = -TUNING.SANITY_SMALL
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)

    inst.components.floater:SetScale({0.55, 0.5, 0.55})
    inst.components.floater:SetVerticalOffset(0.05)

    return inst
end

local function cookeddatefn()
    local inst = commondatefn("idle_cooked")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.inventoryitem.imagename = "dates_cooked"

    inst.components.edible.healthvalue = -TUNING.HEALING_TINY
    inst.components.edible.sanityvalue = -TUNING.SANITY_SMALL
    inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)

    inst.components.floater:SetSize("med")
    inst.components.floater:SetScale(0.65)

    return inst
end

local function pitteddatefn()
    local inst = commondatefn("idle", nil, true)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.inventoryitem.imagename = "dates"

    inst.components.tradable.rocktribute = 1

    inst.components.floater:SetScale({0.55, 0.5, 0.55})
    inst.components.floater:SetVerticalOffset(0.05)

    inst:AddComponent("deployable")
    inst.components.deployable:SetDeployMode(DEPLOYMODE.PLANT)
    inst.components.deployable.ondeploy = ondeploy

    inst.OnLoad = OnLoad

    return inst
end

return Prefab("date_sapling", sapling_fn(), date_sapling_assets, date_sapling_prefabs),
    Prefab("date", defaultdatefn, date_assets, date_prefabs),
    Prefab("date_cooked", cookeddatefn, date_assets, cooked_date_prefabs),
    Prefab("date_pit", pitteddatefn, date_assets, pitted_date_prefabs),
    MakePlacer("date_pit_placer", "sapling", "planted_hills", "sand", nil, nil, nil, nil, nil, nil, function(inst)
        inst.AnimState:OverrideSymbol("swap_sapling", "date_fruit", "swap_sapling")
    end)
