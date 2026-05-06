# Consolidator pass — Branch A capstone: existence of an optimal $\sigma^*$

You are the Consolidator in the soft-scaffolding workflow.

## Your job

Assemble Branch A — Lemmas L1–L7 of `phil_reny_route_memo.md` — into a
single clean proof report establishing the **existence-of-an-optimal-agent-strategy**
half of the Theorem 2 infinite-extension under the standing hypotheses
plus (A5).

Write the narrative for a mathematician who has *not* read the
intermediate logs. The route memo, prover responses, and reviewer passes
are all available as durable sources.

## Inputs (durable sources)

- `phil_reny_route_memo.md` — live route memo with all PROVED statuses
  and (A5) recorded.
- `phil_reny_bundle.md` — Phil's contribution + Balder/Mertens précis.
- `prior_attempts_digest.md` — what was tried before; the dead-route list.
- `Robust_trust_Dworczak_Smolin.pdf` — original paper, definitive
  notation.
- `objective_statement.md` — original objective.

## Target

A clean **proof report** for Branch A. The output is a single self-contained
markdown document. It is *not* a re-derivation of every lemma — those
are reviewer-cleared and on file. It is a coherent **narrative** that
states the final theorem, names the lemmas it rests on, sketches each
proof in 1–3 sentences with the right citation, and is honest about
what remains for Branch B.

## Output Format (use this exactly)

