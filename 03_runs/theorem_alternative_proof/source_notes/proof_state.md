# Proof State — Alternative Proof of Theorem 2

## Status: IN PROGRESS (Blocks A-B complete, Blocks C-D awaiting reviewer, Blocks E-F open)

This document tracks the mathematical state of the alternative proof verification.

## Theorem Statement

**Theorem 2 (Robustly Rationalizable Solution)**: Any robustly rationalizable strategy is optimal. If M and Θ are finite, a robustly rationalizable strategy exists.

**Alternative proof target (finite case)**: The sketch targets the finite-case existence/saddle-point/minimax part of Theorem 2, establishing it via FOC + envelope theorem instead of Sion's minimax theorem. It does NOT claim a different theorem — only a different route to the same finite-case result.

## Proof Architecture

The alternative proof decomposes into the following blocks:

### Block A: Setup and Notation Alignment

**Status**: COMPLETE (verified by formalizer, 2026-03-15)

Notation dictionary established. Key renamings:
- Sketch π(m|μ) = Paper β(m|μ) — misaligned adviser's reporting rule
- Sketch P(m) = Paper q_β(m) — marginal message probability (NOT the paper's trust-region map P(m))
- Sketch γ_m = Paper P_β(·|m) — agent's posterior over states given message m
- Sketch a*(μ) = Paper σ̂*(μ) — Bayes-optimal response at belief μ
- Sketch U(π,σ) = Paper U(β,σ) — zero-sum stage-game payoff

Suppressed objects: The sketch drops the agent's private type θ, the signal function f, the truthful strategy id, and the paper's private-strategy notation σ̂. These suppressions create genuine restrictions that must be addressed in translation (Block G-level concern).

### Block B: Posterior Belief Derivation

**Status**: COMPLETE (verified by formalizer, 2026-03-15)

The posterior formula is VERIFIED CORRECT after renamings. In paper-canonical notation:

P_β(ω|m) = [α τ(m) m(ω) + (1−α) Σ_{μ∈M} τ(μ) β(m|μ) μ(ω)] / q_β(m)

where q_β(m) = α τ(m) + (1−α) Σ_{μ∈M} τ(μ) β(m|μ).

Key verification: The truthful/misaligned decomposition of Pr(m|ω) and the identity μ₀(ω)Pr(s=μ|ω) = τ(μ)μ(ω) were confirmed correct but were compressed into one line in the original sketch.

### Block C: DM Payoff and First-Order Conditions

**Status**: IN PROGRESS (prover pass complete, awaiting reviewer)

**Prover response**: `logs/20260315T025500Z_prover_foc_envelope_response.md`

**Prover findings (2026-03-15)**:
- FOC derivation produced from scratch using simplex-preserving perturbation β_ε(m|μ) = β(m|μ) + ε[δ_{m₁}(m) − δ_{m₂}(m)] · 𝟙{μ=μ*}
- Direct effect: c(W(P_β(·|m₁)) − W(P_β(·|m₂))) where c = (1−α)τ(μ*)
- Indirect effect: handled via envelope theorem (see Block D)
- Full derivative collapses to V'(0) = (1−α)τ(μ*)(U(σ̂*_{m₁}, μ*) − U(σ̂*_{m₂}, μ*))
- KKT handled via variational inequality on Δ(M): no extra smoothness needed for support characterization
- Classical KKT multiplier form also derived under [ASSUMPTION+] differentiability of row objective
- μ* vs μ notation ambiguity resolved: row index must be the specific adviser belief μ*

1. Write payoff U(β,σ) = Σ_{ω,m} u(σ̂*(P_β(·|m)), ω) P_β(ω|m) q_β(m)
2. Take derivative with respect to β(m₁|μ*) − β(m₂|μ*) perturbation
3. Identify direct effect vs. indirect effect (through changing posteriors)
4. Supply full KKT / boundary analysis for simplex constraints on β(·|μ*)

### Block D: Envelope Theorem Application

**Status**: IN PROGRESS (prover pass complete, awaiting reviewer)

**Prover response**: `logs/20260315T025500Z_prover_foc_envelope_response.md`

**Prover findings (2026-03-15)**:
- Envelope theorem identified as Milgrom-Segal (2002), Theorem 3 (local equidifferentiability version, not the global absolute-continuity theorem)
- Key insight: reparametrize via Φ_m(ε) = q_{β_ε}(m) W(P_{β_ε}(·|m)) so parameter enters affinely through N_{β_ε}(m,ω), making envelope application clean
- Three hypotheses verified individually: (i) nonempty argmax via compactness [ASSUMPTION+], (ii) differentiability in ε via q_β(m) >= ατ(m) > 0, (iii) equidifferentiability via bounded utility and finite Ω
- "Indirect effect vanishes" clarified: what drops out is the derivative of the optimizing private strategy σ̂*_m(ε), not the derivative of the posterior P_{β_ε}(·|m)
- Bridge to formalizer's posterior-derivative formula: coordinate derivative ∂_{β(m|μ*)} P_β(ω|m) = (1−α)τ(μ*)/q_β(m) · (μ*(ω) − P_β(ω|m)) confirmed consistent
- Support changes: message support stable under perturbation since q_β(m) >= ατ(m) > 0; only row support of β(·|μ*) can change (handled by KKT)
- Sketch's phrase "absolutely equicontinuous in belief" flagged as imprecise [GAP]

1. State the exact version of the envelope theorem being used (Milgrom-Segal or Sinander)
2. Verify its hypotheses in the current setting
3. Show the posterior belief derivative is bounded:
   dP_β(·|m)/dε = (1−α) [β(m|μ*)τ(μ*)/q_β(m)] [P_β(·|m) − μ*]
4. Conclude the indirect effect vanishes at ε=0
5. Bridge: explain the logical step from "small perturbation of posteriors" to the exact envelope-theorem hypotheses

### Block E: Optimality Preservation Under Commitment

**Status**: NOT STARTED

1. Define the commitment game where DM commits to σ̂(m) = δ_{σ̂*(P_β(·|m))}
2. Show that bad AI's problem decomposes by μ:
   min_{β(·|μ)} Σ_ω u(σ̂*(P_β(·|m)), ω) β(m|μ) μ(ω)
3. Show that the FOC from Block C imply the original β remains optimal

### Block F: Minimax Conclusion

**Status**: NOT STARTED

1. Establish that sup inf = inf sup (the saddle point property)
2. Connect back to the paper's definitions of robustly rationalizable and optimal
3. Conclude Theorem 2

### Block G: Infinite Message Space Question

**Status**: NOT STARTED (explicitly flagged as open by Piotr)

Investigate whether the FOC approach can extend beyond finite M:
- What breaks in the argument?
- Is it fundamentally a finite-dimensional proof technique?
- Can partial extensions be salvaged?

## Verified Results

1. **Notation dictionary** (Block A): Complete mapping between sketch and paper notation. All inconsistencies identified and resolved. (Formalizer, 2026-03-15)
2. **Posterior formula** (Block B): Verified correct after renamings π→β, P(m)→q_β(m). (Formalizer, 2026-03-15)
3. **Formal theorem statement**: The alternative proof targets the finite-case existence/saddle-point part of Theorem 2, not a different theorem. (Formalizer, 2026-03-15)
4. **FOC derivation** (Block C): Prover produced complete derivation with direct/indirect effect decomposition, variational inequality KKT on Δ(M), and classical KKT multiplier form. μ*/μ notation ambiguity resolved. (Prover, 2026-03-15 — awaiting reviewer)
5. **Envelope theorem** (Block D): Identified as Milgrom-Segal (2002) Theorem 3 (equidifferentiability). All three hypotheses verified in finite setting. Clean reparametrization via unnormalized posteriors N_{β_ε}. (Prover, 2026-03-15 — awaiting reviewer)

## Open Questions

### Addressed by Prover (2026-03-15, awaiting reviewer confirmation)

1. **[ADDRESSED — Block C]** FOC derivative formula: Prover derived from scratch with simplex-preserving perturbation. Full decomposition into direct/indirect effects produced.
2. **[ADDRESSED — Block D]** Envelope theorem identified: Milgrom-Segal (2002) Theorem 3, with all hypotheses verified individually in the finite setting.
3. **[ADDRESSED — Block D]** Bridge from posterior derivative to envelope hypotheses: Provided via reparametrization through unnormalized posteriors N_{β_ε}(m,ω). Support changes addressed (message support stable under α > 0).
4. **[ADDRESSED — Block C]** KKT on supports: Variational inequality form derived without extra smoothness. Classical KKT multiplier form also provided under [ASSUMPTION+]. μ*/μ notation ambiguity resolved.
5. **[ADDRESSED — Block C]** "AI moves first" equivalence: Justified via message-by-message decomposition for fixed β plus minimax equality from Sion's theorem (paper's Appendix A.2).

