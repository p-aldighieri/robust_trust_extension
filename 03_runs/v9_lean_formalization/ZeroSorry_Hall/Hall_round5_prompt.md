ROLE — Lean 4 / Mathlib prover, Hall closure round 5. Opus.

# Mission

Round 4 (subagent abe3b836) closed all 5 Hall sorries — but it did so by adding 3 NEW SMUGGLED fields to `RegPackage`:
- `Pγα_calibrated` (v9 analogue of v8 MenuHall.calibration)
- `σstar_adversarial_under_supportedKernel` (v9 analogue of v8 menu_hall_support_implies_exact_adversary)
- `σstar_qae_bayesOptimal` (v9 analogue of v8 per_message_Bayes_optimality)

The Hall theorems then use `exact reg.<field>` projections from these fields. This IS the cert-verifier smuggling pattern — moved from Inventory axioms to RegPackage structure fields. User policy 2026-05-22: this is SMUGGLED_CERTIFICATE regardless of whether the field lives in Inventory or in a data structure.

# Required corrective action

## 1. REMOVE the 3 smuggled fields from `RegPackage`

Field names (current locations in v9_appendix.lean):
- L1311: `Pγα_calibrated`
- L1321: `σstar_adversarial_under_supportedKernel`
- L1331: `σstar_qae_bayesOptimal`

KEEP the 2 legitimate fields added in round 4:
- `message_in_bayes_cone : ∀ m, model.inclM m ∈ B m` (legitimate Reg-2 hypothesis)
- `source_in_rowwise_bayes_cone : ∀ s m', m' ∈ G s → model.inclM s ∈ B m'` (legitimate Reg-2 hypothesis)

## 2. BUILD the v9→v8 `ExactContact` bridge as a real `def`

```lean
noncomputable def RegPackage.toExactContact
    {model : RobustTrustModel} (reg : RegPackage model)
    (hUstar : RobustPayoffFull model reg.σstar = UStarFull model)
    -- ... other reg primitive hypotheses as needed
    : ExactContact model reg.σstar := by
  refine {
    opt := ?_
    wlabel := ?_
    cdagger := ?_
    selector := ?_
    selector_measurable := ?_
    selector_mem := ?_
    sigma_implements_wlabel := ?_ }
  all_goals sorry  -- INITIAL — fill in step by step
```

For each field of `ExactContact` (v8_main.lean:L501-L512):

- `opt : OptimalMenuCstar model` — construct from `PayoffProfileSet model` and reg's optimal labeling. May need to invoke v8's `optimal_menu_exists` theorem if available, or use `Inventory.measurable_argmax_selector` on the payoff functional. If genuinely needs construction that isn't in v8/Mathlib, FLAG the gap; do NOT add a new Inventory.V9 axiom for "v9 OptimalMenuCstar exists" (that's smuggled).

- `wlabel : AlignedBestLabelingWstar model opt` — from reg.wstar, reg.wstar_inWP, reg.wstar_measurable.

- `cdagger : PrunedMenuCdagger model wlabel` — pruning per v8's pruning lemma.

- `selector : model.M → model.M` — construct via `Inventory.measurable_argmax_selector` (v8 axiom) applied to reg.G (closed-graph correspondence, compact-valued).

- `selector_mem` — by KRN selector's selector_mem property.

- `sigma_implements_wlabel` — directly from `reg.σstar_realizes_wstar`.

If a field genuinely cannot be constructed from reg + v8 + Mathlib without further hypotheses, ADD a legitimate reg primitive (similar to message_in_bayes_cone — a structural assumption, NOT a conclusion). Document each addition.

## 3. APPLY v8's PROVEN lemmas

After `RegPackage.toExactContact` returns an `ec : ExactContact model reg.σstar`:

```lean
-- For Hall sorry #4 (IsAdversarialFull):
have ⟨hAdv, _⟩ := menu_hall_support_implies_exact_adversary 
    model reg.σstar hUstar (reg.toExactContact hUstar ...) κ hSupp_v8
exact hAdv

-- For Hall sorry #5 (q-a.e. Bayes optimality):
-- Construct MenuHall structure from reg + κ + calibration
let mh : MenuHall model reg.pd reg.σstar (reg.toExactContact ...) κ := {
  supported := hSupp_v8
  q := MixtureMessageLaw model κ
  q_eq_qκ := rfl
  q_eq_gamma_second := -- from pd.sourceLawβ_disintegrates etc.
  calibration := -- derived from hCal + B_bayes_optimal
}
have ⟨_, hae⟩ := per_message_Bayes_optimality model reg.pd reg.σstar (reg.toExactContact ...) κ mh
exact hae (by linarith [reg.alpha_pos])  -- if needed
```

## 4. For Hall sorry #1 (Pγα calibration q-a.e.)

This was being smuggled via `reg.Pγα_calibrated`. Derive via:
- `pd.gamma_alpha_conditional_barycenter κ` gives `beliefBarycenter ((sourceLawγα κ) m) = beliefAsProfile (pd.Pγα κ m)` q-a.e.
- The Bayes cone B(m) is closed and convex.
- Combine: barycenter of a measure supported in a closed convex set is in the closure (i.e., in the set if closed).

May require: derive `Pγα κ m ∈ B m` from `KernelSupportedOnRegG ⟹ sourceLawγα κ m supported in B(m) ⟹ barycenter in B(m)` chain.

Or if this is genuinely hard, NARROWLY scope a sorry with `-- TODO: barycenter-of-supported-measure-in-closed-convex-set` and move on. **This is acceptable — but DO NOT add a smuggled axiom or smuggled reg field.**

# Constraints (BLOCKING)

- REMOVE the 3 smuggled fields. NO replacement axioms. NO replacement smuggled fields.
- BUILD `RegPackage.toExactContact` as a real `def` returning a `ExactContact` (which exists in v8). Add legitimate reg primitive HYPOTHESES if needed (must be structural assumptions, not conclusion shapes).
- APPLY v8's PROVEN lemmas (`menu_hall_support_implies_exact_adversary`, `per_message_Bayes_optimality`) directly with the bridge.
- For sorry #1: derive from `pd.gamma_alpha_conditional_barycenter` + B closedness + Bogachev support-of-measure. Narrow honest sorry acceptable for "barycenter-in-closed-convex" step (genuine Mathlib gap), but DOCUMENT precisely.
- Build MUST PASS.
- Cap at 8 iterations.

# Files

- Edit: `lean/v9_appendix.lean`
- Read-only: `lean/v8_main.lean` (study lines 501-580 for ExactContact / MenuHall structures)

# Acceptable end state

- 0 OR small number of narrow sorries with `-- TODO: <very specific Mathlib lemma>` comments.
- 8 axioms total in Inventory.V9 (unchanged from round 4: 5 originals + Bogachev + Clarke product + KR scalar).
- NO new smuggled fields on RegPackage.
- NO new axioms.
- Build PASS.

# Output

Concise report under 500 words: build status, sorry count, axiom list, removed fields, added reg primitives (with rationale), `toExactContact` constructor sketch, per-sorry resolution.
