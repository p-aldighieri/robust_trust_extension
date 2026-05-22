
========
ROLE: user (id=5e833486-ce1f-4f7c-b867-67c303036d29)
========
ROLE — Lean 4 / Mathlib formalization architect. Produce a Lean-ready decomposition of the v9 Robust Trust Theorem 2 infinite-extension package. Sources: v9_consolidated.md (master, 2019 lines), exposition_v9.tex (canonical statements, 905 lines), exposition_v9_paper.tex (long-form, 900 lines), v9_executive_summary.md, plus the v8 baseline v8_main.lean (4981 lines, the predecessor Lean file in namespace RobustTrustV8).

# The task

Produce **one Lean-ready decomposition document** for the full v9 surface. This document will be saved as lean/decomposition.md and will drive the per-lemma formalization rounds. The document is the **skeleton** — not the proofs. Proofs come in subsequent prover-session passes, one lemma at a time.

# What "Lean-ready" means

For each theorem/lemma:

1. **Slug** in kebab-case (e.g. binary-L_B5-endpoint-stationarity). Must match the ledger in lean_state.md.
2. **Lean statement** in Lean 4 / Mathlib syntax, using the RobustTrustV8 namespace primitives (RobustTrustModel, Belief, Profile, PayoffProfileSet, MenuHall, ExactContact, etc.) where they apply. New v9 primitives (Pareto frontier WP, finite-menu functional Fk, cone-Hall dual Psi, FBNF foliation Foliation, regularity package RegPackage, primitive class predicates) must be **declared first** in a RobustTrustV9 namespace at the top of main.lean before the theorem statements.
3. **Dependency list**: which other lemmas in this decomposition does this one use, and which **Inventory axioms** (Mathlib-unprovable, axiomatized in support/INVENTORY.lean) does it consume. For each Inventory axiom, give a one-line citation (Clarke 1990, Strassen 1965, Aliprantis–Border, Castaing–Valadier, Kechris 1995).
4. **Proof outline** in 3–8 bullet points (math-level, not Lean tactics yet). Should be specific enough that a downstream prover session can fill in the tactics.
5. **Estimated difficulty**: SMALL (≤ 50 lines Lean), MEDIUM (50–200), LARGE (200–500), HUGE (500+).
6. **Source-doc anchor**: page or section reference in v9_consolidated.md and exposition_v9.tex.

# The full v9 surface (full scope is locked)

Decompose all of:

**A. Inventory axioms (new in v9; add to support/INVENTORY.lean alongside reused v8 axioms):**
- clarke_danskin_stationarity — Clarke subdifferential of an integral / Danskin's theorem applied to a value functional; needed for T1.
- clarke_fermat_normal_cone — Clarke subdifferential at a local extremum lies in the normal cone.
- strassen_marginals — Strassen 1965 coupling existence under marginal dominance / Kantorovich–Rubinstein duality form; needed for Hall biconditional G2c.
- farkas_lp_duality_conic — Farkas' lemma / strong LP duality in conic form; needed for G1 finite cone-Hall and G4 LP threshold.
- berge_maximum_set_valued — Berge's maximum theorem for set-valued correspondences; if Mathlib's IsCompact.isClosed_argmax family suffices, do NOT axiomatize; flag this as a Mathlib audit task.
- hausdorff_alexandroff_continuous_surjection — continuous surjection from the Cantor space onto any compact metric space; reused from v8 atomless τ work if available, else lift to Inventory.

Reused from v8 Inventory (do not redeclare; just note that v9 lemmas consume them):
- measurable_argmax_selector (KRN)
- krn_borel_right_inverse
- kernel_infimum_epsilon_selection

**B. Theorems and lemmas (the full v9 surface):**

1. **T1 — Finite-menu Pareto-Hall calibration via Clarke–Danskin** (exposition_v9.tex §3, v9_consolidated.md §B.1)
   - T1-clarke-danskin-multiplier-bayes-cone — given Clarke–Danskin stationarity (axiom), the resulting multipliers λ⁺, λ⁻ satisfy p_i = g_i/q_i ∈ B_W(w_i). This is the consequence we actually prove.
   - Plus the integral Clarke–Danskin representation (L6), Clarke–Fermat stationarity (L7), and multipliers-are-calibration-kernel (L8) sub-lemmas.

2. **T2 — α=0 unconditional infinite extension via singleton strategy** (exposition_v9.tex §4, v9_consolidated.md §B.2)
   - T2-alpha-zero-singleton-prior-strategy — when α=0, the optimal payoff-profile menu collapses to a singleton; the constant adversarial message induces μ_0; Bayes-optimal at prior gives robust rationalizability.
   - Sub-lemmas as in the proof.

3. **Binary capstone** (exposition_v9.tex §8, v9_consolidated.md §B.3)
   - binary-L_B1-endpoint-fiber-lift — Borel kernel realizing scalar calibration under total-balance η(A_-) = ν(S_+).
   - binary-L_B2-TRS-interval-reduction — paper Theorem 1 lift.
   - binary-L_B3-endpoint-only-image — misaligned BR concentrates on {L, R}.
   - binary-L_B4-interior-message-calibration — under TRS, interior messages aligned-only, posterior = message.
   - binary-L_B5-endpoint-stationarity-total-balance — Clarke–Danskin Fermat with k≤2 active labels gives the integral equations.
   - binary-L_B6-capstone — assemble B1+B3+B5 into the theorem.

4. **FBNF capstone + 3 corollaries** (exposition_v9.tex §9, v9_consolidated.md §B.4)
   - FBNF-F1-conditional-B1-measurable-pasting
   - FBNF-F2-endpoint-only-fiber-image
   - FBNF-F3-localized-stationarity-FBNF6 (derives FBNF-6 from optimality)
   - FBNF-F4-capstone
   - FBNF-corollary-spherical-radial
   - FBNF-corollary-affine-MLR-single-crossing
   - FBNF-corollary-polyhedral-scalarizable

5. **Hall biconditional + WTA certificate** (exposition_v9.tex §11, v9_consolidated.md §B.5)
   - Hall-G1-finite-cone-hall-farkas-LP — finite cone-Hall via Farkas/LP duality.
   - Hall-G2c-borel-extension — Borel extension from finite to general measurable (no compact-patch deletion, no cell-flow, no ε-net slack).
   - Hall-biconditional — (a) ⟺ Ψ(y) ≤ 0 for all bounded Borel y, under (Reg-1)+(Reg-2).
   - Hall-WTA-dual-certificate-psi-two-ninths — explicit Ψ(y) = 2/9 for WTA ternary uniform.
   - Hall-WTA-reopening-threshold-D — D ≥ 2(1−α)/(9α) reopening condition.

6. **G4 finite-facet polyhedral LP threshold** (exposition_v9.tex §13, v9_consolidated.md §B.5.G4)
   - G4-finite-facet-polyhedral-LP-threshold — Ψ ≤ 0 ⟺ explicit finite LP feasibility a_j + b_j ≤ 0 at extreme directions of the polyhedral normal fan.

7. **Primitive sufficient classes** (exposition_v9.tex §12, v9_consolidated.md §B.7)
   - P2-star-cone-margin-bounded-jamming — (P1) + uniform cone margin η + sufficient aligned baseline mass D → Ψ ≤ 0.
   - P3-polyhedral-cone-margin — polyhedral W, finite-vertex C*, supporting cones with positive margin → finite LP feasibility.
   - P4-radial-antipodal-tau-symmetry — τ-symmetric, u equivariant → Ψ ≤ 0 via primal symmetry construction.

8. **Section G v9.2 sharpenings** (v9_consolidated.md §G)
   - G-addendum-binary-tie-splitting — relax R-TD: atom at endpoint indifference belief → measurable tie-splitting preserves calibration.
   - G-addendum-variable-margin-P2-star-prime — uniform cone-margin η weakened to Borel-positive margin η(m) > 0 with local cap on adversarial target density.
   - G-addendum-P6_G-finite-graph-FBNF — FBNF extends to finite graphs of affine arcs with Kirchhoff node balance at shared vertices.

# Cross-cutting structural questions to address up front

Before listing per-lemma decomposition, the document should open with a **§0 Structural questions** answering:

Q1. **Pareto frontier WP as a Lean type**: Is WP : Set (Profile model) (subset of W) sufficient, or do we need a coercion WP → CompactConvex with the Pareto-dominance order? Recommend the simplest that closes the proofs.

