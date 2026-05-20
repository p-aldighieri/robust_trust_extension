You are the Lean Prover. Close ONE specific sorry: `strategy_value_le_menu_sup` at line 1286 of main.lean.

## Target

```lean
theorem strategy_value_le_menu_sup
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (σM : AgentStrategyM model) :
    RobustPayoffM model σM ≤ sSup (Set.range (MenuFunctionalF model)) := by
  sorry
```

## Key building block (just PROVED at line 1204): adversary_infimum_pointwise

For w : M → ProfileInW with measurability + boundedness + integrability hypotheses,
```
sInf (range β => ∫ s, ∫ m, beliefDot (inclM s) (w m).val ∂(β.kernel s) ∂τM)
  = ∫ s, sInf (range m => beliefDot (inclM s) (w m).val) ∂τM
```

## Math sketch

Construct C* := closed convex hull of range w_of_σ ⊆ ProfileInW, where
`w_of_σ m := ⟨profileMap σM m, ⟨σM.sectionM m, rfl⟩⟩ : ProfileInW model` (always in PayoffProfileSet).

For each s, since beliefDot (inclM s) · is linear in second arg:
- sup over closed conv hull of range = sup over range
- inf over closed conv hull of range = inf over range

So:
- maxPayoff C* s = sup_m beliefDot (inclM s) (profileMap σM m)
- minPayoff C* s = inf_m beliefDot (inclM s) (profileMap σM m) = sInf_m

Then:
- AlignedPayoffM σM = ∫ beliefDot(inclM s, profileMap σM s) dτM
  ≤ ∫ sup_m beliefDot(inclM s, profileMap σM m) dτM
  = ∫ maxPayoff C* dτM
- sInf_β MisalignedPayoffM β σM = ∫ sInf_m beliefDot(...) dτM  [adversary_infimum_pointwise]
  = ∫ minPayoff C* dτM
- RobustPayoff σM = sInf_β MixturePayoffM β σM = α A + (1-α) sInf_β M_β
  ≤ α ∫ max C* + (1-α) ∫ min C* = MenuFunctionalF C*
  ≤ sSup (range MenuFunctionalF)

For BddAbove (range MenuFunctionalF): mirror `menu_value_le_strategy_sup_robust_range_bddAbove`.
Use the uniform |beliefDot| ≤ B bound, every MenuFunctionalF C ∈ [-B, B].

## Definitions

```lean
abbrev ProfileInW (model) := {w : Profile model // w ∈ PayoffProfileSet model}
abbrev CompactMenu (model) := TopologicalSpace.NonemptyCompacts (ProfileInW model)
noncomputable def maxPayoff (model) (C) (s) : ℝ :=
  sSup ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) '' (↑C : Set _))
noncomputable def minPayoff (model) (C) (s) : ℝ := sInf (...)
noncomputable def MenuFunctionalF (model) (C) : ℝ :=
  ∫ s, model.α * maxPayoff C s + (1 - model.α) * minPayoff C s ∂model.τM
```

Available helpers in scope:
- `profileMap_measurable_for_kernel_bound model setup σM : Measurable (fun m => profileMap σM m)`
- `beliefDot_profileMap_uncurry_measurable model setup σM : Measurable (...)` (line ~1605)
- `beliefDot_profileMap_uniform_bound model σM : ∃ B, ∀ s m, ‖...‖ ≤ B`
- `integral_Icc_of_forall_abs_le_prob`
- `beliefDot_ProfileInW_abs_le_private_bound model : ∃ B ≥ 0, ∀ b w, |beliefDot b w.val| ≤ B`
- `maxPayoff_integrable`, `minPayoff_integrable model C` (for any C)
- `compact_menu_aligned_selection model C : ∃ wC ...` (line 1292)
- `adversary_infimum_pointwise` (line 1204, PROVED)
- `model.private_profile_bounded`, `setup.W_compact`, `setup.W_convex`, `setup.Φ_eq_profile`, `setup.Φ_continuous`

Mathlib helpers: `IsCompact.closure_subset_of_isClosed`, `subset_closure`, `IsClosed.closure_eq`, `IsLinearMap.csSup_convexHull`, `Convex.csInf_convexHull` (for sup/inf over conv hull = sup/inf over set, via linear functional).

## Strategy

1. **Build C***: `C* := closure (range w_of_σ) ⊆ ProfileInW model`.
   - IsCompact via `setup.W_compact.image (inclusion)` or `setup.W_compact` restricted to subtype, combined with `IsCompact.closure`.
   - Or simpler: `C* := setupNonemptyCompactsOfSetWInRange ...`.
   - The natural "full menu" is `Set.univ : Set (ProfileInW model)` if CompactSpace inst exists.
   - Use IsCompact_univ.

2. **Bounds**:
   - `hmax_bound s : beliefDot (inclM s) (profileMap σM s) ≤ maxPayoff C* s`
   - `hmin_bound s : minPayoff C* s ≤ sInf_m beliefDot (inclM s) (profileMap σM m)`
   (Both via membership of profileMap σM m in C*.)

3. **AlignedPayoff bound**: integrate hmax_bound.

4. **sInf MisalignedPayoff = ∫ sInf_m**: apply `adversary_infimum_pointwise` with `w := w_of_σ` and verify the 6 hypotheses (measurability of w, measurability of g, boundedness of g, measurability of sInf, integrability of sInf, integrability of g under compProd).

5. **RobustPayoff bound**: combine the additive decomposition. Need
   `sInf_β (α A + (1-α) M_β) = α A + (1-α) sInf_β M_β` — use `Real.sInf_const_add` or general `ciInf_add_const` after rewriting.

6. **MenuFunctionalF bound**: linearity (integral_add) + comparison.

7. **sSup**: use `le_csSup` with C* ∈ range and BddAbove (proved analogously to robust_range_bddAbove).

Aim for 150-400 lines. May add private helpers. If genuinely STUCK on Step 1 (compact menu construction), state STUCK with the precise mathlib lemma needed.

## Output

```
lean_proof
target_lemma_slug: strategy_value_le_menu_sup
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem strategy_value_le_menu_sup ... := by
  -- your proof
```

CRITICAL: model fields are `model.α/model.τM` (Greek). `AdviserKernel.kernel` is the field; `β.isMarkov` is Markov instance witness.
