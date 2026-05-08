# Countable Atomic Attainment Route

## Status

Reviewer-cleared active route as of `2026-03-17`.

This route now replaces the exhausted direct tail/recurrence branch as the main beyond-finite-`M` candidate.
The unconditional attainment theorem on this route is now disproved on the present record by a genuine escape-of-mass counterexample.

## Core idea

Do not try to recover exact recurring fiber membership from local tail data `j -> K_j`.

Instead, lift the finite alternative proof to the Banach pair

- `X := prod_{mu in I} l^1(M)`
- `X* := prod_{mu in I} l^infty(M)`

for countable atomic `M`, with the same finite row index set `I` as in the alternative-proof formalization.

The new primitive is not message-level recurrence. It is adversary attainment/tightness:

- `min_{beta in K} V(beta)` is attained for
- `K := prod_{mu in I} Delta(M) subset X`

Once `beta*` exists, the selector/subgradient argument should recover the simultaneous equal-payoff-on-support condition row by row, exactly as in the finite-case alternative proof.

## Credible theorem shape

Assume:

- `M` countable atomic
- `I` finite
- sender payoffs bounded
- Bayes problem admits at least one Bayes-optimal selector at every posterior that can arise
- adversary problem attains a minimizer `beta*`

Then the finite-case alternative proof should extend:

1. choose one Bayes-optimal selector `sigma_m*` for each message `m`
2. define `g* in X*` by the selector payoffs
3. show `g* in partial V(beta*)`
4. use `-g* in N_K(beta*)`
5. deduce rowwise equal-payoff-on-support on `supp beta*(.|mu)`
6. run the same rowwise commitment linear program

## Reviewer-cleared verdict

The route-level reviewer passed the branch switch.

Safe banked conclusions:

- the `l^1 / l^infty` selector/subgradient lift is coherent once a minimizer `beta*` exists
- the normal cone to the countable simplex gives the same equal-payoff-on-support conclusion row by row
- the first genuine theorem-level obstacle is adversary-side attainment / tightness, not recurrence
- compactness of `W` is only auxiliary; it does not replace the `l^1` tightness problem

## Main conditional proposition

The first theorem-sized proposition on this route is now banked.

Safe banked conclusions:

- if the adversary problem attains a minimizer `beta* in K`, then the finite alternative-proof
  selector/subgradient mechanism extends coherently in
  - `X := prod_{mu in I} l^1(M)`
  - `X* := prod_{mu in I} l^infty(M)`
- one gets a messagewise Bayes-optimal selector family `g* in X*` with
  - `g* in partial V(beta*)`
  - `-g* in N_K(beta*)`
  - equivalently `0 in partial V(beta*) + N_K(beta*)`
- rowwise equal-payoff-on-support then follows from the normal cone to the countable simplex

Exact caveat now isolated:

- beyond mere attainment of `beta*`, the proof uses a Bayes-side subgradient-realization property:
  every `d in partial V(beta*)` must be realizable as the payoff array of one messagewise
  Bayes-optimal selector family
- this is the right caveat, not a hidden finite-dimensional LP assumption

## Attainment theorem verdict

The unconditional theorem

- `inf_{beta in K} V(beta)` is attained on `K := prod_{mu in I} Delta(M)`

is false under the standing hypotheses alone.

Safe banked conclusions:

- there is a genuine escape-of-mass counterexample already inside the support-function architecture
- minimizing sequences can run down an infinite message tail without remaining rowwise uniformly tight
- so attainment is not a generic compactness consequence of bounded continuous support-function structure

Banked positive replacement:

- if near-minimizers are rowwise uniformly tight, then attainment follows by norm precompactness in
  `X := prod_{mu in I} l^1(M)` together with continuity of `V`
- once attainment holds, the already banked selector/subgradient proposition reactivates immediately

Natural theorem-level reformulation:

- add an explicit near-minimizer tightness or message-coercivity hypothesis
- prove attainment from that hypothesis
- then conclude rowwise equal-payoff-on-support from the selector/subgradient step

## Reviewer-cleared endpoint

The reviewer now passes the full branch endpoint.

Safe banked conclusions:

- the escape-of-mass counterexample is sound and kills unconditional attainment on this route
- the exact surviving positive theorem is a conditional attainment statement under an explicit
  near-optimal sublevel-set tightness / message-coercivity hypothesis
- continuity of `V` is stronger than necessary for the attainment step; lower semicontinuity is enough
- the packet formulation "every near-minimizing sequence is rowwise uniformly tight" is valid but can be sharpened
  to one tight near-optimal sublevel set
- once attainment is available, the already-banked selector/subgradient proposition closes the rowwise
  equal-payoff-on-support step

Clean theorem shape now preferred:

- if there exists `eta > 0` such that
  - `A_eta := { beta in K : V(beta) <= inf_K V + eta }`
  is rowwise uniformly tight,
- then `V` attains its infimum on `K`
- then the banked selector/subgradient proposition applies at the minimizer

## Conditional theorem package

The first full theorem-sized replacement is now banked at prover level.

Safe banked conclusions:

- the least-strengthened attainment theorem on this branch uses one tight near-optimal sublevel set,
  not the looser wrapper "every near-minimizing sequence is tight"
- lower semicontinuity of `V` is sufficient for the attainment step
- finiteness of `I` lets rowwise tightness upgrade to product-`l^1` precompactness
- once a minimizer `beta*` exists, the already-banked selector/subgradient proposition yields
  rowwise equal-payoff-on-support, conditional on the explicit Bayes-side subgradient-realization caveat

Preferred theorem shape:

