ROLE — Lean 4 / Mathlib prover, Phase 7 Batch D FBNF correction. Opus.

# Mission

Phase 6 Batch D FAIL/REVISE. Findings:
- F1: scalar shell, doesn't formalize fiber-level B1 pasting (paper: foliation-conditional measurable kernel construction).
- F2: collapses trust-region band T_z = ℓ_z([L(z), R(z)]) to raw foliation endpoints (a_z, b_z). Different theorem.
- F3: too scalar/global. Should be fiberwise λ-a.e. balance with two integral equations, not lhs=rhs scalar.
- F4: MAJOR SMUGGLING. Uses regBridge + PsiNonpos_of_regPackage shortcut, doesn't derive Ψ ≤ 0 from FBNF data.
- 3 corollaries: store primitive fields but powered by trivial pieces (fbnf_trivial_*) + generic F4 bridge.

# Priority fix

**The KEY fix is F4**: introduce `PsiNonpos_of_FBNFPackage` lemma that derives Ψ ≤ 0 from F1 + F2 + F3 + FBNF-7 (globalFiberDominance), NOT from RegPackage shortcut.

The audit recommends:
> "Introduce a genuine lemma PsiNonpos_of_FBNFPackage whose proof uses F1, F2, F3, and FBNF-7. Do not allow PsiNonpos_of_regPackage to prove Ψ≤0 without the FBNF balance and pasting data."

If genuinely intractable in budget, add a narrow TODO sorry inside this new lemma rather than continuing to smuggle through regBridge. The user prefers a documented honest sorry over a hidden shortcut.

# Corrective approach

## F4 refactor

Add new lemma:
```lean
lemma PsiNonpos_of_FBNFPackage 
    {model : RobustTrustModel}
    (pkg : FBNFPackage model) 
    (hF1 : ...) (hF2 : ...) (hF3 : ...) (hDom : ...) :
    PsiNonpos model pkg.regBridge := by
  -- Use F1's kernel construction, F2's endpoint-supported projection,
  -- F3's fiberwise balance, FBNF-7 global dominance to derive Ψ ≤ 0
  -- WITHOUT going through PsiNonpos_of_regPackage.
  sorry  -- if intractable, narrow TODO; otherwise derive
```

Then F4 capstone:
```lean
theorem «FBNF-F4-capstone» (pkg : FBNFPackage model) :
    HasRobustRationalizableStrategy model pkg.pd := by
  have hF1 := «FBNF-F1-...» pkg ...
  have hF2 := «FBNF-F2-...» pkg ...
  have hF3 := «FBNF-F3-...» pkg ...
  have hPsi := PsiNonpos_of_FBNFPackage pkg hF1 hF2 hF3 pkg.fbnf7
  have hKernel := («Hall-biconditional» pkg.regBridge).mpr hPsi
  exact robustRationalizableKernelExists_to_strategy pkg.regBridge hKernel
```

This makes F1+F2+F3+F7 actually feed Ψ ≤ 0.

## Corollaries (Spherical-radial, Affine-MLR, Polyhedral-scalarizable)

Audit says they use `fbnf_trivial_pasting`/`fbnf_trivial_fiberImage`/`rfl` shortcuts. Real geometric data (radial diameters, MLR order, polyhedral vertex enumeration) isn't used.

Fix: each corollary should construct an FBNFPackage from its primitive class's geometric data, not trivial placeholders.

If full replacement is intractable, ADD a TODO comment + narrow sorry documenting the geometric construction gap. Better than smuggled placeholders.

## F1, F2, F3 statement adjustments

- F1: scalar shell is acceptable IF the docstring acknowledges this is the v9 fiberwise pasting at the scalar level (per §F1 specifies). Add docstring note.
- F2: introduce L : Z → ℝ, R : Z → ℝ trust-region band fields on FBNFPackage. Update F2 conclusion to reference T_z = ℓ_z([L z, R z]).
- F3: change `fbnf6Lhs : ℝ`, `fbnf6Rhs : ℝ` to fiberwise predicate `∀ᵐ z ∂λ, BalanceL z ∧ BalanceR z` where BalanceL/R are the two FBNF integral equations.

These are structural refactors of FBNFPackage. Comprehensive but necessary.

# Constraints

- Build MUST PASS via `lake build MathlibStarter.V9Main` (exit 0).
- Narrow TODO sorries acceptable for:
  - PsiNonpos_of_FBNFPackage (if FBNF→Ψ derivation intractable).
  - Real corollary geometric construction (if intractable per primitive class).
- NO new axioms (Inventory.V9 stays at 9) unless a NEW genuine external (Mathlib gap) is needed.
- NO new cert-verifier patterns.
- Build MUST PASS.
- Edit only lean/v9_appendix.lean.
- Cap 8 iterations.

# Output

Concise report under 500 words: build status, sorry count, axiom count, before/after of F4 + corollaries showing the new PsiNonpos_of_FBNFPackage chain.
