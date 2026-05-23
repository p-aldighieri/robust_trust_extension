
========
ROLE: user (id=c0c56b9a-5061-412f-8ced-41a63a9aadd9)
========
ROLE — Lean ↔ v9 paper per-theorem verification auditor. Extended Pro (gpt-5.5-pro-xhigh).# Contextv9 formalization at zero sorries, 9 paper-cited axioms. Verify per-theorem.# Batch C — Binary block (6 theorems)Audit:1. **«binary-L_B1-endpoint-fiber-lift»** (v9_appendix.lean ~L2827)2. **«binary-L_B2-TRS-interval-reduction»** (~L2858)3. **«binary-L_B3-endpoint-only-projected-image»** (~L2871)4. **«binary-L_B4-interior-message-calibration»** (~L2892)5. **«binary-L_B5-endpoint-stationarity-total-balance»** (~L2926)6. **«binary-L_B6-capstone»** (~L4517)v9 paper §B.3 / exposition_v9.tex §8 covers the Binary capstone |Ω|=2 under R-EE + R-TD + R-IES.# Audit per theorem1. Quote Lean signature + proof body.2. Quote v9 paper English statement + proof (v9_consolidated.md §B.3, individual L_Bi subsections).3. Translation, Smuggling, Verdict per theorem.Special focus:- **B5**: was previously smuggled via scalar equality fields. Now derived via FiniteMenuData.normalized_sum_one + field arithmetic at k=2. Verify the derivation is honest and matches v9 §B.3 L_B5 (the Clarke–Danskin Fermat with k=2 active labels → integral total-balance equations).- **B6 capstone**: uses BinaryCapstoneData.regBridge + PsiNonpos_of_regPackage + Hall biconditional + bridge. Verify this matches v9 §B.3 L_B6 (capstone assembles B1+B3+B5 + B2/B4 inputs into HasRobustRationalizableStrategy).# Output formatPer theorem as in Batch A. End with batch verdict.
Show more

========
ROLE: assistant (id=390c1c23-b434-435b-9bd5-5823637f5641)
========
Batch C audit summary

I inspected /mnt/data/v9_appendix.lean directly for the actual Lean bodies. I also checked the v9 English sources. One bookkeeping note: the uploaded v9_consolidated.md §B.3 is a consolidated binary-capstone block, not a file with separately headed L_B1–L_B6 subsections. The separately named English lemma statements/proofs are in exposition_v9_paper.tex §“Binary capstone”; I quote those below and cross-check them against the consolidated §B.3 statement that the binary capstone assumes |Ω|=2, α∈(0,1), endpoint exposure, tie discipline, and interior endpoint stationarity, then constructs endpoint-fiber kernels and q-a.e. calibrated posteriors. 

v9_consolidated

I did not run lake build; no Lean toolchain was available in the container. This is a source-level theorem/proof-body audit.

1. «binary-L_B1-endpoint-fiber-lift»
Lean quote
lean
theorem «binary-L_B1-endpoint-fiber-lift»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hBalance : data.endpointStationarityTotalBalance) :
    data.endpointFiberLift := by
  classical
  have hBalance :
      IsEndpointStationarityTotalBalance
        (endpointMenuLhsL data.endpointMenu) (endpointMenuRhsL data.endpointMenu)
        (endpointMenuLhsR data.endpointMenu) (endpointMenuRhsR data.endpointMenu) := by
    simpa [BinaryCapstoneData.endpointStationarityTotalBalance] using _hBalance
  have hDominance :
      _root_.Inventory.V9.StrassenMarginalDominance
        model.τM model.τM data.endpointRelation :=
    data.endpointDominanceFromBalance hBalance
  obtain ⟨π, hπ_coupling, hπ_support⟩ :=
    _root_.Inventory.V9.strassen_marginals
      model.τM model.τM data.endpointRelation hDominance
  have _hEndpointCoupling :
      _root_.Inventory.V9.IsCoupling π model.τM model.τM := hπ_coupling
  have _hEndpointSupport : π data.endpointRelationᶜ = 0 := hπ_support
  unfold BinaryCapstoneData.endpointFiberLift IsEndpointFiberLift
  exact ⟨data.cL_nonneg, data.cR_nonneg,
    data.endpointMassCalibrationFromBalance hBalance⟩
