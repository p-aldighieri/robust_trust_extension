I’m consolidating the target note, reviewer packets, and durable proof-state into one picture to decide whether the existential replacement lemma is genuinely proved or exactly where it fails.The issue is now isolated to the reduced objective—an aligned linear term plus rowwise minima—and whether a maximizer yields a countably additive selector on the true tie sets with column aggregates giving supporting normals.I’m now testing a concrete positive route: derive the honest kernel from a finite-coordinate variational inequality, then patch it by compactness/minimax rather than proving every supergradient is representable.The exact minimal existential replacement lemma is not yet proved on the current record. What is provable directly on the countable-atomic direct branch is a sharp relaxed version, and the proof now stalls at a single tail/no-mass-at-infinity completion step. This matches the reviewer-cleared status: the finite obstruction does not kill existence, the phantom-support counterexample is not bankable, and the live bottleneck is exactly the countably additive replacement step on actual tie sets.    
Fix the countable atomic support M={mj}j∈IM=\{m_j\}_{j\in I}M={mj​}j∈I​ with I=NI=\mathbb NI=N, weights τj>0\tau_j>0τj​>0, the compact convex payoff set W⊂RNW\subset \mathbb R^NW⊂RN from the Appendix A.1 reduction, and the reduced objective
R(w):=α∑j∈Iτj mj⋅wj+(1−α)∑i∈Iτi ϕi(w),ϕi(w):=inf⁡j∈Imi⋅wj,R(w):=\alpha\sum_{j\in I}\tau_j\, m_j\cdot w_j +(1-\alpha)\sum_{i\in I}\tau_i\,\phi_i(w),
\qquad
\phi_i(w):=\inf_{j\in I} m_i\cdot w_j,R(w):=αj∈I∑​τj​mj​⋅wj​+(1−α)i∈I∑​τi​ϕi​(w),ϕi​(w):=j∈Iinf​mi​⋅wj​,
for w=(wj)j∈I∈WIw=(w_j)_{j\in I}\in W^Iw=(wj​)j∈I​∈WI. Let w∗=(wj∗)w^*=(w_j^*)w∗=(wj∗​) be a reduced maximizer. For each row iii, write
Ji:=arg⁡min⁡j∈I(mi⋅wj∗),J_i:=\arg\min_{j\in I}(m_i\cdot w_j^*),Ji​:=argj∈Imin​(mi​⋅wj∗​),
possibly empty. For each on-path jjj, write Nj:=NW(wj∗)N_j:=N_W(w_j^*)Nj​:=NW​(wj∗​). This is exactly the reduced certification problem tied to Theorem 2 / robust rationalizability.  
Bankable partial result: a relaxed supporting kernel exists
Proposition. There exists a matrix λ=(λij)i,j∈I\lambda=(\lambda_{ij})_{i,j\in I}λ=(λij​)i,j∈I​ such that


λij≥0\lambda_{ij}\ge 0λij​≥0 for all i,ji,ji,j,


λij=0\lambda_{ij}=0λij​=0 whenever j∉Jij\notin J_ij∈/Ji​,


∑jλij≤1\sum_{j}\lambda_{ij}\le 1∑j​λij​≤1 for every iii,


for every on-path jjj,


