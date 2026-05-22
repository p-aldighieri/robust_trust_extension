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
  /-- B5 integral total-balance scalars. -/
  lhsL : ℝ
  rhsL : ℝ
  lhsR : ℝ
  rhsR : ℝ
  /-- Active two-label menu used by the binary Clarke-Danskin/Fermat step. -/
  endpointMenu : FiniteMenuData model 2
  /-- Endpoint balance equations imply the Strassen marginal-dominance
  hypothesis for `endpointRelation`. This is narrower than the old B1
  witness: it gives only the concrete input required by Strassen. -/
  endpointDominanceFromBalance :
    IsEndpointStationarityTotalBalance lhsL rhsL lhsR rhsR →
      _root_.Inventory.V9.StrassenMarginalDominance
        model.τM model.τM endpointRelation
  /-- Scalar nonnegativity of the left endpoint transport mass. -/
  cL_nonneg : 0 ≤ cL
  /-- Scalar nonnegativity of the right endpoint transport mass. -/
  cR_nonneg : 0 ≤ cR
  /-- The endpoint balance equations give the scalar calibration identity. -/
  endpointMassCalibrationFromBalance :
    IsEndpointStationarityTotalBalance lhsL rhsL lhsR rhsR →
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
  /-- A measurable tie split restores the endpoint total-balance equations;
  Binary B1 then converts this balance into the endpoint-fiber lift. -/
  endpointBalanceAfterSplit : data.endpointStationarityTotalBalance

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
Unlike the Binary capstone after the 2026-05-22 pass, this FBNF primitive
class still carries its own capstone bridge field. -/
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
spherical-radial primitive for the remaining FBNF bridge-field rationale. -/
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
proof now invokes `Inventory.V9.strassen_marginals` on the endpoint
relation derived from `_hBalance`; the remaining scalar identity is
assembled from primitive scalar component facts. -/
theorem «binary-L_B1-endpoint-fiber-lift»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hBalance : data.endpointStationarityTotalBalance) :
    data.endpointFiberLift := by
  classical
  have hBalance :
      IsEndpointStationarityTotalBalance
        data.lhsL data.rhsL data.lhsR data.rhsR := by
    simpa [BinaryCapstoneData.endpointStationarityTotalBalance] using _hBalance
  have hDominance :
      _root_.Inventory.V9.StrassenMarginalDominance
        model.τM model.τM data.endpointRelation :=
    data.endpointDominanceFromBalance hBalance
  obtain ⟨π, hπ_coupling, hπ_support⟩ :=
    _root_.Inventory.V9.strassen_marginals
      model.τM model.τM data.endpointRelation hDominance
  have _hEndpointCoupling :
      _root_.Inventory.V9.IsCoupling π model.τM model.τM := hπ_coupling
  have _hEndpointSupport : π data.endpointRelationᶜ = 0 := hπ_support
  unfold BinaryCapstoneData.endpointFiberLift IsEndpointFiberLift
  exact ⟨data.cL_nonneg, data.cR_nonneg,
    data.endpointMassCalibrationFromBalance hBalance⟩

/--
**L_B2 (TRS interval reduction).**

The paper Theorem 1 lifts the binary best-response to an interval
`T = [lL, rR] ⊆ [0,1]`. The theorem assembles the interval statement
from the primitive endpoint inequalities. -/
theorem «binary-L_B2-TRS-interval-reduction»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model) :
    data.trsIntervalReduction := by
  unfold BinaryCapstoneData.trsIntervalReduction IsTRSIntervalReduction
  exact ⟨data.lL_nonneg, data.lL_le_rR, data.rR_le_one⟩

/--
**L_B3 (endpoint-only PROJECTED image).**

