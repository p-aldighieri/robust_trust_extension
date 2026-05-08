PASS

The diagnosis is correct.

## 1. Ambient normalization is only a formulation prerequisite

If the witness objects live in varying spaces, or are only defined up to changing normalizations, then any convergence sentence for `j \mapsto K_j` is not yet well-posed. So a common ambient witness space, or an explicit normalization embedding every `K_j` into one fixed space, is indeed a prerequisite for even stating a convergence-based recurrence lemma.

But that is only a setup issue. Once such an ambient space is granted, the branch still has to prove an actual recurrence statement. So this is not the first substantive obstruction.

## 2. The deeper gap is exactly the limsup-to-fiber upgrade

Even after putting all `K_j` into one common space, the statement

`kappa in ⋂_N closure(⋃_{j >= N} K_j)`

only says that every neighborhood of `kappa` meets infinitely many tail unions. In sequential language, it gives at best a subsequence `j_n -> infinity` and points `kappa_{j_n} in K_{j_n}` with `kappa_{j_n} -> kappa`.

That is strictly weaker than exact recurring membership:

`kappa in K_j` for infinitely many `j`.

The latter requires the same point `kappa` to belong to infinitely many varying fibers. The former only gives approximants lying in those fibers. Without more structure, approximation by points from `K_j` does not force exact membership of the limit point in those same `K_j`.

So the prover's claim is right: tail-limsup or closure-of-tail-unions membership does not by itself yield exact recurring fiber membership.

## 3. Why the exhausted generic routes do not bridge this

The already-exhausted generic tail-stability / closedness route does not repair this gap.

Closedness of each individual `K_j` only helps if one already has a sequence lying in one fixed fiber `K_j` and converging to `kappa`. Here the approximants lie in different fibers `K_{j_n}`, so individual closedness does not transfer across `j`.

Likewise, generic limsup language only certifies repeated approximation from the family `{K_j}`, not repeated exact membership in the specific fibers. That is precisely the distinction the current diagnosis is drawing, and it is the right one.

## 4. What the missing ingredient would have to look like

The missing ingredient is indeed an upgrade lemma of the form

`kappa in ⋂_N closure(⋃_{j >= N} K_j) => kappa in K_j for infinitely many j`

or an equivalent principle specialized to the concrete witness construction `j \mapsto K_j`.

Without smuggling assumptions, the only ways such an upgrade could work are via additional structure on the concrete `K_j`, for example:

- a closed-graph principle that converts convergence of nearby witnesses into exact same-fiber membership
- a nesting or tail-hereditary property of the fibers
- a finite-coordinate or stabilization rule showing that eventual approximation forces the limit witness itself to satisfy the defining constraints of infinitely many `K_j`
- a canonicalization map sending nearby witnesses in `K_j` to the same normalized `kappa` while staying inside `K_j`

Absent one of those concrete mechanisms, the recurrence hinge does not go through.

## Bottom line

The sharp distinction is:

- ambient normalization: necessary to state convergence or tail-limsup membership
- exact recurrence upgrade: the first real mathematical gap

The latest prover's diagnosis gets that distinction right.

Suggested next local action: isolate the exact definition of the concrete fibers `K_j` and test, line by line, whether their membership constraints are tail-hereditary or finitely checkable in a way that could prove the missing upgrade lemma.
