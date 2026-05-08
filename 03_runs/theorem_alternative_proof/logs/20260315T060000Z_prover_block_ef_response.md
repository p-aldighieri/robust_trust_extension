# Prover Response — Blocks E+F: Commitment Game and Minimax Conclusion

**Chat URL**: https://chatgpt.com/g/g-p-69b612c07c108191a7597062801a020e/c/69b63bfb-af9c-832c-9f42-d7aba3d394d8
**Role**: prover
**Date**: 2026-03-15

---

Block E: Commitment Game

Let

𝛾
𝑚
:
=
𝑃
𝛽
∗
(
⋅
∣
𝑚
)
,
γ
m
	​

:=P
β
∗
	​

(⋅∣m),

and let 
(
𝜎
^
𝑚
∗
)
𝑚
∈
𝑀
(
σ
^
m
∗
	​

)
m∈M
	​

 denote the jointly chosen Bayes-optimal selector family from the banked Block D repair, so that for every 
𝑚
m,

𝜎
^
𝑚
∗
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
𝛾
𝑚
)
.
σ
^
m
∗
	​

∈arg
σ
^
max
	​

U(
σ
^
,γ
m
	​

).

I am writing 
𝜎
^
𝑚
∗
σ
^
m
∗
	​

 for the family denoted 
𝜎
^
𝑚
†
σ
^
m
†
	​

 in the selector-fix note. The crucial banked consequence is that for every 
𝜇
∈
𝑀
μ∈M there exists a scalar 
𝜅
𝜇
κ
μ
	​

 such that

𝑈
(
𝜎
^
𝑚
∗
,
𝜇
)
≥
𝜅
𝜇
∀
𝑚
∈
𝑀
,
U(
σ
^
m
∗
	​

,μ)≥κ
μ
	​

∀m∈M,

with equality whenever 
𝛽
∗
(
𝑚
∣
𝜇
)
>
0
β
∗
(m∣μ)>0. Equivalently, all messages in 
supp
⁡
𝛽
∗
(
⋅
∣
𝜇
)
suppβ
∗
(⋅∣μ) deliver the same 
𝜇
μ-payoff, and every off-support message delivers weakly higher payoff. 


Define the committed agent strategy 
𝜎
∗
σ
∗
 by

𝜎
^
∗
(
𝑚
)
:
=
𝜎
^
𝑚
∗
(
𝑚
∈
𝑀
)
.
σ
^
∗
(m):=
σ
^
m
∗
	​

(m∈M).

Write

𝑢
ˉ
(
𝜎
^
,
𝜔
)
:
=
𝐸
[
𝑢
(
𝑎
,
𝜔
,
𝜃
)
∣
𝜔
,
𝜎
^
]
,
u
ˉ
(
σ
^
,ω):=E[u(a,ω,θ)∣ω,
σ
^
],

so that

𝑈
(
𝜎
^
,
𝜇
)
=
∑
𝜔
𝑢
ˉ
(
𝜎
^
,
𝜔
)
𝜇
(
𝜔
)
.
U(
σ
^
,μ)=
ω
∑
	​

u
ˉ
(
σ
^
,ω)μ(ω).

Once the agent commits to 
𝜎
∗
σ
∗
, the aligned part of the payoff is independent of 
𝛽
β, so minimizing the total payoff is equivalent to minimizing only the misaligned part. For fixed 
𝜇
μ, the adversary’s row problem is exactly

min
⁡
𝑏
∈
Δ
(
𝑀
)
∑
𝑚
∈
𝑀
𝑏
(
𝑚
)
[
∑
𝜔
𝑢
ˉ
(
𝜎
^
𝑚
∗
,
𝜔
)
𝜇
(
𝜔
)
]
=
min
⁡
𝑏
∈
Δ
(
𝑀
)
∑
𝑚
∈
𝑀
𝑏
(
𝑚
)
 
𝑈
(
𝜎
^
𝑚
∗
,
𝜇
)
.
b∈Δ(M)
min
	​

m∈M
∑
	​

b(m)[
ω
∑
	​

u
ˉ
(
σ
^
m
∗
	​

,ω)μ(ω)]=
b∈Δ(M)
min
	​

m∈M
∑
	​

b(m)U(
σ
^
m
∗
	​

,μ).

This is a linear program over the simplex 
Δ
(
𝑀
)
Δ(M). Therefore its minimizers are precisely those distributions whose support is contained in

arg
⁡
min
⁡
𝑚
∈
𝑀
𝑈
(
𝜎
^
𝑚
∗
,
𝜇
)
.
arg
m∈M
min
	​

U(
σ
^
m
∗
	​

,μ).

Now apply the banked FOC condition. Since

𝑈
(
𝜎
^
𝑚
∗
,
𝜇
)
=
𝜅
𝜇
for all 
𝑚
∈
supp
⁡
𝛽
∗
(
⋅
∣
𝜇
)
,
U(
σ
^
m
∗
	​

,μ)=κ
μ
	​

