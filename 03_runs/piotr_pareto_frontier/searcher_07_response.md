
========
ROLE: user (id=328e3932-2e7d-4db1-a991-ec0184e4678a)
========
# Searcher pass 07 — Sharpening pass for additional primitive sufficient classes

## Role

You are the Searcher. The verification block returned the final v9
package: 5 reviewer-PASS'd theorems + Hall biconditional + 3 primitive
sufficient classes (P2*, P3, P4) + LP threshold G4.

This pass is **sharpening**: look for **additional primitive sufficient
classes** beyond P2*/P3/P4 that broaden the unconditional coverage of
unrestricted |Ω|≥3 Theorem 2. The constraint: any new class must be a
**primitive condition on (u, A, Ω, Θ, τ)**, NOT calibration on output.

## Existing primitive classes (cited from v9_consolidated.md)

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

Show more

========
ROLE: assistant (id=122441f0-6fd3-4e64-ba53-c8e0ca766e9a)
========
I’ll treat this as a sharpening pass, evaluating P5–P9 against the Ψ≤0 cone-Hall gate for primitiveness, added coverage, and rankable value.

========
ROLE: assistant (id=f11c114b-a9cb-4393-88c0-29988d67f0dd)
========
The first added filter is that merely regularizing w
∗
 or U will not suffice unless it primitively certifies the needed rowwise-minimizer kernel.

========
ROLE: assistant (id=d49c0a56-afb8-4bf5-adc6-61a85cfc96bc)
========
Searcher pass 07 — sharpening audit for P5–P9
Executive verdict

Do not add P5–P9 to v9 as stated. Of the five, only P6 has real sharpening value, but it needs a substantial rewrite into a finite graph / 1-skeleton FBNF theorem with explicit node-balance and cross-arc dominance conditions. Raw “finite union of arcs” is not enough.

The current proof architecture says the true gate is still cone-Hall: for a fixed optimal labeling, robust rationalizability is equivalent to $\Psi(y)\le 0$ for every bounded Borel dual price $y$. The existing sufficient classes work only when they either construct a calibrated primal kernel or reduce the dual check to an LP/scalar balance. The record is very clear on that: P2* works through cone-margin plus bounded jamming, P3 works only after finite-facet cone-Hall verification, and P4 works by constructing an antipodal/radial calibrated kernel rather than by abstract symmetry averaging. 

prover_15_response

 

prover_15_response

 

prover_15_response

The WTA ternary witness remains the litmus goblin. In the no-baseline full-vertex WTA case, the finite cone-Hall certificate gives $\Psi(y)>0$, so any proposed class that includes WTA without adding aligned-baseline thickness, scalarization, or a finite-facet LP pass is false. 

prover_16_response

Ranking
Rank	Candidate	Verdict	Reason
1	P6, patched to Graph-FBNF	Promising, not add as stated	A finite union of affine arcs could extend FBNF if it becomes a finite graph with Borel charting, endpoint-fiber transports, Kirchhoff/node balance, and cross-arc dominance. Raw arc support is too weak.
2	P5, heavily patched	Not ready	Concavification/sandwich geometry may give regularity or dual bounds, but it does not by itself construct a calibrated kernel or imply $\Psi\le0$.
3	P7	Fails as stated	Equivariance alone is not enough. Finite group symmetry can average to the wrong posterior. The valid version is basically P4/radial symmetry with stabilizer structure.
4	P8	Fails and is output-conditioned	Boundary Bayes-support is a support property, not calibration. It does not imply posterior membership in the right Bayes cone.
5	P9	False as a sufficient condition	Generic no-tie conditions help measurability/tie discipline but not vector balance. Positive dual gaps are stable under small perturbations.
P5 — Concavified utility + sandwich condition

Primitive? Maybe, but only if stated directly in terms of $u,A,\Omega,\Theta,\tau$ through the induced indirect value $\Phi(\mu)=\sup_{w\in W}\mu\cdot w$. As written, “sandwiched between two convex envelopes” is under-specified. If the sandwich is chosen after seeing $w^*$, $R(s)$, or $B(m)$, it becomes output-calibration in a silk hat.

Does it imply $\Psi(y)\le0$? No, not as stated. The earlier smooth/strict-convex investigation already found the same failure mode: smoothness/convexity can give the regularity package, but it does not prevent positive dual prices. Smoothness is “the topological half,” not the Hall certificate. 

prover_15_response

The missing ingredient is a transport/coupling domination statement: either a calibrated rowwise-minimizer kernel, bounded-jamming cone-margin, finite-facet dual domination, or a radial/fiberwise construction. Without that, P5 only says the value surface has nice geometry; it says nothing about whether adversarial mass can be routed so that posteriors land in $B(m)$.

Coverage beyond P2/P3/P4?* Potentially broad, but only as a conjectural smooth-full-support theorem. The already stated smooth conjecture would need an “inward-pointing barycentric field” or equivalent differential cone-Hall condition, not just a convex-envelope sandwich. 

