
========
ROLE: user (id=dc115b73-fc7b-44c7-a99c-a5bf4a1c571f)
========
# Prover pass 11 — F4 FBNF capstone assembly

## Role

You are the Prover. Assemble F1+F2+F3 into the **FBNF capstone theorem**
for |Ω|≥3, with FBNF-7 (global fiber dominance) added as a primitive
class condition per Reviewer 08's recommendation.

## The FBNF class (final form)

Primitive class conditions on $(u, A, \Omega, \Theta, \tau, \ell)$:

- **(FBNF-1) Measurable affine foliation.** Standard Borel base $Z$,
  Borel disintegration $\tau(ds) = \int_Z \tau_z(dt)\lambda(dz)$, affine
  embeddings $\ell_z:[a_z, b_z]\to\Delta(\Omega)$ jointly Borel,
  covering $M$ τ-a.e.
- **(FBNF-2) Fiber-preserving TRS.** The optimal trust region admits
  the form $T = \bigcup_z \ell_z([L(z), R(z)])$; Bregman projection
  preserves fibers.
- **(FBNF-3) Endpoint-only fiber image** (proven as F2 from primitive
  condition P, e.g., concavity-on-fiber or supporting-line domination):
  rowwise minimization over $T_z$ supported on $\{\ell_z(L(z)), \ell_z(R(z))\}$.
- **(FBNF-4) Fiberwise endpoint exposure**: $B_W(w_{z,L})\cap\ell_z([a_z, b_z]) = \{\ell_z(L(z))\}$,
  symmetric for $R(z)$.
- **(FBNF-5) Fiberwise tie discipline**: $\tau_z$ no atom at the fiber
  tie point.
- **(FBNF-6) Local endpoint stationarity** — **DERIVED** from optimality
  + (FBNF-1..5) + two-sided localized perturbations (F3).
- **(FBNF-7) Global fiber dominance.** For τ-a.e. $s\in M$ in fiber $z$,
  $\min_{\mu\in T}s\cdot w^*(\mu) = \min_{\mu\in T_z}s\cdot w^*(\mu)$.
  I.e., cross-fiber messages cannot dominate the in-fiber endpoint
  minimum. Spherical (radial fibers through center) and affine-MLR
  satisfy this; WTA ternary fails it.

## Capstone theorem (F4)

**Theorem (FBNF infinite-extension of Theorem 2).** Under standing
hypotheses, $|\Omega|\ge 3$, $\alpha\in(0,1)$, and primitive FBNF-1
through FBNF-5 and FBNF-7, there exists a robustly rationalizable
optimal strategy for arbitrary measurable $M$ and $\Theta$.

Specifically, define the FBNF-induced adversarial kernel
$\hat\beta^*:M\to\Delta(M)$ by pasting fiberwise B1 kernels
$\kappa_{L,z}, \kappa_{R,z}$ from F1, with truthful interior
reporting in the aligned channel. Then for $q$-a.e. $m\in M$, the
TRS continuation $\hat\sigma^*(m) = R(w^*(\Pi_T(m)))$ is Bayes-optimal
under $P_{\hat\beta^*}(\cdot\mid m)$.

## Proof structure

1. **Step 1** — TRS exists by paper Theorem 1; (FBNF-2) gives its
   fibered form.
2. **Step 2** — FBNF-3 (F2) gives within-fiber endpoint-only image.
   FBNF-7 lifts this to GLOBAL endpoint-only image: the adversary's
   true best response sends mass only to fiber endpoints
   $\bigcup_z\{\ell_z(L(z)), \ell_z(R(z))\}$.
3. **Step 3** — FBNF-6 (F3) gives fiberwise total balance from
   optimality.
4. **Step 4** — F1 (conditional B1 + measurable pasting) constructs
   the global adversarial kernel from fiberwise B1 kernels.
5. **Step 5** — FBNF-4 (fiberwise endpoint exposure) gives
   Bayes-optimality of TRS continuation at endpoint-fiber messages.
   Interior messages are aligned-truthful with posterior = m.
6. **Step 6** — Definition 2 holds $q$-a.e.

## What to produce

Full rigorous proof in this structure:


# Theorem (FBNF infinite-extension of Theorem 2)

