I’m focusing strictly on the conditional patching lemma, cross-checking the packet with the durable proof-state and reviewer repairs to ensure every step uses only the explicit labeled posterior assumption. The key checks are to rely on the Needed assumption and derive the agent-side saddle directly from the patched posterior, otherwise I’ll stop at the first genuine gap.The only remaining issue is whether the conditional theorem closes once the zero-gap posterior is granted. I’m now checking that hinge inequality-by-inequality against the reduced-game formulas, not the earlier continuity route.Conditional exact version-and-patching saddle lemma
I will prove the conditional lemma under exactly the explicit added posterior-labeled-lift assumption requested in the packet, and I will not use any stronger lift claim.  
Let W⊂R∣Ω∣W\subset \mathbb R^{|\Omega|}W⊂R∣Ω∣ be the compact payoff set from the reduced game, and let
G(β,w):=α∫Mτ(ds) s⋅w(s)+(1−α)∫Mτ(ds)∫Mβ(dm∣s) s⋅w(m),\mathcal G(\beta,w)
:=
\alpha\int_M \tau(ds)\, s\cdot w(s)
+
(1-\alpha)\int_M \tau(ds)\int_M \beta(dm\mid s)\, s\cdot w(m),G(β,w):=α∫M​τ(ds)s⋅w(s)+(1−α)∫M​τ(ds)∫M​β(dm∣s)s⋅w(m),
for Borel selectors w:M→Ww:M\to Ww:M→W and raw adviser kernels β∈B\beta\in Bβ∈B.
Assume the already-proved selector package on WWW:


a Borel map D:W→WPD:W\to W^{P}D:W→WP with D(w)≥wD(w)\ge wD(w)≥w coordinatewise for every w∈Ww\in Ww∈W,


a Borel map π:WP→Δ(Ω)\pi:W^{P}\to \Delta(\Omega)π:WP→Δ(Ω) with
π(v)⋅v=max⁡u∈Wπ(v)⋅ufor every v∈WP.\pi(v)\cdot v=\max_{u\in W}\pi(v)\cdot u
\qquad\text{for every }v\in W^{P}.π(v)⋅v=u∈Wmax​π(v)⋅ufor every v∈WP.


Let β∗∈B\beta^*\in Bβ∗∈B be the chosen raw lift and let wˉ∗:M→W\bar w^*:M\to Wwˉ∗:M→W be the pre-patching selector. I only assume the adviser-side half of the pre-patching saddle:
G(β∗,wˉ∗)≤G(β,wˉ∗)∀β∈B.(A)\mathcal G(\beta^*,\bar w^*)\le \mathcal G(\beta,\bar w^*)
\qquad\forall \beta\in B.
\tag{A}G(β∗,wˉ∗)≤G(β,wˉ∗)∀β∈B.(A)
If (β∗,wˉ∗)(\beta^*,\bar w^*)(β∗,wˉ∗) was already a deterministic reduced saddle, then (A) is automatic.
Define the induced message law
q∗(dm)=α τ(dm)+(1−α)∫Mτ(ds) β∗(dm∣s).q^*(dm)
=
\alpha\,\tau(dm)
+
(1-\alpha)\int_M \tau(ds)\,\beta^*(dm\mid s).q∗(dm)=ατ(dm)+(1−α)∫M​τ(ds)β∗(dm∣s).
Needed assumption
The chosen raw lift β∗\beta^*β∗ admits a Borel posterior version
p0:M→Δ(Ω)p_0:M\to \Delta(\Omega)p0​:M→Δ(Ω)
such that
wˉ∗(m)∈arg⁡max⁡w∈Wp0(m)⋅wfor q∗-a.e. m.(NA)\bar w^*(m)\in \arg\max_{w\in W} p_0(m)\cdot w
\qquad\text{for }q^*\text{-a.e. }m.
\tag{NA}wˉ∗(m)∈argw∈Wmax​p0​(m)⋅wfor q∗-a.e. m.(NA)
Equivalently, with
hW(μ):=max⁡u∈Wμ⋅u,g(m):=hW(p0(m))−p0(m)⋅wˉ∗(m)≥0,h_W(\mu):=\max_{u\in W}\mu\cdot u,
\qquad
g(m):=h_W(p_0(m))-p_0(m)\cdot \bar w^*(m)\ge 0,hW​(μ):=u∈Wmax​μ⋅u,g(m):=hW​(p0​(m))−p0​(m)⋅wˉ∗(m)≥0,
we have g=0g=0g=0 q∗q^*q∗-a.e.
I claim that under (NA) one can patch wˉ∗\bar w^*wˉ∗ into an exact messagewise Bayes-optimal selector w∗w^*w∗ while preserving the adviser-side inequality, hence obtaining a full saddle.

