
========
ROLE: user (id=d8061506-7fc1-4990-a121-524675d91ef2)
========
# Prover pass 08 — F1: Conditional B1 + measurable pasting (FBNF route to |Ω|≥3)

## Role

You are the Prover. The binary case |Ω|=2 capstone is fully verified
(prover_07_response.md, reviewer_06_response.md). Searcher 04
identified the primary attack route for |Ω|≥3: **G3′/FBNF — Fibered
Binary Normal Fan**. Treat Δ(Ω) as foliated by 1D affine "binary
fibers" and apply the binary capstone conditionally on each fiber.

Searcher 04's lemma chain has 4 lemmas. Your job: prove **F1, the
gate-unlocking conditional-pasting lemma**.

If F1 PASSes, the FBNF route is alive for |Ω|≥3. F2 (endpoint-only
fiber image) and F3 (localized stationarity → fiberwise balance) come
next; F4 is the capstone assembly.

## Setup — the FBNF class

**FBNF primitives** (5 conditions defining the class):

- **(FBNF-1) Measurable affine foliation.** Standard Borel base $Z$,
  Borel disintegration
  $\tau(ds) = \int_Z \tau_z(dt)\,\lambda(dz)$
  and measurable affine embeddings $\ell_z:[a_z, b_z]\to\Delta(\Omega)$
  such that $M$ is covered τ-a.e. by the fibers $\ell_z([a_z, b_z])$.
- **(FBNF-2) Fiber-preserving TRS.** The optimal trust region is fiberwise:
  $T = \bigcup_z \ell_z([L(z), R(z)])$, and the Bregman projection stays
  in the same fiber: $\Pi_T(\ell_z(t)) = \ell_z(\Pi_{[L(z), R(z)]}(t))$.
- **(FBNF-3) Endpoint-only fiberwise rowwise minimization.** For τ_z-a.e.\ $t$,
  $\arg\min_{\mu\in T_z} s\cdot w^*(\mu) \subseteq \{\ell_z(L(z)), \ell_z(R(z))\}$.
- **(FBNF-4) Fiberwise endpoint exposure.** At each active endpoint,
  $B_W(w_{z,L}) \cap \ell_z([a_z, b_z]) = \{\ell_z(L(z))\}$, and
  symmetrically for $R(z)$.
- **(FBNF-5) Fiberwise tie discipline.** $\tau_z$ assigns zero mass to
  the endpoint tie point $b(z)$.
- **(FBNF-6) Local endpoint stationarity.** For λ-a.e.\ $z$, the
  fiberwise total-balance equations hold:
  $\alpha\!\int_{a_z}^{L(z)}\!(L(z)-t)\,\tau_z(dt) = (1-\alpha)\!\int_{S_+(z)}\!(t-L(z))\,\tau_z(dt)$,
  and the symmetric right-endpoint equation.

The substantive case is $\alpha\in(0,1)$.

## Lemma F1 — Conditional B1 + measurable pasting

**Hypotheses.** Standing assumptions + FBNF-1 through FBNF-6.

**Statement.** There exists a global Borel adversarial kernel
$\hat\beta^*: M\to\Delta(M)$ such that:

(a) **Fiber-preserving rowwise-minimizer support.** For τ-a.e.\ $s = \ell_z(t)$,
$\operatorname{supp}\hat\beta^*(\cdot\mid s)\subseteq \{\ell_z(L(z)), \ell_z(R(z))\}$
(the two fiber endpoints).

(b) **Fiberwise calibration.** Define $\gamma_\alpha = \alpha(\mathrm{id},\mathrm{id})_\#\tau + (1-\alpha)\tau\otimes\hat\beta^*$
and $q := (\gamma_\alpha)_2$. The disintegration posterior on $\Omega$,
$P_{\gamma_\alpha}(\cdot\mid m)$, satisfies:
- For $q$-a.e.\ message $m = \ell_z(L(z))$ (left fiber endpoint):
  $P_{\gamma_\alpha}(\cdot\mid m) = \ell_z(L(z))$ (identified with a belief in $\Delta(\Omega)$).
