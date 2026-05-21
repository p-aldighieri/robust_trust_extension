# Route memo — Piotr's Pareto-frontier-set reformulation of Theorem 2

*Author: orchestrator. Date: 2026-05-20. Status: live route, third pass at the
Theorem 2 infinite extension. This memo opens a new route distinct from v8 (the
menu engine) and from the Phil-Reny route. Read after `project_closure_memo.md`
and `prior_attempts_digest.md`. Filed alongside the existing route memos.*

## 0. Piotr's verbatim suggestion (2026-05-20)

> Instead of thinking of the Agent as selecting a mapping from private signals
> and messages of the Adviser to distributions over actions, we can think of
> the Agent as selecting a subset of the weak Pareto frontier of state-
> contingent payoffs, relying on Lemma 2 in the proof of Theorem 1. With some
> appropriate topology, the set of all feasible subsets is compact. The
> strategy of the misaligned Adviser is to map their signal into a state-
> contingent payoff vector in the set chosen by the Agent. And then hopefully
> it's a bit easier to establish the existence of optimal strategies. There
> are (at least) two challenges: 1) I think that we lose the linearity of
> Agent's payoffs in the strategy, which poses a challenge in using Sion's
> minimax theorem, and 2) there is some extra work to get to the original
> statement of the conjecture even if we establish existence of a saddle
> point in the proposed representation. Perhaps a successful approach is to
> combine the approaches, alternating between representations of the problem
> and using the existing results (most likely the proof of Theorem 1) that
> predict that certain properties of the Agent's strategy can be assumed
> wlog.

## 1. Lemma 2 of Theorem 1's proof (verbatim, paper p. 27)

**Lemma 2.** *Any optimal solution \(\sigma^*\) is equivalent to an optimal
solution that uses Bayes-optimal private strategies for all \(m\in\Delta(\Omega)\).*

The proof argues:

- \(W = \{w\in\R^{|\Omega|} : \exists\,\hat\sigma,\;w(\omega)=\E_{\hat\sigma}[u(a,\omega,\theta)\mid\omega]\}\)
  is **convex and compact** (private strategies form a convex set; \(\max_W \lambda\cdot w\)
  is attained by boundedness and the measurable maximum theorem).
- The **weak Pareto frontier** \(W^P = \{w\in W : \not\exists w'\in W\text{ with }w'(\omega)>w(\omega)\,\forall\omega\}\).
- By the supporting-hyperplane theorem, \(\hat\sigma\) is Bayes-optimal for
  *some* belief iff its payoff profile is in \(W^P\).
