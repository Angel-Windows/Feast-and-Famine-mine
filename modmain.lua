local GLOBAL = GLOBAL
local STRINGS = GLOBAL.STRINGS

GLOBAL.SetupGemCoreEnv()
STRINGS = GLOBAL.STRINGS
local language = GetModConfigData("config_Language")

if language == "russian" then
    require("strings/ru")
end
PrefabFiles = {}

Assets = {Asset("ANIM", "anim/merm_trader1_build.zip"), Asset("ANIM", "anim/quagmire_mermcart.zip"),
          Asset("ANIM", "anim/chicken.zip"), Asset("ANIM", "anim/rooster_house.zip"),
          Asset("ANIM", "anim/rooster_farmer_build.zip"), Asset("SOUNDPACKAGE", "sound/chickenfamily.fev"),
          Asset("SOUND", "sound/chickenfamily.fsb"), Asset("SOUNDPACKAGE", "sound/breadbox.fev"),
          Asset("SOUND", "sound/breadbox.fsb"), Asset("IMAGE", "images/map_icons/minimap_rooster.tex"),
          Asset("ATLAS", "images/map_icons/minimap_rooster.xml"),

          Asset("IMAGE", "images/map_icons/minimap_wheatgrass.tex"),
          Asset("ATLAS", "images/map_icons/minimap_wheatgrass.xml"), Asset("ANIM", "anim/quagmire_mealingstone.zip"),
          Asset("ANIM", "anim/breadbox.zip"), Asset("ANIM", "anim/ui_bread_box_1x1.zip"),

          Asset("ATLAS", "images/feast_famine_hud.xml"), Asset("IMAGE", "images/feast_famine_hud.tex"),

          Asset("ATLAS", "images/inventoryimages/cheese_goat.xml"),
          Asset("IMAGE", "images/inventoryimages/cheese_goat.tex"), Asset("IMAGE", "images/feast_food_tags.tex"),
          Asset("ATLAS", "images/feast_food_tags.xml"), Asset("IMAGE", "images/inventoryimages/feast_famine.tex"),
          Asset("ATLAS", "images/inventoryimages/feast_famine.xml"),
          Asset("ATLAS_BUILD", "images/inventoryimages/feast_famine.xml", 256), Asset("ANIM", "anim/turnip_cooked.zip"),

          Asset("ANIM", "anim/feast_crop_turnip.zip"), Asset("ANIM", "anim/feast_crop_wheat.zip"),
          Asset("ANIM", "anim/pumpkin_wild.zip"), Asset("ANIM", "anim/wheat.zip"), Asset("ANIM", "anim/wheat_dug.zip"),
          Asset("ANIM", "anim/turnip.zip"), Asset("ANIM", "anim/quagmire_soil.zip"), Asset("ANIM", "anim/wheat.zip"),
          Asset("ANIM", "anim/wheat_wild_build.zip"), Asset("ANIM", "anim/turnip.zip"),
          Asset("ANIM", "anim/seeds_feast.zip"), Asset("ANIM", "anim/seeds_feast_swap.zip"),
          Asset("ANIM", "anim/barrenseeds.zip"), Asset("ANIM", "anim/faf_seedpacket.zip"),

          Asset("ANIM", "anim/tree_oasispalm_small.zip"), Asset("ANIM", "anim/tree_oasispalm_build.zip"),
          Asset("ANIM", "anim/date_fruit.zip"), Asset("ANIM", "anim/planted_hills.zip"),
          Asset("ANIM", "anim/sapling_overrides.zip"), Asset("ANIM", "anim/logs.zip"),

          Asset("ANIM", "anim/meat_rack_food_faf.zip"), Asset("ANIM", "anim/meats_faf.zip"),
          Asset("ANIM", "anim/meats_alt_faf.zip"), Asset("ANIM", "anim/meats_giant_faf.zip"),
          Asset("ANIM", "anim/meat_rack_food_giant_faf.zip"), Asset("ANIM", "anim/mushroom_tree_chunks.zip"),
          Asset("ANIM", "anim/bird_eggs_faf.zip"), Asset("ANIM", "anim/penguin_egg.zip"),
          Asset("ANIM", "anim/cheese_goat.zip"), Asset("ANIM", "anim/flour.zip"),
          Asset("ANIM", "anim/crystalised_honey.zip"), Asset("ANIM", "anim/honeys.zip"),
          Asset("ANIM", "anim/pasta_wet.zip"), Asset("ANIM", "anim/stick_pretzels.zip"),
          Asset("ANIM", "anim/syrup.zip"), Asset("ANIM", "anim/soup_mushroom.zip"),
          Asset("ANIM", "anim/soup_carrot.zip"), Asset("ANIM", "anim/soup_stone.zip"),
          Asset("ANIM", "anim/berry_cutlet.zip"), Asset("ANIM", "anim/stewed_meat.zip"),
          Asset("ANIM", "anim/jelly_crown.zip"), Asset("ANIM", "anim/jelly_turkish.zip"),
          Asset("ANIM", "anim/trunk_potroast.zip"), Asset("ANIM", "anim/pie_cannibal.zip"),
          Asset("ANIM", "anim/cake_carrot.zip"), Asset("ANIM", "anim/bread.zip"),
          Asset("ANIM", "anim/bread_cheese.zip"), Asset("ANIM", "anim/bread_jam.zip"),
          Asset("ANIM", "anim/bread_garlic.zip"), Asset("ANIM", "anim/bread_rocky.zip"),
          Asset("ANIM", "anim/pasta_fetuccini.zip"), Asset("ANIM", "anim/pasta_mac.zip"),
          Asset("ANIM", "anim/pasta_meatball.zip"), Asset("ANIM", "anim/pasta_manicotti.zip"),
          Asset("ANIM", "anim/pasta_rocky.zip")}

