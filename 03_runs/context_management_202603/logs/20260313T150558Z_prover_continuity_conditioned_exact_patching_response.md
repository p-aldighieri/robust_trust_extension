I’m reading the local packet and cross-checking it against the durable proof-state so I can answer only the scoped lemma, not wander back into the dead routes.I’m also folding in the latest continuity and patching notes to try a clean patched-saddle proof; if that still fails, I’ll stop at the first surviving obstruction.I’m now checking the already-cleared lifting lemma alongside the local packet before finishing the patching step.Continuity-conditioned exact version-and-patching saddle lemma
Assume the current continuity-conditioned exact-route setup: there is a deterministic reduced saddle (β∗,wˉ∗)(\beta^*,\bar w^*)(β∗,wˉ∗) in the reduced game on WWW, wˉ∗:M→W\bar w^*:M\to Wwˉ∗:M→W is continuous, and the upstream continuity-based exact raw lifting lemma has already been used to secure that β∗∈B\beta^*\in Bβ∗∈B is an admissible raw adviser kernel. Also import the selector package on WWW: a Borel map
D:W→WP,D(w)≥w coordinatewise,D:W\to W^P,\qquad D(w)\ge w \text{ coordinatewise},D:W→WP,D(w)≥w coordinatewise,
and a Borel map
π:WP→Δ(Ω),π(v)⋅v=max⁡u∈Wπ(v)⋅u.\pi:W^P\to \Delta(\Omega),\qquad \pi(v)\cdot v=\max_{u\in W}\pi(v)\cdot u.π:WP→Δ(Ω),π(v)⋅v=u∈Wmax​π(v)⋅u.
No additional assumption is needed for the patching step itself.   
Let
q∗(dm)=ατ(dm)+(1−α)∫Mτ(ds)β∗(dm∣s),q^*(dm)=\alpha\tau(dm)+(1-\alpha)\int_M \tau(ds)\beta^*(dm\mid s),q∗(dm)=ατ(dm)+(1−α)∫M​τ(ds)β∗(dm∣s),
and let p0:M→Δ(Ω)p_0:M\to \Delta(\Omega)p0​:M→Δ(Ω) be a Borel q∗q^*q∗-version of the posterior under β∗\beta^*β∗ such that
wˉ∗(m)∈arg⁡max⁡w∈Wp0(m)⋅wfor q∗-a.e. m.\bar w^*(m)\in \arg\max_{w\in W} p_0(m)\cdot w
\qquad\text{for }q^*\text{-a.e. }m.wˉ∗(m)∈argw∈Wmax​p0​(m)⋅wfor q∗-a.e. m.
Define the support function of WWW by
hW(μ):=max⁡u∈Wμ⋅u.h_W(\mu):=\max_{u\in W}\mu\cdot u.hW​(μ):=u∈Wmax​μ⋅u.
Since WWW is compact, hWh_WhW​ is continuous.
Set
N:={m∈M:p0(m)⋅wˉ∗(m)<hW(p0(m))}.N:=\{m\in M: p_0(m)\cdot \bar w^*(m)< h_W(p_0(m))\}.N:={m∈M:p0​(m)⋅wˉ∗(m)<hW​(p0​(m))}.
Because p0p_0p0​ and wˉ∗\bar w^*wˉ∗ are Borel and hWh_WhW​ is continuous, NNN is Borel. By the assumed q∗q^*q∗-a.e. local optimality of wˉ∗\bar w^*wˉ∗, we have
q∗(N)=0.q^*(N)=0.q∗(N)=0.
Now define the patched selector
w∗(m):={wˉ∗(m),m∉N,D(wˉ∗(m)),m∈N,w^*(m):=
\begin{cases}
\bar w^*(m), & m\notin N,\\[2mm]
D(\bar w^*(m)), & m\in N,
\end{cases}w∗(m):=⎩⎨⎧​wˉ∗(m),D(wˉ∗(m)),​m∈/N,m∈N,​
and the patched posterior version
p∗(m):={p0(m),m∉N,π(w∗(m)),m∈N.p^*(m):=
\begin{cases}
p_0(m), & m\notin N,\\[2mm]
\pi(w^*(m)), & m\in N.
\end{cases}p∗(m):=⎩⎨⎧​p0​(m),π(w∗(m)),​m∈/N,m∈N.​
Both maps are Borel.
1. Exact messagewise Bayes optimality
For m∉Nm\notin Nm∈/N, by definition of NNN,
p0(m)⋅wˉ∗(m)=hW(p0(m)),p_0(m)\cdot \bar w^*(m)=h_W(p_0(m)),p0​(m)⋅wˉ∗(m)=hW​(p0​(m)),
hence
w∗(m)=wˉ∗(m)∈arg⁡max⁡w∈Wp0(m)⋅w=arg⁡max⁡w∈Wp∗(m)⋅w.w^*(m)=\bar w^*(m)\in \arg\max_{w\in W} p_0(m)\cdot w
= \arg\max_{w\in W} p^*(m)\cdot w.w∗(m)=wˉ∗(m)∈argw∈Wmax​p0​(m)⋅w=argw∈Wmax​p∗(m)⋅w.
For m∈Nm\in Nm∈N, we have w∗(m)=D(wˉ∗(m))∈WPw^*(m)=D(\bar w^*(m))\in W^Pw∗(m)=D(wˉ∗(m))∈WP, and by construction
p∗(m)=π(w∗(m))∈Δ(Ω)p^*(m)=\pi(w^*(m))\in \Delta(\Omega)p∗(m)=π(w∗(m))∈Δ(Ω)
satisfies
p∗(m)⋅w∗(m)=max⁡u∈Wp∗(m)⋅u.p^*(m)\cdot w^*(m)=\max_{u\in W} p^*(m)\cdot u.p∗(m)⋅w∗(m)=u∈Wmax​p∗(m)⋅u.
So again
w∗(m)∈arg⁡max⁡w∈Wp∗(m)⋅w.w^*(m)\in \arg\max_{w\in W} p^*(m)\cdot w.w∗(m)∈argw∈Wmax​p∗(m)⋅w.
Therefore
w∗(m)∈arg⁡max⁡w∈Wp∗(m)⋅w∀m∈M.w^*(m)\in \arg\max_{w\in W} p^*(m)\cdot w
\qquad\forall m\in M.w∗(m)∈argw∈Wmax​p∗(m)⋅w∀m∈M.
Also, since p∗=p0p^*=p_0p∗=p0​ on M∖NM\setminus NM∖N and q∗(N)=0q^*(N)=0q∗(N)=0, we have
p∗=p0q∗-a.e.,p^*=p_0 \qquad q^*\text{-a.e.},p∗=p0​q∗-a.e.,
so p∗p^*p∗ is still a q∗q^*q∗-version of the same posterior kernel under β∗\beta^*β∗.
2. Coordinatewise monotonicity of the patch
By construction,
w∗(m)=wˉ∗(m)on M∖N,w^*(m)=\bar w^*(m)\quad\text{on }M\setminus N,w∗(m)=wˉ∗(m)on M∖N,
and on NNN,
w∗(m)=D(wˉ∗(m))≥wˉ∗(m)w^*(m)=D(\bar w^*(m))\ge \bar w^*(m)w∗(m)=D(wˉ∗(m))≥wˉ∗(m)
coordinatewise. Hence
w∗(m)≥wˉ∗(m)∀m∈M.w^*(m)\ge \bar w^*(m)\qquad\forall m\in M.w∗(m)≥wˉ∗(m)∀m∈M.
Let
Δ(m):=w∗(m)−wˉ∗(m)∈R+∣Ω∣.\Delta(m):=w^*(m)-\bar w^*(m)\in \mathbb R^{|\Omega|}_+.Δ(m):=w∗(m)−wˉ∗(m)∈R+∣Ω∣​.
3. The payoff against β∗\beta^*β∗ is unchanged
Using the posterior representation for β∗\beta^*β∗,
G(β∗,w)=∫Mq∗(dm) p0(m)⋅w(m)\mathcal G(\beta^*,w)=\int_M q^*(dm)\, p_0(m)\cdot w(m)G(β∗,w)=∫M​q∗(dm)p0​(m)⋅w(m)
for every Borel selector w:M→Ww:M\to Ww:M→W. Therefore
G(β∗,w∗)−G(β∗,wˉ∗)=∫Mq∗(dm) p0(m)⋅Δ(m)=∫Nq∗(dm) p0(m)⋅Δ(m)=0,\mathcal G(\beta^*,w^*)-\mathcal G(\beta^*,\bar w^*)
=\int_M q^*(dm)\, p_0(m)\cdot \Delta(m)
=\int_N q^*(dm)\, p_0(m)\cdot \Delta(m)
=0,G(β∗,w∗)−G(β∗,wˉ∗)=∫M​q∗(dm)p0​(m)⋅Δ(m)=∫N​q∗(dm)p0​(m)⋅Δ(m)=0,
because q∗(N)=0q^*(N)=0q∗(N)=0. So
G(β∗,w∗)=G(β∗,wˉ∗).\mathcal G(\beta^*,w^*)=\mathcal G(\beta^*,\bar w^*).G(β∗,w∗)=G(β∗,wˉ∗).
This preserves the agent side of the saddle:
G(β∗,w)≤G(β∗,wˉ∗)=G(β∗,w∗)∀ w:M→W,\mathcal G(\beta^*,w)\le \mathcal G(\beta^*,\bar w^*)
=\mathcal G(\beta^*,w^*)
\qquad \forall\, w:M\to W,G(β∗,w)≤G(β∗,wˉ∗)=G(β∗,w∗)∀w:M→W,
since (β∗,wˉ∗)(\beta^*,\bar w^*)(β∗,wˉ∗) was already a deterministic reduced saddle.
4. Adviser-side inequality against every admissible raw adviser kernel
Now fix any raw adviser kernel β∈B\beta\in Bβ∈B. Using the original reduced payoff formula,
G(β,w∗)−G(β,wˉ∗)=α∫Mτ(ds) s⋅Δ(s)+(1−α)∫Mτ(ds)∫Mβ(dm∣s) s⋅Δ(m).\mathcal G(\beta,w^*)-\mathcal G(\beta,\bar w^*)
=
\alpha\int_M \tau(ds)\, s\cdot \Delta(s)
+
(1-\alpha)\int_M \tau(ds)\int_M \beta(dm\mid s)\, s\cdot \Delta(m).G(β,w∗)−G(β,wˉ∗)=α∫M​τ(ds)s⋅Δ(s)+(1−α)∫M​τ(ds)∫M​β(dm∣s)s⋅Δ(m).
For every s∈M⊆Δ(Ω)s\in M\subseteq \Delta(\Omega)s∈M⊆Δ(Ω), the vector sss has nonnegative coordinates and sums to one. Since Δ(⋅)\Delta(\cdot)Δ(⋅) is coordinatewise nonnegative, each inner product is nonnegative:
s⋅Δ(s)≥0,s⋅Δ(m)≥0.s\cdot \Delta(s)\ge 0,\qquad s\cdot \Delta(m)\ge 0.s⋅Δ(s)≥0,s⋅Δ(m)≥0.
Hence
G(β,w∗)≥G(β,wˉ∗)∀ β∈B.\mathcal G(\beta,w^*)\ge \mathcal G(\beta,\bar w^*)
\qquad \forall\,\beta\in B.G(β,w∗)≥G(β,wˉ∗)∀β∈B.
Combining this with the original adviser-side saddle inequality for (β∗,wˉ∗)(\beta^*,\bar w^*)(β∗,wˉ∗),
G(β∗,wˉ∗)≤G(β,wˉ∗)∀ β∈B,\mathcal G(\beta^*,\bar w^*)\le \mathcal G(\beta,\bar w^*)
\qquad \forall\,\beta\in B,G(β∗,wˉ∗)≤G(β,wˉ∗)∀β∈B,
gives
G(β∗,w∗)=G(β∗,wˉ∗)≤G(β,wˉ∗)≤G(β,w∗)∀ β∈B.\mathcal G(\beta^*,w^*)
=
\mathcal G(\beta^*,\bar w^*)
\le
\mathcal G(\beta,\bar w^*)
\le
\mathcal G(\beta,w^*)
\qquad \forall\,\beta\in B.G(β∗,w∗)=G(β∗,wˉ∗)≤G(β,wˉ∗)≤G(β,w∗)∀β∈B.
So β∗\beta^*β∗ remains optimal against the patched selector w∗w^*w∗ among all raw adviser kernels.
5. Conclusion
We have proved:


p∗=p0p^*=p_0p∗=p0​ q∗q^*q∗-a.e., so p∗p^*p∗ is still a posterior version under β∗\beta^*β∗;


for every message mmm,
w∗(m)∈arg⁡max⁡w∈Wp∗(m)⋅w;w^*(m)\in \arg\max_{w\in W} p^*(m)\cdot w;w∗(m)∈argw∈Wmax​p∗(m)⋅w;


for every mmm,
w∗(m)≥wˉ∗(m)w^*(m)\ge \bar w^*(m)w∗(m)≥wˉ∗(m)
coordinatewise;


(β∗,w∗)(\beta^*,w^*)(β∗,w∗) is a saddle point of the deterministic reduced game:
G(β∗,w)≤G(β∗,w∗)≤G(β,w∗)∀ w, ∀ β∈B.\mathcal G(\beta^*,w)\le \mathcal G(\beta^*,w^*)\le \mathcal G(\beta,w^*)
\qquad \forall\, w,\ \forall\,\beta\in B.G(β∗,w)≤G(β∗,w∗)≤G(β,w∗)∀w, ∀β∈B.


So the continuity-conditioned patching step succeeds. There is no further local obstruction after the lifting repair. The continuity hypothesis is only needed upstream, to ensure that one can start from a raw-kernel saddle (β∗,wˉ∗)(\beta^*,\bar w^*)(β∗,wˉ∗); once that is in hand, the null-set monotone patch preserves adviser-side optimality against every raw β∈B\beta\in Bβ∈B. The patch may destroy continuity of w∗w^*w∗, but that does not matter for this lemma, because no second lifting step is needed here.
