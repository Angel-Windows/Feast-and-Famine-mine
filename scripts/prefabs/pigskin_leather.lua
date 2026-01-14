local assets = {Asset("ANIM", "anim/meat_rack_food_faf.zip")}

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("meat_rack_food_faf")
    inst.AnimState:SetBuild("meat_rack_food_faf")
    inst.AnimState:PlayAnimation("idle_pigskin_leather")

    MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "pigskin_leather"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

    inst:AddComponent("tradable")

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("pigskin_leather", fn, assets, prefabs)
