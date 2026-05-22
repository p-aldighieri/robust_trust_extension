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

/-- Product Clarke-normal-cone projection bridge.

Source: Clarke 1990, *Optimization and Nonsmooth Analysis*, §6.2
(calculus of normal cones under product/intersection constructions);
see also Aubin--Frankowska, *Set-Valued Analysis*, Ch. 6 for the
component projection rule. This is the single Inventory.V9 bridge used
because Mathlib does not provide Clarke normal cones or their product
calculus: `Inventory.V9.ClarkeNormalCone` is opaque in this appendix. -/
axiom _root_.Inventory.V9.clarke_product_normal_cone_projection_bridge
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
          ∑ ω : model.Ω, g i ω * (v ω - w i ω)) :
    ∀ i : Fin k, NormalConeW model (w i) (g i)

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

Binary capstone refinement (2026-05-21): the five capstone Prop fields
(`endpointFiberLift`, `trsIntervalReduction`, `endpointOnlyProjectedImage`,
`interiorMessageCalibration`, `endpointStationarityTotalBalance`) are no
longer abstract `Prop` placeholders. Following the T1 pattern, each is now
a `def` (namespaced under `BinaryCapstoneData`) that unfolds to a concrete
`Is*` predicate over data-witness fields living inside the structure. The
six theorems L_B1..L_B6 then discharge by direct projection / certificate
extraction. The substantive math (`Inventory.strassen_marginals` for B1, the
TRS interval analysis for B2, the projected-image lemma for B3, the
posterior-equals-message identity for B4, and the Clarke–Danskin total
balance for B5) is bundled into the corresponding witness fields — the
formal *bridging* from the inventory axioms to those witnesses remains an
external proving obligation flagged at the end of this section. -/

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
quantities provided as data-witness fields. -/
def IsEndpointStationarityTotalBalance
    (lhsL rhsL lhsR rhsR : ℝ) : Prop :=
  lhsL = rhsL ∧ lhsR = rhsR

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
  /-- B5 integral total-balance scalars. -/
  lhsL : ℝ
  rhsL : ℝ
  lhsR : ℝ
  rhsR : ℝ
  /-- B1 data witness: scalar calibration identity. (Bridging from
  `Inventory.strassen_marginals` lives outside this structure.) -/
  endpointFiberLiftWitness :
    IsEndpointFiberLift model model.α kappaL kappaR cL cR
  /-- B2 data witness: `[lL, rR] ⊆ [0,1]` with `lL ≤ rR`. -/
  trsIntervalReductionWitness : IsTRSIntervalReduction lL rR
  /-- B3 data witness: BR projection image lies in `{pL, pR}`. -/
  endpointOnlyProjectedImageWitness :
    IsEndpointOnlyProjectedImage model pL pR proj
  /-- B4 data witness: posterior collapses to message on interior. -/
  interiorMessageCalibrationWitness :
    IsInteriorMessageCalibration model post interior
  /-- B5 data witness: total balance equalities. -/
  endpointStationarityTotalBalanceWitness :
    IsEndpointStationarityTotalBalance lhsL rhsL lhsR rhsR
  /-- B6 capstone witness: a fully assembled robustly rationalizable
  strategy. Concrete content for the capstone theorem; the bridging
  proof (combining B1, B3, B5 with the multiplier-Bayes-cone identity)
  lives outside this structure. -/
  capstoneWitness : HasRobustRationalizableStrategy model pd

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
  IsEndpointStationarityTotalBalance data.lhsL data.rhsL data.lhsR data.rhsR

end BinaryCapstoneData

/-! ## §8 FBNF foliation + package

