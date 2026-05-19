You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)

```lean
theorem wta_cone_intersection
    (wta : WTATernaryAlgebra)
    (I : Set WTAΩ)
    (lam : WTAΩ → ℝ)
    (h_support_eq : WTASupport lam = I)
    (h_pos_on_I : ∀ i : WTAΩ, i ∈ I → 0 < lam i)
    (h_sum_one : ∑ i : WTAΩ, lam i = 1)
    (hI : I.Nonempty)
    (ρ : Measure WTABelief)
    [IsProbabilityMeasure ρ]
    (hρ_support : ρ (WTAKminus I) = 1)
    (hbary : beliefBarycenter ρ ∈ WTABconeProfile I) :
    ρ = Measure.dirac wta.μ0 := by
  sorry
```

## All relevant definitions (in RobustTrustV8)

```lean
abbrev WTAΩ : Type := Fin 3
abbrev WTABelief : Type := Belief WTAΩ
abbrev WTAProfile : Type := WTAΩ → ℝ

abbrev Belief (Ω : Type) [Fintype Ω] : Type :=
  {s : Ω → ℝ // (∀ ω : Ω, 0 ≤ s ω) ∧ (∑ ω : Ω, s ω) = 1}

structure WTATernaryAlgebra where
  μ0 : WTABelief
  μ0_coord : ∀ i : WTAΩ, μ0.val i = (1 : ℝ) / 3
  τ : Measure WTABelief
  τ_prob : IsProbabilityMeasure τ

def WTAKminus (I : Set WTAΩ) : Set WTABelief :=
  {s : WTABelief | ∀ i : WTAΩ, i ∈ I → ∀ k : WTAΩ, s.val i ≤ s.val k}

def WTABconeProfile (I : Set WTAΩ) : Set WTAProfile :=
  {p : WTAProfile | ∀ i : WTAΩ, i ∈ I → ∀ k : WTAΩ, p k ≤ p i}

def WTASupport (lam : WTAΩ → ℝ) : Set WTAΩ := {i : WTAΩ | 0 < lam i}

noncomputable def beliefBarycenter {Ω : Type} [Fintype Ω]
    [MeasurableSpace (Belief Ω)] (ρ : Measure (Belief Ω)) : Ω → ℝ :=
  fun ω => ∫ s, s.val ω ∂ρ
```

## Math sketch (from source proof, Lemma 7)

Goal: if `ρ` is a probability measure on `WTABelief = Belief (Fin 3)` with:
- `ρ(K_I^-) = 1` (i.e., ρ-a.s. `s.val i ≤ s.val k` for all `i ∈ I` and all `k`)
- barycenter `s̄ := beliefBarycenter ρ ∈ B_I` (i.e., `s̄_k ≤ s̄_i` for all `i ∈ I` and all `k`)

then `ρ = δ_{μ₀}` where `μ₀ = (1/3, 1/3, 1/3)`.

### Proof:
Fix `i ∈ I`. For each `k`:
- `ρ`-a.s., `s.val k - s.val i ≥ 0` (from K_I^- support).
- `∫ (s.val k - s.val i) dρ = s̄_k - s̄_i ≤ 0` (from B_I barycenter property: `s̄_i ≥ s̄_k`).

So `s.val k - s.val i` is a `ρ`-a.s. nonneg Borel random variable with integral ≤ 0, hence `= 0` `ρ`-a.s.

In particular, `s.val k = s.val i` `ρ`-a.s. (for that fixed `i ∈ I` and every `k`). So all coordinates of `s` are equal `ρ`-a.s. Since `∑_ω s.val ω = 1` (Belief constraint), `s.val ω = 1/3` for all `ω`, `ρ`-a.s. That is, `s = μ₀` `ρ`-a.s.

Therefore `ρ` is supported on `{μ₀}`, and since it's a probability measure, `ρ = δ_{μ₀}`.

## Key Mathlib tools

