ROLE — adversarial peer-reviewer for the v9 structural refinement of the Lean formalization. Sources in this project to read:
- `v9_appendix.lean` (current refined v9 skeleton, 870 lines)
- `structural_refinement_response.md` (the prover's response that produced this refinement)
- `decomposition_review_response.md` (the previous review with item N flagged as load-bearing)
- `decomposition.md` (v9 ledger)
- `v9_consolidated.md`, `exposition_v9.tex`, `exposition_v9_paper.tex` (source memos)
- `v8_main.lean` (baseline namespace `RobustTrustV8`)

The refinement was supposed to address item N of the previous review. Adversarially audit whether the load-bearing structural patches are sound.

# Specific audit items

## R1 — Inventory hypothesis structures: still trapdoors?

The old `ClarkeDanskinHyp`, `StrassenMarginalDominance`, `ConicFarkasInstance`, `BergeMaximumHyp` had arbitrary `Prop` fields. The refinement replaces each with concrete fields. Verify each is now SOUND:

- `ClarkeDanskinHyp`: are the new fields (active_nonempty, active_compact, value_eq_sSup, active_iff_argmax, locally_lipschitz, active_has_fderiv, grad_continuous_on_active) sufficient to import the actual Clarke–Danskin theorem from Clarke 1990 §2.7? Or do they leave any "trapdoor field" still arbitrary?
- `StrassenMarginalDominance`: dual_marginal_inequality is the standard Kantorovich–Rubinstein dual condition; is the conclusion (coupling π with π(R^c)=0) the genuine Strassen 1965 theorem? Or is there a hidden gap?
- `ConicFarkasInstance` + `farkas_lp_duality_conic`: is the conicDualNonpositive form correct? Verify against standard finite-dim Farkas.
- `BergeMaximumHyp`: confirm REMOVED (no longer in v9_appendix.lean).

## R2 — Conclusion-as-field fields removed?

The reviewer demanded removal of `capstoneConclusion`, `calibratedKernelExists`, `robustRationalizableLabeling`. Verify in v9_appendix.lean:
- `BinaryCapstoneData` no longer has `capstoneConclusion`. Theorem `binary-L_B6-capstone` returns `HasRobustRationalizableStrategy model data.pd` directly.
- `FBNFPackage` no longer has `capstoneConclusion`. `FBNF-F4-capstone` returns the explicit type.
- `GraphFBNFPackage` no longer has `capstoneConclusion`. `G-addendum-P6_G-finite-graph-FBNF` returns the explicit type.
- `RegPackage` no longer has `calibratedKernelExists`/`robustRationalizableLabeling` AS FIELDS. Instead, they are now `def`s on `RegPackage` (concrete content via `RegCalibratedKernelExists`/`RegRobustRationalizableKernelExists`). Verify the unfolding is sound — these defs concretely express "there exists a kernel supported on G with posterior calibration q-a.e.".

## R3 — RegPackage σstar + concrete kernel content

`RegPackage` now carries:
- `σstar : AgentStrategyFull model` (the realizing private strategy)
- `σstar_realizes_wstar` (profile-of-private(σstar.sectionFull (inclM m)) = wstar m)
- `G_rowwise_minimizer` (concrete rowwise inequality)
- `B_bayes_optimal` (concrete Bayes-optimality on σstar continuation)

Verify these capture the v9 source's intended Reg-1/Reg-2 content. Is `σstar_realizes_wstar` actually used by the bridge lemma to discharge Definition2QAEPredicate? Check the bridge's proof structure.

## R4 — Hall biconditional now over robustRationalizableKernelExists

```lean
theorem «Hall-biconditional» (reg : RegPackage model) :
    reg.robustRationalizableKernelExists ↔ PsiNonpos model reg
```

This is non-vacuous: `robustRationalizableKernelExists` unfolds to `∃ κ, KernelSupportedOnRegG ∧ ∀ᵐ m, Pγα κ m ∈ B m`. PsiNonpos is the bounded Borel dual quantifier. Both sides are genuinely mathematical. Confirm.

## R5 — Bridge lemma `robustRationalizableKernelExists_to_strategy`

Takes `reg.robustRationalizableKernelExists` (a concrete kernel-existence Prop), refines via `⟨κ, reg.σstar, ?_⟩`, then needs `Definition2QAEPredicate model reg.pd κ reg.σstar`. Audit:
- Does `KernelSupportedOnRegG model reg.G κ` + `reg.G_rowwise_minimizer` imply the `IsAdversarialFull model κ reg.σstar` part of `Definition2QAEPredicate`? Probably yes (rowwise minimizer ⟹ Bayes-optimal in the adversarial direction at each source).
- Does the q-a.e. posterior-in-Bayes-cone condition + `reg.B_bayes_optimal` discharge the `∀ᵐ m, IsBayesOptimal model (σ.sectionFull (model.inclM m)) (pd.Pβ β m)` part?

The bridge proof body is currently `sorry`, but the structural setup (`refine ⟨κ, reg.σstar, ?_⟩`) should align with the v8 `Definition2QAEPredicate` form. Verify the alignment is correct; if not, point out the mismatch.

## R6 — FBNF corollaries as instantiation lemmas

The three corollaries now take a primitive class (e.g. `SphericalRadialFBNFPrimitive`) and conclude `∃ pkg : FBNFPackage, HasRobustRationalizableStrategy model pkg.pd`. The proof body:
```lean
let pkg : FBNFPackage model := { ... fields from prim ... }
refine ⟨pkg, ?_⟩
sorry
```
The sorry is needed because applying `«FBNF-F4-capstone» pkg ...` requires proving `pkg.conditionalB1Pasting` etc. — but only `True` was set for those, leaving the genuine `endpointSupportedFiberImage`, `globalFiberDominance` etc. unsourced.

Is this a real gap, or is it acceptable because each `pkg.X` is definitionally equal to `prim.X_from_*` which the primitive class assumes? Or do the primitive classes need to add proof obligations for `conditionalB1Pasting` and `localizedStationarityFBNF6`?

The refinement document's "follow-up open question" says: "P4Hyp alone is not enough to derive a complete FBNF package without additional bridge fields such as foliationFromRadialDiameters and globalFiberDominance_from_radialSymmetry." Adjudicate: do the primitive classes carry ENOUGH bridge fields, or is the sorry hiding a real gap?

## R7 — WTA threshold normalization

Final check: in v9_appendix.lean the theorem statement is:
```lean
((-2 * α * D + (1 - α) * ((4 : ℝ) / 9) ≤ 0) ↔ ((2 * (1 - α)) / (9 * α) ≤ D))
```
proved via `rw [div_le_iff₀] ; constructor ; nlinarith ; nlinarith`. The source memos (`v9_executive_summary.md`, `v9_consolidated.md`) have been corrected to match. Confirm everything is consistent now.

## R8 — Anything missed

Adversarial: scan for any new structural issues introduced by the refinement that weren't in the original decomposition. In particular:
- Did the refinement leave any abstract Prop fields in places where the source proofs require concrete content?
- Is the `Foliation` structure missing a concrete field that should be there (e.g. Borel chart instead of `chartMeasurable : Prop`)?
- The primitive classes (`SphericalRadialFBNFPrimitive`, `AffineMLRSingleCrossingPrimitive`, `PolyhedralScalarizablePrimitive`) carry many `_from_*` Prop fields that are essentially "assume what you need" placeholders. Acceptable for skeleton, or another trapdoor?

# Output format

```
REFINEMENT REVIEW — VERDICT: PASS / PATCH_LIST / RESTART

For each R1–R8:
  Verdict: OK / PATCH / FLAG
  If PATCH or FLAG: precise patch (Lean replacement, or specific question to escalate)

OVERALL
  - Is the refined v9_appendix.lean mergeable, or are more structural patches needed?
  - Confidence: HIGH / MEDIUM / LOW
  - One-paragraph summary
```

Adversarial. Cite line numbers in v9_appendix.lean. Use as much reasoning time as needed.
