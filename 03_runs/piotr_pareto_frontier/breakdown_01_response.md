
========
ROLE: user (id=ac7f8944-0670-4530-b386-29c8ac7df325)
========
# Breakdown pass 01 — Finite-menu Pareto-Hall calibration via Clarke-Danskin stationarity

## Role

You are the Breakdown role for a smart-scaffolding proof project. The
formalizer, literature, and searcher passes have agreed: attack
Pareto-Hall calibration via **Clarke-Danskin stationarity at a finite
Pareto-frontier menu**. The full thread is in
formalizer_01_response.md, literature_01_response.md, and
searcher_01_response.md (now also present as durable session artifacts).

## Convergent plan to break down

**The hinge claim (searcher's primary route, "the first theorem").**

Let \(C^* = \{w_1,\ldots,w_k\}\subset W^P\) be a **finite** local maximizer
of
\[
F_k(w_1,\ldots,w_k) \;=\; \int_M\!\big[\alpha\,\max_i s\!\cdot\!w_i \;+\; (1-\alpha)\,\min_i s\!\cdot\!w_i\big]\,\tau(ds)
\]
over the constraint \(w_i\in W^P\), **with the further constraint that no
\(w_i\) can be replaced by a Pareto-dominator in \(W\)** (Lemma 2 of the
paper's Theorem 1 proof — wlog Bayes-optimal profiles).

Then there exist measurable active-face weights
\[
\lambda_i^+(s)\in\Delta(\arg\max_j\,s\!\cdot\!w_j), \quad
\lambda_i^-(s)\in\Delta(\arg\min_j\,s\!\cdot\!w_j),
\]
such that the Clarke subdifferential components
\[
g_i \;:=\; \alpha\!\int_M \lambda_i^+(s)\,s\,\tau(ds) \;+\; (1-\alpha)\!\int_M \lambda_i^-(s)\,s\,\tau(ds)
\]
lie in the normal cone \(N_W(w_i)\) of \(W\) at \(w_i\), for every
\(i\in\{1,\ldots,k\}\). The induced posterior at label \(w_i\) is
\[
p_i \;:=\; \frac{g_i}{q_i}, \quad q_i \;:=\; \alpha\!\int_M \lambda_i^+\,d\tau + (1-\alpha)\!\int_M \lambda_i^-\,d\tau,
\]
and \(p_i\in N_W(w_i)\cap\Delta(\Omega)\) whenever \(q_i>0\) — which is
exactly Pareto-Hall calibration at label \(w_i\).

The adversarial kernel \(\hat\beta^*\) in the original game is constructed
by routing source signals \(s\) to message labels with weights
\(\lambda_i^-(s)\). The aligned-truthful term concentrates aligned mass on
label \(w^*(s)\in\arg\max_j s\!\cdot\!w_j\), with weights \(\lambda_i^+(s)\)
when there are ties.

## Your job

Produce a **lemma chain** that decomposes the hinge claim into
prover-sized chunks. Each lemma should:

- Be self-contained (precise hypotheses, statement, expected proof tools).
- Be sized for ~1 Extended Pro prover pass (i.e., 1-2 explicit
  mathematical objects).
- Have an explicit verification target (what a reviewer would check).
- Identify which earlier lemmas it depends on.

The chain should culminate in the finite-menu Pareto-Hall theorem above.
After that, identify the lift to general \(C^*\) (stratified compact
menus, then full \(\mathcal K(W^P)\)) as separate downstream theorems.

## Output ordering


# Breakdown: Finite-menu Pareto-Hall calibration via Clarke-Danskin stationarity

## Theorem target (finite-menu Pareto-Hall)

Restate the hinge claim in fully formal language. Define every symbol.
Decide which version of "local maximizer" you use: pure local max in
\(W^k\), local max up to Pareto-dominating replacement, etc.

## Hypothesis ledger

List every standing/auxiliary hypothesis (Ω finite, full-support μ_0,
A and Θ compact metric, u bounded continuous in a, conditional
independence, Borel measurability) and any new hypothesis you need
(finiteness of optimal menu, regularity of W^P, atomless τ, ...). Tag
each as STANDING, INHERITED-FROM-V8 (e.g., exact-contact), or
NEW. Be explicit about which NEW hypotheses are "economically meaningful"
and which are technical.

## Lemma chain (numbered, in proof order)

For each lemma:

### Lemma X — <name>

**Hypotheses.**  
**Statement.**  
**Tools needed.** (Cite by name; reference earlier lemmas explicitly.)  
**Proof outline.** (1-2 paragraphs.)  
**Reviewer verification target.** (What would a reviewer check first?)  
**Risk.** (One short paragraph on where this could fail.)

## Capstone theorem

Re-state the finite-menu Pareto-Hall theorem as the conclusion of the
chain. Identify which lemmas plug into which step.

## Lift roadmap (post-capstone)

- (Step 1) Extension from finite \(C^*\) to **stratified-compact** \(C^*\)
  (finite stratification on which the Gauss map is single-valued).
- (Step 2) Extension to general compact \(C^*\subseteq W^P\) (limit
  argument using compactness of \(\mathcal K(W^P)\) + closedness of
  normal-cone correspondence).
- (Step 3) Translation of \(\hat\beta^*\) (payoff-vector kernel) into the
  original-game message kernel via the labeling \(w^*:M\to C^*\). Note
  the "original-message lift" gap (formalizer §6 Tier 1b) — may require
  an auxiliary measurable-selection lemma on \((w^*)^{-1}(\beta^*(s))\).

For each lift step, identify the candidate tool (Gauss-map regularity,
normal-current calculus, Painlevé-Kuratowski stability, KRN measurable
selection).

## Prover marching order

State the **single first prover target** — pick one specific lemma from
the chain. State precisely what the prover should produce.

## Anticipated review traps

List 3-5 specific places the reviewer will probably push back. For each,
state how the breakdown handles it pre-emptively.

## Output Contract

- Return everything inline in this chat as plain markdown.
- Stick to the section ordering above exactly.
- Be precise about hypotheses. Do not silently inherit "atomless τ" or
  "exact-contact" — list them as explicit hypotheses in the ledger.
- The hinge of the route is that Clarke multipliers are exactly the
  calibration kernel. Make this load-bearing step its own lemma.
- Pay attention to ties: \(s\mapsto\arg\max_j s\!\cdot w_j\) is single-
  valued except on a measure-zero set in the generic case, but the
  proof must handle the tie set explicitly. The searcher noted this is
  a porcupine — state how the breakdown handles it.

## Constraints

- **Banned re-proposals**: see `prior_attempts_digest.md`. In particular:
  no product-of-narrow Sion, no τ-AC restriction \(F\subset B\), no FOC
  + envelope on the original strategy game, no axiomatized Lean
  GameSetup, no ε-menu-Hall as primary, no canonical/minimal pruning
  without deletion-compatible Hall.
- **Sharpness compatibility**: any final theorem must not contradict
  v8 Lemma 7 (cone intersection) + Theorem 8 (no-free-dust) on the WTA
  ternary witness. The witness is a menu-engine artefact, not a
  primitive counterexample, so a primitive sufficient condition that
  rules it out is acceptable.
- **Per user instruction**: do not stop at a partial theorem. The
  target is OBJECTIVE_MET or OBJECTIVE_MET_WITH_TRIVIAL_REGULARITY where
  the regularity is an economically meaningful primitive condition
  strictly weaker than menu-Hall.
Show more

========
ROLE: assistant (id=c76a3fa6-ea00-429c-a15a-965f5ddbab57)
========
Breakdown: Finite-menu Pareto-Hall calibration via Clarke-Danskin stationarity
Theorem target (finite-menu Pareto-Hall)

Let Ω={1,…,N}, identify Δ(Ω)⊂R
N
, and let τ be the distribution of adviser posteriors s∈M⊆Δ(Ω). Let W⊂R
N
 be the compact convex set of feasible state-contingent payoff profiles

W:={w∈R
N
:∃
σ
^
,w(ω)=E
σ
^
	​

[u(a,ω,θ)∣ω]}.

The paper’s Lemma 2 identifies W, proves compactness/convexity, defines the weak Pareto frontier W
P
, and uses supporting hyperplanes to equate W
P
 with profiles Bayes-optimal for some belief. 

Robust_trust_Dworczak_Smolin

Define the convex normal cone

N
W
	​

(w):={y∈R
N
:y⋅(z−w)≤0∀z∈W}.

Thus p∈N
W
	​

(w)∩Δ(Ω) means w∈argmax
z∈W
	​

p⋅z, so any private strategy realizing w is Bayes-optimal under posterior p.

For k≥1, define

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
1≤i≤k
max
	​

s⋅w
i
	​

+(1−α)
1≤i≤k
min
	​

s⋅w
i
	​

]τ(ds).

Local maximizer convention used here. I use a Pareto-clean ambient local maximizer:

w
ˉ
=(w
1
	​

,…,w
k
	​

)∈(W
P
)
k

and there exists r>0 such that

F
k
	​

(v
1
	​

,…,v
k
	​

)≤F
k
	​

(w
1
	​

,…,w
k
	​

)

for every v=(v
1
	​

,…,v
k
	​

)∈W
k
 with max
i
	​

∥v
i
	​

−w
i
	​

∥<r.

This is stronger than “local maximizer only inside (W
P
)
k
.” The stronger version is deliberate: the conclusion g
i
	​

∈N
W
	​

(w
i
	​

) is an ambient first-order condition against all nearby feasible payoff profiles in W. A frontier-only local maximum would yield a normal condition for W
P
, not automatically for W, unless one adds a separate local Pareto-completion lemma.

For s∈M, define the active index sets

I
+
(s):=arg
j
max
	​

s⋅w
j
	​

,I
−
(s):=arg
j
min
	​

s⋅w
j
	​

.

A vector λ
+
(s)∈Δ(I
+
(s)) means λ
i
+
	​

(s)≥0, ∑
i
	​

λ
i
+
	​

(s)=1, and λ
i
+
	​

(s)=0 outside I
+
(s). Define λ
−
(s)∈Δ(I
−
(s)) analogously.

Finite-menu Pareto-Hall theorem. If 
w
ˉ
 is a Pareto-clean ambient local maximizer of F
k
	​

, then there exist measurable active-face weights

λ
+
(s)∈Δ(I
+
(s)),λ
−
(s)∈Δ(I
−
(s))

such that, for each i,

g
i
	​

:=α∫
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

).

