
========
ROLE: user (id=3639ee76-285a-4ddb-935b-baa568b49742)
========
# Prover pass — Lemma 2.1 (Route 1 collapse lemma trapdoor)

You are the **Prover** in the soft-scaffolding workflow. This is the trapdoor pass for Route 1 (deletion-compatible Hall duality). The R6 breakdown has identified a single critical lemma that decides whether R6 is a real proof of the target theorem or an elaborate way to rediscover menu-Hall.

## The lemma

### Setting (carried from formalizer + breakdown)

- $\Omega$ finite, $\tau$ Borel probability on $\Delta := \Delta(\Omega)$, $M = \mathrm{supp}\,\tau$, $W \subset \mathbb{R}^\Omega$ compact convex (the menu-engine payoff-profile set), $\alpha \in (0, 1)$.
- $F(C) := \int_M [\alpha \max_{w\in C}\,s\cdot w + (1-\alpha)\min_{w\in C}\,s\cdot w]\,\tau(ds)$.
- $(C^*, w^*)$: an optimal labeled compact menu, with $w^*: M \to C^*$ Borel, $w^*(s) \in \arg\max_{z\in C^*}\,s\cdot z$ τ-a.e., and $C^* = \overline{w^*(M)}$.
- $D_E := \overline{w^*(M\setminus E)}$; $\text{Del}(w^*, \tau) := \{D_E : E \in \mathcal B(M),\,\tau(E) > 0,\,D_E\subsetneq C^*\}$.
- $(H_\text{del})$: $\forall D \in \text{Del}(w^*, \tau)$, $F(D) < F(C^*)$.

### The finite LP (from Lemma 1.1)

For a finite Borel partition $\mathcal P = \{A_1, \ldots, A_n\}$ of $M$ with $\tau_i := \tau(A_i) > 0$, representative $m_i \in A_i$, cell barycenter $\bar s_i := \tau_i^{-1}\!\int_{A_i} s\,\tau(ds)$, label $w_i := w^*(m_i)$, and finite $V_0 \subset W$ containing $\{w_1, \ldots, w_n\}$, plus ε > 0:

Define the ε-edge graph $E_\eps(\mathcal P) := \{(i,j) : \bar s_i \cdot w_j \le \min_k \bar s_i \cdot w_k + \eps\}$.

LP variables: residual masses $r_{ij} \ge 0$ for $i, j \in \{1, \ldots, n\}$. Total cell mass: $x_{ij} := \alpha\tau_i \mathbb{1}_{i=j} + r_{ij}$.

Constraints:
- (a) $\sum_j r_{ij} = (1-\alpha)\tau_i$ for all $i$;
- (b) $r_{ij} = 0$ whenever $(i,j) \notin E_\eps(\mathcal P)$;
- (c) primitive cone test: $\sum_i x_{ij}\,\bar s_i \cdot (v - w_j) \le 0$ for every $j \in \{1, \ldots, n\}$ and every $v \in V_0$.

Feasibility is the only objective. The LP is finite-dimensional and Farkas applies.

### Lemma 2.1 (collapse lemma) — candidate statement

**Suppose $\mathrm{LP}(\mathcal P, V_0, \eps)$ is infeasible** for some finite Borel partition $\mathcal P$ of $M$, finite $V_0 \subset W$, and $\eps > 0$.

**Then** there exists a finite union of source cells $E = \bigcup_{i\in I} A_i$ (with $I \subsetneq \{1,\ldots,n\}$) such that:

(i) $\tau(E) > 0$;
(ii) $D_E := \overline{w^*(M\setminus E)} \subsetneq C^*$ is a proper compact deletion (i.e., $D_E \ne C^*$ and $D_E$ is compact);
(iii) $F(D_E) \ge F(C^*)$.

In particular, $D_E \in \text{Del}(w^*, \tau)$ and $F(D_E) \ge F(C^*)$, contradicting $(H_\text{del})$.

**Equivalently (contrapositive):** under $(H_\text{del})$, $\mathrm{LP}(\mathcal P, V_0, \eps)$ is feasible for every $\mathcal P, V_0, \eps$.

## What the lemma must do

