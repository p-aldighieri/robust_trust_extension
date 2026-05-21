# Formalizer pass 01 — Piotr's Pareto-frontier-set reformulation of Theorem 2

## Role

You are the Formalizer for a smart-scaffolding proof project. Your job is to
make the **reformulated game \(\mathcal G_P\)** precise enough that downstream
roles (literature, searcher, prover, reviewer) can attack existence cleanly.

This is the **third pass** at extending Theorem 2 of Dworczak–Smolin (2026,
*Robust Trust*, arXiv:2602.09490) beyond finite \(M\) and \(\Theta\). Pass 1
(Sion + Tychonoff + KRN) and Pass 2 (Phil-Reny restricted-game + Lusin-lift /
v7–v8 menu engine) both stalled. The closure verdict from Pass 2 is in
`project_closure_memo.md` (durable source). The diagnosis: the locked gate is
a **deletion-compatible Hall duality** theorem connecting sourcewise
deletion certificates with messagewise Bayes-calibration constraints.

Piotr now proposes a **structurally different** reformulation. Read his
verbatim statement and our independent route analysis in
`piotr_pareto_frontier_route_memo.md` (durable source). Take that memo as an
*orchestrator working hypothesis*, not as established fact — your job is to
verify or correct it.

## Constraints — read before you start

- **Do not silently re-import banned architectures** (see `prior_attempts_digest.md`
  durable source). In particular: no product-of-narrow Sion, no τ-AC restriction
  on \(\beta\), no atomic truncation lifting.
- **Do not narrow Definition 2** — full robust rationalizability is the target,
  in the \(q_{\beta^*}\)-a.e. infinite-space reading documented in v8 §2.
- **Use Lemma 2 of Theorem 1's proof verbatim** (paper p. 27): *any optimal
  \(\sigma^*\) is equivalent to one using Bayes-optimal private strategies for
  all \(m\in\Delta(\Omega)\)*. The route memo cites it.
- **Stay precise about quantifiers.** In particular distinguish "every \(s\in M\)",
  "\(\tau\)-a.e. \(s\)", and "\(q\)-a.e. \(m\)".
- **Engage critically.** The route memo's §5 (Bayes-calibration question) is
  the load-bearing claim. If it is wrong, say so and propose a replacement.
  If it is right, sharpen it.

## What I want you to produce

### 1. Plain-language reading

State precisely what game \(\mathcal G_P\) is, in your own words, including:

- the agent's strategy space (subsets of the weak Pareto frontier of \(W\), with
  some topology);
- the misaligned adviser's strategy space, as a function of the agent's choice;
- the payoff \(U_P(C,\beta)\);
- the agent's optimization target \(V_P(C) := \inf_\beta U_P(C,\beta)\).

### 2. Formal statement of \(\mathcal G_P\)

Define everything precisely, with explicit quantifiers and topologies. In
particular:

- Define \(W\) and \(W^P\) and verify compactness and (if true) some weak
  structural property (path-connected? closed?).
- Define \(\mathcal K(W^P)\), the topology on it, and prove compactness
  (Blaschke or otherwise).
- Define the adversary's space \(B_P(C) := \{\beta:M\to W^P \text{ Borel},\ \beta(s)\in C\text{ for }\tau\text{-a.e. }s\}\) and the natural topology on it (Young measures? narrow?).
- State the payoff \(U_P(C,\beta)\) and \(V_P(C)\) explicitly.

### 3. The WLOG equivalence

Verify or refute the route memo's claim that
\[
U^* \;=\; \sup_{C\in\mathcal K(W^P)} V_P(C).
\]
Use Lemma 2 of Theorem 1 and v8's Lemma 1 (menu-value equivalence) as
ingredients. Be explicit about the step where \(C\subseteq W^P\) (not just
\(C\subseteq W\)).

If the equivalence holds with **strict equality**, state it. If only
\(\sup V_P \le U^*\), or only \(\ge\), say so and identify the missing step.
If you need an extra measure-theoretic regularity (e.g. closure of \(w_\sigma(M)\)),
flag it explicitly.

### 4. The Bayes-calibration question (the load-bearing one)

This is the load-bearing step. Sharpen route memo §5.