AddMinimapAtlas("images/map_icons/minimap_rooster.xml")
AddMinimapAtlas("images/map_icons/minimap_wheatgrass.xml")

local LEGION = GLOBAL.KnownModIndex:IsModEnabled("workshop-1392778117")
local ISLAND = GLOBAL.KnownModIndex:IsModEnabled("workshop-1467214795")
local MILK = GLOBAL.KnownModIndex:IsModEnabled("workshop-436654027")

if GetModConfigData("config_FootballLeather") then
    GLOBAL.TUNING.FOOTBALLLEATHER = true
end

if GetModConfigData("config_Nightlight") then
    GLOBAL.TUNING.FAFNIGHTLIGHT = true
end

if GetModConfigData("config_MoreMeat") then
    GLOBAL.TUNING.FAFMOREMEAT = true
end

if GetModConfigData("config_seedsall") then
    GLOBAL.TUNING.FAFSEEDSALL = true
end

if GetModConfigData("config_seedscorn") then
    GLOBAL.TUNING.FAFSEEDSCORN = true
    GLOBAL.STRINGS.NAMES.CORN_SEEDS = "Popped Seeds"
end

if GetModConfigData("config_seedsdragonfruit") then
    GLOBAL.TUNING.FAFSEEDSDRAGONFRUIT = true
    GLOBAL.STRINGS.NAMES.DRAGONFRUIT_SEEDS = "Precious Beans"
end

if GetModConfigData("config_seedsdurian") then
    GLOBAL.TUNING.FAFSEEDSDURIAN = true
    GLOBAL.STRINGS.NAMES.DURIAN_SEEDS = "Smelly Seed Pods"
end

if GetModConfigData("config_seedseggplant") then
    GLOBAL.TUNING.FAFSEEDSEGGPLANT = true
    GLOBAL.STRINGS.NAMES.EGGPLANT_SEEDS = "Polished Seeds"
end

if GetModConfigData("config_seedspomegranate") then
    GLOBAL.TUNING.FAFSEEDSPOMEGRANATE = true
    GLOBAL.STRINGS.NAMES.POMEGRANATE_SEEDS = "Squishy Seeds"
end

if GetModConfigData("config_seedspumpkin") then
    GLOBAL.TUNING.FAFSEEDSPUMPKIN = true
    GLOBAL.STRINGS.NAMES.PUMPKIN_SEEDS = "Wrapped Seeds"
end

if GetModConfigData("config_seedswatermelon") then
    GLOBAL.TUNING.FAFSEEDSWATERMELON = true
    GLOBAL.STRINGS.NAMES.WATERMELON_SEEDS = "Curved Seeds"
end

if GetModConfigData("config_seedsasparagus") then
    GLOBAL.TUNING.FAFSEEDSASPARAGUS = true
    GLOBAL.STRINGS.NAMES.ASPARAGUS_SEEDS = "Spiral Seeds"
end

if GetModConfigData("config_seedspepper") then
    GLOBAL.TUNING.FAFSEEDSPEPPER = true
    GLOBAL.STRINGS.NAMES.PEPPER_SEEDS = "Shrivelled Seeds"
end

local require = GLOBAL.require

GLOBAL.TUNING.FAFDROPSWAP = {
    ["monstermeat"] = {},
    ["cookedmonstermeat"] = {},
    ["meat"] = {},
    ["cookedmeat"] = {},
    ["drumstick"] = {},
    ["drumstick_cooked"] = {},
    ["log"] = {},
    ["livinglog"] = {},
    ["honey"] = {}
}

GLOBAL.TUNING.FAFDROPSWAPUNI = {}

local to_lunar = {"opalpreciousgem"}

local to_exotic = {"greengem", "orangegem", "dragonpie", "jellybean", "jelly_turkish", "jelly_crown", "mandrakesoup",
                   "icecream", "pumpkincookie", "watermelonicle", "fruitmedley", "bananapop"}

local to_aromatic = {"purplegem", "yellowgem", "stuffedeggplant", "dragonchilisalad", -- "soup_onion",
"bread_garlic", "mashedpotatoes", "salsa", "asparagussoup", "vegstinger", "gazpacho", "flowersalad", "bread_cheese",
                     "tomato_rock_dried"}

local to_seasonal = {"redgem", "bluegem", "powcake", "cake_carrot", "bread", "bread_jam", "potatotornado",
                     "soup_carrot", "buttermuffin", "trailmix"}

local to_common = {"goldnugget", "syrup", "taffy", "ratatouille", "jammypreserves"}

local to_egg = {"bird_egg", "bird_egg_cooked", "baconeggs"}

