# Breakdown — Phase C: payoff-profile compact-menu engine

You are the Breakdown role. Goal: design the proof architecture for
extending Theorem 2 of \emph{Robust Trust} to infinite $M$, $\Theta$
using the **payoff-profile compact-menu engine** as the upper-saddle
device, instead of the deterministic TRE-gen-Hall route from the
previous attempt.

## Context (do not re-derive)

- The previous pipeline produced a two-tier conditional theorem
  (`theorem_2_extension_proof_v5.md`) under three added hypotheses
  (A5-thick, A8c-attain, TRE-gen-Hall) — but TRE-gen-Hall is
  structurally tight (ternary non-radial Hall-violation witness),
  meaning the deterministic worst-message selector cannot in general
  calibrate posteriors to the agent's Bayes cone. The strategic note
  from Extended Pro identifies the deterministic $m^*$ as the engine
  failure: in finite Sion the saddle adversary mixes among row
  minimizers; an infinite proof should mimic that, not freeze
  prematurely.

- The pivot: use the paper's own \textbf{payoff-profile set}
  $W := \{w\in\R^{|\Omega|} : \exists\,\hat\sigma,\ w(\omega) = \E_{\hat\sigma}[u(a,\omega,\theta)\mid\omega]\}$
  (Theorem 1 / Section 3.2 of the paper). $W$ is compact convex in
  $\R^N$. An agent strategy is equivalent to a measurable assignment
  of message $m\in M$ to a profile $w(m)\in W$. Equivalently the agent
  picks a \emph{menu} $C\subseteq W$ (the image of the assignment),
  and the message-routing problem becomes the labeling problem of
  matching $m$'s to profiles in $C$.

## What you must produce

A clean breakdown packet that does the following.

### 1. Formal model in the menu language

Define precisely:
- The agent's choice variable: a compact subset $C\subseteq W$
  (equivalently, a measurable map $w:M\to W$ inducing $C = \overline{w(M)}$
  or $C = $ ess image; pick the cleaner).
- The aligned-truthful payoff at posterior $s$: $\max_{w\in C}\,s\cdot w$
  (agent picks the best profile for the truthful posterior).
- The misaligned worst case: $\inf_{\beta\in B}\E_{\beta,(C)}[u]$ —
  derive this in menu language. The candidate is
  $\min_{w\in C}\,s\cdot w$ if the agent must commit \emph{before}
  knowing the message and the adversary picks the worst message
  pointing to a worst-profile; but when the agent's strategy is
  message-conditional, the adversary picks the worst $w\in C$ pointwise
  in $s$ via the message channel. Spell this out — the rigorous
  derivation matters.
- The objective:
  $$
  F(C) \;=\; \int_M\!\!\big[\alpha\,\max_{w\in C}\,s\cdot w \;+\; (1-\alpha)\,\min_{w\in C}\,s\cdot w\big]\,\tau(ds).
  $$
- The optimal value $V^* := \sup_{C\subseteq W,\ C \text{ compact nonempty}} F(C)$.

### 2. Existence of an optimal menu

State and sketch the existence theorem:

**Lemma (menu existence).** $V^*$ is attained — there exists compact
$C^*\subseteq W$ with $F(C^*) = V^*$.

The space of nonempty compact subsets of $W$ is compact metrizable
under the Hausdorff metric (since $W$ is compact in $\R^N$). The
functions $C\mapsto\max_{w\in C} s\cdot w$ and $C\mapsto\min_{w\in C} s\cdot w$
are upper / lower semicontinuous in Hausdorff topology respectively,
hence by integration $C\mapsto F(C)$ is upper semicontinuous (the
$\max$ part is u.s.c., the $\min$ part is l.s.c.; weighted sum needs
care). Use a standard Berge-style argument or the Hausdorff–Lipschitz
representation. **Identify any continuity/regularity gap.**

Compare to the previous Branch-A architecture: this would replace
both the Balder kernel topology AND the Mertens minmax + Lusin lift,
giving a one-shot existence theorem in a finite-dimensional ambient
space.

### 3. Labeling: from optimal menu $C^*$ to a strategy $\sigma^*$

Once $C^*$ is in hand, the agent must implement it: assign each
message $m\in M$ a profile $w^*(m)\in C^*$. State and sketch:

**Lemma (measurable labeling).** There exists a Borel-measurable
$w^*: M\to C^*$ such that for $\tau$-a.e. $m$, $w^*(m)\in\arg\max_{w\in C^*}\,m\cdot w$
(if implementing the aligned-best response) or some other principled
rule consistent with $F(C^*)$.

This is a measurable selection from the argmax correspondence $m\mapsto\arg\max_{w\in C^*}\,m\cdot w$.
Use Kuratowski–Ryll-Nardzewski (Aliprantis–Border 18.13) since the
correspondence has compact convex values (faces of $C^*$) and is
weakly measurable.

**This is where A8c-attain becomes automatic:** rowwise argmin in the
finite-dimensional menu picture is a measurable maximum theorem
question — compact $C^*$ in $\R^N$, continuous linear functional
$w\mapsto m\cdot w$, automatic attainment + selector.

### 4. Calibration: the upper saddle via the menu

The substantive step. Given $\sigma^*$ implementing $C^*$, define
$\beta^*$ as the worst-message-coupling, and verify per-message
Bayes-optimality of $\sigma^*$ at the induced posteriors.

The strategic claim: in the menu picture, the upper saddle is
automatic at the optimal $C^*$ because the structure of $C^*$
(specifically, that it's the image of an optimal labeling) forces
the labeling-induced posterior calibration. Spell this out.

If the upper saddle is NOT automatic in the menu picture, identify
the additional structural condition needed and compare to TRE-gen-Hall.

### 5. Explicit relation to A5-thick, A8c-attain, TRE-gen-Hall

For each of the three previously added hypotheses, state whether the
menu engine:
- (a) makes it automatic / unnecessary;
- (b) replaces it with a milder condition;
- (c) needs the same hypothesis still.

This is the deliverable that justifies the engine pivot.

### 6. Risks and aborts

Honest evaluation:
- Is $F$ really upper semicontinuous in Hausdorff topology, or does
  the $\min_{w\in C}\,s\cdot w$ term make it merely measurable?
- Does measurable labeling really exist when $C^*$ is, say, a compact
  curve with no natural parameterization?
- Does the calibration argument really go through, or is the
  Hall-feasibility obstruction lurking inside the labeling problem in
  disguise?

If the engine has structural obstructions, identify them precisely so
we know whether to pivot to set-valued calibrated transport (Plan B)
or accept a different intermediate result.

## Output Format

```markdown
## 1. Menu formulation
(Precise definitions; the agent's choice variable; F(C); V*.)

## 2. Existence of optimal menu
(Lemma + sketch; continuity/regularity diagnosis.)

## 3. Labeling
(Lemma + sketch; how it makes A8c automatic.)

## 4. Calibration / upper saddle
(The substantive lemma; or honest gap.)

## 5. Relation to (A5-thick), (A8c-attain), (TRE-gen-Hall)
(Per-hypothesis verdict.)

## 6. Risks and aborts
(Honest obstructions; pivot triggers.)

## 7. Recommended next prover targets
(Ordered list of focused lemmas to attack first.)
```

## Discipline

- Use paper notation; cite Theorem 1 / Section 3.2 / Appendix A.1 of
  \emph{Robust Trust} for the $W$ set definition.
- Do NOT prove anything in detail. This is a planning pass.
- Be HONEST about whether the menu engine actually delivers full
  robust rationalizability or merely shifts the problem.
- Length: 2000–3000 words.
