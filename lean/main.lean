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
      (∀ᵐ s ∂model.τ, plc.posteriorAfterAdviser s = s) :=
  ⟨plc.barycenter_eq_prior, plc.coordinate_measure_identity, plc.posterior_after_adviser_ae⟩

theorem strategy_restriction_to_M
    (model : RobustTrustModel)
    (σFull : AgentStrategyFull model) :
    ∃ σM : AgentStrategyM model,
      ∀ m : model.M, σM.sectionM m = σFull.sectionFull (model.inclM m) :=
  ⟨restrictFullToM model σFull, fun _ => rfl⟩

theorem restricted_agent_strategy_extends_to_full
    (model : RobustTrustModel)
    (msupp : MessageSupportM model)
    (bridge : MessageRestrictionBridge model msupp)
    (σM : AgentStrategyM model) :
    ∃ σFull : AgentStrategyFull model,
      ∀ m : model.M, σFull.sectionFull (model.inclM m) = σM.sectionM m :=
  ⟨bridge.extendRestricted σM, bridge.extendRestricted_eq σM⟩

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
  -- The restricted strategies agree, so all four payoffs agree by unfolding to M-payoffs.
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
  have hc : ENNReal.ofReal model.α ≠ 0 :=
    ne_of_gt (ENNReal.ofReal_pos.mpr hα)
  have hτ_ac : model.τM ≪ MixtureMessageLaw model β := by
    have hscaled : model.τM ≪ (ENNReal.ofReal model.α) • model.τM :=
      MeasureTheory.Measure.absolutelyContinuous_smul hc
    simpa [MixtureMessageLaw] using
      (hscaled.add_right
        ((ENNReal.ofReal (1 - model.α)) •
          ((model.τM.compProd β.kernel).map Prod.snd)))
  exact hτ_ac.ae_le hP

theorem payoff_profile_set_compact_convex
    (model : RobustTrustModel)
    (prs : ProfileRealizationSetup model) :
    IsCompact (PayoffProfileSet model) ∧
      Convex ℝ (PayoffProfileSet model) ∧
      (∀ w : Profile model, w ∈ PayoffProfileSet model →
        ∃ σ : model.PrivateStrategy, model.profileOfPrivate σ = w) := by
  refine ⟨prs.W_compact, prs.W_convex, ?_⟩
  intro w hw
  obtain ⟨σ, hσ⟩ := prs.Φ_surjective_onto_W w hw
  exact ⟨σ, by rw [← prs.Φ_eq_profile]; exact hσ⟩

