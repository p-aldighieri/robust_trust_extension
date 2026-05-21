
========
ROLE: user (id=84cb1da7-b6d5-4c28-97ad-8841f17fd74d)
========
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

Show more

========
ROLE: assistant (id=d61532a6-4cb1-43a1-9e0e-ab6d2fb3c2f1)
========
I’ll run this as a red-team weakening matrix: test each assumption against the calibration gate, separate technical relaxations from real failures, and rank payoff versus effort.

========
ROLE: assistant (id=f3a26096-a0a7-4ae6-b3e7-a1156088b1e4)
========
According to documents from May 21, 2026, here is the targeted weakening audit. The short diagnosis: the best weakenings are tie-splitting in Binary, variable cone-margin in P2*, and P6^G finite-graph FBNF. The dangerous weakenings are exactly the ones that resurrect full vector Hall: dropping FBNF-7, raw countable vertices, approximate radial symmetry for exact RR, and generic/smooth geometry without a transport certificate.

Class-by-class weakening table

| Class | Load-bearing condition | Weakening | Likely weakable? | Economic meaning | Effort | Recommendation |
|---|---|---:|---:|---:|---|
| Binary | R-EE endpoint exposure | singleton Bayes cone → interval Bayes cone | Maybe, but not free | Yes, covers kink / multiple-optimal-action endpoints | Substantial | Pursue only after tie-splitting |
| Binary | R-TD tie discipline | allow atom at tie with measurable split | Yes | Yes, covers discrete / mixed τ | Small prover pass | Pursue |
| Binary | R-IES interior endpoints | allow L=0 or R=1 via one-sided KKT | Partially | Yes, corner trust regions | Small for inequalities, substantial for exact RR | Skip unless needed |
| FBNF | FBNF-7 global fiber dominance | finite-graph / P6^G replacement | Yes, as P6^G, not as deletion | High | Substantial but live | Pursue |
| FBNF | FBNF-1 affine foliation | smooth non-affine curves | Only with straightening or new curved B1 | High for curved MLR | Substantial | Pursue later |
| P2* | uniform cone-margin η>0 | Borel-positive variable margin η(m)>0 | Yes with local domination bound | High | Small/medium | Pursue |
| P2* | threshold D ≥ 2(1−α)/(9α) | sharpen threshold | Model-specific only | Medium | Small audit / LP | Already covered by G4 |
| P3 | finite-vertex polyhedral W | countable vertices | Not generally | Medium | Substantial | Skip except locally finite cases |
| P4 | exact radial / antipodal symmetry | ε-radial symmetry | Approximate yes, exact no without slack | Medium/high | Medium | Pursue only as stability theorem |
| P6^G | finite graph + Kirchhoff | countable graph / automatic Kirchhoff | Maybe | High | Substantial | Pursue after G-FBNF-2/3 |

Binary capstone

The binary theorem is currently clean under R-EE, R-TD, and R-IES. The proof explicitly treats these as meaningful primitives, not menu-Hall: R-EE is unique Bayes action at endpoints, R-TD is no atom at the tie belief, and R-IES is a proper interior interval. It also records that the proof constructs calibration from B1 + endpoint image + endpoint stationarity rather than assuming menu-Hall. 

prover_07_response

R-EE: singleton endpoint exposure → interval Bayes cone

This is not a one-line weakening. In the current proof, endpoint exposure does two jobs. First, it lets endpoint stationarity pin the posterior exactly at L or R. Second, it makes Bayes verification automatic once B1 calibrates the endpoint-fiber posterior to L or R. The capstone’s verification at the left endpoint explicitly uses the fact that the posterior at the L-fiber messages equals L and then invokes R-EE to conclude Bayes-optimality. 

prover_07_response

A plausible weakening is:

B
W
	​

(w
L
	​

)=[L,L
♯
]or more generally an interval I
L
	​

∋L,

with a new interval-cone endpoint balance: instead of forcing the posterior to equal L, the scalar transport may target some p
L
	​

