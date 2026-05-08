I’m aligning the lemma target with the three support notes, then I’ll either complete the limit argument or pinpoint the exact tail obstruction.I’ve now reduced the atomic branch to a selector g:M→Wg:M\to Wg:M→W against an adviser kernel β(⋅∣s)\beta(\cdot\mid s)β(⋅∣s), with any tail effect entering only through the rowwise minima inf⁡ms ⁣⋅ ⁣g(m)\inf_m s\!\cdot\! g(m)infm​s⋅g(m). The key remaining check is whether truncation preserves the adviser’s leverage from tiny-probability tail messages, since finite-support existence alone does not decide it.1. Exact setup and chosen finite approximation scheme
Work on the countable atomic branch requested in the packet: M=supp⁡(τ)={m0,m1,m2,… }M=\operatorname{supp}(\tau)=\{m_0,m_1,m_2,\dots\}M=supp(τ)={m0​,m1​,m2​,…}, with τ({mk})>0\tau(\{m_k\})>0τ({mk​})>0 for every kkk. I take the concrete exhaustion
Mn:={m0,m1,…,mn},τ(n):=τ( ⋅∣Mn).M_n:=\{m_0,m_1,\dots,m_n\},\qquad \tau^{(n)}:=\tau(\,\cdot\mid M_n).Mn​:={m0​,m1​,…,mn​},τ(n):=τ(⋅∣Mn​).
For each nnn, the trusted finite-MMM, compact-Θ\ThetaΘ theorem gives a robustly rationalizable finite-stage saddle pair; I use that only as a black box. 
On the reduced side, with payoff-vector set W⊂RΩW\subset \mathbb R^{\Omega}W⊂RΩ from Appendix A.1, a selector is g:M→Wg:M\to Wg:M→W, and an adviser kernel is β∈∏s∈MΔ(M)\beta\in \prod_{s\in M}\Delta(M)β∈∏s∈M​Δ(M). The reduced payoff is
G(β,g)=∑s∈Mτ(s)[α s ⁣⋅ ⁣g(s)+(1−α)∫Ms ⁣⋅ ⁣g(m) β(dm∣s)].G(\beta,g)
=\sum_{s\in M}\tau(s)\Bigl[\alpha\, s\!\cdot\! g(s)
+(1-\alpha)\int_M s\!\cdot\! g(m)\,\beta(dm\mid s)\Bigr].G(β,g)=s∈M∑​τ(s)[αs⋅g(s)+(1−α)∫M​s⋅g(m)β(dm∣s)].
For fixed ggg, adviser minimization is sourcewise:
Ls(g):=inf⁡m∈Ms ⁣⋅ ⁣g(m).L_s(g):=\inf_{m\in M} s\!\cdot\! g(m).Ls​(g):=m∈Minf​s⋅g(m).
In the nnn-th truncation this becomes
Ls(n)(gn):=inf⁡m∈Mns ⁣⋅ ⁣gn(m).L^{(n)}_s(g_n):=\inf_{m\in M_n} s\!\cdot\! g_n(m).Ls(n)​(gn​):=m∈Mn​inf​s⋅gn​(m).
So the atomic truncation-limit lemma would have to pass finite-stage saddle inequalities through the limit
Ls(n)(gn)→Ls(g)for every fixed source belief s,L^{(n)}_s(g_n)\to L_s(g)
\quad\text{for every fixed source belief }s,Ls(n)​(gn​)→Ls​(g)for every fixed source belief s,
or at least the lower-semicontinuity needed to preserve adviser optimality. This is exactly the live bottleneck already flagged in the atomic branch notes: fixed-β\betaβ continuity in ggg is fine, but adviser-side continuity/semicontinuity on full WMW^MWM fails.  
2. Proof attempt for the atomic truncation-limit decision lemma
A natural attempt is:


Use compactness of WMW^MWM (countable product topology) and of the adviser-kernel space on the atomic branch to extract a cluster point (β∗,g∗)(\beta^*,g^*)(β∗,g∗) from finite-stage saddle pairs.