1. if there exists `eta > 0` such that
   - `A_eta := { beta in K : V(beta) <= inf_K V + eta }`
   is rowwise uniformly tight,
   then `V` attains its infimum on `K`
2. if, moreover, Bayes-side subgradient realization holds at the attained minimizer,
   then the selector/subgradient corollary applies and recovers rowwise equal-payoff-on-support

Remaining open point inside this route:

- identify a primitive message-coercivity condition implying tightness of one near-optimal sublevel set

## Reviewer-cleared conditional endpoint

The reviewer now passes the full conditional theorem package.

Safe banked conclusions:

- the conditional attainment theorem is sound as stated
- the product-`l^1` compactness argument is the right one:
  - finiteness of `I` merges rowwise tightness into one product tail bound
  - diagonal extraction on finite truncations plus uniform tails gives norm precompactness in `X`
- lower semicontinuity of `V` is genuinely sufficient for the attainment step
- the selector/subgradient corollary plugs in honestly at the attained minimizer
- the Bayes-side subgradient-realization caveat remains the only explicit downstream caveat
- there is no further hidden theorem-level gap inside this conditional route

So the branch should now be treated as a clean conditional theorem route:

1. unconditional negative theorem:
   - generic attainment fails by escape of mass
2. conditional positive theorem:
   - one tight near-optimal sublevel set implies attainment
3. downstream conditional corollary:
   - attainment plus Bayes-side subgradient realization implies rowwise equal-payoff-on-support

## Coercive finite-set capture

The next theorem-sized prover pass proposed a reduced-form tail-gap sufficient condition.

Safe banked prover conclusions:

- the best current primitive theorem hypothesis is a coercive finite-set capture condition on the
  reduced value functional `V`
- preferred form:
  - there exist `bar_eta > 0`, an increasing finite exhaustion `F_n \uparrow M`, and tail levels
    `r_n \downarrow 0` such that for every `n`,
    - `inf { V(beta) : beta in K, T_{F_n}(beta) >= r_n } >= inf_K V + bar_eta`
  where
    - `T_{F_n}(beta) := sum_{mu in I} beta_mu(M \ F_n)`
- this is a genuine value-gap exclusion principle against escape of mass, not just tightness restated
- it implies one tight near-optimal sublevel set immediately
- once that is in place, the already-banked conditional attainment theorem and selector/subgradient
  corollary reactivate verbatim

Reviewer-cleared correction:

- coercive finite-set capture is mathematically sound
- its implication to one tight near-optimal sublevel set is sound
- but on the present branch with finite `I`, it is not more primitive than the already-banked
  tight-sublevel hypothesis
- it is theorem-equivalent to the existence of one rowwise uniformly tight near-optimal sublevel set
  `A_eta`

So this condition should be treated only as an equivalent reduced-form restatement of the current
conditional theorem package, not as the new leading branch assumption.

## First hard lemma

`Attainment/Tightness Lemma`:

- any minimizing sequence in `K = prod_{mu in I} Delta(M)` has a subsequence that is rowwise uniformly tight and converges to some `beta* in K` strongly enough for `V` to pass to the limit

This is now understood as a conditional lemma rather than something forced by the standing hypotheses.

## Relation to compact reduced-payoff route

A compact reduced payoff space `W` is relevant only as a way to prove the attainment/tightness lemma.

To be useful, the reduced Bayes envelope must be continuous enough that its subgradients live in `C(W)`. A naive weak-* compactification in `P(W)` without this continuity is not yet a clean theorem route.

## Consequence for the old direct branch

Treat the old countable-atomic direct tail/recurrence route as blocked on the present record.

Its obstruction is structural:

- local tail closure data only gives limsup / closure-of-tail-unions membership
- exact recurring fiber membership is the wrong object to extract before global attainment

## Next move

Do not keep probing generic attainment under the standing hypotheses. That theorem is now blocked and reviewer-cleared as blocked.

Next macro actions:

- use the alternative-proof formalization to search for a genuinely earlier structural condition
  implying the tight-sublevel / coercive finite-set capture package
- if no such source exists, keep the route stated only as the current conditional theorem:
  tight near-optimal sublevel set + lower semicontinuity + Bayes-side subgradient realization

## Alternative-proof structural-source verdict

The larger theorem-design pass using the alternative-proof formalization is now banked at prover
level with verdict `HOLD`.

Safe banked conclusions:

- the alternative-proof architecture does not produce a genuinely earlier structural condition beyond
  the current countable-atomic endpoint
- where finite `M` is doing real work is adversary-side compactness / minimizer existence
- the selector/subgradient mechanism itself is already portable once attainment is restored
- a rowwise inf-compactness condition on selector payoff arrays is the closest structural analogue
  visible from that architecture, but at the strength needed to imply attainment it is just the
  existing tightness/coercivity package in coefficient-array form

So the honest route endpoint remains:

1. one tight near-optimal sublevel set `A_eta`
2. lower semicontinuity of `V`
3. Bayes-side subgradient realization at the attained minimizer

and the branch should not spend more theorem-design cycles on repackaging that same coercive content
inside the finite alternative-proof architecture.

Reviewer-cleared status:

- the `HOLD` verdict now passes
- this branch should therefore be treated as frozen in conditional form
- the honest endpoint on this architecture is exactly:
  1. one tight near-optimal sublevel set `A_eta`
  2. lower semicontinuity of `V`
  3. Bayes-side subgradient realization at the attained minimizer
- any further beyond-finite-`M` progress must come from a genuinely new architecture or a genuinely
  new model-side primitive, not another reformulation inside this attainment/alternative-proof route