for _, v in pairs(to_egg) do
    AddPrefabPostInit(v, function(inst)
        inst:AddTag("preciousegg")
    end)
end

for _, v in pairs(to_lunar) do
    AddPrefabPostInit(v, function(inst)
        inst:AddTag("lunartrade")
    end)
end

for _, v in pairs(to_exotic) do
    AddPrefabPostInit(v, function(inst)
        inst:AddTag("exotictrade")
    end)
end

for _, v in pairs(to_aromatic) do
    AddPrefabPostInit(v, function(inst)
        inst:AddTag("aromatictrade")
    end)
end

for _, v in pairs(to_seasonal) do
    AddPrefabPostInit(v, function(inst)
        inst:AddTag("seasonaltrade")
    end)
end

for _, v in pairs(to_common) do
    AddPrefabPostInit(v, function(inst)
        inst:AddTag("commontrade")
    end)
end

AddPrefabPostInit("oasislake", function(inst)
    inst:AddTag("oasislake")
end)

local function ExoticTradesInit(inst)
    inst:AddTag("exotictrade")
end

local function CommonTradesInit(inst)
    inst:AddTag("commontrade")
end

if LEGION then
    AddPrefabPostInit("dish_pomegranatejelly", ExoticTradesInit)
end

if ISLAND then
    AddPrefabPostInit("dubloon", CommonTradesInit)
end

local function AgedCheeseInit(inst)
    if inst.components.edible then
        inst.components.edible.foodtype = "GOODIES"
    end
    if inst.components.inventoryitem then
        inst.components.inventoryitem.atlasname = nil
        inst.components.inventoryitem.imagename = "aged_cheese"
    end
end

local function AgedWhiteInit(inst)
    if inst.components.edible then
        inst.components.edible.foodtype = "GOODIES"
    end
    if inst.components.inventoryitem then
        inst.components.inventoryitem.atlasname = nil
        inst.components.inventoryitem.imagename = "aged_white_cheese"
    end
end

local function BeefMilkInit(inst)
    if inst.components.inventoryitem then
        inst.components.inventoryitem.atlasname = nil
        inst.components.inventoryitem.imagename = "beefalo_milk"
    end
end

local function BerryShakeInit(inst)
    if inst.components.inventoryitem then
        inst.components.inventoryitem.atlasname = nil
        inst.components.inventoryitem.imagename = "berryshake"
    end
end

local function CheeseInit(inst)
    if inst.components.edible then
        inst.components.edible.foodtype = "GOODIES"
    end
    if inst.components.inventoryitem then
        inst.components.inventoryitem.atlasname = nil
        inst.components.inventoryitem.imagename = "cheese"
    end
end

local function CheeseCakeInit(inst)
    if inst.components.edible then
        inst.components.edible.foodtype = "VEGGIE"
    end
    if inst.components.inventoryitem then
        inst.components.inventoryitem.atlasname = nil
        inst.components.inventoryitem.imagename = "cheesecake"
    end
end

local function CookedMilkInit(inst)
    if inst.components.inventoryitem then
        inst.components.inventoryitem.atlasname = nil
        inst.components.inventoryitem.imagename = "cookedmilk"
    end
end

local function CurdInit(inst)
    if inst.components.edible then
        inst.components.edible.foodtype = "GOODIES"
    end
    if inst.components.inventoryitem then
        inst.components.inventoryitem.atlasname = nil
        inst.components.inventoryitem.imagename = "curd"
    end
end

local function FishYogInit(inst)
    if inst.components.inventoryitem then
        inst.components.inventoryitem.atlasname = nil
        inst.components.inventoryitem.imagename = "fishyogurt"
    end
end

local function GoldenWhiteInit(inst)
    if inst.components.edible then
        inst.components.edible.foodtype = "GOODIES"
    end
    if inst.components.inventoryitem then
        inst.components.inventoryitem.atlasname = nil
        inst.components.inventoryitem.imagename = "goldenvein_white_cheese"
    end
    if inst.components.perishable then
        inst.components.perishable.onperishreplacement = "goldnugget"
    end
    if inst.components.tradable then
        inst.components.tradable.goldvalue = 20
    end
end

local function PizzaInit(inst)
    if inst.components.inventoryitem then
        inst.components.inventoryitem.atlasname = nil
        inst.components.inventoryitem.imagename = "pizza"
    end
end

local function RawMilkInit(inst)
    if inst.components.inventoryitem then
        inst.components.inventoryitem.atlasname = nil
        inst.components.inventoryitem.imagename = "rawmilk"
    end
end

local function WhiteCheeseInit(inst)
    if inst.components.edible then
        inst.components.edible.foodtype = "GOODIES"
    end
    if inst.components.inventoryitem then
        inst.components.inventoryitem.atlasname = nil
        inst.components.inventoryitem.imagename = "white_cheese"
    end
end

