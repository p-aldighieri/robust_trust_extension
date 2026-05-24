According to a source audit of /mnt/data/v9_appendix.lean against the v9 proof brief and review ledger, I do not recommend accepting Phase 12 as clean. I accepted your stated build result as an input and did a textual Lean-smuggling audit; I did not re-run lake build in this session.

OVERALL

Clean: NO
Severity: CRITICAL
Recommendation: further work, do not ACCEPT yet

The narrow Phase 12 greps mostly pass: the old regPsi_le_X_integral fields are gone, the old G_rowwise_carries_prior_to_bayes_cone field is gone, and P-capstones no longer call PsiNonpos_of_regPackage. But the file still has two zero-gap failures:

HYPOTHESIS_AS_PAPER_DERIVATION: several P-class structures still carry paper-derivation conclusions as fields, especially pointwise or a.e. integrand nonpositivity and balance/alignment facts.

SMUGGLED_UNIVERSAL_HELPER: regPsi_nonpos_of_calibrated_kernel is not sufficiently load-bearing as a “calibrated kernel consumption” lemma. Its proof path delegates to Hall-biconditional, whose forward direction can discharge Ψ ≤ 0 using RegPackage structural Bayes-cone facts derived from G_eq_rowwiseBayesMinimizers, rather than actually using the posterior-calibration hypothesis as the mathematical engine. That is too close to a universal helper bypass for the Theorem 2 target, where robust rationalizability requires an adversarial β and Bayes-optimality under the posterior induced by β. The paper’s Definition 2 explicitly requires an adversarial strategy β* and Bayes-optimality under P
β
∗
	​

(⋅∣m), and Theorem 2’s existence result is exactly about producing such an object, not only proving a dual nonpositivity inequality. 

Robust_trust_Dworczak_Smolin

The v9 source itself frames the general result as a conditional/classification theorem, not an unconditional standing-hypotheses proof, with calibrated adversarial kernels characterized by cone-Hall/Ψ under regularity. 

v9_consolidated

 This makes it especially important that any “calibrated kernel” lemma really consumes the posterior-calibration proof, not a structurally preloaded Bayes-feasible graph.

A. No regPsi_le_X_integral structural fields remain on P-class structures

Verdict: PASS, narrow textual check.

I found no remaining structure field named like regPsi_le_*_integral in the P-class packages. The actual non-comment occurrences are theorem/lemma declarations, not fields:

Line	Declaration	Status
5616	regPsi_le_integral_localSlack_of_kernel	theorem-level common lemma
5827	FBNFPackage.regPsi_le_fiber_integral	theorem-level, has sorry
5936	BinaryCapstoneData.regPsi_le_binaryIntegrand_integral	theorem-level, has sorry
6591	P4Hyp.regPsi_le_reflectionBalance_integral	theorem-level
7405	GraphFBNFPackage.regPsi_le_graphEdgeIntegrand_integral	theorem-level, has sorry

Also checked P3: regPsi_eq_finite and dual_eval_eq_finitePsi are theorem-level declarations in P3FiniteFlowLP, not structure fields, even though dot notation makes them look field-like at call sites.

B. No G_rowwise_carries_prior_to_bayes_cone structural field on RegPackage

Verdict: PASS narrowly, but it feeds the critical E finding.

There is no RegPackage field named G_rowwise_carries_prior_to_bayes_cone. It is a derived lemma at line 1336.

However, the new primitive

lean
G_eq_rowwiseBayesMinimizers

at lines 1265 to 1272 defines membership in G s as both:

a rowwise minimizer condition, and

