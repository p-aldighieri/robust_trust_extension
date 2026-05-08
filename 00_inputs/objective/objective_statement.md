# Objective Statement: Parsing Theorem 2 in *Robust Trust* (Dworczak & Smolin, 2026)

This note is a working “claim-parsing + dependency map” for **Theorem 2 (Robustly Rationalizable Solution)** in *Robust Trust* by Piotr Dworczak and Alex Smolin (February 9, 2026). It is meant to prepare a proof of Theorem 2 **without** assuming that the adviser-belief support \(M\) and the agent type space \(\Theta\) are finite.

Primary source: the paper PDF in this workspace. Citations refer to the uploaded PDF text: **Theorem 2, Definition 2, and Appendix A.2**. 【15†Robust_trust_Dworczak_Smolin.pdf】

---

## 0. Where Theorem 2 sits in the paper

- **Section 3.3 (“Robust Rationalizability”)** introduces a *zero-sum equilibrium / saddle point* perspective on the agent’s max–min problem and defines **robustly rationalizable strategies**. 【15†Robust_trust_Dworczak_Smolin.pdf】
- **Theorem 2** then states:
  1) robustly rationalizable \(\Rightarrow\) optimal; and
  2) existence of a robustly rationalizable strategy under **finite \(M\) and finite \(\Theta\)**. 【15†Robust_trust_Dworczak_Smolin.pdf】
- Theorem 2 is conceptually complementary to **Theorem 1 (Trust Region Solution)**, which characterizes optimal strategies as (equivalent to) trust region strategies; combining them yields the “TRE” (trust region equilibrium) interpretation. 【15†Robust_trust_Dworczak_Smolin.pdf】

---

## 1. The claim (plain language)

Theorem 2 formalizes the idea that **optimal robust behavior does not require commitment**:

- If the agent’s strategy can be justified ex post as a *myopic best response* to some **adversarial** misaligned adviser strategy \(\beta^*\) (i.e., after every on-path message, the agent is choosing an action optimal for the Bayesian posterior induced by \(\beta^*\)), then that agent strategy is already **globally optimal** for the original max–min problem.

- Under finiteness of \(M\) and \(\Theta\), such a “self-confirming” strategy exists.

This is exactly the “saddle point / minimax theorem” bridge in the paper. 【15†Robust_trust_Dworczak_Smolin.pdf】

---

## 2. Restating Theorem 2 precisely (quantifiers)

### 2.1 Fixed primitives

Fix a model with:

- finite state space \(\Omega\) with \(|\Omega| = N\) and full-support prior \(\mu_0 \in \Delta(\Omega)\);
- adviser posteriors \(s\in \Delta(\Omega)\) distributed according to \(\tau\) with support \(M := \operatorname{supp}(\tau)\);
- compact metric action set \(A\);
- compact metric type space \(\Theta\);
- bounded utility \(u(a,\omega,\theta)\), continuous in \(a\);
- conditional independence of \(s\) and \(\theta\) given \(\omega\);
- alignment probability \(\alpha \in [0,1]\).

All measurability conventions are as in the paper (Borel \(\sigma\)-algebras; “for all” interpreted as “almost all” where needed). 【15†Robust_trust_Dworczak_Smolin.pdf】

### 2.2 Strategy sets

- Agent strategies:
  \[
  \Sigma := \{\sigma: \Delta(\Omega)\times \Theta \to \Delta(A) \;\text{measurable}\}.
  \]

- Misaligned adviser strategies:
  \[
  B := \{\beta: M \to \Delta(\Delta(\Omega)) \;\text{measurable}\}.
  \]
  (The paper notes wlog that misaligned strategies need only send messages in \(M\).) 【15†Robust_trust_Dworczak_Smolin.pdf】

### 2.3 Robust objective

Given \(\sigma\in \Sigma\), define
\[
U(\sigma) := \alpha\, \mathbb{E}_{\mathrm{id},\sigma}[u(a,\omega,\theta)] 
\;+
(1-\alpha)\, \inf_{\beta\in B} \mathbb{E}_{\beta,\sigma}[u(a,\omega,\theta)].
\]
Define the optimal value
\[
U^* := \sup_{\sigma\in\Sigma} U(\sigma).
\]
These are equations (1)–(2). 【15†Robust_trust_Dworczak_Smolin.pdf】

