# Prompt Packet: prover

Branch: `atomic_truncation_limit`

## Scope Of This Move

One lemma only on the countable atomic branch. Do not compare routes and do not revisit the refuted full-kernel compactness route.

## Goal

Fix a concrete finite approximation scheme M_n up to M for the countable atomic branch, use the trusted finite-M theorem as a black box, and either prove that every cluster point of finite-stage saddle pairs is a saddle pair of the full atomic reduced game or construct an explicit counterexample showing that adviser tail concentration creates a value gap.

## Hard Constraints

- Treat the trusted finite-M compact-Theta theorem as a black box, not as something to re-prove.
- Stay on the countable atomic branch where tau({m}) > 0 for every message.
- Do not ask again for the false compact-topology lemma on the full measurable reduced game.
- If the route fails, the failure must be an explicit tail-concentration counterexample or a clearly isolated exact obstruction.
- Do not drift into broad route comparison or literature review.

## Durable Project Sources Already In ChatGPT

- `objective_statement.md`
- `Robust_trust_Dworczak_Smolin.pdf`
- `Context Management/source_notes/proof_state.md`

## Project Sources To Refresh Before This Chat

- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/source_notes/proof_state.md`
- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/source_notes/atomic_truncation_strategy.md`

## Temporary Files To Attach In This Chat

- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/source_notes/partial_extension_finite_M.md`
- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/source_notes/atomic_fallback_progress.md`
- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/logs/20260312T191259Z_breakdown_infinite_M_route_repair_response.md`

## Deliberately Excluded Context

- `Old exact-route strategy notes that still prioritize the refuted full-kernel continuity route.`
- `Reviewer packets from already settled finite-M work.`
- `Any route-comparison or planner language beyond the chosen atomic truncation lemma.`

## Required Output

Return markdown with: 1. Exact setup and the chosen finite approximation scheme. 2. A proof attempt for the Atomic truncation-limit decision lemma. 3. If the lemma fails, an explicit counterexample with the exact tail mechanism. 4. A short conclusion stating either PROVED or COUNTEREXAMPLE for this lemma. 5. End with one line: Suggested next local action: reviewer, revised breakdown, or searcher.

## Proof-State Update Target

If accepted, update proof_state.md with the result of the Atomic truncation-limit decision lemma and whether the atomic branch advances to reviewer or collapses to a concrete tail counterexample.

## Expected Next-Step Signal

End with one line: Suggested next local action: reviewer, revised breakdown, or searcher.
