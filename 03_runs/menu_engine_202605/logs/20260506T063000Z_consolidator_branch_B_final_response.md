
========
ROLE: user (id=8146abfa-a101-433e-ac5f-fa61035ae35c)
========
# Consolidator pass — Branch B FINAL: Theorem 2 conditional extension

You are the Consolidator in the soft-scaffolding workflow.

## Your job

Assemble Branch A + Branch B into a **single coherent proof report**
delivering the **final conditional theorem**:

> **Theorem (Robust Trust Theorem 2 — infinite extension).** Under the
> standing hypotheses of Dworczak & Smolin (2026), plus
> **(A5):** $\pi(\cdot\mid\omega)\sim\tau$ for every $\omega\in\Omega$,
> and **(A8c-lsc):** for the Branch-A maximizer's value-preserving
> representative, $m\mapsto\ell_{\sigma^*}(m,s) := \sum_\omega s(\omega)\,p_\omega(m)$
> is lower semicontinuous on $M$ for τ-a.e. $s$, the existence direction
> of Theorem 2 extends to **infinite $M$ and infinite (compact metric)
> $\Theta$**:
>
> 1. There exists $\sigma^*\in\Sigma$ with
>    $U(\sigma^*) = U^* := \sup_{\sigma\in\Sigma} U(\sigma)$ (Branch A).
> 2. There exists $\beta^*\in B$ adversarial against $\sigma^*$:
>    $U(\beta^*,\sigma^*) = \inf_{\beta\in B} U(\beta,\sigma^*) = U^*$
>    (Branch B / L8 under (A8c-lsc)).
> 3. (When $\alpha > 0$.) $\hat\sigma^*(m) \in \arg\max_{\hat\sigma'} U(\hat\sigma', P_{\beta^*}(\cdot\mid m))$
>    for τ-a.e. $m\in M$ (Branch B / L9 under (A8c-lsc)).
>
> Hence $\sigma^*$ is **robustly rationalizable** in the sense of
> Definition 2, in the paper's a.e./on-path reading.

This is the **publishable conditional theorem** extending Dworczak–Smolin
Theorem 2 beyond finite $M$ and $\Theta$.

## Inputs

