# Searcher pass 07 — Sharpening pass for additional primitive sufficient classes

## Role

You are the Searcher. The verification block returned the final v9
package: 5 reviewer-PASS'd theorems + Hall biconditional + 3 primitive
sufficient classes (P2*, P3, P4) + LP threshold G4.

This pass is **sharpening**: look for **additional primitive sufficient
classes** beyond P2*/P3/P4 that broaden the unconditional coverage of
unrestricted |Ω|≥3 Theorem 2. The constraint: any new class must be a
**primitive condition on (u, A, Ω, Θ, τ)**, NOT calibration on output.

## Existing primitive classes (cited from `v9_consolidated.md`)

- **(P2\*)** Smooth strict-convex utility + atomless τ + uniform
  cone-margin η > 0 at frontier vertices + sufficient aligned baseline.
- **(P3)** Polyhedral W with finite-vertex C* + cone-margin.
- **(P4)** Radial / antipodal τ-symmetry on spherical models.

## Candidate additional classes

### (P5) Concavified utility + sandwich condition

Suppose $u(a, \omega, \theta)$ is such that the concavified value
function $\Phi(\mu) = \sup_W \mu\cdot w$ on $\Delta(\Omega)$ is
"sandwiched" between two convex envelopes. Does this imply Ψ(y)≤0
for the resulting Bayes selector?

### (P6) Coarse signal structure

Suppose τ is supported on a finite union of arcs (not necessarily a
single foliation) — i.e., M is a 1-skeleton of finite arcs in $\Delta(\Omega)$.
Does this generalize FBNF beyond strict 1-d foliation while preserving
endpoint-only adversary?

### (P7) Symmetric multi-trust-region

For models with a finite group acting on $\Delta(\Omega)$ preserving
the optimal trust region T, the action lifts to W and to W^P. Is
G-equivariance enough to give Ψ(y)≤0 by symmetry averaging?

### (P8) Bayes-cone-saturated boundary

If $\partial T$ has the property that EVERY $\mu \in \partial T$ is
Bayes-supporting for SOME action a, then no rowwise-minimizer routes
through interior. Does this give endpoint-only adversary unconditionally?

### (P9) Generic position

Suppose $W$, $\tau$, $\mu_0$ are in "generic position" (no degenerate
ties on a positive-measure set). Is generic position alone enough to
imply Ψ(y)≤0?

## What I want

For each candidate, check:
- Is it genuinely primitive (not output-conditioned)?
- Does it imply Ψ(y)≤0 under the regularity package?
- Coverage: what economic models satisfy it that AREN'T covered by P2*/P3/P4?
- Sharpness: does it correctly exclude the WTA witness (or include
  it under aligned baseline)?

Top recommendation: which (P*) is the most valuable to add to v9?

## Output Contract

Inline markdown. Rank candidates. Recommend top addition. If none of
P5-P9 add meaningful coverage beyond P2*/P3/P4, report so and propose
new candidates.

End with: (a) verdict — add to v9 or not; (b) if yes, first prover
target; (c) if no, recommendation for the orchestrator (stop sharpening,
or pivot to other improvements like polished LaTeX export of v9
consolidated memo).

## Constraints

- Banned tools list applies.
- Per user: "leave no stone unturned" — but also: don't add empty classes.
- The endpoint goal: v9 covers the maximum primitive coverage that's
  CHECKABLE and economically meaningful.
