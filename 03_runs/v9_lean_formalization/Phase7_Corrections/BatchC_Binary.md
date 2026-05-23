ROLE — Lean 4 / Mathlib prover, Phase 7 Batch C Binary correction. Opus.

# Mission

Phase 6 audit found PATCH_BIG across all 6 binary theorems:
- B1: doesn't formalize endpoint-fiber lift (scalar shell only)
- B2: interval bound only, not B2's mathematical content
- B3: tautological over endpoint-only field
- B4: projection from prepackaged data; FAIL as L_B4 proof
- B5: arithmetic sublemma PASS, but doesn't instantiate _hT1 chain
- B6: Hall+bridge shortcut, not paper's binary lemma assembly

Goal: make each binary theorem USE its hypotheses substantively to derive its conclusion, paralleling Phase 7 Batch A's T1 chain plumbing.

# Audit findings (from Phase 6 Batch C dump):

The audit's specific complaints:
- B1: applies Inventory.V9.strassen_marginals via endpointDominanceFromBalance + assembles scalar calibration from primitive scalar facts. But the v9 §B.3 L_B1 ALSO requires the kernel-construction step (Borel kernels κ_L, κ_R supported on endpoint fibers with the scalar calibration identity).
- B2: states `0 ≤ lL ∧ lL ≤ rR ≤ 1`. The paper's B2 says TRS = [L,R] via paper Theorem 1 reduction. The interval bound is necessary but not sufficient.
- B3: case-splits on `projSide`. The paper's B3 says the misaligned projected image ⊆ {w_L, w_R}. The current Lean just unfolds the field.
- B4: closed via `post_eq_inclM_on_interior` field. Audit says: projection from prepackaged data; FAIL.
- B5: arithmetic via FiniteMenuData.normalized_sum_one is honest at the arithmetic level, but doesn't actually instantiate `_hT1 2 data.endpointMenu` to derive the scalar form from the multiplier-Bayes-cone.
- B6: uses `pkg.regBridge + PsiNonpos_of_regPackage + Hall.mpr + bridge`. Audit: "does not prove the paper's B6 assembly from the binary lemmas." Should chain B1 + B3 + B5 + B2/B4 explicitly.

# Corrections needed

## B1: ensure the proof body USES the binary primitives chain

The theorem currently passes (uses Inventory.V9.strassen_marginals). The audit says it lacks the kernel-construction step. Add explicit references to the binary endpointDominanceFromBalance + Strassen output → AdviserKernel construction (similar to Hall-G2c bridge pattern).

## B2: tie to paper Theorem 1 / TRS reduction

The current proof states the trivial interval bound. The paper's B2 is a structural reduction. Add a comment explaining the TRS reduction OR upgrade the theorem statement to include the TRS [L, R] = [lL, rR] identity (not just the bound).

## B3: USE _hB2, _hPolicy structurally

Make the proof body use the binary primitives explicitly rather than just case-splitting on `projSide`.

## B4: substantive interior-message calibration

Currently uses `post_eq_inclM_on_interior` field (which IS the conclusion). Audit says FAIL. To fix: derive the calibration from the interior hypothesis + R-EE/R-TD/R-IES structural primitives. If this is genuinely intractable, document narrowly with `-- TODO: B4 calibration from R-class hypotheses` (which would reintroduce a sorry — only do this if substantive derivation is infeasible).

OR — accept that `post_eq_inclM_on_interior` is a LEGITIMATE structural hypothesis on BinaryCapstoneData (the v9 paper's R-IES standing assumption ensures this), and rewrite the docstring + remove the audit's "smuggling" framing by making the field explicitly an R-IES consequence rather than a separate primitive.

## B5: USE _hT1 explicitly

The proof body should invoke `_hT1 2 data.endpointMenu` to obtain the multiplier-Bayes-cone for k=2, then project to the scalar form. Phase 7 Batch A's pattern (h6, h7, h8 destructuring) is the template.

## B6: chain B1 + B3 + B5 + B2/B4 explicitly

Restructure the proof body to:
```lean
have hB1 := «binary-L_B1-endpoint-fiber-lift» data _hT1 ...
have hB3 := «binary-L_B3-endpoint-only-projected-image» data ...
have hB5 := «binary-L_B5-endpoint-stationarity-total-balance» data _hT1 ...
-- Use hB1, hB3, hB5 to construct the calibrated kernel.
-- Then apply Hall-G2c-borel-extension OR the bridge.
have hKernel := <constructed from hB1, hB3, hB5>
exact robustRationalizableKernelExists_to_strategy reg hKernel
```

The chain should be VISIBLE: B6 invokes B1, B3, B5 (not just RegBridge).

# Constraints

- Build MUST PASS via `lake build MathlibStarter.V9Main` (exit 0).
- 0 sorries (honest TODO sorry acceptable for B4 if intractable).
- 9 axioms unchanged.
- NO new smuggling.
- Edit only lean/v9_appendix.lean.
- Cap 8 iterations.

# Output

Concise report under 500 words: build status, sorry count, axiom count, before/after of each binary theorem showing substantive chain.