∈I
L
	​

. That would require a modified B1 with p=p
L
	​

, plus a stationarity/KKT argument proving existence of such p
L
	​

. The dragon here is small but real: if p
L
	​

>L, the old aligned-deficit set [0,L] and high-source surplus set may no longer have the right sign geometry.

Economic value: high. It covers endpoint kinks and finite-action tie regions.

Verdict: pursue later; substantial work. The right first lemma is “interval-cone B1 with selectable p in the Bayes interval.” This is not already covered by the binary capstone, but G3 cone-Hall would cover it if the finite/regular cone-Hall inequality is checked.

R-TD: no atom at tie → tie atom with measurable tie-splitting

This is the cleanest Binary weakening. The sanity check already says: if τ has an atom at the endpoint tie belief, the theorem needs a tie-splitting variant rather than the clean scalar statement. It also says B1 itself needs no atomlessness or density; the tie atom is the only local problem. 

sanity_chunk1_response

The patch is finite-dimensional: introduce a split λ∈[0,1] of the tie atom between S
+
	​

 and S
−
	​

. The two endpoint balance equations become affine equations in λ. In the generic one-atom tie case, either there is a feasible split, or failure is witnessed by a scalar imbalance. With multiple endpoint ties, use a measurable split function into the tie simplex.

Economic value: high enough. It admits discrete τ and finite-support examples.

Verdict: pursue. Estimated effort: small prover pass. This should become the next binary refinement.

R-IES: interior endpoints → one-sided KKT at L=0 or R=1

One-sided KKT gives inequalities, not the equalities B1 needs. The FBNF stationarity proof has the same warning: if an endpoint hits the boundary or two-sided perturbations are unavailable, the conclusion is one-sided KKT, not equality. 

prover_10_response

For exact robust rationalizability, the corner case is delicate. If L=0, the left target fiber has no aligned deficit mass below it. Any positive high-source surplus routed to the left endpoint generally pushes the posterior above 0, so exact calibration at 0 fails unless either the surplus is zero, the Bayes cone at the corner is wide enough to absorb it, or there is an atom/other mechanism at the corner.

Economic value: moderate. Corners correspond to full trust on one side or one-sided clipping.

Verdict: skip as a general weakening. Pursue only a corollary: “corner endpoint allowed if the KKT slack branch has zero adversarial surplus or the endpoint Bayes cone contains the induced one-sided posterior.”

FBNF

The final FBNF theorem uses affine foliation, fiber-preserving TRS, endpoint-only fiber image, fiberwise endpoint exposure, tie discipline, derived local endpoint stationarity, and FBNF-7 global fiber dominance. FBNF-7 is explicitly the cross-fiber exclusion making a fiber-local minimizer into a true original-game adversarial best response. 

prover_11_response

 The proof chain is TRS → F2 endpoint image → FBNF-7 global image → F3 balance → F1 pasting → Bayes verification. 

prover_11_response

FBNF-7: global fiber dominance → finite-graph version P6^G

This is the strongest useful weakening, but it is not “remove FBNF-7.” It is “replace a single foliation by a finite graph with a graph-level analogue of FBNF-7 plus Kirchhoff node balance.”

P6^G is already the right formulation: finite affine arcs, global cross-arc dominance, Kirchhoff node balance, arc-wise B1, and measurable pasting. The P6^G proof target says Kirchhoff is the new ingredient, while cross-arc dominance is the FBNF-7 analogue. 

prover_19_response

 The patched Graph-FBNF route was identified as the only P6 sharpening worth adding; raw finite union of arcs is too weak without Borel charting, endpoint-fiber transports, Kirchhoff/node balance, and cross-arc dominance. 

searcher_07_response

Economic value: high. It covers finite decision trees, piecewise-affine MLR paths, severity/risk-score networks, and scalarizable polyhedral edge graphs.

