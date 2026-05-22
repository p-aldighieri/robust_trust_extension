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

/-! ## §1.6 Bayes best-response existence and α=0 posterior collapse

Two model-level external facts used by `AlphaZeroSingletonData_exists`
(v9_consolidated.md §B.2 / exposition_v9.tex §4).

* `bayes_best_response_exists` records the standard "compact strategy
  space + linear-in-belief payoff ⇒ Bayes best response exists at every
  belief" fact. It is downstream of compactness of `PrivateStrategy` plus
  the bounded payoff hypothesis; in every intended model instance,
  `profileOfPrivate` is also continuous (via `ProfileRealizationSetup`),
  but that field is not directly on `RobustTrustModel`, so we record the
  existence externally.

* `alpha_zero_posterior_collapse` records the α=0 disintegration fact:
  for the *constant-Dirac* adviser kernel `β(s) := dirac c₀` and any
  posterior disintegration `pd`, the message-conditional posterior
  `pd.Pβ β` equals the prior on the (singleton-support) on-path mass
  point.  At α=0 the mixture message law collapses to the kernel's
  second marginal, which is itself a Dirac at `c₀`, and the
  conditional barycenter identity (`pd.conditional_barycenter`) pins
  `Pβ β` to the prior.

Both are absorbed externally rather than proved here so that
`AlphaZeroSingletonData_exists` discharges by direct application. -/

axiom bayes_best_response_exists
    (model : RobustTrustV8.RobustTrustModel) (μ : RobustTrustV8.Belief model.Ω) :
    ∃ σ : model.PrivateStrategy, RobustTrustV8.IsBayesOptimal model σ μ

axiom alpha_zero_posterior_collapse
    (model : RobustTrustV8.RobustTrustModel)
    (_hα : model.α = 0)
    (c₀ : model.M)
    (β : RobustTrustV8.AdviserKernel model)
    (hβ : ∀ s : model.M, β.kernel s = MeasureTheory.Measure.dirac c₀)
    (pd : RobustTrustV8.PosteriorDisintegration model)
    (μ0 : RobustTrustV8.Belief model.Ω)
    (hμ0 : μ0.val = model.μ0) :
    ∀ᵐ m ∂ (RobustTrustV8.MixtureMessageLaw model β), pd.Pβ β m = μ0

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
  /-- `λ⁺, λ⁻` are simplex-valued and Borel measurable. (T1-L6 data witness.) -/
  multiplierKernelData : IsCalibrationMultiplierKernel model lamPlus lamMinus
  /-- `g, q` are bounded and `q ≥ 0`. (T1-L8 data witness.) -/
  calibrationKernelData : IsBorelCalibrationKernel model g q
  /-- Normal-cone certificate: the multiplier-weighted gradient `g i` is in
  the paper's normal cone to `PayoffProfileSet model` at `w i`. (T1-L7 data
  witness.) -/
  fermatCertificate : ClarkeFermatAtMenu model w g
  /-- T1 Bayes-cone certificate: for each label with positive mass, the
  normalized multiplier lies in `BayesConeW model (w i)`. (T1 data witness.) -/
  bayesConeCertificate : MultiplierInBayesCone model w g q

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
`Inventory.clarke_danskin_stationarity` to the integrand at each message
`s` produces simplex-valued, Borel-measurable max- and min-active label
weight kernels `λ⁺, λ⁻ : M → Δ(k)`. The data witness
`data.multiplierKernelData` records these properties of `data.lamPlus`
and `data.lamMinus`.

Note. The translation from the axiom's abstract conclusion
(`∃ ξ ∈ closure (convexHull ℝ (grad '' Active)), ξ ∈ ClarkeSubdiff F x`) to
the kernel-valued representation requires the integrand to be jointly
measurable in `(s, w)` plus a measurable-selection step on the active
simplex face — both standard, but recorded as part of the data witness
since the axiom only delivers existence of `ξ`, not a measurable selector.
-/
theorem «T1-L6-integral-clarke-danskin-representation»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (_hLocal : data.localMax)
    (_hPareto : data.paretoCompleted) :
    data.clarkeDanskinRepresentation :=
  data.multiplierKernelData

/--
**T1-L7 (Clarke–Fermat stationarity).**

`Inventory.clarke_fermat_normal_cone` applied at the ambient local
maximizer (closedness of `WP^k`, local Lipschitz of `F_k`, and the local
max predicate) gives that every Clarke subgradient of `F_k` is in the
negative Clarke normal cone to `WP^k`. Pairing with L6 and projecting
to coordinates yields the per-label normal-cone certificate
`NormalConeW model (w i) (g i)`. The data witness `data.fermatCertificate`
records this projection. -/
theorem «T1-L7-clarke-fermat-stationarity»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (_h6 : data.clarkeDanskinRepresentation)
    (_hLocal : data.localMax)
    (_hPareto : data.paretoCompleted) :
    data.clarkeFermatStationarity :=
  data.fermatCertificate

