You are the Lean Prover. Close 3 inline sorries inside `menu_value_le_strategy_sup` that share the same measure-theory bridge pattern. The measurability gap is now closed (menu_integrand_aemeasurable and MenuFunctionalF_le_of_contains_aligned_argmax are proved).

## Three target sorries

### Target 1: `hF_split` (integral linearity)

Inside `menu_value_le_strategy_sup` body:
```lean
have hF_split :
    MenuFunctionalF model C =
      model.α * (∫ s, @maxPayoff model C s ∂model.τM) +
        (1 - model.α) * (∫ s, @minPayoff model C s ∂model.τM) := by
  unfold MenuFunctionalF
  sorry
```

### Target 2: `hMis_per_β` (per-β misaligned bound)

```lean
have hMis_per_β :
    ∀ β : AdviserKernel model,
      (∫ s, @minPayoff model C s ∂model.τM)
        ≤ @MisalignedPayoffM model β σM_C := by
  intro β
  sorry
```

Context: `hmin_point : ∀ s m, minPayoff model C s ≤ beliefDot (model.inclM s) (profileMap model σM_C m)` is in scope.

### Target 3: `menu_value_le_strategy_sup_robust_range_bddAbove`

```lean
private lemma menu_value_le_strategy_sup_robust_range_bddAbove
    (model : RobustTrustModel) :
    BddAbove
      (Set.range (fun σ : AgentStrategyM model => @RobustPayoffM model σ)) := by
  sorry
```

## Available in main.lean (already proved)

```lean
-- Joint continuity of beliefDot
private lemma beliefDot_menu_uncurry_continuous (model) :
    Continuous (fun x : Belief model.Ω × ProfileInW model => beliefDot x.1 x.2.val)

-- Combined aemeasurable (gives individual max, min measurability internally)
private lemma menu_integrand_aemeasurable (model C) :
    AEMeasurable (fun s => model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s) model.τM
  -- INTERNAL: derives hmax_meas, hmin_meas as `Measurable (fun s => maxPayoff/minPayoff model C s)`

-- Combined bound
private lemma menu_integrand_mem_Icc_ae (model C) :
    ∃ B, ∀ᵐ s ∂model.τM, model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s ∈ Icc (-B) B

-- Already integrable
private lemma menu_integrand_integrable (model C) :
    Integrable (fun s => model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s) model.τM

-- Model bounds
model.private_profile_bounded : ∃ C, ∀ σ ω, |profileOfPrivate σ ω| ≤ C
model.α_nonneg, model.α_le_one, model.τM_prob
```

## Strategy

The measurability and bound infrastructure is in place. Need to:

### For sorries 1 (hF_split) and 3 (robust_range_bddAbove):

Build **individual** integrability of `maxPayoff model C ·` and `minPayoff model C ·` as helper lemmas (analogous to menu_integrand_aemeasurable but for max and min separately):

```lean
private lemma maxPayoff_aemeasurable (model C) :
    AEMeasurable (fun s : model.M => maxPayoff model C s) model.τM := by
  -- Use IsCompact.continuous_sSup directly (cf. menu_integrand_aemeasurable proof)
  classical
  have hdot : Continuous (Function.uncurry
      (fun b : Belief model.Ω => fun w : ProfileInW model => beliefDot b w.val)) := by
    simpa [Function.uncurry] using beliefDot_menu_uncurry_continuous model
  have hmax_cont : Continuous (fun b : Belief model.Ω =>
      sSup ((fun w : ProfileInW model => beliefDot b w.val) ''
        (↑C : Set (ProfileInW model)))) :=
    C.isCompact.continuous_sSup hdot
  have : Measurable (fun s : model.M => maxPayoff model C s) := by
    simpa [maxPayoff] using hmax_cont.measurable.comp model.inclM_measurable
  exact this.aemeasurable

private lemma minPayoff_aemeasurable (model C) : ...  -- analogous with continuous_sInf

private lemma maxPayoff_mem_Icc_ae (model C) :
    ∃ B, ∀ᵐ s ∂model.τM, maxPayoff model C s ∈ Icc (-B) B := by
  -- Same B as menu_integrand_mem_Icc_ae but for max alone
  -- Re-derive via Finset.sup' over Ω + private_profile_bounded
  sorry

private lemma maxPayoff_integrable (model C) :
    Integrable (fun s : model.M => maxPayoff model C s) model.τM := by
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  rcases maxPayoff_mem_Icc_ae model C with ⟨B, hB⟩
  exact Integrable.of_mem_Icc (-B) B (maxPayoff_aemeasurable model C) hB

-- Similarly minPayoff_integrable
```

