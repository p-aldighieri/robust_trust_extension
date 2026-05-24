Implemented in `lean/v9_appendix.lean` and regenerated `lean/main.lean`.

Build: `lake build MathlibStarter.V9Main` passed, exit 0, 8264 jobs, using the ACL fallback writable MathlibStarter project. The fallback `V9Main.lean` hash matches `lean/main.lean`.

Sorry delta: 0. `lean/v9_appendix.lean` remains at 47 live `sorry` lines.

Axioms: unchanged. Static active axiom declarations remain 9.

P4 derivation change: `PsiNonpos_of_P4Hyp` no longer closes by directly calling `P4_calibrated_kernel_exists` plus `regPsi_nonpos_of_calibrated_kernel`. It now proves each `y` by the radial/reflection-balance route:
`regPsi ≤ ∫ reflectionBalance dτM`, then `∫ reflectionBalance dτM = 0`.

The reflection cancellation now visibly consumes `radialSymmetry_involutive`, `radialSymmetry_tauM_preserving`, and `reflectionBalance_antisymmetric`. The P4 upper-bound theorem opens the deterministic antipodal route `κ := hyp.antipodalKernel`, with support coming from `radialSymmetry_mem_G`, so the radial routing data is explicit in the P4 path.