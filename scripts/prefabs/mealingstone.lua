require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/quagmire_mealingstone.zip"),
}

local prefabs =
{
    "collapse_small",
}

local function onhammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("stone")
    inst:Remove()
end

local function onturnon(inst)
    if inst.AnimState:IsCurrentAnimation("idle") then
        inst.AnimState:PlayAnimation("proximity_loop", true)
    else
        inst.AnimState:PushAnimation("proximity_loop", true)
    end
    inst.SoundEmitter:PlaySound("dontstarve/quagmire/common/mealing_stone/proximity_LP", "loop")
end


local function onturnoff(inst)
    inst.SoundEmitter:KillSound("loop")
    inst.AnimState:PushAnimation("idle", false)
end

local function onactivate(inst)
    if inst.components.prototyper.on then
        inst.AnimState:PushAnimation("proximity_loop", true)
    else
        inst.AnimState:PushAnimation("idle", false)
    end
    --inst.SoundEmitter:PlaySound("dontstarve/quagmire/common/mealing_stone/proximity_LP")
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .4)

    inst.MiniMapEntity:SetPriority(5)
    inst.MiniMapEntity:SetIcon("quagmire_mealingstone.png")

    inst.AnimState:SetBank("quagmire_mealingstone")
    inst.AnimState:SetBuild("quagmire_mealingstone")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("structure")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("prototyper")
    inst.components.prototyper.onturnon = onturnon
    inst.components.prototyper.onturnoff = onturnoff
    inst.components.prototyper.onactivate = onactivate
    inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES.FOODPROCESSING

    inst:AddComponent("inspectable")

    inst:ListenForEvent("onbuilt", onbuilt)

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)

    return inst
end

return Prefab("mealingstone", fn, assets, prefabs),
    MakePlacer("mealingstone_placer", "quagmire_mealingstone", "quagmire_mealingstone", "idle")