Proof
Because WWW is compact in the finite-dimensional space R∣Ω∣\mathbb R^{|\Omega|}R∣Ω∣, the support function hWh_WhW​ is continuous. Since p0p_0p0​ and wˉ∗\bar w^*wˉ∗ are Borel, the gap
g(m)=hW(p0(m))−p0(m)⋅wˉ∗(m)g(m)=h_W(p_0(m))-p_0(m)\cdot \bar w^*(m)g(m)=hW​(p0​(m))−p0​(m)⋅wˉ∗(m)
is Borel. Set
N:={m∈M:g(m)>0}.N:=\{m\in M:g(m)>0\}.N:={m∈M:g(m)>0}.
Then NNN is Borel and, by (NA),
q∗(N)=0.(1)q^*(N)=0.
\tag{1}q∗(N)=0.(1)
Define the patched selector and patched posterior version by
w∗(m):={wˉ∗(m),m∉N,D(wˉ∗(m)),m∈N,p∗(m):={p0(m),m∉N,π(w∗(m)),m∈N.(2)w^*(m):=
\begin{cases}
\bar w^*(m), & m\notin N,\\[1mm]
D(\bar w^*(m)), & m\in N,
\end{cases}
\qquad
p^*(m):=
\begin{cases}
p_0(m), & m\notin N,\\[1mm]
\pi(w^*(m)), & m\in N.
\end{cases}
\tag{2}w∗(m):={wˉ∗(m),D(wˉ∗(m)),​m∈/N,m∈N,​p∗(m):={p0​(m),π(w∗(m)),​m∈/N,m∈N.​(2)
Both maps are Borel.
1. Exact messagewise Bayes optimality of w∗w^*w∗
If m∉Nm\notin Nm∈/N, then g(m)=0g(m)=0g(m)=0, so
p0(m)⋅wˉ∗(m)=hW(p0(m))=max⁡w∈Wp0(m)⋅w.p_0(m)\cdot \bar w^*(m)=h_W(p_0(m))=\max_{w\in W} p_0(m)\cdot w.p0​(m)⋅wˉ∗(m)=hW​(p0​(m))=w∈Wmax​p0​(m)⋅w.
Since w∗(m)=wˉ∗(m)w^*(m)=\bar w^*(m)w∗(m)=wˉ∗(m) and p∗(m)=p0(m)p^*(m)=p_0(m)p∗(m)=p0​(m),
w∗(m)∈arg⁡max⁡w∈Wp∗(m)⋅w.w^*(m)\in \arg\max_{w\in W} p^*(m)\cdot w.w∗(m)∈argw∈Wmax​p∗(m)⋅w.
If m∈Nm\in Nm∈N, then w∗(m)=D(wˉ∗(m))∈WPw^*(m)=D(\bar w^*(m))\in W^Pw∗(m)=D(wˉ∗(m))∈WP, and by the defining property of π\piπ,
p∗(m)⋅w∗(m)=π(w∗(m))⋅w∗(m)=max⁡u∈Wπ(w∗(m))⋅u=max⁡u∈Wp∗(m)⋅u.p^*(m)\cdot w^*(m)
=
\pi(w^*(m))\cdot w^*(m)
=
\max_{u\in W}\pi(w^*(m))\cdot u
=
\max_{u\in W}p^*(m)\cdot u.p∗(m)⋅w∗(m)=π(w∗(m))⋅w∗(m)=u∈Wmax​π(w∗(m))⋅u=u∈Wmax​p∗(m)⋅u.
Hence again
w∗(m)∈arg⁡max⁡w∈Wp∗(m)⋅w.w^*(m)\in \arg\max_{w\in W} p^*(m)\cdot w.w∗(m)∈argw∈Wmax​p∗(m)⋅w.
Therefore,
w∗(m)∈arg⁡max⁡w∈Wp∗(m)⋅w∀m∈M.(3)w^*(m)\in \arg\max_{w\in W} p^*(m)\cdot w
\qquad\forall m\in M.
\tag{3}w∗(m)∈argw∈Wmax​p∗(m)⋅w∀m∈M.(3)
2. p∗p^*p∗ is still a posterior version under β∗\beta^*β∗
Since p∗=p0p^*=p_0p∗=p0​ on M∖NM\setminus NM∖N and q∗(N)=0q^*(N)=0q∗(N)=0, we have
p∗=p0q∗-a.e.(4)p^*=p_0
\qquad q^*\text{-a.e.}
\tag{4}p∗=p0​q∗-a.e.(4)
Now, by definition of posterior version under β∗\beta^*β∗, for every bounded Borel map φ:M→R∣Ω∣\varphi:M\to \mathbb R^{|\Omega|}φ:M→R∣Ω∣,
∫Mq∗(dm) p0(m)⋅φ(m)=α∫Mτ(ds) s⋅φ(s)+(1−α)∫Mτ(ds)∫Mβ∗(dm∣s) s⋅φ(m).(5)\int_M q^*(dm)\, p_0(m)\cdot \varphi(m)
=
\alpha\int_M \tau(ds)\, s\cdot \varphi(s)
+
(1-\alpha)\int_M \tau(ds)\int_M \beta^*(dm\mid s)\, s\cdot \varphi(m).
\tag{5}∫M​q∗(dm)p0​(m)⋅φ(m)=α∫M​τ(ds)s⋅φ(s)+(1−α)∫M​τ(ds)∫M​β∗(dm∣s)s⋅φ(m).(5)
Because p∗=p0p^*=p_0p∗=p0​ q∗q^*q∗-a.e., the same identity holds with p∗p^*p∗ in place of p0p_0p0​. In particular, for every Borel selector w:M→Ww:M\to Ww:M→W,
G(β∗,w)=∫Mq∗(dm) p∗(m)⋅w(m)=∫Mq∗(dm) p0(m)⋅w(m).(6)\mathcal G(\beta^*,w)
=
\int_M q^*(dm)\, p^*(m)\cdot w(m)
=
\int_M q^*(dm)\, p_0(m)\cdot w(m).
\tag{6}G(β∗,w)=∫M​q∗(dm)p∗(m)⋅w(m)=∫M​q∗(dm)p0​(m)⋅w(m).(6)
3. Coordinatewise domination
By construction,
w∗(m)=wˉ∗(m)on M∖N,w^*(m)=\bar w^*(m)\quad\text{on }M\setminus N,w∗(m)=wˉ∗(m)on M∖N,
and on NNN,
w∗(m)=D(wˉ∗(m))≥wˉ∗(m)w^*(m)=D(\bar w^*(m))\ge \bar w^*(m)w∗(m)=D(wˉ∗(m))≥wˉ∗(m)
coordinatewise. Hence
w∗(m)≥wˉ∗(m)∀m∈M.(7)w^*(m)\ge \bar w^*(m)
\qquad\forall m\in M.
\tag{7}w∗(m)≥wˉ∗(m)∀m∈M.(7)
Let
Δ(m):=w∗(m)−wˉ∗(m)∈R+∣Ω∣.(8)\Delta(m):=w^*(m)-\bar w^*(m)\in \mathbb R^{|\Omega|}_+.
\tag{8}Δ(m):=w∗(m)−wˉ∗(m)∈R+∣Ω∣​.(8)
4. The payoff at β∗\beta^*β∗ is unchanged by the patch
Using (6) with w=w∗w=w^*w=w∗ and w=wˉ∗w=\bar w^*w=wˉ∗,
G(β∗,w∗)−G(β∗,wˉ∗)=∫Mq∗(dm) p0(m)⋅Δ(m).\mathcal G(\beta^*,w^*)-\mathcal G(\beta^*,\bar w^*)
=
\int_M q^*(dm)\, p_0(m)\cdot \Delta(m).G(β∗,w∗)−G(β∗,wˉ∗)=∫M​q∗(dm)p0​(m)⋅Δ(m).
But Δ=0\Delta=0Δ=0 on M∖NM\setminus NM∖N, so
∫Mq∗(dm) p0(m)⋅Δ(m)=∫Nq∗(dm) p0(m)⋅Δ(m)=0\int_M q^*(dm)\, p_0(m)\cdot \Delta(m)
=
\int_N q^*(dm)\, p_0(m)\cdot \Delta(m)
=
0∫M​q∗(dm)p0​(m)⋅Δ(m)=∫N​q∗(dm)p0​(m)⋅Δ(m)=0
by (1). Therefore
G(β∗,w∗)=G(β∗,wˉ∗).(9)\mathcal G(\beta^*,w^*)=\mathcal G(\beta^*,\bar w^*).
\tag{9}G(β∗,w∗)=G(β∗,wˉ∗).(9)
5. Agent-side saddle inequality at β∗\beta^*β∗
Now use the exact pointwise optimality (3) and the posterior representation (6). For any Borel selector w:M→Ww:M\to Ww:M→W,
G(β∗,w)=∫Mq∗(dm) p∗(m)⋅w(m)≤∫Mq∗(dm) p∗(m)⋅w∗(m)=G(β∗,w∗).(10)\mathcal G(\beta^*,w)
=
\int_M q^*(dm)\, p^*(m)\cdot w(m)
\le
\int_M q^*(dm)\, p^*(m)\cdot w^*(m)
=
\mathcal G(\beta^*,w^*).
\tag{10}G(β∗,w)=∫M​q∗(dm)p∗(m)⋅w(m)≤∫M​q∗(dm)p∗(m)⋅w∗(m)=G(β∗,w∗).(10)
So w∗w^*w∗ is optimal against β∗\beta^*β∗ in the full Borel selector class. This step uses only the Needed assumption and does not require any pre-patching agent-side saddle claim for wˉ∗\bar w^*wˉ∗.
6. Adviser-side monotonicity of the patch
Fix any β∈B\beta\in Bβ∈B. Using the raw reduced payoff formula and Δ=w∗−wˉ∗\Delta=w^*-\bar w^*Δ=w∗−wˉ∗,
G(β,w∗)−G(β,wˉ∗)=α∫Mτ(ds) s⋅Δ(s)+(1−α)∫Mτ(ds)∫Mβ(dm∣s) s⋅Δ(m).(11)\mathcal G(\beta,w^*)-\mathcal G(\beta,\bar w^*)
=
\alpha\int_M \tau(ds)\, s\cdot \Delta(s)
+
(1-\alpha)\int_M \tau(ds)\int_M \beta(dm\mid s)\, s\cdot \Delta(m).
\tag{11}G(β,w∗)−G(β,wˉ∗)=α∫M​τ(ds)s⋅Δ(s)+(1−α)∫M​τ(ds)∫M​β(dm∣s)s⋅Δ(m).(11)
For every s∈M⊆Δ(Ω)s\in M\subseteq \Delta(\Omega)s∈M⊆Δ(Ω), the vector sss has nonnegative coordinates. Since Δ(⋅)∈R+∣Ω∣\Delta(\cdot)\in \mathbb R^{|\Omega|}_+Δ(⋅)∈R+∣Ω∣​ by (8), each inner product in (11) is nonnegative. Therefore
G(β,w∗)≥G(β,wˉ∗)∀β∈B.(12)\mathcal G(\beta,w^*)\ge \mathcal G(\beta,\bar w^*)
\qquad\forall \beta\in B.
\tag{12}G(β,w∗)≥G(β,wˉ∗)∀β∈B.(12)
7. Adviser-side saddle inequality transfers from wˉ∗\bar w^*wˉ∗ to w∗w^*w∗
Combine (A), (9), and (12):
G(β∗,w∗)=G(β∗,wˉ∗)≤G(β,wˉ∗)≤G(β,w∗)∀β∈B.(13)\mathcal G(\beta^*,w^*)
=
\mathcal G(\beta^*,\bar w^*)
\le
\mathcal G(\beta,\bar w^*)
\le
\mathcal G(\beta,w^*)
\qquad\forall \beta\in B.
\tag{13}G(β∗,w∗)=G(β∗,wˉ∗)≤G(β,wˉ∗)≤G(β,w∗)∀β∈B.(13)
Finally, (10) and (13) give
G(β∗,w)≤G(β∗,w∗)≤G(β,w∗)∀ Borel w:M→W, ∀β∈B.(14)\mathcal G(\beta^*,w)\le \mathcal G(\beta^*,w^*)\le \mathcal G(\beta,w^*)
\qquad\forall\text{ Borel }w:M\to W,\ \forall \beta\in B.
\tag{14}G(β∗,w)≤G(β∗,w∗)≤G(β,w∗)∀ Borel w:M→W, ∀β∈B.(14)
Thus (β∗,w∗)(\beta^*,w^*)(β∗,w∗) is a saddle point of the full Borel reduced game, and w∗w^*w∗ is messagewise Bayes-optimal at every message.

Conclusion
Under the explicit Needed assumption that the chosen raw lift β∗\beta^*β∗ admits a Borel posterior version p0p_0p0​ with zero Bayes gap, equivalently q∗q^*q∗-a.e. local optimality of wˉ∗\bar w^*wˉ∗, the exact version-and-patching saddle lemma is valid. The patching construction yields Borel maps w∗w^*w∗ and p∗p^*p∗ such that:


p∗p^*p∗ is still a posterior version under β∗\beta^*β∗;


w∗(m)∈arg⁡max⁡w∈Wp∗(m)⋅ww^*(m)\in \arg\max_{w\in W} p^*(m)\cdot ww∗(m)∈argmaxw∈W​p∗(m)⋅w for every mmm;


w∗(m)≥wˉ∗(m)w^*(m)\ge \bar w^*(m)w∗(m)≥wˉ∗(m) coordinatewise for every mmm;


G(β∗,w∗)=G(β∗,wˉ∗)\mathcal G(\beta^*,w^*)=\mathcal G(\beta^*,\bar w^*)G(β∗,w∗)=G(β∗,wˉ∗);


G(β∗,w)≤G(β∗,w∗)≤G(β,w∗)\mathcal G(\beta^*,w)\le \mathcal G(\beta^*,w^*)\le \mathcal G(\beta,w^*)G(β∗,w)≤G(β∗,w∗)≤G(β,w∗) for all Borel selectors www and all β∈B\beta\in Bβ∈B.


So the conditional route succeeds cleanly. No further local defect remains once the posterior-labeled-lift assumption is made explicit.  
Suggested next local action: bank this conditional lemma and send it to reviewer as the exact conditional theorem.
