ROLE — Lean 4 / Mathlib prover, Phase 7 Batch F P-class correction. Opus.

# Mission

Phase 6 Batch F found "PASS for proof routing, with PATCH_SMALL hypothesis-fidelity caveats". The geometric primitive fields (cone-margin, polyhedral vertices, radial symmetry, variable margin, graph FBNF) are decorative — they don't enter the proof derivation.

The audit's recommendation:
> "Add fields documenting the actual P2* ingredients [...] or upgrade theorems to derive Ψ ≤ 0 from primitives."

# Same pattern as Phase 7 Batch D

For each P-class theorem (P2*, P3, P4, VariableMargin, Graph FBNF):
1. Introduce a per-class lemma `PsiNonpos_of_<Class>Hyp` that derives Ψ ≤ 0 from the geometric primitives.
2. The theorem invokes this lemma instead of `PsiNonpos_of_regPackage` shortcut.
3. Narrow TODO sorry inside the per-class lemma acceptable if the geometric derivation is intractable.

Templates needed:
- `PsiNonpos_of_P2StarHyp` — derives Ψ ≤ 0 from cone-margin + bounded jamming + aligned baseline + margin_dominates_jamming.
- `PsiNonpos_of_P3Hyp` — derives from polyhedral vertex enumeration + Inventory.V9.farkas_lp_duality_conic.
- `PsiNonpos_of_P4Hyp` — derives from radial symmetry involution + change-of-variables.
- `PsiNonpos_of_VariableMarginP2Hyp` — derives from η floor + density cap + integral comparison.
- `PsiNonpos_of_GraphFBNFPackage` — derives from kirchhoff balance + cross-edge dominance margin.

# Targets in v9_appendix.lean

- P2* (~L4608): `«P2-star-cone-margin-bounded-jamming»`
- P3 (~L4631): `«P3-polyhedral-cone-margin»`
- P4 (~L4652): `«P4-radial-antipodal-tau-symmetry»`
- G-addendum-variable-margin (~L4866): `«G-addendum-variable-margin-P2-star-prime»`
- G-addendum-P6_G-finite-graph-FBNF (~L4887)
- G-addendum-binary-tie-splitting (~L4857): already routes via Binary B1, PASS.

# Constraints

- Each P-class theorem invokes a per-class PsiNonpos lemma (not the generic PsiNonpos_of_regPackage).
- Narrow TODO sorry inside each per-class lemma acceptable.
- Build MUST PASS via `lake build MathlibStarter.V9Main` (exit 0).
- 9 axioms unchanged.
- NO smuggling.
- Edit only lean/v9_appendix.lean.
- Cap 8 iterations.

# Acceptable: ~5 additional narrow TODO sorries (one per class)

The trade-off: gain paper-fidelity (geometric data enters per-class derivation) at the cost of ~5 narrow TODOs (each documenting the specific geometric → Ψ derivation gap per class).

# Output

Concise report under 500 words: build status, sorry count (total + new), axiom count, before/after of each P-class theorem.
