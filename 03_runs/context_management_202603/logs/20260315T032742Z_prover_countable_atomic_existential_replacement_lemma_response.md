I’m reading the target packet and both supporting notes against the durable proof state to isolate the exact existential replacement lemma, then I’ll determine whether it can be proved from the banked atomic inputs or whether a clean obstruction/counterexample remains.The hinge is now precise: I’m checking whether the rowwise inf admits a subgradient carried by actual argmin indices, or whether near-minimizing tails can fake support. The reviewer’s PASS narrows context but doesn’t resolve this, so I’m pursuing both an honest-kernel proof from concavity/compactness and a reduced-game tail obstruction.The existential replacement lemma is false
There is a countable-atomic reduced game in which w∗w^*w∗ is a reduced maximizer, every row infimum is attained on an actual argmin set JiJ_iJi​, but no honest countably additive kernel β\betaβ with supp⁡βi⊆Ji\operatorname{supp}\beta_i\subseteq J_isuppβi​⊆Ji​ can satisfy the on-path normal-cone conditions
aj(β):=ατjmj+(1−α)∑iτiβijmi∈NW(wj∗)for all on-path j.a_j(\beta):=\alpha\tau_j m_j+(1-\alpha)\sum_i \tau_i\beta_{ij}m_i\in N_W(w_j^*)
\quad\text{for all on-path }j.aj​(β):=ατj​mj​+(1−α)i∑​τi​βij​mi​∈NW​(wj∗​)for all on-path j.
So the missing step on the countable-atomic direct route is not just a proof gap. It can genuinely fail because of phantom support.

Counterexample
Work in N=2N=2N=2, so beliefs are points in Δ({1,2})⊂R2\Delta(\{1,2\})\subset\mathbb R^2Δ({1,2})⊂R2.
Let the message set be
I=U⊔V,U={u0,u1,u2,… },V={v0,v1,v2,… }.I=U\sqcup V,\qquad
U=\{u_0,u_1,u_2,\dots\},\quad
V=\{v_0,v_1,v_2,\dots\}.I=U⊔V,U={u0​,u1​,u2​,…},V={v0​,v1​,v2​,…}.
Choose a compact convex W⊂R2W\subset\mathbb R^2W⊂R2 with the following geometry.


u0u_0u0​ and v0v_0v0​ are exposed corners of WWW.


There are exposed boundary points un→u0u_n\to u_0un​→u0​ and vn→v0v_n\to v_0vn​→v0​.


The normal cones NW(u0)N_W(u_0)NW​(u0​) and NW(v0)N_W(v_0)NW​(v0​) are pointed 2-dimensional cones. Pick beliefs


mu0∈Δ({1,2})∩NW(u0),mv0∈Δ({1,2})∩NW(v0)m_{u_0}\in \Delta(\{1,2\})\cap N_W(u_0),\qquad
m_{v_0}\in \Delta(\{1,2\})\cap N_W(v_0)mu0​​∈Δ({1,2})∩NW​(u0​),mv0​​∈Δ({1,2})∩NW​(v0​)
on the frontier-facing extreme rays of those cones.


Pick the exposing beliefs mun→mu0m_{u_n}\to m_{u_0}mun​​→mu0​​ and mvn→mv0m_{v_n}\to m_{v_0}mvn​​→mv0​​ so that all munm_{u_n}mun​​ lie strictly on the “uuu-side” of NW(v0)N_W(v_0)NW​(v0​), and all mvnm_{v_n}mvn​​ lie strictly on the “vvv-side” of NW(u0)N_W(u_0)NW​(u0​).


For every i∈Ui\in Ui∈U, v0v_0v0​ is the unique minimizer of mi⋅wm_i\cdot wmi​⋅w over WWW, and


