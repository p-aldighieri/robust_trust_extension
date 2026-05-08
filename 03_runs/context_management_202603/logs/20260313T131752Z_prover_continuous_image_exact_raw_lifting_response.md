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
