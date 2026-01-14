local drythings = {"fish_dried", "fishbite_dried", "tomato_rock_dried", "pasta"}

for k, v in pairs(drythings) do
    table.insert(PrefabFiles, v)
end

local ISLAND = GLOBAL.KnownModIndex:IsModEnabled("workshop-1467214795")

-- If you wish to add our fish jerky to your modded fish items, test for FaF and then add the following in a postinit:

-- if inst.components.dryable then -- (makes sure this only runs after the dryable component has been turned on)  
-- inst.components.dryable:SetProduct("fishbite_dried") -- ("fishbite_dried" is the small fish jerky while "fish_dried" is the big one)
-- inst.components.dryable:SetDriedBuildFile("meat_rack_food_mymod") -- (this points towards your mod's anim file. @Tosh somewhere if lost)
-- inst.components.dryable:SetDriedBuildFile("meat_rack_food_faf") -- (normally the ingredient and product symbols have to be in the same anim file. This changes that. NB: only available from Hook Line and Inker onwards)
-- end

local function DriedFishbiteInit(inst)
    if inst.components.dryable then
        inst.components.dryable:SetProduct("fishbite_dried")
        inst.components.dryable:SetBuildFile("meat_rack_food_faf")
        if CurrentRelease.GreaterOrEqualTo("R09_ROT_HOOKLINEANDINKER") then
            inst.components.dryable:SetDriedBuildFile("meat_rack_food_faf")
        end
    end
end

local function DriedFishInit(inst)
    if inst.components.dryable then
        inst.components.dryable:SetProduct("fish_dried")
        inst.components.dryable:SetBuildFile("meat_rack_food_faf")
        if CurrentRelease.GreaterOrEqualTo("R09_ROT_HOOKLINEANDINKER") then
            inst.components.dryable:SetDriedBuildFile("meat_rack_food_faf")
        end
    end
end

local function DriedTomatoInit(inst)
    inst:AddComponent("dryable")
    inst.components.dryable:SetProduct("tomato_rock_dried")
    inst.components.dryable:SetDryTime(TUNING.DRY_FAST)
    inst.components.dryable:SetBuildFile("meat_rack_food_faf")
end

if CurrentRelease.GreaterOrEqualTo("R09_ROT_HOOKLINEANDINKER") then
    AddPrefabPostInit("fishmeat", DriedFishInit)
    AddPrefabPostInit("fishmeat_small", DriedFishbiteInit)
end

AddPrefabPostInit("fish", DriedFishbiteInit) -- this prefab still exists, "Freshwater Fish" is different
AddPrefabPostInit("eel", DriedFishbiteInit)
AddPrefabPostInit("tomato", DriedTomatoInit)

if ISLAND then
    AddPrefabPostInit("fish_tropical", DriedFishbiteInit)
    AddPrefabPostInit("fish_small", DriedFishbiteInit)
    AddPrefabPostInit("fish_med", DriedFishInit)
    AddPrefabPostInit("swordfish_dead", DriedFishInit)
    AddPrefabPostInit("solofish_dead", DriedFishInit)
end