theorem profile_map_has_borel_right_inverse
    (model : RobustTrustModel)
    (prs : ProfileRealizationSetup model) :
    ∃ R : ProfileInW model → model.PrivateStrategy,
      Measurable R ∧
        ∀ w : ProfileInW model, model.profileOfPrivate (R w) = w.val := by
  classical
  have hW_meas : MeasurableSet (PayoffProfileSet model) :=
    prs.W_compact.measurableSet
  letI : StandardBorelSpace (ProfileInW model) := hW_meas.standardBorel
  let hmem : ∀ σ : model.PrivateStrategy, prs.Φ σ ∈ PayoffProfileSet model := by
    intro σ
    rw [prs.Φ_eq_profile]
    exact ⟨σ, rfl⟩
  let ΦW : model.PrivateStrategy → ProfileInW model :=
    fun σ => ⟨prs.Φ σ, hmem σ⟩
  have hΦW_cont : Continuous ΦW := by
    simpa [ΦW] using prs.Φ_continuous.subtype_mk hmem
  have hΦW_surj : Function.Surjective ΦW := by
    intro w
    rcases prs.Φ_surjective_onto_W w.val w.property with ⟨σ, hσ⟩
    refine ⟨σ, ?_⟩
    apply Subtype.ext
    simpa [ΦW] using hσ
  have hΦW_fib_compact :
      ∀ w : ProfileInW model,
        IsCompact (ΦW ⁻¹' ({w} : Set (ProfileInW model))) := by
    intro w
    have hset :
        ΦW ⁻¹' ({w} : Set (ProfileInW model)) =
          prs.Φ ⁻¹' ({w.val} : Set (Profile model)) := by
      ext σ
      change ΦW σ = w ↔ prs.Φ σ = w.val
      constructor
      · intro h
        simpa [ΦW] using congrArg (fun x : ProfileInW model => x.val) h
      · intro h
        apply Subtype.ext
        simpa [ΦW] using h
    rw [hset]
    exact prs.fibers_compact w.val
  have hΦW_fib_ne :
      ∀ w : ProfileInW model,
        (ΦW ⁻¹' ({w} : Set (ProfileInW model))).Nonempty := by
    intro w
    rcases hΦW_surj w with ⟨σ, hσ⟩
    refine ⟨σ, ?_⟩
    change ΦW σ = w
    exact hσ
  rcases Inventory.krn_borel_right_inverse
      (Φ := ΦW)
      hΦW_cont hΦW_surj hΦW_fib_compact hΦW_fib_ne with
    ⟨R, hR_meas, hR_right⟩
  refine ⟨R, hR_meas, ?_⟩
  intro w
  have hΦ : prs.Φ (R w) = w.val := by
    simpa [ΦW] using
      congrArg (fun x : ProfileInW model => x.val) (hR_right w)
  simpa [prs.Φ_eq_profile] using hΦ

theorem borel_profile_map_implemented_by_agent_strategy
    (model : RobustTrustModel)
    (R : ProfileRealizationMap model)
    (wMap : model.M → ProfileInW model)
    (hwMap : Measurable wMap) :
    ∃ σM : AgentStrategyM model,
      ∀ m : model.M, profileMap model σM m = (wMap m).val := by
  refine ⟨{ sectionM := fun m => R.R (wMap m)
           , measurable_sectionM := R.measurable_R.comp hwMap }, ?_⟩
  intro m
  exact R.right_inverse (wMap m)

theorem profile_payoff_decomposition_aligned
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (σM : AgentStrategyM model) :
    AlignedPayoffM model σM =
      ∫ s, beliefDot (model.inclM s) (profileMap model σM s) ∂model.τM := by
  aesop

theorem profile_payoff_decomposition_misaligned
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (β : AdviserKernel model)
    (σM : AgentStrategyM model) :
    MisalignedPayoffM model β σM =
      ∫ s, ∫ m, beliefDot (model.inclM s) (profileMap model σM m) ∂(β.kernel s) ∂model.τM := by
  aesop

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
  aesop

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
  obtain ⟨σ0⟩ : Nonempty model.PrivateStrategy := inferInstance
  haveI hAgent_ne : Nonempty (AgentStrategyM model) :=
    ⟨{ sectionM := fun _ => σ0, measurable_sectionM := measurable_const }⟩
  let w0 : Profile model := model.profileOfPrivate σ0
  have hw0 : w0 ∈ PayoffProfileSet model := ⟨σ0, rfl⟩
  let x0 : ProfileInW model := ⟨w0, hw0⟩
  let C0 : CompactMenu model :=
    ⟨⟨{x0}, isCompact_singleton⟩, Set.singleton_nonempty x0⟩
  haveI hMenu_ne : Nonempty (CompactMenu model) := ⟨C0⟩
  apply le_antisymm
  · -- UStarM = sSup (range RobustPayoffM) ≤ sSup (range F)
    refine csSup_le ?_ ?_
    · exact Set.range_nonempty _
    · rintro x ⟨σM, rfl⟩
      exact strategy_value_le_menu_sup model setup σM
  · -- sSup (range F) ≤ UStarM
    refine csSup_le ?_ ?_
    · exact Set.range_nonempty _
    · rintro x ⟨C, rfl⟩
      exact menu_value_le_strategy_sup model setup prm C

theorem compact_menu_space_compact
    (model : RobustTrustModel)
    (prs : ProfileRealizationSetup model) :
    CompactSpace (CompactMenu model) := by
  haveI : CompactSpace (ProfileInW model) := by
    simpa [ProfileInW] using (isCompact_iff_compactSpace.mp prs.W_compact)
  change CompactSpace (TopologicalSpace.NonemptyCompacts (ProfileInW model))
  infer_instance

private lemma menu_sSup_image_lipschitz_nonemptyCompacts
    {α : Type*} [MetricSpace α] {f : α → ℝ} (hf : LipschitzWith 1 f)
    (C D : TopologicalSpace.NonemptyCompacts α) :
    |sSup (f '' (↑C : Set α)) - sSup (f '' (↑D : Set α))| ≤ dist C D := by
  classical
  have hfinCD : Metric.hausdorffEDist (↑C : Set α) (↑D : Set α) ≠ ⊤ :=
    Metric.hausdorffEDist_ne_top_of_nonempty_of_bounded
      C.nonempty D.nonempty C.isCompact.isBounded D.isCompact.isBounded
  have hfinDC : Metric.hausdorffEDist (↑D : Set α) (↑C : Set α) ≠ ⊤ :=
    Metric.hausdorffEDist_ne_top_of_nonempty_of_bounded
      D.nonempty C.nonempty D.isCompact.isBounded C.isCompact.isBounded
  have hCne : (f '' (↑C : Set α)).Nonempty := by
    rcases C.nonempty with ⟨x, hx⟩
    exact ⟨f x, ⟨x, hx, rfl⟩⟩
  have hDne : (f '' (↑D : Set α)).Nonempty := by
    rcases D.nonempty with ⟨x, hx⟩
    exact ⟨f x, ⟨x, hx, rfl⟩⟩
  have hCbdd : BddAbove (f '' (↑C : Set α)) :=
    C.isCompact.bddAbove_image (hf.continuous.continuousOn)
  have hDbdd : BddAbove (f '' (↑D : Set α)) :=
    D.isCompact.bddAbove_image (hf.continuous.continuousOn)

  have hCD :
      sSup (f '' (↑C : Set α)) ≤ sSup (f '' (↑D : Set α)) + dist C D := by
    refine csSup_le hCne ?_
    rintro _ ⟨x, hxC, rfl⟩
    obtain ⟨y, hyD, hy⟩ := D.isCompact.exists_infDist_eq_dist D.nonempty x
    have hxy : dist x y ≤ dist C D := by
      rw [← hy]
      calc
        Metric.infDist x (↑D : Set α)
            ≤ Metric.hausdorffDist (↑C : Set α) (↑D : Set α) :=
          Metric.infDist_le_hausdorffDist_of_mem hxC hfinCD
        _ = dist C D := by
          rw [← Metric.NonemptyCompacts.dist_eq]
    have hySup : f y ≤ sSup (f '' (↑D : Set α)) :=
      le_csSup hDbdd ⟨y, hyD, rfl⟩
    have hxle : f x ≤ f y + dist x y := by
      simpa using hf.le_add_mul x y
    linarith

  have hDC :
      sSup (f '' (↑D : Set α)) ≤ sSup (f '' (↑C : Set α)) + dist C D := by
    refine csSup_le hDne ?_
    rintro _ ⟨x, hxD, rfl⟩
    obtain ⟨y, hyC, hy⟩ := C.isCompact.exists_infDist_eq_dist C.nonempty x
    have hxy : dist x y ≤ dist C D := by
      rw [← hy]
      calc
        Metric.infDist x (↑C : Set α)
            ≤ Metric.hausdorffDist (↑D : Set α) (↑C : Set α) :=
          Metric.infDist_le_hausdorffDist_of_mem hxD hfinDC
        _ = Metric.hausdorffDist (↑C : Set α) (↑D : Set α) := by
          rw [Metric.hausdorffDist_comm]
        _ = dist C D := by
          rw [← Metric.NonemptyCompacts.dist_eq]
    have hySup : f y ≤ sSup (f '' (↑C : Set α)) :=
      le_csSup hCbdd ⟨y, hyC, rfl⟩
    have hxle : f x ≤ f y + dist x y := by
      simpa using hf.le_add_mul x y
    linarith

  rw [abs_sub_le_iff]
  constructor <;> linarith

private lemma menu_sInf_image_lipschitz_nonemptyCompacts
    {α : Type*} [MetricSpace α] {f : α → ℝ} (hf : LipschitzWith 1 f)
    (C D : TopologicalSpace.NonemptyCompacts α) :
    |sInf (f '' (↑C : Set α)) - sInf (f '' (↑D : Set α))| ≤ dist C D := by
  classical
  have hfinCD : Metric.hausdorffEDist (↑C : Set α) (↑D : Set α) ≠ ⊤ :=
    Metric.hausdorffEDist_ne_top_of_nonempty_of_bounded
      C.nonempty D.nonempty C.isCompact.isBounded D.isCompact.isBounded
  have hfinDC : Metric.hausdorffEDist (↑D : Set α) (↑C : Set α) ≠ ⊤ :=
    Metric.hausdorffEDist_ne_top_of_nonempty_of_bounded
      D.nonempty C.nonempty D.isCompact.isBounded C.isCompact.isBounded
  have hCne : (f '' (↑C : Set α)).Nonempty := by
    rcases C.nonempty with ⟨x, hx⟩
    exact ⟨f x, ⟨x, hx, rfl⟩⟩
  have hDne : (f '' (↑D : Set α)).Nonempty := by
    rcases D.nonempty with ⟨x, hx⟩
    exact ⟨f x, ⟨x, hx, rfl⟩⟩
  have hCbdd : BddBelow (f '' (↑C : Set α)) :=
    C.isCompact.bddBelow_image (hf.continuous.continuousOn)
  have hDbdd : BddBelow (f '' (↑D : Set α)) :=
    D.isCompact.bddBelow_image (hf.continuous.continuousOn)

  have hCD :
      sInf (f '' (↑D : Set α)) - dist C D ≤ sInf (f '' (↑C : Set α)) := by
    refine le_csInf hCne ?_
    rintro _ ⟨x, hxC, rfl⟩
    obtain ⟨y, hyD, hy⟩ := D.isCompact.exists_infDist_eq_dist D.nonempty x
    have hxy : dist x y ≤ dist C D := by
      rw [← hy]
      calc
        Metric.infDist x (↑D : Set α)
            ≤ Metric.hausdorffDist (↑C : Set α) (↑D : Set α) :=
          Metric.infDist_le_hausdorffDist_of_mem hxC hfinCD
        _ = dist C D := by
          rw [← Metric.NonemptyCompacts.dist_eq]
    have hInf : sInf (f '' (↑D : Set α)) ≤ f y :=
      csInf_le hDbdd ⟨y, hyD, rfl⟩
    have hfy : f y ≤ f x + dist x y := by
      have h := hf.le_add_mul y x
      simpa [dist_comm] using h
    linarith

  have hDC :
      sInf (f '' (↑C : Set α)) - dist C D ≤ sInf (f '' (↑D : Set α)) := by
    refine le_csInf hDne ?_
    rintro _ ⟨x, hxD, rfl⟩
    obtain ⟨y, hyC, hy⟩ := C.isCompact.exists_infDist_eq_dist C.nonempty x
    have hxy : dist x y ≤ dist C D := by
      rw [← hy]
      calc
        Metric.infDist x (↑C : Set α)
            ≤ Metric.hausdorffDist (↑D : Set α) (↑C : Set α) :=
          Metric.infDist_le_hausdorffDist_of_mem hxD hfinDC
        _ = Metric.hausdorffDist (↑C : Set α) (↑D : Set α) := by
          rw [Metric.hausdorffDist_comm]
        _ = dist C D := by
          rw [← Metric.NonemptyCompacts.dist_eq]
    have hInf : sInf (f '' (↑C : Set α)) ≤ f y :=
      csInf_le hCbdd ⟨y, hyC, rfl⟩
    have hfy : f y ≤ f x + dist x y := by
      have h := hf.le_add_mul y x
      simpa [dist_comm] using h
    linarith

  rw [abs_sub_le_iff]
  constructor <;> linarith

private lemma beliefDot_lipschitz
    (model : RobustTrustModel) (s : model.M) :
    LipschitzWith 1
      (fun w : ProfileInW model => beliefDot (model.inclM s) w.val) := by
  classical
  refine LipschitzWith.of_le_add ?_
  intro x y
  have hp0 : ∀ ω : model.Ω, 0 ≤ (model.inclM s).val ω :=
    (model.inclM s).property.1
  have hpsum : (∑ ω : model.Ω, (model.inclM s).val ω) = 1 :=
    (model.inclM s).property.2
  have hcoord (ω : model.Ω) :
      |x.val ω - y.val ω| ≤ dist x y := by
    have heval :
        dist (x.val ω) (y.val ω) ≤ dist x.val y.val := by
      simpa [Function.eval] using
        ((LipschitzWith.eval (ι := model.Ω)
            (α := fun _ : model.Ω => ℝ) ω).dist_le_mul x.val y.val)
    simpa [Real.dist_eq, Subtype.dist_eq] using heval

  have hdiff :
      beliefDot (model.inclM s) x.val - beliefDot (model.inclM s) y.val =
        ∑ ω : model.Ω,
          (model.inclM s).val ω * (x.val ω - y.val ω) := by
    unfold beliefDot
    rw [← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl ?_
    intro ω hω
    ring

  have hsum_abs :
      (∑ ω : model.Ω,
          (model.inclM s).val ω * (x.val ω - y.val ω)) ≤
        ∑ ω : model.Ω,
          (model.inclM s).val ω * |x.val ω - y.val ω| := by
    refine Finset.sum_le_sum ?_
    intro ω hω
    exact mul_le_mul_of_nonneg_left
      (le_abs_self (x.val ω - y.val ω)) (hp0 ω)

  have hsum_dist :
      (∑ ω : model.Ω,
          (model.inclM s).val ω * |x.val ω - y.val ω|) ≤
        ∑ ω : model.Ω, (model.inclM s).val ω * dist x y := by
    refine Finset.sum_le_sum ?_
    intro ω hω
    exact mul_le_mul_of_nonneg_left (hcoord ω) (hp0 ω)

  have hsum_eq :
      (∑ ω : model.Ω, (model.inclM s).val ω * dist x y) = dist x y := by
    calc
      (∑ ω : model.Ω, (model.inclM s).val ω * dist x y)
          = (∑ ω : model.Ω, (model.inclM s).val ω) * dist x y := by
            simpa using
              (Finset.sum_mul
                (s := Finset.univ)
                (f := fun ω : model.Ω => (model.inclM s).val ω)
                (a := dist x y)).symm
      _ = dist x y := by
            rw [hpsum, one_mul]

  have hsub :
      beliefDot (model.inclM s) x.val - beliefDot (model.inclM s) y.val
        ≤ dist x y := by
    calc
      beliefDot (model.inclM s) x.val - beliefDot (model.inclM s) y.val
          = ∑ ω : model.Ω,
              (model.inclM s).val ω * (x.val ω - y.val ω) := hdiff
      _ ≤ ∑ ω : model.Ω,
              (model.inclM s).val ω * |x.val ω - y.val ω| := hsum_abs
      _ ≤ ∑ ω : model.Ω,
              (model.inclM s).val ω * dist x y := hsum_dist
      _ = dist x y := hsum_eq
  linarith

theorem menu_extrema_Hausdorff_Lipschitz
    (model : RobustTrustModel) :
    ∃ L : ℝ, 0 ≤ L ∧
      ∀ (C D : CompactMenu model) (s : model.M),
        |maxPayoff model C s - maxPayoff model D s| ≤ L * dist C D ∧
        |minPayoff model C s - minPayoff model D s| ≤ L * dist C D := by
  refine ⟨1, by norm_num, ?_⟩
  intro C D s
  let f : ProfileInW model → ℝ :=
    fun w => beliefDot (model.inclM s) w.val
  have hf : LipschitzWith 1 f :=
    beliefDot_lipschitz model s
  constructor
  · simpa [maxPayoff, f, one_mul] using
      menu_sSup_image_lipschitz_nonemptyCompacts hf C D
  · simpa [minPayoff, f, one_mul] using
      menu_sInf_image_lipschitz_nonemptyCompacts hf C D

/-
Precise remaining API stub 1.

Needed lemma:
  compact-extremum measurability for a Carathéodory/support-function map.

In this application:
  F s w = beliefDot (model.inclM s) w.val

For fixed `w`, `s ↦ F s w` is measurable.
For fixed `s`, `w ↦ F s w` is continuous.
For compact `C`, this should give AEMeasurable/Measurable for
  s ↦ maxPayoff C s
and
  s ↦ minPayoff C s.
-/
private lemma menu_integrand_aemeasurable
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (C : CompactMenu model) :
    AEMeasurable
      (fun s =>
        model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s)
      model.τM := by
  sorry

/-
Precise remaining API stub 2.

Needed lemma:
  uniform boundedness of the menu integrand.

A sufficient route is:
  ∃ B, ∀ w : ProfileInW model, ∀ ω, |w.val ω| ≤ B

from compactness of the payoff-profile set, plus:
  0 ≤ (model.inclM s).val ω,
  ∑ ω, (model.inclM s).val ω = 1,
  0 ≤ model.α,
  model.α ≤ 1.

Then:
  |maxPayoff model C s| ≤ B,
  |minPayoff model C s| ≤ B,
  |model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s| ≤ B.
-/
private lemma menu_integrand_mem_Icc_ae
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (C : CompactMenu model) :
    ∃ B : ℝ,
      ∀ᵐ s ∂model.τM,
        model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s ∈
          Set.Icc (-B) B := by
  sorry

private lemma menu_integrand_integrable
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (C : CompactMenu model) :
    Integrable
      (fun s =>
        model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s)
      model.τM := by
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  rcases menu_integrand_mem_Icc_ae model setup C with ⟨B, hB⟩
  exact
    Integrable.of_mem_Icc (-B) B
      (menu_integrand_aemeasurable model setup C)
      hB

theorem menu_functional_continuity
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model) :
    Continuous (MenuFunctionalF model) := by
  obtain ⟨L, _hL_nonneg, hL⟩ := menu_extrema_Hausdorff_Lipschitz model
  haveI : IsProbabilityMeasure model.τM := model.τM_prob

  refine (LipschitzWith.of_dist_le' (K := L) ?_).continuous
  intro C D

  let fC :=
    fun s =>
      model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s
  let fD :=
    fun s =>
      model.α * maxPayoff model D s + (1 - model.α) * minPayoff model D s

  have hC : Integrable fC model.τM := by
    simpa [fC] using menu_integrand_integrable model setup C
  have hD : Integrable fD model.τM := by
    simpa [fD] using menu_integrand_integrable model setup D

  have hBound :
      ∀ᵐ s ∂model.τM, ‖fC s - fD s‖ ≤ L * dist C D := by
    filter_upwards with s
    obtain ⟨hmax, hmin⟩ := hL C D s
    have hα : 0 ≤ model.α := model.α_nonneg
    have h1α : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one
    show |fC s - fD s| ≤ L * dist C D
    have hexpand :
        fC s - fD s =
          model.α * (maxPayoff model C s - maxPayoff model D s) +
            (1 - model.α) * (minPayoff model C s - minPayoff model D s) := by
      simp [fC, fD]; ring
    calc
      |fC s - fD s|
          = |model.α * (maxPayoff model C s - maxPayoff model D s) +
              (1 - model.α) * (minPayoff model C s - minPayoff model D s)| := by
            rw [hexpand]
      _ ≤ |model.α * (maxPayoff model C s - maxPayoff model D s)| +
            |(1 - model.α) * (minPayoff model C s - minPayoff model D s)| :=
              abs_add_le _ _
      _ = model.α * |maxPayoff model C s - maxPayoff model D s| +
            (1 - model.α) * |minPayoff model C s - minPayoff model D s| := by
            rw [abs_mul, abs_mul, abs_of_nonneg hα, abs_of_nonneg h1α]
      _ ≤ model.α * (L * dist C D) + (1 - model.α) * (L * dist C D) := by
            gcongr
      _ = L * dist C D := by ring

  rw [Real.dist_eq]
  calc
    |MenuFunctionalF model C - MenuFunctionalF model D|
        = |∫ s, fC s - fD s ∂model.τM| := by
            simp [MenuFunctionalF, fC, fD,
              MeasureTheory.integral_sub hC hD]
    _ = ‖∫ s, fC s - fD s ∂model.τM‖ := by
            simp [Real.norm_eq_abs]
    _ ≤ (L * dist C D) * model.τM.real Set.univ := by
            exact MeasureTheory.norm_integral_le_of_norm_le_const hBound
    _ = L * dist C D := by
            simp

theorem optimal_menu_exists
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model) :
    ∃ Cstar : CompactMenu model,
      ∀ C : CompactMenu model, MenuFunctionalF model C ≤ MenuFunctionalF model Cstar := by
  haveI : CompactSpace (CompactMenu model) := compact_menu_space_compact model setup
  obtain ⟨σ0⟩ : Nonempty model.PrivateStrategy := inferInstance
  let w0 : Profile model := model.profileOfPrivate σ0
  have hw0 : w0 ∈ PayoffProfileSet model := ⟨σ0, rfl⟩
  let x0 : ProfileInW model := ⟨w0, hw0⟩
  haveI : Nonempty (CompactMenu model) :=
    ⟨⟨⟨{x0}, isCompact_singleton⟩, Set.singleton_nonempty x0⟩⟩
  have hcont : Continuous (MenuFunctionalF model) := menu_functional_continuity model setup
  have hcpct : IsCompact (Set.univ : Set (CompactMenu model)) := isCompact_univ
  obtain ⟨Cstar, _hC_mem, hCmax⟩ :=
    hcpct.exists_isMaxOn Set.univ_nonempty hcont.continuousOn
  exact ⟨Cstar, fun C => hCmax (Set.mem_univ C)⟩

theorem aligned_best_labeling_selection
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model) :
    ∃ wlabel : AlignedBestLabelingWstar model opt,
      (∀ m : model.M, wlabel.wstar m ∈ (↑opt.Cstar : Set (ProfileInW model))) ∧
        (∀ m : model.M,
          IsMaxOn (fun w : ProfileInW model => beliefDot (model.inclM m) w.val)
            (↑opt.Cstar : Set (ProfileInW model)) (wlabel.wstar m)) := by
  classical
  set C : Set (ProfileInW model) := (↑opt.Cstar : Set (ProfileInW model)) with hC_def
  haveI hCne : Nonempty C := by
    rcases opt.Cstar.nonempty with ⟨w, hw⟩
    exact ⟨⟨w, by simpa [hC_def] using hw⟩⟩
  have hC_cpt : IsCompact C := by
    simpa [hC_def] using opt.Cstar.isCompact
  haveI hCcs : CompactSpace C :=
    isCompact_iff_compactSpace.mp hC_cpt
  let Γ : model.M → Set C := fun _ => Set.univ
  let f : model.M → C → ℝ := fun m w =>
    beliefDot (model.inclM m) w.val.val
  have hΓ_meas : MeasurableSet {p : model.M × C | p.2 ∈ Γ p.1} := by
    simpa [Γ] using
      (MeasurableSet.univ : MeasurableSet (Set.univ : Set (model.M × C)))
  have hΓ_ne : ∀ x : model.M, (Γ x).Nonempty := by
    intro x
    simpa [Γ] using (Set.univ_nonempty : (Set.univ : Set C).Nonempty)
  have hΓ_compact : ∀ x : model.M, IsCompact (Γ x) := by
    intro x
    simpa [Γ] using (isCompact_univ : IsCompact (Set.univ : Set C))
  have hf_meas : Measurable fun p : model.M × C => f p.1 p.2 := by
    dsimp [f, beliefDot]
    refine Finset.measurable_sum _ ?_
    intro ω _
    have hμ : Measurable (fun p : model.M × C => (model.inclM p.1).val) := by
      exact measurable_subtype_coe.comp
        (model.inclM_measurable.comp measurable_fst)
    have hw : Measurable (fun p : model.M × C => p.2.val.val) := by
      exact measurable_subtype_coe.comp
        (measurable_subtype_coe.comp measurable_snd)
    have h1 : Measurable
        (fun p : model.M × C => (model.inclM p.1).val ω) := by
      exact
        ((measurable_pi_apply ω :
            Measurable (fun g : model.Ω → ℝ => g ω))).comp hμ
    have h2 : Measurable
        (fun p : model.M × C => p.2.val.val ω) := by
      exact
        ((measurable_pi_apply ω :
            Measurable (fun g : model.Ω → ℝ => g ω))).comp hw
    exact h1.mul h2
  have hf_cont :
      ∀ x : model.M, ContinuousOn (fun y : C => f x y) (Γ x) := by
    intro x
    have hcont : Continuous (fun y : C => f x y) := by
      dsimp [f, beliefDot]
      refine continuous_finset_sum _ ?_
      intro ω _
      have hval : Continuous (fun y : C => y.val.val) := by
        exact continuous_subtype_val.comp continuous_subtype_val
      exact continuous_const.mul ((continuous_apply ω).comp hval)
    exact hcont.continuousOn
  obtain ⟨wsel, hwsel_meas, hwsel⟩ :=
    Inventory.measurable_argmax_selector
      (Γ := Γ) (f := f)
      hΓ_meas hΓ_ne hΓ_compact hf_meas hf_cont
  refine
    ⟨{ wstar := fun m => (wsel m).val
       measurable_wstar := measurable_subtype_coe.comp hwsel_meas
       mem_Cstar := fun m => by
         simpa [hC_def] using (wsel m).property
       is_argmax := ?_ }, ?_, ?_⟩
  · intro m
    rw [isMaxOn_iff]
    intro w hw
    have hwC : w ∈ C := by
      simpa [hC_def] using hw
    have h_isMax : IsMaxOn (fun y : ↥C => f m y) (Γ m) (wsel m) := (hwsel m).2
    have h_mem : (⟨w, hwC⟩ : ↥C) ∈ Γ m := by simp [Γ]
    have hmax : f m ⟨w, hwC⟩ ≤ f m (wsel m) := h_isMax h_mem
    simpa [f] using hmax
  · intro m
    simpa [hC_def] using (wsel m).property
  · intro m
    rw [isMaxOn_iff]
    intro w hw
    have hwC : w ∈ C := by
      simpa [hC_def] using hw
    have h_isMax : IsMaxOn (fun y : ↥C => f m y) (Γ m) (wsel m) := (hwsel m).2
    have h_mem : (⟨w, hwC⟩ : ↥C) ∈ Γ m := by simp [Γ]
    have hmax : f m ⟨w, hwC⟩ ≤ f m (wsel m) := h_isMax h_mem
    simpa [f] using hmax

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
  refine ⟨{ sectionM := fun m => prm.R (wlabel.wstar m)
            measurable_sectionM := prm.measurable_R.comp wlabel.measurable_wstar }, ?_⟩
  intro m
  show model.profileOfPrivate (prm.R (wlabel.wstar m)) = (wlabel.wstar m).val
  exact prm.right_inverse (wlabel.wstar m)

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
  let σstarFull := bridge.extendRestricted σstarM
  refine ⟨σstarFull, ?_, ?_⟩
  · -- RobustPayoffFull σstarFull = UStarFull model
    obtain ⟨hUStar_eq, hRobust_eq⟩ := full_restricted_Ustar_equivalence model msupp bridge
    have h_eq_section : ∀ m, σstarFull.sectionFull (model.inclM m) = σstarM.sectionM m :=
      bridge.extendRestricted_eq σstarM
    rw [hRobust_eq σstarFull σstarM h_eq_section, hσstarM, ← hUStar_eq]
  · exact bridge.extendRestricted_eq σstarM

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
          profileMap model (restrictFullToM model σstar) m = (ec.wlabel.wstar m).val) :=
  ⟨ec.selector, ec.selector_measurable, ec.selector_mem, ec.sigma_implements_wlabel⟩

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
  let βstar : AdviserKernel model :=
    { kernel := Kernel.deterministic ec.selector ec.selector_measurable
      isMarkov := by infer_instance }

  have hdet : ∀ s : model.M, βstar.kernel s = Measure.dirac (ec.selector s) := by
    intro s
    exact Kernel.deterministic_apply ec.selector_measurable s

  have hsupp : KernelSupportedOnG model ec.cdagger βstar := by
    unfold KernelSupportedOnG
    filter_upwards [ec.selector_mem] with s hs
    rw [hdet s]
    exact Measure.dirac_apply_of_mem hs

  have hpay :=
    wstar_payoff_equals_F_Cdagger
      model ec.opt ec.wlabel ec.cdagger
      (restrictFullToM model σstar)
      ec.sigma_implements_wlabel

  have hmis_beta :
      MisalignedPayoffFull model βstar σstar =
        ∫ s, minPayoff model ec.cdagger.Cdagger s ∂model.τM := by
    unfold MisalignedPayoffFull MisalignedPayoffM
    apply integral_congr_ae
    filter_upwards [ec.selector_mem] with s hs
    calc
      (∫ m, beliefDot (model.inclM s)
          (profileMap model (restrictFullToM model σstar) m) ∂(βstar.kernel s))
          =
        ∫ m, beliefDot (model.inclM s)
          (profileMap model (restrictFullToM model σstar) m)
            ∂(Measure.dirac (ec.selector s)) := by
          rw [hdet s]
      _ =
        beliefDot (model.inclM s)
          (profileMap model (restrictFullToM model σstar) (ec.selector s)) := by
          simp
      _ =
        beliefDot (model.inclM s)
          ((ec.wlabel.wstar (ec.selector s)).val) := by
          rw [ec.sigma_implements_wlabel (ec.selector s)]
      _ = minPayoff model ec.cdagger.Cdagger s := by
          simpa [RowwiseContactG] using hs

  have hmis_inf :
      sInf (Set.range fun β : AdviserKernel model =>
        MisalignedPayoffFull model β σstar) =
        ∫ s, minPayoff model ec.cdagger.Cdagger s ∂model.τM := by
    simpa [MisalignedPayoffFull] using hpay.2.1

  have hmis_attains :
      MisalignedPayoffFull model βstar σstar =
        sInf (Set.range fun β : AdviserKernel model =>
          MisalignedPayoffFull model β σstar) := by
    rw [hmis_beta, hmis_inf]

  have hmix :
      MixturePayoffFull model βstar σstar =
        RobustPayoffFull model σstar := by
    -- Algebraic linearity: sInf_β (α·A + (1-α)·M β) = α·A + (1-α)·sInf_β M β when
    -- (1-α) ≥ 0. Combined with hmis_attains (Mis βstar = sInf range Mis), gives equality.
    -- Establishing this requires Real.iInf_const_add + Real.iInf_const_mul-style API
    -- + BddBelow of MisalignedPayoffFull range. Deferred to a future Pro pass.
    sorry

  refine ⟨βstar, hdet, hsupp, ?_, hmix, hσstar⟩
  simpa [IsAdversarialFull] using hmix

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
        mh.q = (MixtureCouplingGammaAlpha model κ).map Prod.snd) :=
  ⟨rfl, mh.q_eq_qκ, mh.q_eq_gamma_second⟩

