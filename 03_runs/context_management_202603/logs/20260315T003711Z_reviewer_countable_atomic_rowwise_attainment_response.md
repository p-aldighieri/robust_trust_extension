I’m reviewing the rowwise-attainment packet alongside the three support notes and Theorem 2’s exact requirement, then I’ll give a narrow PASS/FAIL on whether this lemma really closes the adviser-attainment hinge and identify any remaining bottleneck.

I’m also cross-checking the lemma against the durable proof state, exact branch context, the reduced objective, the banked continuity step, and the paper’s robust-rationalizability usage.

Thought for 18m 15s

Verdict: PASS.

First specific defect: none on the stated local lemma.

The rowwise-attainment argument is mathematically sound on its local scope. The contradiction mechanism is the right one: if row 
𝑖
i has an unattained floor 
𝑔
𝑖
=
inf
⁡
𝑗
(
𝑚
𝑖
⋅
𝑤
𝑗
∗
)
g
i
	​

=inf
j
	​

(m
i
	​

⋅w
j
∗
	​

), then the near-minimizer set

𝐴
𝜀
=
{
𝑗
:
 
𝑚
𝑖
⋅
𝑤
𝑗
∗
<
𝑔
𝑖
+
𝜀
}
A
ε
	​

={j: m
i
	​

⋅w
j
∗
	​

<g
i
	​

+ε}

has 
𝜏
(
𝐴
𝜀
)
→
0
τ(A
ε
	​

)→0 as 
𝜀
↓
0
ε↓0, because every fixed coordinate lies strictly above 
𝑔
𝑖
g
i
	​

 and the atomic weights are summable. Modifying exactly those coordinates by convexly mixing them toward one fixed better coordinate 
𝑝
p raises the 
𝑖
i-th row floor by at least 
𝜀
ε, does not lower any other row floor, and changes the aligned part only on a 
𝜏
τ-small set. Hence the aligned loss is 
𝑂
(
𝜀
 
𝜏
(
𝐴
𝜀
)
)
=
𝑜
(
𝜀
)
O(ετ(A
ε
	​

))=o(ε), while the misaligned gain is at least 
(
1
−
𝛼
)
𝜏
𝑖
𝜀
(1−α)τ
i
	​

ε, contradicting maximality of 
𝑤
∗
w
∗
. So every rowwise infimum is attained, and one can indeed choose an honest-space minimizing kernel row by row. 

20260314T192923Z_prover_countab…

The only cleanup worth noting is cosmetic: in the aligned-loss estimate, keep the denominator 
𝑑
=
𝑐
𝑖
𝑝
−
𝑔
𝑖
d=c
ip
	​

−g
i
	​

 explicit. The bound is 
𝑂
(
𝜀
/
𝑑
)
O(ε/d) per modified coordinate, not 
𝑂
(
𝑑
𝜀
)
O(dε). That is a writeup issue, not a logical gap. 

20260314T192923Z_prover_countab…

Next local bottleneck: not rowwise attainment anymore. Using the already banked continuity block, the reduced value

𝑅
(
𝑤
)
=
inf
⁡
𝛽
𝑈
(
𝛽
,
𝑤
)
R(w)=
β
inf
	​

U(β,w)

should now be routine to maximize on compact 
𝑊
𝑁
W
N
, so the real remaining hinge is the final lift from the reduced saddle to an actual robustly rationalizable original strategy. In Theorem 2 terms, one still must show message-by-message Bayes optimality of the private strategies induced by the reduced saddle, not merely existence of a minimizing kernel. On this countable atomic direct branch, that lift should be simpler than the exhausted exact-route null-set patching problem, because for 
𝛼
>
0
α>0 every message atom is on path with positive aligned mass. 

20260314T191149Z_reviewer_count…

 

RobustTrust_up_to_Theorem2

Suggested next local action: prove the direct atomic lift lemma. Starting from a reduced maximizer 
𝑤
∗
w
∗
 and the rowwise minimizing kernel 
𝛽
∗
β
∗
, define for each message 
𝑗
j

𝜆
𝑗
=
𝛼
𝜏
𝑗
+
(
1
−
𝛼
)
∑
𝑖
𝜏
𝑖
𝛽
𝑖
𝑗
∗
,
𝑞
𝑗
∝
𝛼
𝜏
𝑗
𝑚
𝑗
+
(
1
−
𝛼
)
∑
𝑖
𝜏
𝑖
𝛽
𝑖
𝑗
∗
𝑚
𝑖
.
λ
j
	​

=ατ
j
	​

+(1−α)
i
∑
	​

τ
i
	​

β
ij
∗
	​

,q
j
	​

∝ατ
j
	​

m
j
	​

+(1−α)
i
∑
	​

τ
i
	​

β
ij
∗
	​

m
i
	​

.

Then show that for every 
𝑗
j with 
𝜆
𝑗
>
0
λ
j
	​

>0, the coordinate 
𝑤
𝑗
∗
w
j
∗
	​

 solves

𝑤
𝑗
∗
∈
arg
⁡
max
⁡
𝑤
∈
𝑊
𝑞
𝑗
⋅
𝑤
,
w
j
∗
	​

∈arg
w∈W
max
	​

q
j
	​

⋅w,

so each 
𝑤
𝑗
∗
w
j
∗
	​

 can be implemented by a Bayes-optimal private strategy at posterior 
𝑞
𝑗
q
j
	​

; add the separate 
𝛼
=
0
α=0 patch afterward. 

20260314T192923Z_prover_countab…

 

RobustTrust_up_to_Theorem2

Sources
