
========
ROLE: user (id=af7fa06c-5546-4cb6-8bce-6c65abd5a236)
========
# Breakdown pass 02 — Compact-menu lift roadmap

## Role

You are the Breakdown role. The **finite-menu Pareto-Hall calibration
theorem** has just been proved (Lemmas 6+7+8 reviewer-PASS'd; see
durable sources prover_02_response.md, reviewer_02_response.md).

The remaining big step is the **compact-menu lift**: extend Pareto-
Hall calibration from finite menus \(C^* = \{w_1,\ldots,w_k\}\) to
general compact \(C^*\subseteq W^P\). The route memo's plan was:

- **Step 1**: stratified-compact via Gauss-map regularity.
- **Step 2**: general compact via Painlevé-Kuratowski stability.

The original-message lift (Lemma 12, finite case) is being handled in
a parallel prover pass; **do not duplicate that work** here. Focus on
the compact-menu extension.

## Your job

Produce a lemma chain that decomposes the compact-menu lift into
prover-sized chunks. The chain should culminate in:

**Target theorem (compact-menu Pareto-Hall calibration).** Let
\(C^*\in\arg\max_{C\in\mathcal K(W^P)}\,V_P(C)\) be a global maximizer
of the value functional
\[V_P(C) = \int_M[\alpha h^+_C(s) + (1-\alpha)h^-_C(s)]\,\tau(ds)\]
on the hyperspace \(\mathcal K(W^P)\). Then there exists a Borel kernel
\(\kappa: M\to\Delta(C^*)\) (or, more precisely, a Borel \(\beta^*:M\to W^P\)
with \(\beta^*(s)\in\arg\min_{w\in C^*}\,s\!\cdot\!w\) for τ-a.e.\ \(s\))
such that the disintegration posterior \(p_C(w) := \E[s\mid \text{label} = w]\)
on \(C^*\) satisfies \(p_C(w)\in B_W(w)\) for "\(\tilde q\)-a.e."\ \(w\in C^*\),
where \(\tilde q\) is the appropriate label-marginal under the joint
\(\tilde\gamma_\alpha\).

The hypothesis ledger should identify what's needed beyond standing
assumptions. Candidates:

- (R1) \(W^P\) is a stratified \(C^1\) manifold, with finitely many
  strata, each smooth. Gauss map \(n:W^P\to\Delta(\Omega)\) is single-
  valued (continuous) on each stratum interior.
- (R2) Local finiteness of active-face structure: at \(C^*\), only
  finitely many "exposed" labels carry positive \(q\)-mass. (Economically
  meaningful: the agent's effective response is finite-menu, even when
  C* is a continuum.)
- (R3) Painlevé-Kuratowski stability of the rowwise-minimizer
  correspondence as the menu varies.

## Tools and references

- **Hyperspace variational analysis**: Aubin-Frankowska (1990) Ch.7-8
  on set-valued maps; Rockafellar-Wets (1998) §4 (Painlevé-Kuratowski
  convergence), §5 (set-valued continuity), §6 (normal cones).
- **Gauss map / supporting hyperplane regularity**: Schneider (1993)
  *Convex Bodies* Ch.2 on the spherical image and Gauss map of convex
  bodies; Aliprantis-Border (2006) §7.
- **Approximation by finite menus**: Beer (1993) on Hausdorff
  convergence of compact sets; \(C\) approximable by finite \(C_n\) in
  \(d_H\), but the calibration must pass to the limit.
- **Painlevé-Kuratowski limits of normal cones**: Rockafellar-Wets §6.E.
- **Persuasion / payoff-set tools** (auxiliary): Doval-Smolin (2024),
  Dworczak-Kolotilin (2024).

## Output ordering


# Compact-menu lift roadmap

## Target theorem (compact-menu Pareto-Hall calibration)
(Restate precisely.)

## Hypothesis ledger
- Standing.
- New (R1, R2, R3, or alternatives).

