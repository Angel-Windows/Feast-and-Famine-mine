local assets =
{
    Asset("ANIM", "anim/rooster_farmer_build.zip"),
    Asset("ANIM", "anim/perd.zip"),
    Asset("SOUNDPACKAGE", "sound/chickenfamily.fev"),
    Asset("SOUND", "sound/chickenfamily.fsb"),   
}

local function ontalk(inst, script)
	inst.SoundEmitter:PlaySound("chickenfamily/chickenfamily/roostertalkshort")
end

SetSharedLootTable('rooster',
{
    {'drumstick',  1.0},
    {'drumstick',  .75},
    {'strawhat', .05},
})

local MAX_TARGET_SHARES = 5
local SHARE_TARGET_DIST = 30

local rnames = {
"Reginald",
"Russet",
"Big Red",
"Robert",
"Remington",
"Roman",
"Ryker",
"Richard",
"Ross",
"Ronan",
"Romeo",
"Raymond",
"Ruben",
"Russell",
"Roland",
"Rodrigo",
"Radbourne",
"Radcliffe",
"Ruffles",
"Rayan",
"Ryan",
"Rumby",
"Rarklord",
"Robbstar",
"Rodriguez",
"Rowley",
"Rowlet",
"Raddle",
"Reese",
"Ricky",
"Rocco",
"Rodeo",
"Rollo",
"Roscoe",
"Rover",
"Rowan",
"Jerry",
"Rawling",
"Radford",
"Ragdale",
"Rampkin",
"Ramsey",
"Rathborne",
"Redfern",
"Richardson",
"Rigby",
"Robertson",
"Rosington",
"Rudkins",
"Rumford",
"Rorno",
"Au Revior",
"Robbie Robson Robenski II.",
"Raphael Robert R. Rongfrey III.",
"Roy",
"Refansson",
}

local function OnWake(inst)
	inst.SoundEmitter:KillSound("roostersleep")
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
local BARRENSEEDTYPES = { "exotic", "aromatic", "seasonal", "common" }

local function OnGetItemFromPlayer(inst, giver, item)
	inst.SoundEmitter:PlaySound("chickenfamily/chickenfamily/roostertalkshort")
	inst.components.talker:Say(STRINGS.CHICK_TALK_PROVERB.GIFT["GIFT" .. math.random(1, 8)])
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
	inst.SoundEmitter:PlaySound("chickenfamily/chickenfamily/roostertalklong")
	SpawnPrefab("slide_puff").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.sg:GoToState("refuse")
	--inst.components.talker:Say(STRINGS.CHICK_TALK_PROVERB.REFUSE["REFUSE" .. math.random(1, 46)])
	inst.components.talker:Say("No thank you!")
end

local function OnChat(inst)
	SpawnPrefab("slide_puff").Transform:SetPosition(inst.Transform:GetWorldPosition())
end

local traderbrain = require "brains/chicken_traderbrain"

local function displaynamefn(inst)
	return inst.name
end

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, SHARE_TARGET_DIST, function(dude) return dude.prefab == inst.prefab end, MAX_TARGET_SHARES)
end

local function OnNewTarget(inst, data)
    inst.components.combat:ShareTarget(data.target, SHARE_TARGET_DIST, function(dude) return dude.prefab == inst.prefab end, MAX_TARGET_SHARES)
end

local function is_egg(item)
    return item.prefab == "chicken" or (item.components.edible ~= nil  and item:HasTag("preciousegg"))
end

local function NormalRetargetFn(inst)
    return not inst:IsInLimbo()
        and FindEntity(
                inst,
                TUNING.PIG_TARGET_DIST,
                function(guy)
                return inst.components.combat:CanTarget(guy)
                    and (guy:HasTag("monster")
                        or (guy.components.inventory ~= nil and
                            guy:IsNear(inst, TUNING.BUNNYMAN_SEE_MEAT_DIST) and
                            guy.components.inventory:FindItem(is_egg) ~= nil))
                end,
                { "_combat", "_health" }, -- see entityreplica.lua
                nil,
                { "monster", "player" }
            )
        or nil
