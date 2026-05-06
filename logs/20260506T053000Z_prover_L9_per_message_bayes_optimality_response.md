
========
ROLE: user (id=5f58558c-2850-4f66-b6df-6a1d5d79f2ad)
========
# Prover pass — L9: per-message Bayes-optimality

You are the Prover in the soft-scaffolding workflow.

## Goal for this pass

Establish **L9 (per-message Bayes-optimality)** under standing + (A5) +
(A8c-lsc). Combined with Branch A and L8 (= L8c under (A8c-lsc)),
this completes the Theorem 2 infinite-extension as a conditional
theorem.

## Inputs

- phil_reny_route_memo.md — live route memo. Branch A complete under
  (A5). L8 PROVED-CONDITIONAL under (A8c-lsc) via $\beta^* = \delta_{m^*(s)}$.
  L9 is the last lemma.
- phil_reny_bundle.md, prior_attempts_digest.md, paper PDF (especially
  Definition 2 and the paper's Appendix A.2 finite-case L9-analogue).

## Target — L9

**Statement.** Under standing + (A5) + (A8c-lsc), let $(\sigma^*, \beta^*)$
be the Branch-A and L8c output. Then for τ-a.e. (or all on-path)
$m\in M$, the private strategy $\hat\sigma^*(m): \Theta\to\Delta(A)$
satisfies

$$
\hat\sigma^*(m) \in \arg\max_{\hat\sigma'} U(\hat\sigma', P_{\beta^*}(\cdot\mid m))
$$

where $P_{\beta^*}(\cdot\mid m)$ is the agent's posterior over $\Omega$
after observing message $m$ under the mixture (aligned w.p. $\alpha$,
adversary $\beta^*$ w.p. $1-\alpha$). This is the Definition 2 condition
in Dworczak & Smolin.

## Subquestions you MUST address

1. **Definition of $P_{\beta^*}(\cdot\mid m)$.** With $\beta^*(dm\mid s) = \delta_{m^*(s)}(dm)$
   (Dirac kernel), the marginal message distribution under the mixture is
   $$
   q(dm) := \alpha\,\tau(dm) + (1-\alpha)\,(m^*)_\#\tau(dm),
   $$
   where $(m^*)_\#\tau$ is the pushforward of τ by $m^*$. Compute
   $P_{\beta^*}(\omega\mid m)$ from Bayes' rule, taking care with the
   support of $q$.
   - Aligned contribution: $\mu_0(\omega)\,\pi(dm\mid\omega)\,\alpha$ at message $m$.
   - Misaligned contribution: $\mu_0(\omega)\,(m^*)_\#\pi(\cdot\mid\omega)\,(1-\alpha)$ at message $m$.
   - The posterior is well-defined for $q$-a.e. $m$.

2. **Saddle-point inequality from L8.** From Branch A and L8 under
   (A8c-lsc): $U(\beta^*,\sigma^*) = U^* = \sup_\sigma\inf_\beta U(\beta,\sigma) = \inf_\beta U(\beta,\sigma^*)$.
   Hence $(\sigma^*,\beta^*)$ is a saddle point: for every σ,
   $U(\beta^*,\sigma) \le U(\beta^*,\sigma^*) = U^* \le U(\beta,\sigma^*)$
   for every β. The left inequality says $\sigma^*$ maximizes
   $U(\beta^*,\cdot)$.

3. **Decomposition of $U(\beta^*,\sigma)$ by message.** The fixed-$\beta^*$
   payoff decomposes as
   $$
   U(\beta^*,\sigma) = \int_M U(\hat\sigma(m), P_{\beta^*}(\cdot\mid m))\,q(dm).
   $$
   Verify this decomposition rigorously, using disintegration over the
   message marginal $q$.

4. **Pointwise Bayes-optimality from saddle.** If $\sigma^*$ maximizes
   the integral above, then for $q$-a.e. $m$,
   $\hat\sigma^*(m) \in \arg\max_{\hat\sigma'} U(\hat\sigma', P_{\beta^*}(\cdot\mid m))$.
   The standard recipe: contradiction + measurable selection of an
   improving $\hat\sigma'$ on a positive-$q$-measure set of $m$ where
   $\hat\sigma^*$ fails to be Bayes-optimal — this would improve
   $U(\beta^*,\sigma^*)$, contradicting the saddle. Use Kuratowski–Ryll-Nardzewski
   for the measurable selection.

5. **"For all m" vs "for q-a.e. m".** The paper's Definition 2 says
   "for all $m\in M$", but the paper's measurability convention treats
   "for all" as "for almost all where needed." Confirm that q-a.e. is
   the correct reading, OR upgrade to pointwise via continuity of the
   best-response correspondence.

6. **Posterior version on null sets.** $q(\{m\}) = 0$ for most $m$ in
   the continuous case. Definition 2 may technically require a
   posterior version for *every* $m\in M$ (including $q$-null
   messages). The standard approach: define $P_{\beta^*}(\cdot\mid m)$
   for $q$-null messages by any measurable extension (e.g., the prior,
   or an arbitrary measurable selector). Verify this version-choice
   doesn't break the result.

7. **Aligned messages have $\alpha\,\tau$-mass.** When $\alpha > 0$,
   every $m\in\operatorname{supp}\tau = M$ has positive aligned-mixture
   contribution $\alpha\,\tau$, so $q$ is dominated below by $\alpha\,\tau$.
   This means $q$-a.e. = τ-a.e. for $\alpha>0$. Use this to simplify.

## Output Format


markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: L9 — per-message Bayes-optimality

**Claim:** (Restate L9 with hypotheses standing + (A5) + (A8c-lsc) and
correct quantifier — q-a.e. $m$ or τ-a.e. $m$.)

**Argument:**

Step 1: Definition of $P_{\beta^*}(\cdot\mid m)$.
Justification: ...

Step 2: Saddle-point inequality + agent-side maximization.
Justification: ...

Step 3: Decomposition by message marginal $q$.
Justification: ...

Step 4: Pointwise Bayes-optimality via contradiction + measurable selection.
Justification: (KRN; measurable selection of an improving $\hat\sigma'$
on a positive-$q$-measure set.)

Step 5: Quantifier resolution (q-a.e. = τ-a.e. for $\alpha>0$).
Justification: ...

[DERIVED] L9 holds.

## Assumption Changes

- [ASSUMPTION+] / [ASSUMPTION-] (only if necessary)

## Breakdown Amendments

- [BREAKDOWN_AMEND] (only if route memo needs repair)

## Status Summary

- L9 status: PROVED / PROVED-CONDITIONAL / FALSE-AS-STATED.
- **Branch B status (Theorem 2 conditional):** ...
- **Full theorem statement:** ...

## Exact Next Obstacle

(If L9 closes Branch B: the next move is the Branch B consolidator,
producing the final theorem statement: "Under standing + (A5) +
(A8c-lsc), Theorem 2's existence direction extends to infinite $M, \Theta$."
If L9 needs an additional ingredient: name it.)


## Non-Negotiable Rules

- Cite Kuratowski–Ryll-Nardzewski (Aliprantis–Border 18.13) for
  measurable selection.
- Use the Branch-A saddle structure carefully — saddle is on
  $(\sigma^*,\beta^*)$, both achieving $U^*$.
- Length budget: 2000–3000 words.

## Scope Policy

L9 is the focused target. After L9 closes, the next pass is the Branch B
consolidator.


========
ROLE: assistant (id=69070e84-20ee-43d3-a37c-a90c7c718fa7)
========
Goal for This Pass

This pass proves L9: per-message Bayes-optimality for the Branch-A/L8c saddle pair. The finite proof in Appendix A.2 of Dworczak–Smolin obtains this step from a finite saddle point and the fact that every finite-support message is on path; here the same logic is rebuilt with regular conditional probabilities, a message-marginal decomposition, and a measurable-selection argument. This is the last “Bayes-after-message” cog needed after Branch A and L8c. 

Robust_trust_Dworczak_Smolin

 The route context is Phil Reny’s Branch-A minmax/regularization path and the prior digest’s warning that the remaining infinite-dimensional issue is precisely the per-message measurable-selection step, not another global Sion attempt. 

phil_reny_bundle

 

prior_attempts_digest

Main Work
Target 1: L9 — per-message Bayes-optimality

Claim: Under the standing assumptions, plus (A5) and (A8c-lsc), let (σ
∗
,β
∗
) be the Branch-A/L8c output, with

β
∗
(dm∣s)=δ
m
∗
(s)
	​

(dm).

Let q be the message marginal induced by the aligned/misaligned mixture under β
∗
. Then, for q-a.e. message m,

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

(⋅∣m)).

