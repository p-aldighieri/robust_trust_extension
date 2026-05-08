# Reviewer pass — L9b (calibrated worst-message transport)

You are the Reviewer in the soft-scaffolding workflow.

## What you are reviewing

A prover output for **L9b (calibrated transport)** with verdict
**PROVED-CONDITIONAL on a new assumption (A9c-calib)**. The full prover
response is in
`logs/20260506T084500Z_prover_L9b_calibrated_transport_response.md`.

The result is honest: under standing + (A5) + (A8c-lsc), L8 gives a
rowwise adversarial β but NOT a saddle, so L9 cannot follow from L8
alone. (A9c-calib) is the precise additional ingredient (a
posterior-calibrated Hall/Strassen coupling) that closes the gap.

## Inputs

- `theorem_2_extension_proof.md` (the consolidator output with the
  L9 gap that needs to be revised), `phil_reny_route_memo.md`,
  `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF.

## Items to audit

1. **Diagnosis of the L9 gap.** Prover correctly identifies that L8c
   gives only the rowwise lower saddle, not a true saddle, so the
   standard L9 contradiction doesn't go through. Verify.
2. **Definition of $C(m)$ and $D(s)$.**
   - $C(m) = \{\mu : \hat\sigma^*(m) \in \arg\max U(\cdot, \mu)\}$ — closed
     convex polytope.
   - $D(s) = \arg\min_m \ell_{\sigma^*}(m,s)$ — closed under (A8c-lsc).
   Verify structure claims.
3. **Aligned-message Bayes-optimality at $\mu = m$.** The prover claims
   $m\in C(m)$ τ-a.e. when $\alpha>0$, since aligned messages have
   posterior $m$ and $\sigma^*$ must be Bayes-optimal there (else
   Branch A's value is not achieved). Verify this is forced by Branch
   A's value-securing property.
4. **(A9c-calib) statement.** Prover's formulation: ∃ γ∈Δ(M×M) with
   first marginal τ, support in $\{(s,m): m\in D(s)\}$, and induced
   posterior in $C(m)$ q-a.e. This is the calibrated Hall/Strassen
   coupling. Verify the conditions are equivalent to standard transport
   feasibility.
5. **Sufficient condition (singleton + truthful-posterior calibration).**
   If $D(s) = \{m^*(s)\}$ and $s\in C(m^*(s))$ τ-a.e., (A9c-calib)
   holds with $\beta^*(dm\mid s) = \delta_{m^*(s)}(dm)$. Verify the
   sufficient conditions imply the full coupling.
6. **Concrete example feasibility.** Did the prover work through the
   $|\Omega|=2$ quadratic example? Is feasibility verified there?
7. **Honest fallback.** The prover correctly notes that without
   (A9c-calib), the theorem must drop the Definition 2 conclusion.
   Verify this two-tier structure is the right honest framing.
8. **Scope discipline.** Did the prover stop at L9b? Any leakage? Any
   dead-route machinery?

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

(One paragraph. If PASS, recommend revising the consolidator: state
the theorem in two tiers — weak (without (A9c-calib)) and strong
(with (A9c-calib)).)

## Detailed Review

(Per audit items 1–8.)
```

Length budget: 1200–2000 words.
