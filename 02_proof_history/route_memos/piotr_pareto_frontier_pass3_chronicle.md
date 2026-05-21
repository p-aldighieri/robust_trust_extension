# Pass 3 chronicle — Piotr Pareto-frontier route

*Date: 2026-05-20 to 2026-05-21. Status: closed first attempt, restarted by user request 2026-05-21.*

## What we did

### Setup (2026-05-20)

- User opened session **PIOTR | ROBUST TRUST EXT 3** with Piotr's verbatim
  reformulation: "agent picks a subset of the weak Pareto frontier of payoffs,
  adversary maps signals into vectors in that subset". Explicit instruction:
  *"You shouldn't stop until you get the answer."*
- Discovered Chrome on port 9227 (not the INIT-specified 9223) was already
  attached to the robust trust extension project. Updated memory.
- Curated durable sources: paper PDF, objective statement, prior attempts
  digest, project closure memo, v8 proof, exposition_v8.2_final.pdf, plus
  the new route memo.
- Located Lemma 2 of Theorem 1's proof in the paper (p. 27): *any optimal
  σ* is equivalent to one using Bayes-optimal private strategies for all
  m ∈ Δ(Ω)*. This is the WLOG hammer Piotr's reformulation hangs on.

### Architecture passes (2026-05-20)

| Pass | Output | Key finding |
|---|---|---|
| Formalizer 01 | precise `G_P` game definition | Bayes-calibration equivalent to menu-Hall in C-coordinates |
| Literature 01 | tool survey | BUILD verdict; closest tool is Dworczak-Kolotilin persuasion duality |
| Searcher 01 | route ranking | Primary route: R1/R9 finite-active-menu Clarke-Danskin stationarity |
| Breakdown 01 | 12-lemma chain | Lemma 8 (multipliers = calibration kernel) is the hinge |

### Lemma chain (2026-05-21)

| Pass | Lemma | Verdict |
|---|---|---|
| Prover 01 | L6 Integral Clarke-Danskin representation | PATCH_SMALL: equality form too strong on ties; replaced with R(s)⊇Ψ(s) |
| Reviewer 01 | L6 verification | PATCH_SMALL → effectively PASS after inline patch |
| Prover 02 | L7 Fermat + L8 calibration hinge | Capstone finite-menu Pareto-Hall stated |
| Reviewer 02 | L7+L8 verification | **PASS** — finite-menu Pareto-Hall closes unconditionally |

### Lift and final passes (2026-05-21)

| Pass | Output | Verdict |
|---|---|---|
| Prover 03 | L12 original-message lift | α=0 unconditional ✓; α>0 requires (D2) finite-fiber calibrated matching |
| Breakdown 02 | Compact-menu lift roadmap | Capstone 1 under (R1)+(R2-FES); Capstone 2 under (R3-FCA/PK) |
| Reviewer 03 | α=0 + (D2)≡menu-Hall claims | Both PASS; α=0 has even cleaner singleton-strategy proof |
| Searcher 02 | Primitive sufficient conditions for (D2) | 7 candidates (C1-C7) all fail; recommend consolidation |

### Consolidation (first attempt, 2026-05-21)

- Wrote `piotr_pareto_frontier_results.md` summarizing the four results.
- Committed Pass 3 to git on main branch.
- Cancelled heartbeat and pushed proactive notification to user.
- **User immediately overrode** the "consolidate" recommendation, asked
  for the pipeline to keep trying, and clarified that α=0 is a degenerate
  pure-adversarial case (not "no atoms" as the orchestrator's
  notification could be misread).

### Consolidation (second attempt, 2026-05-21)

Per user request:
- Wrote `exposition_v9.tex` combining v8 menu engine with Pass 3 novel
  results.
- Wrote this chronicle.
- Updated `prior_attempts_digest.md` to record Pass 3 closure.

The user's plan after consolidation: restart the pipeline with fresh
attack vectors targeting the (D2) gate.

## What was learned

### Genuinely new positive contributions

1. **Clarke-Danskin finite-menu Pareto-Hall calibration theorem** —
   calibration as a Lagrange multiplier, not as an external Hall
   assumption. Unconditional in payoff-label coordinates. New proof
   mechanism portable beyond robust trust.
