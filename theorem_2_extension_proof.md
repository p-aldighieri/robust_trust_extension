# Robust Trust Theorem 2 — infinite-$M$, infinite-$\Theta$ conditional extension

*Final orchestrator-authored consolidator. Combines the L1–L7 Branch A
proofs (reviewer-PASS'd) with the corrected L8/L8c/L9b Branch B
treatment that resolves the L9 saddle gap.*

## 1. Original Theorem 2 and the gap

Dworczak and Smolin (2026) prove **Theorem 2**: every robustly
rationalizable strategy is optimal, and — if $M = \operatorname{supp}\tau$
and $\Theta$ are finite — a robustly rationalizable strategy exists.
The optimality direction is a saddle-point verification and is
finiteness-free. The existence direction uses finiteness: Appendix A.2
expresses payoffs as finite sums, applies Sion's minimax theorem to
products of finite-dimensional simplices, and constructs the saddle
$(\sigma^*, \beta^*)$. The paper explicitly notes that extending Sion's
conditions to infinite cheap-talk-like strategy spaces is technically
difficult because messages affect payoffs endogenously.

This document closes the existence direction in two tiers under
infinite $M$ and compact metric $\Theta$, with explicit added
assumptions.

## 2. Main Theorem (two tiers)

**Standing hypotheses (paper).** $\Omega$ finite with full-support prior
$\mu_0$; $A$ and $\Theta$ compact metric; $u(a,\omega,\theta)$ bounded,
Borel, continuous in $a$; conditional independence of $s$ and $\theta$
given $\omega$; Borel measurability throughout.

**Theorem (Tier 1 — value-securing existence and adversary attainment).**
*Under standing hypotheses + (A5) + (A8c-lsc), there exist*
$\sigma^*\in\Sigma$ *and* $\beta^*\in B$ *such that*
1. $U(\sigma^*) = U^* := \sup_{\sigma\in\Sigma} U(\sigma)$ *(σ* attains the
   robust value);
2. $U(\beta^*, \sigma^*) = \inf_{\beta\in B} U(\beta, \sigma^*) = U^*$
   *(β\* is adversarial against σ\*).*

**Theorem (Tier 2 — full robust rationalizability).** *Under standing
hypotheses + (A5) + (A8c-lsc) + (A9c-calib), the pair $(\sigma^*, \beta^*)$
above can be chosen so that, additionally:*
3. *(When $\alpha > 0$.) For τ-a.e. $m\in M$,*
   $\hat\sigma^*(m) \in \arg\max_{\hat\sigma'} U(\hat\sigma', P_{\beta^*}(\cdot\mid m))$.

*Hence $\sigma^*$ is **robustly rationalizable** in the sense of
Definition 2 in Dworczak–Smolin, in the paper's a.e./on-path reading.*

**Added assumptions.**
- **(A5) Common posterior null sets.** $\pi(\cdot\mid\omega) \sim \tau$
  for every $\omega\in\Omega$. The forward direction
  $\pi(\cdot\mid\omega)\ll\tau$ is automatic from full-support $\mu_0$;
  only the reverse $\tau\ll\pi(\cdot\mid\omega)$ is new.
- **(A8c-lsc) Rowwise lower semicontinuity.** For the Branch-A
  maximizer's value-preserving representative, $m\mapsto\ell_{\sigma^*}(m,s) := \sum_\omega s(\omega) p_\omega(m)$
  is lower semicontinuous on $M$ for τ-a.e. $s$.
- **(A9c-calib) Calibrated worst-message transport.** There exists a
  coupling $\gamma\in\Delta(M\times M)$ with first marginal τ,
  disintegrating as $\gamma(ds,dm) = \tau(ds)\,\beta^*(dm\mid s)$, such
  that:
  - **Adversariality:** the support of $\beta^*(\cdot\mid s)$ lies in
    $D(s) := \arg\min_{m\in M}\ell_{\sigma^*}(m,s)$ for τ-a.e. $s$.
  - **Posterior calibration:** with the full $\alpha$-weighted coupling
    $\gamma_\alpha := \alpha\,(\mathrm{id},\mathrm{id})_\#\tau + (1-\alpha)\,\gamma$
    on $M\times M$, and message marginal $q := (\gamma_\alpha)_2$, the
    posterior $P_{\gamma_\alpha}(\cdot\mid m) \in C(m)$ for $q$-a.e. $m$,
    where $C(m) := \{\mu\in\Delta(\Omega) : \hat\sigma^*(m)\in\arg\max_{\hat\sigma'} U(\hat\sigma', \mu)\}$.

## 3. Relationship to the original Theorem 2

Tier 1 weakens the paper's robust-rationalizability conclusion:
$\sigma^*$ exists and an adversarial $\beta^*$ exists, but $\hat\sigma^*$
need not be Bayes-optimal at every on-path $m$ under the induced
posteriors. Tier 2 recovers the full Definition 2 conclusion under the
posterior-calibration hypothesis (A9c-calib), which is the
infinite-dimensional analogue of the paper's TRE/quantile transport
construction (Appendix A.6 verifies it explicitly for the binary
quadratic case).

## 4. Strategy

Phil Reny's two-stage path: (Stage 1) restricted-game existence on
$\tau$-dominated kernels via Mertens (1986) Cor B + Balder (1988); Lusin
lift to all measurable adversaries. (Stage 2) Adversary attainment via
rowwise contact-selection under (A8c-lsc); per-message Bayes-optimality
via posterior-calibrated transport under (A9c-calib).

**Critically:** the two-stage path does NOT produce a true saddle from
Branch A + L8c alone. $\sigma^*$ is maximin and $\beta^*$ is rowwise
adversarial against $\sigma^*$, but $\sigma^*$ is not automatically a
best response to $\beta^*$. The paper's finite proof obtains the upper
saddle inequality from Sion + finite-dimensional compactness; we
substitute it with (A9c-calib).

## 5. Definitions and notation

Let $\pi_\omega := \pi(\cdot\mid\omega)$ be the state-conditional law of
the adviser posterior $s\in M$, $f_\omega := f(\cdot\mid\omega)$ the
state-conditional law of the agent type $\theta$. Unconditional laws:
$\tau = \sum_\omega \mu_0(\omega)\pi_\omega$,
$\bar f = \sum_\omega \mu_0(\omega) f_\omega$. Set $X := M\times\Theta$,
$\lambda := \tau\otimes\bar f$.

Agent strategies $\Sigma$ = Borel kernels $\sigma:X\to\Delta(A)$, modulo
$\lambda$-a.e. equality (Balder quotient). Misaligned-adviser strategies
$B$ = Borel kernels $\beta:M\to\Delta(M)$.

Restricted adversary class $F$ = jointly measurable $\varphi:M\times M\to[0,\infty)$
with $\int_M\varphi(m\mid s)\,\tau(dm) = 1$ for τ-a.e. $s$. Restricted
kernel: $\beta_\varphi(dm\mid s) = \varphi(m\mid s)\,\tau(dm)$. Restricted
payoff $U_F(\sigma,\varphi) := U(\beta_\varphi, \sigma)$.

Topology $T_\lambda$ on $\Sigma$: Balder weak topology on transition
probabilities with base $\lambda$.

Restricted-game value $V^* := \max_\sigma\inf_F U_F(\sigma,\varphi)$.

Lusin-thick compacts $K_n\uparrow K^*\subseteq M$ from L5.

Message payoff $p_\omega(m) := \int_\Theta\int_A u(a,\omega,\theta)\hat\sigma^*(m,\theta)(da) f(d\theta\mid\omega)$;
row payoff $\ell(m,s) := \sum_\omega s(\omega) p_\omega(m)$.

Argmin set $D(s) := \arg\min_m \ell(m,s)$ (closed under (A8c-lsc), not
generally convex).

Bayes-optimal-belief set
$C(m) := \{\mu\in\Delta(\Omega) : \hat\sigma^*(m)\in\arg\max_{\hat\sigma'} U(\hat\sigma', \mu)\}$
— closed convex normal-cone slice of the agent's payoff frontier (NOT
generally a polytope).

