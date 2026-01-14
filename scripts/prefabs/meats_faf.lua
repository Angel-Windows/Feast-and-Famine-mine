local assets = {Asset("ANIM", "anim/meats_faf.zip"), Asset("ANIM", "anim/meats_giant_faf.zip"),
                Asset("ANIM", "anim/meats_alt_faf.zip"), Asset("ANIM", "anim/meat_rack_food_giant_faf.zip")}

local prefabs = {"rocky_meat_cooked", "rocks"}

local cooked_prefabs = {"spoiled_food"}

local function sleepymeat(inst, eater)
    if eater:HasTag("player") then
        eater:PushEvent("yawn", {
            grogginess = 4,
            knockoutduration = TUNING.BEARGER_YAWN_SLEEPTIME
        })
    elseif eater.components.sleeper ~= nil then
        eater.components.sleeper:AddSleepiness(7, TUNING.BEARGER_YAWN_SLEEPTIME)
    elseif eater.components.grogginess ~= nil then
        eater.components.grogginess:AddGrogginess(4, TUNING.BEARGER_YAWN_SLEEPTIME)
    else
        eater:PushEvent("knockedout")
    end
end

local function commonfn(anim, cookable)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("meats")
    inst.AnimState:SetBuild("meats_faf")
    inst.AnimState:PlayAnimation(anim)

    inst:AddTag("catfood")
    inst:AddTag("meat")

    if cookable then
        -- cookable (from cookable component) added to pristine state for optimization
        inst:AddTag("cookable")
    end

    MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.MEAT

    if cookable then
        inst:AddComponent("cookable")
        inst.components.cookable.product = "rocky_meat_cooked"
    end

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERFAST)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "rocks"

    MakeHauntableLaunchAndPerish(inst)

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

    inst:AddComponent("bait")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

    inst:AddComponent("tradable")
    inst.components.tradable.goldvalue = 5

    return inst
end

local function on_mine(inst, miner, workleft, workdone)
    local num_fruits_worked = math.clamp(workdone / TUNING.ROCK_FRUIT_MINES, 1, TUNING.ROCK_FRUIT_LOOT.MAX_SPAWNS)
    num_fruits_worked = math.min(num_fruits_worked, inst.components.stackable:StackSize())

    if inst.components.stackable:StackSize() > num_fruits_worked then

        if num_fruits_worked == TUNING.ROCK_FRUIT_LOOT.MAX_SPAWNS then
            -- If we got hit hard, also launch the remaining fruit stack.
            LaunchAt(inst, inst, miner, TUNING.ROCK_FRUIT_LOOT.SPEED, TUNING.ROCK_FRUIT_LOOT.HEIGHT, nil,
                TUNING.ROCK_FRUIT_LOOT.ANGLE)
        end
    end

    for _ = 1, num_fruits_worked do
        LaunchAt(SpawnPrefab("rocks"), inst, miner, TUNING.ROCK_FRUIT_LOOT.SPEED, TUNING.ROCK_FRUIT_LOOT.HEIGHT, nil,
            TUNING.ROCK_FRUIT_LOOT.ANGLE)
        if math.random() < 0.25 then
            LaunchAt(SpawnPrefab("rocks"), inst, miner, TUNING.ROCK_FRUIT_LOOT.SPEED, TUNING.ROCK_FRUIT_LOOT.HEIGHT,
                nil, TUNING.ROCK_FRUIT_LOOT.ANGLE)
        end
    end

    -- Finally, remove the actual stack items we just consumed
    local top_stack_item = inst.components.stackable:Get(num_fruits_worked)
    top_stack_item:Remove()
end

local function stack_size_changed(inst, data)
    if data ~= nil and data.stacksize ~= nil and inst.components.workable ~= nil then
        inst.components.workable:SetWorkLeft(data.stacksize * TUNING.ROCK_FRUIT_MINES)
    end
end

local function defaultfn()
    local inst = commonfn("lobster_idle", true)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.inventoryitem.imagename = "rocky_meat"

    inst.components.edible.healthvalue = -TUNING.HEALING_MED
    inst.components.edible.sanityvalue = -TUNING.SANITY_MED
    inst.components.edible.hungervalue = TUNING.CALORIES_MED
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERFAST)

    inst.components.tradable.rocktribute = 1

    inst.components.floater:SetScale({0.55, 0.5, 0.55})
    inst.components.floater:SetVerticalOffset(0.05)

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.ROCK_FRUIT_MINES * inst.components.stackable.stacksize)
    -- inst.components.workable:SetOnFinishCallback(on_mine)
    inst.components.workable:SetOnWorkCallback(on_mine)

    inst:ListenForEvent("stacksizechange", stack_size_changed)

    return inst
