
========
ROLE: user (id=2565ef98-feff-4ea9-b745-a9311aaf6868)
========
# Prover pass 15 — Primitive sufficient conditions for $\Psi(y) \le 0$ and the regularity package

## Role

You are the Prover. G3 (Robust Trust Theorem 2 biconditional) is in
flight to fresh-chat verification (Reviewer 13). The biconditional
says: Theorem 2 holds ⟺ Ψ(y) ≤ 0 for all bounded Borel y, under
regularity package (Reg-1) + (Reg-2).

Your job: **identify primitive sufficient conditions** on
$(u, A, \Omega, \Theta, \tau)$ that imply BOTH:
(i) The regularity package (Reg-1 closed-graph R, Reg-2 continuous h_B).
(ii) The dual inequality Ψ(y) ≤ 0 for all bounded Borel y.

If we can identify a primitive sufficient class strictly larger than
FBNF (which we already have for foliated cases), this gives a SECOND
class theorem for unrestricted |Ω|≥3 that doesn't require foliation.

## Candidate primitive conditions

### (P1) Smooth strict-convex utility + atomless τ
- $u(a, \omega, \theta)$ is $C^1$ and strictly concave in $a$ (so
  Bayes-optimal action is unique for each belief).
- $A$ is finite or convex compact.
- $\tau$ is atomless with full support on a closed subset $M \subseteq \Delta(\Omega)$.

Implications:
- $w^*: \Delta(\Omega) \to W^P$ is continuous (smooth Bayes selection).
- $W^P$ is a $C^1$ manifold.
- The Bayes cone $B_W(w^*(m))$ is single-valued continuous in m.
- Closed-graph of R(s): follows from continuity of $(s, m) \mapsto s\cdot w^*(m)$
  + closed argmin theorem.
- Continuity of $h_{B(m)}(y)$: follows from continuity of $w^*$ and
  smoothness of $W^P$.

So (P1) gives the regularity package. Does it give $\Psi(y) \le 0$?
**This is the substantive question.** Smooth W^P does NOT obviously
imply Ψ ≤ 0. Counterexample: the v8 WTA witness has smooth utility
(WTA payoffs are linear in a) but Ψ = 2/9 > 0. So (P1) alone is
insufficient for (ii).

### (P2) (P1) + sufficient aligned baseline mass

Add: $\tau$ has sufficiently concentrated mass on Bayes cone interiors.
Concretely: for every dual price $y$, the aligned-baseline contribution
$\alpha\int[y\cdot m - h_{B(m)}(y)]\tau(dm)$ dominates the misaligned
contribution.

In WTA, the threshold from Reviewer 11 was $D \ge 2(1-\alpha)/(9\alpha)$.
Generalize: state a primitive condition on $\tau$ such that the
analogous threshold holds for all dual prices.

### (P3) Polyhedral W with smooth Gauss map at vertices

- $W$ is polyhedral with finitely many vertices.
- At each vertex $v_j$, the supporting belief cone $B_W(v_j)$ is a
  facet (codim-1 face) of $\Delta(\Omega)$.

This is FBNF-7-adjacent but for polyhedral W. Verify whether (P3) +
sufficient aligned baseline implies $\Psi(y) \le 0$.

### (P4) Radial / antipodal τ-symmetry

For spherical models (paper Appendix A.10) with rotational invariance:
$\tau$ is rotation-invariant, $u$ is rotation-equivariant. Symmetry
forces the dual price y to be rotation-equivariant, which collapses
the integral to a single radial scalar equation.

Verify that the radial dual equation gives $\Psi(y) \le 0$ for all y.

## What I want

For each (P1)-(P4):

1. Check whether (Reg-1)+(Reg-2) follow.
2. Check whether Ψ(y) ≤ 0 follows for all y (or only for specific y).
3. If (i) but not (ii): identify the GAP — under what additional
   primitive does Ψ ≤ 0 follow?

