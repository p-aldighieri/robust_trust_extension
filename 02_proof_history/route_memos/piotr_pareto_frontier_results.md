# Piotr Pareto-frontier route — final results (Pass 3, 2026-05-21)

*Author: orchestrator. Status: terminal results memo for the third pass at
the Robust Trust Theorem 2 infinite extension. All claims below have been
reviewer-verified on independent fresh chats with Extended Pro.*

## Executive summary

The Pareto-frontier-set reformulation \(\mathcal G_P\) (Piotr Dworczak,
2026-05-20) was attacked via the **Clarke-Danskin stationarity** route
identified by the searcher. The honest endpoint:

| Theorem | Status | Hypotheses beyond standing |
|---|---|---|
| (T1) Finite-menu Pareto-Hall calibration (payoff-label coords) | **Unconditional** ✓ | None |
| (T2) α=0 (pure adversarial) original-game Theorem 2 | **Unconditional** ✓ | None |
| (T3) α>0 original-game Theorem 2 | **Conditional** | (D2) ≡ menu-Hall |
| (T4) Compact-menu Pareto-Hall calibration (payoff-label coords) | **Conditional** | (R1) + (R2-FES) or (R3-FCA/PK) |
| (T5) Unrestricted infinite Theorem 2, all α | **Open** | — |

