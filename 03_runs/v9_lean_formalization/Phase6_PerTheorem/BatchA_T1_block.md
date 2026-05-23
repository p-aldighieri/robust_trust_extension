ROLE — Lean ↔ v9 paper per-theorem verification auditor. Extended Pro (gpt-5.5-pro-xhigh).

# Context

v9 formalization in `v9_appendix.lean` is at zero sorries with 9 paper-cited Inventory.V9 axioms. User wants every theorem audited for: (a) proper Lean ↔ English translation, (b) no smuggling/trapdoors, (c) scope/generality — Lean statement adds no extra assumptions beyond English.

The v9 paper sources are in project context: `v9_consolidated.md`, `exposition_v9.tex`, `exposition_v9_paper.tex` (especially §B.1 for T1 block).

# Batch A — T1 block (4 theorems + supporting lemmas)

Audit these:

1. **`«T1-L6-integral-clarke-danskin-representation»`** (v9_appendix.lean ~L2237)
2. **`«T1-L7-clarke-fermat-stationarity»`** (~L2270)
3. **`«T1-L8-multipliers-are-calibration-kernel»`** (~L2302)
4. **`«T1-clarke-danskin-multiplier-bayes-cone»`** (~L2336, this is the headline T1)

Supporting lemmas to audit briefly:
- `g_nonneg`, `q_nonneg`, `mass_balance`, `normal_cone_inequality` (~L901-921)
- `gOf_nonneg`, `qOf_nonneg`, `mass_balance_gOf_qOf` (~L319-360)
- `FiniteMenuData.fromParetoMenu` constructor

# Audit task per theorem

For EACH of the 4 headline theorems:

1. **Quote the Lean signature + proof body** from v9_appendix.lean.

2. **Quote the v9 paper English statement + proof** from v9_consolidated.md §B.1 / exposition_v9_paper.tex §3 (Clarke–Danskin section).

3. **Translation check** — does the Lean statement faithfully capture the English claim? Note any:
   - Extra hypotheses in Lean not in English (SCOPE_NARROWED).
   - Weakened hypotheses in Lean (SCOPE_WEAKENED).
   - Different conclusion shape (CONCLUSION_DIFFERS).
   - Extra side conditions hidden in primitives (HIDDEN_ASSUMPTIONS).

4. **Smuggling check** — does the Lean proof body honestly derive the conclusion, or does it project from a data-witness field / arbitrary Prop / invariant axiom shape?

5. **Verdict per theorem**: PASS / SCOPE_DRIFT / SMUGGLING_FLAG / CRITICAL.

# Output format

```
## T1-L6
Lean: <quoted signature + first lines of proof>
English (v9_consolidated.md §X.Y): <quoted statement + proof sketch>
Translation: <PASS / drift category>
Smuggling: <PASS / flag>
Verdict: <PASS / SCOPE_DRIFT / SMUGGLING_FLAG>
Notes: <details>

## T1-L7
...
```

End with overall batch verdict: PASS / NEEDS_FIX. Cite v9_appendix.lean line numbers.
