
========
ROLE: user (id=b9a9dc3f-3f22-4d09-a117-966d78875962)
========
# Prover pass — Relax (A8c-lsc) to direct rowwise-argmin attainment

You are the Prover in the soft-scaffolding workflow.

## Goal

Per the scoper recommendation
(logs/20260506T110000Z_scoper_assumptions_strength_response.md),
relax **(A8c-lsc)** to the strictly weaker structural condition that's
actually needed for L8c-Half-2 / L8 closure:

**(A8c-attain).** For τ-a.e. $s\in M$, $D(s) := \arg\min_{m\in M}\ell_{\sigma^*}(m,s)$
is **nonempty**, and the correspondence $s\mapsto D(s)$ admits a
**Borel measurable selector** $m^*: M\to M$ with $m^*(s)\in D(s)$
for τ-a.e. $s$.

This is the property L8 actually invokes via Kuratowski–Ryll-Nardzewski.
L.s.c. of $\ell(\cdot,s)$ is just one sufficient route. The l.s.c.
counterexample $g(m) = m$ on $(0,1]$, $g(0) = 1$ shows that
non-l.s.c. $\ell$ can have empty argmin, so (A8c-attain) really is
strictly weaker than (A8c-lsc), with the gap = "does the argmin
correspondence have a measurable selector at all?"

In parallel, **identify primitive sufficient conditions** that force
(A8c-attain) without requiring (A8c-lsc):
- (P1) The agent's optimal Bayes-action correspondence is upper
  hemicontinuous in the message $m$ (compact-valued u.h.c.).
- (P2) The trust-region projection map (paper Section 4 / Theorem 1)
  is continuous on $\Delta(\Omega)$.
- (P3) $\sigma^*$ admits a closed-graph representative (the strategy
  graph $\{(m,\theta,a) : a\in\operatorname{supp}\hat\sigma^*(m,\theta)\}$
  is closed in $M\times\Theta\times A$).

Establish: each of (P1)–(P3) implies (A8c-attain) — without requiring
l.s.c. of $\ell$ pointwise.

## Inputs

- theorem_2_extension_proof.md — landed proof.
- phil_reny_route_memo.md — route memo.
- L8c logs (the obstruction structure).
- Paper PDF (Section 4, Theorem 1, Appendix A.6).

## Targets

### Target 1: (A8c-attain) suffices for L8

Restate L8 using (A8c-attain) instead of (A8c-lsc). Verify the
KRN-based argument in L8 closes under (A8c-attain) with no other
changes. (Should be a one-paragraph verification — KRN is the only
selection theorem invoked.)

### Target 2: (A8c-attain) is strictly weaker than (A8c-lsc)

Show: (A8c-lsc) ⇒ (A8c-attain) (immediate via Berge / measurable
maximum theorem).

Show: there exist models satisfying (A8c-attain) but NOT (A8c-lsc).
Concrete example: $g(m) = m^2$ on $[0,1]\setminus\{0.5\}$ and
$g(0.5) = 0$ — argmin is $\{0.5\}$ (attained), but $g$ is not l.s.c.
at $m = 0.5$. Verify this fits a model realization.

### Target 3: Primitive sufficient conditions

For each of (P1), (P2), (P3), prove: (Pi) ⇒ (A8c-attain). Specifically:

- **(P1) ⇒ (A8c-attain).** If the agent's Bayes-action correspondence
  $\mathcal A^*: \Delta(\Omega) \rightrightarrows A$ is u.h.c. with
  closed values, then $m\mapsto p_\omega(m) = \int u\cdot\hat\sigma^*(m,\theta)(da)\cdot f(d\theta\mid\omega)$
  is u.s.c. (since $\sigma^*$ is a measurable selector from $\mathcal A^*$
  composed with the Bayes-action structure), hence $\ell$ is u.s.c.
  in $m$. **Wait** — u.s.c. is too weak; we need l.s.c. or attainment.
  Refine: u.h.c. of $\mathcal A^*$ + appropriate compactness gives
  the **closed** graph of the strategy correspondence, which gives
  attainment of $\inf_m \ell$ via standard upper-hemicontinuous-min
  arguments (Berge maximum theorem variant: for u.h.c. compact-valued
  $F$ and continuous $f$, $\inf F$ is attained).

  *Carefully* re-derive: under (P1), is $\ell(\cdot,s)$ l.s.c.,
  u.s.c., neither, or just attainment-friendly? Check.

