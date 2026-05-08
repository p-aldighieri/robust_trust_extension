# Formalizer Response — Notation Alignment and Formal Statement

**Chat URL**: https://chatgpt.com/g/g-p-69b612c07c108191a7597062801a020e-robust-trust-alternative-proof/c/69b61765-5fe4-832a-ad39-ea18e1ae6026
**Thought time**: 29m 27s
**Role**: formalizer
**Date**: 2026-03-15

---

1. Notation Dictionary

I use the paper’s notation as canonical. The paper’s model notation comes from Section 2 and Section 3.3, while the sketch’s notation comes from Piotr’s two-page note and the project state summary. 


 


Sketch symbol / phrase	Paper-canonical notation	Meaning	Inconsistency / note
bad AI	misaligned adviser	Strategic adviser, realized with probability 
1
−
𝛼
1−α	Terminology only
DM	agent	Decision maker / receiver	Terminology only

𝜔
ω	
𝜔
∈
Ω
ω∈Ω	State	Consistent

𝜇
0
μ
0
	​

	
𝜇
0
∈
Δ
(
Ω
)
μ
0
	​

∈Δ(Ω)	Prior over states	Consistent

𝑚
m	
𝑚
∈
Δ
(
Ω
)
m∈Δ(Ω)	Reported message	Consistent

𝜇
μ	primitive adviser posterior is 
𝑠
∈
𝑀
=
supp
⁡
(
𝜏
)
s∈M=supp(τ); later the paper also uses 
𝜇
μ as a generic belief variable	Adviser’s true posterior before misreporting	Minor mismatch: in the model section the paper’s primitive symbol is 
𝑠
s, not 
𝜇
μ

𝜋
(
𝑚
∣
𝜇
)
π(m∣μ)	
𝛽
(
𝑚
∣
𝜇
)
β(m∣μ)	Misaligned adviser’s reporting rule conditional on true posterior 
𝜇
μ	Major inconsistency: in the paper, 
𝜋
π is already the primitive signal function 
𝜋
:
Ω
→
Δ
(
𝑆
)
π:Ω→Δ(S)
paper’s 
𝜋
π	
𝜋
:
Ω
→
Δ
(
𝑆
)
π:Ω→Δ(S)	Primitive information structure of the adviser	No sketch counterpart after relabeling the bad-AI strategy as 
𝛽
β

𝜏
τ	
𝜏
∈
Δ
(
Δ
(
Ω
)
)
τ∈Δ(Δ(Ω))	Unconditional distribution of adviser posteriors	Consistent

𝛼
α	
𝛼
α	Alignment probability	Consistent

𝛾
𝑚
γ
m
	​

	
𝑃
𝛽
(
⋅
∣
𝑚
)
P
β
	​

(⋅∣m)	Agent’s posterior over states after message 
𝑚
m, induced by 
𝛽
β	Sketch-specific notation; paper-canonical object is 
𝑃
𝛽
(
⋅
∣
𝑚
)
P
β
	​

(⋅∣m)
sketch 
𝑃
(
𝑚
)
P(m)	better written as 
𝑞
𝛽
(
𝑚
)
:
=
Pr
⁡
𝛽
(
𝑚
)
q
β
	​

(m):=Pr
β
	​

(m)	Marginal probability of message 
𝑚
m under truthful + misaligned mixing	Major inconsistency: in the paper, 
𝑃
(
𝑚
)
P(m) already denotes the trust-region boundary map from Definition 1
paper’s 
𝑃
(
𝑚
)
P(m)	
𝑃
(
𝑚
)
∈
𝑇
P(m)∈T	“Closest safe interpretation” / trust-region projection of off-region message 
𝑚
m	Different object from the sketch’s message probability

𝜎
(
𝑎
∣
𝑚
)
σ(a∣m)	
𝜎
:
Δ
(
Ω
)
×
Θ
→
Δ
(
𝐴
)
σ:Δ(Ω)×Θ→Δ(A), or equivalently 
𝜎
∼
(
𝜎
^
(
𝑚
)
)
𝑚
∈
Δ
(
Ω
)
σ∼(
σ
^
(m))
m∈Δ(Ω)
	​

	Agent strategy after message and type	Sketch suppresses 
𝜃
θ; only matches paper notation after extra specialization

