According to documents from 2026-05-21/22 and my static inspection of /mnt/data/v9_appendix.lean, here is the final Phase 11 smuggling check.

OVERALL

Clean: NO
Severity: MEDIUM
Recommendation: further work

The big shortcut is gone: there are zero live code calls to PsiNonpos_of_regPackage, and there are zero live sorry tokens in code after comment/docstring stripping. The per-class PsiNonpos lemmas now route through their own class data and Mathlib-style inequalities rather than the deleted omnibus shortcut.

The remaining non-clean items are not the old poison dart. They are translation/faithfulness issues:

The FBNF corollary wrappers for spherical-radial / affine-MLR / polyhedral-scalarizable still assemble a degenerate placeholder FBNF package with zero base measure, trivial fiber integrand, and trivial fiber balance, then import the real Ψ ≤ 0 through the per-primitive helper. That is not PsiNonpos_of_regPackage, but it is not a faithful Lean ↔ paper instantiation of the FBNF corollaries.

The WTA reopening threshold is inconsistent across source documents: source_proof.md locks D ≥ 2(1−α)/(9α), while one v9_consolidated.md snippet gives the reciprocal-style D ≥ 9α/(2(1−α)). The Lean appears to follow the former, but the paper/source ledger needs reconciliation.

I could not independently run lake build or #print axioms in this container because no lean/lake executable is available. The build PASS claim remains user-supplied; the axiom audit below is static.

The original paper’s Theorem 2 is finite-existence plus optimality: robustly rationalizable implies optimal, and existence is stated under finite M and finite Θ. 

objective_statement

 The v9 package is explicitly a conditional/classification extension, not an unrestricted standing-assumptions proof; the source says the unstructured ∣Ω∣≥3 case remains open without Reg / primitive structure / verified Ψ≤0. 

v9_consolidated

A. No PsiNonpos_of_regPackage residue

Verdict: PASS

Static grep of the entire v9_appendix.lean found PsiNonpos_of_regPackage only in comments/docstrings, mostly historical Phase 11 notes saying the shortcut was deleted. After stripping Lean line comments and nested block comments, the token count is:

PsiNonpos_of_regPackage: 0

No theorem body calls it. No transitive live call target exists under that name.

B. No sorries

Verdict: PASS

After stripping Lean comments/docstrings, the code token count is:

sorry: 0

Raw sorry occurrences are only historical/commentary text such as “NO sorry”, “documented sorry”, or old-route commentary. There are no live sorry proof holes in v9_appendix.lean.

C. Per-class PsiNonpos lemmas honest

Verdict: MOSTLY PASS, with one translation warning

Inspected lemmas:

PsiNonpos_of_P2StarHyp
PsiNonpos_of_P3Hyp
PsiNonpos_of_P4Hyp
PsiNonpos_of_VariableMarginP2Hyp
PsiNonpos_of_GraphFBNFPackage
PsiNonpos_of_FBNFPackage
PsiNonpos_of_BinaryCapstoneData
PsiNonpos_of_AffineMLRSingleCrossingPrimitive
PsiNonpos_of_PolyhedralScalarizablePrimitive

Findings:

Lemma	Body shape	Smuggling check
PsiNonpos_of_P2StarHyp	regPsi ≤ α∫(jam−η), jam≤η a.e., integral_nonpos_of_ae, mul_le_mul_of_nonneg_left	Clean
PsiNonpos_of_P3Hyp	finite-menu / polyhedral / routing / LP / margin chain; closes via finite cone-Hall/Farkas fields	Clean, assuming LP fields are accepted
PsiNonpos_of_P4Hyp	reflection-balance integral, involution, integral_map, antisymmetry	Clean
PsiNonpos_of_VariableMarginP2Hyp	regPsi ≤ α∫(densityCap−η), a.e. nonpositivity, integral nonpos	Clean
PsiNonpos_of_GraphFBNFPackage	finite graph indices, edge flow, Kirchhoff scalar zero, graph integrand nonpos, integral nonpos	Clean, though Prop bridge fields remain as compatibility flags
PsiNonpos_of_FBNFPackage	regPsi ≤ ∫ fiberPsiIntegrand, fiber integrand nonpos a.e., integral nonpos	Clean at lemma-body level
PsiNonpos_of_BinaryCapstoneData	binary integrand upper bound + nonpos a.e. + integral nonpos	Clean
PsiNonpos_of_AffineMLRSingleCrossingPrimitive	single-crossing integrand upper bound + nonpos a.e. + integral nonpos	Clean
PsiNonpos_of_PolyhedralScalarizablePrimitive	polyhedral facet integrand upper bound + nonpos a.e. + integral nonpos	Clean

There is no internal sorry and no call to the deleted shortcut in any of these bodies.

Static axiom count in live code:

axiom: 9
opaque: 2

The two opaques are ClarkeSubdiff and ClarkeNormalCone, representing external nonsmooth-analysis objects. The 9 live axioms are in Inventory.V9; they line up with the intended external inventory surface: Clarke-Danskin/Fermat, Strassen/coupling, Farkas/LP, Hausdorff-Alexandroff, and related textbook analytic/transport helpers. The formalization brief requires new Inventory axioms to be precise textbook externals with citations and Mathlib-coverage justification. 

source_proof

I did not run #print axioms; therefore the statement “#print axioms would show only [propext, Classical.choice, Quot.sound] plus these Inventory axioms” is plausible by static inspection but not independently verified.

D. Structural upper-bound fields

Verdict: PASS for the requested criterion, with FBNF-corollary caveat

The relevant fields are not : PsiNonpos. They are inequalities of the form:

lean
regPsi model reg y ≤ concrete_real_expression