The locked gate is structural across all known reformulations: it is the
**deletion-compatible Hall duality theorem** named in the v8 closure memo.
This pass independently re-confirmed the structural blockage by attacking
from a new direction (Lagrange multipliers on the Pareto-frontier hyperspace,
instead of v8's menu engine).

## What is genuinely new (versus v8)

1. **A new proof technique — Clarke-Danskin stationarity on \(W^P\).**
   The agent's value functional
   \[F_k(w_1,\ldots,w_k) = \int_M[\alpha\max_i s\!\cdot w_i + (1-\alpha)\min_i s\!\cdot w_i]\,\tau(ds)\]
   on finite menus has a Clarke subdifferential representable in
   **measurable active-face weights** \(\lambda^\pm: M\to\Delta(k)\). At an
   ambient local maximizer, Fermat stationarity forces
   \(g_i = \alpha\int\lambda_i^+(s)s\,d\tau + (1-\alpha)\int\lambda_i^-(s)s\,d\tau \in N_W(w_i)\).
   The normalized vector \(p_i = g_i / q_i\) is the calibrated finite-label
   posterior, in \(B_W(w_i) = N_W(w_i)\cap\Delta(\Omega)\) when \(q_i > 0\).
   **Calibration emerges as a Lagrange multiplier**, not as an external Hall
   assumption.

2. **α=0 unconditional infinite-extension via singleton strategy.**
   In the pure adversarial regime, the optimal menu collapses to the
   singleton \(\{w_0\}\) with \(w_0\in\arg\max_{w\in W}\mu_0\!\cdot w\)
   (Bayes-optimal at the prior). The agent ignores advice (plays \(R(w_0)\)
   for every message); the adversary sends a fixed message \(m_0\); the
   only on-path posterior is \(\mu_0\); the agent's continuation is
   Bayes-optimal at \(\mu_0\). Definition 2 is satisfied without any
   finiteness of \(M\) or \(\Theta\).
   This **strictly generalizes** the paper's Theorem 2 existence direction
   in the \(\alpha = 0\) regime.

3. **Cleaner Tier 1a + payoff-vector adversary attainment.**
   In \(\mathcal G_P\), value optimality \(C^*\in\arg\max V_P\) follows from
   Hausdorff-compactness of \(\mathcal K(W^P)\) + continuity of \(V_P\)
   (Blaschke), and the payoff-vector adversary best-response
   \(\beta^*(s)\in\arg\min_{w\in C^*}s\!\cdot w\) is automatic by KRN on
   the compact-valued correspondence \(s\mapsto C^*\). The (A8c-lsc)
   hypothesis from v5/Phil-Reny is **dispensed with** in the reduced game.

4. **Compact-menu Pareto-Hall under economically meaningful primitives.**
   Under (R1) stratification of \(W^P\) + (R2-FES) finite effective
   exposure of the optimal menu (economically: the agent's effective
   response is finite-menu, even when the abstract menu is a continuum),
   the payoff-label Pareto-Hall calibration extends to compact menus.
   This is **meaningfully weaker** than v8 menu-Hall in payoff-label
   coordinates — the calibration is produced by finite Clarke-Danskin
   stationarity, not assumed.

## What is NOT new (the honest assessment)

5. **For α > 0 + original-message Definition 2**: the lift from payoff-
   label calibration back to original-game messages requires (D2)
   "finite-fiber calibrated matching", which is shown to be the
   **finite-fiber version of v8's menu-Hall** — not a strictly weaker
   primitive condition.
   Both Reviewer 03 and Searcher 02 verify this independently. The
   apparent simplification (calibration emerges as a Lagrange multiplier
   in payoff-label coordinates) does not survive the lift back to
   original messages because of the **aligned/misaligned mismatch**:
   in the reduced game, both aligned tie-routing weights \(\lambda^+\)
   and misaligned weights \(\lambda^-\) co-define each label's posterior;
   in the original game, aligned mass lives at the literal truthful
   message \(s\), not at the representative \(m_i = w^{*-1}(w_i)\).

6. **Searcher 02 ruled out** seven candidate primitive conditions for
   (D2) (atomless + fiber-rich, single-valued Gauss, τ-symmetry, smooth
   + strictly convex \(W^P\), product utility, coarsening, fiber-rich
   Lagrangian transport). The closest candidate (fiber-rich Lyapunov +
   Lagrangian transport, C7) collapses **back into** menu-Hall when
   stated rigorously.

## The locked gate remains the deletion-compatible Hall duality

This pass independently confirms the v8 closure memo's diagnosis: the
single open object is a deletion-compatible Hall duality theorem
connecting sourcewise minimizer support with messagewise Bayes-cone
calibration. The Pareto-frontier route does not break this gate.

The new technique (Clarke-Danskin stationarity) does *reframe* the
problem in finite-label Lagrange-multiplier coordinates — which has
expository and pedagogical value — but the underlying transport
problem is structurally the same.

## Compatibility with the v8 sharpness package

- v8 Lemma 7 (cone intersection) and Theorem 8 (no-free-dust) are
  consistent with all results above. The v8 WTA ternary witness is **not**
  a finite ambient local maximizer in the Lemma 7 sense — it is a
  menu-engine artefact (as classified in the v8 closure memo) and does
  not contradict (T1) or (T4).
- Searcher 02 confirmed that the witness's geometry rules out
  primitive sufficient conditions like "smooth + strictly convex \(W^P\)"
  but does not block (T1) finite-menu Pareto-Hall.

## Path forward (per Searcher 02's explicit recommendation)

> "Consolidate rather than continue broad primitive search. Keep the
> finite-menu Pareto-Hall theorem as a valuable payoff-label result,
> state the α=0 original-game lift as a clean corollary, and present
> α>0 robust rationalizability as conditional on D2/menu-Hall. Future
> work should be framed narrowly as a deletion-compatible Hall duality
> theorem or as special primitive islands such as binary monotone or
> antipodal/radial symmetry, not as another attempt to get D2 from
> atomlessness, fiber richness, or smoothness alone."

Specific recommendations for the project's next phase:

1. **Publishable α=0 standalone note.** Write up (T2) as a short paper
   or appendix. The singleton-strategy proof is elementary and gives
   a clean infinite-extension corollary.
2. **Finite-menu Pareto-Hall as a methodological contribution.** (T1) +
   the Clarke-Danskin technique is a reusable proof method, applicable
   beyond robust trust to other zero-sum persuasion-like games with
   finite-effective payoff-profile menus.
3. **Compact-menu under (R1)+(R2-FES) as a publishable Tier 2.** This is
   meaningfully weaker than v8 Tier 2 (the regularity is on the menu
   structure, not on the calibration); positions the route as a
   strict refinement of v8 in the payoff-label setting.
4. **Special primitive islands** (binary monotone, antipodal/radial
   symmetry) are the most promising directions for future passes,
   per Searcher 02. These are the same islands flagged in v8 (binary
   from paper Appendix A.6; spherical from §5.2 + Appendix A.10).

## Verified pipeline trace

| Role | Chat ID | Verdict |
|---|---|---|
| Formalizer 01 | `6a0e88b1` | Reformulation precise; Bayes-calibration ≡ menu-Hall |
| Literature 01 | `6a0e8b5e` | BUILD; closest candidate: Dworczak-Kolotilin persuasion duality |
| Searcher 01 | `6a0e8f51` | Primary route: R1/R9 Clarke-Danskin stationarity |
| Breakdown 01 | `6a0e95c1` | 12-lemma chain |
| Prover 01 (L6) | `6a0e9994` | Integral Clarke-Danskin representation |
| Reviewer 01 (L6) | `6a0e9cfe` | PATCH_SMALL — Step 2 used L5 equality, fixed with R(s)⊇Ψ(s) |
| Prover 02 (L7+L8) | `6a0ea088` | Fermat → normality; calibration is the multiplier |
| Reviewer 02 (L7+L8) | `6a0ea3ca` | **PASS** — finite-menu Pareto-Hall calibration theorem ✓ |
| Prover 03 (L12 lift) | `6a0ea7b0` | α=0 unconditional; α>0 needs (D2)≡menu-Hall |
| Breakdown 02 (compact) | `6a0ea80b` | (R1)+(R2-FES) capstone; (R3-FCA/PK) capstone |
| Reviewer 03 (α=0 + D2) | `6a0eaf03` | **Both claims PASS**; singleton-strategy proof for α=0 |
| Searcher 02 (D2 primitives) | `6a0eaf16` | No primitive sufficient condition; consolidate |

## Pipeline metadata

- Tool: MathPipeProver smart-scaffolding mode.
- External engine: ChatGPT Extended Pro on CDP port 9227.
- Project URL: `https://chatgpt.com/g/g-p-69fab2d4ab288191a33c6245f4e28957-robust-trust-extension/project`
- Heartbeat: every 15m, cancelled after consolidator completes.
- Pipeline phases used: formalizer, literature, searcher, breakdown,
  prover (×3), reviewer (×3), searcher (final long-shot).
- Reviewer policy: every prover output reviewed on a fresh chat
  (independent context).
- Banned re-proposals confirmed avoided: product-of-narrow Sion, τ-AC
  restriction \(F\subset B\), FOC + envelope on the original strategy
  game, canonical/minimal menu pruning without deletion-compatible Hall,
  ε-menu-Hall as primary.

## Closing

This pass should be considered terminal for the broad Pareto-frontier
attack. The route's positive contributions ((T1), (T2), Tier 1a
cleanup, compact-menu (T4)) are publishable; the negative finding (no
primitive sufficient condition for (D2)) consolidates the v8 closure
memo's diagnosis from an independent direction.

Future work should follow Searcher 02's recommendation: either attack
the deletion-compatible Hall duality theorem directly, or work on
special primitive islands where structural symmetry breaks the
calibration deadlock.
