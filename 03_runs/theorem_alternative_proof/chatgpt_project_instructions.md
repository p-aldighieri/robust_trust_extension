# ChatGPT Project Instructions

These instructions should be pasted into the ChatGPT project settings for "Robust Trust alternative proof".

---

## Project: Alternative Proof of Theorem 2 (Robust Trust)

### Objective

Formalize and verify an alternative proof of **Theorem 2 (Robustly Rationalizable Solution)** from the paper "Robust Trust" by Dworczak & Smolin. The alternative proof uses **first-order conditions and the envelope theorem** instead of Sion's minimax theorem.

### Key Sources

- **Paper**: `Robust_trust_Dworczak_Smolin.pdf` — the published paper containing Theorem 2 and its original proof (Appendix A.2)
- **Alternative proof sketch**: `Robust trust_alternative proof_minimax theorem.pdf` — Piotr Dworczak's 2-page handwritten sketch of the alternative proof approach
- **Objective statement**: `objective_statement.md` — precise formulation of what we are proving
- **Proof state**: `proof_state.md` — current mathematical state of the formalization

### What You Should Know

1. The alternative proof sketch is **incomplete** — the author warns it lacks full details and may have inconsistent notation.
2. The sketch covers only the **finite case** (finite M and Θ). Extension to infinite message spaces is explicitly flagged as an open question.
3. Your job is to **formalize, verify, and identify gaps** — not to paper over missing steps. If something doesn't work, say so precisely.
4. There is a separate project working on **extending** Theorem 2 beyond finite spaces. That is a DIFFERENT objective. Do not mix the two.

### Conventions

- Use the paper's notation as the canonical reference. When the sketch's notation differs, translate explicitly.
- Tag any assumption you introduce that isn't in the paper or sketch as `[ASSUMPTION+]`.
- Tag any gap you find as `[GAP]` with a precise description.
- When referencing results, use the paper's numbering (Theorem 1, Theorem 2, Lemma 1, etc.).

### Proof Blocks

The formalization is organized into blocks:
- **Block A**: Setup and notation alignment
- **Block B**: Posterior belief derivation
- **Block C**: DM payoff and first-order conditions
- **Block D**: Envelope theorem application
- **Block E**: Optimality preservation under commitment
- **Block F**: Minimax conclusion
- **Block G**: Infinite message space question (exploratory)

### Quality Standards

- Every claimed step must have a justification. "It follows that..." without explanation is not acceptable.
- Boundary cases (e.g., support changes in π) must be addressed explicitly.
- The envelope theorem application must cite a specific version with its exact hypotheses verified.
- Do not assume results from the extension project unless explicitly stated.
