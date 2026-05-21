ROLE: assistant (id=8f39f031-ebac-439e-bd2a-60248ae8b17d)
========
Consolidated memo v2: Robust Trust Theorem 2 infinite-extension package

Framing. This is a strong conditional / classification result, not a proof of the unrestricted infinite-M, infinite-Θ existence direction of Theorem 2 under the paper’s standing hypotheses alone.

The original objective was to remove the paper’s finite-M, finite-Θ assumption from Theorem 2. The paper’s Theorem 2 has an optimality direction, robustly rationalizable ⇒ optimal, and an existence direction proved in the paper only when M and Θ are finite. The standing assumptions are finite Ω, full-support μ
0
	​

, compact metric A,Θ, bounded u continuous in a, conditional independence of s and θ given ω, and Borel measurability. 

objective_statement

The verification block returned OBJECTIVE_NARROWED: the package proves exact positive subclasses and a cone-Hall biconditional/LP classification, but not the unrestricted standing-only theorem. 

gatekeeper_response

 The version below is therefore written for Piotr as a conditional classification theorem: it tells us when the infinite-dimensional Theorem 2 existence direction is proved, how to certify it, and exactly what remains open.

Section A — Setting and notation
A.1 Robust Trust primitives

Let

Ω={ω
1
	​

,…,ω
N
	​

}

be finite, with full-support prior μ
0
	​

∈Δ(Ω). The adviser observes a posterior

s∈Δ(Ω),

distributed according to τ, with support

M:=suppτ⊆Δ(Ω).

The agent observes type θ∈Θ, where Θ is compact metric. The action set A is compact metric. Payoffs are

u:A×Ω×Θ→R,

bounded and continuous in a. The adviser posterior s and the private type θ are conditionally independent given ω. The alignment probability is

α∈[0,1].

The aligned adviser reports truthfully. The misaligned adviser chooses a measurable kernel

β:M→Δ(M).

As in the paper, it is without loss on path to restrict misaligned messages to M.

A.2 Strategies and robust value

An agent strategy is a measurable map

σ:M×Θ→Δ(A).

Equivalently,

σ∼(
σ
^
(m))
m∈M
	​

,
σ
^
(m):Θ→Δ(A).

For a private strategy 
σ
^
 and belief μ∈Δ(Ω), write

U(
σ
^
,μ):=E
ω∼μ,θ,a∼
σ
^
(θ)
	​

[u(a,ω,θ)].

For a full strategy σ,

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

and

U
∗
:=
σ∈Σ
sup
	​

U(σ).

A misaligned kernel β
∗
 is adversarial against σ if it attains the infimum in the misaligned term.

A.3 Infinite-space reading of Definition 2

For a kernel β, define the mixture source-message law

γ
α
β
	​

=α(id,id)
#
	​

τ+(1−α)τ⊗β,

and its message marginal

q
β
	​

=(γ
α
β
	​

)
2
	​

=ατ+(1−α)∫
M
	​

β(⋅∣s)τ(ds).

In infinite M, the posterior P
β
	​

(⋅∣m) is defined only q
β
	​

-a.e. Therefore all robust-rationalizability conclusions below are stated q
β
∗
	​

-a.e., not literal-all. This is the correct infinite-space version of the paper’s “for all m” convention.

For Borel E⊆M, define the vector numerator measure

n
β
	​

(E):=α∫
E
	​

mτ(dm)+(1−α)∫
M
	​

∫
E
	​

sβ(dm∣s)τ(ds).

Then

n
β
	​

≪q
β
	​

,

and the posterior is the Radon-Nikodym derivative

  P_β(·|m) = (dn_β / dq_β)(m),   q_β-a.e.

That is, n_β is absolutely continuous with respect to q_β, and the
posterior at on-path m is the unique vector-valued Radon-Nikodym
derivative of n_β with respect to q_β at m. The orientation is
**dn/dq, not dq/dn** — this was the prior typo.

A.4 Payoff-profile geometry

Let

W:={w∈R
N
:∃
σ
^
:Θ→Δ(A) measurable with w(ω)=E
σ
^
	​

[u(a,ω,θ)∣ω]}.

Under the standing hypotheses, W is compact and convex in R
N
.

Let

W
P
:={w∈W:

∃v∈W with v(ω)>w(ω) ∀ω}

be the weak Pareto frontier.

For w∈W, define its Bayes cone

B
W
	​

(w):={μ∈Δ(Ω):w∈arg
v∈W
max
	​

μ⋅v}=N
W
	​

(w)∩Δ(Ω).

To avoid the previous notation clash, write

