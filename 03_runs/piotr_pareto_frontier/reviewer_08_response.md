
========
ROLE: user (id=95c2beb4-7043-48cf-be12-7fe965a4b7a4)
========
# Reviewer pass 08 — Verify F2 (endpoint-only fiber image)

## Role

Fresh-chat reviewer on Prover 09's F2 from prover_09_response.md
(durable source). Verdict from Prover 09:
**PASS for F2-B in endpoint-supported form; PATCH_SMALL if "argmin
set contains only endpoints" wording is required (needs strict P).**

## What's being verified

The endpoint-only fiber image theorem: under FBNF-1+2 plus a primitive
condition P (likely concavity-on-fiber P2 or supporting-line domination
P3), for τ_z-a.e. t and s = ℓ_z(t), the minimum of μ ↦ s·w*(μ) over
T_z = ℓ_z([L(z), R(z)]) is supported on the two fiber endpoints
{ℓ_z(L(z)), ℓ_z(R(z))}.

Adjudicate:
- Is the chosen primitive P (the prover picked one) economically
  meaningful? Does it cover spherical models, MLR families, fan-
  induced normal cones cleanly?
- Is the supporting-line / convexity argument rigorous?
- Does the "endpoint-supported" reading suffice for the downstream
  capstone, or do we strictly need "argmin contains only endpoints"?
- The "cross-fiber exclusion" condition flagged in Prover 09's tail —
  is it benign or does it sneak in calibration as a primitive?

## Verdict format
- PASS / PATCH_SMALL / PATCH_BIG / DISPROVED / HOLD.
- One-line + next-step signal.

## Constraints
- Banned tools list applies.
- Binary capstone (paper §4.2 / v9 §8) is the analog; check consistency.

Show more

========
ROLE: assistant (id=f0dcc2bc-b715-41de-a90b-469625d966b0)
========
PASS for F2-B in endpoint-supported, fiber-local form.
Next step: fire F3, but before F4 add an explicit global fiber-dominance / cross-fiber exclusion clause; do not let “fiberwise minimizer” silently masquerade as a full original-game adversarial best response.

Prover 09’s proof is basically the right little gear. The chosen P
⋆
 is not P2 concavity, and that is good. The real primitive is: affine fibers ℓ
z
	​

(t)=p
z
	​

+td
z
	​

, Bayes-optimal continuation along the fiber, and a fiber-restricted row problem over T
z
	​

. Prover 09 correctly notes this is not a Hall or calibration condition, but a one-dimensional affine support-function geometry condition. It is mathematically meaningful because it turns the high-dimensional problem into the same scalar subgradient picture that made binary work. 

prover_09_response

The supporting-line argument is rigorous. On a fixed fiber, V(r)=U(ℓ(r)) is convex because U(μ)=max
w∈W
	​

μ⋅w is a support function and ℓ is affine. If w
r
	​

 is Bayes-optimal at ℓ(r), then g
r
	​

=d⋅w
r
	​

∈∂V(r). The row payoff satisfies

Φ
t
	​

(r)=ℓ(t)⋅w
r
	​

=V(r)+(t−r)g
r
	​

.

Monotonicity of subgradients then gives endpoint domination: compare to L when t≥r, and to R when t≤r. Prover 09’s inequalities establish

r∈[L(z),R(z)]
min
	​

ℓ
z
	​

(t)⋅w
∗
(ℓ
z
	​

(r))=min{ℓ
z
	​

(t)⋅w
∗
(ℓ
z
	​

(L(z))),ℓ
z
	​

(t)⋅w
∗
(ℓ
z
	​

(R(z)))}.

That is the correct nonsmooth analogue of the binary endpoint argument. 

prover_09_response

 

prover_09_response

The endpoint-supported reading is enough for the downstream F1/F4 machinery. F1 was already patched away from literal singleton endpoint messages toward endpoint-fiber support and “projected payoff image endpoint-only,” because scalar B1 calibration needs mass spread over endpoint fibers rather than only at ℓ
z
	​

(L) and ℓ
z
	​

(R). 

prover_08_response

 So F2 only needs an endpoint-supported selector, not the stronger claim that the whole argmin set contains only endpoints. If the prose insists on the stronger set-inclusion wording, add P
strict
⋆
	​

, namely strict convexity of V
z
	​

=U∘ℓ
z
	​

 on [L(z),R(z)], exactly as Prover 09 says. 

prover_09_response

On coverage: spherical/radial models are covered cleanly when fibers are affine diameters through the center; Prover 09’s reading matches the paper’s antipodal/spherical construction. Affine MLR or single-crossing families are covered only when the posterior path is an affine segment, or when the model is re-expressed in affine belief-fiber coordinates. General curved MLR is not covered yet. Fan-induced normal cones are not cleanly covered by F2 alone; they need a scalarizable-face or one-dimensional-fan decomposition, otherwise the WTA-style vector-balance obstruction can reappear. Searcher 04 had already flagged that raw finite normal fans/polyhedral menus need scalarizable faces, not just finite vertices. 

searcher_04_response

 

searcher_04_response

The cross-fiber exclusion issue is not benign, but it also does not sneak in calibration. It is a support/global optimality restriction, not a Bayes-posterior condition. F2 proves minimization over T
z
	​

, not over the full T=⋃
z
	​

T
z
	​

; Prover 09 explicitly flags this. 

prover_09_response

 For the original Robust Trust adversary, who can choose any message, F4 must include:

μ∈T
min
	​

s⋅w
∗
(μ)=
μ∈T
z
	​

min
	​

s⋅w
∗
(μ)for τ-a.e. s=ℓ
z
	​

(t),

or an equivalent primitive “global fiber dominance” condition. Without it, F2 is only a local normal-fan lemma, not an adversarial best-response theorem. In binary this issue was invisible because there is only one fiber; in ∣Ω∣≥3, it is a real extra dragon with a tiny monocle.