- For $q$-a.e.\ message $m = \ell_z(R(z))$: $P_{\gamma_\alpha}(\cdot\mid m) = \ell_z(R(z))$.
- For $q$-a.e.\ interior message $m = \ell_z(t)$ with $t\in(L(z), R(z))$:
  $P_{\gamma_\alpha}(\cdot\mid m) = \ell_z(t)$ (truthful, by no-extra-fiber-traffic).

(c) **Bayes-optimality.** $\hat\sigma^*(m) := R(w^*(\Pi_T(m)))$ is
Bayes-optimal under $P_{\gamma_\alpha}(\cdot\mid m)$ for $q$-a.e.\ $m\in M$.

## Proof structure (your job to rigorize)

### Step 1 — Disintegrate τ via FBNF-1

$\tau$ disintegrates via $\ell$ into $\tau(ds) = \int_Z \tau_z(dt)\,\lambda(dz)$.
Use standard Polish-space disintegration (Kallenberg 1997 Thm 6.10) on
the Borel surjection $(z, t)\mapsto \ell_z(t)$ from $\{(z, t): z\in Z, t\in[a_z, b_z]\}$
to $M\subseteq\Delta(\Omega)$.

### Step 2 — Apply L_B1 fiberwise

For λ-a.e.\ $z$, the conditional measure $\tau_z$ on $[a_z, b_z]$
satisfies the fiberwise total-balance equations (FBNF-6) at the
endpoints $L(z), R(z)$.

Apply L_B1 (durable source prover_05_response.md) with $p = L(z)$,
$A_- = [a_z, L(z)] \cap \operatorname{supp}\tau_z$, $S_+ = \{t\in[L(z), b_z]: \text{left-minimizer at }t\}$:
- Total-balance gives the L_B1 hypothesis $\eta_z(A_-) = \nu_z(S_+) < \infty$.
- L_B1 supplies a Borel kernel $\kappa_{L,z}: S_+ \to \Delta(A_-)$
  realizing the fiberwise balance, with posterior = $L(z)$ at every
  left-fiber endpoint message.

Apply the symmetric version for $R(z)$.

### Step 3 — Measurable pasting

Show that the family $\{(\kappa_{L,z}, \kappa_{R,z})\}_{z\in Z}$ can be
glued into a single Borel kernel $\hat\beta^*: M\to\Delta(M)$ via the
foliation $\ell$.

**Tool**: standard measurable-pasting / Borel-isomorphism arguments
on standard Borel spaces. Specifically, the joint object
$(z, t, \text{adversarial message})\in Z\times\R\times M$ has Borel
structure inherited from products and measurable selections.

The pasted kernel:
- For $s = \ell_z(t)$ with $t\in S_+(z)$ (high source): route to fiber
  left endpoint $\ell_z(L(z))$ via $\kappa_{L,z}$.
- For $s = \ell_z(t)$ with $t\in S_-(z)$ (low source): route to fiber
  right endpoint $\ell_z(R(z))$ via $\kappa_{R,z}$.
- For $s$ in fiber tie point (FBNF-5: λ-a.e. zero mass): arbitrary
  (default to truthful $\delta_s$).
- For $s\notin M$: arbitrary, $q$-null.

Verify Borel measurability of $z\mapsto \kappa_{L,z}$ and
$z\mapsto \kappa_{R,z}$ (standard kernel measurability under
parameter $z$, by KRN or Aliprantis-Border 18.13).

### Step 4 — Verify (a) — fiber-preserving support

The pasted kernel sends every $s = \ell_z(t)$ to mass on
$\{\ell_z(L(z)), \ell_z(R(z))\}$ by construction (Step 3 + L_B1 support).
This is FBNF-2 + fiber-preserving construction.

### Step 5 — Verify (b) — calibration

For a $q$-positive left-fiber-endpoint message $m = \ell_z(L(z))$:

The conditional posterior at $m$ on $\Omega$ is:
\[
P_{\gamma_\alpha}(\omega\mid m) = \frac{\alpha\,m(\omega)\,\tau(\{m\}) + (1-\alpha)\!\int s(\omega)\,\kappa_{L,z}(\{m\}\mid s)\,\tau(ds)}{q(\{m\})}.
\]

By L_B1 Claim 2 applied to fiber $z$: the conditional barycenter on
the left fiber equals $L(z)$ in the fiber coordinate. Pull back via
$\ell_z$: the posterior belief equals $\ell_z(L(z))$ in $\Delta(\Omega)$.

