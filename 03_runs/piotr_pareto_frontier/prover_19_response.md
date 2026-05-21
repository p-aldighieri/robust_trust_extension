
========
ROLE: user (id=c94e2ec8-b75c-41a5-9454-0ba9330ace67)
========
# Prover pass 19 — G-FBNF-1: Finite-graph endpoint-fiber pasting

## Role

You are the Prover. Searcher 07 (searcher_07_response.md) recommends
**P6$^G$ (Generalized Coarse Signal Structure / Finite Graph FBNF)**
as a candidate 5th primitive sufficient class beyond P2*/P3/P4.

The class generalizes FBNF beyond strict 1-d foliation to a **finite
graph** of arcs in Δ(Ω). The first prover target: **G-FBNF-1** —
the finite-graph endpoint-fiber pasting theorem with Kirchhoff
node balance.

## The lemma to prove

### Setup (P6^G class)

- $|\Omega|\ge 3$, $\alpha\in(0,1)$.
- $M\subseteq\Delta(\Omega)$ is the FINITE union of Borel affine arcs
  $\ell_e: [a_e, b_e]\to\Delta(\Omega)$ indexed by edges $e\in E$ of
  a finite graph $G = (V, E)$. Vertices $V\subseteq\Delta(\Omega)$ are
  the arc endpoints.
- The optimal trust region $T\subseteq\Delta(\Omega)$ is a finite
  union of arc-restrictions $T = \bigcup_e \ell_e([L_e, R_e])$ with
  $L_e\le R_e$ in arc parameter.
- Each arc has fiberwise endpoint exposure: $B_W(w_{e,L_e})\cap\ell_e([a_e,b_e]) = \{\ell_e(L_e)\}$,
  symmetric for $R_e$ (the FBNF-4 analog).
- Fiberwise tie discipline: τ no atom at any arc-endpoint tie (FBNF-5
  analog).
- Global cross-arc dominance: for τ-a.e. $s\in M$ in arc $e$, the
  rowwise min over the FULL T equals the rowwise min over the
  in-arc trust segment $T_e$ (FBNF-7 analog).

### Kirchhoff node balance

At every interior graph vertex $v\in V$, the "flow" balance:
sum of aligned-deficit-in-arc minus sum of misaligned-surplus-from-arc,
summed over edges incident at $v$, equals zero. This is the multi-arc
analog of the binary endpoint balance.

### The theorem

Under P6$^G$ + Kirchhoff node balance + the regularity package
(Reg-1, Reg-2), there exists a Borel adversary kernel $\hat\beta^*$
supported on arc-endpoint fibers such that the disintegration
posterior at every $q$-positive message satisfies Bayes-cone
calibration.

### Proof strategy

1. **Arc-wise B1**: apply L_B1 fiberwise on each arc with $p$ = arc
   endpoint, $A_-$ = aligned-truthful interior segment, $S_+$ =
   misaligned-source region routing to that endpoint.

2. **Kirchhoff balance**: at each interior vertex, sum the L_B1
   constraints across edges; the Kirchhoff condition ensures the
   sum balances.

3. **Measurable pasting across the graph**: glue arc-wise kernels via
   the Borel structure of the graph.

4. **Cross-arc dominance (FBNF-7 analog)**: ensures the adversary
   doesn't route through interior arc messages by crossing arcs.

5. **Verify Definition 2 q-a.e.** on the full graph.

## What I want

Rigorous proof of G-FBNF-1 in the structure:


# G-FBNF-1 (Finite-graph endpoint-fiber pasting)

## Statement
## P6^G primitive class definition
## Kirchhoff node balance

## Proof
### Step 1 — Arc-wise B1 application
### Step 2 — Kirchhoff balance at interior vertices
### Step 3 — Measurable pasting via Borel graph structure
### Step 4 — Cross-arc dominance
### Step 5 — Definition 2 q-a.e.

## Coverage examples
- Multi-trust-region models (e.g., two-armed bandits with two
  separate "trust intervals").
- Trees of binary signal experiments.
- Polyhedral W with edge-graph structure.