Verdict: pursue. Estimated effort: substantial, but live. Next target should be G-FBNF-2 endpoint-only graph image, then G-FBNF-3 localized graph stationarity ⇒ Kirchhoff balance. P6^G is not already fully covered; only G-FBNF-1 endpoint-fiber pasting is in place.

FBNF-1: affine foliation → non-affine smooth curves

This is meaningful but the current machinery is allergic to curvature. FBNF’s scalar proof uses the affine identity

ℓ
z
	​

(t)−ℓ
z
	​

(r)=(t−r)d
z
	​

.

The FBNF source flags non-affine foliations as open because once this identity fails, F2’s scalar subgradient proof no longer runs. 

prover_11_response

Possible tools:

Straightening: find coordinates in belief space that make the curve affine without changing the payoff-profile linearity. This is rarely free.

Curved B1: replace scalar signed distance with a vector measure along tangents. This quickly becomes a cone-Hall problem again.

Approximate theorem: curvature-bounded ε-version with slack cone-margin.

Economic value: high for curved MLR.

Verdict: pursue only after P6^G. Estimated effort: substantial. For exact RR, non-affine curves are not a small patch.

P2*: cone-margin / bounded-jamming class

P2* is the “non-foliated high-alignment” theorem: bounded rowwise jamming plus uniform cone-margin implies Ψ(y)≤0, hence robust rationalizability via G3. The source calls this a genuine second class beyond FBNF because it uses diffuse aligned mass and cone inradius rather than scalar fibers. 

prover_15_response

Uniform cone-margin η>0 → variable Borel-positive margin η(m)

This is likely weakable with a localized domination inequality. The existing P2* proof uses a uniform margin only to absorb the worst-case posterior displacement:

∥p(m)−m∥≤
α+(1−α)g(m)
(1−α)g(m)
	​

D.

So replace uniform η by a Borel function η(m)>0, and require

α+(1−α)g(m)
(1−α)g(m)
	​

D≤η(m)for τ-a.e. m.

This is strictly weaker than uniform η if adversarial traffic g(m) vanishes or thins near small-margin points. A naked “η(m)>0 a.e.” is not enough, since adversarial mass can concentrate near arbitrarily thin margins.

Economic value: high. It covers models where some messages are less safely interior but the adversary cannot flood them.

Verdict: pursue. Estimated effort: small to medium prover pass. This is one of the best returns-on-proof in the list.

Baseline threshold D≥2(1−α)/(9α) → sharper threshold

First, the normalization of D must be fixed. The proof record warns that stored passes used reciprocal conventions, and final writeup must normalize D consistently. 

prover_15_response

Once normalized, a universal sharpening is unlikely. For WTA, the finite-facet dual certificate is tight for the symmetric full-vertex instance; reducing the threshold would contradict the explicit G1/G4 certificate. The correct improvement is not “sharpen D globally,” but “replace scalar D by the exact finite-facet LP.” P3/G4 already does that.

Economic value: model-specific, not universal.

Verdict: already covered by G4 / finite-facet LP. Do not chase a scalar global sharpening.

P3: finite-vertex polyhedral W

Raw P3 is not enough. The source says polyhedral W plus finite vertices gives computational tractability, not automatic calibration; WTA is the cautionary example. It needs finite cone-Hall verification or the cone-margin/bounded-jamming primitive. 

prover_15_response

Finite vertices → countable vertices

General countable vertices are dangerous. In finite dimension, a compact convex set with countably many exposed points can have accumulation of faces and no finite normal fan. That kills the finite-facet LP reduction and can reintroduce no-escape and support-function discontinuity issues.

Weakable only under extra assumptions:

locally finite normal fan;

uniform cone-margin on active cells;

summable tail control of inactive vertices;

compact-closed graph for rowwise minimizers;

finite truncations with uniform dual slack.

Economic value: moderate. It covers countable-action approximations.

Verdict: skip in the main package. A safe result would be an ε-approximation theorem or a “locally finite with uniform slack” theorem, but exact countable-vertex extension is substantial and likely not worth the next pass.

