ROLE — Lean 4 / Mathlib prover, Phase 4b targeted fix. Opus.

# Mission

Phase 4 audit found ONE remaining smuggling vector: the KR generic axiom at v9_appendix.lean:3055-3064 has `(hVectorHall : Prop) (_hVectorHall_proof : hVectorHall)` — an arbitrary unconstrained Prop carrier that doesn't relate to μ, ν, R, f, g. Pure trapdoor (if `hVectorHall := True`, the axiom can manufacture a scalar transport inequality from a proof of `True`).

Fix: restate the axiom WITHOUT the arbitrary `Prop`, in a form that is a genuine textbook KR/Villani 5.10 statement.

# Approach

Two paths:

**Path A (preferred): Tighten the vector-Hall hypothesis to be a properly typed statement involving μ, ν, R.**

For example, restate as:
```lean
axiom Inventory.V9.kantorovich_rubinstein_scalar_duality_generic
    {X : Type*} [MeasurableSpace X] [StandardBorelSpace X]
    (μ ν : Measure X) [IsFiniteMeasure μ] [IsFiniteMeasure ν]
    (R : Set (X × X)) (_hR_meas : MeasurableSet R)
    -- Vector-Hall hypothesis: scalar duality holds for ALL bounded
    -- measurable (φ, ψ) with the relation:
    (hScalarHallAll : ∀ (φ ψ : X → ℝ), Measurable φ → Measurable ψ →
        Integrable φ μ → Integrable ψ ν →
        (∀ s m, (s, m) ∈ R → φ s ≤ ψ m) →
        ∫ s, φ s ∂μ ≤ ∫ m, ψ m ∂ν)
    -- Then for any specific (f, g) with the relation, the inequality holds:
    (f g : X → ℝ) (hf : Measurable f) (hg : Measurable g)
    (hf_int : Integrable f μ) (hg_int : Integrable g ν)
    (hR_ineq : ∀ s m, (s, m) ∈ R → f s ≤ g m) :
    ∫ s, f s ∂μ ≤ ∫ m, g m ∂ν
```

Wait — this axiom is then REDUNDANT: the hypothesis `hScalarHallAll` directly implies the conclusion when applied to f, g.

So Path A makes the axiom trivial. Don't go this route.

**Path B (recommended): Make the axiom genuinely Villani 5.10 - shape.**

The genuine KR duality on Polish spaces says: for measures μ, ν, the optimal transport infimum equals the dual supremum. Specifically:

For a closed-graph relation R = {(x, y) : c(x, y) < ∞} (cost ∞ off R, finite on R), the existence of a coupling π of (μ, ν) supported on R is equivalent to the dual condition: for every pair of bounded measurable functions (φ, ψ) with φ(x) - ψ(y) ≤ c(x, y), ∫φ dμ ≤ ∫ψ dν + ∫c dπ_anyCoupling.

In simpler form for R-indicator cost: coupling supported on R exists ↔ ∀ (φ, ψ) bounded measurable with φ(x) ≤ ψ(y) on R, ∫φ dμ ≤ ∫ψ dν.

The DIRECTION we need for v9: given coupling exists, scalar dual holds. That's the TRIVIAL direction (Fubini).

But the v9 use is the REVERSE: we want to BUILD a coupling. That's `Inventory.V9.strassen_marginals`, which we ALREADY have.

So the KR axiom for our v9 use is actually:

**"Given the scalar Hall property holds (StrassenMarginalDominance), a coupling supported on R exists."**

But this IS `Inventory.V9.strassen_marginals`. So there's potentially redundancy.

Re-read what `kantorovich_rubinstein_scalar_bridge` is actually used for in `Hall-G2c-borel-extension`. Determine if:

(a) The bridge IS converting `PsiNonpos` (vector Hall) into `StrassenMarginalDominance` (scalar Hall), so we can apply `strassen_marginals`. The KR theorem here is: vector Hall ⟹ scalar Hall, i.e., the dual representation theorem of bounded Borel functions in terms of vector test functions.

If (a), the honest formulation is:
```lean
axiom Inventory.V9.kantorovich_rubinstein_vector_to_scalar
    {X : Type*} [MeasurableSpace X] [StandardBorelSpace X]
    (μ ν : Measure X) [IsFiniteMeasure μ] [IsFiniteMeasure ν]
    (R : Set (X × X)) (_hR_meas : MeasurableSet R)
    {V : Type*} [Fintype V]
    -- A vector-Hall hypothesis: for every bounded-measurable y : X → V → ℝ,
    -- the vector dual inequality holds
    (hVectorHall :
      ∀ (y : X → V → ℝ),
        (∀ v, Measurable (fun x => y x v)) →
        (∀ v, ∃ C, ∀ x, |y x v| ≤ C) →  -- bounded
        <some specific vector inequality between μ, ν, R, y>) :
    -- Then scalar Hall holds:
    ∀ (f g : X → ℝ), Measurable f → Measurable g →
      Integrable f μ → Integrable g ν →
      (∀ s m, (s, m) ∈ R → f s ≤ g m) →
      ∫ s, f s ∂μ ≤ ∫ m, g m ∂ν
```

The actual vector inequality depends on what v9's `PsiNonpos` says. Look it up and tie the hypothesis to a generic version of that.

**Path C (also acceptable): Inline as a Lean lemma derived from existing axioms.**

If the bridge from PsiNonpos to scalar Hall can actually be DERIVED from Mathlib's transport / measure theory + the existing axioms (e.g., applying Strassen's theorem in two ways, or using the Riesz representation), then prove it as a lemma and DELETE the axiom entirely. Honest derivation, no new axiom.

**Path D (worst case): Remove the axiom and accept a documented honest sorry at the call site.**

If neither Path B nor Path C works in budget, REMOVE the axiom and put a narrow `-- TODO: KR vector-to-scalar bridge from Villani Thm 5.10` sorry at the bridge lemma's call site (or upstream at the Hall-G2c-borel-extension proof).

# Choose Path B or Path C; D is fallback.

# Constraints

- REMOVE the `(hVectorHall : Prop) (_hVectorHall_proof : hVectorHall)` arbitrary Prop carrier.
- The fix must NOT introduce a new smuggling vector.
- The 6 unchanged legitimate axioms + clarke_product_normal_cone_projection_generic + bayesian_barycenter_in_closed_convex stay as-is.
- Build MUST PASS.
- Final state: 0 v9 sorries OR ≤1 honest sorry with TODO.

# Files

- Edit: `lean/v9_appendix.lean`

# Output

Short report under 400 words: build status, sorry count, axiom count, which Path was chosen (B/C/D), the new KR axiom shape OR the bridge lemma proof OR the documented sorry.
