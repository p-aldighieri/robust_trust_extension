
========
ROLE: user (id=da63cd8e-8b81-4545-8f52-676b4d47d7ef)
========
You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)


lean
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


## Relevant definitions


lean
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


## Math sketch

We want: κ supported on the rowwise contact set G implies κ is adversarial (mixture payoff = robust payoff) AND mixture payoff = UStarFull.

**Second conjunct** follows from first + hσstar: MixturePayoff κ σstar = RobustPayoff σstar = UStarFull.

**First conjunct** MixturePayoff κ σstar = RobustPayoff σstar:
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


lean_proof
target_lemma_slug: menu_hall_support_implies_exact_adversary
status: PROVED | STUCK
tactics_used: [...]



lean
theorem menu_hall_support_implies_exact_adversary ... := by
  -- your proof


Aim for 80-200 lines. May freely add private helper lemmas.

Show more

========
ROLE: assistant (id=a2b391a5-a0a2-4706-9958-41f8f2bc5be3)
========
lean_proof
target_lemma_slug: menu_hall_support_implies_exact_adversary
status: STUCK
tactics_used: [constructor, have, simpa, calc, rw]

lean
namespace RobustTrustV8

/-!
STUCK at the kernel-integration bridge.

The final theorem closes immediately once the following bridge is available:

  KernelSupportedOnG model ec.cdagger κ
    ⟹ MixturePayoffFull model κ σstar = RobustPayoffFull model σstar

The missing Lean step is not the final conjunction plumbing. It is the
measure-theoretic statement that a Markov kernel supported rowwise on `G`
makes the inner kernel integral equal the rowwise `minPayoff`, and that every
other adviser kernel gives an inner integral bounded below by that same
`minPayoff`.

Concretely, the missing lemma should have approximately this shape:
-/

private lemma kernel_supportedOnG_mixture_eq_robust_STUCK
    (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (hsupp : KernelSupportedOnG model ec.cdagger κ) :
    MixturePayoffFull model κ σstar =
      RobustPayoffFull model σstar := by
  /-
  Needed bridge, in mathematical form:

  1. Rewrite the σ-profile by exact contact:
       profileMap model (restrictFullToM model σstar) m
         = (ec.wlabel.wstar m).val

  2. For κ, use support on rowwise contact:
       ∀ᵐ s ∂model.τM,
         κ.kernel s (RowwiseContactG model ec.cdagger s) = 1

     to prove, for τM-a.e. s,

       ∫ m, beliefDot (model.inclM s)
              (profileMap model (restrictFullToM model σstar) m)
            ∂(κ.kernel s)
       =
       minPayoff model ec.cdagger.Cdagger s.

     In Lean this requires the missing “integral over a probability measure
     supported on a level set equals the level value” lemma, plus the Markov
     kernel probability-mass normalization for `κ.kernel s`.

  3. For arbitrary β : AdviserKernel model, prove, for τM-a.e. s,

       minPayoff model ec.cdagger.Cdagger s
         ≤ ∫ m, beliefDot (model.inclM s)
                (profileMap model (restrictFullToM model σstar) m)
              ∂(β.kernel s).

     This needs the pointwise fact that each `(ec.wlabel.wstar m).val`
     lies in `ec.cdagger.Cdagger`, hence its payoff is ≥ the rowwise
     `minPayoff`, then a kernel-integral monotonicity lemma.

  4. Lift the a.e. inner integral identities/inequalities through the outer
     τM integral and through the definition of `MixturePayoffFull`.

  5. Convert the global minimizer inequality

       ∀ β, MixturePayoffFull model κ σstar
              ≤ MixturePayoffFull model β σstar

     into equality with `RobustPayoffFull`, using the `sInf` definition of
     `RobustPayoffFull` and the nonempty/bounded-below range lemmas for
     mixture payoffs.

  The target theorem below is only the final 2-line algebra once this bridge
  lemma exists.
  -/
  sorry

theorem menu_hall_support_implies_exact_adversary
    (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (hsupp : KernelSupportedOnG model ec.cdagger κ) :
    IsAdversarialFull model κ σstar ∧
      MixturePayoffFull model κ σstar = UStarFull model := by
  have hAdvEq :
      MixturePayoffFull model κ σstar =
        RobustPayoffFull model σstar :=
    kernel_supportedOnG_mixture_eq_robust_STUCK model σstar ec κ hsupp

  constructor
  · simpa [IsAdversarialFull] using hAdvEq
  · calc
      MixturePayoffFull model κ σstar
          = RobustPayoffFull model σstar := hAdvEq
      _   = UStarFull model := hσstar

end RobustTrustV8

Precise gap: the missing kernel bridge is the lemma turning hsupp : ∀ᵐ s, κ.kernel s (RowwiseContactG ...) = 1 into the exact inner-integral identity against minPayoff, plus the corresponding lower bound for every competing kernel. Once that lemma is in the environment, the displayed theorem closes exactly as shown.