## 6. Proof — Branch A: existence of optimal $\sigma^*$ under (A5)

### Lemma L1 (constant-marginal continuity)

**Statement.** For each fixed $\varphi\in F$, $\sigma\mapsto U_F(\sigma,\varphi)$
is $T_\lambda$-continuous on $\Sigma$.

**Proof sketch.** The aligned and misaligned terms each integrate a
Carathéodory test (measurable in base, continuous in $a$, $L^1$-dominated)
against a fixed marginal. Apply **Balder (1988) Theorem 2.2, p. 268**.
The misaligned term's $L^1$-domination uses $r_\omega^\varphi := \int_M\varphi(\cdot\mid s)\,\pi_\omega(ds) \in L^1(\tau)$,
which holds by $\pi_\omega\ll\tau$ + Tonelli; no bounded-density
restriction needed.

### Lemma L2 (compactness of $\Sigma$)

**Statement.** $(\Sigma, T_\lambda)$ is compact and convex; every
simultaneous limit of $\omega$-indexed marginals is induced by a single
common kernel.

**Proof sketch.** Compactness via **Balder §2 Theorem 2.3(a)** applied
to finite base $\lambda$ and compact metric target $A$. Common-kernel
extraction: form the finite mixture $Q := \sum_\omega \mu_0(\omega)Q_\omega^\tau$,
disintegrate on standard Borel $X\times A$, recover $\omega$-indexed
marginals via correctly-directed Radon-Nikodym multiplications
(densities $\frac{d\lambda_\omega^\tau}{d\lambda}, \frac{d\pi_\omega}{d\tau},
\frac{df_\omega}{d\bar f}$, all bounded by $\mu_0(\omega)^{-1}$).

