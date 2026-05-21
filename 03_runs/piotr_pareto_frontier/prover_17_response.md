
========
ROLE: user (id=0881cac4-e955-4fa7-984c-04c437916c04)
========
# Prover pass 17 — Implementable LP template + worked examples

## Role

You are the Prover. G4 (finite-facet polyhedral LP threshold) is
PROVED + Reviewer 15 PASS. Per Reviewer 15's next-step signal: write
the **implementable LP template** with explicit inputs and run it on
three concrete models.

## What to deliver

### Part 1: The LP template

State the LP feasibility check explicitly. Inputs:
- $g_{j\ell}$ — extreme dual price vector for cell $\ell$ at vertex $j$.
- $c_{j\ell}$ — corresponding support-function value $h_{B_j}(g_{j\ell})$.
- $\lambda_j$ — aligned baseline weight at vertex $j$.
- $\bar m_j$ — position of aligned baseline at vertex $j$.
- $\mu_j$ — misaligned source weight to vertex $j$.
- $\bar s_j$ — conditional source mean for sources routed to vertex $j$.
- $\alpha$ — alignment probability.

The LP feasibility condition: finitely many linear inequalities in
$(g, c, \lambda, \bar m, \mu, \bar s, \alpha)$. Spell out the LP
formulation cleanly.

### Part 2: WTA ternary worked example

For $|\Omega| = 3$, $W$ = WTA (3 vertices $v_0, v_1, v_2$), $\tau$
uniform on $\Delta(\Omega)$, $\alpha = 1/2$:
- Extreme dual prices $g_{j\ell}$.
- Support functions $c_{j\ell}$.
- LP feasibility check → threshold $D \ge 2(1-\alpha)/(9\alpha) = 2/9$
  on aligned baseline.
- Verify the table matches G1's hand-computation.

### Part 3: Plurality voting $|\Omega|=K$

General plurality with $K$ states, $K$ actions:
- $W$ has $K$ vertices.
- Symmetric case: $\tau$ uniform, $\alpha$ general.
- Compute the symmetric threshold $D_K(\alpha)$ on aligned baseline.
- Compare to WTA ternary ($K=3$).

### Part 4: Finite-experiment design (Doval-Smolin example)

Pick one concrete finite-experiment from Doval-Smolin (2024):
- E.g., a binary signal experiment for a 3-state model.
- Compute the LP threshold.
- Interpret economically.

## Output Contract

- Inline markdown with explicit LP formulas.
- Three tables (one per example) with the LP threshold computation.
- End with a synthesis: how the LP template implements G3+G4 in
  practice.

## Constraints

- Banned tools list applies.
- Use Reviewer 15's notational conventions.
- Per user: relentless. Make this implementable and concrete.

Show more

========
ROLE: assistant (id=5c4b01ff-6ed3-4fcf-83af-4618654efa26)
========
I’ll turn G4 into a solver-ready cone-Hall LP, then run WTA, plurality, and one finite binary-signal experiment with consistent signs and explicit threshold tables.

========
ROLE: assistant (id=576c968a-5067-4021-8ca0-45bfc4150f92)
========
For WTA, I’m fixing the invariant depth normalization: −2αD+(1−α)4/9≤0, yielding D≥2(1−α)/(9α) and 2/9 at α=1/2.

========
ROLE: assistant (id=5ad1d1ee-3ae1-47ee-bb7b-8916ab7ec92e)
========
Part 1: Implementable finite-facet LP template

The finite-facet reduction is the computational form of the cone-Hall condition: with polyhedral Bayes cones, the infinite support-function check collapses to finitely many linear inequalities. The sign convention is the corrected one from G1/G4: feasibility means the cone-Hall expression is nonpositive, Ψ≤0, not nonnegative. 

prover_16_response

Inputs

For each active payoff label or vertex j=1,…,k:

B
j
	​

={p∈Δ(Ω):g
jℓ
	​

⋅p≤c
jℓ
	​

, ℓ=1,…,L
j
	​

},

where B
j
	​

=B
W
	​

(w
j
	​

) is the Bayes cone of the continuation used at label j. The vector g
jℓ
	​

 is an extreme/facet dual price, and

c
jℓ
	​

=h
B
j
	​

	​

(g
jℓ
	​

)=
p∈B
j
	​

