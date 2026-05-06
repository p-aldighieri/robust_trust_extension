
========
ROLE: user (id=d2177999-da68-483e-9da8-8018e56f567a)
========
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

- theorem_2_extension_proof_v4.md, phil_reny_route_memo.md,
  phil_reny_bundle.md, prior_attempts_digest.md, paper PDF.
- Q1 formalizer:
  logs/20260506T170000Z_thin_formalizer_Q1_remove_A8c_response.md.

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

(Standard literature-pass format — see prompts/soft/02_literature_soft.md.)

## Discipline

- Cite each source with author/year/venue/URL.
- Honest assessment: don't oversell partial results.
- Length budget: 1500–2500 words.
- This is a **literature pass**, not a proof. Do NOT prove anything.

Show more

========
ROLE: assistant (id=241dab60-402b-4513-a2fd-509569c83446)
========
Literature pass — Q1: removing (A8c-attain)

Scope note. The referenced Q1 formalizer log was not present among the accessible uploaded files. I used the route memo, prior-attempts digest, final consolidator, Phil Reny bundle, objective statement, and the paper PDF.

Executive verdict

Q1 should be classified as (d): covered by a standard obstruction/counterexample class, and effectively false for Tier 1 as stated. I did not find an online theorem proving positive attainment of the full Borel-kernel infimum when D(s)=argmin
m
	​

ℓ(m,s) is empty on a positive-τ set. The opposite is what the measurable-selection, normal-integrand, dynamic-programming, and non-l.s.c. optimal-transport literatures all whisper in the same gravelly voice: exact minimizers require exact rowwise contact. Approximation is cheap; attainment is the dragon’s tooth.

The strongest reusable statement is:

For a rowwise-separable kernel objective, exact minimization over Borel kernels requires a measurable kernel supported on the rowwise minimizer set, {m:ℓ(m,s)=inf
m
′
	​

ℓ(m
′
,s)}, for τ-a.e. s. If that set is empty on positive τ-measure, randomization cannot create an exact minimizer.

This is exactly why the final consolidator keeps (A8c-attain) for Tier 1: it is not merely a proof convenience, it is the row-contact condition consumed by L8. The same project note explicitly records the upward-spike/nonattainment obstruction g(m)=m on (0,1], g(0)=1, and says some argmin-attainment condition is necessary for the adversary β
∗
 step. 

theorem_2_extension_proof_v4

Priority-ranked source survey
1. Rockafellar and Wets, 1998, Variational Analysis, Springer

Exact result. Theorem 14.37, “measurability of optimal values and solutions,” states that for a normal integrand f(t,x), p(t)=inf
x
	​

f(t,x) is measurable and P(t)=argmin
x
	​

f(t,x) is closed-valued and measurable; on the set where P(t)

=∅, a measurable minimizer can be selected. The surrounding material stresses normal integrands, l.s.c. in the decision variable, measurable level-set maps, and decomposable spaces as the framework for interchanging minimization and integration. 
Math at Washington
+1

Application to Q1. Directly relevant, but negative for removing (A8c-attain). It gives a clean positive theorem when row minimizers exist, and it also makes visible the missing ingredient when D(s)=∅. It does not conjure minimizers out of empty sets.

Reusable technique. Normal-integrand reduction: prove ℓ is a normal integrand, get measurable value and argmin correspondence, then apply measurable selection. This is exactly an (A8c-lsc) or (A8c-attain) route, not a route around it.

2. Kuratowski–Ryll-Nardzewski, Aumann, Jankov–von Neumann, Bogachev, 2007, Measure Theory II

Exact result. Bogachev states the classical Souslin/Jankov-style selection theorem for multifunctions with nonempty sections and the Borel selection theorem for complete separable target spaces with nonempty closed values and weak measurability. 
NoZDR

Application to Q1. Directly relevant, again negative. KRN/Aumann solve measurability once nonemptiness is in the bag. Jankov–von Neumann can select from analytic near-minimizer sets, which supports ε-optimal kernels and value identities, but exact selection collapses if D(s) is empty on a positive-measure set. The route memo already has this split: half 1, pointwise inf equals essential inf, is accessible by JvN plus density; half 2, rowwise attainment, fails without extra assumptions. 

phil_reny_route_memo

Reusable technique. Use JvN for near-minimizers, KRN for exact minimizers. This gives the right bifurcation: value yes, exact adversary no.

3. Bertsekas and Shreve, 1978/1996, Stochastic Optimal Control: The Discrete-Time Case

Exact result. This is the standard Borel-space dynamic-programming toolkit. Bertsekas describes the framework as built around Borel spaces, lower semianalytic functions, and universally measurable policies. 
Massachusetts Institute of Technology

Application to Q1. Highly relevant by analogy. In Borel dynamic programming, universally measurable ε-optimal policies are often available under analytic/lower-semi-analytic hypotheses. Exact optimal policies require a minimizer at the relevant state. That is the same beast wearing a stochastic-control hat.

Reusable technique. Formulate the adversary row problem as a one-stage Borel control problem. The literature supports approximate selectors without (A8c-attain), not exact Tier 1 attainment.

4. Balder, 1988, “Generalized Equilibrium Results for Games with Incomplete Information,” Mathematics of Operations Research

Exact result. Balder develops weak convergence of transition probabilities and applies it to behavioral strategies in games with incomplete information; the abstract notes that the paper recapitulates weak convergence theory for transition probabilities and includes product transition probabilities. 
PubsOnLine

Application to Q1. Crucial for Branch A, not for Q1. Balder is the right hammer for compactness/continuity on the agent side and the restricted τ-dominated game. The Phil route explicitly uses Balder and Mertens to obtain an optimal player-1 strategy, while Phil flags that this does not produce player-2/adversary attainment. 

