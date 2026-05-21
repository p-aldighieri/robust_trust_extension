
========
ROLE: user (id=6650dd61-92ba-40e4-9fa7-9e4d7de21621)
========
# Prover pass 20 — G-FBNF-2 + G-FBNF-3 to close P6^G

## Role

You are the Prover. G-FBNF-1 is proved (Prover 19) and in fresh-chat
verification (Reviewer 17). Prove the two remaining FBNF-graph lemmas:

- **G-FBNF-2 (endpoint-only graph image)**: misaligned BR on each
  arc routes to arc endpoints only — multi-arc analog of L_B3 / F2.
- **G-FBNF-3 (localized graph stationarity → Kirchhoff balance)**:
  at the optimal multi-arc trust band, localized perturbations of
  each arc endpoint yield Kirchhoff balance at interior vertices —
  multi-arc analog of L_B5 / F3.

## What to produce


# G-FBNF-2 (Endpoint-only graph image)

## Statement
Under P6^G-1 (finite affine graph foliation) + analog of FBNF-3
(arc-wise supporting-line domination), the misaligned BR on each
arc concentrates on arc endpoints τ_e-a.e.

## Proof
Apply L_B3 analog arc-by-arc. Standard.

# G-FBNF-3 (Localized graph stationarity → Kirchhoff balance)

## Statement
At the optimal multi-arc trust band T = ∪_e ℓ_e([L_e, R_e]),
localized two-sided perturbations of (L_e, R_e) yield λ-a.e.
fiberwise balance + Kirchhoff balance at every interior graph
vertex v.

## Proof
- Per-arc balance from v9 T1 conditional Clarke-Danskin (as in F3).
- Interior vertex shared by edges e, e' must satisfy a flow
  conservation: aligned deficit + misaligned surplus in arc e
  balances aligned deficit + misaligned surplus in arc e'. This
  is the Kirchhoff law.
- Boundary vertices: one-sided KKT.

## Combined corollary
P6^G primitive class closes Theorem 2 unconditionally for multi-arc
trust regions with finite graph structure.


## Output Contract

Inline markdown. Be precise about Kirchhoff balance at interior
vertices. End with verdict + next-step (extend v9.1 with P6^G or
stop sharpening).

## Constraints

- Banned tools list applies.
- G-FBNF-1 cited as proved (subject to Reviewer 17).
- Per user: if G-FBNF-2/3 stalls, stop sharpening per Searcher 07.

Show more

========
ROLE: assistant (id=e993a73d-a336-4001-ad9c-57138ae991fa)
========
I’ll write this as a concise prover pass using Prover 19’s endpoint-fiber G-FBNF-1 as input: prove endpoint-only image arcwise, then state Kirchhoff as signed half-edge balance at shared vertices.

========
ROLE: assistant (id=187b53f6-e1a9-4f75-9d5b-eb8be3d08729)
========
I’ll also avoid the false stronger claim that minimizers themselves are just endpoints; the proof uses arcwise support geometry and yields the projected endpoint image.

========
ROLE: assistant (id=846b49bb-bf77-427d-8567-377f97ecc4b9)
========
G-FBNF-2 — Endpoint-only graph image
Statement

Let G=(V,E) be a finite embedded affine graph in Δ(Ω), with edge charts

ℓ
e
	​

:[a
e
	​

,b
e
	​

]→Δ(Ω),ℓ
e
	​

(t)=p
e
	​

+td
e
	​

,

and let the optimal graph trust region be

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

]).

Assume:

Finite affine graph chart. The graph has the same Borel-chart / quotient-consistency convention used in G-FBNF-1, so edge interiors are treated as disjoint and shared vertices have consistent labels.

Graph-preserving TRS. For s=ℓ
e
	​

(t), the trust projection stays on the same edge:

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

t)

except at shared vertices, where all incident charts prescribe the same continuation.

Arc-wise supporting-line domination. Along every edge e, the TRS continuation is Bayes-optimal:

w
e
	​

(r):=w
∗
(ℓ
e
	​

(r))∈arg
w∈W
max
	​

ℓ
e
	​

(r)⋅w,

and the edge row problem is the affine support-function restriction of

U(μ):=
w∈W
max
	​

μ⋅w.

Global cross-arc dominance. For τ-a.e. s=ℓ
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

Then for τ
e
	​

-a.e. t, and indeed for every t on every regular edge,

r∈[L
e
	​

,R
e
	​

]
min
	​

ℓ
e
	​

(t)⋅w
e
	​

(r)=min{ℓ
e
	​

(t)⋅w
e
	​

(L
e
	​

), ℓ
e
	​

(t)⋅w
e
	​

(R
e
	​

)}.

Hence the misaligned adviser admits a rowwise best response whose projected payoff image lies only at the two trusted arc endpoints

ℓ
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

).

