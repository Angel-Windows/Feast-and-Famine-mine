local barrenbirdythings = {
    --"barrenseeds_new", -- this will remove the seeds but not the crops
    "feast_crops",
    "turnip_cooked",      
    "barrenseedspacket",
    "pumpkin_wild",
    "wheatgrass",
}

for k,v in pairs(barrenbirdythings) do
    table.insert(PrefabFiles, v)
end

local AllRecipes = GLOBAL.AllRecipes
local assets = {Asset("ANIM", "anim/barrenseeds.zip")}

--[[
local function commonproduct(inst)
    local samerarityveggies = {}
    
    for k,v in pairs(GLOBAL.VEGGIES) do
        if v.seed_weight == 3 then
            table.insert(samerarityveggies, k)
        end      
    end
    if math.random() > 0.93 then
        return "eggplant"    
    elseif math.random() < 0.25 then
        if GLOBAL.TheWorld.state.iswinter then
            return "turnip"
        elseif GLOBAL.TheWorld.state.isspring then 
            return "asparagus"
        elseif GLOBAL.TheWorld.state.issummer then 
            return "watermelon"
        elseif GLOBAL.TheWorld.state.isautumn then 
            return "pumpkin"
        end   
    else 
        return samerarityveggies[math.random(#samerarityveggies)] or "carrot"
    end    
end 
]] 

local function BarrenSeedsInit(inst)
    inst.AnimState:SetBank("seeds_feast")
    inst.AnimState:SetBuild("seeds_feast")
    inst.AnimState:PlayAnimation("seed_rnd")
    --inst.Transform:SetScale(.7, .7, .7)
    --if inst.components.plantable and TUNING.SEASONALSEEDS ~= nil then
        --inst.components.plantable.product = commonproduct
    --end
    if inst.components.inventoryitem then
    inst.components.inventoryitem.imagename = "seeds"   
    end
end 

local function SweetpotatoSeedsInit(inst)
    inst.AnimState:SetBank("seeds_feast")
    inst.AnimState:SetBuild("seeds_feast")
    inst.AnimState:PlayAnimation("seed8")
    --inst.Transform:SetScale(.7, .7, .7)
    if inst.components.inventoryitem then
    inst.components.inventoryitem.imagename = "seed8"   
    end
    if inst.components.edible then
    inst.components.edible.sanityvalue = -TUNING.SANITY_TINY
    end  
end

local function CornSeedsInit(inst)
    if inst.components.cookable then
    inst.components.cookable.product = "corn_cooked"   
    end
end    

local function DurianSeedsInit(inst)
    if inst.components.edible then
    inst.components.edible.sanityvalue = -TUNING.SANITY_TINY
    end  
end

local function PineappleSeedsInit(inst)
    inst.AnimState:SetBank("seeds_feast")
    inst.AnimState:SetBuild("seeds_feast")
    inst.AnimState:PlayAnimation("seed11")
    --inst.Transform:SetScale(.8, .8, .8)
    if inst.components.inventoryitem then
    inst.components.inventoryitem.atlasname = nil -- Clears the atlas name set by Legion as we want to use the default atlas instead 
    inst.components.inventoryitem.imagename = "seed11" 
    end
end

local function WurtSeedsInit(inst)
    if inst.components.foodaffinity then
    inst.components.foodaffinity:AddPrefabAffinity  ("durian_seeds", 2 )
    inst.components.foodaffinity:AddPrefabAffinity  ("tomato_rock_dried", 2)
    end
end

local function CornReskinInit(inst)
    inst.AnimState:SetBank("seeds_feast")
    inst.AnimState:SetBuild("seeds_feast")
    inst.AnimState:PlayAnimation("seed1")
    if inst.components.inventoryitem then
        inst.components.inventoryitem.imagename = "corn_seeds_proxy"
    end 
end

local function CornReskinSeedlingInit(inst)
    inst.AnimState:OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed1")
end

local function DragonfruitReskinInit(inst)
    inst.AnimState:SetBank("seeds_feast")
    inst.AnimState:SetBuild("seeds_feast")
    inst.AnimState:PlayAnimation("seed6")
    if inst.components.inventoryitem then
        inst.components.inventoryitem.imagename = "dragonfruit_seeds_proxy"
    end 
end

local function DragonfruitReskinSeedlingInit(inst)
    inst.AnimState:OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed6")
end

local function DurianReskinInit(inst)
    inst.AnimState:SetBank("seeds_feast")
    inst.AnimState:SetBuild("seeds_feast")
    inst.AnimState:PlayAnimation("seed5")
    if inst.components.inventoryitem then
        inst.components.inventoryitem.imagename = "Durian_seeds_proxy"
    end 
end

local function DurianReskinSeedlingInit(inst)
    inst.AnimState:OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed5")
end

local function EggplantReskinInit(inst)
    inst.AnimState:SetBank("seeds_feast")
    inst.AnimState:SetBuild("seeds_feast")
    inst.AnimState:PlayAnimation("seed4")
    if inst.components.inventoryitem then
        inst.components.inventoryitem.imagename = "eggplant_seeds_proxy"
    end 
end

local function EggplantReskinSeedlingInit(inst)
    inst.AnimState:OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed4")
end

local function PomegranateReskinInit(inst)
    inst.AnimState:SetBank("seeds_feast")
    inst.AnimState:SetBuild("seeds_feast")
    inst.AnimState:PlayAnimation("seed7")
    if inst.components.inventoryitem then
        inst.components.inventoryitem.imagename = "pomegranate_seeds_proxy"
    end 
end

local function PomegranateReskinSeedlingInit(inst)
    inst.AnimState:OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed7")
end

local function PumpkinReskinInit(inst)
    inst.AnimState:SetBank("seeds_feast")
    inst.AnimState:SetBuild("seeds_feast")
    inst.AnimState:PlayAnimation("seed2")
    if inst.components.inventoryitem then
        inst.components.inventoryitem.imagename = "pumpkin_seeds_proxy"
    end 
end

local function PumpkinReskinSeedlingInit(inst)
    inst.AnimState:OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed2")
end

local function WatermelonReskinInit(inst)
    inst.AnimState:SetBank("seeds_feast")
    inst.AnimState:SetBuild("seeds_feast")
    inst.AnimState:PlayAnimation("seed3")
    if inst.components.inventoryitem then
        inst.components.inventoryitem.imagename = "watermelon_seeds_proxy"
    end 
end

local function WatermelonReskinSeedlingInit(inst)
    inst.AnimState:OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed3")
end

local function AsparagusReskinInit(inst)
    inst.AnimState:SetBank("seeds_feast")
    inst.AnimState:SetBuild("seeds_feast")
    inst.AnimState:PlayAnimation("seed9")
    if inst.components.inventoryitem then
        inst.components.inventoryitem.imagename = "asparagus_seeds_proxy"
    end 
end

local function AsparagusReskinSeedlingInit(inst)
    inst.AnimState:OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed9")
end

local function PepperReskinInit(inst)
    inst.AnimState:SetBank("seeds_feast")
    inst.AnimState:SetBuild("seeds_feast")
    inst.AnimState:PlayAnimation("seed10")
    if inst.components.inventoryitem then
        inst.components.inventoryitem.imagename = "pepper_seeds_proxy"
    end 
end

local function PepperReskinSeedlingInit(inst)
    inst.AnimState:OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed10")
end

AddPrefabPostInit("seeds", BarrenSeedsInit)
AddPrefabPostInit("corn_seeds", CornSeedsInit)
AddPrefabPostInit("durian_seeds", DurianSeedsInit) 
AddPrefabPostInit("wurt", WurtSeedsInit)

if GLOBAL.TUNING.FAFSEEDSCORN ~= nil then
    AddPrefabPostInit("corn_seeds", CornReskinInit)
    AddPrefabPostInit("farm_plant_corn", CornReskinSeedlingInit)  
end

if GLOBAL.TUNING.FAFSEEDSDRAGONFRUIT ~= nil then
    AddPrefabPostInit("dragonfruit_seeds", DragonfruitReskinInit)
    AddPrefabPostInit("farm_plant_dragonfruit", DragonfruitReskinSeedlingInit)   
end

if GLOBAL.TUNING.FAFSEEDSDURIAN ~= nil then
    AddPrefabPostInit("durian_seeds", DurianReskinInit)
    AddPrefabPostInit("farm_plant_durian", DurianReskinSeedlingInit)   
end

if GLOBAL.TUNING.FAFSEEDSEGGPLANT ~= nil then
    AddPrefabPostInit("eggplant_seeds", EggplantReskinInit)
    AddPrefabPostInit("farm_plant_eggplant", EggplantReskinSeedlingInit)   
end

if GLOBAL.TUNING.FAFSEEDSPOMEGRANATE ~= nil then
    AddPrefabPostInit("pomegranate_seeds", PomegranateReskinInit) 
    AddPrefabPostInit("farm_plant_pomegranate", PomegranateReskinSeedlingInit) 
end

if GLOBAL.TUNING.FAFSEEDSPUMPKIN ~= nil then
    AddPrefabPostInit("pumpkin_seeds", PumpkinReskinInit)
    AddPrefabPostInit("farm_plant_pumpkin", PumpkinReskinSeedlingInit)   
end

if GLOBAL.TUNING.FAFSEEDSWATERMELON ~= nil then
    AddPrefabPostInit("watermelon_seeds", WatermelonReskinInit)
    AddPrefabPostInit("farm_plant_watermelon", WatermelonReskinSeedlingInit)   
end

if GLOBAL.TUNING.FAFSEEDSASPARAGUS ~= nil then
    AddPrefabPostInit("asparagus_seeds", AsparagusReskinInit)
    AddPrefabPostInit("farm_plant_asparagus", AsparagusReskinSeedlingInit)   
end

if GLOBAL.TUNING.FAFSEEDSPEPPER ~= nil then
    AddPrefabPostInit("pepper_seeds", PepperReskinInit)
    AddPrefabPostInit("farm_plant_pepper", PepperReskinSeedlingInit)   
end

if GLOBAL.KnownModIndex:IsModEnabled("workshop-1467214795") then
    AddPrefabPostInit("sweet_potato_seeds", SweetpotatoSeedsInit)
end

if GLOBAL.KnownModIndex:IsModEnabled("workshop-1392778117") then
    AddPrefabPostInit("pineananas_seeds", PineappleSeedsInit)
end

--------------------------------------------

TUNING = GLOBAL.TUNING
GLOBAL.require "prefabs/veggies"
 
local function MakeVegStats(seedweight, hunger, health, perish_time, sanity, cooked_hunger, cooked_health, cooked_perish_time, cooked_sanity)
    return {
        health = health,
        hunger = hunger,
        cooked_health = cooked_health,
        cooked_hunger = cooked_hunger,
        seed_weight = seedweight,
        perishtime = perish_time,
        cooked_perishtime = cooked_perish_time,
        sanity = sanity,
        cooked_sanity = cooked_sanity
     }
end

local COMMON = 3
local UNCOMMON = 1
local AROMATIC = .75
local RARE = .5

local FEASTVEGGIES =
{
    pepper = MakeVegStats(AROMATIC, TUNING.CALORIES_TINY, -TUNING.HEALING_MED, TUNING.PERISH_SLOW, -TUNING.SANITY_MED, 
                                    TUNING.CALORIES_TINY, -TUNING.HEALING_SMALL, TUNING.PERISH_SLOW, -TUNING.SANITY_SMALL),

    onion = MakeVegStats(AROMATIC, TUNING.CALORIES_TINY, 0, TUNING.PERISH_SLOW, -TUNING.SANITY_SMALL, 
                                   TUNING.CALORIES_TINY, TUNING.HEALING_TINY, TUNING.PERISH_MED, -TUNING.SANITY_TINY),

    garlic = MakeVegStats(AROMATIC, TUNING.CALORIES_TINY, 0, TUNING.PERISH_SLOW, -TUNING.SANITY_SMALL, 
                                   TUNING.CALORIES_TINY, TUNING.HEALING_TINY, TUNING.PERISH_MED, -TUNING.SANITY_TINY),

    wheat = MakeVegStats(0 --[[COMMON]], 0, 0, TUNING.PERISH_MED, 0, 0, 0, 0, 0),

    turnip = MakeVegStats(0 --[[UNCOMMON]], TUNING.CALORIES_MED, 0, TUNING.PERISH_SLOW, 0, TUNING.CALORIES_MED, 0, TUNING.PERISH_FAST, 0)
}

AddSimPostInit(function(inst)
    for k, v in pairs(FEASTVEGGIES) do
        GLOBAL.VEGGIES[k] = v
    end
end)

if not GLOBAL.rawget(GLOBAL, "CROPS_DATA_LEGION") then
 --TODO: make watermelon not wither in summer

    AddComponentPostInit("crop", function(Crop)
        function Crop:DoGrow(dt, nowither)
            if not self.inst:HasTag("withered") then 
                local shouldgrow = nowither or not GLOBAL.TheWorld.state.isnight
                if not shouldgrow then
                    local x, y, z = self.inst.Transform:GetWorldPosition()
                    local DAYLIGHT_SEARCH_RANGE = 30
                    for i, v in ipairs(GLOBAL.TheSim:FindEntities(x, 0, z, DAYLIGHT_SEARCH_RANGE, { "daylight", "lightsource" })) do
                        local lightrad = v.Light:GetCalculatedRadius() * .7
                        if v:GetDistanceSqToPoint(x, y, z) < lightrad * lightrad then
                            shouldgrow = true
                            break
                        end
                    end
                end
                if shouldgrow then
                    local temp_rate =
                        (self.product_prefab == "turnip" and 1) or
                        (GLOBAL.TheWorld.state.temperature < GLOBAL.TUNING.MIN_CROP_GROW_TEMP and 0) or
                        (GLOBAL.TheWorld.state.israining and 1 + GLOBAL.TUNING.CROP_RAIN_BONUS * GLOBAL.TheWorld.state.precipitationrate) or
                        (GLOBAL.TheWorld.state.isspring and 1 + GLOBAL.TUNING.SPRING_GROWTH_MODIFIER / 3) or
                        1
                    self.growthpercent = math.clamp(self.growthpercent + dt * self.rate * temp_rate, 0, 1)
                    self.cantgrowtime = 0
                else
                    self.cantgrowtime = self.cantgrowtime + dt
                    if self.cantgrowtime > GLOBAL.TUNING.CROP_DARK_WITHER_TIME and self.inst.components.witherable ~= nil then
                        self.inst.components.witherable:ForceWither()
                        if self.inst:HasTag("withered") then
                            return
                        end
                    end
                end

                if self.growthpercent < 1 then
                    self.inst.AnimState:SetPercent("grow", self.growthpercent)
                else
                    self.inst.AnimState:PlayAnimation("grow_pst")
                    self:Mature()
                    if self.task ~= nil then
                        self.task:Cancel()
                        self.task = nil
                    end
                end
            end
        end
    end)
end    

--[[ -- Leaving this here in case Legion reintroduces it's crop system
if GLOBAL.rawget(GLOBAL, "CROPS_DATA_LEGION") then 

    local time_annual = 15 * TUNING.TOTAL_DAY_TIME
    local time_years = 36 * TUNING.TOTAL_DAY_TIME
    local time_day = TUNING.LEGION_OVERRIPETIME ~= 0 and TUNING.LEGION_OVERRIPETIME * TUNING.TOTAL_DAY_TIME or TUNING.TOTAL_DAY_TIME

    GLOBAL.rawget(GLOBAL, "CROPS_DATA_LEGION").turnip = 
    {
        growinwinter = true,
        weakinsummer = true,
        deadinsummer = false,

        bank = "quagmire_soil",
        build = "feast_crop_turnip",
        leveldata = {
            [1] = { anim = "crop_small", time = time_annual * 0.15, deadanim = "crop_rot", witheredprefab = {"cutgrass"}, },
            [2] = { anim = "crop_med", time = time_annual * 0.85, deadanim = "crop_rot", witheredprefab = {"cutgrass"}, youth = true,},
            [3] = { anim = "crop_full", time = time_day    * 6.00, deadanim = "crop_rot", witheredprefab = {"cutgrass", "cutgrass"}, },
        },
    }

    GLOBAL.rawget(GLOBAL, "CROPS_DATA_LEGION").wheat = 
    {
        growinwinter = false,
        weakinsummer = true,
        deadinsummer = false,

        bank = "quagmire_soil",
        build = "feast_crop_wheat",
        leveldata = {
            [1] = { anim = "crop_small", time = time_annual * 0.15, deadanim = "crop_rot", witheredprefab = {"cutgrass"}, },
            [2] = { anim = "crop_med", time = time_annual * 0.85, deadanim = "crop_rot", witheredprefab = {"cutgrass"}, youth = true,},
            [3] = { anim = "crop_full", time = time_day    * 6.00, deadanim = "crop_rot", witheredprefab = {"cutgrass", "cutgrass"}, },
        }, 
    }

    GLOBAL.rawget(GLOBAL, "CROPS_DATA_LEGION").watermelon = 
    {
        growinwinter = false,
        weakinsummer = false, -- Changed from Legion's value to suit my seasonal crops system
        deadinsummer = false,
        
        bank = "plant_normal_legion",
        build = "plant_normal_legion",
        leveldata = {
            [1] = { anim = "level1_watermelon", time = time_annual * 0.05, deadanim = "dead123_watermelon", witheredprefab = {"cutgrass"}, },
            [2] = { anim = "level2_watermelon", time = time_annual * 0.10, deadanim = "dead123_watermelon", witheredprefab = {"cutgrass"}, },
            [3] = { anim = "level3_watermelon", time = time_annual * 0.25, deadanim = "dead123_watermelon", witheredprefab = {"cutgrass"}, },
            [4] = { anim = "level4_watermelon", time = time_annual * 0.20, deadanim = "dead456_watermelon", witheredprefab = {"cutgrass"}, youth = true, },
            [5] = { anim = "level5_watermelon", time = time_annual * 0.40, deadanim = "dead456_watermelon", witheredprefab = {"cutgrass"}, bloom = true, },
            [6] = { anim = "level6_watermelon", time = time_day    * 6.00, deadanim = "dead456_watermelon", witheredprefab = {"cutgrass", "cutgrass"}, },
        },
        maturedanim = {
            [1] = "level6_watermelon_1",
            [2] = "level6_watermelon_2",
            [3] = "level6_watermelon_3",
        },
    }

    local seeds_needchange =
    {
        "wheat_seeds",
        "turnip_seeds",
    }

    for k,v in pairs(seeds_needchange) do
        AddPrefabPostInit(v, function(inst)
            inst.overridedeployplacername = "wormwood_cropseeds_placer"

            if GLOBAL.TheNet:GetIsServer() or GLOBAL.TheNet:IsDedicated() then
                inst.components.deployable.ondeploy = function(inst, pt)
                    local plant = GLOBAL.SpawnPrefab("plant_normal_legion")
                    plant.components.crop:StartGrowing(inst.components.plantable.product, inst.components.plantable.growtime)
                    plant.Transform:SetPosition(pt.x, 0, pt.z)
                    plant.SoundEmitter:PlaySound("dontstarve/wilson/plant_seeds")
                    inst:Remove()
                end
            end
        end)       
    end
end]]


--[[ -- need wheat crop assets before we can add this back in. May skip turnips
local PLANT_DEFS = require("prefabs/farm_plant_defs").PLANT_DEFS

PLANT_DEFS.wheat        = {build = "feast_crop_wheat", bank = "quagmire_soil"}
PLANT_DEFS.turnip       = {build = "feast_crop_turnip", bank = "quagmire_soil"}


local function MakeGrowTimes(germination_min, germination_max, full_grow_min, full_grow_max)
    local grow_time = {}

    -- germination time
    grow_time.seed      = {germination_min, germination_max}

    -- grow time
    grow_time.sprout    = {full_grow_min * 0.5, full_grow_max * 0.5}
    grow_time.small     = {full_grow_min * 0.3, full_grow_max * 0.3}
    grow_time.med       = {full_grow_min * 0.2, full_grow_max * 0.2}

    -- harvestable perish time
    grow_time.full      = 4 * TUNING.TOTAL_DAY_TIME
    grow_time.oversized = 6 * TUNING.TOTAL_DAY_TIME
    grow_time.regrow    = {4 * TUNING.TOTAL_DAY_TIME, 5 * TUNING.TOTAL_DAY_TIME} -- min, max

    return grow_time
end

PLANT_DEFS.wheat.grow_time                = MakeGrowTimes(12 * TUNING.SEG_TIME, 16 * TUNING.SEG_TIME,     4 * TUNING.TOTAL_DAY_TIME, 7 * TUNING.TOTAL_DAY_TIME)
PLANT_DEFS.turnip.grow_time               = MakeGrowTimes(12 * TUNING.SEG_TIME, 16 * TUNING.SEG_TIME,     4 * TUNING.TOTAL_DAY_TIME, 7 * TUNING.TOTAL_DAY_TIME)

--PLANT_DEFS.wheat.grow_time              = MakeGrowTimes(0, 0,       4 * TUNING.TOTAL_DAY_TIME, 7 * TUNING.TOTAL_DAY_TIME)
--PLANT_DEFS.turnip.grow_time             = MakeGrowTimes(0, 0,       4 * TUNING.TOTAL_DAY_TIME, 7 * TUNING.TOTAL_DAY_TIME)

-- moisture
local drink_low = TUNING.FARM_PLANT_DRINK_LOW
local drink_med = TUNING.FARM_PLANT_DRINK_MED
local drink_high = TUNING.FARM_PLANT_DRINK_HIGH

PLANT_DEFS.turnip.moisture              = {drink_rate = drink_low,  min_percent = TUNING.FARM_PLANT_DROUGHT_TOLERANCE}
PLANT_DEFS.wheat.moisture               = {drink_rate = drink_low,  min_percent = TUNING.FARM_PLANT_DROUGHT_TOLERANCE}

-- season preferences
PLANT_DEFS.turnip.good_seasons          = {autumn = true,   winter = true,                               }
PLANT_DEFS.wheat.good_seasons           = {autumn = true,                                   summer = true}

-- Nutrients
local S = TUNING.FARM_PLANT_CONSUME_NUTRIENT_LOW
local M = TUNING.FARM_PLANT_CONSUME_NUTRIENT_MED
local L = TUNING.FARM_PLANT_CONSUME_NUTRIENT_HIGH
                                                         
PLANT_DEFS.turnip.nutrient_consumption          = {0, 0, L}
PLANT_DEFS.wheat.nutrient_consumption           = {0, M, 0}


for _, data in pairs(PLANT_DEFS) do
    data.nutrient_restoration = {}
    for i = 1, #data.nutrient_consumption do
        data.nutrient_restoration[i] = data.nutrient_consumption[i] == 0 or nil
    end
end

PLANT_DEFS.wheat.max_killjoys_tolerance             = TUNING.FARM_PLANT_KILLJOY_TOLERANCE
PLANT_DEFS.turnip.max_killjoys_tolerance            = TUNING.FARM_PLANT_KILLJOY_TOLERANCE

-- Weight data                          min         max         sigmoid%
PLANT_DEFS.wheat.weight_data        = { 384.90,     444.47,     .34 }
PLANT_DEFS.turnip.weight_data       = { 462.37,     688.45,     .93 }

for veggie, data in pairs(PLANT_DEFS) do
    data.prefab = "farm_plant_"..veggie

    if data.bank == nil then data.bank = "farm_plant_"..veggie end
    if data.build == nil then data.build = "farm_plant_"..veggie end

    if data then
        data.product = veggie
        --data.product_oversized = veggie.."_oversized"
        data.seed = veggie.."_seeds"
        data.plant_type_tag = "farm_plant_"..veggie -- note: this is used for pollin_sources stress

        --data.loot_oversized_rot = {"spoiled_food", "spoiled_food", "spoiled_food", data.seed, "fruitfly", "fruitfly"}

        -- all plants are going to use the same settings for now, maybe some will have special cases
        if data.family_min_count == nil then data.family_min_count = TUNING.FARM_PLANT_SAME_FAMILY_MIN end
        if data.family_check_dist == nil then data.family_check_dist = TUNING.FARM_PLANT_SAME_FAMILY_RADIUS end

        if data.stage_netvar == nil then
            data.stage_netvar = net_tinybyte
        end

        if data.plantregistryinfo == nil then
            data.plantregistryinfo = {
                {
                    text = "seed",
                    anim = "crop_sprout",
                    grow_anim = "grow_sprout",
                    learnseed = true,
                    growing = true,
                },
                {
                    text = "sprout",
                    anim = "crop_sprout",
                    grow_anim = "grow_sprout",
                    growing = true,
                },
                {
                    text = "small",
                    anim = "crop_small",
                    grow_anim = "grow_small",
                    learnseed = true,
                    growing = true,
                },
                {
                    text = "medium",
                    anim = "crop_med",
                    grow_anim = "grow_med",
                    growing = true,
                },
                {
                    text = "grown",
                    anim = "crop_full",
                    grow_anim = "grow_full",
                    revealplantname = true,
                    fullgrown = true,
                },
                {
                    text = "oversized",
                    anim = "crop_oversized",
                    grow_anim = "grow_oversized",
                    revealplantname = true,
                    fullgrown = true,
                    hidden = true,
                },
                {
                    text = "rotting",
                    anim = "crop_rot",
                    grow_anim = "grow_rot",
                    stagepriority = -100,
                    is_rotten = true,
                    hidden = true,
                },
                {
                    text = "oversized_rotting",
                    anim = "crop_rot_oversized",
                    grow_anim = "grow_rot_oversized",
                    stagepriority = -100,
                    is_rotten = true,
                    hidden = true,
                },
            }
        end
        if data.plantregistrywidget == nil then
            --the path to the widget
            data.plantregistrywidget = "widgets/redux/farmplantpage"
        end
    end
end]]