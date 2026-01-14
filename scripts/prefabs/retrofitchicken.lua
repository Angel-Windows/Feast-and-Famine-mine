local assets = {} -- Hornet: This is kinda a bad way of doing it, but it works

local prefabs = {"fake_trader", "chickenwagon", "chickenhouse", "wheatgrass", -- "slow_farmplot",
"flower"}

local function SpawnChickenStuff(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    SpawnPrefab("chickenhouse").Transform:SetPosition(x, y, z)
    SpawnPrefab("chickenwagon").Transform:SetPosition(x - 5.4, y, z - 9.2)

    SpawnPrefab("pitchfork").Transform:SetPosition(x - 4.1, y, z + 4)

    SpawnPrefab("wheatgrass").Transform:SetPosition(x - 4.1, y, z - 8)
    SpawnPrefab("wheatgrass").Transform:SetPosition(x - 6.7, y, z - 8.5)
    SpawnPrefab("wheatgrass").Transform:SetPosition(x - 4.5, y, z - 10.6)

    SpawnPrefab("flower").Transform:SetPosition(x - 7, y, z - 4)
    SpawnPrefab("flower").Transform:SetPosition(x - 2.2, y, z - 2)
    SpawnPrefab("flower").Transform:SetPosition(x, y, z - 3)
    SpawnPrefab("flower").Transform:SetPosition(x + 2.1, y, z - 4)
    SpawnPrefab("flower").Transform:SetPosition(x + 4, y, z - 2.3)
    SpawnPrefab("flower").Transform:SetPosition(x + 3.3, y, z + .9)
    SpawnPrefab("flower").Transform:SetPosition(x + 4, y, z + 4)
    SpawnPrefab("flower").Transform:SetPosition(x - 1.75, y, z + 2.7)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:DoTaskInTime(1, SpawnChickenStuff)
    inst:DoTaskInTime(3, inst.Remove)

    return inst
end

return Prefab("retrofitchicken", fn, assets, prefabs)
