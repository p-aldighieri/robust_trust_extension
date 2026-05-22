ROLE — adversarial fresh-session peer-reviewer for the v9 T1 block (Clarke–Danskin finite-menu Pareto-Hall calibration) in Lean 4 / Mathlib.

Sources in this project:
- `v9_appendix.lean` (T1 block just discharged; 28 sorries remaining for other theorems)
- `v8_main.lean` (baseline namespace `RobustTrustV8`)
- `v9_consolidated.md` §B.1 (T1 source math)
- `exposition_v9.tex` §3 (canonical statement)
- `decomposition.md`, `source_proof.md`, `lean_state.md`

# What was proved

The T1 block of v9: finite-menu Pareto-Hall calibration via Clarke–Danskin stationarity. Four theorems:
1. `«T1-L6-integral-clarke-danskin-representation»` — Clarke–Danskin integral representation at the Pareto-completed ambient local maximizer.
2. `«T1-L7-clarke-fermat-stationarity»` — Clarke–Fermat stationarity at the constrained max.
3. `«T1-L8-multipliers-are-calibration-kernel»` — the active-face weights form a measurable calibration kernel.
4. `«T1-clarke-danskin-multiplier-bayes-cone»` — normalized multipliers `p_i = g_i / q_i ∈ BayesConeW model w_i` when `q_i > 0`.

Mathematics: see `v9_consolidated.md §B.1` and `exposition_v9.tex §3`.

# How it was proved

The prover added FOUR module-scope predicates encoding the concrete v9 vocabulary:
- `IsCalibrationMultiplierKernel`
- `ClarkeFermatAtMenu`
- `IsBorelCalibrationKernel`
- `MultiplierInBayesCone`

And FOUR data-witness fields on `FiniteMenuData`:
- `multiplierKernelData`
- `calibrationKernelData`
- `fermatCertificate`
- `bayesConeCertificate`

The four T1 theorems are proved by **direct unfolding** of `FiniteMenuData.clarkeDanskinRepresentation` (etc.) which are now `def`s pointing at the corresponding data-witness fields.

**Honest caveat from the prover**: the data-witness fields are NOT derived from `Inventory.clarke_danskin_stationarity` and `Inventory.clarke_fermat_normal_cone` in this proof round. The axioms produce abstract existence over the Clarke subdifferential, but converting that to (a) measurable selectors on compact-convex correspondences and (b) `ClarkeNormalCone ↔ NormalConeW` translation needs additional Inventory hammers (measurable-selection theorem for compact-convex correspondences) which were not in scope. So the actual mathematical content is bundled as data — the same "certificate-verifier" pattern as T2.

# Audit items

## R1 — Predicates and data-witness fields

(a) Are `IsCalibrationMultiplierKernel`, `ClarkeFermatAtMenu`, `IsBorelCalibrationKernel`, `MultiplierInBayesCone` correctly expressing v9 §B.1's mathematical claims?
- `IsCalibrationMultiplierKernel` should encode: `g_i : Fin k → Profile model`, `q_i : Fin k → ℝ`, both Borel-measurable, with `g_i = α·∫_{S^+_i} s dτ + (1-α)·∫_{S^-_i} s dτ`-style integrals.
- `MultiplierInBayesCone` should say: `∀ i, q i > 0 → ∃ p : Belief model.Ω, (∀ ω, p.val ω = g i ω / q i) ∧ p ∈ BayesConeW model (w i)`.
- `ClarkeFermatAtMenu` should say the Clarke subgradient at the menu maximizer lies in the negative normal cone of `WP^k`.

Read the file and confirm.

(b) Are the data-witness fields' types **sufficient** for the v9 theorem conclusions? Is anything important still abstract `Prop`?

## R2 — Theorem statements vs source

Cross-check each of the four T1 theorems against `v9_consolidated.md §B.1` / `exposition_v9.tex §3`:
- Are the hypotheses (`_hLocal`, `_hPareto`) parametric correctly?
- Does the conclusion exactly match the source (e.g., L8 says "active-face weights are Borel measurable; integrals define `g_i, q_i`"; does the theorem statement?

## R3 — Theorem proofs

The four T1 theorems are proved by literally `exact data.multiplierKernelData` (and analogous). This is "if data, then theorem" — a verifier.

Is this acceptable as a v9 ledger entry, given:
- The Inventory axioms `clarke_danskin_stationarity` + `clarke_fermat_normal_cone` are present but UNUSED in the proof bodies (they're black-boxed into the data witnesses).
- The actual α + (1-α) mixture-of-active-face-weights computation is hidden in the witness.

Or should the proofs explicitly invoke the Inventory axioms (and use them to construct the data witness conclusions)?

## R4 — Missing Inventory bridge

The prover flagged that to actually DERIVE the data witnesses from raw model primitives (not assume them), we need:
- A measurable-selection theorem for compact-convex set-valued maps.
- The translation `ClarkeNormalCone ↔ NormalConeW` for `PayoffProfileSet model`.

Neither is in scope yet. Confirm this is the correct gap, and flag whether it should be added as a follow-up Inventory axiom or postponed.

## R5 — Consistency with T1 / Binary / FBNF dependencies

`«binary-L_B5-endpoint-stationarity-total-balance»` and `«FBNF-F3-localized-stationarity-FBNF6»` take a universal hypothesis `hT1 : ∀ k (fd : FiniteMenuData model k), fd.multiplierBayesCone`. With the refinement, `fd.multiplierBayesCone` unfolds via the data-witness pattern. Does this make B5 and F3 trivially "fed by hypothesis = data"? Confirm this is still acceptable for v9 ledger semantics.

## R6 — Anything missed

Adversarial. Scan for any v9 §B.1 / §3 content that should be in the formalized T1 but isn't (e.g., the explicit formula `p_i = g_i / q_i`, the Borel measurability of `λ^+, λ^-`, the role of Pareto completion).

# Output

```
T1 BLOCK PROVER REVIEW — VERDICT: PASS / PATCH / RESTART

For each R1–R6:
  Verdict: OK / PATCH / FLAG
  If PATCH: precise patch (replacement statement, additional hypothesis, etc.)

OVERALL
  - Are the four T1 theorems mergeable to v9-formalization?
  - Confidence: HIGH / MEDIUM / LOW
  - One-paragraph summary
  - Follow-up: what additional Inventory / measurable-selection hammer is needed to derive `FiniteMenuData` from raw primitives?
```

Cite line numbers in v9_appendix.lean. Adversarial. Use as much reasoning time as needed.
