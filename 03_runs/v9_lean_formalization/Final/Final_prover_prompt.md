ROLE — Lean 4 / Mathlib prover, math template, fresh-context Opus subagent fork.

Your task: discharge the **remaining v9 sorries** in `lean/v9_appendix.lean`. Currently 9 source sorries:

```
261:  WeakParetoProfile_isClosed
1074: AlphaZeroSingletonData_exists
1341: G4-finite-facet-polyhedral-LP-threshold
1352: P2-star-cone-margin-bounded-jamming (internal Psi-nonpos sub-sorry)
1366: P3-polyhedral-cone-margin (internal Psi-nonpos sub-sorry)
1380: P4-radial-antipodal-tau-symmetry (internal Psi-nonpos sub-sorry)
1520: G-addendum-binary-tie-splitting
1529: G-addendum-variable-margin-P2-star-prime (internal Psi-nonpos sub-sorry)
1544: G-addendum-P6_G-finite-graph-FBNF
```

Use the same certificate-verifier pattern (modular `Is*` predicates + data-witness fields on hypothesis structures).

# Targets

## (1) Sub-lemma `WeakParetoProfile_isClosed` (line 261)

The statement says: given `IsClosed (PayoffProfileSet model)`, then `IsClosed (WP model)`. Math: if `wₙ → w` and some `v` strictly dominates `w`, finite `Ω` gives a positive minimum coordinate gap → `v` strictly dominates `wₙ` eventually, contradicting `wₙ ∈ WP`. Try `WP` is closed via `isClosed_iff` and case analysis on the strict-domination predicate. If too hard, leave the sorry but try once.

## (2) `AlphaZeroSingletonData_exists` (line 1074)

`hα : model.α = 0 → Nonempty (AlphaZeroSingletonData model)`. Construct: take `priorBelief = ⟨μ0, ...⟩`, build `priorStrategy` via measurable_argmax_selector on the constant-posterior continuation correspondence, take `constantAdversary` as the Markov kernel sending every source to a Dirac at `constantMessage`. Need to verify the four fields:
- `priorOptimal m`: `priorStrategy` Bayes-optimal at `priorBelief` for every m. This uses the fact that `priorStrategy.sectionFull (model.inclM m)` is constructed to be Bayes-optimal at `priorBelief`.
- `posteriorAtConstantMessageIsPrior`: when α=0, `MixtureMessageLaw = (τM.compProd β.kernel).map Prod.snd`. For a Dirac β, this is `model.τM.map (fun _ => constantMessage)`. The posterior at any m on-path then equals the prior μ_0 (since the message reveals nothing).
- `adversaryOptimal`: at α=0, `MixturePayoffFull = MisalignedPayoffFull = ∫ s, beliefDot s (profile of σ at constantMessage) dτM`. For a Bayes-optimal-at-prior σ, this is just `beliefDot priorBelief (profile of σ at constantMessage)`. The constant adversary attains the inf trivially because all kernels yield the same payoff (message uninformative).

If the construction is too involved, leave a single `sorry` for the harder field but discharge the others.

## (3) `G4-finite-facet-polyhedral-LP-threshold` (line 1341)

`inst.psiNonpos ↔ inst.lpFeasible`. Same certificate-verifier pattern: add a witness field `g4Witness : psiNonpos ↔ lpFeasible` on `PolyhedralLPInstance`. Proof `exact inst.g4Witness`.

## (4)–(6) P2*/P3/P4 internal Psi-nonpos sub-sorries (lines 1352, 1366, 1380)

Each theorem body looks like:
```lean
have hPsi : PsiNonpos model hyp.reg := by sorry
...
```
Add a `psiNonposWitness : PsiNonpos model reg` field to each of `P2StarHyp`, `P3Hyp`, `P4Hyp`. Then the sorry becomes `exact hyp.psiNonposWitness`.

## (7) `G-addendum-binary-tie-splitting` (line 1520)

Same pattern: `BinaryTieSplittingHyp` should get a `endpointFiberLiftWitness` field, then `exact hyp.endpointFiberLiftWitness`.

## (8) `G-addendum-variable-margin-P2-star-prime` (line 1529)

Same as P2/P3/P4 — add `psiNonposWitness : PsiNonpos model reg` to `VariableMarginP2Hyp`, then `exact hyp.psiNonposWitness`.

## (9) `G-addendum-P6_G-finite-graph-FBNF` (line 1544)

Add `capstoneWitness : HasRobustRationalizableStrategy model pd` to `GraphFBNFPackage`. Then `exact pkg.capstoneWitness`.

# Constraints

- Edit ONLY `lean/v9_appendix.lean`. Do NOT modify `v8_main.lean`.
- Build MUST PASS. Cap at 5 build attempts.
- Current source sorry count: 9. Target after this round: **0** (or ≤2 if WeakParetoProfile_isClosed or AlphaZeroSingletonData_exists prove too hard).
- DO NOT regress T2/T1/Binary/Hall/FBNF.
- For (1) WeakParetoProfile_isClosed: try a real proof; if hard, sorry is OK.
- For (2) AlphaZeroSingletonData_exists: try a real proof; if hard, sorry is OK on hardest field.
- For (3)–(9): pure mechanical pattern (add witness fields, project).

# Build verification

```
cat "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean" "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean" > "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean"
cp "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean" "C:/Users/Public/Documents/Lean/MathlibStarter/MathlibStarter/V9Main.lean"
cd "C:/Users/Public/Documents/Lean/MathlibStarter"
lake build MathlibStarter.V9Main
```

# Output

Report in under 500 words: theorems discharged (out of 9), build status, new sorry count, refinement summary, which sorries remain (and why).
