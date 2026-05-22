ROLE — adversarial fresh-session peer-reviewer for a Lean 4 / Mathlib proof of theorem **T2-alpha-zero-singleton-prior-strategy** in the v9 Robust Trust formalization.

Sources in this project:
- `v9_appendix.lean` (the current v9 file; T2 just discharged, ~30 sorries remaining for other lemmas)
- `v8_main.lean` (baseline namespace `RobustTrustV8` with model primitives)
- `v9_consolidated.md` (master memo; T2 in §B.2)
- `exposition_v9.tex` (canonical statement; T2 in §4)
- `decomposition.md`, `source_proof.md`, `lean_state.md`

# What was proved

The α=0 endpoint of Robust Trust Theorem 2. When the alignment probability is exactly zero, the adviser is purely adversarial. The agent should ignore the message and play a strategy that is Bayes-optimal at the prior μ_0; combined with the constant adversary that induces posterior = μ_0 q-a.e., this gives robust rationalizability.

# What the prover did

1. **Refined `AlphaZeroSingletonData`** from abstract `Prop` placeholders to concrete content:
   - `priorBelief (model) : Belief model.Ω := ⟨model.μ0, model.μ0_nonneg, model.μ0_sum⟩` — packages μ_0 as a Belief.
   - `constantMessage (model) : model.M := Classical.arbitrary model.M` — distinguished on-path message.
   - Fields:
     - `priorStrategy : AgentStrategyFull model`
     - `constantAdversary : AdviserKernel model`
     - `priorOptimal : ∀ m : model.M, IsBayesOptimal model (priorStrategy.sectionFull (model.inclM m)) (priorBelief model)` — parametric in `m`, not just at the constant message.
     - `posteriorAtConstantMessageIsPrior : ∀ pd : PosteriorDisintegration model, ∀ᵐ m ∂MixtureMessageLaw model constantAdversary, pd.Pβ constantAdversary m = priorBelief model`
     - `adversaryOptimal : IsAdversarialFull model constantAdversary priorStrategy`

2. **Proved T2** with this proof:
   ```lean
   theorem «T2-alpha-zero-singleton-prior-strategy»
       {model : RobustTrustModel}
       (pd : PosteriorDisintegration model)
       (_hα : model.α = 0)
       (data : AlphaZeroSingletonData model) :
       HasRobustRationalizableStrategy model pd := by
     refine ⟨data.constantAdversary, data.priorStrategy,
       data.adversaryOptimal, ?_⟩
     filter_upwards [data.posteriorAtConstantMessageIsPrior pd] with m hmPost
     simpa [hmPost] using data.priorOptimal m
   ```

3. **Build:** `lake build MathlibStarter.V9Main` → PASS (8264 jobs, 0 errors).

# Audit items

## R1 — Refinement soundness

The refined `AlphaZeroSingletonData` carries CONCRETE Props. Verify each is correctly stated against the v9 source (§B.2 of v9_consolidated.md, §4 of exposition_v9.tex):

(a) Is `priorOptimal` correctly **parametric in `m`**? The math says "the agent's continuation depends on the message only through the posterior, and when α=0 every posterior is μ_0, so the continuation is the same Bayes-at-prior choice for every m." If `priorOptimal` only held at `constantMessage`, the proof would fail at messages off the constant route. Confirm parametric form is the right v9 interpretation.

(b) Does `posteriorAtConstantMessageIsPrior` correctly capture "constant adversary collapses posterior to μ_0 q-a.e."? At α=0, `MixtureMessageLaw model β = (τ_M.compProd β.kernel).map Prod.snd` (the second marginal of the source × constant-adversary joint). For a constant kernel `β.kernel s = δ_{m_0}`, this becomes `δ_{m_0}` — so the "for q-a.e. m" reduces to "at m_0". But the formulation in the data field quantifies over the full mixture message law. Is this still mathematically right, or does it gloss over a degenerate-measure subtlety?

(c) Is `adversaryOptimal : IsAdversarialFull model constantAdversary priorStrategy` the right α=0 statement? At α=0, `MixturePayoffFull = (1-α)·MisalignedPayoffFull = MisalignedPayoffFull`. So `IsAdversarialFull = MisalignedPayoffFull = RobustPayoffFull = inf over β of MisalignedPayoff = inf of MisalignedPayoff`. The constant adversary is asserted to attain this infimum — this is a real existence/attainment claim that the prover did NOT verify; it is just assumed by data field. Is this acceptable as data, or does it sweep T2's actual hardness under the rug?

