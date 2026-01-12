require("constants")

local feast_foods =
{

    jelly_crown =
    {
        test = function(cooker, names, tags) return names.royal_jelly and names.boneshard and not tags.monster end,
        priority = 12,
        foodtype = "GOODIES",
        health = 0,
        hunger = TUNING.CALORIES_MED,
        perishtime = nil, -- not perishable
        sanity = TUNING.SANITY_TINY,
        cooktime = 2.5,
        potlevel = "low",
        tags = {"honeyed"},
        stacksize = 3,
        prefabs = { "hungerregenbuff" },
        oneatenfn = function(inst, eater)
            if eater.components.debuffable ~= nil and eater.components.debuffable:IsEnabled() and
                not (eater.components.health ~= nil and eater.components.health:IsDead()) and
                not eater:HasTag("playerghost") then
                eater.components.debuffable:AddDebuff("hungerregenbuff", "hungerregenbuff")
            end
        end,
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_jelly_crown.xml" -- for the hi-res images in the cookbook. pm me if you're trying to replicate this and need help :) - Tosh 
        --oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_DUST_MOTH_FOOD
    },

    jelly_turkish =
    {
        test = function(cooker, names, tags) return names.royal_jelly and (names.acorn_cooked or names.petals_rose) and not tags.inedible and not tags.monster end,
        priority = 12,
        foodtype = "GOODIES",
        health = 0,
        hunger = 0,
        perishtime = nil, -- not perishable
        sanity = TUNING.SANITY_TINY,
        cooktime = 2.5,
        potlevel = "low",
        tags = {"honeyed"},
        stacksize = 3,
        prefabs = { "sanityregenbuff" },
        oneatenfn = function(inst, eater)
            if eater.components.debuffable ~= nil and eater.components.debuffable:IsEnabled() and
                not (eater.components.health ~= nil and eater.components.health:IsDead()) and
                not eater:HasTag("playerghost") then
                eater.components.debuffable:AddDebuff("sanityregenbuff", "sanityregenbuff")
            end
        end,
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_jelly_turkish.xml"
        --oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_DUST_MOTH_FOOD
    },

    --------------------------------------------
    
    trunk_potroast =
    {
        test = function(cooker, names, tags) 
        return (names.trunk_summer or names.trunk_winter or names.trunk_cooked or names.trunk_winter_cooked) and (names.potato or names.potato_cooked) and (names.carrot or names.carrot_cooked) end,
        
        priority = 10,
        weight = 1,
        foodtype = "MEAT",
        health = TUNING.HEALING_MED,
        hunger = TUNING.CALORIES_LARGE*4,
        perishtime = TUNING.PERISH_MED,
        sanity = TUNING.SANITY_TINY,    
        temperature = TUNING.HOT_FOOD_BONUS_TEMP,
        temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
        cooktime = 2.5,
        potlevel = "low",
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_trunk_potroast.xml"
    },

    pie_cannibal =
    {
        test = function(cooker, names, tags) 
        return (names.humanmeat or names.humanmeat_cooked or names.humanmeat_dried)
        end,

        priority = 10,
        weight = 1,
        foodtype = "MEAT",
        health = TUNING.HEALING_SMALL,
        hunger = TUNING.CALORIES_MED,
        perishtime = TUNING.PERISH_MED,
        sanity = -TUNING.SANITY_LARGE*2,
        cooktime = 0.5,
        tags = {"monstermeat"},
        naughtiness = 50,
        potlevel = "med",
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_pie_cannibal.xml"
        --oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_DUST_MOTH_FOOD
    },

    --------------------------------------------

    cake_carrot =
    {
        test = function(cooker, names, tags) 
        return tags.carrot and names.acorn_cooked and tags.sweetener end,

        priority = 10,
        weight = 1,
        foodtype = "VEGGIE",
        health = 0,
        hunger = 50,
        perishtime = TUNING.PERISH_MED,
        sanity = TUNING.SANITY_SMALL,
        cooktime = 2,
        tags = {"honeyed"},
        potlevel = "low",
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_cake_carrot.xml"
    },

    --------------------------------------------

    bread =
    {
        test = function(cooker, names, tags) 
        return tags.flour and not tags.monster end,

        priority = -1,
        weight = 1,
        foodtype = "VEGGIE",
        health = 0,
        hunger = TUNING.CALORIES_SMALL*5,
        perishtime = TUNING.PERISH_SLOW,
        sanity = 0,
        cooktime = 0.5,
        potlevel = "low",
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_bread.xml"
    },

    bread_cheese =
    {
        test = function(cooker, names, tags) return tags.flour and tags.cheese and not tags.monster end,
        priority = 1,
        foodtype = "GOODIES",
        health = TUNING.HEALING_SMALL,
        hunger = TUNING.CALORIES_SMALL*5,
        perishtime = TUNING.PERISH_SLOW,
        sanity = TUNING.SANITY_SMALL,
        cooktime = 0.5,
        potlevel = "high",
        stacksize = 2,
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_bread_cheese.xml"
    },

    bread_jam =
    {
        test = function(cooker, names, tags) return tags.flour and tags.fruit and tags.fruit >= 1 and not tags.monster end,
        priority = 1,
        foodtype = "VEGGIE",
        health = TUNING.HEALING_SMALL,
        hunger = TUNING.CALORIES_SMALL*4,
        perishtime = TUNING.PERISH_SLOW,
        sanity = TUNING.SANITY_TINY,
        cooktime = 0.5,
        potlevel = "med",
        stacksize = 2,
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_bread_jam.xml"
    },

    bread_garlic =
    {
        test = function(cooker, names, tags) return tags.flour and (names.garlic or names.garlic_cooked) and not tags.monster end,
        priority = 1,
        foodtype = "VEGGIE",
        health = TUNING.HEALING_MED,
        hunger = TUNING.CALORIES_SMALL*5,
        perishtime = TUNING.PERISH_SLOW,
        sanity = TUNING.SANITY_TINY,
        cooktime = 0.5,
        potlevel = "med",
        stacksize = 2,
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_bread_garlic.xml"
    },

    bread_rocky =
    {
        test = function(cooker, names, tags) return tags.flour and tags.shellfish and not tags.monster end,
        priority = 30,
        foodtype = "MEAT",
        health = TUNING.HEALING_HUGE*0.5,
        hunger = TUNING.CALORIES_SMALL*5,
        perishtime = TUNING.PERISH_SLOW,
        sanity = TUNING.SANITY_SMALL*0.5,
        cooktime = 0.5,
        potlevel = "high",
        stacksize = 2,
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_bread_rocky.xml"
    },

    --------------------------------------------

    pasta_fetuccini =
    {
        test = function(cooker, names, tags) 
        return tags.noodle and not tags.monster end,

        priority = 10,
        weight = 1,
        foodtype = "VEGGIE",
        health = TUNING.HEALING_MED,
        hunger = 100,
        perishtime = TUNING.PERISH_SLOW,
        sanity = TUNING.SANITY_TINY,
        cooktime = 1,
        potlevel = "low",
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_pasta_fetuccini.xml"
    },

    pasta_mac =
    {
        test = function(cooker, names, tags) 
        return tags.noodle and tags.cheese and not tags.monster end,

        priority = 12,
        weight = 1,
        foodtype = "GOODIES",
        health = TUNING.HEALING_HUGE,
        hunger = 100,
        perishtime = TUNING.PERISH_SLOW,
        sanity = TUNING.SANITY_TINY,
        cooktime = 1,
        potlevel = "low",
        stacksize = 2,
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_pasta_mac.xml"
    },

    pasta_meatball =
    {
        test = function(cooker, names, tags) 
        return tags.noodle and tags.meat and (names.tomato or names.tomato_cooked or names.tomato_rock_dried) end,

        priority = 12,
        weight = 1,
        foodtype = "MEAT",
        health = TUNING.HEALING_MED,
        hunger = TUNING.CALORIES_LARGE*4,
        perishtime = TUNING.PERISH_SLOW,
        sanity = TUNING.SANITY_TINY,
        cooktime = 1,
        potlevel = "low",
        stacksize = 2,
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_pasta_meatball.xml"
    },

    pasta_manicotti =
    {
        test = function(cooker, names, tags) 
        return tags.noodle and tags.white_cheese and (names.tomato or names.tomato_cooked or names.tomato_rock_dried) and not tags.monster end,

        priority = 12,
        weight = 1,
        foodtype = "GOODIES",
        health = TUNING.HEALING_MED,
        hunger = 100,
        perishtime = TUNING.PERISH_SLOW,
        sanity = TUNING.SANITY_LARGE,
        cooktime = 1,
        potlevel = "med",
        stacksize = 2,
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_pasta_manicotti.xml"
    },

    pasta_rocky =
    {
        test = function(cooker, names, tags) 
        return tags.noodle and tags.shellfish and not tags.monster end,

        priority = 30,
        weight = 1,
        foodtype = "MEAT",
        health = TUNING.HEALING_MED,
        hunger = 100,
        perishtime = TUNING.PERISH_SLOW,
        sanity = TUNING.SANITY_HUGE,
        cooktime = 1,
        potlevel = "med",
        stacksize = 2,
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_pasta_rocky.xml"
    },
}

