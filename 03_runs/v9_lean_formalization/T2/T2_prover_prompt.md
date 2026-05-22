ROLE — Lean 4 / Mathlib prover, math template, fresh-context Opus subagent fork.

Your task is to **refine the v9 T2 theorem and discharge its proof obligations**. The skeleton already declares the theorem with a `sorry` body; you must:

1. Inspect the current v9 file at:
   `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean`
2. Find:
   - `structure AlphaZeroSingletonData where ...` (currently has abstract `Prop` fields `priorOptimal` and `posteriorAtConstantMessageIsPrior`)
   - `theorem «T2-alpha-zero-singleton-prior-strategy» ...` (currently `:= by sorry`)
3. Refine the `AlphaZeroSingletonData` Prop fields into **concrete mathematical statements**.
4. Discharge the theorem proof, consuming the (now concrete) data fields.
5. Verify the file builds clean via:
   ```
   cp "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean" "C:/Users/Public/Documents/Lean/MathlibStarter/MathlibStarter/V9Main.lean"
   cd /c/Users/Public/Documents/Lean/MathlibStarter && lake build MathlibStarter.V9Main
   ```
   Note: edit `v9_appendix.lean`, then **re-concatenate** v8 + appendix into main.lean:
   ```
   cat v8_main.lean v9_appendix.lean > main.lean
   ```
   Then copy and build.

# Math content (v9 §B.2, exposition_v9.tex §4)

The α = 0 endpoint of the robust trust model. When α = 0, the adviser is purely adversarial; alignment never occurs. The optimal payoff-profile menu collapses to a single profile (the one Bayes-optimal at the prior μ₀); the adversary's strategy of always sending one constant on-path message induces posterior = μ₀ at that message; hence the agent's constant continuation is q-a.e. Bayes-optimal under the induced posterior. Robust rationalizability follows.

# v8 primitives (already declared in `lean/v8_main.lean`, namespace `RobustTrustV8`)

You can `open RobustTrustV8` (the appendix already does). Key v8 declarations:

- `RobustTrustModel` (carrier of Ω, Θ, A, M, μ_0, τ, α, u, ...).
- `AgentStrategyFull model` (with field `sectionFull : Belief model.Ω → model.PrivateStrategy`).
- `AdviserKernel model` (with field `kernel : Kernel model.M model.M` and `isMarkov`).
- `PosteriorDisintegration model` (with fields `Pβ : AdviserKernel model → model.M → Belief model.Ω`, `Pγα`, `sourceLawβ`, `sourceLawγα`, plus `conditional_barycenter`, `sourceLawβ_disintegrates`, etc.).
- `Belief model.Ω`, `beliefAsProfile`, `beliefDot`, `beliefBarycenter`.
- `IsBayesOptimal model (σhat : model.PrivateStrategy) (μ : Belief model.Ω) : Prop`
  := `∀ σhat', PrivatePayoff model σhat' μ ≤ PrivatePayoff model σhat μ`
- `IsAdversarialFull model β σFull : Prop` := `MixturePayoffFull model β σFull = RobustPayoffFull model σFull`
- `MixtureMessageLaw model β = (ENNReal.ofReal α) • τ_M + (ENNReal.ofReal (1-α)) • ((τ_M.compProd β.kernel).map Prod.snd)`
- `Definition2QAEPredicate model pd β σFull`
  := `IsAdversarialFull model β σFull ∧ ∀ᵐ m ∂MixtureMessageLaw model β, IsBayesOptimal model (σFull.sectionFull (model.inclM m)) (pd.Pβ β m)`

# Suggested refinement of `AlphaZeroSingletonData`

Replace the current abstract Props with:

```lean
structure AlphaZeroSingletonData where
  priorStrategy : AgentStrategyFull model
  constantAdversary : AdviserKernel model

  /-- The agent's prior-strategy continuation is Bayes-optimal at the prior μ_0. -/
  priorOptimal :
    IsBayesOptimal model
      (priorStrategy.sectionFull (model.inclM (constantMessage model)))
      (priorBelief model)

  /-- The constant adversary makes the induced posterior equal the prior μ_0
  for q-a.e. message. -/
  posteriorAtConstantMessageIsPrior :
    ∀ (pd : PosteriorDisintegration model),
      ∀ᵐ m ∂MixtureMessageLaw model constantAdversary,
        pd.Pβ constantAdversary m = priorBelief model

  /-- The constant adversary attains the adversarial infimum at α=0. -/
  adversaryOptimal :
    IsAdversarialFull model constantAdversary priorStrategy
```

You may need to add helper defs `constantMessage : model.M` (some fixed message, e.g. from `model.M_nonempty`) and `priorBelief : Belief model.Ω` (= μ_0 packaged as a Belief). Add them as fields of `AlphaZeroSingletonData` if helpful.

# T2 proof outline

```lean
theorem «T2-alpha-zero-singleton-prior-strategy»
    {model : RobustTrustModel}
    (pd : PosteriorDisintegration model)
    (_hα : model.α = 0)
    (data : AlphaZeroSingletonData model)
    (hPrior : data.priorOptimal)
    (hPost : data.posteriorAtConstantMessageIsPrior)
    (hAdv : data.adversaryOptimal) :
    HasRobustRationalizableStrategy model pd := by
  refine ⟨data.constantAdversary, data.priorStrategy, hAdv, ?_⟩
  -- For q-a.e. m, the posterior equals μ_0, and the prior-strategy continuation
  -- is Bayes-optimal at μ_0.
  filter_upwards [hPost pd] with m hmPost
  rw [hmPost]
  -- IsBayesOptimal model (priorStrategy.sectionFull (model.inclM m)) μ_0
  -- The priorOptimal field gives Bayes-optimality at the constantMessage point;
  -- need to upgrade to all m (or weaken priorOptimal to ∀ m).
  sorry  -- if priorOptimal is parametric in m, this discharges directly
```

You may need to make `priorOptimal` quantify over ALL m, not just constantMessage:

```lean
priorOptimal :
  ∀ m : model.M,
    IsBayesOptimal model
      (priorStrategy.sectionFull (model.inclM m))
      (priorBelief model)
```

This is fine: when α=0, the agent's choice doesn't depend on m (the message is uninformative since α=0 means the agent doesn't trust it), so the continuation is the same Bayes-optimal-at-prior function for every m.

# Reuse of v8 helpers

If you need to construct a `priorBelief` from `model.μ0`, use:
```lean
def priorBelief (model : RobustTrustModel) : Belief model.Ω :=
  ⟨model.μ0, ⟨model.μ0_nonneg, model.μ0_sum⟩⟩
```

# Build verification

After each edit, build:
```
cat "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean" "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean" > "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean" && cp "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean" "C:/Users/Public/Documents/Lean/MathlibStarter/MathlibStarter/V9Main.lean"
cd "C:/Users/Public/Documents/Lean/MathlibStarter" && lake build MathlibStarter.V9Main
```

The build takes ~5 minutes for a fresh compile but is incremental. Tail the output for "Build completed successfully" or errors.

# Constraints

- Do not edit `v8_main.lean`. Only edit `v9_appendix.lean`.
- Do not introduce new `Inventory` axioms unless absolutely necessary. T2 is α=0 endpoint — it should not need Strassen, Clarke–Danskin, or Farkas. Just the v8 model primitives.
- Do not regress other v9 theorems' build. Keep their `sorry` bodies in place.
- The final v9_appendix.lean must build clean with ≤ 19 sorries (current count) minus 1 for T2 = ≤ 18 sorries.
- Report at the end: (a) new sorry count, (b) lines changed, (c) which AlphaZeroSingletonData refinements you adopted.

# Output

After you finish:
1. State the new sorry count.
2. State the build result (Build completed successfully OR list errors).
3. Give a short summary of the proof structure you used.
4. Flag any further refinements needed (e.g., if `priorOptimal` had to be parametric in m, etc.).

Do this in under 800 words. The actual file edits are what matters; the report is for orchestrator handoff.
