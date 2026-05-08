# Final proof state: summary for a math major

This note explains the final state of the infinite-\(M\), infinite-\(\Theta\)
extension project in non-specialist terms. It is not a proof and not a
chronicle of the runs. It is meant to answer: what is the idea, what has
actually been proved, and where does the remaining gap live?

## 1. The original question

In *Robust Trust*, Theorem 2 says two things.

First, if an agent's strategy is **robustly rationalizable**, then it is
optimal for the robust max-min problem. This direction is not the hard part.
It is basically a verification argument.

Second, when the adviser-belief support \(M\) and the private-type space
\(\Theta\) are finite, a robustly rationalizable strategy exists. In the
finite case, the proof uses a finite-dimensional zero-sum game and Sion's
minimax theorem.

The project asked whether the existence direction survives when \(M\) and
\(\Theta\) are not finite, while keeping the paper's standing assumptions:
\(\Omega\) finite, full-support prior, compact metric action and type spaces,
bounded payoff continuous in the action, conditional independence of the
adviser signal and the private type, and Borel measurability.

The hard part is not just finding an optimal strategy. The hard part is
finding an optimal strategy together with a worst-case adviser strategy that
makes the agent's behavior look myopically Bayes-optimal after the messages
that are actually observed.

## 2. What robust rationalizability asks for

The agent chooses a strategy \(\sigma\), mapping messages and private types
to actions. The misaligned adviser chooses a kernel \(\beta\), mapping the
true adviser belief \(s\) to a possibly different reported message \(m\).

Robust rationalizability asks for a pair \((\sigma^*,\beta^*)\) with two
properties:

1. \(\beta^*\) is truly adversarial against \(\sigma^*\): it attains the
   worst-case payoff for the agent.

2. After every on-path message \(m\), the continuation strategy
   \(\hat\sigma^*(m)\) is Bayes-optimal for the posterior induced by
   \(\beta^*\).

In finite spaces, "every on-path message" is unambiguous. In infinite spaces,
conditional posteriors are defined only almost surely. The natural measure is
the actual mixture message marginal
\[
q_{\beta^*}=\alpha\tau+(1-\alpha)\int_M \beta^*(\cdot\mid s)\tau(ds).
\]
So the infinite-space reading is \(q_{\beta^*}\)-almost everywhere. This is
important because \(\beta^*\) may put mass on messages that have zero
\(\tau\)-probability but positive \(q_{\beta^*}\)-probability.

## 3. The main idea: reduce strategies to payoff profiles

The final approach avoids trying to compactify the whole strategy space.
Instead, it uses the fact that the state space \(\Omega\) is finite.

Fix a private strategy: a rule telling the agent what to do as a function of
her private type. From the outside, what matters about this private strategy
is its vector of expected payoffs, one coordinate for each state:
\[
w(\omega)=\mathbb E[u(a,\omega,\theta)\mid \omega].
\]
The set of all such payoff vectors is a compact convex set
\[
W\subseteq \mathbb R^{|\Omega|}.
\]

Thus a message-contingent agent strategy can be summarized by a measurable
labeling
\[
w:M\to W.
\]
When message \(m\) is reported, the agent uses the private strategy whose
payoff profile is \(w(m)\).

The key object is the **menu**
\[
C=\overline{w(M)}\subseteq W.
\]
The aligned adviser reports truthfully, so at belief \(s\) the agent wants a
profile in the menu with large \(s\cdot w\). The misaligned adviser chooses a
message, so for the worst-case part the relevant number is the smallest
\(s\cdot w\) available in the menu.

This turns the agent's problem into optimizing the finite-dimensional
functional
\[
F(C)=\int_M\left[\alpha\max_{w\in C}s\cdot w
 +(1-\alpha)\min_{w\in C}s\cdot w\right]\tau(ds)
\]
over compact subsets \(C\) of the compact set \(W\).

This is the main simplification: instead of proving compactness of an
infinite-dimensional strategy game, we optimize over compact menus in a
finite-dimensional payoff-profile space.

## 4. What the final theorem proves

The final theorem has three tiers.

### Tier 1a: unconditional value optimality and approximate adversaries

Under the paper's standing hypotheses alone, there exists an agent strategy
\(\sigma^*\) with
\[
U(\sigma^*)=U^*.
\]
Moreover, for every \(\varepsilon>0\), there is an adversary
\(\beta_\varepsilon\) whose payoff against \(\sigma^*\) is within
\(\varepsilon\) of the true worst case.

This is the clean unconditional part. It says that the infinite problem has a
value-optimal agent strategy, and the adversary can get arbitrarily close to
the worst case.

### Tier 1b: exact adversary under exact-contact

