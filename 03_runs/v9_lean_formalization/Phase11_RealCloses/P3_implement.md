ROLE — Lean 4 / Mathlib prover, Phase 11 P3 real closure. Opus.

# Mission

Implement the structural refactor of `P3Hyp` per the Extended Pro design at:
`C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/03_runs/v9_lean_formalization/Phase11_RealCloses/P3_brainstorm_response.md`

The brainstorm specifies a 6-sub-structure refactor of P3Hyp:
1. `P3FiniteMenu` — finite active vertices J + label/measure functions
2. `P3PolyhedralW` — halfspace representation (A : H → Profile, b : H → ℝ)
3. `P3BayesConeFacets` — finite facets per label (g : J → Facet → Profile, c : J → Facet → ℝ)
4. `P3RowwiseRouting` — rowwise minimizer relation + tie splitting
5. `P3FiniteFlowLP` — concrete LP variables x_ij + Farkas instance encoding
6. `P3ConeMargin` — ε > 0 + slack inequalities

Then `P3Hyp` bundles all 6.

# Proof skeleton (from brainstorm)

```lean
theorem PsiNonpos_of_P3Hyp (hyp : P3Hyp model) : PsiNonpos model hyp.reg := by
  intro y
  -- Step 1: reduce Borel prices to finite (P3_Psi_le_finiteConeHall)
  have hPsi_le : hyp.reg.Psi y ≤ finiteConeHallPsi ...
  -- Step 2: finite cone-Hall dual nonpositivity (Farkas)
  have hDual := Inventory.V9.farkas_lp_duality_conic hyp.lp.farkasInst
  -- Step 3: identify Farkas dual with finite Ψ
  have hFinite : finiteConeHallPsi ... ≤ 0 := ...
  -- Step 4: conclude
  exact le_trans hPsi_le hFinite
```

# Helper lemmas needed

- `finiteConeHallPsi` def (the finite cone-Hall functional from menu/cones/routing/Y)
- `compressP3Price : BoundedBorelProfile → J → Profile model`
- `P3_Psi_le_finiteConeHall` (Borel → finite reduction)
- `P3_finiteConeHall_dual_nonpos` (Farkas application)
- Optionally `P3_bayesCones_polyhedral` (polyhedral → finite facet cones)

# Implementation steps

1. **Read** v9_appendix.lean to find P3Hyp's current location (~L5440-5520) and the `«P3-polyhedral-cone-margin»` theorem (~L5559).

2. **Add** the 6 sub-structures + auxiliary defs/lemmas BEFORE the new P3Hyp.

3. **Replace** P3Hyp with the new structure (bundling the 6).

4. **Update** `«P3-polyhedral-cone-margin»` theorem to use the new P3Hyp (its body invokes PsiNonpos_of_P3Hyp).

5. **Prove** PsiNonpos_of_P3Hyp via the 4-step skeleton.

6. **Verify** lake build exit 0.

# Constraints (BLOCKING)

- Build MUST PASS via `lake build MathlibStarter.V9Main` (exit 0).
- NO new axioms beyond the existing 9. The reusable Farkas axiom is `Inventory.V9.farkas_lp_duality_conic`.
- NO new opaque Prop fields. Every field must be concrete data or a derivable lemma.
- NO smuggling (regBridge shortcut, conclusion-shaped fields, function-fields hyp→conclusion).
- The `dual_eval_eq_finitePsi` field is acceptable ONLY if it's a definitional algebra lemma over concrete matrices — NOT a black-box equality.
- Edit lean/v9_appendix.lean AND keep V9Main.lean in sync (cat v8 v9 > main; cp main V9Main.lean; build from MathlibStarter).
- Cap 10 iterations.
- Narrow `-- TODO: <specific Mathlib gap>` sorries acceptable for unresolvable measure-theoretic / Mathlib API gaps INSIDE auxiliary lemmas, but NOT in PsiNonpos_of_P3Hyp itself.

# Acceptable end state

- PsiNonpos_of_P3Hyp PROVED (no sorry in its body).
- Net v9 sorries: ideally 5 (was 6, target -1).
- 9 axioms unchanged OR +1 narrow axiom IF a genuine external textbook theorem is needed (NOT v9_consolidated.md citation — must be Mathlib-gap textbook).
- Build PASS.

# Files

- Edit: lean/v9_appendix.lean
- Read-only: lean/v8_main.lean
- Reference: brainstorm response file (see Mission)

# Output

Concise report under 600 words: build status (exit code), sorry count delta, axiom count delta, summary of refactor, summary of PsiNonpos_of_P3Hyp proof.
