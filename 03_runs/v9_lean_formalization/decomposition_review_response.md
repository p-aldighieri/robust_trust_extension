DECOMPOSITION REVIEW — VERDICT: PATCH_LIST

A. Numeric conflict: WTA reopening threshold
Verdict: PATCH

The Lean theorem is algebraically correct; the later v9 memo/executive threshold D ≥ 9α/(2(1−α)) is the reciprocal-style error. The decomposition’s statement is:

lean
((-2 * α * D + (1 - α) * (4/9) ≤ 0) ↔ ((2 * (1 - α)) / (9 * α) ≤ D))

decomposition

Algebra:

−2αD+(1−α)
9
4
	​

≤0
(1−α)
9
4
	​

≤2αD
D≥
18α
(1−α)4
	​

=
9α
2(1−α)
	​

.

So at α = 1/2, the threshold is D ≥ 2/9, not 9/2.

Patch:

lean
theorem «Hall-WTA-reopening-threshold-D»
    (α D : ℝ)
    (hαpos : 0 < α) :
    ((-2 * α * D + (1 - α) * ((4 : ℝ) / 9) ≤ 0)
      ↔
     ((2 * (1 - α)) / (9 * α) ≤ D)) := by
  nlinarith [hαpos]

Also patch v9_consolidated.md and v9_executive_summary.md; the executive summary currently says D ≥ 9α/(2(1−α)). 

v9_executive_summary

B. Hall sign convention
Verdict: OK

Ψ(y) ≤ 0 is correct. The decomposition uses PsiNonpos over bounded Borel profiles, and v9 explicitly says the corrected cone-Hall sign is Ψ(y) ≤ 0, not ≥ 0. 

decomposition

 

v9_consolidated

C. Radon–Nikodym orientation
Verdict: OK, with source-display patch

The decomposition’s decision to route through v8’s PosteriorDisintegration is right. Do not hardcode dρ/dτ or dτ/dρ for posteriors in theorem statements. The posterior should be vector numerator over scalar message marginal, dn/dq, and v9 itself records that infinite-space posteriors are only qβ-a.e. 

v9_consolidated

Patch any source/prover display that says dq/dn for the posterior. The decomposition’s §13 warning is correct. 

decomposition

D. Reg-1 / Reg-2 not derived from standing
Verdict: OK

RegPackage correctly makes closed graph, compact values, and support-function continuity explicit added hypotheses. It does not derive them from compact M. 

decomposition

 The v9 ledger explicitly says standing + compact M does not imply Reg-1/Reg-2. 

v9_consolidated

E. FBNF endpoint-fiber support, not singleton endpoints
Verdict: OK, minor naming patch

The decomposition correctly says the projected payoff image is endpoint-only, while literal message support spreads over endpoint fibers. v9 says explicitly: “It is not a singleton-endpoint kernel.” 

v9_consolidated

Patch only naming/documentation:

lean
endpointOnlyImage

should be renamed or documented as:

lean
endpointOnlyProjectedImage

because the literal kernel is endpoint-fiber supported, not singleton-endpoint supported.

F. FBNF-6 needs two-sided perturbability
Verdict: OK

FBNF-F3-localized-stationarity-FBNF6 explicitly assumes:

lean
(hPert : pkg.localTwoSidedPerturbability)

and the proof outline correctly says that without two-sided perturbability the conclusion is one-sided KKT, not equality. 

decomposition

 This matches v9. 

v9_consolidated

G. P2.* density orientation
Verdict: PATCH

The decomposition’s note is correct: the proof needs adversarial target marginal controlled relative to truthful mass, dρ/dτ, not dτ/dρ. 

decomposition

Patch v9_consolidated.md P2* text, which still has the reversed display:

ρ ≪ τ,
dτ/dρ ≤ C

decomposition

Replacement:

ρ ≪ τ,
dρ/dτ ≤ C.

For variable margin:

dρ/dτ ≤ Γη(m)   τ-a.e.

H. Berge maximum, Mathlib audit
Verdict: PATCH

Remove Inventory.berge_maximum_set_valued. The current axiom returns a bare Prop, which is not a usable theorem and is too vague:

lean
axiom berge_maximum_set_valued ... : Prop

decomposition

For the decomposition’s uses, compact argmax existence should be derived from Mathlib compact/extreme-value lemmas such as IsCompact.exists_isMaxOn and IsCompact.exists_isMinOn; official Mathlib docs list these in Mathlib.Topology.Order.Compact. 
Lean Community

Patch:

lean
-- delete Inventory.berge_maximum_set_valued
-- prove concrete argmax existence lemmas from IsCompact + ContinuousOn

Keep KRN/measurable-selection inventory only where the measurable selector is genuinely beyond the local compactness lemma.

I. WP compactness
Verdict: PATCH

The decomposition correctly refuses to make WP a CompactConvex; WP is not generally convex. But it must add a sublemma proving compactness before using WPProfile in hyperspaces.

Patch:

lean
theorem WeakParetoProfile_isClosed
    {model : RobustTrustModel}
    (hWclosed : IsClosed (PayoffProfileSet model)) :
    IsClosed (WP model) := ...

theorem WP_isCompact
    {model : RobustTrustModel}
    (hWcompact : IsCompact (PayoffProfileSet model)) :
    IsCompact (WP model) := ...

Proof idea: if wₙ → w and some v strictly dominates w, finite Ω gives a positive minimum coordinate gap, so v strictly dominates wₙ eventually. Contradiction. The decomposition already flags this as a needed sublemma. 

decomposition

J. Hyperspace KCompactWP = NonemptyCompacts (WPProfile model)
Verdict: OK, import patch

TopologicalSpace.NonemptyCompacts exists. Mathlib’s official docs for Mathlib.Topology.MetricSpace.Closeds say it defines metric/emetric structures on closed subsets and nonempty compact subsets, and Mathlib.Topology.MetricSpace.HausdorffDistance exposes the Hausdorff-distance API. 
Lean Community
+1

Patch imports:

lean
import Mathlib.Topology.Sets.Compacts
import Mathlib.Topology.MetricSpace.Closeds
import Mathlib.Topology.MetricSpace.HausdorffDistance

Then require the WPProfile compactness instance from item I.

K. Bounded Borel profiles
Verdict: OK

The decomposition uses bounded Borel vector prices, not bounded continuous functions:

lean
structure BoundedBorelProfile ...
def PsiNonpos ... := ∀ y : BoundedBorelProfile model, reg.Psi y ≤ 0

decomposition

 This matches the v9 Hall biconditional, which quantifies over bounded Borel y. 

v9_consolidated

L. Escaped declaration names
Verdict: OK

Lean 4 escaped identifiers such as:

lean
theorem «binary-L_B5-endpoint-stationarity-total-balance» ...

are the correct syntax for kebab-case slugs. The decomposition explicitly uses this convention. 

decomposition

M. Hand-off integrity
Verdict: PATCH

Most of the proving-order DAG is coherent: T1 precedes binary B5; binary B1 precedes FBNF F1; FBNF F2/F3/F1 precede F4; Hall feeds P2*/P3/P4/G4. This matches the source dependency graph. 

v9_consolidated

Patch one ordering bug: FBNF-corollary-spherical-radial is placed before P4-radial-antipodal-tau-symmetry, but its own statement lists P4 as a dependency and carries a P4Hyp argument. 

decomposition

 

decomposition

Replacement order:

...
Hall-biconditional
P4-radial-antipodal-tau-symmetry
FBNF-corollary-spherical-radial
P2-star-cone-margin-bounded-jamming
P3-polyhedral-cone-margin
...

or delete the claimed P4 dependency from the corollary if it is merely exact hF4.

N. Anything missed
Verdict: PATCH

The Inventory axioms are currently too abstract and potentially unsound.
ConicFarkasInstance is just two arbitrary Prop fields and the axiom proves primalFeasible ↔ dualNonpositive; StrassenMarginalDominance is also just a Prop field; ClarkeDanskinHyp fields are arbitrary Props. 

decomposition

 These are not “external hammers”; they are theorem-shaped trapdoors.

Patch by replacing each with a concrete mathematical statement. source_proof.md explicitly requires each new Inventory axiom to have a precise Lean statement, citation, and justification why Mathlib cannot cover it. 

source_proof

Opaque Prop conclusion fields make several theorems vacuous.
Examples: FiniteMenuData, BinaryCapstoneData, RegPackage, P2StarHyp, P3Hyp, and P4Hyp carry proof obligations or conclusions as bare Prop fields. 

decomposition

 

decomposition

 The line saying “Prop fields are intentional scaffolding” is fine for a sketch, but not for mergeable Lean decomposition. 

decomposition

Patch: remove conclusion fields such as:

lean
capstoneConclusion : HasRobustRationalizableStrategy model pd
calibratedKernelExists : Prop
robustRationalizableLabeling : Prop

and make theorem conclusions state the target directly.

Corollaries are currently vacuous.
FBNF-corollary-spherical-radial takes hF4 : pkg.capstoneConclusion and returns it. 

decomposition

 The affine-MLR and polyhedral-scalarizable “corollaries” similarly assume the implication they are supposed to prove. Patch them into actual instantiation lemmas, or remove them from the Lean proof queue.

Add a bridge from fixed-label Hall to strategy existence.
Hall-biconditional gives:

lean
reg.robustRationalizableLabeling ↔ PsiNonpos model reg

but P2/P3/P4 conclude:

lean
HasRobustRationalizableStrategy model hyp.reg.pd

The decomposition currently bridges this with sorry. Patch:

lean
theorem robustRationalizableLabeling_to_strategy
    {model : RobustTrustModel}
    (reg : RegPackage model) :
    reg.robustRationalizableLabeling →
      HasRobustRationalizableStrategy model reg.pd := ...

after expanding robustRationalizableLabeling concretely. The v9 source says the reverse Hall direction constructs a Borel kernel and then gives q-a.e. Bayes optimality. 

v9_consolidated

Source integrity issue.
source_proof.md says exposition_v9.tex is the canonical 905-line statement source, while the uploaded project file appears shorter in this workspace. The source map says v9 theorem statements are canonical in exposition_v9.tex, with proofs in v9_consolidated.md. 

source_proof

 Patch by replacing the uploaded exposition_v9.tex with the locked 905-line canonical file, or explicitly declare v9_consolidated.md + exposition_v9_paper.tex as the active statement source.

OVERALL

Mergeable to lean/decomposition.md? Not yet. Mergeable after patches above. The conceptual decomposition is salvageable, but the current Lean scaffolding contains too many arbitrary Prop axioms and conclusion-as-field structures to be treated as a sound prover handoff.

Structural problems forcing re-decomposition? No. The theorem inventory, conditional/classification scope, q-a.e. reading, Hall sign, Reg package, binary/FBNF endpoint-fiber architecture, and v8 reuse are all broadly aligned with v9’s proof ledger. The serious fixes are local but load-bearing.

Confidence: High on the WTA algebra, Hall sign, Reg/FBNF/P2 orientation, and source-scope verdicts. Medium-high on the Mathlib API audit: official docs confirm the relevant compactness and hyperspace primitives, but lake build will still decide the exact import and lemma names. The decomposition is a good map, but right now it is a map with a few bridges drawn in crayon. Patch those before sending the proof goblins into Lean.