if MILK then
    AddPrefabPostInit("aged_cheese", AgedCheeseInit)
    AddPrefabPostInit("aged__white_cheese", AgedWhiteInit)
    AddPrefabPostInit("beefalo_milk", BeefMilkInit)
    AddPrefabPostInit("berryshake", BerryShakeInit)
    AddPrefabPostInit("cheese", CheeseInit)
    AddPrefabPostInit("cheesecake", CheeseCakeInit)
    AddPrefabPostInit("cookedmilk", CookedMilkInit)
    AddPrefabPostInit("curd", CurdInit)
    AddPrefabPostInit("fishyogurt", FishYogInit)
    AddPrefabPostInit("goldenvein_white_cheese", GoldenWhiteInit)
    AddPrefabPostInit("pizza", PizzaInit)
    AddPrefabPostInit("rawmilk", RawMilkInit)
    AddPrefabPostInit("white_cheese", WhiteCheeseInit)
end

AddNaughtinessFor("chicken", 4)
AddNaughtinessFor("chicken_trader", 2)

if not ISLAND then -- Checks for Island Adventures to prevent doubling up on edible naughtiness
    local _OnEaten
    local function OnEaten(self, eater, ...)

        if eater:HasTag("player") then
            if self.naughtyvalue > 0 and GLOBAL.TheWorld.components.kramped then
                GLOBAL.TheWorld.components.kramped:OnNaughtyAction(self.naughtyvalue, eater)
            end
        end

        _OnEaten(self, eater, ...)
    end

    local function GetNaughtiness(self, eater)
        return self.naughtyvalue
    end

    AddComponentPostInit("edible", function(cmp)
        cmp.naughtyvalue = 0
        _OnEaten = cmp.OnEaten
        cmp.OnEaten = OnEaten
        cmp.GetNaughtiness = GetNaughtiness
    end)
end

-- TODO: add postinit to give naughtiness when milking beefalo with babies around?

-- FOOD SOURCE NERFS --

if GetModConfigData("config_StoneFruit") then
    GLOBAL.TUNING.FAFSTONEFRUIT = true
end

if GetModConfigData("config_CarrotSoup") then
    GLOBAL.TUNING.FAFCARROTSOUP = true
end

if GetModConfigData("config_MushroomSoup") then
    GLOBAL.TUNING.FAFMUSHROOMSOUP = true
end

if GetModConfigData("config_StoneSoup") then
    GLOBAL.TUNING.FAFSTONESOUP = true
end

if GetModConfigData("config_StewedMeat") then
    GLOBAL.TUNING.FAFSTEWEDMEAT = true
end

if GetModConfigData("config_JuicyCutlet") then
    GLOBAL.TUNING.FAFJUICYCUTLET = true
end

if GetModConfigData("config_TwiggyTreats") then
    GLOBAL.TUNING.FAFTWIGGYTREATS = true
end

if GLOBAL.TUNING.FAFSTONEFRUIT ~= nil then
    GLOBAL.TUNING.ROCK_FRUIT_LOOT.RIPE_CHANCE = 0.35
end

for k, recipe in pairs(require("Feast_foods")) do
    table.insert(Assets, Asset("ATLAS", "images/cookbook_" .. recipe.name .. ".xml"))
    table.insert(Assets, Asset("IMAGE", "images/cookbook_" .. recipe.name .. ".tex"))

    AddCookerRecipe("cookpot", recipe)
    AddCookerRecipe("portablecookpot", recipe)
end

RegisterInventoryItemAtlas("images/cookbook_bread_cheese.xml", "bread_cheese")

for k, recipe in pairs(require("Feast_foodspiced")) do
    AddCookerRecipe("portablespicer", recipe)
end

local otherdishes = {"syrup", "pasta_wet", "cheese_goat", "stick_pretzels"}

for k, recipe in pairs(otherdishes) do
    table.insert(Assets, Asset("ATLAS", "images/cookbook_" .. recipe .. ".xml"))
    table.insert(Assets, Asset("IMAGE", "images/cookbook_" .. recipe .. ".tex"))
end

-- fix item images in menu and on minisigns

local feast_famine = GLOBAL.resolvefilepath("images/inventoryimages/feast_famine.xml")

AddInventoryItemAtlas(feast_famine)

AddPrefabPostInit("meat", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    inst.OnSave = function(inst, data)
        if inst.animoverride then
            data.animoverride = inst.animoverride
        end
        if inst.imagenameoverride then
            data.imagenameoverride = inst.imagenameoverride
        end
        if inst.animbankoverride then
            data.animbankoverride = inst.animbankoverride
        end
        if inst.animbuildoverride then
            data.animbuildoverride = inst.animbuildoverride
        end
    end

    inst.OnLoad = function(inst, data)
        if data then
            if data.animoverride then
                inst.AnimState:PlayAnimation(data.animoverride)
                inst.animoverride = data.animoverride
            end
            if data.animbankoverride then
                inst.AnimState:SetBank(data.animbankoverride)
                inst.animbankoverride = data.animbankoverride
            end
            if data.animbuildoverride then
                inst.AnimState:SetBuild(data.animbuildoverride)
                inst.animbuildoverride = data.animbuildoverride
            end
            if data.imagenameoverride then
                inst.components.inventoryitem:ChangeImageName(data.imagenameoverride)
                inst.imagenameoverride = data.imagenameoverride
            end
        end
    end
end)

