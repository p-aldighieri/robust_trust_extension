# Prompt Packet: prover

Branch: `post_route2_exact_route1`

## Scope Of This Move

Prove only the upstream reduced-game block for exact Route 1: kernel-topology saddle existence, posterior representation with q*-a.e. local optimality, and barycentric collapse. Treat the selector package and exact patching lemma as already trusted conditional tools, but do not use them unless explicitly needed.

## Goal

Produce a rigorous prover draft for the reduced-game Lemmas 2 to 4: the kernel-topology saddle-existence block, the posterior representation / q*-a.e. local-optimality block, and the barycentric collapse block.

## Hard Constraints

- Do not attempt the final theorem or the final implementation-to-private-strategy glue.
- Do not reopen alternative routes or fallback theorems.
- Any extra regularity or topology assumption must be labeled Needed assumption.
- If the kernel-topology saddle block fails, stop at the first precise obstruction instead of handwaving.

## Durable Project Sources Already In ChatGPT

- `objective_statement.md`
- `Robust_trust_Dworczak_Smolin.pdf`
- `proof_state.md`
- `exact_route1_strategy.md`

## Project Sources To Refresh Before This Chat

- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/source_notes/proof_state.md`
- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/source_notes/exact_route1_strategy.md`

## Temporary Files To Attach In This Chat

- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/logs/20260311T223130Z_breakdown_exact_route1_patching_response.md`
- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/logs/20260311T235517Z_reviewer_exact_route1_patch_lemma_clean_response.md`

## Deliberately Excluded Context

- `Older corrupted captures and stale waiter artifacts.`
- `Broad route brainstorming outside exact Route 1.`
- `The already trusted selector-package prover draft except through the reviewer summary.`

## Required Output

Return markdown with: 1. A short assumptions paragraph stating exactly what is imported. 2. A precise statement and proof of the kernel-topology saddle-existence lemma, including the chosen topology and checked compactness/continuity hypotheses. 3. A precise statement and proof of the posterior representation and q*-a.e. local-optimality lemma. 4. A precise statement and proof of the barycentric collapse lemma. 5. A final short section called Remaining dependencies listing only what is still needed outside this move. 6. End with one line: Suggested next local action: reviewer or revised breakdown.

## Proof-State Update Target

If accepted, update proof_state.md to mark the reduced-game upstream block as drafted and record any remaining dependency outside this move.

## Expected Next-Step Signal

End with one line: Suggested next local action: reviewer or revised breakdown.
