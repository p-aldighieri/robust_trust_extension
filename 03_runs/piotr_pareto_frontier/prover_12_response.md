
========
ROLE: user (id=d6eea79b-35c4-42c4-b27b-206fe29846e9)
========
# Prover pass 12 — G1: Finite aligned-baseline cone-Hall theorem

## Role

You are the Prover. Searcher 05 surveyed seven attack vectors for the
unrestricted |Ω|≥3 case (beyond FBNF-7) and identified **Attack G:
Cone-valued Hall duality** as the top candidate — a genuinely new
finite Hall-type theorem with aligned baseline that the v8 Routes 1+2
did not try.

Prove the finite case (G1). If G1 PASSes, this is the gate-unlocking
theorem for unrestricted |Ω|≥3: it would let us either reopen WTA
ternary as primitively calibrable for specific $(\alpha, \tau)$, OR
exclude WTA by an explicit dual price certificate (rather than
merely by hypothesis class as FBNF-7 does).

## The theorem to prove

**Setup.** Let:
- $S = \{s_1, \ldots, s_I\}\subset\Delta(\Omega)$ — source posteriors with
  weights $\tau_i\ge 0$.
- $M_{\text{msg}} = \{m_1, \ldots, m_J\}\subset\Delta(\Omega)$ — messages,
  with aligned baseline mass $\alpha\tau_j^M\ge 0$ at message $m_j$.
- $R: \{1,\ldots,I\}\to 2^{\{1,\ldots,J\}}$ — rowwise-minimizer support
  correspondence (sources $i$ can route mass only to messages
  $j\in R(i)$).
- For each $j$, $B_j\subseteq\Delta(\Omega)$ a closed convex Bayes cone
  (the set of beliefs at which the agent's chosen action at message
  $m_j$ is Bayes-optimal).
- $\alpha\in(0,1)$.

**G1 (cone-Hall feasibility).** There exist nonneg flows $x_{ij}\ge 0$
such that:
1. **Support**: $x_{ij} = 0$ if $j\notin R(i)$.
2. **Source marginal**: $\sum_j x_{ij} = (1-\alpha)\tau_i$ for every $i$.
3. **Cone calibration**: for every $j$ with $q_j > 0$,
   \[
   \frac{n_j}{q_j}\in B_j, \quad
   n_j := \alpha\tau_j^M\,m_j + \sum_i x_{ij}\,s_i, \quad
   q_j := \alpha\tau_j^M + \sum_i x_{ij}.
   \]
**iff** the dual cone-Hall inequality holds:
\[
\forall (y_j)_{j=1}^J\subset\R^{|\Omega|},\quad
\alpha\sum_j\tau_j^M[y_j\cdot m_j - h_{B_j}(y_j)] + (1-\alpha)\sum_i\tau_i\,\min_{j\in R(i)}[y_j\cdot s_i - h_{B_j}(y_j)] \;\ge\; 0,
\]
where $h_{B_j}(y) := \sup_{\mu\in B_j}y\cdot\mu$ is the support function
of the cone $B_j$.

## Proof technique (your job to rigorize)

This is a Farkas-style theorem with cone-valued constraints. Standard
tools:

1. **Linearize the cone constraint**: $n_j/q_j\in B_j \Leftrightarrow \forall y_j, y_j\cdot n_j\le h_{B_j}(y_j)\cdot q_j$.

2. **Linear programming feasibility**: the flow problem is a finite
   LP in variables $x_{ij}\ge 0$, with linear constraints (support,
   source marginal, cone calibration written as the family of dual
   inequalities). Farkas' lemma / LP duality gives feasibility iff
   the dual certificate fails to certify infeasibility.

3. **Dual variables**: introduce dual prices $y_j\in\R^{|\Omega|}$ for
   each cone-calibration inequality. Write the LP-dual feasibility
   condition. The condition becomes the displayed cone-Hall inequality.

4. **Support functions**: $h_{B_j}(y_j)$ enters naturally as the optimal
   value of the cone-membership LP.

