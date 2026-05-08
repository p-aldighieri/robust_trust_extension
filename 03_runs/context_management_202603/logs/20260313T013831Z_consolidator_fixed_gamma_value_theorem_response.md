I’m consolidating the theorem packet and support notes into a clean result note, extracting the exact local target and aligning it with the durable proof state so the writeup keeps the strongest surviving split: value equality survives, but exact raw lifting does not.An explicit counterexample is now pinned down, with the raw-lifting failure traced to a closure point. I’m polishing the local statement so it reads as a stable theorem note rather than a route memo.Fixed-γ\gammaγ raw-vs-compactified value theorem
Work under the standing assumptions of the reduced game. Let
M=supp⁡(τ)⊆Δ(Ω),M=\operatorname{supp}(\tau)\subseteq \Delta(\Omega),M=supp(τ)⊆Δ(Ω),
with Ω\OmegaΩ finite, and let W⊂RΩW\subset \mathbb R^\OmegaW⊂RΩ be the compact convex payoff set from Appendix A.1. Fix a Borel measurable relaxed reduced-agent kernel
γ:M⇝Δ(W),Γγ(m):=γ(⋅∣m)∈Δ(W).\gamma:M\rightsquigarrow \Delta(W),
\qquad
\Gamma_\gamma(m):=\gamma(\cdot\mid m)\in \Delta(W).γ:M⇝Δ(W),Γγ​(m):=γ(⋅∣m)∈Δ(W).
Define
Φ(s,μ):=∫Ws⋅w μ(dw),(s,μ)∈M×Δ(W),\Phi(s,\mu):=\int_W s\cdot w\,\mu(dw),
\qquad (s,\mu)\in M\times \Delta(W),Φ(s,μ):=∫W​s⋅wμ(dw),(s,μ)∈M×Δ(W),
and the barycentric image
wˉγ(m):=∫Ww Γγ(m)(dw)∈W.\bar w_\gamma(m):=\int_W w\,\Gamma_\gamma(m)(dw)\in W.wˉγ​(m):=∫W​wΓγ​(m)(dw)∈W.
Then
Φ(s,Γγ(m))=s⋅wˉγ(m).\Phi\bigl(s,\Gamma_\gamma(m)\bigr)=s\cdot \bar w_\gamma(m).Φ(s,Γγ​(m))=s⋅wˉγ​(m).
Set
Kγ:=co⁡‾(Γγ(M))⊆Δ(W),K_\gamma:=\overline{\operatorname{co}}\bigl(\Gamma_\gamma(M)\bigr)\subseteq \Delta(W),Kγ​:=co(Γγ​(M))⊆Δ(W),
Q(τ,Kγ):={Λ∈Δ(M×Kγ):ΛS=τ},\mathcal Q(\tau,K_\gamma):=\{\Lambda\in \Delta(M\times K_\gamma): \Lambda_S=\tau\},Q(τ,Kγ​):={Λ∈Δ(M×Kγ​):ΛS​=τ},
and
Cγ:=α(id⁡,Γγ)#τ+(1−α)Q(τ,Kγ).\mathcal C_\gamma
:=
\alpha(\operatorname{id},\Gamma_\gamma)_\#\tau
+
(1-\alpha)\mathcal Q(\tau,K_\gamma).Cγ​:=α(id,Γγ​)#​τ+(1−α)Q(τ,Kγ​).
Equivalently, Λ∈Cγ\Lambda\in \mathcal C_\gammaΛ∈Cγ​ iff
Λ(ds,dμ)=τ(ds)[α δΓγ(s)(dμ)+(1−α)ζ(dμ∣s)]\Lambda(ds,d\mu)
=
\tau(ds)\Big[\alpha\,\delta_{\Gamma_\gamma(s)}(d\mu)+(1-\alpha)\zeta(d\mu\mid s)\Big]Λ(ds,dμ)=τ(ds)[αδΓγ​(s)​(dμ)+(1−α)ζ(dμ∣s)]
for some measurable kernel ζ:M⇝Δ(Kγ)\zeta:M\rightsquigarrow \Delta(K_\gamma)ζ:M⇝Δ(Kγ​).
Finally, define
Lγ(Λ):=∫M×KγΦ(s,μ) Λ(ds,dμ),L_\gamma(\Lambda):=\int_{M\times K_\gamma}\Phi(s,\mu)\,\Lambda(ds,d\mu),Lγ​(Λ):=∫M×Kγ​​Φ(s,μ)Λ(ds,dμ),
and the raw adviser value
Jγraw:=α∫MΦ(s,Γγ(s)) τ(ds)+(1−α)inf⁡β∫M∫MΦ(s,Γγ(m)) β(dm∣s) τ(ds),J_\gamma^{\mathrm{raw}}
:=
\alpha\int_M \Phi\bigl(s,\Gamma_\gamma(s)\bigr)\,\tau(ds)
+
(1-\alpha)\inf_{\beta}
\int_M\int_M \Phi\bigl(s,\Gamma_\gamma(m)\bigr)\,\beta(dm\mid s)\,\tau(ds),Jγraw​:=α∫M​Φ(s,Γγ​(s))τ(ds)+(1−α)βinf​∫M​∫M​Φ(s,Γγ​(m))β(dm∣s)τ(ds),
where the infimum is over all Borel measurable adviser kernels β:M⇝Δ(M)\beta:M\rightsquigarrow \Delta(M)β:M⇝Δ(M).
Theorem
For every fixed relaxed kernel γ\gammaγ:


