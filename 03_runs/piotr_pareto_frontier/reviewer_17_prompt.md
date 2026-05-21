# Reviewer pass 17 — Verify G-FBNF-1 finite-graph pasting

## Role

Fresh-chat reviewer on Prover 19's G-FBNF-1 (`prover_19_response.md`).
The lemma extends FBNF to a finite-graph primitive class P6^G with
Kirchhoff node balance.

## Specific checks

1. Verify the proof closes under scalar-equality (which the prover
   explicitly used as its reading).
2. Verify Kirchhoff balance is correctly formulated at interior
   graph vertices.
3. Verify the arc-wise L_B1 application + measurable graph pasting.
4. Verify cross-arc dominance (the FBNF-7 analog) is genuinely a
   primitive condition, not output-conditioned.
5. Confirm WTA ternary correctly fails P6^G (vertex menu has no
   arcs).

## Verdict
PASS / PATCH / DISPROVED / HOLD.

End with one-line + next-step (G-FBNF-2/3 or extension to v9.1).
