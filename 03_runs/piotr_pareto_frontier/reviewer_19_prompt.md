# Reviewer pass 19 — Verify P2*-VM variable-margin

## Role

Fresh-chat reviewer on Prover 22's P2*-VM lemma
(`prover_22_response.md`). The lemma replaces P2*'s uniform cone-margin
$\eta > 0$ with a Borel-positive variable margin $\eta(m): M\to(0,\infty)$,
under an integrable upper-capacity condition $b_\eta \le \Gamma_\eta$.

## Specific checks

1. **The variable-margin LP**: does the integrated aligned-baseline
   condition correctly replace the uniform-cone-margin lower bound?
2. **Upper-capacity condition** $b_\eta \le \Gamma_\eta$: is this a
   genuine primitive (not output-conditioned)?
3. **Tightness of approximating LPs**: verify the limit argument.
4. **WTA compatibility**: under P2*-VM, does WTA still fail (without
   baseline) the same way it failed under uniform P2*?

## Verdict

PASS / PATCH / DISPROVED / HOLD.

End with: extend v9.1 with P2*-VM or revert to uniform P2*.