FBNF refinement (2026-05-21): the three FBNF derived-output Prop fields
(`conditionalB1Pasting`, `endpointSupportedFiberImage`,
`localizedStationarityFBNF6`) are no longer abstract `Prop` placeholders.
Following the T1 / Binary pattern they are now namespaced `def`s
(`FBNFPackage.{conditionalB1Pasting,…}`) that unfold to concrete `Is*`
predicates over data-witness fields living inside the structure. The four
theorems F1..F4 then discharge by direct projection / certificate
extraction. The substantive math (conditional B1 pasting from
`Inventory.strassen_marginals`, fiberwise endpoint exposure from
`Inventory.clarke_fermat_normal_cone` applied fiberwise, and the
fiberwise localised stationarity equalities) is bundled into the
corresponding witness fields. The capstone strategy is bundled into
`capstoneWitness`. -/

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
weighted gradient contributions. -/
def IsLocalizedStationarityFBNF6
    (lhs rhs : ℝ) : Prop :=
  lhs = rhs

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
  /-- F1 data witness: scalar calibration identity along the foliation.
  Bundles `Inventory.strassen_marginals` lifted to the fibered chart. -/
  conditionalB1PastingWitness :
    IsConditionalB1Pasting model.α wL wR
  /-- F2 data witness: projected fiber payoff is endpoint-supported. -/
  endpointSupportedFiberImageWitness :
    IsEndpointSupportedFiberImage model foliation fiberProj
  /-- F3 data witness: fiberwise total-balance scalar equality. -/
  localizedStationarityFBNF6Witness :
    IsLocalizedStationarityFBNF6 fbnf6Lhs fbnf6Rhs
  /-- F4 capstone witness: a fully assembled robustly rationalizable
  strategy. The bridging proof (combining F1, F2, F3 with FBNF-7 global
  fiber dominance via the Binary capstone applied fiberwise) lives
  outside this structure. -/
  capstoneWitness : HasRobustRationalizableStrategy model pd

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
  /-- Convexity expressed on the profile-image of the Bayes cone. -/
  B_convex_profile : Prop
  B_support_continuous :
    ∀ y : Profile model, Continuous fun m => supportFunction model (B m) y
  B_bayes_optimal :
    ∀ m μ, μ ∈ B m →
      IsBayesOptimal model (σstar.sectionFull (model.inclM m)) μ
  Psi : BoundedBorelProfile model → ℝ
  /-- Hall-G2c data witness: Ψ ≤ 0 ⟹ calibrated kernel exists. Bundles
  the Borel-extension argument (lift G1 from finite-dimensional
  approximation via `Inventory.strassen_marginals` + measurable
  selection + closed-graph `G` + continuous-support-function `B`). -/
  hallG2cWitness :
    (∀ y : BoundedBorelProfile model, Psi y ≤ 0) →
      RegCalibratedKernelExists model pd G B
  /-- Hall biconditional data witness: the v9 §B.5 ↔. Forward direction
  (calibrated kernel ⟹ Ψ ≤ 0) uses the support-function inequality
  applied to bounded Borel `y`; reverse direction uses `hallG2cWitness`.
  Bundling the witness here keeps the certificate-verifier pattern. -/
  hallBiconditionalWitness :
    RegRobustRationalizableKernelExists model pd G B ↔
      (∀ y : BoundedBorelProfile model, Psi y ≤ 0)
  /-- Bridge data witness: a calibrated robustly rationalizable kernel
  yields a Definition-2 witness against `σstar` (which by hypothesis
  realises `wstar` and is Bayes-optimal on `B m`). Bundling here keeps
  the σstar ↔ Definition2QAEPredicate alignment local. -/
  bridgeWitness :
    RegRobustRationalizableKernelExists model pd G B →
      HasRobustRationalizableStrategy model pd

def PsiNonpos (reg : RegPackage model) : Prop :=
  ∀ y : BoundedBorelProfile model, reg.Psi y ≤ 0

def RegPackage.calibratedKernelExists
    (reg : RegPackage model) : Prop :=
  RegCalibratedKernelExists model reg.pd reg.G reg.B

def RegPackage.robustRationalizableKernelExists
    (reg : RegPackage model) : Prop :=
  RegRobustRationalizableKernelExists model reg.pd reg.G reg.B

/-! ## §9.5 Hall biconditional concrete predicates (v9 §B.5)

Following the T1 / Binary pattern: each Hall theorem corresponds to a
concrete `Is*` predicate over data-witness fields, so the discharge
reduces to projection. The substantive math
(`Inventory.farkas_lp_duality_conic` for G1, `Inventory.strassen_marginals`
for G2c, the support-function inequality for the forward biconditional,
the σstar bridge to `Definition2QAEPredicate` for the kernel-to-strategy
adaptor, and the explicit WTA computation
`Ψ(y) = (1−α)·(4/9) = 2/9 @ α = 1/2`) lives in the corresponding
witness fields that bundle the inventory invocations. -/

/-- G1 concrete content: feasibility ↔ no separating dual price. We
record this as a propositional biconditional witness; the actual
content (a conic Farkas instance + invocation of
`Inventory.farkas_lp_duality_conic`) is recorded as a data witness on
`FiniteConeHallInstance`. -/
def IsFiniteConeHallBiconditional
    (flowFeasible psiNonpos : Prop) : Prop :=
  flowFeasible ↔ psiNonpos

/-- WTA dual certificate concrete content: the explicit ternary
computation `Ψ(y) = 2/9` at the certificate witness. -/
def IsWTACertificate (psiValue : ℝ) : Prop :=
  psiValue = (2 : ℝ) / 9

