I’m focusing narrowly on the rowwise-attainment hinge in the honest countable simplex product, weighing a forcing lemma for attained row minima against an explicit counterexample obstructing exact reduced saddles.

The continuity issue is settled, so the question is now purely geometric: can an optimal 
𝑤
∗
w
∗
 still only chase a horizon, with row infima living in the closure but not attained on any actual index?

Thought for 26m 36s

Verdict: POSITIVE

Local lemma: rowwise adviser infima are attained at any reduced maximizer

Let

𝑅
(
𝑤
)
:
=
𝛼
∑
𝑗
≥
1
𝜏
𝑗
 
𝑚
𝑗
 ⁣
⋅
𝑤
𝑗
+
(
1
−
𝛼
)
∑
𝑖
≥
1
𝜏
𝑖
 
inf
⁡
𝑗
≥
1
(
𝑚
𝑖
 ⁣
⋅
𝑤
𝑗
)
,
𝑤
=
(
𝑤
𝑗
)
𝑗
≥
1
∈
𝑊
𝑁
,
R(w):=α
j≥1
∑
	​

τ
j
	​

m
j
	​

⋅w
j
	​

+(1−α)
i≥1
∑
	​

τ
i
	​

j≥1
inf
	​

(m
i
	​

⋅w
j
	​

),w=(w
j
	​

)
j≥1
	​

∈W
N
,

where 
𝑊
⊂
𝑅
Ω
W⊂R
Ω
 is the compact convex payoff set from Appendix A.1.

Fix a relevant reduced maximizer 
𝑤
∗
=
(
𝑤
𝑗
∗
)
𝑗
≥
1
∈
arg
⁡
max
⁡
𝑅
w
∗
=(w
j
∗
	​

)
j≥1
	​

∈argmaxR. Then, for every row 
𝑖
i,

arg
⁡
min
⁡
𝑗
≥
1
(
𝑚
𝑖
 ⁣
⋅
𝑤
𝑗
∗
)
≠
∅
.
arg
j≥1
min
	​

(m
i
	​

⋅w
j
∗
	​

)

=∅.

Equivalently, if 
0
≤
𝛼
<
1
0≤α<1, every reduced maximizer admits a genuine honest-space rowwise minimizer kernel

𝛽
𝑖
∗
=
𝛿
𝑗
(
𝑖
)
,
𝑗
(
𝑖
)
∈
arg
⁡
min
⁡
𝑗
(
𝑚
𝑖
 ⁣
⋅
𝑤
𝑗
∗
)
.
β
i
∗
	​

=δ
j(i)
	​

,j(i)∈arg
j
min
	​

(m
i
	​

⋅w
j
∗
	​

).

For 
𝛼
=
1
α=1, the adviser term disappears, so the attainment issue is vacuous.

Proof

Write

𝑐
ℓ
𝑗
:
=
𝑚
ℓ
 ⁣
⋅
𝑤
𝑗
∗
,
𝑔
ℓ
:
=
inf
⁡
𝑗
≥
1
𝑐
ℓ
𝑗
(
ℓ
≥
1
)
.
c
ℓj
	​

:=m
ℓ
	​

⋅w
j
∗
	​

,g
ℓ
	​

:=
j≥1
inf
	​

c
ℓj
	​

(ℓ≥1).

Also let

𝐶
𝑊
:
=
sup
⁡
𝑤
∈
𝑊
∥
𝑤
∥
∞
<
∞
.
C
W
	​

:=
w∈W
sup
	​

∥w∥
∞
	​

<∞.

Because each 
𝑚
ℓ
∈
Δ
(
Ω
)
m
ℓ
	​

∈Δ(Ω), we have 
∥
𝑚
ℓ
∥
1
=
1
∥m
ℓ
	​

∥
1
	​

=1, hence

∣
𝑚
ℓ
 ⁣
⋅
𝑤
∣
≤
𝐶
𝑊
for all 
ℓ
,
𝑤
.
∣m
ℓ
	​

⋅w∣≤C
W
	​

for all ℓ,w.

Assume toward contradiction that for some row 
𝑖
i,

arg
⁡
min
⁡
𝑗
𝑐
𝑖
𝑗
=
∅
.
arg
j
min
	​

