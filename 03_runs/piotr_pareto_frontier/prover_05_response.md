
========
ROLE: user (id=ce246069-267c-4e80-868b-5f07b5cdab3b)
========
# Prover pass 05 — Lemma B1: Binary scalar endpoint-fiber lift

## Role

You are the Prover. Pass 3+'s Prover 04 (strict convexity + TRS) failed at
Step 5: the Bregman normal direction does not in general equal the
supporting hyperplane direction at \(w^*(m)\). Searcher 03 surveyed
four special primitive islands and identified **binary state |Ω|=2**
as the only island that genuinely changes the type of the locked gate.
In binary, the original-message Hall lift becomes two scalar endpoint
transports on the real line — no multidimensional Bayes cones.

This pass attacks the gate-unlocking lemma identified by Searcher 03.

## Setup recap

**Binary state primitive (\(H_{bin}\))**:
- \(\Omega = \{0, 1\}\); beliefs \(\mu\in\Delta(\Omega)\) identified with
  \(\mu(1) \in [0,1]\). Source posterior \(s\in[0,1]\), distribution \(\tau\),
  \(M = \operatorname{supp}\tau\subseteq[0,1]\).
- \(A\), \(\Theta\) compact metric; \(u(a, \omega, \theta)\) bounded
  continuous in \(a\). \(\alpha\in(0,1)\) (the substantive regime; \(\alpha=0,1\)
  are degenerate peels).
- Paper Theorem 1: optimal \(\sigma^*\) is a TRS with **connected trust
  region** \(T\subseteq[0,1]\). Connected closed in \([0,1]\) means
  \(T = [L, R]\) for some \(0\le L \le R\le 1\).
- By paper Section 4.2 / Appendix A.6, misaligned adviser's optimal
  response in the smooth-density case has image only at the endpoints
  \(\{L, R\}\): high sources \(s > b\) (for some threshold \(b\)) route
  to \(L\), low sources \(s < b\) route to \(R\), in expectation.

## The lemma to prove

**Lemma B1 (Binary scalar endpoint-fiber lift).**

Let \(p\in[0,1]\), \(A_-\subseteq M\cap(-\infty, p]\), and \(S_+\subseteq M\cap[p, \infty)\)
be Borel. Let \(\alpha\in(0,1)\). Define finite positive measures on \(A_-\)
and \(S_+\) respectively:
\[
\eta(X) \;=\; \alpha\!\int_{X\cap A_-}\!(p - m)\,\tau(dm), \qquad \nu(Y) \;=\; (1-\alpha)\!\int_{Y\cap S_+}\!(s - p)\,\tau(ds).
\]

Assume the **total-balance condition**:
\[
\eta(A_-) \;=\; \nu(S_+) \;<\; \infty.
\]

**Claim 1 (existence of balanced coupling).** There exists a Borel
kernel \(\kappa: S_+\to\Delta(A_-)\) such that for every Borel
\(X\subseteq A_-\),
\[
(1-\alpha)\!\int_{S_+}\!(s - p)\,\kappa(X\mid s)\,\tau(ds) \;=\; \alpha\!\int_X\!(p - m)\,\tau(dm).
\]

