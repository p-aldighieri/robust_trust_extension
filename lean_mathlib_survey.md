# Lean 4/Mathlib Survey for Theorem 2 Extension

## 1. Mathlib Coverage of Required Infrastructure

### 1.1 Compact Metric Spaces

**Status: Well-covered.**

- Module: `Mathlib.Topology.MetricSpace.Basic`
- Provides: `MetricSpace`, `PseudoMetricSpace`, `CompactSpace`, `IsCompact`
- Key results: Heine-Borel equivalences, sequential compactness, Arzela-Ascoli
- Also: `Mathlib.Topology.Compactness.Compact`, `Mathlib.Topology.MetricSpace.Polish`

### 1.2 Probability Measures

**Status: Well-covered.**

- Module: `Mathlib.MeasureTheory.Measure.ProbabilityMeasure`
- Provides: `ProbabilityMeasure α` as a type, equipped with the topology of convergence in distribution (weak topology)
- Key result: When the underlying space has a topology with Borel σ-algebra, the type of probability measures carries the weak convergence topology.

### 1.3 Weak-* / Weak Topology on Probability Measures

**Status: Partially covered.**

- Module: `Mathlib.MeasureTheory.Measure.LevyProkhorovMetric`
- Provides: Lévy-Prokhorov extended distance, `levyProkhorovEDist`
- The topology of the Lévy-Prokhorov metric is at least as fine as the topology of convergence in distribution
- Compactness of `ProbabilityMeasure α` when `α` is compact metric: this should follow from the existing framework (Prokhorov's theorem direction: compact metric → all measures are tight → relatively compact), but I did not find an explicit statement `IsCompact (Set.univ : Set (ProbabilityMeasure α))` for compact `α`.

### 1.4 Borel Sigma-Algebras

**Status: Well-covered.**

- Module: `Mathlib.MeasureTheory.Constructions.BorelSpace.Basic`
- Provides: `BorelSpace α` typeclass, `MeasurableSpace α` from topology
- Key: `borel α` generates the Borel σ-algebra from open sets

### 1.5 Markov Kernels

**Status: Well-covered.**

- Module: `Mathlib.Probability.Kernel.Basic` and related
- Provides: `Kernel α β` as a bundled measurable function from α to measures on β
- Types: `IsMarkovKernel`, `IsFiniteKernel`, `IsSFiniteKernel`
- Operations: composition (`∘ₖ`), parallel composition (`‖ₖ`), composition-product (`⊗ₖ`)
- Disintegration theorem for finite kernels on standard Borel spaces
- Conditional distributions and posterior kernels

### 1.6 Convexity in Topological Vector Spaces

**Status: Partially covered.**

- Module: `Mathlib.Analysis.Convex.Basic`, `Mathlib.Topology.Algebra.Module.Basic`
- Provides: `Convex ℝ s` for convex sets, convex functions, Jensen's inequality
- Topology on dual spaces: `Mathlib.Topology.Algebra.Module.WeakDual` provides weak-* topology
- **Gap**: Convexity of spaces of probability measures (as subsets of the dual of C(X)) is not directly formalized as a standalone result, though the ingredients are there.

### 1.7 Semicontinuity

**Status: Covered.**

- Module: `Mathlib.Topology.Semicontinuous`
- Provides: `LowerSemicontinuous f`, `UpperSemicontinuous f`
- Key results: semicontinuity of sup/inf of families of continuous functions

### 1.8 Polish Spaces

**Status: Well-covered.**

- Module: `Mathlib.Topology.MetricSpace.Polish`
- Provides: `PolishSpace α`, `StandardBorelSpace α`
- Key results: Analytic sets, Lusin-Souslin theorem, Lusin separation theorem, Borel isomorphism theorem

## 2. Sion's Minimax Theorem

**Status: NOT formalized in Mathlib.**

After extensive search (web, GitHub, Mathlib docs), Sion's minimax theorem has not been formally proven and merged into Mathlib as of early 2026. Neither has von Neumann's minimax theorem in its game-theoretic form.

**Implication**: This must go in the Dependencies.lean file with a `sorry`, citing Sion (1958).

## 3. Measurable Selection Theorems

**Status: NOT formalized in Mathlib.**

The Kuratowski-Ryll-Nardzewski measurable selection theorem is not directly formalized in Mathlib. However, many prerequisites exist:
- Analytic sets (`MeasureTheory.AnalyticSet`)
- Polish space structure
- Lusin separation and Lusin-Souslin theorems
- Borel σ-algebra infrastructure

**Implication**: This must go in Dependencies.lean with a `sorry`, citing Kuratowski-Ryll-Nardzewski (1965).

## 4. Compactness of Δ(A) under Weak-* Topology

**Status: Partially formalized.**

- The type `ProbabilityMeasure A` exists with the weak topology.
- For compact metric `A`, the space of probability measures should be compact (by Prokhorov), but I did not find an explicit Mathlib theorem stating this compactness.
- The Lévy-Prokhorov metric file has related material but may not state the full compactness result.

**Implication**: May need to go in Dependencies.lean, or may be derivable from existing Mathlib lemmas. We should attempt to construct the proof from Mathlib primitives first.

## 5. Key Lemmas and Their Mathlib Status

| Lemma | Mathlib Status | Module Path |
|-------|---------------|-------------|
| Compact metric ⟹ Polish | Available | `Mathlib.Topology.MetricSpace.Polish` |
| Probability measures form a measurable space | Available | `Mathlib.MeasureTheory.Measure.ProbabilityMeasure` |
| Weak topology on probability measures | Available | `Mathlib.MeasureTheory.Measure.ProbabilityMeasure` |
| Lévy-Prokhorov metric | Available | `Mathlib.MeasureTheory.Measure.LevyProkhorovMetric` |
| Markov kernel composition | Available | `Mathlib.Probability.Kernel.Basic` |
| Disintegration theorem | Available | `Mathlib.Probability.Kernel.Disintegration` |
| Conditional expectation | Available | `Mathlib.Probability.ConditionalExpectation` |
| Convex sets and functions | Available | `Mathlib.Analysis.Convex.Basic` |
| Jensen's inequality | Available | `Mathlib.Analysis.Convex.Integral` |
| Lower/upper semicontinuity | Available | `Mathlib.Topology.Semicontinuous` |
| Tychonoff's theorem | Available | `Mathlib.Topology.Compactness.Compact` |
| Borel σ-algebra | Available | `Mathlib.MeasureTheory.Constructions.BorelSpace.Basic` |
| Sion's minimax theorem | **NOT available** | Needs Dependencies.lean |
| Measurable selection (KRN) | **NOT available** | Needs Dependencies.lean |
| Δ(A) compact for compact A | **Uncertain** | May be derivable or need Dependencies.lean |
| Bayes-optimality as measurable map | **NOT available** | Needs custom proof or Dependencies.lean |

## 6. Theorems Requiring Dependencies.lean (with sorry)

1. **Sion's minimax theorem**: For X compact convex in a TVS, Y convex in a TVS, f: X×Y → ℝ quasi-concave-quasi-convex with appropriate semicontinuity, min_x sup_y f = sup_y min_x f. Reference: Sion (1958).

2. **Measurable selection theorem**: If F: X → 𝒫(Y) is a weakly measurable correspondence with non-empty closed values, X measurable, Y Polish, then F admits a measurable selector. Reference: Kuratowski-Ryll-Nardzewski (1965).

3. **Compactness of ProbabilityMeasure(A)**: If A is a compact metric space, then ProbabilityMeasure(A) is compact in the weak convergence topology. Reference: Prokhorov (1956), Billingsley (1999). (This may be provable from existing Mathlib if the right lemmas are available; we will attempt it first.)

4. **Bayes-optimal private strategy as a measurable function of the belief**: For bounded continuous u and compact A, the correspondence μ ↦ argmax_{σ̂} U(σ̂, μ) admits a measurable selection. This is a consequence of the Kuratowski-Ryll-Nardzewski theorem applied to the argmax correspondence. Reference: Aliprantis-Border (2006), Ch. 18.

## 7. Recommended Mathlib Imports

```lean
import Mathlib.Topology.MetricSpace.Basic
import Mathlib.Topology.MetricSpace.Polish
import Mathlib.Topology.Compactness.Compact
import Mathlib.Topology.Semicontinuous
import Mathlib.Topology.Algebra.Module.WeakDual
import Mathlib.MeasureTheory.Constructions.BorelSpace.Basic
import Mathlib.MeasureTheory.Measure.ProbabilityMeasure
import Mathlib.MeasureTheory.Measure.LevyProkhorovMetric
import Mathlib.Probability.Kernel.Basic
import Mathlib.Probability.Kernel.Disintegration
import Mathlib.Analysis.Convex.Basic
import Mathlib.Analysis.Convex.Integral
import Mathlib.Order.Filter.Basic
import Mathlib.Data.Fintype.Basic
```
