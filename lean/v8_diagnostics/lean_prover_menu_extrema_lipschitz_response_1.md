
========
ROLE: user (id=5f0d223b-c1fb-48df-a743-4d917d210302)
========
You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)


lean
theorem menu_extrema_Hausdorff_Lipschitz
    (model : RobustTrustModel) :
    ∃ L : ℝ, 0 ≤ L ∧
      ∀ (C D : CompactMenu model) (s : model.M),
        |maxPayoff model C s - maxPayoff model D s| ≤ L * dist C D ∧
        |minPayoff model C s - minPayoff model D s| ≤ L * dist C D := by
  sorry


## Relevant definitions


lean
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


## Math sketch

For each s : model.M, define f_s : ProfileInW model → ℝ by
f_s w := beliefDot (model.inclM s) w.val = ∑ ω, (inclM s).val ω * w.val ω.

Since (inclM s) : Belief model.Ω, we have (inclM s).val ω ∈ [0, 1] and ∑_ω (inclM s).val ω = 1 (probability constraints).

**Claim 1:** f_s is 1-Lipschitz on ProfileInW model (under the subspace metric inherited from Profile model = model.Ω → ℝ with the sup norm).

Proof: For w, w' : ProfileInW model,

|f_s w - f_s w'| = |∑_ω (inclM s).val ω * (w.val ω - w'.val ω)|
                 ≤ ∑_ω (inclM s).val ω * |w.val ω - w'.val ω|       (triangle)
                 ≤ (∑_ω (inclM s).val ω) * (sup_ω |w.val ω - w'.val ω|)  (Hölder/sup)
                 = 1 * dist w.val w'.val                              (since ∑ = 1, sup norm dist)
                 = dist w w'.                                          (subspace metric)


(Note: Mathlib's default metric on Fintype → ℝ is Pi.normedAddCommGroup which has dist f g = sSup_ω dist (f ω) (g ω) = sSup_ω |f ω - g ω|. So sup-norm dist works.)

**Claim 2:** For a K-Lipschitz function f on a metric space and two nonempty compact sets C, D, |sSup (f '' C) - sSup (f '' D)| ≤ K * Metric.hausdorffDist C D and similarly for sInf.

Proof: This is standard. sSup (f '' C) - sSup (f '' D): for any ε > 0, ∃ c ∈ C with f c > sSup (f '' C) - ε. Take d ∈ D with dist c d ≤ hausdorffDist + ε'. Then f c ≤ f d + K · dist c d ≤ sSup(f '' D) + K · hausdorffDist + K ε'. Hence sSup(f '' C) ≤ sSup(f '' D) + K · hausdorffDist. Symmetric for the other side.

In Mathlib, the relevant lemma might be Metric.hausdorffDist_pos_lt or via the EMetric.hausdorffEdist_pic_le family. **Or just prove it directly via the sup/inf characterization** — that's safer since I don't know the exact Mathlib name.

**Claim 3 (the goal):** Combining 1 and 2 with L := 1:
- |maxPayoff C s - maxPayoff D s| = |sSup(f_s '' C) - sSup(f_s '' D)| ≤ 1 * hausdorffDist C D = dist C D
- |minPayoff C s - minPayoff D s| ≤ 1 * dist C D similarly

dist on NonemptyCompacts X IS the Hausdorff distance by definition. So we're done with L = 1.

## Strategy

Take L = 1. The hard part is establishing the Lipschitz of sup/inf in Hausdorff distance for Lipschitz f. 

**Direct ε-argument approach** (probably easiest):

lean
refine ⟨1, zero_le_one, fun C D s => ?_⟩
constructor
-- maxPayoff case:
· -- |sSup(f_s '' C) - sSup(f_s '' D)| ≤ dist C D
  set f : ProfileInW model → ℝ := fun w => beliefDot (model.inclM s) w.val
  have hf_lip : LipschitzWith 1 f := by ...  -- prove using Belief constraints
  -- Now use: |sSup (f '' C) - sSup (f '' D)| ≤ 1 * Metric.hausdorffDist C.toSet D.toSet
  sorry
· sorry  -- minPayoff case symmetric


If Mathlib doesn't have a clean "sup of Lipschitz function over compact = Lipschitz in Hausdorff" lemma, search for Metric.hausdorffDist_image_le or write it from Set.sSup_le_sInf_add_dist-style scratch.

## Key Mathlib API

- Metric.hausdorffDist, EMetric.hausdorffEdist
- TopologicalSpace.NonemptyCompacts.metricSpace (the metric on CompactMenu)
- dist_eq_hausdorffDist (or whatever the field expansion is for NonemptyCompacts.dist)
- Real.iSup_le, Real.sSup_le_sup_iSup
- LipschitzWith, LipschitzWith.dist_le_mul
- Metric.exists_dist_lt_of_hausdorffDist_lt

If you can't quickly establish the sup/inf Lipschitz, STUCK with the precise gap.

## Output


lean_proof
target_lemma_slug: menu_extrema_Hausdorff_Lipschitz
status: PROVED | STUCK
tactics_used: [...]



lean
theorem menu_extrema_Hausdorff_Lipschitz ... := by
  -- your proof


Aim for 60-120 lines. The crux is proving |sSup f '' C - sSup f '' D| ≤ K · hausdorffDist C D for K-Lipschitz f on compact C, D. If Mathlib has it directly, use it; otherwise prove inline.

Show more

========
ROLE: assistant (id=27cc52d2-3aae-4075-9d9d-cd6faa505f5b)
========
lean_proof
target_lemma_slug: menu_extrema_Hausdorff_Lipschitz
status: PROVED
tactics_used: [refine, constructor, calc, rw, simpa, exact, linarith, ring]

Uses the current Mathlib Hausdorff API for NonemptyCompacts.dist_eq, compact nearest-point realization for infDist, and the one-sided real Lipschitz constructor. 
Lean Community
+3
Lean Community
+3
Lean Community
+3

lean
open scoped BigOperators

private lemma menu_sSup_image_lipschitz_nonemptyCompacts
    {α : Type*} [MetricSpace α] {f : α → ℝ} (hf : LipschitzWith 1 f)
    (C D : TopologicalSpace.NonemptyCompacts α) :
    |sSup (f '' (↑C : Set α)) - sSup (f '' (↑D : Set α))| ≤ dist C D := by
  classical
  have hfinCD : Metric.hausdorffEDist (↑C : Set α) (↑D : Set α) ≠ ⊤ :=
    Metric.hausdorffEDist_ne_top_of_nonempty_of_bounded
      C.nonempty D.nonempty C.isCompact.isBounded D.isCompact.isBounded
  have hfinDC : Metric.hausdorffEDist (↑D : Set α) (↑C : Set α) ≠ ⊤ :=
    Metric.hausdorffEDist_ne_top_of_nonempty_of_bounded
      D.nonempty C.nonempty D.isCompact.isBounded C.isCompact.isBounded
  have hCne : (f '' (↑C : Set α)).Nonempty := by
    rcases C.nonempty with ⟨x, hx⟩
    exact ⟨f x, ⟨x, hx, rfl⟩⟩
  have hDne : (f '' (↑D : Set α)).Nonempty := by
    rcases D.nonempty with ⟨x, hx⟩
    exact ⟨f x, ⟨x, hx, rfl⟩⟩
  have hCbdd : BddAbove (f '' (↑C : Set α)) :=
    C.isCompact.bddAbove_image (hf.continuous.continuousOn)
  have hDbdd : BddAbove (f '' (↑D : Set α)) :=
    D.isCompact.bddAbove_image (hf.continuous.continuousOn)

  have hCD :
      sSup (f '' (↑C : Set α)) ≤ sSup (f '' (↑D : Set α)) + dist C D := by
    refine csSup_le hCne ?_
    rintro _ ⟨x, hxC, rfl⟩
    obtain ⟨y, hyD, hy⟩ := D.isCompact.exists_infDist_eq_dist D.nonempty x
    have hxy : dist x y ≤ dist C D := by
      rw [← hy]
      calc
        Metric.infDist x (↑D : Set α)
            ≤ Metric.hausdorffDist (↑C : Set α) (↑D : Set α) :=
          Metric.infDist_le_hausdorffDist_of_mem hxC hfinCD
        _ = dist C D := by
          rw [← Metric.NonemptyCompacts.dist_eq]
    have hySup : f y ≤ sSup (f '' (↑D : Set α)) :=
      le_csSup hDbdd ⟨y, hyD, rfl⟩
    have hxle : f x ≤ f y + dist x y := by
      simpa using hf.le_add_mul x y
    linarith

  have hDC :
      sSup (f '' (↑D : Set α)) ≤ sSup (f '' (↑C : Set α)) + dist C D := by
    refine csSup_le hDne ?_
    rintro _ ⟨x, hxD, rfl⟩
    obtain ⟨y, hyC, hy⟩ := C.isCompact.exists_infDist_eq_dist C.nonempty x
    have hxy : dist x y ≤ dist C D := by
      rw [← hy]
      calc
        Metric.infDist x (↑C : Set α)
            ≤ Metric.hausdorffDist (↑D : Set α) (↑C : Set α) :=
          Metric.infDist_le_hausdorffDist_of_mem hxD hfinDC
        _ = Metric.hausdorffDist (↑C : Set α) (↑D : Set α) := by
          rw [Metric.hausdorffDist_comm]
        _ = dist C D := by
          rw [← Metric.NonemptyCompacts.dist_eq]
    have hySup : f y ≤ sSup (f '' (↑C : Set α)) :=
      le_csSup hCbdd ⟨y, hyC, rfl⟩
    have hxle : f x ≤ f y + dist x y := by
      simpa using hf.le_add_mul x y
    linarith

  rw [abs_sub_le_iff]
  constructor <;> linarith

private lemma menu_sInf_image_lipschitz_nonemptyCompacts
    {α : Type*} [MetricSpace α] {f : α → ℝ} (hf : LipschitzWith 1 f)
    (C D : TopologicalSpace.NonemptyCompacts α) :
    |sInf (f '' (↑C : Set α)) - sInf (f '' (↑D : Set α))| ≤ dist C D := by
  classical
  have hfinCD : Metric.hausdorffEDist (↑C : Set α) (↑D : Set α) ≠ ⊤ :=
    Metric.hausdorffEDist_ne_top_of_nonempty_of_bounded
      C.nonempty D.nonempty C.isCompact.isBounded D.isCompact.isBounded
  have hfinDC : Metric.hausdorffEDist (↑D : Set α) (↑C : Set α) ≠ ⊤ :=
    Metric.hausdorffEDist_ne_top_of_nonempty_of_bounded
      D.nonempty C.nonempty D.isCompact.isBounded C.isCompact.isBounded
  have hCne : (f '' (↑C : Set α)).Nonempty := by
    rcases C.nonempty with ⟨x, hx⟩
    exact ⟨f x, ⟨x, hx, rfl⟩⟩
  have hDne : (f '' (↑D : Set α)).Nonempty := by
    rcases D.nonempty with ⟨x, hx⟩
    exact ⟨f x, ⟨x, hx, rfl⟩⟩
  have hCbdd : BddBelow (f '' (↑C : Set α)) :=
    C.isCompact.bddBelow_image (hf.continuous.continuousOn)
  have hDbdd : BddBelow (f '' (↑D : Set α)) :=
    D.isCompact.bddBelow_image (hf.continuous.continuousOn)

  have hCD :
      sInf (f '' (↑D : Set α)) - dist C D ≤ sInf (f '' (↑C : Set α)) := by
    refine le_csInf hCne ?_
    rintro _ ⟨x, hxC, rfl⟩
    obtain ⟨y, hyD, hy⟩ := D.isCompact.exists_infDist_eq_dist D.nonempty x
    have hxy : dist x y ≤ dist C D := by
      rw [← hy]
      calc
        Metric.infDist x (↑D : Set α)
            ≤ Metric.hausdorffDist (↑C : Set α) (↑D : Set α) :=
          Metric.infDist_le_hausdorffDist_of_mem hxC hfinCD
        _ = dist C D := by
          rw [← Metric.NonemptyCompacts.dist_eq]
    have hInf : sInf (f '' (↑D : Set α)) ≤ f y :=
      csInf_le hDbdd ⟨y, hyD, rfl⟩
    have hfy : f y ≤ f x + dist x y := by
      have h := hf.le_add_mul y x
      simpa [dist_comm] using h
    linarith

  have hDC :
      sInf (f '' (↑C : Set α)) - dist C D ≤ sInf (f '' (↑D : Set α)) := by
    refine le_csInf hDne ?_
    rintro _ ⟨x, hxD, rfl⟩
    obtain ⟨y, hyC, hy⟩ := C.isCompact.exists_infDist_eq_dist C.nonempty x
    have hxy : dist x y ≤ dist C D := by
      rw [← hy]
      calc
        Metric.infDist x (↑C : Set α)
            ≤ Metric.hausdorffDist (↑D : Set α) (↑C : Set α) :=
          Metric.infDist_le_hausdorffDist_of_mem hxD hfinDC
        _ = Metric.hausdorffDist (↑C : Set α) (↑D : Set α) := by
          rw [Metric.hausdorffDist_comm]
        _ = dist C D := by
          rw [← Metric.NonemptyCompacts.dist_eq]
    have hInf : sInf (f '' (↑C : Set α)) ≤ f y :=
      csInf_le hCbdd ⟨y, hyC, rfl⟩
    have hfy : f y ≤ f x + dist x y := by
      have h := hf.le_add_mul y x
      simpa [dist_comm] using h
    linarith

  rw [abs_sub_le_iff]
  constructor <;> linarith

private lemma beliefDot_lipschitz
    (model : RobustTrustModel) (s : model.M) :
    LipschitzWith 1
      (fun w : ProfileInW model => beliefDot (model.inclM s) w.val) := by
  classical
  refine LipschitzWith.of_le_add ?_
  intro x y
  have hp0 : ∀ ω : model.Ω, 0 ≤ (model.inclM s).val ω :=
    (model.inclM s).property.1
  have hpsum : (∑ ω : model.Ω, (model.inclM s).val ω) = 1 :=
    (model.inclM s).property.2
  have hcoord (ω : model.Ω) :
      |x.val ω - y.val ω| ≤ dist x y := by
    have heval :
        dist (x.val ω) (y.val ω) ≤ dist x.val y.val := by
      simpa [Function.eval] using
        ((LipschitzWith.eval (ι := model.Ω)
            (α := fun _ : model.Ω => ℝ) ω).dist_le_mul x.val y.val)
    simpa [Real.dist_eq, Subtype.dist_eq] using heval

  have hdiff :
      beliefDot (model.inclM s) x.val - beliefDot (model.inclM s) y.val =
        ∑ ω : model.Ω,
          (model.inclM s).val ω * (x.val ω - y.val ω) := by
    unfold beliefDot
    rw [← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl ?_
    intro ω hω
    ring

  have hsum_abs :
      (∑ ω : model.Ω,
          (model.inclM s).val ω * (x.val ω - y.val ω)) ≤
        ∑ ω : model.Ω,
          (model.inclM s).val ω * |x.val ω - y.val ω| := by
    refine Finset.sum_le_sum ?_
    intro ω hω
    exact mul_le_mul_of_nonneg_left
      (le_abs_self (x.val ω - y.val ω)) (hp0 ω)

  have hsum_dist :
      (∑ ω : model.Ω,
          (model.inclM s).val ω * |x.val ω - y.val ω|) ≤
        ∑ ω : model.Ω, (model.inclM s).val ω * dist x y := by
    refine Finset.sum_le_sum ?_
    intro ω hω
    exact mul_le_mul_of_nonneg_left (hcoord ω) (hp0 ω)

  have hsum_eq :
      (∑ ω : model.Ω, (model.inclM s).val ω * dist x y) = dist x y := by
    calc
      (∑ ω : model.Ω, (model.inclM s).val ω * dist x y)
          = (∑ ω : model.Ω, (model.inclM s).val ω) * dist x y := by
            simpa using
              (Finset.sum_mul
                (s := Finset.univ)
                (f := fun ω : model.Ω => (model.inclM s).val ω)
                (a := dist x y)).symm
      _ = dist x y := by
            rw [hpsum, one_mul]

  have hsub :
      beliefDot (model.inclM s) x.val - beliefDot (model.inclM s) y.val
        ≤ dist x y := by
    calc
      beliefDot (model.inclM s) x.val - beliefDot (model.inclM s) y.val
          = ∑ ω : model.Ω,
              (model.inclM s).val ω * (x.val ω - y.val ω) := hdiff
      _ ≤ ∑ ω : model.Ω,
              (model.inclM s).val ω * |x.val ω - y.val ω| := hsum_abs
      _ ≤ ∑ ω : model.Ω,
              (model.inclM s).val ω * dist x y := hsum_dist
      _ = dist x y := hsum_eq
  linarith

theorem menu_extrema_Hausdorff_Lipschitz
    (model : RobustTrustModel) :
    ∃ L : ℝ, 0 ≤ L ∧
      ∀ (C D : CompactMenu model) (s : model.M),
        |maxPayoff model C s - maxPayoff model D s| ≤ L * dist C D ∧
        |minPayoff model C s - minPayoff model D s| ≤ L * dist C D := by
  refine ⟨1, by norm_num, ?_⟩
  intro C D s
  let f : ProfileInW model → ℝ :=
    fun w => beliefDot (model.inclM s) w.val
  have hf : LipschitzWith 1 f :=
    beliefDot_lipschitz model s
  constructor
  · simpa [maxPayoff, f, one_mul] using
      menu_sSup_image_lipschitz_nonemptyCompacts hf C D
  · simpa [minPayoff, f, one_mul] using
      menu_sInf_image_lipschitz_nonemptyCompacts hf C D
