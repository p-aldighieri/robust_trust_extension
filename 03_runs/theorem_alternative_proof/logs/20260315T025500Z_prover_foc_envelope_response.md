# Prover Response — FOC Derivation and Envelope Theorem (Blocks C + D)

**Chat URL**: https://chatgpt.com/g/g-p-69b612c07c108191a7597062801a020e-robust-trust-alternative-proof/c/69b623bb-4150-8333-a3a4-916dfeabe2a5
**Role**: prover
**Date**: 2026-03-15

---

1. “AI Moves First” Equivalence

Let

𝑣
‾
:
=
sup
⁡
𝜎
inf
⁡
𝛽
𝑈
(
𝛽
,
𝜎
)
v
	​

:=
σ
sup
	​

β
inf
	​

U(β,σ)

be the paper’s simultaneous-move value from (1)-(2), and let

𝑣
‾
:
=
inf
⁡
𝛽
sup
⁡
𝜎
𝑈
(
𝛽
,
𝜎
)
v
:=
β
inf
	​

σ
sup
	​

U(β,σ)

be the value of the sequential reformulation in which the misaligned adviser chooses 
𝛽
β first and the agent then best-responds. The paper’s model and Theorem 2 are stated in terms of the simultaneous robust objective, while Appendix A.2 proves 
𝑣
‾
=
𝑣
‾
v
	​

=
v
 in the finite case via Sion’s minimax theorem. The sketch, by contrast, says “assume AI moves first” and then works with 
𝑣
‾
v
. 

RobustTrust_up_to_Theorem2

 


 


So there are really two principles here.

First, for a fixed 
𝛽
β, the agent’s optimization does decompose message-by-message. Writing an agent strategy as a family of private strategies 
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
𝑀
σ∼(
σ
^
(m))
m∈M
	​

, for fixed 
𝛽
β the realized posterior after message 
𝑚
m is 
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

(⋅∣m), and the probability of message 
𝑚
m is 
𝑞
𝛽
(
𝑚
)
q
β
	​

(m). Hence

sup
⁡
𝜎
𝑈
(
𝛽
,
𝜎
)
=
∑
𝑚
∈
𝑀
𝑞
𝛽
(
𝑚
)
 
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
(
⋅
∣
𝑚
)
)
.
σ
sup
	​

U(β,σ)=
m∈M
∑
	​

q
β
	​

(m)
σ
^
max
	​

U(
σ
^
,P
β
	​

(⋅∣m)).

This is just backward induction / optimal continuation play by the follower.

Second, identifying this sequential problem with the paper’s simultaneous problem requires

sup
⁡
𝜎
inf
⁡
𝛽
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
sup
⁡
𝜎
𝑈
(
𝛽
,
𝜎
)
,
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

σ
sup
	​

U(β,σ),

which is the minimax / saddle-point principle for a zero-sum game. That equality is not automatic from “AI moves first.” It is exactly what Blocks E-F must prove in the alternative argument. Therefore:

Conclusion for Gap 1.
The sketch’s “AI moves first” step is only a valid way to compute the upper value 
𝑣
‾
v
. Its equivalence to the paper’s simultaneous formulation requires the zero-sum saddle-point/minimax property.

[
𝐺
𝐴
𝑃
]
 The sketch treats this equivalence as immediate, but it is a theorem-level step.
[GAP] The sketch treats this equivalence as immediate, but it is a theorem-level step.
2. Adversary’s Optimization Problem

For a private strategy 
𝜎
^
σ
^
, define its state-contingent payoff vector

𝑢
ˉ
𝜎
^
(
𝜔
)
:
=
∑
𝜃
∈
Θ
𝑓
(
𝜃
∣
𝜔
)
∫
𝐴
𝑢
(
𝑎
,
𝜔
,
𝜃
)
 
𝜎
^
(
𝑑
𝑎
∣
𝜃
)
,
u
ˉ
σ
^
	​

(ω):=
θ∈Θ
∑
	​

f(θ∣ω)∫
A
	​

u(a,ω,θ)
σ
^
(da∣θ),

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
∈
Ω
𝜇
(
𝜔
)
𝑢
ˉ
𝜎
^
(
𝜔
)
.
U(
σ
^
,μ)=
ω∈Ω
∑
	​

μ(ω)
u
ˉ
σ
^
	​

(ω).

Let

𝑊
(
𝜇
)
:
=
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
.
W(μ):=
σ
^
max
	​

U(
σ
^
,μ).

Then for fixed 
𝛽
β,

𝑉
(
𝛽
)
:
=
sup
⁡
𝜎
𝑈
(
𝛽
,
𝜎
)
=
∑
𝑚
∈
𝑀
𝑞
𝛽
(
𝑚
)
 
𝑊
(
𝑃
𝛽
(
⋅
∣
𝑚
)
)
.
V(β):=
σ
sup
	​

U(β,σ)=
m∈M
∑
	​

q
β
	​

(m)W(P
β
	​

(⋅∣m)).

Also define

𝑁
𝛽
(
𝑚
,
𝜔
)
:
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
N
β
	​

(m,ω):=ατ(m)m(ω)+(1−α)
μ∈M
∑
	​

τ(μ)β(m∣μ)μ(ω).

Then