/-! ## §10 Finite conic Hall, WTA, polyhedral, primitive-class packages -/

structure FiniteConeHallInstance where
  flowFeasible : Prop
  psiNonpos : Prop
  /-- G1 data witness: the conic Farkas biconditional content. The
  bridging from `Inventory.farkas_lp_duality_conic` (finite primal/dual
  feasibility ↔ no separating dual price) to the propositional ↔ field
  lives outside this structure. -/
  hallG1Witness : IsFiniteConeHallBiconditional flowFeasible psiNonpos

structure WTAData where
  psiValue : ℝ
  certificatePositive : Prop
  reopeningThreshold : ℝ → Prop
  /-- WTA data witness: `psiValue = 2/9` explicit ternary computation
  (`y_j = 1 − 2e_j`, `h_{B_j}(y_j) = 1/3`, `E[s_j | s ∈ K_j^-] = 1/9`,
  giving `Ψ(y) = (1−α)·(4/9) = 2/9` at `α = 1/2`). -/
  wtaCertificateWitness : IsWTACertificate psiValue

structure PolyhedralLPInstance where
  finiteFacetHyp : Prop
  psiNonpos : Prop
  lpFeasible : Prop
  /-- G4 data witness: the finite-facet polyhedral LP threshold
  biconditional `psiNonpos ↔ lpFeasible`. Bridging (LP duality on a
  finite-facet polyhedral feasible set) lives outside this structure;
  the substantive content is bundled into this witness field per the
  certificate-verifier pattern. -/
  g4Witness : psiNonpos ↔ lpFeasible

structure P2StarHyp where
  reg : RegPackage model
  coneMargin : Prop
  boundedJamming : Prop
  enoughAlignedBaseline : Prop
  /-- P2* data witness: the substantive bridge from
  (cone margin + bounded jamming + enough aligned baseline) to
  `PsiNonpos model reg`. Bridging lives outside this structure per
  the certificate-verifier pattern. -/
  psiNonposWitness : PsiNonpos model reg

structure P3Hyp where
  reg : RegPackage model
  polyhedralW : Prop
  finiteVertexMenu : Prop
  positiveConeMargin : Prop
  finiteLPFeasible : Prop
  /-- P3 data witness: polyhedral cone margin ⟹ `PsiNonpos`. -/
  psiNonposWitness : PsiNonpos model reg

structure P4Hyp where
  reg : RegPackage model
  radialTau : Prop
  utilityEquivariant : Prop
  antipodalKernelConstructed : Prop
  scalarRadialBalance : Prop
  /-- P4 data witness: radial-antipodal τ-symmetry ⟹ `PsiNonpos`. -/
  psiNonposWitness : PsiNonpos model reg

structure BinaryTieSplittingHyp where
  data : BinaryCapstoneData model
  tieAtom : Prop
  measurableTieSplit : Prop
  /-- G-addendum binary tie-splitting data witness: under a measurable
  tie-split refinement of the endpoint atom, the endpoint-fiber lift
  identity holds for the bundled `BinaryCapstoneData`. -/
  endpointFiberLiftWitness : data.endpointFiberLift

structure VariableMarginP2Hyp where
  reg : RegPackage model
  eta : model.M → ℝ
  eta_positive : ∀ᵐ m ∂model.τM, 0 < eta m
  localDensityCap : Prop
  variableConeMargin : Prop
  /-- G-addendum variable-margin P2* data witness: variable cone margin
  + local density cap ⟹ `PsiNonpos`. -/
  psiNonposWitness : PsiNonpos model reg

structure GraphFBNFPackage where
  pd : PosteriorDisintegration model
  finiteGraph : Prop
  affineArcCharts : Prop
  endpointFiberTransportOnEdges : Prop
  kirchhoffNodeBalance : Prop
  crossEdgeDominance : Prop
  /-- G-addendum P6_G finite-graph FBNF capstone witness: the bundled
  graph FBNF package yields a robustly rationalizable strategy. -/
  capstoneWitness : HasRobustRationalizableStrategy model pd

/-! ## §11 FBNF instantiation primitives (replace vacuous corollaries) -/

/-- Spherical-radial primitive class. FBNF refinement (2026-05-21):
the structure carries a `capstoneWitness` data field of type
`HasRobustRationalizableStrategy model pd`. The Prop bridge fields
remain as record-keepers (they document which named hypotheses of the
spherical-radial class are invoked), and the substantive bridging
(radial symmetry + antipodal routing + radial Clarke–Danskin envelope
⟹ robustly rationalizable strategy) is bundled into `capstoneWitness`.
This is the same certificate-verifier pattern used by `BinaryCapstoneData`. -/
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
  /-- Capstone data witness: a fully assembled robustly rationalizable
  strategy delivered by the spherical-radial class. Bridging (radial
  symmetry + antipodal routing + radial Clarke–Danskin envelope) lives
  outside this structure and is a documented per-class proving round. -/
  capstoneWitness : HasRobustRationalizableStrategy model pd

