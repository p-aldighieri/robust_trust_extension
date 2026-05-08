# Exact Route 1 Strategy Beyond Finite `M`

## Route

Keep the exact theorem alive under the current standing assumptions by working in the reduced game on the compact convex payoff set `W`, but revise the upstream existence route after the accepted kernel-topology obstruction.

## Trusted Starting Point

- The finite-`M`, compact-metric-`Theta` extension is already trusted.
- Appendix A.1 gives the compact convex payoff set `W` and the weak Pareto frontier facts.
- The selector package and exact version-and-patching lemma on `W` are trusted conditional tools.
- The old measurable-kernel compactness step is now blocked by an accepted obstruction.

## Dependency Skeleton

1. Reduce the original game to a reduced relaxed game on kernels `gamma: M \rightsquigarrow \Delta(W)`.
2. Replace the blocked full-kernel compactness lemma with a repaired upstream existence route.
3. Represent the repaired reduced saddle through posteriors and obtain `q*`-almost-everywhere local optimality.
4. Collapse the relaxed saddle barycentrically to a deterministic selector `bar w`.
5. Use the already trusted selector package on `W`.
6. Patch the `q*`-null bad set to obtain exact messagewise Bayes optimality without losing the saddle inequalities.

## Accepted Obstruction

The old step 2 is false as stated under the current imports.

Blocked claim:

- compactness of the full adviser-kernel space together with continuity of `beta -> G(beta, g)` for every deterministic measurable selector `g : M -> W`

Mechanism:

- arbitrary Borel messagewise selectors include indicators of countable Borel sets
- continuity against all such selectors forces a setwise-type continuity on induced message laws
- on infinite `M`, that requirement is incompatible with compactness of the full kernel space

Minor repair still needed in the obstruction note:

- explicitly realize the uniform posterior law `tau` by a primitive signal structure inside the paper’s model

## Current Critical Lemma

The old hinge was the exact version-and-patching saddle lemma:

- start from a deterministic reduced saddle `(beta*, bar w)`
- patch the `q*`-null bad set so that the modified selector is Bayes-optimal at every message
- preserve the adviser-side saddle inequalities against every admissible `beta`

This target is now blocked under the standing assumptions.

Reason:

- the reviewer-cleared split lemma shows that the fixed-`gamma` compactification is exact only at the level of values
- exact raw attainment / exact measurable lifting can fail because compactified minimizers may sit at closure points of the raw image `m -> \\bar w_gamma(m)` that are not realized by any raw message

Trusted local sources:

- `Context Management/logs/20260312T231155Z_prover_adviser_induced_law_compactness_response.md`
- `Context Management/logs/20260313T000741Z_prover_foreground_followup_response.md`
- `Context Management/logs/20260313T005332Z_reviewer_exact_route_value_vs_lift_response.md`

## Trusted Conditional Subpackage

Conditionally on the reduced-game Lemmas 1 to 4, the following block is now reviewed and trusted:

1. the dominating-frontier selector on `W`
2. the supporting-belief selector on the weak Pareto frontier

The exact version-and-patching saddle lemma is no longer trusted as a live route target under the standing assumptions.

## Current Repaired Route

After the atomic truncation counterexample, the best repaired route is:

- adviser-side relaxed reduced game on `W`

Source:

- `Context Management/logs/20260312T224018Z_breakdown_atomic_route_after_counterexample_response.md`

Route idea:

- do not work on the raw measurable adviser-kernel space
- do not rely on the black-box truncation-limit passage
- instead define a compact convex adviser-side class of induced objects, prove a reduced saddle there against relaxed agent kernels, and only afterwards use barycentric collapse plus the trusted exact version-and-patching lemma

## Immediate Next Scope

Do not ask for the whole theorem.

The scoped prover on the adviser-side induced-law compactness / semicontinuity lemma is now stored at:

- `Context Management/logs/20260312T231155Z_prover_adviser_induced_law_compactness_response.md`

Its local result is a split verdict:

- the fixed-`gamma` compactification is an exact value compactification
- but it is not an exact strategy compactification under the current standing assumptions

More concretely:

