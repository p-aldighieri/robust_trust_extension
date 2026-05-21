
========
ROLE: user (id=b559557e-9081-4a3c-9756-7aab76a476b1)
========
# Prover pass 02 — Lemmas 7 and 8: Fermat stationarity → Calibration is the multiplier

## Role

You are the Prover for a smart-scaffolding proof project. You have just
read the verified Lemma 6 (Integral Clarke-Danskin representation) and
its PATCH_SMALL reviewer note (durable sources prover_01_response.md
and reviewer_01_response.md). Your job in this pass is to prove the
two **load-bearing** lemmas of the route:

- **Lemma 7**: Clarke Fermat rule yields normal-cone stationarity
  \(g\in N_{W^k}(\bar w)\), equivalently \(g_i\in N_W(w_i)\) for every \(i\).
- **Lemma 8**: The Clarke multipliers from Lemma 6 are exactly the
  **calibration kernel** — the integrand multipliers \(\lambda^-(s)\),
  with appropriate normalization, deliver the calibrated adversarial
  posterior at every active payoff label.

Lemma 8 is the hinge of the entire route: it converts the abstract
Fermat normality of \(g_i\) into a concrete Bayes-calibration statement
\(p_i\in N_W(w_i)\cap\Delta(\Omega)\), which is Pareto-Hall calibration
at each finite payoff label.

## Patched Lemma 6 (the form to cite downstream)

