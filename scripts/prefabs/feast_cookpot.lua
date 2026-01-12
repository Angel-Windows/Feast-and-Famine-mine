local prefabs =
{
    "spoiled_food",
}

local function MakePreparedFood(data)
    local realname = data.basename or data.name
    local assets =
    {
        Asset("ANIM", "anim/"..realname..".zip"),
    }
    
    local spicename = data.spice ~= nil and string.lower(data.spice) or nil
    if spicename ~= nil then
        table.insert(assets, Asset("ANIM", "anim/spices.zip"))
        table.insert(assets, Asset("ANIM", "anim/plate_food.zip"))
        table.insert(assets, Asset("INV_IMAGE", spicename.."_over"))
    end

    local foodprefabs = prefabs
    if data.prefabs ~= nil then
        foodprefabs = shallowcopy(prefabs)
        for i, v in ipairs(data.prefabs) do
            if not table.contains(foodprefabs, v) then
                table.insert(foodprefabs, v)
            end
        end
    end

    local function DisplayNameFn(inst)
        return subfmt(STRINGS.NAMES[data.spice.."_FOOD"], { food = STRINGS.NAMES[string.upper(data.basename)] })
    end

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        if spicename ~= nil then
            inst.AnimState:SetBuild("plate_food")
            inst.AnimState:SetBank("plate_food")
            inst.AnimState:OverrideSymbol("swap_garnish", "spices", spicename)

            inst:AddTag("spicedfood")

            inst.inv_image_bg = {image = realname..".tex"}
            inst.inv_image_bg.atlas = GetInventoryItemAtlas(inst.inv_image_bg.image)
            MakeInventoryFloatable(inst, "med", nil, 0.78)
        else
            inst.AnimState:SetBuild(realname)   
            inst.AnimState:SetBank(realname)

            MakeInventoryFloatable(inst)
        end
        inst.AnimState:PlayAnimation("idle")
        inst.AnimState:OverrideSymbol("swap_food", realname, realname)

        inst:AddTag("preparedfood")
        if data.tags then
            for i,v in pairs(data.tags) do
                inst:AddTag(v)
            end
        end

        if data.basename ~= nil then
            inst:SetPrefabNameOverride(data.basename)
            if data.spice ~= nil then
                inst.displaynamefn = DisplayNameFn
            end
        end

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("edible")
        inst.components.edible.healthvalue = data.health
        inst.components.edible.hungervalue = data.hunger
        inst.components.edible.foodtype = data.foodtype or FOODTYPE.GENERIC
        inst.components.edible.sanityvalue = data.sanity or 0
        inst.components.edible.temperaturedelta = data.temperature or 0
        inst.components.edible.temperatureduration = data.temperatureduration or 0
        inst.components.edible.nochill = data.nochill or nil
        inst.components.edible.spice = data.spice
        inst.components.edible:SetOnEatenFn(data.oneatenfn)
        inst.components.edible.naughtyvalue = data.naughtiness or 0


        inst:AddComponent("inspectable")
        inst.wet_prefix = data.wet_prefix
        
        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.imagename = realname
        if spicename ~= nil then 
            inst.components.inventoryitem:ChangeImageName(spicename.."_over")
        elseif data.basename ~= nil then 
            inst.components.inventoryitem:ChangeImageName(data.basename)
        end

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

		if data.perishtime ~= nil and data.perishtime > 0 then
			inst:AddComponent("perishable")
			inst.components.perishable:SetPerishTime(data.perishtime)
			inst.components.perishable:StartPerishing()
			inst.components.perishable.onperishreplacement = "spoiled_food"
		end
		
        MakeSmallBurnable(inst) 

        MakeSmallPropagator(inst)

        MakeHauntableLaunchAndPerish(inst)

        inst:AddComponent("bait")

        inst:AddComponent("tradable") 

        return inst
    end

    return Prefab(data.name, fn, assets, foodprefabs)
end

----------

