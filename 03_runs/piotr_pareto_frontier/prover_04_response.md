
========
ROLE: user (id=5ab7771b-b573-485b-8a88-53e773252708)
========
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

Show more

========
ROLE: assistant (id=b78bdf46-7b4f-480b-b25d-492d735ce865)
========
Theorem (Pareto-frontier route, calibration under strict convexity)
Statement

Proposed statement:

Under standing assumptions, strict/smooth convexity of the feasible payoff set W, and a C
1
 optimal trust region T, there exists an optimal TRS σ
∗
 with deterministic Bregman-projection adversarial kernel β
∗
 such that

P
β
∗
	​

(⋅∣m)∈B
W
	​

(w
∗
(m))for q-a.e. m.

This would give robust rationalizability for infinite M and infinite Θ, without menu-Hall or another calibrated transport hypothesis.

Hypotheses

I interpret the hypotheses as:

(H1) Standing assumptions: finite Ω, full-support prior, compact metric A,Θ, bounded u continuous in a, conditional independence of s and θ, Borel measurability.

(H2) Smooth/strictly convex W: every relevant boundary point has a unique supporting normal direction. I note below that “unique supporting normal” is a smoothness condition, while “supporting hyperplane touches at exactly one point” is strict convexity; these are related but not equivalent.

(H3) Smooth optimal trust region: the selected optimal TRS has C
1
 boundary.

Proof attempt, audited step by step
Step 1: TRS structure

This part is valid, with the usual caveat that Theorem 1 gives equivalence to a TRS, not a canonical unique TRS.

The paper’s Theorem 1 says any optimal strategy is equivalent to a TRS with connected trust region. It also defines the Bregman clipping rule: inside T, the agent uses a Bayes-optimal private strategy at m; outside T, the agent acts as if the belief were P(m)∈T, chosen via the Bregman/supporting-hyperplane criterion. 

Robust_trust_Dworczak_Smolin

 The paper explicitly emphasizes that T can be connected but need not be convex, and that only the induced payoff-profile set is convexified in dual coordinates. 

Robust_trust_Dworczak_Smolin

So Step 1 passes.

Step 2: Bregman projection deterministic kernel

This step fails.

The proposed kernel

β
∗
(⋅∣s)=δ
Π
T
	​

(s)
	​


for s∈
/
T, and δ
s
	​

 for s∈T, is not the adversary’s best response in general.

There are two different maps in play, and the proof merges them:

The agent’s clipping map: if the received message is m∈
/
T, the agent behaves as if the posterior were the boundary belief P(m)∈T.

The misaligned adviser’s best-response message map: if the adviser’s true posterior is s, he chooses a report that minimizes the agent’s payoff, equivalently selects a payoff profile minimizing s⋅w over the profiles induced by the trust region.

The paper explicitly says the misaligned adviser with belief μ attempts to minimize μ⋅w over state-contingent payoff profiles induced by the trust region, and that the adviser chooses a boundary point maximizing Bregman distance, not “nearest projection” in the agent’s clipping sense. 

Robust_trust_Dworczak_Smolin

 In the binary case, the paper makes this concrete: a high-belief misaligned adviser induces the low endpoint of the interval, and a low-belief adviser induces the high endpoint. 

Robust_trust_Dworczak_Smolin

 That is the opposite-side map, not the nearest projection map.

The in-T convention β
∗
(⋅∣s)=δ
s
	​

 is also not generally adversarial. If s∈T, truthful reporting gives the agent a Bayes-optimal action for s, which is usually good for the agent, not worst for the agent. The adversary may instead report a boundary belief that induces a worse action.

So Step 2’s claimed “deterministic Bregman projection adversary” is not what Section 3 proves. In a TRE, the adversary’s strategy is a calibrated transport that makes Bayes-rule posteriors coincide with the clipping map on path; it is not simply δ
Π
T
	​

(s)
	​

. The paper says exactly that in a TRE, messages outside the trust region must be reported by both types with probabilities such that the Bayes posterior equals the boundary map P(m). 

Robust_trust_Dworczak_Smolin

Step 3: Conditional posterior at boundary messages

