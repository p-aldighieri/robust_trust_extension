# Prover pass — Relax (A8c-lsc) to direct rowwise-argmin attainment

You are the Prover in the soft-scaffolding workflow.

## Goal

Per the scoper recommendation
(`logs/20260506T110000Z_scoper_assumptions_strength_response.md`),
relax **(A8c-lsc)** to the strictly weaker structural condition that's
actually needed for L8c-Half-2 / L8 closure:

**(A8c-attain).** For τ-a.e. $s\in M$, $D(s) := \arg\min_{m\in M}\ell_{\sigma^*}(m,s)$
is **nonempty**, and the correspondence $s\mapsto D(s)$ admits a
**Borel measurable selector** $m^*: M\to M$ with $m^*(s)\in D(s)$
for τ-a.e. $s$.

This is the property L8 actually invokes via Kuratowski–Ryll-Nardzewski.
L.s.c. of $\ell(\cdot,s)$ is just one sufficient route. The l.s.c.
counterexample $g(m) = m$ on $(0,1]$, $g(0) = 1$ shows that
non-l.s.c. $\ell$ can have empty argmin, so (A8c-attain) really is
strictly weaker than (A8c-lsc), with the gap = "does the argmin
correspondence have a measurable selector at all?"

In parallel, **identify primitive sufficient conditions** that force
(A8c-attain) without requiring (A8c-lsc):
- (P1) The agent's optimal Bayes-action correspondence is upper
  hemicontinuous in the message $m$ (compact-valued u.h.c.).
- (P2) The trust-region projection map (paper Section 4 / Theorem 1)
  is continuous on $\Delta(\Omega)$.
- (P3) $\sigma^*$ admits a closed-graph representative (the strategy
  graph $\{(m,\theta,a) : a\in\operatorname{supp}\hat\sigma^*(m,\theta)\}$
  is closed in $M\times\Theta\times A$).

Establish: each of (P1)–(P3) implies (A8c-attain) — without requiring
l.s.c. of $\ell$ pointwise.

## Inputs

- `theorem_2_extension_proof.md` — landed proof.
- `phil_reny_route_memo.md` — route memo.
- L8c logs (the obstruction structure).
- Paper PDF (Section 4, Theorem 1, Appendix A.6).

## Targets

### Target 1: (A8c-attain) suffices for L8

Restate L8 using (A8c-attain) instead of (A8c-lsc). Verify the
KRN-based argument in L8 closes under (A8c-attain) with no other
changes. (Should be a one-paragraph verification — KRN is the only
selection theorem invoked.)

### Target 2: (A8c-attain) is strictly weaker than (A8c-lsc)

Show: (A8c-lsc) ⇒ (A8c-attain) (immediate via Berge / measurable
maximum theorem).

Show: there exist models satisfying (A8c-attain) but NOT (A8c-lsc).
Concrete example: $g(m) = m^2$ on $[0,1]\setminus\{0.5\}$ and
$g(0.5) = 0$ — argmin is $\{0.5\}$ (attained), but $g$ is not l.s.c.
at $m = 0.5$. Verify this fits a model realization.

### Target 3: Primitive sufficient conditions

For each of (P1), (P2), (P3), prove: (Pi) ⇒ (A8c-attain). Specifically:

- **(P1) ⇒ (A8c-attain).** If the agent's Bayes-action correspondence
  $\mathcal A^*: \Delta(\Omega) \rightrightarrows A$ is u.h.c. with
  closed values, then $m\mapsto p_\omega(m) = \int u\cdot\hat\sigma^*(m,\theta)(da)\cdot f(d\theta\mid\omega)$
  is u.s.c. (since $\sigma^*$ is a measurable selector from $\mathcal A^*$
  composed with the Bayes-action structure), hence $\ell$ is u.s.c.
  in $m$. **Wait** — u.s.c. is too weak; we need l.s.c. or attainment.
  Refine: u.h.c. of $\mathcal A^*$ + appropriate compactness gives
  the **closed** graph of the strategy correspondence, which gives
  attainment of $\inf_m \ell$ via standard upper-hemicontinuous-min
  arguments (Berge maximum theorem variant: for u.h.c. compact-valued
  $F$ and continuous $f$, $\inf F$ is attained).

  *Carefully* re-derive: under (P1), is $\ell(\cdot,s)$ l.s.c.,
  u.s.c., neither, or just attainment-friendly? Check.

- **(P2) ⇒ (A8c-attain).** If the trust-region projection $P:\Delta(\Omega)\to T\subseteq\Delta(\Omega)$
  is continuous (where $T$ = closed trust region), and $\sigma^*$ is the
  composition "play Bayes-action at $P(m)$", then $\hat\sigma^*$ is
  continuous in $m$. Hence $p_\omega$ continuous, $\ell$ continuous
  (not just l.s.c.). Strong form: continuity ⇒ attainment + selector.

- **(P3) ⇒ (A8c-attain).** Closed-graph representative ⇒ standard
  application of measurable maximum theorem (Aliprantis–Border 18.19)
  for normal integrands.

### Target 4: Honest framing

The relaxed version of the theorem reads: "Branch B closes under
standing + (A5) + (A8c-attain) + (A9c-calib)" (Tier 2) or "+ (A8c-attain)"
(Tier 1). (A8c-attain) holds whenever any of (P1), (P2), (P3) holds.
Connect these primitive conditions to the paper's economic structure.

## Output Format

```markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: (A8c-attain) suffices for L8
(Argument; one paragraph.)

### Target 2: (A8c-attain) is strictly weaker than (A8c-lsc)
(Forward direction; counterexample for the strict inclusion.)

### Target 3: Primitive sufficient conditions

#### (P1) U.h.c. Bayes-action correspondence
(Argument.)

#### (P2) Continuous trust-region projection
(Argument.)

#### (P3) Closed-graph strategy representative
(Argument.)

### Target 4: Honest framing of the relaxation
(One paragraph.)

[DERIVED] (A8c-lsc) can be relaxed to (A8c-attain), which is implied
by any of (P1), (P2), (P3) — primitive economic conditions
corresponding to TRE structure or u.h.c. Bayes responses.

## Assumption Changes

- [ASSUMPTION-] (A8c-lsc) replaced by (A8c-attain).
- [ASSUMPTION+] (A8c-attain) — strictly weaker primitive condition.

## Breakdown Amendments

- [BREAKDOWN_AMEND] Update theorem statement to use (A8c-attain).
- [BREAKDOWN_AMEND] Document (P1), (P2), (P3) as natural primitive
  routes to (A8c-attain).

## Status Summary

- L8 status: PROVED-CONDITIONAL on (A5) + (A8c-attain) (relaxed).
- (A8c-lsc) replaced by strictly weaker (A8c-attain).
- (A8c-attain) implied by any of (P1), (P2), (P3).

## Exact Next Obstacle

(Ready for reviewer. Next relaxation target: (A5).)
```

## Non-Negotiable Rules

- Cite Aliprantis-Border 18.13 (KRN), 18.19 (measurable maximum), and
  17.11 / Berge for u.h.c.-related results.
- Be careful with hemicontinuity directions: u.h.c. of a correspondence
  ≠ l.s.c. of an integrand. Verify each Pi → (A8c-attain) implication
  rigorously.
- Length budget: 2000–3000 words.

## Scope Policy

Focused on (A8c-lsc) relaxation. Do NOT attempt (A5) or (A9c-calib)
relaxations in this pass.
