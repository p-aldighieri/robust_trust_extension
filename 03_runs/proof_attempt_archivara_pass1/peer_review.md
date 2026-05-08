# Peer Review: "Extending Robust Trust to Infinite Dimensions"

**Reviewer:** Automated Peer Reviewer (Nature/NeurIPS standard)
**Date:** 2026-02-16
**Paper:** "Extending Robust Trust to Infinite Dimensions: A Formally Verified Generalization of the Saddle-Point Characterization for Arbitrary Message and Type Spaces"

---

## Summary

The paper claims to extend Theorem 2 of Dworczak and Smolin (2026), "Robust Trust," from finite message support M and finite agent type space Θ to arbitrary (possibly infinite) M and compact metric Θ. The paper provides an English proof and a Lean 4/Mathlib formalization. The proof strategy is: (1) the optimality direction is finiteness-free, relying only on saddle-point inequalities; (2) the existence direction applies Sion's minimax theorem to product-topology strategy spaces after verifying compactness (Tychonoff), convexity, affinity, and continuity (bounded convergence); (3) measurable extraction of per-message Bayes-optimal strategies uses the Kuratowski–Ryll-Nardzewski (KRN) selection theorem.

---

## Criterion Scores

### 1. Completeness: 5/5

All required sections are present and well-structured: Abstract, Introduction, Related Work (Section 2), Background/Preliminaries (Section 3), Method/Proof Strategy (Section 4), Main Result (Section 5), Verification Methodology (Section 6), Results (Section 7), Discussion (Section 8), Conclusion (Section 9), References, and an Appendix with Lean code excerpts. The paper is thorough in covering the proof from multiple angles (English, formal, examples, comparison).

### 2. Technical Rigor: 3/5

**Strengths:**
- The proof strategy is mathematically sound in its overall structure. The identification that finiteness of Ω (not M or Θ) is the critical structural feature is a genuine and correct insight.
- The optimality direction (Part I) is clean and clearly finiteness-free; the Lean proof confirms this.
- The use of Sion's minimax theorem for the existence direction is appropriate.
- The bounded convergence argument for continuity (Lemmas 4.3–4.4) is correctly identified as the key technical step.

**Significant Weaknesses:**