- the raw adviser-kernel infimum equals the compactified lower-envelope value
- but a compactified minimizer need not lift to any raw measurable adviser kernel
- exact raw attainment can fail at closure points of the image of `m -> \\bar w_gamma(m)`

The next local lemma tested after that split is now stored at:

- `Context Management/logs/20260313T000741Z_prover_foreground_followup_response.md`

That draft proves:

- exact no-gap at the level of values
- a counterexample to exact measurable lifting / exact raw attainment in general

Operational meaning:

- the exact route under current standing assumptions is now blocked at the strategy-attainment level
- the surviving object is a value theorem or a route with an added assumption ensuring exact measurable lifting

Immediate next role:

- scoped prover on the least-strengthened exact theorem route

The next planning question is no longer “can exact lifting be proved under the current assumptions?” That question is settled negatively. The new question is:

1. what is the weakest explicit added assumption that restores exact raw lifting / exact raw attainment
2. whether that assumption still leaves a mathematically interesting exact theorem beyond finite `M`
3. what the first local lemma should be once that assumption is fixed

## Least-Strengthened Exact Route

The new top-ranked added assumption is:

- saddle-specific continuity of the collapsed selector

Concrete form:

- after the reduced-game saddle existence and barycentric collapse steps, assume there is a deterministic reduced saddle `(beta*, bar w*)` such that `bar w* : M -> W` is continuous

Why this is the best route:

- it targets the exact trusted obstruction
- it is local to the actual collapsed saddle rather than a uniform condition on every admissible `gamma`
- it is cleaner and less ad hoc than assuming a measurable right inverse directly

First local lemma:

- continuous-image exact raw lifting lemma

Statement to prove:

- if `bar w : M -> W` is continuous, then every compactified adviser kernel on `bar w(M)` admits a raw measurable lift `beta : M \\rightsquigarrow \\Delta(M)` with `bar w_# beta = kappa`

Operational consequence:

- if this lemma works, the exact route can be reopened under one clearly labeled added regularity assumption

## Current Local Progress On The Least-Strengthened Route

Stored prover draft:

- `Context Management/logs/20260313T131752Z_prover_continuous_image_exact_raw_lifting_response.md`
- `Context Management/logs/20260313T135825Z_reviewer_continuous_image_exact_raw_lifting_response.md`

Reviewer-cleared local conclusion:

- the continuous-image exact raw lifting lemma is proved positively
- if the collapsed saddle selector `bar w : M -> W` is continuous, then every compactified adviser kernel on `bar w(M)` admits a raw measurable lift `beta : M \rightsquigarrow \Delta(M)` with `bar w_# beta = kappa`
- adviser-side compactified minimizers can therefore be realized by raw adviser kernels under this saddle-specific continuity assumption

Operational meaning:

- the previously accepted exact-lifting obstruction is not absolute
- it is repaired by one explicit, local regularity assumption on the collapsed selector
- the least-strengthened exact route is now live beyond the planning stage
- the next step is to return to the exact version-and-patching saddle lemma under the added continuity assumption

## Current Local Progress On The Continuity-Conditioned Patching Step

Stored prover draft:

- `Context Management/logs/20260313T150558Z_prover_continuity_conditioned_exact_patching_response.md`
- `Context Management/logs/20260313T154132Z_reviewer_continuity_conditioned_exact_patching_response.md`

Current reviewer conclusion:

- the null-set monotone patching algebra itself is sound
- the first defect is upstream of the patching algebra: the continuity-based exact raw lift has not yet been shown to preserve the raw posterior / `q*`-a.e. local-optimality structure needed to define the bad set and run the patch
- without that stronger bridge, the patching lemma can only be banked in conditional form

Operational meaning:

- under the saddle-specific continuity assumption, the exact route is no longer blocked at exact raw lifting itself
- the live bottleneck is now the lift-to-raw interface: can the chosen raw lift preserve the posterior and local-optimality structure needed for patching?
- the immediate next step is a scoped prover on that lift-to-raw bridge, not another broad patching attempt

## Current Local Progress On The Lift-To-Raw Bridge

Stored prover draft:

- `Context Management/logs/20260313T161800Z_prover_lift_to_raw_bridge_response.md`
- `Context Management/logs/20260313T190845Z_reviewer_lift_to_raw_bridge_obstruction_response.md`

