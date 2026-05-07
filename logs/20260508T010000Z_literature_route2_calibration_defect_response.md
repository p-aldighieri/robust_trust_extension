
========
ROLE: user (id=49af88aa-e970-467c-b711-465fa33c046a)
========
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


markdown
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


Length: 1500–2200 words.

Show more

========
ROLE: assistant (id=da2aa4b9-f60d-421a-ad02-9fe5d98566b1)
========
Survey
A.1 Stability of constrained convex optimization

Closest theorem: Bonnans and Shapiro (2000), Perturbation Analysis of Optimization Problems, Proposition 4.4 on continuity of the optimal value and Theorem 4.24 on directional value sensitivity via Lagrange multipliers. The surrounding framework is parametric constrained optimization in which a constraint set or right-hand side is perturbed and one asks how the value changes. 
Springer
+1

Hypotheses (primitive?): No. The theorem wants a fixed topological vector-space optimization problem, regularity of the feasible-map perturbation, compactness or inf-compactness, and multiplier stability. Our primitives are F,w
∗
,τ,α, labels, and compact source patches. The calibration constraints are not a pre-given Banach-space constraint map; they are generated by disintegration posteriors and Bayes-optimality cones.

Conclusion: If the calibration problem has already been written as a regular parametric convex program, this literature can turn a constraint perturbation of size Δ into a first-order or Lipschitz value bound, typically of the form “value loss ≤ multiplier norm × perturbation size.”

Gap from our target: It does not define the primitive defect. It would only be useful after Route 2 has already built a normed calibration residual and shown a constraint qualification. It also does not solve the sourcewise-deletion/messagewise-calibration mismatch or the Borel-to-compact patch issue.

A.2 Hoffman / error bounds

Closest theorem: Hoffman (1952), main error-bound theorem for finite systems of linear inequalities; Burke and Tseng (1996), Theorem 1 and Theorem 2, extending Hoffman-type bounds to cone systems in normed spaces; Hu and Wang (1989) and later infinite-system variants. Burke and Tseng explicitly frame the result as bounding distance to the solution set by a residual distance to a cone, with the polyhedral finite-dimensional case as the special Hoffman case. 
Math at Washington
+2
SIAM
+2

Hypotheses (primitive?): Partly, but only after translation. The theory is primitive for a fixed linear system Ax≤b, or Ax−a∈K. Our calibration constraints are semi-infinite, endogenous, and set-valued: the “right-hand side” depends on Bayes cones B(m), rowwise minimizer sets G(s), and the chosen label map.

Conclusion: A residual violation can control distance to feasibility. In a favorable finite-dimensional reduction, a Hoffman constant could give dist(x,F)≤HΔ, and then a Lipschitz payoff map could convert this to regret.

Gap from our target: The crucial constant is not primitive and can be infinite in semi-infinite systems. More importantly, Hoffman controls distance to a fixed feasible set. Route 2 needs a defect built from compact source-patch deletions and payoff-profile replacements, not merely a residual for an already-formalized Hall system. This is a toolkit, not an import.

A.3 Quantitative Strassen / martingale OT

Closest theorem: Strassen (1965) for existence of martingale couplings under convex order; Beiglböck, Nutz, and Touzi (2017), Theorem 1.1, complete duality for one-dimensional martingale optimal transport; Beiglböck, Jourdain, Margheriti, and Pammer (2022), Theorem 2.6, stability of martingale couplings in adapted Wasserstein distance. The 2022 paper states that a martingale coupling exists iff the marginals are in convex order and proves stability of martingale couplings under Wasserstein convergence, while also noting serious higher-dimensional breakdowns. 
Research Collection
+1

Hypotheses (primitive?): No, but close in spirit. These theorems are primitive for marginal distributions and convex-order constraints. Robust-trust calibration is instead a constrained transport from source beliefs s to messages m, with support restrictions m∈G(s) and posterior constraints P(⋅∣m)∈B(m).

Conclusion: In its native habitat, the literature converts exact or approximate convex-order feasibility into existence, stability, or duality statements for couplings. This resembles the desired Φ(Δ
del
	​

): a coupling defect should bound a feasibility or value gap.

Gap from our target: Existing quantitative Strassen/MOT results do not know about deletion patches or payoff-profile replacements. The support correspondence G(s) and Bayes cones B(m) make the object closer to a custom weak-transport/Hall problem than a standard martingale-coupling problem. The higher-dimensional warning matters because M⊆Δ(Ω) is typically multidimensional.

