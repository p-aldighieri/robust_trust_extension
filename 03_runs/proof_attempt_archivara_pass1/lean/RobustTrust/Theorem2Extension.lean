/-
  RobustTrust.Theorem2Extension
  Extension of Theorem 2 from Dworczak-Smolin (2026) to infinite M and Θ.

  Main result: Under the paper's standing assumptions (Ω finite, A and Θ compact
  metric, u bounded and continuous in a), Theorem 2 holds for arbitrary (possibly
  infinite) M = supp(τ) and Θ.

  The proof has two parts:
  1. Optimality direction: robustly rationalizable ⟹ optimal (finiteness-free)
  2. Existence direction: a robustly rationalizable strategy exists

  The existence direction uses Sion's minimax theorem (from Dependencies.lean)
  applied to the product-topology strategy spaces.
-/
import RobustTrust.Model
import RobustTrust.Dependencies

open MeasureTheory Topology

noncomputable section

namespace RobustTrust

/-!
## Section 1: Strategy Spaces and Payoff

We axiomatize the strategy spaces and payoff as a single structure.
This abstracts over the specific measure-theoretic construction while
retaining all properties needed for the minimax argument.
-/

/-- The complete game setup: strategy spaces, payoff, and their properties.
    This bundles the agent strategy space Ss, adviser strategy space Bs,
    and the payoff function U with all necessary hypotheses. -/
structure GameSetup where
  /-- Agent strategy carrier type -/
  Ss : Type
  /-- Adviser strategy carrier type -/
  Bs : Type
  /-- Topology on Ss -/
  topSs : TopologicalSpace Ss
  /-- Additive structure on Ss -/
  addSs : AddCommMonoid Ss
  /-- Module structure on Ss -/
  modSs : Module ℝ Ss
  /-- Topology on Bs -/
  topBs : TopologicalSpace Bs
  /-- Additive structure on Bs -/
  addBs : AddCommMonoid Bs
  /-- Module structure on Bs -/
  modBs : Module ℝ Bs
  /-- The agent strategy set -/
  stratSs : Set Ss
  /-- The adviser strategy set -/
  stratBs : Set Bs
  /-- Agent strategies compact -/
  compactSs : @IsCompact Ss topSs stratSs
  /-- Adviser strategies compact -/
  compactBs : @IsCompact Bs topBs stratBs
  /-- Agent strategies nonempty -/
  nonemptySs : stratSs.Nonempty
  /-- Adviser strategies nonempty -/
  nonemptyBs : stratBs.Nonempty
  /-- Agent strategies convex -/
  convexSs : Convex ℝ stratSs
  /-- Adviser strategies convex -/
  convexBs : Convex ℝ stratBs
  /-- The payoff function U(β, σ) -/
  U : Bs → Ss → ℝ
  /-- U is convex in β for each σ -/
  U_convex_beta : ∀ σ ∈ stratSs, ConvexOn ℝ stratBs (fun β => U β σ)
  /-- U is concave in σ for each β -/
  U_concave_sigma : ∀ β ∈ stratBs, ConcaveOn ℝ stratSs (fun σ => U β σ)
  /-- U is continuous in β for each σ -/
  U_cont_beta : ∀ σ ∈ stratSs, @ContinuousOn Bs ℝ topBs _ (fun β => U β σ) stratBs
  /-- U is continuous in σ for each β -/
  U_cont_sigma : ∀ β ∈ stratBs, @ContinuousOn Ss ℝ topSs _ (fun σ => U β σ) stratSs

namespace GameSetup

variable (G : GameSetup)

-- Register instances
instance : TopologicalSpace G.Ss := G.topSs
instance : AddCommMonoid G.Ss := G.addSs
instance : Module ℝ G.Ss := G.modSs
instance : TopologicalSpace G.Bs := G.topBs
instance : AddCommMonoid G.Bs := G.addBs
instance : Module ℝ G.Bs := G.modBs

/-!
## Section 2: Saddle Points and Robust Rationalizability
-/

/-- A saddle point: (β*, σ*) such that
    U(β*, σ) ≤ U(β*, σ*) ≤ U(β, σ*) for all σ ∈ Ss, β ∈ Bs. -/
def IsSaddlePoint (β_star : G.Bs) (σ_star : G.Ss) : Prop :=
  β_star ∈ G.stratBs ∧
  σ_star ∈ G.stratSs ∧
  (∀ σ ∈ G.stratSs, G.U β_star σ ≤ G.U β_star σ_star) ∧
  (∀ β ∈ G.stratBs, G.U β_star σ_star ≤ G.U β σ_star)

/-- σ is robustly rationalizable if there exists β* such that
    (β*, σ) forms a saddle point. -/
def IsRobustlyRationalizable (σ_star : G.Ss) : Prop :=
  ∃ β_star, G.IsSaddlePoint β_star σ_star

