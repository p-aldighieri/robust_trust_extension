# Reviewer pass — no-free-dust theorem and classification (b)

You are the **Reviewer** in the soft-scaffolding workflow. Audit the prover output that just landed in `logs/20260507T080000Z_prover_strategy2_dust_test_response.md`. Three claims to audit, in order of weight.

## Context

The prover's pass tested Strategy 2 (null-message dust) against the v7 ternary winner-takes-all sharpness witness. Outcome: Step 2 success (no-free-dust lemma) + Step 3 classification (b) (witness is a menu-engine artefact, not a counterexample to unrestricted Theorem 2).

This is the most consequential result the project has produced after v7 because:
- it strengthens the v7 sharpness witness considerably (eliminates ALL dust kernels and labelings, not just pure ones),
- AND it neutralizes the gatekeeper's worry that v7 might silently give up on the original objective: the witness no longer threatens unrestricted Theorem 2.

The downstream effect is large, so the audit must be tight.

## Items to audit

### 1. Cone intersection lemma (highest priority)

**Statement.** For every nonempty $I \subseteq \{0,1,2\}$, if $\rho$ is a probability measure on $\Delta(\Om)$ with $\rho(K_I^-) = 1$ and barycenter $\bar s \in B_I$, then $\rho = \delta_{\mu_0}$ where $\mu_0 = (1/3, 1/3, 1/3)$.

**Prover's proof sketch.** For $i \in I$, $s_k - s_i \ge 0$ ρ-a.s. for every $k$. Barycenter inequality $\bar s_i \ge \bar s_k$ for every $k$. Hence $\int (s_k - s_i)\,d\rho \le 0$. A nonneg r.v. with nonpositive expectation is zero a.s., so $s_k = s_i$ ρ-a.s. Coordinates summing to one force $s = (1/3, 1/3, 1/3)$ ρ-a.s.

**Verify.** (a) Is $K_I^-$ correctly identified — i.e., is $w_\lambda = \sum_i \lambda_i v_i$ a rowwise minimizer at $s$ exactly when every coordinate in $\mathrm{supp}(\lambda)$ is minimal? (b) Is $B_I$ correctly identified — i.e., is $w_\lambda$ Bayes-optimal at posterior $p$ exactly when every coordinate in $\mathrm{supp}(\lambda)$ is maximal? (c) Does the lemma's chain of inequalities require any continuity/regularity assumption that the prover skipped? Specifically, does the equality on $\int (s_k - s_i)$ require $\rho$ to be Borel only, or something stronger?

### 2. Disintegration step in the no-free-dust theorem

**Statement.** Under atomless τ, no Borel null dust set $N$, labeling $w_N : N \to W$, and adversarial kernel $\kappa$ satisfy simultaneously: rowwise-minimizer support q-a.e., positive $q_\beta(N)$, Bayes-cone calibration on $N$.

**Prover's proof sketch.** Define $\nu(ds, dm) := \tau(ds)\kappa(dm \mid s)$. Disintegrate over dust messages: $\nu \mid_{\Delta(\Om) \times N} = \rho_m(ds)\,q_N(dm)$. Rowwise-minimizer support gives $\rho_m(K_{I(m)}^-) = 1$. Bayes-cone calibration gives barycenter of $\rho_m$ in $B_{I(m)}$. Cone intersection lemma gives $\rho_m = \delta_{\mu_0}$ q_N-a.e. Hence $\nu(\{\mu_0\} \times N) = \nu(\Delta(\Om) \times N) > 0$. But the first marginal of $\nu$ is τ, and τ atomless ⇒ $\tau(\{\mu_0\}) = 0$. Contradiction.

**Verify.** (a) Is the disintegration step correctly applied? Specifically, does the disintegration of $\nu$ over its $M$-marginal produce conditionals $\rho_m$ on $\Delta(\Om)$ q_N-a.e., and does $\nu$ live on a standard Borel space ensuring disintegration exists? (b) Is "first marginal of $\nu$ is τ" correct? $\nu = \tau(ds)\kappa(dm \mid s)$ does have first marginal τ, but only the part of $\nu$ on $\Delta(\Om) \times N$ has first marginal that is a sub-measure of τ — verify the inequality $\nu(\{\mu_0\} \times N) \le \tau(\{\mu_0\})$ is justified. (c) Does the argument also kill the case where the dust is uncountable and continuous (the prover claims "diffuse dust does not help"; verify).

