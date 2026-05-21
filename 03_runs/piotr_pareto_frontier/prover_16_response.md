
========
ROLE: user (id=ce8724bc-e266-4427-8821-3a1dce691d38)
========
# Prover pass 16 — Finite-facet polyhedral LP threshold

## Role

You are the Prover. Per Reviewer 13 + Prover 15's next-step signal:
formalize the **finite-facet polyhedral version** of the cone-Hall
sufficient condition. Goal: an explicit LP threshold that classifies
finite-action multi-state models — including the v8 WTA ternary
witness and its baseline-augmented variants — into "Theorem 2 holds"
vs "fails by dual certificate".

## The theorem to prove (G4 polyhedral threshold)

### Setup
- $|\Omega| \ge 3$, finite.
- $W$ polyhedral with finitely many vertices $\{v_1, \ldots, v_K\}$
  (e.g., finite action set with linear utility extended over $\Theta$).
- $C^* \subseteq W^P$ is the optimal menu, taken to be a finite subset
  of vertices: $C^* = \{w_1, \ldots, w_k\} \subseteq \{v_1, \ldots, v_K\}$.
- $B_W(w_j) = $ supporting belief cone at vertex $w_j$ — a polyhedral
  closed convex subset of $\Delta(\Omega)$.
- $R(s) = $ rowwise minimizer correspondence.
- $\tau \in \Delta(M)$ with $M \subseteq \Delta(\Omega)$ Borel.
- $\alpha \in (0,1)$.

### G4 Theorem statement
There exists $\delta > 0$ — depending only on the polyhedral geometry
of $W$, $C^*$, and the cone margins — such that **if the aligned
baseline satisfies the explicit LP threshold inequality** (to be derived
below), then the cone-Hall dual inequality $\Psi(y) \le 0$ holds for
all bounded Borel $y$.

### LP threshold (to derive)

For each vertex $j$ and each candidate dual price $y^{(j)}$
(parametrized by the finite normal fan), define:
- $a_j(y) = \alpha\int_M[y\cdot m - h_{B_j}(y)]\,\mathbf{1}_{\text{aligned at }j}\tau(dm)$
- $b_j(y) = (1-\alpha)\int_S[y\cdot s - h_{B_j}(y)]\,\mathbf{1}_{S_j}\tau(ds)$

where $S_j = R^{-1}(j)$ is the source region routing to vertex $j$.

The threshold condition: for each "extreme" dual price family $y$
(parameterized by the polyhedral normal fan of $W$),
\[
a_j(y) + b_j(y) \le 0 \quad \text{for every }j.
\]

This is finitely many inequalities (one per polyhedral cone-cell of
dual prices), each EXPLICITLY COMPUTABLE in terms of:
- $\alpha$
- aligned baseline weights $\tau(\text{aligned-cell-at-}j)$
- misaligned source weights $\tau(S_j)$
- positions $m_j$, $w_j$.

### Application to WTA ternary

For $|\Omega| = 3$, $W$ = WTA polyhedron (3 vertices), $C^* = \{v_0, v_1, v_2\}$:
- The dual prices $y_j = 1 - 2e_j$ from G1 are EXTREME for the WTA
  normal fan.
- The G4 threshold reduces to the inequalities derived in G1's WTA
  computation.
- Without baseline: $\Psi(y) = (1-\alpha) \cdot 4/9 > 0 \Rightarrow$
  Theorem 2 fails.
- With baseline $D \ge 2(1-\alpha)/(9\alpha)$: $\Psi(y) \le 0 \Rightarrow$
  Theorem 2 holds.

This recovers exactly the threshold from Reviewer 11.

## Proof structure

### Step 1 — Polyhedral normal fan
$W$ polyhedral ⇒ the dual normal-cone correspondence
$y \mapsto \arg\max_{w\in C^*} y\cdot w$ has piecewise-constant
behavior partitioned by a finite normal fan in $\R^{|\Omega|}$.

### Step 2 — Extreme dual price
The cone-Hall dual $\Psi(y) \le 0$ holds for all bounded Borel $y$
iff it holds at the EXTREME dual prices of the polyhedral normal
fan. By finiteness, this is finitely many inequalities.

### Step 3 — Per-vertex decomposition
For each polyhedral cone-cell, the extreme dual price $y^{(j)}$
satisfies $y^{(j)}\cdot w_k - h_{B_k}(y^{(j)}) = ?$ in a specific
piecewise-linear way.