## Step 1 — Stratified-compact lift

### Lemma A — Stratification of W^P
W^P decomposes into finitely many strata; on each stratum the Gauss
map is single-valued. (Cite Rockafellar-Wets Ex.2.39 or Schneider Ch.2.)
This is for the case of polyhedral W; if W is general convex compact,
state the required regularity for stratification.

### Lemma B — Finite-active-face reduction
At a global maximizer C* ∈ K(W^P), only finitely many "active" payoff
profiles carry positive τ-supported aligned-mass and positive
adversarial-mass. (Use the Gauss-map decomposition + integrability.)

### Lemma C — Stratified Clarke-Danskin
On each stratum, the finite-menu Pareto-Hall theorem applies to the
finite active profiles, yielding stratum-local calibration.

### Lemma D — Stratum-stitching
Stitch the stratum-local calibrations into a global Borel kernel on C*.

## Step 2 — General compact lift

### Lemma E — Approximation by finite menus
Show that an arbitrary C* ∈ argmax V_P is approximable in d_H by a
sequence C_n of finite menus with V_P(C_n) → V_P(C*).

### Lemma F — Calibration passes to the PK-limit
The finite-menu calibrations κ_n associated with C_n converge (in
some hyperspace narrow topology) to a calibrated kernel κ* on C*.

### Lemma G — Closedness of the normal-cone correspondence
Use Rockafellar-Wets §6.E to show n ↦ N_W(w_n) is closed under
Painlevé-Kuratowski convergence w_n → w in W^P. Apply to the limit
calibrated kernel.

## Step 3 — Original-message lift (handled in Prover 03; cross-reference only)

Cross-reference the finite-case original-message lift work; identify
the lift hypothesis needed for the compact-menu generalization.

## Capstone (compact-menu Pareto-Hall calibration theorem)
(Combined statement.)

## Prover marching order
First prover target after this breakdown: which lemma, what scope.

## Anticipated review traps
3-5 specific issues a reviewer will probably push back on.


## Output Contract

- Return everything inline as plain markdown.
- Be precise about regularity hypotheses; flag which are economically
  meaningful and which are technical.
- The big risk is that the compact-menu lift quietly reintroduces
  menu-Hall through a back door (e.g., requiring calibration at every
  point of an exposed face). Be vigilant.
- If you decide the lift cannot be made unconditional and requires
  e.g. (R1)+(R3), state the resulting theorem precisely and verify
  it is meaningfully weaker than v8's menu-Hall.

## Constraints

- Banned re-proposals: see prior_attempts_digest.md. Especially
  do not re-import canonical/minimal pruning under standing alone.
- Don't redo the finite-menu work — it's done.
- Per user instruction: push to a meaningful conclusion. If a
  primitive sufficient condition for compact menus exists that is
  strictly weaker than menu-Hall, the theorem is publishable.

Show more

========
ROLE: assistant (id=45d52ffa-4bd0-41c6-b47b-579abe6bbcbf)
========
Compact-menu lift roadmap
Target theorem (compact-menu Pareto-Hall calibration)

Let Ω={1,…,N}, M⊆Δ(Ω) be the support of the adviser-posterior law τ, and let W⊂R
N
 be the compact convex set of feasible state-contingent payoff profiles. By the paper’s Lemma 2 in the proof of Theorem 1, W is convex compact, its weak Pareto frontier W
P
 consists exactly of payoff profiles Bayes-optimal for some belief, and optimal strategies can be replaced by Pareto-frontier payoff profiles without loss. 

Robust_trust_Dworczak_Smolin

For a nonempty compact menu C⊆W
P
, define

V
P
	​

(C)=∫
M
	​

[αh
C
+
	​

(s)+(1−α)h
C
−
	​

(s)]τ(ds),

where

h
C
+
	​

(s):=
w∈C
max
	​

s⋅w,h
C
−
	​

(s):=
w∈C
min
	​

s⋅w.

