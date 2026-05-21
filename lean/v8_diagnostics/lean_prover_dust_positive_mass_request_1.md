You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)

```lean
theorem dust_positive_mass_forces_mu0_atom
    (wta : WTATernaryAlgebra)
    (dust : NullDustData wta)
    (flow : AdversarialFlowDisintegrationData wta dust)
    (hpos : WTAPositiveQMass wta flow.α dust.N flow.κ)
    (hα : flow.α < 1)
    (hdirac : ∀ᵐ m ∂flow.qN, flow.ρ m = Measure.dirac wta.μ0) :
    0 < wta.τ ({wta.μ0} : Set WTABelief) := by
  sorry
```

## Relevant definitions (in RobustTrustV8)

```lean
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
```

## Math sketch

Hypotheses say:
1. `hpos`: `0 < α τ(N) + (1-α) (τ.compProd κ).map snd (N)`. Since `dust.tau_null : τ(N) = 0`, this simplifies to `0 < (1-α) (τ.compProd κ).map snd (N)`. With `hα : α < 1`, `(1-α) > 0`, so `0 < (τ.compProd κ).map snd (N)`.
2. `hdirac`: ∀ᵐ m ∂qN, ρ m = δ μ₀.

Want: `0 < τ({μ₀})`.

### Derivation

From `nu_eq_compProd` and `nuN_eq_restrict`:
`nuN_raw = (τ.compProd κ).restrict {p | p.2 ∈ N}`.

Apply nuN_raw to univ:
`nuN_raw univ = (τ.compProd κ)({p | p.2 ∈ N}) = ((τ.compProd κ).map Prod.snd)(N) = κ-mass on N`.

By `nuN_subtype_pushforward`: νN.map (s↦(s, ↑m)) = nuN_raw. So νN univ ≥ nuN_raw applied to univ (modulo subtype handling) — actually they coincide measure-theoretically.

`qN univ = (νN.map Prod.snd) univ = νN univ`. So `qN univ = nuN_raw univ ≥ 0`. Together with hpos (using `dust.tau_null = 0` and `α < 1`), we get `qN univ > 0` (precisely qN univ = (τ.compProd κ).map Prod.snd (N) > 0 since (1-α) > 0 cancels in the inequality direction).

Now use disintegration. From `rho_disintegrates_nuN`:
`νN.map swap = qN.compProd ρ` where `swap (s, m) := (m, s)`.

Apply both sides to the set `(univ : Set (NDust)) ×ˢ ({μ₀} : Set WTABelief)`:

LHS = `(νN.map swap) (univ ×ˢ {μ₀}) = νN ({(s, m) | (m, s) ∈ univ ×ˢ {μ₀}}) = νN ({(s, m) | s = μ₀}) = νN ({μ₀} ×ˢ univ)`.

RHS = `(qN.compProd ρ) (univ ×ˢ {μ₀}) = ∫⁻ m, ρ_m({μ₀}) dqN`. By `hdirac`, for qN-a.e. m, `ρ m = Measure.dirac μ₀`, so `ρ_m({μ₀}) = (dirac μ₀)({μ₀}) = 1`. Hence integral = `qN univ > 0`.

So `νN ({μ₀} ×ˢ univ) = qN univ > 0`. 

Now relate `νN({μ₀} ×ˢ univ)` to `τ({μ₀})`:
- `νN.map (s ↦ (s, ↑m)) = nuN_raw = (τ.compProd κ).restrict {p | p.2 ∈ N}`.
- `nuN_raw({μ₀} ×ˢ N) = (τ.compProd κ).restrict ... = (τ.compProd κ)({p | p.1 = μ₀ ∧ p.2 ∈ N})`.
- The first marginal of (τ.compProd κ) is τ, so `(τ.compProd κ)({p | p.1 = μ₀ ∧ ...}) ≤ (τ.compProd κ)({p | p.1 = μ₀}) = τ({μ₀})`.

So `νN({μ₀} ×ˢ univ) ≤ nuN_raw({μ₀} ×ˢ N) ≤ τ({μ₀})`.

Combined: `0 < νN({μ₀} ×ˢ univ) ≤ τ({μ₀})`. ✓

### Key Mathlib tools

- `MeasureTheory.Measure.map_apply` for pushforward formula
- `MeasureTheory.Measure.restrict_apply` for restriction
- `MeasureTheory.Measure.compProd_apply` (Kernel-side composition)
- `ProbabilityTheory.Kernel.compProd_apply` (general)
- `MeasureTheory.lintegral_eq_zero_iff_of_nonneg_ae` and dual: lintegral of nonneg integrand > 0 ↔ ∃ pos-mass set
- `MeasureTheory.lintegral_indicator`, `Measure.dirac_apply`

## Output

```
lean_proof
target_lemma_slug: dust_positive_mass_forces_mu0_atom
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem dust_positive_mass_forces_mu0_atom ... := by
  -- your proof
```

Aim for 80-150 lines. The crux is the disintegration formula manipulation. If a specific Mathlib API is missing or unclear, STUCK with the trace.
