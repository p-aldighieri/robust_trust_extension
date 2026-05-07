
========
ROLE: user (id=09ad7929-6672-4b97-8a2d-503ef18c4de0)
========
# Breakdown — Route 1, R6: finite-partition capacitary Hall + projective limit

You are the **Breakdown** role in the soft-scaffolding workflow. The searcher just ranked R6 as the top route for the Route 1 target theorem. Your job is to decompose R6 into a numbered sequence of concrete lemmas a prover can attack one at a time, identify the **critical lemma** whose proof or disproof determines Route 1's life, and apply the renaming test to every step.

## What R6 does

For each finite Borel partition $\mathcal P$ of $M$, finite ε-contact graph (which message-cell may serve as rowwise minimizer for which source-cell), and finite test set $V_0 \subset W$, formulate a **finite Hall/Farkas feasibility problem** in primitive variables. Its variables are masses (source-cell × message-cell) and primitive prices; its constraints are raw inequalities of the form $\sum \int s\cdot(v - w^*(m_A))\,(\cdot) \le 0$ for $v \in V_0$, plus approximate row-minimizer edge constraints, plus a truthful diagonal mass lower bound. **No constraint mentions $h_{B(m)}$ or posterior membership.**

If the finite LP is feasible for every $\mathcal P, V_0$ at every ε, weak compactness of joint laws on $M\times M$ + a suitable disintegration step + a dense $V_0 \uparrow W$ recovers a Borel kernel $\kappa$ realizing the conclusion.

If the finite LP is infeasible at some $\mathcal P, V_0$, Farkas gives a **dual deficiency certificate**. The critical step — the "collapse lemma" — is to convert that deficiency certificate into a **proper deletion-achievable $D \in \text{Del}(w^*, \tau)$ with $F(D) \ge F(C^*)$**, contradicting $(H_\text{del})$.

If the collapse lemma fails (the deficiency certificate cannot be lifted to a proper compact deletion), **Route 1 stops** rather than smuggle calibration into the hypothesis.

## Your task

Produce a numbered breakdown with the structure below. Be concrete: every lemma needs a precise candidate statement, dependencies, technique hint, difficulty estimate, and a renaming-test note.

### Step 1 — Setup lemmas

Lemmas defining and verifying the finite LP. These should be light/medium and primitive.

- **Lemma 1.1 (finite LP construction).** For each finite Borel partition $\mathcal P$ of $M$ with cells $A_1, \ldots, A_n$, each ε > 0, each finite $V_0 \subset W$ containing the cell representatives $\{w^*(m_{A_i}) : i\}$ and the test profiles, formulate the finite LP $\mathrm{LP}(\mathcal P, V_0, \eps)$ with:
  - Variables: nonnegative masses $x_{ij}$ on cell pairs $(A_i, A_j)$.
  - Constraints: (a) marginal $\sum_j x_{ij} = \tau(A_i)$; (b) truthful lower bound $x_{ii} \ge \alpha\,\tau(A_i)$; (c) ε-row-minimizer edge: $x_{ij} > 0$ only if $s_{A_i} \cdot w^*(m_{A_j}) \le \min_{k} s_{A_i} \cdot w^*(m_{A_k}) + \eps$; (d) cell-level cone test: for every $v \in V_0$, ...
  - Objective: feasibility (no objective).
  
  The exact form of (d) is the substantive content. State it as a **primitive cell-level inequality** that must imply the conclusion when $\mathcal P$ is fine enough and $V_0$ is dense.

- **Lemma 1.2 (renaming test for the LP).** Verify that $\mathrm{LP}(\mathcal P, V_0, \eps)$ contains no variable, constraint, or objective term that names $G(s)$, $B(m)$, $h_{B(m)}$, posterior membership, or any disintegration. If it does, rewrite or surface as ambiguity.

### Step 2 — Critical lemma (the trapdoor)

