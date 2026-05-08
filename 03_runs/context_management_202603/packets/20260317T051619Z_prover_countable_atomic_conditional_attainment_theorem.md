# Prompt Packet: prover

Branch: `beyond_finite_M`

## Scope Of This Move

Write the actual theorem-sized replacement on the active countable-atomic attainment route.

Do not hunt new obstructions. Do not go back to recurrence. Do not nibble at local lemmas.

## Goal

Produce a clean conditional attainment theorem for countable atomic `M`, using the now banked reviewer verdict:

- unconditional attainment under the standing hypotheses is false by escape of mass
- the exact surviving positive mechanism is tightness / coercivity of near-optimal sublevels
- once attainment holds, the already-banked selector/subgradient proposition takes over

## Trusted Inputs

- route switch reviewer:
  - `Context Management/logs/20260317T024204Z_reviewer_countable_atomic_attainment_route_response.md`
- conditional selector/subgradient proposition:
  - `Context Management/logs/20260317T033200Z_prover_countable_atomic_conditional_selector_subgradient_proposition_response.md`
- attainment obstruction prover:
  - `Context Management/logs/20260317T041000Z_prover_countable_atomic_attainment_theorem_response.md`
- attainment obstruction/tightness reviewer:
  - `Context Management/logs/20260317T044512Z_reviewer_countable_atomic_attainment_obstruction_and_tightness_response.md`
- active route memo:
  - `Context Management/source_notes/countable_atomic_attainment_route.md`
- durable proof state:
  - `Context Management/source_notes/proof_state.md`

## Task

Write the clean conditional theorem that should now replace the failed unconditional attainment claim.

You should work in:

- `X := prod_{mu in I} l^1(M)`
- `K := prod_{mu in I} Delta(M) subset X`

for countable atomic `M` and finite `I`.

The theorem should use the reviewer-cleared sharper hypothesis:

- there exists `eta > 0` such that the near-optimal sublevel set
  - `A_eta := { beta in K : V(beta) <= inf_K V + eta }`
  is rowwise uniformly tight

and not the looser “every near-minimizing sequence is tight” wrapper unless you explicitly derive one from the other.

## Required Deliverable

Return a theorem-scale proposition plus proof sketch with these three pieces connected coherently:

1. `Conditional attainment theorem`
   - state the precise hypothesis
   - prove attainment of `inf_K V`
   - use only the compactness mechanism actually justified on the record
   - continuity of `V` may be replaced by lower semicontinuity if that is enough

2. `Selector/subgradient corollary`
   - explain exactly how the already-banked selector/subgradient proposition plugs in once a minimizer `beta*` exists
   - isolate any additional caveat that still remains explicit

3. `Final theorem shape`
   - state the resulting least-strengthened beyond-finite-`M` theorem on this route
   - make clear what is unconditional, what is conditional, and what remains open

## Hard Constraints

- Do not search for another counterexample.
- Do not return to the direct countable-atomic recurrence route.
- Do not propose five different options.
- Produce one coherent theorem package.
- Be explicit about where lower semicontinuity is sufficient and where Bayes-side subgradient realization is still needed.

## Required Output

Return only substantive markdown.

Start with exactly one of:

- `PASS`
- `FAIL`

Then give exactly these sections:

1. `Conditional attainment theorem`
2. `Proof skeleton`
3. `Selector/subgradient corollary`
4. `Resulting theorem statement`
5. `Remaining open point`

End with one line beginning exactly:

`Suggested next macro action:`

## Proof-State Update Target

`Context Management/source_notes/proof_state.md`
and
`Context Management/source_notes/countable_atomic_attainment_route.md`