or an integral upper bound, paired with a concrete nonpositivity/integrability package. Examples include:

lean
regPsi_le_jam_minus_eta_integral
regPsi_le_binaryIntegrand_integral
regPsi_le_fiber_integral
regPsi_le_reflectionBalance_integral
regPsi_le_densityCap_minus_eta_integral
regPsi_le_graphEdgeIntegrand_integral
regPsi_le_singleCrossingIntegrand_integral
regPsi_le_polyhedralFacetIntegrand_integral

These are not cert-verifier-shaped in the narrow sense. They do not simply say PsiNonpos; they expose the integrand/routing/margin object whose integral bounds Ψ.

However, they are still strong structural hypotheses. The current Lean proof treats the hard analytic/paper-specific derivation of each upper bound as user-supplied data. That is acceptable if the v9 theorem statements are intentionally conditional/classification statements, which the v9 source says they are. The v9 ledger explicitly classifies Reg and primitive assumptions as meaningful restrictions and says Ψ≤0, when assumed, is exact cone-Hall feasibility rather than a free theorem. 

v9_consolidated

The main caveat: the FBNF corollary wrappers use degenerate zero-measure / trivial-fiber packaging. The source-level FBNF theorem is supposed to require a Borel affine chart or quotient consistency, endpoint-fiber support, local two-sided perturbability, and global fiber dominance; the adversarial kernel is endpoint-fiber supported, not singleton-endpoint supported. 

v9_consolidated

 Lean’s general FBNFPackage lemma respects that shape, but the three FBNF corollary instantiations do not yet faithfully construct the paper’s actual FBNF package.

E. 9 Inventory.V9 axioms

Verdict: PASS, static only

Live code has exactly 9 axiom declarations after comment stripping:

Inventory.V9.clarke_danskin_stationarity
Inventory.V9.clarke_fermat_normal_cone
Inventory.V9.strassen_marginals
Inventory.V9.bogachev_kernel_factorization
Inventory.V9.farkas_lp_duality_conic
Inventory.V9.hausdorff_alexandroff_continuous_surjection
Inventory.V9.clarke_product_normal_cone_projection_generic
Inventory.V9.kantorovich_rubinstein_scalar_duality_generic
Inventory.V9.barycenter_of_supported_measure_in_closed_convex_generic

These are textbook-style externals, not v9-consolidated-memo “because we need it” axioms. The source proof pointer’s expected inventory includes Clarke-Danskin, Strassen, Farkas/LP duality, Hausdorff-Alexandroff, and Clarke-Fermat; it also requires precise Lean statements and citations to standard references rather than proof-specific trapdoors. 

source_proof

The current file also has the two opaque objects ClarkeSubdiff and ClarkeNormalCone. I would record them separately in the axiom report because #print axioms / kernel dependency displays may treat opaque constants differently from theorem axioms, but from a trust perspective they are external-definition stubs.

F. Theorem ↔ paper match

Verdict: PARTIAL PASS / MEDIUM ISSUE

Per theorem class:

Lean theorem family	Paper/v9 match
Original Robust Trust Theorem 2	The paper theorem is finite-M,Θ existence plus optimality. Lean v9 is not claiming the unrestricted theorem, which matches the v9 source’s honest conditional/classification framing. 

objective_statement


T1 finite-menu Pareto-Hall	Matches v9’s finite-menu Clarke-Danskin calibration mechanism, not the original paper’s theorem. This is a v9 extension lemma.
T2 α=0 singleton	Matches v9’s degenerate endpoint theorem. It is scope-changing, not the paper’s finite-existence theorem.
Binary capstone	Matches v9 paper statement if read with R-EE/R-TD/R-IES and q-a.e. calibration.
FBNF capstone	General capstone matches v9 shape: F1/F2/F3/F7 plus endpoint-fiber support and local two-sided perturbability. The source explicitly says two-sided perturbability is required and failure yields one-sided KKT instead. 

v9_consolidated


FBNF corollaries	Not clean. The intended corollaries should instantiate FBNF from radial / affine-MLR / polyhedral-scalarizable primitive data. A review patch explicitly says old corollaries were no-ops and should become real instantiation lemmas; the current Lean wrappers still use degenerate/trivial FBNF packages and import Ψ≤0 through per-primitive helpers. 

sanity_chunk2_response


Hall biconditional / G2c	Matches v9 classification: calibrated adversarial kernel exists iff Ψ(y)≤0 under compact-regular hypotheses, not an unconditional existence theorem. 

v9_consolidated


P2*, VariableMargin, GraphFBNF, P3, P4	The headline theorem statements match the v9 sufficient-class posture. P3 is the cleanest structurally, since the old opaque Prop fields were refactored into finite menu / polyhedral / cone facet / routing / LP / margin substructures.
WTA reopening threshold	Needs source reconciliation. Lean/source-proof scope uses D≥2(1−α)/(9α); one consolidated-memo block contains the reciprocal-style D≥9α/(2(1−α)). Do not treat the theorem-paper match as clean until the paper text and Lean statement agree.
Recommendation

Further work. Not because the old PsiNonpos_of_regPackage goblin survived. It did not. The remaining work is sharper:

Replace the three degenerate FBNF corollary packages with genuine instantiation packages, or stop presenting them as FBNF corollaries and present them only as independent per-primitive PsiNonpos routes.

Reconcile the WTA threshold normalization across source_proof.md, v9_consolidated.md, and Lean.

Run lake build MathlibStarter.V9Main and #print axioms in an actual Lean environment, then attach the exact axiom lists for the headline theorems.

After those patches, I would expect the verdict to become Clean: YES / Severity: NONE or LOW.