if TUNING.FAFCARROTSOUP then
    feast_foods.soup_carrot =
    {
        test = function(cooker, names, tags) 
        return tags.carrot and tags.carrot >= 2 end,

        priority = 1,
        weight = 1,
        foodtype = "VEGGIE",
        health = 0,
        hunger = TUNING.CALORIES_MED,
        perishtime = TUNING.PERISH_SLOW,
        sanity = TUNING.SANITY_SUPERTINY,
        cooktime = 0.5,
        potlevel = "low",
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_soup_carrot.xml"
    }
end 

if TUNING.FAFMUSHROOMSOUP then
    feast_foods.soup_mushroom =
    {
        test = function(cooker, names, tags) 
        return tags.mushrooms and tags.mushrooms >= 2 end,

        priority = 1,
        weight = 1,
        foodtype = "VEGGIE",
        health = 0,
        hunger = TUNING.CALORIES_MED,
        perishtime = TUNING.PERISH_SLOW,
        sanity = TUNING.SANITY_SUPERTINY,
        cooktime = 0.5,
        potlevel = "low",
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_soup_mushroom.xml"
    }
end 

if TUNING.FAFSTONESOUP then
    feast_foods.soup_stone =
    {
        test = function(cooker, names, tags) 
        return tags.stone and tags.stone >= 2 end,
        
        priority = 1,
        weight = 1,
        foodtype = "VEGGIE",
        health = 0,
        hunger = TUNING.CALORIES_MED,
        perishtime = TUNING.PERISH_SLOW,
        sanity = -TUNING.SANITY_TINY,
        cooktime = 0.5,
        potlevel = "low",
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_soup_stone.xml"
    }
