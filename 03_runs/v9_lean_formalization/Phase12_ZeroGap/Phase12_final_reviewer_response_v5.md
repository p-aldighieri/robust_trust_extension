According to the uploaded Phase 12 files from 2026-05-21/22 and my textual audit of /mnt/data/v9_appendix.lean, the direct Phase 12 refactor goals mostly landed, but I would not accept this as zero-gap yet. I did not independently rerun lake build; line numbers below refer to the uploaded v9_appendix.lean.

OVERALL

Clean: NO
Severity: MEDIUM
Recommendation: further work, not ACCEPT

Reason: A, B, and C pass in the narrow sense: the targeted regPsi_le_*_integral structural fields are gone, G_rowwise_carries_prior_to_bayes_cone is derived, and capstones no longer call PsiNonpos_of_regPackage. But D and G still block a clean zero-gap signoff: there are still broad theorem-shaped structural fields in class packages, and the uploaded file contains 12 code sorries, not 10. The source brief itself frames v9 as a structured conditional/classification formalization with real primitive restrictions, not an unrestricted standing-hypotheses proof, so the audit should be strict about theorem-shaped hypotheses hiding paper derivations. 

source_proof

Per-section verdicts
Check	Verdict	Notes
A. No regPsi_le_X_integral structural fields	PASS	No such structural fields found on P-class structures. Only derived lemmas remain.
B. No G_rowwise_carries_prior_to_bayes_cone structural field	PASS	Removed as field; derived from G_eq_rowwiseBayesMinimizers.
C. No capstone calls to PsiNonpos_of_regPackage	PASS	No code-level calls after comment stripping; capstones route through per-class lemmas.
D. HYPOTHESIS_AS_PAPER_DERIVATION	NO, broad-category fail	Direct regPsi fields are gone, but several class structures still carry proof-payload fields.
E. SMUGGLED_UNIVERSAL_HELPER	PASS with watch item	The Phase 12a helper requires calibrated-kernel input, so it is not by itself a bypass. Watch P4/G-equality strength.
F. 9 axioms	PASS	Found 9 theorem axioms in Inventory.V9, plus 2 opaque external objects. They are concrete textbook-style externals, not arbitrary Prop trapdoors.
G. 10 v9 sorries	FAIL on count, PASS on kind	I found 12 code sorries. They are narrow substantive derivation TODOs, not structural-field shortcuts.
A. regPsi_le_X_integral structural-field audit

Verdict: PASS.

I found no remaining structure fields named like regPsi_le_*_integral. The following remain as derived lemmas/theorems, which is consistent with Phase 12’s stated target:

regPsi_le_integral_localSlack_of_kernel, line 5793

FBNFPackage.regPsi_le_fiber_integral, line 6045

BinaryCapstoneData.regPsi_le_binaryIntegrand_integral, line 6154

P4Hyp.regPsi_le_reflectionBalance_integral, line 6809

GraphFBNFPackage.regPsi_le_graphEdgeIntegrand_integral, line 7441

P3 theorem-level regPsi_eq_finite, line 2637

P3 theorem-level dual_eval_eq_finitePsi, line 2680

So the specific “upper-bound field as hypothesis” problem has been removed for the regPsi_le_X_integral family.

B. G_rowwise_carries_prior_to_bayes_cone on RegPackage

Verdict: PASS.

RegPackage begins at line 1179. I found no structural field named G_rowwise_carries_prior_to_bayes_cone. The new primitive is:

G_eq_rowwiseBayesMinimizers, line 1265

The old carrying lemma is now derived:

RegPackage.G_rowwise_carries_prior_to_bayes_cone, line 1336

RegPackage.source_in_rowwise_bayes_cone, line 1362

This matches the intended Phase 12i architecture. It also matches the v9 design where Hall/G calibration is the fixed-label classification engine under regularity rather than a global standing theorem. 

v9_consolidated

C. No PsiNonpos_of_regPackage calls in capstones

Verdict: PASS.

After comment-stripping, I found zero code calls to PsiNonpos_of_regPackage.

Capstones route through per-class lemmas:

FBNF: PsiNonpos_of_FBNFPackage, line 6133

Binary: PsiNonpos_of_BinaryCapstoneData, line 6369

P2*: PsiNonpos_of_P2StarGeom, line 6855

P3: PsiNonpos_of_P3Hyp, line 6875

P4: PsiNonpos_of_P4Hyp, line 6900

Variable-margin P2*: PsiNonpos_of_VariableMarginP2Hyp, line 7397

Graph FBNF: PsiNonpos_of_GraphFBNFPackage, line 7538

