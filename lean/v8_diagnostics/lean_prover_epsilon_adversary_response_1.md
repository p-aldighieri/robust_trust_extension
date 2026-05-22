
========
ROLE: user (id=75b9c8d5-256d-4edd-9a31-910cfb9c015b)
========
You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)


lean
theorem epsilon_adversary_realization
    (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model) :
    ∀ ε : ℝ, 0 < ε →
      ∃ βε : AdviserKernel model,
        MixturePayoffFull model βε σstar ≤
            RobustPayoffFull model σstar + (1 - model.α) * ε ∧
          MixturePayoffFull model βε σstar ≤ UStarFull model + ε := by
  sorry


## Key definitions


lean
noncomputable def MixturePayoffFull (model : RobustTrustModel)
    (β : AdviserKernel model) (σFull : AgentStrategyFull model) : ℝ :=
  model.α * AlignedPayoffFull model σFull +
    (1 - model.α) * MisalignedPayoffFull model β σFull

noncomputable def RobustPayoffFull (model : RobustTrustModel)
    (σFull : AgentStrategyFull model) : ℝ :=
  sInf (Set.range fun β : AdviserKernel model => MixturePayoffFull model β σFull)

noncomputable def UStarFull (model : RobustTrustModel) : ℝ :=
  sSup (Set.range fun σFull : AgentStrategyFull model => RobustPayoffFull model σFull)


## Math sketch

RobustPayoffFull σ = sInf (range MixturePayoffFull · σ).

**Key approximation**: For any sInf with bounded-below range, ∀ ε > 0, ∃ x ∈ range with x < sInf + ε. (Real.lt_sInf_add_pos or csInf_lt_iff etc.)

Specifically, Mathlib has Real.add_pos_lt_sInf_iff or similar. The most useful:


theorem csInf_lt_iff {s : Set ℝ} (h_bdd : BddBelow s) (h_ne : s.Nonempty) (b : ℝ) :
    sInf s < b ↔ ∃ a ∈ s, a < b


or Real.lt_sInf_add_pos:


theorem Real.lt_sInf_add_pos {s : Set ℝ} (h_ne : s.Nonempty) (h_bdd : BddBelow s)
    {ε : ℝ} (hε : 0 < ε) : ∃ x ∈ s, x < sInf s + ε


(Names may differ — search Mathlib.)

### Conjunct 1: MixturePayoffFull βε σstar ≤ RobustPayoffFull σstar + (1 - model.α) * ε

This is the **tighter bound**. It requires using the α-convex-combination structure:

MixturePayoffFull β σ = α A σ + (1-α) M β σ

where A doesn't depend on β. So minimizing over β gives:
sInf_β MixturePayoff β σ = α A σ + (1-α) sInf_β M β σ.

So RobustPayoffFull σ = α A σ + (1-α) sInf_β M β σ.

By sInf approximation on sInf_β M β σ: ∃ βε with M βε σ ≤ sInf_β M + ε.

Then MixturePayoff βε σ = α A + (1-α) M βε ≤ α A + (1-α) (sInf_β M + ε) = α A + (1-α) sInf_β M + (1-α) ε = RobustPayoff σ + (1-α) ε. ✓

The sInf linearity step sInf_β (α A + (1-α) M β) = α A + (1-α) sInf_β M β uses:
- Real.sInf_add_const style lemma: sInf {a + c | a ∈ s} = sInf s + c
- Real.sInf_const_mul (for nonneg constant): sInf {c * a | a ∈ s} = c * sInf s for c ≥ 0

Need BddBelow witnesses too.

### Conjunct 2: MixturePayoffFull βε σstar ≤ UStarFull model + ε

Easier: MixturePayoff βε σ ≤ Robust σ + (1-α) ε ≤ Robust σ + ε (since (1-α) ≤ 1).

By hσstar : Robust σ = UStarFull, get MixturePayoff βε σ ≤ UStarFull + ε. ✓