v9 paper quote

exposition_v9_paper.tex states:

“Let p∈[0,1], A
−
	​

⊆M∩(−∞,p], and S
+
	​

⊆M∩[p,∞) be Borel. Define

η(X)=α∫
X∩A
−
	​

	​

(p−m)τ(dm),ν(Y)=(1−α)∫
Y∩S
+
	​

	​

(s−p)τ(ds).

If η(A
−
	​

)=ν(S
+
	​

)<∞, then there is a Borel kernel κ:S
+
	​

→Δ(A
−
	​

) such that for all Borel X⊆A
−
	​

,

(1−α)∫
S
+
	​

	​

(s−p)κ(X∣s)τ(ds)=α∫
X
	​

(p−m)τ(dm).

The resulting mixture posterior equals p for q-a.e. message in A
−
	​

, provided no other sources send extra mass into A
−
	​

. The symmetric statement holds on A
+
	​

⊆M∩[p,∞) with sources S
−
	​

⊆M∩(−∞,p].”

Proof quote:

“Normalize η and ν when their common mass is positive; any coupling between the normalized measures exists on standard Borel spaces, and disintegration over S
+
	​

 gives κ. If the common mass is zero, any kernel into a nonempty target works. The displayed balance rearranges to

α∫
X
	​

mdτ+(1−α)∫
S
+
	​

	​

sκ(X∣s)dτ=p[ατ(X)+(1−α)∫
S
+
	​

	​

κ(X∣s)dτ],

which is exactly n(X)=pq(X) for all Borel X⊆A
−
	​

. Hence dn/dq=p on A
−
	​

.”

This is also the consolidated §B.3 content: endpoint fibers A
L
	​

=[0,L]∩M, A
R
	​

=[R,1]∩M, endpoint-balance equations, kernels κ
L
	​

,κ
R
	​

, and q-a.e. endpoint posterior identities. 

v9_consolidated

Translation

The paper’s B1 is a genuine scalar transport lemma. It needs a kernel from surplus sources into an endpoint fiber, a no-extra-traffic condition, and a posterior identity P
β
∗
	​

(⋅∣m)=p q-a.e. on the whole endpoint fiber.

The Lean theorem invokes strassen_marginals, but the final predicate IsEndpointFiberLift is only:

lean
0 ≤ cL ∧ 0 ≤ cR ∧ α * cL + (1 - α) * cR = 1

The Strassen coupling π and support proof are produced, then discarded. The conclusion records scalar nonnegativity and one scalar calibration identity, not the existence of the Borel endpoint-fiber kernels nor the q-a.e. posterior identity.

Smuggling

Major under-specification. The Lean theorem’s target is much weaker than B1’s English statement. The actual kernel/posterior content is not in the conclusion. Some needed content is hidden in data.endpointDominanceFromBalance and data.endpointMassCalibrationFromBalance, but even with those fields the theorem does not expose the paper’s kernel or posterior result.

Verdict

PATCH_BIG. No sorry, and the Strassen call is not fake, but the theorem does not formalize B1 as stated in the v9 paper. It proves a scalar calibration shell, not the endpoint-fiber lift.

2. «binary-L_B2-TRS-interval-reduction»
Lean quote
lean
theorem «binary-L_B2-TRS-interval-reduction»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model) :
    data.trsIntervalReduction := by
  unfold BinaryCapstoneData.trsIntervalReduction IsTRSIntervalReduction
  exact ⟨data.lL_nonneg, data.lL_le_rR, data.rR_le_one⟩
v9 paper quote

exposition_v9_paper.tex states:

“Assume ∣Ω∣=2 and identify beliefs with m∈[0,1]. The paper’s trust-region theorem gives an optimal TRS with connected trust region, hence an interval T=[L,R].”

