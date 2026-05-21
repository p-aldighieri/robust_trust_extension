
========
ROLE: user (id=3760b4f1-af19-40da-8994-aa2ebe19a4e0)
========
main.lean.txt
Document
AUDIT REQUEST — skeptical, adversarial.

Attached: main.lean — a Lean 4 / Mathlib 4.29 formalization of an extension of Theorem 2 in Dworczak–Smolin "Robust Trust".

The file has exactly 3 sorrys, all inside a top-level namespace Inventory block at the top (the three theorems are measurable_argmax_selector, krn_borel_right_inverse, kernel_infimum_epsilon_selection). The rest of the file is the namespace RobustTrustV8 proof and is sorry-free + axiom-free as far as I know.

Two independent assessments, please:

## Part A — Audit namespace RobustTrustV8 (everything BELOW the Inventory block)

1. Any axiom declarations? (Should be zero.)
2. Any hypothesis smuggling? (Free hypotheses sneaked into proof bodies, haveI : SomeClass := sorry, conjured typeclass instances, terminal cases that hide cases, vacuous-field structures, etc.)
3. Any trickery? (Definitions secretly containing the conclusion; by exact?-style appeals hiding non-trivial deps; theorems whose conclusion is definitionally True; convert chains changing the goal; etc.)
4. Confirm Tier 2 hypotheses (EXACT-CONTACT + MENU-HALL) are *bound assumptions* to the Tier-2 theorem statement, not blanket axioms/globals.
5. Confirm atomlessness of τ is scoped to the **sharpness package only** (used by wta_no_free_dust-style statements), NEVER inherited by Tier 1a / 1b / 2.

Verdict: PASS or list concerns with line numbers.

## Part B — Audit namespace Inventory (the 3 remaining sorry'd stubs)

For each of:
- Inventory.measurable_argmax_selector
- Inventory.krn_borel_right_inverse
- Inventory.kernel_infimum_epsilon_selection

classify as **LEGIT-EXTERNAL** (legitimate Mathlib-style external invocation; well-known result a measure-theory library should supply) / **HIDDEN-WORK** (sneaks in substantive proof content that should have been done as part of v8) / **BORDERLINE**, with a one-paragraph justification.

If LEGIT-EXTERNAL: cite the closest Mathlib lemma name (if known) or textbook reference (e.g. "Kuratowski-Ryll-Nardzewski 1965", "Bertsekas-Shreve Prop 7.50", "Castaing-Valadier 1977 III.22").

If HIDDEN-WORK: identify which part of the v8 proof is being sneaked in via the stub.

## Output


PART A — namespace RobustTrustV8
  verdict: PASS | FAIL
  findings: ...

PART B — namespace Inventory
  measurable_argmax_selector: LEGIT-EXTERNAL | HIDDEN-WORK | BORDERLINE
    justification: ...
  krn_borel_right_inverse: ...
  kernel_infimum_epsilon_selection: ...


Show more

========
ROLE: assistant (id=38a1b02c-6c11-4c15-8d19-a8aa4ecfdaf1)
========
PART A — namespace RobustTrustV8
verdict: PASS, textual audit only. I did not recompile Lean in this environment.

findings:

Axioms / sorries. I found no axiom, constant, opaque, unsafe, admit, exact?, or sorry below namespace RobustTrustV8. The only three sorrys are the three Inventory stubs at lines 29, 45, and 66; RobustTrustV8 begins after end Inventory, at line 85. 

main.lean

 

main.lean

Hypothesis smuggling. I do not see proof-body smuggling: no haveI : SomeClass := sorry, no local free hypotheses conjured from thin air, no terminal cases hiding an impossible branch, and no exact?-style oracle detours. The strong objects are packaged as explicit structures or theorem parameters. For example, ProfileRealizationSetup explicitly carries continuity, compactness, convexity, surjectivity, and fiber hypotheses; MessageRestrictionBridge explicitly carries the full-to-M restriction and M-to-full extension data; PosteriorDisintegration explicitly carries the disintegration identities tying the posterior kernels to the actual couplings. 

main.lean

 

main.lean

 

main.lean

Minor stylistic warning, not a failure: epsilon_adversary_realization uses a broad first | exact ... search over several possible α-field names, but the actual model fields are model.α_nonneg and model.α_le_one; this is noisy tactic style, not hypothesis creation. Lines 3539-3571.

