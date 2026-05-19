/-
posterior_law_barycenter_identities — proved 2026-05-19 (in-thread, trivial structural unpack)

Imports required (from main.lean's preamble):
  import Mathlib
  -- Plus the structures: RobustTrustModel, PosteriorLawConsistency, Belief, beliefBarycenter, beliefCoord
-/

theorem posterior_law_barycenter_identities
    (model : RobustTrustModel)
    (plc : PosteriorLawConsistency model) :
    beliefBarycenter model.τ = model.μ0 ∧
      (∀ ω : model.Ω,
        (ENNReal.ofReal (model.μ0 ω)) • model.π ω =
          model.τ.withDensity (fun s => ENNReal.ofReal (beliefCoord s ω))) ∧
      (∀ᵐ s ∂model.τ, plc.posteriorAfterAdviser s = s) :=
  ⟨plc.barycenter_eq_prior, plc.coordinate_measure_identity, plc.posterior_after_adviser_ae⟩
