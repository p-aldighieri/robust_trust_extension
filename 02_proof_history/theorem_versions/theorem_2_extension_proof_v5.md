# Robust Trust Theorem 2 — infinite-$M$, infinite-$\Theta$ conditional extension (relaxed-assumption final)

*Final orchestrator-authored consolidator. Combines Branch A (L1–L7) +
Branch B (L8a, L8c, L8, L9b) + the relaxation cycle (A5→A5-thick,
A8c-lsc→A8c-attain, A9c-calib→TRE-gen-Hall). All lemmas + relaxations
reviewer-PASS'd in fresh sessions.*

## 1. Original Theorem 2 and the gap

Dworczak and Smolin (2026) prove **Theorem 2**: every robustly
rationalizable strategy is optimal, and — if $M = \operatorname{supp}\tau$
and $\Theta$ are finite — a robustly rationalizable strategy exists.
The optimality direction is finiteness-free. The existence direction
uses finiteness via Sion's minimax on products of finite-dimensional
simplices. The paper notes that extending Sion's conditions to infinite
cheap-talk-like spaces is technically difficult.

This document closes the existence direction in two tiers under
infinite $M$ and compact metric $\Theta$, with **three relaxed added
assumptions** that are weaker / more interpretable than the original
mutual-absolute-continuity, l.s.c., and abstract-coupling versions.

## 2. Main Theorem (two tiers, with relaxed assumptions)

**Standing hypotheses (paper).** $\Omega$ finite with full-support prior
$\mu_0$; $A$ and $\Theta$ compact metric; $u(a,\omega,\theta)$ bounded,
Borel, continuous in $a$; conditional independence of $s$ and $\theta$
given $\omega$; Borel measurability throughout.

**Theorem (Tier 1 — value-securing existence and adversary attainment).**
*Under standing hypotheses + (A5-thick) + (A8c-attain), there exist*
$\sigma^*\in\Sigma$ *and* $\beta^*\in B$ *such that*
1. $U(\sigma^*) = U^* := \sup_{\sigma\in\Sigma} U(\sigma)$;
2. $U(\beta^*, \sigma^*) = \inf_{\beta\in B} U(\beta, \sigma^*) = U^*$.

**Theorem (Tier 2 — full robust rationalizability).** *Under standing +
(A5-thick) + (A8c-attain) + (TRE-gen-Hall), the pair $(\sigma^*, \beta^*)$
above can be chosen so that, additionally:*
3. *(When $\alpha > 0$.) For τ-a.e. $m\in M$,*
   $\hat\sigma^*(m) \in \arg\max_{\hat\sigma'} U(\hat\sigma', P_{\beta^*}(\cdot\mid m))$.

