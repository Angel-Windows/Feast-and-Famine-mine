local assets =
{
    Asset("ANIM", "anim/tree_oasispalm_small.zip"),
    Asset("ANIM", "anim/tree_oasispalm_build.zip"),

    Asset("SOUND", "sound/forest.fsb"),
    --Asset("MINIMAP_IMAGE", "evergreen_lumpy"),
    --Asset("MINIMAP_IMAGE", "evergreen_burnt"),
    --Asset("MINIMAP_IMAGE", "evergreen_stump"),
}

local prefabs =
{
    "log",
    "date",
    "charcoal",
    "pine_needles_chop",
    "small_puff",
}

local builds =
{
    date = {
        file="tree_oasispalm_build",
        file_bank = "datepalm",
        prefab_name="date_tree",
        regrowth_product="date_sapling",
        regrowth_tuning=TUNING.EVERGREEN_REGROWTH,
        grow_times=TUNING.EVERGREEN_GROW_TIME,
        normal_loot = {"log", "log"},
        short_loot = {"log"},
        tall_loot = {"log", "log", "log"},
        chop_camshake_delay=0.4,
    },
}

local function makeanims(stage)
    return {
        idle="idle_"..stage,
        sway1="sway1_"..stage,
        sway2="sway2_"..stage,
        chop="chop_"..stage,
        fallleft="fallleft_"..stage,
        fallright="fallright_"..stage,
        stump="stump_"..stage,
        burning="burning_loop_"..stage,
        burnt="burnt_"..stage,
        chop_burnt="chop_burnt_"..stage,
        idle_chop_burnt="idle_chop_burnt_"..stage,
    }
end

local short_anims = makeanims("short")
local tall_anims = makeanims("tall")
local normal_anims = makeanims("normal")
local old_anims =
{
    idle="idle_old",
    sway1="idle_old",
    sway2="idle_old",
    chop="chop_old",
    fallleft="chop_old",
    fallright="chop_old",
    stump="stump_old",
    burning="idle_olds",
    burnt="burnt_tall",
    chop_burnt="chop_burnt_tall",
    idle_chop_burnt="idle_chop_burnt_tall",
}

local function dig_up_stump(inst, chopper)
    inst.components.lootdropper:SpawnLootPrefab("log")
    inst:Remove()
end

local function chop_down_burnt_tree(inst, chopper)
    inst:RemoveComponent("workable")
    inst.SoundEmitter:PlaySound("dontstarve/forest/treeCrumble")
    if not (chopper ~= nil and chopper:HasTag("playerghost")) then
        inst.SoundEmitter:PlaySound("dontstarve/wilson/use_axe_tree")
    end
    inst.AnimState:PlayAnimation(inst.anims.chop_burnt)
    RemovePhysicsColliders(inst)
    inst:ListenForEvent("animover", inst.Remove)
    inst.components.lootdropper:SpawnLootPrefab("charcoal")
    inst.components.lootdropper:DropLoot()
end

local function GetBuild(inst)
    return builds[inst.build] or builds["normal"]
end

local function OnBurnt(inst, immediate)
    local function changes()
        if inst.components.burnable ~= nil then
            inst.components.burnable:Extinguish()
        end
        inst:RemoveComponent("burnable")
        inst:RemoveComponent("propagator")
        inst:RemoveComponent("growable")
        inst:RemoveComponent("hauntable")

        inst:RemoveTag("shelter")
        MakeHauntableWork(inst)

        inst.components.lootdropper:SetLoot({})

        if inst.components.workable then
            inst.components.workable:SetWorkLeft(1)
            inst.components.workable:SetOnWorkCallback(nil)
            inst.components.workable:SetOnFinishCallback(chop_down_burnt_tree)
        end
    end

    if immediate then
        changes()
    else
        inst:DoTaskInTime(.5, changes)
    end
    inst.AnimState:PlayAnimation(inst.anims.burnt, true)

    inst.AnimState:SetRayTestOnBB(true)
    inst:AddTag("burnt")

    --inst.MiniMapEntity:SetIcon(inst.build == "twiggy" and "twiggy_burnt.png" or "evergreen_burnt.png")

    if inst.components.timer ~= nil and not inst.components.timer:TimerExists("decay") then
        inst.components.timer:StartTimer("decay", GetRandomWithVariance(GetBuild(inst).regrowth_tuning.DEAD_DECAY_TIME, GetBuild(inst).regrowth_tuning.DEAD_DECAY_TIME*0.5))
    end
end

local function PushSway(inst)
    inst.AnimState:PushAnimation(math.random() > .5 and inst.anims.sway1 or inst.anims.sway2, true)
end

local function Sway(inst)
    inst.AnimState:PlayAnimation(math.random() > .5 and inst.anims.sway1 or inst.anims.sway2, true)