sup
	​

g
jℓ
	​

⋅p.

The data are:

(λ
j
	​

,
m
ˉ
j
	​

),(μ
j
	​

,
s
ˉ
j
	​

),α∈(0,1),

where:

λ
j
	​

=τ(A
j
	​

),
m
ˉ
j
	​

=
λ
j
	​

1
	​

∫
A
j
	​

	​

mτ(dm),

is the aligned truthful mass and mean routed to continuation w
j
	​

, and

μ
j
	​

=τ(S
j
	​

),
s
ˉ
j
	​

=
μ
j
	​

1
	​

∫
S
j
	​

	​

sτ(ds),

is the source mass and conditional source mean of types whose rowwise minimizing adversarial label is j.

Define

q
j
	​

:=αλ
j
	​

+(1−α)μ
j
	​

,
n
j
	​

:=αλ
j
	​

m
ˉ
j
	​

+(1−α)μ
j
	​

s
ˉ
j
	​

.

The induced posterior at label j is p
j
	​

=n
j
	​

/q
j
	​

 whenever q
j
	​

>0.

LP feasibility check

For every active label j and every facet/extreme dual price ℓ,

g
jℓ
	​

⋅n
j
	​

≤c
jℓ
	​

q
j
	​

.
	​


Equivalently,

αλ
j
	​

(g
jℓ
	​

⋅
m
ˉ
j
	​

−c
jℓ
	​

)+(1−α)μ
j
	​

(g
jℓ
	​

⋅
s
ˉ
j
	​

−c
jℓ
	​

)≤0.
	​


This is the implementable LP. If all inequalities pass, then p
j
	​

∈B
j
	​

 for every active j, so the calibrated adversarial kernel exists in the finite-facet quotient. If any inequality fails, the offending g
jℓ
	​

 is an explicit dual certificate against robust rationalizability. This is exactly the finite-facet G4 reduction: under finite-cell/tie-free hypotheses, Theorem 2 holds iff the finite LP is feasible. 

prover_16_response

Design mode

If the aligned baseline is a design object, introduce variables

x
j
	​

:=λ
j
	​

m
ˉ
j
	​

,z
j
	​

:=μ
j
	​

s
ˉ
j
	​

.

Then the constraints become

g
jℓ
	​

⋅[αx
j
	​

+(1−α)z
j
	​

]≤c
jℓ
	​

[αλ
j
	​

+(1−α)μ
j
	​

],

with linear bookkeeping constraints

1⋅x
j
	​

=λ
j
	​

,x
j
	​

≥0,1⋅z
j
	​

=μ
j
	​

,z
j
	​

≥0,

plus any model-specific cell constraints such as x
j
	​

/λ
j
	​

∈A
j
	​

, z
j
	​

/μ
j
	​

∈S
j
	​

. If the cells are polytopes, these remain linear constraints. If ties have positive mass, add tie-splitting variables; otherwise impose tie discipline. 

prover_16_response

Part 2: WTA ternary worked example

Let

Ω={0,1,2},

and WTA payoff vertices be

v
j
	​

(j)=1,v
j
	​

(k)=−1(k

=j).

Then

s⋅v
j
	​

=2s
j
	​

−1.

The rowwise minimizer region for label j is

K
j
−
	​

={s∈Δ
2
:s
j
	​

≤s
k
	​

 ∀k},

and the Bayes cone is

B
j
	​

={p∈Δ
2
:p
j
	​

≥p
k
	​

 ∀k}.

These are the same WTA objects used in the G4 calculation. 

prover_16_response

The exact facet representation is

B
j
	​

={p:e
k
	​

⋅p−e
j
	​

⋅p≤0, k

=j},

so the facet prices are

g
jk
	​

=e
k
	​

−e
j
	​

,c
jk
	​

=0.

For the symmetric G1 hand certificate, aggregate the two facets into

g
~
	​

j
	​

=1−2e
j
	​

,

so 
g
~
	​

j
	​

 has coordinate −1 at j and +1 at the other two states. Then

h
B
j
	​

	​

(
g
~
	​

j
	​

)=
3
1
	​

.

For uniform τ on Δ
2
,

τ(K
j
−
	​

)=
3
1
	​

,E[s
j
	​

∣s∈K
j
−
	​

]=
9
1
	​