## Statement
## Hypotheses (FBNF-1..5, FBNF-7; standing; |Ω|≥3; α∈(0,1))

## Proof (Steps 1-6)

## Economic interpretation of primitives
- FBNF-1: signal posteriors live on a 1-d family.
- FBNF-2: trust region respects the foliation.
- FBNF-3 (via P): fiber arcs are well-shaped (concavity / single-cross).
- FBNF-4: unique Bayes belief at each fiber endpoint label.
- FBNF-5: τ_z no atom at tie point.
- FBNF-7: cross-fiber messages don't beat in-fiber endpoints.

## Coverage examples
- Spherical models (paper §5.2, App A.10): fibers = radial diameters
  through center.
- Affine MLR / single-crossing: posteriors lie on an affine 1-d arc.
- Polyhedral W with scalarizable faces: each Bayes face is a 1-d arc.

## Comparison with v8 menu-Hall + binary capstone
- v8 Tier 2 = menu-Hall postulated as calibration.
- v9 binary = (R-EE)+(R-TD)+(R-IES) primitive, calibration derived.
- v9 FBNF |Ω|≥3 = FBNF-1..5+FBNF-7 primitive, calibration derived.

## Sharpness compatibility
WTA ternary fails FBNF-7 (cross-vertex dominance). The witness is
correctly excluded by the FBNF class.

## Open
- Non-affine foliations.
- General curved MLR.
- Polyhedral W without scalarizable faces.


## Output Contract

- Inline markdown.
- Use F1, F2, F3 verbatim as proven.
- End with verdict + next-step signal.

## Constraints

- Banned tools list applies.
- Per user: do not stop. If F4 fails, identify the missing ingredient.

Show more

========
ROLE: assistant (id=ff297261-39b6-48b5-b2d1-3802f3b50392)
========
Theorem (FBNF infinite-extension of Theorem 2)
Statement

Let the standing hypotheses of Robust Trust hold: Ω is finite with full-support prior, A and Θ are compact metric, u(a,ω,θ) is bounded and continuous in a, s and θ are conditionally independent given ω, and all infinite spaces use their Borel structures. The paper’s Definition 2 asks for an adversarial β
∗
 such that the agent’s continuation is Bayes-optimal after on-path messages; its existence theorem is finite-M, finite-Θ in the original paper. 

objective_statement

Assume ∣Ω∣≥3, α∈(0,1), and the FBNF class conditions below.

There exists a robustly rationalizable optimal strategy for arbitrary measurable M and compact metric Θ. More precisely, for an optimal fibered trust region

T=
z∈Z
⋃
	​

ℓ
z
	​

([L(z),R(z)]),

define the TRS continuation

σ
^
∗
(m)=R(w
∗
(Π
T
	​

(m))),

where R is a Borel payoff-profile realization selector and w
∗
(μ)∈argmax
w∈W
	​

μ⋅w.

Then there is a Borel adversarial kernel 
β
^
	​

∗
:M→Δ(M), obtained by pasting the fiberwise B1 kernels κ
L,z
	​

,κ
R,z
	​

, such that for

γ
α
	​

=α(id,id)
#
	​

τ+(1−α)τ⊗
β
^
	​

∗
,q=(γ
α
	​

)
2
	​

,

we have

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
β
^
	​

∗
	​

(⋅∣m))for q-a.e. m∈M.

Since 
β
^
	​

∗
 is adversarial against 
σ
^
∗
, this is Definition 2 in the natural infinite-space q-a.e. reading.

One bookkeeping convention is essential: by the corrected F1 lemma, the adversary’s literal message support is generally in the endpoint fibers

ℓ
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

not only at the singleton messages ℓ
z
	​

(L(z)),ℓ
z
	​

(R(z)). Its projected payoff image is endpoint-only:

Π
T
	​

