# Phil Reny's contribution to the Robust Trust Theorem 2 infinite-extension

This bundles the two pieces of writing Phil Reny sent (a partial result, then
an email suggestion building on it), plus a brief précis of the two literature
references he attached. It is a durable source for the proof project.

---

## Part 1 — Piotr's problem note (as sent to Phil)

*Reconstructed verbatim from `piotrs problem.pdf`. Math symbols recovered from
page image; prose verbatim.*

> Here is a partial result that might be useful. First, let me suppose that the
> signal $\theta$ is not present. Also, let me think of this as a two-person
> zero-sum game where player 1 chooses a transition probability
> $\sigma(da \mid s)$, player 2 chooses a transition probability
> $\pi(dm \mid s)$, and player 1's payoff is
>
> $$
> \sum_{\omega} \mu_0(\omega)\!\left(\alpha \int_{A \times S} u(a,\omega)\, \sigma(da \mid s)\, G(ds \mid \omega) \;+\; (1-\alpha) \int_{A \times M \times S} u(a,\omega)\, \sigma(da \mid m)\, \pi(dm \mid s)\, G(ds \mid \omega)\right).
> $$
>
> Assume that $M = S$ and restrict player 2 to strategies $\pi(dm \mid s)$ of
> the form $f(m \mid s)\, \bar G(dm)$, where
> $\bar G := \sum_{\omega} \mu_0(\omega) G(\cdot \mid \omega)$. Thus, I am
> restricting player 2 to strategies that, for each observed $s$, are
> absolutely continuous with respect to $\bar G$. I'm guessing that an
> equilibrium of this form, if it could be shown to exist, would be an
> equilibrium. The remainder of this note hinges on this guess.
>
> Thus, player 2's (restricted) pure strategy set is the convex set of jointly
> measurable functions $f(m \mid s)$ on $S \times S$. Denote this set by $F$.
> We can write 1's payoff as
>
> $$
> \sum_{\omega} \mu_0(\omega)\!\left(\alpha \int_{A \times S} u(a,\omega)\, \sigma(da \mid s)\, G(ds \mid \omega) \;+\; (1-\alpha) \int_{A \times M} u(a,\omega) \!\left(\int_S f(m \mid s)\, G(ds \mid \omega)\right) \sigma(da \mid m)\, \bar G(dm)\right).
> $$
>
> This function is continuous in $\sigma$ for each $f \in F$ when we endow 1's
> strategy space $\Sigma$ with the topology in which $\sigma_n \to \sigma$ iff
> $\sigma_n G(\cdot \mid \omega)$ weak\* converges to $\sigma G(\cdot \mid \omega)$
> for each $\omega$ (and so also $\sigma_n \bar G$ weak\* converges to
> $\sigma \bar G$). Moreover $\Sigma$ is compact under this topology.
>
> Hence, since $F$ is convex, **Mertens (1986, p. 238 Corollary (B))** implies
> that
>
> $$
> \max_{\sigma \in \Sigma} \inf_{f \in F} U(\sigma, f) \;=\; \inf_{f \in F} \max_{\sigma \in \Sigma} U(\sigma, f).
> $$
>
> This is what I am able to say for now. Perhaps it will be helpful to you. — Phil.
>
> *Footnote.* Note that continuity in this topology holds even though the
> second integral has an integrand that is only measurable (and so perhaps
> discontinuous in $m$). Continuity nonetheless follows since the marginal of
> $\sigma_n \bar G$ on $M$, namely $\bar G$, is constant. See **Balder (1988)**
> attached.

---

## Part 2 — Phil's email suggestion (Lusin regularization to lift the restriction on player 2)

*Verbatim from `phil's suggestion.txt`, with light notation cleanup.*

> Hi Piotr:
>
> Let $\sigma^*$ be the optimal strategy for player 1 from the notes I sent.
> Perhaps there is a way to extend the argument to show that $\sigma^*$
> guarantees the value for player 1 even if we lift the restriction on
> player 2's strategies. The argument is roughly as follows.
>
> By **Lusin's theorem** there is an increasing sequence of compact subsets
> $S_1, S_2, \ldots$ of $S$ whose union $S^*$ has measure 1 for each
> $G(\cdot \mid \omega)$, such that $\sigma(\cdot \mid s)$ is continuous on
> $S_n$ for every $n$.
>
> We can now modify $\sigma^*$ so that for messages outside $S^*$ it behaves
> as if the message was some fixed element of $S^*$.
>
> Suppose by way of contradiction that there is a measurable map $d: S \to S$
> that player 2 can use to send the message $d(s)$ when she observes $s$ that
> yields player 1 a payoff less than the value. Then $d(\cdot)$ would have to
> send messages outside $S^*$ with probability one. This is because if a
> message inside $S^*$ were a profitable deviation for player 2, then that
> message would be in $S_n$ for some $n$. Moreover, since we can construct the
> sequence $S_1, S_2, \ldots$ such that any open set around any point in any
> $S_k$ has positive $G(\cdot \mid \omega)$ probability for every $\omega$
> when intersected with $S_k$, the continuity of $\sigma^*$ on $S_n$ implies
> that there is a measurable map that player 2 could have used to push 1's
> payoff below the value. But that is not possible by the definition of
> $\sigma^*$.
>
> If correct, this establishes the existence of an optimal strategy for
> player 1, **but not for player 2**. Lots of details to check here. So the
> probability of an error is non-trivial. — Phil.

