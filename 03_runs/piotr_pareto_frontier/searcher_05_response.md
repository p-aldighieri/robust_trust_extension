
========
ROLE: user (id=e7141a1f-501c-417c-83ff-21a7b64f121b)
========
# Searcher pass 05 — Unrestricted |Ω|≥3 (beyond FBNF-7)

## Role

You are the Searcher. The pipeline has now produced TWO unconditional
infinite-extensions of Theorem 2 in the substantive α∈(0,1) regime:

1. **Binary** (|Ω|=2) under (R-EE)+(R-TD)+(R-IES).
2. **FBNF** (|Ω|≥3) under FBNF-1...5 + FBNF-7, covering spherical,
   affine MLR, polyhedral with scalarizable faces.

Both are reviewer-verified, committed to git, and in v9 exposition
(exposition_v9.pdf, 11 pages, durable source).

**Per user override (2026-05-21): keep trying.** The pipeline should
attack the **unrestricted |Ω|≥3 case** (without FBNF-7 or any
foliation hypothesis). This is the v8 closure memo's named open
object: the **deletion-compatible Hall duality theorem**.

The WTA ternary witness (v8 §8) fails FBNF-7 by construction. The
v8 closure memo classifies it as a "menu-engine artefact, not a
primitive counterexample". So the witness does not preclude a
primitive infinite-extension; it just shows FBNF-7-style global
dominance is needed unless you can construct a calibration kernel via
a DIFFERENT mechanism.

## Available tools (new since v8 closure)

Pass 3+ produced two new technical mechanisms that v8 didn't have:

- **v9 T1: Finite-menu Pareto-Hall via Clarke-Danskin.** Calibration
  emerges as a Lagrange multiplier at any finite-menu Pareto-completed
  ambient local maximizer of $F_k$. This is a NEW proof method,
  unconditional in payoff-label coordinates.
- **FBNF measurable pasting (F1).** Conditional B1 kernels can be
  measurably pasted across a Borel foliation. The pasting machinery is
  a standard-Borel disintegration argument.

## Candidate attack vectors

### Attack A: Sinkhorn / IPF for multidim Hall transport

The deletion-compatible Hall duality is a coupling problem: find a
kernel $\kappa: M\to\Delta(M)$ supported on $G(s)$ such that the
disintegration posterior on $\Omega$ lies in the Bayes cone $B_W(w^*(m))$
$q$-a.e. This is a constrained OT problem with cone-valued conditional
marginal constraints.

Sinkhorn iteration handles constrained OT with marginal constraints.
Can a Sinkhorn-style ITERATIVE PROPORTIONAL FITTING with Bayes-cone
PROJECTION step converge? Specifically:
- Start with any kernel $\kappa_0$ supported on $G(s)$.
- Compute current posterior $\mu_m^{(t)}$ at each message $m$.
- Project $\mu_m^{(t)}$ onto $B_W(w^*(m))$ (closest belief in the cone).
- Re-couple to maintain marginal constraints.
- Iterate.

**Question**: under what primitive conditions does this iteration
converge to a calibrated kernel? Standard Sinkhorn convergence
results (Cuturi 2013, Léger 2021) give exponential convergence under
boundedness + finite-state. For continuous M, need an infinite-state
extension (Carlier-Duval-Peyré-Schmitzer 2017).

### Attack B: Doval-Smolin full duality

Doval-Smolin "Persuasion and Welfare" (2024) is cited in the paper.
The literature pass already noted this is the closest dual candidate.
The full framework (not just the W^P definition) gives DUAL price
functions on beliefs. Maybe these dual prices admit a disintegration
interpretation that closes calibration.

**Question**: state the Doval-Smolin duality precisely and check
whether the dual price function at the optimum admits a Bayes-cone
calibration interpretation.

### Attack C: Multi-layer foliation

Generalize FBNF: instead of a SINGLE 1-d foliation, allow a MULTI-LAYER
foliation where Δ(Ω) is foliated at multiple scales. For |Ω|=3, this
might be a 2-d foliation with binary fibers at each layer.

**Question**: state the multi-layer FBNF class precisely. Does it
cover the WTA ternary witness?

### Attack D: Stratified normal fan with cross-stratum patching

Drop the affine foliation assumption; replace with a stratification
of Δ(Ω) into sub-domains where the Gauss map is locally well-behaved,
plus a cross-stratum patching condition.

**Question**: does cross-stratum patching reduce to FBNF-7-like global
dominance, or is it genuinely new?

### Attack E: ε-relaxation of FBNF-7

For every ε > 0, define ε-FBNF-7: cross-fiber messages dominate
in-fiber endpoints by at most ε. Get an ε-version of the FBNF theorem.

