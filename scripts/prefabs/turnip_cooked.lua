local assets=
{
	Asset("ANIM", "anim/turnip_cooked.zip"),
    Asset("ATLAS", "images/inventoryimages/feast_famine.xml")		
}

local prefabs = 
{
	"turnip_cooked",
	"spoiled_food",
}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeSmallPropagator(inst)	
    MakeInventoryPhysics(inst)
		
	inst.AnimState:SetBank("turnip_cooked")
	inst.AnimState:SetBuild("turnip_cooked")		
	inst.AnimState:PlayAnimation("idle")
	
	MakeInventoryFloatable(inst)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
		
	inst:AddComponent("edible")
	inst.components.edible.foodtype = FOODTYPE.VEGGIE
	inst.components.edible.healthvalue = 0
	inst.components.edible.hungervalue = TUNING.CALORIES_LARGE
	inst.components.edible.sanityvalue = 0
			
	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "turnip_cooked"	
	--inst.components.inventoryitem.atlasname = "images/inventoryimages/feast_famine.xml"

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)
		
    return inst
end

return Prefab( "common/inventory/turnip_cooked", fn, assets, prefabs )