As in FBNF, this is an endpoint-supported projected-image statement, not a literal singleton-message support statement: later calibration may spread literal message mass over endpoint fibers. That distinction is necessary because the patched F1/FBNF machinery uses endpoint-fiber support, not singleton endpoint support. 

sanity_chunk2_response

Proof

Fix an edge e. Suppress e and write

ℓ(t)=p+td,L=L
e
	​

,R=R
e
	​

.

For r∈[L,R], let

w
r
	​

:=w
∗
(ℓ(r))∈arg
w∈W
max
	​

ℓ(r)⋅w.

Define the one-dimensional restricted value

V(r):=U(ℓ(r))=
w∈W
max
	​

ℓ(r)⋅w.

Since U is the support function of compact convex W, U is convex; since ℓ is affine, V=U∘ℓ is convex on [a,b]. The earlier F2 proof used exactly this affine-fiber support-function reduction, with V(r)=U(ℓ(r)), g
r
	​

=d⋅w
r
	​

∈∂V(r), and subgradient monotonicity to obtain endpoint domination. 

reviewer_08_response

For each r, set

g
r
	​

:=d⋅w
r
	​

.

Because w
r
	​

 supports U at ℓ(r), g
r
	​

∈∂V(r). For a source s=ℓ(t), the row payoff from inducing trusted coordinate r is

Φ
t
	​

(r):=ℓ(t)⋅w
r
	​

=ℓ(r)⋅w
r
	​

+(t−r)d⋅w
r
	​

=V(r)+(t−r)g
r
	​

.

We show Φ
t
	​

(r)≥min{Φ
t
	​

(L),Φ
t
	​

(R)} for every r∈[L,R].

If r≤t, compare r with L. Pick g
L
	​

∈∂V(L). Convexity gives

V(r)−V(L)≥(r−L)g
L
	​

,

and monotonicity of subgradients gives g
r
	​

≥g
L
	​

. Thus

Φ
t
	​

(r)−Φ
t
	​

(L)
	​

=[V(r)−V(L)]+(t−r)g
r
	​

−(t−L)g
L
	​

=[V(r)−V(L)−(r−L)g
L
	​

]+(t−r)(g
r
	​

−g
L
	​

)≥0.
	​


So Φ
t
	​

(r)≥Φ
t
	​

(L).

If r≥t, compare r with R. Pick g
R
	​

∈∂V(R). Convexity gives

V(r)−V(R)≥(r−R)g
R
	​

,

and monotonicity gives g
r
	​

≤g
R
	​

. Since t−r≤0,

Φ
t
	​

(r)−Φ
t
	​

(R)
	​

=[V(r)−V(R)]+(t−r)g
r
	​

−(t−R)g
R
	​

=[V(r)−V(R)−(r−R)g
R
	​

]+(t−r)(g
r
	​

−g
R
	​

)≥0.
	​


So Φ
t
	​

(r)≥Φ
t
	​

(R).

Therefore every interior r is weakly dominated, for row-minimization, by one of the two arc endpoints. Thus

r∈[L,R]
inf
	​

Φ
t
	​

(r)=min{Φ
t
	​

(L),Φ
t
	​

(R)}.

Tie discipline is not needed for endpoint-supported existence; it is needed only to replace active-minimizer weights by indicator regions S
e,+
	​

,S
e,−
	​

. If one wants the stronger statement

arg
r∈[L
e
	​

,R
e
	​

]
min
	​

ℓ
e
	​

(t)⋅w
e
	​

(r)⊆{L
e
	​

,R
e
	​

}

rather than merely endpoint-supported minimization, add strict no-interior-flatness, for example strict convexity of U∘ℓ
e
	​

 on [L
e
	​

,R
e
	​

]. This is the same patch recorded in the FBNF sanity review. 

sanity_chunk2_response

Finally, global cross-arc dominance upgrades the edge-local conclusion to the original-message row problem:

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

So the endpoint-supported selector on T
e
	​

 is a genuine global adversarial best response. This is exactly the role of FBNF-7 in the earlier FBNF capstone: it prevents a fiber-local minimizer from silently masquerading as a full original-game best response. 

prover_11_response

Thus G-FBNF-2 holds.

G-FBNF-3 — Localized graph stationarity ⇒ Kirchhoff balance
Statement

Let T=⋃
e
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

]) be an optimal graph trust band in the P6
G
 class. Assume:

G-FBNF-1’s finite graph / Borel chart setup, including quotient consistency at shared vertices.

G-FBNF-2 endpoint-supported graph image.

Endpoint exposure along each active half-edge.

Tie discipline, so strict endpoint-minimizer regions describe the active source regions up to null sets.

Local two-sided perturbability of every interior graph endpoint. If an endpoint is constrained, the conclusion becomes one-sided KKT, not equality.

