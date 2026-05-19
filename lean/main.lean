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
  sorry

theorem compact_menu_space_compact
    (model : RobustTrustModel)
    (prs : ProfileRealizationSetup model) :
    CompactSpace (CompactMenu model) := by
  haveI : CompactSpace (ProfileInW model) := by
    simpa [ProfileInW] using (isCompact_iff_compactSpace.mp prs.W_compact)
  change CompactSpace (TopologicalSpace.NonemptyCompacts (ProfileInW model))
  infer_instance

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
  sorry

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
