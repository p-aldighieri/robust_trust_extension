ROLE — Lean 4 / Mathlib prover, CORRECTIVE round. Opus, math template.

# Mission

The previous Hall round (subagent a4200205e32472f3a) closed 5 sorries but introduced **3 smuggled axioms** dressed up as paper-cited dependencies. User clarification 2026-05-22 evening: Inventory.V9 is ONLY for genuine external textbook theorems Mathlib lacks; downstream derivations dressed up as axioms are smuggling.

Your task: REMOVE those 3 smuggled axioms from `Inventory.V9` and REPLACE the corresponding theorem-body invocations with REAL LEAN DERIVATIONS. ZERO net sorries allowed (the v9 zero-sorry directive stands).

# The 3 smuggled axioms to remove

Located in `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean`:

## 1. `Inventory.V9.strassen_coupling_disintegration` (L2551)

Statement: `(π : Measure (M × M)) → IsCoupling π τM τM → support condition → reg.calibratedKernelExists`.

**Why smuggled:** combines genuine Bogachev disintegration with v9-specific `reg.calibratedKernelExists` calibration (Pγα κ m ∈ B m). Bogachev IS a real theorem, but the calibration content is a v9 derivation from `pd.gamma_alpha_conditional_barycenter`.

**Replacement Lean derivation** (call site at L2680, in `«Hall-G2c-borel-extension»`):
```lean
-- After obtaining π from Inventory.V9.strassen_marginals:
obtain ⟨π, hπ_coupling, hπ_support⟩ :=
  _root_.Inventory.V9.strassen_marginals model.τM model.τM R hDominance
-- Now build the AdviserKernel by Mathlib disintegration:
-- (a) Mathlib has Measure.compProd / ProbabilityTheory.Kernel.disintegrate
--     factoring π = τM.compProd κ for a unique Markov kernel κ.
-- (b) The support condition π Rᶜ = 0 transfers to KernelSupportedOnRegG.
-- (c) The Bayes-cone posterior calibration `Pγα κ m ∈ B m` follows from
--     pd.gamma_alpha_conditional_barycenter + pd.sourceLawγα_disintegrates
--     + the rowwise-minimizer support inheritance.
-- The HONEST derivation is:
--   refine ⟨someAdviserKernel, ?supp, ?cal⟩
--   · -- support inheritance: π Rᶜ = 0 ⟹ κ supported on G
--   · -- Pγα ∈ B q-a.e.: from pd's barycenter identity + B is closed
-- If specific Mathlib API is missing for the disintegration→Kernel step,
-- introduce a NARROWER axiom `Inventory.V9.borel_kernel_factorization`
-- that ONLY does the disintegration (not the v9 calibration).
-- Citation: Bogachev Thm 10.6.1 — STANDARD Borel disintegration only.
```

## 2. `Inventory.V9.regPsi_nonpos_of_kernel` (L2580)

Statement: `reg.robustRationalizableKernelExists → PsiNonpos model reg`.

**Why smuggled:** This is the FORWARD DIRECTION of the Hall biconditional. The subagent's own docstring admits "Mathlib provides `integral_mono_ae` and `csInf_le` separately but does not package the v9 `regPsi`-specific forward integration." That's not a missing axiom — that's a Lean proof obligation.

**Replacement Lean derivation** (call site at L2717, in `«Hall-biconditional»` forward direction):
```lean
intro hKernel
rcases hKernel with ⟨κ, hSupp, hCal⟩
intro y
unfold regPsi
-- regPsi y = α · ∫_M (y·m − h_B(m) y) dτM + (1-α) · ∫_M inf_{m'∈G(s)} (...) dτM
-- Both terms ≤ 0 by support-function inequality + rowwise-minimizer inheritance.
apply add_nonpos
· apply mul_nonpos_of_nonneg_of_nonpos
  · linarith [model.α_nonneg]
  · -- ∫ (y·m − h_B(m) y) dτM ≤ 0
    -- from hCal: q-a.e. on the mixture message marginal, Pγα κ m ∈ B m
    -- so y(m) · m ≤ sup_{μ ∈ B(m)} y(m) · μ = h_B(m) (y(m))
    -- so the integrand is ≤ 0 q-a.e.; use integral_mono_ae
    apply MeasureTheory.integral_nonpos_of_ae
    filter_upwards [hCal] with m hm
    -- bound the support function from below
    have : beliefDot m (y.toFun m) ≤ supportFunction model (reg.B m) (y.toFun m) := by
      -- h_B(m) y = sSup ((·) y '' B(m)); m is in B(m) by reg.B's definition + hm
      -- requires reg.B m's definition: μ ∈ B(m) ⟺ Bayes-cone membership
      sorry  -- HONEST GAP: need explicit definition of reg.B for support_function_le
    linarith
· apply mul_nonpos_of_nonneg_of_nonpos
  · linarith [model.α_le_one]
  · -- ∫ inf_{m' ∈ G s} (y(m')·s − h_B(m') y(m')) dτM ≤ 0
    -- For s ∈ supp τ, G(s) is the rowwise minimizer correspondence;
    -- evaluating at some m₀ ∈ G(s) (nonempty by reg.G_nonempty) gives
    -- the rowwise inequality y(m₀)·s − h_B(m₀) y(m₀) ≤ 0 (similar argument).
    apply MeasureTheory.integral_nonpos_of_ae
    apply Filter.eventually_of_forall
    intro s
    -- the inf over G(s) of (y(m')·s − h y(m')) is ≤ that quantity at any m' ∈ G(s)
    sorry  -- HONEST GAP: rowwise-min-correspondence integration
```

