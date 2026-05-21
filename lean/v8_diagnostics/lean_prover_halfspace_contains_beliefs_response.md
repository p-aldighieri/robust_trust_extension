
========
ROLE: user (id=59d42d25-898e-4bd4-a9f1-3b8330db7c64)
========
You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)


lean
abbrev WTAΩ : Type := Fin 3
abbrev WTABelief : Type := Belief WTAΩ

def Belief (Ω : Type) [Fintype Ω] : Type :=
  {s : Ω → ℝ // (∀ ω : Ω, 0 ≤ s ω) ∧ (∑ ω : Ω, s ω) = 1}

def WTAInducesVertex (μ : WTABelief) (i : WTAΩ) : Prop :=
  ∀ k : WTAΩ, μ.val k ≤ μ.val i

def HalfspaceTrustRegion : Set WTABelief :=
  {μ : WTABelief | μ.val (0 : Fin 3) ≤ (2 : ℝ) / 5}

def ContainsBeliefsForAllVertices (T : Set WTABelief) : Prop :=
  ∀ i : WTAΩ, ∃ μ : WTABelief, μ ∈ T ∧ WTAInducesVertex μ i

theorem halfspace_contains_beliefs_inducing_all_vertices :
    ContainsBeliefsForAllVertices HalfspaceTrustRegion := by
  sorry


## Math

Need to construct 3 specific WTABeliefs, one inducing each vertex in Fin 3, all in HalfspaceTrustRegion (i.e., μ.val 0 ≤ 2/5):

1. **Vertex 0** (need μ.val 0 maximal AND ≤ 2/5): take μ.val = (2/5, 2/5, 1/5). Then μ(0)=2/5≥μ(1)=2/5, μ(0)=2/5≥μ(2)=1/5. ✓
2. **Vertex 1** (need μ.val 1 maximal AND μ(0) ≤ 2/5): take μ.val = (1/3, 1/3, 1/3). All equal so vertex-1 trivially induced. μ(0)=1/3 ≤ 2/5. ✓
3. **Vertex 2** (need μ.val 2 maximal AND μ(0) ≤ 2/5): take μ.val = (0, 0, 1). μ(0)=0 ≤ 2/5. μ(2)=1 ≥ μ(0)=0, μ(2)=1 ≥ μ(1)=0. ✓

## Proof strategy


lean
intro i
fin_cases i
case mk =>  -- Fin 3 = ⟨0, _⟩
  -- Vertex 0
  refine ⟨⟨![2/5, 2/5, 1/5], ?_, ?_⟩, ?_, ?_⟩
  · intro ω; fin_cases ω <;> norm_num
  · simp [Fin.sum_univ_three]; norm_num
  · -- ∈ HalfspaceTrustRegion: μ.val 0 ≤ 2/5
    simp [HalfspaceTrustRegion]
    norm_num
  · -- WTAInducesVertex μ 0
    intro k; fin_cases k <;> simp [Matrix.cons_val_zero, Matrix.cons_val_one] <;> norm_num
case ... =>  -- repeat for 1, 2
  ...


Use Fin.sum_univ_three to expand the sum.

## Output


lean_proof
target_lemma_slug: halfspace_contains_beliefs_inducing_all_vertices
status: PROVED | STUCK
tactics_used: [...]



lean
theorem halfspace_contains_beliefs_inducing_all_vertices :
    ContainsBeliefsForAllVertices HalfspaceTrustRegion := by
  -- your proof
  sorry


Aim for ~30-50 lines (3 case splits, each with a Belief construction + 3 conditions).

Show more

========
ROLE: assistant (id=4251fe62-cf7e-4e22-9ffe-ecf74ae27541)
========
lean_proof
target_lemma_slug: halfspace_contains_beliefs_inducing_all_vertices
status: PROVED
tactics_used: [intro, fin_cases, refine, constructor, simp, norm_num]
lean
theorem halfspace_contains_beliefs_inducing_all_vertices :
    ContainsBeliefsForAllVertices HalfspaceTrustRegion := by
  intro i
  fin_cases i
  · refine ⟨⟨![(2 : ℝ) / 5, (2 : ℝ) / 5, (1 : ℝ) / 5], ?_⟩, ?_⟩
    · constructor
      · intro ω
        fin_cases ω <;> simp <;> norm_num
      · simp [Fin.sum_univ_three] <;> norm_num
    · constructor
      · simp [HalfspaceTrustRegion] <;> norm_num
      · intro k
        fin_cases k <;> simp <;> norm_num
  · refine ⟨⟨![(1 : ℝ) / 3, (1 : ℝ) / 3, (1 : ℝ) / 3], ?_⟩, ?_⟩
    · constructor
      · intro ω
        fin_cases ω <;> simp <;> norm_num
      · simp [Fin.sum_univ_three] <;> norm_num
    · constructor
      · simp [HalfspaceTrustRegion] <;> norm_num
      · intro k
        fin_cases k <;> simp <;> norm_num
  · refine ⟨⟨![(0 : ℝ), (0 : ℝ), (1 : ℝ)], ?_⟩, ?_⟩
    · constructor
      · intro ω
        fin_cases ω <;> simp <;> norm_num
      · simp [Fin.sum_univ_three] <;> norm_num
    · constructor
      · simp [HalfspaceTrustRegion] <;> norm_num
      · intro k
        fin_cases k <;> simp <;> norm_num
