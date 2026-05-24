Implemented in [lean/v9_appendix.lean](<C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean:3150>).

Build: `lake build MathlibStarter.V9Main` passed, exit 0, 8264 jobs, using the writable MathlibStarter ACL fallback. Direct copy to `C:\Users\Public\Documents\Lean\MathlibStarter\...` was denied; `lean/main.lean` was regenerated and copied to the fallback target.

Verification:
- Deleted-field grep: no remaining `regPsi_le_singleCrossingIntegrand_integral` or `regPsi_le_polyhedralFacetIntegrand_integral`.
- Sorry count delta: `10 -> 12` actual proof holes. The two added sorries are the narrow Phase 12j calibrated-kernel construction gaps.
- Axiom count: 9 live `axiom` declarations, unchanged.

Refactor summaries:
- AffineMLR: removed the structural upper-bound field; added `AffineMLRSingleCrossingPrimitive.calibratedKernelExists`, consuming affine foliation, single-crossing endpoint/MLR data, dominance, and integrand facts, then `PsiNonpos_of_AffineMLRSingleCrossingPrimitive` closes via `regPsi_nonpos_of_calibrated_kernel`.
- PolyhedralScalarizable: removed the structural upper-bound field; added `PolyhedralScalarizablePrimitive.calibratedKernelExists`, routing through polyhedral facet flow/scalarization data, then `PsiNonpos_of_PolyhedralScalarizablePrimitive` closes via the same common kernel pattern.

`SphericalRadialFBNFPrimitive` was not modified.