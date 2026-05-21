
========
ROLE: user (id=d7cb2461-119e-4b15-abab-c529ee61d53d)
========
# Prover pass 01 — Lemma 6: Integral Clarke-Danskin representation

## Role

You are the Prover for a smart-scaffolding proof project. Your job in
this pass is to produce a **fully rigorous proof** of one lemma, sized
to be checked by a separate reviewer on a fresh chat.

The full lemma chain is in breakdown_01_response.md (durable session
artifact, also available inline below). The breakdown recommends
Lemma 6 as the first prover target. Stay focused on it.

## Setup (shared with the rest of the chain)

Standing assumptions (paper, durable source Robust_trust_Dworczak_Smolin.pdf):

- \(\Omega\) finite, \(|\Omega|=N\); full-support prior \(\mu_0\in\Delta(\Omega)\).
- \(M\subseteq\Delta(\Omega)\) Borel; \(\tau\in\Delta(M)\) is the unconditional
  law of the adviser's posterior \(s\), with \(M = \operatorname{supp}\tau\).
- \(A\) compact metric (action space); \(\Theta\) compact metric (private
  type); \(u:A\times\Omega\times\Theta\to\R\) bounded, continuous in \(a\);
  \(s,\theta\) conditionally independent given \(\omega\); \(\alpha\in[0,1]\).
- \(W := \{w\in\R^N : \exists\,\hat\sigma:\Theta\to\Delta(A)\text{ Borel},\;w(\omega)=\E_{\hat\sigma}[u(a,\omega,\theta)\mid\omega]\}\).
  By paper Lemma 2 (Theorem 1 proof, p. 27): \(W\) is **convex compact**
  in \(\R^N\), and \(W^P:=\{w\in W:\not\exists v\in W,\,v(\omega)>w(\omega)\,\forall\omega\}\)
  is its weak Pareto frontier (closed in \(W\); compact).

The finite-menu value functional is
\[
F_k(\bar w) \;:=\; \int_M\!\phi_s(\bar w)\,\tau(ds), \quad
\phi_s(\bar w) \;:=\; \alpha\max_i s\!\cdot w_i + (1-\alpha)\min_i s\!\cdot w_i,
\]
for \(\bar w=(w_1,\ldots,w_k)\in(\R^N)^k\) and \(k\ge 1\) fixed.

## Ambient lemmas (statements only; cite as needed without re-proving)

**L1 — Payoff-profile normal cone equals Bayes cone.** For \(w\in W\),
\(N_W(w)\cap\R^N_{\ge0}\cap\{\mu:\sum_\omega\mu(\omega)=1\} = B_W(w)\)
where \(B_W(w) := \{\mu\in\Delta(\Omega): w\in\arg\max_{v\in W}\mu\!\cdot v\}\).
**Proof source:** supporting hyperplane theorem + paper Lemma 2. May be assumed.

**L2 — Lipschitz & Pareto-monotone.** For each fixed \(s\in M\), the map
\(\phi_s:(\R^N)^k\to\R\) is \(\|s\|_\infty\)-Lipschitz (max+min of linear
maps in coordinates of \(\bar w\)); \(\phi_s\) is also monotone under
componentwise increase of any \(w_i\) (because \(s\in\Delta(\Omega)\) has
nonnegative coordinates). **Proof source:** elementary; may be assumed.

**L3 — Frontier-local maximality needs ambientization.** A local
maximizer of \(F_k\) over \((W^P)^k\) is also a local maximizer of
\(F_k\) over \(W^k\), under the additional Pareto-completion certificate
that no \(w_i\) can be replaced by a Pareto-dominator without leaving
the optimum. This follows from paper Lemma 2 (any improvement by
Pareto-dominator would weakly improve both terms of \(\phi_s\)). May
be assumed for this pass.

**L4 — Active faces and tie simplices are measurable.** For fixed
\(\bar w\in(\R^N)^k\), the correspondences
\(s\mapsto\arg\max_i s\!\cdot w_i\subseteq\{1,\ldots,k\}\) and
\(s\mapsto\arg\min_i s\!\cdot w_i\subseteq\{1,\ldots,k\}\) have Borel
graphs (finite-valued, defined by piecewise-linear inequalities in
\(s\)). The "tie set" \(T_+\) on which \(|\arg\max| \ge 2\) is Borel, and
similarly \(T_-\). Any active-face simplex correspondence
\(s\mapsto\Delta(\arg\max_i s\!\cdot w_i)\) (resp. \(\arg\min\)) is
Borel-measurable; measurable selections exist by Kuratowski-Ryll-Nardzewski.
May be assumed.

