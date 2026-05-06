# Reviewer pass — L6 (Lusin lift contradiction)

You are the Reviewer in the soft-scaffolding workflow.

## What you are reviewing

A prover proof of **L6** from `phil_reny_route_memo.md`. Verdict
**PROVED under (A5)** with no new assumptions or breakdown amendments.
The prover's response is in
`logs/20260506T023000Z_prover_L6_lusin_lift_response.md`.

This is the **core new step** in Phil's argument and the longest
Branch-A lemma. Audit carefully.

## Inputs (durable sources)

- `phil_reny_route_memo.md` — live route memo. L1, L2, L3+L4, L5 (under A5),
  L7 PROVED. L6 in review.
- `phil_reny_bundle.md` — Phil's email is the contradiction sketch.
- `prior_attempts_digest.md` — dead routes.
- Paper PDF.

## Specific items the reviewer MUST audit

1. **Reduction to message payoff $p_\omega(m)$.** The prover defines
   $p_\omega(m) := \int_\Theta \int_A u(a,\omega,\theta)\,\sigma^*(da\mid m,\theta)\,f(d\theta\mid\omega)$
   and reduces the $U$-difference to the misaligned term:
   $U(\beta,\sigma^*) - U_F(\sigma^*,\varphi) = (1-\alpha)(C(\beta) - C(\varphi))$.
   Verify (a) $p_\omega$ is bounded Borel; (b) the aligned term is
   identical for $U(\beta,\sigma^*)$ and $U_F(\sigma^*,\varphi)$ since
   neither involves $\beta$ or $\varphi$.
2. **Lusin uniform continuity.** The prover claims that since
   $f(\cdot\mid\omega)\ll\bar f$, the test
   $(\theta,a) \mapsto u(a,\omega,\theta)\,\frac{df(\cdot\mid\omega)}{d\bar f}(\theta)$
   is bounded measurable in $\theta$, continuous in $a$, hence the
   functional $\hat\sigma\mapsto p_\omega$ is Balder-stable continuous.
   Therefore $p_\omega\restriction K_n$ is continuous, hence uniformly
   continuous on the compact $K_n$. Verify each step. Watch for
   measurability of the Radon-Nikodym multiplier and its boundedness.
3. **Choice of metric on $M$.** Prover uses any compatible metric, e.g.,
   total variation on $\Delta(\Omega)$ (since $\Omega$ finite, $\Delta(\Omega)$
   sits in $\mathbb R^N$ — total variation is equivalent to Euclidean).
   Verify this is fine.
4. **Smoothing kernel $q_\varepsilon(z\mid y)$.** Built shell-by-shell:
   $D_n := K_n \setminus K_{n-1}$; for $y\in D_n$ set $q_\varepsilon(z\mid y) = \mathbf 1_{K_n\cap B(y,\rho_n)}(z)/\tau(K_n\cap B(y,\rho_n))$;
   for $y\notin K^*$ set $q_\varepsilon(z\mid y) = \mathbf 1_{K_{n_0}\cap B(m_0,\rho_0)}(z)/\tau(K_{n_0}\cap B(m_0,\rho_0))$.
   Verify (a) the denominators are positive by L5 support-thickness +
   (A5) (so $K_n\cap B(y,\rho_n)$ is a relative open in $K_n$ with
   positive $\tau$-mass); (b) joint Borel measurability of
   $q_\varepsilon(z\mid y)$ in $(z,y)$.
5. **Pointwise approximation $|\int p_\omega\,q_\varepsilon - p_\omega(y)| \le \eta$.**
   For $y\in D_n$, $q_\varepsilon$ supports on $K_n\cap B(y,\rho_n)$;
   uniform continuity gives the bound. For $y\notin K^*$, the
   off-$K^*$ modification gives $p_\omega(y) = p_\omega(m_0)$, then
   the bound from $K_{n_0}\cap B(m_0,\rho_0)$ applies. Verify both
   cases.
6. **Composition $\varphi_\varepsilon(z\mid s) = \int q_\varepsilon(z\mid y)\,\beta(dy\mid s)$.**
   Verify (a) joint Borel measurability; (b) $\int_M\varphi_\varepsilon(z\mid s)\,\tau(dz) = 1$
   for $\tau$-a.e. $s$ (Tonelli); (c) the prover's "redefine to 0 on
   the τ-null infinite set" handling is OK (it doesn't change τ-integrals).
7. **Final payoff bound $C(\beta) - C(\varphi_\varepsilon) \le \eta$.**
   This is the punch line. Verify the Tonelli + uniform-continuity bound
   gives the final inequality.
8. **Stochastic kernel handling.** The prover's argument works *directly*
   for stochastic $\beta$ (no Dirac reduction needed) by integrating
   $q_\varepsilon$ against $\beta$. Confirm this is rigorous, not a
   shortcut.
9. **Branch A capstone preview.** The prover asserts that L6 + L1–L5
   gives $V^* = U^*$ via the sandwich $U^* \le V^*$ (since $F\hookrightarrow B$)
   and $U(\beta,\sigma^*) \ge V^*$ for all $\beta\in B$ (from L6).
   Verify the two directions of the sandwich in your review (this is
   the consolidator setup).
10. **Scope discipline.** Did the prover stop at L6 + capstone preview?
    No L8 / L9 leakage? No dead-route machinery?

## Output Format