Then assemble a clean theorem of the form:

> Under the standing hypotheses + (P*), where (P*) is a chosen
> primitive sufficient condition, Robust Trust Theorem 2 holds
> unconditionally for |Ω|≥3, arbitrary measurable Θ, infinite M.

Coverage: should cover at least one substantive class of multi-state
models beyond FBNF.

## Output Contract

- Inline markdown.
- Be rigorous about which (P*) gives (i) only vs (i)+(ii).
- The headline target: a clean primitive sufficient condition
  theorem for the unrestricted |Ω|≥3 case via cone-Hall.
- End with verdict + next-step. If multiple (P*) work, recommend
  the cleanest one for the publication.

## Constraints

- Banned tools list applies.
- v9 T1, FBNF capstone, binary capstone, G1, G2c, G3 may be cited.
- Per user: relentless. Even partial primitive conditions are
  progress.

Show more

========
ROLE: assistant (id=c8452b29-902d-4fa0-b19a-f550d000edf4)
========
I’ll treat this as a theorem-design pass: fix the G3/G2c objects, separate regularity from Ψ-negativity, then test P1–P4 without assuming smoothness supplies calibrated mass.

========
ROLE: assistant (id=d407f6fb-9525-4d96-ad70-c88a9e4a3a76)
========
The likely publishable route is finite-facet cone-Hall or quantified domination: high aligned mass, finite-facet LP, and radial/FBNF symmetry are the viable subclasses.

========
ROLE: assistant (id=642b908a-9abf-434f-9f4b-7f3597ba0b94)
========
Prover pass 15 — Primitive sufficient conditions for Reg + Ψ≤0
Executive verdict

(P1) Smooth strict-convex utility + atomless τ: gives the regularity package under standard no-tie / unique-selection strengthening, but does not imply Ψ(y)≤0. Smoothness is a silk glove, not a Hall certificate.

(P2) “Enough aligned baseline mass”: works only after being made precise. The clean primitive version is a bounded-jamming + uniform cone-margin condition. This gives Reg + Ψ≤0 and is a genuine non-foliated ∣Ω∣≥3 sufficient class.

(P3) Polyhedral W: raw finite-vertex/polyhedral structure is not enough. It needs either finite cone-Hall verification or the cone-margin/bounded-jamming primitive. WTA ternary is the warning lantern.

(P4) Radial / antipodal symmetry: works for Ψ≤0, but the right proof is constructive primal calibration, not “y must be symmetric.” This is clean but essentially radial/FBNF-adjacent.

The cleanest publishable second-class theorem beyond FBNF is:

Regular bounded-jamming cone-margin theorem.
Under the regularity package, truthful self-compatibility with a uniform Bayes-cone margin, and existence of a rowwise-minimizer kernel whose induced target marginal is bounded relative to τ, sufficiently high α implies Ψ(y)≤0 for all bounded Borel y. Hence Theorem 2 holds by cone-Hall.

This class does not require foliation; it allows high-dimensional row-minimizer geometry as long as adversarial traffic can be spread diffusely enough relative to aligned truthful mass.

Baseline: what G3/G2c require

The current cone-Hall biconditional says, for a fixed G2c-admissible optimal labeling w
∗
, robust rationalizability is equivalent to

Ψ(y)≤0∀ bounded Borel y:M→R
∣Ω∣
.

The retrieved G3 statement identifies exactly this equivalence for the fixed labeling w
∗
, with

B(m)=B
W
	​

(w
∗
(m)),R(s)={m:s⋅w
∗
(m)=
z∈C
∗
min
	​

s⋅z},

and emphasizes that the correct infinite-space reading is q
β
∗
	​

-a.e., not literal-all. 

prover_14_response

The G2c regularity package behind that biconditional is exactly the useful “no-escape” package:

GrR closed with compact nonempty sections,m↦h
B(m)
	​

(a) continuous for every a∈R
N
.