Equivalently, the Pareto-frontier set game lets the agent choose C∈K(W
P
), while the misaligned adviser chooses a measurable selector β(s)∈C, and the agent maximizes the induced value V
P
	​

(C). The route memo records that K(W
P
) is Hausdorff-compact and that U
∗
=sup
C∈K(W
P
)
	​

V
P
	​

(C) under the Pareto-frontier reformulation. 

piotr_pareto_frontier_route_memo

For C
∗
∈argmax
K(W
P
)
	​

V
P
	​

, define the exposed active correspondences

A
C
∗
+
	​

(s):=arg
w∈C
∗
max
	​

s⋅w,A
C
∗
−
	​

(s):=arg
w∈C
∗
min
	​

s⋅w.

Target theorem. Under the standing assumptions and the compact-menu regularity hypotheses listed below, there exist Borel kernels

λ
+
(⋅∣s)∈Δ(C
∗
),κ
−
(⋅∣s)∈Δ(C
∗
)

such that

λ
+
(A
C
∗
+
	​

(s)∣s)=1,κ
−
(A
C
∗
−
	​

(s)∣s)=1for τ-a.e. s,

and, for the joint payoff-label law

γ
~
	​

α
	​

(ds,dw)=[αλ
+
(dw∣s)+(1−α)κ
−
(dw∣s)]τ(ds),

with second marginal 
q
~
	​

(dw), the disintegration posterior

p
C
	​

(w):=E
γ
~
	​

α
	​

	​

[s∣w]

satisfies

p
C
	​

(w)∈N
W
	​

(w)∩Δ(Ω)=B
W
	​

(w)for 
q
~
	​

-a.e. w∈C
∗
.

This is the compact-menu payoff-label version of Pareto-Hall calibration. It is deliberately not yet the original-message robust-rationalizability theorem. The infinite-message reading of Definition 2 is q
β
∗
	​

-a.e., not literal-all or merely τ-a.e., because the posterior itself is defined relative to the actual mixture message marginal. 

prover_01_response

Hypothesis ledger
Standing

Ω finite, full-support prior μ
0
	​

.

M⊆Δ(Ω) Borel, τ∈Δ(M).

A,Θ compact metric.

u(a,ω,θ) bounded and continuous in a.

s and θ conditionally independent given ω.

W⊂R
N
 compact convex; W
P
⊂W compact weak Pareto frontier.

B
W
	​

(w):={μ∈Δ(Ω):w∈argmax
v∈W
	​

μ⋅v}=N
W
	​

(w)∩Δ(Ω).

Inherited from finite-menu pass

Finite-menu Pareto-Hall calibration. If C={w
1
	​

,…,w
k
	​

}⊂W
P
 is a Pareto-clean ambient local maximizer of the finite value functional, then there exist measurable active weights λ
i
±
	​

(s) such that the induced finite-label posterior p
i
	​

 lies in N
W
	​

(w
i
	​

)∩Δ(Ω) whenever its label mass q
i
	​

>0. The proof hinges on Clarke-Danskin multipliers plus Fermat normality; the normal-cone sign convention and product normal formula were checked explicitly in Prover 02. 

prover_02_response

Tie robustness. The finite theorem does not assume atomlessness or generic no-tie conditions; tie sets are handled by measurable active-face weights. The Lemma 6 reviewer specifically required using the safe inclusion form of Clarke’s sum rule at ties, not a false equality. 

reviewer_01_response

New hypotheses for compact-menu lift

(A0) Pareto-ambient local stationarity.
The chosen compact maximizer C
∗
⊆W
P
 is locally stable not only within W
P
, but against feasible payoff-profile perturbations in W, after removing Pareto-dominated replacements. This is the compact-menu analogue of the finite pass’s ambient local maximality. It is technical but economically interpretable: no selected payoff profile is sitting on the frontier only because dominated nearby profiles were forbidden.

(R1) Stratified frontier regularity.
W
P
 admits a finite C