𝑞
𝛽
(
𝑚
)
=
∑
𝜔
𝑁
𝛽
(
𝑚
,
𝜔
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
ω
∑
	​

N
β
	​

(m,ω)=ατ(m)+(1−α)
μ
∑
	​

τ(μ)β(m∣μ),

and

𝑃
𝛽
(
𝜔
∣
𝑚
)
=
𝑁
𝛽
(
𝑚
,
𝜔
)
𝑞
𝛽
(
𝑚
)
.
P
β
	​

(ω∣m)=
q
β
	​

(m)
N
β
	​

(m,ω)
	​

.

Because 
𝑚
∈
𝑀
=
supp
⁡
(
𝜏
)
m∈M=supp(τ) and 
𝛼
>
0
α>0,

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
∀
𝑚
∈
𝑀
.
q
β
	​

(m)≥ατ(m)>0∀m∈M.

So every 
𝑚
∈
𝑀
m∈M is always on path, and the posterior map is locally smooth in 
𝛽
β.

For a fixed row 
𝜇
∗
∈
𝑀
μ
∗
∈M, the adversary’s row problem is:

min
⁡
 
𝛽
(
⋅
∣
𝜇
∗
)
∈
Δ
(
𝑀
)
𝑉
(
𝛽
)
,
β(⋅∣μ
∗
)∈Δ(M)
min
	​

V(β),

holding all other rows 
𝛽
(
⋅
∣
𝜇
)
β(⋅∣μ), 
𝜇
≠
𝜇
∗
μ

=μ
∗
, fixed.

3. FOC Derivation (direct + indirect effects)

Fix 
𝜇
∗
∈
𝑀
μ
∗
∈M and messages 
𝑚
1
,
𝑚
2
∈
𝑀
m
1
	​

,m
2
	​

∈M. Consider the feasible row perturbation

𝛽
𝜀
(
𝑚
∣
𝜇
)
=
𝛽
(
𝑚
∣
𝜇
)
+
𝜀
 
[
𝛿
𝑚
1
(
𝑚
)
−
𝛿
𝑚
2
(
𝑚
)
]
 
1
{
𝜇
=
𝜇
∗
}
,
β
ε
	​

(m∣μ)=β(m∣μ)+ε[δ
m
1
	​

	​

(m)−δ
m
2
	​

	​

(m)]1{μ=μ
∗
},

for

𝜀
∈
[
−
𝛽
(
𝑚
1
∣
𝜇
∗
)
,
 
𝛽
(
𝑚
2
∣
𝜇
∗
)
]
.
ε∈[−β(m
1
	​

∣μ
∗
), β(m
2
	​

∣μ
∗
)].

Set

𝑐
:
=
(
1
−
𝛼
)
𝜏
(
𝜇
∗
)
.
c:=(1−α)τ(μ
∗
).
3.1 Derivative of 
𝑞
𝛽
q
β
	​


Only messages 
𝑚
1
,
𝑚
2
m
1
	​

,m
2
	​

 are affected:

𝑞
𝛽
𝜀
(
𝑚
)
=
𝑞
𝛽
(
𝑚
)
+
𝜀
𝑐
 
[
𝛿
𝑚
1
(
𝑚
)
−
𝛿
𝑚
2
(
𝑚
)
]
,
q
β
ε
	​

	​

(m)=q
β
	​

(m)+εc[δ
m
1
	​

	​

(m)−δ
m
2
	​

	​

(m)],

so

𝑞
𝑚
′
(
0
)
:
=
𝑑
𝑑
𝜀
𝑞
𝛽
𝜀
(
𝑚
)
∣
𝜀
=
0
=
𝑐
 
[
𝛿
𝑚
1
(
𝑚
)
−
𝛿
𝑚
2
(
𝑚
)
]
.
q
m
′
	​

(0):=
dε
d
	​

q
β
ε
	​

	​

(m)
	​

ε=0
	​

=c[δ
m
1
	​

	​

(m)−δ
m
2
	​

	​

(m)].
3.2 Derivative of the posterior 
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

Similarly,

𝑁
𝑚
′
(
𝜔
)
:
=
𝑑
𝑑
𝜀
𝑁
𝛽
𝜀
(
𝑚
,
𝜔
)
∣
𝜀
=
0
=
𝑐
 
𝜇
∗
(
𝜔
)
 
[
𝛿
𝑚
1
(
𝑚
)
−
𝛿
𝑚
2
(
𝑚
)
]
.
N
m
′
	​

(ω):=
dε
d
	​

N
β
ε
	​

	​

(m,ω)
	​

ε=0
	​

=cμ
∗
(ω)[δ
m
1
	​

	​

(m)−δ
m
2
	​

	​

(m)].

Using the quotient rule,

𝑑
𝑑
𝜀
𝑃
𝛽
𝜀
(
𝜔
∣
𝑚
)
∣
𝜀
=
0
=
𝑁
𝑚
′
(
𝜔
)
𝑞
𝛽
(
𝑚
)
−
𝑁
𝛽
(
𝑚
,
𝜔
)
𝑞
𝑚
′
(
0
)
𝑞
𝛽
(
𝑚
)
2
.
dε
d
	​

P
β
ε
	​

	​

(ω∣m)
	​

ε=0
	​

=
q
β
	​

(m)
2
N
m
′
	​

(ω)q
β
	​

(m)−N
β
	​

(m,ω)q
m
′
	​

(0)
	​

.

Hence

𝑑
𝑑
𝜀
𝑃
𝛽
𝜀
(
𝜔
∣
𝑚
)
∣
𝜀
=
0
=
𝑞
𝑚
′
(
0
)
𝑞
𝛽
(
𝑚
)
(
𝜇
∗
(
𝜔
)
−
𝑃
𝛽
(
𝜔
∣
𝑚
)
)
.
dε
d
	​

P
β
ε
	​

	​

(ω∣m)
	​

ε=0
	​

=
q
β
	​

(m)
q
m
′
	​

(0)
	​

(μ
∗
(ω)−P
β
	​

(ω∣m)).

Equivalently,

𝑃
𝑚
′
(
𝜔
)
=
{
𝑐
𝑞
𝛽
(
𝑚
1
)
(
𝜇
∗
(
𝜔
)
−
𝑃
𝛽
(
𝜔
∣
𝑚
1
)
)
,
	
𝑚
=
𝑚
1
,


𝑐
𝑞
𝛽
(
𝑚
2
)
(
𝑃
𝛽
(
𝜔
∣
𝑚
2
)
−
𝜇
∗
(
𝜔
)
)
,
	
𝑚
=
𝑚
2
,


0
,
	
𝑚
∉
{
𝑚
1
,
𝑚
2
}
.
P
m
′
	​

(ω)=
⎩
⎨
⎧
	​

q
β
	​

(m
1
	​

)
c
	​

(μ
∗
(ω)−P
β
	​

(ω∣m
1
	​

)),
q
β
	​

(m
2
	​

)
c
	​

(P
β
	​

(ω∣m
2
	​

)−μ
∗
(ω)),
0,
	​

m=m
1
	​

,
m=m
2
	​

,
m∈
/
{m
1
	​

,m
2
	​

}.
	​

3.3 Direct and indirect effects

Pick, for each 
𝑚
m, a Bayes-optimal private strategy

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
𝑃
𝛽
(
⋅
∣
𝑚
)
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
,P
β
	​

(⋅∣m)).

Then

𝑉
(
𝛽
𝜀
)
=
∑
𝑚
∈
𝑀
𝑞
𝛽
𝜀
(
𝑚
)
 
𝑊
(
𝑃
𝛽
𝜀
(
⋅
∣
𝑚
)
)
.
V(β
ε
	​

)=
m∈M
∑
	​

q
β
ε
	​

	​

(m)W(P
β
ε
	​

	​

(⋅∣m)).

Differentiate at 
0
0:

𝑉
′
(
0
)
=
∑
𝑚
𝑞
𝑚
′
(
0
)
 
𝑊
(
𝑃
𝛽
(
⋅
∣
𝑚
)
)
⏟
direct
+
∑
𝑚
𝑞
𝛽
(
𝑚
)
 
𝑑
𝑑
𝜀
𝑊
(
𝑃
𝛽
𝜀
(
⋅
∣
𝑚
)
)
∣
0
⏟
indirect
.
V
′
(0)=
direct
m
∑
	​

q
m
′
	​

(0)W(P
β
	​

(⋅∣m))
	​

	​

+
indirect
m
∑
	​

q
β
	​

(m)
dε
d
	​

W(P
β
ε
	​

	​

(⋅∣m))
	​

0
	​

	​

	​

.

The direct term is immediate:

Direct
=
𝑐
(
𝑊
(
𝑃
𝛽
(
⋅
∣
𝑚
1
)
)
−
𝑊
(
𝑃
𝛽
(
⋅
∣
𝑚
2
)
)
)
.
Direct=c(W(P
β
	​

(⋅∣m
1
	​

))−W(P
β
	​

(⋅∣m
2
	​

))).

The indirect term is handled in Sections 4-5 below. After the envelope step, it becomes

Indirect
=
𝑐
(
𝑈
(
𝜎
^
𝑚
1
∗
,
𝜇
∗
)
−
𝑊
(
𝑃
𝛽
(
⋅
∣
𝑚
1
)
)
)
+
𝑐
(
𝑊
(
𝑃
𝛽
(
⋅
∣
𝑚
2
)
)
−
𝑈
(
𝜎
^
𝑚
2
∗
,
𝜇
∗
)
)
.
Indirect=c(U(
σ
^
m
1
	​

∗
	​

,μ
∗
)−W(P
β
	​

(⋅∣m
1
	​

)))+c(W(P
β
	​

(⋅∣m
2
	​

))−U(
σ
^
m
2
	​

∗
	​

,μ
∗
)).

Therefore the full derivative collapses to

𝑉
′
(
0
)
=
(
1
−
𝛼
)
𝜏
(
𝜇
∗
)
(
𝑈
(
𝜎
^
𝑚
1
∗
,
𝜇
∗
)
−
𝑈
(
𝜎
^
𝑚
2
∗
,
𝜇
∗
)
)
.
V
′
(0)=(1−α)τ(μ
∗
)(U(
σ
^
m
1
	​

∗
	​

,μ
∗
)−U(
σ
^
m
2
	​

∗
	​

,μ
∗
)).
	​


In state-contingent form,

𝑉
′
(
0
)
=
(
1
−
𝛼
)
𝜏
(
𝜇
∗
)
∑
𝜔
∈
Ω
(
𝑢
ˉ
𝜎
^
𝑚
1
∗
(
𝜔
)
−
𝑢
ˉ
𝜎
^
𝑚
2
∗
(
𝜔
)
)
𝜇
∗
(
𝜔
)
.
V
′
(0)=(1−α)τ(μ
∗
)
ω∈Ω
∑
	​

(
u
ˉ
σ
^
m
1
	​

∗
	​

	​

(ω)−
u
ˉ
σ
^
m
2
	​

∗
	​

	​

(ω))μ
∗
(ω).
	​


That is the correct FOC derivative for the simplex-preserving perturbation.

4. Envelope Theorem Identification and Verification

The exact local result needed here is Milgrom-Segal (2002), Theorem 3, not their global absolute-continuity theorem. Milgrom-Segal define equidifferentiability as uniform convergence of the difference quotients across the choice set, and Theorem 3 says that if the family 
{
𝑓
(
𝑥
,
⋅
)
}
𝑥
∈
𝑋
{f(x,⋅)}
x∈X
	​

 is equidifferentiable at 
𝑡
0
t
0
	​

, 
sup
⁡
𝑥
𝑓
𝑡
(
𝑥
,
𝑡
0
)
<
∞
sup
x
	​

f
t
	​

(x,t
0
	​

)<∞, and the argmax is nonempty for all nearby 
𝑡
t, then the value function has left and right derivatives at 
𝑡
0
t
0
	​

, given by the derivative of the primitive objective evaluated along optimal selections. Their Theorem 2 is stronger: under absolute continuity and an integrable derivative bound, the value is absolutely continuous and admits an integral representation. 
Stanford University
+1

For our application, fix a message 
𝑚
m and define

𝐹
𝑚
(
𝜎
^
,
𝜀
)
:
=
𝑈
(
𝜎
^
,
𝑃
𝛽
𝜀
(
⋅
∣
𝑚
)
)
=
∑
𝜔
𝑃
𝛽
𝜀
(
𝜔
∣
𝑚
)
𝑢
ˉ
𝜎
^
(
𝜔
)
.
F
m
	​

(
σ
^
,ε):=U(
σ
^
,P
β
ε
	​

	​

(⋅∣m))=
ω
∑
	​

P
β
ε
	​

	​

(ω∣m)
u
ˉ
σ
^
	​

(ω).

We apply Milgrom-Segal to the value function

𝑊
𝑚
(
𝜀
)
:
=
max
⁡
𝜎
^
𝐹
𝑚
(
𝜎
^
,
𝜀
)
.
W
m
	​

(ε):=
σ
^
max
	​

F
m
	​

(
σ
^
,ε).
Verification of hypotheses in the finite setting

Nonempty choice set and argmax.
In the finite-case regime, it is enough that Bayes-optimal private strategies exist for every posterior. Under the paper’s primitives, finite 
Θ
Θ, compact metric 
𝐴
A, and bounded continuous 
𝑢
(
⋅
,
𝜔
,
𝜃
)
u(⋅,ω,θ) suffice; then the private-strategy space is compact and the maximization problem has a solution. 

RobustTrust_up_to_Theorem2

[
𝐴
𝑆
𝑆
𝑈
𝑀
𝑃
𝑇
𝐼
𝑂
𝑁
+
]
 We use this existence/compactness fact in Block D.
[ASSUMPTION+] We use this existence/compactness fact in Block D.

Differentiability in 
𝜀
ε.
Since 
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

(m)≥ατ(m)>0, the posterior 
𝑃
𝛽
𝜀
(
⋅
∣
𝑚
)
P
β
ε
	​

	​

(⋅∣m) is differentiable in 
𝜀
ε near 
0
0.

Equidifferentiability.
Because 
Ω
Ω is finite and 
∣
𝑢
ˉ
𝜎
^
(
𝜔
)
∣
≤
∥
𝑢
∥
∞
∣
u
ˉ
σ
^
	​

(ω)∣≤∥u∥
∞
	​

,

sup
⁡
𝜎
^
∣
𝐹
𝑚
(
𝜎
^
,
𝜀
)
−
𝐹
𝑚
(
𝜎
^
,
0
)
𝜀
−
∑
𝜔
𝑢
ˉ
𝜎
^
(
𝜔
)
𝑃
𝑚
′
(
𝜔
)
∣
≤
∥
𝑢
∥
∞
∑
𝜔
∣
𝑃
𝛽
𝜀
(
𝜔
∣
𝑚
)
−
𝑃
𝛽
(
𝜔
∣
𝑚
)
𝜀
−
𝑃
𝑚
′
(
𝜔
)
∣
→
0.
σ
^
sup
	​

	​

ε
F
m
	​

(
σ
^
,ε)−F
m
	​

(
σ
^
,0)
	​

−
ω
∑
	​

u
ˉ
σ
^
	​

(ω)P
m
′
	​

(ω)
	​

≤∥u∥
∞
	​

ω
∑
	​

	​

ε
P
β
ε
	​

	​

(ω∣m)−P
β
	​

(ω∣m)
	​

−P
m
′
	​

(ω)
	​

→0.

So the family 
{
𝐹
𝑚
(
𝜎
^
,
⋅
)
}
𝜎
^
{F
m
	​

(
σ
^
,⋅)}
σ
^
	​

 is equidifferentiable at 
0
0.

Uniform derivative bound.
Again using bounded utility and finite 
Ω
Ω,

sup
⁡
𝜎
^
∣
∂
𝜀
𝐹
𝑚
(
𝜎
^
,
0
)
∣
≤
∥
𝑢
∥
∞
∑
𝜔
∣
𝑃
𝑚
′
(
𝜔
)
∣
<
∞
.
σ
^
sup
	​

∣∂
ε
	​

F
m
	​

(
σ
^
,0)∣≤∥u∥
∞
	​

ω
∑
	​

∣P
m
′
	​

(ω)∣<∞.

Hence Milgrom-Segal Theorem 3 applies message-by-message.

What it gives

For any optimal selection 
𝜎
^
𝑚
∗
(
𝜀
)
∈
arg
⁡
max
⁡
𝜎
^
𝐹
𝑚
(
𝜎
^
,
𝜀
)
σ
^
m
∗
	​

(ε)∈argmax
σ
^
	​

F
m
	​

(
σ
^
,ε),

𝑑
𝑑
𝜀
𝑊
𝑚
(
𝜀
)
∣
0
±
=
∑
𝜔
𝑢
ˉ
𝜎
^
𝑚
∗
(
0
±
)
(
𝜔
)
 
𝑃
𝑚
′
(
𝜔
)
.
dε
d
	​

W
m
	​

(ε)
	​

0
±
	​

=
ω
∑
	​

u
ˉ
σ
^
m
∗
	​

(0
±
)
	​

(ω)P
m
′
	​

(ω).

The critical point is this: the derivative of the optimizer itself never appears. That is the envelope step.

So the sketch’s “indirect effect vanishes” should be read as:

the derivative of 
𝜎
^
𝑚
∗
(
𝜀
)
 drops out, not the derivative of 
𝑃
𝛽
𝜀
(
⋅
∣
𝑚
)
.
the derivative of 
σ
^
m
∗
	​

(ε) drops out, not the derivative of P
β
ε
	​

	​

(⋅∣m).
[
𝐺
𝐴
𝑃
]
 The sketch’s phrase “absolutely equicontinuous in belief” is not the precise Milgrom-Segal hypothesis.
[GAP] The sketch’s phrase “absolutely equicontinuous in belief” is not the precise Milgrom-Segal hypothesis.
5. Elimination of Indirect Effect

There is a cleaner bridge than working directly with the ratio 
𝑃
𝛽
=
𝑁
𝛽
/
𝑞
𝛽
P
β
	​

=N
β
	​

/q
β
	​

.

Define the message-
𝑚
m contribution as

Φ
𝑚
(
𝜀
)
:
=
𝑞
𝛽
𝜀
(
𝑚
)
 
𝑊
(
𝑃
𝛽
𝜀
(
⋅
∣
𝑚
)
)
.
Φ
m
	​

(ε):=q
β
ε
	​

	​

(m)W(P
β
ε
	​

	​

(⋅∣m)).

Because 
𝑞
𝑊
(
𝑃
)
=
max
⁡
𝜎
^
∑
𝜔
𝑢
ˉ
𝜎
^
(
𝜔
)
𝑁
(
𝜔
)
qW(P)=max
σ
^
	​

∑
ω
	​

u
ˉ
σ
^
	​

(ω)N(ω), we can rewrite:

Φ
𝑚
(
𝜀
)
=
max
⁡
𝜎
^
∑
𝜔
∈
Ω
𝑢
ˉ
𝜎
^
(
𝜔
)
 
𝑁
𝛽
𝜀
(
𝑚
,
𝜔
)
.
Φ
m
	​

(ε)=
σ
^
max
	​

ω∈Ω
∑
	​

u
ˉ
σ
^
	​

(ω)N
β
ε
	​

	​

(m,ω).

Now the parameter enters affinely through 
𝑁
𝛽
𝜀
(
𝑚
,
𝜔
)
N
β
ε
	​

	​

(m,ω). Applying the envelope theorem directly to 
Φ
𝑚
Φ
m
	​

 yields

Φ
𝑚
′
(
0
)
=
∑
𝜔
𝑢
ˉ
𝜎
^
𝑚
∗
(
𝜔
)
 
𝑁
𝑚
′
(
𝜔
)
.
Φ
m
′
	​

(0)=
ω
∑
	​

u
ˉ
σ
^
m
∗
	​

	​

(ω)N
m
′
	​

(ω).

Since

𝑁
𝑚
1
′
(
𝜔
)
=
𝑐
𝜇
∗
(
𝜔
)
,
𝑁
𝑚
2
′
(
𝜔
)
=
−
𝑐
𝜇
∗
(
𝜔
)
,
N
m
1
	​

′
	​

(ω)=cμ
∗
(ω),N
m
2
	​

′
	​

(ω)=−cμ
∗
(ω),

we get

Φ
𝑚
1
′
(
0
)
=
𝑐
 
𝑈
(
𝜎
^
𝑚
1
∗
,
𝜇
∗
)
,
Φ
𝑚
2
′
(
0
)
=
−
𝑐
 
𝑈
(
𝜎
^
𝑚
2
∗
,
𝜇
∗
)
,
Φ
m
1
	​

′
	​

(0)=cU(
σ
^
m
1
	​

∗
	​

,μ
∗
),Φ
m
2
	​

′
	​

(0)=−cU(
σ
^
m
2
	​

∗
	​

,μ
∗
),

and 
Φ
𝑚
′
(
0
)
=
0
Φ
m
′
	​

(0)=0 for all other 
𝑚
m. Summing over 
𝑚
m,

𝑉
′
(
0
)
=
∑
𝑚
Φ
𝑚
′
(
0
)
=
(
1
−
𝛼
)
𝜏
(
𝜇
∗
)
(
𝑈
(
𝜎
^
𝑚
1
∗
,
𝜇
∗
)
−
𝑈
(
𝜎
^
𝑚
2
∗
,
𝜇
∗
)
)
.
V
′
(0)=
m
∑
	​

Φ
m
′
	​

(0)=(1−α)τ(μ
∗
)(U(
σ
^
m
1
	​

∗
	​

,μ
∗
)−U(
σ
^
m
2
	​

∗
	​

,μ
∗
)).

This is the most rigorous way to “kill the indirect effect.” The optimizer’s derivative disappears by envelope; the posterior derivative itself is absorbed into the linear derivative of 
𝑁
𝛽
𝜀
N
β
ε
	​

	​

.

Bridge to the formalizer’s posterior-derivative formula

The formalizer’s verified formula

𝑑
𝑑
𝜀
𝑃
𝛽
(
𝜔
∣
𝑚
)
=
(
1
−
𝛼
)
𝛽
(
𝑚
∣
𝜇
∗
)
𝜏
(
𝜇
∗
)
𝑞
𝛽
(
𝑚
)
(
𝑃
𝛽
(
𝜔
∣
𝑚
)
−
𝜇
∗
(
𝜔
)
)
dε
d
	​

P
β
	​

(ω∣m)=(1−α)
q
β
	​

(m)
β(m∣μ
∗
)τ(μ
∗
)
	​

(P
β
	​

(ω∣m)−μ
∗
(ω))

corresponds to the single-coordinate shrinkage

𝛽
𝜀
(
𝑚
∣
𝜇
∗
)
=
(
1
−
𝜀
)
𝛽
(
𝑚
∣
𝜇
∗
)
,
β
ε
	​

(m∣μ
∗
)=(1−ε)β(m∣μ
∗
),

not to the mass-shift 
𝑚
2
→
𝑚
1
m
2
	​

→m
1
	​

 used above. For a genuine coordinate derivative,

∂
𝛽
(
𝑚
∣
𝜇
∗
)
𝑃
𝛽
(
𝜔
∣
𝑚
)
=
(
1
−
𝛼
)
𝜏
(
𝜇
∗
)
𝑞
𝛽
(
𝑚
)
(
𝜇
∗
(
𝜔
)
−
𝑃
𝛽
(
𝜔
∣
𝑚
)
)
,
∂
β(m∣μ
∗
)
	​

P
β
	​

(ω∣m)=(1−α)
q
β
	​

(m)
τ(μ
∗
)
	​

(μ
∗
(ω)−P
β
	​

(ω∣m)),

and multiplying by 
−
𝛽
(
𝑚
∣
𝜇
∗
)
−β(m∣μ
∗
) recovers the formalizer’s expression exactly.

Support changes

Because 
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

(m)≥ατ(m)>0 for every 
𝑚
∈
𝑀
m∈M, message support does not change under small perturbations, so the posterior formula stays smooth. What can change is only the row support of 
𝛽
(
⋅
∣
𝜇
∗
)
β(⋅∣μ
∗
), and that is a simplex-boundary issue handled by one-sided derivatives / KKT, not by the envelope theorem.

6. KKT Analysis on the Simplex

Fix 
𝜇
∗
μ
∗
. Write

𝑏
𝑚
:
=
𝛽
(
𝑚
∣
𝜇
∗
)
,
𝑏
=
(
𝑏
𝑚
)
𝑚
∈
𝑀
∈
Δ
(
𝑀
)
.
b
m
	​

:=β(m∣μ
∗
),b=(b
m
	​

)
m∈M
	​

∈Δ(M).

Let the other rows of 
𝛽
β be fixed, and define the reduced row objective 
𝑅
(
𝑏
)
R(b).

6.1 Variational inequality form, no extra smoothness

If 
𝑏
∗
b
∗
 is optimal, then for every feasible direction 
𝑑
d with 
∑
𝑚
𝑑
𝑚
=
0
∑
m
	​

d
m
	​

=0 and 
𝑏
∗
+
𝜀
𝑑
∈
Δ
(
𝑀
)
b
∗
+εd∈Δ(M) for small 
𝜀
>
0
ε>0,

𝐷
𝑅
(
𝑏
∗
;
𝑑
)
≥
0.
DR(b
∗
;d)≥0.

Taking 
𝑑
=
𝑒
𝑚
1
−
𝑒
𝑚
2
d=e
m
1
	​

	​

−e
m
2
	​

	​

, this direction is feasible whenever 
𝑏
𝑚
2
∗
>
0
b
m
2
	​

∗
	​

>0. By Section 3,

𝐷
𝑅
(
𝑏
∗
;
𝑒
𝑚
1
−
𝑒
𝑚
2
)
=
(
1
−
𝛼
)
𝜏
(
𝜇
∗
)
(
𝑈
(
𝜎
^
𝑚
1
∗
,
𝜇
∗
)
−
𝑈
(
𝜎
^
𝑚
2
∗
,
𝜇
∗
)
)
≥
0.
DR(b
∗
;e
m
1
	​

	​

−e
m
2
	​

	​

)=(1−α)τ(μ
∗
)(U(
σ
^
m
1
	​

∗
	​

,μ
∗
)−U(
σ
^
m
2
	​

∗
	​

,μ
∗
))≥0.

So whenever 
𝑚
2
∈
supp
⁡
𝛽
∗
(
⋅
∣
𝜇
∗
)
m
2
	​

∈suppβ
∗
(⋅∣μ
∗
),

𝑈
(
𝜎
^
𝑚
1
∗
,
𝜇
∗
)
≥
𝑈
(
𝜎
^
𝑚
2
∗
,
𝜇
∗
)
∀
𝑚
1
∈
𝑀
.
U(
σ
^
m
1
	​

∗
	​

,μ
∗
)≥U(
σ
^
m
2
	​

∗
	​

,μ
∗
)∀m
1
	​

∈M.
	​


If both 
𝑚
1
,
𝑚
2
m
1
	​

,m
2
	​

 are in support, the reverse direction is also feasible, so equality holds:

𝑈
(
𝜎
^
𝑚
1
∗
,
𝜇
∗
)
=
𝑈
(
𝜎
^
𝑚
2
∗
,
𝜇
∗
)
∀
𝑚
1
,
𝑚
2
∈
supp
⁡
𝛽
∗
(
⋅
∣
𝜇
∗
)
.
U(
σ
^
m
1
	​

∗
	​

,μ
∗
)=U(
σ
^
m
2
	​

∗
	​

,μ
∗
)∀m
1
	​

,m
2
	​

∈suppβ
∗
(⋅∣μ
∗
).
	​


Thus the support of 
𝛽
∗
(
⋅
∣
𝜇
∗
)
β
∗
(⋅∣μ
∗
) consists of messages that minimize the agent’s expected payoff under the true adviser belief 
𝜇
∗
μ
∗
.

6.2 Classical KKT form

If one wants literal multiplier equations, one needs differentiability of the row objective at 
𝑏
∗
b
∗
.

[
𝐴
𝑆
𝑆
𝑈
𝑀
𝑃
𝑇
𝐼
𝑂
𝑁
+
]
 Assume 
𝑅
 is differentiable at 
𝑏
∗
.
[ASSUMPTION+] Assume R is differentiable at b
∗
.

Then there exist 
𝜆
𝜇
∗
∈
𝑅
λ
μ
∗
	​

∈R and 
𝜂
𝑚
𝜇
∗
≥
0
η
m
μ
∗
	​

≥0 such that

∂
𝑏
𝑚
𝑅
(
𝑏
∗
)
+
𝜆
𝜇
∗
−
𝜂
𝑚
𝜇
∗
=
0
,
∂
b
m
	​

	​

R(b
∗
)+λ
μ
∗
	​

−η
m
μ
∗
	​

=0,
𝜂
𝑚
𝜇
∗
𝑏
𝑚
∗
=
0
,
𝑏
𝑚
∗
≥
0
,
∑
𝑚
𝑏
𝑚
∗
=
1.
η
m
μ
∗
	​

b
m
∗
	​

=0,b
m
∗
	​

≥0,
m
∑
	​

b
m
∗
	​

=1.

From the envelope derivative,

∂
𝑏
𝑚
𝑅
(
𝑏
∗
)
=
(
1
−
𝛼
)
𝜏
(
𝜇
∗
)
 
𝑈
(
𝜎
^
𝑚
∗
,
𝜇
∗
)
.
∂
b
m
	​

	​

R(b
∗
)=(1−α)τ(μ
∗
)U(
σ
^
m
∗
	​

,μ
∗
).

Therefore stationarity becomes

(
1
−
𝛼
)
𝜏
(
𝜇
∗
)
 
𝑈
(
𝜎
^
𝑚
∗
,
𝜇
∗
)
+
𝜆
𝜇
∗
−
𝜂
𝑚
𝜇
∗
=
0.
(1−α)τ(μ
∗
)U(
σ
^
m
∗
	​

,μ
∗
)+λ
μ
∗
	​

−η
m
μ
∗
	​

=0.

So:

if 
𝑏
𝑚
∗
>
0
b
m
∗
	​

>0, then 
𝜂
𝑚
𝜇
∗
=
0
η
m
μ
∗
	​

=0, hence all support messages have the same value;

if 
𝑏
𝑚
∗
=
0
b
m
∗
	​

=0, then 
𝜂
𝑚
𝜇
∗
≥
0
η
m
μ
∗
	​

≥0, hence that message’s value is weakly larger.

This is exactly the multiplier version of the directional inequality above.

6.3 Resolving the 
𝜇
∗
μ
∗
 versus 
𝜇
μ ambiguity

All these conditions are for the specific row indexed by the realized adviser belief 
𝜇
∗
μ
∗
. So the commitment-game row problem must read

min
⁡
𝛽
(
⋅
∣
𝜇
∗
)
∈
Δ
(
𝑀
)
∑
𝑚
𝛽
(
𝑚
∣
𝜇
∗
)
 
𝑈
(
𝜎
^
𝑚
∗
,
𝜇
∗
)
.
β(⋅∣μ
∗
)∈Δ(M)
min
	​

m
∑
	​

β(m∣μ
∗
)U(
σ
^
m
∗
	​

,μ
∗
).

If the sketch writes a generic 
𝜇
μ in the conclusion after perturbing the 
𝜇
∗
μ
∗
-row, that is a notation slip.

[
𝐺
𝐴
𝑃
]
 The row index in the FOC and the row index in the commitment problem must be the same 
𝜇
∗
.
[GAP] The row index in the FOC and the row index in the commitment problem must be the same μ
∗
.
7. FOC Summary

For any local minimizer 
𝛽
∗
β
∗
 of the sequential reduced problem 
𝑉
(
𝛽
)
V(β), and for every 
𝜇
∗
∈
𝑀
μ
∗
∈M, choose Bayes-optimal private strategies

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
,P
β
∗
	​

(⋅∣m)).

