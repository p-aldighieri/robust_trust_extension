
========
ROLE: user (id=415fab00-0f8c-441c-9fa7-9ace5a499707)
========
# Reviewer pass 17 — Verify G-FBNF-1 finite-graph pasting

## Role

Fresh-chat reviewer on Prover 19's G-FBNF-1 (prover_19_response.md).
The lemma extends FBNF to a finite-graph primitive class P6^G with
Kirchhoff node balance.

## Specific checks

1. Verify the proof closes under scalar-equality (which the prover
   explicitly used as its reading).
2. Verify Kirchhoff balance is correctly formulated at interior
   graph vertices.
3. Verify the arc-wise L_B1 application + measurable graph pasting.
4. Verify cross-arc dominance (the FBNF-7 analog) is genuinely a
   primitive condition, not output-conditioned.
5. Confirm WTA ternary correctly fails P6^G (vertex menu has no
   arcs).

## Verdict
PASS / PATCH / DISPROVED / HOLD.

End with one-line + next-step (G-FBNF-2/3 or extension to v9.1).

Show more

========
ROLE: assistant (id=bbbc9c30-7e12-47fc-96e0-bb265163adb4)
========
I’ll audit Prover 19’s G-FBNF-1 as a proof checker, focusing on scalar/Kirchhoff formulation, arcwise B1 measurable pasting, primitive cross-arc dominance, and WTA exclusion.

========
ROLE: assistant (id=c98dbce1-63de-44b4-9648-73850d1a5840)
========
Verdict: PATCH_SMALL

G-FBNF-1 is mathematically sound as a finite-graph endpoint-fiber pasting lemma, provided Kirchhoff is read in Prover 19’s precise half-edge transfer-matrix form, not as a vague scalar “net flow equals zero” condition. The only patch is wording/scope: cross-arc dominance is not yet primitive in the strong sense. It is assumed as a graph-class condition involving the chosen optimal T,w
∗
; G-FBNF-2 should either derive it from primitive graph geometry or explicitly advertise it as an optimal-TRS structural assumption.

1. Scalar-equality closure

PASS. Prover 19 correctly uses the scalar-on-each-half-edge reading. Each endpoint fiber A
h
	​

 and source region S
h
	​

 lies on an affine arc, so deviations are scalar multiples of a fixed direction:

p
h
	​

−m=a
h
	​

(m)d
h
	​

,s−p
h
	​

=b
h
	​

(s)d
h
	​

.

The tilted measures η
h
	​

,ν
h
	​

 are defined in those scalar coordinates, and Kirchhoff then transfers scalar source surplus across incident half-edges by a nonnegative matrix Θ
p
	​

. The key condition is not mere scalar mass balance; it is the pair

h
∑
	​

θ
gh
	​

=ν
g
	​

(S
g
	​

),
g
∑
	​

θ
gh
	​

d
g
	​

=η
h
	​

(A
h
	​

)d
h
	​

,

with the zero-demand convention. Prover 19 explicitly notes that this collapses to ordinary scalar B1 balance when H(p) has one active direction. 

prover_19_response

The proof then derives the right endpoint-fiber calibration identity:

(1−α)∫κ
p
	​

(X∣s)(s−p)τ(ds)=α∫
X
	​

(p−m)τ(dm),

for X⊆A
h
	​

. That is the exact vector identity needed to force posterior p on the endpoint fiber. 

prover_19_response

2. Kirchhoff balance at interior graph vertices

PASS with the precise half-edge reading. The prover’s formulation on H(p)={h:p
h
	​

=p} is the right object: it handles both true branching nodes and singleton endpoints. At a singleton endpoint it reduces to B1’s scalar total-balance condition; at a branching node it becomes a finite nonnegative transfer rule converting surplus directions into deficit directions. 

prover_19_response

Small wording patch: do not describe Kirchhoff merely as “sum of aligned-deficit minus misaligned-surplus equals zero.” That wording is too weak. The theorem should state the half-edge matrix conditions (K-row) and (K-col). Otherwise a reader could mistakenly check only scalar total mass and miss direction balance at a branching node.

