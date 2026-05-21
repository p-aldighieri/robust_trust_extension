
========
ROLE: user (id=de31ddd9-71cf-4ab9-b175-bff10b50f3f6)
========
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

Show more

========
ROLE: assistant (id=80b2e372-8c9a-4938-81bc-627276cabe42)
========
Theorem (Binary-state infinite-extension of Theorem 2)
Statement

Let the standing hypotheses of Robust Trust hold: finite state space, full-support prior, compact metric A and Θ, bounded utility u(a,ω,θ) continuous in a, conditional independence of adviser posterior s and type θ given ω, and Borel measurability conventions. In the paper’s notation, the robust objective is

U(σ)=αE
id,σ
	​

[u]+(1−α)
β∈B
inf
	​

E
β,σ
	​

[u],

and robust rationalizability asks for an adversarial β
∗
 such that the continuation 
σ
^
(m) is Bayes-optimal under P
β
∗
	​

(⋅∣m). 

objective_statement

Assume additionally:

∣Ω∣=2, with beliefs identified with m=Pr(ω=1)∈[0,1].

α∈(0,1).

The optimal trust region is a proper interval

T
∗
=[L,R],0<L<R<1.

(R-EE) Endpoint exposure. If w
L
	​

:=w
∗
(L) and w
R
	​

:=w
∗
(R), then

B
W
	​

(w
L
	​

)={L},B
W
	​

(w
R
	​

)={R},

where

B
W
	​

(w):={μ∈[0,1]:w∈arg
z∈W
max
	​

μ⋅z}.

(R-TD) Tie discipline. The endpoint row-minimizer tie set

N
0
	​

:={s∈M:s⋅w
L
	​

=s⋅w
R
	​

}

is τ-null.

(R-IES) Interior endpoint stationarity. The optimum is interior, so the endpoint first-order stationarity equalities hold rather than one-sided Kuhn-Tucker inequalities.

Then there exists a robustly rationalizable optimal strategy in the infinite-space q-a.e. sense. More precisely, there is an optimal TRS

σ
^
∗
(m)=R(w
∗
(Π
[L,R]
	​

(m))),

and an adversarial kernel 
β
^
	​

∗
 such that, if

q=(γ
α
	​

)
2
	​

,γ
α
	​

=α(id,id)
#
	​

τ+(1−α)τ⊗
β
^
	​

∗
,

then

σ
^
∗
(m)∈arg
σ
^
′
max
	​

U(
σ
^
′
,P
β
^
	​

∗
	​

(⋅∣m))for q-a.e. m∈M.

Since in infinite message spaces P
β
∗
	​

(⋅∣m) is itself only defined q
β
∗
	​

-a.e., the q-a.e. formulation is the natural infinite-space reading of Definition 2. 

theorem_2_extension_proof_v8

Small correction to the displayed kernel in the prompt

The misaligned kernel should not send every interior source s∈[L,R]∩M truthfully. That would generally fail adversarial optimality: a misaligned interior source still minimizes over endpoint payoff images. The truthful δ
s
	​

 contribution on interior messages comes from the aligned component α(id,id)
#
	​

τ, not from 
β
^
	​

∗
.

So define the endpoint minimizer regions on all of M, not only outside [L,R]:

S
+
	​

:={s∈M:s⋅w
L
	​

<s⋅w
R
	​

},S
−
	​

:={s∈M:s⋅w
R
	​

<s⋅w
L
	​

}.

By (R-TD),

M=S
+
	​

⊔S
−
	​

⊔N
0
	​

up to τ-null sets.

The constructed kernel is

β
^
	​

∗
(⋅∣s)=
⎩
⎨
⎧
	​

κ
L
	​

(⋅∣s),
κ
R
	​

(⋅∣s),
δ
s
	​

,
	​

s∈S
+
	​

,
s∈S
−
	​

,
s∈N
0
	​

 or other τ-null leftovers.
	​


The final δ
s
	​

 line is harmless because it is used only on a τ-null set. The aligned channel remains truthful for every s.

Hypotheses

(H1) Standing. The standing model of Robust Trust: Ω finite, full-support prior, compact metric A,Θ, bounded u continuous in a, conditional independence of s,θ given ω, Borel measurability.

∣Ω∣=2.

α∈(0,1).

(R-EE), (R-TD), (R-IES).

