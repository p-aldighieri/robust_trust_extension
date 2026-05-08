# Breakdown — Strategy 3: canonical/minimal menu route

You are the **Breakdown** role in the soft-scaffolding workflow. Your job is to decompose Strategy 3 (the canonical/minimal menu route) into a numbered sequence of concrete sub-questions and lemma candidates that a prover can attack one at a time. The breakdown must include explicit guardrails: a clear test for whether any candidate "primitive condition" actually bypasses menu-Hall or merely renames it.

## State of play

- **v8** is the current proof state (durable source). Tier 1a unconditional (existence + ε-adversaries). Tier 1b under (exact-contact). Tier 2 under (exact-contact) + (menu-Hall).
- **menu-Hall** is the calibration condition: ∃ kernel κ supported on rowwise minimizers $G(s)$ such that the disintegration posterior $P_{\gamma_\alpha}(\cdot\mid m)\in B(m)$ q-a.e.
- The gatekeeper's two-pass evaluation classified menu-Hall as **scope-changing**: weaker than deterministic TRE-gen-Hall, but still installs the equilibrium calibration that Definition 2 demands.
- v8's sharpness package (cone intersection lemma + no-free-dust theorem) shows menu-Hall is genuinely needed inside the menu engine. Classification (b) shows the witness is a menu-engine artefact, not a primitive counterexample.
- The gatekeeper's preferred non-narrowed route: **find a primitive, behaviorally minimal payoff-profile menu (not merely an $F$-optimal menu in $\mathcal K(W)$) and ask whether calibration follows from canonicality.**
- The gatekeeper's explicit risk warning: *"if the proof ever says 'choose κ satisfying posterior calibration,' it has looped back into the cave."*

## Your task

Produce a breakdown with the following structure. Be concrete. Every lemma candidate must have a precise statement, not a hand-wave.

### Step 1. Define candidate canonicality conditions

Propose 2–4 distinct candidate definitions of "canonical/minimal payoff-profile menu" that could plausibly imply calibration. Examples (you may use these or propose better ones):

- **(C1) Behavioral minimality:** $C^*$ is minimal among $F$-optimal menus, in the sense that no proper compact subset of $C^*$ is $F$-optimal.
- **(C2) Extreme-point canonicality:** $C^* = \overline{\mathrm{conv}}(\{w^*(m) : m\in M\})$ and the labeling $w^*$ is extreme-point-valued.
- **(C3) Trust-region induced:** $C^*$ arises as the image of the agent's primitive Bayes-action correspondence applied to a trust region $T$ that is minimal among Theorem-1-equivalent trust regions.
- **(C4) Algebraic / symmetry canonicality:** $C^*$ is invariant under any model symmetry (e.g., a transitive group action on $\Omega$ that preserves $u$, $\tau$).

For each candidate, state precisely what "canonical" means as a property of $C^*$ (or of the labeling $w^*$, or of the underlying primitives).

### Step 2. The renaming test

For each canonicality candidate from Step 1, decide whether a positive theorem of the form

> *Canonicality (Cn) implies menu-Hall*

would **bypass** or **rename** the calibration condition. The renaming test is:

- **Bypass** if (Cn) is checkable from primitives without reference to:
  - existence of a kernel κ supported on rowwise minimizers,
  - any disintegration posterior membership condition,
  - any direct Bayes-cone inclusion at messages.
- **Rename** if (Cn) implicitly involves the existence of any of the above.

This is the gatekeeper's hard test. State explicitly for each (Cn) whether it passes the bypass test, and if it does, what verifiable primitive condition it commits to.

### Step 3. Decompose into lemma candidates

For each canonicality candidate that passes the renaming test, propose a sequence of concrete lemmas a prover can attack. Each lemma needs:

- A precise statement.
- Stated dependencies on earlier lemmas.
- A technique hint (e.g., extreme-point analysis, Choquet, group orbits, primal-dual feasibility).
- A difficulty estimate (light / medium / heavy).

For each canonicality candidate that fails the renaming test, mark it dead and explain why succinctly.

### Step 4. Identify the critical lemma

Among all surviving lemma candidates, identify the **single critical lemma** — the one whose proof or disproof determines whether Strategy 3 is alive or dead. Justify the choice in one paragraph.

### Step 5. Test cases

For each surviving canonicality candidate, name a concrete test case where the candidate's prediction can be checked:

- Binary state $|\Om| = 2$: the paper's Appendix A.6 quantile transport. Does (Cn) hold? Does it imply menu-Hall?
- Spherical / radial: the paper's §5.2 + Appendix A.10. Does (Cn) hold? Does it imply menu-Hall?
- Ternary winner-takes-all (the v8 witness): does (Cn) FAIL here, consistent with menu-Hall failing? Or does (Cn) hold and we'd need to revisit?

A good canonicality candidate should pass on the binary and spherical positive cases and fail on the ternary witness, lining up with the calibration story.

## What you MUST do

- Be precise. No "morally similar" handwaves.
- Apply the renaming test honestly. If a candidate is just menu-Hall in a costume, say so.
- Keep the breakdown under 2000 words. Density over bulk.
- Output a numbered list of lemmas at the end so the orchestrator can route the next prover pass to one of them.

## What you MUST NOT do

- Do not propose proofs. That is the prover's job.
- Do not claim a candidate is bypass without explicit primitives.
- Do not silently extend the project's hypotheses; if your decomposition needs one, surface it as an ambiguity.

## Output Format

```markdown
## Strategy 3 Breakdown

### Step 1. Canonicality Candidates
- (C1) ...
- (C2) ...
- (C3) ...
- (C4) ...

### Step 2. Renaming Test
- (C1): bypass / rename — justification
- (C2): ...
- ...

### Step 3. Lemma Candidates
For each surviving candidate:
- Lemma A.1 (statement, dependencies, technique, difficulty)
- Lemma A.2 ...
- Lemma B.1 ...

### Step 4. Critical Lemma
The single critical lemma is [number]. Justification: ...

### Step 5. Test Cases
- Binary: ...
- Spherical: ...
- Ternary witness: ...

### Numbered Action List for Prover
1. (Critical lemma to attack first.)
2. (Next.)
3. ...

### Honest Assessment
(One paragraph: is Strategy 3 a real route, or is it likely to dead-end at a renaming? If the latter, recommend stopping with v8.)
```

Length: 1200–1800 words.
