## Admissibility definition

On the current accessible record, I cannot state the admissibility definition for an infinite moved tail **verbatim**. The packet requires that exact branch definition, and it specifically points to `countable_atomic_direct_route.md` as the source to refresh before doing the clause audit, but that branch memo is not among the accessible materials surfaced in this chat. So the very first required input to the audit is missing from the present record. 

## Clause audit for (S_{\mathrm{ray}})

The canonical candidate under review is
[
S_{\mathrm{ray}}
:=
{j\neq i^*:\text{$j$ is moved at }w^*\text{ and lies in the same }(d_1=e_1)\text{-obstruction class as }i^*}.
]
This identification of the candidate tail is bankable on the present record. 

### Preliminary prerequisite: exact branch definition available

**Status:** unproved on the current record.

Reason: the reviewer-cleared next step is precisely to “write the admissibility definition for infinite moved tails verbatim on the countable-atomic direct branch and check (S_{\mathrm{ray}}) clause by clause,” and the reviewer also states that the current record still lacks the missing clause-by-clause verification of admissibility. That is, admissibility itself is the first live hinge, not any downstream slice or support-gap question.  

Because that prerequisite fails, I have to stop here. I cannot honestly mark any actual admissibility clause for (S_{\mathrm{ray}}) as proved, unproved, or false without first having the exact branch definition in hand.

## What is bankable now

For any **fixed admissible** infinite moved tail (S), the fixed-tail reduction is valid:
[
M_{S,\varepsilon}
=================

\max{\mathcal N(S,w): w\in W,\ m_{i^*}!\cdot w\ge c_{i^*}(w^*)+\varepsilon},
]
and the exposed-safe support test is a stronger sufficient criterion on that fixed-tail branch. But every one of those statements is explicitly conditional on (S) already being admissible. 

For the specific canonical tail (S_{\mathrm{ray}}), the countable-atomic bookkeeping patch is also bankable **only provisionally**: under the assumption that (S_{\mathrm{ray}}) is admissible, the relevant countable sums are uniformly controlled, (\Lambda_{S_{\mathrm{ray}}}) is continuous affine, and (w\mapsto \mathcal N(S_{\mathrm{ray}},w)) is continuous and concave on compact (W), so compact slices attain support values. Again, that does **not** prove admissibility.  

## What is only diagnostic, not bankable

It is **not** bankable that (S_{\mathrm{ray}}) is an admissible infinite moved tail. It is likewise premature to test either
[
K_{S_{\mathrm{ray}},\varepsilon}=\varnothing
]
or any support-gap inequality such as
[
h_{K_{S_{\mathrm{ray}},\varepsilon}}(G_{S_{\mathrm{ray}}})\le C_{S_{\mathrm{ray}}}.
]
Those are downstream only after admissibility is actually established.  

Suggested next local action: attach or quote the exact admissibility definition from `countable_atomic_direct_route.md`, then rerun the (S_{\mathrm{ray}}) audit clause by clause and stop at the first clause that fails on the record.