- phil_reny_route_memo.md — live route memo, all PROVED statuses.
- phil_reny_bundle.md, prior_attempts_digest.md, paper PDF.
- logs/20260506T030000Z_consolidator_branch_A_existence_response.md —
  Branch A consolidator (already reviewer-PASS'd 2026-05-06).
- All L1–L9 prover and reviewer logs.

## Target

A clean, self-contained proof report — **the final theorem document**.
Structured for a mathematician who hasn't followed the orchestration.
Include both Branch A and Branch B, the Needed Assumptions (A5) and
(A8c-lsc), and an honest "Discussion" section addressing:
- Why (A5) is needed (perfect-revelation counterexample).
- Why (A8c-lsc) is needed (the $g(m) = m$ for $m>0$, $g(0) = 1$
  counterexample).
- Whether (A8c-lsc) can be relaxed (open problem).
- Comparison with the paper's finite-case proof.

## Output Format (use this exactly)


markdown
# Robust Trust Theorem 2 — infinite-$M$, infinite-$\Theta$ conditional extension

## 1. Original Theorem 2 and the gap

(One paragraph. State Theorem 2 from the paper, including the finite
qualifier. Note that the optimality direction is finiteness-free; the
existence direction is the gap.)

## 2. Main Theorem (this paper)

**Theorem.** *Under the standing hypotheses of Dworczak–Smolin (2026)
— $\Omega$ finite with full-support prior $\mu_0$, $A$ and $\Theta$
compact metric, $u$ bounded and continuous in $a$, conditional
independence of $s$ and $\theta$ given $\omega$ — and the added
assumptions:*
- **(A5)** *$\pi(\cdot\mid\omega)\sim\tau$ for every $\omega\in\Omega$,*
- **(A8c-lsc)** *for the Branch-A maximizer's value-preserving
  representative $\hat\sigma^*$, the rowwise message payoff
  $\ell_{\sigma^*}(\cdot, s) := \sum_\omega s(\omega)\,p_\omega(\cdot)$
  is lower semicontinuous on $M$ for τ-a.e. $s$,*

*the existence direction of Theorem 2 holds for infinite $M$ and
infinite $\Theta$:*
1. *There exists $\sigma^*\in\Sigma$ with $U(\sigma^*) = U^*$.*
2. *There exists $\beta^*\in B$ adversarial against $\sigma^*$:
   $U(\beta^*,\sigma^*) = U^*$.*
3. *If $\alpha > 0$, $\hat\sigma^*(m)\in\arg\max_{\hat\sigma'} U(\hat\sigma', P_{\beta^*}(\cdot\mid m))$
   for τ-a.e. $m\in M$.*

(Phrase precisely.)

## 3. Strategy

(Two-stage Phil Reny path. (Stage 1) Restricted-game existence of $\sigma^*$
via Mertens (1986) + Balder (1988); Lusin lift to all measurable
adversaries. (Stage 2) Adversary-side attainment of $\beta^*$ via
rowwise contact-selection under (A8c-lsc); per-message Bayes-optimality
via saddle + KRN.)

## 4. Definitions and Notation

(Cleanly: $\Omega$, $\mu_0$, $\pi(\cdot\mid\omega)$, $\tau$, $M$, $A$,
$\Theta$, $f$, $u$, $\alpha$, $\Sigma$, $B$, $F$, $U_F$, $U$, $U^*$,
$V^*$, $T_\lambda$, $K_n$, $K^*$, $\bar f$, $\lambda$, $\sigma^*$,
$p_\omega$, $\ell$, $\beta^*$, $m^*$, $q$, $P_{\beta^*}$.)

## 5. Proof — Branch A: existence of optimal $\sigma^*$ under (A5)

### Lemma L1 (constant-marginal continuity)
Statement, sketch citing Balder Theorem 2.2 p. 268.

### Lemma L2 (compactness of $\Sigma$)
Statement, sketch citing Balder §2 Theorem 2.3(a) + common-kernel
extraction.

### Lemma L7 ($\theta$ in the base)
Statement, sketch.

### Lemma L3+L4 (Mertens minmax + restricted-game $\sigma^*$)
Statement, sketch citing Mertens (1986) Cor B.

### Lemma L5 (Lusin-thick compacts under (A5))
Statement, sketch.

### Lemma L6 (Lusin lift contradiction)
Statement, sketch (smoothing kernel construction).

### Branch A capstone
Proof: $V^* = U^*$ via $F\hookrightarrow B$ + L6. $\sigma^*$ achieves $U^*$.

## 6. Proof — Branch B: adversary attainment under (A8c-lsc)

### Lemma L8a (restricted dual value formula)
$\inf_F U_F(\sigma^*,\varphi) = \text{const} + (1-\alpha)\int_M \operatorname*{essinf}_m \ell_{\sigma^*}(m,s)\,\tau(ds)$.

### Lemma L8c-Half-1 (pointwise inf = essential inf τ-a.e.)
Via Jankov–von Neumann + L6 bottom-density.

### Lemma L8c-Half-2 (pointwise attainment under (A8c-lsc))
Berge / measurable minimum + KRN selector.

### Lemma L8 ($\beta^*$ adversarial)
$\beta^*(dm\mid s) := \delta_{m^*(s)}(dm)$ achieves $\inf_B U(\cdot,\sigma^*) = U^*$.

### Lemma L9 (per-message Bayes-optimality)
Decomposition + saddle + KRN.

## 7. Discussion

### Why (A5) is needed
Perfect-revelation counterexample: $\Omega = \{0,1\}$, $\pi(\cdot\mid\omega) = \delta_{\delta_\omega}$.
Without (A5), L5 support-thickness fails.

### Why (A8c-lsc) is needed
$\ell(m,s) = m$ for $m>0$, $\ell(0,s) = 1$ counterexample. Without
(A8c-lsc), the Lusin shells can have a τ-null upward jump, blocking
pointwise attainment of $\inf_m\ell$.

### Open: can (A8c-lsc) be relaxed?
The construction-side fix would be to build a Branch-A maximizer
with rowwise l.s.c. baked into the representative. This is open. The
current proof structure does not deliver such a representative.

### Comparison with paper's finite-case proof
Finite $M$, $\Theta$ ⇒ $B$, $\Sigma$ are products of finite simplices.
Sion 4.2' applies directly. Our extension via Mertens + Balder + Lusin
+ (A5) + (A8c-lsc) recovers the same conclusion in the infinite case.

## 8. Assumptions Used

- Standing (Dworczak–Smolin 2026).
- (A5): $\pi(\cdot\mid\omega)\sim\tau$ for every $\omega$.
- (A8c-lsc): rowwise l.s.c. message payoff for value-preserving
  representative.

## 9. Open questions

- Removal of (A8c-lsc).
- $\alpha = 0$ case for L9.
- Lean formalization (left as future work; the prior attempt's
  axiomatized GameSetup is structurally weaker than this proof).

## 10. References

- Dworczak & Smolin 2026.
- Balder 1988, Math. Op. Res. 13(2).
- Mertens 1986, Int. J. Game Theory 15(4).
- Aliprantis–Border 2006 (KRN, Berge, etc.).
- Bogachev 2007 (Lusin, disintegration).


## Discipline

- Use paper-canonical notation throughout.
- Cite each lemma's reviewer-passing log file by name (or by route-memo
  lemma label if logs are not visible).
