
========
ROLE: user (id=980c556d-68cb-40f3-a022-137a54feb997)
========
# Prover pass 09 — F2: Endpoint-only fiber image (|Ω|≥3 / FBNF)

## Role

You are the Prover. F1 (conditional B1 + measurable pasting) is now
patched and reviewer 07 in flight. While that runs, prove **F2 — the
endpoint-only fiber image theorem** for the FBNF class.

This is the |Ω|≥3 fibered analog of L_B3 (binary endpoint-only
adversarial image). It says: under FBNF-1+2+3 primitive conditions,
the misaligned BR on each fiber is rowwise-minimizer supported on the
two fiber endpoints.

If F2 PASSes, three of four FBNF lemmas are in hand. F3 (localized
stationarity → fiberwise balance) and F4 (capstone assembly) remain.

## Setup recap — FBNF class

(See searcher_04_response.md and prover_08_response.md durable
sources for full definitions.)

- (FBNF-1) Measurable affine foliation: $\tau(ds) = \int_Z \tau_z(dt)\lambda(dz)$ with
  affine embeddings $\ell_z: [a_z, b_z] \to \Delta(\Omega)$.
- (FBNF-2) Fiber-preserving TRS: $T = \bigcup_z \ell_z([L(z), R(z)])$;
  Bregman projection stays in same fiber.
- (FBNF-3) Endpoint-only fiberwise rowwise minimization (TO PROVE
  as a CONSEQUENCE of more primitive conditions in F2 OR to STATE
  as a primitive condition on the model — adjudicate).
- (FBNF-4), (FBNF-5), (FBNF-6) as before.

## Lemma F2 — Endpoint-only fiber image

There are two reasonable readings:

**(F2-A) FBNF-3 as primitive class condition.** F2 says:
**(FBNF-3) is well-defined and consistent with FBNF-1+2** — i.e., the
condition is meaningful and not vacuous. In this reading, F2 is mostly
a measurability/regularity check.

**(F2-B) FBNF-3 as derived.** F2 PROVES (FBNF-3) from more primitive
conditions on $(u, A, W, \tau)$ — e.g., from the structure of $W^P$
and the foliation $\ell$. In this reading, F2 is a substantive theorem
showing certain primitive geometries automatically give endpoint-only
fiber image.

**Choose your reading**: my preferred reading is **(F2-B)** so the
FBNF class is genuinely primitive (not output-dependent). State the
PRIMITIVE conditions on $(u, A, W, \tau)$ that imply (FBNF-3), and
prove the implication.

## Concrete primitive condition candidates

Candidate primitive conditions on $(u, A, W, \tau, \ell)$:

### (P1) Foliation by "lines" in W^P

The agent's payoff-profile menu $C^* = w^*(T)$ admits a 1-parameter
description: $C^*$ is the image of $T$ under $w^*$, and the foliation
$\ell$ pulls back to a foliation on $C^*$. The Pareto-frontier curve
$\mu\mapsto w^*(\mu)$ restricted to a fiber $T_z = \ell_z([L(z), R(z)])$
is a 1-dim arc on $W^P$.

For (FBNF-3) to hold, the function $\mu\mapsto s\cdot w^*(\mu)$
should be **monotone or unimodal** on each fiber arc, with minimum
at one of the endpoints.

### (P2) Concavity-on-fiber

For τ_z-a.e.\ $s = \ell_z(t)$, the function $\mu\mapsto s\cdot w^*(\mu)$
is **concave** on $T_z$. Then it attains its minimum on the boundary
$\{L(z), R(z)\}$.

This is a primitive condition on $(u, A, W)$ via the structure of $W^P$.
In binary, this reduces to the monotone arc on $W^P\subseteq\R^2$.

### (P3) Supporting-line domination (analog of L_B3 binary)

For every interior $\mu\in (L(z), R(z))$ and every $s = \ell_z(t)$ with
$t\in[a_z, b_z]$,
\[
s\cdot w^*(\mu) \;\ge\; \min\{s\cdot w^*(L(z)), s\cdot w^*(R(z))\}.
\]
This is the direct supporting-line analog of L_B3 Step 2.

## What I want you to produce

A rigorous proof in the structure:


# Lemma F2 — Endpoint-only fiber image (FBNF class)

## Statement (F2-B reading)
Under FBNF-1, FBNF-2, and some chosen primitive condition (P1, P2, or
P3 above), the conclusion (FBNF-3) holds: for τ_z-a.e. t and $s = \ell_z(t)$,
the rowwise minimizer over $T_z$ is one of the two fiber endpoints.

## Choice of primitive condition

Pick the cleanest condition (likely P3 or P2). Justify the choice
economically (i.e., how restrictive is it? What models satisfy it?).

