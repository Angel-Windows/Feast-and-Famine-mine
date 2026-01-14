require "prefabutil"

local PLANT_DEFS = require("prefabs/farm_plant_defs").PLANT_DEFS

local assets = {Asset("ANIM", "anim/barrenseeds.zip")}

local prefabs = {"seeds_cooked", "spoiled_food", "farm_plant_turnip", "farm_plant_wheat"}

local function makeseeds(id, veg)

    local function OnDeploy(inst, pt) -- , deployer, rot)
        local plant = SpawnPrefab("plant_normal_ground")
        plant.components.crop:StartGrowing(veg, inst.components.plantable.growtime)
        plant.Transform:SetPosition(pt.x, 0, pt.z)
        plant.SoundEmitter:PlaySound("dontstarve/wilson/plant_seeds")
        inst:Remove()
    end

    local function can_plant_seed(inst, pt, mouseover, deployer)
        local x, z = pt.x, pt.z
        return TheWorld.Map:CanTillSoilAtPoint(x, 0, z, true)
    end

    local function OnDeploy(inst, pt, deployer) -- , rot)
        local plant = SpawnPrefab(inst.components.farmplantable.plant)
        plant.Transform:SetPosition(pt.x, 0, pt.z)
        plant:PushEvent("on_planted", {
            in_soil = false,
            doer = deployer,
            seed = inst
        })
        TheWorld.Map:CollapseSoilAtPoint(pt.x, 0, pt.z)
        -- plant.SoundEmitter:PlaySound("dontstarve/wilson/plant_seeds")
        inst:Remove()
    end

    local function Seed_GetDisplayName(inst)
        local registry_key = inst.plant_def.product
        local plantregistryinfo = inst.plant_def.plantregistryinfo
        return (ThePlantRegistry:KnowsSeed(registry_key, plantregistryinfo) and
                   ThePlantRegistry:KnowsPlantName(registry_key, plantregistryinfo)) and
                   STRINGS.NAMES["KNOWN_" .. string.upper(inst.prefab)] or nil
    end

    local function fn()
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeSmallBurnable(inst)
        MakeSmallPropagator(inst)

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank("barrenseeds")
        inst.AnimState:SetBuild("barrenseeds")
        inst.AnimState:PlayAnimation("idle_" .. tostring(id))
        inst.AnimState:SetRayTestOnBB(true)
        inst.Transform:SetScale(.8, .8, .8)

        inst:AddTag("deployedplant")

        inst.overridedeployplacername = "seeds_placer"

        inst.plant_def = PLANT_DEFS[veg]
        inst.displaynamefn = Seed_GetDisplayName
        inst._custom_candeploy_fn = can_plant_seed -- for DEPLOYMODE.CUSTOM

        MakeInventoryFloatable(inst)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("edible")
        inst.components.edible.foodtype = FOODTYPE.SEEDS

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

        inst:AddComponent("tradable")

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.imagename = "quagmire_seeds_" .. tostring(id)

        inst.components.edible.healthvalue = TUNING.HEALING_TINY / 2
        inst.components.edible.hungervalue = TUNING.CALORIES_TINY

        inst:AddComponent("perishable")
        inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERSLOW)
        inst.components.perishable:StartPerishing()
        inst.components.perishable.onperishreplacement = "spoiled_food"

        inst:AddComponent("cookable")
        inst.components.cookable.product = "seeds_cooked"

        inst:AddComponent("bait")

        inst:AddComponent("farmplantable")
        inst.components.farmplantable.plant = "farm_plant_" .. veg

        inst:AddComponent("plantable")
        inst.components.plantable.growtime = TUNING.SEEDS_GROW_TIME
        inst.components.plantable.product = veg

        inst:AddComponent("deployable")
        inst.components.deployable:SetDeployMode(DEPLOYMODE.CUSTOM) -- use inst._custom_candeploy_fn        
        inst.components.deployable.restrictedtag = "plantkin"
        inst.components.deployable.ondeploy = OnDeploy

        MakeHauntableLaunchAndPerish(inst)
        return inst
    end

    return Prefab("common/inventory/" .. veg .. "_seeds", fn, assets, prefabs)
end

return makeseeds(1, "wheat"), makeseeds(5, "turnip")
