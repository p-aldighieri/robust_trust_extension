
========
ROLE: user (id=37f6d555-65d6-49f5-8a0a-272ad5f0e6e6)
========
# Formalizer pass — Route 1 target theorem statement

You are the **Formalizer** in the soft-scaffolding workflow. The literature pass for Route 1 returned a **BUILD** verdict and a four-pass proof sequence. Your job is **pass 1 of that sequence**: formalize the **target theorem** for Route 1 — a deletion-compatible Hall duality statement — in precise primitive terms.

This is *not* a proof. It is a precise specification of what we want to prove. Surface ambiguities. Do not silently add hypotheses.

## The shape of the target theorem

The literature pass and the gatekeeper renaming test together fix the shape:

**Target.** For a behaviorally minimal labeled compact menu $(C^*, w^*)$ in the menu engine of v8, **primitive sourcewise deletion-stability implies existence of a calibrated joint law**.

**Hypothesis (primitive).** A "no improving compact patch deletion" condition stated only in terms of $F(C)$, $w^*$, $\tau$, $\alpha$, and compact source patches. **The hypothesis must NOT mention** existence of a kernel $\kappa$ supported on rowwise minimizers $G(s)$, any disintegration posterior membership $P_\gamma(\cdot \mid m) \in B(m)$, any direct Bayes-cone inclusion at messages, or any support-function inequality involving $h_{B(m)}$. Any of those would smuggle in the conclusion (renaming failure).