end

local function cookedfn()
    local inst = commonfn("lobster_cooked")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.inventoryitem.imagename = "rocky_meat_cooked"

    inst.components.edible.healthvalue = TUNING.HEALING_MEDSMALL
    inst.components.edible.hungervalue = TUNING.CALORIES_MED
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERFAST)
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst.Transform:SetScale(.85, .85, .85)

    inst.components.floater:SetSize("med")
    inst.components.floater:SetScale(0.65)

    return inst
end

local trunkprefabs = {"trunk_cooked", "spoiled_food"}

local function create_trunk()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("meats")
    inst.AnimState:SetBuild("meats_faf")
    inst.AnimState:PlayAnimation("trunk2_cooked")
    inst.Transform:SetScale(1.3, 1.3, 1.3)

    MakeInventoryFloatable(inst)

    inst:AddTag("meat")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

    inst:AddComponent("tradable")
    inst.components.tradable.goldvalue = TUNING.GOLD_VALUES.MEAT

    inst:AddComponent("edible")
    inst.components.edible.ismeat = true
    inst.components.edible.foodtype = FOODTYPE.MEAT
    inst.components.edible.healthvalue = TUNING.HEALING_LARGE
    inst.components.edible.hungervalue = TUNING.CALORIES_HUGE

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    MakeHauntableLaunchAndPerish(inst)

    return inst
end

local function create_giant(data)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("meats_giant_faf")
    inst.AnimState:SetBuild("meats_giant_faf")
    inst.AnimState:PlayAnimation(data.animname .. "_idle")

    inst:AddTag("dryable")
    inst:AddTag("meat")
    if data.monster then
        inst:AddTag("monstermeat")
    end

    MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = data.stack or TUNING.STACK_SIZE_MEDITEM

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

    inst:AddComponent("tradable")
    inst.components.tradable.goldvalue = data.gold or TUNING.GOLD_VALUES.RAREMEAT

    inst:AddComponent("edible")
    inst.components.edible.ismeat = true
    inst.components.edible.foodtype = FOODTYPE.MEAT
    inst.components.edible.healthvalue = data.health
    inst.components.edible.hungervalue = data.hunger
    inst.components.edible.sanityvalue = data.sanity

    inst:AddComponent("cookable")
    inst.components.cookable.product = data.name .. "_meat_cooked"

    inst:AddComponent("dryable")
    inst.components.dryable:SetProduct(data.dryprod or "meat_dried")
    inst.components.dryable:SetDryTime(data.dryspeed or TUNING.DRY_MED)
    inst.components.dryable:SetBuildFile("meat_rack_food_giant_faf")
    inst.components.dryable:SetDriedBuildFile("meat_rack_food")

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(data.perish)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    MakeHauntableLaunchAndPerish(inst)

    return inst
end

local deerprefabs = {"deer_meat_cooked", "spoiled_food"}

local function create_deer(anim)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank("meats_giant_faf")
        inst.AnimState:SetBuild("meats_giant_faf")
        inst.AnimState:PlayAnimation("deer_idle")

        inst:AddTag("dryable")
        inst:AddTag("meat")

        MakeInventoryFloatable(inst)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
        -- inst.components.inventoryitem.imagename = "rocky_meat_cooked"  

        inst:AddComponent("cookable")
        inst.components.cookable.product = "deer_meat_cooked"

        inst:AddComponent("dryable")
        inst.components.dryable:SetProduct("meat_dried")
        inst.components.dryable:SetDryTime(TUNING.DRY_MED)
        inst.components.dryable:SetBuildFile("meat_rack_food_giant_faf")
        inst.components.dryable:SetDriedBuildFile("meat_rack_food")

        inst:AddComponent("tradable")
        inst.components.tradable.goldvalue = TUNING.GOLD_VALUES.RAREMEAT

        inst:AddComponent("edible")
        inst.components.edible.ismeat = true
        inst.components.edible.foodtype = FOODTYPE.MEAT
        inst.components.edible.healthvalue = TUNING.HEALING_TINY
        inst.components.edible.hungervalue = TUNING.CALORIES_MED
        inst.components.edible.sanityvalue = -TUNING.SANITY_SMALL

        inst:AddComponent("perishable")
        inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
        inst.components.perishable:StartPerishing()
        inst.components.perishable.onperishreplacement = "spoiled_food"

        MakeHauntableLaunchAndPerish(inst)

        inst.OnSave = function(inst, data)
            if inst.animoverride then
                data.animoverride = inst.animoverride
            end
            if inst.imagenameoverride then
                data.imagenameoverride = inst.imagenameoverride
            end
            if inst.nameoverride then
                data.nameoverride = inst.nameoverride
            end
        end

        inst.OnLoad = function(inst, data)
            if data then
                if data.animoverride then
                    inst.AnimState:PlayAnimation(data.animoverride)
                    inst.animoverride = data.animoverride
                end
                if data.imagenameoverride then
                    inst.components.inventoryitem:ChangeImageName(data.imagenameoverride)
                    inst.imagenameoverride = data.imagenameoverride
                end
                if data.nameoverride then
                    inst.name = data.nameoverride
                    inst.nameoverride = data.nameoverride
                end
            end
        end

        return inst
    end
    return fn
