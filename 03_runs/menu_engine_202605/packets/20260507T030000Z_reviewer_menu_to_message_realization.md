# Reviewer pass — Menu-to-message realization (closure-pruning + exact-contact)

You are the Reviewer. The prover addressed the gap from the v6
consolidator review. Result: closure-pruning gives a clean **value
preservation lemma** and **ε-adversary realization** unconditionally,
but **exact** message-level adversary attainment requires an
additional **exact-contact condition**

$$
G(s) := \arg\min_{m\in M}\,s\cdot w^*(m) \neq \emptyset \quad \text{for $\tau$-a.e. } s.
$$

Full prover response:
`logs/20260507T023000Z_prover_menu_to_message_realization_response.md`.

## Items to audit

1. **Closure-pruning value lemma.** $C^\dagger := \overline{w^*(M)}$,
   $F(C^\dagger) = F(C^*) = U^*$. Verify the inequality direction
   on the misaligned term: $\min_{C^\dagger}\,s\cdot w \ge \min_{C^*}\,s\cdot w$
   (smaller set ⇒ larger min ⇒ bigger misaligned term ⇒ bigger F),
   so $F(C^\dagger) \ge F(C^*)$; combined with $F(C^\dagger) \le F(C^*)$
   from $C^*$ being a maximizer, equality.
2. **The exact-contact condition.** $G(s) := \{m \in M : s\cdot w^*(m) = \min_{z\in C^\dagger}\,s\cdot z\}$.
   Verify this is the right condition: under it, KRN gives $m^*(s)\in G(s)$
   measurable, and $\beta^* = \delta_{m^*(s)}$ attains exactly. Without
   it, only ε-attainment is available.
3. **Connection to A8c-attain.** The prover's exact-contact condition
   is essentially a menu-language version of A8c-attain. Verify
   this. Important: it's now **endogenous to the labeling**, not
   ad-hoc.
4. **The new three-tier structure.**
   - Tier 1a (value + ε-adversary): standing alone.
   - Tier 1b (exact β*): standing + exact-contact.
   - Tier 2 (full RR): standing + exact-contact + menu-Hall.
   Verify this is the correct restructuring.
5. **Comparison with v5.** v5's A5-thick is GONE entirely. v5's
   A8c-attain is REPLACED by the cleaner menu-language exact-contact
   condition. v5's TRE-gen-Hall is REPLACED by menu-Hall.
6. **Pathological-case discussion.** The prover discussed dense-but-not-closed
   image cases. Verify the closure-pruning handles these correctly.
7. **Honest scope.** Don't claim more than what's proved.

## Output Format

```
\`\`\`review_control
verdict: PASS / PATCH_SMALL / PATCH_BIG / REDO
route_status: viable / blocked / dead
recommended_next_phase: PROVER / BREAKDOWN / SEARCHER / CONSOLIDATOR / STOP_STALL
proof_status: complete / partial / broken
\`\`\`

## Verdict
VERDICT: ...

## Opinion and Next Move
(One paragraph. If PASS, recommend updating v6 → v7 with the new
three-tier structure.)

## Detailed Review
(Per audit items 1–7.)
```

Length: 1000–1500 words.
