ROLE — Lean 4 / Mathlib prover, certificate-elimination mode. Model: gpt-5.5 with extra-high reasoning (Codex CLI).

# Mission

Eliminate certificate-verifier pattern from the **Hall biconditional block** in `lean/v9_appendix.lean`. This is the v9 classification engine — the headline theorem of the paper.

# Five Hall-block targets

1. `«Hall-G1-finite-cone-hall-farkas-LP»` — currently `exact inst.hallG1Witness`
2. `«Hall-G2c-borel-extension»` — currently `exact reg.hallG2cWitness hPsi`
3. `«Hall-biconditional»` — currently `exact reg.hallBiconditionalWitness`
4. `robustRationalizableKernelExists_to_strategy` — currently `exact reg.bridgeWitness h`
5. (Hall-WTA-dual-certificate-psi-two-ninths already eliminated in commit before this one.)

All four remaining theorems are cert-verifiers: their bodies project from witness fields on `RegPackage` or `FiniteConeHallInstance`.

# Source math (v9_consolidated.md §B.5 / exposition_v9.tex §11)

Under (Reg-1: closed-graph rowwise minimizer) + (Reg-2: continuous support function), with `Ω` finite, `M` compact metric, `α ∈ (0,1)`:

**Hall biconditional**: There exists a robustly rationalizable strategy at the fixed labeling `w*` ⟺ `Ψ(y) ≤ 0` for every bounded Borel `y : M → ℝ^|Ω|`, where:
```
Ψ(y) := α · ∫_M [y(m)·m - h_{B(m)}(y(m))] dτ(m)
      + (1−α) · ∫_M inf_{m' ∈ G(s)} [y(m')·s - h_{B(m')}(y(m'))] dτ(s)
```

**G1 (finite cone-Hall via Farkas)**: For a finite-dimensional approximation of the cone-Hall LP, primal flow feasibility ↔ dual Ψ ≤ 0. Direct application of `Inventory.V9.farkas_lp_duality_conic`.

**G2c (Borel extension)**: From Ψ ≤ 0 (the dual condition), construct a calibrated kernel `κ : AdviserKernel model` supported on `G(s)` with posterior in `B(m)` q-a.e. Uses `Inventory.V9.strassen_marginals` for the support-constrained coupling, plus measurable selection on `G`.

**Bridge** (`robustRationalizableKernelExists_to_strategy`): From `reg.robustRationalizableKernelExists` (which unfolds to `∃ κ, KernelSupportedOnRegG ∧ ∀ᵐ m, pd.Pγα κ m ∈ B m`), construct a strategy + adversary satisfying `Definition2QAEPredicate`. Use:
- `reg.σstar` (the realizing strategy, already in RegPackage)
- `reg.G_rowwise_minimizer` (concrete rowwise inequality on σstar)
- `reg.B_bayes_optimal` (concrete Bayes-optimality on σstar continuation)
- v8's `pd.sourceLawβ_disintegrates` to align γα second-marginal = MixtureMessageLaw second-marginal
- v8's `pd.conditional_barycenter` for posterior identification
- v8's `PosteriorLawConsistency` if needed (per AlphaZero precedent)

# Required refactor (per smuggling-check policy 2026-05-22)

1. **Remove witness fields** from `RegPackage` and `FiniteConeHallInstance`:
   - `RegPackage.hallG2cWitness` — REMOVE
   - `RegPackage.hallBiconditionalWitness` — REMOVE
   - `RegPackage.bridgeWitness` — REMOVE
   - `FiniteConeHallInstance.hallG1Witness` — REMOVE

