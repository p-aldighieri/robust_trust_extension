
========
ROLE: user (id=2cd850a6-6195-4b21-a84f-4e0bece0125c)
========
# Prover pass 06 — Binary chain Lemmas L_B3 + L_B5

## Role

You are the Prover. Lemma B1 (binary scalar endpoint-fiber lift) is
in flight to fresh-chat reviewer 04. While that's checked, your job
is to prove the two remaining substantive lemmas in the binary chain:

- **L_B3 (Endpoint-only adversarial image)**.
- **L_B5 (Endpoint stationarity / total-balance condition)**.

The two remaining trivial lemmas (L_B2 TRS interval reduction = direct
cite of paper Theorem 1; L_B4 interior calibration = free under TRS)
plus the capstone assembly L_B6 will follow in a downstream pass.

Context: durable sources include prover_05_response.md (B1),
searcher_03_response.md (Island 1 detail), piotr_pareto_frontier_route_memo.md,
exposition_v9.tex/.pdf (v9 with finite-menu T1), the paper PDF.

## Setup (binary state, recap)

- \(\Omega = \{0,1\}\); beliefs \(\mu\in[0,1]\); source posterior
  \(s\in[0,1]\sim\tau\); \(M = \operatorname{supp}\tau\subseteq[0,1]\).
- \(A, \Theta\) compact metric; \(u(a,\omega,\theta)\) bounded continuous in \(a\).
- \(\alpha\in(0,1)\) (substantive regime).
- Paper Theorem 1: optimal \(\sigma^*\) is a TRS with connected trust
  region \(T = [L, R]\), \(0\le L\le R\le 1\).
- \(W = \{w\in\R^2 : \exists\hat\sigma, w(\omega) = \E_{\hat\sigma}[u\mid\omega]\}\)
  convex compact in \(\R^2\). \(W^P\) = upper boundary curve.
- For each interior belief \(\mu\in[0,1]\), let \(w^*(\mu)\in\arg\max_{w\in W}\mu\cdot w\)
  (Bayes-optimal profile at \(\mu\)). \(w^*\) is upper-hemicontinuous;
  single-valued except at finitely many "kink" beliefs (paper Lemma 1
  of Appendix A.6 in the smooth case).

## Lemma L_B3 — Endpoint-only adversarial image

**Hypotheses.** Standing + \(|\Omega|=2\) + TRS with \(T=[L,R]\),
\(L<R\) (the case \(L=R\) is degenerate). \(\sigma^*\) is the TRS
strategy: \(\hat\sigma^*(m) = R(w^*(\Pi_T(m)))\) where \(\Pi_T:[0,1]\to[L,R]\)
is the Bregman projection.

**Statement.** Among all Borel kernels \(\beta:M\to\Delta(M)\), there
exists an adversarial best response \(\beta^*\) (i.e., one attaining
the infimum of the misaligned-term in \(U\)) such that for
\(\tau\)-a.e.\ \(s\in[0,1]\),
\[
\operatorname{supp}\beta^*(\cdot\mid s) \;\subseteq\; \{L, R\}.
\]

In words: the optimal adversary sends only the two trust-region
endpoints, never an interior message.

**Tools.** Paper Lemma 1 (Appendix A.6, smooth case) gives the smooth
version. For the nonsmooth case, use:

1. **Convexity of \(w\mapsto s\cdot w\)** on each row \(s\in[0,1]\):
   it's linear in \(w\), so over the compact menu \(C^* = w^*(T)\),
   the min is attained at an extreme point. \(C^*\) is the image of
   the interval \(T = [L, R]\) under \(w^*\); since \(w^*\) is
   continuous on \(T\) with image on the upper boundary of \(W\), \(C^*\)
   is a continuous curve on the upper boundary, parametrized by
   \(\mu\in[L,R]\).
2. The function \(\mu\mapsto s\cdot w^*(\mu)\) is **concave** on \([L,R]\)
   (because the support function of \(W^P\) restricted to a 1-parameter
   family of beliefs is concave). Therefore its minimum on \([L,R]\) is
   attained at an endpoint: either \(\mu = L\) or \(\mu = R\).
3. Conclude: \(s\cdot w^*(\mu)\) is minimized at \(\{L, R\}\) for every
   \(s\), with potential ties at intermediate \(\mu\) only on a
   \(\tau\)-null set.

