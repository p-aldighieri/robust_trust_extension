## Local no-embedding result on the scoped explicit class

On the explicit (d_1=e_1) witness geometry already banked, a true reduced maximizer cannot carry the obstruction. The dual side is already settled: the reviewer-cleared record says the finite scalar witness (d_1=e_1) is in hand, row (2) is the relevant near row with (J_2={1}), and completion fails because any completion would force a forbidden positive first-coordinate increment at column (1). The remaining issue was purely realization at a genuine maximizer.  

Write
[
c_i(w):=\inf_{j\ge 1} m_i\cdot w_j.
]
On the explicit scoped class,
[
W={(x,0):0\le x\le 1},\qquad m_2=e_1,\qquad m_i=e_2\ \ (i\neq 2).
]
Hence every feasible profile is (w_j=(x_j,0)) with (x_j\in[0,1]), every row (i\neq 2) is completely silent, and the reduced objective collapses to
[
\Phi(w)=\tau_2\Big[\alpha x_2+(1-\alpha)\inf_{j\ge 1}x_j\Big].
]
So there is only one economically active row, row (2). Its aligned piece wants (x_2) high; its robust piece wants the global floor (\inf_j x_j) high. 

Now suppose (w^*=(w_j^*)) is a true reduced maximizer in this explicit class and still carries the obstruction geometry. Then necessarily
[
w_j^*=(x_j^*,0),\qquad x_2^*=1,\qquad s:=\inf_{j\ge 1}x_j^*<1.
]
This includes the concrete obstruction profile already exhibited earlier,
[
x_1^*=0,\qquad x_2^*=1,\qquad x_n^*=\frac1{n-1}\ \ (n\ge 3),
]
for which (s=0). Define the admissible infinite-support path
[
v_2(t):=w_2^*,\qquad
v_j(t):=(1-t)w_j^*+t(1,0)\quad (j\neq 2),\qquad t\in[0,1].
]
Because (W) is the line segment ({(x,0):0\le x\le 1}), this path stays in (W^{\mathbb N}). 

Along this path,
[
c_2(v(t))=\inf_j e_1\cdot v_j(t)=t+(1-t)s,
]
since (e_1\cdot v_2(t)=1) and (e_1\cdot v_j(t)=t+(1-t)x_j^*) for (j\neq 2). Therefore
[
c_2(v(t))-c_2(w^*)=t(1-s)>0.
]
For every (i\neq 2),
[
c_i(v(t))=0=c_i(w^*),
]
because (m_i=e_2) and every feasible vector in (W) has second coordinate (0). Also the aligned terms do not fall:
[
m_2\cdot v_2(t)=m_2\cdot w_2^*=1,
\qquad
m_i\cdot v_i(t)=m_i\cdot w_i^*=0\ \ (i\neq 2).
]
So the tail-lifting inequality that every true reduced maximizer must satisfy,
[
(1-\alpha)\sum_i \tau_i\big(c_i(v)-c_i(w^*)\big)
\le
\alpha\sum_i \tau_i\big(m_i\cdot w_i^*-m_i\cdot v_i\big),
]
reduces here to
[
(1-\alpha)\tau_2, t(1-s)\le 0.
]
In the nontrivial obstruction regime (0\le \alpha<1), with (\tau_2>0), this is impossible. Hence no true reduced maximizer can satisfy (x_2^*=1) and (\inf_j x_j^*<1). In particular, the explicit obstruction profile cannot be a maximizer.  

There is an even stronger restatement. For (0\le \alpha<1),
[
\Phi(w)\le \tau_2[\alpha\cdot 1+(1-\alpha)\cdot 1]=\tau_2,
]
with equality iff (x_2=1) and (\inf_j x_j=1). Since every (x_j\le 1), the latter is equivalent to
[
x_j=1\qquad \forall j.
]
So on this explicit class the unique true reduced maximizer is the constant profile
[
w_j\equiv (1,0).
]
That profile has no tail touching the row-(2) floor, no local singleton-floor obstruction of the earlier type, and no role for the witness (d_1=e_1). The obstruction geometry is therefore not embeddable at a true maximizer on this class. 

This isolates the exact maximizer-specific mechanism. It is not another columnwise cone condition. It is the requirement that a true maximizer be stable against **infinite-support zero-aligned-cost tail lifts** that raise the active row’s floor. The scalar witness (d_1=e_1) is only the local shadow of that motion: in the explicit obstruction profile one has (v_1'(0)=e_1), but the profitable part is the synchronized movement of infinitely many other columns, which finite-window tests do not see. That is exactly why the obstruction could pass all banked finitely supported checks and still fail true maximality. 

Needed assumption for any broader extrapolation beyond this explicit class: one must be able to realize the local witness by an admissible infinite-support path that strictly increases the relevant floor term while creating no compensating aligned loss. On the scoped explicit class this realizability holds with target ((1,0)), so the local embedding issue is fully resolved here.

Suggested next local action: formalize the argument above as a local no-embedding lemma of the form “tail-lift realizability of the (d_1=e_1) witness implies non-maximality,” then test exactly which remaining (d_1=e_1) obstruction configurations satisfy that realizability hypothesis.
