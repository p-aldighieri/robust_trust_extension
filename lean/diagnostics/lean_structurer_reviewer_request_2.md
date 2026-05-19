You are the Lean Structurer Reviewer in the soft-scaffolding workflow.

This is REVIEW PASS 2. Your pass 1 verdict was PATCH_BIG (implicit_assumptions_absorbed: 4, object_definition_concerns: 6). The Lean Structurer has resubmitted with an explicit response to each of your concerns. Audit this revised decomposition with the same rigor as pass 1 — has every flagged item been addressed faithfully? Has anything new been introduced that wasn't there before and needs scrutiny? Did the structurer over-correct anywhere?

## Your Job

Audit the Lean Structurer's decomposition (objects + lemmas + externals + implicit assumptions) for faithfulness, completeness, and decomposability before any formalization begins. Catching scope drift here is much cheaper than catching it after lemmas have been formalized.

- Always issue a verdict.
- Always say whether the decomposition is fit to send to the dependency-audit step.
- Always give concrete, addressable feedback — point at object slugs, lemma slugs, and specific gaps.
- Object definitions matter as much as lemmas. A wrong-shape object encoding poisons every lemma that references it.
- You advise. The smart orchestrator decides.

## Verdict Levels

- `PASS`: The decomposition faithfully captures the English proof and is ready for dependency audit.
- `PATCH_SMALL`: One or two missing or misnamed items; structurer can fix in one focused pass.
- `PATCH_BIG`: Multiple gaps or wrong-shape lemmas / objects; the decomposition needs a real rework.
- `REDO`: The decomposition misreads the proof's structure (wrong split, wrong main theorem, swapped quantifiers, or misencodes a load-bearing object).

## Output Contract

Return the deliverable inline in this chat so the orchestrator can harvest it cleanly.

- Do not try to edit repository files in place.
- Do not ask the orchestrator to click, download, export, or create a sidecar file for you.
- Do not rely on attachments, Canvas, or side panels as the primary output channel.
- Put the final deliverable directly in the response body.
- If the natural deliverable is markdown, return plain markdown only.
- If the natural deliverable is another format, place that payload in exactly one fenced code block with the correct language tag.
- Keep any prefatory note outside the deliverable to one short sentence at most.
- Follow the role-specific section order exactly when one is requested.

## Output Format

The first fenced `review_control` block is for the orchestrator and must appear first.

````markdown
```review_control
verdict: PASS
ready_for_dep_audit: true
recommended_next_phase: LEAN_DEP_AUDIT
implicit_assumptions_absorbed: 0
object_definition_concerns: 0
```

## Verdict

VERDICT: PASS
Reason: ...

## Opinion and Next Move

(What the orchestrator should do next: send back to structurer, proceed to dependency audit, or re-formalize the English claim first.)

## Detailed Review

### Object-Definition Audit

- Are all objects the proof relies on captured in the "Objects and Definitions" section? (list any gaps)
- Are the suggested Lean modelings (`structure` / `class` / `def` / `instance` / reuse-Mathlib) reasonable, or does any of them invite known encoding pitfalls (e.g., `Prop` vs `Decidable` mismatches, `Set` vs `Finset` when finiteness matters, partial vs total functions)?
- Does any lemma in the DAG reference an object that wasn't defined? (list)
- Any object whose fields look load-bearing but are missing or misnamed? (list)

### Faithfulness Audit

- Item: <object-or-lemma-or-main-slug>
  Issue: (claim drift, weakened hypothesis, missing hypothesis, added assumption, wrong object shape, ...)
  Why it matters: ...
  Suggested repair: ...

### Completeness Audit

- Missing object / lemma / external result: ...
  Where in the English proof it appears: ...

### Decomposability Audit

- Item: <lemma-slug>
  Concern: (lemma is too tangled, depends circularly, uses both quantifier styles, ...)
  Suggested split or merge: ...

### Scope / Assumptions

- Implicit assumptions silently absorbed from the English proof rather than surfaced: ...
- External results misclassified as MATHLIB_CANDIDATE when actually specialist: ...
````

## Notes

- `PASS` means you'd hand this decomposition to the dependency-audit role unchanged.
- A `REDO` is appropriate when the structurer's main-theorem statement does not match the English proof's actual conclusion, OR when a load-bearing object is fundamentally mismodeled.
- Be specific about whether NON_MATHLIB classifications look right — misclassifications here propagate into wasted AXLE-check cycles downstream.
- `implicit_assumptions_absorbed` in the control block counts assumptions the structurer baked in without flagging as `IMPLICIT_ASSUMPTION`. This is the structurer-level analog of axiom smuggling; treat any non-zero count as at least `PATCH_SMALL`.

## Pass 2 Specific Focus

Pass 2 was a PATCH_BIG response. Your pass 1 raised 18 specific issues. As reviewer, your job now is:

1. **Did the structurer address each of your 18 issues?** Don't accept "addressed in spirit" — check each item against the new objects/lemmas. The patch directive listed: payoff layer split (5 objects); Tier 2 adversary identity κ; Bayes-plausibility consistency; ProfileRealizationSetup; ΔΩ → M restriction bridge; JvN universally-measurable correction; atomlessness removed from cone-intersection; main theorem split (6 sub-theorems); explicit predicates (KernelSupportedOnG etc.); nonemptiness assumptions; Tier 2 hypothesis correction (ExactContact ∧ MenuHall); Definition2QAEPredicate split; menu-value-equivalence three-way split; profile-realization-right-inverse two-way split; no-free-dust five-way split; WTA cone identification explicit hypotheses; witness-classification scoped to behavioral pieces; external reclassifications.

2. **Did the structurer over-correct?** Watch for: (a) introducing scope drift that wasn't in v8 (e.g., new hypotheses that aren't in the source); (b) making the payoff or kernel layers more general than the source proof requires; (c) adding lemmas that aren't actually used.

3. **Have new objects/lemmas been added that need their own faithfulness audit?** Object_count went from 36 to 50, lemma_count from 29 to 50. Spot-check the new ones.

4. **Implicit assumptions count went from 16 to 20.** Surface anything that should be promoted from implicit to explicit.

5. **non_mathlib_count went from 5 to 10.** That's the right direction (your pass 1 flagged at least 5 underclassified externals). Verify each new NON_MATHLIB is genuinely not in Mathlib at the pinned toolchain (lean-4.29.0).

If everything is genuinely addressed and the decomposition reads as faithful and DAG-clean, issue PASS. Don't withhold PASS just because pass 1 was hard — the test is whether pass 2 is now correct.

## Translation Discipline

This role is part of the Lean post-processing module. Your job is **translation, not mathematics**. The math is already settled by the prover/consolidator passes upstream; you are turning it into Lean. Hold this discipline:

- Do not add hypotheses the source did not state. Do not weaken hypotheses to make a claim easier, or strengthen them to make a proof go through. The Lean type must say the same thing as the source statement.
- Do not "improve" the proof, generalize a result, or fix a mathematical issue you spot mid-translation. If you notice a real mathematical concern, surface it as a `MATHEMATICAL_CONCERN` block at the end of your output and continue translating faithfully. The orchestrator decides whether to revisit the proof or proceed.
- Do not invent results, lemmas, definitions, or objects that are not in the upstream decomposition. The structurer's DAG is the source of truth for what exists; every Lean declaration you introduce must trace back to an item the structurer named (or, if you are the structurer, to the source proof).
- **Never use `axiom`.** Stubbed dependencies use `theorem ... := sorry` so AXLE's `permitted_sorries` can audit them. An `axiom` declaration bypasses that audit and is the canonical way mistakes get smuggled into a Lean proof. Forbidden in this module.
- Do not use `native_decide` or any tactic that delegates correctness to Lean's compiler rather than its kernel. Same goes for `unsafe` declarations and custom `Decidable` instances whose correctness has not been audited.

If you cannot translate faithfully without crossing one of these lines, stop and emit a `TRANSLATION_BLOCKED` block describing the conflict precisely. Do not paper over it.


## Context Packet


## English source proof (v8) — ground truth

# Robust Trust Theorem 2 — infinite-$M$, $\Theta$ extension via the payoff-profile menu engine (v8, three-tier + sharpness package)

*Final consolidator. Replaces v7. The previous v7 three-tier proof
(menu engine in $W$-geometry) is preserved; v8 integrates three
items v7 left implicit or under-developed: (i) the precise q-a.e.
reading of Definition 2 in the infinite setting; (ii) a sharpened
version of the Tier-2 sharpness witness (cone intersection lemma +
no-free-dust theorem); (iii) classification of the ternary witness
as a menu-engine artefact, not a primitive counterexample to
unrestricted Theorem 2.*

## 1. Setting and the question

Standard Robust-Trust setup (Dworczak–Smolin 2026, §2). $\Omega$ finite
with full-support prior $\mu_0$; $s\in\Delta(\Omega)$ has state-conditional
law $\pi(\cdot\mid\omega)$ and unconditional law $\tau$;
$M = \operatorname{supp}\tau$; $\theta\in\Theta$ (compact metric);
$A$ compact metric; $u(a,\omega,\theta)$ bounded continuous in $a$;
conditional independence of $s,\theta$ given $\omega$. $\Sigma$ =
agent's measurable strategies, $B$ = misaligned-adviser measurable
kernels. With probability $\alpha$ aligned (truthful), with probability
$1-\alpha$ misaligned. $U^* = \sup_\sigma U(\sigma)$.

The question: existence direction of Theorem 2 for infinite $M$ and
$\Theta$.

## 2. Reading Definition 2 in the infinite setting

The paper's Section 2 convention says that for infinite spaces,
"statements involving 'for all' should be interpreted as 'for almost
all' with respect to the underlying distributions." Definition 2
quantifies $\hat\sigma(m)\in\arg\max_{\hat\sigma'}U(\hat\sigma',P_{\beta^*}(\cdot\mid m))$
"for all $m\in M$". The natural underlying distribution is **not**
$\tau$ but the actual mixture message marginal under $\beta^*$:
$$
q_{\beta^*} \;:=\; \alpha\,\tau \;+\; (1-\alpha)\!\!\int_M\!\beta^*(\cdot\mid s)\,\tau(ds).
$$
Two key consequences:

- **The right reading of Definition 2 is $q_{\beta^*}$-a.e.**, not
  $\tau$-a.e. and not literal-all. $P_{\beta^*}(\cdot\mid m)$ is itself
  a regular conditional probability defined $q_{\beta^*}$-a.e.
- **The adversary is not required to be $\tau$-absolutely continuous.**
  $\beta^*$ may place positive mass on $\tau$-null Borel sets $N\subseteq M$,
  in which case $q_{\beta^*}(N)>0$ and those messages are on-path
  for the mixture law.

In the finite paper proof, $\alpha>0$ ensures every $m\in M$ has
positive mixture mass, so literal-all, $\tau$-a.e., and
$q_{\beta^*}$-a.e. coincide. In infinite $M$, $\tau$-null but
$q_{\beta^*}$-positive messages are admissible and **must satisfy
the Bayes-optimality condition** if the adversary uses them.

## 3. The menu engine

The paper's Theorem 1 / Appendix A.1 introduces the **payoff-profile set**
$$
W \;:=\; \{w\in\R^{|\Omega|} : \exists\,\hat\sigma:\Theta\to\Delta(A)\ \text{measurable},\ w(\omega) = \E_{\hat\sigma}[u(a,\omega,\theta)\mid\omega]\}.
$$
$W$ is **compact convex in $\R^{|\Omega|}$** (boundedness + compact $A$ +
continuity in $a$). An agent strategy $\sigma$ corresponds to a
measurable map $w_\sigma: M\to W$, the message-conditional payoff
profile, and conversely (modulo the standard profile-realization
sub-lemma below).

The agent's choice variable is therefore a compact subset $C\subseteq W$
("menu") together with a labeling $w: M\to C$. The objective decomposes
cleanly:
$$
F(C) \;:=\; \int_M \!\Big[\alpha\,\max_{w\in C}\,s\cdot w \;+\; (1-\alpha)\,\min_{w\in C}\,s\cdot w\Big]\,\tau(ds).
$$

**Menu-value equivalence.**
$$
U^* \;=\; \sup_{C\in\mathcal K(W)}\,F(C),
$$
where $\mathcal K(W)$ is the set of nonempty compact subsets of $W$.

**Profile-realization sub-lemma (standard).** $\Phi:\hat\Sigma\to W$
from the compact standard-Borel private-kernel space $\hat\Sigma$ to
$W$ is continuous with compact fibers. By Aliprantis–Border 18.13
(Kuratowski–Ryll-Nardzewski) it admits a Borel right inverse
$R: W\to\hat\Sigma$. Every Borel $w: M\to W$ is implementable as a
measurable agent strategy $\sigma(da\mid m,\theta) = R(w(m))(da\mid\theta)$.

## 4. Main theorem (three tiers)

### Theorem (Tier 1a — value optimality + ε-adversary, unconditional)

*Under the standing hypotheses of Dworczak–Smolin (2026), there exists
$\sigma^*\in\Sigma$ with*
$$
U(\sigma^*) \;=\; U^*.
$$
*Moreover, for every $\eps>0$ there exists $\beta_\eps\in B$ with*
$$
U(\beta_\eps,\sigma^*) \;\le\; U^* + \eps.
$$

**No added hypotheses for Tier 1a.**

### Theorem (Tier 1b — exact adversary attainment)

*Under standing hypotheses + Assumption (exact-contact), the
ε-adversary above can be replaced by an exact $\beta^*\in B$ with*
$$
U(\beta^*,\sigma^*) \;=\; \inf_{\beta\in B}\,U(\beta,\sigma^*) \;=\; U^*.
$$

