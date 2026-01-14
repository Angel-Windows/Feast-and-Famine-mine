require "prefabutil"

local assets = {Asset("ANIM", "anim/grass.zip"), Asset("ANIM", "anim/wheat_wild_build.zip"),
                Asset("ANIM", "anim/wheat_dug.zip"), Asset("ANIM", "anim/grass1.zip"),
                Asset("SOUND", "sound/common.fsb")}

local prefabs = {"wheat", "cutgrass", "dug_wheatgrass"}

local function onpickedfn(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds")
    inst.AnimState:PlayAnimation("picking")
    inst.AnimState:PushAnimation("picked")
    --[[
    if inst.components.lootdropper ~= nil then
        --if math.random() <= 0.1 then 
            --inst.components.lootdropper:SpawnLootPrefab("wheat_seeds")
        --end
    end]]
end

local function dig_up(inst, worker)
    if inst.components.pickable ~= nil and inst.components.lootdropper ~= nil then
        local withered = inst.components.witherable ~= nil and inst.components.witherable:IsWithered()

        if inst.components.pickable:CanBePicked() then
            inst.components.lootdropper:DropLoot()
        end

        inst.components.lootdropper:SpawnLootPrefab(withered and "cutgrass" or "dug_wheatgrass")
    end
    inst:Remove()
end

local function onregenfn(inst)
    inst.AnimState:PlayAnimation("grow")
    inst.AnimState:PushAnimation("idle", true)
end

local function makeemptyfn(inst)
    inst.AnimState:PlayAnimation("picked")
end

local function makebarrenfn(inst, wasempty)
    if not POPULATING and (inst.components.witherable ~= nil and inst.components.witherable:IsWithered()) then
        inst.AnimState:PlayAnimation(wasempty and "empty_to_dead" or "full_to_dead")
        inst.AnimState:PushAnimation("idle_dead", false)
    else
        inst.AnimState:PlayAnimation("idle_dead")
    end
end

local function ontransplantfn(inst)
    inst.components.pickable:MakeBarren()
end

local function ondeploy(inst, pt, deployer)
    local tree = SpawnPrefab("wheatgrass")
    if tree ~= nil then
        tree.Transform:SetPosition(pt:Get())
        inst.components.stackable:Get():Remove()
        if tree.components.pickable ~= nil then
            tree.components.pickable:OnTransplant()
        end
        if deployer ~= nil and deployer.SoundEmitter ~= nil then
            -- V2C: WHY?!! because many of the plantables don't
            --     have SoundEmitter, and we don't want to add
            --     one just for this sound!
            deployer.SoundEmitter:PlaySound("dontstarve/common/plant")
        end
    end
end

local function dugfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    -- inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst:AddTag("deployedplant")

    inst.AnimState:SetBank("grass")
    inst.AnimState:SetBuild("grass1")
    inst.AnimState:PlayAnimation("dropped")
    inst.AnimState:OverrideSymbol("grass_dug", "wheat_dug", "wheat_dug")

    MakeInventoryFloatable(inst, "med", 0.1, 0.92)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeMediumBurnable(inst, TUNING.LARGE_BURNTIME)
    MakeSmallPropagator(inst)

    MakeHauntableLaunchAndIgnite(inst)

    inst:AddComponent("deployable")
    -- inst.components.deployable:SetDeployMode(DEPLOYMODE.ANYWHERE)
    inst.components.deployable.ondeploy = ondeploy
    inst.components.deployable:SetDeployMode(DEPLOYMODE.PLANT)
    inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.MEDIUM)

    ---------------------
    return inst
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("minimap_wheatgrass.tex")

    inst:AddTag("plant")
    inst:AddTag("silviculture") -- for silviculture book
    -- inst:AddTag("renewable")
    inst:AddTag("wheatgrass")
    inst:AddTag("witherable")

    inst.AnimState:SetBank("grass")
    inst.AnimState:SetBuild("wheat_wild_build")
    inst.AnimState:PlayAnimation("idle", true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.AnimState:SetTime(math.random() * 2)
    local color = 0.75 + math.random() * 0.25
    inst.AnimState:SetMultColour(color, color, color, 1)

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_reeds"
    -- inst.components.pickable:SetUp("wheat", TUNING.REEDS_REGROW_TIME) -- We handle this with the lootdropper instead to allow for multiple products
    inst.components.pickable:SetUp(nil, TUNING.REEDS_REGROW_TIME)
    inst.components.pickable.use_lootdropper_for_product = true
    inst.components.pickable.onregenfn = onregenfn
    inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.makeemptyfn = makeemptyfn
    inst.components.pickable.SetRegenTime = 120
    inst.components.pickable.makebarrenfn = makebarrenfn
    inst.components.pickable.max_cycles = 20
    inst.components.pickable.cycles_left = 20
    inst.components.pickable.ontransplantfn = ontransplantfn

    inst:AddComponent("witherable")

    inst:AddComponent("inspectable")

    ---------------------        
    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({"wheat", "cutgrass"})

    MakeSmallBurnable(inst, TUNING.SMALL_FUEL)
    MakeSmallPropagator(inst)
    MakeNoGrowInWinter(inst)
    MakeHauntableIgnite(inst)
    ---------------------   

    if not GetGameModeProperty("disable_transplanting") then
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.DIG)
        inst.components.workable:SetOnFinishCallback(dig_up)
        inst.components.workable:SetWorkLeft(1)
    end

    return inst
end

return Prefab("wheatgrass", fn, assets, prefabs), Prefab("dug_wheatgrass", dugfn, assets, prefabs),
    MakePlacer("dug_wheatgrass_placer", "grass", "wheat_wild_build", "idle")