ρ
W
	​

:W→
Σ

for a Borel payoff-profile realization selector, so that ρ
W
	​

(w) is a private strategy realizing w. This replaces the old overloaded R:W→
Σ
.

For an optimal payoff labeling

w
∗
:M→W
P
,

let

C
∗
:=
w
∗
(M)
	​

⊆W
P

be the associated menu.

The rowwise minimizer correspondence is now denoted

G(s):={m∈M:s⋅w
∗
(m)=
z∈C
∗
min
	​

s⋅z}.

This replaces the old overloaded R(s).

The messagewise Bayes cone is

B(m):=B
W
	​

(w
∗
(m)).

A TRS continuation induced by a trust region T is written

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

(m))),

where Π
T
	​

 is the Bregman/trust-region projection.

Section B — Unified theorem statement
B.0 What the package proves

The package combines:

Unconditional structural pieces:

finite-menu payoff-label Pareto-Hall calibration;

the α=0 singleton-strategy endpoint;

Tier-1 value optimality and ε-adversaries from the menu engine, already banked in v8.

Exact constructive subclass theorems:

binary-state capstone under (R-EE)+(R-TD)+(R-IES);

FBNF capstone under fibered-binary normal-fan primitives plus global fiber dominance;

radial/spherical and scalarizable-face subclasses.

A cone-Hall biconditional for the remaining class:

for a fixed regular optimal labeling w
∗
, robust rationalizability is equivalent to

Ψ
w
∗
	​

(y)≤0for all bounded Borel y:M→R
N
.

finite-facet/polyhedral cases reduce this condition to a computable finite LP.

This is not the unrestricted standing-only Theorem 2 extension.

B.1 T1: finite-menu Pareto-Hall calibration in payoff-label coordinates

Let

C={w
1
	​

,…,w
k
	​

}⊆W
P

be a finite payoff menu. Define the finite-menu value functional

F
k
	​

(w
1
	​

,…,w
k
	​

)=∫
M
	​

[α
i
max
	​

s⋅w
i
	​

+(1−α)
i
min
	​

s⋅w
i
	​

]τ(ds).

At a Pareto-completed ambient local maximizer, Clarke-Danskin stationarity produces active multipliers

λ
+
,λ
−
:M→Δ(k),

supported on max-active and min-active labels, respectively.

For each active label i, define

g
i
	​

=α∫
M
	​

λ
i
+
	​

(s)sdτ(s)+(1−α)∫
M
	​

λ
i
−
	​

(s)sdτ(s),

and

q
i
	​

=α∫
M
	​

λ
i
+
	​

(s)dτ(s)+(1−α)∫
M
	​

λ
i
−
	​

(s)dτ(s).

If q_i > 0, then

  p_i := g_i / q_i  ∈  B_W(w_i).

(Vector numerator g_i ∈ R^|Ω|, scalar mass q_i > 0; the quotient is
the unique posterior in Δ(Ω) supporting profile w_i.) This is the
T1 posterior formula in hardened form: the displayed p_i is the
vector g_i divided by the scalar q_i — *not* a fraction with vector
numerator and vector denominator.

Interpretation. T1 is a payoff-label theorem. It proves calibration in the finite menu coordinates, not by itself a full original-message Theorem 2 result. The original-message lift is exactly where binary, FBNF, and cone-Hall enter.

B.2 T2: the α=0 singleton endpoint

When

α=0,

the model is pure adversarial. The agent can ignore the adviser and play a private strategy Bayes-optimal at the prior μ
0
	​

. Let the adversary send a constant on-path message. Since the adviser posterior has barycenter μ
0
	​

, the posterior after the single on-path message is μ
0
	​

. Thus the continuation is Bayes-optimal q-a.e.

This is a complete infinite-M,Θ existence theorem for α=0, but it is a scope-changing degenerate endpoint, not the substantive α∈(0,1) theorem.

B.3 Binary capstone: ∣Ω∣=2

Assume

∣Ω∣=2,α∈(0,1),

and identify beliefs with [0,1]. Let the optimal trust region be

T
∗
=[L,R].

The binary capstone assumes:

(R-EE)B
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

Endpoint exposure means the endpoint payoff profiles are rationalized by unique endpoint beliefs.

(R-TD)τ({s:s⋅w
L
	​

=s⋅w
R
	​

})=0.

Tie discipline removes positive mass at the endpoint indifference belief.

(R-IES)0<L<R<1.

Interior endpoint stationarity rules out boundary KKT-only cases.

Then there exists a robustly rationalizable optimal strategy for arbitrary measurable M and compact metric Θ. The strategy is