### Step 4 — LP threshold
Combine across vertices. The threshold becomes a finite-dimensional LP
in baseline weights vs. misaligned source weights.

### Step 5 — Classification of finite-action models
Apply Step 4 to: WTA, plurality voting, finite-experiment design,
ordered finite-action models. Each gives an explicit threshold for
Theorem 2.

## What I want


# Theorem G4 (Finite-facet polyhedral threshold)

## Statement

## Hypotheses (polyhedral W, finite vertices, |Ω|≥3, α∈(0,1))

## Proof
### Step 1 — Polyhedral normal fan
### Step 2 — Reduction to finite extreme prices
### Step 3 — Per-vertex piecewise-linear decomposition
### Step 4 — LP threshold inequalities

## Application to WTA ternary
Recover the G1 WTA dual certificate as a special case. Verify the
threshold $D \ge 2(1-\alpha)/(9\alpha)$.

## Application to other finite-action models
- Plurality voting (general |Ω|).
- Finite-experiment design (Doval-Smolin examples).
- Ordered finite-action MLR.

## Implications
- Robust Trust Theorem 2 for finite-action polyhedral models reduces
  to a finite LP feasibility check.
- The threshold is explicit and computable.

## Open
- Non-polyhedral W (smooth strictly convex).
- Infinite-action limits.


## Output Contract

- Inline markdown.
- Be explicit about the LP formulation.
- Apply to WTA ternary as the killer sanity check.
- End with verdict + next-step.

## Constraints

- Banned tools list applies.
- G3 biconditional may be cited as proved.
- Per user: relentless. The LP threshold is the deliverable.

Show more

========
ROLE: assistant (id=77a53183-cd6d-4088-ad2a-2149cf73ca3b)
========
I’ll recast G3’s cone-Hall condition as a finite polyhedral LP test, while guarding against an unjustified “finite extremes” reduction for arbitrary Borel prices. The proof will keep sign conventions aligned with G1/G2c and use ternary WTA as the main threshold check.

========
ROLE: assistant (id=01b51cc0-b0f4-48e7-9f1a-ee25f210a4ab)
========
I’ll make the finite reduction exact only after normalizing the dual cones or passing to a finite label/cell quotient, so scale and pointwise Borel variation do not invalidate the LP.

========
ROLE: assistant (id=d4c5449c-e964-40ed-8ea8-0734ca3ca87a)
========
Theorem G4 — Finite-facet polyhedral LP threshold
Statement

Let Ω be finite, ∣Ω∣≥3. Suppose W⊂R
∣Ω∣
 is a polytope and the chosen optimal payoff-profile menu is a finite vertex menu

C
∗
={w
1
	​

,…,w
k
	​

}⊆vert(W).

For each j, let

B
j
	​

:=B
W
	​

(w
j
	​

)={μ∈Δ(Ω):w
j
	​

∈arg
w∈W
max
	​

μ⋅w}

be the Bayes-supporting belief cone of w
j
	​

. Assume B
j
	​

 is represented by finitely many facet inequalities

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

⊆M be the aligned-message cell at which the agent uses w
j
	​

, and let S
j
	​

⊆M be the rowwise-minimizer source cell whose misaligned best response induces payoff label w
j
	​

:

S
j
	​

:={s∈M:s⋅w
j
	​

=
ℓ=1,…,k
min
	​

s⋅w
ℓ
	​

}.

Assume tie discipline:

τ(M∖
j=1
⨆
k
	​

S
j
	​

)=0.

Define the weighted mass and numerator for label j:

q
j
	​

:=ατ(A
j
	​

)+(1−α)τ(S
j
	​

),
n
j
	​

:=α∫
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

Then the following are equivalent:

The cone-Hall dual inequality holds for every bounded Borel dual price y that is constant on the finite polyhedral label cells:

Ψ(y)≤0.

For every j with q
j
	​

>0,

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

.

Equivalently, the following finite LP/facet system holds:

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

∀j, ∀ℓ=1,…,L
j
	​

.
(G4-LP)

Moreover, if the inequalities are strict by a margin δ>0, then the cone-Hall inequality holds with slack. By the G3 biconditional, the induced optimal strategy is robustly rationalizable, hence Theorem 2 holds for that finite-facet model. If some inequality fails, the violated facet normal gives an explicit cone-Hall dual certificate, hence Theorem 2 fails for that fixed optimal labeling.

This is the finite-facet version of the cone-Hall biconditional: prior passes established that robust rationalizability for a fixed optimal labeling is equivalent to Ψ(y)≤0 for all bounded Borel prices, and the q-a.e. reading is the correct infinite-message interpretation. 

