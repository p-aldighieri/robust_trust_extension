ROLE — Lean 4 / Mathlib prover, PHASE 2b clean sweep. Opus.

# Mission

Phase 2 audit identified 8 SMUGGLED Inventory.V9 axioms (each cited to v9_consolidated.md — the v9 paper itself, not external textbook). Replace each with a Lean derivation following the v9 paper's actual proof.

Goal: ZERO sorries, BUILD PASS, with axioms ONLY for genuine external textbook theorems Mathlib lacks.

# The 8 smuggled axioms to remove + derivation strategies

## 1. `binary_T1_to_endpoint_balance` (B5)

**Conclusion**: from T1 multiplier-Bayes-cone (k=2) + TRS + endpoint-only + R-IES → scalar equality `lhsL = rhsL ∧ lhsR = rhsR`.

**Lean derivation**: 
- Apply T1 universal hypothesis at k=2 to `data.endpointMenu`.
- T1 gives `∀ i, p_i ∈ BayesConeW model (paretoMenu i)` for `p_i = g_i / q_i`.
- For k=2 binary, write out the two-label inequality from BayesConeW + project to scalar form `(α·∫... + (1-α)·∫...)` = balance equation.
- Algebraic manipulation gives `lhsL = rhsL`, `lhsR = rhsR`.
- If a specific scalar-projection step is mechanically intractable, leave narrow sorry with `-- TODO: T1 scalar projection at k=2`. NOT a new axiom.

## 2. `binary_capstone_to_QAE` (B6)

**Conclusion**: binary geometry (B1+B2+B3+B5) → `HasRobustRationalizableStrategy model data.pd`.

**Lean derivation**:
- Construct a v9 `RegPackage` from binary data (use binary primitives to satisfy reg's fields).
- Apply Hall biconditional reverse direction to derive kernel existence.
- Apply `robustRationalizableKernelExists_to_strategy` to get the strategy.
- This requires plumbing binary primitives into reg's geometric primitives — substantial Lean. If a piece doesn't fit cleanly, leave narrow sorry with `-- TODO: <specific connection>`.

## 3. `fbnf_capstone_to_QAE` (F4)

Same template as B6 but for FBNF.

## 4-7. `psi_nonpos_from_cone_margin_p2_star` / `_polyhedral_p3` / `_radial_antipodal_p4` / `_variable_margin`

**Conclusion**: geometric primitive (cone-margin / polyhedral vertices / radial symmetry / variable margin) → `PsiNonpos model reg`.

These are v9 §B.5 / §G.P2*' theorems. Each requires a proof in Lean that uses the geometric primitives to derive Ψ ≤ 0 for all bounded Borel test profiles.

**Lean derivation strategy**:
- For P2* cone-margin: show that the integrated support-function gap is dominated by the cone-margin parameter. Algebraic / measure-theoretic.
- For P3 polyhedral: vertex-by-vertex enumeration + farkas_lp_duality_conic.
- For P4 radial antipodal: change-of-variables under the radial involution.
- For variable margin: integral comparison with the floor/cap bounds.

Each is genuinely non-trivial. Leave narrow `-- TODO: <specific gap>` sorries for parts that don't mechanize cleanly.

## 8. `graph_FBNF_to_QAE`

**Conclusion**: GraphFBNFPackage → `HasRobustRationalizableStrategy`.

**Lean derivation**: similar to F4 capstone but adapted for graph-FBNF setup. Use graph-FBNF primitives (nodeIndex, edgeIndex, kirchhoffBalanceScalar, crossEdgeDominanceMargin) to construct FBNFPackage, then apply FBNF F4.

# Constraints (PHASE 2b)

- REMOVE the 8 smuggled axioms from Inventory.V9.
- Replace with Lean derivations (substantial work).
- Narrow `-- TODO: <specific Mathlib lemma>` sorries acceptable inside derivations for genuine Mathlib gaps.
- New Inventory.V9 axioms acceptable ONLY for GENUINE EXTERNAL TEXTBOOK theorems NOT cited from v9_consolidated.md.
- KEEP `bayesian_barycenter_in_closed_convex` if its Lean statement is GENERIC (verify per audit guardrail).
- Build MUST PASS.
- Cap at 8 iterations.

# Files

- Edit: `lean/v9_appendix.lean`
- Read-only: `lean/v8_main.lean`

# Output

Concise report under 600 words: build status, sorry count, FINAL Inventory.V9 axiom list (target ≤9 = 8 originals + Bogachev barycenter, plus maybe a few more if genuinely needed for non-v9-paper external theorems), removed axioms, per-axiom resolution strategy used.
