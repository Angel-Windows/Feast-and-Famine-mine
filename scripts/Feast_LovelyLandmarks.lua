local lovelylandthings = {
    --"tree_oasispalm", 
    --"date_oasispalm",
    "faf_resourceswaps"
}

for k,v in pairs(lovelylandthings) do
    table.insert(PrefabFiles, v)
end

GLOBAL.TUNING.FAFDROPSWAP["log"]["deciduoustree"] = "log_birch" 
GLOBAL.TUNING.FAFDROPSWAP["log"]["moon_tree"] = "log_lunar" 
GLOBAL.TUNING.FAFDROPSWAP["log"]["marsh_tree"] = "log_spiky" 
GLOBAL.TUNING.FAFDROPSWAP["log"]["twiggytree"] = "log_twiggy" 

GLOBAL.TUNING.FAFDROPSWAP["livinglog"]["deciduoustree"] = "log_livingbirch" 


local function CheckForPrefab(prefab)
    for _, entity in pairs(GLOBAL.Ents) do
        if entity.prefab == prefab then
            return true
        end
    end
    return false
end      

AddPrefabPostInit("forest", function(inst)
    inst:DoTaskInTime(0, function()
        if inst.ismastersim then

            print("[Feast and Famine] Checking for wheat in world")
            if not CheckForPrefab("wheatgrass") then
                print("[Feast and Famine] Wheat not found, time to retrofit")
                local new_wheat_max = math.random(20, 30)
                local new_wheats = 0
                for key, entity in pairs(GLOBAL.Ents) do
                    if new_wheats > new_wheat_max then
                        break
                    end
                    if entity.prefab == "grass" then
                        local x, y, z = entity.Transform:GetWorldPosition()
                        local map_vec = GLOBAL.Vector3(x, 0, z)
                        local tile = GLOBAL.TheWorld.Map:GetTileAtPoint(map_vec:Get())
                        if (tile == GLOBAL.GROUND.GRASS) or (tile == GLOBAL.GROUND.SAVANNA) then
                            local wheat = GLOBAL.SpawnPrefab("wheatgrass")
                            if entity.components.pickable:IsBarren() and wheat.components.pickable ~= nil then
                                wheat.components.pickable:MakeBarren()
                            end
                            local poof = GLOBAL.SpawnPrefab("small_puff")
                            poof.Transform:SetPosition(x, y, z)
                            wheat.Transform:SetPosition(x, y, z)
                            entity:Remove()
                            new_wheats = new_wheats + 1
                        end
                    end
                end
                print("[Feast and Famine] Finished Generating Wheat with "..new_wheats.." as the final result")
            else
                print("[Feast and Famine] Wheat found, no need to retrofit")
            end
            -- Need a method to not retrofit pumpkins every time they're picked and the world is reloaded
            --[[
            if not CheckForPrefab("pumpkin_wild") then
                print("[Feast and Famine] pumpkin not found, time to retrofit")
                local new_pumpkin_max = math.random(5, 10)
                local new_pumpkin = 0
                for key, entity in pairs(GLOBAL.Ents) do
                    if new_pumpkin > new_pumpkin_max then
                        break
                    end
                    if entity.prefab == "carrot_planted" then
                        local x, y, z = entity.Transform:GetWorldPosition()
                        local map_vec = GLOBAL.Vector3(x, 0, z)
                        local tile = GLOBAL.TheWorld.Map:GetTileAtPoint(map_vec:Get())
                        if (tile == GLOBAL.GROUND.DECIDUOUS) then
                            local pumpkin = GLOBAL.SpawnPrefab("pumpkin_wild")
                            if entity.components.pickable:IsBarren() and pumpkin.components.pickable ~= nil then
                                wheat.components.pickable:MakeBarren()
                            end
                            local poof = GLOBAL.SpawnPrefab("small_puff")
                            poof.Transform:SetPosition(x, y, z)
                            pumpkin.Transform:SetPosition(x, y, z)
                            entity:Remove()
                            new_pumpkin = new_pumpkin + 1
                        end
                    end
                end
                print("[Feast and Famine] Finished Generating Pumpkin with "..new_pumpkin.." as the final result")
            else
                print("[Feast and Famine] Pumpkin found, no need to retrofit")
            end]]
        end
    end)
end)

-- WIP --

local SpawnPrefab = GLOBAL.SpawnPrefab

local to_sapling =
{
    "acorn_sapling",
    "twiggy_nut_sapling",
    "marblebean_sapling",
    "pinecone_sapling",
    "lumpy_sapling",
    "moonbutterfly_sapling",
}

