# Literature pass 01 — Tools for the Pareto-frontier-set reformulation

## Role

You are the Literature pass for a smart-scaffolding proof project. Your job
is to scan the relevant mathematical literature and report **which tools are
available off-the-shelf**, **which can be adapted**, and **which would be a
genuinely new theorem**. You do not prove anything in this pass — you survey.

This is the third pass at extending Theorem 2 of Dworczak–Smolin (2026,
*Robust Trust*, arXiv:2602.09490) beyond finite \(M\), \(\Theta\). The new
reformulation \(\mathcal G_P\) (Piotr Dworczak, 2026-05-20) is documented in
`piotr_pareto_frontier_route_memo.md` (durable source). Read it first.

The closure of Pass 2 (v8 menu engine) is documented in
`project_closure_memo.md` and the v8 proof is in `theorem_2_extension_proof_v8.md`
(durable sources). The closure-named locked gate was a **deletion-compatible
Hall duality theorem**. Two prior literature passes (Route 1: Strassen +
Kellerer + Beiglböck-Nutz-Touzi; Route 2: Burke-Tseng + Fukushima/Auchmuty +
Balseiro-Besbes-Castro) both verdict-ed BUILD (no off-the-shelf theorem
applies). This pass is for the new \(\mathcal G_P\) route — different
mathematical setting, different tool surface.

## What I need

A **prioritized inventory of usable mathematical machinery**, organized by
the open mathematical questions in \(\mathcal G_P\). The five primary
questions:

### Q1. Hyperspace minimax / saddle-point theorems

The agent's strategy is a compact subset \(C \in \mathcal K(W^P)\) (Hausdorff
distance, compact metric). The adversary's strategy is a measurable map
\(\beta: M\to W^P\) with image in \(C\). The payoff is **non-bilinear** in
\((C,\beta)\) — concave in neither.

What minimax / saddle-point existence theorems apply to such hyperspace
games? Survey:
- Sion (1958) + its quasi-concave variants (Komiya 1988, Lin–Geraghty, Ben
  Tal–Ghaoui–Nemirovski 2009).
- Ky Fan (1953) intersection theorem and its set-valued descendants.
- Granas–Liu, Tuy, and other non-bilinear minimax theorems.
- Set-valued minimax theorems on hyperspaces specifically (Beer 1993,
  Aubin-Frankowska 1990, Klein-Thompson 1984).
- Measurable selection-based minimax theorems (Castaing-Valadier, Hu-Papageorgiou).

For each tool, report: applies / partially applies / does not apply, and why.

### Q2. Existence of optimal measurable selections from compact-valued correspondences

For fixed \(C\) and signal \(s\), \(\arg\min_{w\in C} s\!\cdot\!w\) is a
nonempty compact face of \(C\) (lower face in the dual direction \(s\)).
The adversary's BR is \(\beta^*(s) \in\arg\min_{w\in C} s\!\cdot\!w\) for
τ-a.e. \(s\). Is this BR always measurable?

Survey:
- Kuratowski–Ryll-Nardzewski (1965) classical theorem.
- Castaing-Valadier (1977), Aliprantis-Border (2006) Chapter 18.
- Jankov-von Neumann (Castaing 1972, Bertsekas-Shreve 1978 §7).
- Filippov (1988), Aubin-Frankowska (1990) Chapter 8.

State the cleanest sufficient conditions. The correspondence
\((s, C)\mapsto\arg\min_{w\in C} s\!\cdot w\) is jointly measurable in
\((s, C)\) if \(C\) is fixed Borel-compact and \(s\mapsto s\!\cdot w\)
is continuous in \(s\) for fixed \(w\) and continuous in \(w\) for fixed
\(s\). Document the exact theorem.

### Q3. Compactness of \(\mathcal K(W^P)\) and continuity of the value functional

The agent's strategy space is \(\mathcal K(W^P)\) with Hausdorff distance.
Tools needed:
- Blaschke selection theorem (compact subsets of a compact metric space form a
  compact metric space under Hausdorff distance) — fully classical.
- Lipschitz continuity of support functions \(C\mapsto h_C(s)\) and "infimum
  support" \(C\mapsto\min_{w\in C} s\!\cdot\!w\) in \(d_H\), uniform in \(s\)
  over bounded sets. (Same Lipschitz constant: \(\|s\|\).)
- Integral continuity: \(V_P(C) = \int [\alpha\max_C s\cdot w + (1-\alpha)\min_C s\cdot w]\,\tau(ds)\)
  is therefore continuous on \(\mathcal K(W^P)\) by bounded convergence.

These should be 99% off-the-shelf. Confirm any subtleties (e.g., does
\(W^P\) need to be closed in \(W\) for Blaschke? Is it?).

### Q4. Supporting hyperplane theory on the weak Pareto frontier \(W^P\)