Given a saddle \((C^*,\beta^*)\) of \(\mathcal G_P\) with \(\beta^*(s)\in\arg\min_{w\in C^*}\,s\!\cdot\!w\) for τ-a.e.\ \(s\), and given the labeling \(w^*(m):=\arg\max_{w\in C^*}\,m\!\cdot\!w\):

- (a) Construct the original-game adversary kernel \(\hat\beta^*\) by KRN
  selection on the correspondence \(s \mapsto (w^*)^{-1}(\beta^*(s))\cap M\),
  setting \(\hat\beta^*(\cdot\mid s) := \delta_{m^*(s)}\). State the
  measurability hypotheses you need.
- (b) Compute the message-marginal \(q := \alpha\tau + (1-\alpha)(m^*)_\#\tau\)
  and the disintegration posterior \(P_{\hat\beta^*}(\cdot\mid m)\) on \(\Omega\).
- (c) For \(\hat\sigma^*(m) := R(w^*(m))\) to be Bayes-optimal under
  \(P_{\hat\beta^*}(\cdot\mid m)\) for \(q\)-a.e.\ \(m\), what is the **precise
  geometric condition** on \((C^*,\beta^*,\tau)\)?
- (d) Is this condition **automatically satisfied** at any saddle of
  \(\mathcal G_P\) (by some Lagrangian/dual argument), or is it an **additional
  hypothesis** like menu-Hall?
- (e) If additional: state it as cleanly as possible, in terms of the
  supporting-cone geometry of \(W^P\) at \(\beta^*(s)\) and the source-side
  posterior derived from \((s,\beta^*(s))\) via Bayes' rule. Compare it to
  v8's menu-Hall — is your condition strictly weaker, equivalent, or
  strictly stronger?

### 5. Loss of bilinearity (Piotr's Challenge 1)

\(V_P(C)\) is not bilinear in \((C,\beta)\). However the route memo argues
this is not a real obstacle for **existence** because:

- the inf over \(\beta\) for fixed \(C\) is pointwise (per \(s\)) and explicit
  (linear functional minimization over compact \(C\));
- the sup over \(C\) is attained by continuity + compactness of \(\mathcal K(W^P)\).

Verify or refute. In particular, check whether you ever need a Sion-type
sup-inf = inf-sup step, or whether the explicit pointwise inf collapses it.

### 6. Comparison with v8

For each of v8's three tiers, identify what \(\mathcal G_P\) gives you for free
and what is still open:

- Tier 1a (value optimality + ε-adversary, unconditional).
- Tier 1b (exact adversary under exact-contact).
- Tier 2 (full robust rationalizability under exact-contact + menu-Hall).

In particular: in v8, exact-contact gives \(\beta^*\) via a measurable selector
on rowwise minimizers. Does \(\mathcal G_P\) make exact-contact **automatic**
(because \(\beta^*(s)\in\arg\min_C s\!\cdot\!w\) is automatic by KRN on the
compact-valued correspondence \(s\mapsto C\))? If yes, that's a substantial
reduction in hypotheses.

### 7. Genuine novelty check

The route memo §8 claims this is genuinely new vs.\ v8. Adjudicate. If you
believe \(\mathcal G_P\) is mathematically equivalent to v8's menu engine,
say so, with proof. If you believe it is genuinely new, identify the
structural step that v8 had to assume but \(\mathcal G_P\) gets for free.

### 8. Gap register

Output a numbered gap register of everything that must still be proved or
clarified before the route can be attacked. For each gap, classify it as:

- **CRITICAL** — the route stalls without it.
- **STRUCTURAL** — needed but likely solvable by standard techniques.
- **REGULARITY** — measure-theoretic detail, technical.
- **CLARIFICATION** — definitional choice that should be locked.

Order by priority. For each gap, suggest the **type of role** that should
attack it next (literature, searcher, prover, reviewer).

## Output Contract

- Return everything inline in this chat, as plain markdown.
- Stick to the section numbering above (1–8).
- Do not try to prove the existence theorem in this pass — just formalize
  and surface gaps. Subsequent roles will prove.
- Where relevant, cite the paper's lemmas by name (Lemma 2 of Theorem 1's
  proof, v8 Lemma 1/2/3, etc.) rather than re-deriving them.
- If you find that route memo §5 is wrong (the Bayes-calibration question is
  mis-stated), say so explicitly and replace it with the correct question
  — do not silently re-route.
- End with a one-paragraph **next-step signal**: which role should run next,
  and what the most important gap is.
