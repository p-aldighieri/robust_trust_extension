You are the Lean Prover. Close ONE specific `sorry`.

## Target lemma

```lean
theorem q_dominates_tau_when_alpha_pos
    (model : RobustTrustModel)
    (β : AdviserKernel model)
    {P : model.M → Prop}
    (hα : 0 < model.α)
    (hP : ∀ᵐ m ∂MixtureMessageLaw model β, P m) :
    ∀ᵐ m ∂model.τM, P m := by
  sorry
```

(In namespace `RobustTrustV8`. Imports: `import Mathlib`.)

## Relevant definitions

```lean
noncomputable def MixtureMessageLaw (model : RobustTrustModel)
    (β : AdviserKernel model) : Measure model.M :=
  (ENNReal.ofReal model.α) • model.τM +
    (ENNReal.ofReal (1 - model.α)) • ((model.τM.compProd β.kernel).map Prod.snd)
```

And the model has `α : ℝ` with `0 ≤ α ≤ 1`.

## Math

MixtureMessageLaw = α • τM + (1-α) • (something). Both terms are non-negative measures. So `MixtureMessageLaw ≥ α • τM` as measures. When α > 0, this means `τM ≪ MixtureMessageLaw` (τM is absolutely continuous w.r.t. MixtureMessageLaw). Hence any MixtureMessageLaw-a.e. property holds τM-a.e.

## Suggested Mathlib API

- `MeasureTheory.AbsolutelyContinuous` — for `μ ≪ ν`
- `MeasureTheory.AbsolutelyContinuous.ae_le` — `μ ≪ ν → ν.ae ≤ μ.ae`
  (Or equivalent: maybe `.ae_mono` or other name)
- `MeasureTheory.ae_iff` — converts `∀ᵐ` to "complement is null"
- `MeasureTheory.Measure.add_apply`, `Measure.smul_apply`
- `ENNReal.add_eq_zero` — sum of nonneg ENNReals = 0 iff both 0
- `ENNReal.mul_eq_zero` — product = 0 iff one factor 0
- `ENNReal.ofReal_pos`, `ENNReal.ofReal_ne_zero` — convert positivity

## Output

```lean_proof
target_lemma_slug: q_dominates_tau_when_alpha_pos
status: PROVED
tactics_used: [...]
proof_length_lines: <int>
introduces_have_clauses: <int>
```

```lean
theorem q_dominates_tau_when_alpha_pos
    (model : RobustTrustModel)
    (β : AdviserKernel model)
    {P : model.M → Prop}
    (hα : 0 < model.α)
    (hP : ∀ᵐ m ∂MixtureMessageLaw model β, P m) :
    ∀ᵐ m ∂model.τM, P m := by
  -- your proof
  sorry
```

Aim for ~10-20 lines. If you can't close it cleanly, return STUCK with the obstruction.
