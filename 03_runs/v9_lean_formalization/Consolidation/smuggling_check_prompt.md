ROLE — Lean Smuggling Auditor. Final-pass adversarial audit. Per the role description in `prompts/soft/8b_lean_smuggling_check_soft.md` (MathPipeProver tooling, commit c19c54d).

# Context

The v9 Robust Trust formalization (`v9_appendix.lean` in project sources) was just patched to close the last source sorry (`AlphaZeroSingletonData_exists`). The patch introduced **two new axioms** in `Inventory.V9` that need adversarial scrutiny:

1. `Inventory.V9.bayes_best_response_exists` at lines 226–228.
2. `Inventory.V9.alpha_zero_posterior_collapse` at lines 230–239.

The user (Pedro) is specifically vigilant about this category: per his standing instruction, axioms whose conclusions are *proof-specific goals* (rather than named external theorems) count as SMUGGLED_AXIOM.

# Whitelist (user-supplied permitted)

From `source_proof.md §Inventory axioms expected` (originally declared dependencies):
- `Inventory.measurable_argmax_selector` (v8, KRN)
- `Inventory.krn_borel_right_inverse` (v8)
- `Inventory.kernel_infimum_epsilon_selection` (v8)
- `Inventory.V9.clarke_danskin_stationarity` (Clarke 1990 §2.7)
- `Inventory.V9.clarke_fermat_normal_cone` (Clarke 1990, Fermat rule)
- `Inventory.V9.strassen_marginals` (Strassen 1965)
- `Inventory.V9.farkas_lp_duality_conic` (Farkas)
- `Inventory.V9.hausdorff_alexandroff_continuous_surjection` (Kechris 1995 Thm 4.18)

PERMITTED data-witness fields per certificate-verifier ledger pattern (documented as `CONCLUSION_AS_FIELD`): the witness fields on `FiniteMenuData`, `BinaryCapstoneData`, `FBNFPackage`, `GraphFBNFPackage`, `RegPackage`, primitive classes.

NOT in original whitelist:
- `Inventory.V9.bayes_best_response_exists` (NEW, added 2026-05-22)
- `Inventory.V9.alpha_zero_posterior_collapse` (NEW, added 2026-05-22)

# Specific audit items

## Per-construct scrutiny

For EACH of the two new axioms, decide:

### `Inventory.V9.bayes_best_response_exists`

```lean
axiom bayes_best_response_exists
    (model : RobustTrustV8.RobustTrustModel) (μ : RobustTrustV8.Belief model.Ω) :
    ∃ σ : model.PrivateStrategy, RobustTrustV8.IsBayesOptimal model σ μ
```

Subagent's justification: "compact strategy space + linear-in-belief payoff ⇒ Bayes best response exists at every belief. `RobustTrustModel` doesn't carry continuity of `profileOfPrivate` as a structural field; `ProfileRealizationSetup` does."

Assess:
- Is this the standard form of a named external theorem (e.g., Berge maximum / Weierstrass extreme value)?
- Could it be derived from existing v8 primitives + a continuity hypothesis?
- Is the axiom's conclusion the same as the proof goal of any specific v9 theorem?

### `Inventory.V9.alpha_zero_posterior_collapse`

```lean
axiom alpha_zero_posterior_collapse
    (model : RobustTrustV8.RobustTrustModel)
    (_hα : model.α = 0)
    (c₀ : model.M)
    (β : RobustTrustV8.AdviserKernel model)
    (hβ : ∀ s : model.M, β.kernel s = MeasureTheory.Measure.dirac c₀)
    (pd : RobustTrustV8.PosteriorDisintegration model)
    (μ0 : RobustTrustV8.Belief model.Ω)
    (hμ0 : μ0.val = model.μ0) :
    ∀ᵐ m ∂ (RobustTrustV8.MixtureMessageLaw model β), pd.Pβ β m = μ0
```

Subagent's justification: "at α=0 the mixture message law collapses to the kernel's second marginal, which is itself a Dirac at c₀, and the conditional barycenter identity (`pd.conditional_barycenter`) pins `Pβ β` to the prior."

Assess:
- Is this a named external theorem? (No — it's a derivation from v8 disintegration identities.)
- Is the axiom's conclusion the SAME as a proof goal? Specifically, is it the body of `AlphaZeroSingletonData.posteriorAtConstantMessageIsPrior`? **(Check `AlphaZeroSingletonData` fields in `v9_appendix.lean` §6.)**
- Could the proof goal be derived in-scope from `pd.conditional_barycenter` + `pd.sourceLawβ_disintegrates`?

## Other smuggling categories

Sweep `v9_appendix.lean` for:
- Any `sorry` outside the whitelist (should be 0).
- Any other `axiom`, `opaque`, `constant` declarations besides those in the whitelist.
- Any `Classical.choice` / `Classical.arbitrary` uses (note: `constantMessage := Classical.arbitrary model.M` is legitimate — picking a default message from a nonempty type).
- `noncomputable section` / `unsafe` / `set_option linter ... false`.
- Structure fields of type `Prop` (vacuous) vs concrete propositions (CONCLUSION_AS_FIELD).

# Output

Per the 8b_lean_smuggling_check soft prompt format. Critical items: the two new axioms.

Final verdict OVERALL:
- Clean: YES / NO
- Severity: NONE / LOW / MEDIUM / HIGH / CRITICAL
- One-paragraph summary on whether the two new axioms should be (a) accepted + documented in source_proof.md, (b) reverted and proved from v8 primitives, or (c) refactored with stronger model-field hypotheses.

Cite line numbers in v9_appendix.lean. Adversarial. Use as much reasoning time as needed.