**L5 — Pointwise Clarke-Danskin active-weight representation.** For
fixed \(s\in M\), the Clarke subdifferential of
\(\phi_s:(\R^N)^k\to\R\) at \(\bar w\) is
\[
\partial_C\phi_s(\bar w) \;=\; \alpha\,\operatorname{co}\big\{e_i\otimes s : i\in\arg\max_j s\!\cdot w_j\big\}
\;+\; (1-\alpha)\,\operatorname{co}\big\{e_i\otimes s : i\in\arg\min_j s\!\cdot w_j\big\},
\]
where \(\operatorname{co}\) is the convex hull and \(e_i\otimes s\in(\R^N)^k\)
is zero in all components except the \(i\)-th, which equals \(s\).
Equivalently: every \(\xi\in\partial_C\phi_s(\bar w)\) admits
\(\lambda^+(s),\lambda^-(s)\in\Delta(k)\) (the \((k-1)\)-simplex) with
\(\operatorname{supp}\lambda^+(s)\subseteq\arg\max_j s\!\cdot w_j\),
\(\operatorname{supp}\lambda^-(s)\subseteq\arg\min_j s\!\cdot w_j\), and
\[
\xi_i \;=\; \alpha\,\lambda_i^+(s)\,s \;+\; (1-\alpha)\,\lambda_i^-(s)\,s.
\]
**Proof source:** Clarke (1983, Optimization and Nonsmooth Analysis,
Cor 2.8.6 chain rule for max-type functions); Danskin (1967) theorem.
May be assumed.

## The lemma to prove (Lemma 6)

**Lemma 6 — Integral Clarke-Danskin representation.**

Fix \(k\ge 1\) and \(\bar w = (w_1,\ldots,w_k)\in(\R^N)^k\). Let
\(F_k(\bar w) = \int_M\phi_s(\bar w)\,\tau(ds)\) as above. Then for every
Clarke subgradient
\[
g \;=\; (g_1,\ldots,g_k) \;\in\; \partial_C F_k(\bar w) \;\subseteq\; (\R^N)^k,
\]
there exist Borel measurable maps
\[
\lambda^+:M\to\Delta(k), \quad \lambda^-:M\to\Delta(k),
\]
such that for τ-a.e. \(s\in M\),
\[
\operatorname{supp}\lambda^+(s)\subseteq\arg\max_j s\!\cdot w_j, \quad
\operatorname{supp}\lambda^-(s)\subseteq\arg\min_j s\!\cdot w_j,
\]
and for every \(i\in\{1,\ldots,k\}\),
\[
g_i \;=\; \alpha\!\int_M\lambda_i^+(s)\,s\,\tau(ds) \;+\; (1-\alpha)\!\int_M\lambda_i^-(s)\,s\,\tau(ds).
\]

## Proof technique (sketch — your job is to make it fully rigorous)

The expected proof uses:

1. **Clarke's integral subdifferential interchange** (Clarke 1983 §2.7).
   For \(F_k(\bar w)=\int_M\phi_s(\bar w)\,\tau(ds)\) with \(\phi_s\)
   uniformly Lipschitz in \(\bar w\) (uniform constant \(\sup_{s\in M}\|s\|_\infty\le 1\)
   since \(s\in\Delta(\Omega)\)) and \(\phi_s(\bar w)\) Borel measurable
   in \(s\) for each \(\bar w\), one has the inclusion
   \[
   \partial_C F_k(\bar w) \;\subseteq\; \int_M\partial_C\phi_s(\bar w)\,\tau(ds),
   \]
   where the right-hand side is the **Aumann integral** of the set-valued
   correspondence \(s\mapsto\partial_C\phi_s(\bar w)\).
2. **Closedness of the Aumann integral** in finite dimension. Since
   \(\partial_C\phi_s(\bar w)\) is compact convex in \((\R^N)^k\) (a
   finite-dimensional space) and uniformly bounded (by Lipschitz),
   its Aumann integral is closed; the inclusion becomes an
   equality with measurable witnesses.
