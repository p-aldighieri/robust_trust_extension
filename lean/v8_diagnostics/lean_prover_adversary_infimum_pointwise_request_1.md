You are the Lean Prover. Close ONE specific sorry: `adversary_infimum_pointwise` at line 1233 of main.lean. This is the foundational sInf-swap-with-kernel-integral identity that unlocks 3 downstream sorries.

## Target

```lean
theorem adversary_infimum_pointwise
    (model : RobustTrustModel)
    (w : model.M → ProfileInW model)
    (hw_meas : Measurable w)
    (hg_meas :
      Measurable fun p : model.M × model.M =>
        beliefDot (model.inclM p.1) (w p.2).val)
    (hw_bdd :
      ∃ C : ℝ, ∀ s m : model.M,
        |beliefDot (model.inclM s) (w m).val| ≤ C)
    (hinf_meas :
      Measurable fun s : model.M =>
        sInf (Set.range fun m : model.M =>
          beliefDot (model.inclM s) (w m).val))
    (hinf_int :
      Integrable
        (fun s : model.M =>
          sInf (Set.range fun m : model.M =>
            beliefDot (model.inclM s) (w m).val)) model.τM)
    (hkernel_int :
      ∀ β : AdviserKernel model,
        Integrable
          (fun p : model.M × model.M =>
            beliefDot (model.inclM p.1) (w p.2).val)
          (model.τM.compProd β.kernel)) :
    sInf (Set.range fun β : AdviserKernel model =>
      ∫ s, ∫ m, beliefDot (model.inclM s) (w m).val ∂(β.kernel s) ∂model.τM) =
        ∫ s, sInf (Set.range fun m : model.M =>
          beliefDot (model.inclM s) (w m).val) ∂model.τM := by
  sorry
```

## Math sketch

Define `g(s, m) := beliefDot (inclM s) (w m).val`. Bounded measurable function on M × M.

**≥ direction**: for each β, the inner integral satisfies (pointwise in s, β.kernel s is Markov):
- ∫ m, g(s, m) ∂(β.kernel s) ≥ ∫ m, sInf_m' g(s, m') ∂(β.kernel s) = sInf_m' g(s, m') · 1 = sInf_m' g(s, m').
Then integral_mono_ae gives outer ≥, hence sInf over β ≥ ∫ sInf_m dτM.

**≤ direction**: construct β* such that the LHS equals RHS. The natural witness: β*(s) = Dirac at argmin_m g(s, m). Need measurable selector m*(s) ∈ argmin_m g(s, m), which gives g(s, m*(s)) = sInf_m g(s, m) (compact M, continuous g(s, ·), so achieved).

For the selector: `Inventory.measurable_argmax_selector` (at top of main.lean, line 13) provides measurable argmax. For argmin, apply to `-g` or note Inventory provides the same upgrade.

`Inventory.measurable_argmax_selector`:
```
theorem measurable_argmax_selector {X Y : Type*}
    [MeasurableSpace X] [TopologicalSpace Y] [MeasurableSpace Y]
    [CompactSpace Y] [Nonempty Y]
    {Γ : X → Set Y} {f : X → Y → ℝ}
    (hΓ_meas : MeasurableSet {p : X × Y | p.2 ∈ Γ p.1})
    (hΓ_ne : ∀ x, (Γ x).Nonempty)
    (hΓ_compact : ∀ x, IsCompact (Γ x))
    (hf_meas : Measurable fun p : X × Y => f p.1 p.2)
    (hf_cont : ∀ x, ContinuousOn (fun y => f x y) (Γ x)) :
    ∃ sel : X → Y, Measurable sel ∧ ∀ x, sel x ∈ Γ x ∧ IsMaxOn (fun y => f x y) (Γ x) (sel x)
```

For our case: X = model.M, Y = model.M (compact, nonempty via M_compact, M_nonempty), Γ x = Set.univ, f(s, m) = -g(s, m) (for argmin). Then sel returns argmin_m g(s, m).

Continuity of `fun m => g(s, m)`: g(s, m) = beliefDot (inclM s) (w m).val. We have `w : M → ProfileInW model` MEASURABLE (not continuous), so g(s, ·) is only measurable, not continuous.

**Problem**: `measurable_argmax_selector` requires `ContinuousOn (fun y => f x y) (Γ x)` for each x. We only have measurability of w, so `fun m => g(s, m)` is only MEASURABLE, not continuous. So the inventory argmax selector doesn't directly apply.

**Workarounds**:
1. Use a measurable-selector version (e.g., Kuratowski-Ryll-Nardzewski) — but Inventory doesn't expose one.
2. Approximate via ε-optimal selector: for each ε > 0, the set `{m | g(s, m) ≤ sInf_m g + ε}` is measurable (preimage of (-∞, sInf+ε] under measurable g(s, ·)). Apply Borel selector to this set (e.g., `Inventory.jankov_von_neumann_universal_selection` or similar).

But we don't actually need argmin attainment — we just need: ∀ ε > 0, ∃ β with `∫ ∫ g ∂β ∂τM ≤ ∫ sInf_m g + ε`. The sInf over β then equals RHS.

**Cleaner approach via ε-selector**:
- For each ε > 0, construct β_ε: β_ε(s) = Dirac at m_ε(s) where m_ε(s) is a measurable selector of `{m | g(s, m) ≤ sInf_m g(s, ·) + ε}`. This set is measurable for each s by hinf_meas + hg_meas + measurableSet_le. Then ∫ ∫ g ∂β_ε ∂τM = ∫ g(s, m_ε(s)) dτM ≤ ∫ (sInf_m g(s, ·) + ε) dτM = ∫ sInf + ε.
- The measurable selector here can use the `Inventory.geps_borel_selector_upgrade` shape (with GepsRegularity needing closed-valued — which holds here if g(s, ·) is continuous). But again g is only measurable in m.

Hmm. Without continuity of g in m, the standard selector machinery fails.

**If you get stuck**: state STUCK with the precise selector lemma needed (e.g., "Kuratowski-Ryll-Nardzewski selector for measurable closed-valued correspondences"). This might be a genuine gap requiring a new Inventory lemma.

## Strategy

Try the ε-selector approach. If the measurable selector cannot be constructed without continuity, declare STUCK with the precise Mathlib selector lemma needed (e.g. `MeasureTheory.measurable_argmin_of_continuous` or similar) and what hypothesis would make it work.

Available in scope:
- Inventory.measurable_argmax_selector (sorry'd)
- Inventory.jankov_von_neumann_universal_selection (sorry'd)
- Standard Mathlib: `measurableSet_le`, `MeasurableSet.preimage`, `Measure.dirac`, kernel machinery.

## Output

```
lean_proof
target_lemma_slug: adversary_infimum_pointwise
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem adversary_infimum_pointwise ... := by
  -- your proof or STUCK diagnostic
```

Aim for 80-200 lines. May freely add private helpers. If STUCK, provide a precise diagnostic of which selector lemma is needed and a recommendation (add new Inventory lemma vs. add continuity hypothesis on w).
