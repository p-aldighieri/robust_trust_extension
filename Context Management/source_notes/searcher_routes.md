The real target here is the **existence** half of Theorem 2 for *Robust Trust*: the paper proves existence by a saddle-point/minimax argument only when (M) and (\Theta) are finite, and the project note isolates the no-finiteness extension as the hard part. I am ranking routes for that existence problem, not the verification direction, since the latter is comparatively light once a saddle point is in hand. ([arXiv][1])   

1. **Reduce to a kernel game on the finite-dimensional payoff set (W)**

   **Core technique.** Use Appendix A.1 to compress the agent’s private-strategy side into the compact convex set
   [
   W={w\in\mathbb R^{|\Omega|}:\exists \hat\sigma,; w(\omega)=\mathbb E_{\hat\sigma}[u(a,\omega,\theta)\mid \omega]},
   ]
   then solve a zero-sum game between adviser kernels and **payoff-vector kernels** rather than action kernels. This directly attacks the obstacle the project sources isolate: once (\Omega) is finite, infinite (\Theta) should be compressible, and the real headache is the topology on kernels over (M), plus the final messagewise patching step.   

   **Key intermediate steps.**

   * Define the reduced agent object as a kernel (\gamma:M\to \Delta(W)), or if purification works, a measurable selector (w(\cdot):M\to W).
   * Rewrite the payoff as
     [
     \widetilde U(\beta,\gamma)
     ==========================

     \int_M \tau(ds)\Big[
     \alpha \int_W s\cdot w,\gamma(dw\mid s)
     +(1-\alpha)\int_M\int_W s\cdot w,\gamma(dw\mid m),\beta(dm\mid s)
     \Big].
     ]
     This is affine in both (\beta) and (\gamma), and the integrand (s\cdot w) is bounded and continuous on compact (M\times W).
   * Apply a zero-sum saddle-point theorem for transition kernels. The theorem you want needs: convex strategy sets, compactness in the chosen kernel topology, and separate upper/lower semicontinuity of the payoff. Here compact metric (M) and compact metric (W) make those hypotheses plausible, but they still need verification.
   * Prove a **purification plus version-and-patching lemma**: starting from a saddle point ((\beta^*,\gamma^*)), choose a measurable version of (P_{\beta^*}(\cdot\mid m)) on all of (M), replace (\gamma^*(\cdot\mid m)) by a measurable selector (w^*(m)\in \arg\max_{w\in W} P_{\beta^*}(\cdot\mid m)\cdot w), then lift (w^*(m)) to an actual Bayes-optimal private strategy (\hat\sigma_m).

   **Likely failure point.** The crux is Stage 2, not Stage 1. A saddle point normally gives only message-distribution almost-everywhere optimality, while Definition 2 wants **every** (m\in M). Also, the lift from (w^*(m)) back to an actual private strategy needs a measurable selection theorem for Bayes-optimal private strategies, or an equivalent measurable right-inverse for the map (\hat\sigma\mapsto w). That is the null-set gremlin hiding in the machinery. **Needed assumption candidate, if the lift stalls:** a measurable Bayes selector (\mu\mapsto \hat\sigma^\mu), or an explicit measurable parametrization of private strategies by payoff vectors.  

   **Complexity estimate.** **High**, but this is the best full-target route.

2. **[SCOPE] First remove finiteness of (\Theta) while keeping (M) finite**

   **Core technique.** Use the same (W)-reduction, but keep the adviser support finite. Then the existence problem becomes a genuinely finite-dimensional minimax problem, so Sion can be applied almost verbatim after replacing private strategies by payoff vectors. This would prove that **finite (\Theta) is not the essential restriction** in Theorem 2.   

   **Key intermediate steps.**

   * By Appendix A.1, (W\subset \mathbb R^{|\Omega|}) is compact convex.
   * If (M) is finite, the agent’s reduced strategy space is (W^M), a compact convex subset of finite-dimensional Euclidean space.
   * The adviser’s strategy space is (B=\prod_{s\in M}\Delta(M)), also compact convex.
   * The reduced payoff
     [
     \widetilde U(\beta,(w_m)_{m\in M})
     ==================================

     \sum_{s\in M}\tau(s)\Big[\alpha, s\cdot w_s +(1-\alpha)\sum_{m\in M}\beta(m\mid s), s\cdot w_m\Big]
     ]
     is bilinear and continuous. Sion’s theorem applies because one set is compact convex, the other is convex, and the payoff is separately continuous and affine.
   * Choose, for each (m\in M), a private strategy implementing (w_m^*). Since there are only finitely many messages, any off-path message can be patched individually using the freedom in the choice of a regular conditional distribution on null events.

   **Likely failure point.** Very little should break here. The only real step is choosing an actual private strategy for each selected (w_m^*), but with finite (M) this is only a finite collection of selections, so the measurable-selection burden almost disappears.  

   **Complexity estimate.** **Medium.** This is the cleanest partial theorem, and I would try to prove it early.

