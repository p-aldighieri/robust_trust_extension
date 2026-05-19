
========
ROLE: user (id=73f9fe92-edbe-461d-9798-1da3d2e131d1)
========
You are the Lean Meaning Checker in the Lean post-processing module.

## Your Job

For each lemma (and the main theorem), compare the English statement word-by-word against the Lean type signature, looking specifically for the failure modes where Lean typechecks something semantically wrong.

This is an *auditor* role, not a reviewer-with-verdict role. You produce a per-item meaning audit; the orchestrator decides what to do with it. There is no per-item PASS/REDO verdict — instead, each item gets a categorical assessment (MATCHES, WEAKENED, STRENGTHENED, VACUOUS_RISK, WRONG).

- Compare every item, not just the main theorem. Vacuous lemmas at the bottom propagate vacuously upward; checking only the top hides the rot.
- For each item, exhibit the specific witness for your assessment: a value of the variables that satisfies the English but not the Lean, or vice versa.
- Be specific about *which kind* of mismatch you found.
- If the Lean statement is genuinely stronger than the English, flag STRENGTHENED and explain whether the proof would still discharge it.

## Context (orchestrator briefing)

The Lean skeleton (main.lean) has been AXLE-compile-clean and has just passed two formalizer-reviewer rounds. The architecture is now considered stable: payoff layer split, Tier 1a/1b/2 split, atomlessness scoped to WTA sharpness only, kappa-Tier-2 identity, exact-contact tied to sigma*, posterior disintegration identities, dust subtype typing, INVENTORY stubs preserved, no axiom-smuggling.

The structurer audit has been completed (3 retries to PASS). The formalizer-reviewer audit has been completed (2 retries; the second returned PATCH_SMALL with 2 targeted issues that were patched in-thread and submitted for a 3rd pass currently in flight).

Your meaning_check is the LAST audit before AXLE verify_proof and the prover loop. Your job is to catch the residual class of errors where the Lean typechecks but the meaning is subtly off.

## Specific items to spot-check

1. **WTA cone intersection** (wta_cone_intersection): Lemma 7. Known vacuous-lemma risk per Pedro's discipline. The current statement should require: support λ = I, ∀ i ∈ I, 0 < lam i, ∑ λ = 1. Verify the support equality is iff (not just ⊆), and that strict positivity is genuinely enforced on I.

2. **wta_rowwise_minimizer_and_Bayes_cone_identification**: Reviewer's pass-1 specifically flagged this as tautological (defined as cone membership). Pass-3 should now reference WTA_mixedLabel lam and a real payoff comparison. Verify it's NOT a definitional echo.

3. **Tier 2 hypothesis bundle**: tier2_qae_robust_rationalizability_under_menu_Hall takes BOTH ExactContact AND MenuHall as hypotheses. Atomlessness must be ABSENT.

4. **Reverse strategy lift**: Tier 1a concludes ∃ σ* : AgentStrategyFull (full Σ on Δ Ω × Θ), not a restricted M-strategy. The restricted_agent_strategy_extends_to_full lemma should be invoked or implicitly threaded through MessageRestrictionBridge.

5. **Definition2QAEPredicate**: must use qβ-a.e., NOT τ-a.e. or all-m. The v8 reading is q-a.e. on the mixture message marginal.

6. **PosteriorDisintegration** (just patched): now has Pγα κ m indexed by κ, and two new disintegration identities. Verify the disintegration identities actually disintegrate the right joint laws (not arbitrary kernels).

7. **9 inlined INVENTORY stubs**: the externals are project glue. They should be black-box stubs that downstream lemmas invoke. Verify their signatures match the project intent.

## Assessment Categories

- MATCHES: Lean and English say the same thing modulo notation.
- WEAKENED: Lean is provable from English but English is not provable from Lean.
- STRENGTHENED: Lean is harder than what the English proves.
- VACUOUS_RISK: The Lean hypothesis is satisfiable only by trivial cases.
- WRONG: Lean and English are genuinely different statements.

## Output Format