.

Thus, on K
j
−
	​

,

g
~
	​

j
	​

⋅s−h
B
j
	​

	​

(
g
~
	​

j
	​

)=(1−2s
j
	​

)−
3
1
	​

=
3
2
	​

−2s
j
	​

.

Per label,

∫
K
j
−
	​

	​

(
3
2
	​

−2s
j
	​

)τ(ds)=
3
1
	​

(
3
2
	​

−
9
2
	​

)=
27
4
	​

.

Summing over the three labels gives the misaligned certificate mass

j=0
∑
2
	​

∫
K
j
−
	​

	​

[
g
~
	​

j
	​

⋅s−h
B
j
	​

	​

(
g
~
	​

j
	​

)]τ(ds)=
9
4
	​

.

Define aligned baseline depth

D:=
j=0
∑
2
	​

∫
A
j
	​

	​

(m
j
	​

−
3
1
	​

)τ(dm)=
j=0
∑
2
	​

λ
j
	​

(
m
ˉ
j,j
	​

−
3
1
	​

),

where A
j
	​

={m:m
j
	​

≥m
k
	​

 ∀k}. For the same symmetric certificate,

j
∑
	​

∫
A
j
	​

	​

[
g
~
	​

j
	​

⋅m−h
B
j
	​

	​

(
g
~
	​

j
	​

)]τ(dm)=−2D.

So

Ψ(
g
~
	​

)=−2αD+(1−α)
9
4
	​

.

The LP passes this binding symmetric cut iff

−2αD+(1−α)
9
4
	​

≤0,

i.e.

D≥
9α
2(1−α)
	​

.
	​


For α=1/2,

D≥
9
2
	​

.
	​

WTA ternary table
Item	Value
States	3
Vertices	v
0
	​

,v
1
	​

,v
2
	​


Bayes cone B
j
	​

	p
j
	​

≥p
k
	​

 ∀k
Facet dual prices	g
jk
	​

=e
k
	​

−e
j
	​

, c
jk
	​

=0
Symmetric G1 price	
g
~
	​

j
	​

=1−2e
j
	​

, h
B
j
	​

	​

(
g
~
	​

j
	​

)=1/3
Rowwise minimizer cell	K
j
−
	​

={s:s
j
	​

≤s
k
	​

 ∀k}
Uniform cell mass	τ(K
j
−
	​

)=1/3
Conditional min coordinate	E[s
j
	​

∣K
j
−
	​

]=1/9
Misaligned contribution	4/9
Aligned contribution	−2D
Cone-Hall inequality	−2αD+(1−α)4/9≤0
Threshold	D≥2(1−α)/(9α)
At α=1/2	D≥2/9

This is the G1 hand computation in LP clothing: without enough aligned baseline depth, the symmetric price 
g
~
	​

j
	​

 is the dual certificate; with D≥2/9 at α=1/2, that certificate is neutralized.

Part 3: Plurality voting with ∣Ω∣=K

Let

Ω={1,…,K}.

Plurality/WTA vertices are

v
j
	​

(j)=1,v
j
	​

(k)=−1(k

=j),

so

s⋅v
j
	​

=2s
j
	​

−1.

The Bayes cone is

B
j
	​

={p:p
j
	​

≥p
k
	​

 ∀k},

with exact facet representation

g
jk
	​

=e
k
	​

−e
j
	​

,c
jk
	​

=0,k

=j.

The rowwise minimizer region is

K
j
−
	​

={s:s
j
	​

≤s
k
	​

 ∀k}.

For the symmetric certificate

g
~
	​

j
	​

=1−2e
j
	​

,

we have

h
B
j
	​

	​

(
g
~
	​

j
	​

)=1−
K
2
	​

.

On K
j
−
	​

,

g
~
	​

j
	​

⋅s−h
B
j
	​

	​

(
g
~
	​

j
	​

)=(1−2s
j
	​

)−(1−
K
2
	​

)=2(
K
1
	​

−s
j
	​

).

If τ is uniform on the K-simplex, then by symmetry

τ(K
j
−
	​

)=
K
1
	​

,

and for a uniform Dirichlet(1,…,1) simplex point,

E[
i
min
	​

s
i
	​

]=
K
2
1
	​

.

