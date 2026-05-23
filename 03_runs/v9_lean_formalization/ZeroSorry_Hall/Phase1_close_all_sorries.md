ROLE — Lean 4 / Mathlib prover, PHASE 1: close all sorries. Opus.

# Mission (BLOCKING)

12 v9 sorries remain in `lean/v9_appendix.lean`. User directive 2026-05-22 (clarified): **CLOSE ALL OF THEM, USING ANY ASSUMPTIONS / DEPENDENCIES / AXIOMS NEEDED**.

This is Phase 1 of a two-phase plan:
- **Phase 1 (this round)**: get to ZERO sorries. Use whatever — new Inventory.V9 axioms, helper structural fields, additional reg primitives, function-fields, whatever closes the gap. Build MUST PASS.
- **Phase 2 (later)**: audit each new addition. Reclassify as genuine external dep (KEEP) vs smuggled derivation (REVERT and fix properly). The audit happens AFTER Phase 1, NOT during.

DO NOT hold back. The goal is to make the proof COMPILE FIRST. Cleanup comes after.

# The 12 sorries to close

Locations from the latest commit (ea25f45):

1. **Hall Pγα calibration** (~L2959) — need `Pγα κ m ∈ B m` q-a.e. on mixture marginal. Use the Bogachev barycenter-of-supported-measure approach OR add `Inventory.V9.bayesian_barycenter_in_closed_convex` axiom citing Bogachev 2007 §10.6.
2. **B5 binary stationarity** (~L2612) — T1 multiplier-Bayes-cone + TRS + endpoint-only + R-IES → `lhsL = rhsL ∧ lhsR = rhsR`. Add structural field on `BinaryCapstoneData` OR new Inventory.V9 axiom (cited to v9_consolidated.md §B.3).
3. **B6 binary capstone → QAE** (~L2650) — binary geometry → `HasRobustRationalizableStrategy`. Add bridge primitives OR new Inventory.V9 axiom (cited to v9_consolidated.md §B.3).
4. **F4 FBNF capstone → QAE** (~L2765) — similar bridge.
5. **P2* cone-margin → Ψ ≤ 0** (~L3351) — geometric derivation. Add `Inventory.V9.psi_nonpos_from_cone_margin_p2_star` axiom citing v9_consolidated.md §B.5.P2* if direct Lean derivation is too involved.
6. **P3 polyhedral cone-margin → Ψ ≤ 0** (~L3375) — similar.
7. **P4 radial antipodal → Ψ ≤ 0** (~L3400) — similar.
8. **VariableMargin → Ψ ≤ 0** (~L3565) — similar.
9-11. **3 FBNF corollaries** (~L3471, L3505, L3540) — FBNF-7 dominance bridges per primitive class. Use existing `globalFiberDominance_from_*_holds` fields + add bridge structural fields OR new Inventory.V9 axiom per corollary.
12. **G-addendum P6_G FBNF** — graph-FBNF → FBNFPackage assembly.

# Constraints (PHASE 1)

- **Build MUST PASS** at end. Zero sorries in `lean/v9_appendix.lean`.
- New axioms PERMITTED with paper citations (Clarke / Strassen / Bogachev / Aliprantis-Border / Villani / Aubin-Frankowska / Boyd-Vandenberghe / Bourbaki / Kallenberg, OR v9_consolidated.md §<section> as the v9-paper citation for v9-specific derivations).
- Cert-verifier patterns PERMITTED for Phase 1 — Phase 2 audit will catch and clean.
- Function-field cert-verifiers PERMITTED for Phase 1 — Phase 2 will revisit.
- Theorem-arg cert-verifiers PERMITTED for Phase 1 — Phase 2 will revisit.
- BUT: prefer Lean derivation if it's straightforward. Smuggling is OK only as a fallback to close the sorry.
- v8_main.lean is read-only. Edit only lean/v9_appendix.lean.
- Build MUST PASS. Iterate as many times as needed.

# Files

- Edit: `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean`
- Read-only: `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean`

# Build verification

Standard concat + lake build MathlibStarter.V9Main.

# Output

Concise report under 600 words:
- Build status (PASS required).
- Final sorry count in v9_appendix.lean (target: 0).
- All Inventory.V9 axioms + paper citations.
- New helper structural fields added.
- Per-sorry resolution (which method used).