The consolidated binary block likewise says that with binary beliefs identified with [0,1], the optimal trust region is T
∗
=[L,R], and the robustly rationalizable strategy is 
σ
^
∗
(m)=ρ
W
	​

(w
∗
(Π
[L,R]
	​

(m))). 

v9_consolidated

Translation

The paper’s B2 is the binary specialization of the trust-region theorem: connected trust region plus one-dimensional belief space implies an interval TRS, with a clipped continuation map.

The Lean theorem only proves numeric interval well-formedness:

lean
0 ≤ lL ∧ lL ≤ rR ∧ rR ≤ 1

It does not prove optimality, TRS structure, connectedness, or that the agent’s continuation is the clipped TRS induced by [L,R].

Smuggling

The theorem is a bookkeeping lemma, not the paper’s interval reduction. The actual TRS content is assumed in the BinaryCapstoneData fields. The proof does not use paper Theorem 1, v8 TRS machinery, or any clipping/projection fact.

Verdict

PATCH_BIG. Correct as an interval-bound lemma; not faithful to B2’s mathematical content.

3. «binary-L_B3-endpoint-only-projected-image»
Lean quote
lean
theorem «binary-L_B3-endpoint-only-projected-image»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hTRS : data.trsIntervalReduction) :
    data.endpointOnlyProjectedImage := by
  unfold BinaryCapstoneData.endpointOnlyProjectedImage
    IsEndpointOnlyProjectedImage
  intro m
  have hm := data.proj_eq_endpoint m
  by_cases hside : data.projSide m
  · left
    simpa [hside] using hm
  · right
    simpa [hside] using hm
v9 paper quote

exposition_v9_paper.tex states:

“For a binary TRS with trust interval [L,R], the projected adversarial payoff image is endpoint-supported:

\min_{\mu\in[L,R]}s\cdot w^*(\mu) =\min\{s\cdot w^*(L),s\cdot w^*(R)\}. \]”

Proof quote:

“Let V(x)=max
w∈W
	​

[(1−x)w
0
	​

+xw
1
	​

]. Then V is convex. If w
∗
(μ) supports V at μ, its slope d(w
∗
(μ))=w
1
∗
	​

(μ)−w
0
∗
	​

(μ) lies in ∂V(μ). The row payoff can be written as

s⋅w
∗
(μ)=V(μ)+(s−μ)d(w
∗
(μ)).

Monotonicity of subgradients of a convex function implies that every interior supporting line is dominated, for minimization, by at least one endpoint supporting line.”

This matches the v9 audit language that B3 is a projected-image statement, not literal singleton-message support: endpoint-fiber wording matters. 

decomposition

Translation

The paper proves a convex-analysis fact: for any source belief s, minimizing over the whole interval is equivalent to minimizing over the two endpoint payoff profiles.

The Lean theorem proves only that data.proj is pointwise either pL or pR, using the data field:

lean
proj_eq_endpoint : ∀ m, proj m = if projSide m then pL else pR

The TRS hypothesis _hTRS is unused.

Smuggling

Yes. The endpoint-only image is assumed directly as proj_eq_endpoint. The proof does not formalize the convex/subgradient domination argument, nor connect proj to rowwise adversarial minimization.

Verdict

PATCH_BIG. The naming patch to “projected image” is good, but the proof is tautological over a field that already contains the endpoint-only conclusion.

