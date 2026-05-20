You are the Lean Prover. Close ONE specific sorry: `adversary_kernels_restrict_to_M` 1st conjunct (line 998).

## Target

```lean
theorem adversary_kernels_restrict_to_M
    (model : RobustTrustModel)
    (msupp : MessageSupportM model)
    (bridge : MessageRestrictionBridge model msupp)
    (σFull : AgentStrategyFull model) :
    sInf (Set.range fun βFull : FullMessageAdviserKernel model =>
        MixturePayoffFullRaw model βFull σFull) =
      sInf (Set.range fun βM : AdviserKernel model =>
        MixturePayoffFull model βM σFull) ∧
    RobustPayoffFull model σFull =
      RobustPayoffM model (restrictFullToM model σFull) := by
  refine ⟨?_, ?_⟩
  · sorry  -- 1st conjunct (TARGET)
  · rfl    -- 2nd conjunct
```

## Definitions

```lean
structure FullMessageAdviserKernel where
  kernel : Kernel model.M (Belief model.Ω)
  isMarkov : IsMarkovKernel kernel

structure AdviserKernel where
  kernel : Kernel model.M model.M
  isMarkov : IsMarkovKernel kernel

noncomputable def MisalignedPayoffFullRaw (βFull : FullMessageAdviserKernel) (σFull) : ℝ :=
  ∫ s, ∫ m_belief, beliefDot (model.inclM s) (model.profileOfPrivate (σFull.sectionFull m_belief))
    ∂(βFull.kernel s) ∂model.τM

noncomputable def MixturePayoffFullRaw (βFull) (σFull) : ℝ :=
  model.α * AlignedPayoffFull σFull + (1 - model.α) * MisalignedPayoffFullRaw βFull σFull

-- Note: MixturePayoffFull uses AdviserKernel (not Full), so integrates over inclM-image:
noncomputable def MisalignedPayoffM (β : AdviserKernel) (σM : AgentStrategyM) : ℝ :=
  ∫ s, ∫ m_M, beliefDot (inclM s) (profileMap σM m_M) ∂(β.kernel s) ∂τM
noncomputable def MixturePayoffFull (β : AdviserKernel) (σFull) : ℝ :=
  model.α * AlignedPayoffFull σFull + (1 - model.α) * MisalignedPayoffM β (restrictFullToM σFull)
```

## Mathematical content

For every AdviserKernel βM, we can construct FullMessageAdviserKernel βFull := pushforward by inclM:
`βFull.kernel s := (βM.kernel s).map inclM`.

Then:
- MisalignedPayoffFullRaw (lifted βM) σFull = ∫ s, ∫ m_belief, f(m_belief) ∂(inclM∗(βM s)) dτM
  = ∫ s, ∫ m_M, f(inclM m_M) ∂(βM s) dτM  (integral of pushforward)
  = ∫ s, ∫ m_M, beliefDot (inclM s) (profileOfPrivate (σFull.sectionFull (inclM m_M))) ∂(βM s) dτM
  = MisalignedPayoffM βM (restrictFullToM σFull)  (by definition of restrictFullToM)
- MixturePayoffFullRaw (lifted βM) σFull = MixturePayoffFull βM σFull.

So the M-range injects into the Full-Raw range. Hence sInf Full-Raw ≤ sInf M.

For the REVERSE direction (sInf Full-Raw ≥ sInf M): each βFull has some payoff. The claim:
`MisalignedPayoffFullRaw βFull σFull ≥ MisalignedPayoffM (βM_proj βFull) σFull` for some
projected M-kernel βM_proj βFull, OR equivalent argument using off-support irrelevance.

**Subtlety**: Generally an adversary placing mass on a non-`inclM`-range belief could yield
a smaller payoff (more adversarial). So Full-Raw could have STRICTLY SMALLER sInf than M-version.
For equality, we need that σFull is "trivial off Set.range inclM" or that beliefs outside the
range still give the same payoff structure.

