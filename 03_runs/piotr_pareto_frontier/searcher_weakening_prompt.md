# Targeted-weakening searcher pass — class-by-class

## Role

You are the Searcher. The v9 package has 5 primitive sufficient
classes (Binary, FBNF, P2*, P3, P4) plus the potential P6^G in flight.
Run a targeted weakening attack: for EACH class's load-bearing
condition, ask "can this be relaxed without losing the conclusion?"

## What to attack

For each class, identify the strongest condition and propose
weakening:

### Binary capstone
- (R-EE) endpoint exposure: $B_W(w_L) = \{L\}$ singleton.
  **Weakening question**: can $B_W(w_L)$ be an INTERVAL (non-singleton)
  with appropriate adjustments to the kernel construction?
- (R-TD) tie discipline: τ no atom at the indifference belief.
  **Weakening question**: can τ have an atom at the tie if we use a
  measurable tie-splitting rule?
- (R-IES) interior endpoint: $0 < L < R < 1$.
  **Weakening question**: can corner cases ($L = 0$ or $R = 1$) be
  handled by one-sided KKT?

### FBNF
- (FBNF-7) global fiber dominance.
  **Weakening question**: can cross-fiber dominance be replaced by a
  finite-graph version (which is exactly P6^G)?
- (FBNF-1) affine foliation.
  **Weakening question**: can the foliation be non-affine (e.g.,
  smooth curves)?

### P2*
- Uniform cone-margin η > 0.
  **Weakening question**: can the margin be Borel-positive (variable
  in m) instead of uniform?
- Sufficient aligned baseline D.
  **Weakening question**: can the threshold $D \ge 2(1-\alpha)/(9\alpha)$
  be sharpened?

### P3
- Finite-vertex polyhedral $W$.
  **Weakening question**: countable-vertex extension?

### P4
- Radial / antipodal symmetry.
  **Weakening question**: can the symmetry be approximate (ε-radial)?

## Output

For each weakening question:
- Is it likely weakable (with what tool)?
- Is the weakening economically meaningful (covers more models)?
- Estimated effort: trivial, small prover pass, or substantial work?

Rank the top 2-3 weakenings worth pursuing. End with: pursue / skip /
already covered by existing classes.

## Constraints

Banned tools list applies. Be honest — most weakenings might fail or
overlap with existing classes.