To get an exact worst-case adviser \(\beta^*\), one needs an attainment
condition.

For each source belief \(s\), the adversary wants a message whose label
minimizes \(s\cdot w^*(m)\). The compact menu always contains minimizers, but
the labeling \(w^*:M\to W\) might not actually hit the minimizing payoff
profile at any message. It may only approach it in the closure.

The **exact-contact** condition says that for \(\tau\)-almost every \(s\),
there is a measurable choice of a message \(m^*(s)\) such that
\[
s\cdot w^*(m^*(s))=\min_{z\in C^\dagger}s\cdot z,
\qquad C^\dagger=\overline{w^*(M)}.
\]
Under exact-contact, the deterministic kernel
\(\beta^*(\cdot\mid s)=\delta_{m^*(s)}\) is an exact worst-case adviser.

### Tier 2: robust rationalizability under menu-Hall

Exact adversary attainment is still not enough for robust rationalizability.
The agent also needs to be Bayes-optimal after the messages induced by the
adversary.

The **menu-Hall** condition is the calibration condition that makes this
happen. It asks for a kernel \(\kappa(\cdot\mid s)\), supported on rowwise
minimizing messages, such that the posterior induced at each received
message lies in the Bayes-optimality cone for the continuation strategy used
at that message.

In plain language:

- source by source, the adversary must send the agent to worst-case messages;
- message by message, the average source beliefs arriving at that message
  must justify the action the agent takes there.

Under exact-contact plus menu-Hall, the pair is robustly rationalizable in
the \(q_\beta\)-almost-everywhere sense.

## 5. Why menu-Hall is a real condition

It is tempting to hope that once the adversary can choose worst-case messages,
the Bayes-optimality condition will automatically follow. The project shows
that this is not true inside the menu engine.

The obstruction is easiest to see in a three-state winner-takes-all example.
For a message label with support \(I\), there are two cones:

- a **source cone** \(K_I^-\), saying which source beliefs make that label
  rowwise worst for the agent;
- a **Bayes cone** \(B_I\), saying which posterior beliefs make that label
  optimal for the agent.

The cone-intersection lemma says: if a probability measure is supported on
the source cone \(K_I^-\) and its barycenter lies in the Bayes cone \(B_I\),
then the measure must collapse to the uniform prior. With atomless \(\tau\),
there is no positive mass sitting exactly there.

This rules out a common attempted repair: sending adversarial mass to
\(\tau\)-null "dust" messages. Even if the adversary is allowed to use such
messages, the no-free-dust theorem says they cannot repair the Bayes
calibration problem in the ternary witness.

The important qualification is that this witness is a **menu-engine**
obstruction, not a primitive counterexample to the unrestricted Theorem 2.
The particular trust region used to display the obstruction induces the full
winner-takes-all vertex menu, so it is behaviorally equivalent to the full
simplex in that example.

## 6. The remaining gap

The final result is not a proof of unrestricted infinite Theorem 2. The
remaining gap is exactly the gap between:

- having a value-optimal menu and worst-case messages; and
- having a worst-case message kernel whose induced posteriors justify the
  agent's continuations message by message.

The missing theorem would be a **deletion-compatible Hall duality theorem**.
It would explain when sourcewise optimality of a menu forces messagewise
Bayes calibration.

The difficulty is that the two sides of the problem are indexed differently.

The value calculation is sourcewise: for each source belief \(s\), deleting
or keeping labels changes the minimum \(\min_{w\in C}s\cdot w\).

The rationalizability condition is messagewise: for each received message
\(m\), the conditional average of the sources routed to \(m\) must lie in a
Bayes cone.

The attempted routes all run into the same three obstacles:

1. **Borel-to-compact mismatch.** A Borel set of messages can have positive
   measure but deleting it may not shrink the compact closure of the label
   image.

2. **Label-fiber lift.** A finite or aggregate flow between cells need not
   lift to a genuine Borel kernel supported on the exact rowwise minimizer
   relation.

3. **Lack of uniform slack.** A sequence of proper compact deletions can
   converge back to the original menu while their values converge up to the
   optimum, so pointwise strictness is not enough for an approximate
   contradiction.

## 7. Takeaway

The final approach proves a genuine infinite-dimensional extension, but in a
three-tier form:

- value optimality and approximate adversaries are unconditional;
- exact adversaries require exact-contact;
- full robust rationalizability requires menu-Hall.

The conceptual advance is that most of the infinite-dimensional strategy
problem collapses to compact finite-dimensional menu geometry. The remaining
hard part is not compactness of strategies. It is the calibration problem:
turning sourcewise worst-case routing into messagewise Bayesian
rationalizability.

