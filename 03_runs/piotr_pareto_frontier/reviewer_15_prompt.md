# Reviewer pass 15 — Verify G4 polyhedral LP threshold

## Role

Fresh-chat reviewer on Prover 16's G4 finite-facet polyhedral LP
threshold theorem (`prover_16_response.md`). Verdict from Prover 16:
**PASS** under finite-cell/tie-discipline hypotheses.

## What's being verified

For finite-action multi-state models with polyhedral $W$, the cone-Hall
dual inequality $\Psi(y) \le 0$ from G3 reduces to a finite LP
feasibility check.

### G4 Theorem statement (paraphrase)
- $|\Omega| \ge 3$, $W$ polyhedral with finitely many vertices.
- Optimal menu $C^* = \{w_1, \ldots, w_k\}$ at finitely many vertices.
- Polyhedral normal fan of $W$ partitions dual prices into finitely many
  extreme directions.
- Per-vertex piecewise-linear decomposition gives finitely many
  inequalities $a_j(y) + b_j(y) \le 0$ that suffice.
- For WTA ternary with uniform τ, α=1/2, the threshold $D \ge 2(1-\alpha)/(9\alpha)$
  emerges as expected.

## Specific checks

### 1. Polyhedral normal fan
Verify $W$ polyhedral ⇒ piecewise-constant rowwise-minimizer behavior.

### 2. Reduction to finite extreme prices
Verify the LP feasibility iff a finite collection of inequalities holds.

### 3. Per-vertex decomposition
Verify the piecewise-linear formulas for $a_j, b_j$.

### 4. WTA test
Verify WTA recovery: G4's threshold matches G1's $\Psi(y) = 2/9 > 0$.

### 5. Other applications
Verify the proof extends cleanly to plurality voting, finite-experiment
design, and ordered MLR (or at least gestures at these as concrete
examples).

### 6. Tie-discipline
Verify the finite-cell/tie-discipline hypotheses are necessary and
sufficient.

## Verdict

- PASS / PATCH_SMALL / PATCH_BIG / DISPROVED / HOLD.

End with one-line + next-step.

## Constraints

- Banned tools list applies.
- The LP must be CHECKABLE: given finite (u, A, Ω, Θ, τ) inputs,
  one can decide feasibility.