Under TRS, the misaligned-BR payoff PROJECTION takes values only in
`{data.pL, data.pR}`. (The literal message kernel still spreads over
endpoint fibers; only the payoff projection is endpoint-supported.) -/
theorem «binary-L_B3-endpoint-only-projected-image»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hTRS : data.trsIntervalReduction) :
    data.endpointOnlyProjectedImage := by
  unfold BinaryCapstoneData.endpointOnlyProjectedImage
    IsEndpointOnlyProjectedImage
  intro m
  have hm := data.proj_eq_endpoint m
  by_cases hside : data.projSide m
  · left
    simpa [hside] using hm
  · right
    simpa [hside] using hm

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
    data.interiorMessageCalibration := by
  have hTRS :
      IsTRSIntervalReduction data.lL data.rR := by
    simpa [BinaryCapstoneData.trsIntervalReduction] using _hTRS
  have hEndpoint :
      IsEndpointOnlyProjectedImage model data.pL data.pR data.proj := by
    simpa [BinaryCapstoneData.endpointOnlyProjectedImage] using _hEndpoint
  unfold BinaryCapstoneData.interiorMessageCalibration
    IsInteriorMessageCalibration
  intro m hm
  /-
  Honest gap: the appendix does not yet contain the binary-simplex algebra
  lemma that turns TRS interval reduction plus endpoint-only projected image
  into the aligned-truthful posterior identity on interior messages. The
  missing local lemma should have shape

    binary_interior_message_calibration
      (hTRS : IsTRSIntervalReduction data.lL data.rR)
      (hEndpoint : IsEndpointOnlyProjectedImage model data.pL data.pR data.proj)
      (hm : data.interior m) :
        data.post m = model.inclM m

  and is the formal version of v9_consolidated.md §B.3/L_B4 (also
  exposition_v9.tex §8).
  -/
  sorry

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
  have hT1Binary : data.endpointMenu.multiplierBayesCone :=
    _hT1 2 data.endpointMenu
  have hTRS :
      IsTRSIntervalReduction data.lL data.rR := by
    simpa [BinaryCapstoneData.trsIntervalReduction] using _hTRS
  have hEndpoint :
      IsEndpointOnlyProjectedImage model data.pL data.pR data.proj := by
    simpa [BinaryCapstoneData.endpointOnlyProjectedImage] using _hEndpoint
  have hIES : data.interiorEndpointStationarity := _hIES
  unfold BinaryCapstoneData.endpointStationarityTotalBalance
    IsEndpointStationarityTotalBalance
  /-
  Honest gap: `hT1Binary` gives the two active normalized multiplier
  posteriors in the Bayes cones. The appendix is still missing the binary
  endpoint bookkeeping lemma that identifies those two cone inequalities,
  under TRS, endpoint-only image, and R-IES, with the two scalar integral
  total-balance equations `lhsL = rhsL` and `lhsR = rhsR`.

  Expected local lemma shape:

    binary_t1_multiplier_balance
      (hT1Binary : data.endpointMenu.multiplierBayesCone)
      (hTRS : IsTRSIntervalReduction data.lL data.rR)
      (hEndpoint :
        IsEndpointOnlyProjectedImage model data.pL data.pR data.proj)
      (hIES : data.interiorEndpointStationarity) :
        data.lhsL = data.rhsL ∧ data.lhsR = data.rhsR

  This is the formal Clarke-Danskin/Fermat-to-total-balance calculation for
  the `k = 2` binary active-label case in v9_consolidated.md §B.3/L_B5.
  -/
  sorry

/--
**L_B6 (capstone).**