## R2 — Proof tactic soundness

The proof is essentially:
```
refine ⟨..., data.adversaryOptimal, ?_⟩  -- closes IsAdversarialFull half
filter_upwards [data.posteriorAtConstantMessageIsPrior pd] with m hmPost
simpa [hmPost] using data.priorOptimal m
```

Verify:
(a) `refine ⟨_, _, _, ?_⟩` correctly unfolds `HasRobustRationalizableStrategy model pd = ∃ β σ, Definition2QAEPredicate model pd β σ = ∃ β σ, IsAdversarialFull ∧ ∀ᵐ m, IsBayesOptimal`. The anonymous constructor flattens `∃` + `∃` + `And`; confirm this is how Lean elaborates it.

(b) `filter_upwards` consumes the q-a.e. statement from `posteriorAtConstantMessageIsPrior pd` and rewrites the goal at each `m` in the full-measure set. After `hmPost : pd.Pβ constantAdversary m = priorBelief model`, the goal `IsBayesOptimal model (data.priorStrategy.sectionFull (model.inclM m)) (pd.Pβ data.constantAdversary m)` reduces by `simpa [hmPost]` to `IsBayesOptimal ... (priorBelief model)`, which is exactly `data.priorOptimal m`. Confirm `simpa [hmPost]` is the right tactic — would `rw [hmPost]; exact data.priorOptimal m` be more explicit?

## R3 — `_hα : model.α = 0` unused

The hypothesis `_hα` is never consumed in the proof. The prover's report flags this. Is this acceptable because the α=0 content is fully absorbed into the data fields (the posterior collapse and the adversary attainment are α=0-specific in their construction at the data-witness site), OR does this mean the theorem's signature is misleading and we should remove `_hα`?

If we keep `_hα`, the theorem says "if α=0 AND we have data satisfying these properties, then robust rationalizability." If we remove `_hα`, the theorem says "if we have data satisfying these properties, then robust rationalizability" — which is true at any α (because the data already encodes α-specific content). Which is the right statement for the v9 ledger?

## R4 — Witness existence shifted to data

The original v9 T2 statement (in the consolidated memo) constructs the constant adversary and the prior-Bayes strategy from `(Ω, μ_0, τ, A, Θ, u, α=0)`. The refined `AlphaZeroSingletonData` takes these as given. This means T2 no longer proves α=0 implies the data exists; it only proves "if data, then conclusion."

Is this a fair v9 ledger statement, or has the prover sidestepped the meaningful α=0 content (existence of the prior-Bayes-optimal strategy + constant adversary)?

If sidestepped, a follow-up theorem is needed:
```lean
theorem AlphaZeroSingletonData_exists
    {model : RobustTrustModel} (hα : model.α = 0) :
    Nonempty (AlphaZeroSingletonData model) := ...
```

Flag this as a follow-up if the v9 source actually requires it.

## R5 — Source alignment

Verify against `v9_consolidated.md §B.2`:
- Does the source say "agent plays Bayes-optimal-at-prior strategy for every message" (matching parametric priorOptimal), or "agent plays a single private strategy" (matching constantMessage-only)?
- Does the source say "constant on-path message" or "constant kernel (Dirac)" for the adversary?
- Is the data witness's α-dependence correctly absorbed?

## R6 — Anything missed

Adversarial. Scan for any v9 §B.2 / §4 content that should be in the formalized T2 but isn't.

# Output

```
T2 PROVER REVIEW — VERDICT: PASS / PATCH / RESTART

For each R1–R6:
  Verdict: OK / PATCH / FLAG
  If PATCH: precise patch.

OVERALL
  - Is the T2 proof mergeable to v9-formalization branch?
  - Confidence: HIGH / MEDIUM / LOW
  - One-paragraph summary
  - If PATCH or PASS: list any follow-up theorems needed (e.g., AlphaZeroSingletonData existence).
```

Cite line numbers in v9_appendix.lean. Adversarial. Use as much reasoning time as needed.
