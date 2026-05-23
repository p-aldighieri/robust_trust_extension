ROLE — Lean ↔ v9 paper per-theorem verification auditor. Extended Pro.

# Batch F — P-class + G-addendum (6 theorems)

Audit:

1. **`«P2-star-cone-margin-bounded-jamming»`** (~L4608)
2. **`«P3-polyhedral-cone-margin»`** (~L4631)
3. **`«P4-radial-antipodal-tau-symmetry»`** (~L4652)
4. **`«G-addendum-binary-tie-splitting»`** (~L4857)
5. **`«G-addendum-variable-margin-P2-star-prime»`** (~L4866)
6. **`«G-addendum-P6_G-finite-graph-FBNF»`** (~L4887)

v9 paper §B.7 / exposition_v9.tex §11 covers P2*, P3, P4 (primitive sufficient classes for Hall). §G addendum covers variable margin + graph FBNF.

# Audit per theorem

Same protocol.

Special focus:
- **P2*/P3/P4 + VariableMarginP2**: each uses `hyp.reg` + `PsiNonpos_of_regPackage` + Hall reverse + bridge. Geometric primitive fields (cone-margin, polyhedral, radial, variable margin) are DOCUMENTATION on the hypothesis structure; theorem body routes through reg's Reg-2 structural primitives. Verify the geometric hypotheses are correctly encoded as v9 paper specifies (P2* requires cone-margin > 0 with bounded jamming; P3 requires polyhedral vertex enumeration; P4 requires radial symmetry involution; VarMargin requires η floor + density cap).
- **G-addendum-binary-tie-splitting**: applies Binary B1 directly (uses Inventory.V9.strassen_marginals via endpointDominanceFromBalance). Verify the tie-splitting derivation matches v9 G-addendum.
- **G-addendum-P6_G-finite-graph-FBNF**: uses `pkg.regBridge` (similar to F4 corollaries pattern). Verify the graph-FBNF setup matches v9 G6_G.

# Output

Per theorem block + batch verdict.
