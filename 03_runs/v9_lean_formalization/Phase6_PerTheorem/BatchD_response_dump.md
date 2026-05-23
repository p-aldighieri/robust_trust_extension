
========
ROLE: user (id=e7f92380-fcc7-4635-9f27-8337f7fc4bbc)
========
ROLE — Lean ↔ v9 paper per-theorem verification auditor. Extended Pro.# Batch D — FBNF block (4 theorems + 3 corollaries)Audit:1. **«FBNF-F1-conditional-B1-measurable-pasting»** (~L3007)2. **«FBNF-F2-endpoint-only-projected-fiber-image»** (~L3042)3. **«FBNF-F3-localized-stationarity-FBNF6»** (~L3063)4. **«FBNF-F4-capstone»** (~L4464)5. **«FBNF-corollary-spherical-radial»** (~L4701)6. **«FBNF-corollary-affine-MLR-single-crossing»** (~L4765)7. **«FBNF-corollary-polyhedral-scalarizable»** (~L4810)v9 paper §B.4 / exposition_v9.tex §9 covers FBNF foliation + capstone for |Ω|≥3.# Audit per theoremSame protocol. Verify Lean ↔ English translation, smuggling, scope/generality.Special focus:- **F4 capstone**: uses pkg.regBridge + PsiNonpos_of_regPackage + Hall + bridge. Same pattern as B6. Verify matches v9 §F4 (assembles F1+F2+F3+FBNF-7 globalFiberDominance).- **3 corollaries**: each constructs FBNFPackage from primitive class (Spherical-radial / Affine-MLR / Polyhedral-scalarizable) and applies F4. Verify the primitive class hypotheses match v9 §11.P3/§11.P4 etc.# OutputPer theorem block + batch verdict.
Show more

========
ROLE: assistant (id=6717b364-b349-4bd7-a5c5-99828f7c6646)
========
Batch D verdict: FAIL / REVISE

The Lean FBNF block does not faithfully formalize v9 §B.4 / FBNF. The mathematical target is a constructive fibered-binary theorem: Borel affine chart or quotient-consistent foliation, endpoint-fiber transport, fiberwise stationarity, global fiber dominance, and then a q-a.e. robust-rationalizability conclusion. The source explicitly says FBNF is a primitive sufficient class, not universal, and that the adversarial kernel has endpoint-fiber support, not singleton endpoint support; posterior calibration is q-a.e. on endpoint fibers and interiors. 

v9_consolidated

The Lean block instead turns FBNF into a RegPackage bridge plus automatic Hall route. F1/F2/F3 are reduced to weak scalar or endpoint-placeholder predicates, and F4 does not substantively use them to construct the adversarial kernel. The little theorem-goblin is wearing an FBNF hat, but its passport says “generic RegPackage Hall bridge.”

A source note: I treated v9_consolidated.md / the paper exposition as the English target. The decomposition review already flags a source-integrity issue: the uploaded exposition_v9.tex in this workspace appears shorter than the locked canonical statement source, so the active statement source should be clarified. 

decomposition_review_response

1. «FBNF-F1-conditional-B1-measurable-pasting» around Lean L3007

Lean status: FAIL, underformalized.

v9 English target. F1 should disintegrate τ along the FBNF Borel chart, apply binary B1 conditionally on almost every affine fiber, paste the fiberwise kernels into a global Borel kernel, and verify endpoint-fiber posterior identities q-a.e. The decomposition summary states exactly that proof outline: disintegrate along fibers, apply B1, use quotient consistency, paste kernels, and verify endpoint-fiber posterior identities. 

decomposition

Lean translation. In v9_appendix.lean, IsConditionalB1Pasting is only:

0 ≤ wL ∧ 0 ≤ wR ∧ α * wL + (1 - α) * wR = 1

at L1507–L1509. The theorem at L3007–L3033 simply routes hB1 into pkg.fbnf_conditional_b1_pasting and returns this scalar identity. It does not construct a kernel, does not state support on endpoint fibers, and does not state posterior calibration.