### Remaining Gaps from Prover (8 total, mostly precision)

6. **[PRECISION — Block C/F]** "AI moves first" computes inf_β sup_σ U(β,σ), not automatically the paper's sup_σ inf_β U(β,σ). Equality requires the minimax/saddle-point step (deferred to Block F).
7. **[PRECISION — Block C]** The sketch differentiates as if simplex constraint were absent. Correct perturbation is feasible mass shift e_{m₁} − e_{m₂}, or variational inequality on Δ(M). (Prover supplied the correct form.)
8. **[PRECISION — Block D]** Sketch's envelope-theorem condition ("absolutely equicontinuous in belief") is imprecise. Correct condition is equidifferentiability of the objective family.
9. **[PRECISION — Block D]** "Indirect effect vanishes" is conceptually sloppy. What vanishes is the derivative of the optimizing private strategy, not the derivative of the posterior.
10. **[PRECISION — Block C]** Boundary cases β(m|μ*) = 0 require one-sided directional derivatives or KKT complementary slackness.
11. **[PRECISION — Block C]** Sign of posterior derivative depends on perturbation convention. Formalizer's formula uses shrinkage; prover's uses pairwise mass shift.
12. **[MODERATE — Block C/E]** Sketch suppresses θ. In paper's framework, correct object is σ̂*(μ), not pure action a*(μ). Pure-action notation valid only under [ASSUMPTION+] |Θ|=1.
13. **[DEFERRED — Block E-F]** Full equivalence between sequential reduced problem and original simultaneous game deferred.

