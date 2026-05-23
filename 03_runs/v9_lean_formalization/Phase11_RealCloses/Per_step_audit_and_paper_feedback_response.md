According to the v9 source-proof map, I treated v9_consolidated.md as canonical for detailed proofs, dependency graph, hypothesis ledger, and open-problem ledger; exposition_v9.tex as canonical for theorem statements; and exposition_v9_paper.tex as the long-form writing target. The source map also locks the v9 Lean scope to the Binary, FBNF, Hall, G4, P2/P3/P4, and Section G addendum surface. 

source_proof

 I also inspected /mnt/data/v9_appendix.lean directly for the final Phase 11 Lean state.

Part 1 — Per-new-artifact audit
A. Phase 11 per-class PsiNonpos lemmas
Artifact	Verdict	One-line audit
PsiNonpos_of_P2StarHyp	PASS	Translates the P2* cone-margin / bounded-jamming route as a class-specific Ψ upper-bound proof; no certifier shortcut, and it does not invoke the generic Hall conclusion as an oracle.
PsiNonpos_of_P3Hyp	PASS	Matches the P3 finite-facet / finite-flow LP route: finite menu, cone facets, rowwise routing, flow LP, and cone margin are typed separately.
PsiNonpos_of_P4Hyp	PASS	Matches the radial-antipodal theorem: symmetry, reflection balance, antisymmetry, and a structural Ψ upper bound are explicit.
PsiNonpos_of_VariableMarginP2Hyp	PASS	Correctly refactors P2* from uniform margin to Borel-positive variable margin plus density cap and class-specific structural bound.
PsiNonpos_of_GraphFBNFPackage	PASS	Translates P6_G as a graph-FBNF proof route with edge integrands, edge flow, Kirchhoff balance, and structural Ψ upper bound.
PsiNonpos_of_FBNFPackage	PASS, with package caveat below	The lemma itself proves Ψ nonpositivity from the FBNF fiber integrand and structural upper bound, but the package’s B/G “alignment” fields need paper clarification.
PsiNonpos_of_BinaryCapstoneData	PASS, with data caveat below	The Ψ lemma uses binaryIntegrand and the binary structural upper bound; it does not smuggle the capstone conclusion.
PsiNonpos_of_AffineMLRSingleCrossingPrimitive	PASS	Correctly routes affine-MLR / single-crossing through its primitive-to-FBNF instantiation rather than assuming FBNF conclusion directly.
PsiNonpos_of_PolyhedralScalarizablePrimitive	PASS	Correctly treats polyhedral-scalarizable as a primitive instantiation path into FBNF / G4-style scalarization, not as raw polyhedrality.

The v9 ledger’s own dependency graph supports this architecture: FBNF flows through endpoint-supported fiber image, localized stationarity, conditional B1 pasting, and F4; Hall flows through G1/G2c/G3 into P2*/P3/P4 and G4; and the ledger explicitly records those blocks as reviewer-PASS under their stated regularity or primitive hypotheses. 

v9_consolidated

B. Phase 11 structural refactors of hypothesis types
Artifact	Verdict	One-line audit
P2StarHyp	PASS	eta, jam, kappa0, C_rho, jam_le_eta_ae, and the structural upper bound are visible; no conclusion-shaped field.
P3Hyp	PASS	The six-way decomposition into finite menu, polyhedral W, Bayes-cone facets, rowwise routing, finite-flow LP, and cone margin is faithful and not a one-box certificate.
P4Hyp	PASS	radialSymmetry_tauM_preserving, reflectionBalance, antisymmetry, and the structural upper bound make the P4 geometric mechanism explicit.
VariableMarginP2Hyp	PASS	Variable eta, density cap, and structural bound correctly encode the variable-margin addendum; density orientation should be documented in the paper.
GraphFBNFPackage	PASS	The Prop-bridge smell has been removed; edge flow, graph edge integrand, Kirchhoff balance, and structural upper bound are now typed.
FBNFFoliationData	PASS	A clean corollary-instantiation bundle: foliation data, fiber integrand, measurability/integrability, and structural bound are explicit.
FBNFPackage	FAIL as a structural-primitive translation; PASS for the Ψ lemma that consumes it	foliationProjection, fiberChart, tauFiber, and fiberPsiIntegrand are real, but the B/G fiber-alignment fields in the Lean file are reflexive shells rather than substantive alignment assertions. The actual work sits inside the structural upper bound.
BinaryCapstoneData	FAIL as stated in the prompt; PASS for usable theorem data	binaryIntegrand and the upper bound are fine, but post_eq_inclM_on_interior still appears in the Lean structure, so the claimed removal is not true in the inspected final file.