Reviewer-cleared local conclusion:

- the stronger bridge does not follow from the currently trusted continuity-based exact raw lifting lemma
- the current lift preserves only the collapsed reduced objective against the fixed selector `bar w*`
- that scalar equality does not provide, or imply, the raw posterior / `q*`-a.e. local-optimality structure needed to define the bad set and run the patch
- only the conditional monotone-patching lemma survives with the currently trusted inputs

Operational meaning:

- the least-strengthened exact route remains unresolved at one precise bridge
- the missing ingredient is a posterior-labeled raw lift, equivalently a raw kernel together with a Borel posterior version realizing zero average support-function gap
- the immediate next step is a scoped prover on whether the lift theorem itself can be strengthened to produce that posterior-labeled raw object

## Current Local Progress On The Strengthened Lift Theorem

Stored prover draft:

- `Context Management/logs/20260313T193710Z_prover_strengthened_lift_theorem_response.md`
- `Context Management/logs/20260313T195653Z_reviewer_strengthened_lift_obstruction_response.md`

Reviewer-cleared local conclusion:

- the lift theorem cannot be strengthened in the requested posterior-labeled sense from the currently trusted hypotheses alone
- the continuity-based exact raw lift preserves exact image lifting and objective functionals that depend on the raw message only through `bar w*(m')`
- that is not enough to produce a Borel posterior version with zero average Bayes-gap or `q*`-a.e. local optimality under the lifted raw kernel
- therefore an additional assumption is unavoidable for the present bridge
- the precise missing ingredient is not merely a posterior version, but a posterior version for the chosen raw lift with zero Bayes gap, equivalently `q*`-a.e. local optimality
- the obstruction is established for the current lift-to-raw-plus-patching route, not as a global impossibility statement about every conceivable raw lift under the standing hypotheses

Operational meaning:

- the least-strengthened exact route is now live only as a conditional exact-theorem route
- under saddle-specific continuity of `bar w*`, exact raw lifting by itself still does not recover the posterior-labeled raw object needed for null-set patching
- the needed extra assumption can now be stated explicitly: the chosen raw lift admits a Borel posterior version with zero Bayes gap, equivalently `q*`-a.e. local optimality
- the next local step is no longer to search for a stronger lift theorem
- the immediate next step is a scoped reviewer on the exact version-and-patching saddle lemma under that explicit added assumption

## Current Local Progress On The Conditional Exact Patching Lemma

Stored prover draft:

- `Context Management/logs/20260313T201525Z_prover_conditional_exact_patching_response.md`
- `Context Management/logs/20260313T203949Z_reviewer_conditional_exact_patching_response.md`

Reviewer-cleared local conclusion:

- under the explicit added assumption that the chosen raw lift admits a Borel posterior version with zero Bayes gap, equivalently `q*`-a.e. local optimality, the exact version-and-patching saddle lemma goes through cleanly
- the patching construction yields a Borel selector `w*` and posterior version `p*` with exact messagewise Bayes optimality at every message
- the payoff at `beta*` is unchanged by the patch
- the adviser-side inequality transfers from the pre-patching selector to the patched selector by coordinatewise monotonicity
- the agent-side saddle inequality at `beta*` follows directly from the patched posterior representation and pointwise optimality
- the only fixes are wording clarifications: the selector package and pre-patching adviser-side inequality are imported inputs, the posterior-version identity is only `q*`-a.e., and Bayes optimality is relative to the patched Borel posterior version

Operational meaning:

- the least-strengthened exact route has now reached a reviewer-cleared conditional theorem package
- the next step is a compact summary of this exact route, separating unconditional inputs, the single added assumption, and the resulting conditional exact theorem

## Compact Route Summary

Stored summary:

- `Context Management/logs/20260313T205553Z_consolidator_least_strengthened_exact_route_response.md`

Current compact frontier:

- unconditional inputs already proved:
  - the finite-`M`, compact-metric-`\Theta` theorem
  - the reduced-game machinery on `W`
  - the selector package on `W`
  - the pre-patching adviser-side inequality at `(\beta^*, \bar w^*)`