AddPrefabPostInit("log", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    inst.OnSave = function(inst, data)
        if inst.animoverride then
            data.animoverride = inst.animoverride
        end
        if inst.imagenameoverride then
            data.imagenameoverride = inst.imagenameoverride
        end
        if inst.animbankoverride then
            data.animbankoverride = inst.animbankoverride
        end
        if inst.animbuildoverride then
            data.animbuildoverride = inst.animbuildoverride
        end
    end

    inst.OnLoad = function(inst, data)
        if data then
            if data.animoverride then
                inst.AnimState:PlayAnimation(data.animoverride)
                inst.animoverride = data.animoverride
            end
            if data.animbankoverride then
                inst.AnimState:SetBank(data.animbankoverride)
                inst.animbankoverride = data.animbankoverride
            end
            if data.animbuildoverride then
                inst.AnimState:SetBuild(data.animbuildoverride)
                inst.animbuildoverride = data.animbuildoverride
            end
            if data.imagenameoverride then
                inst.components.inventoryitem:ChangeImageName(data.imagenameoverride)
                inst.imagenameoverride = data.imagenameoverride
            end
        end
    end
end)

AddPrefabPostInit("livinglog", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    inst.OnSave = function(inst, data)
        if inst.animoverride then
            data.animoverride = inst.animoverride
        end
        if inst.imagenameoverride then
            data.imagenameoverride = inst.imagenameoverride
        end
        if inst.animbankoverride then
            data.animbankoverride = inst.animbankoverride
        end
        if inst.animbuildoverride then
            data.animbuildoverride = inst.animbuildoverride
        end
    end

    inst.OnLoad = function(inst, data)
        if data then
            if data.animoverride then
                inst.AnimState:PlayAnimation(data.animoverride)
                inst.animoverride = data.animoverride
            end
            if data.animbankoverride then
                inst.AnimState:SetBank(data.animbankoverride)
                inst.animbankoverride = data.animbankoverride
            end
            if data.animbuildoverride then
                inst.AnimState:SetBuild(data.animbuildoverride)
                inst.animbuildoverride = data.animbuildoverride
            end
            if data.imagenameoverride then
                inst.components.inventoryitem:ChangeImageName(data.imagenameoverride)
                inst.imagenameoverride = data.imagenameoverride
            end
        end
    end
end)

AddPrefabPostInit("bird_egg", function(inst)

    inst:AddTag("penguin_egg")
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    inst.OnSave = function(inst, data)
        if inst.animoverride then
            data.animoverride = inst.animoverride
        end
        if inst.imagenameoverride then
            data.imagenameoverride = inst.imagenameoverride
        end
        if inst.animbankoverride then
            data.animbankoverride = inst.animbankoverride
        end
        if inst.animbuildoverride then
            data.animbuildoverride = inst.animbuildoverride
        end
    end

    inst.OnLoad = function(inst, data)
        if data then
            if data.animoverride then
                inst.AnimState:PlayAnimation(data.animoverride)
                inst.animoverride = data.animoverride
            end
            if data.animbankoverride then
                inst.AnimState:SetBank(data.animbankoverride)
                inst.animbankoverride = data.animbankoverride
            end
            if data.animbuildoverride then
                inst.AnimState:SetBuild(data.animbuildoverride)
                inst.animbuildoverride = data.animbuildoverride
            end
            if data.imagenameoverride then
                inst.components.inventoryitem:ChangeImageName(data.imagenameoverride)
                inst.imagenameoverride = data.imagenameoverride
            end
        end
    end
end)

modimport("scripts/Feast_GorgeousDining.lua")
modimport("scripts/Feast_ChickenFamily.lua")
modimport("scripts/Feast_BarrenSeeds.lua")
modimport("scripts/Feast_DelightfulDryables.lua")
if TUNING.FOOTBALLLEATHER then
    modimport("scripts/Feast_MoroseMoreau.lua")
end
if TUNING.FAFMOREMEAT then
    modimport("scripts/Feast_ManyMeats.lua")
end
modimport("scripts/Feast_LovelyLandmarks.lua")

local language_faf = GetModConfigData("config_Language")
modimport("scripts/Feast_strings.lua")
if language_faf == "chinese" then
    modimport("scripts/Feast_strings_CHS.lua")
end
if language_faf == "russ" then
    modimport("scripts/Feast_strings_RU.lua")
end

AddPrefabPostInit("pigskin", function(inst)
    inst.AnimState:SetBank("meat_rack_food_faf")
    inst.AnimState:SetBuild("meat_rack_food_faf")
    inst.AnimState:PlayAnimation("idle_pigskin")
end)

local function nightlightonignite(inst)
    if inst.components.fueled ~= nil then
        inst.components.fueled:SetPercent(0.30)
    end
    local x, y, z = inst.Transform:GetWorldPosition()
    local range = 20
    local ents = GLOBAL.TheSim:FindEntities(x, y, z, range, nil, {"playerghost", "FX", "DECOR", "INLIMBO"}, {"player"})
    for i, v in ipairs(ents) do
        if v.components.sanity ~= nil then
            v.components.sanity:DoDelta(-15)
        end
    end
end

if GLOBAL.TUNING.FAFNIGHTLIGHT ~= nil then
    AddPrefabPostInit("nightlight", function(inst)
        inst:RemoveTag("wildfireprotected")
        inst:AddTag("wildfirepriority")
        if inst.components.burnable then
            inst.components.burnable.canlight = true
            inst.components.burnable:SetOnIgniteFn(nightlightonignite)
        end
    end)