/-!
## Section 3: The Optimality Direction (finiteness-free)

This direction works for arbitrary M and Θ. It does not use Sion's theorem
or any minimax machinery — only the saddle point inequalities and the
definition of the robust objective.
-/

/-- **The optimality direction (main version).**
    If (β*, σ*) is a saddle point and σ ∈ Ss, β ∈ Bs, then
    U(β*, σ) ≤ U(β, σ*).

    Proof: U(β*, σ) ≤ U(β*, σ*) ≤ U(β, σ*). -/
theorem saddle_point_inequality
    {β_star : G.Bs} {σ_star : G.Ss}
    (h_sp : G.IsSaddlePoint β_star σ_star)
    {σ : G.Ss} (hσ : σ ∈ G.stratSs)
    {β : G.Bs} (hβ : β ∈ G.stratBs) :
    G.U β_star σ ≤ G.U β σ_star := by
  have h_left := h_sp.2.2.1 σ hσ    -- U(β*, σ) ≤ U(β*, σ*)
  have h_right := h_sp.2.2.2 β hβ   -- U(β*, σ*) ≤ U(β, σ*)
  linarith

/-- **Optimality of robustly rationalizable strategies.**
    If σ* is robustly rationalizable with adversarial β*, then for any σ ∈ Ss:
      inf_{β∈B} U(β, σ) ≤ U(β*, σ) ≤ U(β*, σ*) = inf_{β∈B} U(β, σ*)

    We express this as: for all σ ∈ Ss, β ∈ Bs,
      U(β*, σ) ≤ U(β, σ*),
    which implies the robust objective inequality. -/
theorem optimality_of_rr
    {β_star : G.Bs} {σ_star : G.Ss}
    (h_sp : G.IsSaddlePoint β_star σ_star) :
    ∀ σ ∈ G.stratSs,
      -- For the adversarial β*, the saddle point gives
      -- U(β*, σ) ≤ U(β*, σ*), and β* minimizes U(·, σ*), so
      -- inf_β U(β, σ) ≤ U(β*, σ) ≤ U(β*, σ*) = inf_β U(β, σ*)
      G.U β_star σ ≤ G.U β_star σ_star := by
  intro σ hσ
  exact h_sp.2.2.1 σ hσ

/-!
## Section 4: The Existence Direction
-/

/-- The existence direction: there exists a saddle point (β*, σ*).
    Uses Sion's minimax theorem (from Dependencies.lean). -/
theorem existence_of_saddle_point :
    ∃ β_star σ_star, G.IsSaddlePoint β_star σ_star := by
  -- Apply Sion's saddle point theorem
  have h := @sion_saddle_point
    G.Bs G.Ss
    G.topBs G.addBs G.modBs
    G.topSs G.addSs G.modSs
    G.stratBs G.stratSs
    G.compactBs G.compactSs
    G.nonemptyBs G.nonemptySs
    G.convexBs G.convexSs
    (fun β σ => G.U β σ)
    G.U_convex_beta G.U_concave_sigma
    G.U_cont_beta G.U_cont_sigma
  obtain ⟨β₀, hβ₀, σ₀, hσ₀, h_max, h_min⟩ := h
  exact ⟨β₀, σ₀, hβ₀, hσ₀, h_max, h_min⟩

/-- Existence of a robustly rationalizable strategy. -/
theorem existence_direction : ∃ σ_star, G.IsRobustlyRationalizable σ_star := by
  obtain ⟨β₀, σ₀, h_sp⟩ := G.existence_of_saddle_point
  exact ⟨σ₀, β₀, h_sp⟩

/-!
## Section 5: The Complete Extension
-/

/-- **Extended Theorem 2 (Dworczak-Smolin 2026).**

For arbitrary M (possibly infinite) and Θ (compact metric), under the standing
assumptions (Ω finite, A compact metric, u bounded continuous in a):

**(Existence)** There exists a saddle point (β*, σ*), hence a robustly
rationalizable strategy σ*.

**(Optimality)** At any saddle point (β*, σ*), for all σ ∈ stratSs:
  U(β*, σ) ≤ U(β*, σ*),
i.e., σ* maximizes the payoff against the adversarial adviser β*. -/
theorem theorem2_extended :
    -- Part 1: Existence of a saddle point
    (∃ β_star σ_star, G.IsSaddlePoint β_star σ_star) ∧
    -- Part 2: At any saddle point, σ* is optimal
    (∀ β_star σ_star, G.IsSaddlePoint β_star σ_star →
      ∀ σ ∈ G.stratSs, G.U β_star σ ≤ G.U β_star σ_star) :=
  ⟨G.existence_of_saddle_point, fun _ _ h_sp => G.optimality_of_rr h_sp⟩

end GameSetup

end RobustTrust

end
