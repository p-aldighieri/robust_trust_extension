On the trusted record currently attached, I do not see the explicit set-valued definition of the concrete witness map `j \mapsto K_j`, so I cannot honestly manufacture hidden rigidity from it. Under the properties that are actually on the record, the recurrence lemma is still not derivable.

## 1. Mere ambient-normalization prerequisite

There is a purely formal prerequisite: all `K_j` must live in a common ambient space `X` where it makes sense to say `\kappa_n \to \kappa`. For this branch, that means some common metrizable sequential compactness or equivalent normalization/tightness. Without that, the statement of the lemma is not even well-formed.

But once such an `X` is fixed, that only gives the weak topological conclusion

`\kappa \in \bigcap_{N \ge 1} \overline{\bigcup_{j \ge N} K_j}.`

Indeed, if `j_n` are distinct and `\kappa_n \in K_{j_n}` with `\kappa_n \to \kappa`, then for every `N` infinitely many `j_n` lie in the tail `{j \ge N}`, so infinitely many `\kappa_n` lie in `\bigcup_{j \ge N} K_j`, and their limit is `\kappa`.

That is only a formulation-level fact. It does not give the exact recurrence you need.

## 2. First exact substantive failure

The proof fails at the next sharpening step, namely when one tries to pass from

`\kappa \in \bigcap_{N \ge 1} \overline{\bigcup_{j \ge N} K_j}`

to

`\kappa \in K_{j_n}` for infinitely many `n`,

or to any equivalent exact admissibility-on-a-tail statement.

That implication is the substantive hinge, and it is exactly where the argument stops.

The reason is simple and structural. Everything currently available is fiberwise: it tells you things about a fixed `K_j`. Closedness of `K_j`, admissibility of `K_j`, compactness of the ambient class, diagonal extraction, generic tail-union closure, all of these only help when a subsequence stays in one fixed fiber or when one is content with membership in a closure of unions. Here the indices `j_n` are distinct, so no single fiber repeats. The force of each membership statement

`\kappa_n \in K_{j_n}`

is spent on a moving coordinate, once, and ordinary convergence does not recycle that into exact membership of the limit in infinitely many original fibers.

So the obstruction is not that convergence is missing. Even after normalization, you only get topological tail-limsup membership. What is missing is a genuine cross-coordinate stability principle for the set-valued map `j \mapsto K_j`, for example some derived rule of the form

`j_n` distinct, `\kappa_n \in K_{j_n}`, `\kappa_n \to \kappa` implies `\kappa \in K_{j_n}` for infinitely many `n`,

or an equivalent theorem converting tail-limsup closure into exact recurring fiber membership.

Nothing in ordinary compactness, closedness, or generic tail-stability gives that upgrade. So this is a deeper substantive recurrence obstruction, not a mere ambient-normalization issue.

This is also exactly the kind of bottleneck the current branch notes are already circling in proof state, exact-route memo, and atomic memo.

Suggested next local action: write `j \mapsto K_j` explicitly as a set-valued map in one common ambient space and isolate the single missing upgrade lemma `\kappa \in \bigcap_N \overline{\bigcup_{j \ge N} K_j} \Rightarrow \kappa \in K_j` for infinitely many `j`; then test only whether the concrete defining constraints of `K_j` imply that upgrade via a closed-graph, nesting, or tail-hereditary property.
