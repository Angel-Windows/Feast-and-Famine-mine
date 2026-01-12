local assets =
{
    Asset("ANIM", "anim/merm_trader1_build.zip"),
    Asset("ANIM", "anim/ds_pig_basic.zip"),
    Asset("ANIM", "anim/ds_pig_actions.zip"),
}

-- Not 100% happy this is bug free, only enable if the trader wanders really far away
local function onload(inst)
	for k, v in pairs(Ents) do
        if v:IsValid() and v:HasTag("chickenhouse") then
            inst.Transform:SetPosition(v.Transform:GetWorldPosition())
        end
    end
end

local function ontalk(inst, script)
	inst.SoundEmitter:PlaySound("dontstarve/creatures/merm/attack")
end

local function ShouldAcceptItem(inst, item)
	if item.components.edible and item.components.edible.foodtype == FOODTYPE.MEAT then
		return false
	end
	if item:HasTag("spicedfood") then
		return false
	end
	if item:HasTag("molebait") or item:HasTag("preparedfood") then
		return true
	end
	return false	
end

--I've added a check for the "exotictrade", "seasonaltrade" and "commontrade" tags. 
local BARRENSEEDTYPES = { "lunar", "exotic", "aromatic", "seasonal", "common" }

local function OnGetItemFromPlayer(inst, giver, item)
	inst.SoundEmitter:PlaySound("dontstarve/creatures/merm/attack")
    local tradeproduct = "seeds"
    for i, v in ipairs(BARRENSEEDTYPES) do
        if item:HasTag(v.."trade") then
            tradeproduct = "barrenseedspacket_"..v
            break
        end
    end
    
    item:Remove()
    giver.components.inventory:GiveItem(SpawnPrefab(tradeproduct), nil, inst:GetPosition())
    inst.sg:GoToState("dropitem")
end

local function OnRefuseItem(inst, item)
	inst.sg:GoToState("refuse")
end

local traderbrain = require "brains/faketraderbrain"

local function displaynamefn(inst)
	return inst.name
end

local function fake_trader()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddDynamicShadow()
	inst.entity:AddLightWatcher()
	inst.entity:AddNetwork()

	MakeCharacterPhysics(inst, 50, .5)

	inst.DynamicShadow:SetSize(1.5, .75)
	inst.Transform:SetFourFaced()

	inst:AddTag("character")
	inst:AddTag("scarytoprey")
	
	inst.AnimState:SetBank("pigman")
	inst.AnimState:SetBuild("merm_trader1_build")
	inst.AnimState:PlayAnimation("idle_loop", true)
	--inst.AnimState:OverrideSymbol("swap_hat", "hat_kelp", "swap_hat")

	--trader (from trader component) added to pristine state for optimization
	inst:AddTag("trader")

	inst:AddComponent("talker")
	inst.components.talker.fontsize = 35
	inst.components.talker.font = TALKINGFONT
	--inst.components.talker.colour = Vector3(133/255, 140/255, 167/255)
	inst.components.talker.offset = Vector3(0, -400, 0)
	inst.components.talker:MakeChatter()

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst.components.talker.ontalk = ontalk

	inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
	inst.components.locomotor.runspeed = TUNING.PIG_RUN_SPEED --5
	inst.components.locomotor.walkspeed = TUNING.PIG_WALK_SPEED --3

	inst:AddComponent("knownlocations")

	inst:AddComponent("inventory")

	inst:AddComponent("trader")
	inst.components.trader:SetAcceptTest(ShouldAcceptItem)
	inst.components.trader.onaccept = OnGetItemFromPlayer
	inst.components.trader.onrefuse = OnRefuseItem
	
	inst:AddComponent("inspectable")
	
	inst:SetBrain(traderbrain)
    inst:SetStateGraph("SGfaketrader")

	-- Not 100% happy this is bug free, only enable if the trader wanders really far away
    --inst.OnLoad = onload
	
	return inst
end

return Prefab("fake_trader", fake_trader)