Then:

For any 
𝑚
2
∈
supp
⁡
𝛽
∗
(
⋅
∣
𝜇
∗
)
m
2
	​

∈suppβ
∗
(⋅∣μ
∗
) and any 
𝑚
1
∈
𝑀
m
1
	​

∈M,

𝑈
(
𝜎
^
𝑚
1
∗
,
𝜇
∗
)
−
𝑈
(
𝜎
^
𝑚
2
∗
,
𝜇
∗
)
≥
0.
U(
σ
^
m
1
	​

∗
	​

,μ
∗
)−U(
σ
^
m
2
	​

∗
	​

,μ
∗
)≥0.

If also 
𝑚
1
∈
supp
⁡
𝛽
∗
(
⋅
∣
𝜇
∗
)
m
1
	​

∈suppβ
∗
(⋅∣μ
∗
), then

𝑈
(
𝜎
^
𝑚
1
∗
,
𝜇
∗
)
=
𝑈
(
𝜎
^
𝑚
2
∗
,
𝜇
∗
)
.
U(
σ
^
m
1
	​

∗
	​

,μ
∗
)=U(
σ
^
m
2
	​

∗
	​

,μ
∗
).

Equivalently, in state-contingent form,

∑
𝜔
∈
Ω
(
𝑢
ˉ
𝜎
^
𝑚
1
∗
(
𝜔
)
−
𝑢
ˉ
𝜎
^
𝑚
2
∗
(
𝜔
)
)
𝜇
∗
(
𝜔
)
≥
0
,
ω∈Ω
∑
	​