prover_14_response

Sharpness / WTA. Raw P5 does not correctly exclude WTA. WTA’s indirect value is piecewise linear/convex; it can be trivially sandwiched, yet no-baseline full-vertex WTA fails the corrected cone-Hall test by explicit positive dual certificate. 

prover_16_response

Decision. Do not add P5. A useful replacement would be:

P5′ Smooth inward-cone transport. $W^P$ is $C^2$ strictly convex, $w^*$ is a $C^1$ Gauss labeling, $R(s)$ admits a smooth rowwise-minimizer disintegration, and its barycentric field is inward-pointing relative to $B(m)$.

But that is a new theorem target, not an already bankable class.

P6 — Coarse signal structure: finite union of arcs

Primitive? Yes, if phrased as a primitive support/geometry condition on $\tau$ plus affine arc charts:

M⊆
e∈E
⋃
	​

ℓ
e
	​

([a
e
	​

,b
e
	​

]),

with a finite graph of arcs, Borel chart/overlap consistency, and conditional laws $\tau_e$.

Does it imply $\Psi(y)\le0$? Not by itself. A finite union of arcs is only a skeleton. It becomes sufficient only if it inherits the FBNF machinery:

projection stays on the same arc, or at graph nodes obeys a deterministic node rule;

rowwise minimization along each arc is endpoint-supported;

local stationarity gives arcwise balance;

node/junction flows satisfy Kirchhoff-style balance;

cross-arc dominance holds, so an in-arc minimizer is also globally rowwise minimizing.

FBNF already needed a strong global dominance condition: cross-fiber messages cannot beat in-fiber endpoints; without that, fiber-local minimization is not a true original-game best response. 

reviewer_08_response

 The FBNF capstone also needed endpoint-fiber support, not literal singleton endpoint messages, because scalar B1 calibration spreads mass over endpoint fibers. 

prover_15_response

Coverage beyond P2/P3/P4?* Yes, if patched. This would cover finite 1-skeleton advice structures: piecewise-affine MLR paths, finite risk-score regimes, decision trees, finite networks of severity arcs, and polyhedral scalarizable faces that are not a single global foliation. It is not just P4; it allows multiple arcs and finite branching. It is not just P3; it uses scalar transport rather than finite-facet LP checks.

Sharpness / WTA. Raw P6 may accidentally include WTA-like triangular skeletons, which would be fatal. The patched Graph-FBNF version must exclude WTA by requiring scalarizable arc structure plus cross-arc dominance. The existing FBNF record correctly excludes WTA because WTA is a genuinely two-dimensional vector-balance obstruction with three vertex labels, not a scalar B1 transport problem. 

prover_11_response

Decision. P6 is the top sharpening candidate, but not as written. Add only after a prover proves:

P6$^{G}$ — finite graph-FBNF. Adviser support lies on a finite Borel affine graph; each edge satisfies endpoint-supported minimization and endpoint-fiber B1 balance; node flows satisfy Kirchhoff balance; cross-edge dominance makes edge minimizers global; endpoint exposure gives Bayes-optimality.

This is the one candidate worth a first prover target.

P7 — Symmetric multi-trust-region

Primitive? Yes, if stated as a finite or compact group acting affinely on $\Delta(\Omega)$, preserving $\tau,u,W,W^P$, and the optimal trust region.

Does it imply $\Psi(y)\le0$? No. Equivariance alone does not calibrate posteriors. The radial pass already warned that arbitrary dual prices $y$ cannot be symmetrized away; the proof must construct a calibrated primal kernel, then $\Psi\le0$ follows by cone-Hall necessity. 

prover_15_response

Finite group symmetry is especially dangerous. It can average posteriors to the group-fixed barycenter instead of the relevant boundary belief. WTA ternary is highly symmetric, but no-baseline full-vertex WTA still fails cone-Hall. 

prover_16_response

Coverage beyond P2/P3/P4?* Not really. The valid version is P4: radial/antipodal symmetry with stabilizers fixing the radial line, orbit-saturated trust region, and scalar radial balance. 

searcher_04_response

Sharpness / WTA. P7 as stated would likely include WTA-type finite symmetric environments, so it fails sharpness. P4 correctly excludes generic WTA unless radial primitives are truly satisfied. 

gatekeeper_response

Decision. Do not add P7. Keep P4 as the symmetry theorem.

P8 — Bayes-cone-saturated boundary

Primitive? Mostly no. It refers to $\partial T$ and to the optimized trust region, so it is already output-facing. It can be made primitive only if one specifies a model class whose optimal trust region is known ex ante to have that boundary property.

Does it imply $\Psi(y)\le0$? No. It is a support condition, not a calibration condition. Saying every boundary point is Bayes-supporting for some action does not say the posterior induced at that boundary message lies in the Bayes cone of the continuation actually used there.

