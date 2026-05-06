
========
ROLE: user (id=ad097b88-3b5f-4c45-8f3c-85cb0fe9a3d9)
========
# Prover pass — L9b: Calibrated worst-message transport lemma

You are the Prover in the soft-scaffolding workflow.

## Goal for this pass

Prove (or honestly disprove) the **calibrated worst-message transport
lemma**, which is the only viable route to closing the L9 saddle gap
without dropping the Definition 2 conclusion.

## Inputs

- phil_reny_route_memo.md, phil_reny_bundle.md,
  prior_attempts_digest.md, paper PDF.
- theorem_2_extension_proof.md (current consolidator output, with the
  L9 gap).
- L9 reviewer log + L9-saddle-gap breakdown
  (logs/20260506T080000Z_breakdown_L9_saddle_gap_response.md).

## Target — Lemma L9b (calibrated transport)

Let $\sigma^*$ be the Branch-A optimal strategy under standing + (A5) +
(A8c-lsc). Define the rowwise argmin correspondence
$$
D(s) := \arg\min_{m\in M} \ell_{\sigma^*}(m, s)
$$
(nonempty closed by (A8c-lsc)) and the **Bayes-optimal-belief**
correspondence
$$
C(m) := \{\mu\in\Delta(\Omega) : \hat\sigma^*(m) \in \arg\max_{\hat\sigma'} U(\hat\sigma', \mu)\}.
$$

**Claim.** There exists a measurable kernel $\beta^*\in B$ such that
1. **Adversariality:** $\beta^*(D(s)\mid s) = 1$ for τ-a.e. $s$.
2. **Posterior calibration:** for the message marginal $q = \alpha\tau + (1-\alpha)\int\beta^*(\cdot\mid s)\,\tau(ds)$,
   $P_{\beta^*}(\cdot\mid m) \in C(m)$ for $q$-a.e. $m$.

If both hold, L8 closes (β* attains $\inf_\beta U(\beta,\sigma^*) = U^*$
because it concentrates on rowwise minimizers) and L9 closes
(per-message Bayes-optimality is direct from posterior calibration).

## Subquestions you MUST address

