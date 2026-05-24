ROLE — Lean Smuggling Auditor (updated 2026-05-23 with SMUGGLED_UNIVERSAL_HELPER + HYPOTHESIS_AS_PAPER_DERIVATION categories). FINAL Phase 12 zero-gap reviewer pass.

# Context

Phase 12 zero-gap refactor (per user directive 2026-05-23): every per-class `regPsi_le_X_integral` structural field on hypothesis packages REPLACED with a derived theorem; `G_rowwise_carries_prior_to_bayes_cone` DERIVED from new G_eq_rowwiseBayesMinimizers primitive.

# State to audit (v9_appendix.lean)

- Build: PASS `lake build MathlibStarter.V9Main` exit 0, 8264 jobs.
- v9 sorries: 10 (narrow TODOs INSIDE derived theorems for substantive paper-§ derivation steps; NOT structural fields).
- Inventory.V9 axioms: 9 (unchanged — all paper-cited textbook externals).

Phase 12 changes:
- 12a: common pattern (`localSlack` + `regPsi_le_integral_localSlack_of_kernel` + `regPsi_nonpos_of_calibrated_kernel`) added near `regPsi`.
- 12b: P2StarHyp → P2StarGeom; structural `regPsi_le_jam_minus_eta_integral` removed; `PsiNonpos_of_P2StarGeom` derived.
- 12c: P3 — structural `lp.regPsi_eq_finite` + `lp.dual_eval_eq_finitePsi` removed; theorem-level versions added; `PsiNonpos_of_P3Hyp` derived via `regPsi_nonpos_of_calibrated_kernel`.
- 12d: P4 — structural `regPsi_le_reflectionBalance_integral` removed; deterministic antipodal kernel constructed; `PsiNonpos_of_P4Hyp` derived.
- 12e: VariableMargin — structural `regPsi_le_densityCap_minus_eta_integral` removed; calibrated kernel constructed from variable margin data; derived.
- 12f: GraphFBNF — structural `regPsi_le_graphEdgeIntegrand_integral` removed; calibrated kernel from edge-flow + Kirchhoff; derived.
- 12g: FBNF F4 — structural `regPsi_le_fiber_integral` removed; calibrated kernel from foliation disintegration; derived.
- 12h: Binary B6 — structural `regPsi_le_binaryIntegrand_integral` removed; calibrated kernel from B1+B2+B3+B4+B5 chain; derived.
- 12i: G_rowwise_carries_prior — field removed; new `G_eq_rowwiseBayesMinimizers` primitive + derived lemma.

# Audit checks

A. **No `regPsi_le_X_integral` STRUCTURAL FIELDS remain on any P-class structure.** Each is either a derived theorem or absent. Verify via grep.

B. **No `G_rowwise_carries_prior_to_bayes_cone` STRUCTURAL FIELD on RegPackage.** It's a derived lemma now.

C. **No `PsiNonpos_of_regPackage` calls in any P-class capstone theorem.** Each routes via its per-class `PsiNonpos_of_<Class>` theorem.

D. **HYPOTHESIS_AS_PAPER_DERIVATION findings**: any remaining structural fields on P-class structures that bundle paper-derivation results? (Should be NONE after Phase 12.)

E. **SMUGGLED_UNIVERSAL_HELPER findings**: any universal lemma whose conclusion is so general it discharges per-class theorems trivially? The Phase 12a common-pattern lemma `regPsi_nonpos_of_calibrated_kernel` requires a calibrated kernel as input — each P-class must CONSTRUCT one from its geometric data. Verify this is genuine per-class consumption, not universal-helper-bypass.

F. **9 axioms** (all paper-cited textbook externals).

G. **10 v9 sorries**: each should be a narrow TODO at a specific substantive paper-§ derivation step (not a structural shortcut). List each with its substantive content.

# Output

Per soft prompt 8b_lean_smuggling_check_soft.md format. OVERALL verdict:
- Clean: YES / NO
- Severity: NONE / LOW / MEDIUM / HIGH / CRITICAL
- Per-section verdicts (A-G).
- Recommendation: ACCEPT / further work.

User wants ZERO GAP between paper and Lean — the Lean architecture should equal or exceed paper rigor.
