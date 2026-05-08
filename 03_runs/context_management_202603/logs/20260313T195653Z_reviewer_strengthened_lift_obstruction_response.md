## Verdict

PASS, with local wording fixes.

The obstruction is correct in the form needed for the current exact-route bridge. The trusted continuity-based lift only gives a raw kernel (\beta^*) with
[
\bar w^*_{#}\beta^*=\kappa^*,
]
so it preserves only those payoff functionals that depend on the lifted raw message (m') through the collapsed label (\bar w^*(m')). That is strictly weaker than the posterior-level statement needed for null-set patching, namely the existence of a posterior version (p_0) for the lifted raw kernel such that
[
g(m):=h_W(p_0(m))-p_0(m)\cdot \bar w^*(m)=0
\qquad\text{for }q^*\text{-a.e. }m.
]
Without that, the patching step has no basis for concluding that
[
N:={m:g(m)>0}
]
is (q^*)-null.

The two-message obstruction is enough to establish this non-implication for the present bridge: the collapsed payoff (G(\beta_a,\bar w^*)) can be independent of the lift parameter (a), so adviser optimality against the fixed selector carries no additional posterior information, yet for an admissible lift one still gets a positive Bayes gap on a positive-(q) set. Thus the current lift theorem, even with saddle-specific continuity of (\bar w^*), does not by itself furnish the posterior-labeled raw lift needed by the exact version-and-patching argument.

Two wording fixes should be made explicit.

1. The missing ingredient is **not** existence of a posterior version simpliciter. The missing ingredient is a posterior version for the chosen raw lift with zero Bayes gap, equivalently (q^*)-a.e. local optimality.
2. The obstruction should be stated as a failure of implication for **this lift-to-raw plus patching route**. Read as the stronger claim that no raw lift under the standing hypotheses could ever satisfy the desired property, the current example is too weak, because it exhibits a bad lift rather than ruling out every good lift.

## Smallest viable repair

**Needed assumption.** The chosen raw lift (\beta^*) admits a Borel posterior version
[
p_0:M\to\Delta(\Omega)
]
such that
[
\bar w^*(m)\in \arg\max_{w\in W} p_0(m)\cdot w
\qquad\text{for }q^*\text{-a.e. }m.
]

Equivalently, because (p_0) is a posterior version under (\beta^*),
[
G(\beta^*,\bar w^*)=\int p_0(m)\cdot \bar w^*(m),q^*(dm),
]
so imposing
[
\int h_W(p_0(m)),q^*(dm)=G(\beta^*,\bar w^*)
]
forces the nonnegative gap
[
h_W(p_0(m))-p_0(m)\cdot \bar w^*(m)
]
to vanish (q^*)-a.e.

## Proof-state consequence

Bank the strengthened-lift obstruction. The durable proof state and route memo already identify the exact version-and-patching saddle lemma as the live bottleneck, and this review confirms that the current continuity-based lift does not remove it.

Suggested next local action: state the Needed assumption explicitly and prove the exact version-and-patching saddle lemma conditionally under it, rather than spending another cycle trying to strengthen the present lift theorem alone.
