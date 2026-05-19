/- outside_M_messages_irrelevant — proved 2026-05-19 (in-thread, restrictFullToM equality).

Strategy: agreement on inclM(M) implies `restrictFullToM σ₁ = restrictFullToM σ₂`
(funext + structure congruence), and the four full-payoff functions all factor
through restrictFullToM, so each equality follows by `rw`.
-/
theorem outside_M_messages_irrelevant
    (model : RobustTrustModel)
    (σ₁ σ₂ : AgentStrategyFull model)
    (hagree : ∀ m : model.M,
      σ₁.sectionFull (model.inclM m) = σ₂.sectionFull (model.inclM m))
    (β : AdviserKernel model) :
    AlignedPayoffFull model σ₁ = AlignedPayoffFull model σ₂ ∧
      MisalignedPayoffFull model β σ₁ = MisalignedPayoffFull model β σ₂ ∧
      MixturePayoffFull model β σ₁ = MixturePayoffFull model β σ₂ ∧
      RobustPayoffFull model σ₁ = RobustPayoffFull model σ₂ := by
  have hrestrict :
      restrictFullToM model σ₁ = restrictFullToM model σ₂ := by
    unfold restrictFullToM
    congr 1
    funext m
    exact hagree m
  refine ⟨?_, ?_, ?_, ?_⟩
  · unfold AlignedPayoffFull; rw [hrestrict]
  · unfold MisalignedPayoffFull; rw [hrestrict]
  · unfold MixturePayoffFull AlignedPayoffFull MisalignedPayoffFull; rw [hrestrict]
  · unfold RobustPayoffFull
    congr 1
    ext _
    unfold MixturePayoffFull AlignedPayoffFull MisalignedPayoffFull
    rw [hrestrict]