Cγ\mathcal C_\gammaCγ​ is compact and convex in the weak topology on Δ(M×Δ(W))\Delta(M\times \Delta(W))Δ(M×Δ(W)).


LγL_\gammaLγ​ is affine and weakly continuous on Cγ\mathcal C_\gammaCγ​.


The compactified adviser problem has the exact value formula
min⁡Λ∈CγLγ(Λ)=α∫MΦ(s,Γγ(s)) τ(ds)+(1−α)∫Minf⁡m∈MΦ(s,Γγ(m)) τ(ds).\min_{\Lambda\in \mathcal C_\gamma}L_\gamma(\Lambda)
=
\alpha\int_M \Phi\bigl(s,\Gamma_\gamma(s)\bigr)\,\tau(ds)
+
(1-\alpha)\int_M \inf_{m\in M}\Phi\bigl(s,\Gamma_\gamma(m)\bigr)\,\tau(ds).Λ∈Cγ​min​Lγ​(Λ)=α∫M​Φ(s,Γγ​(s))τ(ds)+(1−α)∫M​m∈Minf​Φ(s,Γγ​(m))τ(ds).


There is no value gap between the compactified and raw adviser problems:
Jγraw=min⁡Λ∈CγLγ(Λ).J_\gamma^{\mathrm{raw}}
=
\min_{\Lambda\in \mathcal C_\gamma}L_\gamma(\Lambda).Jγraw​=Λ∈Cγ​min​Lγ​(Λ).


