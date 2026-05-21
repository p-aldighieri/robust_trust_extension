
========
ROLE: user (id=250eb8d3-fdd4-4b3b-9ebd-526e9e47ddb8)
========
You are the Lean Prover. Close ONE specific sorry — a measurability lemma analogous to menu_integrand_aemeasurable.

## Target (in namespace RobustTrustV8, import Mathlib)


lean
theorem geps_graph_measurable
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt)
    (cdagger : PrunedMenuCdagger model wlabel)
    {ε : ℝ}
    (hε : 0 < ε) :
    MeasurableSet
      {p : model.M × model.M | p.2 ∈ EpsilonContactGeps model cdagger ε p.1} := by
  sorry


## Relevant definitions


lean
def EpsilonContactGeps (model : RobustTrustModel)
    {opt : OptimalMenuCstar model}
    {wlabel : AlignedBestLabelingWstar model opt}
    (cdagger : PrunedMenuCdagger model wlabel)
    (ε : ℝ) (s : model.M) : Set model.M :=
  {m : model.M |
    beliefDot (model.inclM s) (wlabel.wstar m).val ≤
      minPayoff model cdagger.Cdagger s + ε}

noncomputable def minPayoff (model : RobustTrustModel)
    (C : CompactMenu model) (s : model.M) : ℝ :=
  sInf ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
    (↑C : Set (ProfileInW model)))


## Math sketch

The graph is {(s, m) | f(s, m) ≤ g(s) + ε} where:
- f(s, m) := beliefDot (inclM s) (wlabel.wstar m).val
- g(s) := minPayoff cdagger.Cdagger s

This is {p | f p ≤ g p.1 + ε} = {p | f p - g p.1 ≤ ε}, which is measurable if f and g ∘ Prod.fst are jointly measurable.

