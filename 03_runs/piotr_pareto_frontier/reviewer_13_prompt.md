# Reviewer pass 13 — Verify G3 Robust Trust biconditional

## Role

Fresh-chat reviewer on Prover 14's G3 (`prover_14_response.md`):
**Theorem 2 ⟺ cone-Hall dual inequality** under regularity package.

## What you're verifying

### G3 statement
For |Ω| ≥ 3, α ∈ (0,1), arbitrary measurable Θ, M = supp τ ⊆ Δ(Ω)
compact, plus regularity package:
- (Reg-1) Closed graph of $R: M \rightrightarrows M$ (the rowwise-
  minimizer correspondence at the optimal labeling $w^*$).
- (Reg-2) Continuity of $h_{B(m)}(y)$ in $m$ for each bounded Borel $y$
  (lower-semicontinuity of the Bayes-cone support function).

The following are equivalent:

(a) **Theorem 2 holds**: there exists a robustly rationalizable optimal
strategy.

(b) **Cone-Hall dual inequality**: $\Psi(y) \le 0$ for every bounded
Borel $y: M \to \R^{|\Omega|}$, where
\[
\Psi(y) = \alpha\!\int_M[y(m)\cdot m - h_{B(m)}(y(m))]\tau(dm) + (1-\alpha)\!\int_M\inf_{m'\in R(s)}[y(m')\cdot s - h_{B(m')}(y(m'))]\tau(ds).
\]

## Specific checks

### 1. The biconditional (a) ⇔ (b)
Verify both directions.

### 2. Setup as G2c instance
Confirm M = supp τ is compact (closed in Δ(Ω); standard).
Confirm the regularity package (Reg-1, Reg-2) is what G2c needs.

### 3. Optimality
Verify the agent's TRS continuation $\hat\sigma^*(m) = R(w^*(\Pi_T(m)))$
is genuinely optimal (uses v8 Tier 1a unconditional value optimality).

### 4. q-a.e. reading
Verify the infinite-space reading of Definition 2 is correct.

### 5. WTA test
Confirm WTA fails (b) with τ uniform, α=1/2 by the dual certificate
$\Psi(y) = 2/9 > 0$ from G1.

### 6. Threshold for WTA reopening
Confirm the threshold $D \ge 2(1-\alpha)/(9\alpha)$ from Reviewer 11
transfers correctly.

## Verdict

PASS / PATCH_SMALL / PATCH_BIG / DISPROVED / HOLD.

If PASS: this is the v8 closure-memo's "deletion-compatible Hall
duality theorem" proved.

End with next-step.

## Constraints

- The biconditional is precise. Check the equivalence rigorously.
- The regularity package (Reg-1, Reg-2) is necessary; do not let it
  smuggle in calibration.
