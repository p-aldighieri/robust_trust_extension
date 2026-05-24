OVERALL

Clean: NO
Severity: CRITICAL
Recommendation: further work, do not accept this as Phase 12 zero-gap.

The uploaded /mnt/data/v9_appendix.lean does not match the Phase 12 state described in the prompt. The prompt says the per-class regPsi_le_X_integral fields and the G_rowwise_carries_prior_to_bayes_cone field were removed and replaced by derived theorems. In the uploaded Lean file, they are still executable structural fields. The result is not a small naming drift. It is exactly the kind of Lean-smuggling pattern Phase 12 was supposed to excise: substantive paper-derivation steps remain bundled as hypotheses inside class/package structures, then downstream capstone lemmas consume those fields.

This matters because the paper’s Definition 2/Theorem 2 requires a real adversarial strategy and per-message Bayes optimality, not a pre-installed calibration oracle. The project’s own source map also frames v9 as a conditional/classification formalization with explicit lemma dependencies, not as an unrestricted theorem under standing assumptions alone. 

objective_statement

 

source_proof

 The v9 ledger itself says the package is OBJECTIVE_NARROWED, with Reg assumptions and Ψ-calibration as nontrivial objects rather than automatic consequences. 

v9_consolidated

Static audit transcript

I audited the uploaded /mnt/data/v9_appendix.lean directly, stripping comments before counting.

comments stripped:
  sorry count: 0
  axiom count: 9
  opaque count: 2
  constant declarations: 0

missing Phase 12 names:
  G_eq_rowwiseBayesMinimizers: 0
  localSlack: 0
  regPsi_le_integral_localSlack_of_kernel: 0
  regPsi_nonpos_of_calibrated_kernel: 0

still present:
  G_rowwise_carries_prior_to_bayes_cone: 2 executable occurrences
  regPsi_le_* structural-field occurrences: present in multiple structures

The “0 sorries” point is not good news. It means the claimed “10 narrow TODOs inside derived theorems” are not present in this uploaded appendix. Their mathematical load has instead been carried by fields, axioms, or already-closed theorem bodies.

A. No regPsi_le_X_integral structural fields remain

Verdict: FAIL.

Executable structural fields remain. Direct hits:

v9_appendix.lean:1530  BinaryCapstoneData.regPsi_le_binaryIntegrand_integral
v9_appendix.lean:1697  FBNFFoliationData.regPsi_le_fiber_integral
v9_appendix.lean:1949  FBNFPackage.regPsi_le_fiber_integral
v9_appendix.lean:2387  P2StarHyp.regPsi_le_jam_minus_eta_integral
v9_appendix.lean:2806  P4Hyp.regPsi_le_reflectionBalance_integral
v9_appendix.lean:2891  VariableMarginP2Hyp.regPsi_le_densityCap_minus_eta_integral
v9_appendix.lean:3009  GraphFBNFPackage.regPsi_le_graphEdgeIntegrand_integral
v9_appendix.lean:3130  AffineMLRSingleCrossingPrimitive.regPsi_le_singleCrossingIntegrand_integral
v9_appendix.lean:3207  PolyhedralScalarizablePrimitive.regPsi_le_polyhedralFacetIntegrand_integral

They are not merely theorem names. They are fields on structures. Downstream proofs then consume them directly, for example:

v9_appendix.lean:5769  exact pkg.regPsi_le_fiber_integral y
v9_appendix.lean:5920  exact data.regPsi_le_binaryIntegrand_integral y
v9_appendix.lean:6188  hyp.regPsi_le_jam_minus_eta_integral y
v9_appendix.lean:6414  hyp.regPsi_le_reflectionBalance_integral y
v9_appendix.lean:7125  hyp.regPsi_le_densityCap_minus_eta_integral y
v9_appendix.lean:7243  pkg.regPsi_le_graphEdgeIntegrand_integral y

So the Phase 12a to 12h claim is not reflected in the uploaded Lean artifact.

B. No G_rowwise_carries_prior_to_bayes_cone structural field on RegPackage

Verdict: FAIL.

The field is still present on RegPackage:

