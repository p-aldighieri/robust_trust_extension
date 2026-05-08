# Formalized Alternative Proof — Working Draft

## Status: SKELETON (awaiting formalizer pass)

This document records the formalized version of Piotr's alternative proof sketch, aligned to the paper's notation and conventions.

---

## Setting (Finite Case)

Fix a finite state space Ω = {ω₁, ..., ω_N}, |Ω| = N.

The adviser observes a signal s drawn from π : Ω → Δ(S), where S = Δ(Ω). Identify the signal with the posterior it induces: μ = posterior about ω given s. Let τ denote the unconditional distribution of the adviser's posteriors, M = supp(τ), |M| = K < ∞.

With probability α, the adviser is aligned and reports μ truthfully (sends message m = μ). With probability 1 − α, the adviser is misaligned and sends message m according to a strategy π(m|μ), where π(·|μ) ∈ Δ(M) for each μ ∈ M.

**Notation alignment note**: In the alternative proof sketch, "π" denotes the bad AI's strategy (mapping posteriors to messages). In the paper, this role is played by β. The sketch's "m(ω)" denotes the message-as-posterior evaluated at state ω.

## Posterior Beliefs

Given strategy π of bad AI, the posterior belief at message m is:

γ_m(ω) = P(ω|m) = [α m(ω) τ(m) + (1−α) Σ_{μ∈M} π(m|μ) μ(ω) τ(μ)] / P(m)

where:

P(m) = Σ_ω [α m(ω) τ(m) + (1−α) Σ_{μ∈M} π(m|μ) μ(ω) τ(μ)]

## DM's Payoff Under Bayes-Optimal Response

The agent chooses action a ∈ A. The agent's strategy σ maps messages to actions (or distributions over actions).

Under Bayes-optimal response, the agent plays a*(γ_m) for each message m. The DM's payoff is:

V(π) = Σ_m [Σ_ω u(a*(γ_m), ω) γ_m(ω)] P(m)

## First-Order Conditions for Bad AI

### Derivative Computation

Take the derivative of V(π) with respect to π(m₁|μ*) − π(m₂|μ*), for some m₁, m₂ ∈ M and μ* ∈ M.

The direct effect (holding a*(γ_m) fixed):

∂V/∂π(m₁|μ*)|_{direct} = Σ_ω u(a*(γ_{m₁}), ω) (1−α) μ*(ω) τ(μ*)

The indirect effect (through changes in γ_m and hence a*(γ_m)):

∂V/∂π(m₁|μ*)|_{indirect} = Σ_m [Σ_ω (∂u(a*(γ_m), ω)/∂π(m₁|μ*)) γ_m(ω)] P(m)

### Envelope Theorem Application

**Claim**: The indirect effect vanishes at the optimum, by the envelope theorem applied to the agent's optimization problem.

**Interpretation**: When the belief is perturbed slightly, the agent's optimal payoff is approximately the payoff from taking the old optimal action.

**Formal conditions needed**: The objective function must be absolutely equicontinuous in the belief parameter.

### Posterior Sensitivity Bound

The posterior belief changes with π at rate:

dγ_m(ω)/dε|_{ε=0} = (1−α) × [π(m|μ*)τ(μ*) / P(m)] × [γ_m(ω) − μ*(ω)]

This is bounded because π(m|μ*)τ(μ*)/P(m) ≤ 1.

**Reference**: Milgrom & Segal (2002), Sinander.

### Resulting FOC

At an interior optimum of the simultaneous game:

Σ_ω [u(a*(γ_{m₁}), ω) − u(a*(γ_{m₂}), ω)] μ*(ω) ≥ 0

for all μ*, all m₁, and m₂ ∈ supp(π(·|μ*)). With equality if both m₁, m₂ ∈ supp(π(·|μ*)).

## Commitment Game Equivalence

### Setup

Consider a different game: DM commits to decision rule σ(a|m) = δ_{a*(γ_m)}, and bad AI chooses any message distribution.

### Bad AI's Problem (Per Realized μ)

min_{π(m|μ)} Σ_{ω,m} u(a*(γ_m), ω) π(m|μ) μ(ω)

### Key Step

For all m₁ and m₂ ∈ supp(π(·|μ*)):

Σ_ω u(a*(γ_{m₁}), ω) μ(ω) ≥ Σ_ω u(a*(γ_{m₂}), ω) μ(ω)

This means sending any message m₂ ∈ supp(π(·|μ*)) is optimal at μ. So bad AI following the same strategy as in the simultaneous game is still optimal in the commitment game.

### Conclusion

The DM's commitment does not change the value of the game:

sup_σ inf_β U(β, σ) = inf_β sup_σ U(β, σ)

This is the minimax theorem for this game.

## Gap Analysis

### Gap 1: Envelope Theorem Formalization

**What's claimed**: "Let's just assume that the envelope theorem holds for the agent's problem."

**What's needed**: A rigorous statement of which envelope theorem version applies. The proof sketch cites Milgrom & Segal and Sinander, then verifies the posterior sensitivity bound. But the exact theorem statement and its hypotheses need to be matched to this problem.

**Specific concern**: The envelope theorem typically applies to a parameterized optimization problem. Here the "parameter" is the distribution π(·|μ*), and the "optimizer" is the agent's action a*(γ_m). The parameter affects both the objective AND the constraint set (through changing γ_m). Need to verify the correct version.

### Gap 2: Boundary Cases

**What's implicitly assumed**: The FOC are written for interior solutions where π(m|μ*) > 0. Boundary cases (where the support of π changes) need separate treatment.

### Gap 3: Infinite Message Space

**Explicitly open**: "Regarding (ii), however, I have no idea how to extend the argument."

The FOC approach is inherently about perturbing individual coordinates π(m₁|μ*) and π(m₂|μ*), which requires a finite-dimensional parameterization.

### Gap 4: From FOC to Global Optimality

The FOC are necessary conditions. Need to verify they are also sufficient, or argue via the structure of the problem (e.g., concavity/convexity) that local optimality implies global optimality.