It also does not prevent vector Hall failure. Existing work distinguishes endpoint-only/projected minimization from calibrated posterior construction: FBNF needed endpoint exposure, scalar balance, measurable pasting, and global dominance before Definition 2 followed. 

prover_11_response

Coverage beyond P2/P3/P4?* Minimal. It may describe many smooth frontiers, but it does not solve the messagewise transport problem.

Sharpness / WTA. It fails the WTA test. In WTA, the active vertex labels are Bayes-supporting, but the no-baseline full-vertex instance has $\Psi(y)>0$ and fails by explicit dual certificate. 

prover_16_response

Decision. Do not add P8. At most, use “boundary saturation” as a lemma inside a larger FBNF/radial/polyhedral proof, never as a standalone sufficient class.

P9 — Generic position

Primitive? Yes, if stated as no positive-measure ties, transverse intersections, and no flat Bayes-cone coincidences.

Does it imply $\Psi(y)\le0$? No. Generic position is a tie-discipline / regularity condition. It can make $R(s)$ single-valued a.e., simplify measurable selection, and remove tie-splitting variables. It cannot repair vector-balance failure.

This is already visible in the existing results: finite-facet LP equivalence requires tie discipline for a clean per-cell test, but the LP can still fail; if it fails, the violated facet normal is a dual certificate. 

sanity_chunk3_response

Coverage beyond P2/P3/P4?* Broad but shallow. It is useful housekeeping, not a sufficient theorem.

Sharpness / WTA. Generic perturbations of WTA can remove ties, but a positive dual gap is stable under small perturbations. So P9 does not correctly exclude the WTA obstruction; it just dusts the floor while the dragon keeps the room.

Decision. Do not add P9.

Recommended top addition
Add only a patched P6, not raw P6

The most valuable new primitive class is:

(P6$^{G}$) Graph-FBNF / finite 1-skeleton scalarization

Primitive condition. The support of $\tau$ is carried by a finite Borel affine graph of arcs in $\Delta(\Omega)$, with a full-measure Borel chart or quotient-consistent overlaps. The optimal TRS respects this graph. Along each edge, the payoff frontier satisfies the same affine support-function monotonicity used in FBNF, so the projected adversarial image is endpoint-supported. At graph nodes, incoming and outgoing endpoint-fiber balances satisfy Kirchhoff-type conservation. Cross-edge dominance ensures edgewise minimizers are global rowwise minimizers.

Why it is not empty. It is the natural extension of FBNF from disjoint affine fibers to finite arc complexes. It keeps the successful scalar B1 engine, but allows finite branching and coarse signal skeletons.

Why it is not menu-Hall. It does not assume a calibrated kernel. It assumes geometry that reduces calibration to finitely many scalar transports plus node balance, then constructs the kernel.

Why it is sharp. It excludes WTA unless WTA satisfies scalarizable arc dominance and node balance. The existing WTA obstruction is exactly the kind of two-dimensional vector balance that Graph-FBNF must not accidentally admit.

First prover target for P6$^{G}$

Lemma G-FBNF-1 — finite graph endpoint-fiber pasting.

Input:

finite directed/undirected affine graph $\mathcal G=(V,E)$;

edge charts $\ell_e:[a_e,b_e]\to\Delta(\Omega)$;

edgewise endpoint regions $A_{e,L},A_{e,R}$ and source regions $S_{e,+},S_{e,-}$;

edgewise B1 total-balance equations;

node Kirchhoff conditions equating net endpoint deficits/surpluses at shared vertices;

Borel chart / quotient consistency.

Output:

a global Borel adversarial kernel $\kappa$ supported on graph endpoint fibers;

induced posterior equals the correct clipped endpoint for $q$-a.e. endpoint-fiber message;

interior graph-edge messages remain truthful and Bayes-optimal;

no mass leaks through nodes in a way that changes the posterior.

If this passes, the next lemmas are graph endpoint-only image and localized graph stationarity. If it fails, P6 should be dropped.

Final ranking with action
Candidate	Add to v9 now?	Action
P6 raw	No	Replace with P6$^{G}$ and run one prover pass.
P5 raw	No	Park as smooth inward-cone conjecture, not a class theorem.
P7 raw	No	Subsumed by P4 once stabilizer/radial structure is added.
P8 raw	No	Output-conditioned and insufficient.
P9 raw	No	Useful tie-discipline only, not Hall.
Verdict

(a) Verdict — add to v9 or not: Do not add P5–P9 as stated. Add P6$^{G}$ Graph-FBNF only if the next prover proves the finite-graph endpoint-fiber pasting lemma.

(b) First prover target if yes: G-FBNF-1, the finite graph endpoint-fiber pasting theorem with Kirchhoff node balance.

(c) If no: Do one narrowly scoped P6$^{G}$ prover attempt. If it does not close cleanly, stop sharpening and pivot to polishing the LaTeX export of the v9 consolidated memo.
