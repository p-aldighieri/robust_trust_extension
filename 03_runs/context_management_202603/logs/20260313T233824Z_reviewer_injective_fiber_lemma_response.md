## Verdict

**PASS.**

As a strengthened sufficient condition, the injective-fiber lemma is mathematically correct once it is read on the already-banked reduced-side inputs: a Borel label-posterior map (\hat p:W\to\Delta(\Omega)) for the collapsed law, with
[
w\in \arg\max_{u\in W}\hat p(w)\cdot u
\quad \rho^*\text{-a.e.},
]
and a Borel selector (F=\bar w^*). Under those inputs, (q^*)-a.e. injectivity gives a (q^*)-full Borel core (M_0\subset M) on which (F) has a Borel inverse; then the posterior version for ((\omega,F(m))) pulls back to a posterior version for ((\omega,m)), and the argmax condition transfers immediately. The proof idea in the probe is sound. 

## Exact caveat on presentation

The caveat is scope, not correctness. This should be presented only as a **strengthened sufficient condition** layered on top of the already-banked reduced-side posterior representation. It is **not** correct to present (q^*)-a.e. injectivity as if it alone upgraded the bare collapsed-kernel identity (F_{#}\beta^*=\kappa^*) into the Needed raw-message posterior statement. The breakdown note is right that message-side exactness is the live bottleneck on the main route, and the lemma succeeds only because the reduced-side Borel posterior map (\hat p) is already available. So the least-strengthened main route should remain anchored at the explicit Needed assumption.  

The clean statement is therefore:

> On the exact Route 1 reduced-side inputs, if (m\mapsto \bar w^*(m)) is (q^*)-a.e. injective, then the chosen raw lift satisfies the Needed assumption.

Even more exactly, the proof uses the existence of a (q^*)-full Borel set (M_0\subset M) such that (F|_{M_0}) has a Borel inverse on its image; (q^*)-a.e. injectivity is just a convenient sufficient primitive for that in this standard-Borel setting. 

## Local wording fixes

Replace
[
\tilde g(w):=g(r(w)),1_{Y_0}(w)
]
by
[
\tilde g(w):=g(r(w)),1_{Y_0}(w).
]

Also spell out once that the hypothesis (F_{#}\beta^*=\kappa^*) is being used to identify the pushforward of the raw joint law (\Gamma^*) under ((\omega,m)\mapsto(\omega,F(m))) with the reduced-side label law. Those are bookkeeping fixes, not substantive repairs. 

## Suggested next local action

Bank the injective-fiber lemma as a valid strengthened sufficient condition, but keep it explicitly subordinate to the main route’s current bottleneck and do not promote it into the preferred general theorem hypothesis. Then go back to the conditional exact-patching lemma under the explicit Needed assumption.
