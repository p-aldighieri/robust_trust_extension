# Prover pass 20 — G-FBNF-2 + G-FBNF-3 to close P6^G

## Role

You are the Prover. G-FBNF-1 is proved (Prover 19) and in fresh-chat
verification (Reviewer 17). Prove the two remaining FBNF-graph lemmas:

- **G-FBNF-2 (endpoint-only graph image)**: misaligned BR on each
  arc routes to arc endpoints only — multi-arc analog of L_B3 / F2.
- **G-FBNF-3 (localized graph stationarity → Kirchhoff balance)**:
  at the optimal multi-arc trust band, localized perturbations of
  each arc endpoint yield Kirchhoff balance at interior vertices —
  multi-arc analog of L_B5 / F3.

## What to produce

```
# G-FBNF-2 (Endpoint-only graph image)

## Statement
Under P6^G-1 (finite affine graph foliation) + analog of FBNF-3
(arc-wise supporting-line domination), the misaligned BR on each
arc concentrates on arc endpoints τ_e-a.e.

## Proof
Apply L_B3 analog arc-by-arc. Standard.

# G-FBNF-3 (Localized graph stationarity → Kirchhoff balance)

## Statement
At the optimal multi-arc trust band T = ∪_e ℓ_e([L_e, R_e]),
localized two-sided perturbations of (L_e, R_e) yield λ-a.e.
fiberwise balance + Kirchhoff balance at every interior graph
vertex v.

## Proof
- Per-arc balance from v9 T1 conditional Clarke-Danskin (as in F3).
- Interior vertex shared by edges e, e' must satisfy a flow
  conservation: aligned deficit + misaligned surplus in arc e
  balances aligned deficit + misaligned surplus in arc e'. This
  is the Kirchhoff law.
- Boundary vertices: one-sided KKT.

## Combined corollary
P6^G primitive class closes Theorem 2 unconditionally for multi-arc
trust regions with finite graph structure.
```

## Output Contract

Inline markdown. Be precise about Kirchhoff balance at interior
vertices. End with verdict + next-step (extend v9.1 with P6^G or
stop sharpening).

## Constraints

- Banned tools list applies.
- G-FBNF-1 cited as proved (subject to Reviewer 17).
- Per user: if G-FBNF-2/3 stalls, stop sharpening per Searcher 07.
