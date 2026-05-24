According to documents from 2026-05-21 and a direct source audit of /mnt/data/v9_appendix.lean, the Phase 12 refactor is not yet zero-gap clean. The formal target is still Theorem 2’s existence / robust-rationalizability certificate, where the paper proves existence only under finite M,Θ, and Definition 2 requires an adversarial β
∗
 plus messagewise Bayes optimality. 

objective_statement

 The v9 brief itself frames the Lean surface as a conditional/classification package, not an unrestricted standing-only theorem. 

v9_consolidated

OVERALL

Clean: NO
Severity: HIGH
Recommendation: further work, do not ACCEPT as zero-gap.

The good news: the exact Phase 12 targets A, B, and C are mostly clean. The bad news: D, E, and G still leave real proof architecture gaps. The old regPsi_le_X_integral fields appear gone, but several other fields still carry paper-derivation content, and the file has 12 v9 sorrys, not 10. The proof dragon did not escape through the old door; it found a side window. 🜁

I treated comment-only grep hits as non-findings for A–C, and I separated “old banned structural field remains” from “new structural derivation field still smuggles paper work.”

A. No regPsi_le_X_integral structural fields remain

Verdict: PASS.

Direct grep found regPsi_le.*integral only in comments or theorem/lemma declarations, not as structure fields. The actual derived theorem declarations are:

regPsi_le_integral_localSlack_of_kernel, v9_appendix.lean:L5587

FBNFPackage.regPsi_le_fiber_integral, L5839

BinaryCapstoneData.regPsi_le_binaryIntegrand_integral, L5948

P4Hyp.regPsi_le_reflectionBalance_integral, L6603

GraphFBNFPackage.regPsi_le_graphEdgeIntegrand_integral, L7417

I found no remaining per-class structure field of the old regPsi_le_X_integral form.

B. No G_rowwise_carries_prior_to_bayes_cone structural field remains

Verdict: PASS.

RegPackage now carries G_eq_rowwiseBayesMinimizers as the primitive at v9_appendix.lean:L1265, and RegPackage.G_rowwise_carries_prior_to_bayes_cone is a derived lemma at L1336. No old structural field named G_rowwise_carries_prior_to_bayes_cone remains.

This is aligned with the intended Hall/rowwise-minimizer architecture: the v9 source treats the Hall biconditional as a classification under regularity, not as a free global assumption. 

v9_consolidated

C. No PsiNonpos_of_regPackage calls in P-class capstones

Verdict: PASS.

Grep finds PsiNonpos_of_regPackage only in comments/docstrings, not as an actual declaration or call. The P-class capstones route through their per-class theorem names, for example:

PsiNonpos_of_P2StarGeom

PsiNonpos_of_P3Hyp

PsiNonpos_of_P4Hyp

PsiNonpos_of_VariableMarginP2Hyp

PsiNonpos_of_GraphFBNFPackage

PsiNonpos_of_BinaryCapstoneData

PsiNonpos_of_FBNFPackage

So the old shortcut is not being invoked by capstones.

D. HYPOTHESIS_AS_PAPER_DERIVATION findings

Verdict: FAIL.

The exact old regPsi_le_X_integral fields are gone, but other structural fields still bundle paper-derivation results. This violates the new category: a structure should not carry a theorem-shaped paper derivation as a hypothesis when the Lean architecture is supposed to derive it.

Load-bearing examples:

Binary capstone still stores derivation-shaped fields.
BinaryCapstoneData.endpointDominanceFromBalance at L1419-L1424 packages “endpoint balance implies Strassen marginal dominance.” endpointMassCalibrationFromBalance at L1430-L1434 packages “endpoint balance gives scalar calibration.” Most importantly, binaryIntegrand_nonpos_ae at L1511-L1512 is explicitly documented as the conclusion of the binary cone-margin / endpoint-fiber / stationarity derivation at L1502-L1509. That is not merely primitive data; it is proof content sitting inside the hypothesis package.