3. Arc-wise B1 plus measurable graph pasting

PASS. The proof uses B1 in the correct generalized way. For non-branching endpoints it is literal scalar B1. For shared vertices, the matrix Θ
p
	​

 first splits source surplus among endpoint fibers, then normalized 
η
ˉ
	​

h
	​

 supplies the target-fiber distribution. This is a finite “switchboard” version of B1, not a hidden multidimensional Hall theorem. 

prover_19_response

Measurability is also fine under the stated Borel chart / quotient-consistency assumption. Prover 19 requires either injectivity off a finite vertex set with quotient consistency, or a full-measure Borel isomorphism from the coordinate graph to M. This is exactly the patched FBNF lesson: a raw finite union of arcs is not enough because overlapping charts could prescribe different posteriors at the same physical message. 

prover_19_response

The pasted kernel is Borel because the graph is finite, the branch regions and endpoint fibers are Borel in the coordinate chart, and the local kernels are finite sums of fixed probability measures with Borel branch indicators. The pushforward through Φ is well-defined precisely because of the chart/quotient condition. 

prover_19_response

4. Cross-arc dominance

PATCH_SMALL. The proof correctly uses cross-arc dominance to make the constructed kernel adversarial in the original game, not merely edge-local. Prover 19 states the condition as

μ∈T
min
	​

s⋅w
∗
(μ)=
μ∈T
e
	​

min
	​

s⋅w
∗
(μ)

for τ-a.e. s=ℓ
e
	​

(t), and explicitly identifies it as the graph analogue of FBNF-7: local edge minimizers must be true global rowwise minimizers. 

prover_19_response

But as written, this is not “primitive” in the strongest sense. It references the optimized trust region T and payoff labeling w
∗
. It is not output-conditioned in the bad menu-Hall sense, since it does not assume a calibrated posterior kernel; it is a support/global-minimizer condition. Still, the ledger should say:

P6
G
-6 is a structural assumption on the chosen optimal graph-TRS, pending G-FBNF-2 deriving it from primitive single-crossing / support-function geometry.

So the theorem is fine as a sufficiency lemma, but the “primitive class” label needs this caveat.

5. Definition 2 verification

PASS. The posterior calculation is clean. From the endpoint-fiber identity, Prover 19 obtains

n(X)=pq(X)

for Borel X⊆A
h
	​

, and hence P
γ
α
	​

	​

(⋅∣m)=p for q-a.e. m∈A
h
	​

. For interior edge messages, the adversary sends no non-null mass there, so the only on-path mass is aligned truthful and the posterior equals m. Vertex atoms are handled by the same Radon-Nikodym identity after choosing the regular conditional version on the atom. 

prover_19_response

Endpoint exposure then gives Bayes-optimality at endpoint-fiber messages, while face-value TRS gives Bayes-optimality at interior trusted messages. This verifies Definition 2 in the correct q-a.e. infinite-space reading. 

prover_19_response

6. WTA ternary compatibility

PASS. Prover 19 correctly excludes WTA ternary. The WTA witness is a 0-dimensional vertex-menu obstruction, not a scalarizable finite graph of Bayes-supporting arcs. More importantly, its obstruction is genuinely multidimensional: three vertex labels and nontrivial Bayes cones create vector-balance constraints that cannot be reduced to scalar B1 transports. 

prover_19_response

That is exactly the sharpness behavior we want: G-FBNF should not accidentally admit the WTA witness, because the earlier cone-Hall/WTA obstruction is the warning flare for non-scalarizable vector balance.

Bottom line

PATCH_SMALL: the pasting theorem closes under Prover 19’s precise half-edge Kirchhoff reading. Patch the theorem statement to make (K-row)/(K-col) explicit and describe cross-arc dominance as a structural optimal-TRS assumption unless G-FBNF-2 derives it from primitive graph geometry.

Next step: G-FBNF-2, then G-FBNF-3. First prove endpoint-only graph image plus cross-arc dominance from primitive support-function / single-crossing geometry; then derive Kirchhoff balance from localized graph stationarity.