2. **α=0 unconditional infinite-extension via singleton strategy** — the
   degenerate pure-adversarial case has a one-line proof: agent ignores
   advice, plays Bayes-optimal at prior; adversary sends a constant
   message; calibration holds at the prior automatically.
3. **Compact-menu Pareto-Hall under (R1)+(R2-FES)** — meaningfully weaker
   than v8 menu-Hall in payoff-label coordinates. Economically meaningful
   primitive: the optimal menu's effective response is finite.

### Honest negative finding

4. **(D2) ≡ menu-Hall for general α ∈ (0,1) in original-message
   coordinates.** The locked gate is structurally the same as v8's
   deletion-compatible Hall duality, just in different coordinates. Seven
   primitive candidates were ruled out: atomless+fiber-rich Lyapunov,
   single-valued Gauss map, τ-symmetry, smooth+strictly convex W^P,
   product utility, coarsening, fiber-rich Lagrangian transport.

### Structural lessons

- **The Pareto-frontier reformulation cleanly improves Tier 1a** (eliminates
  v5/Phil-Reny's A8c-lsc) and **opens the finite-menu Tier 2 by Lagrange
  multipliers**, but does **not** break the original-game lift bottleneck.
- The aligned/misaligned mismatch is structural: aligned-truthful mass
  lives at literal m=s; misaligned label-routing requires representatives
  in (w*)^{-1}(w_i). Forcing the two to give a calibrated posterior at
  each m is the same Hall transport problem under different coordinates.
- v8 sharpness witness (WTA ternary) is *not* a finite ambient local
  maximizer — confirming v8 closure memo's classification as menu-engine
  artefact, not primitive counterexample.

## What didn't work (so future passes don't reattempt)

- (C1) Atomless τ + fiber-richness alone is too weak for (D2).
- (C2) Single-valued Gauss map at C* clarifies but does not solve.
- (C4) Smooth + strictly convex W^P is meaningful regularity but
  not sufficient.
- (C5) Product/separable utility u(a,ω,θ) = u₁(a,ω) + u₂(a,θ) is not
  a useful sufficient condition.
- (C6) Coarsening / pure-aligned-redirect helps for exact-contact but
  not for (D2).
- (C7) Fiber-rich Lyapunov + Lagrangian transport collapses to (D2)
  when stated rigorously.

## Recommended next-pass attack vectors (per searcher 02)

- **Special primitive island: binary state** (|Ω|=2). Paper Appendix
  A.6 covers finite M; push to infinite M, Θ.
- **Special primitive island: antipodal/radial τ-symmetry**. Spherical
  case (paper Appendix A.10) plus rotational invariance.
- **Polyhedral W with finite-faced optimal trust region**: combines (R1)
  + finite faces; reduces (R2-FES) to finite-vertex.
- **Direct attack on the deletion-compatible Hall duality theorem**
  with NEW tools not surveyed in Pass 3: Beiglböck-Nutz martingale OT
  with cone constraints, Doval-Smolin persuasion-and-welfare full
  framework, Lipnowski-Ravid weak-institutions.
- **Theorem 1's connected trust region** combined with Clarke-Danskin:
  any optimal σ* has connected T; C* = w*(T) is therefore connected
  compact in W^P. Whether connectedness combined with (R1) breaks the
  D2 gate is unverified.

## Files

Pipeline artifacts: `03_runs/piotr_pareto_frontier/`:
- `formalizer_01_*.md`, `literature_01_*.md`, `searcher_01_*.md`,
  `breakdown_01_*.md`, `prover_01_*.md`, `reviewer_01_*.md`,
  `prover_02_*.md`, `reviewer_02_*.md`, `prover_03_*.md`,
  `breakdown_02_*.md`, `reviewer_03_*.md`, `searcher_02_*.md`,
  `session_state.md`.

Route memos:
- `02_proof_history/route_memos/piotr_pareto_frontier_route_memo.md` —
  the initial route memo (working hypothesis).
- `02_proof_history/route_memos/piotr_pareto_frontier_results.md` —
  the first-pass closure (overridden by user; kept as a record).
- `02_proof_history/route_memos/piotr_pareto_frontier_pass3_chronicle.md` —
  this file.

Exposition:
- `01_deliverables/exposition/exposition_v9.tex` — Pass 3 exposition
  combining v8 menu engine with Pareto-frontier novel results.