The reviewer's small patch replaces the equality version of L5 in
Step 2 with the inclusion form. The patched Lemma 6 conclusion is
**unchanged**, but the proof's intermediate object is the **larger**
active-weight correspondence
\[
R(s) \;:=\; \alpha\,\operatorname{co}\big\{e_i\otimes s : i\in I_+(s)\big\} \;+\; (1-\alpha)\,\operatorname{co}\big\{e_i\otimes s : i\in I_-(s)\big\},
\]
where \(I_+(s) := \arg\max_j s\!\cdot w_j\), \(I_-(s) := \arg\min_j s\!\cdot w_j\),
and \(e_i\otimes s\in(\R^N)^k\) is zero except in the \(i\)-th block.
Clarke's sum rule gives only \(\Psi(s)\subseteq R(s)\); equality may
fail at ties (reviewer's k=2, N=1 example shows this). The Aumann
integration is on \(R(s)\), and the conclusion is the same.

**For all downstream uses (Lemmas 7-8), treat Lemma 6 as:** *every
\(g\in\partial_C F_k(\bar w)\) admits Borel \(\lambda^\pm:M\to\Delta(k)\)
with \(\operatorname{supp}\lambda^+(s)\subseteq I_+(s)\) and
\(\operatorname{supp}\lambda^-(s)\subseteq I_-(s)\) τ-a.e., and
\(g_i = \alpha\!\int\lambda_i^+(s)s\,\tau(ds) + (1-\alpha)\!\int\lambda_i^-(s)s\,\tau(ds)\).*

## Lemma 7 — Clarke Fermat normal-cone stationarity

**Hypotheses.** \(W\) closed convex compact in \(\R^N\) (paper Lemma 2
of Theorem 1). \(\bar w = (w_1,\ldots,w_k)\in W^k\) is an **ambient
local maximizer** of \(F_k\) over \(W^k\) — i.e., there is an open
neighborhood \(U\) of \(\bar w\) in \((\R^N)^k\) such that \(F_k(\bar w)\ge F_k(\bar v)\)
for every \(\bar v\in U\cap W^k\). (Frontier-local maximality lifts to
ambient by L3, which you may assume; see breakdown.)

**Statement.** There exists \(g = (g_1,\ldots,g_k)\in\partial_C F_k(\bar w)\)
such that
\[
g \;\in\; N_{W^k}(\bar w) \;=\; \prod_{i=1}^k N_W(w_i).
\]
Equivalently, \(g_i\in N_W(w_i)\) for every \(i\).

**Tools.** Clarke's Fermat rule for constrained local optima: if \(f\)
is locally Lipschitz and \(x_0\in C\) is a local minimum of \(f\) on
\(C\) with \(C\) closed convex, then \(0\in\partial_C f(x_0) + N_C(x_0)\).
Convex normal cone calculus on product sets. Apply to \(-F_k\)
minimized over \(W^k\).

**Proof outline.** Apply Clarke's necessary condition for
\(-F_k\) at the local max \(\bar w\) on \(W^k\). Use
\(\partial_C(-F_k) = -\partial_C F_k\) (true for locally Lipschitz
functions). Product formula \(N_{W^k}(\bar w) = \prod_i N_W(w_i)\)
(true for any product of closed convex sets, since the normal cone of
a product is the product of normal cones).

## Lemma 8 — Clarke multipliers ARE the calibration kernel

**Hypotheses.** Lemmas 6 and 7 hold. \(\bar w\) is an ambient local
maximizer.

**Statement.** Let \(g\in\partial_C F_k(\bar w)\) be the normal
subgradient delivered by Lemma 7, with measurable multiplier
decomposition \(\lambda^\pm:M\to\Delta(k)\) per (patched) Lemma 6.

For each \(i\in\{1,\ldots,k\}\), define
\[
q_i \;:=\; \alpha\!\int_M\lambda_i^+(s)\,\tau(ds) \;+\; (1-\alpha)\!\int_M\lambda_i^-(s)\,\tau(ds).
\]

(a) **Mass balance.** \(\sum_i q_i = 1\); each \(q_i\ge 0\).

(b) **Normalized multiplier is a posterior.** When \(q_i>0\), define
\[
p_i \;:=\; \frac{g_i}{q_i} \;=\; \frac{\alpha\int\lambda_i^+(s)\,s\,\tau(ds) + (1-\alpha)\int\lambda_i^-(s)\,s\,\tau(ds)}{q_i}.
\]
Then \(p_i\in\Delta(\Omega)\) (probability vector on the state space).

(c) **Calibration.** \(p_i\in N_W(w_i)\cap\Delta(\Omega) = B_W(w_i)\)
(the Bayes-optimality cone of \(W\) at \(w_i\); cf. L1).

(d) **Kernel realization.** Define the original-game adversarial
kernel on payoff labels as
\[
\hat\kappa(\{i\}\mid s) \;:=\; \lambda_i^-(s).
\]
Define the message-marginal in payoff-label coordinates as
\[
\tilde q(\{i\}) \;:=\; q_i \;=\; \alpha\!\int_M\lambda_i^+(s)\,\tau(ds) + (1-\alpha)\!\int_M\lambda_i^-(s)\,\tau(ds).
\]
Define the joint source-label distribution
\[
\tilde\gamma_\alpha \;:=\; \alpha\sum_i\!\int_M\lambda_i^+(s)\,\tau(ds)\otimes\delta_i \;+\; (1-\alpha)\sum_i\!\int_M\lambda_i^-(s)\,\tau(ds)\otimes\delta_i,
\]
i.e., the law of \((s, I)\) where \(s\sim\tau\) and \(I\mid s\) is
distributed as \(\lambda^+\) (with weight \(\alpha\)) or \(\lambda^-\)
(with weight \(1-\alpha\)). Then the disintegration of \(\tilde\gamma_\alpha\)
over its second marginal \(\tilde q\) yields the posterior
\[
P_{\tilde\gamma_\alpha}(\cdot\mid i) \;=\; p_i \;\in\; B_W(w_i) \;=\; N_W(w_i)\cap\Delta(\Omega) \quad \tilde q\text{-a.e. }i.
\]

**Tools.** Lemma 6 (multiplier representation), Lemma 7 (Fermat
stationarity), L1 (\(N_W(w)\cap\Delta(\Omega) = B_W(w)\); cite without
re-proving). Standard Bayes-rule + disintegration on a finite state
space.

**Proof outline.** Direct computation. Mass balance follows from
\(\sum_i\lambda_i^\pm(s) = 1\) τ-a.e. and Fubini. Posterior in
simplex follows because numerator is nonneg with \(\sum_\omega [p_i]_\omega = 1\)
(use \(s\in\Delta(\Omega)\) and definition of \(q_i\)). Calibration
\(p_i\in N_W(w_i)\) follows because \(g_i\in N_W(w_i)\) by Lemma 7 and
\(p_i\) is a positive rescaling of \(g_i\); \(N_W(w_i)\) is a cone, so
positive scalar multiplication preserves membership.

**Kernel realization** is the cleanest interpretation: the
multipliers \(\lambda^\pm\) define a joint distribution \(\tilde\gamma_\alpha\)
on \(M\times\{1,\ldots,k\}\), and Bayes' rule on this finite-state-space
disintegration yields exactly \(p_i\).

## What I want you to produce

Produce **two rigorous proofs**, in the following structure:


# Lemmas 7 and 8 — Fermat stationarity + Calibration is the multiplier

## Lemma 7 — Clarke Fermat normal-cone stationarity

### Statement
(Restate exactly.)

### Hypotheses used
(Standing + ambient local maximality of w̄ on W^k.)

### Proof
- Step 1: Cite Clarke's necessary condition for −F_k on W^k.
  Verify hypotheses: W^k closed convex (product), F_k locally Lipschitz
  (Lemma 2 / L2).
- Step 2: Apply, obtain 0 ∈ ∂_C(−F_k)(w̄) + N_{W^k}(w̄). Equivalently,
  ∂_C F_k(w̄) ∩ (−N_{W^k}(w̄)) ≠ ∅. Since N_{W^k}(w̄) is a closed convex
  cone, this gives g ∈ ∂_C F_k(w̄) with g ∈ N_{W^k}(w̄) (after the
  sign convention).
- Step 3: Use the product normal cone formula N_{W^k}(w̄) = ∏_i N_W(w_i).
  Conclude g_i ∈ N_W(w_i) for every i.

(Cite Clarke 1983 Optimization and Nonsmooth Analysis Thm 6.1.1 or
equivalent; cite Rockafellar 1970 §16 for the product normal cone formula.)

### Sanity check
Take k=1: ambient local max of F_1(w) = α s·w + (1-α) s·w = s·w
(degenerate; take a non-degenerate F_k with k≥2 if needed). Verify
g_i ∈ N_W(w_i) in a simple binary example.

## Lemma 8 — Calibration is the multiplier

### Statement
(Restate exactly.)

### Hypotheses used
(Lemmas 6 patched + 7.)

### Proof
- Step 1 (mass balance). ∑_i q_i = α + (1-α) = 1; each q_i ≥ 0.
- Step 2 (posterior in simplex). Show p_i has nonneg components
  summing to 1. Use ∑_ω [p_i]_ω · q_i = ∑_ω g_i(ω) =
  ∑_ω [α∫λ_i^+(s)s(ω)dτ + (1-α)∫λ_i^-(s)s(ω)dτ] = (α+(1-α)) q_i = q_i
  (since s∈Δ(Ω) ⇒ ∑_ω s(ω) = 1, and ∫λ_i^±(s)dτ contributes to q_i).
- Step 3 (calibration). Since g_i ∈ N_W(w_i) (Lemma 7) and N_W(w_i)
  is a convex cone (closed under positive scalar mult), p_i = g_i / q_i
  ∈ N_W(w_i) ∩ Δ(Ω) = B_W(w_i) (by L1) whenever q_i > 0.
- Step 4 (kernel realization). Define the finite-label adversarial
  kernel κ̂(·|s) := λ^-(s) and the label-marginal q̃. Disintegrate
  γ̃_α over its second marginal. Compute the conditional barycenter
  formula and identify it as p_i = g_i / q_i. Verify the joint law
  is well-defined (Borel measurability of λ^±) and that disintegration
  on finite spaces is automatic.

### Sanity check
For k=2, N=2, w_1=(1,0), w_2=(0,1), α=1/2, τ uniform on Δ — using the
multipliers from Lemma 6's sanity check, compute q_1, q_2, p_1, p_2
explicitly. Verify p_i ∈ B_W(w_i) (e.g., p_1 puts more weight on ω=1
since w_1 dominates in coord 1).

## Conclusion

State the **finite-menu Pareto-Hall calibration theorem** as the
combined conclusion of Lemmas 6, 7, 8:

> Let C* = {w_1, ..., w_k} ⊂ W^P be a Pareto-completed local maximizer
> of F_k. Then there exist measurable adversarial weights λ^-:M → Δ(k)
> with supp λ^-(s) ⊆ I_-(s), such that the induced finite-label
> message marginal q̃ and the induced posterior p_i = g_i/q_i satisfy
> p_i ∈ B_W(w_i) for every i with q_i > 0.

State that the route to robust rationalizability for finite-label
menus is now complete modulo Lemmas 1-5 (which are standard), Lemma
3 (ambientization certificate via paper Lemma 2 of Theorem 1), and
the original-message lift (Lemma 12 / downstream).

## Open issues remaining
- Original-message lift (Lemma 12): finitely many payoff labels need
  to be lifted to original messages m ∈ M via the labeling w*:M → C*.
  This is a separate measurable-selection step.
- Lift to compact C*: extending from finite to compact menus via
  stratified Gauss-map regularity / Painlevé-Kuratowski stability.
- Compatibility with v8 sharpness package: verify the finite-menu
  theorem does not contradict Lemma 7 (cone intersection) + Theorem 8
  (no-free-dust) in the WTA ternary witness.


## Output Contract

- Return everything inline in this chat as plain markdown.
- Stick to the section ordering above.
- Be rigorous about Step 3 of Lemma 8 (the calibration claim). The
  proof that p_i = g_i/q_i ∈ N_W(w_i) is the LOAD-BEARING step of
  the entire route. Spell it out completely:
  - g_i ∈ N_W(w_i) ⇔ ∀v ∈ W, v·(v - w_i) ≤ 0 (wait, ∀v∈W, g_i · (v - w_i) ≤ 0)? No: normal cone condition is g_i · (v - w_i) ≤ 0 for all v ∈ W. Confirm the sign.
  - p_i = g_i / q_i, so g_i = q_i p_i. For q_i > 0, p_i · (v - w_i) ≤ 0 for all v ∈ W. Equivalently, p_i ∈ N_W(w_i).
  - p_i ∈ Δ(Ω) (Step 2 of Lemma 8) + p_i ∈ N_W(w_i) ⇒ p_i ∈ B_W(w_i).
- DO NOT skip checking the **sign convention** (Clarke Fermat gives g
  with what sign? The Lemma 7 statement should be unambiguous.) Be
  pedantic.
- DO NOT silently use atomlessness, smoothness, or genericity.
- DO NOT extend to general compact C* in this pass — stay finite-menu.

## Constraints

- Banned re-proposals: see prior_attempts_digest.md.
- Stay focused on Lemmas 7 and 8. If a tangential issue appears in
  Lemma 6 or in L1-L5 that you cannot ignore, flag it.
- After the proofs, write a one-paragraph **next-step signal**: which
  Lemma the next prover should attack (likely L9-L11 to wrap up the
  finite-menu capstone), or whether the next move is the original-
  message lift / general-compact lift.

Show more

========
ROLE: assistant (id=c8c10f36-1a4b-4d49-9d8f-c2ab4c040c9d)
========
Lemmas 7 and 8 — Fermat stationarity + Calibration is the multiplier

The proof below uses the patched Lemma 6 exactly as the reviewer requested: the pointwise equality version is not used at ties; downstream we only need the final measurable multiplier representation, which the PATCH_SMALL note preserves. 

reviewer_01_response

 The payoff-profile facts about W, W
P
, and Bayes cones are the paper Lemma 2 package: W is compact convex, W
P
 is the weak Pareto frontier, and frontier profiles are Bayes-optimal for some belief. 

piotr_pareto_frontier_route_memo

Lemma 7 — Clarke Fermat normal-cone stationarity
Statement

Let W⊂R
N
 be closed, convex, and compact. Let

w
ˉ
=(w
1
	​

,…,w
k
	​

)∈W
k

be an ambient local maximizer of F
k
	​

 over W
k
, meaning that there is an open neighborhood U of 
w
ˉ
 in (R
N
)
k
 such that

F
k
	​

(
w
ˉ
)≥F
k
	​

(
v
ˉ
)for every 
v
ˉ
∈U∩W
k
.

Assume F
k
	​

 is locally Lipschitz on (R
N
)
k
. Then there exists

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
)