- If \(\sigma^*(m)\) is not Bayes-optimal at some \(m\), replace it by a
  Bayes-optimal dominator \(\hat\sigma'(m)\). Both the aligned term
  \(\hat\sigma(\mu)\!\cdot\!\mu\) and the misaligned term
  \(\inf_m \hat\sigma(m)\!\cdot\!\mu\) **pointwise weakly increase**, so the
  modified strategy is still optimal.

Lemma 2 says: **WLOG every optimal solution uses only profiles in \(W^P\).**

## 2. The reformulated game \(\mathcal G_P\) (Pareto-frontier set game)

Let \(W^P\subseteq W\) be the weak Pareto frontier of the payoff polytope.
Let \(\mathcal K(W^P)\) be the set of nonempty compact subsets of \(W^P\),
metrized by Hausdorff distance \(d_H\). Since \(W^P\) is compact metric,
\(\mathcal K(W^P)\) is **compact metric** by Blaschke's selection theorem.

**Players.**
- **Agent**: chooses \(C\in\mathcal K(W^P)\).
- **Misaligned adviser**: chooses a measurable map \(\beta : M\to W^P\) with
  \(\beta(s)\in C\) for \(\tau\)-a.e.\ \(s\). Equivalently, a measurable
  selector from the (closed) constant correspondence \(s\mapsto C\). Denote
  this set \(B(C)\).

**Payoff.**
\[
U_P(C,\beta) \;=\; \alpha\!\int_M \max_{w\in C} s\!\cdot\!w\,\tau(ds)
\;+\; (1-\alpha)\!\int_M s\!\cdot\!\beta(s)\,\tau(ds).
\]

**The agent maximizes \(\inf_{\beta\in B(C)} U_P(C,\beta)\):**
\[
V_P(C) \;:=\; \alpha\!\int_M \max_{w\in C} s\!\cdot\!w\,\tau(ds)
\;+\; (1-\alpha)\!\int_M \min_{w\in C} s\!\cdot\!w\,\tau(ds).
\]
(The min over \(C\) is attained because \(C\) is compact.)

**Claim (WLOG, via Lemma 2).** \(U^* = \sup_{C\in\mathcal K(W^P)} V_P(C)\).
Proof sketch: For any \((\sigma,\beta)\) in the original game, define
\(w_\sigma(m) = \E_{\hat\sigma(m)}[u(\cdot,\omega,\cdot)\mid\omega]_{\omega}\),
the message-conditional payoff profile, valued in \(W\). By Lemma 2, WLOG
\(w_\sigma(m)\in W^P\) for every \(m\). Set \(C_\sigma := \overline{w_\sigma(M)}\subset W^P\).
The adversary's choice of message \(m\) induces payoff vector \(w_\sigma(m)\in C_\sigma\);
all attainable adversarial payoff vectors lie in \(C_\sigma\). Thus the
inf-over-adversary of the misaligned term equals \(\int \min_{w\in C_\sigma} s\!\cdot\!w\,\tau(ds)\),
matching \(V_P(C_\sigma)\).

## 3. What this reformulation buys (versus v8 and Phil Reny)

| Aspect | v8 menu engine | Phil-Reny route | \(\mathcal G_P\) (this route) |
|---|---|---|---|
| Agent variable | \((C, w)\) menu + labeling, \(C\subseteq W\) | message kernel \(\sigma:M\times\Theta\to\Delta(A)\) | **\(C\subseteq W^P\) only** |
| Adversary variable | \(\beta:M\to\Delta(M)\) | \(\beta\in B\), \(\tau\)-AC version \(F\) | **\(\beta:M\to W^P\) with \(\beta\le C\)** |
| Adversary space | \(\Delta(M)\) per row | \(F\) (\(\tau\)-AC, breaks under \(|\Omega|\ge 3\)) | measurable selections from \(C\) (compact-valued, finite-dim) |
| Topology used | Hausdorff on \(\mathcal K(W)\) | Balder/Mertens narrow on \(\Sigma\), \(F\) | **Hausdorff on \(\mathcal K(W^P)\) + narrow Young measures on \(M\to W^P\)** |
| Linearity in agent's var | \(F(C)\) is 1-Lipschitz in \(d_H\), not affine | affine in \(\sigma\) | **not affine in \(C\)** — Sion's bilinear form unavailable |
| Bayes-calibration condition | menu-Hall (additional, not derivable from standing) | A8c-lsc (rowwise l.s.c.) | open — see §5 |
| Closed-form for adversary best response | min over \(w\in C^\dagger\) only after restriction | \(\delta_{m^*(s)}\) under A8c-lsc | **automatic**: \(\beta^*(s)\in\arg\min_{w\in C} s\!\cdot\!w\) (compact \(C\)) |

**The big simplification:** the adversary's strategy space in \(\mathcal G_P\) is
finite-dimensional pointwise (\(C\subseteq\R^{|\Omega|}\)), so existence of the
arg-min for each \(s\) is **automatic from compactness of \(C\)**, with
measurable selection by Kuratowski–Ryll-Nardzewski. **There is no need for an
A8c-lsc assumption on a per-message payoff function**, because the per-source
"payoff function" \(w\mapsto s\!\cdot w\) is **linear in \(w\) and continuous**
on the compact set \(C\) — pointwise attainment is free.

This is the structural improvement Piotr is gesturing at: by collapsing the
message dimension into the payoff-profile dimension, the rowwise-attainment
problem (which broke v5/Phil-Reny via A8c-lsc, and which the menu-Hall
calibration also addresses) **disappears**. The adversary's best response is
constructively available for every \(s\) and every \(C\).

## 4. Existence of \(C^* \in \arg\max V_P\)

This step is the **same as v8's Lemma 2 + Lemma 3** transcribed to \(\mathcal K(W^P)\)
instead of \(\mathcal K(W)\):

- \(\mathcal K(W^P)\) is compact in Hausdorff distance.
- \(C\mapsto \max_{w\in C} s\!\cdot\!w\) and \(C\mapsto \min_{w\in C} s\!\cdot\!w\)
  are 1-Lipschitz in \(d_H\) uniformly in \(s\).
- Therefore \(V_P\) is continuous on \(\mathcal K(W^P)\); attainment by compactness.

**Open subtlety.** \(W^P\) is **closed in \(W\)** but generally not convex. Is
\(\mathcal K(W^P)\) still Hausdorff-compact? Yes: closed subsets of a compact
metric space form a compact metric space under Hausdorff distance (Blaschke).
Convexity of \(W^P\) is not needed for compactness of \(\mathcal K(W^P)\).

**Bonus: \(W^P\) is connected, in fact path-connected,** because
\((W,\cdot\ge\cdot)\) is a closed convex set and the weak frontier is the
upper boundary of a convex compact body in \(\R^{|\Omega|}\) — a homotopy
equivalent to \(S^{|\Omega|-1}\) up to a coordinate-positive cone.

## 5. The Bayes-calibration question (Challenge 2)

In Definition 2 (paper), the agent's private strategy \(\hat\sigma(m)\) must
be **Bayes-optimal under the posterior \(P_{\beta^*}(\cdot\mid m)\)** for
every on-path \(m\). In \(\mathcal G_P\) language:

- The "messages" of the original game become payoff vectors \(w\in C^*\).
- The agent's per-message private strategy at "message" \(w\) is the
  representative \(\hat\sigma_w \in\hat\Sigma\) of \(w\), via the profile-
  realization right inverse \(R:W\to\hat\Sigma\) (KRN; v8 §3).
- Lemma 2 says \(\hat\sigma_w\) is Bayes-optimal for **some** belief \(\mu_w\),
  namely any belief in the supporting cone \(N(w)\) of \(W^P\) at \(w\).
- Definition 2 requires \(P_{\beta^*}(\cdot\mid w)\in N(w)\) for \(q\)-a.e.\ \(w\).

This is structurally **the same** as v8's menu-Hall, written in \(C\)-coordinates
rather than \((C,w)\)-coordinates. The difference is one of representation, not
content.

**However**, the constructive availability of \(\beta^*\) in \(\mathcal G_P\) (each
\(\beta^*(s)\) is an arg-min of a linear functional on compact \(C^*\)) opens a
new pathway: maybe the **structure of arg-min faces of \(C^*\)** in the dual to
the source belief simplex gives the right calibration automatically, by
Lagrangian duality / supporting-hyperplane theorems on \(W^P\).

**Concretely:** \(\beta^*(s)\in\arg\min_{w\in C^*} s\!\cdot\!w\) means \(-s\) is
a supporting normal to \(C^*\) at \(\beta^*(s)\). For \(\hat\sigma_{\beta^*(s)}\)
to be Bayes-optimal under \(P_{\beta^*}(\cdot\mid w)\), we need the supporting
normal to \(W^P\) at \(\beta^*(s)\) to agree (up to the Bayes update) with the
posterior \(P_{\beta^*}(\cdot\mid w)\). This is a **fixed-point-like compatibility
condition** between the dual-source and dual-message geometries.

## 6. Translating the saddle back to Definition 2 (Challenge 2 fully)

Even if \(\mathcal G_P\) has a saddle \((C^*,\beta^*)\) and the Bayes-calibration
in §5 holds, we still need to **produce a kernel \(\hat\beta^*:M\to\Delta(M)\)
in the original game** that delivers Definition 2. The map is:

1. \(\sigma^*\): from \(C^*\), define \(w^*(m) := \arg\max_{w\in C^*} m\!\cdot\!w\)
   (KRN selector). Then \(\hat\sigma^*(m) := R(w^*(m))\). This is the agent's
   original-game strategy.
2. \(\hat\beta^*\): we need the misaligned adviser's *message kernel*. Given
   \(\beta^*(s)\in W^P\) (a payoff vector), find any \(m_*(s)\) with
   \(w^*(m_*(s)) = \beta^*(s)\), then set \(\hat\beta^*(\cdot\mid s) := \delta_{m_*(s)}(\cdot)\).
   Measurability of \(m_*\) requires KRN on the correspondence
   \(s\mapsto (w^*)^{-1}(\beta^*(s))\cap M\) — **this is where the v8 deletion-
   compatible Hall duality reappears in disguise.**
3. Bayes-optimality of \(\hat\sigma^*(m)\) under \(P_{\hat\beta^*}(\cdot\mid m)\):
   follows from §5 if §5 holds.

**Step 2 is where the route can succeed or stall.** In v8, this step was
controlled by the exact-contact + menu-Hall pair. In \(\mathcal G_P\), it
becomes: given a measurable \(\beta^*:S\to W^P\) ranging in \(C^*\), is there a
measurable \(m_*:S\to M\) with \(w^*(m_*(s)) = \beta^*(s)\) \(\tau\)-a.e.?

By the profile-realization right inverse (KRN, v8 §3 sub-lemma): yes if
\((w^*)^{-1}\) admits a Borel selector. \(w^*\) is upper-hemicontinuous with
closed compact values (continuity of \(m\mapsto \arg\max_C m\!\cdot\!w\) on the
Hausdorff-compact menu \(C^*\)). KRN applies; **the selector exists**.

**Provisional verdict: §5 is the only genuinely new question.** If the
saddle-point's adversary best-response face automatically lands in the Bayes-
calibration cone, the whole theorem closes. If not, we add a structural
hypothesis that makes them agree.

## 7. Existence of saddle: bilinear-loss diagnosis (Challenge 1)

Piotr's first challenge: **\(V_P(C)\) is not bilinear in \((C, \beta)\)**.

Let's be precise. The reformulated game has payoff
\(U_P(C,\beta) = \alpha\!\int \max_C s\!\cdot\!w\,\tau(ds) + (1-\alpha)\!\int s\!\cdot\!\beta(s)\,\tau(ds)\).

- In \(\beta\): \(\beta\mapsto U_P(C,\beta)\) is **linear** (an integral
  against \(\tau\)).
- In \(C\): the aligned term \(C\mapsto\int \max_C s\!\cdot\!w\,\tau(ds)\) is
  **convex but not concave** in \(d_H\) (it's a supremum over a continuous
  family of linear functionals).
- In \(C\): the misaligned term \(C\mapsto\int s\!\cdot\!\beta(s)\,\tau(ds)\)
  is **constant** in \(C\) (given \(\beta\)).

So **agent's payoff is convex in \(C\)** in some sense — but the agent **maximizes**.
This is *not* the structure Sion's minimax theorem wants (which wants
quasi-concave-in-max-variable, quasi-convex-in-min-variable).

