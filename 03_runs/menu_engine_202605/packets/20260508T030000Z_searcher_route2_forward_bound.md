# Searcher pass — proof routes for Route 2 forward bound

You are the **Searcher**. The Route 2 formalizer landed a clean target theorem with primitive defect (D1 compact-patch dual residual) and a substantive (non-tautological) biconditional. Your job: rank distinct proof routes for the **forward direction**:
$$BR(C^*, w^*) \le \Phi(\Delta_\text{del}^{cp}(C^*, w^*)),$$
**explicitly NOT attempting the reverse direction** (Δ_del = 0 ⇒ exact Tier 2), which is the same closure-memo bottleneck.

The forward direction alone is genuine new content beyond v8: it turns Tier 2's menu-Hall hypothesis into a quantitative obstruction with primitive measurement.

## What the forward bound is

For the target theorem statement (formalizer landed it):

$BR$ — payoff-profile Bayes-regret:
$$BR(C^*, w^*) := \inf_{\kappa: \kappa(R_0(s)\mid s) = 1} \int_M \max_{v \in W} p_\kappa(m) \cdot (v - w^*(m))\,q_\kappa(dm)$$

where $R_0 := \{(s, m) : s\cdot w^*(m) = \ell(s)\}$, $\gamma_{\alpha, \kappa} := \alpha (\mathrm{id}, \mathrm{id})_\#\tau + (1-\alpha)\,\tau \otimes \kappa$, $q_\kappa := (\gamma_{\alpha, \kappa})_2$, $p_\kappa(m) := \int s\,\gamma_{\alpha,\kappa}(ds \mid m)$, $\ell(s) := \min_{z \in C^*}\,s\cdot z$.

$\Delta_\text{del}^{cp}$ — compact-patch dual deletion residual:
$$\Delta_\text{del}^{cp} := \sup_T [S(T)]_+,$$
$$S(T) := \alpha \!\int_M m \cdot A_T(m)\,d\tau + (1-\alpha)\!\int_M\!\inf_{m:\,s\cdot w^*(m) = \ell(s)}\,s\cdot A_T(m)\,d\tau(s),$$
where $T = \{(\lambda_j, K_j, v_j)\}$ runs over finite tests with compact $K_j \subseteq M$, $v_j \in W$, $\lambda_j \ge 0, \sum\lambda_j \le 1$, and $A_T(m) := \sum_j \lambda_j \mathbf{1}_{K_j}(m)(v_j - w^*(m))$.

**The bound** (forward direction): $BR \le \Phi(\Delta_\text{del}^{cp})$ for some $\Phi: [0,\infty) \to [0,\infty)$ with $\Phi(0) = 0$ (linear $\Phi(\delta) = K\delta$ is the natural target).

## Live ambiguities to address

- **Borel→compact gap.** $\Delta_\text{del}^{cp}$ uses compact $K_j$. The bound on $BR$ involves arbitrary Borel $\kappa$. Routes must explain how compact-patch tests control Borel violations.
- **Φ-shape.** Linear $\Phi(\delta) = K\delta$ requires uniform Lipschitz/calmness. Hölder $K\delta^p$ may be needed if W is curved. Identify what hypotheses each route needs.
- **Constant K.** Should $K$ depend on $\tau$, $\alpha$, $\mathrm{diam}(W)$, or be universal? Universal is much stronger.

## Renaming test (must apply to every route)

The defect $\Delta_\text{del}^{cp}$ is by construction primitive. The proof route may freely use $\kappa$, $p_\kappa$, $B(m)$, etc. — these appear on the LHS legitimately. But the route's hypotheses must not silently sneak in extra calibration content.

Specifically, a route fails the renaming test if its proof requires:
- Existence of a calibrated $\kappa$ as a hypothesis (would be circular).
- A version of menu-Hall as a primitive condition (would defeat the point).
- $\tau$-absolute continuity of all admissible $\kappa$ (would forbid the dust constructions the formalizer flagged).

## Candidate routes to consider

You may use these as starting points, refine them, or propose entirely different ones.