- **(P2) ⇒ (A8c-attain).** If the trust-region projection $P:\Delta(\Omega)\to T\subseteq\Delta(\Omega)$
  is continuous (where $T$ = closed trust region), and $\sigma^*$ is the
  composition "play Bayes-action at $P(m)$", then $\hat\sigma^*$ is
  continuous in $m$. Hence $p_\omega$ continuous, $\ell$ continuous
  (not just l.s.c.). Strong form: continuity ⇒ attainment + selector.

- **(P3) ⇒ (A8c-attain).** Closed-graph representative ⇒ standard
  application of measurable maximum theorem (Aliprantis–Border 18.19)
  for normal integrands.

### Target 4: Honest framing

The relaxed version of the theorem reads: "Branch B closes under
standing + (A5) + (A8c-attain) + (A9c-calib)" (Tier 2) or "+ (A8c-attain)"
(Tier 1). (A8c-attain) holds whenever any of (P1), (P2), (P3) holds.
Connect these primitive conditions to the paper's economic structure.

## Output Format


markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: (A8c-attain) suffices for L8
(Argument; one paragraph.)

### Target 2: (A8c-attain) is strictly weaker than (A8c-lsc)
(Forward direction; counterexample for the strict inclusion.)

### Target 3: Primitive sufficient conditions

#### (P1) U.h.c. Bayes-action correspondence
(Argument.)

#### (P2) Continuous trust-region projection
(Argument.)

#### (P3) Closed-graph strategy representative
(Argument.)

### Target 4: Honest framing of the relaxation
(One paragraph.)

[DERIVED] (A8c-lsc) can be relaxed to (A8c-attain), which is implied
by any of (P1), (P2), (P3) — primitive economic conditions
corresponding to TRE structure or u.h.c. Bayes responses.

## Assumption Changes

- [ASSUMPTION-] (A8c-lsc) replaced by (A8c-attain).
- [ASSUMPTION+] (A8c-attain) — strictly weaker primitive condition.

## Breakdown Amendments

- [BREAKDOWN_AMEND] Update theorem statement to use (A8c-attain).
- [BREAKDOWN_AMEND] Document (P1), (P2), (P3) as natural primitive
  routes to (A8c-attain).

## Status Summary

- L8 status: PROVED-CONDITIONAL on (A5) + (A8c-attain) (relaxed).
- (A8c-lsc) replaced by strictly weaker (A8c-attain).
- (A8c-attain) implied by any of (P1), (P2), (P3).

## Exact Next Obstacle

(Ready for reviewer. Next relaxation target: (A5).)


## Non-Negotiable Rules

- Cite Aliprantis-Border 18.13 (KRN), 18.19 (measurable maximum), and
  17.11 / Berge for u.h.c.-related results.
- Be careful with hemicontinuity directions: u.h.c. of a correspondence
  ≠ l.s.c. of an integrand. Verify each Pi → (A8c-attain) implication
  rigorously.
- Length budget: 2000–3000 words.

## Scope Policy

Focused on (A8c-lsc) relaxation. Do NOT attempt (A5) or (A9c-calib)
relaxations in this pass.


========
ROLE: assistant (id=c9138392-7292-4f64-88ac-9fb7eadd68da)
========
Goal for This Pass