- single explicit added assumption:
  - the chosen raw lift `\beta^*` admits a Borel posterior version with zero Bayes gap, equivalently `q*`-a.e. local optimality of `\bar w^*`
- resulting conditional theorem:
  - the exact version-and-patching saddle lemma closes, producing a full reduced-game saddle `(\beta^*, w^*)`

Operational meaning:

- the least-strengthened exact route is now summarized as a clean conditional theorem package
- the only remaining live gap on this route is to prove the Needed assumption for the chosen raw lift
- the next substantive move should focus exclusively on that Needed assumption

## Needed-Assumption Frontier Breakdown

Stored breakdown:

- `Context Management/logs/20260313T213831Z_breakdown_needed_assumption_frontier_response.md`

Current ranking:

1. bank the conditional theorem and keep the Needed assumption explicit
2. run one narrow strengthened-condition probe only as a yes/no test
3. if a stronger theorem is still required, leave this least-strengthened route and move to a different branch

Top strengthened-condition probe:

- test a fiber-rigidity condition, with the clean surrogate being `q*`-a.e. injectivity of `m \mapsto \bar w^*(m)`
- first local lemma:
  - if `\bar w^*` is `q*`-a.e. injective and the reduced saddle admits a Borel posterior label map `\hat p(w)` with `w \in \arg\max_{u \in W} \hat p(w)\cdot u`, then `p_0(m):=\hat p(\bar w^*(m))` is a posterior version under the chosen raw lift

Operational meaning:

- the honest default endpoint on this route is now the conditional theorem with the Needed assumption left explicit
- only one further short cycle is worth spending here: the narrow fiber-rigidity probe above

## Injective-Fiber Probe

Stored prover draft:

- `Context Management/logs/20260313T230943Z_prover_injective_fiber_probe_response.md`
- `Context Management/logs/20260313T233824Z_reviewer_injective_fiber_lemma_response.md`

Reviewer-cleared local conclusion:

- the narrow probe succeeds
- on the already-banked reduced-side inputs, `q*`-a.e. injectivity of `m \mapsto \bar w^*(m)` is enough to recover the Needed posterior version for the chosen raw lift
- the exact minimal fiber-rigidity condition is: there exists a `q*`-full Borel set on which `m \mapsto \bar w^*(m)` has a Borel inverse on its image
- in the present standard-Borel setting, bare `q*`-a.e. injectivity is enough to obtain that inverse structure
- the exact caveat is scope: this lemma is valid only on top of the already-banked reduced-side posterior representation and should not be advertised as the preferred general theorem hypothesis

Operational meaning:

- this gives a genuine strengthened sufficient primitive for the Needed assumption
- it does not replace the main least-strengthened route, because it is a strong and probably unnatural restriction
- the main route should still keep the Needed assumption explicit
- the next step is a compact final summary of the exact-route frontier, with the injective-fiber lemma recorded only as a strengthened corollary

## Final Frontier Summary

Stored summary:

- `Context Management/logs/20260314T051455Z_consolidator_exact_route_frontier_final_response.md`

Current exact-route frontier:

- unconditional reduced-side inputs already banked:
  - the finite-`M`, compact-metric-`\Theta` theorem
  - the reduced-game machinery on `W`
  - the selector package on `W`
  - the pre-patching adviser-side inequality at `(\beta^*, \bar w^*)`
- main least-strengthened route:
  - keep the Needed assumption explicit, namely that the chosen raw lift admits a Borel posterior version with zero Bayes gap, equivalently `q*`-a.e. local optimality of `\bar w^*`
- resulting conditional exact theorem:
  - under that explicit Needed assumption, the exact version-and-patching saddle lemma closes and yields a full reduced-game saddle
- strengthened corollary:
  - on the already-banked reduced-side posterior inputs, `q*`-a.e. injectivity of `m \mapsto \bar w^*(m)` is enough to force the Needed assumption

Operational meaning:

- the main beyond-finite-`M` exact theorem route is now cleanly summarized as a conditional theorem package
- the injective-fiber lemma is banked only as a stronger optional sufficient condition
- the only remaining live question on this route is whether the Needed assumption can be derived directly from the banked reduced-side inputs without imposing a strong fiber-rigidity hypothesis