3. **Direct behavioral-kernel minimax on the original game**

   **Core technique.** Do not reduce to (W). Work directly with adviser kernels
   [
   \beta:M\to \Delta(M)
   ]
   and agent kernels
   [
   \sigma:M\times \Theta \to \Delta(A),
   ]
   then apply a saddle-point theorem for behavioral strategies, in the Balder/Borkar/Young family. The literature note identifies this as the closest off-the-shelf theorem family for the full extension.  

   **Key intermediate steps.**

   * Choose a topology on kernels, not on induced strategic measures. The project sources explicitly warn that weak convergence of induced laws can destroy the information constraints.
   * Verify the theorem’s conditions in your own setting. The relevant conditions, stated abstractly, are: standard Borel or Suslin underlying spaces, compact action spaces, bounded payoff, existence of regular conditional probabilities, convexity of admissible kernel sets, and the right semicontinuity of the payoff in each strategic variable.
   * Use the theorem to obtain a saddle point ((\beta^*,\sigma^*)) for the global payoff (W(\beta,\sigma)).
   * Add a separate lemma upgrading global best reply to messagewise Bayes optimality for all (m\in M).

   **Likely failure point.** Two of them. First, the topology may be wrong: the literature note stresses that conditional-independence constraints are generally **not** preserved under naive weak or setwise convergence. Second, even a genuine saddle point only gives the global inequality, not the exact messagewise condition in Definition 2. **Needed assumption candidate, if the theorem does not plug in cleanly:** the exact compactness and semicontinuity package behind the chosen behavioral-kernel minimax theorem, once its hypotheses are unpacked in full detail.  

   **Complexity estimate.** **Very high.** Elegant if it works, but the topology could turn into quicksand.

4. **Approximate by finite games and pass to a limit**

   **Core technique.** Quantize (M) and, if needed, (\Theta), solve the finite approximating games using the paper’s existing theorem, and then pass to a limit of saddle points or TREs. This is the constructive route.  

   **Key intermediate steps.**

   * Build finite partitions (M_n) and (\Theta_n), and define approximating games where kernels are constant on partition cells.
   * Use the finite theorem to get saddle points ((\beta_n,\sigma_n)).
   * Embed these in a compactified space of kernels, ideally in the reduced (W)-representation rather than directly on strategic measures.
   * Prove convergence of values and pass the saddle inequalities to the limit.
   * Recover exact robust rationalizability by a final version-and-patching argument.

   **Likely failure point.** The literature note already waves a yellow flag here: approximation results in the Milgrom-Weber style naturally give density or (\varepsilon)-equilibria, not exact saddle points with exact messagewise rationalizability. Also, posterior kernels are only defined almost surely at each finite stage, so there is no obvious reason the limit should satisfy the pointwise “for every (m)” clause. **Needed assumption candidate:** continuity of (m\mapsto P_\beta(\cdot\mid m)) and a continuous or at least measurable Bayes selector, or else a closure theorem for the approximating kernel class.  

   **Complexity estimate.** **Very high.** I would keep it as backup, not as the lead horse.

My practical sequencing would be: prove **2** first, because it should fall if the Appendix A.1 reduction really does what it looks like; then recycle the lifting and patching ideas into **1**, which is the best shot at the actual no-finiteness target.  

[1]: https://arxiv.org/abs/2602.09490?utm_source=chatgpt.com "Robust Trust"
