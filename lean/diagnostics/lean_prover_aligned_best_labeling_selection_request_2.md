You are the Lean Prover. This is PASS 2 — your previous proof of `aligned_best_labeling_selection` failed AXLE check.

## AXLE errors

1. `aesop` failed (you used `measurability` for `hf_meas`, which calls aesop and timed out).
2. `simp` timeout (your `continuity` for `hf_cont` triggered nested `simp` whnf overflow at 200000 heartbeats).
3. Whole proof timed out at line 1229-1273 (combined effect).

## Diagnosis

The tactics `measurability` and `continuity` are heavy-weight and don't reliably terminate on goals involving `beliefDot` over `Fintype`-indexed sums into the subtype space. Need to prove measurability/continuity by explicit term-mode chains or `Finset.measurable_sum`/`Continuous.const_smul` etc.

## Fix needed

Replace `measurability` and `continuity` calls with explicit proofs:

```lean
have hf_meas : Measurable fun p : model.M × C => f p.1 p.2 := by
  dsimp [f]
  -- f p = beliefDot (model.inclM p.1) (p.2.val.val)
  -- beliefDot x w = ∑ ω, x.val ω * w ω
  -- So f p = ∑ ω, (model.inclM p.1).val ω * p.2.val.val ω
  -- The map p ↦ (model.inclM p.1).val is measurable (inclM measurable + Subtype.val)
  -- The map p ↦ p.2.val.val is measurable (Subtype.val composed)
  -- For each ω, the projection (·) ω is continuous (hence measurable)
  -- Sum is measurable
  apply Finset.measurable_sum
  intro ω _
  apply Measurable.mul
  · exact (measurable_subtype_coe.comp (model.inclM_measurable.comp measurable_fst)).eval ω
    -- (or whatever the right composition is)
  · exact (measurable_subtype_coe.comp (measurable_subtype_coe.comp measurable_snd)).eval ω

have hf_cont : ∀ x : model.M, ContinuousOn (fun y : C => f x y) (Γ x) := by
  intro x
  apply Continuous.continuousOn
  dsimp [f]
  -- f x y = ∑ ω, (model.inclM x).val ω * y.val.val ω
  apply continuous_finset_sum
  intro ω _
  apply Continuous.mul (continuous_const) _
  -- y ↦ y.val.val ω is continuous: Subtype.val ∘ Subtype.val composed with `fun w => w ω`
  exact (continuous_apply ω).comp (continuous_subtype_val.comp continuous_subtype_val)
```

(The exact Mathlib names may differ — adapt as needed. Key idea: don't use `measurability`/`continuity` tactics; build the chain explicitly.)

## Context (unchanged from pass 1)

Target lemma:
```lean
theorem aligned_best_labeling_selection
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model) :
    ∃ wlabel : AlignedBestLabelingWstar model opt,
      (∀ m : model.M, wlabel.wstar m ∈ (↑opt.Cstar : Set (ProfileInW model))) ∧
        (∀ m : model.M,
          IsMaxOn (fun w : ProfileInW model => beliefDot (model.inclM m) w.val)
            (↑opt.Cstar : Set (ProfileInW model)) (wlabel.wstar m)) := by
  sorry
```

Strategy: still apply `Inventory.measurable_argmax_selector`, but with manually-built `hf_meas` and `hf_cont`.

## Output

Return a complete revised proof. If `measurability`/`continuity` keep timing out, return STUCK with the specific measurability chain you need.

```lean_proof
target_lemma_slug: aligned_best_labeling_selection
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem aligned_best_labeling_selection ...
```