The G2c pass explicitly says bare standard-Borel cone-Hall is false, while compact-closed/continuous G2c is true. 

prover_13_response

 So our “primitive” conditions must imply both this topology and the dual inequality. Otherwise we are trying to bottle fog.

(P1) Smooth strict-convex utility + atomless τ
Reg-1 / Reg-2

A strengthened P1 does give the regularity package.

A precise version:

(P1-Reg).

M=suppτ⊆Δ(Ω) is compact.

A is compact convex.

u(a,ω,θ) is C
1
 and strictly concave in a, uniformly enough that the Bayes-optimal private strategy is unique.

The induced payoff-profile selector

w
∗
(m)∈W
P

is continuous.

The Bayes cone correspondence

B(m)=B
W
	​

(w
∗
(m))

has continuous support function m↦h
B(m)
	​

(a) for every a.

R(s)=argmin
m∈M
	​

s⋅w
∗
(m) is taken over compact M.

Then GrR is closed: if s
n
	​

→s, m
n
	​

→m, and m
n
	​

∈R(s
n
	​

), continuity of (s,m)↦s⋅w
∗
(m) gives m∈R(s). Reg-2 follows from the assumed support-function continuity, and in smooth Gauss-map cases it follows from continuity of the normal field.

So P1 gives (i), after no-tie/continuous-selection strengthening.

Does P1 imply Ψ≤0?

No.

Smoothness controls topology. It does not create the calibrated kernel. The G3/G2c result says Ψ≤0 is equivalent to existence of a kernel supported on rowwise minimizers whose induced posterior lies in the Bayes cones. That is a transport/calibration condition, not a differentiability condition. 

prover_14_response

The WTA family is the conceptual warning: finite/polyhedral or smoothened payoff geometry can still generate a positive dual price. In the WTA full-vertex test, the finite cone-Hall computation produces Ψ(y)>0, hence cone-Hall fails. 

prover_12_response

Gap

P1 lacks any condition tying the misaligned inflow barycenter at message m to B(m). To make P1 useful for Ψ≤0, add either:

calibrating kernel existence,

or a primitive sufficient substitute such as cone-margin + bounded jamming, radial symmetry, or finite cone-Hall dominance.

(P2) P1 + sufficient aligned baseline mass

The vague P2 statement,

aligned-baseline contribution dominates misaligned contribution for every y,

is just Ψ(y)≤0 in disguise. To make it primitive, we need a condition on τ,R,B,α that constructs a feasible calibrated kernel.

Here is the clean version.

Theorem A — Regular bounded-jamming cone-margin theorem

Assume the standing hypotheses and the G2c regularity package:

M⊆Δ(Ω) compact.

R:S=M⇉M has nonempty compact values and closed graph.

B(m)⊆Δ(Ω) is nonempty closed convex, and m↦h
B(m)
	​

(a) is continuous for every a.

Assume additionally:

(CM) Truthful cone margin

There is η>0 and a norm ∥⋅∥ on R
∣Ω∣
 such that

dist(m,Δ(Ω)∖B(m))≥ηfor τ-a.e. m.

So truthful aligned messages are not merely Bayes-compatible; they sit uniformly inside their Bayes cones. This is the “baseline moat.”

(BJ) Bounded rowwise jamming

There exists a Borel kernel κ
0
	​

:M→Δ(M) such that

κ
0
	​

(R(s)∣s)=1τ-a.e.

Let

ρ(E)=∫
M
	​

κ
0
	​

(E∣s)τ(ds)

be its target marginal. Assume

ρ≪τ,
dτ
dρ
	​

(m)≤Cτ-a.e.

for some finite C. This says the adversarial rowwise-minimizer traffic can be spread without concentrating too hard on small aligned-baseline sets.

Let D=diam(Δ(Ω)) in the chosen norm. Assume

α+(1−α)C
(1−α)C
	​

