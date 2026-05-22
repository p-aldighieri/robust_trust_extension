
========
ROLE: user (id=de5e5383-b9fe-4687-a5c2-fb4e8d8df023)
========
You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)


lean
theorem dust_positive_mass_forces_mu0_atom
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hpos : WTAPositiveQMass wta flow.α dust.N flow.κ)
    (hα : flow.α < 1)
    (hdirac : ∀ᵐ m ∂flow.qN, flow.ρ m = Measure.dirac wta.μ0) :
    0 < wta.τ ({wta.μ0} : Set WTABelief) := by
  sorry


## Relevant definitions (in RobustTrustV8)


lean
structure WTATernaryAlgebra where
  μ0 : WTABelief
  μ0_coord : ∀ i : WTAΩ, μ0.val i = (1 : ℝ) / 3
  τ : Measure WTABelief
  τ_prob : IsProbabilityMeasure τ

structure NullDustData (wta : WTATernaryAlgebra) where
  N : Set WTABelief
  measurable_N : MeasurableSet N
  tau_null : wta.τ N = 0
  ...

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

noncomputable def WTAMixtureMessageLaw (wta : WTATernaryAlgebra)
    (α : ℝ) (κ : Kernel WTABelief WTABelief) : Measure WTABelief :=
  (ENNReal.ofReal α) • wta.τ +
    (ENNReal.ofReal (1 - α)) • ((wta.τ.compProd κ).map Prod.snd)

def WTAPositiveQMass (wta : WTATernaryAlgebra)
    (α : ℝ) (N : Set WTABelief) (κ : Kernel WTABelief WTABelief) : Prop :=
  0 < WTAMixtureMessageLaw wta α κ N


## Math sketch

Hypotheses say:
1. hpos: 0 < α τ(N) + (1-α) (τ.compProd κ).map snd (N). Since dust.tau_null : τ(N) = 0, this simplifies to 0 < (1-α) (τ.compProd κ).map snd (N). With hα : α < 1, (1-α) > 0, so 0 < (τ.compProd κ).map snd (N).
2. hdirac: ∀ᵐ m ∂qN, ρ m = δ μ₀.

Want: 0 < τ({μ₀}).

### Derivation

From nu_eq_compProd and nuN_eq_restrict:
nuN_raw = (τ.compProd κ).restrict {p | p.2 ∈ N}.

Apply nuN_raw to univ:
nuN_raw univ = (τ.compProd κ)({p | p.2 ∈ N}) = ((τ.compProd κ).map Prod.snd)(N) = κ-mass on N.

By nuN_subtype_pushforward: νN.map (s↦(s, ↑m)) = nuN_raw. So νN univ ≥ nuN_raw applied to univ (modulo subtype handling) — actually they coincide measure-theoretically.

qN univ = (νN.map Prod.snd) univ = νN univ. So qN univ = nuN_raw univ ≥ 0. Together with hpos (using dust.tau_null = 0 and α < 1), we get qN univ > 0 (precisely qN univ = (τ.compProd κ).map Prod.snd (N) > 0 since (1-α) > 0 cancels in the inequality direction).

Now use disintegration. From rho_disintegrates_nuN:
νN.map swap = qN.compProd ρ where swap (s, m) := (m, s).

Apply both sides to the set (univ : Set (NDust)) ×ˢ ({μ₀} : Set WTABelief):

LHS = (νN.map swap) (univ ×ˢ {μ₀}) = νN ({(s, m) | (m, s) ∈ univ ×ˢ {μ₀}}) = νN ({(s, m) | s = μ₀}) = νN ({μ₀} ×ˢ univ).

RHS = (qN.compProd ρ) (univ ×ˢ {μ₀}) = ∫⁻ m, ρ_m({μ₀}) dqN. By hdirac, for qN-a.e. m, ρ m = Measure.dirac μ₀, so ρ_m({μ₀}) = (dirac μ₀)({μ₀}) = 1. Hence integral = qN univ > 0.

