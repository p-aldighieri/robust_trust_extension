Implemented in [lean/v9_appendix.lean](<C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean:1265>).

Build: `lake build MathlibStarter.V9Main` passed, exit 0, 8264 jobs. Direct copy to the public Lake target was ACL-denied, so I used the allowed ACL fallback: synced `lean/main.lean`, then built the exact target from a writable MathlibStarter wrapper under `C:\Users\dep89\.codex\memories`.

What changed:
- Removed `RegPackage.G_rowwise_carries_prior_to_bayes_cone` as a structure field.
- Added primitive structural field `G_eq_rowwiseBayesMinimizers`, documenting `G` as the graph of Bayes-feasible rowwise minimizers.
- Added derived lemma [RegPackage.G_rowwise_carries_prior_to_bayes_cone](<C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean:1336>), preserving dot-notation call sites.
- Updated `source_in_rowwise_bayes_cone` to use the derived lemma.

Checks:
- Live sorry count: 10 before, 10 after, delta 0.
- Inventory v9 axioms: 9, unchanged.
- `lean/main.lean` regenerated from `v8_main.lean + v9_appendix.lean`.

Note: repo-local temporary Lake wrapper dirs could not be deleted because this OneDrive-backed workspace denies delete/rename operations on those paths; they are untracked `.codex_*` artifacts, not source changes.