σ
^
∗
(m)=ρ
W
	​

(w
∗
(Π
[L,R]
	​

(m))).

The adversarial construction uses endpoint fibers, not singleton endpoint messages:

A
L
	​

=[0,L]∩M,A
R
	​

=[R,1]∩M.

The endpoint-balance equations are

α∫
A
L
	​

	​

(L−m)τ(dm)=(1−α)∫
S
+
	​

	​

(s−L)τ(ds),

and

α∫
A
R
	​

	​

(m−R)τ(dm)=(1−α)∫
S
−
	​

	​

(R−s)τ(ds).

The binary scalar endpoint-fiber lift supplies kernels

κ
L
	​

:S
+
	​

→Δ(A
L
	​

),κ
R
	​

:S
−
	​

→Δ(A
R
	​

),

with no extra unrelated traffic into the calibrated endpoint fibers. It yields

P
β
∗
	​

(⋅∣m)=Lfor q-a.e. m∈A
L
	​

,

and

P
β
∗
	​

(⋅∣m)=Rfor q-a.e. m∈A
R
	​

.

Interior messages m∈(L,R)∩M are calibrated truthfully:

P
β
∗
	​

(⋅∣m)=mq-a.e.

Thus 
σ
^
∗
(m) is Bayes-optimal under P
β
∗
	​

(⋅∣m) q-a.e.

Scope. This is a full infinite-M,Θ Theorem 2 existence result in the binary-state subclass, conditional on (R-EE),(R-TD),(R-IES). These do not follow from standing hypotheses alone.

B.4 FBNF capstone: ∣Ω∣≥3 with fibered-binary normal fan

Assume

∣Ω∣≥3,α∈(0,1).

The FBNF class is a geometry in which the multidimensional belief problem decomposes into one-dimensional affine fibers. It is a primitive sufficient class, not a universal theorem.

FBNF-1: measurable affine chart / quotient-consistent foliation

There is a standard Borel coordinate space

E={(z,t):z∈Z, t∈[a
z
	​

,b
z
	​

]},

a probability

τ
ˉ
(dz,dt)=λ(dz)τ
z
	​

(dt),

and a jointly Borel affine map

Φ(z,t)=ℓ
z
	​

(t)∈Δ(Ω)

such that

Φ
#
	​

τ
ˉ
=τ.

We require either:

Φ is injective on a 
τ
ˉ
-full Borel subset, or

overlaps are quotient-consistent: overlapping coordinates prescribe the same TRS label and same endpoint posterior.

A mere Borel cover is not enough; without this chart or quotient consistency, pasted posteriors can be multivalued at the same message. 

sanity_chunk2_response

FBNF-2: fiber-preserving TRS

The optimal trust region has the form

T=
z
⋃
	​

T
z
	​

,T
z
	​

=ℓ
z
	​

([L(z),R(z)]),

and projection preserves fibers:

Π
T
	​

(ℓ
z
	​

(t))=ℓ
z
	​

(Π
[L(z),R(z)]
	​

(t)).
FBNF-3: endpoint-supported fiber image

For 
τ
ˉ
-a.e. (z,t),

μ∈T
z
	​

min
	​

ℓ
z
	​

(t)⋅w
∗
(μ)=min{ℓ
z
	​

(t)⋅w
∗
(ℓ
z
	​

(L(z))),ℓ
z
	​

(t)⋅w
∗
(ℓ
z
	​

(R(z)))}.

This is endpoint-supported, not necessarily strict argmin-set inclusion. Interior ties are allowed unless a separate strict no-interior-flatness condition is imposed.

FBNF-4: fiberwise endpoint exposure
B
W
	​

(w
z,L
	​

)∩ℓ
z
	​

([a
z
	​

,b
z
	​

])={ℓ
z
	​

(L(z))},

and symmetrically,

B
W
	​

(w
z,R
	​

)∩ℓ
z
	​

([a
z
	​

,b
z
	​

])={ℓ
z
	​

(R(z))}.
FBNF-5: fiberwise tie discipline

The endpoint tie set has zero τ
z
	​

-mass for λ-a.e. z. If tie mass is positive, one needs an explicit measurable tie-splitting variant.

Local two-sided perturbability

For bounded Borel endpoint perturbations

L
ε
	​

(z)=L(z)+εh(z),R
ε
	​

(z)=R(z)+εk(z),

supported on interior patches with positive margin, the perturbed band remains admissible for small ∣ε∣.

Under this condition, FBNF-6 is derived, not primitive. The derived fiberwise balances are

α∫
a
z
	​

L(z)
	​

