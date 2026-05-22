# Lean Formalization State — v9

## Meta
- Proof repo: C:\Users\dep89\OneDrive\Economia\RA Piotr\robust_trust_extension
- Source proof pointer: `lean/source_proof.md`
- Source documents (all three bundled as input pack):
  - `01_deliverables/closure/v9_consolidated.md` — master memo (2019 lines)
  - `01_deliverables/exposition/exposition_v9.tex` — canonical statements (905 lines)
  - `01_deliverables/exposition/exposition_v9_paper.tex` — long-form paper (900 lines)
- Provenance slug: `robust-trust-v9` (codex thread id seed)
- Initialized: 2026-05-21
- Current phase: skeleton-built (main.lean compiles with 26 sorries; awaiting decomposition reviewer pass + first per-lemma round)
- Target Lean toolchain: lean-4.29.0 (carry over from v8 unless a v9 dependency forces a bump)
- AXLE log: `lean/axle_log.jsonl`
- Heartbeat: 15m orchestrator loop, job ffa61811 (`*/15 * * * *`); reset on session restart

## Scope (locked 2026-05-21)

Formalize the full v9 surface — five theorems + corollaries + G addendum + primitive classes + G4 LP threshold. See `lean/source_proof.md §Scope` for the full list. T1 Clarke–Danskin is axiomatized in Inventory; everything else gets a real proof attempt.

## Pipeline discipline

Per memory `feedback_pipeline_discipline`, `feedback_reviewer_division_of_labor`, `feedback_parallel_batch_size`, `feedback_reviewer_prompt_discipline`:

- Every claim → fresh-session reviewer pass before merge.
- Opus subagent = math template (per-lemma proof verification).
- Extended Pro = writing/style + skeleton/decomposition.
- Fan-out batches of 3.
- Paste proofs verbatim into peer-reviewer prompts; do not sketch.
- AXLE-check + `lake build` clean + `#print axioms` audit per merge.
- Cap retries at 5 per lemma.
- CDP browser on port 9227 (Robust Trust Extension Chrome profile).

## Reusable from v8

The v8 `RobustTrustV8` namespace (in `lean/v8_main.lean`, 4981 lines, 3 sorries, AXLE-clean) is imported wholesale:
- `RobustTrustModel`, `Belief`, `Profile`, `PayoffProfileSet`
- `AgentStrategyM`, `AdviserKernel`, `MessageRestrictionBridge`
- `MenuHall`, `ExactContact`, `EpsilonContactGeps`, `Tier1aResult`, `Tier1bResult`, `Tier2Result`
- `WTA` machinery (`WTATernaryAlgebra`, `WTA_vertex`, `WTASupport`, ...)
- `Inventory` namespace: `measurable_argmax_selector`, `krn_borel_right_inverse`, `kernel_infimum_epsilon_selection`, `UniversallyMeasurable`, `GepsRegularity`

v9 lives in a new namespace `RobustTrustV9` on top of the v8 surface.

## Theorem ledger (v9)

_To be populated after the decomposition pass via Extended Pro._

| Slug | declared | proved | reviewed | merged | permanent_stub |
|---|---|---|---|---|---|
| T1-finite-menu-pareto-hall | | | | | |
| T1-clarke-danskin-inventory | | | | | axiom |
| T1-multiplier-bayes-cone-calibration | | | | | |
| T2-alpha-zero-singleton | | | | | |
| binary-L_B1-endpoint-fiber-lift | | | | | |
| binary-L_B2-TRS-interval-reduction | | | | | |
| binary-L_B3-endpoint-only-image | | | | | |
| binary-L_B4-interior-message-calibration | | | | | |
| binary-L_B5-endpoint-stationarity-total-balance | | | | | |
| binary-L_B6-capstone | | | | | |
| FBNF-F1-conditional-B1-measurable-pasting | | | | | |
| FBNF-F2-endpoint-only-fiber-image | | | | | |
| FBNF-F3-localized-stationarity-FBNF6 | | | | | |
| FBNF-F4-capstone | | | | | |
| FBNF-corollary-spherical-radial | | | | | |
| FBNF-corollary-affine-MLR-single-crossing | | | | | |
| FBNF-corollary-polyhedral-scalarizable | | | | | |
| Hall-G1-finite-cone-hall-farkas-LP | | | | | |
| Hall-G2c-borel-extension | | | | | |
| Hall-biconditional | | | | | |
| Hall-WTA-dual-certificate-psi-two-ninths | | | | | |
| Hall-WTA-reopening-threshold-D | | | | | |
| G4-finite-facet-polyhedral-LP-threshold | | | | | |
| P2-star-cone-margin-bounded-jamming | | | | | |
| P3-polyhedral-cone-margin | | | | | |
| P4-radial-antipodal-tau-symmetry | | | | | |
| G-addendum-binary-tie-splitting | | | | | |
| G-addendum-variable-margin-P2-star-prime | | | | | |
| G-addendum-P6_G-finite-graph-FBNF | | | | | |
| Inventory-clarke-danskin-stationarity | | | | | axiom |
| Inventory-clarke-fermat-normal-cone | | | | | axiom |
| Inventory-strassen-marginals | | | | | axiom |
| Inventory-farkas-LP-duality-conic | | | | | axiom |

## Phase log

- 2026-05-21 T+0  Branch v9-formalization created, v8 artifacts renamed.
- 2026-05-21 T+1  Durable sources written (this file + source_proof.md).
- 2026-05-21 T+2  Heartbeat live (job ffa61811, 15m). Browser CDP up on port 9227.
- 2026-05-21 T+3  ChatGPT project Sources panel pruned: 21 → 12. Removed prover_05/12/13/19/21/22, searcher_04/05/07, sanity_chunk1/2, theorem_2_extension_proof_v8.md, exposition_v8.2_final.pdf, project_closure_memo.md. Added exposition_v9_paper.tex, v9_executive_summary.md, source_proof.md, lean_state.md, v8_main.lean. (prior_attempts_digest.md refused removal — historical, harmless.)
- 2026-05-21 T+4  v9 decomposition prompt submitted to Extended Pro. Chat: https://chatgpt.com/g/g-p-69fab2d4ab288191a33c6245f4e28957-robust-trust-extension/c/6a0f9a2b-4f64-83ea-9c08-1e4672bf49ca. Awaiting decomposition.md output.
- 2026-05-21 T+5  Decomposition received (54k chars, 1880 lines, 28 lemma stubs, 6 new Inventory axioms). Saved to lean/decomposition.md.
- 2026-05-21 T+6  Decomposition reviewer dispatched (fresh session). Chat: https://chatgpt.com/g/g-p-69fab2d4ab288191a33c6245f4e28957-robust-trust-extension/c/6a0f9fbe-1254-83ea-b3a4-9951105693d6.
- 2026-05-21 T+7  main.lean skeleton built and PASS in MathlibStarter v4.30.0-rc1 (8264 jobs, 0 errors, 26 sorries). v9_appendix.lean (620 lines) ⊕ v8_main.lean (4981) = main.lean (5601). v9 namespace `RobustTrustV9` carries: WP, KCompactWP, Bayes cones, RegPackage, Foliation, FBNFPackage, BinaryCapstoneData, AlphaZeroSingletonData, FiniteMenuData, BoundedBorelProfile, PsiNonpos, P2*/P3/P4/VariableMargin/GraphFBNF packages, all 28 theorems as `sorry` stubs (3 corollaries as trivial pass-through term-mode proofs).