Smuggling / scope. The hard measurable pasting content is not proved; it is replaced by a structural field of FBNFPackage, and the resulting theorem is weaker than the paper theorem. The “Borel chart or quotient consistency” requirement is crucial because otherwise pasted posteriors can become multivalued at overlapping messages. 

v9_consolidated

Required patch. F1’s output should be an actual global adversarial kernel, or at least a structure containing:

β*, endpoint-fiber support, no-extra-unrelated-traffic, and q-a.e. posterior identities on left endpoint fibers, right endpoint fibers, and interior messages.

2. «FBNF-F2-endpoint-only-projected-fiber-image» around Lean L3042

Lean status: FAIL, wrong endpoint object.

v9 English target. F2 should be endpoint-supported relative to the trust-band endpoints L(z), R(z): for each fiber, the minimization over T_z is attained, or selected, at ℓ_z(L(z)) or ℓ_z(R(z)). The source emphasizes that this is endpoint-supported, not a strict argmin-set inclusion unless extra no-flatness is added. 

v9_consolidated

Lean translation. IsEndpointSupportedFiberImage at L1515–L1522 says that the projection is either ell z (a z) or ell z (b z), the full fiber endpoints. There are no L(z), R(z) fields in FBNFPackage. The theorem around L3035–L3053 just applies pkg.fbnf_endpoint_supported_fiber_image hTRS.

Smuggling / scope. The statement does not encode the v9 trust-region band T_z = ℓ_z([L(z), R(z)]); it collapses “trusted endpoint” into the raw foliation interval endpoints. That is a different theorem. It can be far too strong in some models and irrelevant in others.

Required patch. Add explicit L R : Z → ℝ with a z ≤ L z ≤ R z ≤ b z, define T_z, define Π_T, and make F2 endpoint-supported with respect to ℓ_z(L z) and ℓ_z(R z).

3. «FBNF-F3-localized-stationarity-FBNF6» around Lean L3063

Lean status: FAIL, too scalar and too global.

v9 English target. F3 should derive FBNF-6 as fiberwise total-balance equations, λ-a.e. over fibers, using localized two-sided endpoint perturbations and T1/Clarke-Danskin stationarity. The source states the two balance equations explicitly and says that if two-sided perturbability fails, the correct replacement is a one-sided KKT inequality, not equality. 

v9_consolidated

Lean translation. IsLocalizedStationarityFBNF6 at L1529–L1531 is merely lhs = rhs for two global real numbers. The theorem around L3055–L3076 uses pkg.fbnf_t1_endpoint_stationarity hT1 hF2 hPert to return that equality. No fiber variable, no λ-a.e. statement, no integrals over [a_z, L(z)], [R(z), b_z], no S_+(z) / S_-(z) regions.

Smuggling / scope. The stationarity theorem is only a bookkeeping equality supplied by the package. It does not express the actual FBNF-6 content. The theorem acknowledges localTwoSidedPerturbability, but the conclusion is too weak to use in F1 as a real balance input.

Required patch. Replace fbnf6Lhs : ℝ, fbnf6Rhs : ℝ with a fiberwise balance predicate:

∀ᵐ z ∂λ, BalanceL z ∧ BalanceR z

where BalanceL/R are the two FBNF integral equations. Boundary cases should either be excluded by local two-sided perturbability or stated as one-sided KKT alternatives.

4. «FBNF-F4-capstone» around Lean L4464

Lean status: FAIL, major smuggling.

v9 English target. F4 should assemble the ingredients:

F2 plus FBNF-7 gives true global rowwise minimizers, not merely fiber-local minimizers; F3 supplies the fiberwise balances needed by F1; F1 constructs the endpoint-fiber kernel and posterior calibration; endpoint exposure and interior trust then give q-a.e. Bayes optimality. The decomposition says F4 should use F1 for the global Borel adversarial kernel, F2 plus global fiber dominance for rowwise minimizers, F3 for balances, then verify q-a.e. posterior calibration and conclude robust rationalizability. 

decomposition

Lean translation. The body around L4449–L4500 does this instead:

set reg := pkg.regBridge

packages _hF1, _hF2, _hF3, _hDom, and a positive margin into _hFBNFData

