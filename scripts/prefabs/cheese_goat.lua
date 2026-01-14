local assets = {Asset("ANIM", "anim/cheese_goat.zip")}

local prefabs = {"spoiled_food"}

local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("cheese_goat")
    inst.AnimState:SetBuild("cheese_goat")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("preparedfood")

    MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "cheese_goat"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL

    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.GOODIES
    inst.components.edible.healthvalue = TUNING.HEALING_SMALL
    inst.components.edible.hungervalue = TUNING.CALORIES_SMALL * 3
    inst.components.edible.sanityvalue = TUNING.SANITY_TINY

    inst:AddComponent("tradable")
    inst.components.tradable.goldvalue = TUNING.GOLD_VALUES.MEAT

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst:AddComponent("bait")

    MakeHauntableLaunchAndPerish(inst)

    return inst
end

return Prefab("common/inventory/cheese_goat", fn, assets, prefabs)