**Question**: does the ε-version close for ALL primitive models (in
particular the WTA ternary witness)? If yes, this is a sharp
ε-relaxation result.

### Attack F: Direct attack on WTA ternary

Can we construct a calibrated kernel for the v8 WTA ternary witness
under a primitive condition the v8 closure memo didn't consider? The
witness has W^P = {v_0, v_1, v_2} (vertex menu), τ atomless full-
support on Δ(Ω). The cone-intersection lemma + no-free-dust theorem
say no Borel τ-null dust can repair calibration.

**Question**: does the witness have a calibrated kernel under a
sufficiently fine grid of τ (e.g., uniform with positive density on
each face)? If yes, the obstruction theorem is sharp for the abstract
menu-engine but bypassed by primitive structure.

### Attack G: Cone-valued Hall theorem (genuinely new theorem)

State and attempt to prove a Hall-type theorem with cone-valued
constraints: given finite marginals + cone-valued conditional
constraints, when does a coupling exist? Standard Hall theory handles
set-valued constraints; cone-valued is new.

**Tools to try**: Strassen 1965 with cone-valued upper sets, Beiglböck-
Nutz martingale OT with conjugate constraints, abstract intersection
theorems on conjugate cones.

## What I want

Rank Attacks A-G by:
- Probability of yielding a usable primitive result for unrestricted
  |Ω|≥3.
- Distance from v8's failed Routes 1+2 (we don't want to redo).
- Novel ingredient: what technical tool would close the gap.

Pick the TOP attack. State its first prover target.

## Constraints

- Banned tools list applies.
- The v8 closure memo's R6 (constrained persuasion duality) and
  Routes 1+2 already tried direct Hall-type attacks; new attack must
  introduce a genuinely new ingredient.
- v8 sharpness witness (WTA ternary) MUST be addressed: either
  calibrate it under some primitive, or correctly exclude it.

## Output Contract

- Inline markdown.
- End with: (a) one-line top attack + (b) first prover target + (c)
  whether the route can also reopen the WTA ternary as primitively
  calibrable, or only as excluded by hypothesis class.

Per user instruction: keep going. The expectation is that this pass
will either find a real next angle OR honestly conclude the locked
gate is structural beyond all available tools. Don't fall back to
consolidation.

Show more

========
ROLE: assistant (id=86688160-29e3-43e7-8746-84c3b6ecbdf3)
========
I’ll treat this as a fresh route-selection pass, anchored in the closure/FBNF record and ternary witness, then rank A–G for genuinely new usable mechanisms and name one prover-ready target.

========
ROLE: assistant (id=6cd8b622-95f6-437f-b409-04356889dcb4)
========
I’ll prioritize routes that alter the kernel-existence problem itself, especially regularized or Clarke-Danskin duality mechanisms that create usable slack or local calibration demand.

========
ROLE: assistant (id=ec56dcee-e072-4c5a-b657-d437918c87f9)
========
According to documents from 2026-05-21, the next viable move is not another FBNF-style class theorem. FBNF with FBNF-7 already gives a clean infinite-extension on spherical, affine-MLR, and scalarizable-face geometries, but FBNF-7 is exactly the global cross-fiber dominance condition we now want to remove. The project record still identifies the missing unrestricted object as a deletion-compatible Hall duality theorem, with three named hazards: Borel-to-compact non-monotonicity, label-fiber lift, and slack discipline in curved W. 

project_closure_memo

 The Pareto-frontier pass also confirms that in original-message coordinates (D2) is structurally the same as menu-Hall, so a route that merely repackages calibrated matching is not enough. 

piotr_pareto_frontier_pass3_chr…

Searcher 05: unrestricted ∣Ω∣≥3, beyond FBNF-7
Ranking
Rank	Attack	Probability of usable unrestricted progress	Distance from failed Routes 1+2	Novel ingredient that could close the gap	WTA ternary status
1	G: Cone-valued Hall theorem	Medium-high	High, if formulated as conic Farkas/Strassen with aligned baseline, not compact-deletion	A finite-to-Borel aligned-baseline cone-Hall duality: calibration cones enter the Hall inequalities through support functions	Reopens WTA as a real test case: calibrable iff dual inequalities pass
2	F: Direct WTA ternary	Medium	High	Solve the smallest non-FBNF primitive model by positive-mass transport, not null dust	Directly reopens WTA, probably with an α,τ-threshold
3	D: Stratified normal fan with cross-stratum patching	Medium	Medium-high	Normal-fan strata plus finite cycle or cocycle conditions for cross-stratum flows	Likely excludes WTA via a nonzero cycle obstruction unless it collapses to G
4	B: Doval-Smolin full duality	Medium-low	Medium	Pareto-price functions on Bayes welfare sets as candidate separating prices	Useful dual vocabulary, but aggregate, not messagewise
5	A: Sinkhorn/IPF with cone projection	Low-medium	Medium-high computationally, low as exact theorem	Entropic/Dykstra projection onto support, marginal, and cone constraints	Produces residuals or numerical witnesses; exact convergence assumes feasibility
6	C: Multi-layer foliation	Low-medium	Medium	Iterated binary scalar transports on a filtration/tree of fibers	Covers laminar ordered models, probably not WTA unless it becomes G
7	E: ε-FBNF-7 relaxation	Low for exact, medium for approximate	Medium	Quantitative residual theorem BR≤Φ(ε)	Does not close all primitive models; WTA may have positive residual
Top candidate: Attack G, cone-valued Hall duality

