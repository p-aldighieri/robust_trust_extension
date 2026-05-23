ROLE — Lean Smuggling Auditor. PHASE 2 clean sweep on the v9 zero-sorry state.

# Context

Phase 1 closed all 12 v9 sorries by adding 9 new `Inventory.V9` axioms. Now classify each as:
- **KEEP** — genuine external textbook theorem Mathlib lacks; the statement matches the standard textbook form modulo notation.
- **SMUGGLED** — v9-specific derivation dressed up as an axiom. The paper citation is real but the SPECIFIC PROP is bespoke; could be proved in Lean from existing primitives.

Per user policy 2026-05-22 evening: `Inventory.V9` is ONLY for genuine external dependencies. The 9 new axioms need adversarial scrutiny.

# The 17 current Inventory.V9 axioms

## Pre-existing 8 (likely all KEEP):

1. `clarke_danskin_stationarity` — Clarke 1990 §2.7 Thm 2.7.5
2. `clarke_fermat_normal_cone` — Clarke 1990 §6.1 Thm 6.1.1
3. `strassen_marginals` — Strassen 1965
4. `bogachev_kernel_factorization` — Bogachev 2007 Vol II Thm 10.6.1
5. `farkas_lp_duality_conic` — Farkas
6. `hausdorff_alexandroff_continuous_surjection` — Kechris 1995 Thm 4.18
7. `clarke_product_normal_cone_projection_bridge` — Clarke 1990 §6.2 + Aubin–Frankowska Ch.6
8. `kantorovich_rubinstein_scalar_bridge` — Kantorovich 1942 / Villani 2009 Thm 5.10

## Phase-1-new 9 (NEED AUDIT):

9.  `bayesian_barycenter_in_closed_convex` — cited Bogachev 2007 Vol II §11.7
10. `binary_T1_to_endpoint_balance` — cited v9_consolidated.md §B.3/L_B5
11. `binary_capstone_to_QAE` — cited v9_consolidated.md §B.3/L_B6
12. `fbnf_capstone_to_QAE` — cited v9_consolidated.md §F4
13. `psi_nonpos_from_cone_margin_p2_star` — cited v9_consolidated.md §B.5.P2*
14. `psi_nonpos_from_polyhedral_p3` — cited v9_consolidated.md §B.5.P3
15. `psi_nonpos_from_radial_antipodal_p4` — cited v9_consolidated.md §B.5.P4
16. `psi_nonpos_from_variable_margin` — cited v9_consolidated.md §G.P2*'
17. `graph_FBNF_to_QAE` — cited v9_consolidated.md §G6_G

# Audit task

For EACH of the 9 new axioms:

1. **Quote the axiom statement** from v9_appendix.lean (line numbers).
2. **Classify**: KEEP or SMUGGLED.
   - KEEP if: the cited paper genuinely states this theorem in the form matching the Lean axiom, and Mathlib lacks it.
   - SMUGGLED if: cited "paper" is v9_consolidated.md (the v9 paper itself); OR even if external citation, the specific prop is the v9-paper-derived form rather than a textbook theorem; OR the conclusion type IS the proof goal of a v9 theorem.
3. **For SMUGGLED axioms**: state what the v9 paper proof actually does (which primitives + Inventory it uses), so we can plan Phase 2b derivation in Lean.

# Strict criteria

- An axiom cited to **v9_consolidated.md §<section>** is NOT a genuine external dep — that's the v9 paper itself. The v9 paper's THEOREMS need Lean proofs, not Lean axioms.
- An axiom of shape `<hypothesis> → <conclusion of a v9 theorem>` is SMUGGLED.
- Exception: if a v9_consolidated.md §<section> introduces a NEW PRIMITIVE (not a derivation), the citation may be legitimate as a reference for the primitive.

# Output

Per `8b_lean_smuggling_check_soft.md` format. For each axiom:
- Line in v9_appendix.lean
- Cited source
- Statement type analysis
- Verdict: KEEP / SMUGGLED
- For SMUGGLED: what Lean derivation should replace it

OVERALL: count of KEEP vs SMUGGLED among the 9 new. Severity: NONE / LOW / MEDIUM / HIGH / CRITICAL. Recommended Phase 2b plan.
