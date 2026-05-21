# Searcher pass 03 — Special primitive islands (binary, radial, connected-T)

## Role

You are the Searcher. Pass 3's broad primitive search (Searcher 02) ruled
out seven candidates for (D2)/deletion-compatible Hall duality and
recommended consolidation. The **user has explicitly overridden** that
recommendation and asked the pipeline to keep trying.

This pass surveys **special primitive islands** that Searcher 02 did
NOT cover in depth:

1. **Binary state** \(|\Omega|=2\): paper Appendix A.6 covers finite \(M\)
   in this case. Push to infinite \(M\), \(\Theta\).
2. **Antipodal/radial \(\tau\)-symmetry**: paper §5.2 + Appendix A.10
   spherical case with rotational invariance.
3. **Connected trust region (Theorem 1) + Clarke-Danskin (T1) combo**:
   any optimal \(\sigma^*\) has connected \(T\); \(C^* = w^*(T)\) is
   therefore connected compact in \(W^P\). Whether connectedness
   forces structural calibration that finite-vertex \(C^*\) does not is
   unverified.
4. **Polyhedral W with finite-faceted optimal T**: extends (R2-FES) via
   piecewise-linear structure.

## Convergent context from previous passes

- **(T1) finite-menu Pareto-Hall** closes UNCONDITIONALLY in payoff-label
  coordinates via Clarke-Danskin stationarity.
- **(D2)** for general α∈(0,1) is structurally menu-Hall in finite-fiber
  coordinates (Reviewer 03 + Searcher 02).
- The locked gate: source-to-message splitting inside fibers
  \(F_i = (w^*)^{-1}(w_i)\) under aligned-diagonal mass.

## What the new islands might buy

### Island 1: Binary state |Ω|=2

Paper §4.2 (binary state, Appendix A.6) gives a *complete characterization*
of optimal robust strategies via a single-interval trust region
\(T = [μ_L, μ_R]\subset[0,1]\). In binary, \(W^P\) is a 1-dimensional
curve (the upper boundary of the convex hull of \((u(a, 0), u(a, 1))\)
across actions \(a\)). The Gauss map is single-valued except at corners.
Bregman projection onto \([μ_L, μ_R]\) is two-point: every \(s < μ_L\)
projects to \(μ_L\), every \(s > μ_R\) projects to \(μ_R\). Therefore the
adversary's image consists of at most TWO points \(\{μ_L, μ_R\}\), and
the menu \(C^*\) consists of at most TWO active labels.

So the binary case reduces to finite-menu Pareto-Hall (T1) AUTOMATICALLY,
with \(k \le 2\). Calibration follows from Theorem T1. Lift through
\(w^*\) is straightforward when \(\tau\) has full support on
\([μ_L, μ_R]\) (the fibers are explicit intervals).

**Question**: does this give an UNCONDITIONAL infinite-extension of
Theorem 2 for binary state, infinite \(M\) and \(\Theta\)?

### Island 2: Radial τ-symmetry

For state spaces with rotational symmetry (e.g., \(|\Omega|\ge 3\) with
\(\tau\) invariant under a finite group acting on \(\Delta(\Omega)\)),
the optimal trust region inherits the symmetry. \(C^*\) is then a
union of group-orbits in \(W^P\). For each orbit, the Bayes-cone
\(B_W(w_i)\) and the source distribution on \(F_i\) inherit
matching symmetry, which may force calibration by symmetry-averaging.

**Question**: state a precise primitive symmetry condition (compact
group \(G\) acts on \(\Delta(\Omega)\), \(\tau\) is \(G\)-invariant,
\(u\) is \(G\)-equivariant in \(a\), \(\omega\)). Under this condition,
does the optimal \(C^*\) decompose into \(G\)-orbits with calibrated
posteriors?

### Island 3: Connected-T + Clarke-Danskin combo

Theorem 1 (paper) says any optimal \(\sigma^*\) is a TRS with CONNECTED
trust region \(T\). Then \(C^* = w^*(T) \subseteq W^P\) is connected
(image of connected set under continuous map).

If \(C^*\) is **connected** in \(W^P\) — instead of an arbitrary compact
subset — Clarke-Danskin needs a generalization to **infinite-active-face**
case. Or: maybe the connected structure FORCES (R2-FES) (finite
effective exposure).

**Question**: under what primitive condition does a connected
\(C^* \subseteq W^P\) have only finitely many \(\tau\)-effectively-exposed
labels? Candidate: \(W^P\) is a polyhedral 1-skeleton (curves of finitely
many segments), \(\tau\) is supported on a finite union of segments.

### Island 4: Polyhedral W with finite-faceted T

\(W\) polyhedral (finitely many vertices, edges, faces) ⇒ \(W^P\) is a
polyhedral 1-skeleton ⇒ active-face decomposition of \(M\) is finite
piecewise-linear. The optimal trust region \(T\) is then polyhedral
(finitely many faces). Combined with Theorem 1's connected-T property,
\(T\) is a connected polytope inside \(\Delta(\Omega)\).

The labeling \(w^*: M \to C^*\) is then a finite piecewise-linear map.
Fibers \(F_i\) are finite unions of polyhedral cells. Lyapunov's
convexity theorem on each cell (under atomless \(\tau\)) gives full
control over conditional barycenters.

**Question**: does polyhedral \(W\) + atomless \(\tau\) yield (D2)
unconditionally?

## Banned re-proposals (carry forward)

- (C1-C7) from Searcher 02. Do NOT re-propose atomless+fiber-rich-Lyapunov
  alone, single-valued Gauss alone, smooth+strictly-convex W^P alone,
  product utility, generic coarsening.
- All v8 closure memo banned moves.
- Searcher 02 also confirmed: future work narrowly framed as the
  deletion-compatible Hall duality theorem OR as special primitive
  islands. Islands 1-4 above are the four specific islands worth
  surveying.

## Output Contract

Rank Islands 1-4 by:
- Probability of yielding an UNCONDITIONAL infinite-extension of
  Theorem 2.
- Economic meaningfulness of the primitive.
- Compatibility with the v8 sharpness package.

For the top-ranked island, produce:
- Precise primitive hypothesis.
- Sketch of the proof structure (which existing tools, which new
  ingredients).
- The first prover target.

Return inline as markdown. End with: (a) one-line verdict on which
island to attack first, (b) one-paragraph next-step signal for the
breakdown role.

## Constraints

- The user has explicitly said keep trying. If you find that all four
  islands hit the same locked gate, propose a FIFTH novel angle the
  pipeline has not tried.
- Do not propose adding (D2)/menu-Hall as an axiom; the route's value
  is in NOT requiring it.
- v8 sharpness witness is WTA ternary with vertex-only \(W^P\); any
  island must explain how it handles or rules out this witness.
