# Prover pass — L9b: Calibrated worst-message transport lemma

You are the Prover in the soft-scaffolding workflow.

## Goal for this pass

Prove (or honestly disprove) the **calibrated worst-message transport
lemma**, which is the only viable route to closing the L9 saddle gap
without dropping the Definition 2 conclusion.

## Inputs

- `phil_reny_route_memo.md`, `phil_reny_bundle.md`,
  `prior_attempts_digest.md`, paper PDF.
- `theorem_2_extension_proof.md` (current consolidator output, with the
  L9 gap).
- L9 reviewer log + L9-saddle-gap breakdown
  (`logs/20260506T080000Z_breakdown_L9_saddle_gap_response.md`).

## Target — Lemma L9b (calibrated transport)

Let $\sigma^*$ be the Branch-A optimal strategy under standing + (A5) +
(A8c-lsc). Define the rowwise argmin correspondence
$$
D(s) := \arg\min_{m\in M} \ell_{\sigma^*}(m, s)
$$
(nonempty closed by (A8c-lsc)) and the **Bayes-optimal-belief**
correspondence
$$
C(m) := \{\mu\in\Delta(\Omega) : \hat\sigma^*(m) \in \arg\max_{\hat\sigma'} U(\hat\sigma', \mu)\}.
$$

**Claim.** There exists a measurable kernel $\beta^*\in B$ such that
1. **Adversariality:** $\beta^*(D(s)\mid s) = 1$ for τ-a.e. $s$.
2. **Posterior calibration:** for the message marginal $q = \alpha\tau + (1-\alpha)\int\beta^*(\cdot\mid s)\,\tau(ds)$,
   $P_{\beta^*}(\cdot\mid m) \in C(m)$ for $q$-a.e. $m$.

If both hold, L8 closes (β* attains $\inf_\beta U(\beta,\sigma^*) = U^*$
because it concentrates on rowwise minimizers) and L9 closes
(per-message Bayes-optimality is direct from posterior calibration).

## Subquestions you MUST address

1. **What does $C(m)$ look like?** $C(m)$ is the set of beliefs $\mu$
   on $\Omega$ at which the agent's specific private strategy
   $\hat\sigma^*(m)$ is Bayes-optimal. Generically, $C(m)$ is a closed
   convex polytope (intersection of half-spaces). Verify this: for each
   alternative private strategy $\hat\sigma'$, the set
   $\{\mu : U(\hat\sigma^*(m), \mu) \ge U(\hat\sigma', \mu)\}$ is a
   closed half-space in $\Delta(\Omega)$. $C(m)$ is the intersection.
   - Special case: if $\hat\sigma^*(m)$ is Bayes-optimal at the *truthful*
     posterior $\mu = m$, then $m \in C(m)$. Verify: this is the
     standard "aligned-Bayes-optimal" property and follows from
     $\sigma^*$ achieving the aligned-truthful supremum (when α>0,
     Branch A's value structure forces this — verify).
2. **Hall/Strassen-style necessary inequalities.** The transport
   problem is: find a kernel $\beta^*: M\to\Delta(M)$ with
   - first-marginal property: $\beta^*(D(s)\mid s) = 1$;
   - second-marginal/posterior property: $P_{\beta^*}(\cdot\mid m) \in C(m)$.
   Necessary conditions (Strassen / Hall):
   - For every measurable subset $E\subseteq M$, certain mass-balance
     inequalities must hold relating $\tau(\{s : D(s)\subseteq E\})$
     to $\int_E P_{\beta^*}(\cdot\mid m)\,q(dm)$.
   - State precisely what these inequalities require.
3. **A clean sufficient condition.** Try: if for τ-a.e. $s$, the
   rowwise argmin $D(s)$ is a **single point** $m^*(s)$, AND
   $m^*(s) \in C(m^*(s))^{-1}\{s\}$ (i.e., the truthful posterior $s$
   sits in $C(m^*(s))$), then $\beta^*(dm\mid s) = \delta_{m^*(s)}$
   works. Verify this case.
   - This is a strong special case but covers many natural models.
4. **Existence under (A5) + (A8c-lsc) alone?** Honest evaluation: do
   these standing hypotheses force the transport problem to be
   feasible, or is a further assumption needed?
   - Try a small example: $|\Omega| = 2$, $M = [0,1]$, $\Theta$
     singleton, $A = [0,1]$, $u(a, 0) = -a^2$, $u(a, 1) = -(1-a)^2$.
     Compute $\sigma^*$, $D(s)$, $C(m)$ explicitly. Is the transport
     feasible?
5. **Honest abort.** If the transport is generally infeasible under
   standing + (A5) + (A8c-lsc), state the **additional** assumption
   needed (call it (A9c-calib)) and prove L9b under it. Then the
   published theorem is conditional on standing + (A5) + (A8c-lsc) +
   (A9c-calib).

## Output Format

```markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: L9b — calibrated worst-message transport

**Verdict:** PROVED unconditionally / PROVED-CONDITIONAL on new
assumption (A9c-calib) / DISPROVED.

**Argument:**

Step 1: Structure of $C(m)$ and $D(s)$.
Justification: ...

Step 2: Special case (singleton argmin + truthful-posterior
calibration).
Justification: ...

Step 3: General case — Hall/Strassen conditions.
Justification: ...

Step 4: Existence of β*.
Justification: ...

[DERIVED] (State exactly what was established.)

## Assumption Changes

- [ASSUMPTION+] (If a new condition (A9c-calib) is needed.)

## Breakdown Amendments

- [BREAKDOWN_AMEND] (Route memo updates if needed.)

## Status Summary

- L9b status: PROVED / PROVED-CONDITIONAL on (A9c-calib) / DISPROVED.
- L9 status: PROVED via L9b / OPEN / theorem must be weakened.

## Exact Next Obstacle

(If L9b closes L9 without new assumption: the proof package is complete
under (A5) + (A8c-lsc); update the consolidator. If L9b adds (A9c-calib):
update the consolidator with the additional assumption. If L9b fails:
weaken the theorem to drop Definition 2.)
```

## Non-Negotiable Rules

- Cite Aliprantis-Border, Bogachev where invoking selection /
  disintegration / transport theorems.
- Do not invoke product-narrow Sion or any dead-route machinery.
- **Be honest** about whether (A9c-calib) is needed.
- Length budget: 2500–4000 words.

## Scope Policy

L9b is the focused target. If L9b closes L9, the next pass is the
Branch B FINAL consolidator (revised). If L9b fails, propose either a
new sub-target or theorem-weakening.
