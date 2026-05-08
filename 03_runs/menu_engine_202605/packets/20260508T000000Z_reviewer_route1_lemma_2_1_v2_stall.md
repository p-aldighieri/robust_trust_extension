# Reviewer pass — Lemma 2.1' v2 stall (four structural walls)

You are the **Reviewer**. The Lemma 2.1' v2 prover stalled at four named obstructions after the LP rewrite cleared the previous counterexample. Audit the stall: are the four obstructions genuinely structural, or are some of them LP-construction artifacts that a third LP rewrite could fix? Decide whether Route 1 is genuinely dead under standing + (H_del), or whether one of the prover's three proposed unblockers is a clean primitive repair.

## The four named obstructions (verbatim)

1. **Continuum-mass label fibers have zero τ-mass.** Concrete LP-level witness: Ω = {0,1}, τ atomless on [0, 0.4] ∪ [0.6, 1], V₀ = {u₀ = (1,0), u₁ = (0,1)}, ε < 0.2. Then $J([0, 0.4]) = \{u_1\}$, $J([0.6, 1]) = \{u_0\}$. The cone tests at u₁ vs u₀ become $(1-\alpha)\!\int_{[0,0.4]}(1-2p)\,d\tau \le 0$ (false since 1-2p ≥ 0.2 > 0 on [0, 0.4]) and at u₀ vs u₁: $(1-\alpha)\!\int_{[0.6,1]}(2p-1)\,d\tau \le 0$ (false). LP infeasible, but $\tau(L_{u_0}) = \tau(L_{u_1}) = 0$ — no positive-mass label fiber to delete.

2. **Borel→compact still requires positive source mass.** Even if a relatively open $O \subset C^*$ is extracted from the dual, $\tau(w^{*-1}(O)) = 0$ is possible under bare Borel measurability of $w^*$.

3. **F-comparison gap.** Finite $V_0$ tests don't control compact max-min over W without a mesh + Lipschitz error bound. The desired $F(D_E) \ge F(C^*) - O(\eps)$ compares extrema over compact sets, while the LP only tests finitely many $v$.

4. **(H_del) is pointwise strict, not uniformly.** $\forall D \in \text{Del}(w^*, \tau)\setminus\{C^*\}$, $F(D) < F(C^*)$ does not give a uniform gap. Proper $D_n \to C^*$ in Hausdorff with $F(D_n) \uparrow F(C^*)$ are allowed. So $F(D_E) \ge F(C^*) - K\eps$ doesn't contradict (H_del) without a uniform deletion-gap assumption.