prover_14_response

 The compact/no-escape G2c theorem supplies the kernel iff the support-function cone-Hall inequality holds. 

prover_13_response

 The finite-facet reduction was identified as the clean next theorem for finite-action models. 

prover_14_response

Hypotheses

We use:

finite Ω, ∣Ω∣≥3;

α∈(0,1);

polyhedral W with finitely many vertices;

finite optimal menu C
∗
={w
1
	​

,…,w
k
	​

};

polyhedral Bayes cones B
j
	​

=B
W
	​

(w
j
	​

);

finite aligned cells A
j
	​

 and rowwise-minimizer cells S
j
	​

;

tie discipline, so R(s)={j} for τ-a.e. s∈S
j
	​

;

compact/no-escape regularity if M is not literally finite.

The finite-message case uses G1 directly. The compact Borel case uses G2c/G3, with the same finite-facet inequalities after projecting onto the finite normal fan. Bare standard-Borel without no-escape regularity is not enough; G2c explicitly needs compact-closed/continuous structure. 

prover_13_response

Proof
Step 1 — Polyhedral normal fan

For each vertex w
j
	​

, the Bayes cone

B
j
	​

={μ:w
j
	​

∈arg
w∈W
max
	​

μ⋅w}

is polyhedral. Its support function

h
B
j
	​

	​

(y):=
μ∈B
j
	​

sup
	​

y⋅μ

is convex, positively homogeneous, and piecewise linear. Therefore R
∣Ω∣
 is partitioned by the finite normal fan of B
j
	​

 into cones on which h
B
j
	​

	​

 is linear.

For fixed j, define

Φ
j
	​

(y):=y⋅n
j
	​

−q
j
	​

h
B
j
	​

	​

(y).

The cone-Hall requirement at label j is

Φ
j
	​

(y)≤0∀y∈R
∣Ω∣
.
(1)

Because h
B
j
	​

	​

 is piecewise linear on a finite fan, Φ
j
	​

 is piecewise linear. On every cone-cell of the fan it is linear. Hence (1) is equivalent to checking Φ
j
	​

≤0 on the extreme rays of all fan cells, or equivalently on a finite facet representation of B
j
	​

.

Tiny fan-dragon tamed: the continuum of dual prices has collapsed to finitely many rays.

Step 2 — Reduction to finite extreme prices

By the support-function characterization of closed convex sets,

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

⟺y⋅n
j
	​

≤q
j
	​

h
B
j
	​

	​

(y)∀y.
(2)

If B
j
	​

 has facet representation

B
j
	​

={p∈Δ(Ω):g
jℓ
	​

⋅p≤c
jℓ
	​

},

then (2) is exactly

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

∀ℓ.

Thus the infinite cone-Hall price check is equivalent to finitely many linear inequalities.

In support-function notation, for each finite extreme/facet price y
jℓ
	​

:=g
jℓ
	​

,

a
j
	​

(y
jℓ
	​

)+b
j
	​

(y
jℓ
	​

)≤0,

where

a
j
	​

(y):=α∫
A
j
	​

	​

[y⋅m−h
B
j
	​

	​

(y)]τ(dm),
b
j
	​

(y):=(1−α)∫
S
j
	​

	​

[y⋅s−h
B
j
	​

	​

(y)]τ(ds).

Indeed,

a
j
	​

(y)+b
j
	​

(y)=y⋅n
j
	​

−q
j
	​

h
B
j
	​

	​

(y).

This is exactly the corrected cone-Hall sign convention: feasibility gives Ψ≤0, not Ψ≥0. The earlier G1 finite theorem caught this sign issue explicitly. 

prover_12_response

Step 3 — Per-vertex decomposition

Under tie discipline,

R(s)={j}for τ-a.e. s∈S
j
	​

.

Therefore the cone-Hall functional decomposes:

Ψ(y)=
j=1
∑
k
	​

[α∫
A
j
	​

	​

(y
j
	​

⋅m−h
B
j
	​

	​

(y
j
	​

))τ(dm)+(1−α)∫
S
j
	​

	​

(y
j
	​

⋅s−h
B
j
	​

	​

(y
j
	​

))τ(ds)].

Thus

Ψ(y)=
j=1
∑
k
	​

(a
j
	​

(y
j
	​

)+b
j
	​

(y
j
	​

)).

Because the y
j
	​

’s are independent, Ψ(y)≤0 for all finite-cell price families iff

