OVERALL verdict

Clean: NO
Severity: HIGH
Recommendation: further work

I audited the source text of v9_appendix.lean. I could not independently re-run lake build in this sandbox because lean/lake are not installed here, so I take the reported build pass as given and report the source-level smuggling audit.

The Phase 12 core refactor mostly worked: the old PsiNonpos_of_regPackage shortcut is gone, G_rowwise_carries_prior_to_bayes_cone is now derived, and the main P2/P3/P4/Binary/FBNF/Graph capstones route through per-class PsiNonpos_of_<Class> lemmas. However, the file is not zero-gap clean because there are still exact structural regPsi_le_X_integral fields in FBNF-corollary primitive classes, plus several theorem-shaped FBNF/binary/graph fields that package paper derivation steps as hypotheses. Tiny goblin, large door. 🧩

A. No regPsi_le_X_integral structural fields remain

Verdict: FAIL, with a core-package caveat.

For the Phase 12-listed core packages, the target refactor mostly succeeded. The following are now theorem-level lemmas, not structural fields:

regPsi_le_integral_localSlack_of_kernel at L5632.

FBNFPackage.regPsi_le_fiber_integral at L5843.

BinaryCapstoneData.regPsi_le_binaryIntegrand_integral at L5952.

P4Hyp.regPsi_le_reflectionBalance_integral at L6607.

GraphFBNFPackage.regPsi_le_graphEdgeIntegrand_integral at L7405.

But two exact regPsi_le_X_integral structural fields remain:

AffineMLRSingleCrossingPrimitive.regPsi_le_singleCrossingIntegrand_integral at L3158.

PolyhedralScalarizablePrimitive.regPsi_le_polyhedralFacetIntegrand_integral at L3235.

Those are not mere names in comments. They are fields inside structures, and they assert the class-specific regPsi upper bound directly. If “P-class” is interpreted narrowly as only P2/P3/P4/Binary/FBNF/Graph, then A passes for that core. If the audit covers all positive primitive packages in the v9 theorem surface, including FBNF corollary primitives, A fails.

B. No G_rowwise_carries_prior_to_bayes_cone structural field on RegPackage

Verdict: PASS.

RegPackage now has the primitive field:

G_eq_rowwiseBayesMinimizers at L1265.

The old carry-prior fact is a derived lemma:

RegPackage.G_rowwise_carries_prior_to_bayes_cone at L1336.

The proof rewrites membership in G s via G_eq_rowwiseBayesMinimizers and extracts the second conjunct. This is the correct Phase 12i shape: definition-like primitive first, carry-prior consequence second.

C. No PsiNonpos_of_regPackage calls in P-class capstones

Verdict: PASS.

There is no active declaration or call of PsiNonpos_of_regPackage; all occurrences are comments/docstrings documenting its deletion.

The capstones route through per-class lemmas:

FBNF: PsiNonpos_of_FBNFPackage.

Binary: PsiNonpos_of_BinaryCapstoneData.

P2*: PsiNonpos_of_P2StarGeom.

P3: PsiNonpos_of_P3Hyp.

P4: PsiNonpos_of_P4Hyp.

Variable margin: PsiNonpos_of_VariableMarginP2Hyp.

Graph FBNF: PsiNonpos_of_GraphFBNFPackage.

That part is clean. The old all-purpose RegPackage wand has been removed from active proof traffic.

D. HYPOTHESIS_AS_PAPER_DERIVATION findings

Verdict: FAIL.

There are still structural fields that package paper derivation results rather than primitive economic/geometric assumptions.

Most important findings:

Exact structural regPsi upper-bound fields remain in FBNF corollary primitives.

L3158: regPsi_le_singleCrossingIntegrand_integral.

L3235: regPsi_le_polyhedralFacetIntegrand_integral.

These are precisely the kind of class-specific upper-bound fields Phase 12 was meant to delete.

FBNF F1/F2/F3 are still discharged by structural theorem-shaped fields.

In FBNFPackage, fields such as:

fbnf_conditional_b1_pasting.

fbnf_endpoint_supported_fiber_image.

fbnf_t1_endpoint_stationarity.

fbnf_fiberwise_balance.

fbnf_B_fiber_alignment.

fbnf_G_fiber_alignment.

fiberPsiIntegrand_nonpos_ae.

are not just raw primitives. Their docstrings identify them as the F1/F2/F3/F4 derivation content. The theorems FBNF-F1, FBNF-F2, and FBNF-F3 then largely unpack these fields rather than proving the corresponding paper steps from lower-level assumptions.

Binary and graph packages still carry conclusion-shaped integrand nonpositivity fields.

Examples:

BinaryCapstoneData.binaryIntegrand_nonpos_ae at L1511. Its docstring says this is the conclusion of the v9 §B.3 binary cone-margin argument.

GraphFBNFPackage.graphEdgeIntegrand_nonpos_ae at L3035. Its docstring describes the Kirchhoff/cross-edge dominance integral comparison.

FBNFPackage.fiberPsiIntegrand_nonpos_ae at L1879. Its docstring says it is the conclusion of the per-fiber Binary B1/Strassen endpoint lift.

FBNF corollary instantiations still use degenerate/trivial placeholders.

The spherical/radial, affine-MLR, and polyhedral-scalarizable corollaries build FBNFPackages using helper placeholders such as:

fbnf_trivial_pasting.

fbnf_trivial_fiberProj.

degenerate band L = a, R = b.

balanceL := fun _ => True, balanceR := fun _ => True.

tauFiber := 0.

vacuous B/G fiber alignment.