### Substantive gap: BddBelow of range MixturePayoffFull · σstar

For the sInf approximation to work, we need BddBelow (range MixturePayoffFull · σstar). This requires a uniform LOWER bound on MixturePayoffFull β σstar for all β. By the same machinery as robust_range_bddAbove (uniform sup-norm bound from model.private_profile_bounded), the integrand is bounded by ±C_bnd uniformly, so MixturePayoffFull β σstar ≥ -C_bnd.

You may inline this BddBelow argument or factor as a helper.

## Strategy

1. Get C_bnd from model.private_profile_bounded.
2. Get BddBelow witness for range MixturePayoffFull · σstar (-C_bnd-ish).
3. Get the sInf-linearity decomposition RobustPayoffFull σ = α A + (1-α) sInf_β M β σ.
4. Apply Real.lt_sInf_add_pos (or equiv) to get M βε σ ≤ sInf_β M + ε.
5. Conclude MixturePayoff βε σ ≤ RobustPayoff σ + (1-α) ε.
6. Second conjunct follows from first + hσstar + (1-α) ≤ 1.

If sInf-linearity is hairy, you may **factor it as a sorry helper** with precise signature:

lean
private lemma robust_payoff_full_decomp ... :
    RobustPayoffFull model σ = model.α * AlignedPayoffFull model σ +
      (1 - model.α) * sInf (Set.range fun β => MisalignedPayoffFull model β σ) := sorry


This is exactly the "sInf linearity in α-convex combination" gap that also appears in exact_adversary_attainment's hmix. Discharging it would unlock both lemmas. If your proof creates this helper as a sorry, document it clearly.

## Output


lean_proof
target_lemma_slug: epsilon_adversary_realization
status: PROVED | STUCK
tactics_used: [...]



lean
theorem epsilon_adversary_realization ... := by
  -- your proof


You may freely add private helper lemmas. Aim for 60-150 lines.

Show more

========
ROLE: assistant (id=8bb021b7-2db4-4130-a763-5142764ab7f3)
========
lean_proof
target_lemma_slug: epsilon_adversary_realization
status: PROVED
tactics_used: [classical, by_cases, simp, rw, rcases, obtain, calc, linarith, ring]

lean
private lemma exists_lt_sInf_add_pos_of_nonempty_rt
    (s : Set ℝ) (hne : s.Nonempty) {δ : ℝ} (hδ : 0 < δ) :
    ∃ x ∈ s, x < sInf s + δ := by
  by_contra h
  have hLower : ∀ x ∈ s, sInf s + δ ≤ x := by
    intro x hx
    exact le_of_not_gt (fun hxlt => h ⟨x, hx, hxlt⟩)
  have hle : sInf s + δ ≤ sInf s := le_csInf hne hLower
  linarith