**The available tools for max-of-convex problems:**
- The maximum of a continuous convex function on a compact convex set is
  attained at an extreme point. \(\mathcal K(W^P)\) is not naturally convex —
  it's a hyperspace.
- However, \(V_P\) is **continuous** on \(\mathcal K(W^P)\) (Hausdorff-Lipschitz),
  so attainment by compactness is automatic (§4).
- **The minimax step we need is:**
  \[\max_C \inf_\beta U_P(C,\beta) = \inf_\beta \max_C U_P(C,\beta)?\]
  This is not directly needed for existence of \(\sigma^*\) (we already have
  \(C^*\)), but it is needed to **identify the saddle**.

**Insight:** in \(\mathcal G_P\), the inf-over-\(\beta\) is **pointwise** (per
\(s\)) and **explicit** (rowwise minimum of a linear functional over a compact
set). So inf-sup vs.\ sup-inf collapses:
\[\inf_\beta U_P(C,\beta) = V_P(C),\]
and we **don't need** Sion. The question "is there a \(\beta^*\) attaining"
is trivial in \(\mathcal G_P\) — KRN gives the measurable selector. The question
"is there a \(C^*\) attaining" is the v8 Lemma 2 (menu existence) on \(\mathcal K(W^P)\).

So Sion's loss-of-bilinearity is a *non-issue* for existence in \(\mathcal G_P\).
The only place we'd need Sion is to **identify the saddle as a fixed point of
some structural condition** — and that's the Bayes-calibration question (§5).

