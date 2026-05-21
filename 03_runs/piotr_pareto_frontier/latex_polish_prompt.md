# LaTeX polish — Paper-shaped exposition from v9_consolidated.md

## Role

You are the LaTeX Polisher. The current `v9_consolidated.md`
(durable source) is a 28k-char markdown memo. Turn it into a
**paper-shaped LaTeX exposition** with:

- Standard article preamble (matching the existing `exposition_v9.tex`).
- Numbered theorems, lemmas, propositions, corollaries.
- Clean cross-references.
- Bibliography references in `\cite{}` form (Dworczak-Smolin,
  Clarke 1983, Doval-Smolin 2024, Aumann 1965, etc.).
- Math properly formatted in display equations.
- One section per major result (binary, FBNF, Hall biconditional,
  P*, G4 LP, Phase b).

## Output

A complete LaTeX document, ready to compile. ~25-30 pages.
Structure follows v9_consolidated.md's section ordering but with
paper-style formatting:
- Abstract.
- Introduction (with honest framing paragraph).
- Setting and notation.
- The Pareto-frontier reformulation $\mathcal G_P$.
- Theorem T1 (finite-menu Pareto-Hall via Clarke-Danskin).
- Theorem T2 (α=0 singleton).
- Binary capstone.
- FBNF capstone.
- Hall biconditional + primitive classes + G4 LP.
- Phase (b) verdict.
- Open problems.
- References.

## Output Contract

Inline as a fenced LaTeX block. Use `amsthm` for theorems.
Use the same preamble as the existing `exposition_v9.tex`.

End with: "ready to compile + final paper-shaped exposition for Piotr."
