ROLE — Lean 4 / Mathlib prover, round 6. Opus.

# Mission

Eliminate 5 more cert-verifier fields the previous audit found + derive 1 RegPackage field that's actually a lemma.

# Targets (6 fixes)

## 1. Derive `kernelSupportedOn_v8_of_v9` as a lemma (currently a RegPackage field at L1339)

The subagent admitted this is "morally derivable from `G_subset_rowwiseContactG` plus measurability." Make it a lemma:

```lean
lemma RegPackage.kernelSupportedOnG_of_supportedOnRegG
    {model : RobustTrustModel} (reg : RegPackage model)
    (κ : AdviserKernel model)
    (h : KernelSupportedOnRegG model reg.G κ) :
    KernelSupportedOnG model reg.exactContact.cdagger κ := by
  -- KernelSupportedOnRegG: ∀ᵐ s, κ.kernel s G_set = 1  (or similar)
  -- KernelSupportedOnG: ∀ᵐ s, κ.kernel s (RowwiseContactG cdagger) = 1
  -- Bridge via reg.G_subset_rowwiseContactG + measure_mono_null on complements
  intro -- ...
  filter_upwards [h] with s hs
  -- κ.kernel s (RowwiseContactG cdagger s) ≥ κ.kernel s (G s) = 1
  -- by mono on the inclusion, the larger set has measure ≥ 1
  -- since κ is Markov measure, the larger set also has measure = 1
  sorry  -- to be filled by the prover
```

Remove the field from RegPackage. Update call sites at L3018-3055 to invoke the lemma directly.

## 2-5. Eliminate `psiNonposWitness` fields in P2StarHyp, P3Hyp, P4Hyp, VariableMarginP2Hyp (lines 1575, 1584, 1593, 1611)

Each of these hypothesis structures currently has `psiNonposWitness : PsiNonpos model reg` as a field. The theorems then plug it into Hall-biconditional:

```lean
theorem «P2-star-cone-margin-bounded-jamming»
    (hyp : P2StarHyp model) :
    HasRobustRationalizableStrategy model hyp.reg.pd := by
  have hPsi : PsiNonpos model hyp.reg := hyp.psiNonposWitness  -- SMUGGLED
  -- ... apply Hall biconditional
```

This SMUGGLES the Hall conclusion. The P-class theorems should DERIVE PsiNonpos from the primitive geometric P-class conditions, not assume it.

**Resolution per theorem** (sketches; honest narrow sorry acceptable for the geometric derivation if too hard):

- **P2-star (cone-margin bounded jamming)**: REMOVE `psiNonposWitness`. ADD primitive geometric fields (e.g., `coneMargin : ℝ`, `coneMargin_pos`, `jammingBound`, ...). Derive PsiNonpos from these via the cone-margin → Ψ-nonpositivity lemma. If derivation is too involved, leave a narrow sorry with `-- TODO: cone-margin → Ψ ≤ 0 derivation` and remove the smuggled `psiNonposWitness` field anyway.

- **P3 (polyhedral cone-margin)**: REMOVE `psiNonposWitness`. ADD polyhedral primitive fields. Derive PsiNonpos.

- **P4 (radial antipodal τ-symmetry)**: REMOVE `psiNonposWitness`. ADD radial-symmetry primitive. Derive PsiNonpos.

- **VariableMarginP2 (G-addendum variable margin)**: REMOVE `psiNonposWitness`. ADD margin function field. Derive PsiNonpos.

Minimum acceptable: REMOVE the 4 `psiNonposWitness` fields. Replace each theorem body with EITHER a real derivation OR an honest sorry with `-- TODO: P{2,3,4}-class geometric → Ψ ≤ 0` comment. No more `exact hyp.psiNonposWitness` projection.

## 6. Eliminate `GraphFBNFPackage.capstoneWitness` (line 1622)

`capstoneWitness : HasRobustRationalizableStrategy model pd` is the cert-verifier conclusion bundled as a data field. Used at line 3424.

**Resolution**: REMOVE the field. Derive `HasRobustRationalizableStrategy` from GraphFBNFPackage's actual primitive fields via the G-addendum P6_G theorem chain. If derivation requires substantial work, leave narrow sorry with documented TODO.

# Constraints (BLOCKING)

- REMOVE all 5 cert-verifier fields (4 psiNonposWitness + 1 capstoneWitness).
- Convert `kernelSupportedOn_v8_of_v9` from field to lemma.
- NO new smuggled axioms. NO replacement cert-verifier fields.
- Narrow honest sorries with `-- TODO: <specific gap>` ARE acceptable.
- ADD legitimate structural P-class primitive hypothesis fields as needed (cone-margin scalars, polyhedral vertex sets, radial symmetry function, etc.).
- Build MUST PASS.
- Cap at 8 iterations.

# Files

- Edit: `lean/v9_appendix.lean`
- Read-only: `lean/v8_main.lean`

# Output

Report under 500 words: build status, sorry count, axiom list (target 8 unchanged), removed fields, added P-class primitive structural fields, per-theorem resolution.