**Conclusion.** Existence of a joint law $\gamma$ on $M \times M$ (equivalently a kernel $\kappa$ with $\gamma_\alpha = \alpha (\mathrm{id}, \mathrm{id})_\#\tau + (1-\alpha)\,\tau \otimes \kappa$) that simultaneously: (i) is supported on rowwise minimizers, and (ii) satisfies $P_{\gamma_\alpha}(\cdot \mid m) \in B(m)$ for $q$-a.e.\ $m$ where $q := (\gamma_\alpha)_2$. Equivalently: menu-Hall holds for $(C^*, w^*)$.

## Your task

Produce a precise candidate statement of the target theorem with explicit quantifiers, domains, and side definitions. Then audit it against the renaming test and surface every ambiguity that the candidate either resolves tacitly or genuinely needs an answer to.

### Step 1 — Candidate hypothesis (precise statement)

Propose **one** primitive deletion-stability condition as the hypothesis. The natural candidate:

> **(Sourcewise deletion-stability candidate.)** For every nonempty compact $D \subsetneq C^*$ such that there exists a Borel $E \subseteq M$ with $\overline{c(M \setminus E)} = D$ and $\tau(E) > 0$, $F(D) < F(C^*)$.

State this precisely. Specify:
- What "$D \subsetneq C^*$" means as compact subsets ($D$ proper, with positive Hausdorff distance from $C^*$? Just set-theoretic $\subsetneq$? Specify).
- Whether the inequality is strict and uniform (i.e., $F(D) \le F(C^*) - \delta$ for some $\delta > 0$) or just strict ($F(D) < F(C^*)$ for each fixed $D$).
- Whether the labeling $w^*$ is fixed in advance or chosen optimally per $D$.
- What "$\overline{c(M \setminus E)} = D$" forces about the relationship between $E$ and the label support of $w^*$.

Propose alternatives if the natural candidate has ambiguities you cannot resolve. For each alternative, state its quantifiers and apply the renaming test.

### Step 2 — Candidate conclusion (precise statement)

State the existence claim precisely. The natural candidate:

> **(Calibrated joint law existence.)** There exists a Borel kernel $\kappa: M \to \Delta(M)$ such that with $\gamma_\alpha := \alpha (\mathrm{id}, \mathrm{id})_\#\tau + (1-\alpha)\, \tau \otimes \kappa$ and $q := (\gamma_\alpha)_2$:
> (a) $\kappa(\cdot \mid s)$ is supported on $G(s) := \{m \in M : s \cdot w^*(m) = \min_{z \in C^\dagger} s \cdot z\}$ for $\tau$-a.e.\ $s$;
> (b) $P_{\gamma_\alpha}(\cdot \mid m) \in B(m)$ for $q$-a.e.\ $m$.

Specify:
- Whether $\kappa$ is required to be Borel only or to satisfy further regularity (closed graph, u.h.c.).
- Whether the support-function form of (b) is logically equivalent to the disintegration form, and under what minimal regularity.
- Whether the conclusion depends on $\alpha > 0$ or holds for $\alpha \in [0, 1]$.

### Step 3 — Renaming-test audit

Review your candidate hypothesis (Step 1) and audit it against the renaming test:

- Does the hypothesis mention $G(s)$, $\kappa$, $\gamma$, $P_\gamma$, $B(m)$, $h_{B(m)}$, or any analog?
- If yes: rewrite to remove. If unavoidable: surface as a fundamental ambiguity.
- If no: state explicitly that the hypothesis is checkable using only $F$, $w^*$, $\tau$, $\alpha$, and compact source patches.

### Step 4 — Ambiguities you must surface

Even with the natural candidate, several questions remain. Address each:

1. **What exactly is "behaviorally minimal"?** $C^* = \overline{w^*(M)}$ in the closure-pruning sense from v8 §4 Lemma 3? Or the breakdown's stronger (C1) condition that no proper compact $D \subsetneq C^*$ is $F$-optimal? Or both?
2. **What labeling $w^*$ is the theorem about?** A fixed Borel optimal aligned-best labeling? Any optimal aligned-best labeling? An equivalence class modulo τ-null differences?
3. **Is exact-contact assumed?** The literature pass said the theorem operates "for a behaviorally minimal labeled compact menu $(C^*, w^*)$ in the menu engine of v8" — which has Tier 1a (no exact-contact) and Tier 1b (with exact-contact). Determine which is the right ambient setting.
4. **What measurability of $\kappa$ in the conclusion?** Borel-measurable suffices? Or universally measurable?
5. **What is "compact source patch"?** A compact subset of $M$? Of $\Delta(\Om)$? A compact subset whose τ-mass is positive?
6. **The Borel-to-compact gap.** The hypothesis writes "there exists Borel $E$ with $\overline{c(M \setminus E)} = D$". This is a forward implication: from a candidate $D$, find $E$. Is the right form "for every $D$ that is the closure of some Borel deletion image" or "for every $D \subsetneq C^*$ that is achievable by Borel deletion of a τ-positive set"? These differ.

### Step 5 — Output the candidate target

Produce the candidate statement in clean form, with all quantifiers, side definitions, and the explicit hypothesis/conclusion split.

## What you MUST do

- Be precise. State the theorem, not a description.
- Surface every ambiguity. Do not resolve them silently.
- Apply the renaming test rigorously to every formulation you propose.

## What you MUST NOT do

- Do not propose a proof. That is the prover's job.
- Do not fold in the dual-separation step. That is the searcher/breakdown's job.
- Do not silently add regularity. If the candidate as stated has gaps, name them.

## Output Format


markdown
## Plain-Language Reading

(One paragraph: what the theorem says, in plain English.)

## Formal Candidate Statement

**Setting:** ...
**Side definitions:** ...

**Theorem (deletion-compatible Hall duality, candidate).**
Under (...), if [hypothesis], then [conclusion].

## Hypothesis (Step 1)

(Precise statement, with quantifiers and domain.)

## Conclusion (Step 2)

(Precise statement, with quantifiers and domain.)

## Renaming Test Audit (Step 3)

- Mentions of forbidden objects: yes / no, with line references if any.
- If any: rewrite or surface as ambiguity.

## Surfaced Ambiguities (Step 4)

(Numbered list. For each: the question, why it matters, and the alternative readings the prover would have to pick between.)

## Equivalent Reformulations (Optional)

(Any reformulation that may make the theorem easier to state or attack.)

## What This Theorem Would Buy Us

(One paragraph: if this theorem is proved, what changes about v8? Does Tier 2 become unconditional? Does it just sharpen menu-Hall? Does it apply only under exact-contact, or also without?)


Length: 1500–2000 words.

## Reference

v8 (durable source) has the operational definitions of $W$, $C^\dagger$, $G(s)$, $B(m)$, $\gamma_\alpha$, $q$, menu-Hall (kernel form and support-function form), exact-contact, the cone intersection lemma, the no-free-dust theorem, and classification (b). The literature pass response is in logs/20260507T160000Z_literature_route1_deletion_duality_response.md (the four-pass sketch is in the "Verdict on Route 1" section).

Show more

========
ROLE: assistant (id=6bffd159-164a-4e47-bf7c-52aad8a87f3f)
========
Plain-Language Reading

The candidate theorem says: start with an optimal compact payoff-profile menu and a fixed aligned-best labeling of source beliefs by menu points. Suppose the menu is not merely carrying decorative labels: whenever deleting a positive-mass set of source beliefs genuinely shrinks the closed label image, the resulting compact menu has strictly lower menu value. Then this primitive sourcewise “no harmless deletion” condition should force the existence of an adversarial source-to-message flow that both chooses only rowwise worst labels and makes the agent’s continuation label Bayes-optimal at almost every received message. In v8 language, it would replace the extra menu-Hall hypothesis by a deletion-stability hypothesis that does not already name the desired calibration object. The menu-engine objects and the q-a.e. reading are as in v8. 

theorem_2_extension_proof_v8

Formal Candidate Statement

Setting: Let Ω be finite and let Δ:=Δ(Ω). Let M=suppτ⊆Δ, with τ a Borel probability. Let W⊂R
Ω
 be the compact convex payoff-profile set from the menu engine. Fix α∈(0,1). For every nonempty compact C⊆W, define

F(C):=∫
M
	​

[α
z∈C
max
	​

s⋅z+(1−α)
z∈C
min
	​

s⋅z]τ(ds).

A labeled compact menu is a pair (C
∗
,w
∗
) with C
∗
∈K(W) and w
∗
:M→C
∗
 Borel. For the candidate theorem, take (C
∗
,w
∗
) to satisfy:

F(C
∗
)=
C∈K(W)
sup
	​

F(C),
w
∗
(s)∈arg
z∈C
∗
max
	​

s⋅zfor τ-a.e. s,

and, under the light closure-pruning reading of behavioral minimality,

C
∗
=
w
∗
(M)
	​

.

Side definitions: For m∈M, define the Bayes cone of the label

B(m):={p∈Δ:p⋅w
∗
(m)=
v∈W
max
	​

p⋅v}.

For s∈M, define the rowwise minimizer message set

G(s):={m∈M:s⋅w
∗
(m)=
z∈C
∗
min
	​

s⋅z}.

Because w
∗
 is Borel and C
∗
,W are compact, the graphs of G and B are at least Borel under the displayed definitions, modulo the usual completion convention.

Theorem (deletion-compatible Hall duality, candidate).
Under the setting above, if (C
∗
,w
∗
) satisfies sourcewise deletion-stability (H
del
	​

), then there exists a Borel stochastic kernel κ:M→Δ(M) such that, with

γ
α
	​

:=α(id,id)
#
	​

τ+(1−α)τ⊗κ,q:=(γ
α
	​

)
2
	​

,

we have:

κ(G(s)∣s)=1 for τ-a.e. s;

for some, equivalently any, regular conditional distribution ρ
m
	​

(ds) of the first coordinate of γ
α
	​

 given the second coordinate m, the barycentric posterior

P
γ
α
	​

	​

(⋅∣m):=∫
M
	​

sρ
m
	​

(ds)∈Δ

satisfies

P
γ
α
	​

	​

(⋅∣m)∈B(m)for q-a.e. m.

Equivalently, menu-Hall holds for the labeled menu (C
∗
,w
∗
), but menu-Hall is only in the conclusion, not in the hypothesis.

Hypothesis (Step 1)

Define the deletion image of a Borel source deletion E⊆M by

D
E
	​

:=
w
∗
(M∖E)
	​

⊆C
∗
.

The candidate primitive hypothesis is:

(H
del
	​

)∀E∈B(M),(τ(E)>0,D
E
	​


=∅,D
E
	​

⊊C
∗
)⇒F(D
E
	​

)<F(C
∗
).

Equivalently:

∀D∈K(W),(D

=∅,D⊊C
∗
,∃E∈B(M):τ(E)>0,D=
w
∗
(M∖E)
	​

)⇒F(D)<F(C
∗
).

Here D⊊C
∗
 means set-theoretic proper compact inclusion. Since D is compact and C
∗
 is compact, this is equivalent to d
H
	​

(C
∗
,D)>0; no separate Hausdorff-gap assumption is being added.

The inequality is strict pointwise in D. It is not uniform: the statement does not require a single δ>0 such that all tested D satisfy F(D)≤F(C
∗
)−δ.

The labeling w
∗
 is fixed in advance. It is not reselected when testing a deletion. The functional F(D), however, is the menu functional on D, so the max and min over D are automatically recomputed by F.

The equation 
w
∗
(M∖E)
	​

=D says that every retained label is approximable by labels of undeleted sources, and every label outside D is lost after deleting E. It does not force E=w
∗−1
(C
∗
∖D). One may delete sources whose labels lie in D, provided enough undeleted sources remain to keep the same closure.

Two nearby alternatives, both renaming-safe:

(H
compact E
	​

)∀ compact E⊆M,τ(E)>0,D
E
	​


=∅,D
E
	​

⊊C
∗
⇒F(D
E
	​

)<F(C
∗
).

This is more literal about “compact source patch,” but weaker than the Borel version and not obviously equivalent.

(H
C1
	​

)∀D∈K(W),D

=∅,D⊊C
∗
⇒F(D)<F(C
∗
).

This is stronger than sourcewise deletion-stability. It ignores whether D is achievable by deleting positive source mass. It passes the renaming test but may be too strong for Route 1.

Conclusion (Step 2)

The desired object is a Borel kernel κ, with no closed-graph, u.h.c., or continuity requirement. Borel measurability is the clean target because the v8 strategy spaces use Borel kernels. If a proof only produces a universally measurable κ, that would be a weaker completed-measure version and should not be silently identified with this theorem.

The support condition is:

κ(G(s)∣s)=1τ-a.e.

This says the misaligned adviser only sends messages whose fixed label w
∗
(m) is rowwise minimizing for source s.

The calibration condition is:

P
γ
α
	​

	​

(⋅∣m)∈B(m)q-a.e.

This is the q-a.e. robust-rationalizability reading identified in v8 and is the relevant infinite-message version of Definition 2. The original paper’s finite theorem uses literal “for all m∈M” because finite M and α>0 put every message on path. 

Robust_trust_Dworczak_Smolin

The support-function version is equivalent under standard Borel disintegration, closed convex nonempty B(m) on the relevant q-support, and measurable graph:

α∫
E
	​

ϕ(s)τ(ds)+(1−α)∫
M
	​

ϕ(s)κ(E∣s)τ(ds)≤∫
E
	​

h
B(m)
	​

(ϕ)q(dm)

for every Borel E⊆M and every continuous affine ϕ:Δ→R. The converse uses finite-dimensional separation of P
γ
α
	​

	​

(⋅∣m) from the closed convex set B(m). If B(m)=∅ on positive q-mass, the support-function form must be declared invalid or interpreted with h
∅
	​

=−∞, which immediately forbids such mass.

The candidate is stated for α∈(0,1). The endpoints require separate conventions: at α=1, κ is payoff-irrelevant but the posterior condition reduces to m∈B(m) q-a.e.; at α=0, the aligned diagonal vanishes and the meaning of sourcewise deletion as a trust-calibration test changes.

Renaming Test Audit (Step 3)

Mentions of forbidden objects in (H
del
	​

): no.

The hypothesis does not mention G(s), κ, γ, P
γ
	​

, B(m), h
B(m)
	​

, Bayes cones, disintegration, posterior membership, or any support-function inequality.

It is checkable using only F, the fixed labeling w
∗
, τ, α as embedded in F, and Borel source deletions whose retained label closure is compact.

The two alternatives (H
compact E
	​

) and (H
C1
	​

) also pass the renaming test. The second may fail the intended “sourcewise” spirit because it tests compact submenus that need not arise from source deletion.

Surfaced Ambiguities (Step 4)

Meaning of “behaviorally minimal.”
Light reading: C
∗
=
w
∗
(M)
	​

, the closure-pruning condition from v8. Strong reading: no nonempty proper compact D⊊C
∗
 is F-optimal. Combined reading: both. This matters because the candidate theorem uses only the light reading plus (H
del
	​

); the strong reading would partially subsume deletion-stability.

Which labeling w
∗
.
The theorem must be about a fixed Borel aligned-best labeling. If one may change w
∗
 after each deletion, the hypothesis becomes a different global minimality statement. If labels are only defined up to τ-null sets, deletion images can change on null sets but q-positive adversarial dust may later care about them, so the representative must be fixed.

Exact-contact.
The candidate does not assume exact-contact. It asks deletion-stability to imply the existence of a kernel supported on G(s), hence to imply exact contact as part of the conclusion. If Route 1 is meant to operate only in Tier 1b, exact-contact should be added to the setting, and the theorem becomes a calibration theorem rather than a joint existence theorem.

Measurability of κ.
Borel is the clean target. Universally measurable would probably suffice for completed integrals but would not match the literal menu-Hall statement.

“Compact source patch.”
In the main candidate, compactness belongs to the retained image D
E
	​

, not to the deleted source set E. If “compact source patch” means compact E⊆M, use (H
compact E
	​

). These are not obviously equivalent.

Borel-to-compact gap.
The right formal object is “every D achievable as D
E
	​

 from some positive-mass Borel deletion.” Deleting positive mass may leave 
w
∗
(M∖E)
	​

=C
∗
, so no compact shrink occurs and the hypothesis is silent. This is exactly the gap named in the closure memo as part of the missing deletion-compatible Hall theorem. 

project_closure_memo

Equivalent Reformulations (Optional)

A concise formulation is:

Del(w
∗
,τ):={
w
∗
(M∖E)
	​

:E∈B(M), τ(E)>0}.

Then

(H
del
	​

)∀D∈Del(w
∗
,τ),D

=∅, D⊊C
∗
⇒F(D)<F(C
∗
).

This is the least cluttered version and keeps the sourcewise nature visible.

What This Theorem Would Buy Us

If proved, this theorem would replace v8’s Tier 2 menu-Hall assumption, but only for behaviorally minimal labeled menus satisfying the primitive deletion-stability test. It would not change Tier 1a, which is already unconditional in v8. Depending on the exact-contact ambiguity, it would either make exact-contact plus Tier 2 calibration automatic for stable minimal menus, or, in the stronger reading, make full robust rationalizability automatic for those menus without separately assuming exact-contact. It would not prove unrestricted infinite Theorem 2 unless every relevant primitive optimal menu can be shown to admit such a behaviorally minimal deletion-stable representative.
