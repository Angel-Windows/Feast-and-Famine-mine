return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 5,
  height = 5,
  tilewidth = 64,
  tileheight = 64,
  properties = {},
  tilesets = {
    {
      name = "ground",
      firstgid = 1,
      filename = "../../../../tools/tiled/dont_starve/ground.tsx",
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "../../../../tools/tiled/dont_starve/tiles.png",
      imagewidth = 512,
      imageheight = 256,
      properties = {},
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "BG_TILES",
      x = 0,
      y = 0,
      width = 5,
      height = 5,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      --[[data = {
        5, 5, 5, 2, 5,
        5, 6, 6, 2, 2,
        2, 6, 6, 2, 5,
        2, 2, 2, 2, 5,
        5, 5, 5, 2, 5
      }]]
            data = {
        0, 0, 0, 2, 0,
        0, 6, 6, 2, 2,
        2, 6, 6, 2, 0,
        2, 2, 2, 2, 0,
        0, 0, 0, 2, 0
      }
    },
    {
      type = "objectgroup",
      name = "FG_OBJECTS",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "chickenhouse",
          shape = "rectangle",
          x = 128,
          y = 128,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "chickenwagon",
          shape = "rectangle",
          x = 276,
          y = 42,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "fake_trader",
          shape = "rectangle",
          x = 42,
          y = 42,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "pitchfork",
          shape = "rectangle",
          x = 64,
          y = 63,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        --[[{
          name = "",
          type = "compostingbin",
          shape = "rectangle",
          x = 176,
          y = 275,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },]]
        {
          name = "",
          type = "fertilizer",
          shape = "rectangle",
          x = 110,
          y = 275,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "compostingbin",
          shape = "rectangle",
          x = 128,
          y = 275,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "wheatgrass",
          shape = "rectangle",
          x = 276,
          y = 151,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "wheatgrass",
          shape = "rectangle",
          x = 291,
          y = 177,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "wheatgrass",
          shape = "rectangle",
          x = 274,
          y = 206,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "wheatgrass",
          shape = "rectangle",
          x = 290,
          y = 234,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "wheatgrass",
          shape = "rectangle",
          x = 272,
          y = 263,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "grass",
          shape = "rectangle",
          x = 297,
          y = 56,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "grass",
          shape = "rectangle",
          x = 264,
          y = 22,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "grass",
          shape = "rectangle",
          x = 256,
          y = 63,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "flower",
          shape = "rectangle",
          x = 165,
          y = 193,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "flower",
          shape = "rectangle",
          x = 86,
          y = 100,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "flower",
          shape = "rectangle",
          x = 114,
          y = 182,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "flower",
          shape = "rectangle",
          x = 176,
          y = 127,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "flower",
          shape = "rectangle",
          x = 162,
          y = 93,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "flower",
          shape = "rectangle",
          x = 191,
          y = 64,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "flower",
          shape = "rectangle",
          x = 193,
          y = 162,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "flower",
          shape = "rectangle",
          x = 62,
          y = 193,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
