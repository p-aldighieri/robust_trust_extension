# Phil Reny's email suggestion (Lusin-regularization to lift restriction on player 2)

*Verbatim from `phil's suggestion.txt`, with light notation cleanup.*

---

Hi Piotr:

Let $\sigma^*$ be the optimal strategy for player 1 from the notes I sent. Perhaps
there is a way to extend the argument to show that $\sigma^*$ guarantees the value
for player 1 even if we lift the restriction on player 2's strategies. The
argument is roughly as follows.

By **Lusin's theorem** there is an increasing sequence of compact subsets
$S_1, S_2, \ldots$ of $S$ whose union $S^*$ has measure 1 for each $G(\cdot \mid \omega)$,
such that $\sigma(\cdot \mid s)$ is continuous on $S_n$ for every $n$.

We can now modify $\sigma^*$ so that for messages outside $S^*$ it behaves as if
the message was some fixed element of $S^*$.

Suppose by way of contradiction that there is a measurable map $d: S \to S$ that
player 2 can use to send the message $d(s)$ when she observes $s$ that yields
player 1 a payoff less than the value. Then $d(\cdot)$ would have to send messages
outside $S^*$ with probability one. This is because if a message inside $S^*$ were
a profitable deviation for player 2, then that message would be in $S_n$ for some
$n$. Moreover, since we can construct the sequence $S_1, S_2, \ldots$ such that
any open set around any point in any $S_k$ has positive $G(\cdot \mid \omega)$
probability for every $\omega$ when intersected with $S_k$, the continuity of
$\sigma^*$ on $S_n$ implies that there is a measurable map that player 2 could
have used to push 1's payoff below the value. But that is not possible by the
definition of $\sigma^*$.

If correct, this establishes the existence of an optimal strategy for player 1,
**but not for player 2**. Lots of details to check here. So the probability of an
error is non-trivial.

Phil.

---

## Editorial summary (orchestrator)

- **Two-stage strategy:** (1) prove existence of σ* that secures the value
  *against player-2 strategies in F* (the convex absolutely-continuous-against-Ḡ
  restricted set) using Mertens (1986) Corollary B + Balder (1988) continuity
  on Σ. (2) Lift the restriction on player 2 to all measurable kernels via
  Lusin regularization of σ*.
- **Lusin-regularization mechanics:** the increasing compacts $S_n$ are chosen
  σ*-continuous AND "support-thick" (every open neighborhood of any point in
  $S_k$ has positive $G(\cdot\mid\omega)$ measure when intersected with $S_k$).
  This thickness is what lets us turn a measurable deviation $d$ into a
  continuous deviation, contradicting σ*'s optimality on the restricted game.
- **Caveat (acknowledged by Phil):** this delivers σ* only. To complete
  Theorem 2 we still need an adversarial β* that makes σ* myopically optimal at
  each on-path m. This is the gap to close on top of Phil's argument.
