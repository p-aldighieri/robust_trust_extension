# Prover pass 07 — L_B6 Binary capstone assembly

## Role

You are the Prover. The binary-chain lemmas are essentially in place:
- **L_B1** (binary scalar endpoint-fiber lift): proved by Prover 05,
  PATCH_SMALL stipulations folded in; reviewer 04 confirmed PATCH_SMALL
  with Radon-Nikodym direction fix.
- **L_B3** (endpoint-only adversarial image): PASS modulo wording
  (Prover 06; reviewer 05 in flight).
- **L_B5** (endpoint stationarity / total-balance): PATCH_BIG → PASS
  under (R-EE) endpoint exposure + (R-TD) tie discipline + (R-IES)
  interior endpoint stationarity (Prover 06; reviewer 05 in flight).
- **L_B2** (TRS interval reduction): direct cite of paper Theorem 1.
- **L_B4** (interior message calibration): free under TRS.

Your job: **assemble these into the binary-state capstone theorem**.

## The target theorem

\begin{theorem}[Binary-state infinite-extension of Theorem 2]
Under the standing hypotheses of \emph{Robust Trust} with $|\Omega| = 2$,
$\alpha \in (0, 1)$, and the three regularity conditions
\begin{itemize}
  \item (R-EE) Endpoint exposure: at the optimal TRS endpoints $L, R$,
    the Bayes cones $B_W(w_L)$ and $B_W(w_R)$ are singletons $\{L\}$
    and $\{R\}$ respectively.
  \item (R-TD) Tie discipline: $\tau$ assigns zero mass to the
    indifference belief between profile $w_L$ and $w_R$.
  \item (R-IES) Interior endpoint stationarity: $0 < L < R < 1$ (the
    optimal trust region is a proper interior subinterval).
\end{itemize}
there exists a robustly rationalizable optimal strategy. Specifically,
let $T^* = [L, R]$ be the optimal trust region (Theorem 1 of the paper).
The agent's strategy is the TRS:
\[
  \hat\sigma^*(m) = R\big(w^*(\Pi_{T^*}(m))\big),
\]
where $\Pi_{T^*}$ is the Bregman projection to $[L, R]$. The adversary's
kernel is
\[
  \hat\beta^*(\cdot \mid s) = \begin{cases}
    \kappa_L(\cdot \mid s) & s \in S_+ \\
    \kappa_R(\cdot \mid s) & s \in S_- \\
    \delta_s & s \in [L, R] \cap M
  \end{cases}
\]
where $\kappa_L, \kappa_R$ are the kernels from Lemma B1 applied with
$p = L$, $A_- = [0, L] \cap M$, $S_+ = $ high-source region (resp.\ for
$R$). Then for $q$-a.e.\ $m \in M$, the agent's strategy $\hat\sigma^*(m)$
is Bayes-optimal under $P_{\hat\beta^*}(\cdot \mid m)$. This satisfies
Definition 2 in the infinite-space $q$-a.e.\ reading.
\end{theorem}

\textbf{Substantive scope.} $\alpha \in (0, 1)$. \textbf{$M$ and
$\Theta$ are arbitrary (infinite allowed).}

## Hypothesis check vs.\ economically meaningful primitives

Discuss in the proof:

1. **(R-EE) endpoint exposure** — when does this hold? In binary
   with finitely many actions, it holds whenever the supporting
   hyperplane to $W$ at $w_L$ (resp.\ $w_R$) touches $W$ at a single
   point. Generic in finite-action models. In continuous-action
   models, it holds when $u(a, \omega, \theta)$ is strictly concave in
   $a$ for each $(\omega, \theta)$ (the agent's Bayes action is unique
   at every belief).
2. **(R-TD) tie discipline** — single-point τ-null. In binary, the
   tie belief between $w_L$ and $w_R$ is determined by the linear
   equation $s\cdot(w_L - w_R) = 0$, a single $s^* \in [0,1]$.
   $\tau(\{s^*\}) = 0$ when $\tau$ has no atom at $s^*$. Generic
   for atomless $\tau$ (paper standing convention).
3. **(R-IES) interior endpoint** — the optimal TRS is interior.
   This rules out degenerate corner solutions. Generic in
   typical applications (smooth utility, full-support $\tau$).

\textbf{All three are economically meaningful primitive conditions on
$(\tau, u, A, \Omega, \Theta)$, NOT on the optimization output.} They
are strictly weaker than menu-Hall (which is a calibration condition on
posterior cones of the optimal labeling).

## Proof outline

### Step 1 — TRS interval reduction (L_B2)
Apply paper Theorem 1. Any optimal $\sigma$ is equivalent to a TRS
with connected trust region. In binary, connected $\Leftrightarrow$
interval $[L, R]$. Under (R-IES), $L > 0$ and $R < 1$.

### Step 2 — Endpoint-only adversarial image (L_B3)
The adversary's optimal kernel concentrates on the endpoints $\{L, R\}$.
Sources in $S_+ := \{s : s \cdot w_L < s \cdot w_R, s \cdot w_L < s \cdot w^*(\mu)\,\forall\mu\in(L,R)\}$
route to $L$; sources in $S_-$ symmetric to $R$; sources in
$[L, R] \cap M$ are routed truthfully by the aligned-part. Under
(R-TD), $S_+ \cup S_-$ partitions $M \setminus [L, R]$ up to a
$\tau$-null set.