1
 or Whitney stratification {S
r
	​

}
r=1
R
	​

, with each stratum a smooth embedded manifold, and the normal-cone/Gauss correspondence of W is Borel and well behaved on strata. For smooth strata, the Gauss map may be single-valued on relative interiors. For polyhedral W, do not state single-valuedness at faces or vertices; use the set-valued normal fan.

This is mostly technical. It is acceptable when W is polyhedral, semialgebraic, or generated by finitely many smooth payoff regions.

(R2-FES) Finite effective exposure / finite-active-face saturation.
There exists a finite subset

C
0
	​

={w
1
	​

,…,w
k
	​

}⊆C
∗

such that for τ-a.e. s,

w∈C
∗
max
	​

s⋅w=
w∈C
0
	​

max
	​

s⋅w,
w∈C
∗
min
	​

s⋅w=
w∈C
0
	​

min
	​

s⋅w.

Equivalently, all τ-relevant exposed max/min faces of C
∗
 are already represented by finitely many payoff labels.

This is economically meaningful: the agent may announce or carry a continuum menu, but the aligned and adversarial response uses only finitely many effective payoff profiles. It is strictly weaker than menu-Hall because it says nothing about posterior balance or Bayes calibration; it only identifies the labels that can carry mass.

(R3-FCA/PK) Finite critical approximation and PK stability.
For general compact C
∗
, there exists a sequence of finite Pareto-clean ambient local maximizers C
n
	​

⊂W
P
 such that

d
H
	​

(C
n
	​

,C
∗
)→0,V
P
	​

(C
n
	​

)→V
P
	​

(C
∗
),

and the active correspondences A
C
n
	​

±
	​

 converge to A
C
∗
±
	​

 in the Painlevé-Kuratowski sense along τ-relevant sequences.

This is technical and load-bearing. Plain Hausdorff approximation by finite nets is not enough, because the finite theorem applies to critical/local-maximizer menus, not arbitrary finite subsets. The closure memo’s failed finite-net and deletion-compatible routes warn exactly against smuggling a Hall limit through unverified approximation. 

breakdown_01_response

(R4) Standard Borel disintegration and Radon-Nikodym regularity.
All label laws live on compact metric spaces, so regular conditional probabilities and Radon-Nikodym derivatives exist in the usual Borel sense. This is technical and standard.

Step 1 — Stratified-compact lift
Lemma A — Stratification of W
P

Hypotheses. Standing assumptions plus (R1). In the polyhedral case, replace single-valued Gauss regularity by the normal fan of W.

Statement. W
P
 decomposes into finitely many Borel C
1
 strata

W
P
=
r=1
⋃
R
	​

S
r
	​


such that:

each S
r
	​

 is a smooth embedded manifold in its relative topology;

the normal-cone graph

GrN
W
	​

:={(w,p):w∈W
P
, p∈N
W
	​

(w)∩Δ(Ω)}

is closed, hence Borel;

for every compact C⊆W
P
, the active correspondences

s↦A
C
+
	​

(s),s↦A
C
−
	​

(s)

have analytic, and under mild closed-graph conditions Borel, graphs;

on smooth top-dimensional strata, the Gauss map is single-valued where W has a unique supporting belief; on nonsmooth strata, the correct object is the full convex normal cone.

Tools needed. Rockafellar-Wets normal-cone calculus, Schneider’s spherical image/Gauss map for convex bodies, measurable maximum theorem, Kuratowski-Ryll-Nardzewski selection.

Proof outline. Use (R1) to stratify W
P
. Since W is compact convex, N
W
	​

 has closed graph. For fixed compact C, the map (s,w)↦s⋅w is continuous, so max/min active sets are compact-valued and measurable by the measurable maximum theorem. On each stratum, the Gauss correspondence restricts to a smooth or polyhedral normal object, depending on the stratum.

Reviewer verification target. Check that no false global “single-valued Gauss map” claim is made. Corners and polyhedral faces must use set-valued normal cones.