Let

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

Whenever q
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

∈N
W
	​

(w
i
	​

)∩Δ(Ω).

Equivalently, every finite label w
i
	​

 that receives positive total mixture mass is Bayes-calibrated: its induced posterior p
i
	​

 lies in the Bayes cone of w
i
	​

.

The induced finite-label kernels are

κ
+
(i∣s)=λ
i
+
	​

(s),κ
−
(i∣s)=λ
i
−
	​

(s).

The aligned kernel κ
+
 routes only to payoff profiles maximizing s⋅w
i
	​

; the adversarial kernel κ
−
 routes only to payoff profiles minimizing s⋅w
i
	​

. The finite-label posterior at label i is exactly p
i
	​

.

This is the finite-label version of menu-Hall calibration. The original-message lift is deliberately separated below, because it requires selecting actual messages whose payoff label is w
i
	​

, a gap already flagged in the Pareto-frontier route memo. 

piotr_pareto_frontier_route_memo

Hypothesis ledger

STANDING.

Ω is finite, ∣Ω∣=N, and μ
0
	​

 has full support.

Adviser posteriors s∈Δ(Ω) have Borel law τ, support M=suppτ.

α∈[0,1].

A and Θ are compact metric spaces.

u(a,ω,θ) is bounded and continuous in a.

