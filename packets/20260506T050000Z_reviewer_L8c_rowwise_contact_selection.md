# Reviewer pass — L8c (rowwise contact-selection)

You are the Reviewer in the soft-scaffolding workflow.

## What you are reviewing

A prover output for **L8c (rowwise contact-selection)** with verdict
**Half 1 PROVED unconditionally; Half 2 DISPROVED under standing + (A5)
alone; both PROVED-CONDITIONAL under (A8c-lsc)**. The full prover
response is in
`logs/20260506T043000Z_prover_L8c_rowwise_contact_selection_response.md`.

## Inputs

- `phil_reny_route_memo.md` — live route memo. Branch A complete. Route
  3b blocked (L8a). Route 3c(iii) is the live attempt; L8c is the focused
  question.
- `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF.

## Items the reviewer MUST audit

1. **Half 1 (pointwise inf = essential inf τ-a.e.).**
   - Prover defines $a(s) := \inf_m\ell(m,s)$, $e(s) := \operatorname*{essinf}_m\ell(m,s)$,
     observes $a\le e$ pointwise.
   - $\inf_B C(\beta) = \int a\,d\tau$ via Jankov–von Neumann selection
     of analytic-graph 1/n-minimizers.
   - $\inf_F C_F(\varphi) = \int e\,d\tau$ from L8a.
   - L6 bottom-density gives $\inf_B = \inf_F$, so $\int a = \int e$.
   - $a\le e$ + integral equality ⇒ $a = e$ τ-a.e.
   - Verify each step. Watch for: Jankov–von Neumann citation, analytic
     graph hypothesis (uses $M$ standard Borel, $\ell$ Borel).
2. **Half 2 (pointwise inf NOT attained in general).** The prover gives a
   row counterexample:
   - $M = [0,1]$, τ Lebesgue, $K_n = [1/n, 1]$, $K^* = (0,1]$.
   - $g(m) = m$ for $m>0$; $g(0) = 1$ (modified to $g(m_0) = g(1) = 1$
     since $m_0 = 1$).
   - $g$ continuous on each $K_n$, satisfies L5 constant-off-$K^*$ with
     $m_0 = 1$.
   - $\inf_m g(m) = 0$, essential inf = 0 (Lebesgue), but argmin $= \emptyset$.
   - The example is **realizable** with binary states, $\pi(dx\mid 1) = 2x\,dx$,
     $\pi(dx\mid 0) = 2(1-x)\,dx$ (both $\sim$ Lebesgue, satisfying (A5)),
     binary $\Theta$ singleton, $A = [0,1]$, $u(a,\omega) = a$,
     strategy $a(m) = g(m)$.
   - Verify (a) the example satisfies all standing hypotheses + (A5);
     (b) the L5 construction can produce this $\hat\sigma^*$
     representative; (c) the failure of attainment is genuine.
3. **L.s.c. modification fails too.** The prover argues that changing
   the representative at τ-null messages doesn't help, because full
   adversary kernels in $B$ can concentrate on those null sets.
   Verify this is a correct rebuttal of sub-target (ii).
4. **(A8c-lsc) is the right Needed Assumption.** Under (A8c-lsc), L8c
   closes via Berge maximum theorem + Kuratowski–Ryll-Nardzewski selector.
   Verify the conditional proof is rigorous.
5. **Alternative (A8c-contact).** The prover proposes a weaker
   "tautological" version: argmin set is nonempty, closed, weakly
   measurable in $s$ for τ-a.e. $s$. Verify this is logically minimal.
6. **Edge case α = 1.** Prover correctly notes that L8c is trivially
   true when α = 1 (adversary term vanishes), but the L8c **statement**
   may still fail. Verify the edge case handling.
7. **Recommendation.** Prover suggests two paths: (a) accept (A8c-lsc)
   and proceed to L9; (b) try to construct a Branch-A representative
   with l.s.c. built in. Comment.
8. **Scope discipline.** Did the prover stop at L8c? No L9 leakage? No
   dead-route machinery?

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

(One paragraph. Recommend: planning pass to choose between (a)
publishing under (A8c-lsc) or (b) constructing an l.s.c. representative
from scratch.)

## Detailed Review

(Per audit items 1–8.)
```

Length budget: 1500–2500 words.

---

## PROVER OUTPUT TO REVIEW

The full prover output is in
`logs/20260506T043000Z_prover_L8c_rowwise_contact_selection_response.md`.
Key claims summarized:

- **Half 1 PROVED:** $a = e$ τ-a.e. via Jankov–von Neumann + L6.
- **Half 2 DISPROVED under standing + (A5):** explicit row counterexample
  $g(m) = m$ on $(0,1]$, $g(0) = 1$, with full model realization (binary
  states, equivalent posteriors, continuous payoff in action).
- **L.s.c. modification doesn't rescue:** adversary kernels can
  concentrate on null messages.
- **L8c PROVED-CONDITIONAL under (A8c-lsc):** $\ell(\cdot,s)$ l.s.c.
  on $M$ for τ-a.e. $s$. Berge + KRN gives selector.
- **L8 closes under (A8c-lsc) via $\beta^* = \delta_{m^*(s)}$.**
- **Recommendation:** decide between publishing under (A8c-lsc) or
  attempting a construction-side fix.