Risk. For arbitrary compact convex W, finite C
1
 stratification of W
P
 is not automatic. This lemma is a regularity assumption, not a theorem from standing alone.

Lemma B — Finite-active-face reduction

Hypotheses. Standing assumptions, (A0), (R1), and (R2-FES). Let C
∗
∈argmax
K(W
P
)
	​

V
P
	​

. Let C
0
	​

={w
1
	​

,…,w
k
	​

}⊆C
∗
 saturate both support functions τ-a.e.

Statement. C
0
	​

 is value-equivalent to C
∗
:

V
P
	​

(C
0
	​

)=V
P
	​

(C
∗
).

Moreover, after deleting zero-mass inactive duplicates, C
0
	​

 is a Pareto-clean ambient local maximizer of the finite functional

F
k
	​

(w
1
	​

,…,w
k
	​

)=∫
M
	​

[α
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

Consequently, the finite-menu Pareto-Hall theorem applies to C
0
	​

.

Tools needed. Finite-menu capstone, support-function saturation, ambientization via (A0).

Proof outline. The equalities in (R2-FES) imply pointwise equality of the aligned max and adversarial min integrands for C
0
	​

 and C
∗
, hence V
P
	​

(C
0
	​

)=V
P
	​

(C
∗
). Since C
∗
 is globally maximizing, C
0
	​

 is also globally maximizing among compact menus. Ambient local maximality of its coordinate representation follows from (A0): any small feasible perturbation of w
i
	​

 inside W that raised F
k
	​

 would give a compact menu near C
∗
 with larger V
P
	​

, contradicting maximality. Pareto-cleaning removes labels that are dominated or never active.

Reviewer verification target. Check that (R2-FES) is stated as exact max/min support-function saturation, not merely “only finitely many labels carry positive mass.” Positive-mass finiteness alone does not guarantee V
P
	​

(C
0
	​

)=V
P
	​

(C
∗
).

Risk. This lemma is false if the continuum part of C
∗
 is relevant only on a τ-positive but diffuse family of sources. That is precisely why (R2-FES) is a real hypothesis.

Lemma C — Stratified Clarke-Danskin

Hypotheses. Lemma B’s finite active set C
0
	​

={w
1
	​

,…,w
k
	​

}, plus the finite-menu Lemmas 6, 7, and 8.

Statement. There exist Borel active weights

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

)

such that

g
i
	​

=α∫
M
	​

λ
i
+
	​

(s)sτ(ds)+(1−α)∫
M
	​

λ
i
−
	​

(s)sτ(ds)∈N
W
	​

(w
i
	​

)

for every i. With

q
i
	​

=α∫
M
	​

λ
i
+
	​

(s)τ(ds)+(1−α)∫
M
	​

λ
i
−
	​

(s)τ(ds),

the normalized posterior

p
i
	​

=
q
i
	​

g
i
	​

	​


belongs to N
W
	​

(w
i
	​

)∩Δ(Ω)=B
W
	​

(w
i
	​

) whenever q
i
	​

>0.

Tools needed. Patched integral Clarke-Danskin, Clarke Fermat rule, normal-cone stationarity, finite-label Bayes-rule. These are the finite pass’s completed pieces.

Proof outline. Apply the finite-menu theorem to C
0
	​

. Ties are handled through the measurable active weights λ
i
±
	​

, so no atomlessness or no-tie assumption enters. The normal-cone sign convention is inherited from Lemma 7: g
i
	​

⋅(v−w
i
	​

)≤0 for all v∈W. The calibration follows from positive rescaling of g
i
	​

 into p
i
	​

.

Reviewer verification target. Verify that the same g
i
	​

 supplied by Fermat normality is represented by the Clarke-Danskin multipliers. This was the finite proof’s hinge.

Risk. If Lemma B only produces a value-equivalent finite menu but not ambient local stationarity, Lemma C loses the normal-cone conclusion.