theorem menu_hall_posterior_calibration_unpack
    (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (mh : MenuHall model pd σstar ec κ) :
    ∀ᵐ m ∂mh.q, pd.Pγα κ m ∈ BayesOptimalityBeliefCorrespondenceBm model σstar m := by
  exact?

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
  have hq_ae :
      ∀ᵐ m ∂mh.q,
        IsBayesOptimal model (σstar.sectionFull (model.inclM m)) (pd.Pγα κ m) := by
    filter_upwards [mh.calibration] with m hm
    exact hm
  refine ⟨hq_ae, ?_⟩
  intro hα
  have hq_ae' :
      ∀ᵐ m ∂MixtureMessageLaw model κ,
        IsBayesOptimal model (σstar.sectionFull (model.inclM m)) (pd.Pγα κ m) := by
    rw [← mh.q_eq_qκ]; exact hq_ae
  exact q_dominates_tau_when_alpha_pos model κ hα hq_ae'

theorem posterior_disintegration_menuHall_kernel_coincides
    (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (mh : MenuHall model pd σstar ec κ) :
    ∀ᵐ m ∂MixtureMessageLaw model κ, pd.Pβ κ m = pd.Pγα κ m := by
  classical
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  haveI : IsMarkovKernel κ.kernel := κ.isMarkov
  haveI : IsMarkovKernel (pd.sourceLawβ κ) := pd.sourceLawβ_markov κ
  haveI : IsMarkovKernel (pd.sourceLawγα κ) := pd.sourceLawγα_markov κ
  haveI hMixtureMessageLaw_finite :
      IsFiniteMeasure (MixtureMessageLaw model κ) := by
    unfold MixtureMessageLaw
    have h1 : IsFiniteMeasure ((ENNReal.ofReal model.α) • model.τM) :=
      MeasureTheory.Measure.smul_finite model.τM
        (c := ENNReal.ofReal model.α) ENNReal.ofReal_ne_top
    have hprod : IsFiniteMeasure (model.τM.compProd κ.kernel) := by
      infer_instance
    have hmap : IsFiniteMeasure
        (MeasureTheory.Measure.map Prod.snd (model.τM.compProd κ.kernel)) := by
      haveI : IsFiniteMeasure (model.τM.compProd κ.kernel) := hprod
      infer_instance
    have h2 : IsFiniteMeasure
        ((ENNReal.ofReal (1 - model.α)) •
          MeasureTheory.Measure.map Prod.snd (model.τM.compProd κ.kernel)) := by
      haveI : IsFiniteMeasure
          (MeasureTheory.Measure.map Prod.snd (model.τM.compProd κ.kernel)) := hmap
      exact MeasureTheory.Measure.smul_finite
        (MeasureTheory.Measure.map Prod.snd (model.τM.compProd κ.kernel))
        (c := ENNReal.ofReal (1 - model.α)) ENNReal.ofReal_ne_top
    haveI : IsFiniteMeasure ((ENNReal.ofReal model.α) • model.τM) := h1
    haveI : IsFiniteMeasure
        ((ENNReal.ofReal (1 - model.α)) •
          MeasureTheory.Measure.map Prod.snd (model.τM.compProd κ.kernel)) := h2
    infer_instance
  have hbase :
      (MixtureCouplingGammaAlpha model κ).map Prod.snd =
        MixtureMessageLaw model κ :=
    mh.q_eq_gamma_second.symm.trans mh.q_eq_qκ
  have hγ_dis :
      (MixtureCouplingGammaAlpha model κ).map
          (fun p : model.M × model.M => (p.2, model.inclM p.1)) =
        (MixtureMessageLaw model κ).compProd (pd.sourceLawγα κ) := by
    simpa [hbase] using pd.sourceLawγα_disintegrates κ
  have hcomp :
      (MixtureMessageLaw model κ).compProd (pd.sourceLawβ κ) =
        (MixtureMessageLaw model κ).compProd (pd.sourceLawγα κ) :=
    (pd.sourceLawβ_disintegrates κ).symm.trans hγ_dis
  have hsource :
      (⇑(pd.sourceLawβ κ)) =ᵐ[MixtureMessageLaw model κ]
        ⇑(pd.sourceLawγα κ) :=
    ProbabilityTheory.Kernel.ae_eq_of_compProd_eq hcomp
  have hbβ :
      ∀ᵐ m ∂MixtureMessageLaw model κ,
        beliefBarycenter ((pd.sourceLawβ κ) m) =
          beliefAsProfile (pd.Pβ κ m) :=
    pd.conditional_barycenter κ
  have hbγ :
      ∀ᵐ m ∂MixtureMessageLaw model κ,
        beliefBarycenter ((pd.sourceLawγα κ) m) =
          beliefAsProfile (pd.Pγα κ m) := by
    simpa [hbase] using pd.gamma_alpha_conditional_barycenter κ
  filter_upwards [hsource, hbβ, hbγ] with m hsrc hβ hγ
  have hprofile :
      beliefAsProfile (pd.Pβ κ m) =
        beliefAsProfile (pd.Pγα κ m) := by
    calc
      beliefAsProfile (pd.Pβ κ m)
          = beliefBarycenter ((pd.sourceLawβ κ) m) := hβ.symm
      _ = beliefBarycenter ((pd.sourceLawγα κ) m) := by
            rw [hsrc]
      _ = beliefAsProfile (pd.Pγα κ m) := hγ
  apply Subtype.ext
  funext ω
  simpa [beliefAsProfile] using congrFun hprofile ω

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
  exact?

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
  obtain ⟨R, hR_meas, hR_right⟩ := profile_map_has_borel_right_inverse model prs
  let prm : ProfileRealizationMap model := ⟨R, hR_meas, hR_right⟩
  obtain ⟨Cstar, hCstar_max⟩ := optimal_menu_exists model prs
  have hbdd : BddAbove (Set.range (MenuFunctionalF model)) :=
    ⟨MenuFunctionalF model Cstar, by rintro x ⟨C, rfl⟩; exact hCstar_max C⟩
  have hF_eq_sSup :
      MenuFunctionalF model Cstar = sSup (Set.range (MenuFunctionalF model)) := by
    apply le_antisymm
    · exact le_csSup hbdd ⟨Cstar, rfl⟩
    · refine csSup_le ⟨_, ⟨Cstar, rfl⟩⟩ ?_
      rintro x ⟨C, rfl⟩
      exact hCstar_max C
  have hF_eq : MenuFunctionalF model Cstar = UStarM model := by
    rw [menu_value_equivalence model prs prm]; exact hF_eq_sSup
  let opt : OptimalMenuCstar model := ⟨Cstar, hCstar_max, hF_eq⟩
  obtain ⟨wlabel, _, _⟩ := aligned_best_labeling_selection model opt
  obtain ⟨cdagger, _hsubset, hF_cdagger_eq, hF_Cstar_eq_U⟩ :=
    closure_pruning_value_preservation model opt wlabel
  obtain ⟨σM, hprofile⟩ :=
    wstar_profile_map_implemented model prs prm opt wlabel cdagger
  obtain ⟨_, _, hRobust⟩ :=
    wstar_payoff_equals_F_Cdagger model opt wlabel cdagger σM hprofile
  have hRobustM_eq_U : RobustPayoffM model σM = UStarM model := by
    rw [hRobust, hF_cdagger_eq, hF_Cstar_eq_U]
  obtain ⟨σstar, hσstar_full, _⟩ :=
    sigma_star_robust_optimal model msupp bridge σM hRobustM_eq_U
  exact ⟨σstar, hσstar_full,
    epsilon_adversary_realization model σstar hσstar_full⟩

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
  obtain ⟨βstar, hdet, hsupp, hadv, hmix, _⟩ :=
    exact_adversary_attainment model σstar hσstar ec
  exact ⟨{ βstar := βstar
           deterministic := hdet
           supported_on_G := hsupp
           adversarial := hadv
           value := hmix.trans hσstar }⟩

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
  obtain ⟨hadv, hmix⟩ :=
    menu_hall_support_implies_exact_adversary model σstar hσstar ec κ mh.supported
  have h_pm := per_message_Bayes_optimality model pd σstar ec κ mh
  have h_coincide :=
    posterior_disintegration_menuHall_kernel_coincides model pd σstar ec κ mh
  have h_bayes_q :
      ∀ᵐ m ∂MixtureMessageLaw model κ,
        IsBayesOptimal model (σstar.sectionFull (model.inclM m)) (pd.Pγα κ m) := by
    rw [← mh.q_eq_qκ]; exact h_pm.1
  have h_def2 : Definition2QAEPredicate model pd κ σstar := by
    refine ⟨hadv, ?_⟩
    filter_upwards [h_bayes_q, h_coincide] with m hb hc
    rw [hc]; exact hb
  exact ⟨rfl, mh.q_eq_qκ, mh.q_eq_gamma_second, hadv, hmix, h_def2, h_pm.2⟩

theorem wta_payoff_dot_product_identity
    (lam : WTAΩ → ℝ)
    (hlam_nonneg : ∀ i : WTAΩ, 0 ≤ lam i)
    (hlam_sum : ∑ i : WTAΩ, lam i = 1)
    (s : WTABelief) :
    beliefDot s (WTA_mixedLabel lam) =
      2 * (∑ i : WTAΩ, lam i * s.val i) - 1 := by
  classical
  have hvertex : ∀ j : WTAΩ, WTA_mixedLabel lam j = 2 * lam j - 1 := by
    intro j
    unfold WTA_mixedLabel WTA_vertex
    calc
      (∑ i : WTAΩ, lam i * (if i = j then (1 : ℝ) else -1))
          = ∑ i : WTAΩ, (2 * (if i = j then lam i else (0 : ℝ)) - lam i) := by
            apply Finset.sum_congr rfl
            intro i _
            by_cases h : i = j <;> simp [h] <;> ring
      _ = 2 * (∑ i : WTAΩ, (if i = j then lam i else (0 : ℝ))) - (∑ i : WTAΩ, lam i) := by
            rw [Finset.sum_sub_distrib]
            rw [← Finset.mul_sum]
      _ = 2 * lam j - 1 := by
            have hsingle : (∑ i : WTAΩ, (if i = j then lam i else (0 : ℝ))) = lam j := by
              simp
            rw [hsingle, hlam_sum]
  unfold beliefDot
  simp_rw [hvertex]
  calc
    (∑ ω : WTAΩ, s.val ω * (2 * lam ω - 1))
        = ∑ ω : WTAΩ, (2 * (lam ω * s.val ω) - s.val ω) := by
          apply Finset.sum_congr rfl
          intro ω _
          ring
    _ = 2 * (∑ ω : WTAΩ, lam ω * s.val ω) - (∑ ω : WTAΩ, s.val ω) := by
          rw [Finset.sum_sub_distrib]
          rw [← Finset.mul_sum]
    _ = 2 * (∑ i : WTAΩ, lam i * s.val i) - 1 := by
          rw [s.property.2]

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
  classical

  have h_outside : ∀ i : WTAΩ, i ∉ I → lam i = 0 := by
    intro i hi
    have hnotpos : ¬ 0 < lam i := by
      intro hpos
      have hsupp : i ∈ WTASupport lam := by
        change 0 < lam i
        exact hpos
      have hmem : i ∈ I := by
        simpa [h_support_eq] using hsupp
      exact hi hmem
    exact le_antisymm (le_of_not_gt hnotpos) (hlam_nonneg i)

  have hvertex :
      ∀ (b : WTABelief) (k : WTAΩ),
        beliefDot b (WTA_vertex k) = 2 * b.val k - 1 := by
    intro b k
    let delta : WTAΩ → ℝ := fun i => if i = k then (1 : ℝ) else 0
    have hdelta_nonneg : ∀ i : WTAΩ, 0 ≤ delta i := by
      intro i
      by_cases h : i = k <;> simp [delta, h]
    have hdelta_sum : ∑ i : WTAΩ, delta i = 1 := by
      dsimp [delta]
      rw [Finset.sum_eq_single k]
      · simp
      · intro i _ hik
        simp [hik]
      · intro hk
        exact False.elim (hk (Finset.mem_univ k))
    have hmixed_delta : WTA_mixedLabel delta = WTA_vertex k := by
      funext j
      unfold WTA_mixedLabel
      rw [Finset.sum_eq_single k]
      · simp [delta]
      · intro i _ hik
        simp [delta, hik]
      · intro hk
        exact False.elim (hk (Finset.mem_univ k))
    have hdelta_b : ∑ i : WTAΩ, delta i * b.val i = b.val k := by
      dsimp [delta]
      rw [Finset.sum_eq_single k]
      · simp
      · intro i _ hik
        simp [hik]
      · intro hk
        exact False.elim (hk (Finset.mem_univ k))
    have h :=
      wta_payoff_dot_product_identity delta hdelta_nonneg hdelta_sum b
    rw [hmixed_delta, hdelta_b] at h
    exact h

  have h_eq_of_avg_le :
      ∀ (b : WTABelief) (avg : ℝ),
        avg = (∑ i : WTAΩ, lam i * b.val i) →
        (∀ k : WTAΩ, avg ≤ b.val k) →
        ∀ i0 : WTAΩ, i0 ∈ I → b.val i0 = avg := by
    intro b avg havg hle i0 hi0
    have hsumTerms : ∑ i : WTAΩ, lam i * (b.val i - avg) = 0 := by
      calc
        ∑ i : WTAΩ, lam i * (b.val i - avg)
            = (∑ i : WTAΩ, lam i * b.val i) - (∑ i : WTAΩ, lam i) * avg := by
                simp_rw [mul_sub]
                rw [Finset.sum_sub_distrib, ← Finset.sum_mul]
        _ = avg - 1 * avg := by
                rw [← havg, hlam_sum]
        _ = 0 := by ring
    have htermNonneg :
        ∀ i ∈ (Finset.univ : Finset WTAΩ), 0 ≤ lam i * (b.val i - avg) := by
      intro i _
      by_cases hi : i ∈ I
      · exact mul_nonneg (hlam_nonneg i) (sub_nonneg.mpr (hle i))
      · rw [h_outside i hi]
        simp
    have hzeroAll :=
      (Finset.sum_eq_zero_iff_of_nonneg htermNonneg).mp hsumTerms
    have hprod_zero : lam i0 * (b.val i0 - avg) = 0 :=
      hzeroAll i0 (Finset.mem_univ i0)
    have hdiff_zero : b.val i0 - avg = 0 := by
      rcases mul_eq_zero.mp hprod_zero with hlam0 | hdiff
      · have hpos := h_pos_on_I i0 hi0
        linarith
      · exact hdiff
    linarith

  have h_eq_of_le_avg :
      ∀ (b : WTABelief) (avg : ℝ),
        avg = (∑ i : WTAΩ, lam i * b.val i) →
        (∀ k : WTAΩ, b.val k ≤ avg) →
        ∀ i0 : WTAΩ, i0 ∈ I → b.val i0 = avg := by
    intro b avg havg hle i0 hi0
    have hsumTerms : ∑ i : WTAΩ, lam i * (avg - b.val i) = 0 := by
      calc
        ∑ i : WTAΩ, lam i * (avg - b.val i)
            = (∑ i : WTAΩ, lam i) * avg - (∑ i : WTAΩ, lam i * b.val i) := by
                simp_rw [mul_sub]
                rw [Finset.sum_sub_distrib, ← Finset.sum_mul]
        _ = 1 * avg - avg := by
                rw [hlam_sum, ← havg]
        _ = 0 := by ring
    have htermNonneg :
        ∀ i ∈ (Finset.univ : Finset WTAΩ), 0 ≤ lam i * (avg - b.val i) := by
      intro i _
      by_cases hi : i ∈ I
      · exact mul_nonneg (hlam_nonneg i) (sub_nonneg.mpr (hle i))
      · rw [h_outside i hi]
        simp
    have hzeroAll :=
      (Finset.sum_eq_zero_iff_of_nonneg htermNonneg).mp hsumTerms
    have hprod_zero : lam i0 * (avg - b.val i0) = 0 :=
      hzeroAll i0 (Finset.mem_univ i0)
    have hdiff_zero : avg - b.val i0 = 0 := by
      rcases mul_eq_zero.mp hprod_zero with hlam0 | hdiff
      · have hpos := h_pos_on_I i0 hi0
        linarith
      · exact hdiff
    linarith

  have h_avg_le_from_K :
      ∀ (b : WTABelief),
        (∀ i : WTAΩ, i ∈ I → ∀ k : WTAΩ, b.val i ≤ b.val k) →
        ∀ k : WTAΩ, (∑ i : WTAΩ, lam i * b.val i) ≤ b.val k := by
    intro b hK k
    have hterm_le :
        ∀ i ∈ (Finset.univ : Finset WTAΩ),
          lam i * b.val i ≤ lam i * b.val k := by
      intro i _
      by_cases hi : i ∈ I
      · exact mul_le_mul_of_nonneg_left (hK i hi k) (hlam_nonneg i)
      · rw [h_outside i hi]
        simp
    have hsum_le :=
      Finset.sum_le_sum hterm_le
    have hright : ∑ i : WTAΩ, lam i * b.val k = b.val k := by
      calc
        ∑ i : WTAΩ, lam i * b.val k = (∑ i : WTAΩ, lam i) * b.val k := by
          rw [← Finset.sum_mul]
        _ = 1 * b.val k := by
          rw [hlam_sum]
        _ = b.val k := by ring
    calc
      (∑ i : WTAΩ, lam i * b.val i) ≤ ∑ i : WTAΩ, lam i * b.val k := hsum_le
      _ = b.val k := hright

  have h_le_avg_from_B :
      ∀ (b : WTABelief),
        (∀ i : WTAΩ, i ∈ I → ∀ k : WTAΩ, b.val k ≤ b.val i) →
        ∀ k : WTAΩ, b.val k ≤ (∑ i : WTAΩ, lam i * b.val i) := by
    intro b hB k
    have hterm_le :
        ∀ i ∈ (Finset.univ : Finset WTAΩ),
          lam i * b.val k ≤ lam i * b.val i := by
      intro i _
      by_cases hi : i ∈ I
      · exact mul_le_mul_of_nonneg_left (hB i hi k) (hlam_nonneg i)
      · rw [h_outside i hi]
        simp
    have hsum_le :=
      Finset.sum_le_sum hterm_le
    have hleft : ∑ i : WTAΩ, lam i * b.val k = b.val k := by
      calc
        ∑ i : WTAΩ, lam i * b.val k = (∑ i : WTAΩ, lam i) * b.val k := by
          rw [← Finset.sum_mul]
        _ = 1 * b.val k := by
          rw [hlam_sum]
        _ = b.val k := by ring
    calc
      b.val k = ∑ i : WTAΩ, lam i * b.val k := hleft.symm
      _ ≤ ∑ i : WTAΩ, lam i * b.val i := hsum_le

  constructor
  · constructor
    · intro hrow
      rcases hrow with ⟨_, hmin⟩
      have hsum_le :
          ∀ k : WTAΩ, (∑ j : WTAΩ, lam j * s.val j) ≤ s.val k := by
        intro k
        have hdot := hmin (WTA_vertex k) ⟨k, rfl⟩
        have hmix :=
          wta_payoff_dot_product_identity lam hlam_nonneg hlam_sum s
        rw [hmix, hvertex s k] at hdot
        linarith
      have heq_on_I :=
        h_eq_of_avg_le s (∑ j : WTAΩ, lam j * s.val j) rfl hsum_le
      change ∀ i : WTAΩ, i ∈ I → ∀ k : WTAΩ, s.val i ≤ s.val k
      intro i hi k
      calc
        s.val i = (∑ j : WTAΩ, lam j * s.val j) := heq_on_I i hi
        _ ≤ s.val k := hsum_le k
    · intro hsK
      change (∀ i : WTAΩ, i ∈ I → ∀ k : WTAΩ, s.val i ≤ s.val k) at hsK
      refine ⟨rfl, ?_⟩
      intro m' hm'
      rcases hm' with ⟨k, rfl⟩
      have hcoord := h_avg_le_from_K s hsK k
      have hmix :=
        wta_payoff_dot_product_identity lam hlam_nonneg hlam_sum s
      rw [hmix, hvertex s k]
      linarith
  · constructor
    · intro hbayes
      rcases hbayes with ⟨_, hmax⟩
      have hle_sum :
          ∀ k : WTAΩ, p.val k ≤ (∑ j : WTAΩ, lam j * p.val j) := by
        intro k
        have hdot := hmax (WTA_vertex k) ⟨k, rfl⟩
        have hmix :=
          wta_payoff_dot_product_identity lam hlam_nonneg hlam_sum p
        rw [hmix, hvertex p k] at hdot
        linarith
      have heq_on_I :=
        h_eq_of_le_avg p (∑ j : WTAΩ, lam j * p.val j) rfl hle_sum
      change ∀ i : WTAΩ, i ∈ I → ∀ k : WTAΩ, p.val k ≤ p.val i
      intro i hi k
      calc
        p.val k ≤ (∑ j : WTAΩ, lam j * p.val j) := hle_sum k
        _ = p.val i := (heq_on_I i hi).symm
    · intro hpB
      change (∀ i : WTAΩ, i ∈ I → ∀ k : WTAΩ, p.val k ≤ p.val i) at hpB
      refine ⟨rfl, ?_⟩
      intro m' hm'
      rcases hm' with ⟨k, rfl⟩
      have hcoord := h_le_avg_from_B p hpB k
      have hmix :=
        wta_payoff_dot_product_identity lam hlam_nonneg hlam_sum p
      rw [hmix, hvertex p k]
      linarith

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
  classical

  obtain ⟨i0, hi0⟩ := hI

  have hcoord_meas (j : WTAΩ) :
      Measurable (fun s : WTABelief => s.val j) := by
    exact (measurable_pi_apply j).comp measurable_subtype_coe

  have hcoord_Icc (s : WTABelief) (j : WTAΩ) :
      s.val j ∈ Set.Icc (0 : ℝ) 1 := by
    refine ⟨s.property.1 j, ?_⟩
    have hle : s.val j ≤ ∑ i : WTAΩ, s.val i :=
      Finset.single_le_sum (f := fun i => s.val i)
        (fun i _ => s.property.1 i) (Finset.mem_univ j)
    linarith [s.property.2]

  have hcoord_int (j : WTAΩ) :
      Integrable (fun s : WTABelief => s.val j) ρ := by
    refine Integrable.of_mem_Icc (μ := ρ) (a := (0 : ℝ)) (b := 1) ?_ ?_
    · exact (hcoord_meas j).aemeasurable
    · exact Filter.Eventually.of_forall (fun s => hcoord_Icc s j)

  have hK_eq :
      WTAKminus I =
        ⋂ i : WTAΩ, ⋂ (_ : i ∈ I), ⋂ k : WTAΩ,
          {s : WTABelief | s.val i ≤ s.val k} := by
    ext s
    simp [WTAKminus]

  have hK_meas : MeasurableSet (WTAKminus I) := by
    rw [hK_eq]
    refine MeasurableSet.iInter (fun i => ?_)
    refine MeasurableSet.iInter (fun _ => ?_)
    refine MeasurableSet.iInter (fun k => ?_)
    exact measurableSet_le (hcoord_meas i) (hcoord_meas k)

  have hKcomp : ρ (WTAKminus I)ᶜ = 0 := by
    rw [prob_compl_eq_zero_iff hK_meas]
    exact hρ_support

  have hKae : ∀ᵐ s ∂ρ, s ∈ WTAKminus I := by
    rw [ae_iff]
    change ρ (WTAKminus I)ᶜ = 0
    exact hKcomp

  have h_coord_eq (k : WTAΩ) : ∀ᵐ s ∂ρ, s.val k = s.val i0 := by
    have h_nonneg : ∀ᵐ s ∂ρ, 0 ≤ s.val k - s.val i0 := by
      filter_upwards [hKae] with s hs
      exact sub_nonneg.mpr (hs i0 hi0 k)

    have h_int_le :
        (∫ s : WTABelief, (s.val k - s.val i0) ∂ρ) ≤ 0 := by
      rw [integral_sub (hcoord_int k) (hcoord_int i0)]
      have hb : beliefBarycenter ρ k ≤ beliefBarycenter ρ i0 :=
        hbary i0 hi0 k
      simpa [beliefBarycenter] using sub_nonpos.mpr hb

    have h_int_nonneg :
        0 ≤ (∫ s : WTABelief, (s.val k - s.val i0) ∂ρ) :=
      integral_nonneg_of_ae h_nonneg

    have h_int_zero :
        (∫ s : WTABelief, (s.val k - s.val i0) ∂ρ) = 0 := by
      exact le_antisymm h_int_le h_int_nonneg

    have hdiff_int :
        Integrable (fun s : WTABelief => s.val k - s.val i0) ρ :=
      (hcoord_int k).sub (hcoord_int i0)

    have hzero :
        (fun s : WTABelief => s.val k - s.val i0) =ᵐ[ρ]
          (fun _ : WTABelief => (0 : ℝ)) := by
      exact (integral_eq_zero_iff_of_nonneg_ae h_nonneg hdiff_int).1 h_int_zero

    filter_upwards [hzero] with s hs
    linarith

  have h_allcoord : ∀ᵐ s ∂ρ, ∀ k : WTAΩ, s.val k = s.val i0 := by
    filter_upwards
      [h_coord_eq (0 : WTAΩ), h_coord_eq (1 : WTAΩ), h_coord_eq (2 : WTAΩ)]
      with s h0 h1 h2 k
    fin_cases k <;> assumption

  have h_ae_eq : ∀ᵐ s ∂ρ, s = wta.μ0 := by
    filter_upwards [h_allcoord] with s hs
    apply Subtype.ext
    funext k

    have hsum3 :
        s.val (0 : WTAΩ) + s.val (1 : WTAΩ) + s.val (2 : WTAΩ) = 1 := by
      simpa [WTAΩ, Fin.sum_univ_three] using s.property.2

    have h0 : s.val (0 : WTAΩ) = s.val i0 := hs 0
    have h1 : s.val (1 : WTAΩ) = s.val i0 := hs 1
    have h2 : s.val (2 : WTAΩ) = s.val i0 := hs 2

    have hi0_val : s.val i0 = (1 : ℝ) / 3 := by
      linarith

    calc
      s.val k = s.val i0 := hs k
      _ = (1 : ℝ) / 3 := hi0_val
      _ = wta.μ0.val k := (wta.μ0_coord k).symm

  have h_fun_ae :
      (fun s : WTABelief => s) =ᵐ[ρ] (fun _ : WTABelief => wta.μ0) :=
    h_ae_eq

  have hmap :
      Measure.map (fun s : WTABelief => s) ρ =
        Measure.map (fun _ : WTABelief => wta.μ0) ρ := by
    exact Measure.map_congr h_fun_ae

  simpa [Measure.map_const] using hmap

theorem dust_disintegration_over_subtype_N
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust) :
    flow.νN.map (fun p : WTABelief × NDust dust => (p.2, p.1)) =
      flow.qN.compProd flow.ρ := by
  exact?

theorem qN_supported_on_N
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust) :
    ∀ᵐ m ∂flow.qN, (m.val : WTABelief) ∈ dust.N := by
  aesop