v9_appendix.lean:1278-1280
  G_rowwise_carries_prior_to_bayes_cone :
    ∀ s m' : model.M, m' ∈ G s →
      model.inclM s ∈ bayesConeFromPrior (model.inclM m')

The file even labels it as “NOT DERIVED” and as a “STANDING STRUCTURAL ASSUMPTION” in the surrounding comment block. It is later used to prove:

v9_appendix.lean:1354
  exact reg.G_rowwise_carries_prior_to_bayes_cone s m' hm'

There is no executable occurrence of G_eq_rowwiseBayesMinimizers. The Phase 12i claim is therefore false for this file.

This is especially serious because the project’s own prior reviewer flagged conclusion-like fields as trapdoors and required theorem conclusions to be stated directly, not tucked into structures. 

v9_consolidated

C. No PsiNonpos_of_regPackage calls in P-class capstones

Verdict: PASS, but only on the literal string check.

After comment stripping, there are no executable calls to PsiNonpos_of_regPackage.

The visible capstones do route through per-class lemmas:

P2:              PsiNonpos_of_P2StarHyp
P3:              PsiNonpos_of_P3Hyp
P4:              PsiNonpos_of_P4Hyp
Binary B6:       PsiNonpos_of_BinaryCapstoneData
FBNF F4:         PsiNonpos_of_FBNFPackage
VariableMargin:  PsiNonpos_of_VariableMarginP2Hyp
GraphFBNF:       PsiNonpos_of_GraphFBNFPackage

But this is a surface-level pass. Those per-class lemmas still consume structural upper-bound fields, so the mathematical shortcut moved one room over. The hallway is clean; the cellar still has goblin footprints.

D. HYPOTHESIS_AS_PAPER_DERIVATION findings

Verdict: FAIL.

Substantive derivation results remain bundled as hypotheses.

Examples:

BinaryCapstoneData.regPsi_le_binaryIntegrand_integral
FBNFPackage.regPsi_le_fiber_integral
P2StarHyp.regPsi_le_jam_minus_eta_integral
P4Hyp.regPsi_le_reflectionBalance_integral
VariableMarginP2Hyp.regPsi_le_densityCap_minus_eta_integral
GraphFBNFPackage.regPsi_le_graphEdgeIntegrand_integral
AffineMLRSingleCrossingPrimitive.regPsi_le_singleCrossingIntegrand_integral
PolyhedralScalarizablePrimitive.regPsi_le_polyhedralFacetIntegrand_integral

These are not primitive economic assumptions like “radial symmetry,” “finite graph,” “tie discipline,” or “bounded density.” They are already-integrated inequalities of the exact form needed to prove PsiNonpos. That is paper-derivation material packaged as class data.

P3 also still carries theorem-shaped algebra as structural data:

v9_appendix.lean:2614  lp.regPsi_eq_finite
v9_appendix.lean:2638  encodeDual_eval_eq

Those may be concrete finite-form equations rather than Prop trapdoors, but they are still nontrivial derivation bridges that the instantiator supplies instead of the theorem proving them. Given the zero-gap standard, these should be derived lemmas, or explicitly marked as external finite-encoding assumptions with narrow TODOs.

E. SMUGGLED_UNIVERSAL_HELPER findings

Verdict: FAIL.

The named Phase 12a helper regPsi_nonpos_of_calibrated_kernel is not present in the uploaded file. So I cannot verify the claimed “common calibrated-kernel pattern” at all.

Instead, the uploaded file has a different universal bypass:

RegPackage still assumes G_rowwise_carries_prior_to_bayes_cone.

RegPackage.source_in_rowwise_bayes_cone is derived from that field.

Hall-biconditional uses reg.message_in_bayes_cone and reg.source_in_rowwise_bayes_cone to prove the support-function bounds.

The most worrying point is inside Hall-biconditional:

v9_appendix.lean:5330-5332
  hCalLoadBearing := hCal

v9_appendix.lean:5366-5369
  hCal_alpha := hαTau_ac.ae_le hCalLoadBearing

v9_appendix.lean:5402
  have hmem : model.inclM m ∈ reg.B m := reg.message_in_bayes_cone m

v9_appendix.lean:5446-5447
  have hmem : model.inclM s ∈ reg.B m' :=
    reg.source_in_rowwise_bayes_cone s m' hm'

v9_appendix.lean:5542
  have _hCalUsed := hCal_alpha

hCal_alpha is syntactically “used” only by assigning it to _hCalUsed; the actual inequalities are discharged by RegPackage membership facts. That is not genuine per-class construction of a calibrated kernel. It is a calibration-shaped universal helper hiding in regularity data.

The project documents explicitly frame the Hall/cone calibration as the central nontrivial object, not something to smuggle into RegPackage. They also state that the unrestricted theorem is not proved under standing assumptions alone, and that the cone-Hall biconditional is a classification theorem under regularity. 

v9_consolidated

F. 9 axioms

Verdict: PARTIAL PASS on count, FAIL on the stronger provenance claim.

The executable axiom count in v9_appendix.lean is 9:

v9_appendix.lean:93    clarke_danskin_stationarity
v9_appendix.lean:112   clarke_fermat_normal_cone
v9_appendix.lean:151   strassen_marginals
v9_appendix.lean:177   bogachev_kernel_factorization
v9_appendix.lean:211   farkas_lp_duality_conic
v9_appendix.lean:234   hausdorff_alexandroff_continuous_surjection
v9_appendix.lean:457   Inventory.V9.clarke_product_normal_cone_projection_generic
v9_appendix.lean:4474  Inventory.V9.kantorovich_rubinstein_scalar_duality_generic
v9_appendix.lean:4656  Inventory.V9.barycenter_of_supported_measure_in_closed_convex_generic

There are also 2 opaque external objects:

v9_appendix.lean:43  ClarkeSubdiff
v9_appendix.lean:49  ClarkeNormalCone

The count “9 axioms” matches the prompt. But I would not certify “all paper-cited textbook externals” from this file alone. Several are textbook-style external imports, but not all are cited by the Robust Trust paper itself. The source-proof brief expected new Inventory axioms to have precise statements, citations, and Mathlib-coverage justifications. 

source_proof

 The uploaded appendix has improved over the earlier arbitrary-Prop trapdoor style, but the provenance ledger still needs a theorem-by-theorem axiom citation audit.

Classification:

Acceptable external shape:
  Clarke-Danskin / Clarke-Fermat
  Strassen
  Farkas / conic LP
  Bogachev kernel factorization
  Hausdorff-Alexandroff, if actually used
  Kantorovich-Rubinstein scalar duality

Needs extra scrutiny:
  clarke_product_normal_cone_projection_generic
  barycenter_of_supported_measure_in_closed_convex_generic

Those last two are broad and generic enough that they may be legitimate, but they are doing real mathematical lifting. I would require a short axiom ledger entry for each: exact statement, textbook theorem, and why Mathlib cannot currently supply it.

G. 10 v9 sorries

Verdict: FAIL / mismatch.

The uploaded v9_appendix.lean has 0 executable sorrys after comment stripping.

So I cannot list “10 narrow TODOs inside derived theorems,” because they are not in this file. This is a direct mismatch with the stated Phase 12 state.

What I found instead:

v9_appendix.lean:
  executable sorry count: 0
  structural derivation fields: many
  axioms: 9

The prompt’s “10 v9 sorries” may refer to a different file, a later generated artifact, or imported code not uploaded here. But for the file named in the request, the claim is false.

This is not merely an accounting issue. If the intended architecture was “leave 10 substantive theorem bodies as TODOs,” then the uploaded file did the opposite: it closed the theorem bodies by assuming the hard derivation lemmas as fields. That is the wrong kind of zero-gap. It is a sealed jar with the dragon still inside.

Per-section summary
A. regPsi_le_X_integral structural fields removed?        FAIL
B. G_rowwise_carries_prior field removed?                 FAIL
C. No PsiNonpos_of_regPackage calls in capstones?          PASS, literal only
D. Hypothesis-as-paper-derivation remaining?              FAIL
E. Smuggled universal helper / bypass?                    FAIL
F. 9 axioms, all paper-cited textbook externals?           PARTIAL
G. 10 narrow v9 sorries?                                  FAIL
Required patches before acceptance

Actually remove the regPsi_le_* fields from BinaryCapstoneData, FBNFPackage, P2StarHyp, P4Hyp, VariableMarginP2Hyp, GraphFBNFPackage, and the affine/polyhedral primitive structures.

Introduce theorem-level derivations for each removed field. If the paper derivation is not yet formalized, leave the sorry inside that theorem body, not inside a structure field.

Remove G_rowwise_carries_prior_to_bayes_cone from RegPackage. Add the promised primitive G_eq_rowwiseBayesMinimizers, then prove the rowwise-carries lemma from it and the Bayes-cone definitions.

Fix Hall-biconditional so hCal is load-bearing. A dummy _hCalUsed := hCal_alpha should not count. The support-function bounds must be derived from the calibrated kernel/posterior condition, not from pre-installed RegPackage cone membership.

Restore the claimed 10 narrow TODOs as actual theorem-body sorrys, or prove them. Do not close those gaps by moving their conclusions into hypothesis packages.

Update the axiom ledger. The count is 9, but each axiom needs a provenance line: theorem name, source/reference, exact mathematical role, and why it is external rather than part of the Lean proof.

Final verdict: REJECT for Phase 12 zero-gap. The architecture still has structural derivation fields and a RegPackage calibration shortcut.