s and θ are conditionally independent given ω.

All spaces carry Borel σ-algebras and all strategies/kernels are measurable.

W⊂R
N
 is the compact convex feasible payoff-profile set derived from private strategies.

W
P
 is the weak Pareto frontier:

W
P
={w∈W:∄w
′
∈W with w
′
(ω)>w(ω) ∀ω}.

These match the Robust Trust standing assumptions and the payoff-profile construction used in the proof of Theorem 1. 

objective_statement

 

Robust_trust_Dworczak_Smolin

INHERITED-FROM-V8, but not assumed in the finite capstone.

q-a.e. on-path reading. For infinite-message robust rationalizability, the natural “on-path” distribution is the mixture message marginal q
β
∗
	​

, not merely τ. This matters for downstream lifts; the finite theorem uses the finite label masses q
i
	​

. 

theorem_2_extension_proof_v8

Exact-contact. Not assumed in the finite theorem. It reappears only when payoff labels must be lifted back to original messages.

Menu-Hall. Not assumed. The finite theorem derives the finite-label Hall calibration from Clarke stationarity.

Sharpness package. The WTA cone-intersection and no-free-dust results are compatibility constraints, not hypotheses. The finite theorem must not pretend that null dust or generic ties solve calibration. 

theorem_2_extension_proof_v8

NEW.

Finite menu, k<∞. Economically meaningful. The robust policy uses finitely many Pareto-frontier payoff profiles.

Pareto-clean coordinates, w
i
	​

∈W
P
. Economically meaningful and inherited in spirit from Lemma 2: no selected profile is strictly dominated in every state.

Ambient local maximality in W
k
. Economically meaningful, but also technically load-bearing. It says the finite menu is stable against all small feasible payoff-profile deviations, not merely deviations along the Pareto frontier.

No atomlessness of τ. Not assumed. Ties may have positive τ-mass.

No generic uniqueness of active faces. Not assumed. The whole point of the λ
±
 fields is to domesticate tie sets instead of pretending they vanish.

Finite-dimensional Clarke calculus. Technical and automatic once Ω and k are finite and W⊂R
N
 is compact.

Lemma chain (numbered, in proof order)
Lemma 1 - Payoff-profile normal cone equals Bayes cone

