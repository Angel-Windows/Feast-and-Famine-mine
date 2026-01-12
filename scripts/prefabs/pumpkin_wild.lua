local assets =
{
    Asset("ANIM", "anim/pumpkin_wild.zip"),
}

local prefabs =
{
    "pumpkin",
}

local function onpicked(inst)
    TheWorld:PushEvent("beginregrowth", inst) -- TO DO
    inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("pumpkin_wild")
    inst.AnimState:SetBuild("pumpkin_wild")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetRayTestOnBB(true)

    inst:AddTag("flower")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst.name = STRINGS.NAMES.PUMPKIN

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_plants"
    inst.components.pickable:SetUp("pumpkin", 10)
    inst.components.pickable.onpickedfn = onpicked

    inst.components.pickable.quickpick = true

    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)

	inst:AddComponent("halloweenmoonmutable")
	inst.components.halloweenmoonmutable:SetPrefabMutated("pumpkin_lantern")

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    return inst
end

return Prefab("pumpkin_wild", fn, assets)