So for fixed γ\gammaγ, the adviser-side compactification is exact at the level of values.
Proof
Because M⊆Δ(Ω)M\subseteq \Delta(\Omega)M⊆Δ(Ω) and Ω\OmegaΩ is finite, MMM is compact metric. Since WWW is compact metric, Δ(W)\Delta(W)Δ(W) is compact metric in the weak topology, hence KγK_\gammaKγ​ is compact and convex.
The set Q(τ,Kγ)\mathcal Q(\tau,K_\gamma)Q(τ,Kγ​) is convex. It is weakly closed because the first-marginal map
Λ↦ΛS\Lambda\mapsto \Lambda_SΛ↦ΛS​
is weakly continuous. Since Δ(M×Kγ)\Delta(M\times K_\gamma)Δ(M×Kγ​) is compact, Q(τ,Kγ)\mathcal Q(\tau,K_\gamma)Q(τ,Kγ​) is compact. Therefore Cγ\mathcal C_\gammaCγ​, being the affine image
Λ′↦α(id⁡,Γγ)#τ+(1−α)Λ′,\Lambda'\mapsto \alpha(\operatorname{id},\Gamma_\gamma)_\#\tau+(1-\alpha)\Lambda',Λ′↦α(id,Γγ​)#​τ+(1−α)Λ′,
is also compact and convex.
The map (s,w)↦s⋅w(s,w)\mapsto s\cdot w(s,w)↦s⋅w is continuous on M×WM\times WM×W, so Φ\PhiΦ is continuous on M×Δ(W)M\times \Delta(W)M×Δ(W) and affine in its second argument. Hence Lγ(Λ)=∫Φ dΛL_\gamma(\Lambda)=\int \Phi\,d\LambdaLγ​(Λ)=∫ΦdΛ is affine and weakly continuous.
Now take Λ∈Cγ\Lambda\in \mathcal C_\gammaΛ∈Cγ​. Write
Λ=α(id⁡,Γγ)#τ+(1−α)Λ′\Lambda=\alpha(\operatorname{id},\Gamma_\gamma)_\#\tau+(1-\alpha)\Lambda'Λ=α(id,Γγ​)#​τ+(1−α)Λ′
with Λ′∈Q(τ,Kγ)\Lambda'\in \mathcal Q(\tau,K_\gamma)Λ′∈Q(τ,Kγ​). Disintegrate
Λ′(ds,dμ)=τ(ds)ζ(dμ∣s)\Lambda'(ds,d\mu)=\tau(ds)\zeta(d\mu\mid s)Λ′(ds,dμ)=τ(ds)ζ(dμ∣s)
for a measurable kernel ζ:M⇝Δ(Kγ)\zeta:M\rightsquigarrow \Delta(K_\gamma)ζ:M⇝Δ(Kγ​). Then
Lγ(Λ)=α∫MΦ(s,Γγ(s)) τ(ds)+(1−α)∫M[∫KγΦ(s,μ) ζ(dμ∣s)]τ(ds).L_\gamma(\Lambda)
=
\alpha\int_M \Phi\bigl(s,\Gamma_\gamma(s)\bigr)\,\tau(ds)
+
(1-\alpha)\int_M\left[\int_{K_\gamma}\Phi(s,\mu)\,\zeta(d\mu\mid s)\right]\tau(ds).Lγ​(Λ)=α∫M​Φ(s,Γγ​(s))τ(ds)+(1−α)∫M​[∫Kγ​​Φ(s,μ)ζ(dμ∣s)]τ(ds).
For each sss,
∫KγΦ(s,μ) ζ(dμ∣s)≥min⁡μ∈KγΦ(s,μ),\int_{K_\gamma}\Phi(s,\mu)\,\zeta(d\mu\mid s)\ge \min_{\mu\in K_\gamma}\Phi(s,\mu),∫Kγ​​Φ(s,μ)ζ(dμ∣s)≥μ∈Kγ​min​Φ(s,μ),
so
Lγ(Λ)≥α∫MΦ(s,Γγ(s)) τ(ds)+(1−α)∫Mmin⁡μ∈KγΦ(s,μ) τ(ds).L_\gamma(\Lambda)\ge
\alpha\int_M \Phi\bigl(s,\Gamma_\gamma(s)\bigr)\,\tau(ds)
+
(1-\alpha)\int_M \min_{\mu\in K_\gamma}\Phi(s,\mu)\,\tau(ds).Lγ​(Λ)≥α∫M​Φ(s,Γγ​(s))τ(ds)+(1−α)∫M​μ∈Kγ​min​Φ(s,μ)τ(ds).
Because Φ\PhiΦ is continuous and KγK_\gammaKγ​ is compact, the argmin correspondence
A(s):=arg⁡min⁡μ∈KγΦ(s,μ)A(s):=\arg\min_{\mu\in K_\gamma}\Phi(s,\mu)A(s):=argμ∈Kγ​min​Φ(s,μ)
has nonempty compact values. Since Φ\PhiΦ is continuous on the compact metric space M×KγM\times K_\gammaM×Kγ​, the measurable maximum theorem gives a Borel selector μ∗:M→Kγ\mu^*:M\to K_\gammaμ∗:M→Kγ​ with μ∗(s)∈A(s)\mu^*(s)\in A(s)μ∗(s)∈A(s) for every sss. Choosing
Λ∗(ds,dμ)=τ(ds)[α δΓγ(s)(dμ)+(1−α)δμ∗(s)(dμ)]\Lambda^*(ds,d\mu)
=
\tau(ds)\Big[\alpha\,\delta_{\Gamma_\gamma(s)}(d\mu)+(1-\alpha)\delta_{\mu^*(s)}(d\mu)\Big]Λ∗(ds,dμ)=τ(ds)[αδΓγ​(s)​(dμ)+(1−α)δμ∗(s)​(dμ)]
shows that the lower bound is attained. Therefore
min⁡Λ∈CγLγ(Λ)=α∫MΦ(s,Γγ(s)) τ(ds)+(1−α)∫Mmin⁡μ∈KγΦ(s,μ) τ(ds).\min_{\Lambda\in \mathcal C_\gamma}L_\gamma(\Lambda)
=
\alpha\int_M \Phi\bigl(s,\Gamma_\gamma(s)\bigr)\,\tau(ds)
+
(1-\alpha)\int_M \min_{\mu\in K_\gamma}\Phi(s,\mu)\,\tau(ds).Λ∈Cγ​min​Lγ​(Λ)=α∫M​Φ(s,Γγ​(s))τ(ds)+(1−α)∫M​μ∈Kγ​min​Φ(s,μ)τ(ds).
It remains to identify the pointwise minimum over KγK_\gammaKγ​. Since Φ(s,⋅)\Phi(s,\cdot)Φ(s,⋅) is continuous and affine,
min⁡μ∈KγΦ(s,μ)=inf⁡m∈MΦ(s,Γγ(m)).\min_{\mu\in K_\gamma}\Phi(s,\mu)
=
\inf_{m\in M}\Phi\bigl(s,\Gamma_\gamma(m)\bigr).μ∈Kγ​min​Φ(s,μ)=m∈Minf​Φ(s,Γγ​(m)).
This gives the compactified value formula.
To compare with the raw adviser problem, set
vγ(s):=inf⁡m∈MΦ(s,Γγ(m))=inf⁡m∈Ms⋅wˉγ(m).v_\gamma(s):=\inf_{m\in M}\Phi\bigl(s,\Gamma_\gamma(m)\bigr)
=\inf_{m\in M}s\cdot \bar w_\gamma(m).vγ​(s):=m∈Minf​Φ(s,Γγ​(m))=m∈Minf​s⋅wˉγ​(m).
For any measurable adviser kernel β\betaβ,
∫MΦ(s,Γγ(m)) β(dm∣s)≥vγ(s),\int_M \Phi\bigl(s,\Gamma_\gamma(m)\bigr)\,\beta(dm\mid s)\ge v_\gamma(s),∫M​Φ(s,Γγ​(m))β(dm∣s)≥vγ​(s),
hence
inf⁡β∫M∫MΦ(s,Γγ(m)) β(dm∣s) τ(ds)≥∫Mvγ(s) τ(ds).\inf_\beta
\int_M\int_M \Phi\bigl(s,\Gamma_\gamma(m)\bigr)\,\beta(dm\mid s)\,\tau(ds)
\ge
\int_M v_\gamma(s)\,\tau(ds).βinf​∫M​∫M​Φ(s,Γγ​(m))β(dm∣s)τ(ds)≥∫M​vγ​(s)τ(ds).
For the reverse inequality, let
Wˉγ:=wˉγ(M)⊆W.\bar W_\gamma:=\bar w_\gamma(M)\subseteq W.Wˉγ​:=wˉγ​(M)⊆W.
Since WWW is compact metric, Wˉγ\bar W_\gammaWˉγ​ is separable. Choose a countable dense subset {xn}n≥1⊆Wˉγ\{x_n\}_{n\ge1}\subseteq \bar W_\gamma{xn​}n≥1​⊆Wˉγ​, and for each nnn choose mn∈Mm_n\in Mmn​∈M such that wˉγ(mn)=xn\bar w_\gamma(m_n)=x_nwˉγ​(mn​)=xn​. Then
vγ(s)=inf⁡n≥1s⋅xn,v_\gamma(s)=\inf_{n\ge1}s\cdot x_n,vγ​(s)=n≥1inf​s⋅xn​,
so vγv_\gammavγ​ is Borel as a countable infimum of continuous functions. Fix ε>0\varepsilon>0ε>0, and define the Borel partition
E1ε:={s:s⋅x1≤vγ(s)+ε},E_1^\varepsilon:=\{s:s\cdot x_1\le v_\gamma(s)+\varepsilon\},E1ε​:={s:s⋅x1​≤vγ​(s)+ε},
Enε:={s:s⋅xn≤vγ(s)+ε}∖⋃k<nEkε,n≥2.E_n^\varepsilon:=\{s:s\cdot x_n\le v_\gamma(s)+\varepsilon\}\setminus \bigcup_{k<n}E_k^\varepsilon,\qquad n\ge2.Enε​:={s:s⋅xn​≤vγ​(s)+ε}∖k<n⋃​Ekε​,n≥2.
Define mε(s):=mnm_\varepsilon(s):=m_nmε​(s):=mn​ on EnεE_n^\varepsilonEnε​, and let
βε(dm∣s):=δmε(s)(dm).\beta_\varepsilon(dm\mid s):=\delta_{m_\varepsilon(s)}(dm).βε​(dm∣s):=δmε​(s)​(dm).
Then for every sss,
Φ(s,Γγ(mε(s)))≤vγ(s)+ε,\Phi\bigl(s,\Gamma_\gamma(m_\varepsilon(s))\bigr)\le v_\gamma(s)+\varepsilon,Φ(s,Γγ​(mε​(s)))≤vγ​(s)+ε,
so
∫M∫MΦ(s,Γγ(m)) βε(dm∣s) τ(ds)≤∫Mvγ(s) τ(ds)+ε.\int_M\int_M \Phi\bigl(s,\Gamma_\gamma(m)\bigr)\,\beta_\varepsilon(dm\mid s)\,\tau(ds)
\le
\int_M v_\gamma(s)\,\tau(ds)+\varepsilon.∫M​∫M​Φ(s,Γγ​(m))βε​(dm∣s)τ(ds)≤∫M​vγ​(s)τ(ds)+ε.
Letting ε↓0\varepsilon\downarrow0ε↓0 yields
inf⁡β∫M∫MΦ(s,Γγ(m)) β(dm∣s) τ(ds)=∫Mvγ(s) τ(ds).\inf_\beta
\int_M\int_M \Phi\bigl(s,\Gamma_\gamma(m)\bigr)\,\beta(dm\mid s)\,\tau(ds)
=
\int_M v_\gamma(s)\,\tau(ds).βinf​∫M​∫M​Φ(s,Γγ​(m))β(dm∣s)τ(ds)=∫M​vγ​(s)τ(ds).
Substituting back gives
Jγraw=min⁡Λ∈CγLγ(Λ).J_\gamma^{\mathrm{raw}}=\min_{\Lambda\in \mathcal C_\gamma}L_\gamma(\Lambda).Jγraw​=Λ∈Cγ​min​Lγ​(Λ).
This proves the theorem.

