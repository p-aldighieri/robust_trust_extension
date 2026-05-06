# Re-review pass — L2 (compactness of $\Sigma$), patched version

You are the Reviewer in the soft-scaffolding workflow.

## Context

The previous reviewer pass (`logs/20260506T002000Z_reviewer_L2_compactness_sigma_response.md`)
returned `PATCH_SMALL` on the L2 prover output. The architecture was sound,
but three Radon-Nikodym densities were written in the wrong direction. The
reviewer supplied surgical fixes:

1. Replace $d\lambda/d\lambda_\omega^\tau$ with $d\lambda_\omega^\tau/d\lambda$.
2. Replace $h_\omega = d\tau/d\pi(\cdot\mid\omega)$ with $h_\omega = d\pi(\cdot\mid\omega)/d\tau$.
3. Add the $L^1$-domination bound $\lambda_\omega^\tau \le \mu_0(\omega)^{-1}\lambda$
   so that $L^1(\lambda)$-dominating tests are automatically $L^1(\lambda_\omega^\tau)$.
4. State the compactness citation explicitly as "Balder (1988), §2,
   Theorem 2.3(a), applied to the finite base $(X,\mathcal B(X),\lambda)$
   and compact metric target $A$."

Below is the **patched L2 proof** (orchestrator-authored, applying those
surgical fixes verbatim while preserving the original architecture). Your
job is to confirm the patch is correct and complete.

## Inputs (durable sources)

- `phil_reny_route_memo.md` — live route memo. L1 PROVED. L2 in patch round.
- `phil_reny_bundle.md` — Phil's contribution + Balder/Mertens précis.
- `prior_attempts_digest.md` — dead routes (sanity check).
- Paper PDF.

## Items to audit on this pass

1. **Density directions.** Every Radon-Nikodym density now points from the
   smaller measure to the dominating measure: $d\lambda_\omega^\tau/d\lambda$,
   $d\pi(\cdot\mid\omega)/d\tau$, $d\lambda_\omega^\pi/d\lambda$,
   $df(\cdot\mid\omega)/d\bar f$.
2. **$L^1$-domination bound.** The bound $\lambda_\omega^\tau \le \mu_0(\omega)^{-1}\lambda$
   correctly justifies passing $L^1(\lambda)$-dominated Carathéodory tests
   through Balder's continuity statement on the $\lambda_\omega^\tau$
   topology.
3. **Compactness citation.** Balder (1988) §2 Theorem 2.3(a), applied with
   compact metric target $A$ and finite base $(X,\mathcal B(X),\lambda)$.
4. **Common-kernel extraction.** The architecture stitches: finite mixture
   $Q = \sum_\omega \mu_0(\omega) Q_\omega^\tau$ → $T_\lambda$-limit of
   $\sigma_i\lambda$ → disintegration on standard Borel $X\times A$ →
   common kernel $\sigma$ → recovery of every $\lambda_\omega^\tau$- and
   $\lambda_\omega^\pi$-marginal via the (correctly-directed) RN
   multiplications.
5. **No new hypotheses smuggled.** The patched proof should rely only on
   $\Omega$ finite + full-support $\mu_0$, $A$ compact metric, $\Theta$
   compact metric, $u$ bounded continuous in $a$, conditional independence.
   No $\lambda \ll \lambda_\omega^\tau$, no $\tau \ll \pi(\cdot\mid\omega)$.

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

(One paragraph. If PASS, recommend the next prover target — should be L7.)

## Detailed Review

