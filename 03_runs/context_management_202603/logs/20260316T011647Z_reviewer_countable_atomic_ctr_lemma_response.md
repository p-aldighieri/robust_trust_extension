PASS.

The new prover pass does prove a valid **conditional** export lemma beyond the settled explicit class. What is now bankable is the following statement:

> Let (w^*) be a true reduced maximizer carrying the scoped (d_1=e_1)-type obstruction, and let (i^*) be the positively weighted obstructing row. If there exist a common target (\bar w\in W), a decomposition (\mathbb N=A\sqcup S) with (A) finite and (S) infinite, and (\varepsilon>0) such that
> [
> v_j(t)=
> \begin{cases}
> w_j^*, & j\in A,\
> (1-t)w_j^*+t\bar w, & j\in S,
> \end{cases}
> \qquad t\in[0,\varepsilon],
> ]
> is admissible, raises the (i^*)-floor strictly, does not lower any other relevant floor, and does not create positive aligned loss in aggregate, then the banked tail-lifting inequality is violated. Hence no true reduced maximizer can carry that obstruction.

The proof of that conditional lemma is correct. The logical core is:

1. By admissibility, (v(t)) is an admissible comparison path, so the maximizer-level tail-lifting inequality applies.

2. From the “floor supported on the moved tail + target lifts it” clause, one gets
   [
   c_{i^*}(v(t))>c_{i^*}(w^*)
   ]
   for every (t\in(0,\varepsilon]).

3. From the “no spillovers on other rows” clause, one gets
   [
   c_i(v(t))\ge c_i(w^*) \qquad (i\neq i^*).
   ]

4. Since (\tau_{i^*}>0), the left side of tail-lifting is therefore strictly positive.

5. From the aggregate aligned no-loss clause,
   [
   \sum_i \tau_i\big(m_i\cdot w_i^*-m_i\cdot v_i(t)\big)\le 0,
   ]
   so the right side of tail-lifting is nonpositive.

That gives the contradiction. So the sufficiency direction is real, not heuristic.

What is **not** yet bankable is any claim that a general (d_1=e_1)-type obstruction automatically yields such a common-target tail lift. The lemma proved here is only:

[
\text{CTR} \Longrightarrow \text{local no-embedding}.
]

It is **not** a derivation of CTR from the already banked scalar witness, from (\neg(C)), or from the local cone data.

What still looks stronger than ideal, but mathematically sufficient:

* **CTR2** is not used in the contradiction itself. It is bookkeeping tying the path to the (d_1=e_1) witness, but it is not part of the logical engine of the tail-lift contradiction.

* The requirement **(1\in S)** is likewise bookkeeping in the current proof. It helps keep the connection to the column-1 witness visible, but the contradiction only needs a moved set on which the active floor is attained.

* The full rowwise condition
  [
  m_i\cdot \bar w \ge c_i(w^*) \quad \forall i\neq i^*
  ]
  is stronger than needed. For the contradiction, it would be enough to control only rows whose floors can actually be hit by the moved coordinates, or more weakly to guarantee that any negative spillovers are too small to offset the positive (i^*)-gain on the left side of tail-lifting.

* The aggregate aligned no-loss condition
  [
  \sum_{j\in S}\tau_j\big(m_j\cdot \bar w-m_j\cdot w_j^*\big)\ge 0
  ]
  is also stronger than necessary. It forces the right side of tail-lifting to be nonpositive, but one only needs it to be strictly smaller than the positive left side.

* The strict separation
  [
  \inf_{j\in S} m_{i^*}\cdot w_j^*=c_{i^*}(w^*)<\inf_{j\in A} m_{i^*}\cdot w_j^*
  ]
  is stronger than the real target. The proof only needs (c_{i^*}(v(t))>c_{i^*}(w^*)) for small (t). The stated separation is a clean sufficient way to guarantee that.

* The finite-anchor / infinite-tail format is natural for this branch, but also stronger than the pure contradiction needs. Any moved set admitting the same estimates would do.

What remains only heuristic in the prover writeup:

* the sentence that CTR is the “weakest non-tautological” structural hypothesis. That may be plausible, but it is not proved here.

* the suggestion that nothing cleaner can be extracted from the current local cone data. That is a diagnosis, not a theorem.

* any implication from the explicit scalar witness (d_1=e_1) to existence of a common target (\bar w) satisfying CTR outside the settled explicit class.

So the branch has genuinely advanced by one rung: there is now a correct **conditional no-embedding lemma** for a broader common-target class. But the route is still missing the theorem that manufactures CTR from the obstruction.

Suggested next local action: formalize the bankable lemma with only the logically used hypotheses, mark CTR2 and (1\in S) as bookkeeping rather than core, and then try to weaken CTR4 to only those rows whose floors can actually be exposed by the moved tail.