The paper’s Theorem 2 proves robust-rationalizable existence under finite M and finite Θ; the current theorem removes those finiteness restrictions in the binary-state case under the three regularity conditions. 

objective_statement

Proof
Step 1 — TRS interval reduction

By the value-existence/menu-engine tier already banked in v8, an optimal strategy exists under the standing hypotheses without finite M or finite Θ. The paper’s Theorem 1 then says any optimal strategy is equivalent to a TRS with a connected trust region. In a binary state space, beliefs live in [0,1], so every compact connected trust region is an interval. Thus we may take an optimal TRS with

T
∗
=[L,R].

By (R-IES), 0<L<R<1.

The paper’s proof of Theorem 1 uses the payoff-profile set W, compactness and convexity of W, and replacement of non-Bayes-optimal continuations by Bayes-optimal dominating private strategies. 

Robust_trust_Dworczak_Smolin

Let

w
μ
	​

:=w
∗
(μ)∈arg
w∈W
max
	​

μ⋅w,

and write w
L
	​

=w
∗
(L), w
R
	​

=w
∗
(R). The TRS continuation is

σ
^
∗
(m)=R(w
∗
(Π
[L,R]
	​

(m))),

where Π
[L,R]
	​

(m)=L for m≤L, Π
[L,R]
	​

(m)=m for m∈[L,R], and Π
[L,R]
	​

(m)=R for m≥R.

Step 2 — Endpoint-only adversarial payoff image

By Lemma L
B3
	​

, for every source belief s∈[0,1],

μ∈[L,R]
inf
	​

s⋅w
∗
(μ)=min{s⋅w
L
	​

, s⋅w
R
	​

}.

The nonsmooth proof uses convexity of the indirect value function and monotonicity of subgradients: every interior supporting line is dominated, for minimization, by one of the two endpoint supporting lines. 

prover_06_response

Thus the misaligned adviser can attain the rowwise infimum using only endpoint payoff images. Define

S
+
	​

:={s∈M:s⋅w
L
	​

<s⋅w
R
	​

},S
−
	​

:={s∈M:s⋅w
R
	​

<s⋅w
L
	​

}.

The tie set N
0
	​

={s:s⋅w
L
	​

=s⋅w
R
	​

} is τ-null by (R-TD). Since the endpoint payoff comparison is affine in s, S
+
	​

, S
−
	​

, and N
0
	​

 are Borel.

By the endpoint-min proof, outside the tie set:

S
+
	​

⊆[L,1]∩M,S
−
	​

⊆[0,R]∩M.

So s−L≥0 on S
+
	​

, and R−s≥0 on S
−
	​

.

Step 3 — Endpoint stationarity and total balance

By Lemma L
B5
	​

, under (R-EE), (R-TD), and (R-IES), the endpoint stationarity equations are

α∫
[0,L]∩M
	​

(L−m)τ(dm)=(1−α)∫
S
+
	​

	​

(s−L)τ(ds),
(TB-L)

and

α∫
[R,1]∩M
	​

(m−R)τ(dm)=(1−α)∫
S
−
	​

	​

(R−s)τ(ds).
(TB-R)

Here is the mechanism. The finite-menu Clarke-Danskin theorem supplies endpoint multipliers. The normalized posterior at the left endpoint belongs to B
W
	​

(w
L
	​

), and the normalized posterior at the right endpoint belongs to B
W
	​

(w
R
	​

). Endpoint exposure collapses those cones to {L} and {R}. R-TD removes positive-mass endpoint-minimizer ties, so the multiplier weights reduce to the indicator regions 1
S
+
	​

	​

 and 1
S
−
	​

	​

. R-IES makes these equalities rather than boundary inequalities. This is exactly the nonsmooth analogue of the paper’s smooth equations (6)-(7), where the average posterior induced by the left and right message regions must equal the corresponding interval endpoint. 

prover_06_response

The smooth binary section of the paper explicitly states the same intuition: the best response of the agent requires the average posterior induced by messages on each side of the trust region to equal the relevant endpoint, and equations (6)-(7) encode those two average-posterior equalities. 

Robust_trust_Dworczak_Smolin

Step 4 — Apply Lemma B1 on both endpoint fibers

Define the left endpoint target fiber and source region:

A
L
	​

:=[0,L]∩M,S
+
	​

.

Define finite measures

η
L
	​

(X):=α∫
X∩A
L
	​

	​

(L−m)τ(dm),
ν
L
	​

