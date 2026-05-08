# Prompt Packet: reviewer

Branch: `route_2__SCOPE_First_remove_finiteness_of_Theta_while_keeping_M_finite`

## Scope Of This Move

Fresh reviewer pass on the full route_2 prover artifact for the partial theorem with finite M and arbitrary compact metric Theta. Review only this proof draft, its route memo, its active breakdown, and its breakdown amendments. Ignore the old reviewer verdict because its packet was truncated.

## Goal

Determine whether the full route_2 prover draft actually proves the finite-M, arbitrary compact metric-Theta existence result, and if not, identify the exact smallest missing step or invalid step.

## Hard Constraints

- No assumption smuggling.
- Do not rely on any prior reviewer verdicts from the old run; they were tainted by truncation.
- Evaluate only the attached full prover artifact, active breakdown, route memo, and breakdown amendments.
- If the proof fails, identify the smallest exact broken lemma or glue step, not a vague global objection.

## Durable Project Sources Already In ChatGPT

- `objective_statement.md`
- `Robust_trust_Dworczak_Smolin.pdf`
- `Context Management/source_notes/proof_state.md`

## Temporary Files To Attach In This Chat

- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Codebook/MathPipeProver/runs/run_20260311T003603710217Z_3016/branches/route_2__SCOPE_First_remove_finiteness_of_Theta_while_keeping_M_finite/context/strategy.md`
- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Codebook/MathPipeProver/runs/run_20260311T003603710217Z_3016/branches/route_2__SCOPE_First_remove_finiteness_of_Theta_while_keeping_M_finite/context/breakdown.md`
- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Codebook/MathPipeProver/runs/run_20260311T003603710217Z_3016/branches/route_2__SCOPE_First_remove_finiteness_of_Theta_while_keeping_M_finite/context/breakdown_amendments.md`
- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Codebook/MathPipeProver/runs/run_20260311T003603710217Z_3016/branches/route_2__SCOPE_First_remove_finiteness_of_Theta_while_keeping_M_finite/external_agent/prover_response.md`

## Deliberately Excluded Context

- `Old route_2 reviewer verdicts from the truncated packet.`
- `Main-branch artifacts except the durable proof-state note.`
- `Earlier exploratory archive files and deleted proof_paths history.`

## Required Output

Return short markdown sections: 1. Verdict (PASS, PATCH_SMALL, PATCH_BIG, or FAIL_SCOPE). 2. Trustworthy proved pieces. 3. Exact broken or missing step, with lemma reference. 4. Minimal next prover delta, if any. 5. Whether this branch should continue.

## Proof-State Update Target

If accepted, update the durable proof-state note with the route_2 verdict, the trustworthy lemma/glue status for the finite-M arbitrary-Theta proof, and the exact next patch target if the verdict is not PASS.

## Expected Next-Step Signal

End with one line: Next role: prover, Next role: reviewer, or Terminate route_2.
