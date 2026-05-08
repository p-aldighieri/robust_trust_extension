## 1. Numbered lemmas in dependency order

1. **Exact reduction to a reduced relaxed game on (W).**
   Let
   [
   W \subset \mathbb R^{|\Omega|}
   ]
   be the compact convex payoff-vector set from Appendix A.1. Let (\Gamma) be the set of measurable kernels
   [
   \gamma: M \rightsquigarrow \Delta(W).
   ]
   Define the reduced payoff
   [
   \mathcal G(\beta,\gamma)
   ========================

   \alpha \int_M \tau(ds)\int_W s\cdot w,\gamma(dw\mid s)
   +(1-\alpha)\int_M\tau(ds)\int_M \beta(dm\mid s)\int_W s\cdot w,\gamma(dw\mid m).
   ]
   Prove that the original max-min value equals
   [
   \sup_{\gamma\in\Gamma}\inf_{\beta\in B}\mathcal G(\beta,\gamma),
   ]
   and that any deterministic selector (w:M\to W) is identified with the Dirac kernel (m\mapsto \delta_{w(m)}).

   What is imported here is only Appendix A.1: conditional on adviser belief (s), the agent’s continuation payoff depends on the private strategy only through (w\in W), via (s\cdot w).

2. **Kernel-topology saddle existence for the reduced game.**
   Pick one concrete topology on (B) and (\Gamma), preferably a Balder/Borkar-style stable topology on kernels rather than weak convergence of induced joint laws. Prove the following three facts in that topology:

   1. (B) is compact and convex.
   2. (\Gamma) is compact and convex.
   3. (\mathcal G) is affine in each argument and separately continuous.

   Then invoke one minimax theorem, stated with hypotheses checked explicitly, to obtain a saddle point ((\beta^*,\gamma^*)).

   This is the whole topology block. It should not be written as “apply Sion/Balder” without the checks. Under the standing assumptions, the standard-Borel and compact-metric pieces are available. The actual work is the compactness and continuity verification for the chosen kernel topology.

3. **Posterior representation and (q^*)-a.e. local optimality at a reduced saddle.**
   For any (\beta), define the induced message law
   [
   q_\beta(dm)=\alpha\tau(dm)+(1-\alpha)\int_M \tau(ds)\beta(dm\mid s).
   ]
   Let (p_\beta(\cdot)) be a Borel (q_\beta)-version of the posterior kernel. Then
   [
   \mathcal G(\beta,\gamma)
   ========================

   \int_M q_\beta(dm)\int_W p_\beta(m)\cdot w,\gamma(dw\mid m).
   ]
   If ((\beta^*,\gamma^*)) is a saddle, then for some Borel (q^*)-version (p^*) of the posterior under (\beta^*),
   [
   \operatorname{supp}\gamma^*(\cdot\mid m)\subseteq
   \arg\max_{w\in W} p^*(m)\cdot w
   \quad\text{for }q^*\text{-a.e. }m.
   ]
   Otherwise a measurable pointwise improvement on a positive-(q^*) set would contradict that (\gamma^*) is a best response to (\beta^*).

4. **Barycentric collapse.**
   Define
   [
   \bar w(m):=\int_W w,\gamma^*(dw\mid m).
   ]
   Then (\bar w:M\to W) is Borel, and for every (\beta),
   [
   \mathcal G(\beta,\gamma^*)=\mathcal G(\beta,\bar w).
   ]
   Since (W) is convex, (\bar w(m)\in W). Since argmax sets of linear functionals over a convex set are convex, the (q^*)-a.e. local optimality from Lemma 3 implies
   [
   \bar w(m)\in \arg\max_{w\in W} p^*(m)\cdot w
   \quad\text{for }q^*\text{-a.e. }m.
   ]
   Hence ((\beta^*,\bar w)) is already a deterministic reduced saddle, except only (q^*)-a.e. on the messagewise optimality clause.

5. **Finite-dimensional selector package on (W).**
   This is the minimal support needed before the exact patch.

   **5a. Dominating-frontier selector.**
   Let (W^P) be the weak Pareto frontier from Appendix A.1. Define
   [
   F(w):={v\in W^P: v\ge w \text{ coordinatewise}}.
   ]
   Using the Appendix A.1 domination fact, (F(w)\neq\varnothing) for every (w\in W). Prove there is a Borel selector
   [
   D:W\to W^P,\qquad D(w)\ge w \text{ coordinatewise}.
   ]

   **5b. Supporting-belief selector.**
   For (v\in W^P), define
   [
   S(v):=\Bigl{\mu\in\Delta(\Omega): \mu\cdot v=\max_{u\in W}\mu\cdot u\Bigr}.
   ]
   By Appendix A.1, (S(v)\neq\varnothing) for every (v\in W^P). Prove there is a Borel selector
   [
   \pi:W^P\to \Delta(\Omega),\qquad \pi(v)\in S(v).
   ]

   These are finite-dimensional measurable-selection lemmas on compact sets. They are much cleaner than the topology block.