## Compatibility with v8 sharpness
WTA ternary has W^P = vertex set (0-d), not 1-d arcs, so fails
P6^G-1. Verify.

## Open
- When does Kirchhoff balance hold automatically from optimality?
- Non-finite graphs (countable / continuum of arcs)?


## Output Contract

- Inline markdown.
- The Kirchhoff balance is the new structural ingredient — be
  explicit about how it generalizes the binary endpoint balance.
- End with verdict + next-step (extend v9 or stop sharpening).

## Constraints

- Banned tools list applies.
- L_B1 may be cited as proved.
- FBNF analog conditions (1, 4, 5, 7) are inherited; the new content
  is Kirchhoff + graph pasting.

Show more

========
ROLE: assistant (id=3e5eeda7-566c-41b9-83c5-85b3829c8f1f)
========
I’ll prove G-FBNF-1 as a finite-graph sufficiency theorem using patched endpoint-fiber support, not singleton endpoints. The new hinge is Kirchhoff node balance, enabling edgewise B1 kernels to paste measurably without posterior leakage.

========
ROLE: assistant (id=da55f11a-9687-47e1-a7c5-4a67d1e6977a)
========
At shared vertices I’ll aggregate incident branch imbalances rather than impose separate edge balances. This gives a vector Kirchhoff condition, with scalar endpoint balance as the single-edge special case.

========
ROLE: assistant (id=8687a2d7-a19f-431d-8a05-1857a213df93)
========
G-FBNF-1 — Finite-graph endpoint-fiber pasting
Statement

Let the standing Robust Trust hypotheses hold: finite Ω, full-support prior, compact metric A,Θ, bounded u(a,ω,θ) continuous in a, conditional independence of s,θ given ω, and Borel measurability conventions. Fix α∈(0,1).

Assume M⊆Δ(Ω) is supported on a finite embedded affine graph

G=(V,E),M=
e∈E
⋃
	​

ℓ
e
	​

([a
e
	​

,b
e
	​

])

up to τ-null sets, where each ℓ
e
	​

 is an affine Borel arc and distinct edge interiors meet only on graph vertices, modulo the Borel chart / quotient consistency condition below.

Let the optimal trust region be a finite union of edge restrictions

T=
e∈E
⋃
	​

T
e
	​

,T
e
	​

:=ℓ
e
	​

([L
e
	​

,R
e
	​

]),a
e
	​

≤L
e
	​

≤R
e
	​

≤b
e
	​

.

Let

σ
^
∗
(m)=ρ
W
	​

(w
∗
(Π
T
	​

(m)))

be the associated TRS continuation, with ρ
W
	​

 a Borel payoff-profile realization selector.

Under P6
G
, Kirchhoff node balance, and the regularity package (Reg-1),(Reg-2), there exists a Borel adversarial kernel

β
	​

∗
:M→Δ(M)

such that:

β
	​

∗
 is supported on graph endpoint fibers, meaning its projected payoff image is endpoint-only:

Π
T
	​

(supp
β
	​

∗
(⋅∣s))⊆{ℓ
e
	​

(L
e
	​

),ℓ
e
	​

(R
e
	​

):e∈E}for τ-a.e. s.

β
	​

∗
 is adversarial against the TRS: it routes only to rowwise minimizer endpoint labels.

For

γ
α
	​

:=α(id,id)
#
	​

τ+(1−α)τ⊗
β
	​

∗
,q:=(γ
α
	​

)
2
	​

,

the disintegration posterior satisfies

P
γ
α
	​

	​

(⋅∣m)∈B
W
	​

(w
∗
(Π
T
	​

(m)))for q-a.e. m.

Hence 
σ
^
∗
(m) is Bayes-optimal under P
γ
α
	​

	​

(⋅∣m) for q-a.e. m, so Definition 2 holds in the infinite-space q-a.e. reading.

The important formal patch, inherited from FBNF, is that the literal message support is on endpoint fibers, not only endpoint points. Earlier FBNF verification found that scalar B1 calibration generally requires spreading adversarial mass over endpoint fibers rather than sending all mass to the singleton endpoint; the projected payoff image is endpoint-only. 

