You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)

```lean
theorem wta_rowwise_minimizer_and_Bayes_cone_identification
    (I : Set WTAΩ)
    (lam : WTAΩ → ℝ)
    (hI : I.Nonempty)
    (h_support_eq : WTASupport lam = I)
    (h_pos_on_I : ∀ i : WTAΩ, i ∈ I → 0 < lam i)
    (hlam_nonneg : ∀ i : WTAΩ, 0 ≤ lam i)
    (hlam_sum : ∑ i : WTAΩ, lam i = 1)
    (s p : WTABelief) :
    (WTARowwiseMinimizer I lam s (WTA_mixedLabel lam) ↔ s ∈ WTAKminus I) ∧
      (WTABayesOptimalWTA I lam p (WTA_mixedLabel lam) ↔ p ∈ WTABcone I) := by
  sorry
```

## All relevant definitions (top-level RobustTrustV8 namespace)

```lean
abbrev WTAΩ : Type := Fin 3
abbrev WTAProfile : Type := WTAΩ → ℝ
abbrev WTABelief : Type := Belief WTAΩ

abbrev Belief (Ω : Type) [Fintype Ω] : Type :=
  {s : Ω → ℝ // (∀ ω : Ω, 0 ≤ s ω) ∧ (∑ ω : Ω, s ω) = 1}

def beliefDot {Ω : Type} [Fintype Ω] (s : Belief Ω) (w : Ω → ℝ) : ℝ :=
  ∑ ω : Ω, s.val ω * w ω

def WTA_vertex (i : WTAΩ) : WTAProfile := fun j => if i = j then 1 else -1

def WTA_mixedLabel (lam : WTAΩ → ℝ) : WTAProfile :=
  fun j => ∑ i : WTAΩ, lam i * WTA_vertex i j

def WTASupport (lam : WTAΩ → ℝ) : Set WTAΩ := {i : WTAΩ | 0 < lam i}

def WTAKminus (I : Set WTAΩ) : Set WTABelief :=
  {s : WTABelief | ∀ i : WTAΩ, i ∈ I → ∀ k : WTAΩ, s.val i ≤ s.val k}

def WTABcone (I : Set WTAΩ) : Set WTABelief :=
  {p : WTABelief | ∀ i : WTAΩ, i ∈ I → ∀ k : WTAΩ, p.val k ≤ p.val i}

def WTARowwiseMinimizer (I : Set WTAΩ) (lam : WTAΩ → ℝ)
    (s : WTABelief) (m : WTAProfile) : Prop :=
  m = WTA_mixedLabel lam ∧
    ∀ m' : WTAProfile, m' ∈ Set.range WTA_vertex →
      beliefDot s m ≤ beliefDot s m'

def WTABayesOptimalWTA (I : Set WTAΩ) (lam : WTAΩ → ℝ)
    (p : WTABelief) (m : WTAProfile) : Prop :=
  m = WTA_mixedLabel lam ∧
    ∀ m' : WTAProfile, m' ∈ Set.range WTA_vertex →
      beliefDot p m' ≤ beliefDot p m
```

## Lemma already proved (use freely)

```lean
theorem wta_payoff_dot_product_identity
    (lam : WTAΩ → ℝ)
    (hlam_nonneg : ∀ i : WTAΩ, 0 ≤ lam i)
    (hlam_sum : ∑ i : WTAΩ, lam i = 1)
    (s : WTABelief) :
    beliefDot s (WTA_mixedLabel lam) =
      2 * (∑ i : WTAΩ, lam i * s.val i) - 1
```

This identity also gives, by specializing `lam = WTA_vertex i₀` (Kronecker delta at i₀):
`beliefDot s (WTA_vertex k) = 2 * s.val k - 1` for any `k : WTAΩ`.