for all m∈suppβ
∗
(⋅∣μ),

and

𝑈
(
𝜎
^
𝑚
∗
,
𝜇
)
≥
𝜅
𝜇
for all 
𝑚
∈
𝑀
,
U(
σ
^
m
∗
	​

,μ)≥κ
μ
	​

for all m∈M,

every support message of 
𝛽
∗
(
⋅
∣
𝜇
)
β
∗
(⋅∣μ) is a minimizer, and no off-support message does strictly better. Hence

supp
⁡
𝛽
∗
(
⋅
∣
𝜇
)
⊆
arg
⁡
min
⁡
𝑚
∈
𝑀
𝑈
(
𝜎
^
𝑚
∗
,
𝜇
)
,
suppβ
∗
(⋅∣μ)⊆arg
m∈M
min
	​

U(
σ
^
m
∗
	​

,μ),

so 
𝛽
∗
(
⋅
∣
𝜇
)
β
∗
(⋅∣μ) solves the row problem for that 
𝜇
μ. This handles boundary cases automatically:

if 
𝛽
∗
(
⋅
∣
𝜇
)
β
∗
(⋅∣μ) has singleton support, that single message is a minimizer;

if 
𝛽
∗
(
⋅
∣
𝜇
)
β
∗
(⋅∣μ) has multiple support points, equal-payoff-on-support says every convex combination over those points is optimal.

Since the adversary’s objective is the 
𝜏
(
𝜇
)
τ(μ)-weighted sum of these independent row problems, 
𝛽
∗
β
∗
 minimizes the entire commitment-game payoff. Thus 
𝛽
∗
β
∗
 remains optimal for the adversary in the commitment game. This is exactly the selector-safe conclusion extracted in the repair note.

Block F: Saddle Point and Minimax

Now return to the original zero-sum game 
𝑈
(
𝛽
,
𝜎
)
U(β,σ).

First, because 
𝜎
∗
σ
∗
 is fixed, the adversary’s optimization problem in the simultaneous game is the same as in the commitment game. By Block E,

	
𝑈
(
𝛽
∗
,
𝜎
∗
)
≤
𝑈
(
𝛽
,
𝜎
∗
)
∀
𝛽
∈
𝐵
.
		
(F.1)
U(β
∗
,σ
∗
)≤U(β,σ
∗
)∀β∈B.
(F.1)

Second, under 
𝛽
∗
β
∗
, the posterior after message 
𝑚
m is 
𝛾
𝑚
=
𝑃
𝛽
∗
(
⋅
∣
𝑚
)
γ
m
	​

=P
β
∗
	​

(⋅∣m). By construction,

𝜎
^
∗
(
𝑚
)
=
𝜎
^
𝑚
∗
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
𝛾
𝑚
)
∀
𝑚
∈
𝑀
.
σ
^
∗
(m)=
σ
^
m
∗
	​

∈arg
σ
^
max
	​

U(
σ
^
,γ
m
	​

)∀m∈M.

So for fixed 
𝛽
∗
β
∗
, the agent cannot improve by deviating at any message 
𝑚
m. Because the payoff against a fixed 
𝛽
∗
β
∗
 is the 
𝑞
𝛽
∗
(
𝑚
)
q
β
∗
	​

(m)-weighted sum of these message-by-message payoffs, and 
𝑞
𝛽
∗
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
∗
	​

(m)≥ατ(m)>0 for every 
𝑚
∈
𝑀
m∈M, this yields

	
𝑈
(
𝛽
∗
,
𝜎
)
≤
𝑈
(
𝛽
∗
,
𝜎
∗
)
∀
𝜎
∈
Σ
.
		
(F.2)
U(β
∗
,σ)≤U(β
∗
,σ
∗
)∀σ∈Σ.
(F.2)

The positivity 
𝑞
𝛽
∗
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
∗
	​

(m)≥ατ(m)>0 is exactly what makes every 
𝑚
∈
𝑀
m∈M on-path and every 
𝛾
𝑚
γ
m
	​

 well-defined.

Combining (F.1) and (F.2),

𝑈
(
𝛽
∗
,
𝜎
)
≤
𝑈
(
𝛽
∗
,
𝜎
∗
)
≤
𝑈
(
𝛽
,
𝜎
∗
)
∀
𝛽
∈
𝐵
,
 
∀
𝜎
∈
Σ
.
U(β
∗
,σ)≤U(β
∗
,σ
∗
)≤U(β,σ
∗
)∀β∈B, ∀σ∈Σ.

So 
(
𝜎
∗
,
𝛽
∗
)
(σ
∗
,β
∗
) is a saddle point of 
𝑈
(
𝛽
,
𝜎
)
U(β,σ).