Counterexample to exact raw lifting and raw attainment
The value identity above does not imply that a compactified minimizer can be lifted exactly to a raw measurable adviser kernel, and it does not imply that the raw infimum is attained.
Proposition
Fix any α∈[0,1)\alpha\in[0,1)α∈[0,1). There exist standing-assumption primitives and a deterministic relaxed kernel γ\gammaγ such that:


min⁡Λ∈CγLγ(Λ)\min_{\Lambda\in \mathcal C_\gamma}L_\gamma(\Lambda)minΛ∈Cγ​​Lγ​(Λ) is attained;


Jγraw=min⁡Λ∈CγLγ(Λ)J_\gamma^{\mathrm{raw}}=\min_{\Lambda\in \mathcal C_\gamma}L_\gamma(\Lambda)Jγraw​=minΛ∈Cγ​​Lγ​(Λ);


no raw measurable adviser kernel β:M⇝Δ(M)\beta:M\rightsquigarrow \Delta(M)β:M⇝Δ(M) attains JγrawJ_\gamma^{\mathrm{raw}}Jγraw​.


Equivalently, exact raw lifting of compactified minimizers can fail.
Construction
Let Ω={0,1}\Omega=\{0,1\}Ω={0,1}, identify beliefs with [0,1][0,1][0,1], let
M=[0,1],M=[0,1],M=[0,1],
and let τ\tauτ be any full-support Borel probability on MMM.
Take Θ={∗}\Theta=\{\ast\}Θ={∗}, A=[0,1]A=[0,1]A=[0,1], and
u(a,ω,∗)≡a.u(a,\omega,\ast)\equiv a.u(a,ω,∗)≡a.
Then the feasible reduced payoff set is
W={(a,a):a∈[0,1]}⊂RΩ,W=\{(a,a):a\in[0,1]\}\subset \mathbb R^\Omega,W={(a,a):a∈[0,1]}⊂RΩ,
which is compact and convex.
Define
g(0):=1,g(m):=m for m∈(0,1].g(0):=1,\qquad g(m):=m\ \text{for }m\in(0,1].g(0):=1,g(m):=m for m∈(0,1].
Then g(m)>0g(m)>0g(m)>0 for every m∈Mm\in Mm∈M, but
inf⁡m∈Mg(m)=0\inf_{m\in M}g(m)=0m∈Minf​g(m)=0
and the infimum is not attained.
Now define the deterministic relaxed kernel
γ(⋅∣m):=δ(g(m),g(m)).\gamma(\cdot\mid m):=\delta_{(g(m),g(m))}.γ(⋅∣m):=δ(g(m),g(m))​.
Then
wˉγ(m)=(g(m),g(m)),\bar w_\gamma(m)=(g(m),g(m)),wˉγ​(m)=(g(m),g(m)),
so for every s∈Ms\in Ms∈M,
Φ(s,Γγ(m))=s⋅(g(m),g(m))=g(m).\Phi\bigl(s,\Gamma_\gamma(m)\bigr)=s\cdot (g(m),g(m))=g(m).Φ(s,Γγ​(m))=s⋅(g(m),g(m))=g(m).
Hence
inf⁡m∈MΦ(s,Γγ(m))=0for every s.\inf_{m\in M}\Phi\bigl(s,\Gamma_\gamma(m)\bigr)=0
\qquad\text{for every }s.m∈Minf​Φ(s,Γγ​(m))=0for every s.
Why the compactified problem attains the minimum
The raw image is
wˉγ(M)={(a,a):a∈(0,1]},\bar w_\gamma(M)=\{(a,a):a\in(0,1]\},wˉγ​(M)={(a,a):a∈(0,1]},
whose closure contains (0,0)(0,0)(0,0). Therefore
δ(0,0)∈Kγ.\delta_{(0,0)}\in K_\gamma.δ(0,0)​∈Kγ​.
Choose the constant compactified selector μ∗(s)≡δ(0,0)\mu^*(s)\equiv \delta_{(0,0)}μ∗(s)≡δ(0,0)​. Then the induced Λ∗∈Cγ\Lambda^*\in \mathcal C_\gammaΛ∗∈Cγ​ satisfies
Lγ(Λ∗)=α∫Mg(s) τ(ds)+(1−α)⋅0.L_\gamma(\Lambda^*)
=
\alpha\int_M g(s)\,\tau(ds)+(1-\alpha)\cdot 0.Lγ​(Λ∗)=α∫M​g(s)τ(ds)+(1−α)⋅0.
So the compactified minimum is attained.
Why no raw kernel attains the same value
Fix any measurable adviser kernel β:M⇝Δ(M)\beta:M\rightsquigarrow \Delta(M)β:M⇝Δ(M). For every sss,
∫MΦ(s,Γγ(m)) β(dm∣s)=∫Mg(m) β(dm∣s).\int_M \Phi\bigl(s,\Gamma_\gamma(m)\bigr)\,\beta(dm\mid s)
=
\int_M g(m)\,\beta(dm\mid s).∫M​Φ(s,Γγ​(m))β(dm∣s)=∫M​g(m)β(dm∣s).
Since g(m)>0g(m)>0g(m)>0 for every actual message m∈Mm\in Mm∈M, this integral is strictly positive for every sss. Therefore
∫M∫MΦ(s,Γγ(m)) β(dm∣s) τ(ds)>0,\int_M\int_M \Phi\bigl(s,\Gamma_\gamma(m)\bigr)\,\beta(dm\mid s)\,\tau(ds)>0,∫M​∫M​Φ(s,Γγ​(m))β(dm∣s)τ(ds)>0,
and hence
α∫Mg(s) τ(ds)+(1−α)∫M∫MΦ(s,Γγ(m)) β(dm∣s) τ(ds)>α∫Mg(s) τ(ds).\alpha\int_M g(s)\,\tau(ds)
+
(1-\alpha)\int_M\int_M \Phi\bigl(s,\Gamma_\gamma(m)\bigr)\,\beta(dm\mid s)\,\tau(ds)
>
\alpha\int_M g(s)\,\tau(ds).α∫M​g(s)τ(ds)+(1−α)∫M​∫M​Φ(s,Γγ​(m))β(dm∣s)τ(ds)>α∫M​g(s)τ(ds).
So no raw kernel attains JγrawJ_\gamma^{\mathrm{raw}}Jγraw​.
Why the raw infimum still equals the compactified value
For each nnn, let
βn(dm∣s):=δ1/n(dm).\beta_n(dm\mid s):=\delta_{1/n}(dm).βn​(dm∣s):=δ1/n​(dm).
Then
∫M∫MΦ(s,Γγ(m)) βn(dm∣s) τ(ds)=g(1/n)=1/n→0.\int_M\int_M \Phi\bigl(s,\Gamma_\gamma(m)\bigr)\,\beta_n(dm\mid s)\,\tau(ds)
=
g(1/n)=1/n\to 0.∫M​∫M​Φ(s,Γγ​(m))βn​(dm∣s)τ(ds)=g(1/n)=1/n→0.
Hence
Jγraw=α∫Mg(s) τ(ds)=min⁡Λ∈CγLγ(Λ),J_\gamma^{\mathrm{raw}}
=
\alpha\int_M g(s)\,\tau(ds)
=
\min_{\Lambda\in \mathcal C_\gamma}L_\gamma(\Lambda),Jγraw​=α∫M​g(s)τ(ds)=Λ∈Cγ​min​Lγ​(Λ),
but the raw infimum is not attained.
This proves the counterexample.

