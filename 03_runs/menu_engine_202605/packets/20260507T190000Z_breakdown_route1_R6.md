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

```markdown
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
```

Length: 1500–2200 words.