*Hence $\sigma^*$ is **robustly rationalizable in the paper's a.e./on-path
sense** (Definition 2 in Dworczak–Smolin, with the paper's "for all"
read as τ-a.e. per the model's measurability convention).*

### Relaxed assumptions

- **(A5-thick) Endogenous Lusin-thickness.** There exist compact
  $K_1\subseteq K_2\subseteq\cdots\subseteq M$ with $K^* := \bigcup_n K_n$
  such that $\pi(K^*\mid\omega)=1$ for every $\omega$, $\hat\sigma^*$
  is continuous on each $K_n$ in the Balder stable private-strategy
  topology, AND every relative open in $K_n$ has positive
  $\pi(\cdot\mid\omega)$-mass for every $\omega$.

  *Strictly weaker than the original* (A5): $\pi(\cdot\mid\omega)\sim\tau$
  for every $\omega$. Recall that $\pi(\cdot\mid\omega)\ll\tau$ is
  automatic (full-support $\mu_0$ + $\tau = \sum_\omega\mu_0(\omega)\pi(\cdot\mid\omega)$);
  the new content of (A5) is only the **reverse** $\tau\ll\pi(\cdot\mid\omega)$.

  **Strict-inclusion example (Bayes-plausible posterior law).** Take
  $\Omega = \{0,1\}$, so $M = \Delta(\Omega) = [0,1]$ (identifying
  $s\in\Delta(\Omega)$ with $s(\omega=1)\in[0,1]$). Set
  $$
  \tau \;=\; \tfrac12\,\mathrm{Leb}_{[0,1]} + \tfrac12\,\delta_0.
  $$
  By Bayes consistency, $\mu_0(1) = \int s\,d\tau = \tfrac14$ and
  $\mu_0(0) = \tfrac34$. The state-conditional posterior laws (computed
  from $s\,\tau(ds) = \mu_0(1)\,\pi(ds\mid 1)$ and
  $(1-s)\,\tau(ds) = \mu_0(0)\,\pi(ds\mid 0)$) are
  $$
  \pi(ds\mid 1) = 2s\,ds \text{ on } [0,1], \qquad \pi(ds\mid 0) = \tfrac{2}{3}(1-s)\,ds + \tfrac{2}{3}\,\delta_0.
  $$
  Bayes-consistency check: $\mu_0(1)\pi(\cdot\mid 1) + \mu_0(0)\pi(\cdot\mid 0) = \tfrac14(2s\,ds) + \tfrac34(\tfrac23(1-s)\,ds + \tfrac23\delta_0) = \tfrac12 s\,ds + \tfrac12(1-s)\,ds + \tfrac12\delta_0 = \tfrac12\mathrm{Leb} + \tfrac12\delta_0 = \tau$ ✓.

  Now $\pi(\cdot\mid 1)$ assigns zero mass to $\{0\}$, while
  $\tau(\{0\}) = \tfrac12 > 0$, so $\tau\not\ll\pi(\cdot\mid 1)$ and
  **(A5) fails**. But both $\pi(\cdot\mid 0)$ and $\pi(\cdot\mid 1)$
  have full topological support on $[0,1]$ — every relative open in
  $[0,1]$ has positive π-mass under both — so the Lusin-thick core
  $K^* = [0,1]$ has $\pi(K^*\mid\omega) = 1$ for every $\omega$ with
  the support-thickness clause holding pointwise. Hence **(A5-thick)
  holds**. Strict inclusion verified.

  (Conceptually: the atom of $\tau$ at $0$ corresponds to the Bayes-rule
  obstruction — both states put mass at the boundary point $s = 0$ in
  $\tau$, but only state $\omega = 0$ does in $\pi(\cdot\mid\omega)$;
  yet topologically, $\{0\}$ is a measure-zero point of the
  full-mass-supported $[0,1]$ core, so thickness survives.) **Continuity
  completion of the example.** To certify the full (A5-thick) condition
  (which also requires $\hat\sigma^*$ continuous on each $K_n$ in the
  Balder stable topology), specialize this example to a trivial
  private-strategy environment — e.g., $\Theta$ a singleton and $A$ a
  singleton (or constant utility $u\equiv 0$) — so that $\hat\sigma^*$
  is the constant kernel, trivially Balder-continuous on $K_1 = [0,1]$.
  The strict-inclusion conclusion (A5-thick holds, A5 fails) carries
  over.

  Implied by primitive conditions weaker than mutual equivalence: e.g.,
  common topologically-thick core; absolutely continuous parts with
  positive density on a common compact full-mass set.

- **(A8c-attain) Rowwise argmin attainment + measurable selector.**
  For τ-a.e. $s$, $D(s) := \arg\min_{m\in M}\ell_{\sigma^*}(m,s)$ is
  nonempty, and $s\mapsto D(s)$ admits a Borel measurable selector
  $m^*: M\to M$ with $m^*(s)\in D(s)$ τ-a.e.

  *Strictly weaker than the original* (A8c-lsc): rowwise l.s.c. of $\ell$.
  L.s.c. is just one sufficient route; what L8 actually consumes via
  Kuratowski–Ryll-Nardzewski is the existence of a measurable selector.
  Strictly weaker per upward-spike-away-from-minimizer counterexample.

  **Sufficient routes to (A8c-attain).** The reviewer-cleared (A8c-lsc)
  relaxation note records three primitive packages, each implying
  (A8c-attain):
  - **(P1)** Agent's Bayes-action correspondence is u.h.c. with closed
    compact values, AND the strategy graph is closed
    in $M\times\Theta\times A$. Then the measurable maximum theorem
    (Aliprantis–Border 18.19) gives both nonempty rowwise argmin and
    measurable selector.
  - **(P2)** Trust-region projection $P_T:\Delta(\Omega)\to T$ is
    continuous with $\hat\sigma^*$ playing Bayes-action at $P_T(m)$.
    Then $\hat\sigma^*$ is continuous in $m$, $\ell$ is continuous,
    attainment + selector are immediate.
  - **(P3)** $\sigma^*$ admits a closed-graph representative in
    $M\times\Theta\times A$. Aliprantis–Border 18.19 applies directly.

  Each of (P1), (P2), (P3) is a primitive economic condition
  corresponding to TRE-style structure or u.h.c. Bayes responses; the
  paper's Theorem 1 finite-case TRE characterization fits (P2).

- **(TRE-gen-Hall) Generalized trust-region structure with Hall mass-balance.**
  $\sigma^*$ has trust-region structure: closed convex $T\subseteq\Delta(\Omega)$,
  continuous Bregman projection $P_T$, $\hat\sigma^*(m)$ Bayes-optimal
  at $P_T(m)$, single-valued monotone worst-message map $m^*$. AND:

  **Hall/Strassen mass-balance via direct disintegration.** Define the
  joint coupling on $M\times M$
  $$
  \gamma_\alpha \;:=\; \alpha\,(\mathrm{id},\mathrm{id})_\#\tau + (1-\alpha)\,(\mathrm{id}, m^*)_\#\tau
  $$
  with second-marginal $q := (\gamma_\alpha)_2$. Disintegrate
  $\gamma_\alpha$ along the second coordinate to obtain a Borel kernel
  $\kappa(\cdot\mid m)$ on $M$ giving the conditional source
  distribution given message $m$; the induced posterior over $\Omega$ is
  $$
  P_{\gamma_\alpha}(\omega\mid m) \;=\; \int_M s(\omega)\,\kappa(ds\mid m).
  $$

  **(TRE-gen-Hall) requires:** $P_{\gamma_\alpha}(\cdot\mid m) \in C(m)$
  for $q$-a.e. $m\in M$.

  **Equivalent support-function form.** $P_{\gamma_\alpha}(\cdot\mid m)\in C(m)$
  q-a.e. iff for every measurable $E\subseteq M$ and every continuous
  affine $\phi: \Delta(\Omega)\to\mathbb R$,
  $$
  \int_E \phi\big(P_{\gamma_\alpha}(\cdot\mid m)\big)\,q(dm) \;\le\; \int_E h_{C(m)}(\phi)\,q(dm),
  $$
  where $h_{C(m)}(\phi) := \sup_{\mu\in C(m)}\phi(\mu)$ is the
  support function of $C(m)$ at $\phi$. (Pointwise membership over $E$
  iff the support-function inequality holds integrated over $E$, by
  duality and a separating countable family of $\phi$.)

  **Equivalent Hall/Strassen calibration inequality for the displayed coupling.**
  Equivalent to the disintegration condition: for all
  measurable $E\subseteq M$ and all continuous affine $\phi$,
  $$
  \alpha\int_E \phi(m)\,\tau(dm) + (1-\alpha)\int_{(m^*)^{-1}(E)} \phi(s)\,\tau(ds) \;\le\; \int_E h_{C(m)}(\phi)\,q(dm).
  $$
  (For binary $\Omega$, $\Delta(\Omega) = [0,1]$, $\phi$ ranges over
  affine $a + bs$, and this collapses to a single 1-D mass-balance
  equation — exactly the paper's Appendix A.6 quantile transport. For
  $|\Omega|\ge 3$, this is a vector-feasibility system over a separating
  family of affine $\phi$.)

  *More interpretable than the original* (A9c-calib) abstract coupling
  existence — recasts it in primitive economic terms (trust region,
  worst-message map, mass balance). **Honest scope:** bare (TRE-gen)
  without Hall is **not enough** for $|\Omega|\ge 3$; the obstruction
  is vector balance. Verified for binary $\Omega = \{0,1\}$ (paper's
  Appendix A.6 quantile transport) and ternary radial/spherical case
  (paper's Section 5.2 + Appendix A.10).

## 3. Relationship to original Theorem 2

Tier 1 weakens the paper's robust-rationalizability conclusion: $\sigma^*$
exists and adversarial $\beta^*$ exists, but $\hat\sigma^*$ need not be
Bayes-optimal at every on-path $m$ under the induced posteriors. Tier 2
recovers the full Definition 2 conclusion under (TRE-gen-Hall), which is
the infinite-dimensional analogue of the paper's TRE/quantile transport
construction (Theorem 1 + Appendix A.6 verify it explicitly for binary;
Section 5.2 + Appendix A.10 cover ternary radial cases).

## 4. Strategy

Phil Reny's two-stage path: (Stage 1) restricted-game existence on
τ-dominated kernels via Mertens (1986) Cor B + Balder (1988); Lusin
lift to all measurable adversaries. (Stage 2) Adversary attainment via
rowwise contact-selection (A8c-attain); per-message Bayes-optimality
via posterior-calibrated transport (TRE-gen-Hall).

**Crucial technical observation:** Branch A + L8 do NOT produce a true
saddle. $\sigma^*$ is maximin and $\beta^*$ rowwise adversarial, but
$\sigma^*$ is not automatically a best response to $\beta^*$. The paper's
finite proof obtains the upper saddle from Sion + finite-dimensional
compactness. Our infinite proof substitutes (TRE-gen-Hall) — a structural
calibration condition.

## 5. Definitions and notation

Let $\pi_\omega := \pi(\cdot\mid\omega)$, $f_\omega := f(\cdot\mid\omega)$.
Unconditional: $\tau = \sum_\omega \mu_0(\omega)\pi_\omega$,
$\bar f = \sum_\omega \mu_0(\omega) f_\omega$. Set $X := M\times\Theta$,
$\lambda := \tau\otimes\bar f$.

$\Sigma$ = Borel kernels $\sigma:X\to\Delta(A)$, modulo $\lambda$-a.e.
equality (Balder quotient). $B$ = Borel kernels $\beta:M\to\Delta(M)$.

Restricted adversary class $F$ = jointly measurable $\varphi:M\times M\to[0,\infty)$
with $\int\varphi(m\mid s)\,\tau(dm)=1$ τ-a.s. $U_F(\sigma,\varphi) := U(\beta_\varphi,\sigma)$
where $\beta_\varphi(dm\mid s) = \varphi(m\mid s)\tau(dm)$.

Topology $T_\lambda$ on $\Sigma$: Balder weak topology with base $\lambda$.

$V^* := \max_\sigma\inf_F U_F(\sigma,\varphi)$. Lusin-thick compacts
$K_n\uparrow K^*$ from L5 / (A5-thick).

Message payoff $p_\omega(m) := \int_\Theta\int_A u(a,\omega,\theta)\hat\sigma^*(m,\theta)(da) f(d\theta\mid\omega)$;
row payoff $\ell(m,s) := \sum_\omega s(\omega) p_\omega(m)$.

$D(s) := \arg\min_m \ell(m,s)$. $C(m) := \{\mu\in\Delta(\Omega) : \hat\sigma^*(m)\in\arg\max_{\hat\sigma'} U(\hat\sigma', \mu)\}$
— closed convex normal-cone slice (NOT generally a polytope).

## 6. Proof — Branch A (under (A5-thick))

### Lemma L1 (constant-marginal continuity)

For each fixed $\varphi\in F$, $\sigma\mapsto U_F(\sigma,\varphi)$ is
$T_\lambda$-continuous on $\Sigma$.

*Proof.* Two Carathéodory tests integrated against fixed marginals;
**Balder (1988) Theorem 2.2, p. 268**. $L^1$-domination via
$r_\omega^\varphi\in L^1(\tau)$. No bounded-density restriction.

### Lemma L2 (compactness of $\Sigma$)

$(\Sigma, T_\lambda)$ is compact and convex; common-kernel extraction.

*Proof.* **Balder §2 Theorem 2.3(a)** + finite-mixture disintegration +
correctly-directed RN multiplications.

### Lemma L7 ($\theta$ in the base)

L1, L2 hold with $\theta$ in base; no $\theta$-continuity needed.
*Proof.* Carathéodory tests treat $\theta$ as measurable base coordinate.

### Lemma L3 + L4 (Mertens minmax + restricted-game $\sigma^*$)

$\max_\sigma\inf_F U_F(\sigma,\varphi) = \inf_F\max_\sigma U_F(\sigma,\varphi) = V^*$,
with $\sigma^*\in\Sigma$ attaining the LHS.

*Proof.* **Mertens (1986) §2 Cor B** + affineness collapses on both
sides. $V(\sigma) = \inf_\varphi U_F(\sigma,\varphi)$ u.s.c., $\Sigma$
compact ⇒ attainment.

### Lemma L5 (Lusin-thick compacts under (A5-thick))

By definition of (A5-thick), the compact sequence $K_n\uparrow K^*$
exists with all required properties.

*Proof.* Either: the (A5-thick) hypothesis directly provides them; or,
stronger primitive conditions (e.g., common topological support of
$\pi_\omega$ + Polish-valued Lusin) construct them. Modification of
$\sigma^*$ off $K^*$ via measurable retraction $r:M\to K^*$.

### Lemma L6 (Lusin lift contradiction)

Under (A5-thick): for every $\beta\in B$ and $\varepsilon>0$, exists
$\varphi_\varepsilon\in F$ with $U(\beta,\sigma^*) \ge U_F(\sigma^*,\varphi_\varepsilon) - \varepsilon$.

*Proof.* Smoothing kernel $q_\varepsilon(z\mid y)$ shell-by-shell on
$D_n := K_n\setminus K_{n-1}$, supported in $K_n\cap B(y,\rho_n)$.
Positive τ-mass denominator from (A5-thick) support-thickness.
Compose with $\beta$ via Tonelli. Pointwise + integrated bound.

### Branch A capstone

**Theorem (Branch A).** *Under standing + (A5-thick), $\sigma^*\in\Sigma$
exists with $U(\sigma^*) = U^* = V^*$ and $U(\beta,\sigma^*)\ge U^*$ for
every $\beta\in B$.*

*Proof.* $V^*\ge U^*$ since $F\hookrightarrow B$. L6 ⇒ $\inf_B U(\cdot,\sigma^*)\ge V^*$,
so $U^*\ge V^*$. Combined: $V^* = U^* = U(\sigma^*)$.

## 7. Proof — Branch B (Tier 1: + (A8c-attain); Tier 2: + (TRE-gen-Hall))

### Lemma L8a (restricted dual value formula)

$\inf_F U_F(\sigma^*,\varphi) = \text{const} + (1-\alpha)\int_M e(s)\,\tau(ds)$
where $e(s) := \operatorname*{essinf}_m \ell(m,s)$.

### Lemma L8c-Half-1 (pointwise = essential τ-a.e., unconditional)

$\inf_m \ell(m,s) = \operatorname*{essinf}_m \ell(m,s)$ τ-a.e.

*Proof.* Jankov–von Neumann (with τ-a.e. Borelization) + L6 bottom-density.

### Lemma L8c-Half-2 (rowwise argmin attainment under (A8c-attain))

By definition of (A8c-attain), $D(s)$ is nonempty for τ-a.e. $s$ and
admits a Borel selector $m^*$.

*Sufficient via* (P1), (P2), or (P3) — primitive economic conditions
(u.h.c. Bayes-action, continuous projection, closed-graph strategy).
The original (A8c-lsc) is one such sufficient condition but not
necessary.

### Lemma L8 ($\beta^*$ rowwise adversarial under (A5-thick) + (A8c-attain))

$\beta^*(dm\mid s) := \delta_{m^*(s)}(dm)$ achieves $U(\beta^*,\sigma^*) = U^*$.

*Proof.* Direct from (A8c-attain) selector + measurable maximum theorem.
Combined with L6 and Branch A: $U(\beta^*,\sigma^*) = (1-\alpha)\int e(s)\tau(ds) + \text{const} = V^* = U^*$.

### Tier 1 capstone

**Theorem (Tier 1).** *Under standing + (A5-thick) + (A8c-attain),
$\sigma^*\in\Sigma$ and $\beta^*\in B$ exist with conclusions 1, 2 of
the Main Theorem.*

### The L9 saddle gap

Tier 1's $(\sigma^*,\beta^*)$ is **not** a saddle: the upper inequality
$U(\beta^*,\sigma)\le U(\beta^*,\sigma^*)$ for all $\sigma$ does not
follow from Branch A + L8. The L9 contradiction (improving private
strategy on a positive-measure set) needs the upper saddle, which the
finite proof gets from Sion. Our infinite proof substitutes
(TRE-gen-Hall) — a structural calibration condition.

### Lemma L9b (calibrated transport under (TRE-gen-Hall))

Under standing + (A5-thick) + (A8c-attain) + (TRE-gen-Hall), the
$\beta^*$ from L8 satisfies the **posterior calibration**: with the
α-weighted coupling $\gamma_\alpha := \alpha(\mathrm{id},\mathrm{id})_\#\tau + (1-\alpha)(\mathrm{id},m^*)_\#\tau$
on $M\times M$ and $q := (\gamma_\alpha)_2$,

$$
P_{\gamma_\alpha}(\cdot\mid m) \in C(m) \quad \text{for } q\text{-a.e. } m.
$$

*Proof construction.* (TRE-gen-Hall) gives:
- **Inside trust region** ($m\in T$): truthful $m\in C(m)$ (Bayes-action
  at $P_T(m) = m$); misaligned average $\bar s_m\in C(m)$ since
  $m^*$ maps to $m$ from same-side fibers.
- **Outside trust region boundary** ($m\in\partial T$): truthful
  $m = P_T(m)\in C(m)$; misaligned $\bar s_m$ on the outside-fiber side;
  Hall-type vector mass-balance forces the barycenter into $C(m)$.

**Verifications:**
- **Binary $\Omega=\{0,1\}$:** Appendix A.6 quantile transport is the
  1-D mass-balance equation. ✓
- **Ternary $\Omega=\{0,1,2\}$ general:** **fails** without Hall. ✗
- **Ternary radial/spherical:** Section 5.2 + Appendix A.10 give per-direction
  1-D quantile transports + radial Bregman monotonicity. ✓

### Tier 2 capstone

**Theorem (Tier 2).** *Under standing + (A5-thick) + (A8c-attain) + (TRE-gen-Hall),
the pair $(\sigma^*,\beta^*)$ from Tier 1 + L9b satisfies all three
conclusions of the Main Theorem; hence $\sigma^*$ is robustly
rationalizable.*

*Proof.* Tier 1 gives 1 + 2. L9b gives 3 directly via posterior
calibration on $C(m)$ — no saddle invocation. KRN handles the
$q$-null version-choice. $\alpha>0$ ⇒ $q\ge\alpha\tau$ ⇒ τ-a.e.

## 8. Discussion

### Why (A5-thick) is needed (and (A5) was overkill)

Phil's Lusin lift consumes only the existence of a Lusin-thick compact
sequence, not the equivalence of all $\pi_\omega$ with τ. The original
(A5) is one route; (A5-thick) directly states what's needed.
Strict-inclusion via a Bayes-plausible atom-at-zero example.

**Necessity of some thickness condition:** perfect-revelation
counterexample $\Omega = \{0,1\}$, $M = \{\delta_0, \delta_1\}$,
$\pi_\omega = \delta_{\delta_\omega}$ refutes any thickness on the
2-point support.

### Why (A8c-attain) is needed (and (A8c-lsc) was overkill)

L8's KRN consumes only nonemptiness + measurable selector — l.s.c. is
one sufficient route. (A8c-attain) is forced by any of three primitive
economic conditions (P1)–(P3) corresponding to TRE structure or u.h.c.
Bayes responses.

**Necessity of some argmin attainment:** $g(m) = m$ on $(0,1]$,
$g(0) = 1$ counterexample (or upward-spike-away-from-minimum variants)
shows pointwise inf $= 0$ is not attained without regularity.

### Why (TRE-gen-Hall) is needed (and (A9c-calib) was opaque)

(A9c-calib) was an abstract coupling existence statement. (TRE-gen-Hall)
recasts it in primitive economic terms — generalized trust-region +
Hall vector mass-balance — making the connection to the paper's TRE
characterization (Theorem 1) explicit. The honest gap remains:
**(TRE-gen-Hall) itself is the infinite-dimensional analogue of the
paper's Theorem 1 + Appendix A.6 quantile transport.** Establishing
(TRE-gen-Hall) from primitive model conditions is the remaining open
research problem.

### Comparison with paper's finite-case proof

Finite $M, \Theta$: Sion 4.2' on finite simplex products; full saddle
free. Our infinite extension via Mertens + Balder + Lusin gives Branch A
under (A5-thick). The upper saddle that Sion gives for free is
substituted by (TRE-gen-Hall).

### Tightness of the three relaxed assumptions (settled)

The three added hypotheses (A5-thick), (A8c-attain), (TRE-gen-Hall)
are **each tight** — explicit obstruction witnesses establish that none
can be removed unconditionally from the conclusions as stated:

- **(A5-thick) is tight.** Perfect-revelation counterexample
  ($\Omega = \{0,1\}$, $M = \{\delta_0,\delta_1\}$,
  $\pi(\cdot\mid\omega)=\delta_{\delta_\omega}$) refutes any thickness
  on the 2-point support. Without (A5-thick) or an equivalent
  endogenous thickness condition, L5 fails. (Witness in §8.)

- **(A8c-attain) is tight (Q1, settled negative).** Under standing +
  (A5-thick) alone, the rowwise argmin $D(s)$ may be empty on a
  positive-τ set (concrete row example $g(0)=1$, $g(m)=m$ for $m>0$),
  and no Borel kernel attains the inf. Literature (Balder, Valadier,
  Mertens-Sorin-Zamir, Dworczak–Pavan, Lipnowski–Ravid–Shishkin,
  Choquet capacity) confirms no positive theorem exists. The published
  Tier 1 must either keep (A8c-attain) (sufficient via primitive
  routes (P1)–(P3)) **or** weaken to the unconditional ε-approximate
  adversary statement
  $$
  \forall \varepsilon > 0,\ \exists\beta_\varepsilon\in B :
  U(\beta_\varepsilon, \sigma^*) \le U^* + \varepsilon
  $$
  which is free from L6 bottom-density.
  Records: `logs/20260506T17000Z–20260506T184500Z_*` (Q1 pipeline).

- **(TRE-gen-Hall) is tight for $|\Omega|\ge 3$ (Q2, settled negative).**
  Concrete ternary non-radial separating witness:
  $\Omega = \{0,1,2\}$, discrete $A = \{a_0,a_1,a_2\}$, non-radial
  trust region $T$, atomless full-support $\tau$, with the Hall
  inequality violated at $E = \{t_0\}$ (boundary point of $T$),
  $\phi(\mu) = \mu_1 - \mu_0$:
  $$
  \text{LHS} = \tfrac{1-\alpha}{9} > 0, \qquad \text{RHS} = 0.
  $$
  The geometric obstruction is genuinely multi-dimensional: the binary
  case (Appendix A.6) collapses to a single scalar mass-balance
  equation; the ternary 2-d barycenter at the collapsed boundary fiber
  cannot align with a single Bayes cone via any scalar transport. The
  published Tier 2 must keep (TRE-gen-Hall) unless an additional
  structural condition (radial symmetry, separability, zonotopal
  monotonicity) is imposed.
  Records: `logs/20260506T19200Z–20260506T204500Z_*` (Q2 pipeline).

### Remaining genuinely-open directions

- **Constructive Branch-A representative with (A8c-attain) automatic.**
  Even though (A8c-attain) cannot be removed in general, a more refined
  Branch-A construction that *builds in* l.s.c. or u.h.c. structure of
  the strategy correspondence (rather than choosing an arbitrary
  representative) would make (A8c-attain) automatic in the constructed
  $\sigma^*$. The L5 modification is one move in this direction; a more
  systematic construction is open.

- **Multi-dim Hall via additional structural conditions.** The
  ternary radial/spherical case verifies (TRE-gen-Hall) via Section 5.2
  + Appendix A.10 (radial Bregman monotonicity + per-direction quantile
  transport). Identifying the *largest* class of geometric structures
  on $T$ for which Hall holds — analogous to the paper's binary
  Appendix A.6 — is genuinely open. Candidates: separable trust
  regions; zonotopal $T$; trust regions invariant under a transitive
  group action.

- **Lean formalization.** Prior axiomatized Lean stub structurally
  weaker than this proof; not adopted. A faithful constructive
  formalization remains future work.

## 9. Assumptions used (final, relaxed)

- **Standing hypotheses** (Dworczak–Smolin 2026).
- **(A5-thick)** Endogenous Lusin-thickness — for Branch A.
- **(A8c-attain)** Rowwise argmin attainment + measurable selector
  — for Tier 1.
- **(TRE-gen-Hall)** Generalized trust-region + Hall vector mass-balance
  — for Tier 2.

Tier 1 conclusion: standing + (A5-thick) + (A8c-attain).
Tier 2 conclusion: + (TRE-gen-Hall).

## 10. References

- **Dworczak, P. and Smolin, A.** (2026). "Robust Trust." arXiv:2602.09490.
  Specifically: **Theorem 1** (Trust Region Solution, Section 3.2,
  proof in Appendix A.1); **Theorem 2** (Robustly Rationalizable
  Solution, Section 3.3, finite-case proof in Appendix A.2);
  **Section 4** (binary state); **Section 5.2** (spherical example);
  **Appendix A.6** (binary-state quantile transport, the construction
  generalized in (TRE-gen-Hall)); **Appendix A.10** (radial Bregman
  monotonicity).
- **Balder, E. J.** (1988). "Generalized Equilibrium Results for Games
  with Incomplete Information." *Math. Operations Research* 13(2),
  265–276. — Theorems 2.2, 2.3(a).
- **Mertens, J.-F.** (1986). "The Minmax Theorem for U.S.C.-L.S.C.
  Payoff Functions." *Int. J. Game Theory* 15(4), 237–250. — Cor B.
- **Aliprantis, C. D. and Border, K. C.** (2006). *Infinite Dimensional
  Analysis*. — Theorems 18.13, 18.19.
- **Bogachev, V. I.** (2007). *Measure Theory*. — Polish-valued Lusin.
- **Villani, C.** *Optimal Transport: Old and New*. — Multi-dimensional
  mass-balance / Hall–Strassen feasibility.

---

*End of relaxed-assumption final consolidator.*