Hypotheses.
Standing assumptions. W⊂R
N
 compact convex. w∈W. Define

N
W
	​

(w)={y:y⋅(z−w)≤0 ∀z∈W}.

Statement.
If p∈N
W
	​

(w)∩Δ(Ω), then every private strategy realizing payoff profile w is Bayes-optimal under posterior p. Conversely, w∈W
P
 iff N
W
	​

(w)∩Δ(Ω)

=∅.

Tools needed.
Supporting hyperplane theorem, compact convex separation, paper Lemma 2. No earlier lemmas.

Proof outline.
The forward direction is immediate:

p⋅z≤p⋅w∀z∈W,

so w maximizes expected payoff at belief p. Since W is exactly the set of feasible payoff profiles, any strategy realizing w attains the Bayes value.

For the reverse direction, separate W from the open upper cone w+R
++
N
	​

. The separating vector can be chosen nonnegative and nonzero; normalizing it gives p∈Δ(Ω). This is the paper’s supporting-hyperplane logic behind the Pareto-frontier reduction. 

Robust_trust_Dworczak_Smolin

Reviewer verification target.
Check that the separator can be chosen in R
+
N
	​

∖{0}, then normalized to a probability vector.

Risk.
The weak Pareto frontier uses strict improvement in every coordinate. If a reviewer uses the stronger “weakly higher and strictly higher somewhere” frontier, boundary beliefs with zero components need separate handling.

Lemma 2 - Finite-menu objective is Lipschitz and Pareto-monotone

Hypotheses.
Standing assumptions. k<∞. w=(w
1
	​

,…,w
k
	​

)∈W
k
.

Statement.
The map F
k
	​

:(R
N
)
k
→R is globally Lipschitz on bounded sets, hence locally Lipschitz. Moreover, if one coordinate w
i
	​

 is replaced by v
i
	​

∈W with v
i
	​

≥w
i
	​

 coordinatewise, then F
k
	​

 weakly increases.

Tools needed.
Finite max/min inequalities, s∈Δ(Ω). Depends on Lemma 1 only for interpretation, not for proof.

Proof outline.
For each s, the functions w↦max
i
	​

s⋅w
i
	​

 and w↦min
i
	​

s⋅w
i
	​

 are Lipschitz because each s has bounded norm. Integrating preserves Lipschitzness.

If v
i
	​

≥w
i
	​

, then s⋅v
i
	​

≥s⋅w
i
	​

 for every s∈Δ(Ω). Raising one menu item cannot lower the max and cannot lower the min of the finite list. Hence the integrand weakly increases pointwise.

Reviewer verification target.
Check the min term: replacing one entry by a larger number cannot decrease the minimum of a finite list.

Risk.
Strict Pareto improvement may not strictly improve F
k
	​

 if the profile is never active in either max or min. Only weak monotonicity is needed.

Lemma 3 - Frontier-local maximality needs an ambientization certificate

Hypotheses.

w
ˉ
∈(W
P
)
k
 is a local maximizer of F
k
	​

 relative to (W
P
)
k
. Assume the following local Pareto-completion property: for every sufficiently small v∈W
k
 near 
w
ˉ
, there is 
v
~
∈(W
P
)
k
, also near 
w
ˉ
, such that 
v
~
i
	​

≥v
i
	​

 coordinatewise for every i.

Statement.
Under this additional property, 
w
ˉ
 is an ambient local maximizer over W
k
.

Tools needed.
Lemma 2.

Proof outline.
Take any nearby v∈W
k
. By local Pareto completion, choose nearby 
v
~
∈(W
P
)
k
 with 
v
~
i
	​

≥v
i
	​

. Lemma 2 gives

F
k
	​

(v)≤F
k
	​

(
v
~
).

Since 
w
ˉ
 is locally maximal on (W
P
)
k
,

F
k
	​

(
v
~
)≤F
k
	​

(
w
ˉ
).

Thus F
k
	​

(v)≤F
k
	​

(
w
ˉ
).

Reviewer verification target.
Check whether the local Pareto-completion property is actually available for the W at hand. It is not automatic for arbitrary nonsmooth compact convex W.

Risk.
This lemma is a bridge, not a free theorem. The capstone below assumes ambient local maximality directly. Without either ambient local maximality or this bridge, the normal cone N
W
	​

(w
i
	​

) conclusion is not justified.

Lemma 4 - Active faces and tie simplices are measurable

Hypotheses.
Standing assumptions. Fixed finite menu 
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
.

Statement.
The correspondences

s↦I
+
(s)=arg
j
max
	​

s⋅w
j
	​

,s↦I
−
(s)=arg
j
min
	​

s⋅w
j
	​


