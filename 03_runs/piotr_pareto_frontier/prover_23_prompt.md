# Prover pass 23 — Derive global-TRS for P6^G from primitive graph geometry

## Role

You are the Prover. Reviewer 17 verified G-FBNF-1 as PASS with one
caveat: the "global TRS" assumption (that the optimal trust region is
union of arc-restrictions on the finite affine graph) was POSTULATED
rather than derived from primitive graph geometry.

Your job: **derive the global-TRS structural property** from primitive
graph-geometric conditions on $(u, A, \Omega, \Theta, \tau)$, removing
the global-TRS caveat from P6^G.

## What to derive

Given:
- Standing hypotheses.
- A measurable finite affine foliation $\ell: V\sqcup E \to \Delta(\Omega)$
  with vertex set $V$ and edge set $E$.
- $\tau$ supported on $M = \ell(V\sqcup E)$ τ-a.e.
- An arc-wise "fiber-preserving" condition: the optimal aligned-best
  selection $w^*: M\to W^P$ pulls back to a piecewise-continuous
  function on the graph.

Derive:
- The optimal trust region $T^*$ is a finite union of arc-restrictions
  $T^* = \bigcup_e \ell_e([L_e, R_e])$.

## Proof strategy

Paper Theorem 1 says any optimal $\sigma^*$ has CONNECTED trust region $T$.
$T = T^*\cap M$ should inherit the graph structure: connected components
of $T^*$ map to connected sub-arcs of the graph.

Standard tools:
- Connected components of a connected subset of a finite-graph foliation
  are arc-restrictions.
- Continuity of the supporting belief at each vertex (FBNF-4 analog).

## What I want

Rigorous derivation in the structure:

```
# Theorem G-FBNF-1.5 (Global-TRS derivation from graph geometry)

## Statement
## Hypotheses (standing + finite affine foliation + arc-wise w*)
## Proof
- Step 1 — Connectedness of T (paper Theorem 1)
- Step 2 — Graph-structure inheritance
- Step 3 — Arc-restriction representation
## Compatibility with P6^G
## Open
```

End with verdict.

## Constraints

- Banned tools list applies.
- Paper Theorem 1, L_B1, G-FBNF-1 may be cited as proved.
- If the derivation requires an additional primitive (e.g., piecewise-
  continuity of $w^*$ on the graph), state it and verify it's natural.