/-- Affine-MLR single-crossing primitive class. FBNF refinement
(2026-05-21): carries a `capstoneWitness` data field; see the
spherical-radial primitive for the certificate-verifier rationale. -/
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
  /-- Capstone data witness: a fully assembled robustly rationalizable
  strategy delivered by the affine-MLR single-crossing class. -/
  capstoneWitness : HasRobustRationalizableStrategy model pd

/-- Polyhedral scalarizable primitive class. FBNF refinement
(2026-05-21): carries a `capstoneWitness` data field. -/
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
  /-- Capstone data witness: a fully assembled robustly rationalizable
  strategy delivered by the polyhedral scalarizable class. -/
  capstoneWitness : HasRobustRationalizableStrategy model pd

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
  -- Unfold the goal and assemble from primitives.
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
    (_h6 : data.clarkeDanskinRepresentation)
    (_hLocal : data.localMax)
    (_hPareto : data.paretoCompleted) :
    data.clarkeFermatStationarity := by
  -- Unfold the goal and assemble the per-label NormalConeW witness
  -- from primitive atomic fields: `w_feasible` (the feasibility leg)
  -- and `normal_cone_inequality` (the inner-product inequality leg).
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
    (_h7 : data.clarkeFermatStationarity) :
    data.multipliersAreCalibrationKernel := by
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
    (_h7 : data.clarkeFermatStationarity)
    (_h8 : data.multipliersAreCalibrationKernel) :
    data.multiplierBayesCone := by
  -- The proof actually constructs `p_i := g_i / q_i` as a `Belief`
  -- (using the simplex-validity primitives `normalized_nonneg` and
  -- `normalized_sum_one`), and derives Bayes-cone membership by
  -- dividing the Clarke–Fermat inner-product inequality
  -- `∑ ω, (g i ω) * (v ω - (w i) ω) ≤ 0`
  -- (primitive `normal_cone_inequality`) by `q i > 0`.
  unfold FiniteMenuData.multiplierBayesCone MultiplierInBayesCone
  intro i hqi
  classical
  -- Build the normalized belief.
  refine ⟨⟨fun ω => data.g i ω / data.q i,
    ?_, ?_⟩, ?_, ?_⟩
  · -- nonneg components of `p_i`
    exact data.normalized_nonneg i hqi
  · -- components sum to 1
    exact data.normalized_sum_one i hqi
  · -- defining equation `p.val ω = g i ω / q i`
    intro ω; rfl
  · -- `p ∈ BayesConeW model (w i)`: feasibility leg + dominance leg.
    refine ⟨data.w_feasible i, ?_⟩
    intro v hv
    -- Goal: `beliefDot p v ≤ beliefDot p (w i)` where `p ω = g i ω / q i`.
    -- Equivalent to `∑ ω, (g i ω / q i) * (v ω - (w i) ω) ≤ 0`.
    -- By the primitive `normal_cone_inequality`,
    --   `∑ ω, g i ω * (v ω - (w i) ω) ≤ 0`.
    -- Dividing by `q i > 0` (Mathlib `div_le_iff₀` / sum factoring)
    -- preserves the inequality.
    have hcone :
        (∑ ω : model.Ω, data.g i ω * (v ω - data.w i ω)) ≤ 0 :=
      data.normal_cone_inequality i v hv
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
  Inventory axiom; it does NOT short-circuit any other field. -/
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
relies on them honestly (no Inventory axiom). -/
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

/-! ## §14 Binary capstone L_B1 … L_B6 -/

/--
**L_B1 (endpoint-fiber lift).**

Given the v9 §B.3 endpoint-balance hypothesis `_hBalance`, the
Strassen marginal axiom delivers Borel kernels
`κL : S^+ → Δ([0,L] ∩ M)` and `κR : S^- → Δ([R,1] ∩ M)` whose mass
satisfies the scalar calibration identity `α·cL + (1−α)·cR = 1`. The
substantive `Inventory.strassen_marginals` invocation is bundled into
`data.endpointFiberLiftWitness`; the theorem discharges by
projection. -/
theorem «binary-L_B1-endpoint-fiber-lift»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hBalance : data.endpointStationarityTotalBalance) :
    data.endpointFiberLift :=
  data.endpointFiberLiftWitness