### (R1) Convex-duality / LP-relaxation

Cast the BR-minimization as a constrained convex optimization in the kernel space. Apply a primal-dual gap inequality: the primal optimum $\le$ any feasible dual value. Construct a dual feasible solution from the compact-patch tests so its dual value equals $\Phi(\Delta_\text{del}^{cp})$.

Route: BR ≤ dual gap ≤ supremum of compact-patch witness scores ≤ $\Phi(\Delta_\text{del}^{cp})$.

### (R2) Hoffman / Burke-Tseng error bound

Treat the calibration condition $\{p_\kappa(m) \cdot (v - w^*(m)) \le 0 \,\forall v\}$ as a system of linear inequalities indexed by $v$. Apply Hoffman/Burke-Tseng calmness to bound the distance from a candidate $\kappa$ to a feasible (calibrated) $\kappa$ by the residual. Translate distance to $BR$ via Lipschitz continuity of the regret functional.

### (R3) Quantitative Strassen / quantitative martingale OT

Use the Beiglböck-Nutz-Touzi (2017) and (2022) framework. Express calibration as a constrained transport problem; apply the quantitative duality theorem to bound BR by the "primal-dual gap," which equals $\Delta_\text{del}^{cp}$ in this setup.

### (R4) Variational gap function approach

Construct a gap function $g: \kappa \mapsto \mathbb R$ such that (i) $g(\kappa) \ge 0$, (ii) $g(\kappa) = 0$ iff $\kappa$ is calibrated, (iii) $g(\kappa) \ge BR$. Bound $\inf g$ by $\Delta_\text{del}^{cp}$ via a min-max argument over compact-patch tests.

### (R5) Direct Lagrangian bound

Form the Lagrangian for BR with Lagrange multipliers attached to the calibration constraints. The dual function evaluated at any feasible multiplier gives an upper bound on BR. Show the supremum over compact-patch witnesses dominates the Lagrange dual evaluated at the optimal multiplier.

### (R6) Anything else genuinely new

If a sixth route dominates these, propose it.

## What you MUST do

For each route:

1. **Hypothesis used:** does it need additional primitive regularity (compact-patch completeness, Lipschitz continuity, polyhedral W, etc.)?
2. **Borel→compact handling:** how does compact-patch testing control Borel violations? (This is the route's load-bearing question.)
3. **Likely failure point:** name the specific lemma or topological step.
4. **Renaming-test detection:** what early test catches a renaming failure?
5. **Φ-shape it produces:** linear / Hölder / piecewise. Constant K dependent on what?
6. **What positive evidence would confirm it is alive:** finite-dim test case, existing duality theorem it adapts cleanly.
7. **Cost estimate:** light / medium / heavy.

Then **rank the alive routes**. Most actionable = highest primitive content, lowest renaming risk, clearest Φ-shape, reasonable cost.

## What you MUST NOT do

- Do not attempt the reverse direction Δ_del = 0 ⇒ exact Tier 2. That is the closure-memo bottleneck and a separate research target.
- Do not invent a route whose hypotheses contain a hidden form of menu-Hall.
- Do not commit the project to a single route; propose a ranking.

## Output Format

```markdown
## Route Audit

### (R1) Convex duality / LP-relaxation
- Hypothesis used: ...
- Borel→compact handling: ...
- Likely failure point: ...
- Renaming-test detection: ...
- Φ shape: ...
- Constant K depends on: ...
- Positive evidence: ...
- Cost: light / medium / heavy

### (R2) Hoffman / Burke-Tseng
...

### (R3) Quantitative Strassen / martingale OT
...

### (R4) Variational gap function
...

### (R5) Lagrangian
...

### (R6) Other (if any)
...

## Ranking

1. **<Route>** — one-sentence justification.
2. **<Route>** — ...
3. **<Route>** — ...

## Honest Assessment

(One paragraph. Is the forward bound genuinely provable without invoking the reverse, or do the routes ultimately collapse into Route-1 territory? If alive, what shape of Φ is realistic — linear, Hölder, or worse?)
```

Length: 1500–2200 words.