- **Lemma 2.1 (collapse lemma).** Suppose $\mathrm{LP}(\mathcal P, V_0, \eps)$ is **infeasible** for some $\mathcal P, V_0, \eps$. Then there exists a Borel $E \subseteq M$ with $\tau(E) > 0$, $D_E := \overline{w^*(M\setminus E)} \subsetneq C^*$ proper compact, and $F(D_E) \ge F(C^*)$. Hence $(H_\text{del})$ fails.

This is the trapdoor. Its proof must:
- start from the Farkas dual deficiency certificate of an infeasible LP;
- identify the source cells whose deficiency drives infeasibility;
- pull those cells back to a Borel $E \subseteq M$;
- guarantee $\overline{w^*(M\setminus E)}$ is a proper compact subset of $C^*$ (closing the Borel→compact gap inside the finite combinatorial framework);
- compare $F(D_E)$ to $F(C^*)$ using only primitive inequalities.

**Difficulty: heavy.** This is the lemma that decides Route 1.

### Step 3 — Limit lemmas

If Lemma 2.1 holds, finite feasibility for every $\mathcal P, V_0, \eps$ is established (by contrapositive of $(H_\text{del})$). Then:

- **Lemma 3.1 (compactness of finite feasible joint laws).** For each $\mathcal P, V_0, \eps$, the LP feasibility produces a probability measure $\gamma_{\mathcal P, V_0, \eps}$ on $M \times M$. The family is tight; weak limits exist along a refining sequence.
  
  Difficulty: medium. Standard tightness + Prokhorov.

- **Lemma 3.2 (limit kernel construction).** Take a weak limit $\gamma^*$ along a refining sequence $\mathcal P_n \uparrow \mathcal B(M)$, $V_0^{(n)} \uparrow W$ dense, $\eps_n \downarrow 0$. Disintegrate $\gamma^*$ over its second coordinate to get the kernel $\kappa$. Verify the marginals (Lemma 1.1 (a)–(b)) and the row-minimizer-support condition (the limit of (c)) carry through, and that the cell-level cone test (d) limits to $P_{\gamma_\alpha}(\cdot \mid m) \in B(m)$ q-a.e.
  
  Difficulty: heavy. Disintegration of a weak limit is standard but the Bayes-cone condition is what the cell-level test (d) is engineered to deliver — getting that engineering right is the substantive content.

- **Lemma 3.3 (renaming test for the limit).** Verify the limit construction does not require imposing any forbidden constraint at the limit step. If the cell-level test (d) was correctly chosen primitive in Lemma 1.1, this should be automatic.

### Step 4 — Critical-lemma-first numbered action list

The orchestrator will route the next prover pass to one of these in order:

1. Prove **Lemma 2.1 (collapse lemma).** If it fails, Route 1 stops and the project moves to Route 2.
2. If Lemma 2.1 holds: prove **Lemma 1.1 + 1.2** (finite LP construction + renaming check).
3. Prove **Lemma 3.1 + 3.2 + 3.3** (compactness + limit kernel + limit renaming check).

### Step 5 — Test cases

Identify concrete test cases where the breakdown's critical lemma can be checked:

