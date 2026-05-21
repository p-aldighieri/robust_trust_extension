# Prover pass 03 — Lemma 12: Original-message lift (finite case)

## Role

You are the Prover. Lemmas 6 (patched), 7, and 8 are reviewer-PASS'd —
the **finite-menu Pareto-Hall calibration theorem** closes in payoff-
label coordinates. Now we need to lift the finite-label kernel back to
the original message space \(M\), so the conclusion becomes a statement
about the original-game adversarial kernel \(\hat\beta^*:M\to\Delta(M)\)
that Definition 2 requires.

Context: durable sources `prover_02_response.md` (Lemmas 7+8 proofs),
`prover_01_response.md` (Lemma 6 with patch note), `reviewer_01_response.md`
(L6 PATCH_SMALL), `reviewer_02_response.md` (L7+L8 PASS), and the
breakdown / route memo.

## Setup recap

Finite menu \(C^* = \{w_1,\ldots,w_k\}\subseteq W^P\). Borel labeling
\(w^*:M\to C^*\) defined by
\[
w^*(m) \;\in\; \arg\max_{w\in C^*}\,m\!\cdot\!w,
\]
with measurable selection on ties via KRN. The finite-label adversarial
kernel from Lemma 8 is
\[
\hat\kappa(\{i\}\mid s) \;:=\; \lambda^-_i(s), \quad s\in M, \; i\in\{1,\ldots,k\}.
\]

We need to construct a Borel **original-game adversarial message kernel**
\(\hat\beta^*:M\to\Delta(M)\), supported on the "rowwise-minimizer
messages" \(G(s) := \{m\in M : w^*(m)\in\arg\min_{w\in C^*}\,s\!\cdot\!w\}\),
such that the induced posterior \(P_{\hat\beta^*}(\cdot\mid m)\)
satisfies \(\hat\sigma^*(m)\) Bayes-optimal under \(P_{\hat\beta^*}(\cdot\mid m)\)
for \(q\)-a.e. \(m\) (Definition 2, infinite-space reading).

## Lemma 12 — Original-message lift

**Hypotheses.**
- (H1) Standing assumptions.
- (H2) Finite \(C^* = \{w_1,\ldots,w_k\}\subseteq W^P\) is a Pareto-
  completed ambient local maximizer of \(F_k\); calibration multipliers
  \(\lambda^\pm:M\to\Delta(k)\) and posterior \(p_i = g_i/q_i\in B_W(w_i)\)
  are as in Lemma 8.
- (H3) **Representative hypothesis (R):** for every \(i\in\{1,\ldots,k\}\)
  with \(q_i > 0\), the fiber \((w^*)^{-1}(\{w_i\}) := \{m\in M: w^*(m) = w_i\}\)
  is nonempty Borel. (This is the lift-feasibility condition; flag it
  as economically meaningful — it says each payoff label has at least
  one representative message.)

**Statement.** Under (H1)–(H3), there exists a Borel kernel
\(\hat\beta^*: M \to \Delta(M)\) with the following properties:

(a) **Support on rowwise minimizers.** For τ-a.e. \(s\in M\),
\(\hat\beta^*(\{m\}\mid s) > 0\) implies \(w^*(m)\in\arg\min_{w\in C^*}\,s\!\cdot\!w\).
Equivalently, \(\hat\beta^*(\cdot\mid s)\) is supported on \(G(s)\) τ-a.e.

