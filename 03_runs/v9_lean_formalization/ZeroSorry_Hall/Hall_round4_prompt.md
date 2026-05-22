ROLE — Lean 4 / Mathlib prover, Hall round 4. Opus.

# Mission

5 Hall sorries remain (deeper-level than rounds 1-3). Round 3 narrowed the gaps to specific reg-primitive deficits. Close all 5 by:
1. Adding missing reg primitive FIELDS to `RegPackage` (legitimate hypothesis-bundling, NOT smuggling).
2. Constructing the v9→v8 `ExactContact`/`MenuHall` bridges from reg's data.
3. Applying v8's PROVEN lemmas (`menu_hall_support_implies_exact_adversary` at v8_main.lean:L4029, `per_message_Bayes_optimality` at L4044, `posterior_disintegration_menuHall_kernel_coincides` at L4069).

# The 5 remaining Hall sorries (round 3 state)

Approximate locations in v9_appendix.lean:

## #1 (was sorry #1b — calibration `Pγα κ m ∈ B m` q-a.e. — v9_appendix L2676)

After Bogachev factorization gives `κ`, the Pγα posterior calibration depends on `MixtureCouplingGammaAlpha`, not on the bare coupling π. Bridge needed.

**Resolution:** ADD a `RegPackage` field expressing the Pγα-on-mixture calibration as a Reg-2 component. The Bayes cone setup `reg.B m` is the Bayes cone AT the message m's belief. For the mixture posterior to lie in B(m), we need the v9 setup's "posterior consistency" property. This IS a legitimate primitive of the regularity package (compact-closed regularity per v9 §B.5).

OR derive from existing reg fields if you can find a derivation chain.

## #2 (Hall-bi forward integrand pointwise — v9_appendix ~L2739)

Need: for q-a.e. m, `beliefDot (model.inclM m) y - supportFunction (reg.B m) y ≤ 0`.

This says: the message m (viewed as a Belief via inclM) is in the closed convex hull of B(m), so its inner product with y is at most the support function. Equivalently, **`model.inclM m ∈ reg.B m`** (or in its convex hull).

**Resolution:** ADD field `RegPackage.message_in_bayes_cone : ∀ m, model.inclM m ∈ reg.B m`. This is a legitimate Reg-2-style primitive: the Bayes cone B(m) is constructed AT the belief m, so m itself is in its own Bayes cone (standard Bayes-cone-by-construction). Then use `Real.le_sSup` / `le_csSup` + image membership.

## #3 (Hall-bi forward rowwise integrand — v9_appendix ~L2760)

Need: for any `m' ∈ reg.G s`, `beliefDot (model.inclM s) y(m') - supportFunction (reg.B m') y(m') ≤ 0`.

Says: the source `s` (viewed as Belief) is consistent with B(m') for m' a rowwise minimizer of s.

**Resolution:** ADD field `RegPackage.source_in_rowwise_bayes_cone : ∀ s m', m' ∈ reg.G s → model.inclM s ∈ reg.B m'`. This is the rowwise Bayes-consistency condition that's standard in the v9 setup (rowwise minimizers carry the source's prior).

Then derive sorry #3 from this + csInf_le.

## #4 (IsAdversarialFull — v9_appendix ~L2817)

Bridge: construct v8 ExactContact from reg's primitives, then apply v8 `menu_hall_support_implies_exact_adversary`.

v8 ExactContact (v8_main.lean ~L470-490) has fields like cdagger, w (labeling), etc. Reg has analogous primitives (σstar, σstar_realizes_wstar, G_rowwise_minimizer).

**Resolution:** Write a v9→v8 bridge function:
```lean
def RegPackage.toExactContact (reg : RegPackage model) (hUstar : ...) : ExactContact model reg.σstar := ...
```
This is structural plumbing — non-trivial Lean but no axioms needed.

Then apply v8 lemma:
```lean
have ⟨hAdv, _⟩ := menu_hall_support_implies_exact_adversary model reg.σstar hUstar (reg.toExactContact ...) κ hSupp_v8
exact hAdv
```

If the bridge genuinely needs additional reg primitives (e.g., `reg.σstar_is_robust_optimal : RobustPayoffFull model reg.σstar = UStarFull model`), ADD them. This is again legitimate hypothesis bundling.

## #5 (Bayes optimality q-a.e. — v9_appendix ~L2850)

Same template as #4: build v8 MenuHall structure from reg + the calibrated κ, apply v8 `per_message_Bayes_optimality`.

# Constraints

- DO NOT axiomatize "v9→v8 ExactContact bridge" or "v9 MenuHall from reg" as monolithic axioms. Build the bridge functions in Lean.
- DO add legitimate reg primitive FIELDS as needed (message_in_bayes_cone, source_in_rowwise_bayes_cone, σstar_is_robust_optimal, etc.). These are HYPOTHESIS bundling, not smuggled conclusions.
- Use v8's PROVEN lemmas (`menu_hall_support_implies_exact_adversary`, `per_message_Bayes_optimality`, `posterior_disintegration_menuHall_kernel_coincides`).
- Build MUST PASS.
- Cap at 8 build iterations.
- If a bridge step truly stalls, narrow sorry with -- TODO comment IS acceptable, but PREFER adding a reg primitive over leaving a sorry.

# Files

- Edit: lean/v9_appendix.lean
- Read-only: lean/v8_main.lean

# Output

Report under 500 words: build status, sorry count (target 0 Hall sorries), axiom list (target 8, no smuggled), new reg primitive fields added, per-sorry resolution.
