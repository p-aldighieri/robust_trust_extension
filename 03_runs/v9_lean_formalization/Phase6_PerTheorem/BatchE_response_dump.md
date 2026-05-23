
========
ROLE: user (id=fd3489a8-5ce9-4b1d-a854-bd2adb8656be)
========
ROLE — Lean ↔ v9 paper per-theorem verification auditor. Extended Pro.# Batch E — Hall block + WTA + G4 (7 theorems)Audit:1. **«Hall-G1-finite-cone-hall-farkas-LP»** (~L3833)2. **«Hall-G2c-borel-extension»** (~L3848)3. **«Hall-biconditional»** (~L3968)4. **robustRationalizableKernelExists_to_strategy** (~L4178)5. **«Hall-WTA-dual-certificate-psi-two-ninths»** (~L4559)6. **«Hall-WTA-reopening-threshold-D»** (~L4587)7. **«G4-finite-facet-polyhedral-LP-threshold»** (~L4599)v9 paper §B.5 / exposition_v9.tex §11 covers Hall biconditional + WTA. §13 covers G4 LP threshold.# Audit per theoremSame protocol.Special focus:- **Hall-G2c**: uses Strassen + Bogachev disintegration + KR vector-to-scalar. The Bogachev step is now bayesian_barycenter_in_closed_convex (lemma, was axiom, Phase 5A). Verify the proof body's measure-theoretic chain is honest.- **Hall biconditional**: forward direction uses PsiNonpos_of_regPackage (lemma resting on Reg-2 construction primitives). Reverse uses G2c. Verify both directions match v9 §B.5 statement.- **Hall-WTA Ψ=2/9**: pure numerical computation. Verify the WTA setup matches v9 §B.5 (Ω=Fin 3, uniform prior, α=1/2, dual prices y_j = 1-2e_j, support value 1/3, K-minus mean 1/9).- **Hall-WTA threshold D**: verify (-2αD + (1-α)(4/9) ≤ 0) ↔ (2(1-α)/(9α) ≤ D). Real proof via div_le_iff₀ + nlinarith. Verify the threshold formula matches v9 §B.5 (D ≥ 2(1-α)/(9α), corrected 2026-05-21 from prior reciprocal-form error).- **G4**: derives via Inventory.V9.farkas_lp_duality_conic. Verify polyhedral LP threshold formulation matches v9 §13.# OutputPer theorem block + batch verdict.
Show more

========
ROLE: assistant (id=b3aa6c66-f7db-4914-a3f7-94461c762a8b)
========
According to the v9 source/proof documents from 2026-05-21/22, Batch E is PATCH_NEEDED, with one material issue in the Hall biconditional fidelity and two lighter “packaging caveats” in G2c and G4. The WTA numerical block is the cleanest part of the batch.

1. «Hall-G1-finite-cone-hall-farkas-LP» around L3833

Lean shape inspected. The theorem is a direct wrapper:

lean
inst.flowFeasible ↔ inst.psiNonpos

by rewriting to

lean
Inventory.V9.conicPrimalFeasible inst.conic ↔
Inventory.V9.conicDualNonpositive inst.conic

and applying Inventory.V9.farkas_lp_duality_conic.

Paper match. This matches v9 §B.5 at the abstract LP-duality layer: finite calibrated flows exist iff the corrected cone-Hall inequality holds. The source states the corrected sign as Ψ(y) ≤ 0, not Ψ(y) ≥ 0, and explains it through the support-function inequality
y_j·n_j − h_{B_j}(y_j) q_j ≤ 0. 

v9_consolidated

Caveat. The Lean theorem proves the equivalence for a packaged FiniteConeHallInstance.conic. It does not itself unpack the finite source/message data, support sets R(i), cones B_j, and support-function formula. That is acceptable if FiniteConeHallInstance is treated as the compiled finite LP instance, but it is not a full standalone derivation of the displayed Hall inequality.

Verdict: PASS, packaged-LP level.

2. «Hall-G2c-borel-extension» around L3848

Lean shape inspected. The theorem proves

lean
PsiNonpos model reg → reg.calibratedKernelExists

by the following chain:

Defines R = {(s,m) | m ∈ reg.G s}.

Uses reg.G_closedGraph to obtain measurability.

Converts Ψ ≤ 0 into a scalar Strassen dominance condition via Inventory.V9.kantorovich_rubinstein_scalar_bridge.

Applies Inventory.V9.strassen_marginals to get a coupling π.

Applies Inventory.V9.bogachev_kernel_factorization to disintegrate π = τ ⊗ κ.

