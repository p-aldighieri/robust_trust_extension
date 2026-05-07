
========
ROLE: user (id=1728f9e2-8498-4ed6-9271-8ac6933ef158)
========
# Literature pass — Route 1: deletion-compatible Hall duality

You are the **Literature** role in the soft-scaffolding workflow. The fresh gatekeeper just identified Route 1 as the only genuinely-new attack surface aimed at unrestricted Theorem 2 in the Robust Trust extension project. The next step before a prover commits is a focused literature search: does a deletion-compatible Hall duality theorem already exist or sit close enough to existing tools that it can be assembled rather than built from scratch?

## What the missing theorem looks like

**Form sought.** A duality theorem whose hypotheses are stated in primitive terms — F(C), the labeled payoff map $w^*: M \to W$, $\tau$, and compact source patches — and whose conclusion is the existence of a **calibrated joint law** $\gamma$ on $M \times M$ (or on source × message × induced-posterior triples).

**Forbidden hypotheses (renaming-test failures).** The theorem must NOT assume:
- existence of a kernel $\kappa$ supported on rowwise minimizers $G(s)$,
- any disintegration posterior membership condition $P_\gamma(\cdot \mid m) \in B(m)$,
- any direct Bayes-cone inclusion at messages.

**Required structural ingredients.** A viable theorem must bridge three gaps the Strategy 3 A.2 stall named:
1. **Label-saturation:** when a deletion happens, all old C*-minimizers for the affected source must be removed (or accounted for).
2. **Sourcewise/messagewise index resolution:** the theorem's dual must price deletion sourcewise while enforcing calibration messagewise.
3. **Borel→compact stability:** the deletion event on a τ-positive Borel set must produce a genuine compact patch removal in the labeled image, not just a Borel restriction with closure unchanged (fat-Cantor-style pathologies are forbidden).

The natural primitive hypothesis is a **sourcewise deletion-stability inequality**: for every compact $D \subsetneq C^*$ and every Borel $E \subseteq M$ such that $\overline{c(M\setminus E)} = D$,
$$F(D) - F(C^*) < 0,$$
i.e., behaviorally minimal $C^*$ is improvement-deficient. The conclusion would be: this primitive deficiency forces existence of a calibrated joint law (i.e., menu-Hall holds).

## Your task

Survey the relevant literature and report what is known, what is close, and what is not yet on the shelf. Specifically:

### Section A — Adjacent theorems already on the shelf

For each of the following bodies of work, identify (i) the closest existing duality theorem, (ii) whether its hypotheses are primitive in our sense, (iii) what conclusion it produces, and (iv) the explicit gap between it and our target.

1. **Strassen's theorem (1965) and Kellerer's theorem (1984).** Mass transportation with marginal constraints; balayage and martingale order. Does any version handle support constraints (rowwise minimizers) plus disintegration constraints (Bayes cones)?

2. **Weak optimal transport (Gozlan–Roberto–Samson–Tetali; Backhoff-Veraguas–Beiglböck–Pammer).** Costs depending on conditional laws. Does the existence/duality theory give a calibrated joint law from primitive cost-deficiency?

3. **Martingale optimal transport (Beiglböck–Henry-Labordère–Penkner; Beiglböck–Juillet).** Constraints that the conditional barycenter equal a target. Is there a moment-constrained variant where the conditional law is required to lie in a cone, not just have a fixed mean?

4. **Capacity-constrained / dominated optimal transport (Korman–McCann; Ghoussoub–Kim–Lim; Backhoff-Veraguas–Beiglböck–Eder–Pichler).** Plans dominated by a capacity. The truthful-aligned $\alpha (id, id)_\# \tau$ is a domination constraint of this type — does this body of work yield calibration directly?

5. **Adapted / causal optimal transport (Pflug–Pichler; Backhoff-Veraguas–Bartl–Beiglböck–Eder).** Filtration-respecting transport. Could the message-then-posterior structure be encoded as a two-step adapted transport?

6. **Cyclic-monotonicity-style optimality conditions for transport.** Are there cyclic-monotonicity or *c*-cyclical-monotonicity duals that can encode "no profitable deletion"?

