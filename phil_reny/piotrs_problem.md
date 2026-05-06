# Piotr's problem note (sent to Phil Reny)

*Reconstructed from `piotrs problem.pdf`. Math symbols recovered from page image; prose verbatim.*

---

Here is a partial result that might be useful. First, let me suppose that the
signal $\theta$ is not present. Also, let me think of this as a two-person
zero-sum game where player 1 chooses a transition probability $\sigma(da \mid s)$,
player 2 chooses a transition probability $\pi(dm \mid s)$, and player 1's payoff is

$$
\sum_{\omega} \mu_0(\omega)\!\left(\alpha \int_{A \times S} u(a,\omega)\, \sigma(da \mid s)\, G(ds \mid \omega) \;+\; (1-\alpha) \int_{A \times M \times S} u(a,\omega)\, \sigma(da \mid m)\, \pi(dm \mid s)\, G(ds \mid \omega)\right).
$$

Assume that $M = S$ and restrict player 2 to strategies $\pi(dm \mid s)$ of the
form $f(m \mid s)\, \bar G(dm)$, where $\bar G := \sum_{\omega} \mu_0(\omega) G(\cdot \mid \omega)$.
Thus, I am restricting player 2 to strategies that, for each observed $s$, are
absolutely continuous with respect to $\bar G$. I'm guessing that an equilibrium
of this form, if it could be shown to exist, would be an equilibrium. The
remainder of this note hinges on this guess.

Thus, player 2's (restricted) pure strategy set is the convex set of jointly
measurable functions $f(m \mid s)$ on $S \times S$. Denote this set by $F$. We can
write 1's payoff as

$$
\sum_{\omega} \mu_0(\omega)\!\left(\alpha \int_{A \times S} u(a,\omega)\, \sigma(da \mid s)\, G(ds \mid \omega) \;+\; (1-\alpha) \int_{A \times M} u(a,\omega) \!\left(\int_S f(m \mid s)\, G(ds \mid \omega)\right) \sigma(da \mid m)\, \bar G(dm)\right).
$$

This function is continuous in $\sigma$ for each $f \in F$ when we endow 1's
strategy space $\Sigma$ with the topology in which $\sigma_n \to \sigma$ iff
$\sigma_n G(\cdot \mid \omega)$ weak\* converges to $\sigma G(\cdot \mid \omega)$
for each $\omega$ (and so also $\sigma_n \bar G$ weak\* converges to $\sigma \bar G$).
Moreover $\Sigma$ is compact under this topology.

Hence, since $F$ is convex, **Mertens (1986, p. 238 Corollary (B))** implies that

$$
\max_{\sigma \in \Sigma} \inf_{f \in F} U(\sigma, f) \;=\; \inf_{f \in F} \max_{\sigma \in \Sigma} U(\sigma, f).
$$

This is what I am able to say for now. Perhaps it will be helpful to you.

— Phil.

---

**Footnote (verbatim):** Note that continuity in this topology holds even though
the second integral has an integrand that is only measurable (and so perhaps
discontinuous in $m$). Continuity nonetheless follows since the marginal of
$\sigma_n \bar G$ on $M$, namely $\bar G$, is constant. See **Balder (1988)** attached.
