local assets =
{
	Asset("ANIM", "anim/stick_pretzels.zip"),
}

local prefabs = 
{
	"spoiled_food",
}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("stick_pretzels")
	inst.AnimState:SetBuild("stick_pretzels")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
    
	MakeInventoryFloatable(inst)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
	
	inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "stick_pretzels"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL

    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.ROUGHAGE
	inst.components.edible.secondaryfoodtype = FOODTYPE.WOOD
    inst.components.edible.healthvalue = TUNING.HEALING_TINY/2
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY*6

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("bait")

	inst:AddComponent("tradable")

	inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_PRESERVED)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

	
	MakeHauntableLaunchAndPerish(inst)
		
    return inst
end

return Prefab( "common/inventory/stick_pretzels", fn, assets, prefabs )