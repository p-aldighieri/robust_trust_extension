# Copy-Editor Response — Notation and Housekeeping Pass

**Chat URL**: https://chatgpt.com/g/g-p-69b612c07c108191a7597062801a020e/c/69c38be5-63d0-8332-be2c-a073bab4ca4f
**Role**: copy-editor (notation/housekeeping)
**Date**: 2026-03-25

---

Reviewed the attached LaTeX file 


. Not a full PASS. Most core symbols are already stable: 
𝑞
𝛽
q
β
	​

, 
𝑃
𝛽
P
β
	​

, 
𝑊
W, and 
𝑁
𝛽
N
β
	​

 are used consistently, and 
𝐵
B/
Σ
Σ are introduced in Section 3. The remaining housekeeping edits are:

Notation consistency

Lines 179 to 181, and 249 to 258: 
Φ
𝑚
Φ
m
	​

 is introduced first as a function of 
𝜀
ε, then later treated as a function of 
𝛽
β. Make this uniform. Best fix: define

Φ
𝑚
(
𝛽
)
≔
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
,
Φ
m
	​

(β):=q
β
	​

(m)W(P
β
	​

(⋅∣m)),

and then, when specializing to the perturbation path, write 
Φ
𝑚
(
𝜀
)
≔
Φ
𝑚
(
𝛽
𝜀
)
Φ
m
	​

(ε):=Φ
m
	​

(β
ε
	​

). Right now the notation slides between two meanings.

Lines 52, 54, 55, 138, 144: “DM” is still used as live notation even though Section 2 maps DM to agent. Change these to “agent” / “agent’s” for full consistency with the paper’s notation.

Lines 300, 338, 348, 353: the document mixes 
𝜎
^
𝑚
∗
σ
^
m
∗
	​

 and 
𝜎
^
∗
(
𝑚
)
σ
^
∗
(m). After line 300, pick one convention and keep it. Cleanest split: use 
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

 only when discussing the selector family, and 
𝜎
^
∗
(
𝑚
)
σ
^
∗
(m) only when discussing the committed strategy.

Lines 110, 153, 232, 249, 252, 254, 283, 336: after defining 
𝐵
B, the text repeatedly switches back to 
∏
𝜇
∈
𝑀
Δ
(
𝑀
)
∏
μ∈M
	​

Δ(M). Use 
𝐵
B uniformly except where the product form is genuinely needed for the normal-cone argument.

Lines 100, 149, 374, 378: the prose still oscillates between the simplified 
𝑢
(
𝑎
,
𝜔
)
u(a,ω) language and the full 
𝑢
ˉ
(
𝜎
^
,
𝜔
)
u
ˉ
(
σ
^
,ω) notation. Add one bridge sentence either at the end of Remark 2 or just before Section 4 saying that the derivation is conceptually the 
∣
Θ
∣
=
1
∣Θ∣=1 case but is written in the full private-strategy notation via 
𝑢
ˉ
u
ˉ
. This is the main place where the document still feels like it changes gears midstream.

Line 348: 
𝛾
𝑚
γ
m
	​

 is reintroduced in live prose, even though Section 2 says the paper’s canonical notation 
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

(⋅∣m) will be used throughout. Replace 
𝛾
𝑚
γ
m
	​

 with 
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

(⋅∣m), or explicitly label it as a temporary shorthand.

Lines 85 to 96: for exact sketch-to-paper bookkeeping, change \mathbb{P}(m) to P(m) in the notation table and accompanying remark. The sketch uses plain 
𝑃
(
𝑚
)
P(m), and your prompt specifically flags that symbol.
Related check: the table is otherwise complete for 
𝜋
π, 
𝑃
(
𝑚
)
P(m), 
𝛾
𝑚
γ
m
	​

, 
𝑎
∗
(
𝜇
)
a
∗
(μ), and 
𝑈
(
𝜋
,
𝜎
)
U(π,σ). I found no later leak of 
𝜋
π or 
𝑃
(
𝑚
)
P(m); the only later sketch-notation leak is 
𝛾
𝑚
γ
m
	​

, plus the live use of “DM.”

Undefined or overloaded symbols

Lines 348, 353, 361: 
𝑈
U becomes overloaded without local definitions. The stage-game 
𝑈
(
𝛽
,
𝜎
)
U(β,σ) is named in the table, but 
𝑈
(
𝜎
^
,
𝜈
)
U(
σ
^
,ν) and 
𝑈
(
𝜎
)
U(σ) are never locally defined. Add, near line 149,

𝑈
(
𝜎
^
,
𝜈
)
≔
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
𝜈
(
𝜔
)
,
𝑊
(
𝜈
)
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
𝜈
)
,
U(
σ
^
,ν):=
ω
∑
	​

u
ˉ
(
σ
^
,ω)ν(ω),W(ν)=
σ
^
max
	​

U(
σ
^
,ν),

and before line 361 add

𝑈
(
𝜎
)
≔
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
.
U(σ):=
β∈B
inf
	​

U(β,σ).

Otherwise those three occurrences look undefined.

Lines 211, 218, 324, 378: 
𝐴
A and 
Θ
Θ are used, but Section 3 never reintroduces them locally. Add a one-line reminder in the setup that 
𝐴
A is the action set and 
Θ
Θ is the private-type set from the paper.

Lines 96 and 357: “Definition~1” / “Definition~2” read like unresolved local references, because this document does not actually state those definitions. Rewrite as “Definition 1 in the paper” and “Definition 2 in the paper.” Line 353 already does this correctly; line 357 should match.

Cross-references and numbering

PASS on internal refs: after rerunning LaTeX, all internal \ref / \eqref links resolve cleanly. I found no broken internal cross-references.

Lines 9 to 14: numbering is sequential overall, but remark shares the theorem counter, so the first proposition appears as Proposition 3 because Remarks 1 and 2 consume the first two numbers. For conventional result numbering, put remark on its own counter or make remarks unnumbered.

Style and typo polish

Line 36: “first-order-conditions (FOC) plus envelope-theorem approach” should be smoothed out. Best fix: “first-order conditions (FOCs) plus an envelope theorem approach.”

Line 53: “Take FOC” should be “Take the FOCs” or “Derive the FOCs.”

Lines 112 and 196: the proposition subtitles use ---. For a cleaner house style, replace with a colon or parenthetical subtitle and use the same format in both places.

Lines 117, 128, 167, 348, 353, 357, and table line 86: standardize conditional bars. Use \mid consistently in 
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

(⋅∣m), and ideally also in 
𝛽
(
𝑚
∣
𝜇
)
β(m∣μ).

Line 205: this is a definitional equality, but it uses = rather than \coloneqq. Change

𝑋
∗
(
0
)
=
arg max
⁡
𝑥
∈
𝑋
𝑓
(
0
,
𝑥
)
X
∗
(0)=
x∈X
argmax
	​

f(0,x)

to \coloneqq to match the rest of the document.
Line 338: same issue, though milder, because line 300 already used \coloneqq.

Line 314: \argmin_m should match line 312’s \argmin_{m \in M}.

The highest-priority fixes are items 1.1, 1.5, 1.6, and 2.1. Those are the places where the notation still visibly wobbles.