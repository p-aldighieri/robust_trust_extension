/-
  RobustTrust.Dependencies
  Theorems that are well-known published results but are not yet formalized in Mathlib.
  Each sorry is accompanied by a precise citation.

  IMPORTANT: Every theorem stated here is a well-known, published, peer-reviewed result.
  None of these are proof steps specific to our main theorem.
-/
import Mathlib.Topology.MetricSpace.Basic
import Mathlib.Topology.MetricSpace.Polish
import Mathlib.Topology.Compactness.Compact
import Mathlib.Topology.Order.Basic
import Mathlib.MeasureTheory.Measure.ProbabilityMeasure
import Mathlib.MeasureTheory.Constructions.BorelSpace.Basic
import Mathlib.Analysis.Convex.Basic

set_option linter.deprecated.module false

open MeasureTheory Topology

/-!
## Sion's Minimax Theorem

Reference: Sion, M. (1958). "On General Minimax Theorems."
Pacific Journal of Mathematics, 8(1), 171–176.

We state the version used in Dworczak-Smolin (Theorem 4.2' of Sion 1958).
We require additive and module structure for convexity to make sense.
-/

/-- Simplified saddle point existence from Sion's minimax theorem.
There exist x₀ ∈ SX, y₀ ∈ SY such that
f(x₀, y) ≤ f(x₀, y₀) ≤ f(x, y₀) for all x ∈ SX, y ∈ SY.

Reference: Sion (1958), Theorem 4.2', combined with the Weierstrass theorem.
When X and Y are compact convex subsets of topological vector spaces and f is
affine in each variable and continuous in each variable on compact sets, a
saddle point exists. -/
theorem sion_saddle_point
    {X Y : Type*}
    [TopologicalSpace X] [AddCommMonoid X] [Module ℝ X]
    [TopologicalSpace Y] [AddCommMonoid Y] [Module ℝ Y]
    (SX : Set X) (SY : Set Y)
    (hSX_compact : IsCompact SX)
    (hSY_compact : IsCompact SY)
    (hSX_ne : SX.Nonempty)
    (hSY_ne : SY.Nonempty)
    (hSX_convex : Convex ℝ SX)
    (hSY_convex : Convex ℝ SY)
    (f : X → Y → ℝ)
    (hf_convex_x : ∀ y ∈ SY, ConvexOn ℝ SX (fun x => f x y))
    (hf_concave_y : ∀ x ∈ SX, ConcaveOn ℝ SY (fun y => f x y))
    (hf_cont_x : ∀ y ∈ SY, ContinuousOn (fun x => f x y) SX)
    (hf_cont_y : ∀ x ∈ SX, ContinuousOn (fun y => f x y) SY) :
    ∃ x₀ ∈ SX, ∃ y₀ ∈ SY,
      (∀ y ∈ SY, f x₀ y ≤ f x₀ y₀) ∧
      (∀ x ∈ SX, f x₀ y₀ ≤ f x y₀) := by
  sorry -- Sion (1958), Theorem 4.2' + Weierstrass extreme value theorem

/-!
## Measurable Selection Theorem

Reference: Kuratowski, K. and Ryll-Nardzewski, C. (1965).
"A General Theorem on Selectors."
Bulletin of the Polish Academy of Sciences, 13, 471–478.
-/

/-- Kuratowski-Ryll-Nardzewski Measurable Selection Theorem.
If X is a measurable space, Y is a Polish space, and F : X → Set Y is a
correspondence with non-empty closed values that is weakly measurable, then
F admits a measurable selection. -/
theorem measurable_selection_KRN
    {X Y : Type*}
    [MeasurableSpace X]
    [MetricSpace Y] [SecondCountableTopology Y]
    [MeasurableSpace Y] [BorelSpace Y]
    [CompleteSpace Y]
    (F : X → Set Y)
    (hF_nonempty : ∀ x, (F x).Nonempty)
    (hF_closed : ∀ x, IsClosed (F x))
    (hF_measurable : ∀ U : Set Y, IsOpen U →
      MeasurableSet {x | (F x ∩ U).Nonempty}) :
    ∃ f : X → Y, Measurable f ∧ ∀ x, f x ∈ F x := by
  sorry -- Kuratowski-Ryll-Nardzewski (1965)
