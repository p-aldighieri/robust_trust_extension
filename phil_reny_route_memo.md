# Route memo — Phil-Reny restricted-game + Lusin-lift route to Theorem 2 infinite extension

*Author: orchestrator. Status: live route. This is a durable ChatGPT source
that supersedes any prior route memos. Read after `prior_attempts_digest.md`
and `phil_reny_bundle.md`.*

## 0. Notation (paper-canonical; we use this throughout)

- $\Omega$ finite, $|\Omega|=N$, full-support prior $\mu_0\in\Delta(\Omega)$.
- $\pi(\cdot\mid\omega)\in\Delta(\Delta(\Omega))$ = state-conditional law of
  the adviser's posterior $s\in\Delta(\Omega)$.
- $\tau(ds) = \sum_\omega \mu_0(\omega)\pi(ds\mid\omega)$ = unconditional law
  of $s$. $M := \operatorname{supp}(\tau)\subseteq\Delta(\Omega)$.
- $A$ compact metric (action space); $\Theta$ compact metric (private type);
  $f(\cdot\mid\omega)\in\Delta(\Theta)$ = conditional law of $\theta$ given
  $\omega$ (independent of $s$).
- $u(a,\omega,\theta)$ bounded, continuous in $a$.
- $\sigma:M\times\Theta\to\Delta(A)$ measurable kernel (agent strategy).
  $\Sigma$ = the set of these kernels.
- $\beta:M\to\Delta(M)$ measurable kernel (misaligned adviser strategy).
  $B$ = the set of these.
- Payoff
  $$
  U(\beta,\sigma) = \alpha\sum_\omega \mu_0(\omega)\!\int_M\!\!\int_\Theta\!\!\int_A u(a,\omega,\theta)\,\sigma(da\mid s,\theta)\,f(d\theta\mid\omega)\,\pi(ds\mid\omega) + (1-\alpha)\sum_\omega \mu_0(\omega)\!\int_M\!\!\int_M\!\!\int_\Theta\!\!\int_A u(a,\omega,\theta)\,\sigma(da\mid m,\theta)\,f(d\theta\mid\omega)\,\beta(dm\mid s)\,\pi(ds\mid\omega).
  $$