- Sketches are 1–3 sentences each. Do not re-derive in full.
- Be honest about (A5) and (A8c-lsc) as added assumptions.
- Length budget: 3000–5000 words.

## Scope Policy

This is the FINAL consolidator pass. Produce the publishable theorem
document. Do not propose new lemmas.


========
ROLE: assistant (id=140c838c-88d7-4219-bd05-1a1883272f58)
========
Robust Trust Theorem 2 — infinite-$M$, infinite-$\Theta$ conditional extension
1. Original Theorem 2 and the gap

Dworczak and Smolin’s Theorem 2 states that every robustly rationalizable strategy is optimal, and that, if both the adviser-belief support M and the agent type space Θ are finite, a robustly rationalizable strategy exists. The optimality direction is a saddle-point verification and does not use finiteness. The existence direction is where finiteness enters: Appendix A.2 uses finite products of simplices, continuity of finite sums, and Sion’s minimax theorem; the paper explicitly notes that verifying Sion-type continuity in infinite cheap-talk-like strategy spaces is difficult because messages affect payoffs endogenously. 

Robust_trust_Dworczak_Smolin

 

objective_statement

2. Main Theorem (this paper)

Theorem. Under the standing hypotheses of Dworczak–Smolin (2026) — Ω finite with full-support prior μ
0
	​

, A and Θ compact metric, u bounded and continuous in a, conditional independence of s and θ given ω — and the added assumptions:

(A5) π(⋅∣ω)∼τ for every ω∈Ω,

(A8c-lsc) for the Branch-A maximizer's value-preserving representative 
σ
^
∗
, the rowwise message payoff

ℓ
σ
∗
	​

(⋅,s):=
ω∈Ω
∑
	​

s(ω)p
ω
	​

(⋅)

is lower semicontinuous on M for τ-a.e. s,

the existence direction of Theorem 2 holds for infinite M and infinite compact metric Θ, in the paper’s a.e./on-path reading:

There exists σ
∗
∈Σ with

U(σ
∗
)=U
∗
:=
σ∈Σ
sup
	​

U(σ).

There exists β
∗
∈B adversarial against σ
∗
:

U(β
∗
,σ
∗
)=
β∈B
inf
	​

U(β,σ
∗
)=U
∗
.

If α>0, then

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

(⋅∣m))for τ-a.e. m∈M.

Consequently, for α>0, σ
∗
 is robustly rationalizable in the sense of Definition 2, with “for all m∈M” interpreted as the paper’s a.e./on-path condition for infinite spaces.

