ROLE — Lean 4 / Mathlib prover, math template, fresh-context Opus subagent fork. HONEST DERIVATION mode.

Your task: close the **single remaining sorry** in `AlphaZeroSingletonData_exists` (the `posteriorAtConstantMessageIsPrior` field branch), without introducing new Inventory axioms.

File: `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean`

# Current state

`AlphaZeroSingletonData_exists` (around line 1218) takes `(_plc : PosteriorLawConsistency model)` and `(prs : ProfileRealizationSetup model)`. Three of four data fields are proved from v8 primitives. The fourth (`posteriorAtConstantMessageIsPrior`) is the only `sorry` left. Find it in the proof body and close it.

# BLOCKING CONSTRAINTS

- DO NOT add new `axiom`, `opaque`, or `constant` items.
- DO NOT add new Inventory.V9 entries.
- DO NOT use Classical.choice to pull a witness for an existence claim.
- DO NOT set the field to `True`.
- May leave a SMALLER `sorry` inside a sub-step if a specific Mathlib lemma is missing — but document precisely what's needed.

# What needs to be proved

The `posteriorAtConstantMessageIsPrior` field body, when unfolded:

```lean
∀ pd : PosteriorDisintegration model,
  ∀ᵐ m ∂MixtureMessageLaw model constantAdversary,
    pd.Pβ constantAdversary m = priorBelief model
```

where `constantAdversary.kernel s = Measure.dirac (constantMessage model)` for all `s`, and `model.α = 0` (available as `_hα`).

# Proof chain (per smuggling auditor 2026-05-22)

1. **Mixture law collapse at α=0:** Show `MixtureMessageLaw model constantAdversary = Measure.dirac (constantMessage model)`.
   - Unfold `MixtureMessageLaw = ENNReal.ofReal α • τM + ENNReal.ofReal (1-α) • ((τM.compProd β.kernel).map Prod.snd)`.
   - With `α = 0`: first term is `0`. Second term is `ENNReal.ofReal 1 • ((τM.compProd (Kernel.const M (dirac c₀))).map Prod.snd)`.
   - The compProd of τM with a constant Dirac kernel pushed to second coordinate equals `Measure.dirac c₀` (need `Measure.compProd_const`-style lemma; check Mathlib).
   - So `MixtureMessageLaw = Measure.dirac c₀`.

2. **q-a.e. over Dirac:** `∀ᵐ m ∂Measure.dirac c₀, P m` iff `P c₀`. (Mathlib: `MeasureTheory.ae_dirac_eq` or `Measure.ae_dirac_iff`.)
   - Reduces the goal to `pd.Pβ constantAdversary c₀ = priorBelief model`.

3. **Conditional barycenter pin:** Use `pd.conditional_barycenter constantAdversary` (this gives `beliefBarycenter ((pd.sourceLawβ constantAdversary) m) = beliefAsProfile (pd.Pβ constantAdversary m)` q-a.e.).

4. **Disintegration identity:** `pd.sourceLawβ_disintegrates constantAdversary` lets us identify what the source-law looks like at m = c₀.

5. **Prior/barycenter consistency:** `_plc.barycenter_eq_prior` says `beliefBarycenter model.τ = model.μ0`.
   - Combined with steps 3-4, this should pin `pd.Pβ constantAdversary c₀ = priorBelief model`.

# Constraints recap

- Use ONLY v8 primitives + existing Inventory.V9.
- ProbabilityTheory.Kernel.const, Measure.dirac, Measure.compProd, Measure.map — all in Mathlib.
- If a specific Mathlib API turns out missing, REPORT it precisely; do not add a v9 axiom for it.

# Build verification

```
cat "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean" "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean" > "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean"
cp "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean" "C:/Users/Public/Documents/Lean/MathlibStarter/MathlibStarter/V9Main.lean"
cd "C:/Users/Public/Documents/Lean/MathlibStarter"
lake build MathlibStarter.V9Main
```

Cap at 5 build attempts. Target: 0 source sorries.

# Output

Report under 400 words:
- Build status.
- Source sorry count (target 0).
- Sub-lemmas added (with their types).
- Mathlib lemmas used (e.g., Measure.compProd_const, Measure.ae_dirac_iff).
- Any honest sorry left with precise reason.
- New Inventory.V9 axioms added (target: 0).