You should prove this auxiliary identity inline if needed (it's a short `unfold + simp` argument since `WTA_vertex i j = if i = j then 1 else -1`).

## Math sketch

Both halves are dot-product comparisons reduced via `wta_payoff_dot_product_identity` to coordinate inequalities.

### Half 1: rowwise minimizer ↔ K_I^-

`WTARowwiseMinimizer I lam s (WTA_mixedLabel lam)` requires:
- first conjunct: `m = WTA_mixedLabel lam` — this is **trivially `rfl`** because the bound `m` is literally `WTA_mixedLabel lam`.
- second conjunct: `∀ m' ∈ Set.range WTA_vertex, beliefDot s (WTA_mixedLabel lam) ≤ beliefDot s m'`.

Unfolding via the identity: `2 * (∑ i, lam i * s.val i) - 1 ≤ 2 * s.val k - 1` for every `k`,
i.e. `∑ i, lam i * s.val i ≤ s.val k` for every `k`.

- **(⇐) `s ∈ WTAKminus I → rowwise minimizer`**: Given `∀ i ∈ I, ∀ k, s.val i ≤ s.val k`. Take any `k`. Split the sum `∑ i, lam i * s.val i`:
  for `i ∈ I`, `lam i * s.val i ≤ lam i * s.val k` (by `s.val i ≤ s.val k` and `lam i ≥ 0`);
  for `i ∉ I`, `lam i = 0` (because `WTASupport lam = I` and `i ∉ I` means `¬(0 < lam i)`, with `lam i ≥ 0` this gives `lam i = 0`), so `lam i * s.val i = 0 ≤ lam i * s.val k = 0`.
  Sum: `∑ i, lam i * s.val i ≤ ∑ i, lam i * s.val k = s.val k * ∑ i, lam i = s.val k * 1 = s.val k`.

- **(⇒) `rowwise minimizer → s ∈ WTAKminus I`**: Given `∀ k, ∑ i, lam i * s.val i ≤ s.val k`. Need `∀ i₀ ∈ I, ∀ k, s.val i₀ ≤ s.val k`.

  Fix `i₀ ∈ I`. Set `k := i₀`. Then `∑ i, lam i * s.val i ≤ s.val i₀`. Combined with the convex-combination inequality `∑ i, lam i * s.val i ≥ ∑ i ∈ I, lam i * (min over I of s.val) = min over I of s.val` ... actually a cleaner route:

  Take any `k`. Compute `s.val i₀ - s.val k`:
  by hypothesis (with `k`), `∑ i, lam i * s.val i ≤ s.val k`.
  by hypothesis (with `i₀`), `∑ i, lam i * s.val i ≤ s.val i₀`.

  These don't immediately give `s.val i₀ ≤ s.val k`. Instead, the right argument is:
  Subtract: `∑ i, lam i * (s.val i - s.val k) ≤ 0` for every `k`.

  Split between `i ∈ I` (where `lam i > 0`) and `i ∉ I` (where `lam i = 0`):
  `∑ i ∈ I, lam i * (s.val i - s.val k) ≤ 0`.

  Now fix any `i₀ ∈ I` and any `k`. Pick the specific test `k`. The inequality
  `∑ i ∈ I, lam i * (s.val i - s.val k) ≤ 0` says the weighted average of `(s.val i - s.val k)` over `i ∈ I` is ≤ 0.

  But we want POINTWISE `s.val i₀ ≤ s.val k`, not just average. Need a stronger argument.

  **Sharper argument:** Apply the hypothesis at `k := i₀`: `∑ i, lam i * s.val i ≤ s.val i₀`.
  Rewrite the LHS as `∑ i, lam i * s.val i = s.val i₀ * (∑ i, lam i) - ∑ i, lam i * (s.val i₀ - s.val i)`
  `= s.val i₀ * 1 - ∑ i, lam i * (s.val i₀ - s.val i) = s.val i₀ - ∑ i, lam i * (s.val i₀ - s.val i)`.

  So `s.val i₀ - ∑ i, lam i * (s.val i₀ - s.val i) ≤ s.val i₀`, i.e. `0 ≤ ∑ i, lam i * (s.val i₀ - s.val i)`.

  Hmm, this still doesn't pin down `s.val i₀ ≤ s.val k`. Let me reconsider.

  **Correct sharper argument** (the right structure):
  Apply hypothesis at `k`: `∑_i lam_i s_i ≤ s_k` ... (★)
  Apply hypothesis at `i₀` (which is in I but treated just as some index): `∑_i lam_i s_i ≤ s_{i₀}` ... (☆)

  These say `s_{i₀} ≥ avg` and `s_k ≥ avg`. We need `s_{i₀} ≤ s_k`.

  Wait — actually the iff in the theorem holds with the FULL hypothesis bundle `h_pos_on_I` and `h_support_eq`. Let me revisit. Using positivity of `lam i₀ > 0`:

  From (☆), `lam i₀ * s.val i₀ + ∑_{i ≠ i₀} lam i * s.val i ≤ s.val i₀`, i.e. `∑_{i ≠ i₀} lam i * s.val i ≤ (1 - lam i₀) * s.val i₀`. With `∑_{i ≠ i₀} lam i = 1 - lam i₀ > 0`... still gives weighted average over `i ≠ i₀` is ≤ `s.val i₀`. Doesn't immediately pin pointwise.

  **Yet another route — direct attack on (⇒):**
  Suppose for contradiction `s.val i₀ > s.val k` for some specific `i₀ ∈ I`, `k`. Then with `lam i₀ > 0`:
  `∑_i lam_i s_i = lam_{i₀} s_{i₀} + ∑_{i ≠ i₀} lam_i s_i > lam_{i₀} s_k + ∑_{i ≠ i₀} lam_i s_i`.
  We can't immediately compare RHS to `s_k`.

  ⚠️ **Crucial observation:** Reading WTAKminus carefully — `s ∈ WTAKminus I` says **for ALL i ∈ I and ALL k, s_i ≤ s_k**. That means all coordinates `s_i` for `i ∈ I` are simultaneously ≤ every other coordinate. Equivalently, the coordinates `{s_i : i ∈ I}` are all equal to `min_k s_k`. (Otherwise, take an `i ∈ I` with `s_i > s_k₀` for some `k₀` — fails.)

  Given that, the (⇒) direction is genuinely strong, but the rowwise hypothesis (with positive support `lam` on `I`) **does** give it via convexity. Here's the clean argument:

  Apply hypothesis at `k`: `∑_i lam_i s_i ≤ s_k`. Equivalently `∑_{i ∈ I} lam_i (s_i - s_k) ≤ 0` (noting `lam_i = 0` for `i ∉ I`). So **the weighted average of `(s_i - s_k)` over `i ∈ I` is ≤ 0**.

  Now we want `∀ i₀ ∈ I, s_{i₀} - s_k ≤ 0`. This does NOT follow from the average being ≤ 0 unless all the values `s_i - s_k` (for `i ∈ I`) are ≤ 0. But the iff is supposed to hold...

  **Reread the proof statement.** The iff is `WTARowwiseMinimizer I lam s (WTA_mixedLabel lam) ↔ s ∈ WTAKminus I`. So both directions should be true under `h_pos_on_I`, `h_support_eq`, etc. The (⇐) direction (K_I^- → rowwise) is OBVIOUS. The (⇒) direction may actually NOT hold pointwise in general — the iff likely only holds under EXTRA reasoning specific to the support structure.

  ⟹ **Trick:** the hypothesis `∀ m' ∈ Set.range WTA_vertex, beliefDot s (WTA_mixedLabel lam) ≤ beliefDot s m'` is `∀ k, ∑_i lam_i s_i ≤ s_k`. Combined with `s ∈ Belief Ω` (so `∑_ω s_ω = 1` and `s_ω ≥ 0`), maybe one can still conclude `s_i ≤ s_k` pointwise FOR `i ∈ I`.

  Actually wait. The averaged inequality `∑_i lam_i s_i ≤ s_k` for ALL `k` (in particular `k ∈ I`) means: for each `i₁ ∈ I`, `∑_i lam_i s_i ≤ s_{i₁}`. Taking max over `i₁ ∈ I`: `∑_i lam_i s_i ≤ max_{i₁ ∈ I} s_{i₁}`. The LHS, with positive weights on `I` summing to 1, equals max iff all values are equal. So **all `{s_i : i ∈ I}` are equal**, with common value `c`, and `c = ∑_i lam_i s_i ≤ s_k` for all `k`. Hence `s_i = c ≤ s_k` for all `i ∈ I` and all `k`. ✓

  **So the (⇒) proof needs:** apply hypothesis to every `k ∈ I` to conclude average ≤ s_k. Then use Jensen-type argument: average of nonnegative reals with positive weights ≤ each individual term forces all terms ≤ average, but average is itself a positive combination... cleanest path:

  Let `m := max_{i ∈ I} s_i`. Then `∑_{i ∈ I} lam_i s_i ≤ ∑_{i ∈ I} lam_i * m = m` (using `∑ lam = 1`). Also, the hypothesis applied at `k := argmax` gives `∑_{i ∈ I} lam_i s_i ≤ m`. Conversely `∑_{i ∈ I} lam_i s_i ≥ ∑_{i ∈ I} lam_i * (min_{i ∈ I} s_i) = min`. So `min ≤ avg ≤ m`. With avg ≤ m AND positive weights, avg = m iff all `s_i` (for `i ∈ I` with `lam_i > 0`) equal `m`. With `lam_i > 0` for all `i ∈ I`, get all `s_i = m` for `i ∈ I`. Then hypothesis at any `k` gives `m = ∑ lam_i s_i ≤ s_k`. So `s_i = m ≤ s_k` for all `i ∈ I` and `k`. ✓

  This avg=max argument with positive weights is the crux. In Lean: state it as a lemma or inline it. Mathlib has `Finset.inner_mul_le_norm_mul_norm` type stuff but the cleanest path is direct.

  **Concrete inline proof of (⇒):**

```lean
-- Given: ∀ k, ∑ i, lam i * s.val i ≤ s.val k
-- Want: ∀ i₀ ∈ I, ∀ k, s.val i₀ ≤ s.val k
intro i₀ hi₀ k
-- Step 1: every i ∉ I has lam i = 0.
have h_outside : ∀ i, i ∉ I → lam i = 0 := by
  intro i hi
  by_contra h_ne
  have : 0 < lam i := lt_of_le_of_ne (hlam_nonneg i) (Ne.symm h_ne)
  have : i ∈ WTASupport lam := this  -- by def of WTASupport
  rw [h_support_eq] at this
  exact hi this
-- Step 2: ∑ i, lam i * s.val i = ∑ i ∈ I.toFinset, lam i * s.val i  (in principle)
-- Step 3: Apply hypothesis at k=i₀: ∑ ≤ s.val i₀, and at k=k: ∑ ≤ s.val k.
have h_at_i₀ : ∑ i, lam i * s.val i ≤ s.val i₀ := ...
have h_at_k : ∑ i, lam i * s.val i ≤ s.val k := ...
-- Step 4: from positive weight on i₀, ∑ ≥ lam i₀ * s.val i₀ + (1 - lam i₀) * min,
-- but cleaner: ∑ lam i * (s.val i₀ - s.val i) ≥ 0 (from h_at_i₀ ⇔ ∑ lam i s_i ≤ s_{i₀}
-- ⇔ s_{i₀} - ∑ lam i s_i ≥ 0 ⇔ ∑ lam i (s_{i₀} - s_i) ≥ 0).
-- Among nonneg terms (lam i ≥ 0; not necessarily s_{i₀} ≥ s_i!), so this doesn't help directly.
-- HOWEVER: the SAME inequality applied to any k₁ ∈ I gives ∑ lam i (s_{k₁} - s_i) ≥ 0.
-- Summing over k₁ ∈ I weighted by lam k₁: ∑_{k₁ ∈ I} lam k₁ * ∑_i lam i (s_{k₁} - s_i) ≥ 0.
-- LHS = ∑_i lam i * (∑_{k₁ ∈ I} lam k₁ * s_{k₁}) - ∑_{k₁ ∈ I} lam k₁ * ∑_i lam i * s_i
-- = (∑ lam) * (∑ lam k₁ s k₁) - (∑ lam k₁) * (∑ lam i s_i) where outer ∑ over I and inner over all.
-- Since support of lam is I, ∑_i lam_i s_i = ∑_{i ∈ I} lam_i s_i, and similarly ∑_{k₁ ∈ I} = ∑ k₁.
-- LHS = (∑ lam_i s_i) - (∑ lam k₁ s k₁) = 0.
-- So this doesn't help.

-- THE RIGHT TRICK: apply at k := i₀ to get ∑ lam_i s_i ≤ s_{i₀}.
-- Combined with: ∑ lam_i s_i = ∑_{i ∈ I} lam_i s_i ≥ lam i₀ * s i₀ (since other lam_i s_i ≥ 0 when ALL lam_i ≥ 0 AND s_i ≥ 0; nonneg!).
-- Wait: lam i ≥ 0 and s.val i ≥ 0 (Belief property), so each term lam i * s.val i ≥ 0.
-- Hence ∑ lam_i s_i ≥ lam i₀ * s.val i₀.
-- From s_{i₀} ≥ ∑ = sum ≥ lam i₀ * s_{i₀}: s_{i₀} (1 - lam i₀) ≥ 0 ⟹ no info.

-- Try: ∑_i lam i (s_i - s_k) ≤ 0 (from h_at_k).
-- With lam i ≥ 0 and s_i ≥ 0 in [0,1] and s_k ∈ [0,1].
-- For i ∉ I: lam i = 0 so term = 0.
-- For i ∈ I: lam i > 0 and we need to extract s_i ≤ s_k.

-- Apply h_at_k with k := k. Get ∑_{i ∈ I} lam_i (s_i - s_k) ≤ 0.
-- Define c := ∑_{i ∈ I} lam_i s_i ≤ s_k. (call this **)
-- Apply h_at_k with k := i₀ ∈ I. Get c ≤ s_{i₀}. (call this ***)

-- From (**) and (***): want s_{i₀} ≤ s_k.
-- This requires showing c = s_{i₀}. Since c ≤ s_{i₀} (from ***) and... we need c ≥ s_{i₀} too.

-- c = ∑_{i ∈ I} lam_i s_i. With lam_i > 0 ∀ i ∈ I and ∑_{i ∈ I} lam_i = 1, c is positive convex combo.
-- c ≤ s_{i₀} for ALL i₀ ∈ I. So c ≤ min_{i₀ ∈ I} s_{i₀}.
-- And c is a convex combination ≥ min_{i₀ ∈ I} s_{i₀}.
-- Hence c = min_{i ∈ I} s_i.
-- For positive convex combo to equal min, all values must equal min: ∀ i ∈ I, s_i = c.
-- In particular s_{i₀} = c ≤ s_k. ✓ QED.
```

The Lean proof must encode this "positive convex combination equals min iff all equal" argument. Cleanest formulation:

For each `i₁ ∈ I`, set `δ_{i₁} := s.val i₁ - c` where `c := ∑_i lam i * s.val i`. Each `δ_{i₁} ≥ 0` (from h_at_i₁: c ≤ s_{i₁}). And `∑_{i₁ ∈ I} lam_{i₁} δ_{i₁} = ∑_{i₁ ∈ I} lam_{i₁} s_{i₁} - c * ∑ lam = c - c = 0`. Nonneg sum with nonneg terms = 0 ⟹ each term is 0 (when `lam_{i₁} > 0`). So `δ_{i₁} = 0` for all `i₁ ∈ I`, i.e. `s.val i₁ = c` for all `i₁ ∈ I`. Then `s.val i₀ = c ≤ s.val k` (from h_at_k). ✓

Key Mathlib lemmas:
- `Finset.sum_eq_zero_iff_of_nonneg`: `∑ i ∈ s, f i = 0 ↔ ∀ i ∈ s, f i = 0` (when `∀ i, 0 ≤ f i`).
- `mul_eq_zero` or `mul_pos_iff`.
- `Belief.property.2 : ∑ ω, s.val ω = 1` and `Belief.property.1 : ∀ ω, 0 ≤ s.val ω`.

### Half 2: Bayes-optimal ↔ B_I

By symmetry (swap min/max), the argument is identical with reversed inequalities:
- `WTABayesOptimalWTA I lam p m` requires `m = WTA_mixedLabel lam` (rfl-true) and `∀ k, beliefDot p (WTA_vertex k) ≤ beliefDot p (WTA_mixedLabel lam)`.
- Using the dot identity: `2 p_k - 1 ≤ 2 (∑ lam_i p_i) - 1`, i.e. `p_k ≤ ∑ lam_i p_i` for all `k`.
- This is `p_k ≤ avg` for all `k`. Symmetric argument: avg ≤ max_{i ∈ I} p_i (by convex combo), and p_k ≤ avg for all k ∈ I gives avg = max, all `p_i` for `i ∈ I` are equal to avg, then for k ∉ I: p_k ≤ avg = p_{i₀} for any i₀ ∈ I. ✓

Same structural proof, signs flipped.

## Output

```
lean_proof
target_lemma_slug: wta_rowwise_minimizer_and_Bayes_cone_identification
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem wta_rowwise_minimizer_and_Bayes_cone_identification ... := by
  -- your proof
```

Aim for 80-150 lines (auxiliary vertex-dot identity + half 1 forward + half 1 backward + half 2 forward + half 2 backward).

Make sure to use the existing `wta_payoff_dot_product_identity` lemma for the WTA_mixedLabel identity. For vertex identity, prove it inline:

```lean
have hvertex : ∀ k : WTAΩ, beliefDot s (WTA_vertex k) = 2 * s.val k - 1 := by
  intro k
  apply wta_payoff_dot_product_identity ... -- using lam = WTA_vertex k characteristic? no.
  -- Actually: WTA_vertex k = WTA_mixedLabel (fun i => if i = k then 1 else 0)
  -- So use wta_payoff_dot_product_identity with lam := Pi.single k 1 or similar.
```

OR prove it directly by `unfold WTA_vertex beliefDot; ... `.

Use whatever feels cleanest. If you get stuck on a specific Mathlib lemma, STUCK with the API trace.