5. **min in dual**: the rowwise minimum $\min_{j\in R(i)}[\cdot]$ comes
   from the source-marginal constraint: for each source $i$, the dual
   constraint says the "row price" must be at least the minimum cost
   among allowed messages.

## What I want you to produce

A rigorous proof of the equivalence, structured as:


# G1 (Finite cone-Hall theorem)

## Statement (re-state precisely)

## Setup
(Define S, M, τ_i, τ_j^M, R, B_j, α.)

## Forward direction (feasibility ⇒ dual inequality)
Plug in any feasible flow {x_ij} and dual prices {y_j}; show the
dual sum is nonnegative.

## Backward direction (dual inequality ⇒ feasibility)
Use Farkas' lemma / LP duality / Fan's inequality on the appropriate
conic LP. Spell out the LP and its dual.

## Equivalent formulations
- support-function cone-Hall (as displayed).
- separation-of-flow-polytope-from-product-cone (alternative).
- finite Strassen-style coupling existence.

## WTA ternary as test case
For the v8 WTA ternary witness with τ uniform on Δ({0,1,2}), α=1/2,
$B_j = $ vertex Bayes cone, compute the dual inequality.
- If it holds: WTA is calibrable, contradicting v8 closure-memo's
  "no calibration" claim — surprise!
- If it fails: WTA is excluded by an explicit dual price certificate.

## Open issues
- Infinite-S extension: Borel S, Borel R, Borel B_j. The finite
  theorem extends via finite approximation + tightness?
- Cone-valued vs. set-valued: standard Hall handles set-valued; cone-
  valued is the new ingredient.


## Output Contract

- Inline markdown.
- Be precise about the LP and its dual. This is finite-dimensional;
  no Borel pathology.
- Test the dual on WTA ternary as the killer sanity check.
- End with verdict (PASS/PATCH/HOLD) + next-step signal:
  - If PASS + WTA dual holds → WTA reopens; pursue infinite extension.
  - If PASS + WTA dual fails → explicit dual certificate; pursue
    infinite extension and characterize the excluded class.

## Constraints

- Banned tools: see prior_attempts_digest.md.
- This is a finite theorem; use LP duality / Farkas / convex
  separation. No need for measure theory or sophisticated topology yet.
- Per user: keep going.

Show more

========
ROLE: assistant (id=ed0f8958-af2e-463f-9e0c-56fc893ebda2)
========
I’ll rebuild G1 as a finite conic LP and first audit the displayed Hall inequality’s sign, support-function orientation, and any hidden recession issue. Then I’ll use WTA ternary as the sanity check.

========
ROLE: assistant (id=fd89c707-4f3d-4b02-96b4-247114bf5e7b)
========
A sign error surfaced: under the stated support-function convention, feasibility forces the Hall expression to be ≤ 0, not ≥ 0. I’ll state the corrected theorem and give a counterexample to the displayed version.

========
ROLE: assistant (id=1557e5d4-1802-4ac9-a828-ac99d2413b61)
========
G1 — Finite aligned-baseline cone-Hall theorem

One sign patch is necessary.

With h
B
j
	​

	​

(y)=sup
μ∈B
j
	​

	​

y⋅μ, cone membership gives

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

≤0.

Therefore the Hall cut in the variables exactly as written must be ≤0, not ≥0. This is also how Searcher 05 stated the first finite cone-Hall target: the proposed finite dual has the same expression with ≤0. 

searcher_05_response

Equivalently, multiplying by −1, the valid “≥0” form is

α
j
∑
	​

τ
j
M
	​

[h
B
j
	​

	​

(y
j
	​

)−y
j
	​

⋅m
j
	​

]+(1−α)
i
∑
	​

τ
i
	​

j∈R(i)
max
	​

[h
B
j
	​

	​

(y
j
	​

)−y
j
	​

⋅s
i
	​

]≥0.

Below I prove the corrected theorem. The sign is not cosmetic; feasibility implies the corrected ≤0 inequality immediately.

Statement

Let N:=∣Ω∣. Let

