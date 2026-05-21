# Prover pass 19 — G-FBNF-1: Finite-graph endpoint-fiber pasting

## Role

You are the Prover. Searcher 07 (`searcher_07_response.md`) recommends
**P6$^G$ (Generalized Coarse Signal Structure / Finite Graph FBNF)**
as a candidate 5th primitive sufficient class beyond P2*/P3/P4.

The class generalizes FBNF beyond strict 1-d foliation to a **finite
graph** of arcs in Δ(Ω). The first prover target: **G-FBNF-1** —
the finite-graph endpoint-fiber pasting theorem with Kirchhoff
node balance.

## The lemma to prove

### Setup (P6^G class)

- $|\Omega|\ge 3$, $\alpha\in(0,1)$.
- $M\subseteq\Delta(\Omega)$ is the FINITE union of Borel affine arcs
  $\ell_e: [a_e, b_e]\to\Delta(\Omega)$ indexed by edges $e\in E$ of
  a finite graph $G = (V, E)$. Vertices $V\subseteq\Delta(\Omega)$ are
  the arc endpoints.
- The optimal trust region $T\subseteq\Delta(\Omega)$ is a finite
  union of arc-restrictions $T = \bigcup_e \ell_e([L_e, R_e])$ with
  $L_e\le R_e$ in arc parameter.
- Each arc has fiberwise endpoint exposure: $B_W(w_{e,L_e})\cap\ell_e([a_e,b_e]) = \{\ell_e(L_e)\}$,
  symmetric for $R_e$ (the FBNF-4 analog).
- Fiberwise tie discipline: τ no atom at any arc-endpoint tie (FBNF-5
  analog).
- Global cross-arc dominance: for τ-a.e. $s\in M$ in arc $e$, the
  rowwise min over the FULL T equals the rowwise min over the
  in-arc trust segment $T_e$ (FBNF-7 analog).

### Kirchhoff node balance

At every interior graph vertex $v\in V$, the "flow" balance:
sum of aligned-deficit-in-arc minus sum of misaligned-surplus-from-arc,
summed over edges incident at $v$, equals zero. This is the multi-arc
analog of the binary endpoint balance.

### The theorem

Under P6$^G$ + Kirchhoff node balance + the regularity package
(Reg-1, Reg-2), there exists a Borel adversary kernel $\hat\beta^*$
supported on arc-endpoint fibers such that the disintegration
posterior at every $q$-positive message satisfies Bayes-cone
calibration.

### Proof strategy

1. **Arc-wise B1**: apply L_B1 fiberwise on each arc with $p$ = arc
   endpoint, $A_-$ = aligned-truthful interior segment, $S_+$ =
   misaligned-source region routing to that endpoint.

2. **Kirchhoff balance**: at each interior vertex, sum the L_B1
   constraints across edges; the Kirchhoff condition ensures the
   sum balances.

3. **Measurable pasting across the graph**: glue arc-wise kernels via
   the Borel structure of the graph.

4. **Cross-arc dominance (FBNF-7 analog)**: ensures the adversary
   doesn't route through interior arc messages by crossing arcs.

5. **Verify Definition 2 q-a.e.** on the full graph.

## What I want

Rigorous proof of G-FBNF-1 in the structure:

```
# G-FBNF-1 (Finite-graph endpoint-fiber pasting)

## Statement
## P6^G primitive class definition
## Kirchhoff node balance

## Proof
### Step 1 — Arc-wise B1 application
### Step 2 — Kirchhoff balance at interior vertices
### Step 3 — Measurable pasting via Borel graph structure
### Step 4 — Cross-arc dominance
### Step 5 — Definition 2 q-a.e.

## Coverage examples
- Multi-trust-region models (e.g., two-armed bandits with two
  separate "trust intervals").
- Trees of binary signal experiments.
- Polyhedral W with edge-graph structure.

## Compatibility with v8 sharpness
WTA ternary has W^P = vertex set (0-d), not 1-d arcs, so fails
P6^G-1. Verify.

## Open
- When does Kirchhoff balance hold automatically from optimality?
- Non-finite graphs (countable / continuum of arcs)?
```

## Output Contract

- Inline markdown.
- The Kirchhoff balance is the new structural ingredient — be
  explicit about how it generalizes the binary endpoint balance.
- End with verdict + next-step (extend v9 or stop sharpening).

## Constraints

- Banned tools list applies.
- L_B1 may be cited as proved.
- FBNF analog conditions (1, 4, 5, 7) are inherited; the new content
  is Kirchhoff + graph pasting.