Uses π(Rᶜ)=0 and ae_compProd_iff to prove κ is supported on G.

Calls Inventory.V9.bayesian_barycenter_in_closed_convex to prove posterior calibration:
Pγα(·|m) ∈ B(m) q-a.e.

Measure-theoretic honesty. The proof does not fake the finite-partition limit. It really routes through Strassen, disintegration/factorization, support transfer on the graph, and barycenter-in-closed-convex. That is the right architecture for the compact-closed/no-escape G2c theorem, which v9 explicitly distinguishes from bare standard-Borel Hall; the source says compact M, closed graph/compact values for G, and support-function continuity are required, and that the proof works directly with measures on Gr G and disintegrates the kernel. 

v9_consolidated

Bogachev step. The current call site uses bayesian_barycenter_in_closed_convex as a lemma, not as the old direct axiom. Internally it still depends on a generic closed-convex barycenter theorem, but the Robust Trust-specific chain is now expanded: diagonal aligned mass, kernel-supported misaligned mass, source-law disintegration, pushforward to profile space, and closed-convex barycenter. That is a real improvement. One comment in the Lean block still describes it as an axiom, so the documentation should be scrubbed, but the proof body is no longer the old one-line axiom trapdoor.

Caveat. The heaviest hidden hinge is the KR vector-to-scalar bridge. The theorem is honest under the enriched RegPackage/no-escape assumptions, not a bare Borel extension. That matches the v9 claim that the unrestricted standing-only theorem remains open and that G2c is a compact-regular classification theorem. 

v9_consolidated

Verdict: PASS-MINUS. Honest measure chain, but advertise the strong regularity and KR bridge.

3. «Hall-biconditional» around L3968

Lean shape inspected. The theorem states:

lean
reg.robustRationalizableKernelExists ↔ PsiNonpos model reg

Reverse direction is clean:

lean
intro hPsi
exact «Hall-G2c-borel-extension» reg hPsi

Forward direction destructs the kernel, but then proves Ψ ≤ 0 mostly from RegPackage structural facts:

lean
reg.message_in_bayes_cone m
reg.source_in_rowwise_bayes_cone s m' hm'

and support-function inequalities. In effect, it inlines PsiNonpos_of_regPackage, rather than using the calibrated kernel’s posterior condition as the core proof.

Paper match. v9 §B.5 states the fixed-label biconditional as:

σ(w*) robustly rationalizable ⇔ Ψ_w*(y) ≤ 0 for all bounded Borel y

with reverse direction constructing a Borel kernel supported on G(s) and satisfying Pγα(·|m) ∈ B(m) q-a.e.; then β* = κ is adversarial and the continuation is Bayes-optimal q-a.e. 

v9_consolidated

Issue. The Lean forward direction is stronger than the paper’s Hall-forward argument: it derives Ψ ≤ 0 from Reg-2 construction primitives even after ignoring the actual kernel calibration _hCal. That is mathematically valid for the current strengthened RegPackage, but it weakens the theorem’s interpretation as a true Hall feasibility biconditional. If RegPackage already implies PsiNonpos, the equivalence is no longer doing all the classification work promised by §B.5.

Required patch. Either:

state this as the strengthened-RegPackage biconditional, where Reg-2 itself implies Ψ≤0, or

revise the forward proof to use the actual calibrated kernel and its q-a.e. posterior-in-cone property, matching the source proof: kernel feasibility gives the primal graph measure, and support-function inequality gives every dual price nonpositive.

Verdict: PATCH_NEEDED. Reverse direction matches; forward direction is too RegPackage-driven for the paper’s biconditional story.

4. robustRationalizableKernelExists_to_strategy around L4178

Lean shape inspected. The theorem takes

lean
h : reg.robustRationalizableKernelExists

destructs it as ⟨κ, hSupp, hCal⟩, and returns

lean
⟨κ, reg.σstar, ?adversarial, ?bayes⟩

The adversarial side is discharged through the v8 exact-contact bridge:

lean
menu_hall_support_implies_exact_adversary

using reg.G_subset_rowwiseContactG and reg.σstar_attains_UStarFull.

The Bayes-optimality side builds a v8 MenuHall, lifts hCal : Pγα κ m ∈ B m through reg.B_bayes_optimal, applies per_message_Bayes_optimality, then transfers from Pγα to Pβ using posterior_disintegration_menuHall_kernel_coincides.

