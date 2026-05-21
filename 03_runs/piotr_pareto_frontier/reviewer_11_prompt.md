# Reviewer pass 11 — Verify G1 finite cone-Hall + WTA dual certificate

## Role

Fresh-chat reviewer on Prover 12's G1 finite cone-Hall theorem
(`prover_12_response.md`). The headline claims:

1. G1 holds with the SIGN-CORRECTED dual inequality (≤0 form).
2. For v8 WTA ternary witness with τ uniform on Δ({0,1,2}), α=1/2,
   the dual price y_j = 1 - 2e_j gives **Ψ(y) = 2/9 > 0**, an
   explicit dual certificate that excludes WTA from cone-Hall
   feasibility.
3. With positive aligned baseline, G1 yields a CONCRETE threshold
   inequality for whether WTA reopens.

## What you're verifying

### Theorem (G1, corrected): For finite S = {s_i}, M = {m_j}, weights τ_i, τ_j^M, rowwise support R(i), Bayes cones B_j, α ∈ (0,1):

Nonneg flows x_ij satisfying support+source marginal+cone calibration
exist ⟺ for every dual price vector $(y_j)_{j=1}^J \subset \R^{|Ω|}$,
\[
\Psi(y) := \alpha\sum_j\tau_j^M[y_j\!\cdot m_j - h_{B_j}(y_j)] + (1-\alpha)\sum_i\tau_i\min_{j\in R(i)}[y_j\!\cdot s_i - h_{B_j}(y_j)] \le 0.
\]

### WTA ternary computation

Verify line-by-line:
- $B_j = \{p : p_j \ge p_k\,\forall k\}$ — Bayes cone at vertex profile $v_j$.
- $K_j^- = \{s : s_j \le s_k\,\forall k\}$ — rowwise-minimizer region for $j$.
- $h_{B_j}(y_j) = \max_{p\in B_j} y_j\cdot p$.
- With $y_j = 1 - 2e_j$ (vector of all 1's except $-1$ in slot $j$):
  - $y_j\cdot \mu = 1 - 2\mu_j$ for any $\mu\in\Delta(\Omega)$.
  - $\mu_j$ minimized on $B_j$ at $\mu_0 = (1/3, 1/3, 1/3)$ (boundary
    of the cone), so $h_{B_j}(y_j) = 1 - 2/3 = 1/3$. ✓
- For $s \in K_j^-$: $y_j\cdot s - h_{B_j}(y_j) = (1 - 2s_j) - 1/3 = 2/3 - 2s_j$.
- $\E[s_j | s \in K_j^-]$ under uniform τ on the 2-simplex: $\E[\min(s_0, s_1, s_2)] = 1/9$. ✓
- $\int_{K_j^-}(2/3 - 2s_j)\,d\tau = (1/3)(2/3 - 2/9) = 4/27$. ✓
- Sum over $j = 0, 1, 2$: $\sum = 4/9$. ✓
- $\Psi(y) = (1-\alpha)\cdot 4/9 = 2/9$ at $\alpha = 1/2$. ✓
- $\Psi(y) = 2/9 > 0$, contradicts G1's ≤ 0 requirement, so WTA is
  excluded by explicit dual certificate. ✓

Verify each step. Look for arithmetic errors.

## Specific checks

### Sign convention

The theorem's dual inequality is ≤ 0, not ≥ 0 as originally stated.
Verify the prover's argument that under the support-function
convention $h_{B_j}(y) = \sup_{\mu\in B_j} y\cdot\mu$, feasibility
forces ≤ 0. Spot-check with a degenerate case (e.g., $B_j$ = all of
$\Delta(\Omega)$ → $h_{B_j}(y) = $ max coord of $y$ → constraint
trivially satisfied).

### Farkas/LP duality

Verify the LP formulation:
- Variables: $x_{ij} \ge 0$, $j \in R(i)$.
- Constraints (linearized cone via $y_j$): for every $y_j$,
  $y_j\cdot n_j \le h_{B_j}(y_j)\cdot q_j$.
- Source marginal: $\sum_j x_{ij} = (1-\alpha)\tau_i$.

The LP-dual / Farkas theorem gives feasibility iff the dual certificate
fails to certify infeasibility — i.e., $\Psi(y) \le 0$ for all $y$.

### Bayes cone of vertex profile

Critical step: verify $B_W(w^*(\mu)) \cap \Delta(\Omega)$ for $\mu$ at
vertex $v_j$ equals $\{p : p_j \ge p_k\,\forall k\}$. This is the
plurality cone in WTA. Cite paper Lemma 2 or v8 §8.

### Conditional expectation

$\E[s_j | s \in K_j^-]$ where $K_j^- = \{s : s_j = \min(s_0, s_1, s_2)\}$,
$s$ uniform on the 2-simplex. By symmetry, $\E[\min(s_0, s_1, s_2)] = ?$
- The simplex is $\{s_0 + s_1 + s_2 = 1, s_i \ge 0\}$ with uniform measure.
- $\E[s_0 + s_1 + s_2] = 1$, so $\E[s_j] = 1/3$ for each $j$.
- $\E[\min] + \E[\text{mid}] + \E[\max] = 1$.
- Standard result: for the Dirichlet(1,1,1) = uniform on 2-simplex,
  $\E[\min] = 1/9$, $\E[\text{mid}] = 2/9$ (wait, check this), $\E[\max] = 1 - 1/9 - 2/9 = 6/9 = 2/3$.
- Actually for order statistics of Dirichlet(1,1,1): $\E[X_{(k)}]$ has
  a closed form. Verify $\E[\min] = 1/9$ specifically.

(If $\E[\min] \ne 1/9$, the numerical value of $\Psi$ changes but the
qualitative conclusion that WTA fails G1 should still hold for any
$\E[\min] < 1/3$.)

### Conclusion

If everything checks out, G1 is PASS and the v8 WTA ternary witness
is excluded by an explicit dual certificate — STRONGER than FBNF-7's
hypothesis-class exclusion, because we have a concrete witness for
the obstruction.

## Verdict format

- PASS / PATCH_SMALL / PATCH_BIG / DISPROVED / HOLD.
- End with one-line verdict + next-step (G2 Borel extension next?).

## Critical question

Does the WTA dual certificate ALSO tell us when WTA REOPENS — i.e.,
under what aligned-baseline structure $(τ_j^M, m_j)$ is the threshold
$\Psi(y) \le 0$ achievable? The prover hints at this; verify and
report the precise threshold.

## Constraints

- Banned tools list applies.
- This is a finite, computable theorem — no Borel pathology.
- Verify the WTA dual is the right test, not just some test.
