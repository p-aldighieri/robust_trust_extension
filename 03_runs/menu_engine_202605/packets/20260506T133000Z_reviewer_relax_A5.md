# Reviewer pass — (A5) relaxation to (A5-thick)

You are the Reviewer in the soft-scaffolding workflow.

## What you are reviewing

A prover output relaxing **(A5) common posterior null sets** to the
strictly weaker **(A5-thick)** — endogenous Lusin-thickness condition
that's exactly what L5/L6 consume. Includes a Bayes-plausible
atom-at-zero example showing strict inclusion.

Full prover response:
`logs/20260506T130000Z_prover_relax_A5_response.md`.

## Inputs

- `theorem_2_extension_proof.md`, `phil_reny_route_memo.md`,
  `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF.

## Items to audit

1. **(A5-thick) suffices for L5+L6.** The L5 statement IS the existence
   of the Lusin-thick compact sequence. L6 uses it for the smoothing
   kernel. The crucial step in L6: $\tau(K_n\cap B(y,\rho_n))>0$. Under
   (A5-thick), support-thickness gives $\pi(K_n\cap B(y,\rho_n)\mid\omega)>0$
   for every $\omega$. Hence $\tau = \sum\mu_0\pi(\cdot\mid\omega)$ also
   $>0$. Verify this works WITHOUT requiring (A5).
2. **(A5) ⇒ (A5-thick).** Standard construction $K_n = \operatorname{supp}(\tau\restriction C_n)$.
   Under (A5), τ-support = π-support for every ω. Verify.
3. **(A5-thick) does NOT imply (A5) — strict inclusion.** Audit the
   prover's atom-at-zero counterexample. Verify it's:
   - Bayes-plausible (i.e., consistent with $\tau = \sum\mu_0\pi(\cdot\mid\omega)$
     and full-support $\mu_0$).
   - Satisfies (A5-thick) — there's a Lusin-thick compact sequence.
   - Violates (A5) — some $\pi(\cdot\mid\omega)$ has different null
     sets from τ (e.g., an atom at zero that the other state doesn't
     match).
4. **Primitive sufficient conditions.** The prover should identify at
   least one primitive condition weaker than (A5) that implies
   (A5-thick). Verify the implication is rigorous and the condition
   is genuinely weaker than mutual absolute continuity.
5. **Honest framing.** The relaxed Tier 1 theorem reads "Branch B
   closes under standing + (A5-thick) + (A8c-attain)" — both endogenous,
   both implied by familiar primitive conditions. The prover correctly
   notes that (A5-thick) still requires common topological support on
   full-mass Lusin shells; this is a real restriction (excludes
   strict-perfect-revelation) but weaker than (A5).
6. **Scope discipline.** Did the prover stop at (A5) relaxation? No
   leakage into (A9c-calib)?

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

(One paragraph. If PASS, recommend the (A9c-calib) relaxation cycle —
the hardest of the three.)

## Detailed Review

(Per audit items 1–6.)
```

Length budget: 1000–1500 words.
