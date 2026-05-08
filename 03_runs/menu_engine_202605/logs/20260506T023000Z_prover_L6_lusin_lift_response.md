
========
ROLE: user (id=259b5b81-0f8d-4cab-b3d5-24bb0a81cf68)
========
# Prover pass — L6: Lift to measurable deviations (the core Phil-Lusin contradiction)

You are the Prover in the soft-scaffolding workflow.

## Goal for this pass

Establish **L6** of phil_reny_route_memo.md: any unrestricted
measurable adversarial deviation $\beta\in B$ that beats the
restricted-game value $V^* = \inf_\varphi U_F(\sigma^*,\varphi) = \max_\sigma\inf_\varphi U_F(\sigma,\varphi)$
can be **converted** into a $\tau$-dominated $\varphi\in F$ that beats
the same $V^*$, contradicting L3+L4.

Combined with L1-L5, this gives that $\sigma^*$ (after Lusin
modification) **secures the value $V^*$ against all unrestricted
measurable adviser strategies** — i.e., $\inf_{\beta\in B} U(\beta,\sigma^*) \ge V^*$.

This is the **core new step** in Phil's argument. Do it carefully.

## Inputs

- phil_reny_route_memo.md — live route memo. **L1–L5, L7 PROVED**
  (L5 conditional on (A5)).