7. **Bayesian persuasion / information-design duality (Kamenica–Gentzkow; Doval–Skreta; Dworczak–Martini).** The robust-trust problem is itself a persuasion-like problem. Is there a duality statement in the persuasion literature that bridges deletion stability and posterior calibration?

### Section B — Gap classification

After surveying the above, classify the missing theorem:
- **(Apply)** An existing theorem applies more or less directly with primitive-equivalent hypotheses; specify which one and what mild adaptation is needed.
- **(Adapt)** An existing theorem has the right shape but its hypotheses or conclusions are not primitive enough; specify the adaptation needed and estimate difficulty.
- **(Build)** No existing theorem comes close; the missing object is a genuinely new duality theorem. Specify which mathematical tools (variational, c-cyclical monotonicity, Lagrangian/dual-potential, capacity-constrained, weak-transport disintegration) are most likely to produce it.

### Section C — Verdict on Route 1 viability

Given Sections A and B, state honestly:
- Is Route 1 viable as a one-pass prover task, or does it need decomposition into multiple proof passes?
- If viable in one pass, what specific theorem from the literature should the prover try to invoke or adapt?
- If multi-pass, what is the minimum sequence of proof passes needed?
- Is there a dominant risk that the route is alive in form but produces a primitive condition equivalent to menu-Hall (renaming failure)? If so, name the early test that would detect this.

## What you MUST do

- Cite specific theorems and authors. Be concrete. "Strassen-style" is not a citation; "Strassen 1965 Theorem 7" or "Kellerer 1984, Lemma 2.3" is.
- Apply the renaming test to each candidate theorem.
- Distinguish "the literature has the theorem" from "the literature has the tools to build it."
- Report negatively when warranted: if a body of work is adjacent in name but unhelpful in substance, say so.

## What you MUST NOT do

- Do not propose a new proof. That is the prover's job.
- Do not invent theorems with vague hypotheses.
- Do not declare Route 1 alive based on "the literature is rich"; verify substance.
- Do not extend the standing assumptions silently.

## Output Format


markdown
## Survey

### A.1 Strassen / Kellerer
- Closest theorem: ...
- Hypotheses (primitive?): ...
- Conclusion: ...
- Gap from our target: ...

### A.2 Weak optimal transport
...

### A.3 Martingale OT
...

### A.4 Capacity-constrained OT
...

### A.5 Adapted/causal OT
...

### A.6 Cyclic monotonicity duals
...

### A.7 Persuasion duality
...

## Gap Classification

- Verdict: Apply / Adapt / Build
- Justification: ...
- If Apply or Adapt: which specific theorem(s), and what work is needed.
- If Build: which tools are most promising.

## Verdict on Route 1

- Single-pass or multi-pass: ...
- Specific theorem to invoke (if applicable): ...
- Sequence of proof passes (if multi-pass): ...
- Renaming-failure risk and detection test: ...

## Honest Assessment

(One paragraph. If Route 1 is best-pursued as a literature import, say so and name the import. If it is genuinely a build job, say so and name the most promising tool. If the survey reveals an unexpected obstacle, surface it.)


Length: 1500–2200 words.

Show more

========
ROLE: assistant (id=414529ec-2857-4943-a449-a4cccdf5c44a)
========
Survey
A.1 Strassen / Kellerer

Closest theorem: Strassen’s 1965 marginal theorem is the cleanest ancestor: in particular, Strassen, The Existence of Probability Measures with Given Marginals, Theorem 7, gives a dual feasibility criterion for existence of a probability measure with prescribed marginals inside a weakly closed convex class of measures. Modern expositions restate it as: for Polish spaces and a weakly closed convex set Λ⊆P(E×F), a coupling in Λ with marginals μ,ν exists iff all continuous marginal test functions satisfy the associated support-function inequality. 
emis.de
 Kellerer’s 1984 Duality theorems for marginal problems, especially Theorem 2.14, pushes the same architecture to Suslin functions and marginal problems via Choquet capacitability; Section 3.2 explicitly treats two-marginal problems with support restrictions and situates Strassen-type theorems inside that framework. 
Springer Link

