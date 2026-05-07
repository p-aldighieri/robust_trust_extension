# Reviewer pass — Lemma 2.1 disproof (Route 1 collapse lemma)

You are the **Reviewer** in the soft-scaffolding workflow. The Lemma 2.1 prover returned **DISPROVED** with a concrete finite counterexample. Audit the counterexample and decide whether the obstruction is **fatal to R6** or merely a **fixable issue** with the LP construction in Lemma 1.1.

## The counterexample (verbatim from prover)

**Setup:** $\Omega = \{0, 1\}$, $\alpha = 3/5$. Posteriors written $s_p = (1-p, p)$. Source space:
$$M = \{s_0, s_{1/3}, s_{2/3}, s_1\}, \quad \tau(\{s_p\}) = \tfrac{1}{4}.$$
Payoff profiles: $a = (0, 0)$, $b = (-3, 3)$, $W = [a, b] = \{w_t := tb : 0 \le t \le 1\}$. Inner products: $s_p \cdot a = 0$, $s_p \cdot b = 6p - 3 =: d(p)$. So $d(0) = -3, d(1/3) = -1, d(2/3) = 1, d(1) = 3$.

**Optimal menu:** $C^* = \{a, b\}$. Aligned-best labeling: $w^*(s_0) = w^*(s_{1/3}) = a$, $w^*(s_{2/3}) = w^*(s_1) = b$.

**$F$-value verification.** For any compact $C \subseteq W$ parametrized by $T_C \subseteq [0,1]$ with $\ell = \min T_C$, $h = \max T_C$:
$$F(C) = (2\alpha - 1)(h - \ell) = \tfrac{1}{5}(h - \ell) \le \tfrac{1}{5}.$$
$F(C^*) = 1/5$. So $C^*$ is optimal.

**(H_del) holds.** Every proper compact deletion of $C^*$ is $\{a\}$ or $\{b\}$ (singleton); both give $F = 0 < 1/5$.

**Partition:** $A_1 = \{s_{1/3}, s_1\}$, $A_2 = \{s_{2/3}, s_0\}$ with $m_1 = s_{1/3}$, $m_2 = s_{2/3}$. Representatives' labels: $w_1 = a$, $w_2 = b$. Cell barycenters: $\bar s_1 = s_{2/3}$, $\bar s_2 = s_{1/3}$.

**ε-edges with $\eps = 1/2$:** $\bar s_1 \cdot a = 0$, $\bar s_1 \cdot b = 1$ → unique min for cell 1 is $a = w_1$. $\bar s_2 \cdot a = 0$, $\bar s_2 \cdot b = -1$ → unique min for cell 2 is $b = w_2$. So $r_{12} = r_{21} = 0$, $r_{11} = r_{22} = 1/5$, $x_{11} = x_{22} = 1/2$.

**Cone test at column 1, $v = b$:** $\sum_i x_{i1}\,\bar s_i \cdot (b - a) = x_{11} \cdot \bar s_1 \cdot (b - a) = \tfrac{1}{2} \cdot 1 = \tfrac{1}{2} > 0$. **LP infeasible.**

**No proper deletion:** $E = A_1$ ⇒ $M\setminus E = A_2 = \{s_{2/3}, s_0\}$ with $w^*(s_{2/3}) = b$ and $w^*(s_0) = a$, so $\overline{w^*(M\setminus E)} = \{a, b\} = C^*$. Same for $E = A_2$. Hence no $E \subsetneq \{1, 2\}$ produces a proper deletion.

**Conclusion:** $(H_\text{del})$ holds AND LP is infeasible AND no proper deletion exists. Lemma 2.1 is false as stated.

## What you MUST audit

### 1. Counterexample correctness

Verify each step:
- **(a)** Is $C^* = \{a, b\}$ actually $F$-optimal? The prover's derivation $F(C) = (2\alpha-1)(h - \ell)$ for $\alpha = 3/5$ uses $\int d_+ d\tau = \int (-d)_+ d\tau = 1$. Verify.
- **(b)** Is $(H_\text{del})$ actually satisfied? The prover claims every proper compact deletion is a singleton $\{a\}$ or $\{b\}$. Is that complete (consider all Borel $E$ with $\tau(E) > 0$)?
- **(c)** Is the LP infeasible? The prover's edge-graph and cone-test computation should be checked.
- **(d)** Is the "no proper deletion" claim correct? Check both $E = A_1$ and $E = A_2$, and any other Borel $E$ that is a finite union of source-cells.

