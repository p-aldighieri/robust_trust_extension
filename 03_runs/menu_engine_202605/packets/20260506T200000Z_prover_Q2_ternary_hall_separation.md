# Prover pass — Q2: Ternary Hall-feasibility separation

You are the Prover in the soft-scaffolding workflow.

## Goal

Per the Q2 literature pass recommendation, attack Q2 via a **concrete
$|\Omega|=3$ separation analysis**. The deliverable: either

- **(NEG)** a concrete ternary RT-model where standing + (A5-thick) +
  (A8c-attain) hold, the trust region $T$ is non-radial, $m^*$ is
  single-valued, and the Hall inequality **fails** for some measurable
  $E$ and affine $\phi$ — proving (TRE-gen-Hall) is essential;
- or **(POS)** a structural condition on the model geometry (beyond
  TRE-gen) that forces the Hall inequality automatically — isolating
  the additional structural condition.

## Inputs

- `theorem_2_extension_proof_v4.md`, `phil_reny_route_memo.md`,
  `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF.
- Q2 formalizer + literature logs.

## Concrete construction template (per literature)

**Fix:**
- $\Omega = \{0, 1, 2\}$, $|\Omega| = 3$. State $\omega$ priors $\mu_0$
  full-support.
- $\Theta$ singleton (or trivial).
- $A = \Delta(\Omega)$ (continuous action space — agent picks a
  belief / action equivalently). Or $A$ a finite set making payoffs
  vary.
- $u(a, \omega, \theta) = -\|a - e_\omega\|^2$ (strictly convex
  quadratic loss in $a$, where $e_\omega$ is the indicator vector for
  $\omega$). This gives Bayes-optimal action $= $ posterior mean.

**Trust region:** non-radial closed convex $T \subset \Delta(\Omega)$,
e.g., a triangle clipped along one face — say,
$T = \{\mu\in\Delta(\Omega) : \mu(0)\le 0.4\}$ (excluding posteriors
that put more than 40% on state 0).

**Posterior law $\tau$ on $M = \Delta(\Omega)$:** atomless, full-support
on $\Delta(\Omega)$. E.g., uniform on the simplex, or Dirichlet.

**Bregman projection $P_T$:** Euclidean projection on $T$.

**$\sigma^*$ via TR-strategy:** $\hat\sigma^*(m) = $ Bayes-action at
$P_T(m)$ — i.e., agent acts as if posterior were the projection of
$m$ onto $T$. This is the natural TR strategy from paper's Theorem 1.

**Worst-message map $m^*$:** for each $s\in M$, $m^*(s) = $ message
that minimizes $\ell(\cdot, s) = \sum_\omega s(\omega) p_\omega(\cdot)$.
For TR-strategies, $m^*(s)$ is typically a boundary point of $T$.

**Posterior-Bayes-optimality cone $C(m)$:** for the Bayes-optimal action
$\hat\sigma^*(m) = P_T(m)$, $C(m) = \{\mu: $ posterior-mean of $\mu = P_T(m)\}$
which is a hyperplane in $\Delta(\Omega)$. (Specifically: $\mu\in C(m)$
iff $\sum_\omega \mu(\omega)\,e_\omega = P_T(m)$ — but since
$\sum_\omega\mu(\omega)e_\omega = \mu$, this reduces to $\mu = P_T(m)$.
For non-quadratic $u$, $C(m)$ is a normal-cone slice.)

Wait — for quadratic loss with action $a=$ posterior mean,
$\hat\sigma^*(m)$ literally equals the posterior on $\Omega$. So
$C(m) = \{P_T(m)\}$ — a single point. This is too restrictive. Adjust:
use $u$ with a non-trivial $C(m)$ (e.g., $u$ with multiple Bayes-optimal
actions on a face), OR change $A$ to be discrete with the resulting
$C(m)$ a polytope.

**Adjust:** make $A = \{a_0, a_1, a_2\}$ discrete with $u(a_\omega, \omega) = 1$,
$u(a_i, \omega) = -1$ for $i\ne\omega$. Then $C(m) = \{\mu: \mu(\omega) > \tfrac12$
for the $\omega = \hat\sigma^*(m)\}$. This is a "winning vertex"
half-space. With the TR projection structure, $\hat\sigma^*(m)$ picks
$\arg\max_\omega P_T(m)(\omega)$, and $C(m)$ is the corresponding
half-space.

## What you must produce

### Target 1: Compute the Hall inequality for the concrete model

**Step 1.** Specify the model precisely (μ₀, π, τ, u, T).

**Step 2.** Compute $\sigma^*$, $\ell_{\sigma^*}$, $D(s)$, $m^*(s)$,
$C(m)$ for the chosen TR.

**Step 3.** State the Hall inequality:
$$
\alpha\int_E\phi(m)\,\tau(dm) + (1-\alpha)\int_{(m^*)^{-1}(E)}\phi(s)\,\tau(ds) \le \int_E h_{C(m)}(\phi)\,q(dm)
$$
for measurable $E$ and continuous affine $\phi$.

**Step 4.** Search for $E$ and $\phi$ violating the Hall inequality.

**Verdict:**
- **If violation found:** (TRE-gen-Hall) is **essential** under
  standing + (A5-thick) + (A8c-attain) + TRE-gen alone. Q2 closes
  NEGATIVELY: (TRE-gen-Hall) cannot be derived from those weaker
  conditions for general $|\Omega|\ge 3$.
- **If no violation under this model:** isolate the geometry that
  prevents it. Candidates: radial symmetry of $T$ around $\mu_0$;
  $T$ orthant-aligned; convex-order monotonicity; etc.

### Target 2: Honest endpoint

State the Q2 endpoint:
- **(NEG path):** "(TRE-gen-Hall) is essential — the published
  theorem must keep it as a Tier 2 hypothesis."
- **(POS path):** "(TRE-gen-Hall) is implied by TRE-gen + [extra
  geometric condition]; this is a positive partial result."

## Output Format

```markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: Concrete ternary Hall analysis

**Model.** (Primitives.)
**Step 1.** Compute σ*, ℓ, D(s), m*(s), C(m).
**Step 2.** State Hall inequality.
**Step 3.** Search for violation.

[DERIVED] Either: violation found ⇒ (TRE-gen-Hall) essential.
       Or: no violation ⇒ isolated geometric condition.

### Target 2: Honest endpoint

(One paragraph.)

## Status Summary

- **Q2 status:** CLOSED-NEGATIVE / CLOSED-POSITIVE-CONDITIONAL / OPEN.

## Exact Next Obstacle

(Reviewer pass on this. Then either consolidate the negative endpoint
or attempt the positive structural theorem.)
```

## Non-Negotiable Rules

- Be HONEST. If the violation can't be constructed concretely, surface
  the obstruction and move toward the positive-conditional endpoint.
- Use Robust-Trust-compliant primitives.
- Length budget: 2500–4000 words.

## Scope Policy

Q2 only. The deliverable is the concrete separation analysis.
