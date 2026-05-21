
========
ROLE: user (id=4826ba43-78f3-493a-933e-c51c38e350da)
========
# Literature pass 01 — Tools for the Pareto-frontier-set reformulation

## Role

You are the Literature pass for a smart-scaffolding proof project. Your job
is to scan the relevant mathematical literature and report **which tools are
available off-the-shelf**, **which can be adapted**, and **which would be a
genuinely new theorem**. You do not prove anything in this pass — you survey.

This is the third pass at extending Theorem 2 of Dworczak–Smolin (2026,
*Robust Trust*, arXiv:2602.09490) beyond finite \(M\), \(\Theta\). The new
reformulation \(\mathcal G_P\) (Piotr Dworczak, 2026-05-20) is documented in
piotr_pareto_frontier_route_memo.md (durable source). Read it first.

The closure of Pass 2 (v8 menu engine) is documented in
project_closure_memo.md and the v8 proof is in theorem_2_extension_proof_v8.md
(durable sources). The closure-named locked gate was a **deletion-compatible
Hall duality theorem**. Two prior literature passes (Route 1: Strassen +
Kellerer + Beiglböck-Nutz-Touzi; Route 2: Burke-Tseng + Fukushima/Auchmuty +
Balseiro-Besbes-Castro) both verdict-ed BUILD (no off-the-shelf theorem
applies). This pass is for the new \(\mathcal G_P\) route — different
mathematical setting, different tool surface.

## What I need

A **prioritized inventory of usable mathematical machinery**, organized by
the open mathematical questions in \(\mathcal G_P\). The five primary
questions:

### Q1. Hyperspace minimax / saddle-point theorems

The agent's strategy is a compact subset \(C \in \mathcal K(W^P)\) (Hausdorff
distance, compact metric). The adversary's strategy is a measurable map
\(\beta: M\to W^P\) with image in \(C\). The payoff is **non-bilinear** in
\((C,\beta)\) — concave in neither.

What minimax / saddle-point existence theorems apply to such hyperspace
games? Survey:
- Sion (1958) + its quasi-concave variants (Komiya 1988, Lin–Geraghty, Ben
  Tal–Ghaoui–Nemirovski 2009).
- Ky Fan (1953) intersection theorem and its set-valued descendants.
- Granas–Liu, Tuy, and other non-bilinear minimax theorems.
- Set-valued minimax theorems on hyperspaces specifically (Beer 1993,
  Aubin-Frankowska 1990, Klein-Thompson 1984).
- Measurable selection-based minimax theorems (Castaing-Valadier, Hu-Papageorgiou).

For each tool, report: applies / partially applies / does not apply, and why.

### Q2. Existence of optimal measurable selections from compact-valued correspondences

For fixed \(C\) and signal \(s\), \(\arg\min_{w\in C} s\!\cdot\!w\) is a
nonempty compact face of \(C\) (lower face in the dual direction \(s\)).
The adversary's BR is \(\beta^*(s) \in\arg\min_{w\in C} s\!\cdot\!w\) for
τ-a.e. \(s\). Is this BR always measurable?

Survey:
- Kuratowski–Ryll-Nardzewski (1965) classical theorem.
- Castaing-Valadier (1977), Aliprantis-Border (2006) Chapter 18.
- Jankov-von Neumann (Castaing 1972, Bertsekas-Shreve 1978 §7).
- Filippov (1988), Aubin-Frankowska (1990) Chapter 8.

State the cleanest sufficient conditions. The correspondence
\((s, C)\mapsto\arg\min_{w\in C} s\!\cdot w\) is jointly measurable in
\((s, C)\) if \(C\) is fixed Borel-compact and \(s\mapsto s\!\cdot w\)
is continuous in \(s\) for fixed \(w\) and continuous in \(w\) for fixed
\(s\). Document the exact theorem.

### Q3. Compactness of \(\mathcal K(W^P)\) and continuity of the value functional