FBNF still stores F1/F2/F3-style derivations structurally.
FBNFPackage carries fbnf_conditional_b1_pasting, fbnf_endpoint_supported_fiber_image, fbnf_t1_endpoint_stationarity, fbnf_fiberwise_balance, fbnf_B_fiber_alignment, fbnf_G_fiber_alignment, and fiberPsiIntegrand_nonpos_ae. These are not just economic primitives; several correspond directly to the intended F1–F4 proof chain. The source ledger says FBNF should proceed through endpoint-supported fiber image, localized stationarity, conditional B1+pasting, then capstone. 

v9_consolidated

 In Lean, too much of that chain remains as package data.

GraphFBNF stores the final integrand inequality.
GraphFBNFPackage.graphEdgeIntegrand_nonpos_ae at L3036 packages a Kirchhoff/cross-edge dominance inequality that should be derived from the finite-graph construction. The Graph-FBNF proof target in the record is exactly to construct/paste endpoint-fiber kernels and verify q-a.e. calibration, not to assume the final graph-edge inequality. 

prover_19_response

Affine/Polyhedral primitive packages store nonpositivity conclusions.
AffineMLRSingleCrossingPrimitive.singleCrossingIntegrand_nonpos_ae and PolyhedralScalarizablePrimitive.polyhedralFacetIntegrand_nonpos_ae are likewise theorem-shaped.

Binary tie splitting stores the post-split balance conclusion.
BinaryTieSplittingHyp.endpointBalanceAfterSplit packages the post-splitting stationarity/balance content rather than deriving it from the tie split.

This category is the main reason the pass is not clean. Prior review already warned that conclusion-as-field structures and vacuous corollary data are not mergeable Lean proof architecture. 

decomposition_review_response

E. SMUGGLED_UNIVERSAL_HELPER findings

Verdict: MIXED / FAIL.

The Phase 12a common helper itself is not the main offender. regPsi_nonpos_of_calibrated_kernel requires a concrete AdviserKernel κ, rowwise support, and q-a.e. posterior calibration. That is a legitimate common pattern: it does not by itself prove a per-class capstone.

However, there is a separate helper-bypass smell in the FBNF corollary block.

The file still defines degenerate/trivial helpers around the FBNF construction:

fbnf_trivial_tauFiber

fbnf_trivial_B_fiber_alignment

fbnf_trivial_G_fiber_alignment

fbnf_trivial_fiberPsiIntegrand

fbnf_trivial_pasting

fbnf_trivial_fiberImage

fbnf_trivial_fiberwise_balance

The file’s own comment says previous degenerate placeholders were a problem: lambdaBase = 0, fiberPsiIntegrand = 0, and trivial fiberwise balance previously defeated the faithful FBNF chain (v9_appendix.lean:L6977-L7006). But the spherical-radial corollary still populates substantial FBNF fields with trivial data:

wL := 1, wR := 1, fiberProj := fbnf_trivial_fiberProj, fbnf6Lhs := 0, fbnf6Rhs := 0, fbnf_conditional_b1_pasting := fbnf_trivial_pasting, fbnf_endpoint_supported_fiber_image := fbnf_trivial_fiberImage, fbnf_t1_endpoint_stationarity := rfl, balanceL/R := True, fbnf_fiberwise_balance := fbnf_trivial_fiberwise_balance, fiberChart := fbnf_trivial_fiberChart, tauFiber := fbnf_trivial_tauFiber, and trivial B/G fiber alignment at L7045-L7088.

It then proves hF1, hF2, and hF3 trivially at L7098-L7104.

That is a universal-helper bypass pattern: the corollary can instantiate the FBNF package without genuinely consuming the primitive’s geometry for F1/F2/F3. It still depends on later sorry-containing kernel/integral theorems, so it is not a closed contradiction, but architecturally it is not zero-gap. The earlier decomposition review specifically flagged endpoint-fiber support and FBNF structure as delicate, not decorative. 

decomposition

F. 9 axioms

Verdict: PASS with note.

I found exactly 9 actual axiom declarations in v9_appendix.lean, plus 2 opaque Clarke objects.

Actual axioms:

clarke_danskin_stationarity, L93

clarke_fermat_normal_cone, L112

strassen_marginals, L151

bogachev_kernel_factorization, L177

farkas_lp_duality_conic, L211

hausdorff_alexandroff_continuous_surjection, L234

Inventory.V9.clarke_product_normal_cone_projection_generic, L457

Inventory.V9.kantorovich_rubinstein_scalar_duality_generic, L4485

