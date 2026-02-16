/-
  RobustTrust.Model
  Formalizes the model primitives for the Robust Trust framework.

  We define the model as a structure (a "bundled" collection of primitives)
  carrying the standing assumptions from Section 2 of Dworczak-Smolin (2026).
-/
import Mathlib.MeasureTheory.Measure.ProbabilityMeasure
import Mathlib.Topology.MetricSpace.Basic
import Mathlib.Topology.Metrizable.Basic
import Mathlib.Topology.MetricSpace.Polish
import Mathlib.MeasureTheory.Constructions.BorelSpace.Basic
import Mathlib.Data.Fintype.Basic
import Mathlib.Analysis.Convex.Basic

open MeasureTheory Topology

/-- The model primitives bundled into a structure. -/
structure RobustTrustModel where
  /-- The finite state space -/
  Ω : Type
  /-- Ω is finite -/
  finOmega : Fintype Ω
  /-- Ω has decidable equality -/
  decEqOmega : DecidableEq Ω
  /-- The action space -/
  A : Type
  /-- A is a topological space -/
  topA : TopologicalSpace A
  /-- A is compact -/
  compactA : CompactSpace A
  /-- A is a T2 space (Hausdorff) -/
  t2A : T2Space A
  /-- A has a measurable space structure (Borel) -/
  measA : MeasurableSpace A
  /-- A is a Borel space -/
  borelA : BorelSpace A
  /-- The agent type space -/
  Θ : Type
  /-- Θ is a topological space -/
  topTheta : TopologicalSpace Θ
  /-- Θ is compact -/
  compactTheta : CompactSpace Θ
  /-- Θ is a T2 space (Hausdorff) -/
  t2Theta : T2Space Θ
  /-- Θ has a measurable space structure (Borel) -/
  measTheta : MeasurableSpace Θ
  /-- Θ is a Borel space -/
  borelTheta : BorelSpace Θ
  /-- The utility function u(a, ω, θ) -/
  u : A → Ω → Θ → ℝ
  /-- u is bounded: there exists C such that |u(a,ω,θ)| ≤ C for all a,ω,θ -/
  u_bounded : ∃ C : ℝ, ∀ a ω θ, |u a ω θ| ≤ C
  /-- u is continuous in a for each fixed (ω, θ) -/
  u_continuous_a : ∀ ω θ, Continuous (fun a => u a ω θ)
  /-- The alignment probability -/
  α : ℝ
  /-- α is in [0, 1] -/
  alpha_nonneg : 0 ≤ α
  /-- α is at most 1 -/
  alpha_le_one : α ≤ 1
  /-- The prior distribution on Ω (as a function Ω → ℝ) -/
  μ₀ : Ω → ℝ
  /-- μ₀ is non-negative -/
  mu0_nonneg : ∀ ω, 0 ≤ μ₀ ω
  /-- μ₀ sums to 1 (using Fintype instance) -/
  mu0_sum : @Finset.sum Ω ℝ _ (@Finset.univ Ω finOmega) μ₀ = 1
  /-- μ₀ has full support -/
  mu0_pos : ∀ ω, 0 < μ₀ ω

namespace RobustTrustModel

variable (M : RobustTrustModel)

-- Register instances from the model structure
instance : Fintype M.Ω := M.finOmega
instance : DecidableEq M.Ω := M.decEqOmega
instance : TopologicalSpace M.A := M.topA
instance : CompactSpace M.A := M.compactA
instance : T2Space M.A := M.t2A
instance : MeasurableSpace M.A := M.measA
instance : BorelSpace M.A := M.borelA
instance : TopologicalSpace M.Θ := M.topTheta
instance : CompactSpace M.Θ := M.compactTheta
instance : T2Space M.Θ := M.t2Theta
instance : MeasurableSpace M.Θ := M.measTheta
instance : BorelSpace M.Θ := M.borelTheta

/-- A belief is a probability distribution on Ω (represented as a function). -/
abbrev Belief := M.Ω → ℝ

/-- A belief is valid if it is non-negative and sums to 1. -/
def IsValidBelief (μ : M.Belief) : Prop :=
  (∀ ω, 0 ≤ μ ω) ∧ (∑ ω : M.Ω, μ ω = 1)

/-- The set of valid beliefs (the simplex Δ(Ω)). -/
def BeliefSimplex : Set M.Belief :=
  {μ | M.IsValidBelief μ}

/-- An agent strategy function: maps (message, type) to a probability measure on A. -/
abbrev AgentStrategyFn :=
  M.Belief → M.Θ → @ProbabilityMeasure M.A M.measA

/-- A misaligned adviser strategy function: maps beliefs μ ∈ M to a probability measure
    on beliefs (the distribution of messages sent). Since M.Belief = M.Ω → ℝ and Ω is
    Fintype, we use the product measurable space. -/
abbrev AdviserStrategyFn :=
  M.Belief → ProbabilityMeasure M.Belief

/-- The prior is a valid belief. -/
theorem prior_valid : M.IsValidBelief M.μ₀ :=
  ⟨M.mu0_nonneg, M.mu0_sum⟩

end RobustTrustModel