are measurable finite-valued correspondences. The embedded simplices

Λ
+
(s):=Δ(I
+
(s)),Λ
−
(s):=Δ(I
−
(s))

have measurable graphs, nonempty compact convex values, and admit measurable selections. Tie sets of positive τ-mass are allowed.

Tools needed.
Finite inequalities, measurable maximum theorem in finite form, Kuratowski-Ryll-Nardzewski in a finite-dimensional simplex. Depends on no earlier lemma except notation.

Proof outline.
For each i,

{s:i∈I
+
(s)}=
j
⋂
	​

{s:s⋅w
i
	​

≥s⋅w
j
	​

},

a Borel set. The argmin case is identical with reversed inequalities. The graph of Λ
±
 is described by finitely many Borel equalities/inequalities:

λ
i
	​

≥0,
i
∑
	​

λ
i
	​

=1,λ
i
	​

=0 off the active set.

Measurable selection follows.

Reviewer verification target.
Check the graph formula for Λ
±
, especially the condition λ
i
	​

=0 outside the active set.

Risk.
None serious. The only trap is silently replacing tie simplices by a single tie-breaking selector, which would lose the degrees of freedom needed for calibration.

Lemma 5 - Pointwise Clarke-Danskin active-weight representation

Hypotheses.
Fixed s∈M. Fixed 
w
ˉ
∈(R
N
)
k
. Define

ϕ
s
	​

(w
1
	​

,…,w
k
	​

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

Statement.
The Clarke subdifferential satisfies the inclusion

∂
C
	​

ϕ
s
	​

(
w
ˉ
)⊆{(αλ
i
+
	​

s+(1−α)λ
i
−
	​

s)
i=1
k
	​

:λ
+
∈Δ(I
+
(s)),λ
−
∈Δ(I
−
(s))}.

In many regular cases this is equality, but the inclusion is all the proof needs.

Tools needed.
Danskin theorem for finite maxima/minima of smooth affine maps; Clarke sum rule. Depends on Lemma 4 for active-set notation.

Proof outline.
For w↦max
i
	​

s⋅w
i
	​

, the Clarke subdifferential is the convex hull of active gradients e
i
	​

⊗s over I
+
(s). For w↦min
i
	​

s⋅w
i
	​

, use min
i
	​

a
i
	​

=−max
i
	​

(−a
i
	​

), giving the convex hull over active minima, again with gradient e
i
	​

⊗s, not −s. The Clarke sum rule gives the inclusion for the weighted sum.

Reviewer verification target.
Check the sign in the min term. The gradient contribution of an active minimum is +s in the active coordinate.

Risk.
Claiming equality for the sum can be false in degenerate cancellations. The inclusion is the safe version and is sufficient for the stationarity-to-calibration route.

Lemma 6 - Integral Clarke-Danskin representation

Hypotheses.
Standing assumptions. Fixed 
w
ˉ
∈W
k
. F
k
	​

=∫ϕ
s
	​

dτ.

Statement.
Every g∈∂
C
	​

F
k
	​

(
w
ˉ
) admits measurable active-face weights λ
±
 such that

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

(s)sτ(ds),i=1,…,k.

Tools needed.
Clarke subgradient interchange for integrals of uniformly Lipschitz normal integrands; Aumann integral of compact convex-valued correspondences; measurable decomposition from Lemma 4; pointwise inclusion from Lemma 5.

Proof outline.
The integrands ϕ
s
	​

 are uniformly Lipschitz because s∈Δ(Ω). Clarke’s integral subgradient theorem gives

∂
C
	​

F
k
	​

(
w
ˉ
)⊆∫
M
	​

∂
C
	​

ϕ
s
	​

(
w
ˉ
)τ(ds).

By Lemma 5, each pointwise subgradient can be represented by active weights. Lemma 4 gives measurable active-weight selections. Finite dimensionality and compact convex values keep the Aumann integral closed, so the representation is exact rather than merely approximate.

Reviewer verification target.
Check the interchange theorem’s hypotheses: measurability, uniform Lipschitz bound, compact convex pointwise subdifferential values, finite-dimensional range.

Risk.
If the prover’s Clarke reference gives only closure of the Aumann integral, one must invoke closedness of the Aumann integral in finite dimension. This is a small but real book-keeping dragon.

Lemma 7 - Clarke Fermat rule gives normal-cone stationarity

Hypotheses.

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
 is an ambient local maximizer of F
k
	​

 over W
k
. W is closed convex.

Statement.
There exists g=(g
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
) such that

g∈N
W
k
	​

(
w
ˉ
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

)∀i.

Tools needed.
Clarke Fermat rule for constrained local maxima; convex normal cone calculus; product normal cone formula. Depends on Lemma 2 for local Lipschitzness.

Proof outline.
Apply the Clarke necessary condition to −F
k
	​

 minimized over W
k
:

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

Using ∂
C
	​

(−F
k
	​

)=−∂
C
	​

F
k
	​

, obtain g∈∂
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
). Since W
k
 is a Cartesian product of closed convex sets,

