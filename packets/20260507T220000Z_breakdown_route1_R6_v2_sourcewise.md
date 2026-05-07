# Breakdown v2 — R6 sourcewise LP rewrite

You are the **Breakdown** role. The Lemma 2.1 prover disproved the original R6 LP construction with a clean counterexample, and the reviewer PASS'd the disproof with a precise fix recipe. The route is **not dead** — the failure is internal to the LP construction in Lemma 1.1, not to R6 as a conceptual route. Your job is to produce a **repaired breakdown** with a sourcewise LP that survives the counterexample, then re-derive the chain of lemmas (especially the new Lemma 2.1 collapse statement).

## The diagnosis (verbatim from reviewer)

The original LP attached **aligned mass to representative labels** of partition cells, but tested optimality at **cell barycenters**. Coarse mixed cells (where the representative's label differs from the barycenter's preferred label) created phantom Bayes violations unrelated to any sourcewise deletion. The repair is internal, does not require importing menu-Hall, and follows a precise recipe:

> **Repair recipe.**
> - Aligned mass charged to actual labels $w^*(s)$ source-by-source, NOT to representative labels.
> - Misaligned mass = source-level measure / kernel supported on actual rowwise minimizers.
> - Cone tests imposed on resulting column measures.

The reviewer also confirmed that quantification "over every partition" kills the original LP regardless of any other patch; the repaired LP must either work for every partition (with sourcewise mass) or restrict quantification to label-pure refining sequences.

## What you MUST produce

A new breakdown with the following structure. Each lemma needs a precise candidate statement, dependencies, technique, difficulty, and a renaming-test note.

### Step 1 — Repaired finite LP

- **Lemma 1.1' (sourcewise LP construction).** For finite Borel partition $\mathcal P = \{A_1, \ldots, A_n\}$ of $M$ and finite $V_0 \subset W$, ε > 0, propose a finite LP whose:
  - **Variables** parametrize a Borel kernel $\kappa$ from $M$ to a finite "column" set $\{1, \ldots, n\}$ (one column per cell $A_j$, with column-label $w_j := w^*(m_j)$ for some fixed $m_j \in A_j$). The variables should be finite-dimensional to make Farkas applicable; this requires aggregating sourcewise data into finitely many slabs while preserving the source-by-source aligned-mass attribution.
  - **Constraints** include:
    - Marginal: row mass = $\tau$.
    - **Sourcewise aligned attribution:** the aligned-truthful component of column $j$'s total mass is $\alpha\,\tau(\{w^*(s) = w_j\} \cap M) = \alpha\,\tau(w^{*-1}(\{w_j\}))$, NOT $\alpha\,\tau(A_j)$.
    - ε-row-minimizer support: misaligned mass routed to column $j$ may only come from sources $s$ with $s\cdot w_j \le \min_k s\cdot w_k + \eps$.
    - Primitive cone test: $\sum_i (\text{column-}j \text{ mass from cell } i) \cdot \bar s_i \cdot (v - w_j) \le 0$ for $v \in V_0$, where the column-$j$ mass from cell $i$ now correctly aggregates aligned mass from $w^{*-1}(\{w_j\}) \cap A_i$ + misaligned mass from $A_i$ on the column-$j$ edge.
  
  Difficulty: **medium-heavy.** The right LP must aggregate sourcewise without re-introducing the representative-label aliasing. The breakdown's main task is to write this carefully.

- **Lemma 1.2' (renaming test for repaired LP).** Verify the new LP names only $\tau, \alpha, w^*, V_0, \eps$, and primitive payoff comparisons. No $G(s)$, $B(m)$, $h_{B(m)}$, posterior membership, or disintegration. Light. Should be a syntactic audit.

### Step 2 — Repaired collapse lemma

- **Lemma 2.1' (sourcewise collapse).** Suppose the repaired $\mathrm{LP}'(\mathcal P, V_0, \eps)$ is infeasible. Then there exists a Borel $E \subseteq M$ with $\tau(E) > 0$ such that $D_E := \overline{w^*(M\setminus E)} \subsetneq C^*$ is a proper compact deletion AND $F(D_E) \ge F(C^*)$, contradicting $(H_\text{del})$.

  The new dual certificate must price **sourcewise deletions of label-pure source patches** (not partition cells), since aligned mass is now attributed sourcewise. State precisely how the Farkas dual translates to a Borel deletion that is guaranteed to shrink $\overline{w^*(M\setminus E)}$ properly.

  Difficulty: **heavy.** This is still the trapdoor, but with a cleaner LP it has a chance.

  **Critical question for the breakdown:** does the sourcewise repair survive the prover's counterexample? Sketch the LP on the prover's example and confirm that the repaired LP is feasible there (so the counterexample is no longer a counterexample).

  Renaming-test note: the dual certificate must remain in primitive vocabulary. If it requires "the source patch where calibration fails," that is fine; if it requires "the source patch where the posterior leaves $B(m)$," that is renaming.