(L(z)−t)τ
z
	​

(dt)=(1−α)∫
S
+
	​

(z)
	​

(t−L(z))τ
z
	​

(dt),

and

α∫
R(z)
b
z
	​

	​

(t−R(z))τ
z
	​

(dt)=(1−α)∫
S
−
	​

(z)
	​

(R(z)−t)τ
z
	​

(dt).

If two-sided perturbability fails, the correct replacement is a one-sided KKT inequality, not equality. 

prover_10_response

FBNF-7: global fiber dominance

For 
τ
ˉ
-a.e. (z,t),

μ∈T
min
	​

ℓ
z
	​

(t)⋅w
∗
(μ)=
μ∈T
z
	​

min
	​

ℓ
z
	​

(t)⋅w
∗
(μ).

This is the cross-fiber condition that turns fiber-local rowwise minimizers into true original-game minimizers.

FBNF conclusion

Under standing hypotheses, ∣Ω∣≥3, α∈(0,1), FBNF-1 through FBNF-5, local two-sided perturbability, and FBNF-7, there exists a robustly rationalizable optimal strategy.

The adversarial kernel has endpoint-fiber support:

suppβ
∗
(⋅∣ℓ
z
	​

(t))⊆ℓ
z
	​

([a
z
	​

,L(z)])∪ℓ
z
	​

([R(z),b
z
	​

]),

with projected payoff image contained in the two endpoint labels:

Π
T
	​

(suppβ
∗
(⋅∣ℓ
z
	​

(t)))⊆{ℓ
z
	​

(L(z)),ℓ
z
	​

(R(z))}.

It is not a singleton-endpoint kernel. The literal message kernel spreads over endpoint fibers to calibrate posteriors.

For q-a.e. message m=ℓ
z
	​

(u):

u∈[a
z
	​

,L(z)]⇒P
β
∗
	​

(⋅∣m)=ℓ
z
	​

(L(z)),
u∈[R(z),b
z
	​

]⇒P
β
∗
	​

(⋅∣m)=ℓ
z
	​

(R(z)),

and

u∈(L(z),R(z))⇒P
β
∗
	​

(⋅∣m)=m.

Therefore the TRS continuation is Bayes-optimal q-a.e.

Compatibility with WTA. WTA ternary is not ruled out because a 2-simplex cannot be foliated by line segments in a bare geometric sense. The correct statement is narrower: WTA ternary is not fibered-binary in the FBNF sense because its active normal-fan / vertex-label geometry does not decompose into one-dimensional scalar B1 transports; if one forces a decomposition, FBNF-7 fails. 

prover_11_response

B.5 G1, G2c, and G3: cone-Hall classification
G1: finite cone-Hall theorem

In a finite source-message model with closed convex Bayes cones B
j
	​

, nonnegative flows x
ij
	​

 supported on allowed rowwise minimizer sets exist and calibrate posteriors iff the corrected cone-Hall inequality holds.

The sign is

Ψ(y)≤0,

not Ψ(y)≥0.

This follows from the support-function convention

h
B
j
	​

	​

(y)=
μ∈B
j
	​

sup
	​

y⋅μ.

Calibration

q
j
	​

n
j
	​

	​

∈B
j
	​


is equivalent to

y
j
	​

⋅n
j
	​

−h
B
j
	​

	​

(y
j
	​

)q
j
	​

≤0∀y
j
	​

.

The WTA ternary no-baseline full-vertex test gives a positive dual certificate. With α=1/2,

Ψ(y)=2/9>0,

so the corrected condition Ψ(y)≤0 fails. The WTA computation uses y
j
	​

=1−2e
j
	​

, h
B
j
	​

	​

(y
j
	​

)=1/3, E[s
j
	​

∣s∈K
j
−
	​

]=1/9, and total misaligned contribution 4/9. 

prover_12_response

G2c: compact-closed Borel cone-Hall

Bare standard-Borel cone-Hall is false: no-escape regularity is needed. The compact-closed version assumes:

M compact metric;

G(s) has closed graph and nonempty compact values;

m↦h
B(m)
	​

(a) is continuous for every fixed a∈R
N
.

Under these assumptions, the Borel kernel problem is equivalent to the Borel cone-Hall inequality.

The proof uses global conic separation, not compact-patch deletion. It avoids the v8 obstacles as follows:

no Borel-to-compact deletion argument;

no finite cell-flow lift to repair;

no ε-net slack discipline.

Instead the primal variable is already a measure on the graph of G, and disintegration gives the kernel. 

sanity_chunk2_response

G3: Robust Trust Hall biconditional

Fix a G2c-admissible value-optimal labeling

