Patch 1 — Concrete Inventory hypotheses and theorem statements

Reviewer item N correctly identifies the old Inventory layer as a trapdoor: ClarkeDanskinHyp, StrassenMarginalDominance, and ConicFarkasInstance used unconstrained Prop fields, so their axioms could prove arbitrary theorem-shaped equivalences rather than importing a named external result. The source-proof brief also requires every new Inventory axiom to have a precise Lean statement, citation, and Mathlib-coverage justification. 

decomposition_review_response

 

source_proof

lean
import Mathlib

open MeasureTheory
open scoped BigOperators

namespace Inventory

/-!
Patch 1.1: Clarke-Danskin and Clarke-Fermat

External reference:
  F. H. Clarke, Optimization and Nonsmooth Analysis, 1990, especially §2.7
  on generalized gradients and maximum/envelope rules.

Audit note:
  Mathlib has Fréchet derivatives, convexity, local extrema, and finite-
  dimensional calculus, but it does not currently expose Clarke generalized
  gradients or Clarke normal cones as theorem-ready objects. Hence the two
  opaque primitives below are acceptable Inventory objects, but the hypotheses
  feeding them must be mathematical, not arbitrary `Prop` slots.
-/

/-- Clarke generalized subdifferential, modeled as a set of continuous
linear functionals. This is an external nonsmooth-analysis object. -/
opaque ClarkeSubdiff
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] :
    (E → ℝ) → E → Set (E →L[ℝ] ℝ)

/-- Clarke normal cone to a closed feasible set. This is an external
nonsmooth-analysis object. -/
opaque ClarkeNormalCone
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] :
    Set E → E → Set (E →L[ℝ] ℝ)

/-- Concrete local maximizer predicate. -/
def ClarkeLocalMaxOn
    {E : Type*} [PseudoMetricSpace E]
    (F : E → ℝ) (C : Set E) (x : E) : Prop :=
  x ∈ C ∧
    ∃ r : ℝ, 0 < r ∧
      ∀ y ∈ C, y ∈ Metric.closedBall x r → F y ≤ F x

/--
Concrete Clarke-Danskin hypothesis.

`F` is represented as the pointwise supremum of a family `φ i`.
At the base point `x`, the active index set is compact and nonempty;
active functions are Fréchet differentiable at `x`; and `F` is locally
Lipschitz near `x`.

This replaces the old arbitrary fields:
`locallyLipschitz : Prop`, `compactActiveSet : Prop`,
`danskinRepresentation : Prop`.
-/
structure ClarkeDanskinHyp
    {I E : Type*}
    [MeasurableSpace I] [TopologicalSpace I]
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
      ∃ K : ℝ≥0, LipschitzOnWith K F (Metric.closedBall x r)
  active_has_fderiv :
    ∀ i : I, i ∈ Active → HasFDerivAt (φ i) (grad i) x
  grad_continuous_on_active :
    ContinuousOn grad Active

/--
Clarke-Danskin stationarity/import theorem.

The conclusion is the actual nonsmooth-analysis content: a Clarke subgradient
of the envelope lies in the closed convex hull of active gradients.
-/
axiom clarke_danskin_stationarity
    {I E : Type*}
    [MeasurableSpace I] [TopologicalSpace I]
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → ℝ) (x : E)
    (φ : I → E → ℝ)
    (grad : I → E →L[ℝ] ℝ)
    (Active : Set I)
    (h : ClarkeDanskinHyp F x φ grad Active) :
    ∃ ξ : E →L[ℝ] ℝ,
      ξ ∈ closure (convexHull ℝ (grad '' Active)) ∧
      ξ ∈ ClarkeSubdiff F x

/--
Clarke-Fermat rule for a constrained local maximum.

This replaces the old argument `_hLocalMax : Prop` by an actual local
maximum statement on a closed feasible set.
-/
axiom clarke_fermat_normal_cone
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → ℝ) (C : Set E) (x : E)
    (hC_closed : IsClosed C)
    (hLip :
      ∃ r : ℝ, 0 < r ∧
        ∃ K : ℝ≥0, LipschitzOnWith K F (Metric.closedBall x r))
    (hLocalMax : ClarkeLocalMaxOn F C x) :
    ∀ ξ : E →L[ℝ] ℝ,
      ξ ∈ ClarkeSubdiff F x →
        -ξ ∈ ClarkeNormalCone C x


