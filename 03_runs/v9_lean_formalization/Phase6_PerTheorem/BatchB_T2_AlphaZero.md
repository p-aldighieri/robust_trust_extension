ROLE — Lean ↔ v9 paper per-theorem verification auditor. Extended Pro (gpt-5.5-pro-xhigh).

# Context

v9 formalization in `v9_appendix.lean` at zero sorries, 9 paper-cited axioms. Verify per-theorem translation/smuggling/scope vs v9 paper.

# Batch B — T2 / AlphaZero block (3 theorems)

Audit these:

1. **`AlphaZeroSingletonData_exists`** (v9_appendix.lean ~L2508)
2. **`AlphaZeroSingletonData.to_hasRobustRationalizableStrategy`** (~L2442)
3. **`«T2-alpha-zero-singleton-prior-strategy»`** (~L2777)

The v9 paper §B.2 / exposition_v9.tex §4 covers the α=0 unconditional infinite-extension theorem.

# Audit per theorem

1. Quote Lean signature + proof body.
2. Quote v9 paper English statement + proof (look up in v9_consolidated.md §B.2 / exposition_v9_paper.tex §4).
3. Translation: PASS / SCOPE_NARROWED / SCOPE_WEAKENED / CONCLUSION_DIFFERS / HIDDEN_ASSUMPTIONS.
4. Smuggling: does the proof body derive honestly?
5. Verdict per theorem: PASS / SCOPE_DRIFT / SMUGGLING_FLAG / CRITICAL.

Note: The v9 paper's T2 is the "α=0 unconditional" case — the agent simply ignores the adviser and plays Bayes-optimal at the prior. The Lean proof should reflect this construction.

# Output format

Per theorem block as in Batch A. End with batch verdict: PASS / NEEDS_FIX.