S={s
1
	​

,…,s
I
	​

}⊂Δ(Ω),M
msg
	​

={m
1
	​

,…,m
J
	​

}⊂Δ(Ω),

with weights τ
i
	​

≥0, τ
j
M
	​

≥0, and α∈(0,1). Let R(i)⊆{1,…,J} be nonempty whenever τ
i
	​

>0. Let B
j
	​

⊆Δ(Ω) be nonempty closed convex sets. Since Δ(Ω) is compact, each B
j
	​

 is compact, so h
B
j
	​

	​

 is finite and continuous.

Define, for x
ij
	​

≥0,

n
j
	​

(x):=ατ
j
M
	​

m
j
	​

+
i
∑
	​

x
ij
	​

s
i
	​

,q
j
	​

(x):=ατ
j
M
	​

+
i
∑
	​

x
ij
	​

.

There exist nonnegative flows x
ij
	​

≥0 such that

x
ij
	​

=0if j∈
/
R(i),
j∈R(i)
∑
	​

x
ij
	​

=(1−α)τ
i
	​

∀i,

and

q
j
	​

(x)>0⟹
q
j
	​

(x)
n
j
	​

(x)
	​

∈B
j
	​


if and only if, for every y
1
	​

,…,y
J
	​

∈R
N
,

α
j
∑
	​

τ
j
M
	​

[y
j
	​

⋅m
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

)]+(1−α)
i
∑
	​

τ
i
	​

j∈R(i)
min
	​

[y
j
	​

⋅s
i
	​

−h
B
j
	​

	​

(y
j
	​

)]≤0.
	​

(CH)

Call this the corrected support-function cone-Hall inequality.

Setup

Let

r
i
	​

:=(1−α)τ
i
	​

,a
j
	​

:=ατ
j
M
	​

.

The row-flow polytope is

X:=
⎩
⎨
⎧
	​

x∈R
+
I×J
	​

:x
ij
	​

=0 if j∈
/
R(i), 
j∈R(i)
∑
	​

x
ij
	​

=r
i
	​

 ∀i
⎭
⎬
⎫
	​

.

Under the nonempty-row convention, X is a nonempty compact convex polytope.

For y=(y
1
	​

,…,y
J
	​

), define

c
ij
	​

(y):=y
j
	​

⋅s
i
	​

−h
B
j
	​

	​

(y
j
	​

),b
j
	​

(y):=y
j
	​

⋅m
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

),

and

Φ(x,y):=
j
∑
	​

a
j
	​

b
j
	​

(y)+
i,j
∑
	​

x
ij
	​

c
ij
	​

(y).

Because h
B
j
	​

	​

 is convex, each c
ij
	​

 and b
j
	​

 is concave in y
j
	​

. Thus Φ is affine in x, concave and continuous in y.

Observe:

Φ(x,y)=
j
∑
	​

[y
j
	​

⋅n
j
	​

(x)−h
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

(x)].
(1)
Linearizing the cone constraint

For q>0,

q
n
	​

∈B
j
	​

⟺y⋅
q
n
	​

≤h
B
j
	​

	​

(y)∀y

by the separating-hyperplane theorem for closed convex sets. Equivalently,

y⋅n−h
B
j
	​

	​

(y)q≤0∀y.

For q=0, in this model q
j
	​

=0 implies a
j
	​

=0 and x
ij
	​

=0 for all i, hence n
j
	​

=0, so the inequality is also harmless.

Therefore a flow x∈X is cone-calibrated iff

Φ(x,y)≤0∀y∈(R
N
)
J
.
(2)

That is the whole theorem in one line: find x∈X making all support-function cuts nonpositive.

Forward direction: feasibility implies cone-Hall

Assume a feasible calibrated flow x∈X exists. By cone calibration and (1),

Φ(x,y)≤0∀y.

For fixed y, the row constraints give

j∈R(i)
∑
	​

x
ij
	​

c
ij
	​

(y)≥
	​

j∈R(i)
∑
	​

x
ij
	​

	​

j∈R(i)
min
	​

c
ij
	​

(y)=r
i
	​