```
\`\`\`review_control
verdict: PASS / PATCH_SMALL / PATCH_BIG / REDO
route_status: viable / blocked / dead
recommended_next_phase: PROVER / BREAKDOWN / SEARCHER / CONSOLIDATOR / STOP_STALL
proof_status: complete / partial / broken
\`\`\`

## Verdict

VERDICT: ...
Reason: ...

## Opinion and Next Move

(One paragraph. If PASS, recommend the next move — should be
**Branch A capstone consolidator**: assemble the value-securing theorem
"$\sigma^*$ achieves $U^*$" from L1–L7. After that, Branch B (L8: $\beta^*$
attainment) is the only remaining task.)

## Detailed Review

(Per audit items 1–10.)
```

Length budget: 1500–2500 words. The proof is long but the architecture
is clean.

---

## PROVER RESPONSE TO REVIEW (verbatim, abridged for length — full version in logs/)

The prover's full response is in
`logs/20260506T023000Z_prover_L6_lusin_lift_response.md` and is
available on the project workspace. Key structural points:

- **Step 1.** Define $p_\omega(m) := \int_\Theta\int_A u(a,\omega,\theta)\,\sigma^*(da\mid m,\theta)\,f(d\theta\mid\omega)$,
  $H := \sup |u|$. Reduce to misaligned term:
  $U(\beta,\sigma^*) - U_F(\sigma^*,\varphi) = (1-\alpha)(C(\beta) - C(\varphi))$
  with $C(\beta) = \sum_\omega \mu_0(\omega)\int_M\int_M p_\omega(y)\,\beta(dy\mid s)\,\pi(ds\mid\omega)$
  and similarly for $C(\varphi)$ with $\varphi(z\mid s)\,\tau(dz)$.

- **Step 2.** $\hat\sigma\mapsto p_\omega$ is Balder-stable continuous
  (test $(\theta,a)\mapsto u(a,\omega,\theta)\,\frac{df(\cdot\mid\omega)}{d\bar f}(\theta)$
  is bounded measurable + continuous in $a$). Hence $p_\omega\restriction K_n$
  is continuous and uniformly continuous on compact $K_n$. Pick
  $\eta := \varepsilon$ and $\rho_n > 0$ such that
  $y,z\in K_n,\,d(y,z)<\rho_n \Rightarrow \max_\omega |p_\omega(z)-p_\omega(y)|\le\eta$.
  Pick $m_0\in K^*$, $n_0$ such that $m_0\in K_{n_0}$, and $\rho_0>0$
  such that $z\in K_{n_0},\,d(z,m_0)<\rho_0 \Rightarrow \max_\omega |p_\omega(z)-p_\omega(m_0)|\le\eta$.

- **Step 3.** Borel shells $D_n := K_n\setminus K_{n-1}$. Define
  $q_\varepsilon(z\mid y) := \mathbf 1_{K_n\cap B(y,\rho_n)}(z)/\tau(K_n\cap B(y,\rho_n))$
  for $y\in D_n$; $q_\varepsilon(z\mid y) := \mathbf 1_{K_{n_0}\cap B(m_0,\rho_0)}(z)/\tau(K_{n_0}\cap B(m_0,\rho_0))$
  for $y\notin K^*$. Denominators positive by L5 support-thickness +
  (A5). Joint Borel measurability via kernel integration.

- **Step 4.** $|\int p_\omega(z)\,q_\varepsilon(dz\mid y) - p_\omega(y)|\le\eta$
  for every $y\in M$, every $\omega$, by uniform continuity in each
  case.

- **Step 5.** $\varphi_\varepsilon(z\mid s) := \int q_\varepsilon(z\mid y)\,\beta(dy\mid s)$,
  the density of the τ-dominated kernel
  $\beta_{\varphi_\varepsilon}(dz\mid s) = \int Q_\varepsilon(dz\mid y)\,\beta(dy\mid s)$
  with $Q_\varepsilon(dz\mid y) := q_\varepsilon(z\mid y)\,\tau(dz)$.
  Tonelli gives normalization. Joint Borel measurability inherited.

- **Step 6.** Bound $|C(\beta) - C(\varphi_\varepsilon)| \le \eta$ by
  Tonelli + step 4 pointwise bound. Hence
  $|U(\beta,\sigma^*) - U_F(\sigma^*,\varphi_\varepsilon)| \le (1-\alpha)\eta < \varepsilon$.

- **Conclusion.** $U(\beta,\sigma^*) \ge U_F(\sigma^*,\varphi_\varepsilon) - \varepsilon \ge V^* - \varepsilon$
  for every $\varepsilon > 0$, hence $\inf_{\beta\in B}U(\beta,\sigma^*) \ge V^*$.
  Combined with $V^* = \sup_\sigma\inf_F U_F(\sigma,\varphi) \ge \sup_\sigma\inf_B U(\beta,\sigma) = U^*$
  (since $F\hookrightarrow B$ via $\beta_\varphi$ and one infimum is over
  a larger set, giving $\inf_\varphi U_F \ge \inf_\beta U$ pointwise in
  $\sigma$, hence $V^* \ge U^*$): **$V^* = U^*$ and $\sigma^*$ achieves it.**

- **Status.** L6 PROVED under (A5). No new assumptions. No breakdown amendments.

If the abridged version above is unclear in any spot, consult
`logs/20260506T023000Z_prover_L6_lusin_lift_response.md` directly.
