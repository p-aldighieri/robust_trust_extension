## Verdict

PASS, with local wording fixes.

Under the already-assumed selector package and the pre-patching adviser-side inequality
[
\mathcal G(\beta^*,\bar w^*)\le \mathcal G(\beta,\bar w^*)\qquad\forall \beta\in B,
]
the conditional exact version-and-patching lemma is mathematically correct. The proof uses no stronger new hypothesis than the labeled Needed assumption: the chosen raw lift (\beta^*) admits a Borel posterior version (p_0) such that
[
\bar w^*(m)\in \arg\max_{w\in W} p_0(m)\cdot w
\qquad q^*\text{-a.e. }m,
]
equivalently the Bayes gap
[
g(m):=h_W(p_0(m))-p_0(m)\cdot \bar w^*(m)
]
vanishes (q^*)-a.e. 

The proof closes for the right reason. The bad set
[
N:={m:g(m)>0}
]
is Borel and (q^*(N)=0). Patching on (N) via
[
w^*(m)=D(\bar w^*(m)),\qquad p^*(m)=\pi(w^*(m))
]
produces Borel maps. On (M\setminus N), one has (w^*=\bar w^*) and (p^*=p_0), while on (N), the defining property of (\pi) gives exact pointwise Bayes optimality of (w^*) relative to (p^*). Since (p^*=p_0) (q^*)-a.e., (p^*) is still a posterior version under (\beta^*), so
[
\mathcal G(\beta^*,w)=\int_M p^*(m)\cdot w(m),q^*(dm)
]
for every Borel selector (w). That representation yields the agent-side inequality
[
\mathcal G(\beta^*,w)\le \mathcal G(\beta^*,w^*)
\qquad\forall w.
]
On the adviser side, the coordinatewise domination (w^*\ge \bar w^*) implies
[
\mathcal G(\beta,w^*)\ge \mathcal G(\beta,\bar w^*)
\qquad\forall \beta\in B,
]
because every state vector (s\in M\subseteq \Delta(\Omega)) has nonnegative coordinates. Combining this with equality at (\beta^*),
[
\mathcal G(\beta^*,w^*)=\mathcal G(\beta^*,\bar w^*),
]
and with the input inequality for (\bar w^*), gives
[
\mathcal G(\beta^*,w)\le \mathcal G(\beta^*,w^*)\le \mathcal G(\beta,w^*)
\qquad\forall w,\ \forall\beta.
]
So the patched pair is a full reduced-game saddle, and (w^*) is Bayes-optimal at every message relative to the patched Borel posterior version (p^*). 

## Local wording fixes

1. State explicitly at the top that the lemma is conditional on the already-proved selector package ((D,\pi)) and on the adviser-side half of the pre-patching saddle. The posterior-labeled-lift assumption is the only **new** assumption.

2. In the sentence “(p^*) is still a posterior version under (\beta^*),” add the reason: posterior versions are only identified (q^*)-a.e., and (p^*=p_0) (q^*)-a.e.

3. Phrase the conclusion as “Bayes-optimal at every message **relative to a Borel posterior version (p^*)**” to avoid suggesting any stronger off-path uniqueness claim.

## Proof-state consequence

Bank the exact version-and-patching saddle lemma **conditionally** under the explicit posterior-labeled raw-lift assumption. This is exactly the live bottleneck identified in the durable proof state and the exact-route memo, so the least-strengthened exact route is now conditionally closed at its hinge. 

## Suggested next local action

Write the compact summary of the least-strengthened exact route, separating cleanly:

* the unconditional inputs already proved,
* the single extra posterior-labeled-lift assumption,
* the resulting conditional exact theorem.