A.4 Approximate persuasion

Closest theorem: Doval and Skreta (2024), Theorem 3.1, finite-support sufficiency in constrained information design; Dworczak and Martini (2019), Theorem 1, a verification theorem for optimal persuasion using a convex “price” function; Dworczak and Kolotilin (2024), strong-duality results for persuasion when state spaces are finite or objective functions have enough regularity. 
NSF Public Access Repository
+2
giorgiomartini.com
+2

Hypotheses (primitive?): Persuasion-primitive, not robust-trust primitive. These papers work with Bayes-plausible distributions of posteriors, moment constraints, or dual price functions. They do not start from a labeled menu (C
∗
,w
∗
), sourcewise compact deletions, and primitive payoff-profile replacements.

Conclusion: The literature gives finite-support reductions, no-duality-gap theorems, and verification by dual certificates. It is valuable because Theorem 2 itself interprets the adversary as solving a constrained persuasion problem, and the paper explicitly uses that interpretation after robust rationalizability is obtained. 

Robust_trust_Dworczak_Smolin

Gap from our target: The approximate object in persuasion is usually approximation of a signal or value, not a calibration defect of a candidate labeled menu. It does not produce “best-attainable distributional Bayes-regret ≤Φ(Δ
del
	​

)” without first inventing the right defect and dual residual.

A.5 Variational inequality / gap functions

Closest theorem: Auchmuty (1989), variational principles for monotone variational inequalities; Fukushima (1992), regularized gap-function theorem; Larsson and Patriksson (1994), generalized gap functions for finite-dimensional variational inequalities. This literature formalizes a nonnegative gap γ(x) such that γ(x)=0 exactly at solutions. 
Springer
+1

Hypotheses (primitive?): No. A VI gap requires a fixed feasible set K, an operator F, and often compactness, monotonicity, or convexity assumptions. In Route 2, the feasible set itself is the calibrated adversarial transport compatible with G(s) and B(m), which is not primitive unless one has already solved the Hall translation.

Conclusion: Conceptually strong: a calibration-defect functional should look like a VI gap. It gives the right grammar for “zero iff exact Tier 2, positive iff approximate regret.”

Gap from our target: VI gap functions measure optimality violation, not necessarily distance or regret unless an error bound or coercivity condition is added. The technology helps name Δ
del
	​

; it does not by itself prove the Bayes-regret bound.

A.6 Robust decision theory / regret bounds

Closest theorem: Aliprantis and Border (2006), Theorem 17.31 on measurable maximum/Berge-type selection and Theorem 18.13 on Kuratowski-Ryll-Nardzewski measurable selection; Castaing and Valadier (1977), Castaing representation theorem for measurable multifunctions. These are not regret theorems, but they are the canonical measurable-selection tools underneath robust decision constructions. 
Wikipedia
+2
ResearchGate
+2

Hypotheses (primitive?): Selection hypotheses are close to the standing model because A,Θ are compact metric and all objects are Borel. But regret bounds in robust statistics or distributionally robust optimization usually require a chosen ambiguity metric, Lipschitz loss, or concentration inequality. None is present in bare robust trust.

Conclusion: Selection theory can realize payoff-profile labels and measurable replacements. It supports the menu-engine view already used in v8, where Tier 1a obtains value-optimal σ
∗
 and ε-adversaries under standing hypotheses. 

project_closure_memo

Gap from our target: It does not quantify calibration failure. Robust decision-theory regret bounds are generally metric-ambiguity bounds, while Δ
del
	​

 is intended to be a deletion/replacement defect. Same toolbox shelf, different lock.

A.7 Distance to IC

Closest theorem: Balseiro, Besbes, and Castro, “Mechanism Design under Approximate Incentive Compatibility,” Theorem 1 on bounding the value gap between ε-IC and IC mechanisms, Theorem 2 on deterministic mechanisms, and Theorem 3 on lower bounds. Carroll (2012), Proposition 5 and Proposition 6, gives local-to-global IC results and counterexamples by domain. Azevedo and Budish (2019) develop strategy-proofness-in-the-large as an approximate IC criterion. 
arXiv
+2
Kyle Woodward
+2

