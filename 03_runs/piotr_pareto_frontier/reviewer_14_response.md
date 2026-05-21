
========
ROLE: user (id=c3fde8d4-18ba-4607-8150-8144194068c4)
========
# Reviewer pass 14 — Verify Prover 15 primitive sufficient classes

## Role

Fresh-chat reviewer on Prover 15 (prover_15_response.md):
**primitive sufficient conditions** on $(u, A, \Omega, \Theta, \tau)$
for the G3 biconditional's RHS ($\Psi(y) \le 0$) to hold.

## What's being verified

Prover 15 evaluated four candidates (P1-P4) and reported:
- **(P1) Smooth strict-convex utility + atomless τ alone**: HOLD —
  gives the regularity package (closed-graph R, continuous h_B) but
  NOT $\Psi(y) \le 0$ (the v8 WTA witness has smooth utility but
  Ψ = 2/9 > 0).
- **(P2) (P1) + sufficient aligned baseline / high-alignment**: PASS
  — Ψ ≤ 0 under explicit baseline mass conditions.
- **(P3) Polyhedral W with cone-margin structure**: PASS — Ψ ≤ 0 with
  the finite-facet cone-margin inequality.
- **(P4) Radial / antipodal τ-symmetry**: PASS — Ψ ≤ 0 by symmetry-
  averaging in spherical models.

## Specific checks

### 1. (P1) HOLD
Verify (P1) gives Reg-1+Reg-2 but does NOT automatically give Ψ ≤ 0.
The v8 WTA witness should be the counterexample: smooth WTA payoffs
+ uniform τ → Ψ = 2/9 > 0.

### 2. (P2) PASS under high-alignment
Verify the "high-alignment" / "sufficient aligned baseline" condition
is GENUINELY primitive (not calibration in disguise). Specifically:
the threshold $D \ge 2(1-\alpha)/(9\alpha)$ was computed for WTA; how
does this generalize across $W$ geometries?

### 3. (P3) PASS under cone-margin
Verify the cone-margin condition is meaningful (not vacuous). For
polyhedral W with finite vertices, the cone margin should be a
non-degeneracy condition on the supporting belief cones.

### 4. (P4) PASS radial
Verify the radial / antipodal symmetry argument. Spherical models
(paper Appendix A.10) should satisfy this automatically.

### 5. Coverage
For each (P2-P4), state the class of models that satisfies it.
Confirm the union (P2 ∪ P3 ∪ P4) ∪ FBNF ∪ Binary covers a substantial
slice of substantive applications.

### 6. Cross-cutting

- Are the primitive conditions ALL conditions on (u, A, Ω, Θ, τ),
  not on the optimization output?
- Are they strictly weaker than menu-Hall?
- Compatibility with v8 sharpness: WTA without baseline fails (P2)
  by the threshold computation. WTA with sufficient baseline reopens.

## Verdict

For each (P*) separately: PASS / PATCH / FAIL.

End with one-line + next-step.

## Constraints

- Banned tools list applies.
- (P1) HOLD is the expected outcome (smoothness alone doesn't give
  calibration).
- Be specific about which (P*) is the cleanest publishable primitive.

Show more

========
ROLE: assistant (id=c2040bf2-ae72-49e2-9184-10ee07edb536)
========
I’ll audit Prover 15 against the G3/G2c cone-Hall record, v8 WTA sharpness, and binary/spherical sources, separating regularity from true Ψ≤0 calibration. I’ll then judge whether each condition is primitive versus output-calibrated and give PASS/PATCH/FAIL with publishability guidance.

========
ROLE: assistant (id=d9d44950-f1e1-4a43-ba7c-0cf865bee910)
========
According to a document from 2026-05-21, Reviewer verdict: Prover 15 is directionally right, but P2 and P3 need wording/formula patches before they can be published as “primitive sufficient classes.” The cleanest publishable primitive is still P2*, the regular bounded-jamming cone-margin/high-alignment theorem, not raw smoothness and not raw polyhedrality.