With these, hF_split becomes:
```lean
have hα_max_int : Integrable (fun s => model.α * maxPayoff model C s) model.τM :=
  (maxPayoff_integrable model C).const_mul model.α
have h1α_min_int : Integrable (fun s => (1 - model.α) * minPayoff model C s) model.τM :=
  (minPayoff_integrable model C).const_mul (1 - model.α)
rw [integral_add hα_max_int h1α_min_int, integral_const_mul, integral_const_mul]
```

### For sorry 2 (hMis_per_β):

```lean
intro β
-- MisalignedPayoffM β σM_C = ∫ s, ∫ m, beliefDot (inclM s) (profileMap σM_C m) ∂(β.kernel s) ∂τM
-- Goal: ∫ minPayoff C ≤ MisalignedPayoffM
-- Per-s, per-m: minPayoff C s ≤ beliefDot ... (= hmin_point)
-- Integrate inner over β.kernel s (Markov so β.kernel s univ = 1)
-- ∫ minPayoff C s ∂(β.kernel s) = minPayoff C s * (β.kernel s univ) = minPayoff C s
-- So inner integral ≥ minPayoff C s.
-- Then integrate outer.
unfold MisalignedPayoffM
haveI := β.isMarkov
-- ... use integral_mono_ae + integral_const + Markov
sorry
```

Key Mathlib lemmas:
- `integral_const_of_isProbabilityMeasure` (or `integral_const`)
- `ProbabilityTheory.IsMarkovKernel` gives β.kernel s is a probability measure
- `MeasureTheory.integral_mono_ae`

### For sorry 3 (robust_range_bddAbove):

Take β0 = `Kernel.deterministic id measurable_id` (deterministic identity kernel). For β0, MisalignedPayoffM β0 σ = AlignedPayoffM σ (inner integral against Dirac collapses). 

```lean
classical
obtain ⟨C_bnd, hC_bnd⟩ := model.private_profile_bounded
haveI : IsProbabilityMeasure model.τM := model.τM_prob
-- For any σ, RobustPayoffM σ ≤ MixturePayoffM β0 σ = AlignedPayoffM σ ≤ C_bnd
let β0 : AdviserKernel model :=
  { kernel := ProbabilityTheory.Kernel.deterministic (id : model.M → model.M) measurable_id
    isMarkov := inferInstance }
refine ⟨C_bnd, ?_⟩
rintro x ⟨σ, rfl⟩
-- RobustPayoffM σ = sInf range MixturePayoffM · σ ≤ MixturePayoffM β0 σ (need BddBelow)
-- MixturePayoffM β0 σ = α A + (1-α) M β0 σ = (α + (1-α)) * A = A (Dirac)
-- A = ∫ beliefDot s (profile s) ∂τM, bounded by ∫ C_bnd ∂τM = C_bnd
sorry
```

## Output

```
lean_proof
target_lemma_slug: inline_bridges_cluster
status: PROVED | PARTIAL | STUCK
tactics_used: [...]
```

Provide ONE Lean block with:
1. Helper lemmas (maxPayoff_aemeasurable, maxPayoff_mem_Icc_ae, maxPayoff_integrable, and same for min — placed BEFORE menu_integrand_aemeasurable in main.lean).
2. Body for hF_split (replaces the sorry inside menu_value_le_strategy_sup).
3. Body for hMis_per_β (replaces the sorry inside menu_value_le_strategy_sup).
4. Body for menu_value_le_strategy_sup_robust_range_bddAbove (replaces the sorry).

Aim for 150-250 lines total. If hMis_per_β's kernel integration is intractable, you may STUCK only on that one and provide hF_split + robust_range_bddAbove cleanly.