Its proof must:
1. **Start from a Farkas certificate.** Infeasibility of the finite LP ⇒ existence of nonnegative dual multipliers $\lambda_i$ (for row-mass), $\mu_{ij} \ge 0$ (for non-edges, with sign reflecting forced zero), $\nu_{j,v} \ge 0$ (for cone tests), and a separation: $\sum_i \lambda_i (1-\alpha)\tau_i + \sum_j \sum_{v\in V_0} \nu_{j,v} \cdot (\text{something}) < 0$ (sign convention to be pinned down by the prover).
2. **Identify the source cells $I \subseteq \{1,\ldots,n\}$ carrying the deficiency.** This must be done in primitive vocabulary — the multipliers must be readable as "deletion prices on source cells" rather than as "calibration prices on message cells."
3. **Pull $E := \bigcup_{i\in I} A_i$ back to $M$.** Verify $\tau(E) > 0$ from the certificate.
4. **Verify $D_E := \overline{w^*(M\setminus E)} \subsetneq C^*$.** This is the **Borel→compact step**, isolated in finite combinatorial form. The certificate must guarantee that removing the cells $\bigcup_{i\in I} A_i$ removes at least one cell label $w_i$ from the closure $\overline{w^*(M\setminus E)}$. **Note:** in finite $\mathcal P$, $\overline{w^*(M\setminus E)} = \overline{\{w_j : j \notin I\}}$ if labels are distinct, else $\overline{\{w_j : j \in J^*\}}$ for some $J^* \supseteq \{1,\ldots,n\}\setminus I$. **The dual certificate must produce $J^* \subsetneq \{1, \ldots, n\}$** for the deletion to be proper.
5. **Compare $F(D_E)$ to $F(C^*)$ using only primitive inequalities.** The aligned term ($\alpha$-piece) of $F$ on $D_E$ is at most that on $C^*$ (some labels removed). The misaligned term ($1-\alpha$-piece) on $D_E$ is at least that on $C^*$ ($D_E \subseteq C^*$ ⇒ pointwise $\min$ goes up). The Farkas certificate must guarantee the second term strictly improves enough to outweigh the first.

## Three valid outcomes

**(A) Proof of Lemma 2.1.** A complete construction of $E$, $D_E$, and the comparison $F(D_E) \ge F(C^*)$, all from the Farkas certificate using primitive vocabulary. Verify the renaming test step by step: no $G(s)$, $B(m)$, $h_{B(m)}$, posterior membership, disintegration, or anything equivalent appears in the construction.

**(B) Counterexample / disproof.** A specific finite-dim model $(M, w^*, \tau, \alpha, \mathcal P, V_0, \eps)$ where $\mathrm{LP}(\mathcal P, V_0, \eps)$ is infeasible AND no proper compact deletion $D_E$ satisfies $F(D_E) \ge F(C^*)$. The most natural counterexample structure: **duplicate labels** ($w_i = w_j$ for some $i \ne j$), where deleting one cell does not shrink the labeled image. If this counterexample works, Route 1's R6 dialect is dead, R1 and R4 are also dead (they share the same collapse step), and the project moves to Route 2 (calibration-defect).

**(C) Honest stall.** A precise named obstruction. Likely candidates from the breakdown:
- "Farkas certificate prices messagewise (the $\nu_{j,v}$ multipliers) but I cannot translate to sourcewise deletion."
- "Duplicate-label cells block the Borel→compact step."
- "The aligned/misaligned offset comparison requires uniform deletion-stability that exceeds $(H_\text{del})$."

For each, name what would unblock.

## What you MUST do

- Pick one outcome and commit.
- If (A): write the proof in full, with every Farkas multiplier identified primitively, the source-cell selection $I$ derived, the proper-deletion verification, and the $F(D_E) \ge F(C^*)$ comparison. **Apply the renaming test step by step.**
- If (B): exhibit the model concretely. Verify both LP infeasibility AND no-deletion-improves explicitly.
- If (C): name the obstacle, the step it appears at, and what additional hypothesis would close it.

## What you MUST NOT do

- Do not import behavioral minimality (closure-pruning v8 Lemma 3 already gives $C^* = \overline{w^*(M)}$, but proper minimality / no-redundant-submenu is **not** assumed in $(H_\text{del})$).
- Do not import (H_C1) silently. If your proof needs no-proper-submenu-is-F-optimal as a hypothesis, surface it explicitly.
- Do not invoke posterior calibration, Bayes cones, or support functions of $B(m)$ at any step.
- Do not reduce to weak OT, persuasion duality, or martingale OT — those routes were marked dead by the searcher.

## Output Format


markdown
## Verdict
PROVED / DISPROVED / STALLED

## Outcome
(A) Proof of Lemma 2.1 / (B) Counterexample / (C) Honest stall

## Argument