Verdict table
Candidate	Verdict	Reason
P1 smooth strict-convex utility + atomless τ	HOLD, expected	Gives Reg-1/Reg-2 under uniqueness/continuity, but not Ψ≤0.
P2 high-alignment / sufficient aligned baseline	PATCH_SMALL → PASS	Correct idea, but Prover 15’s displayed displacement ratio is inverted and the “primitive” wording must be tightened.
P3 polyhedral W + cone-margin / finite facets	PATCH_SMALL → PASS	Meaningful and non-vacuous once finite-facet cone-Hall or cone-margin/bounded-jamming is added. Raw polyhedral W alone fails.
P4 radial / antipodal symmetry	PASS	Works constructively by building the calibrated antipodal/radial kernel, then invoking G2c necessity.
1. P1: HOLD

Prover 15 is right to separate regularity from calibration. A strengthened smooth/unique-selection P1 gives the G2c regularity package: R closed, compact sections, and continuous m↦h
B(m)
	​

(a). Prover 15 explicitly says the continuous selector makes GrR closed and gives support-function continuity, but also says smoothness “does not create the calibrated kernel.” 

prover_15_response

The WTA sharpness check supports the HOLD conclusion. The stored finite cone-Hall computation gives a positive dual certificate in the no-baseline full-vertex WTA case, so cone-Hall fails; in the prompt normalization this is the advertised Ψ=2/9>0, while another normalization in the stored G1 pass reports the same sign with Ψ=9/2>0. The sign is the invariant part. 

prover_12_response

Minor caveat: literal “strict concavity/unique Bayes action” is stronger than the raw WTA finite-action model. So the clean statement is: smooth/regular geometry alone does not imply Ψ≤0. The WTA witness, or a smooth approximation preserving the cone-Hall obstruction, is the right warning flare. No contradiction with v8 sharpness.

2. P2: high-alignment / sufficient aligned baseline

The substantive idea passes: enough aligned baseline mass inside the right Bayes cones can force posterior calibration. But Prover 15 needs two patches.

First, the posterior displacement formula should be

p(m)−m=
α+(1−α)g(m)
(1−α)g(m)
	​

(b(m)−m),

not the reciprocal. Hence the useful high-alignment margin condition is

α+(1−α)C
(1−α)C
	​

diam(Δ(Ω))≤η.

This becomes easier as α rises, which is exactly the economics. Prover 15’s displayed ratio is reversed in the snippet, although the intended bounded-jamming/cone-margin mechanism is clear. 

prover_15_response

Second, “primitive” needs tightening. The theorem is not primitive if stated as “there exists κ
0
	​

 supported on R(s)” without tying R,B,C,η to primitive geometry. It is not menu-Hall in disguise, because it does not require the posterior to land in B(m); it only requires a diffuse row-minimizer traffic bound plus cone inradius. But R and B are induced by the optimal labeling, so the publishable primitive version should state model-side conditions guaranteeing bounded jamming and cone margin, for example density bounds, full-dimensional Bayes-cone interiors, and regular row-minimizer spreading. Prover 15’s version says the condition uses (τ,α,R,B) induced from primitives and does not require foliation; that is a sufficient engine, but not yet a fully primitive one. 

prover_15_response

The WTA threshold D≥2(1−α)/(9α) does not generalize as a universal number. It generalizes as either:

αA(y)+(1−α)D
mis
	​

(y)≤0for every normalized dual price y,

or, in finite-facet models, as a finite LP/conic threshold over facet-normal prices. Prover 14 already framed this exact dual-threshold form, with finite-facet settings reducing the supremum to an LP or conic program. 

prover_14_response

So: P2 is PASS after the ratio patch and after rewriting “primitive” as a bounded-jamming + cone-margin class theorem.

3. P3: polyhedral W with cone-margin structure

Raw polyhedral W does not pass. Prover 15 correctly says polyhedrality gives computational structure, not automatic calibration; WTA is the cautionary example because it has a finite vertex menu but still has a positive dual certificate without enough aligned baseline. 

