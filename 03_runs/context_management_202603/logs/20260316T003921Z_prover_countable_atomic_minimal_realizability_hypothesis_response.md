I’m consolidating the prompt and the three support notes to separate what is already banked from what still needs a bridge, while testing whether a truly local minimal realizability hypothesis suffices or a concrete obstruction remains.I’m also checking the durable proof state, aiming to either bank the minimal realizability hypothesis or isolate the first concrete obstruction.Bankable starting point
On this scoped countable-atomic direct branch, the banked picture is now sharp.


Completion implies the scalarized necessary condition (NC) for every finitely supported tangent family:


Ξ(d):=∑jzj(λ) ⁣⋅dj+(1−α)∑i∈Tτiriinf⁡j∈Jimi ⁣⋅dj≤0.\Xi(d):=\sum_j z_j(\lambda)\!\cdot d_j+(1-\alpha)\sum_{i\in T}\tau_i r_i \inf_{j\in J_i} m_i\!\cdot d_j \le 0.Ξ(d):=j∑​zj​(λ)⋅dj​+(1−α)i∈T∑​τi​ri​j∈Ji​inf​mi​⋅dj​≤0.


Every true reduced maximizer w∗w^*w∗ satisfies the tail-lifting inequality


(1−α)∑iτi(ci(v)−ci(w∗))≤α∑iτi(mi ⁣⋅wi∗−mi ⁣⋅vi)(1-\alpha)\sum_i \tau_i\big(c_i(v)-c_i(w^*)\big)\le \alpha\sum_i \tau_i\big(m_i\!\cdot w_i^*-m_i\!\cdot v_i\big)(1−α)i∑​τi​(ci​(v)−ci​(w∗))≤αi∑​τi​(mi​⋅wi∗​−mi​⋅vi​)
along every admissible infinite-support comparison path vvv.


For the scoped obstruction, the dual witness is already explicit:


d1=e1,dj=0  (j≠1).d_1=e_1,\qquad d_j=0\ \ (j\neq 1).d1​=e1​,dj​=0  (j=1).
So on that obstruction the live gap is not duality; it is realization of an actual admissible path that turns the local witness into a true tail lift. 


On the settled explicit class, that realization step is now fully banked: a synchronized move toward a common target raises the active floor, leaves all other floors unchanged, creates no aligned loss, and therefore contradicts maximality. In that class the obstruction cannot embed at a true maximizer, and the unique true reduced maximizer is the constant profile.  


So the right local question is exactly the one in the prompt: what extra realizability input is enough to export that contradiction one notch beyond the explicit class?
The literally minimal extra input
The exact missing input is:

Path-realizability: there exists an admissible infinite-support path v(t)v(t)v(t) from w∗w^*w∗ such that
∑iτi(ci(v(t))−ci(w∗))>0and∑iτi(mi ⁣⋅wi∗−mi ⁣⋅vi(t))≤0\sum_i \tau_i\big(c_i(v(t))-c_i(w^*)\big)>0
\quad\text{and}\quad
\sum_i \tau_i\big(m_i\!\cdot w_i^*-m_i\!\cdot v_i(t)\big)\le 0i∑​τi​(ci​(v(t))−ci​(w∗))>0andi∑​τi​(mi​⋅wi∗​−mi​⋅vi​(t))≤0
for some t>0t>0t>0.

This is truly minimal, but it is tautological: it just restates the missing bridge from the witness to a contradiction of (TL).
So the first non-tautological local structural hypothesis I can isolate is the following.
Needed assumption: common-target tail-lift realizability (CTR)
Fix a true reduced maximizer w∗=(wj∗)j≥1w^*=(w_j^*)_{j\ge 1}w∗=(wj∗​)j≥1​, and let i∗i^*i∗ be the obstructing row selected by the banked d1=e1d_1=e_1d1​=e1​-type witness. Assume τi∗>0\tau_{i^*}>0τi∗​>0.
There exist:


a finite anchor set A⊂NA\subset \mathbb NA⊂N,


an infinite moved tail S:=N∖AS:=\mathbb N\setminus AS:=N∖A with 1∈S1\in S1∈S,


a target point wˉ∈W\bar w\in Wwˉ∈W,


and ε>0\varepsilon>0ε>0,


