ROLE — Lean 4 / Mathlib prover, Hall closure round 3. Opus, math template.

# Mission

5 narrow sorries remain in v9 Hall block (post-correction). User policy 2026-05-22 evening: zero sorries; derivations preferred over axioms; new axioms ONLY for genuine external theorems Mathlib lacks. Close all 5.

# The 5 sorries + prescribed derivations

## Sorry #1: `«Hall-G2c-borel-extension»` (line ~2580, calibration from Strassen coupling)

The Strassen coupling `π` exists (via `Inventory.V9.strassen_marginals`). Need to disintegrate into a Markov kernel `κ` + show `Pγα κ m ∈ B m` q-a.e.

Two-piece honest path:
- Bogachev disintegration of `π = τM ⊗ κ` for a Markov kernel `κ` is a genuine textbook theorem. If Mathlib lacks the direct factorization theorem, add a NARROWLY-SCOPED axiom `Inventory.V9.bogachev_kernel_factorization` ONLY for the disintegration (NOT for v9-specific calibration). Citation: Bogachev 2007, *Measure Theory* Vol II, Thm 10.6.1.
- The calibration `Pγα κ m ∈ B m` must be DERIVED from pd.gamma_alpha_conditional_barycenter + the closed-graph support transfer + reg.B's closedness. Use `B_closed` + Bogachev's barycenter-of-supported-measure-is-in-the-support.

Prescribed structure:
```lean
-- (a) Bogachev disintegration (legitimate axiom for ONLY the kernel factorization):
obtain ⟨κ, hκ_factor, hκ_markov⟩ :=
  Inventory.V9.bogachev_kernel_factorization model.τM π hπ_coupling.left
-- Now κ : Kernel M M, with π = τM ⊗ κ.
refine ⟨{ kernel := κ, isMarkov := hκ_markov }, ?_, ?_⟩
· -- KernelSupportedOnRegG from π R^c = 0 + π = τM ⊗ κ ⟹ κ s supported on G(s) a.e.
  -- DERIVE in Lean using Mathlib's compProd / support reasoning.
  sorry  -- if Mathlib derivation succeeds: replace with real proof
· -- Pγα κ m ∈ B m q-a.e.
  -- From pd.gamma_alpha_conditional_barycenter + B_closed + Bogachev's
  -- "barycenter of measure supported on closed convex set is in the set"
  sorry  -- DERIVE; do not axiomatize
```

## Sorry #2: `«Hall-biconditional»` forward part 1 (line ~2670, support-function gap nonpos)

For each `y : BoundedBorelProfile`, `m ↦ y(m)·m − h_{B(m)}(y(m)) ≤ 0` q-a.e. on the kernel-supported domain.

Pure Lean derivation. Mathlib has `Real.le_sSup`, `IsCompact.bddAbove`, etc.

```lean
apply MeasureTheory.integral_nonpos_of_ae
filter_upwards [hCal] with m hm  -- hm : Pγα κ m ∈ reg.B m
-- Need: beliefDot m y_m ≤ supportFunction (reg.B m) y_m (the value of m itself bounded by sup over B(m))
-- Wait — we have Pγα κ m, NOT m itself, in reg.B m. The integrand uses m·y(m).
-- The actual support function inequality: for the *aligned* part, m is the message,
-- and for q-a.e. m, m is consistent with B(m) (the Bayes-cone condition).
-- Use le_sSup with the fact that m ∈ B(m) (q-a.e. on aligned mass) + image membership.
sorry  -- derive using le_sSup + Set.mem_image
```

If genuinely needs an Aliprantis–Border citation (Thm 7.51): that's a real textbook theorem; can keep as `kantorovich_rubinstein_scalar_bridge`-style narrow axiom.

## Sorry #3: `«Hall-biconditional»` forward part 2 (line ~2700, rowwise infimum nonpos)

For each `y`, `s ↦ inf_{m' ∈ G(s)} (y(m')·s − h_{B(m')}(y(m'))) ≤ 0` q-a.e.