theorem dust_rowwise_support_implies_cone_support
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hrow : RowwiseSupport wta dust flow) :
    ∀ᵐ m ∂flow.qN, flow.ρ m (WTAKminus (dust.I m)) = 1 := by
  classical

  let sw : WTABelief × NDust dust → NDust dust × WTABelief := fun p => (p.2, p.1)

  have hsw : Measurable sw := by
    dsimp [sw]
    measurability

  have hA :
      MeasurableSet
        {q : NDust dust × WTABelief | q.2 ∈ WTAKminus (dust.I q.1)} := by
    have hImp : ∀ i k : WTAΩ,
        MeasurableSet
          {q : NDust dust × WTABelief |
            0 < dust.lam q.1 i → q.2.val i ≤ q.2.val k} := by
      intro i k
      have hlam :
          Measurable (fun q : NDust dust × WTABelief => dust.lam q.1 i) :=
        (dust.lam_measurable i).comp measurable_fst
      have hnonpos :
          MeasurableSet
            {q : NDust dust × WTABelief | dust.lam q.1 i ≤ 0} :=
        measurableSet_le hlam measurable_const
      have hs_i :
          Measurable (fun q : NDust dust × WTABelief => q.2.val i) :=
        (measurable_pi_apply i).comp (measurable_subtype_coe.comp measurable_snd)
      have hs_k :
          Measurable (fun q : NDust dust × WTABelief => q.2.val k) :=
        (measurable_pi_apply k).comp (measurable_subtype_coe.comp measurable_snd)
      have hle :
          MeasurableSet
            {q : NDust dust × WTABelief | q.2.val i ≤ q.2.val k} :=
        measurableSet_le hs_i hs_k
      have hEqImp :
          {q : NDust dust × WTABelief |
              0 < dust.lam q.1 i → q.2.val i ≤ q.2.val k}
            =
          {q : NDust dust × WTABelief | dust.lam q.1 i ≤ 0} ∪
            {q : NDust dust × WTABelief | q.2.val i ≤ q.2.val k} := by
        ext q
        by_cases hpos : 0 < dust.lam q.1 i
        · have hnle : ¬ dust.lam q.1 i ≤ 0 := not_le_of_gt hpos
          simp [hpos, hnle]
        · have hle0 : dust.lam q.1 i ≤ 0 := le_of_not_gt hpos
          simp [hpos, hle0]
      rw [hEqImp]
      exact hnonpos.union hle

    have hInter :
        MeasurableSet
          (⋂ i : WTAΩ, ⋂ k : WTAΩ,
            {q : NDust dust × WTABelief |
              0 < dust.lam q.1 i → q.2.val i ≤ q.2.val k}) := by
      exact MeasurableSet.iInter fun i =>
        MeasurableSet.iInter fun k => hImp i k

    have hEqAll :
        {q : NDust dust × WTABelief |
          ∀ i : WTAΩ, 0 < dust.lam q.1 i →
            ∀ k : WTAΩ, q.2.val i ≤ q.2.val k}
          =
        (⋂ i : WTAΩ, ⋂ k : WTAΩ,
          {q : NDust dust × WTABelief |
            0 < dust.lam q.1 i → q.2.val i ≤ q.2.val k}) := by
      ext q
      simp only [Set.mem_setOf_eq, Set.mem_iInter]
      constructor
      · intro h i k hi
        exact h i hi k
      · intro h i hi k
        exact h i k hi

    have hAll :
        MeasurableSet
          {q : NDust dust × WTABelief |
            ∀ i : WTAΩ, 0 < dust.lam q.1 i →
              ∀ k : WTAΩ, q.2.val i ≤ q.2.val k} := by
      rw [hEqAll]
      exact hInter

    have hEqA :
        {q : NDust dust × WTABelief | q.2 ∈ WTAKminus (dust.I q.1)}
          =
        {q : NDust dust × WTABelief |
          ∀ i : WTAΩ, 0 < dust.lam q.1 i →
            ∀ k : WTAΩ, q.2.val i ≤ q.2.val k} := by
      ext q
      simp only [WTAKminus, Set.mem_setOf_eq]
      constructor
      · intro h i hpos k
        exact h i ((dust.lam_support_positive q.1 i).mpr hpos) k
      · intro h i hi k
        exact h i ((dust.lam_support_positive q.1 i).mp hi) k

    rw [hEqA]
    exact hAll

  have hmap :
      ∀ᵐ q ∂(flow.νN.map sw),
        q.2 ∈ WTAKminus (dust.I q.1) := by
    exact (MeasureTheory.ae_map_iff hsw.aemeasurable hA).2 <| by
      simpa [sw, RowwiseSupport] using hrow

  have hcomp :
      ∀ᵐ q ∂(flow.qN.compProd flow.ρ),
        q.2 ∈ WTAKminus (dust.I q.1) := by
    have hmap' :
        ∀ᵐ q ∂(flow.νN.map
          (fun p : WTABelief × NDust dust => (p.2, p.1))),
          q.2 ∈ WTAKminus (dust.I q.1) := by
      simpa [sw] using hmap
    rw [← flow.rho_disintegrates_nuN]
    exact hmap'

  by_cases hsf : SFinite flow.qN
  · haveI : SFinite flow.qN := hsf
    haveI : IsMarkovKernel flow.ρ := flow.ρ_markov

    have hfib :
        ∀ᵐ m ∂flow.qN, ∀ᵐ s ∂flow.ρ m,
          s ∈ WTAKminus (dust.I m) := by
      simpa using
        (Measure.ae_ae_of_ae_compProd
          (μ := flow.qN) (κ := flow.ρ)
          (p := fun q : NDust dust × WTABelief =>
            q.2 ∈ WTAKminus (dust.I q.1)) hcomp)

    filter_upwards [hfib] with m hm
    let K : Set WTABelief := WTAKminus (dust.I m)
    change flow.ρ m K = 1

    have hKc : flow.ρ m (Kᶜ) = 0 := by
      have h0 : flow.ρ m {s : WTABelief | ¬ s ∈ K} = 0 :=
        MeasureTheory.ae_iff.mp hm
      simpa [K] using h0

    have hprob_univ : flow.ρ m Set.univ = 1 :=
      (flow.ρ_prob m).measure_univ

    have huniv_le : flow.ρ m Set.univ ≤ flow.ρ m K + flow.ρ m (Kᶜ) := by
      calc
        flow.ρ m Set.univ = flow.ρ m (K ∪ Kᶜ) := by
          rw [Set.union_compl_self]
        _ ≤ flow.ρ m K + flow.ρ m (Kᶜ) :=
          MeasureTheory.measure_union_le (μ := flow.ρ m) K (Kᶜ)

    have hone_le : 1 ≤ flow.ρ m K := by
      calc
        1 = flow.ρ m Set.univ := hprob_univ.symm
        _ ≤ flow.ρ m K + flow.ρ m (Kᶜ) := huniv_le
        _ = flow.ρ m K := by simp [hKc]

    have hle_one : flow.ρ m K ≤ 1 := by
      calc
        flow.ρ m K ≤ flow.ρ m Set.univ :=
          MeasureTheory.measure_mono (μ := flow.ρ m) (Set.subset_univ K)
        _ = 1 := hprob_univ

    exact le_antisymm hle_one hone_le

  · have hcomp0 : flow.qN.compProd flow.ρ = 0 :=
      Measure.compProd_of_not_sfinite flow.qN flow.ρ hsf

    have hmap0' :
        flow.νN.map
          (fun p : WTABelief × NDust dust => (p.2, p.1)) = 0 := by
      rw [flow.rho_disintegrates_nuN, hcomp0]

    have hmap0 : flow.νN.map sw = 0 := by
      simpa [sw] using hmap0'

    have hν0 : flow.νN = 0 :=
      (Measure.map_eq_zero_iff hsw.aemeasurable).mp hmap0

    have hq0 : flow.qN = 0 := by
      rw [flow.qN_eq_marginal, hν0]
      simp

    simp [hq0]

