# Prompt Packet: Formalizer — Notation Alignment and Formal Statement

## Role

`formalizer`

## Scope Of This Move

Blocks A and B of the alternative proof: notation alignment between the sketch and the paper, posterior belief derivation, and a rigorous formal statement of what the alternative proof claims to show.

## Goal

1. Produce a complete notation dictionary mapping between the alternative proof sketch and the paper's conventions. Identify every notational inconsistency.
2. Rewrite the posterior belief formula (γ_m) using the paper's notation, verifying each step.
3. State precisely what the alternative proof claims to prove (as a formal theorem statement), distinguishing between:
   - What is covered by the finite-case argument (Blocks A-F)
   - What is explicitly left open (Block G: infinite M)
4. List every implicit assumption in the sketch that is not stated in the paper's Theorem 2.

## Hard Constraints

- No assumption smuggling.
- Any extra condition must be labeled `[ASSUMPTION+]`.
- Any gap or missing step must be labeled `[GAP]`.
- Do NOT attempt to fill gaps — only identify them.
- Do NOT import results from the separate extension project in `Context Management/`.
- Use the paper's notation as canonical throughout.

## Local Context Included

- `objective_statement.md` (durable project source)
- `Robust_trust_Dworczak_Smolin.pdf` (durable project source — especially Section 2 "Model", Section 3.3 "Robust Rationalizability", and Appendix A.2 "Proof of Theorem 2")
- `Robust trust_alternative proof_minimax theorem.pdf` (durable project source — Piotr's 2-page sketch)

## Durable Project Sources Already In ChatGPT

- `objective_statement.md`
- `Robust_trust_Dworczak_Smolin.pdf`
- `Robust trust_alternative proof_minimax theorem.pdf`
- `proof_state.md`

## Project Sources To Refresh Before This Chat

None — all sources are freshly uploaded.

## Temporary Files To Attach In This Chat

None needed for this first role.

## Deliberately Excluded Context

- `source_notes/alt_proof_formalization.md` — this is our working draft; the formalizer should produce its own independent reading
- All extension project artifacts from `Context Management/`

## Required Output

Produce a single markdown document with these sections:

### 1. Notation Dictionary
A table mapping every symbol in the sketch to the paper's notation, with any inconsistencies flagged.

### 2. Posterior Belief Derivation (Block B)
Rewrite the sketch's posterior formula using the paper's notation. Verify each step.

### 3. Formal Theorem Statement
State precisely what the finite-case alternative proof claims to show, in the paper's language. Compare to the paper's Theorem 2.

### 4. Implicit Assumptions Inventory
List every assumption the sketch makes that is not in the paper's Theorem 2 statement. For each:
- State the assumption precisely
- Say where in the sketch it appears
- Say whether it is a genuine restriction or a simplification that can be removed

### 5. Gap Register
List every step where the sketch says "let's assume" or "we need to establish" or is otherwise incomplete. For each:
- State what is claimed
- State what is missing
- Rate severity: COSMETIC / MODERATE / CRITICAL

## Proof-State Update Target

After acceptance, update `source_notes/proof_state.md`:
- Block A status → COMPLETE or NEEDS_REVISION
- Block B status → COMPLETE or NEEDS_REVISION
- Add any new entries to Open Questions

## Expected Next-Step Signal

Hand off to `prover` on Block C (FOC derivation) if Blocks A-B are clean, or continue `formalizer` if notation issues remain.
