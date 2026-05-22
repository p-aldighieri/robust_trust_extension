ROLE — Lean 4 / Mathlib formalization architect. Apply the deferred load-bearing structural patches to the v9 decomposition. Sources in this project: `decomposition.md` (the v9 ledger, with low-risk patches already applied), `v9_consolidated.md`, `exposition_v9.tex`, `exposition_v9_paper.tex`, `v8_main.lean`, plus `decomposition_review_response.md` and `source_proof.md`. The deferred item is **reviewer item N** verbatim:

# Three structural patches needed

## Patch 1 — Replace abstract Inventory hypothesis structures with concrete mathematical statements

Currently in `lean/v9_appendix.lean` (and `decomposition.md` §1), the following structures carry **arbitrary `Prop` fields** that make the corresponding Inventory axioms theorem-trapdoors (the axiom proves `A ↔ B` where `A, B` are unconstrained Props):

- `Inventory.ClarkeDanskinHyp` — fields `locallyLipschitz : Prop`, `compactActiveSet : Prop`, `danskinRepresentation : Prop`.
- `Inventory.StrassenMarginalDominance` — field `dualInequality : Prop`.
- `Inventory.ConicFarkasInstance` — fields `primalFeasible : Prop`, `dualNonpositive : Prop`.
- `Inventory.BergeMaximumHyp` — *removed* per item H (use Mathlib's `IsCompact.exists_isMaxOn` etc.).

Replace each with a structure whose fields are **specific mathematical statements** (using Mathlib types: `LipschitzOnWith`, `IsCompact`, `Measure`, `IsCoupling`, etc.).

For each, produce:
- Replacement `structure` definition with named, concrete Prop fields.
- Replacement `axiom` statement that consumes the structure and concludes the actual mathematical content (a kernel, a coupling, a stationarity witness).
- Citation: precise reference (Clarke 1990 §2.7, Strassen 1965, Farkas standard form).
- One-line justification why Mathlib doesn't already prove it (for the audit).

For example, instead of:
```lean
structure StrassenMarginalDominance ... where
  dualInequality : Prop

axiom strassen_marginals ... (_h : StrassenMarginalDominance μ ν R) :
  ∃ π, ...
```

write:
```lean
/-- The dominance hypothesis of Strassen 1965: for every Borel `f` bounded
between two functions matching the marginal-cost duality, ∫f dμ ≤ ∫f dν,
restricted to the support relation `R`. -/
structure StrassenMarginalDominance
    {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    (μ : Measure α) (ν : Measure β) (R : Set (α × β)) : Prop where
  measurable_R : MeasurableSet R
  dual_marginal_inequality :
    ∀ f g : α → ℝ, Measurable f → Measurable g →
      (∀ a b, (a, b) ∈ R → f a ≤ g b) →
      ∫ a, f a ∂μ ≤ ∫ b, g b ∂ν

axiom strassen_marginals ... (h : StrassenMarginalDominance μ ν R) :
  ∃ π : Measure (α × β), ...
```

Do this for all 3 remaining hypothesis structures + their axioms.

## Patch 2 — Remove conclusion-as-field structures

Currently `FBNFPackage`, `BinaryCapstoneData`, `GraphFBNFPackage`, `RegPackage` carry conclusion-statement fields:
- `FBNFPackage.capstoneConclusion : HasRobustRationalizableStrategy model pd`
- `BinaryCapstoneData.capstoneConclusion : HasRobustRationalizableStrategy model pd`
- `GraphFBNFPackage.capstoneConclusion : HasRobustRationalizableStrategy model pd`
- `RegPackage.calibratedKernelExists : Prop`
- `RegPackage.robustRationalizableLabeling : Prop`

These cause the theorem statements to be effectively vacuous (the conclusion is built into the hypothesis). Per reviewer item N, remove these fields and rewrite the theorem conclusions to state the target directly.

For each, give:
- Updated structure with the conclusion field removed (or replaced by genuine primitive hypotheses).
- For `RegPackage.robustRationalizableLabeling`: expand it into the actual mathematical content — "there exists a Borel kernel `κ` supported on `G(s)` such that the posterior of `γ_α := α(id,id)#τ + (1-α)τ⊗κ` lies in `B(m)` for `q_α-a.e. m`" — and either rename to `RegPackage.robustRationalizableKernelExists` or replace with the corresponding concrete predicate.
- For `calibratedKernelExists`: same — expand into concrete kernel-existence Prop.
- Patches to all 28 theorem statements that reference these fields (most rewrites are mechanical replacements of `... := pkg.capstoneConclusion` with `HasRobustRationalizableStrategy model pkg.pd`).

## Patch 3 — Rewrite vacuous FBNF corollaries

The three FBNF corollaries are currently no-ops:
```lean
theorem «FBNF-corollary-spherical-radial» ... (hF4 : HasRobustRationalizableStrategy model pkg.pd) :
    HasRobustRationalizableStrategy model pkg.pd := hF4
```
This proves nothing. Per reviewer item N, rewrite each as an **actual instantiation lemma** from primitive class data to FBNF capstone hypotheses, e.g.:

```lean
theorem «FBNF-corollary-spherical-radial»
    {model : RobustTrustModel}
    (radial : P4Hyp model)
    (foliationFromRadial : ... -- derive Foliation from P4Hyp)
    ... :
    ∃ pkg : FBNFPackage model,
      HasRobustRationalizableStrategy model pkg.pd
```

The corollary's content is: under radial / antipodal τ-symmetry primitive, the FBNF foliation comes from radial diameters; verify FBNF-1..5,7 hold; apply FBNF-F4-capstone.

Do this for:
- `FBNF-corollary-spherical-radial` (from `P4Hyp`).
- `FBNF-corollary-affine-MLR-single-crossing` (from an affine-MLR / single-crossing primitive class — define it).
- `FBNF-corollary-polyhedral-scalarizable` (from polyhedral W + scalarizable Bayes faces primitive).

# Output format

A single markdown document with three sections (Patch 1, 2, 3) each containing the replacement Lean source (in `lean` fenced blocks), citations, and brief math justification. The output will be merged into `lean/v9_appendix.lean` after a reviewer round.

Be exhaustive. Use concrete Mathlib types where they exist; fall back to named Prop statements only when no Mathlib lemma can express the content. Do not introduce new `Inventory` axioms beyond the 5 currently kept.

Constraint: the resulting v9_appendix.lean must still build clean (Mathlib v4.30.0-rc1) with all theorems as `sorry` stubs. Do not introduce circular definitions or non-terminating elaboration patterns.

Use as much reasoning time as needed. Adversarial: if any patch creates a new gap (e.g., a primitive class lacks enough structure to derive FBNF hypotheses), flag it as a follow-up open question rather than glossing over it.
