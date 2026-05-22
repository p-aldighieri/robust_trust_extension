REFINEMENT REVIEW — VERDICT: PATCH_LIST

R1 — Inventory hypothesis structures: still trapdoors?

Verdict: PATCH

ConicFarkasInstance is sound. It is now a real finite conic feasibility statement: ∃ x ≥ 0, A x = b, with the dual no-separation condition ∀ y, yᵀA_j ≤ 0 → yᵀb ≤ 0; that is the standard finite-dimensional conic Farkas alternative. See v9_appendix.lean:L145-L171.

BergeMaximumHyp is removed. There is no remaining structure or axiom, only the comment saying to use compact extreme-value lemmas. See v9_appendix.lean:L173-L178. OK.

StrassenMarginalDominance is no longer an arbitrary Prop field. The dual inequality is mathematically recognizable and the conclusion is the genuine support-constrained coupling conclusion π Rᶜ = 0. See v9_appendix.lean:L118-L140. Patch needed: the theorem is too general over arbitrary measurable spaces. Strassen in this dual form needs standard Borel / Polish / Radon hypotheses. Add:

lean
[StandardBorelSpace α] [StandardBorelSpace β]

or a topological Polish/Radon package with finite Borel measures. Without that, the axiom imports a theorem beyond its standard domain.

ClarkeDanskinHyp is improved but not yet sufficient for Clarke 1990 §2.7 as stated. The fields are concrete, not arbitrary, but they do not control near-active nonactive indices. The current package has active compactness, active argmax equivalence, local Lipschitzness of F, differentiability of active candidates, and active gradient continuity. See v9_appendix.lean:L54-L90. Patch needed: add compactness or local compactness of the candidate index set, continuity/upper semicontinuity of φ in the index variable, and a uniform local Lipschitz/C¹ condition for all candidates near the active set, not just for active candidates. Otherwise nonactive candidates approaching the value at x can contribute to the Clarke subdifferential while their gradients are excluded from grad '' Active.

Precise patch direction:

lean
  index_compact_or_local :
    IsCompact (Set.univ : Set I) ∨
      ∃ U : Set I, IsCompact U ∧ Active ⊆ U ∧ ...
  phi_continuous_near_active :
    ContinuousOn (fun p : I × E => φ p.1 p.2) (U ×ˢ Metric.closedBall x r)
  uniform_has_fderiv_near_active :
    ∀ i ∈ U, HasFDerivAt (φ i) (grad i) x
  grad_continuous_near_active :
    ContinuousOn grad U

So: no old-style logical trapdoor remains in the named Inventory items, but Clarke and Strassen need domain-strengthening before the import is honest.

R2 — Conclusion-as-field fields removed?

Verdict: OK with one cleanup note

The three demanded conclusion fields are removed.

BinaryCapstoneData has no capstoneConclusion; binary-L_B6-capstone now concludes HasRobustRationalizableStrategy model data.pd directly. See v9_appendix.lean:L300-L324 and v9_appendix.lean:L619-L628.

FBNFPackage has no capstoneConclusion; FBNF-F4-capstone now concludes HasRobustRationalizableStrategy model pkg.pd. See v9_appendix.lean:L341-L362 and v9_appendix.lean:L656-L664.

GraphFBNFPackage has no capstoneConclusion; G-addendum-P6_G-finite-graph-FBNF concludes HasRobustRationalizableStrategy model pkg.pd. See v9_appendix.lean:L475-L481 and v9_appendix.lean:L865-L874.

RegPackage no longer has calibratedKernelExists or robustRationalizableLabeling as fields. The two are now definitions expanding to a concrete kernel-existence statement: a kernel κ, support on G, and posterior calibration pd.Pγα κ m ∈ B m q-a.e. See v9_appendix.lean:L371-L385 and v9_appendix.lean:L419-L425.

Cleanup: AlphaZeroSingletonData.robustRationalizable : Prop remains at v9_appendix.lean:L291-L296. It is not one of the reviewer-demanded fields and appears unused, but it is conclusion-shaped dead cargo. Remove it.

R3 — RegPackage σstar + concrete kernel content

Verdict: PATCH

The new Reg fields capture much of the intended Reg-1/Reg-2 content:

σstar and σstar_realizes_wstar are present. See v9_appendix.lean:L387-L395.

