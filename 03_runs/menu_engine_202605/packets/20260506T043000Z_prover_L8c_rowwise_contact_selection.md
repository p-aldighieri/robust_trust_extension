# Prover pass — L8c: Rowwise contact-selection lemma

You are the Prover in the soft-scaffolding workflow.

## Goal for this pass

Prove (or honestly disprove) **Lemma L8c**: rowwise contact-selection
for the Branch-A representative.

If proved, this **closes L8 immediately** via the Dirac kernel
$\beta^*(dm\mid s) := \delta_{m^*(s)}(dm)$.

If disproved (or not derivable from current hypotheses), produce the
**explicit obstruction** and identify the Needed Assumption that would
close it.

## Inputs

- `phil_reny_route_memo.md` — Branch A complete; Route 3c primary;
  L8c is the picked sub-target (rowwise measurable argmin).
- `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF.
- L8a logs (essential-inf formula, (A8-flat) criterion).
- L6 log (bottom-density: $\inf_F = \inf_B = U^*$).
- Route 3c breakdown
  (`logs/20260506T040000Z_breakdown_branch_B_route_3c_response.md`).

## Target — Lemma L8c

Let $\sigma^*$ be the Branch-A strategy (after L5 modification off
$K^*$). Define the row payoff
$$
\ell(m,s) := \sum_{\omega\in\Omega} s(\omega)\,\int_\Theta\int_A u(a,\omega,\theta)\,\hat\sigma^*(m,\theta)(da)\,f(d\theta\mid\omega).
$$

**Claim.** Under standing + (A5), there exists a τ-null set $N\subseteq M$
such that for every $s\in M\setminus N$:
$$
A(s) := \big\{m\in M : \ell(m,s) = \inf_{m'\in M}\ell(m',s) = \operatorname*{essinf}_{m'\sim\tau}\ell(m',s)\big\}
$$
is **nonempty** and **closed**, and the correspondence $s\mapsto A(s)$
is **weakly measurable**. Hence by Kuratowski–Ryll-Nardzewski (or
Aliprantis–Border 18.13), there is a Borel selector $m^*: M\setminus N\to M$,
extended arbitrarily on $N$, such that
$\beta^*(dm\mid s) := \delta_{m^*(s)}(dm)$ satisfies
$U(\beta^*,\sigma^*) = \inf_{\beta\in B} U(\beta,\sigma^*) = U^*$.

## Two halves

The breakdown identified two halves:

**Half 1 (probably easier).** Pointwise inf = essential inf for τ-a.e.
$s$. Uses L6 bottom-density: $\inf_F = \inf_B = U^*$, then a row-by-row
extraction. Specifically:
- $\inf_m \ell(m,s) \le \operatorname*{essinf}_m \ell(m,s)$ pointwise.
- L6 + bottom-density gives equality of the **integrated** lower
  bounds: $\int_M \inf_m \ell(m,s)\,\tau(ds) = \int_M \operatorname*{essinf}_m \ell(m,s)\,\tau(ds)$.
- Pointwise dominance + integral equality ⇒ pointwise equality τ-a.e.

**Half 2 (the hard half).** Pointwise inf is **attained** for τ-a.e.
$s$. This is NOT free — even with pointwise = essential equality, a
minimizing sequence may converge to a boundary point in $M$ where
$\ell$ has a jump. Key questions:
1. Is $\ell(\cdot, s)$ **lower semicontinuous** on $M$? If yes,
   compactness of $M$ ⇒ attainment.
2. If not l.s.c., does a contact condition still hold (as in the L8a
   review's contact criterion)?
3. Can the L5 Lusin shells $K_n$ be exploited to produce attainment
   even without global l.s.c.?

## Subquestions you MUST address

1. **Half 1.** Prove pointwise inf = essential inf τ-a.e. using L6 +
   bottom-density. Verify the row extraction is rigorous.
2. **Lower semicontinuity of $\ell(\cdot,s)$.** Is $\ell(\cdot,s)$
   l.s.c. on $M$?
   - From L5: $\sigma^*$ is continuous on each $K_n$ in the Balder
     stable private-strategy topology, hence $p_\omega$ is continuous
     on each $K_n$, hence $\ell(\cdot,s)$ is continuous on each $K_n$.
   - On $M\setminus K^*$: $\sigma^*$ is constant (= $\sigma_0^*(\cdot\mid m_0,\cdot)$),
     so $\ell(m,s) = \ell(m_0,s)$ for $m\notin K^*$.
   - **But:** as the L8a reviewer noted, continuity on each $K_n$ does
     NOT imply l.s.c. on $K^* = \bigcup K_n$. Sequences crossing shells
     can have jumps.
   - **Question:** is $\ell(\cdot,s)$ l.s.c. anyway by some additional
     argument, or do we need an l.s.c. modification?
3. **L.s.c. modification.** If $\ell$ is not l.s.c., consider replacing
   $\hat\sigma^*$ with an "l.s.c. modification" $\hat{\hat\sigma}^*$
   that's also a representative of the Branch-A quotient class and that
   makes $\ell$ l.s.c. Does such a modification exist while preserving
   $\sigma^*$'s value-securing property?
4. **Direct attainment via Lusin shells.** Even without l.s.c., maybe
   attainment can be argued: on each $K_n$, $\ell(\cdot,s)$ is
   continuous on the compact $K_n$, hence attains its min; let
   $m_n^*(s) := \arg\min_{m\in K_n}\ell(m,s)$. By compactness, the
   sequence $(m_n^*(s))$ has a cluster point $m^\infty(s)\in M$. Does
   $\ell(m^\infty(s),s) = \inf_m\ell(m,s)$? This requires a
   "no-discontinuity-at-the-cluster-point" argument.
5. **Joint measurability.** The selector $m^*: M\setminus N\to M$ must
   be Borel-measurable. Verify the argmin correspondence has the
   required structure (closed-valued, weakly measurable).
6. **Bayes-optimality (preview of L9).** If $\beta^*(dm\mid s) = \delta_{m^*(s)}(dm)$
   is the adversary, the induced posterior $P_{\beta^*}(\cdot\mid m)$ is
   only defined for $m$ in the image of $m^*$; this is a τ-null set in
   general. **Note:** L9 / Definition 2 may require a posterior version
   choice on null-set messages. Flag this for the L9 pass; do not solve
   here.
7. **Honest abort.** If neither pointwise attainment nor l.s.c.
   modification works, what's the Needed Assumption? E.g., "$\ell(\cdot,s)$
   is l.s.c. on $M$ for τ-a.e. $s$" or "$\hat\sigma^*$ admits an l.s.c.
   representative."

## Output Format

```markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: L8c — Rowwise contact-selection

