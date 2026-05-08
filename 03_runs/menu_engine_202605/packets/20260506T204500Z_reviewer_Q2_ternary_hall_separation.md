# Reviewer pass — Q2 ternary Hall separation (CLOSED-NEGATIVE)

You are the Reviewer in the soft-scaffolding workflow.

## What you are reviewing

A prover output for **Q2 ternary Hall-feasibility separation** with
verdict **CLOSED-NEGATIVE**: a concrete ternary non-radial RT-style
model exhibits a Hall-inequality **violation**, proving (TRE-gen-Hall)
is essential — i.e., it cannot be derived from standing + (A5-thick) +
(A8c-attain) + bare non-radial TRE-gen geometry alone.

The concrete violation: $E = \{t_0\}$ (a singleton boundary point of
$T$), $\phi(\mu) = \mu_1 - \mu_0$, Hall gap $= (1-\alpha)/9 > 0$ on
the LHS, $0$ on the RHS.

The prover honestly notes one scope caveat: the separation does NOT
prove the displayed $\sigma^*$ is the Branch-A value-securing optimizer
for these primitives — only that the geometry can fail Hall while the
weaker hypotheses all hold.

Full prover response:
`logs/20260506T200000Z_prover_Q2_ternary_hall_separation_response.md`.

## Inputs

- `theorem_2_extension_proof_v4.md`, `phil_reny_route_memo.md`,
  `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF.
- Q2 formalizer + literature logs.

## Items to audit

1. **Concrete model setup.** $\Omega = \{0,1,2\}$, full-support $\mu_0$,
   atomless $\tau$, discrete $A = \{a_0,a_1,a_2\}$ (or continuous), TR
   non-radial, posterior cone $C(m)$ a half-space (or its appropriate
   analog). Verify the model is RT-compliant.
2. **Computations of $\sigma^*$, $\ell$, $D(s)$, $m^*(s)$, $C(m)$.**
   Verify each is correctly derived from the primitives.
3. **Concrete Hall violation.** $E = \{t_0\}$ with $\phi(\mu) = \mu_1 - \mu_0$
   gives Hall LHS $= (1-\alpha)/9 > 0$ vs RHS $= 0$. Verify the
   arithmetic and the interpretation.
4. **Multi-dimensional obstruction.** The prover argues binary
   collapses to a single scalar mass-balance (paper Appendix A.6) but
   ternary has a 2-d barycenter that cannot align with a single Bayes
   cone. Verify this is a structural argument.
5. **Honest scope note.** The prover correctly flags that $\sigma^*$
   may not be the Branch-A optimizer for these primitives — only that
   the geometry can fail Hall under the stated weaker hypotheses. Verify
   this scope is honestly stated.
6. **Verdict CLOSED-NEGATIVE for Q2.** (TRE-gen-Hall) is essential —
   the published theorem must keep it as a Tier 2 hypothesis, OR add
   an additional structural condition. Verify this is the right
   recommendation.

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

(One paragraph. If PASS, recommend stopping the loop — both Q1 and Q2
have reached defensible negative endpoints.)

## Detailed Review

(Per audit items 1–6, brief.)
```

Length budget: 1200–1800 words.