end

local function create_deer_autumn(anim)
    local function fn()
        local inst = CreateEntity()

        local newinst = SpawnPrefab("deer_meat")
        -- newinst.name = STRINGS.NAMES.DEER_MEAT_AUTUMN
        newinst.components.inventoryitem:ChangeImageName("deer_meat_autumn")
        newinst.AnimState:PlayAnimation("deer2_idle")

        newinst.imagenameoverride = "deer_meat_autumn"
        newinst.animoverride = "deer2_idle"
        newinst.nameoverride = "DEER_MEAT_AUTUMN"

        inst:Remove()

        return newinst
    end
    return fn
end

local function create_deer_cooked(anim)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank("meats_giant_faf")
        inst.AnimState:SetBuild("meats_giant_faf")
        inst.AnimState:PlayAnimation("deer_cooked")

        MakeInventoryFloatable(inst)

        inst:AddTag("meat")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")

        inst:AddComponent("tradable")
        inst.components.tradable.goldvalue = TUNING.GOLD_VALUES.RAREMEAT

        inst:AddComponent("edible")
        inst.components.edible.ismeat = true
        inst.components.edible.foodtype = FOODTYPE.MEAT
        inst.components.edible.healthvalue = TUNING.HEALING_SMALL
        inst.components.edible.hungervalue = TUNING.CALORIES_MED
        inst.components.edible.sanityvalue = TUNING.SANITY_SMALL

        inst:AddComponent("perishable")
        inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
        inst.components.perishable:StartPerishing()
        inst.components.perishable.onperishreplacement = "spoiled_food"

        MakeHauntableLaunchAndPerish(inst)

        return inst
    end
    return fn
end

local function create_giant_cooked(data)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("meats_giant_faf")
    inst.AnimState:SetBuild("meats_giant_faf")
    inst.AnimState:PlayAnimation(data.animname .. "_cooked")

    MakeInventoryFloatable(inst)

    inst:AddTag("meat")
    if data.monster then
        inst:AddTag("monstermeat")
    end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = data.stack or TUNING.STACK_SIZE_MEDITEM

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

    inst:AddComponent("tradable")
    inst.components.tradable.goldvalue = data.gold or TUNING.GOLD_VALUES.RAREMEAT

    inst:AddComponent("edible")
    inst.components.edible.ismeat = true
    inst.components.edible.foodtype = FOODTYPE.MEAT
    inst.components.edible.healthvalue = data.cookhealth
    inst.components.edible.hungervalue = data.cookhunger
    inst.components.edible.sanityvalue = data.cooksanity
    inst.components.edible.temperaturedelta = data.temperature or 0
    inst.components.edible.temperatureduration = data.temperatureduration or 0
    inst.components.edible.nochill = data.nochill or nil

    inst.components.edible:SetOnEatenFn(data.cookoneaten)

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(data.cookperish)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    MakeHauntableLaunchAndPerish(inst)

    return inst
end

local function MakeMeat(data)
    local giantprefabs = {data.name .. "_meat_cooked", "spoiled_food"}

    local giantcookprefabs = {"spoiled_food"}

    local function rawfn()
        return create_giant(data)
    end

    local function cookfn()
        return create_giant_cooked(data)
    end

    return Prefab(data.name .. "_meat", rawfn, assets, giantprefabs),
        Prefab(data.name .. "_meat_cooked", cookfn, assets, giantcookprefabs)
end

local altprefabs = {"cookedmeat", "spoiled_food"}

local function create_meat_alt(meatname)
    local function fn()
        local inst = CreateEntity()

        local newinst = SpawnPrefab("meat")
        newinst.components.inventoryitem:ChangeImageName(meatname .. "_meat")
        newinst.AnimState:SetBank("meats_alt_faf")
        newinst.AnimState:SetBuild("meats_alt_faf")
        newinst.AnimState:PlayAnimation(meatname .. "_idle")

        newinst.imagenameoverride = meatname .. "_meat"
        newinst.animoverride = meatname .. "_idle"
        newinst.animbankoverride = "meats_alt_faf"
        newinst.animbuildoverride = "meats_alt_faf"

        inst:Remove()

        return newinst
    end
    return fn