j∈R(i)
min
	​

c
ij
	​

(y).

Hence

α
j
∑
	​

τ
j
M
	​

b
j
	​

(y)+(1−α)
i
∑
	​

τ
i
	​

j∈R(i)
min
	​

c
ij
	​

(y)≤Φ(x,y)≤0.

This is exactly (CH).

So feasibility implies the corrected dual inequality.

Backward direction: cone-Hall implies feasibility

Assume (CH) holds for all y.

For fixed y, minimizing Φ(x,y) over the row-flow polytope X separates row by row:

x∈X
min
	​

Φ(x,y)=
j
∑
	​

a
j
	​

b
j
	​

(y)+
i
∑
	​

r
i
	​

j∈R(i)
min
	​

c
ij
	​

(y).

Thus (CH) says

x∈X
min
	​

Φ(x,y)≤0∀y,

or

y
sup
	​

x∈X
min
	​

Φ(x,y)≤0.
(3)

Apply Fan-Sion minimax to X, compact convex, and Y=(R
N
)
J
, convex. The function Φ is continuous and affine in x, and continuous concave in y. Therefore

x∈X
min
	​

y
sup
	​

Φ(x,y)=
y
sup
	​

x∈X
min
	​

Φ(x,y)≤0.

The map x↦sup
y
	​

Φ(x,y) is lower semicontinuous as a supremum of continuous affine functions, and X is compact, so the minimum is attained. Pick x
∗
∈X with

y
sup
	​

Φ(x
∗
,y)≤0.

Then

Φ(x
∗
,y)≤0∀y.
(4)

Using (1), and varying one y
j
	​

 at a time while setting the other y
ℓ
	​

=0, we get for every j,

y
j
	​

⋅n
j
	​

(x
∗
)−h
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

(x
∗
)≤0∀y
j
	​

.

By the support-function characterization,

q
j
	​

(x
∗
)>0⟹
q
j
	​

(x
∗
)
n
j
	​

(x
∗
)
	​

∈B
j
	​

.

The support and source-marginal conditions hold because x
∗
∈X. Thus a feasible calibrated flow exists.

This proves the corrected equivalence. Tiny anvil, clean strike.

Equivalent formulations
1. Support-function cone-Hall

The most direct form is (CH):

∀y,α
j
∑
	​

τ
j
M
	​

[y
j
	​

⋅m
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

)]+(1−α)
i
∑
	​

τ
i
	​

j∈R(i)
min
	​

[y
j
	​

⋅s
i
	​

−h
B
j
	​

	​

(y
j
	​

)]≤0.

The equivalent nonnegative-price form is

∀y,α
j
∑
	​

τ
j
M
	​

[h
B
j
	​

	​

(y
j
	​

)−y
j
	​

⋅m
j
	​

]+(1−α)
i
∑
	​

τ
i
	​

j∈R(i)
max
	​

[h
B
j
	​

	​

(y
j
	​

)−y
j
	​

⋅s
i
	​

]≥0.
2. Separation from the product cone

Define the closed convex cone

K
j
	​

:={(q,n)∈R
+
	​

×R
N
:n∈qB
j
	​

},

with the convention 0B
j
	​

={0}. Let

K:=
j=1
∏
J
	​

K
j
	​

.

The flow map is

A:X→
j
∏
	​

(R
+
	​

×R
N
),A(x):=(q
j
	​

(x),n
j
	​

(x))
j
	​

.

Feasibility is

A(X)∩K

=∅.

If A(X)∩K=∅, finite-dimensional separation gives a hyperplane. The polar condition for K
j
	​

 says

(λ
j
	​

,y
j
	​

)∈K
j
∘
	​

⟺λ
j
	​

+h
B
j
	​

	​

(y
j
	​

)≤0.

Taking the tight representative λ
j
	​

=−h
B
j
	​

	​

(y
j
	​

) produces exactly (CH). So the support-function inequality is simply the separating hyperplane written in Bayes-price coordinates.

3. Finite Strassen-style coupling

Let the misaligned source mass r
i
	​