D≤η.
(BJ-CM)

Then Ψ(y)≤0 for every bounded Borel y. Consequently, by G3, the induced optimal strategy is robustly rationalizable.

Proof

Use κ
0
	​

 as the candidate adversarial kernel. Since κ
0
	​

 is supported on R(s), it is rowwise adversarial.

Let

ρ(dm)=g(m)τ(dm),0≤g(m)≤C.

Let b(m)∈Δ(Ω) be the conditional source barycenter of sources routed to m, so that the adversarial numerator density is g(m)b(m)τ(dm). The mixture message marginal and numerator are

q(dm)=(α+(1−α)g(m))τ(dm),
n(dm)=(αm+(1−α)g(m)b(m))τ(dm).

Thus the posterior at m is

p(m)=
α+(1−α)g(m)
αm+(1−α)g(m)b(m)
	​

.

Therefore

p(m)−m=
α+(1−α)g(m)
(1−α)g(m)
	​

(b(m)−m).

Since b(m),m∈Δ(Ω),

∥b(m)−m∥≤D.

Using g(m)≤C,

∥p(m)−m∥≤
α+(1−α)C
(1−α)C
	​

D≤η.

By (CM), p(m)∈B(m) for q-a.e. m. Hence κ
0
	​

 is a feasible cone-Hall primal kernel. By G2c necessity, Ψ(y)≤0 for all bounded Borel y, and by the G3 biconditional Theorem 2 holds for this labeling. 

prover_13_response

Why this is primitive and non-foliated

This condition uses only:

(τ,α,R,B)

as induced from the primitives. It does not require a one-dimensional foliation, radial fibers, or binary reduction. The rowwise-minimizer graph R may be high-dimensional. The only transport assumption is bounded spreading of rowwise-minimizer mass relative to τ.

This is a genuine second class beyond FBNF: FBNF scalarizes calibration fiber-by-fiber; Theorem A instead uses diffuse aligned baseline mass plus cone inradius. The little machine has a different engine.

Relation to the WTA threshold

In WTA ternary, Bayes cones at vertices are not uniformly interior around arbitrary continuum messages unless messages are placed inside the correct plurality regions. The stored finite cone-Hall computation gives an explicit positive dual certificate in the no-baseline full-vertex case, and with positive aligned baseline the same certificate becomes a threshold test. 

prover_12_response

So P2 is not “add atomless mass anywhere.” It must be aligned mass inside the right Bayes cones, spread thickly enough to absorb adversarial inflow. The prompt’s WTA threshold D≥2(1−α)/(9α) is exactly this kind of normalized baseline-thickness requirement, though the normalization of D should be fixed in the final writeup because the stored pass uses a different reciprocal convention. 

prover_14_response

(P3) Polyhedral W with smooth Gauss map at vertices
Raw P3 is not enough

Polyhedral W plus finite vertices gives computational tractability, not automatic calibration.

The prior search pass already warned that raw polyhedral finite-vertex structure is insufficient: v9 finite-menu Pareto-Hall gives payoff-label calibration, but the lift back to original messages can still fail. It also notes that the WTA ternary witness has polyhedral W and a full vertex menu, so raw finite-vertex P3 must either handle WTA by transport or exclude it by an added condition. 

searcher_04_response

Reg-1 / Reg-2

Polyhedral W can give Reg-1 if the induced label map is finite-valued with closed active cells, because R(s) is then a finite argmin correspondence with closed graph.

Reg-2 is more delicate. If B(m) jumps across cell boundaries, then m↦h
B(m)
	​

(a) may fail continuity. To get Reg-2, one needs one of:

finite message quotient, so h
B
	​

 is just finitely many constants;

continuous cone interpolation at boundaries;

a strengthened fan regularity condition ensuring support-function continuity;

a G1 finite formulation instead of the G2c compact-continuous formulation.

So P3 as stated does not automatically imply the regularity package.

