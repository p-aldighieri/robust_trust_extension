ROLE — Lean 4 / Mathlib prover, certificate-elimination mode. Model: gpt-5.5 with extra-high reasoning (Codex CLI).

# Mission

Eliminate the certificate-verifier pattern from `«Hall-WTA-dual-certificate-psi-two-ninths»` in `lean/v9_appendix.lean`. This is a small, scoped target — the cleanest place to demonstrate cert-elim on a numerical theorem.

# Current state

```lean
theorem «Hall-WTA-dual-certificate-psi-two-ninths»
    (wta : WTAData)
    (_hCert : wta.certificatePositive) :
    wta.psiValue = (2 : ℝ) / 9 := by
  exact wta.wtaCertificateWitness  -- SMUGGLED_CERTIFICATE
```

This is the textbook cert-verifier: `wta.psiValue = 2/9` is the conclusion, and `wta.wtaCertificateWitness` (a field on `WTAData`) is `IsWTACertificate wta.psiValue` which unfolds to `wta.psiValue = 2/9`. Pure projection.

# Source math (v9_consolidated.md §B.5)

For WTA ternary uniform (Ω = {0,1,2}, prior uniform, α = 1/2), with dual prices `y_j = 1 − 2 e_j`:
- Support function: `h_{B_j}(y_j) = sup_{μ ∈ B_j} μ · y_j = 1/3`
- Conditional expectation: `E[s_j | s ∈ K_j^-] = 1/9`
- Therefore: `Ψ(y) = α · ∫_M [y_j(m) · m - h_{B_j(m)}(y_j(m))] dτ + (1-α) · ∫ ... = (1-α) · (4/9) = (1/2) · (4/9) = 2/9`.

This is pure numerical computation given the WTA ternary uniform setup.

# Required refactor

1. **Refactor `WTAData`** to carry the concrete WTA inputs as fields (not the conclusion):
   - `cardOmega : Fintype.card Ω = 3` (or directly assume Ω = Fin 3)
   - `priorUniform : ∀ ω, model.μ0 ω = 1/3`
   - `tauUniform : Prop or concrete uniform-on-Δ(Ω) statement`
   - `α_value : model.α = 1/2`
   - `dualPrices : Fin 3 → Profile model := fun j => fun ω => if ω = j then -1 else 1` (i.e. `1 - 2 e_j`)
   - (Possibly Bayes-cone descriptions for each vertex.)

2. **Define `psiOfWTA`** as a `noncomputable def` that COMPUTES Ψ(y) for the WTA setup from the inputs.

3. **Theorem `wta_psi_value_eq_two_ninths`** proves `psiOfWTA = 2/9` from the input definitions via algebraic computation. This may need:
   - `Finset.sum` over `Fin 3`
   - Integration of constants against uniform τ
   - `norm_num` for arithmetic
   - The `1-α = 1/2` substitution

4. **`«Hall-WTA-dual-certificate-psi-two-ninths»`** then takes the new `WTADataConcrete` (or refactored `WTAData`) and concludes by calling the theorem.

# Constraints (BLOCKING)

- NO new axioms.
- NO `exact wta.wtaCertificateWitness` projection.
- The theorem body must contain the actual computation.
- Build MUST PASS. Iterate until clean.
- Source sorry count: no new sorries.
- Downstream typecheck: nothing else uses `WTAData.wtaCertificateWitness` AFAIK (only this theorem). Verify by grep.

# Notes

- The current `WTAData` may need significant rework. If the existing `WTAData` is too abstract to carry concrete WTA setup, define a new `WTAConcreteData` structure with the explicit ternary fields, and re-route the theorem.
- The WTA setup is specific (Ω = Fin 3, uniform prior, uniform τ on Δ(Ω), α = 1/2). The theorem can either be parametric (taking the WTA data as input and deriving Ψ = 2/9) or fully concrete (`theorem wta_psi_two_ninths : ∃ wta, psi wta = 2/9`).

# Files

- Edit: `lean/v9_appendix.lean`
- Read-only: `lean/v8_main.lean`
- Source: `v9_consolidated.md §B.5`, `exposition_v9.tex §11`
- Per-pre-existing audit verdicts: 4 of 5 reviewer rounds noted WTA Ψ=2/9 should be a pure computation, not a certificate

# Build verification

```bash
cat "lean/v8_main.lean" "lean/v9_appendix.lean" > "lean/main.lean"
cp "lean/main.lean" "C:/Users/Public/Documents/Lean/MathlibStarter/MathlibStarter/V9Main.lean"
cd "C:/Users/Public/Documents/Lean/MathlibStarter" && lake build MathlibStarter.V9Main
```

(Run from working dir `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension`.)

# Output (final message)

Short report:
- Build status.
- Sorry count.
- New axioms (target: 0).
- Refactored WTA structures.
- Theorem body shape (no projection).
- Downstream typecheck.
