# Project closure memo — Robust Trust Theorem 2 infinite extension

**Status:** terminal at v8. Gatekeeper-blessed (five passes; final verdict `OBJECTIVE_NARROWED` with explicit STOP recommendation; `search_status: structural_search_exhausted`).

**Date closed:** 2026-05-07 (initial); 2026-05-08 (post-Routes-1+2 audit added).

## What v8 is

A three-tier conditional infinite-extension of Theorem 2 from Dworczak–Smolin, *Robust Trust* (2026, arXiv:2602.09490), under standing hypotheses (Ω finite, full-support prior, A and Θ compact metric, u bounded continuous in a, conditional independence of s and θ given ω, Borel measurability) but **without** finite M or Θ:

- **Tier 1a (standing alone).** Existence of σ* ∈ Σ with U(σ*) = U*, plus ε-adversaries for every ε > 0. **No added hypotheses.**
- **Tier 1b (+ exact-contact).** Exact β* ∈ B with U(β*, σ*) = U*. The exact-contact assumption is endogenous to the optimal labeling w*.
- **Tier 2 (+ exact-contact + menu-Hall).** Full robust rationalizability in the q_β-a.e. sense (the natural infinite-space reading of Definition 2; equivalent to τ-a.e. when α > 0). The menu-Hall assumption is set-valued, strictly milder than v5's deterministic TRE-gen-Hall.

Sharpness package:
- **Lemma 7 (cone intersection).** In WTA ternary, for every nonempty support I ⊆ {0,1,2}, the only Borel probability ρ on Δ(Ω) with ρ(K_I^-) = 1 and barycenter in B_I is δ_{(1/3,1/3,1/3)}.
- **Theorem 8 (no-free-dust).** Under atomless τ in WTA ternary, no Borel τ-null dust set + labeling + adversarial kernel can simultaneously satisfy positive q-mass and Bayes-cone calibration.

Classification of the witness:
- The trust region T = {μ : μ(0) ≤ 0.4} used in §8 is **not primitive, minimal, or load-bearing**. Its induced payoff-profile menu is the full vertex menu, behaviorally equivalent to T = Δ(Ω). The witness shows menu-Hall is genuinely needed inside the menu engine **but is not a primitive counterexample to unrestricted Theorem 2.**

## What v8 is NOT

**v8 is not a proof of unrestricted Theorem 2.** Tier 2 carries menu-Hall as an additional hypothesis. The gatekeeper classified menu-Hall as scope-changing because it installs the equilibrium calibration that Definition 2 demands; weaker than deterministic TRE-gen-Hall is not the same as primitive.

**v8 is not a counterexample to unrestricted Theorem 2.** The §8 witness is a menu-engine artefact (classification (b)). No primitive optimization with standing assumptions has been shown to force the witness's geometry.

## Strategic record

| Strategy | Outcome |
|---|---|
| 1. Formalizer reread of Definition 2 on-path semantics | Closed. q_β-a.e. confirmed as the natural reading; v8 narrowing real under any reasonable reading. |
| 2. Null-message dust | Closed (negative). No-free-dust theorem (reviewer-PASS) shows τ-null dust cannot repair menu-Hall in WTA ternary under atomless τ. |
| Classification (b) of v7 ternary witness | Banked. Witness is menu-engine artefact, not primitive counterexample. |
| 3a. C1 behavioral-minimality canonical menu | Stalled. Critical Lemma A.2 (uncalibrated minimal menu pruning) blocked at three named structural gaps: label-saturation, replacement-index mismatch, Borel→compact gap. |
| 3b. C2 exposed-extreme | Not pursued; reviewer judged needs its own analog of A.2. |
| 3c. C3 primitive TR-minimality | Not pursued; reviewer judged useful for ruling out scenery (already in v8 §9) but doesn't solve index mismatch. |
| 3d. C4 radial/orbit symmetry | Not pursued; reviewer judged best islands (binary, spherical) already covered by paper Appendices A.6, A.10. |
| 4. Finite RR equilibria → joint-law limits | Not pursued; searcher ranked low (close to prior failed limit/lifting routes). |
| 5. Trust-region geometry general | Not pursued; positive cases already in paper. |

## Post-v8 terminal route audit: Routes 1+2

After the initial closure, a fresh gatekeeper pass identified two genuinely-new routes that were not proposable from v7-state. Per user authorization, full pipelines were run for both. Both routes are now **structurally blocked** at the same missing object.

### Route 1 — Deletion-compatible Hall duality (exact theorem target)

