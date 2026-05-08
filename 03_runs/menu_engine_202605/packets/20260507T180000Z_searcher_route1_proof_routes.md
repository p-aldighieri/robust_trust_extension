# Searcher pass — proof routes for Route 1 target theorem

You are the **Searcher** in the soft-scaffolding workflow. The Route 1 formalizer just landed a precise target theorem (deletion-compatible Hall duality). Your job: propose 2–4 genuinely distinct proof routes for it, apply the renaming test to each, and rank them.

## The target theorem (as formalized)

**Setting.** $\Omega$ finite, $\tau$ Borel probability on $\Delta := \Delta(\Omega)$, $M = \mathrm{supp}\,\tau$, $W \subseteq \mathbb{R}^\Omega$ compact convex (the menu-engine payoff-profile set), $\alpha \in (0, 1)$. For compact $C \subseteq W$:
$$F(C) := \int_M \big[ \alpha \max_{z \in C} s \cdot z + (1-\alpha) \min_{z \in C} s \cdot z \big]\,\tau(ds).$$

A labeled compact menu $(C^*, w^*)$ satisfies: $F(C^*) = \sup_{C \in \mathcal K(W)} F(C)$, $w^*: M \to C^*$ Borel with $w^*(s) \in \arg\max_{z \in C^*} s \cdot z$ τ-a.e., and $C^* = \overline{w^*(M)}$ (light closure-pruning behavioral minimality).

For $m \in M$: $B(m) := \{p \in \Delta : p \cdot w^*(m) = \max_{v \in W} p \cdot v\}$ (Bayes cone of the label).
For $s \in M$: $G(s) := \{m \in M : s \cdot w^*(m) = \min_{z \in C^*} s \cdot z\}$ (rowwise minimizer message set).

**Hypothesis (H_del, sourcewise deletion-stability).** With $\text{Del}(w^*, \tau) := \{\overline{w^*(M \setminus E)} : E \in \mathcal B(M), \tau(E) > 0\}$,
$$\forall D \in \text{Del}(w^*, \tau) \setminus \{\emptyset, C^*\},\quad F(D) < F(C^*).$$

**Conclusion.** There exists a Borel kernel $\kappa: M \to \Delta(M)$ such that:
- $\kappa(G(s) \mid s) = 1$ for τ-a.e.\ $s$ (rowwise-minimizer support);
- $P_{\gamma_\alpha}(\cdot \mid m) \in B(m)$ for $q$-a.e.\ $m$, where $\gamma_\alpha = \alpha (\mathrm{id}, \mathrm{id})_\#\tau + (1-\alpha)\, \tau \otimes \kappa$ and $q = (\gamma_\alpha)_2$ (Bayes-cone calibration).

## Live ambiguities you must address upfront

The formalizer surfaced three ambiguities that affect route choice:

1. **Exact-contact placement.** Does the theorem assume exact-contact in the setting, or derive the existence of $\kappa$ supported on $G(s)$ as part of the conclusion (which would also imply exact-contact)?
   - **Default for routes:** target the joint existence form (no exact-contact assumed). Note explicitly if a route only delivers calibration under separate exact-contact.
2. **Alternative hypotheses.** $(H_\text{compact E})$: compact $E$ instead of Borel. $(H_\text{C1})$: all proper compact $D$, not just deletion-achievable ones.
   - **Default:** target $(H_\text{del})$ unless a route requires a stronger hypothesis. State explicitly which hypothesis each route uses.
3. **The Borel→compact gap.** The literature pass and the closure memo both flag that a positive-mass Borel deletion may leave $\overline{w^*(M\setminus E)} = C^*$ unchanged. The hypothesis $(H_\text{del})$ is silent on such deletions. Routes must either resolve this via regularity or work with a different formulation.

## Renaming test (must apply to every route)

A route is alive only if its proof structure does not introduce: existence of a kernel on $G(s)$, posterior membership $P_\gamma(\cdot \mid m) \in B(m)$, support-function inequalities involving $h_{B(m)}$, or any direct Bayes-cone constraint. These would smuggle the conclusion into the hypothesis.

The dual or constructive object the route produces must be a **deletion certificate** — something that prices source patches AND message calibration simultaneously, in primitive terms.

