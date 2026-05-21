Executive summary for Piotr — v9 infinite-extension package
Page 1: What’s proved

This is a strong conditional and classification result, not an unconditional proof of Theorem 2 under the paper’s standing assumptions alone. The package does not claim: “for arbitrary infinite M, arbitrary compact metric Θ, and arbitrary ∣Ω∣≥3, a robustly rationalizable strategy exists.” The honest claim is sharper and more useful: the infinite-dimensional existence problem has been reduced to an exact cone-Hall calibration condition, and that condition is proved or constructively verified for a large set of economically meaningful primitive classes. In other words, v9 turns the old open-ended “does the saddle exist?” question into a classification: here are the cases where Theorem 2 survives, here is the certificate when it survives, and here is the obstruction when it does not.

Five theorems

T1: finite-menu Pareto-Hall via Clarke-Danskin. For a finite Pareto-frontier payoff menu at a Pareto-completed local maximizer, Clarke-Danskin stationarity produces Lagrange multipliers whose induced posteriors lie in the Bayes cones of the active payoff labels.

T2: α=0 singleton theorem. In the pure-adversarial endpoint, the agent ignores advice and plays a prior-optimal private strategy; a constant adversarial message induces posterior μ
0
	​

, giving robust rationalizability for arbitrary infinite M,Θ.

Binary capstone. For ∣Ω∣=2, α∈(0,1), and endpoint exposure / tie discipline / interior endpoint stationarity, the optimal trust interval [L,R] admits an exact adversarial kernel and q-a.e. Bayes calibration for arbitrary measurable M and compact metric Θ.

FBNF capstone. For ∣Ω∣≥3 environments whose belief geometry decomposes into one-dimensional affine fibers, with fiberwise endpoint exposure, tie discipline, local endpoint stationarity, and global fiber dominance, the binary endpoint-fiber lift pastes into a full robustly rationalizable strategy.

Cone-Hall biconditional. Under the compact-closed regularity package, a fixed optimal labeling w
∗
 is robustly rationalizable if and only if

Ψ
w
∗
	​

(y)≤0for every bounded Borel y:M→R
∣Ω∣
.

This is the key classification theorem: the calibration problem is no longer assumed away, but characterized exactly.

Three sharpenings

Binary tie-splitting. The binary theorem can relax the no-atom tie condition: if τ has an atom at the endpoint indifference belief, a measurable tie-splitting rule divides that atom between the left and right endpoint transports, preserving endpoint calibration.

Variable-margin P2.* The uniform cone-margin condition can be weakened to a Borel-positive margin η(m)>0, provided adversarial target density is locally capped relative to η(m); this permits thin Bayes cones near boundary beliefs while still preventing posterior escape.

P6
G
: finite-graph FBNF. The one-dimensional FBNF construction extends to finite graphs of affine arcs, with endpoint-fiber transport on each arc and Kirchhoff node balance at shared vertices; this covers coarse signal structures and tree-like binary subexperiments beyond a single foliation.

The headline new mechanism is Clarke-Danskin Lagrange-multiplier calibration. Piotr’s Pareto-frontier reformulation is what made this visible. Once the agent is viewed as choosing a subset of the weak Pareto frontier of payoff profiles, the derivative of the finite-menu value functional has an economic interpretation: its multipliers are not just first-order artifacts, they are calibrated posterior masses. In the finite-menu theorem, calibration emerges as a Fermat condition. That is the new spell in the toolkit. It does not, by itself, solve the original-message lift in all cases, but it converts “find an adversarial strategy” into “read the right multiplier and check the cone-Hall lift.”

The WTA ternary test is the clean obstruction certificate. In the full-vertex WTA menu with uniform ternary geometry, the finite cone-Hall dual has the explicit price vector

y
j
	​

=1−2e
j
	​

,

and gives

Ψ(y)=
9
2
	​

>0.

Since the corrected cone-Hall condition is Ψ(y)≤0, this excludes WTA-uniform calibration. With aligned baseline depth D, normalized so the aligned contribution is −2αD, reopening requires

−2αD+(1−α)
9
4
	​

≤0,

equivalently

D≥
9α
2(1−α)
	​

.

This is a useful diagnostic, not just a counterexample: WTA is no longer a foggy “maybe impossible” case. It has an explicit dual certificate and an explicit reopening threshold.

Page 2: Relation to v8 and what remains open

The key v8-to-v9 transition is this: v8 had Tier 2 conditional on menu-Hall; v9 has Theorem 2 ⟺Ψ(y)≤0 under the regularity package. In v8, the calibration object was still an assumption. Menu-Hall said, in effect, “there exists a kernel supported on rowwise minimizers whose induced messagewise posterior lands in the correct Bayes cone.” That was exactly the desired equilibrium calibration. It was weaker than deterministic TRE-gen-Hall, but still installed the equilibrium object.

