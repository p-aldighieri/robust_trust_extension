You are the Lean Prover. Close ONE specific `sorry`.

## Target lemma + definitions (all in `namespace RobustTrustV8`, `import Mathlib`)

```lean
def WTAΩ : Type := Fin 3
abbrev WTABelief : Type := Belief WTAΩ
abbrev WTAProfile : Type := WTAΩ → ℝ

def WTA_vertex (i : WTAΩ) : WTAProfile := fun j => if i = j then 1 else -1
def WTAInducesVertex (μ : WTABelief) (i : WTAΩ) : Prop := ∀ k : WTAΩ, μ.val k ≤ μ.val i
def ContainsBeliefsForAllVertices (T : Set WTABelief) : Prop :=
  ∀ i : WTAΩ, ∃ μ : WTABelief, μ ∈ T ∧ WTAInducesVertex μ i
def FullWTAVertexMenu : Set WTAProfile := Set.range WTA_vertex
def InducedEffectiveMenu (T : Set WTABelief) : Set WTAProfile :=
  {v : WTAProfile | ∃ i : WTAΩ, v = WTA_vertex i ∧ ∃ μ : WTABelief, μ ∈ T ∧ WTAInducesVertex μ i}
def BehaviorEquivalentTrustRegion (T U : Set WTABelief) : Prop :=
  InducedEffectiveMenu T = InducedEffectiveMenu U
def MenuEngineArtifact (T : Set WTABelief) : Prop :=
  ContainsBeliefsForAllVertices T ∧
    InducedEffectiveMenu T = FullWTAVertexMenu ∧
    BehaviorEquivalentTrustRegion T FullSimplexTrustRegion
def HalfspaceTrustRegion : Set WTABelief := {μ : WTABelief | μ.val (0 : Fin 3) ≤ (2 : ℝ) / 5}
def FullSimplexTrustRegion : Set WTABelief := Set.univ

def HalfspaceWitnessStatement : Prop :=
  MenuEngineArtifact HalfspaceTrustRegion ∧ ¬ True -- approximate; ignore the negation half

-- Pre-existing proven sub-lemmas (in scope, available to use):
theorem halfspace_contains_beliefs_inducing_all_vertices :
    ContainsBeliefsForAllVertices HalfspaceTrustRegion := sorry  -- (still sorry)
theorem halfspace_induced_effective_menu_equals_full_vertices :
    InducedEffectiveMenu HalfspaceTrustRegion = FullWTAVertexMenu := sorry
theorem halfspace_behavior_equivalent_to_full_simplex :
    BehaviorEquivalentTrustRegion HalfspaceTrustRegion FullSimplexTrustRegion := sorry

theorem halfspace_witness_menu_engine_artifact :
    HalfspaceWitnessStatement := by
  sorry
```

Look at `HalfspaceWitnessStatement` in the actual code (it's `MenuEngineArtifact HalfspaceTrustRegion ∧ ...`). Likely the proof just packages the three sub-lemmas.

If you cannot find HalfspaceWitnessStatement's exact body or the three sub-lemmas are still sorry, return STUCK with what you'd need.

Output as usual:

```lean_proof
target_lemma_slug: halfspace_witness_menu_engine_artifact
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem halfspace_witness_menu_engine_artifact :
    HalfspaceWitnessStatement := by
  sorry
```
