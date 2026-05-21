# Reviewer pass 02 — Verify Lemmas 7 and 8 (Fermat + calibration hinge)

## Role

You are an independent Reviewer for a smart-scaffolding proof project.
You are reading proofs of **Lemma 7** (Clarke Fermat → normal-cone
stationarity) and **Lemma 8** (Clarke multipliers ARE the calibration
kernel) produced by a different Prover session.

This is a **fresh chat**. You have not seen the Prover's work before.
The proofs are in durable source `prover_02_response.md`. Context: the
full route memo `piotr_pareto_frontier_route_memo.md`; the breakdown
`breakdown_01_response.md`; the patched Lemma 6 `prover_01_response.md`
+ `reviewer_01_response.md`.

Lemma 8 part (c) is **the load-bearing claim of the entire route** —
that the Bayes-calibration condition \(p_i\in N_W(w_i)\cap\Delta(\Omega)\)
follows automatically from Fermat stationarity, by the identity
\(p_i = g_i / q_i\) and the cone closure of \(N_W(w_i)\) under positive
rescaling. If this step is correct, finite-menu Pareto-Hall closes.

## What you are reviewing

### Lemma 7
**Statement.** \(W\) closed convex compact, \(\bar w\in W^k\) is an
ambient local maximizer of \(F_k\) over \(W^k\). Then there exists
\(g\in\partial_C F_k(\bar w)\) with \(g\in N_{W^k}(\bar w) = \prod_i N_W(w_i)\).
I.e., \(g_i\in N_W(w_i)\) for every \(i\).

### Lemma 8 (the hinge)
**Statement.** Given Lemmas 6 (patched) and 7. Let \(g\) be the normal
subgradient from Lemma 7, with multipliers \(\lambda^\pm:M\to\Delta(k)\)
from Lemma 6. Define
\(q_i := \alpha\int\lambda_i^+(s)d\tau + (1-\alpha)\int\lambda_i^-(s)d\tau\).
Then:

- (a) **Mass balance.** \(\sum_i q_i = 1\); each \(q_i\ge 0\).
- (b) **Posterior in simplex.** When \(q_i>0\), \(p_i := g_i / q_i\in\Delta(\Omega)\).
- (c) **Calibration.** \(p_i\in N_W(w_i)\cap\Delta(\Omega) = B_W(w_i)\).
- (d) **Kernel realization.** The finite-label adversarial kernel
  \(\hat\kappa(\{i\}\mid s) := \lambda_i^-(s)\) combined with the
  aligned tie-routing weights \(\lambda^+_i(s)\) generates a joint law
  whose disintegrated posterior is exactly \(p_i\), with calibration
  \(p_i\in B_W(w_i)\) τ̃-a.e.

Plus the **finite-menu Pareto-Hall calibration theorem** as the combined
conclusion.

## Specific checks

### For Lemma 7

1. **Sign convention.** Clarke's necessary condition for a minimum of
   \(f\) on \(C\) is \(0\in\partial_C f(x_0) + N_C(x_0)\). The prover
   minimizes \(-F_k\) over \(W^k\). Verify: this gives
   \(0\in\partial_C(-F_k)(\bar w) + N_{W^k}(\bar w)\), and
   \(\partial_C(-F_k) = -\partial_C F_k\) (true for locally Lipschitz).
   So \(\exists g\in\partial_C F_k\) with \(g\in N_{W^k}\). The sign is
   not negated; check the proof's bookkeeping.

2. **Product normal cone.** Verify the claim
   \(N_{W^k}(\bar w) = \prod_i N_W(w_i)\) — cite Rockafellar 1970 §16,
   or note that any normal direction to a product splits coordinate-wise.

3. **Local Lipschitz of \(F_k\).** Verify by Lemma 2 / direct argument
   (max+min of linear functionals + bounded integrand).

4. **Ambient vs frontier.** The proof should make explicit that local
   maximality is on the ambient \(W^k\), not on the frontier \((W^P)^k\).
   This depends on L3 (ambientization certificate), which is cited.

### For Lemma 8

1. **Mass balance (a).** Verify \(\sum_i \lambda^+_i(s) = 1\) and
   \(\sum_i \lambda^-_i(s) = 1\) τ-a.e. (from \(\lambda^\pm:M\to\Delta(k)\)),
   so \(\sum_i q_i = \alpha + (1-\alpha) = 1\). Trivial but check.

2. **Posterior in simplex (b).** The proof's argument:
   \(\sum_\omega g_i(\omega) = \alpha\int\lambda_i^+(s)\sum_\omega s(\omega)\,d\tau + (1-\alpha)\int\lambda_i^-(s)\sum_\omega s(\omega)\,d\tau\).
   Since \(\sum_\omega s(\omega) = 1\) (as \(s\in\Delta(\Omega)\)), this
   collapses to \(q_i\), so \(\sum_\omega [p_i]_\omega = 1\). Each
   coordinate is nonneg because \(s\ge 0\) and \(\lambda^\pm\ge 0\).
   Verify this calculation rigorously.