**Proof outline.**
- Step 1: \(w^*\) is continuous on \([L,R]\) (standard from
  upper-hemicontinuity of supporting profile + connectedness of
  \([L,R]\)). The image \(C^* = w^*([L,R])\) is a connected curve.
- Step 2: \(\mu\mapsto s\cdot w^*(\mu)\) is concave on \([L,R]\). To see
  this: \(s\cdot w^*(\mu) = \max_{w\in W} s\cdot w\) restricted to
  \(w\) supporting at \(\mu\). By envelope theorem (Milgrom-Segal),
  this is the support function \(h_W(s)\) ... wait this isn't quite right.

  More carefully: \(s\cdot w^*(\mu)\) is the value of the BAYES action
  at belief \(\mu\), evaluated at the TRUE state distribution \(s\).
  This is the function \(s\cdot w^*(\mu) = \E_{R(w^*(\mu))}[u\mid s]\),
  where the expectation is over actions chosen by the agent assuming
  belief \(\mu\) but states distributed by \(s\). This is a difference
  between actual and assumed beliefs.

  Claim: \(\mu\mapsto s\cdot w^*(\mu)\) is concave in \(\mu\) for fixed \(s\).
  Reason: \(w^*(\mu)\) is the upper envelope of linear functionals
  \(\mu\mapsto\mu\cdot w\) over \(w\in W\); but we're evaluating
  \(s\cdot w^*(\mu)\), not \(\mu\cdot w^*(\mu)\). So the concavity
  argument needs care.

  Alternative: in binary state, \(W^P\) is a 1-d curve with parameter
  \(\mu\). The map \(\mu\mapsto w^*(\mu)\in\R^2\) is a monotone arc:
  one component increases, the other decreases (since you move along
  the upper-right boundary of \(W\)). Therefore \(s\cdot w^*(\mu)\) is
  a difference of monotone scalar functions in \(\mu\), making it
  monotone or unimodal but possibly NOT concave.
- Verify carefully. If the unimodality / endpoint-min claim fails for
  generic \(s\), state the precise structural condition needed.

\paragraph{Alternative attack via Theorem 1.} Paper Theorem 1's proof
already analyzes the adversary's BR in binary. Specifically, paper
Section 4.2 / Appendix A.6 derives the endpoint-only adversary in the
smooth case. The nonsmooth extension is by upper-semicontinuity of
the min over closed sets.

\paragraph{Cleanest path.} Use the binary-state argument from paper
Section 4.2 plus standard nonsmooth-envelope-theorem tools
(Aubin-Frankowska §8). If the smooth case suffices for our application
under standing+regularity, state that.

## Lemma L_B5 — Endpoint stationarity (total-balance)

**Hypotheses.** Standing + \(|\Omega|=2\) + TRS \([L,R]\) is the optimal
trust region (so \([L,R]\in\arg\max_{[L,R]\subset[0,1]} F([L,R])\) where
\(F([L,R]) = \int[\alpha\max_{w\in C^*}s\cdot w + (1-\alpha)\min_{w\in C^*}s\cdot w]\,d\tau\)
with \(C^* = w^*([L,R])\)). \(\alpha\in(0,1)\).

**Statement.** Define the high-source rowwise-minimizer region
\(S_+ = \{s\in[0,1]: w^*(L) = \arg\min_{w\in C^*}s\cdot w\}\) and the
low-source rowwise-minimizer region \(S_- = \{s\in[0,1]: w^*(R) = \arg\min\}\).
Then:
\[
\alpha\!\int_{[0,L]}\!(L-m)\,\tau(dm) \;=\; (1-\alpha)\!\int_{S_+}\!(s-L)\,\tau(ds),
\]
\[
\alpha\!\int_{[R,1]}\!(m-R)\,\tau(dm) \;=\; (1-\alpha)\!\int_{S_-}\!(R-s)\,\tau(ds).
\]

In words: at the optimal trust region, the "aligned deficit" (the
mass aligned-truthful sources put below the trust-interval endpoint
\(L\), weighted by signed distance) equals the "misaligned surplus"
(the high-source mass routed to \(L\), weighted by signed distance);
symmetric for the right endpoint \(R\).

