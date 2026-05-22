ROLE — Lean Smuggling Auditor. Per `prompts/soft/8b_lean_smuggling_check_soft.md` (updated 2026-05-22 to flag CERTIFICATE_VERIFIER as SMUGGLED_CERTIFICATE).

# Context

The T1 block in `v9_appendix.lean` was refactored to "eliminate" certificate-verifier pattern:
- The 4 T1 theorems (`T1-L6...`, `T1-L7...`, `T1-L8...`, `T1-clarke-danskin-multiplier-bayes-cone`) no longer have `exact data.<concluson-field>` bodies — they `unfold` the predicates and construct from atomic fields.
- A new `ParetoMenuPrimitives` structure was introduced at v9_appendix.lean:559 to bundle the "atomic" inputs.
- A constructor `FiniteMenuData.fromParetoMenu` at L636 builds the FiniteMenuData record.

# Audit task

Adversarially decide whether `ParetoMenuPrimitives` constitutes legitimate hypothesis-bundling or merely PUSHES THE SMUGGLING ONE LEVEL DOWN.

Per the user's strict directive (2026-05-22): "EVERYTHING NEEDS TO BE PROVED (except for dependencies), no if certificate then conclusion. this should be clearly flagged as assumption smuggling."

# Specific fields to audit in ParetoMenuPrimitives

Per docstrings, three fields are claimed "primitive" but actually carry conclusion content:

1. `normal_cone_inequality : ∀ i v, v ∈ PayoffProfileSet model → (∑ ω, g i ω * (v ω - paretoMenu i ω)) ≤ 0`
   - Provenance docstring: "Clarke 1990 §6.1 Thm 6.1.1 + projection to coordinates."
   - **Question**: Is this a derivation result of `Inventory.V9.clarke_fermat_normal_cone` + a `ClarkeNormalCone-to-NormalConeW` projection lemma? Should it be derived in Lean rather than bundled?

2. `g_nonneg : ∀ i ω, 0 ≤ g i ω`
   - Provenance docstring: basis perturbation argument under Pareto-completion.
   - **Question**: Is this derivable from the other primitive fields (lamPlus_nonneg, paretoCompleted) + a one-line algebraic argument? Should it be derived?

3. `mass_balance : ∀ i, (∑ ω, g i ω) = q i`
   - Provenance docstring: simplex-weight identity (s ∈ Δ(Ω) sums to 1).
   - **Question**: This appears to be a definitional fact about how g and q are constructed from λ⁺. If `g i := α·∫_{S⁺_i} s dτ + (1-α)·∫_{S⁻_i} s dτ` and `q i := α·τ(S⁺_i) + (1-α)·τ(S⁻_i)` and `s ∈ Δ(Ω)` (so `∑ ω s ω = 1`), this should follow by Fubini + integral_const + scalar arithmetic. Should it be derived?

# Other smuggling categories

Sweep the file for:
- Other CONCLUSION_AS_FIELD / SMUGGLED_CERTIFICATE patterns (any `... := exact data.<field>` where the field is conclusion-shaped).
- New `sorry`, `axiom`, `opaque`, `constant`.
- `Classical.choice` abuse.
- Bare `Prop` fields in any hypothesis structure (FBNF, Binary, Hall packages — they may still have the old pattern).

# Output

Per `8b_lean_smuggling_check_soft.md` format. Include the new `smuggled_certificates` counter.

OVERALL verdict on the T1 cert-elim round 1:
- Did it eliminate certificate-verifier from T1 theorem bodies? (Likely YES — they unfold predicates now.)
- Did it preserve the v9 ledger soundness, or did it push the smuggling into `ParetoMenuPrimitives`?
- Severity: NONE / LOW / MEDIUM / HIGH / CRITICAL.
- Recommended next step: ACCEPT as honest partial, OR DERIVE specific fields, OR REVERT.

Cite line numbers in v9_appendix.lean.