never uses _hFBNFData substantively

proves hPsi : PsiNonpos model reg := PsiNonpos_of_regPackage reg

applies Hall-biconditional

applies robustRationalizableKernelExists_to_strategy

So yes, it uses the exact pkg.regBridge + PsiNonpos_of_regPackage + Hall + bridge pattern you flagged. The problem is that this does not match v9 §F4: the FBNF data do not derive the kernel or Hall feasibility. The capstone is carried by regBridge plus an automatic Ψ proof.

Smuggling / scope. This is the main red flag. FBNFPackage now requires a regBridge : RegPackage model, and the theorem derives robust rationalizability from that bridge. That is not an FBNF capstone; it is a generic RegPackage theorem wearing FBNF robes. Worse, PsiNonpos_of_regPackage makes Ψ nonpositivity automatic for any sufficiently strong RegPackage, while v9 treats Ψ≤0 as a nontrivial Hall feasibility condition or a primitive-specific construction. The v9 ledger says FBNF is supposed to be one of the constructive positive capstones, distinct from the Hall biconditional under Reg. 

v9_consolidated

Required patch. Either:

make F4 constructive: F1 returns β*, F2+F7 prove rowwise adversariality, F3 proves balances, and F4 directly proves q-a.e. Definition 2; or

introduce a genuine lemma PsiNonpos_of_FBNFPackage whose proof uses F1, F2, F3, and FBNF-7. Do not allow PsiNonpos_of_regPackage to prove Ψ≤0 without the FBNF balance and pasting data.

5. «FBNF-corollary-spherical-radial» around Lean L4701

Lean status: FAIL as a v9 primitive corollary.

v9 English target. The radial/spherical corollary should instantiate FBNF from radial geometry: radial diameters as fibers, radial trust-ball projection, antipodal endpoint-supported routing, scalar radial balance, endpoint exposure, tie discipline, local two-sided perturbability, and global dominance. Earlier structural notes say a non-vacuous corollary must build an FBNF package from primitive geometric data and then apply F4; P4Hyp alone is not enough without bridge fields like radial diameters and radial global dominance. 

structural_refinement_response

Lean translation. The Lean construction uses:

wL := 1, wR := 1

fiberProj := fbnf_trivial_fiberProj, always the left raw fiber endpoint a_z

fbnf6Lhs := 0, fbnf6Rhs := 0

fbnf_conditional_b1_pasting := fbnf_trivial_pasting

fbnf_endpoint_supported_fiber_image := fbnf_trivial_fiberImage

fbnf_t1_endpoint_stationarity := rfl

regBridge := prim.radial.reg

This does not use radial scalar balance, antipodal routing, or actual trust-band endpoints. It stores some radial primitive fields in the package, but the live proof is powered by the trivial package pieces plus the generic F4 bridge.

Smuggling / scope. This is not a proof that spherical/radial primitives imply FBNF; it is a proof that if the radial primitive already carries a suitable RegPackage, the generic bridge can close. The “radial” geometry is mostly decorative.

Required patch. Replace the trivial wL=wR=1, fiberProj = left endpoint, and 0=0 stationarity with real radial data: radius r*(α), antipodal routing, scalar balance, and a proof that this induces the endpoint-fiber kernel and posterior calibration.

6. «FBNF-corollary-affine-MLR-single-crossing» around Lean L4765

Lean status: FAIL as a v9 primitive corollary.

v9 English target. Affine-MLR/single-crossing should provide affine fibers, fiber-preserving projection, endpoint exposure, endpoint-supported minimization, tie discipline or tie splitting, local two-sided perturbability, and global dominance from MLR order.

Lean translation. The theorem again builds a package with:

wL := 1, wR := 1

trivial left-endpoint fiberProj

fbnf6Lhs = fbnf6Rhs = 0

trivial F1/F2/F3 witnesses

regBridge := prim.reg

The fields affineMLRChart, endpointSupport_from_singleCrossing, and related primitive hypotheses are not used to prove the working F1/F2/F3 content. This is precisely the old “magic words as Props” problem the structural refinement warned against: “affine MLR” and “single crossing” are not Lean-checkable unless they include concrete chart, exposure, tie, perturbability, and dominance derivations. 