The prover's three proposed unblockers:
- **(U1) Discrete positive-mass labels.** Hypothesis: $C^* = \{u_1, \ldots, u_k\}$ finite with $\tau(L_{u_i}) > 0$ for all i, $V_0$ rich enough.
- **(U2) Label-neighborhood regularization.** Replace $L_u$ with $L_u^\delta$ for δ > 0, using labels from $\mathrm{supp}(w^*_\#\tau)$, with boundary-mass control and finite-net error bound.
- **(U3) New deletion-compatible duality theorem.** A genuinely new theorem, not a patch.

## What you MUST audit

### 1. Are the four obstructions real and structural?

For each:
- **(O1) Continuum-mass.** Is the LP-level witness correct? Verify the ε-edges and cone-test infeasibility. Is the obstruction structural (any LP using sourcewise aligned attribution at sampled labels has it) or specific to this LP construction (a third LP rewrite would fix it)?
- **(O2) Borel→compact.** Is it correct that $\tau(w^{*-1}(O)) = 0$ is possible for open $O \subset C^*$? Construct or argue via an explicit example.
- **(O3) F-comparison.** Verify the gap. Does it dissolve if $V_0$ is taken to be a sufficiently fine ε-net in W? If so, this might be a finite-net upgrade rather than a fundamental wall.
- **(O4) (H_del) pointwise strict.** Is it correct that $D_n \to C^*$ with $F(D_n) \uparrow F(C^*)$ is consistent with (H_del)? Construct or argue via an example. Does this make (H_del) too weak to be a useful primitive hypothesis?

### 2. Diagnose the unblockers

For each:
- **(U1) Discrete labels.** Is this a renaming-test-passing repair, or does it implicitly add label-purity that wasn't in (H_del)? Note that v8's Tier 1a is unconditional — the optimal menu in v8 is generally compact, not finite. Adding "$C^*$ is finite" is a substantial scope narrowing.
- **(U2) Label-neighborhood regularization.** Does this work? Specifically: if labels are picked from $\mathrm{supp}(w^*_\#\tau)$, does the LP have a chance of being feasible whenever (H_del) holds? Or does (O4) still bite?
- **(U3) Deletion-compatible duality.** This is the central unresolved bottleneck named in the closure memo. Is the prover's stall confirming that this is the only real fix, or are (U1)/(U2) viable shortcuts?

### 3. Verdict on Route 1

After this stall, three reasonable verdicts:
- **Dead under (H_del).** Route 1 cannot work without strictly stronger primitive hypotheses than (H_del). The unblockers are scope-narrowing or amount to assuming the conclusion. **Move to Route 2.**
- **Alive under (U1) — discrete-label restriction.** Route 1 holds if we restrict $C^*$ to finite. This gives a non-trivial conditional theorem but a substantially narrower target. **Continue Route 1 in narrowed form.**
- **Alive under (U2) — label-neighborhood regularization.** Route 1 holds with mild label regularity (supports of $w^*_\#\tau$). This is closer to the original objective. **Continue Route 1 with regularization.**

## Verdict and downstream advice

### Verdict levels

- `PASS`: stall is correctly diagnosed at all four walls; the unblocker assessment is sound.
- `PATCH_SMALL`: stall is correct but one of the unblockers is more (or less) salvageable than the prover claims.
- `PATCH_BIG`: one or more obstructions is overstated; Route 1 may live with a third LP rewrite.
- `REDO`: the prover missed something obvious.

### Downstream advice (one paragraph)

Given the verdict, what should the orchestrator do?
- **Stop Route 1 and move to Route 2.** If the stall is structural and unblockers are scope-narrowing.
- **Continue Route 1 in narrowed form (U1 or U2).** If a clean discrete-label or label-regularization theorem is publishable as a real conditional result.
- **Take the four obstructions to a fresh searcher.** If a different proof strategy (R1 Strassen/Kellerer or R4 cyclical monotonicity) might handle the obstructions differently.
- **Stop with v8.** If after this stall, the project's terminal state hasn't moved.

## Output Format

```
\`\`\`review_control
verdict: PASS / PATCH_SMALL / PATCH_BIG / REDO
route_status: viable / blocked / dead
recommended_next_phase: GATEKEEPER / PROVER / BREAKDOWN / SEARCHER / LITERATURE / CONSOLIDATOR / STOP_STALL
proof_status: complete / partial / broken
\`\`\`

## Verdict
VERDICT: ...
Reason: ...

## Detailed Audit
### 1. Four obstructions
- (O1) Continuum-mass label fibers: real / overstated. Reason: ...
- (O2) Borel→compact: real / overstated. Reason: ...
- (O3) F-comparison gap: real / overstated. Reason: ...
- (O4) (H_del) pointwise strict: real / overstated. Reason: ...

### 2. Unblockers
- (U1) Discrete positive-mass labels: viable / scope-narrowing / dead. ...
- (U2) Label-neighborhood regularization: viable / dead. ...
- (U3) New duality theorem: confirmed central bottleneck / unnecessary. ...

### 3. Route 1 verdict
- Dead under (H_del) / Alive under (U1) / Alive under (U2) / Other.

## Opinion and Next Move
(One paragraph. Strong recommendation on next phase.)
```

Length: 1500–2000 words.
