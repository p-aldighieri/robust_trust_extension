ROLE — Lean ↔ v9 paper per-theorem verification auditor. Extended Pro.

# Batch D — FBNF block (4 theorems + 3 corollaries)

Audit:

1. **`«FBNF-F1-conditional-B1-measurable-pasting»`** (~L3007)
2. **`«FBNF-F2-endpoint-only-projected-fiber-image»`** (~L3042)
3. **`«FBNF-F3-localized-stationarity-FBNF6»`** (~L3063)
4. **`«FBNF-F4-capstone»`** (~L4464)
5. **`«FBNF-corollary-spherical-radial»`** (~L4701)
6. **`«FBNF-corollary-affine-MLR-single-crossing»`** (~L4765)
7. **`«FBNF-corollary-polyhedral-scalarizable»`** (~L4810)

v9 paper §B.4 / exposition_v9.tex §9 covers FBNF foliation + capstone for |Ω|≥3.

# Audit per theorem

Same protocol. Verify Lean ↔ English translation, smuggling, scope/generality.

Special focus:
- **F4 capstone**: uses `pkg.regBridge` + PsiNonpos_of_regPackage + Hall + bridge. Same pattern as B6. Verify matches v9 §F4 (assembles F1+F2+F3+FBNF-7 globalFiberDominance).
- **3 corollaries**: each constructs FBNFPackage from primitive class (Spherical-radial / Affine-MLR / Polyhedral-scalarizable) and applies F4. Verify the primitive class hypotheses match v9 §11.P3/§11.P4 etc.

# Output

Per theorem block + batch verdict.