**Tools.** Apply Theorem T1 from v9 (finite-menu Pareto-Hall calibration
via Clarke-Danskin) with \(k\le 2\) (since \(C^*\) is the curve
\(w^*([L,R])\) but the active argmin/argmax cells force the multipliers
to be supported on at most the two endpoint profiles \(\{w^*(L), w^*(R)\}\)).
The total-balance equation is the Lagrange-multiplier balance condition
from T1's Step 5 / Lemma 8 in v9.

**Alternative**: paper Equations (6)-(7) in Appendix A.6 give the
smooth-density version directly (FOC of \(F\) with respect to \(L\) and
\(R\) — interior partial derivatives equal zero at the optimum).

**Proof outline.**
- Step 1: identify the active labels as \(\{w^*(L), w^*(R)\}\) under TRS.
  Aligned mass on interior \([L,R]\) routes to the corresponding
  interior label \(w^*(m)\), which is NOT active for argmin.
- Step 2: the only argmin-active labels are \(w^*(L)\) and \(w^*(R)\),
  carrying weights \(\lambda^-_L\) and \(\lambda^-_R\). Their normalized
  posteriors must be in \(B_W(w^*(L))\) and \(B_W(w^*(R))\) respectively.
- Step 3: in binary, \(B_W(w^*(L)) = \{L\}\) and \(B_W(w^*(R)) = \{R\}\)
  (the Bayes belief is uniquely \(L\) for \(w^*(L)\)). So the
  normalized posterior at label \(L\) must equal \(L\), which gives
  the stationarity equation.
- Step 4: rearrange the equation in terms of \(\tau\) integrals to
  get the displayed total-balance form.

## What I want you to produce

For both L_B3 and L_B5, produce fully rigorous proofs.


# Lemma L_B3 — Endpoint-only adversarial image

## Statement
(Restate.)

## Hypotheses (standing + binary + TRS [L,R] with L<R)

## Proof
- Step 1: w*: [L,R] → W^P continuous, monotone arc.
- Step 2: μ ↦ s·w*(μ) structural property; verify endpoint-min for τ-a.e. s.
- Step 3: conclude adversary's BR is concentrated on {L, R}.

## Compatibility with paper Lemma 1 of Appendix A.6
(Confirm and identify how this extends to nonsmooth U.)

# Lemma L_B5 — Endpoint stationarity (total-balance)

## Statement
(Restate.)

## Hypotheses (standing + binary + TRS [L,R] is the optimal trust region)

## Proof (via v9 T1)
- Step 1: active labels under TRS are {w*(L), w*(R)}.
- Step 2: Lagrange multipliers from v9 T1 give λ^- supported on {L,R}.
- Step 3: B_W(w*(endpoint)) = singleton {endpoint}.
- Step 4: rearrange to total-balance form.

## Compatibility with paper equations (6)-(7) in Appendix A.6
(Confirm consistency in the smooth-density case.)

# Combined corollary

Total-balance condition holds:
- η_L(M) = ν_L(M) for the left endpoint.
- η_R(M) = ν_R(M) for the right endpoint.

Where η_L, ν_L are as in Lemma B1 with p=L, and η_R, ν_R as in B1 with p=R.

Therefore Lemma B1 applies on each endpoint fiber, yielding kernels
κ_L, κ_R lifting to the original game.


## Output Contract

- Inline as plain markdown.
- Be rigorous about Step 2 of L_B3 (the structural claim about
  μ↦s·w*(μ)). This is the load-bearing nonsmooth step.
- L_B5 follows from v9 T1 + binary geometry — should be clean.
- End with one-line verdict on YOUR own proofs + next-step signal
  (probably: "fire capstone assembly L_B6").

## Constraints

- Banned re-proposals: see prior_attempts_digest.md.
- Use v9 T1 for L_B5 (citation to v9 exposition).
- Keep binary throughout — do not generalize to |Ω|≥3 here.
- Per user instruction: do not stop, if either lemma fails, identify
  the missing ingredient.

Show more

========
ROLE: assistant (id=09a395f5-5ce7-41a4-bfe2-4a16f136fd8a)
========
Lemma L_B3 — Endpoint-only adversarial image
Statement

