ROLE — Lean Smuggling Auditor. **Final adversarial sweep** of the v9 surface after all cert-elim rounds. Per `prompts/soft/8b_lean_smuggling_check_soft.md` (MathPipeProver, updated 2026-05-22 to flag CERTIFICATE_VERIFIER as SMUGGLED_CERTIFICATE).

# Context

All cert-elim rounds are complete (T1, T2, WTA, Hall, Binary, FBNF, G4). The user's directive 2026-05-22 was:

> EVERYTHING NEEDS TO BE PROVED (except for dependencies), no if certificate then conclusion. this should be clearly flagged as assumption smuggling.

Audit the final state of `v9_appendix.lean` in the project sources for ANY remaining smuggling.

# Whitelist (user-supplied permitted)

From `source_proof.md §Inventory axioms expected`:
- v8 reused: `Inventory.measurable_argmax_selector`, `Inventory.krn_borel_right_inverse`, `Inventory.kernel_infimum_epsilon_selection`
- v9 declared: `Inventory.V9.clarke_danskin_stationarity` (Clarke 1990 §2.7 Thm 2.7.5), `Inventory.V9.clarke_fermat_normal_cone` (Clarke 1990 §6.1 Thm 6.1.1), `Inventory.V9.strassen_marginals` (Strassen 1965 / KR duality), `Inventory.V9.farkas_lp_duality_conic` (Farkas), `Inventory.V9.hausdorff_alexandroff_continuous_surjection` (Kechris 1995 Thm 4.18)
- v9 added during cert-elim: `Inventory.V9.clarke_product_normal_cone_projection_bridge` (Clarke 1990 §6.2 + Aubin–Frankowska Ch.6, product normal-cone projection)

NOT permitted:
- ANY new axiom not listed above. Sweep `^axiom`, `^opaque`, `^constant` in `Inventory.V9` namespace and verify every name matches the whitelist with paper citation.
- ANY structure field whose type is the proof goal of a theorem (CERTIFICATE_VERIFIER pattern).
- ANY theorem body of shape `exact <data>.<witness>` where `<witness>` is conclusion-shaped.

# Audit items

## A. Axiom inventory

List all entries in `namespace Inventory.V9`. Confirm:
- Names match whitelist.
- Each has a paper citation in docstring.
- No opaques with `Prop`-conclusion (those were the original trapdoor).
- No new axioms added beyond the 6 whitelisted (5 originals + 1 product-projection bridge).

## B. Cert-verifier / projection sweep

For EVERY headline theorem in v9 surface, confirm the body is NOT `exact <data>.<witness>` projection. Theorems:
1. T1-L6, T1-L7, T1-L8, T1-clarke-danskin-multiplier-bayes-cone
2. T2-alpha-zero-singleton-prior-strategy (and AlphaZeroSingletonData_exists, AlphaZeroSingletonData.to_hasRobustRationalizableStrategy)
3. binary-L_B1 through L_B6
4. FBNF-F1 through F4 + 3 corollaries
5. Hall-G1, Hall-G2c, Hall-biconditional, robustRationalizableKernelExists_to_strategy
6. Hall-WTA-dual-certificate-psi-two-ninths
7. Hall-WTA-reopening-threshold-D
8. G4-finite-facet-polyhedral-LP-threshold
9. P2-star, P3-polyhedral, P4-radial
10. G-addendum-binary-tie-splitting, G-addendum-variable-margin-P2-star-prime, G-addendum-P6_G-finite-graph-FBNF

For each, classify the body:
- REAL_DERIVATION: invokes axiom/Mathlib + non-trivial steps.
- HONEST_SORRY: body has explicit `sorry` for a documented gap.
- SMUGGLED_CERTIFICATE: body is `exact <data>.<conclusion-shaped-field>` (FAIL).
- OTHER: explain.

## C. Hypothesis structure sweep

For every hypothesis structure (FBNFPackage, BinaryCapstoneData, RegPackage, FiniteMenuData, FiniteConeHallInstance, WTAData, PolyhedralLPInstance, P2StarHyp, P3Hyp, P4Hyp, BinaryTieSplittingHyp, VariableMarginP2Hyp, GraphFBNFPackage, ParetoMenuPrimitives, ProductClarkeFermatPrimitive, AlphaZeroSingletonData, the three FBNF primitives, MessageSupportM, PosteriorLawConsistency, ProfileRealizationSetup), confirm:
- No field's type is a verbatim copy of a theorem's conclusion.
- All `Prop` fields are either honest hypotheses (R-EE, tie discipline, perturbability) or genuine axiom-output existentials (Clarke subgradient witness, Strassen coupling witness).

## D. `sorry` count + scope

List every `sorry` in `v9_appendix.lean`. For each:
- Is it in a permitted location (Inventory axiom can have sorry-like body? No — axioms aren't sorries) or in a theorem body?
- Is there a precise comment explaining what's missing?

## E. Other smuggling

`Classical.choice` abuse, `noncomputable section` hiding something, tactic suppressions, etc.

# Output

Per `8b_lean_smuggling_check_soft.md` format. Final OVERALL verdict:

- **Clean**: YES / NO
- **Cert-verifier eliminated**: YES / NO (must be YES per user directive)
- **All axioms paper-cited**: YES / NO
- **Honest sorry count + scope**: list each
- **Severity**: NONE / LOW / MEDIUM / HIGH / CRITICAL
- **Mergeable as a v9 ledger with documented external dependencies**: YES / NO

Cite line numbers in v9_appendix.lean.
