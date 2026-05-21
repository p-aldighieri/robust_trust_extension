You are the Lean Prover. Close ONE specific `sorry`.

## Target (in `namespace RobustTrustV8`, `import Mathlib`)

```lean
def WTAΩ : Type := Fin 3
abbrev WTABelief : Type := Belief WTAΩ
abbrev WTAProfile : Type := WTAΩ → ℝ

def WTA_vertex (i : WTAΩ) : WTAProfile := fun j => if i = j then 1 else -1
def WTAInducesVertex (μ : WTABelief) (i : WTAΩ) : Prop := ∀ k : WTAΩ, μ.val k ≤ μ.val i
def HalfspaceTrustRegion : Set WTABelief := {μ : WTABelief | μ.val (0 : Fin 3) ≤ (2 : ℝ) / 5}
def FullWTAVertexMenu : Set WTAProfile := Set.range WTA_vertex
def InducedEffectiveMenu (T : Set WTABelief) : Set WTAProfile :=
  {v : WTAProfile | ∃ i : WTAΩ, v = WTA_vertex i ∧ ∃ μ : WTABelief, μ ∈ T ∧ WTAInducesVertex μ i}
def ContainsBeliefsForAllVertices (T : Set WTABelief) : Prop :=
  ∀ i : WTAΩ, ∃ μ : WTABelief, μ ∈ T ∧ WTAInducesVertex μ i

-- AVAILABLE (already proved):
theorem halfspace_contains_beliefs_inducing_all_vertices :
    ContainsBeliefsForAllVertices HalfspaceTrustRegion := ...

theorem halfspace_induced_effective_menu_equals_full_vertices :
    InducedEffectiveMenu HalfspaceTrustRegion = FullWTAVertexMenu := by
  sorry
```

## Math

`InducedEffectiveMenu T = {WTA_vertex i | ∃ μ ∈ T, WTAInducesVertex μ i}`.
`FullWTAVertexMenu = Set.range WTA_vertex = {WTA_vertex i | i : WTAΩ}`.

When `T = HalfspaceTrustRegion`, by `halfspace_contains_beliefs_inducing_all_vertices`, ALL vertices i have some belief μ ∈ T inducing them. So `InducedEffectiveMenu HalfspaceTrustRegion = {WTA_vertex i | i : WTAΩ} = FullWTAVertexMenu`.

Conversely, every element of `InducedEffectiveMenu T` is `WTA_vertex i` for some i, hence in `FullWTAVertexMenu`.

## Proof strategy

```lean
ext v
constructor
· -- v ∈ InducedEffectiveMenu HalfspaceTrustRegion → v ∈ FullWTAVertexMenu
  rintro ⟨i, rfl, _⟩
  exact ⟨i, rfl⟩
· -- v ∈ FullWTAVertexMenu → v ∈ InducedEffectiveMenu HalfspaceTrustRegion
  rintro ⟨i, rfl⟩
  rcases halfspace_contains_beliefs_inducing_all_vertices i with ⟨μ, hμ_mem, hμ_induces⟩
  exact ⟨i, rfl, μ, hμ_mem, hμ_induces⟩
```

## Output

```lean_proof
target_lemma_slug: halfspace_induced_effective_menu_equals_full_vertices
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem halfspace_induced_effective_menu_equals_full_vertices :
    InducedEffectiveMenu HalfspaceTrustRegion = FullWTAVertexMenu := by
  ...
```