Let Ω={0,1}, identify beliefs with x=Pr(ω=1)∈[0,1], and let the agent use a TRS with nondegenerate trust interval T=[L,R], L<R. Let w
∗
(μ)∈W be any Bayes-optimal payoff profile selected at trust-region belief μ∈[L,R]. For a source posterior s, the misaligned adviser’s row payoff from inducing μ is

s⋅w
∗
(μ):=(1−s)w
0
∗
	​

(μ)+sw
1
∗
	​

(μ).

Then, for every s∈[0,1],

μ∈[L,R]
inf
	​

s⋅w
∗
(μ)=min{s⋅w
∗
(L),s⋅w
∗
(R)}.

Consequently, if L,R are admissible original messages, there is an adversarial best response β
∗
 supported on {L,R} for every s. If original messages are restricted to M and L,R∈
/
M, the literal statement must be read as “endpoint payoff image”: the adversary may instead send any messages in the left/right endpoint fibers whose TRS projection is L or R.

Hypotheses

Standing assumptions, binary state, TRS trust interval T=[L,R] with L<R, and endpoint messages admissible for the literal {L,R}-support version. The paper’s Theorem 1 gives TRS optimality with a connected trust region; in binary, connected compact trust regions are intervals, and the paper’s binary discussion states that outside recommendations are mapped to interval endpoints. 

Robust_trust_Dworczak_Smolin

Proof
Step 1: Replace the curve by supporting lines of a convex value function

Let

V(x):=
w∈W
max
	​

{(1−x)w
0
	​

+xw
1
	​

},x∈[0,1].

Since V is the pointwise maximum of affine functions, V is convex.

For any Bayes-optimal profile w=w
∗
(μ)∈argmax
z∈W
	​

μ⋅z, define its slope

d(w):=w
1
	​

−w
0
	​

.

Then d(w)∈∂V(μ), because for all x,

V(x)≥(1−x)w
0
	​

+xw
1
	​

=V(μ)+d(w)(x−μ).

Thus x↦V(μ)+d(w)(x−μ) is a supporting affine function of V at μ, and

x⋅w
∗
(μ)=V(μ)+d
μ
	​

(x−μ),d
μ
	​

:=d(w
∗
(μ)).

Convexity gives the monotonicity of subgradients:

L≤μ≤R⟹d
L
	​

≤d
μ
	​

≤d
R
	​


for any selected d
L
	​

∈∂V(L), d
μ
	​

∈∂V(μ), d
R
	​

∈∂V(R).

This is the nonsmooth replacement for the paper’s smooth Appendix A.5 argument, where the row payoff is the supporting line to U at μ
′
, and convexity makes the function quasi-concave in μ
′
, so the minimum over an interval is attained at an endpoint. 

Robust_trust_Dworczak_Smolin

Step 2: Endpoint domination of every interior supporting line

Fix μ∈(L,R).

If s≥μ, compare the interior profile w
∗
(μ) with the left endpoint w
∗
(L):

s⋅w
∗
(μ)−s⋅w
∗
(L)
	​

=[V(μ)−V(L)]+(s−μ)d
μ
	​

−(s−L)d
L
	​

.
	​


Since d
L
	​

∈∂V(L),

V(μ)−V(L)≥d
L
	​

(μ−L).

Therefore

s⋅w
∗
(μ)−s⋅w
∗
(L)≥d
L
	​

(μ−L)+(s−μ)d
μ
	​

−(s−L)d
L
	​

=(s−μ)(d
μ
	​

−d
L
	​

)≥0.

So for s≥μ, the left endpoint is weakly better for the adversary:

s⋅w
∗
(L)≤s⋅w
∗
(μ).

If s≤μ, compare w
∗
(μ) with the right endpoint w
∗
(R):

s⋅w
∗
(μ)−s⋅w
∗
(R)
	​

=[V(μ)−V(R)]+(s−μ)d
μ
	​

−(s−R)d
R
	​

.
	​


Since d
R
	​

∈∂V(R),

V(μ)−V(R)≥d
R
	​

(μ−R).

Thus

s⋅w
∗
(μ)−s⋅w
∗
(R)≥d
R
	​

(μ−R)+(s−μ)d
μ
	​

−(s−R)d
R
	​

