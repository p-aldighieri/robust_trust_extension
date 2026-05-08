I’m consolidating the route memo, both reviewer passes, and the durable proof-state notes into one tight three-part conditional theorem package with exactly one isolated extra assumption and no branch broadening.Least-strengthened exact route
1. Unconditional inputs already proved
The strongest fully trusted theorem remains the partial extension: a robustly rationalizable strategy exists when MMM is finite and Θ\ThetaΘ is compact metric. For the exact route beyond finite MMM, the reduced-game side is already in hand: one works on the compact convex payoff set WWW, has the reduced relaxed saddle machinery and barycentric collapse to a deterministic pair (β∗,wˉ∗)(\beta^*,\bar w^*)(β∗,wˉ∗), has the selector package (D,π)(D,\pi)(D,π) on WWW, and has the pre-patching adviser-side inequality
G(β∗,wˉ∗)≤G(β,wˉ∗)∀β∈B.\mathcal G(\beta^*,\bar w^*)\le \mathcal G(\beta,\bar w^*)\qquad\forall \beta\in B.G(β∗,wˉ∗)≤G(β,wˉ∗)∀β∈B.
The only live obstruction on this route is message-side exactness. In particular, the current continuity-based raw lift gives only
wˉ#∗β∗=κ∗,\bar w^*_{\#}\beta^*=\kappa^*,wˉ#∗​β∗=κ∗,
which preserves collapsed payoffs but does not imply the posterior-labeled local-optimality statement needed for null-set patching.    
2. Needed assumption
The chosen raw lift β∗\beta^*β∗ admits a Borel posterior version
p0:M→Δ(Ω)p_0:M\to\Delta(\Omega)p0​:M→Δ(Ω)
such that
wˉ∗(m)∈arg⁡max⁡w∈Wp0(m)⋅wfor q∗-a.e. m.\bar w^*(m)\in \arg\max_{w\in W} p_0(m)\cdot w
\qquad\text{for }q^*\text{-a.e. }m.wˉ∗(m)∈argw∈Wmax​p0​(m)⋅wfor q∗-a.e. m.

3. Resulting exact conditional theorem
Under the unconditional inputs above and the Needed assumption, let
g(m):=hW(p0(m))−p0(m)⋅wˉ∗(m),N:={m:g(m)>0},g(m):=h_W(p_0(m))-p_0(m)\cdot \bar w^*(m),
\qquad
N:=\{m:g(m)>0\},g(m):=hW​(p0​(m))−p0​(m)⋅wˉ∗(m),N:={m:g(m)>0},
where hW(p)=max⁡w∈Wp⋅wh_W(p)=\max_{w\in W}p\cdot whW​(p)=maxw∈W​p⋅w. Then NNN is Borel and q∗(N)=0q^*(N)=0q∗(N)=0. Patch only on NNN by
w∗(m)=D(wˉ∗(m)),p∗(m)=π(w∗(m)),w^*(m)=D(\bar w^*(m)),\qquad p^*(m)=\pi(w^*(m)),w∗(m)=D(wˉ∗(m)),p∗(m)=π(w∗(m)),
and keep w∗=wˉ∗w^*=\bar w^*w∗=wˉ∗, p∗=p0p^*=p_0p∗=p0​ on M∖NM\setminus NM∖N. The patched maps are Borel, p∗=p0p^*=p_0p∗=p0​ q∗q^*q∗-a.e. and hence p∗p^*p∗ is still a posterior version under β∗\beta^*β∗, w∗w^*w∗ is Bayes-optimal at every message relative to the Borel posterior version p∗p^*p∗, and
G(β∗,w)≤G(β∗,w∗)≤G(β,w∗)∀w, ∀β.\mathcal G(\beta^*,w)\le \mathcal G(\beta^*,w^*)\le \mathcal G(\beta,w^*)
\qquad\forall w,\ \forall\beta.G(β∗,w)≤G(β∗,w∗)≤G(β,w∗)∀w, ∀β.
So (β∗,w∗)(\beta^*,w^*)(β∗,w∗) is a full reduced-game saddle. This is the current exact-route frontier: beyond finite MMM, the route is conditionally closed at its hinge, and the only remaining gap is to prove the Needed assumption for the chosen raw lift. 
Suggested next local action: focus exclusively on proving the Needed assumption for the chosen raw lift.
