
========
ROLE: user (id=b529f1ad-711c-42a5-b79e-2eb8c5f439b2)
========
# Prover pass 13 — G2: Standard-Borel cone-Hall extension

## Role

You are the Prover. G1 (finite cone-Hall) is proved (Prover 12,
Reviewer 11 in flight). Extend it to standard-Borel S, M, B_j —
the version actually applicable to the Robust Trust setting where
M ⊆ Δ(Ω) is Borel and τ has continuous components.

## The G2 theorem to prove

**Setup.** Let:
- $(S, \mathcal{B}_S)$ standard Borel; $\tau \in \Delta(S)$ probability.
- $(M, \mathcal{B}_M)$ standard Borel; aligned baseline measure
  $\mu_M$ on $M$ with $\mu_M(M) \le 1$, $\alpha\mu_M$ representing the
  truthful-aligned message marginal.
- Borel rowwise-minimizer correspondence $R: S \twoheadrightarrow M$
  (graph is Borel; values nonempty closed).
- Borel Bayes-cone correspondence $m \mapsto B(m) \subseteq \Delta(\Omega)$
  (values closed convex; graph Borel; $h_{B(m)}(y) = \sup_{\mu\in B(m)} y\cdot \mu$
  Borel in $m$ for each $y$).
- $\alpha\in(0,1)$.

**G2 (Borel cone-Hall feasibility).** There exists a Borel kernel
$\kappa: S \to \Delta(M)$ with $\kappa(R(s) | s) = 1$ τ-a.e. such that
the joint measure
\[
\gamma_\alpha := \alpha(\mathrm{id}, \mathrm{id})_\# \mu_M + (1-\alpha)\tau\otimes\kappa
\]
has disintegration posterior $P_{\gamma_\alpha}(\cdot | m) \in B(m)$
for $q := (\gamma_\alpha)_2$-a.e. $m$

**iff** for every Borel bounded function $y: M \to \R^{|\Omega|}$,
\[
\Psi(y) := \alpha\!\int_M[y(m)\cdot m - h_{B(m)}(y(m))]\,\mu_M(dm) + (1-\alpha)\!\int_S\inf_{m\in R(s)}[y(m)\cdot s - h_{B(m)}(y(m))]\,\tau(ds) \le 0.
\]

## Proof strategy

### Step 1 — Borel-measurable LP setup

The G2 problem is an infinite-dimensional LP on Borel kernels. Standard
tools:
- $\kappa$ lives in the Borel kernel space $K(S, M)$ = Borel maps
  $S \to \Delta(M)$, with the narrow topology (compact under tightness).
- The Borel correspondence $R$ defines a closed subset; selection theorems
  give Borel-measurable feasibility.
- The cone-calibration condition is a closed linear constraint in the
  joint-measure topology.

### Step 2 — Sion / Minkowski for Borel LP duality

Apply minimax theorem on the Borel kernel space. Strong duality:
feasibility iff the dual problem has nonpositive value.

**Key tool**: Borel kernel disintegration + measurable LP duality on
standard Borel spaces. References:
- Bertsekas-Shreve (1978) §7 (LP duality on Borel-measurable functions).
- Anderson-Nash (1987) on infinite LP.
- Beiglböck-Léonard-Schachermayer (2012, 2013) — Strassen-style duality
  on Polish spaces.

### Step 3 — Tightness + compactness

The Borel kernel space K(S, M) is sequentially narrow-compact when M
is compact (Polish). Apply the prokhorov tightness + measurable
selection to extract a limiting calibrated kernel from any approximating
sequence.

### Step 4 — Reduction to G1 via finite partitions

For each ε > 0, choose finite partitions $S_\eps$ of S and $M_\eps$
of M such that:
- $\tau|_{S_\eps}$ approximates $\tau$ in narrow topology.
- $\mu_M|_{M_\eps}$ approximates $\mu_M$.
- $R$ restricts to a Borel correspondence $S_\eps \to M_\eps$.
- $B$ restricts to a Borel cone-valued correspondence on $M_\eps$.