local function MakeMilkFood(data)
    local realname = data.basename or data.name
    local assets =
    {
        Asset("ANIM", "anim/"..realname..".zip"),
    }
    
    local spicename = data.spice ~= nil and string.lower(data.spice) or nil
    if spicename ~= nil then
        table.insert(assets, Asset("ANIM", "anim/spices.zip"))
        table.insert(assets, Asset("ANIM", "anim/plate_food.zip"))
        table.insert(assets, Asset("INV_IMAGE", spicename.."_over"))
    end

    local foodprefabs = prefabs
    if data.prefabs ~= nil then
        foodprefabs = shallowcopy(prefabs)
        for i, v in ipairs(data.prefabs) do
            if not table.contains(foodprefabs, v) then
                table.insert(foodprefabs, v)
            end
        end
    end

    local function DisplayNameFn(inst)
        return subfmt(STRINGS.NAMES[data.spice.."_FOOD"], { food = STRINGS.NAMES[string.upper(data.basename)] })
    end

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        if spicename ~= nil then
            inst.AnimState:SetBuild("plate_food")
            inst.AnimState:SetBank("plate_food")
            inst.AnimState:OverrideSymbol("swap_garnish", "spices", spicename)

            inst:AddTag("spicedfood")

            inst.inv_image_bg = { image = (data.basename or data.name)..".tex" }
            inst.inv_image_bg.atlas = GetInventoryItemAtlas(inst.inv_image_bg.image)
        else
        inst.AnimState:SetBuild(realname)
        inst.AnimState:SetBank(realname)
        end
        inst.AnimState:PlayAnimation("idle")
        inst.AnimState:OverrideSymbol("swap_food", realname, realname)

        inst:AddTag("preparedfood")
        if data.tags ~= nil then
            for i,v in pairs(data.tags) do
                inst:AddTag(v)
            end
        end

        if data.basename ~= nil then
            inst:SetPrefabNameOverride(data.basename)
            if data.spice ~= nil then
                inst.displaynamefn = DisplayNameFn
            end
        end

        if data.floater ~= nil then
            MakeInventoryFloatable(inst, data.floater[1], data.floater[2], data.floater[3])
        else
            MakeInventoryFloatable(inst)
        end

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("edible")
        inst.components.edible.healthvalue = data.health
        inst.components.edible.hungervalue = data.hunger
        inst.components.edible.foodtype = data.foodtype or FOODTYPE.GENERIC
        inst.components.edible.sanityvalue = data.sanity or 0
        inst.components.edible.temperaturedelta = data.temperature or 0
        inst.components.edible.temperatureduration = data.temperatureduration or 0
        inst.components.edible.nochill = data.nochill or nil
        inst.components.edible.spice = data.spice
        inst.components.edible:SetOnEatenFn(data.oneatenfn)
        inst.components.edible.naughtyvalue = data.naughtiness or 0


        inst:AddComponent("inspectable")
        inst.wet_prefix = data.wet_prefix
        
        inst:AddComponent("inventoryitem")
        if spicename ~= nil then
            inst.components.inventoryitem:ChangeImageName(spicename.."_over")
        elseif data.basename ~= nil then
            inst.components.inventoryitem:ChangeImageName(data.basename)
        end

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

        if data.perishtime ~= nil and data.perishtime > 0 then
            inst:AddComponent("perishable")
            inst.components.perishable:SetPerishTime(data.perishtime)
            inst.components.perishable:StartPerishing()
            inst.components.perishable.onperishreplacement = "spoiled_food"
        end
        
        MakeSmallBurnable(inst) 

        MakeSmallPropagator(inst)

        MakeHauntableLaunchAndPerish(inst)

        inst:AddComponent("bait")

        inst:AddComponent("tradable") 

        return inst
    end

    return Prefab(data.name, fn, assets, foodprefabs)
end

----------

local prefs = {}

for k, v in pairs(require("Feast_foods")) do
    table.insert(prefs, MakePreparedFood(v))
end
for k, v in pairs(require("Feast_foodspiced")) do
    table.insert(prefs, MakePreparedFood(v))
end
if KnownModIndex:IsModEnabled("workshop-436654027") then
    for k, v in pairs(require("Milk_foodspiced")) do
        table.insert(prefs, MakeMilkFood(v))
    end
end

return unpack(prefs)
