OVERALL

Clean: YES
Severity: LOW, procedural caveat only
Recommendation: ACCEPT

I did a static adversarial sweep of /mnt/data/v9_appendix.lean, including a comment/string-stripped token scan. I could not independently rerun lake build or #print axioms in this container because Lean/lake/project files are not available here, so the build-pass and exact #print axioms claims remain accepted from the supplied Phase 11 state rather than reproduced. Code-level smuggling result: clean.

The relevant target is the paper’s Definition 2/Theorem 2: robust rationalizability requires an adversarial β
∗
 and per-message Bayes optimality, and the paper’s original existence theorem is finite-M,Θ; the v9 package is a conditional/classification infinite-extension surface, not an unrestricted infinite theorem. 

objective_statement

 The v9 source pointer also locks the Lean scope to T1, T2, Binary, FBNF, Hall, G4, P2*/P3/P4, and Section G addenda, while explicitly deferring unrestricted ∣Ω∣≥3 wilderness claims. 

source_proof

A. No PsiNonpos_of_regPackage residue

Verdict: PASS

Raw grep finds only historical/comment/docstring occurrences. After stripping Lean comments, block comments, and strings, there are zero live occurrences of:

lean
PsiNonpos_of_regPackage

No theorem, lemma, proof body, helper, or transitive live reference calls it. The shortcut is not merely unused; it is absent from executable code. The remaining references are archive breadcrumbs, not proof machinery. Tiny broom passed, no dust bunny escaped. 🧹

B. No sorries

Verdict: PASS

After stripping comments/docstrings/strings, there are zero live sorry tokens in v9_appendix.lean.

Raw file occurrences of “sorry” are only explanatory prose, such as “no sorry” / “sorry-stubbed” historical notes. No live:

lean
sorry
admit
by
  sorry

was detected in code.

C. Per-class PsiNonpos lemmas honest

Verdict: PASS, with one procedural caveat about #print axioms

The nine per-class lemmas are present and drive the theorem pipeline. I found no internal sorry, no live call to the deleted shortcut, and no “prove PsiNonpos by hypothesis named PsiNonpos” maneuver.

Per lemma:

Lemma	Audit result
PsiNonpos_of_FBNFPackage	Uses regPsi_le_fiber_integral, fiberPsiIntegrand_nonpos_ae, MeasureTheory.integral_nonpos_of_ae, then order chaining. It packages FBNF data but does not call the deleted reg shortcut.
PsiNonpos_of_BinaryCapstoneData	Uses regPsi_le_binaryIntegrand_integral, binaryIntegrand_nonpos_ae, integral_nonpos_of_ae, mul_le_mul_of_nonneg_left, and endpoint-chain hypotheses. Honest scalar-integrand route.
PsiNonpos_of_P2StarHyp	Uses regPsi_le_jam_minus_eta_integral, jam_le_eta_ae, integral_nonpos_of_ae, and nonnegative α multiplication. This is cone-margin/jamming, not a disguised verifier.
PsiNonpos_of_P3Hyp	Routes through finite cone-Hall compression and Farkas/LP duality: P3_Psi_le_finiteConeHall, P3_finiteConeHall_dual_nonpos, and farkas_lp_duality_conic. No global reg shortcut.
PsiNonpos_of_P4Hyp	Uses reflection-balance data, MeasureTheory.integral_map, measure-preserving reflection, antisymmetry, and integral cancellation. This is the radial/involution proof route.
PsiNonpos_of_VariableMarginP2Hyp	Uses regPsi_le_densityCap_minus_eta_integral, densityCap_le_eta_ae, integral_nonpos_of_ae, and α-multiplication. Variable margin is explicit.
PsiNonpos_of_GraphFBNFPackage	Uses regPsi_le_graphEdgeIntegrand_integral, graphEdgeIntegrand_nonpos_ae, edgeFlow, Kirchhoff, and graph dominance data. No generic PsiNonpos import.
PsiNonpos_of_AffineMLRSingleCrossingPrimitive	Uses regPsi_le_singleCrossingIntegrand_integral, singleCrossingIntegrand_nonpos_ae, integral_nonpos_of_ae, and α-multiplication.
PsiNonpos_of_PolyhedralScalarizablePrimitive	Uses regPsi_le_polyhedralFacetIntegrand_integral, polyhedralFacetIntegrand_nonpos_ae, integral_nonpos_of_ae, and α-multiplication.

The source ledger says v9’s dependency structure is exactly: finite menu via Clarke-Danskin/Fermat, binary via endpoint-fiber lift, FBNF via conditional B1+pasting, and Hall via cone-Hall feeding P2*/P3/P4/G4; it also says the calibrations come from Clarke-Danskin, scalar B1, conditional B1+pasting, or cone-Hall, not a postulated menu-Hall or banned Sion route. 

v9_consolidated

Axiom caveat: static scan finds 9 live axiom declarations in Inventory.V9, plus two live opaque object symbols, ClarkeSubdiff and ClarkeNormalCone. I could not run #print axioms; if Lean’s #print axioms reports opaque constants as dependencies, those two may appear as object-level primitives in addition to the 9 theorem axioms. That is not a smuggled proof, but it is worth knowing before treating the axiom list as byte-for-byte verified.

D. Structural upper-bound fields

Verdict: PASS

The regPsi_le_* fields are structural inequalities of the form:

lean
regPsi model reg y ≤ concrete_integral_expression y

or the expanded equivalent. They are not fields of type:

lean
PsiNonpos model reg

and they are not hidden theorem conclusions. Checked structural fields include:

Structure	Field checked	Shape
P2StarHyp	regPsi_le_jam_minus_eta_integral	regPsi ≤ α * ∫ (jam - eta)
P4Hyp	regPsi_le_reflectionBalance_integral	regPsi ≤ ∫ reflectionBalance
VariableMarginP2Hyp	regPsi_le_densityCap_minus_eta_integral	regPsi ≤ α * ∫ (densityCap - eta)
GraphFBNFPackage	regPsi_le_graphEdgeIntegrand_integral	regPsi ≤ α * ∫ graphEdgeIntegrand
FBNFPackage	regPsi_le_fiber_integral	regPsi ≤ ∫ fiberPsiIntegrand
BinaryCapstoneData	regPsi_le_binaryIntegrand_integral	expanded regPsi expression bounded by α * ∫ binaryIntegrand
Affine/Poly primitives	regPsi_le_singleCrossingIntegrand_integral, regPsi_le_polyhedralFacetIntegrand_integral	regPsi ≤ concrete primitive integrand integral

These are strong assumptions, but they are the right kind of strength: paper-section structural upper bounds, not certificate-shaped “and therefore PsiNonpos” fields. The v9 ledger explicitly classifies binary, FBNF, P2*, P3/G4, and P4 assumptions as meaningful real restrictions, with Reg-1/Reg-2 nontrivial and Ψ≤0 acting as an exact classification condition rather than a universal standing theorem. 

v9_consolidated

E. 9 Inventory.V9 axioms

Verdict: PASS, static count

Comment-stripped scan finds exactly 9 live axiom declarations in Inventory.V9:

Inventory.V9.clarke_danskin_stationarity

Inventory.V9.clarke_fermat_normal_cone

Inventory.V9.strassen_marginals

Inventory.V9.bogachev_kernel_factorization

Inventory.V9.farkas_lp_duality_conic

Inventory.V9.hausdorff_alexandroff_continuous_surjection

Inventory.V9.clarke_product_normal_cone_projection_generic

Inventory.V9.kantorovich_rubinstein_scalar_duality_generic

Inventory.V9.barycenter_of_supported_measure_in_closed_convex_generic

The source proof brief already frames the expected Inventory layer as textbook externals, requiring precise Lean statements, citations, and justification for axiomatization where Mathlib does not supply the needed theorem-ready result. 

source_proof

 I did not find a v9-consolidated proof citation masquerading as a mathematical external; the docstrings in the Lean file cite standard external references such as Clarke, Strassen, Bogachev, Farkas/LP duality, Kechris/Hausdorff-Alexandroff, Kantorovich-Rubinstein/Villani, Phelps, and Aliprantis-Border.

Non-failure note: the two opaque declarations for Clarke objects are abstract mathematical object symbols, not theorem axioms. Keep them out of the “9 theorem axioms” count, but expect possible visibility in a strict dependency/axiom printout depending on Lean’s treatment of opaque constants.

F. Headline theorem ↔ paper/v9-paper match

Verdict: PASS

The original Dworczak-Smolin paper statement is matched at the right level: Definition 2 requires an adversarial strategy and Bayes-optimal continuation after messages; Theorem 2 gives robust-rationalizable implies optimal and finite-M,Θ existence. 

Robust_trust_Dworczak_Smolin

 v9 does not claim the unrestricted infinite existence theorem; the consolidated v9 text says the package is OBJECTIVE_NARROWED, with real but meaningful restrictions, and the open region remains the totally unstructured ∣Ω∣≥3 case without binary/FBNF/radial/scalarizable structure, P2*/G4, Reg, or a verified Ψ≤0 certificate. 

v9_consolidated

Per headline:

Headline item	Lean/paper match
T1 finite-menu Pareto-Hall	Matches v9 paper’s payoff-label finite-menu calibration theorem: Clarke-Danskin/Fermat produces Bayes-cone calibration multipliers.
T2 α=0 singleton	Matches v9’s degenerate pure-adversarial endpoint theorem; correctly scope-changing, not pretending to solve α∈(0,1).
Binary capstone	Matches v9 § binary theorem: endpoint exposure, tie discipline, interior stationarity, endpoint-fiber transport, q-a.e. Bayes calibration.
FBNF capstone	Matches corrected v9 FBNF: affine/Borel foliation or quotient consistency, endpoint-fiber support, two-sided perturbability, and global fiber dominance. The v9 text explicitly says the kernel is not singleton-endpoint and spreads over endpoint fibers for calibration. 

v9_consolidated


Hall biconditional	Matches v9 classification theorem: calibrated kernel exists iff Ψ(y)≤0 under compact-closed/no-escape regularity; sign is correct. 

v9_consolidated


G4 finite-facet LP	Matches v9’s finite-facet/polyhedral LP pass/fail certificate, not raw polyhedrality as a magical theorem.
P2*/P3/P4	Match v9 primitive sufficient classes: cone-margin/bounded jamming, finite LP/polyhedral, radial/reflection construction.
Variable-margin P2*	Matches Section G sharpening: variable η, density cap, structural bound.
GraphFBNF/P6
G
	​

	Matches Section G finite-graph FBNF: edge transports plus Kirchhoff node balance and cross-edge dominance.
FBNF corollaries	The final PsiNonpos routes are per-primitive: radial/P4, affine-MLR single crossing, polyhedral facet scalarization. This is aligned with v9’s coverage table for spherical/radial, affine MLR, and scalarizable faces. 

v9_consolidated

Final recommendation

ACCEPT.

No live PsiNonpos_of_regPackage, no live sorries, no generic reg-package shortcut, and no theorem collapses into a hidden PsiNonpos field. The remaining LOW caveat is purely procedural: I could not rerun lake build/#print axioms, and strict axiom printing may expose the two Clarke opaque object symbols alongside the 9 theorem axioms.