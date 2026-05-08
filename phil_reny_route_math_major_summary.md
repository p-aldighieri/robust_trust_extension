# Phil Reny route: summary for a math major

This note explains the earlier proof route based on Phil Reny's suggestion.
It is meant to be read separately from the final menu-engine summary. The
point is not to record the sequence of runs, but to explain the idea, why it
was promising, what it achieved conditionally, and where it stalled.

## 1. The motivation

The original finite proof of Theorem 2 uses a zero-sum game between the agent
and the misaligned adviser. In finite spaces, the agent and adviser strategy
sets are products of compact simplices. Sion's minimax theorem gives a saddle
point, and that saddle point gives robust rationalizability.

In infinite \(M\), this direct route breaks. The adviser can choose arbitrary
measurable kernels \(\beta:M\to\Delta(M)\), and the agent can choose
measurable kernels \(\sigma:M\times\Theta\to\Delta(A)\). These spaces are too
large for the finite proof to carry over directly. Continuity in the adviser
kernel is especially problematic because messages affect the agent's
continuation payoff endogenously.

Phil Reny's suggestion was to split the problem into two stages:

1. First prove the existence of an optimal agent strategy by restricting the
   adversary to a more regular class of kernels.

2. Then try to lift the result back to the full class of measurable
   adversaries.

This was a serious route because it targeted the main compactness problem
directly, rather than trying to force the whole infinite adviser space to be
compact.

## 2. Stage 1: restrict the adversary

The first move was to restrict the misaligned adviser to kernels that are
absolutely continuous with respect to \(\tau\):
\[
\beta_\varphi(dm\mid s)=\varphi(m\mid s)\tau(dm).
\]
Here \(\varphi\) is a jointly measurable density, normalized in \(m\) for
each source belief \(s\).

Why does this help?

Because after this restriction, the reported-message variable \(m\) is
integrated against a fixed base measure \(\tau(dm)\). This fixed marginal is
what makes the agent side manageable. One can use Balder's weak topology for
transition probabilities: roughly, a sequence of agent kernels converges if
the induced joint laws over messages, private types, and actions converge in
the right stable sense.

The important technical facts are:

- the agent strategy space is compact in this Balder topology, after the
  usual identification of strategies that agree almost everywhere;
- for each fixed restricted adviser density \(\varphi\), the payoff is
  continuous in the agent strategy;
- the restricted adviser class is convex.

Mertens's asymmetric minimax theorem then gives a maximizer
\(\sigma^*\) for the restricted game:
\[
\max_\sigma\inf_\varphi U_F(\sigma,\varphi).
\]

At this point, we have a strong candidate agent strategy, but only for the
restricted game where the adviser must use \(\tau\)-dominated kernels.

## 3. Stage 2: Lusin lift to unrestricted adversaries

The next step was to show that the same \(\sigma^*\) also works against
arbitrary measurable adviser kernels \(\beta\).

The idea uses Lusin's theorem. A measurable function need not be continuous
everywhere, but it is continuous on large compact sets. The agent's strategy,
as a function of the message, can be represented as continuous on an
increasing sequence of compact sets
\[
K_1\subseteq K_2\subseteq\cdots,\qquad K^*=\bigcup_n K_n,
\]
with full measure.

If these compact sets are also **thick** for all the state-conditional laws,
then an arbitrary adversary message can be slightly "smeared" into a nearby
\(\tau\)-dominated distribution without changing the payoff much. In
intuitive terms: if the adviser wants to send a message \(y\), replace that
point message by a small cloud of nearby messages inside the compact set.
Continuity of the payoff on the compact set makes this cloud almost as good
as the original message.

This is the Lusin-lift step. It says that every unrestricted adversary can
be approximated, at \(\sigma^*\), by a restricted \(\tau\)-dominated
adversary. Therefore the restricted-game maximizer also secures the full
robust value.

## 4. The first added condition: Lusin thickness

The Lusin lift needs more than ordinary full measure. It needs the compact
sets \(K_n\) to have enough local mass for every state-conditional signal
law. Otherwise the "small cloud around a message" might have zero mass under
some relevant state.

This led to the condition called **A5-thick**.

In simple terms, A5-thick says that the Lusin compact sets are not just large
measure-theoretically; they are locally visible to all the state-conditional
posterior laws.

Why is some condition like this needed? Consider a perfect-revelation
example with two states. In state 0, the adviser belief is always
\(\delta_0\); in state 1, it is always \(\delta_1\). The two state-conditional
laws live on disjoint points. There is no common locally thick support on
which one can smooth messages in a way visible from every state. The Lusin
smoothing mechanism fails.

So the route proved value optimality only under this extra thickness
condition.

## 5. The second added condition: exact rowwise attainment

Even after finding a value-optimal agent strategy, Theorem 2 needs an actual
worst-case adviser \(\beta^*\), not merely approximations.