w
∗
:M→W
P
.

Let

G(s)={m∈M:s⋅w
∗
(m)=
z∈C
∗
min
	​

s⋅z},

and

B(m)=B
W
	​

(w
∗
(m)).

Define

Ψ
w
∗
	​

(y)=α∫
M
	​

[y(m)⋅m−h
B(m)
	​

(y(m))]τ(dm)
+(1−α)∫
M
	​

m
′
∈G(s)
inf
	​

[y(m
′
)⋅s−h
B(m
′
)
	​

(y(m
′
))]τ(ds).

Then, under Reg-1 and Reg-2,

σ(w
∗
) is robustly rationalizable⟺Ψ
w
∗
	​

(y)≤0∀ bounded Borel y:M→R
N
.

This is a fixed-labeling biconditional. The existence version is:

∃w
∗
 optimal and Reg-admissible with Ψ
w
∗
	​

≤0.

The reverse direction constructs a Borel kernel κ supported on G(s) and satisfying

P
γ
α
	​

	​

(⋅∣m)∈B(m)q-a.e.

Then β
∗
=κ is an exact adversary, and 
σ
^
∗
(m)=ρ
W
	​

(w
∗
(m)) is Bayes-optimal q-a.e. 

prover_14_response

B.6 Phase (b): regularity cannot be removed from standing alone

The regularity package is not automatic from standing Robust Trust assumptions.

Standing assumptions give compact M=suppτ⊆Δ(Ω), so the old missing-boundary counterexample is killed. But compactness does not force:

w
∗
 continuous,Gr(G) closed,m↦h
B(m)
	​

(a) continuous.

Borel payoff-label jumps and Bayes-cone jumps remain possible. 

prover_18_response

The clean conditional replacement is:

If w
∗
:M→W
P
 is continuous on compact M, and for every a∈R
N
,

m↦h
N
W
	​

(w
∗
(m))∩Δ(Ω)
	​

(a)

is continuous, then G has closed graph and compact values, B(m) is support-function continuous, and G3 applies.

These conditions are automatic under smooth/exposed-frontier primitives such as:

unique Bayes-optimal private strategy for each belief;

globally continuous Bayes-optimal selection w
∗
;

C
1
 exposed Pareto frontier W
P
;

continuous Gauss/normal map.

“Borel-positive” phrasing should not be used here. The needed primitive is globally continuous Bayes-optimal selection, not positivity on a Borel patch.

B.7 Primitive sufficient classes
P2*: cone-margin plus bounded rowwise jamming

Assume Reg-1/Reg-2. Suppose truthful messages sit uniformly inside their Bayes cones: there is η>0 such that

dist(m,Δ(Ω)∖B(m))≥ητ-a.e.

Suppose also that there exists a rowwise-minimizer kernel κ
0
	​

 supported on G(s) whose target marginal ρ satisfies

ρ≪τ,
dτ
dρ
	​

≤C.

Let D
Δ
	​

 denote the diameter of Δ(Ω) in the chosen norm. If

α+(1−α)C
(1−α)C
	​

D
Δ
	​

≤η,

then the mixture posterior remains inside B(m), hence Ψ≤0, and G3 gives robust rationalizability.

This is a non-foliated primitive sufficient class: high enough aligned mass plus diffuse enough adversarial traffic absorbs jamming.

P3/G4: polyhedral finite-facet LP

Assume W is polyhedral, the active optimal menu is finite,

C
∗
={w
1
	​

,…,w
k
	​

},

and each Bayes cone has a finite facet representation

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

}.

Let A
j
	​

 be the aligned-message cell using label j, and S
j
	​

 the rowwise minimizer source cell for label j. Define

q
j
	​

=ατ(A
j
	​

)+(1−α)τ(S
j
	​

),
n
j
	​

=α∫
A
j
	​

	​

mτ(dm)+(1−α)∫
S
j
	​

	​

sτ(ds).

Then the finite-facet LP condition is

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

∀j,ℓ.

Equivalently, with

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

mdτ,
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

sdτ,

the inequality is

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

Tie discipline is required for this simple per-cell equivalence. If rowwise minimizer ties have positive mass, the LP needs explicit tie-splitting variables.

Raw polyhedrality is not enough. WTA ternary is the warning beacon: finite vertices can still fail Ψ≤0. What polyhedrality gives is a computable pass/fail test.

WTA threshold normalization

Use the following convention throughout. Let D be aligned baseline depth normalized so that the aligned contribution of the WTA certificate is −2D. Then

Ψ(y)=−2αD+(1−α)
9
4
	​

