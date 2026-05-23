ROLE — Lean ↔ v9 paper per-theorem verification auditor. Extended Pro (gpt-5.5-pro-xhigh).

# Context

v9 formalization at zero sorries, 9 paper-cited axioms. Verify per-theorem.

# Batch C — Binary block (6 theorems)

Audit:

1. **`«binary-L_B1-endpoint-fiber-lift»`** (v9_appendix.lean ~L2827)
2. **`«binary-L_B2-TRS-interval-reduction»`** (~L2858)
3. **`«binary-L_B3-endpoint-only-projected-image»`** (~L2871)
4. **`«binary-L_B4-interior-message-calibration»`** (~L2892)
5. **`«binary-L_B5-endpoint-stationarity-total-balance»`** (~L2926)
6. **`«binary-L_B6-capstone»`** (~L4517)

v9 paper §B.3 / exposition_v9.tex §8 covers the Binary capstone |Ω|=2 under R-EE + R-TD + R-IES.

# Audit per theorem

1. Quote Lean signature + proof body.
2. Quote v9 paper English statement + proof (v9_consolidated.md §B.3, individual L_Bi subsections).
3. Translation, Smuggling, Verdict per theorem.

Special focus:
- **B5**: was previously smuggled via scalar equality fields. Now derived via FiniteMenuData.normalized_sum_one + field arithmetic at k=2. Verify the derivation is honest and matches v9 §B.3 L_B5 (the Clarke–Danskin Fermat with k=2 active labels → integral total-balance equations).
- **B6 capstone**: uses BinaryCapstoneData.regBridge + PsiNonpos_of_regPackage + Hall biconditional + bridge. Verify this matches v9 §B.3 L_B6 (capstone assembles B1+B3+B5 + B2/B4 inputs into HasRobustRationalizableStrategy).

# Output format

Per theorem as in Batch A. End with batch verdict.
