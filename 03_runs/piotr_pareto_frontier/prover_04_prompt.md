# Prover pass 04 — Calibration under strictly convex W + TRS

## Role

You are the Prover. Pass 3 reached the (D2) gate for general α ∈ (0,1).
The user has explicitly overridden the "consolidate" recommendation
and asked the pipeline to keep trying.

This pass attacks a fresh route the previous passes did NOT verify:
**combining Theorem 1's TRS structure with strict convexity of W**.

## Setup recap

Paper Robust Trust (Dworczak-Smolin 2026):
- \(W = \{w\in\R^N : \exists \hat\sigma, w(\omega) = \E[u(a,\omega,\theta)\mid\omega]\}\), convex compact.
- \(W^P\) = weak Pareto frontier.
- \(B_W(w) = N_W(w)\cap\Delta(\Omega)\) = Bayes cone of \(w\) (beliefs at
  which \(w\) is Bayes-optimal in \(W\)).

**Theorem 1 (paper)**: any optimal \(\sigma^*\) is equivalent to a Trust
Region Strategy (TRS) with a **connected** trust region \(T\subseteq\Delta(\Omega)\).
At \(m\in T\), the agent acts at face value (Bayes-optimal at posterior \(m\)).
At \(m\notin T\), the agent acts as if the posterior were the Bregman
projection \(\Pi_T(m)\in\partial T\).

For a TRS:
- The labeling \(w^*: M\to W^P\) is \(w^*(m) = R^{-1}(\text{Bayes-optimal at }\Pi_T(m))\)
  (or \(m\) directly if \(m\in T\)).
- The adversary's optimal kernel is **deterministic Bregman projection**:
  \(\beta^*(\cdot\mid s) = \delta_{\Pi_T(s)}\) for \(s\notin T\) (and any
  in-T target for \(s\in T\); standard convention puts those at \(s\)
  itself, contributing to aligned-side).

## Hypotheses for this pass

- (H1) Standing assumptions.
- (H2) **Strictly convex \(W\)**: for any \(w \in \partial W\) (boundary
  of W), the supporting normal cone \(N_W(w)\cap S^{N-1}\) is a singleton
  (unique direction up to positive rescaling). Equivalently, the
  supporting hyperplane at any boundary point of \(W\) touches \(W\) in
  exactly one point.
- (H3) **Smooth optimal trust region**: the optimal \(T\) has a \(C^1\)
  boundary \(\partial T\) (no corners, no faces of dimension < \(N-1\)).
  This is implied by (H2) plus regularity of the agent's value function
  on \(\Delta(\Omega)\) (which inherits smoothness from strict convexity
  of \(W\) under standard arguments).

Both (H2) and (H3) are **economically meaningful primitive conditions**:
they correspond to smooth utility \(u(a,\omega,\theta)\) without
degenerate action equivalences.

## The claim to prove

**Theorem (Pareto-frontier route, calibration under strict convexity).**
Under (H1) + (H2) + (H3), there exists an optimal \(\sigma^*\) in TRS
form with adversarial kernel \(\beta^*\) (deterministic Bregman projection)
such that the disintegration posterior
\[
P_{\beta^*}(\cdot\mid m) \;\in\; B_W(w^*(m)) \quad \text{for $q$-a.e.\ } m\in M.
\]
This proves Definition 2 robust rationalizability for infinite \(M\) and
infinite \(\Theta\), without any added Hall-style hypothesis.

## Proof structure (your job to verify or refute)

### Step 1 — TRS structure (cite Theorem 1)

Any optimal \(\sigma^*\) is equivalent to a TRS \((T, \sigma_T)\) with
connected \(T\). Cite the paper's Theorem 1. Under (H3), \(\partial T\) is
\(C^1\).

### Step 2 — Bregman projection deterministic kernel

For \(s\notin T\), \(\Pi_T(s)\) is well-defined and single-valued
(\(\partial T\) is \(C^1\), \(T\) is connected convex closed).

The adversary's optimal kernel is \(\beta^*(\cdot\mid s) := \delta_{\Pi_T(s)}\)
for \(s\notin T\) and \(\beta^*(\cdot\mid s) := \delta_s\) for \(s \in T\)
(adversary cannot help by deviating from truthful inside T because of TRS).

**Verify**: this gives \(U(\beta^*, \sigma^*) = U^*\), with attainment.
Cite paper Section 3.

### Step 3 — Aligned-side conditional posterior at boundary message

For \(m\in\partial T\), the message marginal \(q\) has:
- Aligned contribution: \(\alpha\,\tau(\{m\})\). Under continuous \(\tau\)
  this is zero individually but the boundary surface \(\partial T\) may
  have \(\tau\)-mass.
- Misaligned contribution: \((1-\alpha)\,\tau(\Pi_T^{-1}(m))\) where
  \(\Pi_T^{-1}(m) = \{s : \Pi_T(s) = m\}\). Under (H3), this is the
  Bregman normal ray at \(m\) extending outward from \(T\) in
  \(\Delta(\Omega)\setminus T\).

The conditional source posterior at \(m\):
\[
P_{\beta^*}(\cdot\mid m) \;=\; \frac{\alpha\,m\,\mathrm{1}_{m\in T} + (1-\alpha)\,\E[s\mid s\in\Pi_T^{-1}(m)]\,\tau(\Pi_T^{-1}(m))/q(m)}{\text{normalizer}}.
\]
(Careful with the aligned-on-boundary case; spell it out.)

### Step 4 — Conditional misaligned posterior is on the Bregman normal ray

