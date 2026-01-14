GLOBAL.package.loaded["librarymanager"] = nil
local AutoSubscribeAndEnableWorkshopMods = GLOBAL.require("librarymanager")
AutoSubscribeAndEnableWorkshopMods({"workshop-1378549454"})

GLOBAL.require("map/terrain")

local require = GLOBAL.require
local ModManager = GLOBAL.ModManager
local Layouts = require("map/layouts").Layouts
local StaticLayout = require("map/static_layout")
local ISLAND = GLOBAL.KnownModIndex:IsModEnabled("workshop-1467214795")
local TROPEX = GLOBAL.KnownModIndex:IsModEnabled("workshop-1505270912")

Layouts["chickenfamily"] = StaticLayout.Get("map/static_layouts/chickenfamily")
Layouts["chickenholiday"] = StaticLayout.Get("map/static_layouts/chickenholiday")

--[[
if not TROPEX then
    if ISLAND then
        AddTaskSetPreInitAny(function(tasksetdata)
            if tasksetdata.location ~= "forest" then 
                return
            end
            tasksetdata.set_pieces["chickenholiday"] = { count = 1, tasks={"HomeIslandSmallBoon_Road",}} 
        end)

        AddLevelPreInitAny(function(level)
            Layouts["chickenholiday"].fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN
        end)

        AddLevelPreInitAny(function(level)
            if level.location ~= "forest" then 
                return
            end
            if level.ordered_story_setpieces == nil then 
                    level.ordered_story_setpieces = {}
            end
            table.insert(level.ordered_story_setpieces, "chickenholiday")
        end)
    else
        AddTaskSetPreInitAny(function(tasksetdata)
            if tasksetdata.location ~= "forest" then 
                return
            end
            tasksetdata.set_pieces["chickenfamily"] = { count = 1, tasks={"Great Plains",}} 
        end)
        AddLevelPreInitAny(function(level)
            Layouts["chickenfamily"].fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN
        end)

        AddLevelPreInitAny(function(level)
            if level.location ~= "forest" then 
                return
            end
            if level.ordered_story_setpieces == nil then 
                    level.ordered_story_setpieces = {}
            end
            table.insert(level.ordered_story_setpieces, "chickenfamily")
        end)
    end
end]]

--[[
if #ModManager.mods > 1 then
    local _InitializeModMain = ModManager.InitializeModMain
    function ModManager:InitializeModMain(_modname, env, mainfile, ...)
        local rets = {_InitializeModMain(self, _modname, env, mainfile, ...)}
        if self.mods[#self.mods].modname == _modname then
            Layouts["Oasis"] = require("map/static_layouts/oasispalm")
        end
        return GLOBAL.unpack(rets) 
    end
else
    Layouts["Oasis"] = require("map/static_layouts/oasispalm")
end]]

AddRoomPreInit("BGDeciduous", function(room)
    room.contents.countprefabs.pumpkin_wild = 0 + math.random(3)
end)
GLOBAL.terrain.filter.pumpkin_wild = {GLOBAL.GROUND.ROAD, GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CARPET,
                                      GLOBAL.GROUND.CHECKER, GLOBAL.GROUND.ROCKY, GLOBAL.GROUND.MARSH}

--[[
AddRoomPreInit("BGSavanna", function(room) room.contents.distributeprefabs.wheatgrass = 0.01 end)
AddRoomPreInit("BarePlain", function(room) room.contents.distributeprefabs.wheatgrass = 0.9 end)
AddRoomPreInit("Plain", function(room) room.contents.distributeprefabs.wheatgrass = 0.01 end)
AddRoomPreInit("BeefalowPlain", function(room) room.contents.distributeprefabs.wheatgrass = 0.01 end)
AddRoomPreInit("BGGrass", function(room) room.contents.countprefabs.wheatgrass = 0 + math.random(3) end)

GLOBAL.terrain.filter.wheatgrass = {GLOBAL.GROUND.ROAD, GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CARPET, GLOBAL.GROUND.CHECKER, GLOBAL.GROUND.ROCKY, GLOBAL.GROUND.MARSH}
]]