end

local function SetShort(inst)
    inst.anims = short_anims

    if inst.components.workable then
        inst.components.workable:SetWorkLeft(TUNING.EVERGREEN_CHOPS_SMALL)
    end

    inst.components.lootdropper:SetLoot(GetBuild(inst).short_loot)

    inst:AddTag("shelter")

    Sway(inst)
end

local function GrowShort(inst)
    inst.AnimState:PlayAnimation("grow_old_to_short")
    inst.SoundEmitter:PlaySound("dontstarve/forest/treeGrowFromWilt")
    PushSway(inst)
end

local function SetNormal(inst)
    inst.anims = normal_anims

    if inst.components.workable then
        inst.components.workable:SetWorkLeft(TUNING.EVERGREEN_CHOPS_NORMAL)
    end

    inst.components.lootdropper:SetLoot(GetBuild(inst).normal_loot)

    inst:AddTag("shelter")

    Sway(inst)
end

local function GrowNormal(inst)
    inst.AnimState:PlayAnimation("grow_short_to_normal")
    inst.SoundEmitter:PlaySound("dontstarve/forest/treeGrow")
    PushSway(inst)
end

local function SetTall(inst)
    inst.anims = tall_anims
    if inst.components.workable then
        inst.components.workable:SetWorkLeft(TUNING.EVERGREEN_CHOPS_TALL)
    end

    inst.components.lootdropper:SetLoot(GetBuild(inst).tall_loot)

    inst:AddTag("shelter")

    Sway(inst)
end

local function GrowTall(inst)
    inst.AnimState:PlayAnimation("grow_normal_to_tall")
    inst.SoundEmitter:PlaySound("dontstarve/forest/treeGrow")
    PushSway(inst)
end

local function SetOld(inst)
    inst.anims = old_anims

    if inst.components.workable ~= nil then
        inst.components.workable:SetWorkLeft(1)
    end

    inst.components.lootdropper:SetLoot({})

    inst:RemoveTag("shelter")

    Sway(inst)
end

local function GrowOld(inst)
    inst.AnimState:PlayAnimation("grow_tall_to_old")
    inst.SoundEmitter:PlaySound("dontstarve/forest/treeWilt")
    PushSway(inst)
end

local function inspect_tree(inst)
    return (inst:HasTag("burnt") and "BURNT")
        or (inst:HasTag("stump") and "CHOPPED")
        or nil
end

local growth_stages = {}
for build, data in pairs(builds) do
    growth_stages[build] =
    {
        {
            name = "short",
            time = function(inst) return GetRandomWithVariance(data.grow_times[1].base, data.grow_times[1].random) end,
            fn = SetShort,
            growfn = GrowShort,
        },
       --[[ {
            name = "normal",
            time = function(inst) return GetRandomWithVariance(data.grow_times[2].base, data.grow_times[2].random) end,
            fn = SetNormal,
            growfn = GrowNormal,
        },
        {
            name = "tall",
            time = function(inst) return GetRandomWithVariance(data.grow_times[3].base, data.grow_times[3].random) end,
            fn = SetTall,
            growfn = GrowTall,
        },
        {
            name = "old",
            time = function(inst) return GetRandomWithVariance(data.grow_times[4].base, data.grow_times[4].random) end,
            fn = SetOld,
        },]]
    }
end

local function GetGrowthStages(inst)
    return growth_stages[inst.build] or growth_stages["normal"]
end

local function chop_tree(inst, chopper, chopsleft, numchops)
    if not (chopper ~= nil and chopper:HasTag("playerghost")) then
        inst.SoundEmitter:PlaySound(
            chopper ~= nil and chopper:HasTag("beaver") and
            "dontstarve/characters/woodie/beaver_chop_tree" or
            "dontstarve/wilson/use_axe_tree"
        )
    end

    inst.AnimState:PlayAnimation(inst.anims.chop)
    inst.AnimState:PushAnimation(inst.anims.sway1, true)

    local x, y, z = inst.Transform:GetWorldPosition()
    SpawnPrefab("pine_needles_chop").Transform:SetPosition(x, y + math.random() * 2, z)   
end

local function chop_down_tree_shake(inst)
    ShakeAllCameras(CAMERASHAKE.FULL, .25, .03,
        inst.components.growable ~= nil and
        inst.components.growable.stage > 2 and .5 or .25,
        inst, 6)
end

