# Reviewer pass 09 — Verify F3 (localized stationarity → fiberwise balance)

## Role

Fresh-chat reviewer on **F3** from `prover_10_response.md` (durable
source). Verdict from Prover 10: **PASS with regularity caveat** —
FBNF-6 (fiberwise total balance) is derived from optimality plus
localized two-sided perturbations of the FBNF trust band; if the
model has boundary endpoints or lacks two-sided perturbations,
replace equality by KKT inequalities.

## What's being verified

Under standing + FBNF-1+2+3+4+5 + the optimal TRS being a global
maximizer of $V_P$ within the FBNF class, the fiberwise total-balance
equations hold for λ-a.e. z:

$\alpha\int_{a_z}^{L(z)}(L(z)-t)\tau_z(dt) = (1-\alpha)\int_{S_+(z)}(t-L(z))\tau_z(dt)$,
symmetric for $R(z)$.

## Specific checks

- **Differentiability of $V_P(T_\eps)$**: verify the perturbed value
  is differentiable in $\eps$ via the binary perturbation calculus
  applied pointwise in z.
- **λ-a.e. Fermat from Borel-patch testing**: verify the localization
  argument is rigorous (Lebesgue differentiation / monotone class).
- **KKT caveat**: when does equality fail and one-sided inequality is
  the right form? Confirm this is BOUNDARY only (L(z)=0 or R(z)=1),
  not a generic gap.
- **FBNF-6 is DERIVED**, not assumed: confirm this is the cleaner
  primitive class.

## Verdict
- PASS / PATCH_SMALL / PATCH_BIG / DISPROVED / HOLD.
- One-line + next-step signal.