Hypotheses (primitive?): Partly, but not enough. The marginal τ, the diagonal truthful component, and compact support patches can be primitive. But the moment one sets Λ to “plans supported on G(s) whose message disintegrations have posteriors in B(m),” the theorem fails the renaming test. It assumes the very rowwise-minimizer kernel and Bayes-cone calibration the project is trying to derive.

Conclusion: A coupling or measure satisfying prescribed marginals and the predeclared convex/support constraints, plus a separating-potential dual if none exists.

Gap from our target: Strassen/Kellerer can certify feasibility once the admissible set is declared. They do not turn a primitive sourcewise deletion-stability inequality for F(D)−F(C
∗
) into a calibrated joint law. The missing bridge is exactly the source/message split: deletion is priced by source s, while calibration is checked after message m. The closure memo names this as the central bottleneck: existing Hall constraints are messagewise, whereas deletion arguments are sourcewise and must also handle the Borel-to-compact gap. 

project_closure_memo

A.2 Weak optimal transport

Closest theorem: Backhoff-Veraguas, Beiglböck, and Pammer, Existence, duality, and cyclical monotonicity for weak transport costs, Theorems 1.1, 1.2, and 1.3. Their weak OT problem minimizes ∫C(x,π
x
	​

)μ(dx), so the cost depends on the conditional law π
x
	​

. They prove existence and duality on Polish spaces, and Theorems 5.2 and 5.5 give a weak-transport cyclic-monotonicity criterion. 
Faculty of Mathematics
 Gozlan, Roberto, Samson, and Tetali’s Kantorovich duality for general transport costs is the broader predecessor, including weak costs depending on conditional laws. 
Prasad Tetali

Hypotheses (primitive?): Not in the required sense. Weak OT’s conditional-law cost is temptingly close to “posterior after message,” but to use it directly one must build C so that forbidden Bayes-cone violations receive infinite cost or penalties. That encodes B(m) and thus fails the renaming test unless the deletion inequality alone is shown to generate that cost.

Conclusion: Existence of an optimal weak transport plan, a dual formula, and weak C-monotonicity.

Gap from our target: Weak OT optimizes over fixed marginals. Our target is a feasibility theorem for a joint law whose second marginal is endogenous and whose disintegration posterior must land in a cone produced by the labeling w
∗
. Worse, BBP explicitly note that the ordinary “restriction property” can fail in weak transport, which is exactly the sort of patch-deletion stability Route 1 needs. 
Faculty of Mathematics
 Weak OT is a strong toolbox, not a shelf theorem.

A.3 Martingale optimal transport

Closest theorem: The martingale existence theorem behind martingale OT is Strassen’s convex-order theorem: martingale couplings exist iff marginals are ordered in convex order. Beiglböck, Henry-Labordère, and Penkner, Model-independent bounds for option prices, Theorem 1, then gives no duality gap and primal attainment for lower semicontinuous payoffs with martingale marginal constraints. 
arXiv
 Beiglböck and Juillet’s left-curtain theory adds canonical martingale couplings and variational structure in one dimension, notably their variational lemma and shadow/left-curtain construction. 
arXiv

Hypotheses (primitive?): Primitive only for barycenter constraints. The martingale condition E[Y∣X]=X is a clean conditional moment identity. Our condition is set-valued and message-indexed: the conditional source barycenter after message m must lie in the Bayes-optimality cone B(m). Encoding that as “martingale into a cone” again installs the calibration object.

Conclusion: Existence and duality for martingale couplings, sometimes with structural monotonicity or canonicality.

Gap from our target: Martingale OT handles a fixed conditional mean. Route 1 needs a conditional law whose barycenter is not fixed by the source point but constrained by the received message label. There are moment-constrained and quasi-sure martingale dualities, but they do not solve the deletion-compatible Hall problem unless one first writes calibration as an explicit constraint, which is menu-Hall in fresh clothing.

A.4 Capacity-constrained / dominated OT

Closest theorem: Korman and McCann’s Optimal transportation with capacity constraints, especially Theorem 3.1, proves existence of optimal plans among joint densities h with prescribed marginals and domination 0≤h≤
h
ˉ
. 
U of T Mathematics
 Korman, McCann, and Seis later prove existence of dual potentials for the capacity-constrained problem under L
∞
 capacity assumptions, building on Levin duality. 
U of T Math Department

