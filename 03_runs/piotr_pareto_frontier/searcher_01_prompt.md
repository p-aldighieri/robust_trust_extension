# Searcher pass 01 — Routes to close the Pareto-Hall calibration gap

## Role

You are the Searcher for a smart-scaffolding proof project. The formalizer
(`formalizer_01_response.md`, harvested) and literature passes
(`literature_01_response.md`, harvested) have just adjudicated the Pareto-
frontier-set reformulation \(\mathcal G_P\) (Piotr's 2026-05-20 suggestion,
documented in `piotr_pareto_frontier_route_memo.md`, durable source).

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

```
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
```
