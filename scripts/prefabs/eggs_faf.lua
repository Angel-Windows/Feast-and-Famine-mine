local assets = {Asset("ANIM", "anim/bird_eggs_faf.zip"), Asset("ANIM", "anim/penguin_egg.zip")}

local monster_prefabs = {"egg_monster_cooked", "rottenegg"}

local cooked_monster_prefabs = {"spoiled_food"}

local plant_prefabs = {"egg_plant_cooked", "spoiled_food"}

local cooked_plant_prefabs = {"spoiled_food"}

local penguin_prefabs = {"bird_egg", "egg_cooked", "rottenegg"}

local function commonmonsterfn(anim, cookable)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("eggs")
    inst.AnimState:SetBuild("bird_eggs_faf")
    inst.AnimState:PlayAnimation(anim)

    inst:AddTag("catfood")
    inst:AddTag("monstermeat")

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
        inst.components.cookable.product = "egg_monster_cooked"
    end

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "rottenegg"

    MakeHauntableLaunchAndPerish(inst)

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("bait")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

    inst:AddComponent("tradable")
    inst.components.tradable.goldvalue = 1

    return inst
end

local function defaultmonsterfn()
    local inst = commonmonsterfn("monster_idle", true)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.inventoryitem.imagename = "egg_monster"

    inst.components.edible.healthvalue = -TUNING.HEALING_SMALL
    inst.components.edible.sanityvalue = -TUNING.SANITY_SMALL
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)

    inst.components.tradable.rocktribute = 1

    inst.components.floater:SetScale({0.55, 0.5, 0.55})
    inst.components.floater:SetVerticalOffset(0.05)

    return inst
end

local function cookedmonsterfn()
    local inst = commonmonsterfn("monster_cooked")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.inventoryitem.imagename = "egg_monster_cooked"

    inst.components.edible.healthvalue = -TUNING.HEALING_TINY
    inst.components.edible.sanityvalue = -TUNING.SANITY_SMALL
    inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst.components.floater:SetSize("med")
    inst.components.floater:SetScale(0.65)

    return inst
end

local function commonplantfn(anim, cookable)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("eggs")
    inst.AnimState:SetBuild("bird_eggs_faf")
    inst.AnimState:PlayAnimation(anim)

    inst:AddTag("catfood")

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
        inst.components.cookable.product = "egg_plant_cooked"
    end

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    MakeHauntableLaunchAndPerish(inst)

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("bait")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

    inst:AddComponent("tradable")
    inst.components.tradable.goldvalue = 1

    return inst
end

local function defaultplantfn()
    local inst = commonplantfn("plant_idle", true)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.inventoryitem.imagename = "egg_plant"

    inst.components.edible.hungervalue = TUNING.CALORIES_TINY
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)

    inst.components.floater:SetScale({0.55, 0.5, 0.55})
    inst.components.floater:SetVerticalOffset(0.05)

    return inst
end

local function cookedplantfn()
    local inst = commonplantfn("plant_cooked")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.inventoryitem.imagename = "egg_plant_cooked"

    inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst.components.floater:SetSize("med")
    inst.components.floater:SetScale(0.65)

    return inst
end

local function defaultpengfn2(swapprefab)
    local function fn()
        local inst = CreateEntity()

        local newinst = SpawnPrefab(swapprefab)
        newinst.AnimState:SetBank("penguin_egg")
        newinst.AnimState:SetBuild("penguin_egg")
        newinst.AnimState:PlayAnimation("idle")
        newinst.components.inventoryitem:ChangeImageName("egg_pengull")

        newinst.imagenameoverride = "egg_pengull"
        newinst.animoverride = "idle"
        newinst.animbankoverride = "penguin_egg"
        newinst.animbuildoverride = "penguin_egg"
        -- newinst.displaynamefn = "Pengull Egg"

        inst:Remove()

        return newinst
    end
    return fn
end

return Prefab("egg_pengull", defaultpengfn2("bird_egg"), assets, penguin_prefabs),
    Prefab("egg_monster", defaultmonsterfn, assets, monster_prefabs),
    Prefab("egg_monster_cooked", cookedmonsterfn, assets, cooked_monster_prefabs),
    Prefab("egg_plant", defaultplantfn, assets, plant_prefabs),
    Prefab("egg_plant_cooked", cookedplantfn, assets, cooked_plant_prefabs)
