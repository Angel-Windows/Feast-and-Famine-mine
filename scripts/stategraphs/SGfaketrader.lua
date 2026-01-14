require("stategraphs/commonstates")

local actionhandlers = {ActionHandler(ACTIONS.PICKUP, "pickup"), ActionHandler(ACTIONS.TAKEITEM, "pickup"),
                        ActionHandler(ACTIONS.DROP, "dropitem")}

local events = {CommonHandlers.OnStep(), CommonHandlers.OnLocomote(true, true)}

local states = {State {
    name = "funnyidle",
    tags = {"idle"},

    onenter = function(inst)
        inst.Physics:Stop()
        inst.SoundEmitter:PlaySound("dontstarve/creatures/merm/attack")

        inst.AnimState:PlayAnimation("idle_creepy")
    end,

    events = {EventHandler("animover", function(inst)
        inst.sg:GoToState("idle")
    end)}
}, State {
    name = "dropitem",
    tags = {"busy"},

    onenter = function(inst)
        inst.Physics:Stop()
        inst.AnimState:PlayAnimation("pig_pickup")
    end,

    timeline = {TimeEvent(10 * FRAMES, function(inst)
        inst:PerformBufferedAction()
    end)},

    events = {EventHandler("animover", function(inst)
        inst.sg:GoToState("idle")
    end)}
}}

CommonStates.AddWalkStates(states, {
    walktimeline = {TimeEvent(0, PlayFootstep), TimeEvent(12 * FRAMES, PlayFootstep)}
})

CommonStates.AddRunStates(states, {
    runtimeline = {TimeEvent(0, PlayFootstep), TimeEvent(10 * FRAMES, PlayFootstep)}
})

CommonStates.AddIdle(states, "funnyidle")
CommonStates.AddSimpleState(states, "refuse", "pig_reject", {"busy"})
CommonStates.AddSimpleActionState(states, "pickup", "pig_pickup", 10 * FRAMES, {"busy"})

return StateGraph("faketrader", states, events, "idle", actionhandlers)
