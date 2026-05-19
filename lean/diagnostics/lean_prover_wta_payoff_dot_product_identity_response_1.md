
========
ROLE: user (id=9e4f3459-84ee-4ae2-87b0-9395bb4f7576)
========
You are the Lean Prover in the Lean post-processing module.

## Your Job

Close ONE specific sorry in the Lean file by producing a Lean 4 / Mathlib tactic-mode proof for it. You will be passed the lemma's signature, the imports available, the inlined INVENTORY.lean stubs, and (if this is a retry) the AXLE compile errors from the previous attempt.

- Prove EXACTLY ONE lemma per submission. Stay focused. Do not try to "also clean up" other lemmas in the file.
- Use only the imports declared in the file (just import Mathlib).
- Prefer tactic mode (by … ) over term mode for any non-trivial proof.
- Cite tactics by their Mathlib4 name. Avoid native_decide and other unsafe tactics.
- If you cannot close the lemma, say so explicitly with STUCK and describe the obstruction precisely.

## Target lemma

wta_payoff_dot_product_identity (in namespace RobustTrustV8):


lean
theorem wta_payoff_dot_product_identity
    (lam : WTAΩ → ℝ)
    (hlam_nonneg : ∀ i : WTAΩ, 0 ≤ lam i)
    (hlam_sum : ∑ i : WTAΩ, lam i = 1)
    (s : WTABelief) :
    beliefDot s (WTA_mixedLabel lam) =
      2 * (∑ i : WTAΩ, lam i * s.val i) - 1 := by
  sorry


## Key definitions


lean
abbrev WTAΩ : Type := Fin 3
abbrev WTABelief : Type := Belief WTAΩ
abbrev WTAProfile : Type := WTAΩ → ℝ

def Belief (Ω : Type) [Fintype Ω] : Type :=
  {s : Ω → ℝ // (∀ ω : Ω, 0 ≤ s ω) ∧ (∑ ω : Ω, s ω) = 1}

def beliefDot {Ω : Type} [Fintype Ω] (s : Belief Ω) (w : Ω → ℝ) : ℝ :=
  ∑ ω : Ω, s.val ω * w ω

def WTA_vertex (i : WTAΩ) : WTAProfile :=
  fun j => if i = j then 1 else -1

def WTA_mixedLabel (lam : WTAΩ → ℝ) : WTAProfile :=
  fun j => ∑ i : WTAΩ, lam i * WTA_vertex i j


So WTA_mixedLabel lam j = ∑ i, lam i * (if i = j then 1 else -1).

The math: for each j, the inner sum splits as lam j * 1 + ∑ i ≠ j, lam i * (-1) = lam j - (1 - lam j) = 2 * lam j - 1 (using ∑ i, lam i = 1).

Then beliefDot s (WTA_mixedLabel lam) = ∑ j, s.val j * (2 * lam j - 1) = 2 * ∑ j, s.val j * lam j - ∑ j, s.val j = 2 * (∑ i, lam i * s.val i) - 1 (using ∑ s.val = 1 from s.property.2, and reindexing).

## Suggested Mathlib lemmas

- Finset.sum_ite_eq': ∑ x ∈ s, (if a = x then b a else 0) = if a ∈ s then b a else 0
- Finset.sum_ite_eq: similar direction
- Finset.sum_sub_distrib: ∑ (a - b) = ∑ a - ∑ b
- Finset.mul_sum, Finset.sum_mul: distribute
- Finset.sum_neg_distrib: ∑ (- a) = - ∑ a
- Finset.sum_erase_eq_sub: split a sum at a specific element
- Finset.sum_comm: swap summation order

## Output

Return your proof in two fenced blocks: lean_proof (metadata) and lean (the proof).


lean_proof
target_lemma_slug: wta_payoff_dot_product_identity
status: PROVED
tactics_used: [...]
proof_length_lines: <int>
introduces_have_clauses: <int>



lean
theorem wta_payoff_dot_product_identity
    (lam : WTAΩ → ℝ)
    (hlam_nonneg : ∀ i : WTAΩ, 0 ≤ lam i)
    (hlam_sum : ∑ i : WTAΩ, lam i = 1)
    (s : WTABelief) :
    beliefDot s (WTA_mixedLabel lam) =
      2 * (∑ i : WTAΩ, lam i * s.val i) - 1 := by
  -- your proof here
  sorry


## Notes

- AXLE will compile your proof. If it fails with "unknown lemma X", try a different Mathlib name.
- Don't write by grind as the whole proof if you can produce a structured proof.
- For finite-dim algebra over Fin 3, decide or explicit case analysis on Fin 3 may help.

Show more

========
ROLE: assistant (id=a6047373-2601-44fe-bfbe-97d2f0e36eca)
========
lean_proof
target_lemma_slug: wta_payoff_dot_product_identity
status: PROVED
tactics_used: [classical, intro, unfold, calc, apply, Finset.sum_congr, by_cases, simp, ring, rw, simp_rw]
proof_length_lines: 30
introduces_have_clauses: 2
lean
theorem wta_payoff_dot_product_identity
    (lam : WTAΩ → ℝ)
    (hlam_nonneg : ∀ i : WTAΩ, 0 ≤ lam i)
    (hlam_sum : ∑ i : WTAΩ, lam i = 1)
    (s : WTABelief) :
    beliefDot s (WTA_mixedLabel lam) =
      2 * (∑ i : WTAΩ, lam i * s.val i) - 1 := by
  classical
  have hvertex : ∀ j : WTAΩ, WTA_mixedLabel lam j = 2 * lam j - 1 := by
    intro j
    unfold WTA_mixedLabel WTA_vertex
    calc
      (∑ i : WTAΩ, lam i * (if i = j then (1 : ℝ) else -1))
          = ∑ i : WTAΩ, (2 * (if i = j then lam i else (0 : ℝ)) - lam i) := by
            apply Finset.sum_congr rfl
            intro i _
            by_cases h : i = j <;> simp [h] <;> ring
      _ = 2 * (∑ i : WTAΩ, (if i = j then lam i else (0 : ℝ))) - (∑ i : WTAΩ, lam i) := by
            rw [Finset.sum_sub_distrib]
            rw [← Finset.mul_sum]
      _ = 2 * lam j - 1 := by
            have hsingle : (∑ i : WTAΩ, (if i = j then lam i else (0 : ℝ))) = lam j := by
              simp
            rw [hsingle, hlam_sum]
  unfold beliefDot
  simp_rw [hvertex]
  calc
    (∑ ω : WTAΩ, s.val ω * (2 * lam ω - 1))
        = ∑ ω : WTAΩ, (2 * (lam ω * s.val ω) - s.val ω) := by
          apply Finset.sum_congr rfl
          intro ω _
          ring
    _ = 2 * (∑ ω : WTAΩ, lam ω * s.val ω) - (∑ ω : WTAΩ, s.val ω) := by
          rw [Finset.sum_sub_distrib]
          rw [← Finset.mul_sum]
    _ = 2 * (∑ i : WTAΩ, lam i * s.val i) - 1 := by
          rw [s.property.2]
