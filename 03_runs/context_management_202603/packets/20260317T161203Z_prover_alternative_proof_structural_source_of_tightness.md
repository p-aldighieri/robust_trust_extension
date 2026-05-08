# Role

You are the `prover` for the Robust Trust extension project.

# Task

Work at theorem scale. Do **not** do another tiny local lemma unless it is clearly the unique hinge of a larger theorem statement.

We already know on the active countable-atomic attainment route:

- unconditional attainment fails by escape of mass
- the clean surviving positive theorem is:
  - if there exists `eta > 0` such that
    - `A_eta := { beta in K : V(beta) <= inf_K V + eta }`
    is rowwise uniformly tight,
  - and `V` is lower semicontinuous,
  - then `V` attains its infimum on `K := prod_{mu in I} Delta(M)`
  - then, with the explicit Bayes-side subgradient-realization caveat, the selector/subgradient corollary gives rowwise equal-payoff-on-support

We also just learned that the proposed reduced-form coercive finite-set capture condition is **not** genuinely more primitive on this branch: it is theorem-equivalent to the one-tight-sublevel hypothesis, not earlier structural content.

Your job is to use the attached **finite-case alternative proof formalization** to search for a genuinely earlier structural condition that could plausibly imply the countable-atomic tightness package.

# What to do

Using the attached files, give one substantive theorem-design answer:

1. Identify the exact places in the finite alternative proof where finiteness of `M` is doing real work beyond bare convexity/subgradient arguments.
2. From that analysis, propose the best candidate **structural** countable-atomic hypothesis that is genuinely earlier than the current tightness/coercivity package.
3. Argue carefully whether that candidate really implies the needed tight near-optimal sublevel-set condition.
4. If no genuinely earlier condition is visible from the alternative-proof architecture, say so cleanly and explain why the current honest theorem endpoint should remain:
   - tight near-optimal sublevel set
   - lower semicontinuity
   - Bayes-side subgradient realization
5. End with a concrete branch recommendation:
   - `PROMOTE` if you found a credible earlier structural condition worth making the new theorem statement
   - `HOLD` if the current conditional theorem should remain the honest branch endpoint
   - `PIVOT` if the alternative-proof architecture suggests a different branch entirely

# Output format

Return a compact theorem-design memo with exactly these sections:

- `VERDICT`
- `Where finiteness enters`
- `Best candidate earlier condition`
- `Does it imply tightness?`
- `Recommended theorem statement`
- `Next move`

Be explicit about what is proved, what is heuristic, and what is still open.