Exact interpretation
The strongest surviving beyond-finite-MMM statement under the standing assumptions is now:


for each fixed relaxed kernel γ\gammaγ, adviser-side compactification is exact at the level of values;


exact raw lifting and exact raw attainment can fail at the level of strategies.


The obstruction is not a measurable-selection failure inside the compactified problem. The obstruction is representability: the compactified minimizer may sit at a closure point of Γγ(M)\Gamma_\gamma(M)Γγ​(M), equivalently of wˉγ(M)\bar w_\gamma(M)wˉγ​(M), that is not realized by any raw message. Raw kernels can approximate that point arbitrarily well in value, but they need not realize it exactly.
Accordingly, this note does not prove robustly rationalizable existence beyond finite MMM, and it does not provide a γ\gammaγ-independent adviser compactification suitable for a full saddle-point argument.
Needed assumption for the stronger strategy-level statement
A sufficient extra assumption is:
Needed assumption. The barycentric image map
m↦wˉγ(m)m\mapsto \bar w_\gamma(m)m↦wˉγ​(m)
is continuous on MMM.
Under this added assumption, wˉγ(M)\bar w_\gamma(M)wˉγ​(M) is compact, the pointwise minimum
min⁡m∈Ms⋅wˉγ(m)\min_{m\in M}s\cdot \bar w_\gamma(m)m∈Mmin​s⋅wˉγ​(m)
is attained for every sss, the argmin correspondence has nonempty compact values and closed graph, and a Borel measurable exact minimizer m∗(s)m^*(s)m∗(s) exists. Then compactified minimizers lift exactly to raw deterministic adviser kernels.
That assumption is not part of the standing hypotheses, so it cannot be used on the live route without being added explicitly.

Suggested next local action: update proof_state.md so the active beyond-finite-MMM local endpoint is the fixed-γ\gammaγ value theorem plus the nonattainment counterexample, and retire the exact lifting / patching target unless an explicit regularity assumption is added.