.

Therefore the WTA finite-facet condition is

−2αD+(1−α)
9
4
	​

≤0,

equivalently

D≥
9α
2(1−α)
	​

.

At α=1/2,

D≥
9
2
	​

.

This is the single normalization used in this memo. The reciprocal formula is discarded.

P4: radial / antipodal models

Radial/spherical models are handled constructively, not by symmetrizing arbitrary dual prices. Under radial or compact-group equivariant primitives:

τ is radial or invariant;

the indirect utility is radial, e.g. U(μ)=V(∥μ−b∥);

the optimal trust region is a ball around b;

the adversary routes to antipodal boundary points;

a scalar radial balance calibrates the posterior.

The constructed kernel is primal-feasible; G2c then implies Ψ(y)≤0 for all bounded Borel y.

Section C — Hypothesis ledger
C.1 Classification key

Standing. The paper’s assumptions: finite Ω, full-support μ
0
	​

, compact metric A,Θ, bounded u continuous in a, conditional independence, Borel measurability.

Added regularity. Topological/measurable requirements needed to make an infinite-dimensional theorem well-posed. These may still be economically meaningful.

Added primitive. Model-side assumptions on geometry, ties, support, or alignment.

Meaningful narrowing. A real restriction on the model, but not equivalent to the conclusion.

Scope-changing. A condition or endpoint that changes the theorem’s spirit.

C.2 Ledger by theorem
Theorem block	Standing	Added regularity	Added primitive	Meaningful narrowing	Scope-changing
T1 finite-menu Pareto-Hall	Yes	finite menu, active multiplier measurability	Pareto-completed ambient local maximizer	Yes, payoff-label coordinate theorem	No
T2 α=0 singleton	Yes	standard Bayes selector	α=0	No	Yes, degenerate endpoint
Binary capstone	Yes	q-a.e. reading, measurable B1 kernels	R-EE, R-TD, R-IES	Yes	No
FBNF capstone	Yes	Borel affine chart / quotient consistency; local two-sided perturbability	FBNF-1..5, FBNF-7	Yes	No
G1 finite cone-Hall	finite abstraction	finite conic LP setup	support sets R(i), cones B
j
	​

	classification tool	No
G2c Borel cone-Hall	Yes	compact M, closed graph G, support-continuous B	none beyond cone data	Yes, no-escape regularity	No
G3 biconditional	Yes	Reg-1, Reg-2	Ψ
w
∗
	​

≤0 as diagnostic	Reg is meaningful; Ψ is exact condition	Ψ as assumption is close to conclusion
P2*	Yes plus Reg	density / domination of rowwise traffic	cone margin, bounded jamming, high enough α	Yes	No
P3/G4	Yes	finite cells or closed quotient; tie discipline or tie-splitting variables	finite-facet Bayes cones, LP pass	Yes	No
P4 radial	Yes	smooth radial normal structure	radial/equivariant primitives	Yes	No
Phase (b)	Yes	continuity of w
∗
, support-continuity of B	smooth/exposed-frontier primitives imply Reg	meaningful regularity	No
C.3 Gatekeeper summary

The package is OBJECTIVE_NARROWED. The binary, FBNF, P2*, P3/G4, and P4 assumptions are economically meaningful and not simply menu-Hall in disguise. But they are real restrictions. Reg-1/Reg-2 are not trivial. The condition Ψ≤0, if used as an assumption, is an exact cone-Hall feasibility condition; as a biconditional, it is a classification theorem.

Section D — Dependency graph and proof sources
D.1 Master dependency graph
Standing RT primitives⇒W,W
P
,B
W
	​

