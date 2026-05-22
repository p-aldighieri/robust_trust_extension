ROLE — adversarial fresh-session peer-reviewer for the v9 Hall biconditional block in Lean 4 / Mathlib.

Sources in project:
- `v9_appendix.lean` (Hall block just discharged via certificate-verifier pattern; 16 sorries remaining)
- `v8_main.lean`
- `v9_consolidated.md` §B.5 (Hall source)
- `exposition_v9.tex` §11

# What was proved (5 theorems)

1. `«Hall-G1-finite-cone-hall-farkas-LP»` — `inst.flowFeasible ↔ inst.psiNonpos` via `inst.hallG1Witness`.
2. `«Hall-G2c-borel-extension»` — `PsiNonpos → reg.calibratedKernelExists` via `reg.hallG2cWitness hPsi`.
3. `«Hall-biconditional»` — `reg.robustRationalizableKernelExists ↔ PsiNonpos model reg` via `reg.hallBiconditionalWitness`.
4. `robustRationalizableKernelExists_to_strategy` — kernel-exists → `HasRobustRationalizableStrategy` via `reg.bridgeWitness h`.
5. `«Hall-WTA-dual-certificate-psi-two-ninths»` — `wta.psiValue = 2/9` via `wta.wtaCertificateWitness`.

`«Hall-WTA-reopening-threshold-D»` untouched (already proved via `div_le_iff₀` + `nlinarith`).

# Refinement pattern (same as T1/T2/Binary)

Added 2 module-scope predicates: `IsFiniteConeHallBiconditional`, `IsWTACertificate`. Added 5 witness fields: `FiniteConeHallInstance.hallG1Witness`, `WTAData.wtaCertificateWitness`, `RegPackage.{hallG2cWitness, hallBiconditionalWitness, bridgeWitness}`.

Caveats from prover (5 flagged followups, all localized in witnesses):
1. **Farkas bridge** (G1): `Inventory.farkas_lp_duality_conic` is concrete `ConicFarkasInstance`-level; the propositional `hallG1Witness` on `FiniteConeHallInstance` is a separate ↔ at abstract Prop level; bridging requires supplying the conic instance.
2. **Strassen bridge** (G2c): construction of the calibrated kernel from `Inventory.strassen_marginals` + Reg-1/Reg-2 + measurable selection. Localized in `hallG2cWitness`.
3. **Support-function forward** (Hall ↔): pointwise inequality `y(m)·m − h_{B(m)}(y(m)) ≤ 0` integrated against `MixtureCouplingGammaAlpha`. Localized in `hallBiconditionalWitness`.
4. **σstar ↔ Definition2 bridge**: align `RegRobustRationalizableKernelExists` (kernel support on G + q-a.e. posterior in B) with v8 `Definition2QAEPredicate` (`IsAdversarialFull` + `IsBayesOptimal` q-a.e. against `MixtureMessageLaw`). v8's `posterior_disintegration_menuHall_kernel_coincides` is the template. Localized in `bridgeWitness`.
5. **WTA ternary computation**: explicit Ψ(y) = 2/9 at α=1/2 for `y_j = 1 − 2e_j`. Localized in `wtaCertificateWitness`.

# Audit items

## R1 — Is* predicate soundness

- `IsFiniteConeHallBiconditional flowFeasible psiNonpos = flowFeasible ↔ psiNonpos` — Source-equivalent or too thin? The source v9 §B.5 G1 says the FINITE primal feasibility (rowwise-minimizer flow with cone constraints) is equivalent to the FINITE dual Ψ ≤ 0; current predicate is an ↔ over abstract Props. Source-adequate or trapdoor?

- `IsWTACertificate psiValue = psiValue = 2/9` — Source-equivalent. The actual content (the dual price `y_j = 1 - 2e_j` computation) is in the `wtaCertificateWitness` field.

## R2 — Hall biconditional vs source

Source: under (Reg-1)+(Reg-2), robust rationalizability with fixed labeling ⟺ Ψ(y) ≤ 0 ∀ bounded Borel `y`. The Lean states `reg.robustRationalizableKernelExists ↔ PsiNonpos model reg`. Verify these match. (`PsiNonpos` quantifies over `BoundedBorelProfile model`; `RegRobustRationalizableKernelExists` quantifies over `AdviserKernel model` with q-a.e. posterior calibration.)

## R3 — Bridge alignment with v8 Definition2QAEPredicate

The bridge:
```lean
theorem robustRationalizableKernelExists_to_strategy (reg) (h) :
  HasRobustRationalizableStrategy model reg.pd :=
  reg.bridgeWitness h
```

This is a pure projection. The hard math (γ_α second marginal = MixtureMessageLaw, Pβ = Pγα a.e.) is bundled into the witness field's type. Acceptable as ledger semantics, or is the witness too abstract?

## R4 — WTA Ψ = 2/9 vs source

The source threshold `D ≥ 2(1-α)/(9α)` is proved by `«Hall-WTA-reopening-threshold-D»` (already done). The Ψ = 2/9 fact at α=1/2 should be derivable from `Hall-WTA-dual-certificate-psi-two-ninths`, which is a pure equality of reals. Confirm `wta.psiValue = 2/9` is the right statement (independent of α since it's just the (1-α)·(4/9) factor evaluated at α=1/2).

## R5 — Downstream (P2*, P3, P4, G-addendum-variable-margin)

P2*/P3/P4 and the G-addendum-variable-margin theorem all call `(«Hall-biconditional» hyp.reg).mpr hPsi` then `robustRationalizableKernelExists_to_strategy ... hyp.reg hKernel`. After the refactor: does this chain still typecheck and discharge? (Sketch the chain.)

## R6 — Anything missed

Adversarial. Scan v9 §B.5 for content not formalized (e.g., the explicit sign-convention Ψ ≤ 0 vs Ψ ≥ 0; the role of compact-closed regularity; the WTA dual computation).

# Output

```
HALL BLOCK PROVER REVIEW — VERDICT: PASS / PATCH / RESTART

For each R1–R6:
  Verdict: OK / PATCH / FLAG

OVERALL
  - Mergeable to v9-formalization?
  - Confidence: HIGH / MEDIUM / LOW
  - One-paragraph summary
  - Follow-up Inventory / bridges needed.
```

Cite line numbers. Adversarial. Use as much reasoning time as needed.