**Claim 2 (posterior calibration).** Define the joint adversary law
\(\hat\beta(\cdot\mid s) = \kappa(\cdot\mid s)\) on \(S_+\) (and arbitrary
elsewhere). With \(\gamma_\alpha = \alpha\,(\mathrm{id},\mathrm{id})_\#\tau + (1-\alpha)\,\tau\otimes\hat\beta\)
and \(q := (\gamma_\alpha)_2\), the disintegration posterior on
\(\Omega = \{0, 1\}\) satisfies
\[
P_{\hat\beta}(\cdot\mid m) \;=\; p \;\equiv\; \delta_p \text{ in $\Delta(\Omega)$-coordinates}, \qquad \text{for $q$-a.e. $m\in A_-$.}
\]

**Claim 3 (symmetric version).** State and prove the symmetric
version on \(A_+\subseteq M\cap[p, \infty)\), \(S_-\subseteq M\cap(-\infty, p]\),
with the roles of \(\eta\) and \(\nu\) reversed.

## Why this is the gate-unlocking step

In v8 and Pass 3, the lift from payoff-label calibration to original-game
messagewise calibration required (D2)/menu-Hall — a multidimensional
transport problem that hits Borel→compact non-monotonicity, label-fiber
lift gaps, and slack discipline issues. In binary state, both fibers
\(A_-\) (left endpoint) and \(A_+\) (right endpoint) are 1-dimensional
subsets of \([0,1]\); the lift is a pair of 1D measure-coupling problems.
Standard tools (Kantorovich-Rubinstein, Strassen, even just standard
kernel disintegration on Polish spaces) should give existence
unconditionally.

## Proof outline

### Step 1 — Balance equation as a transport problem

Restate Claim 1 in transport form. Define probability measures
\(\bar\eta = \eta / \eta(A_-)\) on \(A_-\) and \(\bar\nu = \nu / \nu(S_+)\)
on \(S_+\). Since the total masses agree, any coupling
\(\gamma\in\Gamma(\bar\nu, \bar\eta)\) (joint law on \(S_+\times A_-\)
with marginals \(\bar\nu, \bar\eta\)) gives an admissible \(\kappa\)
via disintegration:
\[
\gamma(ds, dm) \;=\; \bar\nu(ds)\,\bar\kappa(dm\mid s), \qquad \kappa(dm\mid s) := \bar\kappa(dm\mid s).
\]
Verify the displayed balance identity reduces to "the coupling has
correct marginals after rescaling by \(s - p\) (resp.\ \(p - m\))".

**Tool**: standard coupling existence on Polish spaces (Kallenberg
*Foundations of Modern Probability* 1997, Thm 6.10, or
Aliprantis-Border Ch.19). Any coupling works; uniqueness not needed.

### Step 2 — Disintegrate to get \(\kappa\)

From the coupling \(\gamma\), disintegrate over its first marginal
\(\bar\nu\) (on a standard Borel space) to get a Borel kernel
\(\bar\kappa: S_+\to\Delta(A_-)\). Compose with the rescaling to
recover \(\kappa\) satisfying Claim 1.

**Subtlety**: the rescaling \(\nu / \tau = (1-\alpha)(s-p)\) is not a
probability density — it's a finite positive density. The kernel
\(\kappa\) satisfies the balance equation **including** the rescaling.
Spell this out carefully.

### Step 3 — Compute the posterior on \(\Omega\)

The joint measure on \((s, m, \omega) \in S_+\times A_-\times\Omega\)
under the adversary kernel decomposes as:
\[
\Pr(s, m, \omega) \;=\; \mu_0(\omega)\,\pi(s\mid\omega)\,\hat\beta(m\mid s).
\]
But more usefully, write the conditional posterior at message \(m\) using
the joint marginal law of \((s, m)\):

\[
P_{\hat\beta}(\omega = 1\mid m) \;=\; \frac{\alpha\,m\,\tau(\{m\})\,\mathbf{1}_{A_-}(m) + (1-\alpha)\!\int_{S_+}\!s\,\kappa(\{m\}\mid s)\,\tau(ds)}{\alpha\,\tau(\{m\})\,\mathbf{1}_{A_-}(m) + (1-\alpha)\!\int_{S_+}\!\kappa(\{m\}\mid s)\,\tau(ds)}.
\]

For \(\tau\) atomless OR for \(m\) outside \(M\), set things up with
densities or with Bayes' rule via Radon-Nikodym on the joint law over
\((s, m)\). In any case, the posterior at \(m\in A_-\) should equal
\(p\). Verify this calculation directly.

### Step 4 — Use the balance identity

From the balance identity (Claim 1) plus the definition of \(\eta\) on
\(A_-\):

\[
(1-\alpha)\!\int_{S_+}\!\kappa(X\mid s)(s - p)\,\tau(ds) \;=\; \alpha\!\int_X\!(p - m)\,\tau(dm)
\]

for every Borel \(X\subseteq A_-\). Rearranging:

\[
\alpha\!\int_X\!m\,\tau(dm) + (1-\alpha)\!\int_{S_+}\!\kappa(X\mid s)\,s\,\tau(ds) \;=\; p\,\Big[\alpha\!\int_X\!\tau(dm) + (1-\alpha)\!\int_{S_+}\!\kappa(X\mid s)\,\tau(ds)\Big].
\]

The LHS is the numerator of the posterior expectation \(\E[\omega = 1\mid m\in X]\)
under the joint law. The bracket on the RHS is the message marginal mass
\(q(X)\). Therefore \(\E[\omega = 1\mid m\in X] = p\) for every Borel
\(X\subseteq A_-\) with \(q(X) > 0\).

This is exactly "posterior at every left-fiber message equals \(p\)".

### Step 5 — Symmetric (Claim 3)

State and prove the symmetric \(A_+, S_-\) version. The argument is
identical with signs flipped: aligned mass on \(A_+\) with weight
\(\alpha(m - p)\), misaligned routing from \(S_-\) with weight
\((1-\alpha)(p - s)\). Balance \(\bar\eta_+(A_+) = \bar\nu_-(S_-)\)
gives a coupling, disintegration gives \(\kappa_R: S_-\to\Delta(A_+)\),
balance identity gives \(\E[\omega = 1\mid m\in X] = p\) for
\(X\subseteq A_+\). \(\square\)

## What I want you to produce

A FULLY RIGOROUS proof of Lemma B1, in the following structure:


# Lemma B1 — Binary scalar endpoint-fiber lift

## Statement (Claims 1, 2, 3)
(Restate exactly.)

## Hypotheses used
- p ∈ [0,1].
- A_-, S_+ Borel subsets of [0,1] (M is standard Borel).
- α ∈ (0,1).
- η(A_-) = ν(S_+) < ∞ (total-balance condition).
- τ is a Borel probability measure on M; NO atomlessness assumed; NO
  density assumed.

## Tools cited
- Disintegration on Polish spaces (Kallenberg 1997 Thm 6.10).
- Standard coupling existence (Aliprantis-Border Ch.19).
- Bayes' rule on finite state space + Radon-Nikodym.

## Proof
### Step 1 — Balance as transport
### Step 2 — Disintegrate
### Step 3 — Compute posterior
### Step 4 — Use balance identity
### Step 5 — Symmetric version

## Sanity check
Take τ = uniform on [0,1], p = 1/2, A_- = [0, 1/2], S_+ = [1/2, 1],
α = 1/2. Compute η, ν explicitly. Verify balance, exhibit a coupling
(e.g., the comonotone one), compute the posterior. Confirm it equals
1/2 on A_-.

## Compatibility with v8 sharpness package
The WTA ternary witness is multi-state |Ω|=3. Lemma B1 is binary
|Ω|=2 only. No conflict.

## Open issues
- Lemma B1 is the GATE for binary. Remaining lemmas in the 6-lemma
  binary chain: TRS interval reduction (Theorem 1, direct cite),
  endpoint-only adversarial image (Lemma 1 of paper Appendix A.6,
  needs nonsmooth extension), interior message calibration (free),
  endpoint stationarity (k≤2 Clarke-Danskin from T1 of v9), assemble
  β*, q-a.e. Bayes verification.


## Output Contract

- Inline as plain markdown.
- This is a CLEAN measure-theoretic lemma. The proof should be ~2-3 pages.
- Do NOT use atomless τ unless you must.
- Do NOT use smoothness or density of τ.
- Cite the standard tools precisely.
- End with a one-line verdict (PASS/PATCH_SMALL/PATCH_BIG/HOLD) on
  YOUR OWN work — but the actual review will be on a fresh reviewer
  chat. Plus a next-step signal for the next prover (which remaining
  lemma in the binary chain to attack).

## Constraints

- Banned re-proposals: see prior_attempts_digest.md.
- This lemma is genuinely new — it's not in v8 and not in the
  closure-memo Routes 1+2.
- Per user instruction: if the lemma fails, go back to the drawing
  board and try another angle. Do NOT stop.

Show more

========
ROLE: assistant (id=a7a4235e-e697-4d64-b99d-b95c3019d0e8)
========
Lemma B1 — Binary scalar endpoint-fiber lift

Two small formal patches are needed for literal correctness:

If the target fiber is empty and the common mass is zero, a kernel into Δ(∅) does not exist under the standard convention. The substantive case is common mass >0, or common mass =0 with nonempty target, or empty domain.

In Claim 2, “arbitrary elsewhere” cannot mean “may also route unrelated sources into A
−
	​

.” Extra traffic into A
−
	​

 can destroy the posterior. The proof uses the necessary no-extra-fiber-traffic convention: outside the source set being lifted, the adversary sends no signed mass into the target fiber, or only sends sources with posterior p, which are harmless.

With those two bookkeeping patches, the scalar lift works cleanly and uses no atomlessness, no density, and no smoothness.

The context is exactly the binary island: in the paper, binary beliefs are identified with [0,1], connected trust regions are intervals, and the misaligned adviser routes to interval endpoints by a threshold rule. 

Robust_trust_Dworczak_Smolin

 The paper also notes that in a TRE the Bayes-rule posterior and the trust-region projection must coincide on-path, which is exactly the calibration condition this lemma supplies on an endpoint fiber. 

Robust_trust_Dworczak_Smolin

Statement

Let p∈[0,1], A
−
	​

⊆M∩(−∞,p], and S
+
	​

⊆M∩[p,∞) be Borel. Let α∈(0,1). Define finite positive measures on A
−
	​

 and S
+
	​

:

η(X)=α∫
X∩A
−
	​

	​

(p−m)τ(dm),ν(Y)=(1−α)∫
Y∩S
+
	​

	​

(s−p)τ(ds).

Assume

η(A
−
	​

)=ν(S
+
	​

)<∞.

Claim 1. There exists a Borel kernel κ:S
+
	​

→Δ(A
−
	​

) such that for every Borel X⊆A
−
	​

,

(1−α)∫
S
+
	​

	​

(s−p)κ(X∣s)τ(ds)=α∫
X
	​

(p−m)τ(dm).

Claim 2. Define 
β
^
	​

(⋅∣s)=κ(⋅∣s) on S
+
	​

, with no extra signed traffic into A
−
	​

 from outside S
+
	​

. With

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

,q:=(γ
α
	​

)
2
	​

,

the binary posterior satisfies

P
β
^
	​

	​

(ω=1∣m)=pfor q-a.e. m∈A
−
	​

.

Equivalently, P
β
^
	​

	​

(⋅∣m)=(1−p,p)∈Δ({0,1}) for q-a.e. m∈A
−
	​

.

Claim 3. The symmetric right-fiber version holds for A
+
	​

⊆M∩[p,∞) and S
−
	​

⊆M∩(−∞,p], with weights α(m−p) on A
+
	​

 and (1−α)(p−s) on S
−
	​

.

Hypotheses used

p∈[0,1].

A
−
	​

, S
+
	​

, A
+
	​

, S
−
	​

 are Borel subsets of [0,1], hence standard Borel.

α∈(0,1).

τ is a Borel probability measure on M⊆[0,1].

No atomlessness, no density, no smoothness.

For posterior calibration, no unrelated source traffic is allowed into the endpoint fiber being calibrated.

Tools cited

Standard coupling existence on standard Borel spaces. In fact the product coupling is enough here.

Disintegration / regular conditional probabilities on standard Borel spaces, e.g. Kallenberg, Foundations of Modern Probability (1997), Theorem 6.10, or Aliprantis and Border, Infinite Dimensional Analysis, Chapter 19.

Radon-Nikodym Bayes rule on the finite state space Ω={0,1}.

Proof
Step 1 — Balance as transport

Write

c:=η(A
−
	​

)=ν(S
+
	​

).

When c>0, define probability measures

η
ˉ
	​

:=η/c∈Δ(A
−
	​

),
ν
ˉ
:=ν/c∈Δ(S
+
	​

).

Because A
−
	​

 and S
+
	​

 are standard Borel, at least one coupling exists. The product coupling

γ
ˉ
	​

(ds,dm):=
ν
ˉ
(ds)
η
ˉ
	​

(dm)

already does the job. More generally, any 
γ
ˉ
	​

∈Γ(
ν
ˉ
,
η
ˉ
	​

) works.

Disintegrate 
γ
ˉ
	​

 over its first marginal:

γ
ˉ
	​

(ds,dm)=
ν
ˉ
(ds)
κ
ˉ
(dm∣s),

where 
κ
ˉ
:S
+
	​

→Δ(A
−
	​

) is a Borel kernel. Put

κ:=
κ
ˉ
.

Then for every Borel X⊆A
−
	​

,

∫
S
+
	​

	​

κ(X∣s)ν(ds)=c∫
S
+
	​

	​

κ(X∣s)
ν
ˉ
(ds)=c
η
ˉ
	​

(X)=η(X).

Expanding η and ν gives exactly

(1−α)∫
S
+
	​

	​

(s−p)κ(X∣s)τ(ds)=α∫
X
	​

(p−m)τ(dm).

If c=0, then η=ν=0. If A
−
	​


=∅, choose any a
0
	​

∈A
−
	​

 and set κ(⋅∣s)=δ
a
0
	​

	​

 for all s∈S
+
	​

; both sides of the balance identity are zero. If S
+
	​

=∅, the empty-domain kernel is harmless. The only literal defect is c=0, S
+
	​


=∅, A
−
	​

=∅, where Δ(A
−
	​

) is empty.

This proves Claim 1, up to that empty-target convention.

Step 2 — Disintegration is the kernel

The preceding construction has already produced the required kernel. The important point is that κ is not transporting τ itself. It transports the tilted source measure

ν(ds)=(1−α)(s−p)1
S
+
	​

	​

(s)τ(ds)

to the tilted target measure

η(dm)=α(p−m)1
A
−
	​

	​

(m)τ(dm).

That tilt is the little hinge: the kernel may be arbitrary on ν-null source points, including s=p, because such sources contribute posterior p and create no calibration imbalance.

Step 3 — Compute the posterior by Radon-Nikodym Bayes rule

Let 
β
^
	​

 be a full adversary kernel on M satisfying

β
^
	​

(⋅∣s)=κ(⋅∣s)for s∈S
+
	​

,

and assume no extra signed traffic into A
−
	​

:

∫
M∖S
+
	​

	​

(s−p)
β
^
	​

(X∣s)τ(ds)=0for every Borel X⊆A
−
	​

.
(NE)

A sufficient simple version is 
β
^
	​

(A
−
	​

∣s)=0 for τ-a.e. s∈
/
S
+
	​

, except for sources with s=p, which are posterior-neutral.

Let

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


be the joint law of source posterior and message. Its second marginal is

q(X)=ατ(X)+(1−α)∫
M
	​

β
^
	​

(X∣s)τ(ds).

Define the finite measure n on messages by

n(X):=∫
M×X
	​

sγ
α
	​

(ds,dm).

Since s is the posterior probability of ω=1, n(X) is the joint probability of {ω=1, m∈X}. Also 0≤n≤q, so n≪q. Therefore

r(m):=
dq
dn
	​

(m)

is the Radon-Nikodym version of the posterior probability

r(m)=P
β
^
	​

	​

(ω=1∣m)q-a.e.

For a Borel X⊆A
−
	​

,

q(X)=ατ(X)+(1−α)∫
M
	​

β
^
	​

(X∣s)τ(ds),

and

n(X)=α∫
X
	​

mτ(dm)+(1−α)∫
M
	​

s
β
^
	​

(X∣s)τ(ds).

Subtract pq(X):

n(X)−pq(X)=α∫
X
	​

(m−p)τ(dm)+(1−α)∫
M
	​

(s−p)
β
^
	​

(X∣s)τ(ds).

Using (NE), this becomes

n(X)−pq(X)=−α∫
X
	​

(p−m)τ(dm)+(1−α)∫
S
+
	​

	​

(s−p)κ(X∣s)τ(ds).

By Claim 1, the two terms cancel. Hence

n(X)=pq(X)for every Borel X⊆A
−
	​

.

Equivalently,

∫
X
	​

(r(m)−p)q(dm)=0for every Borel X⊆A
−
	​

.

Therefore r(m)=p for q-a.e. m∈A
−
	​

. This proves Claim 2.

The proof is atom-blind: atoms simply contribute through the measures n and q. No pointwise density calculation is hiding in the bushes.

Step 4 — Same calculation in “conditional average” form

The same proof can be read as the setwise Bayes identity

α∫
X
	​

mτ(dm)+(1−α)∫
S
+
	​

	​

sκ(X∣s)τ(ds)=p[α∫
X
	​

τ(dm)+(1−α)∫
S
+
	​

	​

κ(X∣s)τ(ds)]

for all Borel X⊆A
−
	​

, again assuming no extra traffic into A
−
	​

. The left side is the state-1 numerator over the event m∈X; the bracket is the message probability q(X). So every positive-mass event inside the left endpoint fiber has average posterior p, and the Radon-Nikodym theorem upgrades this to q-a.e. messagewise calibration.

Step 5 — Symmetric right-fiber version

Let

A
+
	​

⊆M∩[p,∞),S
−
	​

⊆M∩(−∞,p]

be Borel. Define finite positive measures

η
+
	​

(X):=α∫
X∩A
+
	​

	​

(m−p)τ(dm),
ν
−
	​

(Y):=(1−α)∫
Y∩S
−
	​

	​

(p−s)τ(ds).

Assume

η
+
	​

(A
+
	​

)=ν
−
	​

(S
−
	​

)<∞.

Then, subject to the same empty-target convention, there exists a Borel kernel

κ
R
	​

:S
−
	​

→Δ(A
+
	​

)

such that for every Borel X⊆A
+
	​

,

(1−α)∫
S
−
	​

	​

(p−s)κ
R
	​

(X∣s)τ(ds)=α∫
X
	​

(m−p)τ(dm).
(R)

The construction is identical: normalize η
+
	​

 and ν
−
	​

 by their common mass and disintegrate any coupling, with the product coupling again sufficient.

Now define 
β
^
	​

(⋅∣s)=κ
R
	​

(⋅∣s) on S
−
	​

, with no extra signed traffic into A
+
	​

:

∫
M∖S
−
	​

	​

(s−p)
β
^
	​

(X∣s)τ(ds)=0for every Borel X⊆A
+
	​

.

For X⊆A
+
	​

, the same numerator-minus-p-denominator calculation gives

n(X)−pq(X)=α∫
X
	​

(m−p)τ(dm)+(1−α)∫
S
−
	​

	​

(s−p)κ
R
	​

(X∣s)τ(ds).

Since s−p=−(p−s) on S
−
	​

, equation (R) yields

n(X)−pq(X)=α∫
X
	​

(m−p)τ(dm)−(1−α)∫
S
−
	​

	​

(p−s)κ
R
	​

(X∣s)τ(ds)=0.

Thus

P
β
^
	​

	​

(ω=1∣m)=pfor q-a.e. m∈A
+
	​

.

This proves Claim 3.

Sanity check

Take τ uniform on [0,1], p=1/2,

A
−
	​

=[0,1/2],S
+
	​

=[1/2,1],α=1/2.

Then

η(dm)=
2
1
	​

(
2
1
	​

−m)1
[0,1/2]
	​

(m)dm,
ν(ds)=
2
1
	​

(s−
2
1
	​

)1
[1/2,1]
	​

(s)ds.

The common mass is

η(A
−
	​

)=ν(S
+
	​

)=
2
1
	​

∫
0
1/2
	​

(
2
1
	​

−m)dm=
2
1
	​

⋅
8
1
	​

=
16
1
	​

.

Use the equal-excess deterministic coupling

m=1−s.

That is,

κ(⋅∣s)=δ
1−s
	​

(⋅).

For every Borel X⊆[0,1/2],

2
1
	​

∫
1/2
1
	​

(s−
2
1
	​

)1
X
	​

(1−s)ds=
2
1
	​

∫
X
	​

(
2
1
	​

−m)dm=η(X),

where the change of variables is m=1−s. So the balance identity holds.

Now compute the posterior density at m∈[0,1/2]. The aligned component contributes message density 1/2 and state-1 numerator density (1/2)m. The misaligned component comes from s=1−m, contributes message density 1/2, and contributes state-1 numerator density (1/2)(1−m). Hence

q(dm)=1dm,

and

n(dm)=[
2
1
	​

m+
2
1
	​

(1−m)]dm=
2
1
	​

dm.

Therefore

P(ω=1∣m)=
dq
dn
	​

(m)=
2
1
	​

for Lebesgue-a.e. m∈[0,1/2].

The fiber is calibrated exactly at p=1/2.

Compatibility with v8 sharpness package

No conflict. The v8 sharpness obstruction is a ternary winner-takes-all construction with Ω={0,1,2}, and the no-free-dust theorem is explicitly a three-state vector-balance obstruction. 

project_closure_memo

 Lemma B1 is only the binary scalar case, where the Bayes-cone lift collapses to one-dimensional signed mass balance. The closure memo also classifies that ternary witness as a menu-engine artefact rather than a primitive counterexample to unrestricted Theorem 2. 

project_closure_memo

Open issues

Lemma B1 unlocks the binary endpoint-fiber transport gate, but only after the two small formal patches above.

Remaining binary-chain tasks: TRS interval reduction, endpoint-only adversarial image beyond the smooth-density exposition, interior message calibration, endpoint stationarity with k≤2 Clarke-Danskin, and assembly of β
∗
 with q-a.e. Bayes verification.

The next prover should attack the nonsmooth extension of Appendix A.6’s endpoint-only adversarial image, since B1 now supplies the scalar lift once the two endpoint masses are balanced.

Verdict: PATCH_SMALL. The scalar endpoint-fiber lift is correct and rigorous; the literal statement needs the empty-target convention and the no-extra-fiber-traffic clause for Claim 2.