such that

g∈N
W
k
	​

(
w
ˉ
)=
i=1
∏
k
	​

N
W
	​

(w
i
	​

).

Equivalently,

g
i
	​

∈N
W
	​

(w
i
	​

)for every i=1,…,k.

Here the normal cone convention is

N
W
	​

(w):={η∈R
N
:η⋅(v−w)≤0 for every v∈W}.
Hypotheses used

We use:

W is closed and convex, hence W
k
 is closed and convex.

F
k
	​

 is locally Lipschitz. This follows from the finite max-min form of F
k
	​

, since each s∈Δ(Ω) has bounded norm.

w
ˉ
 is an ambient local maximizer of F
k
	​

 on W
k
, not merely a frontier-local maximizer on (W
P
)
k
. The breakdown explicitly makes ambient local maximality load-bearing for this lemma. 

breakdown_01_response

Proof

Step 1: Convert the constrained local maximum into a constrained local minimum.

Since 
w
ˉ
 is a local maximizer of F
k
	​

 over W
k
, it is a local minimizer of

f:=−F
k
	​


over W
k
. The function f is locally Lipschitz because F
k
	​

 is locally Lipschitz.

Apply Clarke’s Fermat rule for constrained local minima over closed convex sets, for example Clarke, Optimization and Nonsmooth Analysis, Theorem 6.1.1:

0∈∂
C
	​

f(
w
ˉ
)+N
W
k
	​

(
w
ˉ
).

With f=−F
k
	​

, this becomes

0∈∂
C
	​

(−F
k
	​

)(
w
ˉ
)+N
W
k
	​

(
w
ˉ
).

Step 2: Check the sign convention carefully.

For locally Lipschitz functions,

∂
C
	​

(−F
k
	​

)(
w
ˉ
)=−∂
C
	​

F
k
	​

(
w
ˉ
).

Therefore there exist g∈∂
C
	​

F
k
	​

(
w
ˉ
) and n∈N
W
k
	​

(
w
ˉ
) such that

0=−g+n.

Hence

g=n∈N
W
k
	​

(
w
ˉ
).

This is the important sign point. With the normal cone convention

N
C
	​

(x)={η:η⋅(y−x)≤0 ∀y∈C},

the Clarke condition for maximizing F
k
	​

 gives

g∈+N
W
k
	​

(
w
ˉ
),

not −N
W
k
	​

(
w
ˉ
). In the differentiable case this reduces to the familiar condition

∇F
k
	​

(
w
ˉ
)⋅(
v
ˉ
−
w
ˉ
)≤0∀
v
ˉ
∈W
k
,

which is exactly ∇F
k
	​

