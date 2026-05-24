Implemented in [lean/v9_appendix.lean](<C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean:1861>).

Changes:
- Removed the structural `regPsi_le_fiber_integral` field from `FBNFPackage`; also removed the now-unused auxiliary `FBNFFoliationData.regPsi_le_fiber_integral` field.
- Added concrete F4 B/G fiber-alignment inputs:
  - `fbnf_B_fiber_alignment`
  - `fbnf_G_fiber_alignment`
- Added `FBNF_calibrated_kernel_exists` with the narrow TODO inside the fiberwise Strassen/B1/trust-band-to-integrated kernel construction.
- Reintroduced `FBNFPackage.regPsi_le_fiber_integral` as a derived theorem, not package data.
- Reworked `PsiNonpos_of_FBNFPackage` to close through `regPsi_nonpos_of_calibrated_kernel`, matching the Phase 12a common pattern.
- Updated the three FBNF corollary package constructors for the new fields.

Verification:
- `lake build MathlibStarter.V9Main` passed, exit 0, 8264 jobs, in the writable MathlibStarter mirror.
- Actual axiom declarations remain `9`.
- Grep confirms no structural `regPsi_le_fiber_integral :` / `:=` remains in `lean/v9_appendix.lean`.