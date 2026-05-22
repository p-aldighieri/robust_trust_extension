ROLE — Lean 4 / Mathlib prover, math template, fresh-context Opus subagent fork. CERTIFICATE-ELIMINATION mode.

# Mission

Per user directive 2026-05-22: the **certificate-verifier pattern is ASSUMPTION SMUGGLING and must be eliminated**. Convert the T1 block in `lean/v9_appendix.lean` from data-witness projections to actual derivations from `Inventory.V9.clarke_danskin_stationarity` and `Inventory.V9.clarke_fermat_normal_cone` + raw v8 primitives.

This is the same trajectory the AlphaZero work just did: take additional v8 hypothesis structures as theorem arguments, derive the conclusion in-Lean using Mathlib lemmas, with NO new axioms.

# Theorems in scope (4 T1 theorems + FiniteMenuData refactor)

1. `«T1-L6-integral-clarke-danskin-representation»` — current proof: `exact data.multiplierKernelData`. Replace with real derivation.
2. `«T1-L7-clarke-fermat-stationarity»` — current proof: `exact data.fermatCertificate`. Replace.
3. `«T1-L8-multipliers-are-calibration-kernel»` — current proof: `exact data.calibrationKernelData`. Replace.
4. `«T1-clarke-danskin-multiplier-bayes-cone»` — current proof: `exact data.bayesConeCertificate`. Replace.

# Mathematical content (v9_consolidated.md §B.1, exposition_v9.tex §3)

The finite-menu functional `F_k(w_1,...,w_k) = ∫_M [α·max_i s·w_i + (1-α)·min_i s·w_i] dτ(s)` is locally Lipschitz on `(Fin k → Profile model)`. At a Pareto-completed ambient local maximizer `(w_1, ..., w_k)`:

- **L6**: Clarke–Danskin gives measurable active-face weights `λ⁺(s), λ⁻(s) ∈ Δ(k)` such that `λ⁺(s)` is supported on argmax and `λ⁻(s)` on argmin. Defines integrated `g_i := α·∫_{S⁺_i} s dτ + (1−α)·∫_{S⁻_i} s dτ` and mass `q_i := α·τ(S⁺_i) + (1−α)·τ(S⁻_i)`.
- **L7**: Clarke–Fermat at the constrained max gives `∀ i, NormalConeW model (w_i) (g_i)` (per-label normal cone certificate).
- **L8**: The active-face weights are Borel measurable; integrals define `g_i, q_i` with `q_i ≥ 0` and `∑_i q_i = 1` (mass balance).
- **T1 final**: For `q_i > 0`, set `p_i := g_i / q_i ∈ Δ(Ω)`. Then `p_i ∈ BayesConeW model (w_i)`.

# Honest derivation route (per smuggling auditor + AlphaZero template)

1. **Add explicit v8/v9 hypothesis arguments** to each T1 theorem (matching the AlphaZero pattern). Likely candidates:
   - `(prs : ProfileRealizationSetup model)` for continuity of `profileOfPrivate`.
   - Maybe additional measurable-selection / disintegration hypotheses.
2. **Build `FiniteMenuData` constructively** — write a constructor lemma `FiniteMenuData.fromParetoMenu (paretoMenu : Fin k → Profile model) (hLocal : isLocalMax F_k paretoMenu) (hPareto : paretoCompleted paretoMenu) (prs : ProfileRealizationSetup model) : FiniteMenuData model k` that derives ALL four witness fields by applying `Inventory.V9.clarke_danskin_stationarity` and `Inventory.V9.clarke_fermat_normal_cone`.
3. The four T1 theorems then refactor to take primitive hypotheses directly and call into the constructor's logic, OR keep `FiniteMenuData` as the input but require it was built via the constructor.

# Constraints (BLOCKING)

- **NO new axioms.** Don't add `axiom`, `opaque`, `constant`. Use only existing `Inventory.V9.*` + v8 primitives + Mathlib.
- **Honest sorry allowed.** If you cannot fully derive a witness (e.g., measurable selection step needs a Mathlib lemma you can't locate), leave a precise `sorry` with documented gap.
- **NO certificate-verifier residue.** The theorem bodies cannot be `exact data.X` projection from a field that holds the conclusion. The data fields must themselves be derived from axioms/primitives.
- **Build MUST PASS.** Cap at 5 build attempts.
- **`FiniteMenuData` is still allowed to exist as a data structure**, but its witness fields must be derivable, not assumed-as-given. Show this by writing the constructor.

# Paper-source citations required

In the docstring of each Inventory.V9 axiom you consume:
- `Inventory.V9.clarke_danskin_stationarity` — Clarke 1990 §2.7, Theorem 2.7.5 (envelope rule for pointwise suprema).
- `Inventory.V9.clarke_fermat_normal_cone` — Clarke 1990 Fermat rule, §6.1 Theorem 6.1.1.

If these citations are not already in the docstrings, add them precisely.

# Files

- `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean` (edit ONLY this)
- `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean` (read-only)
- Source: `v9_consolidated.md §B.1`, `exposition_v9.tex §3`.

# Build verification

Standard:
```
cat v8_main.lean v9_appendix.lean > main.lean
cp main.lean ${MATHLIB}/V9Main.lean
cd ${MATHLIB} && lake build MathlibStarter.V9Main
```

# Output

Report under 600 words:
- Build status (PASS / FAIL).
- Source sorry count (target ≤ 4 for honest gaps; current is 0).
- New Inventory.V9 axioms added (target: 0; smuggling auditor will reject any).
- Hypothesis arguments added to T1 theorems.
- Sub-lemmas / `have`s introduced.
- Mathlib lemmas used.
- Honest sorries remaining with PRECISE reasons.
- Whether downstream theorems (binary L_B5, FBNF F3) still typecheck (their hypothesis was `∀ k (fd : FiniteMenuData model k), fd.multiplierBayesCone`).