Therefore, per label,

∫
K
j
−
	​

	​

2(
K
1
	​

−s
j
	​

)τ(ds)=
K
1
	​

⋅2(
K
1
	​

−
K
2
1
	​

)=
K
3
2(K−1)
	​

.

Summing over K labels gives

misaligned contribution=
K
2
2(K−1)
	​

.

Define symmetric aligned baseline depth

D
K
	​

:=
j=1
∑
K
	​

λ
j
	​

(
m
ˉ
j,j
	​

−
K
1
	​

).

The aligned contribution is −2D
K
	​

, so

Ψ(
g
~
	​

)=−2αD
K
	​

+(1−α)
K
2
2(K−1)
	​

.

The symmetric LP threshold is

D
K
	​

(α)=
α
1−α
	​

⋅
K
2
K−1
	​

.
	​


For K=3,

D
3
	​

(α)=
α
1−α
	​

⋅
9
2
	​

=
9α
2(1−α)
	​

,

which is exactly the WTA ternary threshold.

Plurality K-state table
Item	Formula
States/actions	K
Bayes cone	B
j
	​

={p:p
j
	​

≥p
k
	​

 ∀k}
Exact facets	g
jk
	​

=e
k
	​

−e
j
	​

, c
jk
	​

=0
Symmetric price	
g
~
	​

j
	​

=1−2e
j
	​


Support value	h
B
j
	​

	​

(
g
~
	​

j
	​

)=1−2/K
Rowwise minimizer cell	K
j
−
	​

={s:s
j
	​

≤s
k
	​

 ∀k}
Uniform cell mass	1/K
Conditional minimum coordinate	1/K
2

Misaligned contribution	2(K−1)/K
2

Aligned depth	D
K
	​

=∑
j
	​

λ
j
	​

(
m
ˉ
j,j
	​

−1/K)
LP inequality	−2αD
K
	​

+(1−α)2(K−1)/K
2
≤0
Threshold	D
K
	​

(α)=((1−α)/α)((K−1)/K
2
)
K=3	2(1−α)/(9α)

As K grows, the symmetric required depth scales like (1−α)/(αK). Bigger state spaces make the adversarial certificate thinner per label, but still genuinely multidimensional.

Part 4: Finite-experiment design, Doval-Smolin-style binary signal

Doval and Smolin’s credit-ratings example uses three types with repayment vector

ρ=(0,0.5,1),

and a uniform prior (1/3,1/3,1/3). Their displayed binary experiments include

Π
2
	​

(r)=
	​

r
1
0
	​

1−r
0
1
	​

	​

,

which is a two-signal experiment for three types. 
Squarespace
+1
 I instantiate this experiment at r=1/2, then feed the resulting posterior distribution into the Robust Trust LP.

The two posterior messages are:

m
L
	​

=(
3
1
	​

,
3
2
	​

,0),m
H
	​

=(
3
1
	​

,0,
3
2
	​

),

each with probability 1/2.

Use a binary approval decision with outside threshold 1/2. Approving has normalized payoff profile

w
A
	​

=ρ−
2
1
	​

1=(−
2
1
	​

,0,
2
1
	​

),

and rejecting has normalized payoff profile

w
R
	​

=(0,0,0).

The approve Bayes cone is

B
A
	​

={p:p⋅w
A
	​

≥0}={p:p
3
	​

≥p
1
	​

}.

The reject cone is

B
R
	​

={p:p
3
	​

≤p
1
	​

}.

Facet representation:

B
A
	​

:g
A
	​

=e
1
	​

−e
3
	​

,c
A
	​

=0,
B
R
	​

:g
R
	​

=e
3
	​

−e
1
	​

,c
R
	​

=0.

The aligned cells are:

A
A
	​

={m
H
	​

},A
R
	​

={m
L
	​

},

so

λ
A
	​

=λ
R
	​

=
2
1
	​

,
m
ˉ
A
	​

=m
H
	​

,
m
ˉ
R
	​

=m
L
	​

.

The adversarial rowwise minimizer flips the labels:

S
A
	​

={m
L
	​

},S
R
	​

={m
H
	​

},

so

μ
A
	​

=μ
R
	​

=
2
1
	​

,
s
ˉ
A
	​

=m
L
	​

,
s
ˉ
R
	​

