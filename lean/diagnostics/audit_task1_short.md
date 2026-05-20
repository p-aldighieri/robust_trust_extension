AUDIT REQUEST — skeptical, adversarial.

Attached: `main.lean` — a Lean 4 / Mathlib 4.29 formalization of an extension of Theorem 2 in Dworczak–Smolin "Robust Trust".

The file has exactly 3 `sorry`s, all inside a top-level `namespace Inventory` block at the top (the three theorems are `measurable_argmax_selector`, `krn_borel_right_inverse`, `kernel_infimum_epsilon_selection`). The rest of the file is the `namespace RobustTrustV8` proof and is sorry-free + axiom-free as far as I know.

Two independent assessments, please:

## Part A — Audit `namespace RobustTrustV8` (everything BELOW the Inventory block)

1. Any `axiom` declarations? (Should be zero.)
2. Any hypothesis smuggling? (Free hypotheses sneaked into proof bodies, `haveI : SomeClass := sorry`, conjured typeclass instances, terminal `cases` that hide cases, vacuous-field structures, etc.)
3. Any trickery? (Definitions secretly containing the conclusion; `by exact?`-style appeals hiding non-trivial deps; theorems whose conclusion is definitionally `True`; `convert` chains changing the goal; etc.)
4. Confirm Tier 2 hypotheses (EXACT-CONTACT + MENU-HALL) are *bound assumptions* to the Tier-2 theorem statement, not blanket axioms/globals.
5. Confirm atomlessness of τ is scoped to the **sharpness package only** (used by `wta_no_free_dust`-style statements), NEVER inherited by Tier 1a / 1b / 2.

Verdict: PASS or list concerns with line numbers.

## Part B — Audit `namespace Inventory` (the 3 remaining sorry'd stubs)

For each of:
- `Inventory.measurable_argmax_selector`
- `Inventory.krn_borel_right_inverse`
- `Inventory.kernel_infimum_epsilon_selection`

classify as **LEGIT-EXTERNAL** (legitimate Mathlib-style external invocation; well-known result a measure-theory library should supply) / **HIDDEN-WORK** (sneaks in substantive proof content that should have been done as part of v8) / **BORDERLINE**, with a one-paragraph justification.

If LEGIT-EXTERNAL: cite the closest Mathlib lemma name (if known) or textbook reference (e.g. "Kuratowski-Ryll-Nardzewski 1965", "Bertsekas-Shreve Prop 7.50", "Castaing-Valadier 1977 III.22").

If HIDDEN-WORK: identify which part of the v8 proof is being sneaked in via the stub.

## Output

```
PART A — namespace RobustTrustV8
  verdict: PASS | FAIL
  findings: ...

PART B — namespace Inventory
  measurable_argmax_selector: LEGIT-EXTERNAL | HIDDEN-WORK | BORDERLINE
    justification: ...
  krn_borel_right_inverse: ...
  kernel_infimum_epsilon_selection: ...
```
