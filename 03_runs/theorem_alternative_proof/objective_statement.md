# Alternative Proof of Theorem 2 — Objective Statement

## Theorem Being Proved

**Theorem 2 (Robustly Rationalizable Solution)** from Dworczak & Smolin, "Robust Trust" (2026).

> *Any robustly rationalizable strategy is optimal. If M and Θ are finite, a robustly rationalizable strategy exists.*

Equivalently: the zero-sum game between the agent and the misaligned adviser has a saddle point — commitment does not help the agent.

## What This Project Does

Formalize, verify, and (where possible) complete an **alternative proof** of Theorem 2 sketched by Piotr Dworczak. The alternative proof uses **first-order conditions and the envelope theorem** instead of Sion's minimax theorem.

## Proof Strategy (Piotr's Sketch)

The proof works in two stages:

### Stage 1: Finite Case

1. Fix a finite state space Ω, finite message space M, and finite type space Θ.
2. Suppose the misaligned adviser (bad AI) plays strategy π, inducing posterior beliefs γ_m at each message m.
3. Assume AI moves first, so the DM observes the true distribution of posteriors and best-responds.
4. Take the derivative of the DM's payoff with respect to π(m₁|μ*) − π(m₂|μ*).
5. Apply the **envelope theorem** to eliminate the second-order term arising from changes in the optimal action a*(γ_m).
6. Derive first-order conditions showing that at any optimum of the simultaneous game, for all μ* and messages m₁, m₂ ∈ supp(π(·|μ*)):
   ∑_ω [u(a*(γ_{m₁}), ω) − u(a*(γ_{m₂}), ω)] μ*(ω) = 0
7. Consider the commitment game where the DM commits to σ(a|m) = δ_{a*(γ_m)}. Show that bad AI's strategy π remains optimal in this commitment game.
8. Conclude: the simultaneous-move value equals the commitment value — i.e., the minimax theorem holds.

### Stage 2: Envelope Theorem Verification

Verify the envelope theorem applies by showing:
- The objective is absolutely equicontinuous in beliefs (trivially true).
- A small perturbation in π produces a bounded perturbation in posterior beliefs:
  dγ_m(ω)/dε = (1−α) × [π(m|μ*)τ(μ*)/P(m)] × [γ_m(ω) − μ*(ω)]
- Reference: Milgrom & Segal, or Sinander.

## Known Gaps In The Sketch

1. **Envelope theorem formalization**: The sketch invokes the envelope theorem informally. The formal conditions (Milgrom-Segal or Sinander) need to be stated and verified precisely in the context of this game.

2. **Extension to infinite message space**: Piotr explicitly states "I have no idea how to extend the argument" beyond finite M. The FOC approach is inherently finite-dimensional.

3. **Notation consistency**: Piotr warned the notation may be inconsistent with the paper.

## Scope

- **Primary goal**: Rigorously formalize the finite-case alternative proof (Stage 1 + Stage 2).
- **Secondary goal**: Identify whether this approach can extend to infinite M or whether it is fundamentally limited to the finite case.
- **Non-goal**: We are NOT extending Theorem 2 to weaker assumptions. That is the separate project in `Context Management/`.

## Relationship to Paper Proof

The paper's proof of Theorem 2 (Appendix A.2) uses Sion's minimax theorem directly:
- Shows U(β,σ) is concave-convexlike
- Applies Sion (1958) to swap sup inf = inf sup
- Constructs saddle point from the minimax equality

The alternative proof replaces Sion's theorem with a direct FOC + envelope theorem argument. Potential advantages:
- More constructive / economically interpretable
- Shows WHY the saddle point works through optimality conditions rather than abstract minimax
- May generalize differently than the Sion-based approach

## Source Documents

- Paper: `Robust_trust_Dworczak_Smolin.pdf`
- Alternative proof sketch: `Robust trust_alternative proof_minimax theorem.pdf`
