# Final reviewer pass — `theorem_2_extension_proof_v7.md`

You are the Reviewer. Audit the v7 consolidator integrating all Phase
C results (closure-pruning + exact-contact + menu-Hall) into the new
**three-tier theorem**.

## Context

v7 supersedes v5 (Phil-Reny route under A5-thick + A8c-attain +
TRE-gen-Hall) and v6 (overclaimed unconditional menu engine). v7's
three-tier structure separates:
- **Tier 1a**: standing alone ⇒ value optimality + ε-adversaries.
- **Tier 1b**: + (exact-contact) ⇒ exact β*.
- **Tier 2**: + (menu-Hall) ⇒ full robust rationalizability.

All three component lemmas (menu-value equivalence, menu existence,
closure-pruning, exact-contact selection, ε-adversary) have been
reviewer-PASS'd or PATCH_SMALL-cleared in earlier passes.

## Items to audit

1. **Tier 1a unconditional claim.** Verify the document claims only
   value optimality + ε-adversaries under standing — NOT exact β*.
   This is the v6 overreach that was caught.
2. **Profile-realization sub-lemma** treatment. Cited as standard;
   sketch given. Verify acceptable.
3. **Closure-pruning lemma.** $C^\dagger = \overline{w^*(M)}$,
   value preservation. Verify.
4. **Exact-contact assumption.** Endogenous to the labeling $w^*$;
   sufficient routes (closed image, closed-graph correspondence,
   u.h.c. Bayes-action) listed.
5. **Menu-Hall assumption.** Set-valued kernel $\kappa$ supported on
   $G(s)$, posterior calibration $P_{\gamma_\alpha}(\cdot\mid m)\in B(m)$
   q-a.e. Verify support-function form is correctly stated.
6. **Sharpness witness.** Ternary non-radial Hall-violation; pointwise
   $s_1 - s_0\ge 0$ on $K_0^-$ ⇒ barycenter equality forces
   $\bar s = (1/3,1/3,1/3)$ a.s. ⇒ atomless τ ⇒ no positive mass.
   Verify the argument is reproduced cleanly.
7. **Comparison table.** v5 vs v7. Tier 1 hypotheses go from
   {standing + A5-thick + A8c-attain} to {standing alone}.
8. **No drift.** Tier 1a, Tier 1b, Tier 2 properly distinguished;
   no hidden hypothesis smuggled.

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
(One paragraph. If PASS, recommend stopping the loop, committing v7,
and updating exposition.tex.)

## Detailed Review
(Per audit items 1–8.)
```

Length: 1500–2000 words.