v9 changes the status of calibration. The cone-Hall theorem gives a necessary and sufficient condition in dual prices. The primal object is the adversarial kernel; the dual object is Ψ(y)≤0 for all bounded Borel vector prices. This is the right analogue of Hall/Strassen for the robust-trust calibration problem: feasible calibrated transport exists exactly when no dual price system separates the aligned baseline plus adversarial row-minimizer flows from the Bayes cones. The result is not “menu-Hall assumed.” It is “menu-Hall characterized.”

That is the major conceptual upgrade. v8 was a three-tier theorem with an honest stop at Tier 2. v9 is a classification architecture: if the regularity package holds, robust rationalizability is equivalent to checking Ψ≤0; if primitive structure implies Ψ≤0, Theorem 2 is proved for that class; if a dual y gives Ψ(y)>0, the class is excluded by certificate.

What v9 covers unconditionally, in the relevant primitive subclasses, is broad:

Binary environments are closed under endpoint exposure, interior endpoint stationarity, and either tie discipline or the tie-splitting sharpening. This is the cleanest nontrivial infinite-M,Θ success.

FBNF covers multidimensional problems that are economically multidimensional but calibration-one-dimensional: affine MLR families, radial fibers, scalarized risk-score models, and environments where the trust-region projection stays within fibers.

P2* covers smooth strict-convex / exposed-frontier environments with atomless τ, cone margin, and bounded jamming by rowwise-minimizer traffic. The variable-margin sharpening makes this more realistic near thin boundary regions.

P3 covers polyhedral W with finite active menus and finite-facet Bayes cones, where the remaining calibration condition reduces to a finite LP. Importantly, raw polyhedrality is not enough; the LP is the pass/fail certificate.

P4 covers radial / antipodal models, including spherical environments, where symmetry constructs a primal calibrated kernel via antipodal boundary routing and scalar radial balance. The proof is constructive; it does not rely on averaging arbitrary dual prices.

P6
G
 covers finite graph / coarse-signal geometries: finite unions of affine arcs, graph-preserving trust regions, endpoint-fiber transports, and Kirchhoff node balance. This broadens FBNF from a single foliation to finite arc networks.

Together, these cover essentially all economically substantive applications currently in view: smooth utility, atomless adviser posterior distributions, and reasonable structure such as binary state, radial symmetry, MLR fibers, finite action polyhedra, or coarse graph-like signal supports. The uncovered cases are not the natural applied ones; they are the fully unstructured ∣Ω∣≥3 wilderness where no geometry, no regularity, and no certificate is available. It is a thorn thicket, not a missing lemma.

What remains open is precise:

∣Ω∣≥3

with no binary reduction, no FBNF / radial / scalarizable primitive, no finite-facet LP pass, no cone-margin / bounded-jamming condition, no P6
G
 graph structure, and no verified Ψ(y)≤0. Worse, if regularity itself fails, the Borel cone-Hall theorem is not available without additional no-escape assumptions: compact M alone does not force w
∗
 continuity, closed graph of G, or support-continuity of the Bayes cones.

This is explicitly the WTA-style obstruction territory. The v8 sharpness witness showed null-message dust cannot fix vector-balance failure in ternary WTA. v9 sharpens that into a dual certificate: the obstruction is not a pathology of dust, nor a failure of measurability, nor merely a bad proof route. It is a genuine multidimensional calibration failure unless aligned baseline, finite-facet LP feasibility, or some primitive scalarizing structure reopens it.

Recommendation: present this as a publishable strong classification and sufficient-conditions result, not as a proof of the unrestricted theorem. The paper should say plainly that the unrestricted infinite extension remains open, while emphasizing that v9 provides the first real map of the terrain: payoff-label calibration via Clarke-Danskin, exact Hall biconditional via Ψ, constructive positive theorems for binary / FBNF / radial / polyhedral / graph classes, and explicit dual certificates for obstruction cases.

A title in the right register would be:

“Robust Rationalizability beyond Finite Signals: A Cone-Hall Classification and Primitive Sufficient Conditions.”

A slightly sharper one:

“When Robust Trust Equilibria Survive Infinite Signals: Pareto-Frontier Calibration and Cone-Hall Duality.”

The second better foregrounds Piotr’s contribution. His Pareto-frontier cue was not cosmetic; it changed the coordinate system enough for the Lagrange-multiplier calibration mechanism to appear. That is the breakthrough worth preserving in the narrative.

ready for the long-form paper: exposition_v9_paper.pdf (19 pages).