N
W
k
	​

(
w
ˉ
)=N
W
	​

(w
1
	​

)×⋯×N
W
	​

(w
k
	​

).

Reviewer verification target.
Check the sign convention for maximization: for differentiable F, this reduces to ∇
i
	​

F(
w
ˉ
)⋅(z−w
i
	​

)≤0 for all z∈W, hence ∇
i
	​

F(
w
ˉ
)∈N
W
	​

(w
i
	​

).

Risk.
If the maximizer is only relative to (W
P
)
k
, this lemma fails as stated. That is why the theorem target uses ambient local maximality.

Lemma 8 - Clarke multipliers are the calibration kernel

Hypotheses.

w
ˉ
 is a Pareto-clean ambient local maximizer. Lemmas 6 and 7 hold.

Statement.
There exist measurable active weights

λ
+
(s)∈Δ(I
+
(s)),λ
−
(s)∈Δ(I
−
(s))

such that the vectors

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

satisfy

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

Tools needed.
Lemma 6 for representation of the Clarke subgradient; Lemma 7 for normal-cone stationarity.

Proof outline.
Use Lemma 7 to choose a normal Clarke subgradient g∈∂
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
). Use Lemma 6 to represent that same g by measurable active weights. The product normal cone then gives g
i
	​

∈N
W
	​

(w
i
	​

) component by component.

Reviewer verification target.
Check that the g represented by the λ
±
 is the same g that lies in the normal cone, not a nearby or separately chosen subgradient.

Risk.
This is the hinge. Any gap in the integral subgradient representation or in the local-max stationarity rule breaks the calibration result.

Lemma 9 - Normalized multiplier vectors are posteriors

Hypotheses.
Lemma 8. Define

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

dτ+(1−α)∫
M
	​

λ
i
−
	​

dτ.

Statement.
For every i,

1⋅g
i
	​

=q
i
	​

,g
i
	​

∈R
+
N
	​

.

If q
i
	​

>0, then

p
i
	​

:=g
i
	​

/q
i
	​

∈Δ(Ω)∩N
W
	​

(w
i
	​

).

If q
i
	​

=0, then g
i
	​

=0, and label i has zero total mixture mass.

Tools needed.
s∈Δ(Ω), nonnegativity of λ
±
, conicity of N
W
	​

(w
i
	​

). Depends on Lemma 8.

Proof outline.
Each s is a probability vector, so 1⋅s=1 and s≥0. Therefore g
i
	​

≥0 and

1⋅g
i
	​

=α∫λ
i
+
	​

dτ+(1−α)∫λ
i
−
	​

dτ=q
i
	​

.

If q
i
	​

>0, p
i
	​

 is a probability vector. Since N
W
	​

(w
i
	​

) is a cone and g
i
	​

∈N
W
	​

(w
i
	​

), positive rescaling gives p
i
	​

∈N
W
	​

(w
i
	​

).

Reviewer verification target.
Check the identity 1⋅g
i
	​

=q
i
	​

. It is the tiny arithmetic hinge that makes p
i
	​

 a posterior rather than just a normal vector.

Risk.
Labels with q
i
	​

=0 cannot be assigned posteriors by normalization. The theorem correctly excludes them.

Lemma 10 - Normal posteriors make the finite labels Bayes-optimal

Hypotheses.
Lemmas 1 and 9. For each i, choose a private strategy 
σ
^
i
	​

 realizing w
i
	​

.

Statement.
If q
i
	​

>0, then

σ
^
i
	​

∈arg
σ
^
′
max
	​

U(
σ
^
′
,p
i
	​

).

Tools needed.
Lemma 1. Depends on Lemma 9.

Proof outline.
By Lemma 9, p
i
	​

∈N
W
	​

(w
i
	​

)∩Δ(Ω). Lemma 1 says this is exactly the Bayes cone of w
i
	​

. Since 
σ
^
i
	​

 realizes w
i
	​

, it attains the maximum expected payoff under p
i
	​

.

Reviewer verification target.
Check that any realization of w
i
	​

, not just a special one, is Bayes-optimal at p
i
	​

. This follows because Bayes payoff depends only on the state-contingent payoff vector.

Risk.
If W were not exactly the payoff-profile image of private strategies, this would fail. Under the standing payoff-profile construction, it is safe.

Lemma 11 - Finite-label kernel realizes the calibrated posteriors

