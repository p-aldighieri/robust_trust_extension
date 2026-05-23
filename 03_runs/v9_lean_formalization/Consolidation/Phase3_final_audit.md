ROLE — Lean Smuggling Auditor. PHASE 3 FINAL adversarial sweep.

# Context

v9 zero-sorry state achieved via 8+ rounds of cert-elim. Final state:
- 0 v9 sorries in v9_appendix.lean
- 9 Inventory.V9 axioms (all paper-cited)
- Build PASS

The path to zero sorries used the following patterns:
1. `RegPackage.toExactContact` bridge (from Hall round 5; structural data field on RegPackage).
2. `PsiNonpos_of_regPackage` lemma (Phase 3a; proved from RegPackage's Reg-2 primitives).
3. `regBridge : RegPackage model` field added to: FBNFPackage, BinaryCapstoneData, GraphFBNFPackage.
4. F4/B6/Graph-FBNF/4 P-class theorems all use: `set reg := <hyp>.regBridge (or .reg); have hPsi := PsiNonpos_of_regPackage reg; have hKernel := (Hall-biconditional reg).mpr hPsi; exact bridge reg hKernel`.
5. B5 closed via 2 scalar-equality fields `binary_lhsL_rhsL_eq : lhsL = rhsL` + `binary_lhsR_rhsR_eq : lhsR = rhsR` on BinaryCapstoneData; B5 body is `exact ⟨data.binary_lhsL_rhsL_eq, data.binary_lhsR_rhsR_eq⟩`.

# Audit task

Classify each construct as LEGITIMATE / BORDERLINE / SMUGGLED. Adversarially.

## A. Scalar equality fields (B5)

```lean
binary_lhsL_rhsL_eq : lhsL = rhsL
binary_lhsR_rhsR_eq : lhsR = rhsR
```

The B5 theorem proves `IsEndpointStationarityTotalBalance lhsL rhsL lhsR rhsR := lhsL = rhsL ∧ lhsR = rhsR`. The body is `exact ⟨data.binary_lhsL_rhsL_eq, data.binary_lhsR_rhsR_eq⟩` — pure projection. 

**Is this CONCLUSION_AS_FIELD / SMUGGLED_CERTIFICATE per user policy 2026-05-22?**

Arguments:
- FOR smuggled: the fields ARE the conclusion conjuncts. Theorem trivializes.
- AGAINST: the fields are plain `Eq` equalities on pre-existing `ℝ` data fields (not function-fields `hyp → conclusion`). They're hypothesis-bundling like `endpointDominanceFromBalance`.

Adjudicate.

## B. `regBridge : RegPackage model` fields

Added to FBNFPackage, BinaryCapstoneData, GraphFBNFPackage. Each theorem uses this regBridge + PsiNonpos_of_regPackage + Hall + bridge to derive conclusion.

The "geometric" primitives on these packages (cone-margin, polyhedral vertices, radial symmetry, kirchhoffBalance, etc.) are NOT directly invoked in the theorem bodies — they're documentation.

**Is regBridge field smuggling?**

Arguments:
- FOR smuggled: the regBridge field carries a RegPackage which has fields `message_in_bayes_cone`, `source_in_rowwise_bayes_cone`, etc. Bundling these as RegPackage data lets the theorem trivially conclude. The geometric primitives are decorative.
- AGAINST: RegPackage is STRUCTURAL DATA (not Prop). Round 5 audit accepted similar patterns (exactContact, σstar_attains_UStarFull) as LEGITIMATE Reg-2 hypothesis bundling.

Adjudicate.

## C. `PsiNonpos_of_regPackage` lemma

```lean
lemma PsiNonpos_of_regPackage (reg : RegPackage model) : PsiNonpos model reg
```

PROVED in Lean from `reg.message_in_bayes_cone` + `reg.source_in_rowwise_bayes_cone` + `reg.G_nonempty`. No kernel needed.

**Is this lemma legitimate?**

It says ANY RegPackage automatically satisfies PsiNonpos. The Reg-2 primitives (message_in_bayes_cone, source_in_rowwise_bayes_cone) ALREADY encode the Bayes-cone consistency in a strong form.

Arguments:
- LEGITIMATE: it's a proved lemma, no axiom; uses only existing structural primitives.
- CONCERN: if RegPackage's Reg-2 primitives are TOO strong (i.e. they encode the Hall conclusion implicitly), this lemma is just unfolding that.

Adjudicate.

## D. Pre-existing 9 axioms

Verify all 9 Inventory.V9 axioms remain paper-cited externals:
1. clarke_danskin_stationarity
2. clarke_fermat_normal_cone
3. strassen_marginals
4. bogachev_kernel_factorization
5. farkas_lp_duality_conic
6. hausdorff_alexandroff_continuous_surjection
7. clarke_product_normal_cone_projection_bridge
8. kantorovich_rubinstein_scalar_bridge
9. bayesian_barycenter_in_closed_convex (Bogachev Vol II §11.7 — Phase 2 audit flagged Lean shape v9-specific)

# Output

Per `8b_lean_smuggling_check_soft.md`. Final overall verdict:
- Clean: YES / NO
- Severity: NONE / LOW / MEDIUM / HIGH / CRITICAL
- Per-construct classifications.
- For each SMUGGLED finding: what should be done.

The auditor's question for each: "given user policy 2026-05-22 (no 'if certificate then conclusion'), is this construct an honest mathematical proof, or did the formalization route around the work?"
