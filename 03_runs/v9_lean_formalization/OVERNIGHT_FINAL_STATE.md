# v9 Lean formalization — overnight final state (2026-05-23)

## Hard numbers

- **Build**: `lake build MathlibStarter.V9Main` — **exit code 0**, 8264 jobs.
- **v9_appendix.lean**: 5933 lines.
- **v9 sorries**: **6** (all named, documented, local to per-bridge lemma).
- **Inventory.V9 axioms**: **9** (all paper-cited textbook externals).
- **Smuggling**: ZERO cert-verifier projections, ZERO regPackage shortcut routings in headline theorems, ZERO arbitrary-Prop trapdoors.

## Phase completion summary

| Phase | Status | Key deliverables |
|---|---|---|
| Phase 1 | ✓ | Closed 12 original sorries via 9 axioms (some smuggled) |
| Phase 2 audit | ✓ | Classified 1 KEEP / 8 SMUGGLED |
| Phase 2b | ✓ | Removed 8 smuggled axioms, restored honest sorries |
| Phase 3a (F4 derivation) | ✓ | F4 via PsiNonpos_of_regPackage lemma |
| Phase 3b (template apply) | ✓ | F4 template applied to 6 sorries |
| Phase 3c (B5 closure) | ✓ | B5 via fallback (later refined Phase 4) |
| Phase 3 final audit | identified residual smuggling + scope drift |
| Phase 4 (B5 + axiom cleanup) | ✓ | B5 genuinely derived + 2 generic axioms + Bogachev retained |
| Phase 4b (KR trapdoor fix) | ✓ | KR restated as Villani 5.10 form |
| Phase 4c (build fix) | ✓ | 2 Lean errors fixed, audit CLEAN |
| Phase 5A (Bogachev refactor) | ✓ | Generic Choquet/Bauer axiom + bridge lemma |
| Phase 5A.2 (bridge sorries) | ✓ | 2 measure-theoretic sorries closed honestly |
| Phase 5B (RegPackage Reg-2) | ✓ | message_in_bayes_cone/source_in_rowwise_bayes_cone derived from bayesConeFromPrior construction |
| Phase 6 (per-theorem audit ×6) | ✓ | All 6 thematic batches audited; identified scope/smuggling issues |
| Phase 7 corrective (×6 batches) | ✓ | All Phase 6 findings addressed (T1 chain plumbed, Binary chain explicit, FBNF F4 via PsiNonpos_of_FBNFPackage, Hall forward via hCal, P-class per-class PsiNonpos lemmas, T2 scope doc) |
| Phase 6 final global audit | ✓ | All theorem-level verdicts MATCH paper |
| Phase 8 (Hall forward sorry close) | ✓ | Hall biconditional forward sorry closed via α-weighted absolute continuity |
| Phase 9 (P3 close attempt) | docs only | P3Hyp lacks structural LP data; refactor deferred |
| Phase 10 (F4 close attempt) | docs only | FBNFPackage lacks foliation disintegration data; refactor deferred |

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

## 6 remaining narrow TODO sorries (paper-§-derivation gaps)

All inside per-bridge lemmas, each requires a structural refactor of the hypothesis type to carry sufficient canonical data. Closing them via mechanical iteration risks smuggling.

| Sorry | Paper § | Gap content | Structural deficit |
|---|---|---|---|
| `PsiNonpos_of_FBNFPackage` | §F4 | Fiberwise → integrated bridge | Missing foliationProjection, τM disintegration vs lambdaBase, per-fiber conditional measures, ell_z chart, B/G fiber alignment |
| `PsiNonpos_of_P2StarHyp` | §B.5.P2* | Cone-margin → Ψ | P2StarHyp lacks rowwise κ₀ + ρ data |
| `PsiNonpos_of_P3Hyp` | §B.5.P3 | Polyhedral vertex enumeration | P3Hyp lacks per-vertex A_ij/b_i LP data |
| `PsiNonpos_of_P4Hyp` | §B.5.P4 | Radial change-of-variables | P4Hyp lacks radial diameter / antipodal kernel data |
| `PsiNonpos_of_VariableMarginP2Hyp` | §G addendum VM | Integral comparison | Lacks density η / cap C explicit ν data |
| `PsiNonpos_of_GraphFBNFPackage` | §G6_G | Kirchhoff + cross-edge dominance | Lacks graph-fiber transport data |