### Still Open (pre-existing, not in Blocks C-D scope)

14. **[CRITICAL — Block F]** Translation back to σ̂/θ framework: No proof that the argument survives when private types and private strategies are reinstated.
15. **[MODERATE — Block B]** Posterior derivation compressed: Now verified by formalizer.
16. **[MODERATE — Block E]** Preservation of optimality in commitment game: Only support-based intuition given.
17. Does the envelope theorem application need any regularity beyond what's given (e.g., differentiability of σ̂*(P_β(·|m)) in P_β)? — Prover says no, envelope eliminates this need.
18. The FOC derivation implicitly assumes interior solutions for β(m|μ*). How are boundary cases handled? — Prover addressed via variational inequality.
19. Is the connection between the FOC conditions and the commitment-game optimality fully rigorous? — Deferred to Block E.

## Implicit Assumptions Catalogued by Formalizer

1. **On-path positivity / α > 0**: q_β(m) > 0 for all m ∈ M (automatic when α > 0)
2. **Finite-dimensional case**: finite M and Θ; Ω already finite in the paper
3. **Pure-action Bayes response exists**: a*(μ) is a selected pure action, not a mixed strategy σ̂
4. **Private type θ suppressed**: payoff written as u(a,ω) with no θ-dependence
5. **Regular Bayes-optimal selection**: a*(μ) behaves regularly under perturbations
6. **Interior perturbations capture the first-order problem**: simplex boundary not analyzed — NOW ADDRESSED by prover via variational inequality
7. **Restriction to messages in M**: removable (paper gives WLOG justification)
8. **Commitment problem separates by μ**: needs proof but is a simplification
9. **Envelope-theorem hypotheses hold**: explicitly assumed, not verified — NOW VERIFIED by prover (Milgrom-Segal Thm 3 equidifferentiability)

## Additional Assumptions Identified by Prover (2026-03-15)

10. **[ASSUMPTION+] Bayes-optimal private strategies exist**: Sufficient condition: finite Θ, compact metric A, bounded u, continuous u(·,ω,θ) in a. Used for envelope theorem argmax nonemptiness.
11. **[ASSUMPTION+] Row objective differentiability**: R(b*) differentiable at candidate β*. Only needed for classical KKT multiplier form; variational inequality form works without it.
12. **[ASSUMPTION+] Pure-action specialization**: |Θ|=1 and a pure Bayes-optimal selector exists at each posterior used. Only needed if insisting on sketch's a*(μ) notation instead of paper's σ̂*(μ).

## Dependencies

- Blocks A-B: COMPLETE → prerequisite for Blocks C-D satisfied
- Blocks C-D: PROVER PASS COMPLETE, AWAITING REVIEWER → if reviewer passes, prerequisite for Block E satisfied
- Block D prerequisite for Block E
- Block E prerequisite for Block F
- Block G is independent and exploratory
