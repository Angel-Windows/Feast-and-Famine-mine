local assets =
{
    Asset("ANIM", "anim/logs.zip"), 
}

local function create_livinglog_alt(name)
    local function fn()
        local inst = CreateEntity()
        
        local newinst = SpawnPrefab("livinglog")
        newinst.components.inventoryitem:ChangeImageName("log_"..name)
        newinst.AnimState:SetBank("logs")
        newinst.AnimState:SetBuild("logs")
        newinst.AnimState:PlayAnimation("idle_"..name)

        newinst.imagenameoverride = "log_"..name
        newinst.animoverride = "idle_"..name
        newinst.animbankoverride = "logs"
        newinst.animbuildoverride = "logs"

        inst:Remove()

        return newinst
    end
    return fn
end

local function create_log_alt(name)
    local function fn()
        local inst = CreateEntity()
        
        local newinst = SpawnPrefab("log")
        newinst.components.inventoryitem:ChangeImageName("log_"..name)
        newinst.AnimState:SetBank("logs")
        newinst.AnimState:SetBuild("logs")
        newinst.AnimState:PlayAnimation("idle_"..name)

        newinst.imagenameoverride = "log_"..name
        newinst.animoverride = "idle_"..name
        newinst.animbankoverride = "logs"
        newinst.animbuildoverride = "logs"

        inst:Remove()

        return newinst
    end
    return fn
end

return Prefab("log_lunar", create_log_alt("lunar"), assets),
    Prefab("log_twiggy", create_log_alt("twiggy"), assets),
    Prefab("log_spiky", create_log_alt("spiky"), assets),
    Prefab("log_birch", create_log_alt("birch"), assets),
    Prefab("log_livingbirch", create_livinglog_alt("livingbirch"), assets)