(If A: full proof with Farkas multipliers identified primitively, $I$ extraction, proper-deletion verification, $F$ comparison. Apply the renaming test inline.
If B: specific model with verifications.
If C: precise obstacle and what would unblock.)

## Renaming Test Audit

(Step-by-step. For each step in the proof or counterexample, confirm no forbidden objects appear, or specify exactly where the obstruction is.)

## Implication for Route 1

(One paragraph. Does this verdict close Route 1 or keep it alive? If alive, the orchestrator continues to Lemmas 1.1, 1.2, 3.1, 3.2, 3.3. If dead, Route 1 stops and the project moves to Route 2 (calibration-defect theorem).)

## Implication for the Project

(One paragraph. Should the orchestrator continue Route 1, move to Route 2, or stop with v8?)


Length: 1500–2200 words.

Show more

========
ROLE: assistant (id=0690192a-948f-4c91-b75c-65197a8e1698)
========
Verdict

DISPROVED

Outcome

(B) Counterexample

Argument

The collapse lemma is false as stated. The failure does not require duplicate labels. A coarser, sharper obstruction is enough: a partition cell can contain both labels, while its chosen representative carries one label and its barycenter favors the other. The LP then becomes infeasible for a discretization reason, although every proper deletion strictly lowers F.

Take

Ω={0,1},α=
5
3
	​

.

Write a posterior as s
p
	​

=(1−p,p). Let

M={s
0
	​

,s
1/3
	​

,s
2/3
	​

,s
1
	​

},τ({s
p
	​

})=
4
1
	​

.

Let

a=(0,0),b=(−3,3),W=[a,b]={w
t
	​

:=tb:0≤t≤1}.

For s
p
	​

,

s
p
	​

⋅a=0,s
p
	​

⋅b=6p−3=:d(p).

Thus

d(0)=−3,d(1/3)=−1,d(2/3)=1,d(1)=3.

Set

C
∗
={a,b}.

The aligned maximizer is unique on M:

w
∗
(s
0
	​

)=a,w
∗
(s
1/3
	​

)=a,w
∗
(s
2/3
	​

)=b,w
∗
(s
1
	​

)=b.

Hence

C
∗
=
w
∗
(M)
	​

.

First verify that C
∗
 is genuinely optimal. Let C⊂W be any nonempty compact menu. Write

T
C
	​

={t∈[0,1]:w
t
	​

∈C},ℓ=minT
C
	​

,h=maxT
C
	​

.

Since s
p
	​

⋅w
t
	​

=td(p), for d(p)>0,

C
max
	​

s
p
	​

⋅w=hd(p),
C
min
	​

s
p
	​

⋅w=ℓd(p),

while for d(p)<0,

C
max
	​

s
p
	​

⋅w=ℓd(p),
C
min
	​

s
p
	​

⋅w=hd(p).

Now

∫d
+
	​

dτ=
4
1+3
	​

=1,∫(−d)
+
	​

dτ=
4
3+1
	​

=1.

Therefore

F(C)=[αh+(1−α)ℓ]⋅1−[αℓ+(1−α)h]⋅1=(2α−1)(h−ℓ).

With α=3/5,

F(C)=
5
1
	​

(h−ℓ)≤
5
1
	​

.

The menu C
∗
={a,b} has ℓ=0,h=1, so

F(C
∗
)=
5
1
	​

.

Thus C
∗
 is an optimal compact menu.

Now verify deletion stability. Since M is finite, every Borel deletion is just a subset deletion. A nonempty proper deleted image can only be

{a}or{b}.

Indeed, if the complement of E contains only s
0
	​

,s
1/3
	​

-type labels, then D
E
	​

={a}; if it contains only s
2/3
	​

,s
1
	​

-type labels, then D
E
	​

={b}. For singleton menus,

F({a})=0,F({b})=∫
M
	​

d(p)τ(dp)=
4
−3−1+1+3
	​

=0.

Hence every nonempty proper compact deletion satisfies

F(D
E
	​

)=0<
5
1
	​

=F(C
∗
).

So (H
del
	​

) holds.

Now build the finite LP.

Let the partition be

A
1
	​

={s
1/3
	​

,s
1
	​

},A
2
	​

={s
2/3
	​

,s
0
	​

},

with representatives

m
1
	​

=s
1/3
	​

,m
2
	​

=s
2/3
	​

.

Then

τ
1
	​

=τ
2
	​

=
2
1
	​

,

and

w
1
	​

=w
∗
(m
1
	​

)=a,w
2
	​