(b) **Calibration on positive-mass labels.** Define
\(q := \alpha\,\tau + (1-\alpha)\,\tau\star\hat\beta^*\) (message marginal
of the joint distribution \(\gamma_\alpha = \alpha\,(\mathrm{id},\mathrm{id})_\#\tau + (1-\alpha)\,\tau\otimes\hat\beta^*\)).
Then the disintegration posterior on \(\Omega\),
\[
P_{\hat\beta^*}(\cdot\mid m) \;=\; \E_{\gamma_\alpha}[s\mid m\text{ observed}],
\]
satisfies \(P_{\hat\beta^*}(\cdot\mid m)\in B_W(w^*(m))\) for \(q\)-a.e. \(m\in M\).

(c) **Bayes-optimality of \(\hat\sigma^*\).** \(\hat\sigma^*(m) := R(w^*(m))\)
(where \(R\) is the profile-realization right inverse, paper §3) is
Bayes-optimal under \(P_{\hat\beta^*}(\cdot\mid m)\) for \(q\)-a.e. \(m\).

## Proof outline

The construction is **direct measurable selection + measure pushforward**.

### Step 1 — Per-label representative selector

For each \(i\) with \(q_i > 0\), apply KRN to the fiber
\((w^*)^{-1}(\{w_i\}) \cap M\) (nonempty by (H3), Borel since \(w^*\) is
Borel). Get a deterministic Borel selector \(m_i \in (w^*)^{-1}(\{w_i\})\).
(A single representative per label suffices in the finite case;
in the compact-menu lift it becomes a kernel.)

### Step 2 — Define the original-game kernel

Define
\[
\hat\beta^*(\cdot\mid s) \;:=\; \sum_{i=1}^k \lambda^-_i(s)\,\delta_{m_i}.
\]
Verify Borel measurability of \(s\mapsto\hat\beta^*(\cdot\mid s)\)
(follows from Borel measurability of \(\lambda^-_i\) and constancy of
\(m_i\)).

### Step 3 — Support on rowwise minimizers (verify (a))

For each \(s\), the support of \(\hat\beta^*(\cdot\mid s)\) is
\(\{m_i : \lambda^-_i(s) > 0\}\). By Lemma 8 / patched Lemma 6,
\(\operatorname{supp}\lambda^-(s)\subseteq\arg\min_j s\!\cdot\!w_j\) τ-a.e.
For such \(i\), \(w^*(m_i) = w_i\in\arg\min_j s\!\cdot\!w_j\), so
\(m_i\in G(s)\). QED.

### Step 4 — Compute the message marginal \(q\)

Compute \(q\) explicitly. The aligned term contributes
\(\alpha\,\tau\); the misaligned term contributes
\((1-\alpha)\,\sum_i [\int_M\lambda^-_i(s)\,\tau(ds)]\,\delta_{m_i} = (1-\alpha)\sum_i (q^-_i)\delta_{m_i}\)
where \(q^-_i := \int\lambda^-_i d\tau\).

Note: \(q\) has both a continuous part (\(\alpha\tau\)) and atomic part
(\((1-\alpha)\sum_i q^-_i \delta_{m_i}\)). The atomic part puts mass
\((1-\alpha)q^-_i\) on the representative \(m_i\) (for those \(i\) with
\(q^-_i > 0\)).

### Step 5 — Compute the posterior \(P_{\hat\beta^*}(\cdot\mid m)\)

Two cases for \(q\)-a.e. \(m\):

**Case A: \(m\notin\{m_1,\ldots,m_k\}\).** \(q\)-measure of such \(m\)
is \(\alpha\cdot\tau(M\setminus\{m_1,\ldots,m_k\}) = \alpha\) (assuming
representatives are τ-null, which holds if \(\tau\) is atomless OR if
\(m_i\) are chosen avoiding atoms of \(\tau\)). For such \(m\) (truthful
aligned source), the posterior is \(\delta_m\) on \(s = m\). Verify:
\(\hat\sigma^*(m) = R(w^*(m))\) is Bayes-optimal at \(\delta_m\) iff
\(w^*(m)\in\arg\max_{w\in W} m\cdot w\) — which holds by definition of
\(w^*\). So calibration (c) holds at \(m\in M\setminus\{m_i\}\).

**Case B: \(m = m_i\).** \(q(\{m_i\}) = \alpha\tau(\{m_i\}) + (1-\alpha)q^-_i\).
Disintegration: the conditional posterior over states given \(m = m_i\)
is the mixture of:
- aligned-truthful at \(s = m_i\) (weight \(\alpha\tau(\{m_i\})\)),
- misaligned at \(s\sim\lambda^-_i\cdot\tau/q^-_i\) (weight \((1-\alpha)q^-_i\)).

Compute the conditional barycenter of \(s\) given \(m = m_i\). Under
the assumption that \(\tau(\{m_i\}) = 0\) (representatives chosen
τ-null, or τ atomless), the aligned term vanishes and the posterior
equals
\[
\E[s\mid m = m_i] \;=\; \frac{\int s\,\lambda^-_i(s)\,\tau(ds)}{q^-_i}.
\]

Compare to \(p_i = g_i/q_i\) from Lemma 8. Recall
\(g_i = \alpha\int\lambda^+_i(s)s\,d\tau + (1-\alpha)\int\lambda^-_i(s)s\,d\tau\)
and \(q_i = \alpha\int\lambda^+_i d\tau + (1-\alpha)\int\lambda^-_i d\tau\).

This is NOT immediately equal to \(\int s\lambda^-_i d\tau / q^-_i\)
unless \(\alpha = 0\) or \(\lambda^+_i = \lambda^-_i\). **There is a
mismatch.** Spell it out: in the finite-label setting, the posterior
\(p_i\) from Lemma 8 was computed by collapsing aligned-and-misaligned
contributions to a single payoff label \(i\), via the aligned tie-routing
weights \(\lambda^+_i\). In the original-message lift, the aligned
contribution is at the actual truthful message \(s\), not at the
representative \(m_i\) — these are different messages.

**This is the structural issue with the finite-menu lift.** The
finite-label calibration in Lemma 8 assumed the aligned agent reacts
to the label \(i\) (not to the truthful belief \(s\)) — i.e., the
agent's "message space" in the reduced game is the label set. In the
original game, aligned-truthful and misaligned messages live in the
same space \(M\), and the agent reacts to the message, not the label.

### Step 6 — The resolution

Two paths:

**(I) Aligned messages distinct from misaligned representatives.** If
\(\tau(\{m_i\}) = 0\) for all \(i\) (e.g., τ atomless and \(m_i\)
chosen τ-null), then the aligned and misaligned messages have
disjoint \(q\)-support modulo a \(q\)-null set. The posterior splits:
- At \(m\in M\setminus\{m_i\}\) (aligned-only): \(P_{\hat\beta^*}(\cdot\mid m) = \delta_m\).
  Bayes-optimality of \(\hat\sigma^*(m) = R(w^*(m))\) at \(\delta_m\) iff
  \(w^*(m)\in\arg\max_W m\cdot w\). YES by definition.
- At \(m_i\) (misaligned-only): \(P_{\hat\beta^*}(\cdot\mid m_i) = \int s\lambda^-_i\,d\tau/q^-_i\).
  Bayes-optimality of \(\hat\sigma^*(m_i) = R(w_i)\) at this posterior
  requires the posterior to be in \(B_W(w_i)\).

The misaligned-only posterior \(\int s\lambda^-_i d\tau / q^-_i\) is
NOT the same as \(p_i = g_i/q_i\) but is closely related. Specifically,
\(p_i = (\alpha q^+_i \cdot \mu^+_i + (1-\alpha) q^-_i \cdot \mu^-_i) / q_i\),
where \(\mu^\pm_i := \int s\lambda^\pm_i d\tau / q^\pm_i\). So
\(\mu^-_i\) is the misaligned-only posterior.

**The right calibration claim for the original-message lift is:**
\(\mu^-_i \in B_W(w_i)\). Is this true?

By Lemma 7, \(g_i\in N_W(w_i)\), so
\(\alpha\int\lambda^+_i(s)s d\tau + (1-\alpha)\int\lambda^-_i(s)s d\tau \in N_W(w_i)\).
This does NOT immediately give the misaligned-only part \(\int\lambda^-_i s d\tau \in N_W(w_i)\)
— normal cones aren't generally closed under taking convex parts.

**There's a real issue here that needs care.** The prover should:
- Either prove that \(\int\lambda^-_i s d\tau\in N_W(w_i)\) using a separate
  argument (e.g., a second Clarke Fermat on the misaligned-term-only
  subobjective);
- Or identify a stronger primitive condition (e.g., \(\alpha = 0\),
  the pure-adversarial case) under which the issue dissolves.

**(II) Aligned messages share representatives.** If we allow \(m_i\)
to coincide with actual truthful messages (i.e., a typical
\(s\in M\) with \(w^*(s) = w_i\)), then the aligned-and-misaligned
contributions at \(m_i\) co-mingle. The disintegration posterior at
\(m_i\) becomes:
\[
P_{\hat\beta^*}(\cdot\mid m_i) \;=\; \frac{\alpha\delta_{m_i} + (1-\alpha)\int s\lambda^-_i d\tau / q^-_i}{\alpha + (1-\alpha)q^-_i/q^-_i}
\]
... actually this needs more care. The correct route: define \(m_i\)
NOT as a deterministic representative but via a measurable selector
from \(\arg\max_{m'\in(w^*)^{-1}(w_i)}\) (matching the aligned-side
distribution conditional on label \(i\)). Then aligned and misaligned
distributions at \(m_i\) match \(p_i\).

## What I want you to produce

Produce a careful proof that:

1. Identifies the precise hypothesis needed for the lift (likely (H3)
   plus an additional fiber-richness or matching condition).
2. Constructs the original-game kernel \(\hat\beta^*\) explicitly.
3. Verifies (a), (b), (c) RIGOROUSLY, handling the aligned/misaligned
   mismatch identified in Step 5–6.
4. Reports cleanly whether the lift closes UNCONDITIONALLY under (H1)–(H3),
   or requires an additional primitive hypothesis (e.g., \(\tau\)
   atomless, or representatives matching aligned conditional law, or
   a uniformity condition on \(\lambda^+, \lambda^-\)).
5. Compares the resulting hypothesis with v8's exact-contact + menu-Hall,
   and verifies it is meaningfully weaker (i.e., a primitive condition
   that does NOT presuppose the labeling \(w^*\) is calibrated, only
   that the fibers are nonempty / matched).

If the lift requires a strictly stronger condition than (H3) alone,
state it as a "(D2) condition" with name, and check it is still
strictly weaker than menu-Hall.

## Output Contract

- Return everything inline as plain markdown.
- Be honest about whether the lift closes; do not hand-wave.
- The aligned/misaligned mismatch at \(m_i\) is real — engage with it
  directly. The cleanest resolution may be: pick \(m_i\) so that the
  aligned-conditional-on-label-\(i\) distribution matches the
  misaligned-conditional-on-label-\(i\), via a measurable matching
  argument; or restrict to \(\alpha = 0\) (pure adversarial) where
  the issue dissolves; or impose τ atomless + null-representative
  trick.
- End with the one-line **verdict** (lift closes / closes-under-X /
  blocked) plus a **next-step signal**.

## Constraints

- Banned moves: see `prior_attempts_digest.md`.
- This is the lift step that has historically broken (closure memo:
  "label-fiber lift gap" in Routes 1/2). Be careful.
- If the lift requires a hypothesis that resurrects deletion-compatible
  Hall duality, flag it explicitly — that means the route has reached
  the same closed gate.