## Proof
- Step 1: structural setup (fiber arc on $W^P$).
- Step 2: convexity/concavity / supporting-line argument.
- Step 3: endpoint attainment of the min.

## Compatibility with v8 sharpness package
WTA ternary has W^P = vertex set, no 1-d foliation. Under FBNF-1+P,
the witness is excluded by hypothesis. Verify.

## Coverage examples
- Spherical model (paper §5.2, Appendix A.10): W^P is a sphere
  with rotational symmetry. Each great-circle arc is a fiber.
- MLR / single-crossing utility: μ ↦ s·w*(μ) has monotone structure.
- Binary state with extended type: |Ω|=2, |A|≥2, type Θ; fibers are
  trivially [0,1].

## Open issues
- Does the primitive condition P uniquely determine the foliation
  $\ell$? Or is $\ell$ part of the FBNF data?
- Generalization to non-affine foliations.

## End
Verdict on your own work + next-step signal (F3 next? F4 capstone?
or back to drawing board for a different primitive P?).


## Output Contract

- Inline markdown.
- Be honest about which primitive (P1, P2, P3, or a new P*) gives the
  cleanest derivation.
- Per user: keep going. If F2 fails under all primitives, propose a
  fresh route.

## Constraints

- Banned tools list applies.
- v9 T1, L_B1, binary capstone may be cited.
- FBNF foliation structure is the working hypothesis; don't try to
  generalize beyond it in this pass.

Show more

========
ROLE: assistant (id=6bed8ef4-18b6-46b4-b384-102b5905e443)
========
Lemma F2 — Endpoint-only fiber image (FBNF class)
Statement, F2-B reading

Let W⊂R
∣Ω∣
 be the compact convex payoff-profile set and let

U(μ):=
w∈W
max
	​

μ⋅w

be the indirect payoff. Assume FBNF-1 and FBNF-2: adviser beliefs are fibered by affine embeddings

ℓ
z
	​

:[a
z
	​

,b
z
	​

]→Δ(Ω),ℓ
z
	​

(t)=p
z
	​

+td
z
	​

,

and the trust region is fiberwise,

T
z
	​

=ℓ
z
	​

([L(z),R(z)]),L(z)<R(z),

with fiber-preserving projection. Let w
∗
(ℓ
z
	​

(r))∈argmax
w∈W
	​

ℓ
z
	​

(r)⋅w be the TRS payoff profile used at trusted belief ℓ
z
	​

(r).

Then for every z and every source s=ℓ
z
	​

(t),

r∈[L(z),R(z)]
min
	​

ℓ
z
	​