3. **Pointwise representation by L5.** For each \(s\), every element
   of \(\partial_C\phi_s(\bar w)\) is a convex combination of "active
   tile" vectors \(e_i\otimes s\) (the L5 statement).
4. **Measurable selection by L4 + Castaing representation.** Given
   the integral representation \(g\in\int\partial_C\phi_s\,d\tau\),
   write \(g\) as the integral of a measurable selector
   \(\xi(s)\in\partial_C\phi_s(\bar w)\) (KRN / Castaing). Then for
   each \(s\), choose Borel \(\lambda^\pm(s)\) decomposing \(\xi(s)\)
   per L5. Measurability of the decomposition follows from L4 plus
   continuous-in-\(s\) parametrization.

## What I want you to produce

Produce a **fully rigorous proof of Lemma 6**, in the following structure:


# Lemma 6 — Integral Clarke-Danskin representation

## Statement
(Restate exactly the lemma above.)

## Standing hypotheses used
(Ω finite, M Borel, τ probability measure on M, k≥1, w̄∈(R^N)^k.)

## Ambient lemmas cited
- L1 (cite as needed).
- L4 (active faces measurable; KRN selection).
- L5 (pointwise active-weight representation).

## Proof

### Step 1 — Clarke's integral subdifferential interchange
Statement of the theorem used (cite Clarke 1983 §2.7, Theorem 2.7.2 or
equivalent), with explicit verification of hypotheses:
- Borel measurability of (s, w̄) ↦ φ_s(w̄).
- Uniform local Lipschitz of w̄ ↦ φ_s(w̄), uniform constant w.r.t. s
  (use s ∈ Δ(Ω) ⇒ ‖s‖₁ = 1 ⇒ ‖s‖_∞ ≤ 1; the Lipschitz constant of
  ̄w ↦ φ_s(w̄) is ≤ ‖s‖_∞).
- τ being a finite Borel measure on M (compact metric Borel = standard
  Borel).

Conclude:
∂_C F_k(w̄) ⊆ ∫_M ∂_C φ_s(w̄) τ(ds).

### Step 2 — Closedness of the Aumann integral in finite dimension
State and verify: under uniform compactness of the integrand values
and a finite-dimensional ambient space, the Aumann integral is closed.
Cite Aumann (1965), Hildenbrand (1974), or Aubin-Frankowska (1990) §8.

In particular: ∫_M ∂_C φ_s(w̄) τ(ds) is closed (and convex), so the
inclusion in Step 1 holds with measurable witnesses g(s) ∈ ∂_C φ_s(w̄).

### Step 3 — Pointwise decomposition via L5
For each s ∈ M, decompose every ξ ∈ ∂_C φ_s(w̄) as α (e ⊗ s)(λ^+(s)) +
(1-α)(e ⊗ s)(λ^-(s)) with λ^±(s) ∈ Δ(k) supported on the active faces.

### Step 4 — Measurable selection of (λ^+, λ^-)
Given the measurable witness ξ(s) from Step 2, exhibit Borel maps
λ^±:M → Δ(k) realizing the decomposition. Use:
- L4 (active-face Borel correspondences).
- Castaing measurable selection theorem (Aliprantis-Border 18.13 / KRN).
- Standard tensor-decomposition argument: in coordinates,
  λ^+_i(s) is determined by ξ_i(s) and s up to choice within ties.
  When the active face is single-valued, λ^+_i(s) is the obvious
  Kronecker δ; on tie sets, use a measurable selection.

State the precise selection theorem invoked, and the precise
measurability of the resulting λ^±.

### Step 5 — Putting it together
Conclude g_i = α ∫_M λ_i^+(s) s τ(ds) + (1-α) ∫_M λ_i^-(s) s τ(ds) for
every i, by integrating the pointwise identity in Step 3 against τ.

## Sanity check (counterexample-resistant)
Verify the lemma on a small explicit example, e.g. k=2, N=2,
w_1 = (1,0), w_2 = (0,1), τ uniform on the relative interior of Δ({0,1}).
Compute λ^± and g_i and verify they match the integral formula.