That is the right architecture: the universal Hall/Reg biconditional exists in the source theory, but the capstones should consume class data rather than jumping through a generic conclusion. The v9 proof ledger describes this dependency chain as class-specific routes feeding Hall/G3 rather than a blanket PsiNonpos shortcut. 

v9_consolidated

D. HYPOTHESIS_AS_PAPER_DERIVATION findings

Verdict: NO under the broad 2026-05-23 category.

Strictly for regPsi_le_* structural fields: clean.

For the broader category “any structural field bundling a paper-derivation result”: not clean. This is the main remaining smuggling risk. Earlier review material explicitly warned that opaque Prop conclusion fields and theorem-shaped fields can make theorem statements vacuous if not expanded into concrete theorem conclusions. 

decomposition_review_response

 The structural refinement patches correctly removed some conclusion-as-field patterns and made the Hall bridge more honest, but this file still retains several class-derivation facts as structure fields. 

piotr_pareto_frontier_pass3_chr…

Examples I would classify as HYPOTHESIS_AS_PAPER_DERIVATION unless intentionally marked as primitive assumptions:

BinaryCapstoneData

endpointDominanceFromBalance, line 1419
This packages a balance-to-dominance/transport step.

endpointMassCalibrationFromBalance, line 1430
This packages balance-to-calibration.

binaryIntegrand_nonpos_ae, line 1511
This packages the binary integrand nonpositivity conclusion.

FBNFPackage

fbnf_conditional_b1_pasting, line 1721
This is effectively the F1 measurable pasting step.

fbnf_endpoint_supported_fiber_image, line 1734
This is effectively the F2 endpoint-supported image derivation.

fbnf_t1_endpoint_stationarity, line 1743
This is effectively the F3 localized stationarity derivation.

fbnf_fiberwise_balance, line 1782

fbnf_B_fiber_alignment, line 1835

fbnf_G_fiber_alignment, line 1846

fiberPsiIntegrand_nonpos_ae, lines 1660 and 1879

The FBNF source material says the capstone depends on a true Borel chart/quotient consistency, endpoint-fiber support, local two-sided perturbability, and global fiber dominance, so those should remain visible. But fields such as F1/F2/F3 proof steps and pointwise nonpositivity look like derivations, not primitive geometry. The prior review specifically emphasized endpoint-fiber support and two-sided perturbability as legitimate hypotheses, while warning against hiding proof payload in structure fields. 

decomposition

GraphFBNFPackage

graphEdgeIntegrand_nonpos_ae, line 3036

This is not a primitive graph assumption like Kirchhoff balance or cross-edge dominance; it is the edge-integrand nonpositivity conclusion.

Primitive corollary packages

SphericalRadialFBNFPrimitive: foliationFromRadialDiameters, fiberPreservingTRS_from_radialProjection, endpointSupport_from_antipodalRouting, around lines 3055 to 3057

AffineMLRSingleCrossingPrimitive: endpointExposure_from_singleCrossing, globalFiberDominance_from_MLR, around lines 3195 to 3202

PolyhedralScalarizablePrimitive: globalFiberDominance_or_LP_certificate, around lines 3335 to 3340

These are more defensible as bridge hypotheses, but for zero-gap paper-to-Lean rigor they should either be renamed as explicit added primitives or moved into derived theorem bodies with the relevant sorries. Otherwise they look like little trapdoors wearing a topological hat.

E. SMUGGLED_UNIVERSAL_HELPER findings

Verdict: PASS with watch item.

regPsi_nonpos_of_calibrated_kernel is universal, but it does not discharge class capstones by magic. It requires:

a kernel κ,

support on reg.G,

posterior calibration Pγα κ m ∈ B m q-a.e.

That is exactly the kind of calibrated-kernel object the Hall biconditional is supposed to characterize. The source theory states that the reverse Hall/G3 direction constructs a Borel kernel supported on G(s) with posterior in B(m) q-a.e., yielding exact adversariality and q-a.e. Bayes optimality. 

decomposition

Class consumption check:

P2* and VariableMargin genuinely use cone-margin / jamming / displacement data before invoking the helper.

P3, FBNF, Binary, Affine, Polyhedral, and Graph routes place the hard kernel construction inside derived theorem bodies, several with sorries.

P4 is the thinnest route. PsiNonpos_of_P4Hyp uses a deterministic antipodal kernel plus a generic barycenter/closed-convex argument. This is acceptable only if G_eq_rowwiseBayesMinimizers is accepted as a primitive defining graph strong enough to carry Bayes feasibility. If zero-gap means “derive that equality from radial geometry in the P4 class,” then P4 still needs tightening.

So the Phase 12a helper itself is not a smuggled universal bypass. The watch item is the strength of G_eq_rowwiseBayesMinimizers and the generic barycenter bridge, not regPsi_nonpos_of_calibrated_kernel.