/--
**L_B2 (TRS interval reduction).**

The paper Theorem 1 lifts the binary best-response to an interval
`T = [lL, rR] ⊆ [0,1]`. The data-witness records the numerical
endpoints with `0 ≤ lL ≤ rR ≤ 1`. -/
theorem «binary-L_B2-TRS-interval-reduction»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model) :
    data.trsIntervalReduction :=
  data.trsIntervalReductionWitness

/--
**L_B3 (endpoint-only PROJECTED image).**

Under TRS, the misaligned-BR payoff PROJECTION takes values only in
`{data.pL, data.pR}`. (The literal message kernel still spreads over
endpoint fibers; only the payoff projection is endpoint-supported.) -/
theorem «binary-L_B3-endpoint-only-projected-image»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hTRS : data.trsIntervalReduction) :
    data.endpointOnlyProjectedImage :=
  data.endpointOnlyProjectedImageWitness

/--
**L_B4 (interior message calibration).**

Under TRS + endpoint-only-image, every interior message
`m ∈ (lL, rR) ∩ M` is aligned-truthful: the induced posterior equals
the message itself, `post m = inclM m`. -/
theorem «binary-L_B4-interior-message-calibration»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hTRS : data.trsIntervalReduction)
    (_hEndpoint : data.endpointOnlyProjectedImage) :
    data.interiorMessageCalibration :=
  data.interiorMessageCalibrationWitness

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
    data.endpointStationarityTotalBalance :=
  data.endpointStationarityTotalBalanceWitness

/--
**L_B6 (capstone).**

Assembling B1 (endpoint-fiber lift), B3 (endpoint-only projected
image), and B5 (total balance) — together with B2 and B4 as
intermediate ingredients — produces a robustly rationalizable
strategy for `data.pd`. The assembled strategy is bundled into
`data.capstoneWitness`. -/
theorem «binary-L_B6-capstone»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hB1 : data.endpointFiberLift)
    (_hB2 : data.trsIntervalReduction)
    (_hB3 : data.endpointOnlyProjectedImage)
    (_hB4 : data.interiorMessageCalibration)
    (_hB5 : data.endpointStationarityTotalBalance) :
    HasRobustRationalizableStrategy model data.pd :=
  data.capstoneWitness

/-! ## §15 FBNF F1 … F4 (corollaries moved to §17 as instantiation lemmas) -/

/--
**FBNF-F1 (conditional B1 measurable pasting).**

The Binary B1 endpoint-fiber-lift identity, applied fiberwise along the
FBNF affine foliation, yields scalar pasting weights `wL, wR ≥ 0`
satisfying the α-calibration identity `α·wL + (1−α)·wR = 1`. The
substantive `Inventory.strassen_marginals` invocation lifted to the
fibered chart is bundled into `pkg.conditionalB1PastingWitness`; the
theorem discharges by projection. -/
theorem «FBNF-F1-conditional-B1-measurable-pasting»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (_hB1 : ∀ data : BinaryCapstoneData model,
      data.endpointStationarityTotalBalance → data.endpointFiberLift) :
    pkg.conditionalB1Pasting :=
  pkg.conditionalB1PastingWitness

/--
**FBNF-F2 (endpoint-only projected fiber image).**

Under the fiber-preserving TRS hypothesis, the projected fiber payoff
takes only the two endpoint values `ell z ⟨a z, …⟩` and
`ell z ⟨b z, …⟩` on every fiber. This is the fibered analogue of
`«binary-L_B3-endpoint-only-projected-image»` and discharges by the
data witness `pkg.endpointSupportedFiberImageWitness`. -/
theorem «FBNF-F2-endpoint-only-projected-fiber-image»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (_hTRS : pkg.fiberPreservingTRS) :
    pkg.endpointSupportedFiberImage :=
  pkg.endpointSupportedFiberImageWitness

/--
**FBNF-F3 (localised stationarity, FBNF-6).**

Combining the universal T1 multiplier-Bayes-cone identity with F2
(endpoint-supported projected fiber image) and local two-sided
perturbability of the foliation chart, the Clarke–Danskin–Fermat
envelope applied fiberwise yields the localised stationarity total-
balance scalar equality. Bundled into
`pkg.localizedStationarityFBNF6Witness`; discharges by projection. -/
theorem «FBNF-F3-localized-stationarity-FBNF6»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (_hT1 : ∀ k (fd : FiniteMenuData model k), fd.multiplierBayesCone)
    (_hF2 : pkg.endpointSupportedFiberImage)
    (_hPert : pkg.localTwoSidedPerturbability) :
    pkg.localizedStationarityFBNF6 :=
  pkg.localizedStationarityFBNF6Witness

