ROLE — Lean Inventory Match Auditor. Final-pass audit. Per the role description in `prompts/soft/89_lean_inventory_match_soft.md` (MathPipeProver tooling, commit c19c54d).

# What to audit

The `Inventory.V9` namespace in `v9_appendix.lean` (already in the project sources). It declares the v9 external dependencies — the only external axioms/opaques the v9 theorem surface should consume.

Cross-check against the **declared v9 external dependencies** from `source_proof.md §Inventory axioms expected`:

1. `clarke_danskin_stationarity` (Clarke 1990 §2.7; envelope theorem for locally Lipschitz pointwise suprema)
2. `clarke_fermat_normal_cone` (Clarke 1990, Fermat rule for locally Lipschitz on closed sets)
3. `strassen_marginals` (Strassen 1965 / Kantorovich–Rubinstein dual coupling)
4. `farkas_lp_duality_conic` (Farkas; finite-dimensional conic strong LP duality)
5. `berge_maximum_set_valued` (REMOVED — should not be in Inventory.V9)
6. `hausdorff_alexandroff_continuous_surjection` (Kechris 1995 Thm 4.18)

Plus 3 reused v8 axioms (in `Inventory.*`, NOT in `Inventory.V9`):
- `Inventory.measurable_argmax_selector`
- `Inventory.krn_borel_right_inverse`
- `Inventory.kernel_infimum_epsilon_selection`

For each Inventory.V9 entry currently in `v9_appendix.lean`, assess:

- **MATCHES** — statement is the standard form of the declared dependency.
- **OVERSTATED** — stronger than needed.
- **UNDERSTATED** — weaker than needed (proof would need a stronger version).
- **TRAPDOOR** — hypothesis fields are arbitrary `Prop`s, OR conclusion is bare `Prop`, OR otherwise lets a user inject anything.
- **UNUSED** — declared but never invoked anywhere in `v9_appendix.lean`.
- **MISSING** — declared dependency in `source_proof.md` not present in Inventory.V9.

# Particular things to look for

1. **`hausdorff_alexandroff_continuous_surjection`** — currently has conclusion `Prop` (placeholder). Should be flagged as TRAPDOOR until replaced with the concrete `∃ f : CantorSpace → K, Continuous f ∧ Function.Surjective f`.

2. **`berge_maximum_set_valued`** — should be REMOVED (per decomposition reviewer item H, replaced by `Mathlib.Topology.Order.Compact.IsCompact.exists_isMaxOn`). Verify it's not in Inventory.V9.

3. **Inventory.V9 axiom conclusions** should be concrete mathematical statements (not bare Props, not abstract data carriers).

4. **Inventory.V9 hypothesis structures** (ClarkeDanskinHyp, StrassenMarginalDominance, ConicFarkasInstance) should have named, mathematical fields (LipschitzOnWith, HasFDerivAt, IsCompact, dual_marginal_inequality, etc.).

5. **CONSUMED vs DECLARED**: each Inventory.V9 axiom is declared, but is it actually invoked anywhere in v9_appendix.lean? The current state uses the certificate-verifier pattern, so the axioms may be UNUSED in proof bodies but referenced via data-witness fields. Distinguish:
   - "UNUSED + consumed-via-data-witness" (acceptable — certificate-verifier ledger semantics)
   - "UNUSED + not even referenced" (dead axiom; should be removed)

# Output format

```
INVENTORY MATCH AUDIT — VERDICT: MATCHES_DECLARED / OVER_OR_UNDER / TRAPDOOR_FOUND / MISSING_FOUND

For each axiom in Inventory.V9:
  - Name: Inventory.V9.<name>
  - Standard form: <citation + standard signature>
  - Lean signature: <as in v9_appendix.lean>
  - Assessment: MATCHES / OVERSTATED / UNDERSTATED / TRAPDOOR / UNUSED
  - Where consumed in v9_appendix.lean (or "never invoked, used via data-witness pattern")

Missing dependencies (declared but not in Inventory.V9):
  - <list>

OVERALL
  - Inventory.V9 completeness: COMPLETE / OVERFULL / UNDERFULL
  - Inventory.V9 soundness: SOUND / TRAPDOOR-CONTAINING
  - Mergeable as declared-dependency-faithful: YES / NO
  - Confidence: HIGH / MEDIUM / LOW
  - One-paragraph summary.
```

Cite line numbers in v9_appendix.lean.