If genuine Mathlib API gaps surface for the support function / sInf manipulation, leave NARROWLY-SCOPED `sorry` inside the proof body with a `-- TODO: missing Mathlib lemma <specific name>` comment. This is acceptable per user policy.

## 3. `Inventory.V9.kernel_to_qae_strategy` (L2612)

Statement: `reg.robustRationalizableKernelExists → HasRobustRationalizableStrategy model reg.pd`.

**Why smuggled:** subagent's own docstring: "This is the v9 analogue of v8's `posterior_disintegration_menuHall_kernel_coincides` + `tier2_qae_robust_rationalizability_under_menu_Hall` combined." That's literally restating v8 theorems as a v9 axiom.

**Replacement Lean derivation** (call site at L2738, in `robustRationalizableKernelExists_to_strategy`):
```lean
intro h
rcases h with ⟨κ, hSupp, hCal⟩
refine ⟨κ, reg.σstar, ?adv, ?bayes⟩
· -- IsAdversarialFull: MixturePayoffFull = RobustPayoffFull
  -- From KernelSupportedOnRegG + reg.G_rowwise_minimizer + reg.σstar_realizes_wstar.
  -- Mirror AlphaZero's adversaryOptimal derivation pattern.
  sorry  -- HONEST GAP: similar to AlphaZero adversaryOptimal (commit 2e55b0c)
· -- ∀ᵐ m ∂MixtureMessageLaw κ, IsBayesOptimal (σstar.sectionFull (inclM m)) (pd.Pβ κ m)
  -- Use:
  --   * hCal: q-a.e. on (MixtureCouplingGammaAlpha).map Prod.snd, Pγα κ m ∈ B m
  --   * reg.B_bayes_optimal: μ ∈ B m → IsBayesOptimal σstar μ
  --   * pd.sourceLawβ_disintegrates + pd.sourceLawγα_disintegrates to align
  --     MixtureMessageLaw κ ↔ (MixtureCouplingGammaAlpha κ).map Prod.snd q-a.e.
  --   * pd.conditional_barycenter + pd.gamma_alpha_conditional_barycenter to
  --     identify Pβ κ m and Pγα κ m via barycenter equality
  sorry  -- HONEST GAP: same disintegration alignment pattern as AlphaZero closure
```

# Constraints (BLOCKING)

- **REMOVE** the 3 smuggled axioms from Inventory.V9 (`strassen_coupling_disintegration`, `regPsi_nonpos_of_kernel`, `kernel_to_qae_strategy`).
- **REPLACE** call sites with REAL LEAN DERIVATION (per skeletons above).
- **NARROWLY-SCOPED `sorry`** is acceptable for specific Mathlib API gaps inside derivations, but must have `-- TODO: missing Mathlib lemma <name>` comment.
- **DO NOT** re-add smuggled axioms. The 1st axiom (`kantorovich_rubinstein_scalar_bridge`) stays — KR duality IS a legitimate optimal-transport theorem.
- Build MUST PASS. Iterate until clean.
- Downstream typecheck preserved (P2*/P3/P4/G-addendum-variable-margin).
- If you find that one of the 3 smuggled axioms is actually genuinely a textbook theorem Mathlib lacks (not a downstream derivation), DEFEND that claim with a precise textbook citation in the docstring. But the burden of proof is on you.

# Acceptable end state

- ZERO occurrences of `regPsi_nonpos_of_kernel`, `kernel_to_qae_strategy`, `strassen_coupling_disintegration` as axioms.
- Real Lean derivations for the corresponding theorem bodies.
- Some `sorry` markers acceptable INSIDE these derivations for genuine Mathlib gaps (with comments).
- Build PASS.

# Files

- Edit: `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean`
- Read-only: `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean`

# Build verification

Standard concat + lake build.

# Output

Concise final report:
- Build status.
- Final axiom count in Inventory.V9 (target: 7 = 5 original + 1 product-projection bridge + 1 KR scalar bridge; was 9 in last round).
- Per-axiom: which were removed, which kept (with paper-source verdict).
- Final sorry count + per-sorry: what specific Mathlib bridge is needed.
- Downstream typecheck status.