(
u
ˉ
σ
^
m
1
	​

∗
	​

	​

(ω)−
u
ˉ
σ
^
m
2
	​

∗
	​

	​

(ω))μ
∗
(ω)≥0,

with equality when both messages are in support.

This is the rigorous version of the sketch’s displayed FOC. The only change is that the sketch’s 
𝑢
(
𝑎
∗
(
⋅
)
,
𝜔
)
u(a
∗
(⋅),ω) must be read as the state-contingent payoff generated by a Bayes-optimal private strategy, not necessarily by a pure action. 


8. Translation Conditions

The argument goes through in the paper’s 
(
𝜎
^
,
𝜃
)
(
σ
^
,θ) framework under the following conditions.

First, for each posterior 
𝜇
μ, the private-strategy problem

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
max
	​

U(
σ
^
,μ)

must admit a maximizer.

Second, for each 
𝜎
^
σ
^
, the state-contingent payoff vector

𝜔
↦
𝑢
ˉ
𝜎
^
(
𝜔
)
ω↦
u
ˉ
σ
^
	​

(ω)

must be bounded, so that 
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
,μ) is linear and uniformly Lipschitz in 
𝜇
μ.

Third, for each message 
𝑚
m, the family

𝜀
↦
𝑈
(
𝜎
^
,
𝑃
𝛽
𝜀
(
⋅
∣
𝑚
)
)
ε↦U(
σ
^
,P
β
ε
	​

	​

(⋅∣m))