This pass replaces the rowwise lower-semicontinuity assumption (A8c-lsc) with the exact property used by the L8 adversary-attainment step, namely (A8c-attain): for τ-a.e. adviser posterior s, the worst-message row argmin set D(s)=argmin
m∈M
	​

ℓ
σ
∗
	​

(m,s) is nonempty and has a Borel selector. This keeps the Branch B proof aligned with the paper’s a.e. measurability convention and with the previously landed Branch A/L8/L9 architecture. The paper’s finite Theorem 2 proof uses finite products and Sion to obtain a saddle; the infinite proof replaces that machinery with the Phil-Reny restricted-game/Lusin route plus an explicit adversary-attainment condition. 

Robust_trust_Dworczak_Smolin

 

theorem_2_extension_proof

Main Work
Target 1: (A8c-attain) suffices for L8

Restate L8 as follows. Under standing assumptions plus (A5), let σ
∗
 be the Branch A value-securing strategy, and let

ℓ
σ
∗
	​

(m,s)=
ω∈Ω
∑
	​

s(ω)p
ω
	​

(m)

be the row payoff. L8c-Half-1 already gives

m∈M
inf
	​

ℓ
σ
∗
	​

(m,s)=
m∈M
essinf
	​

ℓ
σ
∗
	​

(m,s)for τ-a.e. s.

If (A8c-attain) holds, choose the Borel selector m
∗
(s)∈D(s) τ-a.e. and set

β
∗
(dm∣s)=δ
m
∗
(s)
	​

(dm).

Then β
∗
∈B is measurable and achieves the unrestricted rowwise infimum:

U(β
∗
,σ
∗
)=aligned const+(1−α)∫
M
	​

m
inf
	​

ℓ
σ
∗
	​

(m,s)τ(ds)=
β∈B
inf
	​

U(β,σ
∗
).

By Branch A, this equals U
∗
. Thus L8 closes with no other modification. The previous proof used Kuratowski-Ryll-Nardzewski only to obtain a selector; under (A8c-attain) that selector is part of the assumption. Equivalently, if one states (A8c-attain) as nonempty measurable closed-valued D, Aliprantis-Border 18.13 supplies the selector.

Target 2: (A8c-attain) is strictly weaker than (A8c-lsc)

First, (A8c-lsc) implies (A8c-attain). Since M=suppτ⊆Δ(Ω) is compact metric, a τ-a.e. l.s.c. section m↦ℓ(m,s) attains its minimum on M. The argmin correspondence is nonempty compact-valued. Since ℓ is jointly Borel with l.s.c. sections, it is a normal integrand; Aliprantis-Border 18.19, the measurable maximum theorem, gives measurability of the value and weak measurability of the argmin correspondence. Aliprantis-Border 18.13, Kuratowski-Ryll-Nardzewski, gives a Borel selector.

For strictness, the proposed example g(m)=m
2
 off 0.5, g(0.5)=0, is actually l.s.c.: a downward spike satisfies g(0.5)≤liminfg(m
n
	​

). Use the following corrected example instead:

