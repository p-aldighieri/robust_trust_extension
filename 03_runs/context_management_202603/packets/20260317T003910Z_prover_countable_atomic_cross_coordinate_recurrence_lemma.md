# Prompt Packet: prover

Branch: `countable_atomic_direct`

## Scope Of This Move

Countable atomic direct route: test the exact cross-coordinate recurrence lemma for the concrete witness construction

## Goal

Work only on the exact missing lemma singled out by the latest reviewer-cleared diagnosis. The target is a concrete recurrence statement for the set-valued map `j \mapsto K_j`, for example:

`j_n` distinct, `\kappa_n \in K_{j_n}`, `\kappa_n \to \kappa` implies `\kappa \in K_{j_n}` for infinitely many `n`,

or any equivalent exact admissibility-on-a-tail theorem that would yield one witness recurring in infinitely many varying fibers. Check directly against the actual definition of `K_j` used on this branch.

## Hard Constraints

- Stay on the countable-atomic direct branch and keep the scope strictly on this recurrence lemma.
- Do not drift to later aggregation, the `C`-side probe, monotone-refinement / eventual-constancy, or counterexample hunting.
- Use as trusted that the finite-palette / finite-label line is exhausted and that the generic tail-stability / closedness backup is already reviewer-cleared blocked on the present record.
- Distinguish sharply between:
  - any ambient-normalization / tightness assumption needed just to formulate convergence, and
  - the substantive recurrence claim needed to conclude exact infinitely-many-fiber membership.
- Do not assume any recurrence, exact tail-membership, finite-label theorem, or hidden rigidity of `K_j` unless you derive it from the concrete witness construction already banked.

## Durable Project Sources Already In ChatGPT

- `objective_statement.md`
- `Robust_trust_Dworczak_Smolin.pdf`

## Project Sources To Refresh Before This Chat

- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/source_notes/proof_state.md`
- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/source_notes/countable_atomic_direct_route.md`

## Temporary Files To Attach In This Chat

- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/logs/20260317T000110Z_prover_countable_atomic_exact_tail_membership_lemma_response.md`
- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/logs/20260317T002212Z_reviewer_countable_atomic_exact_tail_membership_non_derivability_response.md`

## Deliberately Excluded Context

- `Any move to downstream aggregation, C-side work, admissibility/slice/support geometry, or monotone-refinement before this recurrence hinge is tested.`
- `Any reopening of the exhausted finite-label or generic tail-stability lines except as already-banked inputs.`

## Required Output

Return only substantive markdown for the prover role. Either prove the recurrence lemma from the current concrete witness construction, or identify the first exact place where the proof still fails. If it fails, say whether the failure is only a missing ambient-normalization prerequisite or a deeper substantive recurrence obstruction. End with one line beginning Suggested next local action:.

## Proof-State Update Target

Context Management/source_notes/proof_state.md and Context Management/source_notes/countable_atomic_direct_route.md

## Expected Next-Step Signal

Suggested next local action:
