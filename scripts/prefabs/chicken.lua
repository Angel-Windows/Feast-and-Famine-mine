require "stategraphs/SGchicken"

local assets =
{
	Asset("ANIM", "anim/chicken.zip"),
    Asset("SOUNDPACKAGE", "sound/chickenfamily.fev"),
    Asset("SOUND", "sound/chickenfamily.fsb"), 
}

local prefabs =
{
	"drumstick",
	"bird_egg",
	"feather_robin",
}

local chickensounds = 
{
	scream = "chickenfamily/chickenfamily/chickendeath",
	hurt = "chickenfamily/chickenfamily/chickenhurt",
}

local brain = require "brains/chickenbrain"

local cnames = {
"Becky",
"Pecky",
"Alma",
"Annie",
"Barbara",
"Betty",
"Bonnie",
"Brandy",
"Charlotte",
"Clarabelle",
"Clementine",
"Daphne",
"Dotty",
"Edwina",
"Harriet",
"Henrietta",
"Lacey",
"Lucille",
"Stella",
"Octavia",
"Millie",
"Marabelle",
"Josephine",
"Muriel",
"Loretta",
"Isabelle",
}

local function OnStartDay(inst)
    if inst.components.combat:HasTarget() ~= nil then
    	inst.components.combat:SetTarget(nil)
    end
end

local function CanShareTarget(dude)
    return not dude:IsInLimbo()
        and not dude.components.health:IsDead()
end

local function OnAttacked(inst, data)
	inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 30, CanShareTarget, 1, {"chickenfamily"})
    if math.random() < 0.15 then
        local hot = inst.components.burnable
    	if hot ~= nil and hot:IsBurning() then
            inst.components.lootdropper:SpawnLootPrefab("bird_egg_cooked")
        else
            inst.components.lootdropper:SpawnLootPrefab("bird_egg")
        end
    end
end

local function OnPickup(inst)
end

local function OnDropped(inst)
	inst.sg:GoToState("wake")
end

local function OnCookedFn(inst)
    inst.SoundEmitter:PlaySound("chickenfamily/chickenfamily/chickendeath")
end

local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 1, 0.12)

    inst.DynamicShadow:SetSize(1, 0.75)
    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("chicken")
    inst.AnimState:SetBuild("chicken")
    inst.AnimState:PlayAnimation("idle", true)

    inst:AddTag("animal")
    inst:AddTag("prey")
    inst:AddTag("chickenfamily")
    inst:AddTag("smallcreature")
    inst:AddTag("canbetrapped")
    inst:AddTag("chicken")
    inst:AddTag("preciousegg")

    --cookable (from cookable component) added to pristine state for optimization
    inst:AddTag("cookable")
    inst:AddTag("_named")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:RemoveTag("_named")

	inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
	inst.components.locomotor.runspeed = TUNING.RABBIT_RUN_SPEED

	inst:AddComponent("named")
	inst.components.named.possiblenames = cnames
	inst.components.named:PickNewName()

	inst:SetStateGraph("SGchicken")

	inst:SetBrain(brain)

	inst.sounds = chickensounds

	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.SEEDS }, { FOODTYPE.SEEDS })
    inst.components.eater:SetCanEatRaw()

	inst:AddComponent("knownlocations")

	inst:AddComponent("combat")
	inst.components.combat.hiteffectsymbol = "chest"

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(TUNING.RABBIT_HEALTH)
	inst.components.health:StartRegen(1, 8)
	
	MakeSmallBurnableCharacter(inst, "body")
	MakeTinyFreezableCharacter(inst, "chest")

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "chicken"   
    inst.components.inventoryitem.nobounce = true
    inst.components.inventoryitem.canbepickedup = false
    inst.components.inventoryitem.canbepickedupalive = true
    inst.components.inventoryitem:SetSinks(true)

    inst.components.health.murdersound = inst.sounds.scream

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:AddRandomLoot("drumstick", 3)
	inst.components.lootdropper:AddRandomLoot("bird_egg", 3)
	inst.components.lootdropper:AddRandomLoot("feather_robin", 1)
	inst.components.lootdropper.numrandomloot = 1

	inst:AddComponent("cookable")
    inst.components.cookable.product = "drumstick_cooked"
    inst.components.cookable:SetOnCookedFn(OnCookedFn)

	inst:AddComponent("inspectable")
	inst:AddComponent("sleeper")
	inst:AddComponent("tradable")

	inst:WatchWorldState("startcaveday", OnStartDay)  

	inst:ListenForEvent("attacked", OnAttacked)

	MakeFeedableSmallLivestock(inst, TUNING.RABBIT_PERISH_TIME, OnPickup, OnDropped)

	return inst
end

return Prefab("forest/animals/chicken", fn, assets, prefabs)