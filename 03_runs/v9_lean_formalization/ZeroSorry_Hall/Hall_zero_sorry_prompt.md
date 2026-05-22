ROLE — Lean 4 / Mathlib prover, ZERO-SORRY mode. Opus, math template. Fresh-context subagent fork.

# Mission (BLOCKING)

The v9 Hall block in `lean/v9_appendix.lean` currently has 5 honest sorries (open Mathlib bridges). Per user directive 2026-05-22 evening: **every sorry must become either a real Lean derivation OR a new `Inventory.V9` axiom with paper citation**. ZERO sorries allowed in the Hall block at end of this round.

# Targets — 5 Hall sorries

Approximate locations (from local grep, line numbers indicative):

1. **Hall G2c — dual-to-Strassen scalar test-function bridge** (~line 2538/2551)
   - From `PsiNonpos reg` (Borel-bounded vector prices) to the scalar dual-marginal inequality required by `Inventory.V9.strassen_marginals`.
   - Standard tool: separation theorem / Hahn–Banach on bounded Borel functions.
   - Acceptable resolution: real Lean proof using Mathlib's separation lemmas, OR `Inventory.V9` axiom citing "Kantorovich–Rubinstein duality (Kantorovich 1942 / Villani *Optimal Transport: Old and New*, 2009, Thm 5.10)".

2. **Hall G2c — Strassen coupling → AdviserKernel disintegration + calibration** (~line 2590/2598)
   - From the coupling π that Strassen produces, disintegrate into a Markov kernel and verify posterior in B(m) q-a.e.
   - Standard tool: Mathlib's `Kernel` API + `Measure.compProd` factorization.
   - Acceptable: real Lean proof using `MeasureTheory.Kernel.kernel_of_compProd` etc., OR `Inventory.V9` axiom citing "Bogachev *Measure Theory* Vol II, 2007, Thm 10.6.1 (disintegration on standard Borel spaces)".

3. **Hall biconditional — support-function csSup local boundedness** (~line 2637)
   - The Bayes cone B(m) has a continuous support function (Reg-2). Need `BddAbove ((fun μ => μ · y) '' B m)` for the csSup definition to work.
   - Standard tool: compact image under continuous map.
   - Acceptable: real Lean proof (compactness of B(m) inherits from a hyperspace; or use Mathlib's `IsCompact.bddAbove`), OR `Inventory.V9` axiom citing standard result.

4. **Hall biconditional — integration/rowwise-infimum forward direction** (~line 2476 area)
   - Forward direction of Hall: kernel exists → Ψ ≤ 0. The pointwise inequality `y(m)·m - h_B(m)(y(m)) ≤ 0` at kernel-support m, integrated against τ + κ.
   - Tool: `MeasureTheory.integral_mono_ae` + support function inequality.
   - Acceptable: real Lean proof.

5. **Bridge — QAE adversariality + Pβ=Pγα transfer** (~line 2804)
   - `robustRationalizableKernelExists_to_strategy` needs to turn the calibrated kernel + reg.σstar into a `Definition2QAEPredicate` witness. Need `IsAdversarialFull` from `KernelSupportedOnRegG + G_rowwise_minimizer`, and posterior alignment `Pβ = Pγα` q-a.e. from the disintegration identities.
   - Standard tool: v8 `pd.conditional_barycenter`, `pd.sourceLawβ_disintegrates`, `_plc.barycenter_eq_prior` (similar to AlphaZero closure).
   - Acceptable: real Lean proof (mirror AlphaZero's posterior-collapse template), OR `Inventory.V9` axiom citing standard disintegration result.

# Constraints (BLOCKING)

- **ZERO sorries left in the Hall block at end.** Every removed sorry must be:
  - A real Lean proof using Mathlib + v8 primitives + existing Inventory.V9 axioms, OR
  - A NEW `Inventory.V9` axiom with VERIFIABLE PAPER CITATION (author + year + book/paper title + chapter/section/theorem number).
- For each new axiom: the docstring must quote the standard form of the theorem, cite the source verbatim, and justify why Mathlib doesn't have it.
- Build MUST PASS. Iterate as many times as needed.
- Downstream typecheck: P2*/P3/P4 + G-addendum-variable-margin consume Hall-biconditional and robustRationalizableKernelExists_to_strategy — they must continue to typecheck.
- Do NOT touch Binary, FBNF, G4 — those are separate rounds. Only edit Hall-related declarations + add new Inventory.V9 axioms if needed.
- v8_main.lean is read-only.

# Files

- Edit: `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean`
- Read-only: `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean`
- Source: `v9_consolidated.md §B.5`, `exposition_v9.tex §11`

# Build verification

```bash
cat "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean" "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean" > "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean"
cp "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean" "C:/Users/Public/Documents/Lean/MathlibStarter/MathlibStarter/V9Main.lean"
cd "C:/Users/Public/Documents/Lean/MathlibStarter" && lake build MathlibStarter.V9Main
```

# Output (concise final report)

- Build status (PASS required).
- Final sorry count in v9_appendix.lean (target: 5 Hall sorries → 0).
- New Inventory.V9 axioms added: count + each name + paper citation.
- Per-sorry resolution: which became Lean proof, which became Inventory axiom.
- Downstream typecheck status.
