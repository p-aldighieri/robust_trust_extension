ROLE — Lean Smuggling Auditor. PHASE 4c final confirmation audit.

# Context

v9 state after Phase 4 + 4b + 4c:
- 0 v9 sorries in v9_appendix.lean
- 9 Inventory.V9 axioms
- Build PASS via `lake build MathlibStarter.V9Main` (8264 jobs, exit 0)

Fixes applied since Phase 3:
1. **B5 genuinely derived** (Phase 4): scalar equality fields REMOVED; `endpointMenuLhsL/RhsL/LhsR/RhsR` are `noncomputable def`s computed from `endpointMenu.g`, `endpointMenu.q`; theorem body derives mass-balance from `FiniteMenuData.normalized_sum_one` + field arithmetic at k=2.
2. **Clarke product axiom genericized** (Phase 4): now `clarke_product_normal_cone_projection_generic` over indexed product of normed spaces `∀ i : ι, E i`; bridge lemma instantiates for v9.
3. **KR axiom restated** (Phase 4b): `kantorovich_rubinstein_scalar_duality_generic` now has concrete typed vector-Hall hypothesis (V finite, incl : X → V → ℝ, σ : X → (V → ℝ) → ℝ, α ∈ [0,1], with the integral inequality as the hypothesis). The arbitrary `(hVectorHall : Prop)` trapdoor is REMOVED.
4. **Build fixes** (Phase 4c): Fintype instance disambiguation; `unfold regPsi beliefDot` for `rfl`.
5. **Bogachev barycenter** RETAINED in v9-shape, documented in docstring as future-work refactor target.

# Pre-accepted (per user 2026-05-22 evening):
- RegPackage's `message_in_bayes_cone` and `source_in_rowwise_bayes_cone` faithfully encode v9 paper §B.7 P2* standing hypothesis ("truthful messages sit uniformly inside their Bayes cones").
- `regBridge : RegPackage` fields on capstone packages (FBNFPackage, BinaryCapstoneData, GraphFBNFPackage) are legitimate structural hypothesis bundling (Reg-1+Reg-2 encoded as a data field).
- `bayesian_barycenter_in_closed_convex` v9-shape acknowledged in docstring; future-work refactor flagged in TODO_FUTURE_WORK.md.

# Audit task

Adversarially verify:

A. **B5 derivation honest** — theorem body uses real arithmetic from FiniteMenuData.normalized_sum_one, not field projection. No scalar equality fields remain.

B. **Clarke product axiom genuinely generic** — signature over indexed product `∀ i : ι, E i` of normed spaces, not v9-specific types.

C. **KR axiom genuinely generic without trapdoor** — Lean signature uses generic measurable space X (or standard Borel), finite type V, typed vector-Hall integral inequality (NOT arbitrary Prop). Verify the new hVectorHall is a concrete typed statement involving μ, ν, R, incl, σ, α.

D. **Bridge lemmas honest** — clarke_product_normal_cone_projection_bridge and kantorovich_rubinstein_scalar_bridge derive from the generic axioms (not just `exact axiom_call`).

E. **Bogachev barycenter** — docstring honestly documents v9-shape and future-work plan.

F. **No new smuggling** — sweep file for any new `axiom` / `opaque` / cert-verifier fields / function-fields / arbitrary Prop carriers.

# Output

Per `8b_lean_smuggling_check_soft.md`. Final verdict:
- Clean: YES / NO
- Severity: NONE / LOW / MEDIUM / HIGH / CRITICAL
- Per-fix verdict (A through F).
- Recommendation: ACCEPT / further work.

NOTE: do NOT re-flag the pre-accepted items (regBridge, RegPackage Reg-2 primitives, Bogachev v9-shape). Focus on whether the Phase 4 fixes are CLEAN.
