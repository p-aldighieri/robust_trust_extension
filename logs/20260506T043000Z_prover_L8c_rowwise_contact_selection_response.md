
========
ROLE: user (id=cd3c03c6-3120-4729-85a3-59081b6f22a0)
========
# Prover pass — L8c: Rowwise contact-selection lemma

You are the Prover in the soft-scaffolding workflow.

## Goal for this pass

Prove (or honestly disprove) **Lemma L8c**: rowwise contact-selection
for the Branch-A representative.

If proved, this **closes L8 immediately** via the Dirac kernel
$\beta^*(dm\mid s) := \delta_{m^*(s)}(dm)$.

If disproved (or not derivable from current hypotheses), produce the
**explicit obstruction** and identify the Needed Assumption that would
close it.

## Inputs

- phil_reny_route_memo.md — Branch A complete; Route 3c primary;
  L8c is the picked sub-target (rowwise measurable argmin).
- phil_reny_bundle.md, prior_attempts_digest.md, paper PDF.
- L8a logs (essential-inf formula, (A8-flat) criterion).
- L6 log (bottom-density: $\inf_F = \inf_B = U^*$).
- Route 3c breakdown
  (logs/20260506T040000Z_breakdown_branch_B_route_3c_response.md).

## Target — Lemma L8c

Let $\sigma^*$ be the Branch-A strategy (after L5 modification off
$K^*$). Define the row payoff
$$
\ell(m,s) := \sum_{\omega\in\Omega} s(\omega)\,\int_\Theta\int_A u(a,\omega,\theta)\,\hat\sigma^*(m,\theta)(da)\,f(d\theta\mid\omega).
$$

**Claim.** Under standing + (A5), there exists a τ-null set $N\subseteq M$
such that for every $s\in M\setminus N$:
$$
A(s) := \big\{m\in M : \ell(m,s) = \inf_{m'\in M}\ell(m',s) = \operatorname*{essinf}_{m'\sim\tau}\ell(m',s)\big\}
$$
is **nonempty** and **closed**, and the correspondence $s\mapsto A(s)$
is **weakly measurable**. Hence by Kuratowski–Ryll-Nardzewski (or
Aliprantis–Border 18.13), there is a Borel selector $m^*: M\setminus N\to M$,
extended arbitrarily on $N$, such that
$\beta^*(dm\mid s) := \delta_{m^*(s)}(dm)$ satisfies
$U(\beta^*,\sigma^*) = \inf_{\beta\in B} U(\beta,\sigma^*) = U^*$.

## Two halves

The breakdown identified two halves:

**Half 1 (probably easier).** Pointwise inf = essential inf for τ-a.e.
$s$. Uses L6 bottom-density: $\inf_F = \inf_B = U^*$, then a row-by-row
extraction. Specifically:
- $\inf_m \ell(m,s) \le \operatorname*{essinf}_m \ell(m,s)$ pointwise.
- L6 + bottom-density gives equality of the **integrated** lower
  bounds: $\int_M \inf_m \ell(m,s)\,\tau(ds) = \int_M \operatorname*{essinf}_m \ell(m,s)\,\tau(ds)$.
- Pointwise dominance + integral equality ⇒ pointwise equality τ-a.e.

**Half 2 (the hard half).** Pointwise inf is **attained** for τ-a.e.
$s$. This is NOT free — even with pointwise = essential equality, a
minimizing sequence may converge to a boundary point in $M$ where
$\ell$ has a jump. Key questions:
1. Is $\ell(\cdot, s)$ **lower semicontinuous** on $M$? If yes,
   compactness of $M$ ⇒ attainment.