### Lemma L7 ($\theta$ in the base)

**Statement.** L1 and L2 hold with $\theta$ in the Balder base coordinate
$x = (m,\theta)$; no $\theta$-continuity needed.

**Proof sketch.** Verification: Carathéodory tests treat $\theta$ as
a measurable base coordinate; standard-Borel disintegration gives the
kernel/family equivalence $\sigma:M\times\Theta\to\Delta(A) \leftrightarrow \hat\sigma(m):\Theta\to\Delta(A)$.

### Lemma L3 + L4 (Mertens minmax + restricted-game $\sigma^*$)

**Statement.** $\max_\sigma\inf_F U_F(\sigma,\varphi) = \inf_F\max_\sigma U_F(\sigma,\varphi) = V^*$,
and $\sigma^*\in\Sigma$ exists attaining the LHS.

**Proof sketch.** Apply **Mertens (1986) §2 Cor B (p. 238)** with
compact Hausdorff $S = \Sigma$ (in $T_\lambda$ Balder quotient),
arbitrary $T = F$, $f = U_F$ continuous in $\sigma$ (L1) and bounded.
Both mixed-strategy sides collapse by affineness: $F$-side via convex
combination = barycenter in $F$; $\Sigma$-side via barycenter in
compact convex Hausdorff locally convex Balder quotient.

Attainment: $V(\sigma) := \inf_\varphi U_F(\sigma,\varphi)$ is u.s.c.
(inf of continuous), $\Sigma$ compact ⇒ $\sigma^*\in\arg\max V$ exists.

### Lemma L5 (Lusin-thick compacts under (A5))

**Statement.** Under (A5): there exist compact $K_1\subseteq K_2\subseteq\cdots\subseteq M$
with $K^* = \bigcup_n K_n$, $\pi_\omega(K^*) = 1$ for every $\omega$,
$\hat\sigma^*$ continuous on each $K_n$ in the Balder stable
private-strategy topology on $K_{\bar f}(\Theta, A)$, AND **support-thick**:
every relative open in $K_n$ has positive $\pi_\omega$-measure for
every $\omega$.

**Proof sketch.** Polish-valued Lusin (Bogachev §7.1.13) on
$h:M\to Y$ where $Y = K_{\bar f}(\Theta, A)$ (compact metrizable).
Common-support construction $K_n := \operatorname{supp}(\tau\restriction C_n)$
under (A5). Modification of $\sigma^*$ off $K^*$ via measurable
retraction $r:M\to K^*$.

**Necessity of (A5):** perfect-revelation counterexample
$\Omega = \{0,1\}$, $M = \{\delta_0, \delta_1\}$, $\pi_\omega = \delta_{\delta_\omega}$.

### Lemma L6 (Lusin lift contradiction)

**Statement.** Under (A5): for every $\beta\in B$ and every $\varepsilon>0$,
there exists $\varphi_\varepsilon\in F$ with
$U(\beta,\sigma^*) \ge U_F(\sigma^*,\varphi_\varepsilon) - \varepsilon$.
Hence $\inf_{\beta\in B} U(\beta,\sigma^*) \ge V^*$.