2. **Define Ψ concretely** (already partially done — `RegPackage.Psi`, but it's an abstract field):
   ```lean
   noncomputable def regPsi (reg : RegPackage model) (y : BoundedBorelProfile model) : ℝ :=
     model.α * (∫ m, ...) + (1 - model.α) * (∫ s, sInf ...)
   ```
   Then `PsiNonpos reg := ∀ y, regPsi reg y ≤ 0`.

3. **Prove `«Hall-G1-...»`** by applying `Inventory.V9.farkas_lp_duality_conic` to a `FiniteConeHallInstance` constructed from the finite-dim approximation primitives. The current FiniteConeHallInstance has abstract `flowFeasible : Prop` and `psiNonpos : Prop` fields — these should be replaced with the concrete `conicPrimalFeasible inst` and `conicDualNonpositive inst` from `Inventory.V9`.

4. **Prove `«Hall-G2c-...»`** by:
   - Apply `Inventory.V9.strassen_marginals` to the (G, B)-constrained coupling problem.
   - Use Reg-1 closed-graph for the support relation, Reg-2 support-function continuity for the dual inequality.
   - Disintegrate the coupling into a Markov kernel.
   - The Ψ ≤ 0 hypothesis provides the Strassen dual condition.

5. **Prove `«Hall-biconditional»`** as two directions:
   - Forward (kernel exists → Ψ ≤ 0): support function inequality `y · m - h_B(m)(y) ≤ 0` at q-a.e. m, integrated.
   - Backward (Ψ ≤ 0 → kernel exists): apply G2c.

6. **Prove `robustRationalizableKernelExists_to_strategy`** by aligning the calibrated kernel with v8's `Definition2QAEPredicate` (same alignment work as AlphaZero round 3).

# Constraints (BLOCKING)

- NO new axioms beyond Inventory.V9 — IF you need a Mathlib bridge that doesn't exist, add ONE axiom with verifiable paper citation (e.g., Strassen 1965; KR duality; Hahn–Banach extension theorems from Bourbaki; Bogachev *Measure Theory* for disintegration). Document each new axiom with the paper citation.
- NO `exact reg.<witness>` projections from the conclusion-shaped fields.
- Honest sorry is acceptable for unresolvable gaps, but document precisely (with the missing Mathlib lemma name).
- Build MUST PASS.
- Downstream P2*/P3/P4/G-addendum-variable-margin theorems consume `Hall-biconditional` and `robustRationalizableKernelExists_to_strategy` — they must still typecheck.
- Don't touch T1, T2, WTA, Binary, FBNF (those are separate ledger items).

# Plan suggestion

This is a big task. Acceptable to do partial work: e.g., concretize `regPsi` def + prove Hall-G1 (Farkas one-liner) + leave Hall-G2c with a tightly-scoped honest sorry pointing at the Strassen + measurable-selection bridge. Document what's still needed.

But MUST eliminate all 4 `exact reg.<witness>` projections — at minimum each theorem body must invoke the relevant Inventory axiom + a non-trivial derivation (even if some terminal step is sorry'd).

# Files

- Edit: `lean/v9_appendix.lean`
- Read-only: `lean/v8_main.lean`
- Source: `v9_consolidated.md §B.5`, `exposition_v9.tex §11`

# Build verification

```bash
cat "lean/v8_main.lean" "lean/v9_appendix.lean" > "lean/main.lean"
cp "lean/main.lean" "C:/Users/Public/Documents/Lean/MathlibStarter/MathlibStarter/V9Main.lean"
cd "C:/Users/Public/Documents/Lean/MathlibStarter" && lake build MathlibStarter.V9Main
```

(Run from working dir `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension`. If `cp` to MathlibStarter is blocked by ACL, build via `lake env lean lean/main.lean` from the proof repo instead.)

# Output (final message)

Concise report:
- Build status (PASS/FAIL with error).
- Sorry count.
- New axioms added (count + paper-source citations).
- Witness fields removed from RegPackage / FiniteConeHallInstance.
- Theorem-body shapes: what each theorem now invokes (Inventory.V9.X axiom + which Mathlib lemmas).
- Honest sorries with PRECISE reasons.
- Downstream typecheck status (P2*/P3/P4 etc.).
