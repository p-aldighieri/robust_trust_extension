You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)

```lean
theorem menu_hall_support_implies_exact_adversary
    (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (hsupp : KernelSupportedOnG model ec.cdagger κ) :
    IsAdversarialFull model κ σstar ∧
      MixturePayoffFull model κ σstar = UStarFull model := by
  sorry
```

## Relevant definitions

```lean
def IsAdversarialFull (model : RobustTrustModel)
    (β : AdviserKernel model) (σFull : AgentStrategyFull model) : Prop :=
  MixturePayoffFull model β σFull = RobustPayoffFull model σFull

def KernelSupportedOnG (model : RobustTrustModel)
    {opt : OptimalMenuCstar model}
    {wlabel : AlignedBestLabelingWstar model opt}
    (cdagger : PrunedMenuCdagger model wlabel)
    (κ : AdviserKernel model) : Prop :=
  ∀ᵐ s ∂model.τM, κ.kernel s (RowwiseContactG model cdagger s) = 1

def RowwiseContactG (model : RobustTrustModel)
    {opt : OptimalMenuCstar model}
    {wlabel : AlignedBestLabelingWstar model opt}
    (cdagger : PrunedMenuCdagger model wlabel) (s : model.M) : Set model.M :=
  {m : model.M |
    beliefDot (model.inclM s) (wlabel.wstar m).val =
      minPayoff model cdagger.Cdagger s}

structure ExactContact (model : RobustTrustModel)
    (σstar : AgentStrategyFull model) where
  opt : OptimalMenuCstar model
  wlabel : AlignedBestLabelingWstar model opt
  cdagger : PrunedMenuCdagger model wlabel
  selector : model.M → model.M
  selector_measurable : Measurable selector
  selector_mem : ∀ᵐ s ∂model.τM, selector s ∈ RowwiseContactG model cdagger s
  sigma_implements_wlabel :
    ∀ m : model.M,
      profileMap model (restrictFullToM model σstar) m = (ec.wlabel.wstar m).val
```

## Math sketch

We want: κ supported on the rowwise contact set G implies κ is adversarial (mixture payoff = robust payoff) AND mixture payoff = UStarFull.

**Second conjunct** follows from first + hσstar: `MixturePayoff κ σstar = RobustPayoff σstar = UStarFull`.

**First conjunct** `MixturePayoff κ σstar = RobustPayoff σstar`:
- RobustPayoff σstar = sInf (range MixturePayoffFull · σstar). So MixturePayoff κ σstar ≥ RobustPayoff σstar (κ is an element of the range, sInf ≤).
- For ≤: need to show MixturePayoff κ σstar ≤ sInf, i.e., MixturePayoff κ σstar ≤ MixturePayoffFull β σstar for all β.
- For all β: MisalignedPayoffFull β σstar = ∫ s, ∫ m, beliefDot (inclM s) (profile σstar (inclM m)) ∂(β.kernel s) ∂τM.
- For κ specifically (supported on G): MisalignedPayoffFull κ σstar = ∫ s, ∫ m, beliefDot (inclM s) (wstar m).val ∂(κ.kernel s) ∂τM (using ec.sigma_implements_wlabel).
- On G (rowwise contact), beliefDot (inclM s) (wstar m).val = minPayoff(cdagger.Cdagger, s). So inner integral = minPayoff cdagger.Cdagger s (since κ supported on G + Markov).
- Hence MisalignedPayoffFull κ σstar = ∫ s, minPayoff cdagger.Cdagger s dτM.

For any other β:
- MisalignedPayoffFull β σstar = ∫ s, ∫ m, beliefDot (inclM s) (wstar m).val ∂(β.kernel s) dτM (using ec.sigma_implements_wlabel for β too, since σstar is fixed).

Wait — ec.sigma_implements_wlabel says profileMap (restrictFullToM σstar) m = (wstar m).val. So for ALL m, beliefDot (inclM s) (profile σstar (inclM m)) = beliefDot (inclM s) (wstar m).val. This is symmetric: applies to all β, not just κ.

So MisalignedPayoff β σstar = ∫ s, ∫ m, beliefDot (inclM s) (wstar m).val ∂(β.kernel s) dτM.

For each (s, m): beliefDot (inclM s) (wstar m).val ≥ minPayoff cdagger.Cdagger s (since wstar m ∈ Cdagger via cdagger.range_dense, so beliefDot... ≥ sInf over Cdagger).

Hence MisalignedPayoff β σstar ≥ ∫ minPayoff dτM = MisalignedPayoff κ σstar. So MixturePayoff β σstar ≥ MixturePayoff κ σstar (same aligned, larger or equal misaligned).

So MixturePayoff κ σstar ≤ MixturePayoff β σstar for all β. Hence ≤ sInf. Combined with ≥, gives equality.

## Strategy

This proof has the same measure-theory bridge gap as the hMis_per_β / robust_range_bddAbove cluster (kernel integration + sInf bounds). The substantive steps:
1. ec.sigma_implements_wlabel lets you swap profile σstar (inclM m) with (wstar m).val.
2. Show ∀ β, MisalignedPayoff β σstar ≥ ∫ minPayoff dτM (pointwise inequality + Markov kernel integration).
3. Show MisalignedPayoff κ σstar = ∫ minPayoff dτM (using hsupp + RowwiseContactG definition for equality on G + Markov kernel integration of const).
4. Combine: MixturePayoff β ≥ MixturePayoff κ, hence sInf ≥ MixturePayoff κ. With sInf ≤ MixturePayoff κ (by κ being in range), get equality.

If kernel integration is intractable, state STUCK with the precise gap.

## Output

```
lean_proof
target_lemma_slug: menu_hall_support_implies_exact_adversary
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem menu_hall_support_implies_exact_adversary ... := by
  -- your proof
```

Aim for 80-200 lines. May freely add private helper lemmas.