If α>0, this implies the desired τ-a.e. version. In the paper’s infinite-space convention, where “for all” is read as “almost all” with respect to the relevant underlying distributions, this is the correct Definition 2 formulation. 

Robust_trust_Dworczak_Smolin

Argument:

Step 1: Definition of P
β
∗
	​

(⋅∣m).

Let π(⋅∣ω) denote the conditional law of the adviser posterior s∈M given state ω, so that

τ=
ω∈Ω
∑
	​

μ
0
	​

(ω)π(⋅∣ω).

Under the mixture with aligned reporting probability α and misaligned Dirac report m
∗
(s) with probability 1−α, define, for each state ω, the finite measure

λ
ω
	​

(dm):=μ
0
	​

(ω)[απ(dm∣ω)+(1−α)(m
∗
)
#
	​

π(⋅∣ω)(dm)].

The total message marginal is therefore

q(dm)=
ω∈Ω
∑
	​

λ
ω
	​

(dm)=ατ(dm)+(1−α)(m
∗
)
#
	​

τ(dm).

Because Ω is finite, each λ
ω
	​

 is absolutely continuous with respect to q. Choose Radon–Nikodym derivatives

p
ω
	​

(m):=
dq
dλ
ω
	​

	​

(m).

Then a version of the posterior is

