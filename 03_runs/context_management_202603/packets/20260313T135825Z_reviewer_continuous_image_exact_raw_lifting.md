# Prompt Packet: reviewer

Branch: `exact_route1_least_strengthened`

## Scope Of This Move

Continuous-image exact raw lifting lemma under saddle-specific continuity

## Goal

Review only the local lemma claiming that if the collapsed selector bar w : M -> W is continuous, then every compactified adviser kernel on bar w(M) admits a raw measurable lift beta : M -> Delta(M) with bar w_# beta = kappa. Check correctness, hidden assumptions, and whether the consequence for adviser minimizers is justified.

## Hard Constraints

- No assumption smuggling.
- Any extra condition must be labeled Needed assumption.
- If the route fails, prefer a concrete obstruction or counterexample.
- Never truncate attached proof artifacts. If the move is too large, narrow the scope instead.

## Durable Project Sources Already In ChatGPT

- `Context Management/source_notes/proof_state.md`
- `Context Management/source_notes/exact_route1_strategy.md`

## Project Sources To Refresh Before This Chat

- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/source_notes/proof_state.md`
- `/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/source_notes/exact_route1_strategy.md`

## Temporary Files To Attach In This Chat

- `Context Management/logs/20260313T123229Z_breakdown_least_strengthened_exact_route_response.md`
- `Context Management/logs/20260313T131752Z_prover_continuous_image_exact_raw_lifting_response.md`

## Deliberately Excluded Context


## Required Output

Return a reviewer verdict focused only on this lemma: PASS if correct as written or with only local cosmetic fixes; otherwise identify the first precise mathematical defect. Include the smallest repair if one exists.

## Proof-State Update Target

If PASS, bank the continuity-based exact lifting lemma as trustworthy and return to the exact version-and-patching saddle lemma under the added continuity assumption.

## Expected Next-Step Signal

Suggested next local action:

## Embedded Local Context

### FILE: /Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/logs/20260313T123229Z_breakdown_least_strengthened_exact_route_response.md

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


### FILE: /Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension/Context Management/logs/20260313T131752Z_prover_continuous_image_exact_raw_lifting_response.md

The strengthened local route works. The known obstruction under the standing assumptions is purely strategy-level: a compactified minimizer can place mass on closure points of the raw image that are not realized by any raw message. The attached packet asks whether saddle-specific continuity of the collapsed selector repairs exactly that defect. It does.   

## Lemma (continuous-image exact raw lifting)

Let (M\subset \Delta(\Omega)) be the adviser-message set, let (W\subset \mathbb R^N) be the compact payoff set from the reduced game, and let
[
\bar w:M\to W
]
be continuous. Write
[
Y:=\bar w(M)\subset W.
]
Then every Borel adviser kernel
[
\kappa: M \rightsquigarrow \Delta(Y)
]
admits a Borel raw lift
[
\beta: M \rightsquigarrow \Delta(M)
]
such that
[
\bar w_{#}\beta=\kappa.
]

Equivalently, for each (m\in M),
[
\bar w_{#}\beta_m=\kappa_m .
]

Here (M) is compact metric because it is a support inside the finite simplex, and (W) is compact by the payoff-vector construction in Appendix A.1.  

## Proof

Set (Y=\bar w(M)). Since (M) is compact metric and (\bar w) is continuous, (Y) is compact metric.

Define the inverse-fiber relation
[
A:={(y,m')\in Y\times M:\bar w(m')=y}.
]
Because (\bar w) is continuous, (A) is closed in the compact metric space (Y\times M), hence (A) is Borel. For every (y\in Y), the section
[
A_y:={m'\in M:(y,m')\in A}=\bar w^{-1}({y})
]
is nonempty and compact.

Now use the following measurable-selection fact.

> If (X) and (Z) are standard Borel spaces and (B\subset X\times Z) is Borel with every section (B_x) nonempty and (\sigma)-compact, then there exists a Borel map (s:X\to Z) such that ((x,s(x))\in B) for every (x\in X).

Its conditions are met here with (X=Y), (Z=M), and (B=A): both (Y) and (M) are compact metric, hence standard Borel; (A) is Borel; and each section (A_y) is nonempty compact, hence (\sigma)-compact. Therefore there exists a Borel map
[
r:Y\to M
]
such that
[
\bar w(r(y))=y\qquad \forall y\in Y.
]
So (r) is a Borel right inverse of (\bar w) on (Y).

For each (m\in M), define
[
\beta_m:=r_{#}\kappa_m\in \Delta(M).
]
Equivalently, for each Borel set (B\subset M),
[
\beta(m,B):=\kappa(m,r^{-1}(B)).
]

We check that (\beta) is a Borel kernel from (M) to (M).

For fixed (m), (B\mapsto \beta(m,B)) is a probability measure because it is the pushforward of the probability measure (\kappa_m) by the Borel map (r). For fixed Borel (B\subset M), the set (r^{-1}(B)\subset Y) is Borel, and since (\kappa) is a Borel kernel, the map
[
m\mapsto \beta(m,B)=\kappa(m,r^{-1}(B))
]
is Borel. Hence (\beta) is indeed a Borel kernel.

Finally, for any Borel set (C\subset Y),
[
(\bar w_{#}\beta_m)(C)
======================

# \beta_m(\bar w^{-1}(C))

# \kappa_m!\big(r^{-1}(\bar w^{-1}(C))\big)

# \kappa_m!\big((\bar w\circ r)^{-1}(C)\big)

\kappa_m(C),
]
because (\bar w\circ r=\mathrm{id}*Y). Therefore
[
\bar w*{#}\beta_m=\kappa_m
\qquad\text{for every }m\in M,
]
which is exactly
[
\bar w_{#}\beta=\kappa.
]
This proves the lemma. ∎

## Consequence for adviser minimizers

Let (\kappa^*) be any compactified adviser minimizer against the deterministic selector (\bar w). Apply the lemma to obtain (\beta^*) with
[
\bar w_{#}\beta^*=\kappa^*.
]

Moreover, for every bounded Borel function (g:M\times Y\to\mathbb R),
[
\int_Y g(m,y),\kappa^*(dy\mid m)
================================

\int_M g!\big(m,\bar w(m')\big),\beta^*(dm'\mid m)
\qquad \forall m\in M.
]
So every adviser objective written on the compactified side as a functional of the image variable (y\in Y) is preserved by the lift. In particular, the compactified adviser value against (\bar w) is attained by the raw kernel (\beta^*). Hence saddle-specific continuity of (\bar w) removes the previously trusted nonattainment obstruction on the adviser side. 

## What this shows, and what it does not

This settles the single local lemma positively. Under the added assumption that the collapsed saddle selector (\bar w^*) is continuous, exact raw lifting is restored. The real hinge is the existence of a Borel right inverse on (\bar w^*(M)); continuity on compact (M) supplies one automatically. No further topology on the full adviser-kernel space is needed for this step.

Suggested next local action: treat adviser-side exact lifting as closed under saddle-specific continuity, and return to the exact version-and-patching saddle lemma, namely patch (\bar w^*) on the (q^*)-null bad set while preserving the adviser-side saddle inequalities against every admissible raw kernel.