end

GLOBAL.AddRecipePostInitAny(function(recipe)
    local ingredient = recipe:FindAndConvertIngredient("red_cap")
    if ingredient then
        ingredient:AddDictionaryPrefab("red_chunk")
        ingredient:AddDictionaryPrefab("red_chunk")
        ingredient:AddDictionaryPrefab("red_chunk_bloom")
        -- ingredient.allowmultipleprefabtypes = false
    end
end)

GLOBAL.AddRecipePostInitAny(function(recipe)
    local ingredient = recipe:FindAndConvertIngredient("blue_cap")
    if ingredient then
        ingredient:AddDictionaryPrefab("blue_chunk")
        ingredient:AddDictionaryPrefab("blue_chunk_bloom")
        -- ingredient.allowmultipleprefabtypes = false
    end
end)

GLOBAL.AddRecipePostInitAny(function(recipe)
    local ingredient = recipe:FindAndConvertIngredient("green_cap")
    if ingredient then
        ingredient:AddDictionaryPrefab("green_chunk")
        ingredient:AddDictionaryPrefab("green_chunk_bloom")
        -- ingredient.allowmultipleprefabtypes = false
    end
end)

GLOBAL.AddRecipePostInitAny(function(recipe)
    local ingredient = recipe:FindAndConvertIngredient("honey")
    if ingredient then
        ingredient:AddDictionaryPrefab("honey_killer")
        ingredient:AddDictionaryPrefab("honey_floral")
        -- ingredient.allowmultipleprefabtypes = false
    end
end)

GLOBAL.AddRecipePostInitAny(function(recipe)
    local ingredient = recipe:FindAndConvertIngredient("log")
    if ingredient then
        ingredient:AddDictionaryPrefab("log", nil, "corn_seeds_proxy.tex")
        ingredient:AddDictionaryPrefab("log", nil, "dragonfruit_seeds_proxy.tex")
        ingredient:AddDictionaryPrefab("log")
        -- ingredient.allowmultipleprefabtypes = false
    end
end)

GLOBAL.AddRecipePostInitAny(function(recipe)
    local ingredient = recipe:FindAndConvertIngredient("seeds")
    if ingredient then
        ingredient:AddDictionaryPrefab("carrot_seeds")
        ingredient:AddDictionaryPrefab("tomato_seeds")
        ingredient:AddDictionaryPrefab("potato_seeds")
        ingredient:AddDictionaryPrefab("onion_seeds")
        ingredient:AddDictionaryPrefab("garlic_seeds")

        if GLOBAL.TUNING.FAFSEEDSCORN == nil then
            ingredient:AddDictionaryPrefab("corn_seeds")
        else
            ingredient:AddDictionaryPrefab("corn_seeds", nil, "corn_seeds_proxy.tex")
            -- ingredient:AddDictionaryPrefab("corn_seeds", "images/inventoryimages/feast_famine.xml", "corn_seeds_proxy")
        end

        if GLOBAL.TUNING.FAFSEEDSDRAGONFRUIT == nil then
            ingredient:AddDictionaryPrefab("dragonfruit_seeds")
        else
            ingredient:AddDictionaryPrefab("dragonfruit_seeds", nil, "dragonfruit_seeds_proxy.tex")
        end

        if GLOBAL.TUNING.FAFSEEDSDURIAN == nil then
            ingredient:AddDictionaryPrefab("durian_seeds")
        else
            ingredient:AddDictionaryPrefab("durian_seeds", nil, "durian_seeds_proxy.tex")
        end

        if GLOBAL.TUNING.FAFSEEDSEGGPLANT == nil then
            ingredient:AddDictionaryPrefab("eggplant_seeds")
        else
            ingredient:AddDictionaryPrefab("eggplant_seeds", nil, "eggplant_seeds_proxy.tex")
        end

        if GLOBAL.TUNING.FAFSEEDSPOMEGRANATE == nil then
            ingredient:AddDictionaryPrefab("pomegranate_seeds")
        else
            ingredient:AddDictionaryPrefab("pomegranate_seeds", nil, "pomegranate_seeds_proxy.tex")
        end

        if GLOBAL.TUNING.FAFSEEDSPUMPKIN == nil then
            ingredient:AddDictionaryPrefab("pumpkin_seeds")
        else
            ingredient:AddDictionaryPrefab("pumpkin_seeds", nil, "pumpkin_seeds_proxy.tex")
        end

        if GLOBAL.TUNING.FAFSEEDSWATERMELON == nil then
            ingredient:AddDictionaryPrefab("watermelon_seeds")
        else
            ingredient:AddDictionaryPrefab("watermelon_seeds", nil, "watermelon_seeds_proxy.tex")
        end

        if GLOBAL.TUNING.FAFSEEDSASPARAGUS == nil then
            ingredient:AddDictionaryPrefab("asparagus_seeds")
        else
            ingredient:AddDictionaryPrefab("asparagus_seeds", nil, "asparagus_seeds_proxy.tex")
        end

        if GLOBAL.TUNING.FAFSEEDSPEPPER == nil then
            ingredient:AddDictionaryPrefab("pepper_seeds")
        else
            ingredient:AddDictionaryPrefab("pepper_seeds", nil, "pepper_seeds_proxy.tex")
        end
        -- ingredient.allowmultipleprefabtypes = false
    end
end)