Actually — looking at the definitions: `σFull.sectionFull` is defined on all of Belief, but the
INNER integrand `f(m_belief) = beliefDot (inclM s) (profileOfPrivate (σFull.sectionFull m_belief))`
depends only on σFull's behavior at m_belief. If σFull.sectionFull is arbitrary off Set.range inclM,
then the adversary can pick m_belief such that profileOfPrivate (σFull.sectionFull m_belief) is
adversarially chosen.

So equality requires that the adversary's choice space outside Set.range inclM doesn't help.

Hmm — this might rely on σFull being "extended from M" or on profileOfPrivate's range being bounded by W.

Wait, `profileOfPrivate σ ∈ W` always (PayoffProfileSet definition: range of profileOfPrivate IS W).
So `beliefDot (inclM s) (profileOfPrivate (σFull.sectionFull m_belief))` ∈ image of beliefDot
on (inclM s) × W, which is bounded.

The minimum over m_belief of beliefDot (inclM s) (·) over W = minPayoff_W s (the absolute min over W).
The minimum over m_M (range inclM is a subset) of the same = max(minPayoff_W s, ...).

Hmm, in general these aren't equal. So sInf Full-Raw < sInf M is possible.

UNLESS — looking at the conjunction with the 2nd conjunct + how this theorem is used in
`full_restricted_Ustar_equivalence`, the result must hold in this setup.

Maybe the key is in `msupp.support_eq_range : supportSet = Set.range model.inclM` and
`msupp.τM_pushforward : model.τM.map model.inclM = model.τ`. These say the M-support measure
pushes to the full-belief measure τ. So τ is concentrated on Set.range inclM.

But that's about τ, not the kernel β.

Hmm. Actually wait — let me re-read the definitions. MisalignedPayoffFull uses
`MisalignedPayoffM β (restrictFullToM σFull)`. So this is the M-version applied to the restricted
strategy. The outer integral is over τM (M-space measure), and the inner is over βM.kernel s
(also M-space). So MisalignedPayoffFull's adversary β is INHERENTLY restricted to M-space.

MisalignedPayoffFullRaw's adversary βFull is over Belief. So strictly more general.

For sInf equality, we need: for each βFull, the resulting payoff ≥ sInf M, OR there's a βM
with same payoff. Tricky without more structure.

**HYPOTHESIS**: this theorem might require an additional structural lemma that says
σFull.sectionFull restricted to Set.range inclM determines all the values that matter, possibly
extending arbitrary σFull's "out of range" choices via measurable selection. 

## Strategy

This is a substantive restriction theorem. Try the following approaches:

1. **Inequality 1 (sInf Full ≤ sInf M)**: For each βM, construct βFull_lift := M-kernel pushed
   forward to belief space. Show payoffs match. Hence each M-element is in Full-Raw range, sInf
   Full ≤ each M element ⟹ sInf Full ≤ sInf M.

2. **Inequality 2 (sInf M ≤ sInf Full)**: This is the hard direction. The "projection" βFull → βM
   conceptually averages βFull's mass over fibers of inclM. Even if mass is off-range, payoff
   ≥ minimum value over Belief, which we claim equals minimum over M-range under appropriate
   structural assumptions.

**If you can't close Direction 2 cleanly, declare STUCK with the precise gap**: which structural
hypothesis is missing (probably about off-range behavior of σFull's profileOfPrivate composition).

## Available infrastructure

- `MeasureTheory.integral_map`: ∫ f ∂(μ.map g) = ∫ f ∘ g ∂μ (for measurable f, g)
- `ProbabilityTheory.Kernel.map`: kernel pushforward
- `MessageSupportM`: τM.map inclM = τ; supportSet = range inclM (closed, measurable)
- Standard sInf/csInf lemmas

## Output

```
lean_proof
target_lemma_slug: adversary_kernels_restrict_to_M_first_conjunct
status: PROVED | STUCK
tactics_used: [...]
```

```lean
-- Just provide the first conjunct's body to splice in place of `sorry` at line 998
sorry  -- replace with proof, or STUCK diagnostic
```

Aim 80-300 lines. If STUCK, clearly identify the missing structural hypothesis on σFull or bridge.

CRITICAL: model fields are `model.α/model.τM` (Greek). `AdviserKernel.kernel`, `β.isMarkov`.
