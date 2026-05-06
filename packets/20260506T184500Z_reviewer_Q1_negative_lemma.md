# Reviewer pass — Q1 negative lemma (row-negative; RT-realization gap)

You are the Reviewer in the soft-scaffolding workflow.

## What you are reviewing

A prover output for **Q1 negative lemma** with verdict **"ROW-NEGATIVE
CLOSED, THEOREM-LEVEL Q1-NEG NOT CERTIFIED."** The prover establishes
the abstract negative result (no Borel kernel attains the inf for the
spike row payoff) but honestly notes that **realizing the spike row as
$\ell_{\sigma^*}$ for a Branch-A maximizer in the simple binary,
s-independent form does not directly fit the Robust-Trust model**,
because RT payoffs depend on $m$ only through $\hat\sigma^*(m,\theta)$,
not directly.

Full prover response:
`logs/20260506T180000Z_prover_Q1_negative_lemma_response.md`.

## Inputs

- `theorem_2_extension_proof_v4.md`, `phil_reny_route_memo.md`,
  `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF.
- Q1 formalizer + literature pass (logs).

## Items to audit

1. **Row-level negative.** Verify the abstract negative argument
   (Steps 1–4): spike row $g(0)=1$, $g(m)=m$ for $m>0$ has $\inf = 0$
   not attained by any probability measure in $L^1(\tau)$ or by any
   Dirac (since 0 is the inf-point but $g(0)=1$). For Borel kernels
   $\beta\in B$, $\int g\,d\beta(\cdot\mid s) > 0$ for every probability
   measure on $[0,1]$ (since the inf is approached but not attained).
   Hence no Borel kernel attains.
2. **RT-realizability gap.** The prover correctly notes that $\ell$ is
   determined by $\sigma^*$, not freely chosen. So a spike at a single
   message $m_0$ requires $\hat\sigma^*(m_0,\cdot)$ to play badly there.
   The L5 modification creates such a discontinuity at $\partial K^*$,
   but $\partial K^*$ might be τ-null. **Question:** can the prover's
   diagnosis be sharpened — is there a structural reason why RT-induced
   $\ell_{\sigma^*}$ from a Branch-A maximizer always has nonempty
   rowwise argmin, OR is RT-realization just technical and a more
   careful construction works?
3. **Honest endpoint options.** The prover lists two:
   - (a) Accept the approximate-adversary Tier 1 endpoint:
     $\forall \varepsilon>0, \exists \beta_\varepsilon\in B$ with
     $U(\beta_\varepsilon,\sigma^*) \le U^* + \varepsilon$ (free from L6).
   - (b) Supply a different primitive counterexample.
   Verify (a) is mathematically justified by L6 alone; this would be
   a clean defensible endpoint.
4. **Closing Q1 with a defensible endpoint.** Even though Q1-NEG isn't
   fully certified at the theorem-level, the **net status** is:
   - No positive theorem exists (literature confirmed).
   - Abstract negative obstruction established at row level.
   - RT-realization would require careful primitive design, and it's
     not clear if it's possible or impossible.
   - Approximate-adversary statement is unconditionally available.
   This is "honestly stalled" in the sense the heartbeat allows. Should
   the Q1 endpoint be: keep (A8c-attain), and offer ε-approximate
   adversary as the alternative weak Tier 1?

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

(One paragraph. Recommendation: should we accept "row-negative +
approximate-adversary endpoint" as Q1's defensible close, OR attempt
once more at a stronger RT-realization, OR pivot to investigate if
RT structure forces (A8c-attain) automatically?)

## Detailed Review

(Per audit items 1–4, brief.)
```

Length budget: 1200–1800 words.