The proposed formula is not rigorous as written. The correct object is a Radon-Nikodym derivative of vector measures.

For a deterministic message map φ(s), where the proposal sets φ(s)=s on T and φ(s)=Π
T
	​

(s) off T, define

q(E)=ατ(E)+(1−α)τ(φ
−1
(E)),

and the state-weighted vector measure

Γ(E)=α∫
E
	​

sτ(ds)+(1−α)∫
φ
−1
(E)
	​

sτ(ds).

Then

P
β
∗
	​

(⋅∣m)=
dq
dΓ
	​

(m)

where this derivative exists q-a.e.

At a smooth boundary point m, one may write a more geometric conditional barycenter only after imposing enough regularity on τ and on the projection fibers to disintegrate over ∂T. If τ is absolutely continuous with respect to Lebesgue measure in the simplex, individual boundary points have zero mass, and the relevant object is the conditional law induced by the projection map, not a pointwise mass ratio.

More importantly, Step 3 misses the dominant failure: exterior messages m∈M∖T are still on-path because the aligned adviser reports truthfully. Definition 2 is about on-path messages, and in the infinite setting the natural on-path measure is the mixture marginal q
β
∗
	​

, not just the adversary’s image measure. 

exposition_v8.1_post_splice

Step 4: Conditional misaligned posterior is on the Bregman normal ray

Even if one grants smoothness, this is not enough as stated.

For a C
2
 indirect payoff U, a C
1
 boundary, and a locally unique Bregman projection m=Π
T
	​

(s), the first-order condition has the form

∇
2
U(m)(s−m)∈N
T
	​

(m)

up to sign convention. Equivalently, locally,

s=m+λ[∇
2
U(m)]
−1
n
T
	​

(m)

for the relevant boundary normal n
T
	​

(m). That is a preconditioned normal ray of the trust-region boundary.

But this is a normal to T in belief space. It is not, without an additional equation, a normal to W at the payoff vector w
∗
(m). The proof needs exactly that identification, and it has not been established.

Also, the paper warns that Bregman distance is not a metric and that in higher dimensions the geometry of T may be complex. 

Robust_trust_Dworczak_Smolin

 Smoothness alone does not give global single-valued projection, convexity of T, or a global straight-ray fiber structure.

Step 5: Direction match

This is the load-bearing step, and it is false.

The claimed statement is:

The Bregman normal direction at m∈∂T equals the supporting hyperplane direction at w
∗
(m)∈W. Therefore the Bregman normal ray lies in B
W
	​

(w
∗
(m)).

There are two separate mistakes.

First, the Bregman normal direction is a normal to the trust-region boundary in belief space. The supporting hyperplane direction at w
∗
(m) is a normal to W in payoff space. The TRS construction does not identify these two normals. The paper’s dual-coordinate convexification says the misaligned adviser’s payoff is linear in induced payoff profiles, so the payoff-profile set can be convexified; it does not say the primal boundary normal of T equals the Bayes normal of W. 

Robust_trust_Dworczak_Smolin

Second, under the user’s own H2, Step 5 becomes impossible except in the trivial zero-length case.

If w=w
∗
(m) is Bayes-optimal at belief m, then

m∈N
W
	​

(w)∩Δ(Ω)=B
W
	​

(w).

If N
W
	​

(w) has a unique direction, then

N
W
	​

(w)=R
+
	​

m

after normalization, and hence

B
W
	​

(w)=N
W
	​

(w)∩Δ(Ω)={m}.

So the Bayes cone is a singleton. A nontrivial ray

m+tν,t>0,

cannot lie in B
W
	​

(w), because B
W
	​

(w) is not an affine ray through the simplex. It is the normalized normal cone. With a unique normal, it contains exactly one posterior.

Thus Step 5’s conclusion

μ
−
(m)∈B
W
	​

(w
∗
(m))

requires

μ
−
(m)=m.

That is not a consequence of strict convexity or smoothness. It is exactly a messagewise balancing/calibration condition, the very condition this route was supposed to avoid.

Step 6: Convex combination in B
W
	​


The abstract convexity statement is true: B
W
	​

