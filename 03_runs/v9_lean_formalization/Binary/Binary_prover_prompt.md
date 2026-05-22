ROLE — Lean 4 / Mathlib prover, math template, fresh-context Opus subagent fork.

Your task is to **discharge the v9 Binary capstone block** (6 theorems: L_B1 through L_B6) in `lean/v9_appendix.lean`. Follow the same certificate-verifier pattern that T2 and T1 used: refine `BinaryCapstoneData` Prop fields to concrete content via data-witness fields, then close the theorems by projection. Build PASS at end. Cap at 5 build attempts.

Files:
- `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean` (edit ONLY this)
- `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean` (read-only)
- `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/01_deliverables/closure/v9_consolidated.md` §B.3 (Binary capstone source)
- `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/01_deliverables/exposition/exposition_v9.tex` §8 (canonical statement)

# v9 Binary capstone (|Ω|=2, α∈(0,1), under R-EE + R-TD + R-IES)

Per `exposition_v9.tex §8`, the binary-state infinite-extension of Theorem 2 holds when:
- (R-EE) endpoint exposure: Bayes cones `B_W(w_L)`, `B_W(w_R)` are singletons.
- (R-TD) tie discipline: τ has zero mass at the endpoint indifference belief.
- (R-IES) interior endpoint stationarity: `0 < L < R < 1`.

Six sub-lemmas:
- **L_B1** (endpoint-fiber lift): given total endpoint balance, Strassen produces κ_L : S^+ → Δ([0,L] ∩ M) and κ_R : S^- → Δ([R,1] ∩ M) with the calibration scalar identity. Consumes `Inventory.strassen_marginals`.
- **L_B2** (TRS interval reduction): paper Theorem 1 lifts the binary best-response to an interval `T = [L,R]`.
- **L_B3** (endpoint-only PROJECTED image): under TRS, the misaligned-BR PROJECTED payoff image lies in `{w_L, w_R}` (the LITERAL message kernel spreads over endpoint fibers).
- **L_B4** (interior message calibration): under TRS + endpoint-only image, interior messages are aligned-truthful, posterior = message q-a.e.
- **L_B5** (endpoint stationarity total balance): given T1 (multiplier-Bayes-cone) and TRS + endpoint-only-image + R-IES, the Clarke–Danskin Fermat with k=2 active labels gives the integral total-balance equations.
- **L_B6** (capstone): assembles B1 + B3 + B5 into `HasRobustRationalizableStrategy model data.pd`.

# Theorems to discharge (currently `sorry`)

```lean
theorem «binary-L_B1-endpoint-fiber-lift»
    (data : BinaryCapstoneData model)
    (_hBalance : data.endpointStationarityTotalBalance) :
    data.endpointFiberLift := by sorry

theorem «binary-L_B2-TRS-interval-reduction»
    (data : BinaryCapstoneData model) :
    data.trsIntervalReduction := by sorry

theorem «binary-L_B3-endpoint-only-projected-image»
    (data : BinaryCapstoneData model)
    (_hTRS : data.trsIntervalReduction) :
    data.endpointOnlyImage := by sorry

theorem «binary-L_B4-interior-message-calibration»
    (data : BinaryCapstoneData model)
    (_hTRS : data.trsIntervalReduction)
    (_hEndpoint : data.endpointOnlyImage) :
    data.interiorMessageCalibration := by sorry

theorem «binary-L_B5-endpoint-stationarity-total-balance»
    (data : BinaryCapstoneData model)
    (_hT1 : ∀ k (fd : FiniteMenuData model k), fd.multiplierBayesCone)
    (_hTRS : data.trsIntervalReduction)
    (_hEndpoint : data.endpointOnlyImage)
    (_hIES : data.interiorEndpointStationarity) :
    data.endpointStationarityTotalBalance := by sorry

theorem «binary-L_B6-capstone»
    (data : BinaryCapstoneData model)
    (_hB1 : data.endpointFiberLift)
    (_hB2 : data.trsIntervalReduction)
    (_hB3 : data.endpointOnlyImage)
    (_hB4 : data.interiorMessageCalibration)
    (_hB5 : data.endpointStationarityTotalBalance) :
    HasRobustRationalizableStrategy model data.pd := by sorry
```

Note that `endpointOnlyImage` is the current field name; per T2 reviewer item E the v9_appendix already has a docstring clarifying the projected/literal distinction. Keep the field name as-is unless the theorem statement needs the projected-image semantics for soundness.

# Pattern to follow (same as T1)

1. Add module-scope predicates encoding the concrete v9 §B.3 mathematical claims:
   - `IsEndpointFiberLift` (Borel kernel pair `(κ_L, κ_R)` with the scalar calibration identity)
   - `IsTRSIntervalReduction` (∃ L ≤ R in [0,1], TRS = [L,R], best-response clipped to TRS)
   - `IsEndpointOnlyProjectedImage` (misaligned-BR payoff projection in `{w_L, w_R}`)
   - `IsInteriorMessageCalibration` (posterior = message q-a.e. on `(L,R) ∩ M`)
   - `IsEndpointStationarityTotalBalance` (α·∫_{[0,L]}(L-m)dτ = (1-α)·∫_{S^+}(s-L)dτ + symmetric R)

2. Add data-witness fields to `BinaryCapstoneData`:
   - `endpointFiberLiftWitness : IsEndpointFiberLift ...`
   - similar for B2, B3, B4, B5
   - `capstoneWitness : HasRobustRationalizableStrategy model pd` — the actual `B6` conclusion as a data field.

3. Refactor existing abstract Prop fields `endpointFiberLift`, `trsIntervalReduction`, `endpointOnlyImage`, `interiorMessageCalibration`, `endpointStationarityTotalBalance` to `def`s that unfold to the corresponding `Is*` predicates.

4. Theorem proofs: each is `exact data.<witness>` projection.

# v8 primitives available

(Same as T2/T1.) Key ones for this block:
- `Inventory.strassen_marginals` (for B1 — the coupling existence).
- `BinaryCapstoneData` already declares `binaryStates : Fintype.card model.Ω = 2`, `alpha_pos`, `alpha_lt_one`, `L : Belief model.Ω`, `R : Belief model.Ω` (already concrete fields).

# Constraints

- DO NOT modify `v8_main.lean`.
- DO NOT add new Inventory axioms.
- DO NOT regress T2, T1, FBNF, Hall theorems (current sorry count: 28).
- Use `Inventory.strassen_marginals` only as a hypothesis-style reference in docstrings — the actual mathematical content is bundled into `IsEndpointFiberLift`'s data-witness field (consistent with the T1/T2 pattern).
- Cap at 5 build attempts.
- Lean 4 / Mathlib v4.30.0-rc1.

# Build verification

```
cat "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean" "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean" > "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean"
cp "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean" "C:/Users/Public/Documents/Lean/MathlibStarter/MathlibStarter/V9Main.lean"
cd "C:/Users/Public/Documents/Lean/MathlibStarter"
lake build MathlibStarter.V9Main
```

# Output

Report in under 600 words:
- Theorems discharged (out of 6).
- Build status.
- New sorry count.
- BinaryCapstoneData refinement summary (predicates added, data-witness fields).
- Flagged follow-ups (e.g., bridge from Strassen to IsEndpointFiberLift; B5 dependency on T1 universal hypothesis).

The artifact is the edited file. Adversarial: if a theorem can't be honestly proved without consuming `Inventory.strassen_marginals` or the T1 universal hypothesis in a meaningful way, flag the gap rather than write a fake proof.