### 2.4 “Adversarial” strategies

For fixed \(\sigma\), call \(\beta^*\in B\) **adversarial against \(\sigma\)** if it attains the infimum:
\[
\beta^* \in \arg\min_{\beta\in B} \mathbb{E}_{\beta,\sigma}[u(a,\omega,\theta)].
\]
(Defined in Section 2, after equation (1).) 【15†Robust_trust_Dworczak_Smolin.pdf】

### 2.5 Posteriors induced by a misaligned strategy

For any \(\beta\in B\), let \(P_\beta(\cdot\mid m)\) denote the agent’s **Bayesian posterior over states \(\Omega\)** after observing message \(m\), induced by the mixture of:
- aligned adviser reporting truthfully w.p. \(\alpha\);
- misaligned adviser using \(\beta\) w.p. \(1-\alpha\).

(Defined just before Definition 2.) 【15†Robust_trust_Dworczak_Smolin.pdf】

### 2.6 Robustly rationalizable strategy (Definition 2)

Write the agent strategy as a message-indexed family of private strategies \(\sigma \sim (\hat\sigma(m))_{m\in\Delta(\Omega)}\), where each
\(
\hat\sigma(m): \Theta \to \Delta(A)
\)
maps types to (mixed) actions.

A strategy \(\sigma\in\Sigma\) is **robustly rationalizable** if
\[
\exists\, \beta^*\in B \text{ adversarial against } \sigma \text{ such that }
\forall m\in M,\quad 
\hat\sigma(m) \in \arg\max_{\hat\sigma'}\; U(\hat\sigma',\, P_{\beta^*}(\cdot\mid m)).
\]
This is Definition 2. 【15†Robust_trust_Dworczak_Smolin.pdf】

### 2.7 Theorem 2 (formal statement)

**Theorem 2 (Robustly Rationalizable Solution).** 【15†Robust_trust_Dworczak_Smolin.pdf】

1) **Optimality direction.**
\[
\forall \sigma\in\Sigma,\quad \big(\sigma \text{ is robustly rationalizable}\big)\;\Rightarrow\; \big(U(\sigma)=U^*\big).
\]

2) **Existence direction (as stated in the paper).** If \(M\) and \(\Theta\) are finite, then
\[
\exists\, \sigma\in\Sigma \text{ such that } \sigma \text{ is robustly rationalizable}.
\]

---

## 3. GIVEN assumptions (only what’s explicitly in the paper at this point)

### Baseline assumptions (Section 2)

- \(\Omega\) is finite, \(\mu_0\) has full support.
- \(A\) and \(\Theta\) are compact metric sets.
- \(u\) is bounded and continuous in \(a\).
- \(s\) and \(\theta\) are conditionally independent given \(\omega\).
- Infinite spaces are endowed with Borel \(\sigma\)-algebras and all objects are measurable.

These are the model’s standing assumptions. 【15†Robust_trust_Dworczak_Smolin.pdf】

### Additional assumption for the existence part of Theorem 2 (paper version)

- \(M\) and \(\Theta\) are finite.

The paper states this explicitly as a technical condition for existence. 【15†Robust_trust_Dworczak_Smolin.pdf】

---

## 4. Notation / symbol table (minimal set for Theorem 2)

### Objects

- \(\Omega\): finite states.
- \(\mu_0\): prior.
- \(s\): adviser posterior.
- \(\tau\): distribution of adviser posteriors.
- \(M\): support of \(\tau\).
- \(\Theta\): agent type.
- \(A\): action space.
- \(u(a,\omega,\theta)\): payoff.
- \(\alpha\): alignment probability.

### Strategies

- \(\sigma(m,\theta) \in \Delta(A)\): agent action distribution after message \(m\) and type \(\theta\).
- \(\hat\sigma(m): \Theta\to\Delta(A)\): private strategy induced by message \(m\).
- \(\Sigma\): set of measurable agent strategies.
- \(\mathrm{id}:M\to M\): truthful report rule for aligned adviser.
- \(\beta: M \to \Delta(\Delta(\Omega))\): misaligned adviser rule.
- \(B\): set of measurable misaligned strategies.

