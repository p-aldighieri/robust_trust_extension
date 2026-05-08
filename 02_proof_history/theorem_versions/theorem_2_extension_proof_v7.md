# Robust Trust Theorem 2 — infinite-$M$, $\Theta$ extension via the payoff-profile menu engine (v7, three-tier)

*Final consolidator. Replaces v5/v6. The previous (v5) two-tier proof
under three added hypotheses (A5-thick, A8c-attain, TRE-gen-Hall) is
superseded by the menu-engine route in $W$-geometry, which is strictly
cleaner and decomposes naturally into three tiers.*

## 1. Setting and the question

Standard Robust-Trust setup (Dworczak–Smolin 2026, §2). $\Omega$ finite
with full-support prior $\mu_0$; $s\in\Delta(\Omega)$ has state-conditional
law $\pi(\cdot\mid\omega)$ and unconditional law $\tau$;
$M = \operatorname{supp}\tau$; $\theta\in\Theta$ (compact metric);
$A$ compact metric; $u(a,\omega,\theta)$ bounded continuous in $a$;
conditional independence of $s,\theta$ given $\omega$. $\Sigma$ =
agent's measurable strategies, $B$ = misaligned-adviser measurable
kernels. With probability $\alpha$ aligned (truthful), with probability
$1-\alpha$ misaligned. $U^* = \sup_\sigma U(\sigma)$.

The question: existence direction of Theorem 2 for infinite $M$ and
$\Theta$.

## 2. The menu engine (architectural pivot from v5)

The paper's Theorem 1 / Appendix A.1 introduces the **payoff-profile
set**
$$
W \;:=\; \{w\in\R^{|\Omega|} : \exists\,\hat\sigma:\Theta\to\Delta(A)\ \text{measurable},\ w(\omega) = \E_{\hat\sigma}[u(a,\omega,\theta)\mid\omega]\}.
$$
$W$ is **compact convex in $\R^{|\Omega|}$** (boundedness + compact
$A$ + continuity in $a$). An agent strategy $\sigma$ corresponds to
a measurable map $w_\sigma: M\to W$, the message-conditional payoff
profile, and conversely (modulo the standard profile-realization
sub-lemma below).

The agent's choice variable is therefore a compact subset $C\subseteq W$
("menu") together with a labeling $w: M\to C$. The objective decomposes
cleanly:

$$
F(C) \;:=\; \int_M \!\Big[\alpha\,\max_{w\in C}\,s\cdot w \;+\; (1-\alpha)\,\min_{w\in C}\,s\cdot w\Big]\,\tau(ds).
$$

**Menu-value equivalence.**
$$
U^* \;=\; \sup_{C\in\mathcal K(W)}\,F(C),
$$
where $\mathcal K(W)$ is the set of nonempty compact subsets of $W$.

**Profile-realization sub-lemma (used everywhere, standard).** The
profile map $\Phi:\hat\Sigma\to W$ from the compact standard-Borel
private-kernel space $\hat\Sigma$ to $W$ is continuous with compact
fibers (boundedness, compact $A$, continuity in $a$). Hence by
Aliprantis–Border 18.13 (Kuratowski–Ryll-Nardzewski) it admits a
Borel right inverse $R: W\to\hat\Sigma$ with $\Phi\circ R = \mathrm{id}$.
Every Borel $w: M\to W$ is implementable as a measurable agent
strategy $\sigma(da\mid m,\theta) = R(w(m))(da\mid\theta)$.