Hypotheses.
Lemmas 8 through 10.

Statement.
Define finite-label kernels

κ
+
(i∣s)=λ
i
+
	​

(s),κ
−
(i∣s)=λ
i
−
	​

(s),

and the finite-label joint measure

γ(ds,i)=[αλ
i
+
	​

(s)+(1−α)λ
i
−
	​

(s)]τ(ds).

Then the label marginal is q
i
	​

, and whenever q
i
	​

>0, the conditional barycenter of s given label i is p
i
	​

:

E
γ
	​

[s∣i]=p
i
	​

.

Moreover κ
+
(⋅∣s) is supported on argmax
j
	​

s⋅w
j
	​

, while κ
−
(⋅∣s) is supported on argmin
j
	​

s⋅w
j
	​

.

Tools needed.
Finite disintegration, Bayes formula, active-support definitions. Depends on Lemmas 8 and 9.

Proof outline.
The support claims are immediate from λ
±
(s)∈Δ(I
±
(s)). The marginal at label i is

γ(M×{i})=q
i
	​

.

The numerator of the conditional barycenter is

∫
M
	​

s[αλ
i
+
	​

(s)+(1−α)λ
i
−
	​

(s)]τ(ds)=g
i
	​

.

Dividing by q
i
	​

 gives p
i
	​

.

Reviewer verification target.
Check that the same weights define both the subgradient g
i
	​

 and the finite-label posterior numerator.

Risk.
This is a finite-label statement. It does not yet say there are original messages m∈M whose agent continuation is exactly label w
i
	​

. That lift is downstream.

Lemma 12 - Finite original-message representative lift, optional version

Hypotheses.
In addition to Lemma 11, suppose each finite payoff label w
i
	​

 has an actual message representative m
i
	​

∈M such that the agent’s labeling w
∗
:M→{w
1
	​

,…,w
k
	​

} satisfies w
∗
(m
i
	​

)=w
i
	​

. Suppose also that the aligned tie-routing convention can be implemented on the tied truthful messages, or that the finite labels themselves are admitted as the message space.

Statement.
The original-message adversarial kernel

β
^
	​

∗
(⋅∣s)=
i
∑
	​

λ
i
−
	​

(s)δ
m
i
	​

	​

(⋅)

routes only to minimizer labels. With the matching aligned tie-routing λ
i
+
	​

(s), the induced posterior at representative message m
i
	​

 is p
i
	​

, hence the continuation at m
i
	​

 is Bayes-optimal whenever q
i
	​

>0.

Tools needed.
Finite measurable selection, Lemmas 10 and 11.

Proof outline.
Push the finite-label joint law through i↦m
i
	​

. Since there are finitely many labels, measurability is trivial. Conditional posteriors are unchanged by this relabeling if the representative map is injective on labels or duplicates are merged.

Reviewer verification target.
Check that every label used by λ
−
 has an actual message representative and that duplicates are handled by merging their masses.

Risk.
This is exactly where the original-message lift can fail in the general compact-menu problem. The finite capstone does not hide that gap; it isolates it.

Capstone theorem

Finite-menu Pareto-Hall calibration theorem.
Under the standing hypotheses, let k<∞ and let

w
ˉ
=(w
1
	​

,…,w
k
	​

)∈(W
P
)
k

be a Pareto-clean ambient local maximizer of

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

Then there exist measurable active-face weights

λ
+
(s)∈Δ(arg
j
max
	​

s⋅w
j
	​

),λ
−
(s)∈Δ(arg
j
min
	​

s⋅w
j
	​

)

such that

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

dτ+(1−α)∫
M
	​

λ
i
−
	​

dτ,

we have, whenever q
i
	​

>0,

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

∈N
W
	​

(w
i
	​

)∩Δ(Ω).

Thus every finite payoff label with positive induced mass is Pareto-Hall calibrated: its posterior lies in the Bayes cone of its payoff profile.

How the lemmas plug in.
Lemma 2 gives local Lipschitzness. Lemmas 4 through 6 give the Clarke-Danskin active-weight representation, including tie sets. Lemma 7 gives normal-cone stationarity from ambient local maximality. Lemma 8 is the hinge: the Clarke multipliers are exactly the calibration kernel. Lemmas 9 through 11 normalize those multipliers into finite-label posteriors and verify Bayes-optimality. Lemma 12 records the optional finite original-message lift, but the general lift remains downstream.

This capstone does not use product-of-narrow Sion, τ-AC restrictions, FOC/envelope arguments on the original strategy game, or canonical pruning. Those routes were explicitly marked as blocked or banned in the project record. 

prior_attempts_digest

Lift roadmap (post-capstone)

(Step 1) Extension from finite C
∗
 to stratified-compact C