This is the only route that honestly attacks the unrestricted object rather than carving another island around it. The closure memo’s open theorem asks for primitive conditions under which there is a Borel kernel supported on rowwise minimizers G(s) whose induced posterior lies in the Bayes cone B(m) q-a.e. 

project_closure_memo

 FBNF avoided the dragon by scalarizing every calibration equation into one-dimensional B1 transports; its capstone explicitly still requires FBNF-7 to turn fiber-local minimization into a global original-game best response. 

prover_11_response

 We now need the theorem that FBNF sidestepped.

The new ingredient should be a cone-valued finite Hall theorem with aligned baseline. This is not the old compact-deletion Hall route. It moves the calibration condition into the primal variables and derives the dual by conic separation.

First prover target: finite aligned-baseline cone-Hall theorem

Prove the following finite theorem first. This is the bite-sized theorem where no Borel pathology can hide under the carpet.

Let S={s
1
	​

,…,s
I
	​

}⊂Δ(Ω) be source posteriors with weights τ
i
	​

. Let M={m
1
	​

,…,m
J
	​

}⊂Δ(Ω) be messages, with aligned baseline mass ατ
j
M
	​

 at message m
j
	​

. Let R(i)⊆J be the rowwise-minimizer support correspondence. Let each B
j
	​

⊆Δ(Ω) be a closed convex Bayes cone.

Find nonnegative flows x
ij
	​

 such that

x
ij
	​

=0if j∈
/
R(i),
j
∑
	​

x
ij
	​

=(1−α)τ
i
	​

,

and for every message j,

n
j
	​

:=ατ
j
M
	​

m
j
	​

+
i
∑
	​

x
ij
	​

s
i
	​

∈q
j
	​

B
j
	​

,q
j
	​

:=ατ
j
M
	​

+
i
∑
	​

x
ij
	​

.

Equivalently, the posterior n
j
	​

/q
j
	​

 lies in B
j
	​

 whenever q
j
	​

>0.

The finite cone-Hall dual should be:

∀(y
j
	​

)
j=1
J
	​

⊂R
∣Ω∣
,α
j
∑
	​

τ
j
M
	​

[y
j
	​

⋅m
j
	​

−h
B
j
	​

	​

(y
j
	​

)]+(1−α)
i
∑
	​

τ
i
	​

j∈R(i)
min
	​

[y
j
	​

⋅s
i
	​

−h
B
j
	​

	​

(y
j
	​

)]≤0.
	​


Here h
B
j
	​

	​

(y)=sup
μ∈B
j
	​

	​

y⋅μ. This inequality is the cone-Hall cut condition: the first term prices the aligned truthful baseline; the second lets the adversary choose the cheapest rowwise feasible message under the same calibration prices.

Prover target G1. Prove finite G1 by separating the achievable flow polytope from the product cone

K
j
	​

:={(q,n)∈R
+
	​

×R
∣Ω∣
:n∈qB
j
	​

}.

Then show the separating hyperplanes reduce exactly to the displayed support-function inequality. Once finite G1 passes, the next prover target is the standard-Borel extension: approximate by finite partitions, use the countable separating family of affine prices, and disintegrate the limiting flow. That Borel step will still be sharp-toothed, but it is now aimed at a clean finite theorem rather than a fog bank.

Why the other attacks rank lower
A: Sinkhorn/IPF with Bayes-cone projection

Sinkhorn is excellent for computation and regularized feasibility. Cuturi’s entropic OT replaces classical OT by an entropy-smoothed problem computed by Sinkhorn matrix scaling. 
NeurIPS Papers
 Carlier-Duval-Peyré-Schmitzer prove convergence of entropic regularized OT plans toward optimal OT plans as entropy vanishes. 
arXiv
 More recent Schrödinger/Sinkhorn results also state convergence when the Schrödinger problem has a solution, with linear rates under support compatibility. 