end

local function NormalKeepTargetFn(inst, target)
    return not (target.sg ~= nil and target.sg:HasStateTag("hiding")) and inst.components.combat:CanTarget(target)
end

local function battlecry(combatcmp, target)
    local strtbl =
        target ~= nil and
        target.components.inventory ~= nil and
        target.components.inventory:FindItem(is_egg) ~= nil and
        "CHICK_EGG_BATTLECRY" or
        "CHICK_BATTLECRY"
    return strtbl, math.random(#STRINGS[strtbl])
end

local function giveupstring()
    return "CHICK_GIVEUP", math.random(#STRINGS["CHICK_GIVEUP"])
end

local function chicken_trader()
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
	inst:AddTag("chickenfamily")
	inst:AddTag("scarytoprey")
	
	inst.AnimState:SetBank("perd")
	inst.AnimState:SetBuild("rooster_farmer_build")
	inst.AnimState:PlayAnimation("idle_loop", true)
	inst.Transform:SetScale(1.3, 1.3, 1.3)

	--Sneak these into pristine state for optimization
	inst:AddTag("_named")

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

	--Remove these tags so that they can be added properly when replicating components below
	inst:RemoveTag("_named")

	inst.components.talker.ontalk = ontalk

	inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
	inst.components.locomotor.runspeed = TUNING.PIG_RUN_SPEED --5
	inst.components.locomotor.walkspeed = TUNING.PIG_WALK_SPEED --3

	inst:AddComponent("named")
	inst.components.named.possiblenames = rnames
	inst.components.named:PickNewName()

	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE }, { FOODTYPE.VEGGIE })
    inst.components.eater:SetCanEatRaw()

	inst:AddComponent("inventory")

    inst:AddComponent("sleeper")

	inst:AddComponent("combat")
	inst.components.combat.GetBattleCryString = battlecry
    inst.components.combat.GetGiveUpString = giveupstring
	inst.components.combat.hiteffectsymbol = "chest"
	inst.components.combat:SetDefaultDamage(TUNING.BEARDLORD_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.PERD_ATTACK_PERIOD)
    inst.components.combat:SetKeepTargetFunction(NormalKeepTargetFn)
    inst.components.combat:SetRetargetFunction(3, NormalRetargetFn)

    inst:ListenForEvent("attacked", OnAttacked)    
    inst:ListenForEvent("newcombattarget", OnNewTarget)
    inst:ListenForEvent("chattyidle", OnChat) 
    inst:ListenForEvent("onwakeup", OnWake) 

	inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.BEEFALO_HEALTH)

    MakeMediumBurnableCharacter(inst, "pig_torso")
    MakeMediumFreezableCharacter(inst, "pig_torso")

	inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('rooster')
    inst.components.lootdropper:AddRandomLoot("bird_egg", 3)
    inst.components.lootdropper:AddRandomLoot("feather_crow", 1)
    inst.components.lootdropper:AddRandomLoot("feather_canary", 1)
    inst.components.lootdropper:AddRandomLoot("seeds", 1)
    inst.components.lootdropper.numrandomloot = 2

	inst:AddComponent("trader")
	inst.components.trader:SetAcceptTest(ShouldAcceptItem)
	inst.components.trader.onaccept = OnGetItemFromPlayer
	inst.components.trader.onrefuse = OnRefuseItem
	
	inst:AddComponent("knownlocations")
		
	inst:AddComponent("inspectable")
	
	inst:SetBrain(traderbrain)
    inst:SetStateGraph("SGchicken_trader")

    --inst.OnEntityWake = OnWake
    --inst.OnEntitySleep = OnSleep
	
	return inst
end

return Prefab("chicken_trader", chicken_trader)