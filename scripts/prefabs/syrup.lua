local assets =
{
	Asset("ANIM", "anim/syrup.zip"),
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
	
	inst.AnimState:SetBank("syrup")
	inst.AnimState:SetBuild("syrup")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
    
	MakeInventoryFloatable(inst)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
	
	inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "syrup"

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("bait")

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)
		
    return inst
end

return Prefab( "common/inventory/syrup", fn, assets, prefabs )