# Prompt Packet: reviewer

Branch: `main`

## Scope Of This Move

Fresh reviewer pass on the full main-branch prover artifact for the finite-(M), finite-(Theta) existence proof. Review only this proof draft, its route memo, and its active breakdown. Ignore the old reviewer verdict because its packet was truncated.

## Goal

Determine whether the full main prover draft actually proves the finite-(M), finite-(Theta) existence direction of Theorem 2, and if not, identify the exact smallest missing step or invalid step.

## Hard Constraints

- No assumption smuggling.
- Do not rely on any prior reviewer verdicts from the old run; they were tainted by truncation.
- Evaluate only the attached full prover artifact, active breakdown, and route memo.
- If the proof fails, identify the smallest exact broken lemma or glue step, not a vague global objection.

## Durable Project Sources Already In ChatGPT

- `objective_statement.md`
- `Robust_trust_Dworczak_Smolin.pdf`
- `Context Management/source_notes/proof_state.md`

## Temporary Files To Attach In This Chat

- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Codebook/MathPipeProver/runs/run_20260311T003603710217Z_3016/branches/main/context/strategy.md`
- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Codebook/MathPipeProver/runs/run_20260311T003603710217Z_3016/branches/main/context/breakdown.md`
- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Codebook/MathPipeProver/runs/run_20260311T003603710217Z_3016/branches/main/external_agent/prover_response.md`

## Deliberately Excluded Context

- `Old main reviewer verdicts from the truncated packet.`
- `Route_2 branch materials.`
- `Earlier exploratory archive files and deleted proof_paths history.`

## Required Output

Return short markdown sections: 1. Verdict (PASS, PATCH_SMALL, PATCH_BIG, or FAIL_SCOPE). 2. Trustworthy proved pieces. 3. Exact broken or missing step, with lemma reference. 4. Minimal next prover delta, if any. 5. Whether this branch should continue.

## Proof-State Update Target

If accepted, update the durable proof-state note with the main-route verdict, the trustworthy lemma/glue status for the finite-(M), finite-(Theta) proof, and the exact next patch target if the verdict is not PASS.

## Expected Next-Step Signal

End with one line: Next role: prover, Next role: reviewer, or Terminate main route.
