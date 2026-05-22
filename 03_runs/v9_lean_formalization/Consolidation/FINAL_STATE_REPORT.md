# v9 Lean formalization — final state (post cert-elim, 2026-05-22)

## Local-audit definitive results (`grep` verification on v9_appendix.lean)

### Axiom inventory (Inventory.V9 + opaques)

```
43:opaque ClarkeSubdiff
49:opaque ClarkeNormalCone
93:axiom clarke_danskin_stationarity            -- Clarke 1990, §2.7, Thm 2.7.5
112:axiom clarke_fermat_normal_cone             -- Clarke 1990, §6.1, Thm 6.1.1
151:axiom strassen_marginals                    -- Strassen 1965, Ann. Math. Stat. 36(2)
185:axiom farkas_lp_duality_conic               -- Farkas / Boyd–Vandenberghe §5.8.3
208:axiom hausdorff_alexandroff_continuous_surjection  -- Kechris 1995, Thm 4.18
420:axiom clarke_product_normal_cone_projection_bridge  -- Clarke 1990 §6.2 + Aubin–Frankowska Ch.6
```

**6 axioms, 2 opaques, ALL paper-cited.**

### Cert-verifier projections (`exact <data>.<witness>` pattern)

```
$ grep -nE "exact (data|pkg|reg|hyp|prim|wta|inst)\.[a-zA-Z]*[Ww]itness" lean/v9_appendix.lean
(no matches)
```

**ZERO cert-verifier projections.**

### Honest sorries (documented Mathlib bridge gaps)

15 sorries in v9_appendix.lean, each scoped to a specific named Mathlib bridge that the prover documented with a paper-citable replacement strategy. None are cert-verifier patterns; none are smuggled axioms.

Distribution:
- Hall block: 5 (dual-to-Strassen, disintegration to AdviserKernel, support-function csSup boundedness, integration vs rowwise-infimum, QAE adversarial + Pβ=Pγα transfer)
- Binary block: 3 (interior message calibration, T1→stationarity bridge, QAE bridge)
- FBNF block: 4 (foliation pasting, fiberwise endpoint algebra, FBNF6 bookkeeping, QAE capstone)
- 3 FBNF corollaries: 3 (primitive→FBNF7 fiber dominance bridges)

### Build

```
lake build MathlibStarter.V9Main
→ Build completed successfully (8264 jobs).
```

Zero errors. 15 sorry warnings (all in v9_appendix.lean documented gaps) + 3 in v8 baseline (the legacy v8 Inventory stubs).

## Cert-elim ledger

| Block | Status | Notes |
|---|---|---|
| T1 (×4 theorems) | ACCEPT | Real derivations from Inventory.V9.clarke_danskin_stationarity + clarke_fermat_normal_cone + product-projection bridge |
| T2 / AlphaZero | ACCEPT | Full proof from v8 PosteriorLawConsistency + ProfileRealizationSetup + MessageSupportM |
| WTA Ψ=2/9 | ACCEPT | Pure numerical computation, no projection |
| Hall block (×4) | PARTIAL | 0 cert-verifiers, 5 honest sorries |
| Binary block (×6) | PARTIAL | 0 cert-verifiers, 3 honest sorries |
| FBNF block (×4) | PARTIAL | 0 cert-verifiers, 4 honest sorries |
| 3 FBNF corollaries | PARTIAL | 0 cert-verifiers, 3 honest sorries |
| G4 LP threshold | ACCEPT | Fully derived via Farkas |
| WP topology (×2) | ACCEPT | Real topological proof |

## Tooling delivered (MathPipeProver)

1. **`/lean-inventory-match`** — verifies Inventory matches declared deps; paper-source required (commit `b96461f`)
2. **`/lean-headline-translation`** — verifies headlines' Lean ↔ source match; CERTIFICATE_VERIFIER classified as SMUGGLING per user policy
3. **`/lean-smuggling-check`** — final adversarial sweep; SMUGGLED_CERTIFICATE category enforced

All three caught real issues in production:
- Inventory Match → hausdorff trapdoor → fixed
- Smuggling Check → two AlphaZero axiom trapdoors → reverted + replaced with real proof
- Smuggling Check (round 2) → ParetoMenuPrimitives bundled fields → forced derivation
- Headline Translation → flagged the 6 remaining cert-verifiers → eliminated this session

## User policy satisfied (2026-05-22)

- ✅ No certificate-verifier patterns ("if certificate then conclusion")
- ✅ Every dependency mapped to a paper source (Clarke 1990 ×3 sections, Strassen 1965, Farkas/Boyd-Vandenberghe, Kechris 1995, Aubin-Frankowska)
- ✅ Inventory split into `Inventory.V9` (v9 deps) + `Inventory` (v8 baseline reuse)
- ✅ Smuggling-check tooling enforces the policy automatically

## Remaining work (NOT smuggling — explicit honest sorries)

15 sorries documenting specific Mathlib bridges still needed. Each can be:
- Filled with a Mathlib-derivation when the right API surface exists.
- Or replaced by a paper-cited axiom (similar to clarke_product_normal_cone_projection_bridge).
- Each new axiom would go through `/lean-inventory-match` and `/lean-smuggling-check` audits.

The v9 surface is now an **honest open-front skeleton**: every claim is either derived or marked `sorry` with a documented gap. No smuggled axioms. No cert-verifier projections. No bare-Prop trapdoors.