=(1−α)τ
i
	​

 be coupled to messages j through allowed arcs j∈R(i). The aligned baseline contributes fixed message mass a
j
	​

=ατ
j
M
	​

 with state numerator a
j
	​

m
j
	​

. The theorem says:

A support-restricted coupling exists whose conditional barycenter at every message belongs to B
j
	​

 iff every vector-price system y
j
	​

 fails to separate the source-side rowwise transport from the message-side Bayes cones.

That is exactly Strassen’s theorem wearing a cone-shaped hat.

WTA ternary sanity check

The v8 sharpness package defines the ternary WTA cones as

K
I
−
	​

={s∈Δ(Ω):s
i
	​

≤s
k
	​

 ∀i∈I,∀k},

and

B
I
	​

={p∈Δ(Ω):p
i
	​

≥p
k
	​

 ∀i∈I,∀k}.

It also proves the cone-intersection lemma: a probability supported on K
I
−
	​

 with barycenter in B
I
	​

 must be δ
μ
0
	​

	​

, where μ
0
	​

=(1/3,1/3,1/3). 

theorem_2_extension_proof_v8

 The no-free-dust theorem then says null-message dust cannot repair that obstruction. 

theorem_2_extension_proof_v8

Now compute the G1 dual certificate in the natural full-vertex WTA menu.

Let Ω={0,1,2}. For each vertex label j, let

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

The rowwise minimizer region for label j is

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

For the uniform distribution on the simplex and tie sets ignored, each K
j
−
	​

 has probability 1/3.

Take the dual price

y
j
	​

=1−2e
j
	​

,

i.e. y
j
	​

 has coordinate −1 at j and +1 at the two other states.

For μ∈B
j
	​

,

y
j
	​

⋅μ=1−2μ
j
	​

.

Since μ
j
	​

≥1/3 on B
j
	​

, the maximum is attained at μ
0
	​

, so

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

.

For s∈K
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

Under the uniform distribution on Δ
2
,

E[s
j
	​

∣s∈K
j
−
	​

]=E[min(s
0
	​

,s
1
	​

,s
2
	​

)]=
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

)dτ(s)=
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

)]dτ(s)=
9
4
	​

.

For the dust-label/full-vertex WTA test with no aligned atom at the three vertex labels, τ
j
M
	​

=0. With α=1/2,

Ψ(y)=(1−α)
9
4
	​

=
9
2
	​

>0.

But the corrected cone-Hall theorem requires Ψ(y)≤0. Thus the WTA full-vertex dust-label instance fails G1 by an explicit dual price certificate.

If one adds positive aligned baseline masses at finitely many WTA messages, the same certificate becomes

Ψ(y)=α
j
∑
	​

τ
j
M
	​

[(1−2(m
j
	​

)
j
	​

)−
3
1
	​

]+(1−α)
9
4
	​

.

That expression gives a concrete threshold test: sufficiently strong aligned baseline inside the right Bayes cones may offset the misaligned minimizer mass, while weak or zero baseline fails. This is exactly the “reopen WTA or exclude by certificate” fork Searcher 05 wanted. 

searcher_05_response

Open issues after G1

The finite theorem is done after the sign patch. The Borel extension is still the dragon cave. The closure memo’s open object remains a deletion-compatible Hall duality theorem with simultaneous sourcewise deletion certificates and messagewise calibration constraints, and it explicitly names the Borel-to-compact, label-fiber lift, and slack-discipline hazards. 

project_closure_memo

The next target should be:

G2: standard-Borel cone-Hall extension. Start with simple functions and finite partitions, apply G1 on each finite quotient, then prove tightness/disintegration of the limiting calibrated flow without reintroducing the failed compact-patch arguments.

Verdict: PATCH_SMALL → PASS. The theorem is correct and proved with the inequality sign flipped to ≤0, or equivalently with the negative “≥0” form. WTA ternary, in the natural no-baseline full-vertex test, is excluded by an explicit dual certificate; with positive aligned baseline, G1 gives the exact threshold inequality to test.