𝑎
⋆
(
𝜇
)
a
⋆
(μ)	
𝜎
^
⋆
(
𝜇
)
∈
arg
⁡
max
⁡
𝜎
^
𝑈
(
𝜎
^
,
𝜇
)
σ
^
⋆
(μ)∈argmax
σ
^
	​

U(
σ
^
,μ)	Bayes-optimal response at belief 
𝜇
μ	Inconsistency: paper optimizes over private strategies 
𝜎
^
σ
^
, not necessarily over pure actions

𝑈
(
𝜋
,
𝜎
)
U(π,σ)	
𝑈
(
𝛽
,
𝜎
)
U(β,σ) in Appendix A.2	Zero-sum stage-game payoff for fixed adversarial strategy and agent strategy	Overload: paper also uses 
𝑈
(
𝜎
)
U(σ) and 
𝑈
(
𝜎
^
,
𝜇
)
U(
σ
^
,μ)

𝑈
(
𝑎
⋆
(
𝛾
𝑚
)
,
𝛾
𝑚
)
U(a
⋆
(γ
m
	​

),γ
m
	​

) in effect	
𝑈
(
𝜎
^
⋆
(
𝛾
𝑚
)
,
𝛾
𝑚
)
U(
σ
^
⋆
(γ
m
	​

),γ
m
	​

)	Agent’s Bayes value at induced posterior	Sketch compresses private strategy into a pure action

supp
⁡
(
𝜋
(
⋅
∣
𝜇
⋆
)
)
supp(π(⋅∣μ
⋆
))	
supp
⁡
(
𝛽
(
⋅
∣
𝜇
⋆
)
)
supp(β(⋅∣μ
⋆
))	Support of misaligned adviser’s report distribution at posterior 
𝜇
⋆
μ
⋆
	Inherits the 
𝜋
/
𝛽
π/β conflict

𝛿
𝑎
⋆
(
𝛾
𝑚
)
δ
a
⋆
(γ
m
	​

)
	​

	degenerate private strategy at message 
𝑚
m	Deterministic committed decision rule	Canonical only under the pure-action specialization

𝜀
ε	
𝜀
ε	Local perturbation parameter	Consistent

Paper objects suppressed by the sketch. The sketch drops or compresses the model’s original adviser signal 
𝑠
s, the agent’s type signal function 
𝑓
f, the truthful aligned strategy 
i
d
id, the strategy spaces 
𝐵
B and 
Σ
Σ, and especially the paper’s private-strategy notation 
𝜎
^
σ
^
. It also suppresses the paper’s reuse of 
𝑃
(
𝑚
)
P(m) as the trust-region projection map. 


2. Posterior Belief Derivation (Block B)

The sketch’s posterior formula is correct after translating the sketch’s bad-AI strategy 
𝜋
(
𝑚
∣
𝜇
)
π(m∣μ) into the paper’s adversarial strategy 
𝛽
(
𝑚
∣
𝜇
)
β(m∣μ), and after renaming the sketch’s marginal-message term 
𝑃
(
𝑚
)
P(m) to 
𝑞
𝛽
(
𝑚
)
q
β
	​

(m) to avoid collision with the paper’s trust-region map 
𝑃
(
𝑚
)
P(m). 


Let 
𝛽
:
𝑀
→
Δ
(
𝑀
)
β:M→Δ(M) denote the misaligned adviser’s strategy, using the paper’s harmless restriction to messages in 
𝑀
M. For 
𝑚
∈
𝑀
m∈M, define

𝑞
𝛽
(
𝜔
,
𝑚
)
:
=
Pr
⁡
𝛽
(
𝜔
,
𝑚
)
,
𝑞
𝛽
(
𝑚
)
:
=
∑
𝜔
∈
Ω
𝑞
𝛽
(
𝜔
,
𝑚
)
.
q
β
	​

(ω,m):=
β
Pr
	​

(ω,m),q
β
	​

(m):=
ω∈Ω
∑
	​

q
β
	​

(ω,m).

The sketch starts from Bayes’ rule:

𝑃
𝛽
(
𝜔
∣
𝑚
)
=
Pr
⁡
𝛽
(
𝑚
∣
𝜔
)
𝜇
0
(
𝜔
)
∑
𝜔
′
∈
Ω
Pr
⁡
𝛽
(
𝑚
∣
𝜔
′
)
𝜇
0
(
𝜔
′
)
.
P
β
	​

(ω∣m)=
∑
ω
′
∈Ω
	​