**Verdict:** PROVED unconditionally / PROVED-CONDITIONAL on Needed Assumption / DISPROVED.

**Argument:**

Step 1 (Half 1): Pointwise inf = essential inf τ-a.e.
Justification: ...

Step 2 (Half 2): Pointwise inf attained for τ-a.e. s.
Justification: ... (l.s.c., or l.s.c. modification, or Lusin-shell
cluster-point argument, or honest abort.)

Step 3: Measurable selection.
Justification: ...

Step 4: $\beta^* = \delta_{m^*(s)}$ closes L8.
Justification: (Affineness + L6 bottom + Half 2 attainment.)

[DERIVED] (State exactly what was established. If conditional, state the
hypothesis precisely.)

## Assumption Changes

- [ASSUMPTION+] (If Half 2 needs an l.s.c. or contact assumption.)

## Breakdown Amendments

- [BREAKDOWN_AMEND] (If route memo needs repair.)

## Status Summary

- L8c status: PROVED / PROVED-CONDITIONAL / DISPROVED.
- L8 status (conditional on L8c): PROVED / OPEN.

## Exact Next Obstacle

(If L8c closes L8 unconditionally: L9 — per-message Bayes-optimality.
If L8c is conditional: a planning pass to decide whether to publish
under the new assumption or pivot.)
```

## Non-Negotiable Rules

- **Be honest.** If Half 2 has a real gap, state the Needed Assumption
  precisely.
- Do NOT use product-narrow Sion or any dead-route machinery.
- Length budget: 2500–4000 words.

## Scope Policy

L8c is the focused target. Do NOT attempt L9 (only flag for it).