(Y):=(1−α)∫
Y∩S
+
	​

	​

(s−L)τ(ds).

By (TB-L),

η
L
	​

(A
L
	​

)=ν
L
	​

(S
+
	​

)<∞.

Lemma B1 applies with p=L, A
−
	​

=A
L
	​

, and source set S
+
	​

. Hence there is a Borel kernel

κ
L
	​

:S
+
	​

→Δ(A
L
	​

)

such that for every Borel X⊆A
L
	​

,

(1−α)∫
S
+
	​

	​

(s−L)κ
L
	​

(X∣s)τ(ds)=α∫
X
	​

(L−m)τ(dm).
(B1-L)

Moreover, provided there is no extra traffic into A
L
	​

, the posterior satisfies

P
β
^
	​

∗
	​

(ω=1∣m)=Lfor q-a.e. m∈A
L
	​

.
(Cal-L)

Lemma B1 is atom-blind: the proof uses tilted measure coupling, disintegration, and Radon-Nikodym Bayes rule, not atomlessness or densities. 

prover_05_response

Now define the right endpoint fiber and source region:

A
R
	​

:=[R,1]∩M,S
−
	​

.

Define

η
R
	​

(X):=α∫
X∩A
R
	​

	​

(m−R)τ(dm),
ν
R
	​

(Y):=(1−α)∫
Y∩S
−
	​

	​

(R−s)τ(ds).

By (TB-R),

η
R
	​

(A
R
	​

)=ν
R
	​

(S
−
	​

)<∞.

The symmetric part of Lemma B1 gives a Borel kernel

κ
R
	​

:S
−
	​

→Δ(A
R
	​

)

such that for every Borel X⊆A
R
	​

,

(1−α)∫
S
−
	​

	​

(R−s)κ
R
	​

(X∣s)τ(ds)=α∫
X
	​

(m−R)τ(dm),
(B1-R)

and the posterior satisfies

P
β
^
	​

∗
	​

(ω=1∣m)=Rfor q-a.e. m∈A
R
	​

.
(Cal-R)

The symmetric right-fiber version is stated and proved in B1 by flipping the signs. 

prover_05_response

Step 5 — Assemble 
β
^
	​

∗

Define the full misaligned kernel:

β
^
	​

∗
(⋅∣s)=
⎩
⎨
⎧
	​

κ
L
	​

(⋅∣s),
κ
R
	​

(⋅∣s),
δ
s
	​

,
	​

s∈S
+
	​

,
s∈S
−
	​

,
s∈N
0
	​

.
	​


Since S
+
	​

, S
−
	​

, and N
0
	​

 are Borel, and κ
L
	​

,κ
R
	​

 are Borel kernels, 
β
^
	​

∗
 is a Borel kernel. The value on N
0
	​

 is immaterial because τ(N
0
	​

)=0.

The no-extra-fiber-traffic condition required by B1 is automatically satisfied:

Into A
L
	​

: only κ
L
	​

 sends mass there. κ
R
	​

 is supported on A
R
	​

, and N
0
	​

 is τ-null.

Into A
R
	​

: only κ
R
	​

 sends mass there. κ
L
	​

 is supported on A
L
	​

, and N
0
	​

 is τ-null.

Thus B1 applies cleanly on both endpoint fibers. The previous B1 pass explicitly flags this no-extra-traffic clause as the necessary bookkeeping condition for posterior calibration. 

prover_05_response

Step 6 — 
β
^
	​

∗
 is adversarial against 
σ
^
∗

Fix s∈
/
N
0
	​

.

If s∈S
+
	​

, then s⋅w
L
	​

<s⋅w
R
	​

, and Lemma L
B3
	​

 gives

s⋅w
L
	​

=
μ∈[L,R]
inf
	​

s⋅w
∗
(μ).

Every message m∈A
L
	​

=[0,L]∩M is projected by the TRS to L, so it induces payoff profile w
L
	​

. Since κ
L
	​

(⋅∣s) is supported on A
L
	​

, every message in its support attains the rowwise infimum.

If s∈S
−
	​

, the same argument with R and A
R
	​

 shows that every message in the support of κ
R
	​

(⋅∣s) attains the rowwise infimum.

Therefore 
β
^
	​

∗
 minimizes the misaligned payoff row-by-row for τ-a.e. s. Hence

β
^
	​