`markdown
meaning_check
total_items: <int>
matches: <int>
weakened: <int>
strengthened: <int>
vacuous_risk: <int>
wrong: <int>

## Per-Item Audit

### <slug>

- English statement (verbatim from structurer): ...
- Lean signature: ...
- Assessment: MATCHES | WEAKENED | STRENGTHENED | VACUOUS_RISK | WRONG
- Witness for the assessment: ...
- Mismatch category (if not MATCHES): ...
- Suggested fix (if not MATCHES): ...

(...repeat per lemma + main theorem + inventory stubs...)

## Cross-Item Concerns

- (Vacuous/weakened lemmas that propagate upward)
- (Suspicious INVENTORY.lean stubs)

## Decisions for the Orchestrator

- Items needing return-to-formalizer: ...
- Items needing return-to-structurer: ...
- Items safe to proceed to prover: ...


## Translation Discipline

Translation, not mathematics. Don't add hypotheses the source didn't state.


## Context Packet


## main.lean v4 (AXLE-clean)


lean
import Mathlib

/-!
Single-file Lean skeleton for the Robust Trust v8 package.
All non-Mathlib inventory stubs are inlined under top-level namespace `Inventory`.
-/

namespace Inventory

open MeasureTheory ProbabilityTheory
open scoped BigOperators ENNReal

/-! ## 1. measurable-maximum-and-argmax-selection -/

theorem measurable_argmax_selector
    {X Y : Type*}
    [MeasurableSpace X] [TopologicalSpace Y] [MeasurableSpace Y]
    [CompactSpace Y] [Nonempty Y]
    {Γ : X → Set Y} {f : X → Y → ℝ}
    (hΓ_meas : MeasurableSet {p : X × Y | p.2 ∈ Γ p.1})
    (hΓ_ne : ∀ x, (Γ x).Nonempty)
    (hΓ_compact : ∀ x, IsCompact (Γ x))
    (hf_meas : Measurable fun p : X × Y => f p.1 p.2)
    (hf_cont : ∀ x, ContinuousOn (fun y => f x y) (Γ x)) :
    ∃ sel : X → Y,
      Measurable sel ∧
      ∀ x, sel x ∈ Γ x ∧
        IsMaxOn (fun y => f x y) (Γ x) (sel x) := by
  sorry

/-! ## 2. profile-geometry-import -/

theorem profile_geometry_import
    {Ω PrivateStrategy : Type*}
    [Fintype Ω]
    [TopologicalSpace PrivateStrategy] [CompactSpace PrivateStrategy] [Nonempty PrivateStrategy]
    [MeasurableSpace PrivateStrategy] [BorelSpace PrivateStrategy]
    (Φ : PrivateStrategy → (Ω → ℝ))
    (hΦ_cont : Continuous Φ)
    (hconvex_realization :
      ∀ σ1 σ2 : PrivateStrategy, ∀ t : ℝ, 0 ≤ t → t ≤ 1 →
        ∃ σt : PrivateStrategy,
          Φ σt = (fun ω => t * Φ σ1 ω + (1 - t) * Φ σ2 ω)) :
    let W : Set (Ω → ℝ) := Set.range Φ
    IsCompact W ∧
    Convex ℝ W ∧
    (∀ w ∈ W, (Φ ⁻¹' {w}).Nonempty ∧ IsCompact (Φ ⁻¹' {w})) := by
  sorry

/-! ## 3. krn-borel-right-inverse -/

theorem krn_borel_right_inverse
    {X Y : Type*}
    [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X] [StandardBorelSpace X]
    [TopologicalSpace Y] [MeasurableSpace Y] [BorelSpace Y] [StandardBorelSpace Y]
    [CompactSpace X]
    (Φ : X → Y)
    (hΦ_cont : Continuous Φ)
    (hΦ_surj : Function.Surjective Φ)
    (hfib_compact : ∀ y, IsCompact (Φ ⁻¹' {y}))
    (hfib_ne : ∀ y, (Φ ⁻¹' {y}).Nonempty) :
    ∃ R : Y → X, Measurable R ∧ ∀ y, Φ (R y) = y := by
  sorry

/-! ## 4. kernel-infimum-epsilon-selection -/

theorem kernel_infimum_epsilon_selection
    {S M : Type*}
    [MeasurableSpace S] [TopologicalSpace S] [StandardBorelSpace S]
    [MeasurableSpace M] [TopologicalSpace M] [StandardBorelSpace M] [Nonempty M]
    (τ : Measure S)
    [IsFiniteMeasure τ]
    (g : S → M → ℝ)
    (hg_meas : Measurable fun p : S × M => g p.1 p.2)
    (hg_bdd : ∃ C, ∀ s m, |g s m| ≤ C)
    (hinf_meas : Measurable fun s => sInf (Set.range (g s))) :
    (∀ ε > 0, ∃ β : Kernel S M,
        IsMarkovKernel β ∧
        ∫ s, ∫ m, g s m ∂(β s) ∂τ
          ≤ (∫ s, sInf (Set.range (g s)) ∂τ) + ε) ∧
    (∀ β : Kernel S M, IsMarkovKernel β →
        (∫ s, sInf (Set.range (g s)) ∂τ)
          ≤ ∫ s, ∫ m, g s m ∂(β s) ∂τ) := by
  sorry

/-! ## 5. hausdorff-support-function-lipschitz -/

theorem hausdorff_support_function_lipschitz
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (ℓ : E →L[ℝ] ℝ) :
    ∃ L : ℝ, 0 ≤ L ∧
      ∀ C D : TopologicalSpace.NonemptyCompacts E,
        |(sSup (ℓ '' (↑C : Set E))) - (sSup (ℓ '' (↑D : Set E)))|
          ≤ L * dist C D := by
  sorry

/-! ## 6. jankov-von-neumann-universal-selection -/

/-- Universal measurability: `f` is measurable with respect to every Borel completion. -/
def UniversallyMeasurable {X Y : Type*} [TopologicalSpace X] [MeasurableSpace X]
    [MeasurableSpace Y] (f : X → Y) : Prop :=
  ∀ μ : Measure X, IsFiniteMeasure μ → AEMeasurable f μ

theorem jankov_von_neumann_universal_selection
    {X Y : Type*}
    [MeasurableSpace X] [TopologicalSpace X] [BorelSpace X] [StandardBorelSpace X]
    [MeasurableSpace Y] [TopologicalSpace Y] [BorelSpace Y] [StandardBorelSpace Y] [Nonempty Y]
    (G : Set (X × Y))
    (hG_analytic : MeasureTheory.AnalyticSet G)
    (hsections : ∀ x, ∃ y, (x, y) ∈ G) :
    ∃ f : X → Y,
      UniversallyMeasurable f ∧ ∀ x, (x, f x) ∈ G := by
  sorry

/-! ## 7. geps-borel-selector-upgrade -/

structure GepsRegularity {M : Type*} [TopologicalSpace M] [MeasurableSpace M]
    (Gε : ℝ → M → Set M) (ε : ℝ) : Prop where
  closed_valued : ∀ s : M, IsClosed (Gε ε s)
  graph_measurable : MeasurableSet {p : M × M | p.2 ∈ Gε ε p.1}
  sections_measurable : ∀ s : M, MeasurableSet (Gε ε s)

theorem geps_borel_selector_upgrade
    {M : Type*}
    [MetricSpace M]
    [MeasurableSpace M] [BorelSpace M] [StandardBorelSpace M]
    [SecondCountableTopology M]
    [CompactSpace M]
    {Gε : ℝ → M → Set M}
    {ε : ℝ}
    (hε : 0 < ε)
    (hne : ∀ s : M, (Gε ε s).Nonempty)
    (hregular : GepsRegularity Gε ε) :
    ∃ mε : M → M,
      Measurable mε ∧ ∀ s : M, mε s ∈ Gε ε s := by
  sorry

/-! ## 8. bayes-posterior-as-conditional-barycenter -/

theorem bayes_posterior_as_conditional_barycenter
    {Ω : Type*} [Fintype Ω]
    {Belief : Type*} [TopologicalSpace Belief] [MeasurableSpace Belief]
    [BorelSpace Belief] [StandardBorelSpace Belief]
    {M : Type*} [TopologicalSpace M] [MeasurableSpace M] [BorelSpace M] [StandardBorelSpace M]
    (coord : Belief → Ω → ℝ)
    (hcoord_meas : ∀ ω, Measurable (fun s => coord s ω))
    (hcoord_nonneg : ∀ s ω, 0 ≤ coord s ω)
    (hcoord_sum : ∀ s, ∑ ω, coord s ω = 1)
    (μ0 : Ω → ℝ) (hμ0_nonneg : ∀ ω, 0 ≤ μ0 ω) (hμ0_sum : ∑ ω, μ0 ω = 1)
    (π : Ω → Measure Belief)
    [hπ_prob : ∀ ω, IsProbabilityMeasure (π ω)]
    (τ : Measure Belief)
    [IsProbabilityMeasure τ]
    (hposterior_consistency :
      ∀ ω, (ENNReal.ofReal (μ0 ω)) • (π ω) =
        τ.withDensity (fun s => ENNReal.ofReal (coord s ω)))
    (q : Measure M)
    [IsProbabilityMeasure q]
    (χ : Kernel Belief M)
    [IsMarkovKernel χ]
    (hq_marginal : q = (τ.compProd χ).map Prod.snd)
    (ρ : Kernel M Belief)
    [IsMarkovKernel ρ]
    (hρ_disintegration :
      q.compProd ρ =
        (τ.compProd χ).map (fun p : Belief × M => (p.2, p.1)))
    (P : M → Ω → ℝ)
    (hP_meas : ∀ ω, Measurable (fun m => P m ω))
    (hP_bayes_definition :
      ∀ ω : Ω, ∀ᵐ m ∂q,
        P m ω = (μ0 ω) *
          ((((π ω).compProd χ).map Prod.snd).rnDeriv q m).toReal) :
    ∀ᵐ m ∂q, ∀ ω : Ω, P m ω = ∫ s, coord s ω ∂(ρ m) := by
  sorry

/-! ## 9. support-function-measurable-integrated-separation -/

/-- A.e. pointwise version. -/
theorem support_function_ae_pointwise_separation
    {Ω : Type*} [Fintype Ω]
    {M : Type*} [MeasurableSpace M]
    (q : Measure M)
    [IsFiniteMeasure q]
    (B : M → Set (Ω → ℝ))
    (P : M → (Ω → ℝ))
    (hP_meas : Measurable P)
    (hB_closed : ∀ m, IsClosed (B m))
    (hB_convex : ∀ m, Convex ℝ (B m))
    (hB_nonempty : ∀ m, (B m).Nonempty)
    (hB_bounded : ∀ m, Bornology.IsBounded (B m))
    (hB_meas_graph : MeasurableSet {p : M × (Ω → ℝ) | p.2 ∈ B p.1}) :
    (∀ᵐ m ∂q, P m ∈ B m) ↔
      (∀ᵐ m ∂q, ∀ ℓ : (Ω → ℝ) →L[ℝ] ℝ, ℓ (P m) ≤ sSup (ℓ '' B m)) := by
  sorry

/-- Eventwise integrated Hall form. -/
theorem support_function_integrated_separation
    {Ω : Type*} [Fintype Ω]
    {M : Type*} [MeasurableSpace M]
    (q : Measure M)
    [IsFiniteMeasure q]
    (B : M → Set (Ω → ℝ))
    (P : M → (Ω → ℝ))
    (hP_meas : Measurable P)
    (hB_closed : ∀ m, IsClosed (B m))
    (hB_convex : ∀ m, Convex ℝ (B m))
    (hB_nonempty : ∀ m, (B m).Nonempty)
    (hB_bounded : ∀ m, Bornology.IsBounded (B m))
    (hB_meas_graph : MeasurableSet {p : M × (Ω → ℝ) | p.2 ∈ B p.1})
    (hsupp_meas : ∀ ℓ : (Ω → ℝ) →L[ℝ] ℝ, Measurable fun m => sSup (ℓ '' B m))
    (hsupp_int : ∀ ℓ : (Ω → ℝ) →L[ℝ] ℝ, Integrable (fun m => sSup (ℓ '' B m)) q)
    (hP_int : ∀ ℓ : (Ω → ℝ) →L[ℝ] ℝ, Integrable (fun m => ℓ (P m)) q) :
    ∀ E : Set M, MeasurableSet E → q E ≠ 0 →
      ((∀ᵐ m ∂q.restrict E, P m ∈ B m) ↔
        (∀ ℓ : (Ω → ℝ) →L[ℝ] ℝ,
          ∫ m in E, ℓ (P m) ∂q ≤ ∫ m in E, sSup (ℓ '' B m) ∂q)) := by
  sorry

end Inventory

namespace RobustTrustV8

open MeasureTheory ProbabilityTheory
open scoped BigOperators ENNReal

noncomputable section

/-! ## Finite state simplex and generic model primitives -/

abbrev Belief (Ω : Type) [Fintype Ω] : Type :=
  {s : Ω → ℝ // (∀ ω : Ω, 0 ≤ s ω) ∧ (∑ ω : Ω, s ω) = 1}

def beliefCoord {Ω : Type} [Fintype Ω] (s : Belief Ω) (ω : Ω) : ℝ :=
  s.val ω

def beliefDot {Ω : Type} [Fintype Ω] (s : Belief Ω) (w : Ω → ℝ) : ℝ :=
  ∑ ω : Ω, s.val ω * w ω

def beliefAsProfile {Ω : Type} [Fintype Ω] (s : Belief Ω) : Ω → ℝ :=
  fun ω => s.val ω

noncomputable def beliefBarycenter {Ω : Type} [Fintype Ω]
    [MeasurableSpace (Belief Ω)] (ρ : Measure (Belief Ω)) : Ω → ℝ :=
  fun ω => ∫ s, s.val ω ∂ρ

structure RobustTrustModel where
  Ω : Type
  [Ω_fintype : Fintype Ω]
  [Ω_measurable : MeasurableSpace Ω]
  [Ω_nonempty : Nonempty Ω]

  Θ : Type
  [Θ_metric : MetricSpace Θ]
  [Θ_measurable : MeasurableSpace Θ]
  [Θ_borel : BorelSpace Θ]
  [Θ_standardBorel : StandardBorelSpace Θ]
  [Θ_secondCountable : SecondCountableTopology Θ]
  [Θ_compact : CompactSpace Θ]
  [Θ_nonempty : Nonempty Θ]

  A : Type
  [A_metric : MetricSpace A]
  [A_measurable : MeasurableSpace A]
  [A_borel : BorelSpace A]
  [A_standardBorel : StandardBorelSpace A]
  [A_secondCountable : SecondCountableTopology A]
  [A_compact : CompactSpace A]
  [A_nonempty : Nonempty A]

  M : Type
  [M_metric : MetricSpace M]
  [M_measurable : MeasurableSpace M]
  [M_borel : BorelSpace M]
  [M_standardBorel : StandardBorelSpace M]
  [M_secondCountable : SecondCountableTopology M]
  [M_compact : CompactSpace M]
  [M_nonempty : Nonempty M]

  PrivateStrategy : Type
  [PrivateStrategy_topological : TopologicalSpace PrivateStrategy]
  [PrivateStrategy_measurable : MeasurableSpace PrivateStrategy]
  [PrivateStrategy_borel : BorelSpace PrivateStrategy]
  [PrivateStrategy_standardBorel : StandardBorelSpace PrivateStrategy]
  [PrivateStrategy_compact : CompactSpace PrivateStrategy]
  [PrivateStrategy_nonempty : Nonempty PrivateStrategy]

  μ0 : Ω → ℝ
  μ0_nonneg : ∀ ω : Ω, 0 ≤ μ0 ω
  μ0_sum : ∑ ω : Ω, μ0 ω = 1
  μ0_fullSupport : ∀ ω : Ω, 0 < μ0 ω

  π : Ω → Measure (Belief Ω)
  π_prob : ∀ ω : Ω, IsProbabilityMeasure (π ω)
  τ : Measure (Belief Ω)
  τ_prob : IsProbabilityMeasure τ

  inclM : M → Belief Ω
  inclM_measurable : Measurable inclM
  τM : Measure M
  τM_prob : IsProbabilityMeasure τM

  typeLaw : Ω → Measure Θ
  typeLaw_prob : ∀ ω : Ω, IsProbabilityMeasure (typeLaw ω)

  u : A → Ω → Θ → ℝ
  payoff_bounded : ∃ C : ℝ, ∀ a ω θ, |u a ω θ| ≤ C
  payoff_continuous_in_action : ∀ ω θ, Continuous fun a => u a ω θ
  payoff_measurable : Measurable fun p : A × Ω × Θ => u p.1 p.2.1 p.2.2
  conditional_independence : Prop

  α : ℝ
  α_nonneg : 0 ≤ α
  α_le_one : α ≤ 1

  profileOfPrivate : PrivateStrategy → Ω → ℝ
  private_profile_bounded : ∃ C : ℝ, ∀ σ ω, |profileOfPrivate σ ω| ≤ C

attribute [instance]
  RobustTrustModel.Ω_fintype
  RobustTrustModel.Ω_measurable
  RobustTrustModel.Ω_nonempty
  RobustTrustModel.Θ_metric
  RobustTrustModel.Θ_measurable
  RobustTrustModel.Θ_borel
  RobustTrustModel.Θ_standardBorel
  RobustTrustModel.Θ_secondCountable
  RobustTrustModel.Θ_compact
  RobustTrustModel.Θ_nonempty
  RobustTrustModel.A_metric
  RobustTrustModel.A_measurable
  RobustTrustModel.A_borel
  RobustTrustModel.A_standardBorel
  RobustTrustModel.A_secondCountable
  RobustTrustModel.A_compact
  RobustTrustModel.A_nonempty
  RobustTrustModel.M_metric
  RobustTrustModel.M_measurable
  RobustTrustModel.M_borel
  RobustTrustModel.M_standardBorel
  RobustTrustModel.M_secondCountable
  RobustTrustModel.M_compact
  RobustTrustModel.M_nonempty
  RobustTrustModel.PrivateStrategy_topological
  RobustTrustModel.PrivateStrategy_measurable
  RobustTrustModel.PrivateStrategy_borel
  RobustTrustModel.PrivateStrategy_standardBorel
  RobustTrustModel.PrivateStrategy_compact
  RobustTrustModel.PrivateStrategy_nonempty

abbrev Profile (model : RobustTrustModel) : Type :=
  model.Ω → ℝ

structure PriorAdviserPosteriorLaw (model : RobustTrustModel) where
  unconditional_law_identity :
    model.τ = ∑ ω : model.Ω, (ENNReal.ofReal (model.μ0 ω)) • model.π ω
  support_is_msupp :
    ∀ s : Belief model.Ω,
      s ∈ Set.range model.inclM ↔ s ∈ MeasureTheory.Measure.support model.τ

structure PosteriorLawConsistency (model : RobustTrustModel) where
  coordinate_measure_identity :
    ∀ ω : model.Ω,
      (ENNReal.ofReal (model.μ0 ω)) • model.π ω =
        model.τ.withDensity (fun s => ENNReal.ofReal (beliefCoord s ω))
  barycenter_eq_prior : beliefBarycenter model.τ = model.μ0
  posteriorAfterAdviser : Belief model.Ω → Belief model.Ω
  posterior_after_adviser_ae :
    ∀ᵐ s ∂model.τ, posteriorAfterAdviser s = s

structure MessageSupportM (model : RobustTrustModel) where
  supportSet : Set (Belief model.Ω)
  support_eq_range : supportSet = Set.range model.inclM
  support_closed : IsClosed supportSet
  support_measurable : MeasurableSet supportSet
  τM_pushforward : model.τM.map model.inclM = model.τ

structure TypeActionPayoffPrimitives (model : RobustTrustModel) : Prop where
  bounded : ∃ C : ℝ, ∀ a ω θ, |model.u a ω θ| ≤ C
  continuous_in_action : ∀ ω θ, Continuous fun a => model.u a ω θ
  measurable_payoff : Measurable fun p : model.A × model.Ω × model.Θ =>
    model.u p.1 p.2.1 p.2.2
  conditional_independence : model.conditional_independence

structure PrivateStrategySpace (model : RobustTrustModel) where
  actKernel : model.PrivateStrategy → Kernel model.Θ model.A
  actKernel_markov : ∀ σ, IsMarkovKernel (actKernel σ)
  defaultPrivateStrategy : model.PrivateStrategy
  profile_eq : model.PrivateStrategy → Profile model

structure AgentStrategyFull (model : RobustTrustModel) where
  sectionFull : Belief model.Ω → model.PrivateStrategy
  measurable_sectionFull : Measurable sectionFull

structure AgentStrategyM (model : RobustTrustModel) where
  sectionM : model.M → model.PrivateStrategy
  measurable_sectionM : Measurable sectionM

def restrictFullToM (model : RobustTrustModel)
    (σFull : AgentStrategyFull model) : AgentStrategyM model :=
  { sectionM := fun m => σFull.sectionFull (model.inclM m)
    measurable_sectionM := σFull.measurable_sectionFull.comp model.inclM_measurable }

structure MessageRestrictionBridge (model : RobustTrustModel)
    (support : MessageSupportM model) where
  defaultPrivateStrategy : model.PrivateStrategy
  restrictFull : AgentStrategyFull model → AgentStrategyM model
  restrictFull_eq : ∀ σ m, (restrictFull σ).sectionM m = σ.sectionFull (model.inclM m)
  extendRestricted : AgentStrategyM model → AgentStrategyFull model
  extendRestricted_eq :
    ∀ σM m, (extendRestricted σM).sectionFull (model.inclM m) = σM.sectionM m
  -- 2026-05-19 patch v2: opaque `offSupportIrrelevant : Prop` removed per reviewer.
  -- The actual off-support irrelevance content lives in the
  -- `outside_M_messages_irrelevant` theorem, not in this bundle.

structure AdviserKernel (model : RobustTrustModel) where
  kernel : Kernel model.M model.M
  isMarkov : IsMarkovKernel kernel

structure FullMessageAdviserKernel (model : RobustTrustModel) where
  kernel : Kernel model.M (Belief model.Ω)
  isMarkov : IsMarkovKernel kernel

noncomputable def PrivatePayoff (model : RobustTrustModel)
    (σhat : model.PrivateStrategy) (μ : Belief model.Ω) : ℝ :=
  beliefDot μ (model.profileOfPrivate σhat)

def IsBayesOptimal (model : RobustTrustModel)
    (σhat : model.PrivateStrategy) (μ : Belief model.Ω) : Prop :=
  ∀ σhat' : model.PrivateStrategy,
    PrivatePayoff model σhat' μ ≤ PrivatePayoff model σhat μ

noncomputable def profileMap (model : RobustTrustModel)
    (σM : AgentStrategyM model) (m : model.M) : Profile model :=
  model.profileOfPrivate (σM.sectionM m)

noncomputable def AlignedPayoffM (model : RobustTrustModel)
    (σM : AgentStrategyM model) : ℝ :=
  ∫ s, beliefDot (model.inclM s) (profileMap model σM s) ∂model.τM

noncomputable def MisalignedPayoffM (model : RobustTrustModel)
    (β : AdviserKernel model) (σM : AgentStrategyM model) : ℝ :=
  ∫ s, ∫ m, beliefDot (model.inclM s) (profileMap model σM m) ∂(β.kernel s) ∂model.τM

noncomputable def MixturePayoffM (model : RobustTrustModel)
    (β : AdviserKernel model) (σM : AgentStrategyM model) : ℝ :=
  model.α * AlignedPayoffM model σM +
    (1 - model.α) * MisalignedPayoffM model β σM

noncomputable def RobustPayoffM (model : RobustTrustModel)
    (σM : AgentStrategyM model) : ℝ :=
  sInf (Set.range fun β : AdviserKernel model => MixturePayoffM model β σM)

noncomputable def UStarM (model : RobustTrustModel) : ℝ :=
  sSup (Set.range fun σM : AgentStrategyM model => RobustPayoffM model σM)

noncomputable def AlignedPayoffFull (model : RobustTrustModel)
    (σFull : AgentStrategyFull model) : ℝ :=
  AlignedPayoffM model (restrictFullToM model σFull)

noncomputable def MisalignedPayoffFull (model : RobustTrustModel)
    (β : AdviserKernel model) (σFull : AgentStrategyFull model) : ℝ :=
  MisalignedPayoffM model β (restrictFullToM model σFull)

noncomputable def MixturePayoffFull (model : RobustTrustModel)
    (β : AdviserKernel model) (σFull : AgentStrategyFull model) : ℝ :=
  model.α * AlignedPayoffFull model σFull +
    (1 - model.α) * MisalignedPayoffFull model β σFull

noncomputable def RobustPayoffFull (model : RobustTrustModel)
    (σFull : AgentStrategyFull model) : ℝ :=
  sInf (Set.range fun β : AdviserKernel model => MixturePayoffFull model β σFull)

noncomputable def UStarFull (model : RobustTrustModel) : ℝ :=
  sSup (Set.range fun σFull : AgentStrategyFull model => RobustPayoffFull model σFull)

noncomputable def MisalignedPayoffFullRaw (model : RobustTrustModel)
    (βFull : FullMessageAdviserKernel model) (σFull : AgentStrategyFull model) : ℝ :=
  ∫ s, ∫ m, beliefDot (model.inclM s)
      (model.profileOfPrivate (σFull.sectionFull m)) ∂(βFull.kernel s) ∂model.τM

noncomputable def MixturePayoffFullRaw (model : RobustTrustModel)
    (βFull : FullMessageAdviserKernel model) (σFull : AgentStrategyFull model) : ℝ :=
  model.α * AlignedPayoffFull model σFull +
    (1 - model.α) * MisalignedPayoffFullRaw model βFull σFull

def IsAdversarialFull (model : RobustTrustModel)
    (β : AdviserKernel model) (σFull : AgentStrategyFull model) : Prop :=
  MixturePayoffFull model β σFull = RobustPayoffFull model σFull

def IsAdversarialM (model : RobustTrustModel)
    (β : AdviserKernel model) (σM : AgentStrategyM model) : Prop :=
  MixturePayoffM model β σM = RobustPayoffM model σM

noncomputable def MixtureMessageLaw (model : RobustTrustModel)
    (β : AdviserKernel model) : Measure model.M :=
  (ENNReal.ofReal model.α) • model.τM +
    (ENNReal.ofReal (1 - model.α)) • ((model.τM.compProd β.kernel).map Prod.snd)

def PositiveQMass (model : RobustTrustModel)
    (N : Set model.M) (β : AdviserKernel model) : Prop :=
  0 < MixtureMessageLaw model β N

noncomputable def MixtureCouplingGammaAlpha (model : RobustTrustModel)
    (κ : AdviserKernel model) : Measure (model.M × model.M) :=
  (ENNReal.ofReal model.α) • (model.τM.map (fun s : model.M => (s, s))) +
    (ENNReal.ofReal (1 - model.α)) • (model.τM.compProd κ.kernel)

structure PosteriorDisintegration (model : RobustTrustModel) where
  Pβ : AdviserKernel model → model.M → Belief model.Ω
  -- 2026-05-19 patch v2: Pγα is now indexed by κ per reviewer (the posterior
  -- under the γ_α mixture depends on κ; without indexing the structure was
  -- either over-strong or empty).
  Pγα : AdviserKernel model → model.M → Belief model.Ω
  sourceLawβ : AdviserKernel model → Kernel model.M (Belief model.Ω)
  sourceLawγα : AdviserKernel model → Kernel model.M (Belief model.Ω)
  Pβ_measurable : ∀ β, Measurable (Pβ β)
  Pγα_measurable : ∀ κ, Measurable (Pγα κ)
  sourceLawβ_markov : ∀ β, IsMarkovKernel (sourceLawβ β)
  sourceLawγα_markov : ∀ κ, IsMarkovKernel (sourceLawγα κ)
  conditional_barycenter :
    ∀ β : AdviserKernel model, ∀ᵐ m ∂(MixtureMessageLaw model β),
      beliefBarycenter ((sourceLawβ β) m) = beliefAsProfile (Pβ β m)
  gamma_alpha_conditional_barycenter :
    ∀ κ : AdviserKernel model,
      ∀ᵐ m ∂((MixtureCouplingGammaAlpha model κ).map Prod.snd),
        beliefBarycenter ((sourceLawγα κ) m) = beliefAsProfile (Pγα κ m)
  -- 2026-05-19 patch v2: real disintegration identities tying sourceLawβ
  -- and sourceLawγα to the actual mixture couplings (closes the "smuggled
  -- arbitrary kernel" hole — reviewer's main pass-2 concern).
  sourceLawβ_disintegrates :
    ∀ β : AdviserKernel model,
      (MixtureCouplingGammaAlpha model β).map
        (fun p : model.M × model.M => (p.2, model.inclM p.1)) =
      (MixtureMessageLaw model β).compProd (sourceLawβ β)
  sourceLawγα_disintegrates :
    ∀ κ : AdviserKernel model,
      (MixtureCouplingGammaAlpha model κ).map
        (fun p : model.M × model.M => (p.2, model.inclM p.1)) =
      ((MixtureCouplingGammaAlpha model κ).map Prod.snd).compProd
        (sourceLawγα κ)

def Definition2QAEPredicate (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (β : AdviserKernel model) (σFull : AgentStrategyFull model) : Prop :=
  IsAdversarialFull model β σFull ∧
    ∀ᵐ m ∂MixtureMessageLaw model β,
      IsBayesOptimal model (σFull.sectionFull (model.inclM m)) (pd.Pβ β m)

/-! ## Payoff-profile menu engine objects -/

def PayoffProfileSet (model : RobustTrustModel) : Set (Profile model) :=
  Set.range model.profileOfPrivate

abbrev ProfileInW (model : RobustTrustModel) : Type :=
  {w : Profile model // w ∈ PayoffProfileSet model}

structure ProfileRealizationSetup (model : RobustTrustModel) where
  Φ : model.PrivateStrategy → Profile model
  Φ_eq_profile : Φ = model.profileOfPrivate
  Φ_continuous : Continuous Φ
  W_compact : IsCompact (PayoffProfileSet model)
  W_convex : Convex ℝ (PayoffProfileSet model)
  Φ_surjective_onto_W :
    ∀ w : Profile model, w ∈ PayoffProfileSet model → ∃ σ, Φ σ = w
  fibers_compact : ∀ w : Profile model, IsCompact (Φ ⁻¹' {w})
  fibers_nonempty : ∀ w : Profile model, w ∈ PayoffProfileSet model →
    (Φ ⁻¹' {w}).Nonempty

structure ProfileRealizationMap (model : RobustTrustModel) where
  R : ProfileInW model → model.PrivateStrategy
  measurable_R : Measurable R
  right_inverse : ∀ w : ProfileInW model, model.profileOfPrivate (R w) = w.val

abbrev CompactMenu (model : RobustTrustModel) : Type :=
  TopologicalSpace.NonemptyCompacts (ProfileInW model)

noncomputable def maxPayoff (model : RobustTrustModel)
    (C : CompactMenu model) (s : model.M) : ℝ :=
  sSup ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
    (↑C : Set (ProfileInW model)))

noncomputable def minPayoff (model : RobustTrustModel)
    (C : CompactMenu model) (s : model.M) : ℝ :=
  sInf ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
    (↑C : Set (ProfileInW model)))

noncomputable def MenuFunctionalF (model : RobustTrustModel)
    (C : CompactMenu model) : ℝ :=
  ∫ s, model.α * maxPayoff model C s +
    (1 - model.α) * minPayoff model C s ∂model.τM

structure OptimalMenuCstar (model : RobustTrustModel) where
  Cstar : CompactMenu model
  optimal : ∀ C : CompactMenu model, MenuFunctionalF model C ≤ MenuFunctionalF model Cstar
  value_eq : MenuFunctionalF model Cstar = UStarM model

structure AlignedBestLabelingWstar (model : RobustTrustModel)
    (opt : OptimalMenuCstar model) where
  wstar : model.M → ProfileInW model
  measurable_wstar : Measurable wstar
  mem_Cstar : ∀ m : model.M, wstar m ∈ (↑opt.Cstar : Set (ProfileInW model))
  is_argmax :
    ∀ m : model.M,
      IsMaxOn (fun w : ProfileInW model => beliefDot (model.inclM m) w.val)
        (↑opt.Cstar : Set (ProfileInW model)) (wstar m)

structure PrunedMenuCdagger (model : RobustTrustModel)
    {opt : OptimalMenuCstar model}
    (wlabel : AlignedBestLabelingWstar model opt) where
  Cdagger : CompactMenu model
  subset_Cstar :
    (↑Cdagger : Set (ProfileInW model)) ⊆ (↑opt.Cstar : Set (ProfileInW model))
  closure_range_subset :
    closure (Set.range wlabel.wstar) ⊆ (↑Cdagger : Set (ProfileInW model))
  range_dense :
    (↑Cdagger : Set (ProfileInW model)) ⊆ closure (Set.range wlabel.wstar)
  value_preserved : MenuFunctionalF model Cdagger = MenuFunctionalF model opt.Cstar

def RowwiseContactG (model : RobustTrustModel)
    {opt : OptimalMenuCstar model}
    {wlabel : AlignedBestLabelingWstar model opt}
    (cdagger : PrunedMenuCdagger model wlabel)
    (s : model.M) : Set model.M :=
  {m : model.M |
    beliefDot (model.inclM s) (wlabel.wstar m).val =
      minPayoff model cdagger.Cdagger s}

def EpsilonContactGeps (model : RobustTrustModel)
    {opt : OptimalMenuCstar model}
    {wlabel : AlignedBestLabelingWstar model opt}
    (cdagger : PrunedMenuCdagger model wlabel)
    (ε : ℝ) (s : model.M) : Set model.M :=
  {m : model.M |
    beliefDot (model.inclM s) (wlabel.wstar m).val ≤
      minPayoff model cdagger.Cdagger s + ε}

structure ExactContact (model : RobustTrustModel)
    (σstar : AgentStrategyFull model) where
  opt : OptimalMenuCstar model
  wlabel : AlignedBestLabelingWstar model opt
  cdagger : PrunedMenuCdagger model wlabel
  selector : model.M → model.M
  selector_measurable : Measurable selector
  selector_mem :
    ∀ᵐ s ∂model.τM, selector s ∈ RowwiseContactG model cdagger s
  sigma_implements_wlabel :
    ∀ m : model.M,
      profileMap model (restrictFullToM model σstar) m = (wlabel.wstar m).val

def KernelSupportedOnG (model : RobustTrustModel)
    {opt : OptimalMenuCstar model}
    {wlabel : AlignedBestLabelingWstar model opt}
    (cdagger : PrunedMenuCdagger model wlabel)
    (κ : AdviserKernel model) : Prop :=
  ∀ᵐ s ∂model.τM, κ.kernel s (RowwiseContactG model cdagger s) = 1

structure ExactAdversaryKernel (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model σstar)
    (β : AdviserKernel model) : Prop where
  deterministic :
    ∀ s : model.M, β.kernel s = Measure.dirac (ec.selector s)
  supported_on_G : KernelSupportedOnG model ec.cdagger β

structure MenuHallAdversaryKernel (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model σstar) where
  κ : AdviserKernel model
  supported : KernelSupportedOnG model ec.cdagger κ

def BayesOptimalityBeliefCorrespondenceBm (model : RobustTrustModel)
    (σFull : AgentStrategyFull model) (m : model.M) : Set (Belief model.Ω) :=
  {μ : Belief model.Ω |
    IsBayesOptimal model (σFull.sectionFull (model.inclM m)) μ}

structure MenuHall (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (σFull : AgentStrategyFull model)
    (ec : ExactContact model σFull)
    (κ : AdviserKernel model) where
  supported : KernelSupportedOnG model ec.cdagger κ
  q : Measure model.M
  q_eq_qκ : q = MixtureMessageLaw model κ
  q_eq_gamma_second : q = (MixtureCouplingGammaAlpha model κ).map Prod.snd
  calibration :
    ∀ᵐ m ∂q, pd.Pγα κ m ∈ BayesOptimalityBeliefCorrespondenceBm model σFull m

def PosteriorCalibrationProfiles (model : RobustTrustModel)
    (q : Measure model.M)
    (B : model.M → Set (Profile model))
    (P : model.M → Profile model) : Prop :=
  ∀ᵐ m ∂q, P m ∈ B m

def SupportFunctionHallInequalities (model : RobustTrustModel)
    (q : Measure model.M)
    (B : model.M → Set (Profile model))
    (P : model.M → Profile model) : Prop :=
  ∀ E : Set model.M, MeasurableSet E → q E ≠ 0 →
    ∀ ℓ : Profile model →L[ℝ] ℝ,
      ∫ m in E, ℓ (P m) ∂q ≤ ∫ m in E, sSup (ℓ '' B m) ∂q

structure SupportFunctionHallForm (model : RobustTrustModel) where
  q : Measure model.M
  B : model.M → Set (Profile model)
  P : model.M → Profile model
  hall : SupportFunctionHallInequalities model q B P

/-! ## WTA sharpness objects -/

abbrev WTAΩ : Type := Fin 3
abbrev WTAProfile : Type := WTAΩ → ℝ
abbrev WTABelief : Type := Belief WTAΩ

structure WTATernaryAlgebra where
  μ0 : WTABelief
  μ0_coord : ∀ i : WTAΩ, μ0.val i = (1 : ℝ) / 3
  τ : Measure WTABelief
  τ_prob : IsProbabilityMeasure τ

structure AtomlessTauSharpness (wta : WTATernaryAlgebra) where
  noAtoms : NoAtoms wta.τ

def WTA_vertex (i : WTAΩ) : WTAProfile :=
  fun j => if i = j then 1 else -1

def WTA_mixedLabel (lam : WTAΩ → ℝ) : WTAProfile :=
  fun j => ∑ i : WTAΩ, lam i * WTA_vertex i j

def WTASupport (lam : WTAΩ → ℝ) : Set WTAΩ :=
  {i : WTAΩ | 0 < lam i}

def WTAKminus (I : Set WTAΩ) : Set WTABelief :=
  {s : WTABelief | ∀ i : WTAΩ, i ∈ I → ∀ k : WTAΩ, s.val i ≤ s.val k}

def WTABcone (I : Set WTAΩ) : Set WTABelief :=
  {p : WTABelief | ∀ i : WTAΩ, i ∈ I → ∀ k : WTAΩ, p.val k ≤ p.val i}

def WTABconeProfile (I : Set WTAΩ) : Set WTAProfile :=
  {p : WTAProfile | ∀ i : WTAΩ, i ∈ I → ∀ k : WTAΩ, p k ≤ p i}

def WTARowwiseMinimizer (I : Set WTAΩ) (lam : WTAΩ → ℝ)
    (s : WTABelief) (m : WTAProfile) : Prop :=
  m = WTA_mixedLabel lam ∧
    ∀ m' : WTAProfile, m' ∈ Set.range WTA_vertex →
      beliefDot s m ≤ beliefDot s m'

def WTABayesOptimalWTA (I : Set WTAΩ) (lam : WTAΩ → ℝ)
    (p : WTABelief) (m : WTAProfile) : Prop :=
  m = WTA_mixedLabel lam ∧
    ∀ m' : WTAProfile, m' ∈ Set.range WTA_vertex →
      beliefDot p m' ≤ beliefDot p m

structure NullDustData (wta : WTATernaryAlgebra) where
  N : Set WTABelief
  measurable_N : MeasurableSet N
  tau_null : wta.τ N = 0
  wN : {m : WTABelief // m ∈ N} → WTAProfile
  lam : {m : WTABelief // m ∈ N} → WTAΩ → ℝ
  I : {m : WTABelief // m ∈ N} → Set WTAΩ
  lam_measurable :
    ∀ i : WTAΩ, Measurable (fun m : {m : WTABelief // m ∈ N} => lam m i)
  lam_nonneg : ∀ m i, 0 ≤ lam m i
  lam_sum_one : ∀ m, ∑ i : WTAΩ, lam m i = 1
  lam_support_nonempty : ∀ m, (I m).Nonempty
  lam_support_positive : ∀ m i, i ∈ I m ↔ 0 < lam m i
  wN_eq_mixed_label : ∀ m, wN m = WTA_mixedLabel (lam m)

abbrev NDust {wta : WTATernaryAlgebra} (dust : NullDustData wta) : Type :=
  {m : WTABelief // m ∈ dust.N}

structure AdversarialFlowDisintegrationData
    (wta : WTATernaryAlgebra) (dust : NullDustData wta) where
  α : ℝ
  α_nonneg : 0 ≤ α
  α_le_one : α ≤ 1
  κ : Kernel WTABelief WTABelief
  κ_markov : IsMarkovKernel κ
  ν : Measure (WTABelief × WTABelief)
  νN : Measure (WTABelief × NDust dust)
  nuN_raw : Measure (WTABelief × WTABelief)
  qN : Measure (NDust dust)
  ρ : Kernel (NDust dust) WTABelief
  ρ_markov : IsMarkovKernel ρ
  ρ_prob : ∀ m, IsProbabilityMeasure (ρ m)
  nu_eq_compProd : ν = wta.τ.compProd κ
  nuN_eq_restrict :
    nuN_raw = ν.restrict {p : WTABelief × WTABelief | p.2 ∈ dust.N}
  nuN_subtype_pushforward :
    νN.map (fun p : WTABelief × NDust dust => (p.1, (p.2 : WTABelief))) = nuN_raw
  qN_eq_marginal : qN = νN.map Prod.snd
  rho_disintegrates_nuN :
    νN.map (fun p : WTABelief × NDust dust => (p.2, p.1)) = qN.compProd ρ

def RowwiseSupport (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust) : Prop :=
  ∀ᵐ p ∂flow.νN, p.1 ∈ WTAKminus (dust.I p.2)

def BayesConeCalibration (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust) : Prop :=
  ∀ᵐ m ∂flow.qN, beliefBarycenter (flow.ρ m) ∈ WTABconeProfile (dust.I m)

noncomputable def WTAMixtureMessageLaw (wta : WTATernaryAlgebra)
    (α : ℝ) (κ : Kernel WTABelief WTABelief) : Measure WTABelief :=
  (ENNReal.ofReal α) • wta.τ +
    (ENNReal.ofReal (1 - α)) • ((wta.τ.compProd κ).map Prod.snd)

def WTAPositiveQMass (wta : WTATernaryAlgebra)
    (α : ℝ) (N : Set WTABelief) (κ : Kernel WTABelief WTABelief) : Prop :=
  0 < WTAMixtureMessageLaw wta α κ N

/-! ## Halfspace witness objects -/

def HalfspaceTrustRegion : Set WTABelief :=
  {μ : WTABelief | μ.val (0 : Fin 3) ≤ (2 : ℝ) / 5}

def FullSimplexTrustRegion : Set WTABelief :=
  Set.univ

def WTAInducesVertex (μ : WTABelief) (i : WTAΩ) : Prop :=
  ∀ k : WTAΩ, μ.val k ≤ μ.val i

def ContainsBeliefsForAllVertices (T : Set WTABelief) : Prop :=
  ∀ i : WTAΩ, ∃ μ : WTABelief, μ ∈ T ∧ WTAInducesVertex μ i

def FullWTAVertexMenu : Set WTAProfile :=
  Set.range WTA_vertex

def InducedEffectiveMenu (T : Set WTABelief) : Set WTAProfile :=
  {v : WTAProfile |
    ∃ i : WTAΩ, v = WTA_vertex i ∧ ∃ μ : WTABelief, μ ∈ T ∧ WTAInducesVertex μ i}

def BehaviorEquivalentTrustRegion (T U : Set WTABelief) : Prop :=
  InducedEffectiveMenu T = InducedEffectiveMenu U

def MenuEngineArtifact (T : Set WTABelief) : Prop :=
  ContainsBeliefsForAllVertices T ∧
    InducedEffectiveMenu T = FullWTAVertexMenu ∧
    BehaviorEquivalentTrustRegion T FullSimplexTrustRegion

structure EffectiveMenuEquivalenceData where
  T : Set WTABelief
  contains_all_vertices : ContainsBeliefsForAllVertices T
  induced_full_vertices : InducedEffectiveMenu T = FullWTAVertexMenu
  behavior_equivalent : BehaviorEquivalentTrustRegion T FullSimplexTrustRegion

/-! ## Package statement definitions -/

def Tier1aResult (model : RobustTrustModel)
    (σstar : AgentStrategyFull model) : Prop :=
  RobustPayoffFull model σstar = UStarFull model ∧
    ∀ ε : ℝ, 0 < ε →
      ∃ βε : AdviserKernel model,
        MixturePayoffFull model βε σstar ≤
            RobustPayoffFull model σstar + (1 - model.α) * ε ∧
          MixturePayoffFull model βε σstar ≤ UStarFull model + ε

structure Tier1bResult (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model σstar) where
  βstar : AdviserKernel model
  deterministic : ∀ s : model.M, βstar.kernel s = Measure.dirac (ec.selector s)
  supported_on_G : KernelSupportedOnG model ec.cdagger βstar
  adversarial : IsAdversarialFull model βstar σstar
  value : MixturePayoffFull model βstar σstar = UStarFull model

def Tier2Result (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (mh : MenuHall model pd σstar ec κ) : Prop :=
  (let βstar : AdviserKernel model := κ;
    βstar = κ ∧
      mh.q = MixtureMessageLaw model κ ∧
      mh.q = (MixtureCouplingGammaAlpha model κ).map Prod.snd ∧
      IsAdversarialFull model κ σstar ∧
      MixturePayoffFull model κ σstar = UStarFull model ∧
      Definition2QAEPredicate model pd κ σstar ∧
      (0 < model.α →
        ∀ᵐ m ∂model.τM,
          IsBayesOptimal model (σstar.sectionFull (model.inclM m)) (pd.Pγα κ m)))

def WTA_ConeIntersectionStatement : Prop :=
  ∀ (wta : WTATernaryAlgebra) (I : Set WTAΩ) (lam : WTAΩ → ℝ),
    WTASupport lam = I →
    (∀ i : WTAΩ, i ∈ I → 0 < lam i) →
    (∑ i : WTAΩ, lam i = 1) →
    I.Nonempty →
    ∀ ρ : Measure WTABelief, IsProbabilityMeasure ρ →
      ρ (WTAKminus I) = 1 →
      beliefBarycenter ρ ∈ WTABconeProfile I →
      ρ = Measure.dirac wta.μ0

def WTA_NoFreeDustStatement : Prop :=
  ∀ (wta : WTATernaryAlgebra), AtomlessTauSharpness wta →
    ∀ α : ℝ, 0 ≤ α → α ≤ 1 →
      ¬ ∃ (dust : NullDustData wta)
          (flow : AdversarialFlowDisintegrationData wta dust),
        flow.α = α ∧
          WTAPositiveQMass wta α dust.N flow.κ ∧
          RowwiseSupport wta dust flow ∧
          BayesConeCalibration wta dust flow

def HalfspaceWitnessStatement : Prop :=
  ContainsBeliefsForAllVertices HalfspaceTrustRegion ∧
    InducedEffectiveMenu HalfspaceTrustRegion = FullWTAVertexMenu ∧
    BehaviorEquivalentTrustRegion HalfspaceTrustRegion FullSimplexTrustRegion

def RobustTrustInfiniteExtensionV8Package
    (model : RobustTrustModel)
    (_plc : PosteriorLawConsistency model)
    (msupp : MessageSupportM model)
    (_bridge : MessageRestrictionBridge model msupp)
    (_prs : ProfileRealizationSetup model) : Prop :=
  ∃ σstar : AgentStrategyFull model,
    Tier1aResult model σstar ∧
      (∀ ec : ExactContact model σstar, Nonempty (Tier1bResult model σstar ec)) ∧
      (∀ (pd : PosteriorDisintegration model)
          (ec : ExactContact model σstar)
          (κ : AdviserKernel model)
          (mh : MenuHall model pd σstar ec κ),
        Tier2Result model pd σstar ec κ mh) ∧
      WTA_ConeIntersectionStatement ∧
      WTA_NoFreeDustStatement ∧
      HalfspaceWitnessStatement

/-! ## 59 theorem declarations in dependency order -/

theorem posterior_law_barycenter_identities
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model) :
    beliefBarycenter model.τ = model.μ0 ∧
      (∀ ω : model.Ω,
        (ENNReal.ofReal (model.μ0 ω)) • model.π ω =
          model.τ.withDensity (fun s => ENNReal.ofReal (beliefCoord s ω))) ∧
      (∀ᵐ s ∂model.τ, plc.posteriorAfterAdviser s = s) := by
  sorry

theorem strategy_restriction_to_M
    (model : RobustTrustModel)
    (σFull : AgentStrategyFull model) :
    ∃ σM : AgentStrategyM model,
      ∀ m : model.M, σM.sectionM m = σFull.sectionFull (model.inclM m) := by
  sorry

theorem restricted_agent_strategy_extends_to_full
    (model : RobustTrustModel)
    (msupp : MessageSupportM model)
    (bridge : MessageRestrictionBridge model msupp)
    (σM : AgentStrategyM model) :
    ∃ σFull : AgentStrategyFull model,
      ∀ m : model.M, σFull.sectionFull (model.inclM m) = σM.sectionM m := by
  sorry

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
  sorry

theorem adversary_kernels_restrict_to_M
    (model : RobustTrustModel)
    (msupp : MessageSupportM model)
    (bridge : MessageRestrictionBridge model msupp)
    (σFull : AgentStrategyFull model) :
    sInf (Set.range fun βFull : FullMessageAdviserKernel model =>
        MixturePayoffFullRaw model βFull σFull) =
      sInf (Set.range fun βM : AdviserKernel model =>
        MixturePayoffFull model βM σFull) ∧
    RobustPayoffFull model σFull =
      RobustPayoffM model (restrictFullToM model σFull) := by
  sorry

theorem full_restricted_Ustar_equivalence
    (model : RobustTrustModel)
    (msupp : MessageSupportM model)
    (bridge : MessageRestrictionBridge model msupp) :
    UStarFull model = UStarM model ∧
      ∀ (σFull : AgentStrategyFull model) (σM : AgentStrategyM model),
        (∀ m : model.M, σFull.sectionFull (model.inclM m) = σM.sectionM m) →
          RobustPayoffFull model σFull = RobustPayoffM model σM := by
  sorry

theorem q_dominates_tau_when_alpha_pos
    (model : RobustTrustModel)
    (β : AdviserKernel model)
    {P : model.M → Prop}
    (hα : 0 < model.α)
    (hP : ∀ᵐ m ∂MixtureMessageLaw model β, P m) :
    ∀ᵐ m ∂model.τM, P m := by
  sorry

theorem payoff_profile_set_compact_convex
    (model : RobustTrustModel)
    (prs : ProfileRealizationSetup model) :
    IsCompact (PayoffProfileSet model) ∧
      Convex ℝ (PayoffProfileSet model) ∧
      (∀ w : Profile model, w ∈ PayoffProfileSet model →
        ∃ σ : model.PrivateStrategy, model.profileOfPrivate σ = w) := by
  sorry

theorem profile_map_has_borel_right_inverse
    (model : RobustTrustModel)
    (prs : ProfileRealizationSetup model) :
    ∃ R : ProfileInW model → model.PrivateStrategy,
      Measurable R ∧
        ∀ w : ProfileInW model, model.profileOfPrivate (R w) = w.val := by
  sorry

theorem borel_profile_map_implemented_by_agent_strategy
    (model : RobustTrustModel)
    (R : ProfileRealizationMap model)
    (wMap : model.M → ProfileInW model)
    (hwMap : Measurable wMap) :
    ∃ σM : AgentStrategyM model,
      ∀ m : model.M, profileMap model σM m = (wMap m).val := by
  sorry

theorem profile_payoff_decomposition_aligned
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (σM : AgentStrategyM model) :
    AlignedPayoffM model σM =
      ∫ s, beliefDot (model.inclM s) (profileMap model σM s) ∂model.τM := by
  sorry

theorem profile_payoff_decomposition_misaligned
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (β : AdviserKernel model)
    (σM : AgentStrategyM model) :
    MisalignedPayoffM model β σM =
      ∫ s, ∫ m, beliefDot (model.inclM s) (profileMap model σM m) ∂(β.kernel s) ∂model.τM := by
  sorry

theorem mixture_payoff_decomposition
    (model : RobustTrustModel)
    (β : AdviserKernel model)
    (σM : AgentStrategyM model)
    (σFull : AgentStrategyFull model) :
    MixturePayoffM model β σM =
        model.α * AlignedPayoffM model σM +
          (1 - model.α) * MisalignedPayoffM model β σM ∧
      MixturePayoffFull model β σFull =
        model.α * AlignedPayoffFull model σFull +
          (1 - model.α) * MisalignedPayoffFull model β σFull := by
  sorry

theorem adversary_infimum_pointwise
    (model : RobustTrustModel)
    (w : model.M → ProfileInW model)
    (hw_meas : Measurable w)
    (hg_meas :
      Measurable fun p : model.M × model.M =>
        beliefDot (model.inclM p.1) (w p.2).val)
    (hw_bdd :
      ∃ C : ℝ, ∀ s m : model.M,
        |beliefDot (model.inclM s) (w m).val| ≤ C)
    (hinf_meas :
      Measurable fun s : model.M =>
        sInf (Set.range fun m : model.M =>
          beliefDot (model.inclM s) (w m).val))
    (hinf_int :
      Integrable
        (fun s : model.M =>
          sInf (Set.range fun m : model.M =>
            beliefDot (model.inclM s) (w m).val)) model.τM)
    (hkernel_int :
      ∀ β : AdviserKernel model,
        Integrable
          (fun p : model.M × model.M =>
            beliefDot (model.inclM p.1) (w p.2).val)
          (model.τM.compProd β.kernel)) :
    sInf (Set.range fun β : AdviserKernel model =>
      ∫ s, ∫ m, beliefDot (model.inclM s) (w m).val ∂(β.kernel s) ∂model.τM) =
        ∫ s, sInf (Set.range fun m : model.M =>
          beliefDot (model.inclM s) (w m).val) ∂model.τM := by
  sorry

theorem strategy_value_le_menu_sup
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (σM : AgentStrategyM model) :
    RobustPayoffM model σM ≤ sSup (Set.range (MenuFunctionalF model)) := by
  sorry

theorem menu_value_le_strategy_sup
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (prm : ProfileRealizationMap model)
    (C : CompactMenu model) :
    MenuFunctionalF model C ≤ UStarM model := by
  sorry

theorem menu_value_equivalence
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (prm : ProfileRealizationMap model) :
    UStarM model = sSup (Set.range (MenuFunctionalF model)) := by
  sorry

theorem compact_menu_space_compact
    (model : RobustTrustModel)
    (prs : ProfileRealizationSetup model) :
    CompactSpace (CompactMenu model) := by
  sorry

theorem menu_extrema_Hausdorff_Lipschitz
    (model : RobustTrustModel) :
    ∃ L : ℝ, 0 ≤ L ∧
      ∀ (C D : CompactMenu model) (s : model.M),
        |maxPayoff model C s - maxPayoff model D s| ≤ L * dist C D ∧
        |minPayoff model C s - minPayoff model D s| ≤ L * dist C D := by
  sorry

theorem menu_functional_continuity
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model) :
    Continuous (MenuFunctionalF model) := by
  sorry

theorem optimal_menu_exists
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model) :
    ∃ Cstar : CompactMenu model,
      ∀ C : CompactMenu model, MenuFunctionalF model C ≤ MenuFunctionalF model Cstar := by
  sorry

theorem aligned_best_labeling_selection
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model) :
    ∃ wlabel : AlignedBestLabelingWstar model opt,
      (∀ m : model.M, wlabel.wstar m ∈ (↑opt.Cstar : Set (ProfileInW model))) ∧
        (∀ m : model.M,
          IsMaxOn (fun w : ProfileInW model => beliefDot (model.inclM m) w.val)
            (↑opt.Cstar : Set (ProfileInW model)) (wlabel.wstar m)) := by
  sorry

theorem closure_pruning_value_preservation
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt) :
    ∃ cdagger : PrunedMenuCdagger model wlabel,
      (↑cdagger.Cdagger : Set (ProfileInW model)) ⊆
          (↑opt.Cstar : Set (ProfileInW model)) ∧
        MenuFunctionalF model cdagger.Cdagger = MenuFunctionalF model opt.Cstar ∧
        MenuFunctionalF model opt.Cstar = UStarM model := by
  sorry

theorem wstar_profile_map_implemented
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (prm : ProfileRealizationMap model)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt)
    (cdagger : PrunedMenuCdagger model wlabel) :
    ∃ σM : AgentStrategyM model,
      ∀ m : model.M, profileMap model σM m = (wlabel.wstar m).val := by
  sorry

theorem wstar_payoff_equals_F_Cdagger
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt)
    (cdagger : PrunedMenuCdagger model wlabel)
    (σM : AgentStrategyM model)
    (hprofile : ∀ m : model.M, profileMap model σM m = (wlabel.wstar m).val) :
    AlignedPayoffM model σM =
        ∫ s, maxPayoff model cdagger.Cdagger s ∂model.τM ∧
      sInf (Set.range fun β : AdviserKernel model => MisalignedPayoffM model β σM) =
        ∫ s, minPayoff model cdagger.Cdagger s ∂model.τM ∧
      RobustPayoffM model σM = MenuFunctionalF model cdagger.Cdagger := by
  sorry

theorem sigma_star_robust_optimal
    (model : RobustTrustModel)
    (msupp : MessageSupportM model)
    (bridge : MessageRestrictionBridge model msupp)
    (σstarM : AgentStrategyM model)
    (hσstarM : RobustPayoffM model σstarM = UStarM model) :
    ∃ σstarFull : AgentStrategyFull model,
      RobustPayoffFull model σstarFull = UStarFull model ∧
        ∀ m : model.M, σstarFull.sectionFull (model.inclM m) = σstarM.sectionM m := by
  sorry

theorem geps_nonempty
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt)
    (cdagger : PrunedMenuCdagger model wlabel)
    {ε : ℝ}
    (hε : 0 < ε) :
    ∀ s : model.M, (EpsilonContactGeps model cdagger ε s).Nonempty := by
  sorry

theorem geps_graph_measurable
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt)
    (cdagger : PrunedMenuCdagger model wlabel)
    {ε : ℝ}
    (hε : 0 < ε) :
    MeasurableSet
      {p : model.M × model.M | p.2 ∈ EpsilonContactGeps model cdagger ε p.1} := by
  sorry

theorem geps_selector_exists
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt)
    (cdagger : PrunedMenuCdagger model wlabel)
    {ε : ℝ}
    (hε : 0 < ε) :
    ∃ mε : model.M → model.M,
      Measurable mε ∧
        ∀ s : model.M, mε s ∈ EpsilonContactGeps model cdagger ε s := by
  sorry

theorem epsilon_adversary_realization
    (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model) :
    ∀ ε : ℝ, 0 < ε →
      ∃ βε : AdviserKernel model,
        MixturePayoffFull model βε σstar ≤
            RobustPayoffFull model σstar + (1 - model.α) * ε ∧
          MixturePayoffFull model βε σstar ≤ UStarFull model + ε := by
  sorry

theorem exact_contact_selector_unpack
    (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model σstar) :
    ∃ mstar : model.M → model.M,
      Measurable mstar ∧
        (∀ᵐ s ∂model.τM, mstar s ∈ RowwiseContactG model ec.cdagger s) ∧
        (∀ m : model.M,
          profileMap model (restrictFullToM model σstar) m = (ec.wlabel.wstar m).val) := by
  sorry

theorem exact_adversary_attainment
    (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model)
    (ec : ExactContact model σstar) :
    ∃ βstar : AdviserKernel model,
      (∀ s : model.M, βstar.kernel s = Measure.dirac (ec.selector s)) ∧
        KernelSupportedOnG model ec.cdagger βstar ∧
        IsAdversarialFull model βstar σstar ∧
        MixturePayoffFull model βstar σstar = RobustPayoffFull model σstar ∧
        RobustPayoffFull model σstar = UStarFull model := by
  sorry

theorem menuHall_adversary_kernel_identity
    (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (mh : MenuHall model pd σstar ec κ) :
    (let βstar : AdviserKernel model := κ;
      βstar = κ ∧
        mh.q = MixtureMessageLaw model κ ∧
        mh.q = (MixtureCouplingGammaAlpha model κ).map Prod.snd) := by
  sorry

theorem menu_hall_posterior_calibration_unpack
    (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (mh : MenuHall model pd σstar ec κ) :
    ∀ᵐ m ∂mh.q, pd.Pγα κ m ∈ BayesOptimalityBeliefCorrespondenceBm model σstar m := by
  sorry

theorem menu_hall_support_implies_exact_adversary
    (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (hsupp : KernelSupportedOnG model ec.cdagger κ) :
    IsAdversarialFull model κ σstar ∧
      MixturePayoffFull model κ σstar = UStarFull model := by
  sorry

theorem per_message_Bayes_optimality
    (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (mh : MenuHall model pd σstar ec κ) :
    (∀ᵐ m ∂mh.q,
      IsBayesOptimal model (σstar.sectionFull (model.inclM m)) (pd.Pγα κ m)) ∧
    (0 < model.α →
      ∀ᵐ m ∂model.τM,
        IsBayesOptimal model (σstar.sectionFull (model.inclM m)) (pd.Pγα κ m)) := by
  sorry

theorem posterior_disintegration_menuHall_kernel_coincides
    (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (mh : MenuHall model pd σstar ec κ) :
    ∀ᵐ m ∂MixtureMessageLaw model κ, pd.Pβ κ m = pd.Pγα κ m := by
  sorry

theorem support_function_pointwise_membership_equivalence
    (model : RobustTrustModel)
    (q : Measure model.M)
    [IsFiniteMeasure q]
    (B : model.M → Set (Profile model))
    (P : model.M → Profile model)
    (hP_meas : Measurable P)
    (hB_closed : ∀ m, IsClosed (B m))
    (hB_convex : ∀ m, Convex ℝ (B m))
    (hB_nonempty : ∀ m, (B m).Nonempty)
    (hB_bounded : ∀ m, Bornology.IsBounded (B m))
    (hB_meas_graph : MeasurableSet {p : model.M × Profile model | p.2 ∈ B p.1}) :
    (∀ᵐ m ∂q, P m ∈ B m) ↔
      (∀ᵐ m ∂q, ∀ ℓ : Profile model →L[ℝ] ℝ,
        ℓ (P m) ≤ sSup (ℓ '' B m)) := by
  sorry

theorem support_function_integrated_Hall_equivalence
    (model : RobustTrustModel)
    (q : Measure model.M)
    [IsFiniteMeasure q]
    (B : model.M → Set (Profile model))
    (P : model.M → Profile model)
    (hP_meas : Measurable P)
    (hB_closed : ∀ m, IsClosed (B m))
    (hB_convex : ∀ m, Convex ℝ (B m))
    (hB_nonempty : ∀ m, (B m).Nonempty)
    (hB_bounded : ∀ m, Bornology.IsBounded (B m))
    (hB_meas_graph : MeasurableSet {p : model.M × Profile model | p.2 ∈ B p.1})
    (hsupp_meas : ∀ ℓ : Profile model →L[ℝ] ℝ, Measurable fun m => sSup (ℓ '' B m))
    (hsupp_int : ∀ ℓ : Profile model →L[ℝ] ℝ, Integrable (fun m => sSup (ℓ '' B m)) q)
    (hP_int : ∀ ℓ : Profile model →L[ℝ] ℝ, Integrable (fun m => ℓ (P m)) q) :
    PosteriorCalibrationProfiles model q B P ↔
      SupportFunctionHallInequalities model q B P := by
  sorry

theorem tier1a_value_optimality_and_epsilon_adversary
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (msupp : MessageSupportM model)
    (bridge : MessageRestrictionBridge model msupp)
    (prs : ProfileRealizationSetup model) :
    ∃ σstar : AgentStrategyFull model, Tier1aResult model σstar := by
  sorry

theorem tier1b_exact_adversary_under_exact_contact
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (msupp : MessageSupportM model)
    (bridge : MessageRestrictionBridge model msupp)
    (prs : ProfileRealizationSetup model)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model)
    (ec : ExactContact model σstar) :
    Nonempty (Tier1bResult model σstar ec) := by
  sorry

theorem tier2_qae_robust_rationalizability_under_menu_Hall
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (prs : ProfileRealizationSetup model)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (mh : MenuHall model pd σstar ec κ) :
    Tier2Result model pd σstar ec κ mh := by
  sorry

theorem wta_payoff_dot_product_identity
    (lam : WTAΩ → ℝ)
    (hlam_nonneg : ∀ i : WTAΩ, 0 ≤ lam i)
    (hlam_sum : ∑ i : WTAΩ, lam i = 1)
    (s : WTABelief) :
    beliefDot s (WTA_mixedLabel lam) =
      2 * (∑ i : WTAΩ, lam i * s.val i) - 1 := by
  sorry

theorem wta_rowwise_minimizer_and_Bayes_cone_identification
    (I : Set WTAΩ)
    (lam : WTAΩ → ℝ)
    (hI : I.Nonempty)
    (h_support_eq : WTASupport lam = I)
    (h_pos_on_I : ∀ i : WTAΩ, i ∈ I → 0 < lam i)
    (hlam_nonneg : ∀ i : WTAΩ, 0 ≤ lam i)
    (hlam_sum : ∑ i : WTAΩ, lam i = 1)
    (s p : WTABelief) :
    (WTARowwiseMinimizer I lam s (WTA_mixedLabel lam) ↔ s ∈ WTAKminus I) ∧
      (WTABayesOptimalWTA I lam p (WTA_mixedLabel lam) ↔ p ∈ WTABcone I) := by
  sorry

theorem wta_cone_intersection
    (wta : WTATernaryAlgebra)
    (I : Set WTAΩ)
    (lam : WTAΩ → ℝ)
    (h_support_eq : WTASupport lam = I)
    (h_pos_on_I : ∀ i : WTAΩ, i ∈ I → 0 < lam i)
    (h_sum_one : ∑ i : WTAΩ, lam i = 1)
    (hI : I.Nonempty)
    (ρ : Measure WTABelief)
    [IsProbabilityMeasure ρ]
    (hρ_support : ρ (WTAKminus I) = 1)
    (hbary : beliefBarycenter ρ ∈ WTABconeProfile I) :
    ρ = Measure.dirac wta.μ0 := by
  sorry

theorem dust_disintegration_over_subtype_N
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust) :
    flow.νN.map (fun p : WTABelief × NDust dust => (p.2, p.1)) =
      flow.qN.compProd flow.ρ := by
  sorry

theorem qN_supported_on_N
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust) :
    ∀ᵐ m ∂flow.qN, (m.val : WTABelief) ∈ dust.N := by
  sorry

theorem dust_rowwise_support_implies_cone_support
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hrow : RowwiseSupport wta dust flow) :
    ∀ᵐ m ∂flow.qN, flow.ρ m (WTAKminus (dust.I m)) = 1 := by
  sorry

theorem dust_Bayes_calibration_gives_cone_barycenter
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hcal : BayesConeCalibration wta dust flow) :
    ∀ᵐ m ∂flow.qN, beliefBarycenter (flow.ρ m) ∈ WTABconeProfile (dust.I m) := by
  sorry

theorem dust_conditional_sources_satisfy_cones
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hrow : RowwiseSupport wta dust flow)
    (hcal : BayesConeCalibration wta dust flow) :
    ∀ᵐ m ∂flow.qN,
      flow.ρ m (WTAKminus (dust.I m)) = 1 ∧
        beliefBarycenter (flow.ρ m) ∈ WTABconeProfile (dust.I m) := by
  sorry

theorem cone_intersection_applied_to_dust
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hrow : RowwiseSupport wta dust flow)
    (hcal : BayesConeCalibration wta dust flow) :
    ∀ᵐ m ∂flow.qN, flow.ρ m = Measure.dirac wta.μ0 := by
  sorry

theorem positive_dust_mass_impossible_when_alpha_one
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hα : flow.α = 1) :
    ¬ WTAPositiveQMass wta flow.α dust.N flow.κ := by
  sorry

theorem dust_positive_mass_forces_mu0_atom
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hpos : WTAPositiveQMass wta flow.α dust.N flow.κ)
    (hα : flow.α < 1)
    (hdirac : ∀ᵐ m ∂flow.qN, flow.ρ m = Measure.dirac wta.μ0) :
    0 < wta.τ ({wta.μ0} : Set WTABelief) := by
  sorry

theorem wta_no_free_dust
    (wta : WTATernaryAlgebra)
    (sharp : AtomlessTauSharpness wta)
    (α : ℝ)
    (hα0 : 0 ≤ α)
    (hα1 : α ≤ 1) :
    ¬ ∃ (dust : NullDustData wta)
        (flow : AdversarialFlowDisintegrationData wta dust),
      flow.α = α ∧
        WTAPositiveQMass wta α dust.N flow.κ ∧
        RowwiseSupport wta dust flow ∧
        BayesConeCalibration wta dust flow := by
  sorry

theorem sharpness_corollary
    (wta : WTATernaryAlgebra)
    (sharp : AtomlessTauSharpness wta)
    (α : ℝ)
    (hα0 : 0 ≤ α)
    (hα1 : α ≤ 1) :
    (∀ ρ : Measure WTABelief, IsProbabilityMeasure ρ →
      ρ (WTAKminus ({(0 : Fin 3)} : Set WTAΩ)) = 1 →
      beliefBarycenter ρ ∈ WTABconeProfile ({(0 : Fin 3)} : Set WTAΩ) →
      ρ = Measure.dirac wta.μ0) ∧
    (¬ ∃ (dust : NullDustData wta)
        (flow : AdversarialFlowDisintegrationData wta dust),
      flow.α = α ∧
        WTAPositiveQMass wta α dust.N flow.κ ∧
        RowwiseSupport wta dust flow ∧
        BayesConeCalibration wta dust flow) := by
  sorry

theorem halfspace_contains_beliefs_inducing_all_vertices :
    ContainsBeliefsForAllVertices HalfspaceTrustRegion := by
  sorry

theorem halfspace_induced_effective_menu_equals_full_vertices :
    InducedEffectiveMenu HalfspaceTrustRegion = FullWTAVertexMenu := by
  sorry

theorem halfspace_behavior_equivalent_to_full_simplex :
    BehaviorEquivalentTrustRegion HalfspaceTrustRegion FullSimplexTrustRegion := by
  sorry

theorem halfspace_witness_menu_engine_artifact :
    HalfspaceWitnessStatement := by
  sorry

/-! ## Main theorem package -/

theorem robust_trust_infinite_extension_v8_package
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (msupp : MessageSupportM model)
    (bridge : MessageRestrictionBridge model msupp)
    (prs : ProfileRealizationSetup model) :
    RobustTrustInfiniteExtensionV8Package model plc msupp bridge prs := by
  sorry

end

end RobustTrustV8


## Decomposition (English statements)

lean_structure
main_theorem: robust-trust-infinite-extension-v8-package
object_count: 53
lemma_count: 59
external_count: 17
implicit_assumption_count: 0
non_mathlib_count: 9
Objects and Definitions
robust-trust-model

English name: Robust Trust model instance

Informal type: A bundled model satisfying the standing Robust Trust hypotheses: finite state space, full-support prior, adviser posterior process, compact metric type and action spaces, bounded payoff continuous in action, conditional independence of adviser posterior and type given state, and alignment probability.

Suggested Lean modeling: structure

Key fields / operations:
Ω : Type, [Fintype Ω]; μ0 : ProbabilityMass Ω; fullSupport μ0; Belief Ω := {s : Ω → ℝ // (∀ ω, 0 ≤ s ω) ∧ ∑ ω, s ω = 1}; π : Ω → ProbabilityMeasure (Belief Ω); τ : ProbabilityMeasure (Belief Ω); Θ A : Type; compact metric and standard-Borel structures; [Nonempty Θ]; [Nonempty A]; u : A → Ω → Θ → ℝ; boundedness; continuity in action; measurability; conditional type laws; conditional independence of adviser posterior and type given state; α : ℝ; 0 ≤ α; α ≤ 1.

Used by: all positive-tier objects and WTA specialization objects.

Modeling notes: Exact-contact, menu-Hall, and atomlessness are not standing fields. They remain theorem-level hypotheses or separate sharpness objects.

finite-state-and-belief-simplex

English name: Finite state space and belief simplex

Informal type: A finite state space Ω and the finite-dimensional probability simplex Δ Ω.

Suggested Lean modeling: subtype of Ω → ℝ.

Key fields / operations:
Belief Ω := {s : Ω → ℝ // (∀ ω, 0 ≤ s ω) ∧ ∑ ω, s ω = 1}; coordinate projections; dot product dot : Belief Ω → (Ω → ℝ) → ℝ; barycenter of a probability law on Belief Ω; finite sums over Ω.

Used by: posterior-law identities, payoff decompositions, menu extrema, WTA cone intersection.

Modeling notes: The nonnegativity condition is coordinatewise: ∀ ω, 0 ≤ s ω. Do not model it as a scalar inequality 0 ≤ s.

prior-and-adviser-posterior-law

English name: Prior and adviser posterior law

Informal type: The prior, state-conditional adviser-posterior laws, unconditional posterior law, and message support.

Suggested Lean modeling: fields inside robust-trust-model plus helper definitions.

Key fields / operations:
μ0; π; τ; unconditional law identity τ = ∑ ω, μ0 ω • π ω; support M := supp τ; inclusion M → Belief Ω; integration over τ.

Used by: posterior-law-barycenter-identities, message-support-M, mixture-message-law, posterior-disintegration, sharpness dust objects.

Modeling notes: Atomlessness is not part of this object. It is separated into AtomlessTauSharpness.

posterior-law-consistency-field

English name: Bayes-plausibility and posterior-law consistency

Informal type: A field asserting that the random variable s : Δ Ω is the Bayesian posterior generated by π and μ0.

Suggested Lean modeling: field in robust-trust-model or separate structure parameterized by the model.

Key fields / operations:
For each state coordinate ω, finite-measure identity
μ0 ω • π ω = (fun s => s ω) • τ;
barycenter identity ∫ s ∂τ = μ0;
posterior identity after observing adviser posterior s is s, τ-a.e.;
conditional barycenter identities after disintegration.

Used by: posterior-law-barycenter-identities, payoff-profile decompositions, menu-Hall posterior calibration, dust disintegration.

Modeling notes: This prevents silently treating an arbitrary law on Δ Ω as a posterior law.

message-support-M

English name: Message support space

Informal type: M := supp τ, treated as the on-path message space for aligned reports and as the restricted codomain for adversarial reports.

Suggested Lean modeling: subtype {s : Belief Ω // s ∈ supp τ}.

Key fields / operations:
inclM : M → Belief Ω; τM; M Borel and compact as closed support in compact simplex; standard-Borel structure; truthful identity report on M.

Used by: full and restricted strategy bridge, adversary kernels, mixture message law, contact correspondences.

Modeling notes: Using a subtype prevents kernels from accidentally using off-support messages in restricted arguments.

message-restriction-bridge

English name: Full-message to support-message bridge

Informal type: Data and propositions connecting the paper’s full message space Δ Ω to the menu engine’s support-message space M.

Suggested Lean modeling: structure plus bridge lemmas.

Key fields / operations:
restriction of full strategies to M; extension of restricted strategies to full Δ Ω by a default private strategy outside M; proof that M is Borel; proof that off-M values do not affect on-path payoffs; proof that adversarial kernels can be restricted to M without changing the robust value.

Used by: strategy-restriction-to-M, restricted-agent-strategy-extends-to-full, outside-M-messages-irrelevant, adversary-kernels-restrict-to-M, full-restricted-Ustar-equivalence.

Modeling notes: This is the formal bridge for the paper’s “without loss, adversarial strategies only use messages in M” line.

type-action-payoff-primitives

English name: Agent type, action, and payoff primitives

Informal type: Compact metric type space, compact metric action space, bounded payoff, and conditional type laws.

Suggested Lean modeling: fields inside robust-trust-model.

Key fields / operations:
Θ; A; nonemptiness; compact metric and measurable structures; typeLaw : Ω → ProbabilityMeasure Θ; u : A → Ω → Θ → ℝ; boundedness; continuity in action; measurability in all variables.

Used by: private-payoff-functional, payoff-profile-set-W, profile-realization-setup.

Modeling notes: Do not strengthen to continuity in type unless the source proof explicitly adds it.

private-strategy-space

English name: Private strategy space

Informal type: Measurable kernels or maps hatσ : Θ → Δ A.

Suggested Lean modeling: structure for measurable Markov kernels from Θ to A.

Key fields / operations:
actKernel : Θ → ProbabilityMeasure A; measurability; expected payoff against a belief; profile map Φ; nonempty default private strategy for full-message extension.

Used by: private-payoff-functional, profile-realization-setup, Bayes-optimality-belief-correspondence-Bm.

Modeling notes: Compactness/topology of this space comes through profile-realization-setup.

agent-strategy-full

English name: Full agent strategy space

Informal type: The paper’s strategy space Σ, measurable strategies on Δ Ω × Θ.

Suggested Lean modeling: structure for measurable kernels from Belief Ω × Θ to A, equivalently a measurable section from full messages to private strategies.

Key fields / operations:
sectionFull : Belief Ω → PrivateStrategy; measurability of (m, θ) ↦ action kernel; restriction to M.

Used by: definition2-qae-predicate, full payoff layer, restricted-agent-strategy-extends-to-full, full-restricted-Ustar-equivalence, main theorem package.

Modeling notes: The final Tier 1a and Tier 2 statements quantify over this object, not merely over the restricted menu-engine strategy.

agent-strategy-M

English name: Restricted agent strategy space on M

Informal type: Measurable strategies indexed only by messages in M, used internally by the menu engine.

Suggested Lean modeling: structure for measurable sections M → PrivateStrategy.

Key fields / operations:
sectionM : M → PrivateStrategy; profile map on M; induced restricted payoff objects; extension to full Σ.

Used by: menu-value equivalence, wstar-profile-map-implemented, sigma-star-robust-optimal.

Modeling notes: This is an auxiliary engine object. It is not the public strategy space of the theorem.

misaligned-adviser-kernel-space

English name: Misaligned adviser kernel space

Informal type: Borel Markov kernels β : M → Δ M mapping a source posterior to a distribution over reported messages.

Suggested Lean modeling: structure for measurable Markov kernels.

Key fields / operations:
β(dm | s); deterministic Dirac kernels; product measure τ ⊗ β; second marginal; support predicates; no absolute-continuity requirement with respect to τ.

Used by: misaligned-payoff, mixture-message-law, is-adversarial, exact and ε-adversaries, menu-Hall.

Modeling notes: Null-message dust is allowed, so do not impose β s ≪ τ.

private-payoff-functional

English name: Private-strategy payoff at a belief

Informal type: Expected payoff of a private strategy under a belief.

Suggested Lean modeling: definition.

Key fields / operations:
PrivatePayoff : PrivateStrategy → Belief Ω → ℝ;
IsBayesOptimal hatσ μ := ∀ hatσ', PrivatePayoff hatσ' μ ≤ PrivatePayoff hatσ μ.

Used by: Bayes-optimality-belief-correspondence-Bm, per-message-Bayes-optimality, definition2-qae-predicate.

Modeling notes: This is separate from the full robust payoff.

aligned-payoff

English name: Aligned payoff

Informal type: Payoff when the adviser is aligned and reports truthfully.

Suggested Lean modeling: two definitions, full and restricted, connected by bridge lemmas.

Key fields / operations:
AlignedPayoffFull σFull; AlignedPayoffM σM; profile form ∫_M s · wσ(s) τ(ds).

Used by: mixture-payoff, profile-payoff-decomposition-aligned, menu-value equivalence.

Modeling notes: This component is independent of any adversarial kernel.

misaligned-payoff

English name: Misaligned payoff against a kernel

Informal type: Payoff when the misaligned adviser uses kernel β.

Suggested Lean modeling: two definitions, full and restricted.

Key fields / operations:
MisalignedPayoffFull β σFull;
MisalignedPayoffM β σM;
profile form ∫_M ∫_M s · wσ(m) β(dm|s) τ(ds).

Used by: mixture-payoff, adversary-infimum-pointwise, exact-adversary-attainment.

Modeling notes: This is the misaligned component only, not the mixture payoff.

mixture-payoff

English name: Full mixture payoff against a fixed adversary

Informal type: Payoff against a specific misaligned kernel, including aligned and misaligned regimes.

Suggested Lean modeling: two definitions, full and restricted.

Key fields / operations:
MixturePayoffFull β σFull := α * AlignedPayoffFull σFull + (1 - α) * MisalignedPayoffFull β σFull;
MixturePayoffM β σM := α * AlignedPayoffM σM + (1 - α) * MisalignedPayoffM β σM.

Used by: robust-payoff, is-adversarial, epsilon-adversary-realization, exact-adversary-attainment, menu-Hall-support-implies-exact-adversary.

Modeling notes: All adversary-attainment statements compare this object to robust payoff and U_star.

robust-payoff

English name: Robust payoff of an agent strategy

Informal type: Worst-case full mixture payoff over misaligned kernels.

Suggested Lean modeling: two definitions, full and restricted.

Key fields / operations:
RobustPayoffFull σFull := ⨅ β, MixturePayoffFull β σFull;
RobustPayoffM σM := ⨅ β, MixturePayoffM β σM.

Used by: U-star, is-adversarial, sigma-star-robust-optimal, tier1a.

Modeling notes: The full object is the paper object. The restricted object is the menu-engine auxiliary object.

U-star

English name: Robust value

Informal type: Supremum of robust payoff over agent strategies.

Suggested Lean modeling: two definitions plus equivalence theorem.

Key fields / operations:
UStarFull := ⨆ σFull : AgentStrategyFull, RobustPayoffFull σFull;
UStarM := ⨆ σM : AgentStrategyM, RobustPayoffM σM;
menu equivalent ⨆ C : 𝒦(W), F C.

Used by: menu-value-equivalence, full-restricted-Ustar-equivalence, sigma-star-robust-optimal, main theorem package.

Modeling notes: The theorem package exposes UStarFull.

is-adversarial

English name: Adversarial kernel predicate

Informal type: Predicate saying a kernel attains the worst-case mixture payoff against a strategy.

Suggested Lean modeling: definition returning Prop.

Key fields / operations:
IsAdversarialFull β σFull := MixturePayoffFull β σFull = RobustPayoffFull σFull;
restricted analogue for engine proofs.

Used by: definition2-qae-predicate, exact-adversary-attainment, menu-Hall-support-implies-exact-adversary, tier2.

Modeling notes: This replaces ambiguous “adversarial against σ” prose.

mixture-message-law

English name: Mixture message marginal

Informal type: For a misaligned kernel β, the marginal law of observed messages under aligned truth-telling plus misaligned reporting.

Suggested Lean modeling: definition.

Key fields / operations:
q_β := α • τM + (1 - α) • (τ ⊗ β)_2;
domination α • τ ≤ q_β; restriction to dust sets;
PositiveQMass N κ := 0 < q_κ(N).

Used by: q-dominates-tau-when-alpha-pos, posterior-disintegration, definition2-qae-predicate, wta-no-free-dust.

Modeling notes: This is the underlying distribution for Definition 2 in infinite M.

posterior-disintegration

English name: Bayesian posterior after a message

Informal type: Regular conditional posterior over Ω after observing message m under the mixture law induced by β or by γα.

Suggested Lean modeling: definitions backed by disintegration theorem, with a.e. uniqueness.

Key fields / operations:
Pβ : AdviserKernel → M → Belief Ω;
Pγα : M → Belief Ω;
conditional source barycenter representation;
a.e. equality statements for chosen versions.

Used by: definition2-qae-predicate, menu-Hall-posterior-calibration-unpack, posterior-disintegration-menuHall-kernel-coincides, dust-conditional-sources-satisfy-cones.

Modeling notes: Since Ω is finite, posteriors can be represented coordinatewise by conditional expectations or barycenters.

definition2-qae-predicate

English name: Definition 2 q-a.e. robust rationalizability predicate

Informal type: Infinite-space reading of Definition 2 as a predicate on (β, σFull).

Suggested Lean modeling: definition returning Prop.

Key fields / operations:
Definition2QAEPredicate β σFull := IsAdversarialFull β σFull ∧ ∀ᵐ m ∂q_β, IsBayesOptimal (σFull.sectionFull (inclM m)) (Pβ β m).

Used by: tier2-qae-robust-rationalizability-under-menu-Hall.

Modeling notes: The a.e. measure is q_β, not τ and not literal all messages.

payoff-profile-set-W

English name: Payoff-profile set

Informal type: Set W ⊆ Ω → ℝ of state-contingent payoff profiles implementable by private strategies.

Suggested Lean modeling: definition plus compact convex subtype.

Key fields / operations:
w(ω) = E[u(a,ω,θ) | ω]; membership witness private strategy; compactness; convexity; nonemptiness.

Used by: payoff-profile-set-compact-convex, profile-realization-setup, compact-menu-space, WTA vertices.

Modeling notes: Compactness is imported through profile geometry, not derived solely from simplex compactness.

profile-realization-setup

English name: Profile realization setup

Informal type: Bundled geometric theorem and hypotheses for the private-kernel space and profile map.

Suggested Lean modeling: structure.

Key fields / operations:
topology and measurable structure on PrivateStrategy; compactness; Φ : PrivateStrategy → W; continuity of Φ; surjectivity; nonempty compact fibers; measurable/Borel fiber structure.

Used by: payoff-profile-set-compact-convex, profile-map-has-borel-right-inverse, borel-profile-map-implemented-by-agent-strategy.

Modeling notes: This replaces scattered implicit compactness and selection assumptions.

agent-profile-map

English name: Agent strategy profile map

Informal type: For a restricted strategy, the measurable map wσ : M → W.

Suggested Lean modeling: definition.

Key fields / operations:
profileMap σM m : Ω → ℝ; membership in W; measurability; payoff identity s · profileMap σM m.

Used by: payoff decompositions, adversary-infimum-pointwise, menu-value equivalence.

Modeling notes: This is the finite-dimensional bridge from strategies to menu geometry.

profile-realization-map

English name: Profile realization right inverse

Informal type: A Borel map R : W → PrivateStrategy selecting a private strategy realizing each payoff profile.

Suggested Lean modeling: theorem-provided definition or local witness.

Key fields / operations:
R; Measurable R; Φ (R w) = w; implementation of Borel maps M → W.

Used by: profile-map-has-borel-right-inverse, borel-profile-map-implemented-by-agent-strategy, wstar-profile-map-implemented.

Modeling notes: Split the existence of R from its use.

compact-menu-space

English name: Compact menu space

Informal type: 𝒦(W), the nonempty compact subsets of W with Hausdorff metric.

Suggested Lean modeling: subtype of nonempty compact sets.

Key fields / operations:
membership w ∈ C; nonemptiness; compactness; Hausdorff distance; hyperspace topology.

Used by: compact-menu-space-compact, menu-functional-F, optimal-menu-exists.

Modeling notes: Menus are nonempty because maxima and minima are used.

menu-functional-F

English name: Menu value functional

Informal type: Functional on compact menus:
F(C) = ∫_M [α max_{w∈C} s·w + (1-α) min_{w∈C} s·w] τ(ds).

Suggested Lean modeling: definition.

Key fields / operations:
maxPayoff C s; minPayoff C s; integral over τ; Hausdorff continuity.

Used by: menu-value equivalence, optimal-menu-exists, closure-pruning-value-preservation, wstar-payoff-equals-F-Cdagger.

Modeling notes: Finite-dimensional Ω makes s · w continuous.

optimal-menu-Cstar

English name: Optimal compact menu

Informal type: A maximizer C* ∈ 𝒦(W) of F.

Suggested Lean modeling: theorem-local existential witness or bundled structure.

Key fields / operations:
Cstar_nonempty; Cstar_compact; ∀ C, F C ≤ F Cstar; F Cstar = UStarM.

Used by: aligned-best-labeling-selection, closure-pruning-value-preservation, sigma-star-robust-optimal.

Modeling notes: Prefer theorem-local packaging to global choice unless downstream code wants named data.

aligned-best-labeling-wstar

English name: Aligned-best labeling

Informal type: A Borel selector w* : M → C* satisfying w*(m) ∈ argmax_{w∈C*} m·w.

Suggested Lean modeling: definition plus selection theorem witness.

Key fields / operations:
wstar; measurability; membership in C*; argmax equality.

Used by: closure-pruning-value-preservation, wstar-profile-map-implemented, contact correspondences.

Modeling notes: Fix this representative before defining C†.

pruned-menu-Cdagger

English name: Closure-pruned menu

Informal type: C† := closure (w*(M)), a compact subset of C*.

Suggested Lean modeling: definition as compact-menu object.

Key fields / operations:
Cdagger ⊆ Cstar; density of w*(M) in Cdagger; value preservation F Cdagger = F Cstar; rowwise minima over Cdagger.

Used by: closure-pruning-value-preservation, Geps-nonempty, exact-adversary-attainment, wstar-payoff-equals-F-Cdagger.

Modeling notes: This is the realized menu behind σ*.

rowwise-contact-correspondence-G

English name: Rowwise exact contact set

Informal type: For source posterior s, the messages whose selected labels attain the C† rowwise minimum.

Suggested Lean modeling: set-valued correspondence.

Key fields / operations:
G(s) := {m : s · w*(m) = min_{z∈C†} s · z}; graph; support condition.

Used by: exact-contact-selector-unpack, kernel-supported-on-G, menu-Hall-assumption, exact-adversary-attainment.

Modeling notes: Exact-contact asserts measurable selection from this correspondence. Menu-Hall asserts a kernel supported on it.

epsilon-contact-correspondence-Geps

English name: ε-contact correspondence

Informal type: For ε > 0, messages whose selected labels are within ε of the rowwise minimum.

Suggested Lean modeling: set-valued correspondence.

Key fields / operations:
Gε(s) := {m : s·w*(m) ≤ min_{z∈C†} s·z + ε}; nonempty sections; graph measurability; total Borel selector.

Used by: Geps-nonempty, Geps-graph-measurable, Geps-selector-exists, epsilon-adversary-realization.

Modeling notes: The selector target is total Borel: ∀ s : M, mε s ∈ Gε s.

exact-contact-assumption

English name: Exact-contact assumption

Informal type: For τ-a.e. source posterior s, G(s) is nonempty and admits a measurable selector.

Suggested Lean modeling: proposition or structure.

Key fields / operations:
existence of mstar : M → M; measurability; ∀ᵐ s ∂τ, mstar s ∈ G(s).

Used by: exact-contact-selector-unpack, exact-adversary-attainment, tier1b, tier2.

Modeling notes: This is a Tier 1b and Tier 2 hypothesis, not standing.

exact-adversary-kernel

English name: Deterministic exact-contact adversary

Informal type: Kernel induced by an exact-contact selector: β*(·|s) = δ_{m*(s)}.

Suggested Lean modeling: definition.

Key fields / operations:
deterministic Dirac kernel; measurability; rowwise exact minimization.

Used by: exact-adversary-attainment.

Modeling notes: This deterministic kernel is not the Tier 2 adversary unless it equals the menu-Hall kernel.

kernel-supported-on-G

English name: Kernel support on exact contact

Informal type: Predicate saying a kernel sends τ-a.e. source posterior only to exact-contact messages.

Suggested Lean modeling: definition returning Prop.

Key fields / operations:
KernelSupportedOnG κ := ∀ᵐ s ∂τ, κ(s)(G(s)) = 1.

Used by: menu-Hall-assumption, menu-Hall-support-implies-exact-adversary, menuHall-adversary-kernel-identity.

Modeling notes: This names the support component of menu-Hall.

menuHall-adversary-kernel

English name: Menu-Hall adversary kernel

Informal type: The specific kernel κ supplied by menu-Hall and chosen as the Tier 2 adversary.

Suggested Lean modeling: local object or projection from MenuHall.

Key fields / operations:
κ : AdviserKernel; βstar := κ; q_κ; γα; support on G; posterior calibration.

Used by: menuHall-adversary-kernel-identity, menu-Hall-support-implies-exact-adversary, posterior-disintegration-menuHall-kernel-coincides, tier2.

Modeling notes: This prevents replacing κ with the deterministic exact-contact selector.

menu-Hall-assumption

English name: Menu-Hall calibration assumption

Informal type: There exists a kernel κ supported on G(s) τ-a.e. such that the mixture posterior lies in the Bayes-optimality belief set B(m) q-a.e.

Suggested Lean modeling: structure or proposition with explicit kernel.

Key fields / operations:
κ; KernelSupportedOnG κ; γα := α(id,id)#τ + (1-α) τ⊗κ; q := (γα)_2; posterior Pγα; calibration ∀ᵐ m ∂q, Pγα m ∈ B(m).

Used by: menuHall-adversary-kernel-identity, menu-Hall-posterior-calibration-unpack, posterior-disintegration-menuHall-kernel-coincides, tier2.

Modeling notes: The kernel may mix over G(s). It is set-valued, not deterministic.

mixture-coupling-gamma-alpha

English name: Mixture source-message coupling

Informal type: The joint law of source posterior and reported message under aligned truth-telling plus the menu-Hall kernel.

Suggested Lean modeling: definition.

Key fields / operations:
γα := α • (id,id)#τ + (1 - α) • (τ ⊗ κ); first marginal; second marginal q; equality q = q_κ.

Used by: menuHall-adversary-kernel-identity, menu-Hall-posterior-calibration-unpack, posterior-disintegration-menuHall-kernel-coincides.

Modeling notes: This is the canonical posterior law for Tier 2.

Bayes-optimality-belief-correspondence-Bm

English name: Bayes-optimality belief correspondence

Informal type: For each message m, the set of beliefs under which σ*’s private strategy at m is Bayes-optimal.

Suggested Lean modeling: definition M → Set (Belief Ω).

Key fields / operations:
B(m) := {μ : IsBayesOptimal (σstar.sectionFull (inclM m)) μ}; closed convex values when used in support-function form.

Used by: menu-Hall-assumption, menu-Hall-posterior-calibration-unpack, per-message-Bayes-optimality, support-function lemmas.

Modeling notes: The main Tier 2 proof uses membership only.

support-function-Hall-form

English name: Support-function form of menu-Hall

Informal type: Inequality formulation of posterior calibration using support functions of B(m).

Suggested Lean modeling: proposition.

Key fields / operations:
support function h_{B(m)}(φ); measurable-event quantification; continuous affine tests φ : Belief Ω → ℝ; integrated inequality.

Used by: support-function-pointwise-membership-equivalence, support-function-integrated-Hall-equivalence.

Modeling notes: Auxiliary, quarantined from the main positive Tier 2 DAG.

WTA-ternary-algebra

English name: Winner-takes-all ternary finite-coordinate algebra

Informal type: Specialized finite-coordinate WTA algebra with three states, three pure payoff vertices, symmetric prior, and coordinate cones.

Suggested Lean modeling: structure or namespace over Fin 3.

Key fields / operations:
Ω = Fin 3; prior μ0 = (1/3,1/3,1/3); WTA payoff vertices; coordinate algebra; finite sums; simplex identities.

Used by: WTA-payoff-dot-product-identity, WTA-rowwise-minimizer-and-Bayes-cone-identification, wta-cone-intersection, halfspace witness.

Modeling notes: This object does not contain atomlessness.

AtomlessTauSharpness

English name: Atomlessness hypothesis for WTA sharpness

Informal type: The separate hypothesis that τ is atomless in the WTA sharpness setting.

Suggested Lean modeling: proposition or structure field used only by no-free-dust.

Key fields / operations:
Atomless τ; hence τ({μ0}) = 0.

Used by: wta-no-free-dust.

Modeling notes: Not used by wta-cone-intersection.

WTA-payoff-vertices-and-mixed-labels

English name: WTA vertex profiles and mixed labels

Informal type: Vertex payoff profiles v_i and mixed profile labels w_λ.

Suggested Lean modeling: definitions over Fin 3.

Key fields / operations:
v_i(j) = 1 if i = j, -1 otherwise;
wλ := ∑ i, λ i • v_i;
support I = {i : λ i > 0};
dot-product identity.

Used by: WTA-payoff-dot-product-identity, WTA-rowwise-minimizer-and-Bayes-cone-identification, null-dust-data.

Modeling notes: Use finite sums over Fin 3.

WTA-cones-Kminus-and-B

English name: WTA rowwise-minimizer and Bayes-optimality cones

Informal type: For nonempty I ⊆ Fin 3, rowwise minimizer cone K_I^- and Bayes cone B_I.

Suggested Lean modeling: definitions.

Key fields / operations:
Kminus I := {s : ∀ i∈I, ∀ k, s i ≤ s k};
Bcone I := {p : ∀ i∈I, ∀ k, p i ≥ p k}.

Used by: WTA-rowwise-minimizer-and-Bayes-cone-identification, wta-cone-intersection, dust cone lemmas.

Modeling notes: All quantification is finite.

null-dust-data

English name: Null-message dust data on subtype N

Informal type: A τ-null Borel dust set N, a subtype-indexed dust labeling, and measurable mixed-label encoding.

Suggested Lean modeling: structure.

Key fields / operations:
N : Set M; MeasurableSet N; τ(N)=0;
NDust := {m : M // m ∈ N};
wN : NDust → W;
λ : NDust → (Fin 3 → ℝ);
I : NDust → Set (Fin 3) with I m = {i | 0 < λ m i};
λ_measurable;
λ_nonneg : ∀ m i, 0 ≤ λ m i;
λ_sum_one : ∀ m, ∑ i, λ m i = 1;
λ_support_nonempty : ∀ m, (I m).Nonempty;
λ_support_positive : ∀ m i, i ∈ I m ↔ 0 < λ m i;
wN_eq_mixed_label : ∀ m : NDust, wN m = wλ (λ m).

Used by: rowwise-support, Bayes-cone-calibration, adversarial-flow-disintegration-data, wta-no-free-dust.

Modeling notes: wN, λ, and I are never used on all of M; they live on the subtype NDust.

dust-subtype-qN

English name: Dust subtype measure

Informal type: The dust message marginal q_N as a finite measure on the subtype NDust.

Suggested Lean modeling: definition attached to null-dust-data and the dust flow.

Key fields / operations:
NDust := {m : M // m ∈ N};
qN : Measure NDust;
coercion map NDust → M;
support on N is definitional by subtype.

Used by: Bayes-cone-calibration, adversarial-flow-disintegration-data, dust-disintegration-over-subtype-N, qN-supported-on-N.

Modeling notes: This is the chosen Lean shape for dust typing. No arbitrary labels outside N.

rowwise-support

English name: WTA rowwise-support predicate over dust subtype

Informal type: Predicate saying the dust-restricted adversarial flow is supported on rowwise-minimizer cones for the actual dust label.

Suggested Lean modeling: definition returning Prop.

Key fields / operations:
Over m : NDust, require the source coordinate s to lie in Kminus (I m) for the ν_N-a.e. pair (s,m), equivalently the restricted kernel sends dust messages only to labels whose cones contain the source.

Used by: dust-rowwise-support-implies-cone-support, wta-no-free-dust.

Modeling notes: The predicate is subtype-disciplined. It never refers to I m for m : M without a proof m ∈ N.

Bayes-cone-calibration

English name: WTA Bayes-cone calibration over dust subtype

Informal type: Predicate saying dust conditional source barycenters lie in the Bayes-optimality cone corresponding to the dust label support.

Suggested Lean modeling: definition returning Prop.

Key fields / operations:
BayesConeCalibration dust flow := ∀ᵐ m : NDust ∂qN, barycenter (ρ m) ∈ Bcone (I m).

Used by: dust-Bayes-calibration-gives-cone-barycenter, dust-conditional-sources-satisfy-cones, wta-no-free-dust.

Modeling notes: The measure domain is NDust, not all of M.

adversarial-flow-disintegration-data

English name: Adversarial flow and dust disintegration over subtype N

Informal type: The measure flow induced by ν(ds,dm)=τ(ds)κ(dm|s), restricted to dust and disintegrated over dust messages.

Suggested Lean modeling: structure produced by disintegration theorem.

Key fields / operations:
ν : Measure (Belief Ω × M);
νN : Measure (Belief Ω × NDust);
qN := secondMarginal νN;
ρ : NDust → ProbabilityMeasure (Belief Ω);
disintegration identity νN(A × E) = ∫_{m∈E} ρ m A ∂qN;
conditional barycenter bar_s(m).

Used by: dust-disintegration-over-subtype-N, dust cone lemmas, dust-positive-mass-forces-mu0-atom.

Modeling notes: This is the measure-theoretic engine of no-free-dust.

positive-q-mass

English name: Positive mixture dust mass

Informal type: Predicate saying the mixture message law assigns positive mass to the dust set.

Suggested Lean modeling: definition returning Prop.

Key fields / operations:
PositiveQMass N κ := 0 < q_κ(N).

Used by: positive-dust-mass-impossible-when-alpha-one, dust-positive-mass-forces-mu0-atom, wta-no-free-dust.

Modeling notes: This names condition (a) of the no-free-dust theorem.

halfspace-witness-trust-region

English name: Halfspace trust-region witness

Informal type: The WTA halfspace T := {μ : μ(0) ≤ 0.4} used in the menu-engine witness.

Suggested Lean modeling: definition.

Key fields / operations:
membership predicate; witness beliefs (0.4,0.3,0.3), (0.1,0.8,0.1), (0.1,0.1,0.8); plurality labels.

Used by: halfspace-contains-beliefs-inducing-all-vertices, halfspace-witness-menu-engine-artifact.

Modeling notes: The boundary number 0.4 is not formalized as a primitive obstruction.

effective-menu-equivalence-data

English name: Effective menu equivalence data

Informal type: Data showing the halfspace trust region induces the full WTA vertex menu and the same behavior as the full simplex.

Suggested Lean modeling: structure or theorem-local data.

Key fields / operations:
induced menu; full vertex set {v0,v1,v2}; plurality continuation; off-T projection behavior; behavioral equivalence relation.

Used by: halfspace-induced-effective-menu-equals-full-vertices, halfspace-behavior-equivalent-to-full-simplex.

Modeling notes: Formalize behavioral equivalence, not rhetoric about primitive counterexamples.

halfspace-behavioral-equivalence-predicates

English name: Halfspace behavioral equivalence predicates

Informal type: Precise predicates replacing prose “menu-engine artefact.”

Suggested Lean modeling: definitions returning Prop.

Key fields / operations:
ContainsBeliefsForAllVertices T;
InducedEffectiveMenu T = {v0,v1,v2};
BehaviorEquivalent T FullSimplexTrustRegion;
optional documentation wrapper MenuEngineArtifact T.

Used by: halfspace witness lemmas and theorem package.

Modeling notes: Do not formalize “not a primitive counterexample” unless the project already has that predicate.

Main Theorem
robust-trust-infinite-extension-v8-package

Statement (English, precise):
Under the standing Robust Trust hypotheses, posterior-law consistency, and profile-realization setup, the infinite-M, infinite-Θ extension is a package of six theorem declarations.

tier1a-value-optimality-and-epsilon-adversary:
There exists a full paper strategy σ* : AgentStrategyFull such that
RobustPayoffFull σ* = UStarFull.
For every ε > 0, there exists a Borel adversary kernel βε : AdviserKernel with
MixturePayoffFull βε σ* ≤ RobustPayoffFull σ* + (1 - α) * ε,
hence MixturePayoffFull βε σ* ≤ UStarFull + ε.
The menu engine may construct an internal restricted strategy first, but the theorem exposes the full Σ strategy.

tier1b-exact-adversary-under-exact-contact:
Under exact-contact, there exists a deterministic exact-contact kernel β* such that
IsAdversarialFull β* σ* and
MixturePayoffFull β* σ* = RobustPayoffFull σ* = UStarFull.

tier2-qae-robust-rationalizability-under-menu-Hall:
Under exact-contact and menu-Hall, choose the Tier 2 adversary to be the menu-Hall kernel κ. Set βstar := κ. Then
q = q_κ = (γα)_2,
IsAdversarialFull κ σ*,
MixturePayoffFull κ σ* = UStarFull,
and Definition2QAEPredicate κ σ*.
If α > 0, the Bayes-optimality part also holds τ-a.e. by domination.

wta-cone-intersection:
In the WTA ternary algebra, for every nonempty support I, if a Borel probability ρ is supported on K_I^- and has barycenter in B_I, then ρ = δ_{μ0}.

wta-no-free-dust:
In WTA ternary, under the separate atomlessness hypothesis on τ, no τ-null dust set, subtype-indexed dust label, and adversarial kernel can simultaneously have positive mixture dust mass, rowwise minimizer support, and Bayes-cone calibration.

halfspace-witness-menu-engine-artifact:
In the WTA halfspace witness, the precise behavioral facts hold: T contains beliefs inducing all three WTA vertices, its induced effective menu is exactly {v0,v1,v2}, and the resulting continuation behavior is equivalent to the full-simplex trust region.

Type signature (informal):
For model : RobustTrustModel, with PosteriorLawConsistency model and ProfileRealizationSetup model, produce a full strategy σstar : AgentStrategyFull satisfying Tier 1a. Add ExactContact for Tier 1b. Add MenuHall κ for Tier 2, with βstar = κ. Separately, for WTA-ternary-algebra, prove cone intersection; with AtomlessTauSharpness, prove no-free-dust; prove the halfspace behavioral package.

Depends on (objects):
[robust-trust-model, posterior-law-consistency-field, message-restriction-bridge, agent-strategy-full, agent-strategy-M, aligned-payoff, misaligned-payoff, mixture-payoff, robust-payoff, U-star, is-adversarial, mixture-message-law, posterior-disintegration, definition2-qae-predicate, payoff-profile-set-W, profile-realization-setup, compact-menu-space, menu-functional-F, optimal-menu-Cstar, aligned-best-labeling-wstar, pruned-menu-Cdagger, rowwise-contact-correspondence-G, exact-contact-assumption, kernel-supported-on-G, menuHall-adversary-kernel, menu-Hall-assumption, mixture-coupling-gamma-alpha, Bayes-optimality-belief-correspondence-Bm, WTA-ternary-algebra, AtomlessTauSharpness, WTA-payoff-vertices-and-mixed-labels, WTA-cones-Kminus-and-B, null-dust-data, dust-subtype-qN, rowwise-support, Bayes-cone-calibration, adversarial-flow-disintegration-data, positive-q-mass, halfspace-witness-trust-region, halfspace-behavioral-equivalence-predicates]

Depends on (lemmas):
[tier1a-value-optimality-and-epsilon-adversary, tier1b-exact-adversary-under-exact-contact, tier2-qae-robust-rationalizability-under-menu-Hall, wta-cone-intersection, wta-no-free-dust, halfspace-witness-menu-engine-artifact]

Depends on (external):
[profile-geometry-import, krn-borel-right-inverse, fubini-tonelli-kernel-integrals, kernel-infimum-epsilon-selection, hyperspace-blaschke-compactness, geps-borel-selector-upgrade, standard-borel-disintegration, bayes-posterior-as-conditional-barycenter, nonnegative-integral-zero, atomless-singleton-null]

Lemmas
posterior-law-barycenter-identities

Statement:
The posterior-law consistency field implies that τ has barycenter μ0 and that, for each state coordinate ω, the finite measure of state-ω sources is represented by s(ω) τ(ds). Consequently, the posterior after observing adviser posterior s is s, τ-a.e.

Type signature:
From posterior-law-consistency-field, prove barycenter τ = μ0 and coordinate finite-measure identities μ0(ω) • π ω = (fun s => s ω) • τ.

Depends on (objects):
[robust-trust-model, finite-state-and-belief-simplex, posterior-law-consistency-field]

Depends on (lemmas):
[]

Depends on (external):
[bayes-posterior-as-conditional-barycenter]

Notes:
Project glue, not simplex algebra alone.

strategy-restriction-to-M

Statement:
Every full agent strategy on Δ Ω × Θ restricts to a measurable restricted agent strategy on M × Θ.

Type signature:
σFull : AgentStrategyFull → ∃ σM : AgentStrategyM, ∀ m : M, σM.sectionM m = σFull.sectionFull (inclM m).

Depends on (objects):
[agent-strategy-full, agent-strategy-M, message-support-M, message-restriction-bridge]

Depends on (lemmas):
[]

Depends on (external):
[]

Notes:
Pure subtype restriction and measurability.

restricted-agent-strategy-extends-to-full

Statement:
Every restricted Borel agent strategy on M extends to a full paper strategy on Δ Ω by arbitrary/default completion outside M.

Type signature:
∀ σM : AgentStrategyM, ∃ σFull : AgentStrategyFull, restrict σFull = σM.

Depends on (objects):
[agent-strategy-full, agent-strategy-M, message-support-M, message-restriction-bridge, private-strategy-space]

Depends on (lemmas):
[]

Depends on (external):
[]

Notes:
The extension uses the Borel set M and a default private strategy outside M.

outside-M-messages-irrelevant

Statement:
Values of a full agent strategy on messages outside M do not affect aligned payoff, misaligned payoff against M-supported adversaries, mixture payoff, or robust payoff after restriction.

Type signature:
If two full strategies agree on M, then all full payoff objects computed against kernels into M coincide.

Depends on (objects):
[agent-strategy-full, agent-strategy-M, message-support-M, message-restriction-bridge, aligned-payoff, misaligned-payoff, mixture-payoff, robust-payoff]

Depends on (lemmas):
[strategy-restriction-to-M]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
This prevents proving only a restricted-game theorem.

adversary-kernels-restrict-to-M

Statement:
For the robust objective, the infimum over full-message adversarial kernels equals the infimum over Borel kernels into M.

Type signature:
⨅ βFull, MixturePayoffFullRaw βFull σFull = ⨅ βM, MixturePayoffFull βM σFull, and the right-hand side equals the restricted payoff of restrict σFull.

Depends on (objects):
[message-support-M, message-restriction-bridge, misaligned-adviser-kernel-space, mixture-payoff, robust-payoff]

Depends on (lemmas):
[outside-M-messages-irrelevant]

Depends on (external):
[kernel-infimum-epsilon-selection]

Notes:
Formalizes the paper’s without-loss restriction of adversarial messages to M.

full-restricted-Ustar-equivalence

Statement:
The full paper robust value and the restricted menu-engine robust value are equal, and restricted payoff optimality lifts to full payoff optimality under any full extension.

Type signature:
UStarFull = UStarM, and if restrict σFull = σM, then RobustPayoffFull σFull = RobustPayoffM σM.

Depends on (objects):
[agent-strategy-full, agent-strategy-M, robust-payoff, U-star, message-restriction-bridge]

Depends on (lemmas):
[strategy-restriction-to-M, restricted-agent-strategy-extends-to-full, outside-M-messages-irrelevant, adversary-kernels-restrict-to-M]

Depends on (external):
[]

Notes:
This is the reverse strategy lift seam required for Tier 1a to expose σ* ∈ Σ.

q-dominates-tau-when-alpha-pos

Statement:
For every adversarial kernel β, if α > 0, then q_β dominates τ: every q_β-null set is τ-null. Hence any q_β-a.e. predicate holds τ-a.e.

Type signature:
0 < α → (∀ᵐ m ∂q_β, P m) → (∀ᵐ m ∂τ, P m).

Depends on (objects):
[mixture-message-law]

Depends on (lemmas):
[]

Depends on (external):
[]

Notes:
This is the domination lemma for the q-a.e. reading of Definition 2.

payoff-profile-set-compact-convex

Statement:
The payoff-profile set W is a compact convex subset of Ω → ℝ, and the profile map from private strategies is surjective onto W.

Type signature:
IsCompact W ∧ Convex ℝ W ∧ Surjective Φ.

Depends on (objects):
[robust-trust-model, type-action-payoff-primitives, private-strategy-space, payoff-profile-set-W, profile-realization-setup]

Depends on (lemmas):
[]

Depends on (external):
[profile-geometry-import]

Notes:
Specialist imported profile geometry.

profile-map-has-borel-right-inverse

Statement:
The continuous surjective profile map Φ : PrivateStrategy → W with compact nonempty fibers admits a Borel right inverse R : W → PrivateStrategy.

Type signature:
∃ R, Measurable R ∧ ∀ w ∈ W, Φ (R w) = w.

Depends on (objects):
[profile-realization-setup, profile-realization-map, payoff-profile-set-W]

Depends on (lemmas):
[payoff-profile-set-compact-convex]

Depends on (external):
[krn-borel-right-inverse]

Notes:
First half of the profile-realization split.

borel-profile-map-implemented-by-agent-strategy

Statement:
Every Borel map wMap : M → W is implemented by a measurable restricted agent strategy using the Borel right inverse R.

Type signature:
Measurable wMap → ∃ σM : AgentStrategyM, profileMap σM = wMap.

Depends on (objects):
[profile-realization-map, agent-strategy-M, agent-profile-map, message-support-M]

Depends on (lemmas):
[profile-map-has-borel-right-inverse]

Depends on (external):
[]

Notes:
Second half of the profile-realization split.

profile-payoff-decomposition-aligned

Statement:
For any restricted agent strategy σM with profile map wσ, the aligned payoff equals ∫_M s · wσ(s) τ(ds).

Type signature:
AlignedPayoffM σM = ∫ s, dot s (profileMap σM s) ∂τ.

Depends on (objects):
[aligned-payoff, agent-profile-map, agent-strategy-M, posterior-law-consistency-field]

Depends on (lemmas):
[posterior-law-barycenter-identities]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
Uses conditional independence and posterior-law consistency.

profile-payoff-decomposition-misaligned

Statement:
For any restricted agent strategy σM and adversary kernel β, the misaligned payoff equals ∫_M ∫_M s · wσ(m) β(dm|s) τ(ds).

Type signature:
MisalignedPayoffM β σM = ∫ s, ∫ m, dot s (profileMap σM m) ∂β s ∂τ.

Depends on (objects):
[misaligned-payoff, misaligned-adviser-kernel-space, agent-profile-map, agent-strategy-M]

Depends on (lemmas):
[posterior-law-barycenter-identities]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
This isolates the misaligned-only component.

mixture-payoff-decomposition

Statement:
The full payoff against a fixed kernel decomposes as aligned profile integral plus misaligned profile integral with weights α and 1 - α.

Type signature:
MixturePayoffM β σM = α * AlignedPayoffM σM + (1 - α) * MisalignedPayoffM β σM, with profile identities substituted. Full analogue follows through restriction.

Depends on (objects):
[mixture-payoff, aligned-payoff, misaligned-payoff]

Depends on (lemmas):
[profile-payoff-decomposition-aligned, profile-payoff-decomposition-misaligned]

Depends on (external):
[]

Notes:
Payoff API root for adversary lemmas.

adversary-infimum-pointwise

Statement:
For any bounded measurable profile map w : M → W, the infimum of the misaligned profile integral over Borel kernels equals the integral of rowwise infima:
inf_β ∫∫ s·w(m) β(dm|s) τ(ds) = ∫ inf_m s·w(m) τ(ds).

Type signature:
For bounded measurable g(s,m)=s·w(m),
⨅ β, ∫∫ g s m ∂β s ∂τ = ∫ s, ⨅ m, g s m ∂τ.

Depends on (objects):
[misaligned-adviser-kernel-space, agent-profile-map, message-support-M]

Depends on (lemmas):
[profile-payoff-decomposition-misaligned]

Depends on (external):
[fubini-tonelli-kernel-integrals, kernel-infimum-epsilon-selection]

Notes:
Exact minimizers are not required. ε-selectors suffice.

strategy-value-le-menu-sup

Statement:
Every restricted agent strategy generates a compact menu closure Cσ := closure (range wσ) such that RobustPayoffM σ ≤ F(Cσ) ≤ sup_C F(C).

Type signature:
∀ σM, RobustPayoffM σM ≤ ⨆ C : 𝒦(W), F C.

Depends on (objects):
[robust-payoff, agent-profile-map, compact-menu-space, menu-functional-F]

Depends on (lemmas):
[mixture-payoff-decomposition, adversary-infimum-pointwise]

Depends on (external):
[measurable-maximum-and-argmax-selection]

Notes:
One direction of menu-value equivalence.

menu-value-le-strategy-sup

Statement:
For every nonempty compact menu C, an aligned-best Borel labeling into C can be realized by a restricted agent strategy σC with F(C) ≤ RobustPayoffM σC.

Type signature:
∀ C : 𝒦(W), F C ≤ UStarM.

Depends on (objects):
[compact-menu-space, menu-functional-F, profile-realization-map, robust-payoff, U-star]

Depends on (lemmas):
[borel-profile-map-implemented-by-agent-strategy, adversary-infimum-pointwise]

Depends on (external):
[measurable-maximum-and-argmax-selection]

Notes:
Other direction of menu-value equivalence.

menu-value-equivalence

Statement:
The restricted robust value equals the supremum of the menu functional over nonempty compact menus:
UStarM = ⨆ C : 𝒦(W), F C.

Type signature:
UStarM model = sSup {F C | C : 𝒦(W)}.

Depends on (objects):
[U-star, compact-menu-space, menu-functional-F]

Depends on (lemmas):
[strategy-value-le-menu-sup, menu-value-le-strategy-sup]

Depends on (external):
[]

Notes:
The full equality follows later from full-restricted-Ustar-equivalence.

compact-menu-space-compact

Statement:
If W is compact metric, then 𝒦(W) is compact under Hausdorff distance.

Type signature:
CompactSpace (NonemptyCompactSubsets W with HausdorffMetric).

Depends on (objects):
[payoff-profile-set-W, compact-menu-space]

Depends on (lemmas):
[payoff-profile-set-compact-convex]

Depends on (external):
[hyperspace-blaschke-compactness]

Notes:
Conservatively local unless Mathlib compact-set Hausdorff APIs are confirmed.

menu-extrema-Hausdorff-Lipschitz

Statement:
For each belief s, maps C ↦ max_{w∈C} s·w and C ↦ min_{w∈C} s·w are Lipschitz in Hausdorff distance.

Type signature:
|maxPayoff C s - maxPayoff D s| ≤ L * dH C D, and similarly for minima.

Depends on (objects):
[finite-state-and-belief-simplex, compact-menu-space, menu-functional-F]

Depends on (lemmas):
[]

Depends on (external):
[hausdorff-support-function-lipschitz]

Notes:
The source’s “1-Lipschitz” depends on norm convention.

menu-functional-continuity

Statement:
The menu functional F : 𝒦(W) → ℝ is continuous in Hausdorff distance.

Type signature:
Continuous F.

Depends on (objects):
[compact-menu-space, menu-functional-F]

Depends on (lemmas):
[menu-extrema-Hausdorff-Lipschitz]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
Boundedness gives integrability; Lipschitz extrema give continuity.

optimal-menu-exists

Statement:
The supremum of F over 𝒦(W) is attained by some compact menu C*.

Type signature:
∃ Cstar : 𝒦(W), ∀ C : 𝒦(W), F C ≤ F Cstar.

Depends on (objects):
[compact-menu-space, menu-functional-F, optimal-menu-Cstar]

Depends on (lemmas):
[compact-menu-space-compact, menu-functional-continuity]

Depends on (external):
[weierstrass-extreme-value]

Notes:
Menu existence.

aligned-best-labeling-selection

Statement:
For an optimal menu C*, there exists a Borel selector w* : M → C* such that w*(m) maximizes m·w over C*.

Type signature:
∃ wstar, Measurable wstar ∧ ∀ m, wstar m ∈ Cstar ∧ IsArgMax (fun w => dot m w) Cstar (wstar m).

Depends on (objects):
[message-support-M, optimal-menu-Cstar, aligned-best-labeling-wstar]

Depends on (lemmas):
[optimal-menu-exists]

Depends on (external):
[measurable-maximum-and-argmax-selection]

Notes:
The selector is fixed before defining C†.

closure-pruning-value-preservation

Statement:
Let C† := closure (w*(M)). Then C† ⊆ C* and F(C†) = F(C*) = UStarM.

Type signature:
For selected wstar, define Cdagger; prove subset and value equality.

Depends on (objects):
[aligned-best-labeling-wstar, pruned-menu-Cdagger, menu-functional-F, U-star]

Depends on (lemmas):
[menu-value-equivalence, optimal-menu-exists, aligned-best-labeling-selection]

Depends on (external):
[weierstrass-extreme-value]

Notes:
Aligned term unchanged; misaligned term weakly rises; optimality forces equality.

wstar-profile-map-implemented

Statement:
The selected labeling w* : M → C† ⊆ W is Borel and is implemented by a restricted agent strategy.

Type signature:
Measurable wstar → ∃ σM : AgentStrategyM, profileMap σM = wstar.

Depends on (objects):
[agent-strategy-M, profile-realization-map, aligned-best-labeling-wstar, pruned-menu-Cdagger, agent-profile-map]

Depends on (lemmas):
[borel-profile-map-implemented-by-agent-strategy, aligned-best-labeling-selection, closure-pruning-value-preservation]

Depends on (external):
[]

Notes:
First split of the old bundled sigma-star-realization-and-optimality.

wstar-payoff-equals-F-Cdagger

Statement:
For a restricted strategy implementing w*, the aligned payoff equals the integral of the rowwise maxima over C†, and the misaligned infimum equals the integral of the rowwise minima over C†. Hence the restricted robust payoff equals F(C†).

Type signature:
If profileMap σM = wstar, then
AlignedPayoffM σM = ∫ s, max_{w∈C†} dot s w ∂τ,
(⨅ β, MisalignedPayoffM β σM) = ∫ s, min_{z∈C†} dot s z ∂τ,
and RobustPayoffM σM = F Cdagger.

Depends on (objects):
[agent-strategy-M, aligned-payoff, misaligned-payoff, robust-payoff, menu-functional-F, pruned-menu-Cdagger]

Depends on (lemmas):
[profile-payoff-decomposition-aligned, profile-payoff-decomposition-misaligned, adversary-infimum-pointwise, closure-pruning-value-preservation]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
This makes the payoff identity visible rather than hiding it inside realization.

sigma-star-robust-optimal

Statement:
A full extension of the restricted strategy implementing w* attains the full paper robust value.

Type signature:
∃ σstarFull : AgentStrategyFull, RobustPayoffFull σstarFull = UStarFull ∧ restrict σstarFull = σstarM.

Depends on (objects):
[agent-strategy-full, agent-strategy-M, robust-payoff, U-star, message-restriction-bridge]

Depends on (lemmas):
[wstar-profile-map-implemented, wstar-payoff-equals-F-Cdagger, closure-pruning-value-preservation, menu-value-equivalence, restricted-agent-strategy-extends-to-full, full-restricted-Ustar-equivalence]

Depends on (external):
[]

Notes:
This is the full-Σ optimality lemma used by Tier 1a.

Geps-nonempty

Statement:
For every ε > 0 and every source posterior s, the ε-contact set Gε(s) is nonempty.

Type signature:
ε > 0 → ∀ s : M, (Gε ε s).Nonempty.

Depends on (objects):
[epsilon-contact-correspondence-Geps, pruned-menu-Cdagger, aligned-best-labeling-wstar]

Depends on (lemmas):
[closure-pruning-value-preservation]

Depends on (external):
[]

Notes:
Uses density of w*(M) in C† and continuity of dot products.

Geps-graph-measurable

Statement:
For each ε > 0, the graph {(s,m) : m ∈ Gε(s)} is Borel or has the stronger selectable regularity required by the Borel selector theorem.

Type signature:
ε > 0 → MeasurableSet {p : M × M | p.2 ∈ Gε ε p.1}.

Depends on (objects):
[epsilon-contact-correspondence-Geps, aligned-best-labeling-wstar, pruned-menu-Cdagger]

Depends on (lemmas):
[]

Depends on (external):
[]

Notes:
Separated from selector existence.

Geps-selector-exists

Statement:
For every ε > 0, there exists a total admissible Borel selector mε : M → M with mε(s) ∈ Gε(s) for every s.

Type signature:
ε > 0 → ∃ mε : M → M, Measurable mε ∧ ∀ s : M, mε s ∈ Gε ε s.

Depends on (objects):
[epsilon-contact-correspondence-Geps, misaligned-adviser-kernel-space]

Depends on (lemmas):
[Geps-nonempty, Geps-graph-measurable]

Depends on (external):
[jankov-von-neumann-universal-selection, geps-borel-selector-upgrade]

Notes:
The selected formal target is total Borel. JvN alone is not enough; the Borel upgrade is explicit.

epsilon-adversary-realization

Statement:
For every ε > 0, the deterministic kernel βε(·|s)=δ_{mε(s)} satisfies
MixturePayoffFull βε σ* ≤ RobustPayoffFull σ* + (1 - α) * ε, hence MixturePayoffFull βε σ* ≤ UStarFull + ε.

Type signature:
ε > 0 → ∃ βε : AdviserKernel, MixturePayoffFull βε σstar ≤ RobustPayoffFull σstar + (1 - α) * ε ∧ MixturePayoffFull βε σstar ≤ UStarFull + ε.

Depends on (objects):
[epsilon-contact-correspondence-Geps, misaligned-adviser-kernel-space, mixture-payoff, robust-payoff, U-star]

Depends on (lemmas):
[sigma-star-robust-optimal, Geps-selector-exists, mixture-payoff-decomposition, full-restricted-Ustar-equivalence]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
Restated with MixturePayoffFull, not an ambiguous payoff symbol.

exact-contact-selector-unpack

Statement:
Exact-contact gives a Borel selector m* : M → M such that m*(s) ∈ G(s) for τ-a.e. s.

Type signature:
ExactContact → ∃ mstar, Measurable mstar ∧ ∀ᵐ s ∂τ, mstar s ∈ G s.

Depends on (objects):
[exact-contact-assumption, rowwise-contact-correspondence-G]

Depends on (lemmas):
[]

Depends on (external):
[]

Notes:
Unpacking a hypothesis.

exact-adversary-attainment

Statement:
Under exact-contact, the deterministic kernel induced by the exact-contact selector is adversarial and attains the full mixture infimum:
MixturePayoffFull β* σ* = RobustPayoffFull σ* = UStarFull.

Type signature:
ExactContact → ∃ βstar, IsAdversarialFull βstar σstar ∧ MixturePayoffFull βstar σstar = RobustPayoffFull σstar ∧ RobustPayoffFull σstar = UStarFull.

Depends on (objects):
[exact-contact-assumption, exact-adversary-kernel, rowwise-contact-correspondence-G, mixture-payoff, robust-payoff, U-star, is-adversarial]

Depends on (lemmas):
[sigma-star-robust-optimal, exact-contact-selector-unpack, wstar-payoff-equals-F-Cdagger, closure-pruning-value-preservation, mixture-payoff-decomposition, full-restricted-Ustar-equivalence]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
Includes the equality chain required by the source theorem.

menuHall-adversary-kernel-identity

Statement:
Under menu-Hall, the Tier 2 adversary is the menu-Hall kernel κ, and the message marginal used in Definition 2 is exactly both q_κ and (γα)_2.

Type signature:
MenuHall κ → βstar = κ ∧ q = q_κ ∧ q = secondMarginal γα.

Depends on (objects):
[menuHall-adversary-kernel, menu-Hall-assumption, mixture-message-law, mixture-coupling-gamma-alpha]

Depends on (lemmas):
[]

Depends on (external):
[]

Notes:
This prevents accidental substitution of the deterministic exact-contact selector.

menu-Hall-posterior-calibration-unpack

Statement:
Under menu-Hall, the disintegration posterior induced by γα satisfies Pγα(m) ∈ B(m) for q-a.e. m.

Type signature:
MenuHall κ → ∀ᵐ m ∂q, Pγα m ∈ Bm m.

Depends on (objects):
[menu-Hall-assumption, mixture-coupling-gamma-alpha, posterior-disintegration, Bayes-optimality-belief-correspondence-Bm]

Depends on (lemmas):
[menuHall-adversary-kernel-identity]

Depends on (external):
[standard-borel-disintegration]

Notes:
Calibration half of menu-Hall.

menu-Hall-support-implies-exact-adversary

Statement:
If the menu-Hall kernel κ is supported on G(s), then κ is an exact adversary for σ* in the full mixture payoff sense, and its mixture payoff equals UStarFull.

Type signature:
KernelSupportedOnG κ → IsAdversarialFull κ σstar ∧ MixturePayoffFull κ σstar = UStarFull.

Depends on (objects):
[kernel-supported-on-G, menuHall-adversary-kernel, rowwise-contact-correspondence-G, mixture-payoff, robust-payoff, U-star, is-adversarial]

Depends on (lemmas):
[sigma-star-robust-optimal, wstar-payoff-equals-F-Cdagger, closure-pruning-value-preservation, mixture-payoff-decomposition, full-restricted-Ustar-equivalence]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
This is the Tier 2 adversary-attainment statement for κ.

per-message-Bayes-optimality

Statement:
Under exact-contact and menu-Hall, σ*’s private strategy is Bayes-optimal under Pγα(m) for q-a.e. m. If α > 0, it is also Bayes-optimal τ-a.e.

Type signature:
ExactContact → MenuHall κ → (∀ᵐ m ∂q, IsBayesOptimal (σstar.sectionFull (inclM m)) (Pγα m)) ∧ (0 < α → ∀ᵐ m ∂τ, IsBayesOptimal (σstar.sectionFull (inclM m)) (Pγα m)).

Depends on (objects):
[exact-contact-assumption, menu-Hall-assumption, Bayes-optimality-belief-correspondence-Bm, posterior-disintegration]

Depends on (lemmas):
[menu-Hall-posterior-calibration-unpack, q-dominates-tau-when-alpha-pos]

Depends on (external):
[]

Notes:
Exact-contact is retained to match the source theorem, though menu-Hall drives the membership step.

posterior-disintegration-menuHall-kernel-coincides

Statement:
For the menu-Hall kernel κ, the posterior object Pβ κ used by Definition2QAEPredicate is q_κ-a.e. equal to the posterior Pγα supplied by menu-Hall.

Type signature:
MenuHall κ → ∀ᵐ m ∂q_κ, Pβ κ m = Pγα m.

Depends on (objects):
[posterior-disintegration, menuHall-adversary-kernel, menu-Hall-assumption, mixture-message-law, mixture-coupling-gamma-alpha]

Depends on (lemmas):
[menuHall-adversary-kernel-identity, menu-Hall-posterior-calibration-unpack]

Depends on (external):
[standard-borel-disintegration]

Notes:
This is the load-bearing posterior identity between Definition 2 and menu-Hall. Alternatively, downstream formalization may define Pβ κ by the same coupling γα, making this definitional.

support-function-pointwise-membership-equivalence

Statement:
For closed convex nonempty values B(m), a belief p lies in B(m) iff every continuous affine functional is bounded above by the support function of B(m).

Type signature:
p ∈ B m ↔ ∀ φ, φ p ≤ h_{B(m)} φ.

Depends on (objects):
[Bayes-optimality-belief-correspondence-Bm, support-function-Hall-form]

Depends on (lemmas):
[]

Depends on (external):
[support-function-pointwise-separation]

Notes:
Auxiliary finite-dimensional convex analysis.

support-function-integrated-Hall-equivalence

Statement:
Under measurability, closed-convex, and nonempty-value hypotheses for B(m), posterior calibration Pγα(m) ∈ B(m) q-a.e. is equivalent to support-function Hall inequalities over measurable events and continuous affine tests.

Type signature:
PosteriorCalibration γα B q ↔ SupportFunctionHallInequalities γα B q.

Depends on (objects):
[support-function-Hall-form, mixture-coupling-gamma-alpha, Bayes-optimality-belief-correspondence-Bm]

Depends on (lemmas):
[support-function-pointwise-membership-equivalence]

Depends on (external):
[support-function-measurable-integrated-separation, bayes-posterior-as-conditional-barycenter]

Notes:
Auxiliary and outside the main positive Tier 2 DAG.

tier1a-value-optimality-and-epsilon-adversary

Statement:
Under standing hypotheses, there exists a full paper strategy σ* : AgentStrategyFull with RobustPayoffFull σ* = UStarFull. For every ε > 0, there exists a Borel kernel βε with MixturePayoffFull βε σ* ≤ UStarFull + ε.

Type signature:
∃ σstar : AgentStrategyFull, RobustPayoffFull σstar = UStarFull ∧ ∀ ε > 0, ∃ βε, MixturePayoffFull βε σstar ≤ UStarFull + ε.

Depends on (objects):
[robust-trust-model, profile-realization-setup, agent-strategy-full, mixture-payoff, robust-payoff, U-star]

Depends on (lemmas):
[menu-value-equivalence, optimal-menu-exists, aligned-best-labeling-selection, closure-pruning-value-preservation, wstar-profile-map-implemented, wstar-payoff-equals-F-Cdagger, restricted-agent-strategy-extends-to-full, full-restricted-Ustar-equivalence, sigma-star-robust-optimal, epsilon-adversary-realization]

Depends on (external):
[]

Notes:
First component theorem. The public witness is full Σ, not merely restricted.

tier1b-exact-adversary-under-exact-contact

Statement:
Under standing hypotheses plus exact-contact, there exists an exact adversarial kernel β* with MixturePayoffFull β* σ* = RobustPayoffFull σ* = UStarFull.

Type signature:
ExactContact → ∃ βstar, IsAdversarialFull βstar σstar ∧ MixturePayoffFull βstar σstar = UStarFull.

Depends on (objects):
[exact-contact-assumption, exact-adversary-kernel, agent-strategy-full, mixture-payoff, robust-payoff, U-star, is-adversarial]

Depends on (lemmas):
[tier1a-value-optimality-and-epsilon-adversary, exact-adversary-attainment]

Depends on (external):
[]

Notes:
Second component theorem.

tier2-qae-robust-rationalizability-under-menu-Hall

Statement:
Under standing hypotheses plus exact-contact and menu-Hall, choose βstar := κ, the menu-Hall kernel. Then q = qκ = (γα)_2, κ is adversarial against full σ*, MixturePayoffFull κ σ* = UStarFull, and Definition2QAEPredicate κ σ* holds. If α > 0, the Bayes-optimality condition also holds τ-a.e.

Type signature:
ExactContact → MenuHall κ → βstar = κ ∧ IsAdversarialFull κ σstar ∧ MixturePayoffFull κ σstar = UStarFull ∧ Definition2QAEPredicate κ σstar ∧ (0 < α → τAE_BayesOptimal).

Depends on (objects):
[exact-contact-assumption, menu-Hall-assumption, menuHall-adversary-kernel, agent-strategy-full, mixture-message-law, mixture-coupling-gamma-alpha, definition2-qae-predicate, is-adversarial]

Depends on (lemmas):
[menuHall-adversary-kernel-identity, menu-Hall-support-implies-exact-adversary, per-message-Bayes-optimality, posterior-disintegration-menuHall-kernel-coincides]

Depends on (external):
[]

Notes:
Third component theorem. The posterior identity is inserted before invoking Definition2QAEPredicate.

WTA-payoff-dot-product-identity

Statement:
In WTA ternary, for a mixed profile wλ = ∑ i, λ i • v_i, s · wλ = 2 * ∑ i, λ i * s_i - 1.

Type signature:
For λ : Fin 3 → ℝ, λ_i ≥ 0, ∑ λ_i = 1, prove the coordinate identity.

Depends on (objects):
[WTA-ternary-algebra, WTA-payoff-vertices-and-mixed-labels]

Depends on (lemmas):
[]

Depends on (external):
[]

Notes:
Finite coordinate algebra.

WTA-rowwise-minimizer-and-Bayes-cone-identification

Statement:
In WTA ternary, let I be nonempty and let λ satisfy support λ = I, positive weights exactly on I, and ∑ i, λ i = 1. Then the mixed label wλ is a rowwise minimizer exactly for source beliefs in K_I^-, and Bayes-optimal exactly for beliefs in B_I.

Type signature:
I.Nonempty → support λ = I → (∀ i∈I, 0 < λ i) → (∀ i∉I, λ i = 0) → ∑ λ = 1 → (RowwiseMinimizer s wλ ↔ s ∈ Kminus I) ∧ (BayesOptimalWTA p wλ ↔ p ∈ Bcone I).

Depends on (objects):
[WTA-ternary-algebra, WTA-payoff-vertices-and-mixed-labels, WTA-cones-Kminus-and-B]

Depends on (lemmas):
[WTA-payoff-dot-product-identity]

Depends on (external):
[finite-dimensional-simplex-compactness]

Notes:
Uses exact support and positive-weight hypotheses.

wta-cone-intersection

Statement:
For every nonempty I ⊆ Fin 3, if a Borel probability ρ on Δ Ω satisfies ρ(K_I^-)=1 and has barycenter in B_I, then ρ = δ_{μ0} where μ0=(1/3,1/3,1/3).

Type signature:
I.Nonempty → ρ(Kminus I)=1 → barycenter ρ ∈ Bcone I → ρ = dirac μ0.

Depends on (objects):
[WTA-ternary-algebra, WTA-cones-Kminus-and-B]

Depends on (lemmas):
[WTA-rowwise-minimizer-and-Bayes-cone-identification]

Depends on (external):
[nonnegative-integral-zero]

Notes:
No atomlessness dependency. This is purely finite-coordinate probability algebra.

dust-disintegration-over-subtype-N

Statement:
For ν(ds,dm)=τ(ds)κ(dm|s) and dust restriction over NDust, there exists a disintegration over the second marginal qN : Measure NDust, with conditional source laws ρ_m.

Type signature:
∃ ρ : NDust → ProbabilityMeasure (Belief Ω), ∀ A E, νN(A × E) = ∫ m in E, ρ m A ∂qN.

Depends on (objects):
[null-dust-data, dust-subtype-qN, adversarial-flow-disintegration-data]

Depends on (lemmas):
[]

Depends on (external):
[standard-borel-disintegration]

Notes:
First split of no-free-dust. The measure domain is the subtype NDust.

qN-supported-on-N

Statement:
The dust marginal qN is supported on the dust set by construction, since it is a measure on the subtype NDust.

Type signature:
For the coercion ι : NDust → M, (ι # qN) is supported on N; equivalently every m : NDust carries a proof m.val ∈ N.

Depends on (objects):
[dust-subtype-qN, null-dust-data]

Depends on (lemmas):
[dust-disintegration-over-subtype-N]

Depends on (external):
[]

Notes:
This eliminates repeated a.e. coercion goblins.

dust-rowwise-support-implies-cone-support

Statement:
If the dust flow satisfies rowwise-support, then for qN-a.e. dust message m : NDust, the conditional source law ρ_m is supported on Kminus (I m).

Type signature:
RowwiseSupport dust κ flow → ∀ᵐ m : NDust ∂qN, ρ m (Kminus (I m)) = 1.

Depends on (objects):
[rowwise-support, null-dust-data, adversarial-flow-disintegration-data, WTA-cones-Kminus-and-B]

Depends on (lemmas):
[dust-disintegration-over-subtype-N, qN-supported-on-N]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
Cone support is over m : NDust.

dust-Bayes-calibration-gives-cone-barycenter

Statement:
Bayes-cone calibration gives that for qN-a.e. dust message m : NDust, the barycenter of ρ_m lies in Bcone (I m).

Type signature:
BayesConeCalibration dust flow → ∀ᵐ m : NDust ∂qN, barycenter (ρ m) ∈ Bcone (I m).

Depends on (objects):
[Bayes-cone-calibration, null-dust-data, adversarial-flow-disintegration-data, WTA-cones-Kminus-and-B]

Depends on (lemmas):
[dust-disintegration-over-subtype-N]

Depends on (external):
[bayes-posterior-as-conditional-barycenter]

Notes:
Barycenter calibration is subtype-indexed.

dust-conditional-sources-satisfy-cones

Statement:
If rowwise-support and Bayes-cone calibration hold, then for qN-a.e. m : NDust, ρ_m(K_{I(m)}^-)=1 and barycenter(ρ_m) ∈ B_{I(m)}.

Type signature:
RowwiseSupport dust κ flow → BayesConeCalibration dust flow → ∀ᵐ m : NDust ∂qN, ρ m (Kminus (I m)) = 1 ∧ barycenter (ρ m) ∈ Bcone (I m).

Depends on (objects):
[rowwise-support, Bayes-cone-calibration, null-dust-data, adversarial-flow-disintegration-data, WTA-cones-Kminus-and-B]

Depends on (lemmas):
[dust-rowwise-support-implies-cone-support, dust-Bayes-calibration-gives-cone-barycenter, WTA-rowwise-minimizer-and-Bayes-cone-identification]

Depends on (external):
[]

Notes:
This is now a clean product of two subtype lemmas.

cone-intersection-applied-to-dust

Statement:
Under the cone conditions from dust disintegration, ρ_m = δ_{μ0} for qN-a.e. dust message m : NDust.

Type signature:
∀ᵐ m : NDust ∂qN, ρ m = dirac μ0.

Depends on (objects):
[adversarial-flow-disintegration-data, WTA-ternary-algebra]

Depends on (lemmas):
[dust-conditional-sources-satisfy-cones, wta-cone-intersection]

Depends on (external):
[]

Notes:
Applies cone intersection pointwise over the dust subtype.

positive-dust-mass-impossible-when-alpha-one

Statement:
If α = 1 and τ(N)=0, then no adversarial kernel can give positive mixture mass to the dust set N.

Type signature:
α = 1 → τ N = 0 → ¬ PositiveQMass N κ.

Depends on (objects):
[mixture-message-law, positive-q-mass, null-dust-data]

Depends on (lemmas):
[]

Depends on (external):
[]

Notes:
This is the explicit α = 1 branch of no-free-dust.

dust-positive-mass-forces-mu0-atom

Statement:
If dust has positive mixture message mass, τ(N)=0, and α < 1, then the dust disintegration plus ρ_m = δ_{μ0} forces positive ν-mass on {μ0} × N, hence positive τ-mass on {μ0}.

Type signature:
τ N = 0 → PositiveQMass N κ → α < 1 → (∀ᵐ m : NDust ∂qN, ρ m = dirac μ0) → 0 < τ({μ0}).

Depends on (objects):
[null-dust-data, dust-subtype-qN, adversarial-flow-disintegration-data, mixture-message-law, positive-q-mass, WTA-ternary-algebra]

Depends on (lemmas):
[cone-intersection-applied-to-dust]

Depends on (external):
[fubini-tonelli-kernel-integrals]

Notes:
This is only the α < 1 branch.

wta-no-free-dust

Statement:
Under atomless τ in WTA ternary, there do not exist τ-null dust data, a subtype-indexed Borel dust labeling, and an adversarial kernel satisfying positive mixture dust mass, rowwise support, and Bayes-cone calibration.

Type signature:
AtomlessTauSharpness → ¬ ∃ dust κ flow, TauNull dust.N ∧ PositiveQMass dust.N κ ∧ RowwiseSupport dust κ flow ∧ BayesConeCalibration dust flow.

Depends on (objects):
[WTA-ternary-algebra, AtomlessTauSharpness, null-dust-data, rowwise-support, Bayes-cone-calibration, adversarial-flow-disintegration-data, mixture-message-law, positive-q-mass]

Depends on (lemmas):
[dust-disintegration-over-subtype-N, dust-conditional-sources-satisfy-cones, cone-intersection-applied-to-dust, positive-dust-mass-impossible-when-alpha-one, dust-positive-mass-forces-mu0-atom]

Depends on (external):
[atomless-singleton-null]

Notes:
The proof splits on α = 1 ∨ α < 1. Atomlessness appears only here, not in wta-cone-intersection.

sharpness-corollary

Statement:
Taking I={0} in the cone intersection theorem recovers the pointwise v7 obstruction at t0=(0.4,0.3,0.3), and no-free-dust rules out repairing it with τ-null dust.

Type signature:
Specialized consequence for singleton support {0}.

Depends on (objects):
[WTA-ternary-algebra, AtomlessTauSharpness, WTA-cones-Kminus-and-B]

Depends on (lemmas):
[wta-cone-intersection, wta-no-free-dust]

Depends on (external):
[]

Notes:
Sharpness statement, not a positive-tier dependency.

halfspace-contains-beliefs-inducing-all-vertices

Statement:
The halfspace T={μ : μ(0)≤0.4} contains beliefs whose WTA plurality labels induce each of the three vertex profiles.

Type signature:
∃ μ0T μ1T μ2T ∈ T, Label μ0T = v0 ∧ Label μ1T = v1 ∧ Label μ2T = v2.

Depends on (objects):
[halfspace-witness-trust-region, WTA-ternary-algebra, WTA-payoff-vertices-and-mixed-labels, halfspace-behavioral-equivalence-predicates]

Depends on (lemmas):
[]

Depends on (external):
[]

Notes:
Coordinate checks using (0.4,0.3,0.3), (0.1,0.8,0.1), (0.1,0.1,0.8).

halfspace-induced-effective-menu-equals-full-vertices

Statement:
Any plurality-vertex continuation on the halfspace T induces the effective menu {v0,v1,v2}.

Type signature:
InducedEffectiveMenu T = {v0,v1,v2}.

Depends on (objects):
[effective-menu-equivalence-data, halfspace-behavioral-equivalence-predicates, WTA-payoff-vertices-and-mixed-labels]

Depends on (lemmas):
[halfspace-contains-beliefs-inducing-all-vertices]

Depends on (external):
[]

Notes:
Formalizes the menu piece of the classification.

halfspace-behavior-equivalent-to-full-simplex

Statement:
Since the induced in-T menu is already the full WTA vertex menu, the off-T projection/continuation behavior is the same as ordinary plurality over the full simplex.

Type signature:
BehaviorEquivalent T FullSimplexTrustRegion.

Depends on (objects):
[effective-menu-equivalence-data, halfspace-behavioral-equivalence-predicates, halfspace-witness-trust-region]

Depends on (lemmas):
[halfspace-induced-effective-menu-equals-full-vertices]

Depends on (external):
[]

Notes:
Avoids formalizing “not a primitive counterexample” as a rhetoric-flavored theorem.

halfspace-witness-menu-engine-artifact

Statement:
The halfspace witness satisfies the precise behavioral-equivalence package: it contains beliefs inducing all three vertices, its effective menu is the full vertex menu, and its behavior is equivalent to the full-simplex trust region.

Type signature:
ContainsBeliefsForAllVertices T ∧ InducedEffectiveMenu T = {v0,v1,v2} ∧ BehaviorEquivalent T FullSimplexTrustRegion.

Depends on (objects):
[halfspace-witness-trust-region, effective-menu-equivalence-data, halfspace-behavioral-equivalence-predicates]

Depends on (lemmas):
[halfspace-contains-beliefs-inducing-all-vertices, halfspace-induced-effective-menu-equals-full-vertices, halfspace-behavior-equivalent-to-full-simplex]

Depends on (external):
[]

Notes:
Sixth component theorem.

External Results Invoked
finite-dimensional-simplex-compactness

English name: Compact convex geometry of a finite-dimensional probability simplex

Statement used:
For finite Ω, Δ Ω is compact and convex; coordinate functions and dot products are continuous; continuous affine functions attain extrema on compact subsets.

Classification: MATHLIB_CANDIDATE

Why this classification:
Mathlib has finite-dimensional topology, convexity, compactness, and finite-sum APIs, though simplex glue may be needed.

measurable-maximum-and-argmax-selection

English name: Measurable maximum theorem and measurable argmax selection

Statement used:
A measurable compact-valued correspondence with continuous objective admits a measurable selector from the argmax correspondence.

Classification: NON_MATHLIB

Why this classification:
This is a specialist measurable-selection theorem, unlikely to be packaged directly in Mathlib.

profile-geometry-import

English name: Profile geometry theorem for private kernels

Statement used:
The private-kernel space has a compact standard-Borel topology; the profile map Φ is continuous and onto W; fibers are nonempty compact; W is compact convex.

Classification: NON_MATHLIB

Why this classification:
This is imported project geometry from the paper’s profile construction, not standard Mathlib convexity alone.

krn-borel-right-inverse

English name: Kuratowski-Ryll-Nardzewski Borel right inverse theorem

Statement used:
A continuous map from a compact standard-Borel space onto W, with nonempty compact fibers, admits a Borel right inverse.

Classification: NON_MATHLIB

Why this classification:
Specialist measurable-selection theorem.

fubini-tonelli-kernel-integrals

English name: Fubini/Tonelli and kernel integration identities

Statement used:
Iterated integration against Markov kernels is valid and expected payoffs can be rearranged over states, types, actions, messages, and kernels.

Classification: MATHLIB_CANDIDATE

Why this classification:
Mathlib has substantial measure-theory infrastructure, although local Markov-kernel wrappers may be needed.

kernel-infimum-epsilon-selection

English name: Rowwise infimum over Markov kernels via ε-selectors

Statement used:
The infimum over measurable kernels of ∫∫ g(s,m) β(dm|s) τ(ds) equals ∫ inf_m g(s,m) τ(ds) for bounded measurable g, using measurable ε-minimizing selectors.

Classification: NON_MATHLIB

Why this classification:
Combines measurable selection and kernel optimization in a domain-specific packaged theorem.

hyperspace-blaschke-compactness

English name: Blaschke compactness for nonempty compact subsets

Statement used:
The hyperspace of nonempty compact subsets of a compact metric space is compact under Hausdorff distance.

Classification: NON_MATHLIB

Why this classification:
This may become Mathlib-or-local glue, but until compact-set Hausdorff APIs are confirmed it should be stubbed locally.

hausdorff-support-function-lipschitz

English name: Hausdorff Lipschitz continuity of support extrema

Statement used:
Maxima and minima of a bounded linear functional over compact sets vary Lipschitz-continuously with Hausdorff distance.

Classification: MATHLIB_CANDIDATE

Why this classification:
Elementary metric and finite-dimensional linear analysis.

weierstrass-extreme-value

English name: Extreme value theorem on compact spaces

Statement used:
A continuous real-valued function on a compact space attains maximum and minimum.

Classification: MATHLIB_CANDIDATE

Why this classification:
Standard Mathlib theorem.

jankov-von-neumann-universal-selection

English name: Jankov-von Neumann universally measurable selection theorem

Statement used:
An analytic or Borel graph with nonempty sections in standard Borel spaces admits a universally measurable selector.

Classification: NON_MATHLIB

Why this classification:
Specialist descriptive-set result, and it does not by itself give a Borel selector.

geps-borel-selector-upgrade

English name: Borel selector theorem for the ε-contact correspondence

Statement used:
The specific Gε correspondence has enough strengthened regularity to admit a total admissible Borel selector mε : M → M with mε(s) ∈ Gε(s) for every s.

Classification: NON_MATHLIB

Why this classification:
This is the exact patch beyond ordinary JvN and should be explicitly audited.

standard-borel-disintegration

English name: Disintegration theorem for standard Borel spaces

Statement used:
A finite measure on a product of standard Borel spaces admits regular conditional probabilities over a marginal.

Classification: MATHLIB_CANDIDATE

Why this classification:
Flagged as Mathlib-or-partial-import. Mathlib 4 appears to have standard-Borel disintegration infrastructure, including Mathlib.Probability.Kernel.Disintegration.StandardBorel; final import status is for dependency audit.

bayes-posterior-as-conditional-barycenter

English name: Bayesian posterior as conditional barycenter

Statement used:
For finite Ω, the posterior over states after a message equals the barycenter of the conditional distribution of source posteriors given that message.

Classification: NON_MATHLIB

Why this classification:
Project glue connecting the source-posterior process to Bayesian posteriors, even though finite-coordinate algebra follows after disintegration.

support-function-pointwise-separation

English name: Pointwise support-function characterization of closed convex membership

Statement used:
In finite dimension, p ∈ C for a closed convex set C iff all continuous affine functionals at p are bounded by the support function of C.

Classification: MATHLIB_CANDIDATE

Why this classification:
Finite-dimensional separation and convexity are plausible Mathlib material.

support-function-measurable-integrated-separation

English name: Measurable integrated support-function Hall equivalence

Statement used:
The q-a.e. posterior membership condition for a measurable closed-convex correspondence is equivalent to integrated support-function inequalities over measurable events.

Classification: NON_MATHLIB

Why this classification:
The measurable-correspondence and integrated inequality version is specialist.

nonnegative-integral-zero

English name: Nonnegative function with nonpositive expectation vanishes a.e.

Statement used:
If X ≥ 0 a.e. and ∫ X dρ ≤ 0, then X=0 a.e.

Classification: MATHLIB_CANDIDATE

Why this classification:
Standard measure-theory lemma.

atomless-singleton-null

English name: Atomless measures assign zero mass to singletons

Statement used:
Under atomless τ, τ({μ0})=0; this contradicts positive mass forced by dust calibration.

Classification: MATHLIB_CANDIDATE

Why this classification:
Standard measure-theory result.

Implicit Assumptions Surfaced

No unresolved implicit-assumption items remain. The following previously implicit premises are explicit object fields, theorem hypotheses, or named lemmas in the DAG:

Nonemptiness of A, Θ, M, W, and 𝒦(W) is represented in type-action-payoff-primitives, message-support-M, payoff-profile-set-W, and compact-menu-space.

α ∈ [0,1] is a field of robust-trust-model; the τ-a.e. upgrade separately requires 0 < α.

The α = 1 dust branch is explicit in positive-dust-mass-impossible-when-alpha-one; the α < 1 branch is explicit in dust-positive-mass-forces-mu0-atom.

All strategy, profile, and kernel maps carry Borel measurability as fields of their objects or conclusions of selection lemmas.

M is a Borel, compact, standard-Borel support subspace through message-support-M.

Bayes-plausibility/posterior-law consistency is explicit in posterior-law-consistency-field.

The compact standard-Borel topology on private kernels, continuity of Φ, compact nonempty fibers, and surjectivity onto W are bundled in profile-realization-setup.

The ε-contact selector target is total Borel in Geps-selector-exists; JvN plus the Borel upgrade are named externals.

Misaligned kernels are not assumed absolutely continuous with respect to τ.

Regular conditional posteriors are a.e. objects, with the Tier 2 identification handled by posterior-disintegration-menuHall-kernel-coincides.

Support-function Hall requires its own closed-convex, nonempty-value, and measurability hypotheses and is kept auxiliary.

Dust labels live on the subtype NDust; wN, λ, and I are not partial functions on all of M.

Atomlessness of τ is separated into AtomlessTauSharpness and used only in wta-no-free-dust.

The aligned-best selector w* is fixed before defining C†.

The equality between rowwise infimum over w*(M) and minimum over C† is carried by closure-pruning and continuity lemmas.

The deterministic exact-contact adversary and the menu-Hall kernel κ are distinct objects; Tier 2 explicitly chooses κ.

Decomposition Notes

The pass-3 DAG keeps the pass-2 fixes and patches the four remaining load-bearing seams.

First, the full/restricted strategy seam is closed. The menu engine still runs over M, but restricted-agent-strategy-extends-to-full and full-restricted-Ustar-equivalence lift the result back to a full paper strategy σ* : AgentStrategyFull. The main theorem and Tier 1a no longer expose a merely restricted strategy.

Second, the Tier 2 posterior seam is closed. posterior-disintegration-menuHall-kernel-coincides connects the posterior used inside Definition2QAEPredicate κ σ* to the Pγα posterior supplied by menu-Hall.

Third, the WTA sharpness environment is split. WTA-ternary-algebra contains only finite-coordinate WTA algebra. AtomlessTauSharpness is a separate hypothesis used only by wta-no-free-dust. Consequently wta-cone-intersection has no atomlessness dependency.

Fourth, dust labels are subtype-disciplined. NDust := {m : M // m ∈ N} is the domain of wN, λ, and I; qN is a measure on NDust; rowwise support, Bayes-cone calibration, disintegration, and cone conclusions are all stated over m : NDust.

The old bundled sigma-star-realization-and-optimality is split into wstar-profile-map-implemented, wstar-payoff-equals-F-Cdagger, and sigma-star-robust-optimal. The payoff equality at C† is now a visible load-bearing lemma.

The old dust cone lemma is split into dust-disintegration-over-subtype-N, dust-rowwise-support-implies-cone-support, dust-Bayes-calibration-gives-cone-barycenter, and dust-conditional-sources-satisfy-cones. This avoids repeated a.e. coercions.

standard-borel-disintegration is reclassified as MATHLIB_CANDIDATE, flagged as Mathlib-or-partial-import for dependency audit.

The support-function Hall equivalence remains auxiliary and outside the main positive Tier 2 DAG.

Show more

========
ROLE: assistant (id=6bbeaf55-399a-4207-a70c-ce132690122f)
========
meaning_check
total_items: 70
matches: 62
weakened: 6
strengthened: 2
vacuous_risk: 0
wrong: 0

Inventory count note: the briefing says “9 inlined INVENTORY stubs,” but the Lean file contains 10 theorem-level inventory signatures because the support-function external is split into a pointwise/a.e. theorem and an integrated theorem. I audited the 10 Lean theorem signatures.

Per-Item Audit
Inventory stubs
measurable_argmax_selector

English statement: “A measurable compact-valued correspondence with continuous objective admits a measurable selector from the argmax correspondence.”

Lean signature: hΓ_meas, nonempty compact sections, measurable f, continuous-on-section f imply ∃ sel, Measurable sel ∧ ∀ x, sel x ∈ Γ x ∧ IsMaxOn ....

Assessment: STRENGTHENED

Witness for the assessment: take X with an arbitrary non-countably-generated measurable structure and Y = [0,1], Γ x = {0}. The Lean theorem applies without any StandardBorelSpace X or countable-generation hypothesis. The usual measurable maximum/KRN-style English theorem does not.

Mismatch category: missing descriptive-set/measurable-space regularity hypotheses.

Suggested fix: add the intended standard-Borel or countably-generated hypotheses, or rename this as a stronger project axiom.

profile_geometry_import

English statement: “The private-kernel space has a compact standard-Borel topology; the profile map Φ is continuous and onto W; fibers are nonempty compact; W is compact convex.”

Lean signature: for abstract compact PrivateStrategy and continuous Φ, plus an explicit convex-realization hypothesis, conclude IsCompact W ∧ Convex ℝ W ∧ compact nonempty fibers over W.

Assessment: WEAKENED

Witness for the assessment: a primitive Robust Trust private-kernel model satisfying the paper’s payoff assumptions but not already packaged with hconvex_realization satisfies the English import target, while the Lean theorem cannot be applied. Lean proves an abstract consequence after the key profile-geometry work has already been assumed.

Mismatch category: project-geometry import collapsed into an abstract sufficient-condition lemma.

Suggested fix: either update the English to say “abstract profile-geometry consequence,” or strengthen the Lean stub to import the actual private-kernel profile construction.

krn_borel_right_inverse

English statement: “A continuous map from a compact standard-Borel space onto W, with nonempty compact fibers, admits a Borel right inverse.”

Lean signature: Continuous Φ, Function.Surjective Φ, compact nonempty fibers imply ∃ R : Y → X, Measurable R ∧ ∀ y, Φ (R y) = y.

Assessment: MATCHES

Witness for the assessment: no separating witness; for arbitrary y, the Lean conclusion is exactly the right-inverse equality and measurability promised in English.

Mismatch category: none.

Suggested fix: none.

kernel_infimum_epsilon_selection

English statement: “The infimum over measurable kernels of ∫∫ g(s,m) β(dm|s) τ(ds) equals ∫ inf_m g(s,m) τ(ds) for bounded measurable g, using measurable ε-minimizing selectors.”

Lean signature: bounded measurable g, measurable rowwise infimum imply ε-upper selectors and the universal lower bound for every Markov kernel.

Assessment: MATCHES

Witness for the assessment: no separating witness; the two Lean inequalities are exactly the two halves of the infimum equality.

Mismatch category: none.

Suggested fix: none.

hausdorff_support_function_lipschitz

English statement: “Maxima and minima of a bounded linear functional over compact sets vary Lipschitz-continuously with Hausdorff distance.”

Lean signature: for ℓ : E →L[ℝ] ℝ, ∃ L ≥ 0 such that support suprema differ by at most L * dist C D.

Assessment: MATCHES

Witness for the assessment: no separating witness; minima follow by applying the same statement to -ℓ.

Mismatch category: none.

Suggested fix: none.

jankov_von_neumann_universal_selection

English statement: “An analytic or Borel graph with nonempty sections in standard Borel spaces admits a universally measurable selector.”

Lean signature: analytic G ⊆ X × Y, nonempty sections imply ∃ f, UniversallyMeasurable f ∧ ∀ x, (x,f x) ∈ G.

Assessment: MATCHES

Witness for the assessment: no separating witness; the selector property and universal measurability are exactly the promised output.

Mismatch category: none.

Suggested fix: none.

geps_borel_selector_upgrade

English statement: “The specific Gε correspondence has enough strengthened regularity to admit a total admissible Borel selector.”

Lean signature: ε > 0, nonempty sections, GepsRegularity imply ∃ mε, Measurable mε ∧ ∀ s, mε s ∈ Gε ε s.

Assessment: MATCHES

Witness for the assessment: no separating witness; total Borel selection is exactly present.

Mismatch category: none.

Suggested fix: none.

bayes_posterior_as_conditional_barycenter

English statement: “For finite Ω, the posterior over states after a message equals the barycenter of the conditional distribution of source posteriors given that message.”

Lean signature: posterior consistency, message kernel, marginal q, disintegration ρ, and RN posterior definition imply ∀ᵐ m ∂q, ∀ ω, P m ω = ∫ s, coord s ω ∂ρ m.

Assessment: MATCHES

Witness for the assessment: no separating witness; the Lean statement uses the actual joint law τ.compProd χ and its reversed disintegration.

Mismatch category: none.

Suggested fix: none.

support_function_ae_pointwise_separation

English statement: “In finite dimension, p ∈ C for a closed convex set C iff all continuous affine functionals at p are bounded by the support function of C.”

Lean signature: for measurable P : M → Ω → ℝ and measurable closed convex nonempty bounded B, ∀ᵐ P m ∈ B m ↔ ∀ᵐ ∀ ℓ, ℓ(P m) ≤ sSup (ℓ '' B m).

Assessment: MATCHES

Witness for the assessment: no separating witness at the a.e. level; this inventory item is explicitly named “A.e. pointwise version” in Lean.

Mismatch category: none.

Suggested fix: none.

support_function_integrated_separation

English statement: “The q-a.e. posterior membership condition is equivalent to integrated support-function inequalities over measurable events.”

Lean signature: for every measurable positive-mass event E, membership under q.restrict E is equivalent to all integrated support-function inequalities on E.

Assessment: MATCHES

Witness for the assessment: no separating witness; the eventwise formulation is the local form of the Hall equivalence.

Mismatch category: none.

Suggested fix: none.

RobustTrustV8 lemmas
posterior_law_barycenter_identities

English statement: “The posterior-law consistency field implies that τ has barycenter μ0 and that, for each state coordinate ω, the finite measure of state-ω sources is represented by s(ω) τ(ds). Consequently, the posterior after observing adviser posterior s is s, τ-a.e.”

Lean signature: PosteriorLawConsistency model → beliefBarycenter model.τ = model.μ0 ∧ coordinate_measure_identity ∧ τ-a.e. posteriorAfterAdviser s = s.

Assessment: MATCHES

Witness for the assessment: no separating witness; all three fields are unpacked directly from PosteriorLawConsistency.

Mismatch category: none.

Suggested fix: none.

strategy_restriction_to_M

English statement: “Every full agent strategy on Δ Ω × Θ restricts to a measurable restricted agent strategy on M × Θ.”

Lean signature: σFull : AgentStrategyFull model → ∃ σM : AgentStrategyM model, ∀ m, σM.sectionM m = σFull.sectionFull (model.inclM m).

Assessment: MATCHES

Witness for the assessment: no separating witness; the displayed equality is the restriction map.

Mismatch category: none.

Suggested fix: none.

restricted_agent_strategy_extends_to_full

English statement: “Every restricted Borel agent strategy on M extends to a full paper strategy on Δ Ω by arbitrary/default completion outside M.”

Lean signature: with MessageRestrictionBridge, ∀ σM, ∃ σFull, ∀ m, σFull.sectionFull (inclM m) = σM.sectionM m.

Assessment: MATCHES

Witness for the assessment: no separating witness; this is the reverse lift seam and the conclusion is full AgentStrategyFull.

Mismatch category: none.

Suggested fix: none.

outside_M_messages_irrelevant

English statement: “Values of a full agent strategy on messages outside M do not affect aligned payoff, misaligned payoff against M-supported adversaries, mixture payoff, or robust payoff after restriction.”

Lean signature: if two full strategies agree on inclM m for every m : M, then aligned, misaligned, mixture, and robust payoffs agree.

Assessment: MATCHES

Witness for the assessment: no separating witness; the Lean hypotheses and four payoff equalities are exactly the English statement.

Mismatch category: none.

Suggested fix: none.

adversary_kernels_restrict_to_M

English statement: “For the robust objective, the infimum over full-message adversarial kernels equals the infimum over Borel kernels into M.”

Lean signature: sInf over FullMessageAdviserKernel raw payoffs equals sInf over AdviserKernel restricted payoffs, and RobustPayoffFull σFull = RobustPayoffM (restrictFullToM σFull).

Assessment: MATCHES

Witness for the assessment: no separating witness; full-message reports are compared directly to M-valued reports.

Mismatch category: none.

Suggested fix: none.

full_restricted_Ustar_equivalence

English statement: “The full paper robust value and the restricted menu-engine robust value are equal, and restricted payoff optimality lifts to full payoff optimality under any full extension.”

Lean signature: UStarFull = UStarM ∧ ∀ σFull σM, agreement on M → RobustPayoffFull σFull = RobustPayoffM σM.

Assessment: MATCHES

Witness for the assessment: no separating witness; the value equality and agreement-to-payoff equality are both present.

Mismatch category: none.

Suggested fix: none.

q_dominates_tau_when_alpha_pos

English statement: “For every adversarial kernel β, if α > 0, then qβ dominates τ: every qβ-null set is τ-null. Hence any qβ-a.e. predicate holds τ-a.e.”

Lean signature: 0 < model.α → (∀ᵐ m ∂MixtureMessageLaw model β, P m) → ∀ᵐ m ∂model.τM, P m.

Assessment: MATCHES

Witness for the assessment: no separating witness; the a.e. transfer is exactly the domination consequence.

Mismatch category: none.

Suggested fix: none.

payoff_profile_set_compact_convex

English statement: “The payoff-profile set W is a compact convex subset of Ω → ℝ, and the profile map from private strategies is surjective onto W.”

Lean signature: from ProfileRealizationSetup, conclude compactness, convexity, and ∀ w ∈ PayoffProfileSet, ∃ σ, profileOfPrivate σ = w.

Assessment: MATCHES

Witness for the assessment: no separating witness; the Lean conclusion is the compact-convex-surjective package.

Mismatch category: none.

Suggested fix: none.

profile_map_has_borel_right_inverse

English statement: “The continuous surjective profile map Φ : PrivateStrategy → W with compact nonempty fibers admits a Borel right inverse R : W → PrivateStrategy.”

Lean signature: ∃ R : ProfileInW model → model.PrivateStrategy, Measurable R ∧ ∀ w, profileOfPrivate (R w) = w.val.

Assessment: MATCHES

Witness for the assessment: no separating witness; the codomain is the subtype ProfileInW, i.e. exactly W.

Mismatch category: none.

Suggested fix: none.

borel_profile_map_implemented_by_agent_strategy

English statement: “Every Borel map wMap : M → W is implemented by a measurable restricted agent strategy using the Borel right inverse R.”

Lean signature: Measurable wMap → ∃ σM, ∀ m, profileMap model σM m = (wMap m).val.

Assessment: MATCHES

Witness for the assessment: no separating witness; implementation equality is pointwise.

Mismatch category: none.

Suggested fix: none.

profile_payoff_decomposition_aligned

English statement: “For any restricted agent strategy σM with profile map wσ, the aligned payoff equals ∫_M s · wσ(s) τ(ds).”

Lean signature: AlignedPayoffM model σM = ∫ s, beliefDot (inclM s) (profileMap model σM s) ∂τM.

Assessment: MATCHES

Witness for the assessment: no separating witness; the right-hand side is exactly the advertised profile integral.

Mismatch category: none.

Suggested fix: none.

profile_payoff_decomposition_misaligned

English statement: “For any restricted agent strategy σM and adversary kernel β, the misaligned payoff equals ∫_M ∫_M s · wσ(m) β(dm|s) τ(ds).”

Lean signature: MisalignedPayoffM model β σM = ∫ s, ∫ m, beliefDot (inclM s) (profileMap model σM m) ∂β.kernel s ∂τM.

Assessment: MATCHES

Witness for the assessment: no separating witness; the iterated integral has the right source/message roles.

Mismatch category: none.

Suggested fix: none.

mixture_payoff_decomposition

English statement: “The full payoff against a fixed kernel decomposes as aligned profile integral plus misaligned profile integral with weights α and 1 - α.”

Lean signature: both restricted and full mixture payoffs equal α * aligned + (1 - α) * misaligned.

Assessment: MATCHES

Witness for the assessment: no separating witness; both M and full layers are included.

Mismatch category: none.

Suggested fix: none.

adversary_infimum_pointwise

English statement: “For bounded measurable g(s,m)=s·w(m), infβ ∫∫ g s m β(dm|s) τ(ds) = ∫ inf_m g s m τ(ds).”

Lean signature: under measurability, boundedness, rowwise-inf measurability, and integrability, sInf over AdviserKernel integrals equals integral of rowwise sInf.

Assessment: MATCHES

Witness for the assessment: no separating witness; the Lean equality is the rowwise infimum identity.

Mismatch category: none.

Suggested fix: none.

strategy_value_le_menu_sup

English statement: “Every restricted agent strategy generates a compact menu closure Cσ := closure (range wσ) such that RobustPayoffM σ ≤ F(Cσ) ≤ sup_C F(C).”

Lean signature: ∀ σM, RobustPayoffM model σM ≤ sSup (Set.range (MenuFunctionalF model)).

Assessment: WEAKENED

Witness for the assessment: take a strategy whose profile range is not closed. English produces the specific compact menu Cσ = closure(range wσ) and the intermediate inequality through F(Cσ). Lean proves only the final upper bound and gives no Cσ witness.

Mismatch category: dropped witness/intermediate construction.

Suggested fix: either add ∃ Cσ : CompactMenu model, ... with the two inequalities, or revise the English to say this lemma only exports the final scalar inequality.

menu_value_le_strategy_sup

English statement: “For every nonempty compact menu C, an aligned-best Borel labeling into C can be realized by a restricted agent strategy σC with F(C) ≤ RobustPayoffM σC.”

Lean signature: ∀ C : CompactMenu model, MenuFunctionalF model C ≤ UStarM model.

Assessment: WEAKENED

Witness for the assessment: fix any compact menu C. English yields an implementing strategy σC. Lean only proves the scalar inequality F(C) ≤ UStarM; no strategy can be extracted.

Mismatch category: dropped implementing-strategy witness.

Suggested fix: add ∃ σC : AgentStrategyM model, MenuFunctionalF model C ≤ RobustPayoffM model σC, or revise the English statement.

menu_value_equivalence

English statement: “The restricted robust value equals the supremum of the menu functional over nonempty compact menus.”

Lean signature: UStarM model = sSup (Set.range (MenuFunctionalF model)).

Assessment: MATCHES

Witness for the assessment: no separating witness; exact equality is present.

Mismatch category: none.

Suggested fix: none.

compact_menu_space_compact

English statement: “If W is compact metric, then 𝒦(W) is compact under Hausdorff distance.”

Lean signature: CompactSpace (CompactMenu model).

Assessment: MATCHES

Witness for the assessment: no separating witness; CompactMenu is the Lean hyperspace of nonempty compact subsets of ProfileInW.

Mismatch category: none.

Suggested fix: none.

menu_extrema_Hausdorff_Lipschitz

English statement: “For each belief s, maps C ↦ max_{w∈C} s·w and C ↦ min_{w∈C} s·w are Lipschitz in Hausdorff distance.”

Lean signature: ∃ L ≥ 0, ∀ C D s, |maxPayoff C s - maxPayoff D s| ≤ L * dist C D ∧ |minPayoff C s - minPayoff D s| ≤ L * dist C D.

Assessment: MATCHES

Witness for the assessment: no separating witness; Lean gives the uniform-in-s version anticipated by the type signature.

Mismatch category: none.

Suggested fix: none.

menu_functional_continuity

English statement: “The menu functional F : 𝒦(W) → ℝ is continuous in Hausdorff distance.”

Lean signature: Continuous (MenuFunctionalF model).

Assessment: MATCHES

Witness for the assessment: no separating witness.

Mismatch category: none.

Suggested fix: none.

optimal_menu_exists

English statement: “The supremum of F over 𝒦(W) is attained by some compact menu C*.”

Lean signature: ∃ Cstar : CompactMenu model, ∀ C, MenuFunctionalF model C ≤ MenuFunctionalF model Cstar.

Assessment: MATCHES

Witness for the assessment: no separating witness; this is exactly maximum attainment.

Mismatch category: none.

Suggested fix: none.

aligned_best_labeling_selection

English statement: “For an optimal menu C*, there exists a Borel selector w* : M → C* such that w*(m) maximizes m·w over C*.”

Lean signature: ∃ wlabel : AlignedBestLabelingWstar model opt, with membership and IsMaxOn repeated in the conclusion.

Assessment: MATCHES

Witness for the assessment: no separating witness; measurability, membership, and argmax are all fields of AlignedBestLabelingWstar.

Mismatch category: none.

Suggested fix: none.

closure_pruning_value_preservation

English statement: “Let C† := closure (w*(M)). Then C† ⊆ C* and F(C†) = F(C*) = UStarM.”

Lean signature: ∃ cdagger : PrunedMenuCdagger model wlabel, plus subset, value preservation, and MenuFunctionalF opt.Cstar = UStarM.

Assessment: MATCHES

Witness for the assessment: no separating witness; PrunedMenuCdagger also carries closure-range and density data.

Mismatch category: none.

Suggested fix: none.

wstar_profile_map_implemented

English statement: “The selected labeling w* : M → C† ⊆ W is Borel and is implemented by a restricted agent strategy.”

Lean signature: ∃ σM : AgentStrategyM model, ∀ m, profileMap model σM m = (wlabel.wstar m).val.

Assessment: MATCHES

Witness for the assessment: no separating witness; the implementing equality is exact.

Mismatch category: none.

Suggested fix: none.

wstar_payoff_equals_F_Cdagger

English statement: “For a restricted strategy implementing w*, the aligned payoff equals the integral of the rowwise maxima over C†, and the misaligned infimum equals the integral of the rowwise minima over C†. Hence the restricted robust payoff equals F(C†).”

Lean signature: assumes hprofile; concludes the aligned identity, the misaligned sInf identity, and RobustPayoffM σM = MenuFunctionalF Cdagger.

Assessment: MATCHES

Witness for the assessment: no separating witness; all three payoff identities are present.

Mismatch category: none.

Suggested fix: none.

sigma_star_robust_optimal

English statement: “A full extension of the restricted strategy implementing w* attains the full paper robust value.”

Lean signature: for any σstarM : AgentStrategyM model, if RobustPayoffM σstarM = UStarM, then ∃ σstarFull : AgentStrategyFull, full robust optimality and agreement on M.

Assessment: STRENGTHENED

Witness for the assessment: take any restricted robust-optimal σM not known to come from the selected w*. The English lemma only promises a lift for the constructed w* strategy; Lean promises a full lift for this arbitrary restricted optimizer.

Mismatch category: stronger theorem than the English construction lemma.

Suggested fix: safe if intended. Otherwise, narrow the Lean lemma to the w*-implemented σM, or update the English to advertise the stronger general lift.

geps_nonempty

English statement: “For every ε > 0 and every source posterior s, the ε-contact set Gε(s) is nonempty.”

Lean signature: ε > 0 → ∀ s, (EpsilonContactGeps model cdagger ε s).Nonempty.

Assessment: MATCHES

Witness for the assessment: no separating witness.

Mismatch category: none.

Suggested fix: none.

geps_graph_measurable

English statement: “For each ε > 0, the graph {(s,m) : m ∈ Gε(s)} is Borel or has the stronger selectable regularity required by the Borel selector theorem.”

Lean signature: ε > 0 → MeasurableSet {p : M × M | p.2 ∈ EpsilonContactGeps ... p.1}.

Assessment: MATCHES

Witness for the assessment: no separating witness.

Mismatch category: none.

Suggested fix: none.

geps_selector_exists

English statement: “For every ε > 0, there exists a total admissible Borel selector mε : M → M with mε(s) ∈ Gε(s) for every s.”

Lean signature: ε > 0 → ∃ mε, Measurable mε ∧ ∀ s, mε s ∈ EpsilonContactGeps ... ε s.

Assessment: MATCHES

Witness for the assessment: no separating witness; totality is pointwise ∀ s.

Mismatch category: none.

Suggested fix: none.

epsilon_adversary_realization

English statement: “For every ε > 0, the deterministic kernel βε(·|s)=δ_{mε(s)} satisfies MixturePayoffFull βε σ* ≤ RobustPayoffFull σ* + (1 - α) * ε, hence MixturePayoffFull βε σ* ≤ UStarFull + ε.”

Lean signature: for any full robust-optimal σstar, ∀ ε > 0, ∃ βε : AdviserKernel model, the two payoff inequalities.

Assessment: WEAKENED

Witness for the assessment: in a two-message model with a non-Dirac Markov kernel satisfying the two inequalities, Lean accepts that kernel as a witness. English promises the stronger deterministic δ_{mε(s)} kernel coming from the ε-contact selector.

Mismatch category: dropped deterministic/contact-support content.

Suggested fix: add deterministic/support fields to the conclusion, or revise the English statement to “there exists a Borel adversary kernel.”

exact_contact_selector_unpack

English statement: “Exact-contact gives a Borel selector m* : M → M such that m*(s) ∈ G(s) for τ-a.e. s.”

Lean signature: from ec : ExactContact model σstar, conclude ∃ mstar, Measurable mstar ∧ τM-a.e. contact ∧ σstar implements wlabel.

Assessment: MATCHES

Witness for the assessment: no separating witness; Lean also unpacks the implementation field.

Mismatch category: none.

Suggested fix: none.

exact_adversary_attainment

English statement: “Under exact-contact, the deterministic kernel induced by the exact-contact selector is adversarial and attains the full mixture infimum: MixturePayoffFull β* σ* = RobustPayoffFull σ* = UStarFull.”

Lean signature: ∃ βstar, deterministic Dirac equality, support on G, adversariality, MixturePayoffFull = RobustPayoffFull, and RobustPayoffFull = UStarFull.

Assessment: MATCHES

Witness for the assessment: no separating witness; the deterministic kernel is explicit.

Mismatch category: none.

Suggested fix: none.

menuHall_adversary_kernel_identity

English statement: “Under menu-Hall, the Tier 2 adversary is the menu-Hall kernel κ, and the message marginal used in Definition 2 is exactly both qκ and (γα)₂.”

Lean signature: let βstar := κ; βstar = κ ∧ mh.q = MixtureMessageLaw model κ ∧ mh.q = (MixtureCouplingGammaAlpha model κ).map Prod.snd.

Assessment: MATCHES

Witness for the assessment: no separating witness; all three identities are present.

Mismatch category: none.

Suggested fix: none.

menu_hall_posterior_calibration_unpack

English statement: “Under menu-Hall, the disintegration posterior induced by γα satisfies Pγα(m) ∈ B(m) for q-a.e. m.”

Lean signature: ∀ᵐ m ∂mh.q, pd.Pγα κ m ∈ BayesOptimalityBeliefCorrespondenceBm model σstar m.

Assessment: MATCHES

Witness for the assessment: no separating witness; Pγα is indexed by κ.

Mismatch category: none.

Suggested fix: none.

menu_hall_support_implies_exact_adversary

English statement: “If the menu-Hall kernel κ is supported on G(s), then κ is an exact adversary for σ* in the full mixture payoff sense, and its mixture payoff equals UStarFull.”

Lean signature: KernelSupportedOnG ... κ → IsAdversarialFull model κ σstar ∧ MixturePayoffFull model κ σstar = UStarFull model.

Assessment: MATCHES

Witness for the assessment: no separating witness.

Mismatch category: none.

Suggested fix: none.

per_message_Bayes_optimality

English statement: “Under exact-contact and menu-Hall, σ*’s private strategy is Bayes-optimal under Pγα(m) for q-a.e. m. If α > 0, it is also Bayes-optimal τ-a.e.”

Lean signature: ∀ᵐ m ∂mh.q, IsBayesOptimal ... (pd.Pγα κ m) and 0 < α → ∀ᵐ m ∂τM, IsBayesOptimal ... (pd.Pγα κ m).

Assessment: MATCHES

Witness for the assessment: no separating witness; exact-contact remains in the hypothesis bundle and q-to-τ upgrade is conditional on 0 < α.

Mismatch category: none.

Suggested fix: none.

posterior_disintegration_menuHall_kernel_coincides

English statement: “For the menu-Hall kernel κ, the posterior object Pβ κ used by Definition2QAEPredicate is qκ-a.e. equal to the posterior Pγα supplied by menu-Hall.”

Lean signature: ∀ᵐ m ∂MixtureMessageLaw model κ, pd.Pβ κ m = pd.Pγα κ m.

Assessment: MATCHES

Witness for the assessment: no separating witness; the measure is exactly qκ.

Mismatch category: none.

Suggested fix: none.

support_function_pointwise_membership_equivalence

English statement: “For closed convex nonempty values B(m), a belief p lies in B(m) iff every continuous affine functional is bounded above by the support function of B(m).”

Lean signature: (∀ᵐ m ∂q, P m ∈ B m) ↔ (∀ᵐ m ∂q, ∀ ℓ, ℓ(P m) ≤ sSup (ℓ '' B m)).

Assessment: WEAKENED

Witness for the assessment: let M = {0,1}, q = δ0, B(0)=B(1)={0} in a one-dimensional profile space, P(0)=0, P(1)=1. Lean’s a.e. equivalence ignores message 1; the English pointwise statement fails at message 1.

Mismatch category: pointwise statement weakened to q-a.e. statement.

Suggested fix: rename the lemma to a.e. membership equivalence, or state the pointwise version separately.

support_function_integrated_Hall_equivalence

English statement: “Posterior calibration Pγα(m) ∈ B(m) q-a.e. is equivalent to support-function Hall inequalities over measurable events and continuous affine tests.”

Lean signature: PosteriorCalibrationProfiles model q B P ↔ SupportFunctionHallInequalities model q B P.

Assessment: MATCHES

Witness for the assessment: no separating witness; definitions are exactly the calibration and Hall sides.

Mismatch category: none.

Suggested fix: none.

tier1a_value_optimality_and_epsilon_adversary

English statement: “Under standing hypotheses, there exists a full paper strategy σ* : AgentStrategyFull with RobustPayoffFull σ* = UStarFull. For every ε > 0, there exists a Borel kernel βε with MixturePayoffFull βε σ* ≤ UStarFull + ε.”

Lean signature: ∃ σstar : AgentStrategyFull model, Tier1aResult model σstar.

Assessment: MATCHES

Witness for the assessment: no separating witness; Tier1aResult has full strategy, robust value equality, and both ε-adversary inequalities.

Mismatch category: none.

Suggested fix: none.

tier1b_exact_adversary_under_exact_contact

English statement: “Under standing hypotheses plus exact-contact, there exists an exact adversarial kernel β* with MixturePayoffFull β* σ* = RobustPayoffFull σ* = UStarFull.”

Lean signature: given full optimal σstar and ec, conclude Nonempty (Tier1bResult model σstar ec).

Assessment: MATCHES

Witness for the assessment: no separating witness; Tier1bResult contains deterministic support, adversariality, and value equality.

Mismatch category: none.

Suggested fix: none.

tier2_qae_robust_rationalizability_under_menu_Hall

English statement: “Under standing hypotheses plus exact-contact and menu-Hall, choose βstar := κ, the menu-Hall kernel. Then q = qκ = (γα)₂, κ is adversarial against full σ*, MixturePayoffFull κ σ* = UStarFull, and Definition2QAEPredicate κ σ* holds. If α > 0, the Bayes-optimality condition also holds τ-a.e.”

Lean signature: hypotheses include ec : ExactContact model σstar and mh : MenuHall model pd σstar ec κ; conclusion Tier2Result model pd σstar ec κ mh.

Assessment: MATCHES

Witness for the assessment: no separating witness; exact-contact and menu-Hall are both present, atomlessness is absent, and Tier2Result sets βstar := κ.

Mismatch category: none.

Suggested fix: none.

wta_payoff_dot_product_identity

English statement: “In WTA ternary, for a mixed profile wλ = ∑ i, λ i • v_i, s · wλ = 2 * ∑ i, λ i * s_i - 1.”

Lean signature: beliefDot s (WTA_mixedLabel lam) = 2 * (∑ i, lam i * s.val i) - 1.

Assessment: MATCHES

Witness for the assessment: no separating witness; the coordinate formula is exact.

Mismatch category: none.

Suggested fix: none.

wta_rowwise_minimizer_and_Bayes_cone_identification

English statement: “Let I be nonempty and let λ satisfy support λ = I, positive weights exactly on I, and ∑ i, λ i = 1. Then the mixed label wλ is a rowwise minimizer exactly for source beliefs in K_I^-, and Bayes-optimal exactly for beliefs in B_I.”

Lean signature: assumes I.Nonempty, WTASupport lam = I, positivity on I, nonnegativity, and sum one; concludes (WTARowwiseMinimizer ... (WTA_mixedLabel lam) ↔ s ∈ WTAKminus I) ∧ (WTABayesOptimalWTA ... (WTA_mixedLabel lam) ↔ p ∈ WTABcone I).

Assessment: MATCHES

Witness for the assessment: no separating witness; this is not a definitional echo because WTARowwiseMinimizer and WTABayesOptimalWTA quantify over real payoff comparisons to every pure WTA vertex.

Mismatch category: none.

Suggested fix: none.

wta_cone_intersection

English statement: “For every nonempty I ⊆ Fin 3, if a Borel probability ρ on Δ Ω satisfies ρ(K_I^-)=1 and has barycenter in B_I, then ρ = δ_{μ0} where μ0=(1/3,1/3,1/3).”

Lean signature: assumes WTASupport lam = I, ∀ i ∈ I, 0 < lam i, ∑ lam = 1, I.Nonempty, probability ρ, ρ (WTAKminus I)=1, and barycenter in WTABconeProfile I; concludes ρ = Measure.dirac wta.μ0.

Assessment: MATCHES

Witness for the assessment: no separating witness. The support condition is genuine equality WTASupport lam = I, hence iff after extensionality, and strict positivity on I is an explicit hypothesis. Non-vacuity witness: for any nonempty I, take lam i = 1 / |I| on I and 0 off I.

Mismatch category: none.

Suggested fix: none.

dust_disintegration_over_subtype_N

English statement: “For ν(ds,dm)=τ(ds)κ(dm|s) and dust restriction over NDust, there exists a disintegration over the second marginal qN : Measure NDust, with conditional source laws ρ_m.”

Lean signature: for an already given flow : AdversarialFlowDisintegrationData wta dust, conclude flow.νN.map (fun p => (p.2,p.1)) = flow.qN.compProd flow.ρ.

Assessment: WEAKENED

Witness for the assessment: take any standard-Borel product measure νN over WTABelief × NDust. English promises existence of a conditional kernel ρ. Lean cannot be invoked until a flow object already containing ρ and the disintegration identity has been supplied.

Mismatch category: existence theorem turned into field-unpacking theorem.

Suggested fix: either change the lemma to construct ρ and flow, or revise the English to “unpack the bundled dust-flow disintegration identity.”

qN_supported_on_N

English statement: “The dust marginal qN is supported on the dust set by construction, since it is a measure on the subtype NDust.”

Lean signature: ∀ᵐ m ∂flow.qN, (m.val : WTABelief) ∈ dust.N.

Assessment: MATCHES

Witness for the assessment: no separating witness; for every m : NDust dust, the proof m.property already gives membership in dust.N.

Mismatch category: none.

Suggested fix: none.

dust_rowwise_support_implies_cone_support

English statement: “If the dust flow satisfies rowwise-support, then for qN-a.e. dust message m : NDust, the conditional source law ρ_m is supported on Kminus (I m).”

Lean signature: RowwiseSupport wta dust flow → ∀ᵐ m ∂flow.qN, flow.ρ m (WTAKminus (dust.I m)) = 1.

Assessment: MATCHES

Witness for the assessment: no separating witness; all quantification is over NDust.

Mismatch category: none.

Suggested fix: none.

dust_Bayes_calibration_gives_cone_barycenter

English statement: “Bayes-cone calibration gives that for qN-a.e. dust message m : NDust, the barycenter of ρ_m lies in Bcone (I m).”

Lean signature: BayesConeCalibration wta dust flow → ∀ᵐ m ∂flow.qN, beliefBarycenter (flow.ρ m) ∈ WTABconeProfile (dust.I m).

Assessment: MATCHES

Witness for the assessment: no separating witness.

Mismatch category: none.

Suggested fix: none.

dust_conditional_sources_satisfy_cones

English statement: “If rowwise-support and Bayes-cone calibration hold, then for qN-a.e. m : NDust, ρ_m(K_{I(m)}^-)=1 and barycenter(ρ_m) ∈ B_{I(m)}.”

Lean signature: ∀ᵐ m ∂flow.qN, flow.ρ m (WTAKminus (dust.I m)) = 1 ∧ beliefBarycenter (flow.ρ m) ∈ WTABconeProfile (dust.I m).

Assessment: MATCHES

Witness for the assessment: no separating witness.

Mismatch category: none.

Suggested fix: none.

cone_intersection_applied_to_dust

English statement: “Under the cone conditions from dust disintegration, ρ_m = δ_{μ0} for qN-a.e. dust message m : NDust.”

Lean signature: ∀ᵐ m ∂flow.qN, flow.ρ m = Measure.dirac wta.μ0.

Assessment: MATCHES

Witness for the assessment: no separating witness; the dust subtype carries lam, I, and support positivity fields needed to instantiate cone intersection.

Mismatch category: none.

Suggested fix: none.

positive_dust_mass_impossible_when_alpha_one

English statement: “If α = 1 and τ(N)=0, then no adversarial kernel can give positive mixture mass to the dust set N.”

Lean signature: flow.α = 1 → ¬ WTAPositiveQMass wta flow.α dust.N flow.κ.

Assessment: MATCHES

Witness for the assessment: no separating witness; dust.tau_null is a field of NullDustData.

Mismatch category: none.

Suggested fix: none.

dust_positive_mass_forces_mu0_atom

English statement: “If dust has positive mixture message mass, τ(N)=0, and α < 1, then the dust disintegration plus ρ_m = δ_{μ0} forces positive τ-mass on {μ0}.”

Lean signature: WTAPositiveQMass ... → flow.α < 1 → (∀ᵐ m, flow.ρ m = dirac μ0) → 0 < wta.τ {wta.μ0}.

Assessment: MATCHES

Witness for the assessment: no separating witness; the positive atom conclusion is exact.

Mismatch category: none.

Suggested fix: none.

wta_no_free_dust

English statement: “Under atomless τ in WTA ternary, there do not exist τ-null dust data, a subtype-indexed Borel dust labeling, and an adversarial kernel satisfying positive mixture dust mass, rowwise support, and Bayes-cone calibration.”

Lean signature: AtomlessTauSharpness wta → 0 ≤ α → α ≤ 1 → ¬ ∃ dust flow, flow.α = α ∧ WTAPositiveQMass ... ∧ RowwiseSupport ... ∧ BayesConeCalibration ....

Assessment: MATCHES

Witness for the assessment: no separating witness; atomlessness appears here and not in cone intersection.

Mismatch category: none.

Suggested fix: none.

sharpness_corollary

English statement: “Taking I={0} in the cone intersection theorem recovers the pointwise v7 obstruction at t0=(0.4,0.3,0.3), and no-free-dust rules out repairing it with τ-null dust.”

Lean signature: singleton {0} cone-intersection statement plus no-free-dust nonexistence statement.

Assessment: MATCHES

Witness for the assessment: no separating witness; the formalized content is exactly the singleton-support obstruction and the no-free-dust clause.

Mismatch category: none.

Suggested fix: none.

halfspace_contains_beliefs_inducing_all_vertices

English statement: “The halfspace T={μ : μ(0)≤0.4} contains beliefs whose WTA plurality labels induce each of the three vertex profiles.”

Lean signature: ContainsBeliefsForAllVertices HalfspaceTrustRegion.

Assessment: MATCHES

Witness for the assessment: no separating witness; the predicate requires one inducing belief for each vertex.

Mismatch category: none.

Suggested fix: none.

halfspace_induced_effective_menu_equals_full_vertices

English statement: “Any plurality-vertex continuation on the halfspace T induces the effective menu {v0,v1,v2}.”

Lean signature: InducedEffectiveMenu HalfspaceTrustRegion = FullWTAVertexMenu.

Assessment: MATCHES

Witness for the assessment: no separating witness; equality is exact.

Mismatch category: none.

Suggested fix: none.

halfspace_behavior_equivalent_to_full_simplex

English statement: “Since the induced in-T menu is already the full WTA vertex menu, the off-T projection/continuation behavior is the same as ordinary plurality over the full simplex.”

Lean signature: BehaviorEquivalentTrustRegion HalfspaceTrustRegion FullSimplexTrustRegion.

Assessment: MATCHES

Witness for the assessment: no separating witness; BehaviorEquivalentTrustRegion is defined as equality of induced effective menus.

Mismatch category: none.

Suggested fix: none.

halfspace_witness_menu_engine_artifact

English statement: “The halfspace witness satisfies the precise behavioral-equivalence package: it contains beliefs inducing all three vertices, its effective menu is the full vertex menu, and its behavior is equivalent to the full-simplex trust region.”

Lean signature: HalfspaceWitnessStatement.

Assessment: MATCHES

Witness for the assessment: no separating witness; HalfspaceWitnessStatement is exactly the three conjuncts.

Mismatch category: none.

Suggested fix: none.

Main theorem
robust_trust_infinite_extension_v8_package

English statement: “Under the standing Robust Trust hypotheses, posterior-law consistency, and profile-realization setup, the infinite-M, infinite-Θ extension is a package of six theorem declarations.”

Lean signature: given model, PosteriorLawConsistency, MessageSupportM, MessageRestrictionBridge, and ProfileRealizationSetup, conclude RobustTrustInfiniteExtensionV8Package model plc msupp bridge prs.

Assessment: MATCHES

Witness for the assessment: no separating witness; the package exposes ∃ σstar : AgentStrategyFull, Tier 1a, Tier 1b under ExactContact, Tier 2 under ExactContact and MenuHall, WTA cone intersection, WTA no-free-dust, and the halfspace witness.

Mismatch category: none.

Suggested fix: none.

Cross-Item Concerns

No WTA vacuity found. wta_cone_intersection has genuine set equality WTASupport lam = I, so support equality is iff after extensionality. Strict positivity on I is explicit. Nonempty supports have concrete λ witnesses, for example uniform λ on I.

Tier 2 bundle is clean. tier2_qae_robust_rationalizability_under_menu_Hall takes both ExactContact and MenuHall; atomlessness is absent. Definition2QAEPredicate is qβ-a.e. via MixtureMessageLaw model β, not τ-a.e. and not all messages.

Posterior disintegration patch is meaningful. Pγα is indexed by κ, and both sourceLawβ_disintegrates and sourceLawγα_disintegrates tie the kernels to actual mixture couplings rather than arbitrary kernels.

Witness-dropping lemmas are mostly architectural, not theorem-package rot. strategy_value_le_menu_sup and menu_value_le_strategy_sup lose construction witnesses, but the scalar inequalities may be enough for the prover DAG.

The biggest semantic weakening is dust disintegration. The English says “there exists a disintegration”; Lean assumes a bundled flow that already contains one. This is acceptable only if the project intends AdversarialFlowDisintegrationData as supplied data rather than something proved from dust and κ.

Inventory caution. measurable_argmax_selector is stronger than standard selection theorems as stated. profile_geometry_import is weaker than a primitive profile-geometry import because it assumes the abstract convex-realization ingredient.

Decisions for the Orchestrator

Items needing return-to-formalizer: measurable_argmax_selector, profile_geometry_import, support_function_pointwise_membership_equivalence, dust_disintegration_over_subtype_N.

Items needing either return-to-formalizer or structurer clarification: strategy_value_le_menu_sup, menu_value_le_strategy_sup, epsilon_adversary_realization.

Items safe to proceed to prover: the WTA cone intersection block, WTA rowwise/Bayes cone identification, Tier 2 hypothesis bundle, reverse strategy lift, Definition2QAEPredicate, PosteriorDisintegration, no-free-dust chain except the disintegration-existence wording, halfspace witness, and the main theorem package.
