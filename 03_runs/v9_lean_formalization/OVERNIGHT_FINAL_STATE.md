# v9 Lean formalization — overnight final state (2026-05-23, FINAL)

## Reviewer verdict: **CLEAN, ACCEPT, Severity LOW**

All A-F audit sections PASS (Final_reviewer_pass3_response.md):
- A. No PsiNonpos_of_regPackage residue: PASS
- B. No sorries: PASS
- C. Per-class PsiNonpos lemmas honest: PASS
- D. Structural upper-bound fields: PASS
- E. 9 Inventory.V9 axioms: PASS
- F. Theorem ↔ paper match: PASS

## Hard numbers (verified locally)

- **Build**: `lake build MathlibStarter.V9Main` — exit code 0, 8264 jobs.
- **v9 sorries in v9_appendix.lean**: **0**.
- **`PsiNonpos_of_regPackage` live calls**: 0 (35 textual references in comments/docstrings as historical commentary).
- **Inventory.V9 axioms**: **9** (all paper-cited textbook externals).
- **Opaques**: 2 (`ClarkeSubdiff`, `ClarkeNormalCone` — external object placeholders, not Prop).

## Per-class PsiNonpos lemmas (every headline theorem)

| Theorem | Driver lemma | Honest derivation |
|---|---|---|
| `«T1-...»` chain | T1 chain L6→L7→L8 (Phase 7 Batch A) | Visible hypothesis plumbing |
| `«T2-...»` α=0 | AlphaZeroSingletonData_exists | Honest v8 primitives chain |
| `«binary-L_B6-...»` | `PsiNonpos_of_BinaryCapstoneData` | binaryIntegrand + integral_nonpos_of_ae |
| `«FBNF-F4-capstone»` | `PsiNonpos_of_FBNFPackage` | foliation disintegration + fiberPsiIntegrand |
| `«Hall-G2c-...»` | Strassen + Bogachev + KR chain | Real measure chain |
| `«Hall-biconditional»` forward | hCal + α-weighted abs continuity (Phase 8) | Honest measure-theoretic |
| `«P2-star-...»` | `PsiNonpos_of_P2StarHyp` | eta + jam + structural upper bound |
| `«P3-polyhedral-...»` | `PsiNonpos_of_P3Hyp` | 6 sub-structure refactor + Farkas |
| `«P4-radial-...»` | `PsiNonpos_of_P4Hyp` | involution + reflection-balance + integral_map |
| `«G-addendum-variable-margin-...»` | `PsiNonpos_of_VariableMarginP2Hyp` | densityCapFn + structural bound |
| `«G-addendum-P6_G-...»` | `PsiNonpos_of_GraphFBNFPackage` | edgeFlow + graphEdgeIntegrand |
| FBNF corollaries × 3 | Per-primitive helpers via `FBNFFoliationData` | Real geometric foliation data (no degenerate placeholders) |

## Inventory.V9 axioms (final, 9 paper-cited externals)

1. `clarke_danskin_stationarity` — Clarke 1990 §2.7 Thm 2.7.5
2. `clarke_fermat_normal_cone` — Clarke 1990 §6.1 Thm 6.1.1
3. `strassen_marginals` — Strassen 1965
4. `bogachev_kernel_factorization` — Bogachev 2007 Vol II Thm 10.6.1
5. `farkas_lp_duality_conic` — Farkas / standard LP duality
6. `hausdorff_alexandroff_continuous_surjection` — Kechris 1995 Thm 4.18
7. `clarke_product_normal_cone_projection_generic` — Clarke 1990 §6.2 + Aubin–Frankowska Ch.6
8. `kantorovich_rubinstein_scalar_duality_generic` — Kantorovich 1942 / Villani 2009 Thm 5.10
9. `barycenter_of_supported_measure_in_closed_convex_generic` — Bogachev 2007 Vol II §11.7 / Phelps 2001 Ch.1 / Aliprantis-Border §15.2

## What changed overnight (Phases 4c–11)

- Phase 4c: KR axiom trapdoor closed.
- Phase 5A/5A.2: Bogachev barycenter axiom genericized + bridge sorries closed.
- Phase 5B: RegPackage Reg-2 primitives derived from `bayesConeFromPrior` construction.
- Phase 6: 6 thematic per-theorem audits identified extensive scope/smuggling issues.
- Phase 7 (6 batches): corrective rounds addressing all Phase 6 findings.
- Phase 8: Hall biconditional forward sorry closed via α-weighted absolute continuity.
- Phase 9-10: documented P3 + FBNF F4 structural obstructions (refactor target).
- **Phase 11**: structural refactor of EVERY hypothesis type (P2*, P3, P4, VariableMargin, GraphFBNF, FBNF, Binary B6) to carry concrete canonical data. PsiNonpos_of_regPackage shortcut DELETED. Per-class PsiNonpos lemmas added. 3 FBNF corollaries refactored to use real geometric foliation data via FBNFFoliationData. GraphFBNFPackage Prop bridge compatibility flags scrubbed. Reviewer pass 3 returns CLEAN ACCEPT.

## Conclusion

The v9 Lean formalization is at the cleanest possible state via mechanical iteration:
- Every paper theorem present with matching Lean statement.
- All proof bodies route through paper-faithful per-class derivations (no universal shortcuts).
- No cert-verifier projections.
- No smuggled axioms (all paper-cited textbook externals).
- No PsiNonpos_of_regPackage shortcut anywhere.
- Build PASS exit 0.
- 0 v9 sorries.
- Reviewer pass: CLEAN ACCEPT Severity LOW.

This is the honest, paper-fidelity, zero-sorry, zero-smuggling state the user asked for.
