ROLE — Lean Headline Translation Auditor. Per `prompts/soft/8a_lean_headline_translation_soft.md` (MathPipeProver c19c54d).

# What to audit

The v9 Robust Trust formalization is now sorry-free. Audit whether the **headline theorems** in `v9_appendix.lean` correctly translate the mathematical statements from the source paper (`v9_consolidated.md`, `exposition_v9.tex`, `v9_executive_summary.md`).

Headlines to audit (≤ 8, the v9 paper's main results):

1. `«T1-clarke-danskin-multiplier-bayes-cone»` — Finite-menu Pareto-Hall calibration via Clarke–Danskin (exposition_v9.tex §3).
2. `«T2-alpha-zero-singleton-prior-strategy»` — α=0 unconditional infinite-extension (§4).
3. `«binary-L_B6-capstone»` — Binary capstone (|Ω|=2 unconditional under R-EE+R-TD+R-IES, §8).
4. `«FBNF-F4-capstone»` — FBNF |Ω|≥3 unconditional capstone (§9).
5. `«Hall-biconditional»` — Robust rationalizability ↔ Ψ ≤ 0 (§11).
6. `«Hall-WTA-dual-certificate-psi-two-ninths»` — Explicit WTA Ψ = 2/9 (§11).
7. `«Hall-WTA-reopening-threshold-D»` — D ≥ 2(1−α)/(9α) reopening (§11).
8. `«G4-finite-facet-polyhedral-LP-threshold»` — Polyhedral LP threshold (§13).

For each:
- Quote the source math statement (from v9_consolidated.md / exposition_v9.tex).
- Quote the Lean signature (from v9_appendix.lean — file should be in project sources).
- Assess: MATCHES / WEAKENED / STRENGTHENED / MIS_HYPOTHESIZED / MIS_CONCLUDED / VACUOUS_RISK / CERTIFICATE_VERIFIER.

# Critical context

Most of the headline theorem PROOFS use the certificate-verifier pattern: their bodies are `exact data.<witness>` projections. The data structures (FiniteMenuData, BinaryCapstoneData, FBNFPackage, RegPackage) carry the conclusion content as witness fields.

This means several headlines should be assessed as **CERTIFICATE_VERIFIER** — the theorem looks like it proves a derivation but is structurally "if certificate, then conclusion."

Two exceptions (recent honest discharges):
- `«Hall-WTA-reopening-threshold-D»` — proved by `div_le_iff₀ + nlinarith`. Real proof.
- `«T2-alpha-zero-singleton-prior-strategy»` — calls `AlphaZeroSingletonData_exists` which is now ACTUALLY proved from v8 primitives + Inventory.V9 axioms (no smuggling). Real construction. (Auditors: cross-check this is correctly stated against the source's α=0 endpoint claim.)

# Special items to verify

A. WTA threshold formula: The Lean theorem proves
   `((-2 * α * D + (1 - α) * (4/9) ≤ 0) ↔ ((2 * (1 - α)) / (9 * α) ≤ D))`.
   Both source memos (v9_executive_summary.md L80 + v9_consolidated.md §B.5) were patched 2026-05-21 from the wrong-reciprocal `D ≥ 9α/(2(1-α))` to the correct `D ≥ 2(1-α)/(9α)`. Verify Lean matches the corrected source.

B. T2 wrapper takes `(plc : PosteriorLawConsistency model) (prs : ProfileRealizationSetup model) (msupp : MessageSupportM model)` in addition to `pd` and `hα`. The source claims α=0 unconditional, but the Lean version requires additional v8 model primitives. Is this acceptable as v9 ledger semantics? (The structures ARE v8 primitives — they exist in v8_main.lean — but they're now explicit arguments rather than absorbed into RobustTrustModel.)

C. Headlines #1, #3, #4, #5 are CERTIFICATE_VERIFIER (their bodies are field projections). Explicitly note this for each.

# Output

Per `8a_lean_headline_translation_soft.md` format. Machine-readable `headline_translation` block first, then per-headline audit with quoted source statements, quoted Lean signatures, and categorical assessments.

OVERALL verdict: FAITHFUL / PARTIAL / UNFAITHFUL. Count of CERTIFICATE_VERIFIER assessments separately.

Cite line numbers in v9_appendix.lean.
