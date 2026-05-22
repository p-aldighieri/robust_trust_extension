ROLE — adversarial fresh-session peer-reviewer for the v9 Binary capstone block in Lean 4 / Mathlib.

Sources in project:
- `v9_appendix.lean` (Binary block just discharged via data-witness certificate-verifier pattern; 21 sorries remaining)
- `v8_main.lean` (baseline namespace `RobustTrustV8`)
- `v9_consolidated.md` §B.3 (Binary capstone source)
- `exposition_v9.tex` §8 (canonical statement)
- Existing T2 and T1 review responses (same pattern review precedents)

# What was proved

Six theorems in the binary capstone block:
1. `«binary-L_B1-endpoint-fiber-lift»`
2. `«binary-L_B2-TRS-interval-reduction»`
3. `«binary-L_B3-endpoint-only-projected-image»`
4. `«binary-L_B4-interior-message-calibration»`
5. `«binary-L_B5-endpoint-stationarity-total-balance»`
6. `«binary-L_B6-capstone»` (returns `HasRobustRationalizableStrategy model data.pd`)

# How it was proved

Same certificate-verifier pattern as T1/T2:
- 5 module-scope `Is*` predicates encoding concrete claims:
  - `IsEndpointFiberLift model α κL κR cL cR` (scalar calibration identity `α·cL + (1−α)·cR = 1`).
  - `IsTRSIntervalReduction lL rR` (`0 ≤ lL ≤ rR ≤ 1`).
  - `IsEndpointOnlyProjectedImage pL pR proj` (`∀ m, proj m = pL ∨ proj m = pR`).
  - `IsInteriorMessageCalibration post interior` (`∀ m, interior m → post m = inclM m`).
  - `IsEndpointStationarityTotalBalance lhsL rhsL lhsR rhsR` (pair of scalar equalities).
- 16 concrete data fields added to `BinaryCapstoneData` (`kappaL, kappaR, cL, cR, lL, rR, pL, pR, proj, post, interior, lhsL, rhsL, lhsR, rhsR`, ...).
- 6 witness fields.
- Old abstract Prop fields refactored to namespace defs unfolding via witnesses.
- Theorem proofs are projections.

# Honest caveats from prover

1. Strassen → IsEndpointFiberLift bridge NOT discharged. The actual application of `Inventory.strassen_marginals` to v9 §B.3 endpoint setup is bundled into the constructor obligation for any user supplying a `BinaryCapstoneData`.
2. T1 universal hypothesis `_hT1 : ∀ k (fd : FiniteMenuData model k), fd.multiplierBayesCone` in B5 is UNUSED in the projection-style proof.
3. B6 `capstoneWitness` directly holds `HasRobustRationalizableStrategy model pd` as a data field.

# Audit items

## R1 — Is* predicate soundness

Compare each `Is*` predicate against v9_consolidated.md §B.3 / exposition_v9.tex §8:

(a) `IsEndpointFiberLift` claims a scalar calibration identity. The source claim is Borel kernels `κ_L : S^+ → Δ([0,L] ∩ M)`, `κ_R : S^- → Δ([R,1] ∩ M)` with the **endpoint-fiber posterior identities** (vector numerator over scalar message marginal). Is the simplified scalar identity sufficient, or does it lose load-bearing content?

(b) `IsEndpointOnlyProjectedImage` correctly enforces the PROJECTED-payoff-only-on-endpoints interpretation (per reviewer item E from the original decomposition review). Confirm the LITERAL message kernel is not falsely constrained.

(c) `IsEndpointStationarityTotalBalance` reduces to two scalar equalities `lhsL = rhsL`, `lhsR = rhsR`. The source v9 §B.3 specifies:
- `α·∫_{[0,L]}(L-m)dτ = (1-α)·∫_{S^+}(s-L)dτ`
- `α·∫_{[R,1]}(m-R)dτ = (1-α)·∫_{S^-}(R-s)dτ`
Are the four scalar fields `lhsL, rhsL, lhsR, rhsR` substantively encoding these integrals, or just opaque reals that any user can set however they want?

(d) `IsTRSIntervalReduction` `0 ≤ lL ≤ rR ≤ 1` only encodes the interval shape, not the optimality of the TRS or the clipped continuation. Is this sufficient for v9 B2 semantics?

## R2 — Theorem statements vs source

- B1: returns `data.endpointFiberLift = IsEndpointFiberLift ... data.cL data.cR`. Does the conclusion fully match v9 §B.3 B1?
- B5: returns `IsEndpointStationarityTotalBalance ...`. Does this match the v9 §B.3 stationarity statement, or just the scalar shape of it?
- B6 (capstone): returns `HasRobustRationalizableStrategy model data.pd` directly. Is the proof body `exact data.capstoneWitness`, or does it actually assemble B1+B3+B5 into the conclusion? (The witness pattern would say "exact data.capstoneWitness" — confirm this is acceptable as v9 ledger semantics.)

## R3 — Strassen / T1 axiom usage

Per prover's flagged followup:
- `Inventory.strassen_marginals` is declared but NOT INVOKED in B1's proof body. The proof is `exact data.endpointFiberLiftWitness`.
- `_hT1` in B5 is unused.

Is this acceptable for v9 ledger semantics, or must B1 actually consume `strassen_marginals` and B5 actually consume the T1 universal hypothesis?

## R4 — R-EE, R-TD, R-IES role

The Binary capstone's stated primitive conditions are:
- R-EE (endpoint exposure)
- R-TD (tie discipline)
- R-IES (interior endpoint stationarity)

The current `BinaryCapstoneData` carries `endpointExposure : Prop`, `tieDiscipline : Prop`, `interiorEndpointStationarity : Prop` as abstract Prop fields (untouched from the original decomposition). Are these properly threaded into the proofs? The reviewer notes prover left them abstract.

## R5 — Cascading downstream consistency

- `«FBNF-F1-conditional-B1-measurable-pasting»` uses `data.endpointStationarityTotalBalance → data.endpointFiberLift`. After refactoring those fields to `def`s unfolding through `Is*` predicates, is F1's universal hypothesis still well-typed?
- `«G-addendum-binary-tie-splitting»` returns `hyp.data.endpointFiberLift`. Same check.

## R6 — Anything missed

Adversarial. Scan v9 §B.3 for any content not in the formalized block (e.g., the explicit formula for `σ̂*(m) = R(w*(Π_{[L,R]}(m)))`, the role of `Π_{[L,R]}` projection, the trust-region projection invariance).

# Output

```
BINARY PROVER REVIEW — VERDICT: PASS / PATCH / RESTART

For each R1–R6:
  Verdict: OK / PATCH / FLAG
  If PATCH: precise patch.

OVERALL
  - Mergeable to v9-formalization?
  - Confidence: HIGH / MEDIUM / LOW
  - One-paragraph summary
  - Follow-up Inventory / constructor lemmas needed.
```

Adversarial. Cite line numbers in v9_appendix.lean. Use as much reasoning time as needed.
