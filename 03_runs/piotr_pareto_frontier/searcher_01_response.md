
========
ROLE: user (id=d25d07cc-5d22-457e-8cef-cbda15965495)
========
# Searcher pass 01 — Routes to close the Pareto-Hall calibration gap

## Role

You are the Searcher for a smart-scaffolding proof project. The formalizer
(formalizer_01_response.md, harvested) and literature passes
(literature_01_response.md, harvested) have just adjudicated the Pareto-
frontier-set reformulation \(\mathcal G_P\) (Piotr's 2026-05-20 suggestion,
documented in piotr_pareto_frontier_route_memo.md, durable source).

## Convergent verdict from previous passes

\(\mathcal G_P\) gives Tier 1a for free (value-optimal \(C^*\in\arg\max V_P\)
plus payoff-vector adversary BR \(\beta^*\in\arg\min_C s\!\cdot w\) by KRN
on the compact-valued correspondence). But Tier 2 still requires the
**Pareto-Hall calibration condition**:

\[
P_{\hat\beta^*}(\cdot\mid m) \;\in\; N_W(w^*(m))\cap\Delta(\Omega) \quad q\text{-a.e.}\ m,
\]

where \(w^*(m)\in\arg\max_{w\in C^*}\,m\!\cdot\!w\) is the aligned-best
labeling and \(N_W(w)\) is the normal cone of the **full** payoff polytope
\(W\) at \(w\), intersected with the belief simplex.

The literature pass verdict-ed **BUILD**: no off-the-shelf persuasion or
minimax theorem closes this calibration. The formalizer adjudicated
Pareto-Hall as **menu-Hall in different notation** — equivalent, not weaker.

## Your job

**Find the route that makes calibration close.** This is not a "review
candidates" pass — it is a "rank and recommend an attack vector" pass.
Several candidate routes are listed below. Your job is to:

1. **Evaluate** each candidate's odds of closing calibration.
2. **Rank** them by (feasibility × novelty × distance-from-prior-banned-routes).
3. **Recommend** one route as primary attack. State precisely the next
   role's marching orders.
4. **Flag** any candidate that, while attractive, is structurally a banned
   route in disguise.

## Candidate routes (do not just rank these — add new ones if you see them)

### R1. KKT / first-order on the hyperspace

\(V_P(C) = \alpha\int h^+_C(s)\,\tau(ds) + (1-\alpha)\int h^-_C(s)\,\tau(ds)\)
is continuous on the compact hyperspace \(\mathcal K(W^P)\), but
\(\mathcal K(W^P)\) is **not** a vector space, so classical KKT doesn't
directly apply. However, the Aubin-Frankowska / Rockafellar-Wets
**variational analysis on hyperspaces** (Rockafellar-Wets §4) gives
Fréchet/limiting normal cones to compact sets in the right way.

Question: at \(C^*\in\arg\max V_P\), does the first-order condition with
respect to Painlevé-Kuratowski set perturbations force the disintegration
posterior to lie in \(N_W\cap\Delta\)?

Use: variational geometry of \(\mathcal K(W^P)\), set-valued first-order
conditions, the "infimal selection" / "outer-graphical" calculus.

### R2. Dworczak-Kolotilin persuasion duality + disintegrated KKT

Dworczak-Kolotilin (2024) "Persuasion Duality" gives the strongest unified
dual framework for Bayesian persuasion: the optimal dual variable is a
price function on beliefs that supports the concave closure of the value
function at the prior, under Lipschitz conditions.

In \(\mathcal G_P\): treat the adversary as a "sender" choosing a Bayes-
plausible distribution of posteriors and the agent's payoff function on
\(C\) as the receiver's value. The dual variable is a price \(p:\Delta(\Omega)\to\R\)
supporting the concave closure of \(\mu\mapsto\max_{w\in C^*}\,\mu\!\cdot\!w\)
at \(\mu_0\).