must be equidifferentiable uniformly in 
𝜎
^
σ
^
, which in our finite setting follows from bounded utility and differentiability of the posterior map.

A sufficient finite-case package is:

[
𝐴
𝑆
𝑆
𝑈
𝑀
𝑃
𝑇
𝐼
𝑂
𝑁
+
]
 finite 
Θ
, compact metric 
𝐴
, bounded 
𝑢
, continuous 
𝑢
(
⋅
,
𝜔
,
𝜃
)
 in 
𝑎
.
[ASSUMPTION+] finite Θ, compact metric A, bounded u, continuous u(⋅,ω,θ) in a.

Under that package, the relevant private-strategy space is compact and Bayes-optimal private strategies exist.

Where 
𝜃
θ-suppression matters

The sketch writes 
𝑎
∗
(
𝜇
)
a
∗
(μ), as if a posterior directly chooses a pure action. In the paper, the correct object is 
𝜎
^
∗
(
𝜇
)
σ
^
∗
(μ), a private strategy mapping 
𝜃
θ to a mixed action. Therefore every occurrence of

𝑢
(
𝑎
∗
(
𝑃
𝛽
(
⋅
∣
𝑚
)
)
,
𝜔
)
u(a
∗
(P
β
	​

(⋅∣m)),ω)

