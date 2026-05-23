ROLE — Lean Smuggling Auditor + Lean ↔ paper translation reviewer. FINAL Phase 11 verification pass.

# Context

After Phase 11 work, v9 Lean state:
- 0 v9 sorries in v9_appendix.lean.
- 9 Inventory.V9 axioms (all paper-cited textbook externals).
- Build PASS `lake build MathlibStarter.V9Main` exit 0.
- `PsiNonpos_of_regPackage` shortcut DELETED entirely.

Per-class PsiNonpos lemmas now drive every theorem:
- P2*: PsiNonpos_of_P2StarHyp (cone-margin η + jamming + structural upper bound)
- P3: PsiNonpos_of_P3Hyp (6-substructure refactor: finite menu + polyhedral + cone facets + routing + LP + margin; Farkas-based)
- P4: PsiNonpos_of_P4Hyp (involution + reflection-balance + integral_map)
- VariableMargin: PsiNonpos_of_VariableMarginP2Hyp (variable η + densityCap + structural bound)
- GraphFBNF: PsiNonpos_of_GraphFBNFPackage (edgeFlow + graphEdgeIntegrand + Kirchhoff)
- FBNF F4: PsiNonpos_of_FBNFPackage (foliation disintegration + fiberPsiIntegrand)
- Binary B6: PsiNonpos_of_BinaryCapstoneData (B1+B3+B5 chain + binaryIntegrand)
- FBNF corollaries (Spherical-radial / Affine-MLR / Polyhedral-scalarizable): per-primitive helpers (radial via P4, AffineMLR via single-crossing integrand, Polyhedral via facet integrand).

# Audit task

FINAL adversarial sweep. Verify:

## A. No PsiNonpos_of_regPackage residue

Grep the entire v9_appendix.lean for `PsiNonpos_of_regPackage`. Expected: zero live calls (only docstring/comment historical references). Confirm.

## B. No sorries

Verify v9_appendix.lean has zero `sorry` tokens in code (only in comments/docstrings).

## C. Per-class PsiNonpos lemmas honest

For each per-class lemma (PsiNonpos_of_P2StarHyp, _of_P3Hyp, _of_P4Hyp, _of_VariableMarginP2Hyp, _of_GraphFBNFPackage, _of_FBNFPackage, _of_BinaryCapstoneData, _of_AffineMLRSingleCrossingPrimitive, _of_PolyhedralScalarizablePrimitive), verify:
- Body uses concrete data + Mathlib lemmas (integral_nonpos_of_ae, mul_le_mul_of_nonneg_left, integral_map, etc.).
- No internal `sorry`.
- No call to `PsiNonpos_of_regPackage` (which is gone, but check transitively).
- `#print axioms` would show only `[propext, Classical.choice, Quot.sound]` + the 9 Inventory.V9 axioms.

## D. Structural upper bound fields

Several lemmas use `regPsi_le_X_integral` structural fields on hypothesis structures (P2StarHyp, P4Hyp, VariableMarginP2Hyp, GraphFBNFPackage, FBNFPackage, BinaryCapstoneData). Each is `regPsi ≤ (concrete real expression)`. Verify these are LEGITIMATE structural hypotheses (the v9 paper's §-specific upper bound is what the user-supplied hypothesis claims). NOT cert-verifier-shaped (no `: PsiNonpos`).

## E. 9 Inventory.V9 axioms

Verify all 9 are paper-cited textbook externals (not v9_consolidated.md citations).

## F. Theorem ↔ paper match

For each headline theorem, verify the Lean statement matches the v9 paper's §-statement (briefly per theorem).

# Output

Per `8b_lean_smuggling_check_soft.md` format. OVERALL verdict:
- Clean: YES / NO
- Severity: NONE / LOW / MEDIUM / HIGH / CRITICAL
- Per-section verdicts (A through F).
- Recommendation: ACCEPT / further work.