end

local data = {{
    name = "bear",
    animname = "bearger",
    sanity = -TUNING.SANITY_SMALL,
    health = -TUNING.HEALING_MED,
    hunger = TUNING.CALORIES_MED,
    perish = TUNING.PERISH_FAST,
    cooksanity = 0,
    cookhealth = TUNING.HEALING_MED,
    cookhunger = TUNING.CALORIES_MED,
    cookperish = TUNING.PERISH_MED,
    cookoneaten = sleepymeat
}, {
    name = "toad",
    animname = "toadstool",
    sanity = -TUNING.SANITY_SMALL,
    health = TUNING.HEALING_TINY,
    hunger = TUNING.CALORIES_MED,
    perish = TUNING.PERISH_FAST,
    cooksanity = 0,
    cookhealth = TUNING.HEALING_SMALL,
    cookhunger = TUNING.CALORIES_MED,
    cookperish = TUNING.PERISH_MED
}, {
    name = "dragon",
    animname = "dragonfly",
    sanity = -TUNING.SANITY_SMALL,
    health = TUNING.HEALING_TINY,
    hunger = TUNING.CALORIES_MED,
    perish = TUNING.PERISH_FAST,
    cooksanity = 0,
    cookhealth = TUNING.HEALING_SMALL,
    cookhunger = TUNING.CALORIES_MED,
    cookperish = TUNING.PERISH_MED,
    cookoneaten = nil,
    temperature = TUNING.HOT_FOOD_BONUS_TEMP,
    temperatureduration = TUNING.BUFF_FOOD_TEMP_DURATION,
    nochill = true
}, {
    name = "squid",
    animname = "squid_tentacle",
    sanity = -TUNING.SANITY_MED,
    health = 0,
    hunger = TUNING.CALORIES_SMALL,
    perish = TUNING.PERISH_SUPERFAST,
    cooksanity = TUNING.SANITY_SMALL,
    cookhealth = TUNING.HEALING_SMALL,
    cookhunger = TUNING.CALORIES_SMALL,
    cookperish = TUNING.PERISH_FAST,
    dryprod = "monstermeat_dried",
    dryspeed = TUNING.DRY_FAST,
    stacksize = TUNING.STACK_SIZE_SMALLITEM,
    gold = TUNING.GOLD_VALUES.MEAT,
    monster = true
}, {
    name = "bigbird",
    animname = "giantbirds",
    sanity = -TUNING.SANITY_SMALL,
    health = TUNING.HEALING_TINY,
    hunger = TUNING.CALORIES_MED,
    perish = TUNING.PERISH_FAST,
    cooksanity = 0,
    cookhealth = TUNING.HEALING_SMALL,
    cookhunger = TUNING.CALORIES_MED,
    cookperish = TUNING.PERISH_MED
}}

local meatprefabs = {}

for k, v in pairs(data) do
    local raw, cook = MakeMeat(v)
    table.insert(meatprefabs, raw)
    table.insert(meatprefabs, cook)
end

return Prefab("rocky_meat", defaultfn, assets, prefabs), Prefab("rocky_meat_cooked", cookedfn, assets, cooked_prefabs),
    Prefab("trunk_winter_cooked", create_trunk, assets, trunkprefabs),
    Prefab("deer_meat", create_deer("deer"), assets, deerprefabs),
    Prefab("deer_meat_autumn", create_deer_autumn("deer2"), assets, deerprefabs),
    Prefab("deer_meat_cooked", create_deer_cooked("deer"), assets, cooked_prefabs),
    Prefab("antlion_meat", create_meat_alt("antlion"), assets, altprefabs),
    Prefab("beefalo_meat", create_meat_alt("beefalo"), assets, altprefabs),
    Prefab("bunnyman_meat", create_meat_alt("bunnyman"), assets, altprefabs),
    Prefab("cat_meat", create_meat_alt("cat"), assets, altprefabs),
    Prefab("goat_meat", create_meat_alt("goat"), assets, altprefabs),
    Prefab("guardian_meat", create_meat_alt("guardian"), assets, altprefabs),
    Prefab("koala_summer_meat", create_meat_alt("koala_summer"), assets, altprefabs),
    Prefab("koala_winter_meat", create_meat_alt("koala_winter"), assets, altprefabs),
    Prefab("malbatross_meat", create_meat_alt("malbatross"), assets, altprefabs),
    Prefab("moose_meat", create_meat_alt("moose"), assets, altprefabs), unpack(meatprefabs)