For interior messages $m = \ell_z(t)$ with $t\in(L(z), R(z))$: the
no-extra-fiber-traffic stipulation (Step 3 routing) ensures
$\hat\beta^*$ sends no mass to interior $m$ from other fibers; only
aligned-truthful mass at $s = m$. Posterior is $\delta_m$ on
beliefs, i.e., the belief $m$ itself.

### Step 6 — Verify (c) — Bayes-optimality

For each $m$:
- Interior $m = \ell_z(t)$: posterior is $\ell_z(t)$; TRS continuation
  $\hat\sigma^*(\ell_z(t)) = R(w^*(\ell_z(t)))$ is Bayes-optimal at
  $\ell_z(t)$ by definition of $w^*$.
- Endpoint $m = \ell_z(L(z))$: posterior is $\ell_z(L(z))$; by FBNF-4
  fiberwise endpoint exposure, $w_{z,L} = w^*(\ell_z(L(z)))$ is
  Bayes-optimal exactly at $\ell_z(L(z))$. TRS continuation
  $\hat\sigma^*(\ell_z(L(z))) = R(w_{z,L})$ is Bayes-optimal there.
- Endpoint $m = \ell_z(R(z))$: symmetric.

Definition 2 holds $q$-a.e.

## What I want you to produce

A FULLY RIGOROUS proof of F1, in the structure:


# Lemma F1 — Conditional B1 + measurable pasting

## Statement (a), (b), (c) restated

## Hypotheses (FBNF-1 through FBNF-6)

## Proof
### Step 1 — Disintegrate τ via FBNF-1
### Step 2 — Apply L_B1 fiberwise
### Step 3 — Measurable pasting (verify Borel structure carefully)
### Step 4 — Fiber-preserving support
### Step 5 — Calibration via L_B1 Claim 2 pull-back
### Step 6 — Bayes-optimality via FBNF-4 endpoint exposure

## Hidden-hypothesis audit
- Use of FBNF-1 (foliation): essential.
- FBNF-2 (fiber-preserving TRS): essential.
- FBNF-3 (endpoint-only fiber image): used in Step 2.
- FBNF-4 (fiberwise endpoint exposure): used in Step 6.
- FBNF-5 (fiberwise tie discipline): used in Step 2 to avoid B1 boundary issues.
- FBNF-6 (local endpoint stationarity): essential, provides B1 hypothesis.

## Compatibility with v8 sharpness package
WTA ternary witness has |Ω|=3 but is NOT fibered binary in the FBNF-1
sense: the witness's normal fan is 2-dimensional with three vertex
labels {v_0, v_1, v_2}, not a 1-parameter family. So FBNF rules out
the witness by hypothesis.

## Open issues
- F2 (endpoint-only fiber image): the "fiber-restricted" analog of
  L_B3 in higher dimensions. Need to prove (FBNF-3) follows from
  primitive conditions on (u, A) under the foliation.
- F3 (localized endpoint stationarity): (FBNF-6) needs to follow from
  optimality + foliation structure. This may need a localized v9 T1
  Clarke-Danskin theorem.
- F4 (capstone assembly): once F1+F2+F3 are clear, this is bookkeeping.
- Construction of the foliation ℓ from primitives: the FBNF
  hypothesis is non-trivial to verify in practice. Examples worth
  listing: spherical models, MLR families, fan-induced normal cones.


## Output Contract

- Inline as plain markdown.
- Use L_B1 verbatim as proven.
- Be rigorous about measurability — name every selection theorem you use.
- End with verdict (PASS / PATCH_SMALL / PATCH_BIG / HOLD) on your own
  work + next-step signal.

## Constraints

- Banned tools: see prior_attempts_digest.md.
- v9 T1 may be cited as proven.
- L_B1 may be cited verbatim from prover_05_response.md.
- Per user: keep going. If F1 fails, identify the missing measure-
  theoretic ingredient and propose a fix.

Show more

========
ROLE: assistant (id=6bb5bc50-14b6-479c-af37-f2a6a2cea99b)
========
Lemma F1 - Conditional B1 + measurable pasting
Preliminary correction: literal F1 is false as written

The literal support clause

supp
β
^
	​

