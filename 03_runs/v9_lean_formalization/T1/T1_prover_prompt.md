ROLE — Lean 4 / Mathlib prover, math template, fresh-context Opus subagent fork.

Your task is to **refine and prove the v9 T1 block** (Clarke–Danskin finite-menu Pareto-Hall calibration) in `lean/v9_appendix.lean`. The four T1 sub-lemmas + capstone form a tight dependency chain consuming the `Inventory.clarke_danskin_stationarity` and `Inventory.clarke_fermat_normal_cone` axioms (already declared with concrete hypothesis structures).

Files:
- `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean` (edit this, ONLY)
- `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean` (read-only; v8 model primitives)
- `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/01_deliverables/closure/v9_consolidated.md` §B.1 (T1 source math)
- `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/01_deliverables/exposition/exposition_v9.tex` §3 (canonical statement)

Theorems in scope (currently all `sorry`):
1. `«T1-L6-integral-clarke-danskin-representation»` — given `FiniteMenuData`, the Clarke–Danskin integral representation holds at the Pareto-completed ambient local maximizer. Consumes `Inventory.clarke_danskin_stationarity`.
2. `«T1-L7-clarke-fermat-stationarity»` — given L6, the Clarke–Fermat stationarity follows on the closed feasible set. Consumes `Inventory.clarke_fermat_normal_cone`.
3. `«T1-L8-multipliers-are-calibration-kernel»` — given L6 + L7, the resulting multipliers define a measurable calibration kernel.
4. `«T1-clarke-danskin-multiplier-bayes-cone»` — given L6 + L7 + L8, the normalized multiplier `p_i = g_i / q_i` lies in the Bayes cone `BayesConeW model w_i` whenever `q_i > 0`.

Also refine `FiniteMenuData` — its `clarkeDanskinRepresentation`, `clarkeFermatStationarity`, `multipliersAreCalibrationKernel`, `multiplierBayesCone` are still abstract `Prop` fields. Replace each with concrete content stating the actual mathematical claim. Example for `multiplierBayesCone`:

```lean
multiplierBayesCone :
  ∀ i : Fin k, 0 < q i →
    ∃ p : Belief model.Ω,
      (∀ ω, p.val ω = g i ω / q i) ∧ p ∈ BayesConeW model (w i)
```

The T1 proofs use the Inventory axioms as black boxes. The "real proof" is the translation from the axiom's abstract conclusion (e.g., `∃ ξ ∈ closure (convexHull ℝ (grad '' Active)), ξ ∈ ClarkeSubdiff F x`) to the v9 vocabulary (Bayes-cone membership of multiplier-normalized profiles).

# T1 mathematical content (v9_consolidated.md §B.1, exposition_v9.tex §3)

The finite-menu functional `F_k(w_1,...,w_k) = ∫_M [α·max_i s·w_i + (1-α)·min_i s·w_i] dτ(s)` is locally Lipschitz on `(Fin k → Profile model)`. At a Pareto-completed ambient local maximizer:
1. **L6** Clarke–Danskin representation: the Clarke subgradient is a measurable mixture of gradients of the integrand at active labels. The "max" part contributes `λ⁺(s)` weights on max-active labels; the "min" part contributes `λ⁻(s)` weights on min-active labels. Each `λ⁺(s), λ⁻(s) ∈ Δ(k)` is Borel measurable.
2. **L7** Clarke–Fermat: at a constrained local max on the closed set `WP^k`, the Clarke subgradient is in the negative normal cone of `WP^k` at the maximizer.
3. **L8** Multipliers as calibration kernel: the integrated active-face weights define `g_i := α·∫_{S^+_i} s dτ + (1-α)·∫_{S^-_i} s dτ` (vector numerator) and `q_i := α·τ(S^+_i) + (1-α)·τ(S^-_i)` (scalar message marginal); these are Borel measurable.
4. **T1 conclusion**: for `q_i > 0`, normalize `p_i := g_i / q_i`. The Fermat condition translates into "`p_i` is the posterior under which `w_i` is Bayes-optimal", i.e. `p_i ∈ BayesConeW model w_i`.

# Constraints

- **DO NOT** modify `v8_main.lean`.
- **DO NOT** add new `Inventory` axioms. Use only the existing `clarke_danskin_stationarity` and `clarke_fermat_normal_cone` (already declared).
- **DO NOT** introduce circular dependencies (L7 must not consume L8, etc.).
- **DO NOT** regress build of T2, binary, FBNF, Hall, P2*/P3/P4 theorems (they should remain at their current sorry count or fewer).
- For refining `FiniteMenuData`, you may need to add helper defs (e.g., `S_plus_i`, `S_minus_i` as active-label sets) at module scope.
- Cap iterations at **5 build attempts**. If you can't discharge all four T1 theorems in 5 attempts, discharge whichever go through and report which remain.

# Build verification

After edits:
```
cat "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean" "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean" > "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean"
cp "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean" "C:/Users/Public/Documents/Lean/MathlibStarter/MathlibStarter/V9Main.lean"
cd "C:/Users/Public/Documents/Lean/MathlibStarter"
lake build MathlibStarter.V9Main
```

Tail the output for `Build completed successfully` or errors. Build takes ~5 minutes incremental, ~10 minutes fresh.

# Output

Final report in under 600 words:
- List of theorems discharged (out of 4).
- Build status.
- Final sorry count (from `grep -c "sorry" v9_appendix.lean`).
- Brief summary of how `FiniteMenuData` was refined.
- Any flagged follow-ups (e.g., dependencies on Mathlib lemmas you couldn't locate, axiom hypotheses that need T1 itself to verify).

Adversarial: if any T1 theorem statement cannot be honestly proved from the existing Inventory axioms + v8 primitives, flag it rather than write a fake proof.