Pr
β
	​

(m∣ω
′
)μ
0
	​

(ω
′
)
Pr
β
	​

(m∣ω)μ
0
	​

(ω)
	​

.

Now decompose 
Pr
⁡
𝛽
(
𝑚
∣
𝜔
)
Pr
β
	​

(m∣ω) into the aligned and misaligned parts.

For the aligned adviser, truthful reporting means that the reported message equals the adviser’s posterior. Since the paper renormalizes the adviser’s signal into the posterior itself, for every 
𝜇
∈
𝑀
μ∈M,

𝜇
0
(
𝜔
)
Pr
⁡
(
𝑠
=
𝜇
∣
𝜔
)
=
𝜏
(
𝜇
)
𝜇
(
𝜔
)
.
μ
0
	​

(ω)Pr(s=μ∣ω)=τ(μ)μ(ω).

Therefore the truthful contribution to the joint law of 
(
𝜔
,
𝑚
)
(ω,m) is

𝛼
 
𝜏
(
𝑚
)
𝑚
(
𝜔
)
.
ατ(m)m(ω).

For the misaligned adviser, if the true adviser posterior is 
𝜇
μ, then with probability 
𝛽
(
𝑚
∣
𝜇
)
β(m∣μ) he reports 
𝑚
m. Hence the misaligned contribution is

(
1
−
𝛼
)
∑
𝜇
∈
𝑀
𝜏
(
𝜇
)
𝛽
(
𝑚
∣
𝜇
)
𝜇
(
𝜔
)
.
(1−α)
μ∈M
∑
	​

τ(μ)β(m∣μ)μ(ω).

So the full joint law is

𝑞
𝛽
(
𝜔
,
𝑚
)
=
𝛼
 
𝜏
(
𝑚
)
𝑚
(
𝜔
)
+
(
1
−
𝛼
)
∑
𝜇
∈
𝑀
𝜏
(
𝜇
)
𝛽
(
𝑚
∣
𝜇
)
𝜇
(
𝜔
)
.
q
β
	​

(ω,m)=ατ(m)m(ω)+(1−α)
μ∈M
∑
	​

τ(μ)β(m∣μ)μ(ω).

Summing over 
𝜔
ω gives the marginal probability of 
𝑚
m:

𝑞
𝛽
(
𝑚
)
=
∑
𝜔
∈
Ω
𝑞
𝛽
(
𝜔
,
𝑚
)
=
𝛼
 
𝜏
(
𝑚
)
+
(
1
−
𝛼
)
∑
𝜇
∈
𝑀
𝜏
(
𝜇
)
𝛽
(
𝑚
∣
𝜇
)
,
q
β
	​

(m)=
ω∈Ω
∑
	​

q
β
	​

(ω,m)=ατ(m)+(1−α)
μ∈M
∑
	​

τ(μ)β(m∣μ),

because 
∑
𝜔
𝑚
(
𝜔
)
=
1
∑
ω
	​

m(ω)=1 and 
∑
𝜔
𝜇
(
𝜔
)
=
1
∑
ω
	​

μ(ω)=1.

Therefore the paper-canonical posterior is

𝑃
𝛽
(
𝜔
∣
𝑚
)
=
𝛼
 
𝜏
(
𝑚
)
𝑚
(
𝜔
)
+
(
1
−
𝛼
)
∑
𝜇
∈
𝑀
𝜏
(
𝜇
)
𝛽
(
𝑚
∣
𝜇
)
𝜇
(
𝜔
)
𝛼
 
𝜏
(
𝑚
)
+
(
1
−
𝛼
)
∑
𝜇
∈
𝑀
𝜏
(
𝜇
)
𝛽
(
𝑚
∣
𝜇
)
.
P
β
	​

(ω∣m)=
ατ(m)+(1−α)∑
μ∈M
	​

τ(μ)β(m∣μ)
ατ(m)m(ω)+(1−α)∑
μ∈M
	​

τ(μ)β(m∣μ)μ(ω)
	​

.

This is exactly the sketch’s 
𝛾
𝑚
(
𝜔
)
γ
m
	​

(ω), after the two renamings

𝜋
(
𝑚
∣
𝜇
)
⇝
𝛽
(
𝑚
∣
𝜇
)
,
𝑃
(
𝑚
)
⇝
𝑞
𝛽
(
𝑚
)
.
π(m∣μ)⇝β(m∣μ),P(m)⇝q
β
	​