aj(λ):=ατjmj+(1−α)∑iτiλijmi∈Nj.a_j(\lambda):=\alpha\tau_j m_j +(1-\alpha)\sum_i \tau_i\lambda_{ij}m_i \in N_j.aj​(λ):=ατj​mj​+(1−α)i∑​τi​λij​mi​∈Nj​.
Moreover, if JiJ_iJi​ is finite and nonempty, then automatically ∑jλij=1\sum_j \lambda_{ij}=1∑j​λij​=1. So any deficit can occur only on rows with JiJ_iJi​ infinite or empty.
Proof
Step 1. Finite-window first-order inequality
Fix a finite set F⊂IF\subset IF⊂I. For each j∈Fj\in Fj∈F, choose xj∈Wx_j\in Wxj​∈W and set
dj:=xj−wj∗,dj:=0 for j∉F.d_j:=x_j-w_j^*,
\qquad
d_j:=0 \text{ for } j\notin F.dj​:=xj​−wj∗​,dj​:=0 for j∈/F.
Define a feasible path
wjt={(1−t)wj∗+txj,j∈F,wj∗,j∉F,t∈[0,1].w_j^t=
\begin{cases}
(1-t)w_j^*+t x_j,& j\in F,\\
w_j^*,& j\notin F,
\end{cases}
\qquad t\in[0,1].wjt​={(1−t)wj∗​+txj​,wj∗​,​j∈F,j∈/F,​t∈[0,1].
Since w∗w^*w∗ maximizes RRR, we have R(wt)≤R(w∗)R(w^t)\le R(w^*)R(wt)≤R(w∗) for all t∈[0,1]t\in[0,1]t∈[0,1].
Fix row iii, and write ci:=ϕi(w∗)=inf⁡jmi⋅wj∗c_i:=\phi_i(w^*)=\inf_j m_i\cdot w_j^*ci​:=ϕi​(w∗)=infj​mi​⋅wj∗​.
For each j∈F∖Jij\in F\setminus J_ij∈F∖Ji​, the gap
γij:=mi⋅wj∗−ci\gamma_{ij}:=m_i\cdot w_j^*-c_iγij​:=mi​⋅wj∗​−ci​
is strictly positive. Since FFF is finite, the minimum of those positive gaps is positive whenever F∖Ji≠∅F\setminus J_i\neq\varnothingF∖Ji​=∅. Hence, for all sufficiently small t>0t>0t>0, none of the coordinates in F∖JiF\setminus J_iF∖Ji​ can become row-minimizing. Therefore the right derivative of ϕi(wt)\phi_i(w^t)ϕi​(wt) at 000 is
ρiF(d):={min⁡j∈Jimi⋅dj,if Ji≠∅ and Ji⊂F,min⁡ ⁣{0, min⁡j∈Ji∩Fmi⋅dj},otherwise,\rho_i^F(d):=
\begin{cases}
\min_{j\in J_i} m_i\cdot d_j, & \text{if } J_i\neq\varnothing \text{ and } J_i\subset F,\\[1mm]
\min\!\Bigl\{0,\ \min_{j\in J_i\cap F} m_i\cdot d_j\Bigr\}, & \text{otherwise},
\end{cases}ρiF​(d):=⎩⎨⎧​minj∈Ji​​mi​⋅dj​,min{0, minj∈Ji​∩F​mi​⋅dj​},​if Ji​=∅ and Ji​⊂F,otherwise,​
with the convention min⁡∅=+∞\min\varnothing=+\inftymin∅=+∞, so if Ji=∅J_i=\varnothingJi​=∅ the second line is just 000.
Why the second line is correct: if some exact minimizer lies outside FFF, or if the infimum is not attained at all, then an unperturbed outside-FFF tail remains available at first order, so the row-inf derivative cannot exceed 000 unless one of the perturbed exact minimizers in FFF does better.
Also,
∣ϕi(wt)−ϕi(w∗)t∣≤max⁡j∈F∣mi⋅dj∣≤max⁡j∈F∥dj∥≤diam⁡(W).\left|\frac{\phi_i(w^t)-\phi_i(w^*)}{t}\right|
\le \max_{j\in F}|m_i\cdot d_j|
\le \max_{j\in F}\|d_j\|
\le \operatorname{diam}(W).​tϕi​(wt)−ϕi​(w∗)​​≤j∈Fmax​∣mi​⋅dj​∣≤j∈Fmax​∥dj​∥≤diam(W).
Since ∑iτi=1\sum_i \tau_i=1∑i​τi​=1, this uniform bound lets us pass the limit through ∑iτi\sum_i\tau_i∑i​τi​. Hence
0≥lim⁡t↓0R(wt)−R(w∗)t=∑j∈Fατj mj⋅dj+(1−α)∑iτi ρiF(d).(1)0\ge \lim_{t\downarrow 0}\frac{R(w^t)-R(w^*)}{t}
=
\sum_{j\in F}\alpha\tau_j\, m_j\cdot d_j
+
(1-\alpha)\sum_i \tau_i\, \rho_i^F(d).
\tag{1}0≥t↓0lim​tR(wt)−R(w∗)​=j∈F∑​ατj​mj​⋅dj​+(1−α)i∑​τi​ρiF​(d).(1)
Step 2. Finite-window minimax
For each row iii, define the compact convex set KiF⊂[0,1]FK_i^F\subset [0,1]^FKiF​⊂[0,1]F by
KiF:={{qi∈[0,1]F: qij=0 ∀j∉Ji, ∑j∈Fqij=1},if Ji≠∅ and Ji⊂F,{qi∈[0,1]F: qij=0 ∀j∉Ji, ∑j∈Fqij≤1},otherwise.K_i^F:=
\begin{cases}
\left\{q_i\in[0,1]^F:\ q_{ij}=0\ \forall j\notin J_i,\ \sum_{j\in F}q_{ij}=1\right\},
& \text{if } J_i\neq\varnothing \text{ and } J_i\subset F,\\[2mm]
\left\{q_i\in[0,1]^F:\ q_{ij}=0\ \forall j\notin J_i,\ \sum_{j\in F}q_{ij}\le 1\right\},
& \text{otherwise}.
\end{cases}KiF​:=⎩⎨⎧​{qi​∈[0,1]F: qij​=0 ∀j∈/Ji​, ∑j∈F​qij​=1},{qi​∈[0,1]F: qij​=0 ∀j∈/Ji​, ∑j∈F​qij​≤1},​if Ji​=∅ and Ji​⊂F,otherwise.​
Set
QF:=∏i∈IKiF,DF:=∏j∈F(W−wj∗).Q_F:=\prod_{i\in I} K_i^F,
\qquad
D_F:=\prod_{j\in F}(W-w_j^*).QF​:=i∈I∏​KiF​,DF​:=j∈F∏​(W−wj∗​).
Because III is countable and each KiFK_i^FKiF​ is compact, QFQ_FQF​ is compact and convex. Likewise DFD_FDF​ is compact and convex.
Define
HF(q,d):=∑j∈Fατj mj⋅dj+(1−α)∑iτi∑j∈Fqij mi⋅dj.H_F(q,d):=
\sum_{j\in F}\alpha\tau_j\, m_j\cdot d_j
+
(1-\alpha)\sum_i \tau_i \sum_{j\in F} q_{ij}\, m_i\cdot d_j.HF​(q,d):=j∈F∑​ατj​mj​⋅dj​+(1−α)i∑​τi​j∈F∑​qij​mi​⋅dj​.
For fixed FFF, the series in iii converges uniformly on QF×DFQ_F\times D_FQF​×DF​, because
∣∑j∈Fqij mi⋅dj∣≤max⁡j∈F∥dj∥≤diam⁡(W),\left|\sum_{j\in F} q_{ij}\, m_i\cdot d_j\right|
\le \max_{j\in F}\|d_j\|
\le \operatorname{diam}(W),​j∈F∑​qij​mi​⋅dj​​≤j∈Fmax​∥dj​∥≤diam(W),
and ∑iτi<∞\sum_i\tau_i<\infty∑i​τi​<∞. So HFH_FHF​ is jointly continuous. It is affine in qqq and affine in ddd.
For fixed ddd, the minimization over q∈QFq\in Q_Fq∈QF​ separates row by row, and by construction of KiFK_i^FKiF​,
inf⁡q∈QFHF(q,d)=∑j∈Fατj mj⋅dj+(1−α)∑iτi ρiF(d).\inf_{q\in Q_F} H_F(q,d)
=
\sum_{j\in F}\alpha\tau_j\, m_j\cdot d_j
+
(1-\alpha)\sum_i \tau_i\, \rho_i^F(d).q∈QF​inf​HF​(q,d)=j∈F∑​ατj​mj​⋅dj​+(1−α)i∑​τi​ρiF​(d).
By (1), this is always ≤0\le 0≤0. Hence
sup⁡d∈DFinf⁡q∈QFHF(q,d)≤0.\sup_{d\in D_F}\inf_{q\in Q_F} H_F(q,d)\le 0.d∈DF​sup​q∈QF​inf​HF​(q,d)≤0.
Now use the compact-convex minimax theorem in the following form: if X,YX,YX,Y are compact convex sets and h:X×Y→Rh:X\times Y\to\mathbb Rh:X×Y→R is jointly continuous, convex in the first variable, and concave in the second, then
inf⁡x∈Xsup⁡y∈Yh(x,y)=sup⁡y∈Yinf⁡x∈Xh(x,y).\inf_{x\in X}\sup_{y\in Y} h(x,y)=\sup_{y\in Y}\inf_{x\in X} h(x,y).x∈Xinf​y∈Ysup​h(x,y)=y∈Ysup​x∈Xinf​h(x,y).
Here X=QFX=Q_FX=QF​, Y=DFY=D_FY=DF​, and HFH_FHF​ is affine in each variable, hence both convex and concave as needed. Therefore
inf⁡q∈QFsup⁡d∈DFHF(q,d)≤0.\inf_{q\in Q_F}\sup_{d\in D_F} H_F(q,d)\le 0.q∈QF​inf​d∈DF​sup​HF​(q,d)≤0.
So there exists qF∈QFq^F\in Q_FqF∈QF​ such that
HF(qF,d)≤0∀d∈DF.(2)H_F(q^F,d)\le 0\qquad \forall d\in D_F.
\tag{2}HF​(qF,d)≤0∀d∈DF​.(2)
Now fix j∈Fj\in Fj∈F and any x∈Wx\in Wx∈W. Choose d∈DFd\in D_Fd∈DF​ with
dj=x−wj∗,dk=0 (k∈F, k≠j).d_j=x-w_j^*,
\qquad
d_k=0 \ (k\in F,\ k\neq j).dj​=x−wj∗​,dk​=0 (k∈F, k=j).
Plugging this into (2) gives
[ατjmj+(1−α)∑iτiqijFmi]⋅(x−wj∗)≤0∀x∈W.\Bigl[\alpha\tau_j m_j +(1-\alpha)\sum_i \tau_i q^F_{ij}m_i\Bigr]\cdot (x-w_j^*)\le 0
\qquad \forall x\in W.[ατj​mj​+(1−α)i∑​τi​qijF​mi​]⋅(x−wj∗​)≤0∀x∈W.
Therefore
ατjmj+(1−α)∑iτiqijFmi∈Nj.(3)\alpha\tau_j m_j +(1-\alpha)\sum_i \tau_i q^F_{ij}m_i \in N_j.
\tag{3}ατj​mj​+(1−α)i∑​τi​qijF​mi​∈Nj​.(3)
So every finite window FFF admits a relaxed kernel on that window that satisfies the normal-cone conditions for all j∈Fj\in Fj∈F.
Step 3. Diagonal limit
Choose an exhaustion F1⊂F2⊂⋯F_1\subset F_2\subset \cdotsF1​⊂F2​⊂⋯ with ⋃nFn=I\bigcup_n F_n=I⋃n​Fn​=I, and for each nnn choose q(n):=qFnq^{(n)}:=q^{F_n}q(n):=qFn​ from Step 2.
Because I×II\times II×I is countable and each coordinate lies in [0,1][0,1][0,1], a diagonal subsequence converges coordinatewise:
qij(nk)→λij∈[0,1]∀i,j.q^{(n_k)}_{ij}\to \lambda_{ij}\in[0,1]
\qquad\forall i,j.qij(nk​)​→λij​∈[0,1]∀i,j.
Support is preserved coordinatewise, so λij=0\lambda_{ij}=0λij​=0 for j∉Jij\notin J_ij∈/Ji​.
For row sums, let G⊂IG\subset IG⊂I be finite. For all large kkk,
∑j∈Gqij(nk)≤1.\sum_{j\in G} q^{(n_k)}_{ij}\le 1.j∈G∑​qij(nk​)​≤1.
Passing to the limit,
∑j∈Gλij≤1.\sum_{j\in G}\lambda_{ij}\le 1.j∈G∑​λij​≤1.
Since this holds for every finite GGG, we get ∑jλij≤1\sum_j\lambda_{ij}\le 1∑j​λij​≤1.
If JiJ_iJi​ is finite and nonempty, then Ji⊂FnJ_i\subset F_nJi​⊂Fn​ for all large nnn, and by the definition of KiFnK_i^{F_n}KiFn​​,
∑j∈Jiqij(n)=1\sum_{j\in J_i} q^{(n)}_{ij}=1j∈Ji​∑​qij(n)​=1
for all large nnn. Passing to the limit gives ∑jλij=1\sum_j\lambda_{ij}=1∑j​λij​=1.
Finally, fix any on-path jjj. For all large kkk, j∈Fnkj\in F_{n_k}j∈Fnk​​, so by (3),
aj(k):=ατjmj+(1−α)∑iτiqij(nk)mi∈Nj.a_j^{(k)}:=
\alpha\tau_j m_j +(1-\alpha)\sum_i \tau_i q^{(n_k)}_{ij}m_i \in N_j.aj(k)​:=ατj​mj​+(1−α)i∑​τi​qij(nk​)​mi​∈Nj​.
Because 0≤qij(nk)≤10\le q^{(n_k)}_{ij}\le 10≤qij(nk​)​≤1 and ∑iτi<∞\sum_i\tau_i<\infty∑i​τi​<∞, dominated convergence yields
aj(k)→ατjmj+(1−α)∑iτiλijmi=aj(λ).a_j^{(k)}\to \alpha\tau_j m_j +(1-\alpha)\sum_i \tau_i\lambda_{ij}m_i = a_j(\lambda).aj(k)​→ατj​mj​+(1−α)i∑​τi​λij​mi​=aj​(λ).
Since NjN_jNj​ is closed, aj(λ)∈Nja_j(\lambda)\in N_jaj​(λ)∈Nj​.
That proves the proposition. ∎
Where the direct proof stops
The proposition above is the strongest statement I can bank directly on this branch.
It gives a relaxed supporting kernel λ\lambdaλ with row masses ≤1\le 1≤1. The desired existential replacement lemma is exactly the statement that one can upgrade this relaxed object to an honest kernel with row masses =1=1=1 on the actual tie sets.
So the exact irreducible open sublemma is:

Tail/no-mass-at-infinity completion sublemma.
Given a reduced maximizer w∗w^*w∗, prove that there exists some matrix β=(βij)\beta=(\beta_{ij})β=(βij​) such that
βij≥0,βij=0 for j∉Ji,∑jβij=1  ∀i,\beta_{ij}\ge 0,\qquad \beta_{ij}=0\ \text{for } j\notin J_i,\qquad \sum_j \beta_{ij}=1\ \ \forall i,βij​≥0,βij​=0 for j∈/Ji​,j∑​βij​=1  ∀i,
and
aj(β):=ατjmj+(1−α)∑iτiβijmi∈NW(wj∗)∀ on-path j.a_j(\beta):=\alpha\tau_j m_j +(1-\alpha)\sum_i \tau_i\beta_{ij}m_i \in N_W(w_j^*)
\qquad \forall \text{ on-path } j.aj​(β):=ατj​mj​+(1−α)i∑​τi​βij​mi​∈NW​(wj∗​)∀ on-path j.
Equivalently, prove that the relaxed row deficits
ri:=1−∑jλijr_i:=1-\sum_j \lambda_{ij}ri​:=1−j∑​λij​
can always be eliminated without pushing some column aggregate aja_jaj​ out of its normal cone.

This is exactly the remaining gap. It is not the stronger universal claim that every supporting supergradient is representable. It is the minimal existential upgrade from row-subprobabilities to honest row-probabilities.
Why the current banked inputs do not settle that sublemma
First, the finite obstruction only killed
rowwise attainment+arbitrary honest rowwise minimizer⟹on-path normal-cone optimality.\text{rowwise attainment} + \text{arbitrary honest rowwise minimizer}
\Longrightarrow
\text{on-path normal-cone optimality}.rowwise attainment+arbitrary honest rowwise minimizer⟹on-path normal-cone optimality.
It does not address whether some carefully chosen honest kernel exists. 
Second, the phantom-support negative construction is not sound. The reviewer already showed that the key cone calculation in that obstruction goes the wrong way, so there is no banked counterexample to the existential claim.  
Third, the proof above explains why the gap is genuinely tail-based. Every inequality derived from maximality only probes finite windows FFF. Any mass that keeps moving farther out along an infinite exact-tie tail, or along a nonattained near-minimizing tail, is invisible to every such finite test. That is why the diagonal limit naturally produces ∑jλij≤1\sum_j\lambda_{ij}\le 1∑j​λij​≤1, not necessarily equality. Rows with finite nonempty JiJ_iJi​ are already settled; only infinite or unattained rows remain.
So the current record supports the following precise diagnosis:


the direct branch yields a relaxed kernel λ\lambdaλ;


the unresolved step is not tie-breaking inside a finite JiJ_iJi​;


the unresolved step is eliminating row deficits on infinite or unattained tie rows.


Suggested next local action: formalize the relaxed-kernel proposition above as banked progress, then attack only the tail/no-mass-at-infinity completion lemma ri=0r_i=0ri​=0 for rows with JiJ_iJi​ infinite or empty, since all finite attained rows are already settled.