This sub-lemma is genuinely standard (it's exactly the measurable
selection used implicitly in the paper's $W$-representation argument).

## 3. Main theorem (three tiers)

### Theorem (Tier 1a — value optimality + ε-adversary, unconditional)

*Under the standing hypotheses of Dworczak–Smolin (2026), there exists
$\sigma^*\in\Sigma$ with*
$$
U(\sigma^*) \;=\; U^*.
$$
*Moreover, for every $\eps>0$ there exists $\beta_\eps\in B$ with*
$$
U(\beta_\eps,\sigma^*) \;\le\; U^* + \eps.
$$

**No added hypotheses for Tier 1a** — strictly stronger than v5.

### Theorem (Tier 1b — exact adversary attainment)

*Under standing hypotheses + Assumption \textnormal{(exact-contact)},
the ε-adversary above can be replaced by an exact $\beta^*\in B$
with*
$$
U(\beta^*,\sigma^*) \;=\; \inf_{\beta\in B}\,U(\beta,\sigma^*) \;=\; U^*.
$$

\paragraph{Assumption (exact-contact).}
Let $C^\dagger := \overline{w^*(M)}$ where $w^*(m) := \arg\max_{w\in C^*}\,m\cdot w$
is the aligned-best labeling at the optimal menu $C^*$. Then for
$\tau$-a.e. $s\in M$, the rowwise contact set
$$
G(s) \;:=\; \big\{m\in M : s\cdot w^*(m) = \min_{z\in C^\dagger}\,s\cdot z\big\}
$$
is **nonempty and admits a measurable selector** (e.g., via
Jankov–von Neumann + standard $\tau$-a.e. Borelization).

This is the menu-language analog of v5's A8c-attain, but cleanly
endogenous to the chosen labeling $w^*$ rather than imposed on an
arbitrary kernel-space representative. Sufficient routes (each
implies exact-contact): $w^*(M)$ closed; the strategy correspondence
has closed graph; the agent's Bayes-action correspondence is
upper-hemicontinuous with closed compact values.

### Theorem (Tier 2 — full robust rationalizability)

*Under standing + (exact-contact) + Assumption \textnormal{(menu-Hall)},
$(\sigma^*,\beta^*)$ can be chosen so that, when $\alpha>0$,*
$$
\hat\sigma^*(m) \;\in\; \arg\max_{\hat\sigma'}\,U\big(\hat\sigma',\,P_{\beta^*}(\cdot\mid m)\big) \quad \text{for $\tau$-a.e.\ }m\in M.
$$
*Hence $\sigma^*$ is robustly rationalizable in the paper's
a.e./on-path sense.*

\paragraph{Assumption (menu-Hall).}
There exists a kernel $\kappa(\cdot\mid s)$ on $M$ supported on
$G(s)$ for $\tau$-a.e. $s$ such that, with
$\gamma_\alpha := \alpha\,(\mathrm{id},\mathrm{id})_\#\tau + (1-\alpha)\,\tau\otimes\kappa$
and $q := (\gamma_\alpha)_2$, the disintegration posterior
$P_{\gamma_\alpha}(\cdot\mid m) \in B(m)$ for $q$-a.e.\ $m$, where
$$
B(m) \;:=\; \{\mu\in\Delta(\Omega) : \hat\sigma^*(m)\in\arg\max_{\hat\sigma'}\,U(\hat\sigma',\mu)\}.
$$

Equivalently (support-function form): for every measurable $E\subseteq M$
and every continuous affine $\phi:\Delta(\Omega)\to\R$,
$$
\alpha\!\int_E\!\phi(m)\,\tau(dm) + (1-\alpha)\!\int_M\!\phi(s)\,\kappa(E\mid s)\,\tau(ds) \;\le\; \int_E\!h_{B(m)}(\phi)\,q(dm).
$$

This is **strictly milder** than v5's deterministic TRE-gen-Hall:
$\kappa$ may mix over $G(s)$ (set-valued mixing). The deterministic
version forced $\kappa$ to be Dirac.

## 4. Proof — Tier 1a (unconditional)

### Lemma 1 (menu-value equivalence)

$U^* = \sup_{C\in\mathcal K(W)}\,F(C)$.

\paragraph{Proof.} For fixed $\sigma$ with profile-map $w_\sigma:M\to W$:
the misaligned term satisfies $\inf_\beta\!\int\!\!\int s\cdot w_\sigma(m)\,\beta(dm\mid s)\,\tau(ds) = \int_M\inf_{m\in M}\,s\cdot w_\sigma(m)\,\tau(ds) = \int_M\inf_{w\in w_\sigma(M)}\,s\cdot w\,\tau(ds)$.
The aligned term is $\int s\cdot w_\sigma(s)\,d\tau$. Optimizing
$w_\sigma$ jointly: pick a compact $C\subseteq W$ for the image, then
take $w_\sigma(s) = \arg\max_{w\in C}\,s\cdot w$ for the aligned-best
selection. By the profile-realization sub-lemma, every such pair
$(C, w_\sigma)$ corresponds to some $\sigma\in\Sigma$. Hence
$\sup_\sigma U(\sigma) = \sup_{C\in\mathcal K(W)}\,F(C)$.

### Lemma 2 (menu existence)

$\sup_{C\in\mathcal K(W)}\,F(C)$ is attained.

\paragraph{Proof.} $\mathcal K(W)$ is compact metrizable in Hausdorff
distance (since $W\subset\R^{|\Omega|}$ is compact). The maps
$C\mapsto\max_{w\in C}\,s\cdot w$ and $C\mapsto\min_{w\in C}\,s\cdot w$
are 1-Lipschitz in $d_H$ uniformly in $s\in\Delta(\Omega)$. Hence
$F(C)$ is continuous in $C$, and a compactness argument gives a
maximizer $C^*\in\mathcal K(W)$.

### Lemma 3 (closure-pruning value preservation)

Let $w^*(m) := \arg\max_{w\in C^*}\,m\cdot w$ (aligned-best labeling;
single-valued $\tau$-a.e., else KRN selects). Set
$C^\dagger := \overline{w^*(M)} \subseteq C^*$. Then $F(C^\dagger) = F(C^*) = U^*$.

\paragraph{Proof.} Aligned term unchanged: $\max_{w\in C^*}\,m\cdot w = m\cdot w^*(m) \le \max_{w\in C^\dagger}\,m\cdot w \le \max_{w\in C^*}\,m\cdot w$,
so $\max_{C^\dagger} = \max_{C^*}$ pointwise. Misaligned term:
$C^\dagger\subseteq C^*\Rightarrow \min_{w\in C^\dagger}\,s\cdot w \ge \min_{w\in C^*}\,s\cdot w$.
Hence $F(C^\dagger) \ge F(C^*)$. But $C^\dagger\in\mathcal K(W)$ and
$C^*$ is a maximizer over $\mathcal K(W)$, so $F(C^\dagger)\le F(C^*)$.
Equality.

### Lemma 4 (ε-adversary realization, unconditional)

For every $\eps>0$, there exists a Borel kernel $\beta_\eps\in B$ with
$U(\beta_\eps,\sigma^*) \le U^* + \eps$.

\paragraph{Proof.} For each $s$, the set
$G_\eps(s) := \{m\in M : s\cdot w^*(m) \le \min_{z\in C^\dagger}\,s\cdot z + \eps\}$
is nonempty (definition of inf) and has Borel-measurable graph. Apply
Jankov–von Neumann (or the measurable maximum theorem 18.19) to get a
Borel selector $m_\eps(s)\in G_\eps(s)$. Set $\beta_\eps(dm\mid s) := \delta_{m_\eps(s)}(dm)$.
Then
$U(\beta_\eps,\sigma^*) = \alpha\int s\cdot w^*(s)\,d\tau + (1-\alpha)\int s\cdot w^*(m_\eps(s))\,d\tau \le \alpha\int s\cdot w^*(s) + (1-\alpha)\int(\min_{z\in C^\dagger}\,s\cdot z + \eps) = U^* + (1-\alpha)\eps$.

### Tier 1a capstone

Lemma 1 + Lemma 2 + profile-realization sub-lemma deliver $\sigma^*\in\Sigma$
with $U(\sigma^*) = U^*$. Lemma 4 delivers ε-adversaries. ∎

## 5. Proof — Tier 1b (under exact-contact)

### Lemma 5 (exact adversary)

Under (exact-contact), there exists Borel $m^*: M\to M$ with
$m^*(s)\in G(s)$ τ-a.e., and $\beta^*(dm\mid s) := \delta_{m^*(s)}(dm)$
satisfies $U(\beta^*,\sigma^*) = U^*$.

\paragraph{Proof.} (exact-contact) gives $G(s)\ne\emptyset$ τ-a.e.
plus a Borel selector $m^*$. By Lemma 3 plus continuity of $z\mapsto s\cdot z$:
$\inf_{m\in M}\,s\cdot w^*(m) = \min_{z\in C^\dagger}\,s\cdot z$,
attained by $m^*(s)$. Hence $U(\beta^*,\sigma^*) = U^*$ exactly.

## 6. Proof — Tier 2 (under exact-contact + menu-Hall)

### Lemma 6 (per-message Bayes-optimality)

Under (exact-contact) + (menu-Hall), $\hat\sigma^*(m)$ is Bayes-optimal
under $P_{\gamma_\alpha}(\cdot\mid m)$ for $q$-a.e. $m$.

\paragraph{Proof.} (menu-Hall) directly states the disintegration
posterior of $\gamma_\alpha$ lies in $B(m)$ q-a.e. By definition of
$B(m)$, $\hat\sigma^*(m)\in\arg\max_{\hat\sigma'}\,U(\hat\sigma',P_{\gamma_\alpha}(\cdot\mid m))$.
When $\alpha>0$, $q\ge\alpha\tau$, so q-a.e. ⇒ τ-a.e.

## 7. Why Tier 2 is necessarily conditional: a sharpness witness

The structural calibration condition (menu-Hall) cannot be derived
from standing + (exact-contact) alone, even with set-valued mixing:

\paragraph{Witness.} $\Omega = \{0,1,2\}$, $A = \{a_0,a_1,a_2\}$
winner-takes-all ($u(a_\omega,\omega) = 1$, $-1$ otherwise), prior
$\mu_0 = (1/3, 1/3, 1/3)$, atomless full-support $\tau$ on
$\Delta(\Omega)$, non-radial trust region $T = \{\mu : \mu(0)\le 0.4\}$.
Compute: $C^\dagger = \{v_0, v_1, v_2\}$ (three vertices), boundary
point $t_0 = (0.4, 0.3, 0.3)$, $G(t_0) = \{m\in M : w^*(m)\in\{v_1,v_2\}\}$
(the plurality-1 and plurality-2 regions). $B(t_0) = \{p : p_0\ge p_1, p_0\ge p_2\}$
(Bayes cone for $a_0$). Source mass arriving at the $t_0$-label comes
from $K_0^- = \{s : s_0\le s_1, s_0\le s_2\}$.

\paragraph{Calibration fails.} Pointwise on $K_0^-$, $s_1 - s_0\ge 0$
and $s_2 - s_0\ge 0$. Conditional source mean $\bar s\in K_0^-$ inherits
both. For $\bar s\in B(t_0)$ we'd need $\bar s_0\ge\bar s_1, \bar s_0\ge\bar s_2$.
Combining: equality in expectation forces pointwise equality, hence
$\bar s = (1/3, 1/3, 1/3)$ a.s. With atomless $\tau$, no positive
source mass concentrates at the uniform prior point. Hence menu-Hall
fails at $t_0$ in this model.

\paragraph{Significance.} The deterministic-vs-set-valued distinction
is **not** the obstruction. Even allowing $\kappa$ to mix over the
two-element rowwise-minimizer set $\{v_1, v_2\}$, the **multi-dimensional
vector balance** between source cone $K_0^-$ and target cone $B(t_0)$
forbids calibration. This is the essential content of the obstruction
behind the v5 TRE-gen-Hall hypothesis.

## 8. Comparison with v5

| Quantity | v5 (Phil-Reny route) | v7 (menu engine) |
|---|---|---|
| Tier 1 hypotheses | standing + A5-thick + A8c-attain | **standing alone** (Tier 1a) |
| Exact β* hypotheses | standing + A5-thick + A8c-attain | standing + **exact-contact** (Tier 1b) |
| Tier 2 hypotheses | + TRE-gen-Hall (deterministic) | + **menu-Hall** (set-valued) |
| Engine | Balder + Mertens + Lusin (infinite-dim) | Hausdorff compactness on $\mathcal K(W)$ ($\R^{|\Omega|}$) |
| Sharpness witness | ternary non-radial Hall violation | same — confirmed sharper here, deterministic-vs-set-valued not the dichotomy |

## 9. Comparison with the paper's finite-case proof

Finite $M, \Theta$: $W$ is the same compact convex set; finite Sion
gives the saddle directly via finite-dim simplex compactness, and
per-message Bayes-optimality follows from the finite minimax. The
infinite-extension's analog of Sion's "convex/concave-affine + compact"
hypothesis is the convex geometry of $W$ — but the calibration step
(matching adversarial messages to Bayes cones) does not come for free
in $|\Omega|\ge 3$ non-radial settings.

## 10. Remaining directions

- **(menu-Hall) under additional structure on $C^\dagger$.** Radial
  symmetry; zonotopal alignment; separability of Bayes cones $B(m)$;
  group-invariant trust regions. Each may force menu-Hall automatically.
  Concrete classes: binary state (paper Appendix A.6 quantile transport);
  spherical (Section 5.2 + Appendix A.10).

- **Closed-graph constructive labelings.** A natural sufficient
  condition for (exact-contact) is that $w^*$ admits a representative
  with closed graph (then $G(s)$ is closed, KRN applies directly
  without Borelization). Identifying which model primitives force this
  is open.

- **Set-valued mixing fine structure.** The fact that mixing over
  $\{v_1, v_2\}$ doesn't help at $t_0$ raises the question: what
  *would* help? Adding extra extreme points to $C^\dagger$ via richer
  agent randomization, or adding extra messages via signal refinement?
  Both are model-side modifications and are open research directions.

## References

- **Dworczak, P. and Smolin, A.** (2026). "Robust Trust." arXiv:2602.09490.
  Specifically: Theorem 1 (Trust Region Solution, §3.2, proof App. A.1)
  for the $W$ set; Theorem 2 (RR Solution, §3.3, finite proof App. A.2);
  §4 (binary state); §5.2 (spherical example); App. A.6 (binary quantile
  transport); App. A.10 (radial Bregman monotonicity).
- **Aliprantis, C. D. and Border, K. C.** (2006). *Infinite Dimensional
  Analysis*, 3rd ed. Springer. Theorems 18.13 (KRN), 18.19 (measurable
  maximum). Hausdorff metric on compact subsets: §17.
- **Bogachev, V. I.** (2007). *Measure Theory*. Standard-Borel
  disintegration; measurable selection infrastructure.

---

*v7 supersedes v5/v6.*
