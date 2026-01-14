require("constants")

local Milk_foods = {
    berryshake = {
        test = function(cooker, names, tags)
            return tags.dairy == 1 and tags.frozen == 1 and tags.fruit == 0.5
        end,
        priority = 1,
        weight = 1,
        foodtype = "VEGGIE",
        health = TUNING.HEALING_MEDSMALL,
        hunger = TUNING.CALORIES_MEDSMALL,
        perishtime = TUNING.PERISH_FAST,
        sanity = TUNING.SANITY_MEDLARGE,
        temperature = TUNING.COLD_FOOD_BONUS_TEMP,
        temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
        cooktime = 1
        -- potlevel = "low",
        -- floater = {"small", nil, 0.85},
    },

    fishyogurt = {
        test = function(cooker, names, tags)
            return tags.dairy == 1 and tags.fish and not tags.inedible
        end,
        priority = 1,
        weight = 1,
        foodtype = "MEAT",
        health = TUNING.HEALING_LARGE,
        hunger = TUNING.CALORIES_MED,
        perishtime = TUNING.PERISH_FAST,
        sanity = -TUNING.SANITY_MED,
        cooktime = 1.5
        -- potlevel = "low",
        -- floater = {"small", nil, 0.85},
    },

    pizza = {
        test = function(cooker, names, tags)
            return tags.cheese == 0.5 and tags.meat and tags.veggie
        end, -- edit to allow flour
        priority = 6,
        weight = 1,
        foodtype = "MEAT",
        health = TUNING.HEALING_MED,
        hunger = TUNING.CALORIES_SMALL * 5,
        perishtime = TUNING.PERISH_MED,
        sanity = TUNING.SANITY_MED,
        cooktime = 2.5
        -- potlevel = "low",
        -- floater = {"small", nil, 0.85},
    },

    cheesecake = {
        test = function(cooker, names, tags)
            return tags.white_cheese == 0.5 and tags.fruit and tags.egg and tags.sweetener and not tags.inedible and
                       not tags.meat
        end,
        priority = 1,
        weight = 1,
        foodtype = "VEGGIE",
        health = TUNING.HEALING_MED,
        hunger = TUNING.CALORIES_SMALL * 5,
        perishtime = TUNING.PERISH_MED,
        sanity = TUNING.SANITY_MEDLARGE,
        cooktime = 2,
        potlevel = "med"
        -- floater = {"small", nil, 0.85},
    }
}

for k, v in pairs(Milk_foods) do
    v.name = k
    v.weight = v.weight or 1
    v.priority = v.priority or 0
end

return Milk_foods