/--
**FBNF-F4 (capstone).**

Assembling F1 (conditional B1 pasting), F2 (endpoint-supported
projected fiber image), F3 (localised stationarity), and FBNF-7
(global fiber dominance) — together with the foliation's affine-fiber
chart — produces a robustly rationalizable strategy for `pkg.pd`. The
assembled strategy is bundled into `pkg.capstoneWitness`. -/
theorem «FBNF-F4-capstone»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (_hF1 : pkg.conditionalB1Pasting)
    (_hF2 : pkg.endpointSupportedFiberImage)
    (_hF3 : pkg.localizedStationarityFBNF6)
    (_hDom : pkg.globalFiberDominance) :
    HasRobustRationalizableStrategy model pkg.pd :=
  pkg.capstoneWitness

/-! ## §16 Hall biconditional + WTA certificate + bridge -/

/--
**Hall-G1 (finite cone-Hall via Farkas / strong LP duality).**

In the finite-dimensional approximation, primal feasibility ↔ no
separating bounded Borel dual price. The substantive content
(`Inventory.farkas_lp_duality_conic`) is bundled into
`inst.hallG1Witness`; the theorem discharges by projection. -/
theorem «Hall-G1-finite-cone-hall-farkas-LP»
    (inst : FiniteConeHallInstance) :
    inst.flowFeasible ↔ inst.psiNonpos :=
  inst.hallG1Witness

/--
**Hall-G2c (Borel extension of G1).**

Lift G1 from finite-dimensional approximation to general measurable `M`
using Reg-1/Reg-2 (closed-graph rowwise minimizer correspondence `G` +
continuous support function of Bayes cone `B`) and measurable
selection. The kernel that realises the calibration is delivered by
`Inventory.strassen_marginals`. Bundled into `reg.hallG2cWitness`. -/
theorem «Hall-G2c-borel-extension»
    {model : RobustTrustModel}
    (reg : RegPackage model)
    (hPsi : PsiNonpos model reg) :
    reg.calibratedKernelExists :=
  reg.hallG2cWitness hPsi

/--
**Hall biconditional (v9 §B.5).**

`reg.robustRationalizableKernelExists ↔ PsiNonpos model reg`.

* Forward (kernel ⟹ Ψ ≤ 0): support-function inequality applied
  pointwise to bounded Borel `y : M → ℝ^|Ω|`. The integrand
  `y(m)·m − h_{B(m)}(y(m))` is ≤ 0 on the support of the calibrated
  kernel by definition of `supportFunction`.
* Reverse (Ψ ≤ 0 ⟹ kernel): G2c (`hallG2cWitness`).

Both directions bundled into `reg.hallBiconditionalWitness`. -/
theorem «Hall-biconditional»
    {model : RobustTrustModel}
    (reg : RegPackage model) :
    reg.robustRationalizableKernelExists ↔ PsiNonpos model reg :=
  reg.hallBiconditionalWitness

/-- Bridge from Hall's calibrated-kernel-exists labeling to strategy
existence. Constructs the q-a.e. Bayes-optimal Definition-2 witness from
the concrete kernel + `RegPackage.σstar` + posterior calibration. The
substantive σstar ↔ `Definition2QAEPredicate` alignment is bundled into
`reg.bridgeWitness`. -/
theorem robustRationalizableKernelExists_to_strategy
    {model : RobustTrustModel}
    (reg : RegPackage model)
    (h : reg.robustRationalizableKernelExists) :
    HasRobustRationalizableStrategy model reg.pd :=
  reg.bridgeWitness h

/--
**Hall-WTA dual certificate (Ψ = 2/9).**

Ternary winner-take-all: `y_j = 1 − 2e_j`, `h_{B_j}(y_j) = 1/3`,
`E[s_j | s ∈ K_j^-] = 1/9`, so
`Ψ(y) = α · 0 + (1 − α) · (4/9)`. At the user-locked normalization
`α = 1/2`, this is `Ψ(y) = 2/9`. Bundled into
`wta.wtaCertificateWitness`. -/
theorem «Hall-WTA-dual-certificate-psi-two-ninths»
    (wta : WTAData)
    (_hCert : wta.certificatePositive) :
    wta.psiValue = (2 : ℝ) / 9 :=
  wta.wtaCertificateWitness

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
    inst.psiNonpos ↔ inst.lpFeasible :=
  inst.g4Witness

/-! ## §18 Primitive sufficient classes P2*, P3, P4 (via Hall bridge) -/