g(m)={
(m−
2
1
	​

)
2
,
1,
	​

m

=
4
1
	​

,
m=
4
1
	​

.
	​


Then g is Borel and bounded, argming={
2
1
	​

}, but g is not l.s.c. at m=
4
1
	​

, because g(
4
1
	​

)=1>liminf
m→1/4
	​

(m−
2
1
	​

)
2
=1/16. Hence argmin attainment can hold while l.s.c. fails.

This fits the robust-trust primitives. Let Ω={0,1}, μ
0
	​

=(1/2,1/2), M=[0,1], and τ be Lebesgue measure on [0,1], interpreted as a distribution of binary posteriors with mean 1/2. The state-conditional laws can be taken as

π(ds∣1)=2sds,π(ds∣0)=2(1−s)ds,

so Bayes plausibility holds. Let Θ be a singleton, A=[0,1], u(a,1)=a, and u(a,0)=0. Define σ
∗
(m)=δ
g(m)
	​

. Then p
1
	​

(m)=g(m), p
0
	​

(m)=0, and

ℓ
σ
∗
	​

(m,s)=sg(m).

For τ-a.e. s>0, D(s)={1/2}, so the constant selector m
∗
(s)=1/2 proves (A8c-attain), while ℓ(⋅,s) is not l.s.c. at 1/4. The older obstruction g(m)=m on (0,1], g(0)=1, remains useful for showing why some attainment condition is needed at all: the infimum is 0 and is not attained.

Target 3: Primitive sufficient conditions
(P1) U.h.c. Bayes-action correspondence

The rigorous conclusion is slightly sharper than the informal phrasing. A compact-valued u.h.c. Bayes-action correspondence by itself controls the available graph, not an arbitrary measurable selector from that graph. A measurable selector can be wild enough to destroy rowwise argmin attainment.

Indeed, take M=[0,1], A=[0,1], and the constant compact-valued u.h.c. correspondence A
∗
(m)=[0,1]. Select a(m)=m for m>0, a(0)=1. With payoff u(a)=a, the induced row payoff has infimum 0 and no minimizer. Thus bare u.h.c. of A
∗
 does not imply (A8c-attain) for an arbitrary selected σ
∗
.

The valid primitive route is:

(P1-cg). The realized payoff is represented by a compact-valued u.h.c. implementation correspondence G:M⇉Y, where Y is the compact space of private strategies or state-contingent payoff profiles, and

ℓ(m,s)=
y∈G(m)
min
	​

h(y,s)

for a continuous payoff map h, or else the payoff profile induced by G(m) is single-valued.

Then Gr(G) is compact. For each s, the continuous function (m,y)↦h(y,s) attains its minimum on Gr(G). Hence D(s)

=∅. Aliprantis-Border 17.11, the Berge maximum theorem in its u.h.c./compact-valued form, is the relevant graph-compactness and value-correspondence tool here. For measurability in s, apply Aliprantis-Border 18.19 to the normal integrand on the compact graph, then project the measurable selector (m(s),y(s)) to m(s). KRN, Aliprantis-Border 18.13, gives the final Borel selector when stated correspondence-wise.

So: u.h.c. Bayes responses imply (A8c-attain) only when they control the realized payoff graph, not merely the menu from which an arbitrary measurable σ
∗
 is chosen.

(P2) Continuous trust-region projection

This route is clean under the economic structure of a continuous trust-region implementation. Suppose P:Δ(Ω)→T is continuous, T is compact, and the Bayes-response implementation on T admits a continuous representative b:T→Y, where Y is the Balder-stable private-strategy space. This is the usual unique-Bayes-action or continuous tie-breaking version of the trust-region construction. The paper’s trust-region strategy maps off-region messages to boundary beliefs and then plays a Bayes response at the projected belief; in binary-state examples this is exactly the clipping geometry developed in Section 4 and Appendix A.6. 

Robust_trust_Dworczak_Smolin

Define

σ
^
∗
(m)=b(P(m)).

Then m↦
σ
^
∗
(m) is continuous. Since u(⋅,ω,θ) is continuous in the action and bounded, the Balder test-functional map

σ
^
↦∫
Θ
	​

∫
A
	​

u(a,ω,θ)
σ
^
(θ)(da)f(dθ∣ω)

is continuous. Hence each p
ω
	​

(m) is continuous, and because Ω is finite,

(m,s)↦ℓ
σ
∗
	​

(m,s)=
ω
∑
	​

s(ω)p
ω
	​

(m)

is continuous on compact M×M. Therefore D(s) is nonempty compact for every s. Aliprantis-Border 18.19 gives measurable argmin correspondence, and Aliprantis-Border 18.13 gives a Borel selector. This proves (A8c-attain). This is stronger than needed, since it derives continuity, but the primitive assumption is economic continuity of the trust-region projection rather than pointwise l.s.c. imposed directly on ℓ.

(P3) Closed-graph strategy representative

Here the exact meaning of “closed graph” matters. If it means only the support graph

{(m,θ,a):a∈supp
σ
^
∗
(m,θ)}

is closed, then the implication is false for mixed strategies, because the graph of supports does not encode probabilities. Example: A={0,1}, Θ singleton, and

σ
^
∗
(m)=g(m)δ
1
	​

+(1−g(m))δ
0
	​

,

where g(m)=1/4+m/2 for m>0, g(0)=3/4. The support is always {0,1}, so the support graph M×A is closed, but with payoff u(a)=a, the row payoff g has infimum 1/4 and no minimizer.

The valid version is:

(P3-kernel). The representative m↦
σ
^
∗
(m) has closed graph as a map into the compact metric Balder-stable private-strategy space Y, or the strategy is pure and the singleton support graph is closed.

Since M is compact and Y is compact Hausdorff, a closed graph for the single-valued map m↦
σ
^
∗
(m) implies continuity. Then the same argument as in (P2) applies: every p
ω
	​

 is continuous, ℓ is continuous, D(s) is nonempty compact, and AB 18.19 plus AB 18.13 yield a Borel selector. Thus (P3-kernel) implies (A8c-attain). This is the promised normal-integrand route, but it requires closed graph of the kernel/payoff representative, not merely of the support relation.

Target 4: Honest framing of the relaxation

The relaxed theorem should read: Branch B Tier 1 closes under standing assumptions plus (A5) plus (A8c-attain); Tier 2 closes under standing assumptions plus (A5) plus (A8c-attain) plus (A9c-calib). This exactly replaces the previous rowwise l.s.c. condition in the landed consolidator with the weaker selector-attainment condition that L8 actually consumes. 

phil_reny_route_memo

 

theorem_2_extension_proof

 The primitive routes are: continuous trust-region projection plus continuous Bayes implementation; closed-graph kernel/payoff representative; and u.h.c. Bayes-action graphs when they represent the realized payoff correspondence rather than an arbitrary selector. The distinction is not decorative bookkeeping, it is the little trapdoor under the stage: u.h.c. menus and closed support graphs alone do not control the selected payoff function.

[DERIVED] (A8c-lsc) can be relaxed to (A8c-attain). (A8c-attain) is implied by the corrected primitive forms of (P1), (P2), and (P3): u.h.c. payoff-graph implementation, continuous trust-region projection with continuous Bayes implementation, or closed-graph kernel/payoff representative.

Assumption Changes

[ASSUMPTION-] (A8c-lsc) replaced by (A8c-attain).

[ASSUMPTION+] (A8c-attain): τ-a.e. rowwise argmin nonempty with Borel selector.

[CLARIFICATION] Bare u.h.c. of a Bayes-action menu and bare closedness of mixed-strategy support graphs are not sufficient unless they control the realized payoff graph.

Breakdown Amendments

[BREAKDOWN_AMEND] Update theorem statement to use (A8c-attain).

[BREAKDOWN_AMEND] Replace L8c-Half-2 “l.s.c. gives argmin” with “(A8c-attain) gives selector directly.”

[BREAKDOWN_AMEND] Document primitive routes as (P1-cg), (P2-continuous implementation), and (P3-kernel), rather than weaker menu/support-only formulations.

Status Summary

L8 status: PROVED-CONDITIONAL on (A5) + (A8c-attain).

(A8c-lsc) replaced by strictly weaker (A8c-attain).

(A8c-attain) is implied by continuous trust-region projection with continuous Bayes implementation, closed-graph kernel/payoff representative, or u.h.c. compact payoff-graph implementation.

The suggested downward-spike strictness example is corrected: downward spikes preserve l.s.c.; upward spikes away from the minimizer give the desired strict inclusion.

Exact Next Obstacle

Ready for reviewer. Next relaxation target: (A5).