```markdown
# Proof Report — Branch A: Existence of an optimal agent strategy in the infinite Robust-Trust game

## Original Claim

(State the original Theorem 2 existence direction from Dworczak–Smolin
2026, including the finite-$M$, finite-$\Theta$ qualifier.)

## Best Current Result

**Theorem (Branch A capstone).** Under the standing hypotheses of
Dworczak–Smolin (2026) — $\Omega$ finite with full-support prior $\mu_0$,
$A$ and $\Theta$ compact metric, $u$ bounded and continuous in $a$,
conditional independence of $s$ and $\theta$ given $\omega$ — and the
**added assumption (A5): $\pi(\cdot\mid\omega) \sim \tau$ for every
$\omega$** (mutual absolute continuity of the state-conditional posterior
laws), there exists $\sigma^*\in\Sigma$ achieving
$U(\sigma^*) = U^* := \sup_{\sigma\in\Sigma}\,\inf_{\beta\in B}\,U(\beta,\sigma)$.

(State the theorem cleanly. Include the precise value-securing
inequality.)

## Relationship to the Original Claim

(Compare exactly. Branch A proves the "existence of an optimal $\sigma^*$"
half of Theorem 2 — i.e., $\sigma^*$ achieves the sup-inf — under
(A5). It does NOT yet establish:
- existence of an adversarial $\beta^*\in B$ that attains $\inf_\beta U(\beta,\sigma^*)$;
- per-message Bayes-optimality of $\hat\sigma^*$ at every on-path $m\in M$
  (the Definition 2 condition).
Both gaps are Branch B and remain open.)

## Strategy

(One paragraph: Phil Reny's two-stage strategy. (Stage 1) Restrict the
adversary to $\tau$-dominated kernels $\beta_\varphi(dm\mid s) = \varphi(m\mid s)\,\tau(dm)$
with $\varphi\in F$; on the restricted game, the constant-marginal
Balder topology makes $U_F$ continuous in $\sigma$, $\Sigma$ is compact,
and Mertens (1986) Cor B + affineness yields $\sigma^*$ achieving
$V^* = \max_\sigma\inf_\varphi U_F$. (Stage 2) Lift the restriction via
Lusin regularization: on a Lusin-thick compact sequence $K_n\uparrow K^*$,
$\sigma^*$ is continuous and support-thick. Any unrestricted measurable
deviation can be approximated by a $\tau$-dominated density preserving
the message payoff up to $\varepsilon$. The trick is the **constant
marginal** + **support-thickness**, which is where (A5) enters.)

## Definitions and Notation

(Only what the reader needs to follow Section "Proof Body": the model,
$\Sigma$, $B$, $F$, $U$, $U^*$, $\bar f$, $\lambda = \tau\otimes\bar f$,
$T_\lambda$, $K_n$, $K^*$, $\sigma^*$, $V^*$.)

## Proof Body

### Lemma L1 (constant-marginal continuity)

Statement: ...
Proof sketch: (1–3 sentences citing Balder Theorem 2.2, p. 268.)

### Lemma L2 (compactness of $\Sigma$)

Statement: ...
Proof sketch: (Single-base $T_\lambda$, Balder §2 Theorem 2.3(a),
common-kernel extraction via finite mixture + standard-Borel disintegration
+ correctly-directed RN multiplications.)

### Lemma L7 ($\theta$ in the base)

Statement: ...
Proof sketch: (Verification only; $\theta$ measurable factor of base,
no continuity needed.)

### Lemma L3+L4 (Mertens minmax + restricted-game existence)

Statement: ...
Proof sketch: (Mertens (1986) Cor B; affineness collapses both
mixed-strategy sides; u.s.c. + compact attainment for $\sigma^*$.)

### Lemma L5 (Lusin-thick compacts under (A5))

Statement: ...
Proof sketch: (Polish-valued Lusin on $h:M\to Y$ → $C_n$; common-support
$K_n = \operatorname{supp}(\tau\restriction C_n)$ under (A5) gives
support-thickness simultaneously for all $\pi(\cdot\mid\omega)$;
modification of $\sigma^*$ off $K^*$ via measurable retraction.)

### Lemma L6 (Lusin lift)

Statement: ...
Proof sketch: (Smoothing kernel $q_\varepsilon$ shell-by-shell; uniform
continuity of $p_\omega$ on $K_n$; Tonelli-composition with stochastic
$\beta$ gives $\varphi_\varepsilon\in F$; pointwise + integrated bound.)

### Main Result (Branch A capstone)

Proof:
- $V^* \ge U^*$: $F\hookrightarrow B$ via $\beta_\varphi$, so
  $\inf_\varphi U_F(\sigma,\varphi) \ge \inf_\beta U(\beta,\sigma)$ for
  every $\sigma$, hence $\sup_\sigma\inf_\varphi U_F \ge \sup_\sigma\inf_\beta U$.
  *(Wait — verify the direction. F is a subset of B, but as Borel kernels
  not as functions; the inclusion is via $\varphi\mapsto\beta_\varphi$.
  So {$U_F(\sigma,\varphi):\varphi\in F$} is a subset of {$U(\beta,\sigma):\beta\in B$},
  and inf over a smaller set is ≥ inf over a larger set. Yes the
  direction is correct.)*
- L6: $\inf_\beta U(\beta,\sigma^*) \ge V^*$.
- $U(\sigma^*) = \alpha\,\mathbb E_{\mathrm{id},\sigma^*}[u] + (1-\alpha)\,\inf_\beta\mathbb E_{\beta,\sigma^*}[u] = \inf_\beta U(\beta,\sigma^*) \ge V^*$.
  And since $V^* \ge U^*$ and $U^* \ge U(\sigma^*)$ trivially,
  $U(\sigma^*) = U^* = V^*$.

## Assumptions Used

- Original (standing) assumptions: $\Omega$ finite with full-support
  prior $\mu_0$; $A$ and $\Theta$ compact metric; $u$ bounded and
  continuous in $a$; conditional independence of $s$ and $\theta$
  given $\omega$; Borel measurability throughout.
- Added assumption: **(A5)** $\pi(\cdot\mid\omega) \sim \tau$ for every
  $\omega\in\Omega$ (mutual absolute continuity of state-conditional
  posteriors). Forward direction $\pi(\cdot\mid\omega)\ll\tau$ is
  automatic from full-support $\mu_0$; only the reverse
  $\tau\ll\pi(\cdot\mid\omega)$ is new content. Required only for L5
  support-thickness (perfect-revelation counterexample shows necessity).

## Remaining Risks

- **Branch B is open.** Existence of $\beta^*\in B$ adversarial against
  $\sigma^*$ is NOT proved. Per-message Bayes-optimality at on-path $m$
  is NOT proved. The full Theorem 2 statement (robust rationalizability
  in the sense of Definition 2) requires both, and Phil's email
  acknowledges this gap.
- **(A5) is genuinely added.** It restricts the model class to those
  with mutually equivalent state-conditional posterior laws. Examples:
  any model where $f(\cdot\mid\omega)$ is a strictly positive density
  against a common reference. Examples violating (A5): perfect
  revelation, or any signal that fully reveals some $\omega$.

## Recommendation to the Orchestrator

(Move to Branch B. Recommend the next prover target — L8 (production of
$\beta^*$). Flag that L8 must NOT use the dead-route adversary-side
attainment in $\prod_\mu\Delta(M)$; suggest the candidate
hyperplane/transport construction the route memo's L8 entry mentions.
Also mention that publishing the Branch A result on its own (as
"existence of an optimal agent strategy in the infinite Robust-Trust
game under (A5)") would already be a clean partial result if Branch B
turns out to be unreachable.)
```

## Discipline

- Use paper-canonical notation throughout.
- Cite each lemma's reviewer-passing log file by name.
- Do not re-prove. Sketches are 1–3 sentences each.
- Be honest about (A5) and Branch B's open status.
- Length budget: 2000–3500 words.

## Scope Policy

This is a consolidator pass. Do not attempt L8, L9, or any new
mathematics. The deliverable is a clean writeup.