For a fixed source belief \(s\), the adviser wants to choose a message \(m\)
that minimizes the agent's payoff. In formulas, one studies a row function
\[
\ell(m,s),
\]
the payoff from sending message \(m\) when the source belief is \(s\).

The problem is that the infimum over \(m\) may not be attained. For example,
a function can have infimum 0 on an interval without ever taking the value 0.
Then the adversary can get arbitrarily close to the worst case, but no exact
minimizing message exists.

This led to **A8c-attain**: for almost every \(s\), the rowwise infimum is
attained at some message, and these minimizing messages can be selected
measurably.

Under A8c-attain, one can define
\[
\beta^*(\cdot\mid s)=\delta_{m^*(s)}
\]
and obtain an exact adversary.

## 6. The third added condition: posterior calibration

Even with an exact worst-case adviser, robust rationalizability still needs
one more property. After a message \(m\), the agent forms a posterior using
Bayes' rule and the conjectured adviser strategy \(\beta^*\). The prescribed
continuation at \(m\) must be optimal for that posterior.

The Phil Reny route produced worst messages source by source. But it did not
automatically ensure that, after grouping all sources that send the same
message \(m\), their conditional average belief lands in the right Bayes
optimality cone for the action prescribed at \(m\).

This is a mass-balance problem. The name used in that version was
**TRE-gen-Hall**.

The analogy with Hall's marriage theorem is useful. We need to match source
beliefs to messages so that:

- each source belief is sent to a worst-case message;
- each message receives a mixture of sources whose average belief justifies
  the agent's continuation at that message.

In one-dimensional or highly symmetric cases, this kind of matching can be
done by monotone or radial transport. In three or more states, it becomes a
vector balancing problem. The Phil Reny route did not derive this matching
from the standing primitives; it had to assume it.

## 7. What the Phil Reny route achieved

The route achieved a conditional theorem.

Under standing assumptions plus A5-thick, the Lusin-lift argument gives a
value-optimal agent strategy.

Adding A8c-attain gives an exact worst-case adviser.

Adding TRE-gen-Hall gives full robust rationalizability.

So the route did not fail because the tools were wrong. It identified a real
path through the infinite-dimensional strategy problem. But it required three
substantive extra assumptions:

- A5-thick, to make the Lusin smoothing work;
- A8c-attain, to turn approximate worst-case messages into exact worst-case
  messages;
- TRE-gen-Hall, to make the induced posteriors justify the agent's
  continuation strategies.

## 8. Why the route stalled

The route stalled because these extra assumptions were not just cosmetic.

First, A5-thick is tied to a representative of an abstract measurable
strategy. It is a condition on how the chosen maximizer behaves on Lusin
compact sets. That makes it less primitive than one would like.

Second, A8c-attain is a genuine attainment assumption. Without regularity,
the adversary's infimum may be approached but not attained.

Third, TRE-gen-Hall is close to the rationalizability conclusion itself. It
is the condition that the worst-case routing also produces Bayes-consistent
posteriors at messages. This is exactly the feature that finite Sion gives
for free but the infinite proof has to recover somehow.

In short, the Phil Reny route solved much of the infinite compactness
problem, but the price was a set of conditions that encoded the hard
remaining pieces.

## 9. How the final menu-engine route changed the picture

The later menu-engine route replaced the infinite-dimensional compactness
problem with a finite-dimensional payoff-profile problem.

This had two major effects.

First, it removed A5-thick entirely from value optimality. The final theorem
gets a value-optimal agent strategy and approximate adversaries under the
paper's standing hypotheses alone.

Second, it replaced A8c-attain by a cleaner **exact-contact** condition. This
is still an attainment condition, but it is stated directly in terms of the
chosen optimal payoff-profile labeling rather than in terms of a Lusin
representative.

For the full robust-rationalizability step, TRE-gen-Hall became
**menu-Hall**. This is a weaker and cleaner set-valued calibration condition:
instead of forcing one deterministic worst-message map, it allows the
adversary to mix over the whole rowwise minimizer correspondence.

The main lesson is that the Phil Reny route was not wasted. It revealed that
the real obstruction is not merely compactness of the agent's strategy space.
The hard part is posterior calibration: arranging the adversary's worst-case
message flow so that the induced message-by-message posteriors make the
agent's continuations Bayes-optimal.

## 10. Takeaway

The Phil Reny route should be understood as a serious but heavier first
approach.

It works by:

1. restricting the adviser to regular, \(\tau\)-dominated kernels;
2. using Balder and Mertens to get a restricted-game maximizer;
3. using Lusin smoothing to lift from restricted adversaries to arbitrary
   measurable adversaries;
4. adding attainment and Hall-type calibration assumptions to recover full
   robust rationalizability.

It stalled because the added assumptions were doing real work. The final
menu-engine approach keeps the valuable lesson but moves the main existence
argument into finite-dimensional payoff-profile geometry, where value
optimality becomes unconditional and the remaining calibration gap is stated
more transparently.