local function onSaplingload(inst)
    local ground_tile = GLOBAL.TheWorld.Map:GetTileAtPoint(inst.Transform:GetWorldPosition())
    local pt = inst:GetPosition()    
    local ents = #GLOBAL.TheSim:FindEntities(pt.x, pt.y, pt.z, 30, {"oasislake"})
    if (ground_tile ~= GROUND.DESERT_DIRT) and (ground_tile ~= GROUND.DIRT) and ents < 1 then
	    inst.AnimState:OverrideSymbol("sand", "planted_hills", "dirt") 
	    if (ground_tile == GROUND.PEBBLEBEACH) or (ground_tile == GROUND.BEACH) then
            inst.AnimState:OverrideSymbol("sand", "planted_hills", "tropical") 
        end 
    end
end

for _, v in pairs(to_sapling) do
    AddPrefabPostInit(v, function(inst)
		inst.AnimState:SetBank("sapling")
        inst.AnimState:SetBuild("planted_hills")
        inst.AnimState:PlayAnimation("sand")
        inst.AnimState:OverrideSymbol("swap_sapling", "sapling_overrides", v)

        inst.OnLoad = onSaplingload
    end)
end

local function OnDeployMoon(inst, pt, deployer)
    local moontree = SpawnPrefab("moonbutterfly_sapling")
    if moontree then
        moontree.Transform:SetPosition(pt:Get())

	    local ground_tile = GLOBAL.TheWorld.Map:GetTileAtPoint(pt:Get())
	    --local pt = inst:GetPosition()    
	    local ents = #GLOBAL.TheSim:FindEntities(pt.x, pt.y, pt.z, 30, {"oasislake"})
	    if (ground_tile ~= GROUND.DESERT_DIRT) and (ground_tile ~= GROUND.DIRT) and ents < 1 then
	        moontree.AnimState:OverrideSymbol("sand", "planted_hills", "dirt")
	        if (ground_tile == GROUND.PEBBLEBEACH) or (ground_tile == GROUND.BEACH) then
            	moontree.AnimState:OverrideSymbol("sand", "planted_hills", "tropical") 
        	end  
	    end

        inst.components.stackable:Get():Remove()
    end
end

local function OnDeployMarble(inst, pt, deployer)
    local sapling = SpawnPrefab("marblebean_sapling")
    sapling:StartGrowing()
    sapling.Transform:SetPosition(pt:Get())
    sapling.SoundEmitter:PlaySound("dontstarve/wilson/plant_tree")

    local ground_tile = GLOBAL.TheWorld.Map:GetTileAtPoint(pt:Get())
    --local pt = inst:GetPosition()    
    local ents = #GLOBAL.TheSim:FindEntities(pt.x, pt.y, pt.z, 30, {"oasislake"})
    if (ground_tile ~= GROUND.DESERT_DIRT) and (ground_tile ~= GROUND.DIRT) and ents < 1 then
        sapling.AnimState:OverrideSymbol("sand", "planted_hills", "dirt") 
       	if (ground_tile == GROUND.PEBBLEBEACH) or (ground_tile == GROUND.BEACH) then
            sapling.AnimState:OverrideSymbol("sand", "planted_hills", "tropical") 
        end 
    end

    inst:Remove()
end

local function plantacorn(inst, growtime)
    local sapling = SpawnPrefab("acorn_sapling")
    sapling:StartGrowing()
    sapling.Transform:SetPosition(inst.Transform:GetWorldPosition())
    sapling.SoundEmitter:PlaySound("dontstarve/wilson/plant_tree")

    local ground_tile = GLOBAL.TheWorld.Map:GetTileAtPoint(inst.Transform:GetWorldPosition())
    local pt = inst:GetPosition()    
    local ents = #GLOBAL.TheSim:FindEntities(pt.x, pt.y, pt.z, 30, {"oasislake"})
    if (ground_tile ~= GROUND.DESERT_DIRT) and (ground_tile ~= GROUND.DIRT) and ents < 1 then
        sapling.AnimState:OverrideSymbol("sand", "planted_hills", "dirt")
        if (ground_tile == GROUND.PEBBLEBEACH) or (ground_tile == GROUND.BEACH) then
            sapling.AnimState:OverrideSymbol("sand", "planted_hills", "tropical") 
        end  
    end

    inst:Remove()
end

local function domonsterstop(ent)
    ent.monster_stop_task = nil
    ent:StopMonster()
end

