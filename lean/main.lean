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

namespace Inventory

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
closed convex hull of active gradients. Source: Clarke 1990 §2.7. -/
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
negative of the Clarke normal cone. Source: Clarke 1990, Fermat rule. -/
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
space is a continuous image of the Cantor space. (Placeholder Prop until
`CantorSpace` is fixed in Mathlib for v9 use sites.) -/
axiom hausdorff_alexandroff_continuous_surjection
    (K : Type*) [TopologicalSpace K] [CompactSpace K] [T2Space K]
    [SecondCountableTopology K] :
    Prop

end Inventory

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
  sorry

theorem WP_isCompact
    {model : RobustTrustModel}
    (hWcompact : IsCompact (PayoffProfileSet model))
    (hWclosed : IsClosed (PayoffProfileSet model)) :
    IsCompact (WP model) := by
  have hWPclosed : IsClosed (WP model) :=
    WeakParetoProfile_isClosed (model := model) hWclosed
  have hSubset : WP model ⊆ PayoffProfileSet model := fun _ hw => hw.1
  exact hWcompact.of_isClosed_subset hWPclosed hSubset

/-! ## §5 Finite-menu data for T1 -/

structure FiniteMenuData (k : Nat) where
  w : Fin k → Profile model
  inWP : ∀ i, w i ∈ WP model
  localMax : Prop
  paretoCompleted : Prop
  lamPlus : model.M → Fin k → ℝ
  lamMinus : model.M → Fin k → ℝ
  g : Fin k → Profile model
  q : Fin k → ℝ
  clarkeDanskinRepresentation : Prop
  clarkeFermatStationarity : Prop
  multipliersAreCalibrationKernel : Prop
  multiplierBayesCone : Prop

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

/-! ## §7 Binary capstone data (no conclusion-as-field per reviewer N) -/

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
  /-- B1: endpoint-fiber Borel transport exists. -/
  endpointFiberLift : Prop
  /-- B2: paper TRS reduces to an interval `[L,R]`. -/
  trsIntervalReduction : Prop
  /-- B3: the adversary's PROJECTED payoff image is endpoint-only.
  The literal message kernel spreads over endpoint fibers; only the
  payoff projection lies in `{w_L, w_R}`. -/
  endpointOnlyProjectedImage : Prop
  /-- B4: interior messages are truthfully calibrated q-a.e. -/
  interiorMessageCalibration : Prop
  /-- B5: total endpoint-fiber balance equations from Clarke–Danskin Fermat. -/
  endpointStationarityTotalBalance : Prop

/-! ## §8 FBNF foliation + package (no conclusion-as-field) -/

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

structure FBNFPackage where
  pd : PosteriorDisintegration model
  card_ge_three : 3 ≤ Fintype.card model.Ω
  alpha_pos : 0 < model.α
  alpha_lt_one : model.α < 1
  foliation : Foliation model
  /-- FBNF-2. -/
  fiberPreservingTRS : Prop
  /-- FBNF-3, corrected: endpoint-supported projected image. -/
  endpointSupportedFiberImage : Prop
  /-- FBNF-4. -/
  fiberEndpointExposure : Prop
  /-- FBNF-5. -/
  fiberTieDiscipline : Prop
  /-- Required for FBNF-6 equality vs one-sided KKT. -/
  localTwoSidedPerturbability : Prop
  /-- FBNF-7. -/
  globalFiberDominance : Prop
  /-- F1 output. -/
  conditionalB1Pasting : Prop
  /-- F3 output. -/
  localizedStationarityFBNF6 : Prop

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

def PsiNonpos (reg : RegPackage model) : Prop :=
  ∀ y : BoundedBorelProfile model, reg.Psi y ≤ 0

def RegPackage.calibratedKernelExists
    (reg : RegPackage model) : Prop :=
  RegCalibratedKernelExists model reg.pd reg.G reg.B

def RegPackage.robustRationalizableKernelExists
    (reg : RegPackage model) : Prop :=
  RegRobustRationalizableKernelExists model reg.pd reg.G reg.B

/-! ## §10 Finite conic Hall, WTA, polyhedral, primitive-class packages -/

structure FiniteConeHallInstance where
  flowFeasible : Prop
  psiNonpos : Prop

