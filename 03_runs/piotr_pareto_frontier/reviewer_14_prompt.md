# Reviewer pass 14 — Verify Prover 15 primitive sufficient classes

## Role

Fresh-chat reviewer on Prover 15 (`prover_15_response.md`):
**primitive sufficient conditions** on $(u, A, \Omega, \Theta, \tau)$
for the G3 biconditional's RHS ($\Psi(y) \le 0$) to hold.

## What's being verified

Prover 15 evaluated four candidates (P1-P4) and reported:
- **(P1) Smooth strict-convex utility + atomless τ alone**: HOLD —
  gives the regularity package (closed-graph R, continuous h_B) but
  NOT $\Psi(y) \le 0$ (the v8 WTA witness has smooth utility but
  Ψ = 2/9 > 0).
- **(P2) (P1) + sufficient aligned baseline / high-alignment**: PASS
  — Ψ ≤ 0 under explicit baseline mass conditions.
- **(P3) Polyhedral W with cone-margin structure**: PASS — Ψ ≤ 0 with
  the finite-facet cone-margin inequality.
- **(P4) Radial / antipodal τ-symmetry**: PASS — Ψ ≤ 0 by symmetry-
  averaging in spherical models.

## Specific checks

### 1. (P1) HOLD
Verify (P1) gives Reg-1+Reg-2 but does NOT automatically give Ψ ≤ 0.
The v8 WTA witness should be the counterexample: smooth WTA payoffs
+ uniform τ → Ψ = 2/9 > 0.

### 2. (P2) PASS under high-alignment
Verify the "high-alignment" / "sufficient aligned baseline" condition
is GENUINELY primitive (not calibration in disguise). Specifically:
the threshold $D \ge 2(1-\alpha)/(9\alpha)$ was computed for WTA; how
does this generalize across $W$ geometries?

### 3. (P3) PASS under cone-margin
Verify the cone-margin condition is meaningful (not vacuous). For
polyhedral W with finite vertices, the cone margin should be a
non-degeneracy condition on the supporting belief cones.

### 4. (P4) PASS radial
Verify the radial / antipodal symmetry argument. Spherical models
(paper Appendix A.10) should satisfy this automatically.

### 5. Coverage
For each (P2-P4), state the class of models that satisfies it.
Confirm the union (P2 ∪ P3 ∪ P4) ∪ FBNF ∪ Binary covers a substantial
slice of substantive applications.

### 6. Cross-cutting

- Are the primitive conditions ALL conditions on (u, A, Ω, Θ, τ),
  not on the optimization output?
- Are they strictly weaker than menu-Hall?
- Compatibility with v8 sharpness: WTA without baseline fails (P2)
  by the threshold computation. WTA with sufficient baseline reopens.

## Verdict

For each (P*) separately: PASS / PATCH / FAIL.

End with one-line + next-step.

## Constraints

- Banned tools list applies.
- (P1) HOLD is the expected outcome (smoothness alone doesn't give
  calibration).
- Be specific about which (P*) is the cleanest publishable primitive.
