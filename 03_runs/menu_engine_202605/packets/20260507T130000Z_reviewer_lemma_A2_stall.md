# Reviewer pass — Lemma A.2 stall (transport-to-deletion gap)

You are the **Reviewer** in the soft-scaffolding workflow. Audit the prover's stall verdict on Lemma A.2 from `logs/20260507T120000Z_prover_lemma_A2_trapdoor_response.md`. The prover concluded STALLED with three named technical obstacles.

## Context

Lemma A.2 was the trapdoor lemma for Strategy 3 (canonical/minimal menu route). Its statement: assuming standing + (exact-contact), if $C^*$ is behaviorally minimal (C1) and menu-Hall fails, then there exists a proper compact $D \subsetneq C^*$ with $F(D) \ge F(C^*)$.

The prover's verdict: **STALLED**. Three named obstacles:

1. **Support saturation gap.** Deletion only raises $\ell_D$ if every $C^*$-minimizer for source $s$ is removed. Exact-contact gives existence in $G(s)$, not saturation $E \supseteq G(s)$ for the dual-relevant $E$. Without saturation, the transport certificate produces "phantom fuel" — burns in the dual inequality without raising actual $\ell_D$.

2. **Replacement-index mismatch.** The displayed dual inequality has the form
$$\alpha\!\int_E\!m\cdot(c(m) - z(m))\,\tau(dm) - (1-\alpha)\!\int_{M\times E}\!(s\cdot z(m) - \ell_C(s))\,\lambda(ds, dm) \ge 0$$
with $z(m)$ indexed by message. But $F(D) - F(C^*)$ involves $\ell_D(s) - \ell_C(s) = \min_{z \in D}\,s\cdot z - \ell_C(s)$, indexed by source. Even if $z(m) \in D$, only $\ell_D(s) \le s\cdot z(m)$ — wrong direction for the deletion improvement.

3. **Borel→compact gap.** $\overline{c(M\setminus E)} = C^*$ can hold even for large Borel $E$. Behavioral minimality gives $C^* = \overline{c(M)}$, not that deficient message sets correspond to removable compact label patches.

The prover's prescription:
- (Unblocker A) A deletion-compatible Hall duality theorem that builds saturation and sourcewise minimization into the dual.
- (Unblocker B) Stronger regularity (closed graph of $w^*$, u.h.c. of $G$, τ-a.e. uniqueness of minimizers, label-regularity ensuring deficient message sets remove compact patches).

## Items to audit

### 1. Are the three named obstacles real?

Verify each obstacle is a genuine technical gap, not a mis-step in the prover's algebra.

- **(1) Support saturation.** Verify the claim: if $E$ is dual-deficient and $\lambda$ sends source $s$ to $E \cap G(s) \ne \emptyset$ but $G(s) \not\subseteq E$, then deleting $c(E)$ does not raise $\ell$ at $s$. State precisely whether exact-contact (existence + measurable selector) implies any saturation property in general, or whether it is genuinely silent.
- **(2) Replacement-index.** Verify the algebra: the dual inequality's $z(m)$ is indeed message-indexed, the deletion-improvement is source-indexed, and the inequality $\ell_D(s) \le s\cdot z(m)$ for $z(m) \in D$ does not produce the needed direction. Sanity check: is there a way to read the dual differently that matches the deletion side?
- **(3) Borel→compact.** Verify the example space: under bare Borel measurability of $w^*$ and behavioral minimality, can we exhibit (or argue) a Borel $E$ with $\tau(E) > 0$ AND $\overline{c(M\setminus E)} = C^*$? If yes, the obstacle is real. If not, the obstacle may be a measurability slip.

### 2. Does the diagnosis actually block Strategy 3's general form?

The prover claims that obstacles (1)–(3) jointly block A.2 under standing + exact-contact alone, and that only Unblockers (A) or (B) would close the gap. Verify:

- Are there alternative proof techniques (not Strassen/Kellerer-based) that might bypass all three obstacles?
- Does the breakdown's proposed Unblocker (B) — closed graph + u.h.c. + uniqueness + label regularity — actually suffice? Or does it still leave a gap?
- Is there a softer A.2 (e.g., $F(D) \ge F(C^*) - \eps$ for some $\eps > 0$) that would still be useful and might be provable under standing alone?

### 3. Are the special-geometry candidates (C2/C3/C4) genuinely independent?

The prover claims C2/C3/C4 remain live "where uniqueness, symmetry, or closed-graph structure supplies the missing saturation." Verify:

- Do C2 (exposed-extreme), C3 (primitive TR-minimality), and C4 (radial/orbit symmetry) each automatically supply saturation, sourcewise-minimization, or compact deletion?
- Or do they each need their own analog of A.2 to bridge canonicality to menu-Hall?
- If the latter, the same transport-to-deletion gap may reappear; flag this if so.

## Verdict and downstream advice

### Verdict levels

- `PASS`: stall is correctly diagnosed. Strategy 3's general form (C1) is genuinely blocked. Project's terminal status under v8 is honest.
- `PATCH_SMALL`: the stall is real but a minor patch (e.g., a softer A.2) might still close the route under standing.
- `PATCH_BIG`: one of the three obstacles is overstated; the route may still live with a non-obvious technique.
- `REDO`: the prover missed an obvious proof.

### Downstream advice (one paragraph)

Given the verdict, what should the orchestrator do? Options:
- **Stop and gatekeeper (third pass).** Take v8 + sharpness + Strategy 3 stall to the gatekeeper for a final verdict on whether the project is at a publishable terminal state.
- **Special-geometry prover passes.** Run the breakdown's items 2–4 (B.2 normal-fan, C.2 binary interval, D.2 spherical orbit) one at a time, accepting that they only cover special cases.
- **Search for Unblocker (A).** Look for a deletion-compatible Hall duality theorem in the literature (martingale optimal transport, Strassen with cone constraints, Kellerer with disintegration constraints).
- **Stop with v8 as terminal**, treating the special-geometry routes as already covered by the paper's own constructions (Appendices A.6 and A.10).

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
### 1. Three named obstacles
- (1) Support saturation: real / overstated. Reason: ...
- (2) Replacement-index: real / overstated. Reason: ...
- (3) Borel→compact: real / overstated. Reason: ...

### 2. Does the diagnosis block Strategy 3 general form?
...

### 3. Special-geometry candidates
- C2: ...
- C3: ...
- C4: ...

## Opinion and Next Move
(One paragraph. Strong recommendation on the next phase.)
```

Length: 1500–2000 words.