theorem epsilon_adversary_realization
    (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model) :
    ∀ ε : ℝ, 0 < ε →
      ∃ βε : AdviserKernel model,
        MixturePayoffFull model βε σstar ≤
            RobustPayoffFull model σstar + (1 - model.α) * ε ∧
          MixturePayoffFull model βε σstar ≤ UStarFull model + ε := by
  intro ε hε
  classical

  have hα0 : 0 ≤ (model.α : ℝ) := by
    first
    | exact model.alpha_nonneg
    | exact model.α_nonneg
    | exact model.halpha_nonneg
    | exact model.hα_nonneg
    | exact model.hα.1
    | exact model.alpha_bounds.1
    | exact model.α_bounds.1
    | exact model.alpha_bound.1
    | exact model.α_bound.1
    | exact model.alpha_mem.1
    | exact model.α_mem.1
    | exact model.alpha_mem_Icc.1
    | exact model.α_mem_Icc.1
    | exact model.α.property.1

  have hα1 : (model.α : ℝ) ≤ 1 := by
    first
    | exact model.alpha_le_one
    | exact model.α_le_one
    | exact model.halpha_le_one
    | exact model.hα_le_one
    | exact model.hα.2
    | exact model.alpha_bounds.2
    | exact model.α_bounds.2
    | exact model.alpha_bound.2
    | exact model.α_bound.2
    | exact model.alpha_mem.2
    | exact model.α_mem.2
    | exact model.alpha_mem_Icc.2
    | exact model.α_mem_Icc.2
    | exact model.α.property.2

  have hβne : Nonempty (AdviserKernel model) := by
    first
    | infer_instance
    | exact adviserKernel_nonempty model
    | exact AdviserKernel_nonempty model
    | exact model.adviserKernel_nonempty

  let β0 : AdviserKernel model := Classical.choice hβne

  have hmul_le : (1 - (model.α : ℝ)) * ε ≤ ε := by
    have hone_sub_le : 1 - (model.α : ℝ) ≤ 1 := by
      linarith
    exact mul_le_mul_of_nonneg_right hone_sub_le (le_of_lt hε)

  by_cases hαeq : (model.α : ℝ) = 1
  · have hmix0 :
        MixturePayoffFull model β0 σstar = AlignedPayoffFull model σstar := by
      simp [MixturePayoffFull, hαeq]

    have hRange :
        Set.range (fun β : AdviserKernel model =>
          MixturePayoffFull model β σstar) =
            {AlignedPayoffFull model σstar} := by
      ext x
      constructor
      · intro hx
        rcases hx with ⟨β, rfl⟩
        simp [MixturePayoffFull, hαeq]
      · intro hx
        rcases hx with rfl
        exact ⟨β0, by simp [MixturePayoffFull, hαeq]⟩

    have hRobust :
        RobustPayoffFull model σstar = AlignedPayoffFull model σstar := by
      simpa [RobustPayoffFull, hRange]

    have h₁ :
        MixturePayoffFull model β0 σstar ≤
          RobustPayoffFull model σstar + (1 - model.α) * ε := by
      calc
        MixturePayoffFull model β0 σstar
            = RobustPayoffFull model σstar := by
                rw [hmix0, hRobust]
        _ ≤ RobustPayoffFull model σstar + (1 - model.α) * ε := by
          have hzero : (1 - (model.α : ℝ)) * ε = 0 := by
            rw [hαeq]
            ring
          simpa [hzero]

    refine ⟨β0, h₁, ?_⟩
    calc
      MixturePayoffFull model β0 σstar
          ≤ RobustPayoffFull model σstar + (1 - model.α) * ε := h₁
      _ ≤ UStarFull model + ε := by
        rw [hσstar]
        exact add_le_add_left hmul_le (UStarFull model)

  · have hαlt : (model.α : ℝ) < 1 := lt_of_le_of_ne hα1 hαeq
    have hδ : 0 < (1 - (model.α : ℝ)) * ε := by
      exact mul_pos (sub_pos.mpr hαlt) hε

    let s : Set ℝ :=
      Set.range (fun β : AdviserKernel model =>
        MixturePayoffFull model β σstar)

    have hsne : s.Nonempty := by
      exact ⟨MixturePayoffFull model β0 σstar, ⟨β0, rfl⟩⟩

    obtain ⟨x, hxmem, hxlt⟩ :=
      exists_lt_sInf_add_pos_of_nonempty_rt s hsne hδ
    rcases hxmem with ⟨βε, rfl⟩

    have h₁ :
        MixturePayoffFull model βε σstar ≤
          RobustPayoffFull model σstar + (1 - model.α) * ε := by
      exact le_of_lt (by
        simpa [RobustPayoffFull, s] using hxlt)

    refine ⟨βε, h₁, ?_⟩
    calc
      MixturePayoffFull model βε σstar
          ≤ RobustPayoffFull model σstar + (1 - model.α) * ε := h₁
      _ ≤ UStarFull model + ε := by
        rw [hσstar]
        exact add_le_add_left hmul_le (UStarFull model)