Lemma D — Stratum-stitching

Hypotheses. Lemmas A-C. Finite active set C
0
	​

⊆C
∗
. Define zero mass outside C
0
	​

.

Statement. There exist Borel kernels on the full compact menu C
∗
,

λ
+
(dw∣s),κ
−
(dw∣s),

such that

λ
+
(⋅∣s)=
i=1
∑
k
	​

λ
i
+
	​

(s)δ
w
i
	​

	​

,κ
−
(⋅∣s)=
i=1
∑
k
	​

λ
i
−
	​

(s)δ
w
i
	​

	​

,

with supports in A
C
∗
+
	​

(s) and A
C
∗
−
	​

(s), respectively, for τ-a.e. s. The induced compact-label law 
γ
~
	​

α
	​

 satisfies

p
C
	​

(w)∈N
W
	​

(w)∩Δ(Ω)
q
~
	​

-a.e. w∈C
∗
.

Tools needed. Finite support kernels, Borel pasting across finitely many strata, finite disintegration.

Proof outline. Because C
0
	​

 saturates the active faces of C
∗
, the finite active weights are valid C
∗
-active kernels. Extend them by zero on C
∗
∖C
0
	​

. The second marginal 
q
~
	​

 is supported on C
0
	​

, so finite-label calibration gives compact-label calibration immediately.

Reviewer verification target. Check that boundary strata or duplicate labels are not double-counted. Use a disjoint Borel stratum partition, or simply push the finite-label measure through i↦w
i
	​

 after merging duplicates.

Risk. This lemma is clean only because (R2-FES) makes the effective support finite. If the active set is truly continuum, Step 2 is needed.

Step 2 — General compact lift
Lemma E — Approximation by finite menus

Hypotheses. Standing assumptions, (A0), and (R3-FCA/PK). Let C
∗
∈argmax
K(W
P
)
	​

V
P
	​

 be arbitrary compact.

Statement. There exists a sequence of finite menus

C
n
	​

={w
n1
	​

,…,w
nk
n
	​

	​

}⊂W
P

such that:

d
H
	​

(C
n
	​

,C
∗
)→0;

V
P
	​

(C
n
	​

)→V
P
	​

(C
∗
);

each C
n
	​

 is Pareto-clean and ambient locally critical/maximizing in the sense required by the finite-menu theorem;

the active correspondences A
C
n
	​

±
	​

 are Painlevé-Kuratowski stable along τ-a.e. relevant sequences.

Tools needed. Beer’s finite approximation of compact sets, Blaschke compactness, Ekeland variational principle or a penalized finite-menu maximization, measurable maximum theorem.

Proof outline. Start with Hausdorff finite nets D
n
	​

⊂C
∗
. Plain nets give d
H
	​

(D
n
	​

,C
∗
)→0 and value convergence by continuity of V
P
	​

, but not stationarity. Use a finite-dimensional penalized problem near D
n
	​

 to produce a nearby finite ambient local maximizer C
n
	​

. The penalty keeps C
n
	​

 close to C
∗
; compactness and continuity preserve value. PK stability is imposed in (R3) or derived from stratified regularity in tame cases.

Reviewer verification target. Confirm that C
n
	​

 are genuine finite critical/local-maximizer menus. Arbitrary finite nets are not enough: no Fermat multiplier, no calibration.

Risk. This is the largest dragon in the compact lift. Without finite critical approximants, the finite theorem cannot be used.

Lemma F — Calibration passes to the PK-limit

Hypotheses. Lemma E. For each n, finite-menu calibration gives kernels

λ
n
+
	​

(dw∣s),κ
n
−
	​

(dw∣s)

supported on A
C
n
	​

+
	​

(s) and A
C
n
	​

−
	​

(s). Assume compactness/tightness of the joint laws.

Statement. Along a subsequence,

γ
~
	​

α,n
	​

=[αλ
n
+
	​

(dw∣s)+(1−α)κ
n
−
	​

(dw∣s)]τ(ds)