Paper match. This is the right bridge from the Hall kernel to Definition 2 in the infinite-space q-a.e. reading. It matches v9’s reverse Hall story: a Borel kernel supported on rowwise minimizers plus posterior-in-Bayes-cone calibration yields exact adversariality and q-a.e. Bayes optimality. 

v9_consolidated

Caveat. It depends on the v8 ExactContact bundle and the structural premise that σstar attains UStarFull. That is fine for v9’s fixed optimal labeling / RegPackage theorem, but it should not be read as a raw-primitives existence theorem.

Verdict: PASS.

5. «Hall-WTA-dual-certificate-psi-two-ninths» around L4559

Lean shape inspected. The theorem computes

lean
wta.psiValue = 2/9

from WTAData fields:

α = 1/2,

aligned contribution 0,

h_{B_j}(y_j)=1/3,

E[s_j | s ∈ K_j^-]=1/9,

three symmetric labels.

The body first proves the averaged misaligned term is 4/9, then multiplies by (1−α)=1/2.

Paper match. This matches the user-locked WTA setup: ternary WTA, uniform geometry, y_j = 1 − 2e_j, support value 1/3, K-minus coordinate mean 1/9, and misaligned contribution 4/9. v9 records the same WTA computation and says the positive certificate violates the corrected condition Ψ≤0. 

v9_consolidated

Caveat. The theorem is a numerical certificate conditional on WTAData; it does not derive uniformity of the simplex or the conditional mean from measure geometry. That is exactly the right scope for a “pure numerical computation” lemma.

Verdict: PASS.

6. «Hall-WTA-reopening-threshold-D» around L4587

Lean shape inspected. The theorem proves:

lean
(-2 * α * D + (1 - α) * (4/9) ≤ 0)
↔
(2 * (1 - α)) / (9 * α) ≤ D

under 0 < α, using div_le_iff₀ and nlinarith.

Algebra.

−2αD+(1−α)
9
4
	​

≤0

is equivalent to

(1−α)
9
4
	​

≤2αD,

and since α>0,

D≥
9α
2(1−α)
	​

.

This is exactly the corrected formula in the user’s prompt and the locked source scope, which records WTA certificate Ψ=2/9 plus reopening threshold D ≥ 2(1−α)/(9α). 

source_proof

Important source hygiene. Some older v9 prose still contains the reciprocal-style expression 9α/(2(1−α)); the decomposition review explicitly marked that as a reciprocal-form source error and retained the Lean theorem with 2(1−α)/(9α). 

decomposition_review_response

 Treat the reciprocal text as deprecated.

Verdict: PASS.

7. «G4-finite-facet-polyhedral-LP-threshold» around L4599

Lean shape inspected. The theorem proves:

lean
inst.psiNonpos ↔ inst.lpFeasible

by rewriting to:

lean
conicDualNonpositive inst.conic ↔ conicPrimalFeasible inst.conic

and applying farkas_lp_duality_conic symmetrically.

Paper match. This matches v9 §13/G4 at the LP-duality interface: finite-facet Bayes cones and finite active cells reduce the Hall condition to a finite LP. The source’s application table states that polyhedral finite-action cases require finite active vertex menu, finite-facet Bayes cones, and closed/tie-free active cells or tie-splitting variables; the result is an iff finite LP feasibility test, with violated facets giving a dual certificate. 

v9_consolidated

Caveat. As with G1, the theorem proves the packaged conic equivalence. It does not itself prove that the concrete polyhedral cells, facet normals, aligned masses, and rowwise minimizer means have been correctly encoded into inst.conic. So the Lean theorem is a correct LP core, not a full end-to-end polyhedral modeling proof.

Verdict: PASS-MINUS.

Batch E verdict

PATCH_NEEDED, localized.

The code block is strong and mostly aligned with v9’s Hall/WTA/G4 architecture: finite G1 and G4 are valid packaged Farkas wrappers; G2c has an honest compact-closed measure/disintegration/barycenter chain; the WTA 2/9 computation and reopening threshold are correct. The source ledger itself frames G1 → G2c → G3 → G4 as the Hall classification path and records G1/G2c/G3/G4 as reviewed under their regularity hypotheses. 

v9_consolidated

The red flag is Hall-biconditional forward direction. In current Lean, Ψ≤0 is essentially derived from Reg-2 structural cone-membership primitives, not from the calibrated kernel. That can be defended as a strengthened-RegPackage theorem, but it does not faithfully realize the v9 §B.5 biconditional as an exact Hall feasibility classification unless the theorem statement is narrowed or the forward proof is rewritten to consume the kernel calibration.
