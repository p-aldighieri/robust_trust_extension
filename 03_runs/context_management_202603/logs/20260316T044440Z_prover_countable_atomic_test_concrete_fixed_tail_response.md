## Concrete candidate tail

Take the canonical obstruction-ray tail
[
S_{\mathrm{ray}}
:=
\Big{j\neq i^*:\ \text{$j$ is moved at }w^*\text{ and belongs to the same }(d_1=e_1)\text{-obstruction class as }i^*\Big}.
]
This is the most plausible single fixed tail suggested by the current geometry: it keeps exactly the rows whose moved contribution points in the active obstructing direction, so it is the natural first place where the aligned-tail vector (\sum_{j\in S}\tau_j m_j) could reinforce the active row rather than dilute it.

I am **not** claiming that the current record proves (S_{\mathrm{ray}}) is an admissible infinite moved tail. In fact, the reviewer-cleared diagnosis says that, beyond the explicit class, the present zero-order obstruction data do **not** yet manufacture any admissible infinite moved tail, and in particular it remains only diagnostic, not proved, that the present ((d_1=e_1))-type obstruction data yield such an (S).

## Uniform-convergence / concavity bookkeeping

Now suppose provisionally that (S_{\mathrm{ray}}) is admissible. Write
[
E:=E_{S_{\mathrm{ray}}}(w^*)\setminus{i^*},
]
and use the fixed-tail definitions
[
\Lambda_{S_{\mathrm{ray}}}(w)=\sum_{j\in S_{\mathrm{ray}}}\tau_j\big(m_j!\cdot! w_j^*-m_j!\cdot! w\big),
\qquad
\mathcal N(S_{\mathrm{ray}},w)
==============================

G_{S_{\mathrm{ray}}}!\cdot! w-C_{S_{\mathrm{ray}}}
-(1-\alpha)\sum_{i\in E}\tau_i[c_i(w^*)-m_i!\cdot! w]_+.
]
These are exactly the fixed-tail objects already isolated on the branch.

Let
[
R:=\sup_{u\in W}|u|*\infty<\infty,
]
which is finite because (W) is compact. Since each posterior row (m_j) lies in the simplex, (|m_j|*1=1), so for all (u,v\in W),
[
|m_j\cdot(u-v)|\le |m_j|*1,|u-v|*\infty\le 2R.
]
Hence
[
|m_j\cdot w_j^*-m_j\cdot w|\le 2R
\qquad (j\in S*{\mathrm{ray}},\ w\in W).
]
Also, using the standing meaning of (c_i(w^*)) as the row-(i) floor generated from (W), one has (|c_i(w^*)|\le R), and therefore
[
0\le [c_i(w^*)-m_i\cdot w]*+\le 2R
\qquad (i\in E,\ w\in W).
]
Because we are on the countable-atomic branch, (\sum_{j\in S_{\mathrm{ray}}}\tau_j\le 1) and (\sum_{i\in E}\tau_i\le 1). The Weierstrass (M)-test therefore gives absolute and uniform convergence on (W) of both series
[
\sum_{j\in S_{\mathrm{ray}}}\tau_j\big(m_j\cdot w_j^*-m_j\cdot w\big),
\qquad
\sum_{i\in E}\tau_i[c_i(w^*)-m_i\cdot w]*+.
]
So (\Lambda*{S_{\mathrm{ray}}}) is continuous affine, the exposed-row penalty term is continuous convex, and (w\mapsto \mathcal N(S_{\mathrm{ray}},w)) is continuous and concave on (W). If (K_{S_{\mathrm{ray}},\varepsilon}\neq\varnothing), then it is compact and (h_{K_{S_{\mathrm{ray}},\varepsilon}}(G_{S_{\mathrm{ray}}})) is attained. This is the bookkeeping patch the reviewer explicitly asked to make written-out on the countable-atomic branch.

## Test of the stronger exposed-safe criterion on (S_{\mathrm{ray}})

For (\varepsilon>0), the stronger criterion asks first whether
[
K_{S_{\mathrm{ray}},\varepsilon}
================================

{w\in W:\ m_{i^*}\cdot w\ge c_{i^*}(w^*)+\varepsilon,\ \ m_i\cdot w\ge c_i(w^*)\ \forall i\in E}
]
is nonempty, and then whether
[
h_{K_{S_{\mathrm{ray}},\varepsilon}}(G_{S_{\mathrm{ray}}})>C_{S_{\mathrm{ray}}}.
]
If both held, the exposed-safe lemma would immediately yield a QNG-feasible common target on this fixed tail.

On the **present banked record**, this test does **not** go through. The precise first failure is

[
\boxed{\text{prior defect in the candidate tail itself}.}
]

Reason: the current record still does not prove that (S_{\mathrm{ray}}) is an admissible infinite moved tail at all. That defect occurs before the exposed-safe slice is legitimately available for testing. So I cannot honestly classify the failure as
[
K_{S_{\mathrm{ray}},\varepsilon}=\varnothing
]
or as
[
h_{K_{S_{\mathrm{ray}},\varepsilon}}(G_{S_{\mathrm{ray}}})\le C_{S_{\mathrm{ray}}};
]
those are later failure modes, and we are stopped one gate earlier.

There is still a useful conditional diagnosis. **If** future work proves that (S_{\mathrm{ray}}) is admissible, then the next unresolved subtest is slice feasibility, not the support gap. The current record does not yet provide any (w\in W) that raises the active floor while keeping every exposed row above its floor, so the branch has not even reached the support comparison (h_K(G_S)>C_S). In that conditional sense, the next live obstruction would be “slice nonemptiness not established,” not “support-gap failure.”

## What is bankable and what remains conjectural

Bankable now: for any **fixed admissible** countable tail, the fixed-tail reduction is valid; the stronger exposed-safe support criterion is a correct sufficient condition; and the countable-sum bookkeeping can be closed explicitly with uniform convergence and attainment on compact slices.

Still conjectural: that the canonical (d_1=e_1) obstruction-ray candidate (S_{\mathrm{ray}}) is actually an admissible infinite moved tail, and then that some (\varepsilon>0) makes (K_{S_{\mathrm{ray}},\varepsilon}\neq\varnothing). The present obstruction notes explicitly say those front-end realizations are not yet produced by the current data.

Suggested next local action: isolate and prove or refute the admissibility of the canonical (d_1=e_1) moved tail (S_{\mathrm{ray}}); only if that succeeds should the next pass test (K_{S_{\mathrm{ray}},\varepsilon}\neq\varnothing) before any support-gap computation.