∗
(⋅∣ℓ
z
	​

(t))⊆{ℓ
z
	​

(L(z)),ℓ
z
	​

(R(z))}

cannot be combined with the B1 balance mechanism unless the outside-fiber masses are degenerate.

The obstruction is the same small bookkeeping issue that appeared in the binary capstone: B1 does not send high sources only to the point L. It sends high sources into the left endpoint fiber

A
L
	​

(z):=[a
z
	​

,L(z)]

so that aligned truthful messages below L(z) provide the negative signed mass needed to offset the high-source surplus. Prover 05’s B1 already flagged the no-extra-traffic condition and used tilted measures on A
−
	​

, not only the singleton endpoint. 

prover_05_response

Here is the one-line contradiction for literal endpoint support. Suppose on one fiber there is positive high-source mass routed to ℓ
z
	​

(L). At the message m
L
	​

=ℓ
z
	​

(L), the aligned truthful contribution has belief exactly ℓ
z
	​

(L), while every nontrivial high-source adversarial contribution has belief ℓ
z
	​

(t) with t>L. Since ℓ
z
	​

 is affine, the posterior at m
L
	​

 is strictly above ℓ
z
	​

(L) in the fiber direction unless the high-source routed mass is zero. Thus endpoint-only point support cannot produce endpoint calibration. And if no adversarial mass is sent to exterior messages u<L, those exterior messages are aligned-on-path with posterior ℓ
z
	​

(u), while the TRS continuation clips them to ℓ
z
	​

(L), so Bayes-optimality fails there whenever τ
z
	​

([a
z
	​

,L(z)))>0.

So the correct F1 statement is the endpoint-fiber version:

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

equivalently,

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

That is exactly the object Searcher 04 identified: conditional B1 plus measurable pasting along a fibered-binary normal fan. 

searcher_04_response

The proof below establishes this patched F1. The literal singleton-endpoint version is not recoverable without adding a degenerate assumption that the endpoint-fiber deficit/surplus masses vanish.

Statement, patched endpoint-fiber form

Let the standing Robust Trust assumptions hold, with Ω finite, M⊆Δ(Ω) standard Borel, and τ the adviser-posterior law. Robust rationalizability is read q-a.e. in infinite message spaces, since P
β
∗
	​

(⋅∣m) is itself only defined under the mixture message marginal q. 

theorem_2_extension_proof_v8

Assume FBNF-1 through FBNF-6, interpreted with a Borel coordinate chart as follows. Let

E:={(z,t):z∈Z, t∈[a
z
	​

,b
z
	​

]}

be a standard Borel set, let

Φ:E→M,Φ(z,t)=ℓ
z
	​

(t),

and let

τ
ˉ
(dz,dt):=λ(dz)τ
z
	​

(dt),τ=Φ
#
	​

τ
ˉ
.

For a clean global kernel on M, assume Φ is a Borel isomorphism between a 
τ
ˉ
-full Borel subset E
0
	​

⊆E and a τ-full Borel subset M
0
	​

⊆M. This is the precise “measurable foliation” reading needed for a pasted kernel on messages rather than merely on coordinates.

Define

A
L
	​

(z):=[a
z
	​

,L(z)],A
R
	​

(z):=[R(z),b
z
	​

],
I(z):=(L(z),R(z)).

Let S
L
	​

(z) be the strict left-endpoint row-minimizer set and S
R
	​

(z) the strict right-endpoint row-minimizer set. By FBNF-3 and FBNF-5, for λ-a.e. z,

S
L
	​

(z)∪S
R
	​

(z)

covers [a
z
	​

,b
z
	​

] up to τ
z
	​

-null tie sets. The sign convention is

S
L
	​

(z)⊆[L(z),b
z
	​

],S
R
	​

(z)⊆[a
z
	​

,R(z)]

up to τ
z
	​

-null sets.

Then there exists a Borel adversarial kernel

β
^
	​

∗
:M→Δ(M)

such that:

(a′) Fiber-preserving endpoint-fiber support. For τ-a.e. s=ℓ
z
	​

(t),

supp
β
^
	​

∗
(⋅∣s)⊆ℓ
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

(z)).

Equivalently,

Π
T
	​

(supp
β
^
	​

∗
(⋅∣s))⊆{ℓ
z
	​

(L(z)),ℓ
z
	​

(R(z))}.