## Candidate routes to consider

You may use these as starting points, refine them, or propose entirely different routes.

### (R1) Strassen/Kellerer convex-feasibility separation

Encode the desired $\gamma$ as an element of a convex set $\Gamma$ of joint laws on $\Delta \times M$ defined by primitive constraints (first marginal $\tau$; truthful diagonal lower bound $\alpha (\mathrm{id}, \mathrm{id})_\#\tau$; total mass 1; barycenter constraints encoding rowwise minimization). Show $\Gamma$ is closed convex in the weak topology. Apply Strassen/Kellerer-style separation to either find $\gamma \in \Gamma$ satisfying calibration, or produce a separating dual variable.

Translate the dual variable into a deletion certificate using $(H_\text{del})$.

### (R2) Weak optimal transport with conditional-law constraints

Cast the calibration condition as a weak OT problem: cost depending on the conditional law $\rho_m$ at message $m$. Use Backhoff-Veraguas–Beiglböck–Pammer existence + duality to get a dual potential. Show the dual potential, viewed as a function of source/message, encodes a deletion-stable certificate when $(H_\text{del})$ holds.

### (R3) Constrained-persuasion Lagrangian

Treat menu-Hall as a constrained persuasion problem: maximize a Bayesian objective subject to "messages live in $G(s)$" and "posterior in $B(m)$". Apply Doval–Skreta or Dworczak–Kolotilin price-theoretic duality to get a Lagrangian + dual prices. Translate "primal infeasibility" (no such $\gamma$ exists) into the deletion-deficiency hypothesis being false.

### (R4) Direct cyclical-monotonicity construction

Build $\kappa$ by a cyclical-monotonicity-style construction: start with an arbitrary candidate, find a finite-cycle improvement, iterate until either calibration holds or a deletion-deficiency certificate is exposed.

### (R5) Variational / topological fixed-point

Construct $\kappa$ as a fixed point of a variational map on a compact convex space of Borel kernels. Use $(H_\text{del})$ as the regularity hypothesis ensuring the map is well-posed and the fixed point lands in the calibrated region.

### (R6) Anything else that genuinely escapes the renaming test

If a sixth route dominates these, propose it.

## What you MUST do

For each route you keep alive (after renaming test):

1. **Hypothesis used:** (H_del), (H_compact E), or (H_C1)?
2. **Exact-contact:** does the route prove it as part of the conclusion, or assume it?
3. **Likely failure point:** name the specific lemma or topological step that has to work. Be specific.
4. **Renaming-test detection:** what early test would catch a renaming failure (e.g., "if the dual variable mentions $h_{B(m)}$, the route has smuggled the conclusion")?
5. **What positive evidence would confirm it is alive:** a finite-dim test case, an existing duality theorem the route adapts cleanly, etc.
6. **Cost estimate:** light / medium / heavy in expected prover effort.

Then **rank the alive routes**. The most actionable is the route with: high primitive content, lowest renaming risk, clearest early-evidence test, and reasonable cost. Justify the ranking in 2–3 sentences.

## What you MUST NOT do

- Do not prove anything. That is the prover's job.
- Do not invent a route whose proof structure depends on assuming menu-Hall in another form.
- Do not commit the project to a single route. Propose a ranking; orchestrator decides.

## Output Format

```markdown
## Route Audit

### (R1) Strassen/Kellerer separation
- Hypothesis used: ...
- Exact-contact: ...
- Likely failure point: ...
- Renaming-test detection: ...
- Positive evidence: ...
- Cost: light / medium / heavy

### (R2) Weak OT
...

### (R3) Constrained-persuasion Lagrangian
...

### (R4) Cyclical-monotonicity
...

### (R5) Variational fixed-point
...

### (R6) Other (if any)
...

## Ranking

1. **<Route>** — one-sentence justification.
2. **<Route>** — ...
3. **<Route>** — ...

## Honest Assessment

(One paragraph. Is there a route that genuinely produces a primitive deletion certificate, or do all routes ultimately reduce to "import menu-Hall under another name"? If the latter, recommend stopping Route 1 here and moving to Route 2.)
```

Length: 1500–2200 words.
