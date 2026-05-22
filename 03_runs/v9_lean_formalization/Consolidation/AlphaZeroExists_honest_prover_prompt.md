ROLE — Lean 4 / Mathlib prover, math template, fresh-context Opus subagent fork. HONEST DERIVATION mode.

Your task: discharge `AlphaZeroSingletonData_exists` in `lean/v9_appendix.lean` from v8 primitives, **without introducing any new Inventory axioms**.

# BLOCKING CONSTRAINT

Per `/lean-smuggling-check` verdict 2026-05-22 on the previous attempt:
- Adding an axiom whose conclusion is the proof goal (or a structure field on the proof path) is **SMUGGLED_AXIOM** and will be rejected.
- The previous attempt added `Inventory.V9.bayes_best_response_exists` and `Inventory.V9.alpha_zero_posterior_collapse` — BOTH were caught as trapdoors. They have been REMOVED. Do NOT re-add them or anything similar.

You may NOT:
- Declare new `axiom`, `opaque`, or `constant` items in `Inventory.V9` or anywhere.
- Use `Classical.choice` to pull a witness for an existence claim that should have been proved.
- Set a structure field equal to a constant `True` to skirt a proof obligation.

You MAY:
- Use any v8 primitive in `RobustTrustV8` namespace.
- Use any existing `Inventory.V9.*` axiom (Clarke-Danskin, Clarke-Fermat, Strassen, Farkas, hausdorff_alexandroff_continuous_surjection).
- Add `Inventory.V9` hypothesis arguments to `AlphaZeroSingletonData_exists` (e.g., take a `PosteriorLawConsistency` instance as an argument). If the v8 model doesn't carry the needed continuity for the Bayes-best step, ADD AN ARGUMENT (`(prs : ProfileRealizationSetup model)`) rather than adding an axiom.
- Leave a `sorry` if you genuinely cannot close — `sorry` is honest; smuggled axioms are not.

# Files

- `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean` (edit ONLY this; theorem at ~line 1209)
- `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean` (read-only)

# v8 primitives the auditor specifically recommended

- `PosteriorLawConsistency` (v8_main.lean L224) with field `barycenter_eq_prior : beliefBarycenter model.τ = model.μ0` at L229. **This is the legitimate prior/barycenter consistency hypothesis.**
- `ProfileRealizationSetup` (v8_main.lean L421) — contains continuity of profileOfPrivate via its setup. Use to derive the Bayes-best-strategy existence step.
- `pd.conditional_barycenter`, `pd.sourceLawβ_disintegrates` (v8 `PosteriorDisintegration` fields). These are the disintegration identities.
- `MixtureMessageLaw model β = ENNReal.ofReal α • τM + ENNReal.ofReal (1-α) • ((τM.compProd β.kernel).map Prod.snd)` — at α=0, the first term vanishes; if β.kernel s = Measure.dirac c₀ for all s, the second term equals Measure.dirac c₀.

# The construction (honest version)

Add hypotheses to `AlphaZeroSingletonData_exists` to make the missing structure explicit. The new signature should be roughly:

```lean
theorem AlphaZeroSingletonData_exists
    {model : RobustTrustModel}
    (hα : model.α = 0)
    (plc : PosteriorLawConsistency model)       -- prior/barycenter consistency
    (prs : ProfileRealizationSetup model) :     -- continuity for Bayes-best
    Nonempty (AlphaZeroSingletonData model) := by
  ...
```

Then the wrapper `«T2-alpha-zero-singleton-prior-strategy»` needs to take `plc` and `prs` too, or be parametric in them.

Construction steps:
1. **Bayes-best existence**: derive `∃ σ, IsBayesOptimal model σ (priorBelief model)` from `prs` (compact strategy space + continuous profileOfPrivate → Weierstrass argmax). Use Mathlib's `IsCompact.exists_isMaxOn` or `IsCompact.exists_isMinOn` from `Mathlib.Topology.Order.Compact`. NO AXIOM.

2. **Constant adversary kernel**: as before, `Kernel.const M (Measure.dirac c₀)` for `c₀ := constantMessage`.

3. **`priorOptimal m`**: by construction.

4. **`posteriorAtConstantMessageIsPrior`**: prove from:
   - `hα : α = 0` (so `MixtureMessageLaw = (τM.compProd β.kernel).map Prod.snd`)
   - β.kernel s = Dirac c₀ (so the second marginal is Dirac c₀)
   - `pd.conditional_barycenter`: q-a.e. posterior = barycenter of sourceLawβ
   - `pd.sourceLawβ_disintegrates`: the sourceLawβ at message m identifies with...
   - `plc.barycenter_eq_prior`: barycenter of τ = μ_0
   - Algebraic: at the single q-a.e. mass point m = c₀, the barycenter sourceLaw collapses to barycenter τ = μ_0.

   This is a real proof, maybe 30-80 lines.

5. **`adversaryOptimal`**: same argument as before — `MisalignedPayoffFull β priorStrategy` is independent of β when priorStrategy is message-ignoring (constant integrand integrated against any Markov kernel is the constant). The Set.range argument from the previous attempt is fine — it didn't use any smuggled axiom, just `integral_congr_ae` + Markov kernel constant-integral. **Restore that block.**

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
- New Inventory.V9 axioms added: 0 (target). If you added any, the work is rejected.
- Sorries remaining inside the construction (with reason — be honest).
- Hypothesis arguments added to `AlphaZeroSingletonData_exists` (e.g., `plc`, `prs`).
- Sub-lemmas added (with their types).
- Whether `«T2-alpha-zero-singleton-prior-strategy»` wrapper needs updating to match new signature.

Cap at 5 build attempts. Honest is better than complete: a clean partial proof with documented sorries beats a "closed" proof using smuggled axioms.
