I’m reading the target note, the three supporting notes, and the durable proof-state together, focusing narrowly on whether the countable-atomic direct/U-side branch already forces a tail-stability or closedness upgrade.I’ve narrowed it to the exact limit-step obstruction: the current U-side local or approximate witnesses still do not supply a common ambient witness space with closed membership, so a convergent subsequence yields only limsup-style compatibility, not an exact witness surviving along an infinite tail.On the current banked record, the tail-stability / closedness backup lemma is not derivable. The U-side notes bank only coordinatewise witness availability Kj≠∅K_j\neq\varnothingKj​=∅ and explicitly reject both the direct infinite-common-fiber extraction and the quotient-level finite-label collapse; they also state that compactness by itself is too weak for this backup.   
The first exact obstruction is this: even if one grants the friendliest missing normalization step and extracts a convergent subsequence of local witnesses
jn∈U,κn∈Kjn,κn→κ,j_n\in U,\qquad \kappa_n\in K_{j_n},\qquad \kappa_n\to\kappa,jn​∈U,κn​∈Kjn​​,κn​→κ,
ordinary closedness of the fibers KjK_jKj​ does not imply
κ∈Kjnfor infinitely many n.\kappa\in K_{j_n}\quad\text{for infinitely many }n.κ∈Kjn​​for infinitely many n.
Closedness of a single fiber is a same-coordinate statement:
ηm∈Kj ∀m, ηm→η  ⟹  η∈Kj.\eta_m\in K_j\ \forall m,\ \eta_m\to\eta \;\Longrightarrow\; \eta\in K_j.ηm​∈Kj​ ∀m, ηm​→η⟹η∈Kj​.
But in the tail problem the index varies with mmm. If the coordinates jnj_njn​ are all distinct, then no fixed fiber KjK_jKj​ is visited more than once, so this closedness statement never fires.
What subsequential compactness gives is only a cluster point of nearby fibers:
κ∈⋂N≥1⋃n≥NKjn‾.\kappa\in \bigcap_{N\ge 1}\overline{\bigcup_{n\ge N}K_{j_n}}.κ∈N≥1⋂​n≥N⋃​Kjn​​​.
What the branch needs is an exact recurrent fiber point:
κ∈Kjnfor infinitely many n.\kappa\in K_{j_n}\quad\text{for infinitely many }n.κ∈Kjn​​for infinitely many n.
Those are different notions. Compactness controls the first. The proof needs the second.
A toy family already shows the gap. Let
Kn={1/n}⊂[0,1],κn=1/n∈Kn.K_n=\{1/n\}\subset [0,1],\qquad \kappa_n=1/n\in K_n.Kn​={1/n}⊂[0,1],κn​=1/n∈Kn​.
Then κn→0\kappa_n\to 0κn​→0, so 000 is a cluster point of the family (Kn)(K_n)(Kn​). But 0∉Kn0\notin K_n0∈/Kn​ for every nnn. Thus even in a compact ambient space, with each KnK_nKn​ closed, convergence of selected witnesses does not produce one witness that remains exactly admissible on an infinite tail. So the desired upgrade is not a routine sequential-closedness argument; it needs a stronger recurrence principle.
So the first exact missing ingredient is a genuine tail-membership lemma for the set-valued map j↦Kjj\mapsto K_jj↦Kj​, not mere compactness of a witness space.
Needed assumption: a fixed normalized witness space XXX in which all local witness classes KjK_jKj​ live, so that one can even formulate subsequential convergence.
Needed assumption: a tail-membership closedness principle of the form
jn distinct, κn∈Kjn, κn→κ⟹κ∈Kjn for infinitely many nj_n\ \text{distinct},\ \kappa_n\in K_{j_n},\ \kappa_n\to\kappa
\quad\Longrightarrow\quad
\kappa\in K_{j_n}\ \text{for infinitely many }njn​ distinct, κn​∈Kjn​​, κn​→κ⟹κ∈Kjn​​ for infinitely many n
or any equivalent exact-admissibility conclusion on an infinite tail.
If the construction only works modulo a compatibility relation ∼\sim∼, there is also a further requirement:
Needed assumption: ∼\sim∼ is sequentially closed on the normalized witness space.
But that is second-order. The route already fails earlier, at exact membership in infinitely many varying fibers KjK_jKj​.
This diagnosis is fully consistent with the other banked notes. The finite-label route is exhausted; compact-convex payoff geometry WWW does not secretly force finite active types or a finite compatibility quotient; and the durable proof state still lists removal of finiteness of MMM as the open target, with finite-MMM, compact-metric-Θ\ThetaΘ as the current best trusted theorem.   
Therefore the tail-stability / closedness backup lemma is not proved on the current record. The first exact reason is: a limit of witnesses chosen from varying coordinates only yields a cluster point of the family (Kj)(K_j)(Kj​), whereas the branch needs a point lying in infinitely many exact fibers. No banked lemma bridges that gap.
Suggested next local action: formalize the precise tail-membership statement needed for j↦Kjj\mapsto K_jj↦Kj​ and test it directly on the present witness construction; if that statement cannot be derived, bank the tail-stability / closedness backup as non-derivable on the current branch.
