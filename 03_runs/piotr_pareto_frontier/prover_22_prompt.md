# Prover pass 22 — P2* variable-margin weakening

## Role

You are the Prover. Targeted-weakening searcher identified **P2*
variable-margin** as the second-ranked weakening to attempt.

## What's being weakened

**Current P2***: uniform cone-margin $\eta > 0$ — there exists a
single positive constant $\eta$ such that every active vertex
$w_j\in C^*$ has Bayes cone $B_W(w_j)$ "wider than $\eta$" in a
precise sense.

**Target weakening (P2***-VM**): allow the margin to be a
Borel-measurable positive function $\eta(m): M\to(0,\infty)$,
strictly positive but not bounded below by a uniform constant.

## Lemma to prove (P2*-VM)

Under standing + |Ω|≥3 + α∈(0,1) + (P1) smooth strict-convex
utility + atomless τ + **(P2*-VM) Borel-positive cone-margin**
+ sufficient aligned baseline (in an integrated sense involving
$\eta(m)$), Theorem 2 holds.

## Proof structure

### Step 1 — Restate the cone-Hall dual under variable margin
The dual inequality $\Psi(y) \le 0$ now involves an integral against
$\eta(m)$ instead of uniform $\eta$. Verify the LP remains feasible
under the integrated condition.

### Step 2 — Tightness argument
Under atomless τ + Borel-positive $\eta$ + integrated aligned baseline,
the dual reaches its infimum. (Lyapunov / Dunford-Pettis tightness.)

### Step 3 — G3 biconditional applies
Pull back to G3: since Ψ(y) ≤ 0 holds, by G3 the calibrated kernel
exists.

### Step 4 — Verify economic content
Is "Borel-positive but not uniformly bounded" a meaningful weakening?
Concretely: economic models where the cone-margin shrinks to zero at
certain boundary points (e.g., the simplex boundary of Δ(Ω)) but
remains positive on the interior of M.

## What I want

Rigorous proof of P2*-VM, in the structure above. Critical questions:
- Does the integrated aligned-baseline condition replace the
  uniform-cone-margin lower bound cleanly?
- Or do we need an additional integrability hypothesis on $\eta(m)^{-1}$?

Output:
```
# Lemma P2*-VM (variable-margin)

## Statement
## Hypotheses
## Proof (Steps 1-4)
## Economic interpretation
## Compatibility with original P2*
```

End with verdict.

## Constraints

- Banned tools list applies.
- G3, L_B1 may be cited as proved.
- If the weakening requires recovering uniform-cone-margin from
  $\eta(m)^{-1}$ integrability, that's an honest failure — say so.
