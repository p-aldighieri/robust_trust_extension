OVERALL verdict

Clean: NO
Severity: MEDIUM
Recommendation: further work before ACCEPT

I audited /mnt/data/v9_appendix.lean textually. I could not re-run lake build in this container, so I treat the user-supplied build result as given. The Phase 12 structural target is mostly successful: the old regPsi_le_X_integral fields are gone, the old G_rowwise_carries_prior_to_bayes_cone field is gone, and P-class capstones no longer route through PsiNonpos_of_regPackage. But the zero-gap claim does not pass as stated, because the file contains 23 actual sorrys, not 10, and there are still several proof-shaped structural fields outside the narrow regPsi_le_X_integral family.

The v9 proof brief itself frames the Lean target as a broad conditional/classification surface, with T1, T2, Binary, FBNF, Hall, G4, P2/P3/P4, and Section G addendum components, and it requires precise external Inventory axioms rather than theorem-shaped trapdoors. 

source_proof

 The consolidated ledger also says the package is OBJECTIVE_NARROWED, with Reg/primitive assumptions treated as real restrictions, not free derivations from standing hypotheses. 

v9_consolidated

A. No regPsi_le_X_integral structural fields remain

Verdict: PASS

I found no P-class structure field named like regPsi_le_*_integral. The remaining hits are derived lemmas or comments/docstrings. The important surviving derived theorem names are:

regPsi_le_integral_localSlack_of_kernel, line 5974.

FBNFPackage.regPsi_le_fiber_integral, line 6227.

BinaryCapstoneData.regPsi_le_binaryIntegrand_integral, line 6380.

P4Hyp.regPsi_le_reflectionBalance_integral, line 7035.

GraphFBNFPackage.regPsi_le_graphEdgeIntegrand_integral, line 7637.

So the Phase 12 field-removal pass succeeded for the named regPsi_le_X_integral pattern. The little caveat-beetle is that several of these derived lemmas still contain sorry; that is a G-section incompleteness issue, not an A-section structural-field issue.

B. No G_rowwise_carries_prior_to_bayes_cone structural field on RegPackage

Verdict: PASS

RegPackage no longer has G_rowwise_carries_prior_to_bayes_cone as a field. It now has the primitive:

G_eq_rowwiseBayesMinimizers

and the carry lemma is derived later:

RegPackage.G_rowwise_carries_prior_to_bayes_cone, line 1336.

RegPackage.source_in_rowwise_bayes_cone, line 1362.

This matches the stated Phase 12i design.

C. No PsiNonpos_of_regPackage calls in P-class capstones

Verdict: PASS

PsiNonpos_of_regPackage appears only in comments/docstrings, not as an executable theorem call. The P-class capstones route through per-class nonpositivity theorems:

PsiNonpos_of_FBNFPackage

PsiNonpos_of_BinaryCapstoneData

PsiNonpos_of_P2StarGeom

PsiNonpos_of_P3Hyp

PsiNonpos_of_P4Hyp

PsiNonpos_of_VariableMarginP2Hyp

PsiNonpos_of_GraphFBNFPackage

This is exactly the desired routing. No old universal capstone shortcut remains.

D. HYPOTHESIS_AS_PAPER_DERIVATION findings

Verdict: FAIL / PATCH REQUIRED

The narrow Phase 12 target is clean, but the broader “no paper-derivation result bundled as a hypothesis” criterion is not clean.

The main residual proof-shaped structural fields are not the old regPsi_le_X_integral fields. They are integrand nonpositivity, B/G alignment, stationarity, and balance fields packed into FBNF/corollary primitive data. Examples:

Location	Field / object	Concern
line 1680	FBNFFoliationData.fiberPsiIntegrand_nonpos_ae	Directly assumes the fiberwise Ψ-integrand nonpositivity that should be derived from pasted kernels, endpoint support, balance, and Bayes-cone alignment.
line 1683	FBNFFoliationData.integrable_fiberPsiIntegrand	Less severe, but still a proof obligation embedded in data.
line 3245	SphericalRadialFBNFPrimitive.radialFoliation : FBNFFoliationData ...	Imports the foliation data bundle, including integrand nonpositivity, rather than deriving it purely from radial primitives.
lines 3264, 3268, 3272, 3286	radialConditionalB1Pasting, radialEndpointSupportedFiberImage, radialEndpointStationarity, radialFiberwiseBalance	These are paper-derivation steps carried as fields.
lines 3305 to 3317	radial_B_fiber_alignment, radial_G_fiber_alignment	Bayes-cone and rowwise-minimizer alignment are derivation-shaped.
lines 3385, 3404	singleCrossingIntegrand_nonpos_ae, affineFoliation	Affine-MLR branch still carries integrand nonpositivity or a data bundle that carries it.
lines 3417, 3421, 3425, 3439	affine conditional pasting / endpoint image / stationarity / balance fields	Same issue in affine MLR specialization.
lines 3458 to 3470	affine B/G alignment fields	Same issue.
lines 3538, 3555	polyhedralFacetIntegrand_nonpos_ae, polyhedralFacetFoliation	Polyhedral branch carries nonpositivity or a foliation bundle containing it.
lines 3567, 3572, 3577, 3591	polyhedral conditional pasting / endpoint image / stationarity / balance fields	Same issue.
lines 3611 to 3623	polyhedral B/G alignment fields	Same issue.

This is the main zero-gap blocker. The earlier decomposition review explicitly warned against conclusion-as-field and proof-shaped structure fields, including vacuous or too-powerful packages. 

decomposition_review_response

 Phase 12 fixed the named regPsi fields, but not all derivation-as-hypothesis packaging.

The clean repair is to either prove these as derived lemmas from genuine primitives, or explicitly downgrade the affected corollaries to conditional primitive packages. For a zero-gap Lean architecture, these should not be silent structural assumptions.

E. SMUGGLED_UNIVERSAL_HELPER findings

Verdict: PASS, with warning

regPsi_nonpos_of_calibrated_kernel is not itself a smuggled universal helper. It requires a real calibrated kernel:

support on reg.G,

posterior calibration into reg.B q-a.e.,

then the local slack argument converts those facts into Ψ-nonpositivity.

That is a legitimate common pattern, not a magic theorem that discharges P-classes for free. The FBNF source ledger also emphasizes that real kernels must spread over endpoint fibers to calibrate posteriors, and that endpoint-only projected payoff image is weaker than singleton endpoint message support. 

v9_consolidated

The warning: many class-specific calibrated-kernel constructors are still unresolved or supplied via fields. So the helper is architecturally honest, but the current file has not yet closed all per-class kernel-construction obligations. The spell is legal; several ingredients are still powdered dragonbone labeled sorry.

F. Inventory axioms

Verdict: PASS

After stripping comments/docstrings, I count exactly 9 actual axiom declarations:

Inventory.V9.clarke_danskin_stationarity, line 93.

Inventory.V9.clarke_fermat_normal_cone, line 112.

Inventory.V9.strassen_marginals, line 151.

Inventory.V9.bogachev_kernel_factorization, line 177.

Inventory.V9.farkas_lp_duality_conic, line 211.

Inventory.V9.hausdorff_alexandroff_continuous_surjection, line 234.

Inventory.V9.clarke_product_normal_cone_projection_generic, line 457.

Inventory.V9.kantorovich_rubinstein_scalar_duality_generic, line 4872.

Inventory.V9.barycenter_of_supported_measure_in_closed_convex_generic, line 5054.

A naive grep can return 11 because two docstring lines contain axiom-like prose, but they are not declarations. These 9 are plausibly textbook/library externals rather than theorem-specific shortcuts, provided each statement remains mathematically concrete and source-cited as required by the formalization brief. 

source_proof

G. sorry audit

Verdict: FAIL

The file has 23 actual sorrys, not 10. All are in substantive proof locations rather than structural fields, but the count mismatch alone blocks the “FINAL Phase 12 zero-gap” claim.