theorem dust_Bayes_calibration_gives_cone_barycenter
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hcal : BayesConeCalibration wta dust flow) :
    ∀ᵐ m ∂flow.qN, beliefBarycenter (flow.ρ m) ∈ WTABconeProfile (dust.I m) := by
  aesop

theorem dust_conditional_sources_satisfy_cones
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hrow : RowwiseSupport wta dust flow)
    (hcal : BayesConeCalibration wta dust flow) :
    ∀ᵐ m ∂flow.qN,
      flow.ρ m (WTAKminus (dust.I m)) = 1 ∧
        beliefBarycenter (flow.ρ m) ∈ WTABconeProfile (dust.I m) := by
  filter_upwards [dust_rowwise_support_implies_cone_support wta dust flow hrow,
                  dust_Bayes_calibration_gives_cone_barycenter wta dust flow hcal] with m hrow_m hcal_m
  exact ⟨hrow_m, hcal_m⟩

theorem cone_intersection_applied_to_dust
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hrow : RowwiseSupport wta dust flow)
    (hcal : BayesConeCalibration wta dust flow) :
    ∀ᵐ m ∂flow.qN, flow.ρ m = Measure.dirac wta.μ0 := by
  filter_upwards [dust_conditional_sources_satisfy_cones wta dust flow hrow hcal] with m ⟨hsupp, hbary⟩
  haveI : IsProbabilityMeasure (flow.ρ m) := flow.ρ_prob m
  exact wta_cone_intersection wta (dust.I m) (dust.lam m)
    (Set.ext fun i => (dust.lam_support_positive m i).symm)
    (fun i hi => (dust.lam_support_positive m i).mp hi)
    (dust.lam_sum_one m)
    (dust.lam_support_nonempty m)
    (flow.ρ m) hsupp hbary