AFST

But that is the catch: for our exact theorem, convergence requires the calibrated feasible set not to be empty, or it converges to a relaxed residual. So A is a good diagnostic engine and an ε-certificate engine, but it does not by itself prove primitive existence. It becomes powerful after G, not before G.

B: Doval-Smolin full duality

Doval-Smolin is the right dual-language source, but not the whole lift. Their paper defines and characterizes the Bayes welfare set, and says the Pareto frontier can be recovered by standard Bayesian persuasion problems. 
arXiv
 That gives price functions and Pareto weights, which can become the y
j
	​

’s in G1.

The missing step is messagewise disintegration. Doval-Smolin gives aggregate feasibility of welfare profiles and persuasion posteriors; Definition 2 needs P
β
∗
	​

(⋅∣m)∈B(m) for actual messages m, q-a.e. The pass-3 record says exactly why this matters: payoff-label calibration can be obtained by Lagrange multipliers, but the original-message lift remains the Hall transport problem. 

piotr_pareto_frontier_pass3_chr…

C: Multi-layer foliation

A multi-layer foliation is a natural extension of FBNF, but it is still a foliation hypothesis. It could cover ordered/layered models by running B1 repeatedly along a tree of binary splits. The problem is gluing: once multiple layers can route mass around cycles, tower calibration is not automatic. The compatibility condition becomes a cycle condition, and that cycle condition is basically cone-Hall in disguise.

It probably does not cover the WTA ternary witness unless one adds enough cross-layer constraints to recreate G. WTA’s obstruction has three labels and genuinely two-dimensional cone geometry, not a one-parameter family of binary fibers. 

prover_08_response

D: Stratified normal fan with cross-stratum patching

This is a serious backup. The honest version is: stratify T or W
P
 by normal fan cells; solve a finite or low-dimensional cone-Hall problem on each stratum; then patch across shared faces.

The key question in the prompt is exactly right: does cross-stratum patching reduce to FBNF-7-like dominance? My answer: yes if it is only “don’t let other strata dominate”; no if it is formulated as a finite cycle-balance condition. The latter is genuinely new, but then it is a finite-dimensional face version of G. So D is a good implementation layer after G1, not the first theorem to prove.

E: ε-relaxation of FBNF-7

This can give a useful approximate theorem:

calibration defect≤CεorBR≤Φ(ε).

But it will not close all primitive models exactly unless every model admits arbitrarily small cross-fiber dominance residual. The WTA geometry is the caution sign: the obstruction is vector-valued, and an ε-dominance relaxation may leave a positive irreducible residual. This is a publication-grade approximation route, not the best route for unrestricted Theorem 2.

F: Direct WTA ternary

This is the best testbed and the best second attack. The v8 witness is not a primitive counterexample: its halfspace trust region is behaviorally equivalent to the full vertex menu, so the witness is a menu-engine artefact rather than a primitive impossibility result. 

project_closure_memo

 The no-free-dust result only kills repairs through τ-null dust; it does not rule out a positive-measure transport using the actual B
i
	​

 plurality regions.

The next concrete WTA theorem should be:

For WTA with full-support density τ, characterize the α for which the full vertex menu admits a calibrated rowwise-minimizer kernel.

I expect an α-threshold. If α is large, aligned truthful mass inside each Bayes cone B
i
	​

 may dominate misaligned inflow from the opposite minimizer cone K
i
−
	​

. If α is small, G1 should produce an explicit separating price. This would either reopen WTA as primitively calibrable or exclude it with a real primitive certificate, not the old dust argument.

The precise next prover pass

Prover pass 12: G1 finite aligned-baseline cone-Hall theorem.

Deliverables:

State the finite theorem with S,M,R,B
j
	​

,α,τ.

Prove necessity of the support-function inequalities.

Prove sufficiency by finite-dimensional separation/Farkas.

Show how WTA ternary instantiates B
j
	​

 and R(i).

Identify the exact Borel extension target after G1.

This is the smallest theorem that is both new and load-bearing. It has no compact-patch smoke, no limiting dust, no topology on strategy spaces, no foliation. Just finite conic flow with aligned baseline. A tiny anvil, but the right one. 🜁

(a) Top attack: Attack G, cone-valued Hall duality via finite aligned-baseline conic Farkas/Strassen.
(b) First prover target: Prove G1, the finite aligned-baseline cone-Hall theorem with the displayed support-function dual inequality.
(c) WTA ternary: This route can genuinely reopen WTA as primitively calibrable for some (α,τ), or exclude it by an explicit dual price certificate; it does not merely exclude WTA by hypothesis class.
