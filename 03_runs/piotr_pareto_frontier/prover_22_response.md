
========
ROLE: user (id=ef67008c-0966-4ad0-9b85-b0797bd1a69d)
========
# Prover pass 22 — P2* variable-margin weakening

## Role

You are the Prover. Targeted-weakening searcher identified **P2*
variable-margin** as the second-ranked weakening to attempt.

## What's being weakened

**Current P2***: uniform cone-margin $\eta > 0$ — there exists a
single positive constant $\eta$ such that every active vertex
$w_j\in C^*$ has Bayes cone $B_W(w_j)$ "wider than $\eta$" in a
precise sense.

**Target weakening (P2***-VM**): allow the margin to be a
Borel-measurable positive function $\eta(m): M\to(0,\infty)$,
strictly positive but not bounded below by a uniform constant.

## Lemma to prove (P2*-VM)

Under standing + |Ω|≥3 + α∈(0,1) + (P1) smooth strict-convex
utility + atomless τ + **(P2*-VM) Borel-positive cone-margin**
+ sufficient aligned baseline (in an integrated sense involving
$\eta(m)$), Theorem 2 holds.

## Proof structure

### Step 1 — Restate the cone-Hall dual under variable margin
The dual inequality $\Psi(y) \le 0$ now involves an integral against
$\eta(m)$ instead of uniform $\eta$. Verify the LP remains feasible
under the integrated condition.

### Step 2 — Tightness argument
Under atomless τ + Borel-positive $\eta$ + integrated aligned baseline,
the dual reaches its infimum. (Lyapunov / Dunford-Pettis tightness.)

### Step 3 — G3 biconditional applies
Pull back to G3: since Ψ(y) ≤ 0 holds, by G3 the calibrated kernel
exists.

### Step 4 — Verify economic content
Is "Borel-positive but not uniformly bounded" a meaningful weakening?
Concretely: economic models where the cone-margin shrinks to zero at
certain boundary points (e.g., the simplex boundary of Δ(Ω)) but
remains positive on the interior of M.

## What I want

Rigorous proof of P2*-VM, in the structure above. Critical questions:
- Does the integrated aligned-baseline condition replace the
  uniform-cone-margin lower bound cleanly?
- Or do we need an additional integrability hypothesis on $\eta(m)^{-1}$?

Output:

# Lemma P2*-VM (variable-margin)

## Statement
## Hypotheses
## Proof (Steps 1-4)
## Economic interpretation
## Compatibility with original P2*


End with verdict.

## Constraints

- Banned tools list applies.
- G3, L_B1 may be cited as proved.
- If the weakening requires recovering uniform-cone-margin from
  $\eta(m)^{-1}$ integrability, that's an honest failure — say so.

Show more

========
ROLE: assistant (id=c92ccc17-0180-415c-9948-8fa6e8cbe263)
========
I’ll audit the existing P2*/G3 cone-Hall proof rather than merely restate it, focusing on whether a positive Borel margin sustains feasibility without hidden 1/η control. The main risk I’ll test is whether tiny-margin regions cause dual-price escape despite the integrated baseline condition.

========
ROLE: assistant (id=7a52caa9-6b2c-45fd-b217-efd6fb931053)
========
A useful refinement is emerging: the variable margin can work with pointwise/local domination, such as a density cap controlled by η(m). A single averaged alignment surplus is too weak, since G3 allows Borel test prices to concentrate on bad thin regions.

========
ROLE: assistant (id=93f7e130-01e1-4bba-890e-37a4d62f66fb)
========
Lemma P2*-VM (variable-margin)
Statement

Let Ω be finite with ∣Ω∣≥3, α∈(0,1), and let the standing Robust Trust hypotheses hold. Fix a G2c/G3-admissible value-optimal payoff labeling

w
∗
:M→W
P
,

with rowwise-minimizer correspondence

G(s):={m∈M:s⋅w
∗
(m)=
z∈C
∗
min
	​

s⋅z},

and Bayes cone

B(m):=B
W
	​

(w
∗
(m))={μ∈Δ(Ω):w
∗
(m)∈arg
w∈W
max
	​

μ⋅w}.

Assume the variable cone-margin condition:

η:M→(0,∞)

is Borel and, for τ-a.e. m,

B
Δ
	​

(m,η(m))⊆B(m).
(VM)

Let D
Δ
	​

:=diam(Δ(Ω)) in the chosen norm.

Assume the variable aligned-baseline / bounded-jamming condition:

There exists a Borel kernel κ
0
	​

:M→Δ(M), supported on rowwise minimizers,

κ
0
	​

(G(s)∣s)=1τ-a.e.,

such that its target marginal

ρ(E):=∫
M
	​

κ
0
	​

(E∣s)τ(ds)

is absolutely continuous with respect to τ, with density

g(m):=
dτ
dρ
	​

(m),

and satisfies the pointwise variable-cap inequality

α+(1−α)g(m)
(1−α)g(m)
	​

D
Δ
	​

≤η(m)for τ-a.e. m.
(AB-VM)

Equivalently, whenever η(m)<D
Δ
	​

,

g(m)≤Γ
η
	​

(m):=
(1−α)(D
Δ
	​

−η(m))
αη(m)
	​

,
(Cap)

with no restriction needed at points where η(m)≥D
Δ
	​

. The earlier P2* package used a uniform cone-margin η>0 plus bounded rowwise jamming to force Ψ≤0; this statement replaces the uniform scalar by a variable capacity. The v9 record already places P2* under Reg plus density/domination of rowwise traffic, cone margin, bounded jamming, and sufficiently high aligned mass. 

v9_consolidated

Then Theorem 2’s existence direction holds in the G3 q-a.e. sense: there is an exact adversarial kernel β
∗
=κ
0
	​

 against the induced strategy σ
∗
(m)=ρ
W
	​

(w
∗
(m)), and

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
∗
	​

(⋅∣m))q
β
∗
	​

-a.e.
Hypotheses

Use:

Standing Robust Trust assumptions.

∣Ω∣≥3, α∈(0,1).

Smooth strict-convex / exposed-frontier primitives sufficient to supply Reg-1/Reg-2, or else Reg-1/Reg-2 directly. This is not cosmetic: v9 records that Reg-1/Reg-2 are not automatic from standing assumptions, and G3 is a fixed-label biconditional only under the regularity package. 

v9_consolidated

Atomless τ, if used upstream to select an exact-contact/value-optimal representative. The proof below does not use atomlessness once κ
0
	​

 and the density cap are given.

Borel-positive variable cone margin (VM).

Variable aligned-baseline / bounded-jamming condition (AB-VM).

Important orientation patch: the density needed here is g=dρ/dτ, i.e. the adversarial target marginal must be dominated by the truthful/aligned message law. The displayed v9 P2* snippet says ρ≪τ but then writes dτ/dρ≤C; the posterior-displacement calculation uses dρ/dτ≤C. I use the corrected domination direction.

Proof
Step 1 — Restate cone-Hall dual under variable margin

For a bounded Borel price

y:M→R
∣Ω∣
,

the G3 cone-Hall functional is

Ψ(y)=α∫
M
	​

[y(m)⋅m−h
B(m)
	​

(y(m))]τ(dm)+(1−α)∫
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
(1)

The G3 biconditional says, under Reg-1/Reg-2,

σ(w
∗
) is robustly rationalizable⟺Ψ(y)≤0∀ bounded Borel y.
(G3)

This is exactly the cone-Hall classification recorded in v9: calibrated adversarial kernels exist iff Ψ(y)≤0 for all Borel prices, under compact-regular hypotheses. 

v9_consolidated

Now plug in the candidate kernel κ
0
	​

. Since κ
0
	​

 is supported on G(s),

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
))]≤∫
M
	​

[y(m)⋅s−h
B(m)
	​

(y(m))]κ
0
	​

(dm∣s).

Thus it suffices to prove

A(y):=α∫
M
	​

[y(m)⋅m−h
B(m)
	​

(y(m))]τ(dm)+(1−α)∫
M
	​

∫
M
	​

[y(m)⋅s−h
B(m)
	​

(y(m))]κ
0
	​

(dm∣s)τ(ds)≤0.
(2)

Let

ρ(E)=∫
M
	​

κ
0
	​

(E∣s)τ(ds)

and define the adversarial vector numerator measure

ζ(E):=∫
M
	​

∫
E
	​

sκ
0
	​

(dm∣s)τ(ds).

Because s∈Δ(Ω), ζ≪ρ, and its Radon-Nikodym derivative

r(m):=
dρ
dζ
	​

(m)

lies in Δ(Ω) for ρ-a.e. m.

The mixture message marginal and vector numerator are

q=ατ+(1−α)ρ,
n(E)=α∫
E
	​

mτ(dm)+(1−α)ζ(E).

Since ρ≪τ with density g=dρ/dτ,

q(dm)=(α+(1−α)g(m))τ(dm),

and

n(dm)=(αm+(1−α)g(m)r(m))τ(dm).

Hence the posterior is

p(m):=
dq
dn
	​

(m)=
α+(1−α)g(m)
αm+(1−α)g(m)r(m)
	​

.
(3)

Therefore

p(m)−m=
α+(1−α)g(m)
(1−α)g(m)
	​

(r(m)−m).
(4)

Since both r(m) and m lie in Δ(Ω),

∥r(m)−m∥≤D
Δ
	​

.

By (AB-VM),

∥p(m)−m∥≤
α+(1−α)g(m)
(1−α)g(m)
	​

D
Δ
	​

≤η(m).
(5)

By (VM), p(m)∈B(m) for q-a.e. m. Thus

y(m)⋅p(m)≤h
B(m)
	​

(y(m))q-a.e.

Integrating,

A(y)=∫
M
	​

[y(m)⋅p(m)−h
B(m)
	​

(y(m))]q(dm)≤0.

Therefore Ψ(y)≤A(y)≤0 for all bounded Borel y. This proves the cone-Hall inequality.

So the “variable-margin dual” is not obtained by replacing a scalar η inside Ψ directly. Rather, η(m) creates a variable capacity cap on admissible adversarial target density g(m), and that cap forces every G3 dual price to be nonpositive. The little lever is (4): the posterior is a convex pull from truthful m toward adversarial barycenter r(m), and the pull coefficient is locally controlled by g(m).

Step 2 — Tightness / attainment under the integrated condition

If (AB-VM) is assumed as the existence of κ
0
	​

, no extra compactness argument is needed. We have already constructed the calibrated primal kernel.

If instead (AB-VM) is to be verified by finite-dimensional LP approximation, use the capacity form:

ρ(E)≤∫
E
	​

Γ
η
	​

(m)τ(dm)∀ Borel E⊆M.
(6)

Equivalently,

dτ
dρ
	​

≤Γ
η
	​

τ-a.e.

For a clean tightness theorem, impose the slightly stronger finite-capacity version: there exists an integrable Borel function

b
η
	​

∈L
1
(τ),0≤b
η
	​

≤Γ
η
	​

,
(7)

and the approximating target marginals satisfy

dτ
dρ
n
	​

	​

≤b
η
	​

.
(8)

Then the densities {dρ
n
	​

/dτ} are uniformly integrable. By Dunford-Pettis, they have weakly compact L
1
 subsequences. Since M⊆Δ(Ω) is compact in the Robust Trust setting and G has closed graph under Reg-1, the corresponding joint laws

π
n
	​

(ds,dm)=τ(ds)κ
n
	​

(dm∣s)

are tight, and any weak limit π remains supported on GrG. Disintegration gives

π(ds,dm)=τ(ds)κ(dm∣s),

with κ(G(s)∣s)=1 τ-a.e. The density cap is weakly closed under the L
1
-weak limit, so the limiting target marginal still satisfies dρ/dτ≤b
η
	​

≤Γ
η
	​

. The posterior calculation from Step 1 then applies to the limiting kernel.

This is precisely the compact-closed/no-escape style of G2c, which v9 records as avoiding the older Borel-to-compact deletion, cell-flow lift, and ε-net slack obstacles by working directly with measures on the graph and disintegrating the limiting law. 

v9_consolidated

No η
−1
 integrability appears. The compactness object is an upper capacity for adversarial target density, not the reciprocal margin. The right integrability hypothesis, when one wants compactness from approximation, is b
η
	​

∈L
1
(τ) with b
η
	​

≤Γ
η
	​

. The conservative sufficient cap

b
η
	​

(m):=
(1−α)D
Δ
	​

α
	​

η(m)
(9)

is always integrable because η(m)≤D
Δ
	​

 after truncation, and g≤b
η
	​

 implies (AB-VM).

Step 3 — G3 biconditional applies

By Step 1,

Ψ(y)≤0∀ bounded Borel y:M→R
∣Ω∣
.

By G3, under Reg-1/Reg-2, there exists a calibrated adversarial kernel supported on rowwise minimizers, and the induced posterior satisfies

P
γ
α
	​

	​

(⋅∣m)∈B(m)q-a.e.

In fact, the kernel is already κ
0
	​

. Since κ
0
	​

(G(s)∣s)=1, it is adversarial against σ
∗
, and because P
γ
α
	​

	​

(⋅∣m)∈B(m), the continuation 
σ
^
∗
(m)=ρ
W
	​

(w
∗
(m)) is Bayes-optimal q-a.e. This is the robust-rationalizability condition in the infinite-space reading. v9 explicitly records that G3’s reverse direction constructs such a Borel kernel and gives exact adversariality plus q-a.e. Bayes-optimality. 

v9_consolidated

Thus Theorem 2 holds for the P2*-VM class.

Step 4 — Verify economic content

P2*-VM is a real weakening. Uniform P2* requires

m
inf
	​

η(m)>0.

P2*-VM permits

m
inf
	​

η(m)=0,

as long as the adversarial target density g(m) decays fast enough near the thin-cone region.

Economically, this fits models where the agent is robustly comfortable with ordinary interior beliefs but becomes fragile near boundary beliefs. For example, in a multi-state diagnostic simplex, Bayes cones can narrow as reported beliefs approach the boundary: an almost-certain recommendation may leave very little room for adversarial contamination before the posterior crosses into another action’s Bayes cone. P2*-VM allows these boundary margins to shrink to zero, but it forces the adversary’s rowwise-minimizer traffic into those messages to shrink proportionally.

The condition says:

small cone margin at m⟹small admissible adversarial target density at m.

That is economically meaningful: extreme recommendations can remain in the message space, but they must be sufficiently protected by truthful/aligned mass relative to adversarial traffic. This is exactly the same “aligned baseline absorbs jamming” idea as P2*, but with a local safety budget instead of a single global safety budget. The v9 package already identifies P2* as a non-foliated primitive sufficient class in which high aligned mass plus bounded adversarial traffic absorbs jamming. 

v9_consolidated

What fails if the condition is only averaged?

A merely scalar condition such as

∫
M
	​

η(m)τ(dm)>c

does not suffice.

Reason: calibration is q-a.e. pointwise. If on a positive q-mass set E,

∥p(m)−m∥>η(m),

then p(m)∈
/
B(m) on a positive-measure subset. Since B(m) is closed convex, a measurable separating price y(m) can be chosen on that subset, and the G3 functional becomes positive on that localized test. The cone-Hall dual is a sniper, not a weather report: it can aim at thin bad sets. This is also why earlier smoothness-only candidates failed; the record notes that smoothness/strict convexity can supply regularity but does not itself prevent positive dual prices or construct the needed transport. 

searcher_07_response

So the valid “integrated” replacement is the measure-capacity inequality

ρ(E)≤∫
E
	​

Γ
η
	​

(m)τ(dm)∀E,

or equivalently the pointwise density cap g≤Γ
η
	​

 after Radon-Nikodym. A single global integral of η is not enough.

Economic interpretation

Under uniform P2*, every trusted message has the same protective moat. Under P2*-VM, the moat can become a rivulet near dangerous boundary beliefs. The proof still works because the adversary is forbidden from piling too much traffic exactly where the moat is thin.

Examples covered by P2*-VM but not uniform P2*:

Continuous diagnostic beliefs on intΔ(Ω) where the Bayes-cone margin shrinks as some state probability approaches 0.

Multi-action smooth problems where the optimal action changes sharply near a boundary face, but the signal distribution places little adversarially usable rowwise-minimizer traffic there.

“Extreme-confidence guardrail” designs: extreme reports remain allowed, but the calibrated adversarial flow into them must be locally capacity-controlled.

The class does not cover models where adversarial traffic has a density bounded below near a zero-margin boundary. In that case the posterior pull coefficient in (4) does not vanish with η(m), and calibration can fail.

Compatibility with original P2*

Original P2* is recovered by taking

η(m)≥η
0
	​

>0andg(m)≤C.

Then

α+(1−α)g(m)
(1−α)g(m)
	​

D
Δ
	​

≤
α+(1−α)C
(1−α)C
	​

D
Δ
	​

.

Thus the original uniform sufficient condition

α+(1−α)C
(1−α)C
	​

D
Δ
	​

≤η
0
	​


implies (AB-VM). So P2* is a special case of P2*-VM.

The weakening is strict: choose η(m)>0 with inf
m
	​

η(m)=0, and choose g(m)≤αη(m)/((1−α)D
Δ
	​

) with ∫gdτ=1. Then P2*-VM holds, while no uniform η
0
	​

>0 exists.

Answer to the critical questions

Does the integrated aligned-baseline condition replace the uniform lower bound cleanly?

Yes, if “integrated” means a Borel capacity domination:

ρ(E)≤∫
E
	​

Γ
η
	​

dτ∀E,

or equivalently dρ/dτ≤Γ
η
	​

 τ-a.e. This is a local/integrated measure condition, not a single averaged scalar.

No, if “integrated” means only ∫ηdτ is large. Averages do not prevent a positive-measure bad set where the posterior exits B(m).

Do we need an additional integrability hypothesis on η
−1
?

No. The proof never uses η
−1
. The adversarial density must instead be upper-bounded by a function proportional to η near zero-margin regions. If one wants compactness of approximating LPs, require an integrable upper capacity b
η
	​

≤Γ
η
	​

, not η
−1
∈L
1
.

Verdict: PASS, with one important precision: P2*-VM is valid under a pointwise/every-Borel-set variable capacity condition on the adversarial target marginal. A mere global average margin is not enough.