- **Literature pass: BUILD verdict.** No off-the-shelf theorem applies. Closest tools: Strassen/Kellerer + Beiglböck-Nutz-Touzi weak/martingale OT + Doval-Skreta/Dworczak-Kolotilin constrained persuasion duality.
- **Formalizer:** target $T(C^*, w^*)$ pinned with primitive hypothesis (H_del) — sourcewise deletion-stability $\forall D \in \text{Del}(w^*, \tau)\setminus\{C^*\}, F(D) < F(C^*)$. Conclusion: existence of Borel kernel κ supported on $G(s)$ τ-a.e. with $P_{\gamma_\alpha}(\cdot|m) \in B(m)$ q-a.e.
- **Searcher:** R6 (finite-partition capacitary Hall + projective limit) ranked top.
- **Breakdown:** 8-step lemma chain, Lemma 2.1 (the collapse lemma) identified as critical.
- **Prover (twice):**
  - First pass: DISPROVED with concrete binary counterexample. The original LP attached aligned mass to representative cell labels but tested optimality at cell barycenters; coarse mixed cells generated phantom Bayes violations unrelated to any compact deletion.
  - Sourcewise rewrite: STALLED at four obstructions (continuum-mass label fibers, Borel→compact gap, F-comparison gap, **(H_del) pointwise-strict ≠ uniform**).
- **Reviewer (twice):** both stalls confirmed structural. **Decisive obstruction (O4):** $D_n \to C^*$ with $F(D_n) \uparrow F(C^*)$ is consistent with (H_del). Therefore an LP conclusion $F(D_E) \ge F(C^*) - K\eps$ does not contradict (H_del). *"The tiny hinge that swings the whole castle gate."*

### Route 2 — Calibration-defect quantitative bound

- **Literature pass: BUILD verdict.** Ingredients available (Burke-Tseng error bounds + Beiglböck-Nutz-Touzi + Fukushima/Auchmuty gap functions + Balseiro-Besbes-Castro approximate-IC), no direct import.
- **Formalizer:** target $BR \le \Phi(\Delta_\text{del}^{cp})$ with primitive defect (D1: compact-patch dual deletion residual). Crucial: the (H_del) tiny-hinge obstruction is **dodged by quantitative softness** — positive Δ produces positive regret rather than requiring contradiction. But the **same Hall bottleneck reappears in defect form**.
- **Searcher:** R6 (finite-net entropy bootstrap) ranked top, with linear Φ for polytope W and Hölder $\Phi(\delta) \asymp \delta^{1/(d+1)}$ for curved W.
- **Breakdown:** 8-step lemma chain, Lemma 2.1 identified as critical ("the smaller dragon").
- **Prover:** STALLED at three obstructions:
  - **(O1) Borel→compact deletion gap.** Signed integrand $s\cdot(v_i - w^*(m))$ makes $\inf_{m \in G(s)}$ non-monotone in $E_i$; ordinary inner regularity does not bridge $E_i$ to compact $K_i$.
  - **(O2) Cell-flow lift gap.** Cell-flow LP solutions average over source cells; lifting to Borel kernels supported on $R_0$ requires fiber-thickness or splitability not in standing hypotheses.
  - **(O3) Slack discipline.** $n(\eps)\,\rho_\eps \to 0$ requires uniformity standing doesn't supply for curved W.
- **Reviewer:** stall confirmed. *"Route 2 found a different scorch pattern. Route 1 died on the pointwise-strict versus uniform-strict gap. Route 2 avoids that exact wound by using quantitative softness, so it is not literally Route 1 in disguise. But the remaining failures are recognizably from the same family."*

### Convergent diagnosis

Strategy 3 (canonical/minimal menu, Lemma A.2), Route 1 R6 (collapse lemma), Route 2 R6 (finite-net bound) all reach the same locked gate. The closure memo's named open theorem is now triple-confirmed.

## The single most consequential open question (sharpened)

A **deletion-compatible Hall duality theorem.**

