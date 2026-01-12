require 'prefabutil'

local assets =
{
	Asset("ANIM", "anim/breadbox.zip"),
	Asset("ANIM", "anim/ui_bread_box_1x1.zip"),
	Asset("ATLAS", "images/feast_famine_hud.xml"),
    Asset("IMAGE", "images/feast_famine_hud.tex"),
    Asset("SOUNDPACKAGE", "sound/breadbox.fev"),
    Asset("SOUND", "sound/breadbox.fsb"),
}

local function checkItem(container, item, slot)
	if item:HasTag("breadbox_valid") then
		return true
	end
	return false
end

local container_data =
{
	widget =
    {
        slotpos = 
		{
			Vector3(0, -2.5, 0),
		},
		slotbg =
		{
			{ image = "bread_slot.tex", atlas = "images/feast_famine_hud.xml" },
		},
        animbank = "ui_bread_box_1x1", --"ui_bread_box_1x1",
        animbuild = "ui_bread_box_1x1", --"ui_bread_box_1x1",
        pos = Vector3(160, 202.5, 0),
        side_align_tip = 160,
    },
    acceptsstacks = false,
    type = "cooker",
	itemtestfn = checkItem,
}

local prefabs =
{
    "collapse_small",
}

local function onOpen(inst)
	if not inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("open", false)
		inst.SoundEmitter:PlaySound("breadbox/breadbox/breadbox_open") 
	end
end 

local function onClose(inst)
	if not inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("close")
		inst.AnimState:PushAnimation("closed", true)
		inst.SoundEmitter:PlaySound("breadbox/breadbox/breadbox_close") 
	end
end

local function onDestroyed(inst, worker)
    inst.components.lootdropper:DropLoot()
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
    end
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onBuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("closed", true)
    inst.SoundEmitter:PlaySound("breadbox/breadbox/breadbox_place") 
end

local function onSave(inst, data)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() or inst:HasTag("burnt") then
        data.burnt = true
    end
end

local function onLoad(inst, data)
    if data ~= nil and data.burnt and inst.components.burnable ~= nil then
        inst.components.burnable.onburnt(inst)
    end
end

local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
	inst.entity:AddNetwork()

	--inst.MiniMapEntity:SetIcon()

	inst:AddTag("structure")
	inst:AddTag("breadbox")
	inst:AddTag("_jester")

	inst.AnimState:SetBank("breadbox")
	inst.AnimState:SetBuild("breadbox")
	inst.AnimState:PlayAnimation("closed", true)

	MakeSnowCoveredPristine(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then    
		inst.OnEntityReplicated = function(inst)
			if inst.replica.container then 
	            inst.replica.container:WidgetSetup("breadbox", container_data)
	        end
	    end    
        return inst
    end
   
	inst:AddComponent("inspectable")
	
	inst:AddComponent("container")
	inst.components.container:WidgetSetup("breadbox", container_data)
	inst.components.container.onopenfn = onOpen
	inst.components.container.onclosefn = onClose

	inst:AddComponent("lootdropper")
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(onDestroyed)

	MakeSmallBurnable(inst, nil, nil, true)
	MakeSmallPropagator(inst)

	inst:AddComponent("hauntable")
	inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

	inst:ListenForEvent("onbuilt", onBuilt)
	MakeSnowCovered(inst)

	inst.OnSave = onSave 
	inst.OnLoad = onLoad

	return inst
end

return Prefab("breadbox", fn, assets, prefabs),
    MakePlacer("breadbox_placer", "breadbox", "breadbox", "closed")