ROLE — Lean 4 / Mathlib prover, cert-elim mode. Model: gpt-5.5 with extra-high reasoning (Codex CLI).

# Mission

Eliminate certificate-verifier pattern from the **Binary capstone block** in `lean/v9_appendix.lean`. Per user policy 2026-05-22: certificate-verifier = SMUGGLED. The Binary block currently has 6 theorems all in cert-verifier form, projecting from `BinaryCapstoneData` witness fields.

# Targets (6 Binary capstone theorems)

1. `«binary-L_B1-endpoint-fiber-lift»` — currently `exact data.endpointFiberLiftWitness`
2. `«binary-L_B2-TRS-interval-reduction»` — currently `exact data.trsIntervalReductionWitness`
3. `«binary-L_B3-endpoint-only-projected-image»` — currently `exact data.endpointOnlyProjectedImageWitness`
4. `«binary-L_B4-interior-message-calibration»` — currently `exact data.interiorMessageCalibrationWitness`
5. `«binary-L_B5-endpoint-stationarity-total-balance»` — currently `exact data.endpointStationarityTotalBalanceWitness`
6. `«binary-L_B6-capstone»` — currently `exact data.capstoneWitness` (HasRobustRationalizableStrategy)

# Source math (v9_consolidated.md §B.3, exposition_v9.tex §8)

Binary state |Ω|=2, α∈(0,1), under R-EE+R-TD+R-IES:

- **L_B1**: Strassen-style endpoint-fiber transport. From endpoint balance equations, construct Borel kernels κ_L : S^+ → Δ([0,L]∩M), κ_R : S^- → Δ([R,1]∩M) with the scalar calibration identity α·cL + (1−α)·cR = 1.
- **L_B2**: TRS = [L,R]. Paper Theorem 1 reduction.
- **L_B3**: Misaligned BR projected image ⊆ {w_L, w_R}.
- **L_B4**: Interior messages aligned-truthful, posterior = message q-a.e.
- **L_B5**: Clarke–Danskin Fermat with k=2 active labels → integral total-balance equations.
- **L_B6**: Capstone — assemble B1+B3+B5 into HasRobustRationalizableStrategy.

# Refactor strategy

Same template as T1 round 2 and WTA round:

1. **Remove cert-verifier witness fields** from `BinaryCapstoneData`:
   - `endpointFiberLiftWitness`, `trsIntervalReductionWitness`,
     `endpointOnlyProjectedImageWitness`, `interiorMessageCalibrationWitness`,
     `endpointStationarityTotalBalanceWitness`, `capstoneWitness`.

2. **Keep primitive inputs** that genuinely carry hypothesis content:
   - `pd : PosteriorDisintegration`
   - `binaryStates`, `alpha_pos`, `alpha_lt_one`, `L`, `R`
   - `endpointExposure` (R-EE), `tieDiscipline` (R-TD), `interiorEndpointStationarity` (R-IES)
   - The concrete scalar fields `kappaL`, `kappaR`, `cL`, `cR`, `lL`, `rR`, `pL`, `pR`, `proj`, `post`, `interior`, `lhsL`, `rhsL`, `lhsR`, `rhsR` (these are honest inputs from the construction)
   - But REPLACE the `Is*` predicate witnesses with actual theorem-derived statements.

3. **Define concrete predicates** (already partially done):
   - `IsEndpointFiberLift`, `IsTRSIntervalReduction`, etc. — these are FINE (they're math content); the issue is using their inhabitation as a free field rather than deriving it.

4. **For each Binary theorem**, derive the conclusion from:
   - **L_B1**: `Inventory.V9.strassen_marginals` applied to the endpoint balance equations (which come from L_B5).
   - **L_B2**: Either accept as a primitive hypothesis (paper Theorem 1 is itself a result from Dworczak–Smolin 2026 paper, cited as an external dependency), OR derive from primitive trust-region setup.
   - **L_B3**: Algebra on the binary state simplex + endpoint comparison.
   - **L_B4**: Algebraic identity (under TRS, the only on-path interior mass is aligned).
   - **L_B5**: Apply the T1 universal hypothesis (`∀ k fd, fd.multiplierBayesCone`) with k=2.
   - **L_B6**: Combine the above to discharge `HasRobustRationalizableStrategy` (this is the bridge to v8's `Definition2QAEPredicate`, same shape as the AlphaZero + Hall bridge).

# Constraints (BLOCKING)

- NO new axioms beyond Inventory.V9 + paper-cited bridges. If a binary-specific Mathlib gap surfaces, add ONE axiom with verifiable paper citation; document.
- NO `exact data.<witness>` projections from cert-shaped fields.
- Honest sorry acceptable for unresolvable gaps with documented Mathlib lemma needed.
- Build MUST PASS.
- Downstream typecheck: `«FBNF-F1-conditional-B1-measurable-pasting»` (uses Binary B1) and `«G-addendum-binary-tie-splitting»` (uses Binary B1) must still typecheck.

# Plan suggestion

Big task with 6 theorems. Acceptable to produce honest partial:
- Discharge L_B2, L_B3, L_B4 fully (algebraic / structural).
- Discharge L_B5 via the T1 universal hypothesis chain.
- Leave L_B1 with a tightly-scoped sorry pointing at the Strassen→AdviserKernel disintegration (same gap as Hall G2c).
- Leave L_B6 with a sorry on the QAE bridge (same gap as Hall bridge).

But MUST eliminate all 6 `exact data.<witness>` projections.

# Files

- Edit: `lean/v9_appendix.lean` only.
- Source: v9_consolidated.md §B.3, exposition_v9.tex §8.

# Build verification

```bash
cat "lean/v8_main.lean" "lean/v9_appendix.lean" > "lean/main.lean"
cp "lean/main.lean" "C:/Users/Public/Documents/Lean/MathlibStarter/MathlibStarter/V9Main.lean"
cd "C:/Users/Public/Documents/Lean/MathlibStarter" && lake build MathlibStarter.V9Main
```

(If MathlibStarter copy ACL-blocked: fall back to lake env lean lean/main.lean from proof repo dir.)

# Output

Concise report:
- Build status.
- Sorry count.
- New axioms (count + paper-source).
- Witness fields removed.
- Per-theorem body shape (what each invokes).
- Honest sorries with PRECISE reasons + Mathlib lemma name if known.
- Downstream typecheck status.