3. Strategy

The proof follows the two-stage path suggested by Phil Reny. Stage 1 restricts the misaligned adviser to τ-dominated kernels, proves existence of a restricted-game maximin σ
∗
 using Balder’s constant-marginal weak-convergence machinery and Mertens’s asymmetric minimax theorem, and then uses a Lusin support-thick lift to show that the same σ
∗
 secures the value against all measurable adviser kernels. Stage 2 constructs an actual adversarial β
∗
 for that σ
∗
: L8 identifies the restricted dual value rowwise, proves pointwise-infimum equality, and, under (A8c-lsc), selects measurable rowwise minimizers. L9 then gives per-message Bayes-optimality from the saddle/decomposition argument and Kuratowski–Ryll-Nardzewski selection. The route is documented in the live Phil-Reny route memo, with Branch A reviewer-passed and Branch B closed conditionally under (A8c-lsc). 

phil_reny_bundle

 

phil_reny_route_memo

4. Definitions and Notation

Let Ω be finite, with full-support prior μ
0
	​

. The adviser’s posterior is s∈Δ(Ω), with state-conditional law π(⋅∣ω). Its unconditional law is

τ(ds)=
ω∈Ω
∑
	​

μ
0
	​

(ω)π(ds∣ω),

and M=supp(τ)⊆Δ(Ω). Since Ω is finite, Δ(Ω) is compact metric, hence M is compact metric.

The agent observes θ∈Θ, where Θ is compact metric, with conditional law f(⋅∣ω). Conditional on ω, s and θ are independent. The action space A is compact metric, and u(a,ω,θ) is bounded and continuous in a.

An agent strategy is a measurable kernel

σ:M×Θ→Δ(A),

equivalently a measurable family 
σ
^
(m):Θ→Δ(A). Let Σ be the set of such strategies. A misaligned adviser strategy is a measurable kernel

β:M→Δ(M),

and B is the set of all such kernels.

For β∈B, the payoff is

U(β,σ)
	​

=α
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
Θ
	​

∫
A
	​

u(a,ω,θ)σ(da∣s,θ)f(dθ∣ω)π(ds∣ω)
+(1−α)
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

∫
Θ
	​

∫
A
	​

u(a,ω,θ)σ(da∣m,θ)f(dθ∣ω)β(dm∣s)π(ds∣ω).
	​


The robust payoff is U(σ)=inf
β∈B
	​

U(β,σ), and

U
∗
=
σ∈Σ
sup
	​

U(σ).

Let F be the convex set of jointly measurable densities φ:M×M→[0,∞) such that

∫
M
	​

φ(m∣s)τ(dm)=1for τ-a.e. s.

Each φ∈F induces the dominated kernel

β
φ
	​

(dm∣s)=φ(m∣s)τ(dm),

and

U
F
	​

(σ,φ):=U(β
φ
	​

,σ).

Define the restricted value

V
∗
:=
σ∈Σ
sup
	​

φ∈F
inf
	​

U
F
	​

(σ,φ).

For the Balder topology, set

f
ˉ
	​

:=
ω
∑
	​

μ
0
	​

(ω)f(⋅∣ω),λ:=τ⊗
f
ˉ
	​


on X:=M×Θ. The topology T
λ
	​

 on Σ is the stable weak topology for kernels from X into A, modulo λ-a.e. equality.

The Lusin construction gives compact sets

K
1
	​

⊆K
2
	​

⊆⋯⊆M,K
∗
:=
n≥1
⋃
	​

K
n
	​

,

with π(K
∗
∣ω)=1 for all ω, and with support-thickness on each K
n
	​

.

For the Branch-A maximizer σ
∗
, define

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
(da∣m,θ)f(dθ∣ω),

and

ℓ
σ
∗
	​

(m,s):=
ω∈Ω
∑
	​

s(ω)p
ω
	​

(m).

The Branch-B selector is m
∗
:M→M, and

β
∗
(dm∣s):=δ
m
∗
(s)
	​

(dm).

The message marginal under β
∗
 is

