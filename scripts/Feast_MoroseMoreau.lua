local occultthings = {
  "pigskin_leather",
}

for k,v in pairs(occultthings) do
    table.insert(PrefabFiles, v)
end

if GetModConfigData("config_OtherLeather") then
    TUNING.OTHERLEATHER = true
end

-- fix to stop the pigskin rocking 
local function onstartdryingnew(inst, ingredient, buildfile)
    if ingredient == "pigskin" then
    	if POPULATING then
	    	inst.AnimState:PlayAnimation("idle_full")
	    else
	    	inst.AnimState:PlayAnimation("idle_full")
	    end
	end
	if ingredient ~= "pigskin" then
	    if POPULATING then
	        inst.AnimState:PlayAnimation("drying_loop", true)
	    else
	        inst.AnimState:PlayAnimation("drying_pre")
	        inst.AnimState:PushAnimation("drying_loop", true)
	    end
	end
  if ingredient == "pigskin" and inst:GetSkinName() ~= nil then
    inst.AnimState:OverrideSymbol("swap_dried", "meat_rack_food_faf", "pigskin_alt")
  else
    inst.AnimState:OverrideSymbol("swap_dried", buildfile or "meat_rack_food", ingredient)
  end
end

local function ondonedryingnew(inst, product, buildfile)
    if POPULATING then
        inst.AnimState:PlayAnimation("idle_full")
    else
        inst.AnimState:PlayAnimation("drying_pst")
        inst.AnimState:PushAnimation("idle_full", false)
    end
    if product == "pigskin_leather" and inst:GetSkinName() ~= nil then
      inst.AnimState:OverrideSymbol("swap_dried", "meat_rack_food_faf", "pigskin_leather_alt")
    else
      inst.AnimState:OverrideSymbol("swap_dried", buildfile or "meat_rack_food", product)
    end
end

local function LeatherRackInit(inst)
  	if inst.components.dryer then
  	inst.components.dryer:SetStartDryingFn(onstartdryingnew)
    inst.components.dryer:SetDoneDryingFn(ondonedryingnew)
	end
end

local function hermitonstartdryingnew(inst, ingredient, buildfile)
    if ingredient == "pigskin" then
      if POPULATING then
        inst.AnimState:PlayAnimation("idle_full")
      else
        inst.AnimState:PlayAnimation("idle_full")
      end
  end
  if ingredient ~= "pigskin" then
      if POPULATING then
          inst.AnimState:PlayAnimation("drying_loop", true)
      else
          inst.AnimState:PlayAnimation("drying_pre")
          inst.AnimState:PushAnimation("drying_loop", true)
      end
  end
  if ingredient == "pigskin" or "pasta_wet" or "tomato" then
    inst.AnimState:OverrideSymbol("swap_dried", "meat_rack_food_faf", ingredient.."_hermit")
  else
    inst.AnimState:OverrideSymbol("swap_dried", buildfile or "meat_rack_food", ingredient)
  end
end

local function hermitondonedryingnew(inst, product, buildfile)
    if POPULATING then
        inst.AnimState:PlayAnimation("idle_full")
    else
        inst.AnimState:PlayAnimation("drying_pst")
        inst.AnimState:PushAnimation("idle_full", false)
    end
    if product == "pigskin_leather" or "pasta_dry" or "tomato_rock_dried" then
      inst.AnimState:OverrideSymbol("swap_dried", "meat_rack_food_faf", product.."_hermit")
    else
      inst.AnimState:OverrideSymbol("swap_dried", buildfile or "meat_rack_food", product)
    end
end

local function HermitLeatherRackInit(inst)
    if inst.components.dryer then
    inst.components.dryer:SetStartDryingFn(hermitonstartdryingnew)
    inst.components.dryer:SetDoneDryingFn(hermitondonedryingnew)
  end
end

-- cheating a non-perishable item onto the drying rack
AddComponentPostInit("dryer", function(self)
    local _StartDrying = self.StartDrying
    
    function self:StartDrying(dryable, ...)
        if dryable.components.dryable ~= nil and dryable.components.perishable == nil then
            dryable:AddComponent("perishable")
        end
        
        return _StartDrying(self, dryable, ...)
    end
end)

local function PigLeatherInit(inst)
  inst:AddComponent("dryable")
  inst.components.dryable:SetProduct("pigskin_leather")
  inst.components.dryable:SetDryTime(TUNING.DRY_MED)
  inst.components.dryable:SetBuildFile("meat_rack_food_faf")
  inst.components.dryable:SetDriedBuildFile("meat_rack_food_faf")

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_PRESERVED)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"
end

AddPrefabPostInit("pigskin", PigLeatherInit)
AddPrefabPostInit("meatrack", LeatherRackInit)
AddPrefabPostInit("meatrack_hermit", HermitLeatherRackInit)

GLOBAL.AllRecipes["footballhat"].ingredients = {Ingredient("pigskin_leather", 1), Ingredient("rope", 1)}
GLOBAL.AllRecipes["armordragonfly"].ingredients = {Ingredient("dragon_scales", 1), Ingredient("armorwood", 1), Ingredient("pigskin_leather", 3)}

if TUNING.OTHERLEATHER then
GLOBAL.AllRecipes["saddle_basic"].ingredients = {Ingredient("beefalowool", 4), Ingredient("pigskin_leather", 4), Ingredient("goldnugget", 4)}
GLOBAL.AllRecipes["goggleshat"].ingredients = {Ingredient("goldnugget", 1), Ingredient("pigskin_leather", 1)}
GLOBAL.AllRecipes["deserthat"].ingredients = {Ingredient("goggleshat", 1), Ingredient("pigskin_leather", 1)}
GLOBAL.AllRecipes["umbrella"].ingredients = {Ingredient("twigs", 6), Ingredient("pigskin_leather", 1), Ingredient("silk", 2)}
GLOBAL.AllRecipes["reflectivevest"].ingredients = {Ingredient("rope", 1), Ingredient("feather_robin", 3), Ingredient("pigskin_leather", 2)}
GLOBAL.AllRecipes["piggyback"].ingredients = {Ingredient("pigskin_leather", 4), Ingredient("silk", 6), Ingredient("rope", 2)}
GLOBAL.AllRecipes["onemanband"].ingredients = {Ingredient("goldnugget", 2),Ingredient("nightmarefuel", 4),Ingredient("pigskin_leather", 2)}
GLOBAL.AllRecipes["antlionhat"].ingredients ={Ingredient("beefalowool", 5), Ingredient("pigskin_leather", 3), Ingredient("townportaltalisman", 1)}
if TIDDLES then GLOBAL.AllRecipes["hat_tiddlevirus"].ingredients = {Ingredient("petals", 6), Ingredient("pigskin_leather", 1), Ingredient("goldnugget", 2)} end
end