### Payoffs and posteriors

- \(U(\hat\sigma,\mu)\): expected payoff of private strategy \(\hat\sigma\) under belief \(\mu\).
- \(U(\sigma)\): robust payoff for full strategy \(\sigma\).
- \(U^*\): robust value.
- \(P_\beta(\cdot\mid m)\): posterior over \(\Omega\) given message \(m\) under \(\beta\).

---

## 5. What Theorem 2 is “building on” (dependency map)

### 5.1 The robust objective is a zero-sum game

The agent chooses \(\sigma\) to maximize a mixture of (i) aligned-truthful payoff and (ii) worst-case payoff against \(\beta\). This induces a natural two-player zero-sum structure:
- Player 1 (agent): \(\max_\sigma\)
- Player 2 (misaligned adviser): \(\min_\beta\)

The aligned part adds a fixed truthful component. 【15†Robust_trust_Dworczak_Smolin.pdf】

### 5.2 The decomposition into “message \(\to\) private strategy” and Bayes posteriors

Robust rationalizability is phrased as: after each on-path \(m\in M\), the agent chooses a private strategy \(\hat\sigma(m)\) that is Bayes-optimal under the posterior \(P_{\beta^*}(\cdot\mid m)\). This uses the definition of \(U(\hat\sigma,\mu)\) and Bayes-optimality. 【15†Robust_trust_Dworczak_Smolin.pdf】

### 5.3 Existence (paper proof) relies on a minimax theorem and finiteness

In Appendix A.2, the paper proves existence (for finite \(M\), finite \(\Theta\)) by:
- writing the payoff \(U(\beta,\sigma)\) explicitly as a finite sum;
- noting \(B\) and \(\Sigma\) are convex and compact (products of simplices);
- verifying continuity in each argument;
- applying Sion’s minimax theorem to obtain a saddle point \((\beta^*,\sigma^*)\);
- concluding \(\sigma^*\) is robustly rationalizable. 【15†Robust_trust_Dworczak_Smolin.pdf】

Crucially, the paper explicitly notes that extending Sion’s conditions to infinite-dimensional cheap-talk-like strategy spaces is technically difficult because messages affect payoffs endogenously. 【15†Robust_trust_Dworczak_Smolin.pdf】

### 5.4 How it interfaces with Theorem 1

- Theorem 1 says: **any optimal strategy is equivalent to a trust region strategy (TRS)** with a connected trust region.
- Theorem 2 says: **some optimal strategy is robustly rationalizable** (under finiteness as stated).
- Together: one can talk about a **trust region equilibrium (TRE)**: a TRS \(\sigma^*\) paired with an adversarial \(\beta^*\) that makes \(\sigma^*\) myopically optimal after each on-path message. 【15†Robust_trust_Dworczak_Smolin.pdf】

---

## 6. Literature context (why Theorem 2 is a natural move)

Theorem 2 is essentially a **minimax / saddle-point implementation** result. It situates the paper alongside:

- **Cheap talk** (Crawford–Sobel): here, sender is “aligned” w.p. \(\alpha\) and “adversarial” otherwise, which changes equilibrium structure drastically. 【15†Robust_trust_Dworczak_Smolin.pdf】

- **Bayesian persuasion** (Kamenica–Gentzkow): via minimax, the paper interprets the adversary as choosing a Bayes-plausible distribution subject to partial-truthfulness constraints. Theorem 2 is the bridge that legitimizes that persuasion-like interpretation. 【15†Robust_trust_Dworczak_Smolin.pdf】

- **Robust persuasion / alpha-maxmin** (Hurwicz; Dworczak–Pavan): Theorem 2 is the technical device that turns a robust objective into a certifiable equilibrium-like object. 【15†Robust_trust_Dworczak_Smolin.pdf】