prover_08_response

P6
G
 primitive class definition
P6
G
-1. Finite embedded affine graph with Borel chart

There is a finite graph G=(V,E), affine edge charts

ℓ
e
	​

:[a
e
	​

,b
e
	​

]→Δ(Ω),

and a finite disjoint coordinate space

M
:=
e∈E
⨆
	​

{e}×[a
e
	​

,b
e
	​

]

with coordinate map

Φ(e,t)=ℓ
e
	​

(t).

We assume either:

Φ is injective off a finite vertex set, and vertices are quotient-consistent; or

there is a 
τ
-full Borel set 
M
0
	​

⊆
M
 on which Φ is a Borel isomorphism onto a τ-full subset M
0
	​

⊆M.

This is the graph analogue of the FBNF Borel-chart requirement. The FBNF review explicitly warned that a mere Borel cover is insufficient: without a chart or quotient consistency, pasted posteriors can become multi-valued at overlapping messages. 

prover_08_response

Let

τ=Φ
#
	​

τ
.

Since E is finite, write 
τ
 as a finite family of Borel edge measures τ
e
	​

 on [a
e
	​

,b
e
	​

].

P6
G
-2. Graph-preserving TRS

The optimal trust region is edgewise:

T=
e∈E
⋃
	​

ℓ
e
	​

([L
e
	​

,R
e
	​

]).

For m=ℓ
e
	​

(t) on an edge,

Π
T
	​

(ℓ
e
	​

(t))=ℓ
e
	​

(Π
[L
e
	​

,R
e
	​

]
	​

(t))

unless m is a shared vertex, in which case all incident edge charts prescribe the same clipped belief and the same continuation payoff profile.

P6
G
-3. Edgewise endpoint-only projected row minimization

For τ
e
	​

-a.e. source s=ℓ
e
	​

(t), the rowwise minimizer over the in-edge trusted segment T
e
	​

 is endpoint-supported:

μ∈T
e
	​

min
	​

s⋅w
∗
(μ)=min{s⋅w
∗
(ℓ
e
	​

(L
e
	​

)),s⋅w
∗
(ℓ
e
	​

(R
e
	​

))}.

As in FBNF, this is an endpoint-supported statement; it does not require the whole argmin set to contain only endpoints when flat ties occur. The FBNF reviewer accepted precisely this endpoint-supported form as enough for the downstream pasting machinery. 

reviewer_08_response

P6
G
-4. Endpoint-fiber exposure

For every active half-edge endpoint p=ℓ
e
	​

(L
e
	​

) or p=ℓ
e
	​

(R
e
	​

),

B
W
	​

(w
∗
(p))∩ℓ
e
	​

([a
e
	​

,b
e
	​

])={p}.

At graph vertices shared by several edges, quotient consistency additionally requires the same continuation payoff profile w
∗
(p) and the same Bayes cone B
W
	​

(w
∗
(p)).

P6
G
-5. Endpoint tie discipline

For every edge e, τ
e
	​

 gives zero mass to endpoint-minimizer tie sets. Equivalently, the source regions routed to the left and right endpoint labels partition the edge up to τ
e
	​

-null sets.

P6
G
-6. Global cross-arc dominance

For τ-a.e. s=ℓ
e
	​

(t),

μ∈T
min
	​

s⋅w
∗
(μ)=
μ∈T
e
	​

min
	​

s⋅w
∗
(μ).

This is exactly the graph analogue of FBNF-7: local edge minimizers must be true global rowwise minimizers, not merely edge-local minimizers. The prior FBNF capstone made this cross-fiber condition load-bearing; without it, a fiber-local minimizer may fail to be an original-game adversarial best response. 

prover_11_response

P6
G
-7. Regularity package

Use the compact-regular package already isolated in Phase (b):

(Reg-1)G(s):=arg
m∈M
min
	​

s⋅w
∗
(m) has closed graph and compact nonempty values,