Q2. **KCompact W for the Pareto-frontier game** \mathcal G_P: how to formalize "compact set of compact subsets of W^P under Hausdorff distance". Mathlib has EMetric.Hausdorff, TopologicalSpace.NonemptyCompacts, Blaschke selection. Pick the cleanest.

Q3. **Cone-Hall dual functional Psi**: signature, domain. Likely Psi : (M → ℝ^|Ω|) → ℝ for bounded Borel y. How to encode "bounded Borel" — BoundedContinuousFunction is too narrow; need BoundedBorelFunction or BddBelow ∩ BddAbove ∧ Measurable. Recommend.

Q4. **Regularity package**: (Reg-1) closed-graph rowwise-minimizer correspondence + (Reg-2) continuous support function. Structure or two separate hypotheses? Recommend.

Q5. **FBNF foliation**: how to encode a measurable affine 1-d foliation of Δ(Ω) over a standard Borel base. Structure Foliation with fields (Z : StandardBorel, embed : Z → [a, b] → Belief, disintegration : ...) style.

Q6. **Clarke subdifferential** in Lean: Mathlib has Lipschitz and ConvexOn but no Clarke subdifferential calculus. Treat as a black box: declare an axiom of the form clarke_danskin_stationarity : ... → ∃ multipliers, ... and consume it directly.

Q7. **Reuse from v8**: which v8 namespace declarations are imported verbatim, and which need v9-specific refinements? List the imports needed.

Q8. **Inventory axioms naming convention**: stay consistent with v8 (Inventory.measurable_argmax_selector etc.). New v9 axioms live in Inventory namespace or a new Inventory.V9 sub-namespace? Recommend.

# Output format

Produce a single coherent markdown document (NOT a chat reply, a document) with these sections:


# v9 Lean decomposition

§0 Structural questions (Q1–Q8 above with concrete answers)
§1 New Inventory axioms (6 new + 3 reused from v8)
§2 RobustTrustV9 namespace: new primitives (Pareto frontier, game G_P, regularity, FBNF, Psi)
§3 Theorem T1 + sub-lemmas L6/L7/L8
§4 Theorem T2
§5 Binary capstone L_B1 ... L_B6
§6 FBNF F1 ... F4 + 3 corollaries
§7 Hall biconditional G1, G2c, Hall, WTA Psi=2/9, WTA threshold D
§8 G4 polyhedral LP threshold
§9 Primitive sufficient classes P2*, P3, P4
§10 Section G sharpenings (3 sub-lemmas)
§11 Proving order recommendation (dependency-DAG topological sort)
§12 Mathlib dep audit: list every Mathlib lemma the formalization will likely need; flag any that are open issues or unstable APIs.
§13 Open questions / blocker risks


For each lemma in §3–§10, use the per-lemma template:

### <slug>
**Statement (Lean):**
\`\`\`lean
theorem <slug> ... := by sorry
\`\`\`
**Depends on:** <list of slugs + Inventory axioms>
**Source anchor:** v9_consolidated.md §..., exposition_v9.tex §...
**Proof outline:** 3–8 bullets.
**Difficulty:** SMALL/MEDIUM/LARGE/HUGE.


Be exhaustive on dependencies. Be conservative on Lean syntax — if you're unsure of an exact Mathlib name, write a comment with the expected lemma name and flag it in §12. The goal is a document I can hand to per-lemma prover sessions, not a finished Lean file.

Use as much reasoning time as needed. Adversarial: if any v9 theorem statement is unclear or has gaps that the formalization will expose, flag them in §13 with a specific question for me.

Output the full document. No summary, no apologies. Just the decomposition.

Show more

========
ROLE: assistant (id=6e58ab59-f42b-476b-aecf-83b768129766)
========
v9 Lean decomposition

Source note. This decomposition treats v9_consolidated.md as the detailed proof ledger, exposition_v9.tex as canonical for theorem statements, and exposition_v9_paper.tex as long-form positioning, per the v9 source-proof pointer. The locked Lean scope includes T1, T2, the binary and FBNF capstones, Hall biconditional, WTA certificate and threshold, G4, P2*/P3/P4, and the three Section G sharpenings. 

source_proof

 

source_proof

 The v9 Lean layer imports the v8 RobustTrustV8 namespace and reuses RobustTrustModel, Belief, Profile, PayoffProfileSet, MenuHall, ExactContact, the WTA machinery, and the v8 Inventory measurable-selection stubs. 

lean_state

§0 Structural questions
Q1. Pareto frontier WP as a Lean type

Use WP : Set (Profile model) as the primitive object, plus a subtype abbreviation when a compact hyperspace needs an element type:

lean
def WeakParetoProfile (model : RobustTrustModel) (w : Profile model) : Prop := ...
def WP (model : RobustTrustModel) : Set (Profile model) :=
  { w | WeakParetoProfile model w }

abbrev WPProfile (model : RobustTrustModel) : Type :=
  { w : Profile model // w ∈ WP model }

Do not coerce WP into CompactConvex. The weak Pareto frontier is compact but generally not convex. The ambient feasible-payoff set W is the compact convex object; WP is a closed frontier subset used for menus and Bayes cones. This is the cleanest Lean split: PayoffProfileSet model carries convexity, while WP model carries frontier membership.

Q2. KCompact W for the Pareto-frontier game 𝓖_P

Formalize compact menus as nonempty compact subsets of the subtype WPProfile model:

lean
abbrev KCompactWP (model : RobustTrustModel) : Type :=
  TopologicalSpace.NonemptyCompacts (WPProfile model)

Mathlib currently has Hausdorff-distance APIs for closed and nonempty compact subsets: Mathlib.Topology.MetricSpace.Closeds defines metric/emetric structures on Closeds and NonemptyCompacts, while Mathlib.Topology.MetricSpace.HausdorffDistance exposes Metric.hausdorffEDist and Metric.hausdorffDist. 
Lean Community
+1

Audit task: check whether the imported NonemptyCompacts instance gives the exact compactness theorem needed for Blaschke selection on WPProfile model. If not, keep KCompactWP as a structure with carrier, nonempty, compact, and use Hausdorff distance manually.

Q3. Cone-Hall dual functional Psi

Use bounded Borel functions, not BoundedContinuousFunction. The Hall theorem quantifies over bounded Borel vector prices:

lean
structure BoundedBorelProfile (model : RobustTrustModel) where
  toFun : model.M → Profile model
  measurable_toFun : Measurable toFun
  bounded_coord : ∃ C : ℝ, 0 ≤ C ∧ ∀ m ω, |toFun m ω| ≤ C

Then encode:

lean
def PsiNonpos (reg : RegPackage model) : Prop :=
  ∀ y : BoundedBorelProfile model, reg.Psi y ≤ 0

This avoids a false continuity restriction. Continuous bounded prices are useful for approximation lemmas, but the theorem surface is Borel.

Q4. Regularity package

Use one structure:

lean
structure RegPackage (model : RobustTrustModel) where
  wstar : model.M → Profile model
  wstar_inWP : ∀ m, wstar m ∈ WP model
  wstar_measurable : Measurable wstar
  G : model.M → Set model.M
  B : model.M → Set (Belief model.Ω)
  G_nonempty : ∀ s, (G s).Nonempty
  G_compact : ∀ s, IsCompact (G s)
  G_closedGraph : IsClosed {p : model.M × model.M | p.2 ∈ G p.1}
  B_closed : ∀ m, IsClosed (B m)
  B_convex : ∀ m, Convex ℝ (B m)
  B_support_continuous : ∀ y : Profile model,
    Continuous fun m => supportFunction (B m) y
  Psi : BoundedBorelProfile model → ℝ

Reg-1 and Reg-2 are not automatic from standing Robust Trust assumptions; v9 records that compactness of M does not force continuity of w*, closed graph of G, or support-continuity of Bayes cones. 

v9_consolidated

Q5. FBNF foliation

Use a structure carrying a standard-Borel chart, an affine embedding, and either injectivity on a full-measure set or quotient-consistency on overlaps:

lean
structure Foliation (model : RobustTrustModel) where
  Z : Type
  measurableZ : MeasurableSpace Z
  standardBorelZ : Prop
  a b : Z → ℝ
  intervalNonempty : ∀ z, a z ≤ b z
  ell : (z : Z) → {t : ℝ // a z ≤ t ∧ t ≤ b z} → Belief model.Ω
  ell_affine : Prop
  chartMeasurable : Prop
  tauBase : Measure Z
  tauFiber : Z → Measure ℝ
  disintegration : Prop
  pushforward_tau : Prop
  quotientConsistent : Prop

The foliation package must say “Borel chart or quotient-consistency,” not merely “cover by fibers.” FBNF also uses endpoint-fiber support rather than singleton endpoint messages, and local two-sided perturbability is needed to derive FBNF-6 as equality rather than a one-sided KKT inequality. 

v9_consolidated

Q6. Clarke subdifferential in Lean

Treat Clarke subdifferentials as Inventory black boxes. Mathlib has differentiability, convexity, local extrema, and finite-dimensional calculus, but not the Clarke subdifferential calculus needed here. Declare Inventory.clarke_danskin_stationarity and Inventory.clarke_fermat_normal_cone, and consume them in T1/L6/L7.

Q7. Reuse from v8

Import RobustTrustV8 wholesale. Reused declarations:

lean
open RobustTrustV8

-- model primitives
RobustTrustModel
Belief
Profile
PayoffProfileSet
AgentStrategyM
AdviserKernel
PosteriorDisintegration

-- menu/contact objects
MenuHall
ExactContact
EpsilonContactGeps
Tier1aResult
Tier1bResult
Tier2Result

-- selectors and external inventory
Inventory.measurable_argmax_selector
Inventory.krn_borel_right_inverse
Inventory.kernel_infimum_epsilon_selection
Inventory.UniversallyMeasurable
Inventory.GepsRegularity

-- WTA machinery
WTATernaryAlgebra
WTA_vertex
WTASupport

The formalization state explicitly says v9 lives in RobustTrustV9 on top of v8. 

lean_state

Q8. Inventory naming convention

Keep all new axioms in the existing Inventory namespace, not a new Inventory.V9 sub-namespace. The v8 convention already uses Inventory.measurable_argmax_selector, and downstream theorem statements should consume Inventory.clarke_danskin_stationarity, Inventory.strassen_marginals, etc. The ledger slugs can be Inventory-clarke-danskin-stationarity, while the Lean names stay lowercase snake-case.

Lean names with hyphenated slugs must be escaped:

lean
theorem «binary-L_B5-endpoint-stationarity-total-balance» ... := by
  sorry
§1 New Inventory axioms

Add these to support/INVENTORY.lean. The axioms are external mathematical hammers, not theorem-specific shortcuts.

lean
namespace Inventory

/-- Abstract Clarke subdifferential placeholder. -/
constant ClarkeSubdiff
  {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] :
  (E → ℝ) → E → Set E

/-- Abstract Clarke normal cone placeholder. -/
constant ClarkeNormalCone
  {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] :
  Set E → E → Set E

structure ClarkeDanskinHyp
  {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
  (F : E → ℝ) (x : E) (Candidates : Set E) : Prop where
  locallyLipschitz : Prop
  compactActiveSet : Prop
  danskinRepresentation : Prop

axiom clarke_danskin_stationarity
  {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
  (F : E → ℝ) (x : E) (Candidates : Set E)
  (h : ClarkeDanskinHyp F x Candidates) :
  ∃ ξ ∈ Candidates, ξ ∈ ClarkeSubdiff F x

axiom clarke_fermat_normal_cone
  {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
  (F : E → ℝ) (C : Set E) (x : E)
  (hx : x ∈ C)
  (hLocalMax : Prop)
  (ξ : E)
  (hξ : ξ ∈ ClarkeSubdiff F x) :
  -ξ ∈ ClarkeNormalCone C x

structure StrassenMarginalDominance
  {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
  (μ : Measure α) (ν : Measure β) (R : Set (α × β)) : Prop where
  dualInequality : Prop

axiom strassen_marginals
  {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
  (μ : Measure α) (ν : Measure β) (R : Set (α × β))
  (h : StrassenMarginalDominance μ ν R) :
  ∃ π : Measure (α × β),
    (Measure.map Prod.fst π = μ) ∧
    (Measure.map Prod.snd π = ν) ∧
    π Rᶜ = 0

structure ConicFarkasInstance : Type where
  primalFeasible : Prop
  dualNonpositive : Prop

axiom farkas_lp_duality_conic
  (inst : ConicFarkasInstance) :
  inst.primalFeasible ↔ inst.dualNonpositive

/-- Audit before use: Mathlib may cover pieces of Berge maximum theorem. -/
structure BergeMaximumHyp
  {X Y : Type*} [TopologicalSpace X] [TopologicalSpace Y]
  (F : X → Set Y) (f : X → Y → ℝ) : Prop where
  compactValues : Prop
  closedGraph : Prop
  continuousObjective : Prop

axiom berge_maximum_set_valued
  {X Y : Type*} [TopologicalSpace X] [TopologicalSpace Y]
  (F : X → Set Y) (f : X → Y → ℝ)
  (h : BergeMaximumHyp F f) :
  Prop

axiom hausdorff_alexandroff_continuous_surjection
  {K : Type*} [TopologicalSpace K] [CompactSpace K] [T2Space K]
  [SecondCountableTopology K] :
  ∃ f : CantorSpace → K, Continuous f ∧ Function.Surjective f

end Inventory

Inventory citations and use:

Axiom	Use	Citation
clarke_danskin_stationarity	T1 L6 and finite-menu stationarity	Clarke 1990; Danskin/Clarke envelope theorem
clarke_fermat_normal_cone	T1 L7, binary/FBNF stationarity	Clarke 1990, Fermat rule for Lipschitz functions
strassen_marginals	Borel Hall G2c, B1 transport, tie splitting	Strassen 1965; Kantorovich-Rubinstein duality
farkas_lp_duality_conic	G1 finite cone-Hall, G4 LP	Farkas lemma / strong conic LP duality
berge_maximum_set_valued	measurable/closed argmin correspondences if Mathlib cannot cover	Aliprantis-Border, Berge maximum theorem
hausdorff_alexandroff_continuous_surjection	Cantor canvas / atomless construction, if not already lifted from v8	Kechris 1995; Hausdorff-Alexandroff theorem

Reused v8 Inventory axioms:

lean
Inventory.measurable_argmax_selector
Inventory.krn_borel_right_inverse
Inventory.kernel_infimum_epsilon_selection

These are used for KRN selection, Borel right inverses for payoff-profile realization, and epsilon kernel selections.

§2 RobustTrustV9 namespace: new primitives

Add this before theorem statements in main.lean.

lean
import Mathlib
import RobustTrust.v8_main
import RobustTrust.support.INVENTORY

open MeasureTheory
open scoped BigOperators

namespace RobustTrustV9
open RobustTrustV8

noncomputable section

variable (model : RobustTrustModel)

def WeakParetoProfile (w : Profile model) : Prop :=
  w ∈ PayoffProfileSet model ∧
    ¬ ∃ v : Profile model,
      v ∈ PayoffProfileSet model ∧
      (∀ ω : model.Ω, w ω < v ω)

def WP : Set (Profile model) :=
  { w | WeakParetoProfile model w }

abbrev WPProfile : Type :=
  { w : Profile model // w ∈ WP model }

abbrev KCompactWP : Type :=
  TopologicalSpace.NonemptyCompacts (WPProfile model)

def BayesConeW (w : Profile model) : Set (Belief model.Ω) :=
  { μ | w ∈ PayoffProfileSet model ∧
      ∀ v : Profile model,
        v ∈ PayoffProfileSet model →
          beliefDot μ v ≤ beliefDot μ w }

def NormalConeW (w n : Profile model) : Prop :=
  w ∈ PayoffProfileSet model ∧
    ∀ v : Profile model,
      v ∈ PayoffProfileSet model →
        (∑ ω : model.Ω, n ω * (v ω - w ω)) ≤ 0

noncomputable def supportFunction
    (B : Set (Belief model.Ω)) (y : Profile model) : ℝ :=
  sSup ((fun μ : Belief model.Ω => beliefDot μ y) '' B)

structure BoundedBorelProfile where
  toFun : model.M → Profile model
  measurable_toFun : Measurable toFun
  bounded_coord : ∃ C : ℝ, 0 ≤ C ∧ ∀ m ω, |toFun m ω| ≤ C

def RobustRationalizableQAE
    (pd : PosteriorDisintegration model)
    (β : AdviserKernel model)
    (σ : AgentStrategyM model) : Prop :=
  Definition2QAEPredicate model pd β σ

def HasRobustRationalizableStrategy
    (pd : PosteriorDisintegration model) : Prop :=
  ∃ β : AdviserKernel model, ∃ σ : AgentStrategyM model,
    RobustRationalizableQAE model pd β σ

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

structure AlphaZeroSingletonData where
  priorStrategy : AgentStrategyM model
  constantAdversary : AdviserKernel model
  priorOptimal : Prop
  posteriorAtConstantMessageIsPrior : Prop
  robustRationalizable : Prop

structure BinaryCapstoneData where
  pd : PosteriorDisintegration model
  binaryStates : Fintype.card model.Ω = 2
  alpha_pos : 0 < model.α
  alpha_lt_one : model.α < 1
  L R : Belief model.Ω
  endpointExposure : Prop
  tieDiscipline : Prop
  interiorEndpointStationarity : Prop
  endpointFiberLift : Prop
  trsIntervalReduction : Prop
  endpointOnlyImage : Prop
  interiorMessageCalibration : Prop
  endpointStationarityTotalBalance : Prop
  capstoneConclusion : HasRobustRationalizableStrategy model pd

structure Foliation where
  Z : Type
  measurableZ : MeasurableSpace Z
  standardBorelZ : Prop
  a b : Z → ℝ
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
  fiberPreservingTRS : Prop
  endpointSupportedFiberImage : Prop
  fiberEndpointExposure : Prop
  fiberTieDiscipline : Prop
  localTwoSidedPerturbability : Prop
  globalFiberDominance : Prop
  conditionalB1Pasting : Prop
  localizedStationarityFBNF6 : Prop
  capstoneConclusion : HasRobustRationalizableStrategy model pd

structure RegPackage where
  pd : PosteriorDisintegration model
  wstar : model.M → Profile model
  wstar_inWP : ∀ m, wstar m ∈ WP model
  wstar_measurable : Measurable wstar
  G : model.M → Set model.M
  B : model.M → Set (Belief model.Ω)
  G_nonempty : ∀ s, (G s).Nonempty
  G_compact : ∀ s, IsCompact (G s)
  G_closedGraph : IsClosed {p : model.M × model.M | p.2 ∈ G p.1}
  B_closed : ∀ m, IsClosed (B m)
  B_convex : ∀ m, Convex ℝ (B m)
  B_support_continuous :
    ∀ y : Profile model, Continuous fun m => supportFunction model (B m) y
  Psi : BoundedBorelProfile model → ℝ
  calibratedKernelExists : Prop
  robustRationalizableLabeling : Prop

def PsiNonpos (reg : RegPackage model) : Prop :=
  ∀ y : BoundedBorelProfile model, reg.Psi y ≤ 0

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
  capstoneConclusion : HasRobustRationalizableStrategy model pd

end
end RobustTrustV9

The Prop fields are intentional scaffolding. Per-lemma prover sessions should expand each field into concrete formulas, then replace the field-level theorem with the expanded theorem once that block is stable.

§3 Theorem T1 + sub-lemmas L6/L7/L8
T1-L6-integral-clarke-danskin-representation

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «T1-L6-integral-clarke-danskin-representation»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (hLocal : data.localMax)
    (hPareto : data.paretoCompleted) :
    data.clarkeDanskinRepresentation := by
  -- consumes Inventory.clarke_danskin_stationarity
  sorry

end RobustTrustV9

Depends on: Inventory.clarke_danskin_stationarity.

Inventory citations: Clarke 1990, Danskin theorem / Clarke subdifferential calculus for maxima/minima under integral signs.

Source anchor: v9_consolidated.md §B.1, exposition_v9.tex §3.

Proof outline:

Treat the finite-menu functional Fk as a locally Lipschitz function on (Fin k → Profile model).

Use measurable active-label correspondences for max and min labels.

Apply Clarke-Danskin to obtain λ⁺, λ⁻ supported on active max/min labels.

Integrate active gradients to obtain g_i and scalar masses q_i.

Tie patch: use inclusion of active correspondences, not equality on tie sets.

Difficulty: LARGE.

T1-L7-clarke-fermat-stationarity

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «T1-L7-clarke-fermat-stationarity»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (h6 : data.clarkeDanskinRepresentation)
    (hLocal : data.localMax)
    (hPareto : data.paretoCompleted) :
    data.clarkeFermatStationarity := by
  -- consumes Inventory.clarke_fermat_normal_cone
  sorry

end RobustTrustV9

Depends on: T1-L6-integral-clarke-danskin-representation; Inventory.clarke_fermat_normal_cone.

Inventory citations: Clarke 1990, Fermat rule for locally Lipschitz functions constrained to a closed set.

Source anchor: v9_consolidated.md §B.1, exposition_v9.tex §3.

Proof outline:

Use L6 to identify a Clarke subgradient of the finite-menu value.

Apply Clarke-Fermat at a Pareto-completed local maximizer.

Translate the normal-cone condition into one normal-cone inequality per active label.

Isolate the labelwise vector g_i.

Preserve inactive labels with q_i = 0 as vacuous branches.

Difficulty: MEDIUM.

T1-L8-multipliers-are-calibration-kernel

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «T1-L8-multipliers-are-calibration-kernel»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (h6 : data.clarkeDanskinRepresentation)
    (h7 : data.clarkeFermatStationarity) :
    data.multipliersAreCalibrationKernel := by
  sorry

end RobustTrustV9

Depends on: T1-L6-integral-clarke-danskin-representation, T1-L7-clarke-fermat-stationarity.

Inventory axioms: none beyond dependencies.

Source anchor: v9_consolidated.md §B.1, exposition_v9.tex §3.

Proof outline:

Define the vector numerator g_i and mass q_i from the Clarke multipliers.

Prove 0 ≤ q_i; handle q_i = 0 separately.

For q_i > 0, show p_i := g_i / q_i is a belief by coordinate nonnegativity and total mass one.

Use the normal-cone inequality from L7 to show w_i maximizes p_i · w over W.

Conclude p_i ∈ B_W(w_i).

Difficulty: MEDIUM.

T1-clarke-danskin-multiplier-bayes-cone

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «T1-clarke-danskin-multiplier-bayes-cone»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (h6 : data.clarkeDanskinRepresentation)
    (h7 : data.clarkeFermatStationarity)
    (h8 : data.multipliersAreCalibrationKernel) :
    data.multiplierBayesCone := by
  sorry

end RobustTrustV9

Depends on: T1-L6-integral-clarke-danskin-representation, T1-L7-clarke-fermat-stationarity, T1-L8-multipliers-are-calibration-kernel.

Inventory axioms: inherited Inventory.clarke_danskin_stationarity, Inventory.clarke_fermat_normal_cone.

Source anchor: v9_consolidated.md §B.1, exposition_v9.tex §3.

Proof outline:

Invoke L8 for every label.

Unfold multiplierBayesCone.

For every active label i with q_i > 0, set p_i = g_i / q_i.

Conclude p_i ∈ BayesConeW model (w_i).

Inactive labels are discharged by the statement’s q_i = 0 guard.

Difficulty: SMALL.

§4 Theorem T2
T2-alpha-zero-singleton-prior-strategy

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «T2-alpha-zero-singleton-prior-strategy»
    {model : RobustTrustModel}
    (pd : PosteriorDisintegration model)
    (hα : model.α = 0)
    (data : AlphaZeroSingletonData model)
    (hPrior : data.priorOptimal)
    (hPost : data.posteriorAtConstantMessageIsPrior) :
    HasRobustRationalizableStrategy model pd := by
  -- expected witness: data.constantAdversary, data.priorStrategy
  sorry

end RobustTrustV9

Depends on: v8 Definition2QAEPredicate; Inventory.measurable_argmax_selector for the prior-optimal private strategy if constructed inside Lean.

Inventory axioms: reused Inventory.measurable_argmax_selector.

Source anchor: v9_consolidated.md §B.2, exposition_v9.tex §4.

Proof outline:

Use α = 0 to remove the aligned term from the robust objective.

Choose a private strategy Bayes-optimal at the prior μ0.

Define the full agent strategy to ignore the message and play that private strategy.

Let the adversary send one constant on-path message.

The posterior at that message is the barycenter prior μ0.

The constant strategy is q-a.e. Bayes-optimal, hence robustly rationalizable.

Difficulty: MEDIUM.

§5 Binary capstone L_B1 ... L_B6

The binary package uses endpoint fibers, not singleton endpoint messages. The binary assumptions and endpoint-balance equations are stated in v9_consolidated.md §B.3; this is a full infinite-M, Θ theorem in the binary-state subclass, conditional on endpoint exposure, tie discipline, and interior endpoint stationarity. 

v9_consolidated

binary-L_B1-endpoint-fiber-lift

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «binary-L_B1-endpoint-fiber-lift»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (hBalance : data.endpointStationarityTotalBalance) :
    data.endpointFiberLift := by
  -- consumes Inventory.strassen_marginals or equivalent coupling theorem
  sorry

end RobustTrustV9

Depends on: none inside v9.

Inventory axioms: Inventory.strassen_marginals.

Inventory citation: Strassen 1965; Aliprantis-Border coupling/disintegration theorem.

Source anchor: v9_consolidated.md §B.3, exposition_v9.tex §8.

Proof outline:

Convert scalar endpoint balance into equality of two finite measures.

Use Strassen/coupling to transport misaligned source surplus to aligned endpoint-fiber deficit.

Disintegrate the coupling into kernels κ_L, κ_R.

Show no unrelated traffic enters the calibrated endpoint fibers.

Compute the posterior on each endpoint fiber via the vector numerator and scalar message marginal.

Conclude posterior equals L on the left fiber and R on the right fiber q-a.e.

Difficulty: LARGE.

binary-L_B2-TRS-interval-reduction

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «binary-L_B2-TRS-interval-reduction»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model) :
    data.trsIntervalReduction := by
  -- import/cite paper Theorem 1 route through v8 TRS primitives
  sorry

end RobustTrustV9

Depends on: v8 Trust Region / ExactContact machinery; paper Theorem 1 imported as a stated dependency, not reproved.

Inventory axioms: reused Inventory.measurable_argmax_selector, if constructing selectors.

Source anchor: v9_consolidated.md §B.3, exposition_v9.tex §8.

Proof outline:

Use binary state space to identify beliefs with an interval.

Apply paper Theorem 1 / v8 TRS representation to reduce optimal policies to trust regions.

Use connectedness to identify the trust region as [L,R].

Package the induced clipped continuation map.

Record endpoint labels and interior labels.

Difficulty: MEDIUM.

binary-L_B3-endpoint-only-image

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «binary-L_B3-endpoint-only-image»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (hTRS : data.trsIntervalReduction) :
    data.endpointOnlyImage := by
  sorry

end RobustTrustV9

Depends on: binary-L_B2-TRS-interval-reduction.

Inventory axioms: none.

Source anchor: v9_consolidated.md §B.3, exposition_v9.tex §8.

Proof outline:

Work with the convex indirect value along the binary interval.

Show any interior supporting payoff is dominated, for adversarial minimization, by one of the two endpoint supporting payoffs.

Use endpoint tie discipline to avoid positive-mass ambiguous routing.

Conclude the projected adversarial payoff image lies in {w_L, w_R}.

Keep the literal message support as endpoint fibers.

Difficulty: MEDIUM.

binary-L_B4-interior-message-calibration

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «binary-L_B4-interior-message-calibration»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (hTRS : data.trsIntervalReduction)
    (hEndpoint : data.endpointOnlyImage) :
    data.interiorMessageCalibration := by
  sorry

end RobustTrustV9

Depends on: binary-L_B2-TRS-interval-reduction, binary-L_B3-endpoint-only-image.

Inventory axioms: none.

Source anchor: v9_consolidated.md §B.3, exposition_v9.tex §8.

Proof outline:

Interior messages are trusted by the TRS and not used by the misaligned endpoint-only image.

The only on-path interior mass is aligned truthful mass.

Compute the posterior numerator and denominator on interior Borel sets.

Conclude posterior equals the message q-a.e. on (L,R) ∩ M.

Use Bayes optimality of the TRS interior continuation.

Difficulty: SMALL.

binary-L_B5-endpoint-stationarity-total-balance

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «binary-L_B5-endpoint-stationarity-total-balance»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (hT1 : ∀ k (fd : FiniteMenuData model k),
      fd.multiplierBayesCone)
    (hTRS : data.trsIntervalReduction)
    (hEndpoint : data.endpointOnlyImage)
    (hIES : data.interiorEndpointStationarity) :
    data.endpointStationarityTotalBalance := by
  sorry

end RobustTrustV9

Depends on: T1-clarke-danskin-multiplier-bayes-cone, binary-L_B2-TRS-interval-reduction, binary-L_B3-endpoint-only-image.

Inventory axioms: inherited Inventory.clarke_danskin_stationarity, Inventory.clarke_fermat_normal_cone.

Source anchor: v9_consolidated.md §B.3, exposition_v9.tex §8.

Proof outline:

Restrict endpoint perturbations to the two active endpoint labels.

Apply T1/L6-L8 to the two-label active menu.

Use interior endpoint stationarity to get equality rather than one-sided KKT inequalities.

Translate multiplier Bayes-cone calibration into left and right scalar moment equations.

Identify those equations with total endpoint-fiber balance.

Difficulty: LARGE.

binary-L_B6-capstone

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «binary-L_B6-capstone»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (hB1 : data.endpointFiberLift)
    (hB2 : data.trsIntervalReduction)
    (hB3 : data.endpointOnlyImage)
    (hB4 : data.interiorMessageCalibration)
    (hB5 : data.endpointStationarityTotalBalance) :
    data.capstoneConclusion := by
  sorry

end RobustTrustV9

Depends on: binary-L_B1-endpoint-fiber-lift, binary-L_B2-TRS-interval-reduction, binary-L_B3-endpoint-only-image, binary-L_B4-interior-message-calibration, binary-L_B5-endpoint-stationarity-total-balance.

Inventory axioms: inherited Inventory.strassen_marginals, Inventory.measurable_argmax_selector.

Source anchor: v9_consolidated.md §B.3, exposition_v9.tex §8.

Proof outline:

Build the adversarial kernel by combining left-fiber, right-fiber, and interior clauses.

Use B3 to verify rowwise adversariality.

Use B1 for endpoint-fiber posterior calibration.

Use B4 for interior posterior calibration.

Apply endpoint exposure and interior Bayes optimality.

Conclude Definition 2 q-a.e. robust rationalizability.

Difficulty: LARGE.

§6 FBNF F1 ... F4 + 3 corollaries

FBNF reduces multidimensional calibration to scalar endpoint-fiber transports on affine one-dimensional fibers. The capstone requires global fiber dominance, endpoint-fiber support, local two-sided perturbability, and a Borel chart or quotient consistency; endpoint singleton wording is wrong for the literal kernel. 

v9_consolidated

FBNF-F1-conditional-B1-measurable-pasting

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «FBNF-F1-conditional-B1-measurable-pasting»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (hB1 : ∀ data : BinaryCapstoneData model,
      data.endpointStationarityTotalBalance → data.endpointFiberLift) :
    pkg.conditionalB1Pasting := by
  sorry

end RobustTrustV9

Depends on: binary-L_B1-endpoint-fiber-lift.

Inventory axioms: Inventory.strassen_marginals; reused KRN/disintegration selectors.

Source anchor: v9_consolidated.md §B.4, exposition_v9.tex §9.

Proof outline:

Disintegrate τ along FBNF fibers using the Borel chart.

Apply binary B1 conditionally on almost every fiber.

Use quotient consistency to avoid multivalued message prescriptions on overlaps.

Paste the fiberwise kernels into a global Borel kernel.

Verify endpoint-fiber posterior identities q-a.e.

Difficulty: HUGE.

FBNF-F2-endpoint-only-fiber-image

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «FBNF-F2-endpoint-only-fiber-image»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (hTRS : pkg.fiberPreservingTRS) :
    pkg.endpointSupportedFiberImage := by
  sorry

end RobustTrustV9

Depends on: FBNF primitive fiberPreservingTRS.

Inventory axioms: none.

Source anchor: v9_consolidated.md §B.4, exposition_v9.tex §9.

Proof outline:

Restrict the support-function problem to a single affine fiber.

Pull back payoffs along ℓ_z to a convex one-dimensional value.

Use subgradient monotonicity along the fiber.

Show a measurable endpoint-supported minimizer exists.

Avoid the stronger false claim that the entire argmin set is contained in endpoints unless strict no-interior-flatness is added.

Difficulty: LARGE.

FBNF-F3-localized-stationarity-FBNF6

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «FBNF-F3-localized-stationarity-FBNF6»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (hT1 : ∀ k (fd : FiniteMenuData model k),
      fd.multiplierBayesCone)
    (hF2 : pkg.endpointSupportedFiberImage)
    (hPert : pkg.localTwoSidedPerturbability) :
    pkg.localizedStationarityFBNF6 := by
  sorry

end RobustTrustV9

Depends on: T1-clarke-danskin-multiplier-bayes-cone, FBNF-F2-endpoint-only-fiber-image.

Inventory axioms: inherited Clarke-Danskin and Clarke-Fermat.

Source anchor: v9_consolidated.md §B.4, exposition_v9.tex §9.

Proof outline:

Localize endpoint perturbations on Borel patches of the fiber base.

Apply T1 to the locally finite active endpoint menu.

Use two-sided perturbability to derive equality of first variations.

Convert equality into fiberwise scalar total-balance equations.

Use patch testing to upgrade integrated identities to λ-a.e. fiber identities.

If two-sided perturbability fails, only one-sided inequalities follow; this theorem explicitly assumes the two-sided condition.

Difficulty: HUGE.

FBNF-F4-capstone

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «FBNF-F4-capstone»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (hF1 : pkg.conditionalB1Pasting)
    (hF2 : pkg.endpointSupportedFiberImage)
    (hF3 : pkg.localizedStationarityFBNF6)
    (hDom : pkg.globalFiberDominance) :
    pkg.capstoneConclusion := by
  sorry

end RobustTrustV9

Depends on: FBNF-F1-conditional-B1-measurable-pasting, FBNF-F2-endpoint-only-fiber-image, FBNF-F3-localized-stationarity-FBNF6.

Inventory axioms: inherited Inventory.strassen_marginals, KRN selectors.

Source anchor: v9_consolidated.md §B.4, exposition_v9.tex §9.

Proof outline:

Use F1 to produce a global Borel adversarial kernel.

Use F2 and global fiber dominance to prove rowwise minimizers are true global minimizers.

Use F3 to supply the balance equations needed by F1.

Verify q-a.e. posterior calibration on left endpoint fibers, right endpoint fibers, and interiors.

Apply fiberwise endpoint exposure and interior Bayes optimality.

Conclude robust rationalizability.

Difficulty: HUGE.

FBNF-corollary-spherical-radial

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «FBNF-corollary-spherical-radial»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (radial : P4Hyp model)
    (hF4 : pkg.capstoneConclusion) :
    HasRobustRationalizableStrategy model pkg.pd := by
  exact hF4

end RobustTrustV9

Depends on: FBNF-F4-capstone, P4-radial-antipodal-tau-symmetry.

Inventory axioms: inherited from dependencies.

Source anchor: v9_consolidated.md §B.4, exposition_v9.tex §9.

Proof outline:

Use radial symmetry to identify affine radial fibers.

Show antipodal routing is endpoint-supported.

Verify scalar radial balance.

Instantiate FBNF hypotheses.

Apply F4.

Difficulty: MEDIUM.

FBNF-corollary-affine-MLR-single-crossing

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «FBNF-corollary-affine-MLR-single-crossing»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (affineMLR : Prop)
    (singleCrossing : Prop)
    (hMLR_implies_FBNF : affineMLR → singleCrossing → pkg.capstoneConclusion)
    (h1 : affineMLR) (h2 : singleCrossing) :
    HasRobustRationalizableStrategy model pkg.pd := by
  exact hMLR_implies_FBNF h1 h2

end RobustTrustV9

Depends on: FBNF-F4-capstone.

Inventory axioms: inherited from dependencies.

Source anchor: v9_consolidated.md §B.4, exposition_v9.tex §9.

Proof outline:

Encode affine MLR paths as one-dimensional affine fibers.

Use single crossing for endpoint exposure and endpoint-supported minimization.

Verify global fiber dominance from monotone likelihood-ratio order.

Instantiate FBNF package.

Apply F4.

Difficulty: LARGE.

FBNF-corollary-polyhedral-scalarizable

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «FBNF-corollary-polyhedral-scalarizable»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model)
    (polyScalar : Prop)
    (hPolyScalar : polyScalar → pkg.capstoneConclusion)
    (h : polyScalar) :
    HasRobustRationalizableStrategy model pkg.pd := by
  exact hPolyScalar h

end RobustTrustV9

Depends on: FBNF-F4-capstone; optionally G4-finite-facet-polyhedral-LP-threshold.

Inventory axioms: inherited from dependencies.

Source anchor: v9_consolidated.md §B.4, exposition_v9.tex §9.

Proof outline:

Decompose active polyhedral faces into scalarizable affine fibers.

Verify endpoint exposure on each scalarized face.

Use finite-facet LP or FBNF balance to check calibration.

Instantiate the FBNF package.

Apply F4.

Difficulty: LARGE.

§7 Hall biconditional G1, G2c, Hall, WTA Psi=2/9, WTA threshold D

The Hall block is the v9 classification engine: finite cone-Hall via Farkas, Borel extension via compact-closed/no-escape regularity, and the fixed-label Robust Trust biconditional RR ↔ Ψ ≤ 0. The sign is Ψ(y) ≤ 0. 

v9_consolidated

Hall-G1-finite-cone-hall-farkas-LP

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «Hall-G1-finite-cone-hall-farkas-LP»
    (inst : FiniteConeHallInstance) :
    inst.flowFeasible ↔ inst.psiNonpos := by
  -- consumes Inventory.farkas_lp_duality_conic
  sorry

end RobustTrustV9

Depends on: none inside v9.

Inventory axioms: Inventory.farkas_lp_duality_conic.

Inventory citation: Farkas lemma / finite-dimensional conic LP strong duality.

Source anchor: v9_consolidated.md §B.5, exposition_v9.tex §11.

Proof outline:

Encode calibrated finite flows as a finite-dimensional conic primal.

Encode cone constraints using support functions of Bayes cones.

Derive the dual inequality with sign convention Ψ ≤ 0.

Apply conic Farkas/strong LP duality.

Prove both directions by primal-dual equivalence.

Difficulty: LARGE.

Hall-G2c-borel-extension

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «Hall-G2c-borel-extension»
    {model : RobustTrustModel}
    (reg : RegPackage model)
    (hPsi : PsiNonpos model reg) :
    reg.calibratedKernelExists := by
  -- consumes Inventory.strassen_marginals and measurable-selection inventory
  sorry

end RobustTrustV9

Depends on: Hall-G1-finite-cone-hall-farkas-LP.

Inventory axioms: Inventory.strassen_marginals, reused Inventory.measurable_argmax_selector.

Inventory citation: Strassen 1965; Castaing-Valadier measurable multifunction selection; Aliprantis-Border measurable selection/disintegration.

Source anchor: v9_consolidated.md §B.5, exposition_v9.tex §11.

Proof outline:

Work directly with measures on the graph of G, not compact-patch deletion.

Use compactness, closed graph, and support-function continuity for no escape.

Use conic separation to pass from failure of kernel existence to a bounded Borel dual price.

Contradict Ψ ≤ 0.

Disintegrate the graph-supported measure into a Borel kernel.

Verify posterior Bayes-cone calibration q-a.e.

Difficulty: HUGE.

Hall-biconditional

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «Hall-biconditional»
    {model : RobustTrustModel}
    (reg : RegPackage model) :
    reg.robustRationalizableLabeling ↔ PsiNonpos model reg := by
  sorry

end RobustTrustV9

Depends on: Hall-G2c-borel-extension; reverse direction also uses the definition of Psi.

Inventory axioms: inherited Inventory.strassen_marginals, measurable-selection inventory.

Source anchor: v9_consolidated.md §B.5, exposition_v9.tex §11.

Proof outline:

Forward direction: a calibrated adversarial kernel gives feasible primal graph measure.

Use support-function inequality for each Bayes cone to show every bounded Borel dual price has Ψ ≤ 0.

Reverse direction: apply G2c to obtain a calibrated kernel supported on rowwise minimizers.

Rowwise support gives adversariality.

Bayes-cone posterior calibration gives Definition 2 q-a.e.

Conclude fixed-label robust rationalizability iff ΨNonpos.

Difficulty: HUGE.

Hall-WTA-dual-certificate-psi-two-ninths

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «Hall-WTA-dual-certificate-psi-two-ninths»
    (wta : WTAData)
    (hCert : wta.certificatePositive) :
    wta.psiValue = (2 : ℝ) / 9 := by
  sorry

end RobustTrustV9

Depends on: Hall-G1-finite-cone-hall-farkas-LP; v8 WTA algebra.

Inventory axioms: none.

Source anchor: v9_consolidated.md §B.5, exposition_v9.tex §11.

Proof outline:

Instantiate the WTA ternary vertex menu and Bayes cones.

Use dual price y_j = 1 - 2 e_j.

Compute support values h_{B_j}(y_j).

Compute aligned and misaligned contributions under uniform ternary geometry.

Show Ψ(y) = 2/9 > 0, hence Hall fails.

Difficulty: MEDIUM.

Hall-WTA-reopening-threshold-D

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «Hall-WTA-reopening-threshold-D»
    (α D : ℝ)
    (hαpos : 0 < α) :
    ((-2 * α * D + (1 - α) * ((4 : ℝ) / 9) ≤ 0)
      ↔
     ((2 * (1 - α)) / (9 * α) ≤ D)) := by
  nlinarith [hαpos]

end RobustTrustV9

Depends on: Hall-WTA-dual-certificate-psi-two-ninths.

Inventory axioms: none.

Source anchor: v9_consolidated.md §B.5, exposition_v9.tex §11.

Proof outline:

Start from the user-locked WTA reopening condition.

Rearrange the scalar inequality using α > 0.

Use nlinarith after clearing positive denominators.

Pair with the WTA certificate to interpret the threshold.

Difficulty: SMALL.

§8 G4 finite-facet polyhedral LP threshold
G4-finite-facet-polyhedral-LP-threshold

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «G4-finite-facet-polyhedral-LP-threshold»
    (inst : PolyhedralLPInstance) :
    inst.psiNonpos ↔ inst.lpFeasible := by
  -- finite-facet reduction + Inventory.farkas_lp_duality_conic
  sorry

end RobustTrustV9

Depends on: Hall-G1-finite-cone-hall-farkas-LP.

Inventory axioms: Inventory.farkas_lp_duality_conic.

Inventory citation: finite-dimensional Farkas lemma / conic LP duality.

Source anchor: v9_consolidated.md §B.5.G4, exposition_v9.tex §13.

Proof outline:

Represent each Bayes cone by finitely many facet inequalities.

Replace support-function inequalities by finitely many extreme dual directions.

Encode aligned and rowwise-minimizer cells as finite masses and means.

Show Ψ ≤ 0 iff every finite-facet inequality is feasible.

Package the inequalities as the explicit LP.

Use finite cone-Hall/Farkas for equivalence.

Difficulty: LARGE.

§9 Primitive sufficient classes P2*, P3, P4
P2-star-cone-margin-bounded-jamming

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «P2-star-cone-margin-bounded-jamming»
    {model : RobustTrustModel}
    (hyp : P2StarHyp model)
    (hMargin : hyp.coneMargin)
    (hJam : hyp.boundedJamming)
    (hBase : hyp.enoughAlignedBaseline) :
    HasRobustRationalizableStrategy model hyp.reg.pd := by
  have hPsi : PsiNonpos model hyp.reg := by
    -- prove by cone-margin displacement estimate
    sorry
  have hHall := ( «Hall-biconditional» hyp.reg ).mpr hPsi
  -- unfold robustRationalizableLabeling into strategy existence
  sorry

end RobustTrustV9

Depends on: Hall-biconditional.

Inventory axioms: inherited from Hall.

Source anchor: v9_consolidated.md §B.7, exposition_v9.tex §12.

Proof outline:

Use uniform cone margin to get a ball around each truthful message inside its Bayes cone.

Bound adversarial posterior displacement by the jamming-density cap.

Use sufficient aligned baseline mass to keep the posterior inside the Bayes cone.

Deduce Ψ ≤ 0 through the Hall biconditional’s primal feasibility.

Apply Hall-biconditional.

Difficulty: LARGE.

P3-polyhedral-cone-margin

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «P3-polyhedral-cone-margin»
    {model : RobustTrustModel}
    (hyp : P3Hyp model)
    (hPoly : hyp.polyhedralW)
    (hFinite : hyp.finiteVertexMenu)
    (hMargin : hyp.positiveConeMargin)
    (hLP : hyp.finiteLPFeasible) :
    HasRobustRationalizableStrategy model hyp.reg.pd := by
  have hPsi : PsiNonpos model hyp.reg := by
    -- reduce to G4 LP
    sorry
  have hHall := ( «Hall-biconditional» hyp.reg ).mpr hPsi
  sorry

end RobustTrustV9

Depends on: G4-finite-facet-polyhedral-LP-threshold, Hall-biconditional.

Inventory axioms: inherited Inventory.farkas_lp_duality_conic.

Source anchor: v9_consolidated.md §B.7, exposition_v9.tex §12.

Proof outline:

Use polyhedrality to reduce Bayes cones to finite facet inequalities.

Use the finite active vertex menu to form the finite LP instance.

Use positive cone margin for robust facet feasibility.

Apply G4 to obtain ΨNonpos.

Apply the Hall biconditional.

Difficulty: LARGE.

P4-radial-antipodal-tau-symmetry

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «P4-radial-antipodal-tau-symmetry»
    {model : RobustTrustModel}
    (hyp : P4Hyp model)
    (hRadial : hyp.radialTau)
    (hEq : hyp.utilityEquivariant)
    (hKernel : hyp.antipodalKernelConstructed)
    (hBalance : hyp.scalarRadialBalance) :
    HasRobustRationalizableStrategy model hyp.reg.pd := by
  have hPsi : PsiNonpos model hyp.reg := by
    -- primal antipodal kernel is feasible; G2c/Hall gives Ψ≤0
    sorry
  have hHall := ( «Hall-biconditional» hyp.reg ).mpr hPsi
  sorry

end RobustTrustV9

Depends on: Hall-biconditional; optionally FBNF-F4-capstone.

Inventory axioms: inherited from Hall.

Source anchor: v9_consolidated.md §B.7, exposition_v9.tex §12.

Proof outline:

Use radial symmetry to identify the trust region as a ball centered at b.

Construct the adversary by routing beliefs to antipodal boundary points.

Verify scalar radial balance.

Show the constructed kernel is primal feasible and calibrated.

Deduce Ψ ≤ 0.

Apply Hall biconditional.

Difficulty: LARGE.

§10 Section G sharpenings
G-addendum-binary-tie-splitting

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «G-addendum-binary-tie-splitting»
    {model : RobustTrustModel}
    (hyp : BinaryTieSplittingHyp model)
    (hTie : hyp.tieAtom)
    (hSplit : hyp.measurableTieSplit) :
    hyp.data.endpointFiberLift := by
  -- patched B1 with atom split at endpoint indifference belief
  sorry

end RobustTrustV9

Depends on: binary-L_B1-endpoint-fiber-lift.

Inventory axioms: Inventory.strassen_marginals.

Source anchor: v9_consolidated.md §G, exposition_v9.tex §8 addendum.

Proof outline:

Split the atom at the endpoint indifference belief into left and right pieces.

Add the split pieces to the two scalar endpoint-balance equations.

Apply B1 to each side after splitting.

Paste the two kernels and the tie split.

Verify endpoint posterior calibration remains q-a.e.

Difficulty: MEDIUM.

G-addendum-variable-margin-P2-star-prime

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «G-addendum-variable-margin-P2-star-prime»
    {model : RobustTrustModel}
    (hyp : VariableMarginP2Hyp model)
    (hEta : ∀ᵐ m ∂model.τM, 0 < hyp.eta m)
    (hCap : hyp.localDensityCap)
    (hCone : hyp.variableConeMargin) :
    HasRobustRationalizableStrategy model hyp.reg.pd := by
  have hPsi : PsiNonpos model hyp.reg := by
    -- local displacement estimate with η(m)
    sorry
  exact ( «Hall-biconditional» hyp.reg ).mpr hPsi

end RobustTrustV9

Depends on: P2-star-cone-margin-bounded-jamming, Hall-biconditional.

Inventory axioms: inherited from Hall.

Source anchor: v9_consolidated.md §G, exposition_v9.tex §12 addendum.

Proof outline:

Replace uniform cone radius by Borel-positive η(m).

Use local adversarial target-density cap to bound posterior displacement pointwise.

Show displacement at m is at most η(m) q-a.e.

Conclude posterior remains in B(m) q-a.e.

Apply Hall biconditional.

Difficulty: LARGE.

Lean note: Use the corrected domination direction for adversarial target density: the proof needs the adversarial target marginal dominated by the truthful/aligned message law, i.e. dρ/dτ bounded locally, not dτ/dρ.

G-addendum-P6_G-finite-graph-FBNF

Statement (Lean):

lean
namespace RobustTrustV9
open RobustTrustV8

theorem «G-addendum-P6_G-finite-graph-FBNF»
    {model : RobustTrustModel}
    (pkg : GraphFBNFPackage model)
    (hGraph : pkg.finiteGraph)
    (hArcs : pkg.affineArcCharts)
    (hEdge : pkg.endpointFiberTransportOnEdges)
    (hKirchhoff : pkg.kirchhoffNodeBalance)
    (hDom : pkg.crossEdgeDominance) :
    pkg.capstoneConclusion := by
  sorry

end RobustTrustV9

Depends on: binary-L_B1-endpoint-fiber-lift, FBNF-F1-conditional-B1-measurable-pasting.

Inventory axioms: Inventory.strassen_marginals, reused measurable-selection axioms.

Source anchor: v9_consolidated.md §G, exposition_v9_paper.tex §G.

Proof outline:

Apply B1 on every affine graph edge to build endpoint-fiber transports.

Use Kirchhoff node balance to match deficits and surpluses at shared vertices.

Paste edgewise kernels through the finite Borel graph chart.

Use cross-edge dominance to ensure edgewise minimizers are global rowwise minimizers.

Verify q-a.e. posterior calibration on edges and nodes.

Conclude robust rationalizability.

Difficulty: HUGE.

The finite-graph sharpening is the patched P6_G class: finite affine arcs, endpoint-fiber transport on each edge, Kirchhoff node balance, and cross-edge dominance. 

prover_19_response

§11 Proving order recommendation

Topological sort for prover sessions:

Inventory-clarke-danskin-stationarity

Inventory-clarke-fermat-normal-cone

Inventory-strassen-marginals

Inventory-farkas-LP-duality-conic

§2 primitive declarations and compile-only scaffolding.

T1-L6-integral-clarke-danskin-representation

T1-L7-clarke-fermat-stationarity

T1-L8-multipliers-are-calibration-kernel

T1-clarke-danskin-multiplier-bayes-cone

T2-alpha-zero-singleton-prior-strategy

binary-L_B1-endpoint-fiber-lift

binary-L_B2-TRS-interval-reduction

binary-L_B3-endpoint-only-image

binary-L_B4-interior-message-calibration

binary-L_B5-endpoint-stationarity-total-balance

binary-L_B6-capstone

FBNF-F2-endpoint-only-fiber-image

FBNF-F3-localized-stationarity-FBNF6

FBNF-F1-conditional-B1-measurable-pasting

FBNF-F4-capstone

FBNF-corollary-spherical-radial

FBNF-corollary-affine-MLR-single-crossing

FBNF-corollary-polyhedral-scalarizable

Hall-G1-finite-cone-hall-farkas-LP

Hall-G2c-borel-extension

Hall-biconditional

Hall-WTA-dual-certificate-psi-two-ninths

Hall-WTA-reopening-threshold-D

G4-finite-facet-polyhedral-LP-threshold

P2-star-cone-margin-bounded-jamming

P3-polyhedral-cone-margin

P4-radial-antipodal-tau-symmetry

G-addendum-binary-tie-splitting

G-addendum-variable-margin-P2-star-prime

G-addendum-P6_G-finite-graph-FBNF

The high-level dependency graph in the source ledger is: standing primitives imply W, WP, and Bayes cones; finite menu implies L6/L7/L8/T1; binary uses interval reduction, endpoint-only image, stationarity, B1, and capstone; FBNF uses F2/F3/F1/F4; Hall uses G1/G2c/G3 and feeds P2*/P3/P4/G4. 

v9_consolidated

§12 Mathlib dep audit

Likely imports:

lean
import Mathlib.MeasureTheory.Measure.MeasureSpace
import Mathlib.MeasureTheory.Function.ConditionalExpectation
import Mathlib.MeasureTheory.Decomposition.RadonNikodym
import Mathlib.Topology.MetricSpace.HausdorffDistance
import Mathlib.Topology.MetricSpace.Closeds
import Mathlib.Analysis.Convex.Basic
import Mathlib.Analysis.Convex.Function
import Mathlib.Analysis.Convex.Body
import Mathlib.Analysis.Calculus.LocalExtr.Basic
import Mathlib.LinearAlgebra.Matrix
import Mathlib.Data.Matrix.Basic
import Mathlib.Topology.ContinuousMap.Bounded

Likely stable Mathlib components:

Need	Likely Mathlib object	Audit status
finite sums over states	Finset.sum, Fintype	stable
finite-dimensional profiles	functions model.Ω → ℝ; Pi instances	stable
convexity of feasible payoff set	Convex ℝ	stable
compact convex bodies	ConvexBody exists for convex compact nonempty subsets	current docs confirm ConvexBody with carrier/convex/compact/nonempty and metric if normed 
Lean Community

Hausdorff distance	Metric.hausdorffEDist, Metric.hausdorffDist	current docs show renamed Metric.* names and deprecated EMetric.* aliases since 2026-01-08; use Metric.hausdorffEDist 
Lean Community

nonempty compact hyperspace	TopologicalSpace.NonemptyCompacts	current docs confirm NonemptyCompacts metric structure under Hausdorff distance 
Lean Community

closed graph	`IsClosed {p	...}`
support functions	use sSup over image	may need boundedness/compactness lemmas
measurable functions	Measurable, AEMeasurable, ∀ᵐ	stable
Radon-Nikodym	Measure.rnDeriv	API audit needed
disintegration	likely insufficient	keep in v8 PosteriorDisintegration structures or Inventory
KRN selection	not generally available in the needed form	keep v8 Inventory
Farkas/conic LP	not available in theorem-ready form	Inventory
Strassen/marginal coupling	not available in theorem-ready form	Inventory
Clarke subdifferential	absent	Inventory
Berge maximum theorem	partial compact argmax lemmas may exist	audit before axiomatizing
Hausdorff-Alexandroff surjection	unlikely theorem-ready	Inventory if not in v8

Open API risks:

EMetric.Hausdorff naming is stale. Use Metric.hausdorffEDist/Metric.hausdorffDist.

TopologicalSpace.NonemptyCompacts may require importing Mathlib.Topology.MetricSpace.Closeds.

ConvexBody is for nonempty compact convex subsets, not Pareto frontiers. Use it for W, not WP.

Standard Borel spaces are not first-class enough for FBNF; encode the exact measurable-space hypotheses as fields.

Avoid committing to a specific Mathlib disintegration API. v8 already packages posterior disintegration.

§13 Open questions / blocker risks

WTA threshold normalization conflict. The user-locked scope requests Hall-WTA-reopening-threshold-D with reopening condition D ≥ 2(1−α)/(9α), and source_proof.md repeats that scope. 

source_proof

 A later v9_consolidated.md snippet displays a different normalization, D ≥ 9α/(2(1−α)). 

v9_consolidated

 The Lean ledger should follow the user-locked slug statement, but this must be resolved before proving the numeric theorem.

Radon-Nikodym orientation. v9_consolidated.md flags an orientation typo for the posterior derivative. The formalization should route through v8 PosteriorDisintegration identities rather than hardcoding dn/dq or dq/dn in theorem statements. 

v9_consolidated

Unrestricted theorem is not claimed. v9 is a conditional/classification package, not a proof of unrestricted infinite-M, Θ existence under standing hypotheses alone. The open region is unstructured |Ω| ≥ 3 without binary/FBNF/radial/scalarizable structure, without P2*/G4, and without a verified Ψ ≤ 0 certificate. 

v9_consolidated

Regularity is a real hypothesis. Reg-1 and Reg-2 are not automatic from compact M; Borel jumps in w* and Bayes cones can break closed graph/support continuity. Do not silently derive RegPackage from standing Robust Trust assumptions. 

v9_consolidated

FBNF endpoint-fiber support. The literal adversarial message kernel spreads over endpoint fibers; only the projected payoff image is endpoint-only. Any statement saying the adversary sends only singleton endpoint messages is too strong. 

v9_consolidated

FBNF local stationarity needs two-sided perturbability. Without two-sided perturbations, FBNF-6 becomes a one-sided KKT inequality, not equality. Keep localTwoSidedPerturbability visible in FBNFPackage.

P2 density orientation.* The variable-margin proof needs adversarial target density controlled relative to truthful mass, i.e. a dρ/dτ-style cap. A reversed dτ/dρ cap does not give the posterior-displacement estimate.

Berge maximum theorem audit. Before adding Inventory.berge_maximum_set_valued, check whether compact argmax existence and closedness can be assembled from Mathlib’s existing compactness/continuity lemmas. If yes, do not axiomatize it.

WP compactness proof. The frontier WP must be proved closed inside compact W. This is easy mathematically but can be fiddly in Lean because strict coordinate domination is an open relation with finite coordinates.

Escaped theorem names. The ledger slugs are kebab-case, but Lean declarations must use escaped identifiers like «Hall-G2c-borel-extension».

Prior failed routes should not re-enter through abstractions. Do not resurrect product-of-narrow Sion, τ-AC restricted games, FOC/envelope on the infinite strategy game, or an axiomatized abstract GameSetup; prior attempts record those as blocked or structurally weak. 

prior_attempts_digest