∗
 with finite Gauss-map stratification.

Candidate theorem: let C
∗
⊂W
P
 be compact and decomposed into finitely many C
1
 or rectifiable strata S
r
	​

, with a single-valued Gauss map except on a lower-dimensional tie skeleton. The finite active weights become measurable Young measures over active exposed faces:

λ
s
+
	​

∈Δ(arg
w∈C
∗
max
	​

s⋅w),λ
s
−
	​

∈Δ(arg
w∈C
∗
min
	​

s⋅w).

Stationarity should yield a vector-valued measure G(dw) on C
∗
 such that

dq
dG
	​

(w)∈N
W
	​

(w)∩Δ(Ω)

for q-a.e. w.

Candidate tools: stratified Danskin theorem, Gauss-map regularity, normal-current calculus, measurable selection on exposed-face correspondences, Clarke stationarity for measures on finite strata.

(Step 2) Extension to general compact C
∗
⊆W
P
.

Approximate C
∗
 by finite or stratified menus C
n
	​

→C
∗
 in Hausdorff distance. Extract weak limits of the induced finite-label measures and vector-valued normal measures. Use closedness of the graph of the convex normal-cone correspondence:

w
n
	​

→w,p
n
	​

→p,p
n
	​

∈N
W
	​

(w
n
	​

)⇒p∈N
W
	​

(w).

The posterior normalization must survive possible zero-mass labels by passing to Radon-Nikodym derivatives dG/dq.

Candidate tools: compactness of K(W
P
), Prokhorov/tightness for probability kernels on compact spaces, Painlevé-Kuratowski stability of active-face correspondences, closed-graph normal-cone correspondence, measurable disintegration.

(Step 3) Translation of 
β
^
	​

∗
 from payoff-vector kernel into the original-game message kernel via w
∗
:M→C
∗
.

Given a payoff-vector adversarial kernel κ(dw∣s), construct an original-message kernel 
β
^
	​

∗
(dm∣s) supported on

(w
∗
)
−1
(w)

for κ-a.e. w. For finite menus this is Lemma 12. For compact menus, it requires a measurable selector or measurable disintegration over the inverse-label fibers:

m∈(w
∗
)
−1
(w).

This is the “original-message lift” gap already flagged in the Pareto-frontier route memo. 

piotr_pareto_frontier_route_memo

Candidate tools: Kuratowski-Ryll-Nardzewski selection, Jankov-von Neumann selection for analytic inverse graphs, measurable lifting of kernels, exact-contact-style nonempty-fiber conditions.

Prover marching order

Single first prover target: Lemma 6 - Integral Clarke-Danskin representation.

The prover should produce a fully explicit theorem of the following form:

Let M⊆Δ(Ω) be Borel, τ∈Δ(M), k,N<∞, and

F
k
	​

(w)=∫
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

For every 
w
ˉ
∈(R
N
)
k
 and every

g∈∂
C
	​

F
k
	​

(
w
ˉ
),

there exist Borel maps

λ
+
:M→Δ
k
	​

,λ
−
:M→Δ
k
	​


such that for τ-a.e. s,

suppλ
+
(s)⊆arg
i
max
	​

s⋅
w
ˉ
i
	​

,suppλ
−
(s)⊆arg
i
min
	​

s⋅
w
ˉ
i
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

(s)sτ(ds)∀i.

The proof should explicitly handle positive-measure tie sets. It should use inclusion, not overclaim equality, for the Clarke subdifferential of the max-plus-min integrand.

Anticipated review traps

“Local on W
P
” is not enough for N
W
	​

.
The breakdown uses ambient local maximality over W
k
. If a prover starts from frontier-only local maximality, Lemma 3’s local Pareto-completion certificate must be proved separately.

The min term’s subgradient sign.
Active minima contribute +s, not −s. The minus appears only in the identity min=−max(−⋅), and cancels when taking gradients.

Ties cannot be brushed under the rug.
No atomless or generic no-tie hypothesis is assumed. Tie sets are handled by measurable simplex-valued weights λ
±
(s). This is where the porcupine gets mittens.

The multiplier must be the same vector that is normal.
It is not enough to find some active-weight integral and some normal subgradient separately. Lemma 8 requires the Clarke subgradient selected by Fermat stationarity to be represented by the active weights.

Finite-label calibration is not automatically the original-message theorem.
Lemma 11 proves calibration for payoff labels. The original-game kernel requires a measurable lift through w
∗
:M→C
∗
, handled only in Lemma 12 under finite representative assumptions and in the downstream Step 3 roadmap. The no-free-dust sharpness package remains compatible with this separation; the prior witness is a menu-engine artefact, not a primitive counterexample. 

theorem_2_extension_proof_v8