6. **Critical lemma: exact version-and-patching saddle lemma.**
   Starting from the deterministic reduced saddle ((\beta^*,\bar w)) of Lemma 4, patch the (q^*)-null bad set using Lemma 5 so that messagewise Bayes optimality holds for every message while the adviser-side saddle inequality is preserved against every (\beta\in B).

---

## 2. Explicit critical lemma

**Critical Lemma (Exact version-and-patching saddle lemma).**
Let ((\beta^*,\bar w)) be as in Lemma 4. Let
[
q^*(dm)=\alpha\tau(dm)+(1-\alpha)\int_M \tau(ds)\beta^*(dm\mid s),
]
and let (p_0) be a Borel (q^*)-version of the posterior under (\beta^*) such that
[
\bar w(m)\in \arg\max_{w\in W} p_0(m)\cdot w
\quad\text{for }q^*\text{-a.e. }m.
]
Then there exist Borel maps
[
w^*:M\to W,\qquad p^*:M\to \Delta(\Omega)
]
such that:

1. (p^*=p_0) (q^*)-a.e., so (p^*) is still a (q^*)-version of the same posterior kernel.
2. For every (m\in M),
   [
   w^*(m)\in \arg\max_{w\in W} p^*(m)\cdot w.
   ]
3. For every (m\in M),
   [
   w^*(m)\ge \bar w(m)
   \quad\text{coordinatewise}.
   ]
4. ((\beta^*,w^*)) is a saddle point of the deterministic reduced game.

**Proof skeleton.**
Let
[
N:=\Bigl{m\in M:\bar w(m)\notin \arg\max_{w\in W} p_0(m)\cdot w\Bigr}.
]
Then (q^*(N)=0).

Set
[
w^*(m)=
\begin{cases}
\bar w(m), & m\notin N,\
D(\bar w(m)), & m\in N,
\end{cases}
]
where (D) is the selector from Lemma 5a. Thus (w^*(m)\ge \bar w(m)) everywhere, and (w^*(m)\in W^P) on (N).

Now set
[
p^*(m)=
\begin{cases}
p_0(m), & m\notin N,\
\pi(w^*(m)), & m\in N,
\end{cases}
]
where (\pi) is the selector from Lemma 5b. Then (p^*=p_0) (q^*)-a.e., hence (p^*) is a valid posterior version, and by construction (w^*(m)) is Bayes-optimal for (p^*(m)) for every (m).

Why the saddle survives:

* Against (\beta^*), the payoff is unchanged because the modification occurs only on the (q^*)-null set (N).
* Against any other (\beta), the payoff weakly rises because (w^*(m)-\bar w(m)) is coordinatewise nonnegative, and every source belief (s\in M\subseteq \Delta(\Omega)) has nonnegative coordinates. Hence
  [
  \mathcal G(\beta,w^*)\ge \mathcal G(\beta,\bar w)
  \quad\forall \beta\in B.
  ]
* Since ((\beta^*,\bar w)) was already a saddle, it follows that ((\beta^*,w^*)) is still a saddle.

So the dangerous part is not adversariality itself. The hinge is the monotone patch on the (q^*)-null set.

---

## 3. Imported background versus new work

**Imported background.**

1. Appendix A.1: compact convexity of (W).
2. Appendix A.1: Bayes-optimal payoff vectors are exactly the weak Pareto frontier (W^P).
3. Appendix A.1: every (w\in W) is coordinatewise dominated by some (v\in W^P).
4. The paper’s standing wlog reduction that the misaligned adviser can be restricted to messages in (M).
5. The trusted finite-(M), compact-(\Theta) extension is baseline context and should not be reproved here.

**New work beyond finite (M).**

1. The kernel-topology saddle-existence block in Lemma 2.
2. The (q^*)-a.e. local-optimality lemma in the reduced game.
3. The barycentric collapse lemma.
4. The measurable versions of the domination and supporting-belief selections on (W).
5. The exact version-and-patching saddle lemma.

One caveat to keep explicit: if the final proof is written back in full private-strategy language rather than staying in (W)-space almost to the end, there may be one extra measurable-implementation lemma from (m\mapsto w^*(m)) to (m\mapsto \hat\sigma(m)). I am not expanding that here because the prompt explicitly asks for the beyond-finite-(M) exact-route skeleton, not the full writeup.

---

## 4. Fallback branch if the critical lemma fails

If the critical lemma fails, the clean fallback theorem branch is:

**Purely atomic infinite support.** Assume (M) is countable and (\tau({m})>0) for every (m\in M).

Why this is the right fallback: for (\alpha>0),
[
q^*({m})\ge \alpha \tau({m})>0
\quad\forall m\in M,
]
so the reduced saddle already forces pointwise messagewise optimality, and the null-set patching problem disappears. This isolates nonatomic support as the real obstruction.

Needed caveat: if (\alpha=0), one still needs a separate countable version of the existing (\alpha=0) edge patch.

Suggested next local action: prover.