(
w
ˉ
)∈N
W
k
	​

(
w
ˉ
).

Step 3: Product normal cone formula.

We prove the product identity directly. Let

g=(g
1
	​

,…,g
k
	​

)∈(R
N
)
k
.

By definition,

g∈N
W
k
	​

(
w
ˉ
)

iff

i=1
∑
k
	​

g
i
	​

⋅(v
i
	​

−w
i
	​

)≤0∀(v
1
	​

,…,v
k
	​

)∈W
k
.

If g∈N
W
k
	​

(
w
ˉ
), fix an index i and set v
j
	​

=w
j
	​

 for all j

=i. Then

g
i
	​

⋅(v
i
	​

−w
i
	​

)≤0∀v
i
	​

∈W,

so g
i
	​

∈N
W
	​

(w
i
	​

).

Conversely, if g
i
	​

∈N
W
	​

(w
i
	​

) for every i, then for every 
v
ˉ
∈W
k
,

g
i
	​

⋅(v
i
	​

−w
i
	​

)≤0for each i,

and summing gives

i=1
∑
k
	​

g
i
	​

⋅(v
i
	​

−w
i
	​

)≤0.

Thus g∈N
W
k
	​

(
w
ˉ
).

Therefore

N
W
k
	​

(
w
ˉ
)=
i=1
∏
k
	​

N
W
	​

(w
i
	​

),

which is the standard product normal-cone formula for closed convex product sets, also found in Rockafellar’s convex analysis normal-cone calculus.

Combining Step 2 and Step 3 gives

g
i
	​

∈N
W
	​

(w
i
	​

)∀i.

This proves Lemma 7. □

Sanity check

For k=1,

F
1
	​

(w)=∫
M
	​

s⋅wτ(ds)=
s
ˉ
⋅w,
s
ˉ
:=∫
M
	​

sτ(ds).

If w is a local maximizer of this linear functional over W, then for every v∈W,

s
ˉ
⋅(v−w)≤0.

Thus 
s
ˉ
∈N
W
	​

(w), exactly as Lemma 7 says. In a binary square example W=[0,1]
2
, if 
s
ˉ
=(1/2,1/2), the maximizer is w=(1,1), and N
W
	​

(1,1)=R
≥0
2
	​

, so 
s
ˉ
∈N
W
	​

(w). The sign is not a decorative choice here; it is the whole compass.

Lemma 8 — Calibration is the multiplier
Statement

Assume Lemmas 6 and 7 hold. Let 
w
ˉ
=(w
1
	​

,…,w
k
	​

)∈W
k
 be an ambient local maximizer. Let

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
)∩N
W
k
	​

(
w
ˉ
)

be the normal Clarke subgradient delivered by Lemma 7. Let λ
±
:M→Δ(k) be a measurable multiplier decomposition of this same g, as delivered by the patched Lemma 6:

suppλ
+
(s)⊆I
+
	​

(s),suppλ
−
(s)⊆I
−
	​

(s)τ-a.e.,

where

I
+
	​

(s):=arg
j
max
	​

s⋅w
j
	​

,I
−
	​

(s):=arg
j
min
	​

s⋅w
j
	​

,

and

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

For each i, define

q
i
	​

:=α∫
M
	​

λ
i
+
	​

(s)τ(ds)+(1−α)∫
M
	​

λ
i
−
	​

(s)τ(ds).

Then:

(a) Mass balance.

q
i
	​

≥0∀i,
i=1
∑
k
	​

q
i
	​

