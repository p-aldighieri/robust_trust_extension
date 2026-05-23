According to the v9 Lean decomposition/review documents from 2026-05-22, I cannot complete the literal quote + line-number part: v9_appendix.lean is not present in the uploaded workspace, and searches for the nine axiom names did not surface the Lean file or exact axiom bodies. So the “statement quote” fields below are marked UNAVAILABLE rather than invented. The classification is still possible from the axiom names, cited sources, and v9 proof ledger.

The important policy hook is clear: v9 itself treats binary/FBNF/P2*/P3/P4/G4/G3 as proof blocks and conditional/classification theorems, not external textbook imports. The v9 source says the package is OBJECTIVE_NARROWED, with real restrictions, and gives a dependency graph in which binary, FBNF, Hall/G3, P2*/P3/P4, and G4 are derived proof blocks. 

v9_consolidated

Audit results
9. bayesian_barycenter_in_closed_convex

Line in v9_appendix.lean: unavailable. v9_appendix.lean was not present in the uploaded files, so I cannot quote the exact Lean statement.

Cited source: Bogachev 2007 Vol. II §11.7.

Statement type analysis: This is the only Phase-1-new axiom that plausibly belongs in Inventory.V9. A theorem of the form “the barycenter / Bochner integral of a probability measure supported in a closed convex set lies in that closed convex set” is a standard external measure/convexity theorem. It is not v9-specific if stated generically over a locally convex or finite-dimensional vector space and closed convex set.

Verdict: KEEP, with a guardrail. Keep only if the actual Lean statement is a generic barycenter-in-closed-convex theorem. If the missing Lean statement is specialized to Robust Trust primitives, adviser posterior support, or a particular v9 posterior law, it should be downgraded to smuggled.

Replacement needed: None if generic. If specialized, replace with a generic Bogachev-style theorem plus a short v9 instantiation lemma.

10. binary_T1_to_endpoint_balance

Line in v9_appendix.lean: unavailable. No exact Lean quote available.

Cited source: v9_consolidated.md §B.3 / L_B5.

Statement type analysis: This is v9’s binary endpoint-balance lemma, not an external theorem. The Lean decomposition states binary-L_B5-endpoint-stationarity-total-balance with assumptions data.trsIntervalReduction, data.endpointOnlyImage, data.interiorEndpointStationarity, and a T1 multiplier/Bayes-cone input, concluding data.endpointStationarityTotalBalance. Its proof outline explicitly says to restrict endpoint perturbations, apply T1/L6-L8, use interior endpoint stationarity, translate multiplier calibration into scalar moment equations, and identify those equations with endpoint-fiber balance. 

decomposition

Verdict: SMUGGLED.

What the v9 proof actually does: It derives endpoint balance from:

binary TRS interval reduction,

endpoint-only projected adversarial image,

the finite-menu Pareto-Hall/T1 multiplier calibration,

Clarke-Danskin/Fermat stationarity,

interior endpoint stationarity to turn KKT inequalities into equalities.

Lean replacement: Make it a theorem, probably binary_T1_to_endpoint_balance, outside Inventory.V9, depending on the proved T1 theorem and binary hypotheses. The only external axioms it should consume are genuine nonsmooth-analysis hammers such as Clarke-Danskin and Clarke-Fermat, already classed as textbook-style Inventory dependencies.

11. binary_capstone_to_QAE

Line in v9_appendix.lean: unavailable. No exact Lean quote available.

Cited source: v9_consolidated.md §B.3 / L_B6.

Statement type analysis: This is the binary capstone itself, i.e., a v9 theorem yielding robust rationalizability / QAE. The v9 memo says the binary capstone proves a full infinite-M,Θ existence result in the binary-state subclass, conditional on endpoint exposure, tie discipline, and interior endpoint stationarity; it also describes the actual adversarial construction via endpoint fibers and q-a.e. posterior calibration. 

v9_consolidated

 The decomposition’s binary-L_B6-capstone has the capstone conclusion after B1-B5 and explicitly builds the adversarial kernel, verifies rowwise adversariality, endpoint posterior calibration, interior calibration, endpoint exposure, and Bayes optimality. 

decomposition

Verdict: SMUGGLED.

What the v9 proof actually does: It assembles:

B1 endpoint-fiber lift, using coupling/disintegration/Strassen-style measure transport,

B2 binary TRS interval reduction,

B3 endpoint-only projected image,

B4 interior message calibration,

B5 endpoint stationarity/balance,

endpoint exposure and Bayes optimality.

Lean replacement: Prove binary_capstone_to_QAE as a theorem after B1-B5. Do not keep it in Inventory; its conclusion is exactly the v9 capstone goal. 🧨

12. fbnf_capstone_to_QAE

Line in v9_appendix.lean: unavailable. No exact Lean quote available.

Cited source: v9_consolidated.md §F4.

Statement type analysis: This is the FBNF capstone theorem. The v9 ledger states that FBNF derives the capstone by F2 endpoint-supported fiber image ⇒ F3 localized stationarity ⇒ F1 conditional B1 + pasting ⇒ F4 capstone, and notes FBNF is a constructive positive capstone under its own primitive hypotheses. 