structural_refinement_response

Smuggling / scope. The theorem assumes or stores the right-sounding primitives but does not derive the corollary from them. Its actual power comes from the same generic regBridge.

Required patch. Formalize affine MLR and single crossing as data/lemmas that produce the actual FBNF fields, especially the trust-band endpoints, endpoint-supported image, endpoint exposure, and global dominance. Then apply a repaired F4.

7. «FBNF-corollary-polyhedral-scalarizable» around Lean L4810

Lean status: FAIL as a v9 primitive corollary.

v9 English target. The polyhedral-scalarizable corollary should use scalarizable Bayes faces or a finite-facet LP-style dominance certificate, plus finite-facet tie discipline or tie splitting, and two-sided perturbations on active faces. Structural refinement explicitly says the polyhedral case should use scalarizable Bayes faces or a finite-facet LP certificate, not just a finite vertex menu. 

structural_refinement_response

Lean translation. The theorem builds the same trivial package:

wL=wR=1

constant left endpoint projection

0=0 stationarity

trivial pasting and endpoint image

regBridge := prim.reg

It does not use finite-facet inequalities, tie-splitting variables, LP feasibility, or scalarized face geometry to construct the endpoint-fiber kernel.

Smuggling / scope. This is not a polyhedral-scalarizable theorem; it is a generic RegPackage theorem with polyhedral labels placed in the wrapper.

Required patch. Add the finite-facet or scalarizable-face data as concrete structures and prove the FBNF package fields from them. If using an LP certificate, connect it to endpoint-fiber balance or to a valid PsiNonpos_of_polyhedral_scalarizable lemma.

Cross-cutting issues
A. FBNFPackage lacks the real trust-band endpoints

The source target has T_z = ℓ_z([L(z), R(z)]) and endpoint posteriors ℓ_z(L(z)), ℓ_z(R(z)). 

v9_consolidated

 Lean’s Foliation has only raw interval endpoints a z, b z; FBNFPackage does not carry L(z), R(z). That forces F2 and the corollaries into the wrong endpoint vocabulary.

B. The automatic PsiNonpos_of_regPackage is too strong

The Hall route should be a classification: Ψ≤0 is the nontrivial feasibility condition. The source explicitly treats Ψ as an exact cone-Hall feasibility condition, not something automatic from standing assumptions or generic regularity. 

decomposition

 If PsiNonpos_of_regPackage is kept, RegPackage must be understood as already containing a very strong calibration-like hypothesis, close to the conclusion.

C. Endpoint-fiber support is the invariant that Lean must preserve

The source and review repeatedly warn that the literal kernel spreads over endpoint fibers; only the projected payoff image is endpoint-only. 

v9_consolidated

 Lean’s names and predicates need to distinguish “projected endpoint-only image” from “literal singleton endpoint support.” This naming is not cosmetic; it is the difference between a scalar B1 transport and a false singleton-kernel claim.

Batch verdict

Reject this batch as a faithful Lean formalization of v9 FBNF.

The mathematical v9 FBNF theorem is sound as a conditional primitive class after the endpoint-fiber, Borel-chart, and local-perturbability patches. 

sanity_chunk2_response

 But the current Lean block does not encode that theorem. It uses a generic RegPackage → PsiNonpos → Hall → strategy tunnel, while F1/F2/F3 and the three primitive corollaries are too weak or trivialized to carry the advertised content.

Minimum repair checklist:

Add L(z), R(z) and define T_z = ℓ_z([L(z), R(z)]).

Make F1 return an actual pasted kernel with endpoint-fiber support and q-a.e. posterior identities.

Make F2 endpoint-supported relative to L(z), R(z), not raw a_z, b_z.

Make F3 state λ-a.e. fiberwise balance equations.

Replace PsiNonpos_of_regPackage in F4 with PsiNonpos_of_FBNFPackage, proved from F1/F2/F3/FBNF-7, or make F4 direct and constructive.

Rebuild the three corollaries so the primitive hypotheses actually derive the FBNF package fields, not trivial placeholders.