(m).

It is also equivalent to the sketch’s denominator

∑
𝜔
∈
Ω
[
𝛼
𝑚
(
𝜔
)
𝜏
(
𝑚
)
+
(
1
−
𝛼
)
∑
𝜇
∈
𝑀
𝛽
(
𝑚
∣
𝜇
)
𝜇
(
𝜔
)
𝜏
(
𝜇
)
]
,
ω∈Ω
∑
	​

[αm(ω)τ(m)+(1−α)
μ∈M
∑
	​

β(m∣μ)μ(ω)τ(μ)],

but the simplified form above is the cleaner canonical rewrite. 


[ASSUMPTION+] If the posterior is meant to be defined for every 
𝑚
∈
𝑀
m∈M, the sketch is implicitly using that 
𝑞
𝛽
(
𝑚
)
>
0
q
β
	​

(m)>0 for all 
𝑚
∈
𝑀
m∈M. This is automatic when 
𝛼
>
0
α>0, because then 
𝑞
𝛽
(
𝑚
)
≥
𝛼
𝜏
(
𝑚
)
>
0
q
β
	​

(m)≥ατ(m)>0 on 
𝑀
=
supp
⁡
(
𝜏
)
M=supp(τ). If 
𝛼
=
0
α=0, one has to restrict to on-path messages instead. This positivity requirement is not stated in Theorem 2. 


[GAP] The sketch compresses the identity

𝜇
0
(
𝜔
)
Pr
⁡
(
𝑠
=
𝜇
∣
𝜔
)
=
𝜏
(
𝜇
)
𝜇
(
𝜔
)
μ
0
	​

(ω)Pr(s=μ∣ω)=τ(μ)μ(ω)

and the truthful/misaligned decomposition of 
Pr
⁡
(
𝑚
∣
𝜔
)
Pr(m∣ω) into one line. That step is correct, but it is not justified in the note itself. 


3. Formal Theorem Statement

The paper’s Theorem 2 says:

Any robustly rationalizable strategy is optimal. If 
𝑀
M and 
Θ
Θ are finite, a robustly rationalizable strategy exists. 


Finite-case target of the alternative proof (Blocks A-F)

A precise paper-language statement of what the sketch is trying to establish is:

Theorem 2, finite-case alternative target.
Work in the paper’s model. Since 
Ω
Ω is already finite in Section 2 of the paper, additionally assume that 
𝑀
=
supp
⁡
(
𝜏
)
M=supp(τ) and 
Θ
Θ are finite. Then there exist an agent strategy 
𝜎
⋆
∈
Σ
σ
⋆
∈Σ and a misaligned-adviser strategy 
𝛽
⋆
∈
𝐵
β
⋆
∈B (WLOG supported on 
𝑀
M) such that:

𝛽
⋆
β
⋆
 is adversarial against 
𝜎
⋆
σ
⋆
;

for every 
𝑚
∈
𝑀
m∈M,

𝜎
^
⋆
(
𝑚
)
∈
arg
⁡
max
⁡
𝜎
^
′
𝑈
 ⁣
(
𝜎
^
′
,
𝑃
𝛽
⋆
(
⋅
∣
𝑚
)
)
.
σ
^
⋆
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
⋆
	​

(⋅∣m)).

Equivalently, 
(
𝜎
⋆
,
𝛽
⋆
)
(σ
⋆
,β
⋆
) is a saddle point, so

sup
⁡
𝜎
∈
Σ
inf
⁡
𝛽
∈
𝐵
𝑈
(
𝛽
,
𝜎
)
=
inf
⁡
𝛽
∈
𝐵
sup
⁡
𝜎
∈
Σ
𝑈
(
𝛽
,
𝜎
)
.
σ∈Σ
sup
	​

β∈B
inf
	​

U(β,σ)=
β∈B
inf
	​

σ∈Σ
sup
	​

U(β,σ).

Hence 
𝜎
⋆
σ
⋆
 is robustly rationalizable and optimal.

This is the finite-case version of the paper’s Theorem 2, written in the paper’s own language of adversarial strategies, induced posteriors 
𝑃
𝛽
(
⋅
∣
𝑚
)
P
β
	​

(⋅∣m), and robust rationalizability. The alternative proof is intended to replace the paper’s Sion-based existence argument with a first-order-conditions plus envelope-theorem argument. 


