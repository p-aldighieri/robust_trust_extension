
========
ROLE: user (id=d76701f4-a9b1-49d5-8e88-fe8789f25af6)
========
You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)


lean
theorem positive_dust_mass_impossible_when_alpha_one
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hα : flow.α = 1) :
    ¬ WTAPositiveQMass wta flow.α dust.N flow.κ := by
  sorry


## Relevant definitions


lean
structure NullDustData (wta : WTATernaryAlgebra) where
  N : Set WTABelief
  measurable_N : MeasurableSet N
  tau_null : wta.τ N = 0     -- ← KEY: τ-null
  ...

structure AdversarialFlowDisintegrationData (wta : WTATernaryAlgebra) (dust : NullDustData wta) where
  α : ℝ
  α_nonneg : 0 ≤ α
  α_le_one : α ≤ 1
  κ : Kernel WTABelief WTABelief
  ...

noncomputable def WTAMixtureMessageLaw (wta : WTATernaryAlgebra)
    (α : ℝ) (κ : Kernel WTABelief WTABelief) : Measure WTABelief :=
  (ENNReal.ofReal α) • wta.τ +
    (ENNReal.ofReal (1 - α)) • ((wta.τ.compProd κ).map Prod.snd)

def WTAPositiveQMass (wta : WTATernaryAlgebra)
    (α : ℝ) (N : Set WTABelief) (κ : Kernel WTABelief WTABelief) : Prop :=
  0 < WTAMixtureMessageLaw wta α κ N


## Math

When α = 1, WTAMixtureMessageLaw wta 1 κ = 1 • τ + 0 • _ = τ. Then WTAMixtureMessageLaw wta 1 κ N = τ N = 0 (from dust.tau_null). So ¬ (0 < 0).

## Proof sketch


lean
intro h
unfold WTAPositiveQMass WTAMixtureMessageLaw at h
rw [hα] at h
simp [dust.tau_null] at h
-- h : 0 < (ENNReal.ofReal 1) • τ N + (ENNReal.ofReal 0) • ((τ ⊗ₘ κ).map _) N
-- = 1 * 0 + 0 * _ = 0
-- contradiction with 0 < 0


Or more directly:


lean
intro h
have : WTAMixtureMessageLaw wta flow.α flow.κ dust.N = 0 := by
  unfold WTAMixtureMessageLaw
  rw [hα]
  -- ENNReal.ofReal 1 = 1, ENNReal.ofReal 0 = 0
  simp [ENNReal.ofReal_one, ENNReal.ofReal_zero, Measure.add_apply, Measure.smul_apply, dust.tau_null]
exact absurd (this ▸ h) (lt_irrefl _)


## Output


lean_proof
target_lemma_slug: positive_dust_mass_impossible_when_alpha_one
status: PROVED | STUCK
tactics_used: [...]



lean
theorem positive_dust_mass_impossible_when_alpha_one ... := by
  ...


Aim for ~10 lines.

Show more

========
ROLE: assistant (id=3437b10a-2ed4-43dd-bd52-6a25cbf4c314)
========
lean_proof
target_lemma_slug: positive_dust_mass_impossible_when_alpha_one
status: PROVED
tactics_used: [intro, simpa]
lean
theorem positive_dust_mass_impossible_when_alpha_one
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hα : flow.α = 1) :
    ¬ WTAPositiveQMass wta flow.α dust.N flow.κ := by
  intro h
  simpa [WTAPositiveQMass, WTAMixtureMessageLaw, hα, dust.tau_null] using h