Therefore

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
𝑈
(
𝛽
∗
,
𝜎
∗
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

U(β,σ)=U(β
∗
,σ
∗
)=
β∈B
inf
	​

σ∈Σ
sup
	​

U(β,σ).

This is the minimax conclusion, obtained here from the FOC-plus-envelope route rather than from Sion. The saddle inequalities are the same shape as in Appendix A.2 of the paper. 


Finally, since for every message 
𝑚
m,

𝜎
^
∗
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
𝑈
(
𝜎
^
,
𝑃
𝛽
∗
(
⋅
∣
𝑚
)
)
,
σ
^
∗
(m)∈arg
σ
^
max
	​

U(
σ
^
,P
β
∗
	​

(⋅∣m)),

and since 
𝛽
∗
β
∗
 is adversarial against 
𝜎
∗
σ
∗
, the strategy 
𝜎
∗
σ
∗
 satisfies Definition 2, hence is robustly rationalizable. 


Connection to Theorem 2

The paper’s Definition 2 says that 
𝜎
σ is robustly rationalizable if there exists an adversarial 
𝛽
∗
β
∗
 such that, for all 
𝑚
∈
𝑀
m∈M,

𝜎
^
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
(
𝜎
^
′
,
𝑃
𝛽
∗
(
⋅
∣
𝑚
)
)
.
σ
^
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

That is exactly what the constructed pair 
(
𝜎
∗
,
𝛽
∗
)
(σ
∗
,β
∗
) satisfies. 


So the alternative proof now delivers the finite-case existence part of Theorem 2:

Existence: when 
𝑀
M and 
Θ
Θ are finite, the constructed 
𝜎
∗
σ
∗
 is robustly rationalizable.

Optimality: because 
(
𝜎
∗
,
𝛽
∗
)
(σ
∗
,β
∗
) is a saddle point, 
𝜎
∗
σ
∗
 is optimal.

There is also a short general implication, matching the first sentence of Theorem 2. If 
𝜎
σ is any robustly rationalizable strategy with witness 
𝛽
∗
β
∗
, then:

𝛽
∗
β
∗
 is adversarial against 
𝜎
σ, so

𝑈
(
𝛽
∗
,
𝜎
)
≤
𝑈
(
𝛽
,
𝜎
)
∀
𝛽
;
U(β
∗
,σ)≤U(β,σ)∀β;

𝜎
σ is Bayes-optimal message by message under 
𝑃
𝛽
∗
(
⋅
∣
𝑚
)
P
β
∗
	​

(⋅∣m), so

𝑈
(
𝛽
∗
,
𝜎
′
)
≤
𝑈
(
𝛽
∗
,
𝜎
)
∀
𝜎
′
.
U(β
∗
,σ
′
)≤U(β
∗
,σ)∀σ
′
.

Hence 
(
𝜎
,
𝛽
∗
)
(σ,β
∗
) is a saddle point, and 
𝜎
σ is optimal. Thus the first clause of Theorem 2 is the generic saddle implication, while Blocks E-F provide the finite-case constructive existence of such a pair. This aligns exactly with the theorem statement in the paper.

Remaining Gaps

[GAP] The selector family used in Blocks E-F must be the jointly selected Bayes-optimal family extracted from a subgradient of 
𝑉
V at 
𝛽
∗
β
∗
. The argument does not justify replacing it by an arbitrary Bayes-optimal selector family chosen independently at each 
𝛾
𝑚
γ
m
	​

. That stronger claim was the reviewer’s objection and remains unavailable. 


[GAP] To make the proof fully self-contained on paper, the convex-analytic optimality step

0
∈
∂
𝑉
(
𝛽
∗
)
+
𝑁
∏
𝜇
∈
𝑀
Δ
(
𝑀
)
(
𝛽
∗
)
0∈∂V(β
∗
)+N
∏
μ∈M
	​

Δ(M)
	​

(β
∗
)

should be written explicitly in Block D/E. The selector-fix note uses it, but flags that it still needs to be inserted into the formal proof text. 


[GAP] This closes only the finite case. The extension beyond finite message spaces remains open in the original sketch and is outside the present scope. 


No new [ASSUMPTION+] were needed in Blocks E-F.

Final Assessment: Is the finite-case alternative proof complete?

Substantively, yes. If Blocks A-D are banked with the selector-fix, then Blocks E-F above complete the finite-case alternative proof of Theorem 2: they produce a jointly selected Bayes-optimal strategy 
𝜎
∗
σ
∗
, show that 
𝛽
∗
β
∗
 remains adversarial under commitment, establish the saddle point, derive minimax equality, and verify robust rationalizability and optimality.

As a writeup, one local [GAP] remains: the proof text should explicitly insert the normal-cone / subgradient step that yields the selector family. Without that insertion, the mathematics is already doing the right thing, but one gear is still hidden behind the casing.