local assets =
{
    Asset("ANIM", "anim/faf_seedpacket.zip"),
}

local prefabs =
{
    "ash",
    "quagmire_seedpacket_unwrap",
    "halloween_moonpuff",
}

local function onburnt(inst)
    inst.burnt = true
    inst.components.unwrappable:Unwrap()
end

local function onignite(inst)
    inst.components.unwrappable.canbeunwrapped = false
end

local function onextinguish(inst)
    inst.components.unwrappable.canbeunwrapped = true
end

local function MakeSeedPacket(rarename, seedloot1, seedloot2, seedloot3, rarity, commonnerf, moon)
    
    local function OnMoonUnwrapped(inst, pos, doer)
         if inst.burnt then
            SpawnPrefab("ash").Transform:SetPosition(pos:Get())
        else
            local seed = SpawnPrefab("moonbutterfly")
            if seed ~= nil then
                if seed.Physics ~= nil then
                    seed.Physics:Teleport(pos:Get())
                else
                    seed.Transform:SetPosition(pos:Get())
                end
                if seed.components.inventoryitem ~= nil then
                    seed.components.inventoryitem:OnDropped(true, .5)
                end
            end
            local sprout1 = SpawnPrefab("rock_avocado_fruit_sprout")     
            if sprout1 ~= nil then
                if sprout1.Physics ~= nil then
                    sprout1.Physics:Teleport(pos:Get())
                else
                    sprout1.Transform:SetPosition(pos:Get())
                end
                if sprout1.components.inventoryitem ~= nil then
                    sprout1.components.inventoryitem:OnDropped(true, .5)
                end
            end
            local sprout2 = SpawnPrefab("rock_avocado_fruit_sprout")     
            if sprout2 ~= nil then
                if sprout2.Physics ~= nil then
                    sprout2.Physics:Teleport(pos:Get())
                else
                    sprout2.Transform:SetPosition(pos:Get())
                end
                if sprout2.components.inventoryitem ~= nil then
                    sprout2.components.inventoryitem:OnDropped(true, .5)
                end
            end
            local sprout3 = SpawnPrefab("rock_avocado_fruit_sprout")     
            if sprout3 ~= nil then
                if sprout3.Physics ~= nil then
                    sprout3.Physics:Teleport(pos:Get())
                else
                    sprout3.Transform:SetPosition(pos:Get())
                end
                if sprout3.components.inventoryitem ~= nil then
                    sprout3.components.inventoryitem:OnDropped(true, .5)
                end
            end
            local sprout4 = SpawnPrefab("rock_avocado_fruit_sprout")     
            if sprout4 ~= nil then
                if sprout4.Physics ~= nil then
                    sprout4.Physics:Teleport(pos:Get())
                else
                    sprout4.Transform:SetPosition(pos:Get())
                end
                if sprout4.components.inventoryitem ~= nil then
                    sprout4.components.inventoryitem:OnDropped(true, .5)
                end
            end
            local sprout5 = SpawnPrefab("rock_avocado_fruit_sprout")     
            if sprout5 ~= nil then
                if sprout5.Physics ~= nil then
                    sprout5.Physics:Teleport(pos:Get())
                else
                    sprout5.Transform:SetPosition(pos:Get())
                end
                if sprout5.components.inventoryitem ~= nil then
                    sprout5.components.inventoryitem:OnDropped(true, .5)
                end
            end
            SpawnPrefab("halloween_moonpuff").Transform:SetPosition(pos:Get())
        end
        if doer ~= nil and doer.SoundEmitter ~= nil then
            doer.SoundEmitter:PlaySound("dontstarve/common/together/packaged")
        end
        inst:Remove()
    end

    local function OnUnwrapped(inst, pos, doer)
        if inst.burnt then
            SpawnPrefab("ash").Transform:SetPosition(pos:Get())
        else
            local loot = {seedloot1, seedloot2, seedloot3}
            local number1 = math.random(#loot)
            local seed = SpawnPrefab(loot[number1])     
            if seed ~= nil then
                if seed.Physics ~= nil then
                    seed.Physics:Teleport(pos:Get())
                else
                    seed.Transform:SetPosition(pos:Get())
                end
                if seed.components.inventoryitem ~= nil then
                    seed.components.inventoryitem:OnDropped(true, .5)
                end
            end
            local extraseeds = {}
            for i,v in pairs(VEGGIES) do
                if v.seed_weight == rarity then
                    table.insert(extraseeds, i)   
                end
            end

            local enumber1 = math.random(#extraseeds)
            local eseed1 = SpawnPrefab(extraseeds[enumber1]..tostring("_seeds")) 
            if eseed1 ~= nil then
                if eseed1.Physics ~= nil then
                    eseed1.Physics:Teleport(pos:Get())
                else
                    eseed1.Transform:SetPosition(pos:Get())
                end
                if eseed1.components.inventoryitem ~= nil then
                    eseed1.components.inventoryitem:OnDropped(true, .5)
                end
            end
            local enumber2 = math.random(#extraseeds)
            local eseed2 = SpawnPrefab(extraseeds[enumber2]..tostring("_seeds")) 
            if eseed2 ~= nil then
                if eseed2.Physics ~= nil then
                    eseed2.Physics:Teleport(pos:Get())
                else
                    eseed2.Transform:SetPosition(pos:Get())
                end
                if eseed2.components.inventoryitem ~= nil then
                    eseed2.components.inventoryitem:OnDropped(true, .5)
                end
            end   
            if extraseeds ~= nil and commonnerf == nil then
                local enumber3 = math.random(#extraseeds)
                local eseed3 = SpawnPrefab(extraseeds[enumber3]..tostring("_seeds")) 
                if math.random() < 0.66 then
                    if eseed3 ~= nil then
                        if eseed3.Physics ~= nil then
                            eseed3.Physics:Teleport(pos:Get())
                        else
                            eseed3.Transform:SetPosition(pos:Get())
                        end
                        if eseed3.components.inventoryitem ~= nil then
                            eseed3.components.inventoryitem:OnDropped(true, .5)
                        end
                    end  
                end    
            end
            SpawnPrefab("quagmire_seedpacket_unwrap").Transform:SetPosition(pos:Get())
        end
        if doer ~= nil and doer.SoundEmitter ~= nil then
            doer.SoundEmitter:PlaySound("dontstarve/common/together/packaged")
        end
        inst:Remove()
    end

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank("faf_seedpacket")
        inst.AnimState:SetBuild("faf_seedpacket")
        inst.AnimState:PlayAnimation("idle_"..tostring(rarename))
        if rarename ~= "lunar" then
            if rarename == "aromatic" then
                inst.Transform:SetScale(.7, .7, .7)
            else
                inst.Transform:SetScale(.8, .8, .8)
            end
        end

        inst:AddTag("bundle")

        inst:AddTag("unwrappable")
        
        MakeInventoryFloatable(inst)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.imagename = "seedpacket_"..tostring(rarename)
        --inst.components.inventoryitem:SetSinks(true)

        inst:AddComponent("unwrappable")
        if moon ~= nil then
            inst.components.unwrappable:SetOnUnwrappedFn(OnMoonUnwrapped)
        else
            inst.components.unwrappable:SetOnUnwrappedFn(OnUnwrapped)
        end

        MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
        MakeSmallPropagator(inst)
        inst.components.propagator.flashpoint = 10 + math.random() * 5
        inst.components.burnable:SetOnBurntFn(onburnt)
        inst.components.burnable:SetOnIgniteFn(onignite)
        inst.components.burnable:SetOnExtinguishFn(onextinguish)

        MakeHauntableLaunchAndIgnite(inst)

        return inst
    end

    return Prefab("barrenseedspacket_"..tostring(rarename), fn, assets, prefabs)
end

return 
MakeSeedPacket("common", "wheat", "corn_seeds", "cutgrass", 2.5, true), -- temporarily replaced wheat seeds with wheat and cut grass
MakeSeedPacket("seasonal", "eggplant_seeds", "watermelon_seeds", "pumpkin_seeds", 1),
MakeSeedPacket("aromatic", "pepper_seeds", "onion_seeds", "garlic_seeds", 0.75),    
MakeSeedPacket("exotic", "durian_seeds", "pomegranate_seeds", "pomegranate_seeds", 0.5),
MakeSeedPacket("lunar", nil, nil, nil, nil, nil, true)        