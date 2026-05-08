# Prompt Packet: searcher

Branch: `post_route2_extension`

## Scope Of This Move

Planning pass only. Starting from the now-trusted partial theorem with finite M and compact metric Theta, choose the best next route for removing finiteness of M or for identifying the right weaker/conditional theorem if the full extension is not realistic under current assumptions.

## Goal

Produce a high-quality route comparison for the remaining open target beyond finite M, with emphasis on topology on adviser kernels, saddle-point existence, and the messagewise posterior-optimality patching problem.

## Hard Constraints

- Do not re-prove the finite-M compact-Theta result; treat it as trusted baseline context.
- Do not assume the full unrestricted extension is true. If the best path requires narrowing the theorem or adding restrictions, say so explicitly.
- Use Piotr's note as a negative prior against naive transplantation of the finite argument.
- Keep the route recommendations distinct and scoped enough that a later breakdown can be manually inspected.

## Durable Project Sources Already In ChatGPT

- `objective_statement.md`
- `Robust_trust_Dworczak_Smolin.pdf`
- `Context Management/source_notes/proof_state.md`

## Temporary Files To Attach In This Chat

- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/source_notes/proof_state.md`
- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/source_notes/partial_extension_finite_M.md`
- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/source_notes/piotr_topology_note.md`
- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/source_notes/literature_map.md`
- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Codebook/MathPipeProver/runs/run_20260311T003603710217Z_3016/branches/main/context/strategy.md`

## Deliberately Excluded Context

- `Old truncated reviewer packets and deleted request/session artifacts.`
- `Detailed prover drafts that are specific to the already-solved finite-M route2 proof.`
- `Any route recommendation that ignores topology or null-message patching issues.`

## Required Output

Return markdown with: 1. Candidate Routes (2 to 4 ranked routes). 2. For each route: core idea, key lemmas, likely failure point, and whether it aims at the exact theorem or a weaker conditional theorem. 3. Recommended route to pursue next. 4. Exact critical lemma or bottleneck. 5. Suggested next local action: breakdown, literature, or scoped prover.

## Proof-State Update Target

If accepted, update the durable proof-state note with the ranked post-route2 options, the selected next route, and the exact bottleneck beyond finite M.

## Expected Next-Step Signal

End with one line: Suggested next local action: breakdown, literature, or scoped prover.