converges narrowly to a probability law 
γ
~
	​

α
	​

 on M×C
∗
. Its conditional kernels λ
+
 and κ
−
 are supported on A
C
∗
+
	​

(s) and A
C
∗
−
	​

(s), respectively, for τ-a.e. s.

Moreover, if 
q
~
	​

n
	​

 is the second marginal and

G
n
	​

(E):=∫
M
	​

∫
E
	​

s[αλ
n
+
	​

(dw∣s)+(1−α)κ
n
−
	​

(dw∣s)]τ(ds),

then G
n
	​

⇒G as vector measures and

p
C
	​

(w):=
d
q
~
	​

dG
	​

(w)

is the limiting conditional posterior.

Tools needed. Prokhorov compactness on compact M×W
P
, disintegration, vector-measure weak convergence, Radon-Nikodym theorem, PK upper-limit stability of active correspondences.

Proof outline. Compactness gives a narrowly convergent subsequence. If (s
n
	​

,w
n
	​

)→(s,w) with w
n
	​

∈A
C
n
	​

±
	​

(s
n
	​

), Hausdorff plus PK stability gives w∈A
C
∗
±
	​

(s). Hence the limit law is supported on the correct active graph. The vector numerator measures converge because s is bounded and continuous on compact Δ(Ω). Absolute continuity G≪
q
~
	​

 follows from the definition of G, giving a posterior density p
C
	​

.

Reviewer verification target. Check active support in the limit. This is where PK stability does real work.

Risk. If active faces jump downward under approximation, mass may land outside A
C
∗
±
	​

. That would break adversarial optimality even if normal-cone calibration survives.

Lemma G — Closedness of the normal-cone correspondence

Hypotheses. W⊂R
N
 compact convex. Lemma F. For each n,

p
n
	​

(w)∈N
W
	​

(w)∩Δ(Ω)
q
~
	​

n
	​

-a.e.

Statement. The limiting posterior satisfies

p
C
	​

(w)∈N
W
	​

(w)∩Δ(Ω)
q
~
	​

-a.e. w.

Tools needed. Closedness of GrN
W
	​

 for closed convex W, Painlevé-Kuratowski limits of normal cones, disintegration, convexity of N
W
	​

(w)∩Δ(Ω).

Proof outline. The graph

Gr(N
W
	​

∩Δ)={(w,p):p∈N
W
	​

(w)∩Δ(Ω)}

is closed. The finite calibrated laws on (w,p) are supported on this graph. Narrow limits of measures supported on a closed set remain supported there. When disintegration averages several limiting posterior samples at the same w, convexity of N
W
	​

(w)∩Δ(Ω) keeps the conditional average inside the same cone. Therefore p
C
	​

(w)∈B
W
	​

(w) for 
q
~
	​

-a.e. w.

Reviewer verification target. Check the averaging step. Closed graph alone gives pointwise support for sampled (w,p); the conditional mean remains calibrated because normal cones are convex.

Risk. If the limiting numerator G is not represented as a conditional mean of calibrated posterior samples, the argument needs a vector-measure version of the same closed-convex support theorem.

Step 3 — Original-message lift (handled in Prover 03; cross-reference only)

This roadmap does not duplicate the original-message lift.

The payoff-label compact theorem produces a kernel on C
∗
⊆W
P
. To translate it into the original game, one must choose an agent labeling

w
∗
:M→C
∗

and lift a payoff label w∈C
∗
 to actual messages in the fiber

(w
∗
)
−1
(w)⊆M.

For finite menus this is a representative-selection problem. For compact menus it becomes a measurable kernel or selector problem over inverse-label fibers.

The route memo identifies exactly this translation issue: given a payoff-vector adversarial choice β
∗
(s)∈W
P
, one must find an original message m
∗
	​

(s) with w
∗
(m
∗
	​

(s))=β
∗
(s), and this requires measurable selection on inverse fibers. 