G_rowwise_minimizer is a concrete rowwise inequality over beliefDot (model.inclM s) (wstar m). See v9_appendix.lean:L396-L404.

B_bayes_optimal says every posterior in B m makes σstar.sectionFull (model.inclM m) Bayes-optimal. See v9_appendix.lean:L405-L413.

This is the right skeleton. But the bridge proof currently does not actually use σstar_realizes_wstar; it only comments that G_rowwise_minimizer and B_bayes_optimal discharge the predicate. See v9_appendix.lean:L689-L699. That is not enough.

Patch: split the bridge into two lemmas.

lean
lemma supportedOnRegG_isAdversarial
    (reg : RegPackage model) (κ : AdviserKernel model)
    (hSupp : KernelSupportedOnRegG model reg.G κ) :
    IsAdversarialFull model κ reg.σstar := by
  -- uses reg.σstar_realizes_wstar and reg.G_rowwise_minimizer
  ...

lemma reg_calibration_gives_bayes_ae
    (reg : RegPackage model) (κ : AdviserKernel model)
    (hCal :
      ∀ᵐ m ∂((MixtureCouplingGammaAlpha model κ).map Prod.snd),
        reg.pd.Pγα κ m ∈ reg.B m) :
    ∀ᵐ m ∂MixtureMessageLaw model κ,
      IsBayesOptimal model
        (reg.σstar.sectionFull (model.inclM m))
        (reg.pd.Pβ κ m) := by
  -- needs γ-second = MixtureMessageLaw and Pβ = Pγα a.e.
  ...

Also patch B_convex_profile : Prop at v9_appendix.lean:L407-L409. Cone-Hall needs convex Bayes cones. This should not be an arbitrary Prop. Make it a concrete convexity statement in the vector representation of beliefs.

R4 — Hall biconditional over robustRationalizableKernelExists

Verdict: PATCH

The left side is non-vacuous. reg.robustRationalizableKernelExists unfolds to RegCalibratedKernelExists, which is a concrete existential over a kernel supported on G with q-a.e. posterior calibration. See v9_appendix.lean:L371-L385 and v9_appendix.lean:L423-L425.

The right side is not yet genuinely mathematical because RegPackage carries Psi : BoundedBorelProfile model → ℝ as an arbitrary field. See v9_appendix.lean:L414-L417. The theorem

lean
reg.robustRationalizableKernelExists ↔ PsiNonpos model reg

at v9_appendix.lean:L680-L684 is therefore a biconditional against an uninterpreted dual functional.

Patch: remove Psi from RegPackage and define it from G, B, τ, α, and support functions.

lean
noncomputable def RegPsi (reg : RegPackage model)
    (y : BoundedBorelProfile model) : ℝ :=
  model.α *
      ∫ m, (beliefDot (model.inclM m) (y.toFun m)
             - supportFunction model (reg.B m) (y.toFun m)) ∂model.τM
    +
  (1 - model.α) *
      ∫ s, sInf
        ((fun m =>
            beliefDot (model.inclM s) (y.toFun m)
              - supportFunction model (reg.B m) (y.toFun m))
          '' reg.G s) ∂model.τM

def PsiNonpos (reg : RegPackage model) : Prop :=
  ∀ y : BoundedBorelProfile model, RegPsi model reg y ≤ 0

Only after this patch is R4 the claimed Hall/Strassen-style dual quantifier rather than a dial the structure owner can turn.

R5 — Bridge lemma robustRationalizableKernelExists_to_strategy

Verdict: PATCH

The witness shape is correct: it refines to ⟨κ, reg.σstar, ?_⟩. See v9_appendix.lean:L689-L695.

But the bridge is not aligned with the v8 predicate yet. In v8, Definition2QAEPredicate requires:

lean
IsAdversarialFull model β σFull ∧
∀ᵐ m ∂MixtureMessageLaw model β,
  IsBayesOptimal model (σFull.sectionFull (model.inclM m)) (pd.Pβ β m)

See v8_main.lean:L406-L411.

The v9 calibrated-kernel predicate instead gives:

lean
∀ᵐ m ∂((MixtureCouplingGammaAlpha model κ).map Prod.snd),
  pd.Pγα κ m ∈ B m

See v9_appendix.lean:L371-L379.

So the missing alignment is not cosmetic. The bridge must prove both:

(MixtureCouplingGammaAlpha model κ).map Prod.snd = MixtureMessageLaw model κ;