mi⋅vn↓mi⋅v0.m_i\cdot v_n \downarrow m_i\cdot v_0.mi​⋅vn​↓mi​⋅v0​.
Symmetrically, for every i∈Vi\in Vi∈V, u0u_0u0​ is the unique minimizer of mi⋅wm_i\cdot wmi​⋅w over WWW, and
mi⋅un↓mi⋅u0.m_i\cdot u_n \downarrow m_i\cdot u_0.mi​⋅un​↓mi​⋅u0​.
A concrete realization is the convex hull of two strictly convex C1C^1C1 arcs, one terminating at u0u_0u0​, one at v0v_0v0​, with short backside segments inserted so that u0,v0u_0,v_0u0​,v0​ become genuine corners. Then choose the exposed points un,vnu_n,v_nun​,vn​ along the two frontier arcs sufficiently close to the corners.
Fix any α∈(0,1)\alpha\in(0,1)α∈(0,1). Because the corners are genuine and the endpoint normals above are chosen on the frontier-facing extreme rays, there are finite constants cU,cVc_U,c_VcU​,cV​ such that
μ⋅w−μ⋅v0≤cU(mv0⋅v0−mv0⋅w)∀μ∈{mi:i∈U}, ∀w∈W,\mu\cdot w-\mu\cdot v_0
\le c_U\bigl(m_{v_0}\cdot v_0-m_{v_0}\cdot w\bigr)
\quad\forall \mu\in\{m_i:i\in U\},\ \forall w\in W,μ⋅w−μ⋅v0​≤cU​(mv0​​⋅v0​−mv0​​⋅w)∀μ∈{mi​:i∈U}, ∀w∈W,
and
ν⋅w−ν⋅u0≤cV(mu0⋅u0−mu0⋅w)∀ν∈{mi:i∈V}, ∀w∈W.\nu\cdot w-\nu\cdot u_0
\le c_V\bigl(m_{u_0}\cdot u_0-m_{u_0}\cdot w\bigr)
\quad\forall \nu\in\{m_i:i\in V\},\ \forall w\in W.ν⋅w−ν⋅u0​≤cV​(mu0​​⋅u0​−mu0​​⋅w)∀ν∈{mi​:i∈V}, ∀w∈W.
Intuitively: to increase any UUU-belief above its value at v0v_0v0​, one must move away from v0v_0v0​ in a direction that loses mv0m_{v_0}mv0​​-payoff at first order; similarly on the other side.
Now choose strictly positive atomic weights (τi)i∈I(\tau_i)_{i\in I}(τi​)i∈I​ such that
ατv0>(1−α)cU∑i∈Uτi,ατu0>(1−α)cV∑i∈Vτi.\alpha\tau_{v_0}>(1-\alpha)c_U\sum_{i\in U}\tau_i,
\qquad
\alpha\tau_{u_0}>(1-\alpha)c_V\sum_{i\in V}\tau_i.ατv0​​>(1−α)cU​i∈U∑​τi​,ατu0​​>(1−α)cV​i∈V∑​τi​.
This is easy: take α\alphaα close enough to 111, make τu0,τv0\tau_{u_0},\tau_{v_0}τu0​​,τv0​​ large, and make the tails small but positive.
Define the candidate reduced profile by
wun∗=un,wvn∗=vn(n≥0).w_{u_n}^*=u_n,\qquad w_{v_n}^*=v_n\qquad(n\ge 0).wun​∗​=un​,wvn​∗​=vn​(n≥0).

