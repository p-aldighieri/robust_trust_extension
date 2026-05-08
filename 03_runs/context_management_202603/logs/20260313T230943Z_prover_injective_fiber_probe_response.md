## Injective-fiber probe: succeeds, with one exact caveat

Let (F:=\bar w^*:M\to W). On the current exact route, the only remaining gap is message-side exactness: the chosen raw lift (\beta^*) is known to preserve the collapsed label kernel,
[
F_{#}\beta^*=\kappa^*,
]
but that alone does not produce a posterior version on raw messages. The probe asks whether (q^*)-a.e. injectivity of (F) upgrades the already-banked label-side posterior exactness to the Needed raw-message version. That is exactly the right narrow question.  

The answer is:

> **Yes, provided we use the reduced-side posterior representation already banked in this route.**
>
> Injectivity does **not** create label-side posterior exactness from nothing. What it does is transfer that exactness from the collapsed label (w=F(m)) back to the raw message (m). Since the route memo identifies message-side exactness as the only live obstruction, this is the relevant sufficiency statement here.  

---

## Lemma (injective-fiber lift)

Assume the reduced-side input already in hand from Step 3 of the exact-route plan: there exists a Borel map
[
\hat p:W\to \Delta(\Omega)
]
such that for the collapsed label law (\rho^*) induced by the reduced saddle,

1. (\hat p) is a posterior version of the state given the collapsed label (w), and
2. (w\in \arg\max_{u\in W}\hat p(w)\cdot u) for (\rho^*)-a.e. (w).

Assume also that (F=\bar w^*) is (q^*)-a.e. injective.

Then the map
[
p_0(m):=\hat p(F(m))
]
is a Borel posterior version under the chosen raw lift (\beta^*), and
[
\bar w^*(m)\in \arg\max_{u\in W} p_0(m)\cdot u
\qquad q^*\text{-a.e.}
]
Hence the Needed assumption holds.

---

## Proof

Let (\Gamma^*) be the joint law on (\Omega\times M) induced by the chosen raw lift (\beta^*), and let (q^*) be its (M)-marginal. Push (\Gamma^*) forward through ((\omega,m)\mapsto (\omega,F(m))). Call the resulting law (\Lambda^*) on (\Omega\times W), and let (\rho^*) be its (W)-marginal.

Because (F_{#}\beta^*=\kappa^*), the law (\Lambda^*) is exactly the label-side law attached to the reduced saddle. So the already-banked reduced-side posterior map (\hat p) is a posterior version for (\Lambda^*).

Now use the injectivity hypothesis.

Since (M) is a Borel subset of the simplex (\Delta(\Omega)), it is standard Borel. Since (W\subset \mathbb R^{|\Omega|}) is compact, it is also standard Borel. Because (F) is (q^*)-a.e. injective, there exists a measurable set (A\subset M) with (q^*(A)=1) such that (F|*A) is injective. As (q^*) is a Borel probability on a compact metric space, (A) contains a Borel subset (M_0\subset A) with (q^*(M_0)=1). Then (F|*{M_0}) is still injective.

Set
[
Y_0:=F(M_0)\subset W.
]
By the Lusin-Souslin theorem for Borel injective maps between standard Borel spaces, (Y_0) is Borel and the inverse
[
r:Y_0\to M_0,\qquad r(F(m))=m\ \text{for }m\in M_0,
]
is Borel.

Define
[
p_0(m):=\hat p(F(m)).
]
This is Borel because both (\hat p) and (F) are Borel.

It remains to prove that (p_0) is a posterior version for (\Gamma^*). Fix a bounded Borel (g:M\to \mathbb R) and a state (i\in \Omega). Define
[
\tilde g(w):=g(r(w)),1_{Y_0}(w).
]
Then (\tilde g) is Borel on (W), and since (q^*(M_0)=1), we have
[
g(m)=\tilde g(F(m))
\qquad \Gamma^*\text{-a.s.}
]
Therefore,
[
\int g(m),1_{{\omega=i}},d\Gamma^*
==================================

\int \tilde g(w),1_{{\omega=i}},d\Lambda^*.
]
Because (\hat p) is a posterior version for (\Lambda^*),
[
\int \tilde g(w),1_{{\omega=i}},d\Lambda^*
==========================================

\int \tilde g(w),\hat p_i(w),d\rho^*(w).
]
Pulling this back through (w=F(m)),
[
\int \tilde g(w),\hat p_i(w),d\rho^*(w)
=======================================

# \int g(m),\hat p_i(F(m)),dq^*(m)

\int g(m),p_{0,i}(m),dq^*(m).
]
So for every bounded Borel (g) and every state (i),
[
\int g(m),1_{{\omega=i}},d\Gamma^*
==================================

\int g(m),p_{0,i}(m),dq^*(m).
]
This is exactly the statement that (p_0) is a posterior version of the state given the raw message under (\beta^*).

Finally, let
[
N:=\Bigl{w\in W:\ w\notin \arg\max_{u\in W}\hat p(w)\cdot u\Bigr}.
]
By the reduced-side input, (\rho^*(N)=0). Since (\rho^*=F_{#}q^*),
[
q^*(F^{-1}(N))=\rho^*(N)=0.
]
Hence for (q^*)-a.e. (m),
[
F(m)\in \arg\max_{u\in W}\hat p(F(m))\cdot u
============================================

\arg\max_{u\in W} p_0(m)\cdot u.
]
That is,
[
\bar w^*(m)\in \arg\max_{u\in W} p_0(m)\cdot u
\qquad q^*\text{-a.e.}
]
So the Needed assumption holds. ∎

---

## What is the actual minimal fiber-rigidity primitive?

The proof uses only this:

> there exists a (q^*)-full Borel set (M_0\subset M) such that (F|_{M_0}) has a Borel inverse on its image.

That is the exact “raw message carries no more information than the collapsed label” condition. In the present setting, bare (q^*)-a.e. injectivity is enough because (M) and (W) are standard Borel and (F) is Borel, so one gets the Borel full-measure core and Borel inverse for free.

So the probe does **not** fail on a hidden measurability pebble. The only real dependency is the already-banked label-side posterior map (\hat p). If one removed that reduced-side input, injectivity alone would not suffice. But on this route that label-side input is precisely what is already supposed to be in hand; the live obstruction was only the lift from labels back to raw messages.  

---

## Scoped conclusion

Bank the following strengthened sufficient condition:

> **Injective-fiber lemma.**
> On the exact Route 1 reduced-side inputs, if (m\mapsto \bar w^*(m)) is (q^*)-a.e. injective, then the chosen raw lift (\beta^*) satisfies the Needed assumption.

This is a valid short-cycle success. It is also a strong and probably unnatural outcome restriction, so it should be recorded as a **sufficient strengthened primitive**, not as the preferred general theorem hypothesis.  

**Suggested next local action:** bank this lemma as the top strengthened sufficient primitive, but keep the Needed assumption explicit on the main least-strengthened route unless one is willing to impose this injective-fiber restriction.