2. If not l.s.c., does a contact condition still hold (as in the L8a
   review's contact criterion)?
3. Can the L5 Lusin shells $K_n$ be exploited to produce attainment
   even without global l.s.c.?

## Subquestions you MUST address

1. **Half 1.** Prove pointwise inf = essential inf τ-a.e. using L6 +
   bottom-density. Verify the row extraction is rigorous.
2. **Lower semicontinuity of $\ell(\cdot,s)$.** Is $\ell(\cdot,s)$
   l.s.c. on $M$?
   - From L5: $\sigma^*$ is continuous on each $K_n$ in the Balder
     stable private-strategy topology, hence $p_\omega$ is continuous
     on each $K_n$, hence $\ell(\cdot,s)$ is continuous on each $K_n$.
   - On $M\setminus K^*$: $\sigma^*$ is constant (= $\sigma_0^*(\cdot\mid m_0,\cdot)$),
     so $\ell(m,s) = \ell(m_0,s)$ for $m\notin K^*$.
   - **But:** as the L8a reviewer noted, continuity on each $K_n$ does
     NOT imply l.s.c. on $K^* = \bigcup K_n$. Sequences crossing shells
     can have jumps.
   - **Question:** is $\ell(\cdot,s)$ l.s.c. anyway by some additional
     argument, or do we need an l.s.c. modification?
3. **L.s.c. modification.** If $\ell$ is not l.s.c., consider replacing
   $\hat\sigma^*$ with an "l.s.c. modification" $\hat{\hat\sigma}^*$
   that's also a representative of the Branch-A quotient class and that
   makes $\ell$ l.s.c. Does such a modification exist while preserving
   $\sigma^*$'s value-securing property?
4. **Direct attainment via Lusin shells.** Even without l.s.c., maybe
   attainment can be argued: on each $K_n$, $\ell(\cdot,s)$ is
   continuous on the compact $K_n$, hence attains its min; let
   $m_n^*(s) := \arg\min_{m\in K_n}\ell(m,s)$. By compactness, the
   sequence $(m_n^*(s))$ has a cluster point $m^\infty(s)\in M$. Does
   $\ell(m^\infty(s),s) = \inf_m\ell(m,s)$? This requires a
   "no-discontinuity-at-the-cluster-point" argument.
5. **Joint measurability.** The selector $m^*: M\setminus N\to M$ must
   be Borel-measurable. Verify the argmin correspondence has the
   required structure (closed-valued, weakly measurable).
6. **Bayes-optimality (preview of L9).** If $\beta^*(dm\mid s) = \delta_{m^*(s)}(dm)$
   is the adversary, the induced posterior $P_{\beta^*}(\cdot\mid m)$ is
   only defined for $m$ in the image of $m^*$; this is a τ-null set in
   general. **Note:** L9 / Definition 2 may require a posterior version
   choice on null-set messages. Flag this for the L9 pass; do not solve
   here.
7. **Honest abort.** If neither pointwise attainment nor l.s.c.
   modification works, what's the Needed Assumption? E.g., "$\ell(\cdot,s)$
   is l.s.c. on $M$ for τ-a.e. $s$" or "$\hat\sigma^*$ admits an l.s.c.
   representative."

## Output Format


markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: L8c — Rowwise contact-selection

**Verdict:** PROVED unconditionally / PROVED-CONDITIONAL on Needed Assumption / DISPROVED.

**Argument:**

Step 1 (Half 1): Pointwise inf = essential inf τ-a.e.
Justification: ...

Step 2 (Half 2): Pointwise inf attained for τ-a.e. s.
Justification: ... (l.s.c., or l.s.c. modification, or Lusin-shell
cluster-point argument, or honest abort.)

Step 3: Measurable selection.
Justification: ...

Step 4: $\beta^* = \delta_{m^*(s)}$ closes L8.
Justification: (Affineness + L6 bottom + Half 2 attainment.)

[DERIVED] (State exactly what was established. If conditional, state the
hypothesis precisely.)

## Assumption Changes

- [ASSUMPTION+] (If Half 2 needs an l.s.c. or contact assumption.)

## Breakdown Amendments

- [BREAKDOWN_AMEND] (If route memo needs repair.)

## Status Summary

- L8c status: PROVED / PROVED-CONDITIONAL / DISPROVED.
- L8 status (conditional on L8c): PROVED / OPEN.

## Exact Next Obstacle

(If L8c closes L8 unconditionally: L9 — per-message Bayes-optimality.
If L8c is conditional: a planning pass to decide whether to publish
under the new assumption or pivot.)


## Non-Negotiable Rules

- **Be honest.** If Half 2 has a real gap, state the Needed Assumption
  precisely.
- Do NOT use product-narrow Sion or any dead-route machinery.
- Length budget: 2500–4000 words.

## Scope Policy

L8c is the focused target. Do NOT attempt L9 (only flag for it).


========
ROLE: assistant (id=44462e84-246f-4fd0-b179-0d5fd7dadc42)
========
Goal for This Pass

The pass tests whether the Branch-A value-securing strategy σ
∗
, after the L5 null-set modification, also admits a rowwise adversary selector m
∗
(s) attaining the pointwise lower payoff. This would upgrade Branch A from “the agent secures U
∗
” to L8 adversary-side attainment by the Dirac kernel β
∗
(dm∣s)=δ
m
∗
(s)
	​

(dm). The paper’s Theorem 2 needs both an adversarial β
∗
 and per-message Bayes optimality, and the route memo correctly isolates L8 as the next missing piece after Branch A. 

Robust_trust_Dworczak_Smolin

 

phil_reny_route_memo

Main Work
Target 1: L8c, Rowwise contact-selection

Verdict: DISPROVED / not derivable from current hypotheses as stated.
Conditional result: PROVED under a rowwise l.s.c. or contact assumption.

Half 1 is valid: pointwise infimum equals essential infimum for τ-a.e. row s. Half 2 is the real gap: current hypotheses do not force the pointwise infimum to be attained. The obstruction is a null-boundary upward jump created or left unresolved by the Lusin-shell construction. Continuity on each K
n
	​

 is not enough to prevent a minimizing sequence from converging to a point outside the continuity shell, or to a future-shell boundary, where ℓ jumps upward.

Argument:

Step 1: Half 1, pointwise inf = essential inf τ-a.e.

Define

p
ω
	​

(m):=∫
Θ
	​

∫
A
	​

u(a,ω,θ)
σ
^
∗
(m,θ)(da)f(dθ∣ω),

so that

ℓ(m,s)=
ω∈Ω
∑
	​

s(ω)p
ω
	​

(m).

By Bayes’ rule for posterior-valued signals,

μ
0
	​

(ω)π(ds∣ω)=s(ω)τ(ds),

and hence the misaligned part of the payoff against a kernel β∈B can be written as

C(β)=∫
M
	​

∫
M
	​

ℓ(m,s)β(dm∣s)τ(ds).

Similarly, for a dominated restricted kernel β
φ
	​

(dm∣s)=φ(m∣s)τ(dm),

C
F
	​

(φ)=∫
M
	​

∫
M
	​

ℓ(m,s)φ(m∣s)τ(dm)τ(ds).

Let

a(s):=
m∈M
inf
	​

ℓ(m,s),e(s):=
m∼τ
essinf
	​

ℓ(m,s).

Then a(s)≤e(s) pointwise.

For full kernels B,

β∈B
inf
	​

C(β)=∫
M
	​

a(s)τ(ds).

The lower bound is immediate because ℓ(m,s)≥a(s) for every m. For the reverse inequality, since M is compact metric and ℓ is bounded Borel, the multifunction of 1/n-minimizers has an analytic graph; Jankov-von Neumann, followed by a Borel modification on a τ-null set, gives a measurable d
n
	​

(s) such that

ℓ(d
n
	​

(s),s)≤a(s)+1/n

for τ-a.e. s. The deterministic kernel δ
d
n
	​

(s)
	​

 gives

β∈B
inf
	​

C(β)≤∫a(s)dτ+1/n,

and n→∞ gives equality.

For the restricted dominated class F, the L8a formula gives

φ∈F
inf
	​

C
F
	​

(φ)=∫
M
	​

e(s)τ(ds),

with the restricted dual value written as the aligned constant plus (1−α)∫e(s)dτ(s). The route memo records exactly this formula and the associated A8-flat criterion. 

phil_reny_route_memo

Now use the L6 Branch-A bottom-density conclusion. For the fixed Branch-A σ
∗
, L6 gives equality of the unrestricted and restricted bottoms: V
∗
=U
∗
, σ
∗
 achieves U
∗
, and inf
B
	​

U(⋅,σ
∗
)=inf
F
	​

U
F
	​

(σ
∗
,⋅). 

phil_reny_route_memo

 In the nontrivial adversary case 1−α>0, subtracting the common aligned term and dividing by 1−α gives

β∈B
inf
	​

C(β)=
φ∈F
inf
	​

C
F
	​

(φ).

Therefore

∫
M
	​

a(s)τ(ds)=∫
M
	​

e(s)τ(ds).

Since a≤e and both are bounded measurable, it follows that

a(s)=e(s)for τ-a.e. s.

So Half 1 is proved. The row-extraction is rigorous: the full-kernel infimum is the integral of the pointwise infimum, while the dominated-kernel infimum is the integral of the essential infimum.

The edge case α=1 should be separated. Then the adversary term vanishes and L8 is trivial with any β, but L8c as a statement about ℓ is not forced by payoff equality.

Step 2: Half 2, pointwise infimum is not guaranteed to be attained

The current regularity is:

p
ω
	​

, hence ℓ(⋅,s), is continuous on each Lusin compact K
n
	​

.

K
n
	​

↑K
∗
, with τ(K
∗
)=1.

Off K
∗
, the representative is modified to behave like a fixed m
0
	​

∈K
∗
. 

phil_reny_route_memo

This does not imply lower semicontinuity on M. The problem is a little cliff hidden at a null boundary.

A bare row obstruction is:

M=[0,1],τ=Lebesgue,K
n
	​

=[1/n,1],K
∗
=(0,1],

and

g(m)={
m,
1,
	​

m>0,
m=0.
	​


Then g is continuous on every K
n
	​

, and it is constant off K
∗
 in the L5 sense if m
0
	​

=1, since g(0)=g(1)=1. But

m∈[0,1]
inf
	​

g(m)=0=
m∼τ
essinf
	​

g(m),

and the infimum is not attained. The putative argmin set is empty.

This example is compatible with the posterior-measure structure under (A5): take binary states, prior 1/2, τ uniform on [0,1], and state-conditional laws

π(dx∣1)=2xdx,π(dx∣0)=2(1−x)dx.

Both are equivalent to τ, since their densities vanish only at τ-null endpoints. It is also realizable as a row payoff: take Θ singleton, A=[0,1], u(a,ω)=a, and the measurable strategy a(m)=g(m). Then p
0
	​

=p
1
	​

=g, so ℓ(m,s)=g(m).

There is also a direct Branch-A representative obstruction if the allowed edge case α=1 is kept. Let u(a,1)=−(1−a)
2
, u(a,0)=−a
2
, A=[0,1], and let the aligned-optimal strategy be a(m)=m on (0,1], modified at the null point 0 to a(0)=1, exactly as an L5 off-K
∗
 representative can do. Since τ({0})=0, the aligned value is unchanged, so this remains Branch-A optimal when α=1. For a row s=x∈(1/2,1],

ℓ(m,x)=−(a(m)−x)
2
−x(1−x),

whose infimum is approached by a(m)↓0 along m>0, but is not attained because a(0)=1. Thus L8c is literally false as stated if α=1 is allowed. In the nontrivial 1−α>0 case, the same construction is the exact regularity obstruction: the current proof record has no condition excluding such upward jumps at τ-null contact points.

The Lusin-shell cluster argument fails for the same reason. In the toy row example, the minimizer on K
n
	​

 is m
n
	​

=1/n, with g(m
n
	​

)=1/n→0. The cluster point is 0, but g(0)=1. Compactness gives a cluster point; shellwise continuity does not give contact at the cluster point. The sequence falls through a trapdoor between the shells.

Step 3: L.s.c. modification is not available from current hypotheses

One might try replacing ℓ by its lower-semicontinuous envelope 
ℓ
ˇ
. In the toy example, 
g
ˇ
	​

(0)=0<g(0)=1, so the envelope has a minimizer at 0, but the original row payoff does not. A selector for 
ℓ
ˇ
 is not a selector for ℓ.

To turn the envelope into an actual payoff, one would need to modify the representative 
σ
^
∗
 at null messages. But full adversary kernels can put all mass on those null messages. Changing the payoff there is not harmless unless the modification preserves the full row infimum for τ-a.e. s and preserves σ
∗
’s value-securing property. The L5 modification preserves restricted-game payoffs because τ(K
∗
)=1, but L8 is exactly about full kernels that may concentrate on τ-null messages. Phil’s original note also explicitly flagged that the Lusin lift establishes an optimal player-1 strategy, not an adversarial player-2 optimizer. 

phil_reny_bundle

So no l.s.c. representative exists by current assumptions alone. A contact-preserving l.s.c. representative would be a new assumption, not a consequence.

Step 4: Conditional measurable selection under the Needed Assumption

Add the following assumption.

(A8c-lsc)

There is a representative of the Branch-A strategy, preserving the Branch-A value guarantee, such that ℓ is jointly Borel and, for τ-a.e. s, the map

m↦ℓ(m,s)

is lower semicontinuous on compact M.

Then L8c is proved.

Let N
0
	​

 be the null set from Step 1 where a(s)

=e(s), and let N
1
	​

 be the null set where rowwise l.s.c. fails. On M∖N, with N=N
0
	​

∪N
1
	​

, compactness of M and lower semicontinuity imply that m↦ℓ(m,s) attains its minimum. Hence

A(s)={m∈M:ℓ(m,s)=a(s)=e(s)}

is nonempty.

It is also closed: for fixed s∈
/
N,

A(s)={m:ℓ(m,s)≤a(s)},

because a(s) is the minimum value, and sublevel sets of l.s.c. functions are closed.

For measurability, use the measurable maximum theorem for Borel normal integrands on compact metric action spaces. It gives that s↦a(s)=min
m
	​

ℓ(m,s) is measurable and that the argmin correspondence has measurable graph and nonempty compact values. Equivalently, the correspondence is weakly measurable. Kuratowski-Ryll-Nardzewski then yields a Borel selector

m
∗
:M∖N→M,m
∗
(s)∈A(s).

Extend m
∗
 arbitrarily on N. Since M is standard Borel, the Dirac map

β
∗
(dm∣s)=δ
m
∗
(s)
	​

(dm)

is a measurable stochastic kernel.

Step 5: β
∗
=δ
m
∗
(s)
	​

 closes L8 under (A8c-lsc)

For this Dirac kernel,

C(β
∗
)=∫
M
	​

ℓ(m
∗
(s),s)τ(ds)=∫
M
	​

a(s)τ(ds)=
β∈B
inf
	​

C(β).

Adding back the aligned term gives

U(β
∗
,σ
∗
)=
β∈B
inf
	​

U(β,σ
∗
)=U
∗
.

Thus β
∗
 is adversarial against σ
∗
. This closes L8, but only under the added rowwise l.s.c. or equivalent contact assumption. It does not solve L9: Definition 2 still requires Bayes-optimality after on-path messages, and posterior versions on null-message sets may matter. The project notes already identify the per-message posterior/best-response step as the next hard piece after adversary attainment. 

objective_statement

[DERIVED]

Under standing + (A5), and in the nontrivial case 1−α>0,

m
inf
	​

ℓ(m,s)=
m∼τ
essinf
	​

ℓ(m,s)for τ-a.e. s.

Under standing + (A5) alone, rowwise attainment is not derivable. Shellwise Lusin continuity does not imply l.s.c. or contact.

Under (A8c-lsc), L8c is proved and L8 closes by the Dirac kernel.

Assumption Changes

[ASSUMPTION+] (A8c-lsc): For the Branch-A representative used in L8, m↦ℓ(m,s) is lower semicontinuous on compact M for τ-a.e. s. Equivalently, 
σ
^
∗
 admits a value-preserving representative whose induced row payoff is rowwise l.s.c.

A weaker but more tautological version is:

[ASSUMPTION+] (A8c-contact): For τ-a.e. s, the set

{m:ℓ(m,s)=
m
′
inf
	​

ℓ(m
′
,s)=
m
′
essinf
	​

ℓ(m
′
,s)}

is nonempty closed and weakly measurable in s.

(A8c-lsc) is the cleaner publishable assumption. (A8c-contact) is the exact minimal selector assumption.

Breakdown Amendments

[BREAKDOWN_AMEND] Route 3c(iii) cannot be obtained from L5 shell continuity alone. The missing ingredient is rowwise contact, most naturally supplied by l.s.c. of m↦ℓ(m,s) for τ-a.e. s.

[BREAKDOWN_AMEND] The Lusin-shell minimizer sequence argument fails. Minima on K
n
	​

 may converge to a null-boundary point at which the L5 representative jumps upward.

[BREAKDOWN_AMEND] An l.s.c. envelope only solves a relaxed problem unless one proves that the envelope is realized by a value-preserving representative and has no contact gap for the original ℓ.

Status Summary

L8c status: PROVED-CONDITIONAL under (A8c-lsc); not proved and not derivable under standing + (A5) alone.

L8 status: PROVED-CONDITIONAL under (A8c-lsc), via β
∗
(dm∣s)=δ
m
∗
(s)
	​

(dm). OPEN unconditionally.

Branch A status: unchanged, complete under (A5): σ
∗
 secures U
∗
. 

phil_reny_route_memo

Exact Next Obstacle

The next pass should decide whether to publish Branch B under (A8c-lsc)/(A8c-contact), or attempt a new construction of the Branch-A maximizer that builds rowwise l.s.c. into the representative from the start. If the assumption is accepted, L8 is closed and the next true target is L9: per-message Bayes-optimality and posterior-version control on null-set messages.