and

(Reg-2)m↦h
B(m)
	​

(a) is continuous for every fixed a∈R
∣Ω∣
,

where B(m):=B
W
	​

(w
∗
(m)). These conditions are not automatic from standing assumptions; compactness does not rule out payoff-label jumps or Bayes-cone jumps. 

prover_18_response

Kirchhoff node balance

The clean way to state Kirchhoff is on half-edges.

Let

H:={(e,L),(e,R):e∈E}.

For h=(e,L), define

p
h
	​

:=ℓ
e
	​

(L
e
	​

),A
h
	​

:=ℓ
e
	​

([a
e
	​

,L
e
	​

]),

and let S
h
	​

⊆ℓ
e
	​

([L
e
	​

,b
e
	​

]) be the strict source region whose projected rowwise minimizer is p
h
	​

.

For h=(e,R), define

p
h
	​

:=ℓ
e
	​

(R
e
	​

),A
h
	​

:=ℓ
e
	​

([R
e
	​

,b
e
	​

]),

and let S
h
	​

⊆ℓ
e
	​

([a
e
	​

,R
e
	​

]) be the strict source region whose projected rowwise minimizer is p
h
	​

.

Choose the constant edge-direction vector d
h
	​

 and scalar functions a
h
	​

(m),b
h
	​

(s)≥0 so that

p
h
	​

−m=a
h
	​

(m)d
h
	​

,m∈A
h
	​

,

and

s−p
h
	​

=b
h
	​

(s)d
h
	​

,s∈S
h
	​

.

For a left endpoint d
h
	​

 is the affine edge direction; for a right endpoint d
h
	​

 is the negative affine edge direction.

Define tilted target and source masses

η
h
	​

(X):=α∫
X∩A
h
	​

	​

a
h
	​

(m)τ(dm),

and

ν
h
	​

(Y):=(1−α)∫
Y∩S
h
	​

	​

b
h
	​

(s)τ(ds).

Let

H(p):={h∈H:p
h
	​

=p}

be the set of active half-edges sharing the endpoint belief p.

Kirchhoff condition at p

For every endpoint belief p, there exists a nonnegative matrix

Θ
p
=(θ
gh
	​

)
g,h∈H(p)
	​


such that

h∈H(p)
∑
	​

θ
gh
	​

=ν
g
	​

(S
g
	​

)for all g∈H(p),
(K-row)

and

g∈H(p)
∑
	​

θ
gh
	​

d
g
	​

=η
h
	​

(A
h
	​

)d
h
	​

for all h∈H(p).
(K-col)

If η
h
	​

(A
h
	​

)=0, require θ
gh
	​

=0 for all g, so no adversarial traffic is sent to a zero-demand endpoint fiber.

This is the precise graph version of binary endpoint balance. In the binary case, H(p) has one active direction, so (K-row) and (K-col) collapse to the scalar B1 balance

α∫
A
h
	​

	​

a
h
	​

(m)τ(dm)=(1−α)∫
S
h
	​

	​

b
h
	​

(s)τ(ds).

At a branching node, Kirchhoff is not merely “total scalar mass in equals total scalar mass out.” It is a finite nonnegative flow rule that converts source surplus directions into target deficit directions. This is exactly the finite-graph analogue of the scalar B1 engine that Searcher 07 identified as the next sharpening target: finite graph arcs, endpoint regions, source regions, Kirchhoff node balance, and Borel chart consistency should produce a global kernel with no node leakage. 

searcher_07_response

Proof
Step 1 — Arc-wise B1 ingredients

Fix a half-edge h. The endpoint fiber A
h
	​

 is the set of messages that the TRS clips to p
h
	​

. Its aligned truthful mass pulls the posterior away from p
h
	​

 by the vector

α∫
X
	​

(p
h
	​

−m)τ(dm)=η
h
	​

(X)d
h
	​


for X⊆A
h
	​

.

The source region S
h
	​

 consists of sources whose rowwise minimizing endpoint label is p
h
	​

. Its adversarial surplus vector is