v9_consolidated

 The FBNF conclusion in v9 is explicitly a v9-specific robust-rationalizability theorem under FBNF-1..5, local two-sided perturbability, and FBNF-7; it even describes the constructed adversarial kernel and q-a.e. posterior identities. 

v9_consolidated

Verdict: SMUGGLED.

What the v9 proof actually does: It uses:

F1 conditional B1 measurable pasting along fibers,

F2 endpoint-supported fiber image,

F3 localized stationarity deriving fiberwise total balance,

FBNF-7 global fiber dominance,

endpoint-fiber posterior calibration,

fiberwise endpoint exposure and interior Bayes optimality.

The decomposition says F4 uses F1 to produce a global Borel adversarial kernel, F2 plus global dominance to get true rowwise minimizers, F3 for balance, then verifies q-a.e. posterior calibration and Bayes optimality. 

decomposition

Lean replacement: Prove as FBNF-F4-capstone or a wrapper theorem, not as an axiom. Keep only Strassen/coupling, KRN/disintegration, and Clarke tools as Inventory-level dependencies.

13. psi_nonpos_from_cone_margin_p2_star

Line in v9_appendix.lean: unavailable. No exact Lean quote available.

Cited source: v9_consolidated.md §B.5.P2*.

Statement type analysis: This is a v9 sufficient-condition theorem, not a textbook theorem. P2* says cone margin plus bounded rowwise jamming plus enough aligned baseline imply Ψ≤0, which then feeds the Hall biconditional. The v9 hypothesis ledger classifies P2* as a meaningful narrowing with added regularity and primitive assumptions, not an external theorem. 

v9_consolidated

Verdict: SMUGGLED.

What the v9 proof actually does: It proves a posterior-displacement estimate:

truthful messages sit inside their Bayes cones with a margin,

adversarial target traffic is density-controlled,

aligned mass keeps the mixture posterior inside B(m),

therefore the cone-Hall functional satisfies Ψ≤0,

the Hall biconditional gives robust rationalizability.

The decomposition states this proof route directly for P2-star-cone-margin-bounded-jamming: use cone margin, bound displacement by jamming-density cap, keep posterior inside the Bayes cone, deduce Ψ≤0, apply Hall. 

decomposition

Lean replacement: Prove as a lemma/theorem in the P2* module. Do not hide the displacement estimate in Inventory.

14. psi_nonpos_from_polyhedral_p3

Line in v9_appendix.lean: unavailable. No exact Lean quote available.

Cited source: v9_consolidated.md §B.5.P3.

Statement type analysis: This is v9’s polyhedral finite-facet LP sufficient condition. It is not an external theorem. The external dependency is finite conic Farkas / LP duality, but the reduction from Robust Trust P3 hypotheses to Ψ≤0 is bespoke.

Verdict: SMUGGLED.

What the v9 proof actually does: It:

represents Bayes cones by finitely many facet inequalities,

encodes aligned and rowwise-minimizer cells by masses and means,

reduces Ψ≤0 to a finite LP feasibility condition,

uses finite conic Farkas/LP duality as the external hammer.

The decomposition’s G4/P3 proof outline says the finite-facet theorem represents Bayes cones with finite facets, encodes cells as finite masses and means, shows Ψ≤0 iff the finite-facet inequalities are feasible, and uses Farkas only for the finite conic equivalence. 

decomposition

Lean replacement: Keep farkas_lp_duality_conic as the external Inventory axiom, if stated concretely. Prove psi_nonpos_from_polyhedral_p3 from the finite-facet LP theorem.

15. psi_nonpos_from_radial_antipodal_p4

Line in v9_appendix.lean: unavailable. No exact Lean quote available.

Cited source: v9_consolidated.md §B.5.P4.

Statement type analysis: This is a v9-specific constructive calibration theorem for radial/antipodal models. The Robust Trust paper has a spherical example and antipodal intuition, but the precise proposition “P4 primitives imply Ψ≤0” is a v9 derivation, not a textbook theorem. The v9 memo describes P4 as a primitive sufficient class with radial/equivariant assumptions and a constructed kernel; it is a real restriction, not an external dependency. 

v9_consolidated

Verdict: SMUGGLED.

What the v9 proof actually does: It:

uses radial/equivariant primitives,

constructs an antipodal boundary-routing kernel,

verifies scalar radial balance,

shows the constructed kernel is primal-feasible,

invokes the Hall/cone-Hall machinery to get Ψ≤0.

The structural refinement explicitly shows the P4 theorem route: prove Ψ-nonpositivity from radialTau, utilityEquivariant, antipodalKernelConstructed, and scalarRadialBalance, then apply the Hall biconditional. 

structural_refinement_response

Lean replacement: Prove a P4 theorem. If using the paper’s spherical calculation, cite it as mathematical source material for the radial geometry, but do not leave the full P4-to-Ψ bridge as Inventory.

16. psi_nonpos_from_variable_margin

Line in v9_appendix.lean: unavailable. No exact Lean quote available.

