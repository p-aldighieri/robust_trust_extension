The first concrete obstruction is now clear, and it occurs strictly before the tail-lifting contradiction.

Let
[
\mathcal N(S,\bar w)
:=
(1-\alpha)\Big(\tau_{i^*}\Delta_*
-\sum_{i\in E_S(w^*)\setminus{i^*}}\tau_i\Gamma_i\Big)
-\alpha\Lambda,
]
with
[
\Delta_*:=m_{i^*}\cdot \bar w-c_{i^*}(w^*),\qquad
\Gamma_i:=[c_i(w^*)-m_i\cdot \bar w]*+,\qquad
\Lambda:=\sum*{j\in S}\tau_j\big(m_j\cdot w_j^*-m_j\cdot \bar w\big).
]
The reviewer-cleared QNG lemma already gives the back end: if there exist an admissible infinite moved tail (S) and a common target (\bar w\in W) such that
[
\Delta_*>0
\quad\text{and}\quad
\mathcal N(S,\bar w)>0,
]
then the tail-lifting inequality is violated for all sufficiently small (t>0), so the obstruction cannot live at a true reduced maximizer. That part is banked.

What is *not* banked, and is in fact the first live obstruction beyond the explicit class, is the realization of such an ((S,\bar w)). More sharply, the unresolved step splits into two sub-obstructions:

[
\text{(G)}\qquad
\exists,\bar w\in W\ \text{with}\ m_{i^*}\cdot \bar w>c_{i^*}(w^*)
]
for some admissible infinite tail (S), and

[
\text{(S)}\qquad
\sup_{\bar w\in W:,m_{i^*}\cdot \bar w>c_{i^*}(w^*)}\mathcal N(S,\bar w)>0.
]

Here (G) is the geometric feasibility of a common target that genuinely lifts the active floor, and (S) is the first-order sign condition after exposed-row penalties and aligned loss are priced in. The current zero-order obstruction record yields neither.

This is the right place to stop. The present inputs are still only:

[
\text{scalarized obstruction data} ;+; (d_1=e_1)\text{-type finite witness at }\lambda=0 ;+; \text{maximizer-level tail-lifting inequality}.
]

Those objects can kill a configuration once a good path is already in hand, but they do not manufacture the path data needed by QNG. In particular, beyond the settled explicit class they do not produce:

[
\text{(i) an admissible infinite moved tail }S,
]
[
\text{(ii) a common target }\bar w\in W\text{ with }\Delta_*>0,
]
or
[
\text{(iii) the strict sign }\mathcal N(S,\bar w)>0.
]

So the answer to the present move is negative: there is no bankable realization lemma yet beyond the explicit class.

There is, however, one useful local reduction that is now safe to treat as bankable. For each *fixed* admissible infinite tail (S), define
[
V(S):=\sup_{\bar w\in W,;m_{i^*}\cdot \bar w>c_{i^*}(w^*)}\mathcal N(S,\bar w).
]
Because (W) is compact and convex and (\bar w\mapsto\mathcal N(S,\bar w)) is continuous and concave, (V(S)) is a well-posed finite-dimensional target program. Thus the missing lemma has been reduced exactly to:

[
\exists\ \text{admissible infinite moved tail }S\ \text{such that}\ V(S)>0.
]

That reduction is stronger than a slogan and weaker than a theorem: it tells us the branch has narrowed to a tail-selection problem coupled with a concave target program, but it does not solve either part.

What is now bankable:

The explicit scoped class is dead by a genuine tail-lift contradiction.

The naive exposed-row-only pointwise weakening is false.

The QNG lemma is a correct conditional export lemma on the countable-atomic direct branch.

The real contradiction engine is:
[
\text{active linear gain }+\text{ exposed-row linear loss control }+\text{ non-exposed }o(t)\text{ tail control }-\text{ aligned linear loss}.
]

The unresolved issue is exactly the existence of an admissible infinite moved tail (S) for which the concave target program (V(S)) is positive.

What remains only diagnostic:

Any claim that the current ((d_1=e_1))-type obstruction data automatically identify such an (S).

Any claim that they automatically identify a common target (\bar w).

Any claim that they determine the sign of (V(S)), equivalently of (\mathcal N(S,\bar w)) at an optimizer.

Needed assumption / crux lemma: some structural bridge from the zero-order obstruction witness to a tail (S) on which the active row can be lifted by a common target with enough uniform advantage to dominate both the exposed deficits
[
\sum_{i\in E_S(w^*)\setminus{i^*}}\tau_i\Gamma_i
]
and the aligned-loss term
[
\Lambda.
]
Without such a bridge, the direct route does not advance beyond the current obstruction.

Suggested next local action: fix an admissible infinite tail (S) candidate and attack the finite-dimensional concave program (V(S)=\sup_{\bar w\in W,;m_{i^*}\cdot\bar w>c_{i^*}(w^*)}\mathcal N(S,\bar w)); either prove (V(S)\le 0) for all admissible (S) from current obstruction data, or isolate the additional structural hypothesis on (w^*) and the normals (m_i) that would force some (V(S)>0).