c
ij
	​

=∅.

Then 
𝑐
𝑖
𝑗
>
𝑔
𝑖
c
ij
	​

>g
i
	​

 for every 
𝑗
j.

Pick one coordinate 
𝑝
p and set

𝑑
:
=
𝑐
𝑖
𝑝
−
𝑔
𝑖
>
0.
d:=c
ip
	​

−g
i
	​

>0.

Now fix 
0
<
𝜀
<
𝑑
/
2
0<ε<d/2, and define the “bad” set

𝐴
𝜀
:
=
{
𝑗
≥
1
:
 
𝑐
𝑖
𝑗
<
𝑔
𝑖
+
𝜀
}
.
A
ε
	​

:={j≥1: c
ij
	​

<g
i
	​

+ε}.

Since the infimum is not attained, 
1
{
𝑐
𝑖
𝑗
<
𝑔
𝑖
+
𝜀
}
↓
0
1
{c
ij
	​

<g
i
	​

+ε}
	​

↓0 pointwise as 
𝜀
↓
0
ε↓0. Because 
∑
𝑗
𝜏
𝑗
=
1
∑
j
	​

τ
j
	​

=1, dominated convergence on the counting measure gives

𝜏
(
𝐴
𝜀
)
:
=
∑
𝑗
∈
𝐴
𝜀
𝜏
𝑗
⟶
0
(
𝜀
↓
0
)
.
τ(A
ε
	​

):=
j∈A
ε
	​

∑
	​

τ
j
	​

⟶0(ε↓0).

For each 
𝑗
∈
𝐴
𝜀
j∈A
ε
	​

, define

𝜆
𝑗
:
=
𝑔
𝑖
+
𝜀
−
𝑐
𝑖
𝑗
𝑐
𝑖
𝑝
−
𝑐
𝑖
𝑗
,
𝑤
~
𝑗
:
=
(
1
−
𝜆
𝑗
)
𝑤
𝑗
∗
+
𝜆
𝑗
𝑤
𝑝
∗
.
λ
j
	​

:=
c
ip
	​

−c
ij
	​

g
i
	​

+ε−c
ij
	​

	​

,
w
~
j
	​

:=(1−λ
j
	​

)w
j
∗
	​

+λ
j
	​

w
p
∗
	​

.

For 
𝑗
∉
𝐴
𝜀
j∈
/
A
ε
	​

, set 
𝑤
~
𝑗
:
=
𝑤
𝑗
∗
w
~
j
	​

:=w
j
∗
	​

.

Because 
𝑊
W is convex, every 
𝑤
~
𝑗
∈
𝑊
w
~
j
	​

∈W. Let 
𝑤
~
=
(
𝑤
~
𝑗
)
𝑗
≥
1
w
~
=(
w
~
j
	​

)
j≥1
	​

.

1. The 
𝑖
i-th row floor rises by at least 
𝜀
ε

If 
𝑗
∈
𝐴
𝜀
j∈A
ε
	​

, then by construction

𝑚
𝑖
 ⁣
⋅
𝑤
~
𝑗
=
(
1
−
𝜆
𝑗
)
𝑐
𝑖
𝑗
+
𝜆
𝑗
𝑐
𝑖
𝑝
=
𝑔
𝑖
+
𝜀
.
m
i
	​

⋅
w
~
j
	​

=(1−λ
j
	​

)c
ij
	​

+λ
j
	​

c
ip
	​

=g
i
	​

+ε.

If 
𝑗
∉
𝐴
𝜀
j∈
/
A
ε
	​

, then 
𝑐
𝑖
𝑗
≥
𝑔
𝑖
+
𝜀
c
ij
	​

≥g
i
	​

+ε, so also

𝑚
𝑖
 ⁣
⋅
𝑤
~
𝑗
=
𝑐
𝑖
𝑗
≥
𝑔
𝑖
+
𝜀
.
m
i
	​

⋅
w
~
j
	​

=c
ij
	​

≥g
i
	​

+ε.

Hence

inf
⁡
𝑗
(
𝑚
𝑖
 ⁣
⋅
𝑤
~
𝑗
)
≥
𝑔
𝑖
+
𝜀
.
j
inf
	​

