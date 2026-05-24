Implemented Phase 12e VariableMargin refactor.

Build: `lake build MathlibStarter.V9Main` passed, exit 0.

Summary:
- Removed `VariableMarginP2Hyp.regPsi_le_densityCap_minus_eta_integral`.
- Removed the now-unused `integrable_densityCap_minus_eta` primitive.
- Added concrete variable-margin kernel data: `kappa0`, `kappa0_supported_on_G`, `ballAbsorbsCone_qae`, `posterior_displacement_le_densityCap`, and qκ₀-a.e. `densityCap_le_eta_ae`.
- Added `VariableMarginP2_calibrated_kernel_exists`.
- Reworked `PsiNonpos_of_VariableMarginP2Hyp` to construct/calibrate the kernel and call `regPsi_nonpos_of_calibrated_kernel`.

Counts:
- `sorry` delta: 0. `lean/v9_appendix.lean` remains at 4 actual `sorry`s.
- Inventory V9 axioms unchanged: 9.

Sync completed byte-preserving: regenerated `lean/main.lean` from `v8_main + v9_appendix` and copied to `MathlibStarter/V9Main.lean`.