=1.

(b) Normalized multiplier is a posterior. If q
i
	​

>0, define

p
i
	​

:=
q
i
	​

g
i
	​

	​

=
q
i
	​

α∫
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
	​

.

Then

p
i
	​

∈Δ(Ω).

(c) Calibration.
If q
i
	​

>0, then

p
i
	​

∈N
W
	​

(w
i
	​

)∩Δ(Ω)=B
W
	​

(w
i
	​

).

(d) Kernel realization. Define the finite payoff-label adversarial kernel

κ
^
({i}∣s):=λ
i
−
	​

(s).

Define the finite-label message marginal

q
~
	​

({i}):=q
i
	​

.

Define the joint source-label distribution 
γ
~
	​

α
	​

 on M×{1,…,k} by

γ
~
	​

α
	​

(A×{i}):=α∫
A
	​

λ
i
+
	​

(s)τ(ds)+(1−α)∫
A
	​

λ
i
−
	​

(s)τ(ds)

for Borel A⊆M. Equivalently, s∼τ, and conditional on s, the label I is drawn from λ
+
(s) with weight α, or from λ
−
(s) with weight 1−α.

Then the disintegration of 
γ
~
	​

α
	​

 over its second marginal 
q
~
	​

, interpreted as a conditional barycenter over the state simplex, yields

P
γ
~
	​

α
	​

	​

(⋅∣i)=p
i
	​

∈B
W
	​

(w
i
	​

)

for every i with q
i
	​

>0, equivalently 
q
~
	​

-a.e. i.

Hypotheses used

We use:

Patched Lemma 6: the normal subgradient g chosen in Lemma 7 admits measurable active weights λ
±
. The reviewer patch says to use the larger active-weight correspondence R(s), not the false equality form at ties; the final conclusion of Lemma 6 is unchanged. 

reviewer_01_response

Lemma 7: the same g satisfies

g
i
	​

∈N
W
	​

(w
i
	​

)∀i.

L1: for w∈W,

B
W
	​

(w)=N
W
	​

(w)∩Δ(Ω).

s∈Δ(Ω) τ-a.e., so s
ω
	​

≥0 and ∑
ω
	​

s
ω
	​

=1.

λ
±
(s)∈Δ(k), so λ
i
±
	​

(s)≥0 and ∑
i
	​

λ
i
±
	​

(s)=1.

No atomlessness, no smoothness, and no generic no-tie assumption is used. The tie weights are the little finite-dimensional gears doing the work.

Proof

Step 1: Mass balance.

For every i,

q
i
	​

=α∫
M
	​

λ
i
+
	​

(s)τ(ds)+(1−α)∫
M
	​

λ
i
−
	​

(s)τ(ds)≥0

because λ
i
±
	​

(s)≥0.

Since λ
+
(s),λ
−
(s)∈Δ(k),

i=1
∑
k
	​

λ
i
+
	​

(s)=1,
i=1
∑
k
	​

λ
i
−
	​

(s)=1

for τ-a.e. s. Therefore, by finite summation and Fubini,

i=1
∑
k
	​

q
i
	​

=α∫
M
	​

i=1
∑
k
	​

λ
i
+
	​

(s)τ(ds)+(1−α)∫
M
	​

i=1
∑
k
	​

λ
i
−
	​

(s)τ(ds).

Thus

i=1
∑
k
	​

q
i
	​

=α∫
M
	​

1τ(ds)+(1−α)∫
M
	​

1τ(ds)=α+(1−α)=1.

This proves (a).

Step 2: The normalized multiplier is in the simplex.

Fix i. For each state ω∈Ω,

[g
i
	​

]
ω
	​

=α∫
M
	​

λ
i
+
	​

(s)s
ω
	​

τ(ds)+(1−α)∫
M
	​

λ
i
−
	​

(s)s
ω
	​

τ(ds).

Because λ
i
±
	​

(s)≥0 and s
ω
	​

≥0,

[g
i
	​

]
ω
	​

≥0.

Hence g
i
	​

∈R
≥0
N
	​

.

Now sum over ω:

ω∈Ω
∑
	​

[g
i
	​

]
ω
	​

=α∫
M
	​

λ
i
+
	​

(s)
ω∈Ω
∑
	​

s
ω
	​

τ(ds)+(1−α)∫
M
	​

λ
i
−
	​

(s)
ω∈Ω
∑
	​

s
ω
	​

τ(ds).

Since s∈Δ(Ω),

ω∈Ω
∑
	​

s
ω
	​

=1.

Therefore

ω∈Ω
∑
	​