(m
i
	​

⋅
w
~
j
	​

)≥g
i
	​

+ε.
2. No other row floor goes down

Fix any row 
ℓ
ℓ. For every original coordinate 
𝑗
j,

𝑐
ℓ
𝑗
≥
𝑔
ℓ
,
c
ℓj
	​

≥g
ℓ
	​

,

simply because 
𝑔
ℓ
g
ℓ
	​

 is the infimum over all coordinates.

In particular, both 
𝑐
ℓ
𝑗
c
ℓj
	​

 and 
𝑐
ℓ
𝑝
c
ℓp
	​

 are at least 
𝑔
ℓ
g
ℓ
	​

. Therefore, for 
𝑗
∈
𝐴
𝜀
j∈A
ε
	​

,

𝑚
ℓ
 ⁣
⋅
𝑤
~
𝑗
=
(
1
−
𝜆
𝑗
)
𝑐
ℓ
𝑗
+
𝜆
𝑗
𝑐
ℓ
𝑝
≥
𝑔
ℓ
.
m
ℓ
	​

⋅
w
~
j
	​

=(1−λ
j
	​

)c
ℓj
	​

+λ
j
	​

c
ℓp
	​

≥g
ℓ
	​

.

For 
𝑗
∉
𝐴
𝜀
j∈
/
A
ε
	​

, nothing changed. So

inf
⁡
𝑗
(
𝑚
ℓ
 ⁣
⋅
𝑤
~
𝑗
)
≥
𝑔
ℓ
for every 
ℓ
.
j
inf
	​

(m
ℓ
	​

⋅
w
~
j
	​

)≥g
ℓ
	​

for every ℓ.

Thus the misaligned term weakly increases in every row, and in row 
𝑖
i it increases by at least 
𝜀
ε.

3. The aligned loss is 
𝑜
(
𝜀
)
o(ε)

For 
𝑗
∈
𝐴
𝜀
j∈A
ε
	​

,

𝑐
𝑖
𝑝
−
𝑐
𝑖
𝑗
>
𝑑
−
𝜀
>
𝑑
/
2
,
c
ip
	​

−c
ij
	​

>d−ε>d/2,

so

0
<
𝜆
𝑗
=
𝑔
𝑖
+
𝜀
−
𝑐
𝑖
𝑗
𝑐
𝑖
𝑝
−
𝑐
𝑖
𝑗
≤
𝜀
𝑑
/
2
=
2
𝜀
𝑑
.
0<λ
j
	​

=
c
ip
	​

−c
ij
	​

g
i
	​

+ε−c
ij
	​

	​

≤
d/2
ε
	​

=
d
2ε
	​

.

Also,

∥
𝑤
~
𝑗
−
𝑤
𝑗
∗
∥
∞
=
𝜆
𝑗
∥
𝑤
𝑝
∗
−
𝑤
𝑗
∗
∥
∞
≤
2
𝐶
𝑊
𝜆
𝑗
.
∥
w
~
j
	​

−w
j
∗
	​

∥
∞
	​

=λ
j
	​

∥w
p
∗
	​

−w
j
∗
	​

∥
∞
	​

≤2C
W
	​

λ
j
	​

.

Hence

∣
𝑚
𝑗
 ⁣
⋅
(
𝑤
~
𝑗
−
𝑤
𝑗
∗
)
∣
≤
∥
𝑚
𝑗
∥
1
∥
𝑤
~
𝑗
−
𝑤
𝑗
∗
∥
∞
≤
2
𝐶
𝑊
𝜆
𝑗
≤
4
𝐶
𝑊
𝑑
𝜀
.
∣m
j
	​

⋅(
w
~
j
	​

−w
j
∗
	​

)∣≤∥m
j
	​

∥
1
	​

∥
w
~
j
	​

−w
j
∗
	​

∥
∞
	​

≤2C
W
	​

λ
j
	​

≤
d
4C
W
	​

	​

ε.

Therefore the total aligned loss is bounded by

𝛼
∑
𝑗
∈
𝐴
𝜀
𝜏
𝑗
 
∣
𝑚
𝑗
 ⁣
