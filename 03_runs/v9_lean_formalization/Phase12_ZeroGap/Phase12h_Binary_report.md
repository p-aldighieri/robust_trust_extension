Implemented in [lean/v9_appendix.lean](</C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean:1501>).

Changes:
- Removed the `regPsi_le_binaryIntegrand_integral` structural field from `BinaryCapstoneData`.
- Added derived theorem `BinaryCapstoneData.regPsi_le_binaryIntegrand_integral` at [line 5938](</C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean:5938>).
- Added `BinaryCapstoneData.calibratedKernelExists` at [line 5993](</C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean:5993>), with narrow TODOs inside the binary endpoint-pasting/calibration derivation.
- Reworked `PsiNonpos_of_BinaryCapstoneData` at [line 6041](</C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean:6041>) to use `regPsi_nonpos_of_calibrated_kernel`.
- Updated `binary-L_B6-capstone` to pass B1+B2+B3+B4+B5 into the new theorem chain.

Verification:
- Current concatenated source type-checked with `lake env lean ...` from the external `MathlibStarter` environment, exit 0.
- Exact `lake build MathlibStarter.V9Main` could not be run against the patched source because the repo root has no Lake config and the configured `MathlibStarter/V9Main.lean` target lives outside the writable sandbox.
- Inventory axiom declarations remain 9.