**Measurability of f**: f(s, m) = beliefDot (inclM s) (wlabel.wstar m).val. 
- s ↦ inclM s is measurable (model.inclM_measurable).
- m ↦ wlabel.wstar m is measurable (wlabel.measurable_wstar).
- (s, m) ↦ beliefDot (inclM s) (wstar m).val is measurable as joint composition (Measurable.prod_mk + beliefDot's joint continuity, or per-coordinate decomposition).

**Measurability of g**: g(s) = minPayoff cdagger.Cdagger s is measurable in s by **the same argument as the proved menu_integrand_aemeasurable** — uses IsCompact.continuous_sInf over Belief Ω × ProfileInW model with joint continuity of beliefDot (which we have proved as beliefDot_menu_uncurry_continuous). Then inclM_measurable pulls back.

Specifically, the existing proof of menu_integrand_aemeasurable derives:

lean
have hmin_meas : Measurable (fun s : model.M => minPayoff model C s)

as an intermediate step. Reuse this.

## Strategy

1. Establish joint measurability of f:

lean
have hf_meas : Measurable (fun p : model.M × model.M =>
    beliefDot (model.inclM p.1) (wlabel.wstar p.2).val) := by
  -- decompose: beliefDot = ∑_ω inclM.val ω * wstar.val ω
  unfold beliefDot
  refine Finset.measurable_sum _ ?_
  intro ω _
  have h1 : Measurable (fun p : model.M × model.M => (model.inclM p.1).val ω) :=
    ((measurable_pi_apply ω).comp measurable_subtype_coe).comp
      (model.inclM_measurable.comp measurable_fst)
  have h2 : Measurable (fun p : model.M × model.M => (wlabel.wstar p.2).val ω) :=
    ((measurable_pi_apply ω).comp measurable_subtype_coe).comp
      (wlabel.measurable_wstar.comp measurable_snd)
  exact h1.mul h2


2. Establish measurability of g:

lean
have hg_meas : Measurable (fun s : model.M => minPayoff model cdagger.Cdagger s) := by
  -- Reuse the structure of menu_integrand_aemeasurable's proof for min.
  classical
  have hdot : Continuous (Function.uncurry
      (fun b : Belief model.Ω => fun w : ProfileInW model => beliefDot b w.val)) := by
    simpa [Function.uncurry] using beliefDot_menu_uncurry_continuous model
  have hK : IsCompact (↑cdagger.Cdagger : Set (ProfileInW model)) := cdagger.Cdagger.isCompact
  have hmin_cont :
      Continuous (fun b : Belief model.Ω =>
        sInf ((fun w : ProfileInW model => beliefDot b w.val) ''
          (↑cdagger.Cdagger : Set (ProfileInW model)))) := by
    simpa using hK.continuous_sInf hdot
  simpa [minPayoff] using hmin_cont.measurable.comp model.inclM_measurable


3. Convert to graph measurability:

lean
-- Graph = {p | f p ≤ g p.1 + ε}
-- = {p | f p - g p.1 ≤ ε}
-- = preimage of (-∞, ε] under p ↦ f p - g p.1
have hg_comp : Measurable (fun p : model.M × model.M =>
    minPayoff model cdagger.Cdagger p.1) :=
  hg_meas.comp measurable_fst
have hdiff : Measurable (fun p : model.M × model.M =>
    beliefDot (model.inclM p.1) (wlabel.wstar p.2).val
      - minPayoff model cdagger.Cdagger p.1) :=
  hf_meas.sub hg_comp
-- {p | f p ≤ g p.1 + ε} = {p | f p - g p.1 ≤ ε} (algebra)
have hset_eq :
    {p : model.M × model.M |
        p.2 ∈ EpsilonContactGeps model cdagger ε p.1} =
      {p : model.M × model.M |
        beliefDot (model.inclM p.1) (wlabel.wstar p.2).val
          - minPayoff model cdagger.Cdagger p.1 ≤ ε} := by
  ext p; simp [EpsilonContactGeps]; constructor <;> intro h <;> linarith
rw [hset_eq]
exact measurableSet_le hdiff measurable_const


## Available helper (already proved in main.lean)


lean
private lemma beliefDot_menu_uncurry_continuous
    (model : RobustTrustModel) :
    Continuous (fun x : Belief model.Ω × ProfileInW model =>
      beliefDot x.1 x.2.val)


## Output


lean_proof
target_lemma_slug: geps_graph_measurable
status: PROVED | STUCK
tactics_used: [...]



lean
theorem geps_graph_measurable ... := by
  -- your proof


Aim for 30-60 lines. This should be tractable since the helpers are already in scope.

Show more

========
ROLE: assistant (id=05ee8e8b-5e6d-4431-b184-86c14d53238c)
========
lean_proof
target_lemma_slug: geps_graph_measurable
status: PROVED
tactics_used: [classical, exact, simpa, comp, prod_mk, continuous_sInf, measurableSet_le]

lean
theorem geps_graph_measurable
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt)
    (cdagger : PrunedMenuCdagger model wlabel)
    {ε : ℝ}
    (hε : 0 < ε) :
    MeasurableSet
      {p : model.M × model.M | p.2 ∈ EpsilonContactGeps model cdagger ε p.1} := by
  classical

  -- Joint measurability of
  --   (s,m) ↦ beliefDot (inclM s) (wstar m).val.
  have hpair_meas :
      Measurable (fun p : model.M × model.M =>
        ((model.inclM p.1, wlabel.wstar p.2) :
          Belief model.Ω × ProfileInW model)) := by
    exact
      (model.inclM_measurable.comp measurable_fst).prod_mk
        (wlabel.measurable_wstar.comp measurable_snd)

  have hf_meas :
      Measurable (fun p : model.M × model.M =>
        beliefDot (model.inclM p.1) (wlabel.wstar p.2).val) := by
    simpa using
      (beliefDot_menu_uncurry_continuous model).measurable.comp hpair_meas

  -- Measurability of s ↦ minPayoff model cdagger.Cdagger s,
  -- by the same compact-menu sInf continuity argument used for
  -- menu integrands.
  have hg_meas :
      Measurable (fun s : model.M =>
        minPayoff model cdagger.Cdagger s) := by
    have hdot :
        Continuous (Function.uncurry
          (fun b : Belief model.Ω =>
            fun w : ProfileInW model => beliefDot b w.val)) := by
      simpa [Function.uncurry] using
        beliefDot_menu_uncurry_continuous model

    have hK :
        IsCompact (↑cdagger.Cdagger : Set (ProfileInW model)) :=
      cdagger.Cdagger.isCompact

    have hmin_cont :
        Continuous (fun b : Belief model.Ω =>
          sInf ((fun w : ProfileInW model => beliefDot b w.val) ''
            (↑cdagger.Cdagger : Set (ProfileInW model)))) := by
      simpa [Function.uncurry] using hK.continuous_sInf hdot

    simpa [minPayoff] using
      hmin_cont.measurable.comp model.inclM_measurable

  have hg_comp :
      Measurable (fun p : model.M × model.M =>
        minPayoff model cdagger.Cdagger p.1) := by
    exact hg_meas.comp measurable_fst

  have hright :
      Measurable (fun p : model.M × model.M =>
        minPayoff model cdagger.Cdagger p.1 + ε) := by
    exact hg_comp.add measurable_const

  have hpre :
      MeasurableSet
        {p : model.M × model.M |
          beliefDot (model.inclM p.1) (wlabel.wstar p.2).val ≤
            minPayoff model cdagger.Cdagger p.1 + ε} := by
    exact measurableSet_le hf_meas hright

  simpa [EpsilonContactGeps] using hpre