Hypotheses (primitive?): The diagonal truthful component α(id,id)
#
	​

τ resembles a domination or prescribed-mass constraint, but the resemblance is only half the spell. Capacity OT assumes fixed marginals and a capacity 
h
ˉ
. In Robust Trust the mixture law is α truthful plus (1−α) adversarial, the second marginal is induced, and the posterior cone is a disintegration condition.

Conclusion: Optimal dominated plans and dual potentials for capacity prices.

Gap from our target: Capacity OT can price “how much mass may flow through a cell.” It does not say “if deleting every compact patch fails to improve F, then there exists a plan supported on rowwise minimizers and calibrated at messages.” It is useful for the truthful-aligned lower/fixed component, not for the Bayes-cone conclusion.

A.5 Adapted / causal optimal transport

Closest theorem: Backhoff-Veraguas, Beiglböck, Lin, and Zalashko, Causal transport in discrete time and applications, introduce causal couplings and prove dynamic-programming and structural results for nonanticipative transport. 
arXiv
 Adapted Wasserstein/process-distance work by Backhoff-Veraguas, Bartl, Beiglböck, and Eder develops the adapted topology for laws of stochastic processes. 
Faculty of Mathematics

Hypotheses (primitive?): No. One can model source → message → posterior as a two-step process, but the filtration constraint only says information arrives in order. It does not derive that posterior beliefs must fall in B(m), nor that rowwise minimizers must be saturated under deletion.

Conclusion: Existence, stability, duality, and dynamic programming for causality/nonanticipativity constraints.

Gap from our target: Adapted OT supplies a language for sequential structure, not the Hall theorem. It would be an encoding layer, perhaps a useful loom, but not the missing cloth.

A.6 Cyclic-monotonicity-style optimality conditions

Closest theorem: Classical c-cyclical monotonicity gives optimality of transport supports under Kantorovich duality. In weak OT, BBP’s Definition 5.1 and Theorems 5.2/5.5 give a conditional-law version: finite families of source points and replacement conditional measures are compared by the weak cost. 
Faculty of Mathematics

Hypotheses (primitive?): Usually not. Cyclic monotonicity is an optimality condition relative to a cost or feasible class already chosen. If the cost/class contains G(s), B(m), or posterior calibration, the renaming test catches it.

Conclusion: “No improving finite rearrangement,” often equivalent to optimality under the relevant duality.

Gap from our target: Route 1’s deletion is not just a finite cycle. It must delete a Borel set, saturate all old C
∗
-minimizers for affected sources, resolve sourcewise prices against messagewise calibration, and convert a Borel deletion into a compact labeled-image shrink. Cyclic monotonicity may be a local diagnostic after a candidate γ exists. It does not produce γ from primitive deletion deficiency.

A.7 Persuasion / information-design duality

Closest theorem: Kamenica and Gentzkow’s Bayesian persuasion concavification/splitting result reduces optimal persuasion to choosing a Bayes-plausible distribution of posterior beliefs. 
NBER
 Doval and Skreta’s constrained information-design theory is closer: Theorem 3.1 rewrites constrained information design as concavification of a modified objective, and Theorem 3.2 gives weak duality and no duality gap under their regularity conditions. 
NSF Public Access Repository
 Dworczak-Martini and Dworczak-Kolotilin develop price-theoretic persuasion duality, where dual prices/supergradients support optimal posterior distributions. 
Chicago Journals
+1

Hypotheses (primitive?): Not for this route. Persuasion duality is primitive about Bayes plausibility, but constrained persuasion imposes constraints. If the constraint is “posterior after m lies in B(m)” or “truthful component at least α,” it is a direct Bayes-cone inclusion, forbidden by the prompt.

Conclusion: Bayes-plausible posterior distributions, dual multipliers, finite-support bounds, and Lagrangian characterizations.

Gap from our target: Persuasion is conceptually closest to Robust Trust; the paper itself reads the adversary as choosing a constrained Bayes-plausible posterior distribution in the finite equilibrium interpretation. But the literature does not derive messagewise calibration from sourcewise deletion minimality. It assumes the information constraints and prices them. The v8 project state already isolates Tier 2 as needing exact-contact plus menu-Hall, while the open question is whether menu-Hall can be derived from primitive structure rather than assumed. 