=w
∗
(m
2
	​

)=b.

The cell barycenters are

s
ˉ
1
	​

=
2
s
1/3
	​

+s
1
	​

	​

=s
2/3
	​

,
s
ˉ
2
	​

=
2
s
2/3
	​

+s
0
	​

	​

=s
1/3
	​

.

Thus

s
ˉ
1
	​

⋅(b−a)=1,
s
ˉ
2
	​

⋅(b−a)=−1.

Take

V
0
	​

={a,b},ε=
2
1
	​

.

At cell 1, the barycenter values of the two labels are

s
ˉ
1
	​

⋅a=0,
s
ˉ
1
	​

⋅b=1.

So the unique ε-minimum label is a=w
1
	​

. Thus row 1 may send residual mass only to column 1.

At cell 2,

s
ˉ
2
	​

⋅a=0,
s
ˉ
2
	​

⋅b=−1.

So the unique ε-minimum label is b=w
2
	​

. Thus row 2 may send residual mass only to column 2.

Therefore the LP edge constraints force

r
11
	​

=(1−α)τ
1
	​

=
5
2
	​

⋅
2
1
	​

=
5
1
	​

,r
12
	​

=0,

and

r
22
	​

=(1−α)τ
2
	​

=
5
1
	​

,r
21
	​

=0.

Consequently

x
11
	​

=ατ
1
	​

+r
11
	​

=
5
3
	​

⋅
2
1
	​

+
5
1
	​

=
2
1
	​

,

and similarly

x
22
	​

=
2
1
	​

,x
12
	​

=x
21
	​

=0.

Now inspect the primitive cone test for column j=1, whose label is w
1
	​

=a, against v=b∈V
0
	​

:

i
∑
	​

x
i1
	​

s
ˉ
i
	​

⋅(b−a)=x
11
	​

s
ˉ
1
	​

⋅(b−a)=
2
1
	​

⋅1=
2
1
	​

>0.

But the LP requires this quantity to be ≤0. Contradiction.

So

LP(P,V
0
	​

,ε)

is infeasible.

Finally, the finite unions of source cells do not yield a proper deletion. If E=A
1
	​

, then M∖E=A
2
	​

, and A
2
	​

 contains both an a-labeled point and a b-labeled point, so

D
E
	​

=C
∗
.

If E=A
2
	​

, the same holds because A
1
	​

 also contains both labels. The empty deletion has zero mass, and deleting both cells is not allowed by I⊊{1,2}. Thus the lemma’s required E does not exist.

This is a direct contradiction to the candidate lemma: (H
del
	​

) holds, yet the finite LP is infeasible.

Renaming Test Audit

The construction uses only the permitted primitive objects:

M,τ,W,C
∗
,w
∗
,F,P,
s
ˉ
i
	​

,w
i
	​

,V
0
	​

,ε,r
ij
	​

,x
ij
	​

.

No posterior-calibration object is introduced. No disintegration, no message-posterior best-response set, no support-function Hall condition, no weak transport, and no persuasion duality is used.

The obstruction is purely finite and primitive:

The optimal menu is the endpoint menu C
∗
={a,b}.

The deletion test is computed directly from w
∗
(M∖E).

The LP infeasibility is caused by the cone tests at the two cell barycenters.

The partition cells are label-mixed: each cell contains both an a-source and a b-source.

The representatives select labels opposite to the labels favored by their barycenters.

That last point is the trapdoor. The LP prices the aligned mass using representative labels but tests optimality using barycenters. A coarse mixed cell can therefore create artificial infeasibility unrelated to any compact deletion of C
∗
.

Implication for Route 1

Route 1, as stated, stops here. The contrapositive form is false: even under strict deletion stability, the finite LP need not be feasible for every finite partition, V
0
	​

, and ε. This counterexample does not merely expose a proof gap; it falsifies Lemma 2.1. A repaired route would need an additional partition regularity hypothesis, such as label-pure cells, barycenter-compatible representatives, or a different LP that does not attach aligned mass to representative labels while testing at barycenters. Without such a repair, the deletion-compatible Hall collapse cannot support R6.

Implication for the Project

The orchestrator should not continue Route 1 in its current form. This counterexample does not disprove unrestricted robust rationalizability, and it does not attack the menu-engine value theorem. It only kills the proposed collapse lemma and the universal LP-feasibility bridge. The project should move to Route 2, the calibration-defect theorem, or stop with the existing conditional v8 package until a new, partition-stable deletion-Hall statement is formulated.