(b′) Fiberwise calibration. Let

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

.

Then for q-a.e. message m=ℓ
z
	​

(u):

u∈A
L
	​

(z)⟹P
γ
α
	​

	​

(⋅∣m)=ℓ
z
	​

(L(z)),
u∈A
R
	​

(z)⟹P
γ
α
	​

	​

(⋅∣m)=ℓ
z
	​

(R(z)),
u∈I(z)⟹P
γ
α
	​

	​

(⋅∣m)=ℓ
z
	​

(u)=m.

(c) Bayes-optimality. The TRS continuation

σ
^
∗
(m)=R(w
∗
(Π
T
	​

(m)))

is Bayes-optimal under P
γ
α
	​

	​

(⋅∣m) for q-a.e. m∈M.

Hypotheses used

Standing Robust Trust assumptions.

FBNF-1: measurable affine foliation, strengthened to a τ-a.e. Borel chart.

FBNF-2: fiber-preserving TRS and fiber-preserving projection.

FBNF-3: endpoint-only fiberwise rowwise minimization.

FBNF-4: endpoint exposure. Not strictly needed for the measure-pasting identity, but compatible and used downstream when deriving stationarity/calibration from primitives.

FBNF-5: fiberwise tie discipline.

FBNF-6: local endpoint stationarity, giving scalar total-balance equations on λ-a.e. fiber.

α∈(0,1).

Tools cited

Standard-Borel disintegration and regular conditional probabilities, e.g. Kallenberg, Foundations of Modern Probability (1997), Theorem 6.10.

Kernel integration theorem: if z↦τ
z
	​

 is a Borel kernel and f(z,t) is bounded Borel, then z↦∫f(z,t)τ
z
	​

(dt) is Borel.

Kuratowski-Ryll-Nardzewski / Jankov-von Neumann only for harmless default selectors if one does not take t=L(z),R(z) as default points.

Radon-Nikodym Bayes rule on finite Ω.

Lemma B1, used fiberwise. B1 is the scalar transport gadget: tilted source mass (1−α)(t−p)τ(dt) is coupled to tilted target mass α(p−u)τ(du), yielding posterior p on the target fiber, with no atomlessness or density required. 

prover_05_response

Proof
Step 1 - Disintegrate τ via FBNF-1

Let

τ
ˉ
(dz,dt)=λ(dz)τ
z
	​

(dt)

on

E={(z,t):t∈[a
z
	​

,b
z
	​

]}.

The coordinate map

Φ(z,t)=ℓ
z
	​

(t)

pushes 
τ
ˉ
 forward to τ:

τ=Φ
#
	​

τ
ˉ
.

We work first on the coordinate message space E, then push forward to M using the Borel chart Φ:E
0
	​

→M
0
	​

. This avoids a nasty little quotient goblin: if two different fibers share the same message point but prescribe different endpoint posteriors, no single posterior on M can satisfy both. The Borel-chart clause is therefore not decorative; it is the key measurable-pasting condition.

For each z, write

L
z
	​

:=L(z),R
z
	​

:=R(z).

Since ℓ
z
	​

 is affine, there is a vector d
z
	​

∈R
Ω
 such that for all t,u∈[a
z
	​

,b
z
	​

],

ℓ
z
	​

(t)−ℓ
z
	​

(u)=(t−u)d
z
	​

.
Step 2 - Apply B1 fiberwise, with a canonical measurable choice

For λ-a.e. z, define the left tilted measures

η
L,z
	​

(B):=α∫
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

(C):=(1−α)∫
C∩S
L
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

FBNF-6 gives the total balance

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
L
	​

(z))=:c
L
	​

(z)<∞

for λ-a.e. z.

Likewise define the right tilted measures

η
R,z
	​

(B):=α∫
B∩A
R
	​

(z)
	​

(u−R
z
	​

)τ
z
	​

(du),
ν
R,z
	​

(C):=(1−α)∫
C∩S
R
	​

(z)
	​

(R
z
	​

−t)τ
z
	​

(dt),

with common mass

c
R
	​

(z):=η
R,z
	​

(A
R
	​

(z))=ν
R,z
	​

(S
R
	​

(z)).

B1 says that any coupling of the normalized tilted measures works. For measurable pasting, choose the canonical product coupling. Thus, for c
L
	​