## 8. The genuine novelty over v8

To pre-empt the temptation to call this "just v8 restricted to \(W^P\)":

| Item | v8 | \(\mathcal G_P\) |
|---|---|---|
| Menu space | \(\mathcal K(W)\) | \(\mathcal K(W^P)\) |
| Lemma 2 wlog usage | implicit (closure-pruning gives \(C^\dagger\subseteq W^P\) after the fact) | **upfront** (built into the choice space) |
| Adversary variable | message kernel \(\beta:M\to\Delta(M)\) | payoff-vector map \(\beta:M\to W^P\) |
| Existence of \(\beta^*\) | needs A8c-lsc (rowwise l.s.c. of \(\ell(\cdot,s)\)) | **free** — \(\beta^*(s)\in\arg\min_C s\!\cdot\!w\), KRN on compact \(C\) |
| Tier 2 condition | menu-Hall (set-valued kernel \(\kappa\) into rowwise mins, plus Bayes-cone) | per-frontier-point Bayes-cone calibration; not yet known to be derivable |
| Deletion-compatible Hall duality | the locked gate at closure | **dodged** — no Hall-style assignment problem; just per-source arg-min |

The structural shift is: in \(\mathcal G_P\), there is **no separate message-
indexing step** for the adversary. The adversary's choice IS the payoff vector.
This eliminates the cell-flow / Borel-to-compact / sourcewise-deletion-
certificate machinery of Routes 1+2 that locked the v8 closure.

