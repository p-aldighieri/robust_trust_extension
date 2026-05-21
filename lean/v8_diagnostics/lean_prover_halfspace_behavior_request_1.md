You are the Lean Prover. Close ONE specific `sorry`.

## Target (in `namespace RobustTrustV8`, `import Mathlib`)

```lean
def BehaviorEquivalentTrustRegion (T U : Set WTABelief) : Prop :=
  InducedEffectiveMenu T = InducedEffectiveMenu U

def FullSimplexTrustRegion : Set WTABelief := Set.univ

theorem halfspace_behavior_equivalent_to_full_simplex :
    BehaviorEquivalentTrustRegion HalfspaceTrustRegion FullSimplexTrustRegion := by
  sorry
```

## Math + strategy

`BehaviorEquivalentTrustRegion T U := InducedEffectiveMenu T = InducedEffectiveMenu U`.

Need to show `InducedEffectiveMenu HalfspaceTrustRegion = InducedEffectiveMenu FullSimplexTrustRegion`.

Both equal `FullWTAVertexMenu`:
- LHS = `FullWTAVertexMenu` (by `halfspace_induced_effective_menu_equals_full_vertices`)
- RHS = `FullWTAVertexMenu` (FullSimplex contains every belief, including ones inducing each vertex)

But you may need to also prove `InducedEffectiveMenu FullSimplexTrustRegion = FullWTAVertexMenu` as a sub-step. That requires constructing 3 beliefs inducing each vertex — same as halfspace_contains_beliefs but for FullSimplex (which is universally easier since FullSimplex = Set.univ).

```lean
unfold BehaviorEquivalentTrustRegion
rw [halfspace_induced_effective_menu_equals_full_vertices]
-- now need to show FullWTAVertexMenu = InducedEffectiveMenu FullSimplexTrustRegion
symm
ext v
constructor
· rintro ⟨i, rfl, _⟩
  exact ⟨i, rfl⟩
· rintro ⟨i, rfl⟩
  -- construct a belief in FullSimplex (= Set.univ, trivially) inducing vertex i
  -- For i : Fin 3, use μ_i with μ_i.val i = 1, μ_i.val k = 0 for k ≠ i. Then WTAInducesVertex μ_i i.
  refine ⟨i, rfl, ?_⟩
  fin_cases i
  · refine ⟨⟨![1, 0, 0], ?_, ?_⟩, ?_, ?_⟩
    -- nonneg, sums to 1, in Set.univ, induces vertex 0
    sorry
  · sorry
  · sorry
```

The 3 case witness beliefs:
- vertex 0: ![1, 0, 0]
- vertex 1: ![0, 1, 0]
- vertex 2: ![0, 0, 1]

Each trivially in FullSimplex = Set.univ (Set.mem_univ).

## Output

```lean_proof
target_lemma_slug: halfspace_behavior_equivalent_to_full_simplex
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem halfspace_behavior_equivalent_to_full_simplex :
    BehaviorEquivalentTrustRegion HalfspaceTrustRegion FullSimplexTrustRegion := by
  ...
```
