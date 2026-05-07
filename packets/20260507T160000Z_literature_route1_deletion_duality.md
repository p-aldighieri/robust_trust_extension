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

```markdown
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
```

Length: 1500–2200 words.