\paragraph{Assumption (exact-contact).}
Let $C^\dagger := \overline{w^*(M)}$ where $w^*(m) := \arg\max_{w\in C^*}\,m\cdot w$
is the aligned-best labeling at the optimal menu $C^*$. Then for
$\tau$-a.e. $s\in M$, the rowwise contact set
$$
G(s) \;:=\; \big\{m\in M : s\cdot w^*(m) = \min_{z\in C^\dagger}\,s\cdot z\big\}
$$
is **nonempty and admits a measurable selector**.

Sufficient routes (each implies exact-contact): $w^*(M)$ closed; the
strategy correspondence has closed graph; the agent's Bayes-action
correspondence is upper-hemicontinuous with closed compact values.

### Theorem (Tier 2 — full robust rationalizability)

*Under standing + (exact-contact) + Assumption (menu-Hall),
$(\sigma^*,\beta^*)$ can be chosen so that, when $\alpha>0$,*
$$
\hat\sigma^*(m) \;\in\; \arg\max_{\hat\sigma'}\,U\big(\hat\sigma',\,P_{\beta^*}(\cdot\mid m)\big) \quad \text{for $q$-a.e.\ }m\in M,
$$
*where $q := (\gamma_\alpha)_2$. Since $q\ge\alpha\tau$ when $\alpha>0$,
the conclusion also holds $\tau$-a.e.*

\paragraph{Assumption (menu-Hall).}
There exists a kernel $\kappa(\cdot\mid s)$ on $M$ supported on
$G(s)$ for $\tau$-a.e. $s$ such that, with
$\gamma_\alpha := \alpha\,(\mathrm{id},\mathrm{id})_\#\tau + (1-\alpha)\,\tau\otimes\kappa$
and $q := (\gamma_\alpha)_2$, the disintegration posterior
$P_{\gamma_\alpha}(\cdot\mid m) \in B(m)$ for $q$-a.e.\ $m$, where
$$
B(m) \;:=\; \{\mu\in\Delta(\Omega) : \hat\sigma^*(m)\in\arg\max_{\hat\sigma'}\,U(\hat\sigma',\mu)\}.
$$

Equivalently (support-function form): for every measurable $E\subseteq M$
and every continuous affine $\phi:\Delta(\Omega)\to\R$,
$$
\alpha\!\int_E\!\phi(m)\,\tau(dm) + (1-\alpha)\!\int_M\!\phi(s)\,\kappa(E\mid s)\,\tau(ds) \;\le\; \int_E\!h_{B(m)}(\phi)\,q(dm).
$$

This is **strictly milder** than v5's deterministic TRE-gen-Hall:
$\kappa$ may mix over $G(s)$ (set-valued mixing).

## 5. Proof — Tier 1a (unconditional)

### Lemma 1 (menu-value equivalence)

$U^* = \sup_{C\in\mathcal K(W)}\,F(C)$.

\paragraph{Proof.} For fixed $\sigma$ with profile-map $w_\sigma:M\to W$:
the misaligned term satisfies $\inf_\beta\!\int\!\!\int s\cdot w_\sigma(m)\,\beta(dm\mid s)\,\tau(ds) = \int_M\inf_{m\in M}\,s\cdot w_\sigma(m)\,\tau(ds) = \int_M\inf_{w\in w_\sigma(M)}\,s\cdot w\,\tau(ds)$.
The aligned term is $\int s\cdot w_\sigma(s)\,d\tau$. Optimizing
$w_\sigma$ jointly: pick a compact $C\subseteq W$ for the image, then
take $w_\sigma(s) = \arg\max_{w\in C}\,s\cdot w$. By the
profile-realization sub-lemma, every such pair $(C, w_\sigma)$
corresponds to some $\sigma\in\Sigma$.

### Lemma 2 (menu existence)

$\sup_{C\in\mathcal K(W)}\,F(C)$ is attained.

\paragraph{Proof.} $\mathcal K(W)$ is compact metrizable in Hausdorff
distance. The maps $C\mapsto\max_{w\in C}\,s\cdot w$ and
$C\mapsto\min_{w\in C}\,s\cdot w$ are 1-Lipschitz in $d_H$ uniformly
in $s$. Hence $F$ is continuous in $C$, and a compactness argument
gives a maximizer $C^*\in\mathcal K(W)$.

### Lemma 3 (closure-pruning value preservation)

Let $w^*(m) := \arg\max_{w\in C^*}\,m\cdot w$ (single-valued $\tau$-a.e.,
else KRN selects). Set $C^\dagger := \overline{w^*(M)} \subseteq C^*$.
Then $F(C^\dagger) = F(C^*) = U^*$.

\paragraph{Proof.} Aligned term unchanged: $\max_{w\in C^*}\,m\cdot w = m\cdot w^*(m) \le \max_{w\in C^\dagger}\,m\cdot w \le \max_{w\in C^*}\,m\cdot w$.
Misaligned: $C^\dagger\subseteq C^*\Rightarrow \min_{C^\dagger}\,s\cdot w \ge \min_{C^*}\,s\cdot w$,
so $F(C^\dagger) \ge F(C^*)$. Optimality forces equality.

### Lemma 4 (ε-adversary realization, unconditional)

For every $\eps>0$, there exists Borel $\beta_\eps\in B$ with
$U(\beta_\eps,\sigma^*) \le U^* + \eps$.

\paragraph{Proof.} For each $s$, the set
$G_\eps(s) := \{m\in M : s\cdot w^*(m) \le \min_{z\in C^\dagger}\,s\cdot z + \eps\}$
is nonempty (definition of inf) and has Borel-measurable graph.
Jankov–von Neumann gives a Borel selector $m_\eps(s)\in G_\eps(s)$.
$\beta_\eps(\cdot\mid s) := \delta_{m_\eps(s)}$ achieves
$U(\beta_\eps,\sigma^*) \le U^* + (1-\alpha)\eps$.

### Tier 1a capstone

Lemma 1 + Lemma 2 + profile-realization sub-lemma deliver $\sigma^*\in\Sigma$
with $U(\sigma^*) = U^*$. Lemma 4 delivers ε-adversaries. ∎

## 6. Proof — Tier 1b (under exact-contact)

### Lemma 5 (exact adversary)

Under (exact-contact), the deterministic kernel $\beta^*(\cdot\mid s) := \delta_{m^*(s)}$
satisfies $U(\beta^*,\sigma^*) = U^*$.

\paragraph{Proof.} (exact-contact) gives Borel $m^*: M\to M$ with
$m^*(s)\in G(s)$ τ-a.e. By Lemma 3 plus continuity,
$\inf_{m\in M}\,s\cdot w^*(m) = \min_{z\in C^\dagger}\,s\cdot z$,
attained by $m^*(s)$.

## 7. Proof — Tier 2 (under exact-contact + menu-Hall)

### Lemma 6 (per-message Bayes-optimality)

Under (exact-contact) + (menu-Hall), $\hat\sigma^*(m)$ is Bayes-optimal
under $P_{\gamma_\alpha}(\cdot\mid m)$ for $q$-a.e. $m$.

