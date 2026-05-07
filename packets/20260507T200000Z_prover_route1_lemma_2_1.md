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

```markdown
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
```

Length: 1500–2200 words.
