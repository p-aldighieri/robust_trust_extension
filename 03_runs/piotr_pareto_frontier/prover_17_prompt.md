# Prover pass 17 — Implementable LP template + worked examples

## Role

You are the Prover. G4 (finite-facet polyhedral LP threshold) is
PROVED + Reviewer 15 PASS. Per Reviewer 15's next-step signal: write
the **implementable LP template** with explicit inputs and run it on
three concrete models.

## What to deliver

### Part 1: The LP template

State the LP feasibility check explicitly. Inputs:
- $g_{j\ell}$ — extreme dual price vector for cell $\ell$ at vertex $j$.
- $c_{j\ell}$ — corresponding support-function value $h_{B_j}(g_{j\ell})$.
- $\lambda_j$ — aligned baseline weight at vertex $j$.
- $\bar m_j$ — position of aligned baseline at vertex $j$.
- $\mu_j$ — misaligned source weight to vertex $j$.
- $\bar s_j$ — conditional source mean for sources routed to vertex $j$.
- $\alpha$ — alignment probability.

The LP feasibility condition: finitely many linear inequalities in
$(g, c, \lambda, \bar m, \mu, \bar s, \alpha)$. Spell out the LP
formulation cleanly.

### Part 2: WTA ternary worked example

For $|\Omega| = 3$, $W$ = WTA (3 vertices $v_0, v_1, v_2$), $\tau$
uniform on $\Delta(\Omega)$, $\alpha = 1/2$:
- Extreme dual prices $g_{j\ell}$.
- Support functions $c_{j\ell}$.
- LP feasibility check → threshold $D \ge 2(1-\alpha)/(9\alpha) = 2/9$
  on aligned baseline.
- Verify the table matches G1's hand-computation.

### Part 3: Plurality voting $|\Omega|=K$

General plurality with $K$ states, $K$ actions:
- $W$ has $K$ vertices.
- Symmetric case: $\tau$ uniform, $\alpha$ general.
- Compute the symmetric threshold $D_K(\alpha)$ on aligned baseline.
- Compare to WTA ternary ($K=3$).

### Part 4: Finite-experiment design (Doval-Smolin example)

Pick one concrete finite-experiment from Doval-Smolin (2024):
- E.g., a binary signal experiment for a 3-state model.
- Compute the LP threshold.
- Interpret economically.

## Output Contract

- Inline markdown with explicit LP formulas.
- Three tables (one per example) with the LP threshold computation.
- End with a synthesis: how the LP template implements G3+G4 in
  practice.

## Constraints

- Banned tools list applies.
- Use Reviewer 15's notational conventions.
- Per user: relentless. Make this implementable and concrete.