(w)⇒payoff-label representation.
Finite menu⇒L6 Clarke-Danskin⇒L7 Fermat⇒L8 calibration multiplier⇒T1.
∣Ω∣=2⇒TRS interval⇒endpoint-only payoff image⇒endpoint stationarity⇒B1 scalar endpoint-fiber lift⇒binary capstone.
FBNF⇒F2 endpoint-supported fiber image⇒F3 localized stationarity⇒F1 conditional B1 + pasting⇒F4 capstone.
G1 finite cone-Hall⇒G2c compact-closed cone-Hall⇒G3 Robust Trust Hall biconditional⇒P2*/P3/P4 and G4.
Phase (b)⇒Reg not eliminable from standing⇒smooth/exposed-frontier primitives make Reg automatic.
D.2 Detailed source ledger
Block	Lemmas	Source files	Reviewer status
T1 finite-menu Pareto-Hall	L6, L7, L8	prover_01_response.md, prover_02_response.md	L6 patched; L7/L8 PASS
T2 α=0	singleton prior strategy	reviewer_03_response.md, chronicle	PASS
Binary capstone	B1, B3, B5, B6	prover_05_response.md, prover_06_response.md, prover_07_response.md	PASS after RN + endpoint-fiber patches
FBNF capstone	F1, F2, F3, F4	prover_08_response.md, prover_09_response.md, prover_10_response.md, prover_11_response.md	PASS after endpoint-fiber, Borel chart, local perturbability patches
G1	finite cone-Hall	prover_12_response.md	PASS with sign Ψ≤0
G2c	compact-closed Borel cone-Hall	prover_13_response.md	PASS under Reg/no-escape
G3	fixed-label RT biconditional	prover_14_response.md	PASS under Reg
P2*/P3/P4	primitive sufficient classes	prover_15_response.md	PASS with caveats
G4	finite-facet LP	prover_16_response.md	PASS under finite-cell/tie-free or tie-split LP
LP examples	WTA, plurality, finite experiment	prover_17_response.md	WTA/plurality patched; finite experiment illustrative only
Phase (b)	Reg eliminability	prover_18_response.md	definitive: Reg not standing-automatic
D.3 Cross-theorem consistency

T1 is used in binary/FBNF stationarity arguments; binary/FBNF do not feed back into T1.

Binary B1 is not literally a theorem about all higher-dimensional messages. FBNF applies scalar B1 conditionally on affine one-dimensional fibers, then pastes the kernels.

G3 does not replace binary or FBNF. G3 is a fixed-label biconditional under Reg-1/Reg-2. Binary and FBNF are constructive positive capstones under their own primitives.

No banned route is used: no product-of-narrow Sion master theorem, no τ-AC restriction, no failed FOC/envelope infinite route, no canonical/minimal pruning, and no postulated menu-Hall as the main conclusion. The calibrations come from Clarke-Danskin, scalar B1, conditional B1+pasting, or cone-Hall Ψ≤0. 

gatekeeper_response

Section E — Application table

| Application | Applies theorem | Conditions to check | Conclusion |
|---|---|---|---|
| Binary state, \|Ω\|=2 | Binary capstone | R-EE, R-TD, R-IES; arbitrary measurable M, compact metric Θ | Unconditional full infinite-M, Θ Theorem 2 existence |
| α=0 | T2 singleton | none beyond standing and Bayes selector | Degenerate pure-adversarial robust rationalizability |
| Smooth \|Ω\|≥3 | G3 + Phase (b) | continuous w*, support-continuous Bayes cones, plus verified Ψ≤0 or one of P2*/P3/P4 | G3 applies under Reg; biconditional / classification under Ψ≤0 |
Polyhedral finite-action	G4 LP	finite active vertex menu, finite-facet Bayes cones, closed/tie-free active cells or tie-splitting variables	Theorem 2 holds iff finite LP is feasible; violation gives dual certificate
WTA ternary full vertex, no aligned baseline	G1/G4	WTA cones and minimizer regions	fails Ψ≤0 by explicit certificate
Baseline-augmented WTA	G4 LP	aligned depth D under fixed normalization	holds once D ≥ 2(1−α)/(9α) (i.e., at α=1/2, D ≥ 2/9), subject to all finite-facet hypotheses
Spherical/radial	P4 or FBNF	radial/equivariant U,τ, ball trust region, antipodal boundary routing, scalar radial balance	constructive calibrated kernel; G2c then gives Ψ≤0
Affine MLR / single-crossing	FBNF if affine-fiber exact	affine belief fibers, fiber-preserving TRS, endpoint exposure, global dominance	conditional FBNF theorem
General curved MLR	not closed	need affine reparameterization or non-affine fiber theorem	open
Fan-induced / scalarizable faces	FBNF or G4	each active face scalarizes into one-dimensional fibers, or finite-facet LP passes	FBNF constructs kernel; G4 gives LP certificate
Finite-experiment examples	G4 template	enumerate labels, facets, aligned/misaligned masses and means	use as spreadsheet-style feasibility check; current worked finite-experiment example remains illustrative pending independent verification
Section F — Open problems and closure status
F.1 What remains open

The unrestricted existence direction of Theorem 2 remains open in the following precise sense.

We do not have a proof under standing hypotheses alone for arbitrary finite ∣Ω∣, arbitrary compact metric Θ, arbitrary M=suppτ, and arbitrary bounded u continuous in a.

The open region is:

∣Ω∣≥3;

no binary structure;

no FBNF/radial/scalarizable-fiber primitive;

no cone-margin/bounded-jamming primitive;

