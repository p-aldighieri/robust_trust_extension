# Prompt Packet: Reviewer — FOC Derivation and Envelope Theorem (Blocks C + D)

## Role

`reviewer`

## Scope Of This Move

Review ONLY sections 2-3 (FOC derivation) and sections 4-5 (envelope theorem application) of the attached prover response. Do NOT review all 10 sections. Do NOT re-derive anything.

## Goal

Evaluate whether the prover's FOC derivation and envelope theorem application are logically valid, complete, and correctly cited. You are a checker, not a prover.

## What To Review

1. **FOC derivation (prover sections 2-3)**: Is the perturbation β_ε correctly set up? Is the decomposition into direct/indirect effects algebraically correct? Does the final derivative formula V'(0) = (1-α)τ(μ*)(U(σ̂*_{m₁}, μ*) - U(σ̂*_{m₂}, μ*)) follow from the preceding steps?

2. **Envelope theorem application (prover sections 4-5)**: Is the citation of Milgrom-Segal (2002) Theorem 3 correct? Are the three hypotheses (nonempty argmax, differentiability in ε, equidifferentiability) actually verified, or merely asserted? Is the reparametrization via Φ_m(ε) = q_{β_ε}(m) W(P_{β_ε}(·|m)) valid? Does the envelope step actually eliminate the indirect effect as claimed?

3. **Correctness of envelope theorem citation**: Verify that Milgrom-Segal Theorem 3 is the right tool (not Theorem 2 or a different result). Check whether equidifferentiability is the correct hypothesis name for their local result.

4. **Gap closure**: Do the prover's derivations actually close the gaps they claim to close (Gaps 2-5 from the prover packet)?

## Hard Constraints

- **Scope**: Blocks C-D only. Do not evaluate Block E-F material.
- **Do not re-derive**: Only evaluate the prover's work. Point out errors, do not fix them.
- **Do not review sections 6-10** of the prover response. Those are out of scope.

## Verdict

Return one of:
- **PASS**: The FOC derivation and envelope application are correct. Ready for Block E.
- **PATCH_SMALL**: Minor fixable issues (notation, precision). List them. No resubmission needed.
- **PATCH_BIG**: Substantive issues that require prover resubmission on specific steps.
- **REDO**: Fundamental logical errors. Blocks C-D must be redone.

## Required Output Format

### Verdict: [PASS / PATCH_SMALL / PATCH_BIG / REDO]

### FOC Derivation (sections 2-3)
- Logical validity: [OK / ERROR with description]
- Algebraic correctness: [OK / ERROR with description]
- Gap closure status for Gaps 2, 5

### Envelope Theorem (sections 4-5)
- Citation correctness: [OK / ERROR with description]
- Hypothesis verification: [OK / INCOMPLETE with description]
- Indirect effect elimination: [OK / ERROR with description]
- Gap closure status for Gaps 3, 4

### Issues Found (if any)
[Numbered list]

## Attached File

The prover response is attached as a file in this chat. Read it in full before evaluating.

## Durable Project Sources Already In ChatGPT

- `objective_statement.md`
- `Robust_trust_Dworczak_Smolin.pdf`
- `Robust trust_alternative proof_minimax theorem.pdf`
- `proof_state.md`