> Take an optimal compact menu/labeling pair $(C^*, w^*)$, a rowwise-minimizer correspondence $G(s) := \{m : s\cdot w^*(m) = \min_{z \in C^*} s\cdot z\}$, and Bayes-optimality cones $B(m) := \{\mu : \hat\sigma^*(m) \in \arg\max U(\hat\sigma', \mu)\}$. Give **necessary and sufficient conditions in primitive terms** (using only $F$, $w^*$, $\tau$, $\alpha$, compact source patches, raw payoff comparisons) under which there exists a Borel kernel $\kappa(\cdot|s)$ supported on $G(s)$ τ-a.e. such that the induced disintegration posterior lies in $B(m)$ for $q$-a.e. $m$.
>
> The theorem must be compatible with **sourcewise deletion certificates** (the dual character) and **messagewise calibration constraints** (the primal character) **simultaneously**, AND must explicitly handle:
> - **Borel→compact non-monotonicity:** signed deletion integrands prevent compact-patch tests from controlling Borel violations.
> - **Label-fiber lift:** cell-flow LP solutions to Borel kernels on $R_0$.
> - **Slack discipline in curved W:** $n(\eps)\,\rho_\eps \to 0$ uniformly across the dual class generated by an ε-net $V_\eps \subset W$.

If such a theorem exists, Routes 1 and 2 both reopen, and Tier 2 could become unconditional or replace menu-Hall by a primitive defect.

## Separate research target: (U-Borel) variant

A distinct future paper target: a **Borel-residual** version of Route 2's quantitative bound. Replace $\Delta_\text{del}^{cp}$ (compact-patch defect) with a Borel-patch residual. The Route 2 reviewer flagged this as *"viable as a different theorem, not a small repair"*: Borel patches restore the natural separation (the dual $A_E$ is Borel-natural), avoiding O1's non-monotonicity, but the cell-flow lift gap (O2) likely still bites.

This is **not** part of the current project's closure. It is logged here as a separate handoff, not as a route worth restarting inside this project's scope.

If such a theorem exists, Strategy 3 may reopen with real force and Tier 2 could become unconditional for behaviorally minimal canonical menus. Until then, **do not restart canonical pruning without it.**

## What future contributors should not redo

- **Do not** propose new sharpness witnesses for menu-Hall. The cone intersection lemma + no-free-dust theorem cover all support patterns and all dust regimes uniformly.
- **Do not** treat the v7 ternary witness as evidence against unrestricted Theorem 2. Classification (b) closes that interpretation.
- **Do not** restart canonical/minimal menu pruning under standing + exact-contact. Lemma A.2 is blocked at named structural gaps; the route requires Unblocker A (deletion-compatible Hall duality) or Unblocker B+ (regularity strictly stronger than closed-graph + uniqueness, with explicit label-regularity tied to compact patches).
- **Do not** silently re-import infinite-dimensional saddle/minimax architectures (Sion, Tychonoff, Balder-Mertens-Lusin in the original Phil Reny form). These were tried in v3-v6 and superseded by the menu engine for clean reasons.

## Path to publication

The cleanest framing for an exposition or paper: *"Three-tier infinite-extension of Theorem 2 with sharpness. Tier 1a unconditional value optimality + ε-adversaries. Tier 1b exact adversary under a clean endogenous exact-contact condition. Tier 2 robust rationalizability under a set-valued menu-Hall calibration. menu-Hall is sharply needed inside the menu engine (cone intersection lemma + no-free-dust theorem), but the known obstruction is a menu-engine artefact, not a primitive counterexample to unrestricted Theorem 2. The unrestricted infinite extension remains open; the bottleneck is a deletion-compatible Hall duality theorem."*

## Pipeline metadata

- **Tool:** MathPipeProver, smart-scaffolding mode.
- **External engine:** ChatGPT Extended Pro.
- **Project URL:** https://chatgpt.com/g/g-p-69fab2d4ab288191a33c6245f4e28957/project
- **Active CDP port:** 9224 (chrome-debug-profile-npiv).
- **Pipeline phases used:** formalizer (reread + Route 1 + Route 2), literature (Route 1 + Route 2), searcher (Route 1 + Route 2), breakdown (Strategy 3 + Route 1 + Route 2), prover (multiple cycles), reviewer (matching), consolidator (manual local), gatekeeper (5 passes — the role's first project, all five passes returned NARROWED with progressively sharper diagnosis).
- **Final search status:** structural_search_exhausted. The gatekeeper-blessed search space has converged on the deletion-compatible Hall duality theorem as the single open object.

## Durable sources at closure

- `objective_statement.md` — original claim-parsing and dependency map.
- `prior_attempts_digest.md` — failed architectures (Sion/Tychonoff/KRN, FOC/envelope, Phil-Reny global-saddle versions). Prevents repetition.
- `Robust_trust_Dworczak_Smolin.pdf` — primary paper.
- `theorem_2_extension_proof_v8.md` — terminal proof artifact.
- `project_closure_memo.md` (this file) — to prevent future contributors from misremembering v8 as proof or counterexample.
