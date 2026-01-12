-- From Craft Pot --

-- define or redefine global variable to store tag data
global("FOODTAGDEFINITIONS")
FOODTAGDEFINITIONS = FOODTAGDEFINITIONS or {}

--
-- A public API for ingredient tag management
-- This function should be used by modders to add info about food tags, specifically atlas
-- Function performs merge, so it is safe to call multiple times or with different data
--
-- So Far TagData only takes following keys: atlas, tex, name
global("AddFoodTag")
AddFoodTag = function(tag, data)
  local mergedData = FOODTAGDEFINITIONS[tag] or {}

  for k, v in pairs(data) do
    mergedData[k] = v
  end

  FOODTAGDEFINITIONS[tag] = mergedData
end

-- common tags
AddFoodTag('flour', { name= 'Flour', atlas="images/feast_food_tags.xml" })
AddFoodTag('noodle', { name= 'Pasta', atlas="images/feast_food_tags.xml" })
AddFoodTag('carrot', { name= 'Carrots', atlas="images/feast_food_tags.xml" })
AddFoodTag('mushrooms', { name= 'Mushrooms', atlas="images/feast_food_tags.xml" })
AddFoodTag('mushrooms_blue', { name= 'Blue Caps', atlas="images/feast_food_tags.xml" })
AddFoodTag('mushrooms_green', { name= 'Green Caps', atlas="images/feast_food_tags.xml" })
AddFoodTag('mushrooms_red', { name= 'Red Caps', atlas="images/feast_food_tags.xml" })
AddFoodTag('stone', { name= 'Stone Fruit', atlas="images/feast_food_tags.xml" })
AddFoodTag('sugar', { name= 'High-Fructose', atlas="images/feast_food_tags.xml" })
AddFoodTag('cheese', { name= 'Cheese', atlas="images/feast_food_tags.xml" })
AddFoodTag('berries', { name= 'Berries', atlas="images/feast_food_tags.xml" })
AddFoodTag('shellfish', { name= 'Shellfish', atlas="images/feast_food_tags.xml" })
AddFoodTag('poultry', { name= 'Poultry', atlas="images/feast_food_tags.xml" })
AddFoodTag('frogmeat', { name= 'Frog Meat', atlas="images/feast_food_tags.xml" })
AddFoodTag('honey', { name= 'Raw Honey', atlas="images/feast_food_tags.xml" })
AddFoodTag('plantmeat', { name= 'Leafy Eats', atlas="images/feast_food_tags.xml" })
