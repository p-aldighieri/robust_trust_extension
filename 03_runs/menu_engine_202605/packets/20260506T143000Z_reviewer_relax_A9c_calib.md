# Reviewer pass — (A9c-calib) relaxation to (TRE-gen-Hall)

You are the Reviewer in the soft-scaffolding workflow.

## What you are reviewing

A prover output relaxing **(A9c-calib)** to a structural condition
**(TRE-gen-Hall)** = generalized trust-region structure (continuous
Bregman projection + closed worst-message graph + monotone/ray-like
fibers) + **Hall/Strassen vector mass-balance inequalities**. Honest
result: bare (TRE-gen) is **not enough** for $|\Omega|\ge 3$;
multi-dimensional vector mass-balance is required separately. Binary
verified via Appendix A.6 quantile transport; ternary radial/spherical
case verified via paper's Section 5.2 / Appendix A.10.

Full prover response: `logs/20260506T140000Z_prover_relax_A9c_calib_response.md`.

## Inputs

- `theorem_2_extension_proof.md`, `phil_reny_route_memo.md`,
  `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF
  (especially Section 4 / Theorem 1, Section 5 / TRE, Section 5.2 /
  spherical example, Appendix A.6 / quantile transport, Appendix A.10).
- L9b logs.

## Items to audit

1. **(TRE-gen) precise statement.** Closed convex trust region $T$;
   continuous Bregman projection $P_T$; $\hat\sigma^*(m)$ Bayes-optimal
   at $P_T(m)$; worst-message map $m^*$ single-valued and monotone for
   τ-a.e. $s$. Verify the structure aligns with the paper's TRE
   characterization (Theorem 1 finite case).
2. **(TRE-gen-Hall) Hall/Strassen vector inequalities.** Multi-dimensional
   mass-balance: for each subset $E\subseteq\partial T$, the τ-mass of
   $s\in M\setminus T$ being mapped into $E$ by $m^*$ must vector-equal
   the misaligned posterior contribution at $E$. Verify the formulation
   is correct and matches standard OT/Strassen feasibility.
3. **Binary verification.** Reduces to Appendix A.6 single-mass-balance
   quantile transport. Verify the prover's reduction is faithful.
4. **General ternary failure.** The prover claims general ternary fails
   without Hall vector inequalities — the obstruction is vector balance,
   not measurability. Verify with a concrete pathological ternary
   example or the prover's diagnostic.
5. **Ternary radial/spherical works.** Symmetric model with $U(\mu) = V(\|\mu-b\|)$,
   $\tau$ symmetric on a ball around $b$, concentric ball trust region.
   Disintegration by directions reduces to independent 1-D quantile
   transports. Cite paper's Section 5.2 + Appendix A.10. Verify the
   reduction is rigorous.
6. **Honest scope.** (TRE-gen-Hall) is a real structural restriction.
   Verify the prover doesn't overclaim that it's "free" — it's a
   genuinely new condition that subsumes the Hall vector inequalities.
7. **Interpretability vs (A9c-calib).** Is (TRE-gen-Hall) more
   interpretable than (A9c-calib)? Both are structural. The argument
   for (TRE-gen-Hall) being better: it's stated in primitive economic
   terms (trust region, worst-message map, mass balance), whereas
   (A9c-calib) is stated as the existence of an abstract coupling.
   Verify this is a real interpretability gain.
8. **Scope discipline.** Did the prover stop at (A9c-calib) relaxation?
   No drift; no dead-route machinery (no product-narrow Sion).

## Output Format

```
\`\`\`review_control
verdict: PASS / PATCH_SMALL / PATCH_BIG / REDO
route_status: viable / blocked / dead
recommended_next_phase: PROVER / BREAKDOWN / SEARCHER / CONSOLIDATOR / STOP_STALL
proof_status: complete / partial / broken
\`\`\`

## Verdict

VERDICT: ...
Reason: ...

## Opinion and Next Move

(One paragraph. If PASS, recommend a final consolidator to update
`theorem_2_extension_proof.md` with all three relaxations; the proof
package is then complete and the loop can be stopped.)

## Detailed Review

(Per audit items 1–8.)
```

Length budget: 1200–1800 words.
