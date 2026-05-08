Verdict: OBSTRUCTION

## Statement

On the main least-strengthened exact route, the Needed assumption
[
\exists,p_0:M\to \Delta(\Omega)\ \text{Borel posterior version under }\beta^*
\quad\text{such that}\quad
\bar w^*(m)\in \arg\max_{w\in W} p_0(m)\cdot w
\ \text{for }q^*\text{-a.e. }m
]
cannot be derived from the already-banked reduced-side inputs alone. Equivalently, one cannot derive
[
g(m):=h_W(p_0(m))-p_0(m)\cdot \bar w^*(m)=0
\qquad q^*\text{-a.e.}
]
from those inputs without an extra condition that identifies posterior labels along fibers of (F:=\bar w^*). This refutes derivability on the current lift-to-raw-plus-patching route. It does **not** prove that no good raw lift exists under the standing hypotheses.   

## Proof idea or obstruction mechanism

The first precise obstruction is **fiber non-identifiability**.

The current continuity-based bridge gives only a raw lift whose content is collapsed through (F=\bar w^*): it fixes (F_{#}\beta^*=\kappa^*), so it controls only payoff functionals that depend on a raw message through the collapsed label (F(m)). That is weaker than the messagewise posterior statement needed for patching, because the Bayes gap
[
g_p(m)=h_W(p(m))-p(m)\cdot F(m)
]
need not factor through (F(m)). If two raw messages lie in the same fiber of (F), the reduced-side data are blind to how posterior labels are assigned inside that fiber, while (g_p) can change. 

A concrete two-message counterexample already shows the failure.

Take
[
\Omega={1,2},\qquad \mu_0=(1/2,1/2),
]
no private type, two actions (A={a_1,a_2}), and payoffs
[
u(a_i,\omega_j)=\mathbf 1{i=j}.
]
Then the feasible payoff set is
[
W=\operatorname{co}{e_1,e_2}=\Delta(\Omega).
]
Let the raw message space be ({m_1,m_2}), and define the deterministic reduced selector
[
\bar w^*(m_1)=\bar w^*(m_2)=\bar w:=(1/2,1/2).
]

This selector is a reduced saddle in the (\alpha=0) adversarial problem. Indeed, for any selector (w(\cdot)) write (w(m)=(x(m),1-x(m))). If the adviser sends after state (1) a message minimizing (x(m)) and after state (2) a message maximizing (x(m)), the induced payoff is
[
\frac12\Big(\min_m x(m)+1-\max_m x(m)\Big)\le \frac12.
]
So no selector secures more than (1/2). The constant selector (\bar w) secures exactly (1/2), because it yields payoff (1/2) in every state and after every message.

Now define, for each (a\in[0,1]), an admissible raw-message kernel (\beta_a) by
[
\beta_a(m_1\mid \omega_1)=a,\qquad \beta_a(m_2\mid \omega_1)=1-a,
]
[
\beta_a(m_1\mid \omega_2)=1-a,\qquad \beta_a(m_2\mid \omega_2)=a.
]
Under the prior ((1/2,1/2)), each (\beta_a) induces the same raw-message law
[
q^*(m_1)=q^*(m_2)=1/2,
]
and the posterior version
[
p_a(m_1)=(a,1-a),\qquad p_a(m_2)=(1-a,a).
]

Because (F=\bar w^*) is constant, all these lifts have the same collapsed data:
[
F_{#}\beta_a = F_{#}\beta_{a'}
\qquad \forall a,a'.
]
Also,
[
\mathcal G(\beta_a,\bar w^*)=\int p_a(m)\cdot \bar w^*(m),q^*(dm)=1/2
\qquad \forall a,
]
so adviser optimality against the fixed selector carries no information about (a).

But the Bayes gap does depend on (a). Since (W=\Delta(\Omega)),
[
h_W(p)=\max{p_1,p_2},
]
hence for (i=1,2),
[
g_a(m_i)=h_W(p_a(m_i))-p_a(m_i)\cdot \bar w
=\max{a,1-a}-1/2.
]
Therefore
[
g_a(m_i)=0 \iff a=1/2,
]
and for every (a\neq 1/2),
[
g_a(m_i)>0 \quad \text{for both } i=1,2.
]

So we have a whole family of admissible raw lifts with the **same** reduced-side collapsed information and the **same** adviser payoff against (\bar w^*), but only one of them has (q^*)-a.e. local Bayes optimality. Hence the Needed assumption is not a consequence of the already-banked reduced-side inputs.

This is exactly the first obstruction the current route hits: reduced-side information is invariant under re-labeling posterior mass inside fibers of (\bar w^*), while the null-set patching condition is not. 

## Exact dependency on already-banked inputs

* I use only the already-banked route facts that the main exact route works in the reduced game on compact convex (W), that the live bottleneck is message-side exactness after barycentric collapse to a deterministic selector (\bar w^*), and that the current bridge aims to pass from a reduced saddle to a raw-message posterior statement.   
* I use the reviewer-cleared obstruction that the current lift theorem identifies only ( \bar w^*_{#}\beta^* ) and therefore only factor-through-(\bar w^*) functionals, not the messagewise zero-gap property. 
* I use the banked conditional exact version-and-patching lemma only as a downstream check: once the Needed assumption is granted, the patching argument closes and yields the full reduced-game saddle. So the issue isolated here is exactly the missing derivation of that assumption. 
* I do **not** use injective-fiber, any equivalent fiber-rigidity hypothesis, or any reopening of the settled finite-(M) and reduced-side lemmas.

## Next local consequence

The durable proof state should record that the main exact route remains conditional: the posterior-labeled raw-lift assumption is not removable from the already-banked reduced-side inputs alone. Any unconditional continuation must add some new posterior-labeling principle on raw messages, or move to a different branch.

Suggested next local action: Bank this fiber non-identifiability obstruction and restate the main exact theorem conditionally on the posterior-labeled raw-lift assumption unless a new raw-message labeling lemma is proved.
