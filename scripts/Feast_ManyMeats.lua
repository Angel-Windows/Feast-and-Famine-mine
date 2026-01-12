GLOBAL.AddRecipePostInitAny(function(recipe)
    local ingredient = recipe:FindAndConvertIngredient("meat")
    if ingredient then
        if GetModConfigData("config_FAF_BEAR") then ingredient:AddDictionaryPrefab("bear_meat") end
        if GetModConfigData("config_FAF_DEER") then 
            --ingredient:AddDictionaryPrefab("deer_meat_autumn")
            ingredient:AddDictionaryPrefab("deer_meat", nil, "deer_meat_autumn") 
        end
        if GetModConfigData("config_FAF_DRAGON") then ingredient:AddDictionaryPrefab("dragon_meat") end
        if GetModConfigData("config_FAF_TOAD") then ingredient:AddDictionaryPrefab("toad_meat") end
        ingredient:AddDictionaryPrefab("plantmeat")
        --ingredient:AddDictionaryPrefab("monstermeat")
        --ingredient:AddDictionaryPrefab("fishmeat")
        --ingredient.allowmultipleprefabtypes = false
    end
end)

-- Set up the lootdropper (moved to modmain)
--[[
GLOBAL.TUNING.FAFDROPSWAP = {
    ["monstermeat"] = {},
    ["cookedmonstermeat"] = {},
    ["meat"] = {},
    ["cookedmeat"] = {},
    ["drumstick"] = {},
    ["drumstick_cooked"] = {},
    ["log"] = {},
}]]

AddComponentPostInit("lootdropper", function(self)
    local _SpawnLootPrefab = self.SpawnLootPrefab    
    function self:SpawnLootPrefab(lootprefab, ...)
        local _lootprefab = lootprefab
        if GLOBAL.TUNING.FAFDROPSWAPUNI[_lootprefab] ~= nil then -- universal cases
            lootprefab = GLOBAL.TUNING.FAFDROPSWAPUNI[_lootprefab]
        end
        if GLOBAL.TUNING.FAFDROPSWAP[_lootprefab] ~= nil then -- source-specific cases
            if GLOBAL.TUNING.FAFDROPSWAP[_lootprefab][self.inst.prefab] ~= nil then 
                lootprefab = GLOBAL.TUNING.FAFDROPSWAP[_lootprefab][self.inst.prefab]
            end
        end
        return _SpawnLootPrefab(self, lootprefab, ...)
    end
end)

-- Set up the drop swaps

if GetModConfigData("config_FAF_SQUID") then
    GLOBAL.TUNING.FAFDROPSWAP["monstermeat"]["squid"] = "squid_meat"
    GLOBAL.TUNING.FAFDROPSWAP["cookedmonstermeat"]["squid"] = "squid_meat_cooked"
end

if GetModConfigData("config_FAF_BEAR") then
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["bearger"] = "bear_meat"
    GLOBAL.TUNING.FAFDROPSWAP["cookedmeat"]["bearger"] = "bear_meat_cooked"
end

if GetModConfigData("config_FAF_DEER") then
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["deerclops"] = "deer_meat"
    GLOBAL.TUNING.FAFDROPSWAP["cookedmeat"]["deerclops"] = "deer_meat_cooked"
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["deer"] = "deer_meat_autumn"
    GLOBAL.TUNING.FAFDROPSWAP["cookedmeat"]["deer"] = "deer_meat_cooked"
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["deer_red"] = "deer_meat_autumn"
    GLOBAL.TUNING.FAFDROPSWAP["cookedmeat"]["deer_red"] = "deer_meat_cooked"
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["deer_blue"] = "deer_meat_autumn"
    GLOBAL.TUNING.FAFDROPSWAP["cookedmeat"]["deer_blue"] = "deer_meat_cooked"
end