## Open issues left for downstream lemmas
- Lemma 6 does NOT establish g_i ∈ N_W(w_i). That is Lemma 7 (Fermat).
- Lemma 6 does NOT establish posterior calibration. That is Lemma 9
  (normalization) + L10 + L11.


## Output contract

- Return everything inline in this chat as plain markdown.
- Stick to the section ordering above.
- Be rigorous about measurability — name every selection theorem you
  use and verify its hypotheses explicitly. Reviewers will check.
- The Castaing representation step is the most error-prone — handle
  the tie set explicitly. If λ^+(s) is non-unique on the tie set
  (because the active argmax has \(\ge 2\) elements), exhibit a
  measurable selection from \(\Delta(\text{active})\) and verify
  Borel measurability.
- Do not assume atomless τ. Do not assume genericity (no ties).
- Do not appeal to envelope-theorem language — this is a Clarke-Danskin
  argument, not a smooth envelope.

## Constraints

- **Banned re-proposals** (see prior_attempts_digest.md): no product-of-narrow
  Sion, no τ-AC restriction, no FOC + envelope, no canonical-pruning,
  no ε-menu-Hall as primary, no axiomatized Lean GameSetup.
- **Soft scaffolding**: do NOT prove Lemma 7 or beyond in this pass.
  Stay focused on Lemma 6. If you find a gap in L4 or L5 that you
  cannot work around, flag it and stop — the orchestrator will route
  a remediation pass.

## End-of-response signal

After the proof, write a one-paragraph **next-step signal** stating
whether you believe the proof is reviewer-ready, what the most
fragile step is, and what Lemma the next prover pass should attack.

Show more

========
ROLE: assistant (id=782bb923-1743-460e-8b0e-8dff4689e652)
========
Lemma 6 - Integral Clarke-Danskin representation
Statement

Fix k≥1 and 
w
ˉ
=(w
1
	​

,…,w
k
	​

)∈(R
N
)
k
. Let

F
k
	​

(
w
ˉ
)=∫
M
	​

ϕ
s
	​

(
w
ˉ
)τ(ds),ϕ
s
	​

(
w
ˉ
)=α
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

.

Then for every Clarke subgradient

g=(g
1
	​

,…,g
k
	​

)∈∂
C
	​

F
k
	​

(
w
ˉ
)⊆(R
N
)
k
,

there exist Borel measurable maps

λ
+
:M→Δ(k),λ
−
:M→Δ(k),

such that for τ-a.e. s∈M,

suppλ
+
(s)⊆arg
j
max
	​

s⋅w
j
	​

,suppλ
−
(s)⊆arg
j
min
	​

s⋅w
j
	​

,

and for every i∈{1,…,k},

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

(s)sτ(ds)+(1−α)∫
M
	​

λ
i
−
	​

(s)sτ(ds).
Standing hypotheses used

We use only the following facts from the shared setup:

Ω is finite with ∣Ω∣=N, so Δ(Ω)⊂R
N
 is compact. M⊆Δ(Ω) is Borel, and τ is a probability measure on M. Hence M, with its Borel σ-algebra, is a standard Borel space. The integer k≥1 is fixed, and 
w
ˉ
∈(R
N
)
k
 is fixed. No atomlessness, no generic no-tie assumption, and no finiteness of M are used.

For the Lipschitz estimates, put

E:=(R
N
)
k
,∥
x
ˉ
∥
E
	​

:=
1≤i≤k
max
	​

∥x
i
	​

∥
1
	​

.

All norms on E are equivalent, so this choice is only a bookkeeping device.

Ambient lemmas cited

L1. Payoff-profile normal cone equals Bayes cone. Not used in Lemma 6.

L2. Lipschitz and Pareto-monotone. We use the Lipschitz part.

L4. Active faces and tie simplices are Borel-measurable; measurable selections exist.

L5. Pointwise Clarke-Danskin active-weight representation.

Proof

Let

Ψ(s):=∂
C
	​

ϕ
s
	​

(
w
ˉ
)⊆E.

The proof is a little selection-theorem garden: first we get a measurable selector
ξ(s)∈Ψ(s) whose integral is g, then we measurably decompose ξ(s) into the active max/min weights from L5.

Step 1 - Clarke's integral subdifferential interchange