[g
i
	​

]
ω
	​

=α∫
M
	​

λ
i
+
	​

(s)τ(ds)+(1−α)∫
M
	​

λ
i
−
	​

(s)τ(ds)=q
i
	​

.

If q
i
	​

>0, then

p
i
	​

:=
q
i
	​

g
i
	​

	​


has nonnegative components and

ω∈Ω
∑
	​

[p
i
	​

]
ω
	​

=
q
i
	​

1
	​

ω∈Ω
∑
	​

[g
i
	​

]
ω
	​

=1.

Thus

p
i
	​

∈Δ(Ω).

This proves (b).

If q
i
	​

=0, the same calculation gives ∑
ω
	​

[g
i
	​

]
ω
	​

=0 with g
i
	​

≥0, hence g
i
	​

=0. There is then no positive-mass label posterior to normalize.

Step 3: Calibration from normality.

This is the load-bearing step.

By Lemma 7,

g
i
	​

∈N
W
	​

(w
i
	​

).

By the normal cone convention,

g
i
	​

∈N
W
	​

(w
i
	​

)⟺g
i
	​

⋅(v−w
i
	​

)≤0∀v∈W.

Equivalently,

∀v∈W,g
i
	​

⋅(v−w
i
	​

)≤0.

Now suppose q
i
	​

>0. Since

p
i
	​

=
q
i
	​

g
i
	​

	​

,

we have for every v∈W,

p
i
	​

⋅(v−w
i
	​

)=
q
i
	​

1
	​

g
i
	​

⋅(v−w
i
	​

)≤0,

because q
i
	​

>0. Therefore

p
i
	​

∈N
W
	​

(w
i
	​

).

Step 2 already proved

p
i
	​

∈Δ(Ω).

Hence

p
i
	​

∈N
W
	​

(w
i
	​

)∩Δ(Ω).

By L1,

N
W
	​

(w
i
	​

)∩Δ(Ω)=B
W
	​

(w
i
	​

),

where

B
W
	​

(w
i
	​

):={μ∈Δ(Ω):w
i
	​

∈arg
v∈W
max
	​

μ⋅v}.

Thus

p
i
	​

∈B
W
	​

(w
i
	​

).

This proves (c).

Step 4: Kernel realization and Bayes-rule calculation.

Define

κ
^
({i}∣s)=λ
i
−
	​

(s).

Because λ
−
:M→Δ(k) is Borel and the label space is finite, 
κ
^
 is a Borel Markov kernel from M to {1,…,k}. Its support is active-adversarial:

supp
κ
^
(⋅∣s)=suppλ
−
(s)⊆I
−
	​

(s)=arg
j
min
	​

s⋅w
j
	​


for τ-a.e. s.

Define 
γ
~
	​

α
	​

 by

γ
~
	​

α
	​

(A×{i})=α∫
A
	​

λ
i
+
	​

(s)τ(ds)+(1−α)∫
A
	​

λ
i
−
	​

(s)τ(ds).

Its total mass is

i=1
∑
k
	​

γ
~
	​

α
	​

(M×{i})=
i=1
∑
k
	​

q
i
	​

=1,

so 
γ
~
	​

α
	​

 is a probability measure. Its second marginal is exactly

q
~
	​

({i})=
γ
~
	​

α
	​

(M×{i})=q
i
	​

.

Now compute the conditional state posterior at a label i. Since s∈Δ(Ω) is itself a posterior over Ω, the induced state-label joint law is

Γ
α
	​

({ω}×{i})=α∫
M
	​

λ
i
+
	​

(s)s
ω
	​

τ(ds)+(1−α)∫
M
	​

λ
i
−
	​

(s)s
ω
	​

τ(ds).

The numerator is exactly [g
i
	​

]
ω
	​

. Therefore, when q
i
	​

>0,

P
γ
~
	​

α
	​

	​

(ω∣i)=
q
~
	​

({i})
Γ
α
	​

({ω}×{i})
	​

=
q
i
	​

[g
i
	​

]
ω
	​

	​

=[p
i
	​

]
ω
	​

.

Since this holds for every ω,

P
γ
~
	​

α
	​

	​

(⋅∣i)=p
i
	​

.

By Step 3,

p
i
	​

∈B
W
	​

(w
i
	​

)

for every i with q
i
	​

>0. Labels with q
i
	​

=0 are irrelevant for 
q
~
	​

-a.e. statements. This proves (d).

Lemma 8 is proved. □

Sanity check

Take k=2, N=2,

w
1
	​

=(1,0),w
2
	​