q:=ατ+(1−α)(m
∗
)
#
	​

τ.

Finally, P
β
∗
	​

(⋅∣m) is the Bayesian posterior over Ω obtained by disintegrating the state-message joint law

ν
β
∗
	​

(ω,dm)=αμ
0
	​

(ω)π(dm∣ω)+(1−α)μ
0
	​

(ω)∫
M
	​

β
∗
(dm∣s)π(ds∣ω)

with respect to its M-marginal q.

5. Proof — Branch A: existence of optimal σ
∗
 under (A5)
Lemma L1 (constant-marginal continuity)

Statement. For each fixed φ∈F, the map

σ↦U
F
	​

(σ,φ)

is continuous on (Σ,T
λ
	​

).

Sketch. The aligned term is handled by Balder’s weak convergence of transition probabilities. For the misaligned term, dominated kernels rewrite the integral over the fixed base marginal τ(dm)f(dθ∣ω), with density

r
ω
φ
	​

(m):=∫
M
	​

φ(m∣s)π(ds∣ω)∈L
1
(τ).

The integrand is measurable in (m,θ), continuous in a, and L
1
-dominated, so Balder Theorem 2.2, p. 268 applies. Record: route memo L1, reviewer-cleared 2026-05-05. 

phil_reny_route_memo

Lemma L2 (compactness of Σ)

Statement. Σ, identified modulo λ-a.e. equality and endowed with T
λ
	​

, is compact. The single-base topology is equivalent to simultaneous Balder-stable convergence under the finitely many state-contingent base laws used in the payoff.

Sketch. Balder §2 Theorem 2.3(a) gives compactness of the transition-probability space into compact metric A. The common-kernel extraction step uses standard-Borel disintegration on X×A, finite mixtures, and correctly directed Radon-Nikodym multiplications from each state-contingent base law into λ. Record: logs/20260506T003500Z_rereview_L2_compactness_patched_response.md, as cited in route memo L2. 

phil_reny_route_memo

Lemma L7 (θ in the base)

Statement. L1 and L2 remain valid for full strategies σ:M×Θ→Δ(A), equivalently for message-indexed private strategies 
σ
^
(m):Θ→Δ(A).

Sketch. The type coordinate θ is simply part of the Balder base X=M×Θ. No continuity in θ is required: Balder’s Carathéodory condition asks for measurability in the base and continuity only in the action coordinate a. Record: logs/20260506T010000Z_prover_L7_theta_reintroduction_response.md and logs/20260506T011500Z_reviewer_L7_theta_reintroduction_response.md. 

phil_reny_route_memo

Lemma L3+L4 (Mertens minmax + restricted-game σ
∗
)

Statement. The restricted game has a value and an optimal pure agent strategy:

σ∈Σ
max
	​

φ∈F
inf
	​

U
F
	​

(σ,φ)=
φ∈F
inf
	​

σ∈Σ
max
	​

U
F
	​

(σ,φ),

and there exists σ
∗
∈Σ with

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
.

Sketch. Apply Mertens (1986) Corollary B to the compact Hausdorff Balder quotient Σ, the arbitrary convex set F, and the payoff U
F
	​

, which is continuous in σ by L1. Mertens’s mixed objects collapse to pure objects by affinity in σ, affinity in φ, barycenter existence on the compact convex Balder quotient, and convexity of F. The lower-left value function σ↦inf
φ
	​

U
F
	​

(σ,φ) is upper semicontinuous, hence attains its maximum. Records: logs/20260506T013000Z_prover_L3_mertens_minmax_response.md, logs/20260506T014500Z_reviewer_L3_mertens_minmax_response.md; L4 folded into L3. 

phil_reny_bundle

 

phil_reny_route_memo

Lemma L5 (Lusin-thick compacts under (A5))

Statement. Under (A5), σ
∗
 admits a value-preserving representative and compact sets K
n
	​

↑K
∗
 such that π(K
∗
∣ω)=1 for every ω, 
σ
^
∗
 is continuous on each K
n
	​

 in the stable private-strategy topology, and every relative open neighborhood in K
