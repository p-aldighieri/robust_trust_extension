# Prompt Packet: Prover — FOC Derivation and Envelope Theorem (Blocks C + D)

## Role

`prover`

## Scope Of This Move

Blocks C and D of the alternative proof of Theorem 2: rigorous derivation of the first-order conditions for the adversary's problem, and identification and verification of the exact envelope theorem needed.

## Goal

1. **Derive the FOC from scratch** — not merely verify the sketch's claim, but produce a complete, self-contained derivation of the first-order conditions for the misaligned adviser's optimization problem.

2. **Identify and state the exact envelope theorem** needed to eliminate the indirect effect, verify all its hypotheses in the current setting, and provide the logical bridge from the posterior-derivative bound to the envelope theorem's actual conditions.

3. **Handle boundary/KKT analysis** for the simplex constraints β(·|μ*) ∈ Δ(M).

4. **Establish the "AI moves first" equivalence** — provide a formal justification for why the timing reformulation is without loss of generality.

## Notation Dictionary (from formalizer)

Use the paper's notation as canonical throughout. The following renamings resolve all inconsistencies between the sketch and the paper:

| Sketch symbol | Paper-canonical | Meaning |
|---|---|---|
| π(m\|μ) | β(m\|μ) | Misaligned adviser's reporting rule |
| P(m) | q_β(m) | Marginal probability of message m |
| γ_m | P_β(·\|m) | Agent's posterior over states given message m |
| a*(μ) | σ̂*(μ) | Bayes-optimal response at belief μ |
| U(π,σ) | U(β,σ) | Zero-sum stage-game payoff |
| bad AI | misaligned adviser | Strategic adviser (prob 1−α) |
| DM | agent | Decision maker / receiver |

**Key collision to avoid**: The paper uses P(m) for the trust-region projection map (Definition 1). The message probability must be written as q_β(m), never as P(m).

**Suppressed objects**: The sketch drops θ (private type), f (signal function), id (truthful strategy), and σ̂ (private-strategy notation). For Blocks C-D, this suppression is acceptable as a simplification, but flag it if it creates issues.

## Verified Starting Point (Block B result)

The posterior formula is VERIFIED CORRECT:

P_β(ω|m) = [α τ(m) m(ω) + (1−α) Σ_{μ∈M} τ(μ) β(m|μ) μ(ω)] / q_β(m)

where:
- q_β(m) = α τ(m) + (1−α) Σ_{μ∈M} τ(μ) β(m|μ)
- M = supp(τ) is finite
- Ω is finite
- α ∈ (0,1) ensures q_β(m) > 0 for all m ∈ M

## Gap Register (from formalizer) — What Needs Filling

The formalizer identified the following CRITICAL gaps that are in scope for this packet:

### Gap 1: "AI moves first" equivalence [CRITICAL]
- **Claimed**: The sketch says to assume the AI moves first so the DM knows the distribution of posteriors.
- **Missing**: No formal equivalence between this reformulated timing and the paper's simultaneous/commitment setup.
- **Your task**: Provide the formal equivalence argument, or state precisely what game-theoretic principle justifies this.

### Gap 2: FOC derivative formula [CRITICAL]
- **Claimed**: The sketch writes a derivative of the DM payoff w.r.t. β(m₁|μ*) − β(m₂|μ*).
- **Missing**: No full derivation, including the dependence of all P_β(·|m) and q_β(m) on the perturbation, and the simplex feasibility constraints.
- **Your task**: Derive this from scratch. Write β_ε(m|μ) = β(m|μ) + ε[δ_{m₁}(m) − δ_{m₂}(m)] · 𝟙{μ=μ*}, compute dU/dε|_{ε=0}, and decompose into direct and indirect effects.