Does P3 imply Ψ≤0?

No. WTA gives the sharp cautionary case: with vertex labels and no sufficient aligned baseline, a dual price has Ψ(y)>0. The finite G1 pass gives this explicitly. 

prover_12_response

Working polyhedral theorem

A publishable P3 version is:

Theorem B — Finite-facet high-alignment theorem

Assume:

W is a polytope.

The optimal menu C
∗
={v
1
	​

,…,v
k
	​

} is finite.

Each Bayes cone B
j
	​

=B
W
	​

(v
j
	​

)∩Δ(Ω) is a closed polyhedral cell with finitely many facet normals.

The original-message lift is either finite, or satisfies the compact-closed/continuous G2c regularity package.

The finite cone-Hall inequality holds on the finite facet-normal generating set.

Then Ψ(y)≤0 for all bounded Borel y, and Theorem 2 holds.

Because polyhedral cones are finitely generated, it suffices to check the dual inequality on finitely many price directions. The G3 pass explicitly records this finite-facet reduction as the cleanest next theorem for finite-action models. 

prover_14_response

A stronger but easier sufficient condition is to combine P3 with Theorem A: if each active label has a Bayes cone with positive inradius around truthful messages and the rowwise-minimizer kernel is bounded relative to τ, then high alignment gives Ψ≤0.

Verdict on P3

Raw P3: Reg maybe, Ψ no.

P3 + finite cone-Hall facet test: Reg + Ψ, computational theorem.

P3 + bounded-jamming cone-margin: Reg + Ψ, primitive high-alignment theorem.

(P4) Radial / antipodal τ-symmetry
Reg-1 / Reg-2

Under a smooth radial model, Reg-1 and Reg-2 are fine.

A precise radial condition:

There is a center b∈Δ(Ω) and compact radial support

C={μ:ρ(μ,b)≤r
0
	​

}.

τ is radial or G-invariant under a compact group acting affinely on Δ(Ω).

The indirect utility is radial:

U(μ)=V(ρ(μ,b)).

The optimal trust region is a ball:

T={μ:ρ(μ,b)≤r
∗
(α)}.

Boundary Bayes cones and antipodal maps vary continuously.

The paper’s spherical example has exactly this skeleton: U(μ)=V(∥μ−b∥), adviser beliefs are symmetrically distributed over a ball, and there is a robustly rationalizable solution with a ball trust region. 

Robust_trust_Dworczak_Smolin

Does P4 imply Ψ≤0?

Yes, if we prove it by constructing the calibrated adversary.

Important correction: symmetry does not mean arbitrary dual prices y become symmetric. The dual inequality must hold for every bounded Borel y, including wildly asymmetric little gremlins. So the right proof is:

Construct the antipodal/radial adversarial kernel.

Verify its induced posterior equals the boundary belief on q-a.e. boundary messages.

Invoke G2c necessity to conclude Ψ(y)≤0 for all y.

This is the same proof architecture as FBNF: construct primal calibration, then the dual inequality follows automatically.

The search pass already stated the symmetry package: compact group action, invariant center, G-invariant or conditionally radial τ, equivariant utility, radial indirect utility, orbit-saturated T, and stabilizers fixing only the radial line. Under those conditions, stabilizer averaging reduces calibration to a single radial scalar balance. 

searcher_04_response

Verdict on P4

P4 works, but it is narrower and essentially radial/FBNF-adjacent. It is a useful theorem, but not the best “second class beyond FBNF.”

Summary table
Candidate	Reg-1 / Reg-2	Ψ(y)≤0	Verdict
P1 smooth strict-convex + atomless τ	Yes, with continuous unique selection	No	Regularity only. Needs calibration.
P2 aligned baseline mass	Yes if paired with Reg package	Yes under bounded-jamming cone-margin or finite dual threshold	Best non-foliated primitive route.
P3 polyhedral W	Not automatically; needs fan/support regularity	Not automatically; WTA dual certificate can fail	Works after finite-facet cone-Hall or cone-margin.
P4 radial / antipodal symmetry	Yes	Yes via constructed primal kernel	Works, but radial/FBNF-adjacent.
Clean primitive sufficient condition theorem
Theorem — Regular bounded-jamming cone-margin class

