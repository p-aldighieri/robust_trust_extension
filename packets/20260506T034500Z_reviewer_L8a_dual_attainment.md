# Reviewer pass — L8a (restricted dual attainment)

You are the Reviewer in the soft-scaffolding workflow.

## What you are reviewing

A prover output for **L8a (restricted dual attainment)** with verdict
**CONDITIONAL on a new (A8-flat) flat-essential-minimum assumption**.
The prover honestly reports that under standing + (A5) alone, Route 3b
(barycenter bridge) does **not** close L8. The full prover response is
in `logs/20260506T033000Z_prover_L8a_dual_attainment_response.md`.

## Inputs

- `phil_reny_route_memo.md` — live route memo. Branch A complete. L8a in
  review.
- `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF.

## Items to audit

1. **Conditional structure of $\ell_{\sigma^*}(m,s)$.** The prover
   derives $\ell_{\sigma^*}(m,s) = \sum_\omega s(\omega)\,p_\omega(m)$
   for τ-a.e. $s$ from the conditional independence + the identity
   $\mu_0(\omega)\,h_\omega(s) = s(\omega)$ where
   $h_\omega = \frac{d\pi(\cdot\mid\omega)}{d\tau}$. Verify this is the
   correct formula in paper notation. (This is the natural Bayesian
   weighting of state-conditional message payoffs by posterior beliefs.)
2. **Restricted dual value formula.** $\inf_F U_F(\sigma^*,\varphi) = \text{const} + (1-\alpha)\int_M \operatorname*{essinf}_m \ell_{\sigma^*}(m,s)\,\tau(ds)$.
   The proof: lower bound from row-by-row essential infimum; upper bound
   from $\varphi_n(m\mid s) = \mathbf 1_{A_n(s)}(m)/\tau(A_n(s))$ where
   $A_n(s) = \{m: \ell_{\sigma^*}(m,s) \le e(s)+1/n\}$.
   Verify (a) $A_n(s)$ has positive τ-measure for τ-a.e. $s$; (b) joint
   measurability of $\varphi_n$; (c) the upper bound calculation.
3. **(A8-flat) necessary and sufficient.** Forward: if $\tau(Z(s))>0$
   for τ-a.e. $s$, the normalized indicator on $Z(s)$ attains. Reverse:
   if $\varphi^*\in F$ attains, then $(\ell_{\sigma^*} - e)\varphi^*\equiv 0$
   $\tau\otimes\tau$-a.e., forcing $\varphi^*(\cdot\mid s)$ supported on
   $Z(s)$ τ-a.e., which requires $\tau(Z(s))>0$ τ-a.e. since
   $\varphi^*(\cdot\mid s)\,\tau$ is a probability measure.
   Verify the necessity argument is rigorous.
4. **Generic failure example.** $M=[0,1]$, τ Lebesgue, $\ell(m,s)=m^2$;
   inf $=0$ approached by $n\,\mathbf 1_{[0,1/n]}$, no attainer in
   $L^1(\tau)$. Sanity-check this example matches the framework.
5. **Topology diagnosis.** Prover claims: $F$ is convex and weakly
   closed in $L^1(\tau\otimes\tau)$ with norm 1; $\varphi\mapsto U_F(\sigma^*,\varphi)$
   is weakly continuous; but $F$ is **not** uniformly integrable so
   Dunford-Pettis doesn't give weak compactness. Verify each clause.
6. **Why L6 doesn't help.** Prover argues L6 is bottom-density
   ($\inf_F = \inf_B = U^*$), not bottom-attainment. Verify this.
7. **Pivot recommendation.** Without (A8-flat), pivot to Route 3c
   (coarsened class $B'$). Verify this is the right next move; flag any
   alternative.
8. **Specific question for the orchestrator's next move.** Note that
   L5 establishes $\sigma^*$ Lusin continuous on each $K_n$, hence
   $p_\omega$ continuous on $K_n$, hence $\ell_{\sigma^*}(m,s) = \sum_\omega s(\omega)\,p_\omega(m)$
   continuous in $m$ on $K_n$ (for each fixed $s$). Combined with the
   L5 modification ($\sigma^*$ constant outside $K^*$ ⇒ $\ell_{\sigma^*}(m,s) = \ell_{\sigma^*}(m_0,s)$
   for $m\notin K^*$), $\ell_{\sigma^*}$ is continuous in $m$ everywhere
   except possibly on $\partial K^* \setminus K^*$ (which has τ-measure
   0 since $\tau(K^*) = 1$). Does this open Route 3c via Balder
   compactness on $B$ with τ-source marginal? Comment.

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

(One paragraph. If PASS, recommend the next prover target. The next
move depends on whether Route 3c is now viable with the L5-driven
continuity observation in audit item 8.)

## Detailed Review

(Per audit items 1–8.)
```

Length budget: 1500–2500 words.

---

## PROVER OUTPUT TO REVIEW

The full prover output is in
`logs/20260506T033000Z_prover_L8a_dual_attainment_response.md`. Key
claims summarized:

- **Verdict:** CONDITIONAL on (A8-flat).
- **Restricted dual formula:** $\inf_F U_F(\sigma^*,\varphi) = \text{const} + (1-\alpha)\int_M \operatorname*{essinf}_m \ell_{\sigma^*}(m,s)\,\tau(ds)$.
- **(A8-flat):** $\tau(Z(s)) > 0$ for τ-a.e. $s$ where $Z(s) = \{m: \ell_{\sigma^*}(m,s) = e(s)\}$ and $e(s) = \operatorname*{essinf}_m \ell_{\sigma^*}(m,s)$.
- Forward direction: under (A8-flat), $\varphi^*(m\mid s) := \mathbf 1_{Z(s)}(m)/\tau(Z(s)) \in F$ attains.
- Reverse direction: any attainer must concentrate on $Z(s)$ τ-a.e., forcing $\tau(Z(s))>0$.
- Generic failure: $M=[0,1]$, $\ell(m,s)=m^2$ has no $L^1$-attainer.
- $F$ convex weakly closed, weakly continuous functional, but not uniformly integrable.
- L6 is bottom-density, not bottom-attainment.
- Conditional L8 barycenter bridge: under (A8-flat), $\beta^* := \beta_{\varphi^*}$ closes L8.
- Recommendation: pivot to Route 3c if (A8-flat) cannot be verified.