P
β
∗
	​

(ω∣m)=p
ω
	​

(m),q-a.e. m.

Equivalently, at an atom m of q,

P
β
∗
	​

(ω∣m)=
∑
ω
′
	​

μ
0
	​

(ω
′
)[απ({m}∣ω
′
)+(1−α)π((m
∗
)
−1
({m})∣ω
′
)]
μ
0
	​

(ω)[απ({m}∣ω)+(1−α)π((m
∗
)
−1
({m})∣ω)]
	​

,

whenever the denominator is positive.

For q-null messages, Bayes’ rule imposes no value. Pick any measurable extension, for example P
β
∗
	​

(⋅∣m)=μ
0
	​

 outside a q-full set on which the Radon–Nikodym version is well-defined. This version choice does not affect any payoff decomposition or any q-a.e. optimality statement.

Step 2: Saddle-point inequality plus agent-side maximization.

By Branch A and L8c under (A8c-lsc), the constructed pair satisfies

U(β
∗
,σ
∗
)=U
∗
=
σ
sup
	​

β
inf
	​

U(β,σ)=
β
inf
	​

U(β,σ
∗
),

and L8c gives the adversary β
∗
 attaining the relevant lower side. Thus the pair is a saddle point:

U(β
∗
,σ)≤U(β
∗
,σ
∗
)=U
∗
≤U(β,σ
∗
)∀σ,β.

The right inequality says β
∗
 is adversarial against σ
∗
. The left inequality is the one needed for L9: holding β
∗
 fixed, σ
∗
 maximizes the agent’s expected payoff. This is the infinite analogue of the finite Appendix A.2 sentence that the saddle point makes σ
∗
 a best response to β
∗
. 

Robust_trust_Dworczak_Smolin

Step 3: Decomposition by message marginal q.

Let f
ω
	​