So νN ({μ₀} ×ˢ univ) = qN univ > 0. 

Now relate νN({μ₀} ×ˢ univ) to τ({μ₀}):
- νN.map (s ↦ (s, ↑m)) = nuN_raw = (τ.compProd κ).restrict {p | p.2 ∈ N}.
- nuN_raw({μ₀} ×ˢ N) = (τ.compProd κ).restrict ... = (τ.compProd κ)({p | p.1 = μ₀ ∧ p.2 ∈ N}).
- The first marginal of (τ.compProd κ) is τ, so (τ.compProd κ)({p | p.1 = μ₀ ∧ ...}) ≤ (τ.compProd κ)({p | p.1 = μ₀}) = τ({μ₀}).

So νN({μ₀} ×ˢ univ) ≤ nuN_raw({μ₀} ×ˢ N) ≤ τ({μ₀}).

Combined: 0 < νN({μ₀} ×ˢ univ) ≤ τ({μ₀}). ✓

### Key Mathlib tools

- MeasureTheory.Measure.map_apply for pushforward formula
- MeasureTheory.Measure.restrict_apply for restriction
- MeasureTheory.Measure.compProd_apply (Kernel-side composition)
- ProbabilityTheory.Kernel.compProd_apply (general)
- MeasureTheory.lintegral_eq_zero_iff_of_nonneg_ae and dual: lintegral of nonneg integrand > 0 ↔ ∃ pos-mass set
- MeasureTheory.lintegral_indicator, Measure.dirac_apply

## Output


lean_proof
target_lemma_slug: dust_positive_mass_forces_mu0_atom
status: PROVED | STUCK
tactics_used: [...]



lean
theorem dust_positive_mass_forces_mu0_atom ... := by
  -- your proof


Aim for 80-150 lines. The crux is the disintegration formula manipulation. If a specific Mathlib API is missing or unclear, STUCK with the trace.

Show more

========
ROLE: assistant (id=be6b7d9a-b686-4364-b783-bd77facc2b62)
========
lean_proof
target_lemma_slug: dust_positive_mass_forces_mu0_atom
status: PROVED
tactics_used: [classical, dsimp, rw, simp, calc, measure_mono, lintegral_congr_ae]

API note: this proof uses Mathlib’s pushforward formula Measure.map_apply_of_aemeasurable, restriction formula Measure.restrict_apply, and rectangle formula Measure.compProd_apply_prod. 
Lean Community
+2
Lean Community
+2

lean
import Mathlib

open MeasureTheory ProbabilityTheory
open scoped ENNReal

namespace RobustTrustV8

