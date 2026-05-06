# Prover pass — L1: Constant-marginal continuity (Balder hammer)

You are the Prover in the soft-scaffolding workflow.

## Goal for this pass

Establish **L1** of `phil_reny_route_memo.md` rigorously and report whether
the density set $F$ must be restricted (e.g., to bounded densities).

## Inputs (durable sources + this packet's attachments)

- Paper PDF (`Robust_trust_Dworczak_Smolin.pdf`) for the canonical model.
- `phil_reny_route_memo.md` — the live route memo, including the precise
  statement of L1 and the joint-transition-law topology on $\Sigma$.
- `phil_reny_bundle.md` — Phil's contribution and the Balder/Mertens
  précis.
- `prior_attempts_digest.md` — list of routes that are dead. Do not invoke
  the dead-route machinery in your proof.
- (Composer attachment, this pass) full Balder (1988) text.

## Target

**L1 (constant-marginal continuity).** Under the standing assumptions
($\Omega$ finite, $A$ compact metric, $\Theta$ Borel, $u$ bounded and
continuous in $a$, conditional independence of $s$ and $\theta$ given
$\omega$), and for fixed $\varphi\in F$:

If $\sigma_n\to\sigma$ in the joint-transition-law topology — i.e., for
every $\omega\in\Omega$, the joint laws

$$
\sigma_n(da\mid s,\theta)\,\pi(ds\mid\omega)\,f(d\theta\mid\omega) \;\xrightharpoonup{w^*}\; \sigma(da\mid s,\theta)\,\pi(ds\mid\omega)\,f(d\theta\mid\omega) \quad \text{on } A\times M\times \Theta,
$$

and likewise

$$
\sigma_n(da\mid m,\theta)\,\tau(dm)\,f(d\theta\mid\omega) \;\xrightharpoonup{w^*}\; \sigma(da\mid m,\theta)\,\tau(dm)\,f(d\theta\mid\omega) \quad \text{on } A\times M\times \Theta,
$$

— then for every fixed $\varphi\in F$,

$$
U_F(\sigma_n,\varphi) \longrightarrow U_F(\sigma,\varphi),
$$

where $U_F(\sigma,\varphi) := U(\beta_\varphi,\sigma)$ for
$\beta_\varphi(dm\mid s) := \varphi(m\mid s)\,\tau(dm)$ and $U$ is the paper's
payoff (eq. (1) of the paper, with the misaligned-term written as a
$\tau$-dominated integral).

Identify the **exact** Balder (1988) result invoked (theorem number, page).

## Subquestions you MUST address

1. Does the result hold for **all** $\varphi\in F$, or does it require
   $\varphi$ to be bounded ($\varphi\in L^\infty(\tau\otimes\tau)$ in some
   suitable sense)? If the latter, propose the mildest restriction (e.g.,
   $F_K := \{\varphi : \|\varphi\|_\infty \le K\}$) and state how the
   route memo must update.
2. Is the topology on $\Sigma$ described in the route memo equivalent to
   Balder's product weak topology on transition probabilities for the
   family $\{\sigma\,\pi(\cdot\mid\omega)\,f(\cdot\mid\omega)\}_{\omega\in\Omega}\cup\{\sigma\,\tau\,f(\cdot\mid\omega)\}_{\omega\in\Omega}$,
   or is it strictly weaker/stronger? If different, state which we should use.
3. Does the result need $\theta$-continuity? Phil's note suppresses
   $\theta$. We do **not** want to assume continuity in $\theta$; we want
   only measurability in $(s,\theta)$ or $(m,\theta)$, plus continuity in
   $a$. Verify Balder allows that.
4. Is there a "regular conditional probability" hypothesis needed on
   $f(\cdot\mid\omega)$? If so, is it automatic from $\Theta$ compact metric
   + Borel?

## Output Format

```markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: L1 — Constant-marginal continuity

**Claim:** (Restate L1 with all hypotheses explicit.)

**Argument:**

Step 1: (Recall the relevant Balder result by section/theorem number.)
Justification: (Cite Balder 1988, exact location.)

Step 2: (Verify hypotheses of Balder's result against our setup.)
Justification: ...

Step 3: (Apply Balder to derive continuity.)
Justification: ...

Step 4: (Combine the aligned and misaligned terms; reduce to two Balder
applications, one with marginal $\pi(\cdot\mid\omega)\,f(\cdot\mid\omega)$
and one with marginal $\tau\,f(\cdot\mid\omega)$.)
Justification: ...

[DERIVED] (State exactly what was established.)

### Target 2: Subquestion answers

(One short paragraph for each of the four subquestions above. Crisp
verdicts, not hedges.)

## Assumption Changes

- [ASSUMPTION+] / [ASSUMPTION-] (only if necessary)

## Breakdown Amendments

- [BREAKDOWN_AMEND] (only if the route memo needs repair — e.g., if F
  must be restricted to bounded densities)

## Status Summary

- L1 status: PROVED / PROVED-CONDITIONAL / FALSE-AS-STATED.

## Exact Next Obstacle

(Name the next real blocker — should point to L2.)
```

## Non-Negotiable Rules

- Every material step needs an explicit justification with a Balder citation
  by page/theorem number where Balder is invoked.
- Do not hand-wave with "clearly", "obviously", "by Balder".
- Do not silently weaken the target. If $F$ must be bounded, say so loudly
  in §Breakdown Amendments.
- Do not invoke any of the dead-route machinery in `prior_attempts_digest.md`.
- Length budget: 1500–2500 words. Do not exceed 3000.

## Scope Policy

One target lemma per pass. If you discover that L1 forces a non-trivial
amendment to the route memo (e.g., bounded densities only), STOP at the
amendment line — do not also try to re-prove L2 in this pass.