(dθ) be the conditional law of θ given ω. Conditional independence of s and θ given ω implies that, after conditioning on (ω,m), the type distribution remains f
ω
	​

. For a private strategy 
σ
^
:Θ→Δ(A), recall

U(
σ
^
,μ)=
ω∈Ω
∑
	​

μ(ω)∫
Θ
	​

∫
A
	​

u(a,ω,θ)
σ
^
(da∣θ)f
ω
	​

(dθ).

For any full strategy σ∼(
σ
^
(m))
m∈M
	​

, the payoff under fixed β
∗
 is

U(β
∗
,σ)
	​

=
ω∈Ω
∑
	​

∫
M
	​

∫
Θ
	​

∫
A
	​

u(a,ω,θ)
σ
^
(m)(da∣θ)f
ω
	​

(dθ)λ
ω
	​

(dm).
	​


Disintegrating the joint (ω,m)-measure

Λ(dω,dm)=λ
ω
	​

(dm)

with respect to its message marginal q, we have

Λ(dω,dm)=P
β
∗
	​

(dω∣m)q(dm).

Therefore,

U(β
∗
,σ)
	​

=∫
M
	​

ω∈Ω
∑
	​

P
β
∗
	​

(ω∣m)∫
Θ
	​

∫
A
	​

u(a,ω,θ)
σ
^
(m)(da∣θ)f
ω
	​

(dθ)q(dm)
=∫
M
	​

U(
σ
^
(m),P
β
∗
	​

(⋅∣m))q(dm).
	​


All integrals are legitimate by boundedness of u, measurability of the kernels, finiteness of Ω, and standard disintegration on standard Borel spaces.

Step 4: Pointwise Bayes-optimality via contradiction plus measurable selection.

Assume, toward contradiction, that 
σ
^
∗
(m) is not Bayes-optimal on a set of positive q-measure. Let

V(m):=
σ
^
′
sup
	​

U(
σ
^
′
,P
β
∗
	​

(⋅∣m)),

and define the value gap

D(m):=V(m)−U(
σ
^
∗
(m),P
β
∗
	​

(⋅∣m))≥0.

The failure set is E={m:D(m)>0}. By assumption, q(E)>0.

We now need a measurable family of private strategies that attains V(m). Fix a finite dominating type measure

f
ˉ
	​

:=
ω∈Ω
∑
	​

f
ω
	​

,

so each f
ω
	​

≪
f
ˉ
	​

. Let ℓ
ω
	​

=df
ω
	​

/d
f
ˉ
	​

. For each posterior μ, type θ, and action a, define the typewise objective

H(a,θ,μ):=
ω∈Ω
∑
	​

μ(ω)ℓ
ω
	​

(θ)u(a,ω,θ).

For fixed (θ,μ), H(⋅,θ,μ) is continuous on compact A; for fixed a, it is measurable in (θ,μ). Thus the correspondence

C(m,θ):=arg
a∈A
max
	​

H(a,θ,P
β
∗
	​

(⋅∣m))

has nonempty compact values and measurable graph. By the Kuratowski–Ryll-Nardzewski measurable selection theorem, specifically Aliprantis–Border 18.13, there exists a measurable selector

a
†
(m,θ)∈C(m,θ).

The pure private strategy

σ
^
†
(m)(da∣θ):=δ
a
†
(m,θ)
	​

(da)

is measurable in (m,θ) and attains V(m) for every m in the chosen posterior version.

Define a new full strategy

σ
^
~
(m)={
σ
^
†
(m),
σ
^
∗
(m),
	​

m∈E,
m∈
/
E.
	​


Then, by the decomposition in Step 3,

U(β
∗
,
σ
~
)−U(β
∗
,σ
∗
)
	​

=∫
E
	​

[V(m)−U(
σ
^
∗
(m),P
β
∗
	​

(⋅∣m))]q(dm)
=∫
E
	​

D(m)q(dm)>0.
	​


The final inequality follows because D>0 on a positive-q-measure set. This contradicts the saddle inequality

U(β
∗
,σ)≤U(β
∗
,σ
∗
)∀σ.

Therefore D(m)=0 for q-a.e. m, which is precisely

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

(⋅∣m))q-a.e.
Step 5: Quantifier resolution: q-a.e. and τ-a.e. when α>0.