The Bayes-calibration question (Pareto-frontier route memo §5) hinges on:
the supporting normal cone \(N(w)\) of \(W^P\) at \(w\) consists of belief-
proportional vectors \(\mu \in\Delta(\Omega)\) such that \(w\in\arg\max_{w'\in W}\mu\cdot w'\),
i.e., the Bayes-optimality cone. Lemma 2 of Theorem 1's proof
(paper p. 27) makes this explicit: \(\hat\sigma\) is Bayes-optimal for
some belief iff its profile is on \(W^P\), and the set of supporting
beliefs is the normal cone of \(W\) at \(w\) intersected with \(\Delta(\Omega)\).

Tools:
- Rockafellar (1970) §13 (convex sets, normal cones, supporting hyperplanes).
- Rockafellar-Wets (1998) Chapter 6 (normal cones to general sets).
- Holmes-Penot duality for set-valued maps.
- Doval-Smolin (2024) on persuasion via payoff sets.

Specifically: is there a clean **continuous selection** of supporting
beliefs from the normal cone of \(W^P\)? I.e., a Borel map
\(\mu: W^P\to\Delta(\Omega)\) with \(\mu(w)\in N(w)\)? If yes, the route
memo §5 is essentially solved at the saddle.

### Q5. Set-valued Bayes-calibration / persuasion-theoretic duality

The route memo §5 reduces to: at every \(w\in C^*\), the posterior
\(P_{\hat\beta^*}(\cdot\mid w)\in\Delta(\Omega)\) induced by Bayes' rule from
\((\tau, \beta^*)\) should lie in the supporting normal cone \(N(w)\) of
\(W^P\) at \(w\).

This is **structurally** a calibration / persuasion-equilibrium condition:
the posterior at "message" \(w\) should be consistent with the agent's
private-strategy choice at \(w\), namely \(\hat\sigma_w = R(w)\). Survey:

- **Bayesian persuasion family** (Kamenica-Gentzkow 2011, Dworczak-Kolotilin
  2024, Dworczak-Pavan 2022, Doval-Smolin 2024).
- **Constrained persuasion / monotone payoff structure** (Kolotilin 2018,
  Mensch 2021, Yang-Zentefis 2023).
- **Pareto-frontier persuasion** (Lipnowski-Ravid 2020 specifically uses
  W^P-style frontier characterization; the paper cites them).
- **Robust persuasion / multiple receivers** (Hu-Weng 2021, Galperti-Perego
  2022).
- **Saddle-point equilibrium in zero-sum persuasion** (Min 2021 Bayesian
  persuasion under partial commitment; Dworczak-Pavan 2022 "robust Bayesian
  persuasion").

Specific candidate theorem to look for: is there a known result of the form
"in a zero-sum persuasion game with supporting-cone structure, the
sender's equilibrium message kernel automatically calibrates to the
receiver's posterior cone"?

### Q6. Banned tool list (carry over from prior memos)

State explicitly which tools are **banned** in this route (per
`prior_attempts_digest.md`) and confirm none of your recommendations
re-import a banned route. Specifically:
- Sion + Tychonoff on product-of-narrow \(\Sigma\) — banned.
- Adversary attainment in \(\prod_\mu \Delta(M)\) without new tightness — banned.
- τ-AC restriction \(F\subset B\) — banned (Piotr's geometric objection).
- FOC + envelope in infinite case — banned (apparatus is finite-only).

If a tool you recommend reduces to one of these, flag it and propose a
genuinely new replacement.

## Output Contract

Return everything inline in this chat as plain markdown. Use this section
ordering exactly:

```
# Literature inventory for the Pareto-frontier-set reformulation

## Q1. Hyperspace minimax / saddle-point theorems
- Tool name (Citation, Year). Status: applies / partial / does not apply.
  One-paragraph justification. If "partial", state what additional
  hypothesis would close the gap.

## Q2. Measurable selection from compact-valued correspondences
- ...

## Q3. Compactness + continuity on K(W^P)
- ...

## Q4. Supporting hyperplane theory on W^P
- ...

## Q5. Set-valued Bayes-calibration / persuasion duality
- ...

## Q6. Banned tools — sanity check
- ...

## Verdict
- BUILD / REUSE / BLEND. Justify in one paragraph.
- Cleanest single tool to use as the entry point.
- One-paragraph next-step signal to the searcher.
```

- BUILD = no off-the-shelf theorem applies, we'd be proving a genuinely new
  result.
- REUSE = there is a usable theorem; cite it precisely and identify how
  it slots in.
- BLEND = a tool exists but requires extension; identify the closest
  candidate and the gap.

End with a one-paragraph **next-step signal**: should the searcher prioritize
Q1, Q2, Q4, or Q5 next, and why?