prover_15_response

The useful P3 is the patched finite-facet theorem:

W polytope,C
∗
={v
1
	​

,…,v
k
	​

},B
j
	​

 closed polyhedral cells with finitely many facet normals,

plus either a finite-message/finite-quotient lift or the G2c compact-closed/continuous regularity package, and then the cone-Hall inequality checked only on the finitely generated facet-normal price set. Prover 15 states exactly this as the working polyhedral theorem. 

prover_15_response

This condition is meaningful, not vacuous. It is a non-degeneracy condition on the supporting belief cones: the active Bayes cones must have usable polyhedral interiors or finite facet normals, so that aligned truthful mass can be compared against adversarial row-minimizer inflow. But do not call the finite-facet cone-Hall test “strictly weaker than menu-Hall” in a logical sense. In finite polyhedral form, it is a dual certificate equivalent to feasibility. It is better described as finite, checkable, and primitive-adjacent, not weaker.

4. P4: radial / antipodal symmetry

P4 passes. The paper’s spherical example already has the skeleton: U(μ)=V(∥μ−b∥), adviser beliefs are symmetrically distributed over a ball, and there exists a robustly rationalizable solution with a ball trust region. 

Robust_trust_Dworczak_Smolin

Prover 15 also makes the key correction: do not argue that arbitrary dual prices y become symmetric. The dual inequality must hold for every bounded Borel y. The right proof is primal: construct the radial/antipodal adversarial kernel, verify boundary posterior calibration, then invoke G2c necessity to get Ψ(y)≤0 for all y. 

prover_15_response

This automatically covers spherical models in Appendix A.10 style. It is clean, but narrower and basically FBNF-adjacent because it scalarizes the vector balance by symmetry.

Cross-cutting checks

Are all conditions primitive?
P1 and P4 can be stated directly on (u,A,Ω,Θ,τ). P2 and P3, as Prover 15 states them, still mention w
∗
,R,B, hence optimization-output objects. That is acceptable for a cone-Hall corollary, but not for a strict “primitive-only” theorem. Patch: define model-side hypotheses that guarantee the induced R,B have bounded-jamming, cone-margin, and finite-facet properties.

Are they strictly weaker than menu-Hall?
Not literally. A sufficient condition that implies menu-Hall is usually stronger as a hypothesis. The correct claim is: P2/P3/P4 do not assume menu-Hall or posterior calibration; they produce it from margin, density, finite-facet, or symmetry structure. That is the publishable distinction.

Compatibility with v8 sharpness.
Yes. WTA without aligned baseline fails the cone-Hall inequality by a positive dual certificate. Adding sufficiently strong aligned baseline in the right Bayes-cone regions can reopen it, and the threshold is geometry-specific. Prover 15 correctly warns that the WTA threshold is a normalized finite-cone-Hall threshold, not a universal scalar constant. 

prover_15_response

Coverage.
The union is substantial: Binary covers one-dimensional state uncertainty; FBNF covers fibered/radial/MLR-like scalarizable geometries; P4 covers spherical symmetry; P3 covers finite-action/polyhedral normal-fan applications once finite-facet conditions hold; P2 covers non-foliated high-alignment/diffuse-baseline geometries. It still does not cover unrestricted ∣Ω∣≥3 without checking Ψ≤0.

Final verdicts

P1: HOLD. Correct: Reg yes, calibration no.

P2: PATCH_SMALL → PASS. Fix the posterior-displacement ratio and make “primitive” model-side rather than R,B-side.

P3: PATCH_SMALL → PASS. Raw polyhedrality fails; finite-facet cone-Hall or cone-margin/bounded-jamming makes it publishable.

P4: PASS. Radial/antipodal symmetry works by primal construction, not dual symmetrization.

Cleanest publishable primitive: P2*, the regular bounded-jamming cone-margin theorem. Next step: formalize the finite-facet P3 version and compute explicit LP thresholds for finite-action multi-state models.
