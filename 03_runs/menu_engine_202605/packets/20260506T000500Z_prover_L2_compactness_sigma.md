# Prover pass — L2: Compactness of $\Sigma$

You are the Prover in the soft-scaffolding workflow.

## Goal for this pass

Establish **L2** of `phil_reny_route_memo.md` rigorously, paying explicit
attention to the "one common kernel" issue.

## Inputs (durable sources + this packet)

- `phil_reny_route_memo.md` — live route memo. **L1 is now PROVED**
  (Balder Theorem 2.2, p. 268, no bounded-density restriction). L2 is next.
- `phil_reny_bundle.md` — Phil's contribution + Balder/Mertens précis.
- `prior_attempts_digest.md` — dead routes; do not invoke.
- Paper PDF for canonical notation.

## Target

**L2 (compactness of $\Sigma$).** $\Sigma$, the set of measurable kernels
$\sigma:M\times\Theta\to\Delta(A)$, is **compact** in the topology of L1
— i.e., the topology where $\sigma_n\to\sigma$ iff for every $\omega\in\Omega$,

$$
\sigma_n(da\mid s,\theta)\,\pi(ds\mid\omega)\,f(d\theta\mid\omega) \;\xrightharpoonup{w^*}\; \sigma(da\mid s,\theta)\,\pi(ds\mid\omega)\,f(d\theta\mid\omega),
$$

and likewise

$$
\sigma_n(da\mid m,\theta)\,\tau(dm)\,f(d\theta\mid\omega) \;\xrightharpoonup{w^*}\; \sigma(da\mid m,\theta)\,\tau(dm)\,f(d\theta\mid\omega).
$$

## Subquestions you MUST address

1. **Common-kernel issue.** A priori, a Balder/stable limit gives one
   limit per ω-indexed base measure (i.e., $|\Omega|$ separate
   $\omega$-indexed marginals plus $|\Omega|$ separate $\omega$-indexed
   marginals on the τ side, for $2|\Omega|$ total marginals). The L2 we
   need is that all of these limits arise from **one common measurable
   kernel** $\sigma$. State and prove the "common kernel extraction"
   lemma. Hint: $\pi(\cdot\mid\omega)\ll\tau$ for every $\omega$, which
   should let you compare the τ-marginal to each $\pi(\cdot\mid\omega)$-marginal
   and force consistency.
2. **Choice of topology.** Is the topology in the route memo
   (= simultaneous Balder-weak convergence for all $2|\Omega|$ marginals)
   the right object? Or should L2 be stated in a single Balder-weak
   topology indexed by τ alone, with the $\pi(\cdot\mid\omega)$-marginals
   recovered ex post via Radon-Nikodym? Pick the cleaner formulation and
   justify.
3. **Compactness reference.** Cite the exact Balder (1988) result for
   compactness — most likely §3 (Theorem 3.1 / 3.2 area: compactness of
   transition probabilities under tightness). Verify the tightness
   hypothesis (automatic since $A$ compact metric makes $\Delta(A)$ compact
   metric; the $A$-fibers are uniformly tight).
4. **Product-kernel continuity (Theorem 2.5).** L2 may want this —
   to show that taking a kernel and pairing it with the conditional law
   $f(\cdot\mid\omega)$ behaves continuously. State whether and where
   Theorem 2.5 enters.

## Output Format

```markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: L2 — Compactness of $\Sigma$

**Claim:** (Restate L2 with the topology fully specified, and the common-kernel
clause explicit.)

**Argument:**

Step 1: (Choose the working topology and justify the pick.)
Justification: ...

Step 2: (Establish compactness of the kernel space under Balder weak/stable.
Cite the exact Balder result by section/theorem.)
Justification: ...

Step 3: (Prove the common-kernel extraction lemma. Use $\pi(\cdot\mid\omega)\ll\tau$.)
Justification: ...

Step 4: (Stitch.)
Justification: ...

[DERIVED] (State exactly what was established.)

### Target 2: Subquestion answers

(Crisp paragraph for each of the four subquestions above.)

## Assumption Changes

- [ASSUMPTION+] / [ASSUMPTION-] (only if necessary)

## Breakdown Amendments

- [BREAKDOWN_AMEND] (only if route memo needs repair)

## Status Summary

- L2 status: PROVED / PROVED-CONDITIONAL / FALSE-AS-STATED.

## Exact Next Obstacle

(Should point to L7 — re-introducing $\theta$ — per the route memo's
attack order, unless you find a reason to attack L3 first.)
```

## Non-Negotiable Rules

- Cite Balder by section/theorem number for every compactness or
  common-kernel claim.
- Do not handle $\theta$ separately — keep it in the base coordinate
  $(s,\theta)$ or $(m,\theta)$ throughout.
- Do not invoke any of the dead-route machinery in `prior_attempts_digest.md`
  (no Tychonoff-on-product-of-narrow, no atomic truncation, no exact
  raw lifting, no Sion).
- Length budget: 2000–3000 words. Do not exceed 3500.

## Scope Policy

One target per pass. If L2 forces a non-trivial route-memo amendment
(e.g., a tightness assumption is needed beyond standing hypotheses), STOP
at the amendment line.
