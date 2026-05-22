ROLE — Lean Smuggling Auditor. Audit Hall round 5 state.

# Background

Round 5 reverted round 4's 3 smuggled CONCLUSION_AS_FIELD fields from RegPackage and built `RegPackage.toExactContact` bridge instead. The new RegPackage has 6 fields beyond v8 reuse:

1. `message_in_bayes_cone : ∀ m : model.M, model.inclM m ∈ B m`
2. `source_in_rowwise_bayes_cone : ∀ s m', m' ∈ G s → model.inclM s ∈ B m'`
3. `exactContact : ExactContact model σstar` (structural data bundle from v8)
4. `G_subset_rowwiseContactG : ∀ s, G s ⊆ RowwiseContactG model exactContact.cdagger s`
5. `kernelSupportedOn_v8_of_v9 : ∀ κ, KernelSupportedOnRegG model G κ → KernelSupportedOnG model exactContact.cdagger κ` (subagent admits "morally derivable from G_subset + measurability, exposed as primitive to keep bridge axiom-free")
6. `σstar_attains_UStarFull : RobustPayoffFull model σstar = UStarFull model`

# Audit task

Adversarially classify each NEW field:
- LEGITIMATE Reg-2 structural hypothesis (data bundle or standard sup-attainer / consistency claim).
- SMUGGLED_CERTIFICATE (data-witness path bundling a Hall theorem conclusion).
- DERIVABLE_FACT_AS_FIELD (would be provable from the other primitives, e.g. #5).

Specifically scrutinize:
- Is `exactContact : ExactContact model σstar` (which has its own nested sub-fields opt, wlabel, cdagger, selector, sigma_implements_wlabel) a legitimate data bundle, or does it carry hidden conclusion content?
- Is `kernelSupportedOn_v8_of_v9` (subagent admits derivable) smuggled?
- Does any Hall theorem now have body `exact reg.<some_new_field>` projecting from a conclusion-shaped field?

Also sweep:
- Total axioms in Inventory.V9 (target 8: 5 originals + 3 cited bridges). Confirm each has paper citation.
- Total sorries in v9_appendix.lean (target ≤14, mostly Binary/FBNF/v8 pre-existing).
- The 1 remaining Hall sorry (Pγα calibration, documented Bogachev barycenter gap): is it acceptable as a documented narrow gap?

# Output

Per soft prompt `8b_lean_smuggling_check_soft.md`. OVERALL verdict:
- Clean: YES / NO
- Severity: NONE / LOW / MEDIUM / HIGH / CRITICAL
- Per-field assessment for the 6 new fields.
- Recommendation: ACCEPT / FURTHER_DERIVE / REVERT_SPECIFIC_FIELD.

Line numbers in v9_appendix.lean.