-- This handles the symbol swaps for the new crop widget

AddClassPostConstruct("widgets/redux/farmplantpage", function(self, plantspage, data)
    print("[Feast and Famine] Debug Farmplantpage Text")
    if self.data ~= nil then
        print("Data Exists!")
        if self.data.plant_def ~= nil then
            print("Plant Def Exists!")
            if self.data.plant_def.prefab ~= nil then
                print("The Prefab -> " .. self.data.plant_def.prefab)
            end
        end
    end
    if self.data and self.data.plant and self.data.info and self.data.plant_def and self.data.plant_def.prefab then
        local knows_seed = GLOBAL.ThePlantRegistry:KnowsSeed(self.data.plant, self.data.info)
        if knows_seed then
            local base = "farm_plant_"
            if GLOBAL.TUNING.FAFSEEDSCORN ~= nil then
                if self.data.plant_def.prefab == base .. "corn" then
                    self.seed_icon:SetTexture("images/inventoryimages/feast_famine.xml", "corn_seeds_proxy.tex",
                        "default_image.tex") -- default image is an image that exists no matter what in the atlas, just in case it cant find the actual desired one
                end
            end
            if GLOBAL.TUNING.FAFSEEDSDRAGONFRUIT ~= nil then
                if self.data.plant_def.prefab == base .. "dragonfruit" then
                    self.seed_icon:SetTexture("images/inventoryimages/feast_famine.xml", "dragonfruit_seeds_proxy.tex",
                        "default_image.tex") -- default image is an image that exists no matter what in the atlas, just in case it cant find the actual desired one
                end
            end
            if GLOBAL.TUNING.FAFSEEDSDURIAN ~= nil then
                if self.data.plant_def.prefab == base .. "durian" then
                    self.seed_icon:SetTexture("images/inventoryimages/feast_famine.xml", "durian_seeds_proxy.tex",
                        "default_image.tex") -- default image is an image that exists no matter what in the atlas, just in case it cant find the actual desired one
                end
            end
            if GLOBAL.TUNING.FAFSEEDSEGGPLANT ~= nil then
                if self.data.plant_def.prefab == base .. "eggplant" then
                    self.seed_icon:SetTexture("images/inventoryimages/feast_famine.xml", "eggplant_seeds_proxy.tex",
                        "default_image.tex") -- default image is an image that exists no matter what in the atlas, just in case it cant find the actual desired one
                end
            end
            if GLOBAL.TUNING.FAFSEEDSPOMEGRANATE ~= nil then
                if self.data.plant_def.prefab == base .. "pomegranate" then
                    self.seed_icon:SetTexture("images/inventoryimages/feast_famine.xml", "pomegranate_seeds_proxy.tex",
                        "default_image.tex") -- default image is an image that exists no matter what in the atlas, just in case it cant find the actual desired one
                end
            end
            if GLOBAL.TUNING.FAFSEEDSPUMPKIN ~= nil then
                if self.data.plant_def.prefab == base .. "pumpkin" then
                    self.seed_icon:SetTexture("images/inventoryimages/feast_famine.xml", "pumpkin_seeds_proxy.tex",
                        "default_image.tex") -- default image is an image that exists no matter what in the atlas, just in case it cant find the actual desired one
                end
            end
            if GLOBAL.TUNING.FAFSEEDSWATERMELON ~= nil then
                if self.data.plant_def.prefab == base .. "watermelon" then
                    self.seed_icon:SetTexture("images/inventoryimages/feast_famine.xml", "watermelon_seeds_proxy.tex",
                        "default_image.tex") -- default image is an image that exists no matter what in the atlas, just in case it cant find the actual desired one
                end
            end
            if GLOBAL.TUNING.FAFSEEDSASPARAGUS ~= nil then
                if self.data.plant_def.prefab == base .. "asparagus" then
                    self.seed_icon:SetTexture("images/inventoryimages/feast_famine.xml", "asparagus_seeds_proxy.tex",
                        "default_image.tex") -- default image is an image that exists no matter what in the atlas, just in case it cant find the actual desired one
                end
            end
            if GLOBAL.TUNING.FAFSEEDSPEPPER ~= nil then
                if self.data.plant_def.prefab == base .. "pepper" then
                    self.seed_icon:SetTexture("images/inventoryimages/feast_famine.xml", "pepper_seeds_proxy.tex",
                        "default_image.tex") -- default image is an image that exists no matter what in the atlas, just in case it cant find the actual desired one
                end
            end
            -- add more here
        end
    end

    if self and self.plant_grid and self.data and self.data.plant_def and self.data.plant_def.prefab then
        for i, widget in pairs(self.plant_grid) do
            if (i == 1 or i == 2) and widget.plant_anim then
                local anim = widget.plant_anim
                if anim.GetAnimState then
                    if (GLOBAL.TUNING.FAFSEEDSPEPPER ~= nil) and (self.data.plant_def.prefab == 'farm_plant_pepper') then
                        anim:GetAnimState():OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed10")
                    elseif (GLOBAL.TUNING.FAFSEEDSASPARAGUS ~= nil) and
                        (self.data.plant_def.prefab == 'farm_plant_asparagus') then
                        anim:GetAnimState():OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed9")
                    elseif (GLOBAL.TUNING.FAFSEEDSWATERMELON ~= nil) and
                        (self.data.plant_def.prefab == 'farm_plant_watermelon') then
                        anim:GetAnimState():OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed3")
                    elseif (GLOBAL.TUNING.FAFSEEDSPUMPKIN ~= nil) and
                        (self.data.plant_def.prefab == 'farm_plant_pumpkin') then
                        anim:GetAnimState():OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed2")
                    elseif (GLOBAL.TUNING.FAFSEEDSPOMEGRANATE ~= nil) and
                        (self.data.plant_def.prefab == 'farm_plant_pomegranate') then
                        anim:GetAnimState():OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed7")
                    elseif (GLOBAL.TUNING.FAFSEEDSEGGPLANT ~= nil) and
                        (self.data.plant_def.prefab == 'farm_plant_eggplant') then
                        anim:GetAnimState():OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed4")
                    elseif (GLOBAL.TUNING.FAFSEEDSDURIAN ~= nil) and (self.data.plant_def.prefab == 'farm_plant_durian') then
                        anim:GetAnimState():OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed5")
                    elseif (GLOBAL.TUNING.FAFSEEDSDRAGONFRUIT ~= nil) and
                        (self.data.plant_def.prefab == 'farm_plant_dragonfruit') then
                        anim:GetAnimState():OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed6")
                    elseif (GLOBAL.TUNING.FAFSEEDSCORN ~= nil) and (self.data.plant_def.prefab == 'farm_plant_corn') then
                        anim:GetAnimState():OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed1")
                    end
                end
            end
        end
    end
end)