(1−α)∫
Y
	​

(s−p
h
	​

)τ(ds)=ν
h
	​

(Y)d
h
	​


for Y⊆S
h
	​

.

Thus each half-edge carries a scalar B1 transport problem. If H(p
h
	​

) is a singleton, the Kirchhoff condition is exactly the B1 total-balance condition, and L
B1
	​

 gives a kernel from S
h
	​

 to A
h
	​

 that calibrates every q-positive message in A
h
	​

 to posterior p
h
	​

.

At a shared graph vertex p, we cannot generally apply B1 independently edge by edge unless each incident half-edge balances on its own. Kirchhoff supplies the missing finite node routing: it tells us how to split source surplus from each incident half-edge g among target endpoint fibers h.

This is the only new graph ingredient. Everything else is the same scalar endpoint-fiber mechanism as FBNF, where the literal support is on endpoint fibers and the projected payoff image is endpoint-only. 

prover_08_response

Step 2 — Kirchhoff balance at interior vertices

Fix an endpoint belief p and the finite set H(p).

For each g∈H(p) with ν
g
	​

(S
g
	​

)>0, define row probabilities

π
gh
	​

:=
ν
g
	​

(S
g
	​

)
θ
gh
	​

	​

.

If ν
g
	​

(S
g
	​

)=0, define π
gg
	​

=1 arbitrarily; this branch is irrelevant for τ-a.e. tilted source mass.

For each h∈H(p) with η
h
	​

(A
h
	​

)>0, define the normalized target measure

η
ˉ
	​

h
	​

(dm):=
η
h
	​

(A
h
	​

)
η
h
	​

(dm)
	​

.

If η
h
	​

(A
h
	​

)=0, choose any fixed default probability on A
h
	​

 when A
h
	​


=∅; by the Kirchhoff zero-demand convention no positive mass is routed there.

Define a local node kernel on S
g
	​

 by

κ
p
	​

(dm∣s):=
h∈H(p)
∑
	​

π
gh
	​

η
ˉ
	​

h
	​

(dm),s∈S
g
	​

.

Now verify the balance identity. For X⊆A
h
	​

,

(1−α)∫
⋃
g
	​

S
g
	​

	​

κ
p
	​

(X∣s)(s−p)τ(ds)

equals

g∈H(p)
∑
	​

π
gh
	​

η
ˉ
	​

h
	​

(X)(1−α)∫
S
g
	​

	​

(s−p)τ(ds).

Since

(1−α)∫
S
g
	​

	​

(s−p)τ(ds)=ν
g
	​

(S
g
	​

)d
g
	​

,

this becomes

g∈H(p)
∑
	​

ν
g
	​

(S
g
	​

)
θ
gh
	​

	​

η
h
	​

(A
h
	​

)
η
h
	​

(X)
	​

ν
g
	​

(S
g
	​

)d
g
	​

=
η
h
	​

(A
h
	​

)
η
h
	​

(X)
	​

g∈H(p)
∑
	​

θ
gh
	​

d
g
	​

.

By the Kirchhoff column equation,

g∈H(p)
∑
	​

θ
gh
	​

d
g
	​

=η
h
	​

(A
h
	​

)d
h
	​

.

Therefore

(1−α)∫κ
p
	​

(X∣s)(s−p)τ(ds)=η
h
	​

(X)d
h
	​

=α∫
X
	​

(p−m)τ(dm).
(1)

This is the endpoint-fiber calibration identity. It is the graph-node version of B1. The node is now a little finite switchboard: every incoming tilted source current is split across endpoint fibers so that each outgoing fiber receives exactly the vector deficit it needs. Tiny Kirchhoff orchestra, no rogue trombone.

Step 3 — Measurable pasting via Borel graph structure

Because E and the graph are finite, all sets

A
h
	​

,S
h
	​

,H(p),η
h
	​

,ν
h
	​


are Borel in the coordinate chart. The matrices Θ
p
 are finite deterministic data. The kernels

s↦κ
p
	​

(⋅∣s)