Star exposure at shared vertices: for each graph vertex p, the Bayes cone of the common continuation w
∗
(p), restricted to the affine star generated by incident edge directions, intersects the star only at p:

B
W
	​

(w
∗
(p))∩(p+span{d
h
	​

:h∈H(p)})∩Δ(Ω)={p}.

This is the vertex version of endpoint exposure. Without it, stationarity gives only Bayes-cone membership at the node, not Kirchhoff equality.

Then localized two-sided perturbations of edge endpoints imply:

Non-shared endpoint balance. If a half-edge endpoint p
h
	​

 is not shared with any other active half-edge, the scalar B1 balance holds:

η
h
	​

(A
h
	​

)=ν
h
	​

(S
h
	​

).

Interior vertex Kirchhoff balance. If p is an interior graph vertex shared by active half-edges H(p), there exist nonnegative splitting weights

Θ
p
	​

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

)∀g∈H(p),
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

∀h∈H(p).
(K-col)

This is the graph Kirchhoff law: every incoming tilted source-current at a node is split across endpoint fibers so that each outgoing endpoint fiber receives exactly the vector deficit needed to calibrate that fiber.

Boundary vertices. If a graph vertex or trust endpoint is constrained, the same argument gives the corresponding one-sided KKT inequality. Equality requires local two-sided perturbability.

Notation for the Kirchhoff law

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

 be the strict source region whose projected rowwise minimizer is p
h
	​

. For h=(e,R), define

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

and again let S
h
	​

 be the strict source region whose projected rowwise minimizer is p
h
	​

.

Choose the oriented edge direction d
h
	​

 and nonnegative scalar distances a
h
	​

(m),b
h
	​

(s) so that

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

 is the edge direction toward the trusted interval; for a right endpoint it is the negative edge direction.

Define the tilted aligned deficit and misaligned surplus measures

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

For a vertex p, let

H(p):={h∈H:p
h
	​

=p}.

This is the same half-edge notation introduced in G-FBNF-1, where Kirchhoff was stated as the finite half-edge transfer condition (K-row)–(K-col), not a vague scalar equality. 

prover_19_response

Proof
Step 1 — Localized endpoint perturbations

Fix an interior half-edge endpoint h. Perturb its trust endpoint by

p
h
ε
	​

=p
h
	​

+εξ
h
	​

d
h
	​

,

where ξ
h
	​

 is bounded and supported on a chosen Borel patch of the coordinate graph. For a finite graph, “Borel patch” just means a finite union of edge-coordinate Borel sets; measurability is harmless under the Borel chart.

If the endpoint has positive margin from the edge boundary and from adjacent constrained graph structure, then for small ∣ε∣ the perturbed graph band remains admissible. This is the graph analogue of the local two-sided perturbability used in F3, where perturbations L(z)+εh(z), R(z)+εk(z) are admissible on patches with positive margin. 

prover_10_response

Let V(T) denote the payoff-profile value of the graph TRS. Since the graph is finite and W is bounded, V is locally Lipschitz in the finitely many endpoint coordinates. Hence Clarke-Danskin stationarity applies.

Step 2 — Active endpoint labels and tie weights

By G-FBNF-2, along every edge the projected row-minimizer image is endpoint-supported. Thus source regions are exhausted up to null ties by the endpoint regions S
h
	​

. The FBNF proof chain already records that the finite-menu Clarke-Danskin mechanism handles active min/max ties through simplex-valued weights, not by pretending ties do not exist. 

prover_01_response

At a non-shared endpoint p
h
	​

, there is a single active copy of the endpoint label. At a shared graph vertex p, there are several incident half-edge copies h∈H(p). These copies have the same physical belief p and the same continuation profile w
∗
(p), but they represent different local endpoint perturbation directions d
h
	​

.

For sources in S
g
	​

, all endpoint copies h∈H(p) are payoff-identical at the node. Clarke-Danskin therefore supplies measurable tie weights

λ
gh
	​

(s)≥0,
h∈H(p)
∑
	​

λ
gh
	​

(s)=1

for s∈S
g
	​

, supported only on active node copies. Define

θ
gh
	​

:=(1−α)∫
S
g
	​

	​

λ
gh
	​

(s)b
g
	​

(s)τ(ds).

Then immediately

h∈H(p)
∑
	​

θ
gh
	​

=(1−α)∫
S
g
	​

	​

b
g
	​

(s)τ(ds)=ν
g
	​

(S
g
	​

),

which is (K-row).

Step 3 — Column stationarity and posterior identity

Now fix a target half-edge h∈H(p). The unnormalized posterior numerator assigned to the half-edge-copy h is

g
h
	​

=α∫
A
h
	​

	​

mτ(dm)+(1−α)
g∈H(p)
∑
	​

∫
S
g
	​

	​

λ
gh
	​

