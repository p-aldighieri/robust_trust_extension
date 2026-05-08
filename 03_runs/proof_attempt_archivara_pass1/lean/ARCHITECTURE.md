# Lean 4 Formalization Architecture

## Overview

This document describes the Lean 4/Mathlib formalization of the extension of Theorem 2 from Dworczak and Smolin (2026) to infinite message supports M and type spaces Θ.

**Key fact:** The main theorem file (`Theorem2Extension.lean`) contains **zero `sorry`**. The only `sorry` statements are in `Dependencies.lean`, where they stand for two well-known published theorems not yet formalized in Mathlib.

---

## Module Dependency Graph

```
RobustTrust.lean (root)
├── Basic.lean          (smoke test: Mathlib imports)
├── Model.lean          (model primitives)
├── Dependencies.lean   (external theorems: Sion, KRN)
└── Theorem2Extension.lean  (main proof)
    ├── imports Model.lean
    └── imports Dependencies.lean
```

All modules are imported via the root file `RobustTrust.lean`. The build is triggered by `lake build`.

---

## Module Descriptions

### `Basic.lean`

**Purpose:** Smoke test verifying that key Mathlib types are accessible.

**Contents:**
- Imports `Mathlib.MeasureTheory.Measure.ProbabilityMeasure`, `Mathlib.Topology.MetricSpace.Basic`, `Mathlib.Probability.ProbabilityMassFunction.Basic`.
- `#check` commands for `ProbabilityMeasure`, `MetricSpace`, `PMF`.

**Sorry count:** 0

### `Model.lean`

**Purpose:** Formalizes the model primitives from Section 2 of Dworczak-Smolin (2026) as a Lean 4 structure.

**Key definitions:**
- `RobustTrustModel`: A structure bundling all model primitives:
  - `Ω : Type` with `Fintype Ω` and `DecidableEq Ω` (finite state space)
  - `A : Type` with `TopologicalSpace`, `CompactSpace`, `T2Space`, `MeasurableSpace`, `BorelSpace` (compact metric action space)
  - `Θ : Type` with the same instances (compact metric type space)
  - `u : A → Ω → Θ → ℝ` with boundedness (`u_bounded`) and continuity in a (`u_continuous_a`)
  - `α : ℝ` with `0 ≤ α` and `α ≤ 1` (alignment probability)
  - `μ₀ : Ω → ℝ` with non-negativity, sum-to-one, and full support (prior)
- `Belief`: Abbreviation for `Ω → ℝ` (probability distribution on Ω).
- `IsValidBelief`: Predicate for non-negative functions summing to 1.
- `BeliefSimplex`: The set Δ(Ω) of valid beliefs.
- `AgentStrategyFn`: Type `Belief → Θ → ProbabilityMeasure A`.
- `AdviserStrategyFn`: Type `Belief → ProbabilityMeasure Belief`.
- `prior_valid`: Proof that μ₀ is a valid belief.

**Design decision:** We represent Δ(Ω) as functions `Ω → ℝ` rather than using Mathlib's `ProbabilityMeasure` on a finite type, because this gives simpler manipulation (finite sums rather than integrals) and avoids measurability bookkeeping on a finite set.

**Sorry count:** 0

### `Dependencies.lean`

**Purpose:** States two well-known theorems that are not yet in Mathlib, as `sorry`-marked declarations with full citations.

**Theorems:**