We use Clarke's integral subdifferentiation theorem, in the form given in Clarke, Optimization and Nonsmooth Analysis (1983), §2.7, Theorem 2.7.2 or the equivalent integral subdifferential inclusion:

Let (T,T,μ) be a finite measure space and f:T×E→R be measurable in t for each x, locally Lipschitz in x near x
0
	​

, with an integrable Lipschitz modulus L(t). If

I(x):=∫
T
	​

f(t,x)μ(dt),

then I is locally Lipschitz near x
0
	​

 and

∂
C
	​

I(x
0
	​

)⊆
∫
T
	​

∂
C
	​

f(t,x
0
	​

)μ(dt)
	​

,

where the right side is the closure of the Aumann integral of the pointwise Clarke subdifferential correspondence.

We verify the hypotheses.

First, (s,
x
ˉ
)↦ϕ
s
	​

(
x
ˉ
) is Borel, indeed continuous on M×E with the subspace topology, because it is a finite linear-max/min expression:

(s,
x
ˉ
)↦s⋅x
i
	​


is continuous for each i, and finite maxima and minima preserve continuity.

Second, ϕ
s
	​

 is globally Lipschitz in 
x
ˉ
, uniformly in s. For 
x
ˉ
,
y
ˉ
	​

∈E,

	​

i
max
	​

s⋅x
i
	​

−
i
max
	​

s⋅y
i
	​

	​

≤
i
max
	​

∣s⋅(x
i
	​

−y
i
	​

)∣≤∥s∥
∞
	​

i
max
	​

∥x
i
	​

−y
i
	​

∥
1
	​

.

The same estimate holds for the minimum. Therefore

∣ϕ
s
	​

(
x
ˉ
)−ϕ
s
	​

(
y
ˉ
	​

)∣≤(α+(1−α))∥s∥
∞
	​

∥
x
ˉ
−
y
ˉ
	​

∥
E
	​

=∥s∥
∞
	​

∥
x
ˉ
−
y
ˉ
	​

∥
E
	​

.

Since s∈Δ(Ω), ∥s∥
∞
	​

≤1. Thus the Lipschitz modulus L(s)=1 is τ-integrable.

Third, τ is finite because it is a probability measure.

Hence

∂
C
	​

F
k
	​

(
w
ˉ
)⊆
∫
M
	​

Ψ(s)τ(ds)
	​

.
(1)

Here

∫
M
	​

Ψ(s)τ(ds):={∫
M
	​

ξ(s)τ(ds):ξ measurable and integrable, ξ(s)∈Ψ(s) τ-a.e.}.
Step 2 - Closedness of the Aumann integral in finite dimension

We now remove the closure in (1).

By L5, for every s∈M, Ψ(s) is a nonempty compact convex subset of E. Moreover it is uniformly bounded. Indeed, every ξ∈Ψ(s) can be written as

ξ
i
	​

=(αλ
i
+
	​

+(1−α)λ
i
−
	​

)s

for some λ
±
∈Δ(k). The coefficients

c
i
	​

:=αλ
i
+
	​

+(1−α)λ
i
−
	​


are nonnegative and satisfy ∑
i
	​

c
i
	​

=1. Since s∈Δ(Ω), this gives a uniform bound on ξ in any fixed norm on E.

The correspondence s↦Ψ(s) is measurable. To see this explicitly, partition M into the finitely many Borel active-face cells

E
I,J
	​

:={s∈M:arg
ℓ
max
	​

s⋅w
ℓ
	​

=I, arg
ℓ
min
	​

s⋅w
ℓ
	​

=J},

where I,J⊆{1,…,k} are nonempty. L4 gives these cells as Borel sets. On E
I,J
	​

, L5 gives

Ψ(s)={η∈E:∃(λ
+
,λ
−
)∈Δ(I)×Δ(J) with η
i
	​

=(αλ
i
+
	​

+(1−α)λ
i
−
	​

)s},

where

Δ(I):={λ∈Δ(k):λ
i
	​

=0 for i∈
/
I}.

This has Borel graph because the defining constraints are Borel in s and continuous in (η,λ
+
,λ
−
), with compact parameter set Δ(I)×Δ(J).

