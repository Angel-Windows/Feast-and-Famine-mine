local assets = {Asset("ANIM", "anim/flour.zip")}

local prefabs = {"wetgoop"}

local function wettest(inst)
    if inst.components.inventoryitem:GetMoisture() >= 35 then
        inst.components.perishable:SetLocalMultiplier(8)
    else
        inst.components.perishable:SetLocalMultiplier(1)
    end
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("flour")
    inst.AnimState:SetBuild("flour")
    inst.AnimState:PlayAnimation("idle")

    MakeInventoryFloatable(inst)

    inst:AddTag("show_spoilage")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "quagmire_flour"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERSLOW)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "wetgoop"

    inst:AddComponent("tradable")

    inst:ListenForEvent("wetnesschange", wettest)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("common/inventory/flour", fn, assets, prefabs)