structure WTAData where
  psiValue : ℝ
  certificatePositive : Prop
  reopeningThreshold : ℝ → Prop

structure PolyhedralLPInstance where
  finiteFacetHyp : Prop
  psiNonpos : Prop
  lpFeasible : Prop

structure P2StarHyp where
  reg : RegPackage model
  coneMargin : Prop
  boundedJamming : Prop
  enoughAlignedBaseline : Prop

structure P3Hyp where
  reg : RegPackage model
  polyhedralW : Prop
  finiteVertexMenu : Prop
  positiveConeMargin : Prop
  finiteLPFeasible : Prop

structure P4Hyp where
  reg : RegPackage model
  radialTau : Prop
  utilityEquivariant : Prop
  antipodalKernelConstructed : Prop
  scalarRadialBalance : Prop

structure BinaryTieSplittingHyp where
  data : BinaryCapstoneData model
  tieAtom : Prop
  measurableTieSplit : Prop

structure VariableMarginP2Hyp where
  reg : RegPackage model
  eta : model.M → ℝ
  eta_positive : ∀ᵐ m ∂model.τM, 0 < eta m
  localDensityCap : Prop
  variableConeMargin : Prop

structure GraphFBNFPackage where
  pd : PosteriorDisintegration model
  finiteGraph : Prop
  affineArcCharts : Prop
  endpointFiberTransportOnEdges : Prop
  kirchhoffNodeBalance : Prop
  crossEdgeDominance : Prop

/-! ## §11 FBNF instantiation primitives (replace vacuous corollaries) -/

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

end -- noncomputable section

/-! ## §12 Theorem T1 + sub-lemmas L6/L7/L8 -/

theorem «T1-L6-integral-clarke-danskin-representation»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (_hLocal : data.localMax)
    (_hPareto : data.paretoCompleted) :
    data.clarkeDanskinRepresentation := by
  sorry

theorem «T1-L7-clarke-fermat-stationarity»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (_h6 : data.clarkeDanskinRepresentation)
    (_hLocal : data.localMax)
    (_hPareto : data.paretoCompleted) :
    data.clarkeFermatStationarity := by
  sorry

theorem «T1-L8-multipliers-are-calibration-kernel»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (_h6 : data.clarkeDanskinRepresentation)
    (_h7 : data.clarkeFermatStationarity) :
    data.multipliersAreCalibrationKernel := by
  sorry

theorem «T1-clarke-danskin-multiplier-bayes-cone»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (_h6 : data.clarkeDanskinRepresentation)
    (_h7 : data.clarkeFermatStationarity)
    (_h8 : data.multipliersAreCalibrationKernel) :
    data.multiplierBayesCone := by
  sorry

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

/-- **Missing α=0 existence lemma.** Given `α = 0`, construct the
`AlphaZeroSingletonData` certificate. The construction requires:
1. Existence of a private strategy Bayes-optimal at `priorBelief model` for
   every message (use the standard Bayes selector / KRN with a constant
   posterior, or the existence-of-Bayes-best-action lemma).
2. A Dirac/constant adversarial kernel concentrated at `constantMessage`.
3. The q-a.e. posterior collapse `pd.Pβ constantAdversary m = priorBelief model`
   under the mixture message law (when `α = 0`, that law reduces to the
   Dirac second-marginal, and the disintegration identities then collapse
   the posterior).
4. The "message-ignoring strategy makes every adversary optimal" identity,
   which gives `IsAdversarialFull` for the constant adversary.

Each sub-step is its own per-lemma round. -/
theorem AlphaZeroSingletonData_exists
    {model : RobustTrustModel}
    (_hα : model.α = 0) :
    Nonempty (AlphaZeroSingletonData model) := by
  sorry

/-- v9 α=0 endpoint: unconditional infinite-extension of Robust Trust
Theorem 2 in the pure-adversarial regime. -/
theorem «T2-alpha-zero-singleton-prior-strategy»
    {model : RobustTrustModel}
    (pd : PosteriorDisintegration model)
    (hα : model.α = 0) :
    HasRobustRationalizableStrategy model pd := by
  obtain ⟨data⟩ := AlphaZeroSingletonData_exists (model := model) hα
  exact AlphaZeroSingletonData.to_hasRobustRationalizableStrategy pd data