(z)>0, set

K
L,z
	​

(B∣t):=
c
L
	​

(z)
η
L,z
	​

(B)
	​

(t∈S
L
	​

(z)).

For c
L
	​

(z)=0, set K
L,z
	​

(⋅∣t)=δ
L
z
	​

	​

 in coordinate space. This branch is ν
L,z
	​

-null and therefore has no effect on the balance identity.

Similarly, for c
R
	​

(z)>0,

K
R,z
	​

(B∣t):=
c
R
	​

(z)
η
R,z
	​

(B)
	​

(t∈S
R
	​

(z)),

and for c
R
	​

(z)=0, set K
R,z
	​

(⋅∣t)=δ
R
z
	​

	​

.

These are Borel kernels in (z,t). Indeed, for any Borel D⊆E, the section

D
z
	​

:={u:(z,u)∈D}

is Borel, and

z↦∫1
D
	​

(z,u)(L
z
	​

−u)1
{u≤L
z
	​

}
	​

τ
z
	​

(du)

is Borel by the kernel integration theorem. The same argument applies to the right side. The ratios by c
L
	​

(z), c
R
	​

(z) are Borel on the positive-mass sets, and the default branches are Borel because z↦L
z
	​

,R
z
	​

 are Borel.

For every Borel B⊆A
L
	​

(z), the left balance identity is

(1−α)∫
S
L
	​

(z)
	​

(t−L
z
	​

)K
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
(L)

For every Borel B⊆A
R
	​

(z), the right balance identity is

(1−α)∫
S
R
	​

(z)
	​

(R
z
	​

−t)K
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
(R)

This is B1, but with the coupling chosen canonically so the parameter z moves measurably.

Step 3 - Measurable pasting into a coordinate kernel

Define a kernel 
β
	​

:E→Δ(E) by

β
	​

(D∣z,t)=1
S
L
	​

	​

(z,t)K
L,z
	​

(D
z
	​

∣t)+1
S
R
	​

	​

(z,t)K
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

where N is the tie/null leftover set. By FBNF-5,

τ
ˉ
(N)=0.

The kernel is Borel because S
L
	​

,S
R
	​

,N are Borel and K
L
	​

,K
R
	​

 are Borel kernels.

Now push this kernel to M. On M
0
	​

=Φ(E
0
	​

), define

β
^
	​

∗
(A∣Φ(z,t)):=
β
	​

(Φ
−1
(A)∣z,t).

On the τ-null complement M∖M
0
	​

, define 
β
^
	​

∗
(⋅∣m) arbitrarily, say δ
m
	​

 when m∈M. Since Φ:E
0
	​

→M
0
	​

 is a Borel isomorphism, this is a Borel kernel M→Δ(M).

This is the paste. The glue is not pixie dust; it is the Borel chart plus the canonical product-coupling choice.

Step 4 - Verify fiber-preserving support and adversariality

For (z,t)∈S
L
	​

, the support of 
β
	​

(⋅∣z,t) is contained in

{z}×A
L
	​

(z).

For (z,t)∈S
R
	​

, the support is contained in

{z}×A
R
	​

(z).

Therefore, after pushing forward to M,

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

(z))

for τ-a.e. ℓ
z
	​

(t).

By FBNF-2,

Π
T
	​

(ℓ
z
	​

(u))=ℓ
z
	​

(L
z
	​

)for u∈A
L
	​

(z),

and

Π
T
	​

(ℓ
z
	​

(u))=ℓ
z
	​

(R
z
	​

)for u∈A
R
	​

(z).

Thus the induced payoff profile is w
z,L
	​

 on the left endpoint fiber and w
z,R
	​

 on the right endpoint fiber. By FBNF-3, these are rowwise minimizers for the corresponding source sets S
L
	​

,S
R
	​

, up to the 
τ
ˉ
-null tie set. Hence 
β
^
	​

∗
 is adversarial against the TRS continuation.

So the literal point-support clause fails, but the payoff-image support is exactly endpoint-only:

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
Step 5 - Calibration by Radon-Nikodym Bayes rule

Work on the coordinate space first. Define

γ
	​

α
	​

=α(id
E
	​

,id
E
	​

)
#
	​