3. **Calibration (c).** **THE LOAD-BEARING STEP.** The argument:
   \(g_i\in N_W(w_i)\) by Lemma 7. \(N_W(w_i)\) is a convex cone.
   \(p_i = g_i / q_i\), a positive scalar multiple of \(g_i\) when
   \(q_i>0\). So \(p_i\in N_W(w_i)\). Combined with (b),
   \(p_i\in N_W(w_i)\cap\Delta(\Omega) = B_W(w_i)\) (cite L1).

   **Verify the cone closure under positive rescaling.** \(N_W(w_i)\)
   is defined as \(\{\xi: \xi\cdot(v-w_i)\le 0\,\forall v\in W\}\).
   If \(\xi\in N_W(w_i)\) and \(c > 0\), then \(c\xi\cdot(v-w_i) = c(\xi\cdot(v-w_i))\le 0\),
   so \(c\xi\in N_W(w_i)\). Trivial but central.

   **Verify the identification \(N_W(w_i)\cap\Delta(\Omega) = B_W(w_i)\).**
   This is L1 (cited without re-proving). \(B_W(w) := \{\mu\in\Delta(\Omega):w\in\arg\max_{v\in W}\mu\cdot v\}\).
   The equivalence is by supporting hyperplane theorem: \(\mu\in B_W(w)\)
   iff \(\mu\cdot v\le\mu\cdot w\,\forall v\in W\) iff \(\mu\cdot(v-w)\le 0\)
   iff \(\mu\in N_W(w)\). When \(\mu\in\Delta(\Omega)\), the equivalence
   gives \(B_W(w) = N_W(w)\cap\Delta(\Omega)\). Trivial but central.

4. **Kernel realization (d).** Verify the joint law
   \(\tilde\gamma_\alpha = \alpha\cdot(\lambda^+)_\#\tau + (1-\alpha)\cdot(\lambda^-)_\#\tau\)
   (suitably defined as Borel measure on \(M\times\{1,...,k\}\)) has
   disintegrated posterior \(p_i\). Bayes' rule on finite spaces:
   \(P(\omega\mid I=i) = P(\omega, I=i) / P(I=i)\). Compute:
   \(P(\omega, I=i) = \alpha\int s(\omega)\lambda_i^+(s) d\tau + (1-\alpha)\int s(\omega)\lambda_i^-(s) d\tau = g_i(\omega)\).
   \(P(I=i) = q_i\). So \(P(\omega\mid I=i) = g_i(\omega)/q_i = [p_i]_\omega\).

5. **Sanity check.** The proof should compute the k=2, N=2 example
   from L6's sanity check, verifying calibration holds. Check the
   computation.

6. **No hidden hypotheses.** Verify the proof does NOT silently use:
   - atomless τ;
   - generic no-tie behavior;
   - strict convexity of \(W\) or smoothness of \(W^P\);
   - any condition on \(\tau\) beyond it being a probability measure;
   - any condition on \(W\) beyond closed convex compact.

7. **Banned tool audit.** Cross-check: no product-of-narrow Sion, no
   τ-AC restriction, no FOC + envelope, no canonical/minimal pruning,
   no ε-menu-Hall as primary.

### Verdict format

State your verdict as one of:

- **PASS** — both proofs correct, route closes finite-menu Pareto-Hall.
- **PATCH_SMALL** — proofs morally correct, small fixes needed.
- **PATCH_BIG** — substantive gap requires real remediation.
- **DISPROVED** — at least one lemma is false, or a central step is
  irreparably broken.
- **HOLD** — need more information.

For non-PASS: be precise about which lemma, which step, and the fix.

## Critical sanity check

The route's BIG claim is that calibration **emerges from Lagrange
multipliers** rather than from external Hall duality. v8 has menu-Hall
as an **assumption**; this route claims calibration is a **consequence**
of finite-menu optimality. If Lemma 8(c) is correct, this is a genuine
new theorem.

Reviewer should specifically ask: **does the route's logic also apply
to the v8 sharpness witness (WTA ternary, atomless τ)?** If yes, then
the witness should have a calibrated kernel — but v8 Lemma 7 (cone
intersection) says it doesn't. Resolve the apparent contradiction. The
expected resolution: the v8 witness is **not** a finite-menu local
maximizer in the sense of Lemma 7 (it's an arbitrary menu, not an
ambient maximizer of \(F_k\)). Confirm this resolution.

## Output Contract

- Return everything inline in this chat as plain markdown.
- Be specific about line/step references.
- End with: (a) one-line verdict, (b) one-paragraph next-step signal.

## Constraints

- Banned tools list applies; check it's not snuck in.
- This is a fresh-context review; do not trust the Prover's claims
  without verifying.