Cited source: v9_consolidated.md §G.P2*'.

Statement type analysis: This is a Section G v9.2 sharpening of P2*. It is plainly v9-internal. It turns a uniform cone-margin sufficient condition into a variable-margin version.

Verdict: SMUGGLED.

What the v9 proof actually does: It:

replaces a uniform cone radius by a Borel-positive margin η(m),

uses a local adversarial target-density cap,

bounds posterior displacement pointwise by η(m),

keeps the posterior in B(m) q-a.e.,

applies the Hall biconditional.

The decomposition review explicitly says the variable-margin proof needs the adversarial target marginal controlled relative to truthful mass, with the corrected density direction dρ/dτ, and treats this as a patchable v9 proof obligation rather than an external theorem. 

decomposition_review_response

Lean replacement: Prove after P2*. It should be a local-density/displacement lemma plus Hall invocation, not an Inventory axiom.

17. graph_FBNF_to_QAE

Line in v9_appendix.lean: unavailable. No exact Lean quote available.

Cited source: v9_consolidated.md §G6_G.

Statement type analysis: This is the finite-graph FBNF capstone, i.e., a new v9 theorem. It is not a primitive and not an external textbook result. The graph-FBNF material adds a finite graph / 1-skeleton scalarization with Kirchhoff node balance and endpoint-fiber pasting. Searcher 07 says raw P6 is not enough; only patched P6
G
 with node balance, endpoint-supported minimization, Borel chart/overlap consistency, and cross-arc dominance is meaningful. 

searcher_07_response

Verdict: SMUGGLED.

What the v9 proof actually does: It:

applies B1 edgewise on affine graph arcs,

uses Kirchhoff node balance to make endpoint deficits/surpluses match at shared vertices,

pastes kernels through the finite Borel graph chart,

uses cross-arc dominance to ensure edgewise minimizers are global minimizers,

verifies Definition 2 q-a.e.

The prover record states exactly this proof strategy for P6
G
: arc-wise B1, Kirchhoff balance, measurable graph pasting, cross-arc dominance, and q-a.e. Definition 2 verification. 

prover_19_response

Lean replacement: Prove as G-addendum-P6_G-finite-graph-FBNF or graph_FBNF_to_QAE, with graph primitives as hypotheses. External dependencies should be only B1’s measure/coupling tools plus selection/disintegration hammers.

Overall count

KEEP: 1 / 9
SMUGGLED: 8 / 9

The only keepable new axiom is bayesian_barycenter_in_closed_convex, and only if its missing Lean statement is genuinely generic. Everything cited to v9_consolidated.md is the v9 paper proving its own theorem garden. Those should be Lean theorems, not Inventory.V9 axioms.

Severity

CRITICAL.

The zero-sorry state is not trustworthy if eight v9-internal theorem/capstone bridges are parked in Inventory. The most dangerous ones are binary_capstone_to_QAE, fbnf_capstone_to_QAE, and graph_FBNF_to_QAE, because their conclusion type is essentially the target QAE/robust-rationalizability conclusion. The review materials already warned against theorem-shaped trapdoors and conclusion-carrying structures: axioms with arbitrary Prop fields or capstone conclusions hidden as fields are “not external hammers” but “theorem-shaped trapdoors.” 

decomposition_review_response

Recommended Phase 2b plan

First, remove the eight smuggled axioms from Inventory.V9. Reintroduce them as named theorems in RobustTrustV9, with their proof dependencies explicit. Keep the Inventory namespace for genuine external hammers only: Clarke-Danskin/Fermat, Strassen-style coupling, Farkas/conic LP, KRN/right-inverse selection, and possibly the generic Bogachev barycenter theorem.

Second, prove in dependency order:

Binary chain: prove binary_T1_to_endpoint_balance from T1 + binary TRS/endpoint-image/interior-stationarity, then prove binary_capstone_to_QAE from B1-B5.

FBNF chain: prove F2, F3, F1, then fbnf_capstone_to_QAE. Keep the endpoint-fiber wording, Borel chart/quotient consistency, FBNF-7 global dominance, and local two-sided perturbability visible. The source is emphatic that the literal kernel spreads over endpoint fibers, not singleton endpoints. 

v9_consolidated

Hall/Psi sufficient classes: prove P2*, P3, and P4 as theorem-level sufficient classes. P3 may consume farkas_lp_duality_conic; P4 should construct the primal radial/antipodal kernel; P2* should be a displacement estimate.

Section G sharpenings: prove variable-margin P2*′ after P2*, and graph-FBNF after edgewise B1 + Kirchhoff + cross-edge dominance.

Third, rerun #print axioms on each capstone. The final axiom list should contain textbook/library gaps only. No axiom name should mention binary, capstone, QAE, psi_nonpos_from_*, P2, P3, P4, FBNF, or graph.

Finally, do not reopen the old product-topology/Sion or FOC-envelope architectures; the prior-attempt ledger records those as structurally blocked, with the product-topology route failing continuity in β and the FOC route not extending to the infinite-message problem. 

prior_attempts_digest