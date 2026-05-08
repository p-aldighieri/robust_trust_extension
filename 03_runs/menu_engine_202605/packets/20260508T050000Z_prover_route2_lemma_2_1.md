# Prover pass — Lemma 2.1 (Route 2 finite-family compact-patch separation)

You are the **Prover**. The Route 2 R6 breakdown identified Lemma 2.1 as the trapdoor for the forward bound $BR \le \Phi(\Delta_\text{del}^{cp})$. This is the make-or-break test for whether Route 2 produces genuine new content beyond v8, or whether it is Route 1 in finite-net armor.

## The lemma

### Setting

$\Omega$ finite, $\tau$ Borel probability on $\Delta := \Delta(\Omega)$, $M = \mathrm{supp}\,\tau$, $W \subset \mathbb{R}^\Omega$ compact convex, $\alpha \in (0, 1)$.

Optimal labeled menu $(C^*, w^*)$: $w^*: M \to W$ Borel, $w^*(s) \in \arg\max_{z \in C^*}\,s\cdot z$ τ-a.e., $C^* = \overline{w^*(M)}$.

$\ell(s) := \min_{z \in C^*}\,s\cdot z$. Sourcewise exact-contact relation $R_0 := \{(s, m) : s\cdot w^*(m) = \ell(s)\}$.

Admissible rowwise-contact kernel: Borel $\kappa: M \to \Delta(M)$ with $\kappa(\{m : (s, m) \in R_0\} \mid s) = 1$ τ-a.e. (We assume $R_0$ is non-trivial, i.e., exact-contact in the v8 sense — this is the hypothesis the LP needs to even state.)

For $\kappa$: $\gamma_{\alpha, \kappa} := \alpha (\mathrm{id}, \mathrm{id})_\#\tau + (1-\alpha)\,\tau \otimes \kappa$, $q_\kappa := (\gamma_{\alpha, \kappa})_2$, $p_\kappa(m) := \int s\,\gamma_{\alpha,\kappa}(ds \mid m)$.

Finite-family violation at $\kappa$: $V_i(\kappa) := \int_M [p_\kappa(m) \cdot (v_i - w^*(m))]_+\,dq_\kappa(m)$.

**Compact-patch dual deletion residual:**
$$\Delta_\text{del}^{cp}(C^*, w^*) := \sup_T [S(T)]_+,$$
$$S(T) := \alpha\!\int m \cdot A_T(m)\,d\tau + (1-\alpha)\!\int\!\inf_{m: (s,m)\in R_0}\,s\cdot A_T(m)\,d\tau(s),$$
where $T = \{(\lambda_j, K_j, v_j)\}$ runs over finite tests with compact $K_j \subseteq M$, $v_j \in W$, and $A_T(m) := \sum_j \lambda_j \mathbf{1}_{K_j}(m)(v_j - w^*(m))$.

### Lemma 2.1 (candidate statement)

Fix $\eps > 0$ and a finite ε-net $V_\eps = \{v_1, \ldots, v_{n(\eps)}\} \subset W$.

Let $\delta := \Delta_\text{del}^{cp}(C^*, w^*)$. Then there exists an admissible rowwise-contact kernel $\kappa_\eps$ with
$$\max_{i \le n(\eps)}\,V_i(\kappa_\eps) \le \delta + \rho_\eps,$$
where $\rho_\eps$ is a slack that goes to zero as ε → 0 with the discipline $n(\eps)\,\rho_\eps \to 0$ at the final optimization scale.

## What this lemma must do

