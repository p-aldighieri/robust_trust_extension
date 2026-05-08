# Prover pass — L5: Lusin-thick compact sequence

You are the Prover in the soft-scaffolding workflow.

## Goal for this pass

Establish **L5** of `phil_reny_route_memo.md`: given $\sigma^*\in\Sigma$
(the restricted-game maximin from L3+L4), construct an increasing sequence
of compact subsets $K_n\subseteq M$ with the **Lusin** property
(continuity of a representative of $\sigma^*$ on each $K_n$) AND the
**support-thickness** property (every relative open in $K_n$ has positive
$\pi(\cdot\mid\omega)$ measure for every $\omega$).

This is the trickiest Branch-A lemma. The support-thickness clause is
the delicate part. **Be honest:** if support-thickness cannot be derived
from the standing hypotheses, surface that as an explicit
[ASSUMPTION+] with the mildest formulation possible.

## Inputs

- `phil_reny_route_memo.md` — live route memo. **L1, L2, L3+L4, L7
  PROVED.** L5 is next.
- `phil_reny_bundle.md` — Phil's email explicitly describes the
  support-thickness clause.
- `prior_attempts_digest.md` — dead routes (don't invoke).
- Paper PDF.

## Target

**L5 (Lusin-thick compact sequence).** Given $\sigma^*\in\Sigma$ from
L3+L4 (a Balder quotient class), there exist:

1. A measurable representative $\hat\sigma^*$ of the quotient class
   (i.e., $\hat\sigma^*:M\times\Theta\to\Delta(A)$ measurable, agreeing
   with $\sigma^*$ $\bar G$-a.e.), AND a definition of "$m\mapsto\hat\sigma^*(m)$
   continuous on $K\subseteq M$" that makes sense in the appropriate
   private-strategy topology (presumably the topology of $\Theta\to\Delta(A)$
   as a measurable function space).

2. Compact $K_1\subseteq K_2\subseteq\cdots\subseteq M$ with $K^* = \bigcup_n K_n$
   such that $\pi(K^*\mid\omega) = 1$ for every $\omega\in\Omega$.

3. **Lusin clause:** $m\mapsto\hat\sigma^*(m)$ is continuous on each $K_n$
   in the chosen private-strategy topology.

4. **Support-thickness clause:** for every $n$, every $m\in K_n$, every
   relative open $O\subseteq K_n$ containing $m$, and every $\omega\in\Omega$,
   $\pi(O\mid\omega) > 0$.

## Subquestions you MUST address

1. **Choice of private-strategy topology.** What topology on $\hat\sigma^*(m):\Theta\to\Delta(A)$
   makes "Lusin continuity on $K_n$" meaningful? Candidates: pointwise
   weak convergence at each $\theta$, $\Delta(\Theta\times A)$ via the
   joint law $\hat\sigma^*(m)\otimes f(\cdot\mid\omega)$, or the Balder
   weak topology on $\Theta\to\Delta(A)$ itself. Pick one and justify.
2. **Lusin clause derivation.** Apply Lusin's theorem in its kernel
   form (Bogachev, Aliprantis-Border) to $\hat\sigma^*$ viewed as a
   measurable function $M\to\mathcal Y$ where $\mathcal Y$ is the chosen
   target Polish space. State the exact Lusin theorem invoked.
3. **Support-thickness clause — the delicate part.** Is it derivable
   from standing hypotheses? Specifically: for the Lusin compact $K_n$
   (which has $\pi(\cdot\mid\omega)$-measure close to 1), is every
   point of $K_n$ a $\pi(\cdot\mid\omega)$-density point?
   - One natural sufficient condition: each $\pi(\cdot\mid\omega)$ is
     **mutually absolutely continuous** with some reference measure
     (e.g., $\tau$ or Lebesgue on $\Delta(\Omega)$).
   - Another: each $\pi(\cdot\mid\omega)$ has **full support** on $M$.
   - The cleanest formulation may be to take $K_n$ to be the support of
     $\pi(\cdot\mid\omega)\restriction K_n$ (intersected over $\omega$),
     but verify this is itself compact.
4. **Compatibility across $\omega$.** The thickness condition must hold
   for **every** $\omega\in\Omega$. Since $|\Omega|<\infty$, intersect
   support-thick sets across $\omega$. Verify the intersection is still
   support-thick for each $\pi(\cdot\mid\omega)$ — i.e., the operation
   preserves the property.
5. **Modification of $\sigma^*$ off $K^*$.** Phil's email says: "modify
   $\sigma^*$ so that for messages outside $S^*$ it behaves as if the
   message was some fixed element of $S^*$." Verify this modification
   does NOT change $U_F(\sigma^*,\varphi)$ on the restricted game (since
   $K^*$ has full $\pi(\cdot\mid\omega)$ measure for every $\omega$,
   hence full $\bar G$ measure, hence $\bar G$-a.e. agreement). State
   the modified strategy precisely.
6. **Honest [ASSUMPTION+] reporting.** If support-thickness CANNOT be
   derived from the standing hypotheses, propose the mildest
   [ASSUMPTION+] that secures it. Suggested formulations:
   - **(A5a) Mutual absolute continuity of state-conditional posteriors.**
     For all $\omega,\omega'\in\Omega$, $\pi(\cdot\mid\omega)\sim\pi(\cdot\mid\omega')$.
   - **(A5b) Full support of unconditional posterior.**
     $\operatorname{supp}\tau = M$, with $\pi(\cdot\mid\omega)$
     equivalent to $\tau\restriction M$ for every $\omega$.
   - **(A5c) Density-point property.** Every $m\in M$ is a Lebesgue
     point of every $\pi(\cdot\mid\omega)$.
   Pick the one that is mildest given the existing model and explain.