**Proof sketch.** Build smoothing kernel $q_\varepsilon(z\mid y)$
shell-by-shell on $D_n := K_n\setminus K_{n-1}$, supported in
$K_n\cap B(y, \rho_n)$, with positive τ-mass denominator from
support-thickness. Compose with $\beta$ via Tonelli to get
$\varphi_\varepsilon\in F$. Pointwise + integrated bound
$|U(\beta,\sigma^*) - U_F(\sigma^*,\varphi_\varepsilon)| \le (1-\alpha)\varepsilon$.

### Branch A capstone

**Theorem (Branch A).** *Under standing + (A5), $\sigma^*\in\Sigma$
exists with $U(\sigma^*) = U^* = V^*$ and $U(\beta,\sigma^*)\ge U^*$ for
every $\beta\in B$.*

**Proof.** $V^* \ge U^*$ since $F\hookrightarrow B$ (inf over a smaller
set). L6 gives $\inf_B U(\cdot,\sigma^*) \ge V^*$, so $U^* \ge V^*$.
Combined: $V^* = U^* = U(\sigma^*) = \inf_B U(\beta,\sigma^*)$.

## 7. Proof — Branch B: adversary attainment and Bayes-optimality

### Lemma L8a (restricted dual value formula)

**Statement.** $\inf_F U_F(\sigma^*,\varphi) = \text{const} + (1-\alpha)\int_M e(s)\,\tau(ds)$
where $e(s) := \operatorname*{essinf}_m \ell_{\sigma^*}(m,s)$.

**Proof sketch.** Lower bound row-by-row; upper bound via
$\varphi_n(m\mid s) := \mathbf 1_{A_n(s)}(m)/\tau(A_n(s))$ for
$A_n(s) := \{m: \ell(m,s) \le e(s) + 1/n\}$.

**Necessary and sufficient attainment criterion (A8-flat) — generally fails.**
$\inf_F U_F(\sigma^*,\varphi)$ attained in $F$ iff $\tau(Z(s))>0$ τ-a.e.
where $Z(s) := \{m: \ell(m,s) = e(s)\}$. Generically $Z(s)$ is a
singleton or τ-null (e.g., $\ell(m,s) = m^2$ on $[0,1]$ has $Z(s) = \{0\}$,
τ-null). Hence the restricted-dual barycenter bridge does not close
unconditionally; pivot to (A8c-lsc).

### Lemma L8c-Half-1 (pointwise = essential τ-a.e.)

**Statement.** $\inf_m \ell(m,s) = \operatorname*{essinf}_m \ell(m,s)$
for τ-a.e. $s$.

**Proof sketch.** $a(s) := \inf_m\ell(m,s) \le e(s)$ pointwise.
Jankov–von Neumann (with τ-a.e. Borelization) gives a measurable
$d_n:M\to M$ with $\ell(d_n(s),s) \le a(s) + 1/n$, hence
$\inf_B U(\cdot,\sigma^*) - \text{const} = (1-\alpha)\int a\,d\tau$. L6
+ L8a give $\inf_B = \inf_F$, so $\int a = \int e$. Combined with
$a\le e$: $a = e$ τ-a.e.

### Lemma L8c-Half-2 (pointwise attainment under (A8c-lsc))

**Statement.** Under (A8c-lsc), the pointwise infimum is attained: $D(s) = \arg\min_m \ell(m,s) \neq \emptyset$
for τ-a.e. $s$, and is closed.

**Proof sketch.** L.s.c. function on compact $M$ attains its min;
sublevel sets at the min are closed. Without (A8c-lsc), attainment
fails (counterexample: $g(m) = m$ for $m>0$, $g(0) = 1$, with full
model realization).

### Lemma L8 ($\beta^*$ rowwise adversarial under (A8c-lsc))

**Statement.** Under (A8c-lsc), there exists Borel $m^*: M\to M$ with
$m^*(s)\in D(s)$ τ-a.e., and $\beta^*(dm\mid s) := \delta_{m^*(s)}(dm)$
satisfies $U(\beta^*,\sigma^*) = U^* = \inf_{\beta\in B} U(\beta,\sigma^*)$.

**Proof sketch.** Measurable minimum theorem for Borel normal
integrands (Aliprantis–Border 18.19) gives measurable $a(s)$ and
weakly measurable closed-valued correspondence $s\mapsto D(s)$.
Kuratowski–Ryll-Nardzewski (AB 18.13) gives Borel selector $m^*$.
$\beta^*$ achieves the inf rowwise.

### The L9 saddle gap

