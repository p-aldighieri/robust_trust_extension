ROLE — Lean 4 / Mathlib prover, PHASE 5B major refactor. Opus.

# Mission

Refactor RegPackage to remove the "TOO STRONG" Reg-2 primitives (`message_in_bayes_cone`, `source_in_rowwise_bayes_cone`) that the Phase 3 audit identified as encoding the Hall conclusion. Derive them from a more primitive Bayes-cone construction.

This is the big one. The user has explicitly approved: "stay on task overnight. Try every strategy. Leave no stone untouched."

# Current state (before refactor)

```lean
structure RegPackage (model : RobustTrustModel) where
  pd : PosteriorDisintegration model
  σstar : AgentStrategyFull model
  wstar : ...
  ...
  G : model.M → Set model.M
  G_nonempty, G_compact, G_closedGraph, G_rowwise_minimizer : ...
  B : model.M → Set (Belief model.Ω)
  B_closed, B_convex_profile, B_support_continuous, B_bayes_optimal, B_graph_measurable : ...
  message_in_bayes_cone : ∀ m, model.inclM m ∈ B m              -- ⚠️ TOO STRONG
  source_in_rowwise_bayes_cone : ∀ s m', m' ∈ G s → model.inclM s ∈ B m'  -- ⚠️ TOO STRONG
  exactContact : ExactContact model σstar
  G_subset_rowwiseContactG, kernelSupportedOn_v8_of_v9, σstar_attains_UStarFull
```

Phase 3 audit finding: `message_in_bayes_cone` + `source_in_rowwise_bayes_cone` are too strong; they encode the Hall conclusion. Bundling them on RegPackage makes `PsiNonpos_of_regPackage` trivial.

# Refactor target

Add genuinely PRIMITIVE structural fields that the Bayes cones are constructed FROM, then DERIVE the two consistency lemmas. The v9 paper's §B.5 Reg-2 specifies the Bayes cone as a topologically-closed convex set constructed from the posterior-disintegration setup — there should be a construction primitive.

## New RegPackage primitive (proposed):

```lean
-- Replaces message_in_bayes_cone and source_in_rowwise_bayes_cone:
-- The Bayes cone B(m) is constructed from a primitive map:
bayesConeFromPrior : Belief model.Ω → Set (Belief model.Ω)
bayesConeFromPrior_self : ∀ μ : Belief model.Ω, μ ∈ bayesConeFromPrior μ
B_eq_bayesConeFromPrior_at_inclM : ∀ m, B m = bayesConeFromPrior (model.inclM m)
-- Reg-1 closed-graph compatibility:
G_rowwise_carries_prior_to_bayes_cone : 
  ∀ s m', m' ∈ G s → model.inclM s ∈ bayesConeFromPrior (model.inclM m')
```

Then DERIVE:
```lean
lemma RegPackage.message_in_bayes_cone (reg : RegPackage model) (m : model.M) :
    model.inclM m ∈ reg.B m := by
  rw [reg.B_eq_bayesConeFromPrior_at_inclM]
  exact reg.bayesConeFromPrior_self (model.inclM m)

lemma RegPackage.source_in_rowwise_bayes_cone (reg : RegPackage model) 
    (s m' : model.M) (hm' : m' ∈ reg.G s) : model.inclM s ∈ reg.B m' := by
  rw [reg.B_eq_bayesConeFromPrior_at_inclM]
  exact reg.G_rowwise_carries_prior_to_bayes_cone s m' hm'
```

This way:
- `bayesConeFromPrior_self` is a STRUCTURAL property of how Bayes cones are constructed (every belief is in its own Bayes cone — definitional self-consistency of the construction). NOT conclusion-shaped.
- `G_rowwise_carries_prior_to_bayes_cone` says rowwise minimizers carry the prior — a Reg-1 structural compatibility between G and the Bayes cone construction. NOT conclusion-shaped.

The Hall biconditional forward direction (`PsiNonpos_of_regPackage`) now genuinely uses these AS LEMMAS derived from the more primitive setup, rather than projecting the conclusion directly.

# Constraints

- DO NOT keep `message_in_bayes_cone` and `source_in_rowwise_bayes_cone` as direct RegPackage fields. They become LEMMAS.
- ADD legitimate Bayes-cone-construction primitives (`bayesConeFromPrior`, `bayesConeFromPrior_self`, `B_eq_bayesConeFromPrior_at_inclM`, `G_rowwise_carries_prior_to_bayes_cone`). The `bayesConeFromPrior_self` is the only one that's potentially borderline — but it's structural (defining property of the construction).
- Update `PsiNonpos_of_regPackage` lemma body to invoke the new lemmas (not the removed fields). The proof should compile with no changes since the lemmas have the same signature as the removed fields.
- Build MUST PASS via `lake build MathlibStarter.V9Main` (exit code 0).
- ZERO sorries.
- NO new smuggling.
- Edit only lean/v9_appendix.lean.
- Cap 8 iterations.

# Files

- Edit: `lean/v9_appendix.lean`
- Read-only: `lean/v8_main.lean`

# Verification

Standard concat + lake build. Verify exit code 0.

After refactor, the Hall-G2c bridge lemma (`bayesian_barycenter_in_closed_convex` from Phase 5A) may need its `source_in_rowwise_bayes_cone` reference updated to call the new lemma form. Update accordingly.

The downstream P-class theorems (P2*/P3/P4/VariableMargin/Graph-FBNF) use `reg.message_in_bayes_cone` and `reg.source_in_rowwise_bayes_cone` — these calls will still work since the new LEMMAS have the same signatures as the removed fields.

# Output

Concise report under 500 words: build status (exit code), sorry count (0), axiom count (9), new RegPackage primitives, derivation lemmas, downstream impact.
