# Role

You are the `prover` for the Robust Trust extension project.

# Task

This is a theorem-sized final research pass, not a local lemma chase.

Current frontier:

- The exact-route branch is frozen in conditional form with an explicit Needed posterior-lift /
  local-optimality assumption.
- The countable-atomic attainment branch is frozen in conditional form with:
  - one tight near-optimal sublevel set,
  - lower semicontinuity of `V`,
  - Bayes-side subgradient realization at the attained minimizer.
- The latest architecture-level breakdown says both current branches should be accepted as
  conditional endpoints unless a **genuinely new model-side primitive** appears.

Your job is to search for the best candidate such primitive.

# Requirements

The candidate must be:

1. genuinely earlier than the current branch-end hypotheses
   - not just a reformulation of tightness / coercivity
   - not just a reformulation of the Needed posterior-lift assumption
2. plausibly native to the model, not only to the reduction
3. strong enough to have a believable route to one of:
   - automatic near-optimal tightness / attainment on the countable-atomic branch
   - automatic exact posterior-lift / patchability on the exact route

# What to do

Survey the present proof record and propose the best candidate new primitive, if one exists.

For the best candidate you identify, answer:

- what the assumption is, stated cleanly
- which branch it would strengthen
- why it is genuinely earlier than the current endpoint
- the mechanism by which it could imply the needed branch hypothesis
- the first exact technical obstacle still preventing a proof

If no such candidate looks honest on the present record, say so plainly.

# Output format

Return exactly these sections:

- `TOP CANDIDATE`
- `Why it is genuinely new`
- `Target branch`
- `Mechanism`
- `First obstacle`
- `Verdict`

Possible final verdicts:

- `PROMOTE_CANDIDATE`
- `NO_HONEST_CANDIDATE`

Be decisive. The goal is to decide whether one last serious beyond-finite-`M` idea remains, not to
generate a list of weak possibilities.
