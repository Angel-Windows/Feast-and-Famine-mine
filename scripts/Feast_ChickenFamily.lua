local chickenfamilythings = { 
	"chicken_trader",
	--"fake_trader",
    "chicken",
    "chickenwagon",
    "chickenhouse",
    "retrofitchicken",
}

for k,v in pairs(chickenfamilythings) do
    table.insert(PrefabFiles, v)
end

AddPrefabPostInit("forest", function(inst)
    inst:DoTaskInTime(0, function()
        local chicken = GLOBAL.TheSim:FindFirstEntityWithTag("chickenhouse")
        if chicken == nil then
            local lastroom = -1
            local found = nil
            local foundid = nil
            local reallowest = nil
            local reallowestid = nil
            local count = 0
            local ISLAND = GLOBAL.KnownModIndex:IsModEnabled("workshop-1467214795")
            --if ISLAND then anchorroom = "MeadowBees" else anchorroom = "beefalo" end -- TODO: find a gaurunteed IA room
            local anchorroom = "beefalo"

            for i, node in ipairs(GLOBAL.TheWorld.topology.nodes) do
                if string.lower(GLOBAL.TheWorld.topology.ids[i]):find(anchorroom) then
                    if reallowest == nil then
                        reallowest = node
                        reallowestid = i
                    end
                    count = count + 1
                    if i > lastroom then
                        found = node
                        foundid = i
                        break
                    end
                end
            end

            if found == nil and reallowest ~= nil then
                found = reallowest
                foundid = reallowestid
            end
            
            if found == nil then
                print("This code failed, we all failed. How could we fail?")
                return
            end
            
            GLOBAL.SpawnPrefab("retrofitchicken").Transform:SetPosition(found.cent[1], 0, found.cent[2])
        end
    end)
end)