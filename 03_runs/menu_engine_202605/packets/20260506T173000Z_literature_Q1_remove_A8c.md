# Literature pass — Q1: Removing (A8c-attain) for Branch B Tier 1

You are the Literature Searcher for the soft-scaffolding workflow.

## Goal

Survey the online mathematical literature for results bearing on **Q1**:

> Under standing hypotheses + (A5-thick), is the infimum
> $\inf_{\beta\in B} U(\beta,\sigma^*) = U^*$ **attained** in the
> unrestricted measurable-kernel space $B$, where $B$ = Borel kernels
> $M\to\Delta(M)$ on a compact metric message space, when the rowwise
> argmin correspondence $D(s) = \arg\min_m \ell(m,s)$ may be empty on
> a positive-τ set of $s$?

The question is **attainment of an infimum over a Borel-kernel space**
where the natural rowwise selector doesn't exist. Phrased generically:
when does an inf over a function space of Markov kernels admit an
attaining kernel without pointwise rowwise selectability?

## Inputs

- `theorem_2_extension_proof_v4.md`, `phil_reny_route_memo.md`,
  `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF.
- Q1 formalizer:
  `logs/20260506T170000Z_thin_formalizer_Q1_remove_A8c_response.md`.

## Search angles (use as starting points)

1. **Stable transition probabilities and Young measures.** Balder
   (1988), and successors: Valadier, Castaing-Valadier, Pedregal,
   Roubíček. Are there general attainment theorems for inf over stable
   kernels when the integrand fails to attain a pointwise rowwise
   minimum?
2. **Optimal transport with non-l.s.c. cost.** Villani; Santambrogio.
   Under which conditions does the OT minimum over couplings exist
   when the cost is not l.s.c.? Strassen-type theorems for couplings.
3. **Mertens-Sorin-Zamir-style minimax under minimal regularity.**
   "Game Theory" (Mertens–Sorin–Zamir, 2015) Chapter on minmax. Variants
   of the Mertens 1986 theorem with attainment statements.
4. **Aumann-style measurable selection without compactness.**
   Kuratowski–Ryll-Nardzewski variants; Bogachev §6.10. Is there a
   selection theorem that produces a measurable selector when the
   pointwise correspondence is empty on a measurable set?
5. **Choquet capacity / inner regularity attainment.** Capacitability
   theorems (Choquet, Sion, Dellacherie). Could the inf-attainment
   question be recast as a capacity / analytic-set question?
6. **Robust persuasion / cheap talk attainment.** Dworczak-Pavan
   2022, Lipnowski-Ravid-Shishkin 2022. Specifically the
   attainment-of-adversary-strategy step in their robust persuasion
   constructions.
7. **Information design / Kamenica-Gentzkow extensions to infinite
   spaces.** Kolotilin 2018, Doval-Skreta, Bergemann-Morris,
   Mathevet-Pearce-Stacchetti. Do any of these establish
   minimax-strategy attainment in infinite-dimensional settings without
   requiring continuity / l.s.c.?
8. **Recent (post-2020) papers on infinite-dimensional cheap-talk
   / persuasion attainment.** arXiv search on relevant keywords.

## What you must produce

Standard literature-pass output, but with **crisp prioritization**:

- For each relevant source, identify the EXACT result and whether it
  applies directly to Q1.
- Assess: is Q1 (a) already proved positively in the literature,
  (b) already disproved, (c) plausibly open, or (d) covered by a
  counterexample suggesting it's open or false?
- Identify the strongest reusable lemma or proof technique.
- Recommend the next pipeline step: prover (if a clean proof template
  exists), counterexample hunter (if obstruction is plausible), or
  breakdown (if the territory is open and needs route ranking).

## Output Format

(Standard literature-pass format — see `prompts/soft/02_literature_soft.md`.)

## Discipline

- Cite each source with author/year/venue/URL.
- Honest assessment: don't oversell partial results.
- Length budget: 1500–2500 words.
- This is a **literature pass**, not a proof. Do NOT prove anything.