⋅
(
𝑤
~
𝑗
−
𝑤
𝑗
∗
)
∣
≤
4
𝛼
𝐶
𝑊
𝑑
 
𝜀
 
𝜏
(
𝐴
𝜀
)
.
α
j∈A
ε
	​

∑
	​

τ
j
	​

∣m
j
	​

⋅(
w
~
j
	​

−w
j
∗
	​

)∣≤
d
4αC
W
	​

	​

ετ(A
ε
	​

).
4. Contradiction to optimality

Combine the previous bounds:

𝑅
(
𝑤
~
)
−
𝑅
(
𝑤
∗
)
≥
(
1
−
𝛼
)
𝜏
𝑖
 
𝜀
−
4
𝛼
𝐶
𝑊
𝑑
 
𝜀
 
𝜏
(
𝐴
𝜀
)
.
R(
w
~
)−R(w
∗
)≥(1−α)τ
i
	​

ε−
d
4αC
W
	​

	​

ετ(A
ε
	​

).

Since 
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

)→0, for all sufficiently small 
𝜀
ε,

4
𝛼
𝐶
𝑊
𝑑
𝜏
(
𝐴
𝜀
)
<
(
1
−
𝛼
)
𝜏
𝑖
.
d
4αC
W
	​

	​

τ(A
ε
	​

)<(1−α)τ
i
	​

.

Then 
𝑅
(
𝑤
~
)
−
𝑅
(
𝑤
∗
)
>
0
R(
w
~
)−R(w
∗
)>0, contradicting maximality of 
𝑤
∗
w
∗
.

So the assumption of nonattainment was false. Hence every rowwise infimum is attained.

Consequence for the branch

The honest simplex-product spaces do not suffer a genuine rowwise-attainment obstruction.

Given any reduced maximizer 
𝑤
∗
w
∗
, choose

𝑗
(
𝑖
)
∈
arg
⁡
min
⁡
𝑗
(
𝑚
𝑖
 ⁣
⋅
𝑤
𝑗
∗
)
j(i)∈arg
j
min
	​

(m
i
	​

⋅w
j
∗
	​

)

for each 
𝑖
i, and define the honest kernel

𝛽
𝑖
∗
=
𝛿
𝑗
(
𝑖
)
∈
Δ
(
𝑁
)
.
β
i
∗
	​

=δ
j(i)
	​

∈Δ(N).

Then

∑
𝑗
𝛽
𝑖
𝑗
∗
(
𝑚
𝑖
 ⁣
⋅
𝑤
𝑗
∗
)
=
inf
⁡
𝑗
(
𝑚
𝑖
 ⁣
⋅
𝑤
𝑗
∗
)
,
j
∑
	​

β
ij
∗
	​

(m
i
	​

⋅w
j
∗
	​

)=
j
inf
	​

(m
i
	​

⋅w
j
∗
	​

),

so 
𝛽
∗
=
(
𝛽
𝑖
∗
)
𝑖
≥
1
∈
∏
𝑖
Δ
(
𝑁
)
β
∗
=(β
i
∗
	​

)
i≥1
	​

∈∏
i
	​

Δ(N) is a genuine adviser minimizer against 
𝑤
∗
w
∗
.

So the previously suspected “phantom minimum” failure mode cannot occur at a reduced maximizer on the countable-atomic direct branch.

Mechanism

The mechanism is clean:

If a row infimum is unattained, only a vanishing 
𝜏
τ-mass of coordinates lies within 
𝜀
ε of that bad floor.

Pick any existing coordinate that is strictly better in that row.

By convexity of 
𝑊
W, nudge exactly those near-bad coordinates toward that better point just enough to lift the bad row by 
𝜀
ε.

Because both endpoints already lie above every current row floor, no other row floor can drop.

The aligned loss per modified coordinate is only 
𝑂
(
𝜀
)
O(ε), so the total aligned loss is 
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

))=o(ε).

The misaligned gain is fixed order 
𝜀
ε, namely 
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

ε.

That contradiction rules out nonattained row infima at any maximizer.

Suggested next local action: prove existence or upper semicontinuity of the reduced value functional 
𝑅
R on the compact agent space 
𝑊
𝑁
W
N
, since once a reduced maximizer exists, the honest-space adversarial kernel now comes for free.