**This is what was missing from prior architectures**: every prior attempt
treated messages and payoff profiles as different objects connected by a
labeling. Piotr's reformulation collapses them.

## 9. Risks and where this could still fail

1. **Bayes-calibration mismatch (§5).** The dual source-supporting normal at
   \(\beta^*(s)\in C^*\) may not align with the posterior \(P_{\hat\beta^*}(\cdot\mid w)\)
   for general \(\tau\). This is the analog of menu-Hall in \(\mathcal G_P\)
   coordinates. **If** this calibration is automatic for \(C^*\in\arg\max V_P\)
   (via some Lagrangian/duality argument), the route closes. **If not**, we
   need a structural hypothesis on \(\tau\) or on \(C^*\). The hypothesis would
   need to be tested against the v8 sharpness witness (Lemma 7 + Theorem 8)
   to confirm it's strictly weaker than menu-Hall.
2. **WLOG step (Lemma 2 application).** Lemma 2 says any optimal \(\sigma^*\)
   uses Bayes-optimal profiles. It does NOT directly say the OPTIMIZATION can
   be restricted to compact subsets of \(W^P\) without losing supremum. To
   close this we use v8's Lemma 2 (menu-value equivalence) — but on \(W^P\)
   instead of \(W\). Verifiable: \(\overline{w_\sigma(M)}\subseteq W^P\) (by
   paper Lemma 2 wlog), so the supremum is over compact subsets of \(W^P\).