pd.Pβ κ = pd.Pγα κ q-a.e., using the disintegration identities.

This is exactly the Pβ/Pγα seam. The existing v8 file has a related proof under MenuHall for posterior coincidence, but this v9 bridge needs a standalone version that does not depend on MenuHall.

Patch:

lean
lemma gamma_second_eq_mixtureMessageLaw
    (κ : AdviserKernel model) :
    (MixtureCouplingGammaAlpha model κ).map Prod.snd =
      MixtureMessageLaw model κ := by
  ...

lemma posterior_Pβ_eq_Pγα_ae
    (pd : PosteriorDisintegration model) (κ : AdviserKernel model) :
    ∀ᵐ m ∂MixtureMessageLaw model κ,
      pd.Pβ κ m = pd.Pγα κ m := by
  -- use sourceLawβ_disintegrates and sourceLawγα_disintegrates
  ...

KernelSupportedOnRegG + G_rowwise_minimizer does imply the adversarial part only after using σstar_realizes_wstar. The Bayes-optimality part follows from hCal + B_bayes_optimal only after the Pβ/Pγα and message-law patches above. Current comment lines v9_appendix.lean:L696-L698 skip that dragon cave.

R6 — FBNF corollaries as instantiation lemmas

Verdict: FLAG

This is a real gap.

The primitive classes do carry useful bridge fields: radial/MLR/polyhedral data include foliation, fiber-preserving TRS, endpoint support, endpoint exposure, tie discipline, local two-sided perturbability, and global dominance. See v9_appendix.lean:L485-L527.

But the constructed packages set:

lean
conditionalB1Pasting := True
localizedStationarityFBNF6 := True

in all three corollaries. See v9_appendix.lean:L790-L791, v9_appendix.lean:L815-L816, and v9_appendix.lean:L837-L838.

That is a trapdoor. Since FBNF-F4-capstone only needs pkg.conditionalB1Pasting and pkg.localizedStationarityFBNF6 as assumptions, setting them to True lets the capstone be applied without proving F1 or F3. This defeats the point of the FBNF decomposition, whose source dependency chain is F2 endpoint-supported fiber image → F3 localized stationarity → F1 conditional B1 + pasting → F4 capstone.

Patch: add these fields to each primitive class, or derive them by applying F1 and F3 before F4.

Minimal direct patch:

lean
structure SphericalRadialFBNFPrimitive where
  ...
  conditionalB1Pasting_from_radial :
    Prop  -- replace by concrete formula or theorem input
  localizedStationarityFBNF6_from_radial :
    Prop

-- package construction
conditionalB1Pasting := prim.conditionalB1Pasting_from_radial
localizedStationarityFBNF6 := prim.localizedStationarityFBNF6_from_radial

Better patch:

lean
have hF2 : pkg.endpointSupportedFiberImage := ...
have hF3 : pkg.localizedStationarityFBNF6 :=
  «FBNF-F3-localized-stationarity-FBNF6» pkg hT1 hF2 pkg.localTwoSidedPerturbability
have hF1 : pkg.conditionalB1Pasting :=
  «FBNF-F1-conditional-B1-measurable-pasting» pkg hB1
exact ⟨pkg, «FBNF-F4-capstone» pkg hF1 hF2 hF3 pkg.globalFiberDominance⟩

The structural refinement document itself warns that P4/radial data alone is not enough unless the missing bridge fields such as radial foliation and global dominance are explicit; the current Lean file did add some of those fields, but then smuggled the two most load-bearing FBNF conclusions through True. That little True is a red button in a candy wrapper.

R7 — WTA threshold normalization

Verdict: PATCH

The Lean theorem in v9_appendix.lean is algebraically correct for the stated expression:

lean
((-2 * α * D + (1 - α) * ((4 : ℝ) / 9) ≤ 0)
  ↔ ((2 * (1 - α)) / (9 * α) ≤ D))

See v9_appendix.lean:L710-L718. The proof using div_le_iff₀ and nlinarith is fine, and hα_lt is harmless but unused.

However, the uploaded source memos are not fully consistent. source_proof.md locks the threshold as D ≥ 2(1−α)/(9α) at source_proof.md:L72-L75, and the application table in v9_consolidated.md also has that value at v9_consolidated.md:L1939-L1940. But the narrative WTA normalization block in v9_consolidated.md still displays 9/4 and D ≥ 9α/(2(1−α)) at v9_consolidated.md:L1795-L1817, and v9_executive_summary.md repeats the same reciprocal-style text at v9_executive_summary.md:L68-L82.