4. «binary-L_B4-interior-message-calibration»
Lean quote
lean
theorem «binary-L_B4-interior-message-calibration»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hTRS : data.trsIntervalReduction)
    (_hEndpoint : data.endpointOnlyProjectedImage) :
    data.interiorMessageCalibration := by
  have hTRS :
      IsTRSIntervalReduction data.lL data.rR := by
    simpa [BinaryCapstoneData.trsIntervalReduction] using _hTRS
  have hEndpoint :
      IsEndpointOnlyProjectedImage model data.pL data.pR data.proj := by
    simpa [BinaryCapstoneData.endpointOnlyProjectedImage] using _hEndpoint
  unfold BinaryCapstoneData.interiorMessageCalibration
    IsInteriorMessageCalibration
  -- Discharge via the structural primitive `post_eq_inclM_on_interior`
  -- bundled in `BinaryCapstoneData`.  This field is NOT a smuggled
  -- conclusion of the L_B4 theorem in isolation — `BinaryCapstoneData`
  -- already carries `post` and `interior` as data fields, so the
  -- calibration identity `post m = inclM m` on interior messages is a
  -- *structural hypothesis* on those data fields (the §B.3/L_B4
  -- packaging of the TRS + endpoint-only-image binary-simplex algebra
  -- lemma).  The TRS + endpoint-only hypotheses `hTRS, hEndpoint`
  -- are recorded for paper-traceability (`_ := hTRS`; `_ := hEndpoint`).
  let _hTRS_ := hTRS
  let _hEndpoint_ := hEndpoint
  exact data.post_eq_inclM_on_interior
v9 paper quote

exposition_v9_paper.tex, in the binary capstone proof, states:

“For q-a.e. interior message m∈(L,R)∩M, the adversary sends no extra mass there, so the posterior is m and the TRS is Bayes-optimal at m.”

The consolidated §B.3 says the same: interior messages m∈(L,R)∩M are calibrated truthfully, P
β
∗
	​

(⋅∣m)=m q-a.e. 

v9_consolidated

Translation

The paper argument is: endpoint-only projected image means the adversary routes to endpoint fibers, so interior messages receive only aligned truthful traffic. Therefore Bayes’ rule gives posterior equal to the literal message.

The Lean theorem proves:

lean
∀ m, interior m → post m = inclM m

by exact use of data.post_eq_inclM_on_interior.

Smuggling

Direct conclusion-as-field. The theorem’s own comment openly says the calibration identity is a structural hypothesis. That may be acceptable as a data-package invariant, but it is not a Lean derivation of L_B4 from B2+B3.

Verdict

FAIL as a proof of L_B4; PASS only as a projection from prepackaged data. The paper’s proof step is not formalized.