should be replaced by

𝑢
ˉ
𝜎
^
∗
(
𝑃
𝛽
(
⋅
∣
𝑚
)
)
(
𝜔
)
.
u
ˉ
σ
^
∗
(P
β
	​

(⋅∣m))
	​

(ω).

Writing pure actions is legitimate only under the extra specialization

[
𝐴
𝑆
𝑆
𝑈
𝑀
𝑃
𝑇
𝐼
𝑂
𝑁
+
]
 
∣
Θ
∣
=
1
 and a pure Bayes-optimal selector exists at every posterior used.
[ASSUMPTION+] ∣Θ∣=1 and a pure Bayes-optimal selector exists at every posterior used.
9. Updated Gap Register

[GAP] “AI moves first” computes 
inf
⁡
𝛽
sup
⁡
𝜎
𝑈
(
𝛽
,
𝜎
)
inf
β
	​

sup
σ
	​

U(β,σ), not automatically the paper’s 
sup
⁡
𝜎
inf
⁡
𝛽
𝑈
(
𝛽
,
𝜎
)
sup
σ
	​

inf
β
	​

U(β,σ). Equality requires the minimax / saddle-point step.

[GAP] The sketch differentiates with respect to a single coordinate as if the simplex constraint were absent. The correct perturbation is a feasible mass shift 
𝑒
𝑚
1
−
𝑒
𝑚
2
e
m
1
	​

	​

