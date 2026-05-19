/- restricted_agent_strategy_extends_to_full — proved 2026-05-19 (in-thread, bridge unpack). -/
theorem restricted_agent_strategy_extends_to_full
    (model : RobustTrustModel)
    (msupp : MessageSupportM model)
    (bridge : MessageRestrictionBridge model msupp)
    (σM : AgentStrategyM model) :
    ∃ σFull : AgentStrategyFull model,
      ∀ m : model.M, σFull.sectionFull (model.inclM m) = σM.sectionM m :=
  ⟨bridge.extendRestricted σM, bridge.extendRestricted_eq σM⟩