Inventory.V9.barycenter_of_supported_measure_in_closed_convex_generic, L4667

Opaque objects:

ClarkeSubdiff, L43

ClarkeNormalCone, L49

These are consistent with the source-proof brief’s expectation that Inventory handles external hammers such as Clarke-Danskin, Strassen, Farkas, and related selection/duality tools. 

source_proof

 The axiom count is therefore clean, assuming opaques are not counted as axioms. If the audit treats opaque constants as axiom-like foundations, then the foundation count is 11 external primitives.

G. v9 sorries

Verdict: FAIL on count; mostly PASS on placement.

The uploaded /mnt/data/v9_appendix.lean has 12 bare sorrys, not 10. All 12 are inside derived theorem/proof bodies rather than old structural fields, but the mismatch matters for a zero-gap final pass.

Line	Declaration / theorem	Substantive paper-step content
2672	P3FiniteFlowLP.regPsi_eq_finite	Rewrite regPsi through finite τM decomposition; identify aligned and rowwise sInf terms with the finite allowed-label expression.
2709	P3FiniteFlowLP.dual_eval_eq_finitePsi	Unfold finite Farkas rows/columns and simplify the dual dot product against encoded dual prices.
5609	regPsi_le_integral_localSlack_of_kernel	Prove the common qκ decomposition/local-slack upper bound from mixture law, integral algebra, and sInf ≤ routed integrand.
5830	FBNF_calibrated_kernel_exists	Construct measurable endpoint-lift kernels on fibers via Binary B1/Strassen; paste through foliation; prove G-support and B-calibration.
5862	FBNFPackage.regPsi_le_fiber_integral	Rewrite the pasted-kernel localSlack integral through foliation disintegration and identify it with the fiber Ψ integrand.
5994	BinaryCapstoneData.regPsi_le_binaryIntegrand_integral	Paste endpoint-fiber kernels, split endpoint/interior mass, apply B5 balance, and rewrite the common localSlack bound to the binary integrand.
6043	Binary_calibrated_kernel_exists	Build the Markov kernel from left/right Strassen endpoint transports plus truthful interior; prove G-support and qκ-a.e. B-calibration.
6488	P3_calibrated_kernel_exists	Normalize finite flow into a kernel over allowed labels; prove support and posterior-in-cone via LP/facet certificate.
6747	AffineMLR_calibrated_kernel_exists	Select single-crossing endpoints on affine fibers; paste endpoint-supported kernels; prove G-support and Bayes-cone calibration.
6811	PolyhedralScalarizable_calibrated_kernel_exists	Normalize finite polyhedral facet flow into a measurable kernel; prove face-normal support and facet barycenter calibration.
7408	GraphFBNF_calibrated_kernel_exists	Normalize finite graph edge-flow LP; paste over graph using Kirchhoff cancellation; prove support and graph-assembled posterior calibration.
7445	GraphFBNFPackage.regPsi_le_graphEdgeIntegrand_integral	Rewrite graph kernel localSlack integral as finite edge sums; use Kirchhoff cancellation; identify the graph-edge integrand.

The good part: these are real mathematical TODOs, not old structural regPsi_le_X_integral fields. The bad part: there are 12, and several are exactly the kernel-construction / calibration steps that Theorem 2’s existence direction needs. The paper-level theorem is precisely about producing an adversarial strategy and verifying messagewise Bayes optimality, so these are not cosmetic holes. 

objective_statement

Final audit judgment

A–C are clean; F is clean under the “9 axioms, opaques separate” convention. D and E are not clean, and G has a hard count mismatch. The file has removed the most obvious Phase 12 structural fields, but it still carries proof-shaped data in class structures and still relies on unresolved derived theorem bodies for the substantive calibration/kernalization steps.

Final recommendation: further work. Do not mark Phase 12 as zero-gap accepted until:

The remaining paper-derivation fields are moved out of P-class structures into theorem bodies or explicitly reclassified as primitive economic assumptions.

FBNF corollaries stop using fbnf_trivial_* helpers for F1/F2/F3 and B/G alignment.

The sorry inventory is corrected to 12 or reduced to the claimed 10 by closing the two P3 finite-identity sorries.

The final audit is rerun after these changes, with the same grep gates.