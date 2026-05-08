# Prior attempts on the Theorem 2 infinite-extension — what was tried, what failed

*Concise digest. Intended as a durable ChatGPT source so future passes do NOT
re-propose strategies that have already been worked through. Read this before
proposing a route.*

## Goal (unchanged from `objective_statement.md`)

Prove the **existence direction** of Theorem 2 in Dworczak & Smolin (2026,
*Robust Trust*) without assuming finite $M$ or finite $\Theta$. Standing
assumptions: $\Omega$ finite with full-support prior; $A$ and $\Theta$ compact
metric; $u$ bounded and continuous in $a$; conditional independence of $s$ and
$\theta$ given $\omega$. The optimality direction is finiteness-free already.

## Attempt 1 — `Context Management/` (the large primary attempt — the one whose ChatGPT project was deleted)

This is the most extensive prior pass. Hundreds of packets across many routes;
final architectural verdict was an **honest stop**:
`ACCEPT_CONDITIONAL_ENDPOINTS` plus `NO_HONEST_CANDIDATE` for further primitive
search.

Key results worth carrying forward (each was reviewer-`PASS`'d):

- **Negative — escape of mass.** On the countable-atomic attainment route the
  unconditional extension is **false** under the standing assumptions:
  there is a genuine escape-of-mass counterexample for adversary-side
  attainment in $\prod_{\mu \in I} \Delta(M)$. The exact surviving positive
  result is conditional on rowwise-uniform tightness of near-minimizers.
- **Positive (conditional).** Under explicit near-optimal-sublevel-set
  tightness OR an explicit `Needed assumption` (selected variants:
  saddle-specific continuity of the collapsed selector, $q^*$-a.e.
  injectivity of fibers), the conditional exact-route theorem closes
  cleanly, with the alternative-proof's selector/subgradient mechanism
  reactivating in the Banach pair $\big(\prod_\mu \ell^1(M),\, \prod_\mu \ell^\infty(M)\big)$.
- **Negative — exact raw lifting.** Exact measurable lifting / exact raw
  attainment fails in general; only the value theorem and a separate
  conditional patching lemma survive.
- **Negative — primitive search.** No genuinely earlier model-side primitive
  is visible on the present record (`HOLD` then `NO_HONEST_CANDIDATE`).

Routes that were exhausted on this attempt (do **not** re-propose without a
genuinely new ingredient):

1. Topological reduced-game saddle on full measurable agent class $W^M$ —
   blocked by failed semicontinuity.
2. Atomic-truncation-limit raw black-box passage — blocked by a substantive
   counterexample.
3. Direct lift on countable-atomic — blocked by a finite counterexample.
4. Continuous-image / posterior-labeled lift — blocked by within-fiber
   posterior-transport obstruction; second-order liftability also blocked.
5. Cross-coordinate uniformization (finite-palette → tail-stability →
   monotone-refinement → recurrence) — every one diagnosed and reviewer-cleared
   as **non-derivable** on the present record. The deepest blocker is a
   missing exact recurrence upgrade from tail-limsup/closure-of-tail-unions
   membership to exact recurring fiber membership for $j \mapsto K_j$.
6. Eventual movement / eventual single-ray collapse / cofinite-tail setup
   for $S_{\mathrm{ray}}$ admissibility — all open and not derivable.

Final live route reset (2026-03-17, never executed): countable-atomic $M$,
finite row index $I$, bounded payoffs, Bayes selector existence, adversary
attainment/tightness in $\prod_\mu \ell^1(M)$ — using the finite-case
alternative proof's selector/subgradient architecture.

**Net:** Attempt 1 demonstrates that the unconditional extension under
standing hypotheses is genuinely *blocked* and that continuing inside the
same architectures is no longer productive. The honest endpoint is conditional.

## Attempt 2 — `proof_attempt_archivara_pass1/` (Sion + Tychonoff + KRN)

A separate later pass that produced a full draft + Lean formalization. Verdict
**REVISE**, not accepted.

- Strategy: equip $\Sigma = \prod_{(m,\theta)} \Delta(A)$ and
  $B = \prod_\mu \Delta(M)$ with the **product-of-narrow** topology
  (Tychonoff → compact, convex). Affineness in each argument; continuity by
  bounded convergence; Sion (4.2'); per-message Bayes-optimality via
  Kuratowski–Ryll-Nardzewski.
- **Critical gap (Lemma 4.4, continuity in $\beta$).** The marginal-based
  argument routes through $\lambda_\omega^\beta = \int_M \tau(d\mu)\,\mu(\omega)\,\beta(\cdot\mid\mu)$
  and integrates a test function $g_\sigma(m,\omega)$. Narrow convergence of
  $\lambda_\omega^{\beta_n}\to\lambda_\omega^\beta$ plus boundedness of
  $g_\sigma$ is not enough — it also requires $g_\sigma$ to be **continuous in
  $m$**, which the product topology on $\Sigma$ does NOT deliver. The proposed
  patch ("convergence per $\mu$ then bounded convergence over $\tau$") was
  sketched but never executed and has the same hidden issue.
- **Lemma 4.3 (continuity in $\sigma$):** measurability of the integrand on
  $M\times\Theta$ was sketched, not proven.
- **Lean formalization:** the `GameSetup` structure **axiomatizes** compactness,
  convexity, continuity, and affinity. The "zero sorry in main theorem" claim is
  technically accurate but the hard work (Sion's hypotheses for the concrete
  kernel spaces) lives outside Lean. KRN is sorry'd but not actually invoked.
- Fallbacks listed but never executed: Sion via lower-semicontinuity instead
  of full continuity; finite-$M$ approximation $M_k\uparrow M$.

## Attempt 3 — `Theorem_alternative_proof/` (FOC + envelope, finite case only)

Off-topic for the current goal. Piotr's alternative-proof sketch replaces
Sion's minimax in the **finite case** with a first-order / envelope-theorem
route ($\beta$-perturbation + Milgrom–Segal Theorem 3). The infinite-message
Block G was never opened.

Final reviewer (2026-03-25, comprehensive): `PATCH_BIG`. Section 6 (selector
family, Prop 6) Step 2 partial derivative $g_m(\mu, m')$ is miscomputed; the
multivariate subgradient claim cannot rest on Prop 4 alone. Block F (minimax
conclusion) proves existence of *one* robustly rationalizable optimal $\sigma$
but NOT that *any* robustly rationalizable $\sigma$ is optimal.

## Recurring deep obstruction across all three attempts

Adversary-side **attainment / compactness** in the natural Banach setting
($\prod_\mu \Delta(M)$ or its $\ell^1$ cousin) is the rock everything bangs
against. Whether you go via Sion + Tychonoff (Attempt 2), via the
selector/subgradient FOC apparatus (Attempts 1 & 3), or via topological
reduced-game saddle, you eventually need either (a) a continuity-in-$\beta$
that the product topology does not give for bounded *measurable* test
functions, or (b) a tightness/coercivity condition on near-minimizers that
the standing hypotheses do not force.

## What this means for the current attempt (do NOT re-propose)

- Do **not** retry the product-topology + Sion route as written — Lemma 4.4
  has a structural hole and the proposed direct fix has the same hole.
- Do **not** retry the FOC + envelope route from Attempt 3 in the infinite
  case — the apparatus is built around finite simplex perturbations and Block
  G was never opened.
- Do **not** retry any of the cross-coordinate uniformization shapes from
  Attempt 1 (finite-palette, tail-stability, monotone-refinement, recurrence)
  — each was reviewer-cleared as non-derivable.
- Do **not** propose "axiomatize the GameSetup, prove the abstract Sion → RR
  reduction in Lean" — that was the structurally weakest part of Attempt 2.
- Do **not** propose the cofinite-tail $S_{\mathrm{ray}}$ admissibility, the
  $U\cup C<\infty$ finiteness lemma, or the realization/duality bridge — all
  open and reviewer-cleared as non-derivable.

## What is genuinely new (Phil Reny's contribution)

A two-stage path that **avoids the broken adversary-side attainment step**:

1. **Restrict** player 2 to absolutely-continuous-vs-$\bar G$ kernels
   (the convex set $F$ of jointly measurable $f(m\mid s)$ on $S\times S$,
   where $\pi(dm\mid s) = f(m\mid s)\bar G(dm)$). On the restricted game, the
   payoff is **continuous in $\sigma$** in the topology where
   $\sigma_n\to\sigma$ iff $\sigma_n G(\cdot\mid\omega)$ weak\* converges to
   $\sigma G(\cdot\mid\omega)$ for each $\omega$ — *because the marginal
   $\sigma_n\bar G$ on $M$ is constant* (Balder 1988 weak convergence of
   transition probabilities with a fixed marginal). $\Sigma$ is compact in
   this topology; $F$ is convex. Apply **Mertens (1986) Corollary B**
   (minmax for u.s.c. payoffs without joint continuity in player 2) to get
   $\max_\sigma \inf_F U(\sigma,f) = \inf_F \max_\sigma U(\sigma,f)$ and an
   optimal $\sigma^*$ on the restricted game.
2. **Lift** the restriction on player 2 by Lusin regularization: choose
   compacts $S_n\uparrow S^*$ on which $\sigma^*$ is continuous AND that are
   "support-thick" against $G(\cdot\mid\omega)$. Any measurable deviation
   $d:S\to S$ that beats $\sigma^*$ must send messages outside $S^*$ a.s.;
   support-thickness lets us turn that into a continuous-on-some-$S_k$
   deviation, contradicting $\sigma^*$'s optimality on the restricted game.

This is structurally orthogonal to all three prior attempts:
- it does NOT need adversary-side attainment in the full kernel space;
- it does NOT use Sion-on-product-of-narrow;
- it does NOT use the FOC apparatus;
- it bypasses the cross-coordinate uniformization machinery entirely;
- the **constant-marginal trick** (Balder 1988) is the technical hammer that
  was missing from every prior attempt.

**Open caveats acknowledged by Phil:**
- Delivers existence of $\sigma^*$ for player 1 only, NOT existence of an
  adversarial $\beta^*$ for player 2. Theorem 2 needs both. The
  robust-rationalizability conclusion (per-message Bayes-optimality at each
  on-path $m$) requires $\beta^*$; closing that is an explicit task.
- "Lots of details to check here. So the probability of an error is
  non-trivial."

## Useful artifacts already produced (re-usable)

- `proof_attempt_archivara_pass1/theorem2_analysis.md`: clean enumeration of
  the six places where finiteness enters the original proof. Five are
  finite-friendly; the sixth (per-$m$ Bayes-optimality from the global saddle)
  is the measurable-selection step.
- `Theorem_alternative_proof/source_notes/proof_state.md`: notation
  dictionary $\pi\to\beta$, $P(m)\to q_\beta(m)$, $\gamma_m\to P_\beta(\cdot\mid m)$,
  $a^*(\mu)\to\hat\sigma^*(\mu)$.
- `proof_attempt_archivara_pass1/REPORT.md` Section 5.1: the observation that
  the **finiteness of $\Omega$** (not of $M$ or $\Theta$) is the structural
  feature that makes integrals tractable.
- `Context Management/source_notes/atomic_truncation_counterexample.md` and
  `escape_of_mass`-related artifacts: concrete counterexamples showing that
  certain naive routes are *false*, useful as guardrails.