local function make_stump(inst)
    inst:RemoveComponent("burnable")
    MakeSmallBurnable(inst)
    inst:RemoveComponent("propagator")
    MakeSmallPropagator(inst)
    inst:RemoveComponent("workable")
    inst:RemoveTag("shelter")
    inst:RemoveComponent("hauntable")
    MakeHauntableIgnite(inst)

    RemovePhysicsColliders(inst)

    inst:AddTag("stump")
    if inst.components.growable ~= nil then
        inst.components.growable:StopGrowing()
    end

    --inst.MiniMapEntity:SetIcon(inst.build == "twiggy" and "twiggy_stump.png" or "evergreen_stump.png")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetOnFinishCallback(dig_up_stump)
    inst.components.workable:SetWorkLeft(1)

    if inst.components.timer and not inst.components.timer:TimerExists("decay") then
        inst.components.timer:StartTimer("decay", GetRandomWithVariance(GetBuild(inst).regrowth_tuning.DEAD_DECAY_TIME, GetBuild(inst).regrowth_tuning.DEAD_DECAY_TIME*0.5))
    end
end

local function chop_down_tree(inst, chopper)
    inst.SoundEmitter:PlaySound("dontstarve/forest/treefall")
    local pt = inst:GetPosition()

    local he_right = true

    if chopper then
        local hispos = chopper:GetPosition()
        he_right = (hispos - pt):Dot(TheCamera:GetRightVec()) > 0
    else
        if math.random() > 0.5 then
            he_right = false
        end
    end

    if he_right then
        inst.AnimState:PlayAnimation(inst.anims.fallleft)
        inst.components.lootdropper:DropLoot(pt - TheCamera:GetRightVec())
    else
        inst.AnimState:PlayAnimation(inst.anims.fallright)
        inst.components.lootdropper:DropLoot(pt + TheCamera:GetRightVec())
    end

    inst:DoTaskInTime(GetBuild(inst).chop_camshake_delay, chop_down_tree_shake)

    make_stump(inst)
    inst.AnimState:PushAnimation(inst.anims.stump)
end

local function tree_burnt(inst)
    OnBurnt(inst)
end

local function handler_growfromseed(inst)
    inst.components.growable:SetStage(1)
    inst.AnimState:PlayAnimation("seed_to_short")
    inst.SoundEmitter:PlaySound("dontstarve/forest/treeGrow")
    PushSway(inst)
end