/-! ## §14 Binary capstone L_B1 … L_B6 -/

theorem «binary-L_B1-endpoint-fiber-lift»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hBalance : data.endpointStationarityTotalBalance) :
    data.endpointFiberLift := by
  sorry

theorem «binary-L_B2-TRS-interval-reduction»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model) :
    data.trsIntervalReduction := by
  sorry

theorem «binary-L_B3-endpoint-only-projected-image»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hTRS : data.trsIntervalReduction) :
    data.endpointOnlyProjectedImage := by
  sorry

theorem «binary-L_B4-interior-message-calibration»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hTRS : data.trsIntervalReduction)
    (_hEndpoint : data.endpointOnlyProjectedImage) :
    data.interiorMessageCalibration := by
  sorry

theorem «binary-L_B5-endpoint-stationarity-total-balance»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hT1 : ∀ k (fd : FiniteMenuData model k), fd.multiplierBayesCone)
    (_hTRS : data.trsIntervalReduction)
    (_hEndpoint : data.endpointOnlyProjectedImage)
    (_hIES : data.interiorEndpointStationarity) :
    data.endpointStationarityTotalBalance := by
  sorry

theorem «binary-L_B6-capstone»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hB1 : data.endpointFiberLift)
    (_hB2 : data.trsIntervalReduction)
    (_hB3 : data.endpointOnlyProjectedImage)
    (_hB4 : data.interiorMessageCalibration)
    (_hB5 : data.endpointStationarityTotalBalance) :
    HasRobustRationalizableStrategy model data.pd := by
  sorry

/-! ## §15 FBNF F1 … F4 (corollaries moved to §17 as instantiation lemmas) -/

theorem «FBNF-F1-conditional-B1-measurable-pasting»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (_hB1 : ∀ data : BinaryCapstoneData model,
      data.endpointStationarityTotalBalance → data.endpointFiberLift) :
    pkg.conditionalB1Pasting := by
  sorry

theorem «FBNF-F2-endpoint-only-projected-fiber-image»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (_hTRS : pkg.fiberPreservingTRS) :
    pkg.endpointSupportedFiberImage := by
  sorry

theorem «FBNF-F3-localized-stationarity-FBNF6»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (_hT1 : ∀ k (fd : FiniteMenuData model k), fd.multiplierBayesCone)
    (_hF2 : pkg.endpointSupportedFiberImage)
    (_hPert : pkg.localTwoSidedPerturbability) :
    pkg.localizedStationarityFBNF6 := by
  sorry

theorem «FBNF-F4-capstone»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (_hF1 : pkg.conditionalB1Pasting)
    (_hF2 : pkg.endpointSupportedFiberImage)
    (_hF3 : pkg.localizedStationarityFBNF6)
    (_hDom : pkg.globalFiberDominance) :
    HasRobustRationalizableStrategy model pkg.pd := by
  sorry

/-! ## §16 Hall biconditional + WTA certificate + bridge -/

theorem «Hall-G1-finite-cone-hall-farkas-LP»
    (inst : FiniteConeHallInstance) :
    inst.flowFeasible ↔ inst.psiNonpos := by
  sorry

theorem «Hall-G2c-borel-extension»
    {model : RobustTrustModel}
    (reg : RegPackage model)
    (_hPsi : PsiNonpos model reg) :
    reg.calibratedKernelExists := by
  sorry

theorem «Hall-biconditional»
    {model : RobustTrustModel}
    (reg : RegPackage model) :
    reg.robustRationalizableKernelExists ↔ PsiNonpos model reg := by
  sorry

/-- Bridge from Hall's calibrated-kernel-exists labeling to strategy
existence. Constructs the q-a.e. Bayes-optimal Definition-2 witness from
the concrete kernel + `RegPackage.σstar` + posterior calibration. -/
theorem robustRationalizableKernelExists_to_strategy
    {model : RobustTrustModel}
    (reg : RegPackage model)
    (h : reg.robustRationalizableKernelExists) :
    HasRobustRationalizableStrategy model reg.pd := by
  rcases h with ⟨κ, _hSupp, _hCal⟩
  refine ⟨κ, reg.σstar, ?_⟩
  -- hSupp gives adversarial support on rowwise minimizers (`reg.G`).
  -- hCal gives q-a.e. posterior-in-Bayes-cone calibration.
  -- `reg.G_rowwise_minimizer` + `reg.B_bayes_optimal` discharge Definition2QAEPredicate.
  sorry