(t)⋅w
∗
(ℓ
z
	​

(r))=min{ℓ
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

Hence the fiber-restricted misaligned best response has an endpoint-supported selector: on each fiber, the adversary can minimize rowwise by choosing one of the two fiber endpoints. This is exactly the FBNF-3 content needed by F1 after the endpoint-fiber correction: the projected payoff image is endpoint-only, even if literal messages are later spread across endpoint fibers for calibration. F1 already records that endpoint-fiber support, rather than singleton endpoint-message support, is the correct measure-theoretic object for the patched pasting lemma. 

prover_08_response

If one wants the stronger convention

arg
r∈[L(z),R(z)]
min
	​

ℓ
z
	​

(t)⋅w
∗
(ℓ
z
	​

(r))⊆{L(z),R(z)}for τ
z
	​

-a.e. t,

then add the strict no-interior-flat primitive stated below. Without it, interior ties can occur in flat or kinked payoff geometries. That stronger set-inclusion version is not needed for F1/F4; endpoint-supported minimization is enough.

Choice of primitive condition

I do not take FBNF-3 as primitive. I also do not use P2 as stated, because global concavity of

r↦ℓ
z
	​

(t)⋅w
∗
(ℓ
z
	​

(r))

is stronger than necessary and can fail even when endpoint minimization is true. The clean primitive is:

P
⋆
 — affine-fiber support-function primitive

For each fiber z:

ℓ
z
	​

 is affine: ℓ
z
	​

(t)=p
z
	​

+td
z
	​

.

The TRS continuation on T
z
	​

 is Bayes-optimal:

w
∗
(ℓ
z
	​

(r))∈arg
w∈W
max
	​

ℓ
z
	​

(r)⋅w.

The row problem is fiber-restricted, i.e. the FBNF adversarial comparison on source ℓ
z
	​

(t) is over T
z
	​

=ℓ
z
	​

([L(z),R(z)]).

This is not a calibration or Hall condition. It is just the one-dimensional affine geometry of the fiber plus the standard payoff-profile support-function structure of W. The project’s Searcher 04 identified this “fibered binary normal fan” route precisely because it reduces multidimensional calibration to scalar fiber problems. 

searcher_04_response

For the stronger “no interior minimizers” reading, add:

P
strict
⋆
	​

 — strict fiber value

For λ-a.e. z, the scalar restricted value

V
z
	​

(r):=U(ℓ
z
	​

(r))

is strictly convex on [L(z),R(z)]. Equivalently, no supporting affine line of V
z
	​

 touches V
z
	​

 at an endpoint and at a distinct interior point. This is a primitive curvature/exposure condition on the payoff geometry W along the fiber.

Proof
Step 1 — Structural setup: restrict the support function to one affine fiber

Fix a fiber z. Suppress z in the notation and write

ℓ(t)=p+td,L=L(z),R=R(z).

Define the scalar restricted indirect payoff

V(r):=U(ℓ(r))=
w∈W
max
	​

ℓ(r)⋅w.

Since U is a support function of the compact convex payoff-profile set W, U is convex. Since ℓ is affine, V=U∘ℓ is convex on [a,b].

For each r∈[L,R], put

w
r
	​

:=w
∗
(ℓ(r))∈arg
w∈W
max
	​

ℓ(r)⋅w,

and define the scalar slope

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

 is Bayes-optimal at ℓ(r),

V(r)=ℓ(r)⋅w
r
	​

.

For every u∈[a,b],

V(u)≥ℓ(u)⋅w
r
	​

=ℓ(r)⋅w
r
	​

+(u−r)d⋅w
r
	​

=V(r)+(u−r)g
r
	​

.

Thus

g
r
	​

∈∂V(r).

So the fiber problem is literally the one-dimensional convex-supporting-line problem from the binary proof, with r as the scalar coordinate. In the earlier binary capstone, this was the load-bearing fact: every interior supporting line is dominated, for minimization, by one endpoint supporting line. 

prover_07_response

Step 2 — Supporting-line domination

Fix a source point s=ℓ(t) on the same fiber. The payoff from inducing trusted point ℓ(r) is

Φ
t
	​

(r):=ℓ(t)⋅w
r
	​

.

Using ℓ(t)=ℓ(r)+(t−r)d, we get the key identity

Φ
t
	​

(r)=V(r)+(t−r)g
r
	​

.

Now take any interior r∈(L,R). Since V is convex, subgradients are monotone:

g
L
	​

≤g
r
	​

≤g
R
	​

.

There are two cases.

If t≥r, compare r to the left endpoint L:

Φ
t
	​

(r)−Φ
t
	​

(L)
	​

=V(r)−V(L)+(t−r)g
r
	​

−(t−L)g
L
	​

=[V(r)−V(L)−g
L
	​

(r−L)]+(t−r)(g
r
	​

−g
L
	​

).
	​


The first bracket is nonnegative because g
L
	​

∈∂V(L). The second term is nonnegative because t−r≥0 and g
r
	​

−g
L
	​

≥0. Hence

Φ
t
	​

(r)≥Φ
t
	​

(L).

If t≤r, compare r to the right endpoint R:

Φ
t
	​

(r)−Φ
t
	​

(R)
	​

=V(r)−V(R)+(t−r)g
r
	​

−(t−R)g
R
	​

=[V(r)−V(R)−g
R
	​

(r−R)]+(t−r)(g
r
	​

−g
R
	​

).
	​


Again the bracket is nonnegative because g
R
	​

∈∂V(R). The second term is also nonnegative because t−r≤0 and g
r
	​

−g
R
	​

≤0. Hence

Φ
t
	​

(r)≥Φ
t
	​

(R).

Therefore for every r∈(L,R),

Φ
t
	​

(r)≥min{Φ
t
	​

(L),Φ
t
	​

(R)}.

The endpoints themselves are feasible, so

r∈[L,R]
min
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

Unpacking Φ
t
	​

, this is

r∈[L,R]
min
	​

ℓ
z
	​

(t)⋅w
∗
(ℓ
z
	​

(r))=min{ℓ
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

That proves endpoint-supported fiberwise minimization.

Step 3 — Endpoint attainment and measurable endpoint selector

Define the endpoint comparison sets

S
L
	​

(z):={t:ℓ
z
	​

(t)⋅w
∗
(ℓ
z
	​

(L(z)))≤ℓ
z
	​

(t)⋅w
∗
(ℓ
z
	​

(R(z)))},
S
R
	​

(z):={t:ℓ
z
	​

(t)⋅w
∗
(ℓ
z
	​

(R(z)))<ℓ
z
	​

(t)⋅w
∗
(ℓ
z
	​

(L(z)))}.

Under the Borel-chart version of FBNF-1 used in F1, these sets are Borel because z↦L(z),R(z), (z,t)↦ℓ
z
	​

(t), and w
∗
 are Borel on the chosen graph. The endpoint selector

e
z
	​

(t):={
L(z),
R(z),
	​

t∈S
L
	​

(z),
t∈S
R
	​

(z)
	​


is therefore Borel up to the standard tie convention. FBNF-5, the fiberwise tie discipline, removes positive conditional mass on the endpoint tie set when one wants a unique endpoint assignment.

Thus, for λ-a.e. z and τ
z
	​

-a.e. t, the adversary has a rowwise-minimizing endpoint choice. This is the FBNF-3 image theorem in the form needed for the FBNF route.

Strong version under P
strict
⋆
	​


Assume V
z
	​

 is strictly convex on [L(z),R(z)]. Then the supporting-line inequalities at the endpoints are strict for every interior r:

V(r)>V(L)+g
L
	​

(r−L),V(r)>V(R)+g
R
	​

(r−R).

Repeating the two comparisons above gives

Φ
t
	​

(r)>Φ
t
	​

(L)if t≥r,

and

Φ
t
	​

(r)>Φ
t
	​

(R)if t≤r.

Hence no interior r∈(L,R) can be a minimizer. Therefore

arg
r∈[L,R]
min
	​

Φ
t
	​

(r)⊆{L,R}.

If the endpoint tie point has τ
z
	​

-mass zero, the minimizing endpoint is unique τ
z
	​

-a.e.

Compatibility with the paper’s binary and spherical arguments

This proof is the fiberwise version of the binary endpoint argument. In the smooth binary case, differentiability gives the familiar one-line derivative:

dr
d
	​

[V(r)+(t−r)V
′
(r)]=(t−r)V
′′
(r),

so the row payoff is single-peaked in the candidate report r, with no interior minimum. The nonsmooth proof above replaces V
′′
 with subgradient monotonicity.

It also lines up with the paper’s multidimensional rich-strategy discussion: the misaligned adviser minimizes the supporting hyperplane value, equivalently maximizes Bregman distance, and Bregman geometry pushes choices to the opposite boundary of the trust region. 

Robust_trust_Dworczak_Smolin

 In the spherical example, the paper’s Lemma 9 shows the antipodal boundary point is selected and the radial coordinate is maximal; that is precisely the “affine diameter fiber” version of this F2 theorem. 

Robust_trust_Dworczak_Smolin

Compatibility with v8 sharpness package

The ternary WTA witness is not contradicted. The v8 sharpness obstruction is a genuinely two-dimensional vector-balance problem with three labels and nontrivial Bayes cones; it is the reason menu-Hall cannot be dismissed in the general ∣Ω∣≥3 menu engine. 

theorem_2_extension_proof_v8

 FBNF excludes that geometry by requiring the active comparison to decompose into one-dimensional affine fibers. F1 made the same point: FBNF avoids the multidimensional Hall dragon by reducing calibration to scalar B1 transports on fibers. 

prover_08_response

Coverage examples

Spherical / radial model. Take fibers to be affine diameters through the center b, with signed radial coordinate t. The two fiber endpoints are the two antipodal boundary points of the trust ball on that diameter. The paper’s spherical calculation already has the endpoint-only image via antipodal maximization of Bregman distance. 

Robust_trust_Dworczak_Smolin

Affine MLR / single-crossing families. If within each observable stratum z, adviser posteriors lie on an affine ordered segment between a low and high posterior,

ℓ
z
	​

(t)=(1−t)μ
z
0
	​

+tμ
z
1
	​

,

then the theorem applies fiberwise. General curved MLR families are not covered unless re-expressed by affine belief fibers; that is a real non-affine extension issue.

Binary state with extended type. When ∣Ω∣=2, there is a single nontrivial fiber Z={∗}, ℓ(t)=t, and F2 reduces exactly to the binary endpoint-only image lemma already used in the capstone.

Open issues

The primitive P
⋆
 does not determine the foliation. The foliation ℓ remains part of the FBNF data, and different economic models may supply it in different ways: radial directions, severity-index mixtures, or affine MLR strata.

The affine assumption is load-bearing. If ℓ
z
	​

 is curved, the identity

ℓ
z
	​

(t)−ℓ
z
	​

(r)=(t−r)d
z
	​


disappears, and the subgradient-monotonicity proof no longer goes through. A non-affine version would need a replacement geometry, likely a one-dimensional geodesic Bregman monotonicity condition.

Finally, F2 is fiberwise. It proves endpoint minimization over T
z
	​

, not global minimization over all fibers. The FBNF capstone must still ensure that the admissible adversarial comparison is fiber-preserving, or else add a cross-fiber exclusion condition.

Verdict: PASS for F2-B in endpoint-supported form; PATCH_SMALL if the project insists on the stronger “argmin set contains only endpoints” wording, in which case add P
strict
⋆
	​

. Next step: F3, localized stationarity ⇒ fiberwise total balance.
