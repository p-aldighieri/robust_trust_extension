ROLE — Lean ↔ v9 paper per-theorem verification auditor. Extended Pro.

# Batch E — Hall block + WTA + G4 (7 theorems)

Audit:

1. **`«Hall-G1-finite-cone-hall-farkas-LP»`** (~L3833)
2. **`«Hall-G2c-borel-extension»`** (~L3848)
3. **`«Hall-biconditional»`** (~L3968)
4. **`robustRationalizableKernelExists_to_strategy`** (~L4178)
5. **`«Hall-WTA-dual-certificate-psi-two-ninths»`** (~L4559)
6. **`«Hall-WTA-reopening-threshold-D»`** (~L4587)
7. **`«G4-finite-facet-polyhedral-LP-threshold»`** (~L4599)

v9 paper §B.5 / exposition_v9.tex §11 covers Hall biconditional + WTA. §13 covers G4 LP threshold.

# Audit per theorem

Same protocol.

Special focus:
- **Hall-G2c**: uses Strassen + Bogachev disintegration + KR vector-to-scalar. The Bogachev step is now `bayesian_barycenter_in_closed_convex` (lemma, was axiom, Phase 5A). Verify the proof body's measure-theoretic chain is honest.
- **Hall biconditional**: forward direction uses `PsiNonpos_of_regPackage` (lemma resting on Reg-2 construction primitives). Reverse uses G2c. Verify both directions match v9 §B.5 statement.
- **Hall-WTA Ψ=2/9**: pure numerical computation. Verify the WTA setup matches v9 §B.5 (Ω=Fin 3, uniform prior, α=1/2, dual prices y_j = 1-2e_j, support value 1/3, K-minus mean 1/9).
- **Hall-WTA threshold D**: verify `(-2αD + (1-α)(4/9) ≤ 0) ↔ (2(1-α)/(9α) ≤ D)`. Real proof via `div_le_iff₀ + nlinarith`. Verify the threshold formula matches v9 §B.5 (D ≥ 2(1-α)/(9α), corrected 2026-05-21 from prior reciprocal-form error).
- **G4**: derives via `Inventory.V9.farkas_lp_duality_conic`. Verify polyhedral LP threshold formulation matches v9 §13.

# Output

Per theorem block + batch verdict.
