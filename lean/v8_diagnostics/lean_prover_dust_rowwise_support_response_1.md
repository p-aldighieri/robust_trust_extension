
========
ROLE: user (id=5ad98be3-dba4-42d7-ae0c-1fad4c12d74e)
========
You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)


lean
theorem dust_rowwise_support_implies_cone_support
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hrow : RowwiseSupport wta dust flow) :
    ∀ᵐ m ∂flow.qN, flow.ρ m (WTAKminus (dust.I m)) = 1 := by
  sorry


## Relevant definitions (in RobustTrustV8)


lean
abbrev WTAΩ : Type := Fin 3
abbrev WTABelief : Type := Belief WTAΩ

structure NullDustData (wta : WTATernaryAlgebra) where
  N : Set WTABelief
  measurable_N : MeasurableSet N
  tau_null : wta.τ N = 0
  wN : {m : WTABelief // m ∈ N} → WTAProfile
  lam : {m : WTABelief // m ∈ N} → WTAΩ → ℝ
  I : {m : WTABelief // m ∈ N} → Set WTAΩ
  lam_measurable : ∀ i : WTAΩ, Measurable (fun m : {m : WTABelief // m ∈ N} => lam m i)
  lam_nonneg : ∀ m i, 0 ≤ lam m i
  lam_sum_one : ∀ m, ∑ i : WTAΩ, lam m i = 1
  lam_support_nonempty : ∀ m, (I m).Nonempty
  lam_support_positive : ∀ m i, i ∈ I m ↔ 0 < lam m i
  wN_eq_mixed_label : ∀ m, wN m = WTA_mixedLabel (lam m)

abbrev NDust {wta : WTATernaryAlgebra} (dust : NullDustData wta) : Type :=
  {m : WTABelief // m ∈ dust.N}

structure AdversarialFlowDisintegrationData
    (wta : WTATernaryAlgebra) (dust : NullDustData wta) where
  α : ℝ
  α_nonneg : 0 ≤ α
  α_le_one : α ≤ 1
  κ : Kernel WTABelief WTABelief
  κ_markov : IsMarkovKernel κ
  ν : Measure (WTABelief × WTABelief)
  νN : Measure (WTABelief × NDust dust)
  nuN_raw : Measure (WTABelief × WTABelief)
  qN : Measure (NDust dust)
  ρ : Kernel (NDust dust) WTABelief
  ρ_markov : IsMarkovKernel ρ
  ρ_prob : ∀ m, IsProbabilityMeasure (ρ m)
  nu_eq_compProd : ν = wta.τ.compProd κ
  nuN_eq_restrict :
    nuN_raw = ν.restrict {p : WTABelief × WTABelief | p.2 ∈ dust.N}
  nuN_subtype_pushforward :
    νN.map (fun p : WTABelief × NDust dust => (p.1, (p.2 : WTABelief))) = nuN_raw
  qN_eq_marginal : qN = νN.map Prod.snd
  rho_disintegrates_nuN :
    νN.map (fun p : WTABelief × NDust dust => (p.2, p.1)) = qN.compProd ρ

def WTAKminus (I : Set WTAΩ) : Set WTABelief :=
  {s : WTABelief | ∀ i : WTAΩ, i ∈ I → ∀ k : WTAΩ, s.val i ≤ s.val k}

def RowwiseSupport (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust) : Prop :=
  ∀ᵐ p ∂flow.νN, p.1 ∈ WTAKminus (dust.I p.2)


## Math sketch

Given the hypothesis on the joint measure νN:
- ∀ᵐ p ∂νN, p.1 ∈ K_I^-(dust.I p.2)

The disintegration of νN (swapped to (snd, fst) = (m, s) layout) is:
- νN.map (fun p => (p.2, p.1)) = qN.compProd ρ

Want: ∀ᵐ m ∂qN, ρ m (WTAKminus (dust.I m)) = 1.

### Classical disintegration argument:

Define A : Set (NDust dust × WTABelief) := {(m, s) | s ∈ WTAKminus (dust.I m)}.

The hypothesis (after swap) says: ∀ᵐ ⟨m, s⟩ ∂(νN.map swap), ⟨m, s⟩ ∈ A. (Swap takes (s, m) ↦ (m, s).)

Equivalently: (νN.map swap)(Aᶜ) = 0.

Using rho_disintegrates_nuN: (qN.compProd ρ)(Aᶜ) = 0.

By the compProd formula: (qN.compProd ρ)(Aᶜ) = ∫⁻ m, ρ_m({s | (m, s) ∈ Aᶜ}) dqN = ∫⁻ m, ρ_m(WTAKminus(dust.I m))ᶜ dqN = 0.

So ρ_m((WTAKminus(dust.I m))ᶜ) = 0 for qN-a.e. m.
With ρ_m a probability measure, ρ_m(WTAKminus(dust.I m)) = 1 for qN-a.e. m. ✓

### Key Mathlib tools

- ae_iff : (∀ᵐ x ∂μ, P x) ↔ μ {x | ¬ P x} = 0
- Kernel.compProd_apply or Measure.compProd_apply for the integral formula
- MeasureTheory.lintegral_eq_zero_iff_of_nonneg_ae : ∫⁻ f dμ = 0 ↔ f =ᵐ[μ] 0 for nonneg f
- prob_compl_eq_zero_iff : [IsProbabilityMeasure μ] → μ Aᶜ = 0 ↔ μ A = 1

### Measurability of A

A = {(m, s) | s ∈ WTAKminus (dust.I m)}. Need MeasurableSet A.

WTAKminus (dust.I m) = {s | ∀ i, i ∈ dust.I m → ∀ k, s.val i ≤ s.val k}. The set depends on dust.I m, which depends on m. Note dust.lam_support_positive m i : i ∈ I m ↔ 0 < lam m i, so dust.I m = {i | 0 < lam m i}.

A = {(m, s) | ∀ i, 0 < dust.lam m i → ∀ k, s.val i ≤ s.val k}
   = ⋂ i, ⋂ k, {(m, s) | 0 < dust.lam m i → s.val i ≤ s.val k}.

For each fixed i, k, the set {(m, s) | 0 < dust.lam m i → s.val i ≤ s.val k} is measurable because:
- 0 < dust.lam m i is measurable in m (from dust.lam_measurable).
- s.val i ≤ s.val k is measurable in s.
- Implication of measurable predicates = measurable.

## Output


lean_proof
target_lemma_slug: dust_rowwise_support_implies_cone_support
status: PROVED | STUCK
tactics_used: [...]



lean
theorem dust_rowwise_support_implies_cone_support ... := by
  -- your proof


Aim for 60-100 lines. The key steps:
1. Show A := {(m, s) | s ∈ WTAKminus (dust.I m)} is measurable.
2. Rephrase hrow as (νN.map swap)(univ \ A_swapped) = 0 or similar.
3. Apply rho_disintegrates_nuN to convert to qN.compProd ρ measure.
4. Use compProd_apply integral formula to extract qN-a.e. ρ-measure.

If you hit a specific Mathlib API gap, STUCK with the precise name.

Show more

========
ROLE: assistant (id=8874e128-551f-4fe9-a7f5-76cd7c6d65de)
========
lean_proof
target_lemma_slug: dust_rowwise_support_implies_cone_support
status: PROVED
tactics_used: [measurability, ae_map_iff, ae_ae_of_ae_compProd, ae_iff, measure_union_le, measure_mono, simp, rw]

lean
open MeasureTheory ProbabilityTheory

theorem dust_rowwise_support_implies_cone_support
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hrow : RowwiseSupport wta dust flow) :
    ∀ᵐ m ∂flow.qN, flow.ρ m (WTAKminus (dust.I m)) = 1 := by
  classical

  let sw : WTABelief × NDust dust → NDust dust × WTABelief := fun p => (p.2, p.1)

  have hsw : Measurable sw := by
    dsimp [sw]
    measurability

  have hA :
      MeasurableSet
        {q : NDust dust × WTABelief | q.2 ∈ WTAKminus (dust.I q.1)} := by
    have hImp : ∀ i k : WTAΩ,
        MeasurableSet
          {q : NDust dust × WTABelief |
            0 < dust.lam q.1 i → q.2.val i ≤ q.2.val k} := by
      intro i k
      have hlam :
          Measurable (fun q : NDust dust × WTABelief => dust.lam q.1 i) :=
        (dust.lam_measurable i).comp measurable_fst
      have hnonpos :
          MeasurableSet
            {q : NDust dust × WTABelief | dust.lam q.1 i ≤ 0} :=
        measurableSet_le hlam measurable_const
      have hs_i :
          Measurable (fun q : NDust dust × WTABelief => q.2.val i) := by
        measurability
      have hs_k :
          Measurable (fun q : NDust dust × WTABelief => q.2.val k) := by
        measurability
      have hle :
          MeasurableSet
            {q : NDust dust × WTABelief | q.2.val i ≤ q.2.val k} :=
        measurableSet_le hs_i hs_k
      have hEqImp :
          {q : NDust dust × WTABelief |
              0 < dust.lam q.1 i → q.2.val i ≤ q.2.val k}
            =
          {q : NDust dust × WTABelief | dust.lam q.1 i ≤ 0} ∪
            {q : NDust dust × WTABelief | q.2.val i ≤ q.2.val k} := by
        ext q
        by_cases hpos : 0 < dust.lam q.1 i
        · have hnle : ¬ dust.lam q.1 i ≤ 0 := not_le_of_gt hpos
          simp [hpos, hnle]
        · have hle0 : dust.lam q.1 i ≤ 0 := le_of_not_gt hpos
          simp [hpos, hle0]
      rw [hEqImp]
      exact hnonpos.union hle

    have hInter :
        MeasurableSet
          (⋂ i : WTAΩ, ⋂ k : WTAΩ,
            {q : NDust dust × WTABelief |
              0 < dust.lam q.1 i → q.2.val i ≤ q.2.val k}) := by
      exact MeasurableSet.iInter fun i =>
        MeasurableSet.iInter fun k => hImp i k

    have hEqAll :
        {q : NDust dust × WTABelief |
          ∀ i : WTAΩ, 0 < dust.lam q.1 i →
            ∀ k : WTAΩ, q.2.val i ≤ q.2.val k}
          =
        (⋂ i : WTAΩ, ⋂ k : WTAΩ,
          {q : NDust dust × WTABelief |
            0 < dust.lam q.1 i → q.2.val i ≤ q.2.val k}) := by
      ext q
      simp only [Set.mem_setOf_eq, Set.mem_iInter]
      constructor
      · intro h i k hi
        exact h i hi k
      · intro h i hi k
        exact h i k hi

    have hAll :
        MeasurableSet
          {q : NDust dust × WTABelief |
            ∀ i : WTAΩ, 0 < dust.lam q.1 i →
              ∀ k : WTAΩ, q.2.val i ≤ q.2.val k} := by
      rw [hEqAll]
      exact hInter

    have hEqA :
        {q : NDust dust × WTABelief | q.2 ∈ WTAKminus (dust.I q.1)}
          =
        {q : NDust dust × WTABelief |
          ∀ i : WTAΩ, 0 < dust.lam q.1 i →
            ∀ k : WTAΩ, q.2.val i ≤ q.2.val k} := by
      ext q
      simp only [WTAKminus, Set.mem_setOf_eq]
      constructor
      · intro h i hpos k
        exact h i ((dust.lam_support_positive q.1 i).mpr hpos) k
      · intro h i hi k
        exact h i ((dust.lam_support_positive q.1 i).mp hi) k

    rw [hEqA]
    exact hAll

  have hmap :
      ∀ᵐ q ∂(flow.νN.map sw),
        q.2 ∈ WTAKminus (dust.I q.1) := by
    exact (MeasureTheory.ae_map_iff hsw.aemeasurable hA).2 <| by
      simpa [sw, RowwiseSupport] using hrow

  have hcomp :
      ∀ᵐ q ∂(flow.qN.compProd flow.ρ),
        q.2 ∈ WTAKminus (dust.I q.1) := by
    have hmap' :
        ∀ᵐ q ∂(flow.νN.map
          (fun p : WTABelief × NDust dust => (p.2, p.1))),
          q.2 ∈ WTAKminus (dust.I q.1) := by
      simpa [sw] using hmap
    rw [← flow.rho_disintegrates_nuN]
    exact hmap'

  by_cases hsf : SFinite flow.qN
  · haveI : SFinite flow.qN := hsf
    haveI : IsMarkovKernel flow.ρ := flow.ρ_markov

    have hfib :
        ∀ᵐ m ∂flow.qN, ∀ᵐ s ∂flow.ρ m,
          s ∈ WTAKminus (dust.I m) := by
      simpa using
        (Measure.ae_ae_of_ae_compProd
          (μ := flow.qN) (κ := flow.ρ)
          (p := fun q : NDust dust × WTABelief =>
            q.2 ∈ WTAKminus (dust.I q.1)) hcomp)

    filter_upwards [hfib] with m hm
    let K : Set WTABelief := WTAKminus (dust.I m)
    change flow.ρ m K = 1

    have hKc : flow.ρ m (Kᶜ) = 0 := by
      have h0 : flow.ρ m {s : WTABelief | ¬ s ∈ K} = 0 :=
        MeasureTheory.ae_iff.mp hm
      simpa [K] using h0

    have hprob_univ : flow.ρ m Set.univ = 1 :=
      (flow.ρ_prob m).measure_univ

    have huniv_le : flow.ρ m Set.univ ≤ flow.ρ m K + flow.ρ m (Kᶜ) := by
      calc
        flow.ρ m Set.univ = flow.ρ m (K ∪ Kᶜ) := by
          rw [Set.union_compl_self]
        _ ≤ flow.ρ m K + flow.ρ m (Kᶜ) :=
          MeasureTheory.measure_union_le (μ := flow.ρ m) K (Kᶜ)

    have hone_le : 1 ≤ flow.ρ m K := by
      calc
        1 = flow.ρ m Set.univ := hprob_univ.symm
        _ ≤ flow.ρ m K + flow.ρ m (Kᶜ) := huniv_le
        _ = flow.ρ m K := by simp [hKc]

    have hle_one : flow.ρ m K ≤ 1 := by
      calc
        flow.ρ m K ≤ flow.ρ m Set.univ :=
          MeasureTheory.measure_mono (μ := flow.ρ m) (Set.subset_univ K)
        _ = 1 := hprob_univ

    exact le_antisymm hle_one hone_le

  · have hcomp0 : flow.qN.compProd flow.ρ = 0 :=
      Measure.compProd_of_not_sfinite flow.qN flow.ρ hsf

    have hmap0' :
        flow.νN.map
          (fun p : WTABelief × NDust dust => (p.2, p.1)) = 0 := by
      rw [flow.rho_disintegrates_nuN, hcomp0]

    have hmap0 : flow.νN.map sw = 0 := by
      simpa [sw] using hmap0'

    have hν0 : flow.νN = 0 :=
      (Measure.map_eq_zero_iff hsw.aemeasurable).mp hmap0

    have hq0 : flow.qN = 0 := by
      rw [flow.qN_eq_marginal, hν0]
      simp

    simp [hq0]
