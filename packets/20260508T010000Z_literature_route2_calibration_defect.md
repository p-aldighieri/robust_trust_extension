# Literature pass — Route 2: calibration-defect theorem

You are the **Literature** role in the soft-scaffolding workflow. Route 1 (deletion-compatible Hall duality) just closed at an honest stall: the four-obstruction wall (continuum-mass, Borel→compact, F-comparison, (H_del) pointwise-strict) makes the LP/deletion contradiction architecture untenable under bare (H_del). The orchestrator is moving to Route 2 (calibration-defect theorem) per the gatekeeper's earlier ranking and the user's "full pipeline per route" plan. This is the literature pass for Route 2.

## What Route 2 aims for

The target is a **calibration-defect theorem**, not an existence theorem. Define a primitive defect functional $\Delta_\text{del}$ on the labeled menu $(C^*, w^*)$ that measures "how much improvement is detectable by sourcewise compact-patch deletions and primitive payoff-profile replacements." The deliverable is a theorem of the form:

> **Best-attainable distributional Bayes-regret** $\le \Phi(\Delta_\text{del})$.

Two key features:
- **Quantitative:** the bound is real-valued, not zero/one. If $\Delta_\text{del} > 0$, you get a quantitative relaxation; if $\Delta_\text{del} = 0$, you recover exact Tier 2 (full robust rationalizability).
- **Primitive:** the defect uses only $F$, $w^*$, $\tau$, $\alpha$, compact source patches — passes the renaming test by construction.

The crucial Route-1 observation: (H_del) is pointwise strict but not uniform. Route 2 doesn't need to contradict (H_del) — it produces a quantitative bound regardless. So the (H_del) "tiny hinge" obstruction (O4) is sidestepped. But the other obstructions (continuum-mass, Borel→compact) may still bite.

## Your task

Survey the relevant literature and decide whether the calibration-defect theorem is:
- **(Apply)** a direct consequence of an existing stability/sensitivity theorem with primitive-equivalent hypotheses;
- **(Adapt)** close to an existing theorem but needing primitive-hypothesis adaptation;
- **(Build)** genuinely new.

Survey the following bodies of work; for each, identify (i) the closest stability/sensitivity theorem, (ii) whether its hypotheses are primitive in our sense, (iii) what conclusion it produces, (iv) the explicit gap to our calibration-defect target.

### A.1 Stability of constrained convex optimization

Bonnans–Shapiro, *Perturbation Analysis of Optimization Problems*. Stability of optimal value under perturbation of constraints; sensitivity formulas via Lagrange multipliers. Does this give a Lipschitz-style bound on optimal-value gap when calibration constraints are violated by $\Delta$?

### A.2 Hoffman's lemma / error bounds for systems of inequalities

Hoffman 1952 + descendants. For a polyhedral system $Ax \le b$, the distance to the feasible set is bounded by a constant times the violation. Does an infinite-dimensional analog apply to our calibration constraints (linear inequalities indexed by $v \in W$)?

### A.3 Quantitative Strassen / quantitative martingale OT

Recent work on quantitative versions of Strassen's theorem and martingale OT, where the feasibility gap is converted to a quantitative bound. Beiglböck–Nutz–Touzi and others. Does this give us $\Phi(\Delta)$ with $\Delta$ measuring deletion deficiency?

### A.4 Approximate persuasion / approximate Bayes-rational behavior

Has the persuasion literature (Doval–Skreta, Dworczak–Martini) developed approximate / quantitative versions where the sender achieves at most $\Phi(\Delta)$-suboptimal Bayes posteriors? What's $\Delta$ in their setting and is it primitive?

### A.5 Variational inequality and gap functions

The "gap function" in variational inequalities measures the minimum violation of optimality at a candidate point. Auchmuty, Fukushima. Does this technology adapt to a primitive deletion-defect on labeled menus?

### A.6 Concentration / regret bounds in robust decision theory

Aliprantis–Border, Castaing–Valadier. Robust statistics, distributionally robust optimization. Is there a "regret functional" that quantifies suboptimality of a strategy in primitive terms?

### A.7 Distance to incentive-compatibility

In mechanism design, "approximate incentive compatibility" theorems quantify how far a mechanism is from being IC (e.g., Carroll, Pai-Vohra). Some of these have primitive defect formulations. Does any apply to robust-trust calibration?

### A.8 Closure-memo bottleneck revisited

The closure memo names "deletion-compatible Hall duality" as the central bottleneck. Route 1's stall confirmed this. Does Route 2 dodge the bottleneck (via quantitative softness) or does the same bottleneck reappear in defect form?

## Output

For each section, identify:
- Closest theorem (cite specifically: author, year, theorem number);
- Whether hypotheses are primitive in our sense;
- Conclusion produced;
- Gap from the calibration-defect target.

Then **classify** Route 2: Apply / Adapt / Build.

**If Apply:** name the specific theorem; sketch the import.
**If Adapt:** name the closest theorem; sketch what adaptation is needed; estimate effort.
**If Build:** identify the most promising tools; sketch the missing object's hypotheses and conclusion.

Then **honest assessment** (one paragraph): is Route 2 viable? Does it dodge the (H_del) "tiny hinge" obstruction that killed Route 1? Or does the same bottleneck reappear in defect form?

## What you MUST NOT do

- Do not propose proofs.
- Do not claim Route 2 is alive based on "the literature is rich"; verify substance.
- Do not silently assume any version of menu-Hall in the candidate theorem.
- Do not extend standing assumptions silently.

## Output Format

```markdown
## Survey

### A.1 Stability of constrained convex optimization
- Closest theorem: ...
- Hypotheses (primitive?): ...
- Conclusion: ...
- Gap from our target: ...

### A.2 Hoffman / error bounds
...

### A.3 Quantitative Strassen / martingale OT
...

### A.4 Approximate persuasion
...

### A.5 Variational inequality / gap functions
...

### A.6 Robust decision theory / regret bounds
...

### A.7 Distance to IC
...

### A.8 Closure-memo bottleneck
...

## Gap Classification

- Verdict: Apply / Adapt / Build
- Justification: ...
- If Apply or Adapt: which theorem(s), and what work is needed.
- If Build: which tools are most promising.

## Verdict on Route 2

- Single-pass or multi-pass: ...
- Specific theorem(s) to invoke: ...
- (H_del) bottleneck: dodged / reappears in defect form / different obstruction.

## Honest Assessment

(One paragraph. Is Route 2 viable as a real theorem? Does it produce a publishable quantitative relaxation, or does the same bottleneck re-emerge?)
```

Length: 1500–2200 words.