local function onsave(inst, data)
    if inst:HasTag("burnt") or (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
        data.burnt = true
    end

    if inst:HasTag("stump") then
        data.stump = true
    end

    if inst.build ~= "date" then
        data.build = inst.build
    end

    data.burntcone = inst.burntcone
end

local function onload(inst, data)
    if data ~= nil then
        inst.build = data.build ~= nil and builds[data.build] ~= nil and data.build or "date"

        if data.stump then
            make_stump(inst)
            inst.AnimState:PlayAnimation(inst.anims.stump)
            if data.burnt or inst:HasTag("burnt") then
                DefaultBurntFn(inst)
            end
        elseif data.burnt and not inst:HasTag("burnt") then
            OnBurnt(inst, true)
        end

        if not inst:IsValid() then
            return
        end

        inst.burntcone = data.burntcone
    end
end

local function OnEntitySleep(inst)
    local doBurnt = inst.components.burnable ~= nil and inst.components.burnable:IsBurning()
    if doBurnt and inst:HasTag("stump") then
        DefaultBurntFn(inst)
    else
        inst:RemoveComponent("burnable")
        inst:RemoveComponent("propagator")
        inst:RemoveComponent("inspectable")
        if doBurnt then
            inst:RemoveComponent("growable")
            inst:AddTag("burnt")
        end
    end
end

local function OnEntityWake(inst)
    if inst:HasTag("burnt") then
        tree_burnt(inst)
    else
        local isstump = inst:HasTag("stump")

        if not (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
            if inst.components.burnable == nil then
                if isstump then
                    MakeSmallBurnable(inst)
                else
                    MakeLargeBurnable(inst, TUNING.TREE_BURN_TIME)
                    inst.components.burnable:SetFXLevel(5)
                    inst.components.burnable:SetOnBurntFn(tree_burnt)
                end
            end

            if inst.components.propagator == nil then
                if isstump then
                    MakeSmallPropagator(inst)
                else
                    MakeMediumPropagator(inst)
                end
            end
        end
    end

    if inst.components.inspectable == nil then
        inst:AddComponent("inspectable")
        inst.components.inspectable.getstatus = inspect_tree
    end
end

local REMOVABLE =
{
    ["log"] = true,
    ["date"] = true,
    ["charcoal"] = true,
}

local function OnTimerDone(inst, data)
    if data.name == "decay" then
        local x, y, z = inst.Transform:GetWorldPosition()
        if inst:IsAsleep() then
            -- before we disappear, clean up any crap left on the ground
            -- too many objects is as bad for server health as too few!
            local leftone = false
            for i, v in ipairs(TheSim:FindEntities(x, y, z, 6, { "_inventoryitem" }, { "INLIMBO", "fire" })) do
                if REMOVABLE[v.prefab] then
                    if leftone then
                        v:Remove()
                    else
                        leftone = true
                    end
                end
            end
        else
            SpawnPrefab("small_puff").Transform:SetPosition(x, y, z)
        end
        inst:Remove()
    end
end

local function onhauntwork(inst, haunter)
    if inst.components.workable ~= nil and math.random() <= TUNING.HAUNT_CHANCE_OFTEN then
        inst.components.workable:WorkedBy(haunter, 1)
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
        return true
    end
    return false
end

local function tree(name, build, stage, data)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddMiniMapEntity()
        inst.entity:AddNetwork()

        MakeObstaclePhysics(inst, .25)

        --inst.MiniMapEntity:SetIcon(build == "sparse" and "evergreen_lumpy.png" or "evergreen.png")

        inst:AddTag("shelter")

        inst.MiniMapEntity:SetPriority(-1)

        inst:AddTag("date_tree")
        inst:AddTag("plant")
        inst:AddTag("tree")

        inst.build = build

        inst.AnimState:SetBuild(GetBuild(inst).file)

        inst.AnimState:SetBank(GetBuild(inst).file_bank)

        inst:SetPrefabName(GetBuild(inst).prefab_name)
        inst:AddTag(GetBuild(inst).prefab_name) -- used by regrowth

        MakeSnowCoveredPristine(inst)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        local color = .5 + math.random() * .5
        inst.AnimState:SetMultColour(color, color, color, 1)

        -------------------
        MakeLargeBurnable(inst, TUNING.TREE_BURN_TIME)
        inst.components.burnable:SetFXLevel(5)
        inst.components.burnable:SetOnBurntFn(tree_burnt)
        MakeMediumPropagator(inst)

        -------------------
        inst:AddComponent("inspectable")
        inst.components.inspectable.getstatus = inspect_tree

        -------------------
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.CHOP)
        inst.components.workable:SetOnWorkCallback(chop_tree)
        inst.components.workable:SetOnFinishCallback(chop_down_tree)

        -------------------
        inst:AddComponent("lootdropper")

        ---------------------
        inst:AddComponent("growable")
        inst.components.growable.stages = GetGrowthStages(inst)
        inst.components.growable:SetStage(1) --stage == 0 and math.random(1, 3) or stage)
        inst.components.growable.loopstages = true
        inst.components.growable.springgrowth = true
        inst.components.growable:StartGrowing()

        inst.growfromseed = handler_growfromseed

        ---------------------        
        --inst:AddComponent("plantregrowth")
        --inst.components.plantregrowth:SetRegrowthRate(GetBuild(inst).regrowth_tuning.OFFSPRING_TIME)
        --inst.components.plantregrowth:SetProduct(GetBuild(inst).regrowth_product)
        --inst.components.plantregrowth:SetSearchTag(GetBuild(inst).prefab_name)
        --inst.components.plantregrowth:GetSpawnPoint(nil, 60, "oasislake")

        ---------------------
        inst:AddComponent("timer")
        inst:ListenForEvent("timerdone", OnTimerDone)

        ---------------------

        inst:AddComponent("hauntable")
        inst.components.hauntable:SetOnHauntFn(onhauntwork)

        ---------------------

        inst.OnSave = onsave
        inst.OnLoad = onload

        MakeSnowCovered(inst)
        ---------------------

        if data == "stump" then
            RemovePhysicsColliders(inst)
            inst:AddTag("stump")
            inst:RemoveTag("shelter")

            inst:RemoveComponent("burnable")
            MakeSmallBurnable(inst)
            inst:RemoveComponent("workable")
            inst:RemoveComponent("propagator")
            MakeSmallPropagator(inst)
            inst:RemoveComponent("growable")
            inst:AddComponent("workable")
            inst.components.workable:SetWorkAction(ACTIONS.DIG)
            inst.components.workable:SetOnFinishCallback(dig_up_stump)
            inst.components.workable:SetWorkLeft(1)
            inst.AnimState:PlayAnimation(inst.anims.stump)
            --inst.MiniMapEntity:SetIcon(build == "twiggy" and "twiggy_stump.png" or "evergreen_stump.png")
        else
            inst.AnimState:SetTime(math.random() * 2)
            if data == "burnt" then
                OnBurnt(inst)
            end
        end

        inst.OnEntitySleep = OnEntitySleep
        inst.OnEntityWake = OnEntityWake

        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

return  tree("date_tree", "date", 0),
        --tree("date_tree_normal", "date", 2),
        --tree("date_tree_tall", "date", 3),
        tree("date_tree_short", "date", 1)