Trickery / definitional vacuity. I do not see the main theorem collapsing to True. Tier2Result does contain one decorative trivial conjunct, let βstar := κ; βstar = κ, but the rest of the statement still demands nontrivial adversariality, value equality, Definition-2 QAE, and α-positive Bayes optimality. 

main.lean

 MenuHall.calibration is a strong assumption, but it is not hidden: it is a field of MenuHall, and the Tier-2 theorem separately proves the bridge from Pγα to Pβ via the PosteriorDisintegration identities. 

main.lean

 

main.lean

Tier-2 assumptions are bound, not global. PASS. ExactContact is a structure parameterized by σstar, with selector/support/implementation fields. MenuHall is a structure parameterized by pd, σFull, ec, and κ, with support, q-identities, and calibration fields. 

main.lean

 Tier2Result explicitly takes both ec : ExactContact ... and mh : MenuHall ...; the final package quantifies over pd ec κ mh before producing Tier2Result. 

main.lean

 The final theorem also introduces them locally with intro pd ec κ mh, then calls the Tier-2 theorem. 

main.lean

Atomlessness scope. PASS. NoAtoms appears only through AtomlessTauSharpness, whose sole field is noAtoms : NoAtoms wta.τ. 

main.lean

 It is required by WTA_NoFreeDustStatement and by the sharpness theorems wta_no_free_dust / sharpness_corollary, not by Tier 1a, Tier 1b, or Tier 2. 

main.lean

 

main.lean

PART B — namespace Inventory

measurable_argmax_selector: BORDERLINE
justification: This is a recognizable measurable maximum plus measurable argmax-selection theorem. It is not secretly the robust-trust conclusion; in the file it is used to build measurable aligned-best menu labelings, for example in compact_menu_aligned_selection and aligned_best_labeling_selection. 

main.lean

 

main.lean

 The reason I mark it BORDERLINE rather than clean LEGIT-EXTERNAL is that the stub’s statement is more general than the usual theorem: it assumes only [TopologicalSpace Y] [MeasurableSpace Y] [CompactSpace Y] [Nonempty Y], with no explicit StandardBorelSpace, Polish/Souslin, second-countability, or Borel compatibility hypothesis on the choice space. Standard references usually need a standard-Borel/Polish-style setting plus closed or compact nonempty values. Closest references: Kuratowski–Ryll-Nardzewski measurable selection theorem; Castaing–Valadier measurable multifunction results; Aliprantis–Border measurable maximum theorem. In the actual v8 applications, the target is a compact subtype of the finite-dimensional payoff-profile space, so the intended use looks legitimate; the stub as globally stated is the smudgy edge of the map.

krn_borel_right_inverse: LEGIT-EXTERNAL
justification: This is a Borel right-inverse theorem for a continuous surjection with nonempty compact fibers between standard Borel/Borel topological spaces. That is exactly the sort of result supplied by Kuratowski–Ryll-Nardzewski / measurable-section machinery. The file uses it narrowly in profile_map_has_borel_right_inverse to choose a measurable private strategy realizing each payoff profile, after deriving continuity, surjectivity, compact fibers, and nonempty fibers for ΦW; the call is at lines 963-966. 

main.lean

 This is external profile-realization infrastructure, not hidden Tier-2 calibration or adversarial attainment. Closest references: Kuratowski–Ryll-Nardzewski 1965; Aliprantis–Border Theorem 18.13-style measurable selection/right-inverse results.

kernel_infimum_epsilon_selection: BORDERLINE
justification: This is the most load-bearing Inventory stub. It supplies the measurable ε-selection/interchange lemma saying that, for bounded measurable g, the infimum over Markov kernels has the value ∫ sInf (range (g s)) dτ, up to ε selection plus the obvious lower bound. The file uses it directly in adversary_infimum_pointwise to turn pointwise rowwise infima into an infimum over measurable adversary kernels. 

main.lean

 

main.lean

 This is standard stochastic-control/selection technology, not a bespoke v8 theorem, but it is not a tiny Mathlib bookkeeping lemma either. The delicate point is Borel versus universally measurable ε-selectors on arbitrary standard Borel action spaces; the statement likely needs careful library-side formulation, possibly “universally measurable selector, then τ-a.e. Borel modification” or a kernel-valued measurable selection theorem. Closest references: Bertsekas–Shreve, especially ε-optimal measurable-policy selection results such as Prop. 7.50; Brown–Purves/Jankov–von Neumann measurable selection; normal-integrand interchange theorems. I would not call it HIDDEN-WORK, but it is the stub most worth pinning down before claiming the Lean port is fully sealed.
