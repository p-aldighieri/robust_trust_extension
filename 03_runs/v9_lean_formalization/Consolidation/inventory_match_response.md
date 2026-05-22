INVENTORY MATCH AUDIT - VERDICT: TRAPDOOR_FOUND

I could not retrieve or inspect v9_appendix.lean itself in the exposed workspace, so I cannot honestly provide line citations to that Lean file. The audit below is therefore a best-effort inventory-match audit against the visible v9 source brief, decomposition, review, and refinement artifacts. The declared expected inventory is clear: v8 reuses measurable_argmax_selector, krn_borel_right_inverse, and kernel_infimum_epsilon_selection, while the new v9 external axioms are Clarke-Danskin, Strassen, Farkas/conic LP, Hausdorff-Alexandroff, and Clarke-Fermat, with Berge marked as something to check before axiomatizing. The source brief also requires each new Inventory axiom to have a precise Lean statement, citation, and Mathlib-coverage justification. 

source_proof

For each axiom in Inventory.V9:

Name: Inventory.V9.clarke_danskin_stationarity

Standard form: Clarke 1990 §2.7, Clarke-Danskin envelope theorem for locally Lipschitz pointwise suprema. Expected Lean shape: locally Lipschitz envelope, concrete active set, compactness/measurability of the active set, differentiability of active branches, and conclusion that a Clarke subgradient lies in the closed convex hull of active gradients.

Lean signature seen in available scaffold: ClarkeDanskinHyp had fields locallyLipschitz : Prop, compactActiveSet : Prop, and danskinRepresentation : Prop, and the axiom concluded ∃ ξ ∈ Candidates, ξ ∈ ClarkeSubdiff F x. 

decomposition

Assessment: TRAPDOOR, also UNDERSTATED relative to the declared Clarke-Danskin dependency. The hypothesis fields are arbitrary Props, and the conclusion does not expose the active-gradient convex-hull representation. The review explicitly flags ClarkeDanskinHyp arbitrary Prop fields as a theorem-shaped trapdoor. 

decomposition_review_response

Where consumed in v9_appendix.lean: not verifiable. In the visible decomposition it is consumed by T1-L6-integral-clarke-danskin-representation, then feeds T1/L7/L8. 

decomposition

Fix target: the refined statement gives concrete active-set, Lipschitz, derivative, and convex-hull fields, with conclusion ξ ∈ closure (convexHull ℝ (grad '' Active)) ∧ ξ ∈ ClarkeSubdiff F x. 

structural_refinement_response

Name: Inventory.V9.clarke_fermat_normal_cone

Standard form: Clarke 1990 Fermat rule for a locally Lipschitz function on a closed feasible set. At a constrained local maximum, every Clarke subgradient gives the corresponding normal-cone inclusion, with sign convention for maximization.

Lean signature seen in available scaffold: the axiom takes (hLocalMax : Prop) and returns -ξ ∈ ClarkeNormalCone C x, with no concrete local-maximum predicate, no closedness hypothesis, and no local Lipschitz hypothesis. 

decomposition

Assessment: TRAPDOOR, also UNDERSTATED. The arbitrary Prop local-maximum hypothesis lets the caller inject the hard condition without mathematical structure.

Where consumed in v9_appendix.lean: not verifiable. In the visible decomposition it is consumed by T1-L7-clarke-fermat-stationarity, and later inherited by binary/FBNF stationarity steps. 

decomposition

Fix target: the refined statement replaces hLocalMax : Prop with ClarkeLocalMaxOn F C x, plus IsClosed C and a concrete local Lipschitz condition. 

structural_refinement_response

Name: Inventory.V9.strassen_marginals

Standard form: Strassen 1965 / Kantorovich-Rubinstein support-constrained coupling theorem. Given finite measures with equal mass and a measurable relation R, a dual marginal inequality implies existence of a coupling supported on R.

Lean signature seen in available scaffold: StrassenMarginalDominance had only dualInequality : Prop; the axiom conclusion was a concrete coupling with mapped marginals and π Rᶜ = 0. 

decomposition

Assessment: TRAPDOOR. The conclusion is concrete, but the hypothesis structure is arbitrary Prop.

Where consumed in v9_appendix.lean: not verifiable. In the visible decomposition it is consumed by B1/FBNF transport and Hall G2c. Binary/FBNF capstones inherit it through endpoint-fiber lift and measurable pasting. 

decomposition

 

decomposition

Fix target: the refined statement gives concrete fields measurable_R, finite measures, equal total mass, and a dual inequality over measurable integrable price functions, with conclusion IsCoupling π μ ν ∧ π Rᶜ = 0. 

structural_refinement_response

Name: Inventory.V9.farkas_lp_duality_conic

Standard form: finite-dimensional conic Farkas theorem, ∃ x ≥ 0, A x = b iff every linear separator nonpositive on the columns is nonpositive on b.