The agent's strategy space is \(\mathcal K(W^P)\) with Hausdorff distance.
Tools needed:
- Blaschke selection theorem (compact subsets of a compact metric space form a
  compact metric space under Hausdorff distance) — fully classical.
- Lipschitz continuity of support functions \(C\mapsto h_C(s)\) and "infimum
  support" \(C\mapsto\min_{w\in C} s\!\cdot\!w\) in \(d_H\), uniform in \(s\)
  over bounded sets. (Same Lipschitz constant: \(\|s\|\).)
- Integral continuity: \(V_P(C) = \int [\alpha\max_C s\cdot w + (1-\alpha)\min_C s\cdot w]\,\tau(ds)\)
  is therefore continuous on \(\mathcal K(W^P)\) by bounded convergence.

These should be 99% off-the-shelf. Confirm any subtleties (e.g., does
\(W^P\) need to be closed in \(W\) for Blaschke? Is it?).

### Q4. Supporting hyperplane theory on the weak Pareto frontier \(W^P\)

The Bayes-calibration question (Pareto-frontier route memo §5) hinges on:
the supporting normal cone \(N(w)\) of \(W^P\) at \(w\) consists of belief-
proportional vectors \(\mu \in\Delta(\Omega)\) such that \(w\in\arg\max_{w'\in W}\mu\cdot w'\),
i.e., the Bayes-optimality cone. Lemma 2 of Theorem 1's proof
(paper p. 27) makes this explicit: \(\hat\sigma\) is Bayes-optimal for
some belief iff its profile is on \(W^P\), and the set of supporting
beliefs is the normal cone of \(W\) at \(w\) intersected with \(\Delta(\Omega)\).

Tools:
- Rockafellar (1970) §13 (convex sets, normal cones, supporting hyperplanes).
- Rockafellar-Wets (1998) Chapter 6 (normal cones to general sets).
- Holmes-Penot duality for set-valued maps.
- Doval-Smolin (2024) on persuasion via payoff sets.

Specifically: is there a clean **continuous selection** of supporting
beliefs from the normal cone of \(W^P\)? I.e., a Borel map
\(\mu: W^P\to\Delta(\Omega)\) with \(\mu(w)\in N(w)\)? If yes, the route
memo §5 is essentially solved at the saddle.

### Q5. Set-valued Bayes-calibration / persuasion-theoretic duality

The route memo §5 reduces to: at every \(w\in C^*\), the posterior
\(P_{\hat\beta^*}(\cdot\mid w)\in\Delta(\Omega)\) induced by Bayes' rule from
\((\tau, \beta^*)\) should lie in the supporting normal cone \(N(w)\) of
\(W^P\) at \(w\).

This is **structurally** a calibration / persuasion-equilibrium condition:
the posterior at "message" \(w\) should be consistent with the agent's
private-strategy choice at \(w\), namely \(\hat\sigma_w = R(w)\). Survey:

- **Bayesian persuasion family** (Kamenica-Gentzkow 2011, Dworczak-Kolotilin
  2024, Dworczak-Pavan 2022, Doval-Smolin 2024).
- **Constrained persuasion / monotone payoff structure** (Kolotilin 2018,
  Mensch 2021, Yang-Zentefis 2023).
- **Pareto-frontier persuasion** (Lipnowski-Ravid 2020 specifically uses
  W^P-style frontier characterization; the paper cites them).
- **Robust persuasion / multiple receivers** (Hu-Weng 2021, Galperti-Perego
  2022).
- **Saddle-point equilibrium in zero-sum persuasion** (Min 2021 Bayesian
  persuasion under partial commitment; Dworczak-Pavan 2022 "robust Bayesian
  persuasion").

Specific candidate theorem to look for: is there a known result of the form
"in a zero-sum persuasion game with supporting-cone structure, the
sender's equilibrium message kernel automatically calibrates to the
receiver's posterior cone"?

### Q6. Banned tool list (carry over from prior memos)

State explicitly which tools are **banned** in this route (per
prior_attempts_digest.md) and confirm none of your recommendations
re-import a banned route. Specifically:
- Sion + Tychonoff on product-of-narrow \(\Sigma\) — banned.
- Adversary attainment in \(\prod_\mu \Delta(M)\) without new tightness — banned.
- τ-AC restriction \(F\subset B\) — banned (Piotr's geometric objection).
- FOC + envelope in infinite case — banned (apparatus is finite-only).

If a tool you recommend reduces to one of these, flag it and propose a
genuinely new replacement.

## Output Contract

Return everything inline in this chat as plain markdown. Use this section
ordering exactly:


# Literature inventory for the Pareto-frontier-set reformulation

## Q1. Hyperspace minimax / saddle-point theorems
- Tool name (Citation, Year). Status: applies / partial / does not apply.
  One-paragraph justification. If "partial", state what additional
  hypothesis would close the gap.

## Q2. Measurable selection from compact-valued correspondences
- ...

## Q3. Compactness + continuity on K(W^P)
- ...

## Q4. Supporting hyperplane theory on W^P
- ...

## Q5. Set-valued Bayes-calibration / persuasion duality
- ...

## Q6. Banned tools — sanity check
- ...

## Verdict
- BUILD / REUSE / BLEND. Justify in one paragraph.
- Cleanest single tool to use as the entry point.
- One-paragraph next-step signal to the searcher.


- BUILD = no off-the-shelf theorem applies, we'd be proving a genuinely new
  result.
- REUSE = there is a usable theorem; cite it precisely and identify how
  it slots in.
- BLEND = a tool exists but requires extension; identify the closest
  candidate and the gap.

End with a one-paragraph **next-step signal**: should the searcher prioritize
Q1, Q2, Q4, or Q5 next, and why?

Show more

========
ROLE: assistant (id=ff11c982-e362-40de-8fb9-9a65a0f3aacb)
========
Literature inventory for the Pareto-frontier-set reformulation
Q1. Hyperspace minimax / saddle-point theorems

Sion minimax theorem (Sion, 1958; Komiya, 1988). Status: does not apply.
The theorem’s useful versions require convex strategy sets and quasi-concavity in the maximizing variable, quasi-convexity in the minimizing variable. In G
P
	​

, the agent chooses C∈K(W
P
), which is compact but not naturally convex, and C↦∫max
C
	​

s⋅wdτ is convex, not concave, while the agent maximizes. The route memo explicitly diagnoses this as the wrong shape for Sion. More importantly, G
P
	​

 does not need Sion for value existence: the adversary’s infimum is pointwise and explicit, so inf
β
	​

U
P
	​

(C,β)=V
P
	​

(C), and C
∗
 is obtained by compactness of K(W
P
). 

piotr_pareto_frontier_route_memo

 Sion and Komiya remain useful only as negative diagnostics, not as route machinery. 
MSP
+1

Sion-style quasi-concave variants, including Lin–Geraghty and robust-optimization minimax formulations (Komiya, 1988; Ben-Tal–El Ghaoui–Nemirovski, 2009). Status: does not apply.
These variants relax continuity or compactness in some directions, or use convex robust-optimization structure, but they still live in convex/quasi-convex decision geometry. The G
P
	​

 agent variable is a hyperspace element C, not a vector in a convex strategy set, and the payoff is not quasi-concave in C. Ben-Tal–El Ghaoui–Nemirovski is a powerful optimization reference for uncertainty sets and tractable robust counterparts, but it is not a saddle-point existence theorem for nonconcave hyperspace games. 
People at EECS

Ky Fan intersection/minimax theorem and KKM descendants (Fan, 1953). Status: partial.
Ky Fan’s intersection theorem is the right atmosphere for “many local inequalities imply a global selector/fixed point,” and its descendants sometimes handle games without linear structure. But a KKM/Fan approach would require a cover or intersection property on the family of Bayes-calibration constraints over K(W
P
). That property is not present off the shelf; it would have to be proved from the optimality of C
∗
. So Ky Fan is a possible language for the future Bayes-calibration fixed point, but not a theorem that slots directly into G
P
	​

. 
PNAS
+1

Granas–Liu and “minimax without convexity” theorems (Granas–Liu, 1995; Simons-style variants). Status: partial.
These results are designed for nonclassical minimax settings, sometimes replacing convexity by connectedness or acyclicity. They are tempting because W
P
 and K(W
P
) are topological rather than linear objects. The gap is that they still require a generalized convexity/intersection structure for level sets. The memo’s payoff is max-of-linear over C, and no known theorem turns optimal compact-set choice into posterior-cone calibration. Extra hypothesis that could close the gap: prove a KKM/acyclicity condition for the correspondence w↦N
W
	​

(w)∩Δ(Ω) restricted to the rowwise arg-min faces of C
∗
. 
SciSpace

Tuy-type quasiconvex–quasiconcave minimax and stability theorems (Tuy, 1974/2007 revisitations). Status: does not apply.
Tuy’s line of minimax theory is built for quasiconvex/quasiconcave functions on topological or vector spaces. Here the objective in the agent variable has the opposite curvature for maximization, and the hyperspace K(W
P
) lacks the convex structure those theorems need. It gives no automatic saddle or calibration result. 
Mathematics Institute

Set-valued minimax / hyperspace topology machinery (Beer, 1993; Aubin–Frankowska, 1990; Klein–Thompson, 1984). Status: partial.
This machinery is useful for the topology of closed sets, continuity of set-valued maps, and Hausdorff/Vietoris convergence. Beer is directly relevant for hyperspace topology, and Aubin–Frankowska/Klein–Thompson are good libraries for correspondences. But they do not give the missing saddle theorem: they help prove compactness, semicontinuity, and measurable/continuous dependence of arg-min faces, not Bayes calibration of the induced posterior. 
Springer
+2
Semantic Scholar
+2

Measurable-selection-based minimax tools (Castaing–Valadier, Hu–Papageorgiou, measurable maximum theorem). Status: partial.
These tools apply cleanly to the adversary’s best response: for fixed compact C, s↦argmin
w∈C
	​

s⋅w has nonempty compact values and a measurable selector. This is the little silver key in G
P
	​

. But selection theorems only choose a rowwise minimizer; they do not say the posterior induced by the selected rowwise minimizer belongs to the Bayes-optimality cone. The route memo says this explicitly: rowwise attainment disappears, while Bayes calibration remains the live dragon. 

piotr_pareto_frontier_route_memo

Q2. Measurable selection from compact-valued correspondences

Kuratowski–Ryll-Nardzewski (Kuratowski–Ryll-Nardzewski, 1965). Status: applies.
Clean sufficient conditions: domain standard Borel, target Polish, correspondence nonempty closed-valued and weakly measurable, or equivalently Borel graph in the compact-valued metric case. Here M⊆Δ(Ω) is standard Borel, W
P
⊂R
∣Ω∣
 is compact metric once closedness is verified, and for fixed C∈K(W
P
),

F
C
	​

(s)=arg
w∈C
min
	​

s⋅w

has nonempty compact values. Its graph is closed/Borel because (s,w)↦s⋅w is continuous and C is compact. Thus an adversary best-response selector β
C
∗
	​

(s)∈F
C
	​

(s) exists. This is fully off-the-shelf. 

piotr_pareto_frontier_route_memo

Measurable maximum theorem / Aliprantis–Border Chapter 18. Status: applies.
The cleanest exact theorem is the measurable maximum theorem: if X is a measurable space, Y is a compact metric space, f:X×Y→R is measurable in x and continuous in y, and Γ:X⇉Y is measurable compact-valued, then x↦argmax
y∈Γ(x)
	​

f(x,y) is measurable compact-valued and admits a measurable selector. Apply it with Y=W
P
, Γ(s)=C, and f(s,w)=−s⋅w. For joint dependence on (s,C), use the feasible graph {(C,w):w∈C}⊂K(W
P
)×W
P
, closed under Hausdorff topology, and the same theorem yields joint measurability of (s,C)↦argmin
w∈C
	​

s⋅w. The v8 exposition already flags Aliprantis–Border 18.13/18.19 as the relevant selection/maximum package. 

exposition_v8.2_final

Castaing–Valadier measurable multifunctions (Castaing–Valadier, 1977). Status: applies.
This is the broader multifunction language behind the same conclusion. It gives measurable selections and Castaing representations for measurable closed-valued correspondences. In G
P
	​

, it is useful if one later wants not just a deterministic selector but a measurable family of compact arg-min faces or a kernel supported on those faces. It is more than enough for Q2, but still does not solve Q5. 
GBV

Jankov–von Neumann selection (Castaing, 1972; Bertsekas–Shreve, 1978 §7). Status: partial.
Use this when the graph is analytic rather than Borel, for example when pulling a payoff-vector selector back through a potentially rough labeling w
∗
. It typically gives universally measurable selectors; a Borel version may require a Borel modification on a completed probability space or stronger closed-graph assumptions. It is the “emergency lantern” rather than the cleanest Q2 tool. Bertsekas–Shreve is the standard stochastic-control reference for analytic-set selection machinery. 
Faculty Hub
+1

Filippov selection theorem / Aubin–Frankowska Chapter 8. Status: applies but overkill.
These are useful in differential inclusions and dynamic selection problems; the current problem is static and compact-valued. The theorem surface is available, but KRN/measurable maximum is cleaner. Aubin–Frankowska is still useful as a reference for measurable set-valued maps, limits, and selections. 
Google Books
+1

Q3. Compactness + continuity on K(W^P)

Blaschke selection theorem / hyperspace compactness. Status: applies.
If W
P
 is compact metric, then K(W
P
), the nonempty compact subsets of W
P
, is compact metric under Hausdorff distance. The only real subtlety is closedness of W
P
. For the weak Pareto frontier

W
P
={w∈W:∄w
′
∈W,w
′
(ω)>w(ω) ∀ω},

closedness follows from compactness of W: if w
n
	​

→w with w
n
	​

∈W
P
, and w were strictly dominated by w
′
, then w
′
 would strictly dominate w
n
	​

 for all large n, contradiction. The paper’s Lemma 2 gives W compact convex and identifies W
P
 as the Bayes-optimal payoff-profile frontier. 

Robust_trust_Dworczak_Smolin

 The route memo correctly notes that convexity of W
P
 is unnecessary for Blaschke compactness. 

piotr_pareto_frontier_route_memo

Lipschitz continuity of support and inf-support maps. Status: applies.
For any C,D∈K(W
P
),

	​

w∈C
max
	​

s⋅w−
w∈D
max
	​

s⋅w
	​

≤∥s∥d
H
	​

(C,D),

and the same bound holds for the minima. Since s∈Δ(Ω), ∥s∥ is uniformly bounded. Therefore C↦max
C
	​

s⋅w and C↦min
C
	​

s⋅w are uniformly Hausdorff-Lipschitz in s. The v8 menu engine and the Pareto-frontier memo both use exactly this Lipschitz/compactness mechanism. 

theorem_2_extension_proof_v8

 

piotr_pareto_frontier_route_memo

Integral continuity of V
P
	​

(C). Status: applies.
Because payoffs are bounded and s is bounded in the finite-dimensional simplex, the Lipschitz estimate gives pointwise convergence under d
H
	​

(C
n
	​

,C), dominated convergence, and hence continuity:

V
P
	​

(C)=∫[α
w∈C
max
	​

s⋅w+(1−α)
w∈C
min
	​

s⋅w]τ(ds).

Thus C
∗
∈argmax
K(W
P
)
	​

V
P
	​

 exists. This is 99% off-the-shelf; the remaining 1% is only the closedness check for W
P
.

Q4. Supporting hyperplane theory on W^P

Supporting hyperplane theorem / convex normal cone of W (Rockafellar, 1970). Status: applies.
The right normal cone is the convex normal cone of W, not a nonconvex normal cone of W
P
. For w∈W
P
,

N
W
	​

(w)∩Δ(Ω)={μ∈Δ(Ω):w∈arg
z∈W
max
	​

μ⋅z}.

This is exactly the Bayes-optimality cone: w is the payoff profile of a private strategy optimal under belief μ. The paper’s Lemma 2 already states the key equivalence: a private strategy is Bayes-optimal for some belief iff its payoff profile lies in W
P
. 

Robust_trust_Dworczak_Smolin

Rockafellar–Wets variational normal cones (Rockafellar–Wets, 1998). Status: partial.
Useful if the route insists on treating W
P
 itself as the primitive set. But W
P
 is generally nonconvex, and limiting/proximal/Clarke normal cones to W
P
 may include geometric normals that are not Bayes beliefs. For Bayes calibration, the load-bearing object is still N
W
	​

(w)∩Δ(Ω). Rockafellar–Wets is therefore a useful notation library, not the theorem that closes Q5. 
Math at Washington
+1

Borel selection of supporting beliefs. Status: applies.
The correspondence

S(w)=N
W
	​

(w)∩Δ(Ω)

has nonempty compact convex values on W
P
, and its graph is closed:

(w,μ)∈graphS⟺μ∈Δ(Ω),μ⋅(z−w)≤0 ∀z∈W.

Since W
P
 and Δ(Ω) are compact metric, KRN gives a Borel selector w↦μ(w)∈S(w). This is enough for measurable representative choice.

Continuous selection of supporting beliefs. Status: does not apply generally.
Continuous selection would require lower semicontinuity plus convex values, for example a Michael-selection setup, or uniqueness of the supporting belief with continuous dependence. Normal-cone correspondences are typically upper hemicontinuous, not lower hemicontinuous, and at corners or flat faces the cone jumps. Continuous selection exists under extra smooth/exposed-frontier assumptions: for instance, if W
P
 is a smooth exposed hypersurface and N
W
	​

(w)∩Δ(Ω) is singleton varying continuously. Without such curvature/single-normal hypotheses, expect only Borel, not continuous, selection. This matters because Q5 needs not merely choosing some supporting belief, but matching the posterior generated by β
∗
.

Holmes–Penot duality for set-valued maps. Status: partial.
Useful for polar/dual formulations of correspondences and for expressing normal-cone relations. It does not produce a continuous selector or a posterior-calibrated adversarial kernel. Treat it as notation and duality grammar, not an off-the-shelf engine.

Doval–Smolin payoff-set / persuasion frontier tools (Doval–Smolin, 2024). Status: partial.
Very relevant conceptually: Doval–Smolin characterize Bayes welfare sets and recover Pareto frontier points through Bayesian persuasion problems. That matches the W/W
P
 geometry in this project. But their theorem does not say that a zero-sum rowwise-minimizing kernel automatically induces posteriors in the normal cones of the selected payoff profiles. It is a strong candidate for the Q5 duality language, not a finished calibration theorem. 
Chicago Journals
+1

Q5. Set-valued Bayes-calibration / persuasion duality

Kamenica–Gentzkow Bayesian persuasion (Kamenica–Gentzkow, 2011). Status: partial.
This gives the primal Bayes-plausibility and concavification technology. It is relevant because β
∗
 plus truth-telling generates a distribution of posteriors/messages subject to Bayes plausibility. But standard persuasion optimizes an information structure against a receiver response rule; it does not impose the specific condition “posterior at message w lies in N
W
	​

(w)” for a rowwise-minimizer face of a compact payoff menu. Useful language, not a direct theorem. 
American Economic Association

Persuasion duality (Dworczak–Kolotilin, 2024). Status: partial, closest dual candidate.
This is the closest off-the-shelf dual hammer. It gives a unified duality approach to Bayesian persuasion; the optimal dual variable can be interpreted as a price function and as a supergradient of the concave closure at the prior, with strong duality under Lipschitz conditions. That is exactly the kind of object one would want to compare to supporting normals of W. The gap: persuasion duality is global and prior-level, while Q5 is messagewise and disintegrated: for q-a.e. realized payoff vector w, the posterior P
β
∗
	​

(⋅∣w) must lie in N
W
	​

(w)∩Δ(Ω). Adapting this would be a real theorem, likely a KKT/disintegration version of persuasion duality. 
Kolotilin
+1

Robust Bayesian persuasion (Dworczak–Pavan, 2022). Status: partial.
Highly relevant thematically because it handles robust persuasion and max–min concerns. It does not, however, solve the present cone-calibration problem: the robust uncertainty there is not the same as an adversarial adviser choosing rowwise minimizers on a payoff-profile frontier. Good background; not a plug-in theorem. 
Wiley Online Library
+1

Doval–Smolin persuasion and welfare (Doval–Smolin, 2024). Status: partial.
This is the best payoff-set reference. It speaks directly to welfare-profile sets and Pareto frontiers, and the paper’s own Lemma 2 cites the same payoff-profile idea. But it does not establish that the adversary’s equilibrium message kernel automatically calibrates to receiver posterior cones. It is a natural scaffold for proving such a theorem.

Constrained / monotone persuasion (Kolotilin line; Mensch, 2021; Yang–Zentefis, 2023/2024). Status: partial for special cases.
These papers give strong tools when states/actions/posteriors are ordered or when posterior quantile distributions obey monotone structure. Mensch identifies primitive conditions under which monotone signal structures are optimal; Yang–Zentefis characterize monotone function intervals and apply them to posterior quantiles in persuasion. These tools may recover the binary-state interval case or monotone one-dimensional subfamilies, but they do not cover general multidimensional W
P
. 
ScienceDirect
+2
arXiv
+2

Pareto-frontier persuasion / weak institutions (Lipnowski–Ravid–Shishkin, 2022; Lipnowski–Ravid, 2020). Status: partial.
The weak-institutions literature is structurally close because it studies persuasion with limited/weak commitment and endogenous credibility. It is useful for thinking about equilibrium messages and on-path beliefs, but I do not see a theorem of the required form: a rowwise-minimizing adversarial kernel with supporting-cone posterior calibration. 
Chicago Journals
+1

Robust persuasion / privately informed receivers (Hu–Weng, 2021). Status: partial.
Hu–Weng study robust Bayesian persuasion of a privately informed receiver in a binary environment with maxmin preferences and identify tractable optimal structures. This is a positive island for binary or ordered environments, not a general R
∣Ω∣
 Pareto-frontier cone theorem. 
Springer
+1

Partial commitment / zero-sum persuasion (Min, 2021; Dworczak–Pavan, 2022). Status: partial.
Min is relevant because partial commitment naturally creates mixtures of committed and cheap-talk behavior; Dworczak–Pavan is relevant because robust persuasion is explicitly max–min. Neither yields the candidate theorem the prompt asks for.

Candidate theorem: “in a zero-sum persuasion game with supporting-cone structure, the sender’s equilibrium message kernel automatically calibrates to the receiver’s posterior cone.” Status: not found; likely new.
In the project’s own language, this is exactly menu-Hall in G
P
	​

 coordinates: the v8 menu-Hall condition asks for a kernel supported on rowwise minimizers whose induced posterior lies in the Bayes cone B(m) q-a.e.; the Pareto-frontier route restates that as P
β
∗
	​

(⋅∣w)∈N
W
	​

(w)∩Δ(Ω) q-a.e. 

theorem_2_extension_proof_v8

 

piotr_pareto_frontier_route_memo

 The v8 sharpness package also says this is not cosmetic: cone-intersection and no-free-dust show calibration cannot simply be repaired by routing mass through null messages. 

exposition_v8.2_final

Q6. Banned tools — sanity check

Sion + Tychonoff on product-of-narrow Σ. Status: banned, not re-imported.
Sion appears above only as a negative diagnostic. The G
P
	​

 route avoids the product-of-narrow strategy topology entirely: existence of C
∗
 comes from compactness of K(W
P
), and adversary best response comes from pointwise compact arg-min plus KRN. The prior attempts’ product-topology Sion route failed because continuity in β against bounded measurable message tests was not available; this pass does not revive it. 

piotr_pareto_frontier_route_memo

Adversary attainment in ∏
μ
	​

Δ(M) without new tightness. Status: banned, not re-imported.
The adversary no longer chooses a row of Δ(M) per belief. In G
P
	​

, the adversary chooses β(s)∈C⊂W
P
, and compactness of C gives pointwise arg-min. This is precisely the route’s structural improvement. 

piotr_pareto_frontier_route_memo

τ-AC restriction F⊂B. Status: banned, not re-imported.
No recommendation here restricts the adversary to τ-absolutely-continuous kernels. In fact the q-a.e. reading keeps τ-null but q-positive messages on-path, and v8 explicitly warns that such messages must satisfy Bayes optimality if used. 

theorem_2_extension_proof_v8

FOC + envelope in the infinite case. Status: banned, not re-imported.
None of the recommended machinery uses finite-dimensional simplex perturbations or Milgrom–Segal envelope logic. The only optimization derivative language mentioned is a possible future KKT/persuasion-duality theorem for Q5, which would need to be formulated as a new infinite-dimensional disintegration theorem, not as the prior finite FOC apparatus.

Canonical/minimal pruning and deletion-compatible Hall duality. Status: open, not silently reused.
The closure memo identifies deletion-compatible Hall duality as the prior bottleneck, with Borel-to-compact non-monotonicity, label-fiber lift, and slack discipline as the named obstructions. This pass does not claim those are solved. The Pareto-frontier route dodges part of the old Hall assignment problem by letting the adversary choose payoff vectors directly, but Q5 can still recreate the same calibration issue in normal-cone language. 

project_closure_memo

Verdict

BLEND.
Q2 and Q3 are REUSE: KRN/measurable maximum and Blaschke/Hausdorff support-function continuity give measurable adversary best responses and existence of C
∗
 essentially for free. Q4 is mostly REUSE for Borel supporting-belief selection, but not for continuous selection. Q1 is mostly a negative result: classical minimax theorems do not apply and are not needed for value existence. Q5 is BUILD: I find no off-the-shelf persuasion or minimax theorem that turns rowwise arg-min faces of C
∗
⊂W
P
 into posterior membership in N
W
	​

(w)∩Δ(Ω) q-a.e. The route’s orchard bears fruit, but the calibration tree still needs grafting. 🍐

Cleanest single tool to use as the entry point.
Use the measurable maximum theorem / KRN selection package on

(s,C)↦arg
w∈C
min
	​

s⋅w.

It makes G
P
	​

 operational: compact hyperspace gives C
∗
, measurable maximum gives β
∗
, and the remaining problem is isolated cleanly as a posterior-normal-cone calibration theorem. For the next proof attempt, pair that with Dworczak–Kolotilin persuasion duality as the candidate dual language for Q5.

One-paragraph next-step signal to the searcher.
Prioritize Q5. Q1 is a decoy forest: Sion/Ky Fan/nonlinear minimax tools either do not apply or are unnecessary for existence of C
∗
. Q2 and Q3 are closed by standard selection and hyperspace compactness. Q4 gives Borel supporting-belief selectors but not automatic matching to Bayes posteriors. The real question is whether optimality of C
∗
 forces the disintegration posterior generated by rowwise minimizers to lie in N
W
	​

(w)∩Δ(Ω), or whether one needs a primitive structural condition weaker than menu-Hall. Search first for a disintegrated KKT / persuasion-duality theorem; failing that, build the theorem directly in G
P
	​

 coordinates.