- phil_reny_bundle.md — Phil's email contains the contradiction sketch.
- prior_attempts_digest.md — dead routes (don't invoke).
- Paper PDF.

## Target

**L6 (Lusin lift contradiction).** Under standing hypotheses + (A5):
For any measurable $\beta\in B$ and any $\varepsilon>0$, there exists a
$\tau$-dominated $\varphi_\varepsilon\in F$ with

$$
U(\beta,\sigma^*) \;\ge\; U_F(\sigma^*,\varphi_\varepsilon) - \varepsilon.
$$

Consequently, since $U_F(\sigma^*,\varphi_\varepsilon) \ge V^*$ for every
$\varphi_\varepsilon\in F$ (by L3+L4 saying $\sigma^*$ achieves
$\max_\sigma\inf_\varphi U_F$), we get $U(\beta,\sigma^*) \ge V^* - \varepsilon$
for every $\varepsilon$, hence $U(\beta,\sigma^*) \ge V^*$.

Equivalently and more memorably: **$\sigma^*$ secures the value $V^*$
against all unrestricted measurable adversaries.**

## Argument structure (for guidance, NOT to copy verbatim)

Phil's email gives a contrapositive argument: assume $d:M\to M$
measurable with $U(\delta_d,\sigma^*) < V^*$, derive a contradiction.
The same idea works for general kernels $\beta$ via measurable selection
or by directly constructing the τ-dominated approximation.

Two-case structure (after the L5 modification of $\sigma^*$ off $K^*$):

**Case A — deviation supported off $K^*$.** If $\beta$ sends mass into
$M\setminus K^*$ from messages $s$, then since $\sigma^*$ is constant on
$M\setminus K^*$ (= $\sigma_0^*(\cdot\mid m_0,\theta)$), the corresponding
$U$-contribution is the same as using $m_0$ as the message — which is
also achievable via a $\tau$-dominated $\varphi$ (e.g., approximate Dirac
at $m_0$ within $K^*$).

**Case B — deviation supported in $K^*$.** Then for $\pi(\cdot\mid\omega)$-a.e.
$s$, $\beta(\cdot\mid s)$ puts mass in some $K_n$. Use Lusin continuity
of $\sigma^*\restriction K_n$ + support-thickness to construct
$\varphi_\varepsilon$ as follows: for each $s$, replace the kernel
$\beta(\cdot\mid s)$ by a $\tau$-dominated density supported in a
neighborhood $O_\varepsilon(s)$ of $\beta$'s effective image, where
$\sigma^*$ is approximately constant. Specifically, if
$\beta(\cdot\mid s) = \delta_{d(s)}$ for some $d(s)\in K_n$, take
$\varphi_\varepsilon(m\mid s) = \mathbf 1_{O_\varepsilon(d(s))\cap K_n}(m) / \tau(O_\varepsilon(d(s))\cap K_n)$,
which is $\tau$-dominated (well-defined by support-thickness:
$\tau(O_\varepsilon(d(s))\cap K_n)>0$). For non-Dirac $\beta$, integrate.

## Subquestions you MUST address

1. **Reduction of stochastic kernels to measurable maps.** The argument
   above is cleanest for $\beta(\cdot\mid s) = \delta_{d(s)}$ (Dirac
   kernels, equivalent to measurable maps $d:M\to M$). Show that the
   inf $\inf_{\beta\in B} U(\beta,\sigma^*)$ is unchanged if we
   restrict to deterministic kernels — OR show that the lift argument
   works for general $\beta$ via Tonelli without going through Dirac.
   (Hint: $U$ is affine in $\beta$, so $\inf_\beta U = \inf_d U|_{\text{Diracs}}$
   if $\sigma^*$ doesn't see "shape" of $\beta$ beyond its image
   distribution.)
2. **Approximation precision.** Pick the right neighborhood structure on
   $K_n$. Since $K_n$ is compact metric, use balls of radius $\varepsilon$
   (in any compatible metric on $M$, e.g., total-variation on $\Delta(\Omega)$).
   Use the Lusin continuity of $\hat\sigma^*$ on $K_n$ (private-strategy
   topology = continuity of $m\mapsto[\theta\mapsto\hat\sigma^*(\cdot\mid m,\theta)]$
   into the Balder stable space $Y$) to bound the payoff difference.
3. **Pointwise vs uniform.** The Lusin continuity is uniform on each
   compact $K_n$ (continuous functions on compact metric spaces are
   uniformly continuous). Use this to get a *uniform* $\varepsilon$-bound
   across $s\in K_n$.
4. **Measurable selection of $\varphi_\varepsilon$.** $\varphi_\varepsilon(m\mid s)$
   defined pointwise must be **jointly measurable** in $(m,s)$. Justify
   the joint measurability — possibly by noting that the radius-$\varepsilon$
   ball in a compact metric space is a closed (hence Borel) function of
   the center, so the indicator is jointly measurable.
5. **What about $s\in M\setminus K^*$?** Since $\pi(M\setminus K^*\mid\omega) = 0$,
   the integral over $s$ doesn't see this set. But $\varphi_\varepsilon(\cdot\mid s)$
   must still be defined for τ-a.e. $s$. Set it arbitrarily on $M\setminus K^*$
   (e.g., to a fixed reference density). Verify the integrand is
   τ-integrable.
6. **Stitching across $n$.** For deviation $d:M\to M$ with $d(s)$ varying
   across $K_n$ for different $s$, you may need to choose $n = n(s)$
   measurably. Use that $K_n\uparrow K^*$ to handle.
7. **Stochastic case.** If you reduce to Dirac kernels in subquestion 1,
   confirm the reduction is rigorous. Otherwise, repeat the construction
   integrating against the kernel measure.

## Output Format


markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: L6 — Lusin lift contradiction

**Claim:** (Restate L6 with all hypotheses, including (A5).)

**Argument:**

Step 1: (Reduction to deterministic / Dirac kernels, if applicable.)
Justification: ...

Step 2: (For deterministic $d$ supported in $K^*$, construct
$\varphi_\varepsilon$ neighborhood-by-neighborhood.)
Justification: ...

Step 3: (Verify joint measurability of $\varphi_\varepsilon$.)
Justification: ...

Step 4: (Bound the payoff difference $|U(\delta_d,\sigma^*) - U_F(\sigma^*,\varphi_\varepsilon)|$
using Lusin uniform continuity on $K_n$.)
Justification: ...

Step 5: (Handle $d$ off $K^*$ via the modification.)
Justification: ...

Step 6: (Lift to general $\beta\in B$ if step 1 used a reduction.)
Justification: ...

[DERIVED] (State exactly what was established.)

### Target 2: Subquestion answers

(Crisp paragraph for each of subquestions 1–7.)

## Assumption Changes

- [ASSUMPTION+] / [ASSUMPTION-] (only if necessary)

## Breakdown Amendments

- [BREAKDOWN_AMEND] (only if route memo needs repair)

## Status Summary

- L6 status: PROVED / PROVED-CONDITIONAL / FALSE-AS-STATED.

## Exact Next Obstacle

(Should be the **Branch A capstone consolidator**: assemble
"$\sigma^*$ secures $V^*$ against all measurable $\beta\in B$" from
L1+L2+L3+L4+L5+L6+L7, identifying $V^* = U^*$ as the unrestricted-game
value. Or, if more is needed to identify $V^*$ with $U^*$, surface that
as a missing lemma. After this, Branch A is complete and Branch B (L8
adversary attainment) becomes the only remaining task.)


## Non-Negotiable Rules

- The two-case structure (Case A: off $K^*$; Case B: in $K^*$) should be
  explicit.
- Every measurability claim needs a one-sentence justification.
- Use the (A5)-driven support-thickness from L5 — do not assume more.
- Do not invoke any of the dead-route machinery in
  prior_attempts_digest.md.
- Length budget: 2500–4000 words. L6 is a long lemma; this is a
  legitimately hard step.

## Scope Policy

One target per pass. **Do not** attempt L8 (adversary $\beta^*$
attainment) or L9 (per-message Bayes-optimality). Those are Branch B.
After L6 is reviewer-cleared, the next pass is the Branch A consolidator.


========
ROLE: assistant (id=ca256fdc-36cf-4ee2-900d-28ac4f874325)
========
Goal for This Pass

This pass proves L6: the Lusin-thick modification of the restricted-game optimizer σ
∗
 secures the restricted value V
∗
 not only against τ-dominated restricted deviations, but against every measurable adviser kernel β∈B. The route memo already fixes the restricted class F, the Lusin-thick compacts K
n
	​

↑K
∗
, and the off-K
∗
 modification of σ
∗
; Phil’s email supplies the underlying Lusin idea; the paper’s Appendix A.2 is the finite saddle-point benchmark being replaced here. 

phil_reny_route_memo

 

phil_reny_bundle

 

Robust_trust_Dworczak_Smolin

 The prior-attempts digest is used only as a guardrail: no dead-route compactness or adversary-attainment machinery is invoked. 

prior_attempts_digest

Main Work
Target 1: L6 - Lusin lift contradiction

Claim: Under the standing hypotheses plus (A5), and after the L5 modification of σ
∗
 off K
∗
, for every measurable adviser kernel β∈B and every ε>0, there exists a τ-dominated φ
ε
	​

∈F such that

U(β,σ
∗
)≥U
F
	​

(σ
∗
,φ
ε
	​

)−ε.

Consequently,

β∈B
inf
	​

U(β,σ
∗
)≥V
∗

where

V
∗
=
φ∈F
inf
	​

U
F
	​

(σ
∗
,φ)=
σ
max
	​

φ∈F
inf
	​

U
F
	​

(σ,φ).

The objective statement and route memo identify this as the Branch A value-securing step for the infinite-M, infinite-Θ extension. 

objective_statement

 

phil_reny_route_memo

Argument:

Step 1: Direct stochastic-kernel lift, no deterministic reduction needed.

For each state ω, define the bounded message payoff induced by σ
∗
:

p
ω
	​

(m):=∫
Θ
	​

∫
A
	​

u(a,ω,θ)σ
∗
(da∣m,θ)f(dθ∣ω).

Let H:=sup∣u∣<∞. Then ∣p
ω
	​

(m)∣≤H. The aligned part of the payoff is the same for U(β,σ
∗
) and U
F
	​

(σ
∗
,φ), so only the misaligned term matters:

C(β):=
ω
∑
	​

μ
0
	​

(ω)∫
M
	​

∫
M
	​

p
ω
	​

(y)β(dy∣s)π(ds∣ω).

If φ∈F, write

C(φ):=
ω
∑
	​

μ
0
	​

(ω)∫
M
	​

∫
M
	​

p
ω
	​

(z)φ(z∣s)τ(dz)π(ds∣ω).

Then

U(β,σ
∗
)−U
F
	​

(σ
∗
,φ)=(1−α)(C(β)−C(φ)).

Measurability justification: p
ω
	​

 is Borel because σ
∗
 is a measurable kernel and u is bounded Borel in (ω,θ) and continuous in a; kernel integration preserves measurability.

Step 2: Use Lusin uniform continuity on each compact K
n
	​

.

Fix a compatible metric d on M, for instance total variation inherited from the finite-dimensional simplex Δ(Ω). By L5, on each compact K
n
	​

, the private-strategy map

m↦
σ
^
∗
(m)

is continuous in the Balder stable private-strategy topology. Since f(⋅∣ω)≪
f
ˉ
	​

 and the test

(θ,a)↦u(a,ω,θ)
d
f
ˉ
	​

df(⋅∣ω)
	​

(θ)

is bounded measurable in θ and continuous in a, the functional 
σ
^
↦p
ω
	​

 is continuous in that topology. Hence each p
ω
	​

↾K
n
	​

 is continuous, and since K
n
	​

 is compact, it is uniformly continuous.

Let η:=ε. Since Ω is finite, for every n choose ρ
n
	​

>0 such that

y,z∈K
n
	​

,d(y,z)<ρ
n
	​

⟹
ω∈Ω
max
	​

∣p
ω
	​

(z)−p
ω
	​

(y)∣≤η.

Pick m
0
	​

∈K
∗
, and let n
0
	​

 be such that m
0
	​

∈K
n
0
	​

	​

. Choose ρ
0
	​

>0 such that

z∈K
n
0
	​

	​

,d(z,m
0
	​

)<ρ
0
	​

⟹
ω∈Ω
max
	​

∣p
ω
	​

(z)−p
ω
	​

(m
0
	​

)∣≤η.

Measurability justification: no selection is being made here; the radii are deterministic constants chosen countably many times, one for each compact K
n
	​

.

Step 3: Build a measurable local smoothing kernel Q
ε
	​

(dz∣y) dominated by τ.

Set K
0
	​

:=∅ and define the Borel shells

D
n
	​

:=K
n
	​

∖K
n−1
	​

,n≥1.

The sets D
n
	​

 are disjoint and ⋃
n
	​

D
n
	​

=K
∗
. Define a density q
ε
	​

(z∣y) with respect to τ(dz) as follows.

Case A: target message y∈
/
K
∗
.
Because of the L5 off-K
∗
 modification,

σ
∗
(⋅∣y,θ)=σ
∗
(⋅∣m
0
	​

,θ)

for all y∈
/
K
∗
. Hence p
ω
	​

(y)=p
ω
	​

(m
0
	​

). Set

q
ε
	​

(z∣y):=
τ(K
n
0
	​

	​

∩B(m
0
	​

,ρ
0
	​

))
1
K
n
0
	​

	​

∩B(m
0
	​

,ρ
0
	​

)
	​

(z)
	​

.

The denominator is positive by the L5 support-thickness property applied at m
0
	​

∈K
n
0
	​

	​

: K
n
0
	​

	​

∩B(m
0
	​

,ρ
0
	​

) is a relative open neighborhood of m
0
	​

 in K
n
0
	​

	​

, so it has positive π(⋅∣ω)-mass for every ω, hence positive τ-mass.

Case B: target message y∈K
∗
.
There is a unique shell D
n
	​

 with y∈D
n
	​

. Set

a
n
	​

(y):=τ(K
n
	​

∩B(y,ρ
n
	​

))

and

q
ε
	​

(z∣y):=
a
n
	​

(y)
1
K
n
	​

∩B(y,ρ
n
	​

)
	​

(z)
	​

.

Again a
n
	​

(y)>0 by L5 support-thickness, because K
n
	​

∩B(y,ρ
n
	​

) is a relative open neighborhood of y in K
n
	​

.

Thus, for every y∈M, q
ε
	​

(⋅∣y) is a probability density with respect to τ.

Measurability justification: K
∗
 is Borel as a countable union of compacts, each shell D
n
	​

 is Borel, (y,z)↦1
{z∈K
n
	​

, d(y,z)<ρ
n
	​

}
	​

 is Borel, and y↦a
n
	​

(y)=∫1
{z∈K
n
	​

, d(y,z)<ρ
n
	​

}
	​

τ(dz) is Borel by kernel integration. Therefore q
ε
	​

 is jointly Borel on M×M.

Step 4: Verify the pointwise payoff approximation.

For y∈D
n
	​

⊂K
n
	​

, the support of q
ε
	​

(⋅∣y) is contained in K
n
	​

∩B(y,ρ
n
	​

). Therefore

	​

∫
M
	​

p
ω
	​

(z)q
ε
	​

(z∣y)τ(dz)−p
ω
	​

(y)
	​

≤η

for every ω.

For y∈
/
K
∗
, the support of q
ε
	​

(⋅∣y) is contained in K
n
0
	​

	​

∩B(m
0
	​

,ρ
0
	​

), and p
ω
	​

(y)=p
ω
	​

(m
0
	​

). Therefore the same estimate holds:

	​

∫
M
	​

p
ω
	​

(z)q
ε
	​

(z∣y)τ(dz)−p
ω
	​

(y)
	​

≤η.

This is exactly the two-case Phil-Lusin mechanism: inside K
∗
, use Lusin continuity shell-by-shell; outside K
∗
, the modification turns every off-K
∗
 report into the fixed m
0
	​

-behavior, then approximates m
0
	​

 from within a thick compact.

Step 5: Compose the local smoothing with the arbitrary stochastic kernel β.

Define

φ
	​

ε
	​

(z∣s):=∫
M
	​

q
ε
	​

(z∣y)β(dy∣s).

This is the density of the following τ-dominated kernel:

β
φ
ε
	​

	​

(dz∣s)=∫
M
	​

Q
ε
	​

(dz∣y)β(dy∣s),Q
ε
	​

(dz∣y)=q
ε
	​

(z∣y)τ(dz).

Measurability justification: q
ε
	​

 is jointly Borel and β is a measurable kernel, so (z,s)↦∫q
ε
	​

(z∣y)β(dy∣s) is jointly measurable.

Tonelli gives, for every s,

∫
M
	​

φ
	​

ε
	​

(z∣s)τ(dz)=∫
M
	​

(∫
M
	​

q
ε
	​

(z∣y)τ(dz))β(dy∣s)=1.

If 
φ
	​

ε
	​

 is infinite on a τ-null set for some s, replace its infinite values by 0. Since its τ-integral is 1, the infinite set is τ-null for each s, so this finite Borel modification preserves the normalization. Denote the resulting finite density by φ
ε
	​

. Then φ
ε
	​

∈F.

Integrability justification: ∣p
ω
	​

∣≤H, β and Q
ε
	​

 are probability kernels, and π(⋅∣ω) is a probability measure, so every displayed integral is absolutely bounded by H.

Step 6: Bound the payoff difference.

Using Tonelli and the definition of φ
ε
	​

,

C(φ
ε
	​

)−C(β)=
ω
∑
	​

μ
0
	​

(ω)∫
M
	​

∫
M
	​

[∫
M
	​

p
ω
	​

(z)q
ε
	​

(z∣y)τ(dz)−p
ω
	​

(y)]β(dy∣s)π(ds∣ω).

The bracketed term is bounded in absolute value by η=ε, uniformly in s,y,ω. Hence

∣C(φ
ε
	​

)−C(β)∣≤
ω
∑
	​

μ
0
	​

(ω)ε=ε.

Therefore

∣U
F
	​

(σ
∗
,φ
ε
	​

)−U(β,σ
∗
)∣=(1−α)∣C(φ
ε
	​

)−C(β)∣≤ε.

In particular,

U(β,σ
∗
)≥U
F
	​

(σ
∗
,φ
ε
	​

)−ε.

This proves the claimed lift inequality.

Since σ
∗
 attains the restricted maximin value,

U
F
	​

(σ
∗
,φ
ε
	​

)≥
φ∈F
inf
	​

U
F
	​

(σ
∗
,φ)=V
∗

for every φ
ε
	​

∈F. Hence

U(β,σ
∗
)≥V
∗
−ε.

Because ε>0 and β∈B were arbitrary,

β∈B
inf
	​

U(β,σ
∗
)≥V
∗
.

[DERIVED] Under standing hypotheses plus (A5), after the L5 Lusin modification, σ
∗
 secures the restricted-game value V
∗
 against every unrestricted measurable adviser kernel β∈B.

Target 2: Subquestion answers

1. Reduction of stochastic kernels to measurable maps.
No deterministic reduction is used. The construction works directly for arbitrary stochastic β by composing β(dy∣s) with the local τ-dominated smoothing kernel Q
ε
	​

(dz∣y). Tonelli justifies integrating the pointwise approximation over y∼β(⋅∣s). For deterministic deviations d:M→M, this specializes to φ
ε
	​

(z∣s)=q
ε
	​

(z∣d(s)).

2. Approximation precision.
The approximation is made in the payoff coordinates p
ω
	​

. L5 gives continuity of m↦
σ
^
∗
(m) into the Balder stable private-strategy space on each K
n
	​

; the finite family of payoff functionals p
ω
	​

 is continuous in that topology. Compactness of K
n
	​

 gives radii ρ
n
	​

 with a uniform ε-payoff bound on K
n
	​

∩B(y,ρ
n
	​

).

3. Pointwise vs uniform.
The proof uses uniform continuity on each compact K
n
	​

, not merely pointwise continuity. Since Ω is finite, one radius ρ
n
	​

 works simultaneously for all states ω on that K
n
	​

.

4. Measurable selection of φ
ε
	​

.
No point selector is needed. The kernel is defined by normalized relative balls. Joint measurability follows because (y,z)↦1
{z∈K
n
	​

, d(y,z)<ρ
n
	​

}
	​

 is Borel, the normalizing denominator is a Borel function of y, and countable shellwise pasting preserves Borel measurability.

5. What about s∈M∖K
∗
?
Source messages s∈
/
K
∗
 are invisible to payoffs because π(K
∗
∣ω)=1 for every ω, hence also τ(K
∗
)=1. Nevertheless φ
ε
	​

(⋅∣s) is defined for every s by the same formula ∫q
ε
	​

(⋅∣y)β(dy∣s), and boundedness of u plus normalization of φ
ε
	​

 gives integrability.

6. Stitching across n.
The measurable shell index is handled by D
n
	​

=K
n
	​

∖K
n−1
	​

. If the adversarial target y∈K
∗
, then y∈D
n
	​

 for exactly one n, and the proof uses the radius ρ
n
	​

 and the set K
n
	​

∩B(y,ρ
n
	​

). The shell sets are Borel, so the stitched density is jointly measurable.

7. Stochastic case.
The stochastic case is the main proof. The local smoothing kernel Q
ε
	​

(dz∣y) is first built for each possible target y, including the off-K
∗
 case. Then any stochastic β(dy∣s) is smoothed by integration. Affineness is used only to write the payoff difference as the integral of the pointwise errors, and Tonelli supplies the legitimate interchange of s,y,z.

Assumption Changes

[ASSUMPTION+] None beyond the already adopted (A5) from L5.

[ASSUMPTION-] None.

Breakdown Amendments

[BREAKDOWN_AMEND] None. L6 works with the existing L5 support-thick compact sequence and the off-K
∗
 modification.

Status Summary

L6 status: PROVED under standing hypotheses plus (A5). Relative to the original standing hypotheses alone, the Branch A package remains conditional on (A5), exactly as L5 does.

Exact Next Obstacle

The next pass should be the Branch A capstone consolidator. It should assemble the value sandwich:

σ
sup
	​

β∈B
inf
	​

U(β,σ)≤
σ
max
	​

φ∈F
inf
	​

U
F
	​

(σ,φ)=V
∗

because F⊆B, while L6 gives

β∈B
inf
	​

U(β,σ
∗
)≥V
∗
.

Thus V
∗
=U
∗
, and σ
∗
 is optimal in the unrestricted measurable-kernel game. After that, Branch A is complete; Branch B remains the separate problem of producing an adversarial minimizer β
∗
 and proving per-message Bayes-optimality.
