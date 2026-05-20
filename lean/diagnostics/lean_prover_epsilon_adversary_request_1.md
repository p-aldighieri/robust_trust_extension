You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)

```lean
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
```

## Key definitions

```lean
noncomputable def MixturePayoffFull (model : RobustTrustModel)
    (β : AdviserKernel model) (σFull : AgentStrategyFull model) : ℝ :=
  model.α * AlignedPayoffFull model σFull +
    (1 - model.α) * MisalignedPayoffFull model β σFull

noncomputable def RobustPayoffFull (model : RobustTrustModel)
    (σFull : AgentStrategyFull model) : ℝ :=
  sInf (Set.range fun β : AdviserKernel model => MixturePayoffFull model β σFull)

noncomputable def UStarFull (model : RobustTrustModel) : ℝ :=
  sSup (Set.range fun σFull : AgentStrategyFull model => RobustPayoffFull model σFull)
```

## Math sketch

RobustPayoffFull σ = sInf (range MixturePayoffFull · σ).

**Key approximation**: For any sInf with bounded-below range, ∀ ε > 0, ∃ x ∈ range with x < sInf + ε. (`Real.lt_sInf_add_pos` or `csInf_lt_iff` etc.)

Specifically, Mathlib has `Real.add_pos_lt_sInf_iff` or similar. The most useful:

```
theorem csInf_lt_iff {s : Set ℝ} (h_bdd : BddBelow s) (h_ne : s.Nonempty) (b : ℝ) :
    sInf s < b ↔ ∃ a ∈ s, a < b
```

or `Real.lt_sInf_add_pos`:

```
theorem Real.lt_sInf_add_pos {s : Set ℝ} (h_ne : s.Nonempty) (h_bdd : BddBelow s)
    {ε : ℝ} (hε : 0 < ε) : ∃ x ∈ s, x < sInf s + ε
```

(Names may differ — search Mathlib.)

### Conjunct 1: `MixturePayoffFull βε σstar ≤ RobustPayoffFull σstar + (1 - model.α) * ε`

This is the **tighter bound**. It requires using the α-convex-combination structure:

`MixturePayoffFull β σ = α A σ + (1-α) M β σ`

where A doesn't depend on β. So minimizing over β gives:
`sInf_β MixturePayoff β σ = α A σ + (1-α) sInf_β M β σ`.

So `RobustPayoffFull σ = α A σ + (1-α) sInf_β M β σ`.

By sInf approximation on `sInf_β M β σ`: ∃ βε with `M βε σ ≤ sInf_β M + ε`.

Then `MixturePayoff βε σ = α A + (1-α) M βε ≤ α A + (1-α) (sInf_β M + ε) = α A + (1-α) sInf_β M + (1-α) ε = RobustPayoff σ + (1-α) ε`. ✓

The sInf linearity step `sInf_β (α A + (1-α) M β) = α A + (1-α) sInf_β M β` uses:
- `Real.sInf_add_const` style lemma: `sInf {a + c | a ∈ s} = sInf s + c`
- `Real.sInf_const_mul` (for nonneg constant): `sInf {c * a | a ∈ s} = c * sInf s` for c ≥ 0

Need BddBelow witnesses too.

### Conjunct 2: `MixturePayoffFull βε σstar ≤ UStarFull model + ε`

Easier: `MixturePayoff βε σ ≤ Robust σ + (1-α) ε ≤ Robust σ + ε` (since (1-α) ≤ 1).

By `hσstar : Robust σ = UStarFull`, get `MixturePayoff βε σ ≤ UStarFull + ε`. ✓

### Substantive gap: BddBelow of range MixturePayoffFull · σstar

For the sInf approximation to work, we need `BddBelow (range MixturePayoffFull · σstar)`. This requires a uniform LOWER bound on `MixturePayoffFull β σstar` for all β. By the same machinery as `robust_range_bddAbove` (uniform sup-norm bound from `model.private_profile_bounded`), the integrand is bounded by `±C_bnd` uniformly, so `MixturePayoffFull β σstar ≥ -C_bnd`.

You may inline this BddBelow argument or factor as a helper.

## Strategy

1. Get C_bnd from `model.private_profile_bounded`.
2. Get BddBelow witness for `range MixturePayoffFull · σstar` (-C_bnd-ish).
3. Get the sInf-linearity decomposition `RobustPayoffFull σ = α A + (1-α) sInf_β M β σ`.
4. Apply `Real.lt_sInf_add_pos` (or equiv) to get `M βε σ ≤ sInf_β M + ε`.
5. Conclude `MixturePayoff βε σ ≤ RobustPayoff σ + (1-α) ε`.
6. Second conjunct follows from first + hσstar + (1-α) ≤ 1.

If sInf-linearity is hairy, you may **factor it as a sorry helper** with precise signature:
```lean
private lemma robust_payoff_full_decomp ... :
    RobustPayoffFull model σ = model.α * AlignedPayoffFull model σ +
      (1 - model.α) * sInf (Set.range fun β => MisalignedPayoffFull model β σ) := sorry
```

This is exactly the "sInf linearity in α-convex combination" gap that also appears in `exact_adversary_attainment`'s hmix. Discharging it would unlock both lemmas. If your proof creates this helper as a sorry, document it clearly.

## Output

```
lean_proof
target_lemma_slug: epsilon_adversary_realization
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem epsilon_adversary_realization ... := by
  -- your proof
```

You may freely add private helper lemmas. Aim for 60-150 lines.