The FBNF caveat is not cosmetic. The v9 proof record emphasizes that FBNF needs an actual Borel affine chart or quotient consistency, endpoint-fiber support, local two-sided perturbability, and global fiber dominance; it also warns that literal singleton endpoint support is false because the kernel spreads over endpoint fibers to calibrate posteriors. 

v9_consolidated

C. Phase 5B bayesConeFromPrior construction on RegPackage
Artifact	Verdict	One-line audit
bayesConeFromPrior	PASS	A legitimate construction map Belief Ω → Set (Belief Ω); this makes the paper’s informal “Bayes cone at a message/prior” into a typed object.
bayesConeFromPrior_self	PASS	Correct self-membership-style structural fact; no conclusion-shaped shortcut by itself.
B_eq_bayesConeFromPrior_at_inclM	PASS	Bridges the regular package’s messagewise Bayes cone to the construction at the included message belief; faithful to the fixed-label Hall setup.
G_rowwise_carries_prior_to_bayes_cone	FAIL as paper-translation / smuggling risk	As a Lean hypothesis, it is explicit, but mathematically it is very close to the calibration goal: rowwise minimizer routing already carries the source prior into the target Bayes cone. The paper should state this as a named structural assumption or derive it, not let it hide in RegPackage.

This is the only Phase 5B item I would call a genuine trust gremlin. The v9 package’s central theorem is a cone-Hall classification: calibrated adversarial kernel exists iff Ψ ≤ 0 under regularity, not an unconditional theorem under standing assumptions alone. 

v9_consolidated

 A field that directly sends rowwise minimizers into Bayes cones is therefore too close to the conclusion unless it is clearly advertised as a primitive compatibility condition.

D. External dependencies / axioms

The remaining external hammers are standard, paper-citable tools: Clarke-Danskin / Clarke-Fermat, Strassen marginal coupling, and conic Farkas / LP duality. The source-proof brief explicitly expects these as Inventory axioms with precise Lean statements, textbook citations, and Mathlib-coverage justification. 

source_proof

 This is acceptable so long as the final Lean file uses concrete mathematical statements rather than arbitrary Prop ↔ Prop trapdoors.

Part 2 — What the English paper should clarify
1. Bayes cone as a function of prior

Status: implicit, paper could clarify.
The paper and v9 prose use messagewise Bayes cones like B(m) or B_W(w*(m)), while Lean makes the construction explicit as bayesConeFromPrior : Belief Ω → Set (Belief Ω). The v9 consolidated source defines B_W(w) and B(m):=B_W(w*(m)), so the concept is there, but not the map-as-object used in Lean. 

prover_01_response

Suggested clarification: “For any belief p, define B(p) to be the Bayes cone associated with the payoff profile used at prior/message p. Thus B(m)=B(m) when m is embedded in the message space.”

2. Per-class structural Ψ bound

Status: implicit, paper should clarify.
Lean requires each primitive class to supply a structural upper bound of the form regPsi reg y ≤ class-specific integral, which is exactly the class-specific geometry-to-Ψ derivation. The v9 ledger lists P2*, P3/G4, P4, FBNF, and graph-FBNF as distinct routes to Ψ ≤ 0, but not all theorem statements expose the exact upper-bound integrand. 

v9_consolidated

Suggested clarification: “Each primitive theorem proves Ψ
w
∗
	​

(y)≤0 by first bounding Ψ
w
∗
	​

(y) above by a class-specific integral. We state these bounds explicitly in the theorem hypotheses/proof so the reader can see where geometry enters.”

3. P3 finite LP encoding

Status: implicit, paper should clarify.
Lean’s P3FiniteFlowLP is more concrete than the phrase “finite-facet LP”: it has explicit x
ij
	​

 flows, source balance, message masses q
j
	​

, numerators n
j
	​

, facet feasibility, and a Farkas/conic feasibility witness. The v9 text says finite-facet/polyhedral cases reduce to a computable LP and that raw polyhedrality is not enough. 

