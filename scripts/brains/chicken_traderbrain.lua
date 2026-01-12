require "behaviours/wander"
require "behaviours/leash"
require "behaviours/faceentity"
require "behaviours/chattynode"
require "behaviours/chaseandattack"
require "behaviours/panic"

local BrainCommon = require "brains/braincommon"

local MAX_LEASH_DIST = 30
local LEASH_RETURN_DIST = 10

local MAX_WANDER_DIST = 20
local TRADE_DIST = 20
local MAX_CHASE_TIME = 10
local MAX_CHASE_DIST = 30
local SEE_TARGET_DIST = 30
local SEE_FOOD_DIST = 10
local FINDFOOD_CANT_TAGS = { "outofreach" }

local function FindFoodAction(inst)
    if inst.sg:HasStateTag("busy") then
        return
    end

    local target =
        inst.components.inventory ~= nil and
        inst.components.eater ~= nil and
        inst.components.inventory:FindItem(function(item) return inst.components.eater:CanEat(item) end) or
        nil

    if target == nil then
        local time_since_eat = inst.components.eater:TimeSinceLastEating()
        if time_since_eat == nil or time_since_eat > TUNING.PIG_MIN_POOP_PERIOD * 2 then
            local noveggie = time_since_eat ~= nil and time_since_eat < TUNING.PIG_MIN_POOP_PERIOD * 4
            target = FindEntity(inst,
                SEE_FOOD_DIST,
                function(item)
                    return item:GetTimeAlive() >= 8
                        and item.prefab ~= "mandrake"
                        and item.components.edible ~= nil
                        and (not noveggie or item.components.edible.foodtype == FOODTYPE.MEAT)
                        and inst.components.eater:CanEat(item)
                        and item:IsOnPassablePoint()
                end,
                nil,
                FINDFOOD_CANT_TAGS
            )
        end
    end

    return target ~= nil and BufferedAction(inst, target, ACTIONS.EAT) or nil
end

local function HasValidHome(inst)
    local home = inst.components.homeseeker ~= nil and inst.components.homeseeker.home or nil
    return home ~= nil
        and home:IsValid()
end

local function GoHomeAction(inst)
    if HasValidHome(inst) and not inst.components.combat.target then
        return BufferedAction(inst, inst.components.homeseeker.home, ACTIONS.GOHOME)
    end
end

local function GetHomePos(inst)
    return HasValidHome(inst) and inst.components.homeseeker:GetHomePos()
end

local function GetTraderFn(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local players = FindPlayersInRange(x, y, z, TRADE_DIST, true)
    for i, v in ipairs(players) do
        if inst.components.trader:IsTryingToTradeWithMe(v) then
            return v
        end
    end
end

local function KeepTraderFn(inst, target)
    return inst.components.trader:IsTryingToTradeWithMe(target)
end

local Chicken_TraderBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

function Chicken_TraderBrain:OnStart()
    local root =
        PriorityNode(
        {
            WhileNode(function() return not TheWorld.state.isday end, "IsNight",
                ChattyNode(self.inst, "CHICK_GO_HOME",
                        DoAction(self.inst, GoHomeAction, "go home", true ), 1)),
            BrainCommon.PanicWhenScared(self.inst, .25, "CHICK_PANIC"),
            WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire",
                ChattyNode(self.inst, "CHICK_PANIC",
                    Panic(self.inst))),
            ChaseAndAttack(self.inst, MAX_CHASE_TIME, MAX_CHASE_DIST),
            FaceEntity(self.inst, GetTraderFn, KeepTraderFn),
            DoAction(self.inst, FindFoodAction),
            Leash(self.inst, GetHomePos, MAX_LEASH_DIST, LEASH_RETURN_DIST),
			Wander(self.inst, GetHomePos, MAX_WANDER_DIST)
        }, .5)

    self.bt = BT(self.inst, root)
end

return Chicken_TraderBrain