model.inclM s ∈ bayesConeFromPrior (model.inclM m').

That second conjunct is exactly what later derives the carry-prior lemma. This matches the Phase 12i surface requirement, but it is still structurally powerful enough to make the calibrated-kernel hypothesis non-load-bearing downstream.

C. No PsiNonpos_of_regPackage calls in P-class capstone theorems

Verdict: PASS.

I found no non-comment call to PsiNonpos_of_regPackage. The P-capstones route through per-class lemmas:

lean
PsiNonpos_of_FBNFPackage
PsiNonpos_of_BinaryCapstoneData
PsiNonpos_of_P2StarGeom
PsiNonpos_of_P3Hyp
PsiNonpos_of_P4Hyp
PsiNonpos_of_VariableMarginP2Hyp
PsiNonpos_of_GraphFBNFPackage
PsiNonpos_of_AffineMLRSingleCrossingPrimitive
PsiNonpos_of_PolyhedralScalarizablePrimitive

This part is structurally cleaner than earlier versions.

D. HYPOTHESIS_AS_PAPER_DERIVATION findings

Verdict: FAIL.

The old regPsi_le_*_integral fields are gone, but several P-class structures still store paper-derivation conclusions as fields. That violates the “hypotheses should be primitives, derivations should be theorems” discipline. The prior decomposition review explicitly warned that conclusion-like fields and arbitrary proof obligations in structures make Lean handoffs vacuous or trapdoor-shaped. 

decomposition_review_response

Material examples in v9_appendix.lean:

Structure	Field	Lines	Why it is derivation-shaped
BinaryCapstoneData	binaryIntegrand_nonpos_ae	1496 to 1516	Stores a.e. nonpositivity of the binary integrand as data; comments say it is the conclusion of the binary cone-margin / endpoint-balance argument.
FBNFPackage	fbnf_fiberwise_balance	1782 to 1784	Stored balance equation, advertised as derived in F3 but still a field.
FBNFPackage	fbnf_B_fiber_alignment	1835 to 1838	Stores alignment between fiber endpoint labels and Bayes cones.
FBNFPackage	fbnf_G_fiber_alignment	1846 to 1850	Stores alignment between rowwise minimizers and fiber endpoint routing.
FBNFPackage	fiberPsiIntegrand_nonpos_ae	1867 to 1881	Stores the resulting fiberwise Ψ-integrand nonpositivity.
GraphFBNFPackage	kirchhoffBalanceScalar_zero, edgeFlow_nonneg, crossEdgeDominanceMargin_pos	3018 onward	Some are primitive graph-flow assumptions, but kirchhoffBalanceScalar_zero and dominance-margin positivity are proof-output-flavored unless declared as model primitives.
GraphFBNFPackage	graphEdgeIntegrand_nonpos_ae	3035 to 3040	Stores a.e. nonpositivity of the graph integrand, which should be derived from edge-flow plus Kirchhoff plus dominance.
AffineMLRSingleCrossingPrimitive	singleCrossingIntegrand_nonpos_ae	about 3144 to 3152	Stores the single-crossing Ψ integrand nonpositivity.
PolyhedralScalarizablePrimitive	polyhedralFacetIntegrand_nonpos_ae	about 3215 to 3222	Stores finite-facet/polyhedral integrand nonpositivity.

These are not merely harmless regularity assumptions. They are precisely the “paper section derivation steps” that the Lean architecture is supposed to expose as theorem bodies.

E. SMUGGLED_UNIVERSAL_HELPER findings

Verdict: FAIL, critical.

The advertised common-pattern lemma

lean
regPsi_nonpos_of_calibrated_kernel

has the right-looking signature: it requires a kernel κ, support on G, and q-a.e. posterior calibration into reg.B. But the proof path is not clean enough.

The lemma delegates to:

lean
(Hall-biconditional reg).mp ⟨κ, hSupp, hCal_alpha⟩

Inside the forward direction of Hall-biconditional, the decisive inequalities are obtained from structural RegPackage lemmas:

lean
reg.message_in_bayes_cone
reg.source_in_rowwise_bayes_cone

Those are derived from:

lean
bayesConeFromPrior_self
B_eq_bayesConeFromPrior_at_inclM
G_eq_rowwiseBayesMinimizers

The posterior-calibration hypothesis hCal is present, but it is not the mathematical load-bearing source of Ψ ≤ 0. The graph of G has already been defined to contain the source-prior-in-target-cone condition. In effect, the lemma can function like:

“If there is any supported kernel, then RegPackage’s preloaded Bayes-feasible rowwise graph gives Ψ ≤ 0.”

That is not the zero-gap theorem you want. The v9 intended biconditional is supposed to characterize calibrated adversarial kernels by Ψ, with the reverse direction constructing a Borel kernel whose induced posterior lies in the Bayes cone q-a.e. 

v9_executive_summary

 The current forward direction risks making the calibrated posterior a decorative ingredient rather than the key proof object.

Minimal fix: rewrite regPsi_nonpos_of_calibrated_kernel so it proves Ψ ≤ 0 from hCal through the local-slack/posterior calculation, e.g.

prove or finish regPsi_le_integral_localSlack_of_kernel,

derive localSlack ≤ 0 from pd.Pγα κ m ∈ reg.B m,

integrate to get regPsi ≤ 0.

Do not route this proof through reg.message_in_bayes_cone and reg.source_in_rowwise_bayes_cone. Also consider splitting G_eq_rowwiseBayesMinimizers so G is only rowwise minimizers structurally; the source-prior/Bayes-cone carry condition should be a theorem from calibration, not part of the graph definition.

F. 9 axioms

Verdict: PASS textually, with one note.

I found exactly 9 actual axiom declarations, all in Inventory.V9:

clarke_danskin_stationarity

clarke_fermat_normal_cone

strassen_marginals

bogachev_kernel_factorization

farkas_lp_duality_conic

hausdorff_alexandroff_continuous_surjection

clarke_product_normal_cone_projection_generic

kantorovich_rubinstein_scalar_duality_generic

barycenter_of_supported_measure_in_closed_convex_generic

I also found two opaque external objects:

lean
ClarkeSubdiff
ClarkeNormalCone

The axiom count agrees with your stated inventory. This is consistent with the v9 source-proof brief, which expects Inventory-level external mathematical hammers such as Clarke-Danskin, Strassen, Farkas/LP duality, Hausdorff-Alexandroff, and Clarke-Fermat, with precise statements and citations. 

source_proof

 I did not find non-Inventory axioms.

G. v9 sorries

Verdict: FAIL on count; mostly narrow on content.

I found 12 actual sorry tokens in code after stripping comments, not 10. The two-count mismatch is not cosmetic for an audit inventory.

Line	Declaration	Substantive content
2671	P3FiniteFlowLP.regPsi_eq_finite	Finite atomic measure integral-sum and routing reduction for P3.
2708	P3FiniteFlowLP.dual_eval_eq_finitePsi	Finite matrix / dual-evaluation identity for the Farkas encoding.
5638	regPsi_le_integral_localSlack_of_kernel	Core common-pattern local-slack integral identity from qκ/posterior decomposition. This is central to fixing E.
5818	FBNF_calibrated_kernel_exists	Pasting fiberwise endpoint kernels into a global calibrated kernel using foliation, disintegration, FBNF-7, and Bayes-cone alignment.
5850	FBNFPackage.regPsi_le_fiber_integral	Fiber integral identity / upper-bound algebra.
5982	BinaryCapstoneData.regPsi_le_binaryIntegrand_integral	Binary endpoint/interior decomposition into the closed-form integrand.
6031	BinaryCapstoneData.calibratedKernelExists	Pasting two Strassen endpoint transports plus truthful interior kernel, proving support and q-a.e. calibration.
6476	P3_calibrated_kernel_exists	Normalizing finite-flow LP into a Markov kernel and proving posterior-in-cone calibration.
6735	AffineMLRSingleCrossingPrimitive.calibratedKernelExists	Selecting/pasting single-crossing endpoint kernels and proving support plus calibration.
6799	PolyhedralScalarizablePrimitive.calibratedKernelExists	Normalizing polyhedral/facet flow into a calibrated kernel.
7396	GraphFBNF_calibrated_kernel_exists	Finite edge-flow/Kirchhoff/cross-edge kernel construction and q-a.e. calibration.
7433	GraphFBNFPackage.regPsi_le_graphEdgeIntegrand_integral	Graph local-slack / integral identity with Kirchhoff cancellation.

Most of these are genuinely substantive proof steps rather than direct structural shortcuts. But the inventory is wrong, and several sorries are exactly where the current E failure should be fixed, especially regPsi_le_integral_localSlack_of_kernel.

Per-section verdict summary
Check	Verdict	Severity
A. No regPsi_le_X_integral structural fields	PASS	none
B. No old G_rowwise_carries_prior_to_bayes_cone field	PASS narrowly	low, but feeds E
C. No PsiNonpos_of_regPackage calls in P capstones	PASS	none
D. No hypothesis-as-paper-derivation fields	FAIL	HIGH
E. No smuggled universal helper	FAIL	CRITICAL
F. 9 axioms	PASS	low
G. 10 sorries, narrow TODOs	FAIL, 12 found	MEDIUM
Final recommendation

Recommendation: further work.

The next patch should be surgical:

Make regPsi_nonpos_of_calibrated_kernel genuinely consume the posterior-calibration hypothesis via local slack, not via the RegPackage Bayes-feasible graph.

Move *_Integrand_nonpos_ae, fiber balance/alignment, and graph edge nonpositivity fields out of structures into derived theorem bodies or explicitly rename them as primitive assumptions if they are intentionally narrowing the theorem.

Reconsider G_eq_rowwiseBayesMinimizers; for zero-gap rigor, the Bayes-feasible part of the graph should be derived from the calibrated kernel, not installed as the definition of G.

Update the sorry ledger from 10 to 12, or close two more theorem bodies.

Re-run lake build, comment-stripped sorry/axiom greps, and #print axioms after the patch.

As it stands, Phase 12 has the right surface choreography, but one hidden trapdoor remains under the orchestra pit.