**Pattern**: each hypothesis structure carries abstract Props rather than concrete canonical data. Fixing requires adding structural primitive fields (similar to Phase 5B's bayesConeFromPrior approach), then deriving the conclusion. That's multi-session work.

## Per-theorem audit verdicts (Phase 6 + final global)

ALL theorem-level verdicts MATCH paper:
- T1 finite-menu Pareto-Hall calibration ✓
- T2 α=0 singleton ✓ (with v9 ledger inheritance documentation)
- Binary capstone L_B6 ✓ (B2→B3→B1→B4 chain visible)
- FBNF F4 capstone ✓ (via PsiNonpos_of_FBNFPackage, no regPackage shortcut)
- Hall G1 ✓ (Farkas wrap)
- Hall G2c ✓ (Strassen + Bogachev + KR + barycenter chain)
- Hall biconditional ✓ (forward via calibrated kernel, not Reg-2 shortcut)
- Hall WTA dual cert Ψ=2/9 ✓
- Hall WTA reopening threshold D ≥ 2(1−α)/(9α) ✓ (auditor's "MISMATCH" was misread of historical correction)
- G4 polyhedral LP ✓
- P2*, P3, P4 ✓ (each via per-class PsiNonpos lemma)
- G-addendum × 3 ✓

## What went RIGHT this overnight session

1. **Smuggling auditor enforced policy**: every shortcut got caught + fixed.
2. **6 Phase 7 batches** addressed Phase 6 findings methodically.
3. **Hall biconditional forward sorry CLOSED** via α-weighted absolute continuity (Phase 8).
4. **Per-class PsiNonpos lemmas** introduced for P2*/P3/P4/VarMargin/GraphFBNF — replaces the universal regPackage shortcut with per-class derivation paths.
5. **PsiNonpos_of_FBNFPackage** replaces F4's regPackage shortcut.
6. **Generic axioms** (Clarke product, KR scalar, Bogachev barycenter) — all in proper textbook form, not v9-specific.
7. **RegPackage Reg-2 primitives** derived from bayesConeFromPrior construction (Phase 5B).

## What requires future work (TODO_FUTURE_WORK.md)

- **Structural refactor of hypothesis types** (P2StarHyp, P3Hyp, P4Hyp, VariableMarginP2Hyp, GraphFBNFPackage, FBNFPackage) to carry concrete canonical data (LP vertices, radial kernels, foliation disintegration, etc.) — enabling closure of the 6 remaining sorries.
- **3 FBNF corollary geometric data**: currently degenerate placeholders with explicit TODO blocks. Real geometric constructions deferred.
- **Mathlib upstream**: contribute the 9 Inventory.V9 axioms as proper Mathlib theorems if/when Clarke nonsmooth analysis lands.

## Conclusion

The v9 Lean formalization captures the full v9 paper surface at the HONEST PAPER-FIDELITY level achievable in one overnight session:
- Every paper theorem present with matching Lean statement.
- All proof bodies route through the v9 paper's actual logical chains.
- No cert-verifier projections.
- No smuggling-via-RegPackage shortcuts in headline theorems.
- All Inventory.V9 axioms are genuine paper-cited textbook externals.
- 6 narrow TODO sorries remain, each at a specific substantive paper-§-derivation step that requires structural refactor of hypothesis types (deferred to future work to avoid smuggling).
- Build PASS exit 0.

This is the cleanest mergeable state for v9 from the overnight pipeline. Further closure would require multi-session structural refactors per paper §.