τ
ˉ
+(1−α)
τ
ˉ
⊗
β
	​

,

and let

q
	​

=(
γ
	​

α
	​

)
2
	​

.

Define the vector numerator measure

n
(C):=∫
E×C
	​

Φ(z,t)
γ
	​

α
	​

(d(z,t),d(z
′
,u)).

Since Ω is finite, this is just a finite vector of finite measures, one coordinate per state. Each coordinate is absolutely continuous with respect to 
q
	​

. Therefore

d
q
	​

d
n
	​

(z,u)

is a version of the posterior belief after observing the coordinate message (z,u).

Left endpoint fiber

Let C⊆E
L
	​

:={(z,u):u∈A
L
	​

(z)} be Borel. We prove

n
(C)=∫
C
	​

ℓ
z
	​

(L
z
	​

)
q
	​

(dz,du).
(LC)

The aligned contribution to the difference between the two sides of (LC) is

α∫
C
	​

(ℓ
z
	​

(u)−ℓ
z
	​

(L
z
	​

))
τ
ˉ
(dz,du).

The misaligned contribution comes only from S
L
	​

, because the pasted kernel sends no right-source traffic into E
L
	​

. It is

(1−α)∫
Z
	​

∫
S
L
	​

(z)
	​

∫
C
z
	​

	​

(ℓ
z
	​

(t)−ℓ
z
	​

(L
z
	​

))K
L,z
	​

(du∣t)τ
z
	​

(dt)λ(dz).

Using affinity,

ℓ
z
	​

(u)−ℓ
z
	​

(L
z
	​

)=(u−L
z
	​

)d
z
	​

,

and

ℓ
z
	​

(t)−ℓ
z
	​

(L
z
	​

)=(t−L
z
	​

)d
z
	​

.

Thus the total difference is

∫
Z
	​

d
z
	​

[−α∫
C
z
	​

	​

(L
z
	​

−u)τ
z
	​

(du)+(1−α)∫
S
L
	​

(z)
	​

(t−L
z
	​

)K
L,z
	​

(C
z
	​

∣t)τ
z
	​

(dt)]λ(dz).

The bracket is zero by (L). Therefore (LC) holds.

By the Radon-Nikodym theorem,

P
γ
	​

α
	​

	​

(⋅∣z,u)=ℓ
z
	​

(L
z
	​

)
q
	​

-a.e. on E
L
	​

.
Right endpoint fiber

The same calculation with (R) gives, for every Borel C⊆E
R
	​

:={(z,u):u∈A
R
	​

(z)},

n
(C)=∫
C
	​

ℓ
z
	​

(R
z
	​

)
q
	​

(dz,du),

hence

P
γ
	​

α
	​

	​

(⋅∣z,u)=ℓ
z
	​

(R
z
	​

)
q
	​

-a.e. on E
R
	​

.
Interior fiber

Let

E
I
	​

:={(z,u):L
z
	​

<u<R
z
	​

}.

By construction, 
β
	​

(E
I
	​

∣z,t)=0 for 
τ
ˉ
-a.e. (z,t), because all non-null adversarial traffic goes to E
L
	​

∪E
R
	​

. Therefore, for Borel C⊆E
I
	​

,

q
	​

(C)=α
τ
ˉ
(C),

and

n
(C)=α∫
C
	​

ℓ
z
	​

(u)
τ
ˉ
(dz,du).

So

P
γ
	​

α
	​

	​

(⋅∣z,u)=ℓ
z
	​

(u)
q
	​

-a.e. on E
I
	​

.

Pushing these identities forward through the Borel isomorphism Φ:E
0
	​

→M
0
	​

 gives the claimed q-a.e. posterior identities on M:

u≤L
z
	​

⟹P
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
u≥R
z
	​

⟹P
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
L
z
	​

<u<R
z
	​

⟹P
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

(u).
Step 6 - Bayes-optimality

Let m=ℓ
z
	​

(u).

If u∈A
L
	​

(z), then by Step 5,

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

)q-a.e.

By FBNF-2,

Π
T
	​

(m)=ℓ
z
	​

(L
z
	​

).

Hence

σ
^
∗
(m)=R(w
∗
(ℓ
z
	​

(L
z
	​

))),

which is Bayes-optimal at posterior ℓ
z
	​