By the standard compactness theorem for Aumann integrals in finite dimension, for example Aumann (1965), Hildenbrand (1974), or Aubin-Frankowska, Set-Valued Analysis (1990), §8, an integrably bounded measurable correspondence with nonempty compact convex values in R
d
 has a compact, hence closed, Aumann integral.

Equivalently, one can prove this directly: the set of selectors

S:={ξ∈L
1
(τ;E):ξ(s)∈Ψ(s) τ-a.e.}

is convex, norm-closed, and uniformly integrable because it is uniformly L
∞
-bounded. By the Dunford-Pettis theorem it is relatively weakly compact in L
1
, and because it is closed and convex it is weakly closed. Hence S is weakly compact. The integration operator

ξ↦∫
M
	​

ξdτ

is a continuous linear map L
1
(τ;E)→E, so its image is compact in finite-dimensional E.

Thus the Aumann integral ∫
M
	​

Ψdτ is closed and convex. From (1),

g∈∫
M
	​

Ψ(s)τ(ds).

Therefore there exists an integrable measurable selector ξ:M→E such that

ξ(s)∈Ψ(s)τ-a.e.,g=∫
M
	​

ξ(s)τ(ds).
(2)

If the selector delivered by the Aumann integral is only τ-measurable with respect to the completion, replace it by a Borel modification. Since M is standard Borel and E is finite-dimensional, every such selector has a Borel version equal to it τ-a.e. This replacement preserves (2) and preserves ξ(s)∈Ψ(s) on a full-measure set.

Fix such a Borel ξ. Let

M
0
	​

:={s∈M:ξ(s)∈Ψ(s)}.

The graph of Ψ is Borel, so M
0
	​

 is Borel, and τ(M
0
	​

)=1.

Step 3 - Pointwise decomposition via L5

For each s∈M
0
	​

, L5 applies to ξ(s)∈∂
C
	​

ϕ
s
	​

(
w
ˉ
). Hence there exist

λ
+
(s),λ
−
(s)∈Δ(k)

such that

suppλ
+
(s)⊆arg
j
max
	​

s⋅w
j
	​

,suppλ
−
(s)⊆arg
j
min
	​

s⋅w
j
	​

,

and

ξ
i
	​

(s)=αλ
i
+
	​

(s)s+(1−α)λ
i
−
	​

(s)sfor every i.
(3)

At this point the weights exist pointwise. The remaining task is to choose them Borel-measurably, including on positive-measure tie sets. This is where the little selection machine hums.

Step 4 - Measurable selection of (λ
+
,λ
−
)

For every nonempty I,J⊆{1,…,k}, recall the Borel active cell

E
I,J
	​

={s:arg
ℓ
max
	​

s⋅w
ℓ
	​

=I, arg
ℓ
min
	​

s⋅w
ℓ
	​

=J}.

The cells E
I,J
	​

 form a finite Borel partition of M.

On each cell define the compact simplexes

Δ(I):={λ∈Δ(k):λ
i
	​

=0 for i∈
/
I},Δ(J):={λ∈Δ(k):λ
i
	​

=0 for i∈
/
J}.

Choose once and for all default points d
I
	​

∈Δ(I), d
J
	​

∈Δ(J), for example unit mass on the smallest element of I and J.

For s∈E
I,J
	​

, define a correspondence

K
I,J
	​

(s)⊆Δ(I)×Δ(J)

by

K
I,J
	​

(s)={(λ
+
,λ
−
)∈Δ(I)×Δ(J):ξ
i
	​

(s)=(αλ
i
+
	​

+(1−α)λ
i
−
	​

)s for all i}

if s∈M
0
	​

, and

K
I,J
	​

(s):={(d
I
	​

,d
J
	​

)}

if s∈E
I,J
	​

∖M
0
	​

.

For s∈E
I,J
	​

∩M
0
	​

, nonemptiness follows from L5. For s∈
/
M
0
	​

, nonemptiness is built in by the default point. Each value is compact. The graph is Borel: on M
0
	​

 it is a finite intersection of zero sets of the Borel maps

(s,λ
+
,λ
−
)↦ξ
i
	​

(s)−(αλ
i
+
	​

+(1−α)λ
i
−
	​

)s,

restricted to the compact set Δ(I)×Δ(J); off M
0
	​

 it is the graph of a constant singleton.

