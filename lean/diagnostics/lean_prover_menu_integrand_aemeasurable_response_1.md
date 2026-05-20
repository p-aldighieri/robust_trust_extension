
========
ROLE: user (id=81d05368-e501-4175-855c-33a7420a9dd0)
========
You are the Lean Prover. Close ONE specific sorry — a measurability lemma.

## Target (in namespace RobustTrustV8, import Mathlib)


lean
private lemma menu_integrand_aemeasurable
    (model : RobustTrustModel)
    (_setup : ProfileRealizationSetup model)
    (C : CompactMenu model) :
    AEMeasurable
      (fun s =>
        model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s)
      model.τM := by
  sorry


## Relevant definitions


lean
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


Key facts:
- model.inclM : model.M → Belief model.Ω is Measurable (via model.inclM_measurable).
- model.M has [MetricSpace, MeasurableSpace, BorelSpace, StandardBorelSpace, SecondCountableTopology, CompactSpace, Nonempty].
- model.Ω is [Fintype, MeasurableSpace, Nonempty].
- ProfileInW model = {w : (model.Ω → ℝ) // w ∈ Set.range model.profileOfPrivate}.
- C : NonemptyCompacts (ProfileInW model); ↑C : Set (ProfileInW model) is compact.

## Math sketch

For each fixed w : ProfileInW model, the function s ↦ beliefDot (inclM s) w.val is measurable (composition of measurable inclM with a continuous linear functional in s.val).

To show measurability of s ↦ sSup_{w ∈ ↑C} beliefDot (inclM s) w.val (which is maxPayoff):

**Approach 1 (separability)**: Since ↑C is compact in a separable space (ProfileInW model, subtype of finite-dim model.Ω → ℝ), it has a countable dense subset D. By continuity of beliefDot (inclM s) ·.val (continuous in w), sSup_{w ∈ ↑C} = sSup_{w ∈ D} for each s. Countable sSup of measurable functions is measurable.

**Approach 2 (Carathéodory)**: Use Measurable.iSup or Measurable.sSup for parametric families. Specifically Mathlib has results like Measurable.sSup_set (or similar — need to verify exact name).

**Approach 3 (continuity + compactness)**: 
- (s, w) ↦ beliefDot (inclM s) w.val is measurable jointly (product measurability).
- For each fixed s, the function w ↦ beliefDot (inclM s) w.val is continuous on ↑C compact.
- By the parametric Berge maximum theorem (or measurable selection theorems for compact-valued maps), the maximum s ↦ sSup is measurable.

The cleanest Mathlib lemma might be IsCompact.measurable_csSup or MeasureTheory.AEMeasurable.csSup over a fixed-domain compact family.

## Specifically usable lemmas

- Measurable.iSup — sSup of countable measurable family
- Measurable.add, Measurable.const_mul
- Continuous.measurable — needs s ↦ inclM s continuous which we don't have
- Set.range_eq_iUnion_of_countable_separable or similar for compact in separable

## Strategy

Given the typeclasses available on model.M and ProfileInW model, the cleanest path is:

1. Show s ↦ maxPayoff C s is **measurable** by:
   - Picking a countable dense subset D ⊆ ↑C (via Metric.SecondCountableTopology or similar — ProfileInW model is a subtype of finite-dim space, so separable).
   - For each w ∈ D, s ↦ beliefDot (inclM s) w.val is measurable.
   - maxPayoff C s = sSup ((beliefDot (inclM s) ·.val) '' ↑C) = sSup (... '' D) by continuity + density.
   - Countable sSup of measurable = measurable.

2. Same for minPayoff (sInf).

3. α * max + (1-α) * min is measurable by Measurable.add + Measurable.const_mul.

4. Convert to AEMeasurable via Measurable.aemeasurable.

If the Mathlib API for "countable dense in compact" + "sSup over dense = sSup over compact" is hairy, alternative is to bound max via Inventory.measurable_argmax_selector (already proved in context as compact_menu_aligned_selection):


lean
obtain ⟨wmax, hwmax_meas, hwmax_mem, hwmax_max⟩ :=
  compact_menu_aligned_selection model C
-- Then maxPayoff C s = beliefDot (inclM s) (wmax s).val for all s.
-- The RHS is measurable in s (composition of measurable wmax + inclM).


Wait — this is the cleanest path! Use compact_menu_aligned_selection to get a measurable selector wmax realizing the argmax. Then s ↦ maxPayoff C s = s ↦ beliefDot (inclM s) (wmax s).val, which is measurable as a composition.

Similarly for minPayoff via dual argument or analogous helper (compact_menu_argmin_selection — would need to add).

For the AEMeasurable conclusion: Measurable → AEMeasurable trivially.

## Concrete strategy (recommended)

Use compact_menu_aligned_selection for max (already proved in main.lean, generalizes aligned_best_labeling_selection from OptimalMenuCstar to arbitrary CompactMenu).

For min: prove an analogous compact_menu_alignedmin_selection private helper. Same proof shape, swap IsMaxOn with IsMinOn. Or: invoke compact_menu_aligned_selection on a "flipped" beliefDot (multiply by -1) and recover via abs.

Even simpler: replicate compact_menu_aligned_selection for min by swapping Inventory.measurable_argmax_selector with a hypothetical measurable_argmin_selector — but Inventory only has argmax. So use the -1 trick:


lean
-- minPayoff C s = -sSup (-beliefDot (inclM s) ·.val '' ↑C) = -(maxPayoff_with_flipped C s)
-- where flipped uses `-f`. Then measurability follows from max.


Or just write a separate compact_menu_min_selection helper.

## Output


lean_proof
target_lemma_slug: menu_integrand_aemeasurable
status: PROVED | STUCK
tactics_used: [...]



lean
private lemma menu_integrand_aemeasurable
    (model : RobustTrustModel)
    (_setup : ProfileRealizationSetup model)
    (C : CompactMenu model) :
    AEMeasurable
      (fun s =>
        model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s)
      model.τM := by
  -- your proof


You may freely add private helper lemmas (compact_menu_alignedmin_selection, etc.). Aim for 30-80 lines.

Show more

========
ROLE: assistant (id=07d19ce6-ff5f-4b94-9265-572dc86fb89b)
========
lean_proof
target_lemma_slug: menu_integrand_aemeasurable
status: PROVED
tactics_used: [continuous_finset_sum, IsCompact.continuous_sSup, IsCompact.continuous_sInf, Measurable.comp, Measurable.mul, Measurable.add, Measurable.aemeasurable]

lean
private lemma beliefDot_menu_uncurry_continuous
    (model : RobustTrustModel) :
    Continuous (fun x : Belief model.Ω × ProfileInW model =>
      beliefDot x.1 x.2.val) := by
  classical
  unfold beliefDot
  apply continuous_finset_sum
  intro ω _
  have hb : Continuous (fun b : Belief model.Ω => b.val ω) := by
    exact (continuous_apply ω).comp
      (continuous_subtype_val : Continuous (fun b : Belief model.Ω => b.val))
  have hw : Continuous (fun w : ProfileInW model => w.val ω) := by
    exact (continuous_apply ω).comp
      (continuous_subtype_val : Continuous (fun w : ProfileInW model => w.val))
  exact (hb.comp continuous_fst).mul (hw.comp continuous_snd)

private lemma menu_integrand_aemeasurable
    (model : RobustTrustModel)
    (_setup : ProfileRealizationSetup model)
    (C : CompactMenu model) :
    AEMeasurable
      (fun s =>
        model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s)
      model.τM := by
  classical

  have hdot :
      Continuous (Function.uncurry
        (fun b : Belief model.Ω =>
          fun w : ProfileInW model => beliefDot b w.val)) := by
    simpa [Function.uncurry] using beliefDot_menu_uncurry_continuous model

  have hK : IsCompact (↑C : Set (ProfileInW model)) := C.isCompact

  have hmax_cont :
      Continuous (fun b : Belief model.Ω =>
        sSup ((fun w : ProfileInW model => beliefDot b w.val) ''
          (↑C : Set (ProfileInW model)))) := by
    simpa using hK.continuous_sSup hdot

  have hmin_cont :
      Continuous (fun b : Belief model.Ω =>
        sInf ((fun w : ProfileInW model => beliefDot b w.val) ''
          (↑C : Set (ProfileInW model)))) := by
    simpa using hK.continuous_sInf hdot

  have hmax_meas : Measurable (fun s : model.M => maxPayoff model C s) := by
    simpa [maxPayoff] using
      hmax_cont.measurable.comp model.inclM_measurable

  have hmin_meas : Measurable (fun s : model.M => minPayoff model C s) := by
    simpa [minPayoff] using
      hmin_cont.measurable.comp model.inclM_measurable

  have hαmax :
      Measurable (fun s : model.M => model.α * maxPayoff model C s) :=
    measurable_const.mul hmax_meas

  have hαmin :
      Measurable (fun s : model.M => (1 - model.α) * minPayoff model C s) :=
    measurable_const.mul hmin_meas

  exact (hαmax.add hαmin).aemeasurable

The compact-extrema step is the little clockwork owl here: IsCompact.continuous_sSup and IsCompact.continuous_sInf turn joint continuity on Belief model.Ω × ProfileInW model plus compactness of C into continuity of the max/min payoff as functions of the belief; then model.inclM_measurable does the final measurable pullback. Mathlib documents these compact-domain parametric extrema lemmas as IsCompact.continuous_sSup and IsCompact.continuous_sInf. 
leanprover-community.github.io
