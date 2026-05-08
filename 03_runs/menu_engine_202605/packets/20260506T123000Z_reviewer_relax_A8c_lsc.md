# Reviewer pass — (A8c-lsc) relaxation to (A8c-attain)

You are the Reviewer in the soft-scaffolding workflow.

## What you are reviewing

A prover output relaxing **(A8c-lsc)** to the strictly weaker
**(A8c-attain)** — "for τ-a.e. $s$, $D(s)$ nonempty + Borel selector
exists" — the property L8 actually invokes via Kuratowski–Ryll-Nardzewski.
Plus three primitive sufficient conditions (P1)–(P3). Full prover
response in `logs/20260506T120000Z_prover_relax_A8c_lsc_response.md`.

## Inputs

- `theorem_2_extension_proof.md`, `phil_reny_route_memo.md`,
  `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF.

## Items to audit

1. **(A8c-attain) suffices for L8.** L8's KRN argument needs only
   nonempty + closed-valued + measurable correspondence. (A8c-attain)
   delivers exactly that. Verify the L8 proof closes under (A8c-attain)
   without other changes.
2. **(A8c-lsc) ⇒ (A8c-attain).** L.s.c. on compact $M$ ⇒ attainment
   of pointwise inf, hence $D(s)$ nonempty closed; measurable maximum
   theorem ⇒ measurable selector. Verify.
3. **(A8c-attain) does NOT imply (A8c-lsc).** The prover should give a
   model-realizable example where argmin is attained but $\ell$ fails
   l.s.c. at some other point. Audit the prover's corrected
   counterexample (upward spike away from minimizer).
4. **(P1) ⇒ (A8c-attain).** U.h.c. Bayes-action correspondence with
   compact closed values. The prover should derive: closed-graph
   strategy + measurable maximum ⇒ measurable selector for $D(s)$.
   Verify hemicontinuity directions are correct (u.h.c. of correspondence
   does NOT directly give l.s.c. of integrand).
5. **(P2) ⇒ (A8c-attain).** Continuous trust-region projection
   $P:\Delta(\Omega)\to T$ + Bayes-action at $P(m)$. This gives
   continuity of $\hat\sigma^*$ in $m$, hence $\ell$ continuous, hence
   trivially attained. Verify.
6. **(P3) ⇒ (A8c-attain).** Closed-graph strategy representative.
   Aliprantis–Border 18.19 (measurable maximum) gives the selector.
   Verify.
7. **Honest framing.** The relaxed Tier 1 theorem now reads "Branch B
   closes under standing + (A5) + (A8c-attain)", with (A8c-attain)
   forced by any of (P1), (P2), (P3) — primitive economic conditions.
   Verify the framing doesn't overstate or understate.
8. **Scope discipline.** Did the prover stop at (A8c-lsc) relaxation?
   No drift into (A5) or (A9c-calib)? No dead-route machinery?

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
Reason: ...

## Opinion and Next Move

(One paragraph. If PASS, recommend the (A5) relaxation cycle next.)

## Detailed Review

(Per audit items 1–8.)
```

Length budget: 1000–1800 words.
