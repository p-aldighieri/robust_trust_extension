ROLE — Lean 4 / Mathlib prover, math template, fresh-context Opus subagent fork.

Your task: discharge the **last remaining sorry** in `lean/v9_appendix.lean` — the `AlphaZeroSingletonData_exists` construction. This is the v9 α=0 existence theorem: given `α = 0`, construct an `AlphaZeroSingletonData` certificate.

Files:
- `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean` (edit ONLY this; lines 1150–1154 are the target)
- `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean` (read-only)
- `01_deliverables/closure/v9_consolidated.md` §B.2 (α=0 source math)
- `01_deliverables/exposition/exposition_v9.tex` §4

# The theorem

```lean
theorem AlphaZeroSingletonData_exists
    {model : RobustTrustModel}
    (_hα : model.α = 0) :
    Nonempty (AlphaZeroSingletonData model) := by
  sorry
```

# What needs to be produced

`AlphaZeroSingletonData model` is a structure with these fields (read v9_appendix.lean §6 around line 280 for current definition):

- `priorStrategy : AgentStrategyFull model`
- `constantAdversary : AdviserKernel model`
- `priorOptimal : ∀ m, IsBayesOptimal model (priorStrategy.sectionFull (model.inclM m)) (priorBelief model)`
- `posteriorAtConstantMessageIsPrior : ∀ pd, ∀ᵐ m ∂MixtureMessageLaw model constantAdversary, pd.Pβ constantAdversary m = priorBelief model`
- `adversaryOptimal : IsAdversarialFull model constantAdversary priorStrategy`

# Construction sketch (v9_consolidated.md §B.2)

At α = 0, the agent ignores the adviser entirely:

1. **Prior-Bayes private strategy.** Use the v8 `Inventory.measurable_argmax_selector` (KRN selector) on the constant correspondence `Γ s := {σ̂ ∈ PrivateStrategy | σ̂ is Bayes-optimal at μ_0}`. This gives a measurable `priorBayesSection : Belief Ω → PrivateStrategy`. Package as `priorStrategy : AgentStrategyFull model`.

   Alternative cheaper: directly use `Classical.arbitrary` to pick a single `PrivateStrategy` (Bayes-optimal at μ_0) and have `priorStrategy.sectionFull` ignore its input. Since at α=0 every adversary attains the inf, the agent's choice need only be measurable.

2. **Constant adversary kernel.** `constantAdversary.kernel s := Measure.dirac (Classical.arbitrary model.M)`. Markov by construction.

3. **`priorOptimal m`.** By construction, `priorStrategy.sectionFull (model.inclM m)` is Bayes-optimal at `priorBelief model = ⟨μ0, μ0_nonneg, μ0_sum⟩` (uniformly in `m`).

4. **`posteriorAtConstantMessageIsPrior`.** When `model.α = 0`, the `MixtureMessageLaw model β` formula reduces to `ENNReal.ofReal 0 • τM + ENNReal.ofReal 1 • ((τM.compProd β.kernel).map Prod.snd)`. The full-measure constant-adversary second marginal is concentrated at `Classical.arbitrary model.M`. The posterior `pd.Pβ constantAdversary m` at that message equals `priorBelief` because (by `pd.conditional_barycenter`) it's the barycenter of `(sourceLawβ constantAdversary) m`, and at α=0 the only contribution is from the (constant) adversary's uninformative kernel.

5. **`adversaryOptimal`.** At α=0, `MixturePayoffFull β σ = 0·AlignedPayoff + 1·MisalignedPayoffFullRaw β σ = MisalignedPayoffFullRaw β σ`. For the message-ignoring `priorStrategy`, `MisalignedPayoffFullRaw β σ = ∫ s, ∫ m, beliefDot (model.inclM s) (model.profileOfPrivate (σ.sectionFull (model.inclM m))) dβ(s) dτM`. Since the profile doesn't depend on `m` (because `priorStrategy.sectionFull` is the constant Bayes-at-prior section), the inner integral simplifies to a constant in `m`, so the value is independent of `β`. Hence ANY adversary, including `constantAdversary`, attains the robust infimum.

# Constraints

- Edit ONLY `lean/v9_appendix.lean`. The target is the `theorem AlphaZeroSingletonData_exists` body (currently `sorry`).
- This is the LAST sorry. After this round source sorry count should be 0.
- DO NOT modify other theorems.
- Use v8 primitives. `Inventory.measurable_argmax_selector` is available. The `priorBelief` and `constantMessage` helper defs exist (lines 292–297).
- The construction can be partial — you may need to introduce a small helper lemma (e.g., "α=0 → MixtureMessageLaw is the adversarial second-marginal") proved separately.
- Cap at 5 build attempts.
- If you can't fully close it, leave a smaller sorry inside the construction with a precise comment about what's still needed.

# Build verification

```
cat "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean" "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean" > "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean"
cp "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean" "C:/Users/Public/Documents/Lean/MathlibStarter/MathlibStarter/V9Main.lean"
cd "C:/Users/Public/Documents/Lean/MathlibStarter"
lake build MathlibStarter.V9Main
```

# Output

Report in under 500 words:
- Build status (PASS / FAIL with error).
- Source sorry count (target: 0).
- Construction summary (what you used: Classical.arbitrary, measurable_argmax_selector, etc.).
- Any sub-lemmas you introduced.
- Any remaining sorries inside the construction (with precise reason).
