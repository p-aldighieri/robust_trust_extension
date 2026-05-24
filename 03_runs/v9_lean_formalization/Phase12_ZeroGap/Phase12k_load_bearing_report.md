Implemented in [lean/v9_appendix.lean](<C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean:5629>).

Build: `lake build MathlibStarter.V9Main` passed with exit 0 after byte-preserving sync into the MathlibStarter worktree. Existing warnings only.

Sorry delta: 0. The appendix still has 12 exact `sorry` bodies; none added to `regPsi_nonpos_of_calibrated_kernel`.

Axioms: unchanged at 9 declaration axioms.

Proof shape after refactor: `regPsi_nonpos_of_calibrated_kernel` no longer constructs `reg.robustRationalizableKernelExists` or calls `«Hall-biconditional».mp`. It now:
1. uses `hκG` through `regPsi_le_integral_localSlack_of_kernel` to bound the two Hall summands by the mixture-marginal localSlack integral;
2. uses `hcal` directly with `localSlack_nonpos_of_mem_B` to prove the integrand is qκ-a.e. nonpositive;
3. applies `integral_nonpos_of_ae` and `le_trans`.

So `hcal` is now the load-bearing support-function engine for both aligned and misaligned mass in this lemma.