such that for
vj(t):={wj∗,j∈A,(1−t)wj∗+twˉ,j∈S,t∈[0,ε],v_j(t):=
\begin{cases}
w_j^*, & j\in A,\\[2mm]
(1-t)w_j^*+t\bar w, & j\in S,
\end{cases}
\qquad t\in[0,\varepsilon],vj​(t):=⎩⎨⎧​wj∗​,(1−t)wj∗​+twˉ,​j∈A,j∈S,​t∈[0,ε],
the following hold.
(CTR1) Admissibility
For every t∈[0,ε]t\in[0,\varepsilon]t∈[0,ε], v(t)∈WNv(t)\in W^{\mathbb N}v(t)∈WN.
(CTR2) Witness compatibility at column 111
e1⋅(wˉ−w1∗)>0.e_1\cdot(\bar w-w_1^*)>0.e1​⋅(wˉ−w1∗​)>0.
This is the bookkeeping clause that ties the realized path to the d1=e1d_1=e_1d1​=e1​ local witness.
(CTR3) The obstructing row’s floor is supported on the moved tail and the target lifts it
inf⁡j∈Smi∗⋅wj∗=ci∗(w∗)<inf⁡j∈Ami∗⋅wj∗,\inf_{j\in S} m_{i^*}\cdot w_j^* = c_{i^*}(w^*)
< \inf_{j\in A} m_{i^*}\cdot w_j^*,j∈Sinf​mi∗​⋅wj∗​=ci∗​(w∗)<j∈Ainf​mi∗​⋅wj∗​,
and
mi∗⋅wˉ>ci∗(w∗).m_{i^*}\cdot \bar w > c_{i^*}(w^*).mi∗​⋅wˉ>ci∗​(w∗).
(CTR4) No floor spillovers on other rows
For every i≠i∗i\neq i^*i=i∗,
mi⋅wˉ≥ci(w∗).m_i\cdot \bar w \ge c_i(w^*).mi​⋅wˉ≥ci​(w∗).
(CTR5) No aggregate aligned loss
∑j∈Sτj(mj⋅wˉ−mj⋅wj∗)≥0.\sum_{j\in S}\tau_j\big(m_j\cdot \bar w - m_j\cdot w_j^*\big)\ge 0.j∈S∑​τj​(mj​⋅wˉ−mj​⋅wj∗​)≥0.
This is weaker than pointwise no-loss on each moved coordinate and is exactly what the right-hand side of (TL) needs.
Local proof sketch under CTR
Assume w∗w^*w∗ is a true reduced maximizer carrying a d1=e1d_1=e_1d1​=e1​-type obstruction, and assume (CTR).
For the obstructing row i∗i^*i∗, by (CTR3):
inf⁡j∈Smi∗⋅vj(t)=inf⁡j∈S((1−t)mi∗⋅wj∗+t mi∗⋅wˉ)≥(1−t)ci∗(w∗)+t mi∗⋅wˉ>ci∗(w∗).\inf_{j\in S} m_{i^*}\cdot v_j(t)
=
\inf_{j\in S}\big((1-t)m_{i^*}\cdot w_j^* + t\, m_{i^*}\cdot \bar w\big)
\ge
(1-t)c_{i^*}(w^*) + t\, m_{i^*}\cdot \bar w
>
c_{i^*}(w^*).j∈Sinf​mi∗​⋅vj​(t)=j∈Sinf​((1−t)mi∗​⋅wj∗​+tmi∗​⋅wˉ)≥(1−t)ci∗​(w∗)+tmi∗​⋅wˉ>ci∗​(w∗).
Also, for j∈Aj\in Aj∈A, mi∗⋅vj(t)=mi∗⋅wj∗> ⁣ci∗(w∗)m_{i^*}\cdot v_j(t)=m_{i^*}\cdot w_j^*>\!c_{i^*}(w^*)mi∗​⋅vj​(t)=mi∗​⋅wj∗​>ci∗​(w∗). Hence
ci∗(v(t))>ci∗(w∗)for every t∈(0,ε].c_{i^*}(v(t))>c_{i^*}(w^*)
\qquad\text{for every }t\in(0,\varepsilon].ci∗​(v(t))>ci∗​(w∗)for every t∈(0,ε].
For any other row i≠i∗i\neq i^*i=i∗, if j∈Sj\in Sj∈S, then by definition of the floor and (CTR4):
mi⋅wj∗≥ci(w∗),mi⋅wˉ≥ci(w∗),m_i\cdot w_j^*\ge c_i(w^*),\qquad m_i\cdot \bar w\ge c_i(w^*),mi​⋅wj∗​≥ci​(w∗),mi​⋅wˉ≥ci​(w∗),
so
mi⋅vj(t)≥ci(w∗).m_i\cdot v_j(t)\ge c_i(w^*).mi​⋅vj​(t)≥ci​(w∗).
For j∈Aj\in Aj∈A, nothing changes. Therefore
ci(v(t))≥ci(w∗)(i≠i∗).c_i(v(t))\ge c_i(w^*)\qquad (i\neq i^*).ci​(v(t))≥ci​(w∗)(i=i∗).
Thus the left-hand side of (TL) is strictly positive:
(1−α)∑iτi(ci(v(t))−ci(w∗))≥(1−α)τi∗(ci∗(v(t))−ci∗(w∗))>0.(1-\alpha)\sum_i \tau_i\big(c_i(v(t))-c_i(w^*)\big)
\ge
(1-\alpha)\tau_{i^*}\big(c_{i^*}(v(t))-c_{i^*}(w^*)\big)
>0.(1−α)i∑​τi​(ci​(v(t))−ci​(w∗))≥(1−α)τi∗​(ci∗​(v(t))−ci∗​(w∗))>0.
Now look at the aligned part. Since anchored coordinates do not move,
∑iτi(mi⋅wi∗−mi⋅vi(t))=t∑j∈Sτj(mj⋅wj∗−mj⋅wˉ)≤0\sum_i \tau_i\big(m_i\cdot w_i^* - m_i\cdot v_i(t)\big)
=
t\sum_{j\in S}\tau_j\big(m_j\cdot w_j^* - m_j\cdot \bar w\big)
\le 0i∑​τi​(mi​⋅wi∗​−mi​⋅vi​(t))=tj∈S∑​τj​(mj​⋅wj∗​−mj​⋅wˉ)≤0
by (CTR5). Hence the right-hand side of (TL) is nonpositive.
So (TL) is violated:
strictly positive≤nonpositive,\text{strictly positive} \le \text{nonpositive},strictly positive≤nonpositive,
a contradiction. Therefore no true reduced maximizer can carry a d1=e1d_1=e_1d1​=e1​-type obstruction once (CTR) holds.
That reproduces the explicit-class contradiction on a strictly broader local class.
Why this is close to minimal, and why nothing cleaner is currently bankable
The genuinely important point is that the d1=e1d_1=e_1d1​=e1​ witness is only a local scalar shadow. (TL) is not a tangent inequality; it is an inequality about actual feasible infinite-support paths.
So three things must be controlled, and none of them follows from the current banked inputs alone:


Tail support of the relevant floor.
A lift at column 111 means nothing if the obstructing floor ci∗(w∗)c_{i^*}(w^*)ci∗​(w∗) is actually determined by other columns that are left untouched. This is why some version of (CTR3) is unavoidable.


Safety for the other floors.
A common target can raise the i∗i^*i∗-floor and still lower some other iii-floor. This is why some version of (CTR4) is unavoidable.


Control of aligned loss.
Even if the floor rises, the aligned terms can move against you and absorb the gain. This is why some version of (CTR5) is unavoidable.


This is the first concrete reason no cleaner hypothesis follows from the current banked inputs: a condition stated only in terms of the local witness at column 111, or only in terms of Ji∗J_{i^*}Ji∗​, does not tell us who carries the relevant infimum, whether synchronized lifting is feasible in WWW, or whether the move is safe on the other rows.
So:


the exact minimal extra input is path-realizability itself;


the weakest non-tautological structural hypothesis I can presently isolate is (CTR) or a near-equivalent reformulation of it.


What is bankable vs still conjectural
Bankable now


(C)\Rightarrow(NC) is proved.


True reduced maximizers satisfy (TL) along admissible infinite-support paths.


For the scoped obstruction, the dual witness d1=e1d_1=e_1d1​=e1​ is already in hand.


On the explicit class, the obstruction is not embeddable at a true maximizer because tail-lift realizability is verified directly.  


Still conjectural


That every d1=e1d_1=e_1d1​=e1​-type obstruction automatically satisfies (CTR).


That a strictly weaker criterion than (CTR) can be read off from the current local cone data alone.


Any general theorem turning ¬(C)\neg(C)¬(C) into an explicit realizable tail path beyond the already settled explicit class.


Suggested next local action: formalize (CTR) as a lemma “common-target tail-lift realizability implies local no-embedding for a d1=e1d_1=e_1d1​=e1​-type obstruction,” then test the weakest replaceable clauses, starting with whether (CTR4) can be weakened from all rows to only those rows whose floors can be hit by the moved tail.