(L
z
	​

) by the definition of w
∗
.

If u∈A
R
	​

(z), the same argument gives posterior ℓ
z
	​

(R
z
	​

) and continuation

R(w
∗
(ℓ
z
	​

(R
z
	​

))),

Bayes-optimal at ℓ
z
	​

(R
z
	​

).

If u∈(L
z
	​

,R
z
	​

), Step 5 gives

P
γ
α
	​

	​

(⋅∣m)=m,

and FBNF-2 gives

Π
T
	​

(m)=m.

Thus

σ
^
∗
(m)=R(w
∗
(m)),

Bayes-optimal at m.

Combining the three cases,

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

This is Definition 2’s Bayes-optimality requirement in the infinite-space q-a.e. reading.

Hidden-hypothesis audit

FBNF-1, foliation. Essential. A Borel chart is needed. A mere Borel surjection (z,t)↦ℓ
z
	​

(t) is not enough unless overlapping fibers prescribe identical endpoint posteriors at every overlap. Without a chart or quotient-consistency condition, the pasted posterior may be multi-valued at the same message.

FBNF-2, fiber-preserving TRS. Essential. It is what makes every message in ℓ
z
	​

(A
L
	​

(z)) behaviorally equivalent to the endpoint ℓ
z
	​

(L
z
	​

), and similarly on the right.

FBNF-3, endpoint-only fiber image. Essential for adversariality. The kernel is supported on endpoint fibers, but its projected payoff image is supported on the two endpoint labels.

FBNF-4, fiberwise endpoint exposure. Not load-bearing for the measure-pasting identity itself. It is load-bearing in the upstream/downstream steps that turn endpoint stationarity into endpoint posterior equality and rule out cone ambiguity.

FBNF-5, tie discipline. Essential unless one replaces it by an explicit measurable tie-splitting rule. In this proof, the tie set is thrown into N, and 
τ
ˉ
(N)=0.

FBNF-6, local endpoint stationarity. Essential. It supplies the scalar total-balance identities that B1 transports.

B1 empty-target convention. Harmless but necessary for literal formalism. If the common tilted mass is zero, the kernel branch is arbitrary on a null tilted source set. If a target fiber were literally empty while a nonempty source branch required a probability on it, the statement would need a default outside that empty target or an assumption that the branch is τ-null.

Compatibility with v8 sharpness package

This proof does not conflict with the ternary WTA sharpness package. The v8 obstruction is a genuinely multidimensional vector-balance failure: menu-Hall asks for a rowwise-minimizer kernel whose induced posterior lies in Bayes cones q-a.e., and the ternary witness shows that this cannot be manufactured by null-message dust. 

exposition_v8.1_post_splice

The FBNF route avoids that dragon rather than slaying it head-on. It assumes a primitive one-dimensional foliation that reduces each active calibration equation to a scalar B1 balance. Searcher 04 explicitly marked this as the top ∣Ω∣≥3 route because it turns vector calibration into fiberwise scalar transport. 

searcher_04_response

The WTA ternary witness is not fibered binary in this sense: its normal-fan obstruction uses three vertex labels and a two-dimensional cone geometry, not a one-parameter family of binary fibers.

Open issues

F2. Endpoint-only fiber image remains a geometric theorem: show that FBNF-3 follows from primitive assumptions on (u,A,τ) and the foliation.

F3. Localized endpoint stationarity remains the analytic theorem: derive FBNF-6 from optimality via a localized Clarke-Danskin/v9 T1 argument.

F4. Capstone assembly is now mostly bookkeeping once F1
fib
, F2, and F3 are in place.

Foliation construction. The Borel chart condition is the little hinge. Examples such as radial models, MLR families, and fan-induced normal-cone fibers should verify it explicitly.

Verdict

PATCH_BIG for literal F1; PASS for the corrected endpoint-fiber F1. The FBNF route stays alive, but the statement must replace singleton endpoint support {ℓ
z
	​

(L),ℓ
z
	​

(R)} by endpoint-fiber support ℓ
z
	​

([a
z
	​

,L])∪ℓ
z
	​

([R,b
z
	​

]), plus the Borel-chart/quotient-consistency clause. Next-step signal: prove F2, the endpoint-only fiber image theorem, under the FBNF primitive geometry.