3. **Profile-realization step.** Given a measurable \(\beta:M\to W^P\), we
   need a corresponding kernel \(\hat\beta:M\to\Delta(M)\) such that the joint
   law over \((m,\omega)\) realizes \(\beta(s)\) as the agent's payoff
   profile observed at the adversary's message. Done by KRN on
   \((w^*)^{-1}\); §6 step 2.
4. **No-free-dust (v8 Theorem 8) compatibility.** The reformulation should not
   accidentally bypass a genuine obstruction. Need to check Theorem 8 holds
   verbatim in \(\mathcal G_P\) coordinates — it does (every adversarial \(\beta\)
   in \(\mathcal G_P\) trivially corresponds to a kernel in \(B\), so the
   τ-null dust obstruction transfers).

## 10. Banned re-proposals (carried over from prior route memos)

- Do **not** retry product-of-narrow + Sion as the master theorem (the loss-
  of-bilinearity diagnosis above shows we don't need it anyway).
- Do **not** retry adversary attainment in \(\prod_\mu\Delta(M)\) — the
  reformulation eliminates the message-indexing dimension.
- Do **not** retry the τ-AC restriction (\(F\subset B\)) — the reformulation
  doesn't need it.
- Do **not** restart canonical/minimal menu pruning without first checking
  whether §5 makes it unnecessary.
- Do **not** treat this as "v8 with \(W^P\) instead of \(W\)" — the
  adversary's strategy space is structurally different.

## 11. Live plan of attack

1. **Formalizer pass** (Extended Pro): precisely state \(\mathcal G_P\),
   verify the Lemma 2 wlog step, identify the exact form of the Bayes-
   calibration question (§5), and produce a gap register.
2. **Literature pass** (Extended Pro): minimax / saddle-point existence
   for hyperspace games; supporting-hyperplane-on-\(W^P\) tools (Doval-Smolin
   2024, Dworczak-Pavan 2022, Lipnowski-Ravid-Shishkin 2022); measurable-
   selection theorems for arg-min on \(W^P\) viewed as a hyperspace.
3. **Searcher pass**: rank routes for closing §5. Candidates:
   - (R1) Lagrangian / KKT-duality at the saddle, derive the Bayes-calibration
     from \(\beta^*(s)\in\arg\min_C s\!\cdot\!w\).
   - (R2) Alternating-representations bootstrap: use \(\mathcal G_P\) for
     value optimality, then switch to original-game coordinates and apply
     v8's exact-contact + menu-Hall in the smaller \(W^P\) setting.
   - (R3) Direct construction of \(C^*\) via concavification / convexification
     of \(W^P\) — perhaps the maximizer \(C^*\) has a structural description
     (e.g., a face of \(\text{conv}(W^P)\)) that forces calibration.
   - (R4) Reduce to a deterministic frontier-mapping subgame and apply
     measurable selection theorems on \(W^P\)-valued correspondences.
4. **Breakdown + prover loop** on top-ranked route. Iterate reviewer until
   PASS. Consolidator. Gatekeeper. Until OBJECTIVE_MET or OBJECTIVE_MET_WITH_
   TRIVIAL_REGULARITY (per user instruction: theorem proved, OR added
   hypotheses economically meaningful + not too close to conclusion).

## 12. Stop condition (per user instruction, 2026-05-20)

> "I really just want you to stop when you get a session, like when you get
> Pro to agree that you fulfilled the theorem or we added assumptions that
> are economically meaningful and not too close to the theorem to prove in
> spirit the initial idea."

Operational reading: do not stop on partial Tier-1a-style results;
push through to robust rationalizability OR to an added hypothesis that is
- (a) economically meaningful (interpretable in terms of \(\alpha,\tau,W\)
  primitives, not in terms of the optimization output \(C^*\) or \(\sigma^*\)),
  AND
- (b) strictly weaker than menu-Hall, AND
- (c) compatible with the v8 sharpness package (Lemma 7 + Theorem 8).
