# Reviewer pass 08 — Verify F2 (endpoint-only fiber image)

## Role

Fresh-chat reviewer on Prover 09's F2 from `prover_09_response.md`
(durable source). Verdict from Prover 09:
**PASS for F2-B in endpoint-supported form; PATCH_SMALL if "argmin
set contains only endpoints" wording is required (needs strict P).**

## What's being verified

The endpoint-only fiber image theorem: under FBNF-1+2 plus a primitive
condition P (likely concavity-on-fiber P2 or supporting-line domination
P3), for τ_z-a.e. t and s = ℓ_z(t), the minimum of μ ↦ s·w*(μ) over
T_z = ℓ_z([L(z), R(z)]) is supported on the two fiber endpoints
{ℓ_z(L(z)), ℓ_z(R(z))}.

Adjudicate:
- Is the chosen primitive P (the prover picked one) economically
  meaningful? Does it cover spherical models, MLR families, fan-
  induced normal cones cleanly?
- Is the supporting-line / convexity argument rigorous?
- Does the "endpoint-supported" reading suffice for the downstream
  capstone, or do we strictly need "argmin contains only endpoints"?
- The "cross-fiber exclusion" condition flagged in Prover 09's tail —
  is it benign or does it sneak in calibration as a primitive?

## Verdict format
- PASS / PATCH_SMALL / PATCH_BIG / DISPROVED / HOLD.
- One-line + next-step signal.

## Constraints
- Banned tools list applies.
- Binary capstone (paper §4.2 / v9 §8) is the analog; check consistency.