- **Finite $M$:** the LP is finite-dimensional; Farkas applies directly. Lemma 2.1 should reduce to a clean Farkas argument.
- **Binary state $|\Omega| = 2$:** the paper's quantile transport (Appendix A.6) is a candidate verifier — do the LP feasibilities reproduce it?
- **Spherical / radial $|\Omega| \ge 3$:** the paper's antipodal construction (§5.2 + Appendix A.10) — same question.
- **v8 ternary witness:** the witness fails menu-Hall; under the strong reading of behavioral minimality (which is wrong for the witness's halfspace $T$), does the LP detect infeasibility AND the collapse lemma produce a deletion certificate? This is a valuable internal-consistency check.

### Step 6 — Renaming-test global note

Reaffirm: every lemma in the chain must be statable in primitive terms only ($F$, $w^*$, $\tau$, $\alpha$, compact source patches, raw payoff comparisons $s \cdot v$ for $v \in W$). If any lemma's natural statement requires posterior membership or Bayes-cone constraints, surface it as a fundamental ambiguity, not a step to be patched.

## What you MUST do

- Be precise. Every lemma needs a candidate statement, not a description.
- Apply the renaming test to every lemma.
- Identify the single critical lemma (Lemma 2.1) and explain in one paragraph why it is the trapdoor.
- Output a numbered action list at the end so the orchestrator can route the next prover pass.

## What you MUST NOT do

- Do not propose proofs.
- Do not reuse the searcher's R1/R4 framing; this is R6's specific decomposition.
- Do not silently strengthen to (H_C1) without flagging.

## Output Format


markdown
## R6 Breakdown

### Step 1 — Setup
- Lemma 1.1 (finite LP construction): statement, dependencies, technique, difficulty, renaming-test note.
- Lemma 1.2 (renaming check on LP): statement, dependencies, technique, difficulty.

### Step 2 — Critical Lemma (the trapdoor)
- Lemma 2.1 (collapse lemma): statement, dependencies, technique, difficulty, renaming-test note.
- Justification why this is the trapdoor: (one paragraph)

### Step 3 — Limit
- Lemma 3.1 (tightness/compactness): ...
- Lemma 3.2 (limit kernel): ...
- Lemma 3.3 (limit renaming check): ...

### Step 4 — Numbered Action List for Prover

1. (Critical lemma to attack first.)
2. (Next.)
3. ...

### Step 5 — Test Cases
- Finite M: ...
- Binary: ...
- Spherical/radial: ...
- v8 ternary witness: ...

### Step 6 — Global Renaming Note
(Restate the renaming test discipline at the breakdown level.)

### Honest Assessment
(One paragraph: is R6 a real route, or is the collapse lemma likely to hide a renaming? If the collapse lemma fails on the v8 witness internal-consistency check, Route 1 should stop at Lemma 2.1.)


Length: 1500–2200 words.

Show more

========
ROLE: assistant (id=20e8b964-edb3-46de-9486-6dc926958d63)
========
R6 Breakdown

Working notation: W⊂R
∣Ω∣
 is the compact payoff-profile set; C
∗
⊂W is the chosen optimal compact menu; w
∗
:M→C
∗
 is the aligned-best Borel labeling; and

F(C)=∫
M
	​

[α
w∈C
max
	​

s⋅w+(1−α)
w∈C
min
	​

s⋅w]τ(ds).

For a Borel E⊆M, write

D
E
	​

:=
w
∗
(M∖E)
	​

,Del(w
∗
,τ):={D
E
	​

:τ(E)>0, D
E
	​

⊊C
∗
}.

This is aimed at the infinite-M,Θ existence direction of Theorem 2, whose paper version assumes finite M,Θ. 

objective_statement

Step 1: Setup

Lemma 1.1 (finite LP construction).

Candidate statement. Let P={A
1
	​

,…,A
n
	​

} be a finite Borel partition of M, with τ
i
	​

:=τ(A
i
	​

)>0, representative m
i
	​

∈A
i
	​

, barycenter

s
ˉ
i
	​

:=τ
i
−1
	​

∫
A
i
	​

	​

sτ(ds),

and label w
i
	​

:=w
∗
(m
i
	​

). For ε>0, define the finite approximate minimizer graph

E
ε
	​

(P):={(i,j):
s
ˉ
i
	​

⋅w
j
	​

≤
k
min
	​

s
ˉ
i
	​

⋅w
k
	​

+ε}.

For finite V
0
	​

⊂W containing {w
1
	​

,…,w
n
	​

}, define LP(P,V
0
	​

,ε) with variables r
ij
	​

≥0, interpreted as misaligned residual mass from source cell A
i
	​

 to message cell A
j
	​

, and total cell mass

x
ij
	​

:=ατ
i
	​

1
i=j
	​

+r
ij
	​

.

The constraints are:

j
∑
	​

r
ij
	​

=(1−α)τ
i
	​

for all i,
r
ij
	​

=0whenever (i,j)∈
/
E
ε
	​

(P),

hence automatically

j
∑
	​

x
ij
	​

=τ
i
	​

,x
ii
	​

≥ατ
i
	​

,

and the primitive cell-level cone tests

i
∑
	​

x
ij
	​

s
ˉ
i
	​

⋅(v−w
j
	​

)≤0for every j=1,…,n, v∈V
0
	​

.
	​


Feasibility is the only objective. The boxed condition is the engineered test: it says the total source mass arriving at message-cell j, including truthful diagonal mass, does not prefer any tested profile v to the primitive label w
j
	​

. It is deliberately written as raw payoff comparisons, not as a posterior constraint.

Dependencies. Compact payoff-profile formulation; Borel selector w
∗
; finite partition data; finite test set V
0
	​

.

Technique hint. Pure finite-dimensional linear feasibility after rewriting truthful mass as a fixed diagonal component plus residual adversarial mass.

Difficulty. Medium. The LP itself is light; the nontrivial point is choosing the boxed condition so it survives refinement.

Renaming-test note. Passes only in the residual form above. If the edge constraint is imposed on total x
ij
	​

, the truthful diagonal mass is accidentally forced to be adversarial minimizer mass, which is false. The LP names only τ,α,w
∗
,V
0
	​

,
s
ˉ
i
	​

, and raw dot products s⋅v. It does not name G(s), B(m), h
B(m)
	​

, posterior membership, or a disintegration.

Lemma 1.2 (renaming check on LP).

Candidate statement. The LP in Lemma 1.1 is admissible for Route 1 iff every constraint can be expressed using only

α,τ(A
i
	​

),∫
A
i
	​

	​

sdτ(s),w
∗
(m
j
	​

),V
0
	​

,ε,

and affine payoff comparisons. In particular, the cell-level cone test must remain the boxed inequality above, and any formulation using

P(⋅∣A
j
	​

)∈B(A
j
	​

),h
B(m
j
	​

)
	​

,“posterior belongs to the Bayes cone”

is a failed renaming test.

Dependencies. Lemma 1.1.

Technique hint. Syntactic audit of every symbol appearing in the finite feasibility system.

Difficulty. Light.

Renaming-test note. Pass, with the explicit caveat that “primitive prices” may only mean the fixed profiles w
j
	​

 and tests v∈V
0
	​

, or Farkas dual multipliers later. They cannot be hidden posterior-support functions.

Step 2: Critical Lemma (the trapdoor)

Lemma 2.1 (collapse lemma).

Candidate statement. Suppose LP(P,V
0
	​

,ε) is infeasible for some finite Borel partition P, finite V
0
	​

⊂W, and ε>0. Let a Farkas alternative be taken for the exact finite system of Lemma 1.1, with dual multipliers attached only to row-mass constraints, edge exclusions, nonnegativity, and raw cone tests

i
∑
	​

x
ij
	​

s
ˉ
i
	​

⋅(v−w
j
	​

)≤0.

Then there exists a finite union of source cells

E=
i∈I
⋃
	​

A
i
	​


such that τ(E)>0,

D
E
	​

=
w
∗
(M∖E)
	​

⊊C
∗

is a proper compact deletion, and

F(D
E
	​

)≥F(C
∗
).

Equivalently, finite infeasibility implies D
E
	​

∈Del(w
∗
,τ) with non-worse menu value, contradicting (H
del
	​

).

Dependencies. Lemma 1.1; finite Farkas lemma; definition of F; deletion hypothesis (H
del
	​

); the closure-pruning convention C
∗
=
w
∗
(M)
	​

 or an explicitly stated replacement.

Technique hint. Convert the dual deficiency into a source-indexed deletion certificate: identify the source cells carrying the negative capacity imbalance, delete those cells, show the remaining label image is genuinely smaller, and compare F(D
E
	​

) to F(C
∗
) using only rowwise payoff minima and aligned maxima.

Difficulty. Heavy. This is the hinge with a steel door and a tiny keyhole.

Renaming-test note. This lemma passes only if the dual certificate is collapsed into a deletion statement in the language of F,w
∗
,τ,α. If the proof says “the deficient message cells violate Bayes calibration” and then uses B(m), h
B(m)
	​

, or posterior membership to choose E, the lemma has failed. If it needs behavioral minimality, canonical menus, or (H
C1
	​

), that must be flagged as a new hypothesis, not smuggled into (H
del
	​

).

Justification why this is the trapdoor.

Lemma 2.1 is the only step that turns a finite Hall/Farkas obstruction into a primitive contradiction. The finite LP is messagewise: its hard constraints say incoming mass at a message-cell must satisfy raw Bayes-optimality inequalities. The deletion hypothesis is sourcewise: it only prohibits deleting positive-τ source patches while preserving or improving F. The collapse lemma must build a bridge between these two coordinate systems without naming the forbidden bridge itself. This is exactly the deletion-compatible Hall duality bottleneck identified in the project closure memo: messagewise calibration and sourcewise deletion do not naturally price the same object, and the Borel-to-compact gap can make E positive without making D
E
	​

 proper. 

project_closure_memo

Step 3: Limit

Lemma 3.1 (tightness/compactness).

Candidate statement. Assume Lemma 2.1 and (H
del
	​

), so LP(P,V
0
	​

,ε) is feasible for every finite datum. For each feasible solution r
P,V
0
	​

,ε
, define

γ
P,V
0
	​

,ε
	​

:=α(id,id)
#
	​

τ+
i,j
∑
	​

r
ij
	​

ν
i
	​

⊗δ
m
j
	​

	​

,ν
i
	​

:=τ∣
A
i
	​

	​

/τ
i
	​

.

Then γ
P,V
0
	​

,ε
	​

 is a probability measure on M×M, its first marginal is τ, and

γ
P,V
0
	​

,ε
	​

≥α(id,id)
#
	​

τ.

Along any refining sequence P
n
	​

↑B(M), V
0
(n)
	​

↑W dense, and ε
n
	​

↓0, the family admits weakly convergent subsequences.

Dependencies. Lemma 1.1; compactness of M×M; Prokhorov.

Technique hint. Treat M⊂Δ(Ω) as compact and use weak compactness of probability laws on a compact metric space.

Difficulty. Medium.

Renaming-test note. Pass. This lemma constructs joint laws from primitive mass arrays only. No posterior or Bayes cone is imposed.

Lemma 3.2 (limit kernel).

Candidate statement. Let γ
n
	​

⇒γ
∗
 be a limit from Lemma 3.1. Set

ν
∗
:=γ
∗
−α(id,id)
#
	​

τ.

If α<1, disintegrate ν
∗
/(1−α) over its first coordinate to obtain an adversarial kernel κ(dm∣s). Disintegrate γ
∗
 over its second coordinate to obtain source-conditionals ρ
m
	​

(ds), with second marginal q=(γ
∗
)
2
	​

. Then:

κ({m:s⋅w
∗
(m)=
m
′
∈M
inf
	​

s⋅w
∗
(m
′
)}∣s)=1τ-a.e.,

and for q-a.e. m,

∫s⋅(v−w
∗
(m))ρ
m
	​

(ds)≤0for every v∈W.

Consequently, the realized continuation w
∗
(m) is Bayes-optimal for the barycenter of ρ
m
	​

, q-a.e.

Dependencies. Lemma 3.1; disintegration on standard Borel spaces; density of ⋃
n
	​

V
0
(n)
	​

; a label-stability mechanism ensuring w
j
	​

→w
∗
(m) along refining cells.

Technique hint. Use closed-support passage for the minimizer graph and diagonal extraction over the countable dense test family.

Difficulty. Heavy. The disintegrations are standard; passing the raw cell tests to the exact w
∗
(m) inequality is the load-bearing engineering.

Renaming-test note. Mostly pass, but with one surfaced ambiguity: the prompt’s phrase “disintegrate over the second coordinate to get κ” reverses the two kernels. First-coordinate disintegration gives the adversary kernel; second-coordinate disintegration gives received-message posteriors. The lemma may mention posterior only as a derived object after the raw inequalities pass to the limit.

Lemma 3.3 (limit renaming check).

Candidate statement. The limit step is admissible iff the final q-a.e. Bayes-optimality conclusion is derived from

∫s⋅(v−w
∗
(m))ρ
m
	​

(ds)≤0(v∈W),

and not inserted as an assumption. Any step that assumes P
γ
∗
	​

(⋅∣m)∈B(m), invokes menu-Hall, or uses h
B(m)
	​

 before deriving the displayed inequalities fails Route 1.

Dependencies. Lemma 3.2.

Technique hint. Final syntactic audit plus finite-dimensional separation only after all raw inequalities are in hand.

Difficulty. Light to medium.

Renaming-test note. This is the guardrail lemma. It prevents the limit passage from quietly becoming v8 Tier 2 plus menu-Hall, whose calibration condition was explicitly an added hypothesis. 

theorem_2_extension_proof_v8

Step 4: Numbered Action List for Prover

Attack Lemma 2.1 first. Prove or disprove the collapse lemma from a finite Farkas deficiency to a proper deletion D
E
	​

∈Del(w
∗
,τ) with F(D
E
	​

)≥F(C
∗
).

If Lemma 2.1 holds, prove Lemma 1.1 and Lemma 1.2 exactly, especially the residual-mass rewrite and the primitive cone test.

Prove Lemma 3.1, Lemma 3.2, and Lemma 3.3, with special attention to label-stability and the corrected two-disintegration structure.

Step 5: Test Cases

Finite M. The LP is genuinely finite-dimensional and Farkas applies directly. Lemma 2.1 should become a finite deletion argument. The sharp stress test is duplicate labels: deleting positive source mass must actually shrink 
w
∗
(M∖E)
	​

, not merely delete names of messages.

Binary state ∣Ω∣=2. The paper’s quantile transport in Appendix A.6 is the candidate verifier. The finite LP should reproduce interval endpoint balance: incoming mass to each endpoint satisfies the raw inequalities p(v−w
ℓ
	​

)≤0, and Farkas failure should collapse to deleting one side of the interval. 

theorem_2_extension_proof_v8

Spherical/radial ∣Ω∣≥3. The paper’s spherical construction sends misaligned beliefs to antipodal boundary points, with the radius determined by a one-dimensional balancing equation. R6 should reduce finite feasibility to radial shell transport, so the collapse lemma should be inactive or symmetry-trivial. 

Robust_trust_Dworczak_Smolin

v8 ternary witness. Under the incorrect strong reading that the halfspace T={μ:μ(0)≤0.4} is behaviorally minimal, the LP should detect infeasibility. The key internal-consistency test is whether Lemma 2.1 then produces a legitimate primitive deletion. It should not produce a bogus deletion from representational scenery: v8 classifies that halfspace witness as a menu-engine artefact, not a primitive counterexample. 

theorem_2_extension_proof_v8

Step 6: Global Renaming Note

Every lemma must be statable in the primitive vocabulary

F, w
∗
, τ, α, Borel source patches, compact deletions, s⋅v comparisons for v∈W.

The permitted finite tests are raw inequalities comparing w
∗
(m
j
	​

) to v∈V
0
	​

. The forbidden names are G(s) as a constraint, B(m), h
B(m)
	​

, posterior membership, and any disintegration used as an input rather than an output. If a natural statement needs one of those names, the right response is not patchwork. It is a red flag that R6 has rediscovered menu-Hall under a mask.

Honest Assessment

R6 is a real route, but only because Lemma 2.1 is allowed to fail. The finite LP and compactness pieces are plausible scaffolding; the collapse lemma is the dragon under the floorboards. It must solve exactly the deletion-compatible Hall duality problem that previous passes isolated: convert a messagewise calibration obstruction into a sourcewise compact deletion, while also closing the Borel-to-compact gap. The closure memo explicitly marks that as the central unresolved bottleneck, and v8 shows that menu-Hall cannot simply be assumed away inside the menu engine. If Lemma 2.1 fails on duplicate-label finite cases or on the v8 ternary internal-consistency check, Route 1 should stop at Lemma 2.1 rather than import (H
C1
	​

), behavioral minimality, or menu-Hall under renamed ink.
