
========
ROLE: user (id=67e32abb-2e41-4953-8656-70671477435d)
========
# Scoper pass — strength and economic plausibility of the three added assumptions

You are advising on the **scope** of the Theorem 2 conditional extension.
The proof landed (see theorem_2_extension_proof.md) under standing
hypotheses plus three added assumptions:

- **(A5) Common posterior null sets:** $\pi(\cdot\mid\omega)\sim\tau$ for
  every $\omega\in\Omega$.
- **(A8c-lsc) Rowwise lower semicontinuity:** for the Branch-A
  maximizer's value-preserving representative, $m\mapsto\ell_{\sigma^*}(m,s) = \sum_\omega s(\omega)p_\omega(m)$
  is l.s.c. on $M$ for τ-a.e. $s$.
- **(A9c-calib) Calibrated worst-message transport:** existence of a
  posterior-calibrated coupling $\gamma_\alpha$ on $M\times M$ (the
  formal expression that "the paper's TRE/Appendix A.6 quantile
  transport generalizes").

This is **not** a proof pass. It is a **scoping pass**. For each
assumption, I want an honest evaluation of:
1. **Mathematical strength** — what does it require, and is it tight?
2. **Economic interpretation** — what does it mean for the model? In
   what economic settings is it natural vs. restrictive?
3. **Scope of the extension** — which class of models in the
   information-design / cheap-talk / robust-persuasion literature does
   it cover? Which models are excluded?
4. **Compared to the paper's standing assumptions** — is it a "free"
   regularity assumption (free in the sense of being almost always
   true in applications) or a substantive restriction?

Then **rank** the three assumptions from least to most restrictive,
with explicit reasoning.

## Inputs (durable sources)

- theorem_2_extension_proof.md — the landed proof.
- phil_reny_route_memo.md — live route memo with all PROVED statuses
  and counterexamples.
- phil_reny_bundle.md — Phil Reny's contribution.
- prior_attempts_digest.md — what the dead routes were.
- Robust_trust_Dworczak_Smolin.pdf — the paper, especially Sections 3
  (model, Theorem 2), 4 (binary quadratic example, Theorem 1 / TRE),
  and Appendix A.6 (quantile transport).

## What you must produce

A markdown deliverable in the response body, with **exactly** these
sections:


markdown
## 1. (A5) Common posterior null sets

**Statement.** $\pi(\cdot\mid\omega)\sim\tau$ for every $\omega$.

### 1a. Mathematical strength
(How strong is this technically? What's the gap between (A5) and
weaker variants like "$\tau\ll\pi(\cdot\mid\omega)$ for SOME $\omega$"?
Is (A5) tight for L5? Is there a weaker condition that would still
give Lusin-thick compacts?)

### 1b. Economic interpretation
(What does (A5) mean for the signal structure $\pi$? When is it
natural? Specifically:
- (A5) is automatic for any signal structure with strictly positive
  density against a common reference.
- (A5) FAILS for perfect-revelation signals (each $\omega$ produces a
  unique posterior with no overlap with other states).
- (A5) FAILS for partition signals (each posterior is supported on a
  state-dependent subset).
Identify the economic class of signal structures (A5) excludes.)

### 1c. Scope
(Which standard information-design models satisfy/violate (A5)?
Examples:
- Bayesian persuasion (Kamenica-Gentzkow): typically satisfies (A5)
  if the sender's experiment has full-support marginals.
- Strategic info transmission (Crawford-Sobel): partition equilibria
  violate (A5).
- Robust persuasion (Dworczak-Pavan): the uncertainty set may include
  partition-violating signals.
Be honest about which strands are excluded.)

### 1d. Comparison to standing hypotheses
(Is (A5) "free" (almost always true in applications) or "substantive"?)

## 2. (A8c-lsc) Rowwise lower semicontinuity

**Statement.** $m\mapsto\ell_{\sigma^*}(m,s)$ l.s.c. on $M$ for τ-a.e. $s$.

### 2a. Mathematical strength
(How strong is l.s.c. of $\ell_{\sigma^*}$? Is this a property of the
PRIMITIVES — $u$, $f$, $\pi$ — or only of the optimal strategy
$\sigma^*$? Specifically:
- $\ell$ depends on $\sigma^*$ via $p_\omega(m) = \int u\,\sigma^*(da\mid m,\theta)\,f(d\theta\mid\omega)$.
- L.s.c. of $\ell$ in $m$ requires the kernel $\sigma^*(\cdot\mid m,\cdot)$
  to be "well-behaved" in $m$.
- This is a property of the equilibrium representative, not the model
  primitives.
What primitive conditions force (A8c-lsc)? E.g., "agent's optimal
action is upper-hemicontinuous in $m$", or "the trust region is closed".)

### 2b. Economic interpretation
(What does (A8c-lsc) mean economically? It says the agent's optimal
strategy doesn't have "upward jumps in payoff exposure" at τ-null
boundaries — the worst the adversary can do at any $m$ is at least the
nearby worst. Discuss connection to TRE: in the paper's TRE, the
strategy outside the trust region is the "closest safe action" at the
boundary, which is naturally l.s.c. — so (A8c-lsc) is essentially
"$\sigma^*$ has TRE-like structure or is well-behaved at boundaries".)

### 2c. Scope
(Which models naturally satisfy (A8c-lsc)?
- TRE-style strategies (paper's Theorem 1): yes, by construction.
- Continuous best-response models: typically yes.
- Discontinuous-best-response models: not necessarily.
Be specific.)

### 2d. Comparison to standing hypotheses
(The standing hypothesis on $u$ is "continuous in $a$, bounded".
(A8c-lsc) adds a continuity/regularity requirement on the BEST RESPONSE
in $m$, which is one level deeper. Is this free or substantive?)

## 3. (A9c-calib) Calibrated worst-message transport

**Statement.** ∃ coupling $\gamma_\alpha = \alpha(\mathrm{id},\mathrm{id})_\#\tau + (1-\alpha)\gamma$
on $M\times M$ with $\gamma$ first-marginal-τ, support in $\{(s,m): m\in D(s)\}$,
posterior calibration $P_{\gamma_\alpha}(\cdot\mid m)\in C(m)$ q-a.e.

### 3a. Mathematical strength
(How strong is (A9c-calib)? It's a Hall/Strassen-type transport
feasibility condition. Compare:
- The paper's binary-quadratic case (Appendix A.6) verifies it via
  quantile transport. This is essentially the **strongest** model where
  (A9c-calib) is provable from primitives.
- General-Ω, general-payoff: (A9c-calib) is NOT free. It's an
  implicit "TRE generalizes" assumption.
Identify the gap between "trust-region structure of $\sigma^*$" and
(A9c-calib). Is there a substantive class where one holds without
the other?)

### 3b. Economic interpretation
(What does (A9c-calib) mean? It's the requirement that the misaligned
adversary can be "talked into" a Bayes-rationalizing posterior at every
on-path message. This is the heart of robust rationalizability. In the
finite case, Sion's theorem provides this for free; in the infinite
case, it must be IMPOSED.)

### 3c. Scope
(Which models satisfy (A9c-calib)?
- Paper's binary-quadratic + TRE: yes.
- Models where $\sigma^*$ has the trust-region/clipped-action structure
  with sufficient regularity: yes.
- Models where the optimal $\sigma^*$ is qualitatively different from
  TRE (e.g., randomized over multiple "branches"): unclear.
Be honest about the unknown territory.)

### 3d. Comparison to standing hypotheses
(This is the substantively strongest of the three added assumptions.
It substitutes for the upper saddle inequality that Sion gives for free
in the finite case. State this clearly.)

## 4. Comparison and ranking

(Rank from **least restrictive (mildest)** to **most restrictive
(strongest)**. Justify the ranking with explicit reasoning. Identify
which assumption(s) are most plausible to relax in a future research
cycle.)

## 5. Recommendation for the relaxation cycle

(For each assumption, identify one concrete relaxation candidate:
- For (A5): is there a weaker "approximate equivalence" or "support
  thickness on a generic set" that suffices for L5?
- For (A8c-lsc): can we exhibit conditions on the primitives that
  force l.s.c. of $\ell_{\sigma^*}$? Or relax to "l.s.c. except at a
  τ-null set" (which is automatic anyway)?
- For (A9c-calib): is there a structural condition on $\sigma^*$ (e.g.,
  trust-region) that makes calibration automatic?)


## Discipline

- Use paper-canonical notation.
- Cite Dworczak–Smolin sections explicitly when referencing the paper's
  TRE / Theorem 1 / Section 4 / Appendix A.6.
- Be concrete about model classes: don't write "for some models";
  name them.
- Honest opinion encouraged. If an assumption is essentially "free in
  applications" say so; if it's a real restriction, say that too.
- Length budget: 2000–3000 words.

## Scope Policy

This is a scoping/strategy pass. Do NOT prove anything. The output is
an honest critical assessment that will inform the next set of
prover/reviewer cycles attempting to relax the strongest assumption(s).


========
ROLE: assistant (id=d6d694a8-f272-438b-b3d4-36f4753f0933)
========
1. (A5) Common posterior null sets

Statement. $\pi(\cdot\mid\omega)\sim\tau$ for every $\omega$.

1a. Mathematical strength

(A5) requires all state-conditional laws of the adviser’s posterior to have the same null sets as the unconditional posterior law $\tau$. Since $\tau=\sum_\omega \mu_0(\omega)\pi(\cdot\mid\omega)$ and $\mu_0$ has full support, the direction $\pi(\cdot\mid\omega)\ll\tau$ is automatic. The added bite is $\tau\ll\pi(\cdot\mid\omega)$ for every state: no $\tau$-positive region of posterior space may be invisible in any state. The extension proof identifies exactly this as the new content of (A5). 

theorem_2_extension_proof

The gap between (A5) and a weaker condition like “$\tau\ll\pi(\cdot\mid\omega)$ for some $\omega$” is large. L5 needs a single Lusin compact exhaustion that is support-thick simultaneously for every $\pi(\cdot\mid\omega)$. One state with a hole is enough to break the smoothing step, because the payoff sums over states and the adversary can exploit messages whose neighborhoods are invisible under that state. The route memo’s L5 construction uses (A5) precisely to make $\operatorname{supp}(\pi(\cdot\mid\omega)\restriction C_n)=K_n$ for every $\omega$, which gives the simultaneous relative-open positivity condition. 

phil_reny_route_memo

Is (A5) tight? For the current L5 proof architecture, yes in spirit, though not literally as a primitive condition. The truly minimal condition is not full mutual absolute continuity on all of $M$, but the existence of a Lusin-thick compact exhaustion $K_n\uparrow K^$ with $\pi(K^\mid\omega)=1$ for every $\omega$ and every relative open neighborhood in each $K_n$ carrying positive $\pi(\cdot\mid\omega)$ mass. That “support-thick exhaustion” is the hidden workhorse. (A5) is a clean, primitive, checkable sufficient condition for it, not the thinnest possible knife.

1b. Economic interpretation

Economically, (A5) says every posterior message that can occur with positive unconditional probability can occur under every state. Equivalently, the adviser’s posterior distribution has no state-specific support holes. In finite experiments, this is the familiar “strictly positive likelihood matrix” condition. In continuous experiments, it is automatic when each $\pi(\cdot\mid\omega)$ has a strictly positive density against a common reference measure.

That is natural for noisy sensors, continuous AI scores, logit or probit signal models, Gaussian signals with state-dependent means and common full support, and calibrated classifiers whose output probabilities never exactly rule out a state. In those models, an extreme recommendation may be unlikely in some states, but it is not impossible.

It is restrictive for exact information. Perfect revelation fails: if state $\omega$ produces a unique posterior $\delta_\omega$, then the posterior associated with another state is a $\tau$-positive point but has zero probability under $\pi(\cdot\mid\omega)$. The proof record uses exactly this perfect-revelation example to show support-thickness can fail without (A5). 

phil_reny_route_memo

 Partition signals fail for the same reason: each state or event sends the adviser into a state-dependent region of posterior space. So (A5) excludes support-separating experiments, deterministic diagnostic tests, hard disclosure technologies, and exact partition communication.

1c. Scope

In Bayesian persuasion à la Kamenica-Gentzkow, (A5) is satisfied by experiments whose posterior realizations lie in the relative interior of $\Delta(\Omega)$ and whose induced conditional laws have full support over the experiment’s posterior support. It fails for common persuasion constructions with boundary posteriors, conclusive signals, or disclosure partitions.

In Crawford-Sobel strategic information transmission, partition equilibria are the canonical object, and those violate the analogue of (A5): messages reveal that the state lies in a particular interval or cell, so conditional message supports differ across states. Even if one translates Crawford-Sobel into finite-state posterior language, non-overlap is part of the economic mechanism.

In robust persuasion, including Dworczak and Pavan style uncertainty over information structures, (A5) is not robust to the full uncertainty set unless the modeler explicitly rules out partition-like or support-separating signals. If the uncertainty set includes disclosure, deterministic experiments, or state-exclusive signals, (A5) cuts those out.

For Dworczak and Smolin’s own binary-state Section 4, the assumption is natural under their continuous full-support density over $M=[0,1]$: endpoints can be in the support topologically while carrying zero probability, so the state-conditional laws remain mutually absolutely continuous in the measure-theoretic sense relevant here. The paper’s Section 4 is exactly the kind of smooth interior-posterior environment where (A5) feels like harmless noise rather than economic surgery. 

Robust_trust_Dworczak_Smolin

1d. Comparison to standing hypotheses

(A5) is not free. It is a primitive restriction on the signal structure $\pi$, stronger than the paper’s standing assumptions, which allow arbitrary measurable posterior laws under finite $\Omega$, compact $A,\Theta$, bounded $u$ continuous in $a$, and conditional independence of $s$ and $\theta$ given $\omega$. 

objective_statement

That said, it is a familiar regularity condition in noisy-information applications. It is “cheap” for smooth full-support signals and “expensive” for exact-information economics. My scope verdict: substantive but transparent. It buys the Lusin-thick compacts cleanly, while excluding an important class of partition and revelation models.

2. (A8c-lsc) Rowwise lower semicontinuity

Statement. $m\mapsto\ell_{\sigma^*}(m,s)$ l.s.c. on $M$ for τ-a.e. $s$.

2a. Mathematical strength

(A8c-lsc) is a regularity assumption on the selected Branch-A maximizer, not directly on the primitives. The object

p
ω
	​

(m)=∫
Θ
	​

∫
A
	​

u(a,ω,θ)σ
∗
(da∣m,θ)f(dθ∣ω)

depends on $\sigma^$, and $\ell_{\sigma^}(m,s)=\sum_\omega s(\omega)p_\omega(m)$ is the payoff exposure generated by the representative chosen for $\sigma^*$. So (A8c-lsc) is one level downstream from boundedness and continuity of $u$ in $a$.

Technically, it is weaker than continuity and only rowwise in $s$, for $\tau$-a.e. $s$. Its job is specific: make the adversary’s pointwise minimization attain. A l.s.c. function on compact $M$ attains its minimum, giving closed nonempty $D(s)=\arg\min_m\ell(m,s)$ and enabling a measurable selector. The proof record gives a sharp counterexample without l.s.c.: $\ell(m,s)=m$ for $m>0$, $\ell(0,s)=1$ has pointwise infimum equal to essential infimum, but no minimizer. 

theorem_2_extension_proof

Primitive conditions that would force (A8c-lsc) include: a continuous or l.s.c. value-preserving representative $m\mapsto\hat\sigma^*(m)$ in the Balder stable private-strategy topology; continuous payoff profiles $p_\omega(m)$; a closed trust region with a continuous clipping/projection map $P(m)$; or a Bayes-optimal private-strategy correspondence that is upper hemicontinuous in $m$ with payoff-continuous selections. In smooth single-valued best-response environments, these are very plausible. In discontinuous best-response models, they are not automatic.

2b. Economic interpretation

Economically, (A8c-lsc) says the agent’s strategy does not contain payoff-exposure spikes at boundary or off-path messages. Since the misaligned adviser may send messages that have zero $\tau$-probability under truthful reporting, “almost everywhere in $m$” is not enough. A single badly behaved boundary message can matter if the adversary can choose it.

The right intuition is: the worst message cannot be a ghost limit that is approached by increasingly damaging messages but disappears at the limiting message itself. L.s.c. makes the bad boundary available to the adversary, which is exactly what is needed for adversarial attainment.

This fits the paper’s trust-region equilibrium picture. In a TRE, messages inside the trust region are taken at face value, while messages outside are interpreted through a boundary projection. Dworczak and Smolin describe this as Bayes’ rule and Bregman-distance clipping agreeing on path in a TRE. 

Robust_trust_Dworczak_Smolin

 Boundary clipping is naturally semicontinuous, often continuous, when the trust region is closed and the projection is single-valued.

2c. Scope

TRE-style strategies in the paper’s Theorem 1 and Section 4 are the natural home for (A8c-lsc). The binary-state trust interval gives a particularly friendly case: inside $[\underline\mu,\bar\mu]$ the agent uses the Bayes-optimal action for $m$, and outside she uses the endpoint action. Under the smooth assumptions of Section 4, that structure is well behaved. 

Robust_trust_Dworczak_Smolin

Continuous best-response models usually satisfy it: quadratic loss, smooth convex decision problems, continuous actions, unique optimal actions, and regular private information all push toward continuous payoff exposure. Finite-action models can also satisfy it if tie-breaking is payoff-continuous or if only payoff profiles matter.

Models with discontinuous best responses are the danger zone. Threshold action rules, arbitrary tie-breaking at indifference, nonunique best responses, randomized multi-branch optimal strategies, and measurable but wild selectors can all generate row payoff functions that fail l.s.c. Even when the primitive payoff is continuous in $a$, the selected equilibrium representative may be a trapdoor.

2d. Comparison to standing hypotheses

The standing hypothesis on $u$ is boundedness and continuity in $a$. It does not impose continuity in $m$, nor continuity of the selected best-response representative. (A8c-lsc) is therefore not free. It is a substantive regularity requirement on the equilibrium object, but it is less economically structural than (A5): it does not remove whole signal technologies, it asks that the chosen optimal rule be tame enough at worst-message boundaries.

My verdict: mild to moderate in smooth applications, serious in discontinuous-action or arbitrary-selection environments.

3. (A9c-calib) Calibrated worst-message transport

Statement. ∃ coupling $\gamma_\alpha = \alpha(\mathrm{id},\mathrm{id})#\tau + (1-\alpha)\gamma$ on $M\times M$ with $\gamma$ first-marginal-τ, support in ${(s,m): m\in D(s)}$, posterior calibration $P{\gamma_\alpha}(\cdot\mid m)\in C(m)$ q-a.e.

3a. Mathematical strength

(A9c-calib) is the heavyweight. It is a Hall/Strassen-type feasibility condition with two simultaneous constraints. First, the misaligned component must put mass only on worst messages, $m\in D(s)$. Second, after mixing truthful reporting with that adversarial transport, the posterior induced at each message must lie in

C(m)={μ:
σ
^
∗
(m)∈arg
σ
^
′
max
	​

U(
σ
^
′
,μ)}.

The extension proof states this as the condition that recovers the full Definition 2 conclusion after Branch A and rowwise adversariality. 

theorem_2_extension_proof

The gap between “$\sigma^*$ has trust-region structure” and (A9c-calib) is real. A trust region tells us which messages are worst for each adviser posterior. Calibration asks whether the mass moved to each message has exactly the right state composition to make the agent’s prescribed private strategy sequentially optimal. That is a global mass-balance problem, not a pointwise best-response problem.

Dworczak and Smolin’s binary-state Section 4 and Appendix A.6 are the clean success case. The trust region is an interval; the adversary’s worst-message choice has a threshold form; the TRE conditions reduce to two balancing equations; and Appendix A.6 constructs the needed transport by quantile maps between atomless measures. 

Robust_trust_Dworczak_Smolin

 

Robust_trust_Dworczak_Smolin

 That is essentially the most favorable geometry: one-dimensional order, two boundary branches, atomless mass, and monotone matching. In general $\Omega$, $D(s)$ need not be convex, $C(m)$ is a normal-cone slice rather than a simple interval, and multi-branch randomization can turn the transport ledger into a many-headed octopus.

There are substantive classes where trust-region structure plausibly holds without (A9c-calib): multi-dimensional nonconvex trust regions, atom-heavy posterior distributions, models with several worst boundary points for the same $s$, and cases where worst-message mass arrives at a boundary message with the wrong average posterior. Conversely, calibration could hold accidentally outside a canonical TRE structure, but that is not a broad economic class.

3b. Economic interpretation

(A9c-calib) says the adversary can be worst-case and self-confirming at the same time. The misaligned adviser must be able to route posterior types to damaging messages in a way that makes the agent’s reaction at each message Bayes-rational under the induced posterior.

This is the heart of robust rationalizability. In the finite paper proof, Sion’s theorem gives a full saddle point, and the upper saddle inequality delivers per-message Bayes-optimality. In the infinite extension, Branch A plus (A8c-lsc) gives a maximin $\sigma^$ and an adversarial $\beta^$, but not the upper saddle inequality. The proof document states this gap explicitly and uses (A9c-calib) as the substitute. 

theorem_2_extension_proof

Economically, this is not just regularity. It says the worst-case conjecture the agent fears can also rationalize the agent’s own behavior after every on-path recommendation. That is a strong equilibrium-plausibility requirement.

3c. Scope

The paper’s binary quadratic / binary-state TRE satisfies (A9c-calib). Appendix A.6 constructs the relevant quantile transport, and Section 4 uses the resulting mutual best-response structure to characterize the trust interval. 

Robust_trust_Dworczak_Smolin

 

Robust_trust_Dworczak_Smolin

Models with a trust-region or clipped-action structure and enough monotone or radial geometry are plausible candidates: one-dimensional ordered beliefs, interval trust regions, atomless full-support posterior laws, smooth strictly convex indirect utility, and unique boundary projection. Symmetric radial models may also be promising, because the transport problem can collapse to a one-dimensional balance along rays.

The unclear territory is large. General $\Omega$, arbitrary payoffs, randomized optimal strategies over multiple branches, nonconvex or hollow trust regions, finite actions with discontinuities, and robust-persuasion uncertainty sets without monotone geometry are not covered by the current evidence. In those models, (A9c-calib) should be treated as an imposed equilibrium-transport condition, not as a theorem waiting politely in the hallway.

3d. Comparison to standing hypotheses

(A9c-calib) is the strongest of the three added assumptions. It is not a “free” compactness or measurability patch. It substitutes for the upper saddle inequality that finite $M,\Theta$ plus Sion provide in Appendix A.2. The paper explicitly says finite $M,\Theta$ make the minimax proof work, while infinite cheap-talk-like strategy spaces create continuity difficulties because messages affect payoffs endogenously. 

Robust_trust_Dworczak_Smolin

So the scope verdict is clear: (A9c-calib) is a substantive equilibrium existence assumption. It is economically meaningful, mathematically powerful, and the first target for any serious relaxation cycle.

4. Comparison and ranking

Least restrictive to most restrictive:

(A8c-lsc), mildest overall. It is not primitive-free, but it is a regularity requirement on the selected representative of $\sigma^*$, and smooth continuous-action models or TRE clipping rules often deliver it. It can fail, and the counterexample shows why the proof needs something like it, but it does not exclude whole information structures. The most promising relaxation is to replace it with the exact needed condition: rowwise infimum attainment plus a measurable selector.

(A5), middle. It is easy to verify and natural in noisy full-support signal models, but it is a genuine primitive restriction on $\pi$. It excludes perfect revelation, partition signals, conclusive experiments, and many canonical cheap-talk or disclosure structures. In information-design terms, it bans support-separating information. That is a bigger economic cut than (A8c-lsc), even though it is cleaner to state and check.

(A9c-calib), most restrictive. It is a global transport and posterior-calibration condition. It is not merely saying the adversary has worst messages; it says worst messages can be allocated so that every on-path message rationalizes the agent’s prescribed behavior. This is exactly what finite Sion gives in the paper, and exactly what the infinite proof lacks without adding structure. The proof record itself flags recovering the upper saddle or calibrated transport as the price of the infinite-dimensional extension. 

theorem_2_extension_proof

The assumption most plausible to relax first is (A8c-lsc), because it can likely be replaced by primitive sufficient conditions or by direct argmin-attainment. The second target is (A5), by replacing equivalence with the exact Lusin-thickness property. The hardest and highest-value target is (A9c-calib): relaxing it means proving that TRE geometry itself generates calibration, which is the real dragon in this cave.

5. Recommendation for the relaxation cycle

For (A5), replace common posterior null sets with an endogenous Lusin-thick support condition: there exist compact $K_n\uparrow K^$ such that $\pi(K^\mid\omega)=1$ for every $\omega$, $\hat\sigma^*$ is continuous on each $K_n$, and every relative open neighborhood in $K_n$ has positive $\pi(\cdot\mid\omega)$ mass for every state. That is exactly what L5 uses. A more primitive approximate version would be: for every $\varepsilon>0$, find compact $K_\varepsilon$ with $\pi(K_\varepsilon\mid\omega)>1-\varepsilon$ for all $\omega$ and densities locally bounded below on $K_\varepsilon$. This would cover some singular-but-topologically-overlapping signal laws that (A5) currently rejects.

For (A8c-lsc), target the strictly weaker condition: for $\tau$-a.e. $s$, $D(s)=\arg\min_m\ell(m,s)$ is nonempty and admits a measurable selector. L.s.c. is a sufficient route to that, not the economic essence. In parallel, develop primitive sufficient conditions: closed trust region, continuous or upper-hemicontinuous Bayes-optimal correspondence, continuous payoff-profile selection, and continuous clipping map $P(m)$. Relaxing to “l.s.c. except on a $\tau$-null set of messages” is not enough, because the misaligned adviser can concentrate on $\tau$-null messages.

For (A9c-calib), formulate a structural TRE-to-calibration theorem. A good candidate is: if $\sigma^*$ is a closed trust-region strategy with single-valued continuous Bregman projection, $\tau$ is atomless with full support, and the worst-message correspondence has monotone or ray-like fibers satisfying Hall-type mass inequalities, then a calibrated $\gamma_\alpha$ exists. The binary Appendix A.6 quantile transport is the one-dimensional prototype; the next research cycle should generalize that mass-balance argument before trying another all-purpose minimax hammer.
