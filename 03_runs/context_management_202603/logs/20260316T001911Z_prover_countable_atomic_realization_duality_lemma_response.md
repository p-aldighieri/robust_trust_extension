## Result for this move

I do **not** see a proof of the full realization/duality implication from the current banked machinery. What can be proved cleanly is a sharp **scalarized necessary condition** for completion. That condition reveals that the remaining gap is genuinely two-step:

1. a **countable duality step** from failure of the transport completion system to a strict tangent-family certificate, and
2. an **infinite-support realization step** from that tangent-family certificate to an actual admissible comparison profile or path that violates the maximizer-level tail-lifting inequality.

This is exactly the seam the packet asks about on the `countable_atomic_direct` branch.   

## 1. The strongest general statement now provable

Write
[
T:=\mathcal T_\infty\cup \mathcal T_{\mathrm{near}},
]
and let
[
\mathcal M(r,J)
:=
\Bigl{\mu=(\mu_{ij})*{i\in T,j\ge1}:
\mu*{ij}\ge 0,;
\mu_{ij}=0\ \text{for }j\notin J_i,;
\sum_{j\ge1}\mu_{ij}=r_i\ \forall i\in T
\Bigr}.
]
The reviewer-cleared reformulation is that completion means:

[
A_j(\mu):=
z_j(\lambda)+(1-\alpha)\sum_{i\in T}\tau_i\mu_{ij}m_i
\in N_j
\qquad\forall j\ge1,
\tag{C}
]
for some (\mu\in\mathcal M(r,J)). 

Let
[
T_j:=T_W(w_j^*)=N_j^\circ
]
be the tangent cone at (w_j^*).
For any finitely supported family (d=(d_j)*{j\ge1}) with (d_j\in T_j), define
[
\Xi(d):=
\sum*{j\ge1} z_j(\lambda)\cdot d_j
+
(1-\alpha)\sum_{i\in T}\tau_i r_i \inf_{j\in J_i} m_i\cdot d_j.
\tag{NC}
]

### Proposition

If completion (C) holds, then
[
\Xi(d)\le 0
\qquad
\text{for every finitely supported }d\text{ with }d_j\in T_j.
\tag{NC}
]

### Proof

Fix feasible (\mu\in\mathcal M(r,J)). Since (A_j(\mu)\in N_j) and (d_j\in T_j=N_j^\circ),
[
d_j\cdot A_j(\mu)\le 0
\qquad\forall j.
]
Because (d) is finitely supported, summing over (j) is legitimate:
[
\sum_j z_j(\lambda)\cdot d_j
+
(1-\alpha)\sum_{i\in T}\tau_i\sum_j \mu_{ij},m_i\cdot d_j
\le 0.
]
Now for each fixed (i),
[
\sum_j \mu_{ij},m_i\cdot d_j
\ge
\Bigl(\sum_j\mu_{ij}\Bigr)\inf_{j\in J_i} m_i\cdot d_j
======================================================

r_i\inf_{j\in J_i} m_i\cdot d_j,
]
because (\mu_{ij}) is supported on (J_i). Substituting gives
[
\sum_j z_j(\lambda)\cdot d_j
+
(1-\alpha)\sum_{i\in T}\tau_i r_i \inf_{j\in J_i} m_i\cdot d_j
\le 0,
]
which is (NC). ∎

So the bankable implication is:
[
(C)\Longrightarrow (NC).
]
This is the strongest **general** consequence of completion I can extract without adding new assumptions. It uses only the reviewer-cleared completion system and normal/tangent cone polarity. 

## 2. How a realization/duality lemma would close the branch

The maximizer-level tail-lifting lemma already banked says that for a true maximizer (w^*),
[
(1-\alpha)\sum_{i\ge1}\tau_i\bigl(c_i(v)-c_i(w^*)\bigr)
\le
\alpha\sum_{i\ge1}\tau_i\bigl(m_i\cdot w_i^*-m_i\cdot v_i\bigr)
\tag{TL}
]
for every feasible comparison profile (v), and likewise along admissible paths. 

Therefore a closure of the direct branch would follow from the following **conditional** package.

### Needed assumption A: countable duality for the completion system

If (C) fails, then there exists a tangent-family (d=(d_j)) with (d_j\in T_j) such that
[
\Xi(d)>0.
\tag{D}
]

This is exactly the missing strong-duality / separation statement for the countable cone-capacitated transport problem.

### Needed assumption B: aggregate tail realization

