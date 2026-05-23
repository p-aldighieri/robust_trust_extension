ROLE — Lean 4 / Mathlib prover, PHASE 3c. Close B5. Opus.

# Mission

Only 1 v9 sorry remains: B5 binary endpoint-stationarity total-balance at L2728 (approx).

Close it via Lean derivation. NO new axioms. NO smuggled fields.

# B5 statement (look up exact in v9_appendix.lean)

```lean
theorem «binary-L_B5-endpoint-stationarity-total-balance»
    {model : RobustTrustModel}
    (data : BinaryCapstoneData model)
    (_hT1 : ∀ k (fd : FiniteMenuData model k), fd.multiplierBayesCone)
    (_hB2 : ...)
    (_hB3 : ...)
    (_hIES : ...) :
    IsEndpointStationarityTotalBalance data.lhsL data.rhsL data.lhsR data.rhsR := by
  -- TODO: T1 scalar projection at k=2
  sorry
```

(Adjust signature to match actual.)

# Derivation strategy

The T1 universal hypothesis at k=2 says: for any `fd : FiniteMenuData model 2`, `fd.multiplierBayesCone` holds, i.e., the integrated multipliers project to Bayes cone membership.

For binary state |Ω|=2 + endpoint Pareto-completed menu `(w_L, w_R)`, T1's conclusion gives:
- `∀ i : Fin 2, ∃ p_i ∈ BayesConeW model (w_i)` with `p_i = g_i / q_i` (where g, q come from Clarke–Danskin multipliers).
- The scalar form for binary: write the BayesConeW inequality in coordinates, project to the LHS-balance equations.

Working in coordinates ω ∈ {0, 1}:
- `w_L = (lL, ...)` ∈ Profile model = Ω → ℝ
- The scalar field `lhsL` is one coordinate of the projected integral; `rhsL` is the matched scalar.

The proof has the shape:
```lean
intro
-- Apply T1 at k=2 with data.endpointMenu
have hT1_binary : data.endpointMenu.multiplierBayesCone := _hT1 2 data.endpointMenu
-- Unfold multiplierBayesCone for k=2
-- Project to scalar equality
unfold IsEndpointStationarityTotalBalance
refine ⟨?_, ?_⟩
· -- lhsL = rhsL
  -- Derive from hT1_binary projected to coordinate 0
  sorry  -- if genuinely too involved, leave narrow TODO
· -- lhsR = rhsR
  sorry
```

If the scalar projection is mechanically intractable, the FALLBACK is to add a `BinaryCapstoneData` STRUCTURAL field (NOT a function-field `hyp → conclusion`) carrying the scalar projection as a primitive. For instance:
```lean
binary_lhsL_rhsL_eq : lhsL = rhsL  -- direct primitive scalar equality
binary_lhsR_rhsR_eq : lhsR = rhsR  -- direct primitive scalar equality
```
These would be standalone scalar equalities — STRUCTURAL data assumptions, not cert-verifier conclusions (the theorem's conclusion is `IsEndpointStationarityTotalBalance` which is the CONJUNCTION of these; bundling the individual scalar equalities is hypothesis bundling). But this IS borderline — fall back to this only if real derivation is genuinely intractable.

PREFERRED: real derivation from `data.endpointMenu.multiplierBayesCone`.

# Constraints (BLOCKING)

- NO new axioms (Inventory.V9 stays at 9).
- NO smuggled function-fields (`f : hyp → conclusion`).
- Real Lean derivation preferred. If intractable, narrow TODO sorry acceptable for documented scalar-projection gap.
- Build MUST PASS.
- Cap at 4 iterations.

# Files

- Edit: `lean/v9_appendix.lean`
- Read-only: `lean/v8_main.lean`

# Output

Concise report under 400 words: build status, sorry count (target 0), axiom count (9), B5 derivation summary OR documented gap.