no finite-facet LP pass;

no Reg-1/Reg-2 package, or Reg holds but Ψ≤0 has not been verified.

Equivalently, the totally unstructured ∣Ω∣≥3 case remains open without:

regularity package+checkable Ψ(y)≤0,

or without one of the primitive classes that imply Ψ≤0.

F.2 Deletion-compatible Hall duality status

The deletion-compatible Hall duality problem is no longer an amorphous gap. It has been converted into the G3/G2c cone-Hall biconditional under compact-regular hypotheses:

calibrated adversarial kernel exists⟺Ψ(y)≤0 ∀y.

This is a classification theorem. It is not an unconditional existence theorem.

The old v8 obstruction remains meaningful: null-message dust cannot repair the WTA ternary vector-balance obstruction, and the WTA witness is a menu-engine obstruction, not a primitive counterexample to unrestricted Theorem 2. 

theorem_2_extension_proof_v8

F.3 Regularity open problem

Phase (b) shows:

standing+compact M

⇒Reg-1/Reg-2.

The minimal useful extra primitive appears to be:

w
∗
 continuous on M+m↦B(m) support-continuous.

The open refinement is to find a weaker no-escape condition than global continuity that still supports G2c.

F.4 Primitive sufficient conditions for Ψ≤0

Known routes:

P2*: cone-margin plus bounded jamming;

P3/G4: finite-facet LP feasibility;

P4: radial/antipodal constructive calibration;

FBNF: conditional scalar B1 transports plus global fiber dominance.

Open routes:

smooth full-support non-polyhedral theorem;

curved MLR reparameterization;

polyhedral W without scalarizable faces but with a tractable cone-Hall certificate;

exact WTA threshold classification for broader (α,τ), using G1/G4 rather than dust.

F.5 Final positioning

This package should be presented to Piotr as follows:

We do not claim an unrestricted infinite-M,Θ proof of Theorem 2 under standing hypotheses alone. We have a strong conditional/classification result. The package proves exact robust rationalizability for several economically meaningful subclasses, gives a fixed-label cone-Hall biconditional for the general regular case, reduces finite-action/polyhedral cases to an LP, and pinpoints the remaining open object as the unstructured ∣Ω∣≥3 case without Reg, without primitive structure, and without a verified Ψ(y)≤0 certificate.

Section G — Weakenings and sharpenings (v9.2 addendum, 2026-05-21)

Three targeted weakening attempts on the load-bearing primitive
conditions, all reviewer-verified:

**G.1 Binary-TS (weaken R-TD → R-TD\*).**
Replaces R-TD ("τ no atom at the indifference belief") with R-TD\*
("τ may have atom $\kappa$ at the indifference belief $s^*$, with
measurable tie-splitting weights $\lambda^+(s^*), \lambda^-(s^*) \in [0,1]$").
Prover 21 + Reviewer 18 PASS. Mechanism: Clarke-Danskin stationarity
at the atom produces the tie weights; modified L_B5 total-balance
includes the tie-mass; L_B1 applies to adjusted measures; endpoint
calibration $P_{\hat\beta^*}(\cdot|L) = L$ survives. Effect: binary
capstone extends to atomic-at-knife-edge τ, covering common
applications with discrete-time or mass-point signals.

**G.2 P2\*-VM (variable cone-margin).**
Replaces P2\*'s uniform cone-margin $\eta > 0$ with a Borel-positive
variable margin $\eta(m): M\to(0,\infty)$, under the integrable
upper-capacity condition $b_\eta \le \Gamma_\eta$. Prover 22 + Reviewer 19
PATCH-then-PASS. Effect: P2\* extends to smooth models where the
Bayes-cone width can shrink at certain boundary points of $M$ (e.g.,
near the simplex boundary of $\Delta(\Omega)$) but remains positive
in the interior.

**G.3 Global-TRS derivation for P6^G.**
Removes Reviewer 17's caveat by deriving the global-TRS hypothesis
from primitive finite-graph geometry. Prover 23 PASS with stronger
primitive: "piecewise continuous $w^*$" upgrades to "edgewise
finite-contact (no-fractal contact) + vertex quotient consistency."
Effect: P6^G's primitive class becomes fully derivable from
$(u, A, \Omega, \Theta, \tau, \text{graph}\,G)$.

**Net for v9.2**: three sharpenings, all economically meaningful,
none changing the headline framing. The package remains a **strong
conditional / classification result**; the unconditional open object
is still the unstructured |Ω|≥3 case without Reg/primitive/checkable
Ψ(y)≤0.

ready to send to Piotr as a strong conditional / classification result
