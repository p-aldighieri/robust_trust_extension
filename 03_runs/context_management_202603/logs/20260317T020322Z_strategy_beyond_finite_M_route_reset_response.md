## Verdict

ROUTE: there is a credible broader theorem route worth pursuing now, but it is not the current countable-atomic direct tail/recurrent-fiber route. The credible route is to lift the finite alternative proof from finite-dimensional simplex geometry to the Banach pair

- `X := prod_{mu in I} l^1(M)`
- `X* := prod_{mu in I} l^infty(M)`

for countable atomic `M`, with the same finite row index set `I` as in the current alternative-proof formalization. The genuinely new primitive is not a message-level recurrence statement. It is adversary attainment/tightness. Once an optimizer `beta*` exists, the selector/subgradient argument should recover the global support equalization that the direct branch has failed to manufacture.

## Best Credible Route

The strongest credible theorem statement now is:

- `M` countable atomic
- row index set `I` finite
- sender payoffs bounded
- Bayes problem admits at least one Bayes-optimal selector at every posterior that can arise
- adversary problem
  - `min_{beta in K} V(beta)`
  - `K := prod_{mu in I} Delta(M) subset X := prod_{mu in I} l^1(M)`
  attains a minimizer `beta*`

Under those assumptions, the finite-`M` alternative proof should extend as follows:

1. Choose one Bayes-optimal selector `sigma_m*` for each message `m`.
2. Define the coefficient array `g*` in `X*` by the selector payoffs.
3. Show, via the same envelope logic, that `g*` is a subgradient of `V` at `beta*`.
4. Use first-order optimality over the closed convex set `K`:
   - `-g* in N_K(beta*)`
5. Because the normal cone of the countable simplex `Delta(M) subset l^1(M)` is still explicit, row by row we get:
   - `g*_{mu,m} <= lambda_mu` for all `m`
   - equality on `supp beta*(.|mu)`

That is exactly the simultaneous equal-payoff-on-support conclusion needed for the commitment step. The same rowwise commitment linear program then goes through.

This is materially more primitive than assuming the missing message-level posterior structure. The new assumption is only a global optimization primitive: adversary attainment/tightness, not an exact recurrence hypothesis about concrete message labels.

The first real hard lemma is therefore:

- `Attainment/Tightness Lemma`
  - any minimizing sequence in `K = prod_{mu in I} Delta(M)` has a subsequence that does not lose mass to fresh messages and converges to some `beta* in K` strongly enough for `V` to be lower semicontinuous along that subsequence

A compact reduced-payoff space `W` is relevant as a way to prove that lemma, but only if the reduced Bayes envelope is continuous enough that its subgradients are represented by elements of `C(W)`, not merely bounded measurable functions.

## Why The Current Direct Branch Stalls

The direct countable-atomic branch is failing for a structural reason, not because one more local repair is missing.

The banked frontier says that for the concrete sequence `j -> K_j`, one gets only limsup / closure-of-tail-unions information. That is exactly what noncompactness in a countable simplex looks like: mass keeps shifting onto fresh labels, so the robust statement is accumulation in closure, not exact recurring membership in the same fibers.

The desired upgrade to exact recurring-fiber membership is stronger than it looks. It is naturally a first-order optimality statement at an attained minimizer, not something that tail closure alone can manufacture. The direct branch is trying to recover a global exposing-functional conclusion from purely local tail data. On the present record, that is the wrong object.

So the direct branch should be treated as blocked unless one adds exactly the kind of structure that restores an attained global optimizer or an equivalent compactified reduced-form problem.

## Minimal New Assumption Or Structure

The minimal new primitive is:

- `Adversary-attainment / compactness`
  - `min_{beta in prod_{mu in I} Delta(M)} V(beta)` is attained

At route level, that is the exact missing structure. It says minimizing sequences cannot bleed mass forever into ever-new messages in a way that destroys support exposure.

The natural functional-analytic implementation is:

- a compact reduced payoff representation `W`
- plus continuity strong enough that the reduced Bayes envelope has subgradients represented in `C(W)`

A naive weak-* replacement on `P(W)` is not enough by itself. If selector payoff functions are only measurable, the dual object moves into the wrong universe. So the useful addition is not vague compactness, but an attained optimizer in the correct dual pair.

## Suggested next macro action

Freeze the direct countable-atomic tail branch and rewrite the beyond-finite-`M` extension around the alternative proof as a theorem conditional on adversary attainment/tightness in `prod_{mu} l^1(M)`.