Hypotheses (primitive?): These are primitive for mechanism design: type spaces, allocation rules, transfers, and IC inequalities are fixed. They are not primitive for robust trust. Still, this is the closest methodological cousin: take exact equilibrium inequalities, relax by ε, then bound the objective loss.

Conclusion: This literature really does produce quantitative “distance from incentive constraints implies bounded performance loss” theorems. It validates the Route 2 shape.

Gap from our target: IC inequalities are reportwise and fixed. Robust-trust calibration is a transport/disintegration constraint with sourcewise minimizer support and messagewise Bayes cones. Approximate IC does not supply the missing deletion-compatible Hall object; it only tells us such a theorem would be a natural species, not a captured specimen.

A.8 Closure-memo bottleneck

Closest theorem: None currently. The closure memo identifies the missing object as a deletion-compatible Hall duality theorem: existing Hall constraints are messagewise, while deletion arguments are sourcewise, and the missing dual would have to price source deletions while enforcing message calibration. It also flags the Borel-to-compact gap: deleting a positive-measure Borel set need not shrink the compact closure of the label image. 

project_closure_memo

Hypotheses (primitive?): This is exactly the primitive axis. v8’s Tier 2 works under exact-contact plus menu-Hall, but the memo records that menu-Hall is scope-changing because it installs the calibration Definition 2 demands rather than deriving it. 

project_closure_memo

Conclusion: Route 2 does dodge the Route 1 contradiction architecture. It does not need pointwise-strict (H
del
	​

) to become uniform. But it must still quantify how far the sourcewise deletion/replacement system is from messagewise Bayes calibration.

Gap from our target: The gap is the theorem. The defect must not merely rename menu-Hall. It must be computable from F,w
∗
,τ,α and compact source patches, and it must bound distributional Bayes-regret even when continuum mass and Borel-to-compact effects survive.

Gap Classification

Verdict: Build.

Justification: No surveyed theorem directly yields the calibration-defect theorem under primitive-equivalent hypotheses. The closest bodies each grab one handle: Hoffman gives residual-to-distance, Strassen/MOT gives transport feasibility and duality, VI gives a gap-function language, persuasion gives dual prices, and approximate IC gives the right quantitative philosophy. None handles the exact robust-trust object: sourcewise compact-patch deletions plus messagewise Bayes-cone calibration over an endogenous labeled menu.

If Apply or Adapt: Not applicable as a single import. The closest adaptation template would combine Burke-Tseng/Hoffman error bounds with weak-transport or Strassen duality, then express the resulting residual as a VI-style gap.

If Build: The most promising tools are: a quantitative Hall/transport dual for kernels supported on G(s); a Hoffman-type calmness bound for the resulting semi-infinite linear inequalities; and a VI-style primitive gap functional whose zero set is exact Tier 2. The defect must absorb continuum-mass and Borel-to-compact errors explicitly rather than sweeping them into regularity assumptions.

Verdict on Route 2

Single-pass or multi-pass: Multi-pass. The first pass should define Δ
del
	​

 and test renaming resistance; the second should derive a dual or error-bound representation; the third should translate defect to distributional Bayes-regret.

Specific theorem(s) to invoke: Burke and Tseng (1996), Theorem 1 or 2, as error-bound architecture; Beiglböck, Nutz, and Touzi (2017), Theorem 1.1, plus Beiglböck et al. (2022), Theorem 2.6, as transport-duality/stability architecture; Fukushima/Auchmuty gap functions as defect grammar; Balseiro, Besbes, and Castro, Theorems 1-3, as the approximate-constraint-to-value-gap analogue.

(H
del
	​

) bottleneck: Dodged in its tiny-hinge form, but reappears in defect form. Route 2 no longer needs to extract a uniform strict deletion contradiction. It does need a quantitative replacement for the missing deletion-compatible Hall duality.

Honest Assessment

Route 2 is viable as a real theorem, but not as a literature corollary. The publishable version would be a new calibration-defect theorem that imports known machinery without being swallowed by it. The good news is that the fatal Route 1 hinge, pointwise strictness without uniform slack, is no longer fatal: a positive Δ
del
	​

 can simply produce positive regret. The harder news is that the old Hall beast is still in the tunnel, just wearing a measuring tape. Unless Δ
del
	​

 genuinely prices the sourcewise deletion versus messagewise calibration mismatch, the theorem will either be false or tautological. The most honest classification is Build, with strong adaptation ingredients and a clear missing object.
