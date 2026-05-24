Phase 12c — P3 zero-gap via derived theorem. Same pattern as Phase 12b (P2*).

Read design at:
`C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/03_runs/v9_lean_formalization/Phase12_ZeroGap/Brainstorm_Reg2_derivation_response.md`

Section 2 covers P3 polyhedral.

Goal:
1. P3Hyp currently has the 6-substructure refactor (Phase 11 P3) + 2 structural fields `lp.regPsi_eq_finite` (LP equation) + `lp.dual_eval_eq_finitePsi` (Farkas dual equation). The current PsiNonpos_of_P3Hyp closes via these structural fields + Inventory.V9.farkas_lp_duality_conic.
2. DERIVE these fields as theorems (no longer structural). Use Phase 12a common pattern:
   a. Construct a calibrated kernel from P3FiniteFlowLP data + farkas_lp_duality_conic.
   b. Verify it's supported on reg.G and posterior in reg.B q-a.e.
   c. Invoke `regPsi_nonpos_of_calibrated_kernel` from Phase 12a.
3. DELETE `lp.regPsi_eq_finite` and `lp.dual_eval_eq_finitePsi` if possible — they should become theorems derived from concrete LP data.

If the matrix-algebra identification of Farkas dual with finite Ψ is genuinely intractable in budget, leave narrow TODOs INSIDE the derivation (not as structural fields on P3FiniteFlowLP).

Build MUST PASS via lake build MathlibStarter.V9Main (exit 0). 9 axioms unchanged. Edit ONLY lean/v9_appendix.lean (don't touch MathlibStarter/V9Main.lean directly; the sync is: cat v8_main.lean v9_appendix.lean > main.lean; cp main.lean /c/Users/Public/Documents/Lean/MathlibStarter/MathlibStarter/V9Main.lean).

Final report under 400 words: build status, sorry count delta, axioms, P3 refactor summary.