By the Kuratowski-Ryll-Nardzewski measurable selection theorem, equivalently the Castaing measurable selection theorem for nonempty closed-valued measurable correspondences into a Polish space, each K
I,J
	​

 admits a Borel selector

s↦(λ
I,J
+
	​

(s),λ
I,J
−
	​

(s))on E
I,J
	​

.

Now paste these finitely many selectors:

(λ
+
(s),λ
−
(s)):=(λ
I,J
+
	​

(s),λ
I,J
−
	​

(s))when s∈E
I,J
	​

.

Because the partition is finite and Borel, λ
+
 and λ
−
 are Borel maps M→Δ(k).

This also handles ties explicitly. If ∣I∣≥2 or ∣J∣≥2, then E
I,J
	​

 is a tie cell. On that cell the active simplex Δ(I) or Δ(J) is genuinely multi-dimensional; the selector above chooses one admissible decomposition measurably. No atomlessness of τ is needed, so ties may carry positive mass. No division by coordinates of s is used, so zero coordinates of s cause no difficulty.

By construction,

suppλ
+
(s)⊆I=arg
j
max
	​

s⋅w
j
	​

,suppλ
−
(s)⊆J=arg
j
min
	​

s⋅w
j
	​


for every s∈E
I,J
	​

, hence for all s∈M. On the full-measure set M
0
	​

, equation (3) holds.

Step 5 - Putting it together

From (2),

g
i
	​

=∫
M
	​

ξ
i
	​

(s)τ(ds)for every i.

On M
0
	​

, which has τ-measure one,

ξ
i
	​

(s)=αλ
i
+
	​

(s)s+(1−α)λ
i
−
	​

(s)s.

The maps s↦λ
i
±
	​

(s)s are Borel and bounded, hence integrable. Therefore

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

(s)sτ(ds)+(1−α)∫
M
	​

λ
i
−
	​

(s)sτ(ds)

for every i=1,…,k. This is exactly the desired representation. □

Sanity check: a small explicit example

Take k=2, N=2,

w
1
	​

=(1,0),w
2
	​

=(0,1),

and write s=(p,1−p) with p∈(0,1). Let τ be uniform Lebesgue measure on p∈(0,1). Then

s⋅w
1
	​

=p,s⋅w
2
	​

=1−p.

Thus for p>1/2, the max index is 1 and the min index is 2; for p<1/2, the max index is 2 and the min index is 1. At p=1/2 there is a tie, but it is τ-null.

Choose

λ
+
(p)=
⎩
⎨
⎧
	​

(0,1),
(1/2,1/2),
(1,0),
	​

p<1/2,
p=1/2,
p>1/2,
	​

λ
−
(p)=
⎩
⎨
⎧
	​

(1,0),
(1/2,1/2),
(0,1),
	​

p<1/2,
p=1/2,
p>1/2.
	​


Compute

I
−
	​

:=∫
0
1/2
	​

(p,1−p)dp=(
8
1
	​

,
8
3
	​

),I
+
	​

:=∫
1/2
1
	​

(p,1−p)dp=(
8
3
	​

,
8
1
	​

).

Then the representation gives

g
1
	​

=αI
+
	​

+(1−α)I
−
	​

=(
8
1+2α
	​

,
8
3−2α
	​

),

and

g
2
	​

=αI
−
	​

+(1−α)I
+
	​

=(
8
3−2α
	​

,
8
1+2α
	​

).

Because the tie set has zero measure, F
k
	​

 is differentiable at this 
w
ˉ
, and these are the ordinary gradient components. So the lemma’s formula lands exactly where it should.

Open issues left for downstream lemmas

Lemma 6 does not establish g
i
	​

∈N
W
	​

(w
i
	​

). That is the Fermat and normal-cone step in Lemma 7.

Lemma 6 does not establish posterior calibration. That belongs to Lemma 9 together with L10 and L11.

Next-step signal

I believe this proof is reviewer-ready. The most fragile step is the measurable decomposition in Step 4, especially the conversion from an a.e. selector ξ to Borel active weights on positive-measure tie cells; the proof shields that point by using finite active-face cells and KRN selection rather than any coordinatewise formula. The next prover pass should attack Lemma 7, the Fermat step showing the integral subgradient components land in the relevant normal cones.
