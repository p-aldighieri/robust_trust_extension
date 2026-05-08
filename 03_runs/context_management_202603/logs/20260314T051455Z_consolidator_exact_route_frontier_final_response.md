## Unconditional Inputs

According to a document from 2026-03-14, the beyond-finite-(M) exact route remains anchored in the reduced game on the compact convex payoff set (W), with the finite-(M), compact-metric-(\Theta) extension already trusted, and with Appendix A.1 supplying the compact convex (W) and weak Pareto frontier facts. The durable route memo records that the only live obstruction is message-side exactness after reduction, barycentric collapse, and passage to a deterministic reduced selector (\bar w^*).   

At the current frontier, the already-banked reduced-side package is: a reduced saddle on (W), a deterministic selector (\bar w^*), and the selector package ((D,\pi)) used in patching. The durable proof state identifies the exact bottleneck as whether one can patch to pointwise Bayes optimality on all messages while preserving adversariality against every admissible adviser kernel.  

## Needed Assumption

The least-strengthened main route now hinges on one explicit Needed assumption and no weaker reviewer-cleared replacement is currently banked: the chosen raw lift (\beta^*) admits a Borel posterior version (p_0) such that
[
\bar w^*(m)\in \arg\max_{w\in W} p_0(m)\cdot w
\qquad q^*\text{-a.e. }m.
]
Equivalently, the Bayes gap
[
g(m):=h_W(p_0(m)) - p_0(m)\cdot \bar w^*(m)
]
vanishes (q^*)-a.e. This is the only new assumption used in the reviewer-cleared exact patching lemma. 

## Conditional Exact Theorem

Under the unconditional reduced-side inputs, the selector package ((D,\pi)), the pre-patching adviser-side inequality
[
\mathcal G(\beta^*,\bar w^*)\le \mathcal G(\beta,\bar w^*)
\qquad \forall \beta\in B,
]
and the Needed assumption above, the exact version-and-patching lemma is reviewer-cleared. One patches on the Borel null bad set
[
N:={m:g(m)>0},
]
defining
[
w^*(m)=D(\bar w^*(m)),\qquad p^*(m)=\pi(w^*(m)).
]
Because (p^*=p_0) (q^*)-a.e., (p^*) is still a posterior version under (\beta^*); the patched pair satisfies the full reduced-game saddle inequalities
[
\mathcal G(\beta^*,w)\le \mathcal G(\beta^*,w^*)\le \mathcal G(\beta,w^*)
\qquad \forall w,\ \forall \beta,
]
and (w^*) is Bayes-optimal at every message relative to the patched Borel posterior version (p^*). So the main beyond-finite-(M) exact route is conditionally closed at its hinge, but only conditionally on the explicit Needed assumption.  

## Strengthened Sufficient Condition

The injective-fiber lemma is now reviewer-cleared as a stronger sufficient condition, not as the preferred general hypothesis. On the already-banked reduced-side inputs, assume there is a reduced-side Borel posterior map
[
\hat p:W\to \Delta(\Omega)
]
with
[
w\in \arg\max_{u\in W}\hat p(w)\cdot u
\qquad \rho^*\text{-a.e.},
]
and let (F=\bar w^*). If (m\mapsto \bar w^*(m)) is (q^*)-a.e. injective, more exactly if there exists a (q^*)-full Borel core on which (F) has a Borel inverse on its image, then the reduced-side posterior version pulls back to a raw-message posterior version, and the Needed assumption follows. Thus injective-fiber should be recorded only as a strengthened corollary:
[
q^*\text{-a.e. injectivity of } \bar w^* ;\Longrightarrow; \text{Needed assumption}.
]
It does not by itself replace the main bottleneck, and it should not be promoted into the baseline exact theorem hypothesis. 

**Current Frontier.** What remains open is exactly the derivation of the Needed assumption from the standing beyond-finite-(M) reduced-side inputs alone: namely, producing a raw-message Borel posterior version for the chosen raw lift (\beta^*) that certifies (q^*)-a.e. Bayes optimality of (\bar w^*) without adding an injective-fiber-type strengthening.  

Suggested next local action: formulate and prove the raw-message posterior-lifting lemma that derives the Needed assumption directly from the banked reduced-side inputs, without using injective-fiber.