### Step 3 — Endpoint stationarity (L_B5, patched)
Under (R-EE) + (R-TD) + (R-IES), the v9 T1 Lagrange multipliers
$\lambda^\pm$ at the active endpoints satisfy the total-balance
equations:
\[
  \alpha\!\int_{[0,L]}\!(L - m)\,\tau(dm) = (1-\alpha)\!\int_{S_+}\!(s - L)\,\tau(ds),
\]
and the symmetric equation for $R$.

### Step 4 — Apply Lemma B1 on both endpoint fibers
The total-balance from Step 3 is exactly the $\eta(A_-) = \nu(S_+) < \infty$
hypothesis of Lemma B1 (with $p = L$, $A_- = [0, L] \cap M$, $S_+$ as
defined). B1 supplies a Borel kernel $\kappa_L: S_+ \to \Delta([0, L] \cap M)$
realizing the balance and making the posterior at every left-fiber
message equal $L$. Symmetric application for $R$ gives $\kappa_R$.

### Step 5 — Assemble $\hat\beta^*$ and verify Definition 2
Define $\hat\beta^*$ as in the theorem statement. Verify case-by-case:

- For $m \in (L, R) \cap M$ (interior message): the adversary does not
  route to $m$ (by Step 2's endpoint-only support). The only on-path
  mass is aligned-truthful at $m = s$. Posterior $P_{\hat\beta^*}(\cdot\mid m) = m$.
  Continuation $\hat\sigma^*(m) = R(w^*(m))$ is Bayes-optimal at $m$ by
  TRS face-value.
- For $m = L$ (left endpoint): aligned-truthful mass is on $\tau\restriction_{[0, L]}$
  (sources in $[0, L]$ are reported truthfully). Misaligned mass from
  $S_+$ via $\kappa_L$. By Lemma B1 Claim 2 (with the no-extra-fiber-traffic
  stipulation enforced), the posterior at $L$-fiber messages equals $L$.
  Continuation $\hat\sigma^*(L) = R(w^*(L)) = R(w_L)$ is Bayes-optimal at $L$
  by (R-EE).
- For $m = R$ (right endpoint): symmetric.
- For $m \notin M$: $q(\{m\}) = 0$, trivially OK.

Therefore Definition 2 holds $q$-a.e.

### Step 6 — Strict generalization
The binary case of Theorem 2 in the paper assumes finite $M$ and
$\Theta$. Our result holds for ARBITRARY $M, \Theta$ (paper standing:
$\Theta$ compact metric, $M$ Borel in $\Delta(\Omega)$) under the
three regularity conditions, all of which are economically meaningful
and not equivalent to menu-Hall.

## What I want you to produce

A FULLY RIGOROUS proof of the capstone theorem, in the structure:

```
# Theorem (Binary-state infinite-extension of Theorem 2)

## Statement
(Full statement with $\alpha \in (0,1)$, the three regularity
conditions, and the explicit $(\hat\sigma^*, \hat\beta^*)$.)

## Hypotheses
- (H1) Standing.
- $|\Omega| = 2$.
- $\alpha \in (0, 1)$.
- (R-EE), (R-TD), (R-IES).

## Proof (Steps 1-6)
Each step cites the appropriate lemma.

## Economic interpretation of the three regularity conditions
- (R-EE): unique Bayes action at trust-region endpoints.
- (R-TD): τ no-atom at the tie belief.
- (R-IES): proper interior trust region.
All three are primitive structural conditions on $(\tau, u)$, not
calibration conditions on the optimization output.

## Comparison with v8 architecture
v8 Tier 1a/1b/2 architecture has menu-Hall as Tier 2 hypothesis. The
v9 binary capstone (this theorem) does NOT use menu-Hall — instead it
uses (R-EE)+(R-TD)+(R-IES). Compare:
- v8 menu-Hall: requires a calibrated kernel to EXIST on the menu
  engine output $C^* \subseteq W$. This is a condition on the
  optimization solution.
- v9 (R-EE)+(R-TD)+(R-IES): primitive conditions on the model itself,
  imply the existence of a calibrated kernel via L_B1 + L_B3 + L_B5.

## Compatibility with v8 sharpness package
WTA ternary witness has $|\Omega| = 3$. This theorem is binary
$|\Omega| = 2$ only. No conflict.

## Open issues
- Extension to $|\Omega| \ge 3$ remains open (the deletion-compatible
  Hall duality problem).
- Smoothness extensions of (R-EE), (R-TD), (R-IES) (e.g., what if τ
  has atoms?) — these are special cases / refinements.
```

## Output Contract

- Inline as plain markdown.
- Be rigorous. This is the CAPSTONE — every step must cite the right
  lemma + paper.
- Verify that the three regularity conditions are NOT equivalent to
  menu-Hall.
- End with a one-line verdict (PASS/PATCH_SMALL/etc.) on YOUR OWN
  capstone + next-step signal. The real verification will be on a
  fresh reviewer chat.

## Constraints

- Banned re-proposals: see prior_attempts_digest.md.
- Use L_B1, L_B3, L_B5 as inputs (they're in the durable sources).
- v9 T1 may be cited as proven.
- Per user: keep going. If the capstone has gaps, identify them
  precisely and propose remedies.
