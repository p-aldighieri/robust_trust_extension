You are the Lean Prover. This is PASS 2 — your previous attempt was STUCK on a missing selector.

## Target (in namespace RobustTrustV8, import Mathlib)

```lean
theorem menu_value_le_strategy_sup
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (prm : ProfileRealizationMap model)
    (C : CompactMenu model) :
    MenuFunctionalF model C ≤ UStarM model := by
  sorry
```

## Helper lemma (proved separately, you can cite it freely)

```lean
private lemma compact_menu_aligned_selection
    (model : RobustTrustModel)
    (C : CompactMenu model) :
    ∃ wC : model.M → ProfileInW model,
      Measurable wC ∧
      (∀ m, wC m ∈ (↑C : Set (ProfileInW model))) ∧
      (∀ m,
        IsMaxOn (fun w : ProfileInW model => beliefDot (model.inclM m) w.val)
          (↑C : Set (ProfileInW model)) (wC m))
```

This is the generalization of `aligned_best_labeling_selection` from `OptimalMenuCstar` to arbitrary `CompactMenu`. The proof is a copy of the existing `aligned_best_labeling_selection` proof with `opt.Cstar` replaced by `C` (uses `Inventory.measurable_argmax_selector`).

## All relevant definitions

(Same as pass 1.)

## Math sketch

For any C : CompactMenu model, build σM_C : AgentStrategyM model that achieves payoff ≥ F(C):

**Step 1**: Use `compact_menu_aligned_selection model C` to get `⟨wC, hwC_meas, hwC_mem, hwC_max⟩`.

**Step 2**: Build `σM_C := { sectionM := fun m => prm.R (wC m), measurable_sectionM := prm.measurable_R.comp hwC_meas }`.

**Step 3**: Compute AlignedPayoffM σM_C:
```
AlignedPayoffM σM_C = ∫ s, beliefDot(inclM s) (profileMap σM_C s) dτM
                    = ∫ s, beliefDot(inclM s) (model.profileOfPrivate (prm.R (wC s))) dτM
                    = ∫ s, beliefDot(inclM s) (wC s).val dτM        (by prm.right_inverse)
                    = ∫ s, maxPayoff(C, s) dτM                       (by hwC_max + Set.IsMaxOn.sSup_eq for compact)
```

The last step: `maxPayoff C s = sSup ((beliefDot (inclM s) ·.val) '' ↑C)`. With `wC s ∈ ↑C` and `IsMaxOn (beliefDot (inclM s) ·.val) ↑C (wC s)`, we have `beliefDot(inclM s) (wC s).val = sSup ((beliefDot (inclM s) ·.val) '' ↑C) = maxPayoff(C, s)`.

Use `IsMaxOn.sSup_image_eq` or write directly:
```lean
have : beliefDot (model.inclM s) (wC s).val = maxPayoff model C s := by
  unfold maxPayoff
  symm
  refine IsLUB.csSup_eq ?_ ⟨_, ⟨wC s, hwC_mem s, rfl⟩⟩
  refine ⟨?_, ?_⟩
  · rintro x ⟨w, hw, rfl⟩
    exact hwC_max s ⟨w, hw⟩ (Set.mem_univ _)  -- or similar
    -- Actually: hwC_max gives `(fun w => beliefDot (inclM s) w.val) w' ≤ (fun w => beliefDot (inclM s) w.val) (wC s)` for w' ∈ ↑C
  · intro b hb
    exact hb ⟨wC s, hwC_mem s, rfl⟩
```

**Step 4**: For any β, MisalignedPayoffM β σM_C ≥ ∫ s, minPayoff(C, s) dτM.

```
MisalignedPayoffM β σM_C = ∫ s, ∫ m, beliefDot(inclM s) (profileMap σM_C m) ∂(β.kernel s) dτM
                        = ∫ s, ∫ m, beliefDot(inclM s) (wC m).val ∂(β.kernel s) dτM
```

For each (s, m), `beliefDot(inclM s) (wC m).val ≥ minPayoff(C, s)` (since wC m ∈ ↑C and minPayoff is sInf over ↑C).

```lean
have : ∀ s m, beliefDot (model.inclM s) (wC m).val ≥ minPayoff model C s := fun s m => by
  unfold minPayoff
  apply csInf_le
  · -- BddBelow witness (need uniform bound; can be -B for some B)
    sorry
  · exact ⟨wC m, hwC_mem m, rfl⟩
```

Then by monotonicity of integral (or just iInf/inf bounds):
```
MisalignedPayoffM β σM_C ≥ ∫ s, ∫ m, minPayoff(C, s) ∂(β.kernel s) dτM
                         = ∫ s, minPayoff(C, s) * β.kernel s univ dτM
                         = ∫ s, minPayoff(C, s) dτM   (β Markov so kernel univ = 1)
```

**Step 5**: sInf_β MisalignedPayoff ≥ ∫ minPayoff dτM.

**Step 6**: RobustPayoffM σM_C = α AlignedPayoff + (1-α) sInf MisalignedPayoff ≥ α ∫ max + (1-α) ∫ min = F(C).

**Step 7**: UStarM ≥ RobustPayoffM σM_C ≥ F(C) via `le_csSup`. Need BddAbove witness for `Set.range RobustPayoffM`.

## Simplification

If the full proof is too long, you may **assume** BddAbove for `Set.range RobustPayoffM` and `BddBelow` for `Set.range (fun w => beliefDot (inclM s) w.val) '' ↑C`. Cite them as sorried helpers. The substantive content (selector + integral comparison + le_csSup chain) is what we want.

If integrability / measurability gets hairy, return STUCK with the precise gap (e.g., "need measurability of s ↦ minPayoff(C, s)" — this is the same gap as in menu_functional_continuity).

## Output

```
lean_proof
target_lemma_slug: menu_value_le_strategy_sup
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem menu_value_le_strategy_sup ... := by
  -- your proof
```

Aim for 80-150 lines.