If any step has a slip, the counterexample fails and Lemma 2.1 may still be alive.

### 2. Fatal vs. fixable diagnosis

The prover's diagnosis: "The LP prices the aligned mass using representative labels but tests optimality using barycenters. Coarse mixed cells create artificial infeasibility unrelated to any compact deletion of $C^*$."

Is this diagnosis correct, and if so, does it kill R6 fundamentally or only kill the specific LP construction in Lemma 1.1?

Specific questions:

- **(2a) Refining the partition.** If we REQUIRE the partition $\mathcal P$ to be **label-pure** (each cell $A_i$ contained in $\{w^*\}^{-1}(\{w_i\})$), does the counterexample evaporate? On the prover's example, label-pure partitions are $\{s_0, s_{1/3}\}$ vs. $\{s_{2/3}, s_1\}$ (label $a$ vs. label $b$). What does the LP look like under that partition?
- **(2b) Refining the LP.** Could the LP be redefined so that the aligned mass is not attached to representative labels but to actual labels at each $s$ via $w^*(s)$? E.g., replace "diagonal mass $\alpha\tau_i \mathbb{1}_{i=j}$" with "diagonal mass at the actual label, ignoring partitions". What does that LP look like?
- **(2c) Refining the test.** Could the cone test use the cell label $w_j$ but be evaluated at the actual sources $s$ rather than at the barycenter $\bar s_i$? E.g., $\sum_i \int_{A_i} s\cdot(v - w_j)\,r_{ij}/\tau_i\,\tau(ds)$ instead of $\sum_i x_{ij}\bar s_i \cdot (v - w_j)$.
- **(2d) Limit behavior.** If the LP is required to be feasible for **every** partition, does the obstruction survive? The prover's counterexample is for a specific $(\mathcal P, V_0, \eps)$; does it still bite if we quantify over all partitions?

### 3. Implication for the project

Given the verdict and your fatal/fixable diagnosis:

- If **fatal**: confirm Route 1's R6 dialect is dead. Do R1 and R4 die too (they share the collapse step in spirit)? Should the project move to Route 2 (calibration-defect) or stop with v8?
- If **fixable**: identify the minimal fix. Is the fix internal (rewrite the LP) or does it require additional hypotheses (label-pure partitions, regularity of $w^*$)? If it requires hypotheses, are they primitive (passing renaming test) or do they secretly invoke menu-Hall?

## Verdict and downstream advice

### Verdict levels

- `PASS`: counterexample is correct; the diagnosis (fatal vs. fixable) is sound.
- `PATCH_SMALL`: counterexample is correct but the fatal/fixable assessment needs adjustment.
- `PATCH_BIG`: counterexample has a real gap; Lemma 2.1 may still be salvageable.
- `REDO`: counterexample is wrong.

### Downstream advice (one paragraph)

Given the verdict, what should the orchestrator do?

- **Stop Route 1 and gatekeeper.** If R6 is fatally dead (and R1, R4 share the obstruction), close Route 1 and run a fresh gatekeeper: does Route 2 still warrant a full pipeline pass, or do we stop with v8?
- **Repair Route 1's LP.** If the obstruction is fixable, run another breakdown pass with the refined LP construction.
- **Move directly to Route 2.** If R6 is fatal but Route 2 is the gatekeeper-blessed alternative, skip the gatekeeper and go straight to Route 2's literature pass.
- **Stop with v8.** If the obstruction generalizes beyond the LP and the deletion-compatible Hall theorem is genuinely unreachable, v8 is terminal.

## Output Format

```
\`\`\`review_control
verdict: PASS / PATCH_SMALL / PATCH_BIG / REDO
route_status: viable / blocked / dead
recommended_next_phase: GATEKEEPER / PROVER / BREAKDOWN / SEARCHER / LITERATURE / CONSOLIDATOR / STOP_STALL
proof_status: complete / partial / broken
\`\`\`

## Verdict
VERDICT: ...
Reason: ...

## Counterexample Audit
- (a) F-optimality of C*: ...
- (b) (H_del) holds: ...
- (c) LP infeasibility: ...
- (d) No proper deletion: ...

## Fatal vs. Fixable Diagnosis
- (2a) Label-pure partitions: ...
- (2b) Refined LP with actual labels: ...
- (2c) Cone test at sources rather than barycenters: ...
- (2d) Quantification over all partitions: ...
- Fatal vs. fixable verdict: ...

## Implication for the Project
(One paragraph. Strong recommendation on next phase.)
```

Length: 1500–2000 words.
