# Prompt Packet: reviewer

Branch: `post_route2_exact_route1`

## Scope Of This Move

Review only the scoped prover draft for the selector package on W and the exact version-and-patching saddle lemma, assuming the reduced-game Lemmas 1 to 4 as established context.

## Goal

Determine whether the scoped prover draft soundly proves the dominating-frontier selector, the supporting-belief selector, and the exact version-and-patching saddle lemma under the stated assumptions, and if not identify the smallest exact repair.

## Hard Constraints

- Review only this scoped prover draft and the exact-route breakdown. Do not reopen broad route-selection questions.
- Assume Lemmas 1 to 4 of the exact-route breakdown as given context for this review.
- Report local proof status and repair needs only; Codex decides branch continuation.

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
- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/logs/20260311T232119Z_prover_exact_route1_patch_lemma_clean_response.md`

## Deliberately Excluded Context

- `Broad beyond-finite-M route brainstorming outside exact Route 1.`
- `Older truncated or corrupted captures.`
- `Full historical branch bundles not needed for this scoped review.`

## Required Output

Return short markdown sections: 1. Verdict (PASS, PATCH_SMALL, PATCH_BIG, or REDO). 2. Trusted proved pieces. 3. Exact broken or missing step, with lemma reference. 4. Minimal next prover delta or breakdown amendment. 5. End with one line: Suggested next local action: prover patch, reviewer follow-up, or breakdown revisit.

## Proof-State Update Target

If accepted, update proof_state.md to record whether the selector package and patching lemma are now trustworthy or what exact repair remains.

## Expected Next-Step Signal

End with one line: Suggested next local action: prover patch, reviewer follow-up, or breakdown revisit.
