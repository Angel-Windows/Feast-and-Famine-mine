name = "Feast and Famine Fixed"
author = "Smurf"
version = "1.10"
description = "Feast your eyes! \n\nA collection of content and gameplay tweaks, designed to make playing with your food oh-so enjoyable. \n\n• Fancy seeds \n• Seasonal crops \n• Monster eggs \n• Much ado about honey \n• Chickens! \n• Pasta and Fish Jerky \n\n...and so much more to come."
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
        label   = "请选择语言",
        hover   = "",
        options =
        {
            {description = "英语", data = "english"},
            {description = "中文", data = "chinese"},
            {description = "Russian", data = "russ"},
        },
        default = "english",
    },
    {
        name    = "config_MonsterEggs",
        label   = "特殊的蛋",
        hover   = "用怪物肉或多汁肉喂鸟会得到特殊的蛋",
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
        default = 1,
    },
    {
        name    = "config_HoneyCrystals",
        label   = "蜂蜜结晶",
        hover   = "蜂蜜在冰箱或者寒冷处会结晶",

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

    {
        name    = "config_CarrotSoup",
        label   = "胡萝卜汤",
        hover   = "用胡萝卜做美味的汤！",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },

    {
        name    = "config_MushroomSoup",
        label   = "蘑菇汤",
        hover   = "Make terrible soup from Mushrooms!\n用蘑菇做可怕的汤！",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },

    {
        name    = "config_StoneSoup",
        label   = "石头汤",
        hover   = "喝上一碗石果汤，磕掉一颗牙",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        
        default = true,
    },
    {
        name    = "config_StewedMeat",
        label   = "迫害肉丸",
        hover   = "我倒要看看还有谁能用冰做肉丸",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },

        {
        name    = "config_JuicyCutlet",
        label   = "多汁肉片",
        hover   = "看起来确实不错",
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
        label   = "椒盐脆饼",
        hover   = "皮弗洛牛的专属料理（锅中放入多个树枝）",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },
]]
    {
        name    = "config_SeasonalSeeds",
        label   = "多样种子",
        hover   = "添加多种掉落种子",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },

    {
        name    = "config_FootballLeather",
        label   = "皮革",
        hover   = "橄榄球头盔需要用干燥的猪皮",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },

    {
        name    = "config_OtherLeather",
        label   = "更多皮革",
        hover   = "更多制作需要皮革",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },

    {
        name    = "config_Bunnymen",
        label   = "兔人调整",
        hover   = "兔人掉落",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },

    {
        name    = "config_StoneFruit",
        label   = "石果调整",
        hover   = "开采石果时获得更多石头及更少食物",
        options =
        {
            {description = "Enable",            data = true},
            {description = "Disable",           data = false},
        },
        default = true,
    },

}