theorem positive_dust_mass_impossible_when_alpha_one
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hα : flow.α = 1) :
    ¬ WTAPositiveQMass wta flow.α dust.N flow.κ := by
  intro h
  simpa [WTAPositiveQMass, WTAMixtureMessageLaw, hα, dust.tau_null] using h

theorem dust_positive_mass_forces_mu0_atom
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hpos : WTAPositiveQMass wta flow.α dust.N flow.κ)
    (hα : flow.α < 1)
    (hdirac : ∀ᵐ m ∂flow.qN, flow.ρ m = Measure.dirac wta.μ0) :
    0 < wta.τ ({wta.μ0} : Set WTABelief) := by
  classical
  haveI : IsProbabilityMeasure wta.τ := wta.τ_prob
  haveI : IsMarkovKernel flow.κ := flow.κ_markov
  haveI : IsMarkovKernel flow.ρ := flow.ρ_markov

  let sndMass : Measure WTABelief :=
    (wta.τ.compProd flow.κ).map Prod.snd

  have hsμ0 : MeasurableSet ({wta.μ0} : Set WTABelief) :=
    measurableSet_singleton _
  have hsN : MeasurableSet dust.N := dust.measurable_N

  have hprod_pos :
      0 < ENNReal.ofReal (1 - flow.α) * sndMass dust.N := by
    have h := hpos
    dsimp [WTAPositiveQMass, WTAMixtureMessageLaw, sndMass] at h
    simpa [Measure.add_apply, Measure.smul_apply, smul_eq_mul,
      dust.tau_null, zero_add, mul_zero] using h

  have hsnd_pos : 0 < sndMass dust.N := by
    by_contra hnot
    have hzero : sndMass dust.N = 0 :=
      le_antisymm (le_of_not_gt hnot) (zero_le _)
    have : 0 < (0 : ENNReal) := by
      simpa [hzero] using hprod_pos
    exact (lt_irrefl (0 : ENNReal)) this

  let embed : WTABelief × NDust dust → WTABelief × WTABelief :=
    fun p => (p.1, (p.2 : WTABelief))
  let swap : WTABelief × NDust dust → NDust dust × WTABelief :=
    fun p => (p.2, p.1)

  have hembed_meas : Measurable embed := by
    dsimp [embed]
    refine Measurable.prod ?_ ?_
    · exact measurable_fst
    · exact measurable_subtype_coe.comp measurable_snd
  have hswap_meas : Measurable swap := by
    dsimp [swap]
    refine Measurable.prod ?_ ?_
    · exact measurable_snd
    · exact measurable_fst

  have hembed_map : flow.νN.map embed = flow.nuN_raw := by
    dsimp [embed]
    exact flow.nuN_subtype_pushforward
  have hswap_map : flow.νN.map swap = flow.qN.compProd flow.ρ := by
    dsimp [swap]
    exact flow.rho_disintegrates_nuN

  let dustCyl : Set (WTABelief × WTABelief) :=
    {p : WTABelief × WTABelief | p.2 ∈ dust.N}

  have hqN_univ_eq : flow.qN Set.univ = sndMass dust.N := by
    calc
      flow.qN Set.univ
          = (flow.νN.map Prod.snd) Set.univ := by
              rw [flow.qN_eq_marginal]
      _ = flow.νN Set.univ := by
              rw [Measure.map_apply_of_aemeasurable
                (measurable_snd.aemeasurable) MeasurableSet.univ]
              simp
      _ = (flow.νN.map embed) Set.univ := by
              rw [Measure.map_apply_of_aemeasurable
                (hembed_meas.aemeasurable) MeasurableSet.univ]
              simp
      _ = flow.nuN_raw Set.univ := by
              rw [hembed_map]
      _ = flow.ν dustCyl := by
              rw [flow.nuN_eq_restrict]
              rw [Measure.restrict_apply MeasurableSet.univ]
              simp [dustCyl]
      _ = (flow.ν.map Prod.snd) dust.N := by
              rw [Measure.map_apply_of_aemeasurable
                (measurable_snd.aemeasurable) hsN]
              rfl
      _ = sndMass dust.N := by
              rw [flow.nu_eq_compProd]

  have hqN_univ_pos : 0 < flow.qN Set.univ := by
    rwa [hqN_univ_eq]

  have h_sndMass_prob : IsProbabilityMeasure sndMass := by
    dsimp [sndMass]
    exact Measure.isProbabilityMeasure_map measurable_snd.aemeasurable
  haveI : IsProbabilityMeasure sndMass := h_sndMass_prob

  have hqN_univ_lt_top : flow.qN Set.univ < ⊤ := by
    rw [hqN_univ_eq]
    exact lt_of_le_of_lt
      (prob_le_one (μ := sndMass) (s := dust.N))
      (by simp)
  haveI : IsFiniteMeasure flow.qN := ⟨hqN_univ_lt_top⟩

  let target0 : Set (NDust dust × WTABelief) :=
    (Set.univ : Set (NDust dust)) ×ˢ ({wta.μ0} : Set WTABelief)
  let source0 : Set (WTABelief × NDust dust) :=
    ({wta.μ0} : Set WTABelief) ×ˢ (Set.univ : Set (NDust dust))

  have htarget0_meas : MeasurableSet target0 := by
    dsimp [target0]
    exact MeasurableSet.univ.prod hsμ0

  have hswap_pre : swap ⁻¹' target0 = source0 := by
    ext p
    simp [swap, target0, source0]

  have hcomp_target0 :
      (flow.qN.compProd flow.ρ) target0 = flow.qN Set.univ := by
    dsimp [target0]
    rw [Measure.compProd_apply_prod MeasurableSet.univ hsμ0]
    have hρ_one :
        (fun m : NDust dust => flow.ρ m ({wta.μ0} : Set WTABelief))
          =ᵐ[flow.qN] (fun _ => (1 : ENNReal)) := by
      filter_upwards [hdirac] with m hm
      show flow.ρ m ({wta.μ0} : Set WTABelief) = 1
      rw [hm]
      simp
    calc
      ∫⁻ m in (Set.univ : Set (NDust dust)),
          flow.ρ m ({wta.μ0} : Set WTABelief) ∂flow.qN
          = ∫⁻ m,
              flow.ρ m ({wta.μ0} : Set WTABelief) ∂flow.qN := by
              simp
      _ = ∫⁻ _m : NDust dust, (1 : ENNReal) ∂flow.qN := by
              exact lintegral_congr_ae hρ_one
      _ = flow.qN Set.univ := by
              simp

  have hνN_source_eq_comp :
      flow.νN source0 = (flow.qN.compProd flow.ρ) target0 := by
    rw [← hswap_map]
    rw [Measure.map_apply_of_aemeasurable
      (hswap_meas.aemeasurable) htarget0_meas]
    rw [hswap_pre]

  have hνN_source_pos : 0 < flow.νN source0 := by
    rw [hνN_source_eq_comp, hcomp_target0]
    exact hqN_univ_pos

  let target0N : Set (WTABelief × WTABelief) :=
    ({wta.μ0} : Set WTABelief) ×ˢ dust.N
  let sourceBig : Set (WTABelief × WTABelief) :=
    ({wta.μ0} : Set WTABelief) ×ˢ (Set.univ : Set WTABelief)

  have htarget0N_meas : MeasurableSet target0N := by
    dsimp [target0N]
    exact hsμ0.prod hsN

  have hembed_pre : embed ⁻¹' target0N = source0 := by
    ext p
    simp only [embed, target0N, source0, Set.mem_preimage,
      Set.mem_prod, Set.mem_singleton_iff, Set.mem_univ, and_true]
    exact ⟨fun hp => hp.1, fun hp => ⟨hp, by simpa using p.2.property⟩⟩

  have hνN_source_eq_raw :
      flow.νN source0 = flow.nuN_raw target0N := by
    rw [← hembed_map]
    rw [Measure.map_apply_of_aemeasurable
      (hembed_meas.aemeasurable) htarget0N_meas]
    rw [hembed_pre]

  have hraw_le_tau :
      flow.nuN_raw target0N ≤ wta.τ ({wta.μ0} : Set WTABelief) := by
    have hsubset : target0N ∩ dustCyl ⊆ sourceBig := by
      intro p hp
      simp only [target0N, dustCyl, sourceBig, Set.mem_inter_iff,
        Set.mem_prod, Set.mem_singleton_iff, Set.mem_univ, and_true] at hp ⊢
      exact hp.1.1
    have hsourceBig :
        flow.ν sourceBig = wta.τ ({wta.μ0} : Set WTABelief) := by
      dsimp [sourceBig]
      rw [flow.nu_eq_compProd]
      rw [Measure.compProd_apply_prod hsμ0 MeasurableSet.univ]
      simp
    calc
      flow.nuN_raw target0N
          = (flow.ν.restrict dustCyl) target0N := by
              rw [flow.nuN_eq_restrict]
      _ = flow.ν (target0N ∩ dustCyl) := by
              rw [Measure.restrict_apply htarget0N_meas]
      _ ≤ flow.ν sourceBig := by
              exact measure_mono hsubset
      _ = wta.τ ({wta.μ0} : Set WTABelief) := hsourceBig

  have hraw_pos : 0 < flow.nuN_raw target0N := by
    rw [← hνN_source_eq_raw]
    exact hνN_source_pos

  exact lt_of_lt_of_le hraw_pos hraw_le_tau

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
  rintro ⟨dust, flow, hα_eq, hpos, hrow, hcal⟩
  have hpos' : WTAPositiveQMass wta flow.α dust.N flow.κ := hα_eq ▸ hpos
  have hcone := cone_intersection_applied_to_dust wta dust flow hrow hcal
  by_cases hα_eq1 : flow.α = 1
  · exact positive_dust_mass_impossible_when_alpha_one wta dust flow hα_eq1 hpos'
  · have hα_lt : flow.α < 1 := lt_of_le_of_ne flow.α_le_one hα_eq1
    have hatom : 0 < wta.τ ({wta.μ0} : Set WTABelief) :=
      dust_positive_mass_forces_mu0_atom wta dust flow hpos' hα_lt hcone
    haveI := sharp.noAtoms
    have hatomless : wta.τ ({wta.μ0} : Set WTABelief) = 0 := measure_singleton wta.μ0
    exact (lt_irrefl (0 : ℝ≥0∞)) (by rw [hatomless] at hatom; exact hatom)

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
  refine ⟨?_, ?_⟩
  · intro ρ hρprob hρsupp hρbary
    haveI : IsProbabilityMeasure ρ := hρprob
    let lam : WTAΩ → ℝ := fun i => if i = (0 : Fin 3) then 1 else 0
    have hsupp_eq : WTASupport lam = ({(0 : Fin 3)} : Set WTAΩ) := by
      ext i
      simp [WTASupport, lam]
      by_cases h : i = (0 : Fin 3) <;> simp [h]
    have hpos : ∀ i : WTAΩ, i ∈ ({(0 : Fin 3)} : Set WTAΩ) → 0 < lam i := by
      intro i hi
      simp [Set.mem_singleton_iff] at hi
      simp [lam, hi]
    have hsum : ∑ i : WTAΩ, lam i = 1 := by
      simp [lam, Fin.sum_univ_three]
    have hI_ne : ({(0 : Fin 3)} : Set WTAΩ).Nonempty := ⟨(0 : Fin 3), rfl⟩
    exact wta_cone_intersection wta ({(0 : Fin 3)} : Set WTAΩ) lam hsupp_eq hpos hsum hI_ne ρ hρsupp hρbary
  · exact wta_no_free_dust wta sharp α hα0 hα1

