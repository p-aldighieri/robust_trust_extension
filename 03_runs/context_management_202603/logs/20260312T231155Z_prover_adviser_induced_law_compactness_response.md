I’m reading the lemma packet and support notes, then I’ll either salvage the adviser-side reduced-game object in a precise form or pin down the obstruction cleanly.I’m cross-checking the target lemma against the counterexample, route memo, and proof-state notes to see whether the adviser-side compactness/semicontinuity claim survives in a reduced local form.Lemma proved in a usable fixed-γ\gammaγ form
Let M=supp⁡(τ)⊆Δ(Ω)M=\operatorname{supp}(\tau)\subseteq \Delta(\Omega)M=supp(τ)⊆Δ(Ω), let W⊂RΩW\subset \mathbb R^\OmegaW⊂RΩ be the compact convex payoff set from Appendix A.1, and let
γ:M⇝Δ(W)\gamma: M \rightsquigarrow \Delta(W)γ:M⇝Δ(W)
be a relaxed reduced-agent kernel. Write
Γγ(m):=γ(⋅∣m)∈Δ(W),\Gamma_\gamma(m):=\gamma(\cdot\mid m)\in \Delta(W),Γγ​(m):=γ(⋅∣m)∈Δ(W),
viewing γ\gammaγ as a measurable map M→Δ(W)M\to \Delta(W)M→Δ(W). Define
Φ(s,μ):=∫Ws⋅w μ(dw),(s,μ)∈M×Δ(W).\Phi(s,\mu):=\int_W s\cdot w\,\mu(dw), \qquad (s,\mu)\in M\times \Delta(W).Φ(s,μ):=∫W​s⋅wμ(dw),(s,μ)∈M×Δ(W).
Then Φ\PhiΦ is bounded and continuous.
Define the compact convex hull of the image of γ\gammaγ:
Kγ:=co⁡‾(Γγ(M))⊆Δ(W).K_\gamma:=\overline{\operatorname{co}}\bigl(\Gamma_\gamma(M)\bigr)\subseteq \Delta(W).Kγ​:=co(Γγ​(M))⊆Δ(W).
Since Δ(W)\Delta(W)Δ(W) is compact metric, KγK_\gammaKγ​ is compact and convex.
Now define the adviser-side induced-law class
Q(τ,Kγ):={Λ∈Δ(M×Kγ):ΛS=τ},\mathcal Q(\tau,K_\gamma):=\{\Lambda\in \Delta(M\times K_\gamma): \Lambda_S=\tau\},Q(τ,Kγ​):={Λ∈Δ(M×Kγ​):ΛS​=τ},
where ΛS\Lambda_SΛS​ denotes the first marginal, and then
Cγ:=α (id⁡,Γγ)#τ+(1−α) Q(τ,Kγ).\mathcal C_\gamma
:=
\alpha\,(\operatorname{id},\Gamma_\gamma)_\#\tau
+
(1-\alpha)\,\mathcal Q(\tau,K_\gamma).Cγ​:=α(id,Γγ​)#​τ+(1−α)Q(τ,Kγ​).
Equivalently, Λ∈Cγ\Lambda\in \mathcal C_\gammaΛ∈Cγ​ iff
Λ(ds,dμ)=τ(ds)[α δΓγ(s)(dμ)+(1−α)ζ(dμ∣s)]\Lambda(ds,d\mu)
=
\tau(ds)\Big[\alpha\,\delta_{\Gamma_\gamma(s)}(d\mu)+(1-\alpha)\zeta(d\mu\mid s)\Big]Λ(ds,dμ)=τ(ds)[αδΓγ​(s)​(dμ)+(1−α)ζ(dμ∣s)]
for some measurable kernel ζ:M⇝Δ(Kγ)\zeta: M\rightsquigarrow \Delta(K_\gamma)ζ:M⇝Δ(Kγ​).
Define the linear payoff functional
Lγ(Λ):=∫M×KγΦ(s,μ) Λ(ds,dμ).L_\gamma(\Lambda):=\int_{M\times K_\gamma}\Phi(s,\mu)\,\Lambda(ds,d\mu).Lγ​(Λ):=∫M×Kγ​​Φ(s,μ)Λ(ds,dμ).
Claim
For every fixed relaxed kernel γ\gammaγ,


Cγ\mathcal C_\gammaCγ​ is compact and convex in the weak topology on Δ(M×Δ(W))\Delta(M\times \Delta(W))Δ(M×Δ(W)).


