You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)

```lean
theorem menu_extrema_Hausdorff_Lipschitz
    (model : RobustTrustModel) :
    ∃ L : ℝ, 0 ≤ L ∧
      ∀ (C D : CompactMenu model) (s : model.M),
        |maxPayoff model C s - maxPayoff model D s| ≤ L * dist C D ∧
        |minPayoff model C s - minPayoff model D s| ≤ L * dist C D := by
  sorry
```

## Relevant definitions

```lean
abbrev Profile (model : RobustTrustModel) : Type := model.Ω → ℝ
abbrev Belief (Ω : Type) [Fintype Ω] : Type :=
  {s : Ω → ℝ // (∀ ω : Ω, 0 ≤ s ω) ∧ (∑ ω : Ω, s ω) = 1}

def beliefDot {Ω : Type} [Fintype Ω] (s : Belief Ω) (w : Ω → ℝ) : ℝ :=
  ∑ ω : Ω, s.val ω * w ω

def PayoffProfileSet (model : RobustTrustModel) : Set (Profile model) :=
  Set.range model.profileOfPrivate
abbrev ProfileInW (model : RobustTrustModel) : Type :=
  {w : Profile model // w ∈ PayoffProfileSet model}
abbrev CompactMenu (model : RobustTrustModel) : Type :=
  TopologicalSpace.NonemptyCompacts (ProfileInW model)

noncomputable def maxPayoff (model : RobustTrustModel)
    (C : CompactMenu model) (s : model.M) : ℝ :=
  sSup ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
    (↑C : Set (ProfileInW model)))

noncomputable def minPayoff (model : RobustTrustModel)
    (C : CompactMenu model) (s : model.M) : ℝ :=
  sInf ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
    (↑C : Set (ProfileInW model)))
```

## Math sketch

For each `s : model.M`, define `f_s : ProfileInW model → ℝ` by
`f_s w := beliefDot (model.inclM s) w.val = ∑ ω, (inclM s).val ω * w.val ω`.

Since `(inclM s) : Belief model.Ω`, we have `(inclM s).val ω ∈ [0, 1]` and `∑_ω (inclM s).val ω = 1` (probability constraints).

**Claim 1:** `f_s` is `1`-Lipschitz on `ProfileInW model` (under the subspace metric inherited from `Profile model = model.Ω → ℝ` with the sup norm).

Proof: For `w, w' : ProfileInW model`,
```
|f_s w - f_s w'| = |∑_ω (inclM s).val ω * (w.val ω - w'.val ω)|
                 ≤ ∑_ω (inclM s).val ω * |w.val ω - w'.val ω|       (triangle)
                 ≤ (∑_ω (inclM s).val ω) * (sup_ω |w.val ω - w'.val ω|)  (Hölder/sup)
                 = 1 * dist w.val w'.val                              (since ∑ = 1, sup norm dist)
                 = dist w w'.                                          (subspace metric)
```

(Note: Mathlib's default metric on `Fintype → ℝ` is `Pi.normedAddCommGroup` which has `dist f g = sSup_ω dist (f ω) (g ω) = sSup_ω |f ω - g ω|`. So sup-norm dist works.)

**Claim 2:** For a `K`-Lipschitz function `f` on a metric space and two nonempty compact sets `C, D`, `|sSup (f '' C) - sSup (f '' D)| ≤ K * Metric.hausdorffDist C D` and similarly for `sInf`.

Proof: This is standard. `sSup (f '' C) - sSup (f '' D)`: for any ε > 0, ∃ c ∈ C with f c > sSup (f '' C) - ε. Take d ∈ D with `dist c d ≤ hausdorffDist + ε'`. Then `f c ≤ f d + K · dist c d ≤ sSup(f '' D) + K · hausdorffDist + K ε'`. Hence `sSup(f '' C) ≤ sSup(f '' D) + K · hausdorffDist`. Symmetric for the other side.

In Mathlib, the relevant lemma might be `Metric.hausdorffDist_pos_lt` or via the `EMetric.hausdorffEdist_pic_le` family. **Or just prove it directly via the sup/inf characterization** — that's safer since I don't know the exact Mathlib name.

**Claim 3 (the goal):** Combining 1 and 2 with `L := 1`:
- `|maxPayoff C s - maxPayoff D s| = |sSup(f_s '' C) - sSup(f_s '' D)| ≤ 1 * hausdorffDist C D = dist C D`
- `|minPayoff C s - minPayoff D s| ≤ 1 * dist C D` similarly

`dist` on `NonemptyCompacts X` IS the Hausdorff distance by definition. So we're done with L = 1.

## Strategy

Take `L = 1`. The hard part is establishing the Lipschitz of sup/inf in Hausdorff distance for Lipschitz `f`. 

**Direct ε-argument approach** (probably easiest):
```lean
refine ⟨1, zero_le_one, fun C D s => ?_⟩
constructor
-- maxPayoff case:
· -- |sSup(f_s '' C) - sSup(f_s '' D)| ≤ dist C D
  set f : ProfileInW model → ℝ := fun w => beliefDot (model.inclM s) w.val
  have hf_lip : LipschitzWith 1 f := by ...  -- prove using Belief constraints
  -- Now use: |sSup (f '' C) - sSup (f '' D)| ≤ 1 * Metric.hausdorffDist C.toSet D.toSet
  sorry
· sorry  -- minPayoff case symmetric
```

If Mathlib doesn't have a clean "sup of Lipschitz function over compact = Lipschitz in Hausdorff" lemma, search for `Metric.hausdorffDist_image_le` or write it from `Set.sSup_le_sInf_add_dist`-style scratch.

## Key Mathlib API

- `Metric.hausdorffDist`, `EMetric.hausdorffEdist`
- `TopologicalSpace.NonemptyCompacts.metricSpace` (the metric on CompactMenu)
- `dist_eq_hausdorffDist` (or whatever the field expansion is for NonemptyCompacts.dist)
- `Real.iSup_le`, `Real.sSup_le_sup_iSup`
- `LipschitzWith`, `LipschitzWith.dist_le_mul`
- `Metric.exists_dist_lt_of_hausdorffDist_lt`

If you can't quickly establish the sup/inf Lipschitz, STUCK with the precise gap.

## Output

```
lean_proof
target_lemma_slug: menu_extrema_Hausdorff_Lipschitz
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem menu_extrema_Hausdorff_Lipschitz ... := by
  -- your proof
```

Aim for 60-120 lines. The crux is proving `|sSup f '' C - sSup f '' D| ≤ K · hausdorffDist C D` for `K`-Lipschitz `f` on compact `C, D`. If Mathlib has it directly, use it; otherwise prove inline.
