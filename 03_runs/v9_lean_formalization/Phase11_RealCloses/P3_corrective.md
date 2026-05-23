ROLE — Lean 4 / Mathlib prover, Phase 11 P3 corrective. Opus.

# Mission

Previous P3 refactor round introduced the 6-sub-structure design but:
1. INTRODUCED 2 NEW sorries in auxiliary lemmas (`P3_Psi_le_finiteConeHall`, `P3_finiteConeHall_dual_nonpos`).
2. KEPT legacy Prop trapdoor fields (`polyhedralW`, `finiteVertexMenu`, `positiveConeMargin`, `finiteLPFeasible`) on P3Hyp "for compatibility".

User policy: ZERO smuggling. The 2 new sorries are just relocated smuggle; the legacy Prop fields are explicit trapdoors.

# Tasks

## 1. Close `P3_Psi_le_finiteConeHall` sorry (Borel → finite reduction)

The hypothesis structure has atomic-finite-support: `finite_support_exact : ∀ᵐ x, m (label x) = x`. This means the measure τM is supported on the finite image of `m`. So `∫ f dτM = ∑_j τmass j · f (m j)` (with proper measurability handling).

Use Mathlib's discrete measure integration:
- `MeasureTheory.integral_finset` (if τM is supported on a Fintype)
- `MeasureTheory.integral_eq_sum_of_countable` for atomic case
- Or directly via `Measure.dirac_eq` decomposition (since each atom is a Dirac at `m j`)

Specifically: derive `τM = ∑ j, τmass j • Measure.dirac (m j)` from the atomic-finite-support hypothesis. Then `∫ f dτM = ∑ j, τmass j • f (m j)` by `integral_dirac` + sum.

Once this is proven, the regPsi → finiteConeHallPsi inequality follows by substituting `y(m j) = compressP3Price hyp y j` and the bayes-cone consistency from `reg_B_eq`/`reg_G_eq`.

If the Mathlib API requires more setup (atomic measure ↔ Dirac sum), use `Measure.sum_smul_dirac` or build it from `Measure.ofFinset`.

## 2. Close `P3_finiteConeHall_dual_nonpos` sorry (Farkas dual ↔ finite Ψ)

The Farkas axiom gives `conicDualNonpositive farkasInst` — i.e., for the encoded dual matrix, all dual values nonpositive. We need to identify this with `finiteConeHallPsi hyp Y ≤ 0`.

The encoding: `encodeP3Dual Y` maps each Y-vector to a Farkas dual vector. Then `dual_eval_eq_finitePsi` (currently sorry'd) says `conicDualEval farkasInst (encodeP3Dual Y) = finiteConeHallPsi hyp Y`.

This MUST be a definitional algebra lemma (per briefing), not black-box. To prove:
- Unfold `encodeP3Dual` and `conicDualEval` (both should be concrete matrix-vector products).
- Compute both sides in coordinates.
- They equal by direct algebra (no choice / no axioms).

If the encoding isn't yet concrete, refactor to make it definitional: `encodeP3Dual hyp Y := ⟨..vector built from Y, hyp.cones.g, hyp.cones.c, hyp.menu.μ, hyp.routing.allowed..⟩`. Then `conicDualEval` of this is a sum-of-products that should match `finiteConeHallPsi` definitionally.

If pure `rfl` doesn't work, use `simp [encodeP3Dual, conicDualEval, finiteConeHallPsi]` + `ring` / `Finset.sum_congr`.

## 3. Remove legacy Prop trapdoors

Currently `P3Hyp` retains `polyhedralW`, `finiteVertexMenu`, `positiveConeMargin`, `finiteLPFeasible` as Prop fields. The downstream theorem `«P3-polyhedral-cone-margin»` may depend on their old shape.

Two options:
- (a) **REMOVE** these fields. Update downstream call sites to use the new sub-structures' content (or compute the Props from sub-structures: e.g., `polyhedralW := True` is just packaging; replace with `(hyp.polyW.W_eq, hyp.polyW.W_compact, ...)`).
- (b) **REPLACE** each Prop with a definitional alias: e.g., `polyhedralW := hyp.polyW.W_eq` (a concrete proposition with concrete content).

Either approach: do NOT keep abstract Prop placeholders. The reviewer's smuggling-check will catch these.

## 4. Verify the build + audit

Verify `lake build MathlibStarter.V9Main` exit 0. Then OPTIONALLY refresh sources + spot-check `PsiNonpos_of_P3Hyp` chain has zero hidden sorries via `#print axioms` if Lean supports it.

# Constraints (BLOCKING)

- Build MUST PASS exit 0.
- ZERO sorries in v9_appendix.lean OR a strict NET DECREASE from baseline (6 sorries → 4 sorries: close 2 P3-related sorries, keep PsiNonpos_of_P2StarHyp/P4Hyp/VarMargin/GraphFBNF/FBNF unchanged).
- NO new axioms (Inventory.V9 stays at 9).
- NO new smuggling.
- NO legacy Prop trapdoors on P3Hyp.
- Edit lean/v9_appendix.lean + sync V9Main.lean.
- Cap 8 iterations.

# Output

Concise report under 500 words: build status (exit code), sorry count (target 4 if both P3 closed, 5 if only one), axiom count (target 9), legacy Prop scrub summary, two auxiliary lemma proof summaries.