That is not zero-gap. It means the FBNF corollaries are still leaning on package fields and degenerate construction scaffolding, rather than deriving the paper’s nondegenerate geometric/fiberwise content.

This is the main reason the audit cannot return “Clean: YES.”

E. SMUGGLED_UNIVERSAL_HELPER findings

Verdict: PARTIAL PASS.

The Phase 12a helper itself is not the bypass.

regPsi_nonpos_of_calibrated_kernel at L5593 requires:

A concrete adviser kernel κ.

KernelSupportedOnRegG model reg.G κ.

Posterior calibration:
∀ᵐ m, reg.pd.Pγα κ m ∈ reg.B m.

That is a strong, meaningful input. The helper does not create calibration from thin air. It only says: once a class has genuinely constructed a calibrated rowwise-minimizer kernel, Hall nonpositivity follows.

The problem is upstream: several classes still supply the hard calibration or upper-bound work structurally, or leave it in sorries. So the universal helper is acceptable, but some class inputs feeding it are not yet zero-gap. The helper is a clean bridge; some roads into the bridge are still fog machines.

F. Inventory.V9 axioms

Verdict: PASS, with opacity note.

I found 9 theorem axioms in Inventory.V9, matching the stated count:

clarke_danskin_stationarity at L93.

clarke_fermat_normal_cone at L112.

strassen_marginals at L151.

bogachev_kernel_factorization at L177.

farkas_lp_duality_conic at L211.

hausdorff_alexandroff_continuous_surjection at L234.

clarke_product_normal_cone_projection_generic at L457.

kantorovich_rubinstein_scalar_duality_generic at L4500.

barycenter_of_supported_measure_in_closed_convex_generic at L4682.

There are also two opaque declarations:

ClarkeSubdiff at L43.

ClarkeNormalCone at L49.

Those are abstract mathematical objects, not theorem axioms. The source brief expected v9 Inventory axioms to be precise external hammers with citations and justification, which is the right standard for this layer. 

source_proof

I do not see theorem-shaped internal v9 derivations reintroduced as Inventory.V9 axioms. The previous smuggled axioms appear to have been removed and replaced with derived lemmas or localized sorries.

G. Ten v9 sorries

Verdict: PASS as to placement; not proof-complete.

There are exactly 10 actual code sorries. They are all inside theorem/lemma bodies, not structural fields.

L2671: P3FiniteFlowLP.regPsi_eq_finite
Borel regPsi to finite LP functional rewrite. Substantive content: reduce integrals and rowwise sInf terms over atomic finite support to the finite cone-Hall expression.

L2708: P3FiniteFlowLP.dual_eval_eq_finitePsi
Finite matrix/Farkas encoding identity. Substantive content: unfold canonical rows/columns and show the encoded dual objective equals the finite cone-Hall functional.

L5654: regPsi_le_integral_localSlack_of_kernel
Universal qκ-decomposition rewrite. Substantive content: identify the additive aligned/misaligned regPsi expression with a single mixture-message integral of localSlack.

L5834: FBNF_calibrated_kernel_exists
FBNF calibrated-kernel construction. Substantive content: paste fiberwise endpoint kernels through foliation disintegration and prove support/calibration for regBridge.G and regBridge.B.

L5866: FBNFPackage.regPsi_le_fiber_integral
FBNF local-slack to fiber-integral identity. Substantive content: unfold the pasted kernel, rewrite the mixture marginal through foliation disintegration, and identify the fiber support-function gap.

L5998: BinaryCapstoneData.regPsi_le_binaryIntegrand_integral
Binary local-slack/integrand identity. Substantive content: split endpoint and interior message regions, use endpoint-fiber Strassen transport and B5 balance, and rewrite into the closed-form binary integrand.

L6047: BinaryCapstoneData.calibratedKernelExists
Binary calibrated-kernel construction. Substantive content: paste left/right endpoint-fiber kernels with truthful interior behavior and prove qκ-a.e. posterior membership in regBridge.B.

L6492: P3_calibrated_kernel_exists
P3 finite-flow kernel construction. Substantive content: normalize LP flows into Markov kernels, prove support in reg.G, and identify posteriors with finite LP numerators satisfying Bayes cone facets.

L7396: GraphFBNF_calibrated_kernel_exists
Graph-FBNF calibrated-kernel construction. Substantive content: normalize finite edge-flow LP, paste endpoint kernels with Kirchhoff cancellation, prove support and posterior calibration.

L7433: GraphFBNFPackage.regPsi_le_graphEdgeIntegrand_integral
Graph-FBNF integral identity. Substantive content: rewrite the qκ local-slack integral into finite edge sums and identify the graph-edge support-function gap.

These are narrow and substantive, as claimed. But because D fails, the presence of narrow sorries alone does not make the architecture zero-gap clean.

Final recommendation

Do not accept yet.

Minimum next patch set:

Delete or demote the remaining structural upper-bound fields:

AffineMLRSingleCrossingPrimitive.regPsi_le_singleCrossingIntegrand_integral.

PolyhedralScalarizablePrimitive.regPsi_le_polyhedralFacetIntegrand_integral.

Replace FBNF package theorem-shaped fields with either:

derived theorems with localized sorries, or

explicit named assumptions in theorem statements that are presented as added hypotheses, not as “proved F1/F2/F3” Lean theorems.

Remove the degenerate FBNF corollary placeholders or mark those corollaries as scaffolding only. The current construction with zero tauFiber, trivial balance predicates, and trivial fiber projection is not paper-faithful.

Keep regPsi_nonpos_of_calibrated_kernel. It is a legitimate bridge, not the smuggling source.

Once those patches land, rerun this audit. Right now the old dragon is wounded, not slain.