Assume standing Robust Trust hypotheses with ∣Ω∣≥3, α∈(0,1), arbitrary compact metric Θ, and compact M=suppτ. Fix a G2c-admissible optimal labeling w
∗
:M→W
P
, with

B(m)=B
W
	​

(w
∗
(m)),R(s)={m:s⋅w
∗
(m)=
z∈C
∗
min
	​

s⋅z}.

Assume:

Closed row-minimizer graph: GrR is closed with nonempty compact values.

Continuous Bayes support: m↦h
B(m)
	​

(a) is continuous for every a∈R
∣Ω∣
.

Uniform truthful cone margin: there exists η>0 such that

dist(m,Δ(Ω)∖B(m))≥ητ-a.e.

Bounded rowwise jamming: there exists a Borel kernel κ
0
	​

 supported on R(s) such that its target marginal ρ satisfies

ρ≪τ,
dτ
dρ
	​

≤C.

High-alignment bound:

α+(1−α)C
(1−α)C
	​

diam(Δ(Ω))≤η.

Then:

Ψ(y)≤0∀ bounded Borel y,

and hence the induced optimal strategy is robustly rationalizable in the q-a.e. sense.

Proof

Conditions 1 and 2 give the G2c regularity package. Conditions 3 to 5 imply that the candidate rowwise-minimizer kernel κ
0
	​

 induces posteriors inside B(m) q-a.e., by the posterior displacement calculation above. Therefore G2c primal feasibility holds, so G2c necessity yields Ψ(y)≤0 for all y. G3 then gives robust rationalizability. 

prover_13_response

 

prover_14_response

How this answers the P1–P4 program
P1 only gives the topological half

Use P1 as the regularity engine, not the Hall engine. It gives closed R and continuous h
B
	​

, but it does not prevent positive dual prices.

P2 becomes the main theorem

Replace “dominates for every dual price” by the bounded-jamming cone-margin primitive. This gives a true non-foliated ∣Ω∣≥3 class.

P3 becomes a computational subclass

Polyhedral W is useful because the dual price search can collapse to finitely many facet normals. But P3 alone is not enough, and WTA proves that finite vertices can still fail. 

searcher_04_response

P4 works constructively

Radial symmetry gives a calibrated primal kernel via antipodal routing and scalar balance, then Ψ≤0 follows. Do not prove P4 by trying to symmetrize arbitrary y; that would be the wrong spellbook.

Publication recommendation

Use Theorem A: Regular bounded-jamming cone-margin as the second non-foliated class theorem.

It is cleaner than raw P3, broader than radial P4, and genuinely different from FBNF. It also interfaces naturally with finite-action/polyhedral applications: finite normal fans often supply full-dimensional Bayes cones with positive margins, and bounded jamming is a primitive density/spreading property of (R,τ), not a hidden posterior-calibration assumption.

For the paper, present the hierarchy as:

Binary theorem: scalar endpoint transport.

FBNF theorem: fiberwise scalar transport.

Cone-margin theorem: non-foliated high-alignment/diffuse-baseline transport.

Cone-Hall biconditional: exact necessary and sufficient condition.

That gives both islands and the ocean chart.

Verdict + next step

Verdict: PASS for P2
∗
 / cone-margin theorem; PATCH_SMALL for P3 after adding finite-facet or cone-margin structure; HOLD for P1-alone; PASS for P4 radial constructive class.

Next step: formalize the finite-facet version of Theorem A: define the finite normal-fan cells, compute C,η, and turn the high-alignment condition into an explicit LP threshold for finite-action multi-state models.