LγL_\gammaLγ​ is affine and weakly continuous on Cγ\mathcal C_\gammaCγ​.


The compactified adviser problem computes the formal sourcewise lower envelope:


min⁡Λ∈CγLγ(Λ)=α∫MΦ(s,Γγ(s)) τ(ds)+(1−α)∫Minf⁡m∈MΦ(s,Γγ(m)) τ(ds).(*)\min_{\Lambda\in \mathcal C_\gamma} L_\gamma(\Lambda)
=
\alpha\int_M \Phi\bigl(s,\Gamma_\gamma(s)\bigr)\,\tau(ds)
+
(1-\alpha)\int_M \inf_{m\in M}\Phi\bigl(s,\Gamma_\gamma(m)\bigr)\,\tau(ds).
\tag{*}Λ∈Cγ​min​Lγ​(Λ)=α∫M​Φ(s,Γγ​(s))τ(ds)+(1−α)∫M​m∈Minf​Φ(s,Γγ​(m))τ(ds).(*)
So the adviser side can be compactified, with truthful mass α\alphaα and sss-marginal τ\tauτ built in, and the payoff is actually continuous affine on that compactified adviser class.

Proof
Step 1: compactness and convexity of Cγ\mathcal C_\gammaCγ​
Because MMM and KγK_\gammaKγ​ are compact metric, M×KγM\times K_\gammaM×Kγ​ is compact metric, hence Δ(M×Kγ)\Delta(M\times K_\gamma)Δ(M×Kγ​) is compact metric in the weak topology.
The set
Q(τ,Kγ)={Λ∈Δ(M×Kγ):ΛS=τ}\mathcal Q(\tau,K_\gamma)=\{\Lambda\in \Delta(M\times K_\gamma):\Lambda_S=\tau\}Q(τ,Kγ​)={Λ∈Δ(M×Kγ​):ΛS​=τ}
is convex. It is also closed, because the marginal map
Λ↦ΛS\Lambda \mapsto \Lambda_SΛ↦ΛS​
is continuous under weak convergence. Therefore Q(τ,Kγ)\mathcal Q(\tau,K_\gamma)Q(τ,Kγ​) is compact and convex.
Then
Cγ=α(id⁡,Γγ)#τ+(1−α)Q(τ,Kγ)\mathcal C_\gamma
=
\alpha(\operatorname{id},\Gamma_\gamma)_\#\tau
+
(1-\alpha)\mathcal Q(\tau,K_\gamma)Cγ​=α(id,Γγ​)#​τ+(1−α)Q(τ,Kγ​)
is an affine image of a compact convex set, hence itself compact and convex.
Step 2: continuity and affinity of the payoff
The map (s,w)↦s⋅w(s,w)\mapsto s\cdot w(s,w)↦s⋅w is continuous on M×WM\times WM×W, and WWW is compact, so Φ(s,μ)=∫s⋅w μ(dw)\Phi(s,\mu)=\int s\cdot w\,\mu(dw)Φ(s,μ)=∫s⋅wμ(dw) is continuous on M×Δ(W)M\times \Delta(W)M×Δ(W). It is also affine in μ\muμ.
Therefore
Lγ(Λ)=∫Φ dΛL_\gamma(\Lambda)=\int \Phi\,d\LambdaLγ​(Λ)=∫ΦdΛ
is affine in Λ\LambdaΛ, and weakly continuous on Δ(M×Kγ)\Delta(M\times K_\gamma)Δ(M×Kγ​), hence on Cγ\mathcal C_\gammaCγ​.
Step 3: reducing minimization over Cγ\mathcal C_\gammaCγ​ to pointwise minimization
Every Λ∈Cγ\Lambda\in \mathcal C_\gammaΛ∈Cγ​ can be written as
Λ=α(id⁡,Γγ)#τ+(1−α)Λ′\Lambda
=
\alpha(\operatorname{id},\Gamma_\gamma)_\#\tau+(1-\alpha)\Lambda'Λ=α(id,Γγ​)#​τ+(1−α)Λ′
with Λ′∈Q(τ,Kγ)\Lambda'\in \mathcal Q(\tau,K_\gamma)Λ′∈Q(τ,Kγ​). Hence
Lγ(Λ)=α∫MΦ(s,Γγ(s))τ(ds)+(1−α)∫M×KγΦ(s,μ) Λ′(ds,dμ).L_\gamma(\Lambda)
=
\alpha\int_M \Phi\bigl(s,\Gamma_\gamma(s)\bigr)\tau(ds)
+
(1-\alpha)\int_{M\times K_\gamma}\Phi(s,\mu)\,\Lambda'(ds,d\mu).Lγ​(Λ)=α∫M​Φ(s,Γγ​(s))τ(ds)+(1−α)∫M×Kγ​​Φ(s,μ)Λ′(ds,dμ).
So it remains to minimize the second term over Λ′∈Q(τ,Kγ)\Lambda'\in \mathcal Q(\tau,K_\gamma)Λ′∈Q(τ,Kγ​).
Disintegrate Λ′\Lambda'Λ′ as
Λ′(ds,dμ)=τ(ds) ζ(dμ∣s)\Lambda'(ds,d\mu)=\tau(ds)\,\zeta(d\mu\mid s)Λ′(ds,dμ)=τ(ds)ζ(dμ∣s)
for a measurable kernel ζ:M⇝Δ(Kγ)\zeta:M\rightsquigarrow \Delta(K_\gamma)ζ:M⇝Δ(Kγ​). Then
∫M×KγΦ(s,μ) Λ′(ds,dμ)=∫M[∫KγΦ(s,μ) ζ(dμ∣s)]τ(ds).\int_{M\times K_\gamma}\Phi(s,\mu)\,\Lambda'(ds,d\mu)
=
\int_M \left[\int_{K_\gamma}\Phi(s,\mu)\,\zeta(d\mu\mid s)\right]\tau(ds).∫M×Kγ​​Φ(s,μ)Λ′(ds,dμ)=∫M​[∫Kγ​​Φ(s,μ)ζ(dμ∣s)]τ(ds).
For each fixed sss, the bracket is at least
min⁡μ∈KγΦ(s,μ).\min_{\mu\in K_\gamma}\Phi(s,\mu).μ∈Kγ​min​Φ(s,μ).
Hence every Λ′\Lambda'Λ′ satisfies
∫Φ dΛ′≥∫Mmin⁡μ∈KγΦ(s,μ) τ(ds).(1)\int \Phi\,d\Lambda'
\ge
\int_M \min_{\mu\in K_\gamma}\Phi(s,\mu)\,\tau(ds).
\tag{1}∫ΦdΛ′≥∫M​μ∈Kγ​min​Φ(s,μ)τ(ds).(1)
Now define the argmin correspondence
A(s):=arg⁡min⁡μ∈KγΦ(s,μ).A(s):=\arg\min_{\mu\in K_\gamma}\Phi(s,\mu).A(s):=argμ∈Kγ​min​Φ(s,μ).
Because KγK_\gammaKγ​ is compact and Φ\PhiΦ is continuous, A(s)A(s)A(s) is nonempty compact for every sss. Its graph is closed:
(sn,μn)→(s,μ),μn∈A(sn)  ⟹  μ∈A(s).(s_n,\mu_n)\to (s,\mu),\quad \mu_n\in A(s_n)
\;\Longrightarrow\;
\mu\in A(s).(sn​,μn​)→(s,μ),μn​∈A(sn​)⟹μ∈A(s).
A closed-graph compact-valued correspondence from the Polish space MMM to the Polish space KγK_\gammaKγ​ admits a Borel measurable selector. So there exists measurable μ∗:M→Kγ\mu^*:M\to K_\gammaμ∗:M→Kγ​ with μ∗(s)∈A(s)\mu^*(s)\in A(s)μ∗(s)∈A(s) for all sss. Let
Λ∗(ds,dμ):=τ(ds) δμ∗(s)(dμ).\Lambda^*(ds,d\mu):=\tau(ds)\,\delta_{\mu^*(s)}(d\mu).Λ∗(ds,dμ):=τ(ds)δμ∗(s)​(dμ).
Then Λ∗∈Q(τ,Kγ)\Lambda^*\in \mathcal Q(\tau,K_\gamma)Λ∗∈Q(τ,Kγ​), and
∫Φ dΛ∗=∫Mmin⁡μ∈KγΦ(s,μ) τ(ds).(2)\int \Phi\,d\Lambda^*
=
\int_M \min_{\mu\in K_\gamma}\Phi(s,\mu)\,\tau(ds).
\tag{2}∫ΦdΛ∗=∫M​μ∈Kγ​min​Φ(s,μ)τ(ds).(2)
Combining (1) and (2),
min⁡Λ′∈Q(τ,Kγ)∫Φ dΛ′=∫Mmin⁡μ∈KγΦ(s,μ) τ(ds).(3)\min_{\Lambda'\in \mathcal Q(\tau,K_\gamma)}\int \Phi\,d\Lambda'
=
\int_M \min_{\mu\in K_\gamma}\Phi(s,\mu)\,\tau(ds).
\tag{3}Λ′∈Q(τ,Kγ​)min​∫ΦdΛ′=∫M​μ∈Kγ​min​Φ(s,μ)τ(ds).(3)
Step 4: evaluating the pointwise minimum over KγK_\gammaKγ​
Fix s∈Ms\in Ms∈M. Since Φ(s,⋅)\Phi(s,\cdot)Φ(s,⋅) is affine,
Φ ⁣(s,∑ipiμi)=∑ipiΦ(s,μi).\Phi\!\left(s,\sum_i p_i\mu_i\right)=\sum_i p_i\Phi(s,\mu_i).Φ(s,i∑​pi​μi​)=i∑​pi​Φ(s,μi​).
Therefore on the convex hull of Γγ(M)\Gamma_\gamma(M)Γγ​(M),
min⁡μ∈co⁡(Γγ(M))Φ(s,μ)=inf⁡m∈MΦ(s,Γγ(m)).\min_{\mu\in \operatorname{co}(\Gamma_\gamma(M))}\Phi(s,\mu)
=
\inf_{m\in M}\Phi\bigl(s,\Gamma_\gamma(m)\bigr).μ∈co(Γγ​(M))min​Φ(s,μ)=m∈Minf​Φ(s,Γγ​(m)).
Passing to the closure does not change the minimum because Φ(s,⋅)\Phi(s,\cdot)Φ(s,⋅) is continuous. Hence
min⁡μ∈KγΦ(s,μ)=inf⁡m∈MΦ(s,Γγ(m)).(4)\min_{\mu\in K_\gamma}\Phi(s,\mu)
=
\inf_{m\in M}\Phi\bigl(s,\Gamma_\gamma(m)\bigr).
\tag{4}μ∈Kγ​min​Φ(s,μ)=m∈Minf​Φ(s,Γγ​(m)).(4)
Substituting (4) into (3), and then back into the decomposition from Step 3, yields (∗)(*)(∗).
This proves the lemma.

What this does and does not buy
This is a real adviser-side compactification, but only for a fixed γ\gammaγ.


It gives a compact convex adviser-side class.


It gives continuous affine dependence on the adviser-side induced object.


It does not require any continuity of m↦γ(⋅∣m)m\mapsto \gamma(\cdot\mid m)m↦γ(⋅∣m).


Hence it does not sneak back in the already-false claim that β↦G(β,g)\beta\mapsto G(\beta,g)β↦G(β,g) is continuous for arbitrary deterministic measurable selectors g:M→Wg:M\to Wg:M→W.


The reason is simple: the topology is put on the induced law of (s,μ)(s,\mu)(s,μ), where μ=γm∈Δ(W)\mu=\gamma_m\in\Delta(W)μ=γm​∈Δ(W), after collapsing messages through γ\gammaγ. The false old route tried to topologize adviser kernels or (s,m)(s,m)(s,m)-laws directly while still testing them against arbitrary discontinuous m↦g(m)m\mapsto g(m)m↦g(m).

Precise obstruction to the stronger, γ\gammaγ-independent version
The stronger statement one might want is:

There exists a single adviser-side compact convex class C\mathcal CC, independent of γ\gammaγ, based on natural weak adviser-induced laws, such that for every relaxed γ\gammaγ the payoff is continuous affine on C\mathcal CC.

That stronger statement is false.
Counterexample
Use the same binary-state reduced environment as in the accepted atomic counterexample:
Ω={0,1},wG=(0,0),wB=(−1,0),\Omega=\{0,1\},\qquad
w^G=(0,0),\qquad
w^B=(-1,0),Ω={0,1},wG=(0,0),wB=(−1,0),
so s⋅wB<s⋅wGs\cdot w^B< s\cdot w^Gs⋅wB<s⋅wG whenever s(0)>0s(0)>0s(0)>0.
Let
m0=(0,1),mn=(1n+1,1−1n+1)→m0,m_0=(0,1),\qquad
m_n=\left(\frac1{n+1},1-\frac1{n+1}\right)\to m_0,m0​=(0,1),mn​=(n+11​,1−n+11​)→m0​,
and let τ\tauτ put positive mass on every mnm_nmn​ and on m0m_0m0​.
Define a deterministic selector
g(mn)=wB(n≥1),g(m0)=wG,g(m_n)=w^B \quad (n\ge 1),\qquad g(m_0)=w^G,g(mn​)=wB(n≥1),g(m0​)=wG,
and g=wGg=w^Gg=wG elsewhere if needed. Let γg\gamma^gγg be the corresponding Dirac relaxed kernel,
γg(⋅∣m)=δg(m).\gamma^g(\cdot\mid m)=\delta_{g(m)}.γg(⋅∣m)=δg(m)​.
For each nnn, let the misaligned adviser send mnm_nmn​ regardless of the source:
βn(dm∣s)=δmn(dm).\beta_n(dm\mid s)=\delta_{m_n}(dm).βn​(dm∣s)=δmn​​(dm).
Let β0(dm∣s)=δm0(dm)\beta_0(dm\mid s)=\delta_{m_0}(dm)β0​(dm∣s)=δm0​​(dm).
The induced source-message laws
qn(ds,dm)=τ(ds)[α δs(dm)+(1−α)δmn(dm)]q_n(ds,dm)
=
\tau(ds)\big[\alpha\,\delta_s(dm)+(1-\alpha)\delta_{m_n}(dm)\big]qn​(ds,dm)=τ(ds)[αδs​(dm)+(1−α)δmn​​(dm)]
converge weakly to
q0(ds,dm)=τ(ds)[α δs(dm)+(1−α)δm0(dm)]q_0(ds,dm)
=
\tau(ds)\big[\alpha\,\delta_s(dm)+(1-\alpha)\delta_{m_0}(dm)\big]q0​(ds,dm)=τ(ds)[αδs​(dm)+(1−α)δm0​​(dm)]
because mn→m0m_n\to m_0mn​→m0​.
But the reduced payoffs against the fixed deterministic ggg do not converge:
G(βn,g)=α∫s⋅g(s) τ(ds)+(1−α)∫s⋅wB τ(ds),G(\beta_n,g)
=
\alpha\int s\cdot g(s)\,\tau(ds)
+
(1-\alpha)\int s\cdot w^B\,\tau(ds),G(βn​,g)=α∫s⋅g(s)τ(ds)+(1−α)∫s⋅wBτ(ds),
whereas
G(β0,g)=α∫s⋅g(s) τ(ds)+(1−α)∫s⋅wG τ(ds).G(\beta_0,g)
=
\alpha\int s\cdot g(s)\,\tau(ds)
+
(1-\alpha)\int s\cdot w^G\,\tau(ds).G(β0​,g)=α∫s⋅g(s)τ(ds)+(1−α)∫s⋅wGτ(ds).
These differ by
(1−α)∫s(0) τ(ds)>0.(1-\alpha)\int s(0)\,\tau(ds) > 0.(1−α)∫s(0)τ(ds)>0.
So any γ\gammaγ-independent compactification that only tracks adviser-induced weak laws on (s,m)(s,m)(s,m), or any continuous image of those weak laws, cannot make the payoff continuous for all relaxed γ\gammaγ, because Dirac kernels γg\gamma^gγg are included among relaxed kernels.

Bottom line


Yes: the adviser side can be compactified in a clean way after fixing γ\gammaγ.
The class Cγ\mathcal C_\gammaCγ​ above is compact convex, truthful mass α\alphaα and sss-marginal τ\tauτ are built in, and the payoff is continuous affine on Cγ\mathcal C_\gammaCγ​.


No: this does not extend to a single γ\gammaγ-independent adviser-side weak-law class without reviving the already false continuity problem for arbitrary deterministic selectors.


So the local lemma is true only in the following usable sense:

adviser-side compactness/continuity is recoverable for the fixed-γ\gammaγ lower-envelope problem, not as a full product-space minimax replacement.

Needed lemma for the next step
To turn this into an existence route, one still needs one of the following, neither of which is proved here:


Needed lemma: a way to run minimax with the γ\gammaγ-dependent correspondence
γ↦Cγ\gamma \mapsto \mathcal C_\gammaγ↦Cγ​
rather than a fixed adviser strategy set; or


Needed lemma: an exact no-gap / measurable-lifting result showing that the compactified lower envelope computed by Cγ\mathcal C_\gammaCγ​ coincides with the infimum over raw measurable adviser kernels in the original reduced game.


Without one of those two ingredients, the fixed-γ\gammaγ compactification is not yet a theorem-producing saddle route.
Suggested next local action: prove or disprove an exact no-gap/measurable-lifting lemma from the fixed-γ\gammaγ compactified lower envelope back to raw adviser kernels.