Why w∗w^*w∗ is a reduced maximizer
The reduced objective is
R(w)=α∑jτj mj⋅wj+(1−α)∑iτi ϕi(w),ϕi(w):=inf⁡jmi⋅wj.R(w)=\alpha\sum_j \tau_j\, m_j\cdot w_j
+(1-\alpha)\sum_i \tau_i\,\phi_i(w),
\qquad
\phi_i(w):=\inf_j m_i\cdot w_j.R(w)=αj∑​τj​mj​⋅wj​+(1−α)i∑​τi​ϕi​(w),ϕi​(w):=jinf​mi​⋅wj​.
For any w=(wj)j∈I∈WIw=(w_j)_{j\in I}\in W^Iw=(wj​)j∈I​∈WI,
R(w)−R(w∗)=α∑jτj mj⋅(wj−wj∗)+(1−α)∑i∈Uτi(ϕi(w)−mi⋅v0)+(1−α)∑i∈Vτi(ϕi(w)−mi⋅u0).R(w)-R(w^*)
=
\alpha\sum_j \tau_j\, m_j\cdot (w_j-w_j^*)
+(1-\alpha)\sum_{i\in U}\tau_i\bigl(\phi_i(w)-m_i\cdot v_0\bigr)
+(1-\alpha)\sum_{i\in V}\tau_i\bigl(\phi_i(w)-m_i\cdot u_0\bigr).R(w)−R(w∗)=αj∑​τj​mj​⋅(wj​−wj∗​)+(1−α)i∈U∑​τi​(ϕi​(w)−mi​⋅v0​)+(1−α)i∈V∑​τi​(ϕi​(w)−mi​⋅u0​).
First term: each wj∗w_j^*wj∗​ is Bayes-optimal for mjm_jmj​, so
mj⋅(wj−wj∗)≤0for every j.m_j\cdot (w_j-w_j^*)\le 0
\quad\text{for every }j.mj​⋅(wj​−wj∗​)≤0for every j.
For i∈Ui\in Ui∈U,
ϕi(w)−mi⋅v0=inf⁡jmi⋅wj−mi⋅v0≤mi⋅wv0−mi⋅v0≤cU(mv0⋅v0−mv0⋅wv0).\phi_i(w)-m_i\cdot v_0
=\inf_j m_i\cdot w_j-m_i\cdot v_0
\le m_i\cdot w_{v_0}-m_i\cdot v_0
\le c_U\bigl(m_{v_0}\cdot v_0-m_{v_0}\cdot w_{v_0}\bigr).ϕi​(w)−mi​⋅v0​=jinf​mi​⋅wj​−mi​⋅v0​≤mi​⋅wv0​​−mi​⋅v0​≤cU​(mv0​​⋅v0​−mv0​​⋅wv0​​).
Summing over i∈Ui\in Ui∈U,
(1−α)∑i∈Uτi(ϕi(w)−mi⋅v0)≤(1−α)cU(∑i∈Uτi)(mv0⋅v0−mv0⋅wv0).(1-\alpha)\sum_{i\in U}\tau_i\bigl(\phi_i(w)-m_i\cdot v_0\bigr)
\le
(1-\alpha)c_U\Bigl(\sum_{i\in U}\tau_i\Bigr)\bigl(m_{v_0}\cdot v_0-m_{v_0}\cdot w_{v_0}\bigr).(1−α)i∈U∑​τi​(ϕi​(w)−mi​⋅v0​)≤(1−α)cU​(i∈U∑​τi​)(mv0​​⋅v0​−mv0​​⋅wv0​​).
Similarly,
(1−α)∑i∈Vτi(ϕi(w)−mi⋅u0)≤(1−α)cV(∑i∈Vτi)(mu0⋅u0−mu0⋅wu0).(1-\alpha)\sum_{i\in V}\tau_i\bigl(\phi_i(w)-m_i\cdot u_0\bigr)
\le
(1-\alpha)c_V\Bigl(\sum_{i\in V}\tau_i\Bigr)\bigl(m_{u_0}\cdot u_0-m_{u_0}\cdot w_{u_0}\bigr).(1−α)i∈V∑​τi​(ϕi​(w)−mi​⋅u0​)≤(1−α)cV​(i∈V∑​τi​)(mu0​​⋅u0​−mu0​​⋅wu0​​).
Hence
R(w)−R(w∗)≤[(1−α)cU∑i∈Uτi−ατv0](mv0⋅v0−mv0⋅wv0)R(w)-R(w^*)
\le
\Bigl[(1-\alpha)c_U\sum_{i\in U}\tau_i-\alpha\tau_{v_0}\Bigr]
\bigl(m_{v_0}\cdot v_0-m_{v_0}\cdot w_{v_0}\bigr)R(w)−R(w∗)≤[(1−α)cU​i∈U∑​τi​−ατv0​​](mv0​​⋅v0​−mv0​​⋅wv0​​)
+[(1−α)cV∑i∈Vτi−ατu0](mu0⋅u0−mu0⋅wu0)≤0\qquad\qquad+
\Bigl[(1-\alpha)c_V\sum_{i\in V}\tau_i-\alpha\tau_{u_0}\Bigr]
\bigl(m_{u_0}\cdot u_0-m_{u_0}\cdot w_{u_0}\bigr)
\le 0+[(1−α)cV​i∈V∑​τi​−ατu0​​](mu0​​⋅u0​−mu0​​⋅wu0​​)≤0
by the choice of τ\tauτ. So w∗w^*w∗ is indeed a reduced maximizer.