(s)sτ(ds),

and the scalar mass is

q
h
	​

=ατ(A
h
	​

)+(1−α)
g∈H(p)
∑
	​

∫
S
g
	​

	​

λ
gh
	​

(s)τ(ds).

By the localized Clarke-Danskin Fermat condition, if q
h
	​

>0,

q
h
	​

g
h
	​

	​

∈B
W
	​

(w
∗
(p)).

Moreover, g
h
	​

/q
h
	​

 lies in the affine star of p, because it is a mixture of p plus incident edge-direction deviations. By star exposure,

q
h
	​

g
h
	​

	​

=p.

Multiplying by q
h
	​

 and rearranging gives

(1−α)
g∈H(p)
∑
	​

∫
S
g
	​

	​

λ
gh
	​

(s)(s−p)τ(ds)=α∫
A
h
	​

	​

(p−m)τ(dm).
(1)

Substitute

s−p=b
g
	​

(s)d
g
	​

,p−m=a
h
	​

(m)d
h
	​

.

Then (1) becomes

g∈H(p)
∑
	​

[(1−α)∫
S
g
	​

	​

λ
gh
	​

(s)b
g
	​

(s)τ(ds)]d
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

By definition of θ
gh
	​

,

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

,

which is (K-col).

Thus Kirchhoff balance holds at every locally two-sided interior graph vertex.

Step 4 — Non-shared endpoints reduce to B1 balance

If H(p)={h}, then (K-row) gives

θ
hh
	​

=ν
h
	​

(S
h
	​

),

while (K-col) gives

θ
hh
	​

d
h
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

Since d
h
	​


=0,

ν
h
	​

(S
h
	​

)=η
h
	​

(A
h
	​

).

This is exactly the scalar B1 total-balance condition:

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

So G-FBNF-3 contains the binary/FBNF endpoint stationarity lemma as the one-half-edge special case. The previous F3 proof established the same scalar balances via localized Clarke-Danskin stationarity and Borel patch testing; it also noted that local two-sided perturbability is needed for equality, otherwise only one-sided KKT inequalities follow. 

prover_10_response

Step 5 — Boundary vertices and one-sided KKT

If p
h
	​

 is constrained by L
e
	​

=a
e
	​

, R
e
	​

=b
e
	​

, graph boundary geometry, or lack of two-sided perturbability, the sign of ε is restricted. The same Clarke-Danskin argument then yields the corresponding one-sided inequality:

g∈H(p)
∑
	​

θ
gh
	​

d
g
	​

−η
h
	​

(A
h
	​

)d
h
	​


lies in the polar cone of admissible endpoint perturbations.

Thus exact Kirchhoff equality is the correct interior condition; boundary vertices carry KKT inequalities. This mirrors the prior F3 caveat exactly. 

prover_10_response

Combined corollary — P6
G
 closes the graph capstone

Under:

P6
G
-1 finite affine graph chart with quotient consistency,

graph-preserving TRS,

G-FBNF-2 endpoint-supported graph image,

endpoint and star exposure,

tie discipline,

global cross-arc dominance,

local two-sided perturbability at interior graph endpoints,

G-FBNF-3 derives Kirchhoff node balance. G-FBNF-1, already proved subject to Reviewer 17, then constructs the global Borel adversarial kernel supported on endpoint fibers, with projected payoff image endpoint-only and q-a.e. Bayes-cone calibration. Prover 19 states exactly that G-FBNF-1 constructs such a kernel under P6
G
, Kirchhoff node balance, and the compact regular package. 

prover_19_response

Therefore the P6
G
 primitive class closes the Theorem 2 existence direction for finite-graph trust regions with affine scalarizable arcs, up to the already-known scope narrowing: this is a graph-scalarization class, not the unrestricted ∣Ω∣≥3 theorem.

Compatibility with v8 sharpness

No conflict. P6
G
 deliberately excludes the WTA ternary obstruction unless the model supplies scalarizable arc dominance and Kirchhoff node balance. Searcher 07 flagged exactly this point: raw finite arcs are not enough, but graph-FBNF with endpoint-supported minimization, node Kirchhoff balance, and cross-edge dominance is the one additional sharpening candidate worth keeping. 

searcher_07_response

Verdict + next step

Verdict: PASS with one explicit patch. G-FBNF-2 is clean. G-FBNF-3 is clean provided “endpoint exposure” at shared graph vertices is read in the star-wise sense; without that, localized stationarity gives Bayes-cone membership at the node but not Kirchhoff equality.

Next step: extend v9.1 with P6
G
 as a fifth primitive sufficient class, but mark the added hypotheses visibly: finite affine graph chart, endpoint-supported arc image, star exposure, global cross-arc dominance, tie discipline, and local two-sided perturbability. Then stop sharpening unless Reviewer 17 rejects G-FBNF-1.