a
j
	​

(y
j
	​

)+b
j
	​

(y
j
	​

)≤0∀j, ∀y
j
	​

.

By Step 2, this is equivalent to the finite LP system (G4-LP).

If ties have positive τ-mass, the same inequalities remain sufficient after a measurable tie-breaking partition, but not necessary unless the tie-breaking is part of the model. For classification, impose tie discipline or include tie-splitting variables in the LP.

Step 4 — LP threshold inequalities

Write

λ
j
	​

:=τ(A
j
	​

),μ
j
	​

:=τ(S
j
	​

),

and, when the masses are positive,

m
ˉ
j
	​

:=
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
s
ˉ
j
	​

:=
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

sτ(ds).

Then

n
j
	​

=αλ
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

,
q
j
	​

=αλ
j
	​

+(1−α)μ
j
	​

.

The LP threshold is:

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
(LP)

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
(LP’)

If 
m
ˉ
j
	​

 lies in the relative interior of B
j
	​

, then

c
jℓ
	​

−g
jℓ
	​

⋅
m
ˉ
j
	​

>0

for every active facet. The minimum aligned baseline weight needed at label j is therefore

λ
j
	​

≥
ℓ: g
jℓ
	​

⋅
s
ˉ
j
	​

>c
jℓ
	​

max
	​

α(c
jℓ
	​

−g
jℓ
	​

⋅
m
ˉ
j
	​

)
(1−α)μ
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

)
	​

.
(Threshold)

This is the explicit LP threshold.

If a candidate model supplies fixed (λ
j
	​

,
m
ˉ
j
	​

,μ
j
	​

,
s
ˉ
j
	​

), the check is a finite feasibility test. If the baseline weights λ
j
	​

 are design variables, (LP') is a linear program in those weights.

Theorem G4, final form

Let W, C
∗
, A
j
	​

, S
j
	​

, and B
j
	​

 satisfy the finite-facet hypotheses above. Then:

Theorem 2 holds for the fixed optimal labeling⟺the finite LP system (LP) holds for every j,ℓ.
	​


Equivalently,

Theorem 2 fails⟺∃(j,ℓ) such that g
jℓ
	​

⋅n
j
	​

>c
jℓ
	​

q
j
	​

.
	​


The violating g
jℓ
	​

 is an explicit dual certificate.

This is the finite-facet LP threshold. It is not merely a sufficient condition; under the finite-cell/tie-free hypotheses, it is necessary and sufficient.

Application: WTA ternary

Let

Ω={0,1,2}.

In winner-takes-all,

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

The rowwise minimizer region for vertex j is

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

 ∀k}.

The Bayes cone for action j is

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

Take the symmetric WTA dual price

y
j
	​

=1−2e
j
	​

,

i.e. coordinate −1 at j, coordinate +1 at the other two states. Then

h
B
j
	​

	​

(y
j
	​

)=
3
1
	​

,

and for s∈K
j
−
	​

,

y
j
	​

⋅s−h
B
j
	​

	​

(y
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

Under uniform τ on the ternary simplex,

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

Therefore

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

Summing over j=0,1,2,

j
∑
	​

∫
K
j
−
	​

	​

[y
j
	​

⋅s−h
B
j
	​

	​

(y
j
	​

)]τ(ds)=
9
4
	​

.

This matches the stored finite cone-Hall certificate: the no-baseline full-vertex WTA instance has a positive dual value, hence fails the corrected Ψ≤0 cone-Hall test. 

prover_12_response

No aligned baseline

With no aligned baseline depth,

a(y)=0,

so

Ψ(y)=(1−α)
9
4
	​

>0.

Therefore Theorem 2 fails by explicit dual certificate.

Baseline-augmented WTA

Let the aligned baseline add mass inside the correct plurality cones. Define the aggregate WTA aligned depth

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

)τ(dm).

For the same price family,

j
∑
	​

∫
A
j
	​

	​

[y
j
	​

⋅m−h
B
j
	​

	​

(y
j
	​

)]τ(dm)=
j
∑
	​

∫
A
j
	​

	​

(
3
2
	​

−2m
j
	​

)τ(dm)=−2D.

Thus

Ψ(y)=−2αD+(1−α)
9
4
	​

.

The dual certificate is killed iff

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


So:

Without baseline: Ψ(y)=(1−α)
9
4
	​

>0, Theorem 2 fails.

With baseline depth

D≥
9α
2(1−α)
	​

,

this WTA certificate is neutralized.

