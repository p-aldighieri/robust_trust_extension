The canonical move is to make FBNFPackage a coordinate, disintegration, and alignment package, not a conclusion package. In particular, PsiNonpos_of_FBNFPackage should be the first place where regBridge.Psi ≤ 0 appears. The package should expose enough structure for Lean to compute the fiberwise integral and then integrate it. The v9 source is explicit that FBNF is a primitive sufficient class, not a universal theorem: it needs a Borel affine chart or quotient-consistent foliation, endpoint-fiber support rather than singleton endpoints, local two-sided perturbability, and global fiber dominance. 

v9_consolidated

1. Canonical data structure
A. Foliation must be a chart, not a decorative cover

Current foliation : Foliation model is too opaque unless it contains a real measurable coordinate system. The source warning is exactly right: a mere cover by fibers is not enough, because pasted posteriors can become multivalued at overlapping messages. 

sanity_chunk2_response

Use this shape:

lean
structure FBNFChart (model : RobustTrustModel) where
  Z : Type
  measurableZ : MeasurableSpace Z
  standardBorelZ : Prop

  a b : Z → ℝ
  interval_nonempty : ∀ z, a z ≤ b z

  /-- Per-fiber affine chart. Defined on all ℝ, supported on `[a z, b z]`. -/
  ell : Z → ℝ → model.M
  ell_measurable : Measurable fun p : Z × ℝ => ell p.1 p.2
  ell_affine : Prop

  /-- Global coordinate map Φ(z,t)=ell z t. -/
  Phi : {p : Z × ℝ // a p.1 ≤ p.2 ∧ p.2 ≤ b p.1} → model.M
  Phi_def :
    ∀ p, Phi p = ell p.val.1 p.val.2

  /-- Projection and coordinate inverse, valid τM-a.e. -/
  foliationProjection : model.M → Z
  fiberCoord : model.M → ℝ
  projection_measurable : Measurable foliationProjection
  fiberCoord_measurable : Measurable fiberCoord

  chart_left_inverse_ae :
    ∀ᵐ m ∂model.τM,
      ell (foliationProjection m) (fiberCoord m) = m

  fiberCoord_in_interval_ae :
    ∀ᵐ m ∂model.τM,
      a (foliationProjection m) ≤ fiberCoord m ∧
      fiberCoord m ≤ b (foliationProjection m)

  /--
  Either Φ is injective on a τ-full Borel set, or overlaps give the same
  TRS label, endpoint posterior, Bayes cone, and rowwise minimizer data.
  -/
  quotientConsistent : Prop

The important additions relative to the current package are foliationProjection, fiberCoord, chart_left_inverse_ae, and quotientConsistent. Without them, Lean cannot even state the fiberwise pullback of a bounded Borel price y : M → ℝ^Ω in a canonical way.

B. tauM_disintegration must be primitive or proved once

For the integrated bridge, do not store only lambdaBase : Measure Z. Store the full disintegration of τM.

lean
structure FBNFDisintegration
    (model : RobustTrustModel) (ch : FBNFChart model) where
  lambdaBase : Measure ch.Z
  tauFiber : ch.Z → Measure ℝ

  tauFiber_supported :
    ∀ᵐ z ∂lambdaBase,
      tauFiber z {t | ch.a z ≤ t ∧ t ≤ ch.b z}ᶜ = 0

  kernel_measurable :
    ∀ s : Set ℝ, MeasurableSet s →
      Measurable fun z => tauFiber z s

  /-- The real bridge: τM is the pushforward of the fiber product. -/
  tauM_disintegration :
    ∀ f : model.M → ℝ,
      Measurable f →
      Integrable f model.τM →
      (∫ m, f m ∂model.τM)
        =
      (∫ z, ∫ t, f (ch.ell z t) ∂tauFiber z ∂lambdaBase)

This is the field that makes the bridge possible. It is not smuggling Ψ ≤ 0; it is the measurable foliation itself. The FBNF capstone’s dependency chain is precisely: endpoint-supported fiber image, localized stationarity, conditional B1 plus measurable pasting, then F4 capstone assembly. 

decomposition

C. Endpoint band and concrete fiber balances

Do not keep balanceL balanceR : Z → Prop as black boxes. Replace them with explicit scalar equations. The v9 FBNF6 balances are concrete left and right endpoint moment equalities, and the source states that two-sided perturbability is required to derive equality; otherwise the right object is a one-sided KKT inequality. 

v9_consolidated

lean
structure FBNFBand
    (model : RobustTrustModel)
    (ch : FBNFChart model)
    (dis : FBNFDisintegration model ch) where
  L R : ch.Z → ℝ

  L_in_interval : ∀ z, ch.a z ≤ L z ∧ L z ≤ ch.b z
  R_in_interval : ∀ z, ch.a z ≤ R z ∧ R z ≤ ch.b z
  L_le_R : ∀ z, L z ≤ R z

  L_measurable : Measurable L
  R_measurable : Measurable R

  leftEndpoint  : ch.Z → model.M := fun z => ch.ell z (L z)
  rightEndpoint : ch.Z → model.M := fun z => ch.ell z (R z)

  sourceToLeft  : ch.Z → Set ℝ
  sourceToRight : ch.Z → Set ℝ
  sourceToLeft_measurable :
    MeasurableSet {p : ch.Z × ℝ | p.2 ∈ sourceToLeft p.1}
  sourceToRight_measurable :
    MeasurableSet {p : ch.Z × ℝ | p.2 ∈ sourceToRight p.1}

structure FiberBalance
    (model : RobustTrustModel)
    {ch : FBNFChart model}
    {dis : FBNFDisintegration model ch}
    (band : FBNFBand model ch dis)
    (z : ch.Z) : Prop where
  left_balance :
    model.α *
      (∫ t in {t | ch.a z ≤ t ∧ t ≤ band.L z},
        (band.L z - t) ∂dis.tauFiber z)
    =
    (1 - model.α) *
      (∫ t in band.sourceToLeft z,
        (t - band.L z) ∂dis.tauFiber z)

  right_balance :
    model.α *
      (∫ t in {t | band.R z ≤ t ∧ t ≤ ch.b z},
        (t - band.R z) ∂dis.tauFiber z)
    =
    (1 - model.α) *
      (∫ t in band.sourceToRight z,
        (band.R z - t) ∂dis.tauFiber z)

Then the package carries:

lean
fiberBalanceAE :
  ∀ᵐ z ∂dis.lambdaBase, FiberBalance model band z

This is acceptable as FBNF6 data if you are not formalizing the stationarity derivation in this theorem. Better still, make it the conclusion of a previous theorem localizedStationarityFBNF6_of_localTwoSidedPerturbability.

D. RegPackage alignment: B, G, and wstar must be fiber-aligned

This is the part that was missing in Phase 10. The bridge cannot be proved from a foliation alone. regBridge must know that its global Bayes cones and rowwise minimizer correspondence are the same objects that the fiber proof sees.

lean
structure FBNFRegAlignment
    (model : RobustTrustModel)
    (ch : FBNFChart model)
    (dis : FBNFDisintegration model ch)
    (band : FBNFBand model ch dis)
    (reg : RegPackage model) where

  /-- The optimal labeling / continuation is fiber-preserving. -/
  wstar_fiber :
    ∀ᵐ z ∂dis.lambdaBase,
      ∀ᵐ t ∂dis.tauFiber z,
        reg.wstar (ch.ell z t)
          =
        reg.wstar (ch.ell z
          (Real.clamp (band.L z) (band.R z) t))

  /--
  Bayes cone used by regBridge agrees with the fiber endpoint Bayes cone.
  Full set equality is ideal; support-function equality is enough for Ψ.
  -/
  regBridge_B_fiber_alignment :
    ∀ᵐ z ∂dis.lambdaBase,
      ∀ᵐ t ∂dis.tauFiber z,
        reg.B (ch.ell z t)
          =
        FiberBayesCone model ch band reg z t

  /--
  Rowwise minimizers used by regBridge agree with fiber endpoint minimizers
  after applying global fiber dominance.
  -/
  regBridge_G_fiber_alignment :
    ∀ᵐ z ∂dis.lambdaBase,
      ∀ᵐ t ∂dis.tauFiber z,
        reg.G (ch.ell z t)
          =
        ch.ell z '' FiberRowMinimizers model ch band reg z t

  /--
  Global fiber dominance:
  a fiber-local minimizer is a true global rowwise minimizer.
  This should be stated in coordinates, τbar-a.e.
  -/
  globalFiberDominance :
    ∀ᵐ z ∂dis.lambdaBase,
      ∀ᵐ t ∂dis.tauFiber z,
        (⨅ μ ∈ TrustRegion model reg,
          beliefDot (ch.ell z t) (reg.wstar μ))
        =
        (⨅ μ ∈ FiberTrustRegion model ch band z,
          beliefDot (ch.ell z t) (reg.wstar μ))

The global dominance field is not decoration: v9 says it is the cross-fiber condition that turns fiber-local rowwise minimizers into true original-game minimizers. 

v9_consolidated

E. Define Ψ by formula, or store its formula, not its sign

The bridge needs a definitional or specified formula for reg.Psi. If RegPackage.Psi is an opaque field, Lean has no reason to believe it decomposes under τM.

The cleanest solution is to remove Psi as arbitrary data and define it from reg.B, reg.G, τM, and the support functions. If that refactor is too large, add a specification:

lean
structure RegPsiSpec
    (model : RobustTrustModel)
    (reg : RegPackage model) where
  psi_global_formula :
    ∀ y : BoundedBorelProfile model,
      reg.Psi y =
        GlobalPsiFormula model reg y

Then prove the bridge as a theorem:

lean
theorem regPsi_eq_integral_fiberPsi
    (pkg : FBNFPackage model)
    (y : BoundedBorelProfile model) :
  pkg.reg.Psi y
    =
  ∫ z, FiberPsi pkg z (PullPrice pkg y z) ∂pkg.dis.lambdaBase := ...

Do not store regPsi_eq_integral_fiberPsi as an arbitrary Prop unless its right side is literally obtained by unfolding reg.Psi and applying tauM_disintegration. Otherwise the bridge field becomes a tiny trapdoor with a brass plaque.

F. Final canonical FBNFPackage

Putting the pieces together:

lean
structure FBNFPackage (model : RobustTrustModel) where
  pd : PosteriorDisintegration model

  card_ge_three : 3 ≤ Fintype.card model.Ω
  alpha_pos : 0 < model.α
  alpha_lt_one : model.α < 1

  chart : FBNFChart model
  dis : FBNFDisintegration model chart
  band : FBNFBand model chart dis

  reg : RegPackage model
  regPsiSpec : RegPsiSpec model reg
  align : FBNFRegAlignment model chart dis band reg

  /-- FBNF-3, endpoint-supported projected image, not strict argmin subset. -/
  endpointSupportedFiberImage :
    ∀ᵐ z ∂dis.lambdaBase,
      ∀ᵐ t ∂dis.tauFiber z,
        FiberEndpointSupported model chart band reg z t

  /-- FBNF-4. -/
  fiberEndpointExposure :
    ∀ᵐ z ∂dis.lambdaBase,
      FiberEndpointExposure model chart band reg z

  /-- FBNF-5, or explicit tie-splitting variant. -/
  fiberTieDiscipline :
    ∀ᵐ z ∂dis.lambdaBase,
      FiberTieDiscipline model chart band reg z

  /-- Local two-sided perturbability, needed to derive equalities. -/
  localTwoSidedPerturbability :
    LocalTwoSidedPerturbability model chart band reg

  /-- FBNF-6, preferably proved from the previous field. -/
  fiberBalanceAE :
    ∀ᵐ z ∂dis.lambdaBase, FiberBalance model band z

Notice what is not here: no capstoneConclusion, no PsiNonpos, no robustRationalizableStrategy, no fiberwisePsiNonpos. Those are theorem outputs. The structural refinement notes explicitly warn against conclusion-as-field packaging and emphasize that the FBNF capstone’s real object is a Borel adversarial kernel with endpoint-fiber support, not a field asserting the end theorem. 

structural_refinement_response

2. Proof skeleton for PsiNonpos_of_FBNFPackage

Target:

lean
theorem PsiNonpos_of_FBNFPackage
    (pkg : FBNFPackage model) :
    PsiNonpos model pkg.reg := by
  intro y
  ...
Step 1: Pull the price back to coordinates

For a bounded Borel price y : M → ℝ^Ω, define

lean
def yFiber (z : pkg.chart.Z) (t : ℝ) : Profile model :=
  y.toFun (pkg.chart.ell z t)

Prove measurability and boundedness from ell_measurable and y.measurable_toFun.

lean
have hy_meas :
  Measurable fun p : pkg.chart.Z × ℝ =>
    y.toFun (pkg.chart.ell p.1 p.2) := ...

have hy_bdd :
  ∃ C, 0 ≤ C ∧ ∀ z t ω,
    |y.toFun (pkg.chart.ell z t) ω| ≤ C := ...
Step 2: Rewrite global Ψ as an integral of fiber Ψ

Unfold reg.Psi using regPsiSpec.psi_global_formula, then apply the disintegration formula to each aligned and adversarial term. The result should be:

Ψ(y)=∫
Z
	​

Ψ
z
	​

(y∘ℓ
z
	​

)dλ(z).

Lean theorem:

lean
have hPsiSplit :
  pkg.reg.Psi y =
    ∫ z, FiberPsi pkg z (PullPrice pkg y z)
      ∂pkg.dis.lambdaBase := by
  exact regPsi_eq_integral_fiberPsi pkg y

This is the bridge. It should use only tauM_disintegration, B_fiber_alignment, G_fiber_alignment, and the global Ψ formula. It should not use any inequality.

Step 3: Prove fiberwise nonpositivity

For λ-a.e. z, use pkg.fiberBalanceAE z, endpoint exposure, endpoint-supported image, tie discipline, and B/G alignment. The binary endpoint-fiber lift gives a calibrated fiber kernel. In primal terms, the fiber posterior equals the left endpoint on the left endpoint fiber, the right endpoint on the right endpoint fiber, and the truthful message on the interior. This is exactly the endpoint-fiber pattern in the v9 capstone. 

v9_consolidated

Formal lemma:

lean
theorem FiberPsi_nonpos_of_balance
    (pkg : FBNFPackage model)
    {z : pkg.chart.Z}
    (hbal : FiberBalance model pkg.band z)
    (hexp : FiberEndpointExposure model pkg.chart pkg.band pkg.reg z)
    (htie : FiberTieDiscipline model pkg.chart pkg.band pkg.reg z)
    (yZ : BoundedBorelFiberPrice pkg z) :
    FiberPsi pkg z yZ ≤ 0 := by
  -- Binary B1 / Strassen endpoint-fiber lift on this fiber.
  -- Posterior-in-Bayes-cone implies support-function inequality.

The last line is the local cone inequality:

y(m)⋅n(m)−h
B(m)
	​

(y(m))q(m)≤0

because the calibrated posterior n(m)/q(m) lies in the Bayes cone B(m). This is where regBridge_B_fiber_alignment is used.

Step 4: Integrate the a.e. fiber inequality
lean
have hFiberNonpos :
  ∀ᵐ z ∂pkg.dis.lambdaBase,
    FiberPsi pkg z (PullPrice pkg y z) ≤ 0 := by
  filter_mono [pkg.fiberBalanceAE, pkg.fiberEndpointExposure,
               pkg.fiberTieDiscipline] with z hbal hexp htie
  exact FiberPsi_nonpos_of_balance pkg hbal hexp htie (PullPrice pkg y z)

have hInt :
  Integrable (fun z =>
    FiberPsi pkg z (PullPrice pkg y z)) pkg.dis.lambdaBase := ...

calc
  pkg.reg.Psi y
      = ∫ z, FiberPsi pkg z (PullPrice pkg y z)
          ∂pkg.dis.lambdaBase := hPsiSplit
  _ ≤ 0 := integral_nonpos_of_ae hInt hFiberNonpos

That is the whole bridge: no fog machine, just disintegration, fiber B1, and integral_nonpos_of_ae.

3. What to do with the current fields
Current field	Keep?	Replacement
foliation : Foliation model	Yes, but strengthen	Must include chart, projection, coordinate inverse, quotient consistency
L R : Z → ℝ	Yes	Put inside FBNFBand with measurability and interval proofs
lambdaBase : Measure Z	Not alone	Put inside FBNFDisintegration with tauFiber and integral formula
balanceL balanceR : Z → Prop	No	Replace by concrete FiberBalance z equations
fbnf_fiberwise_balance : IsFiberwiseBalanceLambdaAE ...	Yes only if concrete	∀ᵐ z, FiberBalance z
conditionalB1Pasting : Prop	No as bare Prop	Prove as lemma from fiberBalanceAE, Strassen, chart, quotient consistency
endpointSupportedFiberImage : Prop	Yes if concrete	State coordinate endpoint-supported minimization, not strict argmin subset
localizedStationarityFBNF6 : Prop	Better as theorem	Derive fiberBalanceAE; needs local two-sided perturbability
globalFiberDominance : Prop	Yes if concrete	State coordinate equality of global min and fiber min
fbnf7DominanceMargin > 0	Optional	Useful for perturbation stability, not a substitute for exact dominance
regBridge : RegPackage model	Yes	Add wstar, B, G, and Psi alignment with fibers

The source explicitly notes that FBNF’s endpoint-supported image should not be strengthened to “the whole argmin set is endpoints” unless extra strict no-interior-flatness is added. The weaker endpoint-supported selector is enough. 

sanity_chunk2_response

4. Irreducible external axioms

For PsiNonpos_of_FBNFPackage itself, the irreducible external tools are few.

First, the binary endpoint-fiber lift uses a Strassen/coupling theorem or equivalent marginal transport theorem. This is the real measure-theoretic hammer behind “fiber balance gives a kernel.” The decomposition already marks Inventory.strassen_marginals as the axiom inherited by FBNF-F1 and binary B1. 

decomposition

Second, measurable selection is needed for endpoint-supported minimizers, tie-splitting, and kernel pasting. This is KRN/Castaing-Valadier territory. It is acceptable as an Inventory axiom, but it must be stated as a measurable selection theorem, not as “there exists the FBNF kernel.”

Third, deriving fiberBalanceAE from localized stationarity uses Clarke-Danskin plus Clarke-Fermat normal-cone stationarity. If fiberBalanceAE is an input theorem already proved upstream, PsiNonpos_of_FBNFPackage does not need Clarke. If this theorem derives FBNF6 internally, it does. The v9 decomposition explicitly routes FBNF-F3 through T1 and the Clarke-Danskin/Fermat mechanism. 

decomposition

Fourth, regular conditional probability / disintegration can be either a structural field of FBNF or an external theorem. For this theorem, I would keep it as structural data: FBNF is exactly the class where the model supplies a usable disintegration. Fubini/Tonelli, Radon-Nikodym bookkeeping, and integral_nonpos_of_ae should be ordinary Mathlib-level tools, not project axioms. The Lean audit also warns not to hardcode posterior RN orientation, and to route through the existing PosteriorDisintegration package. 

decomposition

Not needed here: Sion, product-of-narrow compactness, Berge maximum as an axiom, or finite Farkas/Hall duality. The FBNF proof is a scalar B1 transport proof plus integration. Cone-Hall is the parallel classification route, not the canonical FBNF capstone route.

5. One-line Lean dependency shape
lean
theorem PsiNonpos_of_FBNFPackage
    {model : RobustTrustModel}
    (pkg : FBNFPackage model) :
    PsiNonpos model pkg.reg := by
  intro y
  rw [regPsi_eq_integral_fiberPsi pkg y]
  apply integral_nonpos_of_ae
  · exact FiberPsi_integrable pkg y
  · filter_mono
      [pkg.fiberBalanceAE,
       pkg.endpointSupportedFiberImage,
       pkg.fiberEndpointExposure,
       pkg.fiberTieDiscipline,
       pkg.align.globalFiberDominance] with z hbal hend hexp htie hdom
    exact FiberPsi_nonpos_of_binaryB1
      pkg z y hbal hend hexp htie hdom

That is the proof spine. The dragon has only two heads: regPsi_eq_integral_fiberPsi and FiberPsi_nonpos_of_binaryB1. The first is pure disintegration plus alignment. The second is binary B1 plus Bayes-cone support. Keep those honest, and PsiNonpos_of_FBNFPackage becomes a tidy little theorem rather than a suitcase full of wishes.