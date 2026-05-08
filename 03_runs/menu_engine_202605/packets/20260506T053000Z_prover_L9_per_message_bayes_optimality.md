# Prover pass — L9: per-message Bayes-optimality

You are the Prover in the soft-scaffolding workflow.

## Goal for this pass

Establish **L9 (per-message Bayes-optimality)** under standing + (A5) +
(A8c-lsc). Combined with Branch A and L8 (= L8c under (A8c-lsc)),
this completes the Theorem 2 infinite-extension as a conditional
theorem.

## Inputs

- `phil_reny_route_memo.md` — live route memo. Branch A complete under
  (A5). L8 PROVED-CONDITIONAL under (A8c-lsc) via $\beta^* = \delta_{m^*(s)}$.
  L9 is the last lemma.
- `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF (especially
  Definition 2 and the paper's Appendix A.2 finite-case L9-analogue).

## Target — L9

**Statement.** Under standing + (A5) + (A8c-lsc), let $(\sigma^*, \beta^*)$
be the Branch-A and L8c output. Then for τ-a.e. (or all on-path)
$m\in M$, the private strategy $\hat\sigma^*(m): \Theta\to\Delta(A)$
satisfies

$$
\hat\sigma^*(m) \in \arg\max_{\hat\sigma'} U(\hat\sigma', P_{\beta^*}(\cdot\mid m))
$$

where $P_{\beta^*}(\cdot\mid m)$ is the agent's posterior over $\Omega$
after observing message $m$ under the mixture (aligned w.p. $\alpha$,
adversary $\beta^*$ w.p. $1-\alpha$). This is the Definition 2 condition
in Dworczak & Smolin.

## Subquestions you MUST address

1. **Definition of $P_{\beta^*}(\cdot\mid m)$.** With $\beta^*(dm\mid s) = \delta_{m^*(s)}(dm)$
   (Dirac kernel), the marginal message distribution under the mixture is
   $$
   q(dm) := \alpha\,\tau(dm) + (1-\alpha)\,(m^*)_\#\tau(dm),
   $$
   where $(m^*)_\#\tau$ is the pushforward of τ by $m^*$. Compute
   $P_{\beta^*}(\omega\mid m)$ from Bayes' rule, taking care with the
   support of $q$.
   - Aligned contribution: $\mu_0(\omega)\,\pi(dm\mid\omega)\,\alpha$ at message $m$.
   - Misaligned contribution: $\mu_0(\omega)\,(m^*)_\#\pi(\cdot\mid\omega)\,(1-\alpha)$ at message $m$.
   - The posterior is well-defined for $q$-a.e. $m$.

2. **Saddle-point inequality from L8.** From Branch A and L8 under
   (A8c-lsc): $U(\beta^*,\sigma^*) = U^* = \sup_\sigma\inf_\beta U(\beta,\sigma) = \inf_\beta U(\beta,\sigma^*)$.
   Hence $(\sigma^*,\beta^*)$ is a saddle point: for every σ,
   $U(\beta^*,\sigma) \le U(\beta^*,\sigma^*) = U^* \le U(\beta,\sigma^*)$
   for every β. The left inequality says $\sigma^*$ maximizes
   $U(\beta^*,\cdot)$.

3. **Decomposition of $U(\beta^*,\sigma)$ by message.** The fixed-$\beta^*$
   payoff decomposes as
   $$
   U(\beta^*,\sigma) = \int_M U(\hat\sigma(m), P_{\beta^*}(\cdot\mid m))\,q(dm).
   $$
   Verify this decomposition rigorously, using disintegration over the
   message marginal $q$.

4. **Pointwise Bayes-optimality from saddle.** If $\sigma^*$ maximizes
   the integral above, then for $q$-a.e. $m$,
   $\hat\sigma^*(m) \in \arg\max_{\hat\sigma'} U(\hat\sigma', P_{\beta^*}(\cdot\mid m))$.
   The standard recipe: contradiction + measurable selection of an
   improving $\hat\sigma'$ on a positive-$q$-measure set of $m$ where
   $\hat\sigma^*$ fails to be Bayes-optimal — this would improve
   $U(\beta^*,\sigma^*)$, contradicting the saddle. Use Kuratowski–Ryll-Nardzewski
   for the measurable selection.

5. **"For all m" vs "for q-a.e. m".** The paper's Definition 2 says
   "for all $m\in M$", but the paper's measurability convention treats
   "for all" as "for almost all where needed." Confirm that q-a.e. is
   the correct reading, OR upgrade to pointwise via continuity of the
   best-response correspondence.

6. **Posterior version on null sets.** $q(\{m\}) = 0$ for most $m$ in
   the continuous case. Definition 2 may technically require a
   posterior version for *every* $m\in M$ (including $q$-null
   messages). The standard approach: define $P_{\beta^*}(\cdot\mid m)$
   for $q$-null messages by any measurable extension (e.g., the prior,
   or an arbitrary measurable selector). Verify this version-choice
   doesn't break the result.

7. **Aligned messages have $\alpha\,\tau$-mass.** When $\alpha > 0$,
   every $m\in\operatorname{supp}\tau = M$ has positive aligned-mixture
   contribution $\alpha\,\tau$, so $q$ is dominated below by $\alpha\,\tau$.
   This means $q$-a.e. = τ-a.e. for $\alpha>0$. Use this to simplify.

## Output Format

```markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: L9 — per-message Bayes-optimality

**Claim:** (Restate L9 with hypotheses standing + (A5) + (A8c-lsc) and
correct quantifier — q-a.e. $m$ or τ-a.e. $m$.)

**Argument:**

Step 1: Definition of $P_{\beta^*}(\cdot\mid m)$.
Justification: ...

Step 2: Saddle-point inequality + agent-side maximization.
Justification: ...

Step 3: Decomposition by message marginal $q$.
Justification: ...

Step 4: Pointwise Bayes-optimality via contradiction + measurable selection.
Justification: (KRN; measurable selection of an improving $\hat\sigma'$
on a positive-$q$-measure set.)

Step 5: Quantifier resolution (q-a.e. = τ-a.e. for $\alpha>0$).
Justification: ...

[DERIVED] L9 holds.

## Assumption Changes

- [ASSUMPTION+] / [ASSUMPTION-] (only if necessary)

## Breakdown Amendments

- [BREAKDOWN_AMEND] (only if route memo needs repair)

## Status Summary

- L9 status: PROVED / PROVED-CONDITIONAL / FALSE-AS-STATED.
- **Branch B status (Theorem 2 conditional):** ...
- **Full theorem statement:** ...

## Exact Next Obstacle

(If L9 closes Branch B: the next move is the Branch B consolidator,
producing the final theorem statement: "Under standing + (A5) +
(A8c-lsc), Theorem 2's existence direction extends to infinite $M, \Theta$."
If L9 needs an additional ingredient: name it.)
```

## Non-Negotiable Rules

- Cite Kuratowski–Ryll-Nardzewski (Aliprantis–Border 18.13) for
  measurable selection.
- Use the Branch-A saddle structure carefully — saddle is on
  $(\sigma^*,\beta^*)$, both achieving $U^*$.
- Length budget: 2000–3000 words.

## Scope Policy

L9 is the focused target. After L9 closes, the next pass is the Branch B
consolidator.
