# Breakdown — Route 2 R6: finite-net entropy bootstrap for forward bound

You are the **Breakdown** role. Route 2 searcher ranked R6 as the top route for the forward bound $BR \le \Phi(\Delta_\text{del}^{cp})$. Decompose R6 into a numbered chain of lemmas. Identify the critical "finite-family compact-patch separation" lemma. Apply the renaming test step-by-step.

## What R6 does

For each ε > 0:
1. Fix a finite ε-net $V_\eps \subset W$ with $|V_\eps| = n(\eps)$.
2. Apply **finite-family minimax/separation** to the finite system $\{p \cdot (v - w^*(m)) \le 0 : v \in V_\eps\}$ — given $\Delta_\text{del}^{cp}(C^*, w^*) = \delta$, construct a rowwise-contact kernel $\kappa_\eps$ with finite compact-patch violations $\le \delta + \eta(\eps)$.
3. Apply **inner regularity** to upgrade compact-patch control to Borel control: $\int [p_{\kappa_\eps}(m) \cdot (v_i - w^*(m))]_+\,dq_{\kappa_\eps} \le \delta + \eta(\eps)$ for each $v_i \in V_\eps$.
4. **Net approximation:** $BR \le L\eps + n(\eps)\,(\delta + \eta(\eps))$, since the support function of W is uniformly approximated by $V_\eps$.
5. Optimize over ε: linear $\Phi(\delta) = r\delta$ for polytope W; Hölder $\Phi(\delta) \asymp \delta^{1/(d+1)}$ for curved W via metric entropy.

## Your task

Produce a numbered breakdown. Each lemma needs a precise candidate statement, dependencies, technique hint, difficulty estimate, and renaming-test note.

### Step 1 — Setup and finite-family LP

- **Lemma 1.1 (finite-net data).** Fix ε > 0. Let $V_\eps = \{v_1, \ldots, v_{n(\eps)}\} \subset W$ be a finite ε-net (in the metric induced by $\sup_{s \in \Delta(\Om)} |s\cdot \cdot|$). For each $v_i \in V_\eps$, the finite-family violation at kernel κ is $V_i(\kappa) := \int [p_\kappa(m) \cdot (v_i - w^*(m))]_+\,dq_\kappa$. Light. Definition only.

- **Lemma 1.2 (finite-family LP).** Construct a finite-dimensional LP whose variables are masses on a finite slab partition × $V_\eps$, whose constraints encode rowwise-contact support and admissibility, and whose feasibility is equivalent to existence of a kernel with $V_i \le 0$ for all $v_i \in V_\eps$. Light/medium.

  **Renaming check:** the LP's constraints must be primitive — no $G(s)$ as constraint, no $B(m)$. Variables $x_{B,v}$ on slabs × labels; constraints on raw $s\cdot(v - w^*(m))$.

### Step 2 — Critical lemma (the finite-family separation)

- **Lemma 2.1 (finite-family compact-patch separation).** If the finite-family LP has minimum max-violation $\delta_\eps > 0$, then there exists a finite compact-patch test $T$ with $S(T) \ge \delta_\eps - O(\eps)$. **Equivalently** (by contrapositive): given $\Delta_\text{del}^{cp}(C^*, w^*) = \delta$, the finite-family LP admits a feasible solution with $\max_i V_i \le \delta + O(\eps)$.

  This is the "smaller dragon": **the same architecture as the failed Route 1 collapse lemma, but for a finite family instead of the full Borel system.** It must avoid the four obstructions:
  - **Continuum-mass / label-fiber zero-mass:** does the slab discretization handle this?
  - **Borel→compact:** if compact-patch tests miss Borel violations, $\Delta_\text{del}^{cp}$ may understate the true defect.
  - **F-comparison gap:** the searcher's net approximation handles this via $L\eps$ slack.
  - **(H_del) pointwise strict:** Route 2 doesn't need a contradiction; it produces a quantitative bound regardless.

  Difficulty: **heavy.** This is the route's trapdoor.

  **Renaming-test note:** the dual certificate may use Lagrange multipliers, but they must price the finite primitive constraints, not posterior cones.

### Step 3 — Inner regularity / compact-to-Borel upgrade

- **Lemma 3.1 (inner regularity).** For a finite $V_\eps$, $\sup_{T \text{ compact-patch}} S(T)$ controls $\sup_{T \text{ Borel-patch}} S(T)$ with a $\eta(\eps)$ slack. Use Borel inner regularity of finite measures (every Borel set has a compact subset of nearly equal measure).

  Difficulty: medium. Standard inner regularity + uniform bounding.

  **Renaming-test note:** uses only $\tau$, $\alpha$, $w^*$, $W$, $V_\eps$. Pass.

### Step 4 — Net approximation

