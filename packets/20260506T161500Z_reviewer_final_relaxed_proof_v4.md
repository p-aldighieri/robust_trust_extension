# Final reviewer pass v4 — `theorem_2_extension_proof_v3.md` (after math-error patches)

You are the Reviewer in the soft-scaffolding workflow.

## Context

Previous review v3 returned **PATCH_BIG** with two real math errors:

1. **(A5-thick) strict-inclusion example** had an invalid posterior
   (used $M = [0,1]\cup\{2\}$ for binary $\Omega$, but $\{2\}\notin\Delta(\Omega)$).
2. **(TRE-gen-Hall) Hall display** was malformed — scalar/measure type
   mismatch, "Leb_q-density" assumed Lebesgue domination of $q$, sup
   bound too weak for pointwise membership.

Both errors are now patched per the reviewer's exact suggestions:

1. **(A5-thick) replaced with the reviewer-supplied valid example:**
   $\Omega = \{0,1\}$, $M = [0,1]$, $\tau = \tfrac12\mathrm{Leb}_{[0,1]} + \tfrac12\delta_0$,
   $\mu_0(1) = 1/4$, $\pi(\cdot\mid 1) = 2s\,ds$, $\pi(\cdot\mid 0) = \tfrac23(1-s)\,ds + \tfrac23\delta_0$.
   Bayes consistency verified. $\tau\not\ll\pi(\cdot\mid 1)$ (atom at 0
   in τ but not in π_1) so (A5) fails. Both posteriors have full
   topological support on $[0,1]$ so $K^* = [0,1]$ thick — (A5-thick)
   holds.

2. **(TRE-gen-Hall) restated cleanly** as the **direct disintegration
   condition**: define $\gamma_\alpha = \alpha(\mathrm{id},\mathrm{id})_\#\tau + (1-\alpha)(\mathrm{id},m^*)_\#\tau$,
   disintegrate to get $\kappa(\cdot\mid m)$, then **(TRE-gen-Hall) requires
   $P_{\gamma_\alpha}(\cdot\mid m)\in C(m)$ q-a.e.**
   The malformed scalar-bracket equation is **dropped**.
   Equivalent **support-function form** added with proper duality:
   $\int_E\phi(P_{\gamma_\alpha}(\cdot\mid m))\,q(dm)\le\int_E h_{C(m)}(\phi)\,q(dm)$
   for all measurable $E$ and continuous affine $\phi$.
   **Necessary-and-sufficient Strassen feasibility** stated as the
   correct integral inequality over a separating family.

The patched document is in durable as
**`theorem_2_extension_proof_v3.md`** (renamed to dodge the project-side
deduplication issue with the prior `theorem_2_extension_proof_relaxed_final.md`
that also failed to update on remove+add).

## Inputs

- **`theorem_2_extension_proof_v3.md`** — the patched final document.
- `phil_reny_route_memo.md`, `phil_reny_bundle.md`,
  `prior_attempts_digest.md`, paper PDF.

## Items to audit

1. **(A5-thick) strict-inclusion correctness.** New example uses
   $M = [0,1]$ (so all posteriors are valid simplex points), Bayes
   consistency holds, atom at 0 in τ but not in π_1 gives
   $\tau\not\ll\pi(\cdot\mid 1)$, both posteriors have full topological
   support on $[0,1]$ so $K^* = [0,1]$ is thick. Verify each step.
2. **(TRE-gen-Hall) correctness.**
   - Direct disintegration condition $P_{\gamma_\alpha}(\cdot\mid m)\in C(m)$
     q-a.e. — well-typed measure-theoretically.
   - Support-function form $\int_E\phi(P_{\gamma_\alpha})\,dq \le \int_E h_{C(m)}(\phi)\,dq$
     — equivalent via standard separating-family duality.
   - Strassen feasibility inequality — necessary and sufficient.
   - No "Leb_q-density" or other Lebesgue-dominated assumption.
   - Binary case still collapses to Appendix A.6 1-D mass-balance.
3. **Other items still passing from v3 review:** Patch 4
   (Dworczak-Smolin reference labels), Patch 5 (RR qualifier), two-tier
   theorem statement.
4. **No new errors introduced by the patches.**

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

(One paragraph. If PASS, recommend stopping the loop and committing.)

## Detailed Review

(Per audit items 1–4, brief.)
```

Length budget: 800–1200 words.
