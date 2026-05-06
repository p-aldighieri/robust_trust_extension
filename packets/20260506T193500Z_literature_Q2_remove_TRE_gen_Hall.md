# Literature pass — Q2: Removing (TRE-gen-Hall) for $|\Omega|\ge 3$

You are the Literature Searcher for the soft-scaffolding workflow.

## Goal

Survey the online mathematical and economic literature for results
bearing on **Q2**:

> Under standing + (A5-thick) + (A8c-attain), can the calibrated
> worst-message transport condition (TRE-gen-Hall) be **derived** from
> primitive structural conditions on the Robust-Trust model for
> general finite $|\Omega|\ge 3$? Equivalently: does the paper's
> trust-region characterization (Theorem 1) extend to infinite $M$ in
> a way that forces a Hall-feasible vector mass-balance?

## Inputs

- `theorem_2_extension_proof_v4.md`, `phil_reny_route_memo.md`,
  `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF.
- Q2 formalizer:
  `logs/20260506T192000Z_thin_formalizer_Q2_remove_TRE_gen_Hall_response.md`.

## Search angles

1. **Paper's own Theorem 1 (Trust Region Solution).** Section 3.2,
   proof Appendix A.1. Does the proof technique extend to infinite $M$?
   What's the obstruction? Is there a follow-up paper or a working
   paper extension?
2. **Multi-dimensional optimal transport.**
   - **Brenier theorem** (1991) and successors: existence of OT maps
     under quadratic cost in $\mathbb R^d$.
   - **Knothe-Rosenblatt** rearrangement: explicit OT map via
     iterated 1-D quantile transports.
   - **McCann-Gangbo** for general costs.
   - **Villani** *Optimal Transport: Old and New* (2008).
   - **Santambrogio** *Optimal Transport for Applied Mathematicians* (2015).
   Question: do these give multi-dim Hall feasibility under standard
   regularity (atomless, full-support source measure)?
3. **Strassen-type feasibility for posterior-constrained couplings.**
   - **Strassen (1965)**: classical theorem on feasibility of
     couplings with marginal and ordering constraints.
   - **Kellerer (1984)**: order-preserving couplings.
   - **Beiglböck-Henry-Labordère-Penkner** martingale OT.
   - Specifically: when does a coupling exist with prescribed
     posterior-set membership constraints?
4. **Bayesian persuasion / information design with multidim states.**
   - **Mathevet-Pearce-Stacchetti** (2020+).
   - **Doval-Skreta** on persuasion design.
   - **Salem-Pavan** continuous-state extensions.
   - **Lipnowski-Ravid-Shishkin** trust-region structure.
   Question: does any of these have a multidim TRE characterization
   that subsumes (TRE-gen-Hall)?
5. **Multi-dim cheap-talk / mediation.**
   - **Crawford-Sobel** finite-state baseline.
   - Recent multi-dim cheap talk extensions (continuous state).
   Question: do they have a multidim TRE structure?
6. **Robust persuasion / stress-testing.**
   - **Dworczak-Pavan** 2022 robust persuasion.
   - **Kosterina** (2022 or recent) robustness in persuasion.
   - **Hu-Weinberg** etc.
   Question: do they have multi-dim Hall/transport feasibility results?
7. **Recent (2022+) infinite-state Bayesian persuasion attainment.**
   arXiv search.
8. **Vector mass-balance / Hall-type theorems.**
   - **König-Hall** marriage theorem (vector / continuous version).
   - Generalizations to vector measures.

## What you must produce

Standard literature-pass output. Crisp prioritization:

- For each relevant source, identify the EXACT result and whether it
  helps Q2.
- Assess: is Q2 (a) plausibly closeable via a known theorem, (b)
  provably open, (c) covered by a counterexample, (d) suggesting
  (TRE-gen-Hall) is essential and cannot be derived?
- Identify the strongest reusable lemma or proof technique.
- Recommend the next pipeline step.

## Output Format

(Standard literature-pass format — see `prompts/soft/02_literature_soft.md`.)

## Discipline

- Cite each source with author/year/venue/URL.
- Honest assessment.
- Length budget: 2000–3000 words. Q2 covers a wider literature than Q1.