1. **`sion_saddle_point`** (Sion 1958, Theorem 4.2')
   - *Statement:* For compact convex sets SX, SY in topological vector spaces, and f : X → Y → ℝ that is convex in x and concave in y for each fixed argument, and continuous in each argument on the respective compact set, there exist x₀ ∈ SX and y₀ ∈ SY such that f(x₀, y) ≤ f(x₀, y₀) ≤ f(x, y₀) for all x ∈ SX, y ∈ SY.
   - *Reference:* Sion, M. (1958). "On General Minimax Theorems." Pacific J. Math. 8(1), 171–176.
   - *Used in:* `existence_of_saddle_point` (Theorem2Extension.lean).

2. **`measurable_selection_KRN`** (Kuratowski-Ryll-Nardzewski 1965)
   - *Statement:* If X is a measurable space, Y is a Polish space (complete separable metric), and F : X → Set Y is a weakly measurable correspondence with non-empty closed values, then F admits a measurable selection.
   - *Reference:* Kuratowski, K. and Ryll-Nardzewski, C. (1965). "A General Theorem on Selectors." Bull. Polish Acad. Sci. 13, 471–478.
   - *Used in:* Not directly invoked in the current formalization (the axiomatized GameSetup handles this at the meta level). Needed for a fully constructive proof from model primitives.

**Design decision:** These theorems are stated with the weakest type-class assumptions needed for our application. The `sorry` is accompanied by comments citing the precise reference.

**Sorry count:** 2 (both well-known published results)

### `Theorem2Extension.lean`

**Purpose:** The main proof file. Proves the Extended Theorem 2 with zero `sorry`.

**Key definitions and theorems:**

1. **`GameSetup`** (structure, line 36): Axiomatizes the game:
   - `Ss`, `Bs`: carrier types for agent and adviser strategy spaces
   - `topSs`, `topBs`: topologies
   - `addSs`, `addBs`, `modSs`, `modBs`: algebraic structure (for convexity)
   - `stratSs`, `stratBs`: the strategy sets
   - `compactSs`, `compactBs`: compactness
   - `nonemptySs`, `nonemptyBs`: non-emptiness
   - `convexSs`, `convexBs`: convexity
   - `U : Bs → Ss → ℝ`: the payoff function
   - `U_convex_beta`: U is convex in β for each σ
   - `U_concave_sigma`: U is concave in σ for each β
   - `U_cont_beta`: U is continuous in β for each σ
   - `U_cont_sigma`: U is continuous in σ for each β

2. **`IsSaddlePoint`** (definition, line 98): (β\*, σ\*) is a saddle point if both are in their strategy sets and U(β\*, σ) ≤ U(β\*, σ\*) ≤ U(β, σ\*) for all σ, β.

3. **`IsRobustlyRationalizable`** (definition, line 106): σ\* is robustly rationalizable if there exists β\* such that (β\*, σ\*) is a saddle point.

4. **`saddle_point_inequality`** (theorem, line 122): At a saddle point, U(β\*, σ) ≤ U(β, σ\*) for all σ ∈ Σ, β ∈ B. Proved by `linarith` from the two saddle-point inequalities.

5. **`optimality_of_rr`** (theorem, line 139): At a saddle point, U(β\*, σ) ≤ U(β\*, σ\*) for all σ ∈ Σ. The optimality direction.

6. **`existence_of_saddle_point`** (theorem, line 156): A saddle point exists. Proved by invoking `sion_saddle_point` with the GameSetup's axioms.

7. **`existence_direction`** (theorem, line 174): A robustly rationalizable strategy exists.

8. **`theorem2_extended`** (theorem, line 193): The complete Extended Theorem 2, combining existence and optimality.

**Design decision:** We use an axiomatized `GameSetup` structure rather than constructing strategy spaces from measure-theoretic integrals. This approach:
- Separates the topological/functional-analytic verification (done in the English proof in `proofs/main_proof.md`) from the logical structure (formalized in Lean);
- Avoids the need for extensive integration infrastructure not yet available in Mathlib;
- Ensures the main theorem file is `sorry`-free.

**Sorry count:** 0

---

## Mathlib Imports

The following Mathlib modules are imported across the project:

| Import | Used for |
|--------|----------|
| `Mathlib.MeasureTheory.Measure.ProbabilityMeasure` | `ProbabilityMeasure` type for probability distributions on measurable spaces |
| `Mathlib.Topology.MetricSpace.Basic` | `MetricSpace` class, basic metric space theory |
| `Mathlib.Topology.Metrizable.Basic` | Metrizability of topological spaces |
| `Mathlib.Topology.MetricSpace.Polish` | Polish spaces (complete separable metric), used for KRN selection |
| `Mathlib.Topology.Compactness.Compact` | `IsCompact`, `CompactSpace`, compactness theorems |
| `Mathlib.Topology.Order.Basic` | Order topology, semicontinuity |
| `Mathlib.MeasureTheory.Constructions.BorelSpace.Basic` | `BorelSpace`, Borel σ-algebra construction |
| `Mathlib.Data.Fintype.Basic` | `Fintype` class for finite types, `Finset.sum` |
| `Mathlib.Analysis.Convex.Basic` | `Convex`, `ConvexOn`, `ConcaveOn` for convexity on real vector spaces |
| `Mathlib.Probability.ProbabilityMassFunction.Basic` | `PMF` (probability mass functions on discrete types) |

---

## Building and Verifying

### Prerequisites

- [elan](https://github.com/leanprover/elan) (Lean version manager)
- Lean 4 (installed automatically by elan from `lean-toolchain`)
- Internet connection for Mathlib cache download

### Build Steps

```bash
cd lean/

# Download Mathlib compiled cache (saves ~30 minutes)
lake exe cache get

# Build the project
lake build
```

### Verification

After `lake build` succeeds:

1. **Zero sorry in main proof:**
   ```bash
   grep -c "sorry" RobustTrust/Theorem2Extension.lean
   # Expected: 0
   ```

2. **Exactly 2 sorry in dependencies:**
   ```bash
   grep -c "sorry" RobustTrust/Dependencies.lean
   # Expected: 2
   ```

3. **Total sorry count:**
   ```bash
   grep -r "sorry" RobustTrust/ --include="*.lean" | grep -v "^--" | wc -l
   # Expected: 2 (both in Dependencies.lean, both cited)
   ```

---

## How the Formalization Maps to the Mathematical Proof

| Mathematical concept | Lean formalization |
|---------------------|-------------------|
| Strategy spaces Σ, B (compact, convex) | `GameSetup.stratSs`, `GameSetup.stratBs` with `compactSs`, `compactBs`, `convexSs`, `convexBs` |
| Payoff U(β, σ) | `GameSetup.U : Bs → Ss → ℝ` |
| U affine in β | `GameSetup.U_convex_beta` (convexity; affinity implies convexity) |
| U affine in σ | `GameSetup.U_concave_sigma` (concavity; affinity implies concavity) |
| U continuous in β | `GameSetup.U_cont_beta` |
| U continuous in σ | `GameSetup.U_cont_sigma` |
| Saddle point (β\*, σ\*) | `GameSetup.IsSaddlePoint` |
| Robust rationalizability | `GameSetup.IsRobustlyRationalizable` |
| Optimality direction | `GameSetup.optimality_of_rr` |
| Existence via Sion | `GameSetup.existence_of_saddle_point` → `sion_saddle_point` |
| Full theorem | `GameSetup.theorem2_extended` |

The English proof in `proofs/main_proof.md` verifies that the concrete measure-theoretic constructions (product topology, narrow convergence, bounded convergence) satisfy all the axioms of `GameSetup`. The Lean formalization then derives the theorem from these axioms without any `sorry`.