Apply G1 to each finite partition. As ε → 0, the family of finite-cone-Hall
inequalities → the Borel cone-Hall inequality (Step 2's duality).

**Critical**: the closure memo's "Borel→compact" gap (Route 2 O1) — avoid
this by going Borel→Borel via Polish-space approximation, not via
compact-patch deletion.

## Caveats from v8 closure memo

The deletion-compatible Hall duality named by the closure memo as the
single open object faces three obstacles:
- (O1) Borel→compact non-monotonicity for compact-patch deletion.
- (O2) Cell-flow lift gap (fiber thickness).
- (O3) Slack discipline in curved W.

The cone-Hall route is structurally different:
- No compact-patch deletion (the dual variable is a bounded Borel
  function on M, not a compact patch).
- No cell-flow lift (we directly use the Borel kernel space, not LP
  on cells).
- Slack discipline replaced by ≤ 0 inequality on Ψ(y).

So G2 should avoid the v8 obstacles. **Verify this claim** in your proof.

## What I want

Rigorous proof of G2 (Borel cone-Hall), in the structure:


# Theorem G2 (Standard-Borel cone-Hall)

## Setup (S, M, R, B, τ, μ_M, α — Borel structure)

## Proof
### Step 1 — Borel LP framework
### Step 2 — LP duality (cite Bertsekas-Shreve or Beiglböck)
### Step 3 — Tightness/compactness on K(S, M)
### Step 4 — Reduction to G1 via finite partition limits

## Critical: Verify the v8 obstacles (O1, O2, O3) are avoided
- O1 Borel→compact: avoided because dual variable is Borel function, not
  compact patch.
- O2 cell-flow lift: avoided because direct Borel kernel.
- O3 slack discipline: avoided by ≤ 0 inequality on continuous Ψ.

## WTA test (revisit)
The WTA dual certificate from G1 (Ψ(y) = 2/9 > 0 with uniform τ on
Δ({0,1,2}), α=1/2) extends to the Borel τ uniform setting. So WTA
remains excluded by explicit dual certificate in G2.

## Open issues
- Reopening WTA: under what aligned-baseline structure (τ_j^M, m_j) does
  Ψ(y) ≤ 0 hold? This is the primitive condition for WTA to be
  calibrable.
- Application to Robust Trust: how to make Borel R, B from primitives.


## Output Contract

- Inline markdown.
- Be honest about whether G2 closes UNCONDITIONALLY in standard-Borel
  setting, or requires additional regularity.
- Verify the v8 obstacles are not snuck in.
- End with verdict + next-step.

## Constraints

- Banned tools list applies.
- The genuinely novel ingredient is **cone-valued dual variables on
  Borel functions**. If the proof reverts to compact-patch deletion, it's
  not new.
- Per user: relentless. Don't stop. If G2 fails at some step, identify
  the missing ingredient and propose a fix.

Show more

========
ROLE: assistant (id=b9ac8cd6-76b4-4138-b82e-336b38918e0d)
========
I’ll audit G2 from the measurable-LP foundation upward: fix the finite-dual sign convention, test standard-Borel duality/compactness assumptions, and identify exactly what closes versus what needs extra regularity.

========
ROLE: assistant (id=529d70af-7135-42bc-91e1-4fd0cf6cb1b8)
========
The main correction is to avoid Sion or finite-partition limits as stated; the viable path is countably additive conic LP duality, after making the belief-simplex embedding explicit.

========
ROLE: assistant (id=7c7bd9cb-ed28-4c6a-a55f-50bcce00e9ea)
========
Theorem G2 — Standard-Borel cone-Hall
Verdict first

G2 does not close unconditionally in the bare standard-Borel form stated.
There is a small escape-to-missing-boundary counterexample where the dual inequality Ψ(y)≤0 holds for every bounded Borel y, but no Borel kernel can satisfy posterior calibration.

The theorem does close after adding a no-escape regularity package, for example: M compact metric, S Polish with τ tight, GrR closed with nonempty compact sections, and m↦h
B(m)
	​

(a) continuous for every a∈R
∣Ω∣
. This is enough for the conic separation proof below. The earlier project record also identifies this exact unrestricted object as the remaining Hall/duality bottleneck, with Borel-to-compact, label-fiber lift, and slack issues as the named hazards. 

project_closure_memo

So the honest result is:

Bare standard-Borel G2: false.

Compact-closed/continuous G2: true by direct conic separation.

Full Borel G2 without no-escape regularity: requires an additional Borel conic-LP no-gap theorem.

0. Why bare standard-Borel G2 is false

Take Ω={0,1}, identify beliefs with p=Pr(ω=1), and write the belief vector as (1−p,p).

Let

S={0},τ=δ
0
	​

,M=(0,1],
μ
M
	​

=0,R(0)=M,B(m)={m}.

Here M is standard Borel; R(0)=M is nonempty and closed in the relative topology of M; B(m) is closed convex; h
B(m)
	​

(y)=y⋅m is Borel.

For a bounded Borel y:M→R
2
, write

d(m):=y
1
	​

(m)−y
0
	​

(m).

Then

y(m)⋅(1,0)−h
B(m)
	​

(y(m))=y
0
	​

(m)−((1−m)y
0
	​

(m)+my
1
	​

(m))=−md(m).

Since d is bounded and m↓0 is available inside M=(0,1],

m∈M
inf
	​

[−md(m)]≤0.

Thus

Ψ(y)=(1−α)
m∈M
inf
	​

[−md(m)]≤0

for every bounded Borel y.

But no feasible kernel exists. For any kernel κ on M, the source posterior is always s=(1,0). Hence the disintegration posterior at every q-positive message is (1,0). Calibration requires

(1,0)∈B(m)={m}

for q-a.e. m, which would force m=0, but 0∈
/
M. Impossible.

Diagnosis. The dual sees the missing boundary point 0 only as an infimum; the primal cannot route mass there. This is a genuine no-attainment/no-escape defect. It is not a compact-patch deletion issue; it is more basic.

Corrected theorem G2c — Compact-closed cone-Hall
Setup

Let Ω be finite and identify Δ(Ω)⊂R
N
.

Assume:

S is Polish and τ∈Δ(S).

M⊂Δ(Ω) is compact metric.

s↦s∈Δ(Ω) and m↦m∈Δ(Ω) are continuous coordinate maps.

R:S↠M has nonempty compact values and closed graph.

B(m)⊆Δ(Ω) is nonempty closed convex, and for every a∈R
N
, the map

m↦h
B(m)
	​

(a):=
μ∈B(m)
sup
	​

a⋅μ

is continuous.

μ
M
	​

 is a finite Borel measure on M, μ
M
	​

(M)≤1, and α∈(0,1).

Then the following are equivalent.

Primal feasibility. There exists a Borel kernel κ:S→Δ(M) with

κ(R(s)∣s)=1τ-a.e.

such that, for

γ
α
	​

=α(id,id)
#
	​

μ
M
	​

+(1−α)τ⊗κ,q=(γ
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

(⋅∣m)∈B(m)q-a.e.

Cone-Hall dual inequality. For every bounded Borel y:M→R
N
,

Ψ(y):=α∫
M
	​

[y(m)⋅m−h
B(m)
	​

(y(m))]μ
M
	​

(dm)+(1−α)∫
S
	​

m∈R(s)
inf
	​

[y(m)⋅s−h
B(m)
	​

(y(m))]τ(ds)≤0.

The sign is the corrected G1 sign: feasibility gives ≤0, not ≥0. The finite pass already caught that sign: cone membership gives y⋅n−h
B
	​

(y)q≤0. 

prover_12_response

Proof
Step 1 — Borel/conic LP framework

Let Π
R
	​

 be the set of finite measures π on S×M such that

π
1
	​

=τ,π(GrR)=1.

Equivalently, every π∈Π
R
	​

 disintegrates as

π(ds,dm)=τ(ds)κ(dm∣s)

for a Borel kernel κ supported on R(s) τ-a.e. Existence of at least one such kernel follows from the Kuratowski–Ryll-Nardzewski measurable selection theorem, since R has nonempty compact values and measurable closed graph.

Because M is compact and τ is fixed, Π
R
	​

 is tight. Since GrR is closed, Π
R
	​

 is weakly closed. Hence Π
R
	​

 is compact convex.

For π∈Π
R
	​

, define the scalar message measure and vector numerator measure

q
π
	​

=αμ
M
	​

+(1−α)π
2
	​

,
n
π
	​

(E)=α∫
E
	​

mμ
M
	​

(dm)+(1−α)∫
S×E
	​

sπ(ds,dm).

The posterior is

P
π
	​

(⋅∣m)=
dq
π
	​

dn
π
	​

	​

(m)

where the Radon–Nikodym derivative is defined q
π
	​

-a.e.

Define the calibration cone

C={(q,n):n≪q,dn/dq(m)∈B(m) q-a.e.}.

This is convex. It is weakly closed under the compact-continuous assumptions. A quick verification: (q,n)∈C iff for every rational a∈Q
N
 and every nonnegative continuous φ∈C(M),

∫
M
	​

φ(m)(a⋅dn(m)−h
B(m)
	​

(a)dq(m))≤0.

Continuity of m↦h
B(m)
	​

(a) passes the inequality to weak limits; countable separation by a∈Q
N
 recovers dn/dq(m)∈B(m) a.e.

Thus the primal problem is

∃π∈Π
R
	​

such that(q
π
	​

,n
π
	​

)∈C.
Step 2 — Necessity

Assume κ is feasible and let π=τ⊗κ. For any bounded Borel y:M→R
N
, calibration gives

y(m)⋅P
γ
α
	​

	​

(⋅∣m)≤h
B(m)
	​

(y(m))q-a.e.

Multiplying by q and integrating,

α∫
M
	​

[y(m)⋅m−h
B(m)
	​

(y(m))]μ
M
	​

(dm)
+(1−α)∫
S
	​

∫
M
	​

[y(m)⋅s−h
B(m)
	​

(y(m))]κ(dm∣s)τ(ds)≤0.

Since κ is supported on R(s),

∫
M
	​

[y(m)⋅s−h
B(m)
	​

(y(m))]κ(dm∣s)≥
m∈R(s)
inf
	​

[y(m)⋅s−h
B(m)
	​

(y(m))].

Therefore

Ψ(y)≤0.

This is the easy direction: calibrated kernels price every Bayes-cone inequality nonpositively.

Step 3 — Sufficiency by conic separation

Assume Ψ(y)≤0 for every bounded Borel y. It is enough to use bounded continuous y, since those are included.

Suppose, toward contradiction, that no feasible π∈Π
R
	​

 exists. Then the compact convex set

K:={(q
π
	​

,n
π
	​

):π∈Π
R
	​

}

is disjoint from the closed convex cone C.

By strict separation of a compact convex set from a closed convex set in a locally convex space, there exist continuous functions

φ∈C(M),y∈C(M;R
N
)

and ε>0 such that

∫φdq
π
	​

+∫y⋅dn
π
	​

≥ε∀π∈Π
R
	​

,

while

∫φdq+∫y⋅dn≤0∀(q,n)∈C.

Because C contains every atomic calibrated pair

(q,n)=(δ
m
	​

,μδ
m
	​

),μ∈B(m),

the polar condition implies

φ(m)+y(m)⋅μ≤0∀m, ∀μ∈B(m).

Thus

φ(m)≤−h
B(m)
	​

(y(m)).

Replacing φ by the larger function −h
B(m)
	​

(y(m)) can only increase the left side on K. Hence

α∫
M
	​

[y(m)⋅m−h
B(m)
	​

(y(m))]μ
M
	​

(dm)
+(1−α)∫
S×M
	​

[y(m)⋅s−h
B(m)
	​

(y(m))]π(ds,dm)≥ε

for every π∈Π
R
	​

.

Now minimize over π∈Π
R
	​

. Since

f
y
	​

(s,m):=y(m)⋅s−h
B(m)
	​

(y(m))

is continuous and R(s) is compact-valued with closed graph, the measurable maximum/minimum theorem gives

π∈Π
R
	​

inf
	​

∫f
y
	​

dπ=∫
S
	​

m∈R(s)
min
	​

f
y
	​

(s,m)τ(ds).

Therefore

Ψ(y)≥ε>0,

contradicting the assumed cone-Hall inequality. Hence a feasible π exists.

Finally, disintegrate π(ds,dm)=τ(ds)κ(dm∣s). Since π(GrR)=1,

κ(R(s)∣s)=1τ-a.e.

and (q
π
	​

,n
π
	​

)∈C gives

P
γ
α
	​

	​

(⋅∣m)∈B(m)q-a.e.

This proves G2c.

Step 4 — Why the finite-partition route is dangerous

Finite G1 is clean: it is a finite conic Farkas theorem with aligned baseline, and its dual is exactly the support-function cone-Hall inequality. The finite pass explicitly framed the Borel extension as “simple functions and finite partitions, then tightness/disintegration,” but also flagged that this Borel step is still the dragon cave. 

prover_12_response

The counterexample above shows why. Finite partitions can chase a limiting missing boundary point. The dual infimum sees the boundary; a countably additive kernel on M cannot use it. Without compact closed support or an equivalent no-escape condition, partition limits can converge outside the admissible message space.

So the finite-partition strategy is valid only after adding enough regularity to guarantee:

finite quotient feasible limits stay inside M

and

cell flows lift to actual Borel kernels supported on R.
Verification of the v8 obstacles
O1 — Borel → compact non-monotonicity

Avoided in G2c. The proof never uses compact-patch deletion. It uses a global conic separation between K=T(Π
R
	​

) and C. The separating price y is a global message-price function, not a compact deletion patch.

Not avoided in bare standard-Borel. The counterexample is precisely a no-attainment escape: the infimum sits at a missing boundary point.

O2 — Cell-flow lift gap

Avoided in G2c. The primal variable is already a measure π on GrR. Once π exists, standard disintegration gives the Borel kernel κ. No cell-flow object has to be lifted.

This differs from the older finite-cell route, where cell flows averaged over source cells and then had to be lifted back to pointwise Borel kernels, one of the named closure obstructions. 

project_closure_memo

O3 — Slack discipline in curved W

Avoided in G2c. There is no ε-net and no n(ε)ρ
ε
	​

 bookkeeping. If feasibility fails, separation produces one exact continuous price y with Ψ(y)>0.

WTA test

The WTA ternary certificate survives the Borel formulation. In the full-vertex WTA test, the Bayes cone for label j is

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

and the rowwise minimizer region is

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

The finite G1 pass uses a price y
j
	​

=1−2e
j
	​

, computes h
B
j
	​

	​

(y
j
	​

)=1/3, and obtains a strictly positive Ψ(y) in the no-baseline full-vertex WTA instance; the sign is what matters, and the corrected cone-Hall theorem requires Ψ(y)≤0. 

prover_12_response

With the normalization in your prompt, the same certificate gives

Ψ(y)=
9
2
	​

>0.

So WTA remains excluded by an explicit cone-Hall dual certificate in G2. If positive aligned baseline mass is added at the right messages, the certificate becomes a threshold test rather than an automatic exclusion; that is exactly the “reopen or exclude by certificate” fork identified after G1. 

searcher_05_response

What remains open

The exact open object is now sharp:

Prove a Borel conic Hall theorem that preserves countable additivity and support without compact closed no-escape assumptions, or state the minimal no-escape condition that makes the finite G1 limit valid.

The closure memo’s older formulation called this the deletion-compatible Hall duality theorem: existence of a Borel kernel supported on rowwise minimizers with Bayes-cone posterior calibration q-a.e., while simultaneously handling sourcewise dual certificates and messagewise calibration. 

project_closure_memo

The compact-closed proof above gives the clean version. The bare standard-Borel version fails.

Final verdict

PATCH_BIG / HOLD for the theorem exactly as stated.
PASS for the compact-closed/continuous G2c theorem.

Next step: formulate the minimal “no boundary escape” hypothesis that strictly contains compact M. The counterexample shows the necessary shape: every dual infimum that can be approached along R(s) must either be attainable inside M or be detected by an admissible Borel price with Ψ(y)>0.