end 

if TUNING.FAFSTEWEDMEAT then
    feast_foods.stewed_meat =
    {
        test = function(cooker, names, tags) 
        return tags.meat
        and tags.meat <= 2 
        and (tags.frozen and tags.frozen >= 2)
        and not tags.inedible
        and not names.rabbit
        end,
        
        priority = 10,
        weight = 1,
        foodtype = "MEAT",
        health = 0,
        hunger = TUNING.CALORIES_LARGE,
        perishtime = TUNING.PERISH_MED,
        sanity = TUNING.SANITY_SUPERTINY,
        cooktime = 0.5,
        potlevel = "low",
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_stewed_meat.xml"
    }
end

if TUNING.FAFJUICYCUTLET then
    feast_foods.berry_cutlet =
    {
        test = function(cooker, names, tags) 
        return tags.meat 
        and tags.berries 
        and tags.berries >= 1
        and not tags.inedible
        end,

        priority = 0,
        weight = 1,
        foodtype = "MEAT",
        health = 0,
        hunger = TUNING.CALORIES_LARGE,
        perishtime = TUNING.PERISH_MED,
        sanity = TUNING.SANITY_TINY,
        cooktime = 2,
        potlevel = "med",
        floater = {"small", nil, 0.85},
        cookbook_atlas = "images/cookbook_berry_cutlet.xml"
    }
end

for k,v in pairs(feast_foods) do
	v.name = k
	v.weight = v.weight or 1
	v.priority = v.priority or 0
end

return feast_foods