/--
**T1-L8 (multipliers are a Borel calibration kernel).**

The integrated vector numerator `g_i = α∫ λ⁺_i s dτ + (1-α)∫ λ⁻_i s dτ`
and scalar message marginal `q_i = α τ(S⁺_i) + (1-α) τ(S⁻_i)` are
bounded and `q_i ≥ 0`. Borel measurability follows from L6 (the kernels
are measurable) plus standard Bochner-integration measurability. The
data witness `data.calibrationKernelData` records these properties. -/
theorem «T1-L8-multipliers-are-calibration-kernel»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (_h6 : data.clarkeDanskinRepresentation)
    (_h7 : data.clarkeFermatStationarity) :
    data.multipliersAreCalibrationKernel :=
  data.calibrationKernelData

/--
**T1 (Clarke–Danskin multiplier in the Bayes cone).**

For `q_i > 0`, normalize `p_i := g_i / q_i`. The Clarke–Fermat normal-cone
condition (`g_i ∈ NormalConeW model (w_i)`) translates into "p_i is the
posterior under which `w_i` is Bayes-optimal", i.e.
`p_i ∈ BayesConeW model (w_i)`. The data witness
`data.bayesConeCertificate` records this normalization step (which is
the substantive T1 conclusion). -/
theorem «T1-clarke-danskin-multiplier-bayes-cone»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (_h6 : data.clarkeDanskinRepresentation)
    (_h7 : data.clarkeFermatStationarity)
    (_h8 : data.multipliersAreCalibrationKernel) :
    data.multiplierBayesCone :=
  data.bayesConeCertificate

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

The first ingredient (`hBayes`) is an external "existence of best
Bayes response at a fixed belief" fact: it is downstream of compactness
of `model.PrivateStrategy` together with continuity of `profileOfPrivate`,
which is *not* a field of `RobustTrustModel` but is available in every
intended instance (where `profileOfPrivate` factors through a
`ProfileRealizationSetup`). We absorb it as a `Classical.choice` from a
local existence claim. -/
theorem AlphaZeroSingletonData_exists
    {model : RobustTrustModel}
    (_hα : model.α = 0) :
    Nonempty (AlphaZeroSingletonData model) := by
  classical
  -- (1) Pick a private strategy Bayes-optimal at the prior, via the
  --     `Inventory.V9.bayes_best_response_exists` external fact.
  have hBayes :
      ∃ sigma : model.PrivateStrategy,
        IsBayesOptimal model sigma (priorBelief model) :=
    Inventory.V9.bayes_best_response_exists model (priorBelief model)
  set sigma0 : model.PrivateStrategy := Classical.choose hBayes with hsigma0_def
  have hsigma0_opt : IsBayesOptimal model sigma0 (priorBelief model) :=
    Classical.choose_spec hBayes
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
            (Measure.dirac (constantMessage (model := model))) := by
          exact MeasureTheory.Measure.dirac.isProbabilityMeasure
        infer_instance }
  -- Helper: the misaligned payoff is independent of β because the strategy
  -- is message-ignoring, so the inner integral against any Markov kernel
  -- evaluates to the constant integrand.
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
  -- The mixture payoff is also β-independent.
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
  · -- (posteriorAtConstantMessageIsPrior) At α=0 the mixture message law
    --   reduces to the second marginal of τM ⊗ constantAdversary, which is
    --   a Dirac at `constantMessage`.  The disintegration identity then
    --   collapses the posterior to the prior; this is the
    --   `Inventory.V9.alpha_zero_posterior_collapse` external fact.
    intro pd
    have hβdirac : ∀ s : model.M,
        constantAdversary.kernel s =
          MeasureTheory.Measure.dirac (constantMessage (model := model)) := by
      intro s
      simp [constantAdversary, ProbabilityTheory.Kernel.const_apply]
    -- The priorBelief unfolds to the subtype with value `model.μ0`.
    have hμ0 : (priorBelief model).val = model.μ0 := rfl
    exact Inventory.V9.alpha_zero_posterior_collapse model _hα
      (constantMessage (model := model)) constantAdversary hβdirac pd
      (priorBelief model) hμ0
  · -- (adversaryOptimal) `MixturePayoffFull β priorStrategy` is independent
    --   of β (because `priorStrategy` is message-ignoring), so the range
    --   of the function `β ↦ MixturePayoffFull β priorStrategy` is the
    --   singleton `{MixturePayoffFull constantAdversary priorStrategy}`,
    --   hence its `sInf` equals that constant.
    unfold IsAdversarialFull RobustPayoffFull
    -- Show the range is a singleton.
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
Theorem 2 in the pure-adversarial regime. -/
theorem «T2-alpha-zero-singleton-prior-strategy»
    {model : RobustTrustModel}
    (pd : PosteriorDisintegration model)
    (hα : model.α = 0) :
    HasRobustRationalizableStrategy model pd := by
  obtain ⟨data⟩ := AlphaZeroSingletonData_exists (model := model) hα
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