- `MeasureTheory.integral_nonneg_of_ae`: nonneg integrand a.e. → integral ≥ 0.
- `MeasureTheory.integral_eq_zero_iff_of_nonneg_ae`: integral of nonneg = 0 iff integrand = 0 a.e. (confirmed in dep_audit).
- `MeasureTheory.NoAtoms.measure_singleton`: NOT what we want; we want to SHOW ρ = δ singleton.
- `Measure.dirac_eq_dirac_iff_of_isProbabilityMeasure` or similar: a probability measure supported on `{x}` equals `Measure.dirac x`.

The likely path:
```lean
-- Step 1: a.s. equalities s.val i = s.val k for all i ∈ I and all k.
-- Step 2: a.s., s = μ₀ (using sum-to-one to pin all coords to 1/3).
-- Step 3: conclude ρ = dirac μ₀ using that ρ({μ₀}) = 1.
```

For step 3, Mathlib provides:
```lean
MeasureTheory.Measure.eq_dirac_of_ae_eq  -- or similar
-- or:
have hae : ∀ᵐ s ∂ρ, s = wta.μ0 := ...
-- Then use that ρ is a probability measure: ρ = Measure.dirac μ₀.
```

The exact Mathlib lemma to convert "∀ᵐ s ∂ρ, s = x" + IsProbabilityMeasure ρ → ρ = Measure.dirac x is something like `MeasureTheory.Measure.dirac_apply` + measure extensionality, OR `eq_dirac_of_measure_singleton_eq_one` if such exists. Most direct: show ρ({μ₀}) = 1 (from a.e. equality), then both ρ and Measure.dirac μ₀ are probability measures with the same mass on {μ₀} and supports = {μ₀} → use uniqueness.

OR more elegantly: use the fact that for finite-dim Belief (∀ ω, s.val ω = 1/3 is a specific point — μ₀), and ∀ᵐ s ∂ρ, s = μ₀ together with [IsProbabilityMeasure ρ] should give ρ = Measure.dirac μ₀ via `MeasureTheory.ae_eq_dirac_iff` or by showing `ρ.map id = (dirac μ₀).map id` after using `ae_eq_dirac` properly.

A concrete approach:
```lean
have h_ae : ∀ᵐ s ∂ρ, s = wta.μ0 := by
  filter_upwards [hρ_support_ae, h_eq_coords] with s hsK hcoord
  -- prove s = μ₀ from coordinate-equality + sum = 1
  apply Subtype.ext
  funext ω
  -- s.val ω = 1/3 = μ₀.val ω
  ...
-- Now: ρ is a probability measure that a.e. equals a constant μ₀, so ρ = dirac μ₀.
-- Use MeasureTheory.Measure.ext or:
ext A hA
rw [Measure.dirac_apply A hA, ...]  -- match measure of A on both sides
```

To prove `ρ A = (dirac μ₀) A` for measurable `A`:
- If `μ₀ ∈ A`: `(dirac μ₀) A = 1`. Need ρ(A) = 1.
  - ρ(A) ≥ ρ({μ₀} ∩ A) = ρ({μ₀}) (since μ₀ ∈ A) = 1 (from ∀ᵐ s ∂ρ, s = μ₀ + IsProbabilityMeasure).
- If `μ₀ ∉ A`: `(dirac μ₀) A = 0`. Need ρ(A) = 0.
  - ρ(A) ≤ ρ(univ \ {μ₀}) = 1 - ρ({μ₀}) = 0.

This requires measurability of `{μ₀}` (singleton in Belief WTAΩ — easy since Belief is a subtype of Fin 3 → ℝ; singletons in finite-dim spaces are measurable).

Cleaner Mathlib idiom: `Measure.eq_dirac_iff` or `Measure.dirac_eq_of_ae_eq`. If neither exists, build it inline.

## Output

```
lean_proof
target_lemma_slug: wta_cone_intersection
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem wta_cone_intersection ... := by
  -- your proof
```

Aim for 80-150 lines. The crux is:
1. ρ-a.e. coordinate equalities from integral_eq_zero_iff_of_nonneg_ae (one application per pair).
2. ρ-a.e. point equality `s = μ₀` (via Subtype.ext + sum-to-one constraint).
3. Conclude `ρ = Measure.dirac μ₀` via the measure-uniqueness argument.

If you hit a specific Mathlib API gap, return STUCK with the precise lemma name you'd need.