AddClassPostConstruct("widgets/redux/plantspage", function(self, parent_widget, ismodded)
    if self and self.plant_grid then
        local _update_fn = self.plant_grid.update_fn or (function()
        end)
        self.plant_grid.update_fn = function(context, widget, data, index, ...)
            _update_fn(context, widget, data, index, ...)
            if widget and data and widget.data then
                if (GLOBAL.TUNING.FAFSEEDSPEPPER ~= nil) and (data.plant_def.prefab == 'farm_plant_pepper') then
                    widget.plant_anim:GetAnimState():OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed10")
                elseif (GLOBAL.TUNING.FAFSEEDSASPARAGUS ~= nil) and (data.plant_def.prefab == 'farm_plant_asparagus') then
                    widget.plant_anim:GetAnimState():OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed9")
                elseif (GLOBAL.TUNING.FAFSEEDSWATERMELON ~= nil) and (data.plant_def.prefab == 'farm_plant_watermelon') then
                    widget.plant_anim:GetAnimState():OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed3")
                elseif (GLOBAL.TUNING.FAFSEEDSPUMPKIN ~= nil) and (data.plant_def.prefab == 'farm_plant_pumpkin') then
                    widget.plant_anim:GetAnimState():OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed2")
                elseif (GLOBAL.TUNING.FAFSEEDSPOMEGRANATE ~= nil) and
                    (data.plant_def.prefab == 'farm_plant_pomegranate') then
                    widget.plant_anim:GetAnimState():OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed7")
                elseif (GLOBAL.TUNING.FAFSEEDSEGGPLANT ~= nil) and (data.plant_def.prefab == 'farm_plant_eggplant') then
                    widget.plant_anim:GetAnimState():OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed4")
                elseif (GLOBAL.TUNING.FAFSEEDSDURIAN ~= nil) and (data.plant_def.prefab == 'farm_plant_durian') then
                    widget.plant_anim:GetAnimState():OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed5")
                elseif (GLOBAL.TUNING.FAFSEEDSDRAGONFRUIT ~= nil) and
                    (data.plant_def.prefab == 'farm_plant_dragonfruit') then
                    widget.plant_anim:GetAnimState():OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed6")
                elseif (GLOBAL.TUNING.FAFSEEDSCORN ~= nil) and (data.plant_def.prefab == 'farm_plant_corn') then
                    widget.plant_anim:GetAnimState():OverrideSymbol("veggie_seed", "seeds_feast_swap", "seed1")
                    -- widget.plant_anim:GetAnimState():OverrideSymbol("veggie_seed", "accountitem_frame_extra", "swap_icon_common")
                end
            end
        end
        self.plant_grid:RefreshView()
    end
end)

-- GLOBAL.TUNING.PIG_ATTACK_PERIOD = 3
-- GLOBAL.TUNING.PIG_ATTACK_PERIOD = math.random(2,4)

-- GLOBAL.TUNING.WEREPIG_ATTACK_PERIOD = 2
-- GLOBAL.TUNING.WEREPIG_ATTACK_PERIOD = math.random(1,3)

--[[
PERD_ATTACK_PERIOD = 3
WALRUS_ATTACK_PERIOD = 3
LITTLE_WALRUS_ATTACK_PERIOD = 3 * 1.7
PENGUIN_ATTACK_PERIOD = 3
]]