Comparison with the paper’s Theorem 2

The asymmetry in the paper’s theorem matters:

The clause “any robustly rationalizable strategy is optimal” is the global optimality clause.

The clause “if 
𝑀
M and 
Θ
Θ are finite, a robustly rationalizable strategy exists” is the finite-case existence clause.

The sketch is really targeting the existence / saddle-point / minimax part in the finite case. Once such a saddle point is obtained, the optimality clause follows by the same standard saddle-point implication used in the paper’s Appendix A.2. So the sketch is not claiming a different theorem. It is claiming a different route to the same finite-case theorem. 


A further comparison point: if one additionally imports the paper’s Theorem 1, then the resulting optimal 
𝜎
⋆
σ
⋆
 can be taken equivalent to a trust region strategy with connected trust region. That connected-trust-region conclusion is not proved in the sketch; it comes from the paper separately. 


What is explicitly left open (Block G)

The sketch explicitly leaves open the extension of this FOC/envelope argument to infinite message spaces. So Blocks A-F only aim at a finite-dimensional proof of Theorem 2. They do not claim an infinite-
𝑀
M proof of the same route. 


4. Implicit Assumptions Inventory

These are assumptions used by the sketch but not stated in the paper’s Theorem 2 itself. The list below distinguishes genuine restrictions from removable simplifications. 


Assumption	Precise statement	Where it appears in the sketch	Restriction or simplification?
[ASSUMPTION+] On-path positivity / effectively 
𝛼
>
0
α>0	The posterior 
𝑃
𝛽
(
⋅
∣
𝑚
)
P
β
	​

(⋅∣m) is treated as defined for every 
𝑚
∈
𝑀
m∈M, which requires 
𝑞
𝛽
(
𝑚
)
>
0
q
β
	​

(m)>0 for all such 
𝑚
m	Posterior formula 
𝛾
𝑚
γ
m
	​

, later universal quantification over messages	Simplification if one restricts to on-path messages; genuine extra condition if one wants all 
𝑚
∈
𝑀
m∈M covered uniformly
[ASSUMPTION+] Finite-dimensional case	“Everything is finite,” meaning at least finite 
𝑀
M and finite 
Θ
Θ; 
Ω
Ω is already finite in the paper	Opening sentence of the sketch	Genuine restriction, but exactly the intended scope of Blocks A-F
[ASSUMPTION+] Pure-action Bayes response exists	For each belief 
𝜇
μ, there is a selected optimal action 
𝑎
⋆
(
𝜇
)
a
⋆
(μ)	“where 
𝑎
⋆
(
𝜇
)
a
⋆
(μ) denotes the optimal action for belief 
𝜇
μ” and throughout	Genuine restriction as written; removable only by rewriting the proof in terms of Bayes-optimal private strategies 
𝜎
^
σ
^

[ASSUMPTION+] Private type can be suppressed	The agent’s payoff can be written as 
𝑢
(
𝑎
,
𝜔
)
u(a,ω), and the agent strategy as 
𝜎
(
𝑎
∣
𝑚
)
σ(a∣m), with no 
𝜃
θ-dependence	All payoff formulas in the sketch	Genuine restriction as written; removable by reformulating the sketch in paper notation
[ASSUMPTION+] Single-valued Bayes-optimal selection is regular enough	The chosen 
𝑎
⋆
(
𝜇
)
a
⋆
(μ) behaves regularly enough under perturbations of 
𝜇
μ for the envelope step to make sense	Envelope-theorem paragraph	Genuine extra analytical condition
[ASSUMPTION+] Interior perturbations capture the first-order problem	Derivatives with respect to 
𝜋
(
𝑚
1
∣
𝜇
⋆
)
−
𝜋
(
𝑚
2
∣
𝜇
⋆
)
π(m
1
	​

∣μ
⋆
)−π(m
2
	​

∣μ
⋆
) represent the relevant feasible directions of the adversary’s simplex problem	First-order-condition step	Genuine extra issue unless a full KKT / boundary analysis is supplied
[ASSUMPTION+] Restriction to messages in 
𝑀
M	The adversarial adviser can be analyzed using only reports in 
𝑀
M	Implicit in the sums and in the finite-support setup	Removable simplification; the paper gives the WLOG justification
[ASSUMPTION+] Commitment problem separates by realized posterior 
𝜇
μ	Once the DM commits to 
𝑚
↦
𝛿
𝑎
⋆
(
𝛾
𝑚
)
m↦δ
a
⋆
(γ
m
	​

)
	​