**Branch A + L8 do NOT give a saddle.** They give:
- $\sigma^*\in\arg\max_\sigma\inf_\beta U(\beta,\sigma)$ (maximin).
- $U(\beta^*,\sigma^*) = \inf_\beta U(\beta,\sigma^*)$ ($\beta^*$ rowwise
  adversarial against $\sigma^*$).

The **upper saddle inequality** $U(\beta^*,\sigma) \le U(\beta^*,\sigma^*)$
for all $\sigma$ does NOT follow: a minimizer against a maximin strategy
need not be a minimax strategy. The standard L9 contradiction
(measurable selection of an improving private strategy on a
positive-measure set) requires the upper saddle.

The paper's finite proof obtains the upper saddle from Sion's theorem +
finite-dimensional compactness. Our infinite proof substitutes
**(A9c-calib)**: a posterior-calibrated coupling that bypasses the need
for a true saddle.

### Lemma L9b (calibrated transport, under (A9c-calib))

**Statement (full corrected version).** Under standing + (A5) + (A8c-lsc) +
**(A9c-calib)**, there exists $\beta^*\in B$ such that:
1. $\beta^*(\cdot\mid s)$ is supported on $D(s)$ for τ-a.e. $s$
   (adversariality against $\sigma^*$).
2. With $\gamma_\alpha := \alpha\,(\mathrm{id},\mathrm{id})_\#\tau + (1-\alpha)\,\gamma$
   on $M\times M$ where $\gamma(ds,dm) := \tau(ds)\,\beta^*(dm\mid s)$,
   and $q := (\gamma_\alpha)_2$, the posterior $P_{\gamma_\alpha}(\cdot\mid m) \in C(m)$
   for $q$-a.e. $m$.

The first clause closes L8 (β* attains the inf via support on rowwise
argmin). The second clause delivers per-message Bayes-optimality
**directly without saddle**: by the convex barycenter structure of
$P_{\gamma_\alpha}$, the posterior at $m$ is the α-weighted mix of the
truthful $m$ and the misaligned $\beta^*$-induced posterior, and the
calibration condition forces this mix to lie in $C(m)$.

**Honest scope.** $C(m)$ is a closed convex normal-cone slice of
$\Delta(\Omega)$ (NOT generally a polytope). $D(s)$ is closed (NOT
generally convex). **Crucially**, "$m\in C(m)$ τ-a.e." is **NOT** forced
by Branch A — outside-trust-region messages typically have $m\notin C(m)$
in the paper's TRE construction. Hence (A9c-calib) is a substantive
added hypothesis.

**Sufficient conditions for (A9c-calib).** Either:
- **(a) Three-clause form.** $D(s) = \{m^*(s)\}$ τ-a.e., $s\in C(m^*(s))$
  τ-a.e., and $m\in C(m)$ for τ-a.e. $m$ in $\operatorname{supp} q$.
- **(b) Barycentric form.** The full $\alpha$-weighted coupling
  $\gamma_\alpha$ above satisfies posterior-calibration directly.

**Binary quadratic example.** $|\Omega| = 2$, $A = [0,1]$,
$u(a,0) = -a^2$, $u(a,1) = -(1-a)^2$, $\Theta$ singleton. Paper's
**Appendix A.6 quantile transport** gives a calibrated coupling: trust
region $T = [\underline\mu, \bar\mu]$; inside-$T$ messages get truthful
posterior; outside-$T$ messages get clipped posterior at the boundary.
The misaligned adversary uses quantile-coupled kernel matching τ-mass
outside $T$ to trust-boundary messages. (A9c-calib) is verified
explicitly for this example.

### Branch B capstone (Tier 2)

**Theorem (Branch B).** *Under standing + (A5) + (A8c-lsc) + (A9c-calib),
the pair $(\sigma^*, \beta^*)$ from Branch A + L9b satisfies
$U(\sigma^*) = U^*$, $U(\beta^*,\sigma^*) = U^*$, AND when $\alpha>0$,
$\hat\sigma^*(m)\in\arg\max_{\hat\sigma'} U(\hat\sigma', P_{\beta^*}(\cdot\mid m))$
for τ-a.e. $m$ (Definition 2 a.e./on-path).*

**Proof.** Branch A: $U(\sigma^*) = U^*$. L8 (under A8c-lsc): $\beta^*$
adversarial against σ*. L9b clause 2 (under A9c-calib): pointwise
Bayes-optimality directly from posterior calibration; KRN gives a
measurable version-choice on $q$-null messages. When $\alpha>0$,
$q\ge\alpha\tau$ so q-a.e. ⇒ τ-a.e.

