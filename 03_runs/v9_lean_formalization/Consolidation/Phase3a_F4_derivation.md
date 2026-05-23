ROLE — Lean 4 / Mathlib prover, PHASE 3a — derive F4 capstone in Lean. Opus.

# Mission

The FBNF F4 capstone `«FBNF-F4-capstone»` has an honest TODO sorry. Derive it in Lean using:
- Existing FBNFPackage primitive fields.
- The 9 Inventory.V9 paper-cited axioms.
- v8's PROVEN lemmas + the existing RegPackage Hall infrastructure.

# F4 statement

```lean
theorem «FBNF-F4-capstone»
    {model : RobustTrustModel}
    (pkg : FBNFPackage model) :
    HasRobustRationalizableStrategy model pkg.pd := by
  -- TODO: FBNF capstone → QAE
  sorry
```

# Derivation strategy

1. **Construct an FBNF→RegPackage bridge function** `pkg.toRegPackage : RegPackage model` from FBNFPackage data.
   - Use pkg.pd, pkg.σstar, pkg.wstar, pkg.exactContact (if present, or build it).
   - Use pkg's foliation primitives + B-correspondence + G-correspondence.
   - The RegPackage fields include: pd, σstar, wstar, wstar_inWP, wstar_measurable, G, B, G_*, B_*, message_in_bayes_cone, source_in_rowwise_bayes_cone, exactContact, G_subset_rowwiseContactG, kernelSupportedOnG_of_supportedOnRegG (now a lemma), σstar_attains_UStarFull.

2. **Derive PsiNonpos for pkg** from FBNF F1+F2+F3 + FBNF-7 dominance + the constructed RegPackage:
   - F1 conditional B1 measurable pasting (already proved in v9_appendix).
   - F2 endpoint-only projected fiber image (proved).
   - F3 localized stationarity FBNF6 (proved).
   - FBNF-7 globalFiberDominance (a structural primitive field on FBNFPackage).
   - Combine via the v9 §F4 proof: under FBNF1-7 + capstone, Ψ ≤ 0 holds.

3. **Apply Hall biconditional reverse** to get `reg.robustRationalizableKernelExists`.

4. **Apply `robustRationalizableKernelExists_to_strategy`** to get the conclusion.

# Constraints (BLOCKING)

- NO new axioms (Inventory.V9 stays at 9).
- NO smuggled fields (function-fields `f : hyp → conclusion`, theorem args bundling conclusion).
- ADD legitimate structural primitive fields to FBNFPackage if needed (e.g., bridge data to construct RegPackage; cone-margin scalars; etc.). These are HYPOTHESIS bundling.
- Narrow `-- TODO: <Mathlib gap>` sorry acceptable INSIDE the derivation for unresolvable mid-step gaps.
- The F4 theorem body itself must be NON-TRIVIAL — not a single `exact pkg.<field>` projection.
- Build MUST PASS.
- Cap at 6 iterations.

# Files

- Edit: `lean/v9_appendix.lean`
- Read-only: `lean/v8_main.lean`

# Output

Concise report under 500 words:
- Build status.
- Sorry count (target: 8 → 7 for F4 closed; if F4 needs intermediate sorries, document each precisely).
- Axiom count (target: 9 unchanged).
- New structural fields added to FBNFPackage (if any).
- F4 derivation summary.