=m
H
	​

.

Now compute the LP constraints.

For approval A:

n
A
	​

=α
2
1
	​

m
H
	​

+(1−α)
2
1
	​

m
L
	​

,q
A
	​

=
2
1
	​

.

The constraint is

(e
1
	​

−e
3
	​

)⋅n
A
	​

≤0.

Compute:

(e
1
	​

−e
3
	​

)⋅m
H
	​

=
3
1
	​

−
3
2
	​

=−
3
1
	​

,
(e
1
	​

−e
3
	​

)⋅m
L
	​

=
3
1
	​

−0=
3
1
	​

.

So

(e
1
	​

−e
3
	​

)⋅n
A
	​

=
2
α
	​

(−
3
1
	​

)+
2
1−α
	​

(
3
1
	​

)=
6
1−2α
	​

.

Thus approval calibration requires

6
1−2α
	​

≤0⟺α≥
2
1
	​

.

For rejection R:

n
R
	​

=α
2
1
	​

m
L
	​

+(1−α)
2
1
	​

m
H
	​

.

The constraint is

(e
3
	​

−e
1
	​

)⋅n
R
	​

≤0.

Compute:

(e
3
	​

−e
1
	​

)⋅m
L
	​

=0−
3
1
	​

=−
3
1
	​

,
(e
3
	​

−e
1
	​

)⋅m
H
	​

=
3
2
	​

−
3
1
	​

=
3
1
	​

.

So

(e
3
	​

−e
1
	​

)⋅n
R
	​

=
2
α
	​

(−
3
1
	​

)+
2
1−α
	​

(
3
1
	​

)=
6
1−2α
	​

.

Thus rejection calibration also requires

α≥
2
1
	​

.
Finite-experiment table
Item	Approval label A	Rejection label R
Continuation profile	w
A
	​

=(−1/2,0,1/2)	w
R
	​

=(0,0,0)
Bayes cone	p
3
	​

≥p
1
	​

	p
3
	​

≤p
1
	​


Facet price g	e
1
	​

−e
3
	​

	e
3
	​

−e
1
	​


Support value c	0	0
Aligned mass λ	1/2	1/2
Aligned mean 
m
ˉ
	m
H
	​

=(1/3,0,2/3)	m
L
	​

=(1/3,2/3,0)
Misaligned mass μ	1/2	1/2
Misaligned mean 
s
ˉ
	m
L
	​

=(1/3,2/3,0)	m
H
	​

=(1/3,0,2/3)
LP left side	(1−2α)/6	(1−2α)/6
Feasibility condition	α≥1/2	α≥1/2
Threshold	\multicolumn{2}{c}{
α≥1/2
	​

}	

Economic reading: the high signal m
H
	​

 supports approval, while the low signal m
L
	​

 supports rejection. The adversary flips low sources into approval and high sources into rejection. When α≥1/2, truthful aligned mass is large enough that the posterior at each recommendation remains on the correct side of the approval threshold. Below 1/2, the LP returns a violated facet, a tiny red flag with a megaphone.

Synthesis: how this implements G3 + G4

The Robust Trust theorem asks for an adversarial kernel β
∗
 such that, after on-path messages, the agent’s continuation is Bayes-optimal for the posterior induced by the mixture of truthful aligned reporting and adversarial misaligned reporting. That is Definition 2’s certification logic. 

objective_statement

G3 converts that certification problem into cone-Hall feasibility: posterior calibration must place each induced posterior in the Bayes cone B(m). G4 then says that, when W and the active Bayes cones are polyhedral, this feasibility problem becomes finitely many inequalities:

g
jℓ
	​

⋅[αλ
j
	​

m
ˉ
j
	​

+(1−α)μ
j
	​

s
ˉ
j
	​

]≤c
jℓ
	​

[αλ
j
	​

+(1−α)μ
j
	​

].

That is the whole implementation. Feed in the facets, masses, means, and α. The checker returns:

PASS⟺robust rationalizability certificate exists,
FAIL⟺violated facet (j,ℓ) is an explicit dual certificate.

So G3 is the theorem-shaped lighthouse, and G4 is the spreadsheet-shaped lantern. The finite examples above show the same machine in three costumes: WTA ternary, K-state plurality, and a concrete finite binary-signal experiment.