n
	​

 has positive π(⋅∣ω)-mass for every ω.

Sketch. Apply Polish-valued Lusin to the map m↦
σ
^
∗
(m), first with reference measure τ. Then replace the Lusin compact C
n
	​

 by K
n
	​

=supp(τ∣
C
n
	​

	​

). Assumption (A5) transfers this support to every π(⋅∣ω), giving simultaneous support-thickness. Record: logs/20260506T020000Z_prover_L5_lusin_thick_compacts_response.md, logs/20260506T021500Z_reviewer_L5_lusin_thick_compacts_response.md. 

phil_reny_route_memo

Lemma L6 (Lusin lift contradiction)

Statement. Under the standing hypotheses and (A5), for every β∈B and every ε>0, there exists φ
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
.

Sketch. The aligned term is unchanged, so only the misaligned term matters. On each Lusin shell K
n
	​

∖K
n−1
	​

, uniform continuity of p
ω
	​

 lets one smooth any message y into a small τ-positive neighborhood inside K
n
	​

; support-thickness supplies positive denominators, and Tonelli gives a jointly measurable dominated density φ
ε
	​

. The smoothing changes all p
ω
	​

-payoffs by at most ε, uniformly after summing over finitely many states. Record: logs/20260506T023000Z_prover_L6_lusin_lift_response.md, logs/20260506T024500Z_reviewer_L6_lusin_lift_response.md. 

phil_reny_route_memo

Branch A capstone

Since F↪B, for every σ,

φ∈F
inf
	​

U
F
	​

(σ,φ)≥
β∈B
inf
	​

U(β,σ),

so V
∗
≥U
∗
. For the restricted maximizer σ
∗
, L6 gives

β∈B
inf
	​

U(β,σ
∗
)≥V
∗
.

Therefore

U
∗
≥
β∈B
inf
	​

U(β,σ
∗
)≥V
∗
≥U
∗
,

hence equality holds throughout:

U(σ
∗
)=
β∈B
inf
	​

U(β,σ
∗
)=V
∗
=U
∗
.

Thus Branch A proves existence of an optimal σ
∗
 for the unrestricted infinite-M, infinite-Θ game under (A5). Record: logs/20260506T030000Z_consolidator_branch_A_existence_response.md, reviewer pass at logs/20260506T031500Z_reviewer_branch_A_consolidator_response.md. 

phil_reny_route_memo

6. Proof — Branch B: adversary attainment under (A8c-lsc)
Lemma L8a (restricted dual value formula)

For fixed σ
∗
, the restricted dominated-adversary value is

φ∈F
inf
	​

U
F
	​

(σ
∗
,φ)=C
al
	​

(σ
∗
)+(1−α)∫
M
	​

m∈M
essinf
	​

ℓ
σ
∗
	​

(m,s)τ(ds),

where C
al
	​

(σ
∗
) is the aligned payoff term and the essential infimum is with respect to τ(dm).

The key identity is Bayes plausibility:

μ
0
	​

(ω)π(ds∣ω)=s(ω)τ(ds),

so the misaligned term becomes rowwise linear:

(1−α)∫
M
	​

∫
M
	​

ℓ
σ
∗
	​

(m,s)φ(m∣s)τ(dm)τ(ds).

Taking the infimum over all densities φ(⋅∣s) gives the rowwise essential infimum. Record: logs/20260506T033000Z_prover_L8a_dual_attainment_response.md, logs/20260506T034500Z_reviewer_L8a_dual_attainment_response.md, with the route memo noting the minor editorial patch. 

phil_reny_route_memo

Lemma L8c-Half-1 (pointwise inf = essential inf τ-a.e.)

Let

b(s):=
m∈M
inf
	​

ℓ
σ
∗
	​

(m,s),e(s):=
m∈M
essinf
	​

ℓ
σ
∗
	​

(m,s).

Then

b(s)=e(s)for τ-a.e. s.

The proof uses a Jankov–von Neumann measurable near-minimizer on the set where b<e. If that set had positive τ-measure, the resulting measurable deterministic deviation β(dm∣s)=δ
m(s)
	​