### 3. Classification (b) — T not a primitive optimal trust region

**Statement.** $T = \{\mu : \mu(0) \le 0.4\}$ is not a primitive optimal trust region for the ternary winner-takes-all. The induced payoff-profile menu under any reasonable agent strategy on $T$ is $C^\dagger = \{v_0, v_1, v_2\}$, i.e., the full vertex menu, equivalent to the trivial trust region $T = \Delta(\Om)$. Hence the boundary point $t_0 = (0.4, 0.3, 0.3)$ is "representational scenery, not load-bearing beams" and does not certify any actual constraint a primitive robust optimization would impose.

**Verify.** (a) Is the claim "$T$ contains messages whose plurality labels are 0, 1, 2" correct? Specifically, verify the plurality vertex map sends elements of $T$ to all three actions $a_0, a_1, a_2$. (b) Is the conclusion "induced menu is the full vertex menu" correct, given that the agent's continuation strategy is the plurality vertex map? (c) Most consequentially: is the claim "if the full menu is optimal under some α, τ, then the same behavior is equivalently represented by $T = \Delta(\Om)$" correct, or is there a primitive optimization in which the geometric cut $\mu(0) = 0.4$ is genuinely binding? Be skeptical: this is exactly the kind of subtle claim that can be wrong because of how the trust-region projection enters the agent's continuation strategy.

(d) The deepest version: is there ANY primitive robust optimization (any $u$, $\alpha$, $\tau$) under standing assumptions such that the optimal trust region is $\{\mu : \mu(0) \le 0.4\}$ AND the induced rowwise-minimizer / Bayes-cone geometry recovers the v7 obstruction? If yes, classification (b) is wrong and we should be at (c) (genuine counterexample to unrestricted Theorem 2). If no, classification (b) holds.

## Verdict and downstream advice

### Verdict levels

- `PASS`: all three claims clean. Strategy 2 retired with a strong sharpness lemma; original objective still alive.
- `PATCH_SMALL`: minor patches to the proofs, nothing structural.
- `PATCH_BIG`: one of the three claims has a real gap that needs more than a focused patch.
- `REDO`: the no-free-dust theorem or the classification is wrong.

### Downstream advice (one paragraph)

Given the verdict, what should the orchestrator do next? Options:
- **Stop and gatekeeper.** Take this strengthened sharpness back to the gatekeeper to revisit OBJECTIVE_NARROWED — the witness is now a menu-engine artefact, which may change the verdict.
- **Strategy 3 prover.** Constrained-persuasion transport. Heaviest, but cleanest language for the calibration invariant.
- **Strategy 5 prover.** Trust-region geometry as primitive structure. Best positive islands (binary, spherical), but risks "menu-Hall under symmetry."
- **Stop and commit v7+nodust.** This is now a defensible result: Tier 1a unconditional, Tier 1b under exact-contact, Tier 2 under menu-Hall, with menu-Hall sharply needed in winner-takes-all ternary BUT the witness is a menu-engine artefact, not a counterexample.

## Output Format

```
\`\`\`review_control
verdict: PASS / PATCH_SMALL / PATCH_BIG / REDO
route_status: viable / blocked / dead
recommended_next_phase: GATEKEEPER / PROVER / BREAKDOWN / SEARCHER / CONSOLIDATOR / STOP_STALL
proof_status: complete / partial / broken
\`\`\`

## Verdict
VERDICT: ...
Reason: ...

## Detailed Audit
### 1. Cone intersection lemma
...

### 2. Disintegration step
...

### 3. Classification (b)
...

## Opinion and Next Move
(One paragraph. Strong recommendation on next phase.)
```

Length: 1500–2000 words.