5. «binary-L_B5-endpoint-stationarity-total-balance»
Lean quote
lean
theorem «binary-L_B5-endpoint-stationarity-total-balance»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hT1 : ∀ k (fd : FiniteMenuData model k), fd.multiplierBayesCone)
    (_hTRS : data.trsIntervalReduction)
    (_hEndpoint : data.endpointOnlyProjectedImage)
    (_hIES : data.interiorEndpointStationarity) :
    data.endpointStationarityTotalBalance := by
  -- Phase 4 cleanup (2026-05-22): B5 is now closed via the T1 mass-balance
  -- identity carried by `FiniteMenuData.normalized_sum_one`.  The previous
  -- `binary_lhsL_rhsL_eq` and `binary_lhsR_rhsR_eq` scalar equality fields
  -- (which were the B5 conclusion conjuncts in disguise) have been removed
  -- from `BinaryCapstoneData`.
  --
  -- Derivation: at the binary `endpointMenu : FiniteMenuData model 2` with
  -- both endpoint labels active (`endpointMenu_q0_pos`, `endpointMenu_q1_pos`
  -- guarantee `0 < q i` for `i ∈ {0, 1}`), the T1 normalization step
  -- `normalized_sum_one i` gives `∑ ω, g i ω / q i = 1`, which rearranges
  -- to `∑ ω, g i ω = q i`.  This is the §B.3/L_B5 mass-balance identity
  -- at `k = 2`, and matches the two scalar identities
  -- `endpointMenuLhsL endpointMenu = endpointMenuRhsL endpointMenu` and
  -- `endpointMenuLhsR endpointMenu = endpointMenuRhsR endpointMenu`.
  --
  -- The T1 hypothesis `_hT1` and the v9 §B.3 inputs `_hTRS`, `_hEndpoint`,
  -- `_hIES` are recorded for paper-traceability; the mechanical derivation
  -- uses only the mass-balance identity on the menu data.
  let _hT1_ := _hT1
  let _hTRS_ := _hTRS
  let _hEndpoint_ := _hEndpoint
  let _hIES_ := _hIES
  unfold BinaryCapstoneData.endpointStationarityTotalBalance
    IsEndpointStationarityTotalBalance
  -- Mass balance from T1 normalization: ∑ ω, g i ω = q i for i ∈ {0, 1}.
  have hMassBalance :
      ∀ i : Fin 2, 0 < data.endpointMenu.q i →
        (∑ ω : model.Ω, data.endpointMenu.g i ω) = data.endpointMenu.q i := by
    intro i hqi
    -- From `normalized_sum_one`: ∑ ω, g i ω / q i = 1 (when q i > 0).
    have hnorm : (∑ ω : model.Ω, data.endpointMenu.g i ω / data.endpointMenu.q i) = 1 :=
      data.endpointMenu.normalized_sum_one i hqi
    have hqne : data.endpointMenu.q i ≠ 0 := ne_of_gt hqi
    -- Convert ∑(g/q) = 1 to ∑g = q via field arithmetic.
    -- ∑ ω, g i ω / q i = (∑ ω, g i ω) / q i
    have hSumDiv :
        (∑ ω : model.Ω, data.endpointMenu.g i ω / data.endpointMenu.q i) =
          (∑ ω : model.Ω, data.endpointMenu.g i ω) / data.endpointMenu.q i := by
      rw [Finset.sum_div]
    have hSumDivEq :
        (∑ ω : model.Ω, data.endpointMenu.g i ω) / data.endpointMenu.q i = 1 := by
      rw [← hSumDiv]; exact hnorm
    -- Multiply both sides by q i.
    have := congrArg (· * data.endpointMenu.q i) hSumDivEq
    simp only at this
    rw [div_mul_cancel₀ _ hqne, one_mul] at this
    exact this
  refine ⟨?_, ?_⟩
  · -- Left endpoint mass balance: endpointMenuLhsL = endpointMenuRhsL.
    unfold endpointMenuLhsL endpointMenuRhsL
    exact hMassBalance 0 data.endpointMenu_q0_pos
  · -- Right endpoint mass balance: endpointMenuLhsR = endpointMenuRhsR.
    unfold endpointMenuLhsR endpointMenuRhsR
    exact hMassBalance 1 data.endpointMenu_q1_pos
v9 paper quote

exposition_v9_paper.tex states:

“Under Assumption [Binary regularity], the optimal trust interval satisfies

α∫
[0,L]∩M
	​

(L−m)τ(dm)=(1−α)∫
S
+
	​

	​

(s−L)τ(ds),
α∫
[R,1]∩M
	​

(m−R)τ(dm)=(1−α)∫
S
−
	​

	​

(R−s)τ(ds),

where S
+
	​

 is the high-source region whose projected minimizer is L and S
−
	​

 is the low-source region whose projected minimizer is R.”

Proof quote:

“Apply the finite-menu stationarity theorem to the two active endpoint labels. Endpoint exposure identifies the Bayes cones with the singleton endpoint beliefs. Tie discipline removes active-minimizer ambiguity on a positive-measure set. Interior stationarity gives equality rather than a one-sided Kuhn–Tucker inequality. The normalized posterior condition at the left label is p=L, which rearranges to [left balance]; the right endpoint is symmetric.”

The decomposition summary says exactly this should be the B5 route: restrict endpoint perturbations to two active labels, apply T1/L6–L8, use interior endpoint stationarity for equality, translate multiplier Bayes-cone calibration into scalar moment equations, and identify those with total endpoint-fiber balance. 

decomposition

Translation

The Lean body really does remove the old scalar equality fields. It proves:

ω
∑
	​

g
i
	​

(ω)=q
i
	​


from normalized_sum_one i hqi and field arithmetic. That part is clean. Tiny algebra gremlin slain.

