# Reviewer pass 18 — Verify Binary-TS tie-splitting

## Role

Fresh-chat reviewer on Prover 21's Binary-TS lemma
(`prover_21_response.md`). Confirms whether the binary capstone
extends to atoms at the tie belief via measurable tie-splitting.

## What you're verifying

The lemma replaces **(R-TD) tie discipline** with **(R-TD*) tie-split
discipline**: τ may have atom $\kappa$ at the indifference belief
$s^*$, with measurable tie-splitting weights $\lambda^+(s^*), \lambda^-(s^*) \in [0,1]$
specifying how much of the tied mass routes to $L$ vs $R$ on aligned
and misaligned sides.

## Specific checks

1. **Modified L_B5 total-balance**: includes the tie-mass contribution
   on both aligned and misaligned sides. Verify the algebra.
2. **Clarke-Danskin stationarity at the atom**: Prover 21 claims the
   tie weights emerge from the Lagrange multipliers at the tie cell.
   Verify this is correct.
3. **L_B1 application with adjusted measures**: the modified η, ν
   include tie-mass terms; does L_B1 still apply?
4. **Calibration at endpoint**: $P_{\hat\beta^*}(\cdot\mid L) = L$
   under the tied-mass mixture. Verify.

## Verdict

PASS / PATCH_SMALL / PATCH_BIG / DISPROVED / HOLD.

End with one-line + next-step (extend v9.1 with R-TD* in binary
capstone or stop sharpening).