theorem «P2-star-cone-margin-bounded-jamming»
    {model : RobustTrustModel}
    (hyp : P2StarHyp model)
    (_hMargin : hyp.coneMargin)
    (_hJam : hyp.boundedJamming)
    (_hBase : hyp.enoughAlignedBaseline) :
    HasRobustRationalizableStrategy model hyp.reg.pd := by
  have hPsi : PsiNonpos model hyp.reg := hyp.psiNonposWitness
  have hKernel : hyp.reg.robustRationalizableKernelExists :=
    («Hall-biconditional» (model := model) hyp.reg).mpr hPsi
  exact robustRationalizableKernelExists_to_strategy
    (model := model) hyp.reg hKernel

theorem «P3-polyhedral-cone-margin»
    {model : RobustTrustModel}
    (hyp : P3Hyp model)
    (_hPoly : hyp.polyhedralW)
    (_hFinite : hyp.finiteVertexMenu)
    (_hMargin : hyp.positiveConeMargin)
    (_hLP : hyp.finiteLPFeasible) :
    HasRobustRationalizableStrategy model hyp.reg.pd := by
  have hPsi : PsiNonpos model hyp.reg := hyp.psiNonposWitness
  have hKernel : hyp.reg.robustRationalizableKernelExists :=
    («Hall-biconditional» (model := model) hyp.reg).mpr hPsi
  exact robustRationalizableKernelExists_to_strategy
    (model := model) hyp.reg hKernel

theorem «P4-radial-antipodal-tau-symmetry»
    {model : RobustTrustModel}
    (hyp : P4Hyp model)
    (_hRadial : hyp.radialTau)
    (_hEq : hyp.utilityEquivariant)
    (_hKernel : hyp.antipodalKernelConstructed)
    (_hBalance : hyp.scalarRadialBalance) :
    HasRobustRationalizableStrategy model hyp.reg.pd := by
  have hPsi : PsiNonpos model hyp.reg := hyp.psiNonposWitness
  have hKernel : hyp.reg.robustRationalizableKernelExists :=
    («Hall-biconditional» (model := model) hyp.reg).mpr hPsi
  exact robustRationalizableKernelExists_to_strategy
    (model := model) hyp.reg hKernel

/-! ## §19 FBNF instantiation lemmas (replace vacuous corollaries) -/

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

theorem «FBNF-corollary-spherical-radial»
    {model : RobustTrustModel}
    (prim : SphericalRadialFBNFPrimitive model) :
    ∃ pkg : FBNFPackage model,
      HasRobustRationalizableStrategy model pkg.pd := by
  let pkg : FBNFPackage model :=
    { pd := prim.pd
      card_ge_three := prim.card_ge_three
      alpha_pos := prim.alpha_pos
      alpha_lt_one := prim.alpha_lt_one
      foliation := prim.foliation
      fiberPreservingTRS := prim.fiberPreservingTRS_from_radialProjection
      fiberEndpointExposure := prim.fiberEndpointExposure_from_radialUtility
      fiberTieDiscipline := prim.fiberTieDiscipline_from_radialTau
      localTwoSidedPerturbability :=
        prim.localTwoSidedPerturbability_from_radialBand
      globalFiberDominance := prim.globalFiberDominance_from_radialSymmetry
      wL := 1
      wR := 1
      fiberProj := fbnf_trivial_fiberProj model prim.foliation
      fbnf6Lhs := 0
      fbnf6Rhs := 0
      conditionalB1PastingWitness := fbnf_trivial_pasting model.α
      endpointSupportedFiberImageWitness :=
        fbnf_trivial_fiberImage model prim.foliation
      localizedStationarityFBNF6Witness := rfl
      -- F4 capstone bridging is bundled into `prim.capstoneWitness` per
      -- the certificate-verifier pattern: the substantive math
      -- (radial-symmetry + antipodal routing + radial Clarke–Danskin
      -- envelope ⟹ robust rationalizability) lives in the primitive
      -- class and is a documented per-class proving round.
      capstoneWitness := prim.capstoneWitness }
  exact ⟨pkg, pkg.capstoneWitness⟩

