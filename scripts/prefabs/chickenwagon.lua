local assets = {Asset("ANIM", "anim/quagmire_mermcart.zip")}

local prefabs = {"chicken"}

local function StartSpawning(inst)
    if not TheWorld.state.iswinter and inst.components.childspawner ~= nil then
        inst.components.childspawner:StartSpawning()
    end
end

local function StopSpawning(inst)
    if inst.components.childspawner ~= nil then
        inst.components.childspawner:StopSpawning()
    end
end

local function OnSpawned(inst, child)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds")
    if TheWorld.state.isday and inst.components.childspawner ~= nil and
        inst.components.childspawner:CountChildrenOutside() >= 1 and child.components.combat.target == nil then
        StopSpawning(inst)
    end
end

local function OnIsDay(inst, isday)
    if isday then
        StartSpawning(inst)
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.AnimState:SetBank("quagmire_mermcart")
    inst.AnimState:SetBuild("quagmire_mermcart")
    inst.AnimState:PlayAnimation("idle1")

    inst:AddTag("structure")
    inst:AddTag("antlion_sinkhole_blocker")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("childspawner")
    inst.components.childspawner.childname = "chicken"
    inst.components.childspawner:SetSpawnedFn(OnSpawned)
    inst.components.childspawner:SetRegenPeriod(TUNING.TOTAL_DAY_TIME * 4)
    inst.components.childspawner:SetSpawnPeriod(10)
    inst.components.childspawner:SetMaxChildren(TUNING.MERMHOUSE_MERMS)

    inst.components.childspawner.emergencychildname = "chicken"
    inst.components.childspawner:SetEmergencyRadius(TUNING.MERMHOUSE_EMERGENCY_RADIUS)
    inst.components.childspawner:SetMaxEmergencyChildren(TUNING.MERMHOUSE_EMERGENCY_MERMS)

    inst:WatchWorldState("isday", OnIsDay)

    StartSpawning(inst)

    inst:AddComponent("inspectable")

    return inst
end

return Prefab("chickenwagon", fn, assets, prefabs)