∗
∈arg
β∈B
min
	​

E
β,
σ
^
∗
	​

[u],

so 
β
^
	​

∗
 is adversarial against 
σ
^
∗
.

This is the binary escape hatch from the general menu-Hall dragon: the adversary is not forced to solve a multidimensional posterior-cone transport problem. The endpoint fibers reduce the problem to two scalar signed-balance transports.

Step 7 — Verify Definition 2, q-a.e.

Let

γ
α
	​

=α(id,id)
#
	​

τ+(1−α)τ⊗
β
^
	​

∗
,q=(γ
α
	​

)
2
	​

.

Let r(m)=P
β
^
	​

∗
	​

(ω=1∣m), defined q-a.e. by Radon-Nikodym Bayes rule.

Case 1: m∈(L,R)∩M

The misaligned kernel 
β
^
	​

∗
 puts no mass on (L,R): κ
L
	​

 is supported on A
L
	​

, κ
R
	​

 is supported on A
R
	​

, and N
0
	​

 is τ-null. Hence, for every Borel X⊆(L,R)∩M,

q(X)=ατ(X),

and the state-1 numerator is

n(X)=α∫
X
	​

mτ(dm).

Thus

r(m)=mfor q-a.e. m∈(L,R)∩M.

By the TRS definition,

σ
^
∗
(m)=R(w
∗
(m)),

which is Bayes-optimal at belief m. Therefore

σ
^
∗
(m)∈arg
σ
^
′
max
	​

U(
σ
^
′
,r(m))q-a.e. on (L,R)∩M.
Case 2: m∈A
L
	​

=[0,L]∩M

By Lemma B1 applied at p=L, and by the no-extra-traffic property,

r(m)=Lfor q-a.e. m∈A
L
	​

.

For every m∈A
L
	​

, the TRS projects m to L, so

σ
^
∗
(m)=R(w
L
	​

).

Since w
L
	​

=w
∗
(L) is Bayes-optimal at L, 
σ
^
∗
(m) is Bayes-optimal under posterior L. Thus

σ
^
∗
(m)∈arg
σ
^
′
max
	​

U(
σ
^
′
,r(m))q-a.e. on A
L
	​

.
Case 3: m∈A
R
	​

=[R,1]∩M

Symmetrically, Lemma B1 gives

r(m)=Rfor q-a.e. m∈A
R
	​

.

The TRS projects every m∈A
R
	​

 to R, so

σ
^
∗
(m)=R(w
R
	​

),

which is Bayes-optimal under posterior R. Hence

σ
^
∗
(m)∈arg
σ
^
′
max
	​

U(
σ
^
′
,r(m))q-a.e. on A
R
	​

.
Case 4: m∈
/
M

The message marginal q is supported on M, because both aligned and misaligned messages are in M. Therefore messages outside M are q-null.

Combining the cases:

σ
^
∗
(m)∈arg
σ
^
′
max
	​

U(
σ
^
′
,P
β
^
	​

∗
	​

(⋅∣m))q-a.e. m∈M.

Since 
β
^
	​

∗
 is adversarial against 
σ
^
∗
, 
σ
^
∗
 is robustly rationalizable in the infinite-space q-a.e. reading of Definition 2.

This proves the theorem. □

Economic interpretation of the three regularity conditions
(R-EE) Endpoint exposure

Formally, (R-EE) says the Bayes cone of each endpoint payoff profile is a singleton:

B
W
	​

(w
L
	​

)={L},B
W
	​

(w
R
	​

)={R}.

This is the exact binary condition that turns the Clarke-Danskin endpoint multiplier into the scalar endpoint belief. Without it, stationarity gives only cone membership, not the equality P(ω=1∣m)=L or R.

Economically, it says the endpoint continuation is locally pinned down by exactly one posterior. A clean primitive sufficient condition is a smooth, strictly curved Pareto frontier in payoff-profile space, for example when the downstream payoff problem yields a unique Bayes action at each belief. In continuous-action models, strict concavity of u(a,ω,θ) in a for each (ω,θ) is a standard route to uniqueness.

In finite-action/polyhedral models, the precise primitive condition is not merely “unique action at L”; it is that the normal cone of W at w
L
	​

 intersects the binary simplex only at L. At vertices, normal cones can be intervals, so one should check singleton cone exposure directly. The condition is economically meaningful, but it is not a hidden transport condition.

(R-TD) Tie discipline