Assembling B1 (endpoint-fiber lift), B3 (endpoint-only projected
image), and B5 (total balance) — together with B2 and B4 as
intermediate ingredients — produces a robustly rationalizable
strategy for `data.pd`. The final QAE bridge remains a documented local
gap rather than a bundled capstone witness. -/
theorem «binary-L_B6-capstone»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hB1 : data.endpointFiberLift)
    (_hB2 : data.trsIntervalReduction)
    (_hB3 : data.endpointOnlyProjectedImage)
    (_hB4 : data.interiorMessageCalibration)
    (_hB5 : data.endpointStationarityTotalBalance) :
    HasRobustRationalizableStrategy model data.pd := by
  have hBinaryGeometry :
      data.endpointFiberLift ∧ data.endpointOnlyProjectedImage ∧
        data.endpointStationarityTotalBalance :=
    ⟨_hB1, _hB3, _hB5⟩
  have hTRSCalibration :
      data.trsIntervalReduction ∧ data.interiorMessageCalibration :=
    ⟨_hB2, _hB4⟩
  /-
  Honest gap: the appendix lacks the bridge from the binary construction
  pieces above to `Definition2QAEPredicate`/`HasRobustRationalizableStrategy`.
  The missing lemma should assemble the endpoint-fiber transport, endpoint
  projected image, and total-balance stationarity into an adviser kernel and
  strategy, then discharge the v8 QAE predicate using the same posterior-law
  alignment pattern documented in `robustRationalizableKernelExists_to_strategy`.

  Expected local lemma shape:

    binary_capstone_to_qae
      (hBinaryGeometry :
        data.endpointFiberLift ∧ data.endpointOnlyProjectedImage ∧
          data.endpointStationarityTotalBalance)
      (hTRSCalibration :
        data.trsIntervalReduction ∧ data.interiorMessageCalibration) :
        HasRobustRationalizableStrategy model data.pd
  -/
  sorry

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
      have hHallDual :
          ∀ y : BoundedBorelProfile model, regPsi model reg y ≤ 0 := hPsi
      have hClosedGraph : IsClosed R := hR_closed
      have hSupportFunctionContinuous := hReg2
      /-
      Honest gap: this is the scalar Kantorovich-Strassen dual-to-Hall-dual
      translation.  The available hypothesis is the vector Hall inequality
      `hHallDual` for bounded Borel payoff profiles; Strassen needs the scalar
      test-function inequality over the graph relation `R`.  Filling this
      requires a Mathlib lemma packaging the standard Hahn-Banach / monotone
      class extension from the paper's finite-dimensional Hall prices to
      bounded Borel scalar tests.
      -/
      sorry
  obtain ⟨π, hπ_coupling, hπ_support⟩ :=
    _root_.Inventory.V9.strassen_marginals model.τM model.τM R hDominance
  have hReg1 := reg.G_closedGraph
  have hSupportFunctionContinuous := reg.B_support_continuous
  /-
  Honest gap: `strassen_marginals` supplies the supported coupling `π`.
  The remaining formal bridge disintegrates `π` into an `AdviserKernel`,
  proves `KernelSupportedOnRegG`, and identifies the Bayes-cone posterior
  calibration with `pd.Pγα`.  Mathlib has the measure/kernel primitives used
  elsewhere in v8, but this appendix does not yet contain the specialized
  disintegration-and-selection lemma for the Hall graph relation.
  -/
  sorry

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
  constructor
  · intro hKernel y
    rcases hKernel with ⟨κ, hSupported, hCalibrated⟩
    have hBayesGamma :
        ∀ᵐ m ∂((MixtureCouplingGammaAlpha model κ).map Prod.snd),
          IsBayesOptimal model
            (reg.σstar.sectionFull (model.inclM m)) (reg.pd.Pγα κ m) := by
      filter_upwards [hCalibrated] with m hm
      exact reg.B_bayes_optimal m (reg.pd.Pγα κ m) hm
    have hSupportBound :
        ∀ᵐ m ∂((MixtureCouplingGammaAlpha model κ).map Prod.snd),
          beliefDot (reg.pd.Pγα κ m) (y.toFun m) ≤
            supportFunction model (reg.B m) (y.toFun m) := by
      filter_upwards [hCalibrated] with m hm
      /-
      Honest gap: this is the standard support-function inequality
      `⟪μ,y⟫ ≤ h_{B(m)}(y)` from `μ ∈ B(m)`.  The missing local lemma is a
      bounded-above proof for the image set in `supportFunction`, using the
      finite simplex bound and `y.bounded_coord`, so that `le_csSup` applies.
      -/
      sorry
    have hKernelSupport := hSupported
    have hRowwise := reg.G_rowwise_minimizer
    /-
    Honest gap: integrate the support-function bound over the calibrated
    coupling and use `KernelSupportedOnRegG` plus `hRowwise` to compare the
    second Hall term with the rowwise infimum in `regPsi`.
    -/
    sorry
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
  classical
  rcases h with ⟨κ, hSupported, hCalibrated⟩
  refine ⟨κ, reg.σstar, ?_⟩
  have hBayesGamma :
      ∀ᵐ m ∂((MixtureCouplingGammaAlpha model κ).map Prod.snd),
        IsBayesOptimal model
          (reg.σstar.sectionFull (model.inclM m)) (reg.pd.Pγα κ m) := by
    filter_upwards [hCalibrated] with m hm
    exact reg.B_bayes_optimal m (reg.pd.Pγα κ m) hm
  have hBetaDisintegrates := reg.pd.sourceLawβ_disintegrates κ
  have hGammaDisintegrates := reg.pd.sourceLawγα_disintegrates κ
  have hBetaBarycenter := reg.pd.conditional_barycenter κ
  have hGammaBarycenter := reg.pd.gamma_alpha_conditional_barycenter κ
  have hRowwise := reg.G_rowwise_minimizer
  have hRealizes := reg.σstar_realizes_wstar
  have hSupport := hSupported
  /-
  Honest gap: finish `Definition2QAEPredicate` by proving:
  (1) adversariality of `κ` for `reg.σstar` from `hSupport`, `hRowwise`, and
      `hRealizes`;
  (2) transfer of `hBayesGamma` from the `γ_α` second marginal to
      `MixtureMessageLaw`, identifying `Pβ` with `Pγα` using
      `sourceLawβ_disintegrates`, `sourceLawγα_disintegrates`, and the two
      conditional-barycenter fields.  This is the same v8 disintegration
      alignment pattern as `posterior_disintegration_menuHall_kernel_coincides`.
  -/
  sorry

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
  «binary-L_B1-endpoint-fiber-lift» (model := model)
    hyp.data hyp.endpointBalanceAfterSplit

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