The direct conclusion is q-a.e. Bayes-optimality. Since

q=ατ+(1−α)(m
∗
)
#
	​

τ,

if α>0, then

q(N)=0⇒τ(N)=0.

Hence q-a.e. Bayes-optimality implies τ-a.e. Bayes-optimality.

One small precision goblin: q-a.e. and τ-a.e. are not literally identical unless (m
∗
)
#
	​

τ≪τ. The domination q≥ατ gives the implication needed here, not equality of null sets. This is enough for the target: the stronger q-a.e. conclusion automatically gives the advertised τ-a.e. result for α>0.

In the finite-M case with τ(m)>0 for every m∈M, q({m})≥ατ({m})>0, so the same argument upgrades to every m∈M, matching Appendix A.2. In the continuous case, singletons typically have zero q-mass, so the correct infinite-space reading is almost-sure/on-path Bayes-optimality.

Step 6: Posterior versions on null sets.

The Radon–Nikodym posterior is pinned down only q-a.e. On q-null messages, choose any measurable extension, such as the prior μ
0
	​

. This does not alter:

the disintegration identity,

the payoff decomposition,

the saddle inequality,

the q-a.e. Bayes-optimality conclusion.

A literal “for every m” strengthening would require more than a posterior extension: one would also need a strategy representative that is Bayes-optimal on all q-null messages while preserving adversariality against all possible deviations β. Arbitrary null-set changes can create new exploitable messages for the adversary, so the safe theorem-level statement is the q-a.e., hence τ-a.e. for α>0, formulation. This matches the paper’s measurability convention for infinite spaces. 

objective_statement

 

Robust_trust_Dworczak_Smolin

[DERIVED] L9 holds.

Assumption Changes

[ASSUMPTION+] None for the q-a.e. L9 statement.

[ASSUMPTION+] To state L9 as τ-a.e., use α>0. If α=0, the proven and generally correct statement is only q-a.e., i.e. on-path under β
∗
.

Breakdown Amendments

[BREAKDOWN_AMEND] Replace “q-a.e. =τ-a.e. because q≥ατ” with the precise statement:

q-a.e.⇒τ-a.e.when α>0.

Equality of null sets would additionally require (m
∗
)
#
	​

τ≪τ, which is not supplied by the standing assumptions or by (A8c-lsc).

Status Summary

L9 status: PROVED-CONDITIONAL under standing + (A5) + (A8c-lsc). The condition is the same as L8c’s condition; no new substantive assumption is added. The exact quantifier is q-a.e., and therefore τ-a.e. when α>0.

Branch B status (Theorem 2 conditional): Closed modulo consolidator. Branch A supplies σ
∗
; L8c supplies β
∗
=δ
m
∗
(s)
	​

 and the saddle structure; L9 supplies Definition 2’s per-message Bayes-optimality in the infinite-space, almost-sure sense.

Full theorem statement: Under the standing assumptions plus (A5) and (A8c-lsc), Theorem 2’s existence direction extends to infinite M and Θ: there exists an optimal σ
∗
 and an adversarial β
∗
 such that 
σ
^
∗
(m) is Bayes-optimal for P
β
∗
	​

(⋅∣m) for q-a.e. message, hence for τ-a.e. message when α>0. In finite M with full support and α>0, this recovers the paper’s “all m∈M” version.

Exact Next Obstacle

L9 closes Branch B. The next move is the Branch B consolidator, producing the final conditional theorem statement:

Under standing + (A5) + (A8c-lsc), Theorem 2’s existence direction extends to infinite M,Θ, with robust rationalizability interpreted in the paper’s almost-sure/on-path sense.