The tie between w
L
	​

 and w
R
	​

 is

s⋅(w
L
	​

−w
R
	​

)=0.

In binary, this is one affine equation in one scalar s. Unless the two endpoint profiles coincide, it identifies at most one tie belief s
∗
. Thus (R-TD) is simply

τ({s
∗
})=0.

It holds automatically for atomless τ, and it is the exact condition that lets the endpoint minimizer regions S
+
	​

 and S
−
	​

 partition M up to null sets. If τ has an atom at the tie belief, a tie-splitting version of L
B5
	​

 is needed.

(R-IES) Interior endpoint stationarity

(R-IES) says the optimal trust interval is a proper interior interval:

0<L<R<1.

This rules out corner cases where stationarity becomes a one-sided inequality. Economically, it says the agent neither ignores the adviser completely nor fully trusts all reports, and the optimum balances marginal aligned gains against marginal adversarial losses at both endpoints. Smooth utility, full-support τ, and nondegenerate information value are typical primitive routes to this behavior.

Strictly speaking, as written, (R-EE) and (R-IES) are solution-local regularity assumptions: they refer to the selected optimal endpoints. Their primitive content is that the underlying payoff geometry and signal distribution generate exposed, interior endpoints. They are still not menu-Hall: they do not assert the existence of any calibrated message kernel.

Comparison with v8 architecture

The v8 theorem had three tiers: Tier 1a gave value optimality plus ε-adversaries under standing hypotheses; Tier 1b added exact-contact for exact adversary attainment; Tier 2 added menu-Hall for full robust rationalizability. The closure memo explicitly notes that v8 Tier 2 carries menu-Hall and is therefore not an unrestricted proof of Theorem 2. 

project_closure_memo

The binary capstone does not assume menu-Hall. Instead, it proves the needed calibration by the chain:

endpoint-only image (L
B3
	​

)+endpoint stationarity (L
B5
	​

)+scalar endpoint-fiber lift (B1).

The difference is structural:

v8 menu-Hall asks directly for a kernel supported on rowwise minimizers whose induced posteriors lie in Bayes cones q-a.e. That is a calibration condition on the optimal labeling.

Binary v9 conditions impose endpoint exposure, tie discipline, and interior stationarity. These imply the two scalar balance identities, and B1 constructs the calibrated kernels.

Thus (R-EE)+(R-TD)+(R-IES) are sufficient for the binary menu-Hall conclusion, but they are not equivalent to menu-Hall. They are not necessary: menu-Hall may still hold with endpoint ties, non-singleton Bayes cones, or corner solutions after appropriate tie-splitting or inequality handling. Conversely, in the binary regular case, they are strong enough to construct the kernel rather than postulate it.

Compatibility with v8 sharpness package

No conflict. The v8 sharpness witness is ternary winner-takes-all with ∣Ω∣=3, and the obstruction is explicitly multidimensional vector balance. The closure memo classifies that witness as a menu-engine artefact rather than a primitive counterexample to unrestricted Theorem 2. 

project_closure_memo

Lemma B1 is binary only: the posterior-calibration problem collapses to a single signed scalar balance on each endpoint fiber. The previous B1 pass explicitly states that the ternary WTA sharpness package does not conflict with this binary scalar lift. 

prover_05_response

Open issues

Extension to ∣Ω∣≥3 remains open. The deletion-compatible Hall duality problem is still the real dragon in higher dimensions.

Tie atoms. If τ has an atom at the endpoint tie belief, (R-TD) fails. A refined theorem should replace S
+
	​

, S
−
	​

 by a measurable tie-splitting rule and use the weighted version of L
B5
	​

.

Non-exposed endpoints. If B
W
	​

(w
L
	​

) or B
W
	​

(w
R
	​

) is an interval, stationarity yields cone membership rather than equality to L or R. A cone-valued endpoint version may still be possible, but it is not the clean scalar capstone proved here.

Corner trust regions. If L=0 or R=1, the balance equations become one-sided inequalities. That is a boundary refinement, not a contradiction.

Verdict: PATCH_SMALL → PASS. The capstone proof closes after the small but essential correction that the misaligned kernel routes all non-tie sources through the two endpoint fibers; truthful interior reporting belongs to the aligned channel, not to the adversarial kernel. Next step: send this capstone to a fresh reviewer, with the kernel-branch correction highlighted in neon chalk.