, the bad-AI optimization can be solved separately for each realized 
𝜇
μ	“Now, consider bad AI’s problem, for each realized 
𝜇
μ separately”	Simplification, but it still needs proof
[ASSUMPTION+] Envelope-theorem hypotheses hold	The relevant Milgrom-Segal or Sinander theorem applies to the agent’s value function in beliefs	“For now, let’s just assume that the envelope theorem holds…” and the last-page discussion	Genuine extra condition
5. Gap Register

These are the places where the sketch is incomplete, either explicitly or materially. I do not fill any of them here. 


Gap	What is claimed	What is missing	Severity
[GAP] Posterior derivation compressed into one line	The sketch jumps from Bayes’ rule to the explicit mixture formula for 
𝛾
𝑚
γ
m
	​

	The truthful/misaligned decomposition of 
Pr
⁡
(
𝑚
∣
𝜔
)
Pr(m∣ω), and the identity 
𝜇
0
(
𝜔
)
Pr
⁡
(
𝑠
=
𝜇
∣
𝜔
)
=
𝜏
(
𝜇
)
𝜇
(
𝜔
)
μ
0
	​

(ω)Pr(s=μ∣ω)=τ(μ)μ(ω), are omitted	MODERATE
[GAP] “AI moves first” step	The sketch says to assume the AI moves first so the DM knows the distribution of posteriors	No formal equivalence is given between this reformulated timing and the original simultaneous / commitment setup in the paper	CRITICAL
[GAP] First-order derivative formula	The sketch writes a derivative of the DM payoff with respect to 
𝜋
(
𝑚
1
∣
𝜇
⋆
)
−
𝜋
(
𝑚
2
∣
𝜇
⋆
)
π(m
1
	​

∣μ
⋆
)−π(m
2
	​

∣μ
⋆
)	No full derivation is given, including the dependence of all 
𝛾
𝑚
γ
m
	​

 and message probabilities on the perturbation, and the simplex feasibility constraints	CRITICAL
[GAP] Envelope-theorem elimination of the indirect term	The sketch says the second term can be dropped by an envelope theorem	The exact theorem is not stated, the parameter space is not formalized, and hypotheses such as continuity, selection, and treatment of nonunique optimizers are not verified	CRITICAL
[GAP] Posterior-derivative bound implies envelope theorem	The sketch argues that a bounded derivative of posterior beliefs is enough	The logical bridge from “small perturbation of posteriors” to the exact Milgrom-Segal / Sinander hypotheses is not provided, and support changes in 
𝜋
π are not addressed	CRITICAL
[GAP] FOC inequality / equality on supports	The sketch concludes 
∑
𝜔
[
𝑢
(
𝑎
⋆
(
𝛾
𝑚
1
)
,
𝜔
)
−
𝑢
(
𝑎
⋆
(
𝛾
𝑚
2
)
,
𝜔
)
]
𝜇
⋆
(
𝜔
)
≥
0
∑
ω
	​

[u(a
⋆
(γ
m
1
	​

	​

),ω)−u(a
⋆
(γ
m
2
	​

	​

),ω)]μ
⋆
(ω)≥0, with equality on-support	No KKT-style boundary analysis is provided; the note also switches from 
𝜇
⋆
μ
⋆
 to 
𝜇
μ in the subsequent displayed condition, creating a real notation ambiguity	CRITICAL
[GAP] Preservation of optimality in the commitment game	The sketch says that the same bad-AI strategy remains optimal after commitment	A complete optimization argument over the full simplex of message distributions for each 
𝜇
μ is not supplied; only a support-based intuition is given	MODERATE
[GAP] Translation back to the paper’s 
𝜎
^
,
𝜃
σ
^
,θ-framework	The sketch works with 
𝑢
(
𝑎
,
𝜔
)
u(a,ω) and 
𝑎
⋆
(
𝜇
)
a
⋆
(μ)	No proof is given that the argument survives unchanged when the paper’s private types and private strategies are reinstated	CRITICAL
[GAP] Infinite-
𝑀
M extension	The sketch explicitly says there are “two more things to establish,” one of which is extension to infinite message space	The note ends by stating that the author has no idea how to extend the argument	CRITICAL