phil_reny_bundle

Reusable technique. Stable kernels/Young-measure compactness for value-securing existence. But stable convergence can relax the problem; it does not force a Borel kernel to attain a rowwise infimum absent a row minimizer.

5. Beiglböck, Goldstern, Maresch, and Schachermayer, 2009, “Optimal and Better Transport Plans,” Journal of Functional Analysis; Beiglböck and Schachermayer, 2011, “Duality for Borel Measurable Cost Functions,” Transactions AMS

Exact results. The 2009 paper studies Monge–Kantorovich transport with Borel costs and explicitly notes that, without proper continuity assumptions, optimal transport plans need not exist. 
Faculty of Mathematics
 The 2011 paper gives a sharp toy example: X=Y=[0,1], Lebesgue marginals, c(x,y)=(x−y)
2
 off the diagonal and c(x,x)=1; costs can be arbitrarily small, but the infimum 0 is not attained. 
Faculty of Mathematics
 Santambrogio’s textbook gives the standard positive theorem: for Polish/compact metric spaces, lower semicontinuity and bounded-below cost give existence of a Kantorovich optimizer. 
Math University Lyon 1

Application to Q1. Not identical, because Q1 has free conditional kernels rather than fixed two-marginal couplings, but the lesson is direct: l.s.c. is the compactness glue. Without it, minimizing sequences can “fall toward” a nonattained contact set. Q1 is easier than OT in one sense, because the rows decouple; that makes the nonattainment obstruction even sharper.

Reusable technique. Use the OT counterexample style to build a compact-message non-l.s.c. row payoff with value approached but not attained.

6. Mertens, 1986, “The Minmax Theorem for U.S.C.-L.S.C. Payoff Functions,” International Journal of Game Theory; Mertens–Sorin–Zamir, 2015, Repeated Games

Exact result. Mertens’s paper is the asymmetric minmax tool used in the route; it is the 1986 IJGT article on u.s.c.–l.s.c. payoff functions. 
Springer Link
 Mertens–Sorin–Zamir is a broad repeated-games reference, presented by Cambridge as a major general treatment of game-theoretic results. 
Cambridge University Press & Assessment

Application to Q1. Useful for value equalities, not exact adversary kernels. The project’s prior attempts already found the “Sion/Tychonoff compactness” strategy structurally blocked by continuity-in-β and escape-of-mass problems. 

prior_attempts_digest

 Mertens does not remove the need for a row-contact kernel.

Reusable technique. Keep Mertens for Branch A. Do not use it as a cloak for adversary-side attainment.

7. Robust persuasion, information design, and cheap talk

Exact results. Dworczak–Pavan (2022, Econometrica) study robust Bayesian persuasion where Nature chooses worst-case information/coordination; the paper characterizes robust solutions in that setting. 
IDEAS/RePEc
 Lipnowski–Ravid–Shishkin (2022, JPE) characterize persuasion through weak institutions via concavification of a capped value function. 
IDEAS/RePEc
 Bergemann–Morris (2016, Theoretical Economics) characterize Bayes correlated equilibrium outcomes and information-structure comparisons. 
Econ Theory
 Kolotilin (2018, Theoretical Economics) uses a linear-programming approach to optimal disclosure. 
UNSW Sites

Application to Q1. These works are valuable background, but I found no theorem there proving exact Borel-kernel adversary attainment under non-l.s.c. row payoffs or empty row argmins. They tend to work in finite-dimensional, concavification/LP, compact-continuous, or otherwise regularized environments. Robust Trust itself states Theorem 2 existence only for finite M,Θ, and says the finite assumption is technical because verifying Sion’s continuity requirements is difficult in infinite cheap-talk-like strategy spaces. 
arXiv

Recent post-2020 check. Recent cheap-talk/persuasion papers such as Lyu–Suen’s “Information Design in Cheap Talk” and Kreutzkamp–Lou’s “Persuasion without ex-post commitment” are thematically nearby, but the online descriptions do not contain a Borel-kernel exact-attainment theorem for Q1’s non-l.s.c./empty-argmin problem. 
arXiv
+1

8. Choquet capacity and analytic-set machinery

Exact result. El Karoui–Tan (2013) present capacity theory as a route to measurable selection and dynamic programming, following Dellacherie. 
arXiv

Application to Q1. Helpful for measurability of projections and approximate selectors. It does not override empty sections. Capacity theory can certify analytic measurability of “near-contact” sets; it cannot make D(s) nonempty.

Assessment against the requested categories

(a) Already proved positively? No. I found no positive theorem that exact minimization over unrestricted Borel kernels is attained when rowwise minima are absent on a positive-τ set.

(b) Already disproved? Not under the name “Robust Trust Q1,” but yes in the relevant mathematical sense: standard non-l.s.c. counterexamples and integral-functional selection theory cover the obstruction.

(c) Plausibly open? Not as stated. A subtler open question is whether the Robust Trust primitives secretly prevent empty D(s) for the σ
∗
 produced by Branch A. The internal notes say they do not under standing plus (A5)-type hypotheses alone. 

phil_reny_route_memo

(d) Covered by counterexample suggesting false? Yes. This is the right label.

Recommended next pipeline step

Send this to counterexample hunter / consolidator, not prover. The target should be a crisp negative lemma:

Under a rowwise-separable adversary objective, if D(s)=∅ on a positive-τ set and the row value is finite, no Borel kernel β
∗
 attains the infimum.

Then attach the already-indicated compact row example g(m)=m on (0,1], g(0)=1, and, if needed, a full Robust Trust primitive realization. The theorem statement should keep (A8c-attain), or replace Tier 1 by an approximate-adversary statement. Exact β
∗
 without rowwise contact is a locked door, not a missing key.
