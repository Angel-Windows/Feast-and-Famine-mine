local assets = {Asset("ANIM", "anim/rooster_house.zip"), Asset("SOUNDPACKAGE", "sound/chickenfamily.fev"),
                Asset("SOUND", "sound/chickenfamily.fsb")}

local prefabs = {"chicken_trader"}

local function OnUpdateWindow(window, inst, snow)
    if inst:HasTag("burnt") then
        inst._window = nil
        window:Remove()
    elseif inst.Light:IsEnabled() then
        if not window._shown then
            window._shown = true

            window:Show()
        end
    elseif window._shown then
        window._shown = false
        window:Hide()
    end
end

local function LightsOn(inst)
    if not inst:HasTag("burnt") and not inst.lightson then
        inst.Light:Enable(true)
        inst.SoundEmitter:PlaySound("dontstarve/pig/pighut_lighton")
        inst.lightson = true

        if inst._window ~= nil then
            inst._window.AnimState:PlayAnimation("window", true)
            inst._window:Show()
        end
    end
end

local function LightsOff(inst)
    if not inst:HasTag("burnt") and inst.lightson then
        inst.Light:Enable(false)
        inst.SoundEmitter:PlaySound("dontstarve/pig/pighut_lightoff")
        inst.lightson = false
        if inst._window ~= nil then
            inst._window:Hide()
        end
    end
end

local function onfar(inst)
    if not inst:HasTag("burnt") and inst.components.spawner:IsOccupied() then
        LightsOn(inst)
    end
end

local function onnear(inst)
    if not inst:HasTag("burnt") and inst.components.spawner:IsOccupied() then
        LightsOff(inst)
    end
end

local function getstatus(inst)
    return (inst.components.spawner ~= nil and inst.components.spawner:IsOccupied() and
               (inst.lightson and "FULL" or "LIGHTSOUT")) or nil
end

local function onnormal(child)
    if child.parent ~= nil then
        child.parent.SoundEmitter:KillSound("roostersound")
        child.parent.SoundEmitter:PlaySound("chickenfamily/chickenfamily/roostersleephouse", "roostersound", 0.1)
    end
end

local function onoccupieddoortask(inst)
    inst.doortask = nil
    if not inst.components.playerprox:IsPlayerClose() then
        LightsOn(inst)
    end
end

local function onoccupied(inst, child)
    inst.SoundEmitter:PlaySound("chickenfamily/chickenfamily/roostersleephouse", "roostersound", 0.1)
    inst.SoundEmitter:PlaySound("dontstarve/common/pighouse_door")

    if inst.doortask ~= nil then
        inst.doortask:Cancel()
    end
    inst.doortask = inst:DoTaskInTime(1, onoccupieddoortask)
end

local function onvacate(inst, child)
    if inst.doortask ~= nil then
        inst.doortask:Cancel()
        inst.doortask = nil
    end
    inst.SoundEmitter:PlaySound("dontstarve/common/pighouse_door")
    inst.SoundEmitter:KillSound("roostersound")
    LightsOff(inst)

    if child ~= nil then
        if child.components.health ~= nil then
            child.components.health:SetPercent(1)
        end
    end
end

local function onstartdaydoortask(inst)
    inst.doortask = nil
    inst.components.spawner:ReleaseChild()
end

local function onstartdaylighttask(inst)
    if inst.LightWatcher:GetLightValue() > 0.8 then
        inst.doortask = inst:DoTaskInTime(1 + math.random() * 2, onstartdaydoortask)
    elseif TheWorld.state.iscaveday then
        inst.doortask = inst:DoTaskInTime(1 + math.random() * 2, onstartdaylighttask)
    else
        inst.doortask = nil
    end
end

local function OnStartDay(inst)
    if inst.components.spawner:IsOccupied() then
        if inst.doortask ~= nil then
            inst.doortask:Cancel()
        end
        inst.SoundEmitter:PlaySound("chickenfamily/chickenfamily/roosterwake")
        inst.SoundEmitter:KillSound("roostersound")
        inst.doortask = inst:DoTaskInTime(1 + math.random() * 2, onstartdaylighttask)
    end
end

local function spawncheckday(inst)
    inst.inittask = nil
    inst:WatchWorldState("startcaveday", OnStartDay)
    if inst.components.spawner ~= nil and inst.components.spawner:IsOccupied() then
        if TheWorld.state.iscaveday then
            inst.components.spawner:ReleaseChild()
        else
            inst.components.playerprox:ForceUpdate()
            onoccupieddoortask(inst)
        end
    end
end

local function oninit(inst)
    inst.inittask = inst:DoTaskInTime(math.random(), spawncheckday)
    if inst.components.spawner ~= nil and inst.components.spawner.child == nil and inst.components.spawner.childname ~=
        nil and not inst.components.spawner:IsSpawnPending() then
        local child = SpawnPrefab(inst.components.spawner.childname)
        if child ~= nil then
            inst.components.spawner:TakeOwnership(child)
            inst.components.spawner:GoHome(child)
        end
    end
end

local function MakeWindow()
    local inst = CreateEntity("Chickenhouse.MakeWindow")

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst:AddTag("DECOR")
    inst:AddTag("NOCLICK")
    --[[Non-networked entity]]
    inst.persists = false

    inst.AnimState:SetBank("rooster_house")
    inst.AnimState:SetBuild("rooster_house")
    inst.AnimState:PlayAnimation("window")
    inst.AnimState:SetLightOverride(.6)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetFinalOffset(1)

    inst:Hide()

    return inst
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddLight()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
    inst.entity:AddLightWatcher()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("minimap_rooster.tex")

    inst.Light:SetFalloff(1)
    inst.Light:SetIntensity(.5)
    inst.Light:SetRadius(1)
    inst.Light:Enable(false)
    inst.Light:SetColour(180 / 255, 195 / 255, 50 / 255)

    inst.AnimState:SetBank("rooster_house")
    inst.AnimState:SetBuild("rooster_house")
    inst.AnimState:PlayAnimation("idle", true)

    -- inst.SoundEmitter:PlaySound("chickenfamily/chickenfamily/roostersleephouse", "roostersound",  0.1)

    inst:AddTag("structure")
    inst:AddTag("chickenhouse")

    MakeSnowCoveredPristine(inst)

    if not TheNet:IsDedicated() then
        inst._window = MakeWindow()
        inst._window.entity:SetParent(inst.entity)
        if not TheWorld.ismastersim then
            inst._window:DoPeriodicTask(FRAMES, OnUpdateWindow, nil, inst)
        end
    end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("spawner")
    inst.components.spawner:Configure("chicken_trader", TUNING.TOTAL_DAY_TIME)
    inst.components.spawner.onoccupied = onoccupied
    inst.components.spawner.onvacate = onvacate
    inst.components.spawner:CancelSpawning()

    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(10, 13)
    inst.components.playerprox:SetOnPlayerNear(onnear)
    inst.components.playerprox:SetOnPlayerFar(onfar)

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = getstatus

    MakeSnowCovered(inst)

    inst.inittask = inst:DoTaskInTime(0, oninit)

    return inst
end

return Prefab("chickenhouse", fn, assets, prefabs)
