Current verdict: on the present countable-atomic direct record, the obstruction data do **not** manufacture the moved-set / common-target / QNG package beyond the settled explicit class. The first unresolved step is already **before** the tail-lifting contradiction. It is the missing realization of a **QNG-feasible common target** on an admissible infinite moved tail.

## What is now bankable

1. **Explicit class no-embedding is proved.**
   On the scoped class
   [
   W={(x,0):0\le x\le 1},\qquad m_2=e_1,\qquad m_i=e_2\ (i\neq 2),
   ]
   the obstruction cannot occur at a true reduced maximizer. The path that moves every non-anchor coordinate toward ((1,0)) strictly raises the only active floor and creates no aligned loss, so the banked tail-lifting inequality is violated.

2. **CTR is a correct conditional export lemma.**
   If one already has an admissible infinite-tail common-target path that raises the active floor and causes no harmful spillovers, then the tail-lifting inequality gives a contradiction.

3. **QNG is a correct first-order conditional export lemma.**
   For an admissible common-target path, the contradiction follows under
   [
   (1-\alpha)\Big(\tau_{i^*}\Delta_*-\sum_{i\in E_S(w^*)\setminus{i^*}}\tau_i\Gamma_i\Big)>\alpha\Lambda,
   ]
   where
   [
   \Delta_*:=m_{i^*}\cdot \bar w-c_{i^*}(w^*),\qquad
   \Gamma_i:=[c_i(w^*)-m_i\cdot \bar w]*+,\qquad
   \Lambda:=\sum*{j\in S}\tau_j\big(m_j\cdot w_j^*-m_j\cdot \bar w\big).
   ]

4. **The naive zero-order weakening is false.**
   One cannot recover the old pointwise rowwise monotonicity argument by checking only exposed rows. Non-exposed rows can still dip below their old floor pointwise, even though their weighted total effect is only (o(t)).

These are real gains. The back end of the contradiction is now solid.

## The exact local manufacture problem

Fix a true reduced maximizer (w^*) carrying the scoped (d_1=e_1)-type obstruction, and let (i^*) be the positively weighted obstructing row. For any admissible infinite moved set (S) on which the (i^*)-floor is actually lifted by a common target (\bar w\in W), define
[
\mathcal N(S,\bar w)
:=
(1-\alpha)\Big(\tau_{i^*}\Delta_*-\sum_{i\in E_S(w^*)\setminus{i^*}}\tau_i\Gamma_i\Big)-\alpha\Lambda.
]
Then the reviewer-cleared QNG lemma says:

> if there exist (S) and (\bar w) with (\Delta_*>0) and (\mathcal N(S,\bar w)>0), the tail-lifting inequality is violated.

So beyond the explicit class, the whole direct route has now reduced to the following **single missing realization statement**:

> **Needed assumption / crux lemma.** There exist an admissible infinite moved tail (S) and a common target (\bar w\in W) such that the (i^*)-floor is raised and (\mathcal N(S,\bar w)>0).

For fixed (S), the map (\bar w\mapsto \mathcal N(S,\bar w)) is continuous and concave on compact (W). So this is a well-posed compact feasibility problem, not a vague heuristic. But it is still **unproved** from the current obstruction data.

## Why the current obstruction data stop exactly here

The banked obstruction inputs are still only **zero-order / finite-screening** objects:

* the scalarized necessary condition,
* the explicit finite scalar witness (d_1=e_1) at (\lambda=0),
* the maximizer-level tail-lifting inequality.

Those tools can rule out configurations once a good path is in hand, but they do not yet manufacture the path-level data needed by QNG.

More precisely, the current obstruction data do **not** yield any of the following beyond the explicit class:

1. **An admissible infinite moved set (S).**
   One still needs an infinite tail on which the active row floor is attained in a way that can actually be lifted by a common deformation. That is a path-realization issue, not a scalar witness issue.

2. **A common target (\bar w).**
   The obstruction witness does not presently imply the existence of a single (\bar w\in W) with
   [
   m_{i^*}\cdot \bar w>c_{i^*}(w^*)
   ]
   while keeping exposed-row deficits and aligned losses under control. Outside the explicit class, this is the first genuine geometric bottleneck.

3. **The strict slope sign (\mathcal N(S,\bar w)>0).**
   Even if some active-row-improving (\bar w) existed, the current data do not control
   [
   \sum_{i\in E_S(w^*)\setminus{i^*}}\tau_i\Gamma_i
   \quad\text{or}\quad
   \Lambda,
   ]
   hence do not determine the sign of (\mathcal N(S,\bar w)). The scalarized necessary condition is too coarse for that. It is finite and zero-order; QNG is infinite-tail and first-order.

This is why the reviewer-cleared counterexample matters. It shows the missing control cannot be replaced by the naive slogan “only exposed rows matter pointwise.” The correct first-order statement is the weighted inequality (\mathcal N(S,\bar w)>0), and current obstruction data do not imply it.

## What is bankable versus only diagnostic

### Bankable

* The explicit scoped class is dead by a real tail-lift contradiction.
* CTR and QNG are valid **conditional** no-embedding tools.
* The correct path-level target is not old CTR4 pointwise safety; it is the net-gain inequality (\mathcal N(S,\bar w)>0) plus the (o(t)) control of non-exposed rows.
* The direct branch has been reduced to a sharp local realization problem: produce (S) and (\bar w) with (\Delta_*>0) and (\mathcal N(S,\bar w)>0).

### Only diagnostic

* Any claim that the current (d_1=e_1)-type obstruction data automatically produce such an (S).
* Any claim that they automatically produce a common target (\bar w).
* Any claim that they automatically force (\mathcal N(S,\bar w)>0), hence QNG.
* Any claim that the scalarized necessary condition alone bridges zero-order obstruction geometry to first-order path gain.

## Bottom line

So the answer to the present move is negative: **the current obstruction data do not yet manufacture QNG beyond the explicit class.** The first concrete obstruction is the missing **QNG-feasible common-target realization lemma**. Everything after that point is already banked.

Suggested next local action: formulate and attack exactly the realization problem “find an admissible infinite tail (S) and (\bar w\in W) with (\Delta_*>0) and (\mathcal N(S,\bar w)>0),” rather than trying to read QNG directly off the scalar witness or off zero-order obstruction geometry.