## Output Format

```markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: L5 — Lusin-thick compact sequence

**Claim:** (Restate L5 in full, including the precise private-strategy
topology and any [ASSUMPTION+] adopted.)

**Argument:**

Step 1: (Choice of private-strategy topology.)
Justification: ...

Step 2: (Apply Lusin's theorem to obtain $K_n^{\mathrm{Lusin}}$
with $\pi(K_n^{\mathrm{Lusin}}\mid\omega) > 1 - 1/n$.)
Justification: ...

Step 3: (Build $K_n$ from the $K_n^{\mathrm{Lusin}}$ — possibly
intersected with support-thick subsets.)
Justification: ...

Step 4: (Verify support-thickness — either from standing hypotheses or
under [ASSUMPTION+].)
Justification: ...

Step 5: (Modify $\sigma^*$ off $K^*$ to a fixed in-$K^*$ value.)
Justification: ...

[DERIVED] (State exactly what was established.)

### Target 2: Subquestion answers

(Crisp paragraph for each of subquestions 1–6.)

## Assumption Changes

- [ASSUMPTION+] (If needed for support-thickness, with the mildest
  formulation.) **Be explicit and honest.**

## Breakdown Amendments

- [BREAKDOWN_AMEND] (If the route memo needs repair.)

## Status Summary

- L5 status: PROVED / PROVED-CONDITIONAL (under [ASSUMPTION+]) /
  FALSE-AS-STATED.

## Exact Next Obstacle

(Should point to L6 — the lift-to-measurable-deviations contradiction
argument — which is the actual core Phil-Lusin step.)
```

## Non-Negotiable Rules

- Be **honest** about whether support-thickness is automatic or needs an
  [ASSUMPTION+]. Do not paper over a gap.
- Cite Lusin's theorem by exact form (Bogachev §7, Aliprantis-Border §11).
- Do not invoke any of the dead-route machinery in
  `prior_attempts_digest.md`.
- Length budget: 2500–3500 words.

## Scope Policy

One target per pass. **Do not** attempt L6 in this pass. L5 is heavy
enough on its own.