Why no honest countably additive kernel can support w∗w^*w∗
By construction, for every i∈Ui\in Ui∈U,
Ji=arg⁡min⁡j(mi⋅wj∗)={v0},J_i=\arg\min_j (m_i\cdot w_j^*)=\{v_0\},Ji​=argjmin​(mi​⋅wj∗​)={v0​},
and for every i∈Vi\in Vi∈V,
Ji={u0}.J_i=\{u_0\}.Ji​={u0​}.
So an honest kernel is forced to be
βi,v0=1(i∈U),βi,u0=1(i∈V).\beta_{i,v_0}=1\quad(i\in U),\qquad
\beta_{i,u_0}=1\quad(i\in V).βi,v0​​=1(i∈U),βi,u0​​=1(i∈V).
There is no selector freedom left. The honest kernel is unique.
At column v0v_0v0​,
av0(β)=ατv0mv0+(1−α)∑i∈Uτimi.a_{v_0}(\beta)
=
\alpha\tau_{v_0}m_{v_0}
+
(1-\alpha)\sum_{i\in U}\tau_i m_i.av0​​(β)=ατv0​​mv0​​+(1−α)i∈U∑​τi​mi​.
Every mim_imi​ with i∈Ui\in Ui∈U was chosen strictly on the wrong side of the frontier-facing boundary ray of NW(v0)N_W(v_0)NW​(v0​). Since mv0m_{v_0}mv0​​ itself lies on that boundary ray, adding any positive UUU-mass pushes the sum out of NW(v0)N_W(v_0)NW​(v0​). Therefore
av0(β)∉NW(v0)=NW(wv0∗).a_{v_0}(\beta)\notin N_W(v_0)=N_W(w_{v_0}^*).av0​​(β)∈/NW​(v0​)=NW​(wv0​∗​).
So wv0∗w_{v_0}^*wv0​∗​ is not Bayes-optimal for the posterior induced by any honest kernel. Symmetrically,
au0(β)∉NW(u0)=NW(wu0∗).a_{u_0}(\beta)\notin N_W(u_0)=N_W(w_{u_0}^*).au0​​(β)∈/NW​(u0​)=NW​(wu0​∗​).
Thus there is no honest countably additive β\betaβ with supp⁡βi⊆Ji\operatorname{supp}\beta_i\subseteq J_isuppβi​⊆Ji​ that satisfies the required on-path normal-cone conditions.

Where honest countable additivity fails
The reduced maximizer is supported only by a phantom certificate.
For the UUU-rows, the values mi⋅vn↓mi⋅v0m_i\cdot v_n\downarrow m_i\cdot v_0mi​⋅vn​↓mi​⋅v0​ let the row-inf part behave as if the adversary could keep its mass “out along the vvv-tail,” invisible to every fixed column. The same happens for the VVV-rows along the uuu-tail.
That relaxed certificate is not countably additive. In every fixed column it contributes zero, but rowwise it still carries full mass at the limiting infimum. Honest countable additivity forbids that escape: since each JiJ_iJi​ is a singleton, all row mass must land on the actual argmin column v0v_0v0​ or u0u_0u0​, and that collapses the endpoint posteriors outside the normal cones.
So the obstruction is genuinely existential, not merely “some honest selector is bad.” Here the honest selector is unique, and it fails.
Suggested next local action: bank this as a negative result on the countable-atomic direct route and reformulate the branch around a relaxed/finitely-additive certificate theorem, or impose an explicit anti-phantom assumption that rules out tails with unattained support at the row-inf level.