In the symmetric WTA finite-facet model, the other facet inequalities are permutations of the same one, so the LP threshold reduces exactly to the displayed bound.

This recovers the Reviewer 11 threshold in the normalization requested here. Earlier notes warn that different normalizations of D invert or rescale the displayed bound; the invariant object is the inequality

−2αD+(1−α)
9
4
	​

≤0.
Application to other finite-action models
1. Plurality voting, general ∣Ω∣

Let W be the plurality payoff polytope with vertices v
1
	​

,…,v
N
	​

. The Bayes cone for vertex j is

B
j
	​

={p:p
j
	​

≥p
k
	​

 ∀k}.

The rowwise minimizer region is

S
j
	​

={s:s
j
	​

≤s
k
	​

 ∀k}.

The G4 LP becomes:

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

)≤0

for each plurality facet p
k
	​

−p
j
	​

≤0. Thus plurality voting reduces to N(N−1) linear inequalities. If the model is symmetric, these collapse to one scalar threshold, exactly as WTA ternary collapses.

2. Finite-experiment design / Doval-Smolin-style finite menus

If the experiment induces finitely many posterior cells and W is the convex hull of finitely many payoff profiles, then:

C
∗
 is finite;

each B
j
	​

 is a polyhedral normal cone;

each S
j
	​

 is a polyhedral cell in the posterior simplex.

The algorithm is:

enumerate active payoff vertices w
j
	​

;

compute B
j
	​

 by normal-cone inequalities;

compute rowwise minimizer cells S
j
	​

;

compute λ
j
	​

,
m
ˉ
j
	​

,μ
j
	​

,
s
ˉ
j
	​

;

solve (LP).

This is exactly the finite cone-Hall machinery: the finite theorem is a conic Farkas theorem with aligned baseline, and its dual is the support-function cone-Hall inequality. 

searcher_05_response

3. Ordered finite-action / MLR models

For ordered finite actions, the payoff polytope is usually a chain or fan. The Bayes cones are adjacent intervals or slabs:

B
j
	​

={p:g
j,−
	​

⋅p≤c
j,−
	​

, g
j,+
	​

⋅p≤c
j,+
	​

}.

The LP threshold becomes two inequalities per active action. In monotone likelihood-ratio models, the barycenters 
s
ˉ
j
	​

 and 
m
ˉ
j
	​

 often lie on a one-dimensional sufficient-statistic curve, so G4 collapses back toward the binary/fibered-B1 thresholds. But G4 does not require the foliation: it only needs finite facets.

Implications

The finite-facet theorem gives a computational classification:

Theorem 2 holds⟺finite LP feasible
	​


under the finite-cell/tie-free polyhedral hypotheses.

And:

Theorem 2 fails⟺some facet inequality is violated
	​


with the violated facet normal itself serving as the dual certificate.

This sits cleanly in the hierarchy already established:

G3: exact cone-Hall biconditional for a fixed optimal labeling.

G4: polyhedral finite-facet reduction of that biconditional to an LP.

WTA ternary: explicit dual certificate without baseline, explicit threshold with baseline.

Finite-action multi-state models: direct finite LP check.

Raw polyhedrality alone is not a magic wand; earlier passes already flagged that finite vertices can still fail without enough aligned baseline, with WTA as the cautionary lantern. 

prover_15_response

 G4 is the correct sharpened statement: polyhedrality gives finite computation, not automatic success.

Open

Non-polyhedral W. Smooth strictly convex W
P
 needs a density or differential version of cone-Hall. The current finite-facet proof does not apply.

Infinite-action limits. Approximate W by polytopes and track whether the LP thresholds converge. This will require uniform slack; without slack, limiting certificates can escape.

Positive-mass Borel cells. If messages are genuinely continuum-valued inside each label, the finite LP is exact only after a finite quotient or a no-escape/continuous-cone condition. Otherwise full G2c must be used.

Tie-positive rowwise minimizers. Add tie-splitting variables to the LP:

x
sj
	​

≥0,j∈R(s),

or impose tie discipline. Without one of these, per-cell inequalities are sufficient but not necessary.

Verdict: PASS. G4 is proved as the finite-facet LP threshold under the necessary finite-cell/tie-discipline hypotheses. Next step: write the implementable LP template with inputs (G
j
	​

,c
j
	​

,λ
j
	​

,
m
ˉ
j
	​

,μ
j
	​

,
s
ˉ
j
	​

), then run it on WTA, plurality, and a finite-experiment example as a table.
