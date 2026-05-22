You are the Lean Prover. Close ONE specific sorry — a measurability lemma.

## Target (in namespace RobustTrustV8, import Mathlib)

```lean
private lemma menu_integrand_aemeasurable
    (model : RobustTrustModel)
    (_setup : ProfileRealizationSetup model)
    (C : CompactMenu model) :
    AEMeasurable
      (fun s =>
        model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s)
      model.τM := by
  sorry
```

## Relevant definitions

```lean
noncomputable def maxPayoff (model : RobustTrustModel)
    (C : CompactMenu model) (s : model.M) : ℝ :=
  sSup ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
    (↑C : Set (ProfileInW model)))

noncomputable def minPayoff (model : RobustTrustModel)
    (C : CompactMenu model) (s : model.M) : ℝ :=
  sInf ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
    (↑C : Set (ProfileInW model)))

def beliefDot {Ω : Type} [Fintype Ω] (s : Belief Ω) (w : Ω → ℝ) : ℝ :=
  ∑ ω : Ω, s.val ω * w ω
```

Key facts:
- `model.inclM : model.M → Belief model.Ω` is `Measurable` (via `model.inclM_measurable`).
- `model.M` has [MetricSpace, MeasurableSpace, BorelSpace, StandardBorelSpace, SecondCountableTopology, CompactSpace, Nonempty].
- `model.Ω` is [Fintype, MeasurableSpace, Nonempty].
- `ProfileInW model = {w : (model.Ω → ℝ) // w ∈ Set.range model.profileOfPrivate}`.
- `C : NonemptyCompacts (ProfileInW model)`; `↑C : Set (ProfileInW model)` is compact.

## Math sketch

For each fixed `w : ProfileInW model`, the function `s ↦ beliefDot (inclM s) w.val` is measurable (composition of measurable inclM with a continuous linear functional in `s.val`).

To show measurability of `s ↦ sSup_{w ∈ ↑C} beliefDot (inclM s) w.val` (which is `maxPayoff`):

**Approach 1 (separability)**: Since `↑C` is compact in a separable space (ProfileInW model, subtype of finite-dim model.Ω → ℝ), it has a countable dense subset `D`. By continuity of `beliefDot (inclM s) ·.val` (continuous in w), `sSup_{w ∈ ↑C} = sSup_{w ∈ D}` for each s. Countable sSup of measurable functions is measurable.

**Approach 2 (Carathéodory)**: Use `Measurable.iSup` or `Measurable.sSup` for parametric families. Specifically Mathlib has results like `Measurable.sSup_set` (or similar — need to verify exact name).

**Approach 3 (continuity + compactness)**: 
- `(s, w) ↦ beliefDot (inclM s) w.val` is measurable jointly (product measurability).
- For each fixed s, the function `w ↦ beliefDot (inclM s) w.val` is continuous on ↑C compact.
- By the parametric Berge maximum theorem (or measurable selection theorems for compact-valued maps), the maximum `s ↦ sSup` is measurable.

The cleanest Mathlib lemma might be `IsCompact.measurable_csSup` or `MeasureTheory.AEMeasurable.csSup` over a fixed-domain compact family.

## Specifically usable lemmas

- `Measurable.iSup` — sSup of countable measurable family
- `Measurable.add`, `Measurable.const_mul`
- `Continuous.measurable` — needs `s ↦ inclM s` continuous which we don't have
- `Set.range_eq_iUnion_of_countable_separable` or similar for compact in separable

## Strategy

Given the typeclasses available on `model.M` and `ProfileInW model`, the cleanest path is:

1. Show `s ↦ maxPayoff C s` is **measurable** by:
   - Picking a countable dense subset `D ⊆ ↑C` (via `Metric.SecondCountableTopology` or similar — ProfileInW model is a subtype of finite-dim space, so separable).
   - For each `w ∈ D`, `s ↦ beliefDot (inclM s) w.val` is measurable.
   - `maxPayoff C s = sSup ((beliefDot (inclM s) ·.val) '' ↑C) = sSup (... '' D)` by continuity + density.
   - Countable sSup of measurable = measurable.

2. Same for `minPayoff` (sInf).

3. `α * max + (1-α) * min` is measurable by `Measurable.add` + `Measurable.const_mul`.

4. Convert to AEMeasurable via `Measurable.aemeasurable`.

If the Mathlib API for "countable dense in compact" + "sSup over dense = sSup over compact" is hairy, alternative is to bound max via Inventory.measurable_argmax_selector (already proved in context as `compact_menu_aligned_selection`):

```lean
obtain ⟨wmax, hwmax_meas, hwmax_mem, hwmax_max⟩ :=
  compact_menu_aligned_selection model C
-- Then maxPayoff C s = beliefDot (inclM s) (wmax s).val for all s.
-- The RHS is measurable in s (composition of measurable wmax + inclM).
```

Wait — this is the cleanest path! Use `compact_menu_aligned_selection` to get a measurable selector `wmax` realizing the argmax. Then `s ↦ maxPayoff C s = s ↦ beliefDot (inclM s) (wmax s).val`, which is measurable as a composition.

Similarly for minPayoff via dual argument or analogous helper (compact_menu_argmin_selection — would need to add).

For the AEMeasurable conclusion: Measurable → AEMeasurable trivially.

## Concrete strategy (recommended)

Use `compact_menu_aligned_selection` for max (already proved in main.lean, generalizes aligned_best_labeling_selection from OptimalMenuCstar to arbitrary CompactMenu).

For min: prove an analogous `compact_menu_alignedmin_selection` private helper. Same proof shape, swap IsMaxOn with IsMinOn. Or: invoke `compact_menu_aligned_selection` on a "flipped" beliefDot (multiply by -1) and recover via abs.

Even simpler: replicate `compact_menu_aligned_selection` for min by swapping `Inventory.measurable_argmax_selector` with a hypothetical `measurable_argmin_selector` — but Inventory only has argmax. So use the -1 trick:

```lean
-- minPayoff C s = -sSup (-beliefDot (inclM s) ·.val '' ↑C) = -(maxPayoff_with_flipped C s)
-- where flipped uses `-f`. Then measurability follows from max.
```

Or just write a separate `compact_menu_min_selection` helper.

## Output

```
lean_proof
target_lemma_slug: menu_integrand_aemeasurable
status: PROVED | STUCK
tactics_used: [...]
```

```lean
private lemma menu_integrand_aemeasurable
    (model : RobustTrustModel)
    (_setup : ProfileRealizationSetup model)
    (C : CompactMenu model) :
    AEMeasurable
      (fun s =>
        model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s)
      model.τM := by
  -- your proof
```

You may freely add private helper lemmas (`compact_menu_alignedmin_selection`, etc.). Aim for 30-80 lines.
