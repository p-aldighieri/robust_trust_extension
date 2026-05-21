/- strategy_restriction_to_M — proved 2026-05-19 (in-thread, trivial). -/
theorem strategy_restriction_to_M
    (model : RobustTrustModel)
    (σFull : AgentStrategyFull model) :
    ∃ σM : AgentStrategyM model,
      ∀ m : model.M, σM.sectionM m = σFull.sectionFull (model.inclM m) :=
  ⟨restrictFullToM model σFull, fun _ => rfl⟩