For every fixed message mkm_kmk​, since mk∈Mnm_k\in M_nmk​∈Mn​ for all large nnn, pass the messagewise Bayes-optimality condition at mkm_kmk​ to the limit.


Pass the adviser inequality to the limit:
Gn(βn∗,gn)≤Gn(β,gn)∀β on MnG_n(\beta_n^*,g_n)\le G_n(\beta,g_n)\quad\forall \beta\text{ on }M_nGn​(βn∗​,gn​)≤Gn​(β,gn​)∀β on Mn​
should imply
G(β∗,g∗)≤G(β,g∗)∀β on M.G(\beta^*,g^*)\le G(\beta,g^*)\quad\forall \beta\text{ on }M.G(β∗,g∗)≤G(β,g∗)∀β on M.


Step 2 is plausible on the atomic branch because every fixed message is on path forever. Step 3 is the crux. To get it, one needs at least:
lim inf⁡n→∞Ls(n)(gn)≥Ls(g∗)(∀s∈M).(*)\liminf_{n\to\infty}L^{(n)}_s(g_n)\ge L_s(g^*)
\qquad(\forall s\in M).
\tag{*}n→∞liminf​Ls(n)​(gn​)≥Ls​(g∗)(∀s∈M).(*)
The reverse inequality is easy: freeze one near-minimizer mmm for g∗g^*g∗, and use coordinatewise convergence gn(m)→g∗(m)g_n(m)\to g^*(m)gn​(m)→g∗(m). The hard direction is (∗)(*)(∗). It is exactly a closed-graph / lower-semicontinuity statement for the adviser best-response operator.
That statement is false.
3. Explicit counterexample with the exact tail mechanism
I now give an explicit reduced-game obstruction inside the paper’s standing model.
Take a nontrivial binary-state, no-type decision problem:
Ω={0,1},Θ={θ0},A={aG,aB},\Omega=\{0,1\},\qquad \Theta=\{\theta_0\},\qquad A=\{a^{G},a^{B}\},Ω={0,1},Θ={θ0​},A={aG,aB},
with payoffs
u(aG,0)=u(aG,1)=0,u(aB,0)=−1,u(aB,1)=0.u(a^{G},0)=u(a^{G},1)=0,\qquad
u(a^{B},0)=-1,\quad u(a^{B},1)=0.u(aG,0)=u(aG,1)=0,u(aB,0)=−1,u(aB,1)=0.
Then
wG=(0,0),wB=(−1,0)∈W.w^{G}=(0,0),\qquad w^{B}=(-1,0)\in W.wG=(0,0),wB=(−1,0)∈W.
So for any belief sss with s(0)>0s(0)>0s(0)>0,
s⋅wB=−s(0)<0=s⋅wG.s\cdot w^{B}=-s(0)<0=s\cdot w^{G}.s⋅wB=−s(0)<0=s⋅wG.
Now choose a countable atomic support
m0=(0,1),mk=(1k+1, 1−1k+1)  (k≥1),m_0=(0,1),\qquad
m_k=\Bigl(\frac1{k+1},\,1-\frac1{k+1}\Bigr)\ \ (k\ge1),m0​=(0,1),mk​=(k+11​,1−k+11​)  (k≥1),
with masses
τ(m0)=12,τ(mk)=2−k−1  (k≥1).\tau(m_0)=\frac12,\qquad \tau(m_k)=2^{-k-1}\ \ (k\ge1).τ(m0​)=21​,τ(mk​)=2−k−1  (k≥1).
Then every message has strictly positive τ\tauτ-mass, and mk→m0m_k\to m_0mk​→m0​.
Define the truncation Mn={m0,…,mn}M_n=\{m_0,\dots,m_n\}Mn​={m0​,…,mn​}. For each nnn, define a selector gn:M→Wg_n:M\to Wgn​:M→W by
gn(mn)=wB,gn(m)=wG for m≠mn.g_n(m_n)=w^{B},\qquad g_n(m)=w^{G}\ \text{for }m\neq m_n.gn​(mn​)=wB,gn​(m)=wG for m=mn​.
Then for every fixed mkm_kmk​, once n>kn>kn>k we have gn(mk)=wGg_n(m_k)=w^{G}gn​(mk​)=wG, so
gn→g∗≡wGcoordinatewise in WM.g_n \to g^*\equiv w^{G}
\quad\text{coordinatewise in }W^M.gn​→g∗≡wGcoordinatewise in WM.
Fix the source belief s:=m1=(1/2,1/2)s:=m_1=(1/2,1/2)s:=m1​=(1/2,1/2). Then for every n≥1n\ge1n≥1,
Ls(n)(gn)=inf⁡m∈Mns⋅gn(m)=s⋅wB=−12.L^{(n)}_{s}(g_n)
=\inf_{m\in M_n}s\cdot g_n(m)
=s\cdot w^{B}
=-\frac12.Ls(n)​(gn​)=m∈Mn​inf​s⋅gn​(m)=s⋅wB=−21​.
But for the cluster point g∗≡wGg^*\equiv w^{G}g∗≡wG,
Ls(g∗)=inf⁡m∈Ms⋅g∗(m)=0.L_s(g^*)
=\inf_{m\in M}s\cdot g^*(m)
=0.Ls​(g∗)=m∈Minf​s⋅g∗(m)=0.
So the adviser lower envelope jumps:
lim⁡n→∞Ls(n)(gn)=−12≠Ls(g∗)=0.\lim_{n\to\infty}L^{(n)}_s(g_n)=-\frac12
\quad\neq\quad
L_s(g^*)=0.n→∞lim​Ls(n)​(gn​)=−21​=Ls​(g∗)=0.
This is the exact tail mechanism. The “bad” action sits on a moving tail message mnm_nmn​. Its aligned mass τ(mn)=2−n−1\tau(m_n)=2^{-n-1}τ(mn​)=2−n−1 goes to zero, but that does not weaken the adviser’s power, because the adviser chooses the target message directly. The minimizer simply chases the newest toxic tail message. Compactness in the product topology sees every fixed coordinate settle down, but it is blind to the moving minimizer. Hence the adviser-side best-response graph is not closed under this truncation topology.
That is precisely the obstruction the atomic note warned about in prose: fixed-β\betaβ continuity survives, but adviser-side semicontinuity fails on full WMW^MWM. 
Why this kills the lemma in the raw black-box form
The finite-MMM theorem gives stagewise saddle pairs only on each MnM_nMn​. To conclude that every cluster point is a full saddle pair, one must have some mechanism forcing (∗)(*)(∗), i.e. ruling out moving-tail minimizers. The explicit construction above shows that product-topology compactness plus finite-stage saddle inequalities do not provide that mechanism.
So the black-box truncation route fails exactly here:


fixed-message Bayes optimality can pass;


adviser optimality cannot be passed without an extra selector-regularity lemma.


A condition that would make the proof go through is something like:

Needed assumption / needed lemma. Along the selected finite-stage saddles, the selectors gng_ngn​ satisfy a diagonal continuity property:
whenever mkn→mm_{k_n}\to mmkn​​→m, every cluster point of gn(mkn)g_n(m_{k_n})gn​(mkn​​) lies in the Bayes-optimal set used at mmm.

Equivalent formulations would be an equicontinuity/upper-semicontinuity condition on the selected gng_ngn​, or a domination/tightness restriction on admissible adviser-induced laws strong enough to stop the adviser from chasing moving spikes. Without such an added ingredient, the truncation-limit lemma is not valid as a black-box consequence of the trusted finite-MMM theorem alone. This matches the “exact obstruction” anticipated in the durable notes.  
4. Short conclusion
COUNTEREXAMPLE to the raw truncation-limit passage: the adviser-side lower-semicontinuity needed to pass finite-stage saddle inequalities to the full atomic reduced game fails by an explicit moving-tail-minimizer construction. Therefore the atomic branch does not advance by the proposed black-box truncation argument without an additional selector-regularity lemma.
Suggested next local action: revised breakdown