Patch the memos, not the Lean theorem:

Replace every displayed `(1−α) * 9/4` in the WTA threshold block by `(1−α) * 4/9`.

Replace every `D ≥ 9α/(2(1−α))` by `D ≥ 2(1−α)/(9α)`.

So R7 is internally OK in Lean, but cross-source consistency is still broken.

R8 — Anything missed

Verdict: FLAG

Several new or remaining structural issues matter.

First, many theorem-surface objects still use arbitrary Prop fields where the source proofs require concrete content. Examples:

FiniteMenuData still has theorem targets as fields: clarkeDanskinRepresentation, clarkeFermatStationarity, multipliersAreCalibrationKernel, and multiplierBayesCone. See v9_appendix.lean:L275-L287. That is acceptable as a scratch skeleton, not as a mergeable formalization surface.

FiniteConeHallInstance and PolyhedralLPInstance are still arbitrary Prop pairs/triples, so Hall-G1-finite-cone-hall-farkas-LP and G4-finite-facet-polyhedral-LP-threshold are not yet concrete LP/Farkas theorems. See v9_appendix.lean:L429-L441 and theorem statements at v9_appendix.lean:L668-L671, v9_appendix.lean:L722-L725.

P2StarHyp, P3Hyp, P4Hyp, VariableMarginP2Hyp, and GraphFBNFPackage are still mostly named Prop placeholders. See v9_appendix.lean:L443-L481. For paper exposition, these can be named assumptions. For Lean merge, they need formulas: margin inequalities, density domination, LP feasibility, radial invariance, Kirchhoff balance, and cross-edge dominance.

Second, Foliation is too thin for FBNF. It has chartMeasurable : Prop, disintegration : Prop, and quotientConsistent : Prop, but no concrete base measure, fiber kernels, pushforward equality, full-measure injectivity set, or quotient relation. See v9_appendix.lean:L328-L339. The FBNF source needs an actual Borel chart or quotient-consistency mechanism, not a Borel-chart poem. Patch:

lean
structure Foliation where
  Z : Type
  measurableZ : MeasurableSpace Z
  standardBorelZ : StandardBorelSpace Z
  base : Measure Z
  fiber : Z → Measure ℝ
  fiber_kernel : Kernel Z ℝ
  ell : ...
  ell_measurable : Measurable ...
  pushforward_tau :
    Measure.map Phi (base.compProd fiber_kernel) = model.τM.map model.inclM
  fullInjectiveSet : Set (Z × ℝ)
  fullInjective_meas : MeasurableSet fullInjectiveSet
  fullInjective_full :
    (base.compProd fiber_kernel) fullInjectiveSetᶜ = 0
  quotientConsistent_formula : ...

Third, hausdorff_alexandroff_continuous_surjection remains an axiom returning bare Prop. See v9_appendix.lean:L180-L188. It is not directly a trapdoor into false theorems, but it is useless as an external theorem. It should be either removed until used or restored to the concrete existential statement from the earlier decomposition.

Fourth, the robust rationalizability target uses AgentStrategyFull, while the source paper’s strategy is message-indexed. That is fine because v8 provides the restriction bridge, but the proof needs to be explicit whenever a theorem uses only model.M. In the Reg bridge, this is handled by σstar.sectionFull (model.inclM m), but the adversarial proof must explicitly restrict to M.

OVERALL

The refined v9_appendix.lean is not mergeable as a sound structural patch yet. It made real progress: the named Inventory trapdoors are mostly replaced by recognizable mathematical statements, the demanded conclusion-as-field trio is removed, the Reg kernel-existence proposition is concrete, and the binary/FBNF capstone conclusions now state the target directly.

But more structural patches are needed before the proof goblins should be let loose. The load-bearing remaining defects are: Clarke/Strassen domain hypotheses are too weak, Psi is still an arbitrary field rather than the cone-Hall functional, the Reg bridge misses the Pβ/Pγα and message-law alignment, the FBNF corollaries use True for F1/F3 outputs, and the uploaded WTA source memos still conflict with the Lean theorem.

Confidence: HIGH. The verdict is PATCH_LIST, not RESTART: the architecture is salvageable, but this is not a clean merge.