- **Lemma 4.1 (net approximation).** For ε-net $V_\eps$ in W, the support function $\sigma_W(p) := \max_{v \in W} p\cdot v$ is approximated by $\sigma_{V_\eps}(p) := \max_{v \in V_\eps} p\cdot v$ uniformly: $|\sigma_W - \sigma_{V_\eps}|_\infty \le L\eps$ where $L$ depends on $\sup_p \|p\|$ and the diameter of $\Delta(\Om)$.

  Difficulty: light. Standard.

  **Renaming-test note:** completely primitive. Pass.

- **Lemma 4.2 (BR control by finite-family violation).** $BR \le L\eps + \sum_{v_i \in V_\eps} V_i(\kappa_\eps)$ for any kernel $\kappa_\eps$. (The sum is the natural finite-family aggregation; alternatively, $\max_i V_i$ times $n(\eps)$.)

  Difficulty: light/medium. Follows from Lemma 4.1 + Jensen-style aggregation.

  **Renaming-test note:** uses only LHS objects (allowed). Pass.

### Step 5 — Putting it together

- **Theorem 5.1 (forward bound, R6).** For every ε > 0:
$$BR(C^*, w^*) \le L\eps + n(\eps)\,(\Delta_\text{del}^{cp}(C^*, w^*) + \eta(\eps)).$$
Optimize over ε.
  - Polytope $W$ with r vertices: $V_\eps$ can be chosen with $|V_\eps| = r$ for ε = 0; bound becomes $BR \le r\,\Delta_\text{del}^{cp}$ — **linear $\Phi$**.
  - Curved $W$ with metric entropy $N_W(\eps) \le C\eps^{-d}$: optimize $L\eps + C\eps^{-d}\delta$, yielding **Hölder $\Phi(\delta) \asymp \delta^{1/(d+1)}$**.

  Difficulty: light/medium. Bookkeeping after Lemmas 1–4.

  **Renaming-test note:** the constant $L = L(W, \Delta(\Om))$, the entropy constant $C = C(W)$, and the polytope vertex count $r$ depend only on $W$, not on $C^*$ or $w^*$ in any way that smuggles in calibration. Pass.

### Step 6 — Numbered action list for prover

The orchestrator routes the next prover pass to:
1. **Lemma 2.1 (finite-family compact-patch separation).** This is the critical lemma. If it fails, Route 2 R6 is dead.
2. If 2.1 holds: prove 1.1 + 1.2 + 3.1 + 4.1 + 4.2 + 5.1 in order.

### Step 7 — Test cases

- **Finite M, finite W:** finite Farkas. Lemma 2.1 should be ordinary LP duality.
- **Binary state Appendix A.6:** does the bound recover the paper's quantile-transport regret bound?
- **Spherical / radial:** does the bound recover the paper's antipodal construction?
- **v8 ternary witness:** the witness has menu-Hall failure; Δ_del^{cp} should be positive there. Compute (or estimate) Δ_del^{cp} on the witness; verify the bound is informative.
- **Route 1 prover's counterexample (mixed-cell binary):** a sanity check that the sourcewise rewrite + finite-net approach handles it cleanly.

### Step 8 — Honest assessment

Is R6 alive as a forward bound, or does Lemma 2.1 just rediscover the failed Route 1 architecture? Specifically:
- Does the **finite** family avoid the four Route 1 obstructions (continuum-mass, Borel→compact via inner regularity, F-comparison via net, (H_del) pointwise via quantitative softness)?
- Is the constant $K$ in $\Phi$ actually computable from W and $\tau$, or does it secretly depend on calibration content?

## What you MUST do

- Be precise. Every lemma needs a candidate statement.
- Apply the renaming test to every step.
- Identify the single critical lemma.
- Output a numbered action list.

## What you MUST NOT do

- Do not propose proofs.
- Do not silently strengthen with hidden hypotheses (label-purity, behavioral minimality stronger than $C^* = \overline{w^*(M)}$).
- Do not invoke $G(s)$ as a constraint, $B(m)$, $h_{B(m)}$, posterior membership, or the reverse biconditional.

## Output Format

```markdown
## R6 Breakdown for Route 2 Forward Bound

### Step 1 — Setup
- Lemma 1.1 (finite-net data): ...
- Lemma 1.2 (finite-family LP): ...

### Step 2 — Critical Lemma
- Lemma 2.1 (finite-family compact-patch separation): ..., renaming-test note.
- Justification why this is the trapdoor: ...

### Step 3 — Inner regularity
- Lemma 3.1: ...

### Step 4 — Net approximation
- Lemma 4.1, Lemma 4.2: ...

### Step 5 — Theorem
- Theorem 5.1 (forward bound, R6): ...

### Step 6 — Numbered Action List for Prover

1. (Critical lemma to attack first.)
2. (Next.)
3. ...

### Step 7 — Test Cases
- Finite M / W: ...
- Binary: ...
- Spherical / radial: ...
- v8 ternary witness: ...
- Route 1 prover's counterexample: ...

### Step 8 — Honest Assessment
(One paragraph. Does Lemma 2.1 actually escape Route 1's four walls, or is it the same dragon shrunk to LP size?)
```

Length: 1500–2200 words.