Define \(\mu^-(m) := \E[s\mid s\in\Pi_T^{-1}(m)]\), the conditional
barycenter of misaligned sources mapped to \(m\). Under (H3) (\(\partial T\)
is \(C^1\) with unique outward normal at \(m\)), the set \(\Pi_T^{-1}(m)\)
is a **straight ray** in the Bregman geometry: \(\{s = m + t \cdot \nabla h^*\text{-stuff}\}\)
(make this precise using Rockafellar duality / Bregman ball geometry).

The conditional barycenter \(\mu^-(m)\) is therefore a single point on
the Bregman normal ray.

### Step 5 — Bregman normal direction equals supporting hyperplane direction at \(w^*(m)\)

This is the load-bearing step. Use:
- **(H2) Strict convexity of \(W\)**: the supporting hyperplane to \(W\)
  at \(w^*(m)\) has a unique direction \(\nu(m) \in S^{N-1}\).
- \(w^*(m)\) is Bayes-optimal at posterior \(m\) (TRS face-value at \(m\)).
  Equivalently, \(m\) is a supporting belief: \(m\cdot w^*(m) \ge m\cdot w\)
  for all \(w\in W\). So \(m\) is on the supporting hyperplane direction
  \(\nu(m)\).
- The Bregman normal direction at \(m\) on \(\partial T\) is precisely
  this \(\nu(m)\) (standard fact from convex duality: the trust region's
  boundary normal coincides with the supporting hyperplane direction of
  the Bayes-optimal profile).

So the Bregman normal ray at \(m\) consists of points \(\{m + t\nu(m) : t \ge 0\}\)
all of which are in the supporting hyperplane direction \(\nu(m)\) at
\(w^*(m)\). All such points are in \(B_W(w^*(m))\) (by definition of
supporting cone).

**Conclusion**: \(\mu^-(m) \in B_W(w^*(m))\).

### Step 6 — Calibration at \(m\)

The full posterior \(P_{\beta^*}(\cdot\mid m)\) is a convex combination
of:
- \(m\) (aligned contribution) \(\in B_W(w^*(m))\) (since \(m\) is the
  supporting belief).
- \(\mu^-(m)\) (misaligned conditional) \(\in B_W(w^*(m))\) (by Step 5).

\(B_W(w^*(m))\) is convex (it's a face of \(\Delta(\Omega)\) — the
supporting normals form a cone). Therefore the convex combination is
in \(B_W(w^*(m))\).

**Calibration is automatic at every boundary message under (H1)+(H2)+(H3).**

### Step 7 — Interior messages

For \(m \in T \setminus \partial T\) (interior of trust region), the
adversary doesn't visit (since β* = δ_{Π_T(s)} sends mass to ∂T for s∉T,
and aligned contribution at m∈T is just m itself with posterior δ_m).
So calibration at interior m is automatic: σ̂*(m) = R(w*(m)) is
Bayes-optimal at belief m by definition of w*(m).

### Step 8 — Definition 2 conclusion

Combining Steps 6+7, σ̂*(m) is Bayes-optimal under P_β*(·|m) for q-a.e. m.
Definition 2 (robust rationalizability) holds. The existence direction of
Theorem 2 closes under (H1)+(H2)+(H3) for infinite M and Θ.

## What I want you to produce

A FULLY RIGOROUS proof of the Theorem above, in the structure:

```
# Theorem (Pareto-frontier route, calibration under strict convexity)

## Statement
(Restate.)

## Hypotheses
- (H1) Standing.
- (H2) Strict convexity of W.
- (H3) Smooth optimal trust region.

## Proof (Steps 1-8)

### Step 1 — TRS structure (Theorem 1)
### Step 2 — Bregman projection kernel
### Step 3 — Conditional posterior at boundary
### Step 4 — Bregman normal ray
### Step 5 — Direction match (CRITICAL — verify carefully)
### Step 6 — Convex combination in B_W
### Step 7 — Interior messages
### Step 8 — Definition 2

## Verification: does Step 5 actually hold?
The load-bearing claim is: under (H2), the Bregman normal direction at
m ∈ ∂T equals the supporting hyperplane direction at w*(m) in W. Prove
or refute this carefully.

## Compatibility with v8 sharpness package
The WTA ternary witness has vertex menu W^P = {v_0, v_1, v_2}. (H2)
fails for this: W is not strictly convex (it's a triangle, hence
polyhedral). So (H2) rules out the v8 witness. Verify this is
correct.

## Open issues
- Original-message lift for individual representative m_i — does the
  TRS structure obviate the lift issue? Or does it persist?
- Verify (H2) is genuinely satisfied by economically meaningful models
  (smooth utility u(a,ω,θ) without degenerate action equivalences).
- Verify (H3) follows from (H2) + standard regularity (or state it
  separately).
```

## Output Contract

- Inline as plain markdown.
- BE SKEPTICAL of Step 5 — that's the load-bearing step. If it doesn't
  hold, the theorem fails. If you find it does hold, the theorem closes
  Definition 2 robust rationalizability under (H2)+(H3) — a major
  positive result.
- If (H2)+(H3) is insufficient and you need additional hypotheses,
  state them precisely.
- End with: verdict (theorem holds / theorem fails / needs additional H)
  + next-step signal.

## Constraints

- Banned re-proposals: see prior_attempts_digest.md.
- (H2) strict convexity of W is candidate C4 from Searcher 02, which
  was classified "not sufficient". The current argument tries to use
  it COMBINED WITH the TRS structure from Theorem 1 — that may be the
  ingredient Searcher 02 missed.
- v8 sharpness witness must be compatibility-checked.
- The user wants this to converge or fail decisively; do not hedge.
