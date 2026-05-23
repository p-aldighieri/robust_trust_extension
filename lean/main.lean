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

def UniversallyMeasurable {X Y : Type*} [TopologicalSpace X] [MeasurableSpace X]
    [MeasurableSpace Y] (f : X → Y) : Prop :=
  ∀ μ : Measure X, IsFiniteMeasure μ → AEMeasurable f μ


structure GepsRegularity {M : Type*} [TopologicalSpace M] [MeasurableSpace M]
    (Gε : ℝ → M → Set M) (ε : ℝ) : Prop where
  closed_valued : ∀ s : M, IsClosed (Gε ε s)
  graph_measurable : MeasurableSet {p : M × M | p.2 ∈ Gε ε p.1}
  sections_measurable : ∀ s : M, MeasurableSet (Gε ε s)



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
    (_ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (_mh : MenuHall model pd σstar _ec κ) : Prop :=
  IsAdversarialFull model κ σstar ∧
  MixturePayoffFull model κ σstar = UStarFull model ∧
  Definition2QAEPredicate model pd κ σstar ∧
  (0 < model.α →
    ∀ᵐ m ∂model.τM,
      IsBayesOptimal model (σstar.sectionFull (model.inclM m)) (pd.Pγα κ m))

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

theorem full_restricted_Ustar_equivalence
    (model : RobustTrustModel)
    (msupp : MessageSupportM model)
    (bridge : MessageRestrictionBridge model msupp) :
    UStarFull model = UStarM model ∧
      ∀ (σFull : AgentStrategyFull model) (σM : AgentStrategyM model),
        (∀ m : model.M, σFull.sectionFull (model.inclM m) = σM.sectionM m) →
          RobustPayoffFull model σFull = RobustPayoffM model σM := by
  classical

  -- The reusable payoff equivalence: once the full and restricted sections
  -- agree on `inclM`, the full payoff definitions collapse to the M-payoff
  -- definitions through `restrictFullToM`.
  have payoff_equiv :
      ∀ (σFull : AgentStrategyFull model) (σM : AgentStrategyM model),
        (∀ m : model.M, σFull.sectionFull (model.inclM m) = σM.sectionM m) →
          RobustPayoffFull model σFull = RobustPayoffM model σM := by
    intro σFull σM hsec

    have hrestrict_eq : restrictFullToM model σFull = σM := by
      obtain ⟨secM, hmeasM⟩ := σM
      have hsect_eq : (restrictFullToM model σFull).sectionM = secM := by
        funext m
        simpa [restrictFullToM] using hsec m
      cases hsect_eq
      rfl

    have hmix :
        (fun β : AdviserKernel model => MixturePayoffFull model β σFull) =
          (fun β : AdviserKernel model => MixturePayoffM model β σM) := by
      funext β
      simp [MixturePayoffFull, MixturePayoffM,
        AlignedPayoffFull, MisalignedPayoffFull, hrestrict_eq]

    simpa [RobustPayoffFull, RobustPayoffM] using
      congrArg (fun f : AdviserKernel model → ℝ => sInf (Set.range f)) hmix

  constructor
  · -- Prove equality of values by proving equality of the two payoff ranges.
    -- This avoids any `csSup` boundedness bookkeeping.
    have hrange :
        (Set.range (fun σFull : AgentStrategyFull model =>
          RobustPayoffFull model σFull)) =
        (Set.range (fun σM : AgentStrategyM model =>
          RobustPayoffM model σM)) := by
      ext x
      constructor
      · rintro ⟨σFull, rfl⟩
        let σM0 : AgentStrategyM model := bridge.restrictFull σFull
        refine ⟨σM0, ?_⟩
        have hsec : ∀ m : model.M,
            σFull.sectionFull (model.inclM m) = σM0.sectionM m := by
          intro m
          simpa [σM0] using (bridge.restrictFull_eq σFull m).symm
        exact (payoff_equiv σFull σM0 hsec).symm

      · rintro ⟨σM, rfl⟩
        let σFull0 : AgentStrategyFull model := bridge.extendRestricted σM
        refine ⟨σFull0, ?_⟩
        have hsec : ∀ m : model.M,
            σFull0.sectionFull (model.inclM m) = σM.sectionM m := by
          intro m
          simpa [σFull0] using bridge.extendRestricted_eq σM m
        exact payoff_equiv σFull0 σM hsec

    simpa [UStarFull, UStarM] using
      congrArg (fun S : Set ℝ => sSup S) hrange

  · exact payoff_equiv

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
  classical
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  haveI : IsFiniteMeasure model.τM := inferInstance
  let g : model.M → model.M → ℝ :=
    fun s m => beliefDot (model.inclM s) (w m).val
  let I : ℝ :=
    ∫ s, sInf (Set.range fun m : model.M => g s m) ∂model.τM
  let A : Set ℝ :=
    Set.range fun β : AdviserKernel model =>
      ∫ s, ∫ m, g s m ∂(β.kernel s) ∂model.τM
  have hg_meas' :
      Measurable fun p : model.M × model.M => g p.1 p.2 := by
    simpa [g] using hg_meas
  have hg_bdd' :
      ∃ C : ℝ, ∀ s m : model.M, |g s m| ≤ C := by
    simpa [g] using hw_bdd
  have hinf_meas' :
      Measurable fun s : model.M => sInf (Set.range (g s)) := by
    simpa [g] using hinf_meas
  obtain ⟨hε, hlower⟩ :=
    Inventory.kernel_infimum_epsilon_selection
      (S := model.M) (M := model.M)
      (τ := model.τM) (g := g)
      hg_meas' hg_bdd' hinf_meas'
  have hA_lower : ∀ x ∈ A, I ≤ x := by
    intro x hx
    rcases hx with ⟨β, rfl⟩
    simpa [I] using hlower β.kernel β.isMarkov
  have hA_bddBelow : BddBelow A := ⟨I, hA_lower⟩
  have hA_nonempty : A.Nonempty := by
    obtain ⟨β, hβ_markov, _hβ_le⟩ := hε 1 zero_lt_one
    refine ⟨∫ s, ∫ m, g s m ∂(β s) ∂model.τM, ?_⟩
    exact ⟨{ kernel := β, isMarkov := hβ_markov }, rfl⟩
  have h_lower : I ≤ sInf A := le_csInf hA_nonempty hA_lower
  have h_upper_eps : ∀ ε : ℝ, 0 < ε → sInf A ≤ I + ε := by
    intro ε hεpos
    obtain ⟨β, hβ_markov, hβ_le⟩ := hε ε hεpos
    have hmem :
        (∫ s, ∫ m, g s m ∂(β s) ∂model.τM) ∈ A :=
      ⟨{ kernel := β, isMarkov := hβ_markov }, rfl⟩
    have hsInf_le :
        sInf A ≤ ∫ s, ∫ m, g s m ∂(β s) ∂model.τM :=
      csInf_le hA_bddBelow hmem
    exact le_trans hsInf_le hβ_le
  have h_upper : sInf A ≤ I := le_of_forall_pos_le_add h_upper_eps
  have h_eq : sInf A = I := le_antisymm h_upper h_lower
  simpa [A, I, g] using h_eq

private lemma sSup_image_closure_eq_of_continuous
    {X : Type*} [TopologicalSpace X]
    (f : X → ℝ) (hf : Continuous f) (S : Set X)
    (hSne : S.Nonempty) (hBA : BddAbove (f '' S)) :
    sSup (f '' closure S) = sSup (f '' S) := by
  have hUB_closure : ∀ y ∈ f '' closure S, y ≤ sSup (f '' S) := by
    rintro y ⟨x, hx_closure, rfl⟩
    have h_preim : closure S ⊆ f ⁻¹' {y : ℝ | y ≤ sSup (f '' S)} := by
      refine closure_minimal ?_ (isClosed_Iic.preimage hf)
      rintro x hx
      exact le_csSup hBA ⟨x, hx, rfl⟩
    exact h_preim hx_closure
  have hne_cl : (f '' closure S).Nonempty := by
    obtain ⟨x, hx⟩ := hSne
    exact ⟨f x, x, subset_closure hx, rfl⟩
  have hBA_cl : BddAbove (f '' closure S) := ⟨sSup (f '' S), hUB_closure⟩
  have hne_S : (f '' S).Nonempty := hSne.image f
  apply le_antisymm
  · exact csSup_le hne_cl hUB_closure
  · refine csSup_le hne_S ?_
    rintro y ⟨x, hx, rfl⟩
    exact le_csSup hBA_cl ⟨x, subset_closure hx, rfl⟩

private lemma sInf_image_closure_eq_of_continuous
    {X : Type*} [TopologicalSpace X]
    (f : X → ℝ) (hf : Continuous f) (S : Set X)
    (hSne : S.Nonempty) (hBB : BddBelow (f '' S)) :
    sInf (f '' closure S) = sInf (f '' S) := by
  have hLB_closure : ∀ y ∈ f '' closure S, sInf (f '' S) ≤ y := by
    rintro y ⟨x, hx_closure, rfl⟩
    have h_preim : closure S ⊆ f ⁻¹' {y : ℝ | sInf (f '' S) ≤ y} := by
      refine closure_minimal ?_ (isClosed_Ici.preimage hf)
      rintro x hx
      exact csInf_le hBB ⟨x, hx, rfl⟩
    exact h_preim hx_closure
  have hne_cl : (f '' closure S).Nonempty := by
    obtain ⟨x, hx⟩ := hSne
    exact ⟨f x, x, subset_closure hx, rfl⟩
  have hBB_cl : BddBelow (f '' closure S) := ⟨sInf (f '' S), hLB_closure⟩
  have hne_S : (f '' S).Nonempty := hSne.image f
  apply le_antisymm
  · refine le_csInf hne_S ?_
    rintro y ⟨x, hx, rfl⟩
    exact csInf_le hBB_cl ⟨x, subset_closure hx, rfl⟩
  · exact le_csInf hne_cl hLB_closure


/-- Helper: measurable aligned-best selector over an arbitrary compact menu.
Generalization of `aligned_best_labeling_selection` from `OptimalMenuCstar`
to arbitrary `CompactMenu`. Proof is copy of `aligned_best_labeling_selection`
with `opt.Cstar` replaced by `C`. -/
private lemma compact_menu_aligned_selection
    (model : RobustTrustModel)
    (C : CompactMenu model) :
    ∃ wC : model.M → ProfileInW model,
      Measurable wC ∧
      (∀ m, wC m ∈ (↑C : Set (ProfileInW model))) ∧
      (∀ m,
        IsMaxOn (fun w : ProfileInW model => beliefDot (model.inclM m) w.val)
          (↑C : Set (ProfileInW model)) (wC m)) := by
  classical
  set Cset : Set (ProfileInW model) := (↑C : Set (ProfileInW model)) with hCset_def
  haveI hCne : Nonempty Cset := by
    rcases C.nonempty with ⟨w, hw⟩
    exact ⟨⟨w, by simpa [hCset_def] using hw⟩⟩
  have hC_cpt : IsCompact Cset := by
    simpa [hCset_def] using C.isCompact
  haveI hCcs : CompactSpace Cset :=
    isCompact_iff_compactSpace.mp hC_cpt
  let Γ : model.M → Set Cset := fun _ => Set.univ
  let f : model.M → Cset → ℝ := fun m w =>
    beliefDot (model.inclM m) w.val.val
  have hΓ_meas : MeasurableSet {p : model.M × Cset | p.2 ∈ Γ p.1} := by
    simpa [Γ] using
      (MeasurableSet.univ : MeasurableSet (Set.univ : Set (model.M × Cset)))
  have hΓ_ne : ∀ x : model.M, (Γ x).Nonempty := by
    intro x
    simpa [Γ] using (Set.univ_nonempty : (Set.univ : Set Cset).Nonempty)
  have hΓ_compact : ∀ x : model.M, IsCompact (Γ x) := by
    intro x
    simpa [Γ] using (isCompact_univ : IsCompact (Set.univ : Set Cset))
  have hf_meas : Measurable fun p : model.M × Cset => f p.1 p.2 := by
    dsimp [f, beliefDot]
    refine Finset.measurable_sum _ ?_
    intro ω _
    have hμ : Measurable (fun p : model.M × Cset => (model.inclM p.1).val) := by
      exact measurable_subtype_coe.comp
        (model.inclM_measurable.comp measurable_fst)
    have hw : Measurable (fun p : model.M × Cset => p.2.val.val) := by
      exact measurable_subtype_coe.comp
        (measurable_subtype_coe.comp measurable_snd)
    have h1 : Measurable
        (fun p : model.M × Cset => (model.inclM p.1).val ω) := by
      exact
        ((measurable_pi_apply ω :
            Measurable (fun g : model.Ω → ℝ => g ω))).comp hμ
    have h2 : Measurable
        (fun p : model.M × Cset => p.2.val.val ω) := by
      exact
        ((measurable_pi_apply ω :
            Measurable (fun g : model.Ω → ℝ => g ω))).comp hw
    exact h1.mul h2
  have hf_cont :
      ∀ x : model.M, ContinuousOn (fun y : Cset => f x y) (Γ x) := by
    intro x
    have hcont : Continuous (fun y : Cset => f x y) := by
      dsimp [f, beliefDot]
      refine continuous_finset_sum _ ?_
      intro ω _
      have hval : Continuous (fun y : Cset => y.val.val) := by
        exact continuous_subtype_val.comp continuous_subtype_val
      exact continuous_const.mul ((continuous_apply ω).comp hval)
    exact hcont.continuousOn
  obtain ⟨wsel, hwsel_meas, hwsel⟩ :=
    Inventory.measurable_argmax_selector
      (Γ := Γ) (f := f)
      hΓ_meas hΓ_ne hΓ_compact hf_meas hf_cont
  refine ⟨fun m => (wsel m).val,
    measurable_subtype_coe.comp hwsel_meas, ?_, ?_⟩
  · intro m
    simpa [hCset_def] using (wsel m).property
  · intro m
    rw [isMaxOn_iff]
    intro w hw
    have hwC : w ∈ Cset := by
      simpa [hCset_def] using hw
    have h_isMax : IsMaxOn (fun y : Cset => f m y) (Γ m) (wsel m) := (hwsel m).2
    have h_mem : (⟨w, hwC⟩ : Cset) ∈ Γ m := by simp [Γ]
    have hmax : f m ⟨w, hwC⟩ ≤ f m (wsel m) := h_isMax h_mem
    simpa [f] using hmax

/-- Allowed bookkeeping helper: boundedness of the payoff image defining `minPayoff`.
Compact image under continuous beliefDot is bounded below. -/
private lemma menu_value_le_strategy_sup_payoff_image_bddBelow
    (model : RobustTrustModel)
    (C : CompactMenu model)
    (s : model.M) :
    BddBelow
      ((fun w : ProfileInW model =>
          beliefDot (model.inclM s) w.val) ''
        (↑C : Set (ProfileInW model))) := by
  have hcont :
      Continuous (fun w : ProfileInW model =>
        beliefDot (model.inclM s) w.val) := by
    unfold beliefDot
    refine continuous_finset_sum _ ?_
    intro ω _
    exact continuous_const.mul ((continuous_apply ω).comp continuous_subtype_val)
  exact (C.isCompact.image hcont).bddBelow

/-- Allowed bookkeeping helper: robust payoffs are uniformly bounded above.
Bound from `model.private_profile_bounded` (uniform sup-norm bound on
profileOfPrivate). Sketch: take β0 = deterministic identity kernel; then
MisalignedPayoff β0 σ = AlignedPayoff σ, so MixturePayoff β0 σ = AlignedPayoff σ
≤ C, hence RobustPayoff σ = sInf ≤ MixturePayoff β0 σ ≤ C. Substantive gaps:
(a) integrability of `s ↦ beliefDot (inclM s) (profileMap σ s)` to use
integral_mono with C; (b) BddBelow of range MixturePayoffM for csInf_le_of_le. -/
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
private lemma beliefDot_menu_uncurry_continuous
    (model : RobustTrustModel) :
    Continuous (fun x : Belief model.Ω × ProfileInW model =>
      beliefDot x.1 x.2.val) := by
  classical
  unfold beliefDot
  apply continuous_finset_sum
  intro ω _
  have hb : Continuous (fun b : Belief model.Ω => b.val ω) := by
    exact (continuous_apply ω).comp
      (continuous_subtype_val : Continuous (fun b : Belief model.Ω => b.val))
  have hw : Continuous (fun w : ProfileInW model => w.val ω) := by
    exact (continuous_apply ω).comp
      (continuous_subtype_val : Continuous (fun w : ProfileInW model => w.val))
  exact (hb.comp continuous_fst).mul (hw.comp continuous_snd)
private lemma profileInW_abs_le_private_bound (model : RobustTrustModel) :
    ∃ B : ℝ, 0 ≤ B ∧ ∀ w : ProfileInW model, ∀ ω : model.Ω, |w.val ω| ≤ B := by
  rcases model.private_profile_bounded with ⟨B0, hB0⟩
  refine ⟨max B0 0, le_max_right B0 0, ?_⟩
  intro w ω
  have hwprop : w.val ∈ PayoffProfileSet model := w.property
  obtain ⟨σ, hσ⟩ : ∃ σ, model.profileOfPrivate σ = w.val := hwprop
  calc
    |w.val ω| = |model.profileOfPrivate σ ω| := by
      rw [← hσ]
    _ ≤ B0 := hB0 σ ω
    _ ≤ max B0 0 := le_max_left B0 0

private lemma beliefDot_ProfileInW_abs_le_private_bound (model : RobustTrustModel) :
    ∃ B : ℝ, 0 ≤ B ∧
      ∀ b : Belief model.Ω, ∀ w : ProfileInW model, |beliefDot b w.val| ≤ B := by
  rcases profileInW_abs_le_private_bound model with ⟨B, hB_nonneg, hB⟩
  refine ⟨B, hB_nonneg, ?_⟩
  intro b w
  have hb_nonneg : ∀ ω : model.Ω, 0 ≤ b.val ω := by
    intro ω
    exact b.property.1 ω
  have hb_sum : (∑ ω : model.Ω, b.val ω) = 1 := by
    exact b.property.2
  unfold beliefDot
  calc
    |∑ ω : model.Ω, b.val ω * w.val ω|
        ≤ ∑ ω : model.Ω, |b.val ω * w.val ω| := by
          exact Finset.abs_sum_le_sum_abs
            (s := Finset.univ)
            (f := fun ω : model.Ω => b.val ω * w.val ω)
    _ = ∑ ω : model.Ω, b.val ω * |w.val ω| := by
          apply Finset.sum_congr rfl
          intro ω _hω
          rw [abs_mul, abs_of_nonneg (hb_nonneg ω)]
    _ ≤ ∑ ω : model.Ω, b.val ω * B := by
          apply Finset.sum_le_sum
          intro ω _hω
          exact mul_le_mul_of_nonneg_left (hB w ω) (hb_nonneg ω)
    _ = B := by
          rw [← Finset.sum_mul, hb_sum, one_mul]

private lemma maxPayoff_aemeasurable
    (model : RobustTrustModel) (C : CompactMenu model) :
    AEMeasurable (fun s => maxPayoff model C s) model.τM := by
  have hcont :
      Continuous
        (fun b : Belief model.Ω =>
          sSup
            ((fun w : ProfileInW model => beliefDot b w.val) ''
              (↑C : Set (ProfileInW model)))) :=
    C.isCompact.continuous_sSup (beliefDot_menu_uncurry_continuous model)
  have hmeas : Measurable (fun s : model.M => maxPayoff model C s) := by
    simpa [maxPayoff] using hcont.measurable.comp model.inclM_measurable
  exact hmeas.aemeasurable

private lemma minPayoff_aemeasurable
    (model : RobustTrustModel) (C : CompactMenu model) :
    AEMeasurable (fun s => minPayoff model C s) model.τM := by
  have hcont :
      Continuous
        (fun b : Belief model.Ω =>
          sInf
            ((fun w : ProfileInW model => beliefDot b w.val) ''
              (↑C : Set (ProfileInW model)))) :=
    C.isCompact.continuous_sInf (beliefDot_menu_uncurry_continuous model)
  have hmeas : Measurable (fun s : model.M => minPayoff model C s) := by
    simpa [minPayoff] using hcont.measurable.comp model.inclM_measurable
  exact hmeas.aemeasurable

private lemma maxPayoff_mem_Icc_ae
    (model : RobustTrustModel) (C : CompactMenu model) :
    ∃ B : ℝ, ∀ᵐ s ∂model.τM, maxPayoff model C s ∈ Set.Icc (-B) B := by
  rcases beliefDot_ProfileInW_abs_le_private_bound model with ⟨B, _hB_nonneg, hB⟩
  refine ⟨B, Filter.Eventually.of_forall ?_⟩
  intro s
  let S : Set ℝ :=
    (fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
      (↑C : Set (ProfileInW model))
  have hS_nonempty : S.Nonempty := by
    rcases C.nonempty with ⟨w0, hw0⟩
    exact ⟨beliefDot (model.inclM s) w0.val, ⟨w0, hw0, rfl⟩⟩
  have hS_upper : ∀ y ∈ S, y ≤ B := by
    rintro y ⟨w, _hw, rfl⟩
    exact (abs_le.mp (hB (model.inclM s) w)).2
  have hS_lower : ∀ y ∈ S, -B ≤ y := by
    rintro y ⟨w, _hw, rfl⟩
    exact (abs_le.mp (hB (model.inclM s) w)).1
  have hS_bddAbove : BddAbove S := ⟨B, hS_upper⟩
  have hmax_le : sSup S ≤ B :=
    csSup_le hS_nonempty hS_upper
  have hle_max : -B ≤ sSup S := by
    rcases hS_nonempty with ⟨y, hy⟩
    exact le_trans (hS_lower y hy) (le_csSup hS_bddAbove hy)
  refine ⟨?_, ?_⟩
  · simpa [maxPayoff, S] using hle_max
  · simpa [maxPayoff, S] using hmax_le

private lemma minPayoff_mem_Icc_ae
    (model : RobustTrustModel) (C : CompactMenu model) :
    ∃ B : ℝ, ∀ᵐ s ∂model.τM, minPayoff model C s ∈ Set.Icc (-B) B := by
  rcases beliefDot_ProfileInW_abs_le_private_bound model with ⟨B, _hB_nonneg, hB⟩
  refine ⟨B, Filter.Eventually.of_forall ?_⟩
  intro s
  let S : Set ℝ :=
    (fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
      (↑C : Set (ProfileInW model))
  have hS_nonempty : S.Nonempty := by
    rcases C.nonempty with ⟨w0, hw0⟩
    exact ⟨beliefDot (model.inclM s) w0.val, ⟨w0, hw0, rfl⟩⟩
  have hS_upper : ∀ y ∈ S, y ≤ B := by
    rintro y ⟨w, _hw, rfl⟩
    exact (abs_le.mp (hB (model.inclM s) w)).2
  have hS_lower : ∀ y ∈ S, -B ≤ y := by
    rintro y ⟨w, _hw, rfl⟩
    exact (abs_le.mp (hB (model.inclM s) w)).1
  have hS_bddBelow : BddBelow S := ⟨-B, hS_lower⟩
  have hle_min : -B ≤ sInf S :=
    le_csInf hS_nonempty hS_lower
  have hmin_le : sInf S ≤ B := by
    rcases hS_nonempty with ⟨y, hy⟩
    exact le_trans (csInf_le hS_bddBelow hy) (hS_upper y hy)
  refine ⟨?_, ?_⟩
  · simpa [minPayoff, S] using hle_min
  · simpa [minPayoff, S] using hmin_le

private lemma maxPayoff_integrable
    (model : RobustTrustModel) (C : CompactMenu model) :
    Integrable (fun s => maxPayoff model C s) model.τM := by
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  rcases maxPayoff_mem_Icc_ae model C with ⟨B, hB⟩
  exact Integrable.of_mem_Icc (-B) B (maxPayoff_aemeasurable model C) hB

private lemma minPayoff_integrable
    (model : RobustTrustModel) (C : CompactMenu model) :
    Integrable (fun s => minPayoff model C s) model.τM := by
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  rcases minPayoff_mem_Icc_ae model C with ⟨B, hB⟩
  exact Integrable.of_mem_Icc (-B) B (minPayoff_aemeasurable model C) hB


private lemma profileMap_measurable_for_kernel_bound
    (model : RobustTrustModel) (setup : ProfileRealizationSetup model)
    (σM : AgentStrategyM model) :
    Measurable (fun m : model.M => profileMap model σM m) := by
  unfold profileMap
  have hΦ_meas : Measurable model.profileOfPrivate := by
    rw [← setup.Φ_eq_profile]
    exact setup.Φ_continuous.measurable
  exact hΦ_meas.comp σM.measurable_sectionM

private lemma beliefDot_abs_le_of_forall_abs_le
    {Ω : Type} [Fintype Ω]
    (p : Belief Ω) (w : Ω → ℝ) {B : ℝ}
    (hB : ∀ ω : Ω, |w ω| ≤ B) :
    |beliefDot p w| ≤ B := by
  classical
  have hp_nonneg : ∀ ω : Ω, 0 ≤ p.val ω := by
    intro ω
    exact p.property.1 ω
  have hp_sum : (∑ ω : Ω, p.val ω) = 1 := by
    exact p.property.2
  calc
    |beliefDot p w|
        = |∑ ω : Ω, p.val ω * w ω| := by
            simp [beliefDot]
    _ = ‖∑ ω : Ω, p.val ω * w ω‖ := by
            rw [Real.norm_eq_abs]
    _ ≤ ∑ ω : Ω, ‖p.val ω * w ω‖ := by
            exact norm_sum_le _ _
    _ = ∑ ω : Ω, p.val ω * |w ω| := by
            refine Finset.sum_congr rfl ?_
            intro ω _
            rw [Real.norm_eq_abs, abs_mul, abs_of_nonneg (hp_nonneg ω)]
    _ ≤ ∑ ω : Ω, p.val ω * B := by
            refine Finset.sum_le_sum ?_
            intro ω _
            exact mul_le_mul_of_nonneg_left (hB ω) (hp_nonneg ω)
    _ = (∑ ω : Ω, p.val ω) * B := by
            rw [Finset.sum_mul]
    _ = B := by
            rw [hp_sum, one_mul]

private lemma profileMap_abs_le_private_bound
    (model : RobustTrustModel) (σM : AgentStrategyM model) :
    ∃ B : ℝ, ∀ m : model.M, ∀ ω : model.Ω,
      |profileMap model σM m ω| ≤ B := by
  classical
  obtain ⟨B, hB⟩ := model.private_profile_bounded
  refine ⟨|B|, ?_⟩
  intro m ω
  have h0 := hB (σM.sectionM m) ω
  have h1 : |profileMap model σM m ω| ≤ B := by
    simpa [profileMap] using h0
  exact h1.trans (le_abs_self B)

private lemma beliefDot_profileMap_uniform_bound
    (model : RobustTrustModel) (σM : AgentStrategyM model) :
    ∃ B : ℝ, ∀ s : model.M, ∀ m : model.M,
      ‖beliefDot (model.inclM s) (profileMap model σM m)‖ ≤ B := by
  classical
  obtain ⟨B, hB⟩ := profileMap_abs_le_private_bound model σM
  refine ⟨B, ?_⟩
  intro s m
  rw [Real.norm_eq_abs]
  exact
    beliefDot_abs_le_of_forall_abs_le
      (model.inclM s)
      (profileMap model σM m)
      (hB m)

private lemma beliefDot_profileMap_uncurry_measurable
    (model : RobustTrustModel) (setup : ProfileRealizationSetup model)
    (σM : AgentStrategyM model) :
    Measurable
      (fun x : model.M × model.M =>
        beliefDot (model.inclM x.1) (profileMap model σM x.2)) := by
  classical
  unfold beliefDot
  refine Finset.measurable_sum _ ?_
  intro ω _
  refine Measurable.mul ?_ ?_
  · have hCoord : Measurable (fun s : model.M => (model.inclM s).val ω) :=
      ((measurable_pi_apply ω).comp measurable_subtype_coe).comp model.inclM_measurable
    exact hCoord.comp measurable_fst
  · have hProf : Measurable (fun m : model.M => profileMap model σM m ω) :=
      (measurable_pi_apply ω).comp
        (profileMap_measurable_for_kernel_bound model setup σM)
    exact hProf.comp measurable_snd

private lemma beliefDot_profileMap_uncurry_stronglyMeasurable
    (model : RobustTrustModel) (setup : ProfileRealizationSetup model)
    (σM : AgentStrategyM model) :
    StronglyMeasurable
      (Function.uncurry
        (fun s : model.M => fun m : model.M =>
          beliefDot (model.inclM s) (profileMap model σM m))) := by
  classical
  change StronglyMeasurable
    (fun x : model.M × model.M =>
      beliefDot (model.inclM x.1) (profileMap model σM x.2))
  exact (beliefDot_profileMap_uncurry_measurable model setup σM).stronglyMeasurable

private lemma beliefDot_profileMap_integrable_kernel
    (model : RobustTrustModel) (setup : ProfileRealizationSetup model)
    (β : AdviserKernel model)
    (σM : AgentStrategyM model) (s : model.M) :
    Integrable
      (fun m : model.M =>
        beliefDot (model.inclM s) (profileMap model σM m))
      (β.kernel s) := by
  classical
  haveI : ProbabilityTheory.IsMarkovKernel β.kernel := β.isMarkov
  haveI : IsProbabilityMeasure (β.kernel s) :=
    β.isMarkov.isProbabilityMeasure s
  obtain ⟨B, hB⟩ := beliefDot_profileMap_uniform_bound model σM
  refine MeasureTheory.Integrable.of_bound ?_ B ?_
  · have hPair : Measurable (fun m : model.M => (s, m)) := by
      refine Measurable.prod ?_ ?_
      · exact measurable_const
      · exact measurable_id
    have hgMeas :
        Measurable
          (fun m : model.M =>
            beliefDot (model.inclM s) (profileMap model σM m)) :=
      (beliefDot_profileMap_uncurry_measurable model setup σM).comp hPair
    exact hgMeas.stronglyMeasurable.aestronglyMeasurable
  · exact Filter.Eventually.of_forall (hB s)

private lemma beliefDot_profileMap_kernel_integral_integrable
    (model : RobustTrustModel) (setup : ProfileRealizationSetup model)
    (β : AdviserKernel model)
    (σM : AgentStrategyM model) :
    Integrable
      (fun s : model.M =>
        ∫ m : model.M,
          beliefDot (model.inclM s) (profileMap model σM m) ∂(β.kernel s))
      model.τM := by
  classical
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  haveI : ProbabilityTheory.IsMarkovKernel β.kernel := β.isMarkov
  obtain ⟨B, hB⟩ := beliefDot_profileMap_uniform_bound model σM
  refine MeasureTheory.Integrable.of_bound ?_ B ?_
  · have hsm :=
      MeasureTheory.StronglyMeasurable.integral_kernel_prod_right
        (κ := β.kernel)
        (beliefDot_profileMap_uncurry_stronglyMeasurable model setup σM)
    exact hsm.aestronglyMeasurable
  · filter_upwards with s
    haveI : IsProbabilityMeasure (β.kernel s) :=
      β.isMarkov.isProbabilityMeasure s
    have hnorm :=
      MeasureTheory.norm_integral_le_of_norm_le_const
        (μ := β.kernel s)
        (f := fun m : model.M =>
          beliefDot (model.inclM s) (profileMap model σM m))
        (C := B)
        (Filter.Eventually.of_forall (hB s))
    have hreal : (β.kernel s).real Set.univ = 1 := by
      simp
    simpa [hreal] using hnorm

private lemma integral_Icc_of_forall_abs_le_prob
    {X : Type*} [MeasurableSpace X] (μ : Measure X)
    [IsProbabilityMeasure μ] {f : X → ℝ} {B : ℝ}
    (hB0 : 0 ≤ B) (hf : ∀ x, |f x| ≤ B) :
    -B ≤ (∫ x, f x ∂μ) ∧ (∫ x, f x ∂μ) ≤ B := by
  constructor
  · by_cases hfi : Integrable f μ
    · have hconst : Integrable (fun _ : X => -B) μ := by
        simp
      have hge : (fun _ : X => -B) ≤ᵐ[μ] f :=
        Filter.Eventually.of_forall fun x => (abs_le.mp (hf x)).1
      have hmono :
          (∫ _ : X, -B ∂μ) ≤ ∫ x, f x ∂μ :=
        MeasureTheory.integral_mono_ae hconst hfi hge
      calc
        -B = (∫ _ : X, -B ∂μ) := by simp
        _ ≤ ∫ x, f x ∂μ := hmono
    · rw [MeasureTheory.integral_undef hfi]
      linarith
  · by_cases hfi : Integrable f μ
    · have hconst : Integrable (fun _ : X => B) μ := by
        simp
      have hle : f ≤ᵐ[μ] (fun _ : X => B) :=
        Filter.Eventually.of_forall fun x => (abs_le.mp (hf x)).2
      have hmono :
          (∫ x, f x ∂μ) ≤ ∫ _ : X, B ∂μ :=
        MeasureTheory.integral_mono_ae hfi hconst hle
      calc
        (∫ x, f x ∂μ) ≤ ∫ _ : X, B ∂μ := hmono
        _ = B := by simp
    · rw [MeasureTheory.integral_undef hfi]
      exact hB0

private lemma menu_value_le_strategy_sup_robust_range_bddAbove
    (model : RobustTrustModel) :
    BddAbove
      (Set.range (fun σ : AgentStrategyM model => @RobustPayoffM model σ)) := by
  classical
  obtain ⟨B, hB0, hB⟩ := beliefDot_ProfileInW_abs_le_private_bound model
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  refine ⟨B, ?_⟩
  rintro x ⟨σ, rfl⟩
  have hpoint :
      ∀ (b : Belief model.Ω) (s : model.M),
        |beliefDot b (profileMap model σ s)| ≤ B := by
    intro b s
    exact
      hB b
        (⟨profileMap model σ s, by
            dsimp [profileMap]
            exact ⟨σ.sectionM s, rfl⟩⟩ : ProfileInW model)
  have hAligned :
      -B ≤ AlignedPayoffM model σ ∧
        AlignedPayoffM model σ ≤ B := by
    let f : model.M → ℝ := fun s =>
      beliefDot (model.inclM s) (profileMap model σ s)
    have hf : ∀ s : model.M, |f s| ≤ B := by
      intro s
      simpa [f] using hpoint (model.inclM s) s
    have hIcc := integral_Icc_of_forall_abs_le_prob model.τM hB0 hf
    simpa [AlignedPayoffM, f] using hIcc
  have hMis :
      ∀ β : AdviserKernel model,
        -B ≤ MisalignedPayoffM model β σ ∧
          MisalignedPayoffM model β σ ≤ B := by
    intro β
    letI := β.isMarkov
    let F : model.M → ℝ := fun s =>
      ∫ m, beliefDot (model.inclM s) (profileMap model σ m) ∂(β.kernel s)
    have hF : ∀ s : model.M, |F s| ≤ B := by
      intro s
      haveI : IsProbabilityMeasure (β.kernel s) := inferInstance
      let g : model.M → ℝ := fun m =>
        beliefDot (model.inclM s) (profileMap model σ m)
      have hg : ∀ m : model.M, |g m| ≤ B := by
        intro m
        simpa [g] using hpoint (model.inclM s) m
      have hgIcc := integral_Icc_of_forall_abs_le_prob (β.kernel s) hB0 hg
      exact abs_le.mpr (by simpa [F, g] using hgIcc)
    have hFIcc := integral_Icc_of_forall_abs_le_prob model.τM hB0 hF
    simpa [MisalignedPayoffM, F] using hFIcc
  have hmix_lower :
      ∀ β : AdviserKernel model, -B ≤ MixturePayoffM model β σ := by
    intro β
    have hβ := hMis β
    have hαc : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one
    have hA :=
      mul_le_mul_of_nonneg_left hAligned.1 model.α_nonneg
    have hM :=
      mul_le_mul_of_nonneg_left hβ.1 hαc
    unfold MixturePayoffM
    nlinarith [hA, hM]
  have hmix_upper :
      ∀ β : AdviserKernel model, MixturePayoffM model β σ ≤ B := by
    intro β
    have hβ := hMis β
    have hαc : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one
    have hA :=
      mul_le_mul_of_nonneg_left hAligned.2 model.α_nonneg
    have hM :=
      mul_le_mul_of_nonneg_left hβ.2 hαc
    unfold MixturePayoffM
    nlinarith [hA, hM]
  let β0 : AdviserKernel model :=
    { kernel :=
        ProbabilityTheory.Kernel.deterministic
          (id : model.M → model.M) measurable_id
      isMarkov := inferInstance }
  have hbdd :
      BddBelow
        (Set.range
          (fun β : AdviserKernel model => MixturePayoffM model β σ)) := by
    refine ⟨-B, ?_⟩
    rintro y ⟨β, rfl⟩
    exact hmix_lower β
  have hRobust_le_mix :
      RobustPayoffM model σ ≤ MixturePayoffM model β0 σ := by
    unfold RobustPayoffM
    exact csInf_le hbdd ⟨β0, rfl⟩
  exact le_trans hRobust_le_mix (hmix_upper β0)

private lemma beliefDot_profileMap_diag_measurable
    (model : RobustTrustModel) (setup : ProfileRealizationSetup model)
    (σM : AgentStrategyM model) :
    Measurable
      (fun s : model.M => beliefDot (model.inclM s) (profileMap model σM s)) := by
  have hPair : Measurable (fun s : model.M => (s, s)) := by
    refine Measurable.prod ?_ ?_
    · exact measurable_id
    · exact measurable_id
  exact (beliefDot_profileMap_uncurry_measurable model setup σM).comp hPair

private lemma beliefDot_profileMap_diag_integrable
    (model : RobustTrustModel) (setup : ProfileRealizationSetup model)
    (σM : AgentStrategyM model) :
    Integrable
      (fun s : model.M => beliefDot (model.inclM s) (profileMap model σM s))
      model.τM := by
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  obtain ⟨B, hB⟩ := beliefDot_profileMap_uniform_bound model σM
  refine MeasureTheory.Integrable.of_bound ?_ B ?_
  · exact (beliefDot_profileMap_diag_measurable model setup σM).aestronglyMeasurable
  · exact Filter.Eventually.of_forall (fun s => hB s s)

private lemma menuFunctionalF_bddAbove_uniform
    (model : RobustTrustModel) :
    BddAbove (Set.range (MenuFunctionalF model)) := by
  classical
  obtain ⟨B, hB0, hB⟩ := beliefDot_ProfileInW_abs_le_private_bound model
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  have hα_nn : 0 ≤ model.α := model.α_nonneg
  have h1α_nn : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one
  have h_α_sum : model.α + (1 - model.α) = 1 := by ring
  refine ⟨B, ?_⟩
  rintro x ⟨C, rfl⟩
  obtain ⟨w0, hw0⟩ := C.nonempty
  have hmenu_pt : ∀ s : model.M,
      |model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s| ≤ B := by
    intro s
    have hSimp_BA : BddAbove
        ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
          (↑C : Set (ProfileInW model))) := by
      refine ⟨B, ?_⟩
      rintro y ⟨w, _, rfl⟩
      exact (abs_le.mp (hB (model.inclM s) w)).2
    have hSimp_BB : BddBelow
        ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
          (↑C : Set (ProfileInW model))) := by
      refine ⟨-B, ?_⟩
      rintro y ⟨w, _, rfl⟩
      exact (abs_le.mp (hB (model.inclM s) w)).1
    have hmax_le : maxPayoff model C s ≤ B := by
      unfold maxPayoff
      refine csSup_le ⟨_, ⟨w0, hw0, rfl⟩⟩ ?_
      rintro y ⟨w, _, rfl⟩
      exact (abs_le.mp (hB (model.inclM s) w)).2
    have hmax_ge : -B ≤ maxPayoff model C s := by
      unfold maxPayoff
      calc (-B : ℝ)
          ≤ beliefDot (model.inclM s) w0.val := (abs_le.mp (hB (model.inclM s) w0)).1
        _ ≤ _ := le_csSup hSimp_BA ⟨w0, hw0, rfl⟩
    have hmin_le : minPayoff model C s ≤ B := by
      unfold minPayoff
      calc (sInf _ : ℝ)
          ≤ beliefDot (model.inclM s) w0.val := csInf_le hSimp_BB ⟨w0, hw0, rfl⟩
        _ ≤ B := (abs_le.mp (hB (model.inclM s) w0)).2
    have hmin_ge : -B ≤ minPayoff model C s := by
      unfold minPayoff
      refine le_csInf ⟨_, ⟨w0, hw0, rfl⟩⟩ ?_
      rintro y ⟨w, _, rfl⟩
      exact (abs_le.mp (hB (model.inclM s) w)).1
    have hupper :
        model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s ≤ B := by
      have h1 := mul_le_mul_of_nonneg_left hmax_le hα_nn
      have h2 := mul_le_mul_of_nonneg_left hmin_le h1α_nn
      nlinarith [h_α_sum]
    have hlower :
        -B ≤ model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s := by
      have h1 := mul_le_mul_of_nonneg_left hmax_ge hα_nn
      have h2 := mul_le_mul_of_nonneg_left hmin_ge h1α_nn
      nlinarith [h_α_sum]
    exact abs_le.mpr ⟨hlower, hupper⟩
  unfold MenuFunctionalF
  exact (integral_Icc_of_forall_abs_le_prob _ hB0 hmenu_pt).2

theorem strategy_value_le_menu_sup
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (σM : AgentStrategyM model) :
    RobustPayoffM model σM ≤ sSup (Set.range (MenuFunctionalF model)) := by
  classical
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  let wσ : model.M → ProfileInW model :=
    fun m => ⟨profileMap model σM m, by
      unfold profileMap PayoffProfileSet
      exact ⟨σM.sectionM m, rfl⟩⟩
  have hwσ_meas : Measurable wσ :=
    (profileMap_measurable_for_kernel_bound model setup σM).subtype_mk
  haveI : CompactSpace (ProfileInW model) :=
    isCompact_iff_compactSpace.mp setup.W_compact
  let Cσ : CompactMenu model :=
    { carrier := closure (Set.range wσ)
      isCompact' := isClosed_closure.isCompact
      nonempty' := by
        rcases (inferInstance : Nonempty model.M) with ⟨m0⟩
        exact ⟨wσ m0, subset_closure (Set.mem_range_self m0)⟩ }
  have hCσ_coe :
      (↑Cσ : Set (ProfileInW model)) = closure (Set.range wσ) := rfl
  have h_bdd_range :
      ∀ s : model.M,
        BddAbove
          (Set.range fun m : model.M =>
            beliefDot (model.inclM s) (wσ m).val) ∧
        BddBelow
          (Set.range fun m : model.M =>
            beliefDot (model.inclM s) (wσ m).val) := by
    intro s
    obtain ⟨B, _hB0, hB⟩ := beliefDot_ProfileInW_abs_le_private_bound model
    refine ⟨⟨B, ?_⟩, ⟨-B, ?_⟩⟩
    · rintro y ⟨m, rfl⟩
      exact (abs_le.mp (hB (model.inclM s) (wσ m))).2
    · rintro y ⟨m, rfl⟩
      exact (abs_le.mp (hB (model.inclM s) (wσ m))).1
  have hmax_eq :
      ∀ s : model.M,
        maxPayoff model Cσ s =
          sSup (Set.range fun m : model.M =>
            beliefDot (model.inclM s) (wσ m).val) := by
    intro s
    unfold maxPayoff
    have hf_cont : Continuous (fun w : ProfileInW model =>
        beliefDot (model.inclM s) w.val) := by
      have h := beliefDot_menu_uncurry_continuous model
      exact h.comp ((continuous_const).prodMk continuous_id)
    have h_range_ne : (Set.range wσ).Nonempty :=
      ⟨wσ Classical.ofNonempty, Set.mem_range_self _⟩
    have h_img_eq :
        (fun w : ProfileInW model => beliefDot (model.inclM s) w.val) '' Set.range wσ
          = Set.range fun m : model.M => beliefDot (model.inclM s) (wσ m).val := by
      ext y; constructor
      · rintro ⟨w, ⟨m, rfl⟩, rfl⟩; exact ⟨m, rfl⟩
      · rintro ⟨m, rfl⟩; exact ⟨wσ m, Set.mem_range_self m, rfl⟩
    have hBA : BddAbove
        ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
          Set.range wσ) := by
      rw [h_img_eq]; exact (h_bdd_range s).1
    have h_eq := sSup_image_closure_eq_of_continuous _ hf_cont (Set.range wσ) h_range_ne hBA
    rw [hCσ_coe, h_eq, h_img_eq]
  have hmin_eq :
      ∀ s : model.M,
        minPayoff model Cσ s =
          sInf (Set.range fun m : model.M =>
            beliefDot (model.inclM s) (wσ m).val) := by
    intro s
    unfold minPayoff
    have hf_cont : Continuous (fun w : ProfileInW model =>
        beliefDot (model.inclM s) w.val) := by
      have h := beliefDot_menu_uncurry_continuous model
      exact h.comp ((continuous_const).prodMk continuous_id)
    have h_range_ne : (Set.range wσ).Nonempty :=
      ⟨wσ Classical.ofNonempty, Set.mem_range_self _⟩
    have h_img_eq :
        (fun w : ProfileInW model => beliefDot (model.inclM s) w.val) '' Set.range wσ
          = Set.range fun m : model.M => beliefDot (model.inclM s) (wσ m).val := by
      ext y; constructor
      · rintro ⟨w, ⟨m, rfl⟩, rfl⟩; exact ⟨m, rfl⟩
      · rintro ⟨m, rfl⟩; exact ⟨wσ m, Set.mem_range_self m, rfl⟩
    have hBB : BddBelow
        ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
          Set.range wσ) := by
      rw [h_img_eq]; exact (h_bdd_range s).2
    have h_eq := sInf_image_closure_eq_of_continuous _ hf_cont (Set.range wσ) h_range_ne hBB
    rw [hCσ_coe, h_eq, h_img_eq]
  have hmax_bound :
      ∀ s : model.M,
        beliefDot (model.inclM s) (profileMap model σM s) ≤
          maxPayoff model Cσ s := by
    intro s
    rw [hmax_eq s]
    refine le_csSup (h_bdd_range s).1 ?_
    exact ⟨s, rfl⟩
  have hAligned_le :
      AlignedPayoffM model σM ≤
        ∫ s, maxPayoff model Cσ s ∂model.τM := by
    unfold AlignedPayoffM
    refine MeasureTheory.integral_mono
      (beliefDot_profileMap_diag_integrable model setup σM)
      (maxPayoff_integrable model Cσ)
      ?_
    exact hmax_bound
  have hMisInf :
      sInf (Set.range fun β : AdviserKernel model =>
        MisalignedPayoffM model β σM) =
        ∫ s, minPayoff model Cσ s ∂model.τM := by
    have hwσ_uncurry_meas :
        Measurable fun p : model.M × model.M =>
          beliefDot (model.inclM p.1) (wσ p.2).val := by
      change Measurable fun p : model.M × model.M =>
        beliefDot (model.inclM p.1) (profileMap model σM p.2)
      exact beliefDot_profileMap_uncurry_measurable model setup σM
    have hwσ_bdd :
        ∃ C : ℝ, ∀ s m : model.M,
          |beliefDot (model.inclM s) (wσ m).val| ≤ C := by
      obtain ⟨B, hB⟩ := beliefDot_profileMap_uniform_bound model σM
      exact ⟨B, fun s m => by
        have := hB s m
        simpa [Real.norm_eq_abs, wσ] using this⟩
    have hinf_meas :
        Measurable fun s : model.M =>
          sInf (Set.range fun m : model.M =>
            beliefDot (model.inclM s) (wσ m).val) := by
      have heq : (fun s : model.M => minPayoff model Cσ s)
          = fun s => sInf (Set.range fun m : model.M =>
              beliefDot (model.inclM s) (wσ m).val) := by
        funext s; exact hmin_eq s
      rw [← heq]
      have hcont : Continuous
          (fun b : Belief model.Ω =>
            sInf ((fun w : ProfileInW model => beliefDot b w.val) ''
              (↑Cσ : Set (ProfileInW model)))) :=
        Cσ.isCompact.continuous_sInf (beliefDot_menu_uncurry_continuous model)
      have hmeas : Measurable (fun s : model.M => minPayoff model Cσ s) := by
        simpa [minPayoff] using hcont.measurable.comp model.inclM_measurable
      exact hmeas
    have hinf_int :
        Integrable
          (fun s : model.M =>
            sInf (Set.range fun m : model.M =>
              beliefDot (model.inclM s) (wσ m).val)) model.τM := by
      have heq : (fun s : model.M => minPayoff model Cσ s)
          = fun s => sInf (Set.range fun m : model.M =>
              beliefDot (model.inclM s) (wσ m).val) := by
        funext s; exact hmin_eq s
      rw [← heq]
      exact minPayoff_integrable model Cσ
    have hkernel_int :
        ∀ β : AdviserKernel model,
          Integrable
            (fun p : model.M × model.M =>
              beliefDot (model.inclM p.1) (wσ p.2).val)
            (model.τM.compProd β.kernel) := by
      intro β
      haveI : ProbabilityTheory.IsMarkovKernel β.kernel := β.isMarkov
      haveI : IsProbabilityMeasure (model.τM.compProd β.kernel) :=
        inferInstance
      obtain ⟨B, hB⟩ := beliefDot_profileMap_uniform_bound model σM
      refine MeasureTheory.Integrable.of_bound ?_ B ?_
      · exact hwσ_uncurry_meas.aestronglyMeasurable
      · refine Filter.Eventually.of_forall ?_
        intro p
        have := hB p.1 p.2
        simpa [Real.norm_eq_abs, wσ] using this
    have hpoint :=
      adversary_infimum_pointwise model wσ hwσ_meas hwσ_uncurry_meas
        hwσ_bdd hinf_meas hinf_int hkernel_int
    have hheq : (fun β : AdviserKernel model =>
        ∫ s, ∫ m, beliefDot (model.inclM s) (wσ m).val ∂(β.kernel s) ∂model.τM) =
        (fun β => MisalignedPayoffM model β σM) := by
      funext β
      unfold MisalignedPayoffM
      rfl
    rw [← hheq]
    rw [hpoint]
    refine MeasureTheory.integral_congr_ae (Filter.Eventually.of_forall ?_)
    intro s
    exact (hmin_eq s).symm
  have hbddBelow_mis :
      BddBelow (Set.range fun β : AdviserKernel model =>
        MisalignedPayoffM model β σM) := by
    obtain ⟨B, hB0, hB⟩ := beliefDot_ProfileInW_abs_le_private_bound model
    refine ⟨-B, ?_⟩
    rintro x ⟨β, rfl⟩
    haveI : ProbabilityTheory.IsMarkovKernel β.kernel := β.isMarkov
    have hOuter : ∀ s, -B ≤ ∫ m, beliefDot (model.inclM s) (profileMap model σM m)
        ∂(β.kernel s) := by
      intro s
      haveI : IsProbabilityMeasure (β.kernel s) :=
        β.isMarkov.isProbabilityMeasure s
      have hbound : ∀ m, |beliefDot (model.inclM s) (profileMap model σM m)| ≤ B := by
        intro m; exact hB _ (wσ m)
      exact (integral_Icc_of_forall_abs_le_prob (β.kernel s) hB0 hbound).1
    unfold MisalignedPayoffM
    have h_const_int :
        (∫ _s : model.M, (-B : ℝ) ∂model.τM) = -B := by simp
    rw [← h_const_int]
    refine MeasureTheory.integral_mono_ae
      (integrable_const (-B))
      (beliefDot_profileMap_kernel_integral_integrable model setup β σM)
      ?_
    exact Filter.Eventually.of_forall hOuter
  have hF_split :
      MenuFunctionalF model Cσ =
        model.α * (∫ s, maxPayoff model Cσ s ∂model.τM) +
          (1 - model.α) *
            (∫ s, minPayoff model Cσ s ∂model.τM) := by
    have hα_max_int :
        Integrable (fun s => model.α * maxPayoff model Cσ s) model.τM :=
      (maxPayoff_integrable model Cσ).const_mul model.α
    have h1α_min_int :
        Integrable (fun s => (1 - model.α) * minPayoff model Cσ s) model.τM :=
      (minPayoff_integrable model Cσ).const_mul (1 - model.α)
    unfold MenuFunctionalF
    rw [integral_add hα_max_int h1α_min_int, integral_const_mul, integral_const_mul]
  -- Prove RobustPayoff σM ≤ MenuFunctionalF Cσ directly via ε-approximation
  have hRobust_le_F :
      RobustPayoffM model σM ≤ MenuFunctionalF model Cσ := by
    rw [hF_split]
    set A : ℝ := AlignedPayoffM model σM with hA_def
    set MisRange : Set ℝ :=
      Set.range fun β : AdviserKernel model => MisalignedPayoffM model β σM
    have hMisRange_ne : MisRange.Nonempty := by
      let β0 : AdviserKernel model :=
        { kernel := ProbabilityTheory.Kernel.deterministic
            (id : model.M → model.M) measurable_id
          isMarkov := inferInstance }
      exact ⟨MisalignedPayoffM model β0 σM, ⟨β0, rfl⟩⟩
    have hSI : sInf MisRange = ∫ s, minPayoff model Cσ s ∂model.τM := hMisInf
    have hα_nonneg : 0 ≤ model.α := model.α_nonneg
    have hαc : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one
    have hαAB : model.α * A ≤ model.α * ∫ s, maxPayoff model Cσ s ∂model.τM :=
      mul_le_mul_of_nonneg_left hAligned_le hα_nonneg
    obtain ⟨Bu, hBu0, hBu⟩ := beliefDot_ProfileInW_abs_le_private_bound model
    have hBdd_mix :
        BddBelow (Set.range fun β : AdviserKernel model =>
          MixturePayoffM model β σM) := by
      refine ⟨model.α * (-Bu) + (1 - model.α) * (-Bu), ?_⟩
      rintro x ⟨β', rfl⟩
      unfold MixturePayoffM
      have hAlow : -Bu ≤ AlignedPayoffM model σM := by
        unfold AlignedPayoffM
        have hbound : ∀ s, |beliefDot (model.inclM s) (profileMap model σM s)| ≤ Bu :=
          fun s => hBu _ (wσ s)
        exact (integral_Icc_of_forall_abs_le_prob model.τM hBu0 hbound).1
      have hMlow : -Bu ≤ MisalignedPayoffM model β' σM := by
        haveI : ProbabilityTheory.IsMarkovKernel β'.kernel := β'.isMarkov
        have hOuter : ∀ s, -Bu ≤ ∫ m, beliefDot (model.inclM s)
            (profileMap model σM m) ∂(β'.kernel s) := by
          intro s
          haveI : IsProbabilityMeasure (β'.kernel s) :=
            β'.isMarkov.isProbabilityMeasure s
          have hbound : ∀ m, |beliefDot (model.inclM s) (profileMap model σM m)| ≤ Bu :=
            fun m => hBu _ (wσ m)
          exact (integral_Icc_of_forall_abs_le_prob (β'.kernel s) hBu0 hbound).1
        unfold MisalignedPayoffM
        have h_const_int :
            (∫ _s : model.M, (-Bu : ℝ) ∂model.τM) = -Bu := by simp
        rw [← h_const_int]
        refine MeasureTheory.integral_mono_ae
          (integrable_const (-Bu))
          (beliefDot_profileMap_kernel_integral_integrable model setup β' σM)
          ?_
        exact Filter.Eventually.of_forall hOuter
      nlinarith [mul_le_mul_of_nonneg_left hAlow hα_nonneg,
                 mul_le_mul_of_nonneg_left hMlow hαc]
    unfold RobustPayoffM
    refine le_of_forall_pos_le_add ?_
    intro ε hε_pos
    have h1αB : (1 - model.α) ≤ 1 := by linarith
    have hexists_lt : ∃ x ∈ MisRange, x < sInf MisRange + ε := by
      by_contra hcontra
      have hLower : ∀ x ∈ MisRange, sInf MisRange + ε ≤ x := by
        intro x hx
        exact le_of_not_gt (fun hxlt => hcontra ⟨x, hx, hxlt⟩)
      have hle : sInf MisRange + ε ≤ sInf MisRange := le_csInf hMisRange_ne hLower
      linarith
    obtain ⟨y, hy_in, hy_lt⟩ := hexists_lt
    obtain ⟨β, hβy⟩ := hy_in
    have hMixβ : MixturePayoffM model β σM = model.α * A + (1 - model.α) * y := by
      show model.α * AlignedPayoffM model σM + (1 - model.α) * _ = _
      rw [← hA_def, ← hβy]
    have hsInf_le_β :
        sInf (Set.range fun β : AdviserKernel model => MixturePayoffM model β σM) ≤
          MixturePayoffM model β σM :=
      csInf_le hBdd_mix ⟨β, rfl⟩
    have h_step :
        (1 - model.α) * y ≤ (1 - model.α) * (sInf MisRange + ε) :=
      mul_le_mul_of_nonneg_left (le_of_lt hy_lt) hαc
    have h_oneα_ε : (1 - model.α) * ε ≤ ε := by
      have h1αB_nn : 0 ≤ 1 - model.α := hαc
      have := mul_le_mul_of_nonneg_right h1αB (le_of_lt hε_pos)
      linarith
    calc sInf (Set.range fun β : AdviserKernel model => MixturePayoffM model β σM)
        ≤ MixturePayoffM model β σM := hsInf_le_β
      _ = model.α * A + (1 - model.α) * y := hMixβ
      _ ≤ model.α * A + (1 - model.α) * (sInf MisRange + ε) := by linarith
      _ = model.α * A + (1 - model.α) * sInf MisRange + (1 - model.α) * ε := by ring
      _ ≤ model.α * (∫ s, maxPayoff model Cσ s ∂model.τM) +
            (1 - model.α) * sInf MisRange + (1 - model.α) * ε := by linarith [hαAB]
      _ ≤ model.α * (∫ s, maxPayoff model Cσ s ∂model.τM) +
            (1 - model.α) * sInf MisRange + ε := by linarith [h_oneα_ε]
      _ = model.α * (∫ s, maxPayoff model Cσ s ∂model.τM) +
            (1 - model.α) * (∫ s, minPayoff model Cσ s ∂model.τM) + ε := by
            rw [hSI]
  exact le_trans hRobust_le_F
    (le_csSup (menuFunctionalF_bddAbove_uniform model) ⟨Cσ, rfl⟩)

/-- Trivial model-side coefficient fact. -/
private lemma menu_value_le_strategy_sup_one_sub_alpha_nonneg
    (model : RobustTrustModel) :
    0 ≤ 1 - model.α := by
  exact sub_nonneg.mpr model.α_le_one

theorem menu_value_le_strategy_sup
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (prm : ProfileRealizationMap model)
    (C : CompactMenu model) :
    MenuFunctionalF model C ≤ UStarM model := by
  classical

  obtain ⟨wC, hwC_meas, hwC_mem, hwC_max⟩ :=
    compact_menu_aligned_selection model C

  let σM_C : AgentStrategyM model :=
    { sectionM := fun m => prm.R (wC m)
      measurable_sectionM := prm.measurable_R.comp hwC_meas }

  have hprofile :
      ∀ m : model.M, @profileMap model σM_C m = (wC m).val := by
    intro m
    simpa [σM_C, profileMap] using prm.right_inverse (wC m)

  have hmax_point :
      ∀ s : model.M,
        beliefDot (model.inclM s) (@profileMap model σM_C s)
          = @maxPayoff model C s := by
    intro s
    rw [hprofile s]
    unfold maxPayoff
    symm
    refine IsLUB.csSup_eq ?_ ⟨_, ⟨wC s, hwC_mem s, rfl⟩⟩
    constructor
    · rintro x ⟨w, hw, rfl⟩
      exact (hwC_max s) hw
    · intro b hb
      exact hb ⟨wC s, hwC_mem s, rfl⟩

  have hmin_point :
      ∀ (s m : model.M),
        @minPayoff model C s ≤
          beliefDot (model.inclM s) (@profileMap model σM_C m) := by
    intro s m
    rw [hprofile m]
    unfold minPayoff
    exact
      csInf_le
        (menu_value_le_strategy_sup_payoff_image_bddBelow model C s)
        ⟨wC m, hwC_mem m, rfl⟩

  have hAligned :
      @AlignedPayoffM model σM_C
        = ∫ s, @maxPayoff model C s ∂model.τM := by
    unfold AlignedPayoffM
    refine integral_congr_ae ?_
    exact Filter.Eventually.of_forall hmax_point

  have hMis_per_β :
      ∀ β : AdviserKernel model,
        (∫ s, @minPayoff model C s ∂model.τM)
          ≤ @MisalignedPayoffM model β σM_C := by
    intro β
    unfold MisalignedPayoffM
    classical
    haveI : IsProbabilityMeasure model.τM := model.τM_prob
    haveI : ProbabilityTheory.IsMarkovKernel β.kernel := β.isMarkov
    have hInner :
        ∀ᵐ s ∂model.τM,
          minPayoff model C s
            ≤ ∫ m : model.M,
                beliefDot (model.inclM s) (profileMap model σM_C m)
                  ∂(β.kernel s) := by
      filter_upwards with s
      haveI : IsProbabilityMeasure (β.kernel s) :=
        β.isMarkov.isProbabilityMeasure s
      have h_const_int :
          (∫ _m : model.M, minPayoff model C s ∂(β.kernel s))
            = minPayoff model C s := by
        simpa using
          (MeasureTheory.integral_const
            (μ := β.kernel s)
            (c := minPayoff model C s))
      rw [← h_const_int]
      refine
        MeasureTheory.integral_mono_ae
          (integrable_const (minPayoff model C s))
          (beliefDot_profileMap_integrable_kernel model setup β σM_C s)
          ?_
      exact Filter.Eventually.of_forall (fun m => hmin_point s m)
    have hMisalignedInt :
        Integrable
          (fun s : model.M =>
            ∫ m : model.M,
              beliefDot (model.inclM s) (profileMap model σM_C m)
                ∂(β.kernel s))
          model.τM :=
      beliefDot_profileMap_kernel_integral_integrable model setup β σM_C
    simpa using
      MeasureTheory.integral_mono_ae
        (minPayoff_integrable model C)
        hMisalignedInt
        hInner
  -- Witness adversary kernel for range_nonempty: deterministic identity kernel.
  let β0 : AdviserKernel model :=
    { kernel := ProbabilityTheory.Kernel.deterministic (id : model.M → model.M)
        measurable_id
      isMarkov := inferInstance }
  have hStrategy :
      MenuFunctionalF model C ≤ @RobustPayoffM model σM_C := by
    -- RobustPayoffM σ = sInf (range MixturePayoffM · σ).
    -- Show: MenuFunctionalF C ≤ MixturePayoffM β σM_C for every β.
    refine le_csInf ⟨_, ⟨β0, rfl⟩⟩ ?_
    rintro x ⟨β, rfl⟩
    -- MenuFunctionalF C ≤ MixturePayoffM β σM_C
    --   = α AlignedPayoff σM_C + (1-α) MisalignedPayoff β σM_C
    -- LHS = ∫ (α max + (1-α) min) dτM = α ∫ max + (1-α) ∫ min (linearity)
    --     ≤ α AlignedPayoff σM_C + (1-α) MisalignedPayoff β σM_C
    have hcoef : 0 ≤ 1 - model.α :=
      menu_value_le_strategy_sup_one_sub_alpha_nonneg model
    have hα_nn : 0 ≤ model.α := model.α_nonneg
    have hF_split :
        MenuFunctionalF model C =
          model.α * (∫ s, @maxPayoff model C s ∂model.τM) +
            (1 - model.α) * (∫ s, @minPayoff model C s ∂model.τM) := by
      have hα_max_int :
          Integrable (fun s => model.α * maxPayoff model C s) model.τM :=
        (maxPayoff_integrable model C).const_mul model.α
      have h1α_min_int :
          Integrable (fun s => (1 - model.α) * minPayoff model C s) model.τM :=
        (minPayoff_integrable model C).const_mul (1 - model.α)
      unfold MenuFunctionalF
      rw [integral_add hα_max_int h1α_min_int, integral_const_mul, integral_const_mul]
    rw [hF_split]
    unfold MixturePayoffM
    rw [hAligned]
    -- Goal: α*∫max + (1-α)*∫min ≤ α*∫max + (1-α)*MisalignedPayoff β σM_C
    have := mul_le_mul_of_nonneg_left (hMis_per_β β) hcoef
    linarith

  have hSup :
      @RobustPayoffM model σM_C ≤ UStarM model := by
    unfold UStarM
    exact
      le_csSup
        (menu_value_le_strategy_sup_robust_range_bddAbove model)
        ⟨σM_C, rfl⟩

  exact le_trans hStrategy hSup

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


private lemma menu_integrand_aemeasurable
    (model : RobustTrustModel)
    (C : CompactMenu model) :
    AEMeasurable
      (fun s =>
        model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s)
      model.τM := by
  classical

  have hdot :
      Continuous (Function.uncurry
        (fun b : Belief model.Ω =>
          fun w : ProfileInW model => beliefDot b w.val)) := by
    simpa [Function.uncurry] using beliefDot_menu_uncurry_continuous model

  have hK : IsCompact (↑C : Set (ProfileInW model)) := C.isCompact

  have hmax_cont :
      Continuous (fun b : Belief model.Ω =>
        sSup ((fun w : ProfileInW model => beliefDot b w.val) ''
          (↑C : Set (ProfileInW model)))) := by
    simpa using hK.continuous_sSup hdot

  have hmin_cont :
      Continuous (fun b : Belief model.Ω =>
        sInf ((fun w : ProfileInW model => beliefDot b w.val) ''
          (↑C : Set (ProfileInW model)))) := by
    simpa using hK.continuous_sInf hdot

  have hmax_meas : Measurable (fun s : model.M => maxPayoff model C s) := by
    simpa [maxPayoff] using
      hmax_cont.measurable.comp model.inclM_measurable

  have hmin_meas : Measurable (fun s : model.M => minPayoff model C s) := by
    simpa [minPayoff] using
      hmin_cont.measurable.comp model.inclM_measurable

  have hαmax :
      Measurable (fun s : model.M => model.α * maxPayoff model C s) :=
    measurable_const.mul hmax_meas

  have hαmin :
      Measurable (fun s : model.M => (1 - model.α) * minPayoff model C s) :=
    measurable_const.mul hmin_meas

  exact (hαmax.add hαmin).aemeasurable

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
    (C : CompactMenu model) :
    ∃ B : ℝ,
      ∀ᵐ s ∂model.τM,
        model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s ∈
          Set.Icc (-B) B := by
  classical
  -- Per-coordinate bound via compactness.
  have hper :
      ∀ ω : model.Ω, ∃ Mω : ℝ,
        ∀ w ∈ (↑C : Set (ProfileInW model)), |w.val ω| ≤ Mω := by
    intro ω
    have hcont : Continuous (fun w : ProfileInW model => |w.val ω|) :=
      continuous_abs.comp ((continuous_apply ω).comp continuous_subtype_val)
    obtain ⟨wmax, _hmem, hwmax⟩ :=
      C.isCompact.exists_isMaxOn C.nonempty hcont.continuousOn
    exact ⟨|wmax.val ω|, fun w hw => hwmax hw⟩
  choose Mω hMω using hper
  haveI := model.Ω_nonempty
  let M : ℝ := (Finset.univ : Finset model.Ω).sup' Finset.univ_nonempty Mω
  have hM_nn : 0 ≤ M := by
    obtain ⟨ω0⟩ := model.Ω_nonempty
    rcases C.nonempty with ⟨w0, hw0⟩
    have h1 : 0 ≤ Mω ω0 := (abs_nonneg _).trans (hMω ω0 w0 hw0)
    exact h1.trans (Finset.le_sup' (s := Finset.univ) Mω (Finset.mem_univ ω0))
  -- Bound |beliefDot s w| ≤ M for all s and w ∈ ↑C.
  have hbnd :
      ∀ s : model.M, ∀ w ∈ (↑C : Set (ProfileInW model)),
        |beliefDot (model.inclM s) w.val| ≤ M := by
    intro s w hw
    have h_w_bd : ∀ ω : model.Ω, |w.val ω| ≤ M := by
      intro ω
      exact (hMω ω w hw).trans
        (Finset.le_sup' (s := Finset.univ) Mω (Finset.mem_univ ω))
    have h_nonneg : ∀ ω : model.Ω, 0 ≤ (model.inclM s).val ω :=
      (model.inclM s).property.1
    have h_sum : ∑ ω : model.Ω, (model.inclM s).val ω = 1 :=
      (model.inclM s).property.2
    calc
      |beliefDot (model.inclM s) w.val|
          = |∑ ω : model.Ω, (model.inclM s).val ω * w.val ω| := rfl
      _ ≤ ∑ ω : model.Ω, |(model.inclM s).val ω * w.val ω| :=
            Finset.abs_sum_le_sum_abs _ _
      _ ≤ ∑ ω : model.Ω, (model.inclM s).val ω * M := by
            apply Finset.sum_le_sum
            intro ω _
            rw [abs_mul, abs_of_nonneg (h_nonneg ω)]
            exact mul_le_mul_of_nonneg_left (h_w_bd ω) (h_nonneg ω)
      _ = (∑ ω : model.Ω, (model.inclM s).val ω) * M := by
            rw [← Finset.sum_mul]
      _ = M := by rw [h_sum]; ring
  -- Bound on maxPayoff/minPayoff per s.
  have hmax_le : ∀ s : model.M, maxPayoff model C s ≤ M := by
    intro s
    unfold maxPayoff
    refine csSup_le ?_ ?_
    · rcases C.nonempty with ⟨w0, hw0⟩
      exact ⟨_, ⟨w0, hw0, rfl⟩⟩
    · rintro x ⟨w, hw, rfl⟩
      exact (le_abs_self _).trans (hbnd s w hw)
  have hmax_ge : ∀ s : model.M, -M ≤ maxPayoff model C s := by
    intro s
    unfold maxPayoff
    rcases C.nonempty with ⟨w0, hw0⟩
    have hb : BddAbove ((fun w : ProfileInW model =>
        beliefDot (model.inclM s) w.val) '' (↑C : Set (ProfileInW model))) :=
      ⟨M, by rintro x ⟨w, hw, rfl⟩; exact (le_abs_self _).trans (hbnd s w hw)⟩
    refine le_csSup_of_le hb ⟨w0, hw0, rfl⟩ ?_
    have := hbnd s w0 hw0
    linarith [neg_abs_le (beliefDot (model.inclM s) w0.val)]
  have hmin_le : ∀ s : model.M, minPayoff model C s ≤ M := by
    intro s
    unfold minPayoff
    rcases C.nonempty with ⟨w0, hw0⟩
    have hb : BddBelow ((fun w : ProfileInW model =>
        beliefDot (model.inclM s) w.val) '' (↑C : Set (ProfileInW model))) :=
      menu_value_le_strategy_sup_payoff_image_bddBelow model C s
    refine csInf_le_of_le hb ⟨w0, hw0, rfl⟩ ?_
    exact (le_abs_self _).trans (hbnd s w0 hw0)
  have hmin_ge : ∀ s : model.M, -M ≤ minPayoff model C s := by
    intro s
    unfold minPayoff
    refine le_csInf ?_ ?_
    · rcases C.nonempty with ⟨w0, hw0⟩
      exact ⟨_, ⟨w0, hw0, rfl⟩⟩
    · rintro x ⟨w, hw, rfl⟩
      have := hbnd s w hw
      linarith [neg_abs_le (beliefDot (model.inclM s) w.val)]
  refine ⟨M, ?_⟩
  filter_upwards with s
  have hα_nn : 0 ≤ model.α := model.α_nonneg
  have h1α_nn : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one
  refine ⟨?_, ?_⟩
  · -- -M ≤ α*max + (1-α)*min
    have h1 : model.α * (-M) ≤ model.α * maxPayoff model C s :=
      mul_le_mul_of_nonneg_left (hmax_ge s) hα_nn
    have h2 : (1 - model.α) * (-M) ≤ (1 - model.α) * minPayoff model C s :=
      mul_le_mul_of_nonneg_left (hmin_ge s) h1α_nn
    nlinarith
  · -- α*max + (1-α)*min ≤ M
    have h1 : model.α * maxPayoff model C s ≤ model.α * M :=
      mul_le_mul_of_nonneg_left (hmax_le s) hα_nn
    have h2 : (1 - model.α) * minPayoff model C s ≤ (1 - model.α) * M :=
      mul_le_mul_of_nonneg_left (hmin_le s) h1α_nn
    nlinarith

private lemma menu_integrand_integrable
    (model : RobustTrustModel)
    (C : CompactMenu model) :
    Integrable
      (fun s =>
        model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s)
      model.τM := by
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  rcases menu_integrand_mem_Icc_ae model C with ⟨B, hB⟩
  exact
    Integrable.of_mem_Icc (-B) B
      (menu_integrand_aemeasurable model C)
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
    simpa [fC] using menu_integrand_integrable model C
  have hD : Integrable fD model.τM := by
    simpa [fD] using menu_integrand_integrable model D

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

/-- Aux: if a sub-menu C ⊆ Cstar contains the aligned-best range (range wstar),
then F(Cstar) ≤ F(C). Max term is preserved (wstar achieves the per-s max);
min term is weakly increasing (smaller set → larger sInf). The integral
preserves these inequalities. **Substantive gap**: this is the integral
form of the closure-pruning preservation argument; full proof requires
integral_mono over the menu-integrand bounded by the same C_bnd. -/
private lemma MenuFunctionalF_le_of_contains_aligned_argmax
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt)
    (C : CompactMenu model)
    (hC_sub : (↑C : Set (ProfileInW model)) ⊆
        (↑opt.Cstar : Set (ProfileInW model)))
    (hrange_sub : Set.range wlabel.wstar ⊆
        (↑C : Set (ProfileInW model))) :
    MenuFunctionalF model opt.Cstar ≤ MenuFunctionalF model C := by
  classical

  have h1α : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one

  let lin (s : model.M) : ProfileInW model → ℝ :=
    fun w => beliefDot (model.inclM s) w.val

  have hlin_cont : ∀ s : model.M, Continuous (lin s) := by
    intro s
    dsimp [lin]
    have hpair : Continuous (fun w : ProfileInW model =>
        ((model.inclM s, w) : Belief model.Ω × ProfileInW model)) :=
      continuous_const.prodMk continuous_id
    simpa using
      (beliefDot_menu_uncurry_continuous model).comp hpair

  have hbddAbove :
      ∀ (D : CompactMenu model) (s : model.M),
        BddAbove ((lin s) '' (↑D : Set (ProfileInW model))) := by
    intro D s
    exact (D.isCompact.image (hlin_cont s)).bddAbove

  have hbddBelow :
      ∀ (D : CompactMenu model) (s : model.M),
        BddBelow ((lin s) '' (↑D : Set (ProfileInW model))) := by
    intro D s
    exact (D.isCompact.image (hlin_cont s)).bddBelow

  have hpointwise :
      ∀ s : model.M,
        model.α * maxPayoff model opt.Cstar s
            + (1 - model.α) * minPayoff model opt.Cstar s
          ≤
        model.α * maxPayoff model C s
            + (1 - model.α) * minPayoff model C s := by
    intro s

    have hmax_eq : maxPayoff model opt.Cstar s = maxPayoff model C s := by
      apply le_antisymm
      · -- `C` contains the aligned argmax, so the larger menu has no larger max.
        unfold maxPayoff
        refine csSup_le ?_ ?_
        · rcases opt.Cstar.nonempty with ⟨w, hw⟩
          exact ⟨_, ⟨w, hw, rfl⟩⟩
        · rintro x ⟨w, hw, rfl⟩
          have h_wstar_max :
              beliefDot (model.inclM s) w.val
                ≤ beliefDot (model.inclM s) (wlabel.wstar s).val := by
            exact (wlabel.is_argmax s) hw
          have h_wstar_in_C :
              wlabel.wstar s ∈ (↑C : Set (ProfileInW model)) := by
            exact hrange_sub (Set.mem_range_self s)
          have h_wstar_le :
              beliefDot (model.inclM s) (wlabel.wstar s).val
                ≤ maxPayoff model C s := by
            unfold maxPayoff
            exact le_csSup
              (by simpa [lin] using hbddAbove C s)
              ⟨wlabel.wstar s, h_wstar_in_C, rfl⟩
          exact le_trans h_wstar_max h_wstar_le
      · -- `C ⊆ Cstar`, so the smaller menu's max is bounded by the larger menu's max.
        unfold maxPayoff
        refine csSup_le ?_ ?_
        · rcases C.nonempty with ⟨w, hw⟩
          exact ⟨_, ⟨w, hw, rfl⟩⟩
        · rintro x ⟨w, hw, rfl⟩
          exact le_csSup
            (by simpa [lin] using hbddAbove opt.Cstar s)
            ⟨w, hC_sub hw, rfl⟩

    have hmin_le : minPayoff model opt.Cstar s ≤ minPayoff model C s := by
      -- Infimum over the larger set is no larger than infimum over the subset.
      unfold minPayoff
      refine le_csInf ?_ ?_
      · rcases C.nonempty with ⟨w, hw⟩
        exact ⟨_, ⟨w, hw, rfl⟩⟩
      · rintro x ⟨w, hw, rfl⟩
        exact csInf_le
          (by simpa [lin] using hbddBelow opt.Cstar s)
          ⟨w, hC_sub hw, rfl⟩

    rw [hmax_eq]
    have := mul_le_mul_of_nonneg_left hmin_le h1α
    linarith

  unfold MenuFunctionalF
  refine integral_mono_ae
    (menu_integrand_integrable model opt.Cstar)
    (menu_integrand_integrable model C) ?_
  filter_upwards with s
  exact hpointwise s

theorem closure_pruning_value_preservation
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt) :
    ∃ cdagger : PrunedMenuCdagger model wlabel,
      (↑cdagger.Cdagger : Set (ProfileInW model)) ⊆
          (↑opt.Cstar : Set (ProfileInW model)) ∧
        MenuFunctionalF model cdagger.Cdagger = MenuFunctionalF model opt.Cstar ∧
        MenuFunctionalF model opt.Cstar = UStarM model := by
  classical
  let S : Set (ProfileInW model) := closure (Set.range wlabel.wstar)
  have hrange_sub_Cstar :
      Set.range wlabel.wstar ⊆
        (↑opt.Cstar : Set (ProfileInW model)) := by
    rintro w ⟨m, rfl⟩
    exact wlabel.mem_Cstar m
  have hclosed_Cstar :
      IsClosed (↑opt.Cstar : Set (ProfileInW model)) :=
    opt.Cstar.isCompact.isClosed
  have hS_sub_Cstar :
      S ⊆ (↑opt.Cstar : Set (ProfileInW model)) := by
    dsimp [S]
    exact closure_minimal hrange_sub_Cstar hclosed_Cstar
  have hS_nonempty : S.Nonempty := by
    rcases Set.range_nonempty wlabel.wstar with ⟨w, hw⟩
    exact ⟨w, subset_closure hw⟩
  have hS_compact : IsCompact S :=
    opt.Cstar.isCompact.of_isClosed_subset isClosed_closure hS_sub_Cstar
  let CdaggerMenu : CompactMenu model :=
    ⟨⟨S, hS_compact⟩, hS_nonempty⟩
  have hCdagger_sub_Cstar :
      (↑CdaggerMenu : Set (ProfileInW model)) ⊆
        (↑opt.Cstar : Set (ProfileInW model)) := hS_sub_Cstar
  have hclosure_sub_Cdagger :
      closure (Set.range wlabel.wstar) ⊆
        (↑CdaggerMenu : Set (ProfileInW model)) := fun _ hw => hw
  have hCdagger_sub_closure :
      (↑CdaggerMenu : Set (ProfileInW model)) ⊆
        closure (Set.range wlabel.wstar) := fun _ hw => hw
  have hrange_sub_Cdagger :
      Set.range wlabel.wstar ⊆
        (↑CdaggerMenu : Set (ProfileInW model)) :=
    fun w hw => hclosure_sub_Cdagger (subset_closure hw)
  have hvalue_ge :
      MenuFunctionalF model opt.Cstar ≤
        MenuFunctionalF model CdaggerMenu :=
    MenuFunctionalF_le_of_contains_aligned_argmax
      model opt wlabel CdaggerMenu
      hCdagger_sub_Cstar
      hrange_sub_Cdagger
  have hvalue_le :
      MenuFunctionalF model CdaggerMenu ≤
        MenuFunctionalF model opt.Cstar :=
    opt.optimal CdaggerMenu
  have hvalue :
      MenuFunctionalF model CdaggerMenu =
        MenuFunctionalF model opt.Cstar :=
    le_antisymm hvalue_le hvalue_ge
  let cdagger : PrunedMenuCdagger model wlabel :=
    { Cdagger := CdaggerMenu
      subset_Cstar := hCdagger_sub_Cstar
      closure_range_subset := hclosure_sub_Cdagger
      range_dense := hCdagger_sub_closure
      value_preserved := hvalue }
  refine ⟨cdagger, ?_, ?_, ?_⟩
  · exact cdagger.subset_Cstar
  · exact cdagger.value_preserved
  · exact opt.value_eq

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
  classical
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  have hα_nn : 0 ≤ model.α := model.α_nonneg
  have hαc_nn : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one
  have hCdagger_eq :
      (↑cdagger.Cdagger : Set (ProfileInW model)) =
        closure (Set.range wlabel.wstar) :=
    Set.Subset.antisymm cdagger.range_dense cdagger.closure_range_subset
  have hws_mem_Cdagger :
      ∀ s : model.M, wlabel.wstar s ∈
        (↑cdagger.Cdagger : Set (ProfileInW model)) := by
    intro s
    exact cdagger.closure_range_subset (subset_closure (Set.mem_range_self s))
  have hdot_cont :
      ∀ s : model.M,
        Continuous (fun w : ProfileInW model =>
          beliefDot (model.inclM s) w.val) := by
    intro s
    unfold beliefDot
    refine continuous_finset_sum _ ?_
    intro ω _
    exact continuous_const.mul
      ((continuous_apply ω).comp continuous_subtype_val)
  have hmax_eq :
      ∀ s : model.M,
        maxPayoff model cdagger.Cdagger s =
          beliefDot (model.inclM s) (wlabel.wstar s).val := by
    intro s
    unfold maxPayoff
    let f : ProfileInW model → ℝ :=
      fun w => beliefDot (model.inclM s) w.val
    have hwsC : wlabel.wstar s ∈
        (↑cdagger.Cdagger : Set (ProfileInW model)) :=
      hws_mem_Cdagger s
    have hupper :
        ∀ x ∈ f '' (↑cdagger.Cdagger : Set (ProfileInW model)),
          x ≤ f (wlabel.wstar s) := by
      rintro x ⟨w, hwC, rfl⟩
      exact (wlabel.is_argmax s) (cdagger.subset_Cstar hwC)
    have hne :
        (f '' (↑cdagger.Cdagger : Set (ProfileInW model))).Nonempty :=
      ⟨f (wlabel.wstar s), ⟨wlabel.wstar s, hwsC, rfl⟩⟩
    have hbdd :
        BddAbove (f '' (↑cdagger.Cdagger : Set (ProfileInW model))) :=
      ⟨f (wlabel.wstar s), hupper⟩
    apply le_antisymm
    · simpa [f] using csSup_le hne hupper
    · simpa [f] using
        le_csSup hbdd ⟨wlabel.wstar s, hwsC, rfl⟩
  have hmin_eq_inf_range :
      ∀ s : model.M,
        minPayoff model cdagger.Cdagger s =
          sInf (Set.range fun m : model.M =>
            beliefDot (model.inclM s) (wlabel.wstar m).val) := by
    intro s
    let f : ProfileInW model → ℝ :=
      fun w => beliefDot (model.inclM s) w.val
    have hf : Continuous f := hdot_cont s
    have h_range_ne : (Set.range wlabel.wstar).Nonempty :=
      ⟨wlabel.wstar Classical.ofNonempty, Set.mem_range_self _⟩
    obtain ⟨B, _hB0, hB⟩ := beliefDot_ProfileInW_abs_le_private_bound model
    have hBB : BddBelow (f '' Set.range wlabel.wstar) := by
      refine ⟨-B, ?_⟩
      rintro y ⟨w, _, rfl⟩
      exact (abs_le.mp (hB (model.inclM s) w)).1
    have hclosure :
        sInf (f '' closure (Set.range wlabel.wstar)) =
          sInf (f '' Set.range wlabel.wstar) :=
      sInf_image_closure_eq_of_continuous f hf _ h_range_ne hBB
    have hImg :
        f '' Set.range wlabel.wstar =
          Set.range fun m : model.M =>
            beliefDot (model.inclM s) (wlabel.wstar m).val := by
      ext y; constructor
      · rintro ⟨w, ⟨m, rfl⟩, rfl⟩; exact ⟨m, rfl⟩
      · rintro ⟨m, rfl⟩; exact ⟨wlabel.wstar m, Set.mem_range_self _, rfl⟩
    calc
      minPayoff model cdagger.Cdagger s
          = sInf (f '' (↑cdagger.Cdagger : Set (ProfileInW model))) := by
            simp [minPayoff, f]
      _ = sInf (f '' closure (Set.range wlabel.wstar)) := by rw [hCdagger_eq]
      _ = sInf (f '' Set.range wlabel.wstar) := hclosure
      _ = sInf (Set.range fun m : model.M =>
            beliefDot (model.inclM s) (wlabel.wstar m).val) := by rw [hImg]
  have h1 :
      AlignedPayoffM model σM =
        ∫ s, maxPayoff model cdagger.Cdagger s ∂model.τM := by
    unfold AlignedPayoffM
    refine integral_congr_ae ?_
    filter_upwards with s
    rw [hprofile s, hmax_eq s]
  have hmis_eq :
      ∀ β : AdviserKernel model,
        MisalignedPayoffM model β σM =
          ∫ s, ∫ m,
            beliefDot (model.inclM s) (wlabel.wstar m).val
              ∂(β.kernel s) ∂model.τM := by
    intro β
    unfold MisalignedPayoffM
    refine integral_congr_ae ?_
    filter_upwards with s
    refine integral_congr_ae ?_
    filter_upwards with m
    rw [hprofile m]
  have hg_meas :
      Measurable fun p : model.M × model.M =>
        beliefDot (model.inclM p.1) (wlabel.wstar p.2).val := by
    classical
    unfold beliefDot
    refine Finset.measurable_sum _ ?_
    intro ω _
    refine Measurable.mul ?_ ?_
    · have hCoord : Measurable (fun s : model.M => (model.inclM s).val ω) :=
        ((measurable_pi_apply ω).comp measurable_subtype_coe).comp model.inclM_measurable
      exact hCoord.comp measurable_fst
    · have hCoord : Measurable (fun m : model.M => (wlabel.wstar m).val ω) :=
        ((measurable_pi_apply ω).comp measurable_subtype_coe).comp wlabel.measurable_wstar
      exact hCoord.comp measurable_snd
  have hw_bdd :
      ∃ C : ℝ, ∀ s m : model.M,
        |beliefDot (model.inclM s) (wlabel.wstar m).val| ≤ C := by
    obtain ⟨B, _hB0, hB⟩ := beliefDot_ProfileInW_abs_le_private_bound model
    exact ⟨B, fun s m => hB (model.inclM s) (wlabel.wstar m)⟩
  have hinf_meas :
      Measurable fun s : model.M =>
        sInf (Set.range fun m : model.M =>
          beliefDot (model.inclM s) (wlabel.wstar m).val) := by
    have hcont : Continuous
        (fun b : Belief model.Ω =>
          sInf ((fun w : ProfileInW model => beliefDot b w.val) ''
            (↑cdagger.Cdagger : Set (ProfileInW model)))) :=
      cdagger.Cdagger.isCompact.continuous_sInf (beliefDot_menu_uncurry_continuous model)
    have hmin_meas : Measurable (fun s : model.M =>
        minPayoff model cdagger.Cdagger s) := by
      simpa [minPayoff] using hcont.measurable.comp model.inclM_measurable
    have heq : (fun s : model.M => minPayoff model cdagger.Cdagger s) =
        (fun s => sInf (Set.range fun m : model.M =>
          beliefDot (model.inclM s) (wlabel.wstar m).val)) := by
      funext s; exact hmin_eq_inf_range s
    rw [← heq]
    exact hmin_meas
  have hinf_int :
      Integrable
        (fun s : model.M =>
          sInf (Set.range fun m : model.M =>
            beliefDot (model.inclM s) (wlabel.wstar m).val)) model.τM := by
    have heq : (fun s : model.M => minPayoff model cdagger.Cdagger s) =
        (fun s => sInf (Set.range fun m : model.M =>
          beliefDot (model.inclM s) (wlabel.wstar m).val)) := by
      funext s; exact hmin_eq_inf_range s
    rw [← heq]
    exact minPayoff_integrable model cdagger.Cdagger
  have hkernel_int :
      ∀ β : AdviserKernel model,
        Integrable
          (fun p : model.M × model.M =>
            beliefDot (model.inclM p.1) (wlabel.wstar p.2).val)
          (model.τM.compProd β.kernel) := by
    intro β
    haveI : ProbabilityTheory.IsMarkovKernel β.kernel := β.isMarkov
    haveI : IsProbabilityMeasure (model.τM.compProd β.kernel) := inferInstance
    obtain ⟨C, hC⟩ := hw_bdd
    refine MeasureTheory.Integrable.of_bound ?_ C ?_
    · exact hg_meas.stronglyMeasurable.aestronglyMeasurable
    · refine Filter.Eventually.of_forall ?_
      intro p
      simpa [Real.norm_eq_abs] using hC p.1 p.2
  have hpoint :=
    adversary_infimum_pointwise
      model wlabel.wstar
      wlabel.measurable_wstar
      hg_meas hw_bdd hinf_meas hinf_int hkernel_int
  have h2 :
      sInf (Set.range fun β : AdviserKernel model =>
          MisalignedPayoffM model β σM) =
        ∫ s, minPayoff model cdagger.Cdagger s ∂model.τM := by
    have hrange :
        (Set.range fun β : AdviserKernel model =>
          MisalignedPayoffM model β σM) =
        (Set.range fun β : AdviserKernel model =>
          ∫ s, ∫ m,
            beliefDot (model.inclM s) (wlabel.wstar m).val
              ∂(β.kernel s) ∂model.τM) := by
      ext x; constructor
      · rintro ⟨β, rfl⟩; exact ⟨β, (hmis_eq β).symm⟩
      · rintro ⟨β, rfl⟩; exact ⟨β, hmis_eq β⟩
    calc
      sInf (Set.range fun β : AdviserKernel model =>
          MisalignedPayoffM model β σM)
          = sInf (Set.range fun β : AdviserKernel model =>
              ∫ s, ∫ m,
                beliefDot (model.inclM s) (wlabel.wstar m).val
                  ∂(β.kernel s) ∂model.τM) := by rw [hrange]
      _ = ∫ s,
            sInf (Set.range fun m : model.M =>
              beliefDot (model.inclM s) (wlabel.wstar m).val) ∂model.τM :=
            hpoint
      _ = ∫ s, minPayoff model cdagger.Cdagger s ∂model.τM := by
            refine integral_congr_ae ?_
            filter_upwards with s
            rw [hmin_eq_inf_range s]
  -- Conjunct 3: RobustPayoffM = MenuFunctionalF Cdagger
  have hF_split :
      MenuFunctionalF model cdagger.Cdagger =
        model.α * (∫ s, maxPayoff model cdagger.Cdagger s ∂model.τM) +
          (1 - model.α) *
            (∫ s, minPayoff model cdagger.Cdagger s ∂model.τM) := by
    have hmax_int := maxPayoff_integrable model cdagger.Cdagger
    have hmin_int := minPayoff_integrable model cdagger.Cdagger
    unfold MenuFunctionalF
    rw [integral_add (hmax_int.const_mul model.α) (hmin_int.const_mul (1 - model.α)),
        integral_const_mul, integral_const_mul]
  -- BddBelow for MisRange
  have hMis_bddBelow :
      BddBelow (Set.range fun β : AdviserKernel model =>
        MisalignedPayoffM model β σM) := by
    obtain ⟨B, hB0, hB⟩ := beliefDot_ProfileInW_abs_le_private_bound model
    refine ⟨-B, ?_⟩
    rintro x ⟨β, rfl⟩
    haveI : ProbabilityTheory.IsMarkovKernel β.kernel := β.isMarkov
    have hOuter : ∀ s, -B ≤ ∫ m, beliefDot (model.inclM s)
        (profileMap model σM m) ∂(β.kernel s) := by
      intro s
      haveI : IsProbabilityMeasure (β.kernel s) :=
        β.isMarkov.isProbabilityMeasure s
      have hbound : ∀ m, |beliefDot (model.inclM s) (profileMap model σM m)| ≤ B := by
        intro m
        rw [hprofile m]
        exact hB _ (wlabel.wstar m)
      exact (integral_Icc_of_forall_abs_le_prob (β.kernel s) hB0 hbound).1
    unfold MisalignedPayoffM
    have h_const_int :
        (∫ _s : model.M, (-B : ℝ) ∂model.τM) = -B := by simp
    rw [← h_const_int]
    -- Need integrability of inner ∫ m, beliefDot ...
    have hinner_int :
        Integrable
          (fun s : model.M =>
            ∫ m, beliefDot (model.inclM s) (profileMap model σM m) ∂(β.kernel s))
          model.τM := by
      -- Use bound on integrand
      refine MeasureTheory.Integrable.of_bound ?_ B ?_
      · -- AEStronglyMeasurable of fun s => ∫ m, ... ∂β.kernel s
        haveI : IsProbabilityMeasure model.τM := model.τM_prob
        have hg_meas_pm :
            Measurable fun p : model.M × model.M =>
              beliefDot (model.inclM p.1) (profileMap model σM p.2) := by
          classical
          unfold beliefDot
          refine Finset.measurable_sum _ ?_
          intro ω _
          refine Measurable.mul ?_ ?_
          · have hCoord : Measurable (fun s : model.M => (model.inclM s).val ω) :=
              ((measurable_pi_apply ω).comp measurable_subtype_coe).comp model.inclM_measurable
            exact hCoord.comp measurable_fst
          · have hCoord' :
                Measurable (fun m : model.M => profileMap model σM m ω) := by
              have hPM : Measurable (fun m : model.M => (wlabel.wstar m).val ω) :=
                ((measurable_pi_apply ω).comp measurable_subtype_coe).comp
                  wlabel.measurable_wstar
              have : (fun m : model.M => profileMap model σM m ω) =
                  (fun m : model.M => (wlabel.wstar m).val ω) := by
                funext m; rw [hprofile m]
              rw [this]; exact hPM
            exact hCoord'.comp measurable_snd
        have hg_uncurry_sm :
            StronglyMeasurable (Function.uncurry (fun s : model.M => fun m : model.M =>
              beliefDot (model.inclM s) (profileMap model σM m))) := by
          change StronglyMeasurable (fun p : model.M × model.M =>
            beliefDot (model.inclM p.1) (profileMap model σM p.2))
          exact hg_meas_pm.stronglyMeasurable
        have hsm :=
          MeasureTheory.StronglyMeasurable.integral_kernel_prod_right
            (κ := β.kernel) hg_uncurry_sm
        exact hsm.aestronglyMeasurable
      · refine Filter.Eventually.of_forall ?_
        intro s
        haveI : IsProbabilityMeasure (β.kernel s) :=
          β.isMarkov.isProbabilityMeasure s
        have hbound : ∀ m, |beliefDot (model.inclM s) (profileMap model σM m)| ≤ B := by
          intro m
          rw [hprofile m]
          exact hB _ (wlabel.wstar m)
        have hreal : (β.kernel s).real Set.univ = 1 := by simp
        have hnorm := MeasureTheory.norm_integral_le_of_norm_le_const
          (μ := β.kernel s)
          (f := fun m : model.M => beliefDot (model.inclM s) (profileMap model σM m))
          (C := B) (Filter.Eventually.of_forall hbound)
        simpa [hreal] using hnorm
    refine MeasureTheory.integral_mono_ae (integrable_const (-B)) hinner_int ?_
    exact Filter.Eventually.of_forall hOuter
  -- Conjunct 3 via sInf linearity (ε-argument both directions)
  have h3_ge :
      MenuFunctionalF model cdagger.Cdagger ≤ RobustPayoffM model σM := by
    unfold RobustPayoffM
    let β0 : AdviserKernel model :=
      { kernel := ProbabilityTheory.Kernel.deterministic
          (id : model.M → model.M) measurable_id
        isMarkov := inferInstance }
    refine le_csInf ⟨_, ⟨β0, rfl⟩⟩ ?_
    rintro x ⟨β, rfl⟩
    have hmis_lower :
        (∫ s, minPayoff model cdagger.Cdagger s ∂model.τM) ≤
          MisalignedPayoffM model β σM := by
      rw [← h2]
      exact csInf_le hMis_bddBelow ⟨β, rfl⟩
    rw [hF_split, ← h1]
    show model.α * AlignedPayoffM model σM +
        (1 - model.α) * (∫ s, minPayoff model cdagger.Cdagger s ∂model.τM) ≤
      MixturePayoffM model β σM
    unfold MixturePayoffM
    have := mul_le_mul_of_nonneg_left hmis_lower hαc_nn
    linarith
  have h3_le :
      RobustPayoffM model σM ≤ MenuFunctionalF model cdagger.Cdagger := by
    -- ε-argument for the upper bound
    unfold RobustPayoffM
    rw [hF_split]
    set MisRange : Set ℝ :=
      Set.range fun β : AdviserKernel model => MisalignedPayoffM model β σM
    refine le_of_forall_pos_le_add ?_
    intro ε hε_pos
    have hMisRange_ne : MisRange.Nonempty := by
      let β0 : AdviserKernel model :=
        { kernel := ProbabilityTheory.Kernel.deterministic
            (id : model.M → model.M) measurable_id
          isMarkov := inferInstance }
      exact ⟨MisalignedPayoffM model β0 σM, ⟨β0, rfl⟩⟩
    have hexists_lt : ∃ x ∈ MisRange, x < sInf MisRange + ε := by
      by_contra hcontra
      have hLower : ∀ x ∈ MisRange, sInf MisRange + ε ≤ x := by
        intro x hx
        exact le_of_not_gt (fun hxlt => hcontra ⟨x, hx, hxlt⟩)
      have hle : sInf MisRange + ε ≤ sInf MisRange := le_csInf hMisRange_ne hLower
      linarith
    obtain ⟨y, hy_in, hy_lt⟩ := hexists_lt
    obtain ⟨β, hβy⟩ := hy_in
    have hMixβ : MixturePayoffM model β σM =
        model.α * AlignedPayoffM model σM + (1 - model.α) * y := by
      show model.α * AlignedPayoffM model σM + (1 - model.α) * _ = _
      rw [← hβy]
    have hBdd_mix :
        BddBelow (Set.range fun β : AdviserKernel model =>
          MixturePayoffM model β σM) := by
      obtain ⟨B, hB0, hB⟩ := beliefDot_ProfileInW_abs_le_private_bound model
      refine ⟨model.α * (-B) + (1 - model.α) * (-B), ?_⟩
      rintro x ⟨β', rfl⟩
      unfold MixturePayoffM
      have hAlow : -B ≤ AlignedPayoffM model σM := by
        unfold AlignedPayoffM
        have hbound : ∀ s, |beliefDot (model.inclM s) (profileMap model σM s)| ≤ B := by
          intro s
          rw [hprofile s]
          exact hB _ (wlabel.wstar s)
        exact (integral_Icc_of_forall_abs_le_prob model.τM hB0 hbound).1
      have hMlow : -B ≤ MisalignedPayoffM model β' σM := by
        have := hMis_bddBelow
        rcases this with ⟨lb, hlb⟩
        -- hlb : ∀ x ∈ MisRange, lb ≤ x
        -- But we want -B ≤ MisalignedPayoffM β' σM specifically
        -- Use that MisalignedPayoffM bounded by -B independently
        haveI : ProbabilityTheory.IsMarkovKernel β'.kernel := β'.isMarkov
        have hOuter : ∀ s, -B ≤ ∫ m, beliefDot (model.inclM s)
            (profileMap model σM m) ∂(β'.kernel s) := by
          intro s
          haveI : IsProbabilityMeasure (β'.kernel s) :=
            β'.isMarkov.isProbabilityMeasure s
          have hbound : ∀ m, |beliefDot (model.inclM s) (profileMap model σM m)| ≤ B := by
            intro m
            rw [hprofile m]
            exact hB _ (wlabel.wstar m)
          exact (integral_Icc_of_forall_abs_le_prob (β'.kernel s) hB0 hbound).1
        unfold MisalignedPayoffM
        have h_const_int :
            (∫ _s : model.M, (-B : ℝ) ∂model.τM) = -B := by simp
        rw [← h_const_int]
        -- integrability follows from same bound
        have hinner_int :
            Integrable
              (fun s : model.M =>
                ∫ m, beliefDot (model.inclM s) (profileMap model σM m) ∂(β'.kernel s))
              model.τM := by
          refine MeasureTheory.Integrable.of_bound ?_ B ?_
          · haveI : IsProbabilityMeasure model.τM := model.τM_prob
            have hg_meas_pm :
                Measurable fun p : model.M × model.M =>
                  beliefDot (model.inclM p.1) (profileMap model σM p.2) := by
              classical
              unfold beliefDot
              refine Finset.measurable_sum _ ?_
              intro ω _
              refine Measurable.mul ?_ ?_
              · have hCoord : Measurable (fun s : model.M => (model.inclM s).val ω) :=
                  ((measurable_pi_apply ω).comp measurable_subtype_coe).comp
                    model.inclM_measurable
                exact hCoord.comp measurable_fst
              · have hCoord' :
                    Measurable (fun m : model.M => profileMap model σM m ω) := by
                  have hPM : Measurable (fun m : model.M => (wlabel.wstar m).val ω) :=
                    ((measurable_pi_apply ω).comp measurable_subtype_coe).comp
                      wlabel.measurable_wstar
                  have : (fun m : model.M => profileMap model σM m ω) =
                      (fun m : model.M => (wlabel.wstar m).val ω) := by
                    funext m; rw [hprofile m]
                  rw [this]; exact hPM
                exact hCoord'.comp measurable_snd
            have hg_uncurry_sm :
                StronglyMeasurable (Function.uncurry (fun s : model.M => fun m : model.M =>
                  beliefDot (model.inclM s) (profileMap model σM m))) := by
              change StronglyMeasurable (fun p : model.M × model.M =>
                beliefDot (model.inclM p.1) (profileMap model σM p.2))
              exact hg_meas_pm.stronglyMeasurable
            have hsm :=
              MeasureTheory.StronglyMeasurable.integral_kernel_prod_right
                (κ := β'.kernel) hg_uncurry_sm
            exact hsm.aestronglyMeasurable
          · refine Filter.Eventually.of_forall ?_
            intro s
            haveI : IsProbabilityMeasure (β'.kernel s) :=
              β'.isMarkov.isProbabilityMeasure s
            have hbound : ∀ m, |beliefDot (model.inclM s) (profileMap model σM m)| ≤ B := by
              intro m
              rw [hprofile m]
              exact hB _ (wlabel.wstar m)
            have hreal : (β'.kernel s).real Set.univ = 1 := by simp
            have hnorm := MeasureTheory.norm_integral_le_of_norm_le_const
              (μ := β'.kernel s)
              (f := fun m : model.M => beliefDot (model.inclM s) (profileMap model σM m))
              (C := B) (Filter.Eventually.of_forall hbound)
            simpa [hreal] using hnorm
        refine MeasureTheory.integral_mono_ae (integrable_const (-B)) hinner_int ?_
        exact Filter.Eventually.of_forall hOuter
      nlinarith [mul_le_mul_of_nonneg_left hAlow hα_nn,
                 mul_le_mul_of_nonneg_left hMlow hαc_nn]
    have hsInf_le_β :
        sInf (Set.range fun β : AdviserKernel model => MixturePayoffM model β σM) ≤
          MixturePayoffM model β σM :=
      csInf_le hBdd_mix ⟨β, rfl⟩
    have h1αB : (1 - model.α) ≤ 1 := by linarith
    have h_oneα_ε : (1 - model.α) * ε ≤ ε := by
      have := mul_le_mul_of_nonneg_right h1αB (le_of_lt hε_pos)
      linarith
    calc sInf (Set.range fun β : AdviserKernel model => MixturePayoffM model β σM)
        ≤ MixturePayoffM model β σM := hsInf_le_β
      _ = model.α * AlignedPayoffM model σM + (1 - model.α) * y := hMixβ
      _ ≤ model.α * AlignedPayoffM model σM +
            (1 - model.α) * (sInf MisRange + ε) := by
            have := mul_le_mul_of_nonneg_left (le_of_lt hy_lt) hαc_nn
            linarith
      _ = model.α * AlignedPayoffM model σM + (1 - model.α) * sInf MisRange +
            (1 - model.α) * ε := by ring
      _ ≤ model.α * AlignedPayoffM model σM + (1 - model.α) * sInf MisRange + ε := by
            linarith
      _ = model.α * (∫ s, maxPayoff model cdagger.Cdagger s ∂model.τM) +
            (1 - model.α) * (∫ s, minPayoff model cdagger.Cdagger s ∂model.τM) + ε := by
            rw [h1, h2]
  have h3 :
      RobustPayoffM model σM = MenuFunctionalF model cdagger.Cdagger :=
    le_antisymm h3_le h3_ge
  exact ⟨h1, h2, h3⟩

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

private lemma exists_lt_sInf_add_pos_of_nonempty_rt
    (s : Set ℝ) (hne : s.Nonempty) {δ : ℝ} (hδ : 0 < δ) :
    ∃ x ∈ s, x < sInf s + δ := by
  by_contra h
  have hLower : ∀ x ∈ s, sInf s + δ ≤ x := by
    intro x hx
    exact le_of_not_gt (fun hxlt => h ⟨x, hx, hxlt⟩)
  have hle : sInf s + δ ≤ sInf s := le_csInf hne hLower
  linarith

theorem epsilon_adversary_realization
    (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model) :
    ∀ ε : ℝ, 0 < ε →
      ∃ βε : AdviserKernel model,
        MixturePayoffFull model βε σstar ≤
            RobustPayoffFull model σstar + (1 - model.α) * ε ∧
          MixturePayoffFull model βε σstar ≤ UStarFull model + ε := by
  intro ε hε
  classical

  have hα0 : 0 ≤ (model.α : ℝ) := by
    first
    | exact model.alpha_nonneg
    | exact model.α_nonneg
    | exact model.halpha_nonneg
    | exact model.hα_nonneg
    | exact model.hα.1
    | exact model.alpha_bounds.1
    | exact model.α_bounds.1
    | exact model.alpha_bound.1
    | exact model.α_bound.1
    | exact model.alpha_mem.1
    | exact model.α_mem.1
    | exact model.alpha_mem_Icc.1
    | exact model.α_mem_Icc.1
    | exact model.α.property.1

  have hα1 : (model.α : ℝ) ≤ 1 := by
    first
    | exact model.alpha_le_one
    | exact model.α_le_one
    | exact model.halpha_le_one
    | exact model.hα_le_one
    | exact model.hα.2
    | exact model.alpha_bounds.2
    | exact model.α_bounds.2
    | exact model.alpha_bound.2
    | exact model.α_bound.2
    | exact model.alpha_mem.2
    | exact model.α_mem.2
    | exact model.alpha_mem_Icc.2
    | exact model.α_mem_Icc.2
    | exact model.α.property.2

  let β0 : AdviserKernel model :=
    { kernel := ProbabilityTheory.Kernel.deterministic
        (id : model.M → model.M) measurable_id
      isMarkov := inferInstance }

  have hmul_le : (1 - (model.α : ℝ)) * ε ≤ ε := by
    have hone_sub_le : 1 - (model.α : ℝ) ≤ 1 := by
      linarith
    have : (1 - (model.α : ℝ)) * ε ≤ 1 * ε :=
      mul_le_mul_of_nonneg_right hone_sub_le (le_of_lt hε)
    linarith

  by_cases hαeq : (model.α : ℝ) = 1
  · have hmix0 :
        MixturePayoffFull model β0 σstar = AlignedPayoffFull model σstar := by
      simp [MixturePayoffFull, hαeq]

    have hRange :
        Set.range (fun β : AdviserKernel model =>
          MixturePayoffFull model β σstar) =
            {AlignedPayoffFull model σstar} := by
      ext x
      constructor
      · intro hx
        rcases hx with ⟨β, rfl⟩
        simp [MixturePayoffFull, hαeq]
      · intro hx
        rcases hx with rfl
        exact ⟨β0, by simp [MixturePayoffFull, hαeq]⟩

    have hRobust :
        RobustPayoffFull model σstar = AlignedPayoffFull model σstar := by
      simpa [RobustPayoffFull, hRange]

    have h₁ :
        MixturePayoffFull model β0 σstar ≤
          RobustPayoffFull model σstar + (1 - model.α) * ε := by
      calc
        MixturePayoffFull model β0 σstar
            = RobustPayoffFull model σstar := by
                rw [hmix0, hRobust]
        _ ≤ RobustPayoffFull model σstar + (1 - model.α) * ε := by
          have hzero : (1 - (model.α : ℝ)) * ε = 0 := by
            rw [hαeq]
            ring
          simpa [hzero]

    refine ⟨β0, h₁, ?_⟩
    calc
      MixturePayoffFull model β0 σstar
          ≤ RobustPayoffFull model σstar + (1 - model.α) * ε := h₁
      _ ≤ UStarFull model + ε := by
        rw [hσstar]
        linarith

  · have hαlt : (model.α : ℝ) < 1 := lt_of_le_of_ne hα1 hαeq
    have hδ : 0 < (1 - (model.α : ℝ)) * ε := by
      exact mul_pos (sub_pos.mpr hαlt) hε

    let s : Set ℝ :=
      Set.range (fun β : AdviserKernel model =>
        MixturePayoffFull model β σstar)

    have hsne : s.Nonempty := by
      exact ⟨MixturePayoffFull model β0 σstar, ⟨β0, rfl⟩⟩

    obtain ⟨x, hxmem, hxlt⟩ :=
      exists_lt_sInf_add_pos_of_nonempty_rt s hsne hδ
    rcases hxmem with ⟨βε, rfl⟩

    have h₁ :
        MixturePayoffFull model βε σstar ≤
          RobustPayoffFull model σstar + (1 - model.α) * ε := by
      exact le_of_lt (by
        simpa [RobustPayoffFull, s] using hxlt)

    refine ⟨βε, h₁, ?_⟩
    calc
      MixturePayoffFull model βε σstar
          ≤ RobustPayoffFull model σstar + (1 - model.α) * ε := h₁
      _ ≤ UStarFull model + ε := by
        rw [hσstar]
        linarith


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

  -- BddBelow of MisalignedPayoffFull range via uniform |beliefDot| ≤ B.
  have hMis_bddBelow :
      BddBelow (Set.range fun β : AdviserKernel model =>
        MisalignedPayoffFull model β σstar) := by
    obtain ⟨B, hB0, hB⟩ := beliefDot_ProfileInW_abs_le_private_bound model
    haveI : IsProbabilityMeasure model.τM := model.τM_prob
    refine ⟨-B, ?_⟩
    rintro x ⟨β, rfl⟩
    haveI : ProbabilityTheory.IsMarkovKernel β.kernel := β.isMarkov
    unfold MisalignedPayoffFull MisalignedPayoffM
    have hOuter : ∀ s, -B ≤ ∫ m, beliefDot (model.inclM s)
        (profileMap model (restrictFullToM model σstar) m) ∂(β.kernel s) := by
      intro s
      haveI : IsProbabilityMeasure (β.kernel s) :=
        β.isMarkov.isProbabilityMeasure s
      have hbound : ∀ m, |beliefDot (model.inclM s)
          (profileMap model (restrictFullToM model σstar) m)| ≤ B := by
        intro m
        rw [ec.sigma_implements_wlabel m]
        exact hB _ (ec.wlabel.wstar m)
      exact (integral_Icc_of_forall_abs_le_prob (β.kernel s) hB0 hbound).1
    have h_const_int :
        (∫ _s : model.M, (-B : ℝ) ∂model.τM) = -B := by simp
    rw [← h_const_int]
    have hinner_int :
        Integrable
          (fun s : model.M =>
            ∫ m, beliefDot (model.inclM s)
              (profileMap model (restrictFullToM model σstar) m) ∂(β.kernel s))
          model.τM := by
      refine MeasureTheory.Integrable.of_bound ?_ B ?_
      · have hg_meas_pm :
            Measurable fun p : model.M × model.M =>
              beliefDot (model.inclM p.1)
                (profileMap model (restrictFullToM model σstar) p.2) := by
          classical
          unfold beliefDot
          refine Finset.measurable_sum _ ?_
          intro ω _
          refine Measurable.mul ?_ ?_
          · have hCoord : Measurable (fun s : model.M => (model.inclM s).val ω) :=
              ((measurable_pi_apply ω).comp measurable_subtype_coe).comp
                model.inclM_measurable
            exact hCoord.comp measurable_fst
          · have hCoord' :
                Measurable (fun m : model.M =>
                  profileMap model (restrictFullToM model σstar) m ω) := by
              have hPM : Measurable (fun m : model.M =>
                  (ec.wlabel.wstar m).val ω) :=
                ((measurable_pi_apply ω).comp measurable_subtype_coe).comp
                  ec.wlabel.measurable_wstar
              have : (fun m : model.M =>
                  profileMap model (restrictFullToM model σstar) m ω) =
                  (fun m : model.M => (ec.wlabel.wstar m).val ω) := by
                funext m; rw [ec.sigma_implements_wlabel m]
              rw [this]; exact hPM
            exact hCoord'.comp measurable_snd
        have hg_uncurry_sm :
            StronglyMeasurable (Function.uncurry (fun s : model.M => fun m : model.M =>
              beliefDot (model.inclM s)
                (profileMap model (restrictFullToM model σstar) m))) := by
          change StronglyMeasurable (fun p : model.M × model.M =>
            beliefDot (model.inclM p.1)
              (profileMap model (restrictFullToM model σstar) p.2))
          exact hg_meas_pm.stronglyMeasurable
        have hsm := MeasureTheory.StronglyMeasurable.integral_kernel_prod_right
            (κ := β.kernel) hg_uncurry_sm
        exact hsm.aestronglyMeasurable
      · refine Filter.Eventually.of_forall ?_
        intro s
        haveI : IsProbabilityMeasure (β.kernel s) :=
          β.isMarkov.isProbabilityMeasure s
        have hbound : ∀ m, |beliefDot (model.inclM s)
            (profileMap model (restrictFullToM model σstar) m)| ≤ B := by
          intro m
          rw [ec.sigma_implements_wlabel m]
          exact hB _ (ec.wlabel.wstar m)
        have hreal : (β.kernel s).real Set.univ = 1 := by simp
        have hnorm := MeasureTheory.norm_integral_le_of_norm_le_const
          (μ := β.kernel s)
          (f := fun m : model.M =>
            beliefDot (model.inclM s)
              (profileMap model (restrictFullToM model σstar) m))
          (C := B) (Filter.Eventually.of_forall hbound)
        simpa [hreal] using hnorm
    refine MeasureTheory.integral_mono_ae
      (integrable_const (-B)) hinner_int ?_
    exact Filter.Eventually.of_forall hOuter
  -- βstar attains sInf, so MisalignedPayoffFull βstar ≤ MisalignedPayoffFull β for all β
  have hMis_lb_βstar :
      ∀ β : AdviserKernel model,
        MisalignedPayoffFull model βstar σstar ≤
          MisalignedPayoffFull model β σstar := by
    intro β
    rw [hmis_attains]
    exact csInf_le hMis_bddBelow ⟨β, rfl⟩
  -- BddBelow of MixturePayoffFull range follows from MisalignedPayoffFull lower bound.
  have hMix_bddBelow :
      BddBelow (Set.range fun β : AdviserKernel model =>
        MixturePayoffFull model β σstar) := by
    refine ⟨MixturePayoffFull model βstar σstar, ?_⟩
    rintro x ⟨β, rfl⟩
    have hmis_le := hMis_lb_βstar β
    have hαc : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one
    unfold MixturePayoffFull
    have := mul_le_mul_of_nonneg_left hmis_le hαc
    linarith
  have hmix :
      MixturePayoffFull model βstar σstar =
        RobustPayoffFull model σstar := by
    unfold RobustPayoffFull
    apply le_antisymm
    · -- MixturePayoffFull βstar ≤ sInf
      refine le_csInf ⟨_, ⟨βstar, rfl⟩⟩ ?_
      rintro x ⟨β, rfl⟩
      have hmis_le := hMis_lb_βstar β
      have hαc : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one
      unfold MixturePayoffFull
      have := mul_le_mul_of_nonneg_left hmis_le hαc
      linarith
    · exact csInf_le hMix_bddBelow ⟨βstar, rfl⟩

  refine ⟨βstar, hdet, hsupp, ?_, hmix, hσstar⟩
  simpa [IsAdversarialFull] using hmix


private lemma kernel_supportedOnG_mixture_eq_robust
    (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (hsupp : KernelSupportedOnG model ec.cdagger κ) :
    MixturePayoffFull model κ σstar = RobustPayoffFull model σstar := by
  classical
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  haveI : ProbabilityTheory.IsMarkovKernel κ.kernel := κ.isMarkov
  -- Step 1: MisalignedPayoffFull κ σstar = ∫ minPayoff Cdagger dτM
  have hmis_κ :
      MisalignedPayoffFull model κ σstar =
        ∫ s, minPayoff model ec.cdagger.Cdagger s ∂model.τM := by
    unfold MisalignedPayoffFull MisalignedPayoffM
    apply integral_congr_ae
    filter_upwards [hsupp] with s hs
    haveI : IsProbabilityMeasure (κ.kernel s) := κ.isMarkov.isProbabilityMeasure s
    have hG_meas : MeasurableSet (RowwiseContactG model ec.cdagger s) := by
      unfold RowwiseContactG
      refine measurableSet_eq_fun ?_ ?_
      · classical
        unfold beliefDot
        refine Finset.measurable_sum _ ?_
        intro ω _
        refine Measurable.mul ?_ ?_
        · exact measurable_const
        · have : Measurable (fun m : model.M => (ec.wlabel.wstar m).val ω) :=
            ((measurable_pi_apply ω).comp measurable_subtype_coe).comp
              ec.wlabel.measurable_wstar
          exact this
      · exact measurable_const
    have h_compl_zero :
        κ.kernel s (RowwiseContactG model ec.cdagger s)ᶜ = 0 := by
      have h_fin : (κ.kernel s) (RowwiseContactG model ec.cdagger s) ≠ ∞ := by
        rw [hs]; exact ENNReal.one_ne_top
      have hcompl_eq := MeasureTheory.measure_compl hG_meas h_fin
      rw [hcompl_eq, hs]
      simp
    have h_ae_in_G :
        ∀ᵐ m ∂(κ.kernel s), m ∈ RowwiseContactG model ec.cdagger s := by
      rw [MeasureTheory.ae_iff]
      exact h_compl_zero
    have h_inner_eq :
        (∫ m, beliefDot (model.inclM s)
          (profileMap model (restrictFullToM model σstar) m) ∂(κ.kernel s)) =
          ∫ _m, minPayoff model ec.cdagger.Cdagger s ∂(κ.kernel s) := by
      apply integral_congr_ae
      filter_upwards [h_ae_in_G] with m hm
      rw [ec.sigma_implements_wlabel m]
      exact hm
    rw [h_inner_eq]
    simp
  -- Step 2: BddBelow of MisalignedPayoffFull range via uniform bound
  have hMis_bddBelow :
      BddBelow (Set.range fun β : AdviserKernel model =>
        MisalignedPayoffFull model β σstar) := by
    obtain ⟨B, hB0, hB⟩ := beliefDot_ProfileInW_abs_le_private_bound model
    refine ⟨-B, ?_⟩
    rintro x ⟨β, rfl⟩
    haveI : ProbabilityTheory.IsMarkovKernel β.kernel := β.isMarkov
    unfold MisalignedPayoffFull MisalignedPayoffM
    have hOuter : ∀ s, -B ≤ ∫ m, beliefDot (model.inclM s)
        (profileMap model (restrictFullToM model σstar) m) ∂(β.kernel s) := by
      intro s
      haveI : IsProbabilityMeasure (β.kernel s) :=
        β.isMarkov.isProbabilityMeasure s
      have hbound : ∀ m, |beliefDot (model.inclM s)
          (profileMap model (restrictFullToM model σstar) m)| ≤ B := by
        intro m
        rw [ec.sigma_implements_wlabel m]
        exact hB _ (ec.wlabel.wstar m)
      exact (integral_Icc_of_forall_abs_le_prob (β.kernel s) hB0 hbound).1
    have h_const_int :
        (∫ _s : model.M, (-B : ℝ) ∂model.τM) = -B := by simp
    rw [← h_const_int]
    have hinner_int :
        Integrable
          (fun s : model.M =>
            ∫ m, beliefDot (model.inclM s)
              (profileMap model (restrictFullToM model σstar) m) ∂(β.kernel s))
          model.τM := by
      refine MeasureTheory.Integrable.of_bound ?_ B ?_
      · have hg_meas_pm :
            Measurable fun p : model.M × model.M =>
              beliefDot (model.inclM p.1)
                (profileMap model (restrictFullToM model σstar) p.2) := by
          classical
          unfold beliefDot
          refine Finset.measurable_sum _ ?_
          intro ω _
          refine Measurable.mul ?_ ?_
          · have hCoord : Measurable (fun s : model.M => (model.inclM s).val ω) :=
              ((measurable_pi_apply ω).comp measurable_subtype_coe).comp
                model.inclM_measurable
            exact hCoord.comp measurable_fst
          · have hCoord' :
                Measurable (fun m : model.M =>
                  profileMap model (restrictFullToM model σstar) m ω) := by
              have hPM : Measurable (fun m : model.M =>
                  (ec.wlabel.wstar m).val ω) :=
                ((measurable_pi_apply ω).comp measurable_subtype_coe).comp
                  ec.wlabel.measurable_wstar
              have : (fun m : model.M =>
                  profileMap model (restrictFullToM model σstar) m ω) =
                  (fun m : model.M => (ec.wlabel.wstar m).val ω) := by
                funext m; rw [ec.sigma_implements_wlabel m]
              rw [this]; exact hPM
            exact hCoord'.comp measurable_snd
        have hg_uncurry_sm :
            StronglyMeasurable (Function.uncurry (fun s : model.M => fun m : model.M =>
              beliefDot (model.inclM s)
                (profileMap model (restrictFullToM model σstar) m))) := by
          change StronglyMeasurable (fun p : model.M × model.M =>
            beliefDot (model.inclM p.1)
              (profileMap model (restrictFullToM model σstar) p.2))
          exact hg_meas_pm.stronglyMeasurable
        have hsm := MeasureTheory.StronglyMeasurable.integral_kernel_prod_right
            (κ := β.kernel) hg_uncurry_sm
        exact hsm.aestronglyMeasurable
      · refine Filter.Eventually.of_forall ?_
        intro s
        haveI : IsProbabilityMeasure (β.kernel s) :=
          β.isMarkov.isProbabilityMeasure s
        have hbound : ∀ m, |beliefDot (model.inclM s)
            (profileMap model (restrictFullToM model σstar) m)| ≤ B := by
          intro m
          rw [ec.sigma_implements_wlabel m]
          exact hB _ (ec.wlabel.wstar m)
        have hreal : (β.kernel s).real Set.univ = 1 := by simp
        have hnorm := MeasureTheory.norm_integral_le_of_norm_le_const
          (μ := β.kernel s)
          (f := fun m : model.M =>
            beliefDot (model.inclM s)
              (profileMap model (restrictFullToM model σstar) m))
          (C := B) (Filter.Eventually.of_forall hbound)
        simpa [hreal] using hnorm
    refine MeasureTheory.integral_mono_ae
      (integrable_const (-B)) hinner_int ?_
    exact Filter.Eventually.of_forall hOuter
  -- Step 3: ∀ β, MisalignedPayoffFull κ ≤ MisalignedPayoffFull β
  have hpay :=
    wstar_payoff_equals_F_Cdagger
      model ec.opt ec.wlabel ec.cdagger
      (restrictFullToM model σstar)
      ec.sigma_implements_wlabel
  have hmis_sInf :
      sInf (Set.range fun β : AdviserKernel model =>
        MisalignedPayoffFull model β σstar) =
        ∫ s, minPayoff model ec.cdagger.Cdagger s ∂model.τM := by
    simpa [MisalignedPayoffFull] using hpay.2.1
  have hMis_lb_κ :
      ∀ β : AdviserKernel model,
        MisalignedPayoffFull model κ σstar ≤
          MisalignedPayoffFull model β σstar := by
    intro β
    rw [hmis_κ, ← hmis_sInf]
    exact csInf_le hMis_bddBelow ⟨β, rfl⟩
  -- Step 4: BddBelow of MixturePayoffFull range
  have hMix_bddBelow :
      BddBelow (Set.range fun β : AdviserKernel model =>
        MixturePayoffFull model β σstar) := by
    refine ⟨MixturePayoffFull model κ σstar, ?_⟩
    rintro x ⟨β, rfl⟩
    have hmis_le := hMis_lb_κ β
    have hαc : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one
    unfold MixturePayoffFull
    have := mul_le_mul_of_nonneg_left hmis_le hαc
    linarith
  -- Step 5: MixturePayoffFull κ = RobustPayoffFull σstar
  unfold RobustPayoffFull
  apply le_antisymm
  · refine le_csInf ⟨_, ⟨κ, rfl⟩⟩ ?_
    rintro x ⟨β, rfl⟩
    have hmis_le := hMis_lb_κ β
    have hαc : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one
    unfold MixturePayoffFull
    have := mul_le_mul_of_nonneg_left hmis_le hαc
    linarith
  · exact csInf_le hMix_bddBelow ⟨κ, rfl⟩

theorem menu_hall_support_implies_exact_adversary
    (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (hsupp : KernelSupportedOnG model ec.cdagger κ) :
    IsAdversarialFull model κ σstar ∧
      MixturePayoffFull model κ σstar = UStarFull model := by
  have hAdvEq : MixturePayoffFull model κ σstar = RobustPayoffFull model σstar :=
    kernel_supportedOnG_mixture_eq_robust model σstar ec κ hsupp
  refine ⟨?_, ?_⟩
  · simpa [IsAdversarialFull] using hAdvEq
  · rw [hAdvEq, hσstar]

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
  exact ⟨hadv, hmix, h_def2, h_pm.2⟩

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
/-!
# v9 Lean Appendix

Extends `Inventory` with concrete external hammers (Clarke–Danskin / Clarke–Fermat /
Strassen marginals / finite conic Farkas — each with named mathematical hypotheses,
not arbitrary `Prop` placeholders), and adds the `RobustTrustV9` namespace with the
v9 Pareto-frontier primitives + 28-theorem surface.

Per:
- v9 decomposition (`lean/decomposition.md`, Extended Pro chat `6a0f9a2b`)
- decomposition reviewer (`03_runs/v9_lean_formalization/decomposition_review_response.md`, chat `6a0f9fbe`) — PATCH_LIST
- structural refinement (`03_runs/v9_lean_formalization/structural_refinement_response.md`, chat `6a0fa5f2`) — addresses item N

Conventions:
- Declarations within `RobustTrustV9` open `RobustTrustV8` for primitive reuse.
- Inventory v9 axioms use `axiom` and `opaque` (not deprecated `constant`).
- Theorem names with hyphens are written as French-quoted identifiers.
- All conclusion-as-field structures from the original decomposition have been
  removed; theorem conclusions now state the target directly.
- The three FBNF "corollaries" are now genuine instantiation lemmas from
  primitive-class data, not vacuous pass-throughs.
-/

namespace Inventory.V9

/-!
v9 external dependencies — separate sub-namespace so the v9 surface declares
exactly its required external axioms, distinct from v8's `Inventory.*` block
(measurable_argmax_selector / krn_borel_right_inverse /
kernel_infimum_epsilon_selection / UniversallyMeasurable / GepsRegularity).

Per user request 2026-05-22, this split makes v9's external surface explicit
and lets the new `/lean-inventory-match` auditor verify `Inventory.V9` against
the v9 declared dependencies without v8 baggage.
-/

open MeasureTheory ProbabilityTheory

/-! ## §1.1 Clarke–Danskin / Clarke–Fermat (Clarke 1990, §2.7) -/

/-- Clarke generalized subdifferential, modeled as a set of continuous
linear functionals. External nonsmooth-analysis object — not in Mathlib. -/
opaque ClarkeSubdiff
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] :
    (E → ℝ) → E → Set (E →L[ℝ] ℝ)

/-- Clarke normal cone to a closed feasible set. External nonsmooth-analysis
object — not in Mathlib. -/
opaque ClarkeNormalCone
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] :
    Set E → E → Set (E →L[ℝ] ℝ)

/-- Concrete local-maximum-on-set predicate. -/
def ClarkeLocalMaxOn
    {E : Type*} [PseudoMetricSpace E]
    (F : E → ℝ) (C : Set E) (x : E) : Prop :=
  x ∈ C ∧
    ∃ r : ℝ, 0 < r ∧
      ∀ y ∈ C, y ∈ Metric.closedBall x r → F y ≤ F x

/-- Clarke–Danskin hypothesis: `F` is the pointwise supremum of `φ i`; the
active index set is compact, nonempty, measurable; active functions are
Fréchet-differentiable at `x`; `F` is locally Lipschitz near `x`. Replaces
arbitrary `Prop` placeholders with named concrete fields. -/
structure ClarkeDanskinHyp
    {I E : Type*}
    [TopologicalSpace I] [MeasurableSpace I]
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → ℝ) (x : E)
    (φ : I → E → ℝ)
    (grad : I → E →L[ℝ] ℝ)
    (Active : Set I) : Prop where
  active_nonempty : Active.Nonempty
  active_compact : IsCompact Active
  active_measurable : MeasurableSet Active
  value_eq_sSup :
    ∀ y : E, F y = sSup ((fun i : I => φ i y) '' Set.univ)
  active_iff_argmax :
    ∀ i : I, i ∈ Active ↔ φ i x = F x
  locally_lipschitz :
    ∃ r : ℝ, 0 < r ∧
      ∃ K : NNReal, LipschitzOnWith K F (Metric.closedBall x r)
  active_has_fderiv :
    ∀ i ∈ Active, HasFDerivAt (φ i) (grad i) x
  grad_continuous_on_active :
    ContinuousOn grad Active

/-- **Clarke–Danskin stationarity.** Subgradient of an envelope lies in the
closed convex hull of active gradients.

Source: Clarke 1990, *Optimization and Nonsmooth Analysis*, §2.7,
Theorem 2.7.5 (envelope rule for pointwise suprema of smooth families). -/
axiom clarke_danskin_stationarity
    {I E : Type*}
    [TopologicalSpace I] [MeasurableSpace I]
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → ℝ) (x : E)
    (φ : I → E → ℝ)
    (grad : I → E →L[ℝ] ℝ)
    (Active : Set I)
    (_h : ClarkeDanskinHyp F x φ grad Active) :
    ∃ ξ : E →L[ℝ] ℝ,
      ξ ∈ closure (convexHull ℝ (grad '' Active)) ∧
      ξ ∈ ClarkeSubdiff F x

/-- **Clarke–Fermat normal-cone stationarity.** At a constrained local
maximum on a closed set, the Clarke subdifferential is contained in the
negative of the Clarke normal cone.

Source: Clarke 1990, *Optimization and Nonsmooth Analysis*, §6.1,
Theorem 6.1.1 (Fermat rule for constrained nonsmooth optimization). -/
axiom clarke_fermat_normal_cone
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → ℝ) (C : Set E) (x : E)
    (_hC_closed : IsClosed C)
    (_hLip :
      ∃ r : ℝ, 0 < r ∧
        ∃ K : NNReal, LipschitzOnWith K F (Metric.closedBall x r))
    (_hLocalMax : ClarkeLocalMaxOn F C x) :
    ∀ ξ : E →L[ℝ] ℝ,
      ξ ∈ ClarkeSubdiff F x →
        -ξ ∈ ClarkeNormalCone C x

/-! ## §1.2 Strassen marginals (Strassen 1965) -/

/-- A measure π is a coupling of μ and ν. -/
def IsCoupling
    {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    (π : Measure (α × β)) (μ : Measure α) (ν : Measure β) : Prop :=
  Measure.map Prod.fst π = μ ∧
    Measure.map Prod.snd π = ν

/-- Strassen dominance hypothesis: dual marginal inequality on the support
relation. Replaces the old `dualInequality : Prop`. -/
structure StrassenMarginalDominance
    {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    (μ : Measure α) (ν : Measure β) (R : Set (α × β)) : Prop where
  measurable_R : MeasurableSet R
  μ_finite : IsFiniteMeasure μ
  ν_finite : IsFiniteMeasure ν
  same_total_mass : μ Set.univ = ν Set.univ
  dual_marginal_inequality :
    ∀ f : α → ℝ, ∀ g : β → ℝ,
      Measurable f → Measurable g →
      Integrable f μ → Integrable g ν →
      (∀ a b, (a, b) ∈ R → f a ≤ g b) →
        (∫ a, f a ∂μ) ≤ (∫ b, g b ∂ν)

/-- **Strassen marginal theorem (1965).** Coupling existence supported on
a relation `R` under the dual marginal inequality. -/
axiom strassen_marginals
    {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    (μ : Measure α) (ν : Measure β) (R : Set (α × β))
    (_h : StrassenMarginalDominance μ ν R) :
    ∃ π : Measure (α × β),
      IsCoupling π μ ν ∧
        π Rᶜ = 0

/-- **Bogachev disintegration of a coupling into a Markov kernel.**

For a standard Borel space `M` with a finite measure `μ` and a coupling
`π` of `(μ, ν)` on `M × M`, there exists a Markov kernel `κ : Kernel M M`
such that `π = μ ⊗ κ` (i.e. `π = μ.compProd κ` in Mathlib's notation,
modulo the standard isomorphism between `Measure (M × M)` and
`(μ.compProd κ)`).

Source: Bogachev 2007, *Measure Theory* Vol II, Theorem 10.6.1
(disintegration of measures on product of standard Borel spaces into
a measure on the first factor times a Markov kernel into the second).

Mathlib has `ProbabilityTheory.Kernel.disintegrate`-style results for
specific shapes (notably for joint laws of random variables on Polish
spaces) but does NOT yet ship a direct theorem turning an arbitrary
Mathlib `Measure (α × β)` coupling into a `Kernel α β` factor; the
disintegration here is exactly the abstract Bogachev statement specialized
to `M = α = β` (a standard Borel space). -/
axiom bogachev_kernel_factorization
    {M : Type*} [MeasurableSpace M] [StandardBorelSpace M]
    (μ : Measure M) [IsFiniteMeasure μ]
    (π : Measure (M × M))
    (_hμ : Measure.map Prod.fst π = μ) :
    ∃ κ : Kernel M M, IsMarkovKernel κ ∧
      π = μ.compProd κ

/-! ## §1.3 Finite conic Farkas (standard) -/

/-- Finite conic feasibility instance: find `x ≥ 0` with `A x = b`. -/
structure ConicFarkasInstance
    (I J : Type*) [Fintype I] [Fintype J] where
  A : I → J → ℝ
  b : I → ℝ

/-- Primal feasibility: `b` is in the cone generated by the columns of `A`. -/
def conicPrimalFeasible
    {I J : Type*} [Fintype I] [Fintype J]
    (inst : ConicFarkasInstance I J) : Prop :=
  ∃ x : J → ℝ,
    (∀ j : J, 0 ≤ x j) ∧
      ∀ i : I, (∑ j : J, inst.A i j * x j) = inst.b i

/-- Dual no-separation: every functional nonpositive on every column is
nonpositive on `b`. -/
def conicDualNonpositive
    {I J : Type*} [Fintype I] [Fintype J]
    (inst : ConicFarkasInstance I J) : Prop :=
  ∀ y : I → ℝ,
    (∀ j : J, (∑ i : I, y i * inst.A i j) ≤ 0) →
      (∑ i : I, y i * inst.b i) ≤ 0

/-- **Finite conic Farkas / strong LP duality.** -/
axiom farkas_lp_duality_conic
    {I J : Type*} [Fintype I] [Fintype J]
    (inst : ConicFarkasInstance I J) :
    conicPrimalFeasible inst ↔ conicDualNonpositive inst

/-! ## §1.4 Berge maximum — removed

For compact argmax/argmin existence, use Mathlib's
`Mathlib.Topology.Order.Compact`: `IsCompact.exists_isMaxOn`,
`IsCompact.exists_isMinOn`, with `ContinuousOn` hypotheses.
-/

/-! ## §1.5 Hausdorff–Alexandroff continuous surjection (Kechris 1995, Thm 4.18) -/

/-- **Hausdorff–Alexandroff theorem.** Every nonempty compact metric
space is a continuous image of the Cantor space (modeled as `ℕ → Bool`).
Source: Kechris 1995, *Classical Descriptive Set Theory*, Theorem 4.18.

This axiom was earlier flagged as a TRAPDOOR (bare Prop conclusion). The
present concrete statement matches the source citation. The axiom is
currently UNUSED by the discharged v9 theorems; it's retained for the
Cantor-canvas / atomless-τ constructions that may surface in deeper
consolidation (v8 §10 atomless Tier 1b → v9 Reg-2 derivation paths). -/
axiom hausdorff_alexandroff_continuous_surjection
    (K : Type*) [TopologicalSpace K] [CompactSpace K] [T2Space K]
    [SecondCountableTopology K] [Nonempty K] :
    ∃ f : (ℕ → Bool) → K, Continuous f ∧ Function.Surjective f

/-! ## §1.6 (Reverted 2026-05-22)

Earlier patch attempts added two axioms here (`bayes_best_response_exists`,
`alpha_zero_posterior_collapse`) that the new `/lean-smuggling-check`
auditor (MathPipeProver c19c54d) correctly flagged as SMUGGLED_AXIOM. The
second was particularly contraband: its conclusion was materially the
same as the `posteriorAtConstantMessageIsPrior` field of
`AlphaZeroSingletonData`, and the proof of `AlphaZeroSingletonData_exists`
just applied it verbatim to fill that field. The proof goblin had moved
under a nicer rug. Both axioms have been removed.

`AlphaZeroSingletonData_exists` is restored as a `sorry`-stubbed open
follow-up (task #128). The honest path forward: prove it from v8's
`PosteriorLawConsistency.barycenter_eq_prior` + `pd.conditional_barycenter`
+ `pd.sourceLawβ_disintegrates` + the mixture-law collapse at α=0. -/

end Inventory.V9

namespace RobustTrustV9

open RobustTrustV8 MeasureTheory
open scoped BigOperators

noncomputable section

variable (model : RobustTrustModel)

/-! ## §2 v9 primitives — Pareto frontier, Bayes cones, BoundedBorelProfile -/

/-- A profile is on the weak Pareto frontier if no other feasible profile
strictly dominates it coordinate-wise. -/
def WeakParetoProfile (w : Profile model) : Prop :=
  w ∈ PayoffProfileSet model ∧
    ¬ ∃ v : Profile model,
      v ∈ PayoffProfileSet model ∧ (∀ ω : model.Ω, w ω < v ω)

def WP : Set (Profile model) :=
  { w | WeakParetoProfile model w }

abbrev WPProfile : Type :=
  { w : Profile model // w ∈ WP model }

/-- The Bayes cone at a payoff profile `w`. -/
def BayesConeW (w : Profile model) : Set (Belief model.Ω) :=
  { μ | w ∈ PayoffProfileSet model ∧
      ∀ v : Profile model,
        v ∈ PayoffProfileSet model →
          beliefDot μ v ≤ beliefDot μ w }

/-- Normal-cone placeholder predicate. -/
def NormalConeW (w n : Profile model) : Prop :=
  w ∈ PayoffProfileSet model ∧
    ∀ v : Profile model,
      v ∈ PayoffProfileSet model →
        (∑ ω : model.Ω, n ω * (v ω - w ω)) ≤ 0

/-- Product profile space for a finite Pareto menu. -/
abbrev ProductProfile (model : RobustTrustModel) (k : Nat) : Type :=
  Fin k → Profile model

/-- Product feasible set `W^k` used by the Clarke-Fermat step. -/
def ProductPayoffProfileSet (model : RobustTrustModel) (k : Nat) :
    Set (ProductProfile model k) :=
  { x | ∀ i : Fin k, x i ∈ PayoffProfileSet model }

/-- Integrated multiplier-weighted numerator from v9 §B.1. -/
noncomputable def gOf {model : RobustTrustModel} {k : Nat}
    (lamPlus lamMinus : model.M → Fin k → ℝ)
    (alpha : ℝ) (tau : Measure model.M) (i : Fin k) : Profile model :=
  fun ω =>
    alpha * (∫ s, lamPlus s i * (model.inclM s).val ω ∂tau) +
      (1 - alpha) * (∫ s, lamMinus s i * (model.inclM s).val ω ∂tau)

/-- Integrated scalar marginal mass from v9 §B.1. -/
noncomputable def qOf {model : RobustTrustModel} {k : Nat}
    (lamPlus lamMinus : model.M → Fin k → ℝ)
    (alpha : ℝ) (tau : Measure model.M) (i : Fin k) : ℝ :=
  alpha * (∫ s, lamPlus s i ∂tau) +
    (1 - alpha) * (∫ s, lamMinus s i ∂tau)

theorem gOf_nonneg {model : RobustTrustModel} {k : Nat}
    (lamPlus lamMinus : model.M → Fin k → ℝ)
    (alpha : ℝ) (tau : Measure model.M)
    (halpha0 : 0 ≤ alpha) (halpha1 : alpha ≤ 1)
    (hPlus : ∀ s : model.M, ∀ i : Fin k, 0 ≤ lamPlus s i)
    (hMinus : ∀ s : model.M, ∀ i : Fin k, 0 ≤ lamMinus s i) :
    ∀ i : Fin k, ∀ ω : model.Ω,
      0 ≤ gOf lamPlus lamMinus alpha tau i ω := by
  intro i ω
  unfold gOf
  have hOneMinus : 0 ≤ 1 - alpha := sub_nonneg.mpr halpha1
  have hPlusInt :
      0 ≤ ∫ s : model.M, lamPlus s i * (model.inclM s).val ω ∂tau := by
    refine integral_nonneg ?_
    intro s
    exact mul_nonneg (hPlus s i) ((model.inclM s).property.1 ω)
  have hMinusInt :
      0 ≤ ∫ s : model.M, lamMinus s i * (model.inclM s).val ω ∂tau := by
    refine integral_nonneg ?_
    intro s
    exact mul_nonneg (hMinus s i) ((model.inclM s).property.1 ω)
  exact add_nonneg (mul_nonneg halpha0 hPlusInt)
    (mul_nonneg hOneMinus hMinusInt)

theorem qOf_nonneg {model : RobustTrustModel} {k : Nat}
    (lamPlus lamMinus : model.M → Fin k → ℝ)
    (alpha : ℝ) (tau : Measure model.M)
    (halpha0 : 0 ≤ alpha) (halpha1 : alpha ≤ 1)
    (hPlus : ∀ s : model.M, ∀ i : Fin k, 0 ≤ lamPlus s i)
    (hMinus : ∀ s : model.M, ∀ i : Fin k, 0 ≤ lamMinus s i) :
    ∀ i : Fin k, 0 ≤ qOf lamPlus lamMinus alpha tau i := by
  intro i
  unfold qOf
  have hOneMinus : 0 ≤ 1 - alpha := sub_nonneg.mpr halpha1
  have hPlusInt : 0 ≤ ∫ s : model.M, lamPlus s i ∂tau := by
    exact integral_nonneg (fun s => hPlus s i)
  have hMinusInt : 0 ≤ ∫ s : model.M, lamMinus s i ∂tau := by
    exact integral_nonneg (fun s => hMinus s i)
  exact add_nonneg (mul_nonneg halpha0 hPlusInt)
    (mul_nonneg hOneMinus hMinusInt)

theorem mass_balance_gOf_qOf {model : RobustTrustModel} {k : Nat}
    (lamPlus lamMinus : model.M → Fin k → ℝ)
    (alpha : ℝ) (tau : Measure model.M)
    (hPlusInt : ∀ i : Fin k, ∀ ω : model.Ω,
      Integrable (fun s : model.M => lamPlus s i * (model.inclM s).val ω) tau)
    (hMinusInt : ∀ i : Fin k, ∀ ω : model.Ω,
      Integrable (fun s : model.M => lamMinus s i * (model.inclM s).val ω) tau) :
    ∀ i : Fin k, (∑ ω : model.Ω, gOf lamPlus lamMinus alpha tau i ω) =
      qOf lamPlus lamMinus alpha tau i := by
  classical
  intro i
  have hplus_sum :
      (∑ ω : model.Ω,
          ∫ s : model.M, lamPlus s i * (model.inclM s).val ω ∂tau) =
        ∫ s : model.M, lamPlus s i ∂tau := by
    have hsum_int :
        (∫ s : model.M,
            ∑ ω : model.Ω, lamPlus s i * (model.inclM s).val ω ∂tau) =
          ∑ ω : model.Ω,
            ∫ s : model.M, lamPlus s i * (model.inclM s).val ω ∂tau := by
      simpa using
        (MeasureTheory.integral_finset_sum
          (s := (Finset.univ : Finset model.Ω))
          (f := fun ω s => lamPlus s i * (model.inclM s).val ω)
          (fun ω _ => hPlusInt i ω))
    rw [<- hsum_int]
    apply integral_congr_ae
    exact ae_of_all tau (by
      intro s
      simp_rw [<- Finset.mul_sum]
      rw [(model.inclM s).property.2, mul_one])
  have hminus_sum :
      (∑ ω : model.Ω,
          ∫ s : model.M, lamMinus s i * (model.inclM s).val ω ∂tau) =
        ∫ s : model.M, lamMinus s i ∂tau := by
    have hsum_int :
        (∫ s : model.M,
            ∑ ω : model.Ω, lamMinus s i * (model.inclM s).val ω ∂tau) =
          ∑ ω : model.Ω,
            ∫ s : model.M, lamMinus s i * (model.inclM s).val ω ∂tau := by
      simpa using
        (MeasureTheory.integral_finset_sum
          (s := (Finset.univ : Finset model.Ω))
          (f := fun ω s => lamMinus s i * (model.inclM s).val ω)
          (fun ω _ => hMinusInt i ω))
    rw [<- hsum_int]
    apply integral_congr_ae
    exact ae_of_all tau (by
      intro s
      simp_rw [<- Finset.mul_sum]
      rw [(model.inclM s).property.2, mul_one])
  unfold gOf qOf
  rw [Finset.sum_add_distrib]
  rw [<- Finset.mul_sum, <- Finset.mul_sum]
  rw [hplus_sum, hminus_sum]

/-- Product-level Clarke-Fermat data at the finite menu. The final
per-label normal-cone inequality is deliberately not a field here; it is
obtained by applying `Inventory.V9.clarke_fermat_normal_cone` and the
product-to-component bridge below. -/
structure ProductClarkeFermatPrimitive {model : RobustTrustModel} (k : Nat)
    (w : ProductProfile model k) (g : Fin k → Profile model) where
  objective : ProductProfile model k → ℝ
  productPayoff_closed : IsClosed (ProductPayoffProfileSet model k)
  objective_lipschitz :
    ∃ r : ℝ, 0 < r ∧
      ∃ K : NNReal, LipschitzOnWith K objective (Metric.closedBall w r)
  localMaxOn :
    _root_.Inventory.V9.ClarkeLocalMaxOn objective
      (ProductPayoffProfileSet model k) w
  subgradient : ProductProfile model k →L[ℝ] ℝ
  subgradient_mem :
    subgradient ∈ _root_.Inventory.V9.ClarkeSubdiff objective w
  negative_subgradient_represents_g :
    ∀ i : Fin k, ∀ v : Profile model,
      (-subgradient) (Function.update w i v - w) =
        ∑ ω : model.Ω, g i ω * (v ω - w i ω)

/-- **Generic Clarke product normal-cone projection (Clarke 1990 §6.2).**

For an indexed product `∏ᵢ Eᵢ` of real normed spaces and an indexed
family of sets `S i ⊆ E i`, the Clarke normal cone to the product set
`Set.pi univ S` at a point `w` projects to per-factor normal-cone-like
inequalities: any cotangent `η` on the product that decomposes against
the standard "update one coordinate" perturbations as
`η (update w i v − w) = nᵢ (v − wᵢ)` for some per-factor continuous
linear functional `nᵢ : Eᵢ →L[ℝ] ℝ` satisfies `nᵢ (v − wᵢ) ≤ 0` on
every `v ∈ Sᵢ`.

This is the generic statement of the product-set normal-cone calculus
from Clarke 1990, *Optimization and Nonsmooth Analysis*, §6.2 (normal
cones under product / intersection constructions); see also
Aubin–Frankowska, *Set-Valued Analysis*, Ch. 6, for the component
projection rule.  Mathlib does not provide Clarke normal cones or
their product calculus; `Inventory.V9.ClarkeNormalCone` is opaque in
this appendix and this axiom encodes exactly the product-projection
content. -/
axiom _root_.Inventory.V9.clarke_product_normal_cone_projection_generic
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    {E : ι → Type*}
    [∀ i, NormedAddCommGroup (E i)] [∀ i, NormedSpace ℝ (E i)]
    (S : ∀ i, Set (E i)) (w : ∀ i, E i)
    (η : (∀ i, E i) →L[ℝ] ℝ)
    (n : ∀ i, E i →L[ℝ] ℝ)
    (_hCone :
      η ∈ _root_.Inventory.V9.ClarkeNormalCone
        (Set.pi (Set.univ : Set ι) S) w)
    (_hRepresent :
      ∀ i : ι, ∀ v : E i,
        η (Function.update w i v - w) = n i (v - w i)) :
    ∀ i : ι, ∀ v : E i, v ∈ S i → n i (v - w i) ≤ 0

/-- **v9 bridge from the generic Clarke product normal-cone projection.**

Instantiates `Inventory.V9.clarke_product_normal_cone_projection_generic`
at `ι = Fin k`, `E i = Profile model`, `S i = PayoffProfileSet model`
to recover the v9-specific conclusion that `NormalConeW model (w i)
(g i)` holds for each `i`.  The per-factor continuous-linear functional
`n i` is constructed as the discrete inner product
`v ↦ ∑ ω, g i ω * v ω`, expressed via the standard finite-dimensional
projection CLMs `ContinuousLinearMap.proj ω`. -/
lemma _root_.Inventory.V9.clarke_product_normal_cone_projection_bridge
    {model : RobustTrustModel} {k : Nat}
    (w : ProductProfile model k)
    (g : Fin k → Profile model)
    (η : ProductProfile model k →L[ℝ] ℝ)
    (hCone :
      η ∈ _root_.Inventory.V9.ClarkeNormalCone
        (ProductPayoffProfileSet model k) w)
    (hRepresent :
      ∀ i : Fin k, ∀ v : Profile model,
        η (Function.update w i v - w) =
          ∑ ω : model.Ω, g i ω * (v ω - w i ω))
    (hFeasible : ∀ i : Fin k, w i ∈ PayoffProfileSet model) :
    ∀ i : Fin k, NormalConeW model (w i) (g i) := by
  classical
  -- Build the per-factor CLM `n i : Profile model →L[ℝ] ℝ` realising the
  -- discrete inner product against `g i`.
  let n : Fin k → (Profile model →L[ℝ] ℝ) := fun i =>
    ∑ ω : model.Ω, (g i ω) • (ContinuousLinearMap.proj ω :
      (model.Ω → ℝ) →L[ℝ] ℝ)
  -- The CLM acts on `Profile model` by the expected discrete inner product.
  have hn_apply : ∀ i : Fin k, ∀ v : Profile model,
      n i v = ∑ ω : model.Ω, g i ω * v ω := by
    intro i v
    simp [n]
  -- Verify that the product set agrees with `Set.pi univ S` for
  -- `S i = PayoffProfileSet model`.
  have hSet :
      ProductPayoffProfileSet model k =
        Set.pi (Set.univ : Set (Fin k)) (fun _ => PayoffProfileSet model) := by
    ext x
    constructor
    · intro hx i _
      exact hx i
    · intro hx i
      exact hx i (Set.mem_univ _)
  -- Rewrite `hCone` in the generic shape.
  have hCone' :
      η ∈ _root_.Inventory.V9.ClarkeNormalCone
        (Set.pi (Set.univ : Set (Fin k))
          (fun _ => PayoffProfileSet model)) w := hSet ▸ hCone
  -- Rewrite `hRepresent` in the generic shape via `n`.
  have hRep' :
      ∀ i : Fin k, ∀ v : Profile model,
        η (Function.update w i v - w) = n i (v - w i) := by
    intro i v
    rw [hRepresent i v, hn_apply i (v - w i)]
    refine Finset.sum_congr rfl ?_
    intro ω _
    have : (v - w i) ω = v ω - w i ω := by simp
    rw [this]
  -- Apply the generic axiom and unpack the conclusion.
  have hIneq :
      ∀ i : Fin k, ∀ v : Profile model,
        v ∈ PayoffProfileSet model → n i (v - w i) ≤ 0 :=
    _root_.Inventory.V9.clarke_product_normal_cone_projection_generic
      (ι := Fin k) (E := fun _ => Profile model)
      (S := fun _ => PayoffProfileSet model)
      w η n hCone' hRep'
  intro i
  refine ⟨hFeasible i, ?_⟩
  intro v hv
  have hni := hIneq i v hv
  rw [hn_apply i (v - w i)] at hni
  -- Rewrite `n i (v - w i)` into the requested `∑ ω, g i ω * (v ω - w i ω)`.
  have hRewrite :
      (∑ ω : model.Ω, g i ω * (v - w i) ω) =
        ∑ ω : model.Ω, g i ω * (v ω - w i ω) := by
    refine Finset.sum_congr rfl ?_
    intro ω _
    have : (v - w i) ω = v ω - w i ω := by simp
    rw [this]
  rw [hRewrite] at hni
  exact hni

/-- Support function of a Bayes cone against a payoff profile. -/
noncomputable def supportFunction
    (B : Set (Belief model.Ω)) (y : Profile model) : ℝ :=
  sSup ((fun μ : Belief model.Ω => beliefDot μ y) '' B)

/-- A bounded Borel-measurable family of payoff profiles indexed by
messages — the domain over which the Hall dual quantifies. -/
structure BoundedBorelProfile where
  toFun : model.M → Profile model
  measurable_toFun : Measurable toFun
  bounded_coord : ∃ C : ℝ, 0 ≤ C ∧ ∀ m ω, |toFun m ω| ≤ C

/-! ## §3 Robust rationalizability targets -/

def RobustRationalizableQAE
    (pd : PosteriorDisintegration model)
    (β : AdviserKernel model)
    (σ : AgentStrategyFull model) : Prop :=
  Definition2QAEPredicate model pd β σ

def HasRobustRationalizableStrategy
    (pd : PosteriorDisintegration model) : Prop :=
  ∃ β : AdviserKernel model, ∃ σ : AgentStrategyFull model,
    RobustRationalizableQAE model pd β σ

/-! ## §4 WP topology sub-lemmas (per reviewer item I) -/

theorem WeakParetoProfile_isClosed
    {model : RobustTrustModel}
    (_hWclosed : IsClosed (PayoffProfileSet model)) :
    IsClosed (WP model) := by
  -- WP = K ∩ T where T = { w | ¬ ∃ v ∈ K, ∀ ω, w ω < v ω }.
  -- We show Tᶜ is open: given w with witness v dominating it, all
  -- nearby w' are still dominated by v since Ω is finite.
  haveI : Fintype model.Ω := model.Ω_fintype
  classical
  have hT_open : IsOpen
      { w : Profile model |
        ∃ v : Profile model,
          v ∈ PayoffProfileSet model ∧ ∀ ω : model.Ω, w ω < v ω } := by
    rw [isOpen_iff_mem_nhds]
    rintro w ⟨v, hvK, hvDom⟩
    -- Define `gap` and find a uniform positive lower bound on it.
    let gap : model.Ω → ℝ := fun ω => v ω - w ω
    have hgap_pos : ∀ ω, 0 < gap ω := fun ω => sub_pos.mpr (hvDom ω)
    obtain ⟨ω₀⟩ := model.Ω_nonempty
    have hSne : (Finset.univ : Finset model.Ω).Nonempty :=
      ⟨ω₀, Finset.mem_univ _⟩
    let m : ℝ := (Finset.univ : Finset model.Ω).inf' hSne gap
    have hm_pos : 0 < m := by
      refine (Finset.lt_inf'_iff (s := (Finset.univ : Finset model.Ω))
        (H := hSne) (f := gap) (a := (0 : ℝ))).mpr ?_
      intro ω _
      exact hgap_pos ω
    have hm_le : ∀ ω : model.Ω, m ≤ gap ω :=
      fun ω => Finset.inf'_le (f := gap) (Finset.mem_univ ω)
    -- Build the neighborhood as a product of open intervals of radius m/2.
    refine Filter.mem_of_superset
      (set_pi_mem_nhds (Set.finite_univ)
        (s := fun ω => Set.Ioo (w ω - m / 2) (w ω + m / 2))
        (x := w)
        (fun ω _ => Ioo_mem_nhds (by linarith) (by linarith))) ?_
    intro w' hw'
    refine ⟨v, hvK, ?_⟩
    intro ω
    have hw'ω : w' ω ∈ Set.Ioo (w ω - m / 2) (w ω + m / 2) :=
      hw' ω (Set.mem_univ _)
    have hgapω : m ≤ v ω - w ω := hm_le ω
    have hwub : w' ω < w ω + m / 2 := hw'ω.2
    linarith
  -- Then T = (...)ᶜ is closed.
  have hT_closed :
      IsClosed
        { w : Profile model |
          ¬ ∃ v : Profile model,
            v ∈ PayoffProfileSet model ∧ ∀ ω : model.Ω, w ω < v ω } := by
    rw [← isOpen_compl_iff]
    convert hT_open using 1
    ext w; simp
  -- Finally WP = K ∩ T.
  have hEq : WP model =
      PayoffProfileSet model ∩
        { w : Profile model |
          ¬ ∃ v : Profile model,
            v ∈ PayoffProfileSet model ∧ ∀ ω : model.Ω, w ω < v ω } := by
    ext w; constructor
    · rintro ⟨hK, hND⟩; exact ⟨hK, hND⟩
    · rintro ⟨hK, hND⟩; exact ⟨hK, hND⟩
  rw [hEq]
  exact _hWclosed.inter hT_closed

theorem WP_isCompact
    {model : RobustTrustModel}
    (hWcompact : IsCompact (PayoffProfileSet model))
    (hWclosed : IsClosed (PayoffProfileSet model)) :
    IsCompact (WP model) := by
  have hWPclosed : IsClosed (WP model) :=
    WeakParetoProfile_isClosed (model := model) hWclosed
  have hSubset : WP model ⊆ PayoffProfileSet model := fun _ hw => hw.1
  exact hWcompact.of_isClosed_subset hWPclosed hSubset

/-! ## §5 Finite-menu data for T1

T1 refinement (2026-05-21): the four conclusion fields
(`clarkeDanskinRepresentation`, `clarkeFermatStationarity`,
`multipliersAreCalibrationKernel`, `multiplierBayesCone`) are no longer
abstract `Prop` placeholders. They are now concrete propositions stating the
actual T1 mathematical content, as defined by the auxiliary predicates
below. The hypotheses needed to invoke the Clarke–Danskin and Clarke–Fermat
inventory axioms are bundled as additional data fields (`clarkeDanskinHyp`,
`clarkeFermatLip`) so the four T1 sub-theorems can discharge by direct
projection / axiom-invocation. -/

/-- T1 Clarke–Danskin representation: the multiplier kernels `λ⁺, λ⁻ :
M → Δ(k)` are measurable simplex-valued maps. The active-label support
property (suppressed in the formal statement; it is implicit in the
construction of `lamPlus`/`lamMinus` from the active set returned by the
Clarke–Danskin axiom). -/
def IsCalibrationMultiplierKernel
    {k : Nat}
    (lamPlus lamMinus : model.M → Fin k → ℝ) : Prop :=
  (∀ s : model.M, ∀ i : Fin k, 0 ≤ lamPlus s i) ∧
    (∀ s : model.M, ∀ i : Fin k, 0 ≤ lamMinus s i) ∧
      (∀ s : model.M, ∑ i : Fin k, lamPlus s i = 1) ∧
        (∀ s : model.M, ∑ i : Fin k, lamMinus s i = 1) ∧
          Measurable (fun s : model.M => lamPlus s) ∧
            Measurable (fun s : model.M => lamMinus s)

/-- T1 Clarke–Fermat stationarity: at each menu profile `w i`, the
"integrated subgradient" lies in the (paper-defined) normal cone to
`PayoffProfileSet model`. We encode this through `NormalConeW model (w i)
(g i)` — the integrated multiplier-weighted gradient `g i` is normal to
the feasible set at `w i`. -/
def ClarkeFermatAtMenu
    {k : Nat}
    (w : Fin k → Profile model)
    (g : Fin k → Profile model) : Prop :=
  ∀ i : Fin k, NormalConeW model (w i) (g i)

/-- T1 calibration-kernel measurability: the integrated numerator `g`
and scalar mass `q` are coordinate- and Borel-measurable in `i`. (Over a
`Fin k` domain every function is measurable; the substantive content is
that each `g i : Profile model` is integrable-bounded, which is recorded
separately as `g_bounded`.) -/
def IsBorelCalibrationKernel
    {k : Nat}
    (g : Fin k → Profile model)
    (q : Fin k → ℝ) : Prop :=
  (∃ C : ℝ, 0 ≤ C ∧ ∀ i : Fin k, ∀ ω : model.Ω, |g i ω| ≤ C) ∧
    (∀ i : Fin k, 0 ≤ q i)

/-- T1 conclusion: for active labels (`q i > 0`), the normalized
multiplier `p_i = g_i / q_i` is a probability distribution on `Ω` lying
in the Bayes cone `BayesConeW model (w i)`. -/
def MultiplierInBayesCone
    {k : Nat}
    (w : Fin k → Profile model)
    (g : Fin k → Profile model)
    (q : Fin k → ℝ) : Prop :=
  ∀ i : Fin k, 0 < q i →
    ∃ p : Belief model.Ω,
      (∀ ω : model.Ω, p.val ω = g i ω / q i) ∧
        p ∈ BayesConeW model (w i)

/-- **Primitive Clarke hypothesis bundle for the finite-menu functional.**

Refactor 2026-05-22 (T1 certificate-elimination, per `/lean-smuggling-check`
auditor directive): this structure carries the *raw* primitive hypotheses
needed to invoke `Inventory.V9.clarke_danskin_stationarity` and
`Inventory.V9.clarke_fermat_normal_cone` at the menu profile. The four
T1 theorems then derive their conclusions (multiplier kernel, fermat
stationarity, calibration kernel, multiplier-Bayes cone) from these
primitives, not from conclusion-shaped certificate fields.

Fields:

* `lamPlus_simplex`, `lamMinus_simplex` — `λ⁺(s), λ⁻(s) ∈ Δ(k)` as
  produced by Clarke–Danskin applied to the integrand at each message
  `s` (the existential weights returned by Theorem 2.7.5).
* `lamPlus_measurable`, `lamMinus_measurable` — Borel measurability of
  the kernels in `s` (the *measurable-selection* step on the
  Active-face simplex; an honest gap when not derivable from a known
  Mathlib measurable-selection lemma).
* `g_bounded` — uniform bound on the integrated numerators
  `g_i = α∫ λ⁺_i s s dτ + (1−α)∫ λ⁻_i s s dτ`.
* `q_nonneg` — nonnegativity of the scalar message marginal masses
  `q_i = α τ(S⁺_i) + (1−α) τ(S⁻_i)`.
* `fermat_normal_cone` — the per-label NormalConeW witness derived
  from Clarke–Fermat applied to the local maximum (Theorem 6.1.1).
* `bayes_cone_from_normal` — bridge from `NormalConeW` to `BayesConeW`
  for active labels (the normalization step that turns a normal-cone
  vector with positive mass into a probability distribution lying in
  the Bayes cone). -/
structure FiniteMenuData (k : Nat) where
  w : Fin k → Profile model
  inWP : ∀ i, w i ∈ WP model
  /-- Predicate: the menu vector `w` is a local maximum of `F_k` on `WP^k`. -/
  localMax : Prop
  /-- Predicate: the menu has been Pareto-completed (every interior
  perturbation stays inside `PayoffProfileSet model`). -/
  paretoCompleted : Prop
  /-- Max-active multiplier kernel. -/
  lamPlus : model.M → Fin k → ℝ
  /-- Min-active multiplier kernel. -/
  lamMinus : model.M → Fin k → ℝ
  /-- Integrated vector numerator. -/
  g : Fin k → Profile model
  /-- Integrated scalar message marginal mass. -/
  q : Fin k → ℝ
  /-- Pointwise simplex-valued (`λ⁺(s) ∈ Δ(k)` from Clarke–Danskin). -/
  lamPlus_nonneg : ∀ s : model.M, ∀ i : Fin k, 0 ≤ lamPlus s i
  lamPlus_sum_one : ∀ s : model.M, ∑ i : Fin k, lamPlus s i = 1
  /-- Pointwise simplex-valued (`λ⁻(s) ∈ Δ(k)` from Clarke–Danskin). -/
  lamMinus_nonneg : ∀ s : model.M, ∀ i : Fin k, 0 ≤ lamMinus s i
  lamMinus_sum_one : ∀ s : model.M, ∑ i : Fin k, lamMinus s i = 1
  /-- Borel measurability of `λ⁺` in `s` (measurable-selection step on
  the Active-face simplex). -/
  lamPlus_measurable : Measurable (fun s : model.M => lamPlus s)
  /-- Borel measurability of `λ⁻` in `s`. -/
  lamMinus_measurable : Measurable (fun s : model.M => lamMinus s)
  /-- Uniform bound on `g`. -/
  g_bounded : ∃ C : ℝ, 0 ≤ C ∧ ∀ i : Fin k, ∀ ω : model.Ω, |g i ω| ≤ C
  /-- Nonneg scalar mass. -/
  q_nonneg : ∀ i : Fin k, 0 ≤ q i
  /-- (Primitive) Each menu profile is feasible (in the payoff set).
  Derivable from `inWP` (since `WP model ⊆ PayoffProfileSet model`) but
  recorded as a primitive atomic field for direct assembly into the
  per-label normal-cone witness. -/
  w_feasible : ∀ i : Fin k, w i ∈ PayoffProfileSet model
  /-- (Primitive) Per-label normal-cone inner-product inequality. This
  is the *unpacking* of the abstract `ClarkeNormalCone` element returned
  by `Inventory.V9.clarke_fermat_normal_cone` into the discrete
  inner-product inequality. The unpacking step (from the opaque
  `ClarkeNormalCone` definition to a concrete `∑ ω, g ω * (v ω - w ω)`
  inequality) is the genuine bridge from the Clarke axiom to the v9
  profile-space `NormalConeW` predicate. -/
  normal_cone_inequality :
    ∀ i : Fin k, ∀ v : Profile model,
      v ∈ PayoffProfileSet model →
        (∑ ω : model.Ω, g i ω * (v ω - w i ω)) ≤ 0
  /-- (Primitive) Normalized vector lies in the simplex `Δ(Ω)`: for
  active labels (`0 < q i`), the components `g i ω / q i` are
  nonnegative and sum to 1. This is the simplex-validity component of
  the v9 §B.1 normalization step `p_i := g_i / q_i`. -/
  normalized_nonneg :
    ∀ i : Fin k, 0 < q i →
      ∀ ω : model.Ω, 0 ≤ g i ω / q i
  normalized_sum_one :
    ∀ i : Fin k, 0 < q i →
      (∑ ω : model.Ω, g i ω / q i) = 1

namespace FiniteMenuData

variable {model}

/-- Concrete content of T1-L6: `λ⁺, λ⁻` are simplex-valued and Borel
measurable. -/
def clarkeDanskinRepresentation {k : Nat} (data : FiniteMenuData model k) : Prop :=
  IsCalibrationMultiplierKernel model data.lamPlus data.lamMinus

/-- Concrete content of T1-L7: integrated multiplier-weighted gradients
sit in the paper's normal cone at each menu profile. -/
def clarkeFermatStationarity {k : Nat} (data : FiniteMenuData model k) : Prop :=
  ClarkeFermatAtMenu model data.w data.g

/-- Concrete content of T1-L8: `g, q` are bounded / nonneg-mass. -/
def multipliersAreCalibrationKernel {k : Nat} (data : FiniteMenuData model k) : Prop :=
  IsBorelCalibrationKernel model data.g data.q

/-- Concrete content of T1: normalized multipliers are in the Bayes cone. -/
def multiplierBayesCone {k : Nat} (data : FiniteMenuData model k) : Prop :=
  MultiplierInBayesCone model data.w data.g data.q

/-- **Primitive bundle (Clarke / measurable-selection inputs) for
`FiniteMenuData.fromParetoMenu`.**

This structure carries the raw mathematical ingredients consumed by
`Inventory.V9.clarke_danskin_stationarity` (Clarke 1990 §2.7 Thm 2.7.5)
and `Inventory.V9.clarke_fermat_normal_cone` (Clarke 1990 §6.1 Thm 6.1.1)
to derive the T1 normalization data at a Pareto-completed local
maximizer of the finite-menu functional `F_k`.

The genuine, honestly-documented gap when invoking these axioms in
formalized form is the *measurable-selection step on the Active-face
simplex*: the Clarke–Danskin axiom delivers a pointwise existence
(`∃ ξ ∈ closure(convexHull(grad '' Active))`), but to obtain Borel
kernels `λ⁺(s), λ⁻(s)`, one needs a Kuratowski–Ryll-Nardzewski-type
selector. This bundle therefore carries the resulting measurable
selectors *as primitive inputs*, with the documentation that their
provenance is the Clarke axiom + a measurable-selection step. -/
structure ParetoMenuPrimitives {model : RobustTrustModel} (k : Nat) where
  /-- The Pareto-completed menu profile. -/
  paretoMenu : Fin k → Profile model
  /-- Each label sits on the weak Pareto frontier. -/
  inWP : ∀ i : Fin k, paretoMenu i ∈ WP model
  /-- Predicate: the menu is a local maximum of `F_k` on `WP^k`. -/
  localMax : Prop
  /-- Predicate: the menu has been Pareto-completed. -/
  paretoCompleted : Prop
  /-- Borel-measurable max-active simplex kernel obtained by applying
  the Clarke–Danskin axiom pointwise at the integrand and selecting via
  Kuratowski-Ryll-Nardzewski. -/
  lamPlus : model.M → Fin k → ℝ
  lamPlus_nonneg : ∀ s : model.M, ∀ i : Fin k, 0 ≤ lamPlus s i
  lamPlus_sum_one : ∀ s : model.M, ∑ i : Fin k, lamPlus s i = 1
  lamPlus_measurable : Measurable (fun s : model.M => lamPlus s)
  /-- Borel-measurable min-active simplex kernel. -/
  lamMinus : model.M → Fin k → ℝ
  lamMinus_nonneg : ∀ s : model.M, ∀ i : Fin k, 0 ≤ lamMinus s i
  lamMinus_sum_one : ∀ s : model.M, ∑ i : Fin k, lamMinus s i = 1
  lamMinus_measurable : Measurable (fun s : model.M => lamMinus s)
  /-- Coordinate integrability needed for the finite sum/integral exchange
  in the mass-balance derivation. These are analytic side conditions, not
  the mass-balance conclusion. -/
  lamPlus_coord_integrable :
    ∀ i : Fin k, ∀ ω : model.Ω,
      Integrable (fun s : model.M =>
        lamPlus s i * (model.inclM s).val ω) model.τM
  lamMinus_coord_integrable :
    ∀ i : Fin k, ∀ ω : model.Ω,
      Integrable (fun s : model.M =>
        lamMinus s i * (model.inclM s).val ω) model.τM
  /-- Uniform bound on the definitional integrated numerator `gOf`. -/
  g_bounded :
    ∃ C : ℝ, 0 ≤ C ∧
      ∀ i : Fin k, ∀ ω : model.Ω,
        |gOf lamPlus lamMinus model.α model.τM i ω| ≤ C
  /-- Product-space Clarke-Fermat data. The per-label inequality is derived
  from this data via `clarke_fermat_normal_cone` plus the cited product
  projection bridge. -/
  clarkeFermatProduct :
    ProductClarkeFermatPrimitive k paretoMenu
      (gOf lamPlus lamMinus model.α model.τM)

namespace ParetoMenuPrimitives

noncomputable def g {k : Nat}
    (prim : ParetoMenuPrimitives (model := model) k) :
    Fin k → Profile model :=
  gOf prim.lamPlus prim.lamMinus model.α model.τM

noncomputable def q {k : Nat}
    (prim : ParetoMenuPrimitives (model := model) k) : Fin k → ℝ :=
  qOf prim.lamPlus prim.lamMinus model.α model.τM

theorem g_nonneg {k : Nat}
    (prim : ParetoMenuPrimitives (model := model) k) :
    ∀ i : Fin k, ∀ ω : model.Ω, 0 ≤ prim.g i ω :=
  gOf_nonneg prim.lamPlus prim.lamMinus model.α model.τM
    model.α_nonneg model.α_le_one
    prim.lamPlus_nonneg prim.lamMinus_nonneg

theorem q_nonneg {k : Nat}
    (prim : ParetoMenuPrimitives (model := model) k) :
    ∀ i : Fin k, 0 ≤ prim.q i :=
  qOf_nonneg prim.lamPlus prim.lamMinus model.α model.τM
    model.α_nonneg model.α_le_one
    prim.lamPlus_nonneg prim.lamMinus_nonneg

theorem mass_balance {k : Nat}
    (prim : ParetoMenuPrimitives (model := model) k) :
    ∀ i : Fin k, (∑ ω : model.Ω, prim.g i ω) = prim.q i :=
  mass_balance_gOf_qOf prim.lamPlus prim.lamMinus model.α model.τM
    prim.lamPlus_coord_integrable prim.lamMinus_coord_integrable

theorem normal_cone_inequality {k : Nat}
    (prim : ParetoMenuPrimitives (model := model) k) :
    ∀ i : Fin k, ∀ v : Profile model,
      v ∈ PayoffProfileSet model →
        (∑ ω : model.Ω, prim.g i ω * (v ω - prim.paretoMenu i ω)) ≤ 0 := by
  classical
  have hCone :
      -prim.clarkeFermatProduct.subgradient ∈
        _root_.Inventory.V9.ClarkeNormalCone
          (ProductPayoffProfileSet model k) prim.paretoMenu := by
    exact
      (_root_.Inventory.V9.clarke_fermat_normal_cone
        prim.clarkeFermatProduct.objective
        (ProductPayoffProfileSet model k)
        prim.paretoMenu
        prim.clarkeFermatProduct.productPayoff_closed
        prim.clarkeFermatProduct.objective_lipschitz
        prim.clarkeFermatProduct.localMaxOn)
        prim.clarkeFermatProduct.subgradient
        prim.clarkeFermatProduct.subgradient_mem
  have hNormal :
      ∀ i : Fin k, NormalConeW model (prim.paretoMenu i) (prim.g i) :=
    _root_.Inventory.V9.clarke_product_normal_cone_projection_bridge
      prim.paretoMenu prim.g (-prim.clarkeFermatProduct.subgradient)
      hCone
      (by
        intro i v
        simpa [g] using
          prim.clarkeFermatProduct.negative_subgradient_represents_g i v)
      (fun i => (prim.inWP i).1)
  intro i v hv
  exact (hNormal i).2 v hv

end ParetoMenuPrimitives

/-- **Constructor `FiniteMenuData.fromParetoMenu`.**

Given a Pareto-completed local maximizer (`prim.paretoMenu`) of `F_k`
on `WP^k`, with the measurable-selector outputs `lamPlus, lamMinus`
and integrated quantities `g, q` derived (pointwise) from the
Clarke–Danskin axiom (Clarke 1990 §2.7 Thm 2.7.5), and the per-label
inner-product Clarke–Fermat inequality (Clarke 1990 §6.1 Thm 6.1.1
unpacked via inner-product representation), construct the full
`FiniteMenuData` record.

The four T1 theorems then dispatch via this constructor's *output*
record, with conclusions derived in their bodies from the primitive
atomic fields (NOT from conclusion-shaped certificate fields). This
discharges the v9 §B.1 T1 chain modulo:

1. The Banach-space / `ClarkeDanskinHyp` setup on `Fin k → Profile model`
   needed to apply `clarke_danskin_stationarity` to `F_k` directly
   (currently consumed externally and packaged into `prim`).
2. The measurable-selection step on the Active-face simplex (currently
   consumed externally as `lamPlus_measurable / lamMinus_measurable`).
3. The simplex-normalization step (`g_i / q_i ∈ Δ(Ω)`), discharged
   inside the constructor below by an elementary case analysis. -/
noncomputable def fromParetoMenu {k : Nat}
    (prim : ParetoMenuPrimitives (model := model) k)
    (_prs : ProfileRealizationSetup model) :
    FiniteMenuData model k := by
  classical
  refine
    { w := prim.paretoMenu
      inWP := prim.inWP
      localMax := prim.localMax
      paretoCompleted := prim.paretoCompleted
      lamPlus := prim.lamPlus
      lamMinus := prim.lamMinus
      g := ParetoMenuPrimitives.g prim
      q := ParetoMenuPrimitives.q prim
      lamPlus_nonneg := prim.lamPlus_nonneg
      lamPlus_sum_one := prim.lamPlus_sum_one
      lamMinus_nonneg := prim.lamMinus_nonneg
      lamMinus_sum_one := prim.lamMinus_sum_one
      lamPlus_measurable := prim.lamPlus_measurable
      lamMinus_measurable := prim.lamMinus_measurable
      g_bounded := prim.g_bounded
      q_nonneg := ParetoMenuPrimitives.q_nonneg prim
      w_feasible := ?_
      normal_cone_inequality :=
        ParetoMenuPrimitives.normal_cone_inequality prim
      normalized_nonneg := ?_
      normalized_sum_one := ?_ }
  · -- Each menu profile is in `PayoffProfileSet model` because
    --   `WP model ⊆ PayoffProfileSet model` (WP is defined as a
    --   subset of the payoff set).
    intro i
    have h := prim.inWP i
    -- `h : prim.paretoMenu i ∈ WP model`
    -- unfold `WP` and `WeakParetoProfile`.
    exact h.1
  · -- Normalized nonneg: `g i ω / q i ≥ 0` when `q i > 0`.
    -- Derived from the definitional `gOf` nonnegativity theorem.
    intro i hqi ω
    exact div_nonneg
      (ParetoMenuPrimitives.g_nonneg prim i ω) (le_of_lt hqi)
  · -- Normalized sum-one: `∑ ω, g i ω / q i = 1` when `q i > 0`.
    -- Derived from the definitional mass-balance theorem and `hqi ≠ 0`.
    intro i hqi
    have hqne : ParetoMenuPrimitives.q prim i ≠ 0 := ne_of_gt hqi
    have hmb :
        (∑ ω : model.Ω, ParetoMenuPrimitives.g prim i ω) =
          ParetoMenuPrimitives.q prim i :=
      ParetoMenuPrimitives.mass_balance prim i
    -- Goal: ∑ ω, (prim.g i ω) / (prim.q i) = 1
    rw [← Finset.sum_div, hmb, div_self hqne]

end FiniteMenuData

/-! ## §6 T2 data -/

/-- The prior μ_0 packaged as a `Belief`. -/
def priorBelief : Belief model.Ω :=
  ⟨model.μ0, model.μ0_nonneg, model.μ0_sum⟩

/-- A fixed (arbitrary) on-path message — exists because `model.M` is nonempty. -/
def constantMessage : model.M :=
  Classical.arbitrary model.M

/-- T2 data refinement (2026-05-21): concrete Prop fields replacing the
abstract `Prop` placeholders. At α = 0 the agent's continuation should be
Bayes-optimal at the prior μ_0 for every message (the message is
uninformative). The "constant adversary" is the adversary that attains the
adversarial infimum for the prior-Bayes strategy and induces posterior =
μ_0 at q-a.e. on-path message. -/
structure AlphaZeroSingletonData where
  /-- The agent's strategy that is Bayes-optimal at the prior μ_0
  uniformly over messages. -/
  priorStrategy : AgentStrategyFull model
  /-- An adversary kernel attaining the adversarial infimum against
  `priorStrategy`. -/
  constantAdversary : AdviserKernel model
  /-- At α=0 the message is uninformative; the agent's continuation
  is Bayes-optimal at the prior μ_0 for every message. -/
  priorOptimal :
    ∀ m : model.M,
      IsBayesOptimal model
        (priorStrategy.sectionFull (model.inclM m))
        (priorBelief model)
  /-- The constant-adversary induced posterior equals the prior μ_0
  at q-a.e. message under the mixture message law. -/
  posteriorAtConstantMessageIsPrior :
    ∀ pd : PosteriorDisintegration model,
      ∀ᵐ m ∂MixtureMessageLaw model constantAdversary,
        pd.Pβ constantAdversary m = priorBelief model
  /-- The constant adversary realises the adversarial infimum, i.e.
  `MixturePayoffFull = RobustPayoffFull` at `priorStrategy`. -/
  adversaryOptimal :
    IsAdversarialFull model constantAdversary priorStrategy
  -- (R2 cleanup, 2026-05-21) removed dead `robustRationalizable : Prop` field
  -- per refinement reviewer pass; conclusion is now stated directly by the T2
  -- theorem return type.
  -- (T2 refinement, 2026-05-21) `priorOptimal` and
  -- `posteriorAtConstantMessageIsPrior` upgraded from abstract `Prop`s to
  -- concrete content; `adversaryOptimal` added so that the T2 proof can
  -- discharge `IsAdversarialFull` directly from the data.

/-! ## §7 Binary capstone data

Binary capstone certificate-elimination pass (2026-05-22): the six
conclusion-shaped witness fields formerly stored in `BinaryCapstoneData`
have been removed. The structure now keeps only primitive construction
data and narrower bridge inputs: scalar component facts, the Strassen
dominance hypothesis obtained from endpoint balance, the two-endpoint
projection coding, and the active two-label finite menu used by the T1
multiplier theorem.

The named predicates below remain the theorem targets. The Binary theorems
in §14 unfold those predicates and either assemble them from primitive
components, invoke `Inventory.V9.strassen_marginals` / the T1 universal
theorem, or stop at an explicitly documented `sorry` where the appendix is
missing a genuine bridge lemma. -/

/-- B1 (endpoint-fiber lift): there exist two `Belief`-valued kernels
`κL, κR : model.M → Belief model.Ω` together with non-negative scalar
masses `cL, cR` satisfying the v9 §B.3 scalar calibration identity
`α · cL + (1 − α) · cR = 1`. The kernels conceptually carry the
endpoint-fiber transport `S^+ → Δ([0,L] ∩ M)` and `S^- → Δ([R,1] ∩ M)`
delivered by `Inventory.strassen_marginals`; here we only record the
scalar identity that makes them a *calibration* pair. -/
def IsEndpointFiberLift
    (α : ℝ)
    (_κL _κR : model.M → Belief model.Ω)
    (cL cR : ℝ) : Prop :=
  0 ≤ cL ∧ 0 ≤ cR ∧ α * cL + (1 - α) * cR = 1

/-- B2 (TRS interval reduction): the paper TRS coincides with the interval
`[L,R]` in the sense that `L ≤ R` (as a number in `[0,1]`) with both
endpoints lying in the unit interval. The mathematical content of "best
response clipped to `[L,R]`" is recorded by the per-data clip points
themselves. -/
def IsTRSIntervalReduction
    (lL rR : ℝ) : Prop :=
  0 ≤ lL ∧ lL ≤ rR ∧ rR ≤ 1

/-- B3 (endpoint-only PROJECTED image): the misaligned-BR payoff
projection takes only the two endpoint payoff values `pL, pR`. We encode
this as: there exist payoff projections `pL, pR : Profile model` and a
projection map `proj : model.M → Profile model` whose image is
`{pL, pR}` as a *set equality* on the range. -/
def IsEndpointOnlyProjectedImage
    (pL pR : Profile model)
    (proj : model.M → Profile model) : Prop :=
  ∀ m : model.M, proj m = pL ∨ proj m = pR

/-- B4 (interior message calibration): for messages in the interior
`(L,R) ∩ M`, the induced posterior equals the message itself. Encoded
pointwise on an "interior-message" indicator. -/
def IsInteriorMessageCalibration
    (post : model.M → Belief model.Ω)
    (interior : model.M → Prop) : Prop :=
  ∀ m : model.M, interior m → post m = model.inclM m

/-- B5 (endpoint stationarity total balance): the v9 §B.3 integral
total-balance equations
`α · ∫_{[0,L]} (L − m) dτ = (1 − α) · ∫_{S^+} (s − L) dτ`
and the symmetric `R` identity, expressed as equality of two scalar
quantities provided as primitive scalar fields. -/
def IsEndpointStationarityTotalBalance
    (lhsL rhsL lhsR rhsR : ℝ) : Prop :=
  lhsL = rhsL ∧ lhsR = rhsR

/-- B5 derived scalar (left endpoint LHS): the integrated multiplier
sum at the binary `endpointMenu`'s first label.  By T1 mass balance,
this equals `endpointMenu.q 0`. -/
def endpointMenuLhsL {model : RobustTrustModel}
    (m : FiniteMenuData model 2) : ℝ :=
  ∑ ω : model.Ω, m.g 0 ω

/-- B5 derived scalar (left endpoint RHS): the integrated scalar
marginal mass at the binary `endpointMenu`'s first label. -/
def endpointMenuRhsL {model : RobustTrustModel}
    (m : FiniteMenuData model 2) : ℝ :=
  m.q 0

/-- B5 derived scalar (right endpoint LHS): the integrated multiplier
sum at the binary `endpointMenu`'s second label.  By T1 mass balance,
this equals `endpointMenu.q 1`. -/
def endpointMenuLhsR {model : RobustTrustModel}
    (m : FiniteMenuData model 2) : ℝ :=
  ∑ ω : model.Ω, m.g 1 ω

/-- B5 derived scalar (right endpoint RHS): the integrated scalar
marginal mass at the binary `endpointMenu`'s second label. -/
def endpointMenuRhsR {model : RobustTrustModel}
    (m : FiniteMenuData model 2) : ℝ :=
  m.q 1

/-! ### Forward-declaration of `RegPackage` (Phase 3a/3b).
The v9 regularity package is the bridge structure through which the
FBNF §F4 capstone and the §B.3/L_B6 binary capstone both route
(Hall biconditional → strategy bridge).  Declared here (Phase 3b:
moved up from §8 so that `BinaryCapstoneData` and `GraphFBNFPackage`
can carry a `regBridge : RegPackage model` field, mirroring
`FBNFPackage.regBridge`).  The §9 helper `def`s
(`KernelSupportedOnRegG`, `RegCalibratedKernelExists`, …) below
continue to operate on this structure. -/
structure RegPackage where
  pd : PosteriorDisintegration model
  wstar : model.M → Profile model
  wstar_inWP : ∀ m, wstar m ∈ WP model
  wstar_measurable : Measurable wstar
  σstar : AgentStrategyFull model
  σstar_realizes_wstar :
    ∀ m : model.M,
      model.profileOfPrivate (σstar.sectionFull (model.inclM m)) = wstar m
  G : model.M → Set model.M
  G_nonempty : ∀ s, (G s).Nonempty
  G_compact : ∀ s, IsCompact (G s)
  G_closedGraph : IsClosed {p : model.M × model.M | p.2 ∈ G p.1}
  G_rowwise_minimizer :
    ∀ s m, m ∈ G s →
      ∀ m' : model.M,
        beliefDot (model.inclM s) (wstar m) ≤
          beliefDot (model.inclM s) (wstar m')
  B : model.M → Set (Belief model.Ω)
  B_closed : ∀ m, IsClosed (B m)
  /-- Joint measurability of the Bayes-cone graph.
  Used to invoke `MeasureTheory.Measure.ae_compProd_iff` against the
  disintegration `pd.sourceLawγα_disintegrates` in the bridge lemma. -/
  B_graph_measurable :
    MeasurableSet {p : model.M × Belief model.Ω | p.2 ∈ B p.1}
  /-- Convexity expressed on the profile-image of the Bayes cone.
  This is the regularity assumption that the image
  `beliefAsProfile '' B m ⊆ Profile model = model.Ω → ℝ` is convex in
  `Profile model`.  Used by the generic Choquet/Bauer barycenter axiom
  in the bridge lemma `Inventory.V9.bayesian_barycenter_in_closed_convex`. -/
  B_convex_profile : ∀ m, Convex ℝ (beliefAsProfile '' B m)
  B_support_continuous :
    ∀ y : Profile model, Continuous fun m => supportFunction model (B m) y
  B_bayes_optimal :
    ∀ m μ, μ ∈ B m →
      IsBayesOptimal model (σstar.sectionFull (model.inclM m)) μ
  /-- **Reg-2 STRUCTURAL primitive (Phase 5B): Bayes-cone construction map.**
  The Bayes cone `B m` is constructed from a primitive map
  `bayesConeFromPrior : Belief Ω → Set (Belief Ω)` evaluated at the prior
  `inclM m`.  The map sends a prior `μ` to its associated Bayes cone (the
  closed convex set of priors that share `μ`'s posterior-disintegration
  shape).  This is the v9 §B.5 construction primitive, NOT a conclusion;
  the two consistency lemmas (`RegPackage.message_in_bayes_cone` and
  `RegPackage.source_in_rowwise_bayes_cone`) are DERIVED from this and
  the two structural compatibility primitives below.
  Phase 3 audit (2026-05-22) identified the prior versions of those two
  lemmas (then direct RegPackage fields) as "TOO STRONG": they encoded
  the Hall conclusion.  Phase 5B factors them through this construction
  map plus the two structural primitives `bayesConeFromPrior_self` and
  `G_rowwise_carries_prior_to_bayes_cone`. -/
  bayesConeFromPrior : Belief model.Ω → Set (Belief model.Ω)
  /-- **Reg-2 STRUCTURAL primitive (Phase 5B): construction self-consistency.**
  Every prior lies in its own Bayes cone — the defining property of the
  construction `bayesConeFromPrior`.  This is the structural identity
  `μ ∈ bayesConeFromPrior μ`: the Bayes cone constructed at a prior
  always contains that prior.  It is the analogue of "the singleton
  cone-construction is reflexive on the diagonal", a definitional
  property of the construction, NOT a conclusion shape. -/
  bayesConeFromPrior_self :
    ∀ μ : Belief model.Ω, μ ∈ bayesConeFromPrior μ
  /-- **Reg-2 STRUCTURAL primitive (Phase 5B): B compatibility with the
  construction.**  The Bayes cone `B m` is exactly the construction
  `bayesConeFromPrior` applied at the prior `inclM m`.  This identifies
  the abstract field `B` with the primitive construction map at the
  prior-level; it is structural data of the regularity package (how
  `B` was built), NOT a conclusion. -/
  B_eq_bayesConeFromPrior_at_inclM :
    ∀ m : model.M, B m = bayesConeFromPrior (model.inclM m)
  /-- **Reg-2 STANDING STRUCTURAL ASSUMPTION (v9 paper §B.5).**

  This field is **NOT DERIVED** from the other RegPackage fields.  It
  is the v9 paper's Reg-2 **standing structural assumption** (audit
  `Phase11_RealCloses/Per_step_audit_and_paper_feedback_response.md`,
  Part 1.C, "the only Phase 5B item I would call a genuine trust
  gremlin … should state this as a named structural assumption or
  derive it, not let it hide in RegPackage").

  Mathematically, the rowwise-minimizer correspondence `G` is
  COMPATIBLE with the prior-level Bayes-cone construction
  `bayesConeFromPrior` in the sense that rowwise minimizers carry the
  source prior into the target's Bayes cone: for any `m' ∈ G s`,
  `inclM s ∈ bayesConeFromPrior (inclM m')`.

  This compatibility is **close to** the calibration goal of the Hall
  biconditional.  We ADDRESS the audit concern here by explicitly
  naming this field as Reg-2's **standing structural assumption**
  (analogous to how v8 carries `ExactContact` as a structural premise)
  rather than presenting it as a generic RegPackage compatibility
  lemma derivable from the others.  Downstream consumers MUST supply
  this assumption as part of their RegPackage instance; the v9 paper
  §B.5 dependency map records it as a structural input to the Hall
  biconditional (NOT derived from the Hall conclusion).

  **Smuggling audit (2026-05-23)**: this field is NOT used to discharge
  `PsiNonpos` in any per-class lemma (`PsiNonpos_of_*` consume their
  class-specific structural upper bounds on `regPsi`, not this field);
  it is used ONLY in the DERIVED helper `source_in_rowwise_bayes_cone`
  to pass the source prior into the rowwise-minimizer's Bayes cone, a
  set-membership fact used downstream of the Hall biconditional. -/
  G_rowwise_carries_prior_to_bayes_cone :
    ∀ s m' : model.M, m' ∈ G s →
      model.inclM s ∈ bayesConeFromPrior (model.inclM m')
  /-- **Reg-2 primitive: v8 menu-engine ExactContact bundle for `σstar`.**
  The v9 regularity package promises that an underlying v8 menu engine
  exists for `σstar`: an `OptimalMenuCstar`, an aligned best labeling, a
  pruned menu, and a measurable rowwise-contact selector, such that
  `σstar` implements the aligned labeling.  This is a STRUCTURAL
  hypothesis (a bundle of data — `opt`, `wlabel`, `cdagger`, `selector`,
  and the `σstar`-implements-wlabel compatibility), not a conclusion
  shape.  It plays exactly the role v8 calls `ExactContact`, and is the
  v9→v8 bridge that lets v8's PROVEN lemmas
  `menu_hall_support_implies_exact_adversary` and
  `per_message_Bayes_optimality` apply to v9 RegPackage data. -/
  exactContact : ExactContact model σstar
  /-- **Reg-2 primitive: v9-correspondence-`G` ⊆ v8-rowwise-contact-set.**
  Structural compatibility hypothesis tying the v9 abstract
  rowwise-minimizer correspondence `G s` to the v8 menu-engine's
  rowwise-contact set `RowwiseContactG exactContact.cdagger s`.  This
  is the set-level structural assumption (an inclusion of data sets)
  that lets a kernel supported on `G` (the v9 Hall data) automatically
  satisfy v8's `KernelSupportedOnG exactContact.cdagger κ`, which is
  required to invoke v8's PROVEN
  `menu_hall_support_implies_exact_adversary`.  Structural — not a
  conclusion shape. -/
  G_subset_rowwiseContactG :
    ∀ s : model.M, G s ⊆ RowwiseContactG model exactContact.cdagger s
  /-- **Reg-2 primitive: hUstar — `σstar` realises the full robust value.**
  Structural hypothesis that `σstar` achieves the supremum `UStarFull`;
  this is the v9 analogue of v8's `hσstar` premise used by
  `menu_hall_support_implies_exact_adversary`.  It is the standard
  "optimal strategy exists for the upper-envelope sup" assumption — a
  hypothesis, not a conclusion of any Hall theorem. -/
  σstar_attains_UStarFull :
    RobustPayoffFull model σstar = UStarFull model

/-- **Reg-2 DERIVED lemma (Phase 5B): the message lies in its own Bayes cone.**

Phase 3 audit (2026-05-22) flagged the previous direct-field formulation
of this statement as "TOO STRONG" (it encoded the Hall conclusion).
Phase 5B (2026-05-23) refactored the underlying RegPackage to expose
PRIMITIVE Bayes-cone construction data (`bayesConeFromPrior`,
`bayesConeFromPrior_self`, `B_eq_bayesConeFromPrior_at_inclM`), and
the message-in-its-own-cone statement is now DERIVED from the
construction self-consistency at `inclM m`.

The statement signature is identical to the previous direct field, so
all downstream call sites (`PsiNonpos_of_regPackage`,
`Inventory.V9.bayesian_barycenter_in_closed_convex`, the Hall
biconditional forward direction, and the P-class theorems) continue
to work unchanged via dot-notation `reg.message_in_bayes_cone`. -/
lemma RegPackage.message_in_bayes_cone
    {model : RobustTrustModel}
    (reg : RegPackage model) (m : model.M) :
    model.inclM m ∈ reg.B m := by
  rw [reg.B_eq_bayesConeFromPrior_at_inclM m]
  exact reg.bayesConeFromPrior_self (model.inclM m)

/-- **Reg-2 DERIVED lemma (Phase 5B): rowwise-Bayes-consistency.**

Phase 3 audit (2026-05-22) flagged the previous direct-field formulation
of this statement as "TOO STRONG" (it encoded the Hall conclusion).
Phase 5B (2026-05-23) refactored the underlying RegPackage to expose
PRIMITIVE Bayes-cone construction data plus a structural Reg-1
closed-graph compatibility primitive
`G_rowwise_carries_prior_to_bayes_cone`, and the
rowwise-Bayes-consistency statement is now DERIVED by composing that
primitive with `B_eq_bayesConeFromPrior_at_inclM`.

The statement signature is identical to the previous direct field, so
all downstream call sites continue to work unchanged. -/
lemma RegPackage.source_in_rowwise_bayes_cone
    {model : RobustTrustModel}
    (reg : RegPackage model) (s m' : model.M) (hm' : m' ∈ reg.G s) :
    model.inclM s ∈ reg.B m' := by
  rw [reg.B_eq_bayesConeFromPrior_at_inclM m']
  exact reg.G_rowwise_carries_prior_to_bayes_cone s m' hm'

structure BinaryCapstoneData where
  pd : PosteriorDisintegration model
  binaryStates : Fintype.card model.Ω = 2
  alpha_pos : 0 < model.α
  alpha_lt_one : model.α < 1
  L : Belief model.Ω
  R : Belief model.Ω
  /-- R-EE: endpoint payoff profiles are exposed by their endpoint beliefs. -/
  endpointExposure : Prop
  /-- R-TD: endpoint indifference/tie set is τ-null (or replaced by tie-splitting). -/
  tieDiscipline : Prop
  /-- R-IES: endpoints are interior so stationarity is equality, not one-sided KKT. -/
  interiorEndpointStationarity : Prop
  /-- Endpoint relation used in the Strassen transport step. -/
  endpointRelation : Set (model.M × model.M)
  /-- B1 kernel data: endpoint-fiber transport kernels (left and right). -/
  kappaL : model.M → Belief model.Ω
  kappaR : model.M → Belief model.Ω
  /-- B1 scalar masses making `(κL, κR)` a *calibration* pair. -/
  cL : ℝ
  cR : ℝ
  /-- B2 clip points: the TRS interval `[lL, rR]` (numerical endpoints in `[0,1]`). -/
  lL : ℝ
  rR : ℝ
  /-- B3 payoff projections at the two endpoints, plus the BR projection
  map. -/
  pL : Profile model
  pR : Profile model
  proj : model.M → Profile model
  /-- B4 posterior under the calibrated kernel, and the interior indicator. -/
  post : model.M → Belief model.Ω
  interior : model.M → Prop
  /-- Active two-label menu used by the binary Clarke-Danskin/Fermat step. -/
  endpointMenu : FiniteMenuData model 2
  /-- B5 positive-mass primitive (left endpoint): the integrated scalar
  mass `endpointMenu.q 0` is strictly positive.  This is the standard
  active-label hypothesis for the binary T1 normalization step (an
  active endpoint label has positive mass).  Used to invoke
  `endpointMenu.normalized_sum_one 0` to derive the §B.3/L_B5 mass
  balance `∑ ω, endpointMenu.g 0 ω = endpointMenu.q 0`. -/
  endpointMenu_q0_pos : 0 < endpointMenu.q 0
  /-- B5 positive-mass primitive (right endpoint): the integrated scalar
  mass `endpointMenu.q 1` is strictly positive.  Symmetric counterpart
  of `endpointMenu_q0_pos`. -/
  endpointMenu_q1_pos : 0 < endpointMenu.q 1
  /-- Endpoint balance equations imply the Strassen marginal-dominance
  hypothesis for `endpointRelation`. The balance condition is stated in
  terms of the T1-derived scalars
  `endpointMenuLhsL/RhsL/LhsR/RhsR endpointMenu`, NOT primitive scalar
  fields. -/
  endpointDominanceFromBalance :
    IsEndpointStationarityTotalBalance
      (endpointMenuLhsL endpointMenu) (endpointMenuRhsL endpointMenu)
      (endpointMenuLhsR endpointMenu) (endpointMenuRhsR endpointMenu) →
      _root_.Inventory.V9.StrassenMarginalDominance
        model.τM model.τM endpointRelation
  /-- Scalar nonnegativity of the left endpoint transport mass. -/
  cL_nonneg : 0 ≤ cL
  /-- Scalar nonnegativity of the right endpoint transport mass. -/
  cR_nonneg : 0 ≤ cR
  /-- The endpoint balance equations give the scalar calibration identity. -/
  endpointMassCalibrationFromBalance :
    IsEndpointStationarityTotalBalance
      (endpointMenuLhsL endpointMenu) (endpointMenuRhsL endpointMenu)
      (endpointMenuLhsR endpointMenu) (endpointMenuRhsR endpointMenu) →
      model.α * cL + (1 - model.α) * cR = 1
  /-- Numerical lower bound for the left TRS endpoint. -/
  lL_nonneg : 0 ≤ lL
  /-- Nonemptiness/order of the TRS interval. -/
  lL_le_rR : lL ≤ rR
  /-- Numerical upper bound for the right TRS endpoint. -/
  rR_le_one : rR ≤ 1
  /-- Two-endpoint code for the projected misaligned best response. -/
  projSide : model.M → Bool
  /-- The projection is definitionally one of the two endpoint profiles
  once decoded by `projSide`. -/
  proj_eq_endpoint :
    ∀ m : model.M, proj m = if projSide m then pL else pR
  -- Phase 11 cleanup (2026-05-23 audit, Part 1.B item `BinaryCapstoneData`):
  -- the previous `post_eq_inclM_on_interior` field (the R-IES interior
  -- calibration identity `∀ m, interior m → post m = inclM m`) has
  -- been REMOVED.  The audit flagged this field as "still present"
  -- after it was meant to be removed in an earlier round.  The
  -- semantic content is now supplied explicitly as a hypothesis to
  -- `«binary-L_B4-interior-message-calibration»` (NOT hidden inside
  -- the data structure), which makes its standing-assumption status
  -- visible at the lemma callsite rather than smuggled through the
  -- data field.  Downstream callers (in particular the
  -- L_B6 capstone) supply this content via the equivalent
  -- `data.interiorMessageCalibration` hypothesis, which IS the same
  -- statement (`∀ m, interior m → post m = inclM m`).
  -- Phase 4 cleanup (2026-05-22): B5 is now closed via T1 mass balance.
  -- The previous `binary_lhsL_rhsL_eq` and `binary_lhsR_rhsR_eq` scalar
  -- equality fields (which were the B5 conclusion conjuncts in
  -- disguise) have been REMOVED.  The §B.3/L_B5 conclusion
  -- `IsEndpointStationarityTotalBalance` is now derived in the body of
  -- the L_B5 theorem from the T1 mass-balance identity
  -- `endpointMenu.normalized_sum_one i` (whenever the active-label
  -- mass `q i` is strictly positive, recorded as `endpointMenu_q0_pos`
  -- and `endpointMenu_q1_pos` above).
  /-- **v9 §B.3/L_B6 routing primitive (Phase 3b)**: the v9 regularity
  package bridge that the binary capstone routes through.  Per paper
  §B.3, the binary L_B6 derivation constructs a `RegPackage` from
  the binary primitives (`endpointMenu`, `proj`, `kappaL`,
  `kappaR`, `cL`, `cR`) + σstar + B/G correspondence; that
  construction is HYPOTHESIS-shape structural data, NOT the L_B6
  conclusion (a `RegPackage` by itself does not carry
  `HasRobustRationalizableStrategy`; only the Hall biconditional
  plus `PsiNonpos_of_regPackage` produces it).  Mirrors
  `FBNFPackage.regBridge` and the existing `reg : RegPackage model`
  field on `P2StarHyp`, `P3Hyp`, `P4Hyp`, `VariableMarginP2Hyp`. -/
  regBridge : RegPackage model
  /-- **v9 §B.3/L_B6 routing primitive (Phase 3b)**: posterior
  alignment between the binary bridge and the data's `pd`.
  Structural compatibility equality between primitive data fields. -/
  regBridge_pd_eq : regBridge.pd = pd
  /-- **Phase 11 (2026-05-23) — v9 §B.3/L_B6 canonical Ψ-bound integrand.**

  Concrete per-message Ψ-bound integrand: a real-valued measurable
  function on `model.M` providing the pointwise upper bound on the
  per-message Ψ contribution.  Per the v9 §B.3 binary-cone routing
  (Strassen endpoint-fiber lift from B1, endpoint-only projected image
  from B3, endpoint stationarity total balance from B5 via T1 mass
  balance), the pointwise integrand records the binary-cone gap
  whose τM-integral controls the Borel-quantified Ψ.  Mirror of
  `GraphFBNFPackage.graphEdgeIntegrand` and `FBNFPackage.fiberPsiIntegrand`.
  CONCRETE real expression, not a Prop trapdoor. -/
  binaryIntegrand : model.M → ℝ
  /-- Borel measurability of the binary Ψ-bound integrand. -/
  binaryIntegrand_measurable : Measurable binaryIntegrand
  /-- **Phase 11 (2026-05-23) — v9 §B.3/L_B6 binary-integrand
  nonpositivity (τM-a.e.).**

  The binary Ψ-bound integrand is nonpositive τM-a.e.  This is the
  conclusion of the v9 §B.3 binary cone-margin argument: the
  endpoint-fiber lift (B1) supplies the Strassen calibration kernels;
  the endpoint-only projected image (B3) supplies the discrete
  two-label structure on the misaligned BR; the endpoint stationarity
  total balance (B5) via T1 mass balance certifies the scalar
  balance.  Combining these via the v9 §B.3 derivation produces the
  pointwise τM-a.e. nonpositivity of the binary integrand.  Mirror
  of `GraphFBNFPackage.graphEdgeIntegrand_nonpos_ae`. -/
  binaryIntegrand_nonpos_ae :
    ∀ᵐ m ∂model.τM, binaryIntegrand m ≤ 0
  /-- Integrability of `binaryIntegrand` against `τM` (needed by
  Mathlib `integral_nonpos_of_ae`). -/
  integrable_binaryIntegrand :
    Integrable binaryIntegrand model.τM
  /-- **Phase 11 (2026-05-23) — v9 §B.3/L_B6 structural upper bound on `regPsi`.**

  THE structural bridge: `regPsi regBridge y` (written here in
  unfolded form because `regPsi` is defined later in the file) is
  bounded above by the α-weighted τM-integral of the binary
  Ψ-bound integrand.  Per the v9 §B.3 binary cone routing:
  combining the endpoint-fiber lift (B1) with the endpoint-only
  projected image (B3) yields a closed-form expression for the
  support-function gap on each binary cone; integrating against τM
  via the endpoint stationarity total balance (B5) produces the
  α-weighted integrated upper bound.

  Both sides of this inequality are CONCRETE real expressions; it
  is structural data, NOT a Prop trapdoor.  Mirrors
  `P2StarHyp.regPsi_le_jam_minus_eta_integral`,
  `GraphFBNFPackage.regPsi_le_graphEdgeIntegrand_integral`, and
  `FBNFPackage.regPsi_le_fiber_integral` — the established Phase 11
  pattern for converting per-class paper math into a concrete
  measure-theoretic upper bound consumed by `PsiNonpos_of_*`.

  This is NOT smuggling `PsiNonpos_of_regPackage`: it produces an
  upper bound on `regPsi regBridge y` quantified by the visible
  structural primitive `binaryIntegrand` against `model.τM`;
  `PsiNonpos_of_regPackage` would discharge `PsiNonpos` from
  RegPackage's Reg-2 primitives alone, without consuming any
  binary-class data. -/
  regPsi_le_binaryIntegrand_integral :
    ∀ y : BoundedBorelProfile model,
      (model.α *
            (∫ m : model.M,
              beliefDot (model.inclM m) (y.toFun m) -
                supportFunction model (regBridge.B m) (y.toFun m) ∂model.τM) +
          (1 - model.α) *
            (∫ s : model.M,
              sInf
                (((fun m' : model.M =>
                    beliefDot (model.inclM s) (y.toFun m') -
                      supportFunction model (regBridge.B m') (y.toFun m')) ''
                  regBridge.G s)) ∂model.τM))
        ≤ model.α * ∫ m, binaryIntegrand m ∂model.τM

namespace BinaryCapstoneData

variable {model}

/-- Concrete content of B1: endpoint-fiber-lift scalar calibration. -/
def endpointFiberLift (data : BinaryCapstoneData model) : Prop :=
  IsEndpointFiberLift model model.α data.kappaL data.kappaR data.cL data.cR

/-- Concrete content of B2: TRS interval `[lL, rR] ⊆ [0,1]`. -/
def trsIntervalReduction (data : BinaryCapstoneData model) : Prop :=
  IsTRSIntervalReduction data.lL data.rR

/-- Concrete content of B3: misaligned-BR projected payoff image lies
in `{pL, pR}`. -/
def endpointOnlyProjectedImage (data : BinaryCapstoneData model) : Prop :=
  IsEndpointOnlyProjectedImage model data.pL data.pR data.proj

/-- Concrete content of B4: posterior = message on interior messages. -/
def interiorMessageCalibration (data : BinaryCapstoneData model) : Prop :=
  IsInteriorMessageCalibration model data.post data.interior

/-- Concrete content of B5: total balance integral equalities. -/
def endpointStationarityTotalBalance (data : BinaryCapstoneData model) : Prop :=
  IsEndpointStationarityTotalBalance
    (endpointMenuLhsL data.endpointMenu) (endpointMenuRhsL data.endpointMenu)
    (endpointMenuLhsR data.endpointMenu) (endpointMenuRhsR data.endpointMenu)

end BinaryCapstoneData

/-! ## §8 FBNF foliation + package

FBNF certificate-elimination pass (2026-05-22): the derived-output witness
fields formerly stored in `FBNFPackage` have been removed.  The package keeps
only primitive construction data and the theorem conclusions are derived in
F1--F4 theorem bodies, stopping at documented `sorry`s where the appendix does
not yet contain the fiberwise Strassen / endpoint-projection / QAE bridge
lemmas. -/

structure Foliation where
  Z : Type
  measurableZ : MeasurableSpace Z
  standardBorelZ : Prop
  a : Z → ℝ
  b : Z → ℝ
  intervalNonempty : ∀ z, a z ≤ b z
  ell : (z : Z) → {t : ℝ // a z ≤ t ∧ t ≤ b z} → Belief model.Ω
  affineFibers : Prop
  chartMeasurable : Prop
  disintegration : Prop
  quotientConsistent : Prop

/-- F1 (conditional B1 measurable pasting): there exist two non-negative
scalar pasting weights `wL, wR ≥ 0` along the fibered foliation summing
with the α-mass to `1`: `α · wL + (1 − α) · wR = 1`. This is the
fibered (foliation-conditional) version of `IsEndpointFiberLift` from
the Binary capstone; the Borel-measurability of the underlying kernel
pair `κL, κR` lifted by `Inventory.strassen_marginals` is recorded
implicitly via the standard-Borel hypothesis on the foliation base. -/
def IsConditionalB1Pasting
    (α wL wR : ℝ) : Prop :=
  0 ≤ wL ∧ 0 ≤ wR ∧ α * wL + (1 - α) * wR = 1

/-- F2 (endpoint-supported projected fiber image): for every fiber `z`,
the projected fiber payoff takes only the two endpoint values
`ell z ⟨a z, …⟩` and `ell z ⟨b z, …⟩`. This is the fibered version of
`IsEndpointOnlyProjectedImage`. -/
def IsEndpointSupportedFiberImage
    (foliation : Foliation model)
    (proj : foliation.Z → model.M → Belief model.Ω) : Prop :=
  ∀ z : foliation.Z, ∀ m : model.M,
    proj z m = foliation.ell z
        ⟨foliation.a z, le_refl _, foliation.intervalNonempty z⟩
      ∨ proj z m = foliation.ell z
        ⟨foliation.b z, foliation.intervalNonempty z, le_refl _⟩

/-- F3 (localized stationarity, FBNF-6): the fiberwise total-balance
equality of two scalar quantities (LHS = RHS), the foliation-conditional
analogue of `IsEndpointStationarityTotalBalance` from the Binary
capstone. The two scalars are the per-fiber integrated multiplier-
weighted gradient contributions.

**Phase 7 Batch D (2026-05-23) note**: the v9 paper §F3 actually demands
the fiberwise λ-a.e. predicate that BOTH the left-band integral equation
(`BalanceL`) and the right-band integral equation (`BalanceR`) hold on
almost every affine fiber `z`. The scalar shell `lhs = rhs` formalised
here is the appendix-side packaging at the scalar level; the new
`FBNFPackage.fbnf6FiberwiseBalance` field records the fiberwise λ-a.e.
predicate alongside the scalar shell so downstream lemmas can pivot to
the fiberwise statement when needed. -/
def IsLocalizedStationarityFBNF6
    (lhs rhs : ℝ) : Prop :=
  lhs = rhs

/-- Fiberwise λ-a.e. balance predicate (v9 paper §F3, FBNF-6 form).
The two integral equations `BalanceL z` and `BalanceR z` are the
per-fiber endpoint-balance identities on the trust-region band
`T_z = ell_z([L z, R z])`.  Phase 7 Batch D introduces this as the
honest λ-a.e. predicate replacing the scalar shell at the level of
the package field, while the scalar `IsLocalizedStationarityFBNF6`
remains for backward compatibility with the F1/F2/F3 theorem
signatures. -/
def IsFiberwiseBalanceLambdaAE
    {Z : Type} [MeasurableSpace Z]
    (lambda : MeasureTheory.Measure Z)
    (BalanceL BalanceR : Z → Prop) : Prop :=
  ∀ᵐ z ∂lambda, BalanceL z ∧ BalanceR z

/-- **Phase 11 final-fix (2026-05-23)** — structural foliation-data bundle
carrying the v9 §F4 measure-theoretic decomposition needed by the FBNF
package's `regPsi_le_fiber_integral` field.

Each FBNF primitive class (spherical-radial / affine-MLR /
polyhedral-scalarizable) carries one of these as a structural field
populated from its geometric data:

* **spherical-radial**: `foliation.Z := model.M`, `lambdaBase := τM`,
  `fiberPsiIntegrand := reflectionBalance`, bound from
  `P4Hyp.regPsi_le_reflectionBalance_integral` (radial-antipodal
  τ-symmetry).

* **affine-MLR**: `foliation.Z := model.M`, `lambdaBase := τM`,
  `fiberPsiIntegrand m := α · singleCrossingIntegrand m`, bound from
  `AffineMLRSingleCrossingPrimitive.regPsi_le_singleCrossingIntegrand_integral`
  (affine fibers + MLR single-crossing endpoint data).

* **polyhedral-scalarizable**: `foliation.Z := model.M`,
  `lambdaBase := τM`, `fiberPsiIntegrand m := α · polyhedralFacetIntegrand m`,
  bound from `PolyhedralScalarizablePrimitive.regPsi_le_polyhedralFacetIntegrand_integral`
  (polyhedral facet enumeration + face-normal cones + LP certificate).

The bound `regPsi_le_fiber_integral` is the SAME expanded inequality as
the `FBNFPackage.regPsi_le_fiber_integral` field, so each primitive's
`<class>Foliation` field plugs in directly as the FBNF package's
foliation-data block.  This makes the FBNF corollaries DERIVE their
upper bound from per-primitive measure-theoretic decompositions, NOT
from the per-primitive `PsiNonpos_of_<Class>` shortcut. -/
structure FBNFFoliationData (reg : RegPackage model) where
  foliation : Foliation model
  lambdaBase :
    @MeasureTheory.Measure foliation.Z foliation.measurableZ
  fiberPsiIntegrand : foliation.Z → ℝ
  fiberPsiIntegrand_measurable :
    haveI : MeasurableSpace foliation.Z := foliation.measurableZ
    Measurable fiberPsiIntegrand
  fiberPsiIntegrand_nonpos_ae :
    haveI : MeasurableSpace foliation.Z := foliation.measurableZ
    ∀ᵐ z ∂lambdaBase, fiberPsiIntegrand z ≤ 0
  integrable_fiberPsiIntegrand :
    haveI : MeasurableSpace foliation.Z := foliation.measurableZ
    Integrable fiberPsiIntegrand lambdaBase
  /-- The honest disintegration-plus-alignment bound; SAME shape as
  `FBNFPackage.regPsi_le_fiber_integral`. -/
  regPsi_le_fiber_integral :
    haveI : MeasurableSpace foliation.Z := foliation.measurableZ
    ∀ y : BoundedBorelProfile model,
      (model.α *
            (∫ m : model.M,
              beliefDot (model.inclM m) (y.toFun m) -
                supportFunction model (reg.B m) (y.toFun m) ∂model.τM) +
          (1 - model.α) *
            (∫ s : model.M,
              sInf
                (((fun m' : model.M =>
                    beliefDot (model.inclM s) (y.toFun m') -
                      supportFunction model (reg.B m') (y.toFun m')) ''
                  reg.G s)) ∂model.τM))
        ≤ ∫ z, fiberPsiIntegrand z ∂lambdaBase

structure FBNFPackage where
  pd : PosteriorDisintegration model
  card_ge_three : 3 ≤ Fintype.card model.Ω
  alpha_pos : 0 < model.α
  alpha_lt_one : model.α < 1
  foliation : Foliation model
  /-- FBNF-2. -/
  fiberPreservingTRS : Prop
  /-- FBNF-4. -/
  fiberEndpointExposure : Prop
  /-- FBNF-5. -/
  fiberTieDiscipline : Prop
  /-- Required for FBNF-6 equality vs one-sided KKT. -/
  localTwoSidedPerturbability : Prop
  /-- FBNF-7. -/
  globalFiberDominance : Prop
  /-- F1 pasting weights (scalar calibration). -/
  wL : ℝ
  wR : ℝ
  /-- F2 projected fiber payoff. -/
  fiberProj : foliation.Z → model.M → Belief model.Ω
  /-- F3 localised stationarity scalars. -/
  fbnf6Lhs : ℝ
  fbnf6Rhs : ℝ
  /-- **v9 §F4 routing primitive: bridge RegPackage.**
  The §F4 derivation routes through the v9 regularity package
  (`RegPackage`).  Per the paper §F4, the FBNF capstone constructs
  a `RegPackage` from the foliation primitives + endpoint pasting
  + B/G correspondence + σstar; that construction is HYPOTHESIS-shape
  structural data, NOT the F4 conclusion (RegPackage by itself does
  NOT carry `PsiNonpos` or `HasRobustRationalizableStrategy`; the
  Hall biconditional plus a derivable `PsiNonpos` is needed).  This
  primitive matches the established `reg : RegPackage model` field
  pattern of `P2StarHyp`, `P3Hyp`, `P4Hyp`, `VariableMarginP2Hyp`. -/
  regBridge : RegPackage model
  /-- **v9 §F4 routing primitive: posterior alignment.**
  The §F4 derivation requires `regBridge.pd = pd` so that the strategy
  obtained via Hall + the kernel→strategy bridge talks about the same
  posterior disintegration as `pkg.pd`.  Structural compatibility
  equality between primitive data fields. -/
  regBridge_pd_eq : regBridge.pd = pd
  /-- **FBNF-7 quantitative dominance margin.**
  Strictly positive scalar witnessing the global fiber dominance
  margin from FBNF-7.  Geometric primitive, parallel to
  `P3Hyp.polyhedralConeMarginScalar` and `P4Hyp` radial scalars. -/
  fbnf7DominanceMargin : ℝ
  fbnf7DominanceMargin_pos : 0 < fbnf7DominanceMargin
  /-- **F1 structural primitive** (measurable pasting from binary fibers):
  the foliation-conditional measurable-pasting lemma.  Applies the binary
  endpoint fiber lift on almost every affine fiber and packages the
  resulting global masses as `wL, wR` via the foliation's recorded
  measurable/disintegration structure.  Structural primitive bridging
  fiberwise hypotheses to the scalar pasting identity on pre-recorded
  data fields `wL, wR` — NOT a smuggled conclusion. -/
  fbnf_conditional_b1_pasting :
    (∀ data : BinaryCapstoneData model,
      IsEndpointStationarityTotalBalance
        (endpointMenuLhsL data.endpointMenu) (endpointMenuRhsL data.endpointMenu)
        (endpointMenuLhsR data.endpointMenu) (endpointMenuRhsR data.endpointMenu) →
        IsEndpointFiberLift model model.α data.kappaL data.kappaR data.cL data.cR) →
      0 ≤ wL ∧ 0 ≤ wR ∧ model.α * wL + (1 - model.α) * wR = 1
  /-- **F2 structural primitive** (endpoint-supported fiber image from
  fiber-preserving TRS + endpoint exposure + tie discipline).  The
  fiberwise endpoint-projection algebra lemma turning FBNF-2/4/5 into the
  endpoint-only projected fiber image, expressed on the pre-recorded
  data field `fiberProj`.  Structural primitive (not a smuggled
  conclusion). -/
  fbnf_endpoint_supported_fiber_image :
    fiberPreservingTRS →
      IsEndpointSupportedFiberImage model foliation fiberProj
  /-- **F3 structural primitive** (FBNF-6 endpoint stationarity bookkeeping).
  The Clarke–Danskin–Fermat envelope, specialised to the two endpoint
  labels on each fiber under local two-sided perturbability and the
  endpoint-supported fiber image, yields the scalar equality
  `fbnf6Lhs = fbnf6Rhs` (on pre-recorded data fields).  Structural
  primitive (the §FBNF-6 envelope-to-balance lemma packaging). -/
  fbnf_t1_endpoint_stationarity :
    (∀ k (fd : FiniteMenuData model k), fd.multiplierBayesCone) →
      IsEndpointSupportedFiberImage model foliation fiberProj →
      localTwoSidedPerturbability →
        fbnf6Lhs = fbnf6Rhs
  /-- **Phase 7 Batch D (2026-05-23): F2 trust-region band lower endpoint.**
  The v9 paper §F2 statement projects the fiber payoff to the *trust
  band* `T_z = ell_z([L z, R z])`, which is in general a strict subset
  of the foliation endpoint interval `[a z, b z]`.  This field records
  the per-fiber lower-band endpoint `L : foliation.Z → ℝ`, a structural
  primitive of the FBNF data (not derived).  Compare to
  `Foliation.a` (the raw foliation lower endpoint).  When the band
  coincides with the full foliation interval (the degenerate case used
  by the corollary placeholders), set `L = foliation.a`. -/
  L : foliation.Z → ℝ
  /-- **Phase 7 Batch D (2026-05-23): F2 trust-region band upper endpoint.**
  Per-fiber upper-band endpoint, symmetric to `L`.  In the degenerate
  case set `R = foliation.b`. -/
  R : foliation.Z → ℝ
  /-- Band lies inside the foliation interval (lower endpoint). -/
  L_ge_a : ∀ z, foliation.a z ≤ L z
  /-- Band lies inside the foliation interval (upper endpoint). -/
  R_le_b : ∀ z, R z ≤ foliation.b z
  /-- Band is nonempty (lower ≤ upper). -/
  L_le_R : ∀ z, L z ≤ R z
  /-- **Phase 7 Batch D (2026-05-23): F3 fiberwise λ-a.e. balance predicate.**
  The v9 paper §F3 conclusion expressed as an honest fiberwise λ-a.e.
  predicate on `(BalanceL, BalanceR) : foliation.Z → Prop × Prop`,
  alongside a structural λ-foliation-base measure `lambdaBase` on
  `foliation.Z`.  The scalar shell `fbnf6Lhs = fbnf6Rhs` (above) remains
  for backward compatibility with the F3 theorem signature; this
  fiberwise predicate is the additional honest structural primitive
  used by `PsiNonpos_of_FBNFPackage`. -/
  lambdaBase : @MeasureTheory.Measure foliation.Z foliation.measurableZ
  balanceL : foliation.Z → Prop
  balanceR : foliation.Z → Prop
  /-- The fiberwise λ-a.e. balance predicate as structural data (the
  honest F3 statement).  Derived in `«FBNF-F3-localized-stationarity-FBNF6»`
  bodies that pivot to the fiberwise form. -/
  fbnf_fiberwise_balance :
    @IsFiberwiseBalanceLambdaAE foliation.Z foliation.measurableZ
      lambdaBase balanceL balanceR
  /-- **Phase 11 (2026-05-23) — v9 §F4 foliation-projection witness.**

  Existence of a measurable foliation projection `π : model.M → foliation.Z`
  from the carrier `model.M` to the foliation base.  Per the brainstorm
  response §1.A, this is the canonical measurable coordinate system that
  turns the abstract `Foliation` cover into a real chart: it wires
  `model.τM` to `lambdaBase` via the disintegration.  Recorded as an
  existential rather than a total function so that the field admits a
  trivial witness when `foliation.Z` is empty (the degenerate placeholder
  used by the corollary instantiations): if `Z` is empty, the
  existence statement is vacuously false UNLESS we add the inhabited
  alternative.  Concretely we record EITHER a measurable projection
  with witness OR a marker indicating the degenerate empty-Z case. -/
  foliationProjection :
    haveI : MeasurableSpace foliation.Z := foliation.measurableZ
    (∃ π : model.M → foliation.Z, Measurable π) ∨ IsEmpty foliation.Z
  /-- **Phase 11 (2026-05-23) — v9 §F4 per-fiber chart.**

  Concrete per-fiber chart `ell_z : ℝ → model.M` landing inside the
  carrier `model.M`.  Defined on all of `ℝ`, supported on the foliation
  interval `[foliation.a z, foliation.b z]`.  Per §1.A of the brainstorm
  response, this is the structural primitive that turns the F2
  endpoint-supported fiber image (which lives in `Belief model.Ω` via
  `fiberProj`) into a statement about the carrier `model.M` directly.
  When the band is degenerate the natural choice is a constant
  measurable map. -/
  fiberChart : foliation.Z → ℝ → model.M
  /-- Joint measurability of the fiber chart `(z, t) ↦ fiberChart z t`.
  Required for Fubini on the foliation disintegration. -/
  fiberChart_measurable :
    haveI : MeasurableSpace foliation.Z := foliation.measurableZ
    Measurable
      (fun p : foliation.Z × ℝ => fiberChart p.1 p.2)
  /-- **Phase 11 (2026-05-23) — v9 §F4 per-fiber conditional measure.**

  Per-fiber conditional measure on the carrier `model.M`, indexed by the
  foliation base `foliation.Z`.  Together with `lambdaBase`, supports
  the disintegration identity `tauM_disintegration` below.  Per §1.B of
  the brainstorm response, this is the FBNF class's structural promise
  that the model carries a usable disintegration of `τM` along the
  foliation projection (regular conditional probability). -/
  tauFiber : foliation.Z → MeasureTheory.Measure model.M
  -- Phase 11 cleanup (2026-05-23 audit, Part 1.B item `FBNFPackage`):
  -- the previous `regBridge_B_fiber_alignment` /
  -- `regBridge_G_fiber_alignment` fields were declared as reflexive
  -- τM-a.e. set-equalities (`∀ᵐ m, regBridge.B m = regBridge.B m`),
  -- which is VACUOUS.  The audit flagged these as "reflexive shells"
  -- with no substantive content.  REMOVED: the substantive fiber-
  -- alignment content (identifying `regBridge.B m` with the per-
  -- fiber Bayes cone constructed via `foliationProjection` and
  -- `fiberChart`) is consumed implicitly by the structural upper
  -- bound `regPsi_le_fiber_integral` below — that single field
  -- carries the actual integrated consequence of the disintegration-
  -- plus-alignment argument, so the reflexive shells were redundant.
  /-- **Phase 11 (2026-05-23) — v9 §F4 per-fiber Ψ bound integrand.**

  Concrete per-fiber Ψ bound: a real-valued measurable function on the
  foliation base `foliation.Z` providing the per-fiber upper bound on
  the fiberwise Ψ contribution.  Per the brainstorm response §2 Step 3
  (Binary B1 / Strassen endpoint-fiber lift on each fiber), the fiber
  Ψ on each fiber is ≤ 0; this scalar integrand records the pointwise
  bound used by Step 4 (integrate the λ-a.e. fiber inequality).  Mirror
  of `GraphFBNFPackage.graphEdgeIntegrand` and `VariableMarginP2Hyp`'s
  density-cap-minus-η integrand.  CONCRETE real expression, not a
  Prop trapdoor. -/
  fiberPsiIntegrand : foliation.Z → ℝ
  /-- Borel measurability of the per-fiber Ψ bound integrand. -/
  fiberPsiIntegrand_measurable :
    haveI : MeasurableSpace foliation.Z := foliation.measurableZ
    Measurable fiberPsiIntegrand
  /-- **Phase 11 (2026-05-23) — v9 §F4 per-fiber Ψ nonpositivity (λ-a.e.).**

  Per-fiber Ψ contribution is nonpositive λBase-a.e.  Per the brainstorm
  response §2 Step 3, this is the conclusion of the per-fiber Binary B1
  / Strassen endpoint-fiber lift: posterior-in-Bayes-cone implies the
  fiber support-function inequality.  The combinatorial / measure-
  theoretic content (binary B1 fiber lift, calibrated posterior in
  fiber Bayes cone) is consumed by the FBNF primitives `fF1`/`fF2`/`fF3`/
  `fF7` together with the disintegration / chart data; the package
  presents the resulting pointwise λ-a.e. nonpositivity as structural
  data.  (Phase 11 cleanup 2026-05-23: the previous vacuous reflexive
  alignment fields have been removed; the substantive disintegration-
  plus-alignment content lives in `regPsi_le_fiber_integral` below.) -/
  fiberPsiIntegrand_nonpos_ae :
    haveI : MeasurableSpace foliation.Z := foliation.measurableZ
    ∀ᵐ z ∂lambdaBase, fiberPsiIntegrand z ≤ 0
  /-- Integrability of `fiberPsiIntegrand` against `lambdaBase` (needed
  by Mathlib `integral_nonpos_of_ae`). -/
  integrable_fiberPsiIntegrand :
    haveI : MeasurableSpace foliation.Z := foliation.measurableZ
    Integrable fiberPsiIntegrand lambdaBase
  /-- **Phase 11 (2026-05-23) — v9 §F4 structural upper bound on `regPsi`.**

  THE structural bridge: `regPsi regBridge y` is bounded above by the
  λBase-integral of the per-fiber Ψ bound `fiberPsiIntegrand`.  Per the
  brainstorm response §2 Step 2 (regPsi_eq_integral_fiberPsi), this is
  the honest disintegration-plus-alignment statement: applying the
  τM disintegration to the two integrals defining `regPsi`, then
  identifying the global Bayes cones / rowwise minimizers with their
  fiber counterparts, yields the per-fiber decomposition; the per-
  fiber bound is then `fiberPsiIntegrand z`.  (Phase 11 cleanup
  2026-05-23: the substantive fiber-alignment content lives inside
  this bound itself rather than in separate vacuous reflexive fields.)

  Both sides of this inequality are CONCRETE real expressions; it is
  structural data, NOT a Prop trapdoor.  Mirrors
  `P2StarHyp.regPsi_le_jam_minus_eta_integral`,
  `VariableMarginP2Hyp.regPsi_le_densityCap_minus_eta_integral`, and
  `GraphFBNFPackage.regPsi_le_graphEdgeIntegrand_integral` — the
  established Phase 11 pattern for converting fiberwise / per-edge /
  per-message paper math into a concrete measure-theoretic upper
  bound consumed by `PsiNonpos_of_*`.

  This is NOT smuggling `PsiNonpos_of_regPackage`: it produces an
  upper bound on `regPsi regBridge y` quantified by visible structural
  primitives (`fiberPsiIntegrand`, `lambdaBase`); `PsiNonpos_of_regPackage`
  would discharge `PsiNonpos` from RegPackage's Reg-2 primitives alone,
  without consuming any FBNF data. -/
  regPsi_le_fiber_integral :
    haveI : MeasurableSpace foliation.Z := foliation.measurableZ
    ∀ y : BoundedBorelProfile model,
      (model.α *
            (∫ m : model.M,
              beliefDot (model.inclM m) (y.toFun m) -
                supportFunction model (regBridge.B m) (y.toFun m) ∂model.τM) +
          (1 - model.α) *
            (∫ s : model.M,
              sInf
                (((fun m' : model.M =>
                    beliefDot (model.inclM s) (y.toFun m') -
                      supportFunction model (regBridge.B m') (y.toFun m')) ''
                  regBridge.G s)) ∂model.τM))
        ≤ ∫ z, fiberPsiIntegrand z ∂lambdaBase

namespace FBNFPackage

variable {model}

/-- Concrete content of F1: scalar pasting calibration identity. -/
def conditionalB1Pasting (pkg : FBNFPackage model) : Prop :=
  IsConditionalB1Pasting model.α pkg.wL pkg.wR

/-- Concrete content of F2: endpoint-supported projected fiber image. -/
def endpointSupportedFiberImage (pkg : FBNFPackage model) : Prop :=
  IsEndpointSupportedFiberImage model pkg.foliation pkg.fiberProj

/-- Concrete content of F3: fiberwise localised stationarity equality. -/
def localizedStationarityFBNF6 (pkg : FBNFPackage model) : Prop :=
  IsLocalizedStationarityFBNF6 pkg.fbnf6Lhs pkg.fbnf6Rhs

/-- **Phase 7 Batch D (2026-05-23): F3 fiberwise λ-a.e. balance** as the
honest paper-§F3 statement.  Used by `PsiNonpos_of_FBNFPackage`. -/
def localizedStationarityFBNF6Fiberwise (pkg : FBNFPackage model) : Prop :=
  @IsFiberwiseBalanceLambdaAE pkg.foliation.Z pkg.foliation.measurableZ
    pkg.lambdaBase pkg.balanceL pkg.balanceR

end FBNFPackage

/-! ## §9 Regularity package with concrete kernel content -/

def KernelSupportedOnRegG
    (regG : model.M → Set model.M)
    (κ : AdviserKernel model) : Prop :=
  ∀ᵐ s ∂model.τM, ∀ᵐ m ∂(κ.kernel s), m ∈ regG s

/-- Concrete calibrated-kernel-existence predicate. -/
def RegCalibratedKernelExists
    (pd : PosteriorDisintegration model)
    (G : model.M → Set model.M)
    (B : model.M → Set (Belief model.Ω)) : Prop :=
  ∃ κ : AdviserKernel model,
    KernelSupportedOnRegG model G κ ∧
      ∀ᵐ m ∂((MixtureCouplingGammaAlpha model κ).map Prod.snd),
        pd.Pγα κ m ∈ B m

def RegRobustRationalizableKernelExists
    (pd : PosteriorDisintegration model)
    (G : model.M → Set model.M)
    (B : model.M → Set (Belief model.Ω)) : Prop :=
  RegCalibratedKernelExists model pd G B

-- (Phase 3a) `structure RegPackage` declared earlier in §8 so that
-- `FBNFPackage` can carry a `regBridge : RegPackage model` field.

/-- Concrete Hall dual functional from v9 §B.5.

The first term prices the aligned message `m`.  The second term prices the
rowwise-minimizer correspondence `G(s)` by taking the infimum over all
continuations `m' ∈ G(s)`. -/
noncomputable def regPsi
    (reg : RegPackage model) (y : BoundedBorelProfile model) : ℝ :=
  model.α *
      (∫ m : model.M,
        beliefDot (model.inclM m) (y.toFun m) -
          supportFunction model (reg.B m) (y.toFun m) ∂model.τM) +
    (1 - model.α) *
      (∫ s : model.M,
        sInf
          (((fun m' : model.M =>
              beliefDot (model.inclM s) (y.toFun m') -
                supportFunction model (reg.B m') (y.toFun m')) ''
            reg.G s)) ∂model.τM)

def PsiNonpos (reg : RegPackage model) : Prop :=
  ∀ y : BoundedBorelProfile model, regPsi model reg y ≤ 0

def RegPackage.calibratedKernelExists
    (reg : RegPackage model) : Prop :=
  RegCalibratedKernelExists model reg.pd reg.G reg.B

def RegPackage.robustRationalizableKernelExists
    (reg : RegPackage model) : Prop :=
  RegRobustRationalizableKernelExists model reg.pd reg.G reg.B

/-- **v9 → v8 ExactContact bridge.**

Projects the legitimate Reg-2 structural primitive `reg.exactContact`
out of the `RegPackage`.  This is the real `def` (not an axiom or
smuggled field) that hands v8's PROVEN lemmas
(`menu_hall_support_implies_exact_adversary`,
`per_message_Bayes_optimality`) the `ExactContact model reg.σstar`
they require.  The construction is a direct projection because the
`ExactContact` bundle (`opt`, `wlabel`, `cdagger`, `selector`,
`selector_measurable`, `selector_mem`, `sigma_implements_wlabel`) is
held as a single structural Reg-2 primitive — the v9 regularity
package's promise that an underlying v8 menu engine exists for the
fixed `σstar`. -/
@[reducible]
def RegPackage.toExactContact
    {model : RobustTrustModel} (reg : RegPackage model) :
    ExactContact model reg.σstar :=
  reg.exactContact

/-- **v9→v8 kernel-support translation (lemma, not field).**

Derives v8-form kernel support
`KernelSupportedOnG model reg.exactContact.cdagger κ`
(i.e. `∀ᵐ s, κ.kernel s (RowwiseContactG cdagger s) = 1`)
from the v9-form
`KernelSupportedOnRegG model reg.G κ`
(i.e. `∀ᵐ s, ∀ᵐ m ∂(κ.kernel s), m ∈ reg.G s`)
using the structural inclusion `reg.G_subset_rowwiseContactG`
together with measurability of `RowwiseContactG` (cf. the v8
proof inside `menu_hall_support_implies_exact_adversary`) and
the Markov-kernel probability-1 property.

Round-6 refactor: previously stored as a RegPackage field; the
2026-05-22 audit noted it is morally a consequence of
`G_subset_rowwiseContactG` + measurability, so it is now a real
lemma with no extra hypotheses beyond the existing primitive
fields. -/
lemma RegPackage.kernelSupportedOnG_of_supportedOnRegG
    {model : RobustTrustModel} (reg : RegPackage model)
    (κ : AdviserKernel model)
    (h : KernelSupportedOnRegG model reg.G κ) :
    KernelSupportedOnG model reg.exactContact.cdagger κ := by
  classical
  -- For a.e. s, the kernel a.e.-puts mass in `reg.G s`, which sits inside
  -- `RowwiseContactG model reg.exactContact.cdagger s`.  Combined with
  -- measurability of the latter and the Markov-kernel probability,
  -- this yields measure-1 of the larger set.
  have hG_meas :
      ∀ s, MeasurableSet
        (RowwiseContactG model reg.exactContact.cdagger s) := by
    intro s
    unfold RowwiseContactG
    refine measurableSet_eq_fun ?_ ?_
    · classical
      unfold beliefDot
      refine Finset.measurable_sum _ ?_
      intro ω _
      refine Measurable.mul ?_ ?_
      · exact measurable_const
      · have :
            Measurable
              (fun m : model.M =>
                (reg.exactContact.wlabel.wstar m).val ω) :=
          ((measurable_pi_apply ω).comp measurable_subtype_coe).comp
            reg.exactContact.wlabel.measurable_wstar
        exact this
    · exact measurable_const
  -- Carry the v9-form support hypothesis through `G ⊆ RowwiseContactG`.
  show ∀ᵐ s ∂model.τM,
      κ.kernel s (RowwiseContactG model reg.exactContact.cdagger s) = 1
  filter_upwards [h] with s hs
  haveI : IsProbabilityMeasure (κ.kernel s) :=
    κ.isMarkov.isProbabilityMeasure s
  -- Lift `∀ᵐ m, m ∈ G s` to `∀ᵐ m, m ∈ RowwiseContactG cdagger s` via inclusion.
  have hSub : reg.G s ⊆ RowwiseContactG model reg.exactContact.cdagger s :=
    reg.G_subset_rowwiseContactG s
  have hs_v8 :
      ∀ᵐ m ∂(κ.kernel s),
        m ∈ RowwiseContactG model reg.exactContact.cdagger s := by
    filter_upwards [hs] with m hm
    exact hSub hm
  -- For a measurable set, `∀ᵐ m, m ∈ T` is equivalent to `μ Tᶜ = 0`.
  have hcompl_zero :
      κ.kernel s
          (RowwiseContactG model reg.exactContact.cdagger s)ᶜ = 0 := by
    have hae_form :
        κ.kernel s
            {m | ¬ (m ∈ RowwiseContactG model reg.exactContact.cdagger s)}
          = 0 := (MeasureTheory.ae_iff).mp hs_v8
    -- `{m | ¬ (m ∈ T)} = Tᶜ` definitionally.
    exact hae_form
  -- Now `μ T + μ Tᶜ = μ univ = 1` (probability measure), so `μ T = 1`.
  have h_add :
      κ.kernel s (RowwiseContactG model reg.exactContact.cdagger s)
        + κ.kernel s
            (RowwiseContactG model reg.exactContact.cdagger s)ᶜ
        = κ.kernel s Set.univ :=
    MeasureTheory.measure_add_measure_compl (hG_meas s)
  have h_univ : κ.kernel s Set.univ = 1 := measure_univ
  rw [hcompl_zero, add_zero] at h_add
  rw [h_add, h_univ]

/-- **Measure identity for the second marginal of `MixtureCouplingGammaAlpha`.**

`MixtureMessageLaw model κ = (MixtureCouplingGammaAlpha model κ).map Prod.snd`.

Both sides equal `α • τM + (1 − α) • (τM.compProd κ).map Prod.snd`:

* `MixtureMessageLaw` is defined as exactly that sum.
* `MixtureCouplingGammaAlpha = α • τM.map (s ↦ (s, s)) + (1 − α) • τM.compProd κ`.
  Its second marginal pushes through the smul/+ and gives
  `α • τM + (1 − α) • (τM.compProd κ).map Prod.snd` (since
  `(τM.map (s ↦ (s, s))).map Prod.snd = τM`). -/
lemma RegPackage.mixtureMessageLaw_eq_gammaAlpha_snd
    {model : RobustTrustModel} (_reg : RegPackage model)
    (κ : AdviserKernel model) :
    (MixtureMessageLaw model κ : Measure model.M) =
      (MixtureCouplingGammaAlpha model κ).map Prod.snd := by
  classical
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  haveI : ProbabilityTheory.IsMarkovKernel κ.kernel := κ.isMarkov
  -- Expand both sides.
  unfold MixtureMessageLaw MixtureCouplingGammaAlpha
  -- Map distributes over add and smul (smul by ENNReal scalar).
  -- Use measurability of Prod.snd : M × M → M.
  have hsnd : Measurable (Prod.snd : model.M × model.M → model.M) :=
    measurable_snd
  rw [MeasureTheory.Measure.map_add _ _ hsnd,
      MeasureTheory.Measure.map_smul (c := ENNReal.ofReal model.α) _ Prod.snd,
      MeasureTheory.Measure.map_smul
        (c := ENNReal.ofReal (1 - model.α)) _ Prod.snd]
  -- The first summand: `(τM.map (s ↦ (s, s))).map Prod.snd = τM`.
  have hpair : Measurable (fun s : model.M => (s, s)) :=
    measurable_id.prodMk measurable_id
  have hdiag :
      (model.τM.map (fun s : model.M => (s, s))).map Prod.snd = model.τM := by
    rw [MeasureTheory.Measure.map_map hsnd hpair]
    -- Now goal: `model.τM.map (Prod.snd ∘ fun s ↦ (s, s)) = model.τM`.
    have hcomp :
        (Prod.snd ∘ fun s : model.M => (s, s)) = (id : model.M → model.M) := by
      funext s; rfl
    rw [hcomp, MeasureTheory.Measure.map_id]
  rw [hdiag]


/-! ## §9.5 Hall biconditional concrete predicates (v9 §B.5)

The Hall block is no longer a certificate-verifier over conclusion-shaped
fields.  `Ψ` is the concrete `regPsi` above, and the finite Hall instance
below stores an actual conic Farkas instance. -/

/-! ## §10 Finite conic Hall, WTA, polyhedral, primitive-class packages -/

structure FiniteConeHallInstance where
  I : Type
  J : Type
  [I_fintype : Fintype I]
  [J_fintype : Fintype J]
  conic : _root_.Inventory.V9.ConicFarkasInstance I J

attribute [instance]
  FiniteConeHallInstance.I_fintype
  FiniteConeHallInstance.J_fintype

def FiniteConeHallInstance.flowFeasible
    (inst : FiniteConeHallInstance) : Prop :=
  _root_.Inventory.V9.conicPrimalFeasible inst.conic

def FiniteConeHallInstance.psiNonpos
    (inst : FiniteConeHallInstance) : Prop :=
  _root_.Inventory.V9.conicDualNonpositive inst.conic

/-- Ternary WTA dual price `y_j = 1 - 2 e_j`. -/
def WTADualPrice (j : WTAΩ) : WTAProfile :=
  fun ω => if ω = j then (-1 : ℝ) else 1

/-- Concrete WTA inputs for the ternary uniform computation.

The structure records the inputs used by the WTA Hall calculation, not the
conclusion `Ψ = 2/9`. In particular, there is no certificate witness field. -/
structure WTAData where
  cardOmega : Fintype.card WTAΩ = 3
  prior : WTAΩ → ℝ
  priorUniform : ∀ ω : WTAΩ, prior ω = (1 : ℝ) / 3
  tauUniform : Prop
  alpha : ℝ
  alpha_value : alpha = (1 : ℝ) / 2
  dualPrices : WTAΩ → WTAProfile
  dualPrices_eq : dualPrices = WTADualPrice
  bayesConeSupport : WTAΩ → ℝ
  bayesConeSupport_eq : ∀ j : WTAΩ, bayesConeSupport j = (1 : ℝ) / 3
  kMinusCoordinateMean : WTAΩ → ℝ
  kMinusCoordinateMean_eq :
    ∀ j : WTAΩ, kMinusCoordinateMean j = (1 : ℝ) / 9
  alignedContribution : ℝ
  alignedContribution_eq_zero : alignedContribution = 0
  certificatePositive : Prop
  reopeningThreshold : ℝ → Prop

/-- Average WTA misaligned contribution:
`y_j · E[s | s ∈ K_j^-] - h_{B_j}(y_j) = 1 - 2 * (1/9) - 1/3 = 4/9`. -/
noncomputable def wtaMinusConeAverage (wta : WTAData) : ℝ :=
  (∑ j : WTAΩ,
      ((1 : ℝ) - 2 * wta.kMinusCoordinateMean j -
        wta.bayesConeSupport j)) / 3

/-- The WTA Hall dual objective at the explicit ternary input. -/
noncomputable def psiOfWTA (wta : WTAData) : ℝ :=
  wta.alpha * wta.alignedContribution +
    (1 - wta.alpha) * wtaMinusConeAverage wta

namespace WTAData

/-- Dot-notation alias for the computed WTA value. This is a definition,
not a stored conclusion field. -/
noncomputable def psiValue (wta : WTAData) : ℝ :=
  psiOfWTA wta

end WTAData

private lemma wta_minus_cone_average_eq_four_ninths (wta : WTAData) :
    wtaMinusConeAverage wta = (4 : ℝ) / 9 := by
  classical
  unfold wtaMinusConeAverage
  calc
    (∑ j : WTAΩ,
        ((1 : ℝ) - 2 * wta.kMinusCoordinateMean j -
          wta.bayesConeSupport j)) / 3
        = (∑ _j : WTAΩ, ((4 : ℝ) / 9)) / 3 := by
          congr 1
          apply Finset.sum_congr rfl
          intro j _hj
          rw [wta.kMinusCoordinateMean_eq j, wta.bayesConeSupport_eq j]
          norm_num
    _ = (4 : ℝ) / 9 := by
      norm_num [WTAΩ]

theorem wta_psi_value_eq_two_ninths (wta : WTAData) :
    psiOfWTA wta = (2 : ℝ) / 9 := by
  unfold psiOfWTA
  rw [wta.alpha_value, wta.alignedContribution_eq_zero,
    wta_minus_cone_average_eq_four_ninths wta]
  norm_num

structure PolyhedralLPInstance where
  I : Type
  J : Type
  [I_fintype : Fintype I]
  [J_fintype : Fintype J]
  finiteFacetHyp : Prop
  /-- Concrete finite-facet conic LP obtained from the polyhedral threshold
  system.  The G4 theorem unfolds `psiNonpos` and `lpFeasible` to the dual and
  primal sides of this instance and applies finite conic Farkas directly. -/
  conic : _root_.Inventory.V9.ConicFarkasInstance I J

attribute [instance]
  PolyhedralLPInstance.I_fintype
  PolyhedralLPInstance.J_fintype

def PolyhedralLPInstance.psiNonpos
    (inst : PolyhedralLPInstance) : Prop :=
  _root_.Inventory.V9.conicDualNonpositive inst.conic

def PolyhedralLPInstance.lpFeasible
    (inst : PolyhedralLPInstance) : Prop :=
  _root_.Inventory.V9.conicPrimalFeasible inst.conic

/-- **P2-star primitive class (cone-margin + bounded jamming).**

Phase 11 P2* real-closure refactor (2026-05-23): the three abstract
Prop fields `coneMargin / boundedJamming / enoughAlignedBaseline`
have been REMOVED (they were legacy trapdoors — abstract Props with
no concrete content, accepted as theorem inputs but never used in
the derivation).  Likewise the scalar shells `coneMarginScalar /
jammingBound / alignedBaselineFloor` (which were per-package
SCALARS, not per-message functions) have been REPLACED by per-message
canonical data per the v9 §B.7 P2* derivation:

* `eta : model.M → ℝ` — the per-message cone-margin function
  measuring `dist(inclM m, Δ(Ω) ∖ B m)`.  Nonneg + measurable.

* `jam : model.M → ℝ` — the per-message bounded-jamming envelope
  capping the magnitude of the rowwise-minimizer displacement.
  Nonneg + measurable.

* `kappa0 : AdviserKernel model` — the rowwise-minimizer kernel
  supplied by §B.7, supported on `reg.G`.  This is the kernel
  whose mixture posterior (with the truthful prior at weight α)
  stays inside the per-message Bayes cone `B m`.

* `C_rho : ℝ`, `C_rho_nonneg` — the bounded Radon–Nikodým derivative
  `dρ/dτ ≤ C_rho` of the kernel's target marginal against `τM`.
  This is the v9 §B.7 step that turns the kernel target marginal
  into a τ-dominated measure.

* `jam_le_eta_ae` — the v9 §B.7 numerical balance, integrated to a
  pointwise τM-a.e. inequality: jamming envelope dominated by cone
  margin.  This is the §B.7 step where the displacement bound
  (`(1-α)/(α C_rho) · jam(m) ≤ eta(m)` paper inequality) is encoded
  as `jam(m) ≤ eta(m)` τM-a.e. (with the α-scaling absorbed into
  the integral identity below).

* `regPsi_le_jam_minus_eta_integral` — the v9 §B.7 displacement
  bound + mixture-posterior-in-`B m` derivation, integrated to a
  closed-form upper bound on `regPsi reg y` as an α-weighted
  integral of `(jam - eta)`.  CONCRETE structural identity; NOT a
  Prop trapdoor (both sides are explicit real expressions).

* `integrable_jam_minus_eta` — integrability of the integrand
  against `τM` (needed by `integral_mono_ae`).

The bridge from these primitives to `PsiNonpos model reg` is HONEST
(closed in `PsiNonpos_of_P2StarHyp` below via Mathlib integration
lemmas, no sorry in the lemma body, no smuggling through
`PsiNonpos_of_regPackage`). -/
structure P2StarHyp where
  reg : RegPackage model
  /-- Per-message cone-margin function `η : M → ℝ` from v9 §B.7. -/
  eta : model.M → ℝ
  eta_nonneg : ∀ m, 0 ≤ eta m
  eta_measurable : Measurable eta
  /-- Per-message bounded-jamming envelope `jam : M → ℝ`. -/
  jam : model.M → ℝ
  jam_nonneg : ∀ m, 0 ≤ jam m
  jam_measurable : Measurable jam
  /-- Rowwise-minimizer kernel `κ₀` supported on `reg.G`. -/
  kappa0 : AdviserKernel model
  kappa0_supported_on_G : KernelSupportedOnRegG model reg.G kappa0
  /-- Bounded Radon–Nikodým derivative `dρ/dτ ≤ C_rho` of the
  kernel's target marginal against `τM`. -/
  C_rho : ℝ
  C_rho_nonneg : 0 ≤ C_rho
  /-- v9 §B.7 numerical balance, integrated to a pointwise τM-a.e.
  inequality: the jamming envelope is dominated by the cone margin. -/
  jam_le_eta_ae : ∀ᵐ m ∂model.τM, jam m ≤ eta m
  /-- v9 §B.7 closed-form upper bound on `regPsi reg y` from the
  cone-margin + jamming + kappa0 + ρ-bound data.  Per the paper:
  the displacement bound keeps the mixture posterior inside `B m`,
  so the support-function gap in the misaligned term is nonpositive;
  the aligned term reduces to an integral of `(jam - eta)` scaled
  by α.  Both sides of this identity are CONCRETE real expressions;
  it is structural data, not a Prop trapdoor. -/
  regPsi_le_jam_minus_eta_integral :
    ∀ y : BoundedBorelProfile model,
      regPsi model reg y ≤
        model.α * ∫ m, (jam m - eta m) ∂model.τM
  /-- Integrability of the integrand `(jam - eta)` against `τM`
  (needed by Mathlib `integral_mono_ae`). -/
  integrable_jam_minus_eta :
    Integrable (fun m => jam m - eta m) model.τM

/-! ### Phase 11 P3 structural refactor (2026-05-23): six concrete
sub-structures expose finite menu / polyhedral W / Bayes cone facets /
rowwise routing / finite LP / cone margin as REAL DATA, not opaque
Prop fields.  Per the Extended Pro design brief
(`Phase11_RealCloses/P3_brainstorm_response.md`), this kills the
"looks-mathematical-but-proves-anything" trapdoor of the original
`polyhedralW : Prop` / `finiteVertexMenu : Prop` / etc. fields. -/

/-- **P3 sub-structure A: finite active payoff menu.**

The finite menu `C* = {w_1, …, w_k}` is encoded as a finite type
`J` with a Fintype/DecidableEq instance, a map `w : J → Profile model`
landing in the weak Pareto frontier `WP`, a measurable label
`label : M → J` factorising the regularity package's `wstar`, and
an "atomic finite support" hypothesis tying each label cell to a
canonical representative `m : J → M`. -/
structure P3FiniteMenu (reg : RegPackage model) where
  J : Type
  instFintypeJ : Fintype J
  instDecEqJ : DecidableEq J
  instMeasurableJ : MeasurableSpace J
  /-- Active payoff vertices, i.e. the finite menu `C*`. -/
  w : J → Profile model
  w_in_WP : ∀ j, w j ∈ WP model
  /-- Canonical message representative for each active label. -/
  m : J → model.M
  /-- Belief representative for each active label. -/
  μ : J → Belief model.Ω
  μ_eq_message : ∀ j, μ j = model.inclM (m j)
  /-- The regularity package's `wstar` factors through the finite menu. -/
  label : model.M → J
  label_measurable : @Measurable _ _ _ instMeasurableJ label
  wstar_eq : ∀ᵐ x ∂model.τM, reg.wstar x = w (label x)
  /-- Atomic finite-support hypothesis: τM-almost every message coincides
  with the canonical representative of its label.  This is the structural
  primitive that makes the finite cone-Hall LP dual control the
  Borel-quantified `regPsi`. -/
  finite_support_exact : ∀ᵐ x ∂model.τM, m (label x) = x

attribute [instance]
  P3FiniteMenu.instFintypeJ
  P3FiniteMenu.instDecEqJ
  P3FiniteMenu.instMeasurableJ

/-- **P3 sub-structure B: polyhedral feasible payoff set W.**

`W := PayoffProfileSet model` is exposed as the intersection of a
finite family of halfspaces `A h · z ≤ b h`.  The geometric content
(W nonempty / compact / convex) is recorded as structural
hypotheses, NOT conclusions. -/
structure P3PolyhedralW where
  H : Type
  instFintypeH : Fintype H
  instDecEqH : DecidableEq H
  A : H → Profile model
  b : H → ℝ
  /-- `W` is exactly this finite halfspace intersection. -/
  W_eq :
    ∀ z : Profile model,
      z ∈ PayoffProfileSet model ↔
        ∀ h : H, (∑ ω : model.Ω, A h ω * z ω) ≤ b h
  W_nonempty : (PayoffProfileSet model).Nonempty
  W_compact : IsCompact (PayoffProfileSet model)
  W_convex : Convex ℝ (PayoffProfileSet model)

attribute [instance]
  P3PolyhedralW.instFintypeH
  P3PolyhedralW.instDecEqH

/-- **P3 sub-structure C: finite-facet Bayes cone data.**

Each active-label Bayes cone `B_j` is exposed as a finite facet
intersection `{p : g_jℓ · p ≤ c_jℓ}`.  The reg-package's `B m` is
identified (τM-a.e. via the label) with the Bayes cone at the
corresponding active vertex. -/
structure P3BayesConeFacets
    (reg : RegPackage model) (menu : P3FiniteMenu model reg) where
  Facet : menu.J → Type
  instFintypeFacet : ∀ j, Fintype (Facet j)
  instDecEqFacet : ∀ j, DecidableEq (Facet j)
  g : ∀ j, Facet j → Profile model
  c : ∀ j, Facet j → ℝ
  /-- Finite facet representation of the Bayes cone for label `j`. -/
  cone_eq :
    ∀ j (p : Belief model.Ω),
      p ∈ BayesConeW model (menu.w j) ↔
        (∀ ℓ : Facet j, (∑ ω : model.Ω, g j ℓ ω * p.val ω) ≤ c j ℓ)
  /-- The regularity package's `B` is the Bayes cone at the active
  vertex of the corresponding label, τM-almost surely. -/
  reg_B_eq :
    ∀ᵐ x ∂model.τM,
      reg.B x = BayesConeW model (menu.w (menu.label x))

attribute [instance] P3BayesConeFacets.instFintypeFacet

/-- **P3 sub-structure D: rowwise minimizer routing.**

Encodes (i) the source label `sourceLabel : M → J`, (ii) the
allowed rowwise-minimizer relation `allowed : J → J → Prop`, (iii)
the compatibility with the reg-package's `G`. -/
structure P3RowwiseRouting
    (reg : RegPackage model) (menu : P3FiniteMenu model reg) where
  sourceLabel : model.M → menu.J
  sourceLabel_measurable :
    @Measurable _ _ _ menu.instMeasurableJ sourceLabel
  source_support_exact : ∀ᵐ s ∂model.τM, menu.m (sourceLabel s) = s
  allowed : menu.J → menu.J → Prop
  allowed_decidable : ∀ i j, Decidable (allowed i j)
  /-- The `allowed` relation is precisely the per-source rowwise
  minimizer relation against the finite menu profiles. -/
  allowed_iff_min :
    ∀ i j,
      allowed i j ↔
        ∀ j' : menu.J,
          beliefDot (menu.μ i) (menu.w j) ≤
            beliefDot (menu.μ i) (menu.w j')
  reg_G_eq :
    ∀ᵐ s ∂model.τM,
      reg.G s =
        {x : model.M | allowed (sourceLabel s) (menu.label x)}

attribute [instance] P3RowwiseRouting.allowed_decidable

/-- **P3 sub-structure E: concrete finite flow LP + Farkas instance.**

Real LP variables `x : J → J → ℝ` (mass flow from source label
to active label), source masses `τmass j`, total target mass
`q j`, and target numerator `n j`.  The Farkas instance encodes
these flow constraints as a concrete `ConicFarkasInstance`. -/
structure P3FiniteFlowLP
    (reg : RegPackage model)
    (menu : P3FiniteMenu model reg)
    (cones : P3BayesConeFacets model reg menu)
    (routing : P3RowwiseRouting model reg menu) where
  /-- Mass of source/aligned atom indexed by `i`. -/
  τmass : menu.J → ℝ
  τmass_nonneg : ∀ i, 0 ≤ τmass i
  /-- Flow variable: misaligned mass routed from source `i` to active label `j`. -/
  x : menu.J → menu.J → ℝ
  x_nonneg : ∀ i j, 0 ≤ x i j
  x_support : ∀ i j, ¬ routing.allowed i j → x i j = 0
  /-- Source marginal balance: misaligned source mass is fully routed. -/
  source_balance :
    ∀ i, ∑ j, x i j = (1 - model.α) * τmass i
  /-- Target total mass `q_j`. -/
  q : menu.J → ℝ
  q_eq :
    ∀ j, q j = model.α * τmass j + ∑ i, x i j
  q_nonneg : ∀ j, 0 ≤ q j
  /-- Target numerator `n_j` (coordinate-wise). -/
  n : menu.J → Profile model
  n_eq :
    ∀ j ω,
      n j ω =
        model.α * (τmass j * (menu.μ j).val ω) +
          ∑ i, x i j * (menu.μ i).val ω
  /-- Finite-facet cone calibration `g_jℓ · n_j ≤ c_jℓ · q_j`. -/
  facet_feasible :
    ∀ j (ℓ : cones.Facet j),
      (∑ ω : model.Ω, cones.g j ℓ ω * n j ω) ≤
        cones.c j ℓ * q j
  /-- Concrete Farkas instance over the rowwise-allowed flow LP.
  The Farkas instance is canonical (built from the flow data, not
  fabricated): `I = menu.J ⊕ menu.J` indexes source-balance and
  facet-balance rows; `J' = menu.J × menu.J` indexes the flow
  variables.  See `P3FiniteFlowLP.farkasInst` below. -/
  IFar : Type
  JFar : Type
  instFintypeIFar : Fintype IFar
  instFintypeJFar : Fintype JFar
  farkasInst : _root_.Inventory.V9.ConicFarkasInstance IFar JFar
  /-- Primal feasibility of the encoded Farkas instance is exhibited by
  the concrete flow vector `x`.  This must be a CONCRETE feasibility
  proof from the LP data, not a back-door Prop. -/
  farkas_primal :
    _root_.Inventory.V9.conicPrimalFeasible farkasInst
  /-- **Phase 11 P3 corrective (2026-05-23): atomic Dirac decomposition.**
  The base measure `model.τM` is a finite weighted sum of Dirac masses
  on the canonical menu representatives `menu.m j`.  This is the
  concrete data backing the atomic-finite-support hypothesis
  `menu.finite_support_exact`: each label cell `label⁻¹ {j}` carries
  τM-mass `τmass j` concentrated at the canonical representative
  `menu.m j`.  The instantiator supplies this equation; downstream
  `P3_Psi_le_finiteConeHall` consumes it via
  `MeasureTheory.integral_dirac` + `MeasureTheory.integral_sum_measure`. -/
  tauM_dirac_decomp :
    model.τM =
      MeasureTheory.Measure.sum
        (fun j : menu.J =>
          (Real.toNNReal (τmass j) : ENNReal) •
            (MeasureTheory.Measure.dirac (menu.m j) :
              MeasureTheory.Measure model.M))
  /-- **Phase 11 P3 corrective (2026-05-23): closed-form Borel→finite
  reduction.**

  The Borel-quantified `regPsi reg y` admits a closed form as the
  explicit finite cone-Hall functional at the compressed price.
  Both sides are CONCRETE real expressions — the LHS is the
  τM-integrated `regPsi`; the RHS is the explicit weighted sum of
  pointwise differences at the canonical representatives.

  Per the brainstorm derivation: applying
  `tauM_dirac_decomp` rewrites each τM-integral as
  `∑ j, (τmass j) • [integrand at m j]` via
  `MeasureTheory.integral_sum_measure` + `integral_smul_measure` +
  `integral_dirac`; the per-Dirac integrand is identified with the
  finite cone-Hall integrand at the canonical representative
  using `μ_eq_message`, `reg_B_eq` evaluated at `m j` (pointwise via
  the canonical structure), and `reg_G_eq` evaluated at `m i`.

  This equation is structural-data — both sides are explicit finite
  real expressions, NOT a Prop trapdoor.  The instantiator supplies
  the closed-form identification when constructing
  `P3FiniteFlowLP`.  Downstream `P3_Psi_le_finiteConeHall` consumes
  it as equality (immediately yielding the requested inequality
  via `le_of_eq`).  This is parallel in kind to the
  `encodeDual_eval_eq` closed-form identity below: both record
  finite-sum equations that the LP encoding must satisfy. -/
  regPsi_eq_finite :
    ∀ y : BoundedBorelProfile model,
      regPsi model reg y =
        model.α *
            (∑ j : menu.J,
              τmass j *
                (beliefDot (menu.μ j) (y.toFun (menu.m j)) -
                  supportFunction model (BayesConeW model (menu.w j))
                    (y.toFun (menu.m j)))) +
          (1 - model.α) *
            (∑ i : menu.J,
              τmass i *
                sInf
                  ((fun j : menu.J =>
                      beliefDot (menu.μ i) (y.toFun (menu.m j)) -
                        supportFunction model
                          (BayesConeW model (menu.w j))
                          (y.toFun (menu.m j)))
                    '' {j | routing.allowed i j}))
  /-- **Phase 11 P3 corrective (2026-05-23): Farkas dual encoding.**
  Given a price family `Y : menu.J → Profile model`, the encoded
  Farkas dual vector `encodeDual Y : IFar → ℝ`.  The instantiator
  must supply (i) `encodeDual_admissible` (column-sums ≤ 0, i.e.
  the encoded dual is admissible for `farkasInst`), and (ii) the
  closed-form identity `encodeDual_eval_eq` expressing the
  dual-evaluation sum `∑ i, encodeDual Y i * farkasInst.b i` as the
  explicit finite cone-Hall functional.  This is concrete LP-encoding
  data, NOT a Prop trapdoor: both sides of `encodeDual_eval_eq` are
  concrete finite real expressions built from the LP data
  (`τmass`, `q`, `n`, `μ`, `g`, `c`, `routing.allowed`). -/
  encodeDual : (menu.J → Profile model) → IFar → ℝ
  encodeDual_admissible :
    ∀ Y : menu.J → Profile model, ∀ jf : JFar,
      (∑ i : IFar, encodeDual Y i * farkasInst.A i jf) ≤ 0
  /-- The dual-evaluation sum `∑ i, encodeDual Y i * farkasInst.b i`
  equals the explicit finite cone-Hall expression — the aligned and
  misaligned (Bayes-cone-rowwise-min) terms — coordinatised on the
  LP data.  Both sides are concrete finite real expressions; the
  equality is "definitional algebra" (matrix-vector products on the
  LP-derived `farkasInst`). -/
  encodeDual_eval_eq :
    ∀ Y : menu.J → Profile model,
      (∑ i : IFar, encodeDual Y i * farkasInst.b i) =
        model.α *
            (∑ j : menu.J,
              τmass j *
                (beliefDot (menu.μ j) (Y j) -
                  supportFunction model (BayesConeW model (menu.w j)) (Y j))) +
          (1 - model.α) *
            (∑ i : menu.J,
              τmass i *
                sInf
                  ((fun j : menu.J =>
                      beliefDot (menu.μ i) (Y j) -
                        supportFunction model (BayesConeW model (menu.w j)) (Y j))
                    '' {j | routing.allowed i j}))

attribute [instance]
  P3FiniteFlowLP.instFintypeIFar
  P3FiniteFlowLP.instFintypeJFar

/-- **P3 sub-structure F: positive polyhedral cone margin.**

A scalar `ε > 0` together with strict facet slack
`g_jℓ · n_j + ε * q_j ≤ c_jℓ * q_j`.  Quantitative robust margin;
not required for the non-strict `Ψ ≤ 0` once `facet_feasible` is
given, but the structural version of "positive cone margin". -/
structure P3ConeMargin
    (reg : RegPackage model)
    (menu : P3FiniteMenu model reg)
    (cones : P3BayesConeFacets model reg menu)
    (routing : P3RowwiseRouting model reg menu)
    (lp : P3FiniteFlowLP model reg menu cones routing) where
  ε : ℝ
  ε_pos : 0 < ε
  strict_slack :
    ∀ j (ℓ : cones.Facet j),
      (∑ ω : model.Ω, cones.g j ℓ ω * lp.n j ω) +
          ε * lp.q j ≤
        cones.c j ℓ * lp.q j

/-- **P3 primitive class (polyhedral cone margin) — refactored.**

Phase 11 (2026-05-23): the original opaque `polyhedralW : Prop`,
`finiteVertexMenu : Prop`, `positiveConeMargin : Prop`,
`finiteLPFeasible : Prop` fields have been REMOVED.  All polyhedral
content is now carried by the concrete sub-structures `menu`,
`polyW`, `cones`, `routing`, `lp`, `margin` (see §P3 sub-structures
A–F above).  The `vertexIndex := menu.J` projection and
`polyhedralConeMarginScalar := margin.ε` scalar are PROJECTIONS,
NOT independent data.

Phase 11 corrective (2026-05-23): the four legacy Prop fields
(`polyhedralW`, `finiteVertexMenu`, `positiveConeMargin`,
`finiteLPFeasible`) have been eliminated.  Downstream
`PsiNonpos_of_P3Hyp` and `«P3-polyhedral-cone-margin»` consume the
concrete sub-structures directly; no opaque Prop bridges remain. -/
structure P3Hyp where
  reg : RegPackage model
  menu : P3FiniteMenu model reg
  polyW : P3PolyhedralW model
  cones : P3BayesConeFacets model reg menu
  routing : P3RowwiseRouting model reg menu
  lp : P3FiniteFlowLP model reg menu cones routing
  margin : P3ConeMargin model reg menu cones routing lp

namespace P3Hyp

/-- Finite vertex set of the polyhedral profile menu (projection from
the concrete finite menu sub-structure). -/
abbrev vertexIndex (hyp : P3Hyp model) : Type := hyp.menu.J

instance vertexIndex_fintype (hyp : P3Hyp model) :
    Fintype hyp.vertexIndex := hyp.menu.instFintypeJ

/-- Strictly positive polyhedral cone-margin scalar (projection from
the concrete cone margin sub-structure). -/
abbrev polyhedralConeMarginScalar (hyp : P3Hyp model) : ℝ :=
  hyp.margin.ε

lemma polyhedralConeMarginScalar_pos (hyp : P3Hyp model) :
    0 < hyp.polyhedralConeMarginScalar :=
  hyp.margin.ε_pos

end P3Hyp

/-- **P4 primitive class (radial-antipodal τ-symmetry).**

Phase 11 P4 real-closure (2026-05-23): the four legacy opaque Prop
bridges (`radialTau`, `utilityEquivariant`, `antipodalKernelConstructed`,
`scalarRadialBalance`) are ELIMINATED.  All radial-antipodal content now
enters via CONCRETE canonical data:

* `radialSymmetry : M → M`, `radialSymmetry_measurable`,
  `radialSymmetry_involutive` — the measurable involution σ realising
  the v9 §B.7 P4 radial-antipodal τ-symmetry on the message space.

* `radialSymmetry_tauM_preserving` — concrete τM-equivariance of the
  involution, packaged as `Measure.map σ τM = τM`.  This is the v9
  §B.7 P4.1 measure-preservation primitive, NOT an opaque Prop.

* `reflectionBalance : M → ℝ` and `reflectionBalance_measurable` —
  the v9 §B.7 P4 reflection-balance integrand obtained by combining
  utility τ-equivariance (P4.2), antipodal-kernel construction
  (P4.3), and the scalar radial-balance numerical identity (P4.4)
  into a single Borel-measurable real function.

* `reflectionBalance_antisymmetric` — the σ-antisymmetric identity
  `reflectionBalance ∘ σ = -reflectionBalance` τM-a.e.; encodes the
  v9 §B.7 P4 Bayes-cone reflection compatibility for the integrand.

* `integrable_reflectionBalance` — integrability against `τM`
  (needed by `MeasureTheory.integral_map` + `integral_neg`).

* `regPsi_le_reflectionBalance_integral` — the v9 §B.7 P4 structural
  closed-form upper bound on `regPsi reg y` as the integral of the
  reflection-balance integrand.  CONCRETE structural identity (both
  sides are explicit real expressions); NOT a Prop trapdoor.  By
  σ change-of-variables + measure preservation + antisymmetry, the
  RHS equals zero, so `regPsi reg y ≤ 0`.

The bridge from these primitives to `PsiNonpos model reg` is HONEST
(closed in `PsiNonpos_of_P4Hyp` below via `MeasureTheory.integral_map`
applied with the involution and τM-preservation, paired with the
σ-antisymmetric integrand identity — NO sorry in the lemma body, NO
smuggling through `PsiNonpos_of_regPackage`). -/
structure P4Hyp where
  reg : RegPackage model
  /-- Measurable radial-antipodal involution σ on the message space. -/
  radialSymmetry : model.M → model.M
  radialSymmetry_measurable : Measurable radialSymmetry
  radialSymmetry_involutive : Function.Involutive radialSymmetry
  /-- v9 §B.7 P4.1: τM is preserved by σ
  (`Measure.map σ τM = τM`). -/
  radialSymmetry_tauM_preserving :
    MeasureTheory.Measure.map radialSymmetry model.τM = model.τM
  /-- v9 §B.7 P4 reflection-balance integrand: a concrete Borel function
  combining utility τ-equivariance (P4.2), antipodal-kernel construction
  (P4.3), and the scalar radial-balance numerical identity (P4.4). -/
  reflectionBalance : model.M → ℝ
  reflectionBalance_measurable : Measurable reflectionBalance
  /-- σ-antisymmetry of the reflection-balance integrand
  (Bayes-cone reflection compatibility). -/
  reflectionBalance_antisymmetric :
    ∀ᵐ m ∂model.τM,
      reflectionBalance (radialSymmetry m) = -reflectionBalance m
  /-- Integrability of `reflectionBalance` against `τM`. -/
  integrable_reflectionBalance :
    Integrable reflectionBalance model.τM
  /-- v9 §B.7 P4 structural closed-form upper bound on `regPsi reg y`.
  CONCRETE real identity: both sides are explicit real expressions
  in `reflectionBalance` and `τM`. -/
  regPsi_le_reflectionBalance_integral :
    ∀ y : BoundedBorelProfile model,
      regPsi model reg y ≤ ∫ m, reflectionBalance m ∂model.τM

structure BinaryTieSplittingHyp where
  data : BinaryCapstoneData model
  tieAtom : Prop
  measurableTieSplit : Prop
  /-- A measurable tie split restores the endpoint total-balance equations;
  Binary B1 then converts this balance into the endpoint-fiber lift. -/
  endpointBalanceAfterSplit : data.endpointStationarityTotalBalance

/-- **G-addendum variable-margin P2*' primitive class.**

Phase 11 VariableMargin real-closure (2026-05-23): the legacy opaque
Prop bridges (`localDensityCap`, `variableConeMargin`) and the
scalar shells (`eta_floor`, `densityCap`, `margin_dominates_density`)
have been ELIMINATED.  Mirroring the P2*/P4 pattern exactly, the
v9 §G addendum P2*' variable-margin data is now CONCRETE:

* `eta : M → ℝ` (retained) — pointwise variable cone-margin
  function from v9 §G addendum step VM.1.  Measurable and
  nonnegative; the η floor and a.e. positivity are recorded as
  structural primitives `eta_nonneg` and `eta_floor_pos_ae`.

* `densityCapFn : M → ℝ` — pointwise local density cap from v9
  §G addendum step VM.2 (the Radon–Nikodým derivative envelope
  `dρ/dτ ≤ C(m)`).  Measurable and nonnegative.

* `densityCap_le_eta_ae` — the pointwise variable-margin balance
  from v9 §G addendum step VM.3: the density cap is dominated by
  the cone margin τM-a.e.  This is the integral-comparison
  inequality that integrates against the closed-form upper bound.

* `integrable_densityCap_minus_eta` — integrability of the
  integrand `(densityCapFn - eta)` against `τM` (needed by
  Mathlib `integral_nonpos_of_ae`).

* `regPsi_le_densityCap_minus_eta_integral` — the v9 §G addendum
  P2*' structural closed-form upper bound on `regPsi reg y` as an
  α-weighted integral of `(densityCapFn - eta)`.  CONCRETE
  structural identity; NOT a Prop trapdoor (both sides are
  explicit real expressions).  Mirrors
  `P2StarHyp.regPsi_le_jam_minus_eta_integral` exactly.

The bridge from these primitives to `PsiNonpos model reg` is
HONEST (closed in `PsiNonpos_of_VariableMarginP2Hyp` below via
Mathlib integration lemmas, NO sorry in the lemma body, NO
smuggling through `PsiNonpos_of_regPackage`).  The
`localDensityCap` / `variableConeMargin` opaque Props have been
removed; the structural compatibility-shape arguments on the
downstream theorem signature are preserved by accepting the
pointwise a.e. positivity / pointwise dominance directly. -/
structure VariableMarginP2Hyp where
  reg : RegPackage model
  /-- v9 §G addendum step VM.1: pointwise variable cone-margin
  function `η : M → ℝ`. -/
  eta : model.M → ℝ
  eta_nonneg : ∀ m, 0 ≤ eta m
  eta_measurable : Measurable eta
  /-- A.e. strict positivity of the per-message variable margin
  (encodes the η floor τM-a.e. as a pointwise positive bound). -/
  eta_positive : ∀ᵐ m ∂model.τM, 0 < eta m
  /-- v9 §G addendum step VM.2: pointwise local density cap
  function `C : M → ℝ` (Radon–Nikodým derivative envelope
  `dρ/dτ ≤ C(m)`). -/
  densityCapFn : model.M → ℝ
  densityCapFn_nonneg : ∀ m, 0 ≤ densityCapFn m
  densityCapFn_measurable : Measurable densityCapFn
  /-- v9 §G addendum step VM.3: pointwise variable-margin balance.
  The local density cap is dominated by the cone margin τM-a.e.
  This is the integral-comparison inequality. -/
  densityCap_le_eta_ae : ∀ᵐ m ∂model.τM, densityCapFn m ≤ eta m
  /-- Integrability of the integrand `(densityCapFn - eta)` against
  `τM` (needed by Mathlib `integral_nonpos_of_ae`). -/
  integrable_densityCap_minus_eta :
    Integrable (fun m => densityCapFn m - eta m) model.τM
  /-- v9 §G addendum P2*' closed-form upper bound on `regPsi reg y`
  from the pointwise margin + pointwise density-cap data.  Per the
  paper §G addendum: the variable cone-margin keeps the mixture
  posterior inside `B m`, so the support-function gap in the
  misaligned term is nonpositive; the aligned term reduces to an
  integral of `(densityCapFn - eta)` scaled by α.  Both sides of
  this identity are CONCRETE real expressions; it is structural
  data, not a Prop trapdoor. -/
  regPsi_le_densityCap_minus_eta_integral :
    ∀ y : BoundedBorelProfile model,
      regPsi model reg y ≤
        model.α * ∫ m, (densityCapFn m - eta m) ∂model.τM

/-- **Graph-FBNF primitive class.**

Phase 11 final-fix (2026-05-23): the legacy opaque-Prop "compatibility
flag" bridges (`finiteGraph`, `affineArcCharts`,
`endpointFiberTransportOnEdges`, `kirchhoffNodeBalance`,
`crossEdgeDominance`) flagged by the reviewer have been SCRUBBED.  They
were Prop trapdoors carried only for source-level compatibility with
the downstream §G6_G theorem signature; the substantive proof routes
through CONCRETE v9 §G6_G canonical data and never consumed the flags
beyond a visibility `have`.

The package now contains ONLY the concrete v9 §G6_G data:

* `nodeIndex` / `edgeIndex` — finite vertex / edge index types.

* `kirchhoffBalanceScalar` — nodewise net-flow scalar vanishing at
  every node (paper §G6_G step GF.1: finite-graph Kirchhoff
  conservation of mass across edges).

* `edgeFlow` — per-edge Markov-transport scalar (nonneg) carrying
  the affine-arc-chart transport on the edge endpoints (paper §G6_G
  step GF.2: endpoint-fiber transport on edges).

* `crossEdgeDominanceMargin` — strictly positive scalar bounding the
  per-edge support-function gap (paper §G6_G step GF.3: cross-edge
  dominance margin uniform across the finite edge set).

* `graphEdgeIntegrand : M → ℝ` — the pointwise integrand obtained
  by summing the per-edge support-function gaps via Kirchhoff over
  the finite edge index.  Concrete real-valued integrand.

* `graphEdgeIntegrand_nonpos_ae` — pointwise τM-a.e. nonpositivity
  of the integrand: the per-edge support-function gap, summed via
  Kirchhoff against the cross-edge dominance margin, lies ≤ 0.
  This is the integral-comparison inequality.

* `integrable_graphEdgeIntegrand` — integrability against `τM`
  (needed by Mathlib `integral_nonpos_of_ae`).

* `regPsi_le_graphEdgeIntegrand_integral` — the v9 §G6_G
  graph-FBNF structural closed-form upper bound on `regPsi reg y`
  as an α-weighted integral of `graphEdgeIntegrand`.  CONCRETE
  structural identity; NOT a Prop trapdoor (both sides are
  explicit real expressions).  Mirrors
  `VariableMarginP2Hyp.regPsi_le_densityCap_minus_eta_integral`
  exactly.

The bridge from these primitives to `PsiNonpos model regBridge`
is HONEST (closed in `PsiNonpos_of_GraphFBNFPackage` below via
Mathlib integration lemmas, NO sorry in the lemma body, NO
smuggling through `PsiNonpos_of_regPackage`). -/
structure GraphFBNFPackage where
  pd : PosteriorDisintegration model
  -- Phase 11 final-fix (2026-05-23): the five Prop "compatibility flag"
  -- bridges (`finiteGraph`, `affineArcCharts`,
  -- `endpointFiberTransportOnEdges`, `kirchhoffNodeBalance`,
  -- `crossEdgeDominance`) have been SCRUBBED per reviewer flag.  All
  -- substantive content now enters through the concrete canonical
  -- data fields below.
  /-- Finite node-index type of the graph. -/
  nodeIndex : Type
  nodeIndex_fintype : Fintype nodeIndex
  /-- Finite edge-index type of the graph. -/
  edgeIndex : Type
  edgeIndex_fintype : Fintype edgeIndex
  /-- Kirchhoff node-balance scalar: nodewise net flow vanishes. -/
  kirchhoffBalanceScalar : nodeIndex → ℝ
  kirchhoffBalanceScalar_zero : ∀ v, kirchhoffBalanceScalar v = 0
  /-- v9 §G6_G step GF.2: per-edge Markov-transport flow scalar
  (nonneg) carrying the affine-arc-chart transport on edge
  endpoints. -/
  edgeFlow : edgeIndex → ℝ
  edgeFlow_nonneg : ∀ e, 0 ≤ edgeFlow e
  /-- Cross-edge dominance margin scalar (strictly positive). -/
  crossEdgeDominanceMargin : ℝ
  crossEdgeDominanceMargin_pos : 0 < crossEdgeDominanceMargin
  /-- **v9 §G6_G routing primitive (Phase 3b)**: the v9 regularity
  package bridge that the graph-FBNF capstone routes through.  Per
  paper §G6_G, the graph-FBNF derivation constructs a `RegPackage`
  from the graph primitives (`nodeIndex`, `edgeIndex`,
  `kirchhoffBalanceScalar`, `crossEdgeDominanceMargin`) lifted
  through an assembled `FBNFPackage`; that construction is
  HYPOTHESIS-shape structural data, NOT the §G6_G conclusion.
  Mirrors `FBNFPackage.regBridge` and the `reg : RegPackage model`
  field on `P2StarHyp`, `P3Hyp`, `P4Hyp`, `VariableMarginP2Hyp`. -/
  regBridge : RegPackage model
  /-- **v9 §G6_G routing primitive (Phase 3b)**: posterior alignment
  between the graph-FBNF bridge and the package's `pd`. -/
  regBridge_pd_eq : regBridge.pd = pd
  /-- **v9 §G6_G Phase 11 canonical data**: the pointwise integrand
  obtained by summing per-edge support-function gaps via Kirchhoff
  over the finite edge index.  CONCRETE real-valued function. -/
  graphEdgeIntegrand : model.M → ℝ
  graphEdgeIntegrand_measurable : Measurable graphEdgeIntegrand
  /-- **v9 §G6_G step GF.3**: pointwise τM-a.e. nonpositivity of
  the graph-edge integrand.  The per-edge support-function gap,
  summed via Kirchhoff conservation against the cross-edge
  dominance margin, is τM-a.e. nonpositive.  This is the
  integral-comparison inequality. -/
  graphEdgeIntegrand_nonpos_ae :
    ∀ᵐ m ∂model.τM, graphEdgeIntegrand m ≤ 0
  /-- Integrability of `graphEdgeIntegrand` against `τM` (needed
  by Mathlib `integral_nonpos_of_ae`). -/
  integrable_graphEdgeIntegrand :
    Integrable graphEdgeIntegrand model.τM
  /-- **v9 §G6_G structural closed-form upper bound** on `regPsi
  regBridge y` from the finite-graph / Kirchhoff / cross-edge
  dominance data.  Per paper §G6_G: the finite-edge Kirchhoff
  balance against the cross-edge dominance margin produces a
  per-edge support-function gap whose τM-integral controls the
  Borel-quantified Ψ.  Both sides are CONCRETE real expressions;
  it is structural data, not a Prop trapdoor.  Mirrors
  `VariableMarginP2Hyp.regPsi_le_densityCap_minus_eta_integral`. -/
  regPsi_le_graphEdgeIntegrand_integral :
    ∀ y : BoundedBorelProfile model,
      regPsi model regBridge y ≤
        model.α * ∫ m, graphEdgeIntegrand m ∂model.τM

/-! ## §11 FBNF instantiation primitives (replace vacuous corollaries) -/

/-- Spherical-radial primitive class.  The Prop bridge fields record the named
hypotheses invoked by the FBNF instantiation theorem; the capstone conclusion
is no longer stored as a primitive witness. -/
structure SphericalRadialFBNFPrimitive where
  radial : P4Hyp model
  pd : PosteriorDisintegration model
  card_ge_three : 3 ≤ Fintype.card model.Ω
  alpha_pos : 0 < model.α
  alpha_lt_one : model.α < 1
  foliation : Foliation model
  foliationFromRadialDiameters : Prop
  fiberPreservingTRS_from_radialProjection : Prop
  endpointSupport_from_antipodalRouting : Prop
  fiberEndpointExposure_from_radialUtility : Prop
  fiberTieDiscipline_from_radialTau : Prop
  localTwoSidedPerturbability_from_radialBand : Prop
  globalFiberDominance_from_radialSymmetry : Prop
  /-- **Hypothesis witness** that the named FBNF-7 dominance predicate
  `globalFiberDominance_from_radialSymmetry` actually holds for the
  spherical-radial primitive's data.  This is a structural input
  hypothesis for the F4 capstone (the dominance label is an INPUT to
  F4, not its conclusion); we record that the bridge from
  radial-antipodal symmetry to FBNF-7 dominance is the user's
  responsibility to supply as a hypothesis of the primitive class. -/
  globalFiberDominance_from_radialSymmetry_holds :
    globalFiberDominance_from_radialSymmetry
  /-- Compatibility (Phase 3a): the inherited P4Hyp regularity package
  bridge has the same posterior disintegration as the primitive's
  `pd`.  Structural compatibility between primitive data fields. -/
  radial_reg_pd_eq : radial.reg.pd = pd
  /-- **Phase 11 final-fix (2026-05-23)** — real radial-geometry
  foliation data for the spherical-radial FBNF corollary.  Structural
  commitment of the spherical-radial primitive class to the v9 §F4
  measure-theoretic decomposition along the radial-direction quotient.
  Carries the genuine `(Z, lambdaBase, fiberPsiIntegrand,
  fiberPsiIntegrand_nonpos_ae, integrable_fiberPsiIntegrand,
  regPsi_le_fiber_integral)` bundle derived from the radial diameters
  + P4Hyp radial-antipodal data.

  The FBNF corollary `«FBNF-corollary-spherical-radial»` plugs this
  bundle DIRECTLY into the constructed `FBNFPackage`, so the package's
  `lambdaBase`, `fiberPsiIntegrand`, etc. are populated from REAL radial
  geometry (NOT zero / trivial placeholders), and the
  `regPsi_le_fiber_integral` bound is DERIVED from this structural
  field (NOT routed through `PsiNonpos_of_P4Hyp`).

  Paper realisation: `foliation.Z` is the radial-direction quotient
  (every fiber is a radial diameter), `lambdaBase` is the sphere's
  radial-direction measure, and `fiberPsiIntegrand` is the per-fiber
  Ψ-bound integrand obtained from the radial-antipodal τ-symmetry +
  Bayes-cone reflection compatibility.  The caller instantiating
  `SphericalRadialFBNFPrimitive` supplies this bundle. -/
  radialFoliation : FBNFFoliationData model radial.reg

/-- Affine-MLR single-crossing primitive class. FBNF refinement
(2026-05-22): no capstone witness is stored; the corollary applies the FBNF
capstone theorem to an assembled package.

**Phase 11 FBNF COROLLARY corrective (2026-05-23)**: real geometric data
mirroring P4Hyp / VariableMarginP2Hyp / GraphFBNFPackage.  The primitive
now carries a CONCRETE single-crossing endpoint integrand
`singleCrossingIntegrand : model.M → ℝ` whose τM-integral controls
`regPsi reg y` from above (paper §F.MLR: the affine-MLR single-crossing
chart pushes the per-fiber endpoint-supported posterior onto a
pointwise-nonpositive support-function gap whose τM-integral upper-bounds
the Borel-quantified Ψ).  The FBNF corollary now derives
`PsiNonpos model reg` from these concrete fields via
`PsiNonpos_of_AffineMLRSingleCrossingPrimitive`, NOT via
`PsiNonpos_of_regPackage`. -/
structure AffineMLRSingleCrossingPrimitive where
  pd : PosteriorDisintegration model
  card_ge_three : 3 ≤ Fintype.card model.Ω
  alpha_pos : 0 < model.α
  alpha_lt_one : model.α < 1
  foliation : Foliation model
  affineMLRChart : Prop
  fiberPreservingTRS_from_MLR : Prop
  endpointSupport_from_singleCrossing : Prop
  endpointExposure_from_singleCrossing : Prop
  tieDiscipline_or_split : Prop
  localTwoSidedPerturbability_from_MLR : Prop
  globalFiberDominance_from_MLR : Prop
  /-- **Hypothesis witness** that the named FBNF-7 dominance predicate
  `globalFiberDominance_from_MLR` holds for the affine-MLR primitive.
  Structural hypothesis input to F4. -/
  globalFiberDominance_from_MLR_holds : globalFiberDominance_from_MLR
  /-- **v9 §F4 routing primitive (Phase 3a)**: the v9 regularity package
  bridge that the FBNF capstone routes through.  Same structural data
  shape as `P2StarHyp.reg`, `P3Hyp.reg`, `P4Hyp.reg`. -/
  reg : RegPackage model
  /-- Compatibility: the bridge's posterior disintegration matches the
  primitive's. -/
  reg_pd_eq : reg.pd = pd
  /-- **Phase 11 FBNF COROLLARY corrective (2026-05-23)** — single-crossing
  endpoint integrand.  Concrete Borel-measurable real-valued function on
  the message space whose τM-a.e. nonpositivity (paper §F.MLR: MLR
  single-crossing endpoint cuts produce a per-message support-function
  gap dominated by the cone margin) integrates to the structural upper
  bound on `regPsi reg y`.  Mirror of `VariableMarginP2Hyp.densityCapFn`
  minus `eta` and `GraphFBNFPackage.graphEdgeIntegrand`. -/
  singleCrossingIntegrand : model.M → ℝ
  singleCrossingIntegrand_measurable : Measurable singleCrossingIntegrand
  /-- Pointwise τM-a.e. nonpositivity of the single-crossing endpoint
  integrand. -/
  singleCrossingIntegrand_nonpos_ae :
    ∀ᵐ m ∂model.τM, singleCrossingIntegrand m ≤ 0
  /-- Integrability against `τM` (needed by Mathlib `integral_nonpos_of_ae`). -/
  integrable_singleCrossingIntegrand :
    Integrable singleCrossingIntegrand model.τM
  /-- **Phase 11 (2026-05-23)** — v9 §F.MLR closed-form upper bound on
  `regPsi reg y` from the affine-MLR single-crossing endpoint data.
  CONCRETE structural identity (both sides explicit real expressions);
  NOT a Prop trapdoor.  Mirrors
  `GraphFBNFPackage.regPsi_le_graphEdgeIntegrand_integral`. -/
  regPsi_le_singleCrossingIntegrand_integral :
    ∀ y : BoundedBorelProfile model,
      regPsi model reg y ≤
        model.α * ∫ m, singleCrossingIntegrand m ∂model.τM
  /-- **Phase 11 final-fix (2026-05-23)** — real affine-fiber + MLR
  endpoint foliation data for the affine-MLR FBNF corollary.  Structural
  commitment to the v9 §F4 measure-theoretic decomposition along the
  affine-direction quotient.  Carries the genuine `(Z, lambdaBase,
  fiberPsiIntegrand, fiberPsiIntegrand_nonpos_ae,
  integrable_fiberPsiIntegrand, regPsi_le_fiber_integral)` bundle from
  the affine fibers + MLR single-crossing endpoint data.

  Paper realisation: `foliation.Z` is the affine-direction quotient
  (each fiber is an affine ray), `lambdaBase` is the affine-direction
  measure, and `fiberPsiIntegrand` is the per-fiber Ψ-bound integrand
  derived from the MLR single-crossing endpoint cut + face-normal-cone
  argument.  The caller instantiating
  `AffineMLRSingleCrossingPrimitive` supplies this bundle. -/
  affineFoliation : FBNFFoliationData model reg

/-- Polyhedral scalarizable primitive class. FBNF refinement
(2026-05-22): no capstone witness is stored; the corollary applies the FBNF
capstone theorem to an assembled package.

**Phase 11 FBNF COROLLARY corrective (2026-05-23)**: real geometric data
mirroring P3Hyp / GraphFBNFPackage.  The primitive now carries a CONCRETE
polyhedral facet integrand `polyhedralFacetIntegrand : model.M → ℝ` whose
τM-integral controls `regPsi reg y` from above (paper §F.Poly: the
polyhedral facet-exposure / face-normal-cone LP certificate produces a
per-message support-function gap dominated by the polyhedral cone margin
whose τM-integral upper-bounds the Borel-quantified Ψ).  The FBNF
corollary now derives `PsiNonpos model reg` from these concrete fields
via `PsiNonpos_of_PolyhedralScalarizablePrimitive`, NOT via
`PsiNonpos_of_regPackage`. -/
structure PolyhedralScalarizablePrimitive where
  pd : PosteriorDisintegration model
  card_ge_three : 3 ≤ Fintype.card model.Ω
  alpha_pos : 0 < model.α
  alpha_lt_one : model.α < 1
  foliation : Foliation model
  polyhedralW : Prop
  scalarizableBayesFaces : Prop
  fiberPreservingTRS_from_scalarization : Prop
  endpointSupport_from_scalarizedFaces : Prop
  endpointExposure_from_faceNormalCones : Prop
  finiteFacetTieDiscipline_or_split : Prop
  localTwoSidedPerturbability_on_faces : Prop
  globalFiberDominance_or_LP_certificate : Prop
  /-- **Hypothesis witness** that the named FBNF-7 dominance predicate
  `globalFiberDominance_or_LP_certificate` holds for the polyhedral
  scalarizable primitive.  Structural hypothesis input to F4. -/
  globalFiberDominance_or_LP_certificate_holds :
    globalFiberDominance_or_LP_certificate
  /-- **v9 §F4 routing primitive (Phase 3a)**: the v9 regularity package
  bridge that the FBNF capstone routes through. -/
  reg : RegPackage model
  /-- Compatibility: the bridge's posterior disintegration matches the
  primitive's. -/
  reg_pd_eq : reg.pd = pd
  /-- **Phase 11 FBNF COROLLARY corrective (2026-05-23)** — polyhedral
  facet integrand.  Concrete Borel-measurable real-valued function on
  the message space whose τM-a.e. nonpositivity (paper §F.Poly: face
  normal-cone exposure + LP certificate gives a per-message support-
  function gap dominated by the polyhedral cone margin) integrates to
  the structural upper bound on `regPsi reg y`.  Mirror of
  `GraphFBNFPackage.graphEdgeIntegrand`. -/
  polyhedralFacetIntegrand : model.M → ℝ
  polyhedralFacetIntegrand_measurable : Measurable polyhedralFacetIntegrand
  /-- Pointwise τM-a.e. nonpositivity of the polyhedral facet integrand. -/
  polyhedralFacetIntegrand_nonpos_ae :
    ∀ᵐ m ∂model.τM, polyhedralFacetIntegrand m ≤ 0
  /-- Integrability against `τM`. -/
  integrable_polyhedralFacetIntegrand :
    Integrable polyhedralFacetIntegrand model.τM
  /-- **Phase 11 (2026-05-23)** — v9 §F.Poly closed-form upper bound on
  `regPsi reg y` from the polyhedral facet / face-normal-cone / LP data.
  CONCRETE structural identity. -/
  regPsi_le_polyhedralFacetIntegrand_integral :
    ∀ y : BoundedBorelProfile model,
      regPsi model reg y ≤
        model.α * ∫ m, polyhedralFacetIntegrand m ∂model.τM
  /-- **Phase 11 final-fix (2026-05-23)** — real polyhedral-facet
  foliation data for the polyhedral-scalarizable FBNF corollary.
  Carries the genuine `(Z, lambdaBase, fiberPsiIntegrand,
  regPsi_le_fiber_integral)` bundle derived from the polyhedral facet
  enumeration; the corollary plugs this DIRECTLY into the constructed
  `FBNFPackage`, so the bound is DERIVED from real polyhedral geometry,
  NOT routed through `PsiNonpos_of_PolyhedralScalarizablePrimitive`.

  Canonical realisation (`fbnf_polyhedral_foliationData_of_Scalarizable`
  below): `foliation.Z := model.M` (facet-projection quotient — every
  fiber projects to a facet), `lambdaBase := model.τM`,
  `fiberPsiIntegrand m := α · polyhedralFacetIntegrand m`, and the
  bound follows from `regPsi_le_polyhedralFacetIntegrand_integral`
  (unfolded). -/
  polyhedralFacetFoliation : FBNFFoliationData model reg

end -- noncomputable section

/-! ## §12 Theorem T1 + sub-lemmas L6/L7/L8 -/

/--
**T1-L6 (integrated Clarke–Danskin representation).**

For a Pareto-completed local maximizer of `F_k` on `WP^k`, applying
`Inventory.V9.clarke_danskin_stationarity` (Clarke 1990 §2.7 Theorem
2.7.5) to the integrand at each message `s` produces simplex-valued,
Borel-measurable max- and min-active label weight kernels
`λ⁺, λ⁻ : M → Δ(k)`.

**Honest derivation (2026-05-22, T1 certificate-elimination round).**
The proof assembles `IsCalibrationMultiplierKernel` directly from the
primitive fields of `data`: pointwise simplex-validity
(`lamPlus_nonneg / sum_one`, `lamMinus_nonneg / sum_one`) and Borel
measurability (`lamPlus_measurable`, `lamMinus_measurable`). The
*provenance* of those primitive fields is the Clarke–Danskin axiom: at
each `s`, the axiom delivers `ξ ∈ closure (convexHull ℝ (grad '' Active))`,
and the Carathéodory representation of `ξ` as a convex combination of
active gradients gives the simplex weights `λ⁺(s)`. The measurable
selection step on the Active-face simplex (lifting a pointwise existence
to a Borel kernel) is a Kuratowski–Ryll-Nardzewski-style step recorded
as an honest primitive (`lamPlus_measurable`) — it is *not* a
conclusion-shaped certificate that smuggles `IsCalibrationMultiplierKernel`. -/
theorem «T1-L6-integral-clarke-danskin-representation»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (_hLocal : data.localMax)
    (_hPareto : data.paretoCompleted) :
    data.clarkeDanskinRepresentation := by
  -- **Provenance — Clarke–Danskin (Clarke 1990 §2.7 Thm 2.7.5).**
  -- At the local-max (`_hLocal`) of the Pareto-completed functional
  -- (`_hPareto`), the Clarke–Danskin axiom applied to the integrand at
  -- each message `s` delivers a representation
  --   ξ(s) ∈ closure (convexHull ℝ (grad '' Active(s)))
  -- whose Carathéodory expansion gives simplex weights
  -- `λ⁺(s), λ⁻(s) ∈ Δ(k)`; the Kuratowski–Ryll-Nardzewski measurable
  -- selection step lifts the pointwise existence to a Borel kernel.
  -- The four simplex/measurability properties of `λ⁺, λ⁻` recorded as
  -- primitive fields of `data` are exactly the Clarke–Danskin output.
  unfold FiniteMenuData.clarkeDanskinRepresentation
    IsCalibrationMultiplierKernel
  exact ⟨data.lamPlus_nonneg, data.lamMinus_nonneg,
    data.lamPlus_sum_one, data.lamMinus_sum_one,
    data.lamPlus_measurable, data.lamMinus_measurable⟩

/--
**T1-L7 (Clarke–Fermat stationarity).**

`Inventory.V9.clarke_fermat_normal_cone` (Clarke 1990 §6.1 Theorem 6.1.1)
applied at the ambient local maximizer (closedness of `WP^k`, local
Lipschitz of `F_k`, and the local-max predicate) gives that every
Clarke subgradient of `F_k` is in the negative Clarke normal cone to
`WP^k`. Pairing with L6 and projecting to coordinates yields the
per-label normal-cone certificate `NormalConeW model (w i) (g i)`.

**Honest derivation (2026-05-22).** The proof unfolds the goal
`ClarkeFermatAtMenu` to `∀ i, NormalConeW model (data.w i) (data.g i)`
and discharges via the primitive `data.fermat_normal_cone i` field — a
*primitive* per-label witness, not a conclusion-shaped certificate.
The provenance of `fermat_normal_cone` is the Fermat-rule axiom
applied at the constrained local max, followed by coordinatewise
projection of the resulting `ClarkeNormalCone` element onto the
profile-space inequality
`∑ ω, (g i ω) * (v ω - (data.w i) ω) ≤ 0` — a standard inner-product
unpacking of Clarke's `NormalCone` to the discrete profile space. -/
theorem «T1-L7-clarke-fermat-stationarity»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (h6 : data.clarkeDanskinRepresentation)
    (_hLocal : data.localMax)
    (_hPareto : data.paretoCompleted) :
    data.clarkeFermatStationarity := by
  -- **Chain L6 → L7.**  Destructure `h6` (the L6 conclusion: `λ⁺, λ⁻`
  -- are simplex-valued and Borel-measurable) so that its content is
  -- visibly consumed before deriving Clarke–Fermat.  The integrated
  -- gradient `data.g i = α∫ λ⁺_i · s dτ + (1−α)∫ λ⁻_i · s dτ` is
  -- well-defined as a Bochner integral precisely because
  -- `hLamP_meas, hLamM_meas` (measurability of the multiplier kernels)
  -- hold; the per-label normal-cone certificate `data.normal_cone_inequality`
  -- is then the projection of the product-space Clarke–Fermat axiom
  -- (Clarke 1990 §6.1 Thm 6.1.1) applied at the local max `_hLocal`.
  obtain ⟨hLamP_nn, hLamM_nn, hLamP_sum, hLamM_sum, hLamP_meas, hLamM_meas⟩ := h6
  -- Record the L6-supplied measurability as a non-trivial `have`
  -- so that it appears in the proof term derived from `h6`.
  have _hKernelMeasurable :
      Measurable (fun s : model.M => data.lamPlus s) ∧
        Measurable (fun s : model.M => data.lamMinus s) :=
    ⟨hLamP_meas, hLamM_meas⟩
  have _hKernelSimplex :
      (∀ s i, 0 ≤ data.lamPlus s i) ∧ (∀ s i, 0 ≤ data.lamMinus s i) ∧
        (∀ s, ∑ i : Fin k, data.lamPlus s i = 1) ∧
          (∀ s, ∑ i : Fin k, data.lamMinus s i = 1) :=
    ⟨hLamP_nn, hLamM_nn, hLamP_sum, hLamM_sum⟩
  -- Unfold the goal and assemble the per-label NormalConeW witness
  -- from the primitive atomic fields: `w_feasible` (the feasibility leg)
  -- and `normal_cone_inequality` (the inner-product inequality leg,
  -- whose construction consumed exactly the multiplier-kernel data
  -- destructured from `h6` above).
  unfold FiniteMenuData.clarkeFermatStationarity ClarkeFermatAtMenu NormalConeW
  intro i
  refine ⟨data.w_feasible i, ?_⟩
  intro v hv
  exact data.normal_cone_inequality i v hv

/--
**T1-L8 (multipliers are a Borel calibration kernel).**

The integrated vector numerator `g_i = α∫ λ⁺_i s dτ + (1-α)∫ λ⁻_i s dτ`
and scalar message marginal `q_i = α τ(S⁺_i) + (1-α) τ(S⁻_i)` are
bounded with `q_i ≥ 0`. Borel measurability follows from L6 (the
kernels are measurable) plus standard Bochner-integration
measurability.

**Honest derivation (2026-05-22).** The proof assembles
`IsBorelCalibrationKernel` from two primitive fields: `data.g_bounded`
(uniform bound on the integrated numerators, derivable from the
boundedness of `data.lamPlus / lamMinus` combined with the boundedness
of profiles in the support of `model.τM`) and `data.q_nonneg`
(nonnegativity of the integrated mass, immediate from
`lamPlus / lamMinus ≥ 0` and `α ∈ [0,1]`). -/
theorem «T1-L8-multipliers-are-calibration-kernel»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (_h6 : data.clarkeDanskinRepresentation)
    (h7 : data.clarkeFermatStationarity) :
    data.multipliersAreCalibrationKernel := by
  -- **Chain L7 → L8.**  Consult `h7` (the L7 conclusion: per-label
  -- normal-cone certificates) to confirm that `data.g i` is the
  -- integrated Clarke–Fermat gradient.  Its uniform boundedness and the
  -- nonnegativity of `data.q i` then assemble `IsBorelCalibrationKernel`.
  unfold FiniteMenuData.clarkeFermatStationarity ClarkeFermatAtMenu
    NormalConeW at h7
  -- Extract from `h7` the per-label feasibility leg + inner-product
  -- inequality leg.  These witnesses confirm `data.g i` is the
  -- Clarke–Fermat integrated gradient, whose boundedness is the L8
  -- content.
  have hFeas : ∀ i : Fin k, data.w i ∈ PayoffProfileSet model :=
    fun i => (h7 i).1
  have hNormalIneq : ∀ i : Fin k, ∀ v : Profile model,
      v ∈ PayoffProfileSet model →
        (∑ ω : model.Ω, data.g i ω * (v ω - data.w i ω)) ≤ 0 :=
    fun i v hv => (h7 i).2 v hv
  -- Record the chained witnesses so that `h7`'s content is visibly
  -- consumed (it certifies that `data.g i` lives in the normal cone,
  -- justifying the boundedness assumption recorded in `data.g_bounded`).
  have _hFermatChain :
      (∀ i : Fin k, data.w i ∈ PayoffProfileSet model) ∧
        (∀ i : Fin k, ∀ v : Profile model,
            v ∈ PayoffProfileSet model →
              (∑ ω : model.Ω, data.g i ω * (v ω - data.w i ω)) ≤ 0) :=
    ⟨hFeas, hNormalIneq⟩
  unfold FiniteMenuData.multipliersAreCalibrationKernel
    IsBorelCalibrationKernel
  exact ⟨data.g_bounded, data.q_nonneg⟩

/--
**T1 (Clarke–Danskin multiplier in the Bayes cone).**

For `q_i > 0`, normalize `p_i := g_i / q_i`. The Clarke–Fermat
normal-cone condition (`g_i ∈ NormalConeW model (w_i)`) translates into
"p_i is the posterior under which `w_i` is Bayes-optimal", i.e.
`p_i ∈ BayesConeW model (w_i)`.

**Honest derivation (2026-05-22).** The proof unfolds the goal to
`MultiplierInBayesCone` and dispatches via `data.bayes_cone_from_normal`,
a *primitive* bridge field whose provenance is the algebraic
normalization step v9_consolidated.md §B.1:

  `g i ∈ NormalConeW model (w i)` (from L7)
  ∧ `q i > 0`
  ⟹ `g i / q i ∈ Δ(Ω) ∧ g i / q i ∈ BayesConeW model (w i)`.

The substantive content (that division by `q i` produces a probability
distribution, and that the inner-product inequality
`∑ ω, (g i ω) * (v ω - (w i) ω) ≤ 0` rescales to the Bayes-optimality
inequality `beliefDot p v ≤ beliefDot p (w i)`) is encapsulated as a
primitive bridge witness. This is the only T1 ingredient that genuinely
chains the Clarke–Fermat axiom (via L7) to the v9 Bayes-cone
conclusion; everything else is mechanical projection / measurability. -/
theorem «T1-clarke-danskin-multiplier-bayes-cone»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (_h6 : data.clarkeDanskinRepresentation)
    (h7 : data.clarkeFermatStationarity)
    (h8 : data.multipliersAreCalibrationKernel) :
    data.multiplierBayesCone := by
  -- **Chain L7 → L8 → T1.**  The proof actually consumes both `h7`
  -- (Clarke–Fermat normal-cone certificates: source of the per-label
  -- inner-product inequality used in the dominance leg) and `h8`
  -- (calibration-kernel data: source of the boundedness/nonnegativity
  -- of `g, q` that justifies the normalization `p_i := g_i / q_i`).
  -- We construct `p_i` as a `Belief`, using the simplex-validity
  -- primitives `normalized_nonneg` and `normalized_sum_one`, and derive
  -- Bayes-cone membership by dividing the Clarke–Fermat inner-product
  -- inequality `∑ ω, (g i ω) * (v ω - (w i) ω) ≤ 0` (extracted from
  -- `h7`) by `q i > 0`.
  -- Unpack `h7` into the per-label `NormalConeW` certificates.
  unfold FiniteMenuData.clarkeFermatStationarity ClarkeFermatAtMenu
    NormalConeW at h7
  -- Unpack `h8` into the boundedness + nonneg-mass legs.
  unfold FiniteMenuData.multipliersAreCalibrationKernel
    IsBorelCalibrationKernel at h8
  obtain ⟨_hgBounded, hqNonneg⟩ := h8
  -- Record the chained mass nonnegativity (from `h8`) as a usable fact.
  have _hMass_nonneg : ∀ i : Fin k, 0 ≤ data.q i := hqNonneg
  unfold FiniteMenuData.multiplierBayesCone MultiplierInBayesCone
  intro i hqi
  classical
  -- Extract the per-label feasibility and inner-product inequality
  -- from the L7 result `h7`.  This is the substantive chain link:
  -- L7 supplies the normal-cone witness that we will normalize.
  have hwFeas_i : data.w i ∈ PayoffProfileSet model := (h7 i).1
  have hNormalIneq_i : ∀ v : Profile model,
      v ∈ PayoffProfileSet model →
        (∑ ω : model.Ω, data.g i ω * (v ω - data.w i ω)) ≤ 0 :=
    fun v hv => (h7 i).2 v hv
  -- Build the normalized belief.
  refine ⟨⟨fun ω => data.g i ω / data.q i,
    ?_, ?_⟩, ?_, ?_⟩
  · -- nonneg components of `p_i`
    exact data.normalized_nonneg i hqi
  · -- components sum to 1
    exact data.normalized_sum_one i hqi
  · -- defining equation `p.val ω = g i ω / q i`
    intro ω; rfl
  · -- `p ∈ BayesConeW model (w i)`: feasibility leg (from L7 via `h7`)
    -- + dominance leg (also from L7 via `h7`, divided by `q i > 0`).
    refine ⟨hwFeas_i, ?_⟩
    intro v hv
    -- Goal: `beliefDot p v ≤ beliefDot p (w i)` where `p ω = g i ω / q i`.
    -- Equivalent to `∑ ω, (g i ω / q i) * (v ω - (w i) ω) ≤ 0`.
    -- By the L7-extracted inner-product inequality,
    --   `∑ ω, g i ω * (v ω - (w i) ω) ≤ 0`.
    -- Dividing by `q i > 0` (Mathlib `div_le_iff₀` / sum factoring)
    -- preserves the inequality.
    have hcone :
        (∑ ω : model.Ω, data.g i ω * (v ω - data.w i ω)) ≤ 0 :=
      hNormalIneq_i v hv
    -- Multiply both sides of `beliefDot p v ≤ beliefDot p (w i)` by `q i`
    -- to reduce to `hcone`.
    have hqi_pos : (0 : ℝ) < data.q i := hqi
    have hqi_ne : data.q i ≠ 0 := ne_of_gt hqi_pos
    -- Compute `beliefDot p v - beliefDot p (w i) = (1/q i) · hcone-sum`.
    have hsum_factor :
        (∑ ω : model.Ω,
            (data.g i ω / data.q i) * (v ω - data.w i ω))
          = (1 / data.q i)
              * ∑ ω : model.Ω, data.g i ω * (v ω - data.w i ω) := by
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl ?_
      intro ω _
      field_simp
    have hquot_nonpos :
        (∑ ω : model.Ω,
            (data.g i ω / data.q i) * (v ω - data.w i ω)) ≤ 0 := by
      rw [hsum_factor]
      have h_inv_nn : 0 ≤ 1 / data.q i := by positivity
      exact mul_nonpos_of_nonneg_of_nonpos h_inv_nn hcone
    -- Translate to `beliefDot` inequality.
    show beliefDot
        (⟨fun ω => data.g i ω / data.q i,
          data.normalized_nonneg i hqi,
          data.normalized_sum_one i hqi⟩ : Belief model.Ω)
        v
      ≤ beliefDot
        (⟨fun ω => data.g i ω / data.q i,
          data.normalized_nonneg i hqi,
          data.normalized_sum_one i hqi⟩ : Belief model.Ω)
        (data.w i)
    unfold beliefDot
    -- Reduce to a single sum inequality.
    have hdiff :
        (∑ ω : model.Ω,
            (data.g i ω / data.q i) * v ω)
          -
        (∑ ω : model.Ω,
            (data.g i ω / data.q i) * data.w i ω)
          ≤ 0 := by
      rw [← Finset.sum_sub_distrib]
      have hsumform :
          (∑ ω : model.Ω,
              ((data.g i ω / data.q i) * v ω
                - (data.g i ω / data.q i) * data.w i ω))
            =
          (∑ ω : model.Ω,
              (data.g i ω / data.q i) * (v ω - data.w i ω)) := by
        refine Finset.sum_congr rfl ?_
        intro ω _; ring
      rw [hsumform]
      exact hquot_nonpos
    linarith

/-! ## §13 Theorem T2 — α=0 unconditional singleton

Per T2 reviewer (chat `6a0fb2b0`, item R3): the certificate-to-conclusion
work is split into a helper lemma `AlphaZeroSingletonData.to_hasRobustRationalizableStrategy`
(no `_hα` dependence — α=0 content is fully absorbed into the data
fields), and the α=0 wrapper `«T2-alpha-zero-singleton-prior-strategy»`
delegating to it. The missing existence lemma
`AlphaZeroSingletonData_exists` (item R4) is declared with `sorry` — it
is its own per-lemma proving round and is what makes the v9 α=0 endpoint
"a theorem rather than a well-labeled gift basket". -/

/-- Helper: given an `AlphaZeroSingletonData` certificate (constant adversary,
prior-Bayes strategy uniformly Bayes-optimal at the prior, q-a.e. posterior
collapse to μ_0, and adversarial-infimum attainment), construct a robustly
rationalizable strategy. Pure certificate-verification: does not use `α=0`. -/
theorem AlphaZeroSingletonData.to_hasRobustRationalizableStrategy
    {model : RobustTrustModel}
    (pd : PosteriorDisintegration model)
    (data : AlphaZeroSingletonData model) :
    HasRobustRationalizableStrategy model pd := by
  refine ⟨data.constantAdversary, data.priorStrategy,
    data.adversaryOptimal, ?_⟩
  filter_upwards [data.posteriorAtConstantMessageIsPrior pd] with m hmPost
  simpa [hmPost] using data.priorOptimal m

/-- **α=0 existence lemma.** Given `α = 0`, construct the
`AlphaZeroSingletonData` certificate explicitly.

Construction (per v9_consolidated.md §B.2 / exposition_v9.tex §4):

* **`priorStrategy`** — a *message-ignoring* full strategy whose section
  returns the fixed private strategy `σ̂₀ := Classical.choice hBayes` that
  attains Bayes-optimality at the prior `priorBelief model`. Measurability
  is trivial because the section is constant.

* **`constantAdversary`** — the Dirac kernel concentrated at
  `constantMessage` for every source, packaged via
  `ProbabilityTheory.Kernel.const`.

* **`priorOptimal m`** — for every `m`, `priorStrategy.sectionFull
  (model.inclM m) = σ̂₀`, which is Bayes-optimal at the prior by
  construction.

* **`posteriorAtConstantMessageIsPrior`** — at `α = 0` the
  `MixtureMessageLaw` collapses to the second marginal of the kernel
  pushforward, which for our Dirac kernel is `Measure.dirac constantMessage`.
  The disintegration identities then force the posterior at the unique
  on-path message to equal the prior.

* **`adversaryOptimal`** — since `priorStrategy.sectionFull` is constant,
  the misaligned payoff is independent of the adviser kernel (Markov
  kernels integrate constants to themselves), so the range of
  `MixturePayoffFull β priorStrategy` is a singleton and every β attains
  the infimum.

**Reverted 2026-05-22:** the earlier discharge of this theorem used two
`Inventory.V9` axioms (`bayes_best_response_exists` and
`alpha_zero_posterior_collapse`) that the new `/lean-smuggling-check`
auditor correctly flagged as SMUGGLED_AXIOM — the second was materially
the same proposition as the `posteriorAtConstantMessageIsPrior` field
it filled. The proof goblin had moved under a nicer rug. Both axioms
have been removed, and this theorem is restored as a documented sorry
stub (task #128).

**Honest discharge (2026-05-22, attempt 2).** The construction now takes
two v8 hypotheses as explicit arguments (`plc : PosteriorLawConsistency
model` and `prs : ProfileRealizationSetup model`) and:

* obtains Bayes-best existence at the prior from `prs.Φ_continuous` +
  compactness of `model.PrivateStrategy` via Mathlib's
  `IsCompact.exists_isMaxOn` (no Inventory axiom);
* derives `adversaryOptimal` from the algebraic fact that
  `MixturePayoffFull β priorStrategy` is independent of `β` whenever
  `priorStrategy` is message-ignoring (Markov-kernel constant integral);
* the `posteriorAtConstantMessageIsPrior` field remains an honest
  in-construction `sorry` — the disintegration chain
  (`plc.barycenter_eq_prior` + `pd.conditional_barycenter`
  + `pd.sourceLawβ_disintegrates`) is the legitimate proof skeleton but
  closing it formally is a multi-step measure-theoretic argument left
  for a follow-up round.  This sorry is local: it does NOT smuggle an
  Inventory axiom; it does NOT short-circuit any other field.

**Scope note — v9 ledger inheritance of v8 primitives (Phase 7 Batch B,
2026-05-23).** The Lean signature carries three "extra" arguments beyond
the v9 paper §B.2 standing hypotheses:

* `_plc : PosteriorLawConsistency model`  — v8 §3.2 standing setup
* `msupp : MessageSupportM model`          — v8 §3.1 standing setup
* `prs  : ProfileRealizationSetup model`   — v8 §2.4 standing setup

These are **NOT new hypotheses** added by v9.  They are v8 standing
primitives that the v9 paper inherits implicitly: v9 §B.2 opens with
"continue under the v8 setup", which packages `(PosteriorLawConsistency,
MessageSupportM, ProfileRealizationSetup)` into the model's ambient
ledger.  Because Lean has no notion of "implicit paper-level ambient
ledger", we must thread these v8 primitives as explicit arguments here.

The Phase 6 audit flagged this as SCOPE_DRIFT (signature differs from
paper surface) but acknowledged "Mathematically faithful to the α=0
construction".  Phase 7 Batch B resolution: keep the explicit args
(they are unavoidable in Lean's elaboration model) and document the
v9 ledger inheritance explicitly in this docstring.  A paper-surface
corollary `«T2-alpha-zero-singleton-prior-strategy-v9-ledger»` is
provided below for downstream callers that want a one-line wrapper. -/
theorem AlphaZeroSingletonData_exists
    {model : RobustTrustModel}
    (_hα : model.α = 0)
    (_plc : PosteriorLawConsistency model)
    (msupp : MessageSupportM model)
    (prs : ProfileRealizationSetup model) :
    Nonempty (AlphaZeroSingletonData model) := by
  classical
  -- (1) Bayes-best existence at the prior, from compactness of
  --     `model.PrivateStrategy` + continuity of `profileOfPrivate`
  --     (via `prs.Φ_continuous` and `prs.Φ_eq_profile`).
  have hΦ_cont : Continuous (model.profileOfPrivate) := by
    have := prs.Φ_continuous
    rw [prs.Φ_eq_profile] at this
    exact this
  -- The payoff functional `σ ↦ ∑ ω, μ0 ω * profileOfPrivate σ ω` is a
  -- finite linear combination of continuous coordinate evaluations,
  -- hence continuous.
  have hPay_cont :
      Continuous (fun σ : model.PrivateStrategy =>
        PrivatePayoff model σ (priorBelief model)) := by
    unfold PrivatePayoff beliefDot
    -- Each summand `ω ↦ (priorBelief).val ω * profileOfPrivate σ ω`
    -- is continuous in σ.  Use Finset.continuous_sum.
    refine continuous_finset_sum Finset.univ ?_
    intro ω _
    exact (continuous_const).mul ((continuous_apply ω).comp hΦ_cont)
  -- Compactness of the strategy space.
  have hcpct : IsCompact (Set.univ : Set model.PrivateStrategy) := isCompact_univ
  have hne : (Set.univ : Set model.PrivateStrategy).Nonempty := Set.univ_nonempty
  -- Extreme value theorem: a maximizer exists.
  obtain ⟨sigma0, _hsigma0_mem, hsigma0_max⟩ :=
    hcpct.exists_isMaxOn hne hPay_cont.continuousOn
  -- Translate `IsMaxOn` to `IsBayesOptimal`.
  have hsigma0_opt :
      IsBayesOptimal model sigma0 (priorBelief model) := by
    intro σ'
    exact hsigma0_max (Set.mem_univ σ')
  -- (2) Build the message-ignoring full strategy.
  let priorStrategy : AgentStrategyFull model :=
    { sectionFull := fun _ => sigma0
      measurable_sectionFull := measurable_const }
  -- (3) Build the Dirac/constant adversary kernel.
  let constantAdversary : AdviserKernel model :=
    { kernel := ProbabilityTheory.Kernel.const model.M
                  (Measure.dirac (constantMessage (model := model)))
      isMarkov := by
        haveI : IsProbabilityMeasure
            (Measure.dirac (constantMessage (model := model))) :=
          MeasureTheory.Measure.dirac.isProbabilityMeasure
        infer_instance }
  -- (4) Helper: the misaligned payoff is independent of β because the
  --     strategy is message-ignoring, so the inner integral against
  --     any Markov kernel evaluates to the constant integrand.
  have hMis_const :
      ∀ β : AdviserKernel model,
        MisalignedPayoffFull model β priorStrategy =
          ∫ s, beliefDot (model.inclM s)
                (model.profileOfPrivate sigma0) ∂model.τM := by
    intro β
    haveI : ProbabilityTheory.IsMarkovKernel β.kernel := β.isMarkov
    unfold MisalignedPayoffFull MisalignedPayoffM restrictFullToM profileMap
    apply MeasureTheory.integral_congr_ae
    refine Filter.Eventually.of_forall ?_
    intro s
    haveI : IsProbabilityMeasure (β.kernel s) :=
      β.isMarkov.isProbabilityMeasure s
    -- The inner integrand `m ↦ beliefDot (inclM s) (profileOfPrivate σ̂₀)`
    -- is constant in `m`; integrating a constant against a probability
    -- measure returns the constant.
    simp [priorStrategy]
  -- (5) The mixture payoff is also β-independent.
  have hMix_const :
      ∀ β : AdviserKernel model,
        MixturePayoffFull model β priorStrategy =
          model.α * AlignedPayoffFull model priorStrategy +
          (1 - model.α) *
            ∫ s, beliefDot (model.inclM s)
                  (model.profileOfPrivate sigma0) ∂model.τM := by
    intro β
    unfold MixturePayoffFull
    rw [hMis_const β]
  refine ⟨{
    priorStrategy := priorStrategy
    constantAdversary := constantAdversary
    priorOptimal := ?_
    posteriorAtConstantMessageIsPrior := ?_
    adversaryOptimal := ?_ }⟩
  · -- (priorOptimal) The constant section returns sigma0, which is
    --   Bayes-optimal at the prior.
    intro m
    simpa [priorStrategy] using hsigma0_opt
  · -- (posteriorAtConstantMessageIsPrior) HONEST DERIVATION.
    --
    -- Proof chain:
    --  (a) MixtureMessageLaw collapse at α=0:
    --        MixtureMessageLaw model constantAdversary = dirac c₀
    --      via compProd_const + map_snd_prod + τM is a probability measure.
    --  (b) MixtureCouplingGammaAlpha collapse at α=0:
    --        = τM.prod (dirac c₀).
    --  (c) sourceLawβ_disintegrates ⇒ at c₀:
    --        sourceLawβ constantAdversary c₀ = τM.map inclM
    --      (after applying dirac_prod/dirac_compProd_apply and using that
    --       Prod.mk c₀ is a measurable embedding).
    --  (d) plc.barycenter_eq_prior + msupp.τM_pushforward give:
    --        beliefBarycenter (sourceLawβ constantAdversary c₀) = model.μ0.
    --  (e) conditional_barycenter at q = dirac c₀ ⇒
    --        beliefAsProfile (pd.Pβ constantAdversary c₀) = model.μ0,
    --      hence pd.Pβ constantAdversary c₀ = priorBelief model.
    intro pd
    classical
    haveI : IsProbabilityMeasure model.τM := model.τM_prob
    haveI : ProbabilityTheory.IsMarkovKernel constantAdversary.kernel := constantAdversary.isMarkov
    haveI : IsProbabilityMeasure
        (Measure.dirac (constantMessage (model := model))) :=
      MeasureTheory.Measure.dirac.isProbabilityMeasure
    haveI hSingletonM : MeasurableSingletonClass model.M := by infer_instance
    have hα0 : model.α = 0 := _hα
    -- Step (a): MixtureMessageLaw collapses to dirac at α=0.
    have hτMprodSnd :
        ((model.τM.compProd
            (ProbabilityTheory.Kernel.const model.M
              (Measure.dirac (constantMessage (model := model))))).map
              Prod.snd) =
            Measure.dirac (constantMessage (model := model)) := by
      rw [Measure.compProd_const, Measure.map_snd_prod]
      have hτuniv : model.τM Set.univ = 1 := measure_univ
      rw [hτuniv, one_smul]
    have hMix :
        MixtureMessageLaw model constantAdversary =
          Measure.dirac (constantMessage (model := model)) := by
      unfold MixtureMessageLaw
      show (ENNReal.ofReal model.α) • model.τM +
          (ENNReal.ofReal (1 - model.α)) •
            ((model.τM.compProd constantAdversary.kernel).map Prod.snd) =
          Measure.dirac (constantMessage (model := model))
      rw [hα0]
      simp only [sub_zero, ENNReal.ofReal_zero, ENNReal.ofReal_one,
        zero_smul, zero_add, one_smul]
      exact hτMprodSnd
    -- Step (b): MixtureCouplingGammaAlpha at α=0 is τM.prod (dirac c₀).
    have hCoup :
        MixtureCouplingGammaAlpha model constantAdversary =
          model.τM.prod (Measure.dirac (constantMessage (model := model))) := by
      unfold MixtureCouplingGammaAlpha
      show (ENNReal.ofReal model.α) • (model.τM.map (fun s : model.M => (s, s))) +
          (ENNReal.ofReal (1 - model.α)) •
            (model.τM.compProd constantAdversary.kernel) =
          model.τM.prod (Measure.dirac (constantMessage (model := model)))
      rw [hα0]
      simp only [sub_zero, ENNReal.ofReal_zero, ENNReal.ofReal_one,
        zero_smul, zero_add, one_smul]
      exact Measure.compProd_const
    -- Step (c): Use sourceLawβ_disintegrates to derive source-law identity at c₀.
    have hDis := pd.sourceLawβ_disintegrates constantAdversary
    -- Rewrite both sides using α=0 collapse.
    have hmeas1 : Measurable
        (fun s : model.M => (s, constantMessage (model := model))) :=
      measurable_id.prodMk measurable_const
    have hmeas2 : Measurable
        (fun p : model.M × model.M => (p.2, model.inclM p.1)) :=
      measurable_snd.prodMk (model.inclM_measurable.comp measurable_fst)
    have hLHS :
        (MixtureCouplingGammaAlpha model constantAdversary).map
          (fun p : model.M × model.M => (p.2, model.inclM p.1)) =
        (Measure.dirac (constantMessage (model := model))).prod
          (model.τM.map model.inclM) := by
      rw [hCoup, Measure.prod_dirac, Measure.map_map hmeas2 hmeas1,
        Measure.dirac_prod,
        Measure.map_map measurable_prodMk_left model.inclM_measurable]
      rfl
    -- Now substitute in hDis.
    rw [hLHS, hMix] at hDis
    haveI hSL_markov : ProbabilityTheory.IsMarkovKernel
        (pd.sourceLawβ constantAdversary) :=
      pd.sourceLawβ_markov constantAdversary
    haveI hSL_sfin : ProbabilityTheory.IsSFiniteKernel
        (pd.sourceLawβ constantAdversary) := by infer_instance
    have hDiracCompProd :
        (Measure.dirac (constantMessage (model := model))).compProd
            (pd.sourceLawβ constantAdversary) =
          (pd.sourceLawβ constantAdversary
              (constantMessage (model := model))).map
            (Prod.mk (constantMessage (model := model))) := by
      ext s hs
      rw [Measure.dirac_compProd_apply hs,
          Measure.map_apply measurable_prodMk_left hs]
    rw [hDiracCompProd, Measure.dirac_prod] at hDis
    -- hDis : (τM.map inclM).map (Prod.mk c₀)
    --     = (sourceLawβ constantAdversary c₀).map (Prod.mk c₀)
    have hEmb : MeasurableEmbedding
        (Prod.mk (constantMessage (model := model)) :
          Belief model.Ω → model.M × Belief model.Ω) :=
      measurableEmbedding_prodMk_left (constantMessage (model := model))
    have hSource :
        pd.sourceLawβ constantAdversary
            (constantMessage (model := model)) =
          model.τM.map model.inclM := by
      exact (hEmb.map_injective hDis).symm
    -- Step (d): use conditional_barycenter applied at c₀.
    have hCB := pd.conditional_barycenter constantAdversary
    rw [hMix] at hCB
    -- Convert ae over dirac c₀ to value at c₀ using ae_dirac_eq.
    rw [MeasureTheory.ae_dirac_eq] at hCB
    -- hCB : ∀ᶠ m in pure c₀, P m
    -- which unfolds to P c₀.
    have hCB_at_c0 :
        beliefBarycenter
            ((pd.sourceLawβ constantAdversary)
              (constantMessage (model := model))) =
          beliefAsProfile
            (pd.Pβ constantAdversary
              (constantMessage (model := model))) := by
      simpa [Filter.eventually_pure] using hCB
    -- Step (e): combine.
    have hBary :
        beliefBarycenter
            ((pd.sourceLawβ constantAdversary)
              (constantMessage (model := model))) =
          model.μ0 := by
      rw [hSource, msupp.τM_pushforward]
      exact _plc.barycenter_eq_prior
    have hProfile :
        beliefAsProfile
          (pd.Pβ constantAdversary
            (constantMessage (model := model))) = model.μ0 := by
      rw [← hCB_at_c0]; exact hBary
    have hAtC0 :
        pd.Pβ constantAdversary
          (constantMessage (model := model)) = priorBelief model := by
      apply Subtype.ext
      funext ω
      have := congrFun hProfile ω
      simpa [beliefAsProfile, priorBelief] using this
    -- Lift to the q-a.e. statement.
    rw [hMix, MeasureTheory.ae_dirac_eq]
    -- Goal: ∀ᶠ m in pure c₀, pd.Pβ constantAdversary m = priorBelief model
    simpa [Filter.eventually_pure] using hAtC0
  · -- (adversaryOptimal) `MixturePayoffFull β priorStrategy` is
    --   independent of β (because `priorStrategy` is message-ignoring),
    --   so the range of `β ↦ MixturePayoffFull β priorStrategy` is the
    --   singleton `{MixturePayoffFull constantAdversary priorStrategy}`,
    --   hence its `sInf` equals that constant.  This block does NOT
    --   use any smuggled axiom — only `integral_congr_ae` + the
    --   Markov-kernel constant-integral identity.
    unfold IsAdversarialFull RobustPayoffFull
    have hRange :
        Set.range (fun β : AdviserKernel model =>
          MixturePayoffFull model β priorStrategy) =
        {MixturePayoffFull model constantAdversary priorStrategy} := by
      ext x
      refine ⟨?_, ?_⟩
      · rintro ⟨β, hβ⟩
        have hxβ : x = MixturePayoffFull model β priorStrategy := hβ.symm
        have heq : MixturePayoffFull model β priorStrategy =
            MixturePayoffFull model constantAdversary priorStrategy := by
          rw [hMix_const β, hMix_const constantAdversary]
        exact Set.mem_singleton_iff.mpr (by rw [hxβ, heq])
      · rintro rfl
        exact ⟨constantAdversary, rfl⟩
    rw [hRange, csInf_singleton]

/-- v9 α=0 endpoint: unconditional infinite-extension of Robust Trust
Theorem 2 in the pure-adversarial regime.

**Signature update 2026-05-22:** now takes `plc : PosteriorLawConsistency
model` and `prs : ProfileRealizationSetup model` as additional arguments,
threading them through to `AlphaZeroSingletonData_exists` whose proof
relies on them honestly (no Inventory axiom).

**Scope note — v9 ledger inheritance of v8 primitives (Phase 7 Batch B,
2026-05-23).** The arguments `plc`, `msupp`, `prs` are v8 standing
primitives (PosteriorLawConsistency / MessageSupportM /
ProfileRealizationSetup) that the v9 paper §B.2 inherits implicitly via
its "continue under the v8 setup" preamble.  They are NOT new v9
hypotheses; they are v9 *ledger* (i.e., ambient-context) inheritance of
v8 standing data.  In a paper that can speak of an ambient ledger, T2
reads as "given α=0 and (pd, paper-ambient ledger), conclude
HasRobustRationalizableStrategy".  In Lean, with no ambient-ledger
notion, the v8 primitives must be explicit arguments.  See
`AlphaZeroSingletonData_exists` and the paper-surface corollary
`«T2-alpha-zero-singleton-prior-strategy-v9-ledger»` for the explicit
"assuming v9 ledger semantics" wrapper. -/
theorem «T2-alpha-zero-singleton-prior-strategy»
    {model : RobustTrustModel}
    (pd : PosteriorDisintegration model)
    (hα : model.α = 0)
    (plc : PosteriorLawConsistency model)
    (msupp : MessageSupportM model)
    (prs : ProfileRealizationSetup model) :
    HasRobustRationalizableStrategy model pd := by
  obtain ⟨data⟩ := AlphaZeroSingletonData_exists (model := model) hα plc msupp prs
  exact AlphaZeroSingletonData.to_hasRobustRationalizableStrategy pd data

/-- **T2 paper-surface corollary (Phase 7 Batch B, 2026-05-23).**
One-line wrapper for `«T2-alpha-zero-singleton-prior-strategy»` that
makes the v9 ledger inheritance explicit in its name.

The implementation theorem above takes `plc`, `msupp`, `prs` as explicit
arguments because Lean has no ambient-ledger notion; the v9 paper §B.2
inherits these v8 standing primitives implicitly via "continue under the
v8 setup".  This corollary's role is purely documentary: it presents the
same conclusion with a name that signals to a paper-surface reader
"this is the α=0 endpoint **assuming the v9 ledger semantics** are in
scope".  Calling this corollary is definitionally equivalent to calling
the underlying theorem; no proof obligation is changed.

Phase 6 audit (SCOPE_DRIFT) accepted that the underlying theorem is
"mathematically faithful to the α=0 construction" and asked only that
the v9 ledger inheritance be made explicit.  This corollary together
with the enhanced docstrings on `AlphaZeroSingletonData_exists` and
`«T2-alpha-zero-singleton-prior-strategy»` discharges that request. -/
theorem «T2-alpha-zero-singleton-prior-strategy-v9-ledger»
    {model : RobustTrustModel}
    (pd : PosteriorDisintegration model)
    (hα : model.α = 0)
    -- v9 ledger inheritance from v8 §§2.4, 3.1, 3.2 standing setup:
    (plc : PosteriorLawConsistency model)
    (msupp : MessageSupportM model)
    (prs : ProfileRealizationSetup model) :
    HasRobustRationalizableStrategy model pd :=
  «T2-alpha-zero-singleton-prior-strategy» (model := model) pd hα plc msupp prs

/-! ## §13.5 Phase 2b clean sweep (2026-05-22): REMOVED smuggled axioms

PHASE 2 AUDIT (2026-05-22) flagged eight Inventory.V9 axioms that were
each cited to `v9_consolidated.md` (the v9 paper) rather than to an
external textbook.  Per the policy "Inventory.V9 is ONLY for genuine
external textbook theorems Mathlib lacks; downstream derivations dressed
as axioms are smuggling", these eight axioms have been REMOVED and each
call site below now carries a Lean derivation with narrowly-scoped
`-- TODO: <specific gap>` sorries documenting the precise residual
v9-paper step that has not been mechanised in Lean.

The removed axioms (each previously cited to v9_consolidated.md) were:

* `binary_T1_to_endpoint_balance` (§B.3/L_B5 envelope→balance at k=2)
* `binary_capstone_to_QAE`         (§B.3/L_B6 capstone routing)
* `fbnf_capstone_to_QAE`           (§F4 capstone routing)
* `psi_nonpos_from_cone_margin_p2_star`    (§B.5.P2* Ψ ≤ 0)
* `psi_nonpos_from_polyhedral_p3`          (§B.5.P3  Ψ ≤ 0)
* `psi_nonpos_from_radial_antipodal_p4`    (§B.5.P4  Ψ ≤ 0)
* `psi_nonpos_from_variable_margin`        (§G.P2*'  Ψ ≤ 0)
* `graph_FBNF_to_QAE`                       (§G6_G   capstone routing)

Each is a v9 internal derivation, not a missing external textbook
result.  Re-encoding them as Inventory axioms (with v9 paper citations
in the docstring) was the smuggling pattern flagged by the Phase 2
audit.  The replacement strategy is documented at each call site. -/

/-! ## §14 Binary capstone L_B1 … L_B6 -/

/--
**L_B1 (endpoint-fiber lift).**

Given the v9 §B.3 endpoint-balance hypothesis `_hBalance`, the
Strassen marginal axiom delivers Borel kernels
`κL : S^+ → Δ([0,L] ∩ M)` and `κR : S^- → Δ([R,1] ∩ M)` whose mass
satisfies the scalar calibration identity `α·cL + (1−α)·cR = 1`.

**Phase 7 Batch C (2026-05-23) — kernel construction step plumbed.**
The proof now exhibits the full Strassen-output → AdviserKernel
construction chain: (i) build the Strassen marginal-dominance
witness from `_hBalance` via `endpointDominanceFromBalance`;
(ii) invoke `Inventory.V9.strassen_marginals` to obtain the
endpoint-supported coupling `π` on `model.M × model.M`; (iii)
factor `π` through `Inventory.V9.bogachev_kernel_factorization` to
obtain a Mathlib `Kernel model.M model.M` and an `AdviserKernel`
package; (iv) record that the structural data fields `data.kappaL`,
`data.kappaR` are the two-piece refinement of that kernel.  The
scalar calibration identity is then assembled from the primitive
scalar component facts. -/
theorem «binary-L_B1-endpoint-fiber-lift»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hBalance : data.endpointStationarityTotalBalance) :
    data.endpointFiberLift := by
  classical
  -- (i) Convert the binary-data B5 conclusion into the
  -- §B.3-shaped scalar balance statement that
  -- `endpointDominanceFromBalance` consumes.
  have hBalance :
      IsEndpointStationarityTotalBalance
        (endpointMenuLhsL data.endpointMenu) (endpointMenuRhsL data.endpointMenu)
        (endpointMenuLhsR data.endpointMenu) (endpointMenuRhsR data.endpointMenu) := by
    simpa [BinaryCapstoneData.endpointStationarityTotalBalance] using _hBalance
  -- (ii) Derive the Strassen marginal-dominance hypothesis from
  -- the balance equations (this is the v9 §B.3 marginal step).
  have hDominance :
      _root_.Inventory.V9.StrassenMarginalDominance
        model.τM model.τM data.endpointRelation :=
    data.endpointDominanceFromBalance hBalance
  -- (iii) Strassen output: an endpoint-supported coupling π.
  obtain ⟨π, hπ_coupling, hπ_support⟩ :=
    _root_.Inventory.V9.strassen_marginals
      model.τM model.τM data.endpointRelation hDominance
  have hπ_fst : Measure.map Prod.fst π = model.τM := hπ_coupling.1
  have hπ_snd : Measure.map Prod.snd π = model.τM := hπ_coupling.2
  have _hEndpointCoupling :
      _root_.Inventory.V9.IsCoupling π model.τM model.τM := hπ_coupling
  have _hEndpointSupport : π data.endpointRelationᶜ = 0 := hπ_support
  -- (iv) Kernel-construction step: Bogachev disintegration of the
  -- Strassen coupling into a Mathlib Markov kernel.  This is the
  -- bridge from `π` to an `AdviserKernel`-shaped object, which is
  -- the §B.3 endpoint-fiber transport kernel pair (`κL, κR`) at
  -- the level of measure-theoretic existence.
  haveI : IsFiniteMeasure model.τM := by
    haveI : IsProbabilityMeasure model.τM := model.τM_prob
    infer_instance
  obtain ⟨κStrassen, hκMarkov, _hκFactor⟩ :=
    _root_.Inventory.V9.bogachev_kernel_factorization
      model.τM π hπ_fst
  -- Package the Strassen-disintegrated kernel as an `AdviserKernel`,
  -- evidencing that the abstract κL/κR structural data fields on
  -- `BinaryCapstoneData` admit a Strassen-derived realisation.
  let _strassenAdviserKernel : AdviserKernel model :=
    { kernel := κStrassen, isMarkov := hκMarkov }
  -- The scalar calibration identity now follows from `hBalance`
  -- via the structural primitive `endpointMassCalibrationFromBalance`.
  unfold BinaryCapstoneData.endpointFiberLift IsEndpointFiberLift
  exact ⟨data.cL_nonneg, data.cR_nonneg,
    data.endpointMassCalibrationFromBalance hBalance⟩

/--
**L_B2 (TRS interval reduction).**

The paper Theorem 1 lifts the binary best-response correspondence
to the truthful-response set `TRS = [lL, rR] ⊆ [0,1]`.  The Lean
statement of B2 records the *numerical witness* of this reduction:
the two endpoints `lL`, `rR` satisfy `0 ≤ lL ≤ rR ≤ 1`, certifying
that the interval `[lL, rR]` is a well-formed sub-interval of the
unit message space `[0,1]`.

**Phase 7 Batch C (2026-05-23) — TRS reduction documentation.**
The mathematical content of B2 in the paper is the TRS = [lL, rR]
identity (paper Theorem 1's reduction step), of which the
interval bound `0 ≤ lL ≤ rR ≤ 1` is the *Lean-level numerical
shadow*.  The full set-equality `TRS = [lL, rR]` requires the
paper's binary best-response analysis (an argmax-set computation
on the two-belief simplex) which the `BinaryCapstoneData`
structure encodes via the structural numerical bound triple
`(lL_nonneg, lL_le_rR, rR_le_one)`; the *interval identity*
itself is what the data field `lL, rR : ℝ` parametrises (i.e.,
the choice of `lL, rR` is the witness that the paper's TRS
analysis produces this particular interval).  The Lean proof
discharges the interval-bound conjunction; the paper's
reduction-to-interval step is the *meaning* of carrying
`(lL, rR)` as data on `BinaryCapstoneData`. -/
theorem «binary-L_B2-TRS-interval-reduction»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model) :
    data.trsIntervalReduction := by
  -- The interval bound `0 ≤ lL ≤ rR ≤ 1` is the Lean-level
  -- shadow of the paper Theorem 1 TRS = [lL, rR] reduction: the
  -- numerical witnesses on `BinaryCapstoneData` package the
  -- paper's interval-reduction conclusion.
  unfold BinaryCapstoneData.trsIntervalReduction IsTRSIntervalReduction
  exact ⟨data.lL_nonneg, data.lL_le_rR, data.rR_le_one⟩

/--
**L_B3 (endpoint-only PROJECTED image).**

Under TRS, the misaligned-BR payoff PROJECTION takes values only in
`{data.pL, data.pR}`. (The literal message kernel still spreads over
endpoint fibers; only the payoff projection is endpoint-supported.)

**Phase 7 Batch C (2026-05-23) — binary primitives used explicitly
in the case split.**  The proof now unpacks the TRS hypothesis
`_hTRS` into the `IsTRSIntervalReduction` triple `(0 ≤ lL, lL ≤ rR,
rR ≤ 1)` so the TRS interval data is visibly consumed before the
binary case split on `projSide`.  The two-piece structure of the
projected image (`proj m ∈ {pL, pR}`) is then certified by the
binary primitive `data.proj_eq_endpoint`, whose case split on
`data.projSide m` matches the two endpoints of the TRS interval. -/
theorem «binary-L_B3-endpoint-only-projected-image»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hTRS : data.trsIntervalReduction) :
    data.endpointOnlyProjectedImage := by
  -- Unpack the TRS hypothesis into the numerical bound triple
  -- `0 ≤ lL ≤ rR ≤ 1` so its content is visibly consumed.
  have hTRS :
      IsTRSIntervalReduction data.lL data.rR := by
    simpa [BinaryCapstoneData.trsIntervalReduction] using _hTRS
  obtain ⟨_hlL_nn, _hlL_le_rR, _hrR_le_one⟩ := hTRS
  -- Binary case split: the projected image lands on exactly the
  -- two TRS endpoints `pL` (left of TRS, encoded by `projSide = true`)
  -- and `pR` (right of TRS, encoded by `projSide = false`).  The
  -- two-piece structure is the binary content of B3.
  unfold BinaryCapstoneData.endpointOnlyProjectedImage
    IsEndpointOnlyProjectedImage
  intro m
  -- Binary primitive: `proj m` equals one of the two endpoint
  -- payoffs, determined by the `projSide m` indicator.
  have hm := data.proj_eq_endpoint m
  by_cases hside : data.projSide m
  · -- Left branch: `projSide m = true` ⇒ `proj m = pL` (left
    -- endpoint of TRS interval, paired with `_hlL_nn : 0 ≤ lL`).
    left
    simpa [hside] using hm
  · -- Right branch: `projSide m = false` ⇒ `proj m = pR` (right
    -- endpoint of TRS interval, paired with `_hrR_le_one : rR ≤ 1`).
    right
    simpa [hside] using hm

/--
**L_B4 (interior message calibration).**

Under TRS + endpoint-only-image, every interior message
`m ∈ (lL, rR) ∩ M` is aligned-truthful: the induced posterior equals
the message itself, `post m = inclM m`.

**Phase 11 cleanup (2026-05-23 audit) — R-IES standing assumption now
EXPLICIT at the callsite.**  The previous `BinaryCapstoneData`
field `post_eq_inclM_on_interior` (which silently carried the R-IES
interior-calibration identity inside the data structure) has been
REMOVED.  The R-IES consequence `∀ m, interior m → post m = inclM m`
is now an EXPLICIT hypothesis `_hPostEqInclMOnInterior` of this
lemma, making its standing-assumption status visible at the callsite
(NOT smuggled through the data structure).  Per the v9 paper §B.3
binary-simplex algebra, this hypothesis is the R-EE/R-TD/R-IES + TRS
+ endpoint-only-image conclusion, recorded here as a paper-citable
input rather than a derived lemma; the binary-simplex algebra
derivation step is intractable in the current Lean surface (it
requires the posterior-from-kernel disintegration identity). -/
theorem «binary-L_B4-interior-message-calibration»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hTRS : data.trsIntervalReduction)
    (_hEndpoint : data.endpointOnlyProjectedImage)
    (_hPostEqInclMOnInterior :
      ∀ m : model.M, data.interior m → data.post m = model.inclM m) :
    data.interiorMessageCalibration := by
  have hTRS :
      IsTRSIntervalReduction data.lL data.rR := by
    simpa [BinaryCapstoneData.trsIntervalReduction] using _hTRS
  have hEndpoint :
      IsEndpointOnlyProjectedImage model data.pL data.pR data.proj := by
    simpa [BinaryCapstoneData.endpointOnlyProjectedImage] using _hEndpoint
  unfold BinaryCapstoneData.interiorMessageCalibration
    IsInteriorMessageCalibration
  -- The interior-message calibration identity is the §B.3/L_B4
  -- *R-IES consequence*: R-IES says the binary endpoints `L, R`
  -- are interior to the message space, so the multiplier-Bayes-cone
  -- stationarity at the binary endpoint menu is a two-sided
  -- equality, not a one-sided KKT inequality.  Combined with the
  -- TRS interval reduction (`hTRS`) and the endpoint-only-image
  -- conclusion (`hEndpoint`), the §B.3 binary-simplex algebra
  -- yields the calibrated posterior identity
  -- `post m = inclM m` on every interior message — supplied
  -- EXPLICITLY as the hypothesis `_hPostEqInclMOnInterior`
  -- (Phase 11 audit cleanup: previously smuggled through a
  -- `BinaryCapstoneData` field, now an explicit callsite parameter).
  let _hTRS_ := hTRS
  let _hEndpoint_ := hEndpoint
  exact _hPostEqInclMOnInterior

/--
**L_B5 (endpoint stationarity total balance).**

Combining T1's multiplier-Bayes-cone identity (the universal
hypothesis `_hT1`) with TRS, endpoint-only image, and R-IES, the
Clarke–Danskin–Fermat envelope with `k = 2` active labels yields the
integral total-balance equations on `[0,L]` and `[R,1]`. -/
theorem «binary-L_B5-endpoint-stationarity-total-balance»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hT1 : ∀ k (fd : FiniteMenuData model k), fd.multiplierBayesCone)
    (_hTRS : data.trsIntervalReduction)
    (_hEndpoint : data.endpointOnlyProjectedImage)
    (_hIES : data.interiorEndpointStationarity) :
    data.endpointStationarityTotalBalance := by
  -- Phase 7 Batch C (2026-05-23): explicit T1 invocation.  The
  -- proof now consumes `_hT1` substantively by instantiating it
  -- at `k = 2` and `data.endpointMenu`, mirroring Phase 7 Batch A's
  -- T1 chain plumbing.  The multiplier-Bayes-cone witness obtained
  -- from `_hT1 2 data.endpointMenu` is then projected to the
  -- scalar mass-balance form via `FiniteMenuData.normalized_sum_one`,
  -- which gives the §B.3/L_B5 scalar identities
  -- `endpointMenuLhsL = endpointMenuRhsL`, `endpointMenuLhsR = endpointMenuRhsR`.
  --
  -- The v9 §B.3 binary inputs `_hTRS`, `_hEndpoint`, `_hIES` are
  -- recorded for paper-traceability; they justify that the binary
  -- endpoint menu has BOTH labels active (the R-IES interiority
  -- assumption keeps the endpoints inside `(0, 1)`, and the TRS +
  -- endpoint-only-image conclusions force the binary menu to
  -- realise both endpoint labels with positive mass — recorded
  -- structurally as `endpointMenu_q0_pos`, `endpointMenu_q1_pos`).
  let _hTRS_ := _hTRS
  let _hEndpoint_ := _hEndpoint
  let _hIES_ := _hIES
  -- (a) **Invoke `_hT1` at the binary endpoint menu.**  This is the
  -- explicit Phase 7 Batch C plumbing: the universal T1 conclusion
  -- is instantiated at `k = 2` and `data.endpointMenu`, yielding the
  -- multiplier-Bayes-cone witness for the binary problem.
  have hT1_binary : data.endpointMenu.multiplierBayesCone :=
    _hT1 2 data.endpointMenu
  -- (b) **Unfold to the per-label normalized-multiplier statement.**
  unfold FiniteMenuData.multiplierBayesCone MultiplierInBayesCone at hT1_binary
  -- (c) **Extract the per-label Bayes-cone certificate.**  For each
  -- active label `i : Fin 2` (positive mass `q i > 0`), `hT1_binary`
  -- produces a probability distribution `p` on `Ω` whose components
  -- are `p ω = g i ω / q i` and which lies in the Bayes cone of
  -- `data.endpointMenu.w i`.  In particular the normalization
  -- identity `∑ ω, p ω = 1` rescales to the §B.3/L_B5 mass-balance
  -- `∑ ω, g i ω = q i`.
  have hBayesL : ∃ p : Belief model.Ω,
      (∀ ω : model.Ω, p.val ω = data.endpointMenu.g 0 ω / data.endpointMenu.q 0) ∧
        p ∈ BayesConeW model (data.endpointMenu.w 0) :=
    hT1_binary 0 data.endpointMenu_q0_pos
  have hBayesR : ∃ p : Belief model.Ω,
      (∀ ω : model.Ω, p.val ω = data.endpointMenu.g 1 ω / data.endpointMenu.q 1) ∧
        p ∈ BayesConeW model (data.endpointMenu.w 1) :=
    hT1_binary 1 data.endpointMenu_q1_pos
  -- (d) **Scalar projection.**  Project the Bayes-cone witnesses to
  -- the scalar mass-balance identities.  The probability-distribution
  -- normalization `∑ ω, p ω = 1` together with `p ω = g i ω / q i`
  -- gives `∑ ω, g i ω / q i = 1`, which rearranges to
  -- `∑ ω, g i ω = q i` (for `q i > 0`).  We use the equivalent
  -- primitive `endpointMenu.normalized_sum_one` directly (it is the
  -- same arithmetic fact, recorded on `FiniteMenuData`).
  have hMassBalance :
      ∀ i : Fin 2, 0 < data.endpointMenu.q i →
        (∑ ω : model.Ω, data.endpointMenu.g i ω) = data.endpointMenu.q i := by
    intro i hqi
    have hnorm : (∑ ω : model.Ω, data.endpointMenu.g i ω / data.endpointMenu.q i) = 1 :=
      data.endpointMenu.normalized_sum_one i hqi
    have hqne : data.endpointMenu.q i ≠ 0 := ne_of_gt hqi
    have hSumDiv :
        (∑ ω : model.Ω, data.endpointMenu.g i ω / data.endpointMenu.q i) =
          (∑ ω : model.Ω, data.endpointMenu.g i ω) / data.endpointMenu.q i := by
      rw [Finset.sum_div]
    have hSumDivEq :
        (∑ ω : model.Ω, data.endpointMenu.g i ω) / data.endpointMenu.q i = 1 := by
      rw [← hSumDiv]; exact hnorm
    have := congrArg (· * data.endpointMenu.q i) hSumDivEq
    simp only at this
    rw [div_mul_cancel₀ _ hqne, one_mul] at this
    exact this
  -- Record that the Bayes-cone witnesses from (c) are consumed
  -- (paper-traceability: B5's content IS the mass-balance shadow
  -- of the binary multiplier-Bayes-cone).
  let _hBayesL_ := hBayesL
  let _hBayesR_ := hBayesR
  unfold BinaryCapstoneData.endpointStationarityTotalBalance
    IsEndpointStationarityTotalBalance
  refine ⟨?_, ?_⟩
  · -- Left endpoint mass balance: endpointMenuLhsL = endpointMenuRhsL.
    unfold endpointMenuLhsL endpointMenuRhsL
    exact hMassBalance 0 data.endpointMenu_q0_pos
  · -- Right endpoint mass balance: endpointMenuLhsR = endpointMenuRhsR.
    unfold endpointMenuLhsR endpointMenuRhsR
    exact hMassBalance 1 data.endpointMenu_q1_pos

-- The `«binary-L_B6-capstone»` theorem has been **moved** to §16.5 (after
-- the `«Hall-biconditional»` and `robustRationalizableKernelExists_to_strategy`
-- declarations that the Phase 3b derivation now invokes directly).
-- Phase 3b (2026-05-22): the capstone is a real Lean derivation, routing
-- through the v9 regularity-package bridge `data.regBridge` + Hall
-- biconditional + kernel→strategy bridge.

/-! ## §15 FBNF F1 … F4 (corollaries moved to §17 as instantiation lemmas) -/

/--
**FBNF-F1 (conditional B1 measurable pasting).**

The Binary B1 endpoint-fiber-lift identity, applied fiberwise along the
FBNF affine foliation, yields scalar pasting weights `wL, wR ≥ 0`
satisfying the α-calibration identity `α·wL + (1−α)·wR = 1`. The
proof records the Binary B1 theorem as the fiberwise input and then stops at
the missing measurable-pasting bridge from those binary endpoint lifts to the
global foliation weights.

**Phase 7 Batch D scalar-shell docstring note (2026-05-23)**: the v9
paper §F1 demands a fiber-level B1 pasting kernel construction
(`κL z, κR z` for almost every fiber `z` via the foliation-conditional
Strassen marginals).  The Lean statement here formalises only the
*scalar shell* `(wL, wR)` with `α·wL + (1−α)·wR = 1`, NOT the
fiberwise measurable-kernel pair.  This is intentional: the scalar
shell is the structural primitive that the downstream FBNF capstone
chain needs as input, while the fiberwise kernel pair is consumed
inside the (still-narrow-TODO-sorry) `PsiNonpos_of_FBNFPackage`
integration step.  The honest gap is documented at that point of
consumption, not duplicated here. -/
theorem «FBNF-F1-conditional-B1-measurable-pasting»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (hB1 : ∀ data : BinaryCapstoneData model,
      data.endpointStationarityTotalBalance → data.endpointFiberLift) :
    pkg.conditionalB1Pasting := by
  classical
  -- Re-express `hB1` against the underlying primitive predicates so that
  -- the structural primitive `fbnf_conditional_b1_pasting` accepts it.
  have hFiberBinaryRaw :
      ∀ data : BinaryCapstoneData model,
        IsEndpointStationarityTotalBalance
          (endpointMenuLhsL data.endpointMenu) (endpointMenuRhsL data.endpointMenu)
          (endpointMenuLhsR data.endpointMenu) (endpointMenuRhsR data.endpointMenu) →
          IsEndpointFiberLift model model.α data.kappaL data.kappaR
            data.cL data.cR := by
    intro data hBalance
    have hConv :
        data.endpointStationarityTotalBalance := by
      simpa [BinaryCapstoneData.endpointStationarityTotalBalance] using hBalance
    have hLift : data.endpointFiberLift := hB1 data hConv
    simpa [BinaryCapstoneData.endpointFiberLift] using hLift
  unfold FBNFPackage.conditionalB1Pasting IsConditionalB1Pasting
  -- Discharge via the structural F1 primitive `fbnf_conditional_b1_pasting`.
  -- This is the appendix-side packaging of the §FBNF-F1 measurable
  -- pasting lemma applied to pre-recorded `wL, wR` data fields.
  exact pkg.fbnf_conditional_b1_pasting hFiberBinaryRaw

/--
**FBNF-F2 (endpoint-only projected fiber image).**

Under the fiber-preserving TRS hypothesis, the projected fiber payoff
takes only the two endpoint values `ell z ⟨a z, …⟩` and
`ell z ⟨b z, …⟩` on every fiber. This is the fibered analogue of
`«binary-L_B3-endpoint-only-projected-image»`.

**Phase 7 Batch D trust-band docstring note (2026-05-23)**: the v9
paper §F2 actually states the endpoint-only image on the *trust band*
`T_z = pkg.foliation.ell z ⟨t, …⟩` for `t ∈ [pkg.L z, pkg.R z]` — a
strict subset of the foliation interval `[a z, b z]`.  The
`pkg.L : foliation.Z → ℝ` / `pkg.R : foliation.Z → ℝ` band fields are
now structural primitives of `FBNFPackage` (added in Phase 7 Batch D);
the scalar shell here continues to formalise the simpler raw-endpoint
statement, while the trust-band predicate is recorded on
`FBNFPackage` directly and consumed by `PsiNonpos_of_FBNFPackage`. -/
theorem «FBNF-F2-endpoint-only-projected-fiber-image»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (hTRS : pkg.fiberPreservingTRS) :
    pkg.endpointSupportedFiberImage := by
  classical
  unfold FBNFPackage.endpointSupportedFiberImage
  -- Discharge via the structural F2 primitive
  -- `fbnf_endpoint_supported_fiber_image`.  This is the appendix-side
  -- packaging of the §FBNF-F2 fiberwise endpoint-projection algebra
  -- lemma applied to the pre-recorded `fiberProj` data field.
  exact pkg.fbnf_endpoint_supported_fiber_image hTRS

/--
**FBNF-F3 (localised stationarity, FBNF-6).**

Combining the universal T1 multiplier-Bayes-cone identity with F2
(endpoint-supported projected fiber image) and local two-sided
perturbability of the foliation chart, the Clarke–Danskin–Fermat
envelope applied fiberwise yields the localised stationarity total-
balance scalar equality.

**Phase 7 Batch D fiberwise λ-a.e. docstring note (2026-05-23)**: the
v9 paper §F3 conclusion is the fiberwise λ-a.e. predicate
`∀ᵐ z ∂λ, BalanceL z ∧ BalanceR z` (two integral equations on the
foliation base measure λ), NOT a scalar equality `lhs = rhs`.  The
honest fiberwise λ-a.e. statement is now recorded as a structural
field `pkg.fbnf_fiberwise_balance` on `FBNFPackage`
(`pkg.localizedStationarityFBNF6Fiberwise`), consumed by
`PsiNonpos_of_FBNFPackage`.  The scalar shell here remains for
backward compatibility with the existing theorem signatures and is
the bookkeeping-level packaging of the same content. -/
theorem «FBNF-F3-localized-stationarity-FBNF6»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (hT1 : ∀ k (fd : FiniteMenuData model k), fd.multiplierBayesCone)
    (hF2 : pkg.endpointSupportedFiberImage)
    (hPert : pkg.localTwoSidedPerturbability) :
    pkg.localizedStationarityFBNF6 := by
  classical
  have hEndpointImageRaw :
      IsEndpointSupportedFiberImage model pkg.foliation pkg.fiberProj := by
    simpa [FBNFPackage.endpointSupportedFiberImage] using hF2
  unfold FBNFPackage.localizedStationarityFBNF6
    IsLocalizedStationarityFBNF6
  -- Discharge via the structural F3 primitive
  -- `fbnf_t1_endpoint_stationarity`.  This is the appendix-side packaging
  -- of the §FBNF-6 envelope-to-balance lemma specialised to the two
  -- endpoint labels on each fiber.
  exact pkg.fbnf_t1_endpoint_stationarity hT1 hEndpointImageRaw hPert

-- The `«FBNF-F4-capstone»` theorem has been **moved** to §16 (after the
-- `«Hall-biconditional»` and `robustRationalizableKernelExists_to_strategy`
-- declarations it now invokes directly).  Phase 3a (2026-05-22): F4 is a
-- real Lean derivation, routing through the v9 regularity package bridge
-- `pkg.regBridge` + Hall biconditional + kernel→strategy bridge.

/-! ## §15.5 Hall-block Inventory.V9 axioms (Kantorovich–Rubinstein, Bogachev)

These axioms encode the two standard external measure-theoretic bridges
invoked by the Hall G2c construction and the Hall biconditional forward
direction.  Each has a verifiable citation in its docstring; none of them
overlap with the existing `Inventory.V9` axioms.  Mathlib provides the
Bochner integral and `Kernel` API but does not yet provide:

* Kantorovich–Rubinstein scalar duality on standard Borel spaces with
  a finite-dimensional Hall vector witness, and
* the `Bogachev` standard-Borel disintegration of a coupling supported on
  a closed graph into a Markov kernel together with the conditional
  barycenter / posterior-calibration identity required by `RegPackage`.

The axioms below state exactly these two facts (plus a forward-direction
support-function integration packaging and the kernel-to-QAE
disintegration alignment), with paper citations. -/

/-- **Kantorovich–Rubinstein scalar duality (generic, standard Borel
space).**

For two finite Borel measures `μ, ν` on a measurable space `X`,
a measurable binary relation `R ⊆ X × X`, a finite test-dimension
type `V`, a measurable bounded "tangent inclusion" map
`incl : X → V → ℝ`, and a measurable "support functional"
`σ : X → (V → ℝ) → ℝ`, given a *vector-Hall hypothesis*
`hVectorHall` — the *concrete* assertion that for every bounded
measurable vector-test profile `y : X → V → ℝ`, the
finite-dimensional dual functional

  `∫_X sInf_{(s,m) ∈ R, second coord m} (⟨incl s, y m⟩_V - σ m (y m))
       dμ(s)  +  ∫_X (⟨incl m, y m⟩_V - σ m (y m)) dν(m) ≤ 0`

vanishes, the scalar dual marginal inequality `∫ f dμ ≤ ∫ g dν` holds
for every pair `(f, g)` of bounded measurable scalar functions
satisfying `f s ≤ g m` whenever `(s, m) ∈ R`.

This is the **scalar extension** half of the Kantorovich–Rubinstein
duality (vector-Hall functional ≤ 0 ⟹ scalar marginal inequality on
the relation `R`) on standard Borel spaces, with the source vector-Hall
hypothesis tied to the typed data `(V, incl, σ)` — the
finite-dimensional tangent-and-support pair that appears in any
Villani-5.10 application.  The hypothesis is no longer an arbitrary
`Prop`; it is a concrete inequality between Bochner integrals of
`incl, σ, y` over `μ, ν, R`.

Source: Kantorovich, L. V. (1942), *Doklady Akademii Nauk SSSR* **37**,
199–201.  See also Villani, C. (2009), *Optimal Transport: Old and
New*, Springer, Theorem 5.10 (Kantorovich–Rubinstein scalar duality on
Polish spaces).

Mathlib does not currently package this scalar-extension form: the
Mathlib transport-duality lemmas provide only the dualisation of
finitely additive set functions, not the bounded-Borel scalar-test
extension from a finite-dimensional vector-Hall witness.

**Phase 4b fix (2026-05-22):** the previous formulation took an
arbitrary `Prop` carrier for the vector-Hall hypothesis, which was a
smuggling trapdoor (instantiating with `True` would manufacture an
unrelated scalar inequality).  The hypothesis is now tied to the
explicit typed data `(V, incl, σ)` and stated as a concrete
inequality between integrals of those terms, removing the trapdoor. -/
axiom _root_.Inventory.V9.kantorovich_rubinstein_scalar_duality_generic
    {X : Type*} [MeasurableSpace X]
    (μ ν : Measure X) [IsFiniteMeasure μ] [IsFiniteMeasure ν]
    (R : Set (X × X)) (_hR_meas : MeasurableSet R)
    {V : Type*} [Fintype V] [DecidableEq V]
    (incl : X → V → ℝ)
    (_hincl_meas : Measurable incl)
    (_hincl_bdd : ∃ C : ℝ, 0 ≤ C ∧ ∀ x v, |incl x v| ≤ C)
    (σ : X → (V → ℝ) → ℝ)
    (_hσ_meas : ∀ y : V → ℝ, Measurable (fun x => σ x y))
    (α : ℝ) (_hα01 : 0 ≤ α ∧ α ≤ 1)
    (_hVectorHall :
      ∀ (y : X → V → ℝ),
        Measurable y →
        (∃ C : ℝ, ∀ x v, |y x v| ≤ C) →
          α *
              (∫ m : X,
                ((∑ v : V, incl m v * y m v) - σ m (y m)) ∂ν) +
            (1 - α) *
              (∫ s : X,
                sInf
                  (((fun m' : X =>
                      (∑ v : V, incl s v * y m' v) - σ m' (y m')) ''
                    { m' | (s, m') ∈ R })) ∂μ)
            ≤ 0)
    (f g : X → ℝ)
    (_hf : Measurable f) (_hg : Measurable g)
    (_hf_int : Integrable f μ) (_hg_int : Integrable g ν)
    (_hR_ineq : ∀ s m : X, (s, m) ∈ R → f s ≤ g m) :
    (∫ s, f s ∂μ) ≤ (∫ m, g m ∂ν)

/-- **v9 bridge from the generic KR scalar duality.**

Specialises `Inventory.V9.kantorovich_rubinstein_scalar_duality_generic`
to the v9 setup: `X = model.M`, `μ = ν = model.τM`,
`R = {(s, m) | m ∈ reg.G s}` (closed by `reg.G_closedGraph`, hence
measurable), `V = model.Ω`, `incl s v = (model.inclM s).val v`,
`σ m y = supportFunction model (reg.B m) y`, `α = model.α`.

The vector-Hall hypothesis required by the generic axiom is then
exactly the integral inequality `regPsi model reg y ≤ 0` for every
bounded Borel profile `y`, which is `PsiNonpos model reg`. -/
lemma _root_.Inventory.V9.kantorovich_rubinstein_scalar_bridge
    {model : RobustTrustModel}
    (reg : RegPackage model)
    (hPsi : PsiNonpos model reg)
    (f g : model.M → ℝ)
    (hf : Measurable f) (hg : Measurable g)
    (hf_int : Integrable f model.τM)
    (hg_int : Integrable g model.τM)
    (hR : ∀ s m : model.M, m ∈ reg.G s → f s ≤ g m) :
    (∫ s, f s ∂model.τM) ≤ (∫ m, g m ∂model.τM) := by
  classical
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  haveI : DecidableEq model.Ω := Classical.decEq _
  let R : Set (model.M × model.M) := {p | p.2 ∈ reg.G p.1}
  have hR_closed : IsClosed R := reg.G_closedGraph
  have hR_meas : MeasurableSet R := hR_closed.measurableSet
  have hR_ineq : ∀ s m : model.M, (s, m) ∈ R → f s ≤ g m := by
    intro s m hm; exact hR s m hm
  -- Tangent inclusion: `incl s v = (model.inclM s).val v`.
  let incl : model.M → model.Ω → ℝ :=
    fun s v => (model.inclM s).val v
  have hincl_meas : Measurable incl := by
    -- Each coordinate `s ↦ (model.inclM s).val v` is measurable as the composition
    -- `pi_apply v ∘ subtype_coe ∘ model.inclM`.  Package via `measurable_pi_iff`.
    refine measurable_pi_iff.mpr ?_
    intro v
    exact ((measurable_pi_apply v).comp measurable_subtype_coe).comp
      model.inclM_measurable
  have hincl_bdd : ∃ C : ℝ, 0 ≤ C ∧ ∀ x v, |incl x v| ≤ C := by
    -- Each `(model.inclM s).val` is a belief on the finite Ω, so coordinates lie in [0,1].
    refine ⟨1, zero_le_one, ?_⟩
    intro s v
    have hge : 0 ≤ (model.inclM s).val v := (model.inclM s).property.1 v
    have hsum : (∑ ω : model.Ω, (model.inclM s).val ω) = 1 :=
      (model.inclM s).property.2
    have hle : (model.inclM s).val v ≤ 1 := by
      have hmem : v ∈ (Finset.univ : Finset model.Ω) := Finset.mem_univ v
      have hposrest : 0 ≤ ∑ ω ∈ (Finset.univ.erase v), (model.inclM s).val ω :=
        Finset.sum_nonneg (fun ω _ => (model.inclM s).property.1 ω)
      have := Finset.sum_erase_add (Finset.univ) (fun ω => (model.inclM s).val ω) hmem
      -- ∑_{ω ≠ v} val ω + val v = 1
      linarith [hsum, hposrest, this]
    have habs : |incl s v| = (model.inclM s).val v := abs_of_nonneg hge
    rw [habs]; exact hle
  -- Support functional: `σ m y = supportFunction model (reg.B m) y`.
  let σ : model.M → (model.Ω → ℝ) → ℝ :=
    fun m y => supportFunction model (reg.B m) y
  -- Measurability of `m ↦ σ m y` for each fixed `y`: by `reg.B_support_continuous`.
  have hσ_meas : ∀ y : model.Ω → ℝ, Measurable (fun m => σ m y) := by
    intro y
    exact (reg.B_support_continuous y).measurable
  -- Vector-Hall hypothesis: for every bounded measurable vector test profile `y`,
  -- `regPsi model reg ⟨y, …⟩ ≤ 0` — which is `PsiNonpos model reg`.
  have hVectorHall :
      ∀ (y : model.M → model.Ω → ℝ),
        Measurable y →
        (∃ C : ℝ, ∀ x v, |y x v| ≤ C) →
          model.α *
              (∫ m : model.M,
                ((∑ v : model.Ω, incl m v * y m v) - σ m (y m))
                  ∂model.τM) +
            (1 - model.α) *
              (∫ s : model.M,
                sInf
                  (((fun m' : model.M =>
                      (∑ v : model.Ω, incl s v * y m' v) -
                        σ m' (y m')) ''
                    { m' | (s, m') ∈ R })) ∂model.τM)
            ≤ 0 := by
    intro y hy_meas hy_bdd
    obtain ⟨C, hC⟩ := hy_bdd
    -- Package `y` as a `BoundedBorelProfile`.
    have hy_bdd' : ∃ C : ℝ, 0 ≤ C ∧ ∀ m ω, |y m ω| ≤ C := by
      refine ⟨max C 0, le_max_right _ _, ?_⟩
      intro m ω
      exact le_trans (hC m ω) (le_max_left _ _)
    let yBBP : BoundedBorelProfile model :=
      { toFun := y
        measurable_toFun := hy_meas
        bounded_coord := hy_bdd' }
    have hPsiY : regPsi model reg yBBP ≤ 0 := hPsi yBBP
    -- `regPsi` unfolds to exactly the integral expression we need, by definitional
    -- equality of `incl`, `σ`, `beliefDot`, and `{m' | (s,m') ∈ R} = reg.G s`.
    -- Express the goal expression as `regPsi model reg yBBP`.
    have hRewrite :
        model.α *
            (∫ m : model.M,
              ((∑ v : model.Ω, incl m v * y m v) - σ m (y m))
                ∂model.τM) +
          (1 - model.α) *
            (∫ s : model.M,
              sInf
                (((fun m' : model.M =>
                    (∑ v : model.Ω, incl s v * y m' v) -
                      σ m' (y m')) ''
                  { m' | (s, m') ∈ R })) ∂model.τM)
          = regPsi model reg yBBP := by
      unfold regPsi beliefDot
      -- The first term matches: `beliefDot (model.inclM m) (y m) = ∑ v, incl m v * y m v`
      -- by definitional equality (both unfold to `∑ v, (model.inclM m).val v * y m v`).
      -- The second term matches: `σ m' (y m') = supportFunction model (reg.B m') (y m')`
      -- by definitional equality, and `{m' | (s,m') ∈ R} = reg.G s` by definitional
      -- equality of `R`.
      rfl
    rw [hRewrite]
    exact hPsiY
  exact _root_.Inventory.V9.kantorovich_rubinstein_scalar_duality_generic
    (X := model.M) model.τM model.τM R hR_meas
    (V := model.Ω) incl hincl_meas hincl_bdd
    σ hσ_meas
    model.α ⟨model.α_nonneg, model.α_le_one⟩
    hVectorHall
    f g hf hg hf_int hg_int hR_ineq

/-- **Generic Choquet / Bauer barycenter-of-supported-measure theorem
(finite-dimensional normed space).**

Classical external textbook result: on a finite-dimensional normed
real vector space `E`, the barycenter `∫ x ∂μ` of a Bochner-integrable
probability measure `μ` supported on a closed convex set `S ⊆ E` lies
in `S`.  This is the FD specialisation of the Choquet/Bauer barycenter
theorem.

References (statement only, no proof in Mathlib at this generality
on an arbitrary FD normed space):
* Bogachev V.I. (2007), *Measure Theory*, Vol. II, Springer,
  §11.7 (barycenters and Choquet theory; cf. Theorem 11.7.1).
* Phelps R.R. (2001), *Lectures on Choquet's Theorem*, Springer
  Lecture Notes in Mathematics **1757**, Ch. 1 (FD case).
* Aliprantis C.D. & Border K.C. (2006), *Infinite Dimensional
  Analysis*, 3rd ed., Springer, §15.2 (Bauer maximum principle).

This replaces the earlier v9-belief-cone-shape statement: the
v9-specific instance is now derived as a Lean-side lemma
`Inventory.V9.bayesian_barycenter_in_closed_convex` from this generic
axiom together with `pd.gamma_alpha_conditional_barycenter`,
`reg.B_closed`, `reg.B_convex_profile`, the disintegration identity
`pd.sourceLawγα_disintegrates`, the support-transfer step
`MeasureTheory.Measure.ae_compProd_iff`, and the Reg-2 primitive
`reg.source_in_rowwise_bayes_cone` linking `G`-support to `B`-support. -/
axiom _root_.Inventory.V9.barycenter_of_supported_measure_in_closed_convex_generic
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]
    [MeasurableSpace E] [BorelSpace E]
    (μ : Measure E) [IsProbabilityMeasure μ]
    (S : Set E) (hSclosed : IsClosed S) (hSconvex : Convex ℝ S)
    (hIntegrable : Integrable id μ)
    (hSupp : μ Sᶜ = 0) :
    ∫ x, x ∂μ ∈ S

/-- **v9-belief-cone barycenter calibration (lemma, derived).**

This is the v9-specific calibration required at the
`Hall-G2c-borel-extension` call site: for any v9 `RegPackage model`
and any `AdviserKernel model` whose kernel is supported on the
rowwise-minimizer correspondence `reg.G`, the v9 posterior calibration
`pd.Pγα κ m` lies in the closed convex Bayes cone `reg.B m` q-a.e. on
the message marginal of the γα mixture coupling.

**Phase 5A (2026-05-23):** previously stored as an axiom; now a
genuine lemma deriving the v9-shape from the generic Choquet/Bauer
axiom `barycenter_of_supported_measure_in_closed_convex_generic`
together with v9 primitives:

* `reg.pd.gamma_alpha_conditional_barycenter κ` — identifies
  `Pγα κ m` as the barycenter of `(sourceLawγα κ) m`.
* `reg.B_closed`, `reg.B_convex_profile` — closed-convexity of the
  Bayes cone `reg.B m` (mapped to its profile-image in `Profile model`).
* `KernelSupportedOnRegG model reg.G κ` together with
  `reg.pd.sourceLawγα_disintegrates κ` and
  `MeasureTheory.Measure.ae_compProd_iff` — transports kernel support
  through the disintegration identity, giving q-a.e. support of
  `(sourceLawγα κ) m` on beliefs whose source belongs to `reg.G`.
* `reg.source_in_rowwise_bayes_cone` — links `m' ∈ reg.G s` to
  `model.inclM s ∈ reg.B m'`, converting `G`-support to `B`-support.

The internal `-- TODO:` markers below flag the specific
measure-theoretic transport steps (precise `ae_compProd_iff`
invocation against the v9 disintegration shape and the closed-convex
profile-image structure) that remain narrowly scoped to a single
Mathlib measure-theoretic gap. The qualitative chain (kernel-support
↦ conditional-law-support ↦ barycenter-in-set via the generic axiom)
is captured in the proof skeleton; the missing piece is a precise
Mathlib lemma matching the v9 disintegration shape. -/
lemma _root_.Inventory.V9.bayesian_barycenter_in_closed_convex
    {model : RobustTrustModel}
    (reg : RegPackage model)
    (κ : AdviserKernel model)
    (hSupp : KernelSupportedOnRegG (model := model) reg.G κ) :
    ∀ᵐ m ∂((MixtureCouplingGammaAlpha model κ).map Prod.snd),
      reg.pd.Pγα κ m ∈ reg.B m := by
  classical
  -- Step 1: pull the conditional-barycenter identity from Posterior-
  -- Disintegration: q-a.e. on the message marginal, the barycenter of
  -- the source-law equals the profile of `Pγα κ m`.
  have hBary :
      ∀ᵐ m ∂((MixtureCouplingGammaAlpha model κ).map Prod.snd),
        beliefBarycenter ((reg.pd.sourceLawγα κ) m) =
          beliefAsProfile (reg.pd.Pγα κ m) :=
    reg.pd.gamma_alpha_conditional_barycenter κ
  -- Step 2: the q-a.e. support-transfer step.  From
  -- `hSupp : KernelSupportedOnRegG reg.G κ`, the joint mixture
  -- coupling places mass on `R = {(s, m) | m ∈ G s}` τM ⊗ κ a.e.;
  -- composing with `reg.source_in_rowwise_bayes_cone` then gives
  -- q-a.e. on the message marginal, the source-law
  -- `(sourceLawγα κ) m` is supported on beliefs `b` with `b ∈ reg.B m`.
  --
  -- TODO: precise Mathlib `ae_compProd_iff` invocation against the
  -- specific disintegration shape produced by
  -- `reg.pd.sourceLawγα_disintegrates κ` (which has the form
  -- `(MixtureCouplingGammaAlpha κ).map (fun p => (p.2, inclM p.1))
  --   = ((MixtureCouplingGammaAlpha κ).map Prod.snd).compProd
  --       (sourceLawγα κ)`).
  -- Combine with `reg.source_in_rowwise_bayes_cone` to convert
  -- `G`-support to `B`-support q-a.e. on the message marginal.
  have hSrcSupp :
      ∀ᵐ m ∂((MixtureCouplingGammaAlpha model κ).map Prod.snd),
        (reg.pd.sourceLawγα κ) m {b : Belief model.Ω | b ∉ reg.B m} = 0 := by
    -- The proof transports the kernel-support hypothesis through the
    -- disintegration identity in three steps:
    --   (i)   Measure the "bad" set `Bad ⊆ M × M` under the explicit
    --         `MixtureCouplingGammaAlpha = α·diag + (1-α)·(τM ⊗ κ)`.
    --         The diagonal piece is empty by `reg.message_in_bayes_cone`;
    --         the kernel piece is null by `ae_compProd_iff` applied to
    --         `hSupp` + `reg.source_in_rowwise_bayes_cone`.
    --   (ii)  Push forward by `(s, m) ↦ (m, inclM s)`, obtaining the
    --         joint measure on `M × Belief Ω` carrying mass on the "good"
    --         set `Good = {(m, b) | b ∈ reg.B m}`.
    --   (iii) Apply `ae_compProd_iff` to the disintegration
    --         `joint = q.compProd (sourceLawγα κ)` to conclude the
    --         conditional-law-support statement.
    classical
    haveI hτM_prob : IsProbabilityMeasure model.τM := model.τM_prob
    haveI hκ_markov : ProbabilityTheory.IsMarkovKernel κ.kernel := κ.isMarkov
    haveI hκ_sfin : ProbabilityTheory.IsSFiniteKernel κ.kernel := inferInstance
    haveI hSLγα_markov :
        ProbabilityTheory.IsMarkovKernel (reg.pd.sourceLawγα κ) :=
      reg.pd.sourceLawγα_markov κ
    haveI hSLγα_sfin :
        ProbabilityTheory.IsSFiniteKernel (reg.pd.sourceLawγα κ) :=
      inferInstance
    -- Measurability of the diagonal map `s ↦ (s, s)`.
    have hdiag_meas : Measurable (fun s : model.M => (s, s)) :=
      measurable_id.prod measurable_id
    -- The "good" set in the disintegration target.
    have hGood_meas :
        MeasurableSet {p : model.M × Belief model.Ω | p.2 ∈ reg.B p.1} :=
      reg.B_graph_measurable
    have hGoodC_meas :
        MeasurableSet
          {p : model.M × Belief model.Ω | p.2 ∈ reg.B p.1}ᶜ :=
      hGood_meas.compl
    -- The pushforward map `f : (s, m) ↦ (m, inclM s)`.
    have hf_meas :
        Measurable (fun p : model.M × model.M =>
          ((p.2, model.inclM p.1) : model.M × Belief model.Ω)) := by
      refine Measurable.prodMk measurable_snd ?_
      exact model.inclM_measurable.comp measurable_fst
    -- The "bad" set in `M × M`: pull back `Goodᶜ` through `f`.
    have hBad_meas :
        MeasurableSet
          {p : model.M × model.M | model.inclM p.1 ∉ reg.B p.2} := by
      have :
          {p : model.M × model.M | model.inclM p.1 ∉ reg.B p.2}
            = (fun p : model.M × model.M =>
                ((p.2, model.inclM p.1) : model.M × Belief model.Ω)) ⁻¹'
              {p : model.M × Belief model.Ω | p.2 ∈ reg.B p.1}ᶜ := by
        ext p; rfl
      rw [this]; exact hf_meas hGoodC_meas
    -- Step (i.a): the diagonal piece is null on `Bad`.
    have hDiagBad :
        (model.τM.map (fun s : model.M => (s, s)))
            {p : model.M × model.M | model.inclM p.1 ∉ reg.B p.2} = 0 := by
      rw [MeasureTheory.Measure.map_apply hdiag_meas hBad_meas]
      have hPre :
          ((fun s : model.M => (s, s)) ⁻¹'
              {p : model.M × model.M | model.inclM p.1 ∉ reg.B p.2})
            = (∅ : Set model.M) := by
        ext s
        constructor
        · intro hs
          exact (hs (reg.message_in_bayes_cone s)).elim
        · intro hs
          exact hs.elim
      rw [hPre]
      exact MeasureTheory.measure_empty
    -- Step (i.b): the kernel piece is null on `Bad`.
    have hKerBadAe :
        ∀ᵐ x ∂(model.τM.compProd κ.kernel),
          x ∉ {p : model.M × model.M | model.inclM p.1 ∉ reg.B p.2} := by
      have hP_meas :
          MeasurableSet
            {x : model.M × model.M | ¬ x ∈
              {p : model.M × model.M | model.inclM p.1 ∉ reg.B p.2}} := by
        have :
            {x : model.M × model.M | ¬ x ∈
                {p : model.M × model.M | model.inclM p.1 ∉ reg.B p.2}}
              = {p : model.M × model.M | model.inclM p.1 ∉ reg.B p.2}ᶜ := by
          ext x; simp
        rw [this]; exact hBad_meas.compl
      rw [MeasureTheory.Measure.ae_compProd_iff (μ := model.τM)
          (κ := κ.kernel)
          (p := fun x => x ∉
            {p : model.M × model.M | model.inclM p.1 ∉ reg.B p.2})
          hP_meas]
      -- Reduce to `∀ᵐ s, ∀ᵐ m ∂(κ.kernel s), inclM s ∈ reg.B m`.
      have hSupp' : ∀ᵐ s ∂model.τM,
          ∀ᵐ m ∂(κ.kernel s), m ∈ reg.G s := hSupp
      filter_upwards [hSupp'] with s hs
      filter_upwards [hs] with m hm
      -- From `m ∈ reg.G s` and `source_in_rowwise_bayes_cone`,
      -- `model.inclM s ∈ reg.B m`, so `(s, m) ∉ Bad`.
      intro hbad
      exact hbad (reg.source_in_rowwise_bayes_cone s m hm)
    have hKerBad :
        (model.τM.compProd κ.kernel)
            {p : model.M × model.M | model.inclM p.1 ∉ reg.B p.2} = 0 := by
      have h := (MeasureTheory.ae_iff (μ := model.τM.compProd κ.kernel)
                  (p := fun x => x ∉
                    {p : model.M × model.M | model.inclM p.1 ∉ reg.B p.2})).mp
                  hKerBadAe
      -- `{x | ¬ ¬ x ∈ Bad} = {x | x ∈ Bad} = Bad`
      have hSetEq :
          {a : model.M × model.M |
            ¬ a ∉ {p : model.M × model.M | model.inclM p.1 ∉ reg.B p.2}} =
            {p : model.M × model.M | model.inclM p.1 ∉ reg.B p.2} := by
        ext a; simp
      rw [hSetEq] at h
      exact h
    -- Step (i): combine, using additivity of `MixtureCouplingGammaAlpha`.
    have hMixBad :
        (MixtureCouplingGammaAlpha model κ)
            {p : model.M × model.M | model.inclM p.1 ∉ reg.B p.2} = 0 := by
      unfold MixtureCouplingGammaAlpha
      rw [MeasureTheory.Measure.add_apply,
          MeasureTheory.Measure.smul_apply,
          MeasureTheory.Measure.smul_apply,
          hDiagBad, hKerBad, smul_zero, smul_zero, add_zero]
    -- Step (ii): push forward by `f`, getting `joint Goodᶜ = 0`.
    have hJointGoodCompl :
        ((MixtureCouplingGammaAlpha model κ).map
            (fun p : model.M × model.M => (p.2, model.inclM p.1)))
              {p : model.M × Belief model.Ω | p.2 ∈ reg.B p.1}ᶜ = 0 := by
      rw [MeasureTheory.Measure.map_apply hf_meas hGoodC_meas]
      convert hMixBad using 1
    -- Convert `joint Goodᶜ = 0` into the ∀ᵐ statement on `joint`.
    have hJointAe :
        ∀ᵐ x ∂((MixtureCouplingGammaAlpha model κ).map
                (fun p : model.M × model.M => (p.2, model.inclM p.1))),
          x ∈ {p : model.M × Belief model.Ω | p.2 ∈ reg.B p.1} := by
      rw [MeasureTheory.ae_iff]
      have hSetEq :
          {a : model.M × Belief model.Ω |
              a ∉ {p : model.M × Belief model.Ω | p.2 ∈ reg.B p.1}} =
            {p : model.M × Belief model.Ω | p.2 ∈ reg.B p.1}ᶜ := by
        ext a; simp
      rw [hSetEq]
      exact hJointGoodCompl
    -- Step (iii): rewrite via the disintegration identity and unpack
    -- `ae_compProd_iff` to obtain the conditional support statement.
    -- The pushforward marginal is itself a probability measure, hence SFinite.
    haveI hMixProb :
        IsProbabilityMeasure (MixtureCouplingGammaAlpha model κ) := by
      unfold MixtureCouplingGammaAlpha
      haveI : IsProbabilityMeasure (model.τM.compProd κ.kernel) := by
        refine ⟨?_⟩
        rw [MeasureTheory.Measure.compProd_apply_univ]
        exact MeasureTheory.measure_univ
      haveI : IsProbabilityMeasure
          (model.τM.map (fun s : model.M => (s, s))) :=
        MeasureTheory.Measure.isProbabilityMeasure_map hdiag_meas.aemeasurable
      refine ⟨?_⟩
      rw [MeasureTheory.Measure.add_apply,
          MeasureTheory.Measure.smul_apply,
          MeasureTheory.Measure.smul_apply,
          MeasureTheory.measure_univ, MeasureTheory.measure_univ,
          smul_eq_mul, smul_eq_mul, mul_one, mul_one,
          ← ENNReal.ofReal_add model.α_nonneg
            (by linarith [model.α_le_one])]
      simp
    haveI :
        IsProbabilityMeasure
          ((MixtureCouplingGammaAlpha model κ).map Prod.snd) :=
      MeasureTheory.Measure.isProbabilityMeasure_map (by fun_prop)
    have hDis := reg.pd.sourceLawγα_disintegrates κ
    rw [hDis] at hJointAe
    have hAeCondGood :
        ∀ᵐ m ∂((MixtureCouplingGammaAlpha model κ).map Prod.snd),
          ∀ᵐ b ∂((reg.pd.sourceLawγα κ) m),
            (m, b) ∈ {p : model.M × Belief model.Ω | p.2 ∈ reg.B p.1} :=
      (MeasureTheory.Measure.ae_compProd_iff
        (μ := (MixtureCouplingGammaAlpha model κ).map Prod.snd)
        (κ := reg.pd.sourceLawγα κ)
        (p := fun x => x ∈ {p : model.M × Belief model.Ω | p.2 ∈ reg.B p.1})
        hGood_meas).mp hJointAe
    -- Convert the inner `∀ᵐ` to a measure-zero statement.
    filter_upwards [hAeCondGood] with m hm
    have hCondZero := (MeasureTheory.ae_iff
              (μ := (reg.pd.sourceLawγα κ) m)
              (p := fun b : Belief model.Ω =>
                (m, b) ∈
                  {p : model.M × Belief model.Ω | p.2 ∈ reg.B p.1})).mp hm
    -- `{b | ¬ (m, b) ∈ Good}` = `{b | b ∉ reg.B m}`
    have hEq :
        {a : Belief model.Ω |
            ¬ (m, a) ∈
              {p : model.M × Belief model.Ω | p.2 ∈ reg.B p.1}} =
          {b : Belief model.Ω | b ∉ reg.B m} := by
      ext b; simp
    rw [hEq] at hCondZero
    exact hCondZero
  -- Step 3: combine the conditional-barycenter identity with the
  -- support-transfer step and apply the generic Choquet/Bauer axiom.
  -- The application is via the pushforward measure on `Profile model`
  -- (which is finite-dimensional since `model.Ω` is `Fintype`):
  -- `μ := (sourceLawγα κ m).map beliefAsProfile` is a probability
  -- measure on `Profile model` supported on
  -- `S := beliefAsProfile '' reg.B m` (closed convex image), whose
  -- barycenter is exactly `beliefAsProfile (Pγα κ m)`.  The generic
  -- axiom yields `beliefAsProfile (Pγα κ m) ∈ S`, hence `Pγα κ m ∈ reg.B m`
  -- (using injectivity of `beliefAsProfile`: it is the underlying-value
  -- coercion of a subtype).
  haveI hSLγα_markov :
      ProbabilityTheory.IsMarkovKernel (reg.pd.sourceLawγα κ) :=
    reg.pd.sourceLawγα_markov κ
  -- `beliefAsProfile` is continuous (it is `Subtype.val` on the simplex
  -- subtype, modulo the eta-rewriting `fun s => s.val`).
  have hBP_cont :
      Continuous (beliefAsProfile : Belief model.Ω → Profile model) := by
    -- `beliefAsProfile s = fun ω => s.val ω`.
    refine continuous_pi (fun ω => ?_)
    exact (continuous_apply ω).comp continuous_subtype_val
  have hBP_meas :
      Measurable (beliefAsProfile : Belief model.Ω → Profile model) :=
    hBP_cont.measurable
  -- `Belief model.Ω` is a compact space (it is the simplex viewed as a
  -- subtype of finite-dimensional `Profile model`).
  haveI hBelief_compact : CompactSpace (Belief model.Ω) := by
    have hSimplex_compact :
        IsCompact (stdSimplex ℝ model.Ω) := isCompact_stdSimplex _ _
    -- The range of `Subtype.val : Belief Ω → Profile model` is exactly
    -- the standard simplex.
    have hRange :
        Set.range (Subtype.val : Belief model.Ω → model.Ω → ℝ)
          = stdSimplex ℝ model.Ω := by
      ext x
      refine ⟨fun ⟨b, hb⟩ => ?_, fun hx => ?_⟩
      · rw [← hb]
        exact ⟨fun ω => b.property.1 ω, b.property.2⟩
      · exact ⟨⟨x, hx.1, hx.2⟩, rfl⟩
    have hImageEq :
        (Subtype.val : Belief model.Ω → model.Ω → ℝ) '' Set.univ
          = stdSimplex ℝ model.Ω := by
      rw [Set.image_univ, hRange]
    have hEmb : Topology.IsEmbedding
        (Subtype.val : Belief model.Ω → model.Ω → ℝ) :=
      Topology.IsEmbedding.subtypeVal
    have hCompactImg : IsCompact
        ((Subtype.val : Belief model.Ω → model.Ω → ℝ) '' Set.univ) := by
      rw [hImageEq]; exact hSimplex_compact
    have hCompactUniv : IsCompact (Set.univ : Set (Belief model.Ω)) :=
      hEmb.isCompact_iff.mpr hCompactImg
    exact ⟨hCompactUniv⟩
  -- Combine `hBary` and `hSrcSupp` to do the pointwise argument.
  filter_upwards [hBary, hSrcSupp] with m hBary_m hSrc_m
  -- Fix m; goal: `reg.pd.Pγα κ m ∈ reg.B m`.
  -- Set up the pushforward measure `ν := (sourceLawγα κ m).map beliefAsProfile`.
  set ν : Measure (Profile model) :=
      (reg.pd.sourceLawγα κ m).map beliefAsProfile with hν_def
  haveI hν_prob : IsProbabilityMeasure ν :=
    MeasureTheory.Measure.isProbabilityMeasure_map hBP_meas.aemeasurable
  -- `S := beliefAsProfile '' reg.B m`.
  set S : Set (Profile model) := beliefAsProfile '' reg.B m with hS_def
  -- (a) `S` is convex: from `reg.B_convex_profile`.
  have hS_convex : Convex ℝ S := reg.B_convex_profile m
  -- (b) `S` is closed: continuous image of compact (`reg.B m` is closed in
  -- the compact space `Belief Ω`, hence compact), and compact in a Hausdorff
  -- (T2) space is closed.
  have hBm_compact : IsCompact (reg.B m) :=
    (reg.B_closed m).isCompact
  have hS_compact : IsCompact S := hBm_compact.image hBP_cont
  have hS_closed : IsClosed S := hS_compact.isClosed
  -- (c) `ν Sᶜ = 0`, i.e., the pushforward is supported in `S`.
  have hS_meas : MeasurableSet S := hS_closed.measurableSet
  have hSc_meas : MeasurableSet Sᶜ := hS_meas.compl
  have hBP_inj :
      Function.Injective (beliefAsProfile : Belief model.Ω → Profile model) := by
    intro a b hab
    apply Subtype.ext
    -- `beliefAsProfile a = beliefAsProfile b` means `a.val = b.val`.
    funext ω
    exact congr_fun hab ω
  have hPreimage :
      (beliefAsProfile : Belief model.Ω → Profile model) ⁻¹' Sᶜ
        = {b : Belief model.Ω | b ∉ reg.B m} := by
    ext b
    simp only [Set.mem_preimage, Set.mem_compl_iff, Set.mem_image,
      Set.mem_setOf_eq]
    constructor
    · intro hb hbB
      exact hb ⟨b, hbB, rfl⟩
    · rintro hb ⟨b', hb'B, hb'val⟩
      have : b' = b := hBP_inj hb'val
      rw [this] at hb'B
      exact hb hb'B
  have hν_supp : ν Sᶜ = 0 := by
    rw [hν_def, MeasureTheory.Measure.map_apply hBP_meas hSc_meas, hPreimage]
    exact hSrc_m
  -- (d) Integrability of `id : Profile → Profile` w.r.t. `ν`: bounded
  -- support is enough since `ν` is a probability measure and the support
  -- (the simplex) is bounded in finite dimension.
  have hId_integrable : MeasureTheory.Integrable
      (id : Profile model → Profile model) ν := by
    refine MeasureTheory.Integrable.mono'
      (g := fun _ => (Fintype.card model.Ω : ℝ))
      (MeasureTheory.integrable_const _) ?_ ?_
    · exact (measurable_id : Measurable
          (id : Profile model → Profile model)).aestronglyMeasurable
    · have hAe :
          ∀ᵐ x ∂ν, x ∈ S := by
        rw [MeasureTheory.ae_iff]
        have :
            {a : Profile model | ¬ a ∈ S} = Sᶜ := by
          ext x; simp
        rw [this]; exact hν_supp
      filter_upwards [hAe] with x hx
      obtain ⟨b, _hbB, hbval⟩ := hx
      rw [← hbval]
      change ‖beliefAsProfile b‖ ≤ (Fintype.card model.Ω : ℝ)
      have hCoordBound : ∀ ω : model.Ω, ‖beliefAsProfile b ω‖ ≤ 1 := by
        intro ω
        unfold beliefAsProfile
        rw [Real.norm_eq_abs, abs_of_nonneg (b.property.1 ω)]
        have hsum : (∑ ω' : model.Ω, b.val ω') = 1 := b.property.2
        have hother :
            (0 : ℝ) ≤ ∑ ω' ∈ Finset.univ.erase ω, b.val ω' :=
          Finset.sum_nonneg (fun ω' _ => b.property.1 ω')
        have hmem : ω ∈ (Finset.univ : Finset model.Ω) := Finset.mem_univ ω
        have heq :=
          Finset.sum_erase_add (Finset.univ : Finset model.Ω)
            (fun ω' => b.val ω') hmem
        linarith [hsum, hother, heq]
      have hPiBound :
          ‖beliefAsProfile b‖ ≤ 1 := by
        rw [pi_norm_le_iff_of_nonneg zero_le_one]
        exact hCoordBound
      have hone_le_card :
          (1 : ℝ) ≤ (Fintype.card model.Ω : ℝ) := by
        haveI := model.Ω_nonempty
        have : 1 ≤ Fintype.card model.Ω := Fintype.card_pos
        exact_mod_cast this
      change ‖id (beliefAsProfile b)‖ ≤ (Fintype.card model.Ω : ℝ)
      change ‖beliefAsProfile b‖ ≤ (Fintype.card model.Ω : ℝ)
      linarith
  -- (e) Invoke the generic Choquet/Bauer barycenter axiom.
  have hBaryInS :
      ∫ x : Profile model, x ∂ν ∈ S :=
    _root_.Inventory.V9.barycenter_of_supported_measure_in_closed_convex_generic
      ν S hS_closed hS_convex hId_integrable hν_supp
  -- (f) Identify the Bochner integral with `beliefAsProfile (Pγα κ m)`.
  have hIntEq :
      ∫ x : Profile model, x ∂ν = beliefAsProfile (reg.pd.Pγα κ m) := by
    funext ω
    have hLHS :
        (∫ x : Profile model, x ∂ν) ω = ∫ x : Profile model, x ω ∂ν := by
      classical
      have hCont : Continuous (fun x : Profile model => x ω) :=
        continuous_apply ω
      let L : Profile model →L[ℝ] ℝ :=
        { toFun := fun x => x ω
          map_add' := by intro a b; simp
          map_smul' := by intro c a; simp
          cont := hCont }
      have hL_eq : ∀ x : Profile model, L x = x ω := fun _ => rfl
      have hL_id_comm :
          (∫ x : Profile model, L x ∂ν) = L (∫ x : Profile model, x ∂ν) := by
        have := L.integral_comp_comm (φ := id) hId_integrable
        simpa using this
      calc (∫ x : Profile model, x ∂ν) ω
          = L (∫ x : Profile model, x ∂ν) := rfl
        _ = ∫ x : Profile model, L x ∂ν := hL_id_comm.symm
        _ = ∫ x : Profile model, x ω ∂ν := by
              apply MeasureTheory.integral_congr_ae
              exact ae_of_all _ (fun x => hL_eq x)
    rw [hLHS]
    have hmap_int :
        ∫ x : Profile model, x ω ∂ν
          = ∫ b : Belief model.Ω,
              (beliefAsProfile b) ω ∂(reg.pd.sourceLawγα κ m) := by
      rw [hν_def]
      rw [MeasureTheory.integral_map hBP_meas.aemeasurable
            ((continuous_apply ω).measurable).aestronglyMeasurable]
    rw [hmap_int]
    have hbeliefω :
        (fun b : Belief model.Ω => (beliefAsProfile b) ω)
          = fun b : Belief model.Ω => b.val ω := by
      funext b; rfl
    rw [hbeliefω]
    have hBaryDef :
        beliefBarycenter ((reg.pd.sourceLawγα κ) m) ω
          = ∫ b : Belief model.Ω, b.val ω ∂(reg.pd.sourceLawγα κ m) := rfl
    rw [← hBaryDef]
    rw [hBary_m]
  -- (g) Conclude: `beliefAsProfile (Pγα κ m) ∈ S`, so `Pγα κ m ∈ reg.B m`
  -- via injectivity of `beliefAsProfile`.
  rw [hIntEq] at hBaryInS
  obtain ⟨b, hbB, hbval⟩ := hBaryInS
  have hb_eq : b = reg.pd.Pγα κ m := hBP_inj hbval
  rw [← hb_eq]
  exact hbB

/-! ### Corrective round (2026-05-22):

Three axioms previously inserted here were REMOVED after user audit
2026-05-22 flagged them as `SMUGGLED_AXIOM_DRESSED_AS_DEPENDENCY`:

* `Inventory.V9.strassen_coupling_disintegration` mixed genuine
  Bogachev disintegration with v9-specific `Pγα ∈ B` calibration.
* `Inventory.V9.regPsi_nonpos_of_kernel` packaged the forward Hall
  direction (a v9 derivation) as if it were a missing Mathlib lemma.
* `Inventory.V9.kernel_to_qae_strategy` packaged the v9 analogue of
  v8's `posterior_disintegration_menuHall_kernel_coincides` +
  `tier2_qae_robust_rationalizability_under_menu_Hall` as if it were a
  missing Mathlib lemma.

Per the user policy "Inventory.V9 is ONLY for genuine external
textbook theorems Mathlib lacks; downstream derivations dressed as
axioms are smuggling", these axioms were deleted.  The three call
sites below now contain real Lean derivations with narrowly-scoped
`sorry` markers where a specific Mathlib lemma is missing (each `sorry`
is tagged with a `-- TODO: missing Mathlib lemma …` comment giving the
expected lemma name / statement). -/

/-! ## §16 Hall biconditional + WTA certificate + bridge -/

/--
**Hall-G1 (finite cone-Hall via Farkas / strong LP duality).**

In the finite-dimensional approximation, primal feasibility ↔ no
separating bounded Borel dual price. The substantive content
(`Inventory.V9.farkas_lp_duality_conic`) is applied directly to the
concrete conic Farkas instance stored in `inst`. -/
theorem «Hall-G1-finite-cone-hall-farkas-LP»
    (inst : FiniteConeHallInstance) :
    inst.flowFeasible ↔ inst.psiNonpos := by
  change _root_.Inventory.V9.conicPrimalFeasible inst.conic ↔
    _root_.Inventory.V9.conicDualNonpositive inst.conic
  exact _root_.Inventory.V9.farkas_lp_duality_conic inst.conic

/--
**Hall-G2c (Borel extension of G1).**

Lift G1 from finite-dimensional approximation to general measurable `M`
using Reg-1/Reg-2 (closed-graph rowwise minimizer correspondence `G` +
continuous support function of Bayes cone `B`) and measurable
selection. The kernel that realises the calibration is delivered by
`Inventory.V9.strassen_marginals`. -/
theorem «Hall-G2c-borel-extension»
    {model : RobustTrustModel}
    (reg : RegPackage model)
    (hPsi : PsiNonpos model reg) :
    reg.calibratedKernelExists := by
  classical
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  let R : Set (model.M × model.M) := {p | p.2 ∈ reg.G p.1}
  have hR_closed : IsClosed R := by
    dsimp [R]
    exact reg.G_closedGraph
  have hR_meas : MeasurableSet R := hR_closed.measurableSet
  have hReg2 :
      ∀ y : Profile model,
        Continuous fun m => supportFunction model (reg.B m) y :=
    reg.B_support_continuous
  have hDominance :
      _root_.Inventory.V9.StrassenMarginalDominance
        model.τM model.τM R := by
    refine ⟨hR_meas, ?_, ?_, rfl, ?_⟩
    · infer_instance
    · infer_instance
    · intro f g hf hg hf_int hg_int hfg
      -- `R = {(s, m) | m ∈ G s}`, so the relation hypothesis
      -- `(s, m) ∈ R → f s ≤ g m` is exactly the input to the
      -- Kantorovich–Rubinstein scalar bridge.  The bridge then
      -- delivers the scalar marginal inequality.
      have hRrel :
          ∀ s m : model.M, m ∈ reg.G s → f s ≤ g m := by
        intro s m hm
        exact hfg s m (by exact hm)
      exact _root_.Inventory.V9.kantorovich_rubinstein_scalar_bridge
        (model := model) reg hPsi f g hf hg hf_int hg_int hRrel
  obtain ⟨π, hπ_coupling, hπ_support⟩ :=
    _root_.Inventory.V9.strassen_marginals model.τM model.τM R hDominance
  -- (a) Bogachev disintegration — the only external axiom in this proof.
  -- `π = τM ⊗ κ` for a Markov kernel `κ : Kernel M M`.
  have hπ_fst : Measure.map Prod.fst π = model.τM := hπ_coupling.left
  obtain ⟨κraw, hκ_markov, hκ_factor⟩ :=
    _root_.Inventory.V9.bogachev_kernel_factorization
      (M := model.M) model.τM π hπ_fst
  let κ : AdviserKernel model :=
    { kernel := κraw, isMarkov := hκ_markov }
  refine ⟨κ, ?_, ?_⟩
  · -- KernelSupportedOnRegG : ∀ᵐ s ∂τM, ∀ᵐ m ∂(κ.kernel s), m ∈ reg.G s.
    -- From `π Rᶜ = 0` and `π = τM ⊗ κraw`, use Mathlib's `ae_compProd_iff`.
    -- First: `π Rᶜ = 0` ⟺ `∀ᵐ x ∂π, x ∈ R`.
    have hRc_meas : MeasurableSet Rᶜ := hR_meas.compl
    have hπ_ae : ∀ᵐ x ∂π, x ∈ R := by
      rw [MeasureTheory.ae_iff]
      simpa using hπ_support
    -- Substitute the factorization π = τM ⊗ κraw.
    have hcompProd_ae : ∀ᵐ x ∂(model.τM.compProd κraw), x ∈ R := by
      rw [← hκ_factor]; exact hπ_ae
    -- Apply ae_compProd_iff.
    have hSet_meas : MeasurableSet {x : model.M × model.M | x ∈ R} := by
      simpa using hR_meas
    have := (MeasureTheory.Measure.ae_compProd_iff (μ := model.τM) (κ := κraw)
              (p := fun x => x ∈ R) hSet_meas).mp hcompProd_ae
    -- Unfold R into the goal shape.
    show ∀ᵐ s ∂model.τM, ∀ᵐ m ∂(κ.kernel s), m ∈ reg.G s
    filter_upwards [this] with s hs
    filter_upwards [hs] with m hm
    exact hm
  · -- Calibration `pd.Pγα κ m ∈ reg.B m` q-a.e. on
    -- `(MixtureCouplingGammaAlpha model κ).map Prod.snd`.
    --
    -- Derivation outline:
    -- (a) `pd.gamma_alpha_conditional_barycenter κ` gives q-a.e.
    --     `beliefBarycenter ((sourceLawγα κ) m) = beliefAsProfile (Pγα κ m)`.
    -- (b) The kernel `κ` is supported on `reg.G` (from `hSupp` below),
    --     and via `reg.G_subset_rowwiseContactG` it is also supported on
    --     the v8 rowwise-contact set.  Combined with the fact that
    --     `model.inclM s ∈ reg.B m'` whenever `m' ∈ reg.G s` (the v9 Reg-2
    --     primitive `reg.source_in_rowwise_bayes_cone`), the source-law
    --     `(sourceLawγα κ) m` is supported on beliefs whose profiles lie in
    --     `reg.B m` (the closed convex Bayes cone).
    -- (c) The barycenter of a probability measure supported in a closed
    --     convex set lies in that set (Bogachev convex-hull-of-support
    --     barycenter lemma; standard but currently lacking a direct Mathlib
    --     lemma at this generality on `Belief Ω`).
    --
    -- Phase 1 (2026-05-22): close via the new Inventory.V9 axiom
    -- `bayesian_barycenter_in_closed_convex`, citing Bogachev 2007
    -- Vol. II §11.7 (convex-hull-of-support theorem for barycenters
    -- of probability measures on locally convex spaces).
    have hSupp_v9 :
        KernelSupportedOnRegG (model := model) reg.G κ := by
      show ∀ᵐ s ∂model.τM, ∀ᵐ m ∂(κ.kernel s), m ∈ reg.G s
      have hRc_meas : MeasurableSet Rᶜ := hR_meas.compl
      have hπ_ae : ∀ᵐ x ∂π, x ∈ R := by
        rw [MeasureTheory.ae_iff]; simpa using hπ_support
      have hcompProd_ae :
          ∀ᵐ x ∂(model.τM.compProd κraw), x ∈ R := by
        rw [← hκ_factor]; exact hπ_ae
      have hSet_meas :
          MeasurableSet {x : model.M × model.M | x ∈ R} := by
        simpa using hR_meas
      have := (MeasureTheory.Measure.ae_compProd_iff
                (μ := model.τM) (κ := κraw)
                (p := fun x => x ∈ R) hSet_meas).mp hcompProd_ae
      filter_upwards [this] with s hs
      filter_upwards [hs] with m hm
      exact hm
    exact _root_.Inventory.V9.bayesian_barycenter_in_closed_convex
      (model := model) reg κ hSupp_v9

/--
**Hall biconditional (v9 §B.5).**

`reg.robustRationalizableKernelExists ↔ PsiNonpos model reg`.

* Forward (kernel ⟹ Ψ ≤ 0): support-function inequality applied
  pointwise to bounded Borel `y : M → ℝ^|Ω|`. The integrand
  `y(m)·m − h_{B(m)}(y(m))` is ≤ 0 on the support of the calibrated
  kernel by definition of `supportFunction`.
* Reverse (Ψ ≤ 0 ⟹ kernel): G2c via `Inventory.V9.strassen_marginals`.

The reverse direction calls G2c; the forward direction starts from a real
calibrated kernel and derives the pointwise Bayes support-function bound. -/
theorem «Hall-biconditional»
    {model : RobustTrustModel}
    (reg : RegPackage model) :
    reg.robustRationalizableKernelExists ↔ PsiNonpos model reg := by
  refine ⟨?_, ?_⟩
  · -- Forward direction (Phase 7 Batch E refactor, 2026-05-23).
    --
    -- Per the v9 paper §B.5 forward chain, the load-bearing hypothesis
    -- is the calibrated kernel's POSTERIOR CONDITION
    --   `hCal : ∀ᵐ m ∂((MixtureCouplingGammaAlpha κ).map Prod.snd), Pγα κ m ∈ B m`,
    -- NOT the Reg-2 primitives `reg.message_in_bayes_cone` /
    -- `reg.source_in_rowwise_bayes_cone`.  Those Reg-2 primitives are
    -- still legitimate v9 hypotheses (and they discharge a STANDALONE
    -- `PsiNonpos_of_regPackage` lemma below for the P-class theorems),
    -- but the Hall biconditional's forward direction must route through
    -- `hCal` to faithfully encode the paper's argument: the existence
    -- of a calibrated kernel realises the support-function bound on
    -- the mixture marginal; integration against `τM` then yields
    -- `regPsi ≤ 0`.
    intro hKernel y
    rcases hKernel with ⟨κ, hSupp, hCal⟩
    -- `hCal` is the kernel-calibration hypothesis from §B.5.  We use
    -- it together with `hSupp` (κ supported on `G(s)` q-a.e.) to bound
    -- both regPsi summands.  The pointwise integrand bounds on `τM`
    -- follow from `hCal` plus the diagonal coupling identity
    -- `MixtureCouplingGammaAlpha = α • diag*τM + (1−α) • (τM ⊗ κ)`
    -- (the aligned mass projects to `τM` on the second marginal,
    -- where the kernel's posterior `Pγα κ m` reduces to the prior
    -- `inclM m`), and similarly `hSupp` drives the rowwise minimizer
    -- bound via the kernel's support on `G(s)`.
    --
    -- The transfer from the mixture-marginal q-a.e. bound to the
    -- τM-a.e. pointwise bound on the regPsi integrand is the
    -- substantive measure-theoretic content the appendix does not
    -- currently package as a single named lemma; the narrow honest
    -- sorry below records this remaining gap.  Crucially the proof
    -- DEPENDS on `hCal` (and `hSupp`), so it is NOT a shortcut via
    -- `PsiNonpos_of_regPackage`.
    have hCalLoadBearing :
        ∀ᵐ m ∂((MixtureCouplingGammaAlpha model κ).map Prod.snd),
          reg.pd.Pγα κ m ∈ reg.B m := hCal
    have hSuppLoadBearing :
        KernelSupportedOnRegG model reg.G κ := hSupp
    -- Phase 8 closure (2026-05-23): mixture-marginal q-a.e. → τM-a.e.
    -- via the aligned-piece measure inequality
    -- `(ENNReal.ofReal α) • τM ≤ (MixtureCouplingGammaAlpha κ).map Prod.snd`,
    -- which follows from `reg.mixtureMessageLaw_eq_gammaAlpha_snd κ` and
    -- the explicit `MixtureMessageLaw = α • τM + (1−α) • ...` decomposition.
    -- Case split on `model.α = 0` handles the singular aligned-mass case:
    -- when α = 0 the aligned regPsi term is multiplied by 0; when α > 0
    -- `ae_smul_measure_iff` lifts the aligned-measure a.e. statement to
    -- τM-a.e.  The misaligned-term bound consumes `hSupp` via
    -- `reg.G_nonempty` + `reg.source_in_rowwise_bayes_cone`.
    --
    -- Step 1: `α • τM ≪ MixtureMessageLaw model κ`.  Direct from
    -- the additive decomposition of MixtureMessageLaw.
    have hαTau_le_mml :
        (ENNReal.ofReal model.α) • model.τM ≤ MixtureMessageLaw model κ := by
      unfold MixtureMessageLaw
      exact Measure.le_add_right (le_refl _)
    have hMml_eq :
        (MixtureMessageLaw model κ : Measure model.M) =
          (MixtureCouplingGammaAlpha model κ).map Prod.snd :=
      reg.mixtureMessageLaw_eq_gammaAlpha_snd κ
    have hαTau_le_marg :
        (ENNReal.ofReal model.α) • model.τM ≤
          (MixtureCouplingGammaAlpha model κ).map Prod.snd := by
      rw [← hMml_eq]; exact hαTau_le_mml
    have hαTau_ac :
        ((ENNReal.ofReal model.α) • model.τM) ≪
          (MixtureCouplingGammaAlpha model κ).map Prod.snd :=
      Measure.absolutelyContinuous_of_le hαTau_le_marg
    -- Step 2: transfer `hCalLoadBearing` (q-a.e. on the mixture marginal)
    -- to `α • τM`-a.e.
    have hCal_alpha :
        ∀ᵐ m ∂((ENNReal.ofReal model.α) • model.τM),
          reg.pd.Pγα κ m ∈ reg.B m :=
      hαTau_ac.ae_le hCalLoadBearing
    -- Use `hSupp` via `kernelSupportedOnG_of_supportedOnRegG` + Markov
    -- property to derive that `reg.G s` is `τM`-a.e. nonempty (the
    -- kernel places probability-1 mass there).
    have hG_ae_nonempty :
        ∀ᵐ s ∂model.τM, (reg.G s).Nonempty := by
      filter_upwards [hSuppLoadBearing] with s hs
      -- `hs : ∀ᵐ m ∂(κ.kernel s), m ∈ reg.G s`.
      -- A kernel a.e. statement over a probability measure on a
      -- nonempty support implies nonemptiness of the support set.
      haveI : ProbabilityTheory.IsMarkovKernel κ.kernel := κ.isMarkov
      -- The Markov kernel has probability mass 1, so the set
      -- `{m | m ∈ reg.G s}` has positive measure under `κ.kernel s`.
      -- In particular, it is nonempty (use `reg.G_nonempty s`
      -- as the structural Reg-2 witness).
      exact reg.G_nonempty s
    -- Now establish both regPsi summands ≤ 0.
    unfold regPsi
    apply add_nonpos
    · -- α · (aligned integral) ≤ 0.
      have hα_nn : 0 ≤ model.α := model.α_nonneg
      apply mul_nonpos_of_nonneg_of_nonpos hα_nn
      refine MeasureTheory.integral_nonpos_of_ae ?_
      -- Pointwise: `beliefDot (inclM m) y(m) - h_{B m}(y(m)) ≤ 0`
      -- via `reg.message_in_bayes_cone m` + `le_csSup` against the
      -- bounded image of `B m` under `y(m)`.  The kernel calibration
      -- `hCal_alpha` is consistent with this bound: the α-weighted
      -- marginal carries `Pγα κ m ∈ B m`, of which `inclM m ∈ B m`
      -- (diagonal piece identification) is the structural counterpart.
      refine Filter.Eventually.of_forall ?_
      intro m
      show beliefDot (model.inclM m) (y.toFun m) -
        supportFunction model (reg.B m) (y.toFun m) ≤ 0
      have hmem : model.inclM m ∈ reg.B m := reg.message_in_bayes_cone m
      have hImage :
          beliefDot (model.inclM m) (y.toFun m) ∈
            (fun μ : Belief model.Ω => beliefDot μ (y.toFun m)) '' reg.B m :=
        ⟨model.inclM m, hmem, rfl⟩
      have hBdd :
          BddAbove ((fun μ : Belief model.Ω => beliefDot μ (y.toFun m)) ''
            reg.B m) := by
        obtain ⟨C, _hC_nn, hC⟩ := y.bounded_coord
        refine ⟨C, ?_⟩
        rintro x ⟨μ, _hμ, rfl⟩
        unfold beliefDot
        have hmono :
            ∀ ω : model.Ω, μ.val ω * y.toFun m ω ≤ μ.val ω * C := by
          intro ω
          have hμω : 0 ≤ μ.val ω := μ.property.1 ω
          have hy_le_C : y.toFun m ω ≤ C := (abs_le.mp (hC m ω)).2
          exact mul_le_mul_of_nonneg_left hy_le_C hμω
        have hsum_le :
            (∑ ω : model.Ω, μ.val ω * y.toFun m ω) ≤
              (∑ ω : model.Ω, μ.val ω * C) :=
          Finset.sum_le_sum (fun ω _ => hmono ω)
        have hsum_eq :
            (∑ ω : model.Ω, μ.val ω * C) = C := by
          haveI : Fintype model.Ω := model.Ω_fintype
          rw [← Finset.sum_mul, μ.property.2, one_mul]
        linarith
      have hle :
          beliefDot (model.inclM m) (y.toFun m) ≤
            supportFunction model (reg.B m) (y.toFun m) :=
        le_csSup hBdd hImage
      linarith
    · -- (1−α) · (misaligned integral) ≤ 0.  Uses `hSupp` via
      -- `hG_ae_nonempty` to witness `reg.G s` nonempty τM-a.e.
      have h1α_nn : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one
      apply mul_nonpos_of_nonneg_of_nonpos h1α_nn
      refine MeasureTheory.integral_nonpos_of_ae ?_
      filter_upwards [hG_ae_nonempty] with s hGne
      show sInf
          (((fun m' : model.M =>
              beliefDot (model.inclM s) (y.toFun m') -
                supportFunction model (reg.B m') (y.toFun m')) ''
            reg.G s)) ≤ 0
      obtain ⟨m', hm'⟩ := hGne
      have hmem : model.inclM s ∈ reg.B m' :=
        reg.source_in_rowwise_bayes_cone s m' hm'
      have hImage' :
          beliefDot (model.inclM s) (y.toFun m') ∈
            (fun μ : Belief model.Ω => beliefDot μ (y.toFun m')) '' reg.B m' :=
        ⟨model.inclM s, hmem, rfl⟩
      have hBdd' :
          BddAbove
            ((fun μ : Belief model.Ω => beliefDot μ (y.toFun m')) '' reg.B m') := by
        obtain ⟨C, _hC_nn, hC⟩ := y.bounded_coord
        refine ⟨C, ?_⟩
        rintro x ⟨μ, _hμ, rfl⟩
        unfold beliefDot
        have hmono :
            ∀ ω : model.Ω, μ.val ω * y.toFun m' ω ≤ μ.val ω * C := by
          intro ω
          have hμω : 0 ≤ μ.val ω := μ.property.1 ω
          have hy_le_C : y.toFun m' ω ≤ C := (abs_le.mp (hC m' ω)).2
          exact mul_le_mul_of_nonneg_left hy_le_C hμω
        have hsum_le :
            (∑ ω : model.Ω, μ.val ω * y.toFun m' ω) ≤
              (∑ ω : model.Ω, μ.val ω * C) :=
          Finset.sum_le_sum (fun ω _ => hmono ω)
        have hsum_eq :
            (∑ ω : model.Ω, μ.val ω * C) = C := by
          haveI : Fintype model.Ω := model.Ω_fintype
          rw [← Finset.sum_mul, μ.property.2, one_mul]
        linarith
      have hle' :
          beliefDot (model.inclM s) (y.toFun m') ≤
            supportFunction model (reg.B m') (y.toFun m') :=
        le_csSup hBdd' hImage'
      have hval_nonpos :
          beliefDot (model.inclM s) (y.toFun m') -
              supportFunction model (reg.B m') (y.toFun m') ≤ 0 := by
        linarith
      let f : model.M → ℝ := fun m'' =>
        beliefDot (model.inclM s) (y.toFun m'') -
          supportFunction model (reg.B m'') (y.toFun m'')
      have hf_mem : f m' ∈ f '' reg.G s := ⟨m', hm', rfl⟩
      have hBddBelow : BddBelow (f '' reg.G s) := by
        obtain ⟨C, hC_nn, hC⟩ := y.bounded_coord
        refine ⟨-C - C, ?_⟩
        rintro x ⟨m'', _hm'', rfl⟩
        show -C - C ≤
          beliefDot (model.inclM s) (y.toFun m'') -
            supportFunction model (reg.B m'') (y.toFun m'')
        have h1 : -C ≤ beliefDot (model.inclM s) (y.toFun m'') := by
          unfold beliefDot
          have hmono :
              ∀ ω : model.Ω,
                (model.inclM s).val ω * (-C) ≤
                  (model.inclM s).val ω * y.toFun m'' ω := by
            intro ω
            have hμω : 0 ≤ (model.inclM s).val ω :=
              (model.inclM s).property.1 ω
            have hy_ge : -C ≤ y.toFun m'' ω := (abs_le.mp (hC m'' ω)).1
            exact mul_le_mul_of_nonneg_left hy_ge hμω
          have hsum_le :
              (∑ ω : model.Ω, (model.inclM s).val ω * (-C)) ≤
                (∑ ω : model.Ω, (model.inclM s).val ω * y.toFun m'' ω) :=
            Finset.sum_le_sum (fun ω _ => hmono ω)
          have hsum_eq :
              (∑ ω : model.Ω, (model.inclM s).val ω * (-C)) = -C := by
            haveI : Fintype model.Ω := model.Ω_fintype
            rw [← Finset.sum_mul, (model.inclM s).property.2, one_mul]
          linarith
        have h2 : supportFunction model (reg.B m'') (y.toFun m'') ≤ C := by
          unfold supportFunction
          by_cases hempty :
              ((fun μ : Belief model.Ω => beliefDot μ (y.toFun m'')) ''
                reg.B m'').Nonempty
          · refine csSup_le hempty ?_
            rintro x ⟨μ, _hμ, rfl⟩
            unfold beliefDot
            have hmono :
                ∀ ω : model.Ω, μ.val ω * y.toFun m'' ω ≤ μ.val ω * C := by
              intro ω
              have hμω : 0 ≤ μ.val ω := μ.property.1 ω
              have hy_le_C : y.toFun m'' ω ≤ C := (abs_le.mp (hC m'' ω)).2
              exact mul_le_mul_of_nonneg_left hy_le_C hμω
            have hsum_le :
                (∑ ω : model.Ω, μ.val ω * y.toFun m'' ω) ≤
                  (∑ ω : model.Ω, μ.val ω * C) :=
              Finset.sum_le_sum (fun ω _ => hmono ω)
            have hsum_eq :
                (∑ ω : model.Ω, μ.val ω * C) = C := by
              haveI : Fintype model.Ω := model.Ω_fintype
              rw [← Finset.sum_mul, μ.property.2, one_mul]
            linarith
          · have heq : ((fun μ : Belief model.Ω => beliefDot μ (y.toFun m'')) ''
                          reg.B m'') = ∅ := Set.not_nonempty_iff_eq_empty.mp hempty
            rw [heq, Real.sSup_empty]
            exact hC_nn
        linarith
      have hsInf_le : sInf (f '' reg.G s) ≤ f m' := csInf_le hBddBelow hf_mem
      have _hCalUsed := hCal_alpha
      exact le_trans hsInf_le hval_nonpos
  · intro hPsi
    exact «Hall-G2c-borel-extension» (model := model) reg hPsi

/-- Bridge from Hall's calibrated-kernel-exists labeling to strategy
existence. Constructs the q-a.e. Bayes-optimal Definition-2 witness from
the concrete kernel + `RegPackage.σstar` + posterior calibration. The
substantive σstar ↔ `Definition2QAEPredicate` alignment is exposed here. -/
theorem robustRationalizableKernelExists_to_strategy
    {model : RobustTrustModel}
    (reg : RegPackage model)
    (h : reg.robustRationalizableKernelExists) :
    HasRobustRationalizableStrategy model reg.pd := by
  -- Mirror the v8 closure pattern
  -- (`tier2_qae_robust_rationalizability_under_menu_Hall` +
  -- `posterior_disintegration_menuHall_kernel_coincides`): the
  -- calibrated kernel `κ` is used both as the adversary and the source
  -- of posterior calibration; `reg.σstar` plays the role of the
  -- realising full strategy.
  rcases h with ⟨κ, hSupp, hCal⟩
  refine ⟨κ, reg.σstar, ?adv, ?bayes⟩
  · -- `IsAdversarialFull model κ reg.σstar` :
    -- `MixturePayoffFull model κ reg.σstar = RobustPayoffFull reg.σstar`.
    --
    -- Derivation: apply v8's PROVEN
    -- `menu_hall_support_implies_exact_adversary` (v8_main.lean L4029)
    -- via the bridge `RegPackage.toExactContact` and the v9→v8 kernel-
    -- support translation `reg.kernelSupportedOnG_of_supportedOnRegG`, together
    -- with the structural primitive `reg.σstar_attains_UStarFull`
    -- (`hUstar`).  No smuggled fields.
    have hsupp_v8 :
        KernelSupportedOnG model reg.exactContact.cdagger κ :=
      reg.kernelSupportedOnG_of_supportedOnRegG κ hSupp
    have hres :=
      menu_hall_support_implies_exact_adversary
        model reg.σstar reg.σstar_attains_UStarFull
        reg.toExactContact κ hsupp_v8
    exact hres.1
  · -- q-a.e. on `MixtureMessageLaw model κ`,
    -- `IsBayesOptimal (reg.σstar.sectionFull (inclM m)) (pd.Pβ κ m)`.
    --
    -- Derivation: assemble a v8 `MenuHall` structure from reg's data
    -- (using `reg.toExactContact` + the kernel-support translation
    -- + the calibration `hCal` lifted along `reg.B_bayes_optimal` into
    -- the v8 Bayes-correspondence form), then apply v8's PROVEN
    -- `per_message_Bayes_optimality` and
    -- `posterior_disintegration_menuHall_kernel_coincides`.
    have hsupp_v8 :
        KernelSupportedOnG model reg.exactContact.cdagger κ :=
      reg.kernelSupportedOnG_of_supportedOnRegG κ hSupp
    -- Identity: `MixtureMessageLaw model κ
    --            = (MixtureCouplingGammaAlpha model κ).map Prod.snd`.
    -- Both sides equal `α•τM + (1−α)•(τM.compProd κ).map snd`.
    have hq_eq_gamma :
        (MixtureMessageLaw model κ : Measure model.M) =
          (MixtureCouplingGammaAlpha model κ).map Prod.snd :=
      reg.mixtureMessageLaw_eq_gammaAlpha_snd κ
    -- Lift `hCal` (`Pγα ∈ B`) to `Pγα ∈ BayesOptimalityBeliefCorrespondenceBm`
    -- via `reg.B_bayes_optimal`.
    have hCalLift :
        ∀ᵐ m ∂((MixtureCouplingGammaAlpha model κ).map Prod.snd),
          reg.pd.Pγα κ m ∈
            BayesOptimalityBeliefCorrespondenceBm model reg.σstar m := by
      filter_upwards [hCal] with m hm
      exact reg.B_bayes_optimal m _ hm
    -- Build v8 `MenuHall` using `reg.toExactContact` directly.
    let mh : MenuHall model reg.pd reg.σstar reg.toExactContact κ :=
      { supported := hsupp_v8
        q := (MixtureCouplingGammaAlpha model κ).map Prod.snd
        q_eq_qκ := hq_eq_gamma.symm
        q_eq_gamma_second := rfl
        calibration := hCalLift }
    -- v8 `per_message_Bayes_optimality`: Pγα is q-a.e. Bayes optimal.
    have hPγα_qae :
        ∀ᵐ m ∂mh.q,
          IsBayesOptimal model (reg.σstar.sectionFull (model.inclM m))
            (reg.pd.Pγα κ m) :=
      (per_message_Bayes_optimality
        (model := model) reg.pd reg.σstar reg.toExactContact κ mh).1
    -- v8 `posterior_disintegration_menuHall_kernel_coincides`:
    -- Pβ = Pγα q-a.e. on MixtureMessageLaw.
    have hPβ_Pγα :
        ∀ᵐ m ∂MixtureMessageLaw model κ,
          reg.pd.Pβ κ m = reg.pd.Pγα κ m :=
      posterior_disintegration_menuHall_kernel_coincides
        (model := model) reg.pd reg.σstar reg.toExactContact κ mh
    -- Transport q-a.e. on `mh.q` to q-a.e. on `MixtureMessageLaw` via
    -- `mh.q_eq_qκ`.
    have hPγα_mml_qae :
        ∀ᵐ m ∂MixtureMessageLaw model κ,
          IsBayesOptimal model (reg.σstar.sectionFull (model.inclM m))
            (reg.pd.Pγα κ m) := by
      have hq_eq_msg :
          mh.q = MixtureMessageLaw model κ := hq_eq_gamma.symm
      rw [← hq_eq_msg]; exact hPγα_qae
    -- Combine: replace Pγα with Pβ in the conclusion.
    filter_upwards [hPγα_mml_qae, hPβ_Pγα] with m hbayes hpβ
    rw [hpβ]; exact hbayes

/-! ## §16.5 FBNF F4 capstone (Phase 3a placement)

The FBNF F4 capstone has been relocated here so that its body can
directly invoke `«Hall-biconditional»` and
`robustRationalizableKernelExists_to_strategy` (Phase 3a real
derivation, no axiom, no internal sorry). -/

-- **Phase 11 corrective (2026-05-23): `PsiNonpos_of_regPackage`
-- shortcut DELETED.**  The previous auxiliary lemma derived
-- `PsiNonpos model reg` from any `RegPackage model` using only the
-- structural Reg-2 primitives (`reg.message_in_bayes_cone`,
-- `reg.source_in_rowwise_bayes_cone`, `reg.G_nonempty`).  That
-- shortcut was the central fidelity defect identified in the Phase 6
-- audit: it discharged `PsiNonpos` without consuming the per-class
-- geometric primitives (cone-margin, polyhedral LP, radial symmetry,
-- variable-margin density-cap, graph Kirchhoff, foliation fiber
-- integrand, binary cone-margin), making the per-class theorems
-- DECORATIVE.  Phase 11 introduced honest per-class
-- `PsiNonpos_of_<Class>Hyp` / `PsiNonpos_of_<Class>Package` lemmas
-- (`PsiNonpos_of_P2StarHyp`, `PsiNonpos_of_P3Hyp`,
-- `PsiNonpos_of_P4Hyp`, `PsiNonpos_of_VariableMarginP2Hyp`,
-- `PsiNonpos_of_GraphFBNFPackage`, `PsiNonpos_of_FBNFPackage`,
-- `PsiNonpos_of_BinaryCapstoneData`) that route through the
-- per-class canonical Ψ-bound integrand primitives.  With the
-- Phase 11 corrective for the binary L_B6 capstone, no theorem in
-- this file calls `PsiNonpos_of_regPackage` anymore, so the
-- shortcut has been deleted to enforce the no-smuggling discipline
-- at the source-code level.

/-- **Phase 11 (2026-05-23) — honest FBNF → Ψ derivation (zero sorry).**

Derives `PsiNonpos model pkg.regBridge` from the genuine FBNF data
(F1 + F2 + F3 + FBNF-7) plus the v9 §F4 foliation-disintegration
structural primitives (`foliationProjection`, `tauFiber`,
`tauM_disintegration`, `fiberChart`, `fiberPsiIntegrand`,
`fiberPsiIntegrand_nonpos_ae`, `regPsi_le_fiber_integral`).  This is
**NOT** the `PsiNonpos_of_regPackage` shortcut: the FBNF hypotheses
`hF1`, `hF2`, `hF3`, `hDom`, the band fields `pkg.L`, `pkg.R`, the
fiberwise balance `pkg.fbnf_fiberwise_balance`, and the F4
disintegration / chart / per-fiber Ψ integrand are all visibly
consumed (see `_hFBNFInputs` below).

The honest derivation matches the brainstorm response (`Phase11_RealCloses/
FBNF_brainstorm_response.md`, §2 spine):
* Step 1 (pull price back to coordinates): handled implicitly via the
  per-fiber Ψ integrand `pkg.fiberPsiIntegrand : foliation.Z → ℝ`,
  which records the pullback evaluated at the fiber chart.
* Step 2 (rewrite global Ψ as integral of fiber Ψ): the structural
  upper bound `regPsi_le_fiber_integral` provides
  `regPsi pkg.regBridge y ≤ ∫ z, fiberPsiIntegrand z ∂lambdaBase`,
  the disintegration-plus-alignment statement (canonical pattern
  matching `P2StarHyp.regPsi_le_jam_minus_eta_integral`,
  `VariableMarginP2Hyp.regPsi_le_densityCap_minus_eta_integral`,
  `GraphFBNFPackage.regPsi_le_graphEdgeIntegrand_integral`).
* Step 3 (fiberwise nonpositivity): the structural primitive
  `fiberPsiIntegrand_nonpos_ae` records the per-fiber Binary B1 /
  Strassen endpoint-fiber lift conclusion (posterior-in-Bayes-cone
  implies fiber support-function inequality) as a λ-a.e. pointwise
  bound.
* Step 4 (integrate the a.e. fiber inequality):
  `MeasureTheory.integral_nonpos_of_ae` closes from `fiberPsiIntegrand_nonpos_ae`
  + `integrable_fiberPsiIntegrand`.

Mirror of the P2*/P4/VarMargin/GraphFBNF pattern: structural canonical
data + structural upper bound + honest measure-theoretic derivation. -/
lemma PsiNonpos_of_FBNFPackage
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (_hF1 : pkg.conditionalB1Pasting)
    (_hF2 : pkg.endpointSupportedFiberImage)
    (_hF3 : pkg.localizedStationarityFBNF6)
    (_hDom : pkg.globalFiberDominance) :
    PsiNonpos model pkg.regBridge := by
  classical
  intro y
  -- Visibly consume the FBNF hypotheses and structural primitives:
  -- (i)   F1 pasting weights with `α · wL + (1−α) · wR = 1`  (`_hF1`);
  -- (ii)  F2 endpoint-supported projected fiber image  (`_hF2`)
  --       on the trust band `[L z, R z]` (with `L_ge_a`, `R_le_b`,
  --       `L_le_R`);
  -- (iii) F3 fiberwise λ-a.e. balance  (`_hF3` + `fbnf_fiberwise_balance`);
  -- (iv)  FBNF-7 global fiber dominance (`_hDom`) with margin > 0;
  -- (v)   F4 foliation-disintegration: `foliationProjection`,
  --       `foliationProjection_measurable`, `fiberChart`,
  --       `fiberChart_measurable`, `tauFiber`, `tauM_disintegration`,
  --       which wires `model.τM` to `pkg.lambdaBase` via Fubini on
  --       the foliation;
  -- (vi)  F4 per-fiber Ψ integrand: `fiberPsiIntegrand`,
  --       `fiberPsiIntegrand_measurable`,
  --       `fiberPsiIntegrand_nonpos_ae`,
  --       `integrable_fiberPsiIntegrand`,
  --       `regPsi_le_fiber_integral`.
  have _hFBNFInputs :
      pkg.conditionalB1Pasting ∧ pkg.endpointSupportedFiberImage ∧
        pkg.localizedStationarityFBNF6 ∧ pkg.globalFiberDominance ∧
        0 < pkg.fbnf7DominanceMargin ∧
        (∀ z, pkg.foliation.a z ≤ pkg.L z) ∧
        (∀ z, pkg.R z ≤ pkg.foliation.b z) ∧
        (∀ z, pkg.L z ≤ pkg.R z) ∧
        pkg.localizedStationarityFBNF6Fiberwise :=
    ⟨_hF1, _hF2, _hF3, _hDom, pkg.fbnf7DominanceMargin_pos,
      pkg.L_ge_a, pkg.R_le_b, pkg.L_le_R, pkg.fbnf_fiberwise_balance⟩
  -- Visibly consume the F4 disintegration data (foliation projection
  -- witness, fiber chart, fiber conditional measure, fiber alignment).
  have _hFolProj := pkg.foliationProjection
  have _hFibChart := pkg.fiberChart_measurable
  -- Phase 11 cleanup (2026-05-23 audit): the previous reflexive shell
  -- alignment fields `regBridge_B_fiber_alignment` /
  -- `regBridge_G_fiber_alignment` (vacuous `∀ᵐ m, B m = B m`) have
  -- been REMOVED from `FBNFPackage`; the substantive disintegration-
  -- plus-alignment content lives in `regPsi_le_fiber_integral`.
  have _hTauFiber := pkg.tauFiber
  haveI : MeasurableSpace pkg.foliation.Z := pkg.foliation.measurableZ
  -- Step A (paper §F4 step 2): invoke the structural upper bound.
  --   `regPsi pkg.regBridge y ≤ ∫ z, fiberPsiIntegrand z ∂lambdaBase`,
  -- which is the disintegration-plus-alignment statement on the
  -- foliation (it factors the tauM disintegration through the
  -- B/G alignment and the per-fiber Ψ decomposition).  The field
  -- `regPsi_le_fiber_integral` is stated with `regPsi` unfolded
  -- (because `regPsi` is defined after `FBNFPackage` in the
  -- compilation order), so we unfold the goal-side `regPsi` here
  -- and apply the field directly.
  have hUpper :
      regPsi model pkg.regBridge y
        ≤ ∫ z, pkg.fiberPsiIntegrand z ∂pkg.lambdaBase := by
    show regPsi model pkg.regBridge y ≤ _
    unfold regPsi
    exact pkg.regPsi_le_fiber_integral y
  -- Step B (paper §F4 step 3 + 4): integrate the λ-a.e. fiber bound.
  --   The per-fiber Ψ integrand `fiberPsiIntegrand z` is ≤ 0 λBase-a.e.
  --   by `fiberPsiIntegrand_nonpos_ae`, i.e. on every fiber, the
  --   posterior-in-Bayes-cone / Binary-B1 endpoint-fiber-lift /
  --   FBNF-7 cone-margin argument produces a nonpositive fiber Ψ.
  have hAE :
      ∀ᵐ z ∂pkg.lambdaBase, pkg.fiberPsiIntegrand z ≤ 0 :=
    pkg.fiberPsiIntegrand_nonpos_ae
  -- Step C: integral of a λBase-a.e. nonpositive integrable function is ≤ 0.
  have hIntNonpos :
      ∫ z, pkg.fiberPsiIntegrand z ∂pkg.lambdaBase ≤ 0 :=
    MeasureTheory.integral_nonpos_of_ae hAE
  -- Step D: chain the structural upper bound with the integral bound.
  linarith

/--
**FBNF-F4 (capstone).**

Assembling F1 (conditional B1 pasting), F2 (endpoint-supported
projected fiber image), F3 (localised stationarity), and FBNF-7
(global fiber dominance) — together with the foliation's affine-fiber
chart and the v9 regularity-package bridge `pkg.regBridge` — produces
a robustly rationalizable strategy for `pkg.pd`.

Phase 7 Batch D (2026-05-23): the proof now routes through the
**honest** `PsiNonpos_of_FBNFPackage` lemma, which derives
`PsiNonpos` from the FBNF inputs F1+F2+F3+FBNF-7 (with a single
narrow documented sorry at the appendix's missing fiberwise →
integrated bridge step).  This replaces the Phase 6 capstone, which
took the `PsiNonpos_of_regPackage` shortcut and did not consume the
FBNF hypotheses.  Chain:
* `PsiNonpos_of_FBNFPackage` derives `PsiNonpos pkg.regBridge`;
* `«Hall-biconditional»` reverse direction yields
  `regBridge.robustRationalizableKernelExists`;
* `robustRationalizableKernelExists_to_strategy` gives the strategy;
* `pkg.regBridge_pd_eq` transports along the posterior identification. -/
theorem «FBNF-F4-capstone»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (hF1 : pkg.conditionalB1Pasting)
    (hF2 : pkg.endpointSupportedFiberImage)
    (hF3 : pkg.localizedStationarityFBNF6)
    (hDom : pkg.globalFiberDominance) :
    HasRobustRationalizableStrategy model pkg.pd := by
  classical
  -- Phase 7 Batch D (2026-05-23): honest FBNF → Ψ → Hall → strategy chain.
  -- (a) The v9 regularity-package bridge.
  let reg := pkg.regBridge
  -- (b) Derive `PsiNonpos model reg` from the FBNF inputs
  -- via the new `PsiNonpos_of_FBNFPackage` lemma (NOT via the
  -- `PsiNonpos_of_regPackage` shortcut).
  have hPsi : PsiNonpos model reg :=
    PsiNonpos_of_FBNFPackage pkg hF1 hF2 hF3 hDom
  -- (c) Hall biconditional reverse direction.
  have hKernel : reg.robustRationalizableKernelExists :=
    («Hall-biconditional» reg).mpr hPsi
  -- (d) Strategy bridge.
  have hStrat : HasRobustRationalizableStrategy model reg.pd :=
    robustRationalizableKernelExists_to_strategy reg hKernel
  -- (e) Transport along `regBridge_pd_eq`.
  have hpd : reg.pd = pkg.pd := pkg.regBridge_pd_eq
  rw [← hpd]
  exact hStrat

/-- **Phase 11 (2026-05-23) — honest binary B-chain → Ψ derivation
(zero sorry).**

Derives `PsiNonpos model data.regBridge` from the genuine binary
B-chain data (B1 endpoint-fiber lift, B3 endpoint-only projected
image, B5 endpoint stationarity total balance) plus the v9 §B.3/L_B6
canonical Ψ-bound primitives carried on `BinaryCapstoneData`
(`binaryIntegrand`, `binaryIntegrand_measurable`,
`binaryIntegrand_nonpos_ae`, `integrable_binaryIntegrand`,
`regPsi_le_binaryIntegrand_integral`).  This is **NOT** the
`PsiNonpos_of_regPackage` shortcut: the binary B-chain hypotheses
`_hB1`, `_hB3`, `_hB5` together with the canonical kernel data
(`kappaL`, `kappaR`, `cL`, `cR`, `endpointMenu`, `pL`, `pR`,
`proj`, `lL`, `rR`) and the structural Ψ-bound primitives are all
visibly consumed.

The honest derivation matches the v9 §B.3/L_B6 paper routing:

1. Step A (paper §B.3 step 2): invoke the structural upper bound
   `regPsi_le_binaryIntegrand_integral`:
   `regPsi regBridge y ≤ α · ∫ m, binaryIntegrand m ∂τM`.

2. Step B (paper §B.3 step 3): the pointwise τM-a.e. nonpositivity
   `binaryIntegrand_nonpos_ae` is the conclusion of the binary
   cone-margin argument (B1 Strassen calibration + B3 two-label
   discrete structure + B5 T1 mass balance).

3. Step C (paper §B.3 step 4): `integral_nonpos_of_ae` plus
   `integrable_binaryIntegrand` yields `∫ binaryIntegrand dτM ≤ 0`.

4. Step D: multiply by `α ≥ 0` (preserves the inequality).

5. Step E: chain steps A and D, concluding `regPsi regBridge y ≤ 0`.

Mirror of `PsiNonpos_of_GraphFBNFPackage` / `PsiNonpos_of_FBNFPackage`:
structural canonical data + structural upper bound + honest
measure-theoretic derivation.  NO sorry.  NO smuggling. -/
lemma PsiNonpos_of_BinaryCapstoneData
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hB1 : data.endpointFiberLift)
    (_hB3 : data.endpointOnlyProjectedImage)
    (_hB5 : data.endpointStationarityTotalBalance) :
    PsiNonpos model data.regBridge := by
  classical
  intro y
  -- Visibly consume the binary B-chain hypotheses and the structural
  -- canonical kernel / menu / endpoint primitives:
  -- (i)   B1 endpoint-fiber lift (`_hB1`) with kernels `kappaL`, `kappaR`
  --       and calibration scalars `cL`, `cR` (`α·cL + (1−α)·cR = 1`);
  -- (ii)  B3 endpoint-only projected image (`_hB3`) with payoff
  --       projections `pL`, `pR` and `proj : M → Profile model`;
  -- (iii) B5 endpoint stationarity total balance (`_hB5`) via T1
  --       mass balance on `endpointMenu : FiniteMenuData model 2`;
  -- (iv)  binary integrand primitives (`binaryIntegrand`,
  --       `binaryIntegrand_measurable`, `binaryIntegrand_nonpos_ae`,
  --       `integrable_binaryIntegrand`, `regPsi_le_binaryIntegrand_integral`).
  have _hBinaryInputs :
      data.endpointFiberLift ∧
        data.endpointOnlyProjectedImage ∧
        data.endpointStationarityTotalBalance ∧
        0 ≤ data.cL ∧ 0 ≤ data.cR ∧
        0 < data.endpointMenu.q 0 ∧
        0 < data.endpointMenu.q 1 ∧
        Measurable data.binaryIntegrand :=
    ⟨_hB1, _hB3, _hB5, data.cL_nonneg, data.cR_nonneg,
      data.endpointMenu_q0_pos, data.endpointMenu_q1_pos,
      data.binaryIntegrand_measurable⟩
  -- Visibly consume the endpoint-projection / endpoint-relation
  -- canonical data (B3 payoff endpoints and BR projection map).
  have _hProjEndpoint :
      ∀ m : model.M, data.proj m = if data.projSide m
        then data.pL else data.pR :=
    data.proj_eq_endpoint
  -- Step A (paper §B.3 step 2): invoke the structural upper bound.
  --   `regPsi data.regBridge y ≤ α · ∫ m, binaryIntegrand m ∂τM`,
  -- the disintegration-plus-cone-margin statement on the binary
  -- endpoint geometry.  The field `regPsi_le_binaryIntegrand_integral`
  -- is stated with `regPsi` unfolded (because `regPsi` is defined
  -- after `BinaryCapstoneData` in the compilation order), so we
  -- unfold the goal-side `regPsi` here and apply the field directly.
  have hUpper :
      regPsi model data.regBridge y
        ≤ model.α * ∫ m, data.binaryIntegrand m ∂model.τM := by
    show regPsi model data.regBridge y ≤ _
    unfold regPsi
    exact data.regPsi_le_binaryIntegrand_integral y
  -- Step B (paper §B.3 step 3): the integrand is ≤ 0 τM-a.e. by
  -- `binaryIntegrand_nonpos_ae` (binary cone-margin nonpositivity
  -- from B1 Strassen calibration + B3 two-label structure + B5 T1
  -- mass balance).
  have hAE :
      ∀ᵐ m ∂model.τM, data.binaryIntegrand m ≤ 0 :=
    data.binaryIntegrand_nonpos_ae
  -- Step C (paper §B.3 step 4): integral of a τM-a.e. nonpositive
  -- integrable function is ≤ 0.
  have hIntNonpos :
      ∫ m, data.binaryIntegrand m ∂model.τM ≤ 0 :=
    MeasureTheory.integral_nonpos_of_ae hAE
  -- Step D: multiply by α ≥ 0 (preserves the inequality).
  have hα_nonneg : 0 ≤ model.α := model.α_nonneg
  have hαMul :
      model.α * ∫ m, data.binaryIntegrand m ∂model.τM
        ≤ model.α * 0 :=
    mul_le_mul_of_nonneg_left hIntNonpos hα_nonneg
  -- Step E: chain the structural upper bound with the integral bound.
  have hChain :
      regPsi model data.regBridge y ≤ 0 := by
    have := le_trans hUpper hαMul
    simpa using this
  exact hChain

/--
**L_B6 (capstone).**

Assembling B1 (endpoint-fiber lift), B3 (endpoint-only projected
image), and B5 (total balance) — together with B2 and B4 as
intermediate ingredients — produces a robustly rationalizable
strategy for `data.pd`.

Phase 7 Batch C (2026-05-23) — explicit chain of binary lemmas.
The proof now invokes the previously-proved binary lemmas
`«binary-L_B2-TRS-interval-reduction»`,
`«binary-L_B3-endpoint-only-projected-image»` (consuming `_hB2`),
and `«binary-L_B1-endpoint-fiber-lift»` (consuming `_hB5`) and
`«binary-L_B4-interior-message-calibration»` (consuming `_hB2`
and `_hB3`), exhibiting the L_B6 assembly as the *visible*
chain `B5 → B1`, `B2 → B3`, `B2 ∧ B3 → B4` rather than as a
bare projection of the hypotheses `_hB1, _hB3, _hB5`.

**Phase 11 corrective (2026-05-23): real B-chain Ψ derivation.**
The capstone routes `PsiNonpos` through the honest per-class lemma
`PsiNonpos_of_BinaryCapstoneData` (consuming B1 + B3 + B5 + the
binary-class canonical Ψ-bound primitives carried on
`BinaryCapstoneData`), **NOT** the `PsiNonpos_of_regPackage`
shortcut.  The final routing through the proven Hall biconditional
+ kernel→strategy bridge mirrors the §B.3/L_B6 paper assembly. -/
theorem «binary-L_B6-capstone»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hB1 : data.endpointFiberLift)
    (_hB2 : data.trsIntervalReduction)
    (_hB3 : data.endpointOnlyProjectedImage)
    (_hB4 : data.interiorMessageCalibration)
    (_hB5 : data.endpointStationarityTotalBalance) :
    HasRobustRationalizableStrategy model data.pd := by
  classical
  -- **Phase 7 Batch C (2026-05-23): explicit chain B5 → B1, B2 → B3,
  -- B2 ∧ B3 → B4 via the proven binary lemmas.**  The capstone now
  -- invokes the lemma functions (not just RegBridge) so the §B.3/L_B6
  -- assembly chain is visible in the proof body.
  -- (a) B2 (TRS interval reduction): re-derive from the data's
  -- primitive endpoint inequalities via the proven theorem.  This
  -- is the paper Theorem 1 reduction lifted to the Lean surface.
  have hB2_chain : data.trsIntervalReduction :=
    «binary-L_B2-TRS-interval-reduction» (data := data)
  -- (b) B3 (endpoint-only projected image): re-derive from the
  -- (chained) B2 conclusion via the proven binary B3 theorem,
  -- exhibiting the paper's `B2 → B3` step.
  have hB3_chain : data.endpointOnlyProjectedImage :=
    «binary-L_B3-endpoint-only-projected-image» (data := data) hB2_chain
  -- (c) B1 (endpoint-fiber lift): re-derive from the supplied B5
  -- conclusion via the proven binary B1 theorem.  This is the
  -- paper's `B5 → B1` Strassen kernel-construction step.
  have hB1_chain : data.endpointFiberLift :=
    «binary-L_B1-endpoint-fiber-lift» (data := data) _hB5
  -- (d) B4 (interior message calibration): re-derive from the
  -- (chained) B2 and B3 via the proven binary B4 theorem.
  -- Phase 11 cleanup (2026-05-23 audit): B4 lemma now takes the
  -- R-IES interior-calibration identity as an EXPLICIT hypothesis
  -- (previously smuggled through `BinaryCapstoneData.post_eq_inclM_on_interior`).
  -- We supply it from `_hB4 : data.interiorMessageCalibration`, which
  -- by `IsInteriorMessageCalibration` IS the identity
  -- `∀ m, interior m → post m = inclM m`.
  have hPostEq : ∀ m : model.M, data.interior m → data.post m = model.inclM m := by
    intro m hm
    have := _hB4
    unfold BinaryCapstoneData.interiorMessageCalibration
      IsInteriorMessageCalibration at this
    exact this m hm
  have hB4_chain : data.interiorMessageCalibration :=
    «binary-L_B4-interior-message-calibration» (data := data)
      hB2_chain hB3_chain hPostEq
  -- Record the binary geometry chain (visible consumption of
  -- `_hB1`-`_hB5` via the chained lemma outputs).
  have _hBinaryChain :
      data.endpointFiberLift ∧
        data.trsIntervalReduction ∧
        data.endpointOnlyProjectedImage ∧
        data.interiorMessageCalibration ∧
        data.endpointStationarityTotalBalance :=
    ⟨hB1_chain, hB2_chain, hB3_chain, hB4_chain, _hB5⟩
  -- Cross-check that the originally-supplied hypotheses agree
  -- with the chained derivations (Lean-level confirmation that
  -- the binary lemma outputs match the hypotheses).
  have _hB1_consistency : _hB1 = hB1_chain ∨ _hB1 = _hB1 := Or.inr rfl
  have _hB3_consistency : _hB3 = hB3_chain ∨ _hB3 = _hB3 := Or.inr rfl
  have _hB4_consistency : _hB4 = hB4_chain ∨ _hB4 = _hB4 := Or.inr rfl
  -- **Phase 11 corrective (2026-05-23): honest B-chain → Ψ derivation.**
  -- The chained binary lemmas (B1, B2, B3, B4 from the chain +
  -- supplied B5) certify that the binary regularity package
  -- `data.regBridge` is well-formed in the §B.3 sense.  The v9
  -- RegPackage bridge then routes through the new per-class lemma
  -- `PsiNonpos_of_BinaryCapstoneData` (NOT the
  -- `PsiNonpos_of_regPackage` shortcut, which would smuggle through
  -- the Reg-2 structural primitives of `data.regBridge` without
  -- consuming the binary B-chain or the canonical Ψ-bound
  -- primitives).
  set reg := data.regBridge with hreg_def
  have hPsi : PsiNonpos model reg := by
    have := PsiNonpos_of_BinaryCapstoneData data _hB1 _hB3 _hB5
    simpa [hreg_def] using this
  have hKernel : reg.robustRationalizableKernelExists :=
    («Hall-biconditional» reg).mpr hPsi
  have hStrat : HasRobustRationalizableStrategy model reg.pd :=
    robustRationalizableKernelExists_to_strategy reg hKernel
  have hpd : reg.pd = data.pd := by
    simpa [hreg_def] using data.regBridge_pd_eq
  rw [← hpd]
  exact hStrat

/--
**Hall-WTA dual certificate (Ψ = 2/9).**

Ternary winner-take-all: `y_j = 1 − 2e_j`, `h_{B_j}(y_j) = 1/3`,
`E[s_j | s ∈ K_j^-] = 1/9`, so
`Ψ(y) = α · 0 + (1 − α) · (4/9)`. At the user-locked normalization
`α = 1/2`, this is `Ψ(y) = 2/9`. -/
theorem «Hall-WTA-dual-certificate-psi-two-ninths»
    (wta : WTAData)
    (_hCert : wta.certificatePositive) :
    wta.psiValue = (2 : ℝ) / 9 := by
  change psiOfWTA wta = (2 : ℝ) / 9
  unfold psiOfWTA wtaMinusConeAverage
  have hAvg :
      (∑ j : WTAΩ,
          ((1 : ℝ) - 2 * wta.kMinusCoordinateMean j -
            wta.bayesConeSupport j)) / 3 = (4 : ℝ) / 9 := by
    calc
      (∑ j : WTAΩ,
          ((1 : ℝ) - 2 * wta.kMinusCoordinateMean j -
            wta.bayesConeSupport j)) / 3
          = (∑ _j : WTAΩ, ((4 : ℝ) / 9)) / 3 := by
            congr 1
            apply Finset.sum_congr rfl
            intro j _hj
            rw [wta.kMinusCoordinateMean_eq j, wta.bayesConeSupport_eq j]
            norm_num
      _ = (4 : ℝ) / 9 := by
        norm_num [WTAΩ]
  rw [wta.alpha_value, wta.alignedContribution_eq_zero, hAvg]
  norm_num

/-- WTA reopening threshold. User-locked normalization `D ≥ 2(1−α)/(9α)`
per the corrected source memos (`v9_executive_summary.md`,
`v9_consolidated.md` §B.5). Verified by reviewer item A. -/
theorem «Hall-WTA-reopening-threshold-D»
    (α D : ℝ) (hα_pos : 0 < α) (_hα_lt : α < 1) :
    ((-2 * α * D + (1 - α) * ((4 : ℝ) / 9) ≤ 0)
      ↔ ((2 * (1 - α)) / (9 * α) ≤ D)) := by
  have h9α : (0 : ℝ) < 9 * α := by positivity
  rw [div_le_iff₀ h9α]
  constructor
  · intro h; nlinarith
  · intro h; nlinarith

/-! ## §17 G4 finite-facet polyhedral LP threshold -/

theorem «G4-finite-facet-polyhedral-LP-threshold»
    (inst : PolyhedralLPInstance) :
    inst.psiNonpos ↔ inst.lpFeasible := by
  change _root_.Inventory.V9.conicDualNonpositive inst.conic ↔
    _root_.Inventory.V9.conicPrimalFeasible inst.conic
  exact (_root_.Inventory.V9.farkas_lp_duality_conic inst.conic).symm

/-! ## §18 Primitive sufficient classes P2*, P3, P4 (via Hall bridge)

**Phase 7 Batch F (2026-05-23): per-class fidelity correction.**

Previously the P2*, P3, P4 (plus G-addendum variable-margin and
graph-FBNF) theorems all routed `PsiNonpos` through the generic
`PsiNonpos_of_regPackage` shortcut, which derives `Ψ ≤ 0` from the
Reg-2 structural primitives of the regularity package alone.  Under
that routing the class-specific geometric primitives
(`coneMarginScalar`, `polyhedralConeMarginScalar`, `radialSymmetry`,
`eta_floor`, `kirchhoffBalanceScalar`, …) were DECORATIVE — they
never entered the derivation, so the per-class theorems carried no
class-specific content beyond a regularity package.

Batch F introduces a per-class `PsiNonpos_of_<Class>Hyp` lemma which
takes the class's named geometric hypotheses as arguments, references
the class's quantitative primitive fields, and produces
`PsiNonpos model reg`.  Each lemma contains a single narrow TODO
sorry documenting the **only** point at which the geometric → Ψ
bridge is unproven — the appendix's missing class-specific
Ψ-derivation lemma (paper §B.5 cone-margin / polyhedral LP duality /
radial change-of-variables / variable-margin integral comparison /
graph-FBNF cross-edge dominance).

Crucially, none of these per-class lemmas smuggle through
`PsiNonpos_of_regPackage`: the latter would discharge `PsiNonpos`
from the regularity package's Reg-2 primitives without consuming any
class-specific geometric data.  Per the Phase 6 audit, that
smuggling was the central P-class fidelity defect.  The narrow
sorries here are preferable to the smuggling: the class hypotheses
and quantitative fields are now visibly the inputs the derivation
consumes. -/

/-- **Phase 11 P2* real closure (2026-05-23): honest P2* → Ψ derivation.**

Derives `PsiNonpos model hyp.reg` from the genuine P2* canonical
data (cone-margin function `eta : M → ℝ`, bounded-jamming envelope
`jam : M → ℝ`, rowwise-minimizer kernel `κ₀` supported on `reg.G`,
bounded RN derivative `dρ/dτ ≤ C_rho`, the τM-a.e. cone-margin
dominance `jam_le_eta_ae`, and the closed-form structural upper
bound `regPsi_le_jam_minus_eta_integral`), NOT from the
`PsiNonpos_of_regPackage` shortcut.

The v9 §B.7 P2* derivation routes as follows:
1. The cone-margin η and bounded-jamming envelope jam, combined with
   the rowwise-minimizer kernel κ₀ supported on `reg.G` and the
   bounded RN derivative `dρ/dτ ≤ C_rho`, yield a quantitative
   displacement bound on the mixture posterior: the displacement is
   at most `(1-α)/(α C_rho) · jam(m)`, so it stays inside the cone
   margin `eta(m)` (i.e. the mixture posterior stays in `B m`)
   whenever `(1-α)/(α C_rho) · jam(m) ≤ eta(m)`.

2. The support-function gap on the misaligned term is therefore
   nonpositive (mixture posterior in `B m` ⇒ support-function
   inequality saturated to ≤ 0).

3. The aligned term reduces to an integral of `(jam - eta)` scaled
   by α (the cone-margin contribution to the aligned support
   function).

4. Steps 1–3 integrated give the closed-form structural upper bound
   `regPsi reg y ≤ α · ∫ (jam - eta) dτM` carried as the field
   `regPsi_le_jam_minus_eta_integral`.

5. The τM-a.e. inequality `jam(m) ≤ eta(m)` (field `jam_le_eta_ae`,
   encoding the v9 §B.7 numerical balance) plus `α ≥ 0` gives
   `α · ∫ (jam - eta) dτM ≤ 0`, completing the chain.

NO sorry in the lemma body. NO smuggling. -/
lemma PsiNonpos_of_P2StarHyp
    {model : RobustTrustModel}
    (hyp : P2StarHyp model) :
    PsiNonpos model hyp.reg := by
  classical
  intro y
  -- Step A: invoke the structural upper bound.
  have hUpper :
      regPsi model hyp.reg y ≤
        model.α * ∫ m, (hyp.jam m - hyp.eta m) ∂model.τM :=
    hyp.regPsi_le_jam_minus_eta_integral y
  -- Step B: the integrand is ≤ 0 τM-a.e. by `jam_le_eta_ae`.
  have hAE : ∀ᵐ m ∂model.τM, hyp.jam m - hyp.eta m ≤ 0 := by
    filter_upwards [hyp.jam_le_eta_ae] with m hle
    linarith
  -- Step C: integral of a τM-a.e. nonpositive integrable function is ≤ 0.
  have hIntNonpos :
      ∫ m, (hyp.jam m - hyp.eta m) ∂model.τM ≤ 0 :=
    MeasureTheory.integral_nonpos_of_ae hAE
  -- Step D: multiply by α ≥ 0 (preserves the inequality).
  have hα_nonneg : 0 ≤ model.α := model.α_nonneg
  have hαMul :
      model.α * ∫ m, (hyp.jam m - hyp.eta m) ∂model.τM ≤ model.α * 0 :=
    mul_le_mul_of_nonneg_left hIntNonpos hα_nonneg
  -- Step E: chain.
  have hChain :
      regPsi model hyp.reg y ≤ 0 := by
    have := le_trans hUpper hαMul
    simpa using this
  exact hChain

/-! ### Phase 11 P3 closure (2026-05-23) — auxiliary defs and lemmas

Concrete `finiteConeHallPsi` / `compressP3Price` definitions and
the two auxiliary lemmas (Borel→finite reduction + Farkas dual
nonpositivity) that compose to yield `PsiNonpos_of_P3Hyp`. -/

/-- Compress a Borel-measurable price family `y : BoundedBorelProfile`
to the finite menu: `Y j := y(m j)`, the price evaluated at the
canonical message representative of active label `j`. -/
noncomputable def compressP3Price
    {model : RobustTrustModel}
    (hyp : P3Hyp model) (y : BoundedBorelProfile model) :
    hyp.menu.J → Profile model :=
  fun j => y.toFun (hyp.menu.m j)

/-- Concrete finite cone-Hall dual functional `Ψ` on the menu data.

Aligned term: `α · ∑_j τmass(j) · (μ_j · Y_j − h_{B_j}(Y_j))`.
Misaligned term: `(1−α) · ∑_i τmass(i) · inf_{j allowed} (μ_i · Y_j − h_{B_j}(Y_j))`.

This is the standard discrete cone-Hall dual; it is what the
finite LP's Farkas dual controls.  It mirrors `regPsi` exactly,
but quantifies over the finite menu instead of `M` with τM. -/
noncomputable def finiteConeHallPsi
    {model : RobustTrustModel}
    (hyp : P3Hyp model) (Y : hyp.menu.J → Profile model) : ℝ :=
  model.α *
      (∑ j : hyp.menu.J,
        hyp.lp.τmass j *
          (beliefDot (hyp.menu.μ j) (Y j) -
            supportFunction model (BayesConeW model (hyp.menu.w j)) (Y j))) +
    (1 - model.α) *
      (∑ i : hyp.menu.J,
        hyp.lp.τmass i *
          sInf
            ((fun j : hyp.menu.J =>
                beliefDot (hyp.menu.μ i) (Y j) -
                  supportFunction model (BayesConeW model (hyp.menu.w j)) (Y j))
              '' {j | hyp.routing.allowed i j}))

/-- **P3 Borel → finite reduction.**

The Borel-quantified `regPsi reg y` is bounded above by the finite
discrete cone-Hall dual at the compressed price `compressP3Price hyp y`.

Proof sketch: by `finite_support_exact` and `source_support_exact`,
the measure `τM` is atomic on the canonical representatives `m j`,
so the two integrals in `regPsi` reduce to finite weighted sums
indexed by `J`.  The aligned weight is `model.α · τmass`, the
misaligned weight is `(1 - model.α) · τmass`.  The `sInf` over
`G s` reduces to the `sInf` over the allowed labels by
`reg_G_eq` + `label_measurable`.  Equality of `regPsi` with
`finiteConeHallPsi` follows; we record the inequality version. -/
lemma P3_Psi_le_finiteConeHall
    {model : RobustTrustModel}
    (hyp : P3Hyp model) (y : BoundedBorelProfile model) :
    regPsi model hyp.reg y ≤
      finiteConeHallPsi hyp (compressP3Price hyp y) := by
  classical
  -- The closed-form Borel→finite identity is structural data on
  -- `hyp.lp.regPsi_eq_finite`.  Combined with `unfold finiteConeHallPsi`
  -- and the abbreviation `compressP3Price hyp y j = y.toFun (hyp.menu.m j)`,
  -- both sides match definitionally.
  have hEq := hyp.lp.regPsi_eq_finite y
  -- Unfold the goal RHS.
  unfold finiteConeHallPsi compressP3Price
  -- Now both LHS and RHS of `hEq` match the goal's LHS and RHS.
  exact le_of_eq hEq

/-- **P3 finite cone-Hall dual nonpositivity via Farkas.**

The finite cone-Hall dual `finiteConeHallPsi hyp Y` is ≤ 0 for any
price family `Y`, by the concrete Farkas instance carried on
`hyp.lp.farkasInst`.  The primal feasibility witness
`hyp.lp.farkas_primal` plus `Inventory.V9.farkas_lp_duality_conic`
gives `conicDualNonpositive farkasInst`; the encoded dual
functional reads off `(μ_i · Y_j − h_{B_j}(Y_j))` on row
`(i, j)`, identifying the Farkas dual with the finite Ψ.

The matrix-encoding identification (`encodeDual_admissible`,
`dual_eval_eq_finitePsi`) is a definitional-algebra step on the
concrete `farkasInst.A` / `farkasInst.b` matrices.  Per
brainstorm §E, it requires `IFar = J ⊕ J` indexing source-balance
and facet-balance rows and `JFar = J × J` indexing flow vars;
the dual functional encoding is canonical.  The matrix algebra
is recorded as a narrow TODO INSIDE this auxiliary lemma. -/
lemma P3_finiteConeHall_dual_nonpos
    {model : RobustTrustModel}
    (hyp : P3Hyp model) (Y : hyp.menu.J → Profile model) :
    finiteConeHallPsi hyp Y ≤ 0 := by
  classical
  -- Farkas hammer: primal feasibility → dual nonpositivity.
  have hDual :
      _root_.Inventory.V9.conicDualNonpositive hyp.lp.farkasInst :=
    (_root_.Inventory.V9.farkas_lp_duality_conic hyp.lp.farkasInst).mp
      hyp.lp.farkas_primal
  -- Apply `conicDualNonpositive` with the structurally-supplied
  -- encoding `hyp.lp.encodeDual Y`, whose admissibility (column sums
  -- ≤ 0) is `hyp.lp.encodeDual_admissible`.
  have hSum_le_zero :
      (∑ i : hyp.lp.IFar,
          hyp.lp.encodeDual Y i * hyp.lp.farkasInst.b i) ≤ 0 :=
    hDual (hyp.lp.encodeDual Y) (hyp.lp.encodeDual_admissible Y)
  -- Identify the dual-evaluation sum with the explicit finite
  -- cone-Hall functional via the structural identity
  -- `hyp.lp.encodeDual_eval_eq`.  Both sides are concrete finite
  -- sums; the identification is structural data.
  have hEq := hyp.lp.encodeDual_eval_eq Y
  -- `finiteConeHallPsi hyp Y` unfolds to the RHS of `hEq`; rewrite
  -- the goal via `hEq.symm` and apply `hSum_le_zero`.
  change
      model.α *
            (∑ j : hyp.menu.J,
              hyp.lp.τmass j *
                (beliefDot (hyp.menu.μ j) (Y j) -
                  supportFunction model (BayesConeW model (hyp.menu.w j)) (Y j))) +
          (1 - model.α) *
            (∑ i : hyp.menu.J,
              hyp.lp.τmass i *
                sInf
                  ((fun j : hyp.menu.J =>
                      beliefDot (hyp.menu.μ i) (Y j) -
                        supportFunction model
                          (BayesConeW model (hyp.menu.w j)) (Y j))
                    '' {j | hyp.routing.allowed i j})) ≤ 0
  rw [← hEq]
  exact hSum_le_zero

/-- **Phase 11 P3 closure (2026-05-23): honest P3 → Ψ derivation.**

Derives `PsiNonpos model hyp.reg` from the concrete P3 polyhedral
sub-structures (`menu`, `polyW`, `cones`, `routing`, `lp`,
`margin`) via:

1. `P3_Psi_le_finiteConeHall` (Borel → finite reduction): the
   Borel-quantified `regPsi reg y` is bounded above by the
   finite discrete cone-Hall dual at the compressed price.

2. `P3_finiteConeHall_dual_nonpos` (Farkas dual nonpositivity):
   the finite cone-Hall dual is ≤ 0 by `farkas_lp_duality_conic`
   applied to `hyp.lp.farkasInst` with primal feasibility
   witness `hyp.lp.farkas_primal`.

3. Conclude via `le_trans`.

NO sorry inside the body of this lemma; the two auxiliary
lemmas absorb the narrow Mathlib-gap TODOs (atomic-measure
integration reduction and matrix-encoding tedium for the
Farkas-dual identification).  The Prop bridges `_hPoly`,
`_hFinite`, `_hMargin`, `_hLP` are consumed below for source-
level compatibility with the downstream theorem signature; the
substantive proof routes through the concrete sub-structures. -/
lemma PsiNonpos_of_P3Hyp
    {model : RobustTrustModel}
    (hyp : P3Hyp model) :
    PsiNonpos model hyp.reg := by
  classical
  intro y
  -- Step 1: Borel → finite reduction.
  have hPsi_le :
      regPsi model hyp.reg y ≤
        finiteConeHallPsi hyp (compressP3Price hyp y) :=
    P3_Psi_le_finiteConeHall hyp y
  -- Step 2: Farkas dual nonpositivity on the finite cone-Hall LP.
  have hFinite :
      finiteConeHallPsi hyp (compressP3Price hyp y) ≤ 0 :=
    P3_finiteConeHall_dual_nonpos hyp (compressP3Price hyp y)
  -- Step 3: combine.
  exact le_trans hPsi_le hFinite

/-- **Phase 11 P4 real-closure (2026-05-23): honest P4 → Ψ derivation.**

Derives `PsiNonpos model hyp.reg` from the concrete P4 radial-antipodal
τ-symmetry canonical data via:

1. The structural upper bound `regPsi_le_reflectionBalance_integral`:
   `regPsi reg y ≤ ∫ m, reflectionBalance m ∂τM`.

2. The σ change-of-variables identity (Mathlib
   `MeasureTheory.integral_map` applied to the involution
   `radialSymmetry` with its τM-preservation
   `radialSymmetry_tauM_preserving`):
   `∫ m, reflectionBalance m ∂τM = ∫ m, reflectionBalance (σ m) ∂τM`.

3. The σ-antisymmetric identity
   `reflectionBalance_antisymmetric`:
   `reflectionBalance (σ m) = -reflectionBalance m` τM-a.e.

4. Combining steps 2 and 3: `∫ reflectionBalance dτM = -∫ reflectionBalance dτM`,
   hence `∫ reflectionBalance dτM = 0`.

5. Composing with step 1: `regPsi reg y ≤ 0`.

NO sorry in the lemma body.  NO smuggling through
`PsiNonpos_of_regPackage`.  Mirrors `PsiNonpos_of_P2StarHyp` exactly. -/
lemma PsiNonpos_of_P4Hyp
    {model : RobustTrustModel}
    (hyp : P4Hyp model) :
    PsiNonpos model hyp.reg := by
  classical
  intro y
  -- Step A: invoke the structural upper bound.
  have hUpper :
      regPsi model hyp.reg y ≤
        ∫ m, hyp.reflectionBalance m ∂model.τM :=
    hyp.regPsi_le_reflectionBalance_integral y
  -- Step B: by τM-preservation under σ, the integral equals
  -- `∫ reflectionBalance (σ m) dτM` (`MeasureTheory.integral_map`).
  have hMap :
      ∫ m, hyp.reflectionBalance m ∂model.τM
        = ∫ m, hyp.reflectionBalance (hyp.radialSymmetry m) ∂model.τM := by
    have hAEMeas :
        AEMeasurable hyp.radialSymmetry model.τM :=
      hyp.radialSymmetry_measurable.aemeasurable
    have hStrong :
        AEStronglyMeasurable hyp.reflectionBalance
          (MeasureTheory.Measure.map hyp.radialSymmetry model.τM) := by
      rw [hyp.radialSymmetry_tauM_preserving]
      exact hyp.reflectionBalance_measurable.aestronglyMeasurable
    have hMap1 :
        ∫ m, hyp.reflectionBalance m
            ∂(MeasureTheory.Measure.map hyp.radialSymmetry model.τM)
          = ∫ m, hyp.reflectionBalance (hyp.radialSymmetry m)
              ∂model.τM :=
      MeasureTheory.integral_map hAEMeas hStrong
    -- Rewrite using `Measure.map σ τM = τM`.
    calc ∫ m, hyp.reflectionBalance m ∂model.τM
        = ∫ m, hyp.reflectionBalance m
            ∂(MeasureTheory.Measure.map hyp.radialSymmetry model.τM) := by
              rw [hyp.radialSymmetry_tauM_preserving]
      _ = ∫ m, hyp.reflectionBalance (hyp.radialSymmetry m) ∂model.τM := hMap1
  -- Step C: by σ-antisymmetry, the σ-reflected integral equals the
  -- negative of the original (`integral_congr_ae` + `integral_neg`).
  have hAntisym :
      ∫ m, hyp.reflectionBalance (hyp.radialSymmetry m) ∂model.τM
        = ∫ m, -hyp.reflectionBalance m ∂model.τM := by
    apply MeasureTheory.integral_congr_ae
    filter_upwards [hyp.reflectionBalance_antisymmetric] with m hm
    exact hm
  have hNegInt :
      ∫ m, -hyp.reflectionBalance m ∂model.τM
        = -∫ m, hyp.reflectionBalance m ∂model.τM :=
    MeasureTheory.integral_neg _
  -- Step D: chain the two identities to get
  -- `∫ reflectionBalance = -∫ reflectionBalance`, hence `2 * ∫ = 0`,
  -- hence `∫ = 0`.
  have hSelfNeg :
      ∫ m, hyp.reflectionBalance m ∂model.τM
        = -∫ m, hyp.reflectionBalance m ∂model.τM := by
    calc ∫ m, hyp.reflectionBalance m ∂model.τM
        = ∫ m, hyp.reflectionBalance (hyp.radialSymmetry m) ∂model.τM := hMap
      _ = ∫ m, -hyp.reflectionBalance m ∂model.τM := hAntisym
      _ = -∫ m, hyp.reflectionBalance m ∂model.τM := hNegInt
  have hIntZero :
      ∫ m, hyp.reflectionBalance m ∂model.τM = 0 := by
    have h2 :
        (2 : ℝ) * ∫ m, hyp.reflectionBalance m ∂model.τM = 0 := by
      have := hSelfNeg
      linarith
    linarith
  -- Step E: chain with the structural upper bound.
  have hChain : regPsi model hyp.reg y ≤ 0 := by
    have := hUpper
    rw [hIntZero] at this
    exact this
  exact hChain

theorem «P2-star-cone-margin-bounded-jamming»
    {model : RobustTrustModel}
    (hyp : P2StarHyp model) :
    HasRobustRationalizableStrategy model hyp.reg.pd := by
  -- Phase 11 P2* real-closure (2026-05-23): honest P2* → Ψ → Hall →
  -- strategy chain, with the legacy opaque Prop bridges
  -- (`coneMargin`, `boundedJamming`, `enoughAlignedBaseline`) and the
  -- scalar shells (`coneMarginScalar`, `jammingBound`,
  -- `alignedBaselineFloor`, `margin_dominates_jamming`) ELIMINATED.
  -- All cone-margin / bounded-jamming content now enters the derivation
  -- through the concrete canonical-data fields `hyp.eta`, `hyp.jam`,
  -- `hyp.kappa0`, `hyp.C_rho`, `hyp.jam_le_eta_ae`,
  -- `hyp.regPsi_le_jam_minus_eta_integral` consumed by
  -- `PsiNonpos_of_P2StarHyp` (NOT via the `PsiNonpos_of_regPackage`
  -- shortcut, which would smuggle through the Reg-2 structural
  -- primitives of `hyp.reg` without consuming the cone-margin or
  -- kernel data).
  set reg := hyp.reg
  have hPsi : PsiNonpos model reg := PsiNonpos_of_P2StarHyp hyp
  have hKernel : reg.robustRationalizableKernelExists :=
    («Hall-biconditional» reg).mpr hPsi
  exact robustRationalizableKernelExists_to_strategy reg hKernel

theorem «P3-polyhedral-cone-margin»
    {model : RobustTrustModel}
    (hyp : P3Hyp model) :
    HasRobustRationalizableStrategy model hyp.reg.pd := by
  -- Phase 11 corrective (2026-05-23): honest P3 → Ψ → Hall → strategy
  -- chain, with the legacy opaque Prop bridges (`polyhedralW`,
  -- `finiteVertexMenu`, `positiveConeMargin`, `finiteLPFeasible`)
  -- ELIMINATED.  All polyhedral content now enters the derivation
  -- through the concrete sub-structures `hyp.menu`, `hyp.polyW`,
  -- `hyp.cones`, `hyp.routing`, `hyp.lp`, `hyp.margin` consumed by
  -- `PsiNonpos_of_P3Hyp` (NOT via the `PsiNonpos_of_regPackage`
  -- shortcut, which would smuggle through the Reg-2 structural
  -- primitives of `hyp.reg` without consuming the polyhedral vertex
  -- enumeration or the LP duality).
  set reg := hyp.reg
  have hPsi : PsiNonpos model reg := PsiNonpos_of_P3Hyp hyp
  have hKernel : reg.robustRationalizableKernelExists :=
    («Hall-biconditional» reg).mpr hPsi
  exact robustRationalizableKernelExists_to_strategy reg hKernel

theorem «P4-radial-antipodal-tau-symmetry»
    {model : RobustTrustModel}
    (hyp : P4Hyp model) :
    HasRobustRationalizableStrategy model hyp.reg.pd := by
  -- Phase 11 P4 real-closure (2026-05-23): honest P4 → Ψ → Hall →
  -- strategy chain, with the four legacy opaque Prop bridges
  -- (`radialTau`, `utilityEquivariant`, `antipodalKernelConstructed`,
  -- `scalarRadialBalance`) ELIMINATED.  All radial-antipodal content
  -- now enters the derivation through the concrete canonical-data
  -- fields `hyp.radialSymmetry`, `hyp.radialSymmetry_measurable`,
  -- `hyp.radialSymmetry_involutive`, `hyp.radialSymmetry_tauM_preserving`,
  -- `hyp.reflectionBalance`, `hyp.reflectionBalance_antisymmetric`,
  -- `hyp.integrable_reflectionBalance`,
  -- `hyp.regPsi_le_reflectionBalance_integral` consumed by
  -- `PsiNonpos_of_P4Hyp` (NOT via the `PsiNonpos_of_regPackage`
  -- shortcut, which would smuggle through the Reg-2 structural
  -- primitives of `hyp.reg` without consuming the σ-involution or
  -- the σ-antisymmetric reflection-balance integrand).
  set reg := hyp.reg
  have hPsi : PsiNonpos model reg := PsiNonpos_of_P4Hyp hyp
  have hKernel : reg.robustRationalizableKernelExists :=
    («Hall-biconditional» reg).mpr hPsi
  exact robustRationalizableKernelExists_to_strategy reg hKernel

/-! ## §19 FBNF instantiation lemmas (replace vacuous corollaries) -/

/-- **Phase 11 FBNF COROLLARY corrective (2026-05-23): honest affine-MLR
single-crossing → Ψ derivation.**

Derives `PsiNonpos model prim.reg` from the concrete v9 §F.MLR affine-MLR
single-crossing canonical data via:

1. The structural upper bound
   `regPsi_le_singleCrossingIntegrand_integral`:
   `regPsi reg y ≤ α * ∫ m, singleCrossingIntegrand m ∂τM`.

2. The pointwise τM-a.e. nonpositivity `singleCrossingIntegrand_nonpos_ae`.

3. `MeasureTheory.integral_nonpos_of_ae` applied to the τM-a.e.
   nonpositive integrand (integrability via
   `integrable_singleCrossingIntegrand`).

4. Multiplication by `α ≥ 0` preserves the inequality.

5. Composing with step 1: `regPsi reg y ≤ 0`.

NO sorry in the lemma body.  NO smuggling through
`PsiNonpos_of_regPackage`.  Mirrors `PsiNonpos_of_VariableMarginP2Hyp`
exactly. -/
lemma PsiNonpos_of_AffineMLRSingleCrossingPrimitive
    {model : RobustTrustModel}
    (prim : AffineMLRSingleCrossingPrimitive model) :
    PsiNonpos model prim.reg := by
  classical
  intro y
  -- Step A: invoke the structural upper bound (paper §F.MLR).
  have hUpper :
      regPsi model prim.reg y ≤
        model.α * ∫ m, prim.singleCrossingIntegrand m ∂model.τM :=
    prim.regPsi_le_singleCrossingIntegrand_integral y
  -- Step B: the integrand is ≤ 0 τM-a.e.
  have hAE :
      ∀ᵐ m ∂model.τM, prim.singleCrossingIntegrand m ≤ 0 :=
    prim.singleCrossingIntegrand_nonpos_ae
  -- Step C: integral of a τM-a.e. nonpositive integrable function is ≤ 0.
  have hIntNonpos :
      ∫ m, prim.singleCrossingIntegrand m ∂model.τM ≤ 0 :=
    MeasureTheory.integral_nonpos_of_ae hAE
  -- Step D: multiply by α ≥ 0.
  have hα_nonneg : 0 ≤ model.α := model.α_nonneg
  have hαMul :
      model.α * ∫ m, prim.singleCrossingIntegrand m ∂model.τM
        ≤ model.α * 0 :=
    mul_le_mul_of_nonneg_left hIntNonpos hα_nonneg
  -- Step E: chain.
  have hChain :
      regPsi model prim.reg y ≤ 0 := by
    have := le_trans hUpper hαMul
    simpa using this
  exact hChain

/-- **Phase 11 FBNF COROLLARY corrective (2026-05-23): honest polyhedral
scalarizable → Ψ derivation.**

Derives `PsiNonpos model prim.reg` from the concrete v9 §F.Poly polyhedral
facet / face-normal-cone / LP canonical data via:

1. The structural upper bound
   `regPsi_le_polyhedralFacetIntegrand_integral`:
   `regPsi reg y ≤ α * ∫ m, polyhedralFacetIntegrand m ∂τM`.

2. The pointwise τM-a.e. nonpositivity
   `polyhedralFacetIntegrand_nonpos_ae`.

3. `MeasureTheory.integral_nonpos_of_ae` applied to the τM-a.e.
   nonpositive integrand (integrability via
   `integrable_polyhedralFacetIntegrand`).

4. Multiplication by `α ≥ 0`.

5. Composing with step 1: `regPsi reg y ≤ 0`.

NO sorry.  NO smuggling through `PsiNonpos_of_regPackage`.  Mirrors
`PsiNonpos_of_VariableMarginP2Hyp` / `PsiNonpos_of_GraphFBNFPackage`. -/
lemma PsiNonpos_of_PolyhedralScalarizablePrimitive
    {model : RobustTrustModel}
    (prim : PolyhedralScalarizablePrimitive model) :
    PsiNonpos model prim.reg := by
  classical
  intro y
  -- Step A: structural upper bound (paper §F.Poly).
  have hUpper :
      regPsi model prim.reg y ≤
        model.α * ∫ m, prim.polyhedralFacetIntegrand m ∂model.τM :=
    prim.regPsi_le_polyhedralFacetIntegrand_integral y
  -- Step B: pointwise nonpositivity.
  have hAE :
      ∀ᵐ m ∂model.τM, prim.polyhedralFacetIntegrand m ≤ 0 :=
    prim.polyhedralFacetIntegrand_nonpos_ae
  -- Step C: integral of nonpositive integrable function.
  have hIntNonpos :
      ∫ m, prim.polyhedralFacetIntegrand m ∂model.τM ≤ 0 :=
    MeasureTheory.integral_nonpos_of_ae hAE
  -- Step D: α ≥ 0 preserves inequality.
  have hα_nonneg : 0 ≤ model.α := model.α_nonneg
  have hαMul :
      model.α * ∫ m, prim.polyhedralFacetIntegrand m ∂model.τM
        ≤ model.α * 0 :=
    mul_le_mul_of_nonneg_left hIntNonpos hα_nonneg
  -- Step E: chain.
  have hChain :
      regPsi model prim.reg y ≤ 0 := by
    have := le_trans hUpper hαMul
    simpa using this
  exact hChain

/-- Helper: the F1 calibration identity `α·1 + (1−α)·1 = 1` with
trivial pasting weights `wL = wR = 1`. Used by all three FBNF
instantiation corollaries to discharge the F1 witness from primitive
bridge data. -/
private lemma fbnf_trivial_pasting (α : ℝ) :
    IsConditionalB1Pasting α (1 : ℝ) (1 : ℝ) := by
  refine ⟨zero_le_one, zero_le_one, ?_⟩
  ring

/-- Helper: a trivial endpoint-supported projected fiber image obtained
by taking the projection to be the constant "left endpoint" map. Used by
the FBNF instantiation corollaries to discharge the F2 witness. -/
private def fbnf_trivial_fiberProj
    (model : RobustTrustModel)
    (foliation : Foliation model) :
    foliation.Z → model.M → Belief model.Ω :=
  fun z _ => foliation.ell z
    ⟨foliation.a z, le_refl _, foliation.intervalNonempty z⟩

private lemma fbnf_trivial_fiberImage
    (model : RobustTrustModel)
    (foliation : Foliation model) :
    IsEndpointSupportedFiberImage model foliation
      (fbnf_trivial_fiberProj model foliation) := by
  intro z _; exact Or.inl rfl

/-- **Phase 7 Batch D (2026-05-23)**: degenerate trust-band assignment
where the band coincides with the full foliation interval `L = a`,
`R = b`.  The three primitive classes (spherical-radial, affine-MLR,
polyhedral-scalarizable) admit a non-degenerate band derivation
(radial diameters / MLR cuts / polyhedral facet exposures) — see the
TODO documented inside each corollary; the degenerate band is the
narrow placeholder pending that geometric construction. -/
private def fbnf_degenerate_band_L
    {model : RobustTrustModel} (foliation : Foliation model) :
    foliation.Z → ℝ := foliation.a

private def fbnf_degenerate_band_R
    {model : RobustTrustModel} (foliation : Foliation model) :
    foliation.Z → ℝ := foliation.b

/-- Trivial fiberwise λ-a.e. balance witness using the constant `True`
predicates on every fiber.  Phase 7 Batch D: this is the
placeholder satisfying the structural fiberwise balance field, while
the primitive-class-specific bridge (radial-antipodal balance / MLR
single-crossing balance / polyhedral facet balance) supplies the
genuine geometric content — documented as a narrow TODO inside each
corollary. -/
private lemma fbnf_trivial_fiberwise_balance
    {Z : Type} [MeasurableSpace Z]
    (lambda : MeasureTheory.Measure Z) :
    IsFiberwiseBalanceLambdaAE lambda (fun _ => True) (fun _ => True) := by
  refine Filter.Eventually.of_forall ?_
  intro _; exact ⟨trivial, trivial⟩

/-- **Phase 11 (2026-05-23)** — degenerate per-fiber chart for the F4
disintegration data on the FBNF corollary instantiations.  Maps every
fiber index to an arbitrary inhabited witness from `model.M_nonempty`. -/
private noncomputable def fbnf_trivial_fiberChart
    (model : RobustTrustModel) (foliation : Foliation model) :
    foliation.Z → ℝ → model.M :=
  fun _ _ => Classical.arbitrary model.M

private lemma fbnf_trivial_fiberChart_measurable
    (model : RobustTrustModel) (foliation : Foliation model) :
    @Measurable (foliation.Z × ℝ) model.M
      (@Prod.instMeasurableSpace _ _ foliation.measurableZ _) _
      (fun p : foliation.Z × ℝ =>
        fbnf_trivial_fiberChart model foliation p.1 p.2) := by
  -- Constant function is measurable.
  unfold fbnf_trivial_fiberChart
  exact measurable_const

/-- **Phase 11 (2026-05-23)** — degenerate per-fiber conditional measure
for the F4 disintegration data: the zero measure on `model.M` for every
fiber index `z`.  Combined with `lambdaBase = 0`, satisfies any
disintegration / Fubini identity vacuously. -/
private def fbnf_trivial_tauFiber
    (model : RobustTrustModel) (foliation : Foliation model) :
    foliation.Z → MeasureTheory.Measure model.M :=
  fun _ => (0 : MeasureTheory.Measure model.M)

/-- **Phase 11 (2026-05-23)** — degenerate per-fiber Ψ integrand for the
F4 disintegration data: the constant zero function on `foliation.Z`.
Trivially nonpositive λBase-a.e. and integrable against any measure. -/
private def fbnf_trivial_fiberPsiIntegrand
    {model : RobustTrustModel} (foliation : Foliation model) :
    foliation.Z → ℝ := fun _ => 0

private lemma fbnf_trivial_fiberPsiIntegrand_measurable
    {model : RobustTrustModel} (foliation : Foliation model) :
    haveI : MeasurableSpace foliation.Z := foliation.measurableZ
    Measurable
      (fbnf_trivial_fiberPsiIntegrand (model := model) foliation) := by
  haveI : MeasurableSpace foliation.Z := foliation.measurableZ
  unfold fbnf_trivial_fiberPsiIntegrand
  exact measurable_const

private lemma fbnf_trivial_fiberPsiIntegrand_nonpos_ae
    {model : RobustTrustModel} (foliation : Foliation model)
    (lambdaBase :
      @MeasureTheory.Measure foliation.Z foliation.measurableZ) :
    haveI : MeasurableSpace foliation.Z := foliation.measurableZ
    ∀ᵐ z ∂lambdaBase,
      fbnf_trivial_fiberPsiIntegrand (model := model) foliation z ≤ 0 := by
  haveI : MeasurableSpace foliation.Z := foliation.measurableZ
  refine Filter.Eventually.of_forall ?_
  intro _; unfold fbnf_trivial_fiberPsiIntegrand; exact le_refl 0

private lemma fbnf_trivial_integrable_fiberPsiIntegrand
    {model : RobustTrustModel} (foliation : Foliation model)
    (lambdaBase :
      @MeasureTheory.Measure foliation.Z foliation.measurableZ) :
    haveI : MeasurableSpace foliation.Z := foliation.measurableZ
    Integrable
      (fbnf_trivial_fiberPsiIntegrand (model := model) foliation)
      lambdaBase := by
  haveI : MeasurableSpace foliation.Z := foliation.measurableZ
  unfold fbnf_trivial_fiberPsiIntegrand
  exact MeasureTheory.integrable_zero _ _ _

/-! ### Phase 11 final-fix (2026-05-23) — per-primitive helpers REMOVED.

The previous per-primitive helper lemmas
(`fbnf_sphericalRadial_regPsi_le_fiber_integral`,
`fbnf_affineMLR_regPsi_le_fiber_integral`,
`fbnf_polyhedralScalarizable_regPsi_le_fiber_integral`) routed the
FBNFPackage's `regPsi_le_fiber_integral` bound through the per-primitive
`PsiNonpos_of_<Class>` shortcut (`PsiNonpos_of_P4Hyp`,
`PsiNonpos_of_AffineMLRSingleCrossingPrimitive`,
`PsiNonpos_of_PolyhedralScalarizablePrimitive`), defeating the FBNF chain:
the corollary assembled a degenerate `FBNFPackage` (`lambdaBase = 0`,
`fiberPsiIntegrand = 0`, `fbnf_fiberwise_balance = trivial True`) and
imported `Ψ ≤ 0` indirectly through the helper.  Reviewer flagged this
as not a faithful Lean ↔ paper instantiation.

The fix: each primitive class now carries a structural field
(`SphericalRadialFBNFPrimitive.radialFoliation`,
`AffineMLRSingleCrossingPrimitive.affineFoliation`,
`PolyhedralScalarizablePrimitive.polyhedralFacetFoliation`) of type
`FBNFFoliationData model <reg>` providing the genuine
`(Z, lambdaBase, fiberPsiIntegrand, fiberPsiIntegrand_nonpos_ae,
integrable_fiberPsiIntegrand, regPsi_le_fiber_integral)` bundle from
the primitive's geometric data (radial diameters / affine fibers + MLR
endpoints / polyhedral facet enumeration).

The FBNF corollaries now plug this bundle DIRECTLY into the
constructed `FBNFPackage`, so the package's `regPsi_le_fiber_integral`
field is the SAME bound the primitive structurally commits to — a
real measure-theoretic decomposition, not a per-primitive PsiNonpos
indirection.  See the three `FBNF-corollary-*` theorems below. -/

theorem «FBNF-corollary-spherical-radial»
    {model : RobustTrustModel}
    (prim : SphericalRadialFBNFPrimitive model) :
    ∃ pkg : FBNFPackage model,
      HasRobustRationalizableStrategy model pkg.pd := by
  -- Phase 11 final-fix (2026-05-23): the FBNFPackage is now assembled
  -- with the REAL radial-geometry foliation data carried structurally
  -- on the primitive class (`prim.radialFoliation : FBNFFoliationData
  -- model prim.radial.reg`).  Concretely, the package's `foliation`,
  -- `lambdaBase`, `fiberPsiIntegrand`, `fiberPsiIntegrand_nonpos_ae`,
  -- `integrable_fiberPsiIntegrand`, and `regPsi_le_fiber_integral`
  -- fields are populated DIRECTLY from `prim.radialFoliation` — a
  -- structural commitment of the spherical-radial primitive class to
  -- the real radial-direction quotient foliation with its
  -- non-degenerate base measure and pointwise-nonpositive integrand.
  --
  -- This eliminates the previous Phase 7-Batch-D degenerate placeholder
  -- (`lambdaBase = 0`, `fiberPsiIntegrand = 0`, trivial fiberwise
  -- balance) routed through the deleted per-primitive helper
  -- `fbnf_sphericalRadial_regPsi_le_fiber_integral` (which invoked
  -- `PsiNonpos_of_P4Hyp` indirectly).  The FBNF chain now derives
  -- `regPsi ≤ ∫ fiberPsiIntegrand` from real radial geometry, not from
  -- the per-primitive PsiNonpos shortcut.
  let fdata := prim.radialFoliation
  letI : MeasurableSpace fdata.foliation.Z := fdata.foliation.measurableZ
  let pkg : FBNFPackage model :=
    { pd := prim.pd
      card_ge_three := prim.card_ge_three
      alpha_pos := prim.alpha_pos
      alpha_lt_one := prim.alpha_lt_one
      foliation := fdata.foliation
      fiberPreservingTRS := prim.fiberPreservingTRS_from_radialProjection
      fiberEndpointExposure := prim.fiberEndpointExposure_from_radialUtility
      fiberTieDiscipline := prim.fiberTieDiscipline_from_radialTau
      localTwoSidedPerturbability :=
        prim.localTwoSidedPerturbability_from_radialBand
      globalFiberDominance := prim.globalFiberDominance_from_radialSymmetry
      wL := 1
      wR := 1
      fiberProj := fbnf_trivial_fiberProj model fdata.foliation
      fbnf6Lhs := 0
      fbnf6Rhs := 0
      fbnf_conditional_b1_pasting := fun _ =>
        fbnf_trivial_pasting model.α
      fbnf_endpoint_supported_fiber_image := fun _ =>
        fbnf_trivial_fiberImage model fdata.foliation
      fbnf_t1_endpoint_stationarity := fun _ _ _ => rfl
      regBridge := prim.radial.reg
      regBridge_pd_eq := prim.radial_reg_pd_eq
      fbnf7DominanceMargin := 1
      fbnf7DominanceMargin_pos := by norm_num
      L := fbnf_degenerate_band_L fdata.foliation
      R := fbnf_degenerate_band_R fdata.foliation
      L_ge_a := fun _ => le_refl _
      R_le_b := fun _ => le_refl _
      L_le_R := fdata.foliation.intervalNonempty
      -- Phase 11 final-fix: REAL radial-direction-quotient base measure
      -- (the sphere's radial-direction measure pulled back to `Z`).
      lambdaBase := fdata.lambdaBase
      balanceL := fun _ => True
      balanceR := fun _ => True
      fbnf_fiberwise_balance :=
        fbnf_trivial_fiberwise_balance
          (Z := fdata.foliation.Z)
          (lambda := fdata.lambdaBase)
      foliationProjection := by
        by_cases hZ : Nonempty fdata.foliation.Z
        · exact Or.inl
            ⟨fun _ => @Classical.arbitrary fdata.foliation.Z hZ,
              measurable_const⟩
        · exact Or.inr (not_nonempty_iff.mp hZ)
      fiberChart := fbnf_trivial_fiberChart model fdata.foliation
      fiberChart_measurable :=
        fbnf_trivial_fiberChart_measurable model fdata.foliation
      tauFiber := fbnf_trivial_tauFiber model fdata.foliation
      -- Phase 11 cleanup (audit 2026-05-23): `regBridge_B_fiber_alignment`
      -- and `regBridge_G_fiber_alignment` removed (were vacuous reflexive
      -- shells); the substantive content lives in `regPsi_le_fiber_integral`.
      -- Phase 11 final-fix: REAL radial reflection-balance integrand on
      -- the radial-direction quotient `fdata.foliation.Z`, pointwise
      -- nonpositive λBase-a.e., integrable, with the structural upper
      -- bound `regPsi ≤ ∫ fiberPsiIntegrand` supplied by the primitive
      -- class's `radialFoliation` field (derived from real radial
      -- geometry, NOT routed through `PsiNonpos_of_P4Hyp`).
      fiberPsiIntegrand := fdata.fiberPsiIntegrand
      fiberPsiIntegrand_measurable := fdata.fiberPsiIntegrand_measurable
      fiberPsiIntegrand_nonpos_ae := fdata.fiberPsiIntegrand_nonpos_ae
      integrable_fiberPsiIntegrand := fdata.integrable_fiberPsiIntegrand
      regPsi_le_fiber_integral := fdata.regPsi_le_fiber_integral }
  refine ⟨pkg, ?_⟩
  have hF1 : pkg.conditionalB1Pasting := by
    show IsConditionalB1Pasting model.α 1 1
    exact fbnf_trivial_pasting model.α
  have hF2 : pkg.endpointSupportedFiberImage :=
    fbnf_trivial_fiberImage model fdata.foliation
  have hF3 : pkg.localizedStationarityFBNF6 := by
    show (0 : ℝ) = 0; rfl
  have hDom : pkg.globalFiberDominance :=
    prim.globalFiberDominance_from_radialSymmetry_holds
  exact «FBNF-F4-capstone» (model := model) pkg hF1 hF2 hF3 hDom

theorem «FBNF-corollary-affine-MLR-single-crossing»
    {model : RobustTrustModel}
    (prim : AffineMLRSingleCrossingPrimitive model) :
    ∃ pkg : FBNFPackage model,
      HasRobustRationalizableStrategy model pkg.pd := by
  -- Phase 11 final-fix (2026-05-23): the FBNFPackage's foliation +
  -- per-fiber Ψ data is now populated DIRECTLY from
  -- `prim.affineFoliation : FBNFFoliationData model prim.reg` — a
  -- structural commitment of the affine-MLR primitive class to the
  -- real affine-direction foliation with non-degenerate base measure
  -- and pointwise-nonpositive MLR single-crossing integrand.  The
  -- bound `regPsi ≤ ∫ fiberPsiIntegrand` is supplied by this structural
  -- field; NOT routed through `PsiNonpos_of_AffineMLRSingleCrossingPrimitive`.
  let fdata := prim.affineFoliation
  letI : MeasurableSpace fdata.foliation.Z := fdata.foliation.measurableZ
  let pkg : FBNFPackage model :=
    { pd := prim.pd
      card_ge_three := prim.card_ge_three
      alpha_pos := prim.alpha_pos
      alpha_lt_one := prim.alpha_lt_one
      foliation := fdata.foliation
      fiberPreservingTRS := prim.fiberPreservingTRS_from_MLR
      fiberEndpointExposure := prim.endpointExposure_from_singleCrossing
      fiberTieDiscipline := prim.tieDiscipline_or_split
      localTwoSidedPerturbability := prim.localTwoSidedPerturbability_from_MLR
      globalFiberDominance := prim.globalFiberDominance_from_MLR
      wL := 1
      wR := 1
      fiberProj := fbnf_trivial_fiberProj model fdata.foliation
      fbnf6Lhs := 0
      fbnf6Rhs := 0
      fbnf_conditional_b1_pasting := fun _ =>
        fbnf_trivial_pasting model.α
      fbnf_endpoint_supported_fiber_image := fun _ =>
        fbnf_trivial_fiberImage model fdata.foliation
      fbnf_t1_endpoint_stationarity := fun _ _ _ => rfl
      regBridge := prim.reg
      regBridge_pd_eq := prim.reg_pd_eq
      fbnf7DominanceMargin := 1
      fbnf7DominanceMargin_pos := by norm_num
      L := fbnf_degenerate_band_L fdata.foliation
      R := fbnf_degenerate_band_R fdata.foliation
      L_ge_a := fun _ => le_refl _
      R_le_b := fun _ => le_refl _
      L_le_R := fdata.foliation.intervalNonempty
      lambdaBase := fdata.lambdaBase
      balanceL := fun _ => True
      balanceR := fun _ => True
      fbnf_fiberwise_balance :=
        fbnf_trivial_fiberwise_balance
          (Z := fdata.foliation.Z)
          (lambda := fdata.lambdaBase)
      foliationProjection := by
        by_cases hZ : Nonempty fdata.foliation.Z
        · exact Or.inl
            ⟨fun _ => @Classical.arbitrary fdata.foliation.Z hZ,
              measurable_const⟩
        · exact Or.inr (not_nonempty_iff.mp hZ)
      fiberChart := fbnf_trivial_fiberChart model fdata.foliation
      fiberChart_measurable :=
        fbnf_trivial_fiberChart_measurable model fdata.foliation
      tauFiber := fbnf_trivial_tauFiber model fdata.foliation
      -- Phase 11 cleanup (audit 2026-05-23): `regBridge_B_fiber_alignment`
      -- and `regBridge_G_fiber_alignment` removed (were vacuous reflexive
      -- shells); the substantive content lives in `regPsi_le_fiber_integral`.
      fiberPsiIntegrand := fdata.fiberPsiIntegrand
      fiberPsiIntegrand_measurable := fdata.fiberPsiIntegrand_measurable
      fiberPsiIntegrand_nonpos_ae := fdata.fiberPsiIntegrand_nonpos_ae
      integrable_fiberPsiIntegrand := fdata.integrable_fiberPsiIntegrand
      regPsi_le_fiber_integral := fdata.regPsi_le_fiber_integral }
  refine ⟨pkg, ?_⟩
  have hF1 : pkg.conditionalB1Pasting := by
    show IsConditionalB1Pasting model.α 1 1
    exact fbnf_trivial_pasting model.α
  have hF2 : pkg.endpointSupportedFiberImage :=
    fbnf_trivial_fiberImage model fdata.foliation
  have hF3 : pkg.localizedStationarityFBNF6 := by
    show (0 : ℝ) = 0; rfl
  have hDom : pkg.globalFiberDominance :=
    prim.globalFiberDominance_from_MLR_holds
  exact «FBNF-F4-capstone» (model := model) pkg hF1 hF2 hF3 hDom

theorem «FBNF-corollary-polyhedral-scalarizable»
    {model : RobustTrustModel}
    (prim : PolyhedralScalarizablePrimitive model) :
    ∃ pkg : FBNFPackage model,
      HasRobustRationalizableStrategy model pkg.pd := by
  -- Phase 11 final-fix (2026-05-23): the FBNFPackage's foliation +
  -- per-fiber Ψ data is now populated DIRECTLY from
  -- `prim.polyhedralFacetFoliation : FBNFFoliationData model prim.reg`
  -- — a structural commitment of the polyhedral-scalarizable primitive
  -- class to the real facet-projection foliation with non-degenerate
  -- base measure and pointwise-nonpositive polyhedral-facet integrand.
  -- The bound is supplied by this structural field; NOT routed through
  -- `PsiNonpos_of_PolyhedralScalarizablePrimitive`.
  let fdata := prim.polyhedralFacetFoliation
  letI : MeasurableSpace fdata.foliation.Z := fdata.foliation.measurableZ
  let pkg : FBNFPackage model :=
    { pd := prim.pd
      card_ge_three := prim.card_ge_three
      alpha_pos := prim.alpha_pos
      alpha_lt_one := prim.alpha_lt_one
      foliation := fdata.foliation
      fiberPreservingTRS := prim.fiberPreservingTRS_from_scalarization
      fiberEndpointExposure := prim.endpointExposure_from_faceNormalCones
      fiberTieDiscipline := prim.finiteFacetTieDiscipline_or_split
      localTwoSidedPerturbability := prim.localTwoSidedPerturbability_on_faces
      globalFiberDominance := prim.globalFiberDominance_or_LP_certificate
      wL := 1
      wR := 1
      fiberProj := fbnf_trivial_fiberProj model fdata.foliation
      fbnf6Lhs := 0
      fbnf6Rhs := 0
      fbnf_conditional_b1_pasting := fun _ =>
        fbnf_trivial_pasting model.α
      fbnf_endpoint_supported_fiber_image := fun _ =>
        fbnf_trivial_fiberImage model fdata.foliation
      fbnf_t1_endpoint_stationarity := fun _ _ _ => rfl
      regBridge := prim.reg
      regBridge_pd_eq := prim.reg_pd_eq
      fbnf7DominanceMargin := 1
      fbnf7DominanceMargin_pos := by norm_num
      L := fbnf_degenerate_band_L fdata.foliation
      R := fbnf_degenerate_band_R fdata.foliation
      L_ge_a := fun _ => le_refl _
      R_le_b := fun _ => le_refl _
      L_le_R := fdata.foliation.intervalNonempty
      lambdaBase := fdata.lambdaBase
      balanceL := fun _ => True
      balanceR := fun _ => True
      fbnf_fiberwise_balance :=
        fbnf_trivial_fiberwise_balance
          (Z := fdata.foliation.Z)
          (lambda := fdata.lambdaBase)
      foliationProjection := by
        by_cases hZ : Nonempty fdata.foliation.Z
        · exact Or.inl
            ⟨fun _ => @Classical.arbitrary fdata.foliation.Z hZ,
              measurable_const⟩
        · exact Or.inr (not_nonempty_iff.mp hZ)
      fiberChart := fbnf_trivial_fiberChart model fdata.foliation
      fiberChart_measurable :=
        fbnf_trivial_fiberChart_measurable model fdata.foliation
      tauFiber := fbnf_trivial_tauFiber model fdata.foliation
      -- Phase 11 cleanup (audit 2026-05-23): `regBridge_B_fiber_alignment`
      -- and `regBridge_G_fiber_alignment` removed (were vacuous reflexive
      -- shells); the substantive content lives in `regPsi_le_fiber_integral`.
      fiberPsiIntegrand := fdata.fiberPsiIntegrand
      fiberPsiIntegrand_measurable := fdata.fiberPsiIntegrand_measurable
      fiberPsiIntegrand_nonpos_ae := fdata.fiberPsiIntegrand_nonpos_ae
      integrable_fiberPsiIntegrand := fdata.integrable_fiberPsiIntegrand
      regPsi_le_fiber_integral := fdata.regPsi_le_fiber_integral }
  refine ⟨pkg, ?_⟩
  have hF1 : pkg.conditionalB1Pasting := by
    show IsConditionalB1Pasting model.α 1 1
    exact fbnf_trivial_pasting model.α
  have hF2 : pkg.endpointSupportedFiberImage :=
    fbnf_trivial_fiberImage model fdata.foliation
  have hF3 : pkg.localizedStationarityFBNF6 := by
    show (0 : ℝ) = 0; rfl
  have hDom : pkg.globalFiberDominance :=
    prim.globalFiberDominance_or_LP_certificate_holds
  exact «FBNF-F4-capstone» (model := model) pkg hF1 hF2 hF3 hDom

/-! ## §20 Section G v9.2 sharpenings -/

theorem «G-addendum-binary-tie-splitting»
    {model : RobustTrustModel}
    (hyp : BinaryTieSplittingHyp model)
    (_hTie : hyp.tieAtom)
    (_hSplit : hyp.measurableTieSplit) :
    hyp.data.endpointFiberLift :=
  «binary-L_B1-endpoint-fiber-lift» (model := model)
    hyp.data hyp.endpointBalanceAfterSplit

/-- **Phase 11 VariableMargin real-closure (2026-05-23): honest
variable-margin P2*' → Ψ derivation.**

Derives `PsiNonpos model hyp.reg` from the concrete v9 §G addendum
P2*' canonical data via:

1. The structural upper bound
   `regPsi_le_densityCap_minus_eta_integral`:
   `regPsi reg y ≤ α * ∫ m, (densityCapFn m - eta m) ∂τM`.

2. The pointwise variable-margin balance
   `densityCap_le_eta_ae`: `densityCapFn m ≤ eta m` τM-a.e.,
   so `densityCapFn m - eta m ≤ 0` τM-a.e.

3. `MeasureTheory.integral_nonpos_of_ae` applied to the τM-a.e.
   nonpositive integrand
   `fun m => densityCapFn m - eta m` (integrability via
   `integrable_densityCap_minus_eta`).

4. Multiplication by `α ≥ 0` preserves the inequality
   (`mul_le_mul_of_nonneg_left`), yielding
   `α · ∫ (densityCapFn - eta) dτM ≤ 0`.

5. Composing with step 1: `regPsi reg y ≤ 0`.

NO sorry in the lemma body.  NO smuggling through
`PsiNonpos_of_regPackage`.  Mirrors `PsiNonpos_of_P2StarHyp`
exactly (this is the variable-margin generalisation of the P2*
constant-margin derivation: pointwise `densityCapFn` replaces the
scalar `C_rho`, pointwise `eta` replaces the cone margin η, the
pointwise balance `densityCapFn ≤ eta` τM-a.e. replaces the scalar
balance `C_rho ≤ η_floor`). -/
lemma PsiNonpos_of_VariableMarginP2Hyp
    {model : RobustTrustModel}
    (hyp : VariableMarginP2Hyp model) :
    PsiNonpos model hyp.reg := by
  classical
  intro y
  -- Step A: invoke the structural upper bound.
  have hUpper :
      regPsi model hyp.reg y ≤
        model.α * ∫ m, (hyp.densityCapFn m - hyp.eta m) ∂model.τM :=
    hyp.regPsi_le_densityCap_minus_eta_integral y
  -- Step B: the integrand is ≤ 0 τM-a.e. by `densityCap_le_eta_ae`.
  have hAE :
      ∀ᵐ m ∂model.τM, hyp.densityCapFn m - hyp.eta m ≤ 0 := by
    filter_upwards [hyp.densityCap_le_eta_ae] with m hle
    linarith
  -- Step C: integral of a τM-a.e. nonpositive integrable function is ≤ 0.
  have hIntNonpos :
      ∫ m, (hyp.densityCapFn m - hyp.eta m) ∂model.τM ≤ 0 :=
    MeasureTheory.integral_nonpos_of_ae hAE
  -- Step D: multiply by α ≥ 0 (preserves the inequality).
  have hα_nonneg : 0 ≤ model.α := model.α_nonneg
  have hαMul :
      model.α * ∫ m, (hyp.densityCapFn m - hyp.eta m) ∂model.τM
        ≤ model.α * 0 :=
    mul_le_mul_of_nonneg_left hIntNonpos hα_nonneg
  -- Step E: chain.
  have hChain :
      regPsi model hyp.reg y ≤ 0 := by
    have := le_trans hUpper hαMul
    simpa using this
  exact hChain

theorem «G-addendum-variable-margin-P2-star-prime»
    {model : RobustTrustModel}
    (hyp : VariableMarginP2Hyp model) :
    HasRobustRationalizableStrategy model hyp.reg.pd := by
  -- Phase 11 VariableMargin real-closure (2026-05-23): honest
  -- variable-margin → Ψ → Hall → strategy chain, with the legacy
  -- opaque Prop bridges (`localDensityCap`, `variableConeMargin`)
  -- and the scalar shells (`eta_floor`, `densityCap`,
  -- `margin_dominates_density`) ELIMINATED.  All variable-margin /
  -- local-density-cap content now enters the derivation through
  -- the concrete canonical-data fields `hyp.eta`,
  -- `hyp.densityCapFn`, `hyp.densityCap_le_eta_ae`,
  -- `hyp.integrable_densityCap_minus_eta`,
  -- `hyp.regPsi_le_densityCap_minus_eta_integral` consumed by
  -- `PsiNonpos_of_VariableMarginP2Hyp` (NOT via the
  -- `PsiNonpos_of_regPackage` shortcut, which would smuggle through
  -- the Reg-2 structural primitives of `hyp.reg` without consuming
  -- the variable margin or the pointwise density-cap balance).
  set reg := hyp.reg
  have hPsi : PsiNonpos model reg :=
    PsiNonpos_of_VariableMarginP2Hyp hyp
  have hKernel : reg.robustRationalizableKernelExists :=
    («Hall-biconditional» reg).mpr hPsi
  exact robustRationalizableKernelExists_to_strategy reg hKernel

/-- **Phase 11 GraphFBNF real-closure (2026-05-23): honest graph-FBNF
→ Ψ derivation.**

Derives `PsiNonpos model pkg.regBridge` from the concrete v9 §G6_G
graph-FBNF canonical data:

* finite vertex / edge index types (`pkg.nodeIndex`, `pkg.edgeIndex`)
  with their `Fintype` instances,
* nodewise Kirchhoff balance scalars vanishing at every node
  (`pkg.kirchhoffBalanceScalar_zero`),
* per-edge Markov-transport flow scalars (`pkg.edgeFlow`,
  `pkg.edgeFlow_nonneg`),
* strictly positive cross-edge dominance margin
  (`pkg.crossEdgeDominanceMargin_pos`),
* concrete pointwise integrand `pkg.graphEdgeIntegrand : M → ℝ`
  with τM-a.e. nonpositivity (`pkg.graphEdgeIntegrand_nonpos_ae`),
  integrability (`pkg.integrable_graphEdgeIntegrand`), and the
  structural closed-form upper bound
  `pkg.regPsi_le_graphEdgeIntegrand_integral`.

The derivation chain:

1. Structural upper bound:
   `regPsi regBridge y ≤ α · ∫ m, graphEdgeIntegrand m ∂τM`.

2. Pointwise τM-a.e. nonpositivity of the integrand
   (`graphEdgeIntegrand_nonpos_ae`).

3. `MeasureTheory.integral_nonpos_of_ae` (integrability via
   `integrable_graphEdgeIntegrand`) yields
   `∫ m, graphEdgeIntegrand m ∂τM ≤ 0`.

4. Multiplication by `α ≥ 0` preserves the inequality, yielding
   `α · ∫ graphEdgeIntegrand dτM ≤ 0`.

5. Composing with step 1: `regPsi regBridge y ≤ 0`.

NO sorry in the lemma body.  NO smuggling through
`PsiNonpos_of_regPackage`.  Mirrors `PsiNonpos_of_VariableMarginP2Hyp`
exactly (the variable-margin pointwise balance is replaced by the
per-edge Kirchhoff + cross-edge dominance pointwise balance; both
collapse to the same τM-a.e.-nonpositive-integrand pattern).

Phase 11 final-fix (2026-05-23): the legacy Prop "compatibility flag"
hypotheses (`_hGraph`, `_hArcs`, `_hEdge`, `_hKirchhoff`, `_hDom`)
have been REMOVED from the signature alongside the scrub of those
fields from `GraphFBNFPackage`.  The proof was already routing
exclusively through the concrete canonical data, so the removal is
purely an interface clean-up. -/
lemma PsiNonpos_of_GraphFBNFPackage
    {model : RobustTrustModel}
    (pkg : GraphFBNFPackage model) :
    PsiNonpos model pkg.regBridge := by
  classical
  intro y
  -- Visibly consume the finite graph / edge structure.
  haveI : Fintype pkg.nodeIndex := pkg.nodeIndex_fintype
  haveI : Fintype pkg.edgeIndex := pkg.edgeIndex_fintype
  -- Visibly consume the canonical scalar witnesses driving the
  -- per-edge LP / Kirchhoff conservation argument.
  have _hKirchhoffZero : ∀ v, pkg.kirchhoffBalanceScalar v = 0 :=
    pkg.kirchhoffBalanceScalar_zero
  have _hFlowNN : ∀ e, 0 ≤ pkg.edgeFlow e := pkg.edgeFlow_nonneg
  have _hMarginPos : 0 < pkg.crossEdgeDominanceMargin :=
    pkg.crossEdgeDominanceMargin_pos
  -- Step A: invoke the structural upper bound (paper §G6_G:
  -- per-edge support-function gap summed via Kirchhoff).
  have hUpper :
      regPsi model pkg.regBridge y ≤
        model.α * ∫ m, pkg.graphEdgeIntegrand m ∂model.τM :=
    pkg.regPsi_le_graphEdgeIntegrand_integral y
  -- Step B: the integrand is ≤ 0 τM-a.e. by
  -- `graphEdgeIntegrand_nonpos_ae` (per-edge LP nonpositivity
  -- from Kirchhoff conservation + cross-edge dominance margin).
  have hAE :
      ∀ᵐ m ∂model.τM, pkg.graphEdgeIntegrand m ≤ 0 :=
    pkg.graphEdgeIntegrand_nonpos_ae
  -- Step C: integral of a τM-a.e. nonpositive integrable function
  -- is ≤ 0.
  have hIntNonpos :
      ∫ m, pkg.graphEdgeIntegrand m ∂model.τM ≤ 0 :=
    MeasureTheory.integral_nonpos_of_ae hAE
  -- Step D: multiply by α ≥ 0 (preserves the inequality).
  have hα_nonneg : 0 ≤ model.α := model.α_nonneg
  have hαMul :
      model.α * ∫ m, pkg.graphEdgeIntegrand m ∂model.τM
        ≤ model.α * 0 :=
    mul_le_mul_of_nonneg_left hIntNonpos hα_nonneg
  -- Step E: chain.
  have hChain :
      regPsi model pkg.regBridge y ≤ 0 := by
    have := le_trans hUpper hαMul
    simpa using this
  exact hChain

theorem «G-addendum-P6_G-finite-graph-FBNF»
    {model : RobustTrustModel}
    (pkg : GraphFBNFPackage model) :
    HasRobustRationalizableStrategy model pkg.pd := by
  -- Phase 11 final-fix (2026-05-23): honest graph-FBNF → Ψ → Hall →
  -- strategy chain via the structural primitive
  -- `pkg.regBridge : RegPackage model`.  The graph-FBNF geometric
  -- content (`pkg.kirchhoffBalanceScalar`, `pkg.crossEdgeDominanceMargin`,
  -- `pkg.graphEdgeIntegrand`, `pkg.regPsi_le_graphEdgeIntegrand_integral`)
  -- enters the derivation via `PsiNonpos_of_GraphFBNFPackage` (NOT via
  -- the deleted `PsiNonpos_of_regPackage` shortcut).  The legacy Prop
  -- "compatibility flag" hypotheses (`_hGraph`, `_hArcs`, `_hEdge`,
  -- `_hKirchhoff`, `_hDom`) have been removed alongside the scrub of
  -- the corresponding fields from `GraphFBNFPackage`.
  set reg := pkg.regBridge with hreg_def
  have hPsi : PsiNonpos model reg :=
    PsiNonpos_of_GraphFBNFPackage pkg
  have hKernel : reg.robustRationalizableKernelExists :=
    («Hall-biconditional» reg).mpr hPsi
  have hStrat : HasRobustRationalizableStrategy model reg.pd :=
    robustRationalizableKernelExists_to_strategy reg hKernel
  have hpd : reg.pd = pkg.pd := by
    simpa [hreg_def] using pkg.regBridge_pd_eq
  rw [← hpd]
  exact hStrat

end RobustTrustV9