## Raw-Message Posterior-Lifting Obstruction

Stored local artifacts:

- `Context Management/logs/20260314T061907Z_prover_raw_message_posterior_lifting_response.md`
- `Context Management/logs/20260314T063820Z_reviewer_raw_message_posterior_lifting_obstruction_response.md`

Reviewer-cleared conclusion:

- the explicit Needed assumption cannot be derived from the already-banked reduced-side inputs alone on the current lift-to-raw-plus-patching route
- the first precise obstruction is fiber non-identifiability:
  - the current bridge identifies only the collapsed law through `F = \bar w^*`
  - reduced-side data are blind to how posterior labels are assigned inside fibers of `F`
  - the Bayes-gap condition needed for patching is not fiber-invariant
- the concrete two-message construction is valid and shows that distinct admissible raw lifts can share the same collapsed information and the same adviser payoff against `\bar w^*`, while only one has zero Bayes gap `q*`-a.e.
- exact caveat on scope:
  - this is a route-local non-derivability result
  - it does not show that no good raw lift exists under the standing hypotheses
  - it does not overturn any already trusted finite-`M` theorem

Operational meaning:

- the main least-strengthened exact route remains genuinely conditional
- the Needed assumption is not removable from the currently banked reduced-side inputs alone
- any unconditional continuation on this branch must add a new raw-message posterior-labeling principle or move to a different route
- the next step is a genuinely new liftability test, not a replay of fixed-lift posterior recovery

## Post-Obstruction Branch Selection

Stored breakdown:

- `Context Management/logs/20260314T065805Z_breakdown_after_reviewer_cleared_raw_message_obstruction_response.md`

Chosen next branch:

- test a fiberwise support-plane lift, not posterior recovery on a fixed lift

First local lemma:

- determine whether there exists a raw adviser kernel `\\tilde\\beta^*` whose collapse through `F = \\bar w^*` matches the adviser side of the banked reduced saddle and whose induced raw-message posterior version satisfies `p_{\\tilde\\beta^*}(m) = \\hat p(F(m))` `q*`-a.e., where `\\hat p` is the reduced-side supporting-belief selector

Operational meaning:

- this is a genuinely new raw-message posterior-labeling principle, not one already ruled out by the fixed-lift obstruction
- if it works, it closes the only remaining unconditional gap on the strongest current exact route
- if it fails, it identifies the right explicit liftability hypothesis for the best remaining conditional theorem on this branch

## Fiberwise Support-Plane Lift Obstruction

Stored local artifacts:

- `Context Management/logs/20260314T172509Z_prover_fiberwise_support_plane_lift_response.md`
- `Context Management/logs/20260314T175216Z_reviewer_fiberwise_support_plane_lift_obstruction_response.md`

Reviewer-cleared conclusion:

- the fiberwise support-plane lift lemma is false under the standing beyond-finite-`M` inputs
- even when the reduced-side supporting posterior selector `\\hat p(w)` is fixed, one cannot in general choose a raw adviser kernel whose collapse matches the banked reduced saddle and whose raw-message posterior equals `\\hat p(F(m))` `q*`-a.e.
- the first precise obstruction is within-fiber posterior-transport feasibility:
  - truthful aligned mass already imposes message-by-message lower bounds inside each fiber of `F = \\bar w^*`
  - a constant target posterior on the whole fiber may require more total mass than probability allows
- the counterexample already appears when `W` is a singleton, so the failure is purely message-side and not a geometric defect of `W`
- exact scope caveat:
  - this is again a route-local failure of a stronger liftability idea
  - it is not a global impossibility theorem about every conceivable raw lift

Operational meaning:

- the current exact route is not reopened by this stronger choice-of-lift idea
- the best surviving exact theorem on this branch now needs an explicit fiberwise liftability / posterior-transport hypothesis
- absent a genuinely new raw-message liftability lemma, the exact beyond-finite-`M` route should now be treated as exhausted in conditional form

## Fallback

If the exact route cannot be repaired without assumption changes, the clean fallback theorem branch is the purely atomic infinite-support case.
