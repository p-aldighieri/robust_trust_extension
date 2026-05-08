# Prompt Packet: prover

Branch: `beyond_finite_M`

## Scope Of This Move

The conditional theorem package on the countable-atomic attainment route is now banked.

Do not reopen that package. Do not revisit recurrence. Do not search for another escape-of-mass counterexample.

The only live theorem-level question now is:

- what primitive message-coercivity / inf-compactness condition forces one rowwise uniformly tight near-optimal sublevel set?

## Goal

Identify the weakest natural primitive hypothesis you can justify on the current route that implies:

- there exists `eta > 0` such that
  - `A_eta := { beta in K : V(beta) <= inf_K V + eta }`
  is rowwise uniformly tight.

This should be theorem-design work, not another tiny lemma.

## Trusted Inputs

- reviewer-cleared branch endpoint:
  - `Context Management/logs/20260317T054612Z_reviewer_countable_atomic_conditional_attainment_theorem_response.md`
- conditional theorem package:
  - `Context Management/logs/20260317T051619Z_prover_countable_atomic_conditional_attainment_theorem_response.md`
- attainment obstruction/tightness reviewer:
  - `Context Management/logs/20260317T044512Z_reviewer_countable_atomic_attainment_obstruction_and_tightness_response.md`
- selector/subgradient proposition:
  - `Context Management/logs/20260317T033200Z_prover_countable_atomic_conditional_selector_subgradient_proposition_response.md`
- active route memo:
  - `Context Management/source_notes/countable_atomic_attainment_route.md`
- durable proof state:
  - `Context Management/source_notes/proof_state.md`
- alternative proof formalization:
  - `Theorem_alternative_proof/alternative_proof_formalization.tex`

## Task

Work at theorem scale and propose the best primitive sufficient condition for tightness on this route.

You must do all of the following:

1. propose one main primitive hypothesis, stated in model/reduced-form terms rather than directly as "tightness of `A_eta`"
2. explain why it is not tautological
3. prove or at least tightly justify that it implies one tight near-optimal sublevel set
4. compare it briefly to stronger or less natural alternatives
5. say whether this should become the new main beyond-finite-`M` theorem statement on this branch

Natural candidate shapes may include:

- message-coercivity / tail value gaps
- inf-compactness of the reduced cost profile over message labels
- a uniform finite-set capture condition stated directly on the reduced objective

But do not just list options. Pick one best theorem candidate and defend it.

## Hard Constraints

- Do not state the theorem using tightness itself as the main assumption unless you first prove no better primitive condition is available.
- Do not go back to the direct recurrence branch.
- Do not give multiple unrelated theorem designs.
- Give one main candidate theorem.

## Required Output

Return only substantive markdown.

Start with exactly one of:

- `PASS`
- `FAIL`

Then give exactly these sections:

1. `Best primitive hypothesis`
2. `Why it is not tautological`
3. `Why it implies tightness`
4. `Resulting theorem package`
5. `Tradeoff versus stronger alternatives`
6. `Recommended branch statement`

End with one line beginning exactly:

`Suggested next macro action:`

## Proof-State Update Target

`Context Management/source_notes/proof_state.md`
and
`Context Management/source_notes/countable_atomic_attainment_route.md`