Lean signature seen in available scaffold: ConicFarkasInstance had primalFeasible : Prop and dualNonpositive : Prop; the axiom states inst.primalFeasible ↔ inst.dualNonpositive. 

decomposition

Assessment: TRAPDOOR. This is the clearest trapdoor: it proves an equivalence between two arbitrary propositions.

Where consumed in v9_appendix.lean: not verifiable. In the visible decomposition it is consumed by finite cone-Hall G1 and G4 finite-facet LP threshold. 

decomposition

 

decomposition

Fix target: the refined statement uses a concrete finite matrix A : I → J → ℝ, vector b : I → ℝ, primal feasibility ∃ x, 0 ≤ x ∧ A x = b, and a concrete dual no-separation predicate. 

structural_refinement_response

Name: Inventory.V9.hausdorff_alexandroff_continuous_surjection

Standard form: Hausdorff-Alexandroff theorem, Kechris 1995 Thm 4.18 style: for compact Hausdorff second-countable K, there exists a continuous surjection from Cantor space to K.

Lean signature expected:

lean
∃ f : CantorSpace → K, Continuous f ∧ Function.Surjective f

Lean signature seen in the available decomposition, not necessarily current v9_appendix.lean: the visible scaffold already had the concrete conclusion above. 

decomposition

Assessment: if the current v9_appendix.lean conclusion is bare Prop, then TRAPDOOR exactly as suspected. If it has the visible concrete conclusion, then MATCHES in shape, possibly OVERSTATED if CompactSpace K, T2Space K, and SecondCountableTopology K are stronger than the actual use needs.

Where consumed in v9_appendix.lean: not verifiable. In the visible decomposition it is listed as “Cantor canvas / atomless construction” and not in the current four-item v9 theorem ledger. 

decomposition

 

lean_state

Assessment on use: UNUSED + likely not even referenced, based on the visible ledger. This should be removed from Inventory.V9 unless the Cantor-canvas theorem is actually present in v9_appendix.lean.

Name: Inventory.V9.berge_maximum_set_valued

Standard form: Berge maximum theorem / maximum correspondence theorem. For compact-valued correspondences with closed graph and continuous objective, argmax exists and the value/argmax correspondence has the usual continuity/measurability properties.

Lean signature seen in available scaffold: an axiom returning bare Prop. 

decomposition

Assessment: TRAPDOOR and OVERFULL if present. The review says to remove it because the axiom returns a bare Prop and compact argmax/argmin existence should be proved from Mathlib lemmas such as IsCompact.exists_isMaxOn / IsCompact.exists_isMinOn. 

decomposition_review_response

Where consumed in v9_appendix.lean: not verifiable. The refined patch explicitly says do not keep BergeMaximumHyp or berge_maximum_set_valued. 

decomposition

Status: should be REMOVED, not classified as a missing dependency.

Missing dependencies (declared but not in Inventory.V9):

Cannot be certified without the actual v9_appendix.lean.

From the visible v9 theorem ledger, only four Inventory axiom slugs are listed: Clarke-Danskin, Clarke-Fermat, Strassen, and Farkas. Hausdorff-Alexandroff is not listed there. 

lean_state

If hausdorff_alexandroff_continuous_surjection is absent from the actual Inventory.V9, then MISSING_FOUND.

berge_maximum_set_valued is not missing. It is intentionally removed.

The three v8 axioms belong in Inventory.*, not Inventory.V9, and the source brief names them as reusable v8 inventory items. 

source_proof

OVERALL

Inventory.V9 completeness: UNDERFULL if Hausdorff-Alexandroff is absent; otherwise COMPLETE but with dead/unused Hausdorff risk.

Inventory.V9 overfullness: OVERFULL if berge_maximum_set_valued is present.

Inventory.V9 soundness: TRAPDOOR-CONTAINING if the old scaffold signatures are present, especially ConicFarkasInstance with arbitrary Prop fields, StrassenMarginalDominance.dualInequality : Prop, and ClarkeDanskinHyp arbitrary Prop fields. The decomposition reviewer explicitly calls these theorem-shaped trapdoors. 

decomposition_review_response

Mergeable as declared-dependency-faithful: NO.

Confidence: LOW for literal v9_appendix.lean line audit, because that file was not available to inspect. HIGH for the trapdoor classification of the visible inventory scaffold and for the required replacement shapes.

One-paragraph summary: The visible v9 inventory layer is not yet declared-dependency-faithful. Clarke-Danskin, Clarke-Fermat, Strassen, and Farkas are legitimate external dependencies in principle, but the old Lean scaffolding packages them through arbitrary Prop fields, which turns them into trapdoors rather than standard mathematical hammers. Berge must be removed rather than patched, and Hausdorff-Alexandroff must have the concrete Cantor-space continuous-surjection conclusion or it is also a trapdoor. The repaired direction is already sketched in the structural refinement: concrete Clarke hypotheses, concrete Strassen dual dominance, concrete finite conic Farkas, and no Berge axiom.