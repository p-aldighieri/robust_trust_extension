# Prover pass — L3: Mertens minmax checklist

You are the Prover in the soft-scaffolding workflow.

## Goal for this pass

Establish **L3** of `phil_reny_route_memo.md`: Mertens (1986) Corollary B
applies to the restricted game, hypothesis-by-hypothesis, and yields the
asymmetric minmax equality

$$
\max_{\sigma \in \Sigma}\,\inf_{\varphi \in F}\,U_F(\sigma,\varphi) \;=\; \inf_{\varphi \in F}\,\max_{\sigma \in \Sigma}\,U_F(\sigma,\varphi).
$$

## Inputs

- `phil_reny_route_memo.md` — live route memo. **L1 PROVED, L2 PROVED, L7 VERIFIED.**
- `phil_reny_bundle.md` — Phil's contribution + Mertens (1986) précis.
  Mertens Corollary B verbatim:
  > Let $T$ be an arbitrary set, $f(s,t)$ u.s.c. on $S$ for each $t \in T$. Then
  > $\max_\sigma \inf_\tau f(\sigma,\tau) = \inf_\tau \max_\sigma f(\sigma,\tau)$,
  > where $\sigma$ ranges over all regular Borel probabilities on $S$ and
  > $\tau$ over all probabilities with finite support on $T$.
- `prior_attempts_digest.md` — dead routes (don't invoke).
- Paper PDF.

## Target

**L3 (Mertens minmax checklist).** With:
- $S := \Sigma$ (kernel space) endowed with $T_\lambda$ (compact by L2),
- $T := F$ (arbitrary set; convex; carries no topology in Mertens's setup),
- $f(\sigma, \varphi) := U_F(\sigma, \varphi)$,

the hypotheses of Mertens (1986) Corollary B are satisfied, and the
equality holds. Pure-strategy maximizer for the agent exists in $\Sigma$
(no need to mix); the equality holds with $\sigma$ a regular Borel
probability over $\Sigma$ on one side and $\varphi$ ranging over finitely
supported probabilities on $F$ on the other side, but **convexity of $F$
collapses agent-side mixtures back into $\Sigma$ and adversary-side
finite-support probabilities back into $F$**.

## Subquestions you MUST address

1. **Compactness and Hausdorff.** Mertens needs $S$ compact Hausdorff.
   Verify $T_\lambda$ on $\Sigma$ is Hausdorff (Balder kernel topology
   should be Hausdorff under the standing hypotheses). Cite the relevant
   Balder result.
2. **U.s.c. in $\sigma$ for each $\varphi$.** From L1, $U_F(\sigma,\varphi)$
   is **continuous** in $\sigma$ for each $\varphi\in F$, hence u.s.c.
   Confirm this transfers cleanly.
3. **Bounded payoff.** Mertens needs the payoff to be bounded "from above
   or from below". Verify $|U_F(\sigma,\varphi)| \le \|u\|_\infty$ for
   every $(\sigma,\varphi)$.
4. **Convexity collapse on the $F$ side.** Mertens Cor B yields
   $\max_\sigma \inf_\tau f = \inf_\tau \max_\sigma f$ where $\tau$
   ranges over **finitely supported probabilities on $F$**, not over $F$
   itself. Show that, since $F$ is convex and $U_F$ is **affine** in
   $\varphi$, $\inf_{\text{finitely-supported probabilities on }F}\,\mathbb E[U_F(\sigma,\varphi)] = \inf_{\varphi\in F}\,U_F(\sigma,\varphi)$.
5. **Convexity collapse on the $\Sigma$ side.** Similarly, Mertens
   delivers the maximum over **regular Borel probabilities on $\Sigma$**.
   Show that since $\Sigma$ is convex and $U_F$ is **affine** in $\sigma$,
   the max over Borel mixtures equals the max over pure $\sigma\in\Sigma$.
6. **Affineness verification.** Confirm $U_F(\sigma,\varphi)$ is affine
   in $\sigma$ (linear integration against $\sigma$) and affine in
   $\varphi$ (linear in the density). State this as a lemma if helpful.
7. **Attainment of the agent-side maximum.** Mertens guarantees the
   value exists and the agent has $\varepsilon$-optimal strategies with
   finite support. Use compactness of $\Sigma$ + continuity of $U_F$
   in $\sigma$ to upgrade to **attainment**: there exists $\sigma^*\in\Sigma$
   with $\inf_F U_F(\sigma^*, \varphi) = \max_\sigma \inf_F U_F(\sigma, \varphi)$.

## Output Format

```markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: L3 — Mertens minmax checklist

**Claim:** (Restate L3 with all hypotheses explicit.)

**Argument:**

Step 1: (Verify $\Sigma$ compact Hausdorff in $T_\lambda$.)
Justification: ...

Step 2: (Verify $U_F$ continuous, hence u.s.c., in $\sigma$ for each $\varphi$.)
Justification: ...

Step 3: (Verify boundedness.)
Justification: ...

Step 4: (Apply Mertens Cor B.)
Justification: ...

Step 5: (Affineness lemma + adversary-side convexity collapse.)
Justification: ...

Step 6: (Agent-side convexity collapse + pure-strategy attainment.)
Justification: ...

[DERIVED] (State exactly what was established, including attainment of $\sigma^*$.)

### Target 2: Subquestion answers

(Crisp paragraph for each of subquestions 1–7.)

## Assumption Changes

- [ASSUMPTION+] / [ASSUMPTION-] (only if necessary)

## Breakdown Amendments

- [BREAKDOWN_AMEND] (only if route memo needs repair)

## Status Summary

- L3 status: PROVED / PROVED-CONDITIONAL / FALSE-AS-STATED.

## Exact Next Obstacle

(Should point to L4 — the existence and characterization of $\sigma^*$ —
which becomes a near-corollary once L3 lands. Or directly to L5 if you
fold L4 into L3.)
```

## Non-Negotiable Rules

- Cite Mertens (1986) by section/page number for the exact statement of
  Corollary B used.
- Cite Balder (1988) for the Hausdorff property of $T_\lambda$ if needed.
- Do NOT invoke any of the dead-route machinery in
  `prior_attempts_digest.md` (no Sion + Tychonoff, no adversary-side
  attainment in $\prod_\mu \Delta(M)$).
- Length budget: 2000–3000 words.

## Scope Policy

One target per pass. L3 should be tight — L4 (existence of $\sigma^*$)
follows almost mechanically once L3 lands and may be folded in if it
fits. Do not attempt L5 (Lusin compacts) or beyond.
