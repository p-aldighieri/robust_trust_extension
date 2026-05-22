ROLE — Lean 4 / Mathlib prover, math template, fresh-context Opus subagent fork.

Your task is to **discharge the v9 Hall biconditional block** in `lean/v9_appendix.lean`: 4 sorry-stubbed theorems + the bridge lemma. Follow the same certificate-verifier pattern T2/T1/Binary used.

Files:
- `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean` (edit ONLY this)
- `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean` (read-only)
- `v9_consolidated.md` §B.5 (Hall biconditional source)
- `exposition_v9.tex` §11 (canonical statement)

# Theorems to discharge

```lean
-- §16 Hall block — currently all by sorry

theorem «Hall-G1-finite-cone-hall-farkas-LP»
    (inst : FiniteConeHallInstance) :
    inst.flowFeasible ↔ inst.psiNonpos := by sorry

theorem «Hall-G2c-borel-extension»
    {model : RobustTrustModel}
    (reg : RegPackage model)
    (_hPsi : PsiNonpos model reg) :
    reg.calibratedKernelExists := by sorry

theorem «Hall-biconditional»
    {model : RobustTrustModel}
    (reg : RegPackage model) :
    reg.robustRationalizableKernelExists ↔ PsiNonpos model reg := by sorry

theorem robustRationalizableKernelExists_to_strategy
    {model : RobustTrustModel}
    (reg : RegPackage model)
    (h : reg.robustRationalizableKernelExists) :
    HasRobustRationalizableStrategy model reg.pd := by
  rcases h with ⟨κ, _hSupp, _hCal⟩
  refine ⟨κ, reg.σstar, ?_⟩
  sorry

theorem «Hall-WTA-dual-certificate-psi-two-ninths»
    (wta : WTAData)
    (_hCert : wta.certificatePositive) :
    wta.psiValue = (2 : ℝ) / 9 := by sorry
```

Plus already-proven (don't break):
- `«Hall-WTA-reopening-threshold-D»` (proved via `div_le_iff₀`).

# Mathematical content (v9_consolidated.md §B.5 / exposition_v9.tex §11)

The v9 Hall biconditional is the classification engine. Under the regularity package (Reg-1: closed-graph rowwise minimizer correspondence G; Reg-2: continuous support function of Bayes cone B):

**(a)** There exists a robustly rationalizable strategy under the fixed labeling `w*`.
**⟺**
**(b)** `Ψ(y) ≤ 0` for every bounded Borel `y : M → ℝ^|Ω|`.

Where:
```
Ψ(y) := α·∫_M [y(m)·m - h_{B(m)}(y(m))] dτ(m)
      + (1-α)·∫_M inf_{m'∈G(s)} [y(m')·s - h_{B(m')}(y(m'))] dτ(s)
```

The sub-lemmas:
- **G1** finite cone-Hall via Farkas: in finite-dimensional approximation, primal feasibility ↔ no separating bounded Borel dual price. Consumes `Inventory.farkas_lp_duality_conic`.
- **G2c** Borel extension: lift G1 from finite-dim to general measurable M. Uses Reg-1/Reg-2 + measurable selection. Consumes `Inventory.strassen_marginals` (for the support-constrained coupling that produces the calibrated kernel).
- **Hall-biconditional**: combine G1 + G2c. The forward direction (calibrated kernel ⟹ Ψ ≤ 0) is easy (support function inequality). The reverse direction uses G2c.
- **WTA-dual-certificate-psi-two-ninths**: explicit computation for ternary WTA. `y_j = 1 - 2e_j`, `h_{B_j}(y_j) = 1/3`, `E[s_j | s ∈ K_j^-] = 1/9`, so `Ψ(y) = (1-α)·(4/9) = 2/9` at `α = 1/2`. The threshold reopening from baseline depth D is the already-proven `Hall-WTA-reopening-threshold-D`.
- **Bridge `robustRationalizableKernelExists_to_strategy`**: from the calibrated kernel + `RegPackage.σstar` + `RegPackage.B_bayes_optimal` discharge Definition2QAEPredicate. Need to align with v8 `Definition2QAEPredicate` (`MixtureMessageLaw` second-marginal = `MixtureCouplingGammaAlpha`'s second marginal; `pd.Pβ = pd.Pγα` q-a.e.).

# Pattern (same as T1/Binary)

1. Add module-scope `Is*` predicates encoding concrete claims:
   - `IsFiniteConeHallFeasible inst` — concrete content of `flowFeasible ↔ psiNonpos`.
   - `IsBorelCalibratedKernel ...` — concrete kernel-existence statement.
   - `IsHallBiconditional reg` — explicit ↔.
   - `IsWTACertificate wta` — concrete `psiValue = 2/9` content.
   - `IsRobustRationalizableKernelToStrategy` — concrete bridge claim.

2. Add data-witness fields to `FiniteConeHallInstance`, `RegPackage` (already has Psi/calibratedKernelExists/robustRationalizableKernelExists defs; need to add `hallBiconditionalWitness : ↔` field, `bridgeWitness : kernel → strategy`), `WTAData`.

3. Discharge theorems by projection.

# Constraints

- DO NOT modify `v8_main.lean`.
- DO NOT add new Inventory axioms.
- DO NOT regress T2, T1, Binary (currently 21 sorries in source).
- Cap at 5 build attempts.
- Lean 4 / Mathlib v4.30.0-rc1.

# Build verification

```
cat "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean" "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean" > "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean"
cp "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean" "C:/Users/Public/Documents/Lean/MathlibStarter/MathlibStarter/V9Main.lean"
cd "C:/Users/Public/Documents/Lean/MathlibStarter"
lake build MathlibStarter.V9Main
```

# Output

Report in under 600 words:
- Theorems discharged.
- Build status.
- New sorry count.
- RegPackage / FiniteConeHallInstance / WTAData refinement summary.
- Flagged follow-ups (e.g., Farkas axiom bridge, Strassen bridge, σstar bridge to Definition2QAEPredicate).

The artifact is the edited file.
