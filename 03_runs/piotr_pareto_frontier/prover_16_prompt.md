# Prover pass 16 — Finite-facet polyhedral LP threshold

## Role

You are the Prover. Per Reviewer 13 + Prover 15's next-step signal:
formalize the **finite-facet polyhedral version** of the cone-Hall
sufficient condition. Goal: an explicit LP threshold that classifies
finite-action multi-state models — including the v8 WTA ternary
witness and its baseline-augmented variants — into "Theorem 2 holds"
vs "fails by dual certificate".

## The theorem to prove (G4 polyhedral threshold)

### Setup
- $|\Omega| \ge 3$, finite.
- $W$ polyhedral with finitely many vertices $\{v_1, \ldots, v_K\}$
  (e.g., finite action set with linear utility extended over $\Theta$).
- $C^* \subseteq W^P$ is the optimal menu, taken to be a finite subset
  of vertices: $C^* = \{w_1, \ldots, w_k\} \subseteq \{v_1, \ldots, v_K\}$.
- $B_W(w_j) = $ supporting belief cone at vertex $w_j$ — a polyhedral
  closed convex subset of $\Delta(\Omega)$.
- $R(s) = $ rowwise minimizer correspondence.
- $\tau \in \Delta(M)$ with $M \subseteq \Delta(\Omega)$ Borel.
- $\alpha \in (0,1)$.

### G4 Theorem statement
There exists $\delta > 0$ — depending only on the polyhedral geometry
of $W$, $C^*$, and the cone margins — such that **if the aligned
baseline satisfies the explicit LP threshold inequality** (to be derived
below), then the cone-Hall dual inequality $\Psi(y) \le 0$ holds for
all bounded Borel $y$.

### LP threshold (to derive)

For each vertex $j$ and each candidate dual price $y^{(j)}$
(parametrized by the finite normal fan), define:
- $a_j(y) = \alpha\int_M[y\cdot m - h_{B_j}(y)]\,\mathbf{1}_{\text{aligned at }j}\tau(dm)$
- $b_j(y) = (1-\alpha)\int_S[y\cdot s - h_{B_j}(y)]\,\mathbf{1}_{S_j}\tau(ds)$

where $S_j = R^{-1}(j)$ is the source region routing to vertex $j$.

The threshold condition: for each "extreme" dual price family $y$
(parameterized by the polyhedral normal fan of $W$),
\[
a_j(y) + b_j(y) \le 0 \quad \text{for every }j.
\]

This is finitely many inequalities (one per polyhedral cone-cell of
dual prices), each EXPLICITLY COMPUTABLE in terms of:
- $\alpha$
- aligned baseline weights $\tau(\text{aligned-cell-at-}j)$
- misaligned source weights $\tau(S_j)$
- positions $m_j$, $w_j$.

### Application to WTA ternary

For $|\Omega| = 3$, $W$ = WTA polyhedron (3 vertices), $C^* = \{v_0, v_1, v_2\}$:
- The dual prices $y_j = 1 - 2e_j$ from G1 are EXTREME for the WTA
  normal fan.
- The G4 threshold reduces to the inequalities derived in G1's WTA
  computation.
- Without baseline: $\Psi(y) = (1-\alpha) \cdot 4/9 > 0 \Rightarrow$
  Theorem 2 fails.
- With baseline $D \ge 2(1-\alpha)/(9\alpha)$: $\Psi(y) \le 0 \Rightarrow$
  Theorem 2 holds.

This recovers exactly the threshold from Reviewer 11.

## Proof structure

### Step 1 — Polyhedral normal fan
$W$ polyhedral ⇒ the dual normal-cone correspondence
$y \mapsto \arg\max_{w\in C^*} y\cdot w$ has piecewise-constant
behavior partitioned by a finite normal fan in $\R^{|\Omega|}$.

### Step 2 — Extreme dual price
The cone-Hall dual $\Psi(y) \le 0$ holds for all bounded Borel $y$
iff it holds at the EXTREME dual prices of the polyhedral normal
fan. By finiteness, this is finitely many inequalities.

### Step 3 — Per-vertex decomposition
For each polyhedral cone-cell, the extreme dual price $y^{(j)}$
satisfies $y^{(j)}\cdot w_k - h_{B_k}(y^{(j)}) = ?$ in a specific
piecewise-linear way.

### Step 4 — LP threshold
Combine across vertices. The threshold becomes a finite-dimensional LP
in baseline weights vs. misaligned source weights.

### Step 5 — Classification of finite-action models
Apply Step 4 to: WTA, plurality voting, finite-experiment design,
ordered finite-action models. Each gives an explicit threshold for
Theorem 2.

## What I want

```
# Theorem G4 (Finite-facet polyhedral threshold)

## Statement

## Hypotheses (polyhedral W, finite vertices, |Ω|≥3, α∈(0,1))

## Proof
### Step 1 — Polyhedral normal fan
### Step 2 — Reduction to finite extreme prices
### Step 3 — Per-vertex piecewise-linear decomposition
### Step 4 — LP threshold inequalities

## Application to WTA ternary
Recover the G1 WTA dual certificate as a special case. Verify the
threshold $D \ge 2(1-\alpha)/(9\alpha)$.

## Application to other finite-action models
- Plurality voting (general |Ω|).
- Finite-experiment design (Doval-Smolin examples).
- Ordered finite-action MLR.

## Implications
- Robust Trust Theorem 2 for finite-action polyhedral models reduces
  to a finite LP feasibility check.
- The threshold is explicit and computable.

## Open
- Non-polyhedral W (smooth strictly convex).
- Infinite-action limits.
```

## Output Contract

- Inline markdown.
- Be explicit about the LP formulation.
- Apply to WTA ternary as the killer sanity check.
- End with verdict + next-step.

## Constraints

- Banned tools list applies.
- G3 biconditional may be cited as proved.
- Per user: relentless. The LP threshold is the deliverable.