### Step 3 — Limit lemmas (mostly inherited)

Restate Lemmas 3.1, 3.2, 3.3 from the original breakdown, adjusted for the sourcewise LP. Most of the limit machinery should carry over with minor index-bookkeeping changes. Identify any limit step that becomes harder because aligned mass is now source-by-source rather than cell-aggregated.

### Step 4 — New numbered action list

The orchestrator will route the next prover pass to one of these in order:
1. **Lemma 2.1'.** If false on the original counterexample, R6 is genuinely dead and project moves to Route 2.
2. **Lemma 1.1' + 1.2'** if 2.1' holds: write the LP precisely.
3. **Limit lemmas** in original order.

### Step 5 — Test cases

Re-evaluate the test cases from the original breakdown:
- **Prover's counterexample** ($\Omega = \{0,1\}, \alpha = 3/5$, finite $M$, mixed-cell partition): does the repaired LP become feasible? Show the calculation.
- **Finite $M$ with duplicate labels:** does the sourcewise repair handle them, or is duplicate-label still a hard case?
- **Binary state Appendix A.6:** continues to be the natural verifier for the limit step.
- **Spherical/radial:** same.
- **v8 ternary witness:** does the repaired LP detect the menu-engine artefact infeasibility, AND does the collapse lemma produce a deletion certificate? (Recall classification (b): the witness's halfspace is not primitive; the LP should not generate a bogus deletion from it.)

### Step 6 — Honest assessment of route survivability

If the sourcewise repair has its own structural problems beyond the prover's counterexample, surface them. Likely candidates:
- **Aggregation-to-finite-LP problem:** sourcewise aligned mass $\alpha\,\tau(w^{*-1}(\{w_j\}))$ is finite-cell; misaligned mass may need to remain Borel-source-level. Can both fit in a finite LP?
- **Refining-sequence stability:** does the sourcewise LP satisfy a monotonicity property under refinement that the original LP lacked? (The reviewer suggested this is what restores feasibility under label-pure refinements.)
- **Borel→compact gap revisited:** does the sourcewise repair help close the Borel-positive deletion / unchanged label-image-closure gap?

## What you MUST do

- Be precise. Every lemma needs a candidate statement.
- Apply the renaming test to every step.
- Sketch the repaired LP on the prover's counterexample to confirm feasibility.
- Honest assessment at the end: is the repaired R6 a real route, or does the sourcewise rewrite hide a different obstruction?

## What you MUST NOT do

- Do not propose proofs.
- Do not silently strengthen to (H_C1) or label-purity-as-hypothesis without flagging.
- Do not invoke posterior calibration, Bayes cones, or support functions of $B(m)$ at any step.
- Do not patch the LP into something that mentions $G(s)$ or $B(m)$ as constraint.

## Output Format

```markdown
## R6 Breakdown v2 (sourcewise LP)

### Step 1 — Repaired finite LP
- Lemma 1.1' (sourcewise LP construction): statement, dependencies, technique, difficulty, renaming-test note.
- Lemma 1.2' (renaming check on repaired LP): ...

### Step 2 — Repaired collapse lemma
- Lemma 2.1' (sourcewise collapse): statement, ..., renaming-test note.
- Verification on the prover's counterexample: (sketch the LP on $\Omega = \{0,1\}, \alpha = 3/5, M$ as in the prover's setup, confirm feasibility under the repaired LP)

### Step 3 — Limit lemmas
- Lemma 3.1' (tightness/compactness): ...
- Lemma 3.2' (limit kernel): ...
- Lemma 3.3' (limit renaming check): ...

### Step 4 — Numbered Action List for Prover
1. (Lemma 2.1' on the prover's counterexample as a sanity check, then in general.)
2. ...

### Step 5 — Test Cases
- Prover's counterexample: ...
- Duplicate labels: ...
- Binary: ...
- Spherical: ...
- v8 ternary witness: ...

### Step 6 — Honest Assessment
(One paragraph. Is the repaired R6 alive, or does the sourcewise rewrite hide a different obstruction? If alive, what is the most-likely-to-fail step?)
```

Length: 1500–2200 words.