(w) is convex because it is a cone intersected with the simplex.

But Step 6 inherits Step 5’s failure. Under H2, B
W
	​

(w
∗
(m))={m}, so the convex-combination argument reduces to the requirement that every component already equals m. A convex combination of m and μ
−
(m) lies in {m} only if μ
−
(m)=m.

So Step 6 does not rescue the proof; it exposes the hidden calibration equation.

Step 7: Interior messages

This step is also false as stated, because it ignores exterior literal messages.

Inside T, if the proposed adversary does not send extra mass to interior messages, then yes: the posterior at an interior message is m, and the TRS action is Bayes-optimal at m.

But the proof says “the adversary doesn’t visit” and therefore calibration is automatic. That is only about the misaligned component. The aligned component always reports truthfully. Therefore every m∈M with positive aligned density/mass is on-path through q, including m∈
/
T.

This gives a decisive failure for any nontrivial proper trust region.

Let E⊆M∖T. Under the proposed projection kernel, no misaligned source reports a literal exterior message, so

q(E)=ατ(E),Γ(E)=α∫
E
	​

sτ(ds).

Thus

P
β
∗
	​

(⋅∣m)=mfor τ-a.e. m∈M∖T.

But the TRS action at such an exterior message m is Bayes-optimal at Π
T
	​

(m), not at m. Under H2, the Bayes cone at w
∗
(m)=w
∗
(Π
T
	​

(m)) is the singleton {Π
T
	​

(m)}, so calibration would require

m=Π
T
	​

(m),

which is impossible outside T.

Therefore, whenever

α>0,τ(M∖T)>0,

the proposed deterministic projection kernel fails robust rationalizability on a q-positive set.

This is not a small seam. It is a trapdoor.

Step 8: Definition 2 conclusion

The conclusion does not follow. Steps 2, 5, 6, and 7 fail. The proposed theorem is therefore not proven.

Verification: does Step 5 actually hold?

No. Step 5 fails decisively.

A clean formal refutation:

Let w=w
∗
(m). Since w is Bayes-optimal at m,

m⋅w≥m⋅z∀z∈W,

so

m∈N
W
	​

(w)∩Δ(Ω)=B
W
	​

(w).

Under the H2 singleton-normal condition, N
W
	​

(w)∩S
N−1
 is a singleton direction. Since one normal direction is represented by m, the only normalized posterior in the cone is m. Hence

B
W
	​

(w)={m}.

Now take any nonzero “outward Bregman normal ray” point 
m
~

=m. Since B
W
	​

(w)={m}, 
m
~
∈
/
B
W
	​

(w). In particular,

m+tν(m)∈
/
B
W
	​

(w)

for every nonzero admissible displacement that remains in the simplex, unless it normalizes back to m.

So the sentence “all such points are in B
W
	​

(w
∗
(m))” reverses the geometry. H2 makes Bayes cones smaller, not larger. It turns calibration into an equality condition, not an automatic inclusion.

The only way Step 5 could be repaired is by imposing an additional balancing condition:

P
β
∗
	​

(⋅∣m)=morP
β
∗
	​

(⋅∣m)=Π
T
	​

(m),

depending on the label at m. But that is essentially menu-Hall / calibrated transport in another costume. The v8 engine identifies this exact issue as the Tier-2 condition: the adversarial kernel must be supported on rowwise minimizers and must induce Bayes-cone posteriors q-a.e. 

exposition_v8.1_post_splice

A concrete counterexample island

One can make the failure completely concrete in the binary-state rich-action case.

Let Ω={0,1}. Take Θ singleton and let the action set be a compact strictly convex smooth body of payoff vectors, for instance a Euclidean disk W⊂R
2
, implemented by u(a,ω)=a
ω
	​

. Then W is smooth and strictly convex, and every boundary point has a unique normal. The induced indirect value U(p)=max
w∈W
	​

p⋅w is smooth and strictly convex on the interior, after choosing a disk not centered in a degenerate way.

Let τ have strictly positive density on [0,1], and let α∈(1/2,1). In the paper’s binary-state model with strictly convex twice differentiable U, the optimal trust region is a unique interval T=[
μ
	​

,
μ
ˉ
	​

], equal to the prior at α=1/2 and expanding continuously/strictly with α, reaching the full interval only at α=1. 