(dm) would beat the restricted value. L6 then smooths that deviation into a dominated φ∈F, contradicting the restricted optimality of σ
∗
. Record: route memo L8c-Half-1, Branch B complete under (A8c-lsc). 

phil_reny_route_memo

Lemma L8c-Half-2 (pointwise attainment under (A8c-lsc))

Under (A8c-lsc), for τ-a.e. s, the map

m↦ℓ
σ
∗
	​

(m,s)

is lower semicontinuous on compact M. Hence it attains its minimum. Since the integrand is Borel and rowwise lower semicontinuous, the measurable minimum theorem gives measurability of the value function, and Kuratowski–Ryll-Nardzewski gives a measurable selector

m
∗
(s)∈arg
m∈M
min
	​

ℓ
σ
∗
	​

(m,s)for τ-a.e. s.

Record: route memo L8c-Half-2, including the counterexample showing that this attainment can fail without (A8c-lsc). 

phil_reny_route_memo

Lemma L8 (β
∗
 adversarial)

Define

β
∗
(dm∣s):=δ
m
∗
(s)
	​

(dm).

Then β
∗
∈B and

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
inf
	​

ℓ
σ
∗
	​

(m,s)τ(ds).

By L8c-Half-1, the pointwise infimum equals the essential infimum τ-a.e.; by L8a and the Branch-A capstone, this common value is U
∗
. Thus

U(β
∗
,σ
∗
)=
β∈B
inf
	​

U(β,σ
∗
)=U
∗
.

So β
∗
 is adversarial against σ
∗
. Record: route memo L8, Branch B complete under (A8c-lsc). 

phil_reny_route_memo

Lemma L9 (per-message Bayes-optimality)

Let

q=ατ+(1−α)(m
∗
)
#
	​

τ

be the equilibrium message marginal. The state-message joint law induced by β
∗
 disintegrates as

ν
β
∗
	​

(ω,dm)=P
β
∗
	​

(ω∣m)q(dm).

For every σ,

U(β
∗
,σ)=∫
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

The L9 proof combines this decomposition with the Branch-A/L8 saddle inequality and a measurable-selection contradiction: if 
σ
^
∗
(m) failed to be Bayes-optimal on a q-positive set, KRN would select a measurable improving private strategy on that set, producing a global σ
′
 that violates the saddle inequality. Therefore

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

When α>0, q≥ατ, hence the same conclusion holds τ-a.e. Record: logs/20260506T053000Z_prover_L9_per_message_bayes_optimality_response.md, logs/20260506T060000Z_reviewer_L9_per_message_bayes_optimality_response.md. 

phil_reny_route_memo

7. Discussion
Why (A5) is needed

Assumption (A5) is not cosmetic. The forward direction π(⋅∣ω)≪τ follows from the full-support prior and τ=∑
ω
	​

μ
0
	​

(ω)π(⋅∣ω); the added content is the reverse direction τ≪π(⋅∣ω) for every state. L5 needs common support-thickness: every relative open neighborhood in every Lusin compact must have positive probability under every π(⋅∣ω). Without this, the smoothing denominators in L6 can vanish.

The clean counterexample is perfect revelation:

Ω={0,1},π(⋅∣0)=δ
δ
0
	​

	​

,π(⋅∣1)=δ
δ
1
	​

	​

.

Then M={δ
0
	​

,δ
1
	​

}, but the relative open set {δ
0
	​

} has zero mass under π(⋅∣1), and {δ
1
	​

} has zero mass under π(⋅∣0). The common Lusin-thick construction breaks. This is recorded in L5 of the route memo. 

phil_reny_route_memo

Why (A8c-lsc) is needed

Branch A gives value security but not adversary-side attainment. Branch B must turn rowwise essential infima into actual rowwise minimizers. Without lower semicontinuity, the infimum can be approached but not attained. The route memo’s model counterexample is the single-row payoff

g(m)=mfor m>0,g(0)=1,M=[0,1].

Here inf
m
	​