F. Inventory.V9 axioms

Verdict: PASS.

I found 9 theorem axioms in Inventory.V9, plus 2 opaque external objects:

Opaque external objects:

ClarkeSubdiff, line 43

ClarkeNormalCone, line 49

The 9 theorem axioms:

clarke_danskin_stationarity, line 93

clarke_fermat_normal_cone, line 112

strassen_marginals, line 151

bogachev_kernel_factorization, line 177

farkas_lp_duality_conic, line 211

hausdorff_alexandroff_continuous_surjection, line 234

clarke_product_normal_cone_projection_generic, line 457

kantorovich_rubinstein_scalar_duality_generic, line 4691

barycenter_of_supported_measure_in_closed_convex_generic, line 4873

These are not the old arbitrary-Prop trapdoors. The refinement materials explicitly replaced unconstrained Prop inventory hypotheses with concrete mathematical statements, for example Clarke-Danskin now has compact active set, differentiability, Lipschitz, and active-gradient hypotheses; its conclusion is a Clarke subgradient inclusion. 

structural_refinement_response

 The Strassen/Farkas layer is likewise stated in concrete coupling/conic-feasibility form rather than primalFeasible : Prop ↔ dualNonpositive : Prop. 

structural_refinement_response

G. v9 sorries

Verdict: FAIL on count, PASS on character.

The uploaded v9_appendix.lean contains 12 code sorries, not 10, after stripping Lean comments. They are narrow substantive TODOs inside derived theorem bodies, not structural-field shortcuts.

Line	Theorem / lemma	Substantive content
2672	P3FiniteFlowLP.regPsi_eq_finite	Atomic τM decomposition and integral-to-finite-sum rewrite for regPsi, including a.e. representative and finite allowed-label sInf alignment.
2709	P3FiniteFlowLP.dual_eval_eq_finitePsi	Matrix/Farkas algebra identifying the LP dual objective with finite cone-Hall Ψ.
5815	regPsi_le_integral_localSlack_of_kernel	Mixture-message law decomposition, qκ identity, integral add/map rewrites, and comparison of Hall summands to local slack.
6036	FBNF_calibrated_kernel_exists	Construct/paste endpoint-fiber kernels through foliation, prove support in G and posterior calibration q-a.e.
6068	FBNFPackage.regPsi_le_fiber_integral	Fiber-integral/local-slack identity. Derived theorem, not structural field.
6200	BinaryCapstoneData.regPsi_le_binaryIntegrand_integral	Binary integrand/local-slack identity. Derived theorem, not structural field.
6249	BinaryCapstoneData.calibratedKernelExists	Paste left/right Strassen endpoint transports plus truthful interior, prove support and q-a.e. posterior calibration.
6694	P3_calibrated_kernel_exists	Turn finite LP flow into Markov kernel, prove support, identify posterior with n/q, transport facet inequalities into reg.B.
6953	AffineMLRSingleCrossingPrimitive.calibratedKernelExists	Endpoint selection and kernel pasting under MLR/global dominance, support and posterior calibration.
7017	PolyhedralScalarizablePrimitive.calibratedKernelExists	Normalize finite polyhedral facet flow into adviser kernel, prove support and posterior in reg.B.
7432	GraphFBNF_calibrated_kernel_exists	Normalize edge-flow LP into endpoint kernels, paste over graph with Kirchhoff balance, prove support/cross-edge dominance and posterior calibration.
7469	GraphFBNFPackage.regPsi_le_graphEdgeIntegrand_integral	Graph edge-sum/integral identity. Derived theorem, not structural field.

The two extra sorries are real, not comment artifacts. Comment-only sorry mentions appear elsewhere, but these 12 are actual code sorries. This matters because the source proof scope treats v9 as a full surface formalization across T1, T2, Binary, FBNF, Hall, G4, P2*/P3/P4, and Section G sharpenings, while explicitly excluding the unrestricted wilderness. 

source_proof

 A mismatch in the sorry ledger is therefore a real audit failure, even if the sorries are honest little storm-clouds rather than smuggling tunnels.

Bottom line

The refactor does remove the most dangerous Phase 11-style shortcuts: no regPsi_le_* structural fields, no structural G_rowwise_carries_prior_to_bayes_cone, and no capstone routing through PsiNonpos_of_regPackage.

But I would not mark this clean. The remaining proof-payload fields in BinaryCapstoneData, FBNFPackage, GraphFBNFPackage, and the primitive corollary packages mean the broad HYPOTHESIS_AS_PAPER_DERIVATION category is not yet empty. The uploaded file also has 12 code sorries, not the stated 10. For the user’s zero-gap standard, those two points block ACCEPT.