For every tangent-family (d) with (\Xi(d)>0), there exists an admissible path (w(t)\subset W^{\mathbb N}), (w(0)=w^*), such that
[
\liminf_{t\downarrow0}
\frac{\sum_{i\in T}\tau_i\bigl(c_i(w(t))-c_i(w^*)\bigr)}{t}
\ge
\sum_{i\in T}\tau_i r_i \inf_{j\in J_i} m_i\cdot d_j,
\tag{R-floor}
]
and
[
\limsup_{t\downarrow0}
\frac{\alpha\sum_{i\ge1}\tau_i\bigl(m_i\cdot w_i^*-m_i\cdot w_i(t)\bigr)}{t}
\le
-\sum_{j\ge1} z_j(\lambda)\cdot d_j.
\tag{R-align}
]

Then (D), (R-floor), and (R-align) would force a strict violation of TL-path, contradicting maximality.

So the logic is:

[
\text{failure of }(C)
\overset{\text{A}}{\Longrightarrow}
\Xi(d)>0
\overset{\text{B}}{\Longrightarrow}
\text{admissible path violating TL-path}.
]

This shows very precisely what theorem is missing.

## 3. Why the current banked machinery does **not** supply A or B

This is where the branch genuinely jams.

### 3.1 The duality gap

From the current machinery we only get the forward implication
[
(C)\Longrightarrow (NC).
]
We do **not** get the converse
[
\neg(C)\Longrightarrow \exists d:\Xi(d)>0.
]
That converse is a strong-duality statement for a **countable** transport problem with affine normal-cone constraints. Nothing banked so far proves it.

In finite-dimensional LP land this would feel routine. Here it is not routine at all, because the failure mode can sit in the tail: one can imagine every finitely supported scalar test passing while no global completion exists because transport mass has to keep drifting farther out. I am not asserting such a duality-gap example exists here; I am saying the current banked machinery does not rule it out. No assumption smuggling: this is exactly an unproved step.

### 3.2 The realization gap

Even if a strict tangent-family witness (d) were handed to us, we still need an **actual** path in (W^{\mathbb N}). The reduced objective only constrains genuine feasible comparison profiles, not arbitrary tangent-family data. The earlier tail-lifting note already isolated this mismatch: (\Phi) collapses column geometry into rowwise scalar floors (c_i(w)=\inf_j m_i\cdot w_j), so maximality alone cannot manufacture a profile from failure of the columnwise system (C). 

The embed obstruction makes the same point in neon ink. In its explicit geometry, all finitely supported one-sided perturbations satisfy the banked finite-window directional inequalities, because the untouched tail still pins the infimum. Yet a genuine profitable deviation exists by moving **every** tail coordinate, and that path defeats maximality. So any successful realization lemma has to be an **infinite-support tail-lifting** result; finite-window calculus cannot do the job.  

## 4. How this tests against the reviewer-cleared scoped obstruction

In the reviewer-cleared abstract obstruction, completion fails locally because row (2\in\mathcal T_{\mathrm{near}}) has (J_2={1}), (\lambda=0), and any completion would force a forbidden positive first-coordinate increment at column (1), while (N_1) allows only nonpositive first coordinate. 

For that **specific** obstruction, the dual side is not the real mystery. A finitely supported tangent-family certificate is already staring at us: take (d_1=e_1) and (d_j=0) for (j\neq1). Then the row-2 term contributes positively, while the slack term is zero because (\lambda=0). So the scalarized necessary condition (NC) already fails there.

But that still does **not** close the branch, for exactly the reason the previous embedding attempt exposed: the abstract obstruction was not embedded at a true maximizer. The particular profile used there is not a maximizer because there exists a separate infinite-support floor-lifting path that improves (\Phi).  

So in the reviewer-cleared obstruction the unresolved issue is not “find a finite dual vector.” It is:

* embed the obstruction at an **actual** reduced maximizer (w^*), and
* prove the needed infinite-support realization estimate around that (w^*).

That is the exact obstruction on the scoped branch.

## 5. Bottom line

The realization/duality implication is **not proved** at the requested level of generality.

The strongest bankable statement now is the scalarized necessary condition (NC). It shows that the remaining obstacle is not vague. It is the absence of a **countable duality-plus-realization package**:

* **Duality:** failure of the completion system must yield a strict tangent-family certificate.
* **Realization:** that tangent-family certificate must be integrated into an admissible infinite-support path whose aggregate floor gain beats the aligned loss, hence violates TL-path.

Without those two ingredients, the maximizer-level tail-lifting lemma remains only a “no profitable profile” statement, while the completion system remains a separate columnwise transport problem. The bridge between them is exactly what is missing.  

Suggested next local action: prove the finite-support scalarized converse on a tractable subclass first, namely show that for the reviewer-cleared local obstruction any strict violation of (NC) can be realized by an admissible path around a **true** reduced maximizer, or else exhibit a genuine maximizer with failed completion and all finitely supported scalar tests satisfied.