v9_consolidated

Suggested clarification: “In the polyhedral theorem, introduce variables x
ij
	​

 for flow from source cell i to active message/label j, impose source balance, define q
j
	​

,n
j
	​

, and require each Bayes-cone facet g
jℓ
	​

⋅n
j
	​

≤c
jℓ
	​

q
j
	​

.”

4. P4 reflection-balance integrand

Status: gap if P4 is stated beyond the spherical example.
The original paper’s spherical example describes antipodal routing and a scalar radial balance equation, but not the full Lean-level object reflectionBalance as a per-message antisymmetric integrand. 

Robust_trust_Dworczak_Smolin

Suggested clarification: “For radial/antipodal classes, define a measurable reflection-balance function R(m) satisfying the symmetry/antisymmetry identity and show that its integral is the scalar radial balance used to calibrate boundary posteriors.”

5. FBNF F4 fiber disintegration data

Status: implicit-to-gap; paper should state explicitly.
The v9 proof record says FBNF needs a Borel affine chart or quotient-consistent foliation, endpoint-fiber support, local two-sided perturbability, and FBNF-7 global fiber dominance. 

v9_consolidated

 Lean goes further by carrying foliationProjection, fiberChart, tauFiber, and fiber-alignment data. The English paper should not just say “fiberwise” and let the disintegration fairy wave its tiny wand.

Suggested clarification: “State FBNF disintegration data as a definition: a standard Borel base Z, fiber charts ℓ
z
	​

(t), conditional measures τ
z
	​

, quotient consistency on overlaps, and B/G fiber-alignment conditions ensuring fiberwise minimizers are valid global rowwise minimizers.”

6. Binary B6 derivation chain

Status: implicit; paper could clarify order.
Lean’s binary capstone is a staged chain: interval/TRS reduction, endpoint-only projected image, endpoint stationarity/total balance, endpoint-fiber lift, interior calibration, then capstone assembly. The proof ledger records Binary B1/B3/B5/B6 as PASS after Radon-Nikodym and endpoint-fiber patches. 

v9_consolidated

Suggested clarification: “Present Binary B6 in assembly order: TRS interval reduction, endpoint projected minimization, stationarity giving total balance, scalar endpoint-fiber lift, interior truthful calibration, then q-a.e. Definition 2 verification.”

7. GraphFBNF edge flow + Kirchhoff

Status: implicit; paper should clarify.
Lean’s GraphFBNFPackage has explicit graph edge flow, graph-edge integrand, and Kirchhoff node balance. The v9 addendum describes P6_G as finite-graph FBNF with endpoint-fiber transport on each arc and Kirchhoff node balance, but the paper should spell out the edge-flow equations if §G6_G is meant to be theorem-grade. 

v9_executive_summary

Suggested clarification: “For P6_G, define edgewise scalar transports, node deficit/surplus variables, and Kirchhoff balance at shared vertices. Then state cross-edge dominance as the condition that edgewise minimizers are global rowwise minimizers.”

8. WTA threshold form

Status: explicit conflict; paper must patch.
The locked Lean/source scope says the WTA reopening threshold is D≥2(1−α)/(9α). 

source_proof

 However, v9_consolidated.md and the executive summary also contain the reciprocal-style stale form D≥9α/(2(1−α)). 

v9_consolidated

 

v9_executive_summary

Suggested clarification: “Fix the convention once. Under the Lean/source-proof convention Ψ(y)=−2αD+(1−α)
9
4
	​

, the threshold is D≥
9α
2(1−α)
	​

, so at α=1/2, D≥2/9. Remove the reciprocal form everywhere.”

Overall

NEEDS_PAPER_CLARIFICATIONS.
The Phase 11 PsiNonpos lemmas are largely clean and paper-faithful, but the English writeup should explicitly document the Bayes-cone construction map, the per-class Ψ bounds, P3’s actual LP variables, P4’s reflection-balance integrand, FBNF disintegration/alignment data, the Binary B6 chain, GraphFBNF Kirchhoff flow, and the WTA threshold normalization. The Lean side also needs attention to the G_rowwise_carries_prior_to_bayes_cone smuggling risk, the reflexive FBNF alignment shells, and the lingering post_eq_inclM_on_interior field in BinaryCapstoneData.