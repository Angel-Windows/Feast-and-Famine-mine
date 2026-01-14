local assets = {Asset("ANIM", "anim/wheat.zip"), Asset("ANIM", "anim/turnip.zip")}

local prefabs = {"turnip_cooked", "spoiled_food"}

local function FeastCrops(veg, bank, cooked, test, stack)

    local function fn(Sim)
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeSmallPropagator(inst)
        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank(bank)
        inst.AnimState:SetBuild(veg)
        inst.AnimState:PlayAnimation("idle")

        MakeInventoryFloatable(inst)

        if test ~= true then
            inst:AddTag("show_spoilage")
        end

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("edible")

        if test == true then
            inst.components.edible.foodtype = FOODTYPE.VEGGIE
            inst.components.edible.healthvalue = 0
            inst.components.edible.hungervalue = TUNING.CALORIES_LARGE
            inst.components.edible.sanityvalue = 0
        else
            inst.components.edible.foodtype = FOODTYPE.ROUGHAGE
            inst.components.edible.healthvalue = 0
            inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
            inst.components.edible.sanityvalue = 0
        end

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.imagename = "quagmire_" .. tostring(veg)

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = stack

        inst:AddComponent("perishable")
        inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
        inst.components.perishable:StartPerishing()
        inst.components.perishable.onperishreplacement = "spoiled_food"

        if test == true then
            inst:AddComponent("cookable")
            inst.components.cookable.product = cooked
        end

        inst:AddComponent("tradable")

        MakeHauntableLaunchAndPerish(inst)

        return inst
    end

    return Prefab("common/inventory/" .. tostring(veg), fn, assets, prefabs)
end

return FeastCrops("wheat", "quagmire_wheat", "ash", false, TUNING.STACK_SIZE_SMALLITEM),
    FeastCrops("turnip", "turnip", "turnip_cooked", true, TUNING.STACK_SIZE_MEDITEM)
