return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 3,
  height = 3,
  tilewidth = 64,
  tileheight = 64,
  properties = {},
  tilesets = {
    {
      name = "ground",
      firstgid = 1,
      filename = "E:/Users/Thompson/Downloads/tileset/ground.tsx",
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "E:/Users/Thompson/Downloads/tileset/tiles.png",
      imagewidth = 512,
      imageheight = 128,
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
      width = 3,
      height = 3,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        9, 9, 2,
        2, 6, 2,
        2, 2, 2
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
          x = 64,
          y = 32,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "chickenwagon",
          shape = "rectangle",
          x = 128,
          y = 32,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "fake_trader",
          shape = "rectangle",
          x = 63,
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
          x = 70,
          y = 102,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "flower",
          shape = "rectangle",
          x = 115,
          y = 85,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "flower",
          shape = "rectangle",
          x = 118,
          y = 127,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "sail_cloth",
          shape = "rectangle",
          x = 96,
          y = 112,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
