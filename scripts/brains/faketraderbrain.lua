require "behaviours/wander"
require "behaviours/faceentity"
require "behaviours/chattynode"
require "behaviours/leash"

local MAX_WANDER_DIST = 5
local MAX_LEASH_DIST = 10
local TRADE_DIST = 20

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

local FakeTraderBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

function FakeTraderBrain:OnInitializationComplete()
    self.inst.components.knownlocations:RememberLocation("home", Point(self.inst.Transform:GetWorldPosition()))
end

function FakeTraderBrain:OnStart()
    local root = PriorityNode({ChattyNode(self.inst, "FAKE_TRADER_TALK",
        FaceEntity(self.inst, GetTraderFn, KeepTraderFn)), Leash(self.inst, function()
        return self.inst.components.knownlocations:GetLocation("home")
    end, MAX_LEASH_DIST, MAX_WANDER_DIST), Wander(self.inst, nil, MAX_WANDER_DIST)}, .5)

    self.bt = BT(self.inst, root)
end

return FakeTraderBrain