P4: radial / antipodal symmetry

P4 works constructively: build the radial/antipodal calibrated kernel, verify posterior calibration, then invoke G2c. The source explicitly warns not to prove it by symmetrizing arbitrary dual prices. 

prover_15_response

Exact radial symmetry → ε-radial symmetry

For exact robust rationalizability, ε-radial symmetry is not enough by itself. It yields

dist(P
γ
α
	​

	​

(⋅∣m),B(m))≤Cε

at best, not exact cone membership. Exact RR follows only if there is slack:

Cε≤cone-margin at m

for q-a.e. active messages. Without margin, approximate symmetry can fail at boundary cones.

Economic value: high for empirical models that are “nearly symmetric.”

Verdict: pursue as a stability / approximate-RR theorem, not as an exact weakening. Estimated effort: medium if based on G2c residual bounds, substantial if exact.

P6^G in flight

P6^G is best seen as a weakening of FBNF-1’s single foliation, not a weakening of FBNF-7. It allows finite graph branching while retaining scalar B1 transport along edges. The P6^G theorem already states the required finite graph, edge exposure/tie discipline, global cross-arc dominance, Kirchhoff node balance, and endpoint-fiber pasting. 

prover_19_response

Weakening opportunities:

Kirchhoff primitive → derived from optimality. Likely weakable by graph-localized perturbations, analogous to F3. Effort substantial; worth pursuing.

Finite graph → countable graph. Possible with summability and no-escape, but not before finite graph is closed.

Cross-arc dominance → finite LP cross-arc dominance check. Worth adding as computable verification; not a proof weakening.

Affine arcs → curved arcs. Same curved-MLR issue as FBNF; defer.

Verdict: pursue P6^G, but keep it honest. Do not state raw finite arcs as sufficient.

Ranked top weakenings worth pursuing
1. Binary R-TD tie atom → measurable tie-splitting

Best low-cost gain. It broadens binary to discrete or mixed τ, and the existing sanity check already points to the exact needed patch. Estimated effort: small prover pass. Outcome likely PASS.

2. P2* uniform cone-margin → variable margin with localized bounded-jamming

Best non-foliated extension. Replace global η by pointwise η(m) and require the posterior displacement bound to be pointwise below η(m). Estimated effort: small/medium prover pass. Outcome likely PASS.

3. P6^G finite graph completion

Best new coverage. It extends FBNF from one foliation to finite 1-skeletons. G-FBNF-1 is already in place, but the class still needs endpoint-only graph image and localized graph stationarity ⇒ Kirchhoff. Estimated effort: substantial, but it is the most meaningful new class. The finite-graph theorem explicitly aims at multi-trust-region models, trees of binary signal experiments, and polyhedral W with edge-graph structure. 

prover_19_response

Pursue / skip / already covered
Weakening	Decision
Binary R-EE singleton → interval	Pursue later after tie-splitting; substantial
Binary R-TD atom → tie-splitting	Pursue now
Binary R-IES corners	Skip general theorem; add one-sided corollaries only
FBNF-7 → finite graph P6^G	Pursue, but as graph scalarization plus cross-arc dominance, not deletion of dominance
FBNF-1 affine → smooth non-affine	Pursue later; needs curved B1 or straightening
P2* uniform η → variable η(m)	Pursue now
P2* threshold sharpening	Already covered by G4 finite-facet LP; fix D normalization
P3 finite vertices → countable vertices	Skip except locally finite/uniform-slack variant
P4 exact radial → ε-radial	Pursue only as approximate/stability theorem
P6^G finite graph → countable graph	Skip for now
P6^G Kirchhoff primitive → derived	Pursue after G-FBNF-2

Final recommendation: run the next prover passes in this order: Binary tie-splitting, P2* variable-margin theorem, then G-FBNF-2/G-FBNF-3. The rest are either covered by G4, too close to the old Hall dragon, or better framed as approximation/stability rather than exact Theorem 2.