local function OnDeployAcorn(inst, pt)
    inst = inst.components.stackable:Get()
    inst.Transform:SetPosition(pt:Get())
    local timeToGrow = GLOBAL.GetRandomWithVariance(TUNING.ACORN_GROWTIME.base, TUNING.ACORN_GROWTIME.random)
    plantacorn(inst, timeToGrow)

    -- Pacify a nearby monster tree
    local ent = GLOBAL.FindEntity(inst, TUNING.DECID_MONSTER_ACORN_CHILL_RADIUS, nil, {"birchnut", "monster"}, {"stump", "burnt", "FX", "NOCLICK","DECOR","INLIMBO"})
    if ent ~= nil then
        if ent.monster_start_task ~= nil then
            ent.monster_start_task:Cancel()
            ent.monster_start_task = nil
        end
        if ent.monster and
            ent.monster_stop_task == nil and
            not (ent.components.burnable ~= nil and ent.components.burnable:IsBurning()) and
            not (ent:HasTag("stump") or ent:HasTag("burnt")) then
            ent.monster_stop_task = ent:DoTaskInTime(math.random(0, 3), domonsterstop)
        end
    end
end

local function plantpinecone(inst, growtime)
    local sapling = SpawnPrefab(inst._spawn_prefab or "pinecone_sapling")
    sapling:StartGrowing()
    sapling.Transform:SetPosition(inst.Transform:GetWorldPosition())
    sapling.SoundEmitter:PlaySound("dontstarve/wilson/plant_tree")

    local ground_tile = GLOBAL.TheWorld.Map:GetTileAtPoint(inst.Transform:GetWorldPosition())
    local pt = inst:GetPosition()    
    local ents = #GLOBAL.TheSim:FindEntities(pt.x, pt.y, pt.z, 30, {"oasislake"})
    if (ground_tile ~= GROUND.DESERT_DIRT) and (ground_tile ~= GROUND.DIRT) and ents < 1 then
        sapling.AnimState:OverrideSymbol("sand", "planted_hills", "dirt")
        if (ground_tile == GROUND.PEBBLEBEACH) or (ground_tile == GROUND.BEACH) then
            sapling.AnimState:OverrideSymbol("sand", "planted_hills", "tropical") 
        end  
    end

    inst:Remove()
end

local function OnDeployPinecone(inst, pt, deployer)
    inst = inst.components.stackable:Get()
    inst.Physics:Teleport(pt:Get())
    local timeToGrow = GLOBAL.GetRandomWithVariance(TUNING.PINECONE_GROWTIME.base, TUNING.PINECONE_GROWTIME.random)
    plantpinecone(inst, timeToGrow)

    --tell any nearby leifs to chill out
    local ents = GLOBAL.TheSim:FindEntities(pt.x, pt.y, pt.z, TUNING.LEIF_PINECONE_CHILL_RADIUS, { "leif" })

    local played_sound = false
    for i, v in ipairs(ents) do
        local chill_chance =
            v:GetDistanceSqToPoint(pt:Get()) < TUNING.LEIF_PINECONE_CHILL_CLOSE_RADIUS * TUNING.LEIF_PINECONE_CHILL_CLOSE_RADIUS and
            TUNING.LEIF_PINECONE_CHILL_CHANCE_CLOSE or
            TUNING.LEIF_PINECONE_CHILL_CHANCE_FAR

        if math.random() < chill_chance then
            if v.components.sleeper ~= nil then
                v.components.sleeper:GoToSleep(1000)
                --AwardPlayerAchievement( "pacify_forest", deployer ) -- 2+ years of broken mod, whoops
            end
        elseif not played_sound then
            v.SoundEmitter:PlaySound("dontstarve/creatures/leif/taunt_VO")
            played_sound = true
        end
    end
end

AddPrefabPostInit("acorn", function(inst) if inst.components.deployable then inst.components.deployable.ondeploy = OnDeployAcorn end end)
AddPrefabPostInit("twiggy_nut", function(inst) if inst.components.deployable then inst.components.deployable.ondeploy = OnDeployPinecone end end)
AddPrefabPostInit("marblebean", function(inst) if inst.components.deployable then inst.components.deployable.ondeploy = OnDeployMarble end end)
AddPrefabPostInit("pinecone", function(inst) if inst.components.deployable then inst.components.deployable.ondeploy = OnDeployPinecone end end)
AddPrefabPostInit("moonbutterfly", function(inst) if inst.components.deployable then inst.components.deployable.ondeploy = OnDeployMoon end end)