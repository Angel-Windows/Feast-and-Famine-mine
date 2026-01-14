local assets = {Asset("ANIM", "anim/mushroom_tree_chunks.zip")}

local function redpoison(inst, eater)
    if math.random() <= 0.01 and not (eater.components.health ~= nil and eater.components.health:IsDead()) and
        not eater:HasTag("playerghost") and not eater:HasTag("plantkin") then
        if eater:HasTag("player") then
            eater:PushEvent("death", {
                cause = "red_chunk_bloom_death"
            })
        else
            eater.components.health:Kill()
        end
    end
end

local function mushbloom(inst)
    local oldpercent = inst.components.perishable:GetPercent()
    if oldpercent ~= nil then
        local goop = SpawnPrefab(inst.prefab .. "_bloom")
        if goop ~= nil then
            if goop.components.stackable ~= nil and inst.components.stackable ~= nil then
                goop.components.stackable:SetStackSize(inst.components.stackable.stacksize)
            end
            local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner or nil
            local holder = owner ~= nil and (owner.components.inventory or owner.components.container) or nil
            if holder ~= nil then
                local slot = holder:GetItemSlot(inst)
                inst:Remove()
                holder:GiveItem(goop, slot)
                goop.components.perishable:SetPercent(oldpercent)
            else
                local x, y, z = inst.Transform:GetWorldPosition()
                inst:Remove()
                SpawnPrefab("small_puff").Transform:SetPosition(x, y, z)
                goop.Transform:SetPosition(x, y, z)
                goop.components.perishable:SetPercent(oldpercent)
            end
        end
    end
end

local function chunkcommonfn(data)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("mushroom_tree_chunks")
    inst.AnimState:SetBuild("mushroom_tree_chunks")
    inst.AnimState:PlayAnimation(data.animname .. "_dry")

    -- cookable (from cookable component) added to pristine state for optimization
    inst:AddTag("cookable")
    inst:AddTag("mushroom")

    MakeInventoryFloatable(inst, "small", 0.1, 0.88)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

    inst:AddComponent("tradable")
    inst:AddComponent("inspectable")

    MakeSmallBurnable(inst, TUNING.TINY_BURNTIME)
    MakeSmallPropagator(inst)
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = data.animname .. "_chunk"

    -- this is where it gets interesting
    inst:AddComponent("edible")
    inst.components.edible.healthvalue = data.health
    inst.components.edible.hungervalue = data.hunger
    inst.components.edible.sanityvalue = data.sanity
    inst.components.edible.foodtype = FOODTYPE.VEGGIE

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    MakeHauntableLaunchAndPerish(inst)

    inst:AddComponent("cookable")
    inst.components.cookable.product = data.cookedloot

    inst:WatchWorldState("is" .. data.season, mushbloom)
    if TheWorld.state.season == data.season then
        inst:ListenForEvent("ondropped", mushbloom)
    end

    return inst
end

local function bloomcommonfn(data)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("mushroom_tree_chunks")
    inst.AnimState:SetBuild("mushroom_tree_chunks")
    inst.AnimState:PlayAnimation(data.animname .. "_wet")

    inst:AddTag("mushroom")

    MakeInventoryFloatable(inst, "small", 0.1, 0.88)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

    inst:AddComponent("tradable")
    inst:AddComponent("inspectable")

    MakeSmallBurnable(inst, TUNING.TINY_BURNTIME)
    MakeSmallPropagator(inst)
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = data.animname .. "_chunk_bloom"

    -- this is where it gets interesting
    inst:AddComponent("edible")
    inst.components.edible.healthvalue = data.bloomhealth
    inst.components.edible.hungervalue = data.bloomhunger
    inst.components.edible.sanityvalue = data.bloomsanity
    inst.components.edible.foodtype = FOODTYPE.VEGGIE

    if data.animname == "red" then
        inst.components.edible:SetOnEatenFn(redpoison)
    end

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_TWO_DAY)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = data.spore

    MakeHauntableLaunchAndPerish(inst)

    return inst
end

local function MakeMushroom(data)
    local prefabs = {data.cookedloot, "spoiled_food", "small_puff"}

    local prefabs2 = {data.spore}

    local function chunkfn()
        return chunkcommonfn(data)
    end

    local function bloomfn()
        return bloomcommonfn(data)
    end

    return Prefab(data.animname .. "_chunk", chunkfn, assets, prefabs),
        Prefab(data.animname .. "_chunk_bloom", bloomfn, assets, prefabs2)
end

local data = {{
    animname = "red",
    cookedloot = "red_cap_cooked",
    sanity = 0,
    health = -TUNING.HEALING_MED,
    hunger = TUNING.CALORIES_SMALL,
    bloomsanity = 0,
    bloomhealth = -TUNING.HEALING_MEDSMALL,
    bloomhunger = TUNING.CALORIES_MED,
    spore = "spore_medium",
    season = SEASONS.SUMMER
}, {
    animname = "green",
    cookedloot = "green_cap_cooked",
    sanity = -TUNING.SANITY_HUGE,
    health = 0,
    hunger = TUNING.CALORIES_SMALL,
    bloomsanity = -TUNING.SANITY_HUGE * 1.5,
    bloomhealth = 0,
    bloomhunger = 0,
    spore = "spore_small",
    season = SEASONS.SPRING
}, {
    animname = "blue",
    cookedloot = "blue_cap_cooked",
    sanity = -TUNING.SANITY_MED,
    health = TUNING.HEALING_MED,
    hunger = TUNING.CALORIES_SMALL,
    bloomsanity = -TUNING.SANITY_MEDLARGE,
    bloomhealth = TUNING.HEALING_MEDLARGE,
    bloomhunger = 0,
    spore = "spore_tall",
    season = SEASONS.WINTER
}}

local prefabs = {}

for k, v in pairs(data) do
    local chunk, bloom = MakeMushroom(v)
    table.insert(prefabs, chunk)
    table.insert(prefabs, bloom)
end

return unpack(prefabs)
