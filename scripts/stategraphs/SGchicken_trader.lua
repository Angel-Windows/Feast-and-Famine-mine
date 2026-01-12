require("stategraphs/commonstates")

local actionhandlers =
{
    ActionHandler(ACTIONS.GOHOME, "gohome"),
    ActionHandler(ACTIONS.PICKUP, "pickup"),
    ActionHandler(ACTIONS.EAT, "eat"),
    ActionHandler(ACTIONS.TAKEITEM, "pickup"),
    ActionHandler(ACTIONS.DROP, "dropitem"),
}

local events =
{
    CommonHandlers.OnStep(),
    CommonHandlers.OnLocomote(true, true),
    CommonHandlers.OnSleep(),
    CommonHandlers.OnFreeze(),
    EventHandler("attacked", function(inst) if not inst.components.health:IsDead() and not inst.sg:HasStateTag("transform") then inst.sg:GoToState("hit") end end),
    EventHandler("death", function(inst) inst.sg:GoToState("death") end),
    EventHandler("doattack", function(inst) if not inst.components.health:IsDead() and not inst.sg:HasStateTag("transform") then inst.sg:GoToState("attack") end end)
}

local states =
{
    State{
        name = "funnyidle",
        tags = { "idle", "busy" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.SoundEmitter:PlaySound("chickenfamily/chickenfamily/roostertalkshort")
            --SpawnPrefab("slide_puff").Transform:SetPosition(inst.Transform:GetWorldPosition())
            inst:PushEvent("chattyidle")
            inst.AnimState:PlayAnimation("appear") 
            inst.AnimState:SetTime(0.25 * inst.AnimState:GetCurrentAnimationLength()) 
            inst.components.talker:Say(STRINGS.CHICK_TALK_PROVERB.REFUSE["REFUSE" .. math.random(1, 46)])
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State{
        name = "death",
        tags = { "busy" },

        onenter = function(inst)
            inst.SoundEmitter:KillSound("roostersleep")
            inst.SoundEmitter:PlaySound("chickenfamily/chickenfamily/roosterdeath")
            inst.AnimState:PlayAnimation("death")
            inst.components.locomotor:StopMoving()
            inst.components.lootdropper:DropLoot(inst:GetPosition())
            RemovePhysicsColliders(inst)            
        end,
    },

    State{
        name = "attack",
        tags = { "attack" },
        
        onenter = function(inst)
            inst.SoundEmitter:PlaySound("chickenfamily/chickenfamily/roosterbattle")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh")
            inst.components.combat:StartAttack()
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("atk")
        end,

        timeline =
        {
            TimeEvent(20 * FRAMES, function(inst)
                inst.components.combat:DoAttack()
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },    

    State{
        name = "hit",
        tags = { "busy" },

        onenter = function(inst)
            inst.SoundEmitter:KillSound("roostersleep")
            inst.SoundEmitter:PlaySound("chickenfamily/chickenfamily/roosterhurt")
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("hit")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State{
        name = "eat",
        tags = { "busy" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("eat")
        end,

        timeline =
        {
            TimeEvent(10 * FRAMES, function(inst)
                inst:PerformBufferedAction()
                inst.sg:RemoveStateTag("busy")
                inst.sg:AddStateTag("idle")
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State{
        name = "refuse",
        tags = { "busy" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("appear") 
            --inst.AnimState:SetPercent("appear",0.25)
            --inst.AnimState:Resume()
            inst.AnimState:SetTime(0.25 * inst.AnimState:GetCurrentAnimationLength()) -- skip the smushed up ball part of the anim
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State{
        name = "dropitem",
        tags = { "busy" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("take", true)
        end,

        timeline =
        {
            TimeEvent(10 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                --if inst.AnimState:AnimDone() then
                    --inst.AnimState:SetBank("perd")                
                --end
                inst.sg:GoToState("idle")
            end),
        },
    },
}

CommonStates.AddWalkStates(states,
{
    walktimeline =
    {
        TimeEvent(0, PlayFootstep),
        TimeEvent(12 * FRAMES, PlayFootstep),
    },
})

CommonStates.AddRunStates(states,
{
    runtimeline =
    {
        TimeEvent(0, PlayFootstep),
        TimeEvent(10 * FRAMES, PlayFootstep),
    },
})

CommonStates.AddSleepStates(states,
{
    --starttimeline =
    --{
        --TimeEvent(0, function(inst) inst.SoundEmitter:PlaySound("chickenfamily/chickenfamily/roostersleep") end),
    --},

    sleeptimeline =
    {
        TimeEvent(40 * FRAMES, function(inst) inst.SoundEmitter:KillSound("roostersleep") inst.SoundEmitter:PlaySound("chickenfamily/chickenfamily/roostersleep", "roostersleep") end),
    },
})

CommonStates.AddIdle(states,"funnyidle")
CommonStates.AddSimpleActionState(states, "gohome", "hit", 4 * FRAMES, { "busy" })
CommonStates.AddSimpleActionState(states, "pickup", "take", 10 * FRAMES, { "busy" })
CommonStates.AddFrozenStates(states)

return StateGraph("chicken_trader", states, events, "idle", actionhandlers)
