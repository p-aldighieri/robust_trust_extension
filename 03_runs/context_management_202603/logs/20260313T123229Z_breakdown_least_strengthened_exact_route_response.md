I’m pinning down the exact ask against the known local obstructions and durable proof-state so I can rank only genuinely minimal repair assumptions, rather than slipping back into a broader route.The live split is now clear: fixed-γ value exactness survives, but strategy exactness breaks because closure points of m ↦ \bar w_γ(m) need not be raw-realized.

Needed assumption (best): saddle-specific continuity of the collapsed selector
Assume that, after the reduced-game saddle existence and barycentric collapse steps, there is a deterministic reduced saddle (β∗,wˉ∗)(\beta^*,\bar w^*)(β∗,wˉ∗) such that
wˉ∗:M→W\bar w^*:M\to Wwˉ∗:M→W
is continuous.
This is the best route because it hits the exact trusted obstruction: the current failure is that compactified adviser minimizers can live at closure points of the raw image wˉγ(M) \bar w_\gamma(M)wˉγ​(M) that no raw message realizes, and the project already records continuity of m↦wˉγ(m)m\mapsto \bar w_\gamma(m)m↦wˉγ​(m) as a sufficient upgrade restoring exact raw lifting for fixed γ\gammaγ. It is also local to the actual collapsed saddle, so it is weaker than imposing continuity on every admissible γ\gammaγ, while still respecting that the old full-kernel compact-topology route is dead and the raw atomic truncation-limit passage is dead.    
Exact strengthened theorem target.
Assume the standing hypotheses, reduced-game Lemmas 1 to 4, and the added continuity assumption above. Then, at the candidate deterministic reduced saddle (β∗,wˉ∗)(\beta^*,\bar w^*)(β∗,wˉ∗), exact raw lifting and exact raw attainment are restored on the adviser side: the adviser-side compactified minimizer can be lifted to a raw measurable adviser kernel attaining the same value. This removes the presently trusted strategy-level obstruction and reduces the remaining exact-theorem work to the already isolated null-set Bayes-patching step.  
First local lemma.
Lemma (continuous-image exact raw lifting). Let M⊂Δ(Ω)M\subset \Delta(\Omega)M⊂Δ(Ω) and W⊂RNW\subset \mathbb R^NW⊂RN be the usual compact sets, and let wˉ:M→W\bar w:M\to Wwˉ:M→W be continuous. Then every compactified adviser kernel
κ:M⇝Δ(wˉ(M))\kappa: M \rightsquigarrow \Delta(\bar w(M))κ:M⇝Δ(wˉ(M))
admits a raw measurable lift
β:M⇝Δ(M)\beta: M \rightsquigarrow \Delta(M)β:M⇝Δ(M)
such that wˉ#β=κ\bar w_{\#}\beta=\kappawˉ#​β=κ. In particular, every compactified adviser minimizer against wˉ\bar wwˉ is attained by a raw adviser kernel.


Needed assumption: closed raw image plus measurable right inverse
Assume for the candidate collapsed selector wˉ∗\bar w^*wˉ∗ that wˉ∗(M)\bar w^*(M)wˉ∗(M) is closed in WWW and there exists a Borel map
r:wˉ∗(M)→Mwithwˉ∗(r(w))=w.r:\bar w^*(M)\to M
\quad\text{with}\quad
\bar w^*(r(w))=w.r:wˉ∗(M)→Mwithwˉ∗(r(w))=w.
This is formally closer to the literal obstruction mechanism than continuity, because it asks only that closure points used by compactified minimizers are actually realizable and liftable. I rank it below continuity because it is more ad hoc as a theorem assumption: it hides the hard regularity inside a right-inverse hypothesis instead of giving a structural primitive one can plausibly verify from model data. 


Needed assumption: uniform regularity of the relevant selector family
Require the collapsed selectors arising along the exact route to lie in a common regular class, such as an equicontinuous or Lipschitz family, or impose an equivalent domination/tightness restriction that blocks moving-tail exploitation. This is worst because it is substantially stronger, starts drifting back toward a global topology package, and is motivated mainly by the atomic moving-tail pathology rather than by the precise fixed-γ\gammaγ nonattainment mechanism. It may rescue a theorem, but not the least-strengthened exact route.  


Suggested next local action: prove the continuous-image exact raw lifting lemma for a fixed deterministic reduced saddle (β∗,wˉ∗)(\beta^*,\bar w^*)(β∗,wˉ∗), and only after that reopen the null-set patching lemma.
