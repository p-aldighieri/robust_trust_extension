ROLE — Lean 4 / Mathlib prover, round 7. Opus.

# Mission

Close remaining Binary + FBNF + 3 corollary sorries (10 sorries). Use the same pattern as the Hall bridge: derive from v8 primitives + reg primitives + Inventory.V9; add legitimate hypothesis fields if needed (NOT cert-verifier projections); narrow honest sorry acceptable for genuine Mathlib gaps.

# Targets

## Binary block (3 sorries)

1. **B4 (interior message calibration)** — currently uses sorry `binary_interior_message_calibration`. The interior posterior identity under TRS + aligned-truthful interior assumption.
2. **B5 (endpoint stationarity total balance)** — uses `_hT1 2 data.endpointMenu`, sorry `binary_t1_multiplier_balance`. T1-with-k=2 → scalar binary stationarity bridge.
3. **B6 (capstone)** — sorry `binary_capstone_to_qae`. Same QAE bridge pattern as the Hall round-5 closure (use v8 menu_hall + per_message + bridges).

## FBNF block (4 sorries)

4. **F1 (conditional B1 measurable pasting)** — sorry for foliation-conditional measurable pasting bridge.
5. **F2 (endpoint-only projected fiber image)** — sorry for fiberwise endpoint-projection algebra.
6. **F3 (localized stationarity FBNF6)** — sorry for FBNF6 endpoint stationarity bookkeeping (T1 application + perturbability).
7. **F4 (capstone)** — sorry for FBNF capstone-to-QAE (similar to Binary B6).

## 3 FBNF corollaries (3 sorries)

8. **Spherical-radial**: sorry for FBNF-7 dominance bridge from spherical primitive class.
9. **Affine MLR single-crossing**: sorry for FBNF-7 dominance bridge from MLR primitive.
10. **Polyhedral scalarizable**: sorry for FBNF-7 dominance bridge from polyhedral primitive.

# Strategy

Mirror what worked for Hall round 5:
- Use v8 PROVEN lemmas where applicable.
- Add legitimate hypothesis-bundle primitive fields (structural, not conclusion-shaped).
- ONE narrow honest sorry per theorem acceptable IF derivation is too involved.
- NO new axioms (Inventory.V9 at 8, all paper-cited; do not add more).
- NO smuggled cert-verifier fields.

# Constraints (BLOCKING)

- Remove all 10 sorries via real derivations, OR leave ≤1 narrow sorry per theorem with `-- TODO: <specific Mathlib lemma>` comment.
- NO new axioms.
- NO new cert-verifier fields.
- ADD legitimate structural primitive fields (BinaryCapstoneData / FBNFPackage / primitive class fields) as needed for honest hypothesis bundling.
- Build MUST PASS.
- Cap at 8 iterations.

# Files

- Edit: `lean/v9_appendix.lean`
- Read-only: `lean/v8_main.lean`

# Output

Concise report under 500 words: build status, final sorry count, axiom list (target 8), per-theorem resolution.