- **Delegation under uncertainty about advisor preferences** (Frankel 2014): Theorem 2 plays an analogous “can implement without commitment” role, but under very different primitives (adversarial behavior rather than preference uncertainty sets). 【15†Robust_trust_Dworczak_Smolin.pdf】

- **AI alignment / human-AI interaction models**: Theorem 2 backs the interpretation “robust optimal behavior is a stable response to some plausible misalignment conjecture,” hence actionable without commitment devices. 【15†Robust_trust_Dworczak_Smolin.pdf】

---

## 7. Notes for the planned generalization (no finiteness of \(M\) or \(\Theta\))

This section is **not a proof** and adds **no assumptions**. It simply flags where finiteness enters and what would need to be replaced.

### 7.1 What finiteness buys in Appendix A.2

The paper’s existence proof uses finiteness to make:

1) **strategy spaces compact** in a straightforward way (products of finite-dimensional simplices);
2) the payoff \(U(\beta,\sigma)\) **jointly well-behaved** (finite sums; immediate continuity);
3) standard minimax machinery (Sion 1958) directly applicable. 【15†Robust_trust_Dworczak_Smolin.pdf】

### 7.2 What will likely be needed (flagged as “Needed assumptions” candidates)

To extend existence to infinite \(M\), \(\Theta\), one generally needs some combination of:

- **(Needed assumption candidate)** A topology on \(\Sigma\) and \(B\) under which they are compact (often weak or weak-*), plus metrizability or tightness.

- **(Needed assumption candidate)** Continuity (or semicontinuity) of the payoff map \((\beta,\sigma)\mapsto U(\beta,\sigma)\) in the chosen topologies.

- **(Needed assumption candidate)** Existence of minimizers \(\beta^*\) against \(\sigma\) and maximizers \(\sigma^*\) against \(\beta\), or an argument that the saddle point exists without pointwise attainment.

- **(Needed assumption candidate)** Measurable selection / purification steps to ensure the agent’s “myopic best response after each message” is measurable in \(m\).

These are the typical pain points for infinite-dimensional cheap-talk-like games, and the paper explicitly flags continuity difficulties in that setting. 【15†Robust_trust_Dworczak_Smolin.pdf】

### 7.3 What parts of Theorem 2 are “easy” vs “hard” under general spaces

- The **optimality direction** (robustly rationalizable \(\Rightarrow\) optimal) is essentially “saddle point \(\Rightarrow\) max–min optimal,” and is comparatively structure-light.

- The **existence direction** is the hard part: we need to produce a \((\sigma^*,\beta^*)\) that behaves like a saddle point, or otherwise show there exists \(\sigma\) and adversarial \(\beta^*\) with the robust rationalizability property.

---

## 8. Checklist for “understanding the claim” before proving it

1) Confirm exactly which objects are endogenous in Theorem 2:
   - \(P_{\beta^*}(\cdot\mid m)\) is endogenous to \(\beta^*\) (and \(\alpha,\tau\)).

2) Separate the two directions:
   - robust rationalizable \(\Rightarrow\) optimal (a verification lemma from a saddle-point inequality);
   - existence (construct or prove existence of a saddle point).

3) Track where “on-path” enters:
   - The definition requires best-response property for all \(m\in M\). (This is the support of the aligned adviser’s truthful messages.) 【15†Robust_trust_Dworczak_Smolin.pdf】

4) Keep in view the intended interpretation:
   - Theorem 2 is used as a **certification tool**: exhibit an adversarial \(\beta^*\) and verify myopic optimality at each message. 【15†Robust_trust_Dworczak_Smolin.pdf】

---

## 9. Immediate next step (for the proof project)

To pursue the “no finiteness” extension cleanly, it will help to rewrite Theorem 2’s existence direction as:

> Find conditions under which the zero-sum game \(\sup_{\sigma\in\Sigma}\inf_{\beta\in B} U(\beta,\sigma)\) admits a saddle point \((\sigma^*,\beta^*)\), and such that \(\sigma^*\) can be selected to satisfy the per-message Bayes-optimality condition in Definition 2.

This reframing isolates exactly what must be replaced when \(\Sigma\) and \(B\) are infinite-dimensional.