theorem_2_extension_proof_v8

Gap Classification

Verdict: Build.

Justification: No surveyed theorem applies with primitive-equivalent hypotheses. The closest existing mathematics is Strassen/Kellerer marginal feasibility plus weak-OT disintegration duality plus constrained-persuasion Lagrange pricing. That triad has the right bones, but the living creature is missing: a duality that converts primitive sourcewise deletion deficiency into a messagewise calibrated joint law. The project record confirms the existing menu-engine endpoint: value optimality and ε-adversaries are unconditional, exact adversary needs exact-contact, and robust rationalizability currently needs menu-Hall; whether menu-Hall follows from primitive conditions remains open. 

theorem_2_extension_proof_v8

If Apply or Adapt: Not applicable. The strongest possible “Adapt” candidate would be Kellerer Theorem 2.14 or Strassen Theorem 7 applied to a convex set of joint laws with support and cone constraints. But that adaptation would put G(s) and B(m) into the admissible set. That is precisely a renaming failure.

If Build: Most promising tools are: Kellerer/Strassen separation for marginal feasibility; weak OT’s conditional-law formulation and extended-space embedding; constrained-persuasion dual potentials for Bayes-plausibility pricing; and a new compact-regularization lemma turning positive Borel deletion into a genuine compact patch shrink. Capacity constraints may help handle the fixed truthful diagonal component, but they are secondary. Cyclic monotonicity is likely a verification or local optimality tool, not the main engine.

Verdict on Route 1

Single-pass or multi-pass: Multi-pass. Route 1 is viable as a research route, but not as a one-pass prover task. The missing theorem has three nontrivial moving gears, each capable of throwing a tiny brass screw into the machinery: label-saturation, source/message index resolution, and Borel-to-compact stability.

Specific theorem to invoke: None applies directly. The prover should not try to invoke Sion/Tychonoff or the prior full-kernel saddle route; the prior digest records that the product-topology Sion attempt fails because continuity in β would require continuity in message m, which the strategy topology does not provide. 

prior_attempts_digest

 The only plausible imported skeleton is “Strassen/Kellerer separation for a convex feasible set,” but it must be rebuilt so the separating functional becomes a deletion certificate rather than a disguised menu-Hall inequality.

Sequence of proof passes:

Feasibility formalization pass: Define the desired γ using only F(C), w
∗
, τ, α, and compact source patches. No G(s)-kernel existence, no P
γ
	​

(⋅∣m)∈B(m) assumption.

Dual-separation pass: Prove a Strassen/Kellerer-style alternative for nonexistence of γ, with dual variables that separate by source deletion and message calibration simultaneously.

Deletion interpretation pass: Show any separating certificate yields a genuine compact D⊊C
∗
 with 
c(M∖E)
	​

=D and F(D)−F(C
∗
)<0, including label-saturation of all old minimizers.

Regularization pass: Close the Borel-to-compact gap. A positive Borel deletion whose closure does not shrink must not be allowed to masquerade as progress.

Renaming-failure risk and detection test: Dominant risk: the theorem may be alive formally but equivalent to menu-Hall in costume. The early test is brutal and simple: inspect the “primitive” hypotheses and the dual alternative. If either mentions a kernel supported on G(s), a disintegration posterior condition P
γ
	​

(⋅∣m)∈B(m), or a support-function inequality involving h
B(m)
	​

, it has smuggled in the conclusion. A second test: the dual certificate must delete source patches and shrink the compact labeled image; if it only prices messages, it does not resolve the source/message mismatch.

Honest Assessment

Route 1 is not a literature import. The shelf has excellent ingredients, but not the completed theorem. Strassen and Kellerer provide the right separation grammar; weak OT provides the conditional-law syntax; martingale OT shows how barycenter constraints can be dualized; persuasion duality provides the economic price language. None of them bridges primitive deletion-stability to calibrated posterior existence without inserting calibration as a constraint. The route is worth pursuing precisely because it is the first attack surface that targets the real remaining obstruction, but it should be decomposed into proof passes. Treat it as a build job with Kellerer-Strassen bones and weak-transport connective tissue, not as a theorem hiding under a familiar hat.