1. **What does $C(m)$ look like?** $C(m)$ is the set of beliefs $\mu$
   on $\Omega$ at which the agent's specific private strategy
   $\hat\sigma^*(m)$ is Bayes-optimal. Generically, $C(m)$ is a closed
   convex polytope (intersection of half-spaces). Verify this: for each
   alternative private strategy $\hat\sigma'$, the set
   $\{\mu : U(\hat\sigma^*(m), \mu) \ge U(\hat\sigma', \mu)\}$ is a
   closed half-space in $\Delta(\Omega)$. $C(m)$ is the intersection.
   - Special case: if $\hat\sigma^*(m)$ is Bayes-optimal at the *truthful*
     posterior $\mu = m$, then $m \in C(m)$. Verify: this is the
     standard "aligned-Bayes-optimal" property and follows from
     $\sigma^*$ achieving the aligned-truthful supremum (when α>0,
     Branch A's value structure forces this — verify).
2. **Hall/Strassen-style necessary inequalities.** The transport
   problem is: find a kernel $\beta^*: M\to\Delta(M)$ with
   - first-marginal property: $\beta^*(D(s)\mid s) = 1$;
   - second-marginal/posterior property: $P_{\beta^*}(\cdot\mid m) \in C(m)$.
   Necessary conditions (Strassen / Hall):
   - For every measurable subset $E\subseteq M$, certain mass-balance
     inequalities must hold relating $\tau(\{s : D(s)\subseteq E\})$
     to $\int_E P_{\beta^*}(\cdot\mid m)\,q(dm)$.
   - State precisely what these inequalities require.
3. **A clean sufficient condition.** Try: if for τ-a.e. $s$, the
   rowwise argmin $D(s)$ is a **single point** $m^*(s)$, AND
   $m^*(s) \in C(m^*(s))^{-1}\{s\}$ (i.e., the truthful posterior $s$
   sits in $C(m^*(s))$), then $\beta^*(dm\mid s) = \delta_{m^*(s)}$
   works. Verify this case.
   - This is a strong special case but covers many natural models.
4. **Existence under (A5) + (A8c-lsc) alone?** Honest evaluation: do
   these standing hypotheses force the transport problem to be
   feasible, or is a further assumption needed?
   - Try a small example: $|\Omega| = 2$, $M = [0,1]$, $\Theta$
     singleton, $A = [0,1]$, $u(a, 0) = -a^2$, $u(a, 1) = -(1-a)^2$.
     Compute $\sigma^*$, $D(s)$, $C(m)$ explicitly. Is the transport
     feasible?
5. **Honest abort.** If the transport is generally infeasible under
   standing + (A5) + (A8c-lsc), state the **additional** assumption
   needed (call it (A9c-calib)) and prove L9b under it. Then the
   published theorem is conditional on standing + (A5) + (A8c-lsc) +
   (A9c-calib).

## Output Format


markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: L9b — calibrated worst-message transport

**Verdict:** PROVED unconditionally / PROVED-CONDITIONAL on new
assumption (A9c-calib) / DISPROVED.

**Argument:**

Step 1: Structure of $C(m)$ and $D(s)$.
Justification: ...

Step 2: Special case (singleton argmin + truthful-posterior
calibration).
Justification: ...

Step 3: General case — Hall/Strassen conditions.
Justification: ...

Step 4: Existence of β*.
Justification: ...

[DERIVED] (State exactly what was established.)

## Assumption Changes

- [ASSUMPTION+] (If a new condition (A9c-calib) is needed.)

## Breakdown Amendments

- [BREAKDOWN_AMEND] (Route memo updates if needed.)

## Status Summary

- L9b status: PROVED / PROVED-CONDITIONAL on (A9c-calib) / DISPROVED.
- L9 status: PROVED via L9b / OPEN / theorem must be weakened.

## Exact Next Obstacle

(If L9b closes L9 without new assumption: the proof package is complete
under (A5) + (A8c-lsc); update the consolidator. If L9b adds (A9c-calib):
update the consolidator with the additional assumption. If L9b fails:
weaken the theorem to drop Definition 2.)


## Non-Negotiable Rules

- Cite Aliprantis-Border, Bogachev where invoking selection /
  disintegration / transport theorems.
- Do not invoke product-narrow Sion or any dead-route machinery.
- **Be honest** about whether (A9c-calib) is needed.
- Length budget: 2500–4000 words.

## Scope Policy

L9b is the focused target. If L9b closes L9, the next pass is the
Branch B FINAL consolidator (revised). If L9b fails, propose either a
new sub-target or theorem-weakening.


========
ROLE: assistant (id=071290f9-1bab-459b-a9fe-f156e5ce862b)
========
Goal for This Pass

This pass tests whether the new L9b “calibrated worst-message transport” lemma follows from the current assumptions, standing hypotheses plus (A5) plus (A8c-lsc), or whether it must be added as a separate feasibility condition. The key distinction is that L8 only gives a worst-message adversary, while Definition 2 also needs the posterior induced at each on-path message to make the agent’s prescribed private strategy Bayes-optimal. That second requirement is a global transport and calibration constraint, not a pointwise minimization fact. The finite paper proof gets it from a saddle point; the current infinite route has exactly this saddle gap. 

Robust_trust_Dworczak_Smolin

 

phil_reny_route_memo

 

theorem_2_extension_proof

Main Work
Target 1: L9b, calibrated worst-message transport

Verdict: PROVED-CONDITIONAL on a new assumption (A9c-calib).
Under standing plus (A5) plus (A8c-lsc) alone, the pass does not prove the transport feasible. The missing object is precisely a Hall/Strassen-style calibrated coupling between source beliefs s, worst messages m∈D(s), and Bayes-optimality cells C(m).

Argument:

Step 1: Structure of C(m) and D(s)

For any private strategy 
σ
^
, define its state-contingent payoff profile

w
σ
^
	​

(ω):=∫
Θ
	​

∫
A
	​

u(a,ω,θ)
σ
^
(da∣θ)f(dθ∣ω).

Then

U(
σ
^
,μ)=
ω∈Ω
∑
	​

μ(ω)w
σ
^
	​

(ω)=μ⋅w
σ
^
	​

.

Hence, for fixed m,

C(m)={μ∈Δ(Ω):μ⋅w
σ
^
∗
(m)
	​

≥μ⋅w
σ
^
′
	​

 for every private strategy 
σ
^
′
}.

For each alternative 
σ
^
′
, the constraint

μ⋅(w
σ
^
∗
(m)
	​

−w
σ
^
′
	​

)≥0

is a closed half-space in the finite-dimensional affine space containing Δ(Ω). Therefore C(m) is closed and convex.

A small correction is needed: under the standing compact-action, compact-type hypotheses, C(m) need not be a polytope. It is a polytope when the feasible payoff set is polyhedral, for example finite actions and finite types. With continuum A or continuum Θ, the feasible payoff set can have a smooth exposed frontier, and C(m) can be a non-polyhedral closed convex cell. The half-space description is correct; the word “polytope” is only correct under an added polyhedrality condition.

For D(s), under (A8c-lsc), the map m↦ℓ
σ
∗
	​

(m,s) is lower semicontinuous on compact M for τ-a.e. s. Thus

D(s)=arg
m∈M
min
	​

ℓ
σ
∗
	​

(m,s)

is nonempty and compact for τ-a.e. s. Standard measurable maximum/minimum and Kuratowski–Ryll-Nardzewski selection results give measurability of the argmin correspondence and measurable selectors after modifying on a null set; these are the standard Aliprantis–Border measurable maximum and KRN tools. Disintegration of couplings below uses the standard-Borel disintegration theorem, as in Bogachev’s measure-theoretic formulation.

The special claim “if 
σ
^
∗
(m) is Bayes-optimal at the truthful posterior m, then m∈C(m)” is immediate from the definition of C(m). But the stronger statement that Branch A with α>0 forces m∈C(m) for all m is false in general. Trust-region strategies deliberately fail to be truthful-Bayes outside the trust region: the action at an extreme message is Bayes-optimal for a clipped boundary belief, not for the literal message. The aligned term gives a force toward truthful Bayes optimality, but the same message-contingent private strategy is also exposed to the adversarial term. So m∈C(m) must be verified or assumed where it is used; it is not a free consequence of Branch A.

Step 2: Clean sufficient case, singleton argmin plus convex calibration

Assume that for τ-a.e. s, D(s)={m
∗
(s)}, with measurable m
∗
, and assume:

s∈C(m
∗
(s))τ-a.e.

Also, when α>0, assume the aligned truthful component is calibrated:

m∈C(m)τ-a.e.

The second condition is unnecessary if α=0.

Set

β
∗
(dm∣s)=δ
m
∗
(s)
	​

(dm).

Then adversariality is immediate because β
∗
(D(s)∣s)=1.

For posterior calibration, fix a target message m. The posterior induced by m is a barycenter of two kinds of beliefs:

the aligned truthful contribution, which contributes the belief m itself;

the misaligned contribution from all source beliefs s such that m
∗
(s)=m.

By assumption, every misaligned source belief in the fiber m
∗
−1
(m) lies in C(m), and the aligned truthful belief m also lies in C(m). Since C(m) is convex and closed, the posterior, being a convex barycenter of these beliefs, lies in C(m). Thus

P
β
∗
	​

(⋅∣m)∈C(m)q-a.e.

This proves the strong singleton sufficient condition.

The prompt’s proposed condition s∈C(m
∗
(s)) is enough for the misaligned part, but one must also account for the aligned truthful mass when α>0. That small extra clause is not cosmetic; the posterior is formed from both aligned and misaligned message-generating channels.

Step 3: General Hall/Strassen conditions

The right way to write the general problem is as a coupling problem. Let

γ(ds,dm):=τ(ds)β(dm∣s).

Then γ is a probability measure on M×M with first marginal τ. Adversariality is exactly

γ({(s,m):m∈D(s)})=1.

Let r:=γ
2
	​

 be the misaligned message marginal. A necessary Hall condition for a feasible coupling with second marginal r is, for every Borel E⊆M,

τ({s:D(s)⊆E})≤r(E)≤τ({s:D(s)∩E

=∅}).

Equivalently, for every Borel source set A⊆M,

τ(A)≤r(D(A)),D(A):=
s∈A
⋃
	​

D(s).

On compact metric spaces with closed relation graph, these are the usual Hall/Strassen conditions for existence of a coupling supported on the relation m∈D(s). The disintegration γ(ds,dm)=τ(ds)β(dm∣s) is then supplied by the standard disintegration theorem for probability measures on standard Borel spaces, as in Bogachev.

Now add posterior calibration. Define the total message marginal

q:=ατ+(1−α)r.

Using Bayes plausibility,

μ
0
	​

(ω)π(ds∣ω)=s(ω)τ(ds),

the state-message vector measure induced by γ is

Λ(E):=α∫
E
	​

mτ(dm)+(1−α)∫
M×E
	​

sγ(ds,dm)∈R
Ω
.

Its components sum to q(E), so Λ≪q, and

dq
dΛ
	​

(m)=P
β
	​

(⋅∣m)q-a.e.

Thus calibration is the pointwise cone condition

dq
dΛ
	​

(m)∈C(m)q-a.e.

Equivalently, using support functions

h
C(m)
	​

(v):=
μ∈C(m)
sup
	​

v⋅μ,

posterior calibration requires, for every Borel E⊆M and every v∈Q
∣Ω∣
,

v⋅Λ(E)≤∫
E
	​

h
C(m)
	​

(v)q(dm).

Because the rational vectors are dense and C(m) is closed convex, these inequalities are equivalent to dΛ/dq∈C(m) q-a.e.

There are also useful componentwise bounds forced by the support relation:

α∫
E
	​

m(ω)τ(dm)+(1−α)∫
{s:D(s)⊆E}
	​

s(ω)τ(ds)≤Λ
ω
	​

(E)

and

Λ
ω
	​

(E)≤α∫
E
	​

m(ω)τ(dm)+(1−α)∫
{s:D(s)∩E

=∅}
	​

s(ω)τ(ds).

These are necessary for every state ω and Borel E.

The punchline: (A5) gives common support-thickness for the Lusin lift, and (A8c-lsc) gives rowwise minimizers. Neither assumption states these Hall/calibration inequalities. They are global mass-balance restrictions connecting D, C, τ, and α.

Step 4: Existence of β
∗
 under (A9c-calib)

Add the following assumption.

(A9c-calib), calibrated worst-message transport feasibility. There exists a probability measure γ∈Δ(M×M) such that:

γ
1
	​

=τ;

γ({(s,m):m∈D(s)})=1;

with r=γ
2
	​

, q=ατ+(1−α)r, and

Λ(E)=α∫
E
	​

mτ(dm)+(1−α)∫
M×E
	​

sγ(ds,dm),

one has

dq
dΛ
	​

(m)∈C(m)q-a.e.

Because M is compact metric, hence standard Borel, Bogachev’s disintegration theorem gives a measurable kernel β
∗
(dm∣s) such that

γ(ds,dm)=τ(ds)β
∗
(dm∣s).

Condition 2 gives

β
∗
(D(s)∣s)=1τ-a.e.

This is adversariality in the rowwise sense.

Moreover, by the Bayes formula above,

P
β
∗
	​

(⋅∣m)=
dq
dΛ
	​

(m)q-a.e.

Condition 3 gives

P
β
∗
	​

(⋅∣m)∈C(m)q-a.e.

So L9b is proved under (A9c-calib).

Finally, because β
∗
 puts mass only on D(s), it attains the rowwise minimum:

U(β
∗
,σ
∗
)=C
al
	​

(σ
∗
)+(1−α)∫
M
	​

m∈M
min
	​

ℓ
σ
∗
	​

(m,s)τ(ds).

By the L8 value formula and Branch A capstone, this equals U
∗
. Hence β
∗
 is adversarial against σ
∗
, and posterior calibration gives the Definition 2 Bayes-optimality conclusion directly. This avoids the invalid “rowwise adversariality implies saddle” step flagged by the L9 gap. The prior product-narrow/Sion route should not be revived; that obstruction is already documented in the prior attempts digest. 

prior_attempts_digest

 

phil_reny_route_memo

Step 5: Binary quadratic example

Take

Ω={0,1},M=[0,1],Θ={θ},A=[0,1],
u(a,0)=−a
2
,u(a,1)=−(1−a)
2
.

For belief μ∈[0,1],

U(a,μ)=−(1−μ)a
2
−μ(1−a)
2
=−(a−μ)
2
−μ(1−μ).

The unique Bayes-optimal action is

a
∗
(μ)=μ.

Thus, for any strategy a(m),

C(m)={μ:a(m)=μ}.

For the robust binary-state solution with a nontrivial trust interval

T=[
μ
	​

,
μ
	​

],

the optimal strategy is

a
∗
(m)=clip(m;[
μ
	​

,
μ
	​

]).

Hence

C(m)=
⎩
⎨
⎧
	​

{
μ
	​

},
{m},
{
μ
	​

},
	​

m≤
μ
	​

,
m∈[
μ
	​

,
μ
	​

],
m≥
μ
	​

.
	​


For source belief s, the adversary minimizes payoff by choosing the farthest trusted action. With

b=
2
μ
	​

+
μ
	​

	​

,
D(s)=
⎩
⎨
⎧
	​

[
μ
	​

,1],
[0,
μ
	​

],
[0,
μ
	​

]∪[
μ
	​

,1],
	​

s<b,
s>b,
s=b.
	​


The calibrated transport is feasible exactly because the endpoint beliefs solve the binary balancing equations:

ατ([0,
μ
	​

])+(1−α)τ([b,1])
α∫
0
μ
	​

	​

sτ(ds)+(1−α)∫
b
1
	​

sτ(ds)
	​

=
μ
	​

,
ατ([
μ
	​

,1])+(1−α)τ([0,b])
α∫
μ
	​

1
	​

sτ(ds)+(1−α)∫
0
b
	​

sτ(ds)
	​

=
μ
	​

.

These are precisely the one-dimensional calibration conditions in the paper’s binary-state construction. Quantile transport then splits the adversary’s indifference so that every low message induces posterior 
μ
	​

, every high message induces posterior 
μ
	​

, and every interior message is truthful and induces posterior m. For α≤1/2, the trust region collapses to the prior μ
0
	​

, and the usual jamming transport makes the posterior μ
0
	​

 at on-path messages. Thus the example is feasible, but for a substantive reason: the endpoint equations are exactly the calibrated transport equations in one dimension. 

Robust_trust_Dworczak_Smolin

[DERIVED] L9b is established under (A9c-calib). The current assumptions plus (A8c-lsc) give compact rowwise argmin sets and measurable worst-message selectors, but not the global posterior-calibrated Hall/Strassen coupling. The extra feasibility condition is needed to close Definition 2 by this route.

Assumption Changes

[ASSUMPTION+] (A9c-calib): There exists a calibrated worst-message coupling γ∈Δ(M×M) with first marginal τ, support contained in {(s,m):m∈D(s)}, and induced posterior derivative

dq
d
	​

[αmτ(dm)+(1−α)∫sγ(ds,dm)]∈C(m)q-a.e.

where q=ατ+(1−α)γ
2
	​

.

A stronger, easier sufficient assumption is: D(s)={m
∗
(s)} a.e., s∈C(m
∗
(s)) a.e., and, when α>0, m∈C(m) τ-a.e.

Breakdown Amendments

[BREAKDOWN_AMEND] L8 under (A8c-lsc) gives a rowwise adversarial β, but not a saddle and not Definition 2.

[BREAKDOWN_AMEND] The prior L9 saddle/decomposition proof must be downgraded unless the chosen β is known to be calibrated, minimax, or otherwise a best-response rationalizer.

[BREAKDOWN_AMEND] The Branch B final theorem should add (A9c-calib), or weaken the conclusion to optimality plus adversary-side attainment without robust rationalizability.

Status Summary

L9b status: PROVED-CONDITIONAL on (A9c-calib).

L9 status: PROVED via L9b only under (A9c-calib).

Theorem status: The infinite M, infinite Θ Definition 2 existence theorem must be conditional on standing plus (A5) plus (A8c-lsc) plus (A9c-calib), unless a later pass proves the calibrated Hall/Strassen inequalities from more primitive assumptions.

Exact Next Obstacle

Update the consolidator: Branch A remains intact; L8 remains intact under (A8c-lsc); L9 must be replaced by L9b and made conditional on (A9c-calib). Without (A9c-calib), the theorem should be weakened to drop the Definition 2 robust-rationalizability conclusion and retain only optimal σ
∗
 plus adversary-side attainment.
