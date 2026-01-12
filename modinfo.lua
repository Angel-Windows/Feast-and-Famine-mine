name = "  Feast and Famine Fixed"
author = "Tosh, Fuffles & Friends"
version = "1.10" 
description = "Feast your eyes! \n\nA collection of content and gameplay tweaks, designed to make playing with your food oh-so enjoyable. \n\n• Alternative seeds \n• Wild wheat \n• Monster eggs \n• Resource variants \n• Chickens! \n• Pasta and Fish Jerky \n\n...and so much more to come."
forumthread = ""
api_version = 10
priority = -346
dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
all_clients_require_mod = true
client_only_mod = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = 
{
	"FeastAndFamine",
}

configuration_options =
{
    {
        name    = "config_Language",
        label   = "Language",
        hover   = "",
        options =
        {
            {description = "English", data = "english"},
            {description = "中文", data = "chinese"},
            {description = "Русский", data = "russ"},
        },
        default = "english",
    },

    {name = "Title", label = "", options = {{description = "", data = ""},}, default = "",},
    {
        name = "Title",
        label = "Birdcage Tweaks",
        options = {{description = "", data = ""},},
        default = "",
    },
    {
        name    = "config_MonsterEggs",
        label   = "Monstrous Eggs",
        hover   = "Feeding Monster Meat to a bird will give you Monstrous Eggs.",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name    = "config_LeafyEggs",
        label   = "Leafy Eggs",
        hover   = "Feeding Leafy Meat to a bird will give you Leafy Eggs.",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name = "config_SeedMin",
        label = "Minimum Seeds",
        hover   = "The guaranteed number of crop seeds received from feeding a bird.",
        options = 
        {
            {description = "0", data = 0},
            {description = "1", data = 1},
            {description = "2", data = 2},
            {description = "3", data = 3},
        },
        default = 1,
    },
    {
        name = "config_SeedPlus",
        label = "Maximum Seeds",
        hover   = "The maximum number of seeds (relative to minimum seeds).",
        options = 
        {
            {description = "Min Seeds +0", data = 0},
            {description = "Min Seeds +1", data = 1},
            {description = "Min Seeds +2", data = 2},
            {description = "Min Seeds +3", data = 3},
        },
        default = 0,
    },
    
    {name = "Title", label = "", options = {{description = "", data = ""},}, default = "",},
    {
        name = "Title",
        label = "Honey Crystals",
        options = {{description = "", data = ""},},
        default = "",
    },

    {
        name    = "config_HoneyCrystals",
        label   = "Honey Crystals",
        hover   = "Honey will crystallize when placed in the fridge or exposed to the cold.",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },

    {
        name    = "config_HoneyFridge",
        label   = "Fridgable Honey",
        hover   = "Honey can be placed in the Icebox.",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },

    {name = "Title", label = "", options = {{description = "", data = ""},}, default = "",},
    {
        name = "Title",
        label = "Crockblockers",
        options = {{description = "", data = ""},},
        default = "",
    },

    {
        name    = "config_CarrotSoup",
        label   = "Carrot Soup",
        hover   = "Make awful soup with Carrots!",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },

    {
        name    = "config_MushroomSoup",
        label   = "Mushroom Soup",
        hover   = "Make terrible soup from Mushrooms!",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },

    {
        name    = "config_StoneSoup",
        label   = "Stone Soup",
        hover   = "Why not chip a tooth on a bowl of Stone Fruit Soup?",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        
        default = true,
    },
    {
        name    = "config_StewedMeat",
        label   = "Stewed Meat",
        hover   = "Who cooks Meatballs with Ice anyway?",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },

        {
        name    = "config_JuicyCutlet",
        label   = "Juicy Cutletqqqqq",
        hover   = "This Berry Cutlet looks pretty but won't fill you up!",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
--[[
    {
        name    = "config_TwiggyTreats",
        label   = "Twiggy Treats",
        hover   = "Good for Beefalo, not for you! Save those Twigs for kindling.",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
]]
    {name = "Title", label = "", options = {{description = "", data = ""},}, default = "",},
    {
        name = "Title",
        label = "Pigskin Leather",
        options = {{description = "", data = ""},},
        default = "",
    },

    {
        name    = "config_FootballLeather",
        label   = "Leather",
        hover   = "Pigskin rots. Football Helmets will require Leather made from dried Pigskin.",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },

    {
        name    = "config_OtherLeather",
        label   = "More Leather",
        hover   = "Leather replaces Pigskin in most crafting recipes.",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },

    {name = "Title", label = "", options = {{description = "", data = ""},}, default = "",},
    {
        name = "Title",
        label = "Balance Changes",
        options = {{description = "", data = ""},},
        default = "",
    },

    {
        name    = "config_StoneFruit",
        label   = "Stone Fruit Tweaks",
        hover   = "Tweaks Stone Fruit to give more rocks than food when mined.",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name    = "config_Nightlight",
        label   = "Nightlight Tweaks",
        hover   = "Nightlights will now help protect from wildfires during summer...",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },

        {name = "Title", label = "", options = {{description = "", data = ""},}, default = "",},
    {
        name = "Title",
        label = "Seed Reskins",
        options = {{description = "", data = ""},},
        default = "",
    },
    --[[{
        name    = "config_seedsall",
        label   = "Master Toggle",
        hover   = "Reskins all seeds with the Feast and Famine versions.",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = false,
    },]]
    {
        name    = "config_seedscorn",
        label   = "Corn Seeds",
        options =
        {
            {description = "Popped Seeds",            data = true},
            {description = "Clustered Seeds",           data = false},
        },
        default = true,
    },
    {
        name    = "config_seedsdragonfruit",
        label   = "Dragonfruit Seeds",
        options =
        {
            {description = "Precious Beans",            data = true},
            {description = "Bulbous Seeds",           data = false},
        },
        default = false,
    },
    {
        name    = "config_seedsdurian",
        label   = "Durian Seeds",
        options =
        {
            {description = "Smelly Seed Pods",            data = true},
            {description = "Brittle Seed Pods",           data = false},
        },
        default = true,
    },
    {
        name    = "config_seedseggplant",
        label   = "Eggplant Seeds",
        options =
        {
            {description = "Polished Seeds",            data = true},
            {description = "Swirly Seeds",           data = false},
        },
        default = true,
    },
    {
        name    = "config_seedspomegranate",
        label   = "Pomegranate Seeds",
        options =
        {
            {description = "Squishy Seeds",            data = true},
            {description = "Windblown Seeds",           data = false},
        },
        default = true,
    },
    {
        name    = "config_seedspumpkin",
        label   = "Pumpkin Seeds",
        options =
        {
            {description = "Wrapped Seeds",            data = true},
            {description = "Sharp Seeds",           data = false},
        },
        default = true,
    },
    {
        name    = "config_seedswatermelon",
        label   = "Watermelon Seeds",
        options =
        {
            {description = "Curved Seeds",            data = true},
            {description = "Square Seeds",           data = false},
        },
        default = true,
    },
    {
        name    = "config_seedsasparagus",
        label   = "Asparagus Seeds",
        options =
        {
            {description = "Spiral Seeds",            data = true},
            {description = "Tubular Seeds",           data = false},
        },
        default = true,
    },
    {
        name    = "config_seedspepper",
        label   = "Pepper Seeds",
        options =
        {
            {description = "Shrivelled Seeds",            data = true},
            {description = "Lumpy Seeds",           data = false},
        },
        default = true,
    },

    {name = "Title", label = "", options = {{description = "", data = ""},}, default = "",},
    {
        name = "Title",
        label = "Meat Variety",
        options = {{description = "", data = ""},},
        default = "",
    },
    {
        name    = "config_MoreMeat",
        label   = "Master Toggle",
        hover   = "Adds in a variety of new meat drops and mob-specific meat skins. This won't override any changes that other mods make to mob drops.",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name    = "config_FAF_SQUID",
        label   = "Squid Meat",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name    = "config_FAF_BEAR",
        label   = "Smelly Bear Meat",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name    = "config_FAF_DEER",
        label   = "Venison (Deer Meat)",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name    = "config_FAF_ROCKY",
        label   = "Rocky Meat",
        hover   = "Added to both Rock Lobsters and the Crab King.",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name    = "config_FAF_DRAGON",
        label   = "Dragon Meat",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name    = "config_FAF_TOAD",
        label   = "Toad Meat",
        hover   = "Compatible with Uncompromising Mode.",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name    = "config_FAF_BIGBIRD",
        label   = "Jumbo Drumsticks",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name    = "config_FAF_MOOSE",
        label   = "Moose/Goose Meat Reskin",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name    = "config_FAF_MALB",
        label   = "Malbatross Meat Reskin",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name    = "config_FAF_ANTLION",
        label   = "Antlion Meat Reskin",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name    = "config_FAF_BEEF",
        label   = "Beefalo Meat Reskin",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name    = "config_FAF_CAT",
        label   = "Catcoon Meat Reskin",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name    = "config_FAF_GOAT",
        label   = "Goat Meat Reskin",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name    = "config_FAF_BUNNYMANMEAT",
        label   = "Bunnyman Meat Reskin",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name    = "config_FAF_GUARDIAN",
        label   = "Guardian Meat Reskin",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
    {
        name    = "config_FAF_KOALA",
        label   = "Koalephant Meat Reskin",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
}
