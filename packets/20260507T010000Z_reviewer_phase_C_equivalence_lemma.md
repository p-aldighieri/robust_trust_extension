# Reviewer pass — Phase C equivalence lemma (PROVED-CONDITIONAL)

You are the Reviewer. The prover established the menu-formulation
equivalence

$$
U^* \;=\; \sup_{C\in\mathcal K(W),\ C\ne\emptyset}\,F(C),
\quad F(C) = \int_M[\alpha\max_{w\in C}s\cdot w + (1-\alpha)\min_{w\in C}s\cdot w]\,\tau(ds),
$$

PROVED-CONDITIONAL on a profile-realization measurable-selection
sublemma. The aligned-term diagnosis is sharp: for fixed $\sigma$,
aligned $= \int s\cdot w_\sigma(s)\,d\tau$; the $\max_{w\in C}$
appears only after optimal relabeling of a chosen menu.

Full prover response:
`logs/20260507T002000Z_prover_phase_C_equivalence_lemma_response.md`.

## Items to audit

1. **Profile-realization sublemma.** Statement: "compact standard
   Borel private-kernel space $\hat\Sigma$, profile map
   $\Phi:\hat\Sigma\to W$ continuous (or Borel) with compact fibers,
   admits a Borel right inverse $R:W\to\hat\Sigma$." Verify this is
   standard measurable selection (Aliprantis-Border 18.13 / KRN) and
   that $\Phi$'s compact-fiber + Borel structure are correct under
   the paper's standing hypotheses.
2. **Misaligned-term identity.** $\inf_\beta\int\int s\cdot w_\sigma(m)\,\beta(dm\mid s)\tau(ds) = \int_M\min_{m\in M}s\cdot w_\sigma(m)\,\tau(ds) = \int_M\min_{w\in w_\sigma(M)}s\cdot w\,\tau(ds)$.
   Verify each step is rigorous, including the move from "min over $m$"
   to "min over the essential range $w_\sigma(M)$."
3. **Aligned-term identity.** Aligned $= \int s\cdot w_\sigma(s)\,d\tau$
   for fixed $\sigma$. Verify the paper's aligned model gives this.
4. **Joint maximization decoupling.** The argument: optimize over $w_\sigma$
   decouples into (a) pick a compact $C\subseteq W$, (b) assign
   $w_\sigma(s) = \arg\max_{w\in C}s\cdot w$ for the aligned-best
   selection. Verify this decoupling is correct.
5. **No further class restriction needed.** The prover claims
   $\sup_\sigma U(\sigma) = \sup_C F(C)$ at the level of values, with
   the profile-realization sublemma supplying the correspondence in
   the strategy direction. Verify.
6. **Honest framing.** Is the equivalence the right object? Does it
   hold under the paper's standing hypotheses alone (no A5-thick, no
   A8c-attain), as the prover claims?

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

(One paragraph.)

## Detailed Review

(Per audit items 1–6.)
```

Length: 1000–1500 words.