Question: does this dual price function deliver, by disintegration, the
calibration \(P_{\hat\beta^*}(\cdot\mid m)\in N_W(w^*(m))\)?

Use: Dworczak-Kolotilin persuasion duality; Doval-Smolin (2024)
"Persuasion and Welfare" frontier characterization (cited in v8 §3 and
Lemma 2 of Theorem 1's proof); KKT-style sufficient conditions.

### R3. Piotr's alternating-representations bootstrap

Piotr's verbatim closing suggestion:
> "Perhaps a successful approach is to combine the approaches, alternating
> between representations of the problem and using the existing results
> (most likely the proof of Theorem 1) that predict that certain properties
> of the Agent's strategy can be assumed wlog."

Operational reading:

1. Use \(\mathcal G_P\) to get \(C^*\) and \(\sigma^*\) (Tier 1a).
2. Translate back to original-game coordinates.
3. Use Lemma 2 of Theorem 1's proof: \(\hat\sigma^*(m)\) can be assumed
   wlog Bayes-optimal for **some** belief \(\mu_m \in N_W(w^*(m))\cap\Delta\).
4. Now show: when the agent uses \(\hat\sigma^*\) and the adversary plays
   their BR \(\hat\beta^*\), the **induced posterior** \(P_{\hat\beta^*}(\cdot\mid m)\)
   coincides with \(\mu_m\) (the supporting belief chosen by Lemma 2).
5. This is a **fixed-point compatibility** between the agent's choice of
   supporting belief (free under Lemma 2) and the adversary's induced
   posterior.

Question: can step 4 always be arranged at the saddle, by choosing the
right supporting belief in step 3? This is a *measurable-selection-meets-
fixed-point* question, not a direct calibration claim.

Use: Lemma 2 of Theorem 1 (paper p. 27); measurable selection from
upper-hemicontinuous correspondences; Kakutani-type fixed-point on
\((s,m)\mapsto\)(supporting belief at \(w^*(m)\) consistent with rowwise-
min via \(\beta^*\)).

### R4. Primitive structural condition strictly weaker than menu-Hall

Identify a clean **primitive** condition — on \(\tau\), \(W\), \(\alpha\),
or the model fundamentals — that **forces** Pareto-Hall calibration.
Targets:

- (R4a) \(\tau\) has full-support density on \(\Delta(\Omega)\); \(W^P\) is
  smooth (\(C^1\) manifold). Then the normal cone is a singleton continuous
  in \(w\). Maybe calibration is automatic.
- (R4b) \(W^P\) is strictly convex (no flat faces). Then the rowwise-min
  selection \(\arg\min_{w\in C^*}\,s\!\cdot\!w\) is single-valued continuous
  in \(s\). Maybe this forces calibration.
- (R4c) \(\tau\) is supported on the relative interior of the cone of
  normals to \(W^P\) — i.e., every \(s\in M\) is a "regular" source belief
  in a precise sense.
- (R4d) The model has product / separable structure: \(u(a,\omega,\theta) = u_1(a,\omega) + u_2(a,\theta)\)
  or similar. Then \(W^P\) inherits a tensor structure and calibration
  may follow from finite-dimensional intersection theory.

For each candidate, judge whether it is **economically meaningful** (interpretable
as a primitive of the original game, not as a property of the optimization
output \(C^*\) or \(\sigma^*\)) and **strictly weaker than menu-Hall** and
**compatible with the v8 sharpness package** (Lemma 7 cone intersection +
Theorem 8 no-free-dust). The v8 sharpness witness is in WTA ternary with
atomless full-support \(\tau\) — so condition (R4a) alone is NOT sufficient
to rule out the witness. Whatever condition you propose must distinguish
the v8 witness's "menu-engine artefact" geometry from a "primitive optimal"
case.

### R5. Concavification of the value function

Define \(\Phi:\Delta(\Omega)\to\R\) as
\(\Phi(\mu) = \max_{w\in W}\,\mu\!\cdot w = h_W(\mu)\) (support function of
\(W\) on the simplex). \(\Phi\) is concave in \(\mu\) (sup of linear
functionals). Its concave conjugate / disintegration over \(\tau\) gives
a finite-dimensional concavification problem (Kamenica-Gentzkow style).

Does this concavification approach yield a calibrated kernel directly?
The Doval-Smolin persuasion-and-welfare paper uses this technology.

Use: concave envelopes (Aumann-Maschler 1995, Kamenica-Gentzkow 2011);
Doval-Smolin's "frontier persuasion"; concave conjugates on simplex.

### R6. Strassen-Kellerer-style coupling theorem

The Pareto-Hall question is: is there a Borel kernel \(\kappa(\cdot\mid s)\)
on \(M\) supported on the rowwise minimizer correspondence \(G(s)\) such that
the disintegration of \(\alpha\cdot\text{id}\#\tau + (1-\alpha)\tau\otimes\kappa\)
over its second marginal yields posteriors in the right cones?

This is a **constrained coupling problem**: marginals fixed (\(\tau\) on the
source side, \(q\) on the message side), support constraints (kernel
supported on \(G(s)\)), AND conditional constraints (posterior on \(\Omega\)
given \(m\) must lie in \(N_W(w^*(m))\cap\Delta\)).

Strassen 1965 marginals theorem, Kellerer 1984, Beiglböck-Nutz-Touzi
(2017) on martingale optimal transport — these are the natural candidates.
Routes 1 + 2 in the closure memo already tried this and got STALLED at
"Borel→compact non-monotonicity" and "cell-flow lift gap".

Question: in the \(\mathcal G_P\) coordinates, do these obstructions still
bite, or does the payoff-vector reformulation circumvent them? Specifically:
the closure memo's O1 (Borel→compact gap) is about signed deletion
integrands \(s\cdot(v_i - w^*(m))\). In \(\mathcal G_P\), the "deletions" are
in \(W\), not in \(M\). Does this change the geometry of the obstruction?

### R7. WLOG reduction via the rowwise-minimizer face

Define \(F(s) := \arg\min_{w\in C^*}\,s\!\cdot\!w\). This is the minimizer
face of \(C^*\) against signal \(s\); it is a compact convex subset of
\(\partial C^*\). The adversary's BR \(\beta^*(s)\) lives in \(F(s)\).

Choose \(\beta^*\) not as a deterministic selector but as a **kernel**
\(\beta^*(\cdot\mid s)\in\Delta(F(s))\). For Tier 2 calibration,
\(\beta^*\) needs to be chosen specifically to **average correctly** —
i.e., the disintegration posterior across \(F(s)\) must land in the right
cone. This is a relaxed Pareto-Hall.

Question: is the relaxation strictly easier than the deterministic
version? Specifically, does the convexity of \(F(s)\) plus convexity of
\(N_W(w)\) (which is a cone) give a calibrated selection by some
averaging / Choquet theorem?

### R8. Direct existence via the persuasion-fixed-point

Treat \((C, \beta, \mu_{\cdot})\) jointly as a triple where \(\mu_m\in N_W(w^*(m))\)
is the supporting belief at \(w^*(m)\). The game then becomes a triple
fixed-point: \(\beta\) is BR to \((C, \mu_\cdot)\), \(\mu_\cdot\) is the
disintegration posterior of \((\tau, \beta)\), and \(C\) is BR to \(\beta\).

Use Kakutani / Schauder / Ky Fan on the hyperspace \(\mathcal K(W^P)\times
\{\text{Borel kernels}\}\times\{\text{Borel posterior maps}\}\) to assert
existence of a calibrated fixed point.

Question: do the standard fixed-point hypotheses (compactness, convexity-
where-needed, hemicontinuity) hold? The kernel space and the posterior-map
space are infinite-dimensional but compact in narrow topology; the
correspondences need to be upper-hemicontinuous with closed convex values.

## Constraints

- **Stay outside banned tools**: no product-of-narrow Sion, no τ-AC
  restriction \(F\subset B\), no FOC + envelope, no canonical/minimal
  pruning without deletion-compatible Hall duality, no ε-menu-Hall as
  primary route (the 2026-05-08 attempt verdict-ed UNRESOLVED).
- **The v8 sharpness package binds**: any route that incidentally implies
  exact menu-Hall in WTA ternary under atomless τ contradicts Lemma 7
  (cone intersection). Routes that claim exact calibration in this
  geometry must explain how they avoid Lemma 7 — typically by adding a
  primitive structural assumption that rules out the v8 witness's
  menu-engine geometry.
- **Budget**: rank by feasibility within ~3 prover passes; favor routes
  that yield an exact theorem OR a primitive sufficient condition that
  is meaningfully weaker than menu-Hall. Per user instruction, do not
  stop at partial results; push to a closing route.

## Output Contract

Return everything inline in this chat as plain markdown. Use this exact
ordering:


# Searcher: routes to close Pareto-Hall calibration

## Ranking

| Rank | Route | Feasibility | Novelty | Banned-risk | Notes |
|---|---|---|---|---|---|
| 1 | RX | high/med/low | high/med/low | none/low/med/high | ... |
| ... | ... | ... | ... | ... | ... |

## Top route — detailed analysis (R?)
- What it is.
- Why it might close calibration.
- Concrete next prover target (1–2 lemmas, not the whole theorem).
- Specific tools (cite by name and reference).
- Risk assessment: where could it stall?

## Second route — backup
- Same structure, half the depth.

## New routes you saw that weren't in the candidate list
- (May be empty.)

## Routes ruled out / banned re-proposals
- (List with reasons.)

## Verdict
- Primary attack route: R?.
- Next role: breakdown.
- Single most important sub-question to formulate: <one sentence>.

## Next-step signal
- One paragraph telling the breakdown role exactly what lemma chain to
  build first.


Show more

========
ROLE: assistant (id=397308ff-87c3-4c4a-8b5c-5bb83885481b)
========
Searcher: routes to close Pareto-Hall calibration
Ranking
Rank	Route	Feasibility	Novelty	Banned-risk	Notes
1	R1, sharpened as finite/stratified Clarke-KKT on active frontier faces	med-high	high	low-med	Best attack. The key move is not “FOC + envelope” on the original strategy game, but Clarke/Danskin stationarity for finite or stratified Pareto-frontier menus. It can turn active argmax/argmin tie multipliers into the calibrated posterior itself. Start finite, then lift to regular compact strata.
2	R6, payoff-coordinate compact coupling duality	med	med-high	med	Old Strassen/Kellerer in message coordinates hit Borel→compact and cell-flow lift gaps. In G
P
	​

, the message is the payoff vector, so the label-fiber lift largely disappears. Still dangerous: it is Hall duality wearing a cleaner coat.
3	R4, but only strong primitive geometry: one-dimensional normal fan, radial/orbit symmetry, finite exposed menu, or Gauss-map monotonicity	med	med	low	Economically meaningful if stated on primitives or payoff geometry. R4a/R4b alone are not enough; “smooth” or “strictly convex” does not force a barycenter identity.
4	R3 alternating-representations bootstrap	med-low	med	med-high	Piotr’s alternation idea is valuable as a proof wrapper, but step 4 is the whole calibration problem unless the supporting-belief choice affects the adversary’s induced posterior through tie slack. Without that, it is menu-Hall in a nicer hat.
5	R2 persuasion duality + disintegrated KKT	low-med	med	med	Useful as a language for dual prices, but persuasion duality gives global support of a concavification/convexification, not the messagewise posterior-in-normal-cone condition. Good auxiliary tool for R1, weak as primary.
6	R8 direct triple fixed point	low	med	high	Too many nonconvex/hemicontinuity gremlins: K(W
P
) is not convex, posterior maps are discontinuous under weak kernel convergence, and this drifts back toward product-narrow fixed-point/Sion machinery.
7	R7 relaxed rowwise-minimizer face	low	low	high	Structurally the existing set-valued menu-Hall condition. Convexifying F(s) and N
W
	​

(w) does not by itself solve the conditional barycenter constraint.
8	R5 concavification of Φ=h
W
	​

	low	low	med	As stated, Φ(μ)=max
w∈W
	​

μ⋅w is convex, not concave. Concavification can describe persuasion values, but it loses the rowwise-minimizer support constraint and does not deliver calibration.
Top route — detailed analysis (R1)

What it is.
Use G
P
	​

 to get the optimal Pareto-frontier menu C
∗
, then treat V
P
	​

(C) as a nonsmooth variational object on active payoff profiles. The finite-menu version is the clean first bite: write

C={w
1
	​

,…,w
k
	​

}⊂W
P
,F
k
	​

(w
1
	​

,…,w
k
	​

)=∫[α
i
max
	​

s⋅w
i
	​

+(1−α)
i
min
	​

s⋅w
i
	​

]τ(ds).

At a local maximizer, Clarke/Danskin stationarity should produce measurable tie weights

λ
i
+
	​

(s)∈Δ(arg
j
max
	​

s⋅w
j
	​

),λ
i
−
	​

(s)∈Δ(arg
j
min
	​

s⋅w
j
	​

),

such that

g
i
	​

:=α∫λ
i
+
	​

(s)sτ(ds)+(1−α)∫λ
i
−
	​

(s)sτ(ds)∈N
W
	​

(w
i
	​

).

Then

p
i
	​

=
α∫λ
i
+
	​

dτ+(1−α)∫λ
i
−
	​

dτ
g
i
	​

	​


is exactly the posterior induced at payoff-label w
i
	​

, and p
i
	​

∈N
W
	​

(w
i
	​

)∩Δ(Ω). That is Pareto-Hall calibration, not assumed but produced by stationarity.

Why it might close calibration.
The route attacks the right object. The paper’s Lemma 2 identifies W as compact convex and W
P
 as exactly the payoff profiles Bayes-optimal for some belief; dominated non-Bayes profiles can be replaced while weakly improving the robust payoff. 

piotr_pareto_frontier_route_memo

 Piotr’s G
P
	​

 already removes rowwise attainment: C
∗
∈K(W
P
) exists by Hausdorff compactness, and the adversary’s payoff-vector best reply is a pointwise argmin over compact C
∗
. 

piotr_pareto_frontier_route_memo

 The only remaining problem is that the induced posterior must land in the normal cone; the route memo explicitly says this is structurally the same as menu-Hall, but the argmin-face geometry opens a possible Lagrangian/supporting-hyperplane route. 

piotr_pareto_frontier_route_memo

The clever hinge is that the Clarke multipliers are already probability weights over active max/min faces. The aligned tie multipliers and adversarial tie multipliers are not bookkeeping; they are the mass splits whose barycenters become Bayes posteriors. This is the first route where the “missing calibration kernel” appears as a first-order multiplier, not as an external Hall assumption.

Concrete next prover target.
Prove exactly these two lemmas first, in the finite-menu/no-tie-or-purifiable-ties case:

Lemma 1, finite-menu stationarity-to-normality. If C={w
1
	​

,…,w
k
	​

}⊂W
P
 is a local maximizer of F
k
	​

 over W
k
 up to Pareto-dominating replacement, then there exist measurable active-face weights λ
i
+
	​

,λ
i
−
	​

 with g
i
	​

∈N
W
	​

(w
i
	​

) for every i.

Lemma 2, normality-to-calibration. Given the weights from Lemma 1, define the adversarial kernel by λ
i
−
	​

(s) over rowwise minimizers and define the aligned tie labeling by λ
i
+
	​

(s). Then the disintegration posterior at label w
i
	​

 is p
i
	​

=g
i
	​

/q
i
	​

, hence lies in N
W
	​

(w
i
	​

)∩Δ(Ω) whenever q
i
	​

>0.

After those pass, the next extension is either finite exposed optimal menus as an exact theorem, or a C
1
/stratified compact-menu analogue using normal-current/first-variation language.

Specific tools.
Use Clarke’s necessary condition for a locally Lipschitz constrained maximum; Danskin’s theorem for max
i
	​

s⋅w
i
	​

 and min
i
	​

s⋅w
i
	​

; Aumann measurable selection for active argmax/argmin tie weights; Rockafellar-Wets variational analysis for normal-cone bookkeeping; Kuratowski-Ryll-Nardzewski only for measurable active-face selections. The proof should consciously avoid the prior “FOC + envelope” apparatus in the original infinite-message game, which was flagged as finite-case-only and miscomputed in prior work. 

prior_attempts_digest

Risk assessment: where could it stall?
The main risks are small but sharp little porcupines:

Normal cone to W
P
 versus W. Calibration needs N
W
	​

(w
i
	​

), not merely a normal to the frontier. The fix is to permit Pareto-dominating replacements: if z∈W is dominated by z
P
∈W
P
, then g
i
	​

≥0 implies g
i
	​

⋅z≤g
i
	​

⋅z
P
, so stationarity against W
P
 dominators gives normality against all W.

Tie purification. Clarke multipliers may split mass at tied aligned messages. If ties have τ-mass zero, this vanishes. Otherwise the prover needs an atomless-purification lemma or must allow mixed private strategies at tied messages without leaving the intended menu.

Infinite compact menus. The finite proof may pass while the general compact case still needs a normal-cycle or first-variation measure. That is acceptable: it yields a strong primitive theorem first, then a clear lift target.

Sharpness compatibility. This route must not imply arbitrary menu-Hall for arbitrary nonoptimal menu-engine scenery. That is safe if stationarity is imposed on a primitive optimal C
∗
; the v8 witness is explicitly classified as a menu-engine artefact, not a primitive counterexample. 

project_closure_memo

Second route — backup

What it is.
R6, but rewritten entirely in payoff-vector coordinates. Let C
∗
⊂W
P
. Define the closed support relations

R
+
={(s,w):w∈arg
z∈C
∗
max
	​

s⋅z},R
−
={(s,w):w∈arg
z∈C
∗
min
	​

s⋅z}.

The aligned law is a selection or tie-splitting on R
+
. The adversarial law is a kernel on R
−
. Calibration is the linear inequality

∫
E
	​

s⋅(z−w)dγ
α
	​

(s,w)≤0∀E⊂C
∗
, ∀z∈W,

which is equivalent to the conditional barycenter lying in N
W
	​

(w) for q-a.e. w.

Why it might close calibration.
In old message coordinates, the closure memo says the route died on Borel→compact non-monotonicity, label-fiber lift, and slack discipline. 

project_closure_memo

 In payoff coordinates, w itself is the message label, and R
±
⊂M×C
∗
 are compact/closed under ordinary regularity. That removes the nastiest fiber-lift dragon. The result would be a compact linear feasibility theorem: existence of γ
−
 with fixed first marginal, support in R
−
, and cone-valued conditional barycenters.

Concrete next prover target.
First prove the finite-partition Farkas theorem on M×C
∗
: for a finite partition {E
ℓ
	​

} of C
∗
 and a finite test set {z
r
	​

}⊂W, characterize existence of a nonnegative flow on R
−
 satisfying the cone inequalities. Then show the dual inequalities are exactly the finite-menu stationarity inequalities from R1. This backup should either fuse into R1 or expose the precise missing Hall inequality.

Specific tools.
Hahn-Banach separation for compact convex sets of measures, Kellerer/Strassen only after the compact finite-partition version is clean, disintegration on compact metric spaces, and finite-dimensional Farkas for the discretized cone constraints.

Risk assessment: where could it stall?
It can easily become the old deletion-compatible Hall theorem again. The closure record says that theorem is the “single most consequential open question,” and it must handle sourcewise deletion certificates and messagewise calibration simultaneously. 

project_closure_memo

 This backup is only worth pursuing if it stays in payoff-coordinate compact relations and does not reintroduce message-fiber lifting.

New routes you saw that weren't in the candidate list

R9. Finite-active-menu Clarke-Danskin theorem. This is the executable core of R1. It should be treated as the first theorem, not as a toy case. It would already cover infinite M with finitely many payoff-relevant frontier labels, which is economically interpretable as a finite menu of payoff-relevant private strategies.

R10. Normal-fan monotonicity / Gauss-map calibration. Assume the Gauss map n:W
P
→Δ(Ω) is single-valued and the optimal C
∗
 is convex or interval-like in normal coordinates, with τ symmetric/monotone along the normal fan. This generalizes the binary interval and spherical examples, where balancing equations pin down calibration directly. The paper’s binary and spherical constructions already show this style can close in structured environments. 

Robust_trust_Dworczak_Smolin

 

Robust_trust_Dworczak_Smolin

R11. Calibration-as-subgradient-selection theorem. State Pareto-Hall as: the Clarke subdifferential of V
P
	​

 at C
∗
 admits a selection whose Radon-Nikodym conditional densities lie in N
W
	​

(w). This is a continuum version of R9 and a possible bridge between R1 and R6.

Routes ruled out / banned re-proposals

R7 as primary. Relaxing deterministic rowwise minimizers to kernels over F(s) is already the set-valued menu-Hall formulation. It names the dragon; it does not slay it.

R5 as primary. The support function h
W
	​

(μ)=max
w
	​

μ⋅w is convex in μ, not concave. Concavification may help interpret values, but it does not enforce rowwise-minimizer support plus conditional normal-cone membership.

R8. The direct fixed-point route reopens compactness/continuity trouble in kernel spaces. Prior attempts already warn against product-topology Sion/Kakutani-style architectures because the needed continuity in β fails for bounded measurable test functions. 

prior_attempts_digest

R3 without a multiplier or tie mechanism. Choosing the “right” supporting belief after the fact cannot change the posterior induced by β
∗
. Without active-face tie slack, it is menu-Hall in different notation.

R4c if output-dependent. “τ is supported on normals to the optimal C
∗
” is not primitive; it smuggles in the calibrated geometry. A primitive Gauss-map symmetry or one-dimensional normal-fan condition is acceptable.

Old R6 in message coordinates. Do not restart compact-patch deletion Hall, cell-flow LP lift, or Borel→compact repair as previously framed. The closure memo says those pipelines are structurally blocked and converged on the same missing theorem. 

project_closure_memo

Product-of-narrow Sion, τ-AC restriction, canonical/minimal pruning, and ε-menu-Hall as primary. These are explicitly recorded as exhausted or banned; the Pareto-frontier memo also says G
P
	​

 no longer needs Sion for existence, since rowwise minimization is pointwise and explicit. 

piotr_pareto_frontier_route_memo

Verdict

Primary attack route: R1, executed first as R9 finite-active-menu Clarke-Danskin stationarity, then lifted to stratified compact C
∗
.

Next role: breakdown.

Single most important sub-question to formulate: Can Clarke-Danskin stationarity of an optimal Pareto-frontier menu produce active argmax/argmin tie weights whose aggregate source vector lies in N
W
	​

(w) for each active payoff label w?

Next-step signal

Build the proof around the finite-menu lemma first. Define F
k
	​

(w
1
	​

,…,w
k
	​

), compute its Clarke subdifferential using measurable active-face weights for the max and min terms, and prove that local optimality over Pareto-dominating replacements forces each subgradient component g
i
	​

 into N
W
	​

(w
i
	​

). Then turn those same weights into the adversarial kernel and compute the disintegration posterior p
i
	​

=g
i
	​

/q
i
	​

. Do not start with the full hyperspace. The finite case is the calibration anvil: if it rings true, extend to C
1
/stratified compact menus; if it cracks, the crack will identify the exact missing assumption.
