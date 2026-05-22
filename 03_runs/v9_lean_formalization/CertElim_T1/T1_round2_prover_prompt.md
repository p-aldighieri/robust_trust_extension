ROLE — Lean 4 / Mathlib prover working on the v9 Robust Trust formalization. CERTIFICATE-ELIMINATION round 2, model: gpt-5.5 with extra-high reasoning.

# Mission

Round 1 of T1 cert-elimination (subagent commit `7412742`) was caught by the smuggling auditor with **HIGH severity FAIL**: the certificate-verifier pattern was moved out of the four T1 theorem bodies but pushed into `ParetoMenuPrimitives` as three SMUGGLED_CERTIFICATE / DERIVABLE_FACT_AS_FIELD fields. Round 2 must derive those three fields.

Read the audit verdict at:
`C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/03_runs/v9_lean_formalization/CertElim_T1/T1_smuggling_audit_response.md`

# Targets (3 fields in ParetoMenuPrimitives, currently at v9_appendix.lean:559-612)

## 1. `normal_cone_inequality` (line ~609)

**Current**: free field of type `∀ i v, v ∈ PayoffProfileSet model → (∑ ω, g i ω * (v ω - paretoMenu i ω)) ≤ 0`.

**Required**: derive in Lean from `Inventory.V9.clarke_fermat_normal_cone` + a product-normal-cone-projection step. The auditor says:
- Apply Clarke-Fermat on the product space `W^k`.
- Project the product normal-cone inclusion to a per-label normal-cone inclusion.
- Unfold `NormalConeW` to get the inner-product form.

This may require introducing an inner-product representation of `ClarkeNormalCone` for product spaces — that's the missing bridge. Either:
(a) Prove the projection step directly using Mathlib's product/normal-cone API.
(b) If Mathlib lacks the projection theorem, add ONE Inventory.V9 axiom with a precise paper citation (e.g., Clarke 1990 §6.2 / Aubin–Frankowska Set-Valued Analysis Ch.6) for the product-to-component normal-cone projection. Document with paper-source citation.

The honest approach: derive what's derivable; for the bridge axiom (if needed), STATE IT PRECISELY with a verifiable paper source. The smuggling auditor allows MATCHES if there's a paper citation.

## 2. `g_nonneg` (line ~592)

**Current**: free field of type `∀ i ω, 0 ≤ g i ω`.

**Required**: make `g` a `noncomputable def`:
```lean
noncomputable def gOf (lamPlus lamMinus : model.M → Fin k → ℝ) (α : ℝ) (τ : Measure model.M) (i : Fin k) : Profile model :=
  fun ω => α * (∫ s, lamPlus s i * s.val ω ∂τ) + (1 - α) * (∫ s, lamMinus s i * s.val ω ∂τ)
```
(where `s.val ω` extracts the coordinate of `s : Belief Ω` mapped to a real). Adjust types as needed using `model.inclM` to convert `model.M → Belief model.Ω` if necessary.

Then **prove** `g_nonneg` from:
- `α ∈ [0,1]`
- `lamPlus s i ≥ 0`, `lamMinus s i ≥ 0`
- `s.val ω ≥ 0` (Belief is a probability distribution)
- `MeasureTheory.integral_nonneg` for the integrals

This is a 5-10 line proof using `MeasureTheory.integral_nonneg` + nonneg of products.

## 3. `mass_balance` (line ~604)

**Current**: free field of type `∀ i, (∑ ω, g i ω) = q i`.

**Required**: similarly make `qOf` a `def`:
```lean
noncomputable def qOf (lamPlus lamMinus : model.M → Fin k → ℝ) (α : ℝ) (τ : Measure model.M) (i : Fin k) : ℝ :=
  α * (∫ s, lamPlus s i ∂τ) + (1 - α) * (∫ s, lamMinus s i ∂τ)
```

Then **prove** `mass_balance`: 
- `∑ ω, g i ω = ∑ ω [α * ∫ lamPlus s i * s.val ω dτ + (1-α) * ∫ lamMinus s i * s.val ω dτ]`
- Swap sum and integral (Fubini / `Finset.sum_integral_eq_integral_sum`)
- Use `∑ ω, s.val ω = 1` (Belief sums to 1)
- Get `∑ ω, g i ω = α * ∫ lamPlus s i dτ + (1-α) * ∫ lamMinus s i dτ = q i`.

# Constraints (BLOCKING)

- **NO additional axioms beyond Inventory.V9** except possibly ONE for the product-normal-cone projection (with verifiable paper citation: Clarke 1990 §6.2 or Aubin–Frankowska or Rockafellar–Wets Variational Analysis).
- **NO bare `Prop` fields** added to ParetoMenuPrimitives.
- **Honest sorry allowed** for unresolvable Mathlib API gaps; document the gap with a specific Mathlib lemma name needed.
- **Build MUST PASS**. Iterate as many times as needed.
- **Downstream theorems (binary L_B5, FBNF F3) must still typecheck.**
- **Provide `FiniteMenuData.fromParetoMenu` constructor** that uses the new derivations to discharge the FiniteMenuData fields (do not copy `prim.normal_cone_inequality` etc. — derive them).

# Refactored `ParetoMenuPrimitives` should look like

```lean
structure ParetoMenuPrimitives {model} (k : Nat) where
  -- Honest hypothesis inputs (Clarke-Danskin outputs + raw model data):
  paretoMenu : Fin k → Profile model
  inWP : ∀ i, paretoMenu i ∈ WP model
  localMax : Prop          -- still abstract for now
  paretoCompleted : Prop   -- still abstract for now
  lamPlus : model.M → Fin k → ℝ
  lamPlus_nonneg : ∀ s i, 0 ≤ lamPlus s i
  lamPlus_sum_one : ∀ s, ∑ i, lamPlus s i = 1
  lamPlus_measurable : Measurable (fun s => lamPlus s)
  lamMinus : model.M → Fin k → ℝ
  lamMinus_nonneg : ...
  lamMinus_sum_one : ...
  lamMinus_measurable : ...
  -- α=0/α=1 boundary handling (still primitive):
  alpha_in_unit : 0 ≤ model.α ∧ model.α ≤ 1
  -- Clarke-Fermat-on-W^k consequence at the product level (ONLY input for normal cone derivation):
  clarke_fermat_at_paretoMenu :
    ∀ i : Fin k, ∃ ξ : Profile model →L[ℝ] ℝ,
      -- some concrete Clarke-Fermat conclusion at the projected level
      ...
  -- (FORBIDDEN: normal_cone_inequality, g_nonneg, mass_balance as free fields)
```

Then `gOf`, `qOf` are defs; `g_nonneg`, `mass_balance`, `normal_cone_inequality` are theorems / `have`s.

# Files

- Edit: `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean`
- Read-only: `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean`
- Audit verdict: `T1_smuggling_audit_response.md` (in this dir)
- Source: v9_consolidated.md §B.1, exposition_v9.tex §3

# Build verification

```bash
cat "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean" "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean" > "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean"
cp "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean" "C:/Users/Public/Documents/Lean/MathlibStarter/MathlibStarter/V9Main.lean"
cd "C:/Users/Public/Documents/Lean/MathlibStarter" && lake build MathlibStarter.V9Main
```

# Output (final message)

Concise report:
- Build status (PASS/FAIL with error).
- Sorry count.
- New axioms added (count + paper-source citations if any).
- Three target fields: which are now derived, which are still bundled, which use sorry/axiom.
- Downstream typecheck status (binary L_B5, FBNF F3).
- Files edited.
