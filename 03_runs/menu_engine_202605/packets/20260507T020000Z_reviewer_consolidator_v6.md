# Reviewer pass — Menu engine consolidator (v6)

You are the Reviewer. Audit `theorem_2_extension_proof_v6.md` (in
durable) — the new theorem document built around the payoff-profile
menu engine, replacing v5's TRE-gen-Hall-conditional architecture.

## Context

Phase C delivered:
- **Equivalence lemma** (PROVED-CONDITIONAL on profile-realization
  sub-lemma): $U^* = \sup_{C\in\mathcal K(W)} F(C)$.
- **Menu existence + KRN labeling**: gives $\sigma^*$ and $\beta^*$
  attaining the value, no extra hypotheses.
- **Abort test (NEG verdict, reviewer-PASS'd PATCH_SMALL)**: bare
  set-valued mixing over rowwise minimizers does NOT fix the ternary
  non-radial Hall obstruction. The deterministic-vs-set-valued
  distinction is not the dichotomy; multi-dim vector balance is.

The consolidator integrates these into:
- **Tier 1 (no added hypotheses)**: $\sigma^*$ + adversarial $\beta^*$.
- **Tier 2 (under menu-Hall)**: full robust rationalizability.
- **Sharpness witness for Tier 2**: the abort test as embedded lemma.

## Items to audit

1. **Tier 1 statement.** The claim that **no added hypotheses** are
   needed for value + adversary attainment in the menu engine. Verify:
   - Equivalence lemma covers the value direction.
   - Menu existence via Hausdorff compactness + Lipschitz $F$ in $d_H$.
   - KRN labeling delivers $\sigma^*$.
   - KRN on rowwise argmin in compact $C^*\subseteq\R^N$ gives
     $\beta^*$ — A8c-attain is automatic.
   - Profile-realization sub-lemma is genuinely standard (no hidden
     hypotheses smuggled).

2. **Profile-realization sub-lemma's status.** The equivalence is
   PROVED-CONDITIONAL on this sub-lemma. Verify the consolidator is
   honest about this dependency.

3. **Tier 2 statement.** Under menu-Hall: $\hat\sigma^*$ Bayes-optimal
   at $P_{\gamma_\alpha}(\cdot\mid m)$ for q-a.e. $m$. Verify the
   support-function form is correctly stated.

4. **Sharpness witness (the embedded abort test).** $\Omega = \{0,1,2\}$,
   $A$ winner-takes-all, prior uniform, $T = \{\mu : \mu(0)\le 0.4\}$,
   $C^* = \{v_0,v_1,v_2\}$, $R(t_0) = \{v_1,v_2\}$, $B(t_0) = \{p_0\ge p_1, p_0\ge p_2\}$,
   $K_0^- = \{s_0\le s_1, s_0\le s_2\}$, $\bar s\in K_0^-$ + atomless
   $\tau$ ⇒ $\bar s\notin B(t_0)$ for any positive mass. Verify the
   computation is correctly reproduced.

5. **Comparison with v5.** Tier 1 strictly stronger: drops A5-thick
   AND A8c-attain. Tier 2 same logical strength, with menu-Hall
   replacing TRE-gen-Hall (strictly milder framing).

6. **Comparison with paper finite case.** Finite Sion gives upper
   saddle for free; infinite-extension's analog is the convex
   geometry of $W$, but the calibration step needs to be added.
   Verify this framing.

7. **Open problems.** Menu-Hall under additional structure on $C^*$
   (radial, separable, zonotopal, group-invariant). Verify these are
   correctly listed and not overclaimed.

8. **Honest presentation.** No drift; no overclaiming. Sharpness
   witness correctly identifies the structural obstruction.

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

## Opinion and Next Move
(One paragraph. If PASS, recommend stopping the loop and updating
exposition.tex to reflect this new theorem state, OR just commit and
present.)

## Detailed Review
(Per audit items 1–8.)
```

Length: 1500–2500 words.
