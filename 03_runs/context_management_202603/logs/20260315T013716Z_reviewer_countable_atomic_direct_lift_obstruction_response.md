## Verdict: PASS

**First specific defect:** none.

The obstruction is real. The lift needed for Theorem 2 is a **message-by-message Bayes-optimality** statement on every on-path message, not just existence of an honest kernel that attains each row minimum. The banked rowwise-attainment step only yields
[
\operatorname{supp}\beta_i^* \subseteq \arg\min_j (m_i\cdot w_j^*),
]
which is strictly weaker.

The finite example cleanly separates those two requirements. In
[
\Omega={1,2},\qquad W=\operatorname{co}{A,B},\quad A=(1,0),\ B=(0,1),
]
with
[
m_1=\left(\tfrac34,\tfrac14\right),\qquad m_2=\left(\tfrac18,\tfrac78\right),\qquad
\tau_1=\tau_2=\alpha=\tfrac12,
]
the reduced objective is uniquely maximized at
[
w_1^*=w_2^*=B.
]
At that maximizer both rows are ties, so **every** stochastic kernel is an honest rowwise minimizing kernel. But the specific honest choice
[
\beta_{11}^*=\beta_{21}^*=1,\qquad \beta_{12}^*=\beta_{22}^*=0
]
gives
[
\lambda_1=\tfrac34,\qquad q_1=\left(\tfrac{13}{24},\tfrac{11}{24}\right),
]
hence
[
q_1\cdot A=\tfrac{13}{24}>\tfrac{11}{24}=q_1\cdot B.
]
So message (1) is on path, yet (w_1^*=B) is not Bayes-optimal there. This refutes the naive implication
[
\text{rowwise attainment}+\text{arbitrary honest rowwise minimizing }\beta^*
;\Longrightarrow;
\text{coordinatewise Bayes optimality on path}.
]

Since the countable atomic branch contains finite atomic environments as a special case, this is enough to kill the naive direct-lift route.

The nice part is that the example only kills the **arbitrary-selector** route, not the **existence-of-a-good-selector** route. In the same example, the honest kernel
[
\beta_{12}^*=\beta_{21}^*=1,\qquad \beta_{11}^*=\beta_{22}^*=0
]
yields
[
q_1=q_2=\left(\tfrac{7}{16},\tfrac{9}{16}\right),
]
so (B) is Bayes-optimal at both messages. Thus the surviving issue is exactly **kernel selection on tie sets**, not absence of admissible selectors.

## Replacement local lemma / next bottleneck

The strongest still-plausible replacement is:

> **Coordinatewise supporting-kernel selection lemma.**
> For every reduced maximizer (w^*=(w_j^*)), there exists an honest rowwise minimizing kernel (\beta^*) such that for every on-path message (j) with
> [
> \lambda_j=\left|\alpha\tau_j m_j+(1-\alpha)\sum_i \tau_i \beta_{ij}^* m_i\right|*1>0,
> ]
> we have
> [
> a_j(\beta^*) := \alpha\tau_j m_j+(1-\alpha)\sum_i \tau_i \beta*{ij}^* m_i \in N_W(w_j^*),
> ]
> equivalently
> [
> w_j^* \in \arg\max_{w\in W} a_j(\beta^*)\cdot w .
> ]

That is strictly stronger than rowwise attainment and exactly matches the missing Theorem 2 certification step.

**Suggested next local action:** formulate the set of honest rowwise minimizing kernels for a fixed reduced maximizer (w^*) as a feasibility problem on the rowwise tie sets, and prove or refute that one can choose (\beta) from that set so that
[
a_j(\beta)\in N_W(w_j^*)\quad\text{for all on-path }j
]
simultaneously.