(supp
β
^
	​

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

This is the exact patch F1 needed, because scalar B1 calibration spreads mass over endpoint fibers, not just over singleton endpoints. 

prover_08_response

Hypotheses

We use the following FBNF hypotheses.

(FBNF-1) Measurable affine foliation. There is a standard Borel base Z, a Borel field of intervals [a
z
	​

,b
z
	​

], kernels τ
z
	​

, and jointly Borel affine embeddings

ℓ
z
	​

:[a
z
	​

,b
z
	​

]→Δ(Ω),

with

τ=Φ
#
	​

τ
ˉ
,Φ(z,t)=ℓ
z
	​

(t),
τ
ˉ
(dz,dt)=λ(dz)τ
z
	​

(dt).

As in F1, the foliation is read as a 
τ
ˉ
-a.e. Borel chart, or equivalently with quotient consistency on overlaps, so the pasted posterior is not multi-valued. 

prover_08_response

(FBNF-2) Fiber-preserving TRS.

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

and

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

(FBNF-3) Endpoint-only fiber image. On each fiber, the projected row minimum is attained by an endpoint:

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

This is derived by F2 under the affine-fiber support-function primitive P
⋆
. F2 proves endpoint-supported minimization by reducing U∘ℓ
z
	​

 to a one-dimensional convex support-function problem. 

prover_09_response

(FBNF-4) Fiberwise endpoint exposure.

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

and symmetrically for R(z), where

w
z,L
	​

=w
∗
(ℓ
z
	​

(L(z))),w
z,R
	​

=w
∗
(ℓ
z
	​

(R(z))).

(FBNF-5) Fiberwise tie discipline. For λ-a.e. z, the endpoint tie set has τ
z
	​

-measure zero.

Local two-sided perturbability. This is the regularity clause used in F3: Borel endpoint perturbations L(z)+εh(z), R(z)+εk(z) supported on interior patches remain admissible for small ∣ε∣. Under this clause, FBNF-6 is derived, not primitive.

(FBNF-7) Global fiber dominance. For τ-a.e. s=ℓ
z
	​

(t),

μ∈T
min
	​

s⋅w
∗
(μ)=
μ∈T
z
	​

min
	​

s⋅w
∗
(μ).

This is the reviewer-required cross-fiber exclusion. F2 is fiber-local; FBNF-7 is what turns the fiber-local row minimizer into a true original-game adversarial best response. Reviewer 08 explicitly flagged this as necessary before F4. 

reviewer_08_response

Proof
Step 1 - TRS exists and has fibered form

By the trust-region characterization, an optimal rule can be represented as a TRS. In binary this becomes an interval; in the FBNF class, condition (FBNF-2) says the optimal trust region has the fibered form

T=
z
⋃
	​

ℓ
z
	​

([L(z),R(z)]).

The agent’s strategy is fixed as

σ
^
∗
(m)=R(w
∗
(Π
T
	​

(m))).

Messages in the trust region are taken at face value; messages outside a fiber interval are clipped by Π
T
	​

 to the fiber endpoint. This is exactly the TRS architecture from the paper’s Theorem 1 and its proof, where optimal behavior can be represented by a connected trust-region strategy. 

Robust_trust_Dworczak_Smolin

Step 2 - F2 gives endpoint-only image; FBNF-7 makes it global

Fix z and write

L
z
	​

=L(z),R
z
	​

=R(z),w
z,L
	​

=w
∗
(ℓ
z
	​

(L
z
	​

)),w
z,R
	​

=w
∗
(ℓ
z
	​

(R
z
	​

)).

Define the strict endpoint-minimizer regions

S
+
	​

(z)={t:ℓ
z
	​

(t)⋅w
z,L
	​

<ℓ
z
	​

(t)⋅w
z,R
	​

},
S
−
	​

(z)={t:ℓ
z
	​

(t)⋅w
z,R
	​

<ℓ
z
	​

(t)⋅w
z,L
	​

}.

By (FBNF-5), the tie set is τ
z
	​

-null, so S
+
	​

(z)∪S
−
	​

(z) covers the fiber up to null sets.

F2 gives, for each source s=ℓ
z
	​

(t),

μ∈T
z
	​

min
	​

s⋅w
∗
(μ)=min{s⋅w
z,L
	​

,s⋅w
z,R
	​

}.

Thus on S
+
	​

(z), the left endpoint profile is an in-fiber minimizer; on S
−
	​

(z), the right endpoint profile is an in-fiber minimizer.

Now use (FBNF-7):

μ∈T
min
	​

s⋅w
∗
(μ)=
μ∈T
z
	​

min
	​

s⋅w
∗
(μ).

Therefore the endpoint profile selected by F2 is not merely a local fiber minimizer. It is a global minimizer over the whole trust region T. This is the little bridge over the cross-fiber chasm.

Step 3 - F3 derives fiberwise total balance

By F3, local two-sided perturbability plus optimality of the FBNF trust band gives the scalar balance equations for λ-a.e. z:

α∫
a
z
	​

L
z
	​

	​

(L
z
	​

−t)τ
z
	​

(dt)=(1−α)∫
S
+
	​

(z)
	​

(t−L
z
	​

)τ
z
	​

(dt),
(L)

and

α∫
R
z
	​

b
z
	​

	​

(t−R
z
	​

)τ
z
	​

(dt)=(1−α)∫
S
−
	​

(z)
	​

(R
z
	​

−t)τ
z
	​

(dt).
(R)

F3 proves these equalities from FBNF-1 through FBNF-5, optimality, and local endpoint perturbations; it is not a separate primitive in the regular interior class. 

prover_10_response

These are precisely the scalar total-balance hypotheses needed by B1 on each fiber.

Step 4 - F1 constructs the global adversarial kernel

Define the endpoint target fibers in coordinates:

A
L
	​

(z)=[a
z
	​

,L
z
	​

],A
R
	​

(z)=[R
z
	​

,b
z
	​

],I(z)=(L
z
	​

,R
z
	​

).

For the left side, define the tilted measures

η
L,z
	​

(B)=α∫
B∩A
L
	​

(z)
	​

(L
z
	​

−u)τ
z
	​

(du),
ν
L,z
	​

(C)=(1−α)∫
C∩S
+
	​

(z)
	​

(t−L
z
	​

)τ
z
	​

(dt).

Equation (L) says

η
L,z
	​

(A
L
	​

(z))=ν
L,z
	​

(S
+
	​

(z)).

By the fiberwise B1 lift, there is a Borel kernel

κ
L,z
	​

:S
+
	​

(z)→Δ(A
L
	​

(z))

such that for every Borel B⊆A
L
	​

(z),

(1−α)∫
S
+
	​

(z)
	​

(t−L
z
	​

)κ
L,z
	​

(B∣t)τ
z
	​

(dt)=α∫
B
	​

(L
z
	​

−u)τ
z
	​

(du).
(B1-L)

Similarly, using (R), B1 gives

κ
R,z
	​

:S
−
	​

(z)→Δ(A
R
	​

(z))

such that for every Borel B⊆A
R
	​

(z),

(1−α)∫
S
−
	​

(z)
	​

(R
z
	​

−t)κ
R,z
	​

(B∣t)τ
z
	​

(dt)=α∫
B
	​

(u−R
z
	​

)τ
z
	​

(du).
(B1-R)

F1 supplies the measurable-pasting step. In coordinates E={(z,t):t∈[a
z
	​

,b
z
	​

]}, define

β
~
	​

(D∣z,t)=1
S
+
	​

(z)
	​

(t)κ
L,z
	​

(D
z
	​

∣t)+1
S
−
	​

(z)
	​

(t)κ
R,z
	​

(D
z
	​

∣t)+1
N
	​

(z,t)δ
(z,t)
	​

(D),

where N is the null tie/leftover set and D
z
	​

={u:(z,u)∈D}.

Push this kernel forward through the Borel chart Φ(z,t)=ℓ
z
	​

(t):

β
^
	​

∗
(B∣ℓ
z
	​

(t))=
β
~
	​

(Φ
−1
(B)∣z,t),

with arbitrary values on the τ-null complement of the chart.

F1 proves that this is a Borel kernel and that its support is endpoint-fiber preserving:

supp
β
^
	​

∗
(⋅∣ℓ
z
	​

(t))⊆ℓ
z
	​

(A
L
	​

(z))∪ℓ
z
	​

(A
R
	​

(z))for τ-a.e. ℓ
z
	​

(t).

Equivalently,

Π
T
	​

(supp
β
^
	​

∗
(⋅∣ℓ
z
	​

(t)))⊆{ℓ
z
	​

(L
z
	​

),ℓ
z
	​

(R
z
	​

)}.

F1 also proves the posterior calibration identities:

u∈A
L
	​

(z)⟹P
γ
α
	​

	​

(⋅∣ℓ
z
	​

(u))=ℓ
z
	​

(L
z
	​

),
(C-L)
u∈A
R
	​

(z)⟹P
γ
α
	​

	​

(⋅∣ℓ
z
	​

(u))=ℓ
z
	​

(R
z
	​

),
(C-R)
u∈I(z)⟹P
γ
α
	​

	​

(⋅∣ℓ
z
	​

(u))=ℓ
z
	​

(u),
(C-I)

all q-a.e. 

prover_08_response

Step 5 - 
β
^
	​

∗
 is adversarial

Fix s=ℓ
z
	​

(t) outside the null tie set.

If t∈S
+
	​

(z), then 
β
^
	​

∗
(⋅∣s) is supported on ℓ
z
	​

(A
L
	​

(z)). For any target message m=ℓ
z
	​

(u) with u∈A
L
	​

(z), the TRS projection is

Π
T
	​

(m)=ℓ
z
	​

(L
z
	​

),

so the payoff profile induced by the message is w
z,L
	​

. By Step 2, w
z,L
	​

 attains the global row minimum:

s⋅w
z,L
	​

=
μ∈T
min
	​

s⋅w
∗
(μ).

Thus every message in the support of 
β
^
	​

∗
(⋅∣s) is rowwise minimizing.

If t∈S
−
	​

(z), the same argument applies with R
z
	​

 and A
R
	​

(z). Therefore

β
^
	​

∗
∈arg
β∈B
min
	​

E
β,
σ
^
∗
	​

[u],

so 
β
^
	​

∗
 is adversarial against 
σ
^
∗
.

This is the exact point where (FBNF-7) earns its keep: without it, the kernel would only be in-fiber adversarial, not necessarily globally adversarial.

Step 6 - Bayes-optimality of the TRS continuation

Let m=ℓ
z
	​

(u) be a q-typical message.

Interior messages. If u∈(L
z
	​

,R
z
	​

), then F1 gives

P
γ
α
	​

	​

(⋅∣m)=ℓ
z
	​

(u)=m.

Also Π
T
	​

(m)=m, so

σ
^
∗
(m)=R(w
∗
(m)),

which is Bayes-optimal at m by definition of w
∗
.

Left endpoint-fiber messages. If u∈[a
z
	​

,L
z
	​

], then F1 gives

P
γ
α
	​

	​

(⋅∣m)=ℓ
z
	​

(L
z
	​

).

Also Π
T
	​

(m)=ℓ
z
	​

(L
z
	​

), so

σ
^
∗
(m)=R(w
z,L
	​

).

Since w
z,L
	​

=w
∗
(ℓ
z
	​

(L
z
	​

)), this continuation is Bayes-optimal at ℓ
z
	​

(L
z
	​

). FBNF-4 is the upstream hinge that made the endpoint posterior equality derivable from stationarity without cone ambiguity.

Right endpoint-fiber messages. If u∈[R
z
	​

,b
z
	​

], the symmetric calculation gives

P
γ
α
	​

	​

(⋅∣m)=ℓ
z
	​

(R
z
	​

),
σ
^
∗
(m)=R(w
z,R
	​

),

and this is Bayes-optimal at ℓ
z
	​

(R
z
	​

).

Thus

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

Since 
β
^
	​

∗
 is adversarial against 
σ
^
∗
, this verifies robust rationalizability.

Finally, the usual saddle verification gives optimality. For any σ,

U(σ)=
β
inf
	​

U(β,σ)≤U(
β
^
	​

∗
,σ)≤U(
β
^
	​

∗
,
σ
^
∗
)=
β
inf
	​

U(β,
σ
^
∗
)=U(
σ
^
∗
).

The middle inequality follows from pointwise Bayes-optimality of 
σ
^
∗
 under the posterior induced by 
β
^
	​

∗
; the last equality is adversariality. Hence 
σ
^
∗
 is optimal and robustly rationalizable.

That proves the theorem. □

Economic interpretation of primitives

FBNF-1: signal posteriors live on a one-dimensional family.
The adviser’s posterior variation is not arbitrary in Δ(Ω); it is organized into scalar fibers. The base z is the “which binary subproblem?” label, and t is the scalar severity, radius, likelihood-ratio, or risk coordinate.

FBNF-2: the trust region respects the foliation.
Clipping a suspicious report does not jump to another fiber. The agent discounts extremeness within the same one-dimensional information channel.

FBNF-3 via F2: fiber arcs are well-shaped.
F2’s affine support-function proof says that along a fiber, every interior supporting continuation is dominated for minimization by one endpoint. The adversary’s projected image is therefore endpoint-only.

FBNF-4: unique Bayes belief at each fiber endpoint label.
Endpoint exposure prevents a cone-shaped ambiguity: the stationarity posterior at w
z,L
	​

 must be the endpoint belief ℓ
z
	​

(L
z
	​

), not merely some other belief in a larger Bayes cone.

FBNF-5: no atom at the fiber tie point.
This removes positive-mass tie-splitting. If it fails, the theorem needs the weighted tie-split version, not the clean indicator regions S
+
	​

(z),S
−
	​

(z).

FBNF-7: cross-fiber messages do not beat in-fiber endpoints.
This is not a calibration assumption. It is a global support condition: the original adversary is allowed to choose any message, so in-fiber endpoint minimizers must also be global minimizers.

Coverage examples

Spherical models.
The paper’s spherical environment has radial/antipodal structure: a trust region that is a ball around a center, an adversary that chooses the opposite boundary point, and a scalar balance equation for the radius. This is the clean radial instance of FBNF, with fibers equal to affine diameters through the center. 

Robust_trust_Dworczak_Smolin

Affine MLR / single-crossing models.
If posterior movement in each stratum lies on an affine ordered arc

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

and the payoff frontier has the single-crossing support-function property along that arc, F2 applies fiberwise. General curved MLR remains outside this exact theorem unless it is reparameterized into affine belief fibers.

Polyhedral W with scalarizable faces.
Finite-vertex/polyhedral menus are not enough by themselves. The faces must decompose into one-dimensional scalar fibers so that each calibration equation is a B1 transport rather than a multidimensional Hall problem.

Comparison with v8 menu-Hall and the binary capstone

v8 Tier 2.
v8 required menu-Hall: a calibrated kernel supported on rowwise minimizers whose induced posterior lies in the Bayes cone q-a.e. That is a calibration-shaped condition on the optimized menu output; v8 correctly treated it as a conditional theorem rather than an unrestricted extension. 

exposition_v8.1_post_splice

v9 binary capstone.
The binary theorem did not assume menu-Hall. It derived calibration from endpoint-only image, endpoint stationarity, and scalar B1 transport. The FBNF theorem is the same machine with a fiber index z: scalar transport happens conditionally, then F1 pastes the kernels.

v9 FBNF ∣Ω∣≥3.
The new primitive content is not “there exists a calibrated kernel.” Instead, it is geometric: a measurable affine foliation, fiber-preserving clipping, endpoint exposure, tie discipline, local perturbability, and global fiber dominance. Those conditions force the calibrated kernel to exist.

Sharpness compatibility

The WTA ternary witness is correctly excluded. Its obstruction is a genuinely two-dimensional vector-balance problem with three vertex labels and nontrivial Bayes cones, while FBNF assumes a one-dimensional affine-fiber decomposition and scalarizes every active calibration equation. F1’s audit makes this explicit: the FBNF route avoids the multidimensional Hall dragon rather than pretending it is gone. 

prover_08_response

In the language of this theorem, WTA ternary fails FBNF-7: cross-vertex dominance means an out-of-fiber label can beat the in-fiber endpoint. Thus the witness is outside the FBNF class for the right reason.

Open

Non-affine foliations remain open. Once

ℓ
z
	​

(t)−ℓ
z
	​

(r)=(t−r)d
z
	​


fails, F2’s scalar subgradient proof no longer runs.

General curved MLR remains open unless it can be straightened into affine belief fibers.

Polyhedral W without scalarizable faces remains open. Raw finite vertices still leave a vector Hall problem; scalarizable faces are the needed extra geometry.

Verdict: PASS, conditional on the corrected endpoint-fiber reading of F1 and the explicit primitive FBNF-7 global fiber dominance. Next-step signal: send F4 to reviewer, then formalize the spherical/radial and affine-MLR examples as worked FBNF instances.