**(a) The Lean formalization axiomatizes rather than constructs.** The `GameSetup` structure in `Theorem2Extension.lean` takes compactness, convexity, continuity, and affinity of the strategy spaces and payoff as *axioms*. The Lean proof then shows: "if these axioms hold, the theorem follows via Sion." This is logically correct but means the Lean formalization does **not** verify the core mathematical content of the extension — namely, that the product-of-narrow topology on the strategy spaces actually satisfies these axioms for the specific model of Dworczak-Smolin. The measure-theoretic construction (product topology, Prokhorov's theorem, bounded convergence) is verified only in the English proof, not in Lean.

This is a significant gap. The paper's central claim is that the hypotheses of Sion's theorem are verified for the specific game. But the Lean proof only verifies the abstract "if Sion's hypotheses hold, then saddle point exists" step, which is essentially trivial given the sorry'd Sion theorem. The hard part — showing Sion's hypotheses hold for the concrete strategy spaces — is not formalized.

**(b) The continuity argument (Lemma 4.3) has a subtle gap.** The proof claims that if σ_n → σ in the product topology (i.e., σ_n(·|m,θ) → σ(·|m,θ) narrowly for each (m,θ)), then U(β,σ_n) → U(β,σ) by bounded convergence. However, the bounded convergence theorem requires integration over a *measure space*, and the integration variable here is the pair (m,θ) integrated against τ(dμ)·μ(ω)·f(dθ|ω). The product-topology convergence gives pointwise convergence of the integrand for each (m,θ), and the integrand is uniformly bounded. The bounded convergence theorem (Lebesgue dominated convergence) then applies directly. This argument is correct but the paper could be more explicit about the σ-algebra on M × Θ and measurability of the integrand as a function of (m,θ). The argument is sketched rather than proven in full detail.

**(c) The continuity argument (Lemma 4.4) for β has a subtlety.** The proof defines ω-weighted marginals λ_ω^{β_n} and argues their narrow convergence. The claim that g_σ(·,ω) is bounded is correct (since u is bounded), but g_σ(·,ω) must also be *continuous* for the narrow convergence to yield convergence of the integral. The proof asserts this implicitly but does not verify it. Specifically, g_σ(m,ω) = ∫_Θ f(dθ|ω) ∫_A u(a,ω,θ) σ(da|m,θ), and its continuity in m depends on the continuity of σ(·|m,θ) as a function of m, which is **not** guaranteed by the product topology (the product topology gives convergence for each fixed m, not continuity in m). This is a genuine concern: narrow convergence of λ_ω^{β_n} → λ_ω^β plus boundedness of the test function g_σ is sufficient only if g_σ is also continuous. If g_σ is merely measurable and bounded, one needs dominated convergence with respect to the measure λ_ω^β, but the convergence of integrals against bounded *measurable* (not continuous) functions does not follow from narrow convergence alone.

**However**, since U is affine in β and the paper verifies separate continuity via the structure of the payoff (finite sum over ω, integration against τ), one can argue the continuity more carefully: the integrand for each fixed μ converges by narrow convergence of β_n(·|μ), and bounded convergence over τ(dμ) gives the result. The proof's argument via the marginals λ_ω^{β_n} is an indirect route that introduces the g_σ continuity issue unnecessarily. The direct argument (convergence for each μ, then bounded convergence over τ) works without requiring g_σ to be continuous.

**(d) The KRN selection theorem is cited but not actually used in the Lean formalization.** The dependency audit (results/dependency_audit.json) acknowledges this: "Not directly invoked in the current Lean proof." The KRN theorem is needed to justify that the axioms of GameSetup can be satisfied when M is infinite, but since the axioms are taken as given, the KRN sorry serves no purpose in the current formalization. This is somewhat misleading — the paper claims the KRN theorem is a dependency, but the Lean code does not use it.

**(e) The `optimality_of_rr` theorem (Lean line 139–148) only proves U(β*, σ) ≤ U(β*, σ*), which is the left saddle-point inequality.** The paper's Equation (4) claims the chain inf_β U(β,σ) ≤ U(β*,σ) ≤ U(β*,σ*) = inf_β U(β*,σ*), but the "= inf_β U(β,σ*)" equality requires showing β* attains the infimum for σ*. This follows from the right saddle-point inequality (U(β*,σ*) ≤ U(β,σ*) for all β), which implies U(β*,σ*) = inf_β U(β,σ*). The Lean `saddle_point_inequality` theorem does prove U(β*,σ) ≤ U(β,σ*) for all σ,β, which is stronger. But the statement `theorem2_extended` only states Part 2 as "U(β*,σ) ≤ U(β*,σ*)" — it does not formally state the robust objective inequality sup_σ inf_β U(β,σ) ≤ inf_β U(β,σ*). This is a minor incompleteness in the formal statement (the mathematical argument is correct).

### 3. Results Integrity: 4/5

**Strengths:**
- The verification_results.json confirms the build succeeds with the reported sorry counts.
- The paper_examples_test.json confirms the five examples and their coverage status.
- The dependency_audit.json confirms the two sorry'd theorems are published results.
- The literature_comparison.json confirms the comparison claims.
- Figure 1 (proof_architecture.pdf) matches the actual Lean code structure.

**Weaknesses:**
- The paper claims "five concrete examples from the paper" (Table 3), but these are conceptual verification checks, not numerical experiments. They confirm that the theorem's assumptions are satisfied in specific cases but do not compute any equilibria or saddle points. This is appropriate for a theoretical paper but the language "verification" may overstate the nature of the tests.
- The paper claims "zero sorry in the main theorem file" but should more prominently disclose that the main theorem file axiomatizes the game setup rather than constructing it from primitives. The zero-sorry claim is technically accurate but potentially misleading about the scope of formal verification.

### 4. Citation Accuracy: 4/5

**Citation Verification Report:**

| # | Cite Key | Title | Authors | Year | Venue | Pages/Vol | Verified? | Notes |
|---|----------|-------|---------|------|-------|-----------|-----------|-------|
| 1 | `dworczak2026robust` | Robust Trust | Dworczak, Smolin | 2026 | arXiv:2602.09490 | — | **VERIFIED** | Confirmed via arxiv.org |
| 2 | `sion1958general` | On General Minimax Theorems | Sion, Maurice | 1958 | Pacific J. Math. | 8(1):171–176 | **VERIFIED** | Confirmed via projecteuclid.org and msp.org |
| 3 | `fan1953minimax` | Minimax Theorems | Fan, Ky | 1953 | PNAS | 39(1):42–47 | **VERIFIED** | Confirmed via pnas.org |
| 4 | `fan1952fixed` | Fixed-Point and Minimax Theorems in Locally Convex Topological Linear Spaces | Fan, Ky | 1952 | PNAS | 38(2):121–126 | **VERIFIED** | Confirmed via pnas.org |
| 5 | `komiya1988elementary` | Elementary Proof for Sion's Minimax Theorem | Komiya, Hidetoshi | 1988 | Kodai Math. J. | 11(1):5–7 | **VERIFIED** | Confirmed via projecteuclid.org |
| 6 | `kuratowski1965general` | A General Theorem on Selectors | Kuratowski, K.; Ryll-Nardzewski, C. | 1965 | Bull. Acad. Polon. Sci. | 13:471–478 | **PARTIALLY VERIFIED** | The predominant bibliographic record gives pages **397–403**, not 471–478. Some sources do cite 471–478. The discrepancy may stem from different pagination in the physical volume vs. the series. The title, authors, year, and journal are correct. **FLAG: Page numbers should be checked and corrected to 397–403.** |
| 7 | `prokhorov1956convergence` | Convergence of Random Processes and Limit Theorems in Probability Theory | Prokhorov, Yuri V. | 1956 | Theory Probab. Appl. | 1(2):157–214 | **VERIFIED** | Confirmed via SIAM epubs |
| 8 | `aliprantis2006infinite` | Infinite Dimensional Analysis: A Hitchhiker's Guide | Aliprantis, C.D.; Border, K.C. | 2006 | Springer (3rd ed.) | — | **VERIFIED** | Confirmed via Springer |
| 9 | `border1985fixed` | Fixed Point Theorems with Applications to Economics and Game Theory | Border, Kim C. | 1985 | Cambridge Univ. Press | — | **VERIFIED** (but **NOT CITED** in paper) | Entry exists in sources.bib but no \cite command references it. |
| 10 | `kamenica2011bayesian` | Bayesian Persuasion | Kamenica, E.; Gentzkow, M. | 2011 | Amer. Econ. Rev. | 101(6):2590–2615 | **VERIFIED** | Confirmed via AEA |
| 11 | `crawford1982strategic` | Strategic Information Transmission | Crawford, V.P.; Sobel, J. | 1982 | Econometrica | 50(6):1431–1451 | **VERIFIED** | Confirmed via Econometric Society |
| 12 | `dworczak2022preparing` | Preparing for the Worst but Hoping for the Best: Robust (Bayesian) Persuasion | Dworczak, P.; Pavan, A. | 2022 | Econometrica | 90(5):2017–2051 | **VERIFIED** | Confirmed via Wiley |
| 13 | `lipnowski2022persuasion` | Persuasion via Weak Institutions | Lipnowski, E.; Ravid, D.; Shishkin, D. | 2022 | J. Polit. Econ. | 130:2705–2730 | **VERIFIED** | Confirmed via UChicago Press. Volume is 130(10). |
| 14 | `frankel2014aligned` | Aligned Delegation | Frankel, Alexander | 2014 | Amer. Econ. Rev. | 104(1):66–83 | **VERIFIED** | Confirmed via AEA |
| 15 | `bogachev2007measure` | Measure Theory | Bogachev, Vladimir I. | 2007 | Springer | Vol. 1–2 | **VERIFIED** | Confirmed via Springer |
| 16 | `wagner1977survey` | Survey of Measurable Selection Theorems | Wagner, Daniel H. | 1977 | SIAM J. Control Optim. | 15(5):859–903 | **VERIFIED** | Confirmed via SIAM |
| 17 | `kneser1952minimax` | Sur un théorème fondamental de la théorie des jeux | Kneser, Hellmuth | 1952 | C.R. Acad. Sci. Paris | 234:2418–2420 | **VERIFIED** | Confirmed via bibliographic records |
| 18 | `billingsley1999convergence` | Convergence of Probability Measures | Billingsley, Patrick | 1999 | Wiley (2nd ed.) | — | **VERIFIED** | Confirmed via Wiley |
| 19 | `lean4` | The Lean 4 Theorem Prover and Programming Language | de Moura, L.; Ullrich, S. | 2021 | CADE 2021 / lean-lang.org | — | **VERIFIED** | Confirmed via Springer LNCS 12699 |
| 20 | `mathlib4` | Mathlib4: The Math Library for Lean 4 | Mathlib Community | 2024 | GitHub | — | **VERIFIED** | Confirmed via github.com/leanprover-community/mathlib4 |

**Summary:** 18/20 entries fully verified, 1 entry has a page number discrepancy (kuratowski1965general: 471–478 vs. commonly cited 397–403), 1 entry is unused (border1985fixed is in sources.bib but never \cited in the paper). No fabricated citations. All in-text \cite commands resolve to entries in sources.bib.

### 5. Compilation: 5/5

The PDF exists and was compiled successfully. The LaTeX source is well-structured with appropriate packages, theorem environments, and TikZ figures. No compilation issues detected.

### 6. Writing Quality: 5/5

The paper is written in a clear, professional academic tone appropriate for a top venue. The logical flow is excellent: the paper motivates the problem, states the result, describes the proof strategy, executes the proof in detail, describes the formalization, and discusses implications and limitations. The mathematical exposition is precise and well-organized. The limitation discussion (Section 8.5) is admirably honest about the scope of the formalization and the restrictions to compact Θ.

### 7. Figure Quality: 4/5

- **Figure 1 (proof_architecture):** The TikZ-generated figure in the LaTeX source is clean and well-structured, with appropriate color coding, labels, and arrows. The external PNG version is also of high quality with clear legends and hierarchical layout.
- **Figure 2 (lean_arch):** A clean TikZ diagram showing the module dependency graph.
- No matplotlib-style figures are present (this is a theoretical paper with no numerical experiments), so the figure quality assessment is limited to the architectural diagrams, which are publication-quality.

---

## Critical Technical Assessment

### The Core Mathematical Claim

The paper's main claim — that Theorem 2 extends to infinite M and compact metric Θ under the paper's standing assumptions — is **mathematically correct** in its overall structure. The proof strategy (Sion + Tychonoff + bounded convergence + KRN) is sound. The key insight about finiteness of Ω being the essential feature is genuine and correct.

### The Formalization Gap

The Lean formalization is honest about its scope but the paper could better communicate the following:

1. The `GameSetup` structure axiomatizes the properties that the English proof verifies. The Lean proof verifies the *logical* structure (Sion hypotheses ⟹ saddle point ⟹ optimality + existence) but not the *measure-theoretic* content (strategy spaces satisfy Sion hypotheses).

2. The KRN selection theorem is sorry'd but not actually invoked in the Lean code. It is only needed to justify the axioms at the model level, which is not formalized.

3. The claim "zero sorry in the main theorem file" is technically accurate but should be contextualized: the main theorem file's proof is approximately 10 lines of Lean, because all the hard work is in the axioms of `GameSetup` and the sorry'd `sion_saddle_point`.

### Specific Issues to Address

1. **Lemma 4.4 (Continuity in β):** The argument via marginals λ_ω^{β_n} and the claim that g_σ is bounded should also address whether g_σ is measurable/continuous with respect to m. The direct argument (convergence for each fixed μ, then bounded convergence over τ) is cleaner and avoids this issue.

2. **Page numbers for KRN (1965):** The bib entry lists pages 471–478; the standard bibliographic record is 397–403. Should be corrected.

3. **Unused bib entry:** `border1985fixed` is in sources.bib but never cited.

4. **Lean statement of theorem2_extended:** Part 2 only states U(β*,σ) ≤ U(β*,σ*), which is weaker than the paper's claim about the robust objective. Consider strengthening the Lean statement to match Equation (4) of the paper.

---

## Overall Verdict: **REVISE**

### Justification

The paper presents a correct mathematical result with a sound proof strategy and honest limitations. However, several issues prevent acceptance:

1. **Technical Rigor (3/5):** The continuity-in-β argument (Lemma 4.4) has a gap in the presentation that needs to be addressed (either fix the marginal argument by verifying g_σ continuity, or replace with the direct argument). The Lean formalization axiomatizes rather than constructs the game setup, and this gap between the English proof and the formal verification should be more clearly communicated.

2. **Citation issue:** The KRN page numbers (471–478 vs. 397–403) need correction.

3. **Formalization scope:** The paper should more prominently state that the Lean formalization verifies the logical structure of the proof (Sion ⟹ saddle point ⟹ theorem) but not the measure-theoretic verification of Sion's hypotheses. The current presentation may lead readers to overestimate the scope of formal verification.

### Required Revisions

1. **Fix Lemma 4.4 proof:** Either (a) verify that g_σ(·,ω) is continuous as a function of m (which requires additional argument about the structure of σ under the product topology), or (b) replace the marginal argument with the direct argument: for each fixed μ, ∫_M h(m) β_n(dm|μ) → ∫_M h(m) β(dm|μ) by narrow convergence; then bounded convergence over τ(dμ) gives U(β_n,σ) → U(β,σ). This direct argument only requires h to be bounded and continuous, which g_σ(·,ω) satisfies when σ is fixed.

2. **Correct KRN page numbers** in sources.bib from 471–478 to 397–403 (or add a note acknowledging the discrepancy).

3. **Remove or cite** `border1985fixed` — either add a citation in the text or remove from sources.bib.

4. **Clarify formalization scope:** Add a paragraph in Section 6 explicitly stating: "The Lean formalization verifies the deductive structure of the proof — that Sion's minimax theorem, applied to strategy spaces satisfying the axiomatized properties, yields the extended theorem. The verification that the concrete strategy spaces from the Dworczak-Smolin model satisfy these axioms (Lemmas 4.1–4.4) remains at the level of the English proof."

5. **Strengthen Lean statement (optional but recommended):** The `theorem2_extended` Part 2 currently only states U(β*,σ) ≤ U(β*,σ*). Consider adding the full robust objective inequality, or at minimum the `saddle_point_inequality` result U(β*,σ) ≤ U(β,σ*), which is already proved in the file.

6. **Minor:** In the paper's Lemma 4.3, be more explicit about the σ-algebra on M and the measurability of the integrand g_σ(m,ω) as a function of m.

---

## Scores Summary

| Criterion | Score |
|-----------|-------|
| 1. Completeness | 5/5 |
| 2. Technical Rigor | 3/5 |
| 3. Results Integrity | 4/5 |
| 4. Citation Accuracy | 4/5 |
| 5. Compilation | 5/5 |
| 6. Writing Quality | 5/5 |
| 7. Figure Quality | 4/5 |
| **Overall** | **REVISE** |

**Note:** All scores are ≥ 3 except that Technical Rigor is borderline. The revision requests are specific and actionable. With the fixes above — particularly clarifying the continuity argument and the formalization scope — the paper would merit acceptance. The mathematical result itself is correct and valuable.
