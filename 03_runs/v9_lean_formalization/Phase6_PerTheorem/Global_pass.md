ROLE — Lean ↔ v9 paper FINAL GLOBAL audit. Extended Pro.

# Context

v9 Lean formalization is at a milestone state after Phases 1-7. Final global verification pass.

# Current state

- `v9_appendix.lean`: 5684 lines, 7 v9 sorries (all named, documented, local to per-bridge lemma).
- 9 Inventory.V9 axioms, all paper-cited textbook externals.
- Build PASS: `lake build MathlibStarter.V9Main`, exit code 0.
- Phase 7 fixed Phase 6 audit findings across all batches:
  - T1 chain plumbed end-to-end (h6 → h7 → h8 → headline).
  - Binary B1-B6 chain explicit (B2 → B3 → B1 → B4 → RegBridge).
  - FBNF F4 uses new PsiNonpos_of_FBNFPackage (not regPackage shortcut).
  - Hall biconditional forward uses calibrated kernel's hCal (not Reg-2 shortcut).
  - P-class theorems each invoke a per-class PsiNonpos lemma (P2*/P3/P4/VariableMargin/GraphFBNF).
  - T2 scope drift documented as v9 ledger inheritance + paper-surface corollary.

# Audit task — GLOBAL

1. Compare full Lean v9_appendix.lean to the full v9 paper (v9_consolidated.md + exposition_v9_paper.tex). Verify:
   - All paper-level v9 theorems (T1, T2, Binary capstone L_B6, FBNF F4 + 3 corollaries, Hall biconditional + Hall WTA threshold + WTA dual certificate, G4, P2*, P3, P4, G-addendum × 3) are present in Lean with matching statements.
   - No paper theorem missing from Lean.
   - Lean primitive structures match paper standing setup (Reg-1/Reg-2, FBNFPackage primitives, BinaryCapstoneData, etc.).

2. Verify the 7 narrow TODO sorries each cite the correct paper §:
   - PsiNonpos_of_FBNFPackage — §F4 fiberwise → integrated bridge.
   - Hall-biconditional forward — §B.5 mixture-marginal q-a.e. → τM-a.e. measure-theoretic bridge.
   - PsiNonpos_of_P2StarHyp — §B.5.P2* cone-margin → Ψ.
   - PsiNonpos_of_P3Hyp — §B.5.P3 polyhedral vertex enumeration.
   - PsiNonpos_of_P4Hyp — §B.5.P4 radial-antipodal change-of-variables.
   - PsiNonpos_of_VariableMarginP2Hyp — §G addendum VM integral comparison.
   - PsiNonpos_of_GraphFBNFPackage — §G6_G graph kirchhoff.

3. Verify all 9 axioms are legitimate external textbook deps (Clarke 1990 ×3 + Strassen 1965 + Bogachev 2007 ×2 + Farkas + Kechris 1995 + KR Kantorovich 1942/Villani 2009).

# Output

Global verdict:
- Clean: YES / NO
- Severity: NONE / LOW / MEDIUM / HIGH / CRITICAL
- Per-theorem cross-reference: paper theorem ↔ Lean theorem ↔ verdict.
- Final compilation: PASS / FAIL (assume build PASS).

If any structural issue remains, identify the specific Lean line.