g(m)=0, and the τ-essential infimum is also 0, but no m∈M attains the value. The obstruction is a τ-null upward jump at 0. Lusin continuity on shells does not rule out this cross-shell pathology; rowwise lower semicontinuity does. 

phil_reny_route_memo

Open: can (A8c-lsc) be relaxed?

The proof only needs the consequence of (A8c-lsc): for τ-a.e. s, a measurable selector m
∗
(s) attaining

m
inf
	​

ℓ
σ
∗
	​

(m,s)=
m
essinf
	​

ℓ
σ
∗
	​

(m,s).

Lower semicontinuity on compact M is a clean sufficient condition, not a known necessary one. A more constructive route would build the Branch-A maximizer with a rowwise l.s.c. representative already baked in. That remains open. The present proof structure does not produce such a representative from the standing hypotheses alone.

Comparison with paper's finite-case proof

In the finite case, B and Σ are products of finitely many simplices, the payoff is a finite sum, compactness is elementary, and Sion’s Theorem 4.2' applies directly. The finite topology also makes rowwise attainment automatic; every function on finite M attains its minimum. The infinite extension replaces this compact simplex picture with Balder compactness for transition kernels, Mertens’s asymmetric minimax theorem, Lusin support-thick smoothing under (A5), and rowwise measurable contact selection under (A8c-lsc). This route avoids the product-narrow/Sion failure and escape-of-mass obstruction documented in prior attempts. 

Robust_trust_Dworczak_Smolin

 

prior_attempts_digest

 

phil_reny_route_memo

8. Assumptions Used

Standing Dworczak–Smolin hypotheses: Ω finite with full-support μ
0
	​

; A and Θ compact metric; u bounded and continuous in a; s and θ conditionally independent given ω; Borel measurability for infinite spaces; M=supp(τ). 

Robust_trust_Dworczak_Smolin

(A5): π(⋅∣ω)∼τ for every ω. This is used in L5 and L6 to obtain common support-thick Lusin compacts and to smooth arbitrary measurable adviser kernels into τ-dominated kernels.

(A8c-lsc): for the Branch-A maximizer’s value-preserving representative, m↦ℓ
σ
∗
	​

(m,s) is lower semicontinuous on compact M for τ-a.e. s. This is used in L8c-Half-2 to obtain pointwise minimizers and a KRN measurable selector.

No finiteness of M or Θ is used.

9. Open questions

Removal of (A8c-lsc). The minimal needed conclusion is measurable rowwise attainment of the pointwise infimum. Whether this can be derived from the standing hypotheses plus (A5), or forced by a better choice of Branch-A representative, remains open.

α=0 case for L9. L9 gives q-a.e. Bayes-optimality. When α>0, q≥ατ, so this upgrades to τ-a.e. on-path optimality. When α=0, that implication disappears.

Lean formalization. A previous Lean route axiomatized a GameSetup with compactness, continuity, and convexity already assumed. That is structurally weaker than the present proof, whose hard content is precisely Balder compactness, Mertens reduction, Lusin lifting, and measurable rowwise selection. 

prior_attempts_digest

10. References

Dworczak, Piotr, and Alex Smolin. 2026. Robust Trust. February 9, 2026. 

Robust_trust_Dworczak_Smolin

Balder, Erik J. 1988. “Generalized Equilibrium Results for Games with Incomplete Information.” Mathematics of Operations Research 13(2): 265–276. Used for stable weak convergence of transition probabilities and compactness of kernel spaces.

Mertens, Jean-François. 1986. “The Minmax Theorem for U.S.C.-L.S.C. Payoff Functions.” International Journal of Game Theory 15(4): 237–250. Used for the asymmetric restricted-game minimax theorem.

Aliprantis, Charalambos D., and Kim C. Border. 2006. Infinite Dimensional Analysis. Used for Kuratowski–Ryll-Nardzewski selection, measurable maximum/minimum theorems, and Berge-style arguments.

Bogachev, Vladimir I. 2007. Measure Theory. Used for Lusin theorem, standard-Borel disintegration, and measurable-kernel regularity.