The proof must:
1. **Encode** a finite LP whose constraints are primitive inequalities $s\cdot(v - w^*(m))$ and whose feasibility is equivalent (up to the slack $\rho_\eps$) to existence of a kernel with $\max_i V_i \le \delta + \rho_\eps$.
2. **Apply finite Farkas / minimax** to either find a feasible $\kappa$ or extract a dual certificate.
3. **Translate** any dual certificate into a compact-patch test $T$ with $S(T) \ge \max_i V_i(\kappa) - \rho_\eps$. This is the contrapositive form: infeasibility (i.e., no kernel beats threshold $a$) ⇒ existence of compact-patch test with $S(T) \ge a - \rho_\eps$.
4. **Lift** the LP solution (defined on slabs/cells, finite-dimensional) to an actual Borel kernel on $M$. This is where continuum-mass and label-fiber issues bite.

The renaming test: dual multipliers may price the finite primitive constraints (mass conservation, raw $s\cdot(v - w^*(m))$ inequalities). They must NOT price posterior-cone membership, $h_{B(m)}$, or "the message-cell calibrates."

## Three valid outcomes

**(A) Proof of Lemma 2.1.** Complete construction of the LP, finite Farkas duality, dual-to-compact-patch translation, and LP-to-kernel lift. Apply renaming test step-by-step. The slack $\rho_\eps$ must be controllable so that $n(\eps)\,\rho_\eps \to 0$.

**(B) Disproof / counterexample.** A specific model where $\Delta_\text{del}^{cp} = \delta$ but the finite-family LP cannot be made feasible with $\max_i V_i \le \delta + o(1/n(\eps))$. Most plausible structure: continuum-mass / label-fiber gap survives the finite-net regularization. **If exhibited, Route 2 R6 is dead; it's the same dragon.**

**(C) Honest stall.** A precisely named obstacle. Likely candidates from the breakdown:
- "Finite Farkas dual prices a posterior-cone object via finite separation." Renaming check fails.
- "LP-to-kernel lift requires positive-mass on label fibers, which the continuum case denies."
- "Slack $\rho_\eps$ scales with $n(\eps)$, polluting the entropy bootstrap."
- "Compact-patch tests miss a Borel violation that the inner-regularity step doesn't recover."

For each, name what would unblock.

## What you MUST do

- Pick one outcome and commit.
- If (A): write the proof in full, with finite LP, Farkas dual, compact-patch translation, kernel lift, and slack analysis. Apply renaming test inline.
- If (B): exhibit explicitly. Verify both LP infeasibility AND no compact-patch test achieves $S(T) \ge \delta - o(1)$.
- If (C): name the obstacle precisely, the step where it arises, and what additional hypothesis would close it.

## What you MUST NOT do

- Do not use the reverse direction (Δ_del = 0 ⇒ exact Tier 2). That is the closure-memo bottleneck; Route 2 forward bound does not need it.
- Do not invoke posterior calibration, Bayes cones $B(m)$, or support functions $h_{B(m)}$ in the lemma's proof. They appear in the LHS of the bound, but the proof of the bound must use only primitive constraints in the dual.
- Do not silently strengthen the standing hypotheses. If the proof needs label-purity, behavioral minimality stronger than $C^* = \overline{w^*(M)}$, or a uniform deletion-gap, surface it as a new hypothesis.
- Do not import Route 1's full Borel-deletion architecture. The whole point of R6 is that the finite family is supposed to make this manageable.

## Output Format

```markdown
## Verdict
PROVED / DISPROVED / STALLED

## Outcome
(A) Proof / (B) Counterexample / (C) Honest stall

## Argument

(If A: full LP construction, Farkas dual, compact-patch translation, lift, slack analysis. Apply renaming test inline.
If B: specific model with verifications.
If C: precise obstacle and what would unblock.)

## Renaming Test Audit

(Step-by-step. Confirm no forbidden objects appear, or specify exactly where the obstruction lies.)

## Implication for Route 2 R6

(One paragraph. Does this verdict close Route 2's forward bound, or does it survive into Lemmas 3.1, 4.1, 4.2, 5.1?)

## Implication for the Project

(One paragraph. Should the orchestrator continue Route 2, return to v8, or run a final gatekeeper?)
```

Length: 1500–2200 words.