are finite sums of fixed probability measures with Borel branch indicators, hence Borel kernels on the coordinate graph.

Define 
β
	​

∗
 on the full coordinate graph by

β
	​

∗
(⋅∣s)=κ
p
	​

(⋅∣s)if s∈S
g
	​

 for some g∈H(p).

On endpoint tie sets, which are τ-null by P6
G
-5, define 
β
	​

∗
 arbitrarily, for example by selecting any available endpoint fiber. On any τ-null chart-overlap leftovers, use the quotient-consistent default.

Push this coordinate kernel forward through Φ. The Borel chart / quotient consistency assumption guarantees that the pushed kernel is a well-defined Borel kernel on M. This is exactly the same measurability hinge as in FBNF: a Borel chart is required because a raw finite union of arcs can otherwise prescribe multiple posteriors at the same physical message. 

prover_08_response

Step 4 — Cross-arc dominance and adversariality

For s∈S
g
	​

⊆M, every message in the support of 
β
	​

∗
(⋅∣s) lies in some endpoint fiber A
h
	​

 with the same endpoint belief p=p
g
	​

. By graph-preserving TRS,

Π
T
	​

(m)=pfor m∈A
h
	​

.

Hence all such messages induce the payoff profile w
∗
(p).

By P6
G
-3, p is an edgewise endpoint minimizer. By P6
G
-6, the edgewise minimizer is a global minimizer over the full trust region:

μ∈T
min
	​

s⋅w
∗
(μ)=
μ∈T
e
	​

min
	​

s⋅w
∗
(μ).

Thus 
β
	​

∗
 is supported on rowwise minimizers of the full original-message problem, not merely on local graph-edge minimizers. This mirrors the FBNF capstone, where FBNF-7 was the reviewer-required condition turning fiber-local minimization into a true adversarial best response. 

prover_11_response

So 
β
	​

∗
 attains the misaligned infimum against the TRS.

Step 5 — Definition 2 q-a.e.

Let

γ
α
	​

=α(id,id)
#
	​

τ+(1−α)τ⊗
β
	​

∗

and q=(γ
α
	​

)
2
	​

.

Endpoint-fiber messages

Fix an endpoint belief p, a half-edge h∈H(p), and a Borel X⊆A
h
	​

. Let

n(X):=α∫
X
	​

mτ(dm)+(1−α)∫
M
	​

∫
X
	​

s
β
	​

∗
(dm∣s)τ(ds)

be the vector numerator of the posterior, and

q(X):=ατ(X)+(1−α)∫
M
	​

β
	​

∗
(X∣s)τ(ds)

be the message marginal.

The identity (1) says

(1−α)∫
M
	​

β
	​

∗
(X∣s)(s−p)τ(ds)=α∫
X
	​

(p−m)τ(dm).

Rearranging,

α∫
X
	​

mτ(dm)+(1−α)∫
M
	​

β
	​

∗
(X∣s)sτ(ds)=p[ατ(X)+(1−α)∫
M
	​

β
	​

∗
(X∣s)τ(ds)].

Thus

n(X)=pq(X).

By the Radon-Nikodym theorem,

P
γ
α
	​

	​

(⋅∣m)=pfor q-a.e. m∈A
h
	​

.

Since Π
T
	​

(m)=p for m∈A
h
	​

, the TRS continuation is

σ
^
∗
(m)=ρ
W
	​

(w
∗
(p)).

By endpoint exposure and the definition of w
∗
(p),

p∈B
W
	​

(w
∗
(p)).

Therefore

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
γ
α
	​

	​

(⋅∣m))q-a.e. on A
h
	​

.
Interior edge messages

Let

I
e
	​

:=ℓ
e
	​

((L
e
	​

,R
e
	​

)).

By construction, 
β
	​

∗
 sends no non-null adversarial traffic to I
e
	​

. Therefore for Borel X⊆I
e
	​

,

q(X)=ατ(X),n(X)=α∫
X
	​

mτ(dm).

Hence

P
γ
α
	​

	​

(⋅∣m)=mq-a.e. on I
e
	​