if GetModConfigData("config_FAF_ROCKY") then
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["rocky"] = "rocky_meat"
    GLOBAL.TUNING.FAFDROPSWAP["cookedmeat"]["rocky"] = "rocky_meat_cooked"
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["crabking_claw"] = "rocky_meat"
    GLOBAL.TUNING.FAFDROPSWAP["cookedmeat"]["crabking_claw"] = "rocky_meat_cooked"
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["crabking"] = "rocky_meat"
    GLOBAL.TUNING.FAFDROPSWAP["cookedmeat"]["crabking"] = "rocky_meat_cooked"
end

if GetModConfigData("config_FAF_DRAGON") then
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["dragonfly"] = "dragon_meat"
    GLOBAL.TUNING.FAFDROPSWAP["cookedmeat"]["dragonfly"] = "dragon_meat_cooked"
end

if GetModConfigData("config_FAF_TOAD") then
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["toadstool"] = "toad_meat"
    GLOBAL.TUNING.FAFDROPSWAP["cookedmeat"]["toadstool"] = "toad_meat_cooked"
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["toadstool_dark"] = "toad_meat"
    GLOBAL.TUNING.FAFDROPSWAP["cookedmeat"]["toadstool_dark"] = "toad_meat_cooked"
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["toadling"] = "toad_meat"
    GLOBAL.TUNING.FAFDROPSWAP["cookedmeat"]["toadling"] = "toad_meat_cooked"
end

if GetModConfigData("config_FAF_MOOSE") then
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["moose"] = "moose_meat"
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["mossling"] = "moose_meat"
end

if GetModConfigData("config_FAF_MALB") then
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["malbatross"] = "malbatross_meat"
end

if GetModConfigData("config_FAF_ANTLION") then
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["antlion"] = "antlion_meat"
end

if GetModConfigData("config_FAF_BEEF") then
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["beefalo"] = "beefalo_meat"
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["babybeefalo"] = "beefalo_meat"
end

if GetModConfigData("config_FAF_CAT") then
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["catcoon"] = "cat_meat"
end

if GetModConfigData("config_FAF_GOAT") then
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["lightninggoat"] = "goat_meat"
end

if GetModConfigData("config_FAF_BUNNYMANMEAT") then
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["bunnyman"] = "bunnyman_meat"
end

if GetModConfigData("config_FAF_GUARDIAN") then
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["minotaur"] = "guardian_meat"
end

if GetModConfigData("config_FAF_KOALA") then
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["koalefant_summer"] = "koala_summer_meat"
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["koalefant_winter"] = "koala_winter_meat"
end

if GetModConfigData("config_FAF_BIGBIRD") then
    GLOBAL.TUNING.FAFDROPSWAP["meat"]["tallbird"] = "bigbird_meat"
    GLOBAL.TUNING.FAFDROPSWAP["cookedmeat"]["tallbird"] = "bigbird_meat_cooked"
    GLOBAL.TUNING.FAFDROPSWAP["drumstick"]["moose"] = "bigbird_meat"
    GLOBAL.TUNING.FAFDROPSWAP["drumstick_cooked"]["moose"] = "bigbird_meat_cooked"

    local teenbirdloot = { "drumstick", "drumstick"}

    AddPrefabPostInit("teenbird", function(inst)  
        if inst.components.lootdropper then
            inst.components.lootdropper:SetLoot(teenbirdloot)
        end
    end)
end

--[[
if GLOBAL.TheWorld.state.season == GLOBAL.SEASONS.SPRING then
    GLOBAL.TUNING.FAFDROPSWAP["honey"]["bee"] = "honey_killer"
    GLOBAL.TUNING.FAFDROPSWAP["honey"]["beehive"] = "honey_killer"
elseif GLOBAL.TheWorld.state.season == GLOBAL.SEASONS.SUMMER then
    GLOBAL.TUNING.FAFDROPSWAP["honey"]["bee"] = "honey_floral"
    GLOBAL.TUNING.FAFDROPSWAP["honey"]["beehive"] = "honey_floral"
else
    GLOBAL.TUNING.FAFDROPSWAP["honey"]["bee"] = "honey"
    GLOBAL.TUNING.FAFDROPSWAP["honey"]["beehive"] = "honey"
end
]]