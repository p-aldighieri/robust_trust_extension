PASS.

The latest prover pass establishes the two local points it set out to prove on the countable-atomic direct branch.

First, the naive weakening of CTR4 to “check only exposed rows and keep the old pointwise proof” is genuinely false. The provided example
[
W=\operatorname{co}{(0,0),(1,0),(0,-1)},\quad
w_0^*=(0,0),\quad
w_j^*=(1,0)\ \ (j\in S),\quad
\bar w=(0,-1),\quad
m_i=\Big(\frac1i,1-\frac1i\Big)
]
does exactly what is needed: no row is (S)-exposed, but for every fixed (t>0) some non-exposed row satisfies (c_i(v(t))<c_i(w^*)). So the old line
[
c_i(v(t))\ge c_i(w^*)\qquad(i\neq i^*)
]
cannot be recovered from exposed-row checks alone. That diagnosis is now bankable.

Second, the rewritten first-order proof under the quantitative net-gain condition is correct as a conditional sufficiency lemma. On the standing countable-atomic branch, if there is an admissible common-target path and it satisfies
[
\inf_{j\in S} m_{i^*}\cdot w_j^*=c_{i^*}(w^*)<\inf_{j\in A} m_{i^*}\cdot w_j^*,\qquad
\Delta_*:=m_{i^*}\cdot\bar w-c_{i^*}(w^*)>0,
]
[
\Gamma_i:=[c_i(w^*)-m_i\cdot\bar w]_+\qquad (i\in E_S(w^*)\setminus{i^*}),
]
[
\Lambda:=\sum_{j\in S}\tau_j\big(m_j\cdot w_j^*-m_j\cdot\bar w\big),
]
and
[
(1-\alpha)\Big(\tau_{i^*}\Delta_*-\sum_{i\in E_S(w^*)\setminus{i^*}}\tau_i\Gamma_i\Big)>\alpha\Lambda,
\tag{QNG}
]
then the tail-lifting inequality is violated for all sufficiently small (t>0), hence no true reduced maximizer can carry the obstruction.

The proof is sound. The active row contributes a linear gain (t\Delta_*). Exposed non-active rows contribute at worst linear losses (t\Gamma_i). Non-exposed rows need not be pointwise safe, but their weighted total loss is (o(t)): this is exactly where countable atomicity and (\sum_i\tau_i<\infty) are used, via the margins
[
\kappa_i:=\inf_{j\in S}(m_i\cdot w_j^*-c_i(w^*))>0
]
and dominated convergence. The aligned side is exactly linear, (t\Lambda). Plugging these estimates into the banked maximizer-level tail-lifting inequality yields the contradiction.

What is now bankable:

* The naive exposed-row pointwise weakening fails.
* The first-order QNG lemma is a correct conditional export lemma on the countable-atomic direct branch.
* The real replacement for old CTR4 is not pointwise safety of all non-active rows, but:

  * linear control of exposed-row losses through (\Gamma_i), and
  * an (o(t)) weighted tail bound for non-exposed rows.
* Old CTR5 can be weakened from “no aligned loss” to the slope inequality QNG.
* CTR2 and the bookkeeping clause (1\in S) are not part of the contradiction engine.

What should still be treated as stronger than ideal, but mathematically sufficient:

* The strict separation
  [
  \inf_{j\in S} m_{i^*}\cdot w_j^*=c_{i^*}(w^*)<\inf_{j\in A} m_{i^*}\cdot w_j^*
  ]
  is stronger than the real need. The proof only needs (c_{i^*}(v(t))>c_{i^*}(w^*)) for all small (t).
* The common-target finite-anchor/infinite-tail path is stronger than the pure contradiction argument requires.
* QNG is proved as a sufficient path-level condition, not as a necessary or minimal weakening of CTR.

What remains diagnosis or heuristic only:

* Any claim that the current (d_1=e_1)-type obstruction data automatically produce a moved set (S), a common target (\bar w), or QNG.
* Any claim that QNG is the weakest possible nontrivial condition.
* Any export beyond the current common-target countable-atomic setup.

Suggested next local action: formalize the bankable lemma exactly in terms of (E_S(w^*)), (\Gamma_i), (\Lambda), and QNG, strip out the bookkeeping clauses, and only then test whether the current obstruction data can manufacture that QNG hypothesis outside the settled explicit class.
