Final verdict

Clean: YES
Severity: LOW
Recommendation: ACCEPT

I audited the uploaded v9_appendix.lean structurally and adversarially. I did not rerun lake build in this workspace because only standalone Lean files were uploaded, not the Lake project, but the file-level smuggling checks line up with the reported build state.

Per-fix verdict
A. B5 derivation honest

Verdict: CLEAN.

The old scalar equality fields are gone from BinaryCapstoneData. The balance scalars are now computed by definitions:

endpointMenuLhsL/RhsL/LhsR/RhsR at lines 1147–1168, with lhs = ∑ω g i ω and rhs = q i.

BinaryCapstoneData carries endpointMenu : FiniteMenuData model 2 plus positivity assumptions endpointMenu_q0_pos and endpointMenu_q1_pos, not the target equalities, at lines 1287–1298.

The B5 theorem body at lines 2846–2907 derives:

ω
∑
	​

g
i
	​

(ω)=q
i
	​


from data.endpointMenu.normalized_sum_one i hqi, then uses Finset.sum_div, congrArg, div_mul_cancel₀, and one_mul. That is real arithmetic, not a field projection.

Minor hygiene note: the theorem records _hT1, _hTRS, _hEndpoint, _hIES for traceability but does not computationally use them. That is not smuggling under the current target because the implemented derivation is explicitly from FiniteMenuData.normalized_sum_one.

B. Clarke product axiom genuinely generic

Verdict: CLEAN.

The product axiom at lines 457–470 is genuinely generic:

lean
{ι : Type*} [Fintype ι] [DecidableEq ι]
{E : ι → Type*}
[∀ i, NormedAddCommGroup (E i)] [∀ i, NormedSpace ℝ (E i)]

It is over the indexed product ∀ i, E i, not over v9 profiles or Fin k → Profile model.

The v9 bridge at lines 481–554 instantiates it at ι = Fin k, E := fun _ => Profile model, constructs the per-factor continuous linear map n i, proves the product-set rewrite, rewrites the representation hypothesis, calls the generic axiom, and unpacks the result into NormalConeW.

This is the right shape: one generic external hammer, then a Lean bridge.

C. KR axiom genuinely generic without trapdoor

Verdict: CLEAN.

The KR axiom at lines 3070–3099 no longer has an arbitrary hVectorHall : Prop. The hypothesis is a concrete typed statement involving:

X : Type* with [MeasurableSpace X], finite measures μ ν, relation R, finite type V, typed inclusion incl : X → V → ℝ, support functional σ : X → (V → ℝ) → ℝ, and α ∈ [0,1].

The new hVectorHall quantifies over bounded measurable vector-test profiles:

lean
∀ (y : X → V → ℝ),
  Measurable y →
  (∃ C : ℝ, ∀ x v, |y x v| ≤ C) →
    α * ∫ ... ∂ν + (1 - α) * ∫ ... ∂μ ≤ 0

The relation R appears inside the sInf over { m' | (s, m') ∈ R }. This removes the old “plug in True and get scalar duality for free” trapdoor.

D. Bridge lemmas honest

Verdict: CLEAN.

The Clarke bridge at lines 481–554 is not a v9-specific axiom. It builds the discrete inner-product CLMs, rewrites the product set, rewrites the representation hypothesis, invokes the generic product axiom, then reconstructs NormalConeW.

The KR bridge at lines 3112–3224 is also honest. It defines:

R := {p | p.2 ∈ reg.G p.1},

incl s v := (model.inclM s).val v,

σ m y := supportFunction model (reg.B m) y,

then constructs the concrete hVectorHall from hPsi : PsiNonpos model reg. The key rewrite at lines 3196–3215 unfolds regPsi and beliefDot, then closes by rfl. The bridge then applies the generic KR axiom with those concrete arguments.

That is exactly the intended bridge pattern.

E. Bogachev barycenter documentation

Verdict: CLEAN, with accepted caveat.

The retained axiom at lines 3255–3261 is still v9-shaped:

lean
bayesian_barycenter_in_closed_convex
  (reg : RegPackage model)
  (κ : AdviserKernel model)
  (_hSupp : KernelSupportedOnRegG reg.G κ) :
  ∀ᵐ m ∂..., reg.pd.Pγα κ m ∈ reg.B m

The docstring at lines 3226–3254 honestly says it is the v9-belief-cone specialization of the Bogachev / Choquet barycenter theorem, explains the desired future generic refactor, and names the missing Lean-side bridge: transporting kernel support through the disintegration identity via an ae_compProd_iff-style measure argument.

Per the pre-accepted scope, this is not a blocker.

F. No new smuggling

Verdict: CLEAN for Phase 4 fixes; LOW hygiene residue outside the Phase 4 fixes.

Sweep results:

There are no actual Lean sorry proof terms. The word sorry appears only in comments/docstrings.

There are 9 Inventory.V9 axioms, matching the stated inventory surface:

clarke_danskin_stationarity, clarke_fermat_normal_cone, strassen_marginals, bogachev_kernel_factorization, farkas_lp_duality_conic, hausdorff_alexandroff_continuous_surjection, clarke_product_normal_cone_projection_generic, kantorovich_rubinstein_scalar_duality_generic, and bayesian_barycenter_in_closed_convex.

There are 2 opaque declarations, ClarkeSubdiff and ClarkeNormalCone, at lines 43 and 49. These are external mathematical objects, not theorem-shaped conclusion axioms.

No new B5 scalar equality fields were found. No arbitrary KR Prop carrier remains. No Phase 4 bridge lemma is a v9-specific axiom wearing a moustache.

One nonblocking hygiene note: WTAData.certificatePositive : Prop remains at line 1805, and Hall-WTA-dual-certificate-psi-two-ninths takes it as an unused premise at lines 4020–4023. The theorem computes ψ = 2/9 from concrete equalities, so this field is not doing proof work, but it is a small vestigial “certificate” wart. It does not affect A–E or the Phase 4 fixes.

Bottom line

The Phase 4 / 4b / 4c fixes are clean. B5 is no longer smuggled through scalar equality fields, the Clarke product axiom is genuinely generic, KR’s vector-Hall hypothesis is now typed and concrete, both bridges instantiate generic axioms rather than adding v9-specific trapdoors, and Bogachev is honestly documented as the retained v9-shaped future-work item.

Recommendation: ACCEPT.