theorem halfspace_contains_beliefs_inducing_all_vertices :
    ContainsBeliefsForAllVertices HalfspaceTrustRegion := by
  intro i
  fin_cases i
  · refine ⟨⟨![(2 : ℝ) / 5, (2 : ℝ) / 5, (1 : ℝ) / 5], ?_⟩, ?_⟩
    · constructor
      · intro ω
        fin_cases ω <;> simp <;> norm_num
      · simp [Fin.sum_univ_three] <;> norm_num
    · constructor
      · simp [HalfspaceTrustRegion] <;> norm_num
      · intro k
        fin_cases k <;> simp <;> norm_num
  · refine ⟨⟨![(1 : ℝ) / 3, (1 : ℝ) / 3, (1 : ℝ) / 3], ?_⟩, ?_⟩
    · constructor
      · intro ω
        fin_cases ω <;> simp <;> norm_num
      · simp [Fin.sum_univ_three] <;> norm_num
    · constructor
      · simp [HalfspaceTrustRegion] <;> norm_num
      · intro k
        fin_cases k <;> simp <;> norm_num
  · refine ⟨⟨![(0 : ℝ), (0 : ℝ), (1 : ℝ)], ?_⟩, ?_⟩
    · constructor
      · intro ω
        fin_cases ω <;> simp <;> norm_num
      · simp [Fin.sum_univ_three] <;> norm_num
    · constructor
      · simp [HalfspaceTrustRegion] <;> norm_num
      · intro k
        fin_cases k <;> simp <;> norm_num