But the theorem does not apply _hT1. It stores it in a local unused binding. It also does not use _hTRS, _hEndpoint, or _hIES. The content that should come from T1, endpoint exposure, tie discipline, and interior stationarity is already embedded in:

lean
data.endpointMenu.normalized_sum_one
data.endpointMenu_q0_pos
data.endpointMenu_q1_pos
endpointMenuLhsL/RhsL/LhsR/RhsR

The definitions of the endpoint-balance sides are also abstracted to:

lean
endpointMenuLhsL m := ∑ ω, m.g 0 ω
endpointMenuRhsL m := m.q 0
endpointMenuLhsR m := ∑ ω, m.g 1 ω
endpointMenuRhsR m := m.q 1

So the Lean proof proves “normalized vector sums to one implies vector numerator mass equals scalar mass,” not the paper’s integral stationarity equations unless g and q have already been proven to be exactly those integrals.

Smuggling

Improved, but still not fully honest. The previous scalar equality fields are gone, which is a real improvement. The remaining hidden load is now in FiniteMenuData.normalized_sum_one and in the interpretation of endpointMenu.g/q as the Clarke–Danskin endpoint integrals. Since _hT1 is unused, the theorem is not deriving normalization from the universal finite-menu theorem at this call site.

Verdict

PATCH_BIG, with one clean sub-verdict.
Arithmetic sublemma: PASS.
Paper-level B5 theorem: PATCH_BIG. To match v9 §B.3, the proof needs to actually instantiate _hT1 2 data.endpointMenu, extract the normalized posterior/Bayes-cone conclusion, and connect g/q to the displayed endpoint integrals.

6. «binary-L_B6-capstone»
Lean quote
lean
theorem «binary-L_B6-capstone»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hB1 : data.endpointFiberLift)
    (_hB2 : data.trsIntervalReduction)
    (_hB3 : data.endpointOnlyProjectedImage)
    (_hB4 : data.interiorMessageCalibration)
    (_hB5 : data.endpointStationarityTotalBalance) :
    HasRobustRationalizableStrategy model data.pd := by
  classical
  -- Phase 3b derivation (2026-05-22): apply the F4 template via the
  -- structural primitive `data.regBridge : RegPackage model`.  The
  -- binary geometric hypotheses `_hB1`-`_hB5` document why the
  -- binary capstone's regularity package's Reg-2 structural
  -- primitives suffice to deliver `PsiNonpos`; the actual
  -- derivation routes through `PsiNonpos_of_regPackage` and the
  -- Hall biconditional + kernel→strategy bridge.
  have _hBinaryGeometry :
      data.endpointFiberLift ∧ data.endpointOnlyProjectedImage ∧
        data.endpointStationarityTotalBalance :=
    ⟨_hB1, _hB3, _hB5⟩
  have _hTRSCalibration :
      data.trsIntervalReduction ∧ data.interiorMessageCalibration :=
    ⟨_hB2, _hB4⟩
  set reg := data.regBridge with hreg_def
  have hPsi : PsiNonpos model reg := PsiNonpos_of_regPackage reg
  have hKernel : reg.robustRationalizableKernelExists :=
    («Hall-biconditional» reg).mpr hPsi
  have hStrat : HasRobustRationalizableStrategy model reg.pd :=
    robustRationalizableKernelExists_to_strategy reg hKernel
  have hpd : reg.pd = data.pd := by
    simpa [hreg_def] using data.regBridge_pd_eq
  rw [← hpd]
  exact hStrat
v9 paper quote

exposition_v9_paper.tex states the capstone theorem:

“Under the standing hypotheses, ∣Ω∣=2, α∈(0,1), and [Binary regularity], there exists a robustly rationalizable optimal strategy for arbitrary M and compact metric Θ.”

Proof quote:

“Let the optimal TRS be

σ
^
∗
(m)=ρ
W
	​

(w
∗
(Π
[L,R]
	​

(m))).

By [Binary endpoint image], the adversarial projected payoff image is endpoint-supported. By [Binary endpoint stationarity], the two balances are exactly the hypotheses of [Binary endpoint-fiber lift]. Apply [Binary endpoint-fiber lift] on the left fiber with p=L, A
−
	​