=(s−μ)(d
μ
	​

−d
R
	​

)≥0,

because s−μ≤0 and d
μ
	​

−d
R
	​

≤0. Hence for s≤μ,

s⋅w
∗
(R)≤s⋅w
∗
(μ).

Combining the two cases: for every interior μ, at least one endpoint weakly improves the adversary’s row payoff. Therefore

s⋅w
∗
(μ)≥min{s⋅w
∗
(L),s⋅w
∗
(R)},∀μ∈[L,R].

The reverse inequality is trivial because L,R∈[L,R]. Hence

μ∈[L,R]
inf
	​

s⋅w
∗
(μ)=min{s⋅w
∗
(L),s⋅w
∗
(R)}.

This proves the load-bearing nonsmooth structural claim. The function μ↦s⋅w
∗
(μ) need not be concave; the correct property is weaker and sharper: every interior supporting line is pointwise dominated, for minimization, by one of the two endpoint supporting lines.

Step 3: Construct an endpoint-supported adversarial best response

Define

E
L
	​

:={s∈M:s⋅w
∗
(L)≤s⋅w
∗
(R)},E
R
	​

:=M∖E
L
	​

.

These sets are Borel because the two endpoint payoff functions are affine in s. If L,R are admissible original messages, define

β
∗
(⋅∣s)={
δ
L
	​

,
δ
R
	​

,
	​

s∈E
L
	​

,
s∈E
R
	​

.
	​


For each s, this chooses a rowwise minimizer of m↦s⋅w
∗
(Π
T
	​

(m)). Since the misaligned term is an integral of rowwise linear losses and the adversary’s choice is unrestricted row by row, this deterministic kernel attains the infimum.

If the formal message set is M and L,R∈
/
M, this exact δ
L
	​

,δ
R
	​

 kernel is unavailable. The corrected original-message statement is: choose any Borel selectors from the endpoint fibers

F
L
	​

:={m∈M:Π
T
	​

(m)=L},F
R
	​

:={m∈M:Π
T
	​

(m)=R}

when those fibers are nonempty. The payoff image is still endpoint-only, and this is the form needed for the B1 endpoint-fiber lift.

Compatibility with paper Lemma 1 of Appendix A.6

In the smooth binary section, the paper proves that the misaligned adviser’s row problem over the interval has a threshold form: low beliefs induce the upper endpoint, high beliefs induce the lower endpoint, and the threshold is the crossing point of the two endpoint supporting lines. 

Robust_trust_Dworczak_Smolin

 The proof above removes differentiability and strict convexity: it uses only convexity of V and monotonicity of subgradients. Positive-mass ties are harmless because the endpoint selector can split or choose either endpoint.

Lemma L_B5 — Endpoint stationarity / total-balance condition
Status of the literal statement

The displayed total-balance equations are correct under the regular binary assumptions used implicitly by the smooth Appendix A.6 calculation, but they are not implied by the stated hypotheses alone.

A tiny counterexample: let W={w
0
	​

} be a singleton payoff set, so every strategy induces the same state-contingent payoff. Then every interval [L,R] is payoff-equivalent and optimal. But w
∗
(L)=w
∗
(R), so both endpoints are rowwise minimizers for every s. With τ uniform on [0,1], α=1/2, L=1/4, the left displayed equation would read

2
1
	​

∫
0
1/4
	​

(1/4−m)dm=
2
1
	​

∫
0
1
	​

(s−1/4)ds,

i.e.

64
1
	​

=
8
1
	​

,

which is false. The missing ingredient is exactly where the proposed outline was too fast: in binary it is not automatic that

B
W
	​

(w
∗
(L))={L},B
W
	​

(w
∗
(R))={R}.

At kinks, flat faces, duplicated payoff profiles, or non-exposed endpoints, the Bayes cone can be an interval or larger set. Then T1 gives cone membership, not equality to the scalar endpoint.

Correct regular statement

Assume, in addition to the standing binary TRS hypotheses:

Interior endpoint condition: 0<L<R<1. If L=0 or R=1, replace the corresponding equality by the usual one-sided Kuhn–Tucker inequality.

Endpoint exposure: writing w
L
	​

:=w
∗
(L), w
R
	​

:=w
∗
(R),

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

Equivalently, the endpoint profiles are Bayes-optimal only at their endpoint beliefs.

Tie discipline: the endpoint row-minimizer tie set has τ-measure zero, or else one fixes Borel tie weights

λ
L
−
	​

(s),λ
R
−
	​

(s)∈[0,1],λ
L
−
	​

(s)+λ
R
−
	​

(s)=1

on the endpoint-minimizer correspondence, with

λ
L
−
	​

(s)>0⇒w
L
	​

∈argmin{s⋅w
L
	​

,s⋅w
R
	​

},
λ
R
−
	​

(s)>0⇒w
R
	​

∈argmin{s⋅w
L
	​

,s⋅w
R
	​

}.

In the no-tie case, λ
L
−
	​

=1
S
+
	​

	​

 and λ
R
−
	​

=1
S
−
	​

	​

.

Endpoint stationarity / T1 applicability: varying the two endpoint labels while holding the interior labels fixed gives the finite endpoint menu first-order condition from v9 T1. This is the nonsmooth Clarke-Danskin analogue of the paper’s smooth FOC calculation. The relevant v9 theorem supplies active weights λ
±
, a normal-cone stationarity vector g
i
	​

∈N
W
	​

(w
i
	​

), and normalized posteriors p
i
	​

=g
i
	​

/q
i
	​

∈B
W
	​

(w
i
	​

). 

prover_02_response

 

prover_02_response

Then the weighted endpoint balance equations are

α∫
[0,L]
	​

(L−m)τ(dm)=(1−α)∫
M
	​

λ
L
−
	​

(s)(s−L)τ(ds),
(B5-L)
α∫
[R,1]
	​

(m−R)τ(dm)=(1−α)∫
M
	​

λ
R
−
	​

(s)(R−s)τ(ds).
(B5-R)

If the endpoint minimizer is tie-free, these reduce exactly to the user’s displayed equations:

α∫
[0,L]
	​

(L−m)τ(dm)=(1−α)∫
S
+
	​

	​

(s−L)τ(ds),
α∫
[R,1]
	​

(m−R)τ(dm)=(1−α)∫
S
−
	​

	​

(R−s)τ(ds).
Proof via v9 T1

Write a binary belief x∈[0,1] as the vector (1−x,x). Let the endpoint labels be w
L
	​

,w
R
	​

.

Step 1: Active endpoint labels under TRS

By L_B3, the misaligned active payoff image is contained in the two endpoint profiles {w
L
	​

,w
R
	​

}. Thus the misaligned active weights can be chosen as λ
L
−
	​

,λ
R
−
	​

, supported on the endpoint argmin correspondence.

For the aligned truthful part, the endpoint labels receive exactly the outside truthful sources:

λ
L
+
	​

(m)=1
{m≤L}
	​

,λ
R
+
	​

(m)=1
{m≥R}
	​

,

up to choices at m=L,R, which do not affect the signed-distance identities because the distance term vanishes there. Interior messages m∈(L,R) are Bayes-optimal at their own interior beliefs and are not part of the endpoint stationarity equation.

Step 2: Apply v9 T1 to the left endpoint

The finite-menu Clarke-Danskin calibration theorem gives, for the left endpoint,

g
L
	​

=α∫
[0,L]
	​

(1−m,m)τ(dm)+(1−α)∫
M
	​

λ
L
−
	​

(s)(1−s,s)τ(ds),

and

q
L
	​

=ατ([0,L])+(1−α)∫
M
	​

λ
L
−
	​

(s)τ(ds).

If q
L
	​

>0, v9 T1 gives

p
L
	​

:=
q
L
	​

g
L
	​

	​

∈B
W
	​

(w
L
	​

).

By endpoint exposure, B
W
	​

(w
L
	​

)={L}. Hence the second coordinate of p
L
	​

 equals L. Taking second coordinates in g
L
	​

=q
L
	​

p
L
	​

 yields

α∫
[0,L]
	​

mτ(dm)+(1−α)∫
M
	​

λ
L
−
	​

(s)sτ(ds)=L[ατ([0,L])+(1−α)∫
M
	​

λ
L
−
	​

(s)τ(ds)].

Rearranging,

α∫
[0,L]
	​

(L−m)τ(dm)=(1−α)∫
M
	​

λ
L
−
	​

(s)(s−L)τ(ds).

This is (B5-L).

If q
L
	​

=0, both sides are zero and the same identity holds trivially.

Step 3: Apply v9 T1 to the right endpoint

Similarly,

g
R
	​

=α∫
[R,1]
	​

(1−m,m)τ(dm)+(1−α)∫
M
	​

λ
R
−
	​

(s)(1−s,s)τ(ds),
q
R
	​

=ατ([R,1])+(1−α)∫
M
	​

λ
R
−
	​

(s)τ(ds).

T1 gives p
R
	​

=g
R
	​

/q
R
	​

∈B
W
	​

(w
R
	​

), and endpoint exposure gives p
R
	​

=R. Taking second coordinates:

α∫
[R,1]
	​

mτ(dm)+(1−α)∫
M
	​

λ
R
−
	​

(s)sτ(ds)=R[ατ([R,1])+(1−α)∫
M
	​

λ
R
−
	​

(s)τ(ds)].

Rearranging,

α∫
[R,1]
	​

(m−R)τ(dm)=(1−α)∫
M
	​

λ
R
−
	​

(s)(R−s)τ(ds),

which is (B5-R).

Step 4: Tie-free specialization

If the endpoint argmin is tie-free, then

λ
L
−
	​

=1
S
+
	​

	​

,λ
R
−
	​

=1
S
−
	​

	​

.

Substituting these into (B5-L) and (B5-R) gives the two displayed total-balance equations.

The monotone endpoint-min proof in L_B3 also implies that, outside ties, S
+
	​

⊆[L,1] and S
−
	​

⊆[0,R]. Hence the integrands (s−L) and (R−s) have the intended nonnegative “surplus” interpretation.

Compatibility with paper equations (6)-(7) in Appendix A.6

The paper’s smooth-density proof computes partial derivatives of the interval objective with respect to the two endpoints; the derivatives are U
′′
(⋅) times exactly the signed aligned and misaligned endpoint-balance integrals. At an interior non-singleton optimum the derivatives vanish, and since U
′′
>0, the first-order conditions become Ψ
1
	​

=Ψ
2
	​

=0, equivalent to equations (6)-(7). 

Robust_trust_Dworczak_Smolin

 The paper then interprets these equations as requiring the average posterior induced by the left and right message regions to equal the respective endpoint beliefs. 

Robust_trust_Dworczak_Smolin

The proof above is the nonsmooth Clarke-Danskin version of that calculation. The smooth proof gets equality from ordinary derivatives and U
′′
>0; the nonsmooth proof gets equality from T1 calibration plus the endpoint-exposure condition B
W
	​

(w
L
	​

)={L}, B
W
	​

(w
R
	​

)={R}.

Combined corollary

Under the regular/tie-free version of L_B5, define the left endpoint measures

η
L
	​

(X):=α∫
X∩[0,L]
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

Then L_B5 gives

η
L
	​

(M)=ν
L
	​

(M).

Similarly, define the right endpoint measures

η
R
	​

(X):=α∫
X∩[R,1]
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

Then

η
R
	​

(M)=ν
R
	​

(M).

Therefore Lemma B1 applies to the left fiber with p=L, A
−
	​

=[0,L]∩M, S
+
	​

=S
+
	​

, and to the right fiber with p=R, A
+
	​

=[R,1]∩M, S
−
	​

=S
−
	​

. B1 supplies kernels κ
L
	​

 and κ
R
	​

 that transport the signed surplus measures and make the posterior equal to the relevant endpoint on each endpoint message fiber. The B1 proof is explicitly Radon-Nikodym and atom-blind, but it requires the “no extra traffic into the calibrated fiber” convention when assembling the full kernel. 

prover_05_response

Interior messages m∈(L,R) require no adversarial traffic in the binary construction: the aligned adviser reports them truthfully, the posterior is m, and the TRS continuation is Bayes-optimal at m.

Verdict: L_B3 PASS modulo the endpoint-admissibility wording; L_B5 PATCH_BIG as literally stated, but PASS under endpoint exposure + tie discipline + interior endpoint stationarity. Next step: either add those regularity clauses and fire L_B6 assembly, or send patched L_B5 to reviewer before capstone.
