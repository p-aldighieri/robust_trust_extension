ROLE — Lean 4 / Mathlib prover, Phase 7 Batch B T2/AlphaZero scope correction. Opus.

# Mission

Phase 6 Batch B found SCOPE_DRIFT on T2 / AlphaZero theorems:
- AlphaZeroSingletonData_exists takes extra args (plc, msupp, prs) beyond v9 paper §B.2 standing hypotheses.
- T2-alpha-zero-singleton-prior-strategy similarly threads these v8 infrastructure primitives.

Audit: "Mathematically faithful to the α=0 construction, but not an exact paper-surface theorem unless the added infrastructure arguments are officially part of the Lean standing hypotheses and optimality is recovered by a named corollary."

# Fix options

## Option 1: Move plc/msupp/prs into v9 model standing hypotheses

If these v8 infrastructure pieces are needed by EVERY v9 theorem, they should be part of the model standing setup (similar to model.inclM_measurable etc.). Adding them at the model level eliminates the explicit-arg surface.

But — they're v8-specific (PosteriorLawConsistency, ProfileRealizationSetup, MessageSupportM). The v9 paper's §B.2 standing setup is more abstract.

## Option 2: Rename theorems / add a corollary chain

Keep the explicit args but add a corollary like:
```lean
theorem «T2-alpha-zero-singleton-prior-strategy-paper-surface»
    {model : RobustTrustModel}
    (hα : model.α = 0)
    (pd : PosteriorDisintegration model) :
    HasRobustRationalizableStrategy model pd := by
  -- Assume the v9 model has the standing v8 primitives bundled
  exact «T2-alpha-zero-singleton-prior-strategy» model hα pd 
        (default plc) (default msupp) (default prs)
```

This adds a paper-surface version while keeping the implementation theorem with explicit infrastructure.

## Option 3: Document and accept

Add docstring notes to T2 / AlphaZero theorems explaining that plc/msupp/prs are v9 ledger semantics (v8 primitives that v9 inherits but doesn't add to its paper surface). The Lean signature differs from the paper but matches the v9 ledger.

# Recommendation: Option 3 + light Option 2

Document the scope-drift explicitly. The plc/msupp/prs are v8 ledger semantics inherited by v9; they're not new hypotheses but inherited primitives. This is what the v9 paper §B.2 implicitly assumes (the v8 setup is the base).

Add a Documentation block + a one-line corollary that wraps the existing theorem with explicit "assuming v9 ledger semantics" comments.

# Implementation

```lean
/-- **T2 paper-surface corollary.** Wraps the T2 theorem with a docstring
acknowledging the v9 ledger inheritance of v8 standing primitives. -/
theorem «T2-alpha-zero-singleton-prior-strategy-v9-ledger»
    {model : RobustTrustModel}
    (hα : model.α = 0)
    (pd : PosteriorDisintegration model)
    -- v9 ledger inheritance from v8:
    (plc : PosteriorLawConsistency model)
    (msupp : MessageSupportM model)
    (prs : ProfileRealizationSetup model) :
    HasRobustRationalizableStrategy model pd :=
  «T2-alpha-zero-singleton-prior-strategy» (model := model) hα pd plc msupp prs
```

Or even better: enhance the docstrings of the existing T2 / AlphaZero theorems to explain the v9 ledger position.

# Constraints

- Build MUST PASS via `lake build MathlibStarter.V9Main` (exit 0).
- 9 axioms unchanged.
- NO new sorries unless genuinely needed.
- Edit only lean/v9_appendix.lean.
- Cap 4 iterations.

# Output

Concise report under 300 words: build status, sorry count, axiom count, T2/AlphaZero scope documentation added.