=[0,L]∩M, and source region S
+
	​

; apply its symmetric version on the right fiber with p=R, A
+
	​

=[R,1]∩M, and source region S
−
	​

. Paste the two kernels and send tie-null leftovers arbitrarily.

For q-a.e. interior message m∈(L,R)∩M, the adversary sends no extra mass there, so the posterior is m and the TRS is Bayes-optimal at m. On the left endpoint fiber the posterior is L; on the right endpoint fiber it is R. Endpoint exposure gives Bayes-optimality there. The kernel is supported on rowwise minimizers, so it is adversarial. Definition [RR] holds q-a.e.”

This is also the consolidated §B.3 claim: endpoint-fiber kernels calibrate left and right fibers, interior messages calibrate truthfully, and therefore 
σ
^
∗
(m) is Bayes-optimal under the induced posterior q-a.e. 

v9_consolidated

 The decomposition also says B6 should build the adversarial kernel from left/right/interior clauses, use B3 for adversariality, B1 for endpoint calibration, B4 for interior calibration, and conclude Definition 2 q-a.e. 

decomposition

Translation

The Lean B6 does not assemble the left/right endpoint-fiber kernels. It does not paste kernels. It does not use B1/B2/B3/B4/B5 computationally. It bundles them into two unused witnesses:

lean
_hBinaryGeometry
_hTRSCalibration

Then it obtains robust rationalizability through:

lean
reg := data.regBridge
hPsi := PsiNonpos_of_regPackage reg
hKernel := («Hall-biconditional» reg).mpr hPsi
hStrat := robustRationalizableKernelExists_to_strategy reg hKernel

That is exactly the route the user flagged: regBridge + PsiNonpos_of_regPackage + Hall biconditional + bridge.

Smuggling

The route is logically valid if data.regBridge already contains a correct RegPackage encoding the binary construction. But as a verification of the binary capstone, it is too indirect and too strong. regBridge and PsiNonpos_of_regPackage are doing the work that the paper says B1+B3+B5+B2/B4 should do.

In particular, the theorem does not force regBridge to be constructed from _hB1 through _hB5; it merely assumes data.regBridge exists and has the right posterior-disintegration equality. The code comments say the binary hypotheses “document why” the package suffices, but Lean does not use them to build or validate the package.

Verdict

PATCH_BIG. The Hall-biconditional route is a plausible capstone architecture, but this theorem as written proves: “given a RegPackage bridge with Ψ nonpositive, Hall gives a strategy.” It does not prove the paper’s B6 assembly from the binary lemmas.

Batch verdict

Batch C verdict: PATCH_BIG.

The source has zero visible sorries inside the six binary theorem bodies, and the B5 arithmetic cleanup is a real improvement: the old direct scalar equality fields are gone. The binary theorem ledger also records that the intended binary capstone chain had reviewer PASS after endpoint-fiber/RN patches. 

v9_consolidated

But the Lean layer is still too shallow relative to the v9 paper:

B1 proves only a scalar mass identity, not endpoint-fiber kernel existence plus q-a.e. posterior calibration.

B2 proves only interval bounds, not TRS interval reduction.

B3 assumes endpoint-only projection through proj_eq_endpoint.

B4 directly returns post_eq_inclM_on_interior.

B5 honestly performs the new normalized_sum_one arithmetic, but does not actually use _hT1, _hTRS, _hEndpoint, or _hIES; the integral stationarity content is packed into endpointMenu.

B6 routes through data.regBridge and a generic Hall bridge, not through a construction from B1+B3+B5 plus B2/B4.

So the formalization currently verifies a prepackaged binary RegPackage skeleton, not the full per-theorem v9 paper proof. The next patch should make BinaryCapstoneData.regBridge a derived construction from B1–B5, or weaken the Lean theorem names to say explicitly that they are field-unpackers over a binary package rather than formal proofs of the paper lemmas.
