ROLE — adversarial peer-reviewer for a Lean 4 / Mathlib formalization decomposition document. Source documents in the project (read them): `v9_consolidated.md` (master proof memo, 2019 lines), `exposition_v9.tex` (canonical statements), `exposition_v9_paper.tex` (long-form), `v9_executive_summary.md`, `source_proof.md` (the formalization brief), `lean_state.md` (scope), and `v8_main.lean` (v8 baseline namespace).

The document you are reviewing is the **prover's response** that I will paste below verbatim. Your job is to adversarially audit it for:
1. **Mathematical fidelity** — does it correctly capture each v9 theorem/lemma in §3–§10? Cross-check against the canonical statements in `exposition_v9.tex` and the detailed proofs in `v9_consolidated.md`.
2. **Lean formalization soundness** — are the type signatures, Inventory axioms, and reuse decisions correct? Are there Mathlib pieces wrongly axiomatized (e.g. Berge maximum, Hausdorff distance, hyperspace compactness) that should be derived from existing Mathlib instead?
3. **Specific risks the prover already flagged in §13** — verify the prover's own self-flagged issues and decide PATCH or NO-PATCH for each.

# Specific items to audit (be exhaustive)

## A. Numeric conflict: WTA reopening threshold

The prover's §13 flags this conflict. The Lean statement `Hall-WTA-reopening-threshold-D` is:
```lean
((-2 * α * D + (1 - α) * (4/9) ≤ 0) ↔ ((2 * (1 - α)) / (9 * α) ≤ D))
```
Cross-check the **direction of the threshold** in `v9_consolidated.md` and `exposition_v9.tex §11` (the WTA dual certificate paragraph). The v9_executive_summary states `D ≥ 9α / (2(1−α))`. The Lean ledger gives `D ≥ 2(1−α) / (9α)`. **Decide which is correct.** Show the algebra from
`−2αD + (1−α)·(4/9) ≤ 0`
to the threshold. State the verdict and the patch.

## B. Hall sign convention

Verify `Ψ(y) ≤ 0` (not ≥ 0). v9_consolidated says: "Robust rationalizability is equivalent to checking Ψ ≤ 0." The Lean ledger encodes `PsiNonpos`. Confirm or patch.

## C. Radon–Nikodym orientation

`v9_consolidated.md` flags an orientation typo for the posterior derivative. The decomposition routes through v8's `PosteriorDisintegration` instead of hardcoding dρ/dτ or dτ/dρ. Confirm this is the right abstraction; flag any Lean statement that still hardcodes the wrong direction.

## D. Reg-1 / Reg-2 not derived from standing

The decomposition's `RegPackage` structure is correct: closed-graph correspondence + continuous support function are *added* hypotheses, not derivable from compact M. Confirm no theorem statement assumes RegPackage automatically follows from standing.

## E. FBNF endpoint-fiber support, not singleton endpoints

The literal misaligned kernel spreads over endpoint fibers; only the projected payoff image is endpoint-only. Audit `FBNF-F2-endpoint-only-fiber-image`, `FBNF-F4-capstone`, `binary-L_B3-endpoint-only-image`. Any statement saying "adversary sends only singleton endpoint messages" is WRONG.

## F. FBNF-6 needs two-sided perturbability (else KKT inequality)

`FBNF-F3-localized-stationarity-FBNF6` requires `localTwoSidedPerturbability` as a hypothesis (not derivable). Confirm this hypothesis is explicit in the FBNF package; the proof outline notes that without it the conclusion is one-sided KKT, not equality.

## G. P2.* density orientation

`G-addendum-variable-margin-P2-star-prime` proof outline says "adversarial target density controlled relative to truthful mass (dρ/dτ-style cap)." Confirm this is the correct direction. The Lean note at the end of that section warns about reversed dτ/dρ.

## H. Berge maximum — Mathlib audit

The decomposition declares `Inventory.berge_maximum_set_valued` BUT marks it for audit. Decide: can Mathlib's existing compactness/continuity lemmas (e.g. `IsCompact.exists_isMaxOn`, `ContinuousOn.exists_forall_le`, `MeasureTheory.measurable_argmax_selector` variants) discharge Berge for the specific uses in the decomposition? If yes, REMOVE the axiom and use Mathlib. If no, KEEP and justify.

## I. WP compactness

The Lean `WP : Set (Profile model)` is the weak Pareto frontier. The decomposition treats it as a Set (not a CompactConvex). Verify the formalization can prove `IsCompact (WP model)` from `IsCompact (PayoffProfileSet model)` + closedness of the no-strict-domination relation. If this is not standard, flag it as a sub-lemma to add.

## J. Hyperspace `KCompactWP = NonemptyCompacts (WPProfile model)`

The decomposition uses `TopologicalSpace.NonemptyCompacts`. Confirm this exists in Mathlib v4.30-rc1 with the Hausdorff metric structure needed for the Pareto-frontier game G_P. Cite the exact Mathlib module.

## K. Bounded Borel profiles

The decomposition introduces `BoundedBorelProfile` (not `BoundedContinuousFunction`). Confirm this is the right encoding for the Hall dual quantification. The v9 Hall theorem quantifies over **bounded Borel** y, not just bounded continuous y. The decomposition gets this right; double-check it survives in §7's `Hall-biconditional` statement.

## L. Escaped declaration names

The decomposition uses `«binary-L_B5-...»` for kebab-case Lean identifiers. Confirm this is the right Lean 4 syntax; `lake build` will need to compile these.

## M. Hand-off integrity

Check that the proving-order DAG in §11 actually respects dependencies declared in §3–§10 (e.g. binary-L_B5 depends on T1-clarke-danskin-multiplier-bayes-cone, which means T1 must come before binary-L_B5; the §11 order obeys this).

## N. Anything the prover missed

Adversarial — flag any v9 theorem in `exposition_v9.tex` or `v9_consolidated.md` that is **not** decomposed in the document but should be.

# Output format

```
DECOMPOSITION REVIEW — VERDICT: PATCH_LIST / NO_PATCH / RESTART

For each item A–N:
  Verdict: OK / PATCH / FLAG
  If PATCH or FLAG: precise patch (replacement statement, replacement axiom, etc.)

OVERALL
  - Is the decomposition mergeable to lean/decomposition.md (with patches if any)?
  - Are there any structural problems that would force a re-decomposition?
  - One-paragraph summary of confidence.
```

Be terse. Be specific. Cite line numbers / section anchors. Use as much reasoning time as needed; do not hedge.

# The decomposition to review

The document to review is now a project source: **`decomposition.md`** (1880 lines). Read it as your primary input alongside `v9_consolidated.md` and `exposition_v9.tex`.

Output the verdict block specified above. Do not paraphrase the decomposition; quote it where you flag a patch.
