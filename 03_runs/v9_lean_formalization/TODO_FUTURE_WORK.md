# v9 Lean formalization — future-work TODO

## Retry: derive Reg-2 primitives from more elementary structural hypotheses

**Date noted**: 2026-05-22 (Phase 3 final audit + user followup)

### The issue

`RegPackage` currently carries two Reg-2 primitives that the Phase 3 smuggling auditor flagged as "TOO STRONG":

```lean
message_in_bayes_cone : ∀ m : model.M, model.inclM m ∈ B m
source_in_rowwise_bayes_cone : ∀ s m', m' ∈ G s → model.inclM s ∈ B m'
```

The forward direction of `«Hall-biconditional»` (i.e., the `PsiNonpos_of_regPackage` lemma) is essentially trivial given these primitives:

- For the aligned-message integrand, `m ∈ B(m)` + support-function inequality gives `m · y(m) ≤ h_{B(m)}(y(m))` pointwise.
- For the rowwise-minimizer integrand, `s ∈ B(m')` for any `m' ∈ G(s)` gives the analogous bound.

The user's policy concern (2026-05-22): every theorem should be a genuine derivation, not a structural primitive that bundles the conclusion. The audit's "SMUGGLED" verdict for the `regBridge` pattern on capstone packages is rooted in these two RegPackage fields being too strong.

### Why we kept them (current session resolution)

The v9 paper's standing Reg-1/Reg-2 hypothesis EXPLICITLY includes the message-in-Bayes-cone consistency:

> v9_consolidated.md §B.7 P2*: "truthful messages sit uniformly inside their Bayes cones: there is η > 0 such that `dist(m, Δ(Ω)∖B(m)) ≥ η τ-a.e.`"

This is one of the v9 paper's Reg-2 components, not a smuggled conclusion. The Lean encoding faithfully represents it. The forward direction of Hall is supposed to be trivial under this hypothesis; the substantive work is the reverse direction (Strassen + measurable selection).

So the current Reg-2 primitives ARE faithful to the v9 paper. They're not "smuggling" in the v9 paper's logic.

### Why this future-work note matters

Even though the primitives faithfully represent v9 Reg-2, they're coarse:

1. **`message_in_bayes_cone`** could be derived from a more primitive setup:
   - B(m) is constructed as the Bayes cone at belief m.
   - If B(m) is defined via `B(m) := {μ : μ is consistent with m's prior}` or a similar construction, then `inclM m ∈ B m` follows from the construction itself.
   - A cleaner v9 design would EXPOSE this construction in Lean and derive the consistency, rather than assuming it as a primitive.

2. **`source_in_rowwise_bayes_cone`** is even more substantive:
   - It says rowwise minimizers `m' ∈ G(s)` carry the source's prior `inclM s` into `B(m')`.
   - This is the v9 §B.5 Reg-2 "rowwise-minimizer compatibility" condition.
   - In the v9 paper, this is part of the regularity package — but could potentially be derived from Reg-1 (closed-graph G) + Reg-2 (compact + continuous support function B) + a measurable-selection argument.

3. **`exactContact : ExactContact model σstar`** field on RegPackage — bundles v8's menu-engine structure. This is structural data, but it should ideally come from constructing OptimalMenuCstar / AlignedBestLabelingWstar / PrunedMenuCdagger / selector from reg's geometric primitives, not bundled as input.

### Retry plan for future work

When session budget allows:

1. **Refactor RegPackage** to remove `message_in_bayes_cone`, `source_in_rowwise_bayes_cone`, and `exactContact` as direct primitive fields.
2. **Add genuinely primitive structural fields**: e.g., the Bayes-cone-defining map `bayesConeFromPrior : Profile model → Set (Belief model.Ω)` with documented closedness/convexity/support-continuity per Reg-2; the closed-graph G correspondence per Reg-1.
3. **Derive `message_in_bayes_cone`** as a lemma from the Bayes-cone construction.
4. **Derive `source_in_rowwise_bayes_cone`** as a lemma from Reg-1 closed-graph + measurable selection on G + Bayes cone construction.
5. **Build `exactContact` as a `def`** from the refactored RegPackage using `Inventory.measurable_argmax_selector`.

This makes the Hall biconditional's forward direction a NON-TRIVIAL derivation from genuinely primitive hypotheses, and the v9 paper's Reg-2 becomes a set of derived properties rather than primitive fields. Then the `regBridge` pattern on capstone packages would no longer be "smuggling" because the upstream RegPackage no longer carries conclusion-shaped fields.

This is a multi-session refactor — likely requires:
- Reading v9 §B.5 / §B.7 carefully to identify the minimal Reg-2 primitive set.
- Building the Bayes-cone construction in Lean.
- Reorganizing the §7-§9 of v9_appendix.lean.
- Re-deriving all P-class theorems with the new RegPackage shape.

Expected payoff: clean smuggling-check audit at the end (no `SMUGGLED` findings on the capstone `regBridge` pattern).

### Status

Noted 2026-05-22 (Phase 4 in progress). Current focus is fixing the 5% genuine smuggling (B5 scalar fields + 3 borderline axiom shape cleanups), not the Reg-2 primitive refactor. This note is for the next session.

### Related files

- `lean/v9_appendix.lean` — `RegPackage` declaration (~L1280 area).
- `03_runs/v9_lean_formalization/Consolidation/Phase3_final_audit_response.md` — the audit that flagged Reg-2 as too strong.
- `01_deliverables/closure/v9_consolidated.md` §B.5 / §B.7 — v9 paper's Reg-2 statement.