theorem dust_positive_mass_forces_mu0_atom
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hpos : WTAPositiveQMass wta flow.α dust.N flow.κ)
    (hα : flow.α < 1)
    (hdirac : ∀ᵐ m ∂flow.qN, flow.ρ m = Measure.dirac wta.μ0) :
    0 < wta.τ ({wta.μ0} : Set WTABelief) := by
  classical
  haveI : IsProbabilityMeasure wta.τ := wta.τ_prob
  haveI : IsMarkovKernel flow.κ := flow.κ_markov
  haveI : IsMarkovKernel flow.ρ := flow.ρ_markov

  let sndMass : Measure WTABelief :=
    (wta.τ.compProd flow.κ).map Prod.snd

  have hsμ0 : MeasurableSet ({wta.μ0} : Set WTABelief) :=
    measurableSet_singleton _
  have hsN : MeasurableSet dust.N := dust.measurable_N

  have hprod_pos :
      0 < ENNReal.ofReal (1 - flow.α) * sndMass dust.N := by
    have h := hpos
    dsimp [WTAPositiveQMass, WTAMixtureMessageLaw, sndMass] at h
    simpa [Measure.add_apply, Measure.smul_apply, smul_eq_mul,
      dust.tau_null, zero_add, mul_zero] using h

  have hsnd_pos : 0 < sndMass dust.N := by
    by_contra hnot
    have hzero : sndMass dust.N = 0 :=
      le_antisymm (le_of_not_gt hnot) (zero_le _)
    have : 0 < (0 : ENNReal) := by
      simpa [hzero] using hprod_pos
    exact (lt_irrefl (0 : ENNReal)) this

  let embed : WTABelief × NDust dust → WTABelief × WTABelief :=
    fun p => (p.1, (p.2 : WTABelief))
  let swap : WTABelief × NDust dust → NDust dust × WTABelief :=
    fun p => (p.2, p.1)

  have hembed_meas : Measurable embed := by
    exact measurable_fst.prod (measurable_subtype_coe.comp measurable_snd)
  have hswap_meas : Measurable swap := by
    exact measurable_snd.prod measurable_fst

  have hembed_map : flow.νN.map embed = flow.nuN_raw := by
    dsimp [embed]
    exact flow.nuN_subtype_pushforward
  have hswap_map : flow.νN.map swap = flow.qN.compProd flow.ρ := by
    dsimp [swap]
    exact flow.rho_disintegrates_nuN

  let dustCyl : Set (WTABelief × WTABelief) :=
    {p : WTABelief × WTABelief | p.2 ∈ dust.N}

  have hqN_univ_eq : flow.qN Set.univ = sndMass dust.N := by
    calc
      flow.qN Set.univ
          = (flow.νN.map Prod.snd) Set.univ := by
              rw [flow.qN_eq_marginal]
      _ = flow.νN Set.univ := by
              rw [Measure.map_apply_of_aemeasurable
                (measurable_snd.aemeasurable) MeasurableSet.univ]
              simp
      _ = (flow.νN.map embed) Set.univ := by
              rw [Measure.map_apply_of_aemeasurable
                (hembed_meas.aemeasurable) MeasurableSet.univ]
              simp
      _ = flow.nuN_raw Set.univ := by
              rw [hembed_map]
      _ = flow.ν dustCyl := by
              rw [flow.nuN_eq_restrict]
              rw [Measure.restrict_apply MeasurableSet.univ]
              simp [dustCyl]
      _ = (flow.ν.map Prod.snd) dust.N := by
              rw [Measure.map_apply_of_aemeasurable
                (measurable_snd.aemeasurable) hsN]
              rfl
      _ = sndMass dust.N := by
              rw [flow.nu_eq_compProd]
              rfl

  have hqN_univ_pos : 0 < flow.qN Set.univ := by
    rwa [hqN_univ_eq]

  have h_sndMass_prob : IsProbabilityMeasure sndMass := by
    dsimp [sndMass]
    exact Measure.isProbabilityMeasure_map measurable_snd.aemeasurable
  haveI : IsProbabilityMeasure sndMass := h_sndMass_prob

  have hqN_univ_lt_top : flow.qN Set.univ < ⊤ := by
    rw [hqN_univ_eq]
    exact lt_of_le_of_lt
      (prob_le_one (μ := sndMass) (s := dust.N))
      (by simp)
  haveI : IsFiniteMeasure flow.qN := ⟨hqN_univ_lt_top⟩

  let target0 : Set (NDust dust × WTABelief) :=
    (Set.univ : Set (NDust dust)) ×ˢ ({wta.μ0} : Set WTABelief)
  let source0 : Set (WTABelief × NDust dust) :=
    ({wta.μ0} : Set WTABelief) ×ˢ (Set.univ : Set (NDust dust))

  have htarget0_meas : MeasurableSet target0 := by
    dsimp [target0]
    exact MeasurableSet.univ.prod hsμ0

  have hswap_pre : swap ⁻¹' target0 = source0 := by
    ext p
    simp [swap, target0, source0]

  have hcomp_target0 :
      (flow.qN.compProd flow.ρ) target0 = flow.qN Set.univ := by
    dsimp [target0]
    rw [Measure.compProd_apply_prod MeasurableSet.univ hsμ0]
    have hρ_one :
        (fun m : NDust dust => flow.ρ m ({wta.μ0} : Set WTABelief))
          =ᵐ[flow.qN] (fun _ => (1 : ENNReal)) := by
      exact hdirac.mono fun m hm => by
        rw [hm]
        simp
    calc
      ∫⁻ m in (Set.univ : Set (NDust dust)),
          flow.ρ m ({wta.μ0} : Set WTABelief) ∂flow.qN
          = ∫⁻ m,
              flow.ρ m ({wta.μ0} : Set WTABelief) ∂flow.qN := by
              simp
      _ = ∫⁻ _m : NDust dust, (1 : ENNReal) ∂flow.qN := by
              exact lintegral_congr_ae hρ_one
      _ = flow.qN Set.univ := by
              simp

  have hνN_source_eq_comp :
      flow.νN source0 = (flow.qN.compProd flow.ρ) target0 := by
    rw [← hswap_map]
    rw [Measure.map_apply_of_aemeasurable
      (hswap_meas.aemeasurable) htarget0_meas]
    rw [hswap_pre]

  have hνN_source_pos : 0 < flow.νN source0 := by
    rw [hνN_source_eq_comp, hcomp_target0]
    exact hqN_univ_pos

  let target0N : Set (WTABelief × WTABelief) :=
    ({wta.μ0} : Set WTABelief) ×ˢ dust.N
  let sourceBig : Set (WTABelief × WTABelief) :=
    ({wta.μ0} : Set WTABelief) ×ˢ (Set.univ : Set WTABelief)

  have htarget0N_meas : MeasurableSet target0N := by
    dsimp [target0N]
    exact hsμ0.prod hsN

  have hembed_pre : embed ⁻¹' target0N = source0 := by
    ext p
    simp only [embed, target0N, source0, Set.mem_preimage,
      Set.mem_prod, Set.mem_singleton_iff, Set.mem_univ, and_true]
    exact ⟨fun hp => hp.1, fun hp => ⟨hp, by simpa using p.2.property⟩⟩

  have hνN_source_eq_raw :
      flow.νN source0 = flow.nuN_raw target0N := by
    rw [← hembed_map]
    rw [Measure.map_apply_of_aemeasurable
      (hembed_meas.aemeasurable) htarget0N_meas]
    rw [hembed_pre]

  have hraw_le_tau :
      flow.nuN_raw target0N ≤ wta.τ ({wta.μ0} : Set WTABelief) := by
    have hsubset : target0N ∩ dustCyl ⊆ sourceBig := by
      intro p hp
      simp only [target0N, dustCyl, sourceBig, Set.mem_inter_iff,
        Set.mem_prod, Set.mem_singleton_iff, Set.mem_univ, and_true] at hp ⊢
      exact hp.1.1
    have hsourceBig :
        flow.ν sourceBig = wta.τ ({wta.μ0} : Set WTABelief) := by
      dsimp [sourceBig]
      rw [flow.nu_eq_compProd]
      rw [Measure.compProd_apply_prod hsμ0 MeasurableSet.univ]
      simp
    calc
      flow.nuN_raw target0N
          = (flow.ν.restrict dustCyl) target0N := by
              rw [flow.nuN_eq_restrict]
      _ = flow.ν (target0N ∩ dustCyl) := by
              rw [Measure.restrict_apply htarget0N_meas]
      _ ≤ flow.ν sourceBig := by
              exact measure_mono hsubset
      _ = wta.τ ({wta.μ0} : Set WTABelief) := hsourceBig

  have hraw_pos : 0 < flow.nuN_raw target0N := by
    rw [← hνN_source_eq_raw]
    exact hνN_source_pos

  exact lt_of_lt_of_le hraw_pos hraw_le_tau

end RobustTrustV8