### Gap 3: Envelope theorem elimination of indirect term [CRITICAL]
- **Claimed**: The sketch says the second (indirect) term can be dropped by an envelope theorem.
- **Missing**: The exact theorem is not stated, the parameter space is not formalized, and hypotheses (continuity, selection, nonunique optimizers) are not verified.
- **Your task**: State the exact theorem (cite Milgrom-Segal 2002, Theorem 3, or Sinander's version if more appropriate). Define the parameter space. Verify each hypothesis.

### Gap 4: Posterior-derivative → envelope bridge [CRITICAL]
- **Claimed**: The sketch argues that a bounded derivative of posterior beliefs is enough.
- **Missing**: The logical bridge from "small perturbation of posteriors" to the exact envelope-theorem hypotheses is not provided, and support changes in β are not addressed.
- **Your task**: Provide this bridge explicitly.

### Gap 5: FOC on supports with KKT [CRITICAL]
- **Claimed**: Σ_ω [u(σ̂*(P_β(·|m₁)),ω) − u(σ̂*(P_β(·|m₂)),ω)] μ*(ω) ≥ 0 with equality on support.
- **Missing**: No KKT-style boundary analysis. Also a notation ambiguity (μ* vs μ) in the subsequent condition.
- **Your task**: Set up the full KKT conditions for the adversary's problem on the simplex Δ(M). Derive the FOC inequality with complementary slackness. Resolve the notation ambiguity.

### Gap 6: Translation to σ̂/θ framework [CRITICAL]
- **Claimed**: The sketch works with u(a,ω) and a*(μ).
- **Missing**: No proof that the argument survives when private types and private strategies are reinstated.
- **Your task**: At minimum, state precisely what conditions on the (σ̂, θ) framework are needed for the FOC/envelope argument to go through. A full translation is ideal but a precise conditional statement is acceptable.

## Implicit Assumptions to Watch

The formalizer catalogued 9 implicit assumptions. The ones most relevant to Blocks C-D:

1. **Pure-action Bayes response**: The sketch uses a*(μ) as a pure action. If the Bayes-optimal response is a mixed strategy σ̂*(μ), the FOC derivation changes.
2. **Regular Bayes-optimal selection**: a*(μ) must behave regularly under perturbations of μ for the envelope step.
3. **Interior perturbations**: The sketch only considers interior directions. Boundary of the simplex must be handled.
4. **Envelope-theorem hypotheses**: Explicitly assumed in the sketch, must be verified here.

## Hard Constraints

- **No assumption smuggling**: Every hypothesis must be explicitly stated. If you need an assumption not in the paper's Theorem 2, label it `[ASSUMPTION+]`.
- **Tag all gaps**: Any step you cannot complete must be labeled `[GAP]` with severity rating (COSMETIC / MODERATE / CRITICAL).
- **Derive, don't verify**: Produce the FOC derivation from scratch. Do not simply confirm the sketch's formula — derive it step by step.
- **Use paper-canonical notation** with the dictionary above.
- **Cite precisely**: When invoking the envelope theorem, give the exact theorem number and paper, and verify each hypothesis individually.

## Durable Project Sources Already In ChatGPT

- `objective_statement.md`
- `Robust_trust_Dworczak_Smolin.pdf`
- `Robust trust_alternative proof_minimax theorem.pdf`
- `proof_state.md`

## Project Sources To Refresh Before This Chat

Upload the updated `source_notes/proof_state.md` to the project sources before starting this chat.

## Temporary Files To Attach In This Chat

None needed — all context is in this packet and the durable project sources.

## Deliberately Excluded Context

- Extension project artifacts from `Context Management/` — not relevant to finite-case Blocks C-D
- Block G (infinite M) — explicitly out of scope

## Required Output

Produce a single markdown document with these sections:

### 1. "AI Moves First" Equivalence
Formal justification of the timing reformulation.

### 2. Adversary's Optimization Problem
Full statement of the adversary's problem with simplex constraints.

### 3. FOC Derivation
Complete derivation of dU/dε|_{ε=0} for the perturbation β_ε(m|μ) = β(m|μ) + ε[δ_{m₁}(m) − δ_{m₂}(m)] · 𝟙{μ=μ*}. Decompose into direct effect and indirect effect.

### 4. Envelope Theorem Identification and Verification
State the exact theorem. Define the parameter space. Verify each hypothesis individually.

### 5. Elimination of the Indirect Effect
Apply the envelope theorem to show the indirect effect vanishes. Provide the posterior-derivative → envelope bridge explicitly.

### 6. KKT Analysis on the Simplex
Full KKT conditions for β(·|μ*) ∈ Δ(M). Derive the FOC inequality with complementary slackness.

### 7. FOC Summary
State the final first-order necessary conditions cleanly. Resolve any notation ambiguities.

### 8. Translation Conditions
State what is needed for the argument to survive in the full (σ̂, θ) framework.

### 9. Updated Gap Register
List any remaining gaps after this pass, with severity ratings.

### 10. Assumptions Inventory
List all assumptions used, distinguishing paper hypotheses from extra conditions.

## Proof-State Update Target

After acceptance, update `source_notes/proof_state.md`:
- Block C status → COMPLETE or NEEDS_REVISION
- Block D status → COMPLETE or NEEDS_REVISION
- Update Open Questions with any new findings
- Update Gap Register

## Expected Next-Step Signal

If Blocks C-D are clean: hand off to `prover` on Block E (commitment-game optimality preservation).
If critical gaps remain in C-D: continue `prover` on the same blocks with targeted resubmission.