---

## Part 3 — Précis of attached references (technical hammers)

### Balder (1988) — *Generalized Equilibrium Results for Games with Incomplete Information*, Math. of Op. Res. 13(2), 265–276

**What we need from it (the constant-marginal trick):** Balder develops a
theory of weak convergence of *transition probabilities* (Markov kernels)
that works **without topological assumptions on the type space** and
**without continuity in the type variable of the integrand**. The crucial
clause for Phil's argument: if $\sigma_n \to \sigma$ in the sense that
$\sigma_n G(\cdot\mid\omega)$ weak\* converges to $\sigma G(\cdot\mid\omega)$
for each $\omega$, then for any **bounded measurable** integrand $h(a,\omega,m)$
that is continuous in $a$,

$$
\int h\,(\sigma_n G)(da, dm \mid \omega) \;\longrightarrow\; \int h\,(\sigma G)(da, dm \mid \omega),
$$

provided the marginal on $m$ stays *fixed* (this is the constant-marginal
hypothesis — here it's $\bar G$, by construction). Continuity in the bad
variable $m$ is *not* required. This is exactly what Phil needs to declare
$U(\sigma, f)$ continuous in $\sigma$ on the restricted-strategy game.

The full text is available as a durable reference. Key sections: §2 (weak
convergence of transition probabilities), §3 (the product weak topology and
its compactness), and §4 (an application to the Milgrom–Weber existence
theorem). The constant-marginal lemma we want is Theorem 2.5 / Proposition 2.6
type results.

### Mertens (1986) — *The Minmax Theorem for U.S.C.-L.S.C. Payoff Functions*, IJGT 15(4), 237–250

**What we need from it (the asymmetric minmax):** Section 2 Corollary B (page 238):

> Let $T$ be an arbitrary set, $f(s,t)$ u.s.c. on $S$ for each $t \in T$. Then
>
> $$ \max_\sigma \inf_\tau f(\sigma, \tau) \;=\; \inf_\tau \max_\sigma f(\sigma, \tau), $$
>
> where $\sigma$ ranges over all regular Borel probabilities on $S$ and $\tau$
> over all probabilities with finite support on $T$.

The asymmetric structure is the point. We need only:
- compactness of $S$ (here: $\Sigma$, in the topology of Phil's note);
- u.s.c. of $f$ in $\sigma$ for each fixed $\tau$ (here: continuity of
  $U(\sigma, f)$ in $\sigma$ for each fixed $f \in F$, which is stronger
  than u.s.c.);
- no topological assumption on $T$ (here: $F$, the convex set of measurable
  $f(m\mid s)$);
- finite support on $T$ for one of the conclusions, but a regular Borel
  probability on $S$ for the other.

We do *not* need joint continuity, separation, or any topology on $F$. This
is the asymmetric minmax theorem that bypasses the prior attempts'
adversary-side-attainment rock.

The full text is available as a durable reference.

---

## Part 4 — Editorial summary (orchestrator)

- **Two-stage strategy.** (1) Prove existence of $\sigma^*$ that secures the
  value *against player-2 strategies in $F$* (the convex
  absolutely-continuous-against-$\bar G$ set) using Mertens (1986)
  Corollary B + Balder (1988) constant-marginal continuity. (2) Lift the
  restriction on player 2 to all measurable kernels via Lusin regularization
  of $\sigma^*$.
- **Lusin-regularization mechanics.** The increasing compacts $S_n$ are chosen
  $\sigma^*$-continuous AND **support-thick** (every open neighborhood of any
  point in $S_k$ has positive $G(\cdot\mid\omega)$ measure when intersected
  with $S_k$). This thickness is what lets us turn a measurable deviation $d$
  into a continuous deviation, contradicting $\sigma^*$'s optimality on the
  restricted game.
- **What this delivers.** Existence of an optimal $\sigma^*$ for player 1.
  This is the existence-of-an-optimal-strategy half of Theorem 2.
- **What this does NOT yet deliver.** An adversarial $\beta^*$ for player 2,
  AND the per-message Bayes-optimality at each on-path $m$ (Definition 2 in
  the paper). Closing those is the explicit task on top of Phil's sketch.
- **Reintroducing the type $\theta$.** Phil's note dropped the agent's private
  type to keep things compact. Translating back to the paper's full
  framework — agent strategies $\sigma: M\times\Theta\to\Delta(A)$, payoff
  $u(a,\omega,\theta)$ — needs care; the natural move is to absorb $\Theta$
  into the agent's choice as a measurable family of message-conditional
  private strategies $\hat\sigma(m): \Theta\to\Delta(A)$, exactly as the paper
  does, and then check that Balder's continuity statement still holds with
  $\Theta$ in the picture (it should, because Balder's machinery works with
  arbitrary type spaces).
- **Translating back to paper notation.** Phil's $S \leftrightarrow$ paper's
  $M = \operatorname{supp}(\tau)$, with $G(\cdot\mid\omega)$ ↔ the paper's
  signal kernel; Phil's $\bar G \leftrightarrow$ the paper's $\tau$ (the
  unconditional posterior distribution); Phil's $f(m\mid s)$ ↔ the
  Radon-Nikodym density of $\beta(\cdot\mid s)$ vs $\tau$, when it exists.