(Per audit items 1–5.)
```

Length budget: 800–1500 words. The proof is short and the patch is
surgical, so the review can be brief.

---

## PATCHED L2 PROOF (orchestrator-authored, for review)

### Statement

Let $X := M\times\Theta$ and $\bar f := \sum_{\omega\in\Omega}\mu_0(\omega)\,f(\cdot\mid\omega)$,
$\lambda := \tau\otimes\bar f$. Endow $\Sigma$, the set of measurable
kernels $\sigma:X\to\Delta(A)$, with the **Balder weak topology $T_\lambda$**:
$\sigma_i\to\sigma$ iff for every Carathéodory test $g:X\times A\to\mathbb R$
(measurable in $x=(m,\theta)$, continuous in $a$, dominated by some
$q\in L^1(\lambda)$),

$$
\int_X\int_A g(x,a)\,\sigma_i(da\mid x)\,\lambda(dx) \to \int_X\int_A g(x,a)\,\sigma(da\mid x)\,\lambda(dx).
$$

**Claim.** $\Sigma$ is compact in $T_\lambda$. The single-base topology
$T_\lambda$ is equivalent to the route memo's simultaneous topology
requiring Balder-weak convergence in all $\lambda_\omega^\pi := \pi(\cdot\mid\omega)\otimes f(\cdot\mid\omega)$
and $\lambda_\omega^\tau := \tau\otimes f(\cdot\mid\omega)$ topologies, and
every simultaneous limit is induced by **one common measurable kernel**
$\sigma$.

### Step 1. Topology equivalence

Since $\mu_0$ has full support and $\tau = \sum_{\omega'}\mu_0(\omega')\pi(\cdot\mid\omega')$,
we have $\pi(\cdot\mid\omega)\ll\tau$ for every $\omega$. Likewise
$f(\cdot\mid\omega)\ll\bar f$. Hence $\lambda_\omega^\pi\ll\lambda$ and
$\lambda_\omega^\tau\ll\lambda$, with Radon-Nikodym densities

$$
\frac{d\lambda_\omega^\tau}{d\lambda}(m,\theta) = \frac{df(\cdot\mid\omega)}{d\bar f}(\theta), \qquad \frac{d\lambda_\omega^\pi}{d\lambda}(m,\theta) = \frac{d\pi(\cdot\mid\omega)}{d\tau}(m)\,\frac{df(\cdot\mid\omega)}{d\bar f}(\theta).
$$

Conversely,

$$
\lambda = \tau\otimes\bar f = \sum_\omega \mu_0(\omega)\,(\tau\otimes f(\cdot\mid\omega)) = \sum_\omega \mu_0(\omega)\,\lambda_\omega^\tau.
$$

In particular,

$$
\lambda_\omega^\tau \le \mu_0(\omega)^{-1}\,\lambda \qquad \text{(crucial for } L^1\text{-domination transfer).}
$$

**$T_\lambda \Rightarrow$ simultaneous.** Given a $T_{\lambda_\omega^\tau}$-admissible
test $g$ ($\le q\in L^1(\lambda_\omega^\tau)$), the product
$g \cdot \frac{d\lambda_\omega^\tau}{d\lambda}$ is a Balder Carathéodory
test for $T_\lambda$: measurable in $x$, continuous in $a$, dominated by
$q\cdot\frac{d\lambda_\omega^\tau}{d\lambda}\in L^1(\lambda)$ since
$\int q\cdot\frac{d\lambda_\omega^\tau}{d\lambda}\,d\lambda = \int q\,d\lambda_\omega^\tau < \infty$.
By Balder (1988) §2 Theorem 2.2,

$$
\int g\,d(\sigma_i\lambda_\omega^\tau) = \int g\cdot\tfrac{d\lambda_\omega^\tau}{d\lambda}\,d(\sigma_i\lambda) \to \int g\cdot\tfrac{d\lambda_\omega^\tau}{d\lambda}\,d(\sigma\lambda) = \int g\,d(\sigma\lambda_\omega^\tau).
$$

Same argument for the $\lambda_\omega^\pi$-side.

**Simultaneous $\Rightarrow T_\lambda$.** Given a $T_\lambda$-admissible
test $g$ with $|g|\le q\in L^1(\lambda)$: by $\lambda_\omega^\tau\le\mu_0(\omega)^{-1}\lambda$,
also $q\in L^1(\lambda_\omega^\tau)$, so $g$ is $T_{\lambda_\omega^\tau}$-admissible
for every $\omega$. The finite-mixture identity gives

$$
\int g\,d(\sigma_i\lambda) = \sum_\omega \mu_0(\omega)\int g\,d(\sigma_i\lambda_\omega^\tau) \to \sum_\omega \mu_0(\omega)\int g\,d(\sigma\lambda_\omega^\tau) = \int g\,d(\sigma\lambda).
$$

### Step 2. Compactness

Apply **Balder (1988), §2, Theorem 2.3(a)**, with finite base
$(X,\mathcal B(X),\lambda)$ and compact metric target $A$. The set of
transition probabilities $X\to\Delta(A)$ is weakly compact in $T_\lambda$.
No extra tightness is needed because $A$ is compact metric, so every
fiber law $\sigma(\cdot\mid x)\in\Delta(A)$ is automatically tight.

### Step 3. Common-kernel extraction

Let $(\sigma_i)\subset\Sigma$ be a net. Suppose for every $\omega$,
$\sigma_i\lambda_\omega^\tau$ and $\sigma_i\lambda_\omega^\pi$ have
Balder-weak limits $Q_\omega^\tau$ and $Q_\omega^\pi$ respectively.

Form the finite mixture $Q := \sum_\omega \mu_0(\omega)\,Q_\omega^\tau$.
For any $T_\lambda$-admissible Carathéodory $g$ (with $|g|\le q\in L^1(\lambda)$),

$$
\int g\,dQ = \sum_\omega \mu_0(\omega)\int g\,dQ_\omega^\tau = \lim_i \sum_\omega \mu_0(\omega)\int g\,d(\sigma_i\lambda_\omega^\tau) = \lim_i \int g\,d(\sigma_i\lambda).
$$

(The interchange of $\sum_\omega$ and $\lim_i$ is finite because $|\Omega|<\infty$;
$g$ is admissible in each $T_{\lambda_\omega^\tau}$ by the bound
$\lambda_\omega^\tau\le\mu_0(\omega)^{-1}\lambda$, so each term converges
by Step 1's transfer.)

Hence $Q$ is the $T_\lambda$-limit of $\sigma_i\lambda$. Its $X$-marginal
is $\lambda$ (test $g(x,a) = \varphi(x)$ for $\varphi\in L^\infty(\lambda)$).
Since $X\times A$ is standard Borel ($X = M\times\Theta\subseteq\Delta(\Omega)\times\Theta$
with $\Omega$ finite and $\Theta$ compact metric; $A$ compact metric),
disintegrate:

$$
Q(dx,da) = \lambda(dx)\,\sigma(da\mid x)
$$

for some measurable kernel $\sigma:X\to\Delta(A)$.

Fix $\omega$. Set $r_\omega^\tau := \frac{d\lambda_\omega^\tau}{d\lambda} \in L^1(\lambda)$
(direction: small over large). For any $T_{\lambda_\omega^\tau}$-admissible
test $g$,

$$
\int g\,dQ_\omega^\tau = \lim_i \int g\,d(\sigma_i\lambda_\omega^\tau) = \lim_i \int r_\omega^\tau(x)\,g(x,a)\,\sigma_i(da\mid x)\,\lambda(dx).
$$

Since $r_\omega^\tau\le\mu_0(\omega)^{-1}$, the product $r_\omega^\tau g$
is $T_\lambda$-admissible. Balder Theorem 2.2 gives convergence to

$$
\int r_\omega^\tau(x)\,g(x,a)\,\sigma(da\mid x)\,\lambda(dx) = \int g(x,a)\,\sigma(da\mid x)\,\lambda_\omega^\tau(dx).
$$

Hence $Q_\omega^\tau = \sigma\,\lambda_\omega^\tau$.

For the $\pi$-side: set $h_\omega := \frac{d\pi(\cdot\mid\omega)}{d\tau} \in L^1(\tau)$
(direction: small over large). Then $\lambda_\omega^\pi = h_\omega\,\lambda_\omega^\tau$
(viewing $h_\omega(m)$ as a function of $x = (m,\theta)$). Note
$h_\omega\le\mu_0(\omega)^{-1}$ from $\tau \ge \mu_0(\omega)\,\pi(\cdot\mid\omega)$.
The same RN multiplication argument gives, for every
$T_{\lambda_\omega^\pi}$-admissible test $g$,

$$
\int g\,dQ_\omega^\pi = \lim_i \int h_\omega\,g\,d(\sigma_i\lambda_\omega^\tau) = \int h_\omega\,g\,dQ_\omega^\tau = \int g\,d(\sigma\lambda_\omega^\pi).
$$

Hence $Q_\omega^\pi = \sigma\,\lambda_\omega^\pi$.

### Step 4. Stitch

Balder §2 Theorem 2.3(a) gives compactness of $\Sigma$ in $T_\lambda$.
Step 1 shows $T_\lambda$ is equivalent to the simultaneous topology. Step 3
shows every simultaneous limit factors through one common measurable
kernel $\sigma$, with all $\omega$-indexed $\pi$- and $\tau$-marginals
recovered via correctly-directed Radon-Nikodym multiplications.

**[DERIVED] L2 holds.** $\Sigma$ is compact in the topology relevant for
L1, and compactness produces common-kernel limits.

### Notes

- **Density direction discipline.** Every RN density above points from
  a *smaller* (dominated) measure to the *larger* (dominating) one. The
  three densities used are:
  - $\frac{d\lambda_\omega^\tau}{d\lambda} \in L^1(\lambda)$, bounded by $\mu_0(\omega)^{-1}$.
  - $\frac{df(\cdot\mid\omega)}{d\bar f} \in L^1(\bar f)$, bounded by $\mu_0(\omega)^{-1}$.
  - $h_\omega = \frac{d\pi(\cdot\mid\omega)}{d\tau} \in L^1(\tau)$, bounded by $\mu_0(\omega)^{-1}$.
- No assumption beyond standing hypotheses is invoked. In particular,
  $\lambda \not\ll \lambda_\omega^\tau$ and $\tau\not\ll\pi(\cdot\mid\omega)$ in
  general — those reverse-direction relations are NOT used anywhere.
- The standard-Borel disintegration uses that $M\subseteq\Delta(\Omega)\subseteq\mathbb R^N$
  is Borel, $\Theta$ compact metric, $A$ compact metric.

### Status

L2: PROVED (after RN-direction patch).

### Exact next obstacle

L7 — re-introducing $\theta$. Since $\theta$ is already in the base
coordinate $x = (m,\theta)$ throughout the L1 and patched L2 proofs, L7
should be a verification pass rather than a new compactness argument.