theorem «Hall-WTA-dual-certificate-psi-two-ninths»
    (wta : WTAData)
    (_hCert : wta.certificatePositive) :
    wta.psiValue = (2 : ℝ) / 9 := by
  sorry

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
  sorry

/-! ## §18 Primitive sufficient classes P2*, P3, P4 (via Hall bridge) -/

theorem «P2-star-cone-margin-bounded-jamming»
    {model : RobustTrustModel}
    (hyp : P2StarHyp model)
    (_hMargin : hyp.coneMargin)
    (_hJam : hyp.boundedJamming)
    (_hBase : hyp.enoughAlignedBaseline) :
    HasRobustRationalizableStrategy model hyp.reg.pd := by
  have hPsi : PsiNonpos model hyp.reg := by sorry
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
  have hPsi : PsiNonpos model hyp.reg := by sorry
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
  have hPsi : PsiNonpos model hyp.reg := by sorry
  have hKernel : hyp.reg.robustRationalizableKernelExists :=
    («Hall-biconditional» (model := model) hyp.reg).mpr hPsi
  exact robustRationalizableKernelExists_to_strategy
    (model := model) hyp.reg hKernel

/-! ## §19 FBNF instantiation lemmas (replace vacuous corollaries) -/

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
      endpointSupportedFiberImage := prim.endpointSupport_from_antipodalRouting
      fiberEndpointExposure := prim.fiberEndpointExposure_from_radialUtility
      fiberTieDiscipline := prim.fiberTieDiscipline_from_radialTau
      localTwoSidedPerturbability :=
        prim.localTwoSidedPerturbability_from_radialBand
      globalFiberDominance := prim.globalFiberDominance_from_radialSymmetry
      conditionalB1Pasting := True  -- placeholder; B1 pasting derived from prim
      localizedStationarityFBNF6 := True }
  refine ⟨pkg, ?_⟩
  -- Per-primitive proofs of `endpointSupportedFiberImage` and
  -- `globalFiberDominance` come from the primitive bridge fields; downstream
  -- prover round fills these in.
  sorry

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
      endpointSupportedFiberImage := prim.endpointSupport_from_singleCrossing
      fiberEndpointExposure := prim.endpointExposure_from_singleCrossing
      fiberTieDiscipline := prim.tieDiscipline_or_split
      localTwoSidedPerturbability := prim.localTwoSidedPerturbability_from_MLR
      globalFiberDominance := prim.globalFiberDominance_from_MLR
      conditionalB1Pasting := True
      localizedStationarityFBNF6 := True }
  refine ⟨pkg, ?_⟩
  sorry

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
      endpointSupportedFiberImage := prim.endpointSupport_from_scalarizedFaces
      fiberEndpointExposure := prim.endpointExposure_from_faceNormalCones
      fiberTieDiscipline := prim.finiteFacetTieDiscipline_or_split
      localTwoSidedPerturbability := prim.localTwoSidedPerturbability_on_faces
      globalFiberDominance := prim.globalFiberDominance_or_LP_certificate
      conditionalB1Pasting := True
      localizedStationarityFBNF6 := True }
  refine ⟨pkg, ?_⟩
  sorry

/-! ## §20 Section G v9.2 sharpenings -/

theorem «G-addendum-binary-tie-splitting»
    {model : RobustTrustModel}
    (hyp : BinaryTieSplittingHyp model)
    (_hTie : hyp.tieAtom)
    (_hSplit : hyp.measurableTieSplit) :
    hyp.data.endpointFiberLift := by
  sorry

theorem «G-addendum-variable-margin-P2-star-prime»
    {model : RobustTrustModel}
    (hyp : VariableMarginP2Hyp model)
    (_hEta : ∀ᵐ m ∂model.τM, 0 < hyp.eta m)
    (_hCap : hyp.localDensityCap)
    (_hCone : hyp.variableConeMargin) :
    HasRobustRationalizableStrategy model hyp.reg.pd := by
  have hPsi : PsiNonpos model hyp.reg := by sorry
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
    HasRobustRationalizableStrategy model pkg.pd := by
  sorry

end RobustTrustV9
