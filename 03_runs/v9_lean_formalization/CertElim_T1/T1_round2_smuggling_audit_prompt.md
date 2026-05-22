ROLE — Lean Smuggling Auditor. Round-2 verification of T1 cert-elim refactor. Per `prompts/soft/8b_lean_smuggling_check_soft.md` (MathPipeProver b96461f, certificate-verifier classified as SMUGGLED_CERTIFICATE).

# Context

Round-1 T1 cert-elim was caught by the previous smuggling audit (HIGH severity). The three flagged fields — `normal_cone_inequality`, `g_nonneg`, `mass_balance` — were SMUGGLED_CERTIFICATE pulled out of `ParetoMenuPrimitives` and re-derived in round 2 (Codex CLI gpt-5.5 xhigh, commit shortly before this audit).

The round-2 patch:
- Removed all 3 fields from `ParetoMenuPrimitives` (line 724).
- Added `gOf`, `qOf` as `noncomputable def`s at module scope.
- Added `mass_balance_gOf_qOf` theorem at line 334 (Fubini + simplex sum derivation).
- Added `ProductClarkeFermatPrimitive` structure at line 765 to bundle Clarke-Fermat hypothesis input.
- Added 1 new Inventory.V9 axiom `clarke_product_normal_cone_projection_bridge` at line 420, cited to Clarke 1990 §6.2 + Aubin–Frankowska Ch.6 (per user policy: paper-source required).
- `g_nonneg`, `mass_balance`, `normal_cone_inequality` are now THEOREMS at lines 779, 793, 799 inside namespace `ParetoMenuPrimitives`, deriving from primitive Clarke-output inputs.
- `FiniteMenuData.fromParetoMenu` at line 861 now uses these theorems (not field projections) to populate FiniteMenuData fields.

# Audit task

Verify the round-2 refactor is ACTUALLY ledger-sound, not just relocating smuggling deeper.

Specific items to scrutinize:

1. **`ProductClarkeFermatPrimitive`** (line 765) — does it contain bare `Prop` conclusion-shaped fields, or only the Clarke axiom's OUTPUT (existence of subgradient + representation)?

2. **`clarke_product_normal_cone_projection_bridge`** axiom — verify the paper citation is real and the conclusion is a standard normal-cone projection (NOT just the desired downstream claim).

3. **`ParetoMenuPrimitives` (line 724)** — list ALL remaining fields. Confirm each is either:
   - A raw input (paretoMenu, lamPlus, lamMinus, …)
   - A regularity property of an input (lamPlus_nonneg, measurable, …)
   - NOT a conclusion-shaped Prop

4. **`g_nonneg`/`mass_balance`/`normal_cone_inequality`** theorems (lines 779/793/799) — verify their bodies are real derivations, not `:= by exact prim.<field>` projections from a smuggled subfield.

5. **`FiniteMenuData.fromParetoMenu`** (line 861) — verify each field assignment uses the new theorems, not a `prim.<field>` projection.

6. Other smuggling sweep: any new `sorry`, `axiom`, `opaque`, `Classical.choice` abuse, `noncomputable section` hiding something, or bare `Prop` fields in any structure (FBNF, Binary, Hall — those still need work but should not have regressed).

# Output

Per `8b_lean_smuggling_check_soft.md` format. Final verdict OVERALL: is the T1 cert-elim round 2 honest? Or has the smuggling moved deeper again?

Severity scale: NONE / LOW / MEDIUM / HIGH / CRITICAL.
Recommended next step: ACCEPT, FURTHER_DERIVE, or REVERT.

Cite line numbers in v9_appendix.lean.
