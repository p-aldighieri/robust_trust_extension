# Searcher pass — rank routes after the formalizer reread

You are the **Searcher** in the soft-scaffolding workflow. Your job is to take the four route candidates the gatekeeper proposed (Strategies 2–5 below) and rank them in light of the formalizer reread that just landed. The goal is to identify the most actionable next route for proving the existence direction of Theorem 2 in *Robust Trust* without finite M, Θ, AND without slipping into a strict scope narrowing.

## State of play

**v7 status (committed):** three-tier theorem.
- Tier 1a (standing alone): existence of optimal σ* with U(σ*) = U*, plus ε-adversaries.
- Tier 1b (+ exact-contact): exact β*.
- Tier 2 (+ menu-Hall): full robust rationalizability q-a.e.

**Gatekeeper verdict (committed):** `OBJECTIVE_NARROWED`. menu-Hall classified as **scope-changing**, "close to assuming the equilibrium calibration that Theorem 2 was supposed to produce." exact-contact classified as **meaningful narrowing**.

**Formalizer reread (just landed):**
- Definition 2's "for all m ∈ M" should be read **q_β-a.e.**, where
  q_β = α τ + (1-α) ∫ β(·|s) τ(ds)
  is the actual mixture message marginal under the adversary β. Section 2's "for all = almost all" applies, but the paper never names the measure. The natural reading is the message marginal because P_β(·|m) is a conditional posterior.
- The adversary is **not** required to be τ-absolutely-continuous. β can put positive mass on a τ-null Borel N ⊆ M, in which case q_β(N) > 0 and those messages are on-path for the mixture law.
- v7's tacit choices already match this reading: Tier 2 explicitly proves q-a.e. menu-Hall and uses q ≥ α τ.
- Under any reasonable reading, the v7 narrowing is **real**. Strategy 1 (formalizer reread) does not collapse menu-Hall.
- "Adversary atoms on τ-null but q-positive messages remain a genuine calibration obstruction." So **null-message dust by itself relocates the calibration burden, it does not escape it.**

## The four candidate routes

(From the gatekeeper output, with formalizer adjustments factored in.)

**Strategy 2 — Null-message dust.** Place adversary-only payoff profiles on a Borel τ-null subset of M; the aligned payoff is unchanged because τ-null, but the adversary can use those messages with positive q-probability. The formalizer confirms this is formally admissible. Open question after the formalizer: does decoupling the aligned labeling from the adversarial labeling permit a Bayes-cone-consistent posterior that the menu engine could not?

**Strategy 3 — Constrained-persuasion transport.** Recast the adversary's problem as choosing a joint law over (s, m, induced posterior) on M × M × Δ(Ω), with the aligned truthful component as a lower-bound constraint α (id, id)#τ ≤ γ. Then look for a Strassen/Kellerer-style transport theorem with Bayes-cone constraints on the disintegration P_γ(·|m) ∈ B(m).

**Strategy 4 — Finite RR equilibria to joint-law limits.** Approximate the infinite environment by finite partitions M_n ↑ M, Θ_n ↑ Θ, take finite Theorem 2 saddle points (β*_n, σ*_n), and pass to weak limits of joint laws on (state, source posterior, message, induced agent posterior, action). Preserve calibration in the limit, then disintegrate.

**Strategy 5 — Trust-region geometry.** Use Theorem 1's connected trust region structure to argue that optimal menus arising from genuine trust regions satisfy menu-Hall automatically, or to identify a primitive geometric condition under which they do (radial/zonotopal/group-symmetric T).

## What you MUST do

For each of Strategies 2–5:

1. **Compatibility with the q_β-a.e. semantics.** State whether the strategy's natural target is q-a.e., τ-a.e., or literal-all, and whether that matches the formalizer's q_β-a.e. reading.
2. **Likely failure point.** Where does the route plausibly stall? Be specific — name the lemma or topological step that has to work.
3. **What positive evidence would confirm it is alive.** A test case, a special case it must reproduce, a known transport theorem it must extend.
4. **What kills it.** A concrete obstruction that, if found, would close the route.
5. **Cost estimate.** Light / medium / heavy in expected prover effort.

Then **rank the four routes** with the most actionable one first. The most actionable is the route that combines high prospect of dodging menu-Hall, reasonable cost, and a clear early-evidence test. Justify the ranking in 2–3 sentences.

## What you MUST NOT do

- Do not pick a single route to commit the project to. That is the orchestrator's call.
- Do not start proving anything. That is the prover's job.
- Do not invent a sixth strategy unless one of the four is dominated; if so, say which and why.

## Output Format

```markdown
## Route Audit

### Strategy 2 — Null-message dust
- Compatibility with q_β-a.e.: ...
- Likely failure point: ...
- Positive evidence: ...
- What kills it: ...
- Cost: light / medium / heavy

### Strategy 3 — Constrained-persuasion transport
- (...same fields...)

### Strategy 4 — Finite RR equilibria to joint-law limits
- (...)

### Strategy 5 — Trust-region geometry
- (...)

## Ranking

1. **<Strategy>** — one-sentence justification.
2. **<Strategy>** — ...
3. **<Strategy>** — ...
4. **<Strategy>** — ...

## Honest Assessment

(One paragraph. Is there a real route back to the original objective without menu-Hall, or does every route ultimately re-introduce equivalent calibration content under a different name? If the latter, name the calibration content invariant across routes.)
```

Length: 1500–2200 words.