\paragraph{Proof.} (menu-Hall) gives the disintegration posterior in
$B(m)$ q-a.e. By definition of $B(m)$,
$\hat\sigma^*(m)\in\arg\max\,U(\hat\sigma',P_{\gamma_\alpha}(\cdot\mid m))$.
When $\alpha>0$, $q\ge\alpha\tau$, so q-a.e. ⇒ τ-a.e.

This delivers the $q$-a.e. version of Definition 2's condition,
which by §2 is the right reading in the infinite setting.

## 8. Sharpness of menu-Hall

The structural calibration condition (menu-Hall) cannot be derived
from standing + (exact-contact) alone. The witness below shows this
in winner-takes-all ternary; the cone intersection lemma and
no-free-dust theorem strengthen v7's earlier pointwise version into
a uniform obstruction.

\paragraph{Setting.} $\Omega = \{0,1,2\}$, $A = \{a_0,a_1,a_2\}$
winner-takes-all ($u(a_\omega,\omega) = 1$, $-1$ otherwise), prior
$\mu_0 = (1/3, 1/3, 1/3)$, atomless full-support $\tau$ on
$\Delta(\Omega)$, trust region $T = \{\mu : \mu(0)\le 0.4\}$. The
induced payoff-profile menu under any plurality continuation is the
full vertex set $C^\dagger = \{v_0, v_1, v_2\}$ where
$v_\omega(\omega) = 1$ and $v_\omega(\omega') = -1$ for $\omega'\ne\omega$.

For each nonempty $I\subseteq\{0,1,2\}$, define the **rowwise
minimizer cone** and **Bayes-optimality cone** of the mixed profile
$w_\lambda := \sum_{i\in I}\lambda_i v_i$ (with $\mathrm{supp}\,\lambda = I$):
$$
K_I^- \;=\; \{s\in\Delta(\Omega) : s_i\le s_k\,\,\forall i\in I,\,\forall k\in\{0,1,2\}\},
$$
$$
B_I \;=\; \{p\in\Delta(\Omega) : p_i\ge p_k\,\,\forall i\in I,\,\forall k\in\{0,1,2\}\}.
$$
($K_I^-$ uses the identity $s\cdot w_\lambda = 2\sum_i\lambda_i s_i - 1$
to identify rowwise minimizers; $B_I$ similarly.)

### Lemma 7 (cone intersection)

For every nonempty $I\subseteq\{0,1,2\}$, if $\rho$ is a Borel probability
on $\Delta(\Omega)$ with $\rho(K_I^-) = 1$ and barycenter $\bar s\in B_I$,
then $\rho = \delta_{\mu_0}$ where $\mu_0 = (1/3, 1/3, 1/3)$.

\paragraph{Proof.} Fix $i\in I$. $\rho$-a.s., $s_k - s_i \ge 0$ for
every $k$. Since $\bar s\in B_I$, $\bar s_i\ge\bar s_k$, so
$\int(s_k - s_i)\,d\rho \le 0$. A bounded nonnegative Borel random
variable with nonpositive expectation is zero a.s., hence $s_k = s_i$
$\rho$-a.s. for every $k$. Coordinates summing to one force
$s = (1/3, 1/3, 1/3)$ $\rho$-a.s.

### Theorem 8 (no-free-dust)

Under atomless $\tau$, no Borel $\tau$-null set $N\subseteq M$, no
Borel labeling $w_N: N\to W$, and no adversarial kernel $\kappa$
supported on rowwise minimizers can simultaneously satisfy:
(a) $q_\beta(N) > 0$, where $q_\beta = \alpha\tau + (1-\alpha)(\tau\otimes\kappa)_2$;
(b) Bayes-cone calibration: at $q_N$-a.e. $m\in N$, the conditional
source barycenter $\bar s(m)$ lies in $B_{I(m)}$ where $I(m) := \mathrm{supp}\,\lambda(m)$
encodes the dust label $w_N(m) = w_{\lambda(m)}$.

\paragraph{Proof.} Define $\nu(ds, dm) := \tau(ds)\,\kappa(dm\mid s)$
on $\Delta(\Omega)\times M$, and let $\nu_N := \nu\!\restriction_{\Delta(\Omega)\times N}$.
Since $\Delta(\Omega)\times M$ is standard Borel, disintegrate $\nu_N$
over its second marginal $q_N := (\nu_N)_2$:
$$
\nu_N(A\times E) \;=\; \int_E\!\rho_m(A)\,q_N(dm)
$$
for Borel kernels $\rho_m$ on $\Delta(\Omega)$, $q_N$-a.e. $m\in N$.
The rowwise-minimizer support condition gives $\rho_m(K_{I(m)}^-) = 1$
$q_N$-a.e. The Bayes-cone calibration (b) gives the barycenter of
$\rho_m$ in $B_{I(m)}$. By Lemma 7, $\rho_m = \delta_{\mu_0}$ q_N-a.e.
Hence
$$
\nu(\{\mu_0\}\times N) \;=\; \int_N\rho_m(\{\mu_0\})\,q_N(dm) \;=\; q_N(N).
$$
Now $\tau(N) = 0$, so $q_\beta(N) = (1-\alpha)\,q_N(N)$. Assumption (a)
gives $q_N(N) > 0$ (assuming $\alpha < 1$; $\alpha = 1$ rules out
adversarial dust trivially). On the other hand, $\nu$ has first marginal
$\tau$, so
$$
\nu(\{\mu_0\}\times N) \;\le\; \nu(\{\mu_0\}\times\Delta(\Omega)) \;=\; \tau(\{\mu_0\}) \;=\; 0
$$
(atomlessness). Contradiction.

\paragraph{Significance.} The proof never counts messages. It works
identically for finite, countable, or uncountable continuum dust.
Diffuse glitter dust does not help. Combined with Lemma 7's
all-supports-uniform statement, the obstruction is **invariant** to:
deterministic vs. mixed kernel, pure vs. mixed dust labels, atomic vs.
diffuse dust, single boundary message vs. continuum of dust messages.

### Corollary (sharpness for v7's witness).

Setting $I = \{0\}$ in Lemma 7 recovers v7's pointwise sharpness at
$t_0 = (0.4, 0.3, 0.3)$. Theorem 8 then shows no null-message dust
construction can repair the obstruction. menu-Hall is therefore
genuinely required for Tier 2 in this geometry.

## 9. Classification of the witness — menu-engine artefact

Lemma 7 + Theorem 8 strengthen menu-Hall's necessity inside the menu
engine. They do **not** falsify unrestricted Theorem 2 (existence
direction with infinite $M$, $\Theta$).

\paragraph{Claim.} The trust region $T = \{\mu : \mu(0)\le 0.4\}$ used
above is **not a primitive, minimal, or load-bearing trust region**
for the WTA model. Its induced payoff-profile menu is the full vertex
menu $\{v_0, v_1, v_2\}$, behaviorally equivalent to $T = \Delta(\Omega)$.

\paragraph{Justification.} $T$ contains beliefs with each plurality
label: $(0.4, 0.3, 0.3)\mapsto a_0$, $(0.1, 0.8, 0.1)\mapsto a_1$,
$(0.1, 0.1, 0.8)\mapsto a_2$. So any plurality-vertex continuation on
$T$ produces all three pure profiles $v_0, v_1, v_2$. The induced
effective menu is the full vertex menu. The off-$T$ Bregman/TRS
projection chooses an interior point of $T$ whose induced profile
maximizes $m\cdot w$ over the in-$T$ menu — but since the in-$T$ menu
is already the full vertex set, the projection collapses to ordinary
plurality at $m$. Thus every $m\in\Delta(\Omega)$ inside or outside
$T$ induces the same Bayes-optimal WTA vertex, identically to
$T = \Delta(\Omega)$.

If the full menu $\{v_0, v_1, v_2\}$ is optimal under some primitive
$(\alpha, \tau, \Theta, f, u, A)$, then the same behavior is
representable as $T = \Delta(\Omega)$. If the full menu is not optimal,
neither is the halfspace. Either way, the boundary number $0.4$ and
the boundary point $t_0$ are **representational scenery, not
load-bearing beams**.

\paragraph{Consequence.} The witness is a **menu-engine artefact**.
It demonstrates that menu-Hall is genuinely needed inside the
$F$-functional optimization (i.e., choosing among compact menus in
$\mathcal K(W)$), but it does not certify that **every primitive
optimal solution** must hit the same obstruction. There is no known
primitive WTA robust optimization under standing assumptions in which
this halfspace $T$ is genuinely binding **and** recovers the v7 cone
geometry. To recover the obstruction, the strategy would need to
label a τ-null boundary point by $v_0$ while sourcing it from $K_0^-$ —
but the same trust region already contains all three vertices, so the
primitive induced menu is full.

## 10. Comparison with v5

| Quantity | v5 (Phil-Reny route) | v7 (menu engine) | v8 (= v7 + sharpness package) |
|---|---|---|---|
| Tier 1 hypotheses | standing + A5-thick + A8c-attain | standing alone | standing alone |
| Exact β* hypotheses | + A5-thick + A8c-attain | standing + exact-contact | standing + exact-contact |
| Tier 2 hypotheses | + TRE-gen-Hall (deterministic) | + menu-Hall (set-valued) | + menu-Hall (set-valued) |
| Engine | Balder + Mertens + Lusin | Hausdorff on $\mathcal K(W)$ | same |
| Sharpness | pointwise ternary witness | pointwise + set-valued | **uniform across all supports + no-free-dust** |
| Witness status | claimed obstruction to unrestricted Th. 2 | same | **menu-engine artefact, not a primitive counterexample** |

## 11. What v8 has and has not done

\paragraph{What v8 proves (positive).}
- Tier 1a unconditionally: existence of value-optimal $\sigma^*$ plus
  ε-adversaries under standing assumptions alone.
- Tier 1b under (exact-contact): exact $\beta^*$.
- Tier 2 under (exact-contact) + (menu-Hall): full robust
  rationalizability, $q$-a.e. (the natural reading of Definition 2 in
  the infinite setting), hence $\tau$-a.e. when $\alpha>0$.

\paragraph{What v8 sharpens (sharpness).}
- Cone intersection lemma: uniform statement covering all support
  patterns, not just the singleton $I = \{0\}$.
- No-free-dust theorem: no Borel $\tau$-null dust + adversarial
  kernel can repair menu-Hall in WTA ternary, regardless of how
  diffuse or how many dust messages are used.

\paragraph{What v8 does not prove (open).}
- Whether menu-Hall is derivable under additional **primitive**
  structural conditions on $C^\dagger$, the agent's strategy
  correspondence, or the trust-region geometry of $T$. Open candidates:
  primitive optimal $C^\dagger$ that is automatically calibrated;
  trust-region-induced geometric symmetries (radial, zonotopal,
  group-invariant) that force calibration.
- Whether unrestricted infinite Theorem 2 holds without any added
  hypothesis. v8 narrows the question to: does a primitive optimal
  agent strategy in the infinite-$M$, $\Theta$ setting always admit a
  set-valued adversarial kernel with Bayes-cone-consistent
  disintegration posterior? The witness in §8 demonstrates this
  question has bite inside the menu engine; classification (b) shows
  the witness does not settle the primitive question.

## 12. Remaining directions

- **Canonical/minimal menu route.** Identify a "primitive" or
  "behaviorally minimal" payoff-profile menu (not merely an
  $F$-optimal menu in $\mathcal K(W)$) and show calibration follows
  from canonicality. Risk: must not simply rename menu-Hall.
- **Trust-region geometry.** Radial symmetry, zonotopal alignment,
  group-invariant $T$. Each may force menu-Hall automatically. Best
  positive islands: binary state (paper Appendix A.6) and spherical
  (paper §5.2 + Appendix A.10).
- **Constrained-persuasion transport.** Recast the adversarial flow
  as a Strassen/Kellerer transport problem with Bayes-cone
  constraints. Could yield either a transport rescue or a decisive
  dual certificate that menu-Hall is unavoidable.
- **Closed-graph constructive labelings.** Identify which model
  primitives force $w^*$ to admit a closed-graph representative
  (sufficient for exact-contact without assumption).

## References

- **Dworczak, P. and Smolin, A.** (2026). "Robust Trust." arXiv:2602.09490.
- **Aliprantis, C. D. and Border, K. C.** (2006). *Infinite Dimensional Analysis*, 3rd ed. Springer.
- **Bogachev, V. I.** (2007). *Measure Theory*. Standard-Borel disintegration.

---

*v8 supersedes v7. Cone intersection lemma + no-free-dust theorem +
classification of the ternary witness as a menu-engine artefact added.*


## Revised Decomposition (pass 2) — under review

lean_structure
main_theorem: robust-trust-infinite-extension-v8-package
object_count: 50
lemma_count: 50
external_count: 17
implicit_assumption_count: 20
non_mathlib_count: 10
Objects and Definitions
robust-trust-model

English name: Robust Trust model instance
Informal type: A bundled model satisfying the standing hypotheses: finite state space, full-support prior, adviser posterior process, compact metric type and action spaces, bounded payoff continuous in action, conditional independence of adviser posterior and type given state, and alignment probability.
Suggested Lean modeling: structure
Key fields / operations: Ω : Type, [Fintype Ω]; μ0 : ProbabilityMass Ω; fullSupport μ0; Belief := {s : Ω → ℝ // 0 ≤ s ∧ ∑ω s ω = 1}; π : Ω → ProbabilityMeasure Belief; τ : ProbabilityMeasure Belief; Θ A : Type with compact metric and measurable structures; u : A → Ω → Θ → ℝ; u_bounded; u_continuous_in_action; α : ℝ; 0 ≤ α; α ≤ 1; conditional type laws; conditional-independence axiom; posterior-law consistency fields.
Used by: [posterior-law-barycenter-identities, payoff-profile-set-compact-convex, profile-payoff-decomposition-aligned, profile-payoff-decomposition-misaligned, tier1a-value-optimality-and-epsilon-adversary, tier1b-exact-adversary-under-exact-contact, tier2-qae-robust-rationalizability-under-menu-Hall]
Modeling notes: Keep exact-contact and menu-Hall outside this object. They are tier hypotheses, not standing assumptions.

finite-state-and-belief-simplex

English name: Finite state space and belief simplex
Informal type: A finite state space Ω and the finite-dimensional probability simplex Δ Ω, with dot products and barycenters.
Suggested Lean modeling: def plus subtype of Ω → ℝ; reuse finite-dimensional vector-space APIs.
Key fields / operations: Belief Ω; belief_nonneg; belief_sum_one; dot : Belief Ω → (Ω → ℝ) → ℝ; barycenter : ProbabilityMeasure (Belief Ω) → Belief Ω; coordinate projections.
Used by: [posterior-law-barycenter-identities, profile-payoff-decomposition-aligned, menu-extrema-Hausdorff-Lipschitz, WTA-payoff-dot-product-identity, wta-cone-intersection]
Modeling notes: Model profiles as Ω → ℝ, not as abstract ℝ^N. This keeps finite sums over states explicit.

prior-and-adviser-posterior-law

English name: Prior and adviser posterior law
Informal type: The prior μ₀, state-conditional posterior laws π(·|ω), unconditional posterior law τ, and support M.
Suggested Lean modeling: fields inside robust-trust-model plus helper definitions.
Key fields / operations: μ0; π; τ; τ = ∑ω μ0(ω) • π ω; support M := supp τ; integration over τ; atomlessness predicate for sharpness.
Used by: [posterior-law-barycenter-identities, message-support-M, mixture-message-law, posterior-disintegration, wta-no-free-dust]
Modeling notes: The positive tiers do not assume atomlessness. Atomlessness belongs only to WTA no-free-dust.

posterior-law-consistency-field

English name: Bayes-plausibility and posterior-law consistency
Informal type: A field asserting that the random variable s : Δ Ω is the Bayesian posterior generated by π and μ0, not just an arbitrary belief-valued signal.
Suggested Lean modeling: field in robust-trust-model or a bundled theorem record.
Key fields / operations: finite-measure identity μ0(ω) • π ω = (fun s => s ω) • τ for each ω; barycenter identity ∫ s dτ = μ0; posterior identity Pr(ω | s) = s(ω) τ-a.e.; conditional-barycenter identities used after disintegration.
Used by: [posterior-law-barycenter-identities, profile-payoff-decomposition-aligned, menu-Hall-posterior-calibration-unpack, dust-conditional-sources-satisfy-cones]
Modeling notes: This avoids silently treating arbitrary laws on Δ Ω as posterior laws. In Lean, the finite-measure identity is cleaner than prose Bayes-plausibility.

message-support-M

English name: Message support space
Informal type: M := supp τ, treated as the on-path message space for aligned reports and as the restricted codomain for adversarial reports.
Suggested Lean modeling: subtype {s : Belief Ω // s ∈ supp τ}
Key fields / operations: inclusion M → Belief Ω; restricted measure τM; Borel structure; compact or standard-Borel structure; identity truthful report on M.
Used by: [strategy-restriction-to-M, adversary-kernels-restrict-to-M, mixture-message-law, rowwise-contact-correspondence-G, menu-Hall-assumption]
Modeling notes: Use a subtype to prevent kernels from accidentally sending messages outside the intended support.

message-restriction-bridge

English name: Restriction bridge from Δ Ω to M
Informal type: Data and propositions connecting the paper’s full message space Δ Ω to the menu-engine message space M.
Suggested Lean modeling: structure plus lemmas.
Key fields / operations: restriction of full agent strategies to M; extension or arbitrary completion outside M; proof that outside-M messages do not affect aligned payoff or robust objective; proof that adversarial kernels can be replaced by kernels supported on M without changing the infimum.
Used by: [strategy-restriction-to-M, outside-M-messages-irrelevant, adversary-kernels-restrict-to-M, menu-value-equivalence]
Modeling notes: This is the formal bridge for the paper’s “without loss, adversarial strategies only use M” line.

type-action-payoff-primitives

English name: Agent type, action, and payoff primitives
Informal type: Compact metric type space Θ, compact metric action space A, bounded payoff u(a,ω,θ) continuous in action, and conditional type laws.
Suggested Lean modeling: fields inside robust-trust-model
Key fields / operations: Θ; A; typeLaw : Ω → ProbabilityMeasure Θ; u; boundedness; continuity in a; measurability in all variables.
Used by: [private-payoff-functional, payoff-profile-set-compact-convex, profile-payoff-decomposition-aligned, profile-payoff-decomposition-misaligned]
Modeling notes: Do not strengthen to continuity in θ unless the source proof explicitly does so.

private-strategy-space

English name: Private strategy space
Informal type: Measurable kernels or maps hatσ : Θ → Δ A prescribing an action distribution for each private type.
Suggested Lean modeling: structure for measurable Markov kernels from Θ to A.
Key fields / operations: actKernel : Θ → ProbabilityMeasure A; measurability; expected payoff against a belief; profile map Φ.
Used by: [private-payoff-functional, profile-realization-setup, profile-map-has-borel-right-inverse, Bayes-optimality-belief-correspondence-Bm]
Modeling notes: Compactness/topology of this space should come from profile-realization-setup, not from an implicit global instance.

agent-strategy-space

English name: Full agent strategy space
Informal type: Measurable strategies σ : Δ Ω × Θ → Δ A, equivalently message-indexed private strategies on the full paper message space.
Suggested Lean modeling: structure for measurable kernels from Belief Ω × Θ to A.
Key fields / operations: sectionFull : Belief Ω → PrivateStrategy; measurability in (m,θ); restriction to M.
Used by: [strategy-restriction-to-M, outside-M-messages-irrelevant, definition2-qae-predicate]
Modeling notes: The main menu engine works through the restricted section on M, but the paper’s strategy space starts over all Δ Ω.

restricted-agent-strategy-space-on-M

English name: Restricted agent strategy space on M
Informal type: Measurable strategies indexed only by messages in M, used by the menu engine.
Suggested Lean modeling: structure or subtype induced by restriction of agent-strategy-space.
Key fields / operations: section : M → PrivateStrategy; induced kernel on M × Θ; extension to full Δ Ω when needed.
Used by: [profile-payoff-decomposition-aligned, profile-payoff-decomposition-misaligned, menu-value-equivalence, sigma-star-realization-and-optimality]
Modeling notes: Keep a lemma proving equivalence with full strategies for the robust objective. Do not silently replace the paper’s full strategy space.

misaligned-adviser-kernel-space

English name: Misaligned adviser kernel space
Informal type: Borel Markov kernels β : M → Δ M mapping a source posterior to a distribution over reported messages.
Suggested Lean modeling: structure for measurable Markov kernels.
Key fields / operations: β(dm | s); deterministic Dirac kernels; product measure τ ⊗ β; second marginal; support predicates.
Used by: [misaligned-payoff, mixture-message-law, is-adversarial, epsilon-adversary-realization, exact-adversary-attainment, menu-Hall-support-implies-exact-adversary]
Modeling notes: Do not impose absolute continuity with respect to τ. Null-message dust is explicitly allowed.

private-payoff-functional

English name: Private-strategy payoff at a belief
Informal type: Expected payoff of a private strategy under belief μ after integrating over states, conditional types, and randomized actions.
Suggested Lean modeling: def
Key fields / operations: PrivatePayoff : PrivateStrategy → Belief Ω → ℝ; IsBayesOptimal hatσ μ := ∀ hatσ', PrivatePayoff hatσ' μ ≤ PrivatePayoff hatσ μ.
Used by: [Bayes-optimality-belief-correspondence-Bm, per-message-Bayes-optimality, definition2-qae-predicate]
Modeling notes: Keep separate from full robust payoff.

aligned-payoff

English name: Aligned payoff
Informal type: The payoff of an agent strategy when the adviser is aligned and reports truthfully.
Suggested Lean modeling: def
Key fields / operations: AlignedPayoff σ := E_id,σ[u]; profile form ∫_M s · wσ(s) τ(ds).
Used by: [mixture-payoff, profile-payoff-decomposition-aligned, mixture-payoff-decomposition, menu-value-equivalence]
Modeling notes: This is independent of β.

misaligned-payoff

English name: Misaligned payoff against a kernel
Informal type: The payoff of an agent strategy when the misaligned adviser uses kernel β.
Suggested Lean modeling: def
Key fields / operations: MisalignedPayoff β σ := E_β,σ[u]; profile form ∫_M ∫_M s · wσ(m) β(dm|s) τ(ds).
Used by: [mixture-payoff, profile-payoff-decomposition-misaligned, adversary-infimum-pointwise, exact-adversary-attainment]
Modeling notes: This is the misaligned component only, not the full mixture payoff.

mixture-payoff

English name: Full mixture payoff against a fixed adversary
Informal type: The payoff against a specific misaligned kernel, including both aligned and misaligned regimes.
Suggested Lean modeling: def
Key fields / operations: MixturePayoff β σ := α * AlignedPayoff σ + (1 - α) * MisalignedPayoff β σ.
Used by: [robust-payoff, is-adversarial, epsilon-adversary-realization, exact-adversary-attainment, menu-Hall-support-implies-exact-adversary]
Modeling notes: Every downstream adversary-attainment statement should compare this object to RobustPayoff σ and U_star.

robust-payoff

English name: Robust payoff of an agent strategy
Informal type: Worst-case full mixture payoff over misaligned kernels.
Suggested Lean modeling: def
Key fields / operations: RobustPayoff σ := ⨅ β, MixturePayoff β σ; equivalent expression α * AlignedPayoff σ + (1 - α) * ⨅ β, MisalignedPayoff β σ.
Used by: [U-star, is-adversarial, sigma-star-realization-and-optimality, tier1a-value-optimality-and-epsilon-adversary]
Modeling notes: Use sInf or iInf depending on the chosen kernel indexing.

U-star

English name: Robust value
Informal type: Supremum of robust payoff over agent strategies.
Suggested Lean modeling: def
Key fields / operations: U_star := ⨆ σ, RobustPayoff σ; menu equivalent ⨆ C ∈ 𝒦(W), F C.
Used by: [menu-value-equivalence, sigma-star-realization-and-optimality, epsilon-adversary-realization, exact-adversary-attainment, menu-Hall-support-implies-exact-adversary]
Modeling notes: Do not define via a full strategy-space minimax theorem.

is-adversarial

English name: Adversarial kernel predicate
Informal type: Predicate saying a kernel attains the worst-case full mixture payoff against σ.
Suggested Lean modeling: def returning Prop
Key fields / operations: IsAdversarial β σ := MixturePayoff β σ = RobustPayoff σ, equivalently MixturePayoff β σ = ⨅ β', MixturePayoff β' σ.
Used by: [definition2-qae-predicate, exact-adversary-attainment, menu-Hall-support-implies-exact-adversary, tier2-qae-robust-rationalizability-under-menu-Hall]
Modeling notes: This is the formal replacement for ambiguous U_against.

mixture-message-law

English name: Mixture message marginal
Informal type: For a misaligned kernel β, the marginal law of observed messages under the mixture of truthful aligned reporting and misaligned reporting.
Suggested Lean modeling: def
Key fields / operations: q_β := α • τ + (1 - α) • (τ ⊗ β)_2; domination α • τ ≤ q_β; restriction to dust sets.
Used by: [q-dominates-tau-when-alpha-pos, posterior-disintegration, definition2-qae-predicate, wta-no-free-dust]
Modeling notes: This is the “underlying distribution” for Definition 2 in infinite M.

posterior-disintegration

English name: Bayesian posterior after a message
Informal type: Regular conditional posterior over Ω after observing message m under the mixture law induced by β or γα.
Suggested Lean modeling: def plus theorem-backed existence, likely up to a.e. equivalence.
Key fields / operations: Pβ : M → Belief Ω; Pγα : M → Belief Ω; defined q-a.e.; conditional source barycenter representation.
Used by: [definition2-qae-predicate, menu-Hall-posterior-calibration-unpack, per-message-Bayes-optimality, dust-conditional-sources-satisfy-cones]
Modeling notes: Since Ω is finite, posteriors can be represented coordinatewise by conditional expectations or barycenters.

definition2-qae-predicate

English name: Definition 2 q-a.e. robust rationalizability predicate
Informal type: The infinite-space reading of Definition 2 as a predicate on (β, σ): β is adversarial against σ and σ is Bayes-optimal after qβ-almost every message.
Suggested Lean modeling: def returning Prop
Key fields / operations: Definition2QAEPredicate β σ := IsAdversarial β σ ∧ ∀ᵐ m ∂q_β, IsBayesOptimal (section σ m) (Pβ m).
Used by: [tier2-qae-robust-rationalizability-under-menu-Hall]
Modeling notes: Do not prove this as an ordinary measure-theory theorem. It is the chosen formal reading of the paper’s infinite-space convention.

payoff-profile-set-W

English name: Payoff-profile set
Informal type: The set W ⊆ ℝ^Ω of state-contingent payoff profiles implementable by private strategies.
Suggested Lean modeling: def plus bundled compact convex subtype.
Key fields / operations: w(ω) = E[u(a,ω,θ) | ω]; membership witness private strategy; convex combinations; compactness.
Used by: [payoff-profile-set-compact-convex, profile-realization-setup, compact-menu-space, WTA-payoff-vertices-and-mixed-labels]
Modeling notes: Compactness is imported from profile geometry, not derived from elementary simplex compactness alone.

profile-realization-setup

English name: Profile realization setup
Informal type: Bundled geometric theorem/hypotheses for the private-kernel space and profile map.
Suggested Lean modeling: structure
Key fields / operations: topology and measurable structure on PrivateStrategy; compactness of private-kernel space; Φ : PrivateStrategy → W; continuity of Φ; surjectivity onto W; nonempty compact fibers; measurable/Borel structure on fibers; right-inverse selection prerequisites.
Used by: [payoff-profile-set-compact-convex, profile-map-has-borel-right-inverse, borel-profile-map-implemented-by-agent-strategy]
Modeling notes: This is the patched replacement for the scattered private-strategy-space implicit assumption.

agent-profile-map

English name: Agent strategy profile map
Informal type: For a restricted agent strategy σ, the measurable map wσ : M → W assigning the payoff profile induced by the message-m private strategy.
Suggested Lean modeling: def
Key fields / operations: profileMap σ m : Ω → ℝ; membership in W; measurability; payoff identity s · profileMap σ m.
Used by: [profile-payoff-decomposition-aligned, profile-payoff-decomposition-misaligned, adversary-infimum-pointwise, menu-value-equivalence]
Modeling notes: This is the bridge from strategy kernels to finite-dimensional menu geometry.

profile-realization-map

English name: Profile realization right inverse
Informal type: A Borel map R : W → PrivateStrategy selecting a private strategy that realizes each payoff profile.
Suggested Lean modeling: def supplied by theorem.
Key fields / operations: R; Measurable R; Φ (R w) = w; implementation of Borel maps M → W as agent strategies.
Used by: [profile-map-has-borel-right-inverse, borel-profile-map-implemented-by-agent-strategy, menu-value-le-strategy-sup, sigma-star-realization-and-optimality]
Modeling notes: Split existence of R from use of R to implement agent strategies.

compact-menu-space

English name: Compact menu space
Informal type: 𝒦(W), the nonempty compact subsets of W with Hausdorff metric.
Suggested Lean modeling: subtype of nonempty compact sets; possible reuse of compact-set APIs.
Key fields / operations: membership w ∈ C; nonemptiness; compactness; Hausdorff distance; hyperspace topology.
Used by: [compact-menu-space-compact, menu-functional-F, optimal-menu-exists, closure-pruning-value-preservation]
Modeling notes: Nonempty menus only, since max and min over menus are required.

menu-functional-F

English name: Menu value functional
Informal type: Functional on compact menus:
F(C) = ∫_M [α max_{w∈C} s·w + (1-α) min_{w∈C} s·w] τ(ds).
Suggested Lean modeling: def
Key fields / operations: maxPayoff C s; minPayoff C s; integral over τ; Hausdorff continuity.
Used by: [strategy-value-le-menu-sup, menu-value-le-strategy-sup, menu-value-equivalence, optimal-menu-exists, closure-pruning-value-preservation]
Modeling notes: Finite-dimensionality of Ω makes s·w continuous.

optimal-menu-Cstar

English name: Optimal compact menu
Informal type: A maximizer C* ∈ 𝒦(W) of F.
Suggested Lean modeling: existential theorem witness or local chosen object under classical choice.
Key fields / operations: Cstar_nonempty; Cstar_compact; ∀ C, F C ≤ F Cstar; F Cstar = U_star.
Used by: [aligned-best-labeling-selection, closure-pruning-value-preservation, sigma-star-realization-and-optimality]
Modeling notes: Prefer theorem-local existential packaging to global choice unless downstream code wants named data.

aligned-best-labeling-wstar

English name: Aligned-best labeling
Informal type: A Borel selector w* : M → C* satisfying w*(m) ∈ argmax_{w∈C*} m·w.
Suggested Lean modeling: def plus selection theorem.
Key fields / operations: wstar; measurability; membership in C*; argmax equality.
Used by: [closure-pruning-value-preservation, sigma-star-realization-and-optimality, rowwise-contact-correspondence-G, epsilon-contact-correspondence-Geps]
Modeling notes: The representative matters because C† = closure(w*(M)).

pruned-menu-Cdagger

English name: Closure-pruned menu
Informal type: C† := closure (w*(M)), a compact subset of C*.
Suggested Lean modeling: def as a compact-menu object.
Key fields / operations: Cdagger ⊆ Cstar; closure/density of w*(M); value preservation F Cdagger = F Cstar; rowwise minimum over C†.
Used by: [closure-pruning-value-preservation, Geps-nonempty, exact-adversary-attainment, menu-Hall-support-implies-exact-adversary]
Modeling notes: This is the realized menu behind σ*.

rowwise-contact-correspondence-G

English name: Rowwise exact contact set
Informal type: For source posterior s, the messages whose selected labels attain the C† rowwise minimum.
Suggested Lean modeling: def as a set-valued correspondence.
Key fields / operations: G(s) := {m : s · w*(m) = min_{z∈C†} s · z}; graph; support condition.
Used by: [exact-contact-selector-unpack, kernel-supported-on-G, menu-Hall-assumption, exact-adversary-attainment, menu-Hall-support-implies-exact-adversary]
Modeling notes: Exact-contact asserts measurable selection from this correspondence. Menu-Hall asserts a kernel supported on it.

epsilon-contact-correspondence-Geps

English name: ε-contact correspondence
Informal type: For ε > 0, messages whose selected labels are within ε of the rowwise minimum.
Suggested Lean modeling: def as a set-valued correspondence.
Key fields / operations: Gε(s) := {m : s·w*(m) ≤ min_{z∈C†} s·z + ε}; nonempty sections; graph measurability; Borel selector.
Used by: [Geps-nonempty, Geps-graph-measurable, Geps-selector-exists, epsilon-adversary-realization]
Modeling notes: Selector existence must be Borel or otherwise admissible for the kernel space. JvN alone gives only universal measurability.

exact-contact-assumption

English name: Exact-contact assumption
Informal type: For τ-a.e. source posterior s, G(s) is nonempty and admits a measurable selector.
Suggested Lean modeling: Prop
Key fields / operations: existence of mstar : M → M; measurability; ∀ᵐ s ∂τ, mstar s ∈ G(s).
Used by: [exact-contact-selector-unpack, exact-adversary-attainment, per-message-Bayes-optimality, tier1b-exact-adversary-under-exact-contact, tier2-qae-robust-rationalizability-under-menu-Hall]
Modeling notes: This is a Tier 1b and Tier 2 hypothesis, not standing.

exact-adversary-kernel

English name: Deterministic exact-contact adversary
Informal type: Kernel induced by an exact-contact selector: β*(·|s) = δ_{m*(s)}.
Suggested Lean modeling: def
Key fields / operations: deterministic Dirac kernel; measurability; rowwise exact minimization.
Used by: [exact-adversary-attainment]
Modeling notes: This deterministic kernel is not the Tier 2 adversary unless κ happens to be deterministic.

kernel-supported-on-G

English name: Kernel support on exact contact
Informal type: Predicate saying a kernel κ sends τ-a.e. source posterior s only to exact-contact messages.
Suggested Lean modeling: def returning Prop
Key fields / operations: KernelSupportedOnG κ := ∀ᵐ s ∂τ, κ(s)(G(s)) = 1; equivalent support-inclusion formulation.
Used by: [menu-Hall-assumption, menu-Hall-support-implies-exact-adversary, menuHall-adversary-kernel-identity]
Modeling notes: This patch makes the previously inline reference into a named predicate.

menuHall-adversary-kernel

English name: Menu-Hall adversary kernel
Informal type: The specific kernel κ supplied by menu-Hall and chosen as the Tier 2 adversary.
Suggested Lean modeling: local object or projection from a MenuHall structure.
Key fields / operations: κ : AdviserKernel; βstar := κ; q_κ; γα; q = q_κ = (γα)_2; support on G; posterior calibration.
Used by: [menuHall-adversary-kernel-identity, menu-Hall-support-implies-exact-adversary, tier2-qae-robust-rationalizability-under-menu-Hall]
Modeling notes: This directly addresses the Tier 2 identity: the rationalizing adversary is κ, not the deterministic selector.

menu-Hall-assumption

English name: Menu-Hall calibration assumption
Informal type: There exists a kernel κ supported on G(s) τ-a.e. such that the mixture posterior lies in the Bayes-optimality belief set B(m) q-a.e.
Suggested Lean modeling: structure or Prop with existential kernel.
Key fields / operations: κ; KernelSupportedOnG κ; γα := α(id,id)#τ + (1-α) τ⊗κ; q := (γα)_2; posterior Pγα; calibration ∀ᵐ m ∂q, Pγα m ∈ B(m).
Used by: [menuHall-adversary-kernel-identity, menu-Hall-posterior-calibration-unpack, menu-Hall-support-implies-exact-adversary, per-message-Bayes-optimality, tier2-qae-robust-rationalizability-under-menu-Hall]
Modeling notes: It is set-valued: κ may mix over G(s).

mixture-coupling-gamma-alpha

English name: Mixture source-message coupling
Informal type: The joint law of source posterior and reported message under aligned truth-telling plus the menu-Hall kernel κ.
Suggested Lean modeling: def
Key fields / operations: γα := α • (id,id)#τ + (1 - α) • (τ ⊗ κ); first marginal; second marginal q; equality q = q_κ.
Used by: [menuHall-adversary-kernel-identity, menu-Hall-posterior-calibration-unpack, per-message-Bayes-optimality, support-function-integrated-Hall-equivalence]
Modeling notes: This is the canonical posterior law for Tier 2.

Bayes-optimality-belief-correspondence-Bm

English name: Bayes-optimality belief correspondence
Informal type: For each message m, the set of beliefs under which σ*’s private strategy at m is Bayes-optimal.
Suggested Lean modeling: def as M → Set (Belief Ω)
Key fields / operations: B(m) := {μ : IsBayesOptimal (hatσstar m) μ}; optional closed convex values and measurability for support-function form.
Used by: [menu-Hall-assumption, menu-Hall-posterior-calibration-unpack, per-message-Bayes-optimality, support-function-pointwise-membership-equivalence]
Modeling notes: The positive Tier 2 proof uses membership only. Support-function structure is quarantined as auxiliary.

support-function-Hall-form

English name: Support-function form of menu-Hall
Informal type: Inequality formulation of posterior calibration using support functions of B(m).
Suggested Lean modeling: Prop
Key fields / operations: support function h_{B(m)}(φ); event quantification over measurable E ⊆ M; continuous affine tests φ : Belief Ω → ℝ; integrated inequality.
Used by: [support-function-pointwise-membership-equivalence, support-function-integrated-Hall-equivalence]
Modeling notes: This is not used in the main positive Tier 2 DAG.

rowwise-support

English name: WTA rowwise-support predicate
Informal type: Predicate saying an adversarial kernel is supported on rowwise minimizers for the dust label map.
Suggested Lean modeling: def returning Prop
Key fields / operations: RowwiseSupport κ wN := ∀ᵐ s ∂τ, κ(s)-a.e. messages m satisfy the rowwise-minimizer cone condition associated with wN(m).
Used by: [dust-conditional-sources-satisfy-cones, wta-no-free-dust]
Modeling notes: This is a separate predicate, not an inline phrase inside no-free-dust.

Bayes-cone-calibration

English name: WTA Bayes-cone calibration predicate
Informal type: Predicate saying dust conditional source barycenters lie in the Bayes-optimality cone corresponding to the dust label support.
Suggested Lean modeling: def returning Prop
Key fields / operations: BayesConeCalibration N wN κ := ∀ᵐ m ∂q_N, barycenter(ρ_m) ∈ B_{I(m)}.
Used by: [dust-conditional-sources-satisfy-cones, wta-no-free-dust]
Modeling notes: This patch separates the calibration object used by no-free-dust.

WTA-ternary-environment

English name: Winner-takes-all ternary sharpness environment
Informal type: Specialized WTA model with three states, three pure actions, symmetric prior, and atomless full-support τ for sharpness.
Suggested Lean modeling: structure or namespace constants over Fin 3.
Key fields / operations: Ω = Fin 3; actions a0,a1,a2; payoff 1 on matching state and -1 otherwise; prior μ0 = (1/3,1/3,1/3); atomless τ for no-free-dust.
Used by: [WTA-payoff-dot-product-identity, WTA-rowwise-minimizer-and-Bayes-cone-identification, wta-cone-intersection, wta-no-free-dust, halfspace-witness-menu-engine-artifact]
Modeling notes: Separate from the general model. It is a sharpness witness.

WTA-payoff-vertices-and-mixed-labels

English name: WTA vertex profiles and mixed labels
Informal type: Vertex payoff profiles v_i and mixed profile labels w_λ.
Suggested Lean modeling: def
Key fields / operations: v_i(j) = 1 if i=j, -1 otherwise; w_λ := ∑ i, λ i • v_i; support I = {i : λ i > 0}; dot-product identity.
Used by: [WTA-payoff-dot-product-identity, WTA-rowwise-minimizer-and-Bayes-cone-identification, halfspace-induced-effective-menu-equals-full-vertices]
Modeling notes: Use finite sums over Fin 3.

WTA-cones-Kminus-and-B

English name: WTA rowwise-minimizer and Bayes-optimality cones
Informal type: For nonempty I ⊆ {0,1,2}, rowwise minimizer cone K_I^- and Bayes cone B_I.
Suggested Lean modeling: def
Key fields / operations: Kminus I := {s : ∀ i∈I, ∀ k, s_i ≤ s_k}; Bcone I := {p : ∀ i∈I, ∀ k, p_i ≥ p_k}.
Used by: [WTA-rowwise-minimizer-and-Bayes-cone-identification, wta-cone-intersection, dust-conditional-sources-satisfy-cones]
Modeling notes: All quantification is finite.

null-dust-data

English name: Null-message dust data
Informal type: A τ-null Borel message set N, a Borel dust labeling wN : N → W, and a measurable support encoding for mixed WTA labels.
Suggested Lean modeling: structure
Key fields / operations: N : Set M; Borel measurability; τ(N)=0; wN; λ(m); I(m)=support λ(m); support nonempty; ∀ i∈I(m), 0 < λ_i(m); ∑ λ_i(m)=1.
Used by: [dust-disintegration, dust-conditional-sources-satisfy-cones, wta-no-free-dust]
Modeling notes: May require finite partition by supports to avoid measurability headaches.

adversarial-flow-disintegration-data

English name: Adversarial flow and dust disintegration
Informal type: The measure flow induced by ν(ds,dm)=τ(ds)κ(dm|s), its restriction to dust, second marginal, and conditional source laws.
Suggested Lean modeling: structure produced by disintegration theorem.
Key fields / operations: ν; ν_N; q_N := (ν_N)_2; conditional kernels ρ_m; barycenter bar_s(m); disintegration identity.
Used by: [dust-disintegration, dust-conditional-sources-satisfy-cones, cone-intersection-applied-to-dust, dust-positive-mass-forces-mu0-atom]
Modeling notes: This is the measure-theoretic engine of no-free-dust.

halfspace-witness-trust-region

English name: Halfspace trust-region witness
Informal type: The WTA halfspace T := {μ : μ(0) ≤ 0.4} used in the menu-engine witness.
Suggested Lean modeling: def
Key fields / operations: membership predicate; witness beliefs (0.4,0.3,0.3), (0.1,0.8,0.1), (0.1,0.1,0.8); plurality labels.
Used by: [halfspace-contains-beliefs-inducing-all-vertices, halfspace-witness-menu-engine-artifact]
Modeling notes: The boundary value 0.4 is not formalized as a primitive obstruction.

effective-menu-equivalence-data

English name: Effective menu equivalence data
Informal type: Data showing the halfspace trust region induces the full WTA vertex menu and the same behavior as the full simplex.
Suggested Lean modeling: structure or theorem-local data.
Key fields / operations: induced menu; full vertex set {v0,v1,v2}; plurality continuation; off-T projection behavior; equivalence relation on behavior.
Used by: [halfspace-induced-effective-menu-equals-full-vertices, halfspace-behavior-equivalent-to-full-simplex, halfspace-witness-menu-engine-artifact]
Modeling notes: Formalize behavioral equivalence, not rhetoric about primitive counterexamples.

halfspace-behavioral-equivalence-predicates

English name: Halfspace behavioral equivalence predicates
Informal type: Precise predicates replacing prose “menu-engine artefact.”
Suggested Lean modeling: def returning Prop
Key fields / operations: ContainsBeliefsForAllVertices T; InducedEffectiveMenu T = {v0,v1,v2}; BehaviorEquivalent T FullSimplex; optional documentation wrapper MenuEngineArtifact T.
Used by: [halfspace-contains-beliefs-inducing-all-vertices, halfspace-induced-effective-menu-equals-full-vertices, halfspace-behavior-equivalent-to-full-simplex, halfspace-witness-menu-engine-artifact]
Modeling notes: Do not formalize ¬ PrimitiveCounterexampleCertified as a theorem unless a precise project predicate already exists.

Main Theorem

Slug: robust-trust-infinite-extension-v8-package

Statement (English, precise):
Under the standing Robust Trust hypotheses and the explicit profile-realization and posterior-law consistency objects, the infinite-M, Θ extension is a package of six theorem declarations:

tier1a-value-optimality-and-epsilon-adversary: there exists a restricted agent strategy σ* realized by the menu engine such that RobustPayoff σ* = U_star; for every ε > 0, there exists a Borel adversary kernel βε with
MixturePayoff βε σ* ≤ RobustPayoff σ* + (1 - α) * ε, hence MixturePayoff βε σ* ≤ U_star + ε.

tier1b-exact-adversary-under-exact-contact: under exact-contact, there exists a deterministic exact-contact kernel β* such that
IsAdversarial β* σ* and
MixturePayoff β* σ* = ⨅ β, MixturePayoff β σ* = U_star.

tier2-qae-robust-rationalizability-under-menu-Hall: under exact-contact and menu-Hall, take the Tier 2 adversary to be the menu-Hall kernel κ; set βstar := κ; then
q = q_κ = (γα)_2,
IsAdversarial κ σ*,
MixturePayoff κ σ* = U_star, and
Definition2QAEPredicate κ σ*. If α > 0, the Bayes-optimality part also holds τ-a.e. by domination.

wta-cone-intersection: in WTA ternary, for every nonempty support I, if a Borel probability ρ is supported on K_I^- and has barycenter in B_I, then ρ = δ_{μ0}.

wta-no-free-dust: in WTA ternary with atomless τ, no τ-null dust set, Borel dust label, and adversarial kernel can simultaneously have positive mixture dust mass, rowwise minimizer support, and Bayes-cone calibration.

halfspace-witness-menu-engine-artifact: in the WTA halfspace witness, the precise behavioral facts hold: T contains beliefs inducing all three WTA vertices; its induced effective menu is exactly {v0,v1,v2}; the resulting continuation behavior is equivalent to the full-simplex trust region.

Type signature (informal):
For model : RobustTrustModel with ProfileRealizationSetup model and posterior-law consistency, produce the Tier 1a existence object and ε-adversaries. Add ExactContact for Tier 1b. Add MenuHall for Tier 2 with βstar = κ. Separately, for WTA_TernaryEnvironment, prove cone intersection, no-free-dust under atomless τ, and the halfspace behavioral-equivalence package.

Depends on (objects): [robust-trust-model, posterior-law-consistency-field, message-restriction-bridge, restricted-agent-strategy-space-on-M, aligned-payoff, misaligned-payoff, mixture-payoff, robust-payoff, U-star, is-adversarial, mixture-message-law, posterior-disintegration, definition2-qae-predicate, payoff-profile-set-W, profile-realization-setup, compact-menu-space, menu-functional-F, optimal-menu-Cstar, aligned-best-labeling-wstar, pruned-menu-Cdagger, rowwise-contact-correspondence-G, exact-contact-assumption, kernel-supported-on-G, menuHall-adversary-kernel, menu-Hall-assumption, mixture-coupling-gamma-alpha, Bayes-optimality-belief-correspondence-Bm, WTA-ternary-environment, WTA-payoff-vertices-and-mixed-labels, WTA-cones-Kminus-and-B, null-dust-data, adversarial-flow-disintegration-data, halfspace-witness-trust-region, halfspace-behavioral-equivalence-predicates]

Depends on (lemmas): [tier1a-value-optimality-and-epsilon-adversary, tier1b-exact-adversary-under-exact-contact, tier2-qae-robust-rationalizability-under-menu-Hall, wta-cone-intersection, wta-no-free-dust, halfspace-witness-menu-engine-artifact]

Depends on (external): [profile-geometry-import, krn-borel-right-inverse, fubini-tonelli-kernel-integrals, kernel-infimum-epsilon-selection, hyperspace-blaschke-compactness, geps-borel-selector-upgrade, standard-borel-disintegration, bayes-posterior-as-conditional-barycenter, nonnegative-integral-zero, atomless-singleton-null]

Lemmas
posterior-law-barycenter-identities

Statement: The posterior-law consistency field implies that τ has barycenter μ₀ and that, for each state coordinate ω, the finite measure of state-ω sources is represented by s(ω) τ(ds). Consequently the posterior after observing the adviser posterior s is s itself τ-a.e.
Type signature: From posterior-law-consistency-field, prove barycenter τ = μ0 and coordinate finite-measure identities μ0(ω) • π ω = (fun s => s ω) • τ.
Depends on (objects): [robust-trust-model, finite-state-and-belief-simplex, posterior-law-consistency-field]
Depends on (lemmas): []
Depends on (external): [bayes-posterior-as-conditional-barycenter]
Notes: Project glue, not ordinary simplex algebra alone.

strategy-restriction-to-M

Statement: Every full agent strategy on Δ Ω × Θ restricts to a measurable restricted agent strategy on M × Θ.
Type signature: σFull : AgentStrategyFull → ∃ σM : AgentStrategyM, σM.section m = σFull.sectionFull (incl m).
Depends on (objects): [agent-strategy-space, restricted-agent-strategy-space-on-M, message-support-M, message-restriction-bridge]
Depends on (lemmas): []
Depends on (external): []
Notes: Pure measurability/subtype restriction.

outside-M-messages-irrelevant

Statement: Values of a full agent strategy on messages outside M do not affect aligned payoff, misaligned payoff after restriction to M-supported adversaries, mixture payoff, robust payoff, or U*.
Type signature: If two full strategies agree on M, then their restricted robust objectives coincide.
Depends on (objects): [agent-strategy-space, restricted-agent-strategy-space-on-M, message-support-M, message-restriction-bridge, aligned-payoff, misaligned-payoff, mixture-payoff, robust-payoff]
Depends on (lemmas): [strategy-restriction-to-M]
Depends on (external): [fubini-tonelli-kernel-integrals]
Notes: This prevents proving a theorem about the wrong message space.

adversary-kernels-restrict-to-M

Statement: For the robust objective, the infimum over adversarial kernels into the full message space Δ Ω equals the infimum over Borel kernels into M.
Type signature: ⨅ βFull, MixturePayoffFull βFull σ = ⨅ βM, MixturePayoff βM (restrict σ).
Depends on (objects): [message-support-M, message-restriction-bridge, misaligned-adviser-kernel-space, mixture-payoff, robust-payoff]
Depends on (lemmas): [outside-M-messages-irrelevant]
Depends on (external): [kernel-infimum-epsilon-selection]
Notes: Formalizes the paper’s wlog restriction to M.

q-dominates-tau-when-alpha-pos

Statement: For every adversarial kernel β, if α > 0, then q_β dominates τ in the sense that every q_β-null set is τ-null. Hence any qβ-a.e. predicate holds τ-a.e.
Type signature: 0 < α → (∀ᵐ m ∂q_β, P m) → (∀ᵐ m ∂τ, P m).
Depends on (objects): [mixture-message-law]
Depends on (lemmas): []
Depends on (external): []
Notes: This is the domination lemma required by the q-a.e. reading of Definition 2.

payoff-profile-set-compact-convex

Statement: The payoff-profile set W is a compact convex subset of Ω → ℝ, and the profile map from private strategies is surjective onto W.
Type signature: IsCompact W ∧ Convex ℝ W ∧ Surjective Φ.
Depends on (objects): [robust-trust-model, type-action-payoff-primitives, private-strategy-space, payoff-profile-set-W, profile-realization-setup]
Depends on (lemmas): []
Depends on (external): [profile-geometry-import]
Notes: Compactness/profile realization is a specialist imported theorem, not mere Mathlib glue.

profile-map-has-borel-right-inverse

Statement: The continuous surjective profile map Φ : PrivateStrategy → W with compact nonempty fibers admits a Borel right inverse R : W → PrivateStrategy.
Type signature: ∃ R, Measurable R ∧ ∀ w ∈ W, Φ (R w) = w.
Depends on (objects): [profile-realization-setup, profile-realization-map, payoff-profile-set-W]
Depends on (lemmas): [payoff-profile-set-compact-convex]
Depends on (external): [krn-borel-right-inverse]
Notes: First half of the split profile-realization result.

borel-profile-map-implemented-by-agent-strategy

Statement: Every Borel map wMap : M → W is implemented by a measurable restricted agent strategy using the Borel right inverse R.
Type signature: Measurable wMap → ∃ σ, profileMap σ = wMap.
Depends on (objects): [profile-realization-map, restricted-agent-strategy-space-on-M, agent-profile-map, message-support-M]
Depends on (lemmas): [profile-map-has-borel-right-inverse]
Depends on (external): []
Notes: Second half of the split profile-realization result.

profile-payoff-decomposition-aligned

Statement: For any restricted agent strategy σ with profile map wσ, the aligned payoff equals ∫_M s · wσ(s) τ(ds).
Type signature: AlignedPayoff σ = ∫ s, dot s (profileMap σ s) ∂τ.
Depends on (objects): [aligned-payoff, agent-profile-map, restricted-agent-strategy-space-on-M, posterior-law-consistency-field]
Depends on (lemmas): [posterior-law-barycenter-identities]
Depends on (external): [fubini-tonelli-kernel-integrals]
Notes: Conditional independence and posterior-law consistency are used here.

profile-payoff-decomposition-misaligned

Statement: For any restricted agent strategy σ and adversary kernel β, the misaligned payoff equals ∫_M ∫_M s · wσ(m) β(dm|s) τ(ds).
Type signature: MisalignedPayoff β σ = ∫ s, ∫ m, dot s (profileMap σ m) ∂β s ∂τ.
Depends on (objects): [misaligned-payoff, misaligned-adviser-kernel-space, agent-profile-map, restricted-agent-strategy-space-on-M]
Depends on (lemmas): [posterior-law-barycenter-identities]
Depends on (external): [fubini-tonelli-kernel-integrals]
Notes: This isolates the misaligned-only component.

mixture-payoff-decomposition

Statement: The full payoff against a fixed kernel decomposes as α * aligned profile integral + (1-α) * misaligned profile integral.
Type signature: MixturePayoff β σ = α * AlignedPayoff σ + (1 - α) * MisalignedPayoff β σ, with both profile identities substituted.
Depends on (objects): [mixture-payoff, aligned-payoff, misaligned-payoff]
Depends on (lemmas): [profile-payoff-decomposition-aligned, profile-payoff-decomposition-misaligned]
Depends on (external): []
Notes: This is the payoff API root used by all adversary lemmas.

adversary-infimum-pointwise

Statement: For any bounded measurable profile map w : M → W, the infimum of the misaligned profile integral over Borel kernels equals the integral of rowwise infima over messages:
inf_β ∫∫ s·w(m) β(dm|s) τ(ds) = ∫ inf_m s·w(m) τ(ds).
Type signature: For bounded measurable g(s,m)=s·w(m), ⨅ β, ∫∫ g s m ∂β s ∂τ = ∫ s, ⨅ m, g s m ∂τ.
Depends on (objects): [misaligned-adviser-kernel-space, agent-profile-map, message-support-M]
Depends on (lemmas): [profile-payoff-decomposition-misaligned]
Depends on (external): [fubini-tonelli-kernel-integrals, kernel-infimum-epsilon-selection]
Notes: Exact minimizers are not required. ε-selectors suffice.

strategy-value-le-menu-sup

Statement: Every restricted agent strategy σ generates a compact menu closure Cσ := closure (range wσ) such that RobustPayoff σ ≤ F(Cσ) ≤ sup_C F(C).
Type signature: ∀ σ, RobustPayoff σ ≤ ⨆ C : 𝒦(W), F C.
Depends on (objects): [robust-payoff, agent-profile-map, compact-menu-space, menu-functional-F]
Depends on (lemmas): [mixture-payoff-decomposition, adversary-infimum-pointwise]
Depends on (external): [measurable-maximum-and-argmax-selection]
Notes: One direction of menu-value equivalence.

menu-value-le-strategy-sup

Statement: For every nonempty compact menu C, an aligned-best Borel labeling into C can be realized by an agent strategy σC with F(C) ≤ RobustPayoff σC.
Type signature: ∀ C : 𝒦(W), F C ≤ U_star.
Depends on (objects): [compact-menu-space, menu-functional-F, profile-realization-map, robust-payoff, U-star]
Depends on (lemmas): [borel-profile-map-implemented-by-agent-strategy, adversary-infimum-pointwise]
Depends on (external): [measurable-maximum-and-argmax-selection]
Notes: Other direction of menu-value equivalence.

menu-value-equivalence

Statement: The robust value equals the supremum of the menu functional over nonempty compact menus:
U_star = ⨆ C : 𝒦(W), F C.
Type signature: U_star model = sSup {F C | C : 𝒦(W)}.
Depends on (objects): [U-star, compact-menu-space, menu-functional-F]
Depends on (lemmas): [strategy-value-le-menu-sup, menu-value-le-strategy-sup]
Depends on (external): []
Notes: Split into two directions per reviewer request.

compact-menu-space-compact

Statement: If W is compact metric, then 𝒦(W) is compact under Hausdorff distance.
Type signature: CompactSpace (NonemptyCompactSubsets W with HausdorffMetric).
Depends on (objects): [payoff-profile-set-W, compact-menu-space]
Depends on (lemmas): [payoff-profile-set-compact-convex]
Depends on (external): [hyperspace-blaschke-compactness]
Notes: Marked as local glue unless Mathlib’s compact-set Hausdorff APIs are confirmed.

menu-extrema-Hausdorff-Lipschitz

Statement: For each belief s, the maps C ↦ max_{w∈C} s·w and C ↦ min_{w∈C} s·w are Lipschitz in Hausdorff distance, with a finite-dimensional norm constant.
Type signature: |maxPayoff C s - maxPayoff D s| ≤ L * dH C D, and similarly for minima.
Depends on (objects): [finite-state-and-belief-simplex, compact-menu-space, menu-functional-F]
Depends on (lemmas): []
Depends on (external): [hausdorff-support-function-lipschitz]
Notes: The source’s “1-Lipschitz” depends on norm convention.

menu-functional-continuity

Statement: The menu functional F : 𝒦(W) → ℝ is continuous in Hausdorff distance.
Type signature: Continuous F.
Depends on (objects): [compact-menu-space, menu-functional-F]
Depends on (lemmas): [menu-extrema-Hausdorff-Lipschitz]
Depends on (external): [fubini-tonelli-kernel-integrals]
Notes: Boundedness gives integrability; Lipschitz extrema give continuity.

optimal-menu-exists

Statement: The supremum of F over 𝒦(W) is attained by some compact menu C*.
Type signature: ∃ Cstar : 𝒦(W), ∀ C : 𝒦(W), F C ≤ F Cstar.
Depends on (objects): [compact-menu-space, menu-functional-F, optimal-menu-Cstar]
Depends on (lemmas): [compact-menu-space-compact, menu-functional-continuity]
Depends on (external): [weierstrass-extreme-value]
Notes: This is menu existence.

aligned-best-labeling-selection

Statement: For an optimal menu C*, there exists a Borel selector w* : M → C* such that w*(m) maximizes m·w over C*.
Type signature: ∃ wstar, Measurable wstar ∧ ∀ m, wstar m ∈ Cstar ∧ IsArgMax (fun w => dot m w) Cstar (wstar m).
Depends on (objects): [message-support-M, optimal-menu-Cstar, aligned-best-labeling-wstar]
Depends on (lemmas): [optimal-menu-exists]
Depends on (external): [measurable-maximum-and-argmax-selection]
Notes: Selector is fixed before defining C†.

closure-pruning-value-preservation

Statement: Let C† := closure (w*(M)). Then C† ⊆ C* and F(C†) = F(C*) = U_star.
Type signature: For selected wstar, define Cdagger; prove subset and value equality.
Depends on (objects): [aligned-best-labeling-wstar, pruned-menu-Cdagger, menu-functional-F, U-star]
Depends on (lemmas): [menu-value-equivalence, optimal-menu-exists, aligned-best-labeling-selection]
Depends on (external): [weierstrass-extreme-value]
Notes: Aligned term unchanged; misaligned term weakly rises; optimality forces equality.

sigma-star-realization-and-optimality

Statement: The selected labeling w* : M → C† is realized by an agent strategy σ*, and σ* attains the robust value: RobustPayoff σ* = U_star.
Type signature: ∃ σstar, profileMap σstar = wstar ∧ RobustPayoff σstar = U_star.
Depends on (objects): [restricted-agent-strategy-space-on-M, profile-realization-map, aligned-best-labeling-wstar, pruned-menu-Cdagger, robust-payoff, U-star]
Depends on (lemmas): [borel-profile-map-implemented-by-agent-strategy, menu-value-equivalence, closure-pruning-value-preservation]
Depends on (external): []
Notes: This constructs the Tier 1a optimal strategy before adversaries.

Geps-nonempty

Statement: For every ε > 0 and every source posterior s, the ε-contact set Gε(s) is nonempty.
Type signature: ε > 0 → ∀ s : M, (Gε ε s).Nonempty.
Depends on (objects): [epsilon-contact-correspondence-Geps, pruned-menu-Cdagger, aligned-best-labeling-wstar]
Depends on (lemmas): [closure-pruning-value-preservation]
Depends on (external): []
Notes: Uses density of w*(M) in C† and continuity of dot products.

Geps-graph-measurable

Statement: For each ε > 0, the graph {(s,m) : m ∈ Gε(s)} is Borel or has the stronger selectable regularity required by the Borel selector theorem.
Type signature: ε > 0 → MeasurableSet {p : M × M | p.2 ∈ Gε ε p.1}.
Depends on (objects): [epsilon-contact-correspondence-Geps, aligned-best-labeling-wstar, pruned-menu-Cdagger]
Depends on (lemmas): []
Depends on (external): []
Notes: This is separated from selector existence.

Geps-selector-exists

Statement: For every ε > 0, there exists an admissible Borel selector mε : M → M with mε(s) ∈ Gε(s) for every s or τ-a.e. s as required by the kernel construction.
Type signature: ε > 0 → ∃ mε, Measurable mε ∧ ∀ s, mε s ∈ Gε ε s.
Depends on (objects): [epsilon-contact-correspondence-Geps, misaligned-adviser-kernel-space]
Depends on (lemmas): [Geps-nonempty, Geps-graph-measurable]
Depends on (external): [jankov-von-neumann-universal-selection, geps-borel-selector-upgrade]
Notes: JvN alone yields universal measurability. The Borel upgrade or an equivalent admissibility theorem is explicit here.

epsilon-adversary-realization

Statement: For every ε > 0, the deterministic kernel βε(·|s)=δ_{mε(s)} satisfies
MixturePayoff βε σ* ≤ RobustPayoff σ* + (1 - α) * ε, hence MixturePayoff βε σ* ≤ U_star + ε.
Type signature: ε > 0 → ∃ βε : AdviserKernel, MixturePayoff βε σstar ≤ RobustPayoff σstar + (1 - α) * ε ∧ MixturePayoff βε σstar ≤ U_star + ε.
Depends on (objects): [epsilon-contact-correspondence-Geps, misaligned-adviser-kernel-space, mixture-payoff, robust-payoff, U-star]
Depends on (lemmas): [sigma-star-realization-and-optimality, Geps-selector-exists, mixture-payoff-decomposition]
Depends on (external): [fubini-tonelli-kernel-integrals]
Notes: Restated in terms of MixturePayoff, not ambiguous U_against.

exact-contact-selector-unpack

Statement: Exact-contact gives a Borel selector m* : M → M such that m*(s) ∈ G(s) for τ-a.e. s.
Type signature: ExactContact → ∃ mstar, Measurable mstar ∧ ∀ᵐ s ∂τ, mstar s ∈ G s.
Depends on (objects): [exact-contact-assumption, rowwise-contact-correspondence-G]
Depends on (lemmas): []
Depends on (external): []
Notes: Unpacking a hypothesis.

exact-adversary-attainment

Statement: Under exact-contact, the deterministic kernel induced by the exact-contact selector is adversarial and attains the full mixture infimum:
MixturePayoff β* σ* = ⨅ β, MixturePayoff β σ* = U_star.
Type signature: ExactContact → ∃ βstar, IsAdversarial βstar σstar ∧ MixturePayoff βstar σstar = RobustPayoff σstar ∧ RobustPayoff σstar = U_star.
Depends on (objects): [exact-contact-assumption, exact-adversary-kernel, rowwise-contact-correspondence-G, mixture-payoff, robust-payoff, U-star, is-adversarial]
Depends on (lemmas): [sigma-star-realization-and-optimality, exact-contact-selector-unpack, closure-pruning-value-preservation, mixture-payoff-decomposition]
Depends on (external): [fubini-tonelli-kernel-integrals]
Notes: Includes the equality chain required by the source theorem.

menuHall-adversary-kernel-identity

Statement: Under menu-Hall, the Tier 2 adversary is the menu-Hall kernel κ, and the message marginal used in Definition 2 is exactly both q_κ and (γα)_2.
Type signature: MenuHall κ → βstar = κ ∧ q = q_κ ∧ q = secondMarginal γα.
Depends on (objects): [menuHall-adversary-kernel, menu-Hall-assumption, mixture-message-law, mixture-coupling-gamma-alpha]
Depends on (lemmas): []
Depends on (external): []
Notes: This prevents accidental substitution of the deterministic exact-contact selector in Tier 2.

menu-Hall-posterior-calibration-unpack

Statement: Under menu-Hall, the disintegration posterior induced by γα satisfies Pγα(m) ∈ B(m) for q-a.e. m.
Type signature: MenuHall κ → ∀ᵐ m ∂q, Pγα m ∈ Bm m.
Depends on (objects): [menu-Hall-assumption, mixture-coupling-gamma-alpha, posterior-disintegration, Bayes-optimality-belief-correspondence-Bm]
Depends on (lemmas): [menuHall-adversary-kernel-identity]
Depends on (external): [standard-borel-disintegration]
Notes: This is the calibration half of menu-Hall.

menu-Hall-support-implies-exact-adversary

Statement: If the menu-Hall kernel κ is supported on G(s), then κ is an exact adversary for σ* in the full mixture payoff sense, and its mixture payoff equals U*.
Type signature: KernelSupportedOnG κ → IsAdversarial κ σstar ∧ MixturePayoff κ σstar = U_star.
Depends on (objects): [kernel-supported-on-G, menuHall-adversary-kernel, rowwise-contact-correspondence-G, mixture-payoff, robust-payoff, U-star, is-adversarial]
Depends on (lemmas): [sigma-star-realization-and-optimality, closure-pruning-value-preservation, mixture-payoff-decomposition]
Depends on (external): [fubini-tonelli-kernel-integrals]
Notes: This is the patched Tier 2 adversary-attainment statement: κ, not the deterministic selector.

per-message-Bayes-optimality

Statement: Under exact-contact and menu-Hall, σ*’s private strategy is Bayes-optimal under Pγα(m) for q-a.e. m. If α > 0, it is also Bayes-optimal τ-a.e.
Type signature: ExactContact → MenuHall κ → (∀ᵐ m ∂q, IsBayesOptimal (hatσstar m) (Pγα m)) ∧ (0 < α → ∀ᵐ m ∂τ, IsBayesOptimal (hatσstar m) (Pγα m)).
Depends on (objects): [exact-contact-assumption, menu-Hall-assumption, Bayes-optimality-belief-correspondence-Bm, posterior-disintegration, definition2-qae-predicate]
Depends on (lemmas): [menu-Hall-posterior-calibration-unpack, q-dominates-tau-when-alpha-pos]
Depends on (external): []
Notes: The exact-contact hypothesis is retained to match the source theorem, even though the membership step itself is menu-Hall driven.

support-function-pointwise-membership-equivalence

Statement: For closed convex nonempty values B(m), a belief p lies in B(m) iff every continuous affine functional φ is bounded above by the support function of B(m) at φ.
Type signature: p ∈ B m ↔ ∀ φ, φ p ≤ h_{B(m)} φ.
Depends on (objects): [Bayes-optimality-belief-correspondence-Bm, support-function-Hall-form]
Depends on (lemmas): []
Depends on (external): [support-function-pointwise-separation]
Notes: Auxiliary finite-dimensional convex analysis.

support-function-integrated-Hall-equivalence

Statement: Under the additional measurability, closed-convex, and nonempty-value hypotheses for B(m), posterior calibration Pγα(m) ∈ B(m) q-a.e. is equivalent to the support-function Hall inequalities over measurable events and continuous affine tests.
Type signature: PosteriorCalibration γα B q ↔ SupportFunctionHallInequalities γα B q.
Depends on (objects): [support-function-Hall-form, mixture-coupling-gamma-alpha, Bayes-optimality-belief-correspondence-Bm]
Depends on (lemmas): [support-function-pointwise-membership-equivalence]
Depends on (external): [support-function-measurable-integrated-separation, bayes-posterior-as-conditional-barycenter]
Notes: Auxiliary and outside the main positive Tier 2 DAG.

tier1a-value-optimality-and-epsilon-adversary

Statement: Under standing hypotheses, there exists σ* with RobustPayoff σ* = U_star; for every ε > 0, there exists a Borel kernel βε with MixturePayoff βε σ* ≤ U_star + ε.
Type signature: ∃ σstar, RobustPayoff σstar = U_star ∧ ∀ ε > 0, ∃ βε, MixturePayoff βε σstar ≤ U_star + ε.
Depends on (objects): [robust-trust-model, profile-realization-setup, mixture-payoff, robust-payoff, U-star]
Depends on (lemmas): [menu-value-equivalence, optimal-menu-exists, aligned-best-labeling-selection, closure-pruning-value-preservation, sigma-star-realization-and-optimality, epsilon-adversary-realization]
Depends on (external): []
Notes: First component theorem of the package.

tier1b-exact-adversary-under-exact-contact

Statement: Under standing hypotheses plus exact-contact, there exists an exact adversarial kernel β* with
MixturePayoff β* σ* = ⨅ β, MixturePayoff β σ* = U_star.
Type signature: ExactContact → ∃ βstar, IsAdversarial βstar σstar ∧ MixturePayoff βstar σstar = U_star.
Depends on (objects): [exact-contact-assumption, exact-adversary-kernel, mixture-payoff, robust-payoff, U-star, is-adversarial]
Depends on (lemmas): [tier1a-value-optimality-and-epsilon-adversary, exact-adversary-attainment]
Depends on (external): []
Notes: Second component theorem.

tier2-qae-robust-rationalizability-under-menu-Hall

Statement: Under standing hypotheses plus exact-contact and menu-Hall, choose βstar := κ, the menu-Hall kernel. Then q = qκ = (γα)_2, κ is adversarial against σ*, MixturePayoff κ σ* = U_star, and Definition2QAEPredicate κ σ* holds. If α > 0, the Bayes-optimality condition also holds τ-a.e.
Type signature: ExactContact → MenuHall κ → βstar = κ ∧ IsAdversarial κ σstar ∧ MixturePayoff κ σstar = U_star ∧ Definition2QAEPredicate κ σstar ∧ (0 < α → τAE_BayesOptimal).
Depends on (objects): [exact-contact-assumption, menu-Hall-assumption, menuHall-adversary-kernel, mixture-message-law, mixture-coupling-gamma-alpha, definition2-qae-predicate, is-adversarial]
Depends on (lemmas): [menuHall-adversary-kernel-identity, menu-Hall-support-implies-exact-adversary, per-message-Bayes-optimality]
Depends on (external): []
Notes: Third component theorem. This is the corrected Tier 2 adversary identity.

WTA-payoff-dot-product-identity

Statement: In WTA ternary, for a mixed profile w_λ = ∑_{i∈I} λ_i v_i, s · w_λ = 2 * ∑_{i∈I} λ_i * s_i - 1.
Type signature: For λ : Fin 3 → ℝ, λ_i ≥ 0, ∑ λ_i = 1, prove the coordinate identity.
Depends on (objects): [WTA-ternary-environment, WTA-payoff-vertices-and-mixed-labels]
Depends on (lemmas): []
Depends on (external): []
Notes: Finite coordinate algebra.

WTA-rowwise-minimizer-and-Bayes-cone-identification

Statement: In WTA ternary, let I be nonempty and let λ satisfy support λ = I, ∀ i ∈ I, 0 < λ i, λ i = 0 outside I, and ∑ i, λ i = 1. Then the mixed label w_λ is a rowwise minimizer exactly for source beliefs in K_I^-, and is Bayes-optimal exactly for beliefs in B_I, with the appropriate iff statements.
Type signature: I.Nonempty → support λ = I → (∀ i∈I, 0 < λ i) → ∑ λ = 1 → (RowwiseMinimizer s wλ ↔ s ∈ Kminus I) ∧ (BayesOptimalWTA p wλ ↔ p ∈ Bcone I).
Depends on (objects): [WTA-ternary-environment, WTA-payoff-vertices-and-mixed-labels, WTA-cones-Kminus-and-B]
Depends on (lemmas): [WTA-payoff-dot-product-identity]
Depends on (external): [finite-dimensional-simplex-compactness]
Notes: Patch adds exact support and positive-weight hypotheses.

wta-cone-intersection

Statement: For every nonempty I ⊆ Fin 3, if ρ is a Borel probability on Δ Ω with ρ(K_I^-)=1 and barycenter in B_I, then ρ = δ_{μ0} where μ0=(1/3,1/3,1/3).
Type signature: I.Nonempty → ρ(Kminus I)=1 → barycenter ρ ∈ Bcone I → ρ = dirac μ0.
Depends on (objects): [WTA-ternary-environment, WTA-cones-Kminus-and-B]
Depends on (lemmas): [WTA-rowwise-minimizer-and-Bayes-cone-identification]
Depends on (external): [nonnegative-integral-zero]
Notes: Atomlessness is not a dependency here.

dust-disintegration

Statement: For ν(ds,dm)=τ(ds)κ(dm|s) and dust restriction ν_N, there exists a disintegration over the second marginal q_N, with conditional source laws ρ_m.
Type signature: ∃ ρ, ∀ A E, ν_N(A × E) = ∫_E ρ_m(A) q_N(dm).
Depends on (objects): [null-dust-data, adversarial-flow-disintegration-data]
Depends on (lemmas): []
Depends on (external): [standard-borel-disintegration]
Notes: First split of no-free-dust.

dust-conditional-sources-satisfy-cones

Statement: If the dust kernel satisfies RowwiseSupport κ wN and Bayes-cone calibration holds, then for q_N-a.e. dust message m, ρ_m(K_{I(m)}^-)=1 and barycenter(ρ_m) ∈ B_{I(m)}.
Type signature: RowwiseSupport κ wN → BayesConeCalibration N wN κ → ∀ᵐ m ∂q_N, ρ_m(Kminus (I m))=1 ∧ barycenter(ρ_m)∈Bcone(I m).
Depends on (objects): [rowwise-support, Bayes-cone-calibration, null-dust-data, adversarial-flow-disintegration-data, WTA-cones-Kminus-and-B]
Depends on (lemmas): [dust-disintegration, WTA-rowwise-minimizer-and-Bayes-cone-identification]
Depends on (external): [bayes-posterior-as-conditional-barycenter]
Notes: Converts economic support and calibration into cone-intersection hypotheses.

cone-intersection-applied-to-dust

Statement: Under the cone conditions from dust disintegration, ρ_m = δ_{μ0} for q_N-a.e. dust message m.
Type signature: ∀ᵐ m ∂q_N, ρ_m = dirac μ0.
Depends on (objects): [adversarial-flow-disintegration-data, WTA-ternary-environment]
Depends on (lemmas): [dust-conditional-sources-satisfy-cones, wta-cone-intersection]
Depends on (external): []
Notes: Third split of no-free-dust.

dust-positive-mass-forces-mu0-atom

Statement: If dust has positive mixture message mass and τ(N)=0, then the dust disintegration plus ρ_m=δ_{μ0} forces positive ν-mass on {μ0} × N, hence positive τ-mass on {μ0}.
Type signature: τ N = 0 → q_β(N) > 0 → α < 1 → (∀ᵐ m ∂q_N, ρ_m = δ μ0) → 0 < τ({μ0}).
Depends on (objects): [null-dust-data, adversarial-flow-disintegration-data, mixture-message-law, WTA-ternary-environment]
Depends on (lemmas): [cone-intersection-applied-to-dust]
Depends on (external): [fubini-tonelli-kernel-integrals]
Notes: This isolates the α<1 conversion; α=1 makes positive adversarial dust mass impossible.

wta-no-free-dust

Statement: Under atomless τ in WTA ternary, there do not exist τ-null dust data, a Borel dust labeling, and an adversarial kernel satisfying positive mixture dust mass, rowwise support, and Bayes-cone calibration.
Type signature: Atomless τ → ¬ ∃ N wN κ, TauNull N ∧ PositiveQMass N κ ∧ RowwiseSupport κ wN ∧ BayesConeCalibration N wN κ.
Depends on (objects): [WTA-ternary-environment, null-dust-data, rowwise-support, Bayes-cone-calibration, adversarial-flow-disintegration-data, mixture-message-law]
Depends on (lemmas): [dust-disintegration, dust-conditional-sources-satisfy-cones, cone-intersection-applied-to-dust, dust-positive-mass-forces-mu0-atom]
Depends on (external): [atomless-singleton-null]
Notes: Atomlessness appears here, not in wta-cone-intersection.

sharpness-corollary

Statement: Taking I={0} in the cone intersection theorem recovers the pointwise v7 obstruction at t0=(0.4,0.3,0.3), and no-free-dust rules out repairing it with τ-null dust.
Type signature: Specialized consequence for singleton support {0}.
Depends on (objects): [WTA-ternary-environment, WTA-cones-Kminus-and-B]
Depends on (lemmas): [wta-cone-intersection, wta-no-free-dust]
Depends on (external): []
Notes: Sharpness statement, not a positive-tier dependency.

halfspace-contains-beliefs-inducing-all-vertices

Statement: The halfspace T={μ : μ(0)≤0.4} contains beliefs whose WTA plurality labels induce each of the three vertex profiles.
Type signature: ∃ μ0T μ1T μ2T ∈ T, Label μ0T = v0 ∧ Label μ1T = v1 ∧ Label μ2T = v2.
Depends on (objects): [halfspace-witness-trust-region, WTA-ternary-environment, WTA-payoff-vertices-and-mixed-labels, halfspace-behavioral-equivalence-predicates]
Depends on (lemmas): []
Depends on (external): []
Notes: Coordinate checks using (0.4,0.3,0.3), (0.1,0.8,0.1), (0.1,0.1,0.8).

halfspace-induced-effective-menu-equals-full-vertices

Statement: Any plurality-vertex continuation on the halfspace T induces the effective menu {v0,v1,v2}.
Type signature: InducedEffectiveMenu T = {v0,v1,v2}.
Depends on (objects): [effective-menu-equivalence-data, halfspace-behavioral-equivalence-predicates, WTA-payoff-vertices-and-mixed-labels]
Depends on (lemmas): [halfspace-contains-beliefs-inducing-all-vertices]
Depends on (external): []
Notes: Formalizes the menu piece of the classification only.

halfspace-behavior-equivalent-to-full-simplex

Statement: Since the induced in-T menu is already the full WTA vertex menu, the off-T projection/continuation behavior is the same as ordinary plurality over the full simplex.
Type signature: BehaviorEquivalent T FullSimplexTrustRegion.
Depends on (objects): [effective-menu-equivalence-data, halfspace-behavioral-equivalence-predicates, halfspace-witness-trust-region]
Depends on (lemmas): [halfspace-induced-effective-menu-equals-full-vertices]
Depends on (external): []
Notes: This avoids formalizing “not a primitive counterexample” as a rhetoric-flavored theorem.

halfspace-witness-menu-engine-artifact

Statement: The halfspace witness satisfies the precise behavioral-equivalence package: it contains beliefs inducing all three vertices, its effective menu is the full vertex menu, and its behavior is equivalent to the full-simplex trust region.
Type signature: ContainsBeliefsForAllVertices T ∧ InducedEffectiveMenu T = {v0,v1,v2} ∧ BehaviorEquivalent T FullSimplexTrustRegion.
Depends on (objects): [halfspace-witness-trust-region, effective-menu-equivalence-data, halfspace-behavioral-equivalence-predicates]
Depends on (lemmas): [halfspace-contains-beliefs-inducing-all-vertices, halfspace-induced-effective-menu-equals-full-vertices, halfspace-behavior-equivalent-to-full-simplex]
Depends on (external): []
Notes: Sixth component theorem. “Menu-engine artefact” remains a documentation label over these precise propositions.

External Results Invoked
finite-dimensional-simplex-compactness

English name: Compact convex geometry of a finite-dimensional probability simplex
Statement used: For finite Ω, Δ Ω is compact and convex; coordinate functions and dot products are continuous; continuous affine functions attain extrema on compact subsets.
Classification: MATHLIB_CANDIDATE
Why this classification: Mathlib has finite-dimensional topology, convexity, compactness, and finite-sum APIs, though simplex glue may be needed.

measurable-maximum-and-argmax-selection

English name: Measurable maximum theorem and measurable argmax selection
Statement used: A measurable compact-valued correspondence with continuous objective admits a measurable selector from the argmax correspondence.
Classification: NON_MATHLIB
Why this classification: This is a specialist measurable-selection theorem, unlikely to be packaged directly in Mathlib.

profile-geometry-import

English name: Profile geometry theorem for private kernels
Statement used: The private-kernel space has a compact standard-Borel topology; the profile map Φ is continuous and onto W; fibers are nonempty compact; W is compact convex.
Classification: NON_MATHLIB
Why this classification: This is imported project geometry from the paper’s profile construction, not standard Mathlib convexity alone.

krn-borel-right-inverse

English name: Kuratowski-Ryll-Nardzewski Borel right inverse theorem
Statement used: A continuous map from a compact standard-Borel space onto W, with nonempty compact fibers, admits a Borel right inverse.
Classification: NON_MATHLIB
Why this classification: Specialist measurable-selection theorem.

fubini-tonelli-kernel-integrals

English name: Fubini/Tonelli and kernel integration identities
Statement used: Iterated integration against Markov kernels is valid and expected payoffs can be rearranged over states, types, actions, messages, and kernels.
Classification: MATHLIB_CANDIDATE
Why this classification: Mathlib has substantial measure-theory infrastructure, although local Markov-kernel wrappers may be needed.

kernel-infimum-epsilon-selection

English name: Rowwise infimum over Markov kernels via ε-selectors
Statement used: The infimum over measurable kernels of ∫∫ g(s,m) β(dm|s) τ(ds) equals ∫ inf_m g(s,m) τ(ds) for bounded measurable g, using measurable ε-minimizing selectors.
Classification: NON_MATHLIB
Why this classification: Combines measurable selection and kernel optimization in a domain-specific packaged theorem.

hyperspace-blaschke-compactness

English name: Blaschke compactness for nonempty compact subsets
Statement used: The hyperspace of nonempty compact subsets of a compact metric space is compact under Hausdorff distance.
Classification: NON_MATHLIB
Why this classification: This may be Mathlib-or-local-glue, but until compact-set Hausdorff APIs are confirmed it should be stubbed as local project glue.

hausdorff-support-function-lipschitz

English name: Hausdorff Lipschitz continuity of support extrema
Statement used: Maxima and minima of a bounded linear functional over compact sets vary Lipschitz-continuously with Hausdorff distance.
Classification: MATHLIB_CANDIDATE
Why this classification: Elementary metric and finite-dimensional linear analysis.

weierstrass-extreme-value

English name: Extreme value theorem on compact spaces
Statement used: A continuous real-valued function on a compact space attains maximum and minimum.
Classification: MATHLIB_CANDIDATE
Why this classification: Standard Mathlib theorem.

jankov-von-neumann-universal-selection

English name: Jankov-von Neumann universally measurable selection theorem
Statement used: An analytic or Borel graph with nonempty sections in standard Borel spaces admits a universally measurable selector.
Classification: NON_MATHLIB
Why this classification: Specialist descriptive-set result, and it does not by itself give a Borel selector.

geps-borel-selector-upgrade

English name: Borel selector theorem for the ε-contact correspondence
Statement used: The specific Gε correspondence has enough strengthened regularity to admit an admissible Borel selector, or the kernel space has been widened so the selected universally measurable map is admissible.
Classification: NON_MATHLIB
Why this classification: This is the exact patch needed beyond ordinary JvN and should be explicitly audited.

standard-borel-disintegration

English name: Disintegration theorem for standard Borel spaces
Statement used: A finite measure on a product of standard Borel spaces admits regular conditional probabilities over a marginal.
Classification: NON_MATHLIB
Why this classification: Full standard-Borel disintegration is specialist and generally stubbed in Lean projects.

bayes-posterior-as-conditional-barycenter

English name: Bayesian posterior as conditional barycenter
Statement used: For finite Ω, the posterior over states after a message equals the barycenter of the conditional distribution of source posteriors given that message.
Classification: NON_MATHLIB
Why this classification: This is project glue connecting the source-posterior process to Bayesian posteriors, even though finite-coordinate algebra follows after disintegration.

support-function-pointwise-separation

English name: Pointwise support-function characterization of closed convex membership
Statement used: In finite dimension, p ∈ C for a closed convex set C iff all continuous affine functionals at p are bounded by the support function of C.
Classification: MATHLIB_CANDIDATE
Why this classification: Finite-dimensional separation and convexity are plausible Mathlib material.

support-function-measurable-integrated-separation

English name: Measurable integrated support-function Hall equivalence
Statement used: The q-a.e. posterior membership condition for a measurable closed-convex correspondence is equivalent to the integrated support-function inequalities over measurable events.
Classification: NON_MATHLIB
Why this classification: The measurable-correspondence and integrated inequality version is specialist.

nonnegative-integral-zero

English name: Nonnegative function with nonpositive expectation vanishes a.e.
Statement used: If X ≥ 0 a.e. and ∫ X dρ ≤ 0, then X=0 a.e.
Classification: MATHLIB_CANDIDATE
Why this classification: Standard measure-theory lemma.

atomless-singleton-null

English name: Atomless measures assign zero mass to singletons
Statement used: Under atomless τ, τ({μ0})=0; this contradicts positive mass forced by dust calibration.
Classification: MATHLIB_CANDIDATE
Why this classification: Standard measure-theory result.

Implicit Assumptions Surfaced

A is nonempty.

Θ is nonempty.

M = supp τ is nonempty.

W is nonempty.

𝒦(W) is nonempty, which follows from nonempty W but should still be explicit for Lean.

α ∈ [0,1]; the implication from q-a.e. to τ-a.e. additionally requires α > 0.

In no-free-dust, the conversion from qβ(N)>0 and τ(N)=0 to q_N(N)>0 requires α < 1; when α=1, positive adversarial dust mass is impossible.

All strategy, profile, and kernel maps are Borel measurable, and all payoff integrands are measurable and integrable.

M is treated as a compact or at least standard-Borel support subspace of Δ Ω.

Bayes-plausibility/posterior-law consistency tying π, μ0, and τ is required as an explicit field or imported theorem.

The compact standard-Borel topology on private kernels, continuity of Φ, compact nonempty fibers, and surjectivity onto W are bundled in ProfileRealizationSetup; they are not automatic from the primitive statement.

The ε-contact selector must be Borel-admissible or the kernel space must allow the measurability actually delivered by selection. JvN alone gives only universal measurability.

Misaligned kernels are not assumed absolutely continuous with respect to τ.

Regular conditional posteriors are defined only up to the relevant message marginal, so posterior claims must be a.e. claims.

The support-function Hall form requires additional nonempty closed convex q-a.e. values of B(m), measurability of the correspondence, and a convention for empty values if emptiness is allowed.

Dust labels require a measurable encoding of λ(m) and I(m), or equivalently a measurable finite partition by possible supports.

Atomlessness of τ is used only in wta-no-free-dust, not in wta-cone-intersection.

The aligned-best selector w* must be fixed before defining C† = closure(w*(M)).

The equality inf_{m∈M} s·w*(m) = min_{z∈C†} s·z uses density of w*(M) in C† and continuity of the dot product.

The deterministic exact-contact adversary and the menu-Hall kernel κ are both exact adversaries under their hypotheses, but they need not be the same kernel.

Decomposition Notes

The patched DAG has four layers.

First, the model and measurability layer explicitly separates full-message strategies on Δ Ω from restricted strategies on M. The bridge lemmas ensure that the menu engine proves the original paper objective rather than a silently modified model.

Second, the payoff layer is split into AlignedPayoff, MisalignedPayoff, MixturePayoff, RobustPayoff, U_star, and IsAdversarial. All adversary statements now use MixturePayoff, so the comparison with U_star is type-correct and unambiguous.

Third, the positive menu-engine layer proves value optimality, ε-adversaries, exact-contact adversaries, and menu-Hall robust rationalizability. Tier 2 explicitly sets βstar := κ and q = qκ = (γα)_2. The deterministic exact-contact selector is not smuggled into Tier 2.

Fourth, the WTA sharpness layer is split into coordinate algebra, cone identification with exact support hypotheses, cone intersection, dust disintegration, cone application, atom contradiction, and the final no-free-dust theorem. The halfspace witness is formalized only through precise behavioral-equivalence claims.

The support-function Hall equivalence is retained as an auxiliary theorem outside the positive Tier 2 DAG. It should not block formalization of the posterior-membership version of menu-Hall.