−e
m
2
	​

	​

, or equivalently a KKT / variational-inequality argument on 
Δ
(
𝑀
)
Δ(M).

[GAP] The sketch’s envelope-theorem condition is stated imprecisely. The precise local Milgrom-Segal condition is equidifferentiability of the family of objective functions at the perturbation point.

[GAP] The “indirect effect vanishes” line is conceptually sloppy. What vanishes is the derivative of the optimizing private strategy, not the derivative of the posterior.

[GAP] Boundary cases 
𝛽
(
𝑚
∣
𝜇
∗
)
=
0
β(m∣μ
∗
)=0 require one-sided directional derivatives or KKT complementary slackness.

[GAP] The sign of the posterior derivative depends on the perturbation convention. The formalizer’s formula corresponds to shrinking one coordinate; the pairwise simplex perturbation has opposite sign for the receiving message.

[GAP] The sketch suppresses 
𝜃
θ. In the paper’s framework, the correct object is 
𝜎
^
∗
(
𝜇
)
σ
^
∗
(μ), not necessarily a pure action 
𝑎
∗
(
𝜇
)
a
∗
(μ).

[GAP] Full equivalence between the sequential reduced problem and the original simultaneous game is deferred to Blocks E-F.

10. Assumptions Inventory

[ASSUMPTION+] Bayes-optimal private strategies exist for every posterior used in Block D. A sufficient finite-case condition is finite 
Θ
Θ, compact metric 
𝐴
A, bounded 
𝑢
u, and continuity of 
𝑢
(
⋅
,
𝜔
,
𝜃
)
u(⋅,ω,θ) in 
𝑎
a.

[ASSUMPTION+] For the literal multiplier form of KKT in Section 6.2, the reduced row objective is differentiable at the candidate 
𝛽
∗
β
∗
. Without this, the directional variational inequality in Section 6.1 still gives the needed support characterization.

[ASSUMPTION+] If one insists on using the sketch’s pure-action notation 
𝑎
∗
(
𝜇
)
a
∗
(μ), then 
∣
Θ
∣
=
1
∣Θ∣=1 and a pure Bayes-optimal selector exists at each posterior used.

If you want, I can next package this into a lemma-proof format ready to drop into your proof state for Blocks C and D.