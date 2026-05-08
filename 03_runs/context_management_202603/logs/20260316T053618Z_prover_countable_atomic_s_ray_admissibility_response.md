On the present branch record, I do **not** have a proof that the canonical obstruction-ray tail
[
S_{\mathrm{ray}}
:=
{j\neq i^*:\text{$j$ is moved at }w^*\text{ and belongs to the same }(d_1=e_1)\text{-obstruction class as }i^*}
]
is an admissible infinite moved tail. The first concrete obstruction is exactly that: the current data identify (S_{\mathrm{ray}}) as the natural candidate tail, but they do **not** verify the admissibility gate itself. The reviewer-cleared diagnosis is explicit that the branch stops at admissibility, before slice-feasibility or support-gap questions even become legitimate.  

What is bankable now is strictly conditional on having an admissible tail (S). First, for any fixed admissible infinite moved tail, the realization problem reduces to the fixed-tail program
[
M_{S,\varepsilon}
=================

\max{\mathcal N(S,w): w\in W,\ m_{i^*}!\cdot w\ge c_{i^*}(w^*)+\varepsilon},
]
and existence of a QNG-feasible common target on that fixed tail is equivalent to existence of some (\varepsilon>0) with (M_{S,\varepsilon}>0). Second, the exposed-safe support criterion is a correct stronger sufficient condition, but only after admissibility is already in hand. 

Also bankable is the bookkeeping patch for the **conditional** analysis of (S_{\mathrm{ray}}): if one assumes (S_{\mathrm{ray}}) admissible, then on the countable-atomic branch the relevant series are uniformly bounded by an (M)-test argument, so
[
\Lambda_{S_{\mathrm{ray}}}
]
is continuous affine and
[
w\mapsto \mathcal N(S_{\mathrm{ray}},w)
]
is continuous and concave on compact (W); compact slices would therefore attain their support functions. This closes the continuity/concavity issue, but it does **not** promote (S_{\mathrm{ray}}) from “natural candidate” to “admissible tail.” 

So the first concrete obstruction is not vague. It is:

[
\boxed{\text{No clause-by-clause proof currently shows that }S_{\mathrm{ray}}\text{ satisfies the branch definition of an admissible infinite moved tail.}}
]

That is the earliest failing gate. Because that gate is still open, it is not legitimate to classify the branch as failing because
[
K_{S_{\mathrm{ray}},\varepsilon}=\varnothing
]
or because
[
h_{K_{S_{\mathrm{ray}},\varepsilon}}(G_{S_{\mathrm{ray}}})\le C_{S_{\mathrm{ray}}}.
]
Those are downstream failure modes, and the reviewer-cleared diagnosis already rules out treating them as the current obstruction. 

So the status is:

* **Bankable:** fixed-tail reduction for any fixed admissible (S); exposed-safe criterion as a stronger sufficient condition; countable-sum continuity/concavity bookkeeping for the concrete (S_{\mathrm{ray}}) setup under the provisional assumption of admissibility.  
* **Only diagnostic:** the geometric appeal of (S_{\mathrm{ray}}) as the class-aligned tail that could reinforce the active obstructing direction, and the conditional statement that, if admissibility were later proved, the next unresolved issue would be slice nonemptiness rather than support-gap failure.  

The crux lemma that would unlock progress is therefore not a support computation but an admissibility lemma: starting from the exact branch definition of “admissible infinite moved tail,” verify (S_{\mathrm{ray}}) clause by clause. At present, that lemma is missing from the record. I am not adding any extra regularity assumptions here; I am only identifying the exact missing proof obligation.

Suggested next local action: write the admissibility definition for infinite moved tails verbatim on the countable-atomic branch and check it clause-by-clause for (S_{\mathrm{ray}}), stopping at the first clause that cannot be proved from the current obstruction data.