Line	Declaration	Substantive TODO content
1538	endpointDominanceFromBalance	Derive Strassen marginal-dominance inequalities for endpointRelation from endpoint exposure, tie discipline, interior stationarity, and B5 balance.
1563	endpointMassCalibrationFromBalance	Identify endpoint transport masses with T1-normalized endpoint-menu masses and prove the α-calibration identity.
1876	fbnf_conditional_b1_pasting	Paste binary B1 endpoint-fiber lifts over the foliation base and identify scalar masses wL,wR.
1896	fbnf_endpoint_supported_fiber_image	Use fiber-preserving TRS plus endpoint exposure/tie discipline to get endpoint-supported projected fiber image.
1919	fbnf_t1_endpoint_stationarity	Specialize T1 Clarke-Danskin/Fermat stationarity to two endpoint labels on each fiber.
1940	fbnf_fiberwise_balance	Upgrade FBNF-6 to λ-a.e. left/right endpoint-balance identities.
1964	fbnf_B_fiber_alignment	Push endpoint-supported fiber image through Reg-2/Bayes-cone construction and disintegration to get B-membership.
1992	fbnf_G_fiber_alignment	Use FBNF-7 dominance and Reg graph definitions to prove endpoints lie in rowwise-minimizer correspondence.
2018	fiberPsiIntegrand_nonpos_ae	Combine pasted endpoint kernels, balances, FBNF-7, and B/G alignment to prove per-fiber Ψ-integrand nonpositivity.
2782	P3FiniteFlowLP.regPsi_eq_finite	Convert tauM_dirac_decomp into integral-sum rewrites for regPsi and finite allowed-label expression.
2819	P3FiniteFlowLP.dual_eval_eq_finitePsi	Unfold finite matrix/Farkas encoding and simplify the dot product with lp.encodeDual Y.
3167	GraphFBNFPackage.graphEdgeIntegrand_nonpos_ae	Sum per-edge support-function gaps, cancel node terms with Kirchhoff, use cross-edge dominance.
5996	regPsi_le_integral_localSlack_of_kernel	Prove the generic qκ-decomposition/local-slack integral identity using mixture law and csInf_le.
6218	FBNF_calibrated_kernel_exists	Construct and paste endpoint-lift kernels on fibers, prove support on regBridge.G, posterior in regBridge.B q-a.e.
6250	FBNFPackage.regPsi_le_fiber_integral	Rewrite local-slack integral through foliation disintegration and identify it with fiberPsiIntegrand.
6369	BinaryCapstoneData.binaryIntegrand_nonpos_ae	Split endpoint/interior messages, use B1/B4/B5 calibration, prove binary integrand nonpositive.
6426	BinaryCapstoneData.regPsi_le_binaryIntegrand_integral	Paste binary endpoint-fiber kernels and rewrite local-slack bound into the closed-form binary integrand.
6475	BinaryCapstoneData.calibratedKernelExists	Build the binary Markov kernel by pasting endpoint transports and truthful interior kernel, prove G-support and B-calibration.
6920	P3_calibrated_kernel_exists	Normalize finite LP flow into an adviser kernel, prove G-support, identify posterior as lp.n j / lp.q j, use facets for Bayes-cone membership.
7179	AffineMLRSingleCrossingPrimitive.calibratedKernelExists	Select endpoints per affine fiber, paste endpoint-supported kernels, prove G-support and B-calibration via MLR/global dominance.
7243	PolyhedralScalarizablePrimitive.calibratedKernelExists	Normalize finite facet flow into a kernel, prove scalarized face-normal exposure and LP-based Bayes-cone membership.
7628	GraphFBNF_calibrated_kernel_exists	Normalize finite edge-flow LP into endpoint kernels, paste over graph via Kirchhoff, prove G-support and posterior-in-B.
7665	GraphFBNFPackage.regPsi_le_graphEdgeIntegrand_integral	Rewrite graph pasted-kernel local-slack integral into finite edge sums/Kirchhoff support-function gap.

These are mostly narrow and mathematically substantive, not obvious smuggling shortcuts. But there are more than twice the stated count, and several are load-bearing capstone steps. The result is a good Phase 12 refactor skeleton, not a zero-gap completion.

Final recommendation

Do not ACCEPT as “FINAL Phase 12 zero-gap.”

Accept the narrow Phase 12 structural cleanup for A, B, C, E, and F. Then run a Phase 13 “sorry and derivation-field burn-down” pass with two targets:

Reduce the 23 sorrys to the claimed 10 or fewer, with each remaining TODO explicitly justified as a paper-level theorem import or a named Mathlib gap.

Eliminate or relabel the residual FBNF/radial/affine/polyhedral proof-shaped fields, especially integrand nonpositivity, B/G alignment, endpoint stationarity, and fiberwise balance fields.

Right now the Lean architecture is much better than the old menu-Hall-shaped scaffolding, but the zero-gap gate still has teeth marks.