=(0,1),

and s=(p,1−p) with p∼Unif(0,1). The Lemma 6 sanity check uses

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


and

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


The tie point is irrelevant for Lebesgue τ. Compute

I
−
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

),

and

I
+
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

Then

g
1
	​

=αI
+
+(1−α)I
−
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
+(1−α)I
+
=(
8
3−2α
	​

,
8
1+2α
	​

).

Also

q
1
	​

=q
2
	​

=
2
1
	​

.

Thus

p
1
	​

=
q
1
	​

g
1
	​

	​

=(
4
1+2α
	​

,
4
3−2α
	​

),

and

p
2
	​

=
q
2
	​

g
2
	​

	​

=(
4
3−2α
	​

,
4
1+2α
	​

).

At the requested α=1/2,

p
1
	​

=p
2
	​

=(
2
1
	​

,
2
1
	​

).

For W=co{w
1
	​

,w
2
	​

}, the Bayes cone at w
1
	​

 is

B
W
	​

(w
1
	​

)={p∈Δ({1,2}):p
1
	​

≥p
2
	​

},

and the Bayes cone at w
2
	​

 is

B
W
	​

(w
2
	​

)={p∈Δ({1,2}):p
2
	​

≥p
1
	​

}.

At α=1/2, both labels are tied at the prior (1/2,1/2), so both calibration conditions hold with equality. If α>1/2, then p
1
	​

 puts strictly more mass on state 1, and p
2
	​

 puts strictly more mass on state 2, as the intuition predicts.

Conclusion

Finite-menu Pareto-Hall calibration theorem. Let

C
∗
={w
1
	​

,…,w
k
	​

}⊂W
P

be a Pareto-completed finite ambient local maximizer of

F
k
	​

(w
1
	​

,…,w
k
	​

)=∫
M
	​

[α
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

]τ(ds).

Then there exist Borel measurable active weights

λ
+
:M→Δ(k),λ
−
:M→Δ(k),

with

suppλ
+
(s)⊆arg
i
max
	​

s⋅w
i
	​

,suppλ
−
(s)⊆arg
i
min
	​

s⋅w
i
	​


for τ-a.e. s, such that

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

(s)sτ(ds)∈N
W
	​

(w
i
	​

)

for every i. Defining

q
i
	​

=α∫
M
	​

λ
i
+
	​

(s)τ(ds)+(1−α)∫
M
	​

λ
i
−
	​

(s)τ(ds),

we have, for every i with q
i
	​

>0,

p
i
	​

:=
q
i
	​

g
i
	​

	​

∈B
W
	​

(w
i
	​

)=N
W
	​

(w
i
	​

)∩Δ(Ω).

Thus the finite-label adversarial kernel

κ
^
({i}∣s)=λ
i
−
	​

(s)

and the aligned tie-routing weights λ
i
+
	​

(s) induce finite-label posteriors p
i
	​

 that are Bayes-calibrated at every positive-mass payoff label. This is exactly the finite-menu Pareto-Hall calibration conclusion.

The route to robust rationalizability for finite-label menus is now complete modulo Lemmas 1-5, Lemma 3’s ambientization certificate via the paper’s Lemma 2 of Theorem 1, and the original-message lift. The breakdown already flags that finite-label calibration is not automatically the original-message theorem: lifting payoff labels back through a message labeling w
∗
:M→C
∗
 is a separate measurable-selection step. 

prover_01_response

Open issues remaining

Original-message lift (Lemma 12): finitely many payoff labels must be lifted to original messages m∈M through the labeling w
∗
:M→C
∗
. This is a separate measurable-selection problem, not part of Lemmas 7-8.

Lift to compact C
∗
: extending from finite menus to compact menus still needs stratified Gauss-map regularity or a Painlevé-Kuratowski stability argument for normal cones and active-face correspondences.

Compatibility with the v8 sharpness package: the finite-menu theorem does not contradict the WTA ternary cone-intersection and no-free-dust package. It proves calibration for a finite ambient local maximizer with a normal Clarke multiplier; it does not claim that null-message dust or generic tie-breaking can repair a non-calibrated compact-menu witness.

Next-step signal

The next prover should attack the finite original-message lift, Lemma 12, under the cleanest finite representative hypothesis: given labels w
i
	​

 with q
i
	​

>0, produce actual messages m
i
	​

∈M satisfying w
∗
(m
i
	​

)=w
i
	​

, push the finite-label kernel λ
−
 through i↦m
i
	​

, and verify that the induced original-message posterior is unchanged after merging duplicate representatives.