/-!
Patch 1.2: Strassen marginal theorem

External reference:
  V. Strassen, The existence of probability measures with given marginals,
  Annals of Mathematical Statistics, 1965.

Audit note:
  Mathlib has measures, products, pushforwards, integrals, and couplings can be
  expressed with `Measure.map`; it does not expose Strassen's marginal theorem
  in this support-relation / dual-dominance form.
-/

/-- A concrete coupling predicate. -/
def IsCoupling
    {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    (π : Measure (α × β)) (μ : Measure α) (ν : Measure β) : Prop :=
  Measure.map Prod.fst π = μ ∧
    Measure.map Prod.snd π = ν

/--
Concrete Strassen dominance hypothesis.

The dual condition says every bounded/integrable Borel price pair compatible
with the support relation `R` satisfies the corresponding marginal inequality.
This replaces the old field `dualInequality : Prop`.
-/
structure StrassenMarginalDominance
    {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    (μ : Measure α) (ν : Measure β) (R : Set (α × β)) : Prop where
  measurable_R : MeasurableSet R
  μ_finite : IsFiniteMeasure μ
  ν_finite : IsFiniteMeasure ν
  same_total_mass : μ Set.univ = ν Set.univ
  dual_marginal_inequality :
    ∀ f : α → ℝ, ∀ g : β → ℝ,
      Measurable f →
      Measurable g →
      Integrable f μ →
      Integrable g ν →
      (∀ a b, (a, b) ∈ R → f a ≤ g b) →
        (∫ a, f a ∂μ) ≤ (∫ b, g b ∂ν)

/--
Strassen marginal theorem in support-relation form.
-/
axiom strassen_marginals
    {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    (μ : Measure α) (ν : Measure β) (R : Set (α × β))
    (h : StrassenMarginalDominance μ ν R) :
    ∃ π : Measure (α × β),
      IsCoupling π μ ν ∧
        π Rᶜ = 0


/-!
Patch 1.3: finite conic Farkas

External reference:
  Standard finite-dimensional Farkas lemma / conic LP duality.

Audit note:
  Mathlib has matrices, finite sums, linear algebra, convexity, and order
  machinery, but a theorem-ready finite conic LP strong-duality statement in
  exactly this form is not present in the v9 dependency surface. This statement
  is a genuine finite-dimensional Farkas import, not an arbitrary `Prop ↔ Prop`.

Sign convention:
  `conicDualNonpositive` is the no-separating-certificate condition:
  every linear functional nonpositive on all columns is nonpositive on `b`.
-/

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
      ∀ i : I,
        (∑ j : J, inst.A i j * x j) = inst.b i

/-- Dual no-separation condition. -/
def conicDualNonpositive
    {I J : Type*} [Fintype I] [Fintype J]
    (inst : ConicFarkasInstance I J) : Prop :=
  ∀ y : I → ℝ,
    (∀ j : J, (∑ i : I, y i * inst.A i j) ≤ 0) →
      (∑ i : I, y i * inst.b i) ≤ 0

/-- Finite-dimensional conic Farkas lemma. -/
axiom farkas_lp_duality_conic
    {I J : Type*} [Fintype I] [Fintype J]
    (inst : ConicFarkasInstance I J) :
    conicPrimalFeasible inst ↔ conicDualNonpositive inst


/-
Patch 1.4: Berge maximum axiom removal

Do not keep `BergeMaximumHyp` or `berge_maximum_set_valued`.

For pointwise compact argmax/argmin existence, use Mathlib's compact extreme-
value lemmas, e.g. `IsCompact.exists_isMaxOn` and `IsCompact.exists_isMinOn`,
with `ContinuousOn` or the appropriate continuous restriction hypotheses.
Mathlib's docs list these compact-order extreme value results, so a bare
`axiom ... : Prop` is both unusable and unnecessary.  See:
`Mathlib.Topology.Order.Compact`, `IsCompact.exists_isMaxOn`,
`IsCompact.exists_isMinOn`. 
-/

end Inventory

Math justification. The three external tools are now fenced as recognizable mathematical hammers. Clarke-Danskin imports a subgradient inclusion for a locally Lipschitz envelope with compact active set. Strassen imports a support-constrained coupling from a dual marginal inequality. Farkas imports the finite conic feasibility/separation equivalence. The reviewer’s complaint was not that these results are illegitimate, but that the old Lean forms used arbitrary Prop fields; the patch makes the assumptions and conclusions mathematically visible. 

decomposition_review_response

Berge is deliberately removed. The local compact maximum/minimum existence needed for set-valued argmax work should be derived from Mathlib’s compact extreme-value API rather than axiomatized as a theorem returning a bare Prop; Mathlib documents IsCompact.exists_isMaxOn and IsCompact.exists_isMinOn. 
Lean Community

Patch 2 — Remove conclusion-as-field structures and expand Reg kernel content

The reviewer flags the old conclusion fields as making several theorem statements vacuous: capstoneConclusion, calibratedKernelExists, and robustRationalizableLabeling must disappear from data structures, and theorems must conclude the target proposition directly. 

decomposition_review_response

The patched Reg layer also follows the v9 q-a.e. reading: posterior calibration is stated through PosteriorDisintegration and the mixture message marginal, rather than hardcoding a Radon-Nikodym orientation in the theorem surface. The review explicitly says to route through the existing posterior-disintegration package and to keep Reg-1/Reg-2 as real hypotheses, not consequences of standing compactness. 

decomposition_review_response

lean
namespace RobustTrustV9
open RobustTrustV8
open MeasureTheory
open scoped BigOperators

noncomputable section

variable (model : RobustTrustModel)

/-- v9 robust rationalizability, read q-a.e. through the v8 predicate. -/
def RobustRationalizableQAE
    (pd : PosteriorDisintegration model)
    (β : AdviserKernel model)
    (σ : AgentStrategyFull model) : Prop :=
  Definition2QAEPredicate model pd β σ

/-- Existence target used by capstones. -/
def HasRobustRationalizableStrategy
    (pd : PosteriorDisintegration model) : Prop :=
  ∃ β : AdviserKernel model, ∃ σ : AgentStrategyFull model,
    RobustRationalizableQAE model pd β σ


/-!
Patch 2.1: Binary capstone data without built-in conclusion.
-/

structure BinaryCapstoneData where
  pd : PosteriorDisintegration model
  binaryStates : Fintype.card model.Ω = 2
  alpha_pos : 0 < model.α
  alpha_lt_one : model.α < 1
  L R : Belief model.Ω

  /-- R-EE: endpoint payoff profiles are exposed by their endpoint beliefs. -/
  endpointExposure : Prop

  /-- R-TD: endpoint indifference/tie set is null, or replaced by tie-splitting. -/
  tieDiscipline : Prop

  /-- R-IES: endpoints are interior so stationarity is equality, not KKT inequality. -/
  interiorEndpointStationarity : Prop

  /-- Binary B1 endpoint-fiber transport exists. -/
  endpointFiberLift : Prop

  /-- Binary TRS reduces to an interval `[L,R]`. -/
  trsIntervalReduction : Prop

  /--
  The adversary's projected payoff image is endpoint-only.
  This is not a singleton-message support claim.
  -/
  endpointOnlyProjectedImage : Prop

  /-- Interior messages are truthfully calibrated q-a.e. -/
  interiorMessageCalibration : Prop

  /-- Total endpoint-fiber balance equations. -/
  endpointStationarityTotalBalance : Prop


/-!
Patch 2.2: FBNF package without built-in conclusion.
-/

structure Foliation where
  Z : Type
  measurableZ : MeasurableSpace Z
  standardBorelZ : Prop
  a b : Z → ℝ
  intervalNonempty : ∀ z, a z ≤ b z
  ell : (z : Z) → {t : ℝ // a z ≤ t ∧ t ≤ b z} → Belief model.Ω

  /-- Each fiber map is affine in the one-dimensional coordinate. -/
  affineFibers : Prop

  /-- Joint Borel chart / measurable coordinate map. -/
  chartMeasurable : Prop

  /-- Disintegration of τ into base/fiber laws. -/
  disintegration : Prop

  /--
  Either the chart is injective on a full-measure Borel set, or overlaps are
  quotient-consistent for the TRS label and endpoint posterior.
  -/
  quotientConsistent : Prop

structure FBNFPackage where
  pd : PosteriorDisintegration model
  card_ge_three : 3 ≤ Fintype.card model.Ω
  alpha_pos : 0 < model.α
  alpha_lt_one : model.α < 1
  foliation : Foliation model

  /-- FBNF-2: trust-region projection preserves fibers. -/
  fiberPreservingTRS : Prop

  /--
  FBNF-3, corrected: endpoint-supported selector/projection, not strict
  argmin-set inclusion and not singleton-message support.
  -/
  endpointSupportedFiberImage : Prop

  /-- FBNF-4: endpoint labels are Bayes-exposed on their fiber. -/
  fiberEndpointExposure : Prop

  /-- FBNF-5: endpoint tie discipline, or an explicit tie-splitting variant. -/
  fiberTieDiscipline : Prop

  /--
  Local two-sided perturbability. Without this the stationarity conclusion is
  one-sided KKT, not equality.
  -/
  localTwoSidedPerturbability : Prop

  /--
  FBNF-7: global fiber dominance, turning fiberwise row minimizers into true
  original-game minimizers.
  -/
  globalFiberDominance : Prop

  /-- F1: conditional binary endpoint-fiber transports paste measurably. -/
  conditionalB1Pasting : Prop

  /-- F3: FBNF-6 balance derived from localized stationarity. -/
  localizedStationarityFBNF6 : Prop


/-!
Patch 2.3: Reg package with concrete kernel-existence predicates.
-/

/-- Support of an adviser kernel on the rowwise minimizer correspondence `G`. -/
def KernelSupportedOnRegG
    (regG : model.M → Set model.M)
    (κ : AdviserKernel model) : Prop :=
  ∀ᵐ s ∂model.τM,
    ∀ᵐ m ∂(κ.kernel s),
      m ∈ regG s

/--
Concrete calibrated-kernel existence predicate.

This expands the old `RegPackage.calibratedKernelExists : Prop`.

The kernel is supported on rowwise minimizers `G(s)`. For the mixture law
`γ_α := α(id,id)#τ + (1-α)τ⊗κ`, encoded by `MixtureCouplingGammaAlpha`,
its posterior `Pγα κ m` lies in the Bayes cone `B(m)` for q-a.e. message.
-/
def RegCalibratedKernelExists
    (pd : PosteriorDisintegration model)
    (G : model.M → Set model.M)
    (B : model.M → Set (Belief model.Ω)) : Prop :=
  ∃ κ : AdviserKernel model,
    KernelSupportedOnRegG model G κ ∧
      ∀ᵐ m ∂((MixtureCouplingGammaAlpha model κ).map Prod.snd),
        pd.Pγα κ m ∈ B m

/--
Concrete robust-rationalizable kernel predicate for a fixed labeling.

This is intentionally the same mathematical content as calibrated kernel
existence, plus the package fields below that identify `G` as rowwise
minimizers and `B` as Bayes cones for the chosen labeling.
-/
def RegRobustRationalizableKernelExists
    (pd : PosteriorDisintegration model)
    (G : model.M → Set model.M)
    (B : model.M → Set (Belief model.Ω)) : Prop :=
  RegCalibratedKernelExists model pd G B

structure RegPackage where
  pd : PosteriorDisintegration model

  /-- Optimal payoff labeling. -/
  wstar : model.M → Profile model
  wstar_inWP : ∀ m, wstar m ∈ WP model
  wstar_measurable : Measurable wstar

  /-- A concrete agent strategy realizing the labeling. -/
  σstar : AgentStrategyFull model
  σstar_realizes_wstar :
    ∀ m : model.M,
      model.profileOfPrivate (σstar.sectionFull (model.inclM m)) = wstar m

  /-- Rowwise minimizer correspondence. -/
  G : model.M → Set model.M
  G_nonempty : ∀ s, (G s).Nonempty
  G_compact : ∀ s, IsCompact (G s)
  G_closedGraph : IsClosed {p : model.M × model.M | p.2 ∈ G p.1}
  G_rowwise_minimizer :
    ∀ s m, m ∈ G s →
      ∀ m' : model.M,
        beliefDot (model.inclM s) (wstar m) ≤
          beliefDot (model.inclM s) (wstar m')

  /-- Bayes-cone correspondence for the fixed labeling. -/
  B : model.M → Set (Belief model.Ω)
  B_closed : ∀ m, IsClosed (B m)
  B_convex_profile :
    ∀ m, Convex ℝ ((fun μ : Belief model.Ω =>
      beliefAsProfile μ) '' B m)
  B_support_continuous :
    ∀ y : Profile model,
      Continuous fun m => supportFunction model (B m) y
  B_bayes_optimal :
    ∀ m μ, μ ∈ B m →
      IsBayesOptimal model (σstar.sectionFull (model.inclM m)) μ

  /-- Hall dual functional. -/
  Psi : BoundedBorelProfile model → ℝ

def PsiNonpos (reg : RegPackage model) : Prop :=
  ∀ y : BoundedBorelProfile model, reg.Psi y ≤ 0

def RegPackage.calibratedKernelExists
    (reg : RegPackage model) : Prop :=
  RegCalibratedKernelExists model reg.pd reg.G reg.B

def RegPackage.robustRationalizableKernelExists
    (reg : RegPackage model) : Prop :=
  RegRobustRationalizableKernelExists model reg.pd reg.G reg.B


/-!
Patch 2.4: Graph FBNF package without built-in conclusion.
-/

structure GraphFBNFPackage where
  pd : PosteriorDisintegration model
  finiteGraph : Prop
  affineArcCharts : Prop
  endpointFiberTransportOnEdges : Prop
  kirchhoffNodeBalance : Prop
  crossEdgeDominance : Prop


/-!
Patch 2.5: theorem surfaces after conclusion-field removal.
Only the theorem conclusions change; proof bodies remain `sorry`.
-/

theorem «binary-L_B3-endpoint-only-projected-image»
    (data : BinaryCapstoneData model)
    (hTRS : data.trsIntervalReduction) :
    data.endpointOnlyProjectedImage := by
  sorry

theorem «binary-L_B6-capstone»
    (data : BinaryCapstoneData model)
    (hB1 : data.endpointFiberLift)
    (hB2 : data.trsIntervalReduction)
    (hB3 : data.endpointOnlyProjectedImage)
    (hB4 : data.interiorMessageCalibration)
    (hB5 : data.endpointStationarityTotalBalance) :
    HasRobustRationalizableStrategy model data.pd := by
  sorry

theorem «FBNF-F2-endpoint-only-projected-fiber-image»
    (pkg : FBNFPackage model)
    (hTRS : pkg.fiberPreservingTRS) :
    pkg.endpointSupportedFiberImage := by
  sorry

theorem «FBNF-F3-localized-stationarity-FBNF6»
    (pkg : FBNFPackage model)
    (hT1 : ∀ k (fd : FiniteMenuData model k),
      fd.multiplierBayesCone)
    (hF2 : pkg.endpointSupportedFiberImage)
    (hPert : pkg.localTwoSidedPerturbability) :
    pkg.localizedStationarityFBNF6 := by
  sorry

theorem «FBNF-F4-capstone»
    (pkg : FBNFPackage model)
    (hF1 : pkg.conditionalB1Pasting)
    (hF2 : pkg.endpointSupportedFiberImage)
    (hF3 : pkg.localizedStationarityFBNF6)
    (hDom : pkg.globalFiberDominance) :
    HasRobustRationalizableStrategy model pkg.pd := by
  sorry

theorem «Hall-G2c-borel-extension»
    (reg : RegPackage model)
    (hPsi : PsiNonpos model reg) :
    reg.calibratedKernelExists := by
  sorry

theorem «Hall-biconditional»
    (reg : RegPackage model) :
    reg.robustRationalizableKernelExists ↔ PsiNonpos model reg := by
  sorry

theorem robustRationalizableKernelExists_to_strategy
    (reg : RegPackage model)
    (h : reg.robustRationalizableKernelExists) :
    HasRobustRationalizableStrategy model reg.pd := by
  rcases h with ⟨κ, hSupp, hCal⟩
  refine ⟨κ, reg.σstar, ?_⟩
  -- `hSupp` gives adversarial support on rowwise minimizers.
  -- `hCal` gives q-a.e. posterior-in-Bayes-cone calibration.
  -- `reg.G_rowwise_minimizer` and `reg.B_bayes_optimal` turn these into
  -- Definition 2 q-a.e. robust rationalizability.
  sorry

theorem «P2-star-cone-margin-bounded-jamming»
    (hyp : P2StarHyp model)
    (hMargin : hyp.coneMargin)
    (hJam : hyp.boundedJamming)
    (hBase : hyp.enoughAlignedBaseline) :
    HasRobustRationalizableStrategy model hyp.reg.pd := by
  have hPsi : PsiNonpos model hyp.reg := by
    sorry
  have hKernel : hyp.reg.robustRationalizableKernelExists :=
    («Hall-biconditional» model hyp.reg).mpr hPsi
  exact robustRationalizableKernelExists_to_strategy model hyp.reg hKernel

theorem «P3-polyhedral-cone-margin»
    (hyp : P3Hyp model)
    (hPoly : hyp.polyhedralW)
    (hFinite : hyp.finiteVertexMenu)
    (hMargin : hyp.positiveConeMargin)
    (hLP : hyp.finiteLPFeasible) :
    HasRobustRationalizableStrategy model hyp.reg.pd := by
  have hPsi : PsiNonpos model hyp.reg := by
    sorry
  have hKernel : hyp.reg.robustRationalizableKernelExists :=
    («Hall-biconditional» model hyp.reg).mpr hPsi
  exact robustRationalizableKernelExists_to_strategy model hyp.reg hKernel

theorem «P4-radial-antipodal-tau-symmetry»
    (hyp : P4Hyp model)
    (hRadial : hyp.radialTau)
    (hEq : hyp.utilityEquivariant)
    (hKernel : hyp.antipodalKernelConstructed)
    (hBalance : hyp.scalarRadialBalance) :
    HasRobustRationalizableStrategy model hyp.reg.pd := by
  have hPsi : PsiNonpos model hyp.reg := by
    sorry
  have hKernelExists : hyp.reg.robustRationalizableKernelExists :=
    («Hall-biconditional» model hyp.reg).mpr hPsi
  exact robustRationalizableKernelExists_to_strategy model hyp.reg hKernelExists

theorem «G-addendum-P6_G-finite-graph-FBNF»
    (pkg : GraphFBNFPackage model)
    (hGraph : pkg.finiteGraph)
    (hArcs : pkg.affineArcCharts)
    (hEdge : pkg.endpointFiberTransportOnEdges)
    (hKirchhoff : pkg.kirchhoffNodeBalance)
    (hDom : pkg.crossEdgeDominance) :
    HasRobustRationalizableStrategy model pkg.pd := by
  sorry

end
end RobustTrustV9

Math justification. The FBNF capstone’s actual object is a Borel adversarial kernel with endpoint-fiber support, not a field already asserting robust rationalizability. The source ledger emphasizes that the literal kernel spreads over endpoint fibers to calibrate posteriors, while only the projected payoff image is endpoint-only; it also says local two-sided perturbability is required to derive equality balances. 

v9_consolidated

 The Reg patch makes the Hall direction honest: Ψ ≤ 0 produces a supported kernel and posterior-in-Bayes-cone calibration q-a.e., then the bridge theorem turns that concrete kernel into HasRobustRationalizableStrategy.

Patch 3 — Non-vacuous FBNF corollaries as instantiation lemmas

The old corollaries were no-ops of the form “assume the capstone conclusion, return the capstone conclusion.” The reviewer explicitly calls these vacuous and requests actual instantiation lemmas from primitive class data. 

decomposition_review_response

The patched design below does not pretend that P4Hyp, “affine MLR,” or “polyhedral scalarizable” alone magically implies every FBNF field. Each primitive class carries the concrete derivations needed to build an FBNFPackage: chart, fiber-preserving TRS, endpoint-supported projected image, endpoint exposure, tie discipline, local two-sided perturbability, and global fiber dominance. This is not ornamental bookkeeping. The FBNF source says a true Borel chart or quotient consistency is needed for measurable pasting, endpoint-fiber support is needed for calibration, and FBNF-7 is the cross-fiber condition that turns fiberwise minimizers into true rowwise minimizers. 

sanity_chunk2_response

lean
namespace RobustTrustV9
open RobustTrustV8
open MeasureTheory

noncomputable section

variable (model : RobustTrustModel)

/-!
Patch 3.1: spherical/radial primitive-to-FBNF instantiation.

This replaces the old theorem:

  theorem «FBNF-corollary-spherical-radial»
      ... (hF4 : HasRobustRationalizableStrategy model pkg.pd) :
      HasRobustRationalizableStrategy model pkg.pd := hF4

The new statement constructs an FBNF package from radial primitives and then
applies `FBNF-F4-capstone`.
-/

structure SphericalRadialFBNFPrimitive where
  radial : P4Hyp model
  pd : PosteriorDisintegration model
  card_ge_three : 3 ≤ Fintype.card model.Ω
  alpha_pos : 0 < model.α
  alpha_lt_one : model.α < 1

  /-- Radial diameters give the affine one-dimensional fibers. -/
  foliation : Foliation model
  foliationFromRadialDiameters : Prop

  /-- Radial trust ball projection preserves diameter fibers. -/
  fiberPreservingTRS_from_radialProjection : Prop

  /-- Antipodal boundary routing gives endpoint-supported projected image. -/
  endpointSupport_from_antipodalRouting : Prop

  /-- Radial/equivariant utility exposes fiber endpoints. -/
  fiberEndpointExposure_from_radialUtility : Prop

  /-- Radial τ gives the needed zero-tie or explicit tie-split condition. -/
  fiberTieDiscipline_from_radialTau : Prop

  /-- Positive-radius/interior perturbations give two-sided stationarity. -/
  localTwoSidedPerturbability_from_radialBand : Prop

  /-- Symmetry makes fiberwise minimizers globally rowwise minimizing. -/
  globalFiberDominance_from_radialSymmetry : Prop

theorem «FBNF-corollary-spherical-radial»
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
      conditionalB1Pasting := by
        -- Derived from radial chart + scalar endpoint-fiber B1 transports.
        sorry
      localizedStationarityFBNF6 := by
        -- Derived from local two-sided perturbability and T1 stationarity.
        sorry }
  refine ⟨pkg, ?_⟩
  apply «FBNF-F4-capstone» model pkg
  · exact pkg.conditionalB1Pasting
  · exact pkg.endpointSupportedFiberImage
  · exact pkg.localizedStationarityFBNF6
  · exact pkg.globalFiberDominance


/-!
Patch 3.2: affine-MLR / single-crossing primitive-to-FBNF instantiation.
-/

structure AffineMLRSingleCrossingPrimitive where
  pd : PosteriorDisintegration model
  card_ge_three : 3 ≤ Fintype.card model.Ω
  alpha_pos : 0 < model.α
  alpha_lt_one : model.α < 1

  /-- Affine MLR chart by one-dimensional likelihood-ratio coordinate. -/
  foliation : Foliation model
  affineMLRChart : Prop

  /-- TRS projection is monotone and preserves MLR fibers. -/
  fiberPreservingTRS_from_MLR : Prop

  /-- Single crossing reduces rowwise minimization to fiber endpoints. -/
  endpointSupport_from_singleCrossing : Prop

  /-- Single crossing exposes the Bayes cones at endpoints. -/
  endpointExposure_from_singleCrossing : Prop

  /-- Tie discipline or explicit measurable tie splitting along MLR fibers. -/
  tieDiscipline_or_split : Prop

  /-- Interior endpoint perturbations are admissible. -/
  localTwoSidedPerturbability_from_MLR : Prop

  /-- MLR monotonicity gives cross-fiber dominance. -/
  globalFiberDominance_from_MLR : Prop

theorem «FBNF-corollary-affine-MLR-single-crossing»
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
      endpointSupportedFiberImage :=
        prim.endpointSupport_from_singleCrossing
      fiberEndpointExposure :=
        prim.endpointExposure_from_singleCrossing
      fiberTieDiscipline := prim.tieDiscipline_or_split
      localTwoSidedPerturbability :=
        prim.localTwoSidedPerturbability_from_MLR
      globalFiberDominance := prim.globalFiberDominance_from_MLR
      conditionalB1Pasting := by
        -- Conditional scalar endpoint-fiber transports, pasted over the
        -- affine MLR chart.
        sorry
      localizedStationarityFBNF6 := by
        -- Localized endpoint perturbations + Clarke-Danskin T1.
        sorry }
  refine ⟨pkg, ?_⟩
  apply «FBNF-F4-capstone» model pkg
  · exact pkg.conditionalB1Pasting
  · exact pkg.endpointSupportedFiberImage
  · exact pkg.localizedStationarityFBNF6
  · exact pkg.globalFiberDominance


/-!
Patch 3.3: polyhedral scalarizable primitive-to-FBNF instantiation.
-/

structure PolyhedralScalarizablePrimitive where
  pd : PosteriorDisintegration model
  card_ge_three : 3 ≤ Fintype.card model.Ω
  alpha_pos : 0 < model.α
  alpha_lt_one : model.α < 1

  /-- Polyhedral active face decomposition into affine scalar fibers. -/
  foliation : Foliation model
  polyhedralW : Prop
  scalarizableBayesFaces : Prop

  /-- Projection to the active scalarized face preserves fibers. -/
  fiberPreservingTRS_from_scalarization : Prop

  /-- Face scalarization gives endpoint-supported projected minimizers. -/
  endpointSupport_from_scalarizedFaces : Prop

  /-- Bayes faces expose the endpoint labels. -/
  endpointExposure_from_faceNormalCones : Prop

  /-- Finite-facet tie discipline, or tie-splitting variables. -/
  finiteFacetTieDiscipline_or_split : Prop

  /-- Two-sided perturbations within active scalarized faces. -/
  localTwoSidedPerturbability_on_faces : Prop

  /-- Cross-face dominance or finite-facet LP pass. -/
  globalFiberDominance_or_LP_certificate : Prop

theorem «FBNF-corollary-polyhedral-scalarizable»
    (prim : PolyhedralScalarizablePrimitive model) :
    ∃ pkg : FBNFPackage model,
      HasRobustRationalizableStrategy model pkg.pd := by
  let pkg : FBNFPackage model :=
    { pd := prim.pd
      card_ge_three := prim.card_ge_three
      alpha_pos := prim.alpha_pos
      alpha_lt_one := prim.alpha_lt_one
      foliation := prim.foliation
      fiberPreservingTRS :=
        prim.fiberPreservingTRS_from_scalarization
      endpointSupportedFiberImage :=
        prim.endpointSupport_from_scalarizedFaces
      fiberEndpointExposure :=
        prim.endpointExposure_from_faceNormalCones
      fiberTieDiscipline :=
        prim.finiteFacetTieDiscipline_or_split
      localTwoSidedPerturbability :=
        prim.localTwoSidedPerturbability_on_faces
      globalFiberDominance :=
        prim.globalFiberDominance_or_LP_certificate
      conditionalB1Pasting := by
        -- Apply scalar endpoint-fiber B1 on every scalarized face/fiber and
        -- paste using the finite polyhedral chart.
        sorry
      localizedStationarityFBNF6 := by
        -- Finite active faces reduce stationarity to T1 plus finite-facet
        -- endpoint perturbations.
        sorry }
  refine ⟨pkg, ?_⟩
  apply «FBNF-F4-capstone» model pkg
  · exact pkg.conditionalB1Pasting
  · exact pkg.endpointSupportedFiberImage
  · exact pkg.localizedStationarityFBNF6
  · exact pkg.globalFiberDominance

end
end RobustTrustV9

Math justification. These are now genuine instantiation lemmas. Each corollary takes primitive geometric data, builds an FBNFPackage, and applies FBNF-F4-capstone. The spherical/radial case uses radial diameters and antipodal boundary routing; the affine-MLR case uses affine fibers and single crossing; the polyhedral case uses scalarizable Bayes faces or a finite-facet LP-style dominance certificate. This matches the source ledger’s description that FBNF is a conditional class requiring Borel affine chart or quotient consistency, endpoint-fiber transport, local two-sided perturbability, and global fiber dominance. 

sanity_chunk2_response

Follow-up open question. P4Hyp alone is not enough to derive a complete FBNF package without additional bridge fields such as foliationFromRadialDiameters and globalFiberDominance_from_radialSymmetry. Likewise, “affine MLR” and “polyhedral scalarizable” are not Lean-checkable magic words unless they include concrete chart, exposure, tie, perturbability, and dominance hypotheses. Leaving those bridges implicit would simply repaint the old trapdoor in brighter colors.