local assets = {Asset("ANIM", "anim/pasta_wet.zip")}

local prefabs = {"spoiled_food"}

local function CreateNoodle(noodlieness, test)
    local function fn(Sim)
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)
        MakeSmallBurnable(inst)
        MakeSmallPropagator(inst)

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank("pasta_wet")
        inst.AnimState:SetBuild("pasta_wet")
        inst.AnimState:PlayAnimation("idle_" .. noodlieness)

        MakeInventoryFloatable(inst)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")

        if test ~= nil then
            inst:AddComponent("edible")
            inst.components.edible.foodtype = FOODTYPE.VEGGIE

            inst:AddComponent("perishable")
            inst.components.perishable:StartPerishing()
            inst.components.perishable.onperishreplacement = "spoiled_food"
            inst.components.edible.healthvalue = 0
            inst.components.edible.sanityvalue = -TUNING.SANITY_SMALL
            inst.components.edible.hungervalue = -TUNING.CALORIES_MED
            inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
        end

        if test ~= nil then
            inst:AddComponent("dryable")
            inst.components.dryable:SetProduct("pasta_dry")
            inst.components.dryable:SetDryTime(TUNING.DRY_FAST)
            inst.components.dryable:SetBuildFile("meat_rack_food_faf")
        end

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.imagename = "pasta_" .. noodlieness

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

        inst:AddComponent("bait")

        MakeHauntableLaunchAndPerish(inst)

        return inst
    end
    return Prefab("pasta_" .. noodlieness, fn, assets, prefabs)
end

return CreateNoodle("wet", true), CreateNoodle("dry", nil)