- Robust value $U^* = \sup_\sigma \inf_\beta U(\beta,\sigma)$.
- Robust rationalizability (Definition 2): $\sigma$ is RR if there is
  $\beta^*$ adversarial against $\sigma$ such that for every $m\in M$,
  $\hat\sigma(m)\in\arg\max U(\hat\sigma',P_{\beta^*}(\cdot\mid m))$.

## 1. The route in one paragraph

Restrict $B$ to $\tau$-dominated kernels $\beta_\varphi(dm\mid s) = \varphi(m\mid s)\tau(dm)$
for $\varphi\in F$, where $F$ = convex set of jointly measurable
$\varphi:M\times M\to[0,\infty)$ with $\int_M \varphi(m\mid s)\tau(dm)=1$
$\tau$-a.s. On the restricted game, the misaligned-term integrates against
the **fixed** product marginal $\tau(dm)f(d\theta\mid\omega)$, so by Balder
(1988) the payoff is **continuous in $\sigma$** in the topology where
$\sigma_n\to\sigma$ iff $\sigma_n\,\pi(\cdot\mid\omega)\,f(\cdot\mid\omega)$
weak\* converges for each $\omega$ (and the same with $\tau\,f$ for the
restricted term). $\Sigma$ is compact in this topology. $F$ is convex.
Apply **Mertens (1986) Cor B** (asymmetric minmax: u.s.c. on the compact side,
no topology required on the other) to obtain $\sigma^*\in\Sigma$ achieving
$\sup_\sigma\inf_F U(\sigma,\varphi) = \inf_F\sup_\sigma U(\sigma,\varphi)$.
Then **lift** the restriction: pick a Lusin-thick increasing compact
sequence $K_n\uparrow K^*\subseteq M$ with $\pi(K^*\mid\omega)=1$ for every
$\omega$ on which $\hat\sigma^*$ is continuous and every relative open in
$K_n$ has positive $\pi(\cdot\mid\omega)$-mass. Modify $\sigma^*$ off $K^*$
to a fixed in-$K^*$ value. Any unrestricted measurable deviation $d$ that
beats the restricted value would have to be supported off $K^*$ a.s.;
support-thickness then converts $d$ into a $\tau$-dominated $\varphi\in F$
that beats the same value, contradicting the restricted optimality.

## 2. The fork

This route, **as stated**, delivers existence of an optimal agent strategy
$\sigma^*$ (i.e., $U(\sigma^*) = U^*$). That is **half** of Theorem 2's
existence direction. The full statement of Theorem 2 also needs:

- $\beta^*\in B$ adversarial against $\sigma^*$, AND
- per-message Bayes-optimality of $\hat\sigma^*$ at every on-path $m$
  (Definition 2).

Phil himself flags both gaps: *"this establishes the existence of an optimal
strategy for player 1, but not for player 2."*

We split the proof plan into two branches:

- **Branch A (existence-of-optimal-$\sigma^*$).** Lemmas L1–L7 below.
  Status: should be reachable with current tools and Balder/Mertens.
- **Branch B (full Theorem 2 existence).** Adds L8 + L9 on top of Branch A.
  Status: L8 is genuinely open and **must not** be solved by replaying old
  compactness through $\prod_\mu\Delta(M)$. The Branch B endgame requires a
  new ingredient — most plausibly a direct hyperplane/transport construction
  of $\beta^*$ from the value-equality conditions on the restricted game.

## 3. Lemma list (L1–L9) and ranked attack order

### L1. Constant-marginal continuity (Balder hammer) — STATUS: PROVED (reviewer-cleared 2026-05-05)

**Statement.** Under $\Omega$ finite, $A$ compact metric, $\Theta$ compact
metric, $u$ bounded and continuous in $a$, fixed $\varphi\in F$: if
$\sigma_n\to\sigma$ in the joint-transition-law topology (i.e.,
$\sigma_n\,\pi(\cdot\mid\omega)\,f(\cdot\mid\omega)$ weak\* → $\sigma\,\pi(\cdot\mid\omega)\,f(\cdot\mid\omega)$
for each $\omega$, AND $\sigma_n\,\tau\,f(\cdot\mid\omega)$ weak\* →
$\sigma\,\tau\,f(\cdot\mid\omega)$ for each $\omega$), then
$U_F(\sigma_n,\varphi)\to U_F(\sigma,\varphi)$.

**Technique.** **Balder (1988) Theorem 2.2, p. 268** — portmanteau-style
characterization of the weak topology on transition probabilities via
continuity of integral functionals $I_g$ for Carathéodory integrands $g$
(measurable in the base coordinate, continuous in the action coordinate,
**dominated by an $L^1$ base function** — not necessarily a constant).
*Theorem 2.5 (pp. 270–271)* concerns product-kernel continuity, not
constant-marginal continuity, and is reserved for L2.

**Subquestion resolutions (from L1 reviewer pass).**
- Bounded-density restriction on $F$? **NO.** L1 holds for all $\varphi\in F$.
  The only object needed is $r_\omega^\varphi(m) := \int_M \varphi(m\mid s)\,\pi(ds\mid\omega)\in L^1(\tau)$,
  which follows from normalization $\int_M \varphi(\cdot\mid s)\,d\tau = 1$
  $\tau$-a.s. plus $\pi(\cdot\mid\omega)\ll\tau$ (automatic from
  full-support $\mu_0$ and $\tau = \sum_\omega\mu_0(\omega)\pi(\cdot\mid\omega)$).
  Balder's Carathéodory class permits $L^1$-domination, so unbounded
  densities pass through the "little door." No $F_K$ truncation is needed.
- Topology equivalence? On compact metric $M\times\Theta$ with **fixed
  base marginal**, Balder weak convergence ≡ ordinary weak convergence
  of the joint laws. Without fixed marginal, ordinary weak convergence is
  too weak for bounded-measurable-base tests. Keep Balder weak/stable as
  primary in L2.
- $\theta$-continuity needed? **NO.** Balder's Carathéodory definition
  requires only measurability in the base coordinate; continuity is in
  the action coordinate.
- Regular conditional probability hypothesis on $f(\cdot\mid\omega)$?
  **NO** beyond what's already standing — $\Theta$ compact metric is
  standard Borel, so conditioning is automatic.

**Housekeeping note (reviewer-suggested).** When invoking $r_\omega^\varphi$
in proofs, take a finite measurable representative on the $\tau$-null set
where the raw integral could be $+\infty$ (Balder's integrand is
real-valued).

### L2. Compactness of $\Sigma$ — STATUS: PROVED (reviewer-cleared 2026-05-06, after RN-direction patch)

**Statement (refined version).** Set $X := M\times\Theta$,
$\bar f := \sum_\omega \mu_0(\omega)\,f(\cdot\mid\omega)$,
$\lambda := \tau\otimes\bar f$. Endow $\Sigma$ with the **single-base**
Balder weak topology $T_\lambda$. Then $\Sigma$ is compact in $T_\lambda$,
$T_\lambda$ is equivalent to the simultaneous topology requiring
Balder-weak convergence in all $\lambda_\omega^\pi$ and $\lambda_\omega^\tau$,
and every simultaneous limit factors through one common measurable kernel
$\sigma$.

**Technique.** **Balder (1988) §2 Theorem 2.3(a)** (weak compactness of
transition probabilities into compact metric target $A$, with finite base
measure $\lambda$). No extra tightness needed — automatic from compact $A$.
The **common-kernel extraction lemma** is a finite-mixture +
standard-Borel disintegration + Radon-Nikodym multiplication argument,
with all densities pointing from the dominated to the dominating measure
($d\lambda_\omega^\tau/d\lambda$, $d\pi(\cdot\mid\omega)/d\tau$,
$df(\cdot\mid\omega)/d\bar f$, all bounded by $\mu_0(\omega)^{-1}$). The
$L^1$-domination transfer relies on $\lambda_\omega^\tau\le\mu_0(\omega)^{-1}\lambda$.
Theorem 2.5 (product-kernel) is **not** needed here.

**Subquestion resolutions (from L2 reviewer pass).**
- Common-kernel issue: resolved via finite mixture + disintegration on
  standard Borel $X\times A$ + RN-multiplication transfer.
- Topology choice: single-base $T_\lambda$ is the cleaner formulation;
  simultaneous topology is equivalent.
- Compactness reference: Balder §2 Theorem 2.3(a) (NOT Theorem 2.5).
- Theorem 2.5: not used in L2; reserved for later applications where
  product kernels themselves vary.
- Density directions: every RN density points small→large; no
  reverse-direction absolute-continuity smuggled.

**Patched proof of record:** `packets/20260506T003500Z_rereview_L2_compactness_patched.md`
(also in `logs/20260506T003500Z_rereview_L2_compactness_patched_response.md`).

### L7. Reintroducing $\theta$ — STATUS: VERIFIED (reviewer PASS 2026-05-06)

**Statement.** L1 and L2 survive replacing $m\mapsto\Delta(A)$ by
$(m,\theta)\mapsto\Delta(A)$ — equivalently, by viewing the agent strategy
as a measurable family of private strategies $\hat\sigma(m):\Theta\to\Delta(A)$.

**Verification record.** $\theta$ was kept in the Balder base coordinate
$x = (m,\theta)$ throughout L1 and L2. Both the aligned integrand
$g_\omega^\pi((s,\theta),a) = u(a,\omega,\theta)$ and the misaligned
integrand $g_{\omega,\varphi}^\tau((m,\theta),a) = u(a,\omega,\theta)\,r_\omega^\varphi(m)$
are Balder-Carathéodory: measurable in the base, continuous in $a$,
$L^1$-dominated. Standard-Borel disintegration on $X\times A$ produces
a kernel; sectioning gives the family $\hat\sigma(m):\Theta\to\Delta(A)$.
The two representations are interchangeable. **Definition 2 compatibility
verified at the *representation* level only** — per-message Bayes-optimality
(L9) and $\beta^*$-attainment (L8) are NOT addressed by L7.

No new hypothesis on $f(\cdot\mid\omega)$. No $\theta$-continuity required.

**Verification record:** `logs/20260506T010000Z_prover_L7_theta_reintroduction_response.md`,
reviewer-cleared at `logs/20260506T011500Z_reviewer_L7_theta_reintroduction_response.md`.

### L3. Mertens minmax checklist — STATUS: PROVED (reviewer PASS 2026-05-06)

**Statement.**
$$
\max_{\sigma\in\Sigma}\,\inf_{\varphi\in F}\,U_F(\sigma,\varphi) \;=\; \inf_{\varphi\in F}\,\max_{\sigma\in\Sigma}\,U_F(\sigma,\varphi),
$$
and the LHS maximum is **attained** by some pure $\sigma^*\in\Sigma$.

**Technique.** Mertens (1986) §2 Corollary B (p. 238) applied to
$S = \Sigma$ compact Hausdorff (compactness from L2; Hausdorffness from
the **Balder quotient** identification, see amendment below), $T = F$
arbitrary set, $f = U_F$ u.s.c. (in fact continuous by L1) and bounded.
Mertens delivers the equality with regular Borel mixing on $\Sigma$ and
finite-support mixing on $F$. **Both mixings collapse by affineness:**
- $F$-side: $U_F$ affine in $\varphi$ + $F$ convex ⇒ $\sum_i p_i U_F(\sigma,\varphi_i) = U_F(\sigma,\bar\varphi_\eta)$
  with $\bar\varphi_\eta = \sum_i p_i \varphi_i \in F$, where $\eta$ denotes
  the finite-support Mertens lottery (using $\eta$ to avoid clash with
  the paper's $\tau$).
- $\Sigma$-side: $U_F(\cdot,\varphi)$ continuous affine on $\Sigma$ +
  barycenter exists in compact convex $\Sigma$ in the Hausdorff locally
  convex Balder quotient ⇒ $\int_\Sigma U_F\,d\rho = U_F(b(\rho),\varphi)$.

**[BREAKDOWN_AMEND adopted].** $\Sigma$ is the **Balder quotient kernel
space** — kernels are identified when they agree $\bar G$-a.e. (equivalently,
$\bar f$-a.e. on $\Theta$ and $\tau$-a.e. on $M$). This is a standard
identification that changes no payoff and adds no primitive assumption.
Balder (1988) §2 quotient by null subspace; the resulting Hausdorff
locally convex space is what compactness/Mertens act on.

**L4 attainment folded in.** $V(\sigma) := \inf_\varphi U_F(\sigma,\varphi)$
is u.s.c. (inf of continuous functions). Compact $\Sigma$ ⇒ attainment
of $\sigma^*\in\arg\max V$.

**Records:** `logs/20260506T013000Z_prover_L3_mertens_minmax_response.md`,
`logs/20260506T014500Z_reviewer_L3_mertens_minmax_response.md`.

### L4. Existence and characterization of $\sigma^*$ on the restricted game — STATUS: PROVED (folded into L3, 2026-05-06)

**Statement.** $\sigma^*\in\Sigma$ exists with
$\inf_F U_F(\sigma^*,\varphi) = \sup_\sigma \inf_F U_F(\sigma,\varphi)$.

**Status.** Folded into the L3 proof via the u.s.c. + compact attainment
argument on $V(\sigma) := \inf_\varphi U_F(\sigma,\varphi)$.

**Caveat.** This characterizes only a *restricted* maximin agent strategy
— not a full saddle in $B$, not Definition 2 RR.

### L5. Lusin-thick compact sequence — STATUS: PROVED-CONDITIONAL under (A5) (reviewer PASS 2026-05-06)

**[ASSUMPTION+] (A5) — common posterior null sets.** $\pi(\cdot\mid\omega)\sim\tau$
on $M$ for every $\omega\in\Omega$. The forward direction
$\pi(\cdot\mid\omega)\ll\tau$ is automatic from full-support $\mu_0$. The
**new content** is only the reverse direction $\tau\ll\pi(\cdot\mid\omega)$
— i.e., all state-conditional posterior laws are mutually absolutely
continuous.

**Statement.** Under (standing hypotheses) $\cup$ (A5): there exists a
measurable representative $\hat\sigma^*:M\times\Theta\to\Delta(A)$ of
$\sigma^*$, and compact $K_1\subseteq K_2\subseteq\cdots\subseteq M$ with
$K^* = \bigcup_n K_n$, such that:
- $\pi(K^*\mid\omega) = 1$ for every $\omega\in\Omega$.
- $m\mapsto[\theta\mapsto\hat\sigma^*(\cdot\mid m,\theta)]$ is continuous
  on each $K_n$ in the **Balder stable private-strategy topology** (i.e.,
  the topology on $Y = K_{\bar f}(\Theta,A)$, the kernels $\Theta\to\Delta(A)$
  modulo $\bar f$-a.e. equality, generated by $I_g(\kappa) = \int_\Theta\int_A g(\theta,a)\kappa(da\mid\theta)\bar f(d\theta)$
  for $g$ bounded measurable in $\theta$, continuous in $a$). $Y$ is
  Polish (compact metrizable).
- For every $n$, every $m\in K_n$, every relative open $O\subseteq K_n$
  containing $m$, and every $\omega\in\Omega$, $\pi(O\mid\omega)>0$.

**Construction.** Apply Polish-valued Lusin to $h:M\to Y$ (reference
measure $\tau$) to get compact $L_j$ with $\tau(M\setminus L_j) < 1/j$
and $h\restriction L_j$ continuous. Set $C_n := \bigcup_{j\le n} L_j$
(compact, $h$-continuous). Define $K_n := \operatorname{supp}(\tau\restriction C_n)$.
Under (A5), $\operatorname{supp}(\pi(\cdot\mid\omega)\restriction C_n) = K_n$
for every $\omega$, so support-thickness holds simultaneously for all
$\pi(\cdot\mid\omega)$.

**Modification off $K^*$.** Pick $m_0\in K^*$. Define $r:M\to K^*$ by
$r(m) = m$ for $m\in K^*$, $r(m) = m_0$ otherwise. Set $\sigma^*(da\mid m,\theta) := \sigma_0^*(da\mid r(m),\theta)$.
This is measurable, agrees with $\sigma_0^*$ on $K^*\times\Theta$, and
leaves $U_F(\sigma^*,\varphi)$ unchanged on the restricted game (since
$\tau(K^*) = 1$ and $\pi(K^*\mid\omega) = 1$ for every $\omega$).

**Counterexample under standing hypotheses alone (without (A5)).**
$\Omega = \{0,1\}$, $M = \{\delta_0,\delta_1\}$,
$\pi(\cdot\mid 0) = \delta_{\delta_0}$, $\pi(\cdot\mid 1) = \delta_{\delta_1}$.
Any $K^*$ with full $\pi(\cdot\mid\omega)$-measure for both $\omega$
contains both points; $\{\delta_0\}$ has zero $\pi(\cdot\mid 1)$-mass.

**Records:** `logs/20260506T020000Z_prover_L5_lusin_thick_compacts_response.md`,
`logs/20260506T021500Z_reviewer_L5_lusin_thick_compacts_response.md`.

### L6. Lift to measurable deviations — STATUS: PROVED under (A5) (reviewer PASS 2026-05-06)

**Statement.** Under standing + (A5): for every measurable $\beta\in B$ and
every $\varepsilon>0$, there exists $\varphi_\varepsilon\in F$ with
$U(\beta,\sigma^*) \ge U_F(\sigma^*,\varphi_\varepsilon) - \varepsilon$.
Hence $\inf_{\beta\in B} U(\beta,\sigma^*) \ge V^* := \max_\sigma\inf_\varphi U_F(\sigma,\varphi)$.

**Construction (no Dirac reduction needed).**
- Define message payoff $p_\omega(m) := \int_\Theta\int_A u(a,\omega,\theta)\,\sigma^*(da\mid m,\theta)\,f(d\theta\mid\omega)$.
- Aligned term identical for $U(\beta,\sigma^*)$ and $U_F(\sigma^*,\varphi)$;
  only misaligned-term differential matters: $U(\beta,\sigma^*) - U_F(\sigma^*,\varphi) = (1-\alpha)(C(\beta) - C(\varphi))$.
- $\hat\sigma\mapsto p_\omega$ is Balder-stable continuous; $p_\omega\restriction K_n$
  uniformly continuous on compact $K_n$; choose $\rho_n$ for $\eta = \varepsilon$.
- Borel shells $D_n := K_n\setminus K_{n-1}$. Smoothing kernel
  $q_\varepsilon(z\mid y) := \mathbf 1_{K_n\cap B(y,\rho_n)}(z)/\tau(K_n\cap B(y,\rho_n))$
  for $y\in D_n$; $q_\varepsilon(z\mid y) := \mathbf 1_{K_{n_0}\cap B(m_0,\rho_0)}(z)/\tau(K_{n_0}\cap B(m_0,\rho_0))$
  for $y\notin K^*$. Denominators positive by L5 support-thickness + (A5).
- $\varphi_\varepsilon(z\mid s) := \int_M q_\varepsilon(z\mid y)\,\beta(dy\mid s)$
  (joint Borel; Tonelli normalization; finite representative on τ-null sets).
- Pointwise bound $|\int p_\omega q_\varepsilon - p_\omega(y)| \le \eta$
  + Tonelli ⇒ $|C(\beta) - C(\varphi_\varepsilon)| \le \eta$.

**Capstone consequence.** $V^* \ge U^*$ trivially (since $F\hookrightarrow B$
via $\beta_\varphi$, infimum over a smaller set is larger pointwise).
L6 gives $\inf_B U(\cdot,\sigma^*) \ge V^*$, hence $U^* \ge V^*$.
Therefore **$V^* = U^*$ and $\sigma^*$ achieves $U^*$ in the unrestricted
game**. This is the Branch A theorem.

**Records:** `logs/20260506T023000Z_prover_L6_lusin_lift_response.md`,
`logs/20260506T024500Z_reviewer_L6_lusin_lift_response.md`.

### L8. Producing $\beta^*$ — the Branch B endgame — STATUS: PROVED-CONDITIONAL under (A8c-lsc) (2026-05-06, reviewer PATCH_SMALL with editorial notes)

**Statement.** Find $\beta^*\in B$ with $U(\beta^*,\sigma^*) = \inf_\beta U(\beta,\sigma^*) = U^*$.
By Branch A, $\inf_\beta U(\beta,\sigma^*) = U^*$ already. L8 is an
**attainment** question, not a value-equality question.

**Status.** Open. **Do not attack by product-narrow compactness in $\prod_\mu\Delta(M)$.**
The escape-of-mass counterexample is real.

**Plan (updated 2026-05-06 after L8a):**

1. **Route 3b — Restricted-dual barycenter bridge — STATUS: BLOCKED in general.**
   L8a (PATCH_SMALL → bankable result): the restricted dual value is
   $\inf_F U_F(\sigma^*,\varphi) = \text{const} + (1-\alpha)\int_M\operatorname*{essinf}_m \ell_{\sigma^*}(m,s)\,\tau(ds)$
   with $\ell_{\sigma^*}(m,s) = \sum_\omega s(\omega)p_\omega(m)$.
   **Necessary and sufficient attainment criterion (A8-flat):**
   $\tau(Z(s)) > 0$ for τ-a.e. $s$, where
   $Z(s) = \{m: \ell_{\sigma^*}(m,s) = \operatorname*{essinf}_m\ell_{\sigma^*}(m,s)\}$.
   Generically fails (e.g., $\ell(m,s) = m^2$ on $[0,1]$). Hence Route
   3b is **conditional only**, not unconditional.

2. **Route 3c — Coarsened class $B'\supseteq F$ — STATUS: PRIMARY (now).**
   Reviewer flagged the L5-continuity-on-each-$K_n$ observation as
   **insufficient**: continuity on each $K_n$ does NOT imply continuity
   on $K^* = \bigcup_n K_n$ (sequences crossing shells). Need one of
   three precise upgrades:
   - **(i) Strengthened Lusin exhaustion** giving global continuity on
     a full-measure invariant domain.
   - **(ii) Lower-semicontinuous modification** $\tilde\ell\le\ell$
     preserving value against all kernels.
   - **(iii) Rowwise measurable argmin theorem:** pointwise min
     attained, equals essential inf τ-a.e., admits a measurable
     selector $m^*(s)\in\arg\min_m \ell(m,s)$. If yes, $\beta^*(dm\mid s) = \delta_{m^*(s)}(dm)$
     closes L8 directly — no restricted dual attainment needed.

3. **Route 3a — Direct hyperplane** — fallback diagnostic.

**Next pass: Route 3c BREAKDOWN.** Rank the three sub-targets (i)–(iii).
Pick the next prover target.

**L8a result of record (bankable, PATCH_SMALL→to-be-PASS):**
- `logs/20260506T033000Z_prover_L8a_dual_attainment_response.md`,
  `logs/20260506T034500Z_reviewer_L8a_dual_attainment_response.md`.
- Patches: state measurability of $e(s)$, $A_n(s)$, $Z(s)$ explicitly;
  soften "F is not uniformly integrable" to "in general".

**Planning record:** `logs/20260506T031500Z_planning_branch_B_L8_response.md`.

### L9. Per-message Bayes-optimality — STATUS: PROVED-CONDITIONAL under standing + (A5) + (A8c-lsc) (reviewer PASS 2026-05-06)

**Statement.** Under standing + (A5) + (A8c-lsc), let $(\sigma^*,\beta^*)$
be the Branch-A/L8c output with $\beta^*(dm\mid s) = \delta_{m^*(s)}(dm)$.
Let $q := \alpha\tau + (1-\alpha)(m^*)_\#\tau$ be the message marginal.
For $q$-a.e. $m\in M$,
$\hat\sigma^*(m)\in\arg\max_{\hat\sigma'} U(\hat\sigma',P_{\beta^*}(\cdot\mid m))$.
When $\alpha>0$, $q\ge\alpha\tau$, so the statement holds τ-a.e.

**Technique.** $P_{\beta^*}(\cdot\mid m)$ from Bayes' rule with explicit
state-message joint measure. Decomposition $U(\beta^*,\sigma) = \int U(\hat\sigma(m),P_{\beta^*}(\cdot\mid m))\,q(dm)$
via disintegration. Saddle inequality from Branch A + L8c. Pointwise
Bayes-optimality via Kuratowski–Ryll-Nardzewski measurable selection
contradiction. Posterior version on $q$-null messages: any measurable
extension.

**No new assumption** beyond L8c.

**Records:** `logs/20260506T053000Z_prover_L9_per_message_bayes_optimality_response.md`,
`logs/20260506T060000Z_reviewer_L9_per_message_bayes_optimality_response.md`.

## 4. Ranked attack order (operational)

1. ~~**L1** — Balder constant-marginal continuity. Crisp pass/fail.~~ **DONE 2026-05-05 (reviewer PASS).**
2. ~~**L2** — Compactness of $\Sigma$. Mechanical.~~ **DONE 2026-05-06 (PATCH_SMALL→PASS after RN fix).**
3. ~~**L7** — Re-introduce $\theta$. Insurance check before assembling.~~ **DONE 2026-05-06 (reviewer PASS).**
4. ~~**L3** — Map exactly into Mertens Cor B. Reviewer-verifiable line-by-line.~~ **DONE 2026-05-06 (reviewer PASS, with Balder quotient amendment).**
5. ~~**L4** — Restricted-game existence. Should be a one-liner once L1–L3 + L7 pass.~~ **DONE 2026-05-06 (folded into L3).**
6. ~~**L5** — Lusin-thick compacts. Watch for support-thickness; may force an
   added hypothesis.~~ **DONE 2026-05-06 (reviewer PASS, PROVED-CONDITIONAL under (A5)).**
7. ~~**L6** — The Lusin lift contradiction. Most error-prone step.~~ **DONE 2026-05-06 (reviewer PASS under (A5)). Branch A COMPLETE.**
8. **L8** — $\beta^*$ endgame. After Branch A is closed; needs new ingredient.
9. **L9** — per-$m$ Bayes-optimality. Likely deferred until L8 is in hand.

After L1–L7 are reviewer-cleared, Branch A produces a clean publishable result
("existence of an optimal $\sigma^*$ in the infinite-$M$, infinite-$\Theta$
robust-trust game") even if Branch B remains open. That's the de-risked
intermediate target.

## 5. Banned re-proposals

(See `prior_attempts_digest.md` §"What this means for the current attempt".
Keeping the list short here.)

- Product-of-narrow + Sion as the master theorem.
- Adversary attainment in $\prod_\mu\Delta(M)$ without a new tightness
  ingredient.
- Atomic truncation limits, exact raw lifting, exact measurable lifting,
  posterior-labeled lifts, finite-palette / tail-stability /
  monotone-refinement / recurrence uniformization. All reviewer-cleared as
  non-derivable.
- Axiomatized Lean `GameSetup` as progress on this bottleneck.
- FOC + envelope as the infinite route (apparatus is finite-only).

## 6. Live status

- **L1 PROVED** (2026-05-05, reviewer PASS). Balder Theorem 2.2 p. 268;
  no bounded-density restriction.
- **L2 PROVED** (2026-05-06, PATCH_SMALL→PASS). Balder §2 Theorem 2.3(a);
  single-base $T_\lambda$ topology with $\lambda = \tau\otimes\bar f$;
  common-kernel extraction via correctly-directed RN multiplications.
- **L7 VERIFIED** (2026-05-06, reviewer PASS). $\theta$ in base
  coordinate; no new hypothesis; kernel/family equivalence via standard
  Borel disintegration.
- **L3 PROVED + L4 attainment folded in** (2026-05-06, reviewer PASS).
- **L5 PROVED-CONDITIONAL under (A5)** (2026-05-06, reviewer PASS).
  Mutual absolute continuity of state-conditional posteriors.
- **L6 PROVED under (A5)** (2026-05-06, reviewer PASS). Smoothing-kernel
  construction; direct stochastic-kernel lift, no Dirac reduction needed.
  $\sigma^*$ secures $V^* = U^*$ in the unrestricted game.
- **BRANCH A COMPLETE** (2026-05-06). **Theorem (Branch A capstone):**
  Under standing hypotheses + (A5), there exists $\sigma^*\in\Sigma$
  with $U(\sigma^*) = U^* = V^*$ and $U(\beta,\sigma^*)\ge U^*$ for every
  $\beta\in B$. Consolidator written and reviewer-PASS'd
  (`logs/20260506T030000Z_consolidator_branch_A_existence_response.md`,
  `logs/20260506T031500Z_reviewer_branch_A_consolidator_response.md`).
- **Branch B planning (2026-05-06):** Three candidate L8 routes
  evaluated. Route 3b ranked primary contingent on L4 dual attainment.
- **L8a (2026-05-06):** Bankable result: dual value formula + (A8-flat)
  necessary-and-sufficient criterion. Generic failure ⇒ Route 3b is
  blocked unconditionally.
- **Route 3c breakdown + L8c (2026-05-06):**
  - **Half 1** (pointwise inf = essential inf τ-a.e.) **PROVED**
    unconditionally via Jankov–von Neumann (with τ-a.e. Borelization)
    + L6 bottom-density.
  - **Half 2** (pointwise attainment) **DISPROVED** under standing +
    (A5) alone — explicit row counterexample $g(m) = m$ for $m>0$,
    $g(0) = 1$, with full model realization.
  - **L8c (and hence L8) PROVED-CONDITIONAL under (A8c-lsc):**
    rowwise l.s.c. of $\ell(\cdot,s)$ for τ-a.e. $s$. Measurable
    minimum theorem for Borel normal integrands + KRN selector gives
    $\beta^* = \delta_{m^*(s)}\in B$ adversarial against $\sigma^*$.
- **L9 PROVED-CONDITIONAL under standing + (A5) + (A8c-lsc)** (2026-05-06,
  reviewer PASS). Same conditional as L8c, no new assumption. Quantifier
  q-a.e. (τ-a.e. when α>0).
- **BRANCH B COMPLETE** under (A5) + (A8c-lsc).
- **Final Theorem (to be consolidated):** Under standing hypotheses +
  **(A5)** ($\pi(\cdot\mid\omega)\sim\tau$ for every $\omega$) + **(A8c-lsc)**
  (rowwise l.s.c. of the message payoff $\ell_{\sigma^*}(\cdot,s)$ for
  τ-a.e. $s$, equivalently a value-preserving l.s.c. representative),
  Theorem 2's existence direction extends to infinite $M$ and infinite
  (compact metric) $\Theta$: there exists $\sigma^*\in\Sigma$ achieving
  $U(\sigma^*) = U^*$, and there exists adversarial $\beta^*\in B$ with
  $\hat\sigma^*(m)$ Bayes-optimal under $P_{\beta^*}(\cdot\mid m)$ for
  τ-a.e. on-path $m$ (when $\alpha>0$).
- **Next move: Branch B final consolidator pass.**
