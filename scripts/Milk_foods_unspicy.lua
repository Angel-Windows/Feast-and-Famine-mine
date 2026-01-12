require("constants")

local Milk_foods_unspicy =
{
    beefalo_milk =
    {
    test = function(cooker, names, tags) return names.rawmilk and tags.rawmilk > 3 end,
    priority = 1,
    weight = 1,
    foodtype = "GENERIC",
    health = TUNING.HEALING_SMALL,
    hunger = TUNING.CALORIES_SMALL,
    sanity = TUNING.SANITY_SMALL,
    perishtime = TUNING.PERISH_FASTISH,
    temperature = TUNING.HOT_FOOD_BONUS_TEMP,
    temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
    cooktime = 0.5,
    --potlevel = "low",
    --floater = {"small", nil, 0.85},
    },

    cheese =
    {
    test = function(cooker, names, tags) return tags.dairy and tags.dairy >= 2 end,
    priority = 1,
    weight = 1,
    foodtype = "MEAT",
    health = TUNING.HEALING_SMALL,
    hunger = TUNING.CALORIES_SMALL * 3,
    perishtime = TUNING.PERISH_SLOW,
    sanity = TUNING.SANITY_TINY,
    cooktime = 2,
    --potlevel = "low",
    --floater = {"small", nil, 0.85},
    },

    white_cheese =
    {
    test = function(cooker, names, tags) return tags.curd == 2 end,
    priority = 1,
    weight = 1,
    foodtype = "MEAT",
    health = TUNING.HEALING_SMALL,
    hunger = TUNING.CALORIES_SMALL * 5,
    perishtime = TUNING.PERISH_SLOW,
    sanity = TUNING.SANITY_TINY,
    cooktime = 2,
    --potlevel = "low",
    --floater = {"small", nil, 0.85},
    },
}

for k,v in pairs(Milk_foods_unspicy) do
	v.name = k
	v.weight = v.weight or 1
	v.priority = v.priority or 0
end

return Milk_foods_unspicy