Robust_trust_Dworczak_Smolin

 

Robust_trust_Dworczak_Smolin

 Therefore for α∈(1/2,1), T is a proper nontrivial interval and

τ([0,
μ
	​

)∪(
μ
ˉ
	​

,1])>0.

Under the proposed deterministic projection kernel, exterior messages are sent only by the aligned adviser. Hence at τ-a.e. exterior message m,

P
β
∗
	​

(⋅∣m)=m.

But the TRS action at m∈
/
T is Bayes-optimal at the endpoint Π
T
	​

(m), not at m. Since W is smooth/strictly convex, that action has singleton Bayes cone {Π
T
	​

(m)}. Thus

m∈
/
B
W
	​

(w
∗
(m)).

Calibration fails on a positive-q set.

The paper’s actual binary TRE does not use the proposed deterministic projection. It constructs a nontrivial transport: the misaligned adviser must break indifference across messages so that the Bayes posterior induced at each relevant message equals the boundary belief. The authors explicitly describe this as requiring a careful strategy, not a projection convention. 

Robust_trust_Dworczak_Smolin

Compatibility with v8 sharpness package

The compatibility check is correct, but it does not save the theorem.

The WTA ternary witness has payoff menu W
P
={v
0
	​

,v
1
	​

,v
2
	​

} at the effective vertex level, and the convex hull is a triangle. This is not strictly convex or smooth. Normal cones at vertices are multi-dimensional, and supporting hyperplanes can touch along faces or fail uniqueness. Therefore H2 rules out the v8 WTA witness.

The v8 record also classifies that witness as a menu-engine artefact rather than a primitive counterexample to unrestricted Theorem 2: the halfspace trust region T={μ:μ(0)≤0.4} already contains beliefs inducing all three WTA vertices and is behaviorally equivalent to full trust T=Δ(Ω). 

theorem_2_extension_proof_v8

So yes: H2 excludes the WTA witness. But the current theorem still fails for the independent reasons above. Smooth curved W does not make messagewise calibration automatic.

Open issues
Original-message lift

The lift issue persists. TRS structure does not obviate it.

The aligned component places mass at the literal message m=s. The misaligned component must be routed so that the mixture posterior at each on-path literal message lies in the Bayes cone of the action prescribed at that literal message. That is precisely the calibrated-transport problem. Prior work in this project identified the original-message condition as equivalent to menu-Hall/D2 for general α∈(0,1), not as something killed by smoothness. 

piotr_pareto_frontier_pass3_chr…

Is H2 economically meaningful?

A smooth strictly convex feasible payoff set W is economically meaningful in rich-action environments. For example, a continuum of actions with smoothly varying state-contingent payoffs can generate a curved Pareto frontier.

But the exact H2 wording needs cleanup. “Unique supporting normal at every boundary point” is a smoothness condition. “Every supporting hyperplane touches at exactly one point” is strict convexity. Neither implies the other in full generality. The theorem needs to say whether it assumes smoothness, strict convexity, or both.

Does H3 follow from H2?

No, not as stated. H3 is a free-boundary regularity assumption about the optimizer T, not just a smoothness property of W.

The paper explicitly warns that T need not be convex and that higher-dimensional trust-region geometry can be complex. 

Robust_trust_Dworczak_Smolin

 Smoothness of W may make the indirect utility smoother, but it does not by itself give a C
1
, convex, single-projection trust region.

Verdict and next-step signal

Verdict: theorem fails as stated. H2 + H3 are insufficient. The deterministic Bregman-projection kernel is generally not adversarial, exterior aligned messages break calibration immediately for nontrivial T, and Step 5 is false because smooth/strictly convex W makes B
W
	​

(w) a singleton rather than a normal ray.

Next-step signal: stop pursuing Step 5. A viable positive result must either return to calibrated transport/menu-Hall, or restrict to a special primitive island where the paper already constructs the required balancing kernel, such as binary-state quantile transport or spherical/radial symmetry.