theorem halfspace_induced_effective_menu_equals_full_vertices :
    InducedEffectiveMenu HalfspaceTrustRegion = FullWTAVertexMenu := by
  ext v
  constructor
  · rintro ⟨i, rfl, _⟩
    exact ⟨i, rfl⟩
  · rintro ⟨i, rfl⟩
    rcases halfspace_contains_beliefs_inducing_all_vertices i with
      ⟨μ, hμ_mem, hμ_induces⟩
    exact ⟨i, rfl, ⟨μ, hμ_mem, hμ_induces⟩⟩

theorem halfspace_behavior_equivalent_to_full_simplex :
    BehaviorEquivalentTrustRegion HalfspaceTrustRegion FullSimplexTrustRegion := by
  unfold BehaviorEquivalentTrustRegion
  rw [halfspace_induced_effective_menu_equals_full_vertices]
  symm
  ext v
  constructor
  · rintro ⟨i, hvi, _⟩
    exact ⟨i, hvi.symm⟩
  · intro hv
    have hvH : v ∈ InducedEffectiveMenu HalfspaceTrustRegion := by
      rw [halfspace_induced_effective_menu_equals_full_vertices]
      exact hv
    rcases hvH with ⟨i, hvi, μ, _hμH, hInd⟩
    exact ⟨i, hvi, μ, by simp [FullSimplexTrustRegion], hInd⟩

theorem halfspace_witness_menu_engine_artifact :
    HalfspaceWitnessStatement :=
  ⟨halfspace_contains_beliefs_inducing_all_vertices,
   halfspace_induced_effective_menu_equals_full_vertices,
   halfspace_behavior_equivalent_to_full_simplex⟩

/-! ## Main theorem package -/

theorem robust_trust_infinite_extension_v8_package
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model)
    (msupp : MessageSupportM model)
    (bridge : MessageRestrictionBridge model msupp)
    (prs : ProfileRealizationSetup model) :
    RobustTrustInfiniteExtensionV8Package model plc msupp bridge prs := by
  obtain ⟨σstar, h_tier1a⟩ :=
    tier1a_value_optimality_and_epsilon_adversary model plc msupp bridge prs
  refine ⟨σstar, h_tier1a, ?_, ?_, ?_, ?_, ?_⟩
  · intro ec
    exact tier1b_exact_adversary_under_exact_contact
      model plc msupp bridge prs σstar h_tier1a.1 ec
  · intro pd ec κ mh
    exact tier2_qae_robust_rationalizability_under_menu_Hall
      model plc prs pd σstar h_tier1a.1 ec κ mh
  · -- WTA_ConeIntersectionStatement
    intro wta I lam hsupp hpos hsum hI ρ hρprob hρsupp hρbary
    haveI := hρprob
    exact wta_cone_intersection wta I lam hsupp hpos hsum hI ρ hρsupp hρbary
  · -- WTA_NoFreeDustStatement
    intro wta sharp α hα0 hα1
    exact wta_no_free_dust wta sharp α hα0 hα1
  · -- HalfspaceWitnessStatement
    exact halfspace_witness_menu_engine_artifact

end

end RobustTrustV8