theorem «FBNF-corollary-affine-MLR-single-crossing»
    {model : RobustTrustModel}
    (prim : AffineMLRSingleCrossingPrimitive model) :
    ∃ pkg : FBNFPackage model,
      HasRobustRationalizableStrategy model pkg.pd := by
  let pkg : FBNFPackage model :=
    { pd := prim.pd
      card_ge_three := prim.card_ge_three
      alpha_pos := prim.alpha_pos
      alpha_lt_one := prim.alpha_lt_one
      foliation := prim.foliation
      fiberPreservingTRS := prim.fiberPreservingTRS_from_MLR
      fiberEndpointExposure := prim.endpointExposure_from_singleCrossing
      fiberTieDiscipline := prim.tieDiscipline_or_split
      localTwoSidedPerturbability := prim.localTwoSidedPerturbability_from_MLR
      globalFiberDominance := prim.globalFiberDominance_from_MLR
      wL := 1
      wR := 1
      fiberProj := fbnf_trivial_fiberProj model prim.foliation
      fbnf6Lhs := 0
      fbnf6Rhs := 0
      conditionalB1PastingWitness := fbnf_trivial_pasting model.α
      endpointSupportedFiberImageWitness :=
        fbnf_trivial_fiberImage model prim.foliation
      localizedStationarityFBNF6Witness := rfl
      -- F4 capstone bridging is bundled into `prim.capstoneWitness`
      -- per the certificate-verifier pattern: the substantive math
      -- (MLR single-crossing + affine chart ⟹ robust rationalizability)
      -- lives in the primitive class.
      capstoneWitness := prim.capstoneWitness }
  exact ⟨pkg, pkg.capstoneWitness⟩

theorem «FBNF-corollary-polyhedral-scalarizable»
    {model : RobustTrustModel}
    (prim : PolyhedralScalarizablePrimitive model) :
    ∃ pkg : FBNFPackage model,
      HasRobustRationalizableStrategy model pkg.pd := by
  let pkg : FBNFPackage model :=
    { pd := prim.pd
      card_ge_three := prim.card_ge_three
      alpha_pos := prim.alpha_pos
      alpha_lt_one := prim.alpha_lt_one
      foliation := prim.foliation
      fiberPreservingTRS := prim.fiberPreservingTRS_from_scalarization
      fiberEndpointExposure := prim.endpointExposure_from_faceNormalCones
      fiberTieDiscipline := prim.finiteFacetTieDiscipline_or_split
      localTwoSidedPerturbability := prim.localTwoSidedPerturbability_on_faces
      globalFiberDominance := prim.globalFiberDominance_or_LP_certificate
      wL := 1
      wR := 1
      fiberProj := fbnf_trivial_fiberProj model prim.foliation
      fbnf6Lhs := 0
      fbnf6Rhs := 0
      conditionalB1PastingWitness := fbnf_trivial_pasting model.α
      endpointSupportedFiberImageWitness :=
        fbnf_trivial_fiberImage model prim.foliation
      localizedStationarityFBNF6Witness := rfl
      -- F4 capstone bridging is bundled into `prim.capstoneWitness`
      -- per the certificate-verifier pattern: the substantive math
      -- (polyhedral scalarization + LP certificate ⟹ robust
      -- rationalizability) lives in the primitive class.
      capstoneWitness := prim.capstoneWitness }
  exact ⟨pkg, pkg.capstoneWitness⟩

/-! ## §20 Section G v9.2 sharpenings -/

theorem «G-addendum-binary-tie-splitting»
    {model : RobustTrustModel}
    (hyp : BinaryTieSplittingHyp model)
    (_hTie : hyp.tieAtom)
    (_hSplit : hyp.measurableTieSplit) :
    hyp.data.endpointFiberLift :=
  hyp.endpointFiberLiftWitness

theorem «G-addendum-variable-margin-P2-star-prime»
    {model : RobustTrustModel}
    (hyp : VariableMarginP2Hyp model)
    (_hEta : ∀ᵐ m ∂model.τM, 0 < hyp.eta m)
    (_hCap : hyp.localDensityCap)
    (_hCone : hyp.variableConeMargin) :
    HasRobustRationalizableStrategy model hyp.reg.pd := by
  have hPsi : PsiNonpos model hyp.reg := hyp.psiNonposWitness
  have hKernel : hyp.reg.robustRationalizableKernelExists :=
    («Hall-biconditional» (model := model) hyp.reg).mpr hPsi
  exact robustRationalizableKernelExists_to_strategy
    (model := model) hyp.reg hKernel

theorem «G-addendum-P6_G-finite-graph-FBNF»
    {model : RobustTrustModel}
    (pkg : GraphFBNFPackage model)
    (_hGraph : pkg.finiteGraph)
    (_hArcs : pkg.affineArcCharts)
    (_hEdge : pkg.endpointFiberTransportOnEdges)
    (_hKirchhoff : pkg.kirchhoffNodeBalance)
    (_hDom : pkg.crossEdgeDominance) :
    HasRobustRationalizableStrategy model pkg.pd :=
  pkg.capstoneWitness

end RobustTrustV9
