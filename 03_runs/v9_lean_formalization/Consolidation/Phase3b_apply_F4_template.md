ROLE — Lean 4 / Mathlib prover, PHASE 3b. Opus.

# Mission

Phase 3a established a powerful template:
- `PsiNonpos_of_regPackage : ∀ reg : RegPackage model, PsiNonpos model reg` is now a proved lemma (v9_appendix:L3407) using ONLY RegPackage's structural Reg-2 primitives.
- F4 capstone derivation: `set reg := pkg.regBridge; have hPsi := PsiNonpos_of_regPackage reg; have hKernel := («Hall-biconditional» reg).mpr hPsi; exact robustRationalizableKernelExists_to_strategy reg hKernel` (with `pkg.regBridge_pd_eq` rewrite).

Apply this template to close the remaining 7 sorries that follow the same shape.

# 7 remaining sorries

Locations (from grep):

1. L2697 — B5 binary stationarity (T1 scalar projection at k=2)
2. L2747 — B6 binary capstone → QAE (apply template)
3. L3707 — P2* cone-margin → Ψ ≤ 0 (apply template OR derive geometrically)
4. L3739 — P3 polyhedral → Ψ ≤ 0 (apply template)
5. L3773 — P4 radial antipodal → Ψ ≤ 0 (apply template)
6. L3995 — Variable margin → Ψ ≤ 0 (apply template — IF VariableMarginP2Hyp has a reg field; otherwise add one)
7. L4027 — Graph FBNF → QAE (apply template — add regBridge field to GraphFBNFPackage)

# Application strategy

For each of B6, Graph FBNF, and 4 P-class theorems:

1. Verify the hypothesis structure has a `reg : RegPackage model` field (P2/P3/P4/VarMarginP2 might already; B6 needs adding regBridge to BinaryCapstoneData or as a theorem argument; Graph FBNF needs regBridge field on GraphFBNFPackage).

2. Theorem body:
   ```lean
   set reg := hyp.reg  -- or pkg.regBridge
   have hPsi : PsiNonpos model reg := PsiNonpos_of_regPackage reg
   have hKernel : reg.robustRationalizableKernelExists := («Hall-biconditional» reg).mpr hPsi
   have hStrat : HasRobustRationalizableStrategy model reg.pd := robustRationalizableKernelExists_to_strategy reg hKernel
   ```
   Then rewrite `reg.pd ↔ hyp.<pd>` and conclude.

3. For P-class theorems: the geometric hypothesis primitives (cone-margin, polyhedral, radial, variable margin) become DOCUMENTATION of why the constructed reg has the required Reg-2 properties. They aren't directly invoked in the theorem body (the body uses reg's primitives). This is structural — the geometric data CONSTRAINS what reg has to look like, but the theorem proves something about reg.

# Special case: B5

L2697 is the T1 scalar projection at k=2. Different shape — doesn't follow the F4 template.

**Strategy for B5**: invoke `_hT1 2 data.endpointMenu` to get `multiplierBayesCone`. Project to the scalar equality.

If genuinely needs hand-derivation that's too involved, leave the narrow sorry (this is the one residual that's NOT a RegPackage→strategy story).

# Hall Pγα (L2959)

Already closed in Phase 1 via `bayesian_barycenter_in_closed_convex` axiom which Phase 2 KEPT (with guardrail flag). The Lean statement may be v9-specific in shape (`reg.pd.Pγα κ m ∈ reg.B m` rather than a generic Bogachev statement). Phase 2 audit recommended splitting into generic Bogachev + Lean-side derivation, but kept for now.

NOT in scope for this round. Leave as-is.

# Constraints (BLOCKING)

- NO new axioms (Inventory.V9 stays at 9).
- ADD `regBridge : RegPackage model` field to:
  - BinaryCapstoneData (for B6)
  - GraphFBNFPackage (for Graph FBNF)
  Plus the `_pd_eq` compatibility field. Mirror pkg.regBridge / FBNFPackage pattern from Phase 3a.
- For P2/P3/P4/VarMarginP2: their reg field (named `reg` per earlier work, likely) is the bridge — use it directly.
- Build MUST PASS.
- Cap at 6 iterations.
- NO smuggling — the new regBridge fields ARE legitimate structural primitives (RegPackage is a data bundle, not a conclusion-shaped Prop).

# Files

- Edit: `lean/v9_appendix.lean`
- Read-only: `lean/v8_main.lean`

# Output

Concise report (under 400 words): build status, FINAL sorry count (target: 1 = B5 only, plus the kept Bogachev axiom for Hall Pγα), axiom count (9 unchanged), new structural fields added, per-sorry resolution.