```lean
apply MeasureTheory.integral_nonpos_of_ae
apply Filter.eventually_of_forall
intro s
-- G(s) is nonempty (reg.G_nonempty). For any m' ∈ G(s) with Pγα at m' in B(m'),
-- (y(m')·s − h_{B(m')}(y(m'))) ≤ 0 by support function definition.
-- The inf is bounded above by ANY element of G(s); take m' from reg.G_nonempty.
obtain ⟨m', hm'⟩ := reg.G_nonempty s
-- Need: csInf_le applied to image set; combine with the pointwise inequality.
sorry  -- derive using csInf_le + image membership + support function inequality
```

## Sorry #4: `robustRationalizableKernelExists_to_strategy` (line ~2750, IsAdversarialFull)

USE v8's `menu_hall_support_implies_exact_adversary` at line 4029 of `v8_main.lean`:

```lean
theorem menu_hall_support_implies_exact_adversary
    (model : RobustTrustModel)
    (σstar : AgentStrategyFull model)
    (hσstar : RobustPayoffFull model σstar = UStarFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (hsupp : KernelSupportedOnG model ec.cdagger κ) :
    IsAdversarialFull model κ σstar ∧
      MixturePayoffFull model κ σstar = UStarFull model
```

To apply this: need `σstar = reg.σstar`, need `ExactContact model reg.σstar`, need `KernelSupportedOnG model ec.cdagger κ`.

The v9 `KernelSupportedOnRegG model reg.G κ` (we have it as `hSupp`) should imply `KernelSupportedOnG model ec.cdagger κ` IF `reg.G s = G_{ec.cdagger}(s)` (same correspondence). The `ExactContact` may need to be derived from reg's primitives (reg.σstar_realizes_wstar likely gives it).

```lean
-- Step 1: construct ExactContact from reg's primitives
have ec : ExactContact model reg.σstar := by
  -- exact_contact via wstar realization + G_rowwise_minimizer
  sorry  -- bridge from reg.* to v8 ExactContact
-- Step 2: confirm hsupp shape matches
have hsupp_v8 : KernelSupportedOnG model ec.cdagger κ := by
  sorry  -- reg.G = ec.cdagger's G correspondence
-- Step 3: apply v8 theorem
have ⟨hAdv, _⟩ :=
  menu_hall_support_implies_exact_adversary model reg.σstar hσstar ec κ hsupp_v8
exact hAdv
```

If the bridges (step 1, step 2) genuinely don't work, document precise gap (e.g., "reg.G_rowwise_minimizer + reg.σstar_realizes_wstar ⟹ ExactContact requires unfolding ExactContact definition in v8"). May need narrow axiom `Inventory.V9.reg_to_v8_exact_contact_bridge` ONLY for the structural translation — but try real derivation first.

## Sorry #5: `robustRationalizableKernelExists_to_strategy` (line ~2755, q-a.e. Bayes optimality)

USE v8's `per_message_Bayes_optimality` at v8_main.lean line 4044 OR `posterior_disintegration_menuHall_kernel_coincides` at line 4069.

Similar structure: build ExactContact + MenuHall from reg's primitives, apply v8 theorem.

# Constraints

- DO NOT axiomatize "Strassen→calibrated kernel" as a single axiom. The Bogachev disintegration is OK as a narrow axiom (`bogachev_kernel_factorization`); the calibration must be derived.
- DO NOT axiomatize the forward Hall integration. Derive in Lean using Mathlib + support function definition.
- DO NOT axiomatize the QAE bridge (sorries #4 #5). Use v8's PROVEN lemmas directly.
- The bridging structures (v8 ExactContact, MenuHall) may genuinely need derivation from reg's primitives — derive in Lean if possible; if not, narrow axiom citing v8 lemma is acceptable.
- Build MUST PASS.
- Cap iterations at 6 build attempts.

# Files

- Edit: `lean/v9_appendix.lean`
- Read-only: `lean/v8_main.lean`

# Output

Report under 600 words: build status, sorry count, axioms list (target: 7-8, no smuggled), per-sorry resolution.