piotr_pareto_frontier_route_memo

 The compact-menu theorem below therefore stays in payoff-label coordinates; Prover 03 should supply the original-message kernel under its own hypotheses.

Capstone (compact-menu Pareto-Hall calibration theorem)
Capstone 1 — Stratified finite-effective compact theorem

Under the standing assumptions, (A0), (R1), and (R2-FES), every global maximizer

C
∗
∈arg
C∈K(W
P
)
max
	​

V
P
	​

(C)

admits payoff-label kernels λ
+
 and κ
−
 supported on A
C
∗
+
	​

 and A
C
∗
−
	​

 such that

p
C
	​

(w):=E
γ
~
	​

α
	​

	​

[s∣w]∈N
W
	​

(w)∩Δ(Ω)=B
W
	​

(w)
q
~
	​

-a.e. w∈C
∗
.

This theorem is meaningfully weaker than v8 menu-Hall. It assumes finite effective exposure of the compact menu, not posterior calibration. The calibration is produced by finite Clarke-Danskin stationarity.

Capstone 2 — General compact theorem under finite critical approximation

Under the standing assumptions, (A0), and (R3-FCA/PK), every compact global maximizer C
∗
 is the PK/Hausdorff limit of finite calibrated critical menus. The finite calibrated laws converge to a compact-label law 
γ
~
	​

α
	​

, and Lemmas F-G imply

p
C
	​

(w)∈B
W
	​

(w)
q
~
	​

-a.e. w∈C
∗
.

This is the clean general compact lift, but it is conditional. I would not present it as unconditional under standing alone. The project record already identifies finite-net/Hall-limit routes as blocked by Borel-to-compact, label-fiber, and slack-discipline gaps; (R3-FCA/PK) is the explicit technical assumption that prevents those gaps from tiptoeing back in wearing a different hat. 

breakdown_01_response

Prover marching order

First prover target: Lemma B — Finite-active-face reduction.

Precise scope for Prover 03/04, before touching general compact limits:

Assume C
∗
∈argmax
K(W
P
)
	​

V
P
	​

 and a finite subset C
0
	​

={w
1
	​

,…,w
k
	​

}⊆C
∗
 satisfies exact support-function saturation:

C
∗
max
	​

s⋅w=
C
0
	​

max
	​

s⋅w,
C
∗
min
	​

s⋅w=
C
0
	​

min
	​

s⋅wτ-a.e.

Prove V
P
	​

(C
0
	​

)=V
P
	​

(C
∗
), prove that C
0
	​

 is an ambient finite local maximizer under (A0), then invoke the finite-menu Pareto-Hall theorem to construct compact-label kernels supported on C
0
	​

⊂C
∗
. Conclude compact-label calibration with 
q
~
	​

(C
∗
∖C
0
	​

)=0.

Do not prove the original-message lift in this pass. Do not use finite nets. Do not add menu-Hall.

Anticipated review traps

“Finite active mass” is too vague.
The reduction must require exact max/min support-function saturation τ-a.e. Merely saying “only finitely many exposed labels carry positive mass” can miss diffuse continuum exposures.

Frontier-local maximality does not yield N
W
	​

-normality.
The finite proof needs ambient local maximality over W
k
, not only over (W
P
)
k
. The compact theorem therefore carries (A0).

Finite Hausdorff nets are not finite critical menus.
Approximation C
n
	​

→C
∗
 gives value convergence but not Clarke stationarity. Lemma E must produce finite local maximizers or critical approximants, not decorative nets.

Gauss maps are not globally single-valued.
Polyhedral and nonsmooth frontiers require set-valued normal cones. Single-valued Gauss maps are only valid on smooth strata with unique supports.

Original-message lift cannot be hidden inside compact calibration.
The payoff-label theorem gives w-posteriors on C
∗
. Turning those into original messages requires a separate measurable inverse-fiber construction, already flagged in the route memo and left to the parallel prover pass.