.

Since Π
T
	​

(m)=m for interior trusted messages,

σ
^
∗
(m)=ρ
W
	​

(w
∗
(m))

is Bayes-optimal at m.

Vertex atoms

If q has an atom at a graph vertex p, all aligned truthful mass at that atom already has belief p, and all adversarial endpoint-fiber traffic calibrated to that vertex has posterior p. Hence the same Radon-Nikodym identity gives

P
γ
α
	​

	​

(⋅∣p)=p

after choosing the regular conditional version on that atom.

Combining endpoint fibers, interiors, and vertex atoms,

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
γ
α
	​

	​

(⋅∣m))q-a.e.

This is Definition 2 in the correct infinite-space reading.

Coverage examples
Multi-trust-region models

If advice can move along several finite “risk-score” or “severity” arcs, and each arc has its own trusted segment, G-FBNF handles the case where arcs meet at shared intermediate beliefs. Kirchhoff balance is exactly the condition that the shared node does not become a posterior leak.

Trees of binary signal experiments

A finite decision tree of binary refinements naturally gives a finite graph of posterior arcs. Each edge behaves like a scalar binary subproblem; branching points require Kirchhoff node balance. Trees are especially friendly because there are no cycles, so node balances can often be checked recursively.

Polyhedral W with edge-graph structure

If the active Bayes faces of a polyhedral W decompose into scalarizable one-dimensional arcs, G-FBNF gives a constructive alternative to the full finite-facet cone-Hall LP. This is broader than single-foliation FBNF because it permits finite branching, but still avoids the genuinely multidimensional Hall problem.

These are precisely the kinds of finite 1-skeleton models Searcher 07 identified as the only P6 sharpening worth trying: finite networks of affine arcs, decision trees, scalarizable faces, and piecewise-affine MLR paths. 

searcher_07_response

Compatibility with v8 sharpness

The WTA ternary witness is not admitted by this theorem.

In WTA ternary, W
P
 is the finite vertex menu {v
0
	​

,v
1
	​

,v
2
	​

}, a 0-dimensional set of payoff labels, not a scalarizable finite graph of Bayes-supporting arcs. More importantly, its obstruction is genuinely two-dimensional: three vertex labels and nontrivial Bayes cones create vector balance constraints that cannot be reduced to scalar B1 transports. The FBNF audit already emphasized that this kind of WTA obstruction is exactly what one-dimensional scalarization must not accidentally admit. 

prover_08_response

So WTA ternary fails P6
G
-1 in the intended payoff-frontier sense, and it also fails the cross-arc dominance / Kirchhoff scalarization required by P6
G
. No conflict with the v8 sharpness package.

Open

Automatic Kirchhoff from optimality.
The next analytic target is to derive the half-edge Kirchhoff matrices from localized graph perturbations, just as F3 derived fiberwise scalar balance from localized endpoint stationarity. At graph nodes this becomes a finite-dimensional network-flow KKT condition.

Endpoint-only graph image.
The geometric target is the graph analogue of F2: prove that rowwise minimization on each affine arc is endpoint-supported and that cross-arc dominance holds from primitive single-crossing / support-function geometry.

Non-finite graphs.
Countable graphs would require summability and measurable network-flow selection. Continuum graphs would likely reawaken the full cone-Hall dragon, unless additional compactness and no-escape structure is imposed.

Curved arcs.
The proof uses affine arcs so that p−m and s−p are fixed-direction multiples. Curved MLR paths would need either a straightening transformation or a different vector-measure transport lemma.

Verdict

PASS, with one necessary formal reading: Kirchhoff node balance must be the finite half-edge transfer condition (K-row)–(K-col), not merely a vague aggregate scalar equality. Under that reading, G-FBNF-1 closes: finite graph endpoint-fiber pasting constructs the calibrated adversarial kernel and verifies Definition 2 q-a.e.

Next step: prove G-FBNF-2, the endpoint-only graph image theorem, then G-FBNF-3, localized graph stationarity ⇒ Kirchhoff balance.
