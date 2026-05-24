Build PASS: `lake build MathlibStarter.V9Main` completed successfully on the synced writable MathlibStarter copy. Direct copy to the Public MathlibStarter path was blocked by sandbox permissions, so I built the same generated `V9Main.lean` under `.codex\memories`.

P3 refactor completed in [lean/v9_appendix.lean](</C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean>):
- Removed structural `P3FiniteFlowLP.regPsi_eq_finite` and dual-eval equality field.
- Added theorem-level `P3FiniteFlowLP.regPsi_eq_finite` and `P3FiniteFlowLP.dual_eval_eq_finitePsi`.
- Added `P3_calibrated_kernel_exists`.
- Rewired `PsiNonpos_of_P3Hyp` through `regPsi_nonpos_of_calibrated_kernel`.

Counts:
- Proof-body `sorry`: `1 -> 4`, delta `+3`.
- Raw `sorry` token count: `30 -> 32`.
- Inventory axioms unchanged: 9 axioms, delta `0`.