## 8. Discussion

### Why (A5) is needed

Perfect-revelation counterexample: $\Omega = \{0,1\}$, $M = \{\delta_0, \delta_1\}$,
$\pi_\omega = \delta_{\delta_\omega}$. Standing hypotheses satisfied;
any compact $K^*$ with full $\pi_\omega$-measure for both $\omega$ must
contain both points; $\{\delta_0\}$ has zero $\pi_1$-measure, refuting
support-thickness. Hence L5 fails.

### Why (A8c-lsc) is needed

$\ell(m,s) = m$ for $m>0$, $\ell(0,s) = 1$ counterexample. Continuous on
each $K_n = [1/n,1]$, satisfies the L5 modification with $m_0 = 1$.
Pointwise $\inf = 0 = $ essential inf, but argmin empty. Without
l.s.c., L8c Half 2 fails.

### Why (A9c-calib) is needed

Branch A + L8 give only the **lower saddle**. Without an upper saddle,
the standard L9 contradiction fails: an improving deviation against
$\beta^*$ need not contradict anything. The paper's finite Sion-based
proof gets the upper saddle for free; the infinite proof must impose
posterior calibration explicitly. (A9c-calib) is the formal statement
that "the paper's TRE construction generalizes" — verifiable in the
binary quadratic case via Appendix A.6 quantile transport.

### Comparison with paper's finite-case proof

Finite $M$, $\Theta$ ⇒ $B$, $\Sigma$ are products of finite simplices,
Sion 4.2' applies, full saddle is automatic. Our infinite extension via
Mertens + Balder + Lusin recovers Branch A unconditionally up to
common-support (A5). Recovering the upper saddle requires (A9c-calib)
or equivalent; this is the price of moving from finite-dimensional to
infinite-dimensional cheap-talk-like spaces.

### Open questions

- **Removing (A8c-lsc):** can we construct a Branch-A maximizer with
  rowwise l.s.c. baked into the representative from the start? Open.
- **Removing (A9c-calib):** is the calibrated transport free under
  additional structural assumptions on $\sigma^*$? Open. The paper's
  TRE characterization (Theorem 1) suggests yes for "trust-region"
  strategies but the infinite-dimensional generalization is non-trivial.
- **Lean formalization:** axiomatized Lean stub from prior attempts is
  structurally weaker than this proof and not adopted.

## 9. Assumptions Used

- Standing hypotheses (Dworczak–Smolin 2026).
- (A5) Common posterior null sets.
- (A8c-lsc) Rowwise lower semicontinuity (Tier 1 onwards).
- (A9c-calib) Calibrated worst-message transport (Tier 2 only).

Tier 1's conclusion uses standing + (A5) + (A8c-lsc).
Tier 2's conclusion adds (A9c-calib) on top.

## 10. References

- **Dworczak, P. and Smolin, A.** (2026). "Robust Trust." arXiv:2602.09490.
- **Balder, E. J.** (1988). "Generalized Equilibrium Results for Games
  with Incomplete Information." *Math. Operations Research* 13(2),
  265–276. — Theorems 2.2 (p. 268, weak topology characterization),
  2.3(a) (compactness), 2.5 (product-kernel continuity).
- **Mertens, J.-F.** (1986). "The Minmax Theorem for U.S.C.-L.S.C.
  Payoff Functions." *Int. J. Game Theory* 15(4), 237–250. —
  Corollary B p. 238.
- **Aliprantis, C. D. and Border, K. C.** (2006). *Infinite Dimensional
  Analysis*. 3rd ed., Springer. — Theorem 18.13 (Kuratowski–Ryll-Nardzewski),
  Theorem 18.19 (measurable maximum theorem), Theorem 15.11 (compactness
  of $\Delta$ on compact metric).
- **Bogachev, V. I.** (2007). *Measure Theory*. Springer. — §7.1.13
  (Lusin theorem for Polish-valued maps), §10 (disintegration).
- **Sion, M.** (1958). "On General Minimax Theorems." *Pacific J. Math.*
  8(1), 171–176. — *Cited for context only; not used in the infinite
  proof.*
- **Jankov-von Neumann selection theorem.** Standard reference in
  Bogachev §7.5 / Aliprantis-Border §18.

---

*End of consolidated proof report.*
