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

```markdown
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
```

Length: 1500–2000 words.

## Reference

v8 (durable source) has the operational definitions of $W$, $C^\dagger$, $G(s)$, $B(m)$, $\gamma_\alpha$, $q$, menu-Hall (kernel form and support-function form), exact-contact, the cone intersection lemma, the no-free-dust theorem, and classification (b). The literature pass response is in `logs/20260507T160000Z_literature_route1_deletion_duality_response.md` (the four-